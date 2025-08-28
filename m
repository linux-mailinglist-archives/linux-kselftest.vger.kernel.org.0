Return-Path: <linux-kselftest+bounces-40224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4224B3AA49
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0121C212A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD558278E41;
	Thu, 28 Aug 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z61+yV44";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NVdjKya3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773026F2AF;
	Thu, 28 Aug 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407032; cv=fail; b=Tkh7KpBiIyWW/LztiV/g9JdvO+Qmu3ByeDtPukkgeGN9Llqx6G8A246S2ELhS6Xncr/OR4dHTGAa5O4gc0rhHbhrZGEIDhvGNxkv16AVq76q/4caU7S0/GMUbASFdxJdBfkhwDj6ar35sghE7apHxOf+AMATrsjsE/IR2QfELdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407032; c=relaxed/simple;
	bh=c6VX4cZSlWrF0JiPMQQEryqhWxHVWBv+xtr5k1SaTo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMXsVy9UeGp1RK4XOVoUE7HNxK2wUOQ+JJTfblAwvmJ/2v+VH7wNyi5xavkrPQ+ynvZpbsZGoDWDswORNIPla+6EtUQddRftSr9r5dV3+Ne1QpwWaLuc6OevL1QPGlWgK+7yunwtsh5i/WRmqMzOODHsLCMdD9PwTmnYY9HIQL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z61+yV44; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NVdjKya3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHNcIQ019360;
	Thu, 28 Aug 2025 18:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bg1RKVoUtGDK0GJ0cG
	y4CdaBP3iuDyGY5KowArJDFUo=; b=Z61+yV44iSDAMHFNzmTcxC3AWXF2UYm8Oa
	PR92kbgzDypvWWXavTkTlyH2wTw1Q6UWK+VPBvI6Ta3xmRQeYphwLgE3G+3vRVUo
	voL8g6alAe4sfQ/3+yq6hQswXOnCh5wh7ajtD8Ilk+qvzZttFChKT1rTdIcD2V3D
	F5X/Z/85pvGMfhUVUXA/enkfWwUubloC8TGt+nOudU0qVJzC+CIZP54BebmB9jSD
	LbUg/k31yT/4ZGzLC0Filk31phj1b76ppzHuSHEzSHIqZbhOfUIAhcnV0RmTNG7J
	Ms48rXn0UvnTaSjWn4Pev3LRsPCa2yBRhTRWxZd3vQ/gqelRq57A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jas75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:50:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHk58C026713;
	Thu, 28 Aug 2025 18:50:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c50fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGQ4mr8N6hs4ivJxXSKsmoif3Aar8QpMG5Yg+zc+vEgdKdcQzIQWuAomorWO8GOBNI65vwE94MGDiiDwKK2Wk1unWgAiQRZNLmPiLLu3by3mzkuAMxf1LI1bdKu+7JOGoMgFzSSgOarCZ0drt2KQbLxz+uTsQHjMUFtuid4+YwLqf+8YEd4So3CZbSut7C6cz0UdOpbjW13TCcAYaHtfeZy88pRLlyn24cj4iBBKlowBogzjvo5l+lk8s6Gdmi1dol46XPmJp1u/yAKFuJghocF5axU4R7L4DBM07qq7lG4bV6jypxoKvhPG2v5Nd8U6EU/QakhEtXAu49bo5JRQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg1RKVoUtGDK0GJ0cGy4CdaBP3iuDyGY5KowArJDFUo=;
 b=lEtluIy8EmvRmmR578tM8tfYgk/zVkduE4JQVqwGOgDQYLPEQrIgR9cN3M1w1E8fH2v4GVVHx+NwKTd9i2aKtVdh2ZQBCEs8TBoKTjoJ1KZcXWBmBi7YNeXaWF5hjifHT4OGCQsi//DlvfQKBMW2KxtIgpG5XgSehA6nZLdILC9jpHbkBiCxPB4wqZoQwr7fT2Sj4DcZ+xcRu9v8IRVj5tBZDDTYAXlE9HGcjf1Gvfwmrhy5rpszHsQF1lcUmwh7Fcs88zTMJH8tcpaADNOEBTBD/mXcS10xXe/seP9Uyu4zLcVsYEvaf0rHn6nm8z14Oa8pmUW3yMHyQSe9ZsY+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg1RKVoUtGDK0GJ0cGy4CdaBP3iuDyGY5KowArJDFUo=;
 b=NVdjKya3FjA9Rx9o4ByFBUZCOmZTFLPHnm0HiPUOoteQRZU9h0VmXMjY9zoY8oqGndwJhmpaBDFNmHja+IepZ0nowqYZHSV0GALqgVkMe/o4UISUF4GoyN+AfJKKeRlwXIIHQoswyDGKRBOEUdpGf2mamEq1i6QoueVSR8O8Yn8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 18:50:08 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 18:50:07 +0000
Date: Thu, 28 Aug 2025 14:49:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, akpm@linux-foundation.org,
        peterx@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Brendan Jackman <jackmanb@google.com>, Ujwal Kundur <ujwal.kundur@gmail.com>, akpm@linux-foundation.org, 
	peterx@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
 <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: f250cd8a-26c0-4cac-f5dc-08dde663b52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qY6yZRsP7PAcwk4WB7OXZmqFlRQIlRHv4nVYWvza07MmxOEP6biInwB0VlP9?=
 =?us-ascii?Q?Xe5lS3x8a8fotQVnYWL31o+fciQ9lt10pixCr+ohVfDsWPBu1VJZkBj9vmvR?=
 =?us-ascii?Q?ARyWCgU6ejWuxeKYABXhoKO2JAPZlyfAzf4iFJP9ALU7qZQFX/cDjW0LjLW+?=
 =?us-ascii?Q?gAVLE/JaUFI7y5EQjRqyfNgllNkIaFJMKB2jPf3Rz0T/QL800EIQxY8YfzX+?=
 =?us-ascii?Q?pwxvAr8ZdeJASdbnXERPIGiV6feFNC6Wi5QEDfYRwTEu9TydKBWzuwzhh4TU?=
 =?us-ascii?Q?vStBNc3/1cSutOtB2Jv4HI5NSwtMEcyAxxf/MfEjdHi61XUqV4y18q6kUNRW?=
 =?us-ascii?Q?UB6AUUAYSK55lcAvOpnN5DBDb0Vd8AqMLnJjIUjf8+6jSrVuyqtH7KgNuul6?=
 =?us-ascii?Q?0cP9hw29FK+AkKyPeE6hm+JDK0uGbGsrxLLdQIaleXolW/Hx2FRBdOk9tSPO?=
 =?us-ascii?Q?H9P3iXNDQZqtwJd1PBLlX2U4O+sqSclHxmC30zhhVXRPgoPTENnbUsF3qxit?=
 =?us-ascii?Q?xq1z15fOrc7ZRwi+/4VOMk7UFrVSpKibwt+8fRMbNSH/n5ACXLQhRZIFg/qR?=
 =?us-ascii?Q?2jkgj/YECZ6kDLP4/jeVmfoHZ9zgKDs2p7BASnyBPWqo9ghXx9sscHL14ThA?=
 =?us-ascii?Q?bHeGh3r8CcUDOcs/eoMDHwKBL7Iwlc6URt+BhiX4FRJxrbMTMKJaXT0NUaQl?=
 =?us-ascii?Q?dCyMeC9SnVae3GugnFpsk76a8frEGiu0mHL1SOHbgSNUcJUEHXdeA5rARNXm?=
 =?us-ascii?Q?medtfmMKXScdSilIs9r4a4K9KXxl6SqkJw7l2FLfM5tfLXVR8CwdN1xJ5ZV2?=
 =?us-ascii?Q?EJn8/Yj1Kdg38ZOvOGg/tjHslbEp31MKzIAgJNhCizipw84kMTPTUNvfeYo0?=
 =?us-ascii?Q?+x30DEUuKzb2/lmHcPXeVAcLCgv95EcemyzyZMZliyG3DpuzaE377qqi5Nxz?=
 =?us-ascii?Q?yC1W4o1BS2n7M26cg1LDY7cdfyUCbMeaCF3bWT0Je+ErxzWCum3F9asLyvbR?=
 =?us-ascii?Q?WXTBbYVW61PkPbrJg3DC+sDI9JdqerQNWtaYlIL5R2jdoHK8PpjyY99WtWR8?=
 =?us-ascii?Q?54myX1nggvw6tpGt7hZPw5fNoH8f+uwbTNzem1rhUEyBahTKUbQXEXU2EqyR?=
 =?us-ascii?Q?WiJSX7AbYr8wZCfdIGvpb9Jb1c3V3EzQNOJR8w+EDQdC+IjdWhifEZCjFnRL?=
 =?us-ascii?Q?GLk4lSw2x9bZzEL/K+nc+wvaCb0m08HGD/JzWDcT2uYJMxArjSqVnoe0L9a5?=
 =?us-ascii?Q?9oj6oI212XSeKJcfUmcjN0V5jEOHDdjh2NwJ+0GGXRe2iNXspjnZf9Yh2QbH?=
 =?us-ascii?Q?TDgxjTIIUOtfRtEntYCt4k2AC9rK7Dq4dtF3tUKHF1tpFhYSqSdu+9yKf88/?=
 =?us-ascii?Q?Gf4L2wY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mw7abAe8Tmbcg7Nlo+Ug8kU2vNT6cOYo48AjN9supKX7nGVBqmOhkD4UtlTt?=
 =?us-ascii?Q?ywIBl8rXvkwVomIchPTxV2e9FsRogfYLrzbXinURYQ4N3di+taHYgo/PHu6t?=
 =?us-ascii?Q?pTEeoJp9GOXoiPnSQmUKbQN3k4hN5yDs83wPgr1itmhWN+ETGB5PFjg63lQT?=
 =?us-ascii?Q?uM75JlMW6rJah/ImhL4cSNW7o+o2AZerl/hYZbkAJ/LqDbXGy3Y4eBE8z+39?=
 =?us-ascii?Q?COm8Zy4OBD7dI5Fx9UftlsSSd80rwO5bpcCCXBuVWBqp5stsNOwJqv5FcZ2j?=
 =?us-ascii?Q?BQHzH3gJC2WnL4WfdjoY3mT14+EAcLupDEaJWZT65h48tmdcAu39GfN8vgpo?=
 =?us-ascii?Q?5XKjRYx8vWzbkzf5HW4i4NR0CmsEOMIG9R8G3qpanFKWsOYfj2o6N4FVqHwG?=
 =?us-ascii?Q?Umg79iGsw9oR52f8DA5E4IJoHXTd6+SiSbg0ysutcAgt3I+DqNyPpDtQGGcs?=
 =?us-ascii?Q?a7Jn7ERDWzT8Xs8YtvT0wQ3fJNVqAIuk0XyVUnl9a1lNMesq1Wp7Wu/CfnBA?=
 =?us-ascii?Q?+WK8nyEyKvEeWF9oAr2EBXHsIBWjr7jk/OB3VczBWJEYLDNc3SLozEwWMG39?=
 =?us-ascii?Q?gp/yszxETFxrTyB7CaB4Db8RykL9/uuSA/LQgEWK0elsmmOp8rqR7F93yu2i?=
 =?us-ascii?Q?lArHZkLQ/2uDGBgcjxPXY4CAbMg6yrV0wO8VnzggcWfkMtu6iGPKS5tdTjeA?=
 =?us-ascii?Q?aQu7aV3iJmIyH+REFuS6eP98E0sIyrtXz+G3Y+Xx35WGQj3fZZ2CMGNKSfkL?=
 =?us-ascii?Q?5Lsti87RxdWiTbG77pziktYnkLbBJrilZtMX0lsxkQQzLDYVBDjLICzvc3J9?=
 =?us-ascii?Q?d5K6BorgAN5eYGMoBpbau2FlGwSt6SvsWIDIBs4txx3vJw1K6TQih9Ar3TJ9?=
 =?us-ascii?Q?Fs6FPb6dTDOQg9cCT99FrQ0bnDtMCf1UuJR+tx1DRbdvGfEFSMiQOG6afPmC?=
 =?us-ascii?Q?RD8Cybj8yUAtwKVhJFTiad/MzFSDkJGbnKex9n8l3eiiID2pcVBHkw1FjD+Y?=
 =?us-ascii?Q?7uy6WCEzUgbRR4vPXWYoIflGyCGluExkSUgp7X4qRtDh/PphGUEjHKjYpHmu?=
 =?us-ascii?Q?voOtWi6V3YaeUjkwhgtf103R0qToCyVO43k3fiVzJtUx1L6p1+9xzjtVckC+?=
 =?us-ascii?Q?7rzvX4fpafNjq19loa3RrRPHblCtVou9mwLGDygI70p6eKuUMoGYeb9+ggBD?=
 =?us-ascii?Q?Sz6pfs1REX4kZ3vGDFuujWgI8/i5sk2vx2/0RSUL7OrnBN+Uwmj0FXqJWDWW?=
 =?us-ascii?Q?NjRvr07PHUmZanKY+JHweY9R1VsHq5iqKNv8kc0Y7YXSvqd1zl3YXpwOCHKF?=
 =?us-ascii?Q?qTxWVuab2xx135wj4iRq/MT8qaUh7hHCMItWT46dvXkFQxztE8YOPo5xH1ce?=
 =?us-ascii?Q?oDSYDrahXgGbO7N+527gbx0dKciSdbdSe5fD4UxDBmutp4YPFXQbmjg4b+hr?=
 =?us-ascii?Q?WBmcRN2bB00by4iVASRRgTtf7EtnSWABaiQaLXYiu4UCYm6ogf5h5dI7NmY1?=
 =?us-ascii?Q?vt3EMVXRDAqTUfNmMa3oWDhbIF3Ez8vk7oG2yCRH5bMeQvi7rGnyFgX6JCQM?=
 =?us-ascii?Q?k0WNTFDdO71YV5dYSzFrBGgw57EdK+7VIxFuTM9SyXIVypNRvOXES81xQT4k?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OXQ5fEq7mCaO5fTNRsOkULtic+U/olb+HQuDCH9SOJvociDpX8fQiX9JKlBE42oz1kCOLhLzy8I3dPPdAmfZcScBu/cgMGlFhrle6Wj8/jpRRjo9tmZGZbSy+C/m8ZRarPhQ+yYRn9wyVu/unwOv4XGTvxT75XGWRYTrHVYiL8plJlPurbResqaU4RPoTXkgfVLVLZaJ1AZjFN7jOSuvTd4bqnkk0EoKOHvMGVFXEYZf2MiqfOrKSOJtbpGowz0a1SxeQPVJjr0S1QjDuEf1Tbdb7u2VPxDRwSGUNf0IgJz4LTuHzJQOa4XgK6C+OWMvIQF7+2Lf8wm/e5Ud5z8X4H2zdGniMSqcETYetRXEumb3dUIQtwyLfr6NzJqnOU5c2GPmmSXQ96MCqnRxM8126oCgc0SUwbudi5+JCEuR98iGe4LR78plN3plnjFKt0H6WoAMpSfmqCoD3thCuonx/F7AXIb9U+B6OXvOo2SxOJXpcNP+z72CTAxuJWUw8Phq4J/5mkk7IW0xR74oZGRpiJH2bSSUrDWZdIjFRfwFeTKIOCYeLqhxcUxYgdkBL2qtekypv8IZAP7wUj4zF1PZGwl80KwT2KyjIuRXSqCJBUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f250cd8a-26c0-4cac-f5dc-08dde663b52b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:50:07.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv6SEZ1ihnxZHzhvMFvOF67p45AI7QK1feE/vhJe4CVj7oKD1AtEI6FmqOQP2O6dbUWIx+4/m1Uv33SRyUmYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=927 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX2HALnlHSdk3P
 aAKTg/101JVteQTM56h1+5DEdQliU9nzq6z6LGf2EikiCnXg4SyVRxXxVvsbXT1/RzE3FQFQA3b
 7WpfnR+RoESKEqNNzKHKT25Jnc7LdvqqWzey86Mh3DSDCjTLQNOt3Qd1LFSSYQcfQCX6ZE18Q4W
 xwB5xXKYhW4t8ZsRIjKmzEZB3ZK7/NZbJcPfq1HplenvHuis5WFgH0XQucpj619qn7UIgBt4Zid
 AGAVBmzY6qxVNmt620qlptzj8gbjOJ60e673A8vj6VlWq4jhIsT5beDyCrwFoZyXkxnmtmALnp6
 un1g1KJqwHqRt1GTsPGFs7f+7wVdasslZzpdDRdas7XIWppjlwvDIun48JkhKcCIdH7SvpjWaDU
 yBw1Xu9C
X-Proofpoint-GUID: wV5ceOZnrBIBsyIbdEKZoqNAaL6Mm-lE
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b0a4e8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=1XWaLZrsAAAA:8 a=DQP0r4UtjpL9Pz0uWvUA:9 a=CjuIK1q_8ugA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: wV5ceOZnrBIBsyIbdEKZoqNAaL6Mm-lE

* Brendan Jackman <jackmanb@google.com> [250828 08:37]:
> On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
> > -static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
> > -			       unsigned long __unused offset)
> > +static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 __unused *start,
> > +			       size_t __unused len, unsigned long __unused offset)
> 
> After a rebase this is now falling afoul of the -Wunused-parameter added
> here:
> 
> https://lore.kernel.org/all/20250731160132.1795351-5-usama.anjum@collabora.com/T/#m0449dc0d6a5ac3b1f71f7182c13b6829e1b444cf
> 
> I really don't think we want that flag, I'll comment on that thread, but
> just as an FYI here too.

I was under the impression that it was decided to drop that flag,
otherwise I would have also spoken up about it.


