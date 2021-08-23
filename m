Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC33C3F478E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhHWJb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 05:31:26 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:17888 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230428AbhHWJbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 05:31:25 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17N8Ydw9019149;
        Mon, 23 Aug 2021 09:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=9yGBlhSuUmGdUrgZpZmGv+EVUS6u9FxITTbXvB99V5w=;
 b=ghIqC/SZAs+iGK5mzHxOO+XEgVr7wz4CEo2tQE0Vb6+zwliXUw3VtVKFf1p/nTFhcI1j
 EHqYW6nlDU0T5J7Kbfn+eA0GImfpP/EFBgoPivZX3cK7jJLo8KWgADGFLp/x83wf9PD6
 DBVsD2stF/WqMcBRgXZqKN1qe0UroeHafAkOZVgZRVXwvDPnJE2udO8tUyYGARoZOUTU
 932PnLR9kP95e9z9VisGo53puiM9a8YZZhcSych38Nm1vb7zwTATt5J5boMX8jtwSpK+
 WBlYm5xsRlQ40Dk+d1rAa26VMSIBJOBIYqGz4S10xGutcX65ghbnRfLTnLAK42RbgT6J qg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 3aknf88gf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 09:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRStZxDGKfkGjIOg4UIketNwcd7NLEU+EfS6PfXLalkh5jQJz1qTOQXkjsLUheld0vZbDbioj7Q1xQQMWCdm2txs8kUKXZzwRlVx45kq0qbtaxOrb9RaYLNQSch0FeNAKIh7vQEobqULfevWglZRz+8r/gVO78vhDUAVojQgwh6aNWQMjP94jESPK+pQ5r2dn4LSr4fRyu+818lCxpO64tG6zNAgnNlJqN2irVaOSaL5fGX18FKsj+oQxlPbTdEaAH/UciaICXiIqdpVsrPPujoTXODsnvAc8XQmHmzP8U9o+2QVq+IxylTTj4EdTKBSUtW3kl6sMM9PJSD6DOZHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yGBlhSuUmGdUrgZpZmGv+EVUS6u9FxITTbXvB99V5w=;
 b=U8Uu/mbw1G93iJA0d2DuHLTYB2WigT6l92dh9W4oADNGpI+gnH7HwQTt3Y+gd1Syyo6cg22ypV6mwI+mAM3zqiBcNlzyKaqPauL+0uCbpsqUt0HdthbpjzMQALfA8/vLiwsnyINX6bxBu1+YVpfnbeoo8U3u8t5hFeg8G0IWzQ/L/FjtevmWhJYer4PUz3uDW14FdHUm20yQBJcU+sG6RL+P8kC5M4UVdwutVBiIAv0Rx5iufsNa6Oo+waNzbVaZ70Cjgml4F9BaErWFppw9fpCUES5MsQNwAKtIUmGtJH8VTOyuhAMfs5ymWm05rsaaaX2L0Jsa6rB+qepq1pMrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM5PR11MB1513.namprd11.prod.outlook.com (2603:10b6:4:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Mon, 23 Aug 2021 09:30:39 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 09:30:39 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, jun.miao@windriver.com
Subject: [PATCH] selftests/x86/sigreturn: Fix error: variably modified 'altstack_data' at file scope
Date:   Mon, 23 Aug 2021 17:30:26 +0800
Message-Id: <20210823093026.3839645-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 09:30:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd09dedc-0024-4dbe-a452-08d96618aba1
X-MS-TrafficTypeDiagnostic: DM5PR11MB1513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB15132B662B0CF94FFF1875778EC49@DM5PR11MB1513.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btu/HsZzXz2Mf94a/UGBN+KJqJ20xSF/xZ6RKfhVw8T+bKJ++WK8ONGvi/x5NclO2waZ72CPKbgNe+pE7OMbKvyJ2SgklDRwmRMmbA4+ONeIgXVcLrQtKZyUEcPF7brnFzPcyzUL2c6XRWN1unUnZf7INhhwk3sQFTNcFfDqgiOzs86RYfXkQA8PEIATblyxnTUK9/emKex7zqNFMFl8aCZaQo8PFFGOVhoTZv9ftbkH+jfu8rdGdoDh7olgb5lT1R0aBaVZvTbOI633lRyU+iqkClrWhcyeT2yVeFwCjnepkbsZOoTWfVLOGwZtTezqGlH3pWaYAtvh/pj6SD9PWb7+LSVe6cVHkscnWocJGcr3OqVOS/PsH+MVhl6mFrqlLQbqIXjyuz35PpbOVH+BHRMgh7uEjA17yjdu9MZumJK7HXt66BB1VTejAGBlacLZmPFq4MBCedpRv2WaCzllnrm4QnzScjWGdUtnqNxUZ9oR/kjo05F5AFWOm6CWXatcHfB7D2wS9VQZTLeNkv+ki/Z4elkjOMoU1px7Z/7y6A9pfa1vMMDazb9/v//r/RGdWJV78Vm3Ws+93VFc9Ff4BDGZYpIOI4W7xh+NaH8WY++a/5IMLt76GE6BvgVFbC5uRviIxAtuaa3UbLB9+np2crtHU3wSFx9oY+7ZmrQCw8+RS0z/ahQgnAZ53rE5wAtmX6SbZaKihzAA6hiBiO3+IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(136003)(366004)(396003)(5660300002)(4326008)(186003)(38350700002)(478600001)(52116002)(6486002)(44832011)(36756003)(8936002)(107886003)(2616005)(86362001)(6666004)(8676002)(66946007)(1076003)(6916009)(316002)(66476007)(66556008)(83380400001)(6512007)(26005)(6506007)(2906002)(956004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCwVcUNJXXfUzTLHZb7D6Sk7okQvwdnr7Y+ns3dDAJqGyuopv2CL8gM/nCzy?=
 =?us-ascii?Q?vtVQ9hlNB0OjFtcc8/CWAU0gtpNXZE6bOjhNkDx7mCm/LyRc2Tt156FeWZeS?=
 =?us-ascii?Q?H6gAo2M9+iE+43/1GwtczyOT4np71nzeZqOKkz6R2aYgZLRvhabsGWkFuKi+?=
 =?us-ascii?Q?0sAwGG3H/pBJ26utX9iaYVsjDgbmljhitKdJtStr8kWc6Vrze0wdLsYqyviw?=
 =?us-ascii?Q?27DfpVtZJB+JvzkoFijvO2S4TFUkluyBeWeOC0A7xqVEdGdO8Hefgzu8DVZJ?=
 =?us-ascii?Q?fqvEKlt8s6jfilSGJNlBe8MAms3yggKJYOy4J4i3B2P+sh95O9UgVhEvV9qc?=
 =?us-ascii?Q?N219S37gyB8JFzuWce7AG2ESx80RMaqLpgzri3qiqKfV5PBcognZFyR6QOGN?=
 =?us-ascii?Q?EyjKr8naTfKgHro8XpnXFw88qLZmva1Hb/0UaB9IjkDqDjgDI0IYuKcUu2EV?=
 =?us-ascii?Q?fVzUDN7wS4lKkSRYRS0zAqylVl53QyUqd5s9z/C8aOgzIe1yUdducjGEDGsQ?=
 =?us-ascii?Q?gG/KQvTZj9GgPl37gye8Ee5M8SaTyBCDmwkFrpZAV38YhYdqsQYrlXrkg6Ed?=
 =?us-ascii?Q?D0l+5f0IPTE92XOlULx99NfSzkx7Ksr02zeCv3GzOQ/QHbrXx16K3jYOanxU?=
 =?us-ascii?Q?77uzf1fJGcqQAvZbhU7JV8vmZd2SeNhgeNaOhTvs3vHvAAnEn76NHS5NC/fj?=
 =?us-ascii?Q?ySdQqwyaBvBXPfmI8ItSMbwpFStRvG6qcgm26K0yp/tYaBytn1EQ93gF4bIq?=
 =?us-ascii?Q?XVSm2K1rUxf+G1tFqQS9ea54BKep/QwhWX3a8Mk5IioNWiP+3o12vnD8tZj7?=
 =?us-ascii?Q?Qc7qMiiulRTEBm34ZtnJAIV7JPXsR7kOtq2ZKlxNiUzZsT0rxpVV6VPu7Ewm?=
 =?us-ascii?Q?0+KTaEzZ2LbND3s9TxeSQH94njjRF0rv+wUfygRodYvPNFPQqXe2+Uys6FnJ?=
 =?us-ascii?Q?RzGHS9gBX/5VGfrEYdrvEXwFOFWGy7vDr4HKiCbuOCmHMnGHiv1ymU0EbiGT?=
 =?us-ascii?Q?9AmBUMvNL0Tnc2NeiQjCg9a/JYKxkwwUlOVwprsDRTpOGq+opJryXKRaqKDe?=
 =?us-ascii?Q?LgOluTTonINNS5w24eTs0731upWLR7nVqzFHJAPKVDpwPrNr8vrCNFL1xbQx?=
 =?us-ascii?Q?vpB00xP//nKYqWaSTsVsTI9zjbn17rylib594xzzwNRz+Kh7aoZAJr7KoxcD?=
 =?us-ascii?Q?18LbmHwzx2GLfAA5qcKtVRqGEBpITfGXr7L8hwQxD8gLq+LC/6mWym1B2yXf?=
 =?us-ascii?Q?2wjT3iPkY6huKSs0yoEq0M2aDItiNw3WS+t47HacFddiCOF6Y1P48M0T3RdO?=
 =?us-ascii?Q?RMYN8nquQeeVZraz2FR8cGx+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09dedc-0024-4dbe-a452-08d96618aba1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 09:30:39.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBtScYP5J7VBecPd1uYn9kZwj8YlhxkV65jdLhTDADVSvH8kDYg2vklZACG331R7VLBpB2Yz+Am+6IbfQECZhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1513
X-Proofpoint-GUID: INIVctpR5232kNkojlHHxc7h3FbN1Pd4
X-Proofpoint-ORIG-GUID: INIVctpR5232kNkojlHHxc7h3FbN1Pd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=849 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230062
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Based on glibc 2.33 -> 2.34, there is one new feature:

NEWS for version 2.34
=====================

Major new features:
* Add _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.  When _DYNAMIC_STACK_SIZE_SOURCE
  or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ are no longer
  constant on Linux.  MINSIGSTKSZ is redefined to sysconf(_SC_MINSIGSTKSZ)
  and SIGSTKSZ is redefined to sysconf (_SC_SIGSTKSZ).  This supports
  dynamic sized register sets for modern architectural features like
  Arm SVE.

Build error with the GNU C Library 2.34:
DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
|   150 | static char altstack_data[SIGSTKSZ];
DEBUG:	|       |             ^~~~~~~~~~~~~

Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 tools/testing/selftests/x86/sigreturn.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 57c4f67f16ef..e32ffcc7053d 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -138,9 +138,6 @@ static unsigned short LDT3(int idx)
 	return (idx << 3) | 7;
 }
 
-/* Our sigaltstack scratch space. */
-static char altstack_data[SIGSTKSZ];
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -771,7 +768,8 @@ int main()
 	setup_ldt();
 
 	stack_t stack = {
-		.ss_sp = altstack_data,
+		/* Our sigaltstack scratch space. */
+		.ss_sp = malloc (sizeof(char) * SIGSTKSZ),
 		.ss_size = SIGSTKSZ,
 	};
 	if (sigaltstack(&stack, NULL) != 0)
@@ -872,5 +870,6 @@ int main()
 	total_nerrs += test_nonstrict_ss();
 #endif
 
+	free(stack.ss_sp);
 	return total_nerrs ? 1 : 0;
 }
-- 
2.32.0

