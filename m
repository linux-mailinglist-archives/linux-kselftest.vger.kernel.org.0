Return-Path: <linux-kselftest+bounces-35375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81CAE0B24
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451DE5A45B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50B19CC3C;
	Thu, 19 Jun 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RFpNQFTa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RFpNQFTa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F63BE46;
	Thu, 19 Jun 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349731; cv=fail; b=VppiZg0pEwToHxdk/6JSr6r8IYmNH+tl753S4VmzkmSDlLP+ZJZaaaEYgm0YRoc9Sj2psZ+qW9p7xqiAd3OlEzWNhg3XUJZkyyVQqRFo8K3CsQrW/0WpFs5sbS9cSA3g1JOxqZUX3tc+Z+rK/zxQJWHTlcbs/fax9QjozMjo9qk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349731; c=relaxed/simple;
	bh=TItAc7oJ+KzzQZXGCHMNJPS5LFdVTOIHEfwoTtn0VdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qD4rAA6LbFBlUrFy+kwtNw1xMJSPq1EXl2SI9FHj84vK1qhBmRcofVNW69jbEwCwTcvRRncM/eGqkNzFkqUuDqPK26u2H3spNUigAz6K7s0OucyH8wIHjubPHhcegYr+ESXov6a9xgF8hPgdzeXCz4YGXs1YWICiw90OROlY+Rc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RFpNQFTa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RFpNQFTa; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NUrrOhZULH9Ws9ICzx4GgzV6AwZN4BvDxtqu43FAvW7L+BfKg2O+jofCkEuE7RzxxinLO3XN0N8/ZC691P2PREH2MAfwwN8fGK2nzjn2/aZ2IpAEd/vTR1NGKJURiW35wwvUwkSLcMYln/sQeiSM4mwZF4lhlmbxl/XECtOJOuxWeGP+3ux+6YT51/P1rmMRx4Asf/DIRfYwcGQk8f1Tx9xRMPAUis0uj+81f1cAQcy7SiE+9c9GMOwMYtnU82esSWd1xpEHvNZ9YkXm3B8JJMuWkJ8sARpurIasP56l1kymX9smIhDG4tIk8O/Zt7B2Q15pi8s/Mii1niV2ZXAMjw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IklXpBoeCP2vLiltr8uExqPFXSAqSgNIlZyCpCSidys=;
 b=EFoJ1uRRfN9e5TiBxhofwnhZgFRzOlTV3VWAthcUCkLF+lW1tjZr62rboKl47g8mL6Vd2AVaV4Hcdu+d9heZq0lUHhiNgC/I8SrWAyFs6a9CYR18OJ7306Dd+gfOl4b6v9iK8s+svoFGt2Uzv4rkCM/YMM9awPi/tV3C06NzD2aCysIQKjCVckACBIvBE8f64yjVqf1cQutC56FWEQZDrExvQm1Dsh5/DNbthzGSiY9ofdtoC0afO+R8SCD3vcYKxCkGzKF34Jspy8LfWvOpJih+wqXNq1sG1qmvXoakT3XMwdEurkC7rCycVampyn1Lli0Gh5Crdca5e52gzRzZxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IklXpBoeCP2vLiltr8uExqPFXSAqSgNIlZyCpCSidys=;
 b=RFpNQFTadkd61tGmAnCqYhCVminWCNNh47kzrR0/2sOllPwKCtn7R+WKg7VlbJwYvEfSss/62a+b4sfNpfzUW+BRW1bYBF4f5KIrvQ+/LHyZz2msV3dW4OEm79unEmTdr81PxvrFRnNB9K+XyTxIeP7G6LN3efgmZJpTJA0fuy8=
Received: from DUZPR01CA0279.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::28) by AM8PR08MB6451.eurprd08.prod.outlook.com
 (2603:10a6:20b:315::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 16:15:21 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::ac) by DUZPR01CA0279.outlook.office365.com
 (2603:10a6:10:4b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 16:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Thu, 19 Jun 2025 16:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTGCkTr4nFgRC+Jrlod/Dsecs2JwI1DxH5dxpmTOMwuTvMe93+JXSMSLfSHq+xYJjx2DSFpjptwXnBHxwmaDnfkIAlpvM9ewSd4G4giq2uCHapIbz/zDr25Vugz67rkIDIvWcrLTFT7iokQpRj7LYCzJvQ6GGQPZvcdI/BEmW8Bj0nFkNX+H8n+7Q85G1+oJk3FBLqpklUA1CaeQPouOOAwH2CiRbIfoiTaH1AcarDgeOu9NDnn7yBVFqlnOSMZ7xx4k/nl4LmninRF9xTczxOGqGaXxDqYuq0RulVZAhQ8OrxHhxasxB10gCfzv84ujUIUeGm8cKS0LBDQVKF6HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IklXpBoeCP2vLiltr8uExqPFXSAqSgNIlZyCpCSidys=;
 b=rycpypd0UUIQyZIRiXXwGukHLz3xY/vn7QU4Gt/+DMMA9qaMJNZ2/9tmZU6VgCyWg6ClKew+pPxcYP9SZUr+ddQ6jWNi/bYYjAX8ZmUnvrMse2/w4Sd49sFzL4q28TJ34mAtjjcmOu87DgVnjGDVDJIm32iAqWgxsj6ASD4c0K9HT1G2UrCcgMDAaFx7pjJhQB+nPm14C8QlIthyeWuf2Q2OVD4o5Z2q+defo7m8LDwuMEbgz6qUe17kSgv3dpfNZhL8hCnZmEHPcnfJxOuFXT0zUxUekGEIf1Tz1zmfPcox+Ck3vX8/hzuN/MVCV5vjy/2l3BKiacmdIWeF1KcM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IklXpBoeCP2vLiltr8uExqPFXSAqSgNIlZyCpCSidys=;
 b=RFpNQFTadkd61tGmAnCqYhCVminWCNNh47kzrR0/2sOllPwKCtn7R+WKg7VlbJwYvEfSss/62a+b4sfNpfzUW+BRW1bYBF4f5KIrvQ+/LHyZz2msV3dW4OEm79unEmTdr81PxvrFRnNB9K+XyTxIeP7G6LN3efgmZJpTJA0fuy8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB8808.eurprd08.prod.outlook.com (2603:10a6:20b:5f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 16:14:47 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 16:14:47 +0000
Message-ID: <60ed08a3-d502-4e1a-8e23-33ba0eb4d7bb@arm.com>
Date: Thu, 19 Jun 2025 21:44:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Donet Tom <donettom@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <af2618dc-b778-45e6-867e-9ba3a79398c7@arm.com>
 <aFQtbTij87DziSeC@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFQtbTij87DziSeC@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB8808:EE_|DB1PEPF000509F1:EE_|AM8PR08MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ea5350-c92e-4e27-dc45-08ddaf4c7ca7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Z0d3SEZ2MldEK1VMRnNsd0dvU1dwdzhqeWY4cGpDR3dvME1teE1wRFM5NHV5?=
 =?utf-8?B?MWthWFVQT0pVNCtiNlRJdzNLTnU5cXdQYzE1QjhWVlhkRHBuUXZ0WmdpeXlt?=
 =?utf-8?B?N21pSDZCYkl4T1V2U3VTd0pqS1FJKzAwdEx6SisxQldBbmM4UG91dHk3MS9I?=
 =?utf-8?B?emNKTzVnY1dPSDRzZDAwQkxxK0JvT1lHY1VLYWhzYnQwTGJQMDRnam1VL3Rq?=
 =?utf-8?B?b0g1SDdBbzRveFh6SzY1Tys2WXJtR09LOFBBSENrcEVMV0hGWi9uUTJycWYr?=
 =?utf-8?B?N3B6L2srVHdvbU9FVUVWL0taRHJLSkNFWkdUZTM5a0ZzVVZyNDc5bzN6Nmp1?=
 =?utf-8?B?QTNBRDBTbHlBS0tkUTJ3K1lkS3BDUGZCc0FzYWlDWFEweWhZTm5ZZURwRTJa?=
 =?utf-8?B?K3hDdE12VlNWTEVvZTZjVk9BWGE4L3lkMXM5S3FnemdpajVOdkNPK3JmRmdz?=
 =?utf-8?B?d0pPUmo3UE9ObXZUQUZvM3V4eEhjUit4K3pFYzh0WXFZZWpXM0tnMnJ5N0M1?=
 =?utf-8?B?SUNaSkxXUVg3ZEpNczhPY2lycWFKMm82WG1ZOUNpdWMwNjdvZWY3SUpIUEJu?=
 =?utf-8?B?YUVEV0FZdzFTUEVqelBQU0FBKzFjYnU5WWtwbjFKTHR3M2dOUU1LYVlYTlg3?=
 =?utf-8?B?WG5SNDNnQjFYNzhkNW0zQWFQbmRsMW4vSy9ybjFZaDRXdUxDQ2IrdmhQT0pI?=
 =?utf-8?B?TFJpV3FHTFV0cTlhUG0ySWxNRG5zZUcxMUlRbFFSS0RZWU15UkxWQm92WVhV?=
 =?utf-8?B?Qml6MjhjQVpiSVpEMUFjRDBaNkJhcDJnbzlJekIwMEhOeWVMaUVETjIrT0Vp?=
 =?utf-8?B?TmMvWGdpWnNBWVphVmsrUnp4MXdTVG5VL0xGZlJ0YXhhRGRzcWgxdzJRUENt?=
 =?utf-8?B?Wk00SGU0QnhxVEZKMTY4cjNqbFhlb0dGSE1GeVdoVHFmSGk4QW5OMWVjdWlj?=
 =?utf-8?B?M3BJdXVvdjJWcktNdlNodFhubUlJMmNEVXpxamFwNHdodEROYVQxc2xoMWxN?=
 =?utf-8?B?OUkvY1gxSTVlTWRDRTRyUTJTdGZPMHI0UUtDNUlXUmgrMFZQbGYvdzQrOVNi?=
 =?utf-8?B?bCsyRHJXdGVvVjY4Y3pxcE9sTXM1ejlkbVdBbzdJUHJHcGlKNitKbTA5U2RG?=
 =?utf-8?B?SmxsZXJTd1p3M0REbXM2NmZjNVZPeFk0dXRZVVBhTDRweFdvbWdqR084bHhE?=
 =?utf-8?B?TmhmdVNHUGdYVnhldm1sM3NzdUFObkVFWFJkYUhiRzBKY0JRdm9kY0dTN2V3?=
 =?utf-8?B?by9RZTU0TmVCVmcwNmJCY0dpZE40WTdTTmVaMWJQT3BrdkpaYVV4RHBtSElz?=
 =?utf-8?B?ZDZRd0tRVmZuTk13SWZUc2xxQzVZNi92Um1rUXRkbHZ5aXNFbnp1V2liN0lG?=
 =?utf-8?B?SXZZTytlMWNaZkliVG14ckJoTUFhaDdveU4xWkx3ZzFTc2sxMjlwTU9BUXg2?=
 =?utf-8?B?MEEwWnZMSi9rbnRTWGt5cjZUWGxHdDQzaWVjbnlKZXFFNStTZlNIdUZ2L2Fs?=
 =?utf-8?B?QVBxY2IwU05tTmF4Q3hJck5qTmtpZWhBazBBRDB2UzF4MWpoc1J5NER1cURW?=
 =?utf-8?B?RnQ0aTQvR0pEV0VoOTJZU2s2dURsYWlHdGhyNjNkUjR3Sk80S1Nmbm84dUk5?=
 =?utf-8?B?MGhpQTlLSkNPbW5MVHhMd2tKUzU1ck52Rjh5NTNOYlpzQllDU0FGdnltR0ZV?=
 =?utf-8?B?OWFOd0Y5Sk1venhxZlVrQ2Q1SGVjKzJMSVZKM2RjeUZsd1d4aDZyMzljMFdF?=
 =?utf-8?B?TFRkRTE4M0grcFRWdGdqQThCdStoOElQNXFEQTlQVEk4TWUwd2UyRkwrWnd0?=
 =?utf-8?B?U3crcVBya3dsQTNLU0RLeVR2eWlLSHhORm0rSlA0eXdiNkJIZGY1U2kyTXlj?=
 =?utf-8?B?MWVhbE03K1Z1SzI0bnk4NjFYMjlza0pWZEUrZ0FUWEZ3Y3JBKzltS2k1TnFQ?=
 =?utf-8?Q?5y4k5qNWuXU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8808
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0b2af0f6-9ef1-4ed8-8773-08ddaf4c6948
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|7416014|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUV5Ny8yOEhISEIvL2pXcjROSFNWOU5xNnBFU1YyQ1ZrcTFOU09DTGd2VU9z?=
 =?utf-8?B?aFpGUFdrREVvMTRmMUlwa1ZhWVJhOFp5aEVzUXh6Qys0VVJKajRQRlZ5YUEv?=
 =?utf-8?B?eGs4YTIwWDFvWHNuaDRtQzN1UTdlK29IUlFlRGdWL3R3WnlXYWt4RlJ2ZWw3?=
 =?utf-8?B?cGdFT00rZ09VK2xpNEZtNFk4TzFvQmhzcG5ibnNJVjRGTnBKTlh2cTlxUlVu?=
 =?utf-8?B?YklVK2x1SFJVVXpxM3dROS9sYWdUZGhsRW5Ickw1Nno5RFdJaFB2ZXBidDRa?=
 =?utf-8?B?RDlzSDdqVWdhYWxSQml0TmFLSEFxYWJSQXNxdElPYkp1bXhGUWNZOTNtUU13?=
 =?utf-8?B?NVFQMHF3eFp4ZDVQQzZzYlBsT3doTVpQZ3h5NFQvQzJabUtUbngrMTJxN0o2?=
 =?utf-8?B?RU4rMnpPb1oyYzNkT0I2NUFkWEZBaFRoSGNldXgrOEVpb2o4OG0xdkU0Vm5F?=
 =?utf-8?B?TjFEbEJUdnN3ZXduZkhub2R0czBKVDRnVnVxRU9yeWpuRno2bndKRFJLNjB3?=
 =?utf-8?B?SysrNVAzRVprRWRUOS9CeW9YVStsbzF6a2Z4dHlQT090TDY4Z0lXVTRhVGV6?=
 =?utf-8?B?ZXkzZkJQWGpYaFk1UTV1UExoZ3l1RkllZnNBVUI5eFhjREF2N0xCUU50bzdO?=
 =?utf-8?B?Q2locDVCN2tVSmdYYkdzT0hmeVBOOXYxbGpoUXlNYUZEcUFDeUhZZml2QzVF?=
 =?utf-8?B?azViNFp5QzZnazJiMkJyWjNiNVVabi9kSXFKSzNCQUZGWVhrbXJLSTRlSTFE?=
 =?utf-8?B?R0ZobUlMZUNRMUYvMFRMOUZzaG9WZ1lqYTVSdEw2MER4NXlneXp0cmd5S2ho?=
 =?utf-8?B?TGd6aEtBZ2pmQXp4YlVEOUt0SGkyK0lOSzZiWTd3dzJib1hLTC91eVNncm80?=
 =?utf-8?B?Y1JhbkU4STZ3S3k2L0ZNY1pHQkVKbjJxY2xyaUE0UVB5RmEvMXZpTkpFcmVG?=
 =?utf-8?B?SVdWMk4zaE1YcnhjRVVBb2tPL1pLN052WkJzZ3dJcFBSS1ArQUFFMXU5STZL?=
 =?utf-8?B?eFRWbnd3eWNRRG5wdXB0T3hwYWdEeFpvSzU5SUJqMFZjTWdEMXpGWS9HWk9t?=
 =?utf-8?B?Qk5DZXA0M2R6bUxJNkhHOER0YVExU09KNGxoM2FEQ2dkSFhtN0xtVGZ3MXd4?=
 =?utf-8?B?RVA3RFRUbTRHcDNOSDd3MjBrLzEzTitCcGh0WDQydGVJRk9nU2hUV3M5Q0pX?=
 =?utf-8?B?TUdNVmNwN1FxYW9yekdtVjR1dU91cXJhc29UajIycE5iZ1grZ29MNXd4Undr?=
 =?utf-8?B?WEFNOGd4R3FrZ2Y1ZFVwaTRIdldiVnQ2c3lVc29YTDRZK1V0eTB5TnhPSXUz?=
 =?utf-8?B?MTZ2ZDd3RGI0eHRPOWdKd3ZYV1JiT3RyYlBjdG9GekQrNWp3cjJZbHRoZkU3?=
 =?utf-8?B?SURqMzNLUy9XRjdZODRxbFdpT3poR0RPSnJvSnY2QWVIL0h4N3JIWEdJVWFu?=
 =?utf-8?B?WW9UajYvYjdwMXpEdnU5T2oraFM4TzZTTHZ6d1FiWTRObHo2VnlHVm9HQTQz?=
 =?utf-8?B?TDJVT0VXZFc3ZzgyRnhuMCs2UDlIVHhTN2tmd3k1aWJIR1dvUkNBZ1ZlUGY4?=
 =?utf-8?B?NUhnNmZNTEJwdjM4QTNXZHVhY01oT1JMcmROODY1TlpPVzdvQmZWVWJTQlln?=
 =?utf-8?B?L3gzbXZyWTNTYmJiVngzS2FSQ3FwVjB0T3F1WU53UHlVQjVCQjdLWkVoT2pO?=
 =?utf-8?B?R0dkLytpVVRlQnYzMmthWklXMXpqZWJuSW1VQ3NHbjZPY0Jyam1yWUNERkZ6?=
 =?utf-8?B?WkIxZ2xkaEhwM1JMT3krL3ZQOUNIaXBVTVhmZlpzSVlBMHNUWkVTS3VXQThP?=
 =?utf-8?B?dzlvRVRYb1I4ZTNVSkhLMGFxU1JaTkNjQzYvc29iQ0lyS1VLQmtodTVKTVUz?=
 =?utf-8?B?UUhoLzhodGZpcy9WQXU2MENObW5PSEFqRXFLR01VaEh6YlNGU1hxdmpLcGpC?=
 =?utf-8?B?QWtxY3F4YnVGNVU2a3pRLzZKb0dtL1pwWHZiOStxeHJuSUVuWG9FOWdVMVNL?=
 =?utf-8?B?V203VHQ1L2Y5WllJRFZZaFJVR25LREF4Mk1nbDJPaEJ5L3RyUFVFeEFaMDgy?=
 =?utf-8?Q?uuhFYa?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(7416014)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:15:19.9133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ea5350-c92e-4e27-dc45-08ddaf4c7ca7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6451


On 19/06/25 9:01 pm, Donet Tom wrote:
> eOn Thu, Jun 19, 2025 at 02:32:19PM +0530, Dev Jain wrote:
>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>> first.
>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>> mapping count check.
>>>>>>>
>>>>>>> In do_mmap():
>>>>>>>
>>>>>>> 	/* Too many mappings? */
>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>> 		return -ENOMEM;
>>>>>>>
>>>>>>>
>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>> this.
>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>
>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>
>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>> is doing, I can do that : )
>>>>>>
>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>> it passes, but it might just not be of great value.
>>>>>
>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>> leave larger gaps if we feel like it :)
>>>> You have a fair point. Anyhow a debate for another day.
>>>>
>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>
>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>> implementation details.
>>>>>
>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>> userland VMA testing I'd say.
>>>>>
>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>> technical appraisal!
>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>
>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>> this later.
>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>> the gap check at the crossing boundary. What do you think?
>>>>
>>> One problem I am seeing with this approach is that, since the hint address
>>> is generated randomly, the VMAs are also being created at randomly based on
>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>
>>> High address VMAs
>>> -----------------
>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>> Just confirming, the correct way to test this will be, put a sleep
>> after the VA gets exhausted by the test, and then examine /proc/pid/maps -
>> are you doing something similar?
>>
> Yes. I am doing the same.
>   
>> The random generation of the hint addr should not be a problem - if we
>> cannot satisfy the request at addr, then the algorithm falls back to
>> the original approach.
>>
>> FYI in arch/x86/kernel/sys_x86_64.c :
>>
>>     * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
>>           * in the full address space.
>>
> Yes. Got it.
>
> I ran the same test on x86, and what I am seeing is that mmap with a
> hint in this test is always failing and exiting the loop and no high VMA
> is getting created. Ideally mmap should be succeed with hint right?

No, that will succeed only if the CPU has LA57 feature, see arch/x86/include/asm/pgtable_64_types.h,
X86_FEATURE_LA57. On arm64 that will happen only if CPU supports FEAT_LPA2.

So the high address VMAs which you quoted above, were for arm64?

>
>
>> Same happens for arm64; if we give a high addr hint, and the high VA space
>> has been exhausted, then we look for free space in the low VA space.
>
> So, in the test program, is the second mmap (with hint) returning a
> mapped address, or is it failing in your case?
>   
>> The only thing I am not sure about is the border. I remember witnessing weird
>> behaviour when I used to test with 16K page config on arm64, across the
>> border.
>>
>>> I have a different approach to solve this issue.
>>>
>>>   From 0 to 128TB, we map memory directly without using any hint. For the range above
>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>> starting from 128TB.
>>>
>>> With this change:
>>>
>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>
>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>
>>> Below are the VMAs obtained with this approach:
>>>
>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>> 20000000-10020000000 r--p 00000000 00:00 0
>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 4c4c35eac15e..0be008cba4b0 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -56,21 +56,21 @@
>>>    #ifdef __aarch64__
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>> -#define HIGH_ADDR_SHIFT 49
>>> +#define HIGH_ADDR_SHIFT 48
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>    #else
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>> -#define HIGH_ADDR_SHIFT 48
>>> +#define HIGH_ADDR_SHIFT 47
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>    #endif
>>> -static char *hint_addr(void)
>>> +static char *hint_addr(int hint)
>>>    {
>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>> -       return (char *) (1UL << bits);
>>> +       return (char *) (addr);
>>>    }
>>>    static void validate_addr(char *ptr, int high_addr)
>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>           }
>>>           for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>> -               hint = hint_addr();
>>> +               hint = hint_addr(i);
>>>                   hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>>
>>>
>>> Can we fix it this way?

