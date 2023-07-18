Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA257580D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGRP0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGRP0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB2A1;
        Tue, 18 Jul 2023 08:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4886C61634;
        Tue, 18 Jul 2023 15:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D625C433C7;
        Tue, 18 Jul 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689693979;
        bh=+TJ92Gupq0pfZnkJvIFO8Zsm9FylALOLZj8QN/yUCyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PxXZhcH7MKY+vV3z5wfPbRR/veeKx6Ls5TW4S882XnV9tbZTqlD8d64+yDPZQ7qEk
         KEOypCkz7mEya1nKgOp6t82p8ZnW4S29X4otsZHFo4TSllqoTQE5kzcfU3FBVzq5nz
         qVglZcZcJHhr+BveM4TDuGRvmlPcTFUQ5Z+iRRj3IydKhaSGR17Yoydnm8tI8lqj6m
         DtLQy+uq/Oqq9m1Ur3FEHWSSFe27pONGg8YwwCg3ltQl0kgKoCpWqaSpe2IChtPMZ0
         f9MY8RQbsr4K6/x2J1n4KdVBosBsa4MMeDbku9P7ykOHMnSttZCs1fALRBzh1iIjMp
         HiNjZ0mmJgoIQ==
Date:   Tue, 18 Jul 2023 08:26:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718082615.08448806@kernel.org>
In-Reply-To: <20230502005218.3627530-1-drosen@google.com>
References: <20230502005218.3627530-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote:
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
>  	if (likely(hlen - offset >= len))
>  		return (void *)data + offset;
>  
> -	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
> +	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
>  		return NULL;

First off - please make sure you CC netdev on changes to networking!

Please do not add stupid error checks to core code for BPF safety.
Wrap the call if you can't guarantee that value is sane, this is
a very bad precedent.
