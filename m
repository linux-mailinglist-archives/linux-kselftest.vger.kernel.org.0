Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082AB758904
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 01:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGRXVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGRXVl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 19:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65CED;
        Tue, 18 Jul 2023 16:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EE6612F1;
        Tue, 18 Jul 2023 23:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C452BC433C7;
        Tue, 18 Jul 2023 23:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689722499;
        bh=HEoYxr1Q0eWhCNbZroe0oS5/iqjnBEypxbEtpRyC30M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NAmWFf48pDjTN0vrH0Bh7fepD3FgNjpV1rFfrKYuuo3rh7rJlLlrqL5YMbW7+PPxY
         AvJAPRnvHR5uQGuP3U5CIFgcc6tC3IfE2V0EvKqPBU0rOoT8k6oD716Vy1b/NB2v9I
         nzMyzLqLv8d1eboalUc0lQGeYWUO0e+jdRvsF0wNbGSVlwh/6w/6QGniLUTPT9hqgO
         O811FVTe7oLRUvOBXllvcT7gmqCP54bmMAJVMHp4F1jq+svwlkzny1Xb5xzEGLdrHt
         l5JuV5pvFrcFGslsE58y6E8sR5MzZiYkLx76CHbbCQGwuUAoNyWebzD5kuoq3LRWX0
         eXyE36/DOay1Q==
Date:   Tue, 18 Jul 2023 16:21:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718162138.24329391@kernel.org>
In-Reply-To: <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
        <20230718082615.08448806@kernel.org>
        <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
        <20230718090632.4590bae3@kernel.org>
        <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
        <20230718101841.146efae0@kernel.org>
        <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
        <20230718111101.57b1d411@kernel.org>
        <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
        <20230718160612.71f09752@kernel.org>
        <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
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

On Tue, 18 Jul 2023 16:17:24 -0700 Alexei Starovoitov wrote:
> Which would encourage bnxt-like hacks.
> I don't like it tbh.
> At least skb_pointer_if_linear() has a clear meaning.
> It's more run-time overhead, since buffer__opt is checked early,
> but that's ok.

Alright, your version fine by me, too. Thanks!
