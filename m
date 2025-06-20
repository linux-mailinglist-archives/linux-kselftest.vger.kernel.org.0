Return-Path: <linux-kselftest+bounces-35440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E630EAE1DC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5533A188855A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6A28C86C;
	Fri, 20 Jun 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KarOWamz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KarOWamz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8D28C017;
	Fri, 20 Jun 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430771; cv=fail; b=qdq91wLTU0ODZj+FUbJFlhTVmq9yFF0WJaRx6UG44en3dyScBnrVzPgBtezhX0JuJQxJu/AtkNGXmt8tgNx/xG2KkgtBDU4DZwdbs3aYc7keJiFesNqyfcO701Mhg/yeJCpVjfa32euJ8eKl5L2V3EPz1tbqbtha1Sopw6FON8o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430771; c=relaxed/simple;
	bh=eYqLrUrgyVwXeYIyJqb2dS5ZXXaH+EY84cnn1sVBQOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyXKGxHV6huujvC/lgSDH2051Ypm8FXCOfl5Dgu8ht7oHGdWVcsrNiLtmR3mnDSwmgybw3AS0Gr3UvADGjy+UyWT/ru6kFIRx4qnj2QqL8SSA2kxAqzxVNV8r1xe6aPnjHsCHjLeJQLhT6ZYoNjXeDBJuzHRpfZg2hNDc8LmoTA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KarOWamz; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KarOWamz; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=E32rpivTG0PLiCotgdYel5AJOiqC+X2U0HEgRXus4EO5tYE0fHaLTYjw+im3HCrgnDTRmgXmmA2EO9LuGhQzExfMu88to3oLnlJISvlCg4I2SNKpJLSFPG7/x7VpRAVmQKcF/jr24Sqb4/8zr3+fDT7YzGwvQS1d2A4zK4jMRjmtd/G0JU6Ya7jsSlymXWFW4TnclJ3x4jLf+2C3PLIWZy8lJV9H1PNSjBO8NLIdw96ToCv7Y/opg2frwlzf/HUmJeghLMwIyR52OZ7wT/mu71tZy9aIHGHrDYHzpSaccmY20Cndzoki5bWo7ALgQiuJm25VlKRNA6i3vgyekM5Miw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/hTnhp45IuhgH0zpXw8TKAElqHltyfcNYOvfWDKEA0=;
 b=pqyf8gldkKlfIRfJqcnFhRSKwkvHRyrYU3Ino+llcmSD1BAT8i0aGxIqjD4nxXZhIzIU8q1DyhLakY6HfkiRXylGBRVokMyWzXKIr3/M9rbTaXg/O5ay7zZ2KWAJe6t9QOkpgWFYWkSyDClE9WYYWSEUHwjJP3E0s2D48msBb+s8UxekXx9GNmov9XCoIdnsUR50f9Hn04siTHepYbXIt2i5RUudWURtIggirzPES2nPoYpseACWkyu1MgcqZBa2g+bAIaZQ5AqWVa3g9WzsQttgIREMv0mDIWpM6qseLkd8XdXaKFhwPrmSQJxR9tW+ScYLu/Pwojx2pJkvjR9Bhg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/hTnhp45IuhgH0zpXw8TKAElqHltyfcNYOvfWDKEA0=;
 b=KarOWamzZz7d6eaMI8WX6BCXdWi+e1ofMKANYasN+j6Aio0W75PvD31UFCPJ1oWq8tc6QeniXkB56mmwcqTeRRNIv/F4qWFTh/l8dswUpHV3y/5JfyY/WTdTnP8JF6sDdNk7rj+DlypTgUkZIuJ0PRjyg93bJ05sN3ZiovcbPMY=
Received: from DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) by AM9PR08MB6001.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 14:46:05 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::f6) by DB9PR01CA0017.outlook.office365.com
 (2603:10a6:10:1d8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.36 via Frontend Transport; Fri,
 20 Jun 2025 14:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21 via
 Frontend Transport; Fri, 20 Jun 2025 14:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2saFTO+Fl/HWaKBYQ0Qi48xDAQJ+qUNhR7rR0SJpHjOV/Xrt09w2bVBiL7tY6EQ+eSZ+/iennpnFjXMY8TkQqO5a8K0seonu3yMG3kRrx0qplsQXkf2m6Am58m1mj1lg9UQgLDANdRE5X3meFIZXFagA6pO71IcHw/s+QRpZhxeQ7thbp3d02p6RsQuqHtLLwDyYwaapN2Fn//xXj7f+xBGRHVgrNfIcWV/9qQa0M3BPe2Svyo8zqmPeJB+wjHl3O1GZkv0zliG//lcy5osUg06P8LwAvKuo//MTJz5lZnF7ow5EPbCYLf1yG2Uzjp3fLKRL5FAMs56gKPoxolSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/hTnhp45IuhgH0zpXw8TKAElqHltyfcNYOvfWDKEA0=;
 b=yurgBo3q5EX2mMfYRqcP6EY1/1rCT57Q9/qbDh66LDUIA4xYQr7xtwq+LWxiN+deoYEQrW6MXADKkLUF8qRcB/J+PgyFYQ3iWRsVeHG3nPUY1t1A77SeEwR6IWDn8fOffRkD1ATfji5rJ2UCDWA23g0rrFt5aYY2MZ+5gLKLR3HUF271vpg0d9TSxK5ATc2NAbANbdGzQ2stj8SsHgG53cyDNpFWbJy/GMlXPqq3CHt3lXwZX6JqudPdoryGbimlW62hra4vYesoioEEgrLToVLPSyGLQwIVt8lhlM72/cRlPgHLaKEP8bj37mTwUWTW63VFQwDdUdUzTyVLlT/NWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/hTnhp45IuhgH0zpXw8TKAElqHltyfcNYOvfWDKEA0=;
 b=KarOWamzZz7d6eaMI8WX6BCXdWi+e1ofMKANYasN+j6Aio0W75PvD31UFCPJ1oWq8tc6QeniXkB56mmwcqTeRRNIv/F4qWFTh/l8dswUpHV3y/5JfyY/WTdTnP8JF6sDdNk7rj+DlypTgUkZIuJ0PRjyg93bJ05sN3ZiovcbPMY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB8480.eurprd08.prod.outlook.com (2603:10a6:20b:55e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 14:45:32 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 14:45:32 +0000
Message-ID: <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
Date: Fri, 20 Jun 2025 20:15:25 +0530
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
References: <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB8480:EE_|DU2PEPF0001E9C4:EE_|AM9PR08MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edc8527-1566-42e7-0287-08ddb0092eb8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WXFOeDFGYlJYTERIWjRCazM1WmVMdGdEMUhrUHhsZzdHRXpibkp2d2gzVHU5?=
 =?utf-8?B?aFV1MUVQSWpPM0QzdlBlUGJITHFNcmdMRmtEZnZiY0ExN0NnZzV6Ky80VWFV?=
 =?utf-8?B?Q2F0VWhRTkdJM0N5bzRlM1U1QVNlQlNWYTIvc2h6TWV3VEMzbFJCYlJYQkxp?=
 =?utf-8?B?WXNXV0pnSFoyckdtc05oUEZBb2VlejFHUSs5RnBOZG1JQ1Q4T0xBMC9GbmdB?=
 =?utf-8?B?OWxlZXpwRGhTV2ROa0JEL29BWUpDMkFRWlpwNWF3U3JoZ1VzZm42Q1dRZDNv?=
 =?utf-8?B?MjJzQzFJeCtvMytiWVFza3ljRGYrK0wrbnNaWFpLM2gvZjFMSTVCWjZpY1Zo?=
 =?utf-8?B?TEdUTE03TUszdWdGTUdNczR0Umd0ajVaVVQ4UGlTL0sxTWRrZGlrVUpMY2ZY?=
 =?utf-8?B?WXVLc3N0cW91a2VZRGZOMEVwZWJ2SEY5Q0ltTTdBRlY4Uk5PbnBsQzRqVlNx?=
 =?utf-8?B?NnVDeXJvQ3VjaTNPNkswN29vZVBpdzZXZC9DbVFzb1Y1RFdnaGpUOVo5U3hU?=
 =?utf-8?B?SjBEMkxiRy9iZVNuZ1VUTEJYM1ZhVDY1SW9tbzR4dFVmcldabFowdmx3ZWJu?=
 =?utf-8?B?ekJJYkNyTVI3WDJOZmc4dW5GTzIxY3JsRGh1bW9yY05hWElSRmJtcGNkeGpr?=
 =?utf-8?B?c3lhYVlteTVXaDBmdy9meWp0VkJiZXJZZGVScGVNK0Zra2ZiV3FsL3Z3d2dR?=
 =?utf-8?B?RUxWeS93ckgxTWNFWE5PanBwUUxLUldWTTNPclhlcGNqR0VjVGFET21kd3Ja?=
 =?utf-8?B?YnB0UGJKYlVROFlLNXY3MnZBd2tMczY4eDNKVVhqQjhFdHdLMHBGcUZxcHRU?=
 =?utf-8?B?YzEzRWRKWHY1eXlCZkVmeG9qWWtIMUU1K2V5MlZ4dHZZT2tiL0ZQOS9HZXRT?=
 =?utf-8?B?bVJtV2JwWVMvdGhtdjhRcllENVo3QXN1WVkvSmp0Ukx3c1hqOG1rSUc1dXpt?=
 =?utf-8?B?RUxVZ1pLWWtFUjc1Ry9tMXRENVRobktqZFFJSnJFQlplN2pVK0JCVktwSGJp?=
 =?utf-8?B?ZHJHVEt0K0p3VlVVbGF4Y1lvTkVxc1FwRUE1L1lxTlFYZXNhVjc4clh5Qmla?=
 =?utf-8?B?d3IvbGh3d3FUT1dmSnRJdXhvUEhEaUU5U1lCaVkvZ3FjZnNUSlY0d1JlNy9x?=
 =?utf-8?B?bzNpUkxJZXU5MkJ1MDdicE5GRHlQWFV3dXJnaXlYaXcycEg3WDVTa2FEMkJz?=
 =?utf-8?B?ZGt5N2p3Zyt6anJ3VXRsaVJTYzgvT2tkSktBY01GME9aaWlTK0lDeCtCRFVn?=
 =?utf-8?B?SE80UlM4dzlPRUhXaFF4ZWI4SzNBeGNvdGJwUHo1UFIzMFhMS09OVlFpRTIw?=
 =?utf-8?B?bnUzM1ZkQUo2QUV5b0F1U093Q2FBaENKL3FyU0hyNysxUEMxemJwSS9qVkVZ?=
 =?utf-8?B?OUpIMmozSjE5WnNlM1N0VWFuYXV0Skw5MzU0NVVqT1pDR1ZoTTNDS2VRaWdq?=
 =?utf-8?B?M2Rnc3VPM3dPdk45R0tsQmh6My8rTFVNbnZwaTJ4OG9pcXlZY2c4ZnoyaGx1?=
 =?utf-8?B?a0lXdGxSNk1jMTBzMXlRL2gyS3RNQThuOHg3YW9DSndGZHRiaGdMU1lHcVpn?=
 =?utf-8?B?TCtINDd4dFduanBBTnRSQWFJSTZEMXVPR0toTkVpWDhoaFl2TFVacmRzSDI1?=
 =?utf-8?B?VmhpQkF0eUxGdTZBVVBLK3A0VERmYTNPOWgwR1ZEVksvMTNXUExxVUF3eHcw?=
 =?utf-8?B?Y1JFdFE0NXdDdnc2Yy93TXlVY096QUdEZGVHdURvNXdub1BaNFRXaCsrajNt?=
 =?utf-8?B?NEdCRU05LzZRUGJ0NHRsdk0vWjN6YTRZYVJucFZKOFBEd09xSUU4VFNBVjd2?=
 =?utf-8?B?ZFFxeUtveFhiUUxabnB6SGRkeEFNY3JueTBqczdhb0VHZmV0S3hBbW8xT1FG?=
 =?utf-8?B?bm1IUUcvYUJKRkk3Z1hnUVpiYTRGTzYxZnA5dEQvRXhCNUFHWmtOTVlFQVdL?=
 =?utf-8?Q?vm9xcE+IQxs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8480
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4cdb5d9e-88a6-4798-ea1c-08ddb0091b28
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|35042699022|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0M3YzVCY1RkZm10WUlxZmQ3eFVralJaN0d3OW5USVJpWUluaUxkQ2FqVExL?=
 =?utf-8?B?dlcwTDdjNEtGSzVSMUZmZCtBVFp3NDZoaFRJbW1qcXJkeGZDMjlXY3RXQ3Zx?=
 =?utf-8?B?WUY5RDBrbkd5ZE9xNHJoRVdvd2xna3oyanoyMXk0dkp6S0FHU0lVcDE3c0tU?=
 =?utf-8?B?ZEw5dS9TOCtJZ0tEdlpyZlRZMFIxVmxJSWZkaGE2MmsxQlNkV0JCK1pmT3Jp?=
 =?utf-8?B?Ty84TE1JY1I0d0F1WlMyZjQwQVBrR3I0bFk4a3lCeVRVYW9ZTm9qZVUyZ1By?=
 =?utf-8?B?Q1NqREdQK2pPbWRNL0dnRm1wUXRGMGpVZ05HeHB0NGE5NEZrRTZ5bGlYZzJS?=
 =?utf-8?B?KzQ4V1ZKQVU0bmhoWGFQU042cnNMSXdJdHFZRWhmOTBlc2VtckpGZCtPZ3Vo?=
 =?utf-8?B?NHNOMGZ5VFdsbENWK095WFdWaENyR000MEtSSElWRDB4YWVWVGtLRkJUZjZ1?=
 =?utf-8?B?Z1QvZStGVHpqTG1iVk1HRE9aRWY4Y3pPUmk0bHEzMmVBcXJqVUNHNmcvS0JE?=
 =?utf-8?B?SEhwN2hNczRLeFhpY3d4UGw3WFovblJ0N1c4NGdMaXYyNU9nTE9SQ3FkTDZi?=
 =?utf-8?B?eG83dXBuOVlNU3ZUVkJsQnpOWDhvelVqa1RDa1djNEhzR05MWlJsOFJmMXZi?=
 =?utf-8?B?SkxIck9WL2NHb05lYkNPbDhqenBVbHhBOVlmWTJjM3RPWmJUL2J1MWh2M1JD?=
 =?utf-8?B?eU5LcnVjS2hxdktFZUFuUFhhV0c0ZTNydzloNGlMbkVIR1dvUCtuTjMxYlZu?=
 =?utf-8?B?Z2RWaXhRdDBlNHJHeWtuWHdlTzFGRzdzdDBRVTVaMXpMQysxV0kxWHhpd1Bs?=
 =?utf-8?B?RktrUk1IR2NLRzMyLzFGL0JKYW5lYjZQcnZtS0Jkb0YxMlFjK1dhZ2pyUU9k?=
 =?utf-8?B?eldYTHhwS3NYamhmWjRQa2NBQlJVYnU3dDVZc2tyS2ljVnN6OUNlb2QyWFFZ?=
 =?utf-8?B?RmlLSnMvR3VJSzR1citJQmVDMmdzRFcrTUNQWU1qWEFVTlVlbHBteGdMaDly?=
 =?utf-8?B?c3BXcGpYcTNFQnU0SDZSTVBURzcxRW41dk1yQmlvZVFyTHBUS2VXSXlQRUlt?=
 =?utf-8?B?aTFiMGE1OHFxbXFvcXNCWnZZaVp6TEtLQ29oRnViRUVEWm1FMkh0VXZCWHVU?=
 =?utf-8?B?QmhvOU05M2hVcDBmNTBDU01QRS9pdTBRUXgwTXNGV0F4aHhNZ1VNcmwrOW9x?=
 =?utf-8?B?QitCcnJIWEMwUzdyS0N3bW51Y3AvTHF6dXhhTVJ5OFNMelpUdXpzazJQc0RP?=
 =?utf-8?B?ZHZwM1FVamh0K011ck9CNTlaL0FRdjhNNWdyb0tJQlhWcEVhRUlIZFJ6a20x?=
 =?utf-8?B?VFZBbGVFSXowWHAxdTJWcTF1dFN4UkxxWDJSVDZtdjVOVndEZGdnZWluQm01?=
 =?utf-8?B?WDFUZEdzeUtSWDI0Q05odU1nK3ZlTmJQM1gwYWxVNDgvQVRjZU9RQ1p6L1NW?=
 =?utf-8?B?OTlkRGg2UUxqRkgzMUN1aTZhNjBUOG1KSTg5ck83Wm1SNWltaDM0cmtqcmxo?=
 =?utf-8?B?NTVLcXkzSE5TZ3liK3c5OTk5WUwrTXpJY1lwNzNyRkN6eSszdnB3U1QxdTZE?=
 =?utf-8?B?MExpWXEwR0o0QmNycE55VDFka0gxbGVOakVrUXJxb3g0anRFOTNUMkhYVExG?=
 =?utf-8?B?RGRrRjZmdXZRYUE3YVkxRktuVkRpckJWNnBMZUoxYWE1UDM5SEtZbGk2UmV5?=
 =?utf-8?B?aXJqb2xMSkQ3RFRTMWwvQXN0ZnNSZ0x5cEkycHBCNmNuWHNlSlpOaU9aV1pE?=
 =?utf-8?B?SE5KeGgyK2NId1NiZW9oVFFFMUJibUxLRExpaTVlUTFjS2FuZFlJS1FlV0VR?=
 =?utf-8?B?dGVNTkdqMXp4WitQelVJVGNjMnBnUTRYaHlDZmhOcDEyalR1b3lrMXk4bGNC?=
 =?utf-8?B?YzRoRHM5U1JtRGI4WlF2UDR4enZVSkoyQ1BsU3p0UXQ3elZmTUE0OWZZeE9l?=
 =?utf-8?B?RXpETm9Sa0o5QVFYVkpOU2wzUDhHbHo3TTVLZDlOeU4zeVpaQ2FiTVREbkNH?=
 =?utf-8?B?ZG5zL0x4ZnNKbVBjRGttU2VIeEtPTFV6akgzWXRRSkdNNkY3U2YwYlhDellr?=
 =?utf-8?Q?YEtN5a?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(35042699022)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:46:04.0355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edc8527-1566-42e7-0287-08ddb0092eb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6001


On 19/06/25 1:53 pm, Donet Tom wrote:
> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>> first.
>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>> mapping count check.
>>>>>
>>>>> In do_mmap():
>>>>>
>>>>> 	/* Too many mappings? */
>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>> 		return -ENOMEM;
>>>>>
>>>>>
>>>>> As well as numerous other checks in mm/vma.c.
>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>> this.
>>> No problem! It's hard to be aware of everything in mm :)
>>>
>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>
>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>> is doing, I can do that : )
>>>>
>>> I just don't have time right now, I guess I'll have to come back to it
>>> later... it's not the end of the world for it to be iffy in my view as long as
>>> it passes, but it might just not be of great value.
>>>
>>> Philosophically I'd rather we didn't assert internal implementation details like
>>> where we place mappings in userland memory. At no point do we promise to not
>>> leave larger gaps if we feel like it :)
>> You have a fair point. Anyhow a debate for another day.
>>
>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>
>>> But again I'm not sure that achieves much and again also is asserting internal
>>> implementation details.
>>>
>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>> userland VMA testing I'd say.
>>>
>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>> technical appraisal!
>> Nah, it will be rather hilarious to see it all go down the drain xD
>>
>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>> this later.
>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>> the gap check at the crossing boundary. What do you think?
>>
> One problem I am seeing with this approach is that, since the hint address
> is generated randomly, the VMAs are also being created at randomly based on
> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>
> High address VMAs
> -----------------
> 1000000000000-1000040000000 r--p 00000000 00:00 0
> 2000000000000-2000040000000 r--p 00000000 00:00 0
> 4000000000000-4000040000000 r--p 00000000 00:00 0
> 8000000000000-8000040000000 r--p 00000000 00:00 0
> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>
> I have a different approach to solve this issue.

It is really weird that such a large amount of VA space
is left between the two VMAs yet mmap is failing.



Can you please do the following:
set /proc/sys/vm/max_map_count to the highest value possible.
If running without run_vmtests.sh, set /proc/sys/vm/overcommit_memory to 1.
In validate_complete_va_space:

if (start_addr >= HIGH_ADDR_MARK && found == false) {
	found = true;
	continue;
}

where found is initialized to false. This will skip the check
for the boundary.

After this can you tell whether the test is still failing.

Also can you give me the complete output of proc/pid/maps
after putting a sleep at the end of the test.

>
>  From 0 to 128TB, we map memory directly without using any hint. For the range above
> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
> we use random hint addresses, but I have modified it to generate hint addresses linearly
> starting from 128TB.
>
> With this change:
>
> The 0–128TB range is mapped without hints and verified accordingly.
>
> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>
> Below are the VMAs obtained with this approach:
>
> 10000000-10010000 r-xp 00000000 fd:05 135019531
> 10010000-10020000 r--p 00000000 fd:05 135019531
> 10020000-10030000 rw-p 00010000 fd:05 135019531
> 20000000-10020000000 r--p 00000000 00:00 0
> 10020800000-10020830000 rw-p 00000000 00:00 0
> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4c4c35eac15e..0be008cba4b0 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -56,21 +56,21 @@
>   
>   #ifdef __aarch64__
>   #define HIGH_ADDR_MARK  ADDR_MARK_256TB
> -#define HIGH_ADDR_SHIFT 49
> +#define HIGH_ADDR_SHIFT 48
>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>   #else
>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
> -#define HIGH_ADDR_SHIFT 48
> +#define HIGH_ADDR_SHIFT 47
>   #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>   #endif
>   
> -static char *hint_addr(void)
> +static char *hint_addr(int hint)
>   {
> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>   
> -       return (char *) (1UL << bits);
> +       return (char *) (addr);
>   }
>   
>   static void validate_addr(char *ptr, int high_addr)
> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>          }
>   
>          for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -               hint = hint_addr();
> +               hint = hint_addr(i);
>                  hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
>
>
> Can we fix it this way?
>   

