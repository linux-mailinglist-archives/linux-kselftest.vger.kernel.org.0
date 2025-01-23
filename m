Return-Path: <linux-kselftest+bounces-25029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0804A1A9D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546AA7A4502
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737515383E;
	Thu, 23 Jan 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WvFX6rfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A714AD2E;
	Thu, 23 Jan 2025 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658141; cv=fail; b=NCFcBOj06LrLTFS09jqlk1DXXIjNKcdPKRn+YwcFshuSXmmDV1DCGP7raARr6nIeAe+ptsFRTHEExXmAKJFsHM3br4NwykjUhxB5Gz4oCKyyK4+XkWLNCZVkHqRct6j+EfqxUtl7TsDjwEqFKyj/J3utEDi3dfdDUsVjuKKsCGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658141; c=relaxed/simple;
	bh=CO+8LrC6je+6sooHTRaaebe4eCiFQqpUr+AAFiOxynY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gae9TIT4m3ebujucRYrnVwdccpnVJ3ZKGGKvsa546yHdEncjHP5Oz8RASMA/8lkm3WAakmUpQXwF/TJgoy7ROb5/0VjtovLKH6/Sv73QKF616+PI1Xk6ls79mr8fUzl6RQPJoQWwaE1QI29LyqaXqIHs6aInoy4s5yH/JzNZEuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WvFX6rfi; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSBttkXBamc2NAtUGsKdLISA9EVH2S0DoZC65Kjn9/bSWLUzxnnKXR8RBuztr9b3srVp2xL/yMB2xn8sFP9v6vO0A8shPm9AnYZeuqLyyJDVMwpMbw4i0mKc4tFUKxlIfI1RX10O8YEpOlR7B6Fk2O63TBwZ0KAdJc8SL1tSjtedf9LhG/N7gAypdBTmGC7OcO54WICp9z7fUuZf66B69dpCLBkiw36/ziu5Qh1TFEqmblWCISoAbsocYNDQFQSuNEhY9suAj8wgv09ggbYc8ZlTPW69KF2YixUj2x3dCBm7YOJ//bypwGPu/kDFfPRJcNSSjpiTR4MGkw3LF2pSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7VWD2YFhjYeUnNDadhkoB1kS2spzbzxL1xEfaDxay4=;
 b=IX661dATk/8cnUe/zQIMnGXQFcu0N7S53lwRTxlhaPWxV7qVxawrUhvJbuzFAXflx5wqQdOucAWmlxjb2qRimGZEB05VQLd7ImrnrXksdIP8SoXcIVuNphsao15ToTq/2wk7tCJ4m96L7Prw3nNLGZWyhaiOANbana5G5ihCfaK0u3iEskENyQho3pcqDXFE5q8TJNcXPyeEnavd66wPXMmtFgyUiq6PdFCgJeSeHv2ZW0w8XCSJMpBt5dVo8FnsIJoU/ynUal4dGUeZK8Eo1yYvaeDbA7qrnvcTQHn3jpuTdTHLH2FeFmUQ9mbyHtLRjt2+bss6aaVo0taVa5esAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7VWD2YFhjYeUnNDadhkoB1kS2spzbzxL1xEfaDxay4=;
 b=WvFX6rfiMZeagpNmm+CKqcy1G5X0rsprhpqKRFSZ7Nv9Rv/T/awqOvNPI+cELAxstYYDRf4JOuiEUMuvYWUEB5cCaENkyr5ZuKG4x586F6HOYjXRE7MSD3j5V0PXwnyoBQMQLX0sxCL8G5Z7sMv+O5ew2lEJw1Ls0gXb/+eRHPctqkflNLR0sgU57exT2DCYr/yAPq9rF2yR+ehKu8dX37D2y8FqtADfLKQRQdOTOdjeFcfu3SehfTMJNmMuj9TDOelC/gAYn5ZN9MpQHSbfBvhkwV+Lq4jsGW0m7Zlvplghx4Wgucdu12nHMbjiKnM6P1CbCFzr/Wpi+292ciEgbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 18:48:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 18:48:56 +0000
Date: Thu, 23 Jan 2025 14:48:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <20250123184855.GU5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
 <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
X-ClientProxiedBy: BN9PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:408:111::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bb0825-99d8-423b-6ff8-08dd3bde9721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4r12vw7+1PvCz6bPUZ00aTYsi9yVJuq9s/9PUY5W9LiyL3zMUGjgBhg5cwI?=
 =?us-ascii?Q?ohq3vbpkir0GuU9oxTPk67eiq4kEKWK2d2nADQ5HSaY9aA/32GY7GovCIrq5?=
 =?us-ascii?Q?1LEG29sDdMCnQkNB2WM6L8X18P3kRTt/LuSq7DXnsy3xKO+caQeU9gWzyJky?=
 =?us-ascii?Q?hvcOIHwxOJ2qRFLPVZnbp8H55ysR6ht5Dk3NgiPrnZtkE6SZKHuZknId83K9?=
 =?us-ascii?Q?8pws7EdYoHo30efMam6Ieed6g5xzRJ0A27bbRgMDJkUeVQM2TMJFa1tKkVLb?=
 =?us-ascii?Q?twPO9Acp8Vn0hZdJDQWzPm2ChxI8Rn3Qzq4YsXn81oD0zhX5ysvbvyURM69E?=
 =?us-ascii?Q?DzFP5nitWtbVsdEnyMLnMqT8wkGbtGIxyxIV79PSG10DZI4fJ2jNwRh2K4hg?=
 =?us-ascii?Q?TDGXI51BYoq2mw6/CGXVoRLKtDh4828Sy8r72SY9u847WBkbv12mKh3uypB+?=
 =?us-ascii?Q?1egdkVIN4YPeCJfwGFy+XWIoaLpMXq5b4wil8styPkjyKc3RV1eddOmOprg0?=
 =?us-ascii?Q?q15Aghohn809GKKSwj4la0mfhijGqXByrHtuOBS2Tpc7BNmxhgfIRk8TCzy2?=
 =?us-ascii?Q?EesQ1s8Z0JvYsolwc0yfzp+d/sm4Y+huU2i1yLXBqPhAEjSmKeF3Hkra0+OD?=
 =?us-ascii?Q?8LLnxmcPQEo3bls5x4VewBz+3abmsAoxLCncs7akxMVt3u4YNYWnZDSEijmv?=
 =?us-ascii?Q?zhVbLAtcVV6+a/cGVUrP/kMhXfbHZEp5lMLbmKddgQOgIU8w+VF6305PEYK+?=
 =?us-ascii?Q?B0Ht3KLclpZb/ukKsXnM9Pp9N9lgv4X2ogWbaoyH6BsVG+jDGKjnv1wLw+bF?=
 =?us-ascii?Q?ah3RiCNOVZs1GLLfHrTMHQaFddE7p55PqTi59SGtc4ILSWWvKWmQf69ILjCV?=
 =?us-ascii?Q?KjiTcoPkVKWoro1psSxOi4uVnDKQx3gSGweCQk+OX92+2hMmNSQIxV32x+Gj?=
 =?us-ascii?Q?//82lms9tHTvcYmgYP15u87u5hcYr52C6tWwVVwBCmqi1qZEgp7mM07DPaIg?=
 =?us-ascii?Q?XdxUT47EId2jhHGfXKUCzcgW1tH/bOd9fQLOLwygmEpkXbO94RHHCijs81Ok?=
 =?us-ascii?Q?EBzptdJSH6qdXcE8H9TbslylShiJsttZI4dTN0RlqNl7x4N1+KYWXs+YZ+/t?=
 =?us-ascii?Q?xDOgDFjHUvi8a1F+5zNoLK3GOt6KlU8KnQDeXvxOuewIYfcZnyxLC7X273j6?=
 =?us-ascii?Q?6V0ag6iM9If5vzVkUdstNHORJalvPxXqPBXSB/AX1xaMsGXYu9+eBWTgrdGt?=
 =?us-ascii?Q?R32vOgvznmZyQkAJ8zHn9pCwa9oy+cPDid67CrtzYaG5+ZnQiUy9NAZCFd2z?=
 =?us-ascii?Q?MEYOFtj8n+kejTSe8mf2SQoljQe+e+3B9ZKzffoQkQS8WE6PMITY8+vpxT43?=
 =?us-ascii?Q?iwtmf4MOxwO6qRe/IhtAB/drPKmk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Qxamz+KqSA1UmkVzFiK97YXeQh68/m9C4jmXpffkJmQ/+tkJrlEiKvX6G0K?=
 =?us-ascii?Q?xFtbePMPFeP3cJ7VGqTff3KnvfmvLeVO53Msu0ZaWBUrlZxNrOJcyuUqHdGf?=
 =?us-ascii?Q?yL3jbo7o17pXm3ojYH/qZPVobsMnqYQrYW4B1VrX9qyTLiK7V7BsoMVW12gu?=
 =?us-ascii?Q?Du1c7hbXmhN9Ypo/9E25R3bUkRebNVw7YGHXM5RST6J8hOu1h3YdW/A5DCRf?=
 =?us-ascii?Q?i+5pEx+RHer3TgUQhoNLiEKGRDnMzp/JXgINPcl7UWXiL08uw+WmkWtJ+noF?=
 =?us-ascii?Q?vM2d25eVxquILJCfwtVHpKch3Flc/Z+zp248Af8rD/YgNYBd1C8bUAusUOf7?=
 =?us-ascii?Q?qiFfG9Thu8A3SxgU9HIFxBE32ybze0GBJgbfTY71uasRrcutF0pcTf86MNhx?=
 =?us-ascii?Q?AnhwLnxuW+SSdQoY7NUXbXbxZpd9zsJgaHYa0uIXMfXrN4Tw+3UyKWbI+TRg?=
 =?us-ascii?Q?h4R3c1SQSIZJInPw0k0ml83tPi85BIMsripNAXDLAPaYc/eAs2nej3ibnYsw?=
 =?us-ascii?Q?HcFqSwEs3a3h2g6lLkEn6HW5W/JIGFCIo8JRO+MMdkl24TGKCbpQpshNX14P?=
 =?us-ascii?Q?hBkAiaYjTe+sYIrzg9v4FwOOaZ/BTB5qy4x+Ef85lvhTbRzAjF3jTZptpwY6?=
 =?us-ascii?Q?3/pjx6f/id6CT9EFv0ie9rhienBp+ot7IfopdpR3rlL5OujG0kQMNtsm4Kk8?=
 =?us-ascii?Q?hRQiT7HhgOsJbTAdFfyt5yOt2WRfZ/yF5r5DT/d+iBJKqsb58cVTe41lP/sD?=
 =?us-ascii?Q?NqTGI+/+N9SICF5Boa2+o4RvjiY7P19VD2OWitj4ux0J5zUZNJZjfnaS29tC?=
 =?us-ascii?Q?HSizXaqD9rm8QGnBBjXH0tRN6MiG2XfDug946KHsq4ge/eErkYeZIsQza1xL?=
 =?us-ascii?Q?JaEPW6Nfomoy7LFF18mhOkOUnDsIpXyM+kJq3mHaNiUwCvKknNz1Uqd7q27o?=
 =?us-ascii?Q?eB22cQkEH84F+H+wfCBoxd97/CVGeDqc3Y2euwD+8PMoYuYXayq2xjvLYw/3?=
 =?us-ascii?Q?SFQg58WsQd3gfv87bfl5D4P3qFVo66omnWorVBMCzpX0Y8GDX0SoIdEqmGdI?=
 =?us-ascii?Q?JuY3rSOU34jkw7lRR8LtF58JJyeJF4CdT2l2PNQ6Dms0JiAYpqkTJ6PSfnPt?=
 =?us-ascii?Q?0qxjy8SYb5fQ0e3ClwwoVirw6F/pSH3d4Tnb53/MvRdVV0Mv+cSR/5kMK4q2?=
 =?us-ascii?Q?g8wH/xEB5SbEgVCwgGWwGY1hZJ9A9TdcFwg54F9yfVZN9GRrg+1NGy9Avv6Y?=
 =?us-ascii?Q?a03S+7rlYMXk46W0RBUlpogqt4URrC7KDbLp+TbC1MsDL8KjPuo3SwtNz6KB?=
 =?us-ascii?Q?LqYy66pPPJOk/6m4oZpEr6YWQrDYnCzAZ2JSVshaVBGfqiBRJt6C6Fei9mMJ?=
 =?us-ascii?Q?aPeTeojey/bPL7RKVqHntyba4GE/0+9BZZ8hpEmbGYigat5WiRDveus4agHT?=
 =?us-ascii?Q?jpIHd9Xve9qXh5RoY+RvMIbAZraTot0pWzDZz87DjO7C5gTpZnNivlPLUuAA?=
 =?us-ascii?Q?+rGtDuhdNm5l+OXYGxzpgZvVRjqPYLQsYgBeOQf0rItXuApiVJbrHIA4Dq7r?=
 =?us-ascii?Q?oGYMB7tFBEUwQjhWRxsAkaoxtktYiotSGX3Ji2Qj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bb0825-99d8-423b-6ff8-08dd3bde9721
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:48:56.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSGUES+Vu9ikEiwUmZILgW+K2k90ExADRYVgZWZGeXzi+7l+LpJz7UxGyBza30Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

On Thu, Jan 23, 2025 at 06:10:48PM +0100, Eric Auger wrote:

> > However iommufd now permits the domain to change while the driver is
> > probed and VFIO userspace can create races with IRQ changes calling
> > iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.
> and is it safe in iommu_dma_prepare_msi()?

iommu_dma_prepare_msi() takes the group mutex:

int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
{
	struct device *dev = msi_desc_to_dev(desc);
	struct iommu_group *group = dev->iommu_group;

	mutex_lock(&group->mutex);
	if (group->domain && group->domain->sw_msi)
		ret = group->domain->sw_msi(group->domain, desc, msi_addr);

Which prevents changing domain attachments during execution.

For iommufd, if the domain attachment changes immediately after
iommu_dma_prepare_msi() unlocks, then the information given to
msi_desc_set_iommu_msi_iova() is still valid on the new domain.

This is because the iommufd implementation of sw_msi keeps the same
IOVA for the same ITS page globally across all domains. Any racing
change of domain will attach a new domain with the right ITS IOVA
already mapped and populated.

It is why this series stops using the domain pointer as a cookie
inside the msi_desc, immediately after the group->mutex is unlocked
a new domain can be attached and the old domain can be freed, which
would UAF the domain pointer in the cookie.

> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index b10093c4d00e..d442b4a69d56 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -184,7 +184,8 @@ struct msi_desc {
> >  	struct msi_msg			msg;
> >  	struct irq_affinity_desc	*affinity;
> >  #ifdef CONFIG_IRQ_MSI_IOMMU
> > -	const void			*iommu_cookie;
> you may add kernel doc comments above

I wondered if internal stuff was not being documented as the old
iommu_cookie didn't have a comment..

But sure:

 * @iommu_msi_iova: Optional IOVA from the IOMMU to overide the msi_addr.
 *                  Only used if iommu_msi_page_shift != 0
 * @iommu_msi_page_shift: Indicates how many bits of the original address
 *                        should be preserved when using iommu_msi_iova.

Jason

