Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8318B62F347
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiKRLIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 06:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiKRLIO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 06:08:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178F98243;
        Fri, 18 Nov 2022 03:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6783262445;
        Fri, 18 Nov 2022 11:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97123C433C1;
        Fri, 18 Nov 2022 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668769692;
        bh=a7U9Td57moV6dIsrSQNM+u0ybC2RzlpWe+s9uXaiWpY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eHc8HEcwNzAT221n92/PtkwnIgsRBYxmhZ4OdueqydLXGaNyL5dRh0EAakmCaM2Bm
         w1/zhcJ/5sVlBcjwnFFhzSOOB7TjgiW1QystlvJMjaS18MFOYymtTqRtonb3N0vZHP
         Y6YU8zDqdBpuOJWX9hehdcMF/TuC6FIxRlqioFx13DWv5e0xKo1a2sh+hAa69Qa+qh
         gyhC7vOsUCuNYHt8fDFlDpKtDZslk+UGEhfil2K5zrI46cwEyZIeID3X6AdMewP+Nq
         Y1ie/swCopE0FaUJao64SLxwqlw0X4/5PQ5Al6eri5Cje+UdLa27tGeEo4qQfbKsEo
         aXRchAM2qjI8g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CC1AE7A71D0; Fri, 18 Nov 2022 12:08:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>, andrii.nakryiko@gmail.com,
        sdf@google.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dxu@dxuuu.xyz, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkp@intel.com, lorenzo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix error: undeclared
 identifier 'NF_NAT_MANIP_SRC'
In-Reply-To: <tencent_4C0B445E0305A18FACA04B4A959B57835107@qq.com>
References: <CAEf4BzZE5=OOp6OesB=P8PE=Ps62fkecDSZ9MzwHCD68=+oN0g@mail.gmail.com>
 <tencent_4C0B445E0305A18FACA04B4A959B57835107@qq.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Nov 2022 12:08:09 +0100
Message-ID: <87mt8oy0yu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rong Tao <rtoax@foxmail.com> writes:

> From: Rong Tao <rongtao@cestc.cn>
>
> commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c.
>
> In bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> is compiled as built-in, this issue occurs just if it is compiled as
> module. we just hardcode 1/0 here.
>
> How to reproduce the error:
>
>    $ make -C tools/testing/selftests/bpf/
>    ...
>       CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>       error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>             bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                          ^
>       error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>             bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                          ^
>    2 errors generated.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

This will fix the compilation, but the selftest won't actually work when
nf_nat is compiled as a module (see [0]). Would be better to fix the
test properly instead of just papering over the compilation issue like
this. That requires a bit more surgery to the selftests, though...

-Toke

[0] https://lore.kernel.org/r/87leoh372s.fsf@toke.dk
