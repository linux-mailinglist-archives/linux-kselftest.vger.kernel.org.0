Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0A719630
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjFAJBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjFAJA7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:00:59 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C769B3;
        Thu,  1 Jun 2023 02:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6PLOkxBr2+Z7KnCP4H4Bk7jaE8K2yM9Vpvm9QsACBDak5eLf5Jp3h/dlAZvQxjtFG8Ylm8A2cU1bDjbJkPTHfiMY2SVR5VVhL3iGB94SydUQbI6vPm3u+nKj/cEXOyEty5faTHT2LeuT+sPvR+GVZv+KHDvfCDrJi6OVY5Kp55ImA1gEGP+kT5Y1N3y2NWBgHBDKh+euQyhICszh47ROn/yk0ZbGTS405JdhE/vDsdDzblpfHDM5wyHHg2n03jWVQr327wGbiHyG6mYcbgRFCzTWg8xClcBOHm5pj6qt8RzRL+Vif8ziw3B6VEvpOYmprACcymsoe6DcZzu2rxv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0XXlWq0uPPNa7k5cwB3q3MvwRr04OEmEH8Jz1GKZlI=;
 b=jmvLP6jV9cqLJW5Txce33p4kFBK3XRlWUDSMBUuhRcdza0SVJDNZN9BeSYWfNpZngYFHI4FRtwesQPDYqEkDj/2bcKeCYIz1gHCikOWvtjwbGfsUEL3N2Oo/HiG++O7QCEu5sJ53kMgdcpAg3EHPMoazYiEr/HcFefXqbXwhfQX5zvoQ9zaDyACyGQRJEuJAcYzBnMqfUPBVvZv8huN3H7VyjWnqWXRs/QRlTNTBw4btrnfYII0lWurx5JJjm/mgldC2psudkMXeGhjKhn3iPvBuK1CsVeL7Wo8ZyAb4D3wgWSS5cTA5bfz8prBmz+bgAaakx3+Haw6gDnIKwSbTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0XXlWq0uPPNa7k5cwB3q3MvwRr04OEmEH8Jz1GKZlI=;
 b=md4A3SLMa55BTUD3x5Xkw/Tgi8rc2E4zp0e7E6/IquAi7RE4Q4+044upqCaEnd1PdMKIn63/wAcNwqELJObejEUDw4zxbAxxII27CVNajykzk9habalEKaKDqHUSHxinC2Va2p7AWvDZ6FTXRG9v7H/VyofCYJ23D/c/Zjfklx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:00:54 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:00:54 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 00/10] tracing: introducing eventfs
Date:   Thu,  1 Jun 2023 14:30:03 +0530
Message-Id: <1685610013-33478-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: f27c6882-996f-40b7-033f-08db627eb4d1
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYUk40JpqhB04BaSzkI/5ajZ1ABLexttVUs33OMGh90PQZYQchk7iKWlF10Hat12rlksQGU/dw2xFNmjkbgtPOX51wDrRg35RvzaF0Ueheph8RbnMs4lSIArH3UMNyaHv0GKQPPRHyyy3lvKVKI7z4xQR/VeqOWL6zm4kK1D//0topqfcrgaSSfuS7fN0I94G5LgIpfoocDOdbp3ex2obqMP6DFAd+ipJwuKA6vTVTnG2cjNHTZK2GxVfGpStXEw0u70mbcld6qXmcJKyvQo/51YkxcnNf/9RAsScBnsS2/St6aEony7GIWNgekKQkiCpqedUF3Dvz0PDbqk+BvqNgbBuBBhOp7H8T/LP4VTgEeHF2reUnefG1AKY0k/kA8kIrq8Q2g1iMDXHDmGaGULjsFtlqNkFHBvzmfkfbT1mCljpimoa9nXLPwJG8dS5hn9FAv5hesfAfXvjPz/RFVc6NTpp5n/UIsCX4J0h5ZiE8g+IOb7HNTYPiNN0OKc+jxkCC4B/mY2cSLJrceNZOFADH/i6GK+MqJjfeh3ifMZ+FGvLpIDmyhmGUMFN2xAEG4g3FG4QiCmjE8s4VhdOJc+wGkjzUZ5qBQ4WSAjqCTEhNgASmlO0UcZbRPMzFFqdiMv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(6666004)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8qiBejyOGrKzvjlUnZE60JsNOJZW5WvEu/iBEbwdELwhPVj3zgZfb1Nas1Zi?=
 =?us-ascii?Q?bacQvDn5s/lVBbXPwpX9HNd0fdYU7Ep6cDXGz+LPp6WopvAWbXlhTSVXSznH?=
 =?us-ascii?Q?4yPQJDUn7Zq1rnLIw/iinc4rx7GCL2WEjZcoS9bBPbEE0CY7SNULLXq6tR2s?=
 =?us-ascii?Q?ob4C6ZxeQg3HVe3MLu3IyrbgczOoSiPYcH8WQR/XKTua0XjZTD/nMm+7IgM2?=
 =?us-ascii?Q?ZonYrjpLVn46zoi8ZpMqUjNn2s9JUEgkc4xdOyKl6mvAlMGgI9tlKlEoUQYO?=
 =?us-ascii?Q?cV7CBJL6OLpO2tFHOIjnw4W/yY0CX65Dlvr/ahL2jJsx5sKs1skDspb/OC+a?=
 =?us-ascii?Q?++f1RkDs0MoBSDWSIMsZoIv1Ix58+drGat4gyPvUkoNG5//6j2QGMdwG3LJ5?=
 =?us-ascii?Q?csPZjGfBDjPqsMTv/sVpqYSGkSdrQgpQTXsV0IR1LywaTO3gZiypSHj9Mtq2?=
 =?us-ascii?Q?8TY3T4Svh545xU6pFPyOhmez2CWHVYsu/6EF2j7nMC26T+FJkR7PC3UIMZ+h?=
 =?us-ascii?Q?yGf5vern0wQ2DGmvZIDOVQI82vocRIOcbbJe0iy7MHI3nHOQ/VZ2/4XV57rL?=
 =?us-ascii?Q?HErQRgFrErLB9J6Gf20PdGmNjVSyohLFKPGLvpBR6vDSreCa4Fs0F+nSGTAC?=
 =?us-ascii?Q?GQ9Ej9OII5XX+ekU4gw6G9IspJqSknu09iN+2YwVegIFomELWFGOOk3xvB/1?=
 =?us-ascii?Q?QxG15PWmpWyrjxEj73l11ywD+htELoksZmQHit0mi+vQKtmdpl8DF1dfFHYt?=
 =?us-ascii?Q?CSrMCQ7l8nnECztO9Mt12CCwK+9qRkTNd57IEyDf2wBzRzB9oZ8vdp8meaSG?=
 =?us-ascii?Q?UNPQFmUzIYYtTeE7vh7W6Fp3w6EjiWoYWIqvLNM6Rlv2ltFF8whP90aTKV5U?=
 =?us-ascii?Q?QOuv/Rbzly90bLx2ttu9UyXpT4ZQ9ZiXRfJfShotsCniT120sYQZIx1HDABN?=
 =?us-ascii?Q?bgnAk8XB/8DVYc6n67RxJN3qNWP8jg6vSw5/wgE2eo76jt4Vt3fbiOOobUwf?=
 =?us-ascii?Q?B34iHZ+joqPXMHg3ZZHh5XAqQ/mVlaLK+Lhg4RUpdGgkYSqnZj1U0saHl73n?=
 =?us-ascii?Q?devTrr8L2+ok7oOI7Owack16PSVD+6cpqlltLaWr9IRTxXmVXXSjRjGsdTNi?=
 =?us-ascii?Q?dcZYuckFoWlYFQrybYIxzQ//vo8LPEamVVujGOVXvLv2FN7zfHawNb/p6eCC?=
 =?us-ascii?Q?3CCDPc51BU+qp6P1qwT/lu+SHx/c8aVmk8Odn1frKd/+7NBKFAgmRs4jON57?=
 =?us-ascii?Q?psR69dVEeBnCs0Yh/3U+HwjW7kS77uKp6Ov+pA/J23hwMmTFe7QXRswJbklO?=
 =?us-ascii?Q?YzsrPY1jA8sefPzYSYAmFbd3Upq49CtqifrDxFdJ1hvs0xd0/4VGVlzq+cmR?=
 =?us-ascii?Q?7VGscj3rRgKle1dlffnrEG2sIz2c6DT2rlJSZqkwwZc2ElFl3KEkWPVlrZeD?=
 =?us-ascii?Q?Pt7HTIqTQFx7iVZ9BoWByWsAGqbGndz+7ED4VHUxWU2HlVm8mW6CJn3szNsH?=
 =?us-ascii?Q?flHiyzb98tqhaAzOFnKVBpkdqlEjIu2OsiIIYJ0UWWeOIJIFnWOeqaym83b/?=
 =?us-ascii?Q?fjaE3fuy0QsoRRum+/38FoUUlsEY6kwV7+kScj7Z?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27c6882-996f-40b7-033f-08db627eb4d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:00:54.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H70jLVt9kXIScuUAGou17hMqCdeg/SsgCbG0x1o/l7YgjSl03ErBQcZrHgfFk7DSkn2FaTFyOqCelz7PO0o90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
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

 fs/tracefs/Makefile                           |   1 +
 fs/tracefs/event_inode.c                      | 757 ++++++++++++++++++
 fs/tracefs/inode.c                            | 124 ++-
 fs/tracefs/internal.h                         |  25 +
 include/linux/trace_events.h                  |   1 +
 include/linux/tracefs.h                       |  49 ++
 kernel/trace/trace.h                          |   3 +-
 kernel/trace/trace_events.c                   |  78 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   4 +-
 .../test.d/kprobe/kprobe_args_string.tc       |   4 +-
 10 files changed, 994 insertions(+), 52 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

-- 
2.40.0

