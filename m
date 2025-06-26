Return-Path: <linux-kselftest+bounces-35814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD7AE9570
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 07:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659E116E63A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7A21FF44;
	Thu, 26 Jun 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GuZhNRHQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GuZhNRHQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A681A316C;
	Thu, 26 Jun 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917357; cv=fail; b=o8xMaI54AORztomPqExP7RcRS3wd4A1hONMIC0z7vfUm+UjdtR1ONrMHzF00MPTlj8vAsLggeOFSnbAbht0DXESqzssT8q+LyfgLPoRtEGDSfyn3bkzITmpRNGF04Fd/NO+uo8a4fXQiC7eEezCt9Jya/SgCgMj2zuTIMpeAB+0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917357; c=relaxed/simple;
	bh=hnT2ilGO63m0IwS1xHi1LWlzz5+Z93WJh53BFb1nX5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DoXAXL4bV5yg1pI4701T57URny0VySCxYJLXAM4igJCpOVWhPuQC/gnlyrh/VW7C2lJN5oLUGcPYflStPcpvlGBU0/XxQF/BtvqjjKrgp5dICcOLYoneb3a7rU8Td87uzCSvGRL8HnkC1vzlofgcQbvm1esQIOwnSqnpVQRfPQc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GuZhNRHQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GuZhNRHQ; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q9R6zhoXLwFJDOZ6OH25OwpyxmwHQs4tY9Vx5x2Xv0/2lYw0JLiJ8jbMOLaU8MHrZukjwORp84WGmwKkOPaszTZ6gpiWE8ZInz1GzRUOJaLtdBnbtT9LUMSecLMM5UCYlG19r9WpL61ED1GeQckyi6KQdDuPvrNGs7BtwkeihpLqZ18FoWzO/rDAfaO5sxSlny2k6NINWsYHFaKTz++L0Sc8A2HHFnSzNQJ1VXwvUi0e26xHdSpU8eohf5ACeI1M37SlfP9f2ENMp+U9kfZ/0kfeD1EamzXHUDvYxGRgM3btshWa/YawtUg2vr2y/DkfY6tZwzh6iaq+w9bJc21IFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C32JTWT3IV/b0DFyils7u/jsmW38BU0+zwTMgmVOzyo=;
 b=M8uAKjrPaUbxkeB5bSyF9EXokE2CgKu6+IrMaiJM8AHxwPXBTsW8LXpcXHZPqANw4a96BP0BVhZy5TD0XzDu/DkDJMABQu2NliaA8mDybwbCaSWS3T+MSU0Gw6ZqMx41gwj7OB8jgI+d2cmSFkUWOY6e/58IMyefT1qOLYF60ceusUNqdp0kNa37eVoATcrXAaITZBI4J7r8/COBlFc4HeI0MYYCc39iwSPNmhlBr6rNm7tqJlp7Mm2s/2uS5xzRQcSNMBO6KWABlTMBxonc/T2gvHC9TPWvMtFiciTi7BspgWYBwL7luGCZictFkKGSwFmC+dfEkO6j7hamCXs/+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C32JTWT3IV/b0DFyils7u/jsmW38BU0+zwTMgmVOzyo=;
 b=GuZhNRHQxbM2ktDeexmVaivuGPvnVOB/CMV/86+73sO4hYNdlUOE7TfuRo9WV0MYJYx2/ofBAgSKs+ITYwQLxhLzL5V7916YApSoCatL8KDIc4uj5o69hKyp5u22/6RfHIvHnuREy3q26y0r7tb3jSV5+TrLfQTtuOZxuge4ULg=
Received: from AS4P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::16)
 by AM9PR08MB6018.eurprd08.prod.outlook.com (2603:10a6:20b:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 05:55:50 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::b9) by AS4P189CA0013.outlook.office365.com
 (2603:10a6:20b:5d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Thu,
 26 Jun 2025 05:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Thu, 26 Jun 2025 05:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGoPvYL+l9ksGMH0rNEJo0Wr8pUOKp4l3SSsgcn5lmuw1wHn1tSNDihzOrOylX2HJOSNu8AE/ZjfOAx9sWlLHRz9pzJ7nhUm0sz8JYFFK8A77N0zJMucu2Gvxn5h0mgtkI31r9v7O69eXSv2bECOPdglyc5fmdHsIUQroNb6rr6CuN5UgHTjncRUXzYw3bAESq5Y3gVVh9SQW7PcykdcIvuBbkdrVpD8ukgJNXYdKxqBrsCtIrc7I2Ef4Qq1GnNJiNXejeL23X7m66n/rUB73ge/4d9aLcuXHZfRnBk0vhy0KhGdMAMpMtZhpgiQcpPfK8bvaZUJtxwa/kNNlHcLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C32JTWT3IV/b0DFyils7u/jsmW38BU0+zwTMgmVOzyo=;
 b=nLuAd0O8/jxb/CbLY+YxDlZaib1XHNpqA1yrhc04+hH0O2w/RjG8W2UPnhU9HL/Rj43M1kxoI8Cd19TBo/KOHVnAIqmWoYQoReOoCmX+XdGQjwAzduYeGRSO8iAgUcIrSShvP5/3LJAWY6EdjD5ovFYuMMMSvUt8IsFxz71VUSbmxStcEj3EgTFUDigazgEu7687TynZUAc+4I2HDzgG1n+akvZgYJoYvg9zLY9jrUl5Lo4pTGQFxyXUTsAM8P2fYI4GImcqARk93T1REOQGaknNkFU+BIpU6T3IXCdXrdH0KJP5DtVrkKyLz+98UdAaBkL4xJ8DpxNbfCG8f601dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C32JTWT3IV/b0DFyils7u/jsmW38BU0+zwTMgmVOzyo=;
 b=GuZhNRHQxbM2ktDeexmVaivuGPvnVOB/CMV/86+73sO4hYNdlUOE7TfuRo9WV0MYJYx2/ofBAgSKs+ITYwQLxhLzL5V7916YApSoCatL8KDIc4uj5o69hKyp5u22/6RfHIvHnuREy3q26y0r7tb3jSV5+TrLfQTtuOZxuge4ULg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6311.eurprd08.prod.outlook.com (2603:10a6:20b:290::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 05:55:17 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 05:55:17 +0000
Message-ID: <9fe8d8c8-3a24-4cf2-bcf6-c579e8ff75c6@arm.com>
Date: Thu, 26 Jun 2025 11:25:11 +0530
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
References: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
 <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <3bc08930-06f3-443e-a267-ff02c2c053f6@arm.com>
 <aFzdu8YGN_jDxV1u@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFzdu8YGN_jDxV1u@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6311:EE_|AM3PEPF00009BA2:EE_|AM9PR08MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 582889aa-ce09-461c-2b2f-08ddb4761a6d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?di94Z0dWNjhIRzkzN2RINDZRVnQwcU40eDYwQ0xSRm5aVDk0dUdEeEg4cDRG?=
 =?utf-8?B?L3NQcDFEUnRvTnBFMDV2QXI2NHR0NExJenZUajNaS29VYUQ3MUt3cFEyTTlQ?=
 =?utf-8?B?RWtZTlkxSElFQVAyN3FKSEtPejI0KzhPSWJ5U00zUkZRREZHRzJSb1RZQ29u?=
 =?utf-8?B?NmJiWXpVL242Q1BtMUxnYXkvM2dLdWhickwwNFY4WmF3am9WUFpFUWZ4Mk9t?=
 =?utf-8?B?SDc0ZDdyaHJlOXVuNDdYY21QN3kyRkZ0UzMwNnN3UDJmK3ByVkFtK0w0YTVL?=
 =?utf-8?B?bXBkR255b3VyWkVVZEYwUUxnbEVoZUxFaHhFVXZwanNreEJHV3JLdWRKQkVr?=
 =?utf-8?B?bVhXd000Y05vTlVkUVdSUURsU0F0M1dUR2pacGhWKzhraktaTy9XTHhsdVBa?=
 =?utf-8?B?S0VWQTFvcjYreXU4MWRlWkNMemhvMklqemF6UFIvbnRpZGdyYkQ1a1ZKc1hB?=
 =?utf-8?B?eTFMakgxVEFQMzNXbHFCOXZZUFVMemRmRzhiVENuQkxOeUZUeWtQRkIvL3Uz?=
 =?utf-8?B?Zjc5MXdXMU04eEUzVmZza0Y0NGFaUUZXVzRZcGU1VkF4OTZQb29KbkFFdkNG?=
 =?utf-8?B?dXI5NEN3ZWxJbjRjYlp5V05qZ3d6N29jWHUxbU8rRVRscDZZWWRYTEJmdStT?=
 =?utf-8?B?b1ZROXQ0YkhwQy9weHZOZHFRZzFlaVZlalR2bExWWUMzcXVwM3ZuZW5UUGlr?=
 =?utf-8?B?MGhFcnFmaDNuY2FaZkhnWlM0d0UybExQU0FKQlQ4WmdPMnZ6ME10UXBvZGRI?=
 =?utf-8?B?M1FaTFFDaVdXdktOenNVamFZRDdBZVBQSmlhQWhqOW9lY0NTRTNvNHc5bnpT?=
 =?utf-8?B?VnJTcFkzNUVJeE9jQ05BUWY5R3lUM2hRcjVJQ0hKNXk3dGhsdmR5c3RIWWZ6?=
 =?utf-8?B?MEZtYkdwNUFoeG1XaHZMbDZvcHpsc3F5dUJSanFiK2hrR1d6c1hDRjh1WVlh?=
 =?utf-8?B?RjF1NmcvNXpLNm1LUDZzTDhHQ0xJZDNQRzBnQWlYMTRQSnhnQXQvVU9DVXdF?=
 =?utf-8?B?akJpdllWRXhHeVpxUm1PSUhxQUpLbk45c2RpQWYvckdqZ1BUMHpObExGY2VV?=
 =?utf-8?B?RVpaN0FHbFlxOXAweUp6Z3pCZHJGSkNLVnVNTmhMUllLdVhoS0tyMWFzVnZm?=
 =?utf-8?B?cWh6S3UwQ2oyREFzMUh4cU90bHQ4YzJzY1V5TnZtMURmeDBjVzBGQWNvci8z?=
 =?utf-8?B?N2VadDUwTEFOMGM0bE9EUERvdHZsVjR6aWxMK0RjNlJHb0g0VzlkYXlVcUJq?=
 =?utf-8?B?THVqQVEvWWFCbEE0TTc3dUxuaEcyQUVzbWo2THU5ZlllMU5DSjZlVjYzNmhW?=
 =?utf-8?B?N05FRkdDOVlHTkpTdEFjMU96WTZBY3BObFhPdHpiU21tTkNoM2wxRHkwajli?=
 =?utf-8?B?Y3lVRlhqY1VMSVEwRnRITTRJRlkxMnlvWGg5Q2IvV3JrQ2IrbzllUFZieFY0?=
 =?utf-8?B?Zk5OR1QxZ094NVVWeFA1c0JWVTM3L3pIeEFmT2I2QTVPcVBYanBtWjlrdzNM?=
 =?utf-8?B?cmNwOGZhR1RlMXRhMUI2ZDdQYTEvWC9WYjVoL1E3cCttVFZheGptUFNaOW9M?=
 =?utf-8?B?cWFua1BMays5YThCUDRiUGQ0L0hDWlQvUllYeERiSkpjbTRUSCtFc0xNcWdI?=
 =?utf-8?B?TExwdDA5UDVTZVNFdDRwSHcwdkVrUThWbDFWVVA2YlRxd0NZTFNWNE9pWktm?=
 =?utf-8?B?V2tkWkwrOWxlNzNMVG0xWFJOU2hiaS9pcDFTTWg3a0NCNWZrQTFhL3VDN3Fk?=
 =?utf-8?B?WEJwbFdta0NWempvUjUvMnFHUzA4THVDWDdRUERjWTY2REh2eFpnQnJDcnAv?=
 =?utf-8?B?amlYeVVZZFVwUkJhOTgvcW9ISDQ1dmtzVzcwMVR5dG0ybjFCbURPZ0tzd3RJ?=
 =?utf-8?B?SnpGejNnMlFtanBMVDBjVE5FT0JlSW5Bc082aFhVRGMyWE1PZlRJTm1rblZM?=
 =?utf-8?Q?syVJlgg/VPc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6311
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b9c9299-d57a-4fba-d214-08ddb47606d8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9CQ0NFbDV1Y3JpTEdDTFFCdGx1MmdtUjFTS1JkdnJkWExoUS9JbWpqUzhF?=
 =?utf-8?B?T05pd0ppLzliZ0w1L3o5dEU1M2p3YUgxQTFkVjdvRGFhdTF0YmpQYytqc2Ix?=
 =?utf-8?B?NG02ZC83ckhjZE9yWFdwY28xTHRuQkZSZndYUTRMdGRsSHBDVUtPcks0R05L?=
 =?utf-8?B?dmhmVDhFNG9mVGhpcTNtQWE0bDVlUkdRUDhOdmRSbWNxaEh3M0hGenhiK0xy?=
 =?utf-8?B?d25VQzk1Nmc5WXNvSHhZeGNHK21QeVpJU3U0Qm04SmZUTjRCK0ZJNDFKSWRr?=
 =?utf-8?B?QXpiZi9MTUxZS0FQUGhWQ1dTSkFERWhtZzFXdkNqVkMyQ0xuSExxR3NlQ0hT?=
 =?utf-8?B?MEUwSXkzQUdESmNGWWJrVklETVNvQ3dMR3RQMU5KTXZaVnRXV2ZsT2hXWU1H?=
 =?utf-8?B?WkFZTTJ1Y0lpczk5L2hYeXV2aXVtTk1SS0twZzdGaEdBOGZzYTJBMnRsTjZM?=
 =?utf-8?B?cmhBUXJmenRlQ1RRS3AwMWRGbWkyNUJLa21uR0F4QVp5SjBoUGE2NEFZT2pP?=
 =?utf-8?B?QndoZi9KajhDNjJETFV6VFQyQmZ4dCtlU1lYZytpc1orQTNzekRRNVh3RDZ0?=
 =?utf-8?B?WmFhSUlWQkVkcGdpT1NLZ21lOWMxZHlVOTYwL3Y3RjRubUVoUmkwdmtkVWxt?=
 =?utf-8?B?M2Q3akJpc2tMVnM1UTg3OGVKMDZNUm5LeTZQK2tWK1ljcGwrQS8ycng0MnlK?=
 =?utf-8?B?bWV4YUdiRDZITmJzUXhSbXlKcE8rSkhTUEljdGI3YjYwOXB1aXNFeUdDb21H?=
 =?utf-8?B?a24vczFwN1BMeDA5RG01THhRWmE5TkJ2UU4rb1U1b09BaUlrQkVrQXAwK01Y?=
 =?utf-8?B?RUtMQXAzem12WnhLRmpMN29IWG1RSUhsbC90cnpOY1p2MlBpYUpZWlJKUnRZ?=
 =?utf-8?B?dVBOTUVYTHo3ck5zcGNDVnNZNkxaUVBaU2VsekN5cUJiSUlISERZVVhpNWx1?=
 =?utf-8?B?ak04SGgrbXlGeW9yTUNTWUdhejJxTWc4MXMxNmZqVnlDbnl3OWNSdkVIdWsw?=
 =?utf-8?B?NmJTL0g3c3VXMUhKTld3d3hWODJoeXFTaGVuZkh6QXdScHR5Y0UyT0JNcE92?=
 =?utf-8?B?aC9JZWZ0c0hOUStnT3A4TnZJME1qQmNBbDdqSU9uK0JCWGZ4engwMUVDR3J5?=
 =?utf-8?B?aTA5eGVDeExNN0xxdUdmbGVYMW40aDNoWFdUUlBGTzRkbDdoeG02cUJ6cGhk?=
 =?utf-8?B?NTkrUTZLSUVWcEZUWklIZVFYOXJoRyt6bERvZzNEWVliWjBvNnNSQ3NXMkd3?=
 =?utf-8?B?YW5NMlMrbjJ2V2ZBMk13WUtRRktCYTU4cTB2NkJ0a1kyVVR6WWRpdVBYUkZn?=
 =?utf-8?B?eGlSR2kzRUFQTkFLdVQ0M210WSt2OXJoUGlTcnA1TzQ2bkxtdFJNamZ3UmYv?=
 =?utf-8?B?akw1NXoyWnVCV2Vvbk1UVnNOVW5LNWx0QW82NnFmbnM3cjVyQVArTndKZHpa?=
 =?utf-8?B?cXdBUjZDYi9MVEhOcFo2bStnQ2FZYkZMY2tDTjRSNGdJc2xKM3NFQTNzV3dV?=
 =?utf-8?B?Q3dkT2NQUDVjUUFzVE9xeS9rSGJpazNNR25JMmtXNzNjbSthNCtIcjRLNkFh?=
 =?utf-8?B?MUZzTzI3SE5GSllNcnJuNlVmZ2ZFYVcrTGpxcWVQZnNSUXJFOHdJUUlnL3RK?=
 =?utf-8?B?RjBvdHRxVnBnQUJXTGlGanhEMVE0TGJudC9DQlptTzd0YXdqd1JxOVZJTG9P?=
 =?utf-8?B?OGNTcWx5Vzg4VU9oTHlKdGR2WnVjZkVTN1VLODhoSXBocjlia2JLOTRHbWhD?=
 =?utf-8?B?TVlzWmplWjJNS0xNOGFuZkVvYkI5Q2dJNjNPOTZEUXg5MHYxWGljVjhLZTM0?=
 =?utf-8?B?MVBiMVYvV1BneVRxdm5saUVIMzhRd1VNeENOVjNXMURFV2l2WEtYRFU4bVZZ?=
 =?utf-8?B?U1AwZEdlVmpsSkt5aGdBZVc5Wk51aVdzRHFrUlFsZ1Y0bXpKcHNibFJkZ1dl?=
 =?utf-8?B?eWtKTjZMUi9VMWovcXk3UHA1ZXc2NzJjaFJzZ2NMcWZRUlhHbWJ4aHVvSkxQ?=
 =?utf-8?B?RjJ1NjBkeTg1cnFGeVlhd1ljU0JwWnJkREVYYk5wNzZzS3ZNckMzbFUxdGxG?=
 =?utf-8?Q?4giz4B?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:55:49.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582889aa-ce09-461c-2b2f-08ddb4761a6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6018


On 26/06/25 11:12 am, Donet Tom wrote:
> On Thu, Jun 26, 2025 at 09:27:30AM +0530, Dev Jain wrote:
>> On 25/06/25 10:47 pm, Donet Tom wrote:
>>> On Wed, Jun 25, 2025 at 06:22:53PM +0530, Dev Jain wrote:
>>>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>>>> first.
>>>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>>>> mapping count check.
>>>>>>>>>
>>>>>>>>> In do_mmap():
>>>>>>>>>
>>>>>>>>> 	/* Too many mappings? */
>>>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>>>> 		return -ENOMEM;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>>>> this.
>>>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>>>
>>>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>>>
>>>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>>>> is doing, I can do that : )
>>>>>>>>
>>>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>>>> it passes, but it might just not be of great value.
>>>>>>>
>>>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>>>> leave larger gaps if we feel like it :)
>>>>>> You have a fair point. Anyhow a debate for another day.
>>>>>>
>>>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>>>
>>>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>>>> implementation details.
>>>>>>>
>>>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>>>> userland VMA testing I'd say.
>>>>>>>
>>>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>>>> technical appraisal!
>>>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>>>
>>>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>>>> this later.
>>>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>>>> the gap check at the crossing boundary. What do you think?
>>>>>>
>>>>> One problem I am seeing with this approach is that, since the hint address
>>>>> is generated randomly, the VMAs are also being created at randomly based on
>>>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>>>
>>>>> High address VMAs
>>>>> -----------------
>>>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>>>
>>>>> I have a different approach to solve this issue.
>>>>>
>>>>>    From 0 to 128TB, we map memory directly without using any hint. For the range above
>>>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>>>> starting from 128TB.
>>>>>
>>>>> With this change:
>>>>>
>>>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>>>
>>>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>>>
>>>>> Below are the VMAs obtained with this approach:
>>>>>
>>>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>>>> 20000000-10020000000 r--p 00000000 00:00 0
>>>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> index 4c4c35eac15e..0be008cba4b0 100644
>>>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> @@ -56,21 +56,21 @@
>>>>>     #ifdef __aarch64__
>>>>>     #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>>>> -#define HIGH_ADDR_SHIFT 49
>>>>> +#define HIGH_ADDR_SHIFT 48
>>>>>     #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>>>     #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>>>     #else
>>>>>     #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>>>> -#define HIGH_ADDR_SHIFT 48
>>>>> +#define HIGH_ADDR_SHIFT 47
>>>>>     #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>>>     #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>>>     #endif
>>>>> -static char *hint_addr(void)
>>>>> +static char *hint_addr(int hint)
>>>>>     {
>>>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>>>> -       return (char *) (1UL << bits);
>>>>> +       return (char *) (addr);
>>>>>     }
>>>>>     static void validate_addr(char *ptr, int high_addr)
>>>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>>>            }
>>>>>            for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>>>> -               hint = hint_addr();
>>>>> +               hint = hint_addr(i);
>>>>>                    hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>>>                                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>> Ah you sent it here, thanks. This is fine really, but the mystery is
>>>> something else.
>>>>
>>> Thanks Dev
>>>
>>> I can send out v2 with this patch included, right?
>> Sorry not yet :) this patch will just hide the real problem, which
>> is, after the hint addresses get exhausted, why on ppc the kernel
>> cannot find a VMA to install despite having such large gaps between
>> VMAs.
>
> I think there is some confusion here, so let me clarify.
>
> On PowerPC, mmap is able to find VMAs both with and without a hint.
> There is no issue there. If you look at the test, from 0 to 128TB we
> are mapping without any hint, and the VMAs are getting created as
> expected.
>
> Above 256TB, we are mapping with random hint addresses, and with
> those hints, all VMAs are being created above 258TB. No mmap call
> is failing in this case.
>
> The problem is with the test itself: since we are providing random
> hint addresses, the VMAs are also being created at random locations.
>
> Below is the VMAs created with hint addreess
>
> 1. 256TB hint address
>
> 1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 2. 512TB hint address
> 2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 3. 1024TB Hint address
> 4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 4. 2048TB hint Address
> 8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 5. above 3096 Hint address
> eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range].
>
>
> We support up to 4PB, and since the hint addresses are random,
> the VMAs are created at random locations.

I am still not getting you. What happens on my system (and what should
happen) is, suppose after you get the VMA layout you described above,
you again do an mmap with a random high addr hint. Suppose that the hint
addr is 1 << 50. Then, mmap will see that there already is a VMA there. So,
we will fall back to top down allocation, and the fifth VMA described
above will get expanded downwards. This will keep happening till the gap
between the fifth VMA start and fourth VMA end is less than MAP_CHUNK_SIZE.

Then, mmap will extend the fourth VMA downwards, and so on. Eventually
all the gaps will be less than MAP_CHUNK_SIZE.

>
> With sequential hint addresses from 128TB to 512TB, we provide the
> hint addresses in order, and the VMAs are created at the hinted
> addresses.
>
> Within 512TB, we were able to test both high and low addresses, so
> I thought sequential hinting would be a good approach. Since there
> has been a lot of confusion, I’m considering adding a complete 4PB
> allocation test — from 0 to 128TB we allocate without any hint, and
> from 128TB onward we use sequential hint addresses.
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index e24c36a39f22..f2009d23f8b2 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -50,6 +50,7 @@
>   #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>   #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>   #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>   
>   #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>   #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
> @@ -59,6 +60,11 @@
>   #define HIGH_ADDR_SHIFT 49
>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> +#elif defined(__PPC64__)
> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
> +#define HIGH_ADDR_SHIFT 47
> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>   #else
>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>   #define HIGH_ADDR_SHIFT 48
>
>
> With this the test is passing.
>
>
>
>> It should be quite easy to trace which function is failing. Can you
>> please do some debugging for me? Otherwise I will have to go ahead
>> with setting up a PPC VM and testing myself :)
>>
>>>>> Can we fix it this way?

