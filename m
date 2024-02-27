Return-Path: <linux-kselftest+bounces-5465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672E86867A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 02:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310C728D73B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 01:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4CD304;
	Tue, 27 Feb 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fDGNxsiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lskh0tOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6C6AB8;
	Tue, 27 Feb 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999147; cv=fail; b=pNB7o8UUeFJb5C2JEaxn/8KuyY6SSB8CJL40hiMzJVtWByiXKIdlsEHPV+MiPvwpgCfM/YhXjMWLu6Y+sXtZ2TBgffmdYPgPGQK48luYDTLLn2jJ05bV4LvEV7lf9bCoo3HTdq7UKonCBUZI4hVRkqq5dMhbudh5COAvMT/gtoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999147; c=relaxed/simple;
	bh=Z+Hh/3R/SPgtMhlGuCm6OtBnISmR/xYzP0eOMhHe1b4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AU4qqCI/lbCpRPqoXBSpHG0Sn8yBFhPQ3HfzqqYBYkV91nos9ksOqo/RXr7t8L3UA4TPyp10nAqkLTIcmX64keEVcXMZod1/X2rSMgrQa4v1C161jZW7YYUcDI3hqQk9MEOLZdfJ8Ayq+PUurl+oInvHS/ZGO583Xlaw54Fws5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fDGNxsiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lskh0tOK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1DvDj023336;
	Tue, 27 Feb 2024 01:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=fZjbb3To+jkdUPNxlC/KxPevEMmwYUi97gI4Utag6rA=;
 b=fDGNxsiuNtHuiamvIkrNHE7wHPNm90Gi/m6bfNztPc643kbR9rT44xftJyZsP5+jV8dn
 HEMDpbFMHFcrfZOKqy2Uui1OmW/qUztQdfmT5AWImdux06hrVdMdaW9ZuKylStBiYn0+
 cXoC9VpztCcFE+2eVYpEKwxAIM2/ajFdEMU6WRnIR5qE/zyDDT4ewayXHgD7Z53XO/6u
 uS3JOePN6iMF8x/kwUWTfEy/CAQw+BKuSfEt2s/M0YWq7L68cYvSstmrRyMuk+zwHtsQ
 K00UetcniMm8CAbFpWbt7X0n6JXhXkuFR37Kp25j04d8RgdYHFjwfI87w53cRRM1j93E +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784e50n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 01:58:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0RsYR015274;
	Tue, 27 Feb 2024 01:58:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6pxh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 01:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl6m8+hnSuU+BwNJ1+fwAiUrxXC6/3GxmxGeTkUUUSwyRpxszvhra1l0xTlG5/c+J1YY+grebP7O8PS21xU/RHuTRw/Bpj1mEiqY8/WjQK5P2uvoTR/NlQBuicAGYpZlndvah8C6kwMTLcVCr/cUM1WbxjBR29bgM7MPZBIPCxa15ZJcEcbbsS8Nmy18J5ZxoPTLX/oKIE1UzL0T3IowaqD+A33o0fhzMg2pw2eG6uGVJGnwHe2YJKvulM4U75fxAvfYH8luQ16QEGr9tS3R4f2Hg6Bvt0rAqQweQih6tKcHR2oz36LVUUuYtNnB4fUUqGd9GVbmUyiCJbgBCqIDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZjbb3To+jkdUPNxlC/KxPevEMmwYUi97gI4Utag6rA=;
 b=es+AGi3qxldLO+KuIM6yr/9tPEY1ze6PH7JRNwnviSGcRL5lIcndATZ+EKa0XEi8aLxhWIOVsM7apiNa7T+MMrdTBcrYnfZQY71k1ktQBm4NZYTqi4bRw1Pj5zcx+/kC4HjXlMPIiwbTDfdFgr1Kzz9Cqrv+Xd0Z0v60qcbMDaZ9s5/Xcg/OucHgvrWgvyV7h7CpJlOtRiA1ah3ywT2fHkrYo6UgsbaaRfrVsbhELSVqtUZQM4Qmd+UkPZ0cYiofFFnC7StUfl8lMHHqXus6O+/7JoIDH8vrJBmZR6oaEZj1uQ3VO7VN0+5oGqhIkXn52PyGLeml8Igeen4iBupF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZjbb3To+jkdUPNxlC/KxPevEMmwYUi97gI4Utag6rA=;
 b=lskh0tOK+3eOYfWyCrrqOn9T0aPw+4bwFh8Stg3Ef3+mJmLSCYOUa9+L5oO1IFKPLNwIdcUCQ95Nbn+bp/m43tKVYztSPiWZaLKx1+Mv19sTNgzjhxvBEXqtnxNMY/r7GUzTnvdX3i/S0th4vS1RnsJ7EA/fmGO9f/++ZAMUGio=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CH0PR10MB5340.namprd10.prod.outlook.com (2603:10b6:610:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 01:58:26 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f%6]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 01:58:26 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        seanjc@google.com
Subject: [PATCH 1/1] KVM: selftests: close the memfd in some gmem tests
Date: Mon, 26 Feb 2024 17:57:16 -0800
Message-Id: <20240227015716.27284-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|CH0PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f33f336-4301-4cff-4181-08dc373795f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GAgrA+y4qgdJnm7m+8NKxHgRrUJEZyATv+Axb64Xav4zZjuGVS4NPQB+uoDP6bZdpyTc6ju6u/q+vOqA7HAC9qa1Iof5IR0cc5+7ER3I4RqJuhjVAOgJbwQ6/pSXKOTywx11T16I+PYDmosEcUVxYJcwEvfuTcNbjoz4EnqiRbzNGOrnYxlrN3cWFQ4wgMEwfEON3exPhEx8s6+5iaNWOoiBERjvPOEyTbbQj07YIBSIMdIeUxfhzym2l9SsLuSyohkPKonGE+hdv7W8Navu5DbcG2Clfnt420Bn+SfgSVTDNgZw1F93tH0aU13HRv4+8+36OwjM30B0y99QU5If4sVNhAfPaP8gN+b0aLlAAPWNPfosugHoWaF2uVIhbdKZ9AqC5vbaGD5cm2SC0oMsPXmZDwJo4R0T2IYkyDcWhiPS9QM9d0WxX8KfFdBkmfkDI4AoWsQ6Q/pkY+uEhd0TuXFk4h0cQ2ChCkYKdWupFVry2Id3c5OUiOsaCwTkGXR+TY04iKrBtXB9jsyJEwegMS6osNC2LFUKELO4Gabd4apTRmMq5mZrgubFxWMVsUqY9yTOj79tUTAKE6rX+wcPPyJ4GpGIP43cD6TG+kcBSyAX4ufpoi5Ew7YGMvXTxKVJ0Lk0z4bI7EQweF/sCHpjOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L0EJoQLhXoohwRRN4OQMdikC6x7ovYMqvO/r07ObHWrTmhGqVf4J3W8W2cqi?=
 =?us-ascii?Q?U73LahfeY6yaVCBoXEVnBiLzM0FXA7CcejlX7rYUyW2UETJ7bhkfeukFSR1/?=
 =?us-ascii?Q?Gkpwe8meL90NmH0xpv66pOyfkB5AqY4TlkA8dAcoCCPyh82aXsZ6II2ZaW1D?=
 =?us-ascii?Q?dISh570CxhqAraDUns7DVdbelDZRX1wVPQnUFZe4upoYGY/Zsz/qZ+qD4RCU?=
 =?us-ascii?Q?R4gJBcvQl4ZterT11F98kfSBeDm1Pxp0QzLja6L8igAvcTWEHegQOEyBjbhw?=
 =?us-ascii?Q?+81cLH3/YKCb3pm3X8nFOmvOGU9mNCMEpc2IpO0/KQpuhvBUBtux2zzVG8Nk?=
 =?us-ascii?Q?qe3xKqf8TnPgYpUbJ6/awRAgfYFjkCbY2Cia5GJKV5skK2gL5KVVOTjBplvz?=
 =?us-ascii?Q?YUWOdwM+XfwjHKWTfL5zUrzWf3CS743w3rRpzDNtTKQ8EDKFGwEEQwxYNYfu?=
 =?us-ascii?Q?8xTCEiDxE+EzJvMbYuJLaie5n0ixHKKEoasiXD7VUk6tijxYtVl3qLIt9mMH?=
 =?us-ascii?Q?rYTawjOUf+oGex8p2F408UUUHIMVtot4LVd/C5ZC3ozxVMiHNFGn9BjNBFc8?=
 =?us-ascii?Q?GNgyFQfLbOICGQOcsn1mMctmfFSPFVqTOwCrtnaDiqdSlrdksMJQLpj+/65T?=
 =?us-ascii?Q?z2/vPJjmB9NFnc28c0b38ivQKGljzQpmoccM2PF0+5tJSRXmDR/GfLO86spR?=
 =?us-ascii?Q?y2J3JfzHBoBtiWJAEGOvaP+ZSLfs65y66s8181zkapfxa2It2jsCZfIri6ao?=
 =?us-ascii?Q?zOaHbMR+pPDZ/SM4NOq7Uxx3lhKheHgpkEQHVrlsmpcjCKDTVgnBcstHo/6/?=
 =?us-ascii?Q?KPjvus96kNOrbGdKKsml8/0EiJQxQPKVDfGuV3AVvgvxMppN9t4Er1ApH1Cd?=
 =?us-ascii?Q?gh/W+dWk8v0TqAD0CawCbVX+zybbKspuu6VwbwOpvAdt2L9sYYRZxCF1sQ3v?=
 =?us-ascii?Q?dpbRoQ/8XQ1GB6dc/6sIitgFQCF1Wg6Hg7pGSueZ+LPVzXajpC2ZEthKyhnM?=
 =?us-ascii?Q?Dz5uJJAc3mqGyC8PLnum44z0hUrfR0kt/plkLmwwQOG9vx8ZxWPrQlYaifOL?=
 =?us-ascii?Q?Efv5/je1Oq1SKcHnuDosP8LvGpXHibp5E1LmVzAycKr90+eJrnNt9NHIXzQ2?=
 =?us-ascii?Q?8kPsmDuctuKHzMK1CHb3AurR6gA12Fi7YH6mdlD6MDEdezPIwYrFdKL2OgXB?=
 =?us-ascii?Q?d6G51bLo+s4251rjziDOYcVB0ZzC00jDYXxbmIG8sNE3Y7OXpFDL7HBv4RJp?=
 =?us-ascii?Q?Le1LV1ku8VrmaPxa023YEfsgrAWjgu8HRCpkHxe1n2rHp1yL0LJ7bYkY7kJ2?=
 =?us-ascii?Q?RvKVrRdBEeD4IyLjxKuM9wuBNL1zFGf9Z740z3huebLCsykH1CxWpF/kxmvd?=
 =?us-ascii?Q?j0fmGm0FMFhkDTW/r6I0QXQ5BVh038jdsG49sDIS5inR8rRPsvgvYzL2mChT?=
 =?us-ascii?Q?VIiL459EdNbyDoyIBNhiQA2X2UwBB82vx39+ZRsJeN09vAa2UEvmvZj5YBSI?=
 =?us-ascii?Q?ZslfkELZyQmbqRKDXKvlSNEtJdIs5huIVuRop4XF8NPVIwei3qah9HXSxep/?=
 =?us-ascii?Q?bENBnhu+hmGi3k7hAz0Azyuh4U4phKuKBmV5iOwi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6dd9DBxq8CngAK5O5H/tIKOKXyAAIYGnBAbqGzuqKsr5rmdiB7zrkeFO8MP5cgv9y/VXTfeqiTBiOMf0+k6XnMv4p7PuNOUL6yk8+jZ09gb5fojQ/gDm2c+FZvtJOQjml3qPmJ/i0w7bZ1MebIVyBkYFbULYz/55lN5V8Q0BbLwSgZdWs2z+9Md/7CZWz6NGkqQ9kKgaIVEwaEmsnBqkdNNbFfr/WesQ8IJUA4z4QU6OZ27slHJIrXp7EvFHKMZpngthF06RV/Xya5gqe97ecizRZ+tqw//3HKllxMhLKkGso2EZhpNTt76trlTAYxV89VHUvno5X7HYxDva4Q4u0OF0IxlyVHwS3sHK81Cy5l7NHT6yPp3+Wrgmqwj5Fyfr3iQw29YpdfRNnzjKjbFF9ORGRmpl6t3r/ck9i45fv82x+8Ty7bWUqQFVD2FIhuXNqRVxBg25xr6vXT8qn4pp1JPKsL+rFJk+JdvwCdh6YOFzo7g/S3pYyeE9t2SnIv62m3Bytpez9iandKLfAskNLclefRl52Pq9HVg2eJwhIL6nUzKkDwHJSGjJJIafw4th7xdABa3lKOqbyhlXu8AaxISVHrnb4cDxsiPm/2JWzfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33f336-4301-4cff-4181-08dc373795f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:58:26.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrARC2uGB58g6RspEmffP2AVMxFerCS40EH7dduJ+jSrgXFpmLXtXUO+JaCZjOuqLnv538v+7HZqhYP8fasMGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270015
X-Proofpoint-GUID: cJsExeayTeOEGst9XTOyIQwWV7YCfHt1
X-Proofpoint-ORIG-GUID: cJsExeayTeOEGst9XTOyIQwWV7YCfHt1

Add the missing close(fd) in guest_memfd_test.c and
private_mem_conversions_test.c.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c                 | 3 +++
 .../selftests/kvm/x86_64/private_mem_conversions_test.c        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index c78a98c1a915..92eae206baa6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -167,6 +167,9 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
 	TEST_ASSERT(st1.st_size == 4096, "first memfd st_size should still match requested size");
 	TEST_ASSERT(st1.st_ino != st2.st_ino, "different memfd should have different inode numbers");
+
+	close(fd2);
+	close(fd1);
 }
 
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 65ad38b6be1f..e0f642d2a3c4 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -434,6 +434,8 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
 	r = fallocate(memfd, FALLOC_FL_KEEP_SIZE, 0, memfd_size);
 	TEST_ASSERT(!r, __KVM_SYSCALL_ERROR("fallocate()", r));
+
+	close(memfd);
 }
 
 static void usage(const char *cmd)

base-commit: b82879c81b4f09d040e365f9eb7ca036d86dcdfd
-- 
2.34.1


