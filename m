Return-Path: <linux-kselftest+bounces-27050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173CEA3D3B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0856217C1FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5981EBFF0;
	Thu, 20 Feb 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GcpjqTWv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zxxzse1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1E1EB9FD;
	Thu, 20 Feb 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041520; cv=fail; b=GVqC4VKrzy4XxtblfnPtwFBvNvNQb8HxrbV3LEgw9mckIVJ1PT9Xa7TOf7xXO+5kNIiLLeYi0WZwAS1Arbv9jjNOP31g6zWSn7Ne1H2t6ZHj+XYGVdwUlHX6xh55f/uRu8PfoViN+fl2qI2ecFn5qgcS9nomEH8tCpmPDToiZow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041520; c=relaxed/simple;
	bh=ftYooGOZoWwdla0PGwlp3IYK0ucRD7O76qY3Anu4Yis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKld7oEDr+eczS1AbDjp2O//8tYVxWZOWVM5DEG+v+frTzf3xkwNG7c9BkkYttsDg3ND4lSN5eYKWe1EXgHvYG46c9UzidLlkX+YXkg6J51nCAIcsgsLm/b8dTxOK7QdNzM7/+YogAmFN+gqaNVou20cDqpN40qpp2GB1tmuyIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GcpjqTWv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zxxzse1q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5fjVq017645;
	Thu, 20 Feb 2025 08:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ftYooGOZoWwdla0PGw
	lp3IYK0ucRD7O76qY3Anu4Yis=; b=GcpjqTWvxhpf4XUwGtJD0jORIRI9plm/v7
	XmUOdczcrTn9YFiZfCnlcnBdXUS5HJ7/rOYQ/VgdJPlWBLrcdQj8f0hJdjoKGUSo
	iQDbznAAeOr3gqnJxA16FwFZERz3guf/MqNyd0vN9ZrPcaH5a1uS2mNOPEAJ1jeb
	TwFZD7C+BUJInPVRnPhIb+d34KS3rieQi0+/VDHl0uHGiNV8By1KUFTA+WsAtmaa
	X/CYCOKIqQUaDhjrrp+eZtMLnOCAahP8oXfDyUuLz2rO9mZ2Z7JmFOkzi95TbfS0
	S7IievjrRJ3UA/dZYk8YU0uDyIrhl4rdHidDIaKdB3Q1t5NhI7kg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nknxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 08:51:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6VXV8009795;
	Thu, 20 Feb 2025 08:51:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09dkw5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 08:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug0P3y9JbnO1t9AMp0D8Ikzq5KnYlHbiTPoDEZnn+9S5I/B6MwRjsA1W+u1tzSHks85q05HZYY2k8wVtHqaiH98Q9Kw6yKIENV7+4BOF4x0SbpXJ7sMfH7uMB2btVAkRHu8ukZrI73bzVHHvEQzRF1XT/I/MlSBj79aWFkilPBs0hNHozIghug451TPnCOsBdzVNhOjcXMI5QpL9DWZPUHNpNxzsewbW5LI/5X7JghTCPhdDvlPDq6O6RBlVuE9i4WL8PsOXAsUjEQdJbpe4CTtYN3M4vdX3l7gqyy3wohF6NWuL8Q6dCBiy6+N8QBdKi/4P2enUR8MJ+YKQ9AUy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftYooGOZoWwdla0PGwlp3IYK0ucRD7O76qY3Anu4Yis=;
 b=tqOgvw7x+yRIhnNW6xWOavxdKDbI6khU2w37MS3a1OoyfhGleAZXieh/qFUN+83D1Z/8vXkOhco4dAERq4VqNM6p5zU09hZUCeeBomxRzOfpkrYCm3ztQ856bN0sl9+8gvg1HAhkLAMoKC4qk42dB5UU0Y3LsAI5P8D6qLWXB20/+azoWq4eevApsHvPYg+C4Ikbq6fF27kjxeXpz3bMHXDaz8NX4Fqy4haFX/9RbObe8OgDFAz27MlRY7M3ie/kmH/50Iq5zMxktbIQF3DSiYabc8qxvYIoS//LzTkmDgXQkFGidG500DEXa64xZmSM1U/EAPiHj6UhcFXnymYAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftYooGOZoWwdla0PGwlp3IYK0ucRD7O76qY3Anu4Yis=;
 b=zxxzse1qGpro22IXpiUde7OG/c821g9WbrN+KAMtADvJcpiknF/RRssPs8x6RxroScr3+lxNnn6vMEcfBOakKdrVQA3m7DJ+/dR8EvPUXW3m2yPSfp5FdGBP9/u4cXWQwKccOstpCZsvxLmZaYGscfg5Kd6hJ02EWGJve1f5MlY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:51:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 08:51:29 +0000
Date: Thu, 20 Feb 2025 08:51:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4a870d-86d2-4856-5cbc-08dd518bc481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5l6w/6vLkMRfu7g4VRE4YBtLTqD/v5rByreB5oxbz1sCHTzG9K3e+jiS7mnN?=
 =?us-ascii?Q?DEBRcIxFcBurx8OGF0aqE+DXI8sg3HkhZ/rhQ7OM0He/nUS45gzvZrt6AFuX?=
 =?us-ascii?Q?J2V8ofJbuRMpwEu5GAQXpf2OcaYjjMhN8xit63Lyp5GUdFQng9va0/49Atrn?=
 =?us-ascii?Q?bqPA/vaB2Al+e7YMAvzeZ73t/CPNEO7vQnUI8sZKPwt30JAuMJHbEYqWSn4p?=
 =?us-ascii?Q?IBvkKNg11SXWGddl2ge+XiwCiYf3X8j2Z/Ahnln+/y2ysJzpsvXuG18g8OpJ?=
 =?us-ascii?Q?2GVkmrm5YyDZiCZAidsKlDOwI2hNtfHyBocJVCuXpVb6YpNxXXvLOVC8ieqK?=
 =?us-ascii?Q?DcsUcE1QXYsMFgkGS9m2tTGT3lVZhzQ27iJZCvvh+FLLnD87LfHsTUN8QHc/?=
 =?us-ascii?Q?fz4t1QpBZS8K5xEnI2mhNNmu6X2GqWrxBAM/5/Ni8SrV7sblte6biuF9kahz?=
 =?us-ascii?Q?QNVVp5IlbHYYv/SaT4TDIvSjijprmWzBX3BBaBQbEuZ8mhVoaNmUWhL4XDiv?=
 =?us-ascii?Q?j8IlUH+R8MrcXeuOfghmWYJyXR4UxKRoRH1fn8oPn+KWQ24NzYNwWRADfouT?=
 =?us-ascii?Q?Yoqzuy45PngtBHuvtS4uUJTn3bxsOUPBzUjWQ2gqTSOJ1h+TYLiu31ZFQgh/?=
 =?us-ascii?Q?qyhpcqeGDlYZlcjQgPm0k4xRCENyXNEJx1gwQ9B2gWPnHKHvgnmmc5ByzPqb?=
 =?us-ascii?Q?+6u1RFTpZyHSV5jC4yvimmFaR37QM+W0zC+5B6+G4VT/hlP6+Ts0pXiDsbwd?=
 =?us-ascii?Q?kF3dRlvK3IaDEGmIObFfOVkq3nYqxRlfxmTIgKQ1Jtyg+pvH440IgTk+ee0H?=
 =?us-ascii?Q?QSEsOVvPXx3kdM9WrlVqffgCYIns16CxOFX5n/Bww5FXSEPjZQzBgF2sf6tw?=
 =?us-ascii?Q?W6w/7Xmkm+rlJuOfO9dYEDGuwm63V1ktiU5ZGI9PkQ/43/8/qul21H8G+wYc?=
 =?us-ascii?Q?2Fn5oPZF1FGoupY7ekSaZhrMEv8U923pElEtiCktGI8gf5Vyx5M4YO3JRCmK?=
 =?us-ascii?Q?TV2lgwg2mlIkMDa6IcgEiqp9th7U3dc0QbNg+1sR8FmLckenKI2e3jujECh+?=
 =?us-ascii?Q?6Z7rlzQerUVpgirv2za8zewAZQqTnmh2zgdWh6FQiH5VqdroqApYcwjXzovR?=
 =?us-ascii?Q?J9sP3Pqn2rirYbDBLv17/8i4/m2gOpN5WZi8NXw9tabMf9NGBMmP1ezQT04U?=
 =?us-ascii?Q?kXhvPgN51/WdxsuYsL7+KwWOWFtdjxSXqYrxU6q27Hpp4w8eHJsrJvwDxf+h?=
 =?us-ascii?Q?6nOaUmnCe5R1HKeRcHDcDQuoxQxuBCgjiDVrClDvjpBV2+ItX3GF2QIQxPYz?=
 =?us-ascii?Q?opwr5AlPgRKFb84Qxn6b7XWTwcW5UufI7w8HDDZ0qKcRegOmjPlwl2TuLqb0?=
 =?us-ascii?Q?lPU1vLcup+iMOOzd3OdO8uRDkRCo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnOHNcuKctqHwpeOdiDn02+9LNNBWgMhwb7x9Uhe31I8jtBpwg7EadeQDpeM?=
 =?us-ascii?Q?Okza+Q/Dmf59dolwZGrWtpWHA3qrD6hAd52wB/7vUoI5yd2puCALGW9uULoq?=
 =?us-ascii?Q?mM9D/KPOmCTZGaATWjX6/FT4BpHv5e3LT3yF3xKLyk/ne9mWA0kCn71HDi3D?=
 =?us-ascii?Q?Iopon3UFWU6SRfUqMBSSmImA7rb786Zb3EP94jGk+tH6OqyzvxaBiI4uJP2L?=
 =?us-ascii?Q?XAaVGIFeo6V++RX9sRNJK3TW+k39+lh3AMRyXfqnjmwHPZkhMndHtgoBSmbc?=
 =?us-ascii?Q?c/cf1zyEMT+b+dqFmOxks2cQMA16mMxV14U9bGL8pnQ+L4+JFA3yeilRJFHC?=
 =?us-ascii?Q?fQsXe18WRALZHXbxDqlodAw+yLU36BrWFpkA29QjTUl4OSI3FQuJmSWXUVe6?=
 =?us-ascii?Q?BqpaBurutZVTb4FNLeSD8XBaLjsEZ89zsYP70OlfR+2q40B9cWaJZGhqAYKi?=
 =?us-ascii?Q?isWAcwbEu9TVXTXj38M1b0PIuUfacH+Ul94jZYdkSntqPUEEK5YK2kBmTbfW?=
 =?us-ascii?Q?wHFkbIG+y2e1fIyuQYj6j2ebkHZwDP9UWOnSn2IM4CjFm31QWsfH56fNBBop?=
 =?us-ascii?Q?pQkNoBgFSkLypdPcsUnMgUs08x5jvObDthLFDxBkcHfusH9BxyG0NylXCfa9?=
 =?us-ascii?Q?o5mEPZzCjqk06ac4AXqeZm8S2gXR1O0Xo5WSjZ71vi9NfzYvyyjtrN5N0zWH?=
 =?us-ascii?Q?vtRgiZhCUusu5ejR5h83KYI9YMIl/BGU88mByGNE05WTXs+9FcYkaNveFv52?=
 =?us-ascii?Q?UAVV7f7B3835IZdEKSYqypvzyfwhCbiURI5REZkAWwMJMmE1VSZRpg2zG8MM?=
 =?us-ascii?Q?Sk3U+LfI2HwqPNo96WVHU1u7ZLDkqK/+6byKMPdmJvomGZMPxWtc2NmpmV3S?=
 =?us-ascii?Q?w1dNUW5/SwEuR7pWMeAQQhs36eeRZFzqJguYCPaLBYdqXkE72aHlTmdqjJL5?=
 =?us-ascii?Q?xZl+WmaPl57h8IwlzQhc8f9wJd65klkiJeotx94gaDdvUcYslX5njotGnlKk?=
 =?us-ascii?Q?XHmlIEcTOT0E684qRdrKLgvRycPtS8VUivWJQY6uRhgaM2Y2cu0zAcXUaRpq?=
 =?us-ascii?Q?GXimjk+Vc3PT2NZqekXbV/Pqv52++YTUprwS9LVAWoPyYZVmmLPRcau6RuaK?=
 =?us-ascii?Q?CKsz93b1M1yZnrks/W5EiOUd+Q97zq/mVycL8SNs7OJftvzQeHKg0pmIOZ6D?=
 =?us-ascii?Q?X5sJHasdnnC9k1im9DlbU+rWVhPTARGxH94SPuXknwtbDhFUUeHChn0YKaS5?=
 =?us-ascii?Q?0XqR+p9M3zR3slw7LUUArh91Phg6hMeBEsTNCseiIdhyCjq6LkbePdEf11BO?=
 =?us-ascii?Q?zUIUualMTPq9efOz9zqOCWGcfR4USG/H2iEh63CuPi8z71FJDPPw1Sad3kH5?=
 =?us-ascii?Q?XH3OK2CagrjhjHqfKFW9Nhuq9smhx3UlM+nuDSnNpS8QQFjtI9XImlLZc82B?=
 =?us-ascii?Q?pCBYsI1R3OoPzMaQKknqov5vpuCD/2sOHv4kYt2Sgqzk6QeXhArd9Ds5gam+?=
 =?us-ascii?Q?BsFEfxREvYAVOQ2xXstB+55g9z0EkpeFVfPZFgXF7nW1l8L4lvXLlGbOvReJ?=
 =?us-ascii?Q?vGP8OSE/2ZqeSIC2oaJwiQiWGXE/vwEByBSJ3tw9QIRwQx8JyMmXMJtR1j/1?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cizEjJRE/TZxPMQXa6FNAam0vmB1N0BdgfS3j2xSHvAXwg5bIiQ9QRGaipc/qLqhfuhV+isY6htXuNxVgQMz+ARttRGnKLTPmWoTbkP3Ia/izxi3ll5VgAMdd1sz+aWosDoVpRF2GDX6Z6hQ3mxwKCk3RXFIrClM2rl3RGUVwDwrjDh/y0uIaWb2vcfvvWHVZ5fOHWvCrvHSlIJzG+qu2I3ofJF6m4CTTOMldU9Ipc0M+YhPU/hYpvTFzmwl1G1IboT0Rq+AMKrRi9EVKTE/cIPZOhY7jo2e4NxoAidkLygD1YE+dulgZXGltHVlrUt9OctFlXR0fTchgrpTFplg/0vtNHP8SvqM6WrARyRiS3Rgj/3+qivGT6VcQpCD5qDxACsSsc/6yn3wywMJIoowg7BNhUFJ5tjClAnU/QrSx7VQvgHHud580iwQk7NJi7qJJy23g4IwcmEfdCeZuXwd7pO9sT3//gxvXPtmHel2Ka/UWtnDrQr5BuK/yEZMOk938x3k6mWOEqTZKT5q5FikKU2ll6XNZXqz4uaDXsgXBCgaPGM2yMat2PJQfwjMkSGvlTWJXWHOxMUOUNTCyNxDUYTM1JXMc1T9wxtZ/iBvfOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a870d-86d2-4856-5cbc-08dd518bc481
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:51:29.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCJHLjZlJ92Uv5ciDn7L0cvxDRPieyY5FkqqDZ/EbuLqiBVZAyLj1NGcOnL+a0CVUZbaznc2TfzDmUGKcnbBVBzfQcQxKrmm/qM3MonAtgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200063
X-Proofpoint-GUID: ZeVS4EJNf6n698y4RGgXKlT4YakCSRW3
X-Proofpoint-ORIG-GUID: ZeVS4EJNf6n698y4RGgXKlT4YakCSRW3

On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
> > We also can't change smaps in the way you want, it _has_ to still give
> > output per VMA information.
>
> Sorry I wasn't suggesting to change the entries in smaps, rather
> agreeing to your marker suggestion. Maybe a set of ranges for each
> smaps entry that has guards? It doesn't solve the use case, but does
> make these regions visible to userspace.

No, you are not providing a usecase for this. /proc/$pid/pagemaps does not
contaminate the smaps output, mess with efforts to make it RCU readable,
require updating the ioctl interface, etc. so it is clearly the better
choice.

>
> >
> > The proposed change that would be there would be a flag or something
> > indicating that the VMA has guard regions _SOMEWHERE_ in it.
> >
> > Since this doesn't solve your problem, adds complexity, and nobody else
> > seems to need it, I would suggest this is not worthwhile and I'd rather not
> > do this.
> >
> > Therefore for your needs there are literally only two choices here:
> >
> > 1. Add a bit to /proc/$pid/pagemap OR
> > 2. a new interface.
> >
> > I am not in favour of a new interface here, if we can just extend pagemap.
> >
> > What you'd have to do is:
> >
> > 1. Find virtual ranges via /proc/$pid/maps
> > 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
> >
>
> Could we also consider an smaps field like:
>
> VmGuards: [AAA, BBB), [CCC, DDD), ...
>
> or something of that sort?

No, absolutely, categorically not. You realise these could be thousands of
characters long right?

/proc/$pid/pagemaps resolves this without contaminating this output.

> > Well I'm glad that you guys find it useful for _something_ ;)
> >
> > Again this wasn't written only for you (it is broadly a good feature for
> > upstream), but I did have your use case in mind, so I'm a little
> > disappointed that it doesn't help, as I like to solve problems.
> >
> > But I'm glad it solves at least some for you...
>
> I recall Liam had a proposal to store the guard ranges in the maple tree?
>
> I wonder if that can be used in combination with this approach to have
> a better representation of this?

This was an alternative proposal made prior to the feature being
implemented (and you and others at Google were welcome to comment and many
were cc'd, etc.).

There is no 'in combination with'. This feature would take weeks/months to
implement, fundamentally impact the maple tree VMA implementation
and... not actually achieve anything + immediately be redundant.

Plus it'd likely be slower, have locking implications, would have kernel
memory allocation implications, a lot more complexity and probably other
problems besides (we discussed this at length at the time and a number of
issues came up, I can't recall all of them).

To be crystal clear - we are empathically NOT changing /proc/$pid/maps to
lie about VMAs regardless of underlying implementation, nor adding
thousands of characters to /proc/$pid/smaps entries.

This is independent of implementation and would have been the case had we
gone with a maple node version.

So in no world is your problem solved here, unfortunately you have
inextricably tied yourself to a VMA representation here.

I still wonder if you could find some means of abstracting this, but
/proc/$pid/pagemaps is where I am likely to expose this information for
anybody who needs it, and will likely send a series for this relatively
soon.

If you _can_ abstract this in some way, then if we provide this information
_anywhere_ you can get it.

As I said to you earlier, the _best_ we could do in smaps would be to add a
flag like 'Grd' or something to indicate some part of the VMA is
guarded. But I won't do that unless somebody has an -actual use case- for
it.

David's /proc/$pid/pagemaps suggestion is excellent, avoids all the
pitfalls, exposes guard regions to anybody who really really wants to know
and doesn't interfere with anything else, so this is what we'll go with.

Regards, Lorenzo

