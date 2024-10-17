Return-Path: <linux-kselftest+bounces-19949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581099A1F4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 12:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678BE1F2951B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B31D9A54;
	Thu, 17 Oct 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PLqVtaUB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WYX+vVrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF871CCEE5;
	Thu, 17 Oct 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159336; cv=fail; b=ucCy0W3CVJJKWIv+MBrT23DipSW6/StPvDSEkIZic256DSQufcyjtn4PCKU7BtIujjrp0zkfn0UHcltF511arkluk1srP32Q9lgTDErXLlYMYXBsuFjm19t+ubV3sddqUgwHkvBQcnPaifvhsYKQGgL48JGOvM2HMUKhRjoFWqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159336; c=relaxed/simple;
	bh=heD0872MaIQte9m89BGIJkdwniP8sDwuh3E1fJYq1eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YgYzbE8bmyeZdh8LzEM2JUfMy+2oISTEfFKnZaIQSfzgByyLv/klhsvrCAIPyo6WsQXUEspNKpGG2S28gtfBAoMIi3g7Zhbr+b7UcsHMkcdQnxF/eDGqvHRb8Y0wi9XjtO3hgZTV75qLdsCl5+GeuoFAqf5Ay7rVSkllGmRaTkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PLqVtaUB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WYX+vVrs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9Mada000593;
	Thu, 17 Oct 2024 10:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=749fjQg/ZzDD8e3pjX
	I6huWlA3hyO2rFtOVe7goLYmE=; b=PLqVtaUB5PPdmgHRbYiqEsA58Nb8f+VAeM
	VcflO7ILRLUXrCCb6ZB09LAKtzEDp8DFQN91MsxzL+UptSqjYYcgAFUWTj4IKw+2
	ECeiAs2eW9cLv8EqQvtJg4flXXktrlR6vY0GsGvBqZG13lKHANG+cCPFDCbQAdoS
	0P7+ZrEvoDD0FO8KBLLv/zEi69gNsoeMUbC5w6b2GHqB/Tlyb579J/iaxrscH592
	4MKXcPpUMHj4/wJztlkTB3Q1tVC3hgxEPh0jQOkV920QGnoVocYEs8KtPtPOSBJ+
	c64A9P1Mmrs4Edq1txJSOSfCsrum7+xhXtE3sB3QmEQdalsyK9Xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cpa4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:01:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8ceTi035999;
	Thu, 17 Oct 2024 10:00:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgepxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 10:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J05lCDIHQw4rnS7PK0HLiJ34khU1QcS5FYU+zcPA2f3gNATCt2HUMiLFm3xowijdWo79jhVFicXGZUomYaz+36Vdg4lF6kkhZuATjBRoeV3V/RSk5DDDH7CsVmrlfxlNFSdRLjAMNBmQxlhWRo3TN0OHgUqCS07WO1nv4Qh5JVGxophlS8g1P7uXw+U1UJgOrwCHCy1JwE5z9NxVPfQT3bXNAZw4HPDC9E0/WHL3wYs437DLBfEfnEtg4WNJm8v79cQdT97hyNwrvWc/c01F1TsNC1uvUPqszyYhXUcfIbQWRzn5A1y0ok1ZQqT1u+WsWd04ex78gDMFR/MYhERL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=749fjQg/ZzDD8e3pjXI6huWlA3hyO2rFtOVe7goLYmE=;
 b=a9rTvi9kNpytm7f/PvUWlVjT8lhHIHaCKbTuMZUWFVIobauywsbLEXWpzFkDDHiZFxGBYfp0ytkaXduMDFuWviLmKKfox3f4UylTGT1CSt866FeQmszMUpE46H/tRJcvb9IoSqf8/8dj1M2Fo64vzyirBioudhpIuii+/OxSCUQfRh2mxeC/5i9ASBcAXBSG4NKe/gjQax0leifHJHpxzhX9GPQa1ot6d3M/NXEENZ+fJxMfFhjbTw4rUDKpA8GMvdZNnjlWe3RULn3HRV9/kNHbyIoHVXFB0GV8e2/v8gTri2QM+VLNpi33KYJvVq7oAvr2jhlGK5VnkKQVi2bVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=749fjQg/ZzDD8e3pjXI6huWlA3hyO2rFtOVe7goLYmE=;
 b=WYX+vVrs2Tk5gqnW+DRWvfDzUHsNC7a/Gp5VWITifqbzGoUYyCje6X9OsUP5We2zTHyYGXTudSeWI0881DFKimS5o+ntytGzjQi1BQtDG2XpXhO7/SheheMgD973aBsO8k528qMSYYsu05OPdoeto21jR9SvvxAWtLG1GwSkRY8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6985.namprd10.prod.outlook.com (2603:10b6:510:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 09:59:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:59:59 +0000
Date: Thu, 17 Oct 2024 10:59:56 +0100
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
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <e359abef-316f-4fca-8d1d-84b69c8bc060@lucifer.local>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
 <ac11e4c4-a1df-4d39-b7d1-ed9ebd65cd16@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac11e4c4-a1df-4d39-b7d1-ed9ebd65cd16@lucifer.local>
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f4095f-1883-4658-3d0c-08dcee927604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgvK0hTqykyPyIPgro6dIsIhsYaXT1Nhwt6DUs1rHiDN6EapKrQcmYCUkKbR?=
 =?us-ascii?Q?eLG1g/5zz8H4ia9iFIv55A8WTp3x3lgM2x1GwzOqPqh+gGwdwEtbUlJzIOPk?=
 =?us-ascii?Q?oArIys4j3ie3fgpKYHRWjz3WYg/QLlZw6zE0vdHlnhlKC6goZOOD/deV8Bm8?=
 =?us-ascii?Q?lM04fhVYg8uDfAmBr0pm3F2YTX+ehcp+JVlraT9TYmIhYrGZUVuu8mStPFWn?=
 =?us-ascii?Q?rHouZHAs8KIC7Y1MhhUgs5YXvoZs0VOBCG9FzePJ9dbfYS/DAIABsyCrsYUb?=
 =?us-ascii?Q?YsMOaqGCCb/FZthnerANNXFnFDsagSZnx04Ys3paDCAUDGlrxdRVEGGI9plS?=
 =?us-ascii?Q?hpdDgtgtH51n/LEJqibNxK0zzpbuN0wSqTW8VrnWmu1xbm08dvTOE+SdIi/D?=
 =?us-ascii?Q?b0P/xyHM6QYLWMBgESMUNueRwkMwq94fjAYHCna2kOQ7TaSZyFYWR+xnc0kC?=
 =?us-ascii?Q?Yvo3eaN2Qplc+u8R169xZc88Ltg5fmR83eIzAQQbkTLplXinPgL4tC0pBjVr?=
 =?us-ascii?Q?sp6n/fKt2wheSP0+LGOU7mzPMP/2kz9lcu7snb6Sit9/nLkALHh6oEY3kiri?=
 =?us-ascii?Q?wbOMqs8oYuUVRONS8iA930mPIOVuYAEcOO2Alks+Cn+fL7EV7iyqo9PQoMov?=
 =?us-ascii?Q?JbnErPXX5ibZz3W6g1cHTmq1uhVntNdJEECSVYDWf50tbPTRnUN5h9j1r3Xu?=
 =?us-ascii?Q?c0rRdhL0MMLSdqCfmtpQTXa2mWgdOFNgkAZIYA8RJlM9eaGInVx/Qlpf6afO?=
 =?us-ascii?Q?7A8hso8d6g9yd2tlK/AihJlDTF9hydDWB2bAEtAPR+ZTVsSQrjgxPxQ4hWj8?=
 =?us-ascii?Q?Y3jWgRBLHVgxxbJcJfflIoq0mWSgXw3oabWT8oeWjMdMMDm84JoGPSotJGg4?=
 =?us-ascii?Q?2yoLvypiE7qYZUWvTSAG8qMlfTF6dhksCLvpDPujvRaZU6zRGMoldO/Q9q1z?=
 =?us-ascii?Q?1K1Ww7qlGpmgTIHc0UdF+SbLH9enV4emxUxqFkLpv1OyEk9otzHUmp+UYzmo?=
 =?us-ascii?Q?YYSPYVrLVidkQTNTErOc9S5+E5vaMIwXE/2QAF29eqzn3U8mqp1jChlHkt+3?=
 =?us-ascii?Q?ZOy3pK5hq216hprlNcHdSAqnTJnx5IE0gtVfb6tN41NuTRrKQbJ3hCUaSJwF?=
 =?us-ascii?Q?JszdMC5tQJ53Uvk2XqiIM0L0JIU9VZvbBXObk/pYdvub451DJKCT1jo/l+Dk?=
 =?us-ascii?Q?Gq1+tHYFtD7cGxsFCZEddYnecPXpx4v6tCsEeeB0lgEiQZdKIOUaxUQ0vVP4?=
 =?us-ascii?Q?RwKisYtytiZEMz2g4ty17FRzX9R+EdlO2q9TBgX9kAzWI6RucJKCZF0BlNfI?=
 =?us-ascii?Q?GT0JddvBlM7uTdcCPwDphTWP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ydpigrGRXKEclur8iSYvgS5qzo7lCTZRRrMtSu9z8EKSmFrZyOUWi1T1+GHJ?=
 =?us-ascii?Q?PKS9e3AXPLt/Ba8l+p3v7Up6zmS9R9tUYnGxStkOuNoyP0Dnf40nGDZIoBH2?=
 =?us-ascii?Q?oV83y9YRUy2+HO7/bS88esAC2M1ut/Pwmh7Kv5dpR6E2qu8cu3ebeTqFFrTs?=
 =?us-ascii?Q?nXaRRqFPWYwr+wxz/4ZijPgAI506DhyJCQVlb642R7OVR7OXG7faxWBJmhQ9?=
 =?us-ascii?Q?KHHgpbQc1q7DSh25SspispMtH7WNYX9W9nB2fwSazBZ4IuctJ/hX0Qd2MMe/?=
 =?us-ascii?Q?MHDlG7w2QiIP0n6g/c56QiPMlH2i+yRiRVHlN+M8uSTrQKkFkxQDypQkOhBT?=
 =?us-ascii?Q?86zzeL2LMWne2T9t6zlKk+YLx9pBgccZyjbpL7U4UYAZEs4+51AG1jt6NKx+?=
 =?us-ascii?Q?eMy9BrdshBjOXbfqGKKFHRIjsxpLdgUy6jwMoAbS8CBw8hJGgRD9/n7/8A+o?=
 =?us-ascii?Q?1RmedKPEGhMK+e/s5se0MheqfMsB5iebpKnGBWHtrWunv6ozk8daEbOvoF+x?=
 =?us-ascii?Q?/PEHW0+xNpOASbtxCh/lRLrrr2GchRyUzaETEOAezNaCseAhgxE4r+K2F/L3?=
 =?us-ascii?Q?naMFY+dPOos5p1g1m6/W8u4uM1VSM1Znl0UF6l2gv6klkzf1J0c4VRGsr+Fz?=
 =?us-ascii?Q?JkEzKHGmP52LhBd3aI2dwSaQGvdVylhVL/jHOpkG933cOu+Za6xUtZhCsw18?=
 =?us-ascii?Q?djoyh8YEIikMsC7QrcHX9LdFdQ5gd9E5JWPwjwsIkSrtgWR+K0jQb2OX+GCX?=
 =?us-ascii?Q?+HDHuypOW2zuOS/k6JShe40XEXcEb7hdSevKgOhesJgGI9I7dG1pgUp/RCVQ?=
 =?us-ascii?Q?S2BYVmber/P9rp40dG4KtDBOnZqrmfIdJlF1YnOSNikkuM9X41WJllabhJNG?=
 =?us-ascii?Q?5oE0tM1nt7rfl6sr0tqEwHpy9rGzcxAKPvAMwDCHuk7LJ/9VU48bl5Cw7JEm?=
 =?us-ascii?Q?IReuSvvupSJn+hMK+Jy8su0KBuqEZW8rMvEjRdzdG0BYiOadl4NOyDdtiXGx?=
 =?us-ascii?Q?VExVfBiI1Pvq16LSCfBRgCOhwCC9SQzrbrkecP3E18yMYWg16gwj86m+Xt2K?=
 =?us-ascii?Q?mZJNmdEAkMHw+L6VoMMn/ADi+xD7/DNT4q+qWhmKoiIGbOIetFxgMsJ1MqqG?=
 =?us-ascii?Q?uz3efM/B7oZi4YcxL0QCprUI+vwTokphgNt1ejgmd0EWtNd+McfJXXPXVCv0?=
 =?us-ascii?Q?QFtolATKs7i77qmDqiIc9yH60uajY76UqWHGYE6hi0TeM1Wns3HfhW8sIyvw?=
 =?us-ascii?Q?GVKglaGL1PlzbPLxenbjUbepAB6zgJbjXtZoBOiBuznX3CtreJzd5niaupYJ?=
 =?us-ascii?Q?qNFpWFsOKFQejKmGbC7Eaq5QsXXEsTG5Y2EHw9YE8AzfGdqTob2ceFng1srO?=
 =?us-ascii?Q?sYIPXfXWvo4dVZhuanusfqiJjfI25TmbdvMub8ywpowiZTNtOSza8oP2xxMT?=
 =?us-ascii?Q?zMpMJ8NuvG+nrLdEIcRH/xy6C5cDP31oFb0nT1FlRNnurxfbx8S7H5cMycTd?=
 =?us-ascii?Q?wRx7naI4NeGT9xICOZBdtGDaxeCCRMEm88eThT2WW9ZfYR4D9eUocbX7Z0EA?=
 =?us-ascii?Q?qU0jEwaFs0Sm7Dg332T17Jtu9cbTuLckaX1WFurT3VpLS1cuB8nJ/qFFIkS+?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wd3M32Zvur5FlzQy6KbejdF0h2Es9bTOWuEEVsB8OSkTVFmhFShK8ob9dAKvTq3S5X3tLQzaJbJsVRlmC0O208CXkW+wiot9RYOyk8XJz18nL4znf2cZZZx/zwwQZ/a2TsnhGtnHoohG/9DKoOQNSNCawri2VJ5XkvmXCCFDNX4xwyTUPVN67jlaX5WnPx5T0Yubrv7WTSWnVEQQiyGFtcx0BLVIlAmZ9vvr/veFjzSF6CO+w6hdSJlErRtfjRBWkCiXezrQbvKfOfVOf0GlLZ8gZZs76BCZr70OfsD5mfg5xGKdWpRI0GHYIIWjJOM/wzz9034i8zRPe8otreUMCJ0ObJMx20Zd81mNQE8TuF8TkBJO9a9tXBM64fJXej+KhWqu5uAou3YaApcahJUke5L1ArWxBXxeOQR6ceHOi9LRNRbIs9p04OUupwGkP8QIAGNuWIRDc3RpRV/2xs4Gz++8Jzuy+zSzvr8yATTSwWSxK0Omga3FxHxx2W+duekQ76pMrzlikr9k95iZL5MUZz4zpYqUYp+QPFd8skZTNAPx+x5iMvmxrceKDbChWJXDQ2WzNMKB2PUR+ng9hoarr48YDzsBNmxJEnxEXj3HckM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f4095f-1883-4658-3d0c-08dcee927604
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:59:59.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/ev360zddmccdqIyWGeeAgPTDMFUfvRthNnGtSA4rDOlR+9pO8KcS/rOvfMLuN0VUC67pqy6O/xC9SSOorqGgRM60N5Z5I0xbBimND2Y8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170068
X-Proofpoint-ORIG-GUID: ltsI4ja3Keh-QUEYvoS4KDWOFPVFWJNJ
X-Proofpoint-GUID: ltsI4ja3Keh-QUEYvoS4KDWOFPVFWJNJ

OK having said all of the below I think I know exactly what this is...

When an munmap() operation aborts due to error it does not attempt to
re-merge previously split VMAs so you might observe more splits than you
expect.

This is not a bug, it's expected behaviour. We do intend to address this
going forward re: the splits, with an intent to see if we can re-merge or
otherwise change the ordering so if an unmap fails you observe the same VMA
layout.

Before Liam's series I believe you'd see the unsealed portion cleared and
there'd be no recovery so that part of the VMA would just be gone. now we
recover it.

In any case it's absolutely standard in Linux for a task that performs
compound work all of which might fail that, on failure of the overall
operation, that it may be partially fulfilled, partially not.

So yeah, not a bug.


On Thu, Oct 17, 2024 at 10:46:10AM +0100, Lorenzo Stoakes wrote:
> Another thing about etiquette - sending a barely coherent _failing_ test
> with basically zero explanation as a... patch is NOT how to interact with
> the upstream community.
>
> The sensible, respectful and workable way of doing this is to send
> something like a [DISCUSSION] or something and say 'hey guys I think I
> found a bug' with an explanation and a test patch attached.
>
> A lot of your problems with the community could be resolved by being more
> polite, respectful and taking a step back and breathing and _communicating_
> with us who are here to try to help fix problems.
>
> We are all _extremely_ busy, I am ill today also, so taking the time to try
> to explain problems patiently instead of firing off barely documented
> patches is far more likely to get you good results.
>
> Also you fail to actually say what the problem is, what fails, where yoru
> test fails etc.
>
> Anyway, let's try to decode (please take this as input as to how you should
> try to communicate these things):
>
>
> So we start with a VMA like this:
>
> 012345678901
> xxxxxxxxxxxx
>
> We then seal the middle, starting at offset 4:
>
> 012345678901
> xxxx****xxxx
>
> This sets the VM_SEALED flag in the middle and splits VMAs resulting in 3
> VMAs.
>
> We then attempt to unmap 4 pages from offset 2, but this fails, as
> expected.
>
> 012345678901
> xxxx****xxxx
>   |--| fail
>
> We then attempt to unmap 4 pages from offset 6, but this fails, as
> expected.
>
> 012345678901
> xxxx****xxxx
>       |--| fail
>
> At each stage we should observe 4 VMAs.
>
> Are you suggesting there is a larger unexpected split? Where? Under what
> circumstances?
>
> Let's figure out if there's a problem here _together_.
>
> On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > It appears there is a regression on the latest mm,
> > when munmap sealed memory, it can cause unexpected VMA split.
> > E.g. repro use this test.
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> > index fa74dbe4a684..0af33e13b606 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(bool seal)
> >  	REPORT_TEST_PASS();
> >  }
> >
> > +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> > +{
> > +	void *ptr;
> > +	unsigned long page_size = getpagesize();
> > +	unsigned long size = 12 * page_size;
> > +	int ret;
> > +	int prot;
> > +
> > +	setup_single_address(size, &ptr);
> > +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > +
> > +	/* seal the middle 4 page */
> > +	if (seal) {
> > +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(!ret);
> > +
> > +		size = get_vma_size(ptr, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +
> > +		size = get_vma_size(ptr +  4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +
> > +		size = get_vma_size(ptr +  8 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +	}
> > +
> > +	/* munmap 4  pages from the third page */
> > +	ret = sys_munmap(ptr + 2 * page_size, 4 * page_size);
> > +	if (seal) {
> > +		FAIL_TEST_IF_FALSE(ret);
> > +		FAIL_TEST_IF_FALSE(errno == EPERM);
> > +
> > +		size = get_vma_size(ptr, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +
> > +		size = get_vma_size(ptr +  4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +
> > +		size = get_vma_size(ptr +  8 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +	} else
> > +		FAIL_TEST_IF_FALSE(!ret);
> > +
> > +	/* munmap 4 pages from the sealed page */
> > +	ret = sys_munmap(ptr + 6 * page_size, 4 * page_size);
> > +	if (seal) {
> > +		FAIL_TEST_IF_FALSE(ret);
> > +		FAIL_TEST_IF_FALSE(errno == EPERM);
> > +
> > +		size = get_vma_size(ptr + 4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
>
> This is repeated below, presumably you mean to do size = get_vma_size(ptr,
> &prot) here?
>
> > +
> > +		size = get_vma_size(ptr +  4 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +
> > +		size = get_vma_size(ptr +  8 * page_size, &prot);
> > +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > +		FAIL_TEST_IF_FALSE(prot == 4);
> > +	} else
> > +		FAIL_TEST_IF_FALSE(!ret);
> > +
> > +	REPORT_TEST_PASS();
> > +}
> > +
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	bool test_seal = seal_support();
> > @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
> >  	test_madvise_filebacked_was_writable(false);
> >  	test_madvise_filebacked_was_writable(true);
> >
> > +	test_munmap_free_multiple_ranges_with_split(false);
> > +	test_munmap_free_multiple_ranges_with_split(true);
> > +
> >  	ksft_finished();
> >  }
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >

