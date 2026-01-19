Return-Path: <linux-kselftest+bounces-49386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74410D3B490
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96FBA30268FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B432B989;
	Mon, 19 Jan 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3bfgiJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A791A285;
	Mon, 19 Jan 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844260; cv=fail; b=Kqit07Vwib40q8dAgmlnSkip9wQX87W6rDM68EcuL3A41Zor92sl7X59YVk6s7h4kKMAdQHROyvIxZmCh4LcegyfeMUAxYR3JQrWBPz4fLIPb8Wj9NTCLJOtuYPMRGl+zKbS99YOtY+Hahs/cQssKgSlOJqAehbzL+iVXEM/PgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844260; c=relaxed/simple;
	bh=A02AdKVaLzLYzglEVJalXsOA/4O1+vIvT1s+ankoDhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVqy2gRtGVanxzx3ZRDYbAUnSGXlH0vhDcczjSryBr9o5SkFRvFY4cHRje6c/IxvjcFBMr22zNYR6j4g6hdcMNoiRQzfs+yG2P0+j33JNTw4jAOiuRHT62gvi/qQ+sqch8N6nUTa9m0arG0EcFXqNrTjFBQ2v7mJ/lwpaO6c7+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3bfgiJO; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BudPy+K7FMCejI6if7h5wwAoCV5TdzQ/3v1Hmo3weG3ZmW82mHMz0cLlCwTuEcHC66S5gtyLWggiZuL5/ncImqPf/c6jcgTd5MkfUM6CKH/O+G4AaNJckw0b2nN7Mw5OLzAAOhFagMbJHr4AgXM/x9bKe7xyTOz8ggCtOEXZMeSEPtG/soCb3b+d1CGVPEJclAgoIowULggd3c1ERULcywNddra6zuch0ueUUYmS+OXQmRzuBzplMazqIxYKUSuk6YV+E57OsQ5dd5BopcBZT3TKFKL40h11nvzGi+F1QtojtCs5EYhwdFrF5OMF5Lunfrwix4+hRtXY1hB1UrAuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsXiTC1hbLOOThiShqIP3Wv16NQ2O0xU5wJqersJ8/c=;
 b=AD+KygydgbSRYy/O7QzVy7if1HRNiLFqIJw3qGZqSIg7HbaIn5rw3P0Rp4lNYGncKybCscSwo/bCiV49fydZmYfphR9TgPmSkjp+sbd2VNMTi+4veo58dzCtVSN6svDuC+kZBEOleM8XzVzaMw4aYJS03bvE0sQfoEpT8vveSz40BeAcA38AZEfymcY6QhK7VdwMzwRDHw2mBHwTi4xEHdbMYoUPE2QcLAFwNtZmxWPJnUcdKnLqcrXGKlFovrazOcCLH7nLtSlbGjAB3xUB6nmx10gXDN3RizmHRKtNWRs8qxEu4nQpitFA8nYHuRbWsgKx4FuVZhQOPOZ3amtksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsXiTC1hbLOOThiShqIP3Wv16NQ2O0xU5wJqersJ8/c=;
 b=d3bfgiJON4ZL0CQONaSINTxRGlc6ugzgrhky8BcDsRfWhpw3rKKDDlE+hvHT6EtbYYazp5wuH0KbMOJjuSvNSkJD4KG56CR4LbkM1ZaoURWk1ygjaLKyC7oXcSDtKrKBUzB0T8/NZsZO4x1SXVz3NIFTjPXlOyQiTV4sUrMKOChi8oEo3deDGR0ZQmtaXwy4f428wUFki3QDy11oiVHHc077bI3Mf9WmFQPceaMuxR3O2dbVX10TItEZwpCBg3drZ2ZoR1YwDJEFhmUXJKnL5bkjkYp9jj+x5Bi0lKAuBG2OHxKWYsXREUuf1b+anCCQ3SnmT04ukcd4y9pQAmgoGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 17:37:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:37:35 +0000
Date: Mon, 19 Jan 2026 13:37:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 07/15] iommupt: Add map_pages op
Message-ID: <20260119173734.GL1134360@nvidia.com>
References: <7-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <fc4f0354-4e6d-452d-abfb-fe24e53253a2@amd.com>
 <20260117154347.GF1134360@nvidia.com>
 <e0514ec6-b428-4367-9e0d-cfb53cc64379@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0514ec6-b428-4367-9e0d-cfb53cc64379@amd.com>
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 264006be-1240-43fc-5157-08de57816e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K55aPtj0C/ePzEePpxDV/PAz9iQbc6Bc7kGCgWtYZTSUBLOsyo4afdx9RURE?=
 =?us-ascii?Q?DqxacSYGnHxKxhsvGyv17wKEmYxOsJrsj+VaUel5hQNcxH6YPigM+zMHFSe+?=
 =?us-ascii?Q?Ddd4K4neMAyDbfKlcgiktMGsxYcQS2kvUHzSxXMro1P9ahi5N3JEJ4As22fB?=
 =?us-ascii?Q?EZyk8Wg9okHTNaRdjXQadTiPul7XEmK+G61QSNzVMm7SzzDyeGqIp4yoZDKi?=
 =?us-ascii?Q?NR1uNZ+lsAtRaTtITr4zAabQiNhOrSFM5S5WzOreES7eySPq0mFs74XK9qmX?=
 =?us-ascii?Q?WhHS9ExoA5BzxsvtXrGF/Y4qK47DE96BhJLEQ6fcxJoZpM2EkFEElSOL9cMY?=
 =?us-ascii?Q?0ASSKrVyhU9Mhf4QwBqYZWqG4lcz85FGaYnpwAiSLTCfp79kEyX6+XuaSD3K?=
 =?us-ascii?Q?RoRZjeXDHyyFBxr+Rr5hLt5Quxvb87wuD6q8wuk7qqn7m7NYE0Hjm6aCwnPt?=
 =?us-ascii?Q?L+YYT577LwLPCfNZ/qZbH1UCrfu5gyTpM4hfK/z6syNMSMaAiq34lpNUwqxK?=
 =?us-ascii?Q?s4L3d14jXDbwW2OK4SAcq7AtxaPV6e+xTeM5xztV7JAYlPgyN9Sqs4gW6DvT?=
 =?us-ascii?Q?BiFrWQDQL2kWRMUG6PVv97RyTo+FmRuou+3RuQd3Olox8L9qU2ZqqILEeCbV?=
 =?us-ascii?Q?BJyd4ChwnV3TDy0zGDjoHd3BnxwSPKRXWCB0bI+a0bTQcACJyfOdMLJm+GbF?=
 =?us-ascii?Q?4QL5TFT7k8/Qq1Q2JDYh6crqtpwAjgmg+5n/RydG+2yHh24rtlB8AlqLWm9T?=
 =?us-ascii?Q?9i5TAwnbl8rlEBGHWNB8S+t7GPKy+apL4kssraulosHOjaXDKiYT/fFihDwl?=
 =?us-ascii?Q?vi80XSQ+gukc/+hdMkbl4cIf5RNjo8loE4VYNYmpkxytXDe3hAWMY4fsG+92?=
 =?us-ascii?Q?IMLlnr5Is/1gG7J8f96gxDhSzz1HXQgKOHPMePxJM+W6Z6uWmUQNquKW1DGT?=
 =?us-ascii?Q?99Jh46UYFJNEcjLZYPLBiu14l46jVEptY35oxejUADMgbIGIa+v+ovwdI05X?=
 =?us-ascii?Q?ZMNtgC576M/bYfsZKEWJbTulGjlPpV4wTdZAaNF0j7b5/7lCcERimR0g57sP?=
 =?us-ascii?Q?fEhQenL6sElrQAyJutcnYnlUgVCuTm/AUX4L1/s+g4sUd66TQLcvq6dfmVBC?=
 =?us-ascii?Q?uFL4QzkihkAACIrf18K+IBRceXSuVPzGNduAFBIUo9VwBtLA7MI3E3gggT5y?=
 =?us-ascii?Q?Ru9HMxjIVf8fpABtYYi0PNxUn1xiUVa2ufZUGCYBGwa+uT6BY6uMpB2l+EDu?=
 =?us-ascii?Q?Ddy6SPaYPCr1t1Isof4jSc/nxCtokpuwbiYqQhq68IMfwHBBJTVY15L4fe+i?=
 =?us-ascii?Q?MddgYBazHwtb9RabBvkE1AxHw5T/MlGI9eV1wwuioxqBskdC/A3jB5JQSDVe?=
 =?us-ascii?Q?MKUvzg1DJ7hKLcIVfBXEcveQGFCaqpMPsxqOuEsLhxZlG92sZHYKWU0/L0TW?=
 =?us-ascii?Q?dym+L2ljjAupD4m7Ax2pwEXtLfhdaVlBkXA62DgLiTbMN2ZVBjNzwukq/OSh?=
 =?us-ascii?Q?5DA4O+S0zTGacfuks5GxH3nOzOfMokLJJVYh5x8L26GOubvM4F/+sD6YojwB?=
 =?us-ascii?Q?+Q7CBOroUgSFhC12BOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X55t8Se5g8uMGdKLXAsgC2TQ23a9C/AqDdWZUNlb2ffNjjj1G5zcbjrXYOuu?=
 =?us-ascii?Q?U44UmYPfMzwMCUgo7ClGrzkgT7bYc3MPmc64OjP1wk75d5kd4y/kx2uVIl0F?=
 =?us-ascii?Q?pcRhGJP2Jh4PGf9iSp+5IkEpwoZf+n1cRo7hFp16xaNe/kH3hn6xjdX4DKzN?=
 =?us-ascii?Q?wh+2Qu0VwW5HXSN18ss80TjbQVF1KI6WF0khzor1rEBVwV0oApUjDs9dAoJL?=
 =?us-ascii?Q?KEIj3WW7MGbqKCENABPnZ/+i/zkuU+8J0KhdtzdOfanMRFdByjyyidQB/wm7?=
 =?us-ascii?Q?jsR+1ZmZztxMLj0K6SAXR9rzUROyFDjisHvsGijIMdFEsxXb0tpjkTqoaAfm?=
 =?us-ascii?Q?+7juyp3CVL6j35piO4edp2ULHIPn2FD9UKuL0wiUfD9PwCWQHFDKp7S92Ho7?=
 =?us-ascii?Q?gLeoNBqzTh/Ol5P2a4AdwGG0eCuenokp1+6fRiFkiH+lncjzrJba3UR6sxmX?=
 =?us-ascii?Q?PapX5GD/f18H/8yLzb2jlBskJWInA4Gob2avEK+Vnf0ggyx43CuNfXvrpg1T?=
 =?us-ascii?Q?Gzo0zziDxE46SD7rJHoa+pWZOpY8r1elhJN221HgoZZHmJ+lZbiY0m6SfMOt?=
 =?us-ascii?Q?Ci6FeCwGQziJVqjX7Wm0HDwPcejid4K7uRYLA4m1MtePilTEV8lhMVKqRjIC?=
 =?us-ascii?Q?zKnGkRoXEXyJkMJiOptixEA0uE1MBX5Zg9f3ZPEQEMQzBFK04gIiUbgFYYk5?=
 =?us-ascii?Q?YH1usPQHqi0QKDgcpyqMr/MZabqt47wrBGKsqrF7UdshRzdhCpGzh1meAnis?=
 =?us-ascii?Q?CpGiL1Ln/J9YhaLZTmUJUNh+yef0FXRTMdrcqmheekKqqU1Vw7UWZiJEY5L6?=
 =?us-ascii?Q?sIdk4yBKQcgcFmmlCHVqutQCL20FhbNR51/UKTgbYhdpPKU2XJ5X65VA0C4J?=
 =?us-ascii?Q?730Is0PwzxmHG8Gl0JrGReKx5EDhLOk79MbmQTS8PZrb3tvetfw+dGbQphlm?=
 =?us-ascii?Q?Kk3ReR71Kl9PCjg+onw6mEQZv7J9JrqwjCHYBokgKzX6E9nyhDZDVd3mK1td?=
 =?us-ascii?Q?0KOMUe6UDctpMoCvwzFYAD1s84aqMKOHnrpTtpMCJFGSQRZ4epLuog+qp3eT?=
 =?us-ascii?Q?LEFUPYl0BPFh1waLIgCvJZCdBsqHrH2uosnZrWxHebTZx3Uw00HtUKpWAcN3?=
 =?us-ascii?Q?7mbgbFqVvLKNlpBOPQDN1Z/kz4Fm8HFSUWNbk/jZsm5ej/l4rZ+EhM3DvAVr?=
 =?us-ascii?Q?5bpQtvQP6JzlkygSkqXOUSXoKG8MdvddyqJFoQBfWxE20THbTkyyMtqPjB6p?=
 =?us-ascii?Q?HWwJhZS6QdLutRuh3yDHxFoK6NpOWroNrPF+KFtLmtjDZvcmIzjqO2PD4q72?=
 =?us-ascii?Q?GXJOyjgjMo/38YdH7hxth6tLqyuCKDKZwABkstMnTDuVpq8Zdh+oxKxnmjOA?=
 =?us-ascii?Q?cweR65W9trTFCw2V6+E3EsPfb92kEzOII1l418Yzd1qm2F+Or9YWMm4ZQtFf?=
 =?us-ascii?Q?2Hr4hjE/0XjJkVbwWXoYvM7eGBnBtXxxKF0JLzeCFpOg2ORh9NqJXQz9VCwb?=
 =?us-ascii?Q?AOBC7skG+ELXx1eTptcsSsX1t3i4Ph/Hy9byNsk4aBWiwSF7MspHxWFMxFIW?=
 =?us-ascii?Q?Gr+cPYO6B4ZXRMPquTAP+0ADRD0i3NH/Dih5D2LWiRUouLU4lD/P7L38WKDB?=
 =?us-ascii?Q?jdM/lXZNe+CsOGAsceowtx1Isz6KHYpIvv5xvdJQdkVosj80o9a6zJeS/Axx?=
 =?us-ascii?Q?6CQbku73UqY+tx6HVMw36gZnAkr43LKmJVa/GntCOprCrS7F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264006be-1240-43fc-5157-08de57816e7f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:37:35.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ/d8/ctbluJ7E45o3dXWN9/eR5IdT3N53q14M/OMmDQ3t1GJvjLJUbCSv6ugeLI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030

On Mon, Jan 19, 2026 at 12:00:47PM +1100, Alexey Kardashevskiy wrote:
> On 18/1/26 02:43, Jason Gunthorpe wrote:
> > On Sat, Jan 17, 2026 at 03:54:52PM +1100, Alexey Kardashevskiy wrote:
> > 
> > > I am trying this with TEE-IO on AMD SEV and hitting problems.
> > 
> > My understanding is that if you want to use SEV today you also have to
> > use the kernel command line parameter to force 4k IOMMU pages?
> 
> No, not only 4K. I do not enforce any page size by default so it is
> "everything but 512G", only when the device is "accepted" - I unmap
> everything in QEMU, "accept" the device, then map everything again
> but this time IOMMU uses the (4K|2M) pagemask and takes RMP entry
> sizes into account.

I mean, I'm telling you how things work in upstream right now. If you
want this to work you set the 4k only cmdline option and it
works. None of what you are describing is upstream. Upstream does not
support > 4K IOPTEs if RMP is used.

> > > Now, from time to time the guest will share 4K pages which makes the
> > > host OS smash NPT's 2MB PDEs to 4K PTEs, and 2M RMP entries to 4K
> > > RMP entries, and since the IOMMU performs RMP checks - IOMMU PDEs
> > > have to use the same granularity as NPT and RMP.
> > 
> > IMHO this is a bad hardware choice, it is going to make some very
> > troublesome software, so sigh.
> 
> afaik the Other OS is still not using 2MB pages (or does but not much?) and runs on the same hw :)
> 
> Sure we can force some rules in Linux to make the sw simpler though.

I mean that the HW requires multiple SW controlled tables to all be
sizes must be matched. Instead the HW should read all the tables and
compute the appropriate smallest size automatically.

> > Doing it at mapping time doesn't seem right to me, AFAICT the RMP can
> > change dynamically whenever the guest decides to change the
> > private/shared status of memory?
> 
> The guest requests page state conversion which makes KVM change RMPs
> and potentially smash huge pages, the guest only (in)validates the
> RMP entry but does not change ASID+GPA+otherbits, the host does. But
> yeah a race is possible here.

It is not even a "race", it is just something the VMM has to deal with
whenever the RMP changes.

> > My expectation for AMD was that the VMM would be monitoring the RMP
> > granularity and use cut or "increase/decrease page size" through
> > iommupt to adjust the S2 mapping so it works with these RMP
> > limitations.
> > 
> > Those don't fully exist yet, but they are in the plans.
> 
> I remember the talks about hitless smashing but in case of RMPs atomic xchg is not enough (we have a HW engine for that).

I don't think you need hitless here, if the guest is doing
encrpyed/decrypted conversions then it can be expected to not do DMA
at the same time, or at least it is OK if DMA during this period
fails.

So long as the VMM gets a chance to fix the iommu before the guest
understands the RMP change is completed it would be OK.

I'm assuming there is a VMM call involved here?

> > It assumes that the VMM is continually aware of what all the RMP PTEs
> > look like and when they are changing so it can make the required
> > adjustments.
> > 
> > The flow would be some thing like..
> >   1) Create an IOAS
> >   2) Create a HWPT. If there is some known upper bound on RMP/etc page
> >      size then limit the HWPT page size to the upper bound
> >   3) Map stuff into the ioas
> >   4) Build the RMP/etc and map ranges of page granularity
> >   5) Call iommufd to adjust the page size within ranges
> 
> Say, I hotplug a device into a VM with a mix of 4K and 2M RMPs. QEMU
> will ask iommufd to map everything (and that would be 2M/1G), should
> then QEMU ask KVM to walk through ranges and call iommufd directly
> to make IO PDEs/PTEs match RMPs?

Yes, assuming it isn't already tracking it on its own.

> I mean, I have to do the KVM->iommufd part anyway when 2M->4K
> smashing happens in runtime but the initial mapping could be simpler
> if iommufd could check RMP.

Yeah, but then we have to implement two completely different
flows. You can't do without the above since you have to deal with
dynamic changes to the RMP by the guest.

Making it so map can happen right the first time is an
optimization. Lets get the basics and then think about optimising. I
think optimizing hot plug is not important, nor do I know how good an
optimization this would even be.

> For the time being I do bypass IOMMU and make KVM call another FW+HW DMA engine to smash IOPDEs.

I don't even want to know what that means :\ You can't change the
IOMMU page tables owned by linux from FW or you are creating bugs.
 
> ps. I am still curious about:
> 
> > btw just realized - does the code check that the folio_size
> > matches IO pagesize? Or batch_to_domain() is expected to start a
> > new batch if the next page size is not the same as previous? With
> > THP, we can have a mix of page sizes"

The batch has a linear chunk of consecutive physical addreses. It has
nothing to do with folios. The batch can start and end on any physical
address so long as all addresses within the range are contiguously
mapped.

The iommu mapping logic accept contiguous physical ranges and breaks
them back down into IOPTEs. There is no direct relationship between
folio size and IOPTE construction.

For example the iommufd selftest often has a scenario where it lucks
into maybe 16k of consecutive PFNs because that is just what the MM
does on a fresh boot. Even though they are actually 4k folios they
will be mapped into AMDv1's 16k IOPTE encoding.

Jason

