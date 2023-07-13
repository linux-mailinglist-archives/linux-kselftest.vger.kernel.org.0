Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5386B751FF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjGMLeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjGMLeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:04 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25C26B5;
        Thu, 13 Jul 2023 04:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGDkIybyeEP/7h3OVwLRDa+u79Bm02a3x6MxLgyH8LWU/gJaBsonedktLHnG6lIfe5h3I3/0mEpyLkZSXNaAHLxLh0bK9wwfv7k2IBnFBNPysBRAcRJi8SKSgSAAt0oiSZrWQaFi9VPCTycUvnpZASrt1fRv5RyJX6HJOxs+H4qDTmJIjza9CZz/V/XOXelk9jfCCcQm3QaOkm4fhKeMpmGeCSWmUuKlgL6/bDjSNv0OglKNiEQyxCRMB7Z9zkCbEO8RUBnwKSxuVtA8msIKBqKMO+BvDu0RQwJaaGqK/iD0zSSMh77IJJacNq8K0fAaeH6ezdO9lW26VdgXBKxcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgE+9AHvqhwiWNwxdtFengcUyBpY81SylR+AynJvodg=;
 b=CrPicnmlxerUoGECcP0xxCBwdpLob4yfkrF+JRKDDWcXxrL75jkJDGHMnt/LS0xnW/yA1xWCIhQDWPKr9xJBlUIl4FkJkMMJYjgMgCVclI/wjJ8+xz4JjQ72i+g1kiX8M0H4ZKhQ2qZfYT+CWETk7fJ99/gU6NecRoCM1M8DFoJafpy6EX42PCD+n2c3nUk5dhLKXt4MSLD/FUiReqyGFEdCjX9dO3tdSLDEtf9sQBvhXqBV55MQ2pRMGZXgQYUJph0Ls4tX1vJtBrFYajSVElJOrAocsJnYl4FFG0uvLOp43jDdvzIg0tksEMRA0XdB8zTAEuwgZsiqG9z6NNmeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgE+9AHvqhwiWNwxdtFengcUyBpY81SylR+AynJvodg=;
 b=dPghTVukC3m9szBmaQT6+AxYWI5SAiQok0VWL/ACDGseFSryT/yheLUfpLLH0YJ8w4DMY21WZMHQM9bVu9Zwz/2oCh1jwo7UrmTXUp+keW4hWbUBQ8iHYsvPPam5lfDyjh7enHjcozRsnJBVuxNsoMwuW6tzYkAcaFVUMtvMqFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:33:56 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:33:56 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 00/10] tracing: introducing eventfs
Date:   Thu, 13 Jul 2023 17:03:14 +0530
Message-Id: <1689248004-8158-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c65011-8c0e-48ed-e825-08db83950ad3
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMVSDBFSaekmmxmVIyOVO/Cb/S/UeLaNWcb5iSQHniEfS8gTOH7Rnk8J7cmOR36m2WH1jb8q29aannXnbbeENiP+BX+SPm42z+zMNw6/IGa+Vb8vMtNDQ6Dzrxd2pRJKRmQVSDCcMSQQuFKukbI8DskzoEh3HvxhgTlX5b0EUOS+Wv+Sg7+56znHEAkOgMr7EhDzGdo2smyjz8qWpwqMZ5mmL7ClcU0qvvgN3d+UFtWl136zo/8vFbPYBumsNJmwK6dtTsJcWTBKhNfilEsoOkQ8sLCKx0DK7LojG98bnaNg4bHqy4sqSDZWKueTFi9RY+NhaYbBE7dWP8eBAiIWdenFnWHhzdlmfK6jAqXllobWVy9yoRMFgHswXfLyidlGiFEEQds/74MpeJzFPOZfnUrEaStWkvXujNBPYjKwTTU86XAVtvbamE7HDc6/oOELMjiviwT44gf0YAQK36wxWX4UPYqiV8XPqhNBBsinHgdfLbuJk+K1f1qKc0l8sK6Ut4RrXz0gOD1yxgdsZgozOSmnFFCngrafYvdEcCxVFWHtViB7OZ1BMZsRLa6Y0/Uai+YOWLn2uLdORg6kIa0Mh0XWVbAP+Fld/FWb3X2ra05rJMn34nDJwNrDZZ/pLroQZtIWNi8kCTY9d5Ky6bhGh+oeqNGuOgGnOrKEuIE2ftc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rye0zlZFD1MF3w8cVih2Up/ypdj//xWeYuDrvzoReTppvBMLBSTNx5HpSeMF?=
 =?us-ascii?Q?Hcegn/34+p5sZR1uSHk0YmD531/CYuV4pinZWIyZpmYVe3BfyaxcBsbDwJiC?=
 =?us-ascii?Q?ba2MT/21Hfy7JQ8pkEAiFcR/TUrMhTDAlyPKNS/oLPdpxCYx9OJKxEwPhBhT?=
 =?us-ascii?Q?VgOWTORSDLXUeeSdKiLg61UQrpFIKFW4f8wz26j3U/yAyU0wTrZalH2/oHGU?=
 =?us-ascii?Q?FUrvgFmbguxHry7QR4tdoxwHdYmHmBt8sXzqrUQ8EJV61WBzaoQlxduk2sD1?=
 =?us-ascii?Q?t/VPh/5A52tJfm0fuVQl/19xM4AOSdHTNVEqO5iH21Z84q/r2EdYUQaoCDyr?=
 =?us-ascii?Q?sb9+R7dU0P3xZ7sY7fAF1TP8bFz/IRVf/wC2pl9SG8u/Ef2WNG28YYCUSJ2Y?=
 =?us-ascii?Q?KQjHVSaFUDtqM9QNtX2iiMZ58oHtgFvRc5myGIE0a8haAVv7OppsIdx5ULwe?=
 =?us-ascii?Q?Als1+9pr7gRl/G3q5bclBiuXPKInSkc+qzM2/l5KMx9LIQEVUR5vWzS4ZdAA?=
 =?us-ascii?Q?4nbx5d14v168v3Cjz2Lf8IhWAKKW2nClnD9B9KukiI+RCO0ovF0MjDoXrXaH?=
 =?us-ascii?Q?wMxCuUCH81Vph3m4ffTth+VOnRNYZ1TgiupK9KRguAbQDibdflZeUHm3Rx3G?=
 =?us-ascii?Q?EaSYlsSKBkJQvGFe2XBHoZ7DU8Z/eqYVdvi5JnGuexGWXOX4ymZN9VMMOKEl?=
 =?us-ascii?Q?2dXqXFPIZatONc/uYfhrdtzIKom0VVNajPh/y1ogwKwYfNJXLXWORwPx0Kks?=
 =?us-ascii?Q?qIqzn1VstXkhwIuWV9vzVreV+TphmnaSr8CFyHUXyM550/YMla0Tvf1GWNgz?=
 =?us-ascii?Q?SyL9Ixq32gnyRmWYY2GHV08wBKnaf8DWeUGaAVAoXDC4pNDoR0FrB+OJ/JPS?=
 =?us-ascii?Q?wCCH4Khsoylihw/zOHrb70W27K1w480g6pq40Fmjlj+9Al2R91mQUGOaqPb6?=
 =?us-ascii?Q?DI677aGEroazgpTUV2Tc8D8iHF83CpqaIYjgGMnxXn67yq4VxMvbUK0InUI6?=
 =?us-ascii?Q?o3tZs9Ks7CG/VEf+oXHWmcspucaLaqGehFh5Dh0RHuw05bBJMSWUcAfMUuxb?=
 =?us-ascii?Q?676BsvRPl2hUZq9ck0PtW67V9CacPCT5i9GhzGsNSLh76mplxsJtqtftZ1hr?=
 =?us-ascii?Q?Z+fydjQorqpg9WL67ExC4rcLfp4EZm4fJB45ugpHlvPO9J6p53jLmkYibBpo?=
 =?us-ascii?Q?bO+LorokZUXNoDU7S7D8p8EnjhcSgqnFv2k0pWcrFFZOmWAuv2sysB/EiwkO?=
 =?us-ascii?Q?g9GNkVYa0UEq9BP5h1V24I4LRxQPK5wXGC6eui6Uvj3PKdUluSHNQTDhgxZA?=
 =?us-ascii?Q?fVP5XQataYGzmo0AfuDYi4HRF/GaHJke9dbmyLwUq4qGIhZa9FPwKicODKlh?=
 =?us-ascii?Q?a1Er1JiRzzI3vWy7fkyfCeOqFsndpLtYp9jqKDESdSIKWybrLz9cT206qUnc?=
 =?us-ascii?Q?9/G9PjBJRztoo/gKTvHN16TIosWWayCNiuEJVUAOvEZ0MB9ThaggwQLbj1vc?=
 =?us-ascii?Q?dqikEYOO2ZHVyE81QkJ3qISR/PYgyPLP6Gfm+IG5PAUp73QPvI+zLAz2SsR6?=
 =?us-ascii?Q?P+3kUa1OO6NH1yYbFPevVM6gE0pKNEKVrk7kkHCz?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c65011-8c0e-48ed-e825-08db83950ad3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:33:55.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdsVozuctcwalq4Xm5XnDbRlEN+BziyOtGeDjGoonBNOVtSj1XlDdtk7aK0h3SIkhl6+FGUYmUWxylblpyTlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v3:
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

v2:
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

v1:
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

Ajay Kaher (9):
  tracefs: Rename some tracefs function
  eventfs: Implement eventfs dir creation functions
  eventfs: Implement eventfs file add functions
  eventfs: Implement eventfs file, directory remove function
  eventfs: Implement functions to create eventfs files and directories
  eventfs: Implement eventfs lookup, read, open functions
  eventfs: Implement tracefs_inode_cache
  eventfs: Move tracing/events to eventfs
  test: ftrace: Fix kprobe test for eventfs

Steven Rostedt (Google) (1):
  tracing: Require all trace events to have a TRACE_SYSTEM

 fs/tracefs/Makefile                           |   1 +
 fs/tracefs/event_inode.c                      | 711 ++++++++++++++++++
 fs/tracefs/inode.c                            | 124 ++-
 fs/tracefs/internal.h                         |  25 +
 include/linux/trace_events.h                  |   1 +
 include/linux/tracefs.h                       |  32 +
 kernel/trace/trace.h                          |   2 +-
 kernel/trace/trace_events.c                   |  78 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   4 +-
 .../test.d/kprobe/kprobe_args_string.tc       |   4 +-
 10 files changed, 930 insertions(+), 52 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

-- 
2.39.0

