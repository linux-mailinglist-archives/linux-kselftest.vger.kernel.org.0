Return-Path: <linux-kselftest+bounces-45126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7BC40ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8041893CCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7E333723;
	Fri,  7 Nov 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWpbzNQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F432E735;
	Fri,  7 Nov 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534189; cv=fail; b=Muy87O6bepAeiHCNSJfvhN0luV5tV2lOn7aaSqI0XlN4d/OMHcaZIHChqVARmh1vzELvj3gFpp044m0F5M1S5urHLnLMVUFvh4+uZ+7/verjPHnbffdf09u/K68QitCYMGq6BtvD8B0bF8TimD4WO4/6E3qdIu7y6XNlNSLT8ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534189; c=relaxed/simple;
	bh=IVW1EWqJfA1MwSdjKDmMwyEI11B7fJpwXKkK/M0p3YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYKiHpj/9KtgXjOZP7zaWWnpIqlotk6EDvq3nj2ADsBotH5G9xUYmeeQM0Wv2BIMh5rk+iBlrfWDer0UGndnlw3PNjxktMzkDj24hqa8EsTQMUhiz//tzrToxDVvoZmMkbmznFcwm4tEQ6shWAMj2+ZlMVik8jpriNtxkJvx0/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LWpbzNQA; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcMY2bayOEcxSSoLikoOoY7uph0Mlz8l3zWg5NalBxHQe8bGZpz6UPSKeK+tb6wp6+LBmSWQ1L2090V2N6seF2E6BO/VvxtrBw2gl82E2H5J3/7Uc1RjwFsRzofjY+/IQIyiK7VHUhHF1vm9AVU7M1xckoifxbhfAdp99TJ5BAJiekjmkA+lPj0zCpIduRedHk80ylLIKXEahfFp/FuNWzQfwQ436irL+D6hdeEyNu1elvJoohT4c8rdUANnNQkFRev7kEc6G/do54EQ/acdCK0rkey6cuiqGHHJng2Q9gpXibnlmUSFmgaP1YdZENHsukm3XAgIDvrDeOmOOavmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez1Q0rRBzXmZuWzdS8lBLBjgtXV/mlIa+P2SfcFb5Ic=;
 b=tcDjnlfWZ/5SCVV2t4wPfMlDZwshqD8Qd8liEKsrY8KTe6IAcq+Q6vVd3XZhG22vCijzWMZIHEh69SMq65v9XYKmk4ABbTtoW+yQ5pPdPUCnFLOIbP4X/DUVdmoo/K+ELZ2xDUnhsmMoldIsU5uttIqYuwyXVM2jZIdEbalTlciFCjKo5MI+GWLg7mtr1fLeS3Fsv/dCoGq9fVvAKIQf1A/Zd0W5gJSnxWlm7cC1hS8Jm4cXAGxYuAjnNFuyb8N0jMr9mWTBAVBs2cDzRem/t7szb29YlbndOzqfgimKqd/Nt/+G8d6tOBQuVv4vOQ1FOkGA6jOCQCPec1oPOHz+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez1Q0rRBzXmZuWzdS8lBLBjgtXV/mlIa+P2SfcFb5Ic=;
 b=LWpbzNQAOjYdSLT5UChbkXeQEbIN1yo8ERi7phpyCZd1hFXsZwCqPvvAoYlr0VlCI00bdAxsEfLd8xhR7D3kOCpSqJJpm0rUIshFXmnV9B2h5WIe0CeBq5E894ny/2c3U8YzpbibI9uDxPK+LW/xx2NTWhWhWlJ0702mOwYBUPaluJ+FJhteQKK5AzavzVhW5r8eaRNrV7a1meUDmRMRv+uB1G047tFQFFPLsUnhajeqbOqlInr7ekrwAA/oqIHUsRHKtSecpI4y/9HaqoFwW4EJ5ENoZYy4G7dwlxQAZWhcfn1xjTLtuXDPp+Icf3kJphU3wd2wZhwatOqvdI8rMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:43 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:43 +0000
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
Subject: [PATCH 1/9] vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
Date: Fri,  7 Nov 2025 12:49:33 -0400
Message-ID: <1-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0708.namprd03.prod.outlook.com
 (2603:10b6:408:ef::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f5577-4bd9-45b4-0da3-08de1e1da5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nuvw8xYt/iVzBhKnnv8w58P+QG1WNoqUaNhKUM40JQobSu8BMtQbmCpOsf8R?=
 =?us-ascii?Q?Q1MG+t9KxIzFQA642FXxTFCW/nhFnbCmO+z3JCZJihVEIbG+lSr/DXCcTazj?=
 =?us-ascii?Q?x/awuqxIfpXB+wys8QKzhPRr33zQgpm8uzGoWUaO4hVOPiKT2y48qUTtPWG0?=
 =?us-ascii?Q?AAbFRFxI6XB3YaN8IrZ6DMJHstWIiisTI/vpODq8GZrckJ512r0g9fmiyJ3o?=
 =?us-ascii?Q?x98O7rBoAZJHvJvMrEJKojK1xtJnhrRPVCGR/6i6I7e24Iismgw0u5tvXX0U?=
 =?us-ascii?Q?jlrl1ZVn5NoyqQI4sKLGD+plLmKgzdUb9c8csjismYCyL8QUgCA6Q6meqDbQ?=
 =?us-ascii?Q?ce1I97v61p6Jj9uC6ChCxFpckDbH1WI7YZqTaxsBDRmc9Dn0dfZKJ+HmIsCo?=
 =?us-ascii?Q?UwY9id4L3Qz64x0xloJkZQ8bnr9IW+Q2kW4NKRtNBXGMwLrU8EUMqHiZllHL?=
 =?us-ascii?Q?ES4rJHVZ6la2cWuaS7AarqnCTXysKVzPrFvVhw7oEexH5G6gNeofUv3ZCqvX?=
 =?us-ascii?Q?zJnDNBMJcsrJ4bpkUJ2XaEdcN66lfXbw8v89y/Pq4YSbb3y0avwP28phZxzJ?=
 =?us-ascii?Q?65lFfzpOQ82z5sXzRbLNEyJx5v11rcOX32LG/l4qN0+VLnH/bE/PrCadOFM4?=
 =?us-ascii?Q?/k8MMRbV/payTVuBe/tkLTthTi/4/gVZJWIe9+Uc/5zQf2E2UKQgHdNui1/6?=
 =?us-ascii?Q?OetUGpbLL1rZaZ1uLkDRRWaqatrFDiYtMZyhhdJ+RHlGkan+MNPGHvbA+4Tw?=
 =?us-ascii?Q?+BLFSlUzDRX5CVyi8M/Q7IX7T+BDM6RtG3L3XowUjU5Q8LIxQvFZ7TUxM4G3?=
 =?us-ascii?Q?uKOyMrxBb2ejQrFwCR+MVQc2tdwPiSjbFmojeKU/RXT2ieX2pSKhGTCsvRCv?=
 =?us-ascii?Q?JcqOQRbkiPhXulPTOSqGHXLM35wC6tIAOpUlrnHVaG0I5rmpmzD6KQB39Ab0?=
 =?us-ascii?Q?9DUYephJ0sYwq9c3HHaeMo2H7kxoZEOzyX+eds4kr32yiPGoFyQbaqTCpyMw?=
 =?us-ascii?Q?347d/B5kLGHkbSs7w/C6YImKITLW5cXYARr2Rq+u6o8EizQoVMbgATwlqGr+?=
 =?us-ascii?Q?waK10ytP7kJ/PD/bROXH7Xt19X2vR1HpRHUm9SP0nZF/5cGwKSoR58QN8QEN?=
 =?us-ascii?Q?NZOMA0/rvl8xQpu9VizuzUecUJAl6pUEKbP07CKiPvnaoH2lxlw0LuqIJbjc?=
 =?us-ascii?Q?VA3h14OSUPld+fqDH9PkLHQYabs6XUI7PPNeTz8lGmiCTzktzmyApcfjDIRN?=
 =?us-ascii?Q?a/CPhNFlJxM86PKlLudhfudMbqT+X8VMqX1gDGra/MlhKpP+Nn94uPawuOh4?=
 =?us-ascii?Q?Mkj/P1IQGvdbf6M0xykFFaxJ/9zBSe7VyTTP3kdosDioGR/NwJi/BEfEuSWD?=
 =?us-ascii?Q?Fuv9qP+9zRLxXC+FR9eN0GG/Af7KD5Etl0fljUgvMh6eLt/mjbd0h1h+VJOe?=
 =?us-ascii?Q?OPryGKuZht8d7U33ojW+qZfmB8SZf6p2j2V5hJsm4aUgb/vGSPlJNXFfEPh4?=
 =?us-ascii?Q?oWyHcVurPLq5F+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hxAcmLHqGGQ+4c9E91shlcJkyggbkf4QCKkSAeL4suRusM2NpPznjJZqjS5?=
 =?us-ascii?Q?06O3TgITGxqBxBf9aRjI8Nf/dLg0qzL4I45jNaORBqquhcYUT5Q6LcdtOkx2?=
 =?us-ascii?Q?Y1DEyYH9pfAYdL/T00hvLjiis1UZ98RngZ1G17E+oph6OtaJNfJNFGofT45h?=
 =?us-ascii?Q?Bgd/P6Bz/nGh1c2rbWwK2biPCcBu836sQOpvAL7iv2Ky7tVoH05qoSV4AVdD?=
 =?us-ascii?Q?HojJd999BjowTyT1e8MRL6h+BizgQLOE6j1Uou2tbkDach966KFxqJpvNAuI?=
 =?us-ascii?Q?rwxXTxI9tiGgY1Y5IoykYNZ7jMKulkGvOEBV/LSoitTL9Ig28j1V6eTZJUTn?=
 =?us-ascii?Q?JE2nXroD19mPcEzBmVhstUi6q52oYat/pXkkjMoiu8hnCZwPAaNrwx7x+FkY?=
 =?us-ascii?Q?2mxOUt9QzHZ0ixqinN/r5KJQFOaxvKT3LvBu2iHhPEPJH9e/E2JGeQo0c6ix?=
 =?us-ascii?Q?X5AEre/S2w4cB1Tz1iOzCLvgCjJBCiZ85q9r0WIPdZqvmU7sOTltQPO2mRoi?=
 =?us-ascii?Q?JcJU/uAwipsd3/+NS1ZRnCrAQxyIkbZ3UQw05aA0dAyLu2WUgHc1wDWVIB5o?=
 =?us-ascii?Q?lMGqCkFtC8jS6UpsdUj3dGr7oMY/l82U+A0PH6Dg/xBq1gpPW9oGWnKnV8ZI?=
 =?us-ascii?Q?lSQzxh8e46GlVSCIJcKPvf9Rol9cYct/fli7fYbTDuw+MQKldXZJKNp9GuxL?=
 =?us-ascii?Q?ch+TGXdwIQ3jdbMZfStwvxN1CjcdF0WcRggBWTHhqkAxC7nz3pIhw2rbSoN3?=
 =?us-ascii?Q?yfzarfMdvu2yUWP0z0VL+h3MyHJqC9ekoJNtCwT97kJ7+tKzS1zX+wkdccy0?=
 =?us-ascii?Q?PBxHV8Kklk4x9LRJVX/MSx6DcixMWjGHG0cQ7IVRxbC73dk5h7Nw7e1EcyVv?=
 =?us-ascii?Q?mPI+6k9YaLDJCOSK6dkrZKVl+0+DP1GHJE3+mUJcq4gEdQYzpwNoAYOUIgzh?=
 =?us-ascii?Q?Fp50KNISTAPtGCjIW+ERBpe1zX9jRkh7FEGWw2MAHmvv4VUEKNxumuxa7EUL?=
 =?us-ascii?Q?CPsx7r+KRqblWv8bX30jav5WD8qhF2Wo1IcPy+a5YDflbzDZcMHn4XnQtyFY?=
 =?us-ascii?Q?Di8AQOZTD/uqva0pPnH/G3wRbXS+Pbpvnnqij64wNPqUKmwBQvbQtWUdfW4z?=
 =?us-ascii?Q?TM6dFIFZ0zjJVS2PPRQVsKRy69RICo+5kkxqoP0OtL0fveGp5i/PBZW1oIUm?=
 =?us-ascii?Q?Yts+OIJOgFnyCSE+B1Xkjfiq06fW5J0cY/lk1jYDC6owIL6FC0G/BaqiKP5I?=
 =?us-ascii?Q?e1YxMtOpc9xSMOGziZelgcC+p2QgJOQDApwzg8GXPCxWGqMzlQ5KncFsV027?=
 =?us-ascii?Q?5wsOX/AdWKV+5hROZmm7p42MFGa1XDkuHpjN2zD3GCq7Jwt6XxCXSenaT30x?=
 =?us-ascii?Q?tmdoju/oExzs8Q+P8IcbXo9OPvAxspt7c8taOMauOtBYAOXzpsDl0HgGVVWo?=
 =?us-ascii?Q?FS4OiORTO5y6jb+THpkyeRF41m2TRQN2JcaZOGPN1NW1sM2626vRjh7INw7z?=
 =?us-ascii?Q?umiUN4eJeeKhTXB1EOPYAJQt/u/1G2CiKeKov5mCt4FNF1i4NbUxQP3cop1m?=
 =?us-ascii?Q?mlIbOKSfOnc64ZNByfI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f5577-4bd9-45b4-0da3-08de1e1da5d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:42.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omaVxFE8uaWgYw9jj7vK9M4qbPKleHhZotnYf9Ms0iGHy5E6m0UiOR9BOWXuAjtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

This function is used to establish the "private interconnect" between the
VFIO DMABUF exporter and the iommufd DMABUF importer. This is intended to
be a temporary API until the core DMABUF interface is improved to natively
support a private interconnect and revocable negotiation.

This function should only be called by iommufd when trying to map a
DMABUF. For now iommufd will only support VFIO DMABUFs.

The following improvements are needed in the DMABUF API to generically
support more exporters with iommufd/kvm type importers that cannot use the
DMA API:

 1) Revoke semantics. VFIO needs to be able to prevent access to the MMIO
    during FLR, and so it will use dma_buf_move_notify() to prevent
    access. iommmufd does not support fault handling so it cannot
    implement the full move_notify. Instead if revoke is negotiated the
    exporter promises not to use move_notify() unless the importer can
    experiance failures. iommufd will unmap the dmabuf from the iommu page
    tables while it is revoked.

 2) Private interconnect negotiation. iommufd will only be able to map
    a "private interconnect" that provides a phys_addr_t and a
    struct p2pdma_provider * to describe the memory. It cannot use a DMA
    mapped scatterlist since it is directly calling iommu_map().

 3) NULL device during dma_buf_dynamic_attach(). Since iommufd doesn't use
    the DMA API it doesn't have a DMAable struct device to pass here.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 34 ++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h      |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index cbf502b14e3c02..7cafd944ce5d38 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -81,6 +81,40 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+/*
+ * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
+ * It allows the two co-operating drivers to exchange the physical address of
+ * the BAR. This is to be replaced with a formal DMABUF system for negotiated
+ * interconnect types.
+ *
+ * If this function succeeds the following are true:
+ *  - There is one physical range and it is pointing to MMIO
+ *  - When move_notify is called it means revoke, not move, vfio_dma_buf_map
+ *    will fail if it is currently revoked
+ */
+int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	struct vfio_pci_dma_buf *priv;
+
+	dma_resv_assert_held(attachment->dmabuf->resv);
+
+	if (attachment->dmabuf->ops != &vfio_pci_dmabuf_ops)
+		return -EOPNOTSUPP;
+
+	priv = attachment->dmabuf->priv;
+	if (priv->revoked)
+		return -ENODEV;
+
+	/* More than one range to iommufd will require proper DMABUF support */
+	if (priv->nr_ranges != 1)
+		return -EOPNOTSUPP;
+
+	*phys = priv->phys_vec[0];
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(vfio_pci_dma_buf_iommufd_map, "iommufd");
+
 int vfio_pci_core_fill_phys_vec(struct dma_buf_phys_vec *phys_vec,
 				struct vfio_region_dma_range *dma_ranges,
 				size_t nr_ranges, phys_addr_t start,
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index c9466ba323fa9c..6a3074f2cf1cea 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -28,6 +28,7 @@ struct vfio_pci_core_device;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_phys_vec;
+struct dma_buf_attachment;
 
 struct vfio_pci_regops {
 	ssize_t (*rw)(struct vfio_pci_core_device *vdev, char __user *buf,
@@ -203,4 +204,7 @@ VFIO_IOREAD_DECLARATION(32)
 VFIO_IOREAD_DECLARATION(64)
 #endif
 
+int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys);
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.43.0


