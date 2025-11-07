Return-Path: <linux-kselftest+bounces-45130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE33C40EF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63DE18947F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EE33555D;
	Fri,  7 Nov 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebQxq928"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C13346B3;
	Fri,  7 Nov 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534194; cv=fail; b=VMaRRhgDMRGRI3SJWa0VMjao0E1RLHMEArK1a8h2/CmUHifQY/IihLaB+wHs93p8/x07CDGaPlhyseGfUA650CMfrrDu9B3HnZbch39J3T7TfzqaxzRWtIqoMPzVp9GFdiwqPIQXIyRFn26pR++Yan9xzh5uFb+LJmy8D1Z4khM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534194; c=relaxed/simple;
	bh=PGRnqrVco/p3baDXHmRgv43YXkKuLC4WGlkllPFG6IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzzSiXmcPlA1SXRTOWP39lq9XplQKEoJXGz4KHjfC4gSddpBqCrEGW3rBxE05/9YB2oCgp3b6Mb/0syFvoNSOod6cutU8h6opR4rWuV7CprvWc4BRiEOXvYLqoQzmacqLMdTkZFUinr7vphdKxDjv25Go5CAi0mqHiK6I04NaNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebQxq928; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvKYu2rc9eD48vLQUwJTUP5TTAXRenvIG24Sb7Y3tbRCSbftjnW2+0BPv8ANN+DLlwgghzRSS3dn0RNBTWB7DcyFxjEYCqG9xoh7B9VLpus3rvC2FhBvIeRjKQCgWNFvL5Ix3rzheIpnFUUtec0D3Pbz8IraOJ5j1ZyLtHZrh2u5jE7YmKMj7BmM0doZanNGBfgjKAzbU0Ch1t9FpDyJIf+bsSOmxVx5PucF0ZOZj0t1aquZ616h88kBWFdlHQh5lUMzar/onn86TtxgSiYENoYTgiD+bSugaNUZ8eVrEMWro+ZY4g0i4ULEwcDmATxVtJsU2G/v/StkVhbNiNWFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOd7YLnBDZfWDNs3PaUtlCthaHdN7NP9+TXhOa0ruFk=;
 b=AvoGREAPHlU0trE9ekmI/rOb7e/n1pJfvM2W0epVcSFk4hXMCS3mlsgCiM9w1Wg83QmkmkGsUrfjN5ga2ril25lc5D4lM27WJaKpXVnVyOM+NnissUKlRMZkDLHwVGYel70jn8VNcgOESDoqlIrqWK/UyS1x4a6gN6ReW13TUUalpo8pASfEN52J01QcCDKjpC93wnqoJbPJc4f8WIKT1SPSCraA1nkwdWyXkDQVtkXSYdN13PTQMYSDUht64uUkjiJOqYkMUM4l3re0RSmV+WTzTHk7VbxTKL8vEwZLbpVkBS6aGrKV3fPUUEAlxK9q18kqbUHoFyq3FaPcxWVY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOd7YLnBDZfWDNs3PaUtlCthaHdN7NP9+TXhOa0ruFk=;
 b=ebQxq928ILJSvTVeax5EhvDkxi/PUa8SLqbyd91VRcyg8QNQ0LQYuo2Du+IyfB0GmA0qx90mTFmGKCGZGBC4TGgocIq0YH95E89VyRFrmfRaV7Y9y49eWpfoycRvZNDFvsi0KKN8qRGsinR1vEP/aPwM613dpcXzG0f+VgpxLp05qALHD6b1ImU3DogLKLJg5qFS52xc+zK5TlzRwTAPzfW0Yr0Enm5r0V0kJ0uLDZACvNfBoVSYerRK0iampjtyYN83eT5tSD8A0IBkQSCdFhaEmYHDH+zo6VYFSIE66S+aLo0C7/IuCQzeO0kaD4miinTuJUXy+boh+p0od5NSIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:44 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:44 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Date: Fri,  7 Nov 2025 12:49:38 -0400
Message-ID: <6-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::19) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: d537f563-d8d8-4a7e-c36c-08de1e1da66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fP4BVc90tGPWC/Xmk8BXJk+4q4kNrZW33f2WQYw03Gu8YPIFnJg7u2ufJul?=
 =?us-ascii?Q?FDQlIzNwo92kMzUR3p7elJQI/q/qsZqbCNU6V94N7DdK5pLR9W7l9Yxa9s2h?=
 =?us-ascii?Q?fZsBcfO5EkNdPaWz5m1KeS/lAMApYCP9rhEVBphHgYKXqCzJU44D1UwEs7X3?=
 =?us-ascii?Q?FEKJMJhBLwQUfe6c7DUOp1KaEAKJxmeQcv2WHRcKgwKMkxpv8+5OIPojYj6p?=
 =?us-ascii?Q?5L83N/bDOQLiKFwPM4Y4RGEPpgulHbqFv56mY5PN8RWsF9Iy3vCWCwIoNT4w?=
 =?us-ascii?Q?Vx716vnacPxGh6/cNf1Q2u805S2HOdnhQvF7T5kD2ZGgzuVtJxkO0hoftEtj?=
 =?us-ascii?Q?zaC7a4LDjc1YBMItf/uOMI41+8EKC1uEt5GYY11NbmnGmWHhxbW49jplBMN8?=
 =?us-ascii?Q?O9UtpK8VZ8HOvttFv/DW1ICHB2hQgPvXOuSAGpqetidNbceoMectvw1QvJuf?=
 =?us-ascii?Q?S/T6RRlT4Mg+f9indcyrPGQ/zKdPGQc1thBxH+f1G15q6mIzLZGGqfS5Usc7?=
 =?us-ascii?Q?AVrp8U3dz97fyWtzX2ehVNHZaQEqiP6bK77XgI8n+9vTmuiSCoXCBbwDHUtt?=
 =?us-ascii?Q?MIRSWP2SdZLBjzJhLmfLKotKYAywOu6caiD2mcTIgOJybnN4wYOPoNHUgMGv?=
 =?us-ascii?Q?Sp1vgCvpR2VwU+2dQCSfry2NRWDFqGtMYAQp5gYaVZez9RGJ9BWh9LaolyW8?=
 =?us-ascii?Q?GFBM2nwr7g7O6E5c8g3XzoWhVBHxpW7IUCXT9Wpr9LQeoXc/fDJWSGGrR1jJ?=
 =?us-ascii?Q?9qa5HvYCG6v7mvr/x9FCSPsgo/SaCxNVZdE0ksNhETLKmita9FRmQf8ol+vz?=
 =?us-ascii?Q?YxVLVojfbpV1l5pXgJ2I3n5oS7WXVOWeI7DjLqWHL8RmEA0rgnZvo6l6mmQg?=
 =?us-ascii?Q?3Vd/LMPmW/KRqbQ3E8n/SzSZWSJ9wNR+S0GCM8rvrJsUVSLP68Ol2LCSeXM8?=
 =?us-ascii?Q?zzHA7fRUHd9SwpVUYBGfHk48BkxoHZEeYL8BDiY+cFyffeiWshKNw+WDkt2M?=
 =?us-ascii?Q?Hl/MVBUwNzsANa9QvHHJf66E/nXzivvSvU571fviGox1cQ9giuElbkS/hEL6?=
 =?us-ascii?Q?M+bWZiuK1Fv5xkq9eN/YK8Yp33+d7XRX8o4Estk3enkKSSeDIBkPoofwlwdA?=
 =?us-ascii?Q?2duGggeIjeOEk93zxAJJPJxKaqBss1Z6UjOO5Z+P2suesMSyM33pFBgct3DF?=
 =?us-ascii?Q?AQrGCtbp4fAaTBwRCdIaOhQkRbZvEurnWc2y5gp8+hUBkBidXHAqhyjQBKXl?=
 =?us-ascii?Q?h1oggkZQMcaVwqiruZBFYOGcXrRmpt/b8zzveXfKgyPJoB4LLte+Ri2PXFvZ?=
 =?us-ascii?Q?aXXwU0mZFtmhyoaKjVEk3g/4ijN2k7DJzC35k3ba9ZXwJOfIi8kcYBFBu0Uw?=
 =?us-ascii?Q?njtHEFolyyYzjSmeYpaAzcybWO7FFV+5zF/dhflH7rgmfakq5yGrtKj6cnWT?=
 =?us-ascii?Q?co/hQECElnJXl7zotDrjdmQ7TpWrHOPhFP/sXSRDiqRa+tj4vABnfAODtLia?=
 =?us-ascii?Q?MVSS9h+7qC5FXLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wQtk38WgBEyLfDB0H6bN6wpW8oRd4E/xeWZrLMUvy6e/zgDRPb88s5v9M3bl?=
 =?us-ascii?Q?7TfhaXxFg+x7MvQzS3Bgzf1oWJt5x+J4Te2j+xZDcStBoz2MHxcPKplOVWVu?=
 =?us-ascii?Q?EI9u128bbw0qgLfZ0eQW+wuvMO9Ex5gQ5ZAA2NfUmckHMc6upYOMiD1S0Xb1?=
 =?us-ascii?Q?KyaDyymrWMVQ3uvruOmrmRXdU7w9S+qhyTol1ZGy3IEcZ4QERnQ8CYnONNWI?=
 =?us-ascii?Q?jamp5GFXaLBCwn0WqQAdg94a7hPlcXm0PihZjDI93FLsYBTK3L9UgwqTizfj?=
 =?us-ascii?Q?IKeSkwm85/LBIvtxeE8xt33cxzct0cHSMYgF55l/a6L/Brcpdr1hNpIo8Esr?=
 =?us-ascii?Q?kQHB5Tyqovns4tDvxTSWJ5gMk8PPEtM8U84feC4s0Cz4gPsEb8v9BhBbekAX?=
 =?us-ascii?Q?aYZ2+4YJxJ9iJRWy+Q5brgdSSXyUFFHt7JC1kKb/beb1oDM4ovIlT5UTmqCW?=
 =?us-ascii?Q?A90gz1tI3adXQ86TvU1bFLsXQkHDnlwxS1zUzX0EQ9OIX2k9oiFW2gat+O+y?=
 =?us-ascii?Q?UX+UlY6X1D65IBwMmSyRp7MhnAUPwYUkqU1h968c7lOd+yw+EMUrMIJ+gyUJ?=
 =?us-ascii?Q?coLF3+ZuDBGDAtsVtwo3iU9GpZ5Im5dqfZRr5P7r9/8JVE+L5av8QYnkc0TO?=
 =?us-ascii?Q?ItPttSNCszNJYTI02mg5GvhOE1j6KX3DQmD2W8WC006uCTkhcw/lNo4a+pcf?=
 =?us-ascii?Q?0aNzPHaLJ+9MGvG/NxxaM1MPSjpMSNxpmYPNFanExsd48v4s2JK8MleABnnG?=
 =?us-ascii?Q?zhaQ6W5kNVbuWzDoPhO9iqn7qYuWwfLL0nqu1kgxAQyiEfukHsuA6ZWjgEhy?=
 =?us-ascii?Q?Ok9WEHcI89d8lNhvbBn2kJwcWyGPDOmZAJKuGYkGHr8OvOvamRGyRmHKs/Lm?=
 =?us-ascii?Q?UcE5HVWfwt6YyWS45dwXLUI9SiFxN4SW55LlDBg5sh20pwwBQ5SAJkAcBwHC?=
 =?us-ascii?Q?ufPoEoqNZIVnfuZlrABaGEY+lwWo8NZ3McNAl4o2N8YRH2TVYuCzJUMZ822O?=
 =?us-ascii?Q?yCQL6URCQpuklycVerq8vQzCvwcdZwlfbL0N62aSCRF+tJR4cgTyYDFvtKOM?=
 =?us-ascii?Q?deS2eSYjybdFKdrMnhBJbdUz5LR2gkCtAiFMoMYCgYJWFE0jiCax/kZEH8kk?=
 =?us-ascii?Q?9dJqKAwikoTcO8cUL8bvrkPyhuKUo9NUmyhBb8j/9PtyzlVLsoBXNjvGY/gq?=
 =?us-ascii?Q?aTGJQF2XDwtISw1C5lxLRI/niS9h3xQ8bV+ejEsg1z16lq85KuHS29KEtsNW?=
 =?us-ascii?Q?/NAaLRquT+lmMP33zP5Ed/K8+8gKzUjP4LO4r12et1CJAobtBMQJOLwrIR8a?=
 =?us-ascii?Q?twDif4cmCZv72q3gWdUlWFVa77aqs54WzxpT4Uy5x/MkMOpJC2GPT3YPHpcl?=
 =?us-ascii?Q?t6cepAkqmeGWz2p/bL65OXZSt7TT57mDh+Y9CNMtjb6ImVF/29du8adzMgfs?=
 =?us-ascii?Q?Or3wW0y4Oaz9vKQrHA8xvg402aDSIBrwGQ6vz5pwKpwlgw0L9S18J2AYVQHg?=
 =?us-ascii?Q?WwaAk38BqN2lOdXuIdYvQnaIKYM5qCMe6ta3izbyUwXxPyU1axF3NcGd9meE?=
 =?us-ascii?Q?rpatH/Nu+QISq1vw4CE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d537f563-d8d8-4a7e-c36c-08de1e1da66c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:43.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJlVXqZ7HxOrHW6Z988n/bABr3NsDSuUOEZQvLwCewBUB1HvggfQb8PUNmW7J5Y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Make another sub implementation of pfn_reader for DMABUF. This version
will fill the batch using the struct phys_vec recorded during the
attachment.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 70 +++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index e71796b0c4bf44..935184dc68be32 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1076,6 +1076,40 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 	return iopt_pages_update_pinned(pages, npages, inc, user);
 }
 
+struct pfn_reader_dmabuf {
+	struct dma_buf_phys_vec phys;
+	unsigned long start_offset;
+};
+
+static int pfn_reader_dmabuf_init(struct pfn_reader_dmabuf *dmabuf,
+				  struct iopt_pages *pages)
+{
+	/* Callers must not get here if the dmabuf was already revoked */
+	if (WARN_ON(iopt_dmabuf_revoked(pages)))
+		return -EINVAL;
+
+	dmabuf->phys = pages->dmabuf.phys;
+	dmabuf->start_offset = pages->dmabuf.start;
+	return 0;
+}
+
+static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
+				  struct pfn_batch *batch,
+				  unsigned long start_index,
+				  unsigned long last_index)
+{
+	unsigned long start = dmabuf->start_offset + start_index * PAGE_SIZE;
+
+	/*
+	 * This works in PAGE_SIZE indexes, if the dmabuf is sliced and
+	 * starts/ends at a sub page offset then the batch to domain code will
+	 * adjust it.
+	 */
+	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
+			  last_index - start_index + 1, BATCH_MMIO);
+	return 0;
+}
+
 /*
  * PFNs are stored in three places, in order of preference:
  * - The iopt_pages xarray. This is only populated if there is a
@@ -1094,7 +1128,10 @@ struct pfn_reader {
 	unsigned long batch_end_index;
 	unsigned long last_index;
 
-	struct pfn_reader_user user;
+	union {
+		struct pfn_reader_user user;
+		struct pfn_reader_dmabuf dmabuf;
+	};
 };
 
 static int pfn_reader_update_pinned(struct pfn_reader *pfns)
@@ -1130,7 +1167,7 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
@@ -1162,8 +1199,13 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 		return 0;
 	}
 
-	if (start_index >= pfns->user.upages_end) {
-		rc = pfn_reader_user_pin(&pfns->user, pfns->pages, start_index,
+	if (iopt_is_dmabuf(pfns->pages))
+		return pfn_reader_fill_dmabuf(&pfns->dmabuf, &pfns->batch,
+					      start_index, span->last_hole);
+
+	user = &pfns->user;
+	if (start_index >= user->upages_end) {
+		rc = pfn_reader_user_pin(user, pfns->pages, start_index,
 					 span->last_hole);
 		if (rc)
 			return rc;
@@ -1231,7 +1273,10 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 	pfns->batch_start_index = start_index;
 	pfns->batch_end_index = start_index;
 	pfns->last_index = last_index;
-	pfn_reader_user_init(&pfns->user, pages);
+	if (iopt_is_dmabuf(pages))
+		pfn_reader_dmabuf_init(&pfns->dmabuf, pages);
+	else
+		pfn_reader_user_init(&pfns->user, pages);
 	rc = batch_init(&pfns->batch, last_index - start_index + 1);
 	if (rc)
 		return rc;
@@ -1252,8 +1297,12 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 
+	if (iopt_is_dmabuf(pages))
+		return;
+
+	user = &pfns->user;
 	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
 
@@ -1283,7 +1332,8 @@ static void pfn_reader_destroy(struct pfn_reader *pfns)
 	struct iopt_pages *pages = pfns->pages;
 
 	pfn_reader_release_pins(pfns);
-	pfn_reader_user_destroy(&pfns->user, pfns->pages);
+	if (!iopt_is_dmabuf(pfns->pages))
+		pfn_reader_user_destroy(&pfns->user, pfns->pages);
 	batch_destroy(&pfns->batch, NULL);
 	WARN_ON(pages->last_npinned != pages->npinned);
 }
@@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
 
 	lockdep_assert_held(&pages->mutex);
 
+	if (iopt_is_dmabuf(pages)) {
+		iopt_area_unmap_domain_range(area, domain, start_index,
+					     last_index);
+		return;
+	}
+
 	/*
 	 * For security we must not unpin something that is still DMA mapped,
 	 * so this must unmap any IOVA before we go ahead and unpin the pages.
-- 
2.43.0


