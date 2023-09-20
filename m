Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1207A80E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjITMkq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjITMkp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 08:40:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07683
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 05:40:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-530ea522f5eso4376355a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695213637; x=1695818437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=siMb1j/2ui4QtBBCTUzAmiO4Q/tO1NXELA6kziDpDac=;
        b=SsS342ZtRpBhTU6smlP0nYWGc/44R7Qvcv3TzpTUIFWvw5l2P1reZBoW5YGao/SNgI
         LO3XbOR2y+twjRso3E0Y5bNIHzBl6Kpq5XczAEPDIlimwCuOdPNwqmwFgIomyhdgmHim
         b1v0SD0tghBR1dgBJBP4biUokKxskNPPQ4flVSwOYjVyUGeUl+QcmdusdX4PABOBPdZh
         IB2eXJMhaQDp2NH43eEyR4cH2K4CwDSHx+F7SElJS0bKelkivQ98BdDzt3a22vqdFxe0
         J476w4vDDb5YsNBCVzeVuUHS/JrvHIR//Yf4o/xZcoSSXomG71hE6Kz+jfaCWVboftt1
         WVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213637; x=1695818437;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siMb1j/2ui4QtBBCTUzAmiO4Q/tO1NXELA6kziDpDac=;
        b=U/cSA/Ewpe418AEebZ+ONjDH7F+OeQq6mPM+ifGJb/bJG8uKCh5D/43GmPEOwEDDNo
         NsC1zZ65ZwoWn/93Y2XvlVh/GBFMH944571IWoDtpfSzBqYRoI5yZFJRlFo+HH0JO9N3
         Wbrx4q0QmlNb3zMPYNMg0R8oqYCYpikj/tJ11jspqhL/hqnG7SQq0NBKmFtgh4ZHC9nB
         Z7Rfydo64TwCcHY5thjfJgNWSahMMMuM/AbJxkzC/p7bGvwRMLADi7wmTG98HKkHUsxj
         lW3wBY65h+jwAUiegejScCBTKy10SDpkWCAhvOLW42U3BeImUbyvAqF3oHO2FLewJ/jy
         Gsmg==
X-Gm-Message-State: AOJu0Yz5ZU/mMnP0aLUkUSmQuIt2CHbJ7EOGvT4ywn9njMnti+1GV5UA
        fqy12jd9RnF9P4FVY5Cs+bFJZTtOGjqB8pKfOHVV7Q==
X-Google-Smtp-Source: AGHT+IFJLGYt97ceCa1zxstXLFOdTK8xonUjuIs1RQdUe7jEz92yZb6b8+8I1ELjdpmdMXutyNKR5TceTpD+ln0DnUo=
X-Received: by 2002:aa7:c54f:0:b0:530:ccf7:37af with SMTP id
 s15-20020aa7c54f000000b00530ccf737afmr2050462edr.12.1695213637092; Wed, 20
 Sep 2023 05:40:37 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Sep 2023 14:40:24 +0200
Message-ID: <CA+G9fYtio=EY-fitOJZgAWsgVHX8XhgdNQnfMoUBVFrnSP5TZg@mail.gmail.com>
Subject: selftests: user_events: ftrace_test: Internal error: Oops: 0000000096000021
To:     lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following selftests: user_events: ftrace_test running on arm64 Juno-r2
Linux next-20230919.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in user_events
TAP version 13
1..4
# timeout set to 90
# selftests: user_events: ftrace_test
[ 1138.755735] Unable to handle kernel paging request at virtual
address ffff00082fc89ed4
[ 1138.763768] Mem abort info:
[ 1138.766692]   ESR = 0x0000000096000021
[ 1138.770495]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1138.775879]   SET = 0, FnV = 0
[ 1138.779018]   EA = 0, S1PTW = 0
[ 1138.782264]   FSC = 0x21: alignment fault
[ 1138.786399] Data abort info:
[ 1138.789356]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[ 1138.794969]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1138.800095]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1138.805436] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000008265b000
[ 1138.812175] [ffff00082fc89ed4] pgd=18000009ffdf8003,
p4d=18000009ffdf8003, pud=18000009ffa0e003, pmd=18000009ff88f003,
pte=00680008afc89707
[ 1138.824824] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
# TAP[ 1138.831117] Modules linked in: tda998x hdlcd onboard_usb_hub
crct10dif_ce cec drm_dma_helper drm_kms_helper drm fuse backlight
dm_mod ip_tables x_tables
[ 1138.845227] CPU: 1 PID: 4752 Comm: ftrace_test Not tainted
6.6.0-rc2-next-20230919 #1
v[e r1s1i3o8n. 81533080] Hardware name: ARM Juno development board (r2) (DT)

# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           user.register_events ...
[ 1138.868317] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1138.875291] pc : user_event_enabler_write
(arch/arm64/include/asm/atomic_ll_sc.h:210 (discriminator 2)
arch/arm64/include/asm/atomic.h:64 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:3656 (discriminator 2)
include/linux/atomic/atomic-long.h:964 (discriminator 2)
include/asm-generic/bitops/atomic.h:25 (discriminator 2)
include/asm-generic/bitops/instrumented-atomic.h:42 (discriminator 2)
kernel/trace/trace_events_user.c:520 (discriminator 2))
[ 1138.880362] lr : user_event_enabler_write
(kernel/trace/trace_events_user.c:503 (discriminator 1))
[ 1138.885337] sp : ffff80008a593b70
[ 1138.888656] x29: ffff80008a593b70 x28: ffff000800908040 x27: ffff00082767ac40
[ 1138.895817] x26: 0000000000000000 x25: ffff000827732600 x24: 0000ffffc2a46ca0
[ 1138.902972] x23: 0000000000000000 x22: ffff000822773a00 x21: 0000000000000ed4
[ 1138.910128] x20: ffff80008a593c40 x19: ffff00082767ac40 x18: 0000000000000000
[ 1138.917283] x17: ffff8000816f1aa0 x16: ffff80008002ce90 x15: ffff800081cea0b8
[ 1138.924439] x14: ffffffffffffffff x13: 0000ffffadc52000 x12: 1fffe001048d5b21
[ 1138.931597] x11: ffff0008246ad900 x10: ffff0008246ad908 x9 : ffff80008003bc40
[ 1138.938752] x8 : ffff80008a5937d8 x7 : 0000000000000000 x6 : 0000000000000001
[ 1138.945905] x5 : 0000000000000001 x4 : fffffc0020bf2240 x3 : 000000000000001f
[ 1138.953058] x2 : 0000000000000000 x1 : 0000000080000000 x0 : ffff00082fc89ed4
[ 1138.960212] Call trace:
[ 1138.962656] user_event_enabler_write
(arch/arm64/include/asm/atomic_ll_sc.h:210 (discriminator 2)
arch/arm64/include/asm/atomic.h:64 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:3656 (discriminator 2)
include/linux/atomic/atomic-long.h:964 (discriminator 2)
include/asm-generic/bitops/atomic.h:25 (discriminator 2)
include/asm-generic/bitops/instrumented-atomic.h:42 (discriminator 2)
kernel/trace/trace_events_user.c:520 (discriminator 2))
[ 1138.967372] user_events_ioctl (kernel/trace/trace_events_user.c:858
kernel/trace/trace_events_user.c:2314
kernel/trace/trace_events_user.c:2475)
[ 1138.971477] __arm64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:871
fs/ioctl.c:857 fs/ioctl.c:857)
[ 1138.975497] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:56)
[ 1138.979255] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:144 (discriminator 2))
[ 1138.984056] do_el0_svc (arch/arm64/kernel/syscall.c:156)
[ 1138.987377] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
[ 1138.990439] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
[ 1138.994805] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[ 1138.998474] Code: 14000009 f821301f 17ffffed f9800011 (c85f7c02)
All code
========
   0:* 09 00                or     %eax,(%rax) <-- trapping instruction
   2: 00 14 1f              add    %dl,(%rdi,%rbx,1)
   5: 30 21                xor    %ah,(%rcx)
   7: f8                    clc
   8: ed                    in     (%dx),%eax
   9: ff                    (bad)
   a: ff 17                callq  *(%rdi)
   c: 11 00                adc    %eax,(%rax)
   e: 80 f9 02              cmp    $0x2,%cl
  11: 7c 5f                jl     0x72
  13: c8                    .byte 0xc8

Code starting with the faulting instruction
===========================================
   0: 02 7c 5f c8          add    -0x38(%rdi,%rbx,2),%bh
[ 1139.004575] ---[ end trace 0000000000000000 ]---
# # register_events: Test terminated by timeout
# #          FAIL  user.register_events
# not ok 1 user.register_events
# #  RUN           user.write_events ...
# # write_events: Test terminated by timeout
# #          FAIL  user.write_events
# not ok 2 user.write_events
# #  RUN           user.write_empty_events ...


Log:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20073395/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20073395/suite/log-parser-test/test/check-kernel-oops/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VbYWmjbGM16bFDtcoFx62Kdds2/


--
Linaro LKFT
https://lkft.linaro.org
