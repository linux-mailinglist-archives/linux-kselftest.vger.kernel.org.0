Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50D1E4C65
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgE0Rvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388724AbgE0Rvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 13:51:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E70C03E97D
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 10:51:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c11so27869694ljn.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yz1OFVtKUg5e0Gh5JS6gGVn6q7BEXtsG6klU5YEyoTQ=;
        b=vMec02LhOQkAgOnTprMH1UTqxNgSiFlWm4pStE88P3nzVsnVgptVgiCFXvOcRLRdRC
         0c+R+0RoUeYFanulKc/Cpe3BuFVog5SVHpYLuUYsASc6Zfc2qsfKa+1g7zv0/Wr077oH
         +8tSR3i5pihnAFLfZOEAE9ZPw/o/mJvxt0AHzPa/fStrjmdzvpGXiIqH5/m0EL3XQzdu
         /36txsLWTB3/0kX6VI4tLfgOBE37KQMN9o89cOrpe/mBN4BDXl91g4Z8POR3F6feni9Y
         M42k5aCCIBIC5Wg2RdfJKT1YdU57IwMZMWx+poTHvWLGEMMNJQjHrZm+rKEA/w1v3vVj
         zPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yz1OFVtKUg5e0Gh5JS6gGVn6q7BEXtsG6klU5YEyoTQ=;
        b=pg3GlDFEkGU57wz0JB4CDNA7BK2POH4CKxQ8MTUPqN1C7RN+kN/n5blEyitp9nji+Z
         M1eGAb0Xj2kLHPrSvhcjj+KTpWlRze+ewI4gn4rzMWbkOcbqDPd1qlyPZAqAr7eIMfVd
         D6ac8kdnaL/BCMYNA3Hv9LGt044+Bb2mPPQGXKWLfRYWFf6+T+UepyHUEj3eD2IGzeOr
         pj/OWWlDm7xe05R5rUCvJxaSqqizPEB6nVg00LhKZuQ9A4xYahFokvqLeSOAQFv1FyBk
         F4p4H4sqZDMFBGgGDcthEu189AUI0QXIfmDX2jZCJclZ1jNCuWPvpd1RDmiyKeWmfx46
         bMew==
X-Gm-Message-State: AOAM533fz3m6aWKzt0oav55csK1MWqP3maiPfiOUhpwy0sOZyYRUnRSI
        QlE7xjBCHasIdCBg/UaDdS0UWYMs79BPCbuBsJnT6w==
X-Google-Smtp-Source: ABdhPJyKmRM8mieKJ5Y/3GVFXkHHiPY82ctnKLzzvbcP1OGLyNmqRsDEQBuVAH5qsL/q/tGr9E0PSX1ZpQY0C8SKtLs=
X-Received: by 2002:a2e:9684:: with SMTP id q4mr3618805lji.431.1590601889878;
 Wed, 27 May 2020 10:51:29 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 23:21:18 +0530
Message-ID: <CA+G9fYs6pMmR9jA5xJPk+vaAcRsH2OVNtm6UdY-wDb=Wnw0GBg@mail.gmail.com>
Subject: selftests: cgroup: config fragments required
To:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftest cgroup tests are getting skipped due to missing kernel config
fragments.
Please create the required config fragments "config" file.

Our CI system merges these kernel config fragments and builds the kernel
 for testing. You may refer config files in other test directories.

Test output log,
# selftests cgroup test_memcontrol
cgroup: test_memcontrol_ #
[SKIP] not ok 1 # SKIP memory controller isn't available
ok: 1_# [SKIP]
[SKIP] 1 selftests cgroup test_memcontrol # SKIP
selftests: cgroup_test_memcontrol [SKIP]
# selftests cgroup test_core
cgroup: test_core_ #
[SKIP] not ok 1 # SKIP Failed to set memory controller
ok: 1_# [SKIP]
[SKIP] 2 selftests cgroup test_core # SKIP
selftests: cgroup_test_core [SKIP]
# selftests cgroup test_freezer
cgroup: test_freezer_ #
# ok 1 test_cgfreezer_simple
1: test_cgfreezer_simple_ #
# ok 2 test_cgfreezer_tree
2: test_cgfreezer_tree_ #
# ok 3 test_cgfreezer_forkbomb
3: test_cgfreezer_forkbomb_ #
# ok 4 test_cgfreezer_mkdir
4: test_cgfreezer_mkdir_ #
# ok 5 test_cgfreezer_rmdir
5: test_cgfreezer_rmdir_ #
# ok 6 test_cgfreezer_migrate
6: test_cgfreezer_migrate_ #
# Cgroup /sys/fs/cgroup/unified/cg_test_ptrace isn't frozen
/sys/fs/cgroup/unified/cg_test_ptrace: isn't_frozen #
# not ok 7 test_cgfreezer_ptrace
ok: 7_test_cgfreezer_ptrace #
# ok 8 test_cgfreezer_stopped
8: test_cgfreezer_stopped_ #
# ok 9 test_cgfreezer_ptraced
9: test_cgfreezer_ptraced_ #
# ok 10 test_cgfreezer_vfork
10: test_cgfreezer_vfork_ #
[FAIL] 3 selftests cgroup test_freezer # exit=1
selftests: cgroup_test_freezer [FAIL]
# selftests cgroup test_stress.sh
cgroup: test_stress.sh_ #
# ./with_stress.sh line 34 echo write error No such file or directory
line: 34_echo #
# Skipping cannot enable cpuset in /sys/fs/cgroup/unified
cannot: enable_cpuset #
[SKIP] 4 selftests cgroup test_stress.sh # SKIP
selftests: cgroup_test_stress.sh [SKIP]

You may create config file like this,
CONFIG_CGROUPS=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y


-- 
Linaro LKFT
https://lkft.linaro.org
