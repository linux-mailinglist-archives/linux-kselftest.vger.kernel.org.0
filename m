Return-Path: <linux-kselftest+bounces-21645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A636C9C0E13
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189B3B22E21
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BB2170AB;
	Thu,  7 Nov 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mNmKIlHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790438DC8;
	Thu,  7 Nov 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005442; cv=fail; b=bdaeIG7lBwUIW3uBWUIT3mQ+6gq0Y9oUbdmS6KiPpvkmzAOmPcVxIaVKeQP9HXe6VRFQqKbwpGf8Wb1omNbwe6Wg+8TKpkNBm+7oPI+ias0R8bnB93CvbeCjLoWxYouesv+FV3yrW3+KdSVLyf04HFODtqz3BMLq39A5bIxvcWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005442; c=relaxed/simple;
	bh=/t8euTIKhU0NyxZ2BAIKlBxzl0J46UFuFEUN3s4caVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KGl7AXp8uBQaRFHfSsuMmlWETGce9JZKwHP2m6ZVuWvwTGcE4wmclzECCVQOf4Cf7ST2sWIqXmJkPbcc9nYfMKSdQHaZSpKU7iQBAHH3rK3SrRFwY8HHqpKxA12ag1Of0w/4joIgbnK11/yXCz9ZrcGBRQDBLpqxR0t1XhNpOn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mNmKIlHT; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba+VQEe889LyjZK0tTcnyRhexUSH8dNpBOUKCMtjpxYs+/ccnBpQktm36qLZNOKltcfBzqBIbfHe48R404ShD147ipmWWSvcbYQyqwSAsOjGvZeLeNBmxzZT00miek7GJ+nhPH/eVwLEAqI64YzDViTyJniLfaUiwAIteo5pGE4pXKW4wfKCuavaVQF82OLBfRFyzPHNTVwl7EL5FBk9+pq/m+8bcauhv/OcYRdLELEMFakkR5Rtisqd8lVp47sPk7DS6Yo2HoZrycq8LjEqHIGBDBBnH+8FL7yUplYAJx/Y9Lq15pqmw9J+qpyhG57lm6cLOenwb3iiacIT2Is5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUowkb0YkvBLEjJxxTJcCu2BuvVCbtLteeNwbouBGM0=;
 b=ZWNb60qGIvKVnDJIqk0/pCWWALCucI+KWIhkKh1ruZyxw5kWQCY8iPmO62k5e9vde7lpSxJrp4coBNhhRijmu8Ml/FSf8eTxPK6elQMlugyR2s/mh1aE7ZQrJu42PzyOvIoyMie8EQfgJ6VF7BzNWSWSDcnhDgMRYnoQdkuTkCku2uf+9Iff8nnRf5Ww/S6+nqxMA4aUE1K0UdTxeCmBSHf3MFIjKU6/NgXYk3yBPZQ7ICI7X1s0wOy6CjluwRMVcMA/FXYOKD+Gk58hQtnpJbXX57V1pWkZ/P2qy/T6QxBp/DjMUtqXTFYhVaswSecxmstAPRVy1lNPFZZnKZrzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUowkb0YkvBLEjJxxTJcCu2BuvVCbtLteeNwbouBGM0=;
 b=mNmKIlHTCOMj7KTRmEgq9qqgfmHBYPkb1AkJiGyzmrjJNn2YbGRrDidR6AXr9Iqj/QL2znfDPSIq4s+54HgWtGgLJEnFFy2GNy0tMrPjpnREddvBqIITOFFdFvp6CAGoRukEDuwc6hQUxL6oTdN1QB7w1ilWR0KnzVVoaksFN5SSKwlc4bGMRADo2tZBDC+pGaNXY5c2BCaaM8mt4oPwfHpRklHYQ1vyoa22OtfkKH4mArrEm0qtEWsJs/ErxQPYqt60nnZypvL1aMBJJxtQbZfEz2HqK2poaigR8/F7lZgnJ0Gr2+4Rv25YND7epNEgXVUW1fZS+pXbDsjuclgDjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 18:50:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 18:50:37 +0000
Date: Thu, 7 Nov 2024 14:50:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
	corbet@lwn.net, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
	shuah@kernel.org, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241107185036.GC539304@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
 <aeb88b6b-9989-4e1a-824c-757ffdbfbca7@amd.com>
 <Zyzra/E3ARtE/Yyx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyzra/E3ARtE/Yyx@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:408:fb::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fb8d25-e565-4bc0-be35-08dcff5d1193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JgPINvwhML1jsvFVHUKygoLsd3zfXkpi60Ivh704YXLsWpIZ3ehiZZVlMi1w?=
 =?us-ascii?Q?42uaPlwOmMfJ6dsIMc6L9D6lER4HdGAiIzkfo64/0QZlnAw1regIv+mTUuS2?=
 =?us-ascii?Q?nEq7WgZ3dTyMnZQXN726mAyMvhbipGdMIN6XKsBsZNa8ieGI3prqEDf3s9Nd?=
 =?us-ascii?Q?DOupF4CskLvkYmALpnBIttlRIYXXeStTFVbbeF7ydLCM0+y+gLZnyaXW6uOZ?=
 =?us-ascii?Q?Sv5o0dll89uZO4eGb6U3NdAC2sCOWw4jrEwxai2faLrS9TZ9Cu9TvCFqAr9S?=
 =?us-ascii?Q?Xdgt+/i6Izut3TxaVK9V47DG+EibF18ck3sEWbiVGw0pRKy+i4uOhvw54uJd?=
 =?us-ascii?Q?51VTMehgWrNStaKz+eQ2ihlOyX0HRr5+PiOMd5Cd9J6lZx4N/ZKCVOlPJQ0D?=
 =?us-ascii?Q?bhiIfFHthhSFIATyyHJ9kPq5mI55oYKjwyUyqsbmMshP9cK/VKzWhH1CZ1CB?=
 =?us-ascii?Q?CnZa7GN069beEMaWVOUkD/L58fat03zXDsvdtRo2JhJSEYSUKRn2kD7JGyyz?=
 =?us-ascii?Q?oqWf+fnynaPK/IctPdVjQd6dNt50NL3FINq4PDskgTwIvEdJShPnLXQcrNxm?=
 =?us-ascii?Q?gqzIcOop+3j9oxAasKL+gGZLh4ZJZ2vxlh2RZOoGmKaGkmXEfysY2EWhXJu6?=
 =?us-ascii?Q?P9baGvKFCGl0e9XGA6073U72ob9zaDQa99+HCf6K4ReLTOIzRlxpDl1oacu/?=
 =?us-ascii?Q?w258zwY6pNIVRpgYlVW19PJe+37Js+3lWZ00QJsXqXy/uU/s8vnCvCFyw8z5?=
 =?us-ascii?Q?db8tQOHFoG2g1ljBXSaDVda1hj61la6BdRmRo5ZXwGU1WAaVpRPsqz9NLcXT?=
 =?us-ascii?Q?t9MO0mOQmSipZAMgAJ2GGpW6bBaqj+A9q2t/DiOOVDPzYr6BrY2EDKqKm5We?=
 =?us-ascii?Q?bfm+Uzkyc7Zf/1kFpLhslPgJ2cU4CKttApnfrAK/zetNH6lECWK4BXBrZh3w?=
 =?us-ascii?Q?yxQIGzjRFo/67J+krN+2uJb5Cm3es4syfCJoSyut7mW9gKa/sGgQr5ifgiLF?=
 =?us-ascii?Q?4t5zaV2SwHGJfLNqpYtpd9Uwmm53T2C5r0zm8MDjEDHV9l8gDDqvVwTPT8Bl?=
 =?us-ascii?Q?+icTcynVv/dFl9asaO8PlTif9erlP7N7CCnDI7aAYEH3A2hGDa8EGcFFXUDP?=
 =?us-ascii?Q?BuwQSQTVq+9+jlRbahjBk3IC28b2yCjBZoG7sKL8xz5AWO3A433Gf7sHC/Dn?=
 =?us-ascii?Q?nKqzqSLmbdJOKmMfhHS72Ykzdw6wUFHjFn+hTYBbk6iI0AUlUDOcwG3aA6Kh?=
 =?us-ascii?Q?TnFmUjZVOKUDpEp2rZszZvXGL8NzTKhUdopFAWnWPgDNq3bPrdG0Cgox3Gc0?=
 =?us-ascii?Q?rnQAUhElK9QoBJhJrgYvlkcu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UWgx5jep+0Imc2YEDFJRYBh5as4TTWlzhNxf6I4YqD0Q+2cmEZwGdW+14Lkx?=
 =?us-ascii?Q?EqvjRIfIXtSh9Kgjat8giJg2jCyAmlLLz9dImEqCJwyVUrZmwFDU1JIEoxA5?=
 =?us-ascii?Q?nIIdeIqk26JJDDICa/+aYQGhFbEsDXsiV6CkEiDjn4zbiNLlKzUFWj2qArO9?=
 =?us-ascii?Q?eMVplEk3AQdc5XK+hMok9i7tP/Pl1t9CWrTEZ/htTdvIHPqA1QuQ1ASVwdt8?=
 =?us-ascii?Q?sGwH9ruheItART/eZ6dHtOn2D3b5eq3sXKgKX4Els7nwIwy9q5J4zDmrfGMw?=
 =?us-ascii?Q?jEhP8l8bsg5pleUJiGKmQ4KEqOJwNXcTRZ3WRbZtIuYgZKiHSoN6a7PUFcs8?=
 =?us-ascii?Q?SZPI0vcy0Et/Qeidf8FzkIXK38EYZOl39GClPSEtYpk4bsd6INMC+1oiG4nX?=
 =?us-ascii?Q?KcT58hHeEwPGSxyMEWkg/0gVUGuZjd3J6DAF0stbiqxzYN0oQAkt55WO6Hjv?=
 =?us-ascii?Q?7NlZqHjrARSM3YtfmkHCuNfEizKRBkTMSmtS3Af7dLro9TyRMcMXuDujbU+U?=
 =?us-ascii?Q?lfD89JMyGKZmt3BA7hhx/WyFMhQnFg/CY7VHIHUJWF3IEWLEOJNpTZ96JG7P?=
 =?us-ascii?Q?UAE1rVPZ3sqaHZrjeXPyabEMZP51uB4SqsruV13MAswkEjvB8ucuyGEGm5a4?=
 =?us-ascii?Q?hp9vpJeGGT9sATOjHs6J/LMWY+FSoY3b2UFIultg2iTTssDNJgjPourReG7u?=
 =?us-ascii?Q?DlKJfWvuDEoeOWvaARUrwfZvojulVknJh7IHGfFW91GAimi0NXNIvTWEyPJa?=
 =?us-ascii?Q?RflprYi8UI+bHlM2rsP7BNKI5/rAJNkUIfFINDSBV8KYyk4gMJS9EqLd/O43?=
 =?us-ascii?Q?JTdQWdz9X90LBxi138M69RitIj0dDscqySgTuVgqCON6XVjwjBDg96DP7C2W?=
 =?us-ascii?Q?X1AD2Nt0Toj4hPNILY2L+V57UCpiGma+MIm3k8lpGQDOq/uOOAggv5zvspuj?=
 =?us-ascii?Q?Ar5AcEMyvNYliL6ga5USYW7uCfPmroOZybuOIuEpusiVQOyBGN/+s22OAaDR?=
 =?us-ascii?Q?nR5S3LmYzkw2a7EYYVUQ3M9woJIovRFWfzMcK8CWecm6dxkIAg2hdAPbJJIk?=
 =?us-ascii?Q?ZVJLzotB0Awzx+JvX7glkcXdZjNGjFBwFUAPRNv2Dun3gHe1bTPsXZCY0fgN?=
 =?us-ascii?Q?hs4Zw3JtnPxoxz6yOE6C32jT5szWmoHLrSCJsSY68B7PBXvNE0ZE3CZ+Puu1?=
 =?us-ascii?Q?mMewpX6L34nG1kiRj2DjsitGPlFO56eWWur13j6wzs9UDDAc9IGhHnq/QMxo?=
 =?us-ascii?Q?Hcq54n6tkRD2IHcYQ7yOiNtH+aFC3gzeNWZBfu+be0UimYtuJljGGAw8g3aG?=
 =?us-ascii?Q?gXWyBhZgNCaSYEjZuQUtCLUSoSvkHfZ5lXEqyfODo89dfSDItuZJG6a5JUS3?=
 =?us-ascii?Q?dbwexOHR4Bzla/K+0NntvddYfYRLGSSxsepZemaE9aAjF24DIabeMsbzLscf?=
 =?us-ascii?Q?OUyaTRhR6e4I2I8rpUpepfPWroWrJiObb72apaHxWSAcKcvDb4kYbKluv+wT?=
 =?us-ascii?Q?hkANSk+8XyOKcf+/iucp8vEo8JC7NfG1YT9HI+MAuJaMARqSVH4BFDBnMtsM?=
 =?us-ascii?Q?amEUkm57LZWDB83xkfcp65yRMHXqf68ludeqlY7H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb8d25-e565-4bc0-be35-08dcff5d1193
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:50:37.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hr7GqR4jlFnwWAIptiCimfEnqKb41cGppdmuZ0D7y6U0ustmIpgXghcDKYXLn3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920

On Thu, Nov 07, 2024 at 08:31:39AM -0800, Nicolin Chen wrote:
> > Is there any plan to add guest device BDFn as well, or I can add one
> > here for my TEE-IO exercise, if it is the right place? It is the same as
> > vDeviceID for AMD but I am not sure about the others, hence the
> > question. Thanks,
> 
> Generally speaking, adding vRID isn't a problem so long as there
> is a legit reason/usecase. That being said, if it is the same as
> the @virt_id for AMD, why not just pass via @virt_id v.s. adding
> a new vRID/vBDF field?

For CC I'm expecting you to add a AMD CC specific datablob to alloc
viommu that convays all the specific details that the CC world needs
to define the vPCI device. This might include vRID

It depends how you define vdeviceid - for AMD vdeviceid is the index
into the DTE table. vRID, especially if it includes a segment id may
be a larger value and should be seperate.

Jason

