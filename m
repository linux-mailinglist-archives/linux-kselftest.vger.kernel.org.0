Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9C793EBC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjIFO1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 10:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbjIFO1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 10:27:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167810E2
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 07:27:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-573e0d471ceso1262136a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694010420; x=1694615220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkYPPMvm9lTySqP5AoLVg+Epxe3nnL99UArCEyOtUwI=;
        b=wRAjhb70jI8fbG6sfqsHAn7tjTRvYLwOWadPIo6RTc3+mee5eVVo5iAIC15Ky19UK4
         OjEbVFuPVc1MaNZpW5IvhrMuqBRQHh7YflN7wctVZb7s9rDvvLuz9SH11GrHisZdmKDb
         BYuLYSzTrcPMF1G5fZXwZ1Kj+LlCUVwq4i+RzgvpHjiyFUvwnky50KPm/w8X1qZCTGai
         ZiQhtR1AZ0UHMJd8Ve3N9tOav9ou5lDYjxhZIzxU37pf9Kr7Va/iGgTb5dCYwKE0pTIH
         P1pKGXyCrwx1mQhT1MSqp2AHWiVaX6If2QRbcvoU44ybumRuEHBP89tk8KD3xN5R/X10
         KMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010420; x=1694615220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkYPPMvm9lTySqP5AoLVg+Epxe3nnL99UArCEyOtUwI=;
        b=Y7EF2HjmXcWbsVKP+ZoJMJraidQSutwHl2sNUwEMq0Xak3hurVQgyApsAU6zldAMeA
         zgGQe9DTkCEDWU2l+OOMkxs3IvxObWQ4AlNPh4yOuLKjsNLItx1oXvWpHUk6RzQ2nyCr
         bCxp0QjJA0cvqOhv3UfweIfTioFMdeU3f2Rt5l5rr03eR79szCP72vhCOVvSJXux4CgD
         u1mfUvE1/83bMZr9b+BbpaAcFpHViU5OZpTkMkYVgE8dOH1FgYg1tvdZPdoiUtT3J3oC
         Bb1HtgUzziS/iZcXN3yP+JV0924mLf41BkWaIP33/30GC8DB/Zphz1cBxxkmYd6aaG1P
         njvA==
X-Gm-Message-State: AOJu0YyLlfcrnUTEmlwYXybonAwmYGeiC1ZMEqNeQFimSMH0JiyjoLMo
        IUChYV9JBv5aROngJt7U9LP9Gw==
X-Google-Smtp-Source: AGHT+IEb32TAPc51QHG1JFcbFx4AA1HqUDEQFc9Vj6Z1f5/7KOGSh4ul9OjBrZ+mt+5uYL48PdssHw==
X-Received: by 2002:a17:90a:6096:b0:262:ceaa:1720 with SMTP id z22-20020a17090a609600b00262ceaa1720mr12846158pji.5.1694010420166;
        Wed, 06 Sep 2023 07:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f0:103d:c30:bd8e:47ef:2f92:dee0])
        by smtp.gmail.com with ESMTPSA id fa22-20020a17090af0d600b0026b6d0a68c5sm11037508pjb.18.2023.09.06.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:26:59 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     zhengyejian1@huawei.com
Cc:     akaher@vmware.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, skhan@linuxfoundation.org,
        yeweihua4@huawei.com
Subject: "[PATCH] selftests/ftrace: Correctly enable event in instance-event.tc"
Date:   Wed,  6 Sep 2023 19:56:52 +0530
Message-Id: <20230906142652.191866-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[my two cents]

I do see similar kernel panic while running ftrace testing on today's
Linux next-20230906 tag. This crash is from qemu-arm64.

Here I am providing steps to reproduced link and scripts by using tuxrun tool.
  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2V0OqxEZUXIPNqWhQnnsuFOGYxR/reproducer
  
Script details,
=============
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.0
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#
#

tuxrun --runtime podman --device qemu-arm64 --boot-args rw --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2V0OpMYBZhVvxapElfcyFHdaNlO/Image.gz --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2V0OpMYBZhVvxapElfcyFHdaNlO/modules.tar.xz --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz --parameters SKIPFILE=skipfile-lkft.yaml --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2V0OpMYBZhVvxapElfcyFHdaNlO/kselftest.tar.xz --image docker.io/linaro/tuxrun-dispatcher:v0.49.0 --tests kselftest-ftrace --timeouts boot=30 kselftest-ftrace=40



Log details,
-------------
# ok 45 ftrace - test tracing error log support
<47>[ 1373.662292] systemd-journald[90]: Sent WATCHDOG=1 notification.
# ok 46 Test creation and deletion of trace instances while setting an event
<1>[ 1382.873224] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
<1>[ 1382.873223] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
<1>[ 1382.873426] Mem abort info:
<1>[ 1382.874414] Mem abort info:
<1>[ 1382.874449]   ESR = 0x0000000097820004
<1>[ 1382.876291]   ESR = 0x0000000097820004
<1>[ 1382.876385]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[ 1382.877319]   SET = 0, FnV = 0
<1>[ 1382.877370]   EA = 0, S1PTW = 0
<1>[ 1382.878795]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[ 1382.879182]   SET = 0, FnV = 0
<1>[ 1382.879447]   EA = 0, S1PTW = 0
<1>[ 1382.879729]   FSC = 0x04: level 0 translation fault
<1>[ 1382.879967] Data abort info:
<1>[ 1382.880240]   Access size = 4 byte(s)
<1>[ 1382.880562]   SSE = 0, SRT = 2
<1>[ 1382.880849]   SF = 0, AR = 0
<1>[ 1382.881071]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[ 1382.881442]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[ 1382.881934] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109bd6000
<1>[ 1382.882268] [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
<0>[ 1382.883777] Internal error: Oops: 0000000097820004 [#1] PREEMPT SMP
<4>[ 1382.884325] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables [last unloaded: trace_printk]
<4>[ 1382.886127] CPU: 1 PID: 3241 Comm: ls Not tainted 6.5.0-next-20230906 #1
<1>[ 1382.886539]   FSC = 0x04: level 0 translation fault
<1>[ 1382.891731] Data abort info:
<1>[ 1382.891995]   Access size = 4 byte(s)
<1>[ 1382.892315]   SSE = 0, SRT = 2
<1>[ 1382.892603]   SF = 0, AR = 0
<1>[ 1382.892878]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[ 1382.893291]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[ 1382.893719] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010962a000
<1>[ 1382.894229] [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
<4>[ 1382.897391] Hardware name: linux,dummy-virt (DT)
<4>[ 1382.898217] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
<4>[ 1382.899653] pc : trace_event_buffer_reserve+0x78/0xc0
<4>[ 1382.900902] lr : trace_event_buffer_reserve+0x60/0xc0
<4>[ 1382.902127] sp : ffff800080e43ac0
<4>[ 1382.903181] x29: ffff800080e43ac0 x28: ffff0000c5833348 x27: 0000000000000001
<4>[ 1382.904708] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c5832dc0
<4>[ 1382.906141] x23: ffff0000c5834c40 x22: 0000000000000000 x21: 0000000000000040
<4>[ 1382.907736] x20: ffff0000c8ff6a20 x19: ffff800080e43b38 x18: 0000000000000000
<4>[ 1382.909777] x17: ffff5068c5eb0000 x16: ffff800080008000 x15: 00001e8480000000
<4>[ 1382.910696] x14: 000000000003d090 x13: 0000000000000000 x12: 000010a6a8ef4568
<4>[ 1382.912214] x11: 0042c616304c5adc x10: 000000000000b67e x9 : ffffaf98378ee6f8
<4>[ 1382.913698] x8 : 01fd405aa4bf7a00 x7 : 0000000000000009 x6 : 0000000000000081
<4>[ 1382.915755] x5 : 000000000000000f x4 : 0000000000010002 x3 : 0000000000000040
<4>[ 1382.916645] x2 : 0000000000000003 x1 : ffff0000c8ff6a20 x0 : ffff800080e43b38
<4>[ 1382.918912] Call trace:
<4>[ 1382.919358]  trace_event_buffer_reserve+0x78/0xc0
<4>[ 1382.920703]  trace_event_raw_event_sched_switch+0x68/0x158
<4>[ 1382.922509]  __schedule+0x5ac/0xb38
<4>[ 1382.923027]  preempt_schedule_irq+0x44/0xa8
<4>[ 1382.924169]  el1_interrupt+0x4c/0x68
<4>[ 1382.925259]  el1h_64_irq_handler+0x18/0x28
<4>[ 1382.926943]  el1h_64_irq+0x64/0x68
<4>[ 1382.927415]  iterate_dir+0x0/0x198
<4>[ 1382.928505]  invoke_syscall+0x50/0x120
<4>[ 1382.930141]  el0_svc_common.constprop.0+0x48/0xf0
<4>[ 1382.930761]  do_el0_svc+0x24/0x38
<4>[ 1382.931907]  el0_svc+0x48/0xf8
<4>[ 1382.932906]  el0t_64_sync_handler+0x120/0x130
<4>[ 1382.934044]  el0t_64_sync+0x190/0x198
<0>[ 1382.936061] Code: b9002264 aa1503e3 aa1403e1 aa1303e0 (b94032c2) 
<4>[ 1382.937767] ---[ end trace 0000000000000000 ]---
<0>[ 1382.939168] Internal error: Oops: 0000000097820004 [#2] PREEMPT SMP
<6>[ 1382.939221] note: ls[3241] exited with irqs disabled
<4>[ 1382.939699] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables [last unloaded: trace_printk]
<4>[ 1382.940174] CPU: 0 PID: 3233 Comm: mkdir Tainted: G      D            6.5.0-next-20230906 #1
<4>[ 1382.940237] Hardware name: linux,dummy-virt (DT)
<4>[ 1382.940267] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
<4>[ 1382.940310] pc : trace_event_buffer_reserve+0x78/0xc0
<4>[ 1382.944728] lr : trace_event_buffer_reserve+0x60/0xc0
<4>[ 1382.945364] sp : ffff800080ddb800
<4>[ 1382.946351] x29: ffff800080ddb800 x28: ffff0000c2444288 x27: 0000000000000001
<4>[ 1382.947882] x26: 0000000000000000 x25: ffffaf9838b57e00 x24: ffff0000c2443d00
<4>[ 1382.949375] x23: ffff0000c02ceac0 x22: 0000000000000000 x21: 0000000000000040
<4>[ 1382.951442] x20: ffff0000c8ff6a20 x19: ffff800080ddb878 x18: ffff800080e3bc48
<4>[ 1382.952347] x17: ffff5068c5e91000 x16: ffff800080000000 x15: 000000000000000c
<4>[ 1382.954391] x14: 0000000000000001 x13: 006b7361745f6465 x12: 00000e73fb208dc2
<4>[ 1382.955303] x11: 0039fa6a50d119f8 x10: 000000000000b67e x9 : ffffaf98378ee6f8
<4>[ 1382.956810] x8 : ffff0000ff7b1400 x7 : 0000000000000009 x6 : 0000000000000081
<4>[ 1382.958316] x5 : 000000000000000f x4 : 0000000000010002 x3 : 0000000000000040
<4>[ 1382.959846] x2 : 0000000000000003 x1 : ffff0000c8ff6a20 x0 : ffff800080ddb878
<4>[ 1382.961396] Call trace:
<4>[ 1382.962391]  trace_event_buffer_reserve+0x78/0xc0
<4>[ 1382.963637]  trace_event_raw_event_sched_switch+0x68/0x158
<4>[ 1382.964913]  __schedule+0x5ac/0xb38
<4>[ 1382.966018]  preempt_schedule_irq+0x44/0xa8
<4>[ 1382.967055]  el1_interrupt+0x4c/0x68
<4>[ 1382.967816]  el1h_64_irq_handler+0x18/0x28
<4>[ 1382.968607]  el1h_64_irq+0x64/0x68
<4>[ 1382.969353]  __kmalloc_node_track_caller+0x0/0x1b8
<4>[ 1382.970204]  eventfs_prepare_ef.constprop.0+0x5c/0xf0
<4>[ 1382.971094]  eventfs_add_file+0x38/0xb0
<4>[ 1382.971872]  event_create_dir+0x120/0x4b0
<4>[ 1382.972751]  event_trace_add_tracer+0xac/0x120
<4>[ 1382.973564]  trace_array_create_dir+0x3c/0xc8
<4>[ 1382.974382]  trace_array_create+0x11c/0x1e8
<4>[ 1382.975221]  instance_mkdir+0x78/0xb8
<4>[ 1382.975987]  tracefs_syscall_mkdir+0x50/0x90
<4>[ 1382.976798]  vfs_mkdir+0x198/0x230
<4>[ 1382.977549]  do_mkdirat+0x9c/0x168
<4>[ 1382.978289]  __arm64_sys_mkdirat+0x58/0x90
<4>[ 1382.979106]  invoke_syscall+0x50/0x120
<4>[ 1382.979893]  el0_svc_common.constprop.0+0x48/0xf0
<4>[ 1382.980735]  do_el0_svc+0x24/0x38
<4>[ 1382.981475]  el0_svc+0x48/0xf8
<4>[ 1382.982194]  el0t_64_sync_handler+0x120/0x130
<4>[ 1382.983021]  el0t_64_sync+0x190/0x198
<0>[ 1382.983830] Code: b9002264 aa1503e3 aa1403e1 aa1303e0 (b94032c2) 
<4>[ 1382.984710] ---[ end trace 0000000000000000 ]---
<6>[ 1382.985490] note: mkdir[3233] exited with irqs disabled

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230906/testrun/19720390/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230906/testrun/19720390/suite/log-parser-test/test/check-kernel-oops-4c803c9937c892dbabb910d9e3c7b9e9ac9cf45dd3a5af9b07caf0f1291e772b/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2V0OqxEZUXIPNqWhQnnsuFOGYxR
 
--
Linaro LKFT
https://lkft.linaro.org
