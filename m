Return-Path: <linux-kselftest+bounces-24395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0CDA0C0F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D3B3A26D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE41C5499;
	Mon, 13 Jan 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXi9NCc6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD51C3F39;
	Mon, 13 Jan 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795207; cv=fail; b=BU48XATvTjW3/922VbzLDibJVUmWozGUxzg6i9m/FHs0EnMEdAwu5KSPJC0CvglDakzpImy1vwUA0uS5aOcAnW1IYy169GVYrkkAm0zb67dkhY+I+8d9+GB9IuRKR5tV443Rp4ztOvc+KZb/80No76w+DL0I1khyBnO6D48JJNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795207; c=relaxed/simple;
	bh=So/a5h0YZWgW93A1bUPWN14mbdjOszk30y1kxlse2J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=esDJaUfAFWxev9Fu+AS0r8FYQjTEgSf83yGKaG4FXQUOQuhC90SLiIs/vgFVgdwO5vaW4cJkuOhD+Kd+fY8pvRxT616XEgSuDb51jY8HU5i5fEyqIa7+fsIdcjmxdhHNS8Z34z04WDaCW539OL4GHn1M50/SXjggNzYgZy7Ius8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXi9NCc6; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5kOjYoyp1RI2tPpcYI7sH5me7Mmc39cyJbke1Ie7LkcC/qSMRXW8V/aRbENGWyzP628rWTqDmBK05x3/RX9lGCFu4/pPuTLsJ+DVmIntpCyKDCQB7FJHkpPGB86TNtGNWzoYNNIz+37NTz2iZ/m6PMiu9hRleto0xJI05sW88URccbvSx6qM2V5S29lVLI/zi8IEPzitixyf544BXvXvuGwVAcGe1xg6cqRfKwclkiG5je4th6tZ+7IIw8qpvnsteXadWhR46nuQ6NW5PrOsz3d4fCXwimdCa2tbqbs7lhBCrB4s5UImFm1DJInWJT3P/08BJ99+05m2vX7Ghwg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+fwWfH7oCvr0hX6NpoD3FKue+QYWaXbtFQH/dHQ1ns=;
 b=iqTpCYtEo1RyncwZPGeeGuUe38l8ZUbBAFxCgLVMjMv5r+14WnG8bxfzOTyEUlkzGhtA/GO1vdpEQuchTJdxx3yIwtvZVW0dn3pgjfNOMu7yt1TsRNYZm3ciiAqbcqApraqle+3x+a2W07UpW588vE6+cF5wgG9baqY2K9f97f/X6Sbj5J1HJalTsY4pNETK55M/vizmVe0jHT6D/uwFYo7DzlstOzxt/BXyImV09UGLf0cURe9A47HUySvOFysQEQcX8AuxKhae5ce0fwPN1rf8RI5HhiMTm6pOZeuOJBBDx3dF9iqFmTdLazZJfTOC/rZ85n5+XYTxDNzJ0ue+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+fwWfH7oCvr0hX6NpoD3FKue+QYWaXbtFQH/dHQ1ns=;
 b=QXi9NCc6UthFEXcTIR4SaEkQamau0/WMgTErfTHO9FyY51ZMePy2ihq8UP8eWtmONkMQ47MhfBMcEnJcLphuTUzFDtI7sO0wArOZ5CmnkSph9wy45Zuuib12JVUD7HyPHhDuNB70TsSb1DJdJDpThf+0LB/J0lox4jxIK3IJ2CaDSTB7t2z5WWS0wY0Ozms0gY+82QnAMpP55jwS6F9Yxeh31op0RdX4y/xFSGnpOuUUcj/315U1BLG5NHSwthkAwmvs4uHZTiWKj7l5+Ob3X3NSyQHL2j6NYp4JLAoLo4CfrPa80hkDEyJ79++IXAPcQz0MECBr47AWARL537xN4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:06:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:06:43 +0000
Date: Mon, 13 Jan 2025 15:06:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, kevin.tian@intel.com, corbet@lwn.net,
	oe-kbuild-all@lists.linux.dev, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250113190641.GQ5556@nvidia.com>
References: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
 <202501091822.4ocbIobQ-lkp@intel.com>
 <Z4Vi9raM/lOot/SQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Vi9raM/lOot/SQ@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:408:112::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 113abfac-cde4-4921-c7fe-08dd34056ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+G+sQzvnUO3h8R64JyONcEQc+7vNINQNJsFTwYk+kR69phaIak6Q8vSdSVH?=
 =?us-ascii?Q?2Kl2N1OYMC8uFlL3kMuBdmApA7Z4tYF6s29R5klaLhEd2XvHarDSC9GJ7Lwy?=
 =?us-ascii?Q?jpN+Y7K1YjIp6dWpMMWt9KRvvXa7Z1dIt7CGfrjSjX6G3mAXWCKIS4eBoQwt?=
 =?us-ascii?Q?F5hdJ6Y/HczKCnt+1k+6OHar0hyRyCHqT3JKRjeYdI3FdFxgy6twMIAS7hLd?=
 =?us-ascii?Q?cDSXDuw2XW8oA68zj5j4NYV6C8F5PRSnKEQ7NWG/ky88JOBkYhutMVFC+AAK?=
 =?us-ascii?Q?IoI0HhK9RpHEPw77T2hBbjJa20/vEa8j4WolVer/YW2l6Gf4fmWZfYxDeeOW?=
 =?us-ascii?Q?a2yOwIhmxrLzMh+mo7pJJSOn686pFp8wDYyh61EmE/0mEBWDFk5rmjJ0hRuA?=
 =?us-ascii?Q?jf6Tg0BW65kkIgEi2BhIAGKbdwGzS6rw9OND6e4MAhqy1KGnPLd2rSMIkNgt?=
 =?us-ascii?Q?53N9DmWvKorcnRI6dVCPEQypHgYmZFwMAEtmyV5pfsfZsT+RJea4VmfAiGDF?=
 =?us-ascii?Q?Ax0qAQkgVuvhObO+aeP52qVPRv7aClG8tJYiqT1gdvbUDOtjo2ZBXzdUKNbs?=
 =?us-ascii?Q?Hk74yS8hkQH/nRYYmlG6N+/fHOHtgYA9Cd8IzGDIwow5XoKZOtdg5gK4tA1y?=
 =?us-ascii?Q?T0VYhun7lxkZHQPkRtBHCdjLKYUI5iKAGtrktXMDBLRbFnAew6DlS9MU6gV1?=
 =?us-ascii?Q?3qBqzsjREa4Wk4lYWLs0xYnVo2PAcC1Hw7u+2DUBJzQIfh8pPyrOtoq51gKL?=
 =?us-ascii?Q?ke/BYKEhkw8gmcYXAuEOAhGwxgG9OSegQh8t5ZRWXJuXU0gzgHa18xw5e1Zx?=
 =?us-ascii?Q?d0wMS2EZvHEuS2JSW8tZT5Wcv1h1b69Yt+CopX3SzdkuboE9xN5Hx/Ou5dVz?=
 =?us-ascii?Q?C/A/joff3dBpWTJ2/eZ/hchV7t7GcdqBBtT65zdVaBSSAJlQaORxo0PpkZrs?=
 =?us-ascii?Q?jSc0PEJmtJ+0qwT22IgyRKCCGBk6kEEnu3GLjtJqyoKXVMLYR9MQKCM1z7fr?=
 =?us-ascii?Q?pw7rzHfJSwe/Pgjoe8zGzbaTiq/6RrxSnidUKXbwKQPm4s+aXPDnsDzOVRO0?=
 =?us-ascii?Q?RgIydQsYSbL5O/XiTC00cNbU0B+YGqGJ/X2UWFpi0KhPMoIGD+x0mo6NyA43?=
 =?us-ascii?Q?vyqu/6dGcKnvXPY6CTlpWPghno9Qx8Y7IxFGlADQu/uqjvG81Gjd2dNeDKJc?=
 =?us-ascii?Q?AHyaxRRU+9sggARwJfQNJYuQdmDpp9k3CZ7GjGT1rP+1SGg8Ntnvr/BiY8Th?=
 =?us-ascii?Q?nc4Mnb6iD90mRhQUscl2AFajsyNGxIHOJO8EGqOMGqWLajzDqctqo/BjfXQ8?=
 =?us-ascii?Q?6TCUVWVk9ydbMMFnHgLdTGDfZajINnrBrgawFuHiOIt/jGb33HI3cRG/HBVD?=
 =?us-ascii?Q?4lMDAyVrDqqca+n8FIVWPbQNu73r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXoGxBKS3ADsqe0xo2TQOfgvZJ7hATu0qq7ljTV8ntKdna/tdxjry6aUnzKF?=
 =?us-ascii?Q?q8Ff0sA7iEcAABTiBFFym9RhqckPb6+zfgDjunfGutO2b8PFUJ3oqDrJTrU2?=
 =?us-ascii?Q?ChaDgPybsah2eIpOEB3pVaqNsDLecCeHBxpMWO+aKgjJbb7l4HPctoZ7F1pE?=
 =?us-ascii?Q?GdFbGFvoaA7z8AtMauA5AUdgUzOhP/tOoDjl9FG0A3TXnbd+I0r+PNqo9sJt?=
 =?us-ascii?Q?1gdnlM4MDB6Iwm0jP3ccDjAvJy6w1sbB+8SgiTW7hMy+WT5+TG0bVJTs5Srq?=
 =?us-ascii?Q?yEHH/JChHZ2tfUJ3W9Y9la3HRqj88hP94YRLSBtXNblvFPBCpt0B5RuwLlg+?=
 =?us-ascii?Q?PQ2yIBiTt7li3CBrX9IF+clB6DeUOznBp38X89rlTqTkPbVHPe/A4UksYUIX?=
 =?us-ascii?Q?7GiOQ6VXayBSzHnBIOlgqFIz1ulCbUktXjf38Fxs4wJYp+BZjEbn5AzoxPNl?=
 =?us-ascii?Q?XVRDcPVhrdeGX22JqMumnqWhtxN/2cbQOEBl7Qror1XCrOCFeFQJ+pclNrSX?=
 =?us-ascii?Q?sBZObWwmjfqlZct+/F+XCtJmvCmvGEpTTvjnvD4KFslMFsbmV83AQ2/DbDhL?=
 =?us-ascii?Q?S8Se2j5Lu7jJVCpqORKTBFAEPFGd3fqLYiy/1kSfY0HxlLk6UpDZv9gB/fvo?=
 =?us-ascii?Q?XMwAwc4797gNaqB/ZlA8ud0RW+EqW1K8/phn/ktlUpt6DfJ3Fb4H3pHxoTza?=
 =?us-ascii?Q?EuTG+jV0wbI7f4f7ikbJulWggSn0Qi4aCO8hX5sbB0WZoQ6v+FvDcaXCL9Gz?=
 =?us-ascii?Q?WVmZWXzq5eGB9lOMw3YFpnhgJ0LmI9z5pzJecjjZX8itsC3/1e4M3YYlIeDS?=
 =?us-ascii?Q?ZrMhWUssGSEm9ofP4mPOjBxEPgXOMHJv4fYw9CWlev1PiPJZLrxTMJN8k7EQ?=
 =?us-ascii?Q?Wo1deR55SLCwMq1y0k0oh3+tbKzqzJiwgC1Lptp/UY3GRSzUFlesIfI4HSuk?=
 =?us-ascii?Q?ZMsbpTCbMtiL2OGOhyZN7YR1fT2zFsDuY1tU0PIbic0fVjCsQDEYWOK2igh9?=
 =?us-ascii?Q?iWISmf2z/FHvhHpDz/zFK5Wdvs3X54ZoFgFkGMi9gz6fBux91Q08biWyFjiH?=
 =?us-ascii?Q?484/UxTraseUq575BMMhCvp2njuaMzdMEGJjdqyXaB0M0b1J9DNam1pph/xq?=
 =?us-ascii?Q?yh6UEdBbF4yvPhIZ2r2T+E77nJlHIZHicR0+H4mPt3b3Wi8hqXRscjyd23ID?=
 =?us-ascii?Q?Uo7iNGSvKO3AE34PdHqn7vCAdRRZweO67hgQK4KFGIcgS3yVq1aT7zowhdWI?=
 =?us-ascii?Q?dDgVRB5bQteNrbwqsy0vICE2wRhLFJB1o3pwi2oBe2oA5eqUhUHtSK6CsqA2?=
 =?us-ascii?Q?1Y6FuKfBFq2rIxA/EeqyP4P6eae2C/eLkBM7rgwcuJv9d38UBRr6D2RqusXT?=
 =?us-ascii?Q?fSvUpFiGsaPMdYEr6lwvt9UqRBtwPhjhyr1UCGFoqwALgB552D4wJSh/1Wld?=
 =?us-ascii?Q?syXfCPcnTz7FYOH0JiI2WY86RtbUQPpcmlqgel4juBJD5a4isetCJDRqgckp?=
 =?us-ascii?Q?B0ipSV/sdhbBEAVomvenAX/YANyFv3FgV/wtLb78sACmq4MvawV+pkpu1w6a?=
 =?us-ascii?Q?lcZCRIQIDZnz7shhXCUALIUfsay9qzbXZzpW/JKP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113abfac-cde4-4921-c7fe-08dd34056ac7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:06:42.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW+GK5gC4E2derRh7zHwnl2HUH9fp/HgZDWxsEvGG0Oljgg4H+NiSRkL64BxmCUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

On Mon, Jan 13, 2025 at 11:01:10AM -0800, Nicolin Chen wrote:

> +/* This is basically iommu_vevent_arm_smmuv3 in u64 for conversion */
> +struct arm_vsmmu_evt {
> +	union {
> +		u64 evt[EVTQ_ENT_DWORDS];
> +		struct iommu_vevent_arm_smmuv3 uevt;
> +	};
> +};

This doesn't seem right, don't make unions like this

>  int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
>  {
> -	struct iommu_vevent_arm_smmuv3 vevt =
> -		*(struct iommu_vevent_arm_smmuv3 *)evt;

evt is clearly not a iommu_vevent_arm_smmuv3 since it has the wrong
endianess? It should stay in its own type.

struct struct iommu_vevent_arm_smmuv3 uevt;

uet.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) | FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
for (i = 1; i != EVTQ_ENT_DWORDS; i++)
    uet.evt[i] = cpu_to_le64(evt[i]);

Jason

