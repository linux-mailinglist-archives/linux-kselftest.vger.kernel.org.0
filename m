Return-Path: <linux-kselftest+bounces-39975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6EB37118
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0642A3674DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638C52DAFC9;
	Tue, 26 Aug 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lV0zOEcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5E2E371F;
	Tue, 26 Aug 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228729; cv=fail; b=sxw3L7KUiRHn2NeqjET6fY3A5zNbAR//KGMuTLBw86PzTGv/Wc/gmpmxiPkZ/bZwu2EL99MSK5dFmEgnd5BmD5HvTMRdVCLba6ikf9oWI30l/cqdQxJNRgJVjyolc8GKO77MA1C+Oan/iFoWeGcTSDsA3NjnOdJ+mnvFRue13b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228729; c=relaxed/simple;
	bh=T1nYsqQkhuWIaDuwS3g577cxdjwA014VnHa5fvH8OVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXbG2JyQtolae2/q0lr6MNnePOqMUc7zCxmch53xYgTh+UXNxIAU5+d820dpW7XwkYO7jTwPHP7X7qXF7oVLrCV4IryeJMgTllVu3NSjal82KboAQixcqsBNplnIn8WtzYzQryZfcOpmickovdl2c/85j3p47iSTT2ag3QyIBkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lV0zOEcu; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbA0zfOpQy41BjJvd75UztMDyNff7bNE9fEyW/cvcdFCatU+QQk7/wOi8DPP+sKfQb3xdVRKShuyaFRQnyMqd+mRU4KX0J0ZjE0elk3oC9jqEam93DlWBV+Kg4vw+SffooWN5xzCTEtZky0eDnxALvaPP6nNvATrc0XYBqw6pktM3K9Oo8v/o9xoPxbkEAQo3mzpqATzFTECEHJT0uOKKYeGD9O2mnOKKBMeL+XQO9NxdRnK7pw4yq2f3X+oeiHFiWPICMq3owgiy12r7EZhGnnEfFQ7hl0dZg/29294jfHirwEKW78zIIcMoO3QglS1Kd9Njpzt94WS0JtEPuimXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGDqw59iK58jjiOAqr3xfLKXZDMZDIfyCKziPsfoslc=;
 b=NKjaHTioNkHcgAK52zI+r/b9NVJd4/PjxSRkWST6w9KWJAlrCeUwoFBtg8oYPBxCjcjEuGwT6p+aQu62Zk8cj46gZUoceNldqk/91rSuverJjA1JhxOI+50kXxFQFgkw6OCgW175L+Ql6O1aM8UbnElqF25reFjx1E0phSNjKqS9Fl1f1k2SoSe8UycHJrzJ3b6Yhwqqv7OekSnS2Y7zxQtRoUXaovoYVePQfpEXGDNaZGIogs4GMg2gR/rIP3yC2S/0T2r2cvFMr8Mj36T+0YWva6yJXxKtNQISGpXaMkXpSuUss9jJKORb/lgeW0Ay2Bvpi9JM/58f2UwneIQ94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGDqw59iK58jjiOAqr3xfLKXZDMZDIfyCKziPsfoslc=;
 b=lV0zOEcu46Mc5I74YFS5vVobuh1FEEDa7bGT9+igtS9ciN/Cv8x34JL/5/s1rOB/a3MHzBYd1xWvwFQQCHEXbTJ8mvvRtToM4vwwle0EtGDtCCcIG4pl7u5aVXfgRXEws/wp0Qp25oabBipTkUyVDq7zoHGxGF8bQszLhLzONQxG2xGLZq0Rs7wySjnqN32z+AJ6002wABdSoiBaG6xBEgjackO1v/B2tbWie14v5VMHgj+fGivNuLKbgwmlcJcIGB/UlRW+EzwgJADN/i1WqzVfEd4Np0cS9j63h6DkWLoWKPG6UfDKu2CN+IzAdKXSo46ccPtd4l+q8n3u1qNzRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:40 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:40 +0000
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
Subject: [PATCH v4 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Tue, 26 Aug 2025 14:18:31 -0300
Message-ID: <10-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1d50b3-40c3-49c7-9f26-08dde4c49973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96hRKesslGSWwFoY1TxRhlpfnSuO98BZaqqhDXZalxRlMgALsqZYBlkxVigf?=
 =?us-ascii?Q?JldtgexepoI5KWGN/Iw45uFxCYVkRW4W3CD+ztX79CjFoO0/TCq2FRwjLjjC?=
 =?us-ascii?Q?w2wvNKqEw281obQZPRWgi/mt3IOThoJie74qhutJlCRa2TBc8tjuLqiaBrr7?=
 =?us-ascii?Q?oklT9pPYA/Uqs1YFFy+g91+cTJEMimXhRNlGNwEdKomqm78L2jCpGFrOza03?=
 =?us-ascii?Q?rl+SGxV2RwS10vzLe781HtN0VG+CWGTHrgy8fGS0ZK2HZyaWUPUNGU1GQNBW?=
 =?us-ascii?Q?VnEhkJuXkHvol9vzcw04D8fe4Ma+NYlLRBzjFDpgdjCuLlyUO4VpZDGJ2rej?=
 =?us-ascii?Q?c5mJV29AQzmwGqlbr0vfyIQZYdg5Lza2j8rmkpuVJYYZtkUf40mZXlrp3M0L?=
 =?us-ascii?Q?5v+DBKzz6FhWiQQ/2sCE/tSyCGrpKIYrP42ZtTXeaSPWDdq/N+PL53sLhwvc?=
 =?us-ascii?Q?6UTgGuRGcQWkjuGRYxBE/Xl5lp1pCQHwiP3bnGDetJrRpxAJf4j5meTLxGRW?=
 =?us-ascii?Q?hLhqDQscdO3K/QyZq7HzRIPvASe9JpSDFxT5v3FA0Lpy+fd7lKReRdWO6w4B?=
 =?us-ascii?Q?bSbjW2p5TuOJMlN1pT+yAhY6RLCo6dYyc/+uNXki3mzeJetaiDXxliomWVn1?=
 =?us-ascii?Q?CSS/ItvjelyhGEEA9I4CgfIVMe3xx+0enclmP8BrrnF49Mdtoj61hPz6wuyU?=
 =?us-ascii?Q?XQWQZod5E4x9XcMgstVxx5ksozrGRiakOPV8AOwKiQA3T1J7R95YW+Bl7S5i?=
 =?us-ascii?Q?nnDIItr4M3e4+GYt/IA6rMVaqAZ9/ZX1RCxlLPDbDqvDW9D1IMrNoKN8SmGU?=
 =?us-ascii?Q?AwdJIVltJIQZErDu9yj07prLbH4HFwmuugm1hACUmoCPlOH0qI8V2k+P3i1G?=
 =?us-ascii?Q?8w6whevnslRZutRCH1mPy5e1RmuqDw4OghpJjOfDGgRyEY4BNOtqR4bUJWPF?=
 =?us-ascii?Q?QWZyfW6tbKzYrwgK/T/IDEs6AQ3kqd33ZYK7UjBx2po9914limsQroICKVhT?=
 =?us-ascii?Q?zFfOtgNFEegYwNKk9RKPp6dGNxa9bQ9nqtil++xTGglDjFNAkWK1Uug5Mk5t?=
 =?us-ascii?Q?AvkSPgqqt5FkqCWWQpHmHoptNdKFkGxxhOVXfEVyjsSFFNLKwsngFjMeUYkG?=
 =?us-ascii?Q?zB18xrTiPQndg2tBoVf9T7kq6bBTf/ci1INiJfvlBTyBYXFvgmO+PmbqIhte?=
 =?us-ascii?Q?/ixNI/q6wZ9LiatZKbD36tEulO2HjRq96BUxbw5xUp2Ob88HdVaEy0e+TtSJ?=
 =?us-ascii?Q?zMQg/wQL32V3DyWDScS20oNGHeoOWqh5vzQ0r4/KvEicKVozoFk95XurG57C?=
 =?us-ascii?Q?UIJX6x8sucbmlmV0ffocyyBtr4LTsW5xexfL65zIM99oQNV1XjdLpEwD+JEV?=
 =?us-ascii?Q?3dwg7aCBjYDR2UJJeH6HWO7XkECw3Llx6NhuiyC/e5Xx6+97w8coMOvp2aa1?=
 =?us-ascii?Q?7+CTdf6Ler3/C6/2lXGvEAd9hT4SKybre4gHqD6lOd7WmGj1snS4tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XAOn+OLRaBG2zd2Z9xFURjQ/oEgTTYuLnDmtFnMiTAiKlBH1Ra84IXeiKw2A?=
 =?us-ascii?Q?FPqTyO/oZ/Cz7K/n68dNw70aQ1axK4FiZ78qqjWsvBdqsnCJ/feEdQAh3ocg?=
 =?us-ascii?Q?GOY/VRDSW6vnlgOgWLyxA04EZldJnLFg+5XGQZGZGFM9umavIOHpfu1XmZtf?=
 =?us-ascii?Q?RdWlLE7PhWT1ISSQiHXyv3fTsrz+4uwd7mKPZuKF5TK99JWsAhcGoBJBw0Qz?=
 =?us-ascii?Q?de869D+xDHdO13IISJeGk3Em+m0h1VPZRpqxn2HLMWrBQDmk0R9K0rppRMKl?=
 =?us-ascii?Q?EuQDaLb6QfWwG3qAffldqx6hpvLGRlw3YHUtHhD9/UpJkLEZvnavUyXFz38Y?=
 =?us-ascii?Q?nTLcUse+EkBwZhr/AozHAj5kpfKrTv5YZkgP/UAazouH8MB4pXoCpOUUbX2p?=
 =?us-ascii?Q?PGfSeiapzjkQR9B/PsiY119y72w7KUmBcULIivY26f/rQBbqi7xUzKzzw/Eo?=
 =?us-ascii?Q?qel7oECV8DxuL9Tdrwhy0Pt/iYoFZRXSd4+hXm5+IwL23G1eNhYzTXr7IpDO?=
 =?us-ascii?Q?VW/4CMbG8O+z1v6O60UPO20lf6PHLn1rElj/5AVmACFTiNrpwAxtGzU4T1vT?=
 =?us-ascii?Q?3U/yz4hksVccK/jB5SGV4WegB0nRy+ivFLb3tCH+O1DnZ+hhsLf+nJBxOr4i?=
 =?us-ascii?Q?jiGlngz07qTnJdO/AU/BL6DUcIwdnFJubR4Nt727eWdVEVqwcRNFZpbFCRRn?=
 =?us-ascii?Q?mGPvmacD+mnO1+RMPRTO1Cb4k5N4H3nnvMT+JvY9OvEjZVWOX/m4A8SuN2yI?=
 =?us-ascii?Q?ecgv1qNiTC9cLaP3lTXdwOHsJJaAZK1EYa6HrTa8Wj0SIZEcYtEeR6bDvxrA?=
 =?us-ascii?Q?IxGvWlVACdHrxb9tp9XMEeBCHNgjIF4byK4NeXpQX0lgXlZvjhqxSDCDGlvM?=
 =?us-ascii?Q?8ti2x8TIhxK+RVtcIGZieQAeK+EM/N7Kg4xcfSHY5xsXstfrBfV2Uv6pKehk?=
 =?us-ascii?Q?z1oupIyLyaTXa1h1rjBmYLs98p8SmMY9lK9PuwmG1xu+aaBjNLxPWwpu8KRO?=
 =?us-ascii?Q?LC9Wf6q8UWGJfITk8fdiNzTUfFysRjAUYKkgPARnnLqL/NMczfdpnzTLvVpD?=
 =?us-ascii?Q?W6BAsCD/anCdBs4SK151qnPWL6XEtO4KB4CwFJtZKyCJ6v9PmJ5K904pz11l?=
 =?us-ascii?Q?CqtjUhm8uGR9F+GjU/q1Vyobm3Hp0InxSBmVdaa562qxuxq3V/iwpImIHxER?=
 =?us-ascii?Q?78TfFVms4MBSX/3OxhpCIHqTk5yYozlhfIv3nRGEzo2Qg6hoFO/SFII+OaQk?=
 =?us-ascii?Q?1gXcv/xSLnGjkWCWlmsSoLyaYOsn2KWVYQ64HhZgwYe82/EKJfuMNWeyw5hH?=
 =?us-ascii?Q?KL1J8qlFb2B/6WLzPn/rbmdCS2r1s8d4V3r2PAx6iKtDU65AVMQfx8Q9EBJv?=
 =?us-ascii?Q?sxTxmWAV4ZanQXy8O9rkK6Z8osReqSptp2XkHXzQ9D+FWxcG4JLOWRuUeW72?=
 =?us-ascii?Q?zLd6xteaiK/ipkvm9TQiSgcZausLmvrgri4Z+4tzdIaWMkwrSmV9W8RI00MB?=
 =?us-ascii?Q?NX673XyuzaVEjxiqwv5Bu53WHxyu3yEbtY8r8dPpG/yrwtP3y5diEfxGJ+6w?=
 =?us-ascii?Q?BKxFmR2Umk4hdttNALloOEv+5NXZviSwUkri/twk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1d50b3-40c3-49c7-9f26-08dde4c49973
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:39.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3p3V7ZEO/bK1b39sKBySE124IShb+RTaKD2ZhnEo2xZ3HkXXgWv2W8ZXTtE/aeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index cd72688322c6bd..c7442d85a919fa 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -372,6 +384,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -382,6 +395,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 658ef69156121f..cbe6433550f380 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -236,6 +236,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


