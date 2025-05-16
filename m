Return-Path: <linux-kselftest+bounces-33186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877BAB9D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A870E1C00495
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0114B08A;
	Fri, 16 May 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OkQa6Cl7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB65CDF1;
	Fri, 16 May 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402202; cv=fail; b=tA4FMcw+t0Tr797tU4yEWqWZoTMM1qC3OBEM+seJ1NQOijKaMcOd5FZPvw0qSxKEoYouMWEBFVRQCckCUv93+MHwmpgpx06q69cCFUtx2JQnCvq/+Pz13hyuXop4KRscv+aztyAaOcXmp+qJw3AJzFq243vZWAk4slE1enyJ/k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402202; c=relaxed/simple;
	bh=dHKG0duurr9jnL0eBcrEDeTJTGsLHtnWDKAROfjShMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gl4CSvv+LreDEIynVOod9msg+SQMn4aWvfvvN1NJim7hJzJvGObSdtSxISF0D1BM1wL0oN2ENwit2g1IhrUNB4NR0EZXKKBuWnekgJdJcIPKwT4RrAsWbFZ65qGVh446uInLUkIrPgfWYNJLzfB2Vep67eA2k+R7y4CxO+O1Fno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OkQa6Cl7; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS6O4fNhR1BSqoqPoHK0LkBmgb8+cgRC9K8ddo+a8e70wMCtDd7kAPH8Ouqoz1TvgCwj7N/GQwlY7eupSmlNlM40iyyWqm9qpfPr4pemGIheIHWc1BF4m40PRuKvUxMnGklnDz4GA3UbcTp3mrLy7N79QDYSbvI0q/Kg9IYJnsY0L+EHtD/dXvkmjNR//nXM/TUnBMF4eniIMrFUuQKPAo5mvqdgYqjRJ19lw0RJF0zT9nGEf+fUoyDkcy73OC19Xs5fJudqMGT3bU4ccSNUFXlxik8Jo0zIE2/d0dRDww8KuFyErTLlZ15k+kxmVCvaHTHyY3mnzA+rutvKD9q+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDl7Z45sqgGbLQ4Ht8v+sjoperP0vLopUjO0oEcuAhs=;
 b=FS1TG+DTJ3wb6+Pg9dkeYcenqt9b6zXo+++1cN2LWzMeqO1fDkSGmVWRna1+kMIX8arykn3BkvlCJFtTFuAynELWLJaD2TgWZGirVLuhl5Yl024Kb/PydH9cS272vdk8D8SAGhqan6tbAdwHaO66tKCjC5CI96pTds/ns4ocxFMoQtNg8GUadsMMKRAiS+WxYbmDTLaHXIXUK8kPVYIr74dZz+Imf0u+LncKOR6XbWt28F32JOnNPjCUaXyJeFL9oW1yFQZI2j6qsOmKXdTOSeirzc40B2/+EdZDqM+1ps6XSVDeL3SjTxcwUrCsCad0LaGrvNfdVuQucP2BfO/z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl7Z45sqgGbLQ4Ht8v+sjoperP0vLopUjO0oEcuAhs=;
 b=OkQa6Cl7z0KN5wqz60V7QkR0TlnvSE/+x2o36+ZJxHXfUjFLhNFYmXauyB/uJ9qf9bfJRQkmey7+EyxBmf2L8u24bxfYIiFGQZtmm9ZqeBy+O43MmHTt9qjHC+24S4JnpG6QpNqMF8/YYFsOLpCsJhaB/fq7sOU21BnYT95xKOA+XNUMc868S0xAYSh0xJmq7KrvE7UAx8clzjJTFPL16f4k6QAcIs6d5J65T0cmEfI+frnhesYbFlWmhkxov05qPIfH5lVyaaQB4tyhIfPPbRWUNO+P4ijtLOCybl6xCGleEG5VpN7yQa5HylEjJwnlHDT3N4jndBst2oviP9B+WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 13:29:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:29:57 +0000
Date: Fri, 16 May 2025 10:29:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 14/23] iommufd: Add mmap interface
Message-ID: <20250516132956.GI613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
 <20250515164717.GL382960@nvidia.com>
 <BN9PR11MB5276DD2F2CDC313FA04155C18C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DD2F2CDC313FA04155C18C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:408:fb::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c61ece2-5bb9-4706-e941-08dd947dc03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yvaNZWdnwjct79F3oF5sE8ND3aYMJr49MWwm8jh2CEHZTug3aeMG6jBqXzJW?=
 =?us-ascii?Q?s+U1KhgG/NRlW1D3LnqOusIEbBU2RL+ae9a8kW5pzrTqv1DpZKwsmLlV1sYW?=
 =?us-ascii?Q?J5udLMRKkC/f5uXn+Ych+67LP3T0HX2VIrNQL1qO+rAo9xEVZAtZtBKpLiUh?=
 =?us-ascii?Q?70VrtIvxqidk0gsRbk6NlNCV/JhC7cVEs2GSV5qwLg+iEE13MP1mswNVQq1t?=
 =?us-ascii?Q?j/mQiYcVGdFhScpdU3mKUZiDufo/pEct6RsRT9HnUteMgEtqKLu/WUw79JCZ?=
 =?us-ascii?Q?jUTCIOtoz4IVg0KGr9AXHrPczfTeNXKs/7OjNENJS6bAvy71eR3lbvzmKEUQ?=
 =?us-ascii?Q?kzzbjxRQrz7T+zPgXcUPjYyTAIjvUQmrXztejx40Z96YmDgvNKgC6hmvL6In?=
 =?us-ascii?Q?AoUfaXpnfd9N3Q/9oFE8bPxWXqLF6FfW4uiuso2EEQ6zi3cI8OH9ljahPD5G?=
 =?us-ascii?Q?VEuDMJUrl6VP/D8ANOGy+os+qCzNVqJGUkiG0G6Vo9hpNJK0RPqUUXkhdF/7?=
 =?us-ascii?Q?FxfQR2dyBPJnGZiOcI8p40QlfK+yRsIHVrH9NvnZcDfJQ0cgmErDHUiWr56P?=
 =?us-ascii?Q?iNmgM9jTeyd6B1LgwjantEkpwoL04E9rE4HNQ7KsWw/uad/8C4nAt0n25TtW?=
 =?us-ascii?Q?K9tpvKGv3H+xph+itbgoPKUD4iNso5zLsWc+ktRQCu20iZrB1Za3gyFrElDk?=
 =?us-ascii?Q?krX2+hUiQ6Gv3okmlAvqXcNW5L+adfl/Ff+jhuxqgI4uUyWIbQUyY2//B1dn?=
 =?us-ascii?Q?PTFdKlN6KjewZEv1CrRhw7uZJHAcXTQzyBaxMbSdNmUedKklfKPQ+rOsoVeA?=
 =?us-ascii?Q?/MmiBJTuw1i4v7/AlxwsQrrJpcZEKjROOdTKFGhkDt5zo+0T++k+xDXINGtF?=
 =?us-ascii?Q?wVGANtw3jK8IEMLcLCGgbf9AD/rH6LeIVtMJB6fj7QlMJyITRMU1gPhSaITA?=
 =?us-ascii?Q?J/L/+yhm/elAETsQlzfFEalvpVeIoHdOCd6WMH3SN/mrG1/RQL8X8kDS8D7i?=
 =?us-ascii?Q?cPjwJ6ReCXpKcW+zauek2Ac8XbbXfsI0wfw6w571y05jSh0ux/YHFUCpeEiV?=
 =?us-ascii?Q?Hq6WJ66HSujSqwx3zy5z7c4YBNM39ddvSa5MIBvxfGuvq4QuQShPy3x5HrwX?=
 =?us-ascii?Q?cwT7ELlh2tsfzdZan8Up8Qn1AFrsTdaSCOUBjc2/91BwnvIAF8hlbyp3oS0B?=
 =?us-ascii?Q?CWOqkJGTc/ihlW2zdf0BOE5Y3A4WYz+u8DoT5DuXq53pyloeiBpKZWSr6oa4?=
 =?us-ascii?Q?MjV8oQY2bpiikg0+7qqBRJPOq3MNwdZMG95PQf7RQZNi729YE3GxK1oN5ogu?=
 =?us-ascii?Q?eCRM1nkHS/r9vyEAtQjhY8ZEfcBmJ36U41HIXLqfmYtDhPL9NEmaVRL8mqwH?=
 =?us-ascii?Q?EVxDRczuTCA+SVYk1Zc+XZtJu6G5gvCLNkjaWpgrP+ptnrB91w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1QXk/E9ixXI4qu3KuvycnHyavrMHAnYbd8lOiXGrzYawO5UONtTKthPvrCX?=
 =?us-ascii?Q?IPNvT2wmrBWevR9/le3+8YOu7suWkXKoQ1+A9FLss0L9dr1UjmYkrFJ57B6/?=
 =?us-ascii?Q?O72diGZ7UnC1nV7v7/n49YDD9wzeRBHebBKGm9bfy0EodRWsDp62LDJDpUTH?=
 =?us-ascii?Q?WUJQIagR0NDSeXYoO4n7DkAkLXwU6FWeE8WkBPuR95wIC6AnnZTM4l+gg2CK?=
 =?us-ascii?Q?nh4OcAO+GxIr+IHhdwSNHukC3POZsSZ0zlJVdeUblCPTUa8urKaN1A6C4RKd?=
 =?us-ascii?Q?rLNQyDFc0fDoPunfyOszCR1cWtGv7rMiPvOgK0YJk5oH4UgZhXK13qVfM2s+?=
 =?us-ascii?Q?i8woKc0ZVS91oMSTwXAKny4kREDQLl2zVmiDdtR0cIVD5s9ZS2TQEI0C47cj?=
 =?us-ascii?Q?NaAzQIC7EosUSv02veegqoS8s2p6OuH0EeBxxonvfDw3sU6RCxc/FlTOu7Eh?=
 =?us-ascii?Q?vp3UkzIYmesnDAhp6FpAkZRBDVTjjj+tg2BVBJ0P3c9Nus3y6fVj/JK9P79u?=
 =?us-ascii?Q?AuALfnFTzJ/e5qRu+94J9Mjue29oOVHggO2qTkh13nlqdI63UGXRcD19L/wj?=
 =?us-ascii?Q?KhmYbfnzrhHUMn6bFkW/juPzUyYxjZtYJu1lFrQxN1Y19UDlXbJRJ+d1V1bj?=
 =?us-ascii?Q?6F8wTVRfqTqBGnyUVArRO7IrRc7YvxU7gFg29jqXLc7WQu3k+/fqEaevMLlG?=
 =?us-ascii?Q?dX55RRCzJ9v7mWGBLmG2D8S/VPZa9WfULN+5+y2M+RZ2/zU5IZCD2QJ7WlEW?=
 =?us-ascii?Q?TXbFJOKICV3ieVE/ie7t1Roc23hMYnaFCuVyLvg911DadEZPwqL8txT9JfTg?=
 =?us-ascii?Q?gDpEPvbjyPT0wN6nDQub3Cnt5cWQS+dFGgGw9Knnw0IwqHydHtmRyWk4HBM/?=
 =?us-ascii?Q?1BEsmp8ffwj3p9jRFqu20vVWMtm+fhBsxID9nEdZpV42luVUT9ToJ7LCjML1?=
 =?us-ascii?Q?jZ/nxvr66wbTaBMhVmAtlIawQM92aL/rjcNWDFCeKHGTD+xiOjZSVOzDAHwo?=
 =?us-ascii?Q?1RkjA3Mjjs+TAdDd+drmu9X6co79PVURj7eAOQy7OYJ8n594cpvaqy343L3s?=
 =?us-ascii?Q?LIQd1RLJH91vY+LKwQICYtYDfj/inYt5IxuGimgcEWiFv78gM4JuOLfuFFa/?=
 =?us-ascii?Q?I/wW64DQwX+mtts8dLFzxB9rRLdrm01v7wv/aeXCvUBQAMPI1/TcGH11T8hr?=
 =?us-ascii?Q?+mNWc9De5azCwmL0nRt3Kpedbenw5EDhOID/uHLUqDTnV/DsMfxJ3X1QAE5g?=
 =?us-ascii?Q?zK/3CSrB9R3Aow03/MdJkcBDqxuD2sCKzK7h4RO/z8bPus9tt/6xrL0FbgmE?=
 =?us-ascii?Q?Sg6sGGfjrq0W475ALh45UrR8WWjXosIA/875rd09fyO43Yg5KNm8aoDM8ETv?=
 =?us-ascii?Q?CCKWXL4fAAVOZnjqpAewzND3ex96rL/dvw6uoT7PcKsOUsbuobJwM7r1+/pX?=
 =?us-ascii?Q?er+lwxcegHp4F6l4DlwRefcNZf6yM8S3kJdZWfRyrCEkH6/cVGYMuDd/YF+x?=
 =?us-ascii?Q?BoRjZr7nD5qQyRJJ95Rh1mbEfODDTf+KlA7fHpKty1WJMfWtEeFtlF7v/UTO?=
 =?us-ascii?Q?Um6BQUKXfSxN1XCYxnUR7C8IivC1/Rc4ccbFDQiV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c61ece2-5bb9-4706-e941-08dd947dc03f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:29:57.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLdglQ5TGOHW3LhYIS5V5PTnAFfPejXgKYVIqBb544Nchyynx8VNiMKJr6GT630n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Fri, May 16, 2025 at 04:08:25AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, May 16, 2025 12:47 AM
> > 
> > On Thu, May 08, 2025 at 08:02:35PM -0700, Nicolin Chen wrote:
> > > +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> > > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > > +	if (!immap)
> > > +		return -ENXIO;
> > > +	if (length >> PAGE_SHIFT != immap->num_pfns)
> > > +		return -ENXIO;
> > 
> > This needs to validate that vm_pgoff is at the start of the immap or
> > num_pfns is the wrong thing to validate length against.
> > 
> 
> vm_pgoff is the index into mtree. If it's wrong mtree_load() will
> fail already?

I'm not sure? I thought mtree_load will return any range that
intersects with the given index?

Otherwise what is the point of having a range based datastructure?

Jason

