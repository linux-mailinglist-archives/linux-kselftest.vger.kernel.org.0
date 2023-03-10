Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B436B3BA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCJKGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCJKGC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:06:02 -0500
X-Greylist: delayed 1366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 02:05:59 PST
Received: from mail.schwarzvogel.de (unknown [IPv6:2a01:4f8:252:1806::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B85910BA6E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 02:05:58 -0800 (PST)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.96)
        (envelope-from <klausman@schwarzvogel.de>)
        id 1paZHK-0000Y1-14
        for linux-kselftest@vger.kernel.org;
        Fri, 10 Mar 2023 10:43:10 +0100
Date:   Fri, 10 Mar 2023 10:43:10 +0100
From:   Tobias Klausmann <klausman@schwarzvogel.de>
To:     linux-kselftest@vger.kernel.org
Subject: BUG in dhrystone selftest on v6.3-rc1
Message-ID: <4aeec948-f1b8-4d2a-b096-b2d6104946ba@skade.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey,

just ran the new Dhrystone test on one of my machines post-boot (using
echo y > /sys/module/test_dhry/parameters/run) and:

BUG: using smp_processor_id() in preemptible [00000000] code: bash/1903
caller is dhry_benchmark+0x39/0x90
CPU: 5 PID: 1903 Comm: bash Not tainted 6.3.0-rc1 #13
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4 R2.0, BIOS H4.84 04/08/2021
Call Trace:
 <TASK>
 dump_stack_lvl+0x32/0x50
 check_preemption_disabled+0xe6/0x100
 dhry_benchmark+0x39/0x90
 dhry_run_set+0x33/0x40
 param_attr_store+0x98/0x100
 module_attr_store+0x18/0x30
 kernfs_fop_write_iter+0x14e/0x220
 vfs_write+0x29a/0x460
 ksys_write+0x74/0x100
 do_syscall_64+0x3a/0xc0
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f5eec252190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc4b1dea68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5eec252190
RDX: 0000000000000002 RSI: 000055d3c05b4540 RDI: 0000000000000001
RBP: 000055d3c05b4540 R08: 00007f5eec32d3d0 R09: 00007f5eec32d3d0
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 00007f5eec32d760 R14: 0000000000000002 R15: 00007f5eec3289e0
 </TASK>
CPU5: Dhrystones per Second: 34361907 (19557 DMIPS)

Test completes fine (with a credible result) and the machine keeps
running. 

If any additional info is needed, lmk. Note that I'm not subscribe to
the list, so please CC me.

Best,
Tobias
