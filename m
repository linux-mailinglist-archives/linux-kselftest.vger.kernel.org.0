Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817401B70C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXJ0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 05:26:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:13424 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgDXJ0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 05:26:37 -0400
X-IronPort-AV: E=Sophos;i="5.73,311,1583164800"; 
   d="scan'208";a="90107731"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Apr 2020 17:26:34 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3577E4BCC89E;
        Fri, 24 Apr 2020 17:15:57 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 24 Apr 2020 17:26:33 +0800
Message-ID: <5EA2B0C8.2080706@cn.fujitsu.com>
Date:   Fri, 24 Apr 2020 17:26:32 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>, <joel@joelfernandes.org>
CC:     <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>,
        Xiao Yang <ice_yangxiao@163.com>
Subject: preemptirq_delay_test module can trigger crash on arm64 vm
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 3577E4BCC89E.AD8D7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Steve, Joel

Sorry to bother you.

On my slow arm64 vm, inserting and removing preemptirq_delay_test module
in loops triggers kernel panic sometimes.

Reproduce steps:
Do the following steps in loops(more than 10 times):
[root@CentOS81-aarch64 ]# modprobe preemptirq_delay_test
test_mode=preempt delay=500000; rmmod preemptirq_delay_test

Call Trace:
-------------------------------------------------------------------
[172413.750294] Unable to handle kernel paging request at virtual
address fffffe0009010280
[172413.790511] Mem abort info:
[172413.791129]   ESR = 0x86000007
[172413.791656]   EC = 0x21: IABT (current EL), IL = 32 bits
[172413.792322]   SET = 0, FnV = 0
[172413.792793]   EA = 0, S1PTW = 0
[172413.794082] swapper pgtable: 64k pages, 42-bit VAs,
pgdp=0000000040ef0000
[172413.794556] [fffffe0009010280] pgd=00000000bfff0003,
pud=00000000bfff0003, pmd=00000000bfff0003, pte=0000000000000000
[172413.795690] Internal error: Oops: 86000007 [#1] PREEMPT SMP
[172413.796285] Modules linked in: sunrpc vfat fat ext4 mbcache jbd2
crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce ip_tables xfs
libcrc32c virtio_net net_failover failover virtio_blk virtio_mmio [last
unloaded: preemptirq_delay_test]
[172413.797797] CPU: 1 PID: 15750 Comm: preempt_test Not tainted
5.6.0-rc7 #17
[172413.798275] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[172413.799049] pstate: 40000005 (nZcv daif -PAN -UAO)
[172413.799934] pc : 0xfffffe0009010280
[172413.800230] lr : 0xfffffe0009010280
[172413.800497] sp : fffffe001390fe00
[172413.800799] x29: fffffe001390fe00 x28: 0000000000000000
[172413.801263] x27: 0000000000000000 x26: fffffe0009010000
[172413.801726] x25: 0000000000000000 x24: fffffe00114a3670
[172413.802164] x23: fffffe0010d1d150 x22: fffffe0016b2f9e8
[172413.802635] x21: 0000000000000000 x20: fffffe0009030008
[172413.803191] x19: fffffe0009030000 x18: 0000000000000000
[172413.803672] x17: 0000000000000000 x16: 0000000000000000
[172413.804118] x15: 0000000000000000 x14: 0000000000000000
[172413.804558] x13: 0000000000000000 x12: 0000000000000000
[172413.805013] x11: 0000000000000000 x10: 0000000000000d50
[172413.805441] x9 : fffffe001390fd10 x8 : fffffc00762930b0
[172413.805944] x7 : 00000000fa83b2da x6 : 0000000000000000
[172413.806455] x5 : fffffe001127c000 x4 : fffffe006ed00000
[172413.806874] x3 : fffffe001127cf50 x2 : 0000000000000002
[172413.807312] x1 : 0000000000000000 x0 : 0000000000000228
[172413.807869] Call trace:
[172413.808146]  0xfffffe0009010280
[172413.808436]  0xfffffe0009010294
[172413.808723]  0xfffffe0009010050
[172413.809519]  kthread+0x110/0x118
[172413.809734]  ret_from_fork+0x10/0x18
[172413.810338] Code: bad PC value
[172413.811203] ---[ end trace 69c688402fdc8bb1 ]---
[172413.811670] Kernel panic - not syncing: Fatal exception
[172413.812108] SMP: stopping secondary CPUs
[172413.812733] Kernel Offset: disabled
[172413.813043] CPU features: 0x10002,20006082
[172413.813387] Memory Limit: none
[172413.813849] ---[ end Kernel panic - not syncing: Fatal exception]---
-------------------------------------------------------------------

Do you have any suggestion about the issue.

Thanks,
Xiao Yang


