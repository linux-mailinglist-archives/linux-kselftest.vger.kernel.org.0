Return-Path: <linux-kselftest+bounces-40333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C7B3C2C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB97B1CC0284
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07052221275;
	Fri, 29 Aug 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJ5IrU7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697819D093;
	Fri, 29 Aug 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493868; cv=fail; b=cT9XwRQrwjUZPljNlI/Z3qOQwgVhZJW81naWYTSu/nRVMdlV8cuXUSVRbrjm8f0lRiBn2tiDhSX0JzqZsTbgqDC9Wbk0u7QeqAq+RToBEJyeVfjHBowjGeCCaH+uPkQcPo+d+SwQ5gqdcLkecb0N4jYKkKRk+THPzC0/gfOU6/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493868; c=relaxed/simple;
	bh=k2OyVirnQSW6fEyghs7b2Fj9l5+9FpXJqwqdDx0wVPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gum6d5ES7OiFQKYMjn1Kg80wrFiDHqUIq3qNt++8L3ovu2s2eGbzgwxV/bRU/CSvjjA5jqmF0MwG1zEQeOt4//0vRBL+Nc48a+8wGhrGlhL66//FeHFIfgXX5AqwUE/E3pbTyKLWmfznYhjXRlp+vL2FALbdbMzD+P5GPCPgfHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJ5IrU7U; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ8vCe1J52Mc/B+dvRgtvljbLyEconSOFyMTPiuXPhOzdJH/9SgMkC7+oNolhNSXRr87lMivVxoEYFpZVnK4uQhhGxF9ANb0etSze7wbfblbm1MoVZuJViVB6rB9ppXxOvkaj4WIHydSVl0xumXzmIdJjHTZ6RUoH54VKk5HnZuRf2F5SROZlbFKLD4I3oG/MFDxJpor5HkKZtV80Y6+MCYXA/b4gZSQzURonIvleaYmo79bwRDKXKL/2Z5/Zsdbbmt0Hgoy3QrRqApYbV8ZYakYsfrrUAN+8v2RQ93R/YzlLmZXYg8kO0zxPA2juBdVjj1j1lKmBpgLASziBSplBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snGmcaGFkn3WryjCMCWPYQ/U/73KDYslO5ErVujmqyo=;
 b=q+QecuLkpB+VHafk+BHJx/64of03oiuOHizdgOWDsjDxKr8cvHGCGB9NmF6Acr6HrpIpxss3yYhbCLAe8Pgq54SIIvLT9KIZaGHccnjTtbp0cuMaOy4XhLsguVyerG9skEIKQDk1M1nrF9VG+Zhm8PicyWxWZU/Eo0V7UBirIXsDsDRBGxmvaBZmtEKTxFIutWEvczDBRWn9ZlgIi5DdoBCXmf1eszv1QslcKmhAitmk7m4Jf4ZAdZWka3qVPHNjpmm4cNhEmqkb6oLGsb951UOxx3CyHBRDe0mrangHfyQb6tv6dIZrv9Yr4LEKwO2gFj3r6+h+Y0f0dT4t00tVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snGmcaGFkn3WryjCMCWPYQ/U/73KDYslO5ErVujmqyo=;
 b=YJ5IrU7UVUYAhhyXhweK4rBRjaSoSW5PP1dBHU3URQhhpL4S7qGw1PgClAwID8VE3P39/ih4HEEoFev8lQ8pY3vBOilz7C81Ru6kRH8CE/+79RmJerk2LiOxTi/6m7c0k6b1J+AcYTek3wB27VgXmIxCBwasD3SRQiJoCoPNJWBJ8dUNvK5G8W4APY0QbHJ8lkgDkixZl7hDMq6S0BxVeGj8H1sOVXgAt0VT/FIjjPbrEmy6DF2388Qiouk5tGhuDHoREfantbOvE8wHHoC2Pyz6MXC5ErkypyyQmWNQHZ5gpbQd1/H1RlnWk6AXPtVPgpXNnYu3eesVCjNDEoa2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 18:57:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 18:57:40 +0000
Date: Fri, 29 Aug 2025 15:57:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
Subject: Re: [PATCH v4 02/15] genpt: Add Documentation/ files
Message-ID: <20250829185738.GF79520@nvidia.com>
References: <2-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <48f34379-f0aa-40fd-8578-3cf562880731@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f34379-f0aa-40fd-8578-3cf562880731@infradead.org>
X-ClientProxiedBy: DM5PR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:4:ad::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: a30abf04-a152-4182-06a6-08dde72ded83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k00Z0ZQwaF7Mby+y0PJs8ggd/w42LMS6GkN9JQpHwqoX9vuZp3wqCalYVnIu?=
 =?us-ascii?Q?eoMFPbguhlMTmywYnh/Fp5+N4/czgamBsMNtIlNtX9+aw+Mlfpv33xk56wpU?=
 =?us-ascii?Q?NB8hEHnRESbj3PCO1pETVrTIyQ58Y9IlwdSr4i9Tq5vfT9cP0gx6c0Zs6BSg?=
 =?us-ascii?Q?sQf5MMQM9CsaIU96+tucKtmr+o4rDJkiA92GY47zUHTGo4aG1gK6owoQ49dj?=
 =?us-ascii?Q?kSgLFHL/WzCDKBut5jodMvS2XTPHptc/6k3AmmPn20mQgAHGq7mS66/QK7Xy?=
 =?us-ascii?Q?dR9AzsBN9w2L8VBonRbCKycd8MQ1mmfgccpfGllMQ52C1DMNFsRcExdh0G6k?=
 =?us-ascii?Q?+gNsbfyX74003w33gjMb8VpeMwOfyebW0wfZV3/nRCUFbB6xFj6K/1YdW3rz?=
 =?us-ascii?Q?0vJwt52XBcAyF3f4J1Tm7l0shnkhBosL5ANe7psORAadeQoZTVqH3deoxwhz?=
 =?us-ascii?Q?hpUMuo/mKx1kaCFgrgCJqbNOgdhgSHN088LylZju/bh5GGj7WDFWxNhEr2hJ?=
 =?us-ascii?Q?YZuKpwwaBFRrka6sskSd6T0c4xQ/R71AyjsigmwQLDA3FCyFKzmA6aGbYfMC?=
 =?us-ascii?Q?t/y6Q3B+jCr1G6ggjAO/su/9T+B9yfggBF+tLzX2Yjg1QkVOzCrpVGN9Zck1?=
 =?us-ascii?Q?9EKN+vGfoHyx9tSrz0a3M018Yf0m9tGimSNp1u4tRikStNqek0c+Qrsc4FaB?=
 =?us-ascii?Q?iuhLMfQnhJ7UlKAMSjbNAeYITRTnwYbuQBpTf00z4QCPhrMkoK6Eo1PAjWz0?=
 =?us-ascii?Q?VoO6i5D//f14kPfVBH+ObezYvlhi8zCfeMXRJZ12a8/smVNBnx5U5VnLsBO+?=
 =?us-ascii?Q?SSwpRIur+ZqlcYQEHn1/hoV+oJeyZcYlS86z20xtEmo6joXabvP+dAA1LxDr?=
 =?us-ascii?Q?03RAqg7oexmBJ+L1AMAFjshdB6wrFzk5PbwJ7Uy7CF4V1vv1lpy7jUntqVYw?=
 =?us-ascii?Q?84Ez4Fh0sBCt/XXkrnu32qX9GXta1sK1UzjReUwbfaWVKYbM5+7+UXdZ60kB?=
 =?us-ascii?Q?iFH0Zvb60OcMjPuJ08SYASMyootgq/qL/Up401D6eYIXgpLKNrKyNVMh2jUQ?=
 =?us-ascii?Q?0ysKEWqFL3kF/RwPRTH5Ay2i+YxfaYo53hnkSdK2UCnwUUnYB1NCi/MiD08h?=
 =?us-ascii?Q?4nmArudh/e/0mvlsAXP50gN674b3r5wpuJq+s/9juJk6tz+7pxPl2sXXQNJg?=
 =?us-ascii?Q?U49RF3cusKaLUu4USh+NDfXKpwMhTZYA3Ugo2xmt5IMnYwZybviluAEp0NWL?=
 =?us-ascii?Q?mcnJhA1UigOB8vfj8DnJWd9HIY5JfP8CgSafdNzj+jPOWZkUXVIUXhDLBnti?=
 =?us-ascii?Q?evOuKdvjj5nmgugNN7rUjp/asdLviiEPJgBQ3buwdOHudRQZfZUahZIZ/dJ4?=
 =?us-ascii?Q?yRiiaLLJ0uoo8aFeWSK1Gj3vzdsEUtCqEIc92Wya1rf9wizK1JDTT7vmf8C1?=
 =?us-ascii?Q?33U2tVNAiJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxENOq57ZQXGlRgBb2PLTjCA45hWgSe6DBBZCBVg3nl2tl2eJ8rrhnetqVqH?=
 =?us-ascii?Q?N63sl9E1KhGcagADeOWDvWZtmU1LIEPlhsi5ZCbYqUc3izPNU/Co6GABNAZ+?=
 =?us-ascii?Q?FFncFgPUMeo6Qxk5sfjL1/k+oovna3lYtp73f16zMhSGcPYgXhn2vBbo1f8A?=
 =?us-ascii?Q?z8LIUdV/mY+1MwuibI4qRMvf/umNee7i0TvF6P/CiO+JmRNW5K7b4gI84i9h?=
 =?us-ascii?Q?41idWEoDGPgFEaZ/+PqWao6PX2X1aUprQoiRX7+6iQTDugvZsKWwNJFcSf6N?=
 =?us-ascii?Q?x5aDQjJHunufpRNdA9ijpz5KqgTYR+2ZUHuyIMy37eF04B+Ax54iaA5kvwlj?=
 =?us-ascii?Q?hy/xr+HFsoE913+jB8C4Ku1dD5AKoTQNQGQ4GnfPADIak3LPf5ua4mvASZDQ?=
 =?us-ascii?Q?g3BVGwOExaLRbtuRX+lSUiF1Zz6zhEd0xw/qIBpiQr64LZ4uQyOXwYP/3R8X?=
 =?us-ascii?Q?AEUVMm4p3++lpwVclPJFDxM+Oap7QkILKqINJKMyXLblQAbgzcEZUwO1Y+lb?=
 =?us-ascii?Q?08GvtIafY7onmfewEh6ZENe0MCGTqOV+ahz5PQM8jhyqb9d17g9LVl3ABIvN?=
 =?us-ascii?Q?kGX+YwVPn3pE+AH7ZOWHXmyqzsbhwfJuiGoFwYCAFQaBAGDpFUW88N/ttGI4?=
 =?us-ascii?Q?AMul+q5M4LO40Qchix7JeZEz882UrexByLeocyZilp3MyMTd+/v3UehHQWm0?=
 =?us-ascii?Q?wQ+h27rmJXPozU2Ix7KN5sk3hxbI/3ABZXoaY8yluOmsO95K30m6jwDuOkgT?=
 =?us-ascii?Q?I2C+WIbfA5MG6mS63XLUAVDms/CodzXFBQLBBJ4U5X9IjJct7VeYJnfPC4Oh?=
 =?us-ascii?Q?qmDAaUE0lpaoimB3ckdeMdeAhwGVpH1mNiwcQkthpMxnYLG6Lq6wVzPCJ8uI?=
 =?us-ascii?Q?wgnuyLBDYTCBxKY6g4+QFXVJdi0vdqqjl6jtKGwJecnT+ieMcpxKjZ2j2LMX?=
 =?us-ascii?Q?bCn27uGVTjrUQrxGyDCucfvIcOiv1tJ22V9eTOw9doAaVmlbMfnzy3CiLh7l?=
 =?us-ascii?Q?Frvw/4aqc67BZJ8WgBOtWVk6KzBUqUtTBVN+X/EK9xXbQC/kKZtCZtg7AFcB?=
 =?us-ascii?Q?oxD7dOBKjSiTL9kl1U4s0sXanoVkwRyJNGXbeRokUDzXBAG5pwUgv4pxGdy9?=
 =?us-ascii?Q?+ad8xduayRIrikskiqxReZ643pQxHDIqE9WUVDmEJiang3zUqE/iZu1aQ3VJ?=
 =?us-ascii?Q?30Y7D4wpis4h0sS2RoJBioW072hmOSp7yuH/ZpFnP3J1axhUyDIQ2Y/xY2Pn?=
 =?us-ascii?Q?mPLW7VnWz0XPrxbYG5M9uMoweZ4QkuIfkyz+upVUd5dV1GWfQrRty33+2PGt?=
 =?us-ascii?Q?5AlGLKHKv+js7tuhP2s5udjN9PgFLXhWW97eojSETbp0uShnlh5kYh+JYZ6W?=
 =?us-ascii?Q?LZDT/EoADo7gWbt4K8ga+ujT5BIild3KhLvard4z2hxOxa/G+rd1YakIT5MI?=
 =?us-ascii?Q?RODMaH2S0W2ykXOONPfX2YxMtZpWaZd08VjfO1Mr7Xij7Ls78nz8yIUIJQLB?=
 =?us-ascii?Q?F/2dJc2T0KxuFpFpI2V2b2QN2KuWlDuOE9JCqrucMz45QYFIQwf0KXKQGDsV?=
 =?us-ascii?Q?vyq7nOVJuxGNw1S+R1hEo4Zzaw8OaZEhiqNvDuxY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30abf04-a152-4182-06a6-08dde72ded83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:57:40.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpwOvl8yYvPRup+47SUiYTjFhrsZz+97skkYyMAyYxxghrdE5ntXGFHz7sSIMkY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

On Tue, Aug 26, 2025 at 06:07:15PM -0700, Randy Dunlap wrote:
> > +compilation unit. For something like iommu each format will be compiled into a
> > +per-format iommu operations kernel module.
> > +
> 
> I would s/iommu/IOMMU/g when it's used in a sentence as an acronym (i.e., not
> functions names, struct names, struct fields, file names, etc.).

Sure

> > +The implementation will further wrapper this in its own top level struct, such
> 
>                                            this???         top-level
> oh, maybe                          wrap this               top-level


The implementation will further wrap struct pt_common in its own top-level
struct, such as struct pt_iommu_amdv1.

 
Thanks!!
Jason

