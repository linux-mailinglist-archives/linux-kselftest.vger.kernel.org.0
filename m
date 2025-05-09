Return-Path: <linux-kselftest+bounces-32743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39719AB1114
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F7D1C26523
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7B22C322;
	Fri,  9 May 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1nbqUw9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NBoJtoyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5E38FA3;
	Fri,  9 May 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787641; cv=fail; b=hWLncemY8k0qXETvC6dofx79O6q5xFpvMG3KUQbJmgHBN8+ndcbV1AoUJiMOyAY5u9uoqYJ5HObnp26F4YixiMOxido9nCm8yyqfU5NWHG0Y0af/bqlVBDIsn8pOlZ2AXW0vHhERCSxH4XoTNtgxcM1OQXwVubjBdt8EpOP12mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787641; c=relaxed/simple;
	bh=iLsio9Qwaa8bvAmi/al+X5dvtB9hb4wxz5jeLulwds8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZDpD22XmPn6pXjYdP+4brhMMPjIqEC4F6eL8ueeNg8fPWnWoYUkdWe0aYLeeELRSkOGLq9wS7ggx9vq7cA1oC5S/YOLuxpXK/owDPUePER5LTuQHE+z60YIj+u9iqKj60YF+nKDwlBB1oMAwcr5xlStj/QhxA4CwByY9erF5/FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1nbqUw9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NBoJtoyr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AW2uo005968;
	Fri, 9 May 2025 10:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iLsio9Qwaa8bvAmi/a
	l+X5dvtB9hb4wxz5jeLulwds8=; b=L1nbqUw9B8pG285POT8k1CMvXMcDahBfg0
	207bVq8vx4jpmYAhthGAzpY00cp8M689NZKcWdWxnFRKOR9oHgmhkWVc/0Yooanp
	nhaKiFyCZEH8ScehA8cnj3y6yj5OydXa16iEyUcIAlOpzoy6uuHsnPKvUgKLnAuz
	DyWwmO+F6VLaY4CcvfNIEORVbAx5gMG6H2yv9ZvzoI9hr+AsvipuFEgj5Gs/MK12
	OT+7dKWNkoEe2pe0IqiVY2KVyJlvK2eoUWBGUWLjHMZC+N8FmOfIfJt2huiiXNuE
	jbaw0rFWLqtnJUEe6S1H3sMLTE4qmVe5cgm+wDlPQb98hxedhsAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hg1j80sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:47:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549AVxQa007494;
	Fri, 9 May 2025 10:47:10 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011027.outbound.protection.outlook.com [40.93.14.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fmsbefkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYZv0yWSunqosKZ8EFPwgH9RURvl6FkeXkPPQPqeuxPMoW0GWw6erYIJlTkZLjnQeuzTbo9uh5rGynfH0Wc/0SX4rtfsn+d1E/XCs5qb/F+0ojN+AGY9oS+GGgBIjr+SVKXYtO3kV4KIhA0CIEuLbQ7KTrbaTKflBmMcDbC7UBb5Q1sPKIBWkQgO6zBclB3v5ejQBZFWyDkirgPDYwi0Sl9DBHLE9hmya2UBeljX3WfQjwYPzEsG1o+LaNLbo9RiArjQHO2a6A5WrVmiywOvGmS2WiX5T1oLd9NQLujBN0rsKZf47/DaQshYYz1e7mCuBKCLAOTUtDjt18XiXQrgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLsio9Qwaa8bvAmi/al+X5dvtB9hb4wxz5jeLulwds8=;
 b=G7uI+Kmx0Pm/WfmIVoMP2bvWh+NlyeOSNzei3PFgKTJQu5+hZZ59fCwFqD6prrrOkNjkKnZgXl7l5Ugg1Y/u/bZF91mWkJhjTq/abtmfCJnTip9Sx/dIfPjeWMTp/6BORd12X2EpKcMIZCDTew0Cv4MH0xlKypWlZm2wektjI0xKV8wCC6K6+4WhH32ux7+KZAMMRPCp6W0icLRYQZjqa54EawkErh/kF5UyMinSGZCHraQyB1pDWLOPvr0JYeWzDioouK1zYAmI4BZpqb18gH73cL7zDyP9b4wzuTq/HU9mrkXr68DNToXHzr98WGb4mRSMuvTCuQYQv1yd2sdvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLsio9Qwaa8bvAmi/al+X5dvtB9hb4wxz5jeLulwds8=;
 b=NBoJtoyrszkQHYZWUedzW84fO+PCK6UFAD1SCtnCwDPs8Wpk/wbiOvNj+HZApq2yYWaR1Ftc85cieoNFW3Dzbguy5ni0doOcxHA53RNnP1eqRXcB3tuU909Xcz3TPsdVTXs6bvG8hwDX28R1O1SrIL/zv84k39DEbNVshXQqH0w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 10:47:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 10:47:08 +0000
Date: Fri, 9 May 2025 11:47:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Message-ID: <e25a6188-8baa-49c9-8df1-5536a0c8640c@lucifer.local>
References: <20250508222041.1647645-1-david@redhat.com>
 <8c94faf4-9af9-4d43-a597-6b06dd21be95@lucifer.local>
 <4efa9948-a523-4597-baa4-c36d18a658b0@redhat.com>
 <a0a54f02-bee3-41b8-8c4f-9cfd7ea524ed@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a54f02-bee3-41b8-8c4f-9cfd7ea524ed@redhat.com>
X-ClientProxiedBy: LO4P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7731318e-9874-43ec-92b4-08dd8ee6d852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ic4uVos5MqRqOJug1GEAugHXNI593VfLa9X2qnwmAff9Ex7dTbsfxFbflnD?=
 =?us-ascii?Q?/K09nOMQ9oACwuHxQ/zBL+5nMpCkzq8rctSdShxlS02pTlckhtDO6vVdBym+?=
 =?us-ascii?Q?V4Xw4Je3yn7kpvdGp7QdeMxNUyaZT6JPPRT+F0yecK6pkmzHmgecK+uVekEU?=
 =?us-ascii?Q?XgCeMq67IMPGgduV7TxS+Cirz+0cR1YfWjOqr8Sf5wNTAiBArDNLJS/9wr5v?=
 =?us-ascii?Q?vbu4Gf/L5PnCF8ml221UaWRmQn+NGeY9GOxXT7Dx+SMeSW/Jqh7NahY++sFI?=
 =?us-ascii?Q?+E/Sd8PpGE+6cSMfJ57qohbuCxUDV9CCJ/4WdHF8W/pZEIh3febtcztZG/Ch?=
 =?us-ascii?Q?cNULpYfScdK4EDFMlJmKBm1Mx1ovDWJ3CNLuzRa1e4EzpP3MaMtp2+4qlkAK?=
 =?us-ascii?Q?GEWxAb5wjWch59Y3G3kFv6VdsyMMIb984/FQVUln304CuTVco9LOS/Pr3ADV?=
 =?us-ascii?Q?cYRWymzRCjSk1phZqvNN6flRTI0vipZ+VNY03UkKZKRiwDvonDwdhc1Kl/DR?=
 =?us-ascii?Q?X0prKEMXlXD3j/YAAnekRxb8S9i9GnnQ5f9gZTKQ/hetMTNGoZ/Yo4lQyfMm?=
 =?us-ascii?Q?cEWIOdUoATb9QD5W3pk75CqkxRfGomBVPKJTABFQcdpoAEmF9hItXRLcLmyU?=
 =?us-ascii?Q?oma7kF5+VXa1B069tr1qCDCt1YIMXuK7fthGvmDjwsju2LOw+/5zkbjiBV0m?=
 =?us-ascii?Q?1HMeMsloXwrDQZ1+8DMEW8JhAOJRu7+Mho+6U307d+Tsh/3c1Pkhv7N94P/Y?=
 =?us-ascii?Q?Ub2CYXsmp/MWVZcQMwKXdtKxH6TIn+Yw+M7WNE0OPDCF1KwlX012/Lpa4jG5?=
 =?us-ascii?Q?iqYylE+qqmYdKbS/GS7vieKOBBa9JOPxLs1sdX+B17aTP37sK8tBcTuF6cIW?=
 =?us-ascii?Q?I71c8qnyfg4Fj2TPLXwfDhlg1eSk/UrouroNZQLrEPXFKgTV801WjwI53p7/?=
 =?us-ascii?Q?U8Q3KxYLWIY10CaTyT59mYFShom1vwaJXDM88K9snAely+jI2asY1ondqKzD?=
 =?us-ascii?Q?jpTJcRRPTNuXaoagz9gO4KlGZCzhYdMkO8tdUms8ytiIGeSEV8pH9w6HECce?=
 =?us-ascii?Q?t3hozoqFM/k2GCFxva92JAnuFuzy4AGAfEalfDxbq+aXTBPCig+8IAX3GNIv?=
 =?us-ascii?Q?0riDwzeHLkScOuIT9gM2E7XLBCdYj1YAOexX9gqLEpwbOAPhto/kIVEIXJqU?=
 =?us-ascii?Q?wblVbZPfuLfeqmKp3f0bI3nl49TMGY+S/E9sGvA90Iuib8/PxXVmf8YGSjVx?=
 =?us-ascii?Q?szIie0eteQPjpPdd3IHlRGvY22L6i4eP2goaIBhQ2a/XFU7z104Zri1AWdX/?=
 =?us-ascii?Q?nlPoIpD135ACCSdc2Ia5jSesRObCxVlseKpdxFrWH2DftQ8+hwzkRkZdkjnk?=
 =?us-ascii?Q?eXKyrDX2VW1MWUvEGXeIVwE7mh17hJzTgLG2dCiO+bY/tvo+9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WoagH6zBOgAh1ksPOQP+LJdx75pIoIhOHG3LQ1ITlHH2yhZNo6b4e/Ers1nP?=
 =?us-ascii?Q?LR4kVHaD0TAjwZFuvrFApZp2UoUhIlZp1wYjS7m0CKAfWbcRUc8BnU3WkMt5?=
 =?us-ascii?Q?BCSu8I496csSghf7iuFrZXy+IzV10KziQAPxHYxQAfgHwKLhFAdxse/3+HFg?=
 =?us-ascii?Q?pvMQA63b5XVjGRoi/EJs49Tx4eNJOrRpZaFtdFeDR5bfV2EmA7Ccr0RMADsA?=
 =?us-ascii?Q?4qfxvBGfunxfYuGT11RraB55nqLHxGvIEdNaN/3Ak9MQ7U3mHnqteObmiVe/?=
 =?us-ascii?Q?BHxUBT82d4XKrt0Dg6io0yI16+mQt/FZpXmvHs8fObo2ktQRqnO0Fwq3N+8b?=
 =?us-ascii?Q?Zp4uesK13LhPXZlvMRqtJ22v9ejlfv9lPwaLtB57auzXccZAsTPmN6elklgI?=
 =?us-ascii?Q?M8mtg/THbgV8xInJ9ZkfjDU9LQ/XFI4+XkLKzcdwOuzUCWApjNiadeizUTn6?=
 =?us-ascii?Q?4fOP4V15c8mLAnPtsz32gl8qeNysS1nOkNCNxkp9aOoy3s+KmQrtVyELs3xg?=
 =?us-ascii?Q?d/qopgHZL9V4TI7xtTVGpCyV6RaATf5072YnNN6X66RknHibWY1hXOAq5hWv?=
 =?us-ascii?Q?8KakaWh9oLmaNP6Ui9sRC6UIbIE5jYciOyCSIOIqfsvPSS4ayJ0/2qj/FljY?=
 =?us-ascii?Q?GewK5H3G/n3N1DuoGHaXgM3sSf8Nm45JswMQrauyHj3D9AC0UJg/K3kIJ87x?=
 =?us-ascii?Q?iCZso2UmeFOiocYwujFD6FI3YCHcOJbTIXTRyYgl6qVAvL5YeBjKcmnd4udF?=
 =?us-ascii?Q?6GEnr9qdOmrcez+VeolzO+981fb4LYh3GHWjd1MoDxQkdehlGsMD7yxX9Nug?=
 =?us-ascii?Q?4yjDDGQcdJn3MdC3M5WjZUMUFwWz7fLK4mC4JIYyfZxdRjkYSsEEQeMNNd2v?=
 =?us-ascii?Q?1VmWUKnz5QYG9/lFOpCkrh0hjy+LJaFVZzoM9XAv5dpKFjP9VeFpNGob5Kqd?=
 =?us-ascii?Q?+RWlwqBA2WIUlIppff9l1/Ivm59A3oeDartrztz0setmJJH6DdQ2wqeeI9A9?=
 =?us-ascii?Q?uddhXGc0fAC430BO33PgEwcpkcwttSytpy7JOUB+cgL3UdvqOi4zYoor+Qg2?=
 =?us-ascii?Q?hQkbmObaY4B3gcXhHRuB8ZMaFwaOfVqvuzHoL/VjWONBLgThnxAVFyASsaSd?=
 =?us-ascii?Q?j/QJ8iz1oxUTMwXK1Fxax5mEUVbqze7unNDM9/9w9ARD+7UQkVKscg4nEztB?=
 =?us-ascii?Q?XnUIrBzzjNqHY/XbNhZe91BQrhj0coZdip4Otve9xt/jqYLqMWH7wqSGfMyP?=
 =?us-ascii?Q?WWebGD3Q/Cb4AzehlqKTqFnnoYPC3QLE0fVb5UZLGvu3kALk8DuHDK+MEGTC?=
 =?us-ascii?Q?xwNIa1+tbSi9zddEZtnrAg+Zi3DI+V8pJ953mpgRRrkuT0eoITgBOqDQEtvj?=
 =?us-ascii?Q?fxmPJ7BcooABNP95QlBZ+kM1u+YIlwT7o/y7YHBqHQ1mTvs1oGjB8LpwiBT9?=
 =?us-ascii?Q?cFo1vTOqLUU3xnlEY6dGWuEbmvChXF2XrJrBnftBCRWIxYaDXaixPbViWl46?=
 =?us-ascii?Q?+yioC78VVcbx2bBxVVKDriuCjtzanEHJAvfGlrewg2inhUlDDnPc8Xr6q++t?=
 =?us-ascii?Q?ycFT/0+N7RK3rLS+bH0tIC6QCb49xZ8GmCAf+Yiaw5t6URxkeneUCxLMHRgz?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kbjjqAeSP1ctTmC6tS1tRmaoGgcBf+C5D+eg8ztyyxyOjBVxdh45Lt4fxHJ2aSiMFIpouCudLk76Ic4P99iC5cYnOoedKlewA6cQR2tUztooYQUYF/i9EsuIWDMBD8ohFFPV5PLNyNUuIJH92wfdWoczvFYmVl3LvaNWQC7GqSlXlJPyX4x7R0V+6SrMDIMyyzTK6GMHSnsz/pR5AYNUSD9DfFM0BKQnHuwJFYyuVGdr8183tOLpgxja4LpT2s1isE/kS1Vt7skDqGOYjWKjK+eBrqIkBdTtqwNN6woXm9dQ5t7WAnnAlrskd5d7cTRcL/Co/MALNFCLZe6fUkfQ4sID9ut8+7Rhlc5NFeSE8vdijaeya0ciIwjo/QoExuBfOWpPR3Q6dAky/MU7tfUxTmF4f4hkd67YEy3dWLuU+/xs5+U27l5ZQce7bYuXVcBkcEXRamugQ6a9v2WJKsyc6DrMTrSqpgVBblk6lewJD6j50Ujj7mltzBX5j/KfQFqO6lpLwqTP8HE4Pn9QG6ZMTTzd7LoH/pBvakcZSLbJ5/w5Nn/qd81xfE6lxmWBNTYP3v21zkGMe75k/VyoCOOEBKKi/jnyY+W7JaVNwahKTt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7731318e-9874-43ec-92b4-08dd8ee6d852
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:47:07.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmvadVsYyiWODKijze7pX2IUkn8LybCd9v7Fnn3A2eSx9NELVXgtyoISvf6d+YQSAh0vbdpNX0BbuOgEHGOKNHgZ0Q2nfCTxmJ3Xv6Pxs6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=623 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfX7SgcWD1apriW TMNGDqXwbHObhwPCsOVqqKHQLNxwPGT/gfE1DO+ImVCm89aMdXZQ7d4tfBrYeDzv4Rq0LPqgP0S ADPfaJptpMNYrVKtYoDL6wuyXU4pf/W48c4LSxt887Fw8pNfVYLxRA76dJQduzOZDEOno2sPkze
 y+Dss0sMympXX5BGrFZiC1Z2oW/OoCRDQyriBX1vGwn2/uqD/136+eAtVbuBLsoe0lmt44Cl3I2 GD5HXj2eBBUqGiH5IxK2igtK5sZ0Lfnxrnqlpvih8u6bEk3gbBpjduDgotrH7zxIbME5qnx2K0R UnweHXs/vEcHJ7BfQQfMn6/USl7TV1+KnsmR8rkoVy+EaJrqeNz51zrUThBqKq2zOYnhnRWFbzz
 w6a6P6W4W3xUWe2AA0CTdwaAIFq4uvkjC+NtSZvp+y7ZtzKJ5FvaKXZjpQQH48pmcCURdpLm
X-Proofpoint-ORIG-GUID: NNMtp2E5zqBwNAf802J5hMp7ZhAPb9vo
X-Proofpoint-GUID: NNMtp2E5zqBwNAf802J5hMp7ZhAPb9vo
X-Authority-Analysis: v=2.4 cv=aYRhnQot c=1 sm=1 tr=0 ts=681ddd2f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=z8OtOXNS37YS8Jo2DrwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694

On Fri, May 09, 2025 at 12:43:49PM +0200, David Hildenbrand wrote:
> > > Is this not pretty much equivalent to a volatile read where you're forcing
> > > the compiler to not optimise this unused thing away? In guard-regions I set:
> > >
> > > #define FORCE_READ(x) (*(volatile typeof(x) *)x)
> > >
> > > For this purpose, which would make this:
> > >
> > > FORCE_READ(addr);
> > > FORCE_READ(&addr[pagesize]);
> >
> > Hmmm, a compiler might be allowed to optimize out a volatile read.
>
> Looking into this, the compiler should not be allowed to do that. So
> FORCE_READ() should work!

Yeah, was going to say I thought the compiler was explicitly forbidden from
doing this so is a rare case of 'volatile considered harmful' not being
quite so harmful :P

>
> --
> Cheers,
>
> David / dhildenb
>

