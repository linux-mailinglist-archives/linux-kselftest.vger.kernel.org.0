Return-Path: <linux-kselftest+bounces-41506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA67B5810E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA59189638D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7D1DE4DC;
	Mon, 15 Sep 2025 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVMbYiMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52471DC9B3;
	Mon, 15 Sep 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950619; cv=fail; b=KUgYUXZ9GNkPyq5RVX4lho4B14SQfqMEaatYaV547UXMlM9ShygU8Acb9eSeKmHMax0GeRlHKm0UPYzYa+G6SymoQ1Ywlgotw7JiJYqTkoi6d1NJN2K5/fxLZpmp/D76hWSp3B2rC25CqGy1S1YIshWSPr4TW6eAPfeKa8U2MDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950619; c=relaxed/simple;
	bh=KvacbATFSJcaF2xDcDoCkal6W4LHLBXb0dHri3qa7Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZ3O0VIZWdimtd6nZwD7K86tRfM4xEpbzwQnId2yWr1F5eDuK2Pp8WmDy4OsFbJXOWDpxBEvqewlBlankaT1tuiSjQvt7P31VWNLDNZ/BDGuhOqPigeO6QVC5/nuFzhte6yusrGML3kzQdk9SggjcpCQQfTKR2lYG6/6OxHcmLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVMbYiMt; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xChBupAVqMtTK04llo0Zy/UO5h/huhm/PX15BIcNQwRHWAenmtU+lJEOcgERg/AkGTf0MUY5Fk8UU6ClqAAYCSbft6f4tSNao6p8bkuXlmeKPOVQBtZB+NSUUEOhtao2UzlgohWayS3II4p32xABm9vk20Pbhk+njQ87wL81Erx7R/mQOlwmaeV9NkDIVpEpy76/4mJBiJJjugfr0IYkAKsg7PvlLYLjEwwoMNgnT3bqyom8t7vKMfqHk71Tlek0Z2G9unp1UidZiXU6+EwWLXT7Lc7iDuYQBJyD4UNGdrPYsg2Ls+wMt5uPiRjnJ8f89HpH4V3XQ7s+2+up0+pV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvacbATFSJcaF2xDcDoCkal6W4LHLBXb0dHri3qa7Dc=;
 b=gM5JYLZkQ6bJRhCAcSKdww0YKkistKV3gzJnGO3a9i8OER8mQD5L7d34Wjr1X9TA6tuuk7P3CvTdymwYjHpYgqtbA+QDfHBcjrWvOPNk7HzKeOXhp0ubMQniY0t4e0up+sKl0Trlm6EsHWZKQQGqjH2wI55qJj0WplLvIvlzwXovVBZgVrUIu/+zqON/mIo1cGttLbSmxwSLKv7lxIJOikqXs31Q2qVVbdsBv93M3Qcrc6Rp6DVFXnu84qNWIDZwOcRk07hftrdeTZyNtfbQB9mBVI7tPmaLB1xxXyTMkZKfukJvAkvUksL5TfdC2i4uX7gyMSwObt18NmFve4dWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvacbATFSJcaF2xDcDoCkal6W4LHLBXb0dHri3qa7Dc=;
 b=CVMbYiMtXboLwsuaan4VU3IuSTjZj0JbdnckhW77k8EgY7KH1uSoAsya5Qe7LBUPqqymTACyQbYRipa0TQaiXMRXU/zVXYqM5FNUM5qIxTTZ2eAtGW0Wo7S1ievT439G4SzbZNRLQFB7L79n/um7N7x/AB4TD05CenVbi8GZZ4uzuHLwcN35YO5LRDuhY4mYQrSim6QBxHh6/3LKj5Ay5tEDxxWMkFfq3ujMF+kgMfe522chDzjBAH0LFHOXnnD5rvrlLNSp0UQdFz8sHmh1wHV1Lm+Ed1I9wf/V17yB47yEYcfeR3Qa2wtPnuJO8lbvYIUpYMe7fnMY5wJbEDERQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:36:52 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:36:52 +0000
Date: Mon, 15 Sep 2025 12:36:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
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
Subject: Re: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250915153651.GA1057776@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMJgRGl+znjXJRyJ@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMJgRGl+znjXJRyJ@nvidia.com>
X-ClientProxiedBy: DS7PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c871b9-323a-4327-6869-08ddf46db18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+OJQHwnMsPCajZwiEv2HQ5DnBZW6Sj8e4UFSoliW6U6gXmNhOKck+h5tjt8R?=
 =?us-ascii?Q?7zg0tkbownbtLsyRmHzPz0JsFV1b7VaKjRtk77PDO06CWdFATT65ViExtyD/?=
 =?us-ascii?Q?osbNVRDtjuGjOBz67rDl0Rv780WjnGoqBndzDUls3CH7I8Z1EZUlPtTP84dF?=
 =?us-ascii?Q?h2hRxk7Zwagh4+sGwb4J3df3H/eJrCjYyjDaxtLNIIAeVFTFwPGHzxcvSn0Q?=
 =?us-ascii?Q?i5rRhvUWx5fFgCD4hjl7SutcP6nyAfmcvn00f5IjWYAhHByJgPBCLXWNfk+p?=
 =?us-ascii?Q?rbHPnRE7PQfYbR69ueUUK4a5uYvc/4gvGjPWtQKl4GeoD1u7OlvWecXQaNc1?=
 =?us-ascii?Q?ppB84ZR0jZHP/eTIiwG0vjiNM0wKT8FupJtYvYGKcBOtM4lqTyr6HpwXMdrt?=
 =?us-ascii?Q?8Xq/7XxlO0GfLVgFmXeveH1qUtcGd5S220d86orezqScUrjxqTu91kYVkx52?=
 =?us-ascii?Q?qghgNpNkg7qmn7GbACGt4vertFmDwJ1KarmpbulItZ0yDAaxYzG2HpljqRMu?=
 =?us-ascii?Q?+EF79VauETZpU9afmjEGsd0t98nUOX6FSdiSV7ObN8lCyYtolY7oNu/6r9Bb?=
 =?us-ascii?Q?8EP7S0Q81+Ku2S/x48GXCsbGYbT7bWD5zoLvITucd+MzVup3eGOuUNbqQSRb?=
 =?us-ascii?Q?IBpoZNxUWxSXD6rffPnVJB/vQUbfhHGSUSWpkwaUlQ5nn1vXUXewDgIYokgj?=
 =?us-ascii?Q?b0YoGPD0ZjHTLptWbEsgBbrPhGxtF8lQYF+vmS0qHiT+N+gYFeOl0+SvBWIs?=
 =?us-ascii?Q?ZRdEZsJPh5Vw15OsTTPfGMYCFnX4HlbZ0X/nDTqGKQaJytCYmDn59dNe47Ri?=
 =?us-ascii?Q?MNtjerJIeB/nxtPvTE2UbGn1i/XyFd5j2P4jYMT6DAfhqTAWMnAqDYIvkoRA?=
 =?us-ascii?Q?fGLHufyr8KQ1eQLYTsAlAzgwL84Fn3P7SBGG5fv3oUroSPeKca2+KpzitBuU?=
 =?us-ascii?Q?E5Ysc8KaG0ufqbDZTWc5oWcILyFy/M3qrc88vL0Wd121rT9ud3zJG8veHvEh?=
 =?us-ascii?Q?CFso+4u1eZktH70QuU+alXsdTLbyBw+GQxa7SvUNiJ/lf35O9ZrDQ2i3DYlW?=
 =?us-ascii?Q?9XRvO6PB7BI727iUAp/nc6+bs+oPXBd9k2a6YoAJEKLx/MoNzDJMEKyxdSLi?=
 =?us-ascii?Q?L8b6POruXwFCbjCpd+OW0ZHy4/tipGhy9XBzkLZuV3g5Y2ozxTqYOeicWcoG?=
 =?us-ascii?Q?8zGWioKGGEqZZ2vN71XHg3GRzNEc+61zgVb4khWryowJeIse5H5Q+kJxu+6T?=
 =?us-ascii?Q?zWLRVr8UfcVJk/yoP+opsfsVmm9RWKn/BgsdTX8chIGcivJDuQzyxEhDUaqV?=
 =?us-ascii?Q?7cuPIInW0rt0KQzxUxTPg9QvqM2NEyKo/OAgnSaqFmUfZ2FwZA/pApFdC6n1?=
 =?us-ascii?Q?WPJwBcWGXHIbhUcBgxnwg1FIUeiZFObyISwYbzDNo4zoi6rbiE0ZSf0Ug95P?=
 =?us-ascii?Q?/OpBFLypEW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mifAybWf+hPC1dYBY98QGzIpY44ibP9yZkBphKTcUqIyWohqQGmX6PVoQ7bp?=
 =?us-ascii?Q?Par5bq2w+n7ybO3LClVjP8G5IZB6D2Ge1Yq59t0lCCv+DmZT+ArNZrS1D29E?=
 =?us-ascii?Q?sEKs4Mgw99low7AmHZq6ZEnjYsP6MtFYQR13X1KOHAWTKgV8COninIrupZ4v?=
 =?us-ascii?Q?oM6e0ecUX7alhNOhUWXVcxb8dn1s1V5g1Rh8OuCendwjaQ+jB5+oY94G8vS5?=
 =?us-ascii?Q?9VChwEO8kfDZP+0jl4dSSUzpEGSQRcLXJSCGgmEWoGI+IaqQ6+6F/YRb5+V4?=
 =?us-ascii?Q?5+FplKcjo+wGYa6fXXuU8jbHlqGEy1wjG7hmARWBvjqBWy/p93DyLVU6U49K?=
 =?us-ascii?Q?k26auHr8VMjSw+p/7cpUaT+KxdjiZIg178+mWRtYTWrOuMFPrCg6LCC4qKJD?=
 =?us-ascii?Q?Ufaz+ZeB6y5s3gKDdf5k2OnNHcPaMpVlP4VcJ3PYDqewknV/uRk60Gnmk4rL?=
 =?us-ascii?Q?kPwUJYJ0sN8oqk3j5YQU9jNYEQHNAHN3DAFZOsXquFcx347/khwGuqXDzRjS?=
 =?us-ascii?Q?I/oqIj8NAznkH9+E2PlA8hp4EsVW1j0zY8JR6nozDQlx5iZ17CMsWlqbHzSF?=
 =?us-ascii?Q?piCXbv+283D1Cnpo+r+T9mZHfaQTM2BLR6t9rxId4sOUwsjkIw0MkpKei2n0?=
 =?us-ascii?Q?X+VgzmiDzYClABkDLZxl+AV0gw/KSHc4usTPHKpJpTXTDjF6Vg92Ou46Ydbu?=
 =?us-ascii?Q?9mqd3c9RTPR7OlpAbt/GSDX2Y96oJ0x72B9gpK9nSWCKdvPOq9MWdvbyDrtK?=
 =?us-ascii?Q?d1lCe+QhtM1WDC71NODBFgCksm45iTdmHeTOAB35YlsQzKMlE/VLhyyqkOF+?=
 =?us-ascii?Q?A7upFdUks4u8p25y77QcBHIgKEG/IX1sXiioK6w3FbUrHsC2vAltDHj6nI9A?=
 =?us-ascii?Q?G5U9C9OcHbhpH7Nt1J2T6qP907nbpbZYg2Mkp+BrDeK92zx9+FA+ehZ8xNDY?=
 =?us-ascii?Q?4FL34dqNvUoux1rgx/5aZBE+mQVQnVkwCUk74zfCKfEmu2nurRRpC2YPcSKR?=
 =?us-ascii?Q?FQx8/FpWHQq9EXF56u66taxwJ66aqivahNLtXP4pUzEghOiXA7spBcQeu8rn?=
 =?us-ascii?Q?rKsFeMT0PDDSHe3f3QjQojpCSf178WZnR82DzsrbaQw/2/nZkuVgoZZewjXV?=
 =?us-ascii?Q?H7FYeXWqBb+oUTYMwA6o2gr+aJT/dvXs3g7ntQl8tEVn941fl7CCDChQA20z?=
 =?us-ascii?Q?k8hfFlGJq05IkmycgeDz+6vDiqp2K/0mIrRPmbpyaInL5mr+zSPVwS4RupLh?=
 =?us-ascii?Q?nXqfORLVpXypVFCZxcEmBxrzNtz3MWvyt0P7W+4Mq+meXnUzgHQXqja64DTX?=
 =?us-ascii?Q?OpyVObhwCKmtMb2zhcxY0I+B/m0MX03Ia/+XVr2Yx4J+wJE77Lw2SE1sELHq?=
 =?us-ascii?Q?dkEoOds67JwkIKAXTUCd8id0uYCTbF/uFWJZYGpjBGEnSIOTit4vAnE/JCS+?=
 =?us-ascii?Q?I4C+9t30FIepD6BK+v3elwigVXQvWNXJikmuX9nRpSFCMbIpHy6g2laxjBjX?=
 =?us-ascii?Q?fICT5w0MALwDbkAT2+PF+u/korZvJXs7oPGF9XALgnYDyb2o7o9d77YbQ6el?=
 =?us-ascii?Q?MFCX25wNVkfpC9QNa3JYQYFpiLIG7LyWUDSexSOM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c871b9-323a-4327-6869-08ddf46db18d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:36:52.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24IkNmwm6+sqh/nB1mP78wr3rW47iu1lTufA21sl8oLoAbMUgVSPrPy0Cg9yysZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On Wed, Sep 10, 2025 at 10:38:12PM -0700, Nicolin Chen wrote:
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Got them thanks

Jason

