Return-Path: <linux-kselftest+bounces-33457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34ECABF462
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBF14E6B49
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE9266584;
	Wed, 21 May 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC9n0D8N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvOok7q7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA82676C4;
	Wed, 21 May 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830837; cv=fail; b=ne3sHhlPcNVjDVplrfhWyhPhrDass1QjJisulJ3DpOT/L073FEXPPHLbXfZsfx1d/9+bqSaFfyHHbV62r/Kv0KhlT9OyhOzYEuAQzAIEGc1xObZnU/rwSdJPBmROEhg1H6upNXsXWDiIy3dKImv5ISNF3DoEzqqC+T8YMkDKmS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830837; c=relaxed/simple;
	bh=FtiEUXAZrB4KrvOHQvELIGswyNc8Nx+PvSKjZw1QKfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/FIY/OOWR3iD4rfZRxsnjqQzyHMMIwHXaBsVDqE0DkBEpECtWLfpXTrZtk09cDqGjOjp4Icrsgy0PiOcyLhNLC2SPNiXun2whHn1rBs4k43BRQ+rRP1ZV/d3Rvcn+ecu3oNQPwltVITgNZ9dB8rB8ZlDCf5Neb84RW5+Ii04/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XC9n0D8N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvOok7q7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LC7tDL005831;
	Wed, 21 May 2025 12:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FtiEUXAZrB4KrvOHQv
	ELIGswyNc8Nx+PvSKjZw1QKfs=; b=XC9n0D8NtDR/rR8A1hGyUi7dniQs7ug3gV
	7Tm0l1kK4GPhJmrWOIJXY1TkWhBY1ov4E0Q85vJL8jKgZBglu1tBTfDRleInhALj
	qMHUrGuem2tgYa3e6kb8x1N+Rd1k6sgyxZ2Vrv+oDZU/N9zu5DMJr8/6QUa8hS1r
	0Ppt1j3NG71fHBGrXCEF2IaSi4QPUt2Nc+a2uw29Q4C8qH4TCUuspglHPI/2pTl5
	r0n86SEMMoiZU8jUwT0isY5uNpgD9/yCj+NssR0NZk5rQUIVjHBIqFR+s+WiwscL
	BewNS6WyDhTBtWY0RpNMLdrp+W3buzC/0IcOc+KD1EIBiEKJR0BQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sd81g7v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:33:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LC41xG011311;
	Wed, 21 May 2025 12:33:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwen1ver-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxjQUIZryvF++wzwBjHoFwu6j09aqpr85ZAAaG41FrNXyYekycW4bOHQEPzhhUjYf/eGNBeiYuvUiGTzm5pCNjVBNbcf1PsPtg4SHUvoIZ3IRxFpJL6BIgp/JsvBUmW+kOyKRiXV9WkL4ZDzRTt/cT3ZFCRxm3V5OQNplTkZOk9teDsrf4O8zozKfWzPQ8IUiQ7AqmsyTn8r7IGFGZWtKNRalFjmKfsk6jTWszK8tik5UM4B1MFIijASNxBeL/i/gqjfEcM7sz7mSwM1nkJya1SgP9Y0E9WA6piGexIu9RGqPMiOsoEd9835+Ivmtk5m4yikL+1lNSttqsN8eyy9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtiEUXAZrB4KrvOHQvELIGswyNc8Nx+PvSKjZw1QKfs=;
 b=rdJGKsrjPxUL7jeZZeVQSq+V9a8W/2BFWyflC4wGwzEo6EsVw54YRczcSCiBrJ3PTUtc1s1WeoZNGmtHllB9GZTKfP8Gbm+lS4o9k4Zf87qinEMiZB1/vhzJBczMQ10ezhs+Xz2NU5jaWFPrHigRwXNUCxqiI+BHNwzPO+T/q7fIUNPlPWN1inQyxG74gCS1BvXxpdnC8hVxOSuHKoQ9ZF+GYmgYXu8p9Rlirbe5N8S9Dkfum/YkSN601AHdF7zCZ52uWHUiJy4O8L9EUW8CHONPQsez2KZmt0xiZGl73NkAvM7k09bXF8qGwDBFqfD3zSXUEITYxr5HSxipVbK9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtiEUXAZrB4KrvOHQvELIGswyNc8Nx+PvSKjZw1QKfs=;
 b=gvOok7q7frLzFh1byx31lMDoVUaSmHUrJPbyyghc4Zw4JbTlMoXPFtexcD0dtJbAU74vYyAKCkfNSJfw9lkk7YAznOuutR2ohW3ibJuI5pDoVN/36CDbYaljtiNmlbOgzD83JgoQaY/r0VmUUYz4P5z0//2BlJlroRBs87wJDo4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Wed, 21 May
 2025 12:33:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 12:33:04 +0000
Date: Wed, 21 May 2025 13:33:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rientjes@google.com,
        hannes@cmpxchg.org, rdunlap@infradead.org, mhocko@suse.com,
        Liam.Howlett@oracle.com, zokeefe@google.com, surenb@google.com,
        jglisse@google.com, cl@gentwo.org, jack@suse.cz,
        dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
        catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
        raquini@redhat.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, yang@os.amperecomputing.com,
        thomas.hellstrom@linux.intel.com, vishal.moola@gmail.com,
        sunnanyong@huawei.com, usamaarif642@gmail.com,
        wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
        peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
        baolin.wang@linux.alibaba.com, baohua@kernel.org,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, corbet@lwn.net, akpm@linux-foundation.org
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
Message-ID: <085de112-7238-4bbe-822c-198a7291ea89@lucifer.local>
References: <20250515033857.132535-1-npache@redhat.com>
 <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
 <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
 <43d6aa16-3e52-45df-9366-e072c0cb3065@redhat.com>
 <a41ea49b-2bac-44c8-9a4a-dd55dfd0d171@lucifer.local>
 <db190425-9959-4d0c-b928-c537c69bc5a7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db190425-9959-4d0c-b928-c537c69bc5a7@redhat.com>
X-ClientProxiedBy: LNXP265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d4349d-22e1-4872-5019-08dd9863a1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypQiHIi48OJrsITVtO0NG0lXqV2vxybHi7O04t/i+088WbtrjZxeraUimAjp?=
 =?us-ascii?Q?epwDOTUZYW49T8mvhCTpSTJFYNg+CR18Wt3DQRaBG1r4G8Elxs+JntiVzEB3?=
 =?us-ascii?Q?MdKOd77CN8191d+Nmth7ocJMF1ll+TsSQPgZmA+fni7PeMkEerPWu5/sYIfp?=
 =?us-ascii?Q?O3adYDkUUQRCWQn9iMkiCMC/rqMcfNJ047GviJr2OJGYwDY8sCKpuIqTKzuW?=
 =?us-ascii?Q?2rBLd1ROm7V18s3jJayLMizyOZi+xkbODLhde4iDw+5snxU8xzwAbh7f74yT?=
 =?us-ascii?Q?nNp+e+QC2lF5AkfFGe6/KzBIG3t+hqFG+wgMY5Ev3lExikH4OgeRc1MsaaTL?=
 =?us-ascii?Q?kunGtSc4Hp/RLdNZTPYS2tZNjplktYbYT3DYH6VWQ23lqzefcP+eLwGMdW7U?=
 =?us-ascii?Q?UzPhulDIMnrSOJ3qCIz1Bok5ldHCNdllZKpb/Y12MWAmVBwS25d+7dqzfHn0?=
 =?us-ascii?Q?25AoWEiUI0RqD41R9QTaMi8pZej6tgxBeaufVKtaPKzYFLvgkMadsVkrDLBu?=
 =?us-ascii?Q?hQVRdb41bVH09YqT6XANxYoH/83oGyEUVDtJi/Si2ooEMMfh/UYKY0zv4h6Z?=
 =?us-ascii?Q?26K9TEWBzUcvXXirY2eH2cmBJCYsVK8WdQmS0utRl0RIm9LrUCElYl3mXCT7?=
 =?us-ascii?Q?oo4mEg1DVJi45jcrB63H0JGFg+RbR/waTmiPNPzgXVP4kn6B4qYJzcllsNgN?=
 =?us-ascii?Q?wfOonwzn8TixlKYqYkKhiiPQBnCzxf/T0ypSw2ucz18jkaNV20LY00aCN8PT?=
 =?us-ascii?Q?JVGpVyf6t6vLmbt4AHd9oXlRHrbPQ/HCEMq+Lol+EIaoHvvIhHkwKhZpgbrT?=
 =?us-ascii?Q?Qe+fvWJoswLybd9lr9WsCwhwbBcwVv4K4LjwgKLtR7gQneKxT5H1c/cp2TT4?=
 =?us-ascii?Q?qas9KWPxr+5ZiBGW7gFXKqBUMpjqNYmVQtMdhmiGgokHtqRtu61/lD+peG45?=
 =?us-ascii?Q?lsx8GYOKlGNGSnAoCAY1l1cBdZkHggxE5DSQ7aLisRpAtHTDRxq+/e2rJ7sV?=
 =?us-ascii?Q?u+GA0gVH83DDWYwrExuu1s8Dt012pjKlhHRDGCm1rODIRmuMShMZpaBEXyQQ?=
 =?us-ascii?Q?BRExAR5XAzeaERx6wqVL0UQT2gnVr8O9qNSACPkOUy33Trsy23J6Yzn/KT7D?=
 =?us-ascii?Q?+dAzjtbfLQA6TvBeP5aExvkSjNryn2U6ItlERK0izmDUv0aeHAmEK8VALaW3?=
 =?us-ascii?Q?stE5Rhc28tHffW2wQsQpCSe+3Xi+n7dKYFn7rZbbdPDmCUNl6K7n4Yb6gDvp?=
 =?us-ascii?Q?elXOqOw/lSnKWoCNl1TTVegZvFzmX2nsi4m1PEplYALMshd0yTvhZKKUKQwc?=
 =?us-ascii?Q?a0zGsL61Mi0xUVKzAPZd/K1Woq72iz8BM/qbUDBGs8Nbevp7a6brlbmIg0Gw?=
 =?us-ascii?Q?5FL1fsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTrn8Fy5IroLoeac++R77ST8//h3UBOHEdWQQvimGMeTSo29nS1/ZqQdkLw/?=
 =?us-ascii?Q?nY00fYFO44dr6weVCllZ30pRhnTyRVZBrZkcI0e3UC92ODmcVo96YnwsZ1/I?=
 =?us-ascii?Q?n7nb3IN5JHXUrvyUMqHFDupQD3XluOkAQg78G5lgRTG/BzWAV5rTAq0OFmtV?=
 =?us-ascii?Q?T+unYrSgg04XRhImF3OCH2DSPKYElZqE3hcbdbBTZlEYuj0CcZr0CtuHF9ST?=
 =?us-ascii?Q?bUTNouwfWRKPJA/kTIeqodfkYhEgGCBWaNE2GW0W+2qeac9yoY0zR2JQ/PCK?=
 =?us-ascii?Q?ggWDkEw7ZYoA3Z5C5teLHyB8Vqf2FL8KXH2dfYInxGaDXZiN0LMtimUer+iW?=
 =?us-ascii?Q?WzDahEEgwoR5IiZReIzM+yvf/z11ssak7qZ8RmtaYd1h3KpcWYaNag+WUxAn?=
 =?us-ascii?Q?rL5VVvAyU3RLAn1CEztlcqcTXz6zO0ZesOYPj7kW82JAshlSrRa0xSPTioA+?=
 =?us-ascii?Q?tRxUdBIQ8snST3+LurjiNu8cMsjt2IYy0wXoWlaTqao0ogmeVOAMf2z+78ia?=
 =?us-ascii?Q?ZzSq/jl3IhLFvpRfe8ELcBljKI7alzmi+b7KVY1QyockOBYaza2fuzSjAOOh?=
 =?us-ascii?Q?pR4O+sxCTANDZCiD43a3a8KROocBNK/U6o2N1bz5TulAyBKqaNlXEBuWzmNR?=
 =?us-ascii?Q?19nddlFqRuMXh2ZVTzHiMLa8SNeyJ4AhE1aOJEP5o/BMIevTHboKsImHt0Xs?=
 =?us-ascii?Q?mi72GyKau3+tphNU6gaQzg48t3u2RYIz0Dg5JsuVgTgLDoW9D1IDeAjjqyCV?=
 =?us-ascii?Q?DcvvYM8d0Y5ucNC5laEkjsuuNe2lpeRW9JLa9JcaAQHbdNPsm82Dx7WQZY/n?=
 =?us-ascii?Q?My2EAHF99LiblP3HNvdA/o8uRWWjcWdW+lzRVM68xIat4275orMUqgKZvfZB?=
 =?us-ascii?Q?Ytnq7MDaM/VliVhl9ZhU6IlPT3hThgUCNiwvpiX8ACFFhFBY09imtyf1VTj3?=
 =?us-ascii?Q?cZ0b6H4xSAy9QGWEqeypSbqx6ONFgeL8MxO2/2uYbQJUCqrtOD7UKGJzZG6E?=
 =?us-ascii?Q?cWR8Ph4yiQldbcMI2BH4mun4l5YRJ+5qlIuMc5aBhgaKKLiQbTUdXjNnoYaX?=
 =?us-ascii?Q?fyehO2x3tuMhRg0IMwu/oyTyFIB7u5XzdwqH0bBP0KscdSykcaGY1Sv8ZDUL?=
 =?us-ascii?Q?fax8Rm0eDnZ2skjSEKboXNFo4Rx2JXQ8di0rqYttM7pUlKmxLr2oISxtKfhd?=
 =?us-ascii?Q?c8iakprIdkv385oUbkCJTOBIPju2gMZCK1hE121EeKNwMxn9Hepxu1YA5hke?=
 =?us-ascii?Q?vw6VY49o0VPXpesjA8zCQ7+RqR/dM/0Z3Bn1zf/24qAK5E3B7wFZCkt+E7cW?=
 =?us-ascii?Q?tMCtK6CGq0RlflURc2lEvuQZ6Yhek4WjDz9R0CjYhxJJyEQ1JDuV1Rzx19wA?=
 =?us-ascii?Q?anydA4H2Gi+UVuGEl+IFBh92JcpJCCNOKpNO4DpXLR4ZExJqsFOg4EEcS6hU?=
 =?us-ascii?Q?vWsXlTnBH6vS9ipeQ0XXBoTJdXy41x5VjlztxE41okxSCoSIsBnvY2pqt+Es?=
 =?us-ascii?Q?Ps7/tGzSgAtf03sE0QAAraSAAi5PM5WiggIXznyUWxBqeyMw0XYPa9NL7nNH?=
 =?us-ascii?Q?oOs2TMqcacK/UCmQ3rmDF5GhIx2PIBLjQRzdr7A+IPqhw7N+7zVasgI1KJaU?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lFm3mJmlHCso7n0ZghNEKwkLQhO6loE3+zoUTI/vQCy40oYArzbid0JFki/Yc11/R8e5acMaU7Ps/bXH9qbDRwxPH/MzIgR3DnCAykOp1rXlivFSufGJKHWL3UiA/a+lhA3USs7zcnqpzx7JYgNxhaLU/lQy+53tcvsOpb5fFJn+Meil82iib6NPzfwTyEaBxHAW81C9BThIvyp0EMnFOTyDjJpxxGvRcrVv5Dxu3pkY09qwQf9v9b6oc//gffMrCCMyDX1PBT58XdlvGyS/w8YATLNqHfON/2zqwHtVFWBcjrKLM7UH5x3n4MImmjFKSo9YxGTSuq+tIvZQ1ONXE1TEke9zijsF++rzhHK2iBbnUjlCxqb6ZKtxvD2Bw0n9yWBp9bzGjR98aKX/SYdN2Pu47Hx6HRNKasESsaj+aJrPZddTpqq5tPcq/54MtRxNVwfJ0SBERw6ccKw8CFAR/VnAJIkAyIfEXs4nuXLAKB+cXsuQHOOqmKJomLiwwR2hnN31b6+WXEZrwrUHCmK9snJ9Fil4ll/sb3cM7MOhbxMZxpxUtFi7Av/pvKPCFdONHwmOkuXhLvs3Nj3CUOVv263m7sYmYIsl0+phebKhjDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d4349d-22e1-4872-5019-08dd9863a1d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:33:04.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RomY0GBRdgT+4fcisnYGDhVF+9HnQzymf+a7zXsuNW9ogY8VudhoRM85Mzi4qg5i+kizsz0jMoU4wcvFgzIIgI1UJ+5uWJ+Bu2hTQTyKwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210121
X-Authority-Analysis: v=2.4 cv=bJ4WIO+Z c=1 sm=1 tr=0 ts=682dc805 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=vnREMb7VAAAA:8 a=C33gAAnIqbNLhotlcVEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMiBTYWx0ZWRfX3ohZfpQYvC6X HFMvDzsSauEhpaLTKw0eahBRToJy6FgKuz1CFVl/HV7kqlL6nRB2vDU5R4h5d6HLG/v2aIV7QZ2 ftoh6ksgCjmHyst3EH8w6XQCUdAMGYQ/rLrlqQMjV1nXvRKh1bIylfQmmZyquKKE4U90AfEXBuy
 IksPVjABTvYojIxrGCrjQvRzvLR58uhJG+CPI52IP+4w+vO9s6kZ0XWvOuuOW350xGH9/v3OGr2 HjvwZt+NTqvFx3EATv7ELlYCQ5qtxEpxJQi1IgvNspJflqXAk+t8d69XM+x1hfCIgRTnX2TrJif C3zM0MAroROg3mVvm968RONDFKs6f3LI1AQ67iApmsMnEDVvL75GubSFhOljiSBGrWhTPF3cKt5
 rLDKCyFkTo0lqXFXWOQ9Czy48t8WvqA987TXBVQCNbwtSPvNLzxh66Bixf/J9LMynrD98g3V
X-Proofpoint-ORIG-GUID: 9Yytg1Wm1ehUO-skkDTNbY3YSKWHMOrv
X-Proofpoint-GUID: 9Yytg1Wm1ehUO-skkDTNbY3YSKWHMOrv

Fundamentally I trust you to make sure this all goes correctly so let's not
belabour the point or delay things here :)

So in that vein, Nico - I would sugesst for future respins adding a really
clear bit to the header as David suggested :) also update the cover letter
tests so it isn't reliant on a possibly ephemeral web link.

But otherwise let's proceed as was.

On Wed, May 21, 2025 at 02:24:45PM +0200, David Hildenbrand wrote:
> > >
> > > Anyhow, to me the dependency is obvious, but I've followed the MM meeting
> > > discussions, development etc.
> >
> > Right but is it clear to Andrew? I mean the cover letter was super unclear
> > to me.
>
> I mean, assuming that it would not be clear to Andrew (and I think it is
> clear to Andrew), I we would get CCed on these emails and could immediately
> scream STOOOOOP :)
>
> And until this would hit mm-stable, a bit more time would pass.
>
> >
> > What's to prevent things getting merged out of order?
>
> Fortunately, there are still people working here and not machines (at least,
> that's what I hope).

Obligatory link to this :P

https://www.youtube.com/watch?v=5lsExRvJTAI

>
> > And do people 'just
> > have to remember' to resend?
>
> Yes, in this case Nico wants to get his stuff upstream and must drive it
> once the dependencies are met IMHO.
>
> >
> > If there's a requirement related to the ordering of these series it really
> > has to be expressed very clearly.
>
> Jup. I'll note that for now there was no strict rule what to tag as RFC and
> what not that I know of. Of course, if people send broken, half-implemented,
> untested ... crap, it should *clearly* be RFC.
>
> People should be spelling out dependencies in any case (especially for
> non-RFC versions) clearly.
>
> I'll note that even if there would be a rule, I'm afraid we don't have a
> good place to document it (and not sure if people would find it or even try
> finding it ...) :/

Yeah... :)

>
> A big problem is when some subsystems have their own rules for how to handle
> such things. That causes major pain for contributors ...

Yeah, I wish there was something more general.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

