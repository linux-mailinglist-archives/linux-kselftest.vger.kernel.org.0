Return-Path: <linux-kselftest+bounces-25000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7ACA1A4D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66206188C0DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96120F094;
	Thu, 23 Jan 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abQdZ+7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29120E329;
	Thu, 23 Jan 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638738; cv=fail; b=HChAQbczSTeMchVy5AW2wuBKBz1ANUUeHsRZyrOv+xeLTEMTv+px0jDHORowiQvWCMkCm/e113O76FEEiw0rl0+6xiKuXmOOu39MOANMTLTVXHalyGyEVy14LL9JX//bozvjk6pSs/6Kg0XUxmFbmx+KwFoT3LhpoW475kDBwu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638738; c=relaxed/simple;
	bh=TzDe9+pI+Uf9gx7dG6W2PrSN/wLSCi9MXkI4gMIOu28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8A9uianvC3ZMQH0A/hkhfhJZmJiRNrTOZfBRIhMUhucYcvW1ueIudjAEEU/zhVdURMM6hyt7z05fHVYbRKvn4HSN+wuWMu9PbcPuDafv1t/PWqPJjKWr62XsqOVKoo+yxxWhW6S41SIFsRKAwpLfNGxyuRISMO5FqqodhnCjV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abQdZ+7T; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo+Mdnwaq6j97TuIiMDi7I1/h8QGhjkNynWL/EIrMvalT4eVB71lEXDEy2+zwVAxmy2IevzOo4AnL2JDVE9LL6JrgUposStsPagls8Ym6jpscn1zPGdaoFJ3BwnhfS2wNwrkRc6flAmmthDWGdkeIcypxFPOrSKbK1gcXqMlJKey+3u19Bjv14zZqrFtVcQR2+X4+JxfOyfXnuk9a56Z14m8fZuEoHc61u1JIM7+Z8mOa7GhBvrYZe2X6PfKhrNIQk0ERXdMF3EJbLU5ynnv7wKXWXapebS6JWcJL55PKpbLrb7xkcwkICrKKfbhcUm6dTgq4xTuLjGmSZ5/uUeGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSrtWHvWKBL1akKfyJq5moH5pjFeVoDxrlD50TWoMA8=;
 b=W+dMVGzybgchDD/k1C/ruKlU8TPtYPTCi8HkX0wU+49E+sJyNjkadPuXRgLXo4sc9NiGxpAcWjuMuPAHz+VKYC7aSW8bEeaG0zqNaeGDjmRwWGucv0p0wOG4EiaOLzJvZq/xaFddvwviNxoVzmayZKh0Qlmdu8QzwjniSdwCfVhg4q/wC5Rhv1u8hh9DEj/osaR+78DgVNoD1v4f3/akyDI4WkIsp6XZroSMlIGue42okJE98QQ/z0u4iOR5AKS0ee9tewfOoiSsqp/VijBktvr5dCkY9pahabJCpeFZG76Zh8R7d1oEN/2/E1DBB/iBJ30tHLoMXZf0IM4tOPRB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSrtWHvWKBL1akKfyJq5moH5pjFeVoDxrlD50TWoMA8=;
 b=abQdZ+7TU1e5+XWBVE++md7o62DGqJkWUNycaPnMEWSeVAetR1OGvii08fcdnddhWVNgWChFU7h6WJ57Anck48zZPXPzs8d5IcJ4uRQJg/Ah7R/1WlhMRV6Jc6Y2xB2rGrtkDMGZ0EerqgYKbH/DTtMl0foUNYIySKSYtAbRcvgOWzXO9KcRwalbAPCuidxLxxdzj/B4Jsz72B9hFcQ1PEx3X4x1IwD+pBjh0q1wfKN6CzjecBlh5/JcYGDqP6FlED6Xud9BuQiHl2HEqP4kICffAV69S7HLbvy5x/se5QoBvF97Toq5bIoMHd0HYyWCvupGc4Fb8ImqzdlKJ0KmRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 13:25:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 13:25:34 +0000
Date: Thu, 23 Jan 2025 09:25:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"yebin10@huawei.com" <yebin10@huawei.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 05/13] iommu: Turn fault_data to iommufd private
 pointer
Message-ID: <20250123132532.GK5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <3b26ce04e8ecb5e47f028fe5cae48e5235e68420.1736550979.git.nicolinc@nvidia.com>
 <BN9PR11MB52760606D49DAF6ABD86835A8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760606D49DAF6ABD86835A8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dacba8-5244-462f-4a67-08dd3bb16a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHOFmjxCrCv6REUspBcVIRa3gxd0Es9cZE0b/3fKUzcRkMh65I/+lNB9GAHq?=
 =?us-ascii?Q?1kLIQ8q5PEp2xCkjLB8ZIawVlpNAjDRAWXFav3QB75L+TXL59WOFM29xByr8?=
 =?us-ascii?Q?LF5eeb91qdHuygHuEYLDCWfu+TJTMcbSU9JdbHPNzRsK+CxfgXevDkBtU9Iu?=
 =?us-ascii?Q?RC9LNoCkwBIJeMeEMKfsRWMAoeeDfi56MKupdE4BL8J2hKb43p9iVAJtdtND?=
 =?us-ascii?Q?7HChhl5G/yNd9pS9dwAb+l8uuUVjLKWWQVfhA52/aJJuRmaatY3mAu58bmN/?=
 =?us-ascii?Q?+OM+Rez0389v3KhCTAUO44Ey/e1ZpGymS7wB3+ieZthT/zPuaTQ7I5FLQI/l?=
 =?us-ascii?Q?whC54qqGtAdEodQp3Q4PZJHBoksMjyEuLza1kK1tiJ9PAJNwi8Pocv5rJYqP?=
 =?us-ascii?Q?3uHoIDx+Rb6jerlLHv5zeHMY0tirSrUUDp5+C2rHfLfdbFl/VWqCP/y88pBR?=
 =?us-ascii?Q?thXbixQEmq3YcA35Ql+AxHPo01UdmB32a/mrC0BsgtygwI8TkFbhPYPpYaUT?=
 =?us-ascii?Q?fjFpdau/eAHO+oOwHqqWlpuURp02q2byg7k4ZQHmPKxpuKJzRu1ICJg8fzHi?=
 =?us-ascii?Q?cwhT9nKGvu3Ddafv/mA3PqILrp0WYQnTahnCKoLw6j7zq+Y6sQ2lVobuemCv?=
 =?us-ascii?Q?9RypICT9B8yPNCL2WSqOxu69Epa5T1rux3k+bY7fwWVT/oxoRpj2wNsHXjoi?=
 =?us-ascii?Q?w43LxiXTHzrygezjaa0hXheWQGMRp8zJwCF/lDWtCAEoRIdeRHTagvbO/X6E?=
 =?us-ascii?Q?O4ct3yiMctuBYsv3PTm/k6si29EAXSbuAYXdweMoCmRaqh4R2DRTx6UF04po?=
 =?us-ascii?Q?4ZH7lJRx7iANFV/wNXhjODcVYANTIq/bL0Sg3NsZLVCaUiUJyInskq20EgP9?=
 =?us-ascii?Q?kL0ve88Vd96CTGTmQDIFGHrRqaPA6ejUxEK+m8w+jm9Kww3ui9GtB08Psbxr?=
 =?us-ascii?Q?dHa9ch+AiSknds+cRsWuuOUA8Heb6bYVqpi2kR/pxmdqLX27kwusLhgSobsD?=
 =?us-ascii?Q?mfsPyNNe+5uNy7ji7VYM2tYJx6OLmUBOhEX8CGEIm5kp3WNXtG2aFCTmK+7W?=
 =?us-ascii?Q?VnDiScPlwqDPMjXvfifff8xOtPMvJl1VLsaZLHmjgzT2zkbv3709EzxpLuz5?=
 =?us-ascii?Q?1wXOfatml1SRx/8Hmt7G7XaNoHJc9N1pYD+RxuBLDJMUja9BVqbgacTI/IQx?=
 =?us-ascii?Q?ronAE/GKRfKifO6xQoIqyUeN5fk6hs8FePgcrlHcpcXZBdk1h1GxB8Q2EZ34?=
 =?us-ascii?Q?67pOwha3VXJkFqfzBIDXgJvSaT6vm1KyGhE+3sEUKqD1yhDxTReBGvBb5rd1?=
 =?us-ascii?Q?hAYAdwISvG18z93oAghwISc0xU9PzWa/pi6L5hsabMU0ElkpPB/UIL9gKSAE?=
 =?us-ascii?Q?tkIpon/jhaeEshDptviaQrRltsbX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQpVkZQoOBeM6HKRJptKUi0sPd85aFAE/X0DlvL07lS5RJJgL+32uH1QDXUD?=
 =?us-ascii?Q?35VtLU0N0Hy0OCKIf5kwG0hmaB89KOolKmKoO7Q9TAuFQwOLdFaepY61WGng?=
 =?us-ascii?Q?Jmq3Q4u1ZvIDkZYkO/+g7cIaXdo4FSyYZQeg0dtzL/1Qg2YB73/G1ruJ7ycS?=
 =?us-ascii?Q?y7csoLV80lVizIpHnqdECEoB5zJeitQEEl8M9yVVNbLrvmJQZ0K1scpYa9g2?=
 =?us-ascii?Q?obxS27Vl76++kDOs18OvyrdxpnH+4MTO7tNOtcEpLjaThLpm4v2xSJMGBW4X?=
 =?us-ascii?Q?gE0z4A573780FD8D2Si9JW0l400iUwKU492ZnoOawsEKDi4cbHUsn3TnFN32?=
 =?us-ascii?Q?mr7Lo4CEBokq+Kju79JErMsqSOTHPGReQyXeou1VDXh5A7FoXC/WEa4DBr4D?=
 =?us-ascii?Q?EKz/FQvwyIYNJOeN9tIkEcXnDT8UsIEz3DLzIHg6aTHOyERKwZvEcyA3Jy3b?=
 =?us-ascii?Q?IOoc6sJRaVPr9XBRQIO5DkiYt4aWIRed+ZrijMrrtJGExGuZIDO5QfwBXsYC?=
 =?us-ascii?Q?4EBCtVKJPEDZ128pU82ohCBQlIAsvv/j7VHZYq5gB2q9hjx20bVNk1ubpyse?=
 =?us-ascii?Q?ZgZjF3PAGvJN3Vr9+xixQUrFSNYm2zh4+ehIEJ9PEETWF35L1brHay0qTdUj?=
 =?us-ascii?Q?eAmFAsZHEzwOzF2QZOZw7iMrCZbVOYmlQAwHGKZCTntSDTaChZdIVi2cc+1Y?=
 =?us-ascii?Q?nHx5a14/BA1HyxvPqLH7rR10NgoO43URyh/jz5t7KxgjPb5RrpzEFh8HhK4n?=
 =?us-ascii?Q?5rOrzv/U2IeMVREMtp8pWHCm8buquZBbbhktInSMVAbaHgYyHxu9TUfrRJXK?=
 =?us-ascii?Q?bXSaObuLMtD0LvMoFvZpcgelBKMgtFcC8aABEDghU4aPybpfgSS4tpUR4APy?=
 =?us-ascii?Q?2yxNHdDSyQvU/7x8nMH3VwYtsCjhFxBAvoQd2Bk/bf0C/SiBFgyEQN6inlH6?=
 =?us-ascii?Q?Ke8EhEJF8FBEDAhjDlSr5WzoubUZI4RzZ0qe28RKu5Txq8ygPFLgVBRifyh7?=
 =?us-ascii?Q?H0w19aPYzy9x+PmRucmgec9tsFX8x0TSk/0Vo8noo41++6gxV2LN52IpNIuC?=
 =?us-ascii?Q?/H6GADzFnhIbSHGAB5o1bhcsLWWIwewDn7eHKoEebGO6JPHDdawMdCm6aIqa?=
 =?us-ascii?Q?dmNL9Ao2Od8iaVv7XLGRW8aY8gPiP+L9UeJSWGGKN9P9goqrD028HqldiZOS?=
 =?us-ascii?Q?WfjZHUL060VDH6kA0BinCP1ObxBBs6r6v8oc5nY/+hdPfz3cr5pNVQm5eMLd?=
 =?us-ascii?Q?c7rvlaRUvqcKyNvEpRSrgE/ztzIUJDtVzACN/Plm1t3Gq8+2sULum93QepUX?=
 =?us-ascii?Q?JFgTHjI0e6urR53nlQfSOXmGhdXbsn8jWEjHjmIjOwCN3Iy6To5wDOb2rwIk?=
 =?us-ascii?Q?z4CXpVvaF5xvowCKGw3HK1jPnHgFq+cydhynwCwQ+azIfKxpTZ7GR74kzOGF?=
 =?us-ascii?Q?haVbT2sFjVPLHgpQYSSRcltzrWpgM+gMx3ElADoSkcPKGZ5SPueHKKrkPp18?=
 =?us-ascii?Q?xN1YHv5tkXtS26pmiJMuxfWp24lDUThyIHr9iirEKuaaTADRDNp9665hlI+W?=
 =?us-ascii?Q?Dvl96d+Fr29MtJZclX0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dacba8-5244-462f-4a67-08dd3bb16a71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:25:33.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmTQjjvoP2NXpS/k6gOvYtWwVnLrv2uCCH5KuQinQIdaSpc+IdiOPYP3fFyZaX7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On Thu, Jan 23, 2025 at 09:54:38AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 11, 2025 11:32 AM
> > 
> > @@ -224,8 +224,10 @@ struct iommu_domain {
> >  		      phys_addr_t msi_addr);
> >  #endif
> > 
> > -	void *fault_data;
> > -	union {
> > +	union { /* Pointer usable by owner of the domain */
> > +		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd
> > */
> > +	};
> > +	union { /* Fault handler */
> 
> hmm is it better to rename it as "void *private;" and let the caller
> do type conversion?

I like the type safety, the union can hold other in-kernel users with
their proper types and this discourages drivers from inventing weird
things..

Jason

