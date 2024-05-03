Return-Path: <linux-kselftest+bounces-9324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4088BA600
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E556B217E5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73D27447;
	Fri,  3 May 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RdOl36pX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6A2262B;
	Fri,  3 May 2024 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709931; cv=fail; b=tzHvTYGPYh1/j7uLkUdqJq4wWIJvPs0pt32mPWw9aCVI0xOQeZKC1T/+AJW4A/Sj896X70yqBlGMPWThIizl7t2P+WNY5UX+l1wlhxifiDsjeb8zljgmZ86+Uihs57JmTKtMOXnP26V1cWufDXi1gsx/5BH0ANI5RGi14pLorKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709931; c=relaxed/simple;
	bh=19ETxXSuUrJd0XKU95rMF6ZUFCbLVwv0DzYZYrHG3J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiWH6nfpGf2M0yFVPiqoGi18IJNvSliuoNGRTeJ4q+uZdCCVPgLflU3ymdt/xjrH/KF0iO6xb9+nQbwVaxfhxGXDuIz2Npo+PTgkyT/VfTVW6EjtDkW/Tm/IWgc6WnC64QXmgSJgNY2ttpkFDIRPDGmvRVLSPBiC3OG5IQ0gJS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RdOl36pX; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj2WehV9WdpkMe+ZvTsVQRwWTxAN4BNRbuusWf2mId+wI1lX5OrpdlzOHYOnjwUAqqKV/dO66CorNqnojGMHvhrHKgC9tN5eNebXqDG6ih9YWQb82T5o4xsFh+h0OygLC31F8rumENFWq16icls2rLy8KYVykQ+34am/lcQIPf9oPa07tT0eRpUfyWYR09UNDWaRCqdkiYywMuN2fWNefDWBbuwfsxeDgtkIWqMOK0gTULPDRxka5RAz7d7d8qwF96I65cu/ZRERl47SNvEly5LqDGaZKVrjf+oo3br3ai0SU4At5wbcysl878qFj7K83BoYmnSWVuh4DJcTeOs19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdNJkkDWmSF/9/4Bo7TWqqP9eFjEwSxE1VSUw0HhnUs=;
 b=Y056GfWeMwGMcCGrgqOj5z7yU3wZ3oSBdZ/wsElp59O0Z42otCVbeEVjc6VQ169X3A1y+MBnc4lxeP4+kYHnmE6UwFcskXvOfXz7J2/qNDvZpx+s7QPadHBW+zKu6jkbtX+4OflEYhaNopGeVVl3EshFbODlGafoXPE4TxJ+Ht0qboRvPAipIwF5CwF8QdTD1Ug5fMArhqBDhcNx3XN1OVWMNJlprkLbt+fV2Xn4tgR96dokWjgCBJtvOR9PLBiFxD7vGExKilL0at6AGMeDY42VRyvGHgSSuHcPICib6gMlT11MwppVBsceIjcPcm19iE/n2sCz2EFOlu/oDjo30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdNJkkDWmSF/9/4Bo7TWqqP9eFjEwSxE1VSUw0HhnUs=;
 b=RdOl36pXUOgs7CAvnKNsVebEzUGDUn04v70o1xuyRR3YijhDwe37bG38cjBLe8thQyvCqxRUtuPOdCtqc3SCR9wNUgaSymjMroI1y+aflAg1lpq1NZPVqp1L2/uIgLleH7J8NSM786mhcNqujNaG8lGlDze5eYx9u2hzz61gEO0wzmPVweFeuQJIZFOUfM4iZIWVTN7q0tj1FJpXFQMoYkANMw2GUitwC7MXeqBLfHn88QG+vKOJfq2Ghk4oqh/6dQ/2eRDgxafu6FT42L+AzE9WaTUsJbEryECJz1NCjK8KZF7xBr9ffgRApyCUUUn0E7xJHPwJ60t8jB3PX3ruMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 04:18:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 04:18:46 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/3] selftests/futex: don't redefine .PHONY targets (all, clean)
Date: Thu,  2 May 2024 21:18:41 -0700
Message-ID: <20240503041843.99136-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503041843.99136-1-jhubbard@nvidia.com>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7d5046-e971-468d-ea0c-08dc6b28205e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JFTT8+gZuD9D8hyiiY3nLAapRCINV7iiiHWw7ULPepQtfygaouW1VlhXnO8Y?=
 =?us-ascii?Q?DouzwixBGH3OVsxFNvxnllsd52hmALwRI0s0wYWbi7HsSk5ZUaKQG+BIs01e?=
 =?us-ascii?Q?/5rO7jAUn6Rvko4s8HU7q64dQE507HpWuGwq5/urtRG2FtyXJ+Ao/cFlQUQT?=
 =?us-ascii?Q?7cEhyWV5gCbw5dNanARjd4mgipDKzZrDyG7B2rr7kQMjIf1Hu3Hue5DQFwCT?=
 =?us-ascii?Q?pEUO6ne89URgmkxN/wiLnz0BeQlYcTbhIJWXxLb98GwQZceJH0IaN1E3pj4J?=
 =?us-ascii?Q?+46e9cXGNOm1bM8dUXzBqRLCHVB9MgNf7a96VvnDwQ3D7yOf/Ir4sXTV8kK1?=
 =?us-ascii?Q?acpP2P28zAr0rShInGvssJXUuJUrHKTcBCLAFDdO6vWPkfucufS9AX0PWh1T?=
 =?us-ascii?Q?EpvJOArYOAWqlVHs8Rv6tBCK8JqgmByhlSqvNWPkyW/+Pq4t3BItwSh8pH0v?=
 =?us-ascii?Q?RDbZe0zhGa0PF2Zt55PCsGw5jx66JY7iD4TsC4kQGgW98+u6PZrjD4RxdE6r?=
 =?us-ascii?Q?U+h5y5vJYeYQkqswe935MoMNbe2Sm18ABz64zT0tLI/pw4vj3EbKgNLA8BAb?=
 =?us-ascii?Q?eA6iczwMmPCuiwsTAlivnuuEajwBc/+E0WooLidSsr3Hg3d4w7DZBWKpzLBM?=
 =?us-ascii?Q?zoAnq4SQIRruF3eYs7nvyrIbnJlcQG5MwXWevcVWjiI/xfJP8ATBS+XPWqGc?=
 =?us-ascii?Q?j16qgCb51YVsOqGQ0OVJPbS9OmdJyPiyvQyEaMfJ6+YIW96Y2PbYPUGul3QD?=
 =?us-ascii?Q?4QlRqgb2tl0dDD5SW6m6qsQoOVfe0tYxZNIBqW2U0kWu3p7eoz75bYC9zk+O?=
 =?us-ascii?Q?2WzxMbqe073JssXZim2S7tK8DnKHH6Z2c9nA8zGWqEwjaCQcPGb5qZaqRdys?=
 =?us-ascii?Q?jEi2xX19Q1bZcORhmCRG9JdRRZSvGSpy/i08RHVUh9GaFK6bQTRt6dUxaoO/?=
 =?us-ascii?Q?00u2VMZP26MABrKzZ3wAC97ZjXMehaZup+CUkB8wA0EqRimx8wxnYMoyAnry?=
 =?us-ascii?Q?Zi7z6riXYMbEYy8AT7ysRobDdSn10OCEBk6eN7AR1W2tRbMhEzcgevbBB0B5?=
 =?us-ascii?Q?YWcbO9msV+skHY6cctMjYWpym+2p1woqtEiv4OHjs7pm5SFjCZwAoKf9HPdd?=
 =?us-ascii?Q?ZwvdfkIPhBFsJZQmUnKIdYgRiWtQcu88zVXTy/74R8KpGlERnkDq/773NqK2?=
 =?us-ascii?Q?VBqTLGRiZm5SCzU0RxSV0NKJVHYAOzqJRIP7G39byJnhEd+hzfSmX0yyj0Oc?=
 =?us-ascii?Q?68/MvRMYKVydMMLUprMQ+pqRUxj8gdSH7UEsRvKi2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FRfaD93amI5ik5kLx2Vtfrpju0ZSTWqCDtMu6uRuc1jJ0EnHYVM9llhbyj6?=
 =?us-ascii?Q?Gso2/q3uJlilX3nvYaHdfWL2aM27v3RKDS2UrFGBu8VMyy0YLobMhNz8wURj?=
 =?us-ascii?Q?zlIsIzxs+/WWZTP5LJI7pvRFi3qAv6yXV1RNIGDVEPhakXGazIOhJdPHHi/P?=
 =?us-ascii?Q?vPFQ2yRE0YEi1R2DgGvP6Cv85wlm3ivOilm1rvb8PhNu53AvhnbGlhUMvz08?=
 =?us-ascii?Q?Xj9jvEb9QqJDKOauAnfKNWRzm9stjEcyNvqcTrhM5ioc+HxswgXBVMmq5+bR?=
 =?us-ascii?Q?U+K6kyB3mtEdwPSXPc7RcDIZaQTtpxEvqRwVJtknWVTUhvxITF86KjWVjRfd?=
 =?us-ascii?Q?sv1Sm3mea2+esJfrEhIIMMlr/RJaKHvIKmsRp8QolA2+6EA4FWPxotQt+cxa?=
 =?us-ascii?Q?1y7zSdq/WvI86V+dxYr+iFCTKkhnQZTtzQhc8lgEi9+rc2AZAHwRksONiJDb?=
 =?us-ascii?Q?rEgevIDRSq5Qi2XHshCr9QbRcDB390bR/X4dBDVSn/KvAg9Q26QyhsvYjmsa?=
 =?us-ascii?Q?h/Svb1AHl4//+kZMxzJeOMAHRBZ35ueX1qmGOmFA7BX5kRnnCYmcoS5xFSrQ?=
 =?us-ascii?Q?Vs7QWF97iC+pquwsSa47mFadPbTsaGoAnTeStVSL2fARBHKAQEn4QCZqTg9X?=
 =?us-ascii?Q?pl8J6fxfCOg3coVuzZQs0up/nW+vqhvt1jZ+OW+bydMqqLUNMSMyNN18i3Gi?=
 =?us-ascii?Q?EMr8kiKsx7111gvp70H5bf5eEAcAyco4YcHDhGIP71w3WVdT4LmppYke2Koz?=
 =?us-ascii?Q?1I7r0C4rAP/dyYUXjyZwyBgu3CNL4y7amn4lPNzoeBoR7XpgE/FBV6pNwnMX?=
 =?us-ascii?Q?ts/c6qdA8dPt5uuVZXkReDhf/wh7rwHJjATzOSJ/VE/6wja320bexQsC5JMB?=
 =?us-ascii?Q?D0rrGsWjNX5cIjA09DuWHrVcdFfBAnf47wTYYyKKGAHVJ57knw57pWBEjb++?=
 =?us-ascii?Q?PUlcMBw6AWNKD/NRia/OihHpnJNHRSu7ssWBWwMXpsX0DKrNt1JczDbJmqY6?=
 =?us-ascii?Q?ogi4i+5+3y8r7DrhkLeVlzs1QVNlWZ5Qf6H3Jzg+sRw/9DUVEqyIpypTtg9k?=
 =?us-ascii?Q?vJMwQ33IJmLQLdj3lIN1d2m8DwA3gBcb0u5p2Qd6kGC+ahwFMA2cxaxVmGv0?=
 =?us-ascii?Q?nR6ISg8CL+eMKPhouRMMbD9xxGb4/V7YXNehdIcDgp86X3Poy5vFVThn0O66?=
 =?us-ascii?Q?JlD2A2yU8ZrRAs/Da9dje1OvwEBSgC3a3GjpDdTzot6Dx/6Bex3yvKmtZA0l?=
 =?us-ascii?Q?1bcwrK1Be/Tc3M4WN+TP/uatsrAeZRzuZoYNy3AVh2ug5dEEIV/l9rBst0cq?=
 =?us-ascii?Q?P3qYgoKr5YQaGJLVtcRdrjf73VOdiJ4QmB8TKkcmKMHT2lnuvVkqslco3iIF?=
 =?us-ascii?Q?HU3zYwkf1ooJ6H45mmVwa32x8rWKPim4Jf7m7vVJI2/q+i0CWVHjLC/vfayU?=
 =?us-ascii?Q?HqPFHS9h/5Rm/8S2pujjLR0NAlzyGHX9f1SAHUobESgSlc14/2b5Gj0sGOfT?=
 =?us-ascii?Q?GsQzrVzeBhYDCwAAYzr3oEG2hF7TVIygIO1GdVEEVI970w9yQsippGeCMbvV?=
 =?us-ascii?Q?usQ9phaADg/gNa7cnKvB+08Dy+nMHZ8V4slcDRO5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7d5046-e971-468d-ea0c-08dc6b28205e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:18:46.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iUvNwIh95vmgXRx443aoNIn36vB/KTOYasMjV9MIwpaxvglVrnG3EBqVjgRppwbDWcjbKu7vNcxQIBLxdGp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

The .PHONY targets "all" and "clean"  are both defined in the file that
is included in the very next line: ../lib.mk.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 11e157d7533b..78ab2cd111f6 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -3,8 +3,6 @@ SUBDIRS := functional
 
 TEST_PROGS := run.sh
 
-.PHONY: all clean
-
 include ../lib.mk
 
 all:
-- 
2.45.0


