Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B050F6F42A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEBLY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEBLY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:26 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013011.outbound.protection.outlook.com [52.101.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2017E40E6;
        Tue,  2 May 2023 04:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLm5i4PCkVd3ALTrW/0d5kAg8l1aQshmTsQokI7V4RAgQNEvj11RdaEGBym6bBOmt3Mto9xjCSHMoxkmI6spRpPFZ8nVD/vb2R8vSkWNlg8Sg6xeTAmz9pBfHFWCPkbwY0TtgmEJiDb1EaXWQkuwbFnu3mzYga5eWRRaEj3sCi8c2LJ8zRpFkaw3SBbVjmoHiHhQbBd+USEvyOe8pVCObR+kwjwT8MY2d8ZdN0+QqIxZjuDiw8l+xr/wVxxMaDQO3d52Zc3PXsC4waBv2B6xJyCbPlhMuCT1EYQvpvM65mzV+gTa8tgVLRx27p78CrvlKj5u8AkMvYZ+VEhpsl9JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlCPd3vNHGByGM0hm5PDXXFbIMxMpTMUSeky/W6jDj0=;
 b=daekoN3Bl2l1TLNGB8wr1GvM+ixmQWo0/OGkNyiSjxbFaPOcii9po18ZdfJJpeLC9f2AJ2i90sPmlYaMG6sZxfd3JUHn6kCHZoIuM+DYpZVy256FYmncIXRRrBq5pugbwXo2XjmL2AaPABJ6MlQXHQuTM3xSu3N5aclMDwZu7qjlp9eS+GGtyILLOFupeV+u+8tRRUXbg67o95fjMNUW2LxOAiFOC35snzr7PdfJ4/WnSsSmpR6Ui7a7nc7xt9mtfdlQHJqtVpDoZ/dCLCog/ZnD6UZCwfQjVdlogcmmii6OQShlZ8NUgoUtZTCObTZtp3MoKLG6wXo2Sq+Ds48zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlCPd3vNHGByGM0hm5PDXXFbIMxMpTMUSeky/W6jDj0=;
 b=tW3mset+FM4L+hnCVE0MHg4xZY76M0Q3gbcpmJWnFjraZTOxWnHw96KNnGvZeuUC9HEpYQ77JFVCvchcI8hKU8Pk2JYjgZTaJLuvWRHxlQksnVdyVK90gW0uVeWeskU3BhmDihpl+d4gXcA5a9CnOtfJG7oLOEm3EmaicwsNcBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:14 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:14 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 0/9] tracing: introducing eventfs
Date:   Tue,  2 May 2023 16:53:11 +0530
Message-Id: <1683026600-13485-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|BYAPR05MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: ba833ae9-63fb-46ce-6267-08db4affc22b
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCgn2zO6BEubNn21akEMDBsRLPrTA9ficiWjA7JTOoOeHLE5nvAF6yY9R8TjDofljUDboPy9J2nxEMkYjLDJSUXoKBjFwUz6T8qaBoQNXERJwmnOyfsLRABzTCvbaDfEa1AlqCetrawLYNrZuIE1P4zZ/MavmL2tAuSkezLPFhFYF4GeWU06Fnrhx7N4d3FK4PdXdbIT/K3NNueiQ8AZ4SGZpJKtfVn8W8ge6pgG0AQcKJaiu7Mb97hUpCN7xikzVF/lFQohJX7ogS2MDcmCZ2NPdBovceuGb01YHzlfJk1Cv8Yvov+kbjBqE/0wsAdBK/u4MdTUyZvHw1hrJzN/J6co86rJjXvM2XlPQqIxi2lTn6m9xmUQwaugmx0bLzI8MuFv2eafvgUdefQ8FfRheS1K+MJZqUnwqoaVhM35kV3Et/CclRZ/nTOxvDnIEGD9Wpoov6iFUsyXdXqM4UpGtfSiLGuAqlrZiRTtu909Zj7JlYJ21G1UwgSlQtEXjKK6KOvzoJBr9Z7C7Oq0vJP0bOn7AzE9VS6CW1UK8luOwFIZsluFUWxZ1mBJH62BLgP5fmkUZpd42wezBh+0arNV+fb9CjC0EWB8XmeznlhFHx5pfOWNyGkUFCdtU7dJAt2O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rXaKzd2bG7UQQ/OUuOWTuOLEgPm1EqtHTOaqwjtRbfoP+SUuCF/K/PIZ0p7?=
 =?us-ascii?Q?zw21xTTWSl/ew0/86wDt4HmDqkuf4wG8era6JXVCW3IH1S2wBDXbkq4YD5Oh?=
 =?us-ascii?Q?xtAnerwC11QVQj+eG9GUX4HCc+J28R5UAE77FmixiH7WMvnjx03LbyVtqlng?=
 =?us-ascii?Q?skfbLgxeWCQNuSk8QWICaOIAGlggf9aAUcFT+7zn/wwkG3/k8eLibOOmFWxM?=
 =?us-ascii?Q?7LFuNNtd3VGOsrscSbYR7e3IxoFZErl2FAU1h6UTUGKjuKQdK5ObrDFYaRin?=
 =?us-ascii?Q?71ZrdDO2H0xJfqZCHPVYnWBujwO46NWETqXRJHfbxIQkn5c7j/fCWR2zR6v4?=
 =?us-ascii?Q?bhWx8ZyKcJSXTTxggiF79950d9XF+jTL7FjZd+azOxlzb/B9vd3oSdcqx2Lz?=
 =?us-ascii?Q?zXvH8ELKm7S8fKjsixp0q2kvHAX22OLIO45b0w3gYbWGQvDE5vEzzo3kfnsB?=
 =?us-ascii?Q?ZXh0+YCuyTXcpl1HH2R5v2EjgW3nIM2geOuOF6pVlyQkAPmaTxWZAZ1Jt5Eo?=
 =?us-ascii?Q?JgkAUrpHZT114mhsuIls6AGgDZqrvmxAHHHEIl7PT5dYIfmPR8zTfn4lC+dT?=
 =?us-ascii?Q?ZUEKbEZhxBfKY5mSfAbPsh8VZEArB4gz1HVD9JxmCAceSTcu5VC0c23iMiy7?=
 =?us-ascii?Q?NpHvIiTexflfc4N2U0kIMt5VRk2DEl0Gr7Rb4CV5+iUU9Z0iKxDXBxOGP9R1?=
 =?us-ascii?Q?6yNZWp01tWdieuPYiagFZImUFVcGvSJN+T04Yx3f/l0Jqa+SzdS9wSRGIrgj?=
 =?us-ascii?Q?htsdoScdNaS6/f3ZitSlnNHMQ3WngsU+b8kfupSAok3qjkXPpHXrMlAUS9RL?=
 =?us-ascii?Q?wwIRuqFgxQEUtUsl6U8XqQbzvBTQLeWB+ZOPNqjx4okTeirwB9QjTSCXLrwJ?=
 =?us-ascii?Q?SX9ll+fhm2m4Nmzu9XouqQ6Bhl3GqGaL07RXNBMQf4oCbqHy3SWvNRN8eB21?=
 =?us-ascii?Q?l6seENs18ggnnbDHoFBmWGcxYW3OzlfARNaBZhs21p6Hqlu0hWmWzrGA87Ut?=
 =?us-ascii?Q?2XEiw0G7n5WxdUgHeEveJFSf0Fx63pOX0ngs8/UKFgexW/6i4E29QIyBihq5?=
 =?us-ascii?Q?NSj1x41vsq8RsvKcM9nYh4OCEXD+ZChRtmVxGR1g9ahiPjjFY0LLaf7MHR+i?=
 =?us-ascii?Q?Q4BFlmvHLtqP2zMAzKcMIIFB1b4F7XfejvX5FjruLCVEmBXvkXOFl4UOl9OL?=
 =?us-ascii?Q?awJWzHKVV41fDjDFnQYaAEwh1n3+9LRDUjFhLWsQp2ga9NbBuYCtzAcUgy4D?=
 =?us-ascii?Q?UVm/0Jr+5XfBDbLVA8GqiKO35r6N0zkuLPR3w90ACcW8wNO+O7/SQ2zJZTsR?=
 =?us-ascii?Q?DxqVXyqLBMb7N0yItWBLdRaUj94XOzIkaBRi3H2Sc79yoNza7dbl/ooRtfFL?=
 =?us-ascii?Q?LISvR8CIi3Zs0ZKWnpNf5mOPz8QgW2OgrPejILbb1Y1yiFPhH/CYPjFv1wSj?=
 =?us-ascii?Q?/AqUiW3NrMfde2lx2GeC9xW9ErLwrsE/71l5JBhKxNKs/Zc96Uxa6ZBRxBCz?=
 =?us-ascii?Q?KtzdXVUqqOQ8r45QAe6ZR1eHW3wZAmTB1FYjpew1Hn/n0Z/OL4405hfZt0Hq?=
 =?us-ascii?Q?4yv8dgGvhhlD6lM0G7Hrszyj2saC717NUe/GQilp?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba833ae9-63fb-46ce-6267-08db4affc22b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:13.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVkerRUHI+bLkdaxcpbDKXMFfSy+kC2oJpKAAGY5AhEl1hY4X+AwljWn3L4n3mZcE34WTMxIeV30qU0eg36hrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6648
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/tracefs/event_inode.c                      | 761 ++++++++++++++++++
 fs/tracefs/inode.c                            | 124 ++-
 fs/tracefs/internal.h                         |  25 +
 include/linux/trace_events.h                  |   1 +
 include/linux/tracefs.h                       |  49 ++
 kernel/trace/trace.h                          |   3 +-
 kernel/trace/trace_events.c                   |  66 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   4 +-
 .../test.d/kprobe/kprobe_args_string.tc       |   4 +-
 10 files changed, 992 insertions(+), 46 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

-- 
2.39.0

