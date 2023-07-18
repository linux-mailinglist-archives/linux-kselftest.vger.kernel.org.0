Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE932757DEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGRNkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGRNkZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 09:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0761FA;
        Tue, 18 Jul 2023 06:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E36615A0;
        Tue, 18 Jul 2023 13:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219E1C433C7;
        Tue, 18 Jul 2023 13:40:21 +0000 (UTC)
Date:   Tue, 18 Jul 2023 09:40:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230718094005.32516161@gandalf.local.home>
In-Reply-To: <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <20230714185824.62556254@gandalf.local.home>
        <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 16 Jul 2023 17:32:35 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Thanks Steve, hopefully I will fix all the pending nits in v5.
> Here is the checkpatch.pl report:

Hold off on v5. I hit the following on v4:

[  220.170527] BUG: unable to handle page fault for address: fffffffffffffff0
[  220.172792] #PF: supervisor read access in kernel mode
[  220.174618] #PF: error_code(0x0000) - not-present page
[  220.176516] PGD 13104d067 P4D 13104d067 PUD 13104f067 PMD 0
[  220.178559] Oops: 0000 [#1] PREEMPT SMP PTI
[  220.180087] CPU: 3 PID: 35 Comm: kworker/u8:1 Not tainted 6.5.0-rc1-test-00021-gdd6e7af33766-dirty #15
[  220.183441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  220.186629] Workqueue: events_unbound eventfs_workfn
[  220.188286] RIP: 0010:eventfs_set_ef_status_free+0x17/0x40
[  220.190091] Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 48 8b 47 18 48 8b 40 30 48 83 f8 10 74 1b <f6> 40 f0 02 74 15 48 8b 47 78 48 85 c0 74 0c c6 40 5a 00 48 c7 40
[  220.195360] RSP: 0018:ffffa731c0147e20 EFLAGS: 00010287
[  220.196802] RAX: 0000000000000000 RBX: ffff97ca512ca000 RCX: 0000000000000000
[  220.198703] RDX: 0000000000000001 RSI: ffff97ca52d18010 RDI: ffff97ca512ca000
[  220.200540] RBP: ffff97ca52cb3780 R08: 0000000000000064 R09: 00000000802a0022
[  220.202324] R10: 0000000000039e80 R11: ffff97cabffd5000 R12: ffff97ca512ca058
[  220.204012] R13: ffff97ca52cb3780 R14: ffff97ca40153705 R15: ffffffffad5c1848
[  220.205685] FS:  0000000000000000(0000) GS:ffff97cabbd80000(0000) knlGS:0000000000000000
[  220.207476] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.208764] CR2: fffffffffffffff0 CR3: 000000010a01a001 CR4: 0000000000170ee0
[  220.210342] Call Trace:
[  220.210879]  <TASK>
[  220.211359]  ? __die+0x23/0x70
[  220.212036]  ? page_fault_oops+0xa4/0x180
[  220.212904]  ? exc_page_fault+0xf6/0x190
[  220.213738]  ? asm_exc_page_fault+0x26/0x30
[  220.214586]  ? eventfs_set_ef_status_free+0x17/0x40
[  220.216081]  tracefs_dentry_iput+0x39/0x50
[  220.217370]  __dentry_kill+0xdc/0x170
[  220.218581]  dput+0x142/0x310
[  220.219647]  eventfs_workfn+0x42/0x70
[  220.220805]  process_one_work+0x1e2/0x3e0
[  220.222031]  worker_thread+0x1da/0x390
[  220.223204]  ? __pfx_worker_thread+0x10/0x10
[  220.224476]  kthread+0xf7/0x130
[  220.225543]  ? __pfx_kthread+0x10/0x10
[  220.226735]  ret_from_fork+0x2c/0x50
[  220.227898]  </TASK>
[  220.228792] Modules linked in:
[  220.229860] CR2: fffffffffffffff0
[  220.230960] ---[ end trace 0000000000000000 ]---


I think I know the issue, and looking to see if I can fix it.

-- Steve
