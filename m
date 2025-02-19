Return-Path: <linux-kselftest+bounces-26950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC7BA3B89A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889F43BC8D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76E1DF991;
	Wed, 19 Feb 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZbL2Zey8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CbC8DZQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD117A2FE;
	Wed, 19 Feb 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956527; cv=fail; b=XDnGxln6XTX43XOvnWO8UQkDwqxKJAGT4i8v+KinCkoyQPFeQgBkM6TIQR9lI37PMsYFGGGtvHNQGl4sRxdYyBNvwI0klRFT65knDwD1QFOMUIWG1BBZQ3x0aEVe1DBkOVyvrPzocr76SX1kjrYbtuhqrCIRXpIRZdIzWrdv9xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956527; c=relaxed/simple;
	bh=qNIfhghCSDQnVNu4KZOMn88fxYT+dYtLbPq8brYUaFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ORy7lzGbVmHAoUUC33Yd7alTkmu1dN0OpfRcS3VqFZUTMu3tJytMgfwglYkJFVVTocsXpBqpNIwo67GDw1Jd6JZ8Cx3TBNdXtf+EQ9tctunE9434hoUGmqmqbAZolaa2YhwZZGSA3s7ihrd31rkoJ8rZCjUlCRC+7x3tD5TQAoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZbL2Zey8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CbC8DZQZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1tZsi027285;
	Wed, 19 Feb 2025 09:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mV5zAckuXp8AK+uswzbPvsTP+HjIkAB/+bHSHQ6nwXY=; b=
	ZbL2Zey8TEAznoULcX/dI/meUe10HoJ0LxlikcEtqJnmvNgQtcBa+krTD8hE+FmR
	roIUjMdDo2R1e3yqayvTA7RmvpRTz8xXRiy3Ww9aFWphVowJ4fJKNK0yjBfQ7FTT
	pnCu0Ij594X7bOYPm06Wn5V6LFt0En8nXukr2P+lX4AeGeIn+o3bDTCzomu63zgo
	raaoXjKo4tlXqY8pDOykaRMADwFsLDOkQMDWaEXoDtaUFaj84Czxw26eSQFk09ws
	5hqECGZOxMq2bhfcnh3VZmzV3WLR0dC45hR2JzthWLLJ45pEkgvbQ9hsD+/RUR2p
	QGjC2RI5xOQGTNGcUh5eTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yh707-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:15:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7o5sB026248;
	Wed, 19 Feb 2025 09:15:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0snprxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:15:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udCTmknGswtDKTh3tlisdu8x68FBixgDVpGWW/8JxwU6/PV9qXMGACftWOExNn1TWOxzS3ZOR5z34mA1PAnQIoGgQ8uCqrfhULGnSPmvF3RJTJvZkHW02J4xWXgTDW5KegNGwssQiUG/nm8LuZbGAqo+aPUPkCW1wsaepATnds2BrMoRTo2PFKm89fzAwNNj6F0HksiUJ4EZqy7YJfpcKj/tPxkUDPs1Tw5DQveinMyRCTQ1FyGF0seC3t8TPs6KZHAaYl879GzwOjA4Mz7wIetz9DP/F9KEgrUjtUTN2h6wt9d4i7HVAWzqcizaTZ8TWjKFOLBgjleMJs2DElNNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV5zAckuXp8AK+uswzbPvsTP+HjIkAB/+bHSHQ6nwXY=;
 b=Y+PFiljIeR0XOg8fJNW1GnurjLm8g8Suwvu5cM5EDuOYDCqmvwaTEwvG3a2rKiDNeH57gKPdnQ0ljYnD9wqCZSFjUGv9DODQb7qf72zkmjOiKbldlWaBspunGzKefKDqQrN0ElGu7O2hYyq/l3j4izDbB0vLtEfktd0UxTBWIn/WEMHs87lwmpEx2l/weAhvLnydgZg88p5fn0LiBP6EbUu+CoDajegOkFIklILRfyqLzrPA1gd6nqyAmZSBHc8hNiCS/Hso4JIpSGv1603kg4QRMP/z4mzfQ6DxNXzJ7JHmhHzago24GEmJ7UQun0UKzx/uWbO2MgrL+t/wC9IuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV5zAckuXp8AK+uswzbPvsTP+HjIkAB/+bHSHQ6nwXY=;
 b=CbC8DZQZB9fbWdG2TzcwWTTr3gtElnaNk7ytVy7x5ORPugDth1rSbHGPl4+vGsKWhOduSWIXMCRhAZFzP8N1hySqXhudypeXSzYGm2y7w2baYVLiLMF3tTRyGChG3XtXjBoBZdyjq18fm/hvm/ZYFPiao1oRrFhwleaZw8JC+/8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB8000.namprd10.prod.outlook.com (2603:10b6:208:4f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 09:15:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:15:03 +0000
Date: Wed, 19 Feb 2025 09:15:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <be3dd6e7-398e-458b-b36e-2eda4a703e10@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <CAC_TJvfPNkJDWnG81GnJcFeMLYzN8=uM-oTrK6FKT7tD=E4TQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvfPNkJDWnG81GnJcFeMLYzN8=uM-oTrK6FKT7tD=E4TQg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 16371911-14e2-4711-8fa9-08dd50c5e4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2dXeFc1QzljQkwza292N3pMM2JudnJQWWhwamlKS1YvOHVkRWxEMHRrTGtN?=
 =?utf-8?B?dEZOalNaTUUxc1oraUxKd3dRRExsNCttd2JtNnpiMVdHeFNvUDY5cU0xeTdu?=
 =?utf-8?B?Y0VIMk1VcFpxT00wdCsrdXdoNTAzWXRMT1V6b3dPeElCWEo1TkU1ZTVpQW11?=
 =?utf-8?B?Q0NtZUN3R3hwaFVlWnJyVmxMN0hKTXZyRDhkTGM1U3pPWnIrOUtHdTFWL0dq?=
 =?utf-8?B?TmtqUGYxUlJjZ2VyVCt2Tzd3R2ZCbHFIeVYzeEVCbXJXU3V0c1JIRVMwSzJN?=
 =?utf-8?B?OEJJQzFUcDI2a1I1b3BMajlFd09nQnRmRkRGMkVHdTVwMklNWWZmeUhBbUpT?=
 =?utf-8?B?TEV4SU5WRCs0MDhyWnNkNzZVTE82dk9waDdTazFBaGhjcFZXbnBlTWJ3a3g5?=
 =?utf-8?B?ejRpcHFkbFlmdGNKaitRbmNHME9DQnZYNDJpb3NlQllnOVZ3cTIyVEhzNElW?=
 =?utf-8?B?T2RpNEtKSUk0YTM1RnU0dlEvSXpya1psemZ6RzUrMSttYUhFeVRwcnV0K1hM?=
 =?utf-8?B?RUdqLzc0VVgwMjlyc2JRYXdKRmVTbHo4cHQ1VmJqK0w1VnFOWC8ybHV0eVFp?=
 =?utf-8?B?WWV2WlZRZnZvMGd2UjZQQkpnZjhkYW5DY2NScitXbUc4d0ZTejA2TTVFS0t6?=
 =?utf-8?B?TWpxZFdCdU1YbkJsZlZoWk9BejBtbVZILytWbXplQWpCc29PTjhTRmZMTG9F?=
 =?utf-8?B?dFc4NkU0RmkzRk1MOHVGeFRyVUFqeWEwV2NXOHdVUFJnV0pPL2xBOUVOcnB3?=
 =?utf-8?B?bjlzVW81ZzVNR3JkSEt5cjBwK205SzlnVjJ0eThGeEFNR2FMckpuUURiVjE1?=
 =?utf-8?B?ZVA2TWI2VjV1Z1pCU1o2Q0hPV0kyVXpxczVmVzB6NFNoMTdseGhHWXF4V3ZS?=
 =?utf-8?B?dnErMnprRGNMMlBxR0htaDZhem9iL1lOSzJ3dmNpc2x0WjRLWWdvWUlqaXFS?=
 =?utf-8?B?OFhJcVcxRXNPQmFWMTl6MWFWdlNzVzJ6NUJETjFhUzVQR0pCSUFjTUVzbnVR?=
 =?utf-8?B?aFJMZFZTT1daYWVmMUMvU2ZQc0tPaDNvSVhPdXZQMW0vaE81NGk5TDhQeFZk?=
 =?utf-8?B?U1MwbTB1cytvYk1lcjhOVFV3Rkd1Sm5sVS8wWTFwYy9JREptM2VpUlVxUUNO?=
 =?utf-8?B?U2pYTG1Iems2S2ZmYjhuU1ZsZ0F3OGx3SkVDekdHU3lnY1ZXWGJIZ0FZOVRo?=
 =?utf-8?B?MUQ0T3Y3NnF6bnN3U09SdEFFSEtlNnFGSmZuTW5xMHg1WXNNQjJIT21hWUhp?=
 =?utf-8?B?V29ieGxTMWVOOHIvbDVadWg0QmREY2pLTC9ZTHh4bS9CMk9tbGV3dndGMDUv?=
 =?utf-8?B?NWx1dkszNmkrRmtiSzNYL3RFdGxBWU5BSDlMQjdwQXg0R0x3RitlWlV4QjRh?=
 =?utf-8?B?NWIyOGg3S2dYWFcvdEhSaDFvdHBtSUFCdXpNVkVabTlSUTVzcGxTRG9VeDNO?=
 =?utf-8?B?b0IwenVTM2JQeFd1dVZESlM2b2dEb1NMQzBKbE9sV1ZnUjBPUFJrQ2ZReWl0?=
 =?utf-8?B?MnQwdUd1SXZDYkg0akVXaWM4WS84anFFc043dEZmY2tyN09yUWJqdXdoQUJS?=
 =?utf-8?B?c3B5VWRhYUtkTWpNa2JoRW1yVTNHTm1BY1NOUU0rRmUrWmNVR3NKai9QdEEx?=
 =?utf-8?B?OFd1NEF3OUEvdmtpZGVid0xrVi9ndHVuaXBTbFVyaEdHSHBHbGxqVkxUbjFV?=
 =?utf-8?B?R3c5N0dFUFhGdTV5bUYxN3FDUmsrczVYRGEwY2VoN2hQaTROWGtsRytMMTZq?=
 =?utf-8?B?c3FUN1Q2VWsxbUtUdUFpWmdlMlZpYTRRRGt6YS9CTVNEejh4MzdVSmJSRnJO?=
 =?utf-8?B?R25SWWZRaStDOEhTZ2VOY29GM3Nud2IyRkRrODcxWG9OMXVobkFBdHBRalgy?=
 =?utf-8?Q?ddk8Cb2HHFSSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzJPYXZQZ1dnZitPYzEwRW9oUXowK3NTUDRmdHBCYnVkcWl0dU1iY3B6YVUx?=
 =?utf-8?B?UW5CVUhmWmUvY1UzWStlWTJWN2ZQRWFlOWtML1o0Y2hwVGZHbG9xNFFpTFhh?=
 =?utf-8?B?SUw4SHNyeGxMREVGT0NFaXh0cWZWSW1obld2c2tPYTd0bGlRdTBsMW5FbC9t?=
 =?utf-8?B?cFVKRVNUaXNZa0NLMWNMV0JWMW5DWitobWtYL1hPT080SlpDQ21FQnRyY2dw?=
 =?utf-8?B?aDBuV2UyMUFMNlVMV1p3b1U0SjRNcklRU1R3RjZWUHorY1BIQ2NhNGVZaDcw?=
 =?utf-8?B?a3RGSHVwVTRYd3MvY25BMmxlbm1UbDZFdndCZzhSOWhBRm1iOUZXNmI1Z01x?=
 =?utf-8?B?c1pmYkhCd0hCck5nazhqekRyNHM2MmJoNkl2Tk9zcVhteTBvaC9RdUd5SWNE?=
 =?utf-8?B?Q203cmF2MVJ1Y2N5WmE2S04ydkxrc3ZVenFFYVdKWFlTOWpFdE1ONFVxeWRO?=
 =?utf-8?B?WFVlWGN3WG1BbkNOTmdGWXV4MkxpaFZiYXY2SXZ0TENCZk9sK2dWaUVmQ1dr?=
 =?utf-8?B?RkFVUzNGSkZzWENBUGtSbVVTVEVIRzZsbWpCOGozSk9Xc3ovVXY4OVZseWlY?=
 =?utf-8?B?NjdSSE5KQjdmSThFNkduUkV2cHpxZ3VoS203YjZrS1BVOVlvSkkrWU83blBC?=
 =?utf-8?B?WTU5SVAxZnJJdTd3ZmJKdnZDQjEyUkxFR2hiY2pLWmtYNjd5QlZZNWpOeTZk?=
 =?utf-8?B?QW1Xd1owbXF1SExXSUhWSW9aTysrR29lWWRFTWVkYWxWcUZaVTNFTXZRS09E?=
 =?utf-8?B?Z1NMb0MxbUhKejBDNjdNU3luMVJVWDdCTkF5RmcrYm1zeXJsSkJ2aElCWkow?=
 =?utf-8?B?anVKQ1JGaXEzWEwyekYxdWorZ05IWnFIMU9lNmM0K2tjM3BKK3Y1YjJNSFRh?=
 =?utf-8?B?OU0xRlJDOUNlblY4UkxvcytKNlFKd3o3ZSszdWkyM3ZlY2FvMTdtRUtIQ09C?=
 =?utf-8?B?U3VCZnNCZFZzb3dCSXZ2TERUUkhiV2l6UzJiYTgvQU5oNHBieW5Kc29YTWky?=
 =?utf-8?B?c0JLZ1BmRHNJQ0NYTnM3U2cvdVZ2WXdYVkYycW1MWmwzSW5wREwxWFV1UVAw?=
 =?utf-8?B?V1FPRVc5SlhrMVcyM3ltaW5Jd0NYYXBiNHIrL0IxYSt5WXc3d0lVOHV3cWU5?=
 =?utf-8?B?ZUhCa1NidmJPQlhwczBybndrbHplSDNCcEN5YTlnS2EyN3JiMmh0UHBIWlZN?=
 =?utf-8?B?SUV0dzlxbUk2MHE3dDJ1Qmx2MUJtODVEdDVqaTNmdEhtTEdxMEJxUVhwVlZW?=
 =?utf-8?B?ejlHc05mbGVUcThGQlZmN1BZb2pnQ2pZUCtQTDJQQlBzQ3RhTVh4MDFzSVQz?=
 =?utf-8?B?aHJSME5mNk44Wlp4anRUc0YwOXl0UllyK1hrOEZpSXIxVDMxalRQaS9nQXRH?=
 =?utf-8?B?WmJYbXluTjFOTUczUnk1Vy9FTCtwSmRpbTRVVWM3NTU1YjcrMG16YmQrVElM?=
 =?utf-8?B?cnJoRE1yQloyRFlENUFJbHVjNjBhYzZNVGl4YmlyekdFek1NdFZXS255QmQ0?=
 =?utf-8?B?RnFJTU9HTllERUQybXhGenZwb2p3M1dHQU5qTG1YRmI3S1E5Mkx6SjRSak9k?=
 =?utf-8?B?UDZSZmJjQjVmTDNZZWd3WnozOGQzQ0pISnQrNDFxazFmcC8xTXhJY0hGZldN?=
 =?utf-8?B?SGF4YlNLKzd1TzFRMFRHZDB5OGRDRGd1OVlHZ3o0NnpPb1ArUlM2UXc4UGVx?=
 =?utf-8?B?cmtYdVVUc1RrZExhNFcwdkRYY01Xeml3anFGck5PaVFKRVdKWjVOVWZKK3l2?=
 =?utf-8?B?QjJiK1Y5QjBVeE1TNlk4cUNZRkFxT2pGLzExaGhMUU9KTS95ZkpYZDYreSta?=
 =?utf-8?B?OGtZclRVM09PckZraEhRN05sUjFONlJWcE1MRkJ4VjlXcmJFeWZ6dWY2UjJ6?=
 =?utf-8?B?dXhUWmpqT0xubmpUaS9yRnNxMFdKMWdRL2VSdUN5cmNibEVqTHplV0o4STRi?=
 =?utf-8?B?bVhHd2ZTcXNvQjJiNjhseUpTOTdTMGpxd1JoKzhlSGtqd3U4YnVJY2E0dkVq?=
 =?utf-8?B?Z0l3Ky82bjlqeDUyN2xvY2ZSVjNnSk5vUDd0RDlQN01mcUQ0YWNSaWI3Y3lY?=
 =?utf-8?B?ZTlVTkFNamUrSHM3VHArMVVSUDVvd01rZ1lQMExvWUNOenZoSk53V2R2bHdn?=
 =?utf-8?B?S2hUOEY2TFhib0pTalJCVG90TFhnRW5UeVhJR0l6bUIybVJYckhOS2kwTUpJ?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mz/H/BfmDvq7LYNRJ0nbHFUCLTSG+FOQPsMBODNTsZ23XU9BWMep3HzJeVOPlZb4fzRt98Sh1NDzRsClmIyVMHsGXoG/g4QVYuyh8ReYjsyOJ9mqVuIK8P7dBno5NUDKpvb3vGRI4Di9+RC4DL3h5kKNo8qfQ9Da4IrJmTTmyt9XxtEDD+1PtuygwLif1sippFHW7bPjA8ZVmvzTH57QF5X68F1IdzPWlmx2aOq1AbJu/Xgn9zc4j1M45BfYy9QkQjEmX5nTjOXyTZ56gv8JuH74N86gyt9QqUwHPV7kbrzeocxGvwWhtq3Z4e7SD1L2uQQMN8S9RXeVWai1fMDPhTXnyaDQIcyJs/w4Nud4C/qWn3XOhr3upVL95e1nvgxgbL8Q1G83MVo2xY4xu1USnb+kzefRmC50VkUVM1HafgUGufuqloYA8yJOf6QfKmNljE+/6ERFTXaR8c8FnEwSAYHgelH7pry/0J2wtWx7ki0ZxxWeLJv4J0c1zdgVwHUNeLpFIE6+A/2JJ0hf7VF9SMprqRZ9e1PlEX3AC9ic26Yl9pKQqB9/dE98/zo95wHMwRedqxX+jq4oG32XnPOGvwRVwZ0FZmfjSwVj04MudMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16371911-14e2-4711-8fa9-08dd50c5e4a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:15:03.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izEmWhcMroXJFNDIsjSL30PrlQsH7R5CzItZcH9tlsSF54tmZb8EsuwDPHz6brCnA8eDVbMDzCHIZGGIX1UO3fTi1uDyfHOXQuwqdXNjmFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190073
X-Proofpoint-ORIG-GUID: WX7McF9XITB-DegAFcOE3r-obyss0Gve
X-Proofpoint-GUID: WX7McF9XITB-DegAFcOE3r-obyss0Gve

On Wed, Feb 19, 2025 at 12:35:12AM -0800, Kalesh Singh wrote:
> On Wed, Feb 19, 2025 at 12:25 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 10:18 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > The guard regions feature was initially implemented to support anonymous
> > > mappings only, excluding shmem.
> > >
> > > This was done such as to introduce the feature carefully and incrementally
> > > and to be conservative when considering the various caveats and corner
> > > cases that are applicable to file-backed mappings but not to anonymous
> > > ones.
> > >
> > > Now this feature has landed in 6.13, it is time to revisit this and to
> > > extend this functionality to file-backed and shmem mappings.
> > >
> > > In order to make this maximally useful, and since one may map file-backed
> > > mappings read-only (for instance ELF images), we also remove the
> > > restriction on read-only mappings and permit the establishment of guard
> > > regions in any non-hugetlb, non-mlock()'d mapping.
> >
> > Hi Lorenzo,
> >
> > Thank you for your work on this.
> >
> > Have we thought about how guard regions are represented in /proc/*/[s]maps?
> >
> > In the field, I've found that many applications read the ranges from
> > /proc/self/[s]maps to determine what they can access (usually related
> > to obfuscation techniques). If they don't know of the guard regions it
> > would cause them to crash; I think that we'll need similar entries to
> > PROT_NONE (---p) for these, and generally to maintain consistency
> > between the behavior and what is being said from /proc/*/[s]maps.
>
> To clarify why the applications may not be aware of their guard
> regions -- in the case of the ELF mappings these PROT_NONE (guard
> regions) would be installed by the dynamic loader; or may be inherited
> from the parent (zygote in Android's case).

I'm still really confused as to how you propose to use guard regions in
this scenario. If it's trying to 'clone' some set of mappings somehow then
guard regions are just not compatible with your use case at all.

I'm not sure what would be honestly... you maybe could find a way to modify
the loader to interpret PROT_NONE mappings as a cue to use guard regions
instead if that worked?

You can't both not have a VMA (something that describes mapping with common
attributes) and have page table state along with somehow having something
that describes a mapping with said page table state :)

It's a sort of non-such-beast.

Everything is a trade-off, guard regions provide the option to retain state
regarding faulting behaviour in page tables rather the VMAs, entirely
opt-in and at the behest of the user.

Now extended to file-backed and shmem!

While I hoped it would help your scenario based on your talk at LPC, this
is very clearly an important change for guard regions (for shmem most
notably) and removes an important limitation and exposes the possibility of
using it for things such as ELF mappings for those who don't also require
specific [s]maps state (which explicitly NEEDS VMA metadata state).

I suspect you can find a way of making this work in your scenario
though.

An alternative if you're willing to wait for page table state to be
acquired is to expose a new /proc/$pid/... endpoint that explicitly outputs
guard regions.

Would this solve your problem...? I had always considered implementing this
if there was a demand.

Maybe /proc/$pid/gmaps? :P 'g' could mean guard regions or... ;)

>
> >
> > -- Kalesh
> >
> > >
> > > It is permissible to permit the establishment of guard regions in read-only
> > > mappings because the guard regions only reduce access to the mapping, and
> > > when removed simply reinstate the existing attributes of the underlying
> > > VMA, meaning no access violations can occur.
> > >
> > > While the change in kernel code introduced in this series is small, the
> > > majority of the effort here is spent in extending the testing to assert
> > > that the feature works correctly across numerous file-backed mapping
> > > scenarios.
> > >
> > > Every single guard region self-test performed against anonymous memory
> > > (which is relevant and not anon-only) has now been updated to also be
> > > performed against shmem and a mapping of a file in the working directory.
> > >
> > > This confirms that all cases also function correctly for file-backed guard
> > > regions.
> > >
> > > In addition a number of other tests are added for specific file-backed
> > > mapping scenarios.
> > >
> > > There are a number of other concerns that one might have with regard to
> > > guard regions, addressed below:
> > >
> > > Readahead
> > > ~~~~~~~~~
> > >
> > > Readahead is a process through which the page cache is populated on the
> > > assumption that sequential reads will occur, thus amortising I/O and,
> > > through a clever use of the PG_readahead folio flag establishing during
> > > major fault and checked upon minor fault, provides for asynchronous I/O to
> > > occur as dat is processed, reducing I/O stalls as data is faulted in.
> > >
> > > Guard regions do not alter this mechanism which operations at the folio and
> > > fault level, but do of course prevent the faulting of folios that would
> > > otherwise be mapped.
> > >
> > > In the instance of a major fault prior to a guard region, synchronous
> > > readahead will occur including populating folios in the page cache which
> > > the guard regions will, in the case of the mapping in question, prevent
> > > access to.
> > >
> > > In addition, if PG_readahead is placed in a folio that is now inaccessible,
> > > this will prevent asynchronous readahead from occurring as it would
> > > otherwise do.
> > >
> > > However, there are mechanisms for heuristically resetting this within
> > > readahead regardless, which will 'recover' correct readahead behaviour.
> > >
> > > Readahead presumes sequential data access, the presence of a guard region
> > > clearly indicates that, at least in the guard region, no such sequential
> > > access will occur, as it cannot occur there.
> > >
> > > So this should have very little impact on any real workload. The far more
> > > important point is as to whether readahead causes incorrect or
> > > inappropriate mapping of ranges disallowed by the presence of guard
> > > regions - this is not the case, as readahead does not 'pre-fault' memory in
> > > this fashion.
> > >
> > > At any rate, any mechanism which would attempt to do so would hit the usual
> > > page fault paths, which correctly handle PTE markers as with anonymous
> > > mappings.
> > >
> > > Fault-Around
> > > ~~~~~~~~~~~~
> > >
> > > The fault-around logic, in a similar vein to readahead, attempts to improve
> > > efficiency with regard to file-backed memory mappings, however it differs
> > > in that it does not try to fetch folios into the page cache that are about
> > > to be accessed, but rather pre-maps a range of folios around the faulting
> > > address.
> > >
> > > Guard regions making use of PTE markers makes this relatively trivial, as
> > > this case is already handled - see filemap_map_folio_range() and
> > > filemap_map_order0_folio() - in both instances, the solution is to simply
> > > keep the established page table mappings and let the fault handler take
> > > care of PTE markers, as per the comment:
> > >
> > >         /*
> > >          * NOTE: If there're PTE markers, we'll leave them to be
> > >          * handled in the specific fault path, and it'll prohibit
> > >          * the fault-around logic.
> > >          */
> > >
> > > This works, as establishing guard regions results in page table mappings
> > > with PTE markers, and clearing them removes them.
> > >
> > > Truncation
> > > ~~~~~~~~~~
> > >
> > > File truncation will not eliminate existing guard regions, as the
> > > truncation operation will ultimately zap the range via
> > > unmap_mapping_range(), which specifically excludes PTE markers.
> > >
> > > Zapping
> > > ~~~~~~~
> > >
> > > Zapping is, as with anonymous mappings, handled by zap_nonpresent_ptes(),
> > > which specifically deals with guard entries, leaving them intact except in
> > > instances such as process teardown or munmap() where they need to be
> > > removed.
> > >
> > > Reclaim
> > > ~~~~~~~
> > >
> > > When reclaim is performed on file-backed folios, it ultimately invokes
> > > try_to_unmap_one() via the rmap. If the folio is non-large, then map_pte()
> > > will ultimately abort the operation for the guard region mapping. If large,
> > > then check_pte() will determine that this is a non-device private
> > > entry/device-exclusive entry 'swap' PTE and thus abort the operation in
> > > that instance.
> > >
> > > Therefore, no odd things happen in the instance of reclaim being attempted
> > > upon a file-backed guard region.
> > >
> > > Hole Punching
> > > ~~~~~~~~~~~~~
> > >
> > > This updates the page cache and ultimately invokes unmap_mapping_range(),
> > > which explicitly leaves PTE markers in place.
> > >
> > > Because the establishment of guard regions zapped any existing mappings to
> > > file-backed folios, once the guard regions are removed then the
> > > hole-punched region will be faulted in as usual and everything will behave
> > > as expected.
> > >
> > > Lorenzo Stoakes (4):
> > >   mm: allow guard regions in file-backed and read-only mappings
> > >   selftests/mm: rename guard-pages to guard-regions
> > >   tools/selftests: expand all guard region tests to file-backed
> > >   tools/selftests: add file/shmem-backed mapping guard region tests
> > >
> > >  mm/madvise.c                                  |   8 +-
> > >  tools/testing/selftests/mm/.gitignore         |   2 +-
> > >  tools/testing/selftests/mm/Makefile           |   2 +-
> > >  .../mm/{guard-pages.c => guard-regions.c}     | 921 ++++++++++++++++--
> > >  4 files changed, 821 insertions(+), 112 deletions(-)
> > >  rename tools/testing/selftests/mm/{guard-pages.c => guard-regions.c} (58%)
> > >
> > > --
> > > 2.48.1

