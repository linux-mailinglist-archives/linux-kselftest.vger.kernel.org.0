Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC17BBE3F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjJFSB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjJFSB1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 14:01:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE1BB6;
        Fri,  6 Oct 2023 11:01:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cbt2I006021;
        Fri, 6 Oct 2023 18:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/czMuQ6hMH4QeiZ7lcsz7mKC95Cguxk3rp7VNIM5q+4=;
 b=wclL4SkSsoC7NxmqsIXvjn+BWT5/GZs84FZ9eTZkyKcqL20CiKkG7FZ25YSgG1KmQn18
 ksHKfTAPQAZ3xlXWh3PXkezqj4A0Z8Qv89etF+rs9GdBcsMwUqXvf6ZruUgOHXIokzoA
 4gSdfT4ispkkT4rHrnDBNM46ZeZ9mseeUow6LZcNhlyJll8QBeu9l/oZDd4K7/0du5on
 wL/laGqpM6DwLY6jCWCngYyVe6pPWJE1Bdt/3qFJtyLLfJUI6fBpyq2XtBHp6KoQzr5S
 VVXpflKSJw2B+QXuXJoMV1qDdfS6c47NHOKBD0VU0oylD4rC4aTBw5aWxY3F4lUIOmEc Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9umgyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 18:01:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396HQugC002971;
        Fri, 6 Oct 2023 18:01:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4ay08d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 18:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8LlU9J1sdg3lmw0H3d55TgbP/mW0feK5khfJxcoeiSAsdvNj7HvCNItSCXd2fqzFmwcSXqSmSC8kAk3cJxAXk6ZRvrFTAYExmBPM6r+QQVMA8alxY/Y2gvhU+caf6tXkPXX5aaEsAl9aP7nf+74XgbuN7FJkO6FEdWoS04wVu9d/wqxO+JZSItKVp6wASOJwyoTJJum4eFwObvBwuBdP0ocLsxqr6F0bNydkrI3tKDjdp0E6Upga3eOgfZ9JQD9tlJKIOXOZ29bs/r8cq6S2MTQhjccrLfeZC2tBVrwjbb22SlC93K3WFcSqiARpErYvyrF5ErSq6I/BVoY87++Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/czMuQ6hMH4QeiZ7lcsz7mKC95Cguxk3rp7VNIM5q+4=;
 b=j8HmvmvZb/gsxa/badCT2d0rpA5EZzrvv1Tgr1i9CSy9ypWRnmY4Ju7oQylm0She+hihIlyw7xxmSD2Poc5BFfevNhBaqgpkkZaKGRMbFtvN/YWtk7FmmY/V+DwdRPwDUbXM/TQd7PcNOdXBNfvYmsVGWDBTehZYSsEZm7c9upP2R3GJ4GJGAT/IL9XG6Ob5aHO7Y11VHMGIGZOn/yR7ETsuxbnRcnLP3O3HIn6sRx4GMafWLEsrpiPNvJ/r96+JGDy68fmKWrjRdKlbefWq8W9RgPIw4zafH0mha6eS+AT+ijYN+VJMUk7TbjFWCSUQO40Fmwmx02aC6OO+gMSsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/czMuQ6hMH4QeiZ7lcsz7mKC95Cguxk3rp7VNIM5q+4=;
 b=Zx5155HeMl1Vlr+YJAXLg+WycQvc/uT03iiWdaxTNcdjKfkQRqfwgpujvjtCplFm0XWcV8G/c7hxiNMgoi68kr3VOhoCU1g4SflzsLJPCYT3TwoOZ/TKyJYHsux7GSQNf3JVjNH8OfrVasa7a6uDwXZ1w/KSXlbC7S69saMghw4=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 18:01:09 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::7e3d:f3b3:7964:87c3]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::7e3d:f3b3:7964:87c3%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 18:01:09 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, seanjc@google.com, dwmw2@infradead.org,
        joe.jin@oracle.com
Subject: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
Date:   Fri,  6 Oct 2023 10:57:15 -0700
Message-Id: <20231006175715.105517-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb5fd13-860a-408f-c843-08dbc696383a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z0j8or03luT5Kk367Ae7aINVJHiZtqXrBMGcXJZlEcaeGF/fxEysrPoCYubOxR1yRAn9a6K9KARNmVxJ+vkJtfz0Yn/Fex11MJFlCDXEXVvh+jseSzoihndKwbKyjJR3nRkX3yHG1YUNUXytpbNjGohmSnIQVpVhS3g8rYhkdDumPSow1zhX/YCJUCbt6OgrG5w8+EFUqZ6lui3AuJNb6FX9TKrEmz2AmEl5oce4MiWiWI9xo2ViSQMPS59McCiUAVLtKsn+cRqr9i37nhrNff87cBNsHH4eKYcfWsmAHlskYUg5iQMWzb0AmeakkeTE8eHXK1WdNfqE8nKd+dcimxBi8E26/oZ02q916hSLeDnKtVzFFDbgnSFTDswsQd4IGyGpja7At7gd53xx5g7QQEEtqSy56y1tw9y9KRtczyAxd+vgTh/hiIqgHHmHFNlPHH8SuqxxRcEnlCnFsWwoF3Us/dQIv0dw/RbVhqvXyGupVHFuU0LTDkl5T+ZpJ9GIqLlJKbrUaYQBluBlwOKa05W0kbOWQPGuec3LlFshWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(6512007)(107886003)(83380400001)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(8676002)(41300700001)(478600001)(36756003)(966005)(6486002)(66556008)(66476007)(66946007)(86362001)(316002)(6666004)(6506007)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHh61IZM76hONpI9Ajplqt2Jzecc+EuaOAMoHBegaGAKp+ZZbUD9YOJC2dDM?=
 =?us-ascii?Q?tR74D3Han4rIvFtVme0Wml7EWYsFYY4nZQf8NevJDv7deOdd1DuZvGQQ6sBJ?=
 =?us-ascii?Q?4E9JrRsq6WMpHFKWzJ+ZnUQy57+g1Zhv2C7eVx/xCX9COTARX9BHOWf1SQvG?=
 =?us-ascii?Q?NQMoOUNsgG6ThQznewYGYddw+zY53XRw7AEd8s4odQjRCyUWFbuAlhMtxNC+?=
 =?us-ascii?Q?MyByCiCn8C4BfEctJc6+ITuIIaC0nkcMZJgWIuVD9reTORCpr/GZENsZY+a/?=
 =?us-ascii?Q?uSNTSZRcWGknnH4x/JZGYcLXjb8eC/RfypWynBKuBpGBpX3X/DjFS9NIZVlp?=
 =?us-ascii?Q?uuwki7RQmEqW937EDymMn1FAFbIz8EvrQxNy/uNyK2GfUjDnwxHGamtYZxsq?=
 =?us-ascii?Q?NdSVErFzA5YiJOuGm7rjXZesk4rWqIWi+vr5hp/L3uJRKdO0geSW0GBBN8eW?=
 =?us-ascii?Q?fWhJjun8nOeFSPfxDYrqS5CbUB1YFjwN9NYlayywozl8GgUONyKGx2dgmnII?=
 =?us-ascii?Q?kfcoN/9Hz86mXvC7YSw4szk9lhN/6OTBq6gsU2YaIVYXT2s3lAXXKlmsd6g+?=
 =?us-ascii?Q?8/FFBd36Cb9zddO2iR0EbwSTgmox2rOgaQYZXZAeX95Is+PQaKXAHVOF2haw?=
 =?us-ascii?Q?Azugu7ZqAZKXVWmHk/nwepglFVaAm3UL13/pHYEej6IBBwnc1jC3OtfEUQH4?=
 =?us-ascii?Q?S6PU4Rz5XIuwmefCsw9QXvevaer0OgbppVt/SVfWUwb3Ss7me+4AYD8d5Lzq?=
 =?us-ascii?Q?21w0M34+FLkIJl7MXshrAIz1riV9WSuIb5YhiVtQ5Cp5ObOVuGAxPXYjEXfk?=
 =?us-ascii?Q?wYxSqNutzLxKYuuDIilx3jeI4x48CK4P8R/hMIG/dCYQKaYIFTSCbNvv1ALg?=
 =?us-ascii?Q?zap9XFGexkS7/q2fBXMwzwq7t8iL6/VRPtl0dm/dOuXc+u+Y6RV3vcgW2EB3?=
 =?us-ascii?Q?WZG2djIU+dI2rUL2Bn9YSikxf4cZ/6bLRxVSxmyApguPPgfIeZgXWCkhk6Ku?=
 =?us-ascii?Q?0M2VMqn+WvNK7btk8e9B5+jXs5wHxSbySpi55m4vj7tbIwmAdjIq/VP430sI?=
 =?us-ascii?Q?TdLFTnyqx9OL0YzatEVeYArruzpDNwhZ0Lcdh1p6Ng+IMnKhObHbhaUIzzAq?=
 =?us-ascii?Q?09nJ6zf4F8SktxF/+gulWjVaTUv/BszZZQ99s0yjb3SWLybTl1G1AkBUe+gA?=
 =?us-ascii?Q?3oVvvzOpkmZfDKpq60haGDTh1dkGZvWAaQ87DfSuyxra5BkYsL0+aOreOyyO?=
 =?us-ascii?Q?ccyvN4Fo7CTcLu5SgAIS/umtf/fRjfY2A96HZPBL2+zw9mzkYh36pJdojvna?=
 =?us-ascii?Q?XMF7z29noIHB3w5OedEWCCo2/FHMe/74P4eu9dDzDAJlzUySOoNTWdR96lbj?=
 =?us-ascii?Q?+srJjX4FbjpQ9FbZ/5LZJdqncOdg182AV+mQ/O40EbHRiNRunBUGmoCZPzuu?=
 =?us-ascii?Q?MvJDO15SmvgaeQ25FeWPtv8WP0X7UHaiQFHbUddKJcDtKpNe+XZ6xGDns2C2?=
 =?us-ascii?Q?2X/S2j+HMCQHlzr78HuPXA7OeViN0UYH7wCGL3un7uoUz36QSokYTaEJbL9S?=
 =?us-ascii?Q?JUHvzO2guyRoU6IRiZPSFArRxJTdS1DTg75yHqIp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: erj5bWSbA//afUHRWZVXt5j7YlRllnjT1w99Z4SdLfg8fYyJZnCDjukO27FwWQOQdGRiMw8uk3JDBPZJuph0a8sqYt+Z93LXFXJGJU86ISWPpKVVjVJPhyuGUvfYuoQeuz5WEl2VNTZGiYHLAR96Wr/GghVvHnnQxIzAIuPnUiLo4Mwr+79FWWu5GpD0qH/2wbB+n/0PrJ0Lvy/btd2xKX9gcFzXxOER0Fk/B6xGlQykN6NTCsHZAfl6yG4sRTkzFb4K+ibrYSu/n9C+Mzbq7SCH2NG/Xzxp9X5C4WMK61Nlj5aGyglgirAczPV5a1e9HYP/GGLSktsdracDxpwpEivDkcKTEkH8HWBn34LEJVM5Qa8DsXcBGD4vdyzJR4fjKBHkyN9NEL8LoOP8uIXRCKhTQT791NWoy24m93NIbORgy0QA50gvKGLzObjin4zSdAGc0CIBpwvoC5MJwz9SuS24BiMcdyD/Pa6u0V6Yx2I/T+7usBKh5albwWecNKyoY3G6egmY6PGJWViIEs0BZP2anPl4XZzzrMmlHboY3YbNU8Vi97XXc8IMtIeyu6Sn536oHqBKM5ZBqoi5fJIyxvi+XYESwHwrBdWwbG+/3GwyP+zcyqlSJwDRBt//WdmpkEP0/Al1lM+OL7Q3GbP/ITr8AUMPT1p8H3TkibNeMl2aGMBL2OB7rKw4ksmCyQSgA1EEzbyG08QuMDm7OKnVuAG4P+NzNeQKGLoszV2+O/JHLNAYkJei4tRHDfVpr1bBshG8m9EWoAoAlfNlypuZxWmIAMmjLOUxKdKadmdK6x0UaZloQwpQCeJ0lcDrWAL5ITjKQ5vcmdIdrTM6CKxWOoc9H8RMsPidmu3a/9DRPlMJl9Z7euFUX+AozbEa8sB6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5fd13-860a-408f-c843-08dbc696383a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:01:09.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6VWGu/OTIsBI8bkW23O0HLTELEZTrUY2WvL0aK/DeJCPLB7bGbZvPD4PQx6wxPYCBbqdqOnMInduR7KNCv/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060135
X-Proofpoint-ORIG-GUID: ZQm88UL7-tVL_eX2O8iPIJvQ12gyZUW1
X-Proofpoint-GUID: ZQm88UL7-tVL_eX2O8iPIJvQ12gyZUW1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As inspired by the discussion in [1], the boottime wallclock may drift due
to the fact that the masterclock (or host monotonic clock) and kvmclock are
calculated based on the algorithms in different domains.

This is to introduce a testcase to print the boottime wallclock
periodically to help diagnose the wallclock drift issue in the future.

The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
wallclock nanoseconds immediately.

References:
[1] https://lore.kernel.org/all/20231001111313.77586-1-nsaenz@amazon.com

Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/x86_64/boottime_wallclock.c | 100 ++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/boottime_wallclock.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a3bb36fb3cfc..fea05b0118de 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -60,7 +60,8 @@ LIBKVM_riscv += lib/riscv/ucall.c
 TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
 
 # Compiled test targets
-TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
+TEST_GEN_PROGS_x86_64 = x86_64/boottime_wallclock
+TEST_GEN_PROGS_x86_64 += x86_64/cpuid_test
 TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/dirty_log_page_splitting_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
diff --git a/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
new file mode 100644
index 000000000000..cc48c9b19920
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Oracle and/or its affiliates.
+ */
+
+#include <asm/kvm_para.h>
+#include <asm/pvclock-abi.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+
+static int period = 10;
+
+#define GUEST_SYNC_WALLCLOCK(__stage, __val)                        \
+		GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
+
+static void guest_main(vm_paddr_t wc_pa, struct pvclock_wall_clock *wc)
+{
+	uint64_t wallclock;
+
+	while (true) {
+		wrmsr(MSR_KVM_WALL_CLOCK_NEW, wc_pa);
+
+		wallclock = wc->sec * NSEC_PER_SEC + wc->nsec;
+
+		GUEST_SYNC_WALLCLOCK(0, wallclock);
+	}
+}
+
+static void handle_sync(struct ucall *uc)
+{
+	uint64_t wallclock;
+
+	wallclock = uc->args[2];
+
+	pr_info("Boottime wallclock value: %"PRIu64" ns\n", wallclock);
+}
+
+static void handle_abort(struct ucall *uc)
+{
+	REPORT_GUEST_ASSERT(*uc);
+}
+
+static void enter_guest(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	while (true) {
+		vcpu_run(vcpu);
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			handle_sync(&uc);
+			break;
+		case UCALL_ABORT:
+			handle_abort(&uc);
+			return;
+		default:
+			TEST_ASSERT(0, "unhandled ucall: %ld\n", uc.cmd);
+			return;
+		}
+
+		sleep(period);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	vm_vaddr_t wc_gva;
+	vm_paddr_t wc_gpa;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "p:h")) != -1) {
+		switch (opt) {
+		case 'p':
+			period = atoi_positive("The period (seconds)", optarg);
+			break;
+		case 'h':
+		default:
+			pr_info("usage: %s [-p period (seconds)]\n", argv[0]);
+			exit(1);
+		}
+	}
+
+	pr_info("Capture boottime wallclock every %d seconds.\n", period);
+	pr_info("Stop with Ctrl + c.\n\n");
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+
+	wc_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
+	wc_gpa = addr_gva2gpa(vm, wc_gva);
+	vcpu_args_set(vcpu, 2, wc_gpa, wc_gva);
+
+	enter_guest(vcpu);
+	kvm_vm_free(vm);
+}
-- 
2.34.1

