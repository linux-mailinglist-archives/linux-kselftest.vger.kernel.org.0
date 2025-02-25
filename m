Return-Path: <linux-kselftest+bounces-27474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B1A44566
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F8816774C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E18188A0C;
	Tue, 25 Feb 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmkNAtdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A01885A1;
	Tue, 25 Feb 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499524; cv=fail; b=Zsb7KYJOVB2Rafkp4o6UEwmQWdgW0Fk/lK6p1H7xgRQ19qkjbCvYvIOxUfr23MMriIpSV+x+qAOm3+Ythiw+Nsi6cmsGOcbLmpFCTU5Rk5wkykLL1mqXcsfFrhgV+43JYZBONMJkd4069ZYuDo9EuFdBQI4OjFinVSkKHzfSduQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499524; c=relaxed/simple;
	bh=jx1CuTq1NGW/ccCoenzf5Ya1dH52O0QNhWFRUSc3wOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GnQbL+jw98NLJnMH+QcS0313bYXzcalDXDmta8lcmcwpLSGaYI1MuSqXlVkwZYwvtuqFiab0MIbrV0kRv4neX3tQCNKdLvEHGoJ3akN4WZHA3tjpzVFM2Cd0D2wbjhY5kqzH+Cg8GeBO6Mfn0qA+Bkb2xmKXjKRSS96oVLyW4x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmkNAtdT; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAgOslnx6ILb5S7Efz+xVOb3H94BCXMvluAtKD/GkmoF74eTCsbpL2Xe0yYmXcvTQE1BGEA1hj+/1FlniLCXQVikVVFOPoRImx7yFIbSO8G7zY7+ko3ost+tY1+n7T+WMCxjKqHN6L5rv41y94cAJaDe9bKCJQog0mQqMjFaJr7RATKc39N+WWoTnqgSwevhjIWgd5kFsoB/FmiUOGAgDA1Bdr68DDqlm5TRfzE9Wic1bJ2IfLLWA/SJmkFeIRynRlev3XDOlajipJrfiu99AURLrX38JmGQeGBY2iyxa5V94tpK/BcBSnRyCKc2JKm8PkdmdkhI4gNJEBQ6irxYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V15IJVb9dOIZyR1nAYZltqFctN17C+1CwRBmHcqqNQ=;
 b=wkdH5qDIBjncCWsaA/QvYI3m+9bE39Fobf633sJdOleen01bq7hhqyOGNfCH389/x52KiONOsvc+9PVmkr8M03OAbtesCu8cNKlQALlZTFxHkR+wuhfS7qPGiWuu6DmE4kZ++xbc7zgTSyKIWlF3j0htUkChRGYkvn423ljlH8e6VgJPLOZ2JaPyFBcwiblC2bztV5F7+pD4r2AG1jPliU3/0gED8b5HnAekxDBSdNg5VjS7P1pbUUIcmB37xIWT3nJhtRSAcLUGwJp48xcULyhYuCmU2CMkjI1PCeA1U80yVDg655vSCdxfXwZRX5kaBnOCzpNosbpmO/2Nv1wzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V15IJVb9dOIZyR1nAYZltqFctN17C+1CwRBmHcqqNQ=;
 b=CmkNAtdT7po63wMwjnIE0LBBCC5FEdrkQMo2jFD0ihdt4Ocy0keQaCIRHfa6AdFSFykaXL/fOmLt7/lRqE+F1vNSLVg6JgEj+Qv8NNDGTlYl+BLtrDwRiUEliddgrJlWndPZN76Hk6mCLThVh2j3pekRPprRaBkCxcKY4sctKYdddz6HLt5jaYrORvFeb+EmkGCaBK9Z9EceoLgKep8d69cF+DIhLzET7dq/8szoVgS+iRfL+omCm9upsOpcHQKTUVB6laSCAMgVT4e9NIPAwQhQW4Sy/Wv500OI/gWyBR/EUb0fgnMFCg9B1AM8iJAcpY+l0QWD2qnZAuIHCq6kaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:05:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:05:20 +0000
Date: Tue, 25 Feb 2025 12:05:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250225160518.GD587949@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cd42f2-5ef2-403a-8315-08dd55b633c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqduUrPW8kHd44Fk5Hvx9KHJOH152kQYQdBEnGnuQtx0CFdLByUSIEyJgO3D?=
 =?us-ascii?Q?mdUbmKSRlQJcStJ3jYLioDEAr+Q68qV8QD+qbXCE7C4X4pelFBOlsXvRCnYb?=
 =?us-ascii?Q?jawjndGBFn0+T/jqtZYXji+2B9MHOqARx6kjgHkyJqnZ2nrMLQj1EZJTIAgQ?=
 =?us-ascii?Q?hU2Rq5zM1Mz6exU1E0Kq9GLufPNwL6TonxAqlEOSKOtOn06GWtNn8LtxUuBZ?=
 =?us-ascii?Q?C3x0sAegtz89Gcn7qlvugfUFKIz0caQGMYY0pEB+f64AdZJBZ33O2VmAz8vt?=
 =?us-ascii?Q?PmSQo5pBoX16/tqsfu4fslJOI6Pt4gkKu4DMBg3oXcX9Ez617VCAFX1TcJh6?=
 =?us-ascii?Q?DfPmYhRU2nR+DZAuE4TMqeuZ3cn5M708PACfw6GEcwfSh1FlauEtLS2Nqr4U?=
 =?us-ascii?Q?+WENo0TVXgm0oxClrESWBoVVUMECtZrviAT8bNWIyiCRdedwQicqaW+Zc3ED?=
 =?us-ascii?Q?I0/+Mt2+XPsg1B8djZcywrPfDrbtBnuQZq3p4Cml8BKDokmyBY/PW3gj9ga3?=
 =?us-ascii?Q?MX7hu2TafrYIPUfOK9M24r2YFlRgG30vpZmanU+mCj9YYfW4+jrVlGAZkMAb?=
 =?us-ascii?Q?PkmUioOtrw2nQxO0IN2OOXbUxmP0jzr1k8NVkOaqZJ4FaUyF80S/qkbLc3c1?=
 =?us-ascii?Q?i/bski8uM4wRHnTDG+9Zh9wsxmtn/xYVyk9zXB+KZYxBZeEoA4O7hwpcwFj/?=
 =?us-ascii?Q?IFub3QMB3PK+sBOdp44IKz7+bCQO5ODn+MPgwgyqGAAJdfGZaxR7nlRhWFLR?=
 =?us-ascii?Q?lDEc28WvkMxKMm+QhiVrjEkvTD3FZgJUlH/aCq+0C6AOeO6sRLQR6dPrD6P2?=
 =?us-ascii?Q?2m9kftEkyt+Mc9u2nLAbrm6VFqbQq6Vbjk2a7zOFWptG69dz1Cs1Xhh1r/Lq?=
 =?us-ascii?Q?UENTu9wY+XtatpH0ABaRgt7mgNTzr9U2bx99N8d2SRSmXG8dxQ0jliaYHGOA?=
 =?us-ascii?Q?HFch4LO7XezbA3EnXDuPcslHiboOyQA884/kIDk1qVCO7MmKWDfgxMo75XAE?=
 =?us-ascii?Q?0A/mPIV17PKNxVn/zwwd81VG4+QUM9dsYddukQa8HNflkmruVexsqEwD8Z/f?=
 =?us-ascii?Q?jDQfmZS7j7bxWuJfKxkqwlgcLEdPLiVdjrfZt9W0kFQL2Wbzgj4CuMC07vur?=
 =?us-ascii?Q?MOwK6/usK5aKuyap7Im7czqzo65K4AZroPEJ3ozB9yDBD4fqW2rVKOi/uBqh?=
 =?us-ascii?Q?85Mb3FOo4fCq91epirlTNhtC+axT0kOrLFBiQM2lSDd09Q8kMIk0Uo9dcVEg?=
 =?us-ascii?Q?4zoQk7rb7i4za7eZizXW7xgNFizKh3/2mggQRonOYRZe0UuzvNZ+EHjyKAtD?=
 =?us-ascii?Q?lXPQm3210UbIH3vOwT7ENMCPkrj5kAp+6zfMD6xnLWQNADHf+12LzZJt7aLh?=
 =?us-ascii?Q?QTos8pU0/eKrqV+edJRMn3Q7fjt/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLwII4HwY3cwGCTOJyX+BcCoPjsOU89+0sR42nZ0JGndU6ZHH2kSW5UTL5jI?=
 =?us-ascii?Q?v6GfcgV+NTEW5Ms42wSD4HUsBFcUvk/Ipx8PyGT5ko1QHz+rlJLQDl9fdSud?=
 =?us-ascii?Q?nmaypIYPoZhc/j3TC1A0nqE3Nyci9IPxDfCWNE0a5QUiboTJaii1W+zGfRJn?=
 =?us-ascii?Q?SUP+ImB7qijWxFaJreF4Rw3IsWECEV1HopBfKuWJyec6ohjaD8cx+0Z9aIFj?=
 =?us-ascii?Q?OxSggvdQi40rnes60+hCmKnEcjXeajL7bGPQm22uwkVAwaixMr2bVy2LaY9F?=
 =?us-ascii?Q?de7SdUq+ONZkTmNZCgXHBBBsjl3foh/KrJ5xXTrlC7F9IXxdse478I7EEfOf?=
 =?us-ascii?Q?FBjGWao0lvYLqfIZAvJO1RMkWpdzAKAOhotms9R3oHXD4ymOyPWIkWBaDSjZ?=
 =?us-ascii?Q?FAesaBrbiNtHAIDgxM8Va6LEPyz/bfB8UGsl0fFOc3RDkQtKMHgO494U457L?=
 =?us-ascii?Q?S98/V7USTtdliVbeKTgNpRWvbDvfPK4i6OrEHExNftNv/EL4nqN3Xa4TxrhL?=
 =?us-ascii?Q?O3qYwr/ElKTbq7Iy+Qr+4PFvuQov0nEkqK9H8lTpEL6fYNZd3yiGEq30idpW?=
 =?us-ascii?Q?yr4O2tJn0AGmtIekCtQ+pcfEV5jRaZwnqdBxlCpCoqyakrUu/7wExNKaR1Kr?=
 =?us-ascii?Q?G6nbWkvkmpXy+7wNAwKIEgNaDrj390iM/aousOvTPvgYHIaxNYdQ4DEFsVid?=
 =?us-ascii?Q?CW3F1+ykR7dzAtP/wicp5bcas17r+YVkz0XDKCYi8njxmVzP1miIjX3wKyga?=
 =?us-ascii?Q?HjZ8yOeZ19NhAYB0QulvfeYnxmZTFIiPO8rx4QFOJSHJhSEbntSn8Dxu/yEk?=
 =?us-ascii?Q?MDb/5R13VFqrKluKHQkFCGgaN8qX7pJlZL+ImA9duxJOkfXmacgTkK5iW8B+?=
 =?us-ascii?Q?BFhyGygfCJiRBJMtWecH7B1ObqbhmX8wIf158QfnI5jFrBKGvDGP9X/9Nd9f?=
 =?us-ascii?Q?DwcMmY6rRxMen31fAXB7Htq+mHT3UnBVUaybpsaRbBbZF0ECPJUnR+4oZZ5E?=
 =?us-ascii?Q?CCu05Y6RUPzM3rOAE5JadY5D9lgKGgaoSxAqpH/YbKSnmKV3mxmDrEhHHswZ?=
 =?us-ascii?Q?/ni0RQDregQGz06i+AzQ+AHSfVmAQZCM/2qzlGEQ9EN3s2nVPTOZyiyN5CJk?=
 =?us-ascii?Q?U6/mKT2M/q+z1s7iWXlb/ok8lJc+gUtHUA6mOTlBV+4ZDjEAALjgFV/Vuynj?=
 =?us-ascii?Q?qsHFFhMV7XfqIgzu+cYV/hCGKznQ+q4mef/pz23n55IxFaGCJhvsFKPijPUw?=
 =?us-ascii?Q?g0RKJN+gnkeAmmERK5XR2ssWgYpy91oiA/Egck2+ZYwaSoLiRyRPfPtIJshZ?=
 =?us-ascii?Q?tIIh7UyLu0mfJiKhSWBzCj/Z0+xnJEg9yysPQDy/rN1xKkoXhDOTfCUEMaXd?=
 =?us-ascii?Q?zCsTb99ck6KRYEqOf8bEGCfhHgdu682iUHX9huW+veQmGC1BmawZeAcgiZN9?=
 =?us-ascii?Q?ekV8XTGTSDBwhnRn/bb+K9wW5hRvLoH8TCFjDMFe8s5tUjRcWjxJNdNyxHxo?=
 =?us-ascii?Q?fU2/6dxEVXzmn45OGjYlwj9hfJmyE3eKP1vvB+IEW2mr72xEeTgMFYEHfTaq?=
 =?us-ascii?Q?nrfOnpkYABoVxzU0LzF4pfrVxBeNopH7HlkULINT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cd42f2-5ef2-403a-8315-08dd55b633c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:05:19.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJUuxKBkhiKgREMn0gcweTedGeYJRjup1boTS7FslcFM0Ov0QQrIxokQS7cobeUj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On Sat, Feb 22, 2025 at 07:54:10AM -0800, Nicolin Chen wrote:
> Aside from the IOPF framework, iommufd provides an additional pathway to
> report hardware events, via the vEVENTQ of vIOMMU infrastructure.
> 
> Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
> in the threaded IRQ handler. Also, add another four event record types that
> can be forwarded to a VM.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
>  include/uapi/linux/iommufd.h                  | 23 +++++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++--------
>  4 files changed, 82 insertions(+), 25 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

