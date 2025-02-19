Return-Path: <linux-kselftest+bounces-27006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA8A3C644
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8081899F37
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA961B415B;
	Wed, 19 Feb 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9tSwoR4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t80JTGEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633B1A23A0;
	Wed, 19 Feb 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986403; cv=fail; b=YyWBXywettYD4XW/hJ3EUi1ZfIiG5lFSMKVjv5+Zgfkod2VJkeAMsPs9iGg3tCtch4VMUu57C34qPYAFbZMxzMv8P2BnWwyqQGbaPqomojC/8z6P1sO+akBMnDQfbUNDfzIqKAsh+5/IDJb9fasYAlirpVX6HJio+tk+lP88vck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986403; c=relaxed/simple;
	bh=fJOev0r829wPHNe6ICEtaOehLvKQnNg7lwB2Ssg0Ttg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGmEaYKOGWJ6DhGms7T54V+kZ4D0mDUY9VmpjTfX1xk5aE4ZXsDnuVePCS62m7WI6WNXhFWn+Jx+Mp70WNq+mUlHKPsVH3IhJfm13FRnt79NS56VWJdY1U8V1Jw7gYPeY0t6NgPkZ2jfrX9xOwW43dPBHkxP13qEliZ4dIuRBFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9tSwoR4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t80JTGEz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHMah8018114;
	Wed, 19 Feb 2025 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JKZuyudBup2kWJb37HYRYj1zKGt5nAJhbsXkB0PCpFY=; b=
	m9tSwoR4bbq+/oHLQcm2RDRbRAZYbG5NpZBbjgO7Z1kcZVVJIF9gEhggcEVvRwmq
	7ZjuOgRvzk6QPQOmWGKkRlTtKztQUSxgt5EcTchAcSANkv8fI16LQVRyuTbcbv8X
	+nbokXZoXOM7DHQZuRxo9tCwgSrLKlJHQ7+XHXXhR/WBmIg0GriwphRCJXIRbVeU
	/jFLIXbRJYKHG3AFdXRTDPjFBJMRpvXyW/x8uq6dSH4RbEguiqmGW6cqoQG8+IRU
	NGguP/Up5zcdEbEr6TwV5+Dj9WGebOBIR3Yg79XbRgfzA00YKSELC8SIG9hxUMff
	lFxaD1CovmnvukkDkcQLVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pt77x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:33:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGn4NN010589;
	Wed, 19 Feb 2025 17:32:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07dtrqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAOOxbj5szHkBpX72fbgbCYawqvJ7eeTaG0jIYm0OxyqxWu+l/68OMLCxR3nesfgDkjApSTWCJ+YQJRGfI9biwtinUW9+KunlwcmiTzJaQLHcsOeB8M/0ItBT3bIy6015S9gY4O458EYSE8nMOKNtb48x4Ps0/6gz3NSfPEwL9LTdMznPItIVAkV+TlD9w2EL25pb4XIZ2hMCtW4xe/wM3BVM9+Z6T6F3L02rD3KDVecyhOpMi0FmtweygPs/+1B6BknK+rAcFpFnxMdHEeCpzNHrds/skRKYH4FszQRcXvbQRchVakyTm7Va6qgjGT16PDPCWDBpzrKGikLsUXm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKZuyudBup2kWJb37HYRYj1zKGt5nAJhbsXkB0PCpFY=;
 b=SzeVONyte1uqtWUxdhPpm5/OUvtkgtYYsKT0KNuOkJchBsJYmzLyQ0d4MMKct3jipoQ6fhieUypHqlG9gZeWUDDnrYzjpCnmHXDO9hcuV7awu+ozEom6cL1L8ijQEXCJwdAPVpPa5c28gYthuibJW8jZJ7HvQs1lB1QmMpH1amfSKtqhm0nl6LHp9w/Pn2e0oFfohvcUZhDKP52Q6f9mRxDmvMyj6q8Bpv548RTdz+x1TcxB+r1OeUQbE2vkM2eL7s9zAzK9wGEHDiiEXQpnsfe4eTmqBhOa2zsv37uXlQdWBJP7lgN9e663htsehJtDMHVxkJ3LEdllDlJueut5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKZuyudBup2kWJb37HYRYj1zKGt5nAJhbsXkB0PCpFY=;
 b=t80JTGEz/KtbKUYKd5UvajTfjxqBw1B8eRXWrsSzLib81rX/6O2psXK0CGmZ4cStEsVVY9giExlmPGJeET+PMN/q6Y5X6112eDn2IMpfNYue4Oc1Mg3M2usHlPzqwDgHQX2+HYKFmN8W6AsyhziLnMB/IPAHrQw2bv3HEAWrGHs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB6133.namprd10.prod.outlook.com (2603:10b6:8:b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Wed, 19 Feb 2025 17:32:56 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:32:56 +0000
Date: Wed, 19 Feb 2025 12:32:53 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <dbbdcqkfsd5wgoo3xvuvfonj5y5sey4m4ldipnbws4mezmjy2d@575icb4lucak>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <CAC_TJvfPNkJDWnG81GnJcFeMLYzN8=uM-oTrK6FKT7tD=E4TQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAC_TJvfPNkJDWnG81GnJcFeMLYzN8=uM-oTrK6FKT7tD=E4TQg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cfb9ce-6b03-47f5-f6bd-08dd510b725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlJvSHpxOVRSazA2K2FIQkdMU2hCSnFiYTNBZWxUQVRFN0NwN3dZVk9EYk9O?=
 =?utf-8?B?OGh6VXNyckZYaXJwZk1KKzJUSEtzR0Y1SXJzbHJUeDJxQVBMMU1Zc1dHTlUr?=
 =?utf-8?B?WnBjeXZrMEJ2Mkg1R1pCKzY2Mkp3ZEk2Yi9iUUlGaUF3UHpBbjMzWUtoRUdE?=
 =?utf-8?B?M3ZoNnF3eXpnYUJhMHcramZIL1Q1MVhyVTFvTGdIbExSL0MrNjUwSFBSQyt2?=
 =?utf-8?B?S0xFc2tIR3FYd2g0OW53SGRTdXhDaFVCRWtqR2MvYk8xVHZUa2VWSEVyUC9k?=
 =?utf-8?B?blk3Ri8vQy9mZjNnQ25qN0pqRjhYSFRKNlJzR1ZwS0w0V05Kdzc4SU9WUzg5?=
 =?utf-8?B?S3gzWWVuQ2ZLaGFlU0dsUlJHMnhheXFGSGwzcUdoVlFNUDJOUjAwMWRmM3NT?=
 =?utf-8?B?YjdINHdSN1dQZEtXZzFuTGplaHJQVkFnV0EyalQwSlB3WGxvYTcraGtLUXdt?=
 =?utf-8?B?OTBuYUJ3SzlCNTNTUTBwM01mNXdGSHB4NUd1bGxIb1VqSEVEdXR0Qm1aSTBU?=
 =?utf-8?B?NnZlK0pDTDZoK0lzUWdGVis1ZmFXbjZ0WVk5TnNad1ViNFVDY2RPUDZLR0Rt?=
 =?utf-8?B?MEwzRXV5SWpQZlV2SGp0by9MdUlCUnNraHV3U0hKTUdpQ2NoSWNCK0x4RVp5?=
 =?utf-8?B?MTJrTkpDb3c3V0E3Smh5Wm5wREo2ZjU4MXJ6aWE1TkpDVG1Wblh2Yjk4TUtQ?=
 =?utf-8?B?Z0swMW1JVnRVbUVROU5WUnRqOW5tQS90bk5JekFhbUduTWZGZVdHSjdyT2du?=
 =?utf-8?B?cGUxb0dQTmpMMXYvUDdHLzk4eHVlamFKdlNCV0lVcWtkVStYcU95UFNDSXlD?=
 =?utf-8?B?ai94NW5zek5HR0JXZEltSlRscjlES3NwWlZrcUpxTElseFpFczkvOVdpSkY3?=
 =?utf-8?B?UW92UUZjODVRZXhJd3pDWVZETGEyK3daWExLaUIvdVZ5WWRvOG9wRFRXMHJW?=
 =?utf-8?B?STZwTTNRK3FsYnZIeHZnTXBIcHRIZGtHUnBiNHZScXNLcU9neTZoVHYva0ky?=
 =?utf-8?B?YXRNeVVla0JLSE52QkZQVjRzdkZ1YjEzUjJjSU8xNkJUVk9rUmpMaGpnc1hp?=
 =?utf-8?B?Q2VlVTRHbkc1SExZbjc2a0NVUE5JSWVxcWoxTy9ocWN2WTVvMUhIK0FOYi91?=
 =?utf-8?B?c1JjZlhRN2lXbXZPaUEyUnAvYmRMaEwrSGIrVkp4elY4dmlOOFByRUhaQnha?=
 =?utf-8?B?N1A4YmRIYkh5RHkrdjVNcGRkd3JMMTZjNWRsYVYrVFRZTG5kczVCYW9lNGlN?=
 =?utf-8?B?NmZrK0ZodUc5L0k2M21pWEY0ZGRSYWs2cEJMYUNNdm8yTmpmWHMrNHlFbFJz?=
 =?utf-8?B?c1pWQ3RGVUZxNVRzbDZxdEZjSUxCaVVpMmNwdnBUeThNZ3F1d1ZvdWsvY21s?=
 =?utf-8?B?Ym82VDI4N0ZiZm5GT1ZBR1BqejBybmJpT0tpeVpHcVpMZnV3R2ltUjVQdFh0?=
 =?utf-8?B?QlJVMmZpS2JNMGxLZXAwTHlaV2RQbjNzeUZrdFlWdDVNd2VtUDJaOExzT3U0?=
 =?utf-8?B?OWNmZTl6ZjQrQkdNeXA5ZHRNa2YreitHMk5Ec2NYWHlWVWlMY0R6cTgyVTVj?=
 =?utf-8?B?azRFeWk4S0tMNDZzQ1hGN0VwMjBYM0tmSWw0dFFaNjhYWjF3c0ZYcnNiSlNV?=
 =?utf-8?B?N0tNN3Zxb2l2cFg1UVRNTU5COThFVHJWVzFUMVBheFYzbmVITmNYV0dBYzR4?=
 =?utf-8?B?VWRzQlQ1bXE4eHN1b1V4cy9zcC9NcG9PSXRXSFREMW5mdFVMSk1seGZ4QUtT?=
 =?utf-8?B?aHh5WTBQZHFIaWtmaUlXM0ZwRUJ2T2V3TVdacFhlU1hVZW9lM1A5TFZXM0Z1?=
 =?utf-8?B?NGJSWDFPMjVmQjVFN2Roekl6NytrNk81b1pWN3RhbWt2VDNNV0ord0NCNzhD?=
 =?utf-8?Q?bZaYENgIRTAdQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjlvWkc4KzQ5TmxXWWdrT1p0dDdDQ05BUnoxdDBoOTk4OWdUd2RSeXdpMmNG?=
 =?utf-8?B?NmpuVEV0VXhZR1Nma2xwd28wWkIxSTlRR2E1ekRVdUtLTmlxMklvdkU5YjRQ?=
 =?utf-8?B?d0RTS0tkUVNMTnRScUhJUkJ4R3g1NlBxK01PVHorY2RWQlFEeXBxalF1N2U2?=
 =?utf-8?B?SWdmYUlnTklXcU1RTTFwVElVa1Vjblg1QjJlbWNFR3djNGFFaXBmb0lHWGht?=
 =?utf-8?B?cGVUNTZGd3pSd1NyZTVXZGZGNEFJK0pHdUNJV3dPbzNpbWNuTExHRTNCT3ln?=
 =?utf-8?B?OVhURmhxWUE1MlFNSFdwdHVQOSsxajIwOWlhRE4vc3pFUzlBa3A3UXd4OEJs?=
 =?utf-8?B?OHZmbDRNQVBrSWYybkhOMVdDSmIwcjgzaTZndEY3V0RwaEU2anJhc2tQZ2o1?=
 =?utf-8?B?NEtVbXhERkRCRXcwcG4zczZFejU0WHdGT0tpVENpdmxrQ21vMTQzT3Nwazho?=
 =?utf-8?B?MXJicWJHR3g0WkZCZnhmRWErbTl5bExqdmhiS3VBODlKSW9EQThkQWUxc1Av?=
 =?utf-8?B?aWxVMEdKZm9uRkdaRmJUSDJld1hVTFVPOUJ6dnFRazZDdXYvYWxXL1orbUhX?=
 =?utf-8?B?aHdCWkMzQnpMN2ZlcVVUZGxrZjVxU0xIS210Sy9yclhVK00yRnJCUUpxSmY1?=
 =?utf-8?B?b1A3YnZKeG1LczUvM1pGZWZtL3NBbnkxOVB4MGV5cHRUdkV1TVJBZGZ5d1Jv?=
 =?utf-8?B?QTlCUy84Yis1RGN4dnRlRjdaaVFrSDRod3pHUEZVRG53Q2t4Vm9YVUVWWUxp?=
 =?utf-8?B?b0lFQldzQ1ZBcmE3VlVsN0I1VnFmZmM2NHltRXBtS2VrUGkvcUhNWmF5MHBP?=
 =?utf-8?B?TXVFVURTN0NKdFdOeWxnSTNSRytKdG9xNnNoZWtWQVcrbHlTMzJJTkdqZitL?=
 =?utf-8?B?cUxLRHpJcG9GVDJPZWlwWGtKRkJUd1U2ekZYQytFY3JTYmJzemNwbTVNb0dE?=
 =?utf-8?B?Q2U0S0U3cHhlTHJzUjVuYVNxZW1NQjBZbzR0UFEyZmk3SnpCdFk0RTMwbEtu?=
 =?utf-8?B?ZEZHOUkvWUxWcnloYWg0UWZENUgwZ2Q3cTJ2bFZGTTBwM2NJWFRPTHlyTk1R?=
 =?utf-8?B?MFNSSEpEZDlzNHRDMDl3WVdsc0Jma0hiSERoMzZIQnU1cE1aeENQekJYUmRt?=
 =?utf-8?B?QjJlMWd1WDdQUnBWTWYyanhybDFmTGFjeitqR1BDcGdHVzE3dzA0NzA1WXVj?=
 =?utf-8?B?VkF3czRGVFhrSGxwbU14Q1FvRHQ2KytJNnFOS0k3SFFMV3FXclF2bldNT0RO?=
 =?utf-8?B?QnFNVzNpM0hLWndzYWtWV0xoVHJnSzBtMytIbjZjVjltL1ZzNit4ZlE0NGZw?=
 =?utf-8?B?RWJmRmRFcGNVM2ZnN1loaFVtNHJZNmZ4Tzk0OGRpdGVEMWdaVW1mMkdVQjAz?=
 =?utf-8?B?alRBNHdZb0lCcnlMc3BlWjlNTGtieXhldyt2ckxnRDByT0VqVVNVQXJqd0R0?=
 =?utf-8?B?RmpuY0kxZll5NDFWdWxLM21ra1M0K3JNVlVkcVFZMi9RdlNEb2k1cnptVzdM?=
 =?utf-8?B?VkVxUGdiWEE4RUxEbHhaSFVmUFI0YUpQZi9FUUE2S3puVExxREE1U2ZIMmZu?=
 =?utf-8?B?UWxic0hrSzJrcDJTMTBaMmpLd3VpRFVCZTZlcTMrQlJ1bzRuZUtFWUx6dnBL?=
 =?utf-8?B?eExIUW56ajRFQUVZSFZXZFVWdlE2bnlndSs5SFZKVjNWdmdYS0l6dXZkVmhC?=
 =?utf-8?B?LzRJaUFMZEU3QVVDcDVNZS9wSTVDdlgxYXRoaXgxdEl5cEFlWmJaWUtVVXps?=
 =?utf-8?B?dlNyNThkZTRLWjMvd2lOS0RRcmt3MDBZVUVxWm0xazNNcm43MURQMkpPR2gv?=
 =?utf-8?B?d3pQbjBENUo2enlqemowWFhFNE5iNmtUNzhRWHRSMVQxMFZwcWJwdXFBRXM5?=
 =?utf-8?B?UDE3NVZ1M2oyVlNmZjc5QmV3Z0QvY1VIeDBhVDJTL2h2Zm44ZXpLQWdtakxQ?=
 =?utf-8?B?QjFtTUhvbSt1Y2sveW1hcWZoUGovak81ZmF3bCs5OUFKTzBiRDlOZVpiQTJ0?=
 =?utf-8?B?RFQ0ODd0SWlQNUtYV0FBMWo1Qm12NVNTSkNMVWhnYWJOSXFNNFBJcTNkYTZ5?=
 =?utf-8?B?N2MzMDhkeGY0SS90SFIzOU9iWW9yL3ZxanpNZms2QnpLZGpTZ3BrTlVPRFBt?=
 =?utf-8?Q?quhJHfAH4RuTfeN0vaIK4AxXe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EyNRmiB88UTZ2H8A3ER6FEvX7nSorB5yaM1HoVPUR7z7MI0mHEUE1MOzsU2KkDqdYUfz/sps3dkJPQOz+gfqOgD1YAapyFrr1QNV/i8TPNJye9sUJzpNAsSSUjg9ZqMo6frceTv9oZvEcg5O9rWFn8eUF9mu6qJ7VVId9iMuQGrMMgVt9xYkJmmb+q77SYirvIhuPxMcFK3Z5A9xp9POX2MgAYrs0fjGGxYnUKCqPNwuKSzq1mSblCPJy4ToJl666i8jgFB832lGg2VOH/8X8D54nKxsK9z69vLa0HcF8tnJCF0rsEjfvVTjAmfqs7g7Iw8qkiKLy4n4Qby95yF8FUpVvympuZLiUjuhr64EW9k/dFQ3A3c3rJ02JyLJqLHzh2ijHu4l6Yd7CrA5aIJzdmphcnJgEEfqAcUNEW3hvsFcBynhEu4B+kOFRbBE/+3S3BmTmEc655yUVFLzQa7ys9hi2SgGC22vWngEyKY4t8sRYKfDAP5O8hHquPcr7Qi0B/9P19EJTeIr9kz8GuHAehoCVo72bAA82L+yO1CUqq/goOja+ZEK4QUT9a6U4odNJOnMT3UYimWBag1lK3Mjk3/d4tSWVHUe5a4YVpPkyUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cfb9ce-6b03-47f5-f6bd-08dd510b725d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:32:56.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBWiKVbJQ8cT71OVy47wP/AAS9k7P2O40eyvOeNHeJs8LHlsazX34rsqmhBGanXyyJ10muoirZxbX4ta/yY2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190135
X-Proofpoint-ORIG-GUID: 04Ea6rdqoN6QrIhKmt09ubTO1RoBLU04
X-Proofpoint-GUID: 04Ea6rdqoN6QrIhKmt09ubTO1RoBLU04

* Kalesh Singh <kaleshsingh@google.com> [250219 03:35]:
> On Wed, Feb 19, 2025 at 12:25=E2=80=AFAM Kalesh Singh <kaleshsingh@google=
.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > The guard regions feature was initially implemented to support anonym=
ous
> > > mappings only, excluding shmem.
> > >
> > > This was done such as to introduce the feature carefully and incremen=
tally
> > > and to be conservative when considering the various caveats and corne=
r
> > > cases that are applicable to file-backed mappings but not to anonymou=
s
> > > ones.
> > >
> > > Now this feature has landed in 6.13, it is time to revisit this and t=
o
> > > extend this functionality to file-backed and shmem mappings.
> > >
> > > In order to make this maximally useful, and since one may map file-ba=
cked
> > > mappings read-only (for instance ELF images), we also remove the
> > > restriction on read-only mappings and permit the establishment of gua=
rd
> > > regions in any non-hugetlb, non-mlock()'d mapping.
> >
> > Hi Lorenzo,
> >
> > Thank you for your work on this.
> >
> > Have we thought about how guard regions are represented in /proc/*/[s]m=
aps?
> >
> > In the field, I've found that many applications read the ranges from
> > /proc/self/[s]maps to determine what they can access (usually related
> > to obfuscation techniques). If they don't know of the guard regions it
> > would cause them to crash; I think that we'll need similar entries to
> > PROT_NONE (---p) for these, and generally to maintain consistency
> > between the behavior and what is being said from /proc/*/[s]maps.
>=20
> To clarify why the applications may not be aware of their guard
> regions -- in the case of the ELF mappings these PROT_NONE (guard
> regions) would be installed by the dynamic loader; or may be inherited
> from the parent (zygote in Android's case).

The guard regions are a method to reduce vma count and speed up guard
installation and removal.  This very much will change the proc interface
by its design, since it's removing information from the maps for the
advantage of speed and less resources.  I thought that was pretty clear
from the start.

The proc interface is also not a very good way to programmatically get
this information, as I'm sure you are aware.  I'm also sure you know
that reading that file takes the mmap read lock, and tearing can occur.

I think this implies you are taking a lot of time to get the information
you want in the way you are getting it (parsing a text file, and not
doing any mmap write work)?

If this is a common pattern, I think we need a better interface to query
this type of information.  We have an ioctl going in for getting vma
information, but that will lack these new guard regions as well.

David mentioned /proc/self/pagemap - that's certainly worth exploring,
and doesn't involve text parsing.

If it's not that common, then maybe your zygote/loader can communicate
the information in a way that does not involve read locking the programs
vm area?

Are you really parsing the same library information for each application
launched to find the guards instead of asking or being told what they
are?  I must be missing something..

Thanks,
Liam

