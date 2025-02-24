Return-Path: <linux-kselftest+bounces-27348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A681CA42261
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192DF189D74F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2013959D;
	Mon, 24 Feb 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VCK8+T99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HJTQKqQf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3251C4A;
	Mon, 24 Feb 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405778; cv=fail; b=new0FK8jC61rXANZGlpoF09w7KrB8lccdg+vvxoEhdJw2wvp/pksaqrNvXhALTAogdSCovFU6KuD46Jn7XApCSWmGnDyKucgwqJ23R/1XqMvYxT8Ws/0wnqcWYuNnRrZkrIzyjHAgpFgsWEKvhlAwacWXj5oHN5VCCbvN3EpmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405778; c=relaxed/simple;
	bh=XQnmmzZ577UxLTzZrRPpkNhesL1HM/UERwiS1B1NAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCDFv0BYNk/WOpxZBGfbdMdOj3AO+/HRvZSrOoyP8f6L24X4IkgHWatw+0XyCcNhUaD+Tk+EeGC08ViRi7RDsn88H5IR7IwMY3mqDAp6j8XMOsYUaP18s4CCoQss7Xv+FMxMK6jje9I41xPsaGgcYme/OO49NKprJEiF9jPCmF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VCK8+T99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HJTQKqQf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMYYW009988;
	Mon, 24 Feb 2025 14:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8iklp5VKfcqvhhpvWT
	2H8PC3Gih9hjfKEZJ7C9D7sak=; b=VCK8+T99ATtfpQV1RNo+TWh6cx5zRbGVDn
	4yzKc2H9EKn69AhWOFVNDQfC8PenRdn9j5Ape1NQuzeVrlMYd3a0ARtt5tyO3IwK
	ualQEsFo1MNdyRm/EtZ1yfLcjDx2tWf+5Pq6y3KNFxX+6WOQddosXxFjNIazt2TP
	m1xLgRqGdKnMCH8PyaWl6NoS1t5kDrQd/wonbuCG+dwsiBrnwKzmb8Tdy9psnv/Q
	DepcM9WUsLJfwUcLUAuie361ufdFDcdu//egqrRPdYV7vFhpoOk7uxlHCLpiKouH
	Yc7W81LT4bkVrEZe5sGFGVk5dkObgkWmCmy4a97RGOzWO++VLD5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbjm6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:02:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OD91SK024289;
	Mon, 24 Feb 2025 14:02:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517p7j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFkZvnTuDTtF+js5VDXuhQz5f80aX+qIT+DpifmvuH8xzkCafaFmv3leaK1ewfynLmHFZya8KMlBKgUk8Q+cXWUJLh5XTDYhT3HZS27oQJzJQCdsxweCtlEtgfBbl9JqVmPXc1/iOdmujJ47eFolONmFrXou1DXIdlMt4BzrbXowWQ/jBlbPrNCGsHNXUiAU7dl4SRpB/MNu2kzqdkH+//5Gf5QmuLcjr+B+TZUQ8++hEoGyv43ELchqzzreYEy/OojkSJqGgQho7SuEUjS4wNwqPW6cZ3pSnQ3f6C/i5wXt38/sniM8vJ1nJljMdUO0UnA6eJZVl0dupaxL3R0oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iklp5VKfcqvhhpvWT2H8PC3Gih9hjfKEZJ7C9D7sak=;
 b=TgcGVVLwt8MolCX/XGl5Jcz5cj/mZpegRYxBLdm1OPrBUCuH+yvO4eN5BMX6lWQl3x/oJxIN3GjI0X6FdxdDhHpvRajoDWc0xNwlZCk1i50I7qbhSFv7NWPXC7cU+dyq3h1K2F9DB+CBuCan/x0MF/4dFcd7CLH4gbmkCq+GcmSjYOFtxZlOn0wD2DSQB3HVRUSoChxk534l9Y1+exJqBkEx2dh9sJ4AhxZ3zrki5puvMgm/PSH/qDenO4jZNn3tf08QqjWYBMpUCuShKzxz0KaJvhJnkZyGQfdABIqONbzCBjSOVMgtDZq923JHr6TI7gcRecfB4G05amy5INDZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iklp5VKfcqvhhpvWT2H8PC3Gih9hjfKEZJ7C9D7sak=;
 b=HJTQKqQfmH21dsotJ3IZtG0y9ukLA2j8duViuX5fD5jce6lp9dlSlv0SVgaHRh2lV+BpNbL22AaFrId9Wl8fGSq0Lg6PdauwU+qPVQNmG1eTI0xYxCpWJrIkKhk9MxMgAUadcHhFeGMybFfajS8UwNrlDIVS9k13J0EGVqwTda0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 14:02:29 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:02:29 +0000
Date: Mon, 24 Feb 2025 14:02:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
Message-ID: <d68af630-7fda-439f-98e2-6d7381c1bff1@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c289be6-179c-49c0-3e7d-08dd54dbe06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GH7H9uyXFGHNprY4r5e/siLOOrhrF1flGAmtliIIPEXKoDPZrf8BYc15KjLH?=
 =?us-ascii?Q?m7ePb1JEL4bbEER56utYQcBTayUmTSeHxU8XWWrqjyQyPTv7k13v8ZvhjaVi?=
 =?us-ascii?Q?Z0lX3jwcVUPFFoaBFpWqhQNWb/Ie/KSGCS25M1eV3smOsDoHylQxnbCzjk+7?=
 =?us-ascii?Q?bQIMsQrdV2cqDRjGF3MqCUWEvaKuDFmBPTT7ORsrFNZnYhvjwMyaHVs4iNc1?=
 =?us-ascii?Q?WlG26DQ9vecPRv+U8C76rxa0UwI/A2wEoYPE95AoERazAakszQ6+9qQ6m/P0?=
 =?us-ascii?Q?XusTpBXlRJtKLkFgh2pWp05e8tRGiDECI8zxxXovlv8fcdCYF4b4bKbuouia?=
 =?us-ascii?Q?dBZSlyoFYbB0z7xeqXdR84TyL9eyMG0F5L4XtxxOOyWaJ4TjgkQU6BINGlty?=
 =?us-ascii?Q?TezPWZi7BqaKeB79HUaq6cUHGAye72IPZJXOH5MnPKYe0FFj2ZyKrv7WHGhi?=
 =?us-ascii?Q?/IOSOKGx7IihZV0BemHQDNcl0nlDgfc3FjwRuA2V7Bq2ytPVkMmevxqHRyGP?=
 =?us-ascii?Q?m6zfAgcijTEyobwQxg2SaqZjW9I7q0nlca6O8YMQJm+PPYJsCrtTvjS7WaOd?=
 =?us-ascii?Q?hUcEeUWT7I/5qLUvMebxUJoSWEWFJH/kYu4bFUsTPm1QU3rSIe3v1NVQL+wL?=
 =?us-ascii?Q?VkF/457JlQCj9UmD5kkIPMCj7hqOdwX9A3D8pzmlyrlfK55ZAvL1kK81DYq8?=
 =?us-ascii?Q?IOkyLPv4si05ZBaHpJSKDS23WWX9icqsXIqYW2jUjMVPfDCpF6QAkG1/iFZa?=
 =?us-ascii?Q?Ok5sBhrw4I+ptHXrpfTl2viouzJyTlSFUGxzKJB/1jkM0lHwjt1S/T4oK9RE?=
 =?us-ascii?Q?/B5hICJIirEjpvIBs68K/2B0/Nuy7NcPEJT4QgROHWAATh0exxNpkAhes6dW?=
 =?us-ascii?Q?oYmbDTrClfG7vgftFqadlYtWOD4k5LCwUF6Z6vnbAWj4OhrZeESLtNi209Vn?=
 =?us-ascii?Q?h4xrkbAlmPzukDpGA62osA6eDhrlpfC6fJf0MtKBmNQ/nRKFIkde6P6FjOqi?=
 =?us-ascii?Q?IBcrxPew2g5biOgtnmmLG+olkXmecXqf416MswVVIV2ybSTp/epFYqGETzCN?=
 =?us-ascii?Q?yLirxW1/4vBUMkPDladKZonBvQlDDOglXGk53g1Qr2a6UGT36gvggkO8eRC/?=
 =?us-ascii?Q?35W36ol8sosbn9JSsb4ISQFuiEVNMoNzT8u/chwAz8kCfSfYGYPOGuovpuSL?=
 =?us-ascii?Q?J2RNb/O1kv04FYoLYk0jxe9DH/tOoSeTZzxU2z17CxtFydMfMkbvTEgIj6A/?=
 =?us-ascii?Q?4B3NuDTrqCWpif4qJuO2cgJMhefOtz5So/vQ5r8lXZ63477D6j8oa2vLQdDy?=
 =?us-ascii?Q?JTN1IYUTO0eV4dcuAdkAC4Ii/g+7kJQIG3jnL2K9icB7mn/m7/fQL3N1BcqO?=
 =?us-ascii?Q?O4bRD0e6/KzL2tlRGVO9KyBvMjdN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nxdA7lzMGEVmhKssqDOHsQsG6iuFci/pXLfcdztwIC9jiptOAnQnUqePA+9p?=
 =?us-ascii?Q?KSnQ/2qRVrfb/lSRFGuvZmQr/BC4ahYeMhVt8rdQP71VTpsKWE17adEihWKM?=
 =?us-ascii?Q?9O0TMNKoqg7fu3MbwGiWBUBMdZ3Ink2q/0VvoCkNZ8lEtFPd6tRMauu6xxcu?=
 =?us-ascii?Q?vC+7XpVAthtiLPtYrbtz6YsWK3JUr3iNIhQHmkNzCt/XbLfQ+3PY4UyxTlkC?=
 =?us-ascii?Q?I7PstTpUCjcKhTNDgK9ILhJlR9Y8Eicn3KlVzXT/1lv2C/2Nn+8xKzFMVood?=
 =?us-ascii?Q?ECROVMbArqnSjMXAeeC2fpOBc8KjAHEVnfjjJ8q9+IN43J42cWTQ3qkKhAVf?=
 =?us-ascii?Q?sojK4RvMvgYlB7iqPScno1Oen/9mwJsp+VsLom3Fsox060XOYJrGO5DUfsYj?=
 =?us-ascii?Q?1NUmlHH3efUbXTHSRyMk9jR09IumtCjHVerB+G/f+XDhRC+fCYlWaxNeHowI?=
 =?us-ascii?Q?QJAhATrcAH7bVL31+N62g9t3RN6PXKESVK9AHnBPCnLavomfJbf0H/Xnv+TN?=
 =?us-ascii?Q?IvKCcEbf3zpPr/uWhXew3DWuqNzOI2uyEx6jUBFD3Hz8n2Zj0UTCbkVFcnzE?=
 =?us-ascii?Q?AJwQN6M+fWAeSecH2x98VBNo+So6uXkmu+7nMdwMh7fSxGc+l0SZdJ3uJCm7?=
 =?us-ascii?Q?DeuIYZf5Nuf2Ne62QJMUPSsTvZ004UFyqlEMhA2/OHGzoAYcjSJlwSgQs8Hi?=
 =?us-ascii?Q?g0D/xfx+/s5jS+n+Npx/DgxEg5Jx2tA8LDaaARd6PgZqpZ0yb4gwIAIbtqa5?=
 =?us-ascii?Q?OwerxBuZk3GuuJWFAk69yzxsxpgB+83umDsJlZrDtz8fiT1wCkjN+qtwUD1v?=
 =?us-ascii?Q?qxI35IiAzBRzhmPWlbWcnN4jwM6aV/ehDBSiQRGKSJW7QARqfhUOEyWI+z1m?=
 =?us-ascii?Q?r8CDXn6eFZChlIc3byCGScg1iodN0mLnE6MQvC8oirpmOKxUafZmL0xaWEwv?=
 =?us-ascii?Q?ePz3VYun3bsY2bqPcAfjXJQUq4Ezt1xbf8a3z10n1nqUC2BJ6a4D2LQIy8i0?=
 =?us-ascii?Q?cjRT0IiOhYZaXgiRHY3RV0aV9gVqMZp+XsSTZXYKweq1Nk94/N7UmGSUNC0u?=
 =?us-ascii?Q?0pPD2t9gIaUScWK9OCKPc9L/uoaWZ/ilk7EUKn9E0RNNyhmwLqcPjDKWdVFv?=
 =?us-ascii?Q?gpvQWjOzz8N+8HDb5/h+hKdlD20K37BwtAHUIOwaR7nR4cl/m4fFii/ubYPB?=
 =?us-ascii?Q?9xzEVwzzj5ZbjIqIiMC5iiKU9cXlVyVeaTaXTBzGSsthEoxOF5kdE2wH7keU?=
 =?us-ascii?Q?T4tQGOBeRefoMtlawoKCH7lHfcNrfqKOA10RXx8SqBBSTXpoGiBbPqWVceGJ?=
 =?us-ascii?Q?uJvoL4hBv/pITyZALIX8Z7Wr5Udblf9/bLZXxDr6bsk5vn0ElKHYWwtqobke?=
 =?us-ascii?Q?JGbBoLI4iSk1niYPyMUxCbpd1vsRix8eltAkQBBsXMB8XmYElH+Nm17re32p?=
 =?us-ascii?Q?DZ72Af4DdfAv+tIRdEIHSdQqUnRlUC5Dg07UtZ50wT7TEa/vfN5U9mVqpMnp?=
 =?us-ascii?Q?MclU6cguhXJb4gDz9ZQYhLEvov6Czq49J8Dkn56I9LT8UpqVQ/Z3H8yyzOuh?=
 =?us-ascii?Q?nciR0n5pAKoc7nsDVufOrQpI1kXB14M2tqjrwMchxYEWP6JXv0rCHFwXW+bd?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pZ8owOKvl57d6BrnKOkJllnYyFJe0EKjIvwwcHVNn2DOwqExRN06c2u5CnYfm4sZnHV/c93YHYtP3qX7h4IJr/hrOdEQMGbKMvp+6tCY7AEisHJoIONZQDmUh6BH1CQVUNKrr2zzObhF4yqTzDrIzsP5acyL9u1KITB2PemAP6heQK2KtBXhx8z4ufO56Xd8+nMvkoyD+R5KdEefnbG5TzVwRfRnTV880SWTMciqINv+sJBpICK0h1WGShG7sVm5fH7FTTgy4TkTrqrby4mswnUCG54gAaQ/2vk3oEWRi3D6/aVBZtTcW2r9sKWvIS/Wg1wVAzipOLP3yv33ktkvsuRQh5/rzVdwtmGT/cvX3WD+L8gbvro+gWfAxarmm3bnxeHO3QMRXCL6EURdf9MG4qDGOQThJq/mva5PMmK12CBbz3Fwa49uHGfnQgMnJVHBCsnrLLVkx4jQCrlHHlYuo49oLdZ9cGQvgJ5n7x9oRNiSqL8jh3WtFoN2Li/5UMNNAlSHyDbOVeoDXMmX9cZdp3Hxrs7pnBQ1uMvyvydGasM9tM+Fn377/X4Y3Yppsm70oONOk3bUwR5kU2X5u6mGZZVGI1rDqkw9V0Jbua+MGos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c289be6-179c-49c0-3e7d-08dd54dbe06d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:02:29.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBSFT7psttYuWEp6nY374ajXYhwYzzrpiNfMpEJFCu+QAk6RNxSlmJ/436d/q7trOw7JF1MynfKjirnQZs8GoxmvmL3/jrkmZTAVHWNWQFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240101
X-Proofpoint-ORIG-GUID: 2sDLCOuw0pL9Rc3KYRsxqfZIymBg28MT
X-Proofpoint-GUID: 2sDLCOuw0pL9Rc3KYRsxqfZIymBg28MT

One thing to note with this series is that it now implies file-backed VMAs
which install guard regions will now have an anon_vma installed if not
already present (i.e. if not post-CoW MAP_PRIVATE).

I have audited kernel source for instances of vma->anon_vma checks and
found nowhere where this would be problematic for pure file-backed mappings.

I also discussed (off-list) with Matthew who confirmed he can't see any
issue with this.

In effect, we treat these VMAs as if they are MAP_PRIVATE, only with 0
CoW'd pages. As a result, the rmap never has a reason to reference the
anon_vma from folios at any point and thus no unexpected or weird behaviour
results.

The anon_vma logic tries to avoid unnecessary anon_vma propagation on fork
so we ought to at least minimise overhead.

However, this is still overhead, and unwelcome overhead.

The whole reason we do this (in madvise_guard_install()) is to ensure that
fork _copies page tables_. Otherwise, in vma_needs_copy(), nothing will
indicate that we should do so.

This was already an unpleasant thing to have to do, but without a new VMA
flag we really have no reasonable means of ensuring this happens.

Going forward, I intend to add a new VMA flag, VM_MAYBE_GUARDED or
something like this.

This would have specific behaviour - for the purposes of merging, it would
be ignored. However on both split and merge, it will be propagated. It is
therefore 'sticky'.

This is to avoid having to traverse page tables to determine which parts of
a VMA contain guard regions and of course to maintain the desirable
qualities of guard regions - the lack of VMA propagation (+ thus slab
allocations of VMAs).

Adding this flag and adjusting vma_needs_copy() to reference it would
resolve the issue.

However :) we have a VMA flag space issue, so it'd render this a 64-bit
feature only.

Having discussed with Matthew a plan by which to perhaps extend available
flags for 32-bit we may going forward be able to avoid this. But this may
be a longer term project.

In the meantime, we'd have to resort to the anon_vma hack for 32-bit, using
the flag for 64-bit. The issue with this however is if we do then intend to
allow the flag to enable /proc/$pid/maps visibility (something this could
allow), it would also end up being 64-bit only which would be a pity.

Regardless - I wanted to highlight this behaviour as it is perhaps somewhat
surprising.

On Thu, Feb 13, 2025 at 06:17:00PM +0000, Lorenzo Stoakes wrote:
> There is no reason to disallow guard regions in file-backed mappings -
> readahead and fault-around both function correctly in the presence of PTE
> markers, equally other operations relating to memory-mapped files function
> correctly.
>
> Additionally, read-only mappings if introducing guard-regions, only
> restrict the mapping further, which means there is no violation of any
> access rights by permitting this to be so.
>
> Removing this restriction allows for read-only mapped files (such as
> executable files) correctly which would otherwise not be permitted.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/madvise.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6ecead476a80..e01e93e179a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
>  	if (!allow_locked)
>  		disallowed |= VM_LOCKED;
>
> -	if (!vma_is_anonymous(vma))
> -		return false;
> -
> -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> -		return false;
> -
> -	return true;
> +	return !(vma->vm_flags & disallowed);
>  }
>
>  static bool is_guard_pte_marker(pte_t ptent)
> --
> 2.48.1
>

