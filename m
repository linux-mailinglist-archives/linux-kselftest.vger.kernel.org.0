Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6A1A1B9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDHFvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 01:51:35 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41667 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDHFve (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 01:51:34 -0400
Received: by mail-lj1-f174.google.com with SMTP id n17so6250084lji.8
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2HvyJt2Voil1Is0cWHCS2tCfsI8zoyI3d/s0aIHNA8Y=;
        b=jbh0OW5birWM91SV+r9ilildAesnKOH2I0Lc3CadJxVWjfMbNkSW4baxJQlPEF8kW3
         HHgUkW/ga4JY69VbT2bP3QOrRNSvDBbyg6uSwaWFGU85HCaZTnqxECn8CCsuqSWi4DOB
         B66Zk5Zx7g6WmfoDic6hSEqQi6XRs1Sj4GPt9Xcr3HmJI0yAnKbh9zAmcvslBI5gV902
         bglUOu24cRT/Z6andcyfUbFL3yszpfV1VyjAxhy4pqW+BU/aJ4nTk6G4TpG/IJQlHC0g
         6O4iOHgrnR61c1/zK3eBg+b23fSDmWlxCDNppvwMgFnJsN9iD+gkb/E2pVRJhmKM58Jd
         QXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2HvyJt2Voil1Is0cWHCS2tCfsI8zoyI3d/s0aIHNA8Y=;
        b=GNEv1sXHjtz+Kk5kvIPdvdAZvrqgUguspbVkz9eVYuJ3aM6s53SJOQiLEhoPrCyke6
         cR/CyBMcEO5QrNk3g2dTjQt4vGIRLoiXGBEGGDrqUeFoL7vlCxSilVXj+hTjcidGhaeJ
         Xr6C1YnYR3dkfBRRgrhivCm+MJRpGIVtH0Ip2phm00H61llGacwEQO4Lb0stgtxU5IbF
         fUWKrXk7bO3Xk7660nUTn9R6gYpflk0QMT8DUqE7s4eMkfMUCrCHTwOND+93fFZYfq2j
         GNLrUdYLweCGA+wE00l5vdsSLJsvz4/PF/Zpqi9pLC1hv6jsqTt7lapX5jN6rpKlv6x0
         +cKA==
X-Gm-Message-State: AGi0PubdYXjZLMMyqw1B1WzW07s9MLnfpRLLyEOCU9lL9ITaFGd+PycJ
        XagHADW1S6/W3j006Syn2NXY4Tr8MghVlgxSMdt/g5FZ
X-Google-Smtp-Source: APiQypJL2/N1qnzB5lQjtkqwfji5NK3vlOf3tIhEfovIP2dqPOlrnPyNS5dQ9r9E656nhkiZmmaIWejh0DZc2wkUjM8=
X-Received: by 2002:a2e:6e0f:: with SMTP id j15mr3592366ljc.230.1586325088674;
 Tue, 07 Apr 2020 22:51:28 -0700 (PDT)
MIME-Version: 1.0
From:   Deepa B <deepa01012015@gmail.com>
Date:   Wed, 8 Apr 2020 11:21:17 +0530
Message-ID: <CANmdEh3Ukq6+WbdN49B0uPZqC0Cm=jve=cL9vFv1YYaXHqL63Q@mail.gmail.com>
Subject: kselftest build error: ../lib.mk: No such file or directory
To:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,
I'm running kselftest on Ubuntu 16.04lts.
Details:
deepa@deepa-Inspiron-3576:/usr/src/linux-headers-4.15.0-88/Documentation$
uname -a
Linux deepa-Inspiron-3576 4.15.0-91-generic #92~16.04.1-Ubuntu SMP Fri
Feb 28 14:57:22 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

Command:
deepa@deepa-Inspiron-3576:/usr/src/linux-headers-4.15.0-91-generic$
make -C tools/testing/selftests

Error:
make: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/android'
Makefile:7: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/android'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/bpf'
Makefile:25: ../lib.mk: No such file or directory
/bin/sh: 1: llc: not found
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/bpf'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/breakpoints'
Makefile:15: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/breakpoints'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/capabilities'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/capabilities'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/cpufreq'
Makefile:7: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/cpufreq'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/cpu-hotplug'
Makefile:6: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/cpu-hotplug'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/efivarfs'
Makefile:6: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/efivarfs'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/exec'
Makefile:11: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/exec'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/filesystems'
Makefile:7: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/filesystems'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/firmware'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/firmware'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ftrace'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ftrace'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/futex'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/futex'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/gpio'
Makefile:13: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/gpio'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/intel_pstate'
Makefile:11: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/intel_pstate'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ipc'
Makefile:17: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ipc'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/kcmp'
Makefile:7: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/kcmp'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/lib'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/lib'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/membarrier'
Makefile:5: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/membarrier'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/memfd'
Makefile:13: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/memfd'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/memory-hotplug'
Makefile:4: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/memory-hotplug'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/mount'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/mount'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/mqueue'
Makefile:6: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/mqueue'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/net'
Makefile:14: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/net'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/netfilter'
Makefile:6: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/netfilter'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/nsfs'
Makefile:5: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/nsfs'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/powerpc'
Makefile:40: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/powerpc'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/pstore'
Makefile:11: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/pstore'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ptrace'
Makefile:5: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/ptrace'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/seccomp'
Makefile:4: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/seccomp'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sigaltstack'
Makefile:4: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sigaltstack'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/size'
Makefile:5: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/size'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/splice'
Makefile:5: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/splice'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/static_keys'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/static_keys'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sync'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sync'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sysctl'
Makefile:9: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/sysctl'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/timers'
Makefile:17: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/timers'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/user'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/user'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/vm'
Makefile:28: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/vm'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/x86'
Makefile:4: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/x86'
make[1]: Entering directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/zram'
Makefile:8: ../lib.mk: No such file or directory
make[1]: *** No rule to make target '../lib.mk'.  Stop.
make[1]: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/zram'
Makefile:73: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory
'/usr/src/linux-headers-4.15.0-91/tools/testing/selftests'


Can you please help us fix?
Is there an archive available for linux-kselftest? We could check it
once before posting it to this group.Just to avoid duplicates.

Thanks,
Deepa
