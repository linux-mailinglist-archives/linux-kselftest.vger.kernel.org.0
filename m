Return-Path: <linux-kselftest+bounces-24226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C9A0986D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E89F3AADD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73610213E6C;
	Fri, 10 Jan 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sv9GGSR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F22139D4;
	Fri, 10 Jan 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529932; cv=fail; b=na4RBj1DZ0Knz2HlCZCyfxWI5js26hKaOT46c0pFdR0QKedkuWXHlezsjcjzdQFOtkrNCdia011epE9tNk0L8OfjlLCI4tRTFe0o3lBxI/mANdU5Vxvudk4/cs9XciQYjrqkjASIRzabdDxdQ7IYwEA+2gaLqYt6OyI5YsF87jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529932; c=relaxed/simple;
	bh=BDo+mP0O/xWmo/PheHugdsPgS9gQjs6pMP6ordLDYic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHN96rP7K1kBguw3FxDNQb1QJUac2vZTEaa1v/ZHvwECWbR1dHbrPQqO80/di8l9CiCCka8oz69by0tlmsuwPnFjnKStgShknCIW/LgEerivSBuxNsbORy4Daf6cYGhnUlXEw7zesUGn1fXnEs1zy+jwkGXWNCATygAPxoZ5pto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sv9GGSR7; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idga0pLEM99twxmVv+imQ4Du8V1nBEjeKfFRFSz8LkYMFI0ZWL2gsDgf4tMZpMMAWSGsk8WajEmkmrcHsArtoDK7ZjFSTEa/oKFTEele3ZXVmnimKWPHA5PLqVCs155kgTOlcj9DgfqzSJMR/U2UwdSXSacCpMuOPtsuifOqKljzYiVirOJ91dbfwW1L/nSPOkp2B3ECJpavQkkn1kfHlxnyeTGGV8WenmyEYZqxZ129/DWpG9UXO26xgxSINoYrVp2+CEWHUdr8ZtaJvfzMKlCReMR+7eEkb3qAg/ewgCoZKa2glGWutXagk+ms/4bD+FH0T/4aa+DVYIe8FUlteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFvBqhSL8tOYVtAu4Y54abXb7e/A845ItJf4IwgBIbA=;
 b=UI0g6NTs8sqvu3X5iiwem7Usg/9q/1NZYlQxjDuan4h9rvKAB2OByfrWEwJgHdn6rxIg1exnN7lpuLfS07CAQBCz0NtJ+w7KY9mNhOqkFZpb37HxBJg90BYaR4invrxW0Wwn3poc+/6Y4XtzTn+FmU27q7z76Btg09y5NhVHE4dUzCbYhwDadqScfAMQhZWXc/NVxLwf1dUDPJuX4++a6hgEesJcC7Qy6PukVYaLVVoRSFx/oEcCnZMo4CcOxhfYgppQvQOxJ6Ld547Ls0nQMtZucAyCd6fbUURNFDMw/CjYAvg5D8PIfeQjX6GD9bE0eU+hJJZliVXRJRfCk3qs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFvBqhSL8tOYVtAu4Y54abXb7e/A845ItJf4IwgBIbA=;
 b=sv9GGSR7l+R+7EgfjrA5HGl1TRs+juqfDTAjoY2WyDEwGA7rxqsfx3lQsfUPP45qixp77g6rRhD8WB3zFqQRdSxglNFTYlZ/ycs7FK7pwdIWoC52rFysra/qURLpC4BJqHDJU83CSo6slk/gQVDYka9Navwmk+4coFmIbGEy9aQVePn1HUVWWdNLLi32sOYF0J9tcluNDt+LUJOHLnx728Kh6GE5w37vXjVNGWW+dfBbNJEsSrqiyCs52WErljZOznBNBO0GUGrRpn5ZmHNW4nPrcKyud9N44UXR7IvOwZKyz3PASI1LEN8cNCCR1IY2YotxTGUwTJ3iWGK/ycVtYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 17:25:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:25:27 +0000
Date: Fri, 10 Jan 2025 13:25:26 -0400
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
	patches@lists.linux.dev
Subject: Re: [PATCH v5 03/14] iommufd/fault: Move
 iommufd_fault_iopf_handler() to header
Message-ID: <20250110172526.GE396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <6e4f3917e2bcf871b958c0d9f69dd3a182ee8ce7.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4f3917e2bcf871b958c0d9f69dd3a182ee8ce7.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0727.namprd03.prod.outlook.com
 (2603:10b6:408:110::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: c9617997-8962-465e-402e-08dd319bc65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQ8TPeBl40ZyKZ4pCdCoXflBGb5idRqvdHFAH/glwiLrAAPWR03BsEHYJyTz?=
 =?us-ascii?Q?bSHMnmj8/OSX5wX3mUE4azv2dYfMWA2vmYvhCVbLct5g/i6o1bXOV06+wlcH?=
 =?us-ascii?Q?7IwN8q/Kly51BRyxkvRzeJ+z6D0aDx0QyrWMguxJN3OdDgzDPV9KB7AodiZs?=
 =?us-ascii?Q?wp6wgwrQP6n9K7csg6dzLqe7YMrwJifjXcYsWPBXsTMC3O9+Fv0u3i/buJI3?=
 =?us-ascii?Q?qKlNGyFcr4LYZJcIiELMhEx5oPJCuNq8S6iu5hqEPnKA5EaVPwRRnEOUe32S?=
 =?us-ascii?Q?5srn6ZDd3Jm04FokcFf4dzhr5dSI8VX7TA8AF2imgmwWX9EXvoXFFi3OU1Ic?=
 =?us-ascii?Q?NfRxuA2mIAfgqbk1JzGZ9nlau39hgbUSm1GhPTwlXz3llK6xA/Ibda+FIJaP?=
 =?us-ascii?Q?bTReAOfuIxMGvnyR/kewWLRCYuyZtT8QbuhKEkz4pUxcoQQBYD1N8xoRm0u5?=
 =?us-ascii?Q?FbpuQ/mosGBsFSxVBW5HV+CnPFCBwoxZwNT9j7t8DwH7njcW0ndWT2AbHh4G?=
 =?us-ascii?Q?cr/JnwTbuOS4WGSTwWLXCEdc1cftxApsHl/YrE5NG2ABOahkNRIz5/VyghYL?=
 =?us-ascii?Q?q4f2+XbpYhAWTMTmbElNMJZJL7J+Al5y9Foc6WOiwGwF3+Is91ugTRBJXOqX?=
 =?us-ascii?Q?7zMYacXUhiyXsm4gcd6lEj27GbwLQ8xjWrDnfa1fCTBn1L6H/Qak3BFAkMzK?=
 =?us-ascii?Q?96FHZwN1BY3jxMLRQEPNbR/4/K5XaXxfbjB973VOP/XyfveQwrbkL8aMK6kJ?=
 =?us-ascii?Q?kvmGACcltW0fw6TM21cBJDUdmfYpZg3R44HHcGEtj0sW1yWd4qFJpkCDnlpS?=
 =?us-ascii?Q?DTvkfFGBqgdZuvedF4G7rc6zVJr9+/sdUHI7WMGNlWMuEeLT7WDwCju+cJvD?=
 =?us-ascii?Q?LsI7ZVqL5efpb1YjcdDpgvvDDjUDrannbb7oton/pat0x/+3zgEa36CP1ds0?=
 =?us-ascii?Q?04hiYJTSgaG8JrJhGZ8CxYvkjJzkf5DVwhwuP+Ngbd53igCe4R2PcPl0GkDV?=
 =?us-ascii?Q?Na8AZwul7y7kwYHyn+Mex5aC/+BTybDymFf6ksBQFeRl0vzai1HEbwNHOpaP?=
 =?us-ascii?Q?gK7dpP4aInUGcHJeopI2RYxGFXFBCYlKa1umYcLk17sKJH8uRP5RGASpaxS+?=
 =?us-ascii?Q?ifLSL0cLl+hvB5Ryig3reZynC3LJyLf7EhpDybxlEySXbiouXnlX7ZaYhyL8?=
 =?us-ascii?Q?GvkVoHU6tMzhwYIcFFdaeZVSBTPpYgm3GGEFT0fSWZPR1R7BaBl4N2/kBu7g?=
 =?us-ascii?Q?ICxNXOC4Sh4mYm+KBSHmQa/n2Q/u1lSDr3X0GiYt7KGZCQMcpR8J3UcX7aH3?=
 =?us-ascii?Q?/L6x4VOeqZfzuOy+JilITC63izJhXzz9ZiIcnhKJipdUeTo6nV9WO43Ig/Gg?=
 =?us-ascii?Q?dejAFI3G9blo1p4F+QiQM0kHdEhb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pEmS5nLUwmHvmxsKk/thv08tUZb78LyJLD1XqQVeEbfWxWp87tLvpfabXvF?=
 =?us-ascii?Q?5KjUiA2XQn3eLL9UdeUsB753fANTe9lQUb4ON6j2cPCZioSZugx9MuoG2E63?=
 =?us-ascii?Q?NJ/seDY/Rp+83k/6lsWWNKpB7gEN0JB9qw2n57lMSeCWIQIB/UH6qAaLaTri?=
 =?us-ascii?Q?y9mogJ7E2wOrRdoyGVdvMPIzbEv/ryIzBpVBEUg7Tf/K+Va3mZeG3RbpQYnn?=
 =?us-ascii?Q?+b3eSNDB7JjRqy2I1RGRqMtrfm4CTZAxDtuui0tWEGN5y2RaF9jH0MByznBD?=
 =?us-ascii?Q?2BKuCQQGrljRcv7OxsD8rAUpPwgfexMlIUtC/gBwDPQnAqjJxkSDZXvx6D+a?=
 =?us-ascii?Q?kSSHKkNL0/ZsRflsftW9tupLElEvOjqThjUT3nNq14S9A3TNtw1M00fR/LTt?=
 =?us-ascii?Q?abXQRtKOWMfCCZqEfHTcTTLTgL1U019czlSei9jq/wWOd0NL77l0mqN2gO+W?=
 =?us-ascii?Q?N5mNDMOdF4Xu1mbQ8qhCWN96SxqMdLcKgsxXMR/tVZm1yX+2YvbDQ1EB1cdF?=
 =?us-ascii?Q?dYnYhmfdJG1Aefm0v0VXgukZSyIbkBfdCvGIPWM+R/7O0hPY36HEOHmX/OHY?=
 =?us-ascii?Q?Iq6Yu1K4tozW7sUaKh1GhcgmTvOs28AjwfFqgex5d+ND1/F4tRArLrEpnhX0?=
 =?us-ascii?Q?uGECus0XdQOrMvddO43de7QAC3yWt+lzxna245kgP13JctXlwSK4E8xOiyrM?=
 =?us-ascii?Q?i61gviQ8ZshdIPKAhjx4hvrzEM92TolVpP9yxA6KgTnj0RU92ijrDYowpV6T?=
 =?us-ascii?Q?E9Yhhv/ZtHUFpOQZ5i9xcUIuWM/gmUsj+/rUGnQBFoV75oF1usd0ZpNf455m?=
 =?us-ascii?Q?PRb0kAEZLq5ZSi67Fpn1fjlITI5ahkXXL8QINYW5SKlz57RjVthZNlvYZSwU?=
 =?us-ascii?Q?n314ckhfAdabWjrXRwNdVteEFuyG5ua94LtI073p8O40kmlCFyDr/ZwOXT8v?=
 =?us-ascii?Q?zLhqN2HoMmnm8kyAtI48CqsWIhOLQc5dv9429XjLjxnCrvaq33rG/vqmJcO3?=
 =?us-ascii?Q?CH6y8vz1hUXpMWJs9B+HQK7UCUaICL3rZvXHH8k0iMWdPUcw/g3BP/LHZJhD?=
 =?us-ascii?Q?aiOEWk0nf6AdcuqHvjs13WAjCXoWfF4uiMBGUKa9v+j83NNQbzQYw1bNTrFT?=
 =?us-ascii?Q?p3rrY8FBnOdQkmAavZB7cx2+qpVktpF9RS0Rww+rGUzkTJUyV+AazROqxCTP?=
 =?us-ascii?Q?hPmD76C+V449XlxuPhsvhIzau35Olhb+r19cVsnVBADgkuDqVx01w5dHJgdl?=
 =?us-ascii?Q?UMgu5Ue0xqMup8vCTD6lRz7LZbdY4QGbQhnscyJaVcnRwfiFbyaX0tKXvdEF?=
 =?us-ascii?Q?mX4NVR/Gn8IxI6+rc/0g2m1Uiw+wYVz3YgnB6SUHWwxvTUat2VNcKVdoNSaF?=
 =?us-ascii?Q?tReRRU3nGXh/qdpZnvLyrFmWg9mVOFea4e6NK5+6sYQlrIVAbLfA4yq3jYWS?=
 =?us-ascii?Q?Ydw3vYlSGfzALBXSVQnkrXPtvJV8ULCaycYsf8WSM+Dj/Y5kFNu4KqtRluZh?=
 =?us-ascii?Q?sTTf92YILfzouC9m/YrsxbyLpIrRagmT25JMyw1aK+Cpg0k3Vn7pUbjYjnkI?=
 =?us-ascii?Q?EF1UB1oIssEpMZXWuklhK6YJstPuKu4hXk+tBEL/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9617997-8962-465e-402e-08dd319bc65f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:25:27.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z14PtW2gIX3SK46Hyxz29MWkUGO5XC31En5MCu0fYUmTJM/ENyi+OUbT92F9CIU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

On Tue, Jan 07, 2025 at 09:10:06AM -0800, Nicolin Chen wrote:
> The new vEVENTQ object will need a similar function for drivers to report
> the vIOMMU related events. Split the common part out to a smaller helper,
> and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can include
> that in the driver.c file for drivers to use.
> 
> Then keep iommufd_fault_iopf_handler() in the header too, since it's quite
> simple after all.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 20 +++++++++++++++++++-
>  drivers/iommu/iommufd/fault.c           | 17 -----------------
>  2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

