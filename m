Return-Path: <linux-kselftest+bounces-15819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C629594DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F741C2163E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC116E87D;
	Wed, 21 Aug 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzLNtkiD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uv0KFPbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5116E875;
	Wed, 21 Aug 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222466; cv=fail; b=DRVILX4M+mnX20rSge20dgXWt7KBCEiNUGJ8pxLaLGzTeKVTr6SuYRiIRoNB5eFi/4e0mAu64HDVHNssI4pgRcTFjbunGGIU4aOLp7BCnhN5+KIENF5W5A1rClHbtfjRuyn3Uf9MEa6K09YudIo+iwf777VZ5EEbCyZgKv4TlhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222466; c=relaxed/simple;
	bh=cslk2tbEhQjdSp7c0MIk/VTabamJkghAlcwZrpSSjjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bdOurwD060FibmeMWJkSlGvqxXTbweGY/lM6ljD39kSI5KBUFTexsAmhHaljCjxHEG+8YLiMcmhBbCorQEn/XlniUs33h7DERBT2tR15eGewDgYYdDanaLpI4EcUzADVz+a4lhMBwwV+boI6My9Sk1TYtMpbnogkkmuGDuI3cz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzLNtkiD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uv0KFPbP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4fa73022546;
	Wed, 21 Aug 2024 06:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1LyQQpxpDrA/+on
	mIUtdB+8Ab+bU75REYKUWbPOFuRg=; b=hzLNtkiDwxLMGWmGKbR4fWj7q2vFDX+
	3faEyfPuV2rZsSf8jng/x83a3nvcfVT3A0cy93HMyaip078OqLnbw69S8Ct7wIgM
	TezAEQ0Z60ECamLgUMyq9OLSY+bv4t/Sr4yXUQZq3JvEKYNnf7pD0mS2REHyDTDY
	u+bFAffj8xlRf9zf4o6hO/zrUVOj5lZAeRMRDECWZH8Drg+zxIZ9//+KmVs/vaEv
	EKi7TJbXDbvTKKB8Jz/AApgfPRpKD5Yyuqg1xAFw7m925vK3PO1vntkpwv64+OQt
	Ew2jhScQAu9GfEvIW04kWVrvB3NMgglyPTgRPdJTPoJ390XOoNscbtA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uxs3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6J0SH006405;
	Wed, 21 Aug 2024 06:40:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415av28j7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ3HHXhbZPdkU6kA8ENTQgEjnDiSWwIijvAoJfxsr+YQutDqL6BuPVqWL+WEoFwKgR6rfaTj/QKqE5gYG3hSp+HrhaNZy+/QkmkQjyvM8jjWqCreJ43U4IfNUAJjVDmdJaNIbvUihKfRLnl8JH0DCp4I2cPTxcjDts9Wad1z8DYl48qnqQnJXwmm+ViZmgWnYGnVC17b6DxSB3CYLZnFAv/xyQfGUHW6iPJbYMcIT3AymPdESC2tSnO+N0iddF3w3gQaQjOvHjRnIeed+yydr4HxKf0xHwIWp1Pvb0+dBxveBjPcmhl20+PGfrMr1KmYFYF48hxYvlYYHoIuwJZKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LyQQpxpDrA/+onmIUtdB+8Ab+bU75REYKUWbPOFuRg=;
 b=Ci4k479cssf5cYxmyuMbGhF/TT0LpczO5JqrKIPm/GaSV/vC8kkZbT+FiDNIkciJF1uk52Ij81EnfVt3aTW4iPNpmastYphYxoS3UoBB8VereWExkc73K53gRtvo2mmK4RF+baejB+Kh9q5CC+5KQRmP7BCl9TnrFrD3/CEWV0uNEMlgj5xWtBUEwPIUu62YDUKgoCW0YGyyhOvJnp567QALCaU0mJKF9ED2wmZlcDwj8YR5vCYNGjqfWyqvdoPBazNGID8LfZXvxWpYtjmbpu03zlvJ/FS42FMCg2pIZ0cFxX2VnfovNgveksJCJUoLiCYN776beCydMOkH7jCx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LyQQpxpDrA/+onmIUtdB+8Ab+bU75REYKUWbPOFuRg=;
 b=Uv0KFPbP2yEVjhlDEUQiKlNtiVOcmehm8hgkbZbnZaoNuOdPuW2kVrWv65hP/Arsbe2dM+jQkvlOwvlH7jsDjKgkkzjrgM830cCTX8nMTW+1KIED4W2i81wQNk8BDkIONNq+CuWDuDk5TnSIy53tD0ngNOYX+qcpstanVluqUIM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7382.namprd10.prod.outlook.com (2603:10b6:208:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 06:40:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:40:40 +0000
Date: Wed, 21 Aug 2024 07:40:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <28968a48-6a51-452f-88dc-160344905531@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 6308fc95-f7a6-4096-41eb-08dcc1ac2c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MD5+JWYDQCK6/UhNs6G2f4f4oLpnuhk9GHt1lhThePILM3y8l6hpximBFzLi?=
 =?us-ascii?Q?LgIPGc266E0HyNk9brS3wVZWtnIDg3rFe9kQK+E/NfScQQR4Botslju6Q5mw?=
 =?us-ascii?Q?f5gWSWuRmLXJZK6wpcs9MsvWYARc0ob0CnY7GnJWAkuQ6fdazM07ed6b0I3f?=
 =?us-ascii?Q?WVE6/UHyUG2dLzbIhyDe56nK/wWBCyIRMX2H9aOJcDPNYCpQ07nnpYPfUajv?=
 =?us-ascii?Q?Z4G5It5nwrbIBLyLADKZQgv+qhrPl87QY8WQJFoysqclWSgFAiNR/CcaG3NJ?=
 =?us-ascii?Q?CNoSvx/kiLr7StW1FJfik26bfpJ9HO8fM0o2Py4UQXSARhDRIJKdz3WrI070?=
 =?us-ascii?Q?jYuxzkgKPPgHaSk516N+WQonqO+naFBEMIXopJL81g9GsoUikN45ZfUEvV2f?=
 =?us-ascii?Q?6nHswRJSOSCtd495j0cWX8UjMGR0x11w9C8bJc8qKNCR5g4412fBanNP8+FS?=
 =?us-ascii?Q?cKqOjMAESP87avdlNT6lHQRStAYia3FbrhC2Xki5cl16rqKEIdHhmBeFDnAj?=
 =?us-ascii?Q?eXPRLrOaVyBn1ktfD+xiyvDjdDacDHImNni9tr7HXxKd5m2qIyNjcwQKZFv7?=
 =?us-ascii?Q?vgvyPvvCuXf9QtTIrL2pHsTK1icnTypM33enzU1ZBpC15qeJQj//+N1Mx0x4?=
 =?us-ascii?Q?nvr35DJVoDXHPllWhzflKt+dPpbLHHEwz+x5VjMAff9YMWJhiG8eXRKwukEr?=
 =?us-ascii?Q?8cbJZl+oxV5lzcXhkIcW9Ux44zm4h7Rv/7MMtzFNJangG+mH3isEOTp9i+uP?=
 =?us-ascii?Q?QwJIAUMWI9bpwTlBHlo+JHprHEZSEvhXYdZWT0GUHHu2ShuLUUEJHcOZ92Z3?=
 =?us-ascii?Q?Ko71kSzmNx9GA/Vgxm+giLGe45+8SZ9Ke5IwlO48ujL4xluLYDXbMnJDRqfd?=
 =?us-ascii?Q?r9iabM7qEdXHfkbkq9KLiNU/Nfl83M2JXEeMZXPioByhwbzsyovbi3trJOXK?=
 =?us-ascii?Q?2KVBTrcV55XUb33NZjp9/XDOCNSHByqQGFyx6oCIfjFSkCiwKqitF8ZgJ5AY?=
 =?us-ascii?Q?xvQN2fqcWD04Gj6Yv2LPv3mG8nEXj6mwZWI4DQ0z/53niOvrFkl5icbtekZB?=
 =?us-ascii?Q?YujfNIJYfCEG5Hum6QDamrLF+/Y16GIP4Yk4t9n1ZYO5uCCRV15LU6WcvyPB?=
 =?us-ascii?Q?oympWBZFj47+/SzsXEvfnWzwliwJXpVfUSKEv/19+yBVe7kgGOQYjh+FrxNi?=
 =?us-ascii?Q?mfYDu1Ir+Msl9RRyvRLBp93WEUSS6a1gXmZ0bx5vQ+wSUCuKKkBWHLyXNs8U?=
 =?us-ascii?Q?gN7b5GzTraDBmab/dfu3UrDHJuCd7r/eUbpplmJq6+C1b+EMXyEA9PFaWdta?=
 =?us-ascii?Q?LlV3pRTPQmSOlZEFZOdpWrTpJmvAI50TIG5XBnPOxhIkPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqb4Qjr6K/riRqj05ehrE7WAT8u6U0lFcp1LJfWRQTfdPquVkSgnIhmbizli?=
 =?us-ascii?Q?0BiXapoK2uNYk4TKOXNSbHT6UFEghhVN3OTA04VSAuDJRP1uV4KywbKu0GAb?=
 =?us-ascii?Q?t3sGANXshxtvA3+CnYHKX1RKIbeo0C42m+8M3yWyplsFB7z+kC153n5Tvz4u?=
 =?us-ascii?Q?yG4IHMHRXqRnao8Kr8+A9EknjX5NOVUN+sE3T9oeh9vx0oATKLwCQhmjPFG/?=
 =?us-ascii?Q?/ZzpW3j499KXxlXanlpvoy7pHeuHxLGXHpvuI+18WTGkpObOG/AnNvrdtGF2?=
 =?us-ascii?Q?8Bk3VE24OblcAAztBXt2PhNB1e1hoLjZcptzsRjetvaBcClSFxt73sfIuzpX?=
 =?us-ascii?Q?eXQ34htacLekoVewTyvDY868rVKtilm3mwgvztSoM3OsnG8/3b8qaMV6EqX/?=
 =?us-ascii?Q?6GDJ+L0hgCXgHu0/pw4Zef2HGO43KrdxGvFEaRSyE/7op/fPzrclsgo+TJfj?=
 =?us-ascii?Q?XfjlXP1MSGDODKPY9F4UwN+e+CkeaZ7UFhEbcy8LVvmbqVRucxZqXj2PzUG8?=
 =?us-ascii?Q?4WKQxvIWKQgenkjkrMrGYJtZD5dqjPDSdP9U6+BUSCCn6KIhf3omJVGRIUBi?=
 =?us-ascii?Q?bjXPEf8slLGTov8eXrfLy88FgPkmQoejSsHdaco1sIaQMM0LQzBg3PUSl+OD?=
 =?us-ascii?Q?yPBc5VGOAsOL5gVoaqU1aSVI+6wx9A4YccGBUcI2h9AcXTU1Mr+6ZnR1db2O?=
 =?us-ascii?Q?JQtkMOnKDl6th3XzJRDOPSm+94iIa1vfZo/JOxJBUbAis50NHKPaiyT3Qwkp?=
 =?us-ascii?Q?OrdZx+TPh+icsyaMYHJJDiSfkb9VAAWV4S8pwgHq1vdfTR9yFuPdk21Ukc3O?=
 =?us-ascii?Q?D3lN0GTcsozwp+9aqrupuLIX3qOcXYxKoIIzc6LU+rsfRLN9M5N/KcS/FTRt?=
 =?us-ascii?Q?Fe9MkAlrmL3N/HF1SlX93MkFLQDA2rMZpkk56S/e2dqq0nNbKoqVEdHXZeU6?=
 =?us-ascii?Q?XidlsFgN+VWnno+6i6bZ5VDY2DCNXtgSCVAGIZqQ7Vhd08q9KmJZW54/nkJg?=
 =?us-ascii?Q?PrjRj6m3G55kLLeTMxN2yTFRfznSOg/lMHjlbNxcZUzCYK7+bIK0pdymbz1a?=
 =?us-ascii?Q?Rz2tuY1SyhpiIdE6rqCWw59kABV1aDKHbQEd5mBgzPD80o5wGvkBWdYow7Mh?=
 =?us-ascii?Q?J8SdE+5vAKj4mEuE8/d4kq4H45MGRzQC7EM+23FNreHTQhc89g9mQHbJdQ53?=
 =?us-ascii?Q?GqDIRsUOWNxhgNVxRQkG7pUrDgiS57kj2Iy9KdFa4+6OoyQPYBhYKGubxsx9?=
 =?us-ascii?Q?pOdYJAOsWkDJl9OinICBwBBOKYD4AU68I+FzBg0j4tR5DG0pIp0us6l/1WYY?=
 =?us-ascii?Q?aGVuuqISoZNkQ9Nw0F/5I9Ma5CSNoU3h5pZ9OxpmTZ4fW/pLdlF8nvZFy20n?=
 =?us-ascii?Q?sleG2eAXlKS2U5vlfdPfvVJhZe0nWjQYsIT6P7VgLk6fAo5kncd0K0awWnZD?=
 =?us-ascii?Q?ttSBkuRGIDL2V2Y9x2DhInBKo+iEfF2ufd0b3iA0Tk5aqL0ljDzFVhzgYJbg?=
 =?us-ascii?Q?TvCy7n2mnOH4m9DN+l1q/0UpGrrFxWkffxGlS45OoJDZKja5TOB4sTzhG9TL?=
 =?us-ascii?Q?QWNKgwQwp2vgSlAqyh2Wf6GZeMOWoWSwooSHc2n0AT+ey0sghF9vC7Q3w8JV?=
 =?us-ascii?Q?kYPGfdYwB/v0d0IvQt0P0d1SWS9/cr2fpR+SEza5XQrfWWwooWiTl3MvvPn5?=
 =?us-ascii?Q?OjxDqA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jVhOKpbURfRAkRZ1NIGPTaTdoTuQ5CinkqOfqphOqR9K2KMiHshlPQMJdbv8mZLJJw9Mbgfb6G6lM/dehfDIX9qncUZTqqh8kTBbtIUVwXLDOVDTzCEPCvg6UL9KcFelHpigrPpvKvfkwXvhaQmAPs9tel6J8wvhUvYpAgH9zoWJha0sGOTjfE/tsedF+NDWs8LJQPPybpCcQeJaLTdPoRyud6Ep2azErHAKJr3S5BKUeXMZpmE3EY71MfecBmSgofS3ba4H2LEFPIH2Ejy5izAuu4eTWfHG5LGQJiyLRvRhBN7Y7htqsObviy1TQsJxFF6Smvu8lJNP3sOr8H5xZw9o/F8et7ZIxx9UOn0ZNaz21X4i+RFUoFZipFfI5+fX3Fb5SHguxMaHZihreDmxpl6yaOLHQjrNH8fmq2AVdc1KCfl+zvtNj+hx50qHJbUaBuoy5iviagetJ8nRTFi/1ucFA1mq3WmgzwNa+/iJ+b9Xo1fbnPBoz89SogNwwmOZGGRzx/h1K7Olkiermb/X/wyHqqNVuP2yAB3qcqQbtVqHBFLoD48G58ah21LjcEvSWDa0GWuzjGQifivH4PUaZR2/4GAP72ME24rntkbkok4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6308fc95-f7a6-4096-41eb-08dcc1ac2c7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:40:40.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBYyVnzIc6qqrJi+v7rc26bti86tZQ0UISMx9aOckyF17wmL2tyiW/pAUfG8DZaUXKWhs2Vuh7DJV6e2EzNbsaqSPYokC4KNjzWu/7zoYwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210047
X-Proofpoint-ORIG-GUID: uJ4ff10CuBcoMPuNvyqbBZdSBsyepzHL
X-Proofpoint-GUID: uJ4ff10CuBcoMPuNvyqbBZdSBsyepzHL

On Sat, Aug 17, 2024 at 01:18:29AM GMT, Pedro Falcato wrote:
> We were doing an extra mmap tree traversal just to check if the entire
> range is modifiable. This can be done when we iterate through the VMAs
> instead.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mmap.c | 11 +----------
>  mm/vma.c  | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3af256bacef3..30ae4cb5cec9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -	/*
> -	 * Check if memory is sealed, prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> +	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
>  }
>

Oh I like this. Want more mm/mmap.c stuff to look like this, abstracting
actual functionality to mm/vma.c...

>  /*
> diff --git a/mm/vma.c b/mm/vma.c
> index 84965f2cd580..5850f7c0949b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>
> +		/* Don't bother splitting the VMA if we can't unmap it anyway */
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto start_split_failed;
> +		}
> +
>  		error = __split_vma(vmi, vma, start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	next = vma;
>  	do {
> +		if (!can_modify_vma(next)) {
> +			error = -EPERM;
> +			goto modify_vma_failed;
> +		}
> +
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
>  			error = __split_vma(vmi, next, end, 0);
> @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	__mt_destroy(&mt_detach);
>  	return 0;
>
> +modify_vma_failed:
>  clear_tree_failed:
>  userfaultfd_error:
>  munmap_gather_failed:
> @@ -860,13 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>
> -	/*
> -	 * Check if memory is sealed, prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -

This means we will arch_unmap() first, before realising we can't unmap,
however there are a number of other error conditions that would cause a
similar outcome in do_vmi_align_munmap() so I don't think that's a problem.

>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
>
> --
> 2.46.0
>

LGTM, Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

