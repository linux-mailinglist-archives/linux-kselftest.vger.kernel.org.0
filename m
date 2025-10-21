Return-Path: <linux-kselftest+bounces-43674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D8BF7E07
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C6E550365F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57858351FA4;
	Tue, 21 Oct 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pX9pcdQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80C353AD0;
	Tue, 21 Oct 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067158; cv=fail; b=lkOSXa+BhF2ptpKGOQu7CJTmJ+TbdMhtZXD/WFr9dhg3GnpYB67FwKBKVs7Bl5cPdZqWkHlamY+wYqDSb4P4y+PhMX+ijKLhmkevqwEgevHaOXHsxDyYOWe31zTyscLylzXTFi6+fhJkdTjITsTYqAnDke8oHQ6aSjp5Xe7sDtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067158; c=relaxed/simple;
	bh=boRjueFfVm5BcH40R0qPsSpmiiqE/qMvUAyb+ku5vvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sHLY0uMxMOTQyTqzXE4CH0qepR/7ypCq0aaQC7b2cm6gCVjL+nf/XLPlqQ2UjXGJ27t4pDtdWk7l6aB/9LgOpvgiFxyA9FxSWekwh5YYCAQ7Ulkc9OYKOHHodVReWzkxdmv1d1wf3kyuBwK73Wic6hU/hUM/AaMTKBXJei+Z2Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pX9pcdQX; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGkEcOcFNnS2XLuvly0YaKe9c9ubFdXiHv8imZnvGVfR9xO2wZDZpOSkB28jqe1kiSi87DwvE060JRrIN7ojuLvhVx9l1bhp3yMo2jDSYHtzwNGU5gvBdqbPO5t/2GSM0ED4Psr5p7s/jFDAbGggTR9U2gLnyINfcE1vAJzoCEcIE9WmmCXWi+On0lotYtornzrgfuODpIV+ZT7kOoD9qrTnK+rUJ77zjHVbrIgkxWfdVaOelSdq9hcr5DQFs7IsKX14BJb1Hr1qe5ICYSSld6LnRHzufIeGTqwGhd21CcxBf/Mzqp0jJQ01ms426KbymwC708HInxBrGEk7/5rUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfIKvKbhlf5nDV/5OBreet7fe0jiPdOlAySlXWfdjII=;
 b=dFmjOVlJNQcYJYbFQ1WRZilA5rBYGdk5e2FchcZImFQKCDyf1F3uNCKJ1YDOfC+aQWubxhvqbrQL1bm7/pReSDwBE8SYA0DdVA+kf+4PJ5cvNTawkvFAGFcpmpDiYIPXBQB/0EZ9zIB93vNQmjXgOX7aR7jBXZF2KCwEhz5bV1JSoODzJN6PhrktF9xpbr6OuR1tRY6zvHKdaYgRw0LWV3Jbvf2/DrpolxC/n10trlugsTRvwaIb1cCKhvz5370ccHz+fC4lqopaFN5MMtbDfcfUAaHrXtkQBYfjzJJN9R+WmqfViuPRnJsDpA42uvorY0ar1spDqSfhz33YWR2XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfIKvKbhlf5nDV/5OBreet7fe0jiPdOlAySlXWfdjII=;
 b=pX9pcdQX7tOoJEvzP0wMI/Mp58cAB+xRckDXH4c72zS3mtYZsviTxwZEFnXAWKim/g2drHcL651h62RyA1VbWnnNs1tJMKWUARsXZbZ47qRDERIy3YsCTsyD5RDBl3++SZETVk3F2JtGtbwOTKfJUXBbRc/zEh3TSfbmgzM6+Jdw8A9q7A8tCNuC6y2arPV6EQGrctjHt3y2+n6VPa3wERbkcAgtfdopXCYd7BJO7I4xvw91+ThgZRPVteZs76JT0aFpYBa0/SfV4LibXPBYw2i2TAGvg89mprzZWqgGeCggXOmVoUb5Y0PhJ8iNhF/B7PQhCvpAhObxJnnFfNzoGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 17:19:12 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 17:19:12 +0000
Date: Tue, 21 Oct 2025 14:19:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 07/15] iommupt: Add map_pages op
Message-ID: <20251021171910.GH712833@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <7-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276271302BF0AAAE2C7085A8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276271302BF0AAAE2C7085A8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: DM6PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:5:80::39) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 530355b8-ae8a-465a-5a4c-08de10c5f3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dG68tBnWUQ2FjH7OlabvaABt8OQek9Z/FWYSpte3T+uWZpO8qiCxuNw+A0v?=
 =?us-ascii?Q?36XWSnqyt1hNNG5OjLXgpy+k6msCU+4BsoWF69CRMkJ4KZHn4Nuv63s50Tby?=
 =?us-ascii?Q?JhQBXff5UkN2sOGoxavHWQk+kZ9wjwd+OS8x/H8rg6Ean02CrvPOlrYIGQnk?=
 =?us-ascii?Q?luMmEc4kAuTKIORFNKJfo5jFFV5J0E4Hp/3mage05A/TjlL07QVf3hrqfOw5?=
 =?us-ascii?Q?ioIClO3CyWH/bj0TxVPv+ddPVX4K2xwgKWccAx/Fna3hMK4/Pw55DfniltWh?=
 =?us-ascii?Q?NvcdQJqCvai5ZjtrcEU5QtVVkZzNP7Ri4gjPdja7ILAcBOHc+TpypeNwwXCt?=
 =?us-ascii?Q?nXwxKj5c9kaT/cn0CvApVTHhIpEO5zUQdDgKq9IJ1baT34PQXsz0gqP80FFT?=
 =?us-ascii?Q?HprymI9vUUUlgBWPSuiLVkyt3GhpTP39c5qhSXd306+yZySIVfpJJakuy7mM?=
 =?us-ascii?Q?bZI4FI6HjwG9plCAj140oOZWcBZyZ/hk2R3TayISo0SMvygZzYWXcpjg/wOv?=
 =?us-ascii?Q?wWzFgsJsRuXe6tpn+l1eCAZM+Pvab6aSH1tO1QqWpayYsavPyyPahKXw/Iln?=
 =?us-ascii?Q?DBuMezqbNVkLYkZnJlepE3wvuGX3vabd06CJngWDe5y3by/NXFCA/btTl0L4?=
 =?us-ascii?Q?o1p+g1f6ZlYK2kSg7Ulul0YeSsJDxzZI/Z+HJhkNlmo41QNpxmkvRw7vRSHd?=
 =?us-ascii?Q?b852nbmGiverNLL+GWLwSRxcJSdEWV/pf3YNfyOIWeSyLZgmJKc8oVKRzT6/?=
 =?us-ascii?Q?IUBusSXLJDNNGbPD5qK4R4B16FyA7iTyMvPvX2TbJEhnE8abXwi/ND4dSsyP?=
 =?us-ascii?Q?9awo8jYHHkJEaurdX6H8F0xFQjDnoRnvekNC9qxkmSvsHzFF20a7bK7bj60A?=
 =?us-ascii?Q?Mj7zaYk6GDC6Wq6MjzG7Gu7KdqXZjA+BVbxGTNnTFEuqr5JXw0pfvBhJKMOI?=
 =?us-ascii?Q?QJVZvVkI40TBoUM7z+TXRWqbuzAAYIPMmLWa0kRGdtJ+L0g2PPHdSwPpbi+F?=
 =?us-ascii?Q?eycY+8G+80NqpEvbVqDFMTkuJMxFTN+iOyboUixMihTLuu4+DSxGbw9LlQ83?=
 =?us-ascii?Q?cKJMw4MeQcIffJAalsDwwipeblTAfu0zUJFHorUh0joAzJqJt4Unw/Xa9f3D?=
 =?us-ascii?Q?BRnfz1/UT6TSeii3l2y4rx6LlC6OJQP8iki0NmtzKIZK5C/emmBR/4vV39IR?=
 =?us-ascii?Q?hp0XsGtqIrcElJPBdlcyaaynV21awaqugQg3vapDy8g4lok1Uq7wh5kndjqF?=
 =?us-ascii?Q?qV+AR0YHR1gW3ZvEp7+/GrtsTjTQHj8E6Tq7tVUWbAFKUTbUG3ka9lpc6XpR?=
 =?us-ascii?Q?YtwBBNJozxhRfV/jeqj964C+ge9kFa4VFAmwYZ8rwRsx2cBBMd2qpppgelBs?=
 =?us-ascii?Q?OvffeSS2hhLnzCAx39yGAHiLy3Il3JnC8WjBGM/k0Er1ASnZcdngSBUtdpIP?=
 =?us-ascii?Q?+vGahPAH/T83/K7839TH4gNwspTY7gcl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0wiwYuSx8ITDfxktoTYYCIB3JPyIOoVfM1RMNkqEZtBm66eF0MOFL6+Q0l9?=
 =?us-ascii?Q?tyeLlyimrlMswMDVsOGo0Ey41JiJW8cJBCe2sTnYH9hle8jdiu7kzjnDzxwi?=
 =?us-ascii?Q?RTiNhI+LaFUMYdpo0joxxbwcmX2FjLgRGHYRRRAf9NI7mcPubiEnNTn9MjGg?=
 =?us-ascii?Q?B6Ir4bjq+yIL9IMa6ocavYwhsqhv+FzQ2R5Z5OVNBtVCwbVdFO1DAaEG55eD?=
 =?us-ascii?Q?PFkX/bLlYd4+K9IH12HrM5JHNACIQY7BgcrIs5UaC4DpgigSq3z4PZjIP0MP?=
 =?us-ascii?Q?33rq0HjfA+2P7C+95RHlUGeJDAfo6ycV/ivdKlqdfWQ31bwoWam10DV5Isd8?=
 =?us-ascii?Q?OjW3aHLUG7TfCwku5BbNvF1wxIM3q/UksiM5CK4AcqQClBYyRWJw6KdKwWdK?=
 =?us-ascii?Q?pyMqTr6z6RektOquJey9TMgASVVmYNpKXhCWbZ1J3FigZZFgUYOpVEqVx/qW?=
 =?us-ascii?Q?RLi3tnF+ncOjgDQwqR7BywuzbBvhAmCBFPglrcz5QlZbRJu0gjHAPGK6iiwi?=
 =?us-ascii?Q?9msy8zz+A8IX9yVdbIWRTFvQgtziyWoAYELHOPx95IfBrnatcRBpp9nnu8/F?=
 =?us-ascii?Q?BhIfU8gDq3V3L63WylyqwJLMBO9+katDFcW30MJDb0MSXyGD1MXcHyKgsuiV?=
 =?us-ascii?Q?ukQOsNJERvXFVeIEHrQFQD2lHYgCoiVtDoaWw63DLLKMqzgQPDOP8V+wg1f6?=
 =?us-ascii?Q?Yo6lwfhnAjVaXt3nUm/rQxnSwsf+gZBxtKYFkl3PtUC/knnPiUeM6OqAbBNB?=
 =?us-ascii?Q?wQ1AJK45xxDKu3nWTvdlAl7oauLM6OzG0QadGEotEtKjOQ2jutMOxFAgqfty?=
 =?us-ascii?Q?gLQPPkoxh4IILEYikw3BrvG3KhhjoVLNn6VP7p41BRnMAmOK0goPfhz5EJJQ?=
 =?us-ascii?Q?61as0ztzkl4IHUgrBBoDBPGYFp0noVHgXCog3076SLBhZ2+4/vWE3G+pvjap?=
 =?us-ascii?Q?9rqKIMCFh9a9p5mb53geBK9Ydku5RlfnT2W92VOa9yGB2LrXZg7SYxjpStvC?=
 =?us-ascii?Q?JN1zAzFMqS2XMVyUCxw5ZG2+FdQd0BLgLHBanubW0z8o+00gdMp7PZxQM5fb?=
 =?us-ascii?Q?VPhzNeFyoIF80fgOiCwFj4+x0YTJstA8qrr5UT1jBMpOaK1t5BuSuEZUBGRc?=
 =?us-ascii?Q?C6BfLO11I59BCFKExvDcDQ4/MnieShSyDmHogHRPmiDp+hRg23mCv/vN1D2B?=
 =?us-ascii?Q?sRiOpjGOooFosWPfqPpexdarM5XM+RIgn6Amb0mNiiA3EAYPhT7rdkjPIkX7?=
 =?us-ascii?Q?ROkdmC3IsLEKK7TxPOwzbj9lXeMu/h/nZ27GiNHAb3Z3QPcJmLFn8g77CLyT?=
 =?us-ascii?Q?B/FM8BJ++jWjCD4VNzjR+SFS/xHWh/uRwAMdXnjhqQdFcX0DIIu7mgkPJYWB?=
 =?us-ascii?Q?EV9e08md6DrVZewZiUdl4ao5s5Ga35VmHqF5P40+oPCQxMM0vSI1d8w2TTby?=
 =?us-ascii?Q?52J0yuyth+WzvWaZlEzsZHqo1fLrvvHAGu41O49IzN1/hRjzJvQAGYYkBX/7?=
 =?us-ascii?Q?Ml9zr0K7WBO9F2WBsxUwnT5B0iRS8HNqVs1VeKm+Sjmpy4nWLpv3/GLEbveQ?=
 =?us-ascii?Q?wnrq0Ok3+uo0AyRCOw9s1Gb2SkAV5zJEaGnvMKuD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530355b8-ae8a-465a-5a4c-08de10c5f3b8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:19:12.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlAqYFmKnLyZYPgGhhCXDb9us2epLyEivFdS4TDVkn5Eii8h1ddxel3jKivNMtNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

On Thu, Oct 16, 2025 at 06:52:09AM +0000, Tian, Kevin wrote:
> > +static __always_inline int __do_map_single_page(struct pt_range *range,
> > +						void *arg, unsigned int level,
> > +						struct pt_table_p *table,
> > +						pt_level_fn_t descend_fn)
> > +{
> > +	struct pt_state pts = pt_init(range, level, table);
> > +	struct pt_iommu_map_args *map = arg;
> > +
> > +	pts.type = pt_load_single_entry(&pts);
> > +	if (level == 0) {
> > +		if (pts.type != PT_ENTRY_EMPTY)
> > +			return -EADDRINUSE;
> > +		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
> > +				      &map->attrs);
> > +		map->oa += PAGE_SIZE;
> > +		return 0;
> > +	}
> > +	if (pts.type != PT_ENTRY_TABLE)
> > +		return -EAGAIN;
> 
> return -EADDRINUSE if PT_ENTRY_OA. No need to retry if no empty.

I wanted to keep it small this catches if the table needs to be
allocated too. This is a bit clearer:

	if (pts.type == PT_ENTRY_TABLE)
		return pt_descend(&pts, arg, descend_fn);
	/* Something else, use the slow path */
	return -EAGAIN;

> > +/**
> > + * map_pages() - Install translation for an IOVA range
> > + * @domain: Domain to manipulate
> > + * @iova: IO virtual address to start
> > + * @paddr: Physical/Output address to start
> > + * @pgsize: Length of each page
> > + * @pgcount: Length of the range in pgsize units starting from @iova
> > + * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
> > + * @gfp: GFP flags for any memory allocations
> > + * @mapped: Total bytes successfully mapped
> > + *
> > + * The range starting at IOVA will have paddr installed into it. The caller
> > + * must specify a valid pgsize and pgcount to segment the range into
> > compatible
> > + * blocks.
> > + *
> > + * On error the caller will probably want to invoke unmap on the range from
> > iova
> > + * up to the amount indicated by @mapped to return the table back to an
> > + * unchanged state.
> > + *
> > + * Context: The caller must hold a write range lock that includes the whole
> > + * range.
> > + *
> > + * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that
> > were
> > + * mapped are added to @mapped, @mapped is not zerod first.
> 
> hmm seems drivers are not consistent on this, e.g. Intel and several
> others (virtio, rockchip. etc.) don't use addition. and there is no such
> guidance from iommu.h.

Yes. At least ARM64 does addition though.

> Existing callers e.g. iommu_map_nosync() initializes mmaped to 0,
> so this difference doesn't lead to observable problem so far. 

Yep

> But it may be good to unify drivers while at it.

As it doesn't cause any issue, I'm just going to leave it.. The new
implementation will consistently use the addition mode like ARM did
and that is convenient for the kunit as well.

> > +	/* Calculate target page size and level for the leaves */
> > +	if (pt_has_system_page_size(common) && pgsize == PAGE_SIZE &&
> > +	    pgcount == 1) {
> > +		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> > +		if (log2_mod(iova | paddr, PAGE_SHIFT))
> > +			return -ENXIO;
> > +		map.leaf_pgsize_lg2 = PAGE_SHIFT;
> > +		map.leaf_level = 0;
> > +		single_page = true;
> > +	} else {
> > +		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
> > +			pgsize_bitmap, range.va, range.last_va, paddr);
> > +		if (!map.leaf_pgsize_lg2)
> > +			return -ENXIO;
> > +		map.leaf_level =
> > +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
> > +	}
> > +
> > +	ret = check_map_range(iommu_table, &range, &map);
> > +	if (ret)
> > +		return ret;
> 
> single_page should aways pass the check then could skip it.

Even single_page needs this check, it checks if iova is with in range.

> > +	PT_WARN_ON(map.leaf_level > range.top_level);
> > +
> > +	do {
> > +		if (single_page) {
> > +			ret = pt_walk_range(&range, __map_single_page,
> > &map);
> > +			if (ret != -EAGAIN)
> > +				break;
> > +		}
> > +
> > +		if (map.leaf_level == range.top_level)
> > +			ret = pt_walk_range(&range, __map_range_leaf,
> > &map);
> > +		else
> > +			ret = pt_walk_range(&range, __map_range, &map);
> > +	} while (false);
> 
> what is the point of do...while(false) compared to 'goto'?

Didn't want to use goto for something other than an error exit

Let's put it in a function:

static int do_map(struct pt_range *range, bool single_page,
		  struct pt_iommu_map_args *map)
{
	if (single_page) {
		int ret;

		ret = pt_walk_range(range, __map_single_page, map);
		if (ret != -EAGAIN)
			return ret;
		/* EAGAIN falls through to the full path */
	}

	if (map->leaf_level == range->top_level)
		return pt_walk_range(range, __map_range_leaf, map);
	return pt_walk_range(range, __map_range, map);
}

> > +/**
> > + * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
> > + *
> > + * The IOMMU driver should implement these using
> > container_of(iommu_table) to
> > + * get to it's iommu_domain derived structure. All ops can be called in
> > atomic
> > + * contexts as they are buried under DMA API calls.
> > + */
> > +struct pt_iommu_flush_ops {
> 
> not sure it's appropriate to call it flush_ops. It's not purely about flush,
> e.g. @change_top requires the driver to actually change the top.

Hmm, at one point it did have flush related calls but now it is just
about change top..

I'll change it to pt_iommu_driver_ops

> > +	 * HW references to this domain with a new top address and
> > +	 * configuration. On return mappings placed in the new top must be
> > +	 * reachable by the HW.
> > +	 *
> > +	 * top_level encodes the level in IOMMU PT format, level 0 is the
> > +	 * smallest page size increasing from there. This has to be translated
> > +	 * to any HW specific format. During this call the new top will not be
> > +	 * visible to any other API.
> > +	 *
> > +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> > +	 * enabled.
> > +	 */
> > +	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t
> > top_paddr,
> > +			   unsigned int top_level);
> > +
> > +	/**
> > +	 * @get_top_lock: Return a lock to hold when changing the table top
> > +	 * @iommu_table: Table to operate on
> > +	 *
> 
> blank line


	/**
	 * @get_top_lock: lock to hold when changing the table top
	 * @iommu_table: Table to operate on
	 *
	 * Return a lock to hold when changing the table top page table from
	 * being stored in HW. The lock will be held prior to calling
	 * change_top() and released once the top is fully visible.
	 *
	 * Typically this would be a lock that protects the iommu_domain's
	 * attachment list.
	 *
	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
	 * enabled.
	 */

Thanks,
Jason

