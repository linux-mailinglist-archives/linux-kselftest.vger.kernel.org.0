Return-Path: <linux-kselftest+bounces-19934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB79A1D5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EF41C21502
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0C1D54C5;
	Thu, 17 Oct 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hs/GkQv4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zfmG5a/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD5762EB;
	Thu, 17 Oct 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154360; cv=fail; b=NMoFtDFBYUYQJcPVcxkK6cOhwnLa5QjibCbpcZM3s73Rf+m/XXFlz4NQFqsCAUIAhIRioV6Yc5uth7x1dgFtl2DSgbbrG5PYUSKigtmNxKRTFHwXs69Rg5ZwpZz/5J1qGJqcwGttyaWco+oWcpvV3Auu/fXsivhY4ezl5WanNLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154360; c=relaxed/simple;
	bh=jmk4iZyPrx7cZdi+rvUQfxV5jy6rg9qIuhYq4+V9IQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G46RCHz40FdX1qMtcu5N6eq099uqJJy5qzKEfKMyFg/G72YGH0Go622rwxEEaTtyOFXkA4Nz2rjNQOqgJfddJMnYssXTytMbevzEs+hHr1d090Gq921hiZ2wXiPr3ItENBmtTLiM64n9c+5ZfGrtXscjWTfqPyfb3PIxFtyr6Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hs/GkQv4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zfmG5a/f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fcWA031797;
	Thu, 17 Oct 2024 08:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FU5jLOIcb6f4Lk03ze
	uXMImGs6jg/bmYb8PlVvPk+e4=; b=hs/GkQv4vUJyTKltxlVJrCbwoHHx/odJ0D
	I+Fib+BkHy2fgq14FFWhqbAOqW1lvFS5+qQtHGPonkfCTY9OAWWxWKNJJVlASYPM
	1SIXbCqXoGf94dPpoOhIvF3Xu9C5aqmFRrZx60NFE45QXyEqk4n5WPe88qAnvc3x
	Odnzqxs1sxEQOzP+fYBOswCOGpg6YwhLKOpVHf2T6cUo18cul/lhcK0zWCwryg/5
	oC+X0DnXn/AYkM0SALKkibyRi7nH6+DyaHu6W9dCeYLarIaPeV5Nd8fTsO3WDy6P
	3wT/W9vr1+aQ16TJzqF5aMByK3Gf5DqdtzF4mIYNCDYquAbM1LmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntdsjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:38:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H70KCu027100;
	Thu, 17 Oct 2024 08:38:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9wwhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:38:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAPqvttNNYEPSIVAJPvyjDnZDXqejm9OFI1jMJPCOLFMQ7DGlvSFLJBTmRsa8ul5COdExS0Xek/jLtl32xpjgEqJWx5bAa/BV4+kOJ6DZA0M/KjxfSxcxM9aQaV+mogzvNAVJDVYdgUdJxXvYvVbcHh0KHNGBwkOqob9A21yCHoYo/x4gg0GmRy4irQK+JyoQh8ZJY3fhGT90Bao1CFB/wmKOSnPZbqKcT49/r1Q2520zeTtn7TlsL8LsBIH7Mu+fmJJdPnIRVoj9W1vEtoH/nzLcuLfB+WiUkZJHcbLzfO5y4BwImBoGxM2qaOXN6vQzqKxDb2DzdMhGVFqmYFXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU5jLOIcb6f4Lk03zeuXMImGs6jg/bmYb8PlVvPk+e4=;
 b=qjFkGNrHuBnZLWEM7xGrbMoXFS2o+/eDsjnB3gOFxLWsURrEMEnoRGQRHHOIDybG8VQWUnyO+Jpp55Xe4FRsRQfAP8QW8tJ+X0prBlBZZfiqSYgj9Wt30IP8pLifPPO0/bQbghIDEIAHIDaONAFcLX5BzeaxKjUXqm8TB8smry4SQRqs3Zzid4xK2gNcIRWmPF1YPNfzX4N5rv2QvUAeFNi5VvkTs/acuBQYgWCYqmr1XZy1IProqoayY33pyAnTv83kVnpT4xEA3dUBoq+DzY5d1HL3iesH0yl2Bhlj94l/yrleRgeqcIoH0HU2NsDe4lIIZ6aNo4kIm6aYE+C4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU5jLOIcb6f4Lk03zeuXMImGs6jg/bmYb8PlVvPk+e4=;
 b=zfmG5a/fvgmhdyHmDZEH8lYDy4w4nWJoyHHDZ1FPLjgZevr4ePe/oQMntBDnloO/g3AaHry3q69K6JYW646kKva7izZ6ghT1N/jPCI+WciaTlyiQpEhMq5+1MKVx07dzJpFcZoOyrc2Rg5JgprXH9lCs08WORpuQT6Aos1fih0E=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6260.namprd10.prod.outlook.com (2603:10b6:208:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:38:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:38:44 +0000
Date: Thu, 17 Oct 2024 09:38:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, Liam.Howlett@oracle.com, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
        pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
        willy@infradead.org, gregkh@linuxfoundation.org, deraadt@openbsd.org,
        surenb@google.com, merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH v1 0/2] mseal: fixing madvise for file-backed mapping and
 PROT_NONE
Message-ID: <c348bdfd-688b-4260-84e3-3c36a534c807@lucifer.local>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005105.3047458-1-jeffxu@chromium.org>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cea47c4-423f-4ac1-5235-08dcee871c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qhfccv1eQgyHVJ7glDvAUDxehwNB+xUGvGOdquqIMZjllxtDSRMJRnmoKS1n?=
 =?us-ascii?Q?yT8GswOrmNjVU0Yz+LU99zw6CM9RWzltl++84OLuwbAWorcN3ESwfE0u1AGs?=
 =?us-ascii?Q?RatVwMPJOfh+3OgJGL47sHcSTeXmEd3ovdNvJaihro++QhVs+gCac9WMOCYk?=
 =?us-ascii?Q?Sekv/IGapAmVIaDNTgqprJzNpqZteLcyNZQt0SSXp3NYOQpJF8s3wwDQ3ang?=
 =?us-ascii?Q?0QYWak5ySqd9OXzggOxJ6/Fzs4fFpXl5LgQckd+8M0u5l+CRm6dvEM9pUoKq?=
 =?us-ascii?Q?0sM5JemhPa8boQbAw0ya+MMcGaqNkawWUMhVcrX6cz9FT3VBDUDSzI80QUT0?=
 =?us-ascii?Q?sY/+E7dnXeNaD0MHoKc8bGF6ZccVXwpaJaickq3U3RssKYMEzzCl62dVOcwv?=
 =?us-ascii?Q?d41Y9x5o/9Rlh6WbbXCQDNYbFLnfRWzfbpF/9/60uiq4ubKfPObd4nFnhHHe?=
 =?us-ascii?Q?WDq0HNtdhCaB4Pi2+KJ8b9QMqg7A59utTH0E6dj7G3YuDqU3uO/qw3amV3GP?=
 =?us-ascii?Q?9mtdhRUEmAdaXbcgUS++KfDTZYrS2IjRrn0LPUVZGf4dtoqCX+hx6A5+Se59?=
 =?us-ascii?Q?AY5mExE9IBf2gl9j1UwYDT1XmVOLWobkYoThIGPaW+sRYtTJ+RsKthcoRyGq?=
 =?us-ascii?Q?022y+GyJIKqsQEUnBvSFxV/6BXpia9769+xtd4msZBRJ+V8fXEl21SdTk8t+?=
 =?us-ascii?Q?qJp4HAODRHJwSAjKgn/qfpugMGEaVM0EvYMPnoivuIHMPAcjDfE6LzUqi0QY?=
 =?us-ascii?Q?tG3GHnSoLkc/0tu5AZFfmzSPNmBIJG+7spDVRJX8ismzQrO5eIubap5Erod9?=
 =?us-ascii?Q?xesZw72wmX4gh+soISe88yWVn3I054aUC2lATmS2KaTSkuEusB2qr0gmSakn?=
 =?us-ascii?Q?/h7hgBstyaoPScT9X/RKFh17M1IIsPI4cJNYXdj6S3nlMEHnf5GOa9q/Fyvo?=
 =?us-ascii?Q?DaqMDblVhpO7ghI+VmgI4AxM94zI4pLXhHkxRpEJpGqt9vmdLSE8IWS8+Kn8?=
 =?us-ascii?Q?d7vD5VXTqiRHP+5u58YpG2+xUv/fAbkGl5vk0e253UABgUxdQVU/Tbzbz2l1?=
 =?us-ascii?Q?pzxjlE5ylQJPmYPMrr/e0FqXr1E+9Vrbfo64ly6rsJ0gb8FN/bxFE4Si7xu8?=
 =?us-ascii?Q?CmYP654CaGE36MjWPPgRYdAU2LwiMc/bKz7XXTltWKBOMpNS/Ss4aHSXNDq0?=
 =?us-ascii?Q?4DDrJ7GIRkm6p7YrytpxbR3F8v1p4Qx+m4Q6Yg0/Z2KALmRS0bk+ogGgtpKb?=
 =?us-ascii?Q?DlA+icY81+ceG8oTwWwwsVENtQiRlLRWlaWJI1JI08fy+K4z/rzFU3YIUp34?=
 =?us-ascii?Q?gRxbZN7v9PAVNZ6AjhkPfq/o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsDKer87SOTBxDmPcFD7kqM9fBMcX4UvfWPm5nxB2EPqtyoa+ZgrXx1XAbMd?=
 =?us-ascii?Q?G/zqRmbsBd6+Wp9gs1NK66aNSRzE2hVlYp0F0WK4LMNLxhXvbu45ARC/5lnI?=
 =?us-ascii?Q?eXJoWnVR3An16FB3ksLD4/LVSqggS05gjbT32IH0TlNVcBVGA0wxwDpmWVVF?=
 =?us-ascii?Q?mLMP537YNgpvhJBJxY4AnIEG91ZGatzNvmLdkMddpWmPYDW7WxaZbVU/Ysp8?=
 =?us-ascii?Q?2H4BIQVkXISAfwWEoYa8yFoOSlKH63xI84Wc7v5GEQgSq8r1Nke64SHL3Pp1?=
 =?us-ascii?Q?4yfeg3askLIdCzmPASwiQw3q9XZ8XkMdKgyvW7vAQ46Zqipb1y1VDTvTRUoT?=
 =?us-ascii?Q?HEAmFvwRNheGoOU/pbXK72mQ3GW5tQ+MWUoSilaESbTQu3y0VA5q7tuMlMv+?=
 =?us-ascii?Q?WKPZaUGlTP5+1/7c90nYIlooan/pYtK2zmTR+9ghMnetBPpYoAZ9QMfYIaVw?=
 =?us-ascii?Q?LPdE1eSbNdJCljACREeZeB0HtE16zOUxm6IB6FWDrVHrNW/A84NJXP7s+65P?=
 =?us-ascii?Q?8G+E/NmhdhKmHYKnypK9Px/V3HhhnKTM+yuqzNAlIH62ULJlEbnZQVMeZXZ4?=
 =?us-ascii?Q?Q3Rr1mhFAnYYNJ5p28XtXj08QaLe3xGwKSkuQlF0csjGbt/tsUI8Jbe93DbH?=
 =?us-ascii?Q?DeTXFApXX+4M3kSvbae+ICKapxkcJKvvwieIJak1IXH18wmnYNfm+wfiXqSY?=
 =?us-ascii?Q?2N+6mIRWG6pNhL31JXJhLFsowWGNd1EGBOEjZsvY9geq8fSCU2TL4D4ZkMNC?=
 =?us-ascii?Q?3ik7dqjmV3mpjKgycNR6pjawr73ull7Jkeo8wIyUZRcp7tOhX9Rur4BdI0w+?=
 =?us-ascii?Q?Up0yvtlk/9h5+HMz7NslOzsKuY6JHXKRbdx4a2t5JJeMG///HPGGI6Zl6aEL?=
 =?us-ascii?Q?XM7AUOd4ws7e52EYuUMgczZGZX9vL+4zJMIyPouGcnduyj3fMKmFYkkDqxv0?=
 =?us-ascii?Q?IspO1e0s0KxCYhYscel7g1WErVzfPsAC9EwVmckeX/fjdyUB5nKleVebZ0Vg?=
 =?us-ascii?Q?LtfyNirQfk/YNBkNAH7tKbU90PRLrMPqXvmZ4R0zpcw/0t47mBMSPcwM5fwr?=
 =?us-ascii?Q?glzu3l2s6qXJsx5mZP+OXrRfIuX1UmJG0I1XbVr2/tKkfSWlhGD1q6w9fUas?=
 =?us-ascii?Q?FRMtCAzDwSRguVrpESjnm53EkD9mlbFXO6Ya8hPEAQaBMgYMgfcfNl3Lj3fZ?=
 =?us-ascii?Q?uWP8SahIQ140wK9ttF+OTOdTG/rTbL4LYEylLVKhAQD7zAT0LmIq7KNmZ4m4?=
 =?us-ascii?Q?PlEhKoTWQxbP4gFKsPBV6mpeiyZAXmaDEEBZaObcbSpwy6C/2iZIGJJs4mvy?=
 =?us-ascii?Q?uVPTRF0AL8yCpUmWlXi7CIDQ1Li/AD6JsJKCrTvAt9ePuDNtDhYu8KJGaXuF?=
 =?us-ascii?Q?F8op/zfl/+t3SPJ0atPDCeNnqDQKDF5RuALiXj26f+oloRFuxCsGUKA4+YQ7?=
 =?us-ascii?Q?KMHYj+dgPyBTMGr5k3LxZFZKp1eFD9o9V30fXq6rNs9q7Tc4xHKCBvpYu1t9?=
 =?us-ascii?Q?oO/uvNHgN2pe5qVLse25CAnLOT9+j2UIdfcsBTBvWEr/OkDh2W35fKLbT3XK?=
 =?us-ascii?Q?UFNrr9LqnvW8Ar/H9E1SVH4l2Ej3pqo0pfkaz29SkbGwG8AH74LJIJzXvFNN?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ovwmnsB/WgmjadCsXBZkmSRHgV5NGDghlCxcydGLVtC5XsjWxaWwMl+2XYSnt27rlvL9DUh4bgXrQ6ZouUabmShAlqdglX3SSKvqlKEO4Mq+KML3Ffz+EVeF2PKN8wfdcZ0RmXCJMEJ5XPtAexyzIbdCGdsi1GD2JOnpV2xOfmpHa/tvhLhQqzU9rBEdG8y73YnTbsSs32/5DfOrUW69yc+cGgeNKc8v/O0zOBqbWj90p99NmDQp7x8CSxTAYA6+DBwxSjMnZ+nhi999LvISo17iUqxXG+IkCa5BBFYNy7ckwM6YFxXqGUE2fGldFxkzeaiisfpR+APT0g5hme1amWIB53nZHG6ep88fRvh3lwQ50WrtpS4S/wKTzQpMybXOx1grbmwlkNIyX7vD1C08S7cGktCwjxgOhuFM0Z0Lcv3lgCPdRkOu2m4K4AfOkJH2VKZZMckP5Vgj7v4qlzkd/zicAvTxby2NueZrQ91/pm4o5qQy3tUEU0i+vqryf5z7AFMcG7UKD8eipFwTdjw6kXoMTZwOYoRIUcRKQe5hEs1NRwW6GCa3UgJHGzGxNBeiRcr47Dj/QCQ+2vQd45KKclZBcq8gzlZra/I6ujKWKmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cea47c4-423f-4ac1-5235-08dcee871c7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:38:44.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeXFy9ioV6xbOV61urdmBWuJ3OJghkacZN9ZVZbW5wRVukfopqonyS3bzR3jUCi7pqUwPHifWQgKu3oDWZtorkHrU2s/sRHzRrveiJTSYZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=972 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170057
X-Proofpoint-ORIG-GUID: 2K9ihMXZND_VvyCMUhi58e2NjH44KsNk
X-Proofpoint-GUID: 2K9ihMXZND_VvyCMUhi58e2NjH44KsNk

NACK.

On Thu, Oct 17, 2024 at 12:51:03AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> Two fixes for madvise(MADV_DONTNEED) when sealed.
>
> For PROT_NONE mappings, the previous blocking of
> madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
> memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
> order to free the page.

Except if they are VM_MAYWRITE...

>
> For file-backed, private, read-only memory mappings, we previously did
> not block the madvise(MADV_DONTNEED). This was based on
> the assumption that the memory's content, being file-backed, could be
> retrieved from the file if accessed again. However, this assumption
> failed to consider scenarios where a mapping is initially created as
> read-write, modified, and subsequently changed to read-only. The newly
> introduced VM_WASWRITE flag addresses this oversight.

There's no justification for adding a new VMA flag, especially given it
will break VMA merging for everyone.

This whole approach seems broken. What you seem to need is to check whether
a mapping _could_ be mapped writably at some stage.

The kernel doesn't need to keep track of all the times where it was
writable before or not but rather this.

Please look at VM_MAYWRITE and mapping_writably_mapped() (to account for
memfd seal behaviour).

Also you need to rewrite your tests to be readable.

>
> Jeff Xu (2):
>   mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
>   selftest/mseal: Add tests for madvise
>
>  include/linux/mm.h                      |   2 +
>  mm/mprotect.c                           |   3 +
>  mm/mseal.c                              |  42 +++++++--
>  tools/testing/selftests/mm/mseal_test.c | 118 +++++++++++++++++++++++-
>  4 files changed, 157 insertions(+), 8 deletions(-)
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

