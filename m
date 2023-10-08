Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3B7BCC7C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJHGBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 02:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbjJHGBI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 02:01:08 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F635C5
        for <linux-kselftest@vger.kernel.org>; Sat,  7 Oct 2023 23:01:05 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b07548b084so1124076241.1
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Oct 2023 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696744864; x=1697349664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTFi6T6hp86aembs7r35hWj2AG1dkdBFbTPFt+6s00M=;
        b=opm5j0n5ms+cUvmzyj2hTkOZ20We3f1ZL3RFv6XDLZMHHUjbaPiU3Sk6u6ndC3xK7c
         06nWWiqBFCgkWorTmRJaSu9BQanUL7AGoGSP6q6CRLQvfeS6zBCXi0azVLndnqtS3faV
         Oa+CRMiAB64zT4gXNpj/lwFCOitgm84x3KNuXKklvRZuFGDafN75F5wPGDY8++aN7aRS
         J4b5NG1hGlQldfIYz08g947jNmerlIaUZK2WMtR2s11WdbUPNFL7jRgEjPLW9MkYfkEs
         f4xBUhyA9AgpV2TQOI0l9f73cl/e5sIM5WatqJ+4xG6x8GTkVeB9+lKE+WEj4MSjm/oq
         v8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696744864; x=1697349664;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTFi6T6hp86aembs7r35hWj2AG1dkdBFbTPFt+6s00M=;
        b=GA8Rm4mdRtZNkridbxzDHSiJ/CNk8itV2Tcx/PA9S9uyz9CpB7C1KrtbTxh0jHB26n
         sCApTLAOodH6P1B8KNMP+NCvqkXApHNw5e+el7qryod/pOL7MPq/UeQ2s079VCqO63j6
         7dWTHH9tEoEcChuqMGasx9zQ26pHEiOYB9O52iWGrKT7V3GSneceVoxibg9bcXalwfzv
         9Foxfp6kLEqbL070ZWrsryQQ6maLfL4+WB26Fu5fRIxKZ7Sn/LiNLeWLZRBbcQQAjwBv
         LTbeEyV4if7oEMlXW+6OfO5+ecXHOMvyqeCcWKiKvkqwje5l1+HXZoUWTE/arv/BnueM
         nCDQ==
X-Gm-Message-State: AOJu0Yzz8Tot6wEqmEeToZCwWE2cVrpNQQInbxX5LdfVR5pQ8rUrRT5C
        2dbzsm53a/4PCWAbaTWG6rvV4+dJYAh5ty9WgwU0TeUT4VzgjHZaiDpz6w==
X-Google-Smtp-Source: AGHT+IEisY4ALnTRd3SdmOhu9pGYxl2VC9A5R1BecJDnPHTBXfNgrIOf02rkq3XPdXvjXLYQOx2mmGTI2Av1gxmQ46k=
X-Received: by 2002:a05:6122:1822:b0:495:e530:5155 with SMTP id
 ay34-20020a056122182200b00495e5305155mr12374254vkb.3.1696744864072; Sat, 07
 Oct 2023 23:01:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 8 Oct 2023 11:30:52 +0530
Message-ID: <CA+G9fYsJA4fkLCDdXfCdjqJz3q3K0TErgKjypuLmPZ=EU3MbDg@mail.gmail.com>
Subject: selftests: cgroup: test_core - Unable to handle kernel NULL pointer
 dereference at virtual address
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Lucas Karpinski <lkarpins@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running selftests: cgroup: test_kmem on FVP following kernel crash
noticed on Linux next 6.6.0-rc4-next-20231006.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 6.6.0-rc4-next-20231006 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.41) #1 SMP PREEMPT @1696592107
[    0.000000] KASLR enabled
[    0.000000] Machine model: FVP Base RevC
...

Running selftests: cgroup

# selftests: cgroup: test_kmem
# ok 1 test_kmem_basic
#
not ok 2 selftests: cgroup: test_kmem # TIMEOUT 45 seconds
# timeout set to 45
# selftests: cgroup: test_core
# ok 1 test_cgcore_internal_process_constraint
# ok 2 test_cgcore_top_down_constraint_enable
# ok 3 test_cgcore_top_down_constraint_disable
# ok 4 test_cgcore_no_internal_process_constraint_on_threads
# ok 5 test_cgcore_parent_becomes_threaded
# ok 6 test_cgcore_invalid_domain
# ok 7 test_cgcore_populated
# ok 8 test_cgcore_proc_migration
# ok 9 test_cgcore_thread_migration
# ok 10 test_cgcore_destroy
# ok 11 test_cgcore_lesser_euid_open
# ok 12 test_cgcore_lesser_ns_open
[  400.108176] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  400.108404] Mem abort info:
[  400.108523]   ESR = 0x0000000096000004
[  400.108656]   EC = 0x25: DABT (current EL), IL = 32 bits
[  400.108810]   SET = 0, FnV = 0
[  400.108942]   EA = 0, S1PTW = 0
[  400.109074]   FSC = 0x04: level 0 translation fault
[  400.109219] Data abort info:
[  400.109338]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  400.109488]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
ok 3 selftests: cgroup: test_core
[  400.109644]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  400.109802] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008898f3000
[  400.109969] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  400.110267] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  400.110372] Modules linked in: pl111_drm drm_dma_helper arm_spe_pmu
panel_simple crct10dif_ce drm_kms_helper fuse drm backlight dm_mod
ip_tables x_tables
[  400.110872] CPU: 4 PID: 131 Comm: kworker/4:2 Not tainted
6.6.0-rc4-next-20231006 #1
[  400.111010] Hardware name: FVP Base RevC (DT)
[  400.111093] Workqueue: cgroup_destroy css_free_rwork_fn
[  400.111238] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  400.111380] pc : percpu_ref_put_many.constprop.0+0xa0/0xf0
[  400.111540] lr : percpu_ref_put_many.constprop.0+0x18/0xf0
[  400.111700] sp : ffff800080713ca0
[  400.111774] x29: ffff800080713ca0 x28: 0000000000000000 x27: 0000000000000000
[  400.111970] x26: ffff00087f779d28 x25: ffff000800a3f700 x24: ffff0008003c2205
[  400.112173] x23: 0000000000000036 x22: ffffd7c64df6a000 x21: ffffd7c64df6cb70
[  400.112373] x20: ffff0008094d2000 x19: ffff000806dfa4c0 x18: ffff800083893c48
[  400.112575] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000001
[  400.112765] x14: 0000000000000004 x13: ffffd7c64df87258 x12: 0000000000000000
[  400.112964] x11: ffff000800402e60 x10: ffff000800402da0 x9 : ffffd7c64b786a90
[  400.113166] x8 : ffff800080713b68 x7 : 0000000000000000 x6 : 0000000000000001
[  400.113360] x5 : ffffd7c64df6a000 x4 : ffffd7c64df6a288 x3 : 0000000000000000
[  400.113558] x2 : ffff0008044e0000 x1 : 0000000000000000 x0 : ffffffffffffffff
[  400.113756] Call trace:
[  400.113819]  percpu_ref_put_many.constprop.0+0xa0/0xf0
[  400.113980]  __mem_cgroup_free+0x2c/0xe8
[  400.114129]  mem_cgroup_css_free+0x16c/0x1e8
[  400.114281]  css_free_rwork_fn+0x54/0x370
[  400.114408]  process_one_work+0x148/0x3b8
[  400.114530]  worker_thread+0x32c/0x450
[  400.114650]  kthread+0x104/0x118
[  400.114797]  ret_from_fork+0x10/0x20
[  400.114954] Code: d65f03c0 f9400661 d503201f 92800000 (f8e00020)
[  400.115051] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231006/testrun/20279395/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231006/testrun/20279395/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WO7SlYRh87RbfNXUbvVZx2HBL8
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RIllBsiwSAbiLChz9w6KXn8/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RIllBsiwSAbiLChz9w6KXn8/config
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RIllBsiwSAbiLChz9w6KXn8/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
