Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EAC767465
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjG1SVV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjG1SVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:20 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE83C1D;
        Fri, 28 Jul 2023 11:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5QHKGheWwt0JpOtCAcr7lUa77V5W78RODVSk+2bWOSV0frl/loqsvMOLLTLPS5xaGFk0yLWiFrewTIEOP8YqH3uc32+DHoaESWCGwI/LKUIE5q1Ncw4q62SzgNUyM+rb9g8x5NjTmvXG8c99lAJzAH/DjykNh0242u9Pjrf+B0Pzx9/38gpcmUp9wTz3sk5hOuT372dSiCYIaw/9nTrzSAaGiABXI10GM87UNj/HbWiQgxvzn1cxAB5qEfreZIdi0cjmiFwAzyXJ/XfAQeu1uudZeZgmIjReVVXpwPaw+EVVGLvXerm69uDPoSCWsRbxRNZZSC52tqsNZTWiIt5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfLXMCGj80CCDcdIYlIvFACCEWdgC5XodSH6dQhSpEg=;
 b=OEJITMyqSF8lKrWbKidyHSKTzRCMZ4vsfVobIQ6xvc8iVxhq2tZ/lE4QU0J1KF3JmxG8goJQKjumIqc8iXpPZlrv4CWwJFQ9tgkMZg92iq0vPpX7dDAaX1D466bJCQ/zsx44xiUuBSQDC66NnW9dWIrnMm4lYIzTKc53Kffu2TsDN9U2YGZrxf1AaVjBNYsaHB8gD4MPe3amGBqaWvdflJc0WtZWbCKNhewT3vroNMvNrvdf3q6MtLAT7Y8ct68VbPpT2UPdeQYozGVK2jObV2t5J+ghM2+YISzNa7umI7+qSaO962XYfs1w85YaA2Y216BOfN83TH0h+0rpSDnnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfLXMCGj80CCDcdIYlIvFACCEWdgC5XodSH6dQhSpEg=;
 b=S7eyXUhjucBQsKPyH57+OFlWIGqqnZSgdE4mTuPGg8rSmsC49dddrPrsIKndngG/dztqX6FSs6TCqtxNW7wQhedzgv5VsoeckSsSTNDfuDLrYXUKdf3tg5nlLKCTV/JLXMljcTGV0R+R3tzHO9A9LDAJnL7Jf6PZkyQbwGDF1fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:16 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:16 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 00/10] tracing: introducing eventfs
Date:   Fri, 28 Jul 2023 23:50:42 +0530
Message-Id: <1690568452-46553-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SN7PR05MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bdf1bd-b62f-4368-836b-08db8f976eb3
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/Q7vWCWjQH4WRWCPMnf4MlFfF2alE89gxzROU2JqrsNQSolzaA47K0Pq893nkhJz0psl6JfY6vL5WTRwrTOzQq9xYMO/H9GjoX5N1EGZsLLONzZRm6PI/tjJtkXDuoGkGp/Zvs3kxZgXtgPIqPuTyMQqXjUrBL+IyStuvHbJXBLJwmb3qSHXsJcUKdvPiexA5X8zouUqTuwkm/MnmX5nq3yHF3nCQGMIURJqX8XErpqCixdIffCJ3oQJRXQeYzdXJVzaU5f1lrRSI456QcuaDOgomkWFDiH/nzkyhkra/Cgj7ONvsz8IISaNEU2LNnS0G2WlDEhdaBHgbiMQ84jyhLnMYEmolC8q+BbzdLqXn9xtDpIqxpO8ZqVe4lKR8HexKourqzCwtt4Q08rML+W2py0H/StEnkFjK13CNloYTX6JxsVq6jJ0TCHBzCZYyFaSklTjmHQlHuBiQO2JRZXRJIWuYDfkUleLM/QWoHEdfHoT8N8mLt0V0usbjQe2ZUw6iNWMpfAGMVgSZxD9pFbN8Hhm/sfJ24rCWONx+m2FV6s5vto7VPZHK3tnSdSgP2SdqSzTh/8zEsyvXgMZZXlUtIQbpupiiDeCsu2q05Jo1Z5w2eQoUkG0TZjHit4lSqkje/iqfwDlBH34d45mmjwrlF5XKBiD8LCMKUR2XfMiNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkmIyGmPDimGbQGZouxTd8NtazI7ewBDkhLaoW3cFUFzLz2IMDpaq+r8/WQd?=
 =?us-ascii?Q?YJozPsAuLtk1uFoBbRoaVVUew++xCuji+6frEpQMqQMmZpVvxKemW4hOb2R5?=
 =?us-ascii?Q?lA3L0i+fK5N9LOd2sQnJOV2jHbEg6HczwwiJai+Q5hk6uKmiUHE+KJQMeQR0?=
 =?us-ascii?Q?k03j61m5CkDcv3sxGprqveNHGRRDtzzo5m656xB766jHrVbu8r99eezV4vDV?=
 =?us-ascii?Q?gqMdILOo+p5Gl2c5ko3GLo/0EGTsEKZyq+3mBoWtjCV/ontQKK2AL5jQ/HFL?=
 =?us-ascii?Q?++XwziTIvzA6BOhp67y7ueloFKZkHyBDCgSVxMHDRjZiW+hLNG7pusQqp9CY?=
 =?us-ascii?Q?COYulNlKBZ5onCYBz38Vx1KZ6RznCAPHxY99JlXapV/SaT+AwNoIPMD7Z8zG?=
 =?us-ascii?Q?LunxJ0oqWc7t0CxOQjbGft/xDG1EoyfhjoH5CsMzCTm5jSNAjgmcm3vlCiSh?=
 =?us-ascii?Q?Ah/d/Wyy94JweJHTwYGlhWeFOR0OKMRNRcCFF+ITDyOW4IS5PHWzh83M89cs?=
 =?us-ascii?Q?OOy9mKuW6/9rQQUkL2Fgt1dGH6CCVzlR78eYInTsdzovdqPxZLQThbm0ZHY3?=
 =?us-ascii?Q?wHz7qHl7m1AEigAAW7Qfe2cKPARYFqhT9QL7YZjCh05R9iKGkeQscTWs0aEA?=
 =?us-ascii?Q?EWBN6EzGtzuPryLXK9dpPnOUyTCXYB7bqQXbFupcKQegvVX3Ji+l3tjdB6GN?=
 =?us-ascii?Q?nV6VjUzmKPsefMyUj74EGrejAq/NDvrm9QJWh/QnxpCB9Uc5QG7M+4tkDTFP?=
 =?us-ascii?Q?3hNiYiQmoBAajO4evxJ3u7WpttU6NcahmId1RnlZNkVDMojImStYj3k0NsYt?=
 =?us-ascii?Q?xgZ3kMvp42M+ujYVNqvrlMDfFsTKEeRyO6cMWlKypIX1CYrgxe8IAiigSOT/?=
 =?us-ascii?Q?CNoGmIUV3PfxGc1Ncd9PXxvIwZ3Lyz5GB3WSYuzlDAXyvVZA0GgbgHDhdnOD?=
 =?us-ascii?Q?BleG1QhgZt02m5LIQA5Ac97wP/NGF7HuG9dva44aCBKTVQ66v0wC5VAqI80h?=
 =?us-ascii?Q?crzJOd/ZzFVfUDiwdj8DtXyRxgHylFVkt60aYDIkoulvVdU2KS3byZiuk2/h?=
 =?us-ascii?Q?iPfzXx3UMz/A/7tZtOz7iKqRYMLT7vZ5wV2G6zJqYuCcdPuTy9PMZ7IR1tnn?=
 =?us-ascii?Q?rorUhIG7B1qCEH06YU2IYf2ftdJvxeii4X4t2UgtLhuSnGfjMTcGfq6cJksQ?=
 =?us-ascii?Q?vdHEkSnqvR3HUWBDvqgx+V09W9PqEpLVopPb3UMl18UtWzYyHF4DdPs3AQWD?=
 =?us-ascii?Q?LnQTCHrvzillishHvd38LbD9ji3JdUFZSIk16jHy88RLNxo+PzGSfGHWk92F?=
 =?us-ascii?Q?dPMkJnJ8F0OeEn1hLxS/GClIBxlSkgJhTR8EVRVmflW4abJeEjhfHTJ0ttaa?=
 =?us-ascii?Q?MxvFba7csoGM9kITlllHj51CvNhx2HDMpIsQKkFmGFA5wXj3mxs4Qt98adZD?=
 =?us-ascii?Q?MZW+XF2Zkj33R3qJzcOEw0X5n1FmeRFv+pAPZnubj2PgivS7d3ajgOnbfs58?=
 =?us-ascii?Q?ndmux/ggTr2Lo4iLAWInycnqD5UN7urfOudPQMPMtUX/tbkKjBYJ3xYOmFlz?=
 =?us-ascii?Q?FboosCWdlG916oxD2DituADQVEOqAvF9bVCxH3d4?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bdf1bd-b62f-4368-836b-08db8f976eb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:16.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c8RtPKu/5GdbxuB/NgvVy+pPS/5VpRGldq5eYVhSMTGPaPuVm4Q2bGX9LogQnVo/iy37KHLHv4Ua/SRE3GtvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9264
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

Diff from v5:
Patch 02: removed TRACEFS_EVENT_INODE enum.
Patch 04: added TRACEFS_EVENT_INODE enum.
Patch 06: removed WARN_ON_ONCE in eventfs_set_ef_status_free()
Patch 07: added WARN_ON_ONCE in create_dentry()
          moved declaration of following to internal.h:
          eventfs_start_creating()
          eventfs_failed_creating()
          eventfs_end_creating()
Patch 08: added WARN_ON_ONCE in eventfs_set_ef_status_free()

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
 fs/tracefs/event_inode.c                      | 801 ++++++++++++++++++
 fs/tracefs/inode.c                            | 151 +++-
 fs/tracefs/internal.h                         |  29 +
 include/linux/trace_events.h                  |   1 +
 include/linux/tracefs.h                       |  23 +
 kernel/trace/trace.h                          |   2 +-
 kernel/trace/trace_events.c                   |  76 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   9 +-
 .../test.d/kprobe/kprobe_args_string.tc       |   9 +-
 10 files changed, 1050 insertions(+), 52 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

-- 
2.39.0

