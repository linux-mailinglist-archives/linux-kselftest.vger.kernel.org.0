Return-Path: <linux-kselftest+bounces-3874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F2844804
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE17528924E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711539AE9;
	Wed, 31 Jan 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XxhFInHp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCH2vt1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE673E48F;
	Wed, 31 Jan 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729680; cv=fail; b=HjvqQDNYaauFwCTJ9ghW/7wy69cUhHhhVOnlpNCGi+DGAMl95RHCUBl6Oi6YDgEqP0WuLPIw2MAjVMeg6v3zJKez6LKmYOdMuGhjaoriuiplZVLhC30LbF0d+OGCcOg/Hq9Kux0tg+fdqp+Xg0wt6j0YPoRZEtXUwhufijd5Gmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729680; c=relaxed/simple;
	bh=j4D/qPlc3WFhUpcbge3C/5u4+l6WncckW4LHFjNfPyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdpHIjjZrMfoxHYhxDyB/ILDXq2cN+DCSFK5FnhCSjNSszoH2PKcvoSNOO07IshHPBAmSP8yGfgDRFVnV6k4mNp/Ud87i8QnIlxYya3VjGO5lKAkj2oygQLmKw1qcpurtraOFQRTde9DtNwf8v/qqtkmrTgWNo5AXRwR6a/KSyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XxhFInHp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TCH2vt1I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBctD029326;
	Wed, 31 Jan 2024 19:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=sYhh7NVjaRXYGNtay/rgRmuuqXVriI9ilrlmJgjDI9s=;
 b=XxhFInHpULKt/qxYCv928wWn7MRjnUIZk2ELV6EJJgYs8RBh4VcnRyqAeWIHPDVIouF9
 dMbw/Rn0xWvV+5Q0AxWcSKQB61x3qGwoNW/Kq7ud3jPDw72jgIxRuaOqjPcjXrDtVSza
 nCMAyVlX8y3SXIU1skQa6gXWnDvg3K+RxXDwAf/PBDdSfmSgj09+63A3KS0VmUSwjCGU
 QCfJhs/urYXL4sSYZmjqS4fiqEFTzOhONLGhBHTRwrWy+zan3nWOm5rELcMc/lNifaQa
 pc6iNYINL6qmA0V88dlayv3gMVg61nUIAn8/M6pHM/TRJf9rHiH2C/KfJulGOru0debZ zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdtrte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 19:34:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VIJA2x016269;
	Wed, 31 Jan 2024 19:34:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fjj7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 19:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7zc+pQ2KSijhbZvhucgfVMC310qZaTmwwp8LZQip2PZdB8JwVr0aK9UMLkYrvM7UDcDvUQ9mU0l0okfBt5XBJvR3W7UQXvJ0YcIUPvM0vIj1R7o1oMepItR1o8WWQn0Nj/dqgis63q6qG+d96ngZPt8Ic6DJQmEjTJsR/k5e1N/Q21cbqhg6NZXDCX7FReFDBon4sWRzsT1HQDTFCtIAXX16VM9uZAzlFVvmNKi/Q5yAzIxnm82oIGqQyqclDeqt9XvgrJB3U+idLbJeVq9W2KzFgDjb91bHcTC3BYBo90qV7jgDjJ01jOQ1zD3q04mN3CkDv9Yi9smwYXt7oI7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYhh7NVjaRXYGNtay/rgRmuuqXVriI9ilrlmJgjDI9s=;
 b=JBkBpYUiPQ5gzM3I0dJk8aPqPmh/refICA5g5IJgF0g5h9fqQN/KhPl7sNGFYQdrN2p+qV2UYpWbiveyb+6TplZBcYopX6UuDHj1m+yNOfrKoYwS5JFNkzMWsLXELGcqx2dWPGl2x0LKuzJTPlAqfZRCZ/NlcpI38Pos4Ntktwhs8xhvu2QQLh+srnWbDhLbROvbBPYwh17BY3pVAf9/GYul41xTbaQ7TK7jC41p+rHur8yBpVdFRnpIf6IoXFqO2sNzp8zsGEOLjJTn3+3hMkXmtMSCEwd1ZZHqHS5gz5BQ1m2DushR+3kl5l3DmpuOPtrn6s9lkjVD6LtRtfTh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYhh7NVjaRXYGNtay/rgRmuuqXVriI9ilrlmJgjDI9s=;
 b=TCH2vt1I2Dd9HFaJ2Q3/e+lybodrneCc+Mw22IB1OKMLTa+dKv99o6uQx4mVKmgeQgu6fErU2eeMxWxxfgepLgOo+npNFSf+1sB637Y5hI1DPUk2nr3bmcLScZFXhecg5QczZYUNoTsanJ0JRpoJmsJA7ue42XfVB3pauIV8cqI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 19:34:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 19:34:14 +0000
Date: Wed, 31 Jan 2024 14:34:11 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: jeffxu@chromium.org, Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240131193411.opisg5yoyxkwoyil@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	jeffxu@chromium.org, Jonathan Corbet <corbet@lwn.net>,
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240131175027.3287009-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131175027.3287009-1-jeffxu@chromium.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 6130f7b7-5c07-4e7b-b383-08dc22939b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aqGr9QcGs+WbATOB2JbSgChza0T0ZNeck0Kc77eW3nwSiOvamWoOhcSILJZ+xg++AFh0TpAsKyPcfx1kcOwgNkBVGNWHiki229mw7aC8DSyOFFqbcVP+8sRKLMxHArTEosX/ESMdF7vNxLpVpnRggu+pmJShD/99rcn08Z9aUC3srUlr+a/1Xf5mCqpFMtgqGM4TdTX8tk/bXptPxlU4+J61ZBJdmsR7ZSWG/L18iXuoUxy+QVkQjvqBbViiRFNM61NBjATKX8Ec62Yb2ufKahhqy67/y+xT24pTSOMHhOWruSMO1VClrN1/r5pUq40gWXB33fVLTWV02qTugZ8e9uIqZwe+O0vijIP7Kr91ECLTtJjoFj40cZzAT1zmXj2ngW2KdXNpzt25c846hXlQkFDXYbBEhIdxxDnIakJzfQtuDox6CbPCM8Uf3OahlX4cKbmhfJMoEPi5qKx4+aHHq+gzvmnnWLTXBhGFrFHzGXxsord4L2YQSkJ9xbAgndaJNWknAiI7pob76Qo4beAyPPf1Kg8MCML5cwpcbYZN21iZGAGbPftzd3ZPsZnXvM2QBqjhSv8OX+Ajcwj8BK48qQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(83380400001)(86362001)(33716001)(6512007)(6506007)(1076003)(26005)(38100700002)(9686003)(6666004)(478600001)(2906002)(66946007)(6486002)(966005)(6916009)(316002)(66556008)(66476007)(5660300002)(8676002)(7416002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p67a1Q8mt99+mjgTPMKOxVHgIZz78nMmk5T5QA9hLFBPS2EHqgsbM5VH4X/h?=
 =?us-ascii?Q?+Zo6uWfdp1DhtesJsDKYDCEInpfWbHRtDwv9zw188IprXhPH4VMzIr0jEmy0?=
 =?us-ascii?Q?Iv+fvux6yzVAV/gVPeDdQVxj0PYMfzHDdgMxrSf88qbGNJE6bc/K7N4v6Kqm?=
 =?us-ascii?Q?+cIs+wmS9NldjzNgmqG2BXJKOVFkblaB0C+YsXD0BVXTSY/yNwxJHdiCU/on?=
 =?us-ascii?Q?YxNSHz+4HaJ1PAoH2JJHSy67NpOEXR98E2XzKyjTjhfU5hm8qO6s1J5QjnZf?=
 =?us-ascii?Q?eL89CAlbsPugw91PIiYcpAfHvG4fY8m6b77g9qZ3pZbYKeASu/86G57Fpc1k?=
 =?us-ascii?Q?ep7eYu1UcoU4Ggs3N2Ttf0z2AWRrSVMMSHtoiOvV50h1HCVHpYXAyR+gxSDi?=
 =?us-ascii?Q?sk5egzZxMSud3HtK6sSaLiiDJobtr5MuTaCPu5M6Tc4dO02fDVW/7tCE9/u7?=
 =?us-ascii?Q?wCqUVUNQLpZiYFEeabyQmLLn3YV3c3Sq1NdViy9I+z3xo12JRGZrXK8dBXRJ?=
 =?us-ascii?Q?EiAsQKWPSxMhDpFDokcJY2dqx/fLkkcF1yYzhofTD0rMPkDeF0lfXimZULl7?=
 =?us-ascii?Q?vDs073ookl7epTlLHG3w9rxYp5hRcqzA5+vF1y4BIQVThmOpvTEEmYEWVh+B?=
 =?us-ascii?Q?vOLXlu5/zBZ9xvTris+KQMSf0RGlQpCVUbwn/Xj1Mj1UqukyW5sarGvVg0Nl?=
 =?us-ascii?Q?0USFM6HeOPDnuimwtOC2hNhqfTIKnUBWLvaPUTZ1l0Sd9Ti/5hzi/bQj/q2E?=
 =?us-ascii?Q?zegi2DsWev4fHyCYVdrNHIXhTBHHWU9ZXhmev+Yb5gOdEUVHhXC/uW8E4LuE?=
 =?us-ascii?Q?aMHUekuYCWdeQ8sGLpAlfxZ+HG41gCbe4tLtvGMJmTfbZL1ehwUDh2QIrAJL?=
 =?us-ascii?Q?9SEuz+XdFn6n4tshRWf3kxdgQHoFlBKqkPYgfpHfe3eeeghRLl4M/6lUAPIl?=
 =?us-ascii?Q?8sUnC1QoZunwDLUzvSz9H4ZXumKYOzzhwUxyUcMjVhpsKMvOJd5dyQuiofNn?=
 =?us-ascii?Q?J6nIr3MEmBhoefZppTkVBLyledom+wPuj3MxnEt0zatvMwp5pK5SN2+3xEBR?=
 =?us-ascii?Q?wAlyT8+Lv2HWbQjIIUCpeBNSyqNumzYKVAQX8mQyk1P9aljym0Pw7slLvWJe?=
 =?us-ascii?Q?XPbcTyIrDGqBPsodU0L6zE2uZbTylqojmfVcJ37FcfPaX6WgjG9s1GKkBlun?=
 =?us-ascii?Q?y8jHlRuTrIkXJ/y+RJBzm4J4Gs5c6W6F4ig5SWKY7Datcn3kUkVqNio1GpJo?=
 =?us-ascii?Q?lbjPD7UVeJXGS3B6WX6TW+EfVODL23urgCGqCD9/2pnXqptNx1tkb4YVM2mO?=
 =?us-ascii?Q?OPI+420B4r2po4GdNjq13+Aa/lNx8weqMMIqRMxxq3gztYPyKYTFMx2jfclT?=
 =?us-ascii?Q?YlA0Ba4ECPLkKTjeyJ0y33ZNWTysUCtUalmGJkqKaOKj48PWP4iPfcgt7pLZ?=
 =?us-ascii?Q?L3/m0GRRYK24SUo7pUGKhlJwWq9N75AtBDB06vrqcvYze/lpfaJUwbBLBIFd?=
 =?us-ascii?Q?mok3+xRJ6RrlyVysgar7/PJyYe81Wm+zRCt9eDNRplt3x+1JtzPR4luyPJea?=
 =?us-ascii?Q?lYdAjFbtPicKnrbt9oR/aBb/cUP5YdYWbsm0MlsG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	75eHMY5VgBiTEzlb/DGd/X4AS4bGLhKc+e7VXPSuOOlBSd66GVk6+LwhyQH4DYfW9fbM5fW+JUEMY04JvfrRhzwhKVa+NzYF8w9aIyMDgw29CR25yzzjXAFPAZ6tfJE7ClDpp5iRIQSnWOwfwVDtCsvWKkIGkeyohG8J3e7qxEz2/KFCQweztG3EQ3PIumscsTwxckan/o381joF8mSUEIBlaMvw/oeDB05bK8PPyU/ybVYQ45WUKSCevYNsxatbIWYyLJ3sHuyHM2ZzqYpZlR+NEY8rxG0z5xyAo67k692uInd4KOlyOUvnoEXMqEdEYxt/FH+r4H+AmLLLnHjVWF6cAxWwMa+beu8eFX49KlC1mEvCSRaTxaApwZ3EAZCm4RBWAiDrSTFlsAmhmaY1q50ZfdHPDbZyLQsYYcnRoT2haWmDBjCzbuEpCFrCldtrw79mzF4STbMriomA7ltvBMpSpHELgz2w8NEJaZJGP7SkL+9tGL9rgO1JweeHSac09Ruk2ZDit+wCv8at7eJCtvsUvLSN01unkgnqHj9CeCykb70JvDm6a7qEsLRoJSTD4E6kEJXEKaOdTZNinDDKaR86gbAhvlL1YtbgzE6uiVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6130f7b7-5c07-4e7b-b383-08dc22939b3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 19:34:14.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHSj346ZKaVf+Vb45YgdJovnCRb2beXFAwZjRIozhQ+d8EEahkKU4D4JCz0kgcvrcfvt4zAkbMLW4YfaEfimqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310152
X-Proofpoint-ORIG-GUID: vx0WQ03b81jOxykXoCZJAie_FubG6TUL
X-Proofpoint-GUID: vx0WQ03b81jOxykXoCZJAie_FubG6TUL

Please add me to the Cc list of these patches.

* jeffxu@chromium.org <jeffxu@chromium.org> [240131 12:50]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> This patchset proposes a new mseal() syscall for the Linux kernel.
> 
> In a nutshell, mseal() protects the VMAs of a given virtual memory
> range against modifications, such as changes to their permission bits.
> 
> Modern CPUs support memory permissions, such as the read/write (RW)
> and no-execute (NX) bits. Linux has supported NX since the release of
> kernel version 2.6.8 in August 2004 [1]. The memory permission feature
> improves the security stance on memory corruption bugs, as an attacker
> cannot simply write to arbitrary memory and point the code to it. The
> memory must be marked with the X bit, or else an exception will occur.
> Internally, the kernel maintains the memory permissions in a data
> structure called VMA (vm_area_struct). mseal() additionally protects
> the VMA itself against modifications of the selected seal type.

... The v8 cut Jonathan's email discussion [1] off and instead of
replying there, I'm going to add my question here.

The best plan to ensure it is a general safety measure for all of linux
is to work with the community before it lands upstream.  It's much
harder to change functionality provided to users after it is upstream.
I'm happy to hear google is super excited about sharing this, but so
far, the community isn't as excited.

It seems Theo has a lot of experience trying to add a feature very close
to what you are doing and has real data on how this went [2].  Can we
see if there is a solution that is, at least, different enough from what
he tried to do for a shot of success?  Do we have anyone in the
toolchain groups that sees this working well?  If this means Stephen
needs to do something, can we get that to happen please?

I mean, you specifically state that this is a 'very specific
requirement' in your cover letter.  Does this mean even other browsers
have no use for it?

I am very concerned this feature will land and have to be maintained by
the core mm people for the one user it was specifically targeting.

Can we also get some benchmarking on the impact of this feature?  I
believe my answer in v7 removed the worst offender, but since there is
no benchmarking we really are guessing (educated or not, hard data would
help).  We still have an extra loop in madvise, mprotect_pkey, mremap_to
(and mreamp syscall?).

You also did not clean up the loop you copied from mlock, which I
pointed out [3].  Stating that your copy/paste is easier to review is
not sufficient to keep unneeded assignments around.

[1]. https://lore.kernel.org/linux-mm/87a5ong41h.fsf@meer.lwn.net/
[2]. https://lore.kernel.org/linux-mm/86181.1705962897@cvs.openbsd.org/
[3]. https://lore.kernel.org/linux-mm/20240124200628.ti327diy7arb7byb@revolver/

