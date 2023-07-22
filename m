Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081675DE45
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjGVTiM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVTiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:10 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC10E71;
        Sat, 22 Jul 2023 12:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S84v/7vIBAlFLdNhS25O9zn0GjollGMwPpa4Amqh6rFEDzGXlb4yenVQepPOOXBldVNWxf3uvvAG/ZeNcOleeSPZjLqirYRdtzphsO/6k29mU+U4+K4BEtGZd3sIsv8r19R4WmnHDFT4q5LSQ+y4z79Ff3OLsJ4eRMZ1Eypd09e0zbp3DlHt3/hK7HH0VCIwGLgL+ZLHkd0BIyTaLprMAszaD0d0UCOVgX3eiGJoj9lNeSWVdM8XOfYOd1fBwXezH3hxISLlFt197E9fpVnTKW9oQgJVv6VSTyQZmdl9wW3xuORu2/IFxWcQo13fN7QhbuQXE99fDuaoWr83lYQ1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4WaK4KxTRuWh5daClVlTC1EezEIfNyBJPG4+QQVqkU=;
 b=KrzXFYZStwYqO7Bx0oJE3FlVKXr+Wuwu3vMdKkgqpBSxolllUBh6FXQPk513mq7BCTbPY/KHqNoaC8zYqrekcaYot+CUwxxC4o3i6YtVNQMWIpK+tO5sXHOaEgl8iV+LVtyuzipCrL3qBUjnGL+IpZL3eflww2eX7m2OX7j8Knf0Nx/B8+mWjejhrELwdjDRhhnWsiYA/oNQUiaBj1fn6GZAR6RrbT+0Ac+ZJoauK6zUV4A50f7UuT886Wyk8s5OOodrijCpxs4qivZKRjT/iXL8CPmuxUci7hblCl0MYh1MhYFXzUYUrK6UyuB8qLnD/+SbI67koGW06fKcv/MU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4WaK4KxTRuWh5daClVlTC1EezEIfNyBJPG4+QQVqkU=;
 b=zas4uUZDMt+4uiby3IugkC3CPELe7al53+eFvXYmwLF/HJYC5mKkhSrtcTljnEvowqUryTeBVceBXjgG7QwRldPZkUzNmjEfr8QdRQ/oKsamuT7cyTDq38mx745VaGBMEdSjyDm652cyt4DfF77mUaAIf2nAKH0dw835l7Se6Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:06 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:05 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 00/10] tracing: introducing eventfs
Date:   Sun, 23 Jul 2023 01:06:55 +0530
Message-Id: <1690054625-31939-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MN0PR05MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d231707-8548-4ac5-bf77-08db8aeb2b67
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Wox/cW2yLtKpLFLkl7MMTjqNQMrFe66Io5EAX8C08dJ/L2QVN6KaTGS8FKdsSqNf20taiopFvMP0qVBMU8dVuhZ6aXg0LjW4sKfbP5OWJiceZvxg4RzJNRfivP9KwyJnhLgyMC+KOV4Y4tNmxcD/FAhrUp4GWHrVrcwa6MCIjjdDrYmwz040BRG/izuuIQ4l0YDao1m2c3VXnrtolMKELgdiaZmv66z/utBVJDhhdpTm7ERiauuTaspQCIahLIIzoRuPUXvdj7pQlxih4kFQmq+wdOrIXd7M6HVEt2heJib13/vEfbbIRIb8L8ZpsYPlYGq/fZLC3L65q0EpCzGby6xHwBDR4r8+dfAjTy7siS0Rx8XTnb+b2p9jvylPHwoBQFHTanMT7vgBGB3QtWhCBaWe5ApQNnRDJJQ2VHvMprWmp4MRBwnULcS8Ev5nkfk9vuOBnc5TFs6bCbyRbWQIYcP9jtSJLIqx9V//aWygv7zC5F21u+AvX/rF4E7JT7h2JxPhqBlafoWi/GlXax2SbV+Kp/pjYtGpwsrJ0iCdsHc+cSwMTsCPV5Cictjgn8on1fFeXPf8Io21Ke8e8too80ITCMywGH8kWyRmmaavdphNzhRujmaxCCMAVX6pMHsSYkLf+RE3ijhw4nh5KCMQVXeAZB+jacX5m68KhJOwrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDRDV9l0uGMme2yf0RlrNUdQALgDwFo9GabXrVs1o72YIxwP3Lwwg33gYjSY?=
 =?us-ascii?Q?g5Hiwh3neOA7uGn85ISVI/5K9iom34M1UNkWzmIXBhdzymEfRIGS12NWVJXt?=
 =?us-ascii?Q?7yjGoXOYVlIxsr/6OH6MnHdNkbW5pumY488O5YNUTzUbazLx243Q4AiJFQUE?=
 =?us-ascii?Q?WdEPkgZ/EpKpyImJhTT1Krw1ETSLaXwwwlSbovN6+p2Z++GxGKdaa9UrZlAk?=
 =?us-ascii?Q?yFOPfv2D4kOi5IfwOiilOBO+VL0X7uDBlyl/dUzSlc0zZQ5C301AkPym2oHm?=
 =?us-ascii?Q?4KlbuOjGduAI7VXU3U6AFOnDme1hJZvc9BqDWZEFfg08lkTjxJ+yTKZqtTYd?=
 =?us-ascii?Q?YGX6ITJCst8TSvNQcy/9mNr19/5aes9Som9DW5/mokjgEGgVjq3i7Jb5HwCS?=
 =?us-ascii?Q?0XAJCRdpXnJhJicWEPj39AB6YlnlRxjCHQPSxsLRzaX4DBw0b/qoDvdIFQ3B?=
 =?us-ascii?Q?3Hi43t/ogSpLDMc4tS/GlnbCa1mXA1q1sy1F6shhDpnzojWPG1a5ZJBFdYvb?=
 =?us-ascii?Q?emIVWdgQEg2pK7kQCR/yT0+/g5HPAz+4tfzG2Ru8rtwhCaPM75kFQBPJRRUF?=
 =?us-ascii?Q?4imnfPqVHBisu1npUmrSu+RU9BPpy9x7DBvEU8a6njfNc5fgoMunU+UTjahR?=
 =?us-ascii?Q?FdKSLtHX3E+CocV/bqCpNKxy4dxeJnjCIRFwYRE8CHDrSb59MsTcTQ2CsaCh?=
 =?us-ascii?Q?RblVd61soso/t5tXp2Z63YgPEs0KQDo+hzW/R3R7nTSmRc0CTok7jvdZs/OZ?=
 =?us-ascii?Q?8VOus0wioPK85n1Iy/vl9U6bY4v1MvT9td9wzyOGK+iGd1pz38GAxNzNOgMe?=
 =?us-ascii?Q?GP7hV1H/5iAbdbQCWRcaH5SQzl9Ss+lk0UE/SNuhhCftNn2zc5nWxs2/s2w5?=
 =?us-ascii?Q?tONOvIq3sEe8tdHYNelLNswDRTL5swYzJvJo66NsoaON7JbUxdbaBfyAZq5f?=
 =?us-ascii?Q?mcsL8AN2D5QiI1XQ2mKNfvQZPjjLKHr7HcIQCmHauL9Aw+YqKTpKbUIq/UWH?=
 =?us-ascii?Q?efMqoanGZKIBD/XiCJc64mQsZu7haMC8nLPluXpg4O78g4IWRmBCIRZL/GdP?=
 =?us-ascii?Q?ULfzr8YzyIfoWgIovJRYnVxXyufOtmzDqwKsrjPKz8gdQSHKYEAr8lLsVQIk?=
 =?us-ascii?Q?Iwffu8fYgp5y+R2LbGgXZvH0BrqkkIuPc5bQsRe0+oUT5BTtnQwJmrMj0xq+?=
 =?us-ascii?Q?fJNKUOoD5idjrFcpUBb/LFPu1NG6kfNkTK0GLjQOP+eVUBHot+vl1+VbGzAT?=
 =?us-ascii?Q?gm68feIATaqBEUaAuhZkB3ctm7cvSYiApuCDYuT6C1dLh/aL9gHUEP4O90AM?=
 =?us-ascii?Q?mCejPMraHwImNy8J4PcFBr+mgylFrR/ev8XsENngAtsrUCdE+Ckdr/iGrOSJ?=
 =?us-ascii?Q?LH2H8DvtKCNbBYkbHkfIV+U+lJ0nnWBN6SuX39QLTCu+Iut78E098tvHldRn?=
 =?us-ascii?Q?0JUAPFP3NUDLnUseDzxQd9FU+1kydyvKnYg9rYUqJrCAAkefoheCA6JlJgbn?=
 =?us-ascii?Q?4YS+5pOAY9rz3hGFEX9e6LnQrCDqt7DOOm2X9rQSoJK7uO6rdnQ/Z94RtpA5?=
 =?us-ascii?Q?NnISQDrsw9DuNP080QZGRg/VW6waVpesRsO7T5Y5?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d231707-8548-4ac5-bf77-08db8aeb2b67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:05.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR5rUv7RTHCshkSIf0Lv/M2cp4Rmbre90ClUA2MVsl1d4vBQAVQtt6YMv5YU4CEEArrX8XUVPoKA61hi8MrtqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR05MB9005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Events Tracing infrastructure contains lot of files, directories
(internally in terms of inodes, dentries). And ends up by consuming
memory in MBs. We can have multiple events of Events Tracing, which
further requires more memory.

Instead of creating inodes/dentries, eventfs could keep meta-data and
skip the creation of inodes/dentries. As and when require, eventfs will
create the inodes/dentries only for required files/directories.
Also eventfs would delete the inodes/dentries once no more requires
but preserve the meta data.

Tracing events took ~9MB, with this approach it took ~4.5MB
for ~10K files/dir.

Diff from v4:
Patch 02: moved from v4 08/10
          added fs/tracefs/internal.h

Patch 03: moved from v4 02/10
          removed fs/tracefs/internal.h

Patch 04: moved from v4 03/10
          moved out changes of fs/tracefs/internal.h

Patch 05: moved from v4 04/10
          renamed eventfs_add_top_file() -> eventfs_add_events_file()

Patch 06: moved from v4 07/10
          implemented create_dentry() helper function
          added create_file(), create_dir() stub function

Patch 07: moved from v4 06/10
Patch 08: moved from v4 05/10
          improved eventfs remove functionality

Patch 09: removed unwanted if conditions

Patch 10: added available_filter_functions check


Diff from v3:
Patch 3,4,5,7,9:
         removed all the eventfs_rwsem code and replaced it with an srcu
         lock for the readers, and a mutex to synchronize the writers of
         the list.

Patch 2: moved 'tracefs_inode' and 'get_tracefs()' to v4 03/10

Patch 3: moved the struct eventfs_file and eventfs_inode into event_inode.c
         as it really should not be exposed to all users.

Patch 5: added a recursion check to eventfs_remove_rec() as it is really
         dangerous to have unchecked recursion in the kernel (we do have
         a fixed size stack).

         have the free use srcu callbacks. After the srcu grace periods
         are done, it adds the eventfs_file onto a llist (lockless link
         list) and wakes up a work queue. Then the work queue does the
         freeing (this needs to be done in task/workqueue context, as
         srcu callbacks are done in softirq context).

Patch 6: renamed:
         eventfs_create_file() -> create_file()
         eventfs_create_dir() -> create_dir()


Diff from v2:
Patch 01: new patch:'Require all trace events to have a TRACE_SYSTEM'
Patch 02: moved from v1 1/9
Patch 03: moved from v1 2/9
          As suggested by Zheng Yejian, introduced eventfs_prepare_ef()
          helper function to add files or directories to eventfs
          fix WARNING reported by kernel test robot in v1 8/9
Patch 04: moved from v1 3/9
          used eventfs_prepare_ef() to add files
          fix WARNING reported by kernel test robot in v1 8/9
Patch 05: moved from v1 4/9
          fix compiling warning reported by kernel test robot in v1 4/9
Patch 06: moved from v1 5/9
Patch 07: moved from v1 6/9
Patch 08: moved from v1 7/9
Patch 09: moved from v1 8/9
          rebased because of v3 01/10
Patch 10: moved from v1 9/9


Diff from v1:
Patch 1: add header file
Patch 2: resolved kernel test robot issues
         protecting eventfs lists using nested eventfs_rwsem
Patch 3: protecting eventfs lists using nested eventfs_rwsem
Patch 4: improve events cleanup code to fix crashes
Patch 5: resolved kernel test robot issues
         removed d_instantiate_anon() calls
Patch 6: resolved kernel test robot issues
         fix kprobe test in eventfs_root_lookup()
         protecting eventfs lists using nested eventfs_rwsem
Patch 7: remove header file
Patch 8: pass eventfs_rwsem as argument to eventfs functions
         called eventfs_remove_events_dir() instead of tracefs_remove()
         from event_trace_del_tracer()
Patch 9: new patch to fix kprobe test case

 fs/tracefs/Makefile                           |   1 +
 fs/tracefs/event_inode.c                      | 795 ++++++++++++++++++
 fs/tracefs/inode.c                            | 151 +++-
 fs/tracefs/internal.h                         |  26 +
 include/linux/trace_events.h                  |   1 +
 include/linux/tracefs.h                       |  30 +
 kernel/trace/trace.h                          |   2 +-
 kernel/trace/trace_events.c                   |  76 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   9 +-
 .../test.d/kprobe/kprobe_args_string.tc       |   9 +-
 10 files changed, 1048 insertions(+), 52 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

-- 
2.39.0

