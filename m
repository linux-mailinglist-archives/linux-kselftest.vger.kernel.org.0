Return-Path: <linux-kselftest+bounces-34393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EDACF5A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3062E7A16A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D42749E3;
	Thu,  5 Jun 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cv4T1tSC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PRqm/fFT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331618CC15;
	Thu,  5 Jun 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145666; cv=fail; b=FcXemvOP4R7VbQmwHvuh3wLrDcXGDQk0dxLWAXTKZkESqNpqZJpPAU7Gx3vEus2bWKMhgOc5Yk8wpwJXXiRuGiZNSudLuFacdzfcYRzfSQxHP7hC/9t4NEH9MooQNzOaOyWuam3WbdIcWVKaAYyEvUg0SOUHjiBtMJKbXlKSeUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145666; c=relaxed/simple;
	bh=6nE5WW75fE880BXKK8/9Fa55tWj5+2Qje3e2A564eZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6pcF/h8SAdojiab2VsiHMY6/M7m/f1LFIpvEZ2Z+Y9fdquwg9aiuAk92fxwEu2CQwY/3Zw+h6OyyEX6nINZs8lov4plaZP0PJWFFeI6F2YyOzKj3B1JuysvT2jW2T/xcHSzk50alutzHfL/4kgwqvrnNc8WnlvqTil9Y2QFLcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cv4T1tSC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PRqm/fFT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtYR0030873;
	Thu, 5 Jun 2025 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IukOWAANo6J2/XBj5E
	6545ANZQmUnyEp5a5xcG7pMV4=; b=Cv4T1tSCPTnERa5PQam9iwPLHtfLKb9y9a
	x+l59EJwGFcwDPfGfe02kXQLVLBBYA7pIJMcQst5C5ON07CsPiuPn1U44rIEE5ac
	3+yE4AnkKXhA1eKOVDT+ol+VlJL6A7t8ZTlDUgW8I4dnikReHB1VnvTLoLXGXfBr
	LhFVX1y+wl14cKmAXWqwz/HAanu16bc6dN8IyYZuTs/kgla4mLEvG+46G/XIRnfS
	fBckDZk8IKgE0Lwocixyl153jOXTU2gTl2LI+PGPaSeLDK9JrxLudXSOoqsT3rte
	7vFFbM6hwOhx6Ow34dSzE3VHACbHLtugUWvi5T8ivxsUgUtFyulg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhefvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 17:47:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555HUGne016167;
	Thu, 5 Jun 2025 17:47:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7ccha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 17:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx7RzH4O/1nWAit892OhoBtpkCmT/Ayi7aP9Keit75pML180Zd5Njqju0944rCU+bvS1V3QoCpSpCnlO5j9JVyTu6kLxzE2Slvou0OXDt3z4YnzrvKwSvo4V5M4A1+xFbBXto/160N5UGhtMfJWxCa298qqNaqegS2/0LTlJVdTL8qKschMQ8S4kG6u2IIDzbMCncEVuYai4TIrNAmU3emVT1IqC0JKFBL2IJmPw3QeLXDBgnTPCbDCDx/VARPb9SKZY83u0EvZYsZe2jFTNG9/MbYow8XPhkELW4FrXv6TRnhAjRm3ss/b/s9JmlutKw6/53uXxIBtoVzK+TUinzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IukOWAANo6J2/XBj5E6545ANZQmUnyEp5a5xcG7pMV4=;
 b=o5fmxtWWc6wUNtChxnbcyTzsQST/5IvEvI4KLwcy7twIZeI+T6FyYJ5o5KqDpxTzDlQiMEPbD5iMibJiOelBlNHlGo+1HKRGhbNC4XZoJD1YMM/ZCKxFrHJZKZPExbgcnO+Oc2qBgjZctUqxt3nJ89TyVpMMYfYVm0YichxHkreeOZNTPztMIcUvJ89Z8jb/W8sfImbMH3DAO333evZdDkRTIiDS8yDhc5eJcH+pIQ745ybXO6yVMgc2FwPpGfxLSZTAfoDHEg3G+z3JFJzBWtb90AKIWPS2ToCZD7tcNt/Gr0e7Eq785Ck/JtHghhgc2rZgUBMwgBn+1ZGo/OpcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IukOWAANo6J2/XBj5E6545ANZQmUnyEp5a5xcG7pMV4=;
 b=PRqm/fFTgEBDtTuNCudSNAFC1lm+N0yWMPqW6Ta1VYQ6FN1NgBZW9FJXrnHKGsSY4mJ0RKsTOdUifO6XPhgjUceoP6H9QvlcyeOR2O6SNl5bqWroeJG4eKuDr0RDh+NFnMx8npQZ3n7pNiQfsR9QoRlp7AkM1JqJKzoayY+bOkQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6023.namprd10.prod.outlook.com (2603:10b6:930:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 17:47:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 17:47:31 +0000
Date: Thu, 5 Jun 2025 18:47:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <ab2e1fc5-a0bc-4694-9449-adf85b96b38f@lucifer.local>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
 <961a62b0-d0d3-40db-8008-61c634172ca6@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961a62b0-d0d3-40db-8008-61c634172ca6@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 39acbd7a-e4e5-4a04-11dd-08dda4590bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bUzRDzvQQOjXvtkT4bjomg5IWd9YI1719sB0KfPcug4wFuNbvn2++wbFr98w?=
 =?us-ascii?Q?ivyVnttGNUVM7QoIcdMmBSKGNDp7Fpe1LmgVqziJ+27Tw9PnoO8S4e1DJipq?=
 =?us-ascii?Q?WGfrraf6RMnQHtgegXGrRUQXRoQQsuEMGTVspnX504/lqiBf69jXjVigfQx2?=
 =?us-ascii?Q?Hh/yu4pm6W6CIk3L83HWfr2G7RsTUTulSP5xX0kZ8ANjt3ZJVOWq54sDwoNt?=
 =?us-ascii?Q?/kJ/n840AE/H7Ns1aTzB6rsCssd9yehUaU1TG8KtnKXzN1kPdFAU28inJuKc?=
 =?us-ascii?Q?ZoZfvvKVp1c6sDNMarESTgoJEYwp8kLvc4sRagBR9HEk7ixdiS6QoVwvjKWm?=
 =?us-ascii?Q?DITcMNURqaMW+cgFppkm5pmG7zELGnBu8IeHKZITJWF2tUZ5TYwuGR0ch/gR?=
 =?us-ascii?Q?MkUHETr3gqVG2Z3OpTTTVrqKZWZykFguSjDQFs7QSykcoTKIZ69TFV64IIHq?=
 =?us-ascii?Q?LKX5JTaRvahz+1pzxgsggWxIK6uyVl4F39lkFHl0IFC5uqnhU4DbaRzEhmEe?=
 =?us-ascii?Q?xSUGwi/pnXM4HLwmZVRlg3i3m9KR8phaHNzT4/KEDrGgrRN+6Bawqt71BIyM?=
 =?us-ascii?Q?oTVvzAT4cvp31UQ0G2NRRDfKRHaeY/vCWnw5aFWRIKiWgLVkuSBoy5FG72nw?=
 =?us-ascii?Q?fFh9r15GCoZN6hRsaGfLjPiey8tyLFeLgGv3ttkOn2iU92ZPpgivLYaYAOrV?=
 =?us-ascii?Q?FrhbGfYARAA6E7gIAuw8NaXHI+nrmWa6uNtRjiwAURXtx/XqbrLFR/3wM/h/?=
 =?us-ascii?Q?sYzdjtpjnD7Zwn5lcyjkFKh7AFy1aukg/u7a1H3JzsGmEV72OcVWyaadRayK?=
 =?us-ascii?Q?w+wpITO3vtfr8TmQ8tXpGxviDh+Ks8iPFPHiitWX5lukVDBDKBvFdfHmGevX?=
 =?us-ascii?Q?/nM3LeWfnihlZXSbmg/eDOXM+LCjARBi6PZ2HLy1nxuEDI+HIeVH0rvI6FA4?=
 =?us-ascii?Q?6IfMskzPgON2UDYau/3XCtijIpHta7Q2eCsd/9ABm/ifsML/Vquxm008xHDn?=
 =?us-ascii?Q?Clr5jvOc3KXu9WW9iWD8bmf3G6nMUs6TWbg2N27qnMqAYPsyox2ohhB0uFsc?=
 =?us-ascii?Q?QQvF8YN1QOTQSB1Ua1a1Ms6q30fq9cTT0YPCtKoV3tQ5bm9LPfAV4UA24EKn?=
 =?us-ascii?Q?KJ7njYqWv4mIv/2VZFcdKiG/UmLqAbFx02CG2Pxl5ltO1sqD9SWWejwB+CSc?=
 =?us-ascii?Q?W1Lto8SnASGjYw+MXMGjiYHCdZHu6nF7R/zAG2swIOtSWtqXRmhRd9USf3gu?=
 =?us-ascii?Q?h2QWABOZLFnvVxIkAzHOFzTPsQpjIH8FyzoVCu1QiM7FyTUzQUfvxmPriABB?=
 =?us-ascii?Q?R8Wm3E7AOPUYsGoexnx1eV73xKGDrHM40pOt2JYiLxBpWcS8gl/j87hCwGCq?=
 =?us-ascii?Q?9ulhTOyC2ZC5mwUJL9M6ZRJFo9kKpINtl2/mzlRchVIqmU0HguBYG4KvsIzj?=
 =?us-ascii?Q?rXs8v5liivQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5X7erWTdSBv4e/f8irBIrVSN/J37gNm59pxWz0aNa6wXPVif0IbmUp5r/Qp?=
 =?us-ascii?Q?CZioXtp10vdIkhOkRC55EbFzbABAMQSxuzpZEToyp8sIiTQ/13xWGDoIPJ52?=
 =?us-ascii?Q?PQqN57kAHRcGehqVws2dRbSjGV3qvE9L3w2xUb70SMf6TNx/ponqAb3zHtUO?=
 =?us-ascii?Q?YndcbgK17qxiY1DSDCRynpX4nYjS05+KujO43dF4cV/Y63zDHblSYw5BhUd7?=
 =?us-ascii?Q?ZHFfZcEAUt6Rlb/vGWTGKH2d3JoJSC8fRvGNGq8cw/UmZ6IIYDsjZ3gVZBmP?=
 =?us-ascii?Q?QbdjzPyPtwjvACbIPzidaHQfKCipQB7seTLWhnaNF7MKWjygLGAg3BCR4vwa?=
 =?us-ascii?Q?OVGcDktaouhQZtJjYXMgDvAb0CHJKnttdF9Ghwv+OdyKFsWCmhchg5Fr4grF?=
 =?us-ascii?Q?THcC5HoSsqRkzfewBDtdjEjQEV7FMMQ4cr5mWkoEZEwJSF+9PFtKAivEPXJ6?=
 =?us-ascii?Q?tGXZTCDLmFleEdzX7Y8VBgJHk2XCc80D9kO+AOj6TN0EyAOKiM0VwmThwFP1?=
 =?us-ascii?Q?DBxnSVg1F4dCOJeM3tUl/X5BMEX0Dh8sXjq7IiRTz91ZiXpCT/WkoPrX18f8?=
 =?us-ascii?Q?Zj7X2BJsPjxs61kJb1TdBFnfAT0X1xqTcg5vdiQb5jBzzFK/1MPu8TxCNOSi?=
 =?us-ascii?Q?zRLAPM1zDqxDxiU+beekTN8114mFRyGjcaBdBWF4OLdP89e65SvmMcK8C9H8?=
 =?us-ascii?Q?ORJdosNqamMqNjgDH/6sSvzXn/1ueGn+6KnzAZJhiyOQ+TfPOyJsonk0StwC?=
 =?us-ascii?Q?+lvxdh9wcSLU6uONV8UbKmrXLRAB7Qi1hxjv3xKVNVthzwlCRxf5ARK4jjvH?=
 =?us-ascii?Q?KzR8RVyNoCp2M57H3+OBBF3UtxaQjbC5yxlcHj4VfyF7mVYSah+wewhbf6Ru?=
 =?us-ascii?Q?aMlGLD7Mgk+FnNl5LO4NYgVqmhVpdiNrA9jaf7yL8CSXaCJs0dpDAkRIDUP0?=
 =?us-ascii?Q?C1vcg5SorqnxKtNDXYEbMNUl5bUyTegY29Vi51Sd13oIcPKKvuulv7qNIkSR?=
 =?us-ascii?Q?FuFn89qfbGA0JF31DSbrGUVBm4+uNabBHXrSCFO3ITfK/sG6mVMz4Xqdc6nr?=
 =?us-ascii?Q?yzkgkGUqqJXn+5tGp3exYV0nm0wuNmBlVaHjnK4CIKKYayJWXgzA4MBOGZ1h?=
 =?us-ascii?Q?LSjZl1xoWN5p+rCtPQajk6wGgeOuiiX6zsMdZUPh9eRAz6491UCHVnYxs2sQ?=
 =?us-ascii?Q?1kgUN4Sf+434rYzOcSLYvXIqPUasNvxcacpzaMqeKPxbLLs4T9W4pXIm36d3?=
 =?us-ascii?Q?wmAfP1Gsr1TrQSd1Fxdrl6fFwYPEV9B6HDXKBI3uK+hV4qkWVSz5LcngSBwe?=
 =?us-ascii?Q?M61bxbwYB54iORkau50+NALLTgJZUTRBwp2jn8c5usJ+gEFhQRs/3yO255EY?=
 =?us-ascii?Q?JjrFv7Lpz1Q3e1lD8wx0/q3j6wZbjy21MynaXj/xySyiljEk8WMoY1QCI3/7?=
 =?us-ascii?Q?tqINnpphHWoMBnL98Sm5IZjeQrQsmXpiVitvU0ewd94bb23jJRNijy4dSgXM?=
 =?us-ascii?Q?W/E7nVPDexkyqPll6jwF2aAqdNOY3TVe4n+3N58z8Zj0rjPsriIL11PCw6M0?=
 =?us-ascii?Q?A32Kx5bkgUpGiofPgcyt2Lu//bb+lOE1EedbBrU+AjFbEP7XpzZAsqgH04nx?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p1tdLPmduXAMdtS2a/E6inrPuF0Cw4T5pQy0rI1IBNWnyM6k2gX0v0PcRdoBldSl66XxuCNsWXyTyPHSFaxreYHMsbtL2I/qsbhvYPXOAFl9Jwy06QBtIM1cw/bD4y+cPuP5RTN5d2+Jmn8gIetU7uftqZqLoNKI+NuRxo4UjpKsrZHUaIEjxC/CL/VMC6DGxm4OzZnK4PyoMcj3EB5OeT7Tf9MuihsyMzqybvUXdwvciw+oUrqpruRTJqbaMSweEBc27vt6hMC4VYSghrNv9a7Fz4XpDq29HqoHWF9R+69fTzarVCkDuTzFibeZAfRrGIrKm1kZZnq+X/5UmPHY620yHZpgUGFJu4wnMgU2ijIaRvs+4tbhp3LeQzjvWAUAogQ9QvR8gi822ZQZA6KBVsPwrJRtBk5zELioA5Juc59d3cTTU8nau7nSqQF+8M2Ury6l92Ov+1ZIK/FENp4AN0vmGv4CQsnsInDnUmf+i1iAODSOOE1xGdEJY1a+QcfQ3z9NkaCzE+taBPbIx8GxEoJcKtrvMn538rkOcuCLMSmlBUmEa1m0l4ZA2BP5v0PYV+gxq9VwUFfqIn8O7y5Qd+0Ds4i0BQ93Rg8ppRnQhKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39acbd7a-e4e5-4a04-11dd-08dda4590bcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 17:47:31.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMQ8CsAnqhe2gPDsvY7E18vkfUNcgp/peuTeTxJ+o7g+Z6z9v1XEPiMPHmU0rfbfb24H5MUnAHflQ6phAot+6P/eyW0ldkhIKPRHKYGTNSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050157
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=6841d836 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=fVy8VeZ536HuoVpoChUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: w-kC-Ez09LumJIgN1M5SCubOJh3Mt5QW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1NyBTYWx0ZWRfX5B7oU3PH6q5S B1UWHyEW7dNewSAtqTPW2WQQBkZ69iPml9i0EW7fSSuTmd4RX9ndYVSAULDRisb3Jz9aPU93fUe jwo+0VENK6Pm5K7qZyRxIRcp+t8260zlhyXopHV0r41LXSKOvN/JAGc8Ny2iK1wVZe16ZxEwQzb
 mAP/RPy6RRrJf0oSsAuJWacU/60s8Z9xIo3KElJ4XvGGunqh/oK+WWDa+RzvChhp+deIafPJseC TDzDI+4savrG9RmXKb4jiDiCIp1SH1yGafuUjTxvrcrxolaZBEiuh19NZPshwANAS30SZrnZE33 qhI/DkgaFdWRtZecrMpJp4ovuzUmuTPMmvwo1sehOPnzEAs3TqcEKDjXI1VcZlN6IgdscUSeBPe
 Pv7z7UHqsxQ/lpT7nrM+gqdtJ329N+H3wtLvKD55GcLmcLznUqQzCV693+X3GqzybBuDYfY+
X-Proofpoint-ORIG-GUID: w-kC-Ez09LumJIgN1M5SCubOJh3Mt5QW

Mark, I'm not finding this productive.

Bottom line is you've broken the tests, please fix them or if you're not
willing to I'll send a fix.

Thanks.

On Thu, Jun 05, 2025 at 06:38:36PM +0100, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 06:09:09PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Jun 05, 2025 at 05:42:55PM +0100, Mark Brown wrote:
>
> > > > Better to do all of these formating fixes and maintain the _same behaviour_ then
> > > > separately tackle whether or not we should skip.
>
> > > I'm confused, that's generally the opposite of the standard advice for
> > > the kernel - usually it's fixes first, then deal with anything cosmetic
> > > or new?
>
> > I mean the crux is that the 'cosmetic' changes also included a 'this might
> > break things' change.
>
> No, the cosmetic changes are separate.  I'm just saying I have a small
> bunch of stuff based on David's feedback to send out after the merge
> window.
>
> > I'm saying do the cosmetic things in _isolation_, or fix the brokenness
> > before doing the whole lot.
>
> Some subsystems will complain if you send anything that isn't urgent
> during the merge window, this looked more like an "I suppose you could
> configure the kernel that way" problem than a "people will routinely run
> into this" one, I was expecting it (or something) to go in as a fix but
> that it was safer to wait for -rc1 to send.
>
> > > > Obviously the better option would be to somehow determine if hugetlb is
> > > > available in advance (of course, theoretically somebody could come in and
> > > > reserve pages but that's not veyr likely).
>
> > > The tests do enumerate the set of available hugepage sizes at runtime
> > > (see the loop in run_test_case()) but detect_hugetlb_page_sizes() just
> > > looks in /sys/kernel/mm/hugepages/ for subdirectories and doesn't look
> > > inside those directories to see if there are actually any huge pages
> > > available for the huge page sizes advertised.  There's probably utility
> > > in at least a version of that function that checks.
>
> > Right yes, I mean obviously this whole thing is a mess already that's not
> > your fault, and ideally we'd have some general way of looking this up
> > across _all_ tests and just switch things on/off accordingly.
>
> That is at least library code so it'd get the three tests that use it,
> though possibly one of them actually wants the current behaviour for
> some reason?
>
> > There's a whole Pandora's box about what the tests should assume/not and
> > yeah. Anyway. Maybe leave it closed for now :)
>
> It's separate, yeah.  It'd also be good to document what you need to
> enable all the tests somewhere as well - there's the config fragment
> already which is good, but you also at least need a bunch of command
> line options to set up huge pages and enable secretmem.

