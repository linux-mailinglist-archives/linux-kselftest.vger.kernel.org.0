Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18367E4203
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 15:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjKGOpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 09:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjKGOpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 09:45:15 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E6B11B
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 06:45:11 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45f3b583ce9so1294424137.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699368311; x=1699973111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wyN2qeNAfzq8T3+c7zpkeHbe0JGvUl4QQakn3ilisA8=;
        b=WO2FruOS+35EeokZGi3+p8AOKgGFYvA2aODoy4OuFhgECOK9oG6fBf53WnxJ+D9cns
         qzQ+igZhuW3ExWxZSZ4TlDOB1yBGfXiL5ibaaqAs8F4DO+npv1wXHxC8rSxjmUknBCXw
         m0az9UntG32K2E765UHwXhMBjmlsCwTK0ZljmclPMyF+f9ul1Y/iaVlcCvVvWG7OA6jo
         v/2iCC8RmSIOFa4YII5iLGcA+FBZglhFCruksYCCVTWOyfVIKsutuXke0f+4fE2YIstS
         exYlEe+3VSd8UaxGST7PP42p+JfdWvrzUrl+ZXv6FBCLCs6JOLgqhfE1oBp9tZG+AarI
         purg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368311; x=1699973111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyN2qeNAfzq8T3+c7zpkeHbe0JGvUl4QQakn3ilisA8=;
        b=N2abZ66S74sqEnECDJx3/8ttR10utIVr8vcQnANrDRHW9A2S+q8DAxax2oxsgdCQdY
         WYrc9n7B8aMVJ36yQsQr1qrADQXboVghm2rhaOJSMZt39AFt2QYqdTze1dq84X8ckK8R
         pqrcZYwPy5uykdkxCCK9V9Lf5l0D5/eXE07/pfv13bONkYrTP6299BwuNjzA3/rKTI0i
         dBRHXTrwoLgsbtF9gNfdFahHxw1ixq/8Wtgw+NAsSPcsLmWTa5FnA5LSp8J8O6jqNlME
         OQzo3Bqip8n2qHdqoBsIpLaXfUprKtmy/6ZwUakhFTy4z9+5WzL5gwcrppHntyPXgQg9
         hHeQ==
X-Gm-Message-State: AOJu0YwjgFr71VA07G+BoBS4FHSZexOAJ/nJOU+XYmDEL9QKRQneh2mg
        UsipHsRNhmcimNRJ3tWSQ1W7ITe2jRDfTVd1xxuHzic3DSrMEYDUAQo=
X-Google-Smtp-Source: AGHT+IFEKYNQ1IZRyacc+TbJB29Eep3DcxhfqJjpGlrvXPJYZx9aeEnU8QXk3++wPel+Ov/4o7VWGAN3Q3SDq1/ZiFI=
X-Received: by 2002:a05:6102:2d01:b0:457:c953:bc39 with SMTP id
 ih1-20020a0561022d0100b00457c953bc39mr1586305vsb.1.1699368310737; Tue, 07 Nov
 2023 06:45:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsrLTbFkz-LJmAY9efDyEr-8bHcxivBDPToPjBxjStoDg@mail.gmail.com>
 <ZUpH0FNTYAl9Z+L6@finisterre.sirena.org.uk>
In-Reply-To: <ZUpH0FNTYAl9Z+L6@finisterre.sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 20:14:59 +0530
Message-ID: <CA+G9fYta5cUpFArGfON3R+HUGxJRyEsc9zdTwwk5Un+wHqLN8g@mail.gmail.com>
Subject: Re: selftests: arm64: fp-stress: Unable to handle kernel paging
 request at virtual address
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Nov 2023 at 19:51, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 07, 2023 at 06:43:25PM +0530, Naresh Kamboju wrote:
>
> > # # SVE-VL-64-0: Expected
> > [3904000039044000390480003904c0003904000139044001390480013904c0013904000239044002390480023904c0023904000339044003390480033904c003]
> > <>
>
> You've elided *lots* of error reports from the actual test which suggest
> that there is substantial memory corruption, it looks like tearing part
> way through loading or saving the values - the start of the vectors
> looks fine but at some point they get what looks like a related process'
> data, eg:
>
> # # SVE-VL-64-0:        Expected [3904000039044000390480003904c0003904000139044001390480013904c0013904000239044002390480023904c0023904000339044003390480033904c003]
> # # SVE-VL-64-0:        Got      [3904000039044000390480003904c000390480003904c00039040001390440013904000139044001390480013904c001390480013904c0013904000239044002]
>
> This only appears to affect SVE and SME, I didn't spot any FPSIMD
> corruption but then that is the smallest case (and I didn't notice any
> VL 16 cases either).  It looks like the corruption is on the first thing
> we check each time (either register 0 or the highest ZA.H vector for
> ZA), all the values do look lke they were plausibly generated by
> fp-stress test programs.
>
> Then we get what looks like memory corruption:
>
> > # # SVE-VL-256-<1>[   88.160313] Unable to handle kernel paging
> > request at virtual address 00550f0344550f02
>
> > <4>[   88.195706] Call trace:
> > <4>[ 88.196098] percpu_ref_get_many
> > (include/linux/percpu-refcount.h:174 (discriminator 2)
> > include/linux/percpu-refcount.h:204 (discriminator 2))
> > <4>[ 88.196815] refill_obj_stock (mm/memcontrol.c:3339 (discriminator 2))
> > <4>[ 88.197367] obj_cgroup_uncharge (mm/memcontrol.c:3406)
> > <4>[ 88.197835] kmem_cache_free (include/linux/mm.h:1630
> > include/linux/mm.h:1849 include/linux/mm.h:1859 mm/slab.h:208
> > mm/slab.h:572 mm/slub.c:3804 mm/slub.c:3831)
> > <4>[ 88.198407] put_pid.part.0 (kernel/pid.c:118)
> > <4>[ 88.198870] delayed_put_pid (kernel/pid.c:127)
> > <4>[ 88.200527] rcu_core (arch/arm64/include/asm/preempt.h:13
> > (discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1)
> > kernel/rcu/tree.c:2403 (discriminator 1))
>
> This all seems very surprising, especially given that AFAICT there are
> no changes in stable-6.6-rc for arch/arm64.

We do not see on the mainline and next.
Is this reported problems on stable-rc 6.6 and 6.5 are due to running
latest kselftest on older kernels ?

--
# # SSVE-VL-32-1: Mismatch: PID=641, iteration=0, reg=0
# # SSVE-VL-128-1: Got         [<junk>]
# # SSVE-VL-256-1: Got       [<junk>]

Unable to handle kernel paging request at virtual address 00740f0322740f02
0<1>[   89.400173] Mem abort info:
<1>[   89.400844]   ESR = 0x0000000096000004
<1>[   89.401974]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   89.403399]   SET = 0, FnV = 0
<1>[   89.404421]   EA = 0, S1PTW = 0
<1>[   89.405317]   FSC = 0x04: level 0 translation fault
<1>[   89.406545] Data abort info:
<1>[   89.407493]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[   89.408785]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   89.410001]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   89.411485] [00740f0322740f02] address between user and kernel
address ranges
<0>[   89.413851] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[   89.415573] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm dm_mod ip_tables x_tables
<4>[   89.419561] CPU: 1 PID: 22 Comm: ksoftirqd/1 Not tainted 6.5.11-rc1 #1
<4>[   89.420795] Hardware name: linux,dummy-virt (DT)
<4>[   89.422676] pstate: 624000c9 (nZCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[   89.424344] pc : refill_obj_stock+0x6c/0x250
<4>[   89.426324] lr : refill_obj_stock+0x6c/0x250
<trim>
<4>[   89.447170] Call trace:
<4>[   89.447756]  refill_obj_stock+0x6c/0x250
<4>[   89.449033]  obj_cgroup_uncharge+0x20/0x38
<4>[   89.450457]  kmem_cache_free+0xf8/0x500
<4>[   89.451066]  delayed_put_pid+0x50/0xb0
<4>[   89.452401]  rcu_core+0x3cc/0x950
<4>[   89.453369]  rcu_core_si+0x1c/0x30
<4>[   89.454465]  __do_softirq+0x118/0x438
<4>[   89.455738]  run_ksoftirqd+0x40/0xf8
<4>[   89.456893]  smpboot_thread_fn+0x1d0/0x248
<4>[   89.457969]  kthread+0xfc/0x1a0
<4>[   89.459171]  ret_from_fork+0x10/0x20
<0>[   89.460445] Code: aa1603e0 97fffef8 aa0003f4 97f6cbf6 (f9400269)
<4>[   89.462028] ---[ end trace 0000000000000000 ]---
<0>[   89.463494] Kernel panic - not syncing: Oops: Fatal exception in interrupt
<2>[   89.465046] SMP: stopping secondary CPUs
<0>[   89.466327] Kernel Offset: 0x2dabffa00000 from 0xffff800080000000
<0>[   89.467385] PHYS_OFFSET: 0x40000000
<0>[   89.468131] CPU features: 0x00000000,68f167a1,cce6773f
<0>[   89.469850] Memory Limit: none
<0>[   89.470836] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---



Links:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.10-89-g73d52afec3ab/testrun/20963504/suite/log-parser-test/tests/
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.10-89-g73d52afec3ab/testrun/20963709/suite/log-parser-test/tests/
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.10-89-g73d52afec3ab/testrun/20963709/suite/log-parser-test/test/check-kernel-oops/log

- Naresh
