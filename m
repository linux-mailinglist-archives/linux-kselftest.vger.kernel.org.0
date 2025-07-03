Return-Path: <linux-kselftest+bounces-36404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F60AF6CB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295381C41203
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A5298CBC;
	Thu,  3 Jul 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KweBcNeK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KweBcNeK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E1295523;
	Thu,  3 Jul 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530911; cv=fail; b=WmDl/Mq1Q8bdtfZZWG5b9n6zztiPx5MOHtdr55dUs+M1dmrGxXDfh5GFvnhRu2zh127ExdDUQoU8ZiVaPTZyCyp6g2obTIazlQ0MCYpVkStEu7NlADVvNhoJUQBoEcXIaEZyRKZgzUq9QtXI6Ap8bjvwZRs4S8if3FiXmyrNytY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530911; c=relaxed/simple;
	bh=UuJi/0kPEySdS/YVxQyAntAs3txgqH/Apo7EvjVtjmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4aKdp8IgXLwj9AnXs3EknstIQOAYGuONd/RjuaC80OcMmGM+SboPe8fO3SJhsbXTGoGzTueRNf6BtgA3IGT5PrO8GEXizgPiOE6bIS+Xlft5s+T17F9YUoZG+H/hNhrFsTvr3an3+ys/KtDEAA39yuQ+NW8IIAR3aRrPY5j4Pc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KweBcNeK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KweBcNeK; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uZb946F9WluF8/PczYT+LBAgrt3sz6FxOASVkZkTxUEjeFADrF0A07z9+9/grodeGWQch5stl937vQbDoZMa/PvV0wtkypiEBUG4btQht8uSq0booWbFOUafjiJPrXe+f2U5AdIEwpwNlJgvFASpr+Pmdt1aziXfSA7NTYhiWojw9fpdBeh1bUuybDRnhrzuwddwFi5a32Y98dWj8wtTwVq+rYIK0jpMx1K8Ax/8lgGr5ehovmD5UOI1aSwtdsgizyGsBV+UrHVFU6c64flTm59zNocYACaaIoeNDUw7b6VjTmxM8oJzCzJn6XBogt8UvZmiru4Tt5Ci+0+gGQQYgA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuJi/0kPEySdS/YVxQyAntAs3txgqH/Apo7EvjVtjmY=;
 b=DUu3Adw6zUOtEkrcsMprhbAmnUDq7cPemGGGqzRBFxv1mYuoAzDfLuyCYkxGcIhddtX2vHeYWdVFkgcpiyq2B3Krdd8aniEnApT6RO5rL1Ah5ZyxuSL+9llW+kx+ra4PG+qyPorMVZYbjEshfx0H9IYH2VC0ZAZoilF8AYd9z8nehJQwCamXdNeF2bzzq2SvvxJQP0KAua4breGPLIiPykvfaRgxMontCd5hXV0xqrRSUxLWuK7n2AVdJyrqTbVDfdCzlnA96EZXoX04sPoCTv/Z87OgVx8mAf0T/LREQ1UunL3AOUMvL4mKIetsOCg3f2C/h4SVkWA+EWCudx4CIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuJi/0kPEySdS/YVxQyAntAs3txgqH/Apo7EvjVtjmY=;
 b=KweBcNeKKU4tQ8eRJNYlvHpsDgo4/qhXSUTx3Ojn5Tb8djmy6crZc05mdXSQcXVovwrD/p9hwpLXo1wiFA8LeVQ+FKnrtajb5g1VbzLc4AOPa5soqcHRfV7wu833MzSqzv/zAASU7CFzj7dX84XgbHO118/R/xR9iqHb7YKN2iA=
Received: from DU7P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::30)
 by DU0PR08MB9420.eurprd08.prod.outlook.com (2603:10a6:10:423::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:21:45 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::65) by DU7P251CA0026.outlook.office365.com
 (2603:10a6:10:551::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 08:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Thu, 3 Jul 2025 08:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LabAs4v5tWSvD1tZRoV+NX/epyECQdoV1ZMIQSGDauCf6R8/aqIJXdeSSo6pXL1oaym+2lSEi29MErHyd/Q8uIO7kcrqsNoyCnEe2/A2YjYI6rjVh4YIRa+wEWvU+1uULREiAhyVKi/A5mIxZPmqvjr4zo1g/KcgmpqXfmCosz6BosK+pm/L2FdrF8bR1Hiefx7dC1HmQ2m2gA6ljo/+xuH1jBkDjVW/a12zMncOvhP4Tkl/QDR/al97ffRyjNQpmRsfGdJcBYLrwfNcOa1TXL9E2HKu5ESVMXdBbZTIs4ML58xtEZ1nBlQMrqooyTfWUzmThofdR6s6U+h0cRMnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuJi/0kPEySdS/YVxQyAntAs3txgqH/Apo7EvjVtjmY=;
 b=iVS/yiUl8ArjLD9108pjmSa3Wj0TE9tZZ+u4PpugTwWktVXu5XVeDBDJ2SXYUUqV3fvFIQIVtFqhSq/GoVFLzEgLr066xC+SOygZvdZeinmGFY0sD74n1zFw2RIl3kdlsxGdR/D4U2QTJxqZ98ZnMbvfNlGkkdt7eXWjD2vloME9ubdToQDeZ7z29RiMshfXEJoY/ryoI+bytzeNkJ/FvhX0seD2cVDymSX5BXKRMxx04X/NWJi4Fm7+0uIrdVKOXrus8/lZt3zlSEd9VZSza+whQCuxSjDbIupd6D67Raz2Yhz6dNpRFcPBnDUg6IjbwqegdRGLtMFLTrQp54m3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuJi/0kPEySdS/YVxQyAntAs3txgqH/Apo7EvjVtjmY=;
 b=KweBcNeKKU4tQ8eRJNYlvHpsDgo4/qhXSUTx3Ojn5Tb8djmy6crZc05mdXSQcXVovwrD/p9hwpLXo1wiFA8LeVQ+FKnrtajb5g1VbzLc4AOPa5soqcHRfV7wu833MzSqzv/zAASU7CFzj7dX84XgbHO118/R/xR9iqHb7YKN2iA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB8301.eurprd08.prod.outlook.com (2603:10a6:10:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:21:11 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 08:21:11 +0000
Message-ID: <d0628e02-f7cd-4303-af5e-9348840134cb@arm.com>
Date: Thu, 3 Jul 2025 13:51:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] selftests/mm: Skip thuge-gen if shmmax is too
 small or no 1G huge pages
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-7-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250703060656.54345-7-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB8301:EE_|DU2PEPF0001E9C2:EE_|DU0PR08MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 0926544c-c47d-496a-5983-08ddba0aa57d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dFZvZTZSTHBkcWZ1VEtDNTJ3elVkUHljOTluZlQwRFpoUXQwVHpNNXBoV1Z1?=
 =?utf-8?B?dmViWEVFQnJJS1ZGWWNvc1BMTm9BWldBaU04M2pvTzU4Y0NmR21kdTlNeE9j?=
 =?utf-8?B?U2pkL1hEYnBSNHR5VFdxSDlGUUVYLzNqRU5sWFNYOC9PWE5LblRtTjRtT0xj?=
 =?utf-8?B?bEt2anZMR2drRVFPNmtBTzJYWlpiNkNoVXM5VEtvdFp4T2hnbFdjOXVRVGVV?=
 =?utf-8?B?djNhTng1YVY1ODVZdWhpeFd5T0xFeUU5QStvaXcxQlc0SVl0RzF5V1lyMWYv?=
 =?utf-8?B?NGZkM1BWZE5Ld3g1ai95VVc1SzBzYzhVenp0Ujd6aVV4V0RiVm5Kb0d2RWxZ?=
 =?utf-8?B?SFdMQk81cGxaWG9Jd2lVYUtUWTZiaDBWTlRNRGFQSmFaQVRrRWh1ejF2R0py?=
 =?utf-8?B?c1BGa21qWG5MeldZd0NvWWJiTWJZdWxjMGRIbzFXeUM0RlNyUW8xbkxWN0RL?=
 =?utf-8?B?RXpkMXBDZVZTSFNJYU93YWp5am5UZGxFNlNQOHdQQlVNRVl1WHdoTlNrYkdH?=
 =?utf-8?B?a1hHZWZFTUR6RWJoTitFMlJBUUdFNzZFcXEvbjRGMFZYUFc0dzZJaHdtakgx?=
 =?utf-8?B?eHlDTm9rSU9hSjZpRWFoRnkzSlFlcE9UTVQ2WjRBbXlEU0ZmNU5DdWh3RUEy?=
 =?utf-8?B?R3ZUK21aUzA5VXNDaTI1c0pzaElPNHRLSzVubDNlT0lTRFNyd0tsWmRWcDNP?=
 =?utf-8?B?a3BHQ1Brd1drbGtXRnZuTW1OQnFRQ1ZNSXpyU1BFdVhjVmV1VURHL2YyaTRU?=
 =?utf-8?B?cy9XdkxQbCt2M0lkbFV5U1FIYjhiYzNGNEZnK1YrREZhRnhETHFTODdHc2RC?=
 =?utf-8?B?Z01oVmU5QlhpUjRqSXVOMkY3NVdNcGY5dFFwMFh6NXRqQTc5NWthdFVraVg3?=
 =?utf-8?B?eHZTZW13eWdMZlVJQWxRMUdKZFlWa1Bqck8yeXRwSTFBdkhIY2U1aVpScy9i?=
 =?utf-8?B?TVNWV1ZGY3g5QmVHVHp6cDdMY1lQczZvOENyam5KekEyMWoxb05uS2pCbGIw?=
 =?utf-8?B?aTZMeERKZWdtM0trWm9wZlQ0Wjl5eTdXeVoxd0VQdnoxQU4xMjJCSTBTRVph?=
 =?utf-8?B?NzJpUVFiSys4d0wzM3plb0NHWXBzL2dkdDJUUmVBQWNaUjcvdnJ3NlR6SWdU?=
 =?utf-8?B?SDN3cllicVI0dHN4N3ZZUExOVlRYT0FOamliZTAxV2dzVExTSWNxY0tvRjZu?=
 =?utf-8?B?NGtuUGJ1c1ZPbnlyRmVXazRnRnFuajRXU292c3hFOU0xUUYzMkRWbFAxWUxi?=
 =?utf-8?B?QSt2RFBvbzd4RDNVRldKeUcrdWFVZStrMXpPQVBSY2gyU1o5bmtwUm1PU0lS?=
 =?utf-8?B?OWYwMWhFalFRVms3eHVVRVdvOFZSYjNCMVFVTDdaSXdWQTJ5bkdJRkY1dVJT?=
 =?utf-8?B?SXRGUS9LZk9vNHpzcVY1VStoZGZNRitCV2t6bUxjUCtZcWx3VnlMSEFQczRD?=
 =?utf-8?B?eUFwUGMrbXY0UDlyVElOa1p1VGY1V1UrS1lzRngyZlZBdnZkUWFLZ2s2VEhD?=
 =?utf-8?B?WnZZYlNCbHh4NnJOejRPL0xnUGhGZEZZOXN4cVdPNGh6WTdsRzc2dUMyWDRW?=
 =?utf-8?B?YktGNG0wQ2Q3SGhWdncxdHFDZDRVbUpyalozRmFnYVpicXg2a2dOSzdzUjh5?=
 =?utf-8?B?eHZ0blZtb1dXUE1ZaERhT2VvWGV0MVE3RFcrUkJKcW82QUJWL3krVmtGZHRJ?=
 =?utf-8?B?MW8wQ3JpQkRiY0Fld0JyakRCNHhxMXQ2WVpleEoxWFduVk91MGRTc2hNT0J3?=
 =?utf-8?B?ZXB3QVhsTnRFSk1LbjNYT0NzUm44amI2L3JPaEhHZ0R0VTZ5b3pJeHlSRlFM?=
 =?utf-8?B?MWRxVTJ1d0Zkdll2QXg1eHBHTzZSZURJaGdWR285MzM4aEhOeTFxNWF0NE5Y?=
 =?utf-8?B?eTJPeU92NWNxTjFyZDJ4UGRmSjBlOVhlU00rYklJQnlCRFpvK24zYmttcWZS?=
 =?utf-8?B?NFdNbzNrVzJmN2o4aGtjRjE5cVRSTk5Vb01aYXQzWGFqK2lWaUpNZ2Y0czcv?=
 =?utf-8?B?VERvOERHc3NnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8301
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f9ed5fbf-9029-4208-fcea-08ddba0a91b7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|82310400026|14060799003|1800799024|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTBacXVuUGNnclVtYitDeW1ldnR1Ti9BbUo2dzdGSCtjTDRUVU04ZmRIM2hz?=
 =?utf-8?B?Rk5QL1ZVRHNubmVGYVJ3cGxnUTk0emtYaDFERFQ4c0hUVFZuR09JNjYwS2hx?=
 =?utf-8?B?N1lpUTJabnN4MkMzemFzV0xiR0lTWncxS29HZ1hjSXZhOXNQcitKNjI3S21z?=
 =?utf-8?B?SDkwUm40MmQ1cGVtanpVLytkWHhENEFoR0JrTU1xVmJ2MEhRb3NGcWdoUzRE?=
 =?utf-8?B?SCtsaEJkZkVEdy9pL3NCY1VyVFFHOXpwYmdTNitYaUtZNnZLblI2OGhocEhn?=
 =?utf-8?B?YWNTeHMwMHlBWVBvampodFA4UWRWN1N6WDZWT282S1dSb2hnYS9JVUNuZTBp?=
 =?utf-8?B?UW1YWUdZNVkyc2prdC9TQ0FlR2t3M01xcjd6aHk3MllSY3dEM0YreVdURmNn?=
 =?utf-8?B?TS91bGdvaEMwbTRRSVlSMU9iMFd1SlBpSlJRSjdzWkRsY3RTd1hMbUZjd2hR?=
 =?utf-8?B?dFUzNTRWbkFtNEV3bDIrZjVTOE9sUkVsZTJhQjZDUVJQczFhdDl1TnE0Sm0y?=
 =?utf-8?B?U3VMLzVIMG54UzZYT0d0MFV2c0N1VVUydTJrcHU1bFJyY2gvUGtDMVRSdjJ6?=
 =?utf-8?B?U2pISUJOb1dCbGNvTTRyZi9DVEgrQmxiNHowazlvYUFtOHBEcGg3bmI0OUNm?=
 =?utf-8?B?Um1JYWhDbVR1Q0ZPaHFXYmxCQU9ZYkVQQjJndGd3cFhzYUVwK2Z2T2RZcUZp?=
 =?utf-8?B?Z0V0eWJnL1NwektQZnVja1pzdU5vVXVkMlpwc3B2OU9hUjZlSDVudmJ6UGQv?=
 =?utf-8?B?N3ZUd09tN3NkT09kT2lwVWJDMHduS3pHNDlCbWVIVEs2WFZ2SmZ5MmluWXpw?=
 =?utf-8?B?TWRrTjZYcC8xZWh4VXRzMGY3emlPOFNpb2ZNSmw2REVsZGI2cFk3UXVEOTFM?=
 =?utf-8?B?bmtSL3c2RndFRHk5VkFSL3NnYitsdU1SOHRVVDZrdEpIOXlvWXpqWUlSeUNn?=
 =?utf-8?B?SnZyMU0xSGVZdVo1TVVIb1dJd0Vmcmx6RzZzODFJclNjQWRxNW8vUTRMZWlk?=
 =?utf-8?B?MXJZY0I5RGFJN1Z2NllPaHFHRUkzYlQ3ODgzWGx4ZFI0OERWYWIwRnBzL3Ji?=
 =?utf-8?B?S2ZBRzY5RkRIOFI3aVExTEtmZVVjTHgvelFvblJXbVlDRGR4ZlRhZnlYU0RL?=
 =?utf-8?B?elVFb2luTW00UE5lTndaTm5wRjRHRmZKN2xpcmVTZGMrLy9XYlVEaUZWMlJB?=
 =?utf-8?B?U1NNN0JhUzVCVzNYWDNuSUV1dkxtSnllSXc3WXNaNHVKT3c3V2F1dzRhK2hY?=
 =?utf-8?B?UWRWbjdMWTZiRmVHTlhFemdOWVJrbEtZK09RR3JvY2dEajZ5a2FpYXNjTHho?=
 =?utf-8?B?M1RIT1J2OHBCSkt6NTdSdWFNREE4VDFjRnB0am5nR1hyVitqOFZYeU83Sk42?=
 =?utf-8?B?ODNEQjhJMHJnMXQ2RWJHSk4xcjlocWJEdFp4YlBvcS94M0hnd2pSTHlyRlVS?=
 =?utf-8?B?UnBPRUI5ZkhOV3BWU1I5K3VkanJQdDFDak9DWnlBcSt5QkxrMThTU2NTTmtS?=
 =?utf-8?B?MFdxY1hDb3QvOWluRnY2RWIvdWJwNXI1dDJNS2VzaVBCdURNU1NtMm1sbWFq?=
 =?utf-8?B?Tk9mYUN0cmJ3bTU4OGhUQVY0ZGlCSGxpVlNoQlpaYjRaR01HYTI1U1daZVIx?=
 =?utf-8?B?T0lEMGxReG1IMDdyNWx0eVFuUUJTR1ZhczJZYjU1ckwxNG9aNzY2bmlqcUFw?=
 =?utf-8?B?TlcySXJXM0l0U0taTlhLbEI1bm9Qd2NpNGlpU0FDV052YVBkTEZlWWJuQlEw?=
 =?utf-8?B?UFBLdkdIbjBCN3g3SFllT1hQem8rSUpIUGN6NkY2NUlaZzRUdGpydG40YVlE?=
 =?utf-8?B?ZS81UWdoYUhIdEt6cEZCQWtvcUtBNXdJSVVtV3hLelAvbjRlZGorRGU2QWpk?=
 =?utf-8?B?VkcxMFBrVVl2VjlqcDc0cDFkeFBqbUc0QWVTSHd1dzFxNUNkZUkzN044bVVE?=
 =?utf-8?B?bG9rdnFSOFB0ZFptY01lVmlNNm9LbVZzeEtXZnZSNHMxRWpNRzdhTnlXcldw?=
 =?utf-8?B?SFFiTDNjYUxWeTJlQnllZUpUcHo4VUdDaDY3TUc3aURJQWUxcGpBbkNNWWVR?=
 =?utf-8?B?M0Q2RWovSFJoN2tOQ2Y3ZEFMenJxbnVoVGQ1Zz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:21:44.4305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0926544c-c47d-496a-5983-08ddba0aa57d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9420


On 03/07/25 11:36 am, Aboorva Devarajan wrote:
> Make thuge-gen skip instead of fail when it can't run due to system
> settings. If shmmax is too small or no 1G huge pages are available,
> the test now prints a warning and is marked as skipped.
>
> -------------------
> Before Patch:
> -------------------
> ~ running ./thuge-gen
> ~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> ~ [FAIL]
> not ok 28 thuge-gen ~ exit=1
>
> -------------------
> After Patch:
> -------------------
> ~ running ./thuge-gen
> ~ ~ WARNING: shmmax is too small to run this test.
> ~ ~ Please run the following command to increase shmmax:
> ~ ~ echo 262144 > /proc/sys/kernel/shmmax
> ~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
> ~ [SKIP]
> ok 29 thuge-gen ~ SKIP
>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


