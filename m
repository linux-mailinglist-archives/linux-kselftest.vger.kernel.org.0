Return-Path: <linux-kselftest+bounces-39981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BFB37125
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256AF8E4138
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDD312814;
	Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DusgoTuh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694932E2DCF;
	Tue, 26 Aug 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228736; cv=fail; b=q7Ag6jFDHqtrAHt7Y9DFdRbjL5VRnP/dNyRlwEbtz6CnpNTvIAvBLhCEjvVw5GolzmdMg4b/xK8eg5nPdWdMKkdTPpwEZ5zglc+2dGCw58TWHEKAIqpsbq2D5Sh6p0ezyBLw2l8y6QRXE+0y1vvFrN3KBaZqO4DUfl0r5jiKoBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228736; c=relaxed/simple;
	bh=fDXcoHXp4KV5huo6pB9XJ3YyaOLx2zGVXbJeyg9U2RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUf8YXQBcs8PqIpCIrtscYpcFr7mrxT6HtKHtk5OFJ8AH6GuzkCDXn3UB89vTTy8WOlcMJL7bJL1ZbtJyJXL3GHcy27rk1RwyUKZTSQ7Eegrn3uafNhR9dwd3dBKJzzFNT7jrR0M0BUydQykJzZG+pW5BBMolRH3Y9UG0OGkK04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DusgoTuh; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCaLdcEzy5c3jCEutdRsqnAPUIvpa0uLRMj3bkW3vX8RCO8zSmTdriEdm8Tb+65wt19k5ivrF4sP4HR6s3aCUbDFPNc08zTbrcJCtL632lBrI8LSh2W0NYH5H6zY1RqZg3ReSDc+841pJCCdC/CoM17fqhBpfIFY0UJ4dQgwa8omCP64lCSnbgOi+DIJrHTqzqlcfc7539UEXLxyZcAJmH/wNgtuH3cJA3TITYdsx3cWRTftyuFQfBT/fNAh0uIDt1jUgMpZSnasp0DMCT+XA6yu4kUE5IfNO7Q8mQXNdtbYJ+5FsCgZrShGMTL8W8IfgzHsbaw7RM3//SaPm1YbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yffrgpGhH69T+g0fBFNPj/rAEjcIxjOLYRFpcT4KWDs=;
 b=ui/fihEbDCk4owmxNL//qn1sQFBaP5WXaMGxa8Ts03j8l3hOIL/vIg8rQEnV9D/e7V8l/l5dluUJKdQ78xfMw5bEWO3KES5xYtsEY/7RoqIY6O2lMcHIlbRJQDw8OqLhLewWtJPT591sxwHeQn4bLNfEldXd2FylxPH4GVcHfbMRqk0HViaQ7Di3Q+40Fg4GfyoT5kCQkHJ1NFfB9CX4CYjU1CHBxFf38xjKJZWIuaRCgfc3adSLLTAAfPd+oPaLMvSeg4iS/tMA2ej/FqtwnmxuvcwoZj4Ek1eqBwP/IhINsImuvb4O+ZphoxBtlDaHp4gKr1PF5+ZAeCBW5KXsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yffrgpGhH69T+g0fBFNPj/rAEjcIxjOLYRFpcT4KWDs=;
 b=DusgoTuhiWF/RGPNkOfNso3gClkcF5ACT85A1BPSFwCeahd//MlYSP32QgabkmOfQmA+MFap59Y7IWM1sKgKnduv3UpgESF3uq2+qoanP+zEBczmah+TQLFiG9tlZT7BD1ejggKgJduWE+OS8Yswqc+rV661DB3hSMGdeQDsDT2kNnU3AiDKhC3nqeALCGtDePO3jor8o5FW7LvTRdAcVvxXmhtZg3PV0Y80Suyxw1bcACGNrAuVscOJN4oIey3ya3VWqniY6O1zNQzg1VMOTzSzOWfVCXCWwu6UF1U0hzIvxCuIE2PyEwEtr4M3lLQpjd3XvqW+ekXDAF6oz9NX2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 17:18:46 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v4 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Tue, 26 Aug 2025 14:18:36 -0300
Message-ID: <15-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:806:a7::21) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: a90ee9f5-b24f-4d68-0ab0-08dde4c49bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WXSyZZCH7XniIrpMhnZ0gyyLD8CKu/OQvlo8Qp1wE9lgwDxLvIMrHTLqO/yK?=
 =?us-ascii?Q?2Pjuu0KT2ZiqXnFfF5sgZVTob20h0EkoYzUomXdF67wbTp41pfR8VP0Hyq4K?=
 =?us-ascii?Q?BQhXVshAMd8uwI6Tn0ATJB5XZCMw+XCH/hkh6TtNZTLTcI3Ey8iX+EK9WXxD?=
 =?us-ascii?Q?9gN6Xuy9N/laPoW7D8U+V2GLMEzXZLErJGtueRGJ/hbhX+7Pgfugp2KxkTb1?=
 =?us-ascii?Q?/4nRxvmpvSKApQr+QGlVai+Oj3eq+OtDUl6u1ECZgZnu36jdhIaBLS3TkrPw?=
 =?us-ascii?Q?0M2gbP5tUKQHAopxc6gmZ9GvRdJ4cUBz11tmWGJVhehKnCbj9uRxE84DGy7r?=
 =?us-ascii?Q?ibPzOTsRO+zp1Qa4OdIZlnXTEzfURkidrAYHHsX0vfYC9FlG+y+KPCGTCNmw?=
 =?us-ascii?Q?5aIyuUMfvzxp1TlN42vrClckT2kZw8Xwzv3uCUmnter7cBu4WfiW1X7/wqYh?=
 =?us-ascii?Q?oROix3T+Y3ZBfgRvn12UkEiO0m8KlJJQNxL3/f2j+BEsO61U2dtSSCMfvUTD?=
 =?us-ascii?Q?1d+yt0FN1nLX8ORzWrKAwWivltqkhip1bnAd/d9dUa6Xkgi3d0RyLmusx+vQ?=
 =?us-ascii?Q?piTcqO8v5sB+905UcndvNxXCdih5/GM80SUPK7lZB3EF0CNTI02zJVcVRI7Z?=
 =?us-ascii?Q?M3tWuFhc5GQzpSnauv/fzqwpHlAM/Q5XzZ1SFgTzbBFb9cy9rU96c+GOfqUp?=
 =?us-ascii?Q?IqiUFeUK4CTiLmmVy1+SZCH9pNPBC4ZxebQlZ73CcJJwPj1Fdb8vBXWhuRMB?=
 =?us-ascii?Q?1FCRHAozF/+X3cfpg3mdvnEdmVuwobSJdq9i5b2q5vZ9u5JW3mLWFvHpQBtB?=
 =?us-ascii?Q?7gq/FtO2DznZH35+W9boM6kHK5cRah28yDBTg5dGSkWVrOJn9DFJRgfU8k6e?=
 =?us-ascii?Q?XN6twHOsxIW9c0yBXkksHX0J/UIqznaGAV0BhOhEoFa3DCQ5kBrx9rcbsLiA?=
 =?us-ascii?Q?m8lIZnjU7ci6kOgdsotXgYHqD2De3vx2n+jsNkP5KG38gmTCVjM9Ym37tThL?=
 =?us-ascii?Q?NIDZXJHO3yLHCOLewCVRwWTAY3vhiDlAmDSzY36uT2e8GPbZDLOH37VRLAmo?=
 =?us-ascii?Q?u5tEyA0VtR/0HH4ZmrDtAvfs5FnmF+27rmOsb+YFkeaI44pAPaD+paCjZy/q?=
 =?us-ascii?Q?X2Y9RPptcMeZMEdPsMhWVS/6lbceEmopBvW/anrCmLgxJzQqkt2PxXyOwxzw?=
 =?us-ascii?Q?AB67JrBBn4eArhII/a9cz4XZ/XfFcyfHBmJl8oaHD1SpTJcuVLmqXLHmpYWt?=
 =?us-ascii?Q?IEJxgpFBN51AUbgkqjK/8gwt7xpGLUUniJFCrX3lTwYOhc3NKj2/EDk1o93y?=
 =?us-ascii?Q?CToFb9Z5dwPUBn3C9ike9s8VsrpCCQZGPk0HznUzA7ufYezPNjOMKhBjUCHj?=
 =?us-ascii?Q?wZUJ9s6Gr4u2khcxRvd+cqYDpMy9inovrngN8mw9QJJiG7QLjcyRUEbGp/Fz?=
 =?us-ascii?Q?2eo8s5VdMDL2ew16xBC/MlNq3pC0q4POK5gvgKd3IjjcFm/wE+wBPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksookbA2bQjJGo/qM5inIetJsQXqQQWZB02YxkLlgAvHCI9Ti598pLNkV8DP?=
 =?us-ascii?Q?J5CP3bhdTFOx4+qY3VRbi4ktW8LybhuJAU/Qlh9TbMJDWW7p3tk+Pd6PPMFm?=
 =?us-ascii?Q?WUo9LeQoJYuViD5IUbNbaX5Wi9NgS2KZS8rTbo+9FcvBKDomF/WCBRbjmibI?=
 =?us-ascii?Q?X7MKTQEZpYq6IpYosg850h+e+nh+nui/PAVUZAy7lIoicCd5sjABK7tvQSag?=
 =?us-ascii?Q?/VDmwDltKxUXAxn63MMBJln8DWP7PxdZspRwAoyC1olFxd2eDKA6tAD1Y7hS?=
 =?us-ascii?Q?VTcQbbE3Dwo5IbEW6JXxihDT1xZKkqDidgoyto549YwsG9+fP9B9rL/dM3aq?=
 =?us-ascii?Q?PSJVdUTy2gwUppb098VO1Se2mwd4ME35uu+NtsARVvm4mjsra4BiTZ5wzNrb?=
 =?us-ascii?Q?kANUKnkWBcD5Hz3fVuZvfhExz/akHycVVza0hgfK6bNY80GXMfyix8mYsnIg?=
 =?us-ascii?Q?/mFsZ72LAe77jnSatrqh1+pzQqtJzrl6hfAoCjRAvbuREVejt0yNfPeP2acI?=
 =?us-ascii?Q?VRYAd2C1X31VPGzU65UYyDrxypmN6GKn8GHelMrddrNTwpEPOITP4zEamKn4?=
 =?us-ascii?Q?/KHuGy+SA6m/HFMu5VwcKHsfrCrVID0n7xfoKOHizE3b8Ko8owqMxaVfD/kE?=
 =?us-ascii?Q?u/87/GfDRUuIv3giHzN2UuaZGkoH0U8JVgTsGYjJx/DGyLqaHVPXnLugBjvY?=
 =?us-ascii?Q?XRABcmBDlmakdfSNVkpRjXmMTPogh62UQGv4rB+Rp+zalVWQXhHhwN5ktrBB?=
 =?us-ascii?Q?l6F+KMJBy9PEKldlAB5Gf5TkC6k5PnnXo7af8ci8KFLaD/C+KBOu/O/gqb00?=
 =?us-ascii?Q?PFi7GTkcpnTrxcB0PiAKOJVtcxVcvf5lr/wXJPrxdQl9uqCVqcDiLyjoKj+I?=
 =?us-ascii?Q?oXiwpb1goN1bQ0/hN312HpxZbHpcaql+RRgmiPXHPnw9bYDHB6J2lJuI/gkc?=
 =?us-ascii?Q?eA/Wo6+cSFcR1e2Da87AQijtoApLKwIZ7lZbR/pCO8avcUfQlCT8B88zkto/?=
 =?us-ascii?Q?ywuf/EUp7ilNuAs9RajRZZcfkpZlKwKrhIQoR+dK5aSGPnMw/+4sxhkVG6Ye?=
 =?us-ascii?Q?d+QhG8IIiMeRJLgrjHummku7L0LVlBELK7aV1HOeGiyIn3kPmbxXTzb9+oID?=
 =?us-ascii?Q?G/FbdrB/QLhf7rBc14tspAhCrLnTVnsgm/rkrhzGAJ8ytQgt53fR9bw2yGm1?=
 =?us-ascii?Q?GW/SiR/dkR/Ite5GMEJp/dwrhfh4VGayHi5iwIUI49AvfF1CtRAYYIbJ9NC6?=
 =?us-ascii?Q?tcBAOw92TEr5NP1uK0dRCsJdzKS+83BPs2vumT/d1+3ggd9MqeoQ+UFpkFU7?=
 =?us-ascii?Q?LIYulSTyR4ZRYkiuhMTY8wH1iIlhxU+RTnnElbWomUYZLpXIpVWwhMcI3bdD?=
 =?us-ascii?Q?z/EHehZH+n5rm/hcUwvro/s/9V3AEBADw2eiJ6Hx6m2sQPpKfP0NoRoy88FG?=
 =?us-ascii?Q?k8bJ2JcVKehd4ibqvrddWsQ0ewycm1NQCnHyK4qya7zA/d1bpn7b80qD0rpB?=
 =?us-ascii?Q?1SBebwfHSGwmPQM6IbLE24yTvh/+02IJXmNkfwgQsx+aMbwiXZa6FRrLZvIU?=
 =?us-ascii?Q?f0pC9pWeTJrfIMsnrntbfRJKFYfZECy67qUWUK9Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90ee9f5-b24f-4d68-0ab0-08dde4c49bd5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:44.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5VDFl/JlxzrVIBbRC95oLwMQkCQeDZKeic1Brphil8mkQ+M9x4m2C18DViSy6dx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit tests can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=100
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

Like the generic tests, these are run on the format's configuration list
using kunit "params". This also checks the core iommu parts of the page
table code as it enters the logic through a mock iommu_domain.

The following are checked:
 - PT_FEAT_DYNAMIC_TOP properly adds levels one by one
 - Every page size can be iommu_map()'d, and mapping creates that size
 - iommu_iova_to_phys() works with every page size
 - Test converting OA -> non present -> OA when the two OAs overlap and
   free table levels
 - Test that unmap stops at holes, unmap doesn't split, and unmap returns
   the right values for partial unmap requests
 - Randomly map/unmap. Checks map with random sizes, that map fails when
   hitting collisions doing nothing, unmap/map with random intersections and
   full unmap of random sizes. Also checks iommu_iova_to_phys() with random
   sizes
 - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 451 ++++++++++++++++++
 3 files changed, 454 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h

diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
index 11e85106ae302e..d28e86abdf2e74 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_template.h
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -44,4 +44,5 @@
  * which means we are building the kunit modle.
  */
 #include "../kunit_generic_pt.h"
+#include "../kunit_iommu_pt.h"
 #endif
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 8a53b1d772ca9d..cca4e72efcaa04 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -70,6 +70,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..5e25d698450783
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,451 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "kunit_iommu.h"
+#include "pt_iter.h"
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+static void do_map(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		   pt_vaddr_t len);
+
+struct count_valids {
+	u64 per_size[PT_VADDR_MAX_LG2];
+};
+
+static int __count_valids(struct pt_range *range, void *arg, unsigned int level,
+			  struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct count_valids *valids = arg;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			pt_descend(&pts, arg, __count_valids);
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA) {
+			valids->per_size[pt_entry_oa_lg2sz(&pts)]++;
+			continue;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Number of valid table entries. This counts contiguous entries as a single
+ * valid.
+ */
+static unsigned int count_valids(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++)
+		total += valids.per_size[i];
+	return total;
+}
+
+/* Only a single page size is present, count the number of valid entries */
+static unsigned int count_valids_single(struct kunit *test, pt_vaddr_t pgsz)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++) {
+		if ((1ULL << i) == pgsz)
+			total = valids.per_size[i];
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[i], 0);
+	}
+	return total;
+}
+
+static void do_unmap(struct kunit *test, pt_vaddr_t va, pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	size_t ret;
+
+	ret = iommu_unmap(&priv->domain, va, len);
+	KUNIT_ASSERT_EQ(test, ret, len);
+}
+
+static void check_iova(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		       pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t pfn = log2_div(va, priv->smallest_pgsz_lg2);
+	pt_vaddr_t end_pfn = pfn + log2_div(len, priv->smallest_pgsz_lg2);
+
+	for (; pfn != end_pfn; pfn++) {
+		phys_addr_t res = iommu_iova_to_phys(&priv->domain,
+						     pfn * priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, res, (phys_addr_t)pa);
+		if (res != pa)
+			break;
+		pa += priv->smallest_pgsz;
+	}
+}
+
+static void test_increase_level(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_common *common = priv->common;
+
+	if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		kunit_skip(test, "PT_FEAT_DYNAMIC_TOP not set for this format");
+
+	if (IS_32BIT)
+		kunit_skip(test, "Unable to test on 32bit");
+
+	KUNIT_ASSERT_GT(test, common->max_vasz_lg2,
+			pt_top_range(common).max_vasz_lg2);
+
+	/* Add every possible level to the max */
+	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
+		struct pt_range top_range = pt_top_range(common);
+
+		if (top_range.va == 0)
+			do_map(test, top_range.last_va + 1, 0,
+			       priv->smallest_pgsz);
+		else
+			do_map(test, top_range.va - priv->smallest_pgsz, 0,
+			       priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, pt_top_range(common).top_level,
+				top_range.top_level + 1);
+		KUNIT_ASSERT_GE(test, common->max_vasz_lg2,
+				pt_top_range(common).max_vasz_lg2);
+	}
+}
+
+static void test_map_simple(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	pt_vaddr_t cur_va;
+
+	/* Map every reported page size */
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+
+		cur_va = ALIGN(cur_va, len);
+		do_map(test, cur_va, paddr, len);
+		if (len <= SZ_2G)
+			check_iova(test, cur_va, paddr, len);
+		cur_va += len;
+	}
+
+	/* The read interface reports that every page size was created */
+	range = pt_top_range(priv->common);
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		if (pgsize_bitmap & (1ULL << pgsz_lg2))
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 1);
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 0);
+	}
+
+	/* Unmap works */
+	range = pt_top_range(priv->common);
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+		cur_va = ALIGN(cur_va, len);
+		do_unmap(test, cur_va, len);
+		cur_va += len;
+	}
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+}
+
+/*
+ * Test to convert a table pointer into an OA by mapping something small,
+ * unmapping it so as to leave behind a table pointer, then mapping something
+ * larger that will convert the table into an OA.
+ */
+static void test_map_table_to_oa(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t limited_pgbitmap =
+		priv->info.pgsize_bitmap % (IS_32BIT ? SZ_2G : SZ_16G);
+	struct pt_range range = pt_top_range(priv->common);
+	unsigned int pgsz_lg2;
+	pt_vaddr_t max_pgsize;
+	pt_vaddr_t cur_va;
+
+	max_pgsize = 1ULL << (log2_fls(limited_pgbitmap) - 1);
+	KUNIT_ASSERT_TRUE(test, priv->info.pgsize_bitmap & max_pgsize);
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+		pt_vaddr_t offset;
+
+		if (!(priv->info.pgsize_bitmap & len))
+			continue;
+		if (len > max_pgsize)
+			break;
+
+		cur_va = ALIGN(range.va + priv->smallest_pgsz * 256,
+			       max_pgsize);
+		for (offset = 0; offset != max_pgsize; offset += len)
+			do_map(test, cur_va + offset, paddr + offset, len);
+		check_iova(test, cur_va, paddr, max_pgsize);
+		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
+				max_pgsize / len);
+
+		if (len == max_pgsize) {
+			do_unmap(test, cur_va, max_pgsize);
+		} else {
+			do_unmap(test, cur_va, max_pgsize / 2);
+			for (offset = max_pgsize / 2; offset != max_pgsize;
+			     offset += len)
+				do_unmap(test, cur_va + offset, len);
+		}
+
+		KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+	}
+}
+
+/*
+ * Test unmapping a small page at the start of a large page. This always unmaps
+ * the large page.
+ */
+static void test_unmap_split(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	unsigned int count = 0;
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_vaddr_t base_len = log2_to_int(pgsz_lg2);
+		unsigned int next_pgsz_lg2;
+
+		if (!(pgsize_bitmap & base_len))
+			continue;
+
+		for (next_pgsz_lg2 = pgsz_lg2 + 1;
+		     next_pgsz_lg2 != PT_VADDR_MAX_LG2; next_pgsz_lg2++) {
+			pt_vaddr_t next_len = log2_to_int(next_pgsz_lg2);
+			pt_vaddr_t vaddr = top_range.va;
+			pt_oaddr_t paddr = 0;
+			size_t gnmapped;
+
+			if (!(pgsize_bitmap & next_len))
+				continue;
+
+			do_map(test, vaddr, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			/* Make sure unmap doesn't keep going */
+			do_map(test, vaddr, paddr, next_len);
+			do_map(test, vaddr + next_len, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr + next_len,
+					       next_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			count++;
+		}
+	}
+
+	if (count == 0)
+		kunit_skip(test, "Test needs two page sizes");
+}
+
+static void unmap_collisions(struct kunit *test, struct maple_tree *mt,
+			     pt_vaddr_t start, pt_vaddr_t last)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	MA_STATE(mas, mt, start, last);
+	void *entry;
+
+	mtree_lock(mt);
+	mas_for_each(&mas, entry, last) {
+		pt_vaddr_t mas_start = mas.index;
+		pt_vaddr_t len = (mas.last - mas_start) + 1;
+		pt_oaddr_t paddr;
+
+		mas_erase(&mas);
+		mas_pause(&mas);
+		mtree_unlock(mt);
+
+		paddr = oalog2_mod(mas_start, priv->common->max_oasz_lg2);
+		check_iova(test, mas_start, paddr, len);
+		do_unmap(test, mas_start, len);
+		mtree_lock(mt);
+	}
+	mtree_unlock(mt);
+}
+
+static void clamp_range(struct kunit *test, struct pt_range *range)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (range->last_va - range->va > SZ_1G)
+		range->last_va = range->va + SZ_1G;
+	KUNIT_ASSERT_NE(test, range->last_va, PT_VADDR_MAX);
+	if (range->va <= MAPLE_RESERVED_RANGE)
+		range->va =
+			ALIGN(MAPLE_RESERVED_RANGE, priv->smallest_pgsz);
+}
+
+/*
+ * Randomly map and unmap ranges that can large physical pages. If a random
+ * range overlaps with existing ranges then unmap them. This hits all the
+ * special cases.
+ */
+static void test_random_map(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range upper_range = pt_upper_range(priv->common);
+	struct pt_range top_range = pt_top_range(priv->common);
+	struct maple_tree mt;
+	unsigned int iter;
+
+	mt_init(&mt);
+
+	/*
+	 * Shrink the range so randomization is more likely to have
+	 * intersections
+	 */
+	clamp_range(test, &top_range);
+	clamp_range(test, &upper_range);
+
+	for (iter = 0; iter != 1000; iter++) {
+		struct pt_range *range = &top_range;
+		pt_oaddr_t paddr;
+		pt_vaddr_t start;
+		pt_vaddr_t end;
+		int ret;
+
+		if (pt_feature(priv->common, PT_FEAT_SIGN_EXTEND) &&
+		    ULONG_MAX >= PT_VADDR_MAX && get_random_u32_inclusive(0, 1))
+			range = &upper_range;
+
+		start = get_random_u32_below(
+			min(U32_MAX, range->last_va - range->va));
+		end = get_random_u32_below(
+			min(U32_MAX, range->last_va - start));
+
+		start = ALIGN_DOWN(start, priv->smallest_pgsz);
+		end = ALIGN(end, priv->smallest_pgsz);
+		start += range->va;
+		end += start;
+		if (start < range->va || end > range->last_va + 1 ||
+		    start >= end)
+			continue;
+
+		/* Try overmapping to test the failure handling */
+		paddr = oalog2_mod(start, priv->common->max_oasz_lg2);
+		ret = iommu_map(&priv->domain, start, paddr, end - start,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+		if (ret) {
+			KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+			unmap_collisions(test, &mt, start, end - 1);
+			do_map(test, start, paddr, end - start);
+		}
+
+		KUNIT_ASSERT_NO_ERRNO_FN(test, "mtree_insert_range",
+					 mtree_insert_range(&mt, start, end - 1,
+							    XA_ZERO_ENTRY,
+							    GFP_KERNEL));
+
+		check_iova(test, start, paddr, end - start);
+		if (iter % 100)
+			cond_resched();
+	}
+
+	unmap_collisions(test, &mt, 0, PT_VADDR_MAX);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+
+	mtree_destroy(&mt);
+}
+
+static struct kunit_case iommu_test_cases[] = {
+	KUNIT_CASE_FMT(test_increase_level),
+	KUNIT_CASE_FMT(test_map_simple),
+	KUNIT_CASE_FMT(test_map_table_to_oa),
+	KUNIT_CASE_FMT(test_unmap_split),
+	KUNIT_CASE_FMT(test_random_map),
+	{},
+};
+
+static int pt_kunit_iommu_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_nr_secondary_pagetable =
+		global_node_page_state(NR_SECONDARY_PAGETABLE);
+	ret = pt_kunit_priv_init(test, priv);
+	if (ret) {
+		kunit_kfree(test, priv);
+		return ret;
+	}
+	test->priv = priv;
+	return 0;
+}
+
+static void pt_kunit_iommu_exit(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!test->priv)
+		return;
+
+	pt_iommu_deinit(priv->iommu);
+	/*
+	 * Look for memory leaks, assumes kunit is running isolated and nothing
+	 * else is using secondary page tables.
+	 */
+	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
+			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	kunit_kfree(test, test->priv);
+}
+
+static struct kunit_suite NS(iommu_suite) = {
+	.name = __stringify(NS(iommu_test)),
+	.init = pt_kunit_iommu_init,
+	.exit = pt_kunit_iommu_exit,
+	.test_cases = iommu_test_cases,
+};
+kunit_test_suites(&NS(iommu_suite));
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit for generic page table");
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


