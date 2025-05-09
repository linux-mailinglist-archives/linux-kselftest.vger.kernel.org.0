Return-Path: <linux-kselftest+bounces-32740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE8AB0F96
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52279E1C95
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB528D8E9;
	Fri,  9 May 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="luU4dwSH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g6Gafqxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F3266B44;
	Fri,  9 May 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784208; cv=fail; b=H4u023LbxeV0v7c/ZqTR2qJlJdsq0gNBqqDkO7ttggfcS7HvKPVPA4OVOO4l/IaWxlJS/lgN2433zPoKSg/XBkMC/cp2uGVFYulsaGDZ75VNeEXsCD6ClqJSpKIWGzxH5qFVgZNnYIObmt0fFWRl2sJJyfWNbLmdvZqRUZxVHk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784208; c=relaxed/simple;
	bh=ZlOpNudmh+wTsu/9F8o5Gw3ZvzTXe9fHLkguoXxAmyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKu+3xJ1ylt7Mliq7v/qqq/+Ozm8tN3CJnk+sjW89GBgCpNXFAa/8L4D/gr2gvFJUSPVVZFAixAW0FrOtqDllagE42vA6rSuTKO8QVse0UGj+RuWx0h+d6dfKv6rftglUgc/xN8BE3zMgFizZpnKiGz4bhof9VXFAc3GQdYprlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=luU4dwSH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g6Gafqxr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5497HM5B020350;
	Fri, 9 May 2025 09:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=25M2tsrgJgseZksx6/
	2NafIUAN/DXDB2FcGWYlJEjXI=; b=luU4dwSH7nJw1ha81TPchD8QWRH00ybwIk
	c8tuUeNECfah3zQAQGtD4Y5TmMDZcdEGt4ofLwuq09tZiSVQMD54TnXMAN5Zo2GF
	lA8kdvRY59SSp5z0P5Y0qv9J8J8ufoL2fv4v9FFgmh4eENK3U2rDbLAZHAgEgEsj
	AxM+e3AATsvNovkw6SKM/NqbzvDTJOUFBjqnpZt2ArZ/N/j6eIquiHKHmiGBQ8qG
	i/0Q9oICDk5gLr8vwsxIu2sUZQ1OYg6XfI3XgZeaoJLDqabcLSDhQ1FrKppBozik
	R9+bDVMjvR8FeCWgfK/ReZn0ZXm7o88UDKp5zWPg5s0W55yX5PDw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hd658bf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 09:49:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5499kR4W036027;
	Fri, 9 May 2025 09:49:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdhwpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 09:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+F3Mp44K/r5VtaO7eiZ57oOu+iFf7Qyn5yZQ+1A1CRKI5C/p6h9g5MSfOmNVAGo8a6zMHq/E222wJgT37vbmAqqBgkzbVU8eyt0usRRI0inYmEu32fITTRdW4Cy5rQFoYhFDWQ8ZKoQkk6cEn+2cyVIRP2j4gsdWfCBWqS6nIKiBodLyj/jUDjbVh90tRtPstcPnpkIu/B0/mGv1iyTGgWqAowU1PZGfKPECzYNy7aEWNvy5yIYq8MEhbRXbAl9hJS/Ob/LMPvL2XDhujXJJOpJcyWr4m8YfZ/UphxMAvmHvDo8fh500jfYNVgIn2GA4cFNDvqkRAVhaGhUoXkTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25M2tsrgJgseZksx6/2NafIUAN/DXDB2FcGWYlJEjXI=;
 b=nMGbG9BmGqDFhsqmL1mpnPIFmQCfqUXynSbn0epi1N63lGg+tt/vnPypKeEa+BzZJzgC00EcKPxHAfwXt+pLygaIDs6Z1bk5tpnKSTRf/dPfDF2FWv2zsBofLrZ2GIPLI1XIEgkfYUSLWaUKt0Enfx9YLLyWb+4ziVYOWK+K2K+3ClQOyeVy1E5PbmQx4nuiTaVg/bFoVEvEO0tpKOHKaauZs41jFQe2qPn39wHPRs5AcCgNOuzpp8oxXq3b2bRTdBSwYUJW2enk0i/UbkXVEvvg49q4OwoFL44at6AZT18WnyVORXANc+OpZ+naZ+Ryk0+oh8dRBERxgS8VFVE6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25M2tsrgJgseZksx6/2NafIUAN/DXDB2FcGWYlJEjXI=;
 b=g6GafqxrFUMHNYCHdkyAhqYpHpelV1YqZRLU9L0P3GUvd/Bh/bPrKT7eFZcvn7tSCa7s/ry+BRLR/aoBJAFx+0tKYA6H5hu0OL1SP5hENv3sDc8QmQiW+wrdcwQvRZnIr6g1D6B0KzjEKaE5LI5jeZnamz4EuijarDfxzVyU1yg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 09:49:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 09:49:50 +0000
Date: Fri, 9 May 2025 10:49:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Message-ID: <8c94faf4-9af9-4d43-a597-6b06dd21be95@lucifer.local>
References: <20250508222041.1647645-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508222041.1647645-1-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: f4facf4a-8efb-4461-b991-08dd8eded73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epHYebHpBIEGj98NfOjPXztWy6KTu7v/Ht4Ndo7vqChZcm9UHQhEgQn4LCBU?=
 =?us-ascii?Q?fsO+ZF8jpuWZ7pN2aQ0eqBsyegx6hZ182d3bndKrGH9fVeAVb+9LVR3lZcUT?=
 =?us-ascii?Q?wV20vJq6I6zreA0BHv+IkbV5NsLRKpzDiDqRcnE1YWr9x/t4VFM2wWkAMcsV?=
 =?us-ascii?Q?A2HkfpDIz1Z4iwfiPB8zMopvia21vru88+1mt9Vj6zNEBn+tbW1Ylo1XlXgy?=
 =?us-ascii?Q?dsKNV2QOqQ7v4KQOBDjUrZ9mW2waxJOPjmLGZAmx91rr9kNm8WAPoZy7+ag8?=
 =?us-ascii?Q?cu53sZd8SzXV1kN42ECNbOUK+yhDB/ZSqehN8jS774mfk5fK28aH07NdMMUp?=
 =?us-ascii?Q?08nVtBtwZ6FA/P+Yx0rBsLcspgKsHfKg+fuoNv6IotTgOngp+3Wq2sOBl7nM?=
 =?us-ascii?Q?4AmIz8AADwuHMp+KCj+B/uowwUTbVcsQQvHP4pS6jeRi7b7ILg+BJjd7AL6+?=
 =?us-ascii?Q?rT9855miJ9l2LCE8wGY6MzCbIFnZE2wPbBbMj8xKdV7yCgyE9w/h6ARaRj5P?=
 =?us-ascii?Q?JWlqNAlg6nr1/h8aZt2MS+Iixmx3F7fwdJfRHoNM4nvq8eCRE8Ns4IK0q2s0?=
 =?us-ascii?Q?nPddzfJcJ+nBHrPd8kxOF713PNl3IhU2IAaYB/6RRizcuRe6CdBM0hq+qKJJ?=
 =?us-ascii?Q?YCaHlLlrAi8bVuYpsTcB2OrrYrH+QuZ/QV6ShPM1exW/2PhxXFVPvnbwBL28?=
 =?us-ascii?Q?lMEugzX733G09eq/uprgbNuPR75CyTSweT6hywIIlMrvnIn3Q2xrQgGO2Iw2?=
 =?us-ascii?Q?lLTEFbQNvXP3G/Ioiq76ybuIv8vNuJXPu9KcI9jeLpR8rmn2IKZJUzHiK+ob?=
 =?us-ascii?Q?H8Bn+47k+Lm1uTke+1Q3HIvmdIUVDm07JbnxAnkpluS4+7n4+aVx0RAN/NSD?=
 =?us-ascii?Q?7CfTF5dmjm+o5d9EsqQ7EJDnxJCqEI8RoW7G12jMLiwexquX4/fgm1V4aoWc?=
 =?us-ascii?Q?T5bv/I+P3pR63hg+/mo6i/tH16oKUu/vIDJa+99L81Dt1S2d1eZqNJ/1Ob9a?=
 =?us-ascii?Q?B091s6zpWvlV7aNsjyoDaowGnj8wj9kQcy5saxRAkVdxrWkgAt7x7FTCEruL?=
 =?us-ascii?Q?kz/Pwj+bUXCuuYnked6P9EtclQ3LSIHscEQQFY6WAEkltItGBZAymFMuY2pE?=
 =?us-ascii?Q?OIplKfekTx6W6rX3E2BaTKt13Oqd+vWBXTjB1UgKEfPeHzXaSI7YFAiErrOF?=
 =?us-ascii?Q?eonAOIAwn1njoI9MMchfisGIrNmkSHDeXJ58ZEu9j4XsB5TaNuoTvZhsdIhg?=
 =?us-ascii?Q?PXN6f7JeNVBQ1Zgsx4Eee1183Z2fcuPUdusE4G7kCmAqW/rst9RT5ij0HUfk?=
 =?us-ascii?Q?cp057dRvJx1cumtTuKWShpwoSNPBlGvtSEjOC9lSsTD3IfvSDky9ktOpkrZN?=
 =?us-ascii?Q?9i3btOXZdPcULDNL1uCsea9cE6veYbwTFpNcrWeZva/ali2stqlQJOgDx1Xi?=
 =?us-ascii?Q?bk2e/uGC08s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RA3owepZom8oXBxOFndFO11mxHz4BX0mdUUNXZ1RHPVwasSFB2hBXPjhsOq8?=
 =?us-ascii?Q?wBQxpHVLyW3i20MAcT46LA7YIuEh42ryoy0F2NSWKTrZkiZyEgWZQK0igPmB?=
 =?us-ascii?Q?7F9HpvUDs/weVXqmWkoyeCHaZu1vwkFsLpl2G6oVM1PbgcsNUZwdzk+IRFCT?=
 =?us-ascii?Q?GNi6njxJFX4Ctu3NbfMbyQGhdg8EZFbigzGmqH3a5JF6Go5TgDo1t4bwqoH4?=
 =?us-ascii?Q?x/Wk6wrZJ4vMObDuRQO4LsFAqv3ZbicgPHDaChecqNz66YDcVBjE9PHdUZgk?=
 =?us-ascii?Q?+D+3cM6GVv0MdtcC6F/qjlM7jWYeHhzpSQqF2SoiC/hpP6YHFuhZYKG2zyhx?=
 =?us-ascii?Q?Jy/rOpIAX3rpeSV5ODtlazSL8OYrPzuQCrPXI5zx0/8nKq01vxBt1k/E631Z?=
 =?us-ascii?Q?WIW2ajNY5AUduBk0qVvZ/kuunMIqBmSOsH1TZyC0DxNIxIBOSdtmjmnJq7hK?=
 =?us-ascii?Q?JHxsO+p8H92LfhxmsL3rq6zdq4vaKlEDUu9fs/OAsfANHoggIPDrp0nUsGcE?=
 =?us-ascii?Q?Nt2HrYwKlP92y+4PI7UqHSi3C+YuObPCwuj3bk+bzOwYdcP8bmt2qfoCHxM1?=
 =?us-ascii?Q?NEWGpC9QyKZmlV46v6XvY7zvGj4po6muzrLA97hkwWIKEDqWJNNux1D1eTE5?=
 =?us-ascii?Q?2oBPpoB9hne85oJZB9NsKA0fvI5cATrByL6WoBU2BJHDCB0x/K/YpUDF2G0u?=
 =?us-ascii?Q?xeEEulCrOxYFGdaU7YgV7ROIdT3o+puIfnDRbKjYApXBXnPU/QAcH00IwVeN?=
 =?us-ascii?Q?ul0+CbvpnPEt4KRZenRzMi4gbwAI7VlYaNQvRI6M7jPCufeEQvkI2vyAiaH6?=
 =?us-ascii?Q?fcCVAnLQ/Q5Q4+LFMbg7mlPS59ihE24NXZ1aaqFjQvKBoCg1hpNbQ8Ei5Wy6?=
 =?us-ascii?Q?QZ9xV9MqlD1Yp8uQy0pXmdcDjyXwo8VceNgN91JWMK9NcjNoFSwEt1Amhug4?=
 =?us-ascii?Q?mSm8eTeirpk0IZRCIeKsM1hy+oLq/0ISO87/LT+OkisLoafn8na2+nowD33s?=
 =?us-ascii?Q?cNoDE2KF+J2YqUwt5NFdnu5AFwf2ON/75/yHUqgg2QqOa2pjVQtiSbMwummh?=
 =?us-ascii?Q?sjNG4wW7y9wT6VBwuEFRMv5BeZPCRYSDsGXZXVT5zrHYiQcgb5mbG5y7qEBK?=
 =?us-ascii?Q?RsyIO6+SDM2YSddPBcV3syAZnlV6UPSXqJ7HKxqlw/s+TcgFatgObYWwcuAw?=
 =?us-ascii?Q?CzF0nbVPF/VHpZMnIKZEg6nKFb8HOc5OxGUYpn39efh4+JRQlYx7g3IPKeM3?=
 =?us-ascii?Q?St8Xo1/7SNxSoaqqIg+znKpb3HKRwdspvxEjJWHYiG5kZY3X4ACTvjF7FidK?=
 =?us-ascii?Q?nlPCXXAb3xidR2hZp5kf7j5pMzMnIg2ujkI4xtf4el2YsmjJlY2b84agL40D?=
 =?us-ascii?Q?nyBREuDlZ/Fx+ktDjTBJUyFZOxmkPlR6DZJBF/neMpJMJpPPgzmRoQf1e2JW?=
 =?us-ascii?Q?Vpwh8OTzQ6TOQdZk5gHxlz58btjPddKmSgxNkE8Lx2ORcYtZWcFbrOkNKJeP?=
 =?us-ascii?Q?y8HV3/n5gDWOt6Lt9trTeHe4SnzDqzfiyVU8eQP8+htMGEXggIvtC56Ju5iM?=
 =?us-ascii?Q?VbBUCmAvMUF7R0O2fmTDpofYsTSPwu+7KS3iuBNixyOWRMztdC6iRulve3DD?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3QXdzjXF3V5e2TFADP0vFtAxsl4m90TeLDyJfaLtoqTAuSnnoiJla2BNYBswgZLq6MYp1R/1/yfkjBjW2mQnJbWIY3hJuOLEN61YFcllVRV8bnxK3qKsW6Fy95OHHofPRIfOatVe5yJYN18ndgNWBrzkgASULimRAONPlCo0KE5e6nBQ1XYDJvj7LY3bait7PuB6AlPZDB6Z25h6JltXzciOczLb06U7T2GnA5GcZXuVCMkktHCXVUKJwG523Cq9TOTy2bx7YHZxhkl6aoZ8IQf7Ne0vdBRKS+klZnqb+2vxi2q2QakPI9IFIsBo+Jq0iJ85K+0bxQtCekC8i159L6qXVZ8z8C0XS/9ve3OsldDLwV36d3tlRsnA5+Vk0rQdF0yjE2+gJywaJVI/lbEZCdtrdI5MrWcc5rbKunteXtw80qGZvQkss1FCn5ZhEwD+rRqyR8dgdPQO9J18RBpiHgqOJh4AM6wxdjRlmnZzgAHRm72MdwKFv7edyTgiLTqEffnmdnHQLsY4OZR8/Fvlrq8C1GV8yOnaUYWVPO46E4Q95oduUJULeei1JJVg6cVeiW+qRjrhf6VqiLjtB1H/cmN2MbuZOOSSAbQrWOwbO4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4facf4a-8efb-4461-b991-08dd8eded73b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:49:50.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQlp8WRrgHPFwtdb77YhG8FO4EaDqm69W2E/NExUWrc6vjku/FzMT3lBmzHZLkdZseClnpAvYeWc64gTwRcv8p+YeaE82QUpm9PFVVpmACI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5NCBTYWx0ZWRfX3BZKIC+Dh/d8 c7PwVgmCWGrkj7an1Ib4VUheJDM+5FkLrZ6BZ0dsdhjEUopnYIZPgdmrTbbzd9cn46rS/p+EV4Y uo2cwOofQWPkctjrau9Q5Ij7BBDoI6j/tssK3qf9FckmwTgG5YvmbK9k8z8YSWqpVOLRWU7Lm6O
 keQ30YBR4LKKxd8JZ5TW+BsZyB7taPG0mf5U7FuKAdrmQSxIxXV3mCwPrwCkYAwVtXpnZbV4ne0 CGSHqzF4192DTHm6KwtGdCcINaFDT9Jpe+lVTphWwGseeIdhk/9az+C0YN4ITSyQQJc2ZN2kDOg Xet4S5luZVB0InXWDDMKKQrYmKPamYMipxkq/33ChdlXHmQPaaNaau2MpX8hfPHhQMq4kabC+08
 ZOOVLZjG0FejCfBp5eXdrxWomp8iHbwWfMp27Y92yLnKlkY7ML/OFCJ2Wjm9ngPoMo2QeCk3
X-Proofpoint-GUID: wc0ToLeerHc7Sr0SXA_yINYFqHPLCpW2
X-Proofpoint-ORIG-GUID: wc0ToLeerHc7Sr0SXA_yINYFqHPLCpW2
X-Authority-Analysis: v=2.4 cv=Lt+Symdc c=1 sm=1 tr=0 ts=681dcfc2 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=fzykpx2G75pY7y_2CkgA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22

On Fri, May 09, 2025 at 12:20:41AM +0200, David Hildenbrand wrote:
> Let's test some basic functionality using /dev/mem. These tests will
> implicitly cover some PAT (Page Attribute Handling) handling on x86.

Ah this is really nice thanks for this!

/dev/mem is a good choice as a straightforward way to get VM_PFNMAP
mappings also.

>
> These tests will only run when /dev/mem access to the first two pages
> in physical address space is possible and allowed; otherwise, the tests
> are skipped.
>
> On current x86-64 with PAT inside a VM, all tests pass:
>
> 	TAP version 13
> 	1..19
> 	ok 1 madvise(MADV_DONTNEED) should be disallowed
> 	ok 2 madvise(MADV_DONTNEED_LOCKED) should be disallowed
> 	ok 3 madvise(MADV_FREE) should be disallowed
> 	ok 4 madvise(MADV_WIPEONFORK) should be disallowed
> 	ok 5 madvise(MADV_COLD) should be disallowed
> 	ok 6 madvise(MADV_PAGEOUT) should be disallowed
> 	ok 7 madvise(MADV_POPULATE_READ) should be disallowed
> 	ok 8 madvise(MADV_POPULATE_WRITE) should be disallowed
> 	ok 9 munmap() splitting
> 	ok 10 mmap() after splitting
> 	ok 11 mremap(MREMAP_FIXED)
> 	ok 12 mremap() shrinking
> 	ok 13 mremap() growing should be disallowed

One could argue these should be in mremap tests, but the mremap tests are a
bit of a mess and I think better here.

> 	ok 14 mprotect(PROT_NONE)
> 	ok 15 SIGSEGV expected
> 	ok 16 mprotect(PROT_READ)
> 	ok 17 SIGSEGV not expected
> 	ok 18 fork()
> 	ok 19 SIGSEGV in child not expected
> 	# Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0

It'd be good to assert that merging doesn't work for VM_PFNMAP, though hm
one could argue that's not hugely useful as it's trivially implemented.

But I guess anything like that should live in merge.c.

>
> However, we are able to trigger:
>
> [   27.888251] x86/PAT: pfnmap:1790 freeing invalid memtype [mem 0x00000000-0x00000fff]
>
> There are probably more things worth testing in the future, such as
> MAP_PRIVATE handling. But this set of tests is sufficient to cover most of
> the things we will rework regarding PAT handling.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> On current mm-unstable, the MADV_POPULATE_READ test fails because
> mm-unstable contains a patch [1] that must be dropped.
>
> [1] https://lore.kernel.org/all/20250507154105.763088-2-p.antoniou@partner.samsung.com/
>
> ---
>  tools/testing/selftests/mm/Makefile |   1 +
>  tools/testing/selftests/mm/pfnmap.c | 278 ++++++++++++++++++++++++++++

As Dev points out you should update .gitignore, but you should also update
run_vmtests.sh so this gets run with everything else!

>  2 files changed, 279 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/pfnmap.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ad4d6043a60f0..ae6f994d3add7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_FILES += mremap_test
>  TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += pfnmap
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> new file mode 100644
> index 0000000000000..59be2f3221124
> --- /dev/null
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
> + *
> + * Copyright 2025, Red Hat, Inc.
> + *
> + * Author(s): David Hildenbrand <david@redhat.com>
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +static size_t pagesize;
> +static int pagemap_fd;
> +static int dev_mem_fd;
> +static sigjmp_buf env;
> +
> +static void signal_handler(int sig)
> +{
> +	if (sig == SIGSEGV)
> +		siglongjmp(env, 1);
> +	siglongjmp(env, 2);
> +}

Hm, wouldn't it be better to only catch these only if you specifically
meant to catch a signal?

You can see what I did in guard-regions.c for an example (sorry, I'm sure
you know exactly how the thing works, just I mean for an easy reminder :P)

> +
> +static void sense_support(void)
> +{

See below comment about the kselftest_harness, but with that you can
literally declare fixture setups/teardowns very nicely :) You can also
mmap() these 2 pages and munmap() them afterwards straightforwardly.

> +	char *addr, tmp;
> +	int ret;
> +
> +	dev_mem_fd = open("/dev/mem", O_RDONLY);
> +	if (dev_mem_fd < 0)
> +		ksft_exit_skip("Cannot open '/dev/mem': %s\n", strerror(errno));

Hm skip, or failure? Skip implies it's expected right? I suppose it's
possible a system might be setup without this...

> +
> +	/* We'll require the first two pages throughout our tests ... */
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_skip("Cannot mmap '/dev/mem'");
> +
> +	/* ... and want to be able to read from them. */
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr + *(addr + pagesize);
> +		asm volatile("" : "+r" (tmp));

Is this not pretty much equivalent to a volatile read where you're forcing
the compiler to not optimise this unused thing away? In guard-regions I set:

#define FORCE_READ(x) (*(volatile typeof(x) *)x)

For this purpose, which would make this:

FORCE_READ(addr);
FORCE_READ(&addr[pagesize]);

> +	}
> +	if (ret)
> +		ksft_exit_skip("Cannot read-access mmap'ed '/dev/mem'");

Why are we returning 1 or 2 if we don't differentiate it here?

> +
> +	munmap(addr, pagesize * 2);
> +}
> +
> +static void test_madvise(void)
> +{
> +#define INIT_ADVICE(nr) { nr, #nr}
> +	const struct {
> +		int nr;
> +		const char *name;
> +	} advices[] = {
> +		INIT_ADVICE(MADV_DONTNEED),
> +		INIT_ADVICE(MADV_DONTNEED_LOCKED),
> +		INIT_ADVICE(MADV_FREE),
> +		INIT_ADVICE(MADV_WIPEONFORK),
> +		INIT_ADVICE(MADV_COLD),
> +		INIT_ADVICE(MADV_PAGEOUT),
> +		INIT_ADVICE(MADV_POPULATE_READ),
> +		INIT_ADVICE(MADV_POPULATE_WRITE),
> +	};
> +	char *addr;
> +	int ret, i;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);

Nit (same for all mmap() calls) shouldn't this first parameter be NULL, by
convention? I mean not a big deal obviously :)

> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* All these advices must be rejected. */
> +	for (i = 0; i < ARRAY_SIZE(advices); i++) {
> +		ret = madvise(addr, pagesize, advices[i].nr);
> +		ksft_test_result(ret && errno == EINVAL,
> +				 "madvise(%s) should be disallowed\n",
> +				 advices[i].name);
> +	}
> +
> +	munmap(addr, pagesize);
> +}
> +
> +static void test_munmap_splitting(void)
> +{
> +	char *addr1, *addr2;
> +	int ret;
> +
> +	addr1 = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr1 == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Unmap the first pages. */

NIT: pages -> page.

> +	ret = munmap(addr1, pagesize);
> +	ksft_test_result(!ret, "munmap() splitting\n");
> +
> +	/* Remap the first page while the second page is still mapped. */
> +	addr2 = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	ksft_test_result(addr2 != MAP_FAILED, "mmap() after splitting\n");

Hm not sure what the assertion is here per se, that we can munmap() partial
bits of the VMA? It'd be pretty weird if we couldn't though?

If it's that we don't get a merge when we remap, we're not really checking
that, but you actually can, as I added an API to vm_util for this using
PROCMAP_QUERY (very handy tool actually - binary version of /proc/smaps).

You can then use that to determine if the VMAs are separate, see merge.c
for examples, it's actually really quite easy to use, e.g.:

	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);

> +
> +	if (addr2 != MAP_FAILED)
> +		munmap(addr2, pagesize);
> +	if (!ret)
> +		munmap(addr1 + pagesize, pagesize);
> +	else
> +		munmap(addr1, pagesize * 2);

There's no need for this dance, you can just munmap() away, it tolerates
gaps and multiple VMAs.

> +}
> +
> +static void test_mremap_fixed(void)
> +{
> +	char *addr, *new_addr, *ret;
> +
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Reserve a destination area. */
> +	new_addr = mmap(0, pagesize * 2, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> +	if (new_addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* mremap() over our destination. */
> +	ret = mremap(addr, pagesize * 2, pagesize * 2,
> +		     MREMAP_FIXED | MREMAP_MAYMOVE, new_addr);
> +	ksft_test_result(ret == new_addr, "mremap(MREMAP_FIXED)\n");
> +	if (ret != new_addr)
> +		munmap(new_addr, pagesize * 2);

This could only be an error code, and this will fail right?

MREMAP_FIXED is 'do or die' at the new address, not hinting. If there's
anything already mapped there it goes a bye bye.

So again, we could just have a standard munmap(), and this lends itself
well to a FIXTURE_SETUP()/FIXTURE_TEARDOWN() :P

> +	munmap(addr, pagesize * 2);
> +}
> +
> +static void test_mremap_shrinking(void)
> +{
> +	char *addr, *ret;
> +
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Shrinking is expected to work. */
> +	ret = mremap(addr, pagesize * 2, pagesize, 0);
> +	ksft_test_result(ret == addr, "mremap() shrinking\n");
> +	if (ret != addr)
> +		munmap(addr, pagesize * 2);
> +	else
> +		munmap(addr, pagesize);

I think we're safe to just munmap() as usual here :) (it's nitty but I'm
trying to make the case for teardown again of course :P)

> +}
> +
> +static void test_mremap_growing(void)
> +{
> +	char *addr, *ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Growing is not expected to work. */

God imagine if we did allow it... what hell would it be to figure out how
to do this correctly in all cases :P

> +	ret = mremap(addr, pagesize, pagesize * 2, MREMAP_MAYMOVE);
> +	ksft_test_result(ret == MAP_FAILED,
> +			 "mremap() growing should be disallowed\n");
> +	if (ret == MAP_FAILED)
> +		munmap(addr, pagesize);
> +	else
> +		munmap(ret, pagesize * 2);

This is a bit cautious, for a world where we do lose our minds and allow
this? :)

> +}
> +
> +static void test_mprotect(void)
> +{
> +	char *addr, tmp;
> +	int ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* With PROT_NONE, read access must result in SIGSEGV. */
> +	ret = mprotect(addr, pagesize, PROT_NONE);
> +	ksft_test_result(!ret, "mprotect(PROT_NONE)\n");
> +
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr;
> +		asm volatile("" : "+r" (tmp));
> +	}

This code is duplicated, we definitely want to abstract it.

> +	ksft_test_result(ret == 1, "SIGSEGV expected\n");

Hmm, what exactly are we testing here though? I mean PROT_NONE will be a
failed access for _any_ kind of memory? Is this really worthwhile? Maybe
better to mprotect() as PROT_NONE to start then mprotect() to PROT_READ.

But I'm not sure what that really tests? Is it a PAT-specific thing? It
seems if this is broken then the mapping code is more generally broken
beyond just VM_PFNMAP mappings right?

> +
> +	/* With PROT_READ, read access must again succeed. */
> +	ret = mprotect(addr, pagesize, PROT_READ);
> +	ksft_test_result(!ret, "mprotect(PROT_READ)\n");
> +
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr;
> +		asm volatile("" : "+r" (tmp));
> +	}

And also duplicated here.

> +	ksft_test_result(!ret, "SIGSEGV not expected\n");
> +
> +	munmap(addr, pagesize);
> +}
> +
> +static void test_fork(void)
> +{
> +	char *addr, tmp;
> +	int ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* fork() a child and test if the child can access the page. */
> +	ret = fork();
> +	if (ret < 0) {
> +		ksft_test_result_fail("fork()\n");
> +		goto out;
> +	} else if (!ret) {
> +		ret = sigsetjmp(env, 1);
> +		if (!ret) {
> +			tmp = *addr;
> +			asm volatile("" : "+r" (tmp));
> +		}

Same comment as above re: duplication.

> +		/* Return the result to the parent. */
> +		exit(ret);
> +	}
> +	ksft_test_result_pass("fork()\n");
> +
> +	/* Wait for our child and obtain the result. */
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +
> +	ksft_test_result(!ret, "SIGSEGV in child not expected\n");
> +out:
> +	munmap(addr, pagesize);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int err;
> +
> +	ksft_print_header();
> +	ksft_set_plan(19);

I know it's kind of nitpicky, but I really hate this sort of magic number
and so on. You don't actually need any of this, the kselftest_harness.h is
_really_ powerful, and makes for much much more readable and standardised
test code.

You can look at guard-regions.c in the test code (though there's some
complexity there because I use 'variants') or the merge.c test code
(simpler) for straight-forward examples.

I won't block this change on this however, I don't want to be a pain and
you're adding very important tests here, but it'd be really nice if you did
use that :>)

> +
> +	pagesize = getpagesize();
> +	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (pagemap_fd < 0)
> +		ksft_exit_fail_msg("opening pagemap failed\n");
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +		ksft_exit_fail_msg("signal() failed: %s\n", strerror(errno));
> +
> +	sense_support();
> +	test_madvise();
> +	test_munmap_splitting();
> +	test_mremap_fixed();
> +	test_mremap_shrinking();
> +	test_mremap_growing();
> +	test_mprotect();
> +	test_fork();
> +
> +	err = ksft_get_fail_cnt();
> +	if (err)
> +		ksft_exit_fail_msg("%d out of %d tests failed\n",
> +				   err, ksft_test_num());
> +	ksft_exit_pass();
> +}
> --
> 2.49.0
>

