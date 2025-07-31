Return-Path: <linux-kselftest+bounces-38113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77758B17511
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1787A9FFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75323099F;
	Thu, 31 Jul 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YegRVoUE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xKG4YNpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB9BA33;
	Thu, 31 Jul 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980015; cv=fail; b=XxVFLeqEOImWLPbY9ldNxib/U/ENw1nXnSarXqnwC3q/TPV1Ywm1TlV0lJ8KrPbq5EnE0ii08vZe4ZgPU2dY9Mda4A1xxIHtWG4MTnRMHHhjA4d9K7ke2wF0SDyIOpO+u+/kNPxogRTea55Cs7cWKtgQXcMJvNmDuoBWhgY1ve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980015; c=relaxed/simple;
	bh=OHeQ8ejQSwqf4LXI/6lHOS7/dwUfo9+WWB0Fb0w5oaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PR+MSBBX+l1Dt8gMv+ZDrCaqiEOsO+vJHLyRRaBJJKvVfsVXIVo7HsKiYA2jY2SevbgxvX7PO2oILHsLsxiZlO0vMVRdXUmg0erQGOVIDXlTgm4Cu9mDB5ltqOhqnFH0mfE0JtOKhBo78aXrIsW753nH0z4KTpVb4DNX9Xta5Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YegRVoUE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xKG4YNpB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEu9AE003645;
	Thu, 31 Jul 2025 16:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kh9Ftldc2727EwQcJzV3kIce2uwJxAwbTpDtwFM8MS0=; b=
	YegRVoUEoMt4bAiunBVilcnYEPMSwFdbVh9TxAOI0IswhTHnURrVUToixSZ8xBxQ
	hnhJ3Rw8FdANzDNMphP/8aAb5ami+NyyJG8+g3SADADSJgbE6C78f0KbWE8X+ElP
	9lAdOtp5j4JUh/kiVPXvllOCwf15Rp6nn7opcmHRzrOYxkARPquz6zEN03Czqgaz
	Jd4zkNp0q6DGKXxOUzSylVLfNTCpO2us/3vr4oM6ZKiFOcDrGWa7haFpD/OnmUeT
	+1SLZhVztQtpnOwI9GX3sCaeP5VEASHWfRzaW68JDXw+vRki6d5AEEl8PImSFJus
	BlgXAxRlHtrKqKLQPYpPSQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ymgk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:39:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VGL9X2010479;
	Thu, 31 Jul 2025 16:39:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcjbd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ixdx4WtXZwse5tJpjaiRW/pmy7cjgoJAe1L9Fl+BxE3nKwCLBHam7HrxdGGMiLlZ2a9Vxuxgr6/XqVH4wE9wkHLtk5oM8NKvq0eBcKSw1zVPJwG7rDimrmgJKmn1tDplBKnR8IhnOMx06+dO353eHiGxHpD4gi5Sv+Km5E+F1CgGlA9cn/VZ/cmDen00nN8dLWIujw6JGRBQoiMfROquYrU96juvDaq9SIKeZHFzfZliATq0KkZybxhWwHEQYfccHaaIJMGuxZgjTClOOJ00Pkpsl46hKvSGE2hy3nplXyx0Ik/M0tBE8AA5tzaqzBgufZHhSH6miH8WG7V/KAIB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh9Ftldc2727EwQcJzV3kIce2uwJxAwbTpDtwFM8MS0=;
 b=CNBb2Ayjb1eB7NzZI6ZCGEOn/fr1M3+trBxskbHch1o/doZY/H7kE7jbvnvPzpvGYa6KhiM3CE3L/9s9K7XwGmwPFheMtWRSPwBp+l2hOU5nuGXQ9/DTlDk1IVu65cMHwlpqBcb8BIVYdfvqUUVYZRMbIjO3YfMsgII9H23r+VyTd9Fwmh8Uav+hjh0I2iqDqOn28hq5FHkA1sZdQou2JbmsUboFAtfYOr+0Ih73PExWv85DFvkGxwWXDbPe0xe5iufdH5gsS77J9HnpT3rc04MziOQOUUV7dQkrAVM4Sx9zTCubTQQE5NI7xSIRNoT0e4wqGhh7ITKqQg5UFChfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh9Ftldc2727EwQcJzV3kIce2uwJxAwbTpDtwFM8MS0=;
 b=xKG4YNpBMCwimeeVLNya6Ui4uC6v/hxkwDwtJXdwtAEzDy0L1Dbjzx9EMtW7jHZUyFYBdumiXfriPn/y/IWxqZWHwkWsxNNFiQTMfm87AITLFF1NLkmcX2w/fyV4tSU6ibjSvWQESKHgWu63iHjY/17GPjvE2R0iXLcThcdEKU8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 16:39:42 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 16:39:42 +0000
Message-ID: <42ba379f-baaa-4803-8ebe-f7ddeab87522@oracle.com>
Date: Thu, 31 Jul 2025 12:39:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] selftests/mm: protection_keys: Fix dead code
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-3-usama.anjum@collabora.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250731160132.1795351-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: b2557a71-77ca-4171-41dd-08ddd050d969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVJTGxqTXVabEtmMTgvYzZuR0F1YWdya2R1MGZlZVE0SmVNS21hVHgwVGZr?=
 =?utf-8?B?Z1lOOW9MK09QckxMRElZS2N4UW42cGlTTUxvVWZMajJ6aTFiMWpBVTZ1Nmpk?=
 =?utf-8?B?NTZSc09TTkNMcWpocytYLzlMMGpmYjdTS09idXEwMURKVS9iMlBkRVRLQzhD?=
 =?utf-8?B?WWlrUTRvQmRiY1ptakVXNGxjdTFNYTBDenJSSFJBM0N6OWhPTms2bmNsRGM0?=
 =?utf-8?B?dlppYzhISjRxM29qWFpmRWsvQmlRaGlIM3plaFBrQWUzMStZMk5GV0piejN4?=
 =?utf-8?B?NTQ3TXNqZU43SEVGSlIxZkx2aXl4VERmZmgrZm1TSFA3NUk4cjBzSk9laUlK?=
 =?utf-8?B?aE1Ycy9hV3dKbCszZnd0cWRkRnpWaFBua3JmTjZCWlhhb2lmcStHZ3JlMkZT?=
 =?utf-8?B?Q0V2cXlvaGdaSzBqYW9kcEpQM0hWcys3b0JtVlNwdGpOZ1FPMndHVGFwR0NY?=
 =?utf-8?B?M25lSEk2NGZKcUxaVUhGbjlxK2hrVEF4SHpCTDdQTmUzWnlna0h3bXlsN2Jh?=
 =?utf-8?B?dDVIcmxBYzRVLytzMTdOWEJmWFlGSlhYQ3ZHdGQ0RllCdHZuTTRsNFlQbHk4?=
 =?utf-8?B?VXdTVWR6WmVmMzYvUkxNclpvNUJ6elk0ZjF6RGl2Z0VnRXNDdUZGM1JSekhJ?=
 =?utf-8?B?cTRwZ2Q4T3FSTE41NGRIU3BuOFAzbElDWlVXRmJhYmJrUUY4dnlpUUc5bVZ4?=
 =?utf-8?B?S2owMUd1MEh1cWsxd0NnS0Z4WGhBN1ZESjlRZ0RMMHpIdS9hSDVrZ25UNUF5?=
 =?utf-8?B?Q1g4Qm9nN2hkQnVqWXZXZjdIbHBzbjVTdTJVYTRlbXNVVjd5VURGTlBRcEVi?=
 =?utf-8?B?aERmRGdmcjNOZ09mTkhnUmJhL0VnRCtPam9EUFNpSzZSaTcyd3JGSFJtaG5l?=
 =?utf-8?B?REgvcDNidFdXdHBRbCtOUkQ5QTdPUnA5Qk92Qml2QjBmMEUzWmthQkFMdHdp?=
 =?utf-8?B?Vnhsc0VoamxiTWR1ZEJaQzdFZUE4alJQR1Z2djk2c29yZ04zcXhucGh5SkV0?=
 =?utf-8?B?ZVVtTm1OSHplYlNMRVhzYlZldEQxL1poMDZqQTVwRVlGSDVFeEdIaXhwZnFy?=
 =?utf-8?B?V1RFZGt6WkhjYkF6RGIwUEZmR3FOMFpDMTBVbGhLaGJ2RlQxeklidm5iODA0?=
 =?utf-8?B?YlhzRjl1YlI5dnZmRUNHRUp3cFpmUGpzTlVwLzcxck1Yc1k5TlQ4TmRGMmVP?=
 =?utf-8?B?U2ZUeENRbjFJRTR2S2NUUHRnSXk5TTJSazVUM01yaE9rM244RlZiSXBoQnlr?=
 =?utf-8?B?VkEyaUN1Y2NQWlV6NEhhZlVBZVdsRGhKZDQ3N3l3ejdzL2dUNTZOQ1RvNDRH?=
 =?utf-8?B?eUFhSEFheEtTM1RzWEZVZ1BicnIvMFQxL0ttdVFEcDFzblI2YUNWTDBEdy9P?=
 =?utf-8?B?VnpSVjdNYXEyZ1A3bjdWRGFDc2VSUktyNmRVNXhvTkFTZS92cVY4V1BhYVN6?=
 =?utf-8?B?eldBOHRDQmpqYXhTRE90Mis0cDFINUUrajZRT0gxUXFVYStMeDZsSmo5RGZI?=
 =?utf-8?B?SFU4NklIVmh5dGRnTVozUEF3MHM0d01ZY29xUmVGSy9DK0R1MTZlRlRjWk8z?=
 =?utf-8?B?V2trN2twMkd6VnlKZ0ZqZjA4UDJZOG1BNkprcXpPL0NxUENUQlNzUS9oZFI2?=
 =?utf-8?B?dURQdjQzSmJ4d2NUWG5DeUNKWnZQWGVqeUFhWVB5c2FXYzJJVkhTdHN5R3ZW?=
 =?utf-8?B?NFVWZ1V4UFJYTW4rTlVHaURQN284emRjQ1lWR0E5STBBYSt4QzlmUmU5c1lY?=
 =?utf-8?B?STZTV0J3dkxLNFdvSm9PanY3K3dYenQzRWR0UTNlREtiVkVIMXBoZ0Nnbmla?=
 =?utf-8?B?ZG1xNjNrQ25udjhNZDNNa1VFc2pIck9jcmU1V2F3L05IUTYrV2tjYnNNaEZH?=
 =?utf-8?B?WkhSY3JLOWhxK01YYmVlWDVUOXFnTDFGRzhSeHpwL1VUMjVuSGRPRktMQzZn?=
 =?utf-8?B?VENQWkljSDRBbkxPMkt3emU2RVV1Z2hWUzkvbERIV3k4NUtRMjJaWDZXRmNa?=
 =?utf-8?B?QVVxdVl0NHZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFvQVh1b3V6cWtVOTd1WUM3MWNqMTdUUmNiTTlJcW1zSzBxQXBTNGRhQVhP?=
 =?utf-8?B?aTJzZXA1d2o5M3cxR2N1eVRSUWVCTWhnZzYvRHdFSkEvY3ZUT0c1Z1J5UUF4?=
 =?utf-8?B?clRLRCtnQkJCbHducmppTUJpTFlXS3QwVllvei93RkhtbVUzdnBET2N4TWU4?=
 =?utf-8?B?bHBjbU9idDVGWjlUZHQ4cWR2NGo0TDBnRGcwd0U2QnFHL2Y2dHZtaGdMMGFi?=
 =?utf-8?B?Q29iZ2JJTGFPSXZvemZjK05Ea1hyVjNnakNOd29HVjhoTHdOK2pZekpxbU52?=
 =?utf-8?B?TGxaTFNNNzd1bUdtbkdaTmdYeTQwc1JBTGVEZlAvNlBrVkt2RFBncDIxb0hR?=
 =?utf-8?B?ckNpT1hlVnkxd29zN0NVRW9Qalg5dDNvWW1kZllmOWZZU0o2bXJXTTV1OURi?=
 =?utf-8?B?cGJOK3R5S2pJeHVmcnFGemlrQk1WSHZobGdWK1EwaGtsVWc5eVBLN0F0R29r?=
 =?utf-8?B?b2pXVWNyMDFOTlRndDJvQTJUVGVVb09MZDBNemh0ekZ6NjNVODhpSWpBNFRm?=
 =?utf-8?B?elBlb2VJYitmbXpWekt2NXRiV3Rud1o1MlhNUnVKNWNGcHV5aXd6SlJ2YWZk?=
 =?utf-8?B?ZE9iTmRZRFltbGUvelZFYnVvRytwdHpqSUdBS1JpYktGUXZPUWM4d2hTYlZi?=
 =?utf-8?B?bkI0c1dMdlZ0VEVxT24yUEdPcnRXWDgwRXFGeUxtS1hRTm9SdzVoRUxCUlJK?=
 =?utf-8?B?emNoZjZpd2ZhamFGb3l0SzBwNnNWeWNRRXE2YWkvS09SUnlodUVlNFl2RGFm?=
 =?utf-8?B?aTgvbTRqKzFVV29UbG1zU1d1Mk9OUVhlazdCMDVlbUV2RkN2YmFqb1UxRGNJ?=
 =?utf-8?B?N3QwZ2twTDJNL2QyOXlXc1R3SGF4RkFpeTNMdC90dVRjWXFiQmZrSEMxN2tT?=
 =?utf-8?B?RWcrcERqOHVtemFYRGdBaE9WbVRBdHdCN1NHdlYxcnc1RGJqVTBkanRTRGNR?=
 =?utf-8?B?N1J5dlE4VlRJMEV2c1NxbFdpeDhrako4VS9kdU5PM3BCUHdMc2tjRW13TE8x?=
 =?utf-8?B?b1lSNVh1OWhkdkpDeGx3ZHo1di8zQ2NrVHVZVllaTEV6dktzZDVWOHpDd1hC?=
 =?utf-8?B?KzdzOEYyWGVmZmZ1WE53Q3Y0VmZORFhrQVlNd3VvMVR2ZHVYWVgwUlN6U2xX?=
 =?utf-8?B?RGo2N3IyTis2SS9pWVkzODc3S3hNQUQzYkpabjJicWNRdkZndmw0K21oTWEv?=
 =?utf-8?B?RG8yNlZ2TUVxNkM1MGdLV2dpUysyY2NONVZLV3h4NVB2Umt0MUVVMURCTjRU?=
 =?utf-8?B?WkRCaGdTamRENUl1N3drYzB2MjN1dmxnT2ZjckQ3a3NSYXNDdnlSNDZmTTAv?=
 =?utf-8?B?dG83Rzlabk5jd3lSbHFWRUZ1SEYxVHZMMUVZQXArbllPcG9obnFMaDVXRkx6?=
 =?utf-8?B?OG0wamlIakhTbGNBUTdZc05jWDBuWmxNRkczbmNzT0VXN1pFODdZQUxmSExH?=
 =?utf-8?B?VklRYXFTNVRRbllSdXBEZ1Z3eWhlVmxkdEkwNWNmbkF6ZjlHTThlNG9hcExM?=
 =?utf-8?B?ZXpQYkI1dlB3YlBpMUZSK1Z1Qno1M2tOYUtEb2lIQlV2cWRsUzhuMCtZak0r?=
 =?utf-8?B?WHRoYWxyWEhUeVE1cjVJSVRHSU84UEgrSzB4eWxoYlNPTVByRmttZmZmN0dk?=
 =?utf-8?B?c3c4Q3N2ajVTaVhBTmtBNkQ3enBoYXJyUDUrSVlHMGVITXA5eDNOVGRyR0Yw?=
 =?utf-8?B?dmVLeEpDc0YwdEU0ejhUTnBldG94WVV5RjNma1R1M1k4QSsxMmx1ZkhJQzhW?=
 =?utf-8?B?OXhNZWpZUFBPTlVEc3FzamNuWXMzdGczU1RaUjZmdVAzTEtJTnR1blpWZDNk?=
 =?utf-8?B?anNXWWgwUHpJSGhkeWhFL0ZTMXRCRFdNK1NVRGdZQlZ3SDJXdmFHdEJid2Ja?=
 =?utf-8?B?K3o2YTBvVmptazRFaHp6YkVhWHdlZTFuWTY5UWxhejZXUDNERVdNNFVKRytv?=
 =?utf-8?B?ZlpYbTUwTC90aVB6Rk9JVXF3UUtOM0J0MzJpYkNESE50MEFkN3FpcHkyS09m?=
 =?utf-8?B?a3NYblVhS0o3K01JWWZLVmdTVDlBdnpubEZmYkZqbEFybndUalh6dlFjYWhT?=
 =?utf-8?B?RUJSNFFnZkVYQlRUa0gxc3FWNDRKczRHZ2NmUUpRMWdvMGdYTFFIWVEwQnZR?=
 =?utf-8?B?WTVOZldOcXU1Sk5GSldQay9oN2xpemRLM0pKT2xZeUZCZVFWSlE3TGJkSXor?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uTW+/aZryvRDj08B1sF+uA7E7deDohKXoRwQdJs2/Q0H+27WSE04EPXpe1nivXb10/pufEFHKjN/eL1f3oWIvOb1X+SwyuXkIm4/ZBikk13pBjZkeJIuDYD1OlN/vsgkzo2IHvbBkEA0GBUdBuXXtCjlLpH0l2CH+umhD7pwgdMD9VSl4okjbQsJ3RR6NW3SN4Cd5TIz+iD9OoV3QBPL06svWIpy5nVE/pEL+VTdfpSDVQGVVhpWYnxPSUc/cTDMYiwtOWr0Im/Pb3xvzLzyjYh4xJxaym+JZEfmcpXTNFVG8sNrHh2Kj4JV/dDc67lqYIRL075zDfhTv6VdszO3RDg2k/h90vpJNLT/bkbWeoN1mDVHLQK8xC4grIuPNqW8OyEc/BvTpRNA9ZdCf0/4SXCjMaCEeDZrIIIUrTtqJdTauntGdqhKFVUQQ+yumotU+SxEth7l4ht2crHDrf3uGx6CMZbR3BThbIZOyIKrltVDHp53dsWCuw9Jo2TQRIFn8bhm4uNVHFDll6MJB0M0AqWgBLVvtw1/5NTKxs4xi0WJlba9r6FXM2+ujrFdyc3bzvexR8zmLPUwtcC6SIeGihml73v0iddXxTaC/0EDSpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2557a71-77ca-4171-41dd-08ddd050d969
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:39:42.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpgoiHF4Oiq40RxC7I34aBG/qXSVmwO4o9ItELlxBfgYIaw/fRDhsWENLvqTMzO/KAF8feHMxRjPA7ZNPXoHbLSaKynCJ6xgnr+MERG8Jfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310115
X-Proofpoint-GUID: RAjJGMx4379NbIziqb3jEhXLTiYGa7N_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDExNSBTYWx0ZWRfX7yn1AQjZ8MD5
 EeISgn/zx4Tv/x3mno12YILGWKnz4efNtsHQu+RUEjpeF/4n9X804ryqQxS/+YCPgtiRN2UpXTt
 j5zoM6c1sILAlcirLlzg/JI+B3VG4X5nPkcjjcs083N/tJ3buTRP+e0Or3yf4JEddMBvdLxpUyB
 Ksia4qUOMYGxSORdGPfxshPhF1mAStkFmFEi7XVhHob2DZy9ADcVeWW7h5sXTBduMseYB+1KyYa
 69ziIXuwEHLJyjh4Ctwd2Qnp0HJYpY/40n2vVqSCsrlnTcnwlIIDyQeKNLFb+rmS2nXucTOpnz4
 cXQ1lxyU7vIsnLrHvVzkvD2f35alomQw7a2Vz8HiFXwjlzfdxc6xPf5+bBcfH1nhLYJyFYKHx9p
 xHbqAZqXW14sIJZeDEWAYHEXCMMSzkb+yMwiodyqGDeEsHnDpywyd5tCvBwW1ZYGRXq1sqkh
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688b9c51 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QX4gbG5DAAAA:8 a=yPCof4ZbAAAA:8
 a=Xh_rt_91qh1tqCxl9g4A:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 cc=ntf
 awl=host:13604
X-Proofpoint-ORIG-GUID: RAjJGMx4379NbIziqb3jEhXLTiYGa7N_

On 7/31/25 12:01 PM, Muhammad Usama Anjum wrote:
> The while loop doesn't execute and following warning gets generated:
> 
> protection_keys.c:561:15: warning: code will never be executed
> [-Wunreachable-code]
>                  int rpkey = alloc_random_pkey();
> 
> Let's enable the while loop such that it gets executed nr_iterations
> times. Simplify the code a bit as well.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   tools/testing/selftests/mm/protection_keys.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> index 23ebec367015f..6281d4c61b50e 100644
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -557,13 +557,11 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
>   	int nr_iterations = random() % 100;
>   	int ret;
>   
> -	while (0) {
> +	while (nr_iterations-- >= 0) {
>   		int rpkey = alloc_random_pkey();
>   		ret = sys_mprotect_pkey(ptr, size, orig_prot, pkey);
>   		dprintf1("sys_mprotect_pkey(%p, %zx, prot=0x%lx, pkey=%ld) ret: %d\n",
>   				ptr, size, orig_prot, pkey, ret);
> -		if (nr_iterations-- < 0)
> -			break;
>   
>   		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016llx"
>   			" shadow: 0x%016llx\n",


