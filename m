Return-Path: <linux-kselftest+bounces-21205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769569B7A21
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4991C21720
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508619B5B4;
	Thu, 31 Oct 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KfMRV80W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E999153BC7;
	Thu, 31 Oct 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375984; cv=fail; b=U+g9p661vdUwj0JgoU+u2xH9LyIA+edR+fFPeb/wbC5EvXq4K1Jh/zI5vCTUN6Mc7GOUO454el+NqQZW2E4kqVP19DSx2GaZZzFY7Lfk4wK0viM4UUhdo0nDcrJAkau4xhX9XPm7ktl1ezCuxIYVAEg2nhN7ZUyFYJ/0wL1zwNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375984; c=relaxed/simple;
	bh=aT6QUvSw/Y1QrGgFFqc3l7z0qhnYj7XlHbxPq+TMzcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evVWbh59HcUl8/9QwmACQBlneAKFSTCxD8KxGuRNUNXY+D7YpRw+2I0CXiB6n6yuALC8UDaCuz2nHIH9CXVQMARxO7jqAWmyHc/fCiGpNU7bOe3p5vRXHAGqNSxbYGpJczBmffLGBZm/jsqoFUt4QXyB3qY7D5piw7D+3SxENKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KfMRV80W; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln/zwa4UWd4+L+TmY7yr4c3TT2tCai0zoJaw1K+S3YATwc/u3GI1gHpglEK6iZ8uLxZbuKVg2wjck/HfkyKc5bHleRp1D0aTBZ3nWGjoLFwHM8Rc6d8lQdRLQnxAJfxwQKcTYs+4DWlrwTlObgeXKgh4q4rjIZmblgBwwiEyECq4DCs0rBeNCoGvl8pADAhRmkSPXOosQj5aqoxW1Jd3SEjJ/7KVkVzu12RlQoDOg6yldoGUN1a6rQf2uQjxzJsTLtqXoqiWmF5cfANgjoutVULOXrsrdHoptRCptlu+3C1wflIVJurWDOfLdrut/IFzQhuYcKXfFgtDx+qAuIzi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMDJHDA5tCd2GoubyZuU/oUxFosg5i5sWOlvzY9InUw=;
 b=dDkn13SmemfVii45LwjfU8e+DjqjPgU4psC5NhAMZRWa8C00G0bauCDIjkfTyy/7skREQrQM6nsOX2aSCR3NdlBsN4TxxR2NgR08SruZIr9WnTpoOmZnGzQxLwiorA9XJnU1dcDVQ60ctZI5AVdH3yMyFd42OndUporp8vE1HzwlQ1NM4ymnhrtPVpfp4unBPzbiogkzj2b68HtKdResvemkkZ8tYZo8ru/GjI1BTSfOtG8ZaCFBciVYdJHcTDXUBmwLHeU8huPgEMMu9Wo/4E2Yq9ZbLuEjX7vi86sshgTnIxj7mkyYJE2SX0mqI4audmPyw4vJQqEz1zWt3WYZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMDJHDA5tCd2GoubyZuU/oUxFosg5i5sWOlvzY9InUw=;
 b=KfMRV80WohDtXABbIx7POFRUARZwbcGRPFbJ/mkvXjTBqrorR/nHoHlgxJrkxsTGqLfuA2j7nvTmv6BSbzVAhp0XyZm+cLkp5Z9KWM41C+8AMh8lDLZfGcnN4eSo5FxWiq27B3i//pV3ZoN8bXBZT/0Xl353O+W0k7JQazN1qrGkh92XkNIJv1cVLteR+yKWZycDKFNxt7xguMSwsYfZ5gwl4YMtWjhR0rbZemCmeicb+lR+OyMc+Bf7UxCF0ipO3+qs2rriCWTA0INqI59vwviO6VgAeiQk3Idhf3dy3oYuCLBsvy/5meJNN+HEn2yK6S4SxkGXoy0f9KfsMoi52Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 11:59:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 11:59:39 +0000
Date: Thu, 31 Oct 2024 08:59:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
	shuah@kernel.org, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v6 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <20241031115937.GD10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:256::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: a790a5f7-b8ba-49b3-2f5c-08dcf9a37ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ueCtsDBIH8ix9JaWBEfn5TNnldOAJuiDWAUfECoFPE3/CL80kcCUT72g1kun?=
 =?us-ascii?Q?/fK1FmfpIFqTIoFqB7PI5m/ORFjcuiI0yhvu24YyfhnJJ7i0j/XfC8QqG7US?=
 =?us-ascii?Q?2+4M4g5F4+zp/ILV46eyBvPBPg0SEfP9K8KdZDIVgvwQ/nUOdNdAg3h+sxjO?=
 =?us-ascii?Q?IancjBKFdH6j41f7gqJHqDjnHWGHOS92p/2e4w92xdGNLv5ryZ3RrR9I+xrS?=
 =?us-ascii?Q?MdWjrAhq+gUpgj1si8Vre+C+7wN1IU7l2VN+oyxsXntaKGzZbtlHbO6fGJfK?=
 =?us-ascii?Q?st3cqVjYaaYnXWG0a6at1pDCGg7cV0/rlt5Bo5pPpXk8BNhc2Y+VzKxK0NgX?=
 =?us-ascii?Q?wKKiy8vh/BNneBJkHrw4m4AVffd5PTGHGno9ixeth2X3oiWs0Q7vtDblPbBi?=
 =?us-ascii?Q?Qfbgcu6aiiqgV1igF8m7hO/W5cabDHZgrpk0vqlzZgyrfaPy6KM01OKn8nHU?=
 =?us-ascii?Q?vO91P9QelHYAOzBs3khP0P3its91U8Z9Iiw5mx0nuje/vnxbM68uNjgAquIy?=
 =?us-ascii?Q?x5DEZ4V6G5mzm0qsuaJCxP80itNiE6Na8J4FeiUjJV5to69P2sT/dYD/XLNO?=
 =?us-ascii?Q?7b7r3HmqW1Xn+6SkuTTmzN2G+CyiytzLj4hrLaoxgotwNBZIjnGJMqel1za2?=
 =?us-ascii?Q?J2tLjW9Q6l94o+mxIuyazsfXu/2aUUtLSsUd4O5Nq2FjmGKMThuZgqLx0B1/?=
 =?us-ascii?Q?GNOo5auLk9nfiYDx1zet8bZOXzOCXFPsJKniJS8cyKLdEgDxFBSCRcUD3etB?=
 =?us-ascii?Q?SFAFF9TH1NVKRyJ2JGemfOea2r6irpzbKu0oL/sMB2c6morI1tOYjqK36f4z?=
 =?us-ascii?Q?BPkmhrOa6g6njFg9iu9b8YAAbMBafQTCiYrMTv2JDe4O6htapdlcJS7urfMH?=
 =?us-ascii?Q?pZM4Hq/Gl7M/Td54EvJE96ogPC3D6nxM2KAdju4Lvk6WUCIzAv5z6Y7kx+ay?=
 =?us-ascii?Q?suBphmqYEOTadO4OlfMc9sY6JWmeAr/NoLWHKezE4ZBM3CWLAt9KDDKAqXkR?=
 =?us-ascii?Q?0EVAClxQ68IsjuB5QTCjZIGy7d+/epiGEfYIckO14wSOotePZ3bEwQWGOeDe?=
 =?us-ascii?Q?iWoRbrN/xrjq28y6bS7tbeofWA/eMSrFqG9gcFOaW09a71NTSktSfU/rFjVC?=
 =?us-ascii?Q?CHoRMWviToaJdyd4mweSRWE4A5wTtf9L0Q7e6eKu/Pc8oNgdlq3R5ADuqylD?=
 =?us-ascii?Q?zeu1wli9Z266SN/Jx0ZigkGbyIRQJdyGa/IbHq987lT51U/f6fnMvt1BmXzd?=
 =?us-ascii?Q?xUEQztt9H7X6kCD3WraW2AZ9NIGM+Pq1B9iAyOO/1Mxpcn1ZtFg899PzkEa8?=
 =?us-ascii?Q?ibxB+bkKoi/AMF36BLRHmwFX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7o43CMTAl4pTEplKoK0rDzpYGvMDtATd4kPTc/MrUlr3iTYhjYQJ2hu+0MW?=
 =?us-ascii?Q?8f4+Hvh+lDmIJrSQYQveiO/XwNXEmWO6ibTBn7goO4HyMCdu4xPpdIObedKf?=
 =?us-ascii?Q?liF3/CllQCe7n/4EejgBnd5Yjv8g2ef7nL1EhaEWFoqcxiz2ZMCS+5yYhcpY?=
 =?us-ascii?Q?DxX2GrhpQtNmA/fKRuLGTh8qTFGRGmlaqTnxG8E8O5DZztjuxSgg9YpoqtMA?=
 =?us-ascii?Q?IT02FRVTwlUzUzO2DDSjGGRuTFSaJwFJYeFhKFFUcmbaeyF8LsWk2lmqRJNJ?=
 =?us-ascii?Q?3XK4+Rayx5nYP2+ipyMOu5JUd2QLqAO4tuolbo/UR825Z4VdlLzM2+0/+7v7?=
 =?us-ascii?Q?w9q0Y7Mlq8fCzG717cAX6aMT8GOE5g9FlasHOYPblbV5OzOOgadQZSF6MsAt?=
 =?us-ascii?Q?Fk7QVb9m9m9hxWjNNfYsEfv+WG897PQ4Apu+8F1HjuenME3sNgIShHQdz+Nh?=
 =?us-ascii?Q?AuIOO4xKFlfruglQ9gdaHu1qaIiWBbxlPF0B4rCD2sqZQYRx/imQC9Ebwr/H?=
 =?us-ascii?Q?tWV0sHmQNr6dP5EG5MywAza3W2qNnU4zaqcTILohkP9VvwNSf4PWl8z9eYqn?=
 =?us-ascii?Q?bO2CO59flNJrmcOYGQqqP35XXsYIRT71hNg1RkyWezRyt0dxQJ7MkL1A6pP/?=
 =?us-ascii?Q?PBzEaTP57s0mwSsy3GP4kAxzOtLifgtx56uXqEvL4Wfuu7YptWzgIOpwypAU?=
 =?us-ascii?Q?E/p4cspCjH1n+FGuv1qrbKxdkbUyDS/XjHq8ui3AGlNtvGUdz5zTMEkpnmqw?=
 =?us-ascii?Q?B0fz9ST5WYs+k/A7ztogOZa3hlNxM89D4LkWgPPgOT07tWUg/T2IQjQ7DppJ?=
 =?us-ascii?Q?f5B/Sz3tb6wKFqlZ/XKc4AFlHSoFMeWW0/rtfdZj+mmYN6MGhnuvvNd6ZS2O?=
 =?us-ascii?Q?j8gEPepENKDyOvOjzyBh/XOg9IUWCQkBrdRknFS4ZAoy9Gs9zuDGulSecNO3?=
 =?us-ascii?Q?DHjPlmZr3E+6adRxBcYsKgYllPgtpN6KZ7kC28FGGPUc9LlPs8GRTfixE6Fd?=
 =?us-ascii?Q?mfl+Fn+EFKBIUGC/o9RJKSw+7PabPBlNTmB6uMGIl9U+JXYVs9rBOUCMth4r?=
 =?us-ascii?Q?c2HXUPmHyTzSfMEQ4l+ilpD3dLaM7uOprHCycAhlXeN3a/QUKht6NNIDne6D?=
 =?us-ascii?Q?iYYnlIQJ+E7qL1Fewcu7yLPMpjcQmeFnP5Oy9rd9fL75V/VXIXMfpC/fqrmN?=
 =?us-ascii?Q?up1jeXu7VTdjP2/YmGh6hGLv19Pw+HT2/QZuJtYM6sru7MvOdmqktDey3Awg?=
 =?us-ascii?Q?6jilspjz7Y4RiVuirJ5x3j+kMKJdtjJM0Wc45anNsrRQC7pVJcUblDdd14R8?=
 =?us-ascii?Q?xlRJlAreE9go6NPI0d1zKqaEm1J088ri1hrOuTUDZjjGBZXQs4JlqJXA5v34?=
 =?us-ascii?Q?fiOnegcxekj5FSmg4zU2qCKfglXboYe+iAaOw6tbO8BKes72UElsDm8N82D2?=
 =?us-ascii?Q?0ZjUZRp7fl/JGhWbpWc84iug2pwzufXw6lW7zWgvoiNzpvMPW3SCs9qVfBPJ?=
 =?us-ascii?Q?NYWnBOmCNTMWxAOu7wLQB7AEFZ2MCfxNYiiw3MsSfDklionG9IO7FPw0v0zG?=
 =?us-ascii?Q?ZG4DoUrDFs6c1EeDK6k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a790a5f7-b8ba-49b3-2f5c-08dcf9a37ed6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 11:59:38.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukPibTx+u6Bx0I+EPXmEvYA/QAnIdntoWzRxR9T/FkC26y7N+kZIdiMJjMWYRSMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523

On Thu, Oct 31, 2024 at 02:28:12PM +0800, Zhangfei Gao wrote:

> > As for the implementation of the series, add driver support in ARM SMMUv3
> > for a real world use case.
> >
> > This series is on Github:
> > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v6
> > (QEMU branch for testing will be provided in Jason's nesting series)
> 
> Thanks Nico
> 
> I tested on aarch64, functions are OK.
> 
> But with some hacks
> https://github.com/Linaro/linux-kernel-uadk/commit/22f47d6f3a34a0867a187473bd5ba0e0ee3395d4

Hmm, it seems like we should permit IOMMU_HWPT_FAULT_ID_VALID domain
creation on ARM?

Jason

