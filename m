Return-Path: <linux-kselftest+bounces-21096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF809B6369
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1EA281B4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C2D1E9065;
	Wed, 30 Oct 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfHs1BcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55964D8A7;
	Wed, 30 Oct 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292839; cv=fail; b=Rs73pL9ecbCuvAWF4bfsWSMgNn6Doip9g6fLi3SHgwvyH8Et9BetU4QuZQY87CktPDwmLJOAkuNN8GKihE/0B+RooQhdGliJ5Btn7KE3Cjh2wRW+z8sbHwOxargbfpSjqHNemvoZWsG5OFPR2YEj6stlWZKWNSRsX3KIPgGuMT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292839; c=relaxed/simple;
	bh=rselkik4rAkkzHIYbnzx4hIEpwEgnvyqpHNL72KfueQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u6+/0z60aSYoxLgyoG007u44Js0oK87rcJAT0dOKB80EPobYq+B9NqhxnoptiCky0RoYrw9+87kWZzt/LLH8dcqDwPD0XXBqvm2SwiMEK+OzY793MuxsCcW3zhYgQpzGWqz/VRbphjurnIgXL9IbLPRwX8ANCCb8cLs8btL2UtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VfHs1BcU; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPjxDcD4Z12YZhqpKV2feghEiFIT6Asql1v/v4FuG+PyI0D7cGDblLvHcanhFIoYPs4h2sxGxJ/utIugOab2Q9F5kEHc0FNfmBD2LbM+ADvpNdvD4khQGKAp9yacQpemtLQvujfMAIcbhfbZ2M2SAWCXevNia2wIgLc59HuAXHVPpawPwJlBFp0CHr1axuiuIsdHKfaM0Gx5SLqEt9hyHki1pek/jOWslOt6OBUX2s1xrtCm8iwHkeQ4192FL19SUFzcryLzNbp6T9rQyeOb077qzIR2q0jVasj62d388gll1eYJzSeXmTPTDg1w1/vIcJMQHi0VP2I1DvvN6LSH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7jMS/Sye2J6foGcBIQ+sMuHOn11xR2LQVxRHlUx4PE=;
 b=xaRDnoKqCmkSgF06OqHwpwSi43iNuQblVBmuJPTEHvFgJZ3k4CBUZglfhDqrAd/lAQXnqp6a1/XXGdajg2BPsbL08EqTl5y2mDVo03PUXRBbYyOw+0yji+6pIIP/epN9aElKb40vRbmiFPgf1j2sWhV/E6+8LYpeCZvOHuEa1S/OLZdrfTQvEIig+AaK/uqWrcYtUpOdKYEwxdI9oo6T0wrAlh/oC8mLYzqJA4VQ7s4W7f6CEVaSxxW5RF23/vbIdoMpGOQWeTfzlSOoqrKjGJT5GdK3XUSYk2yGypxrWtMPhtU8umDD+t+xQKcbrhVlhzuWvut5f+Ab6cv1eVgB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7jMS/Sye2J6foGcBIQ+sMuHOn11xR2LQVxRHlUx4PE=;
 b=VfHs1BcU8xut1LBxioNdeRZJw6/89C1t33E3zZYost0FGMv7KrYFkesLNYiLGs+8hlQe2b82uVHjmq5ADom48jrhTLBDrurvLcLOkcwsaeT3Hs1TD930cLA04ZpOvm47tktF5I1CoPN7pPN5xLnDPpqqH3eygfqm3QfSzLsODfkaaEEoetq4DXDnbWF+NhK7Ddlc0FXqpoNxTeYJfGz3yUUn8cmIAcN/UpsH+PtwUYj0G97Ylas/WN+vznnWne3ZcZKgIJ16LeXe01YEWbz9e8gNW0A6EC+9VRpOvsDhe0Rx9Ueo58cGLzSheH6gBDpo+lI6GwV88BYCNEByhKkQ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:53:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 12:53:50 +0000
Date: Wed, 30 Oct 2024 09:53:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Message-ID: <20241030125349.GE6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
 <20241029144907.GB209124@nvidia.com>
 <ZyEKvcpgUsS1nCEg@Asurada-Nvidia>
 <20241029185558.GZ6956@nvidia.com>
 <ZyGwemWwixBA+VIh@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyGwemWwixBA+VIh@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0688.namprd03.prod.outlook.com
 (2603:10b6:408:10e::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: fd187a9b-7c16-4479-98cd-08dcf8e1e6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xBh4nWzVJp+WwOZDSWroGb9TvPGFUuBr2qHrjXjL/UR4iSaTEv96eregCza7?=
 =?us-ascii?Q?5EasNADPcgwnHezZCpI6CYv8q/sPTSr1a+u80RS96bApu8TFVh0+DD1aQXIO?=
 =?us-ascii?Q?cE75yVixq6l5a6haDajR9db8cIJDPWoY6Tct1Ok4WObh7H6zxpiURZw9xgeh?=
 =?us-ascii?Q?1az9TTJPEOz/nNi6O302pNQBoMfs/3FJWkdcgooD39Fg5HXe6KBTymzFqdK9?=
 =?us-ascii?Q?D5Q8CF4s1n73miE6692fqLGTxiY+t53tdyZ930J4nKq7QVW7VSiomF6gqPuL?=
 =?us-ascii?Q?uaOgLw3HFwwfCN9JE7n2WrjTyTtteUTJ1o7636JUv7kkPr+SWH6D7Kr6DSxA?=
 =?us-ascii?Q?HG/GRObGFKjUBNlHmCZDvk+9Kzvn8QomyBvh8CwEv6yQQr6/1dI5GtCJ8YPL?=
 =?us-ascii?Q?VOUqt588BbtpuUHrBLmysNPFkTWgB8QdqeDxKh//VgLIyqDbRAS7EgWIPrrO?=
 =?us-ascii?Q?2QzZE47XGuUyJRJttfBjYQ+2zK0e4cFn8ax4M272T3jLQzgDUL8fVonQUspX?=
 =?us-ascii?Q?qogSFeP8kF6UQD0c2ktbhsCkLTvBoOyD1oFWpQCUtMiHiKsKHkgkiPlhpD/D?=
 =?us-ascii?Q?qlcFpIPEiSpzNqRUpYU64ImfJxVw6GYcwjadEXjinQXKTMitziGfCJgo2uDl?=
 =?us-ascii?Q?jf28fDGHJCf5yrYsLeXtKXRNORBM52wor62KYSv70ogpo1mu3Xs5c5JdTvX+?=
 =?us-ascii?Q?SpaYezLvop7D6TpjbtKrRaZkDij0bv0+bFf4Q+kpcIjKSIUTdi95csmfOdCs?=
 =?us-ascii?Q?ISNR0KhTbBOvuhAEIiFw1Dwm05HltW5QmtQS/FDSY7C7rnML6r34thcVqU3Q?=
 =?us-ascii?Q?K0JFicRL81ncJIczP7hO2MKYyUbPHqMVnHxR05XQSeD0IdTYPvBMQORiSkXv?=
 =?us-ascii?Q?6vFTqhepF4Aap6k2vo8gH90Vv/jmffo8AuR87WJuTUTndgG3cqvmh8MtXbgH?=
 =?us-ascii?Q?D1FibdxRzWSsmY+khlsRUgjUxOoK+zkB/uPlgBxR92m77bJ1hfROVbb6aX3g?=
 =?us-ascii?Q?ziYr/xTnPCVaCq5uYibk++HvYSOrZk419zGGLNpBKYY6o9+ukeuop7dETePf?=
 =?us-ascii?Q?X4H7G4L4nuiVAoPmP1ObhvyF1V8mXNojNQC6aGs+dyC65wCxbK11iaQ+j+Ya?=
 =?us-ascii?Q?oUhChjEOYL7OlMoRFEI/NfykUpX7muAV3JzQtOrbgIuhuvmUloKLgZts4Agx?=
 =?us-ascii?Q?BXq2cq907HlrclvC7NJeGwGrvDM0ZE798OcOD//amoK27EKJAnJrXa3ydM2Q?=
 =?us-ascii?Q?NMrKL5elAf1nvT0EUO8C4dGRdhcJf4JZV9tuaQSyEFCjEA9MtZN/xmgInI/W?=
 =?us-ascii?Q?rAcOk7NOdeovf/q+PySQDoPn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z2oRU32Qrsg+jRUquULAjhUSU5zC80L6UaYcRxQVZvcfiFWaQij0Ni6mbm4e?=
 =?us-ascii?Q?ckK2dnlKvRdto2oZgkBZUtzd1w25C6+dJWJEeOZbFq4aXw4L1ptFp726Pl81?=
 =?us-ascii?Q?fmI8oMp3mmE/coMSoMTMNpXwUJbDFwWSUmRzbgSK8STaHpj3riDo/10ZPVUv?=
 =?us-ascii?Q?TlnGdoey2KOFWXLSRPnL14Bj0M814aSAOFc673xCDAhqkYpY9dbAr/8uZr71?=
 =?us-ascii?Q?AyTyXkqYo8DeZriTa+H/l2iVEXQQobgkCdP0RsXJj4+SMmbTpwPeSYC3tTuP?=
 =?us-ascii?Q?mz5dKnjqMpTLwIUf4fH7fH5SXTcwj4+bvVqwvni5WbmkleZjjC4BJM14qsoH?=
 =?us-ascii?Q?07nZnc1GCLASFS0cCsWBk2gOnkVlyzm0Te0XIOcC/h3YMgehPVeSx1ugqWnB?=
 =?us-ascii?Q?XDtzjLNsc6mQyIM14lsJijQHmOH3iNUMOuAoPLgrt2PvUKKUXtUFji52aR6f?=
 =?us-ascii?Q?JDAoaXPYYH3ao9+UEjcQEtPcvm+6rs2a7DoSuuWTF9EPmqXwQW5tPHntLcp4?=
 =?us-ascii?Q?/pO9ReO0oMDf6UTgixaiUd3b0zRRYSxJPZJB3rr/BpoksIxAMou8xfftbdPk?=
 =?us-ascii?Q?2QbRdyJWy2UYWeSTByFUDxlSYlJf3ojZriO27XQ/ILOvwBCplmQvJn/VRITB?=
 =?us-ascii?Q?3hhr9A8/xzelzjcOel2dbkfb2Wb/IvPhNApujJFlAOc2Ac456oIsMFWffPo+?=
 =?us-ascii?Q?vrNr+0KivtciM/m3WU25aEqpsoyxuJzDvNPNshvRyR+S+8ebYBsJNOhJziwj?=
 =?us-ascii?Q?/2DWwLF/wW0/gbxZhKPiMLApfaXHcKPIkijbvDRlgJVbT0Ap+s6icwdcFLMD?=
 =?us-ascii?Q?UUd+OAX3CNWRemISDlJAk9dd+T6KcdW5E432UByiyR2sJ70c/4V7kYPownws?=
 =?us-ascii?Q?DVG2ZzBQtJl48dWKqmy0igh9b/KUFNUm2ovVAahiDIH68JAOYwlKTEsL0v06?=
 =?us-ascii?Q?PiiOz44tZk5KK7AQWRzuqYK4Llth7IlccRVDoYS4H7iBdEYEgJwIyDJTozow?=
 =?us-ascii?Q?62ssz2a+itxzGUN/8DSsBFkdOZEtZ5E6sgfkgulj8CNkdGw2VYvrPOtp/o4P?=
 =?us-ascii?Q?+Y3G+xeTyMiAd79KLVGHRkDG0/gmSYT1wmn1Q+E2v4rWppNMx/QCa4it8tRs?=
 =?us-ascii?Q?RslL2VSHBAAci8bU1WODUkbeiy6C2uY1t6wF+IyabQGBRSLP6O3R2wKmw0/J?=
 =?us-ascii?Q?qiA/XsnI7nOUMlGg585s99lSgAs3fFA66G0hu4RkFZfm3YOAlYEnWU+NmCTk?=
 =?us-ascii?Q?Ms/QMKL/w8Vqevsirwg9srhnPELhKDeDvKLaQ4LWjVPBpFZq97SfF+r70W3E?=
 =?us-ascii?Q?xaIgzSjzeTmHnh9Wz/uXpG1Al6nlSfB8Esh3hOmurwukW9li8ICuChXOv45N?=
 =?us-ascii?Q?hvAaMGIVohbXgrSehTCpUoq4898JZxnDDic8uEz+Bh7KCt1T8sP0111fppAJ?=
 =?us-ascii?Q?1qgCgfVTr87/WnWwdt3wLVm7I4rN8akM8EbEpUWfnUTOiZ5llO0nR4tmhzTq?=
 =?us-ascii?Q?2NMDE8CfEagZmGODUJDnOd7fbB4V9UEQfWYoOZ+zJVNDpjXrTBTDh6thSaIb?=
 =?us-ascii?Q?SgAgaCkTBzAwQ/c2CJD+rHY6qGe/7d2Zwv4ohwSg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd187a9b-7c16-4479-98cd-08dcf8e1e6dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:53:50.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+rIB0nIXIdG0L0Q4CT/TmXJMAbzddawMBdpkMD8+ig2kwKmCVjXR0GDJOi6PgN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

On Tue, Oct 29, 2024 at 09:05:14PM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 03:55:58PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 29, 2024 at 09:18:05AM -0700, Nicolin Chen wrote:
> > > I think we'd need the same change in iommufd_object_abort() too.
> > 
> > Makes sense
> 
> I found xa_cmpxchg() does xas_result to its returning value, which
> turns XA_ZERO_ENTRY into NULL failing our intended verifications.

Oh.. that is annoying, you can't actually tell if cmpxchg failed :\
NULL means success if it was XA_ZERO_ENTRY and failure of it was not
populated! Hmm, I might ask Matthew about this

Your version looks OK

Jason

