Return-Path: <linux-kselftest+bounces-24228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F075DA0987A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B8188EECC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2852213E6F;
	Fri, 10 Jan 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tizo+g+b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD352139D4;
	Fri, 10 Jan 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530031; cv=fail; b=UjzUzpKNNMk5uVw1QFWwlWsQoeBf+7BsFnfIgOsQtJWmur74bHmQ4qvbOwgTHFydFst5pTYnrF1n2knUD1ZiiO8QqvWco83jDDXJo6YZdKcN792TnX+ESs0t82yIs6L/UpnlzYQOhwR/bLMmCbwtYtqy8HghJd38FYtI2E1j+A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530031; c=relaxed/simple;
	bh=wVMSuDVEKW2uQMadnCANRIXRcWyJ3l8ELjvGYWmU4TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEyVckXAFHtLgKTjeLgnzBNPCDJmjbs6a3a9b59RSI1f0TTQFqJyPdz9g0aB4XdYMhkyRIc6vCJoWT+G7kH9wrfPLR+ckelAsJwa8+ubtzQlWtXPq8Leux2fLOposUOR86W5dAfVULPoyK+iiUHLEyNJD/At4JlzrYqDrg2EpyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tizo+g+b; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLPrt0LhGSffSK3gfg/A6zGSbgx4mEPNej62PRTQxouiZ7dvFKy1og19+awZp6hLtyXNY1n1SWsfNMJRjd6QDXLmnQVto2lkZDDuuluyLkru8nK01eryvKCfRFIbrz+TRKeZp4SuIiNfZU13JcUV2EIzagxn7TFiRR/rAKCKW7lD491Ii7OH1wdyVa/QhtihFg5/Ky8afA3a8xrK25m9oS0goKMOgE2xiu+wchOMK1lPTM32b6UXazPV1swslfOamCI9odf9PAiS4aD2GQYBDJW+76wwl0LDN1yjJ03ECoSoo5jr1hNjGWv30q7Fo9cFXmOP5WCTHTTqaBD3EjXtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGeRYMJ49QmKriKv2LAmGJYKrN09+Rp4OO9vHTjsmlI=;
 b=VZ/jOVheSZIHUa+unWOYzyPJ8O2CkQp7lKXT7nXk7ThlmgAFAc98o5VKmCWo3hZYaBQMnYe+mqdDasHDOY/N7p+fhACSuq02PiL/94SXHiRbyXqVBHHvghQaXkZwmsUM23eDcN1p6lQHGcg4iFQUHjkHkLNArMIDZLA2OCPdW8G3qCN/DpWI9/athAUAnNqXCg6waHf/PTuOZFMfBoCavzicxkd/V9Xn/vV3fQKPrSS/hTQVop0gfA5hcx946OFaq5FExhFVB/Ni39iGBVjPXCDYWI246iiMfkV0/aElhlAyThz3Y4Nwy475bWJ7rttmZEc6ihuJUkZCr/G6ELdxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGeRYMJ49QmKriKv2LAmGJYKrN09+Rp4OO9vHTjsmlI=;
 b=Tizo+g+bB4BExYGYGNgb5r7yZzsc5f3Ae9lwL9tWid0A5aPXmhLkD16LqiDBlGsmfLIlDHzSYpX5dtISZb9LC+5VKm6HiIOCFADLY3BVsiZFxqZaR8rtlsdN8Hhn8T6/zHjyhJyTAlMeSaBjeFSWU1eX3I1wjX0Ka2kNMXns2fc/iauxjBJw4qeAtY0R8YzsXqo7vEOHeOPRnrcbQBGXdhPHJAHCIuEStUby1PZOSLutmVz/HNucghFW5GItalcewEnMZLNhIF2/qcPRxYKmOhcmWI3Eni6XDpbYY1lbbawhoOC4kj/2AZTOCXvABtnnlfXOesqJk5S6lfdT0oMwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 17:27:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:27:07 +0000
Date: Fri, 10 Jan 2025 13:27:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 05/14] iommufd: Rename fault.c to eventq.c
Message-ID: <20250110172706.GG396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <af08ddec83b021cdcc6b2163042b04e369b6c5b3.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af08ddec83b021cdcc6b2163042b04e369b6c5b3.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 297946a2-f151-4747-b120-08dd319c0201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TyqVAYmOTrOLYmYxLaghiDvPfL2lVWT0SnpsBuiAXO+Pv+/ELGDR7g1XHvfI?=
 =?us-ascii?Q?P0WW6u0RIEKf9MYAMYZQm85aQTZ9B+31NI6rcYsRnS97kg1zJmvKwbG7iIOQ?=
 =?us-ascii?Q?WByqqLZA8e25F2+8/5+r9fr6aVEKqbQdHVON6A2evKw5abmcoXRXGxDBEbTp?=
 =?us-ascii?Q?JfvxNUsewOqvvna1aAGDL3HefWBO2rzg0RcC3e/52mfb6Irpl8PvmFC6P1sc?=
 =?us-ascii?Q?jbYFI8oJxVHLKSumub7onVgeamoyTn9tFN+pmdpY5i59xLvke5EChCMTSawh?=
 =?us-ascii?Q?/7Sa937xmToHbwcNk/ixgwzW9RGDgB2SMp0s+ojR7UuG1bt7xPRES5cVmMBj?=
 =?us-ascii?Q?GINayDTrr1lOITJYJPODS8fGO6QfBQXJbPQICkfg++9+9ugJ/oU48mlBb0T5?=
 =?us-ascii?Q?moo7oJWml4/rOFr05URQ2IIpxO7/XJ1kSnqho/U17cvxwOQaNtVHeWKCM5OU?=
 =?us-ascii?Q?x+3PYKHqmR3SMD1NBodZ8tkeqFpbxHAYwcnyFCHpejqXJa31YGEevVq6LoDs?=
 =?us-ascii?Q?gzAQOftR2OT/u30a3u23phyx8xPcA4lScxsGFLtvX6MLD/ABkvwoh6Nu5cm+?=
 =?us-ascii?Q?qv6Ttv/lu+ou+hCiTrDOB5rAxC83ypAjBvyWx20rye9Jv0jpNzz1Hl6OVX/Y?=
 =?us-ascii?Q?MZwXb+F+9bAO/gW2pyf2mm/E28QHTKGk9vlvwJ/AbKS3eUC/KXZxLdDvrhGM?=
 =?us-ascii?Q?pKErvEyKEpljtQEuEXSs4Z/H5xf+rVdZl3KW7T/nImPyR8ct5byK209JvMmf?=
 =?us-ascii?Q?oCsJeHYj33svphejwfvQlJQUTlqax1svhISkNSnd9VBsccJlrfX+qPWCQpf3?=
 =?us-ascii?Q?InunLNrUJNagzG2TjK+Bz+L0SQ9Eg9TbQiPDuJ0FLhe56YJUkXjnzSesEjei?=
 =?us-ascii?Q?+Zc5DkkaOwTi3eXIkjVNKsMGLZuIQAG6/POkKszDtaDxFpbKrbWLccGQtoMD?=
 =?us-ascii?Q?TGpKppPImIWmD40pL1k2Uadcayy+qwfcCPE/H3bX0nAsVAoTEDeio7hUtcR4?=
 =?us-ascii?Q?8FEfQ2Ny5F7hhD5hsy0pvvS08xhr9O/2gPgXXPmYklkfRMtfc4KFVcglRKRK?=
 =?us-ascii?Q?Ps8vFL+HAEPta8/PkG5/Jt2e87r+1ekZN3Vj0dchn4o02wIy7wBmjAZuw8Du?=
 =?us-ascii?Q?IATrzgc0/a8LdvLlywSP2C6U+dEt9AagznxHBmv6I4YShXORlRaLRXCNdpCo?=
 =?us-ascii?Q?rf31xiHVRQqYkS259+GO+b2OmDxKykw8I39gnvU4GuMesv/6ssu4TJ/PEt/j?=
 =?us-ascii?Q?8Ci0VeqNNNlu3T36ihtSksSvbfDOMvCBZIRq7h/jgayRb9MSdM7J4OL4xFK8?=
 =?us-ascii?Q?HntOqllushJgVAB28tu90Ljf5ZZmnw/SU1UlAeQ/UWDye3apAljYatnPHsS/?=
 =?us-ascii?Q?eeJW+1EhnXgNyItIhhSH94ucoqXK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?atJ/pxYUzjjkxuvlDpHs4iX4ONyI9/xXU2n3wKXpKZmjHB//oj1GvyGuuBmy?=
 =?us-ascii?Q?c++x0j1NWqAesUqsEmnHyB7myiCGa0fYEP0cdAsRRm7MGejZ2ZNsJmZB0GTT?=
 =?us-ascii?Q?6Odk8Ltwef7mUiWAuTK4JnhA2EdENMj3TdgDrZE3bX4N48LzcOvrMDkfxOrQ?=
 =?us-ascii?Q?8rQFkK+HYb7jqPzEDR0p4P4rS+brqG823tQg7wDdwkoWSUdswKbE5+MbEpuQ?=
 =?us-ascii?Q?5nkMWT7c5Xe8JS6pq7QKH1sm9tvuH9HZgaiekUjFpCbSu6OaRKdRV3q8QXKb?=
 =?us-ascii?Q?7SV8Uvp0CmAcIfQ6yEmlf5wcb0ESIz1+ZkMvGtS6uTthD47VCPCZFa+d42ob?=
 =?us-ascii?Q?h9TFBP1IugwvaumeTMWia1WRavzP4+fI4Vl7MconTbTfh1okUAf+1rRCoGVI?=
 =?us-ascii?Q?Y5RpfCClnX+kACpRr0X4OOL12hpRNUbSemTvcHWUurB28B3RHaPzwvXE0y5r?=
 =?us-ascii?Q?OudzNO3U1kBUpJROKp73yGSN5X4arrHekqBq1tE3AQ8Kn7Tv7wjV9FY42Q7b?=
 =?us-ascii?Q?CP/dW2i7f9EVr4IeYQ2/0dZzoDm5qZyq4MGGSh6BALE3NcXrB1xPzjKw5SoY?=
 =?us-ascii?Q?G+5zWYA900Rkh8owMrjrA7AJ4Rqk3Kd1jkOiNdS+3IQ4dUjgr6sWzrjo2UMS?=
 =?us-ascii?Q?3eP7V7wz+8SCUJfm3p99iaGlGVrKmdC1x6zXrA5L7WeZAVhTwGcjr2kPi5x1?=
 =?us-ascii?Q?tHeXEKBEwJaeTAzSkfuFv9WX74yvFTKQTNlD8BjM/GRvdiA2D0nZxcKm9yN3?=
 =?us-ascii?Q?bGT5QebfQ0bZlbs4yY3Xi7qTa05vngRgrKGpXGxW5kWM5r04TyhtDfstofkp?=
 =?us-ascii?Q?HXavZSaAT8R3c3RmYGcDfgmNmXQKmXa1GPixYA0TKZopbN+AKA0QlhbMT0zw?=
 =?us-ascii?Q?pW9d6J1XRrFZJzKN2Bgjq7Hez3dF4S5C9CmelOo26BP0tE8bVQvbI6xC+6fM?=
 =?us-ascii?Q?K7713uzt9iYbvwWC+lN/7BkaNay5FArNDPMiS/8oErtfx2fkkwto6qQnxusy?=
 =?us-ascii?Q?7h0b4vpXfroBwVSO5TywJsqSjj3Wo5DQZsoBKLqobTBKVmJj//GjJyY/MlqE?=
 =?us-ascii?Q?rGh4Zq9x4oVvKNg7hJOk3HFeWIbqUAow84OH1UXOhyRvCN8KPwgxSTttEvLx?=
 =?us-ascii?Q?5QRjvyQTSC6+oaZ3+WoI7dBTKL75A88AR5H3DclLTeZTQU5e4GJrjA9G1xiF?=
 =?us-ascii?Q?R6TTFrVjIghHnIgz/xA9kBm/WwdFcsL83PiYLUdYawFW9sZVRl1kWTzpSorl?=
 =?us-ascii?Q?aHizphKT2duOZDE652mRj9HvGOGNY8aLVmXfEsfAfnDhO0OxKkDhrGl7YcYk?=
 =?us-ascii?Q?lp1RL2nDP2uq62mytxCr9/+V5w8oAQnjJcFk8S318fjgJBsU1XZ19OGOhpSQ?=
 =?us-ascii?Q?yAL4OrELvdi2KflOYqk7ShByKhat+aHKjsf7BnYyc1WLxvC7j7t88W8xW+uG?=
 =?us-ascii?Q?ua7xINrGnSE4EE0tpk+xaleDtVmFKMXDE1nHLMmOvbiCgLSp80vYCDFocnK4?=
 =?us-ascii?Q?Q7Va/F0knF2a3T8iwM3h7y5/AVXpRcMg8jFDFqk8kguUeRXbl4DakbGboHRy?=
 =?us-ascii?Q?vWRtBeyIynAN6aDn/POu/JKnAguw4Jk8DCNBi2rC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297946a2-f151-4747-b120-08dd319c0201
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:27:07.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7jAsESCWpPVtH1BZZhBnrm2sPEMeL1E+hDZYfELTZ6x7wcVNrMjeNO13cRPwBgp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

On Tue, Jan 07, 2025 at 09:10:08AM -0800, Nicolin Chen wrote:
> Rename the file, aligning with the new eventq object.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile              | 2 +-
>  drivers/iommu/iommufd/{fault.c => eventq.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

