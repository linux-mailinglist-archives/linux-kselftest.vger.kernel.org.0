Return-Path: <linux-kselftest+bounces-34422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52BAD0153
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B574189C689
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C32882BF;
	Fri,  6 Jun 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJvy/Dth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11420330;
	Fri,  6 Jun 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210207; cv=fail; b=D41MOAbtCuainhoxnoHdjnp1sFLrAObRtScj+Ly5QR+Fo+7J45G3YMK0MvtJwB1TZ+PsUqHupPviYpG37OZljBDs8i4wrQqCNMqMNfZHIMWUmZd2MCMZaHwrx0PBzcj7zNBcqSrsCCe9sXonNncQmQte1TTydB5i8NdV/YvS3uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210207; c=relaxed/simple;
	bh=hnLLtBR1Ol4+6Zgmuz+9lAfRGnGmLwXjz91K1EeIjcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MdoPDojy0VI+Qg5uL1XuD8/PmaM0BSeVfwg49rIrPMZ+S39PKwm8JjeqckSsAjbki5qIlahBDgN9wUZO3cHJAtnm8+P0mSnyFOEDkdgifgQIE6HXLquBMKaO70jiFfxz1H7+eKUpmB/YknTupDrKTTtwDIsVC9e8YNztdA+0ifo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJvy/Dth; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgpKB4kkytS2Nu+ZV/yo3u/NaRPOiFKwhs5iaXlhGoNQnaKgojrdUgX7Toqy7G6JpYmn/4MB3eyq65zVjcFuvirF3tidKAnqnjtX7QYtCKHOWi9yGwUfqEYoObT12+DQZkDZJDv+ShMDpw2PldbPDS73JIllXwPIfGNgQlCEQzlwtFxlvkz2D5DsZ1BOTJdyyiKlIozyUibx4lcrYNTPylA+6cwdkvbb2Qpj4Dj4h2e/eqBlKTAgjHmBd2JvrZFdQzizgYqi0vMyFqWyeeqhiuOnH18J0XEkDcgDBvo1gJ3/VcoUdXq3qIALpzuAb/0I+plmJLXOlJklVBOZOhlNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ7spYhjdaAUJTIxrVVhOJIWwc706I5bUDFAI6ertE0=;
 b=I1iqKzovIQlJNl2fKxjForkN4qBMX90pgY3srK0TjxnA2g1HAQoAMwPmbzp4vTqChfS1gRZrDuBAaxchV6sys8+zzCBIzsyJz4Q7UdsnQf08KynzSvkMuQjYCDPeQlaSbhryT62cAfXq4niA2B4njiNhS9naUeL9TAHtPXOAtK0sJXurZXR8c8a7XqITfNQ5ZvXOpnzVhy1v4e21RGi+XU7clbd27TE2Mhnur61KbSF3Y3XsBEohh2QA+QF8ha9QQFQODWEdic2ONj8On92c7To1mjwAw3f5fWoPCbP7WT+vn5AbYrjapD22+MZgiM0JRQ1XErDLxZr5KeVpuDYoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ7spYhjdaAUJTIxrVVhOJIWwc706I5bUDFAI6ertE0=;
 b=OJvy/Dthdyko08xPFEh9VSJVFutmp1PCCA/W9KIma34G7tMCqX9yzrRyZXJ9MCxSIzi+XGKekZRwNARoGKrQkKuaYf16IvGpMWRggqyo4afRS621GbCxDal0gqQdp0g9Gi/UjV18MEJ0UMhN83N2nrUNlspCENSXHLiFFdD5jXKYqG5Z7nAisN+qJ6+/T3GccxdjMjh+e+5mNbv8X3PEjPbGuK8aCDB4/D+0NAGLjRFZ3tjZ1FogTp6sg00oAjDNbTZhY/X1M/RSwpzl50aE+eiJwSOsfra2sVP+z+hG/qMjzEKBPwbdh+OJ2bn9RoiKRhF6GmKWHhg8gtWsmIoVtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 11:43:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 11:43:20 +0000
Date: Fri, 6 Jun 2025 08:43:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
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
Subject: Re: [PATCH v2 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20250606114319.GG19710@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <12-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <20250605140358.2dd6c083@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605140358.2dd6c083@DESKTOP-0403QTC.>
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 756b446d-73d7-4f90-daae-08dda4ef55ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiIqFVIhuAoi10OqgvqK0SCTnwkN+heoXXKq+hKwAitLyLG9p3tIU6r5TgIb?=
 =?us-ascii?Q?VytGTC4V05aOZ8wwF+UnZGLPtW6lhaH25PeZAKU8UJt47bKyJZ061V7sTqYp?=
 =?us-ascii?Q?ze8eqUbcPgfDRcEHUvMeJoyl5Run/5tc4mnIRsJ9hwgVUHxThg9sc9vr7QEC?=
 =?us-ascii?Q?lGCfUuhI5uYAQMi/95VFVgxXZwWKNgLua17UUZtvNV9YP7ufsHnSlFi2/sdY?=
 =?us-ascii?Q?CEpfSNDnM1E69nUkzJlshucL7saTEsuzVcet3uGQrD2A/vq1thgcAQhOV/US?=
 =?us-ascii?Q?rifSmPaI25ie6YerLQfIenn+TpJfz+cImQ9gkVoViGnDxyz5FDFYd+h+zKvP?=
 =?us-ascii?Q?MGlzLGnts8mRlOGVcCurAq14pHE3bAAviJgX+DwenP1MF9ts45aGZaBqOdhP?=
 =?us-ascii?Q?ydM2+1xkhBN2t/5p4babAYpE9Kq8BZ0WdCbeXI8QhPqN3pEvm+kL4VbRVPVr?=
 =?us-ascii?Q?i098sVDtbVsqWu3UV3fK16KfELu/lGbLXRG5soshOdHd+CjVIR5Snijnsdyj?=
 =?us-ascii?Q?8ypOvZHPhp9i0n6IH6gkdPpFQesLbhMrH5DRc/74EtdEos/p8ZDA42ZWkt2W?=
 =?us-ascii?Q?oen4TZUMou8egZ7WkkJpgcAO3tD6+XNWx8zI0niUsJXMl83o8Ndl/jd6/rnp?=
 =?us-ascii?Q?FDqg+Cc9g8hW+QeiiBissMS67OMFW6S5cq+wlOePxMHeDS6IHXhVXVyNkq/d?=
 =?us-ascii?Q?ULesMGjMe/aoEHR7h1ZnxyuNd7/yEKWexrPxV/CSSqkF5IFpoLPe9GJ0mJHl?=
 =?us-ascii?Q?54JoTasdth7LT0P4YOhqwhrcr+Nqcr+siIvmOkYYwcyHdPbEw+xnGkpiEBz8?=
 =?us-ascii?Q?0GY8Xzq317r/QrGXQbqZVMYcNfEGLDqfjUlZMlxVqqFipLZnXdtCUfCyJQME?=
 =?us-ascii?Q?rzz573Wdqrp7QfmdtnYdCrDI1yL7DrvsmorxScYm8RDz+0hkQsBM0T0n7QQh?=
 =?us-ascii?Q?M2Nh98jnfOqKuRmQesZ8gxjUBrx3rqQEbTboj6furh2AGjPtNEVhsPzk4Veb?=
 =?us-ascii?Q?NCSsB8mqPyTpVEN5agvYZDYlINmzzt8tTo/KE0SLOj9z6poXIYzI1PVAu7yu?=
 =?us-ascii?Q?lgHSj/BOY9Cpi2PZOJLX/vURJ+DMP/N+wmpR8m4FGOkY3CmSswY0NtOJw89V?=
 =?us-ascii?Q?cvdd1WUs6wom/eN1gFZ6zGWMQrpRxCDeMdzZvEaqG9PcmwBksaJHghGYlURz?=
 =?us-ascii?Q?q3SKLcuAvLqlnfGBEnFAprrDEmWXZu35fV2LC1+4wOjJkynX0e5yaCjxJjEf?=
 =?us-ascii?Q?NxhfYUTTAGnVwt+8+mUm9e38ppCsgi5Y6oeGW4I5T7Wbdmad8xUe8xmL0KLA?=
 =?us-ascii?Q?qEt09Ye1fsxvRzu6MbSL6bk6z7DK/8AR0gj6WXdeXEYZ24eino0lxuJKrYe6?=
 =?us-ascii?Q?pZGTCMyIb3Y3ZSdVmx643J23cX/VFsTXPpn/BhYf5JP7J7ODJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOi2aQx9gDXelF6X0LLEWvXTdLgis+HKxBW48675hqMRG7pgQIJsd1D2cmVl?=
 =?us-ascii?Q?XaetRPiVSVcvZJAlO8vIyTAFdPsC3f8PfoKADLNcDuZnzv2AZiNvNLEMgBA3?=
 =?us-ascii?Q?ABdQcc9/D6XONj0rrT32jp/kNy9UoJd4RHc7IZ6MtJE8skFfb0mIuWZOaMCE?=
 =?us-ascii?Q?6huqqRg8MacOktYup9EOz86A5lcgUyqtW9BgUdUZokGWxjGN8RSNpgrzmLxr?=
 =?us-ascii?Q?nbZkz49XYNGLqr3inMh6caJH0u3KT3Navy3nyg4PO1L0wiHnvIW/R+o5snEA?=
 =?us-ascii?Q?YF3MaM/ROhT9Zmq12c65pWYso9yJOpDVtDW2EyKDrirtxTC8DzbONlQMF/oz?=
 =?us-ascii?Q?dCLkKEdNqln6T1aPqkxrCzAmRDs8eo+1B6Ere6D6u804+f/MFUESZxXbF3U7?=
 =?us-ascii?Q?v/ImpjM9UahFT7atn3u4RNNSURSt0A+fAqM34cZZLPkKW3lBKUsJpmO9jUQA?=
 =?us-ascii?Q?qafvWHTun1zrtwg2zWY2Ba3jfVPGH8gONRJwWAsYoj4YxBQ0rBzJz6ZouTEe?=
 =?us-ascii?Q?zZpT6aOl5h7TVADmK44kKX/LPCDKC9L2SIIPpaYbp0yQLJtkPdBJicsudXf8?=
 =?us-ascii?Q?ciNlr9xS7rh8ettFF1xK6eE2Bbnn1/4WcKEToTqQjOaJMi3lz9Ecyz3GLWrc?=
 =?us-ascii?Q?efzKuP4exG0xSAXwgTgoGbav7LXNU6rYQMdXlPQ4L+EO/cpc7RQxLloBN3ji?=
 =?us-ascii?Q?22N0Ernuf4TsmILjvKDkjc1PJXYr4RkQwcW/PNvFN3oEM14uJMDB/NgtRG5I?=
 =?us-ascii?Q?i2HuxZaKKGCeMGgubhVsqWlMgneRvJd5AjaZkocxvjqd7upOAzkjc9NQMZy5?=
 =?us-ascii?Q?wI5hCXUV7iT2SpYdZij8ekZ7E1fHZn8kr8XH8/QoMIe3o40X8DRj68ZQ0fTk?=
 =?us-ascii?Q?zIHNBywVc2AAqDsQ0x8isaS/mRaarg9+2kqEncQgtJeLu1hpdZJkqFRmbaR6?=
 =?us-ascii?Q?RqKBq7hN+v/IB9z44LuLPmnnH3E47x8rDLwAvbS8Tk6iMlwq38MUWtfkIvU6?=
 =?us-ascii?Q?Q43ElTihBd1fvo222XoKWWqRD8Nv3uJWteU0GllNvqnFUvfPNhBtmQY1dXxz?=
 =?us-ascii?Q?dFipHnC3BAvCPEpX3z4YE1ek0VGISt1GHoTh0yc1z0/1hzKspWi/tKhCGJ5G?=
 =?us-ascii?Q?giXLdL4NWvl6yuffNqQoo6suwNLzMBMRwVE393BGk8Admxm9vbHFITOfdoak?=
 =?us-ascii?Q?cCUwiCmWimQtWUCpBEaaPhwYRNMbM3pGXCpnTruNUpIHdknBL7wFJQZ4O5IH?=
 =?us-ascii?Q?H4KjsSjKRcFgvZ3f9hpFVFEAgrEytUGVz/0GEsmSToK6OoaO2a6k6N4FnYix?=
 =?us-ascii?Q?rNMpACtlO2JkQRELY7Jd3js9QEBme7/aBWY1VvTyXmkl/QyFpUUpybU54Qq3?=
 =?us-ascii?Q?GGuqpW6HL28IsadSjy64u49Ndjx2WemmyLEo1/3iJIDZXocMQBSg5U1tA7v5?=
 =?us-ascii?Q?XtF0dtD841bSOgjyL3rNyu4LP6yKBJXSznhHK4lrjzGzowIMAwedWL75tZw/?=
 =?us-ascii?Q?oF+k2ezG93cDjcuirTnnMAfr/u1vSzy3LOpkw+T9+eLwS3cqFGFbpszk5I/o?=
 =?us-ascii?Q?8Kf1VVFT00nDDaXIj1Nsi8HaDVPaGUVncToPRugL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b446d-73d7-4f90-daae-08dda4ef55ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:43:20.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS8Vzzl/v2GZ74lXiRqhjwJJIWcklLNuZ0aLIlRaXxvSDsWuYTXhZGyyY0aXZB7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Thu, Jun 05, 2025 at 02:03:58PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon,  5 May 2025 11:18:42 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > +config IOMMU_PT_X86_64
> > +       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
> > +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> > +	default n
> > +	help
> > +	  iommu_domain implementation for the x86 64 bit 4/5 level
> > page table.
> > +	  It supports 4K/2M/1G page sizes and can decode a sign
> > extended
> > +	  portion of the 64 bit IOVA space.
> > +
> > +	  Selected automatically by an IOMMU driver that uses this
> > format. +
> >  config IOMMU_PT_KUNIT_TEST
> >  	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
> >  	depends on KUNIT
> >  	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
> > +	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
> Is this intended? or you mean:
> depends on IOMMU_PT_X86_64 || IOMMU_PT_AMDV1

It is intended, this is the kconfig pattern that says if
IOMMU_PT_X86_64 is enabled and modular then IOMMU_PT_KUNIT_TEST must
also be modular.

Jason

