Return-Path: <linux-kselftest+bounces-42873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8DFBC51E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08C754F6865
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D193241691;
	Wed,  8 Oct 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aapsnG3B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4622A7E6;
	Wed,  8 Oct 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928618; cv=fail; b=NYyvenk9TN3uXQoH026edaIxKEfWAUGOW/1O2QXEMsnf7BcEri8V4xknGMBd1/BQ8UIsqObpSXTTyUUddgFm1LjX84fIJY/skOFqzfsLyAtapNws2Yl1QajXvUT6pwTuU3pWMjUHdGGQL2FqEjd6pP8Z6wY6e7kSmLvYjc+asW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928618; c=relaxed/simple;
	bh=btmyfTvM8DSi3SA/vzO4A5wlAsbFtSLtbBV8FI7mp5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQB7TrZonxnR5oQyd59Vg/ExX31WZjpkuRN6DInLh58eEfLTrbAJ07HuOlU4tuTUfo72UALYUiwW8xU289NWFsNHT/DN9hxP/xJMLLJpGSlOgS+Ghbxg5Z0wqx0hcms5NNeQSPngk92U3UVEPwgWeRLYpiwSO8Ct4x1ErJ9PAxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aapsnG3B; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeXv7oIBwZlHkNyu1qrTUJDz0liZN1sQbCFh2QyAMAeqkrDqApXk6HkR3wHjkjRmdftxSlJf/ia2tMZK12Uarek4Y3eonqwxvNxyjy9rN/MrE7u8TTnTA535u+drpcNqMnBi5OA+rHCv0ZMfJk+1HHKK9wjXtM71jDpwcojnicNyQNIt/J5VSlik6F3QKJ1i0/qpC6nRWFYD6mbbD64WW3kQSpUGybIa2BR01XvfDgXLV+0uR2GHhEEBvalGXIizTVA/3jMVsqRHvPSaJWakKquJRbEvWIwoFpkGjGlpT399ptcFc5phJIaFNVYd5PdottVY8PinS8HQtJVGX4fKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUbduJXsC+iJBpr21Iqyan7Wiohuxmiqg6sjLT886As=;
 b=h3K5QuJQ0d5IP9DowKmYHOU/ch4DMAC1urXK4qEMfIhEgu7zinYgJ5wtzI8EYVpbO/zVt55TAYUCFcc0epv3GnOqS9BXPFjvkujARWhJ8IpbYSlpZOzjPkrjWJuRpvkGymkGxCnTA5DEEFrxIkd2fvL6xHI5fXT4vh0LGb8I+RYH5N4TX48uUU9uQkwtCOo9R7NwefAucwNaDBwKMx1uuTRSQggNvNQwiYupsZ+XxhcovuRcsIqjr1L3+MAGDlnscz5sE2nyhl295Q5DbR1DZ8VIFnSmkvq5FcBrNZn2XHNcUuMCbKa832IykgO2WcwSZRGUg5AxhCWVNPFLbElpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbduJXsC+iJBpr21Iqyan7Wiohuxmiqg6sjLT886As=;
 b=aapsnG3BJ+Wh2pSzJryrahiYW4Z8/vfDsh8WzoVAZ5kArvauF4r2nhxL0b952hgvYyyWZ1nHjWo7eVl4Mdo+uBJtQLfAf9NPhXW0T8XNNM3Pgncmp4Q9pvLUx6bpO/OHRxjFBcysIXqG/dEiZW9SVVgBX9NLoqaE2iaI003il74/3p/5hcehE+TqcUWbDny/2TQuPYLyuwPWxAV2jLhpEr8n87J+r/sPT/B5UJrUdQjfBvSxk5nYyu4RD2x/MwLqClnQ79bvIR/C7YFNawTGvyqIA+s3zA51eRXHB3YzS53jyIAquCFOdeleU9zEkZqNX0yPlPuYwPRCAhSoYlyIXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 13:03:30 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 13:03:30 +0000
Date: Wed, 8 Oct 2025 10:03:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20251008130328.GA3765120@nvidia.com>
References: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2daa4e59-f5ea-43ca-bfc0-4a29e904e29a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2daa4e59-f5ea-43ca-bfc0-4a29e904e29a@amd.com>
X-ClientProxiedBy: DS7PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::6) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 14716d21-23ca-4088-1cc4-08de066b13be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZppJY55GrH+BqI5eF2WTRzaYi1bCDn2x7VxMHvq7tDFdH1ddgFFMuI/vI4N9?=
 =?us-ascii?Q?+gCAllPfIehD/VcAl7WRDcLlnFu9xAwtdzVGwVvVutXJNoeakw5Jr4fvdwRW?=
 =?us-ascii?Q?l4BPUCXTI0FTulVJxNDFypUDXn71oCqzlS5BF4c1qCqm55BzeRrMc6+EAobh?=
 =?us-ascii?Q?KsmDrqY5NbYw80WhnRz0b21OtRNQ6hXHR6BUt1Javyi8lgE2AccDcpime2vB?=
 =?us-ascii?Q?CtYlMlIx0lEjRpwdZyZwx4wv85rOF1co94+rR8KuK/+ZVGoSNZwQkRXKO4cu?=
 =?us-ascii?Q?2VjPst1GaNUhXemjqgWlmEjNqwI1vXNaizJkZ+em5ZmzJ/h9dTQS9WASY5Ms?=
 =?us-ascii?Q?VDB1EHY8UHHKKVyeK2imPOSiQwPLb76nv1BbgDHAZw0z/Tlb+wL6O3uKpRIn?=
 =?us-ascii?Q?ZFC7joqcvxErPRK2WHSwGUkQGrGj5wxnuzUeAsdrtyY1xAeK6qmvy6gtfuT5?=
 =?us-ascii?Q?ki8anX9pw3d8nKBDWRMiHBr12/jUGeSXXD9i8C3qNsKYGuIrydJPbBaV1uH0?=
 =?us-ascii?Q?TGz6xfUmZoC2pxNZyCDc0KgV6zg4IUDvkLyr05rFqzNQgu7lB7B8YCY0z3i6?=
 =?us-ascii?Q?YqVE5L3Ee7icF2On3//KOV/Np+3YL/zymc/m91ItNdeIbORofYyhu/l9GoeD?=
 =?us-ascii?Q?r9snd/KiaFIZ65kjl+Q30arKo54XdCsZJFLRYQ/YnkeoXPC31bVccqgTZ+QN?=
 =?us-ascii?Q?ULDD//uzRoZeaUriO/AOnm1+App+SaLu1+ZW5S3AN299R1EiGJK3GJly91aM?=
 =?us-ascii?Q?jm08JJc9Qhp7/MQikcq1QLQMGuQJM46FqXhiBQQ59aPeT83P519swekHchQ1?=
 =?us-ascii?Q?6vNSd6tKFyT4DhJu1vwrao/Vq7vIiXE1aeO5qQOgGflS3UYu5MNgf90MbBn7?=
 =?us-ascii?Q?PbNRZ4s1yAi5dYEo5s53bNy+NnHFfVpGJX0gzkSEZ6DIBrH7MXTiZ1mtkB1S?=
 =?us-ascii?Q?RfWXbd/EOLwWilMfR45dVMBxo9HXVzaNPP0GFO+KKtepyl9jGDF42tzOH+s0?=
 =?us-ascii?Q?owxohmIKRhKPT/FztO1nIergCH4aaZUrs8m4wWkiehOHL1E8H5et26uAXZ9W?=
 =?us-ascii?Q?E0FX0JPJ0f5V6ylZjwtVhf6xFnu7ctmbotrodIR2Xybe3dGNouKycDMffEC2?=
 =?us-ascii?Q?oEtcoFXLb7kuUjdVB/J/rTZEcxAuykMHQK1N0rUrcSQzfWnjMJBf8L6Llv6j?=
 =?us-ascii?Q?DCBehqStvPNI3WVlK7DsGGD+YKsuJJxmV1GMKbb05Lt7zwFIzFaTtZTHk2F8?=
 =?us-ascii?Q?JK/X0kG7V/fK4cleWFizkcCvuzXf8Kep/y4IvgEON5w4WTVEPoPBbkH1OIVL?=
 =?us-ascii?Q?WWVcxmzsLhdZYBFW7ZT+uTLy7cuOgfRQPFtmDMdR044dMBn9/pzPdhApFV+x?=
 =?us-ascii?Q?RP5RQ8FrxRHk8poySK4bQX2AHg6SrtyjO1zQAVBeizGZmwNCkE5T3LL35u2Z?=
 =?us-ascii?Q?DqO+bGnYKcv79qQCuoYxz04mBp5fnKUI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OfvDchG52VIXgnsezEHiVP4EghbLNDUejxxVmqD7dZRH8siMdcG4Rq9JS5D4?=
 =?us-ascii?Q?pSMx+ecsmNWxYDiiCpcYDDgGJ+xGKmlw9OJihfX1i2kwQQtkl7STnGA5ym/H?=
 =?us-ascii?Q?kOGeRnWpM5+P7/ghcrwIAJMJeY/KDGWg4fmEHTL0Tmy1V2PbkT9SwXoCUGxl?=
 =?us-ascii?Q?BV21bE6mYY8KI60kLBdC6JLcXUB+STVdot6NgcbLFYJ8YTZ2O+PebVQHyyJ0?=
 =?us-ascii?Q?kN7Zc95GMfJZJvrBlw5XRoJEuZ/9PjqdZbdDfpZad2xHURupyghAVpnBGvvP?=
 =?us-ascii?Q?bc4piOase28+WG2hFn13QwjF3mJW9uw5AGHVQPOgm9OPtbfgVhvy5Z/vZYJM?=
 =?us-ascii?Q?oBrTqKWITj9n94boHBEUKmKXPNdA8s8Rr8pImgb8+NjwcWWZXqYGaw804LN7?=
 =?us-ascii?Q?ewWvePGyvJPpzD7A+ABHAc2MdxNbR3vzbBX7foyfB2174PV48fRQx56+SM7B?=
 =?us-ascii?Q?VjzlefNM7UJ0fLhNAwvrzkK+97i1iSKHi1XG6RBU9rCXkp6ILnf8F6QEu2xp?=
 =?us-ascii?Q?hzlYhhGbJrBDJus5qu97Gxzhayyh/e3QSFo0ZnkfBcbruIhKFjPgT8gthPwT?=
 =?us-ascii?Q?zicxz0o88yy2+oO0fVshPLE5q/108KiFfe4KQPcQL3Typ9NciR0voYO/UYdZ?=
 =?us-ascii?Q?Z4XW+dsKrE50SkpCJiLgM2twStlMyp2WP1Yn6Gxkm1TGTjFKj0UCNbyqt6sG?=
 =?us-ascii?Q?2iBmjJuJzZ9cwnfWCM0fiNtbICs86ujNSYSSwr1wkgyHOVuMCkReHRwgMA0S?=
 =?us-ascii?Q?WwQNrWaVuzt8ynFx+wH6iYzbzMj2cdPhAx1P+QbGd6OV3w5HBuh8uWEO0431?=
 =?us-ascii?Q?uqlt5PyWub1qke77C1wY8jc+h0kK86o7/5tdyxo2fiGtLvco74CkoBlM/Wdn?=
 =?us-ascii?Q?QDvxv7/IPSTF+nOyzfxD8gLW/6DePIm2pP/p/rAegE4/7mr+VVTuBgs7xidb?=
 =?us-ascii?Q?GxnUackEfXmavQPymGxq35NG+SRkfm3MQ6jfuD2TLTxMW5MOqL9C1aZxmsEE?=
 =?us-ascii?Q?J8erWAUcysP4EKq8ATmOnZFkMLJ1GLijpx7lQ2XUhY7S6fU94HNTVlwHoRTb?=
 =?us-ascii?Q?4ifIxKVEI0P0DL/fEe8C1EdPkqC37kDOXXxvZ6ga0+0oWSP9VNbcYwjpOse2?=
 =?us-ascii?Q?xqvhyT5JgW+/AXYUAZdzDKPeJ7Ahhajf7dgGpsP3G15/JkQjaY8SzexDbS89?=
 =?us-ascii?Q?v0hgF7QDPsFK9lVvxfsireN32s/xDm5l6uLpyLhA4btmFndUYZLsVrerOxHF?=
 =?us-ascii?Q?sZkSFvqD1Az+IsFpoQ8gpQi3ZT/ATeIcOdPJ9xbG9OfvzKy0G2SEGbOu/i2B?=
 =?us-ascii?Q?kFhtRqeQuHy0nS0bZ0KuZPIN0LY/HLkWsQ8040KeMXh/mzczqySnG5RLovR0?=
 =?us-ascii?Q?HBpEE42ki8+jq/EA5scvx4upTjcsTPIHvmD0PJF7wB6SIJ6yM8UE8WdEpGJ8?=
 =?us-ascii?Q?IIn91ld683YZ4UDOBa+9cUZSygrkKdua5FlF/BQkZ8qJgYnbuKfBUdiGhTqG?=
 =?us-ascii?Q?uh9SCyr99MgYZGvZtRnCQLcmJRosFMThqgLm1pCBywujdRgrt7OHTz/rdsSq?=
 =?us-ascii?Q?dN0Yt801L5gcN8kwPT12MGgl0/ISF0k26PPm9Fg4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14716d21-23ca-4088-1cc4-08de066b13be
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:03:30.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlmqfM/rhAwc1zlsubdNnucxfTSdxU95E+nKGTEDj6QCfG2bsjYVzzBHV+IYTtEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

On Wed, Oct 08, 2025 at 03:35:39PM +0530, Vasant Hegde wrote:

> > +static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
> > +{
> > +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
> > +			  PT_GRANULE_LG2SZ);
> 
> Also here.

Presumably this as well?

@@ -2166,7 +2166,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
                return ret;
 
        pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
-       ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
+       ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
        if (ret)
                free_gcr3_table(&dev_data->gcr3_info);

Jason

