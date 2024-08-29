Return-Path: <linux-kselftest+bounces-16682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EB964773
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E28283DF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D01A00F5;
	Thu, 29 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPSizLwH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AfdtL9D5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300B1849;
	Thu, 29 Aug 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940227; cv=fail; b=Kuemsrcc9tucx30s+U+O90tcFokqYJ4NssfSK8UjAXTVaxtea8X8S8gOEs/WOzH6LPKHZNgGc+7GO5j41FsL7S2Ltx4hnqIFqcHwfsGpyVwmZcPQVpQIJ2Xy5GEhf7aHx1hw6J+P4iLm7xByD7SivG/BWX0l66rz+XZHSzx5viU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940227; c=relaxed/simple;
	bh=vVXGrlhZD5jRO65q3eOzmNKBRAzaCOWA1x22sCrwtq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QLEKfYa/vLHeVK2Ce8+oOfSBYHXHcTzKGi2qp0tM2pvJyKtRSdfSUSeM3n7uF4rw4v1vmacK2s8yaqnjh2xKgkaY3y95XyjGXJeM4175kAK9zu7lfkRCqd8+QUSL2S+pT5EKgbWEcw0jJ4D9z4nIy3kSYOrAXR5qbYKWdFqakZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPSizLwH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AfdtL9D5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TCKnR3013788;
	Thu, 29 Aug 2024 14:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yhWSNKCEaf3Wa7r
	7/oERBUfEQRrF9oSZYEWDc7NSDms=; b=NPSizLwHtiR55nluPvOSdSvMCRUzxzx
	4pz+vofEff0p1XhcGfF8wLEOJkTG8nDkScXBamo71AzZZQZqzGWU93OBhWrhoexz
	4wR+4iuiSAahmcfP2Zy1LL4KLh4cyLMpGWhpQz+EN8SohgALxZ2cnJl0sFn4ExRi
	QWUc44wsEPiwstiZ2liB2RgTQZhBgv8DaBS4BvIaExPqXyZxVglnw0ucn6IQ+7su
	V0AixhdceWvYejKKfUar2xjFS9vsheIbQK87XvAGfIfBjH9BLEFfGY31bVKIcYx0
	MiCabofJl/z09nNseAorubgBEertMRAf3o/0/IFqmUxff/JoZkXlggw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukm61b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:03:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDjJE8035057;
	Thu, 29 Aug 2024 14:03:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw1abp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff4oE2jdd2f4DOhJxGo/AwfEAJqL5Srd8DAF0Sar4souU0E5teMfzIei2LSvGbymBDFsS+D0hojJ8UmlwFSVOy1rlMcZoXAI5OqJTVVH0xXA/8e6OL6S2Dhug5gEN1F0L5k+luUpxdauVBp00JKIkXptmUB00/jQBlgcqVrDkF7Zjmr3WiucBnR01aRrART/TIwiZnSDkcdsYF32aHBdjC1k903uNEEJHaDEBKDAZy0JbYSRNrU4u3aZWIWBRKmGu+zHJo4E4Sc1hb6RZaM4vYuLYOpJBU2cFXaVE20G37IljXe/XKUA9GvMBI+5iu/Uu+iwAWRWGqdFuG9OqaSeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhWSNKCEaf3Wa7r7/oERBUfEQRrF9oSZYEWDc7NSDms=;
 b=QXCVc6nO7L3I+PO7/pyZyAtBTtnc7oj0NGl7ap+Xn5MEzyxWck3LNZPEAApSyba7EIVVzVkqrBQC+8Ekwhn+5Db6NX2oAvVkmduQtkGvcAIBjuUcWpvC+XLl9rz9ihaDoqHGZeCnZB0Cc1QbD6Ib3gkGRqykIcp63M63RY5LQurqslcOc1MecLYnhsEvbMS2q45WPqfvMjXcJdi1ResXlz26atlxhw1zn7Ed0dEgWraugby8CMgOhDis+oPlv+8u19lAI3zt8LQm8aGgzf0Q2s8/+svY23KFH8RBYWrZ9MPrCIi36zQZE2WxiSS0QbLJFTnYR0pXNS7ns/aNunNHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhWSNKCEaf3Wa7r7/oERBUfEQRrF9oSZYEWDc7NSDms=;
 b=AfdtL9D5w3160CvXWq2eAnevoNg7HUUAuBV6PMOF/LfU8n6Y50wuF17NlsFszo39eT4lfvR2t5Nc/SQagcmJkLGSgVQuGU8o4PstUGDKd39P+synwdZi2SekYj34pe+cE30JhsbVHYEszcO3JQSjhEtdiINAKyb5twGS8Uevfqw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 14:03:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 14:03:30 +0000
Date: Thu, 29 Aug 2024 10:03:27 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, rientjes@google.com,
        keescook@chromium.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Message-ID: <vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	rientjes@google.com, keescook@chromium.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: efd5ac66-771e-4c52-a99a-08dcc8335c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUcFDJPygWx+JpPQOEX2yXc3Evj6ubSjQl8XRxpLojYjjnZLrdiC/jZnJfbx?=
 =?us-ascii?Q?ec0wdDKPotr060MiJWsmogER6jd6axIZ54JsX9GtCu+leDxqZ4MsfE+eSI3B?=
 =?us-ascii?Q?UH0jTisOZKwZ6xBQUC5SjQ39bKP7vvA8sgYUp3RvHmjCnRKPzVXwKhXTHdu+?=
 =?us-ascii?Q?XFgut+HWTFcB58NkorKkAkAd8L6pkoubHMMSMDLMpJFFNPpafJn4GgXxXe5w?=
 =?us-ascii?Q?oBr+LnpFK1DIEbEltjIOgx/ogVLZceXITN6xkbIAkp3uShK42zluYszk9I7v?=
 =?us-ascii?Q?NdZxcuf+fUdu8fr7VbB8eVNaK4EmMqfsq49uNrjOjXCORXEpav7eSV4/+7M+?=
 =?us-ascii?Q?kbjdGryBQOHNwp1mm+/Plfqxi53QvVpdQZlQtg6XphFWDGRncSOt6hIn1szu?=
 =?us-ascii?Q?iM2cvH+P6GmAgasYYPdvLT3pJd4P7utWD0oXxd4q/zDc1Lp+KIy5y1uQ8M4L?=
 =?us-ascii?Q?PtVy27BN+AGPz4qQjp3ZN5kFFW3ccnf0K45i1/IJKLhsXycxINzi7YqFfT2d?=
 =?us-ascii?Q?Hzm34cetfeq5dWvIpFI2ZnsEvPXbgz7Ig7XE2gAwyCopRrOHiKiujXjDeQmB?=
 =?us-ascii?Q?X/eOjb6mQvMoO4Kgtb7GvVGH/mmq4PmtxIY1SKFVW5sK1SDC5w99QkipEOE7?=
 =?us-ascii?Q?Qb4zHoSpgz+p/KxFJ+1I/DDz1BkDcxhe8Zm45NUZ5tv1shH3aPj1hd10mPP/?=
 =?us-ascii?Q?QXsCNEIWtdsVDo6/bof+aJNbAdV/392YPbJ7yXwLthtFJ+ESwCiEglTOEY8B?=
 =?us-ascii?Q?CrKtCBXblQeM7iP0cDxovztovw4f786FMK6njjhRZxd8cyLVsVqiTQi9IQJr?=
 =?us-ascii?Q?dXYUn3riyTN0UHMJRPo1Ft3478q/9qq36uXyQqdsGb5KCrKjU2Uxb2SxwiWz?=
 =?us-ascii?Q?CDmnLqlNhL3s4RqI+ICzrAmAIRW2Hd5K1qOjtrd4yGy8PNoNmiH+56fvkQtu?=
 =?us-ascii?Q?E9914d1xCFyCZLo44Jokm7wxqwvezzJ0DddUr6i4y8KxkmG9/DqGOM1MKzxV?=
 =?us-ascii?Q?qk2X7/5RcpDJw6qlNFg8l8DAHQxrQfkDoyH0ww3oyJYUPhlX7nL3l/wDNHlu?=
 =?us-ascii?Q?aIWtmHJ3BxUpXKKRBN8lPHSWGMiY6OEsci6snWgD/0rXqw92cvVP4yxP1N0y?=
 =?us-ascii?Q?H1qLM+w/cFoC6PLzSM+z+CWNOekZ2BgT+abKCoS1WLyWhyrE3m/CkVZYcIbL?=
 =?us-ascii?Q?rRLNe7RUP5vIWdT1jNK8DSnuTrVrWgS9H6j/22cdj/UL9KPcVnWBRXksCFtI?=
 =?us-ascii?Q?+fGnDzK6rpvUv7nz5+J6l2M6pLr7RLiG+BLoVDxpz6AuWyg0C6pMkCZi5/c/?=
 =?us-ascii?Q?9v01wbe6XazV19F5YwffZlxR74kF5y0rrMnXOoBfTsL4qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZtw8e/4fnkNtLHCGgCsvfaTreYCt+MxyJVI5cibu+u0RB5rn0TY+Thsz4BO?=
 =?us-ascii?Q?HJmo6e33TyW/oAfsu6Br16clcAIPvAHBZYOwTQSeyzabdrvQeuBpXDCjml2d?=
 =?us-ascii?Q?xbO0rtus6ATiKDsNoPr33NPpNufb6UpB0TOEnMHKP1Ic8zyMJ+oJJK1JyLF0?=
 =?us-ascii?Q?+vMeuZKRL1P/8Nu9vqieoA385uh38rasrv5VLrwOnBafJe/maTh8gr9jiGan?=
 =?us-ascii?Q?1FRDs+MoJlpbDsAVgS4BKSMO0JPWxE1easmrV+64D6JMh4XFEBIxbT5oFpFX?=
 =?us-ascii?Q?NR1MMlJLxkKjRmTJajFzqdpx972BSeABvpVIbxosfIkEo8jPhJlgLZxaAeCH?=
 =?us-ascii?Q?BdUmq8QF0EizrkqkZgzP0OgAKu6KRdimvpqttktoIT+gKdIa3i4IRne24tqD?=
 =?us-ascii?Q?Y4y603rz7GD+bZY8VawaN5pz+43+HswC6tsySYtNBLJBB+ki0rqxOrP21t1g?=
 =?us-ascii?Q?x5sKSkALYtjoMIlnJogZukewCgCg+vENFQ2xmmg8IsnAY7wkiwHMubqMKqLP?=
 =?us-ascii?Q?qrhSF/jOsIFXG7QG18c2lytTRhI06dmmMV62VHziPFTzQFYPOc0OCQ+Ma8RI?=
 =?us-ascii?Q?atsYoBWFbYBJPs5ORskn5kzIT3gEcejZs+WOBtRiJxMwMrwzWq7u3AFLbYqS?=
 =?us-ascii?Q?NUE0tVjJa5ahrZOICSiT8ykstj7iU4KC5lXqYtnKbAXyoe+DWb7srrFDv4o4?=
 =?us-ascii?Q?n4vL5cwpNeN1Dz6HuXiyj8+EIzNKHNWLiyGOy4gwnhJ0yj5xzJt9T3K0YuEW?=
 =?us-ascii?Q?IHxiNoZ26xdEpgdEOIKSZf6C69Ya1BVYTuueFIqLJyi1WbrnDqYpdc0JlTR9?=
 =?us-ascii?Q?kVA4T54RaYc3bDZHVPTbd40E4Luqs6xgKAtcLgpG54DxEcWNBxtMiezVR6tL?=
 =?us-ascii?Q?v54h16q/SdwRJ5mxt6PCvH672SVWLJ66iJHv+GHrLapNRocUlJr9tcxk62Vl?=
 =?us-ascii?Q?1uyGkP6RNqmyaUY58lDUqgjG+fRCa0UJfLkOh0K3E3XP/MB4cYoIAz6A10H0?=
 =?us-ascii?Q?tRc/tSniYm1DP6rWBBSrf+JYZuvdeNG2+zw9bNB8cJarKwo7Nn0NGZVOrA//?=
 =?us-ascii?Q?KSYEsdMALokRDVS39YYB5p/V+7mwO46fDvZsTTKX38TR4eOtyx7CHs6lDZjr?=
 =?us-ascii?Q?wVFeJNbn4HuxD/HplZHsp8//UCErAfvmxbltRu2Ln6vGKTly7rzCXUoZUobj?=
 =?us-ascii?Q?IisYaB0N04s9T7CObE+T5do28qlVmHIXqSzKHzQHbw0EmGcPPtoWI0AJelmZ?=
 =?us-ascii?Q?u1BVw8RbLv68Y3DtEAoE0iiiymEEWdhXOerBVqyjuiHoFgpNoYBiUMna/zGf?=
 =?us-ascii?Q?eyvaD4k6cBAAtEMf5NVFrEHFmcqDULwUn51LsixrBZXy/3/yjrbEx8fNUTb5?=
 =?us-ascii?Q?CubyZvZy/MMw7FSUs17IqmGDSroJUR2Lk95oYe8aHaKwpc8kX9RaEc8LQc4W?=
 =?us-ascii?Q?3qZzIn0yiDZkrOS8eJHG7pFp/1zPlfm70B/QeTT2cOfdVj/zR7I5Rh2PYoiN?=
 =?us-ascii?Q?7fg0Nwt51wvJJy7JxQDt/eTUbDtnrrvJxeWKKU1E1bth2gEtReYR4G0u3EIU?=
 =?us-ascii?Q?xgRpy0GFf2GVCrEQYKmyLbEHjtjoGY/RiSkP2wN7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	72WkVqXX4Ym1tiBX2MuqvTnD+ubGNTVDgc1zhnmVqEYdbhNXXb7JR7B3bMU+ouLiol7DBKYUNhcMWhb8us9ckWmXkHbruAmVsBNBABJ56ItUCGN48WBBKMI33mTp+HtC9QzlNr7IwGtdBVPNkQDI0wDRU+64HOeUOXrRtAN5Qq3S5AbtSSmGbmqeYx0O4hewVNa7DGjzAvYmHYnfIor/bM20Xvjf1WEgFR7bblow8khRDfV2pKE5XIXe+WRVW4vkZ8xoKU0m1T0e3NCD8WDedI9VbmFvQ7JD2w9FknidjKCJzt6rw2utPhCzXqNU79sN4kYNF+72sZzQjMRpvglWoD2nVANCS/GKMLSDWitGX/pLILN7nuVFFz/TNgcV9qfOnwWYmVf2YvjHIe7ukSDaOrJE2Zs1P4wUqLRqdUgpbuKqDEJYS5GtonJY+cdcm8ZAf1gMG3iHKwxGLU6ia1atj9SDYyCsAzGjCbLWw9wqtl5DMeyS77qKzgdy31ONCFWpENBl6RxSJlVs6aOZ1jgfyEmbOevdVA8sLrP+fFVV+hinjDi4lAC5phUcWlVeSyvQgn9w7rBeoWkarhmgqsB8Q42Am0qlPztUqT4p/5ysffY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd5ac66-771e-4c52-a99a-08dcc8335c5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:03:29.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTYblD1bvufGcCn4AF9JFN6ui1Dl2xhhjoZPeQvmE057Xk0/w25X3ToJmQol0p7MIIwBvJZ/9mjOGQNNfZUkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290097
X-Proofpoint-GUID: nMp1a18RHuWlrscG35diKyR82L5bg2ym
X-Proofpoint-ORIG-GUID: nMp1a18RHuWlrscG35diKyR82L5bg2ym

* Pedro Falcato <pedro.falcato@gmail.com> [240828 19:38]:
> +CC vma reviewers
> On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> > 
> > mmap(MAP_FIXED) should return EPERM when memory is sealed.

Thanks for the fix and finding the issue.  Please email the maintainers
of the file as well as the patch author next time.

> > 
> > Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_vma")
> 
> Thank you for the patch!
> This Fixes: is wrong, the bug was added during Liam's rebasing of his munmap patch
> set on mine.

Right now, the akpm/mm-unstable git id of the patch this needs to squash
into is 5887a7ac23836.  Although, this will leave intermittent patches
to return the incorrect error code.

Initially it was introduced in commit c2eb22189bbc9, so I'd like to fix
this in the series so that it doesn't show up in any bisection.

> 
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/mmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 80d70ed099cf..0cd0c0ef03c7 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		mt_on_stack(mt_detach);
> >  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> > -		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > +		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > +		if (error == -EPERM)
> > +			return -EPERM;
> 
> Not sure if it makes sense to special case this. We should probably deal with this inside
> vms_gather_munmap_vmas and just pass through the error we get.
> 
> Otherwise LGTM. Liam?
> 
> (we should also squash this into the offending commit)

All code paths that exist today in vms_gather_munmap_vmas() can only
return -EPERM and -ENOMEM. So filtering isn't really necessary right
now.  But then again, vms_gather_munmap_vmas() is only used in two
places and this filters one return, but not the other.

I think it best to address this in vms_gather_munmap_vmas() to only
return -ENOMEM or -EPERM.

I will fix this in my series, thanks Jeff.

Regards,
Liam

