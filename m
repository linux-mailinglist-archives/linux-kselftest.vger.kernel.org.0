Return-Path: <linux-kselftest+bounces-36821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E200AFE8EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3155680BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2A28C866;
	Wed,  9 Jul 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmeo0oIc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LWgCdk8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09A1FDA8C;
	Wed,  9 Jul 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064142; cv=fail; b=MFiMSpm9pc+BjgwLdDqtJScYva6IIAbJauUUxXm+2UNvaiDp6eBcUz9H2L3CsgHb8qFl6tzWp3ullRcViczHiDfXxFhZneaKjMYkf9q2uSDYRPMO0J+o4TkkCbhlWq/edfjJZ+DWjNxZ8/rSA6s2f6YBTYLfo/NoLxvjom4OvKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064142; c=relaxed/simple;
	bh=1jQMwn7dKImEEHVU/OGldcWp/QDVrZxEPO+UPYfhTQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0Uz8MkqNg98AWJYt0+TBG6bHinB0G9bxZmpqUXbtILV2LVofZ3aaJ79HGpZ4++bYcTQiWK4HfQEyzmf6ALU0uxY/73ybz00BnxGgw5tL/W4PO6gGKudBa9ChKG8TNQq37DSVPrVPPMAL/kJ5ePB2eS8trd69MtgQUKmZ69C6UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bmeo0oIc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LWgCdk8C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569AbROA017721;
	Wed, 9 Jul 2025 12:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E3AlP1Z5HiMtHE3Qmn
	xSSumA/o3W1qK76W/3qdcm+HY=; b=bmeo0oIc7DCF1VKJWVXCeHwSn0ZzajbD4/
	u3L5ZGtFAcabTsgAnVO+45zi1CUL0ohzAAOXCqIG2AbUbDXR2wCpJ9uTjeu7v8jI
	/hPQtr9IpCXZJBnW0SYQAPg9OFmOMynr7jqngT/ttEa3223f5ojyObV0SAiUuikH
	lcf0C9+YQSRYDEMz8ZmvMafRKCG7+3Wv3jH2gn+tAlI9HkS0kGkjih3cai64iRFG
	Gy89b7TO7IYo2h3kaY1UlaQ4rV/hwTIpUSIb6dKHwJPP5fTkEoQFxylpKgiPJpBz
	VBF76riZ8g7BZGaW/ukL86jhqddjOHTq8yH4vXrgSq6t/r3xy4lg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sptv862y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:28:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569COw45027368;
	Wed, 9 Jul 2025 12:28:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgawe16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTR1qEeTd+LrNY/Dh7j/GGXHQ5DdaDW2qMTjSrAXAS8cUQXuMN6tuTFuSH9YM3c9FXMDbgL3rnLNmsFNhVJeMYCZ12jLUfK6cpKXDaRMjhrl0xO6DzrBP3FIDZRvaUwzJQzeMxW7dcKhyvELsNmikRQZ6rXL14SH4pDGikHacPEIuOWQtplDY8b0/lMKzESCb4mD+F/3klw3t92Yh19+Bk8DE5oXGb5tOXSXOpznYh9PkXtM9LcEVCLR2mWpwC8RR2mPQZycnTyRQHX3j94+VN8s495UjauqrwtQCXtRIY8nWo7l475YSFmKZOgaGwY6WIcMbDQ7zTc62pXjDCVVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3AlP1Z5HiMtHE3QmnxSSumA/o3W1qK76W/3qdcm+HY=;
 b=VKyM6lO9/ff5w6it7IUGfClmsXiyMkir7xeK+/RXXnCadd9aRy2Gn6X0dVPs/e+PKFSkthzI8CHYeHiMQ4WKEFJk1+M2V+WODYvVwzWadg0nX1GrpI+U10UmmENFUI2KBUFSQ6GoGPqH9p5LJI7SsOExbvdBveXSccZBF+xkewUCelA2je1fDGZru3ozRKssFfISPX5bSjEYQKZxSc4cm/wXygBEtw/AN5KrUZylrdLrvkkaBkmHgoZhgbmbeNLUPmLbcbVZiNMN1m624Rqyq3F7EVHfdomGZpHkb/d+wZfZbF/ZCGxESwi30a2htoo3deaIQL0LfB6D28zdei4TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3AlP1Z5HiMtHE3QmnxSSumA/o3W1qK76W/3qdcm+HY=;
 b=LWgCdk8Cs9ZvQScmzK9UZGh8x9Do0EKPR7hrPWk7TGEvenvsvnCLeqS3TPdF30ZeuPGqCS3kLgUY87BK347s5T2dtOGFyeVDCpWcKWu8Go02/r4I8Y6gTfeqxvs2QmwzA9mX4W5ImljvhR4q24CMpnln2l8ODYLbR2znRKdo/GA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 9 Jul
 2025 12:28:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:28:38 +0000
Date: Wed, 9 Jul 2025 13:28:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix split_huge_page_test for folio_split()
 tests.
Message-ID: <b69225c6-1c63-41e8-8c40-5ce52f5b0616@lucifer.local>
References: <20250709012800.3225727-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709012800.3225727-1-ziy@nvidia.com>
X-ClientProxiedBy: LO4P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e1761-8d29-4da7-3e01-08ddbee4216e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTDcE53pC6S7liVphduP3KB7mxpAV0ok7q0Tpe1UpD8Z3FnisayVKx5BGhWr?=
 =?us-ascii?Q?joiQh7PFgJlPb/up6j5NNxCbhLC6HKDCQ+f9Ldx1l+V/xibqeapnN6DPkc6b?=
 =?us-ascii?Q?sxCVeHas+VWEVrqVwnHvIWCRDDYmau5rSx0xvJyq8MzncCtyJTFw+hmGjTbF?=
 =?us-ascii?Q?mjUVg4H9tqvMwrFxBFeyE+BP65xQHWBfKUqKoiCwMFuNf4p3C0fEhminBxp6?=
 =?us-ascii?Q?pjvRn8wxZeB+k132apZzK3NVFU/iz3jdGV9KkYKMw3841uzwf/LVq6oN7cK8?=
 =?us-ascii?Q?LmoKd1fsS8GOZKyGu25+I3J6sqNNzNdi/5WB/69b8F7ZR8L0WBf/vkAzR9qg?=
 =?us-ascii?Q?MQQTgVE7xPxsbxZG6xIftmzq9Y1f8eieRw+KEV9Pg81Bmv6gqW1ezYr6tclN?=
 =?us-ascii?Q?fedwdbdSvoMPd6MaJIXNq2kVPseQk86e7SMlw2y54/cxgMawN3AlVoCyvRp3?=
 =?us-ascii?Q?Ud9iXveQFZ6oKSKExTgwkrHd6WD5hH1BHek3doDDOlrLE0fUXFjwkMJaWcl7?=
 =?us-ascii?Q?pIwAv5QXgKw5CXR1PuHSxzJyeKLooxW3UgOtQIV1pGLuvWOVh+VDne+nrmy2?=
 =?us-ascii?Q?BXmE4z6bWM0arWILk9cwUh06J1iEPfCBgsTNbeKy7ILS5e60tIuNh6E9pGwO?=
 =?us-ascii?Q?Umhb+ig4IVfxH2Z/qDs/r31D/0YYPL3xVyK3EY8YvjUckUb7bAi6L8/QkCub?=
 =?us-ascii?Q?ZZUn2FUeDhUE5nAtEfOKg2bAHqxych7uHnjxy9upsr8wUxPPlUDEXsVfmPGm?=
 =?us-ascii?Q?bk7UhAA/ZYG0LnX04JNqDp8bOz9pLrMbaf3Keqo+bOSDgZLMusxNLwsSb+hF?=
 =?us-ascii?Q?9vLuwJ0Ze/jPcH2jkW9kOaS/cYCEXNOH4RxBst/+kDtmCXJvt4X3u12c70gf?=
 =?us-ascii?Q?Dh4oUQ1oWAMN1CjH3tuknjGgiKggK0CRDtLGiEmyM3sZG67gpxQgN9NWGThD?=
 =?us-ascii?Q?r7FMdzuGZA1kNCZZWniCjc3djWpBF9NR7NTV7VWL+cVDpWCfJeDKX2/MevsE?=
 =?us-ascii?Q?tt+0avqnV/XslGd0WC+CWrzQfwTOlm7k+PAAq+FIzbhWv4vz0z5z+LXtuDpX?=
 =?us-ascii?Q?i9qYv3T0PlaFP4Fl1pKfmfa/C168u6mbuRdW+qJhupw7QKUmIgvD3ci2WDZb?=
 =?us-ascii?Q?GoBNSIMhtq5HChdrSR/fpBuyWevwFiG5IxQSKBvqu0/ezrXacpYxkaj4efdz?=
 =?us-ascii?Q?/mTKVPfMimxiaqXmHygZWZriHvjz9VCznT2KpTOKbd/B4GTV5JHhNmLNiSLb?=
 =?us-ascii?Q?QNLRYggpUqul8q4CqQmwkXKMDKSvqPjTlft3B8MNpOaOm6O8RCkm8H/hEqi/?=
 =?us-ascii?Q?8CiqwAcCa+r/EWECleZg6fix1PQGeZs9Z1aJtSW+SwP9Kl+3UyE6hFvZ/qdc?=
 =?us-ascii?Q?T5KmFPwkyM0umMdQ4MkZ5FtcUZux5gZptfF2xi8aQl4MLCqD6h2lkKDzHXnp?=
 =?us-ascii?Q?mHJYuNsTerI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdaFZtVmU0w+leZHd9GtREiXT2IxTjbcFSivGmRutbwvqJghxCLscLvgueOu?=
 =?us-ascii?Q?CeqJH7ePbHRotxrqIQRjUwioVyP6FLO1c0mHjDTu/iiTngL1/fXWYPxSPMnn?=
 =?us-ascii?Q?uzbai/j5YpEPBCh5FMvGeOIyzNve+EzX4Yoc8C4ljpdtubIHTOu4CIDqwDM8?=
 =?us-ascii?Q?8IpqCdOhTyiCGFIuTDcqxjRZcHYwz/4eKWZzQoV4+DGMfAJXTHwGfBa3Vtrx?=
 =?us-ascii?Q?TrauVESAImWbbmg+3RBzMWSf5zRCFi7dy23r1ADOYtXBOXA80wOPNz2B4/0H?=
 =?us-ascii?Q?6OIuXTMCMgdNYWDFl3b264wpG3sgoFQ1KjHWPuwtqLRsF1dcf+v0XQPisqhK?=
 =?us-ascii?Q?XO5IjuJTxKvkNIsnczKH2Xksg23jChXoNXAu7uITiyQcQyy7CcdpkVOIGO3/?=
 =?us-ascii?Q?+5WrrNQQfdgyiYPHmziHPbHCEC/W2GCGoAPlBlfe+y/Legj0ZFt0Xa/z6tjM?=
 =?us-ascii?Q?CEXc15KIL6knoyMTWoTCRVz2Ai4hlmDc2HnG/j8uM9g2w68KOOHmNYKcRNXm?=
 =?us-ascii?Q?dO3S+a7kFUiNklnioJd+izliAIFrWm2Tv3Khx5z7zZ38tTGkYkVEeXyf/xBW?=
 =?us-ascii?Q?PFZgloLJAGbb65b99O/9uZQwg0zpeoKyj/LYzEY9iikJ/UHFrx0kt2yHuVe/?=
 =?us-ascii?Q?9oNxcTsz4NZE9XrjJrV/g370d2R9y/QsbeOtDmF6ugD7Fr3ZVKbVCMRM0LyR?=
 =?us-ascii?Q?3CuZWb+4QbQ3+hugccNFxWjXf+kGZBQLCb6bGlL0Niyk8LDe6MHNqDrlreGA?=
 =?us-ascii?Q?RvzxRCAXMn2iyr3cFfWNeSB+0xx7i0yUU3hVvmaFVe39T+N6AaMFKCyGvS+o?=
 =?us-ascii?Q?h32/UBPPhMa6caoQBsiwH5lzHdbmuRZi1Sa4JB+4f/xbdt3pArjaBnOawH9+?=
 =?us-ascii?Q?gyaqnZgBBiA30YpiOkp7NoARii7mZ11TzxrLOW89mIIfM4k0tH7CW6GNeuUm?=
 =?us-ascii?Q?qD676dpH5CCy3vu/rGwucGbkOIBFMWFgKfUO2i55kETrk0a2m58VbxCwwK7T?=
 =?us-ascii?Q?iC8AgZ/alANITZOHWXZ0mAvjKraLhjoETKJQO8MJUMid6eQ6NCXo7Kpnh3qo?=
 =?us-ascii?Q?I9hr8Eh3k0ZpnMPGDVxtrgirO1oV1dp0CBoU28RKAmjNFiKY3D2CtAvAwYA4?=
 =?us-ascii?Q?vA0sZFA7JHP3YKa8PMPgXfx0KtOjPEb9/8m8UuQ+j8MqltGInibV6E7qaVAq?=
 =?us-ascii?Q?6wWW0IE4feNsq+3JzH4JiMpHQDLzAQvef6bhGoDZDj1vggi7Q7T2vifId1Xj?=
 =?us-ascii?Q?fTy5v95pIArAkXk8o7UFmt8We2TQqK5DEj+6GYEXbKSJBQ+eZ4mrogqoqskI?=
 =?us-ascii?Q?x3jxiqGvOZAX75eYqyxG4epfsoRqEtn0H3BucsnGTdSLvW/2A3gBkXDF5rTQ?=
 =?us-ascii?Q?EsYni+1xvjslTuHfdPGCS9QbNdFPJ004X6Legb3x5fN0MNuC15RPR2VAuyRN?=
 =?us-ascii?Q?KM0xUcaxdfp2/JDoOacCFXvihvQg2LzRzlS1SzUK7JzhRc5133hRxgDK2fSy?=
 =?us-ascii?Q?Doh100coVxSa9MDEcXIRzJzvemu7/avDm9tzYYAEoXG03wlIjTSldISOdxJA?=
 =?us-ascii?Q?oZQ6ULjt4eAK83hcVnX1Zwx+YWjTQDDjGF9Ca+s27E4nPB81YW2WgK7ONtKK?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jE8N5a/1pYUd4G16QaXThvQE5BNPdEuMXy/Utn2ElCTbBV8Jp+b+NvsBdLZTOVNu0rRagEL4/KCPp/MTWnQzB6SoFoUSx861vaR14MX0EJzCmC5JuWyDpRpZ/90kzcgVGGz5Pvfy74W1XXCtZhX/UHl9DJrYcqEYwvUcwWQs2ZQeUQ4eRWG5MW8cIHHQSZ5sPBLT/Of0Xci8m9GBsh3ZF5e2R47Mb4hDAX0zZWgqi7/XgTsku+UTKYkLHHaLUM7m3KugbUaksv1UTn9Y+5oyAcAYYH9RR+PwrQ+UQdttkG9WWDW8VlC345ASw0I1fnf8fJiJyOGg7bY98nI3GormldHmP1DbHy/GtQPV6ZA1DdVUaqkjUY6+vXfZu0o5kqt+7pD6fyqENV558aCT3aC+ZXV19gA0C6pY64rTpBhatTfLyYobtoePn2JoqDHiOTra67LUAZVgwsJQKEyFUlJqN2023ImBleCvoW+aLkZaUGRg1RJpU4VsP0JU5o478HkicyyyqYwqIsBSOAQ4RDOnD2XVSebME7RIcxuFsaD80yrx+gmVUmChNEWx4zv1rWyk5u5csnKyrIWZ2ROZzfNfU9j9fgahXJQp1vognWN1KqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e1761-8d29-4da7-3e01-08ddbee4216e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:28:38.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+Q+fXUCZGB5khY01E8QAoalatQPp+fKjZIv9RuhJvC5JVEiisqZf7xNOADfKpowG0T9MZZmp0N8lQJaJ6TC2dGPp9pYXpuCdxZDPylTJi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMiBTYWx0ZWRfX1GUObGHENj2k AFl2SRwy4oL1RPaY+pm0Xl5wCJlivYdqnUl5R7dnBjgrp7JeYiywANGVpQpGawILSgq7MpPZ6G0 kbNDR9gIJQK5lch+hiUkUH0fYYrvEJhk+VSuFT0IXNemYRYhXSc/XXa73QhCrQ63v0e5E34vkIk
 8oN8+WWgQetMUrE5R5sqSEkz5swHXquFmbqxkFBvug6pYH1DoXDPWrlWdjVnwyHLktTHsxdq/uF TWLZtvdmysNcQ7wxelmKPaUe+efWmv2J5GP14UgywKWpw5DHqZvoYLNlC29h8cYFyoiUnIKcwzC asEC13uQD7QOLZ5up79kEkBcbGdkPPXwGYUdy4I5fsgFV036FdmdvaVBqt/9jsUZmH2jo8hbNGl
 i1LeNQNSDFYdccmjI0amfpktHmtsXpnfAHl/HnhHY/g+n/vFQk47TXuC2enMiq7nEDfVx2Gp
X-Authority-Analysis: v=2.4 cv=Xub6OUF9 c=1 sm=1 tr=0 ts=686e6079 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=_FuhbDluMK7yXEuoB9EA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057
X-Proofpoint-GUID: XzKRv0cRJo9naPAmqlcLvL1ho6rBglfW
X-Proofpoint-ORIG-GUID: XzKRv0cRJo9naPAmqlcLvL1ho6rBglfW

On Tue, Jul 08, 2025 at 09:27:59PM -0400, Zi Yan wrote:
> PID_FMT does not have an offset field, so folio_split() tests are not
> performed. Add PID_FMT_OFFSET with an offset field and use it to perform
> folio_split() tests.
>
> Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy allocator like split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index aa7400ed0e99..f0d9c035641d 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
>  #define INPUT_MAX 80
>
>  #define PID_FMT "%d,0x%lx,0x%lx,%d"
> +#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>  #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>
>  #define PFN_MASK     ((1UL<<55)-1)
> @@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>  		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>  			      (uint64_t)addr + fd_size, order);
>  	else
> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
> +		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>  			      (uint64_t)addr + fd_size, order, offset);
>
>  	for (i = 0; i < fd_size; i++)
> --
> 2.47.2
>

