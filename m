Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91987727EA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjFHLWE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFHLWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 07:22:03 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893D1FF3;
        Thu,  8 Jun 2023 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=HCCNTmzmcrLed5PCeHmXazM06d4SBCeRlB+khMYifVc=; b=F/UQ+8+1KoKAfFsg7r/qJXxlsn
        V0hj72RKbeNkOew3exhJuK9bmYoNVek8k/VSUmEwQjpAFePVRwsjFQfnzgvqDRGIJrVBOjXJBwT39
        LVJa98e12CXAPJoQnHjXw1bsWHRZWl4R+bwo2JxDI5An1nq/c7eWGsvNFz20uB+2YM3mNMGS+DsRq
        n6f/535zfVkma4gqE/2c1uA89w2djddQ5E045uH71frA7fkNpZ3kJPjExRXbYfiu/G0LeAp42gEWF
        jfPCqcFE+YNFu0ydP5xvSWbYrk0d0zI7lywVxjhBahVsA/6VmzvoJfqV6zx0vsY8WgLHgJ9LCg/4w
        pT9THivQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1q7DiI-0009Yt-Jt; Thu, 08 Jun 2023 13:21:58 +0200
Received: from [178.197.248.31] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1q7DiH-0000aI-T4; Thu, 08 Jun 2023 13:21:57 +0200
Subject: Re: [PATCH bpf v4 0/2] Fix verifier id tracking of scalars on spill
To:     Maxim Mikityanskiy <maxtram95@gmail.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Maxim Mikityanskiy <maxim@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230607123951.558971-1-maxtram95@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <404e95a2-34fb-3cd2-6fc4-817fd6b8c038@iogearbox.net>
Date:   Thu, 8 Jun 2023 13:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230607123951.558971-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26933/Thu Jun  8 09:26:06 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/7/23 2:39 PM, Maxim Mikityanskiy wrote:
[...]
> v4 changes:
> 
> Dropped supposedly redundant tests, kept the ones that result in
> different verifier verdicts. Dropped the variable that is not yet
> useful in this patch. Rephrased the commit message with Daniel's
> suggestions.

Andrii mentioned he did some veristat measurements and they looked good
to him. Looks like patchbot didn't reply, I've pushed it to bpf, thanks!
