Return-Path: <linux-kselftest+bounces-34860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCBAD81C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 05:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032753A2C74
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 03:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7F1EF387;
	Fri, 13 Jun 2025 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JYERC1kS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JYERC1kS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF531A60;
	Fri, 13 Jun 2025 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785666; cv=fail; b=HSSdtESbHjJEXaFsqyX8mOZKEFrIKy1EbyIE+841aLly+9CZKpP1uuVUP2t9BbXSY/z8M+ZTYjCjhUYmunC8eFnCphv+gSi5Z+9+SP60NC/lfynk8suT6uu8mo5W5bRp70cpXMNOmX8A9J93k/ln688UdXjTSYdPl54dcmyRwkA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785666; c=relaxed/simple;
	bh=SFjauH9DkOdLCCqsJNaDjO+EzfhuM/XIc0WG+9wT7wE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SvkHicPmiSmEGSUxBkd7uugb9i/cTmZYP/KGx80AIAvSNnMVy6VCjiEAI72qKCCwZ7zpbVMZe91UKJKfbhAbnjq2w+OzXMwV+xGYiaqWhX+i/vBxJUn1Ji1cGZh//xcgnAzGfxYG9UsZgwPWrd+s6Vxp/AvCv9w21S4WWKcS1ZE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JYERC1kS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JYERC1kS; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=D6tFvNl+b/buLVmx+D9z+WuYWySH2BSgFLWdClJZ9NxblrVCBfI0Pz14kUT0v0kdsAqWz4UXnKLlIm0ioXguAB8djArhjelwZq8wDKkS5L8O6zIyrHQUI7u1efVvo08xxjDJGoMVHXai+RCds08dZhxyBlOBOvA+8tqR71ivldGA2qxNYGEDniEbd41j/nzVVGovQZUK0tq1GMPBj3M54ztee19aTweqz1ylGFF9gsbpIb2wBHzA1bgMSAAwzDHkuSzxTMQdt38rmnRbCSeb7wCW538pItid5t6WaRJdW8EWNOJ028rtSIudplFbPDxrNx1HIWWAqfVzI6xaioTOrA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH3flca1MKC4btdOX9u3sJZwWpmzF9J2VaCf1oKKe7g=;
 b=TR8s2nbgQeNm9d20YkS8CLVpEQzRbNJp4Q2Z42zCo+VdQ1uvZy712tRJLUToazLqShHnICqUieVduJeDd1qr5d3wUQLNKRQjh1+zHD69ednc0DhtzqTb4Um4gskZm21TLEZc4tzbMiHWA2uk4ZvKNMhN2bdHUFpkbv3wMAl5CfylCjTHhMgYG5bGj3LyRq+CZat2RDWg2RLy3y3EtAzRpbQKLLxiNT5sklScUDU+bmy3WS4rCYNd3F/dNGNSK71gN2MUj7xOocG9kosCaITIFECqNIGT/BEMqgSmX3ipamgVyK21HifxrXNdD1QqiOPNOmlcPF40jfv8WMw5o87lJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH3flca1MKC4btdOX9u3sJZwWpmzF9J2VaCf1oKKe7g=;
 b=JYERC1kSu0AB2yqJLLBbORs2ZmtKU4p8xHusOjMuiqevWSlplZnSYUWKQoCrOFv4L+oSYiN3n/oj4mhPRznb4bcvAfQ5gnACo+TMHjhZxqu5+6aqbuy3Vk2A7bVHtzbt4R2W85wfY5nmUHFVTdOEJ8glBFCyVe6cFFqaZiWyc1g=
Received: from DU2PR04CA0284.eurprd04.prod.outlook.com (2603:10a6:10:28c::19)
 by PAWPR08MB10165.eurprd08.prod.outlook.com (2603:10a6:102:361::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 03:34:19 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::15) by DU2PR04CA0284.outlook.office365.com
 (2603:10a6:10:28c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Fri,
 13 Jun 2025 03:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Fri, 13 Jun 2025 03:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcFEHWmhOLq5+KC5YkgmviGyJpetVBZbgf2AmxOZp5/msiFm4cdTfjK4tU4nlJN8qOYjfB1e4IXHTHo4p87AXTUeN8OF0hT0mhG6B+TH8HpQSm/xe7bPCa3jb6GnsmDjWUaEU8Wk0ocS3pRVTRxgJoghqt5Pkm7V37wfLbanRFZZeTysr2FXl5gBMrp0h7gkIGKJXaK4qDt71AYGwPaR3iUM1pNGvlE7Me95kS0BCyyuFw3q2zxFQ0UNLKFfmXRDXMJ7jIp/fXTTmWqWmhQZ3+0rJQbD/rcMVww+fVn+SD+i3EPZSPt3vkWIg1/fWUUF4e+fj3oIIObgvPUkE7b8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH3flca1MKC4btdOX9u3sJZwWpmzF9J2VaCf1oKKe7g=;
 b=g0Vm9YLsfev0eVeszkAg5Kabgpu7rYwTQNSmtNACwqIM9oiUbp0W2NYFFPj1H2m4JpyBipnXgYheO7yczwk0glpf85VBmkuw7/H/ffXWnzZCvgA8AjeIoNJHb4EaBbf3Og9z6yhqAFK1clxaZIhyiMITwEtzOkNqup6bC4v9FoabrBIdYANcH2RNH2eNtMRsNlOrY2O8MAOS74UPHqJCYzLGIweG/uHHG2itFf0uP2VQOBwf+vpIGUsZWrV6kWZ9ackdhqd7GAL2u7T1NNXtwDB2jsWYE2EuDaHIS8mkZFj8W3XKRmL8ad7w6+lzO4uKhsA7x4uFXZbVTFaDcWQdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH3flca1MKC4btdOX9u3sJZwWpmzF9J2VaCf1oKKe7g=;
 b=JYERC1kSu0AB2yqJLLBbORs2ZmtKU4p8xHusOjMuiqevWSlplZnSYUWKQoCrOFv4L+oSYiN3n/oj4mhPRznb4bcvAfQ5gnACo+TMHjhZxqu5+6aqbuy3Vk2A7bVHtzbt4R2W85wfY5nmUHFVTdOEJ8glBFCyVe6cFFqaZiWyc1g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB3PR08MB8795.eurprd08.prod.outlook.com (2603:10a6:10:432::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 03:33:44 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 03:33:44 +0000
Message-ID: <89a2645b-41fe-4717-a08f-1270d8da0863@arm.com>
Date: Fri, 13 Jun 2025 09:03:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests: khugepaged: fix the shmem collapse
 failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, shuah@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB3PR08MB8795:EE_|DB1PEPF00039233:EE_|PAWPR08MB10165:EE_
X-MS-Office365-Filtering-Correlation-Id: a308b4c7-48c5-4665-4f02-08ddaa2b2e0a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UzdNY1RVdUNVVGJ3dGZYUVptVUhmcjFOYi9VbjlxNlk3UlRFd1U5NlFzOGl5?=
 =?utf-8?B?UlZJY25iT0RhekFNQytyenVINllhS1RpK2lJdnB2L2JwdEM1dnRYaTc1NmQ1?=
 =?utf-8?B?THhBQ1NncGc1cjNQN3RLS3k0cTZyYnliWE90MnNGbnVEazZYVTFERndzd0x6?=
 =?utf-8?B?M21xeEJidEhPYkdXaVg5VXJOb1VReXZyaHN5L2ZMMVZjNlpmWmFRbWNMRFhM?=
 =?utf-8?B?alVJN0VRZmlWbERsT0ZXL3loZjNhTjIvQUtRUDJwaUtkTit3Y3FGalYySVEy?=
 =?utf-8?B?N2ViblB6aGZsWng3QXV1Szk0NEZUWlhTdW83N0NjYjdNOWYvMEhaZUlxcXQ2?=
 =?utf-8?B?cmd4M0NPeVhROFVwMkV2dUt6SVNJSFVPbzdIOUFOWE9mV0ZaYzNJVzkzb2ox?=
 =?utf-8?B?YVJzNTVMRGJEc0FFVmxmK2VPYTg2eXVibDR6VnlqK3hNQWc0TGNkdFJ5UTlS?=
 =?utf-8?B?cTVvRHZDRy9vcEdTTzFXempRdnhTbnJMT3VwRkx3ZC9JR1l3b2Jsbi82Tnho?=
 =?utf-8?B?WDc2QXJaZVBWc3VMb3EvOFJGV2RnNzRQZVJLL09nUFE4OGwrcVZFWjk2cGF6?=
 =?utf-8?B?R2ZmbFY0OWFqNUNLMUxHS090SGphVldCaGhHRlRpVEVpcXFPUk9BZ2hOWXhG?=
 =?utf-8?B?Vjc5eE9FOTBvU0hnZUpSVDBFclFkbDdIcGhxNnlJeG1YVFdNdk1tQXVtdjJF?=
 =?utf-8?B?ZEhXVTEvUUpTVUlOSU1wN0JyWFNDQ2FrYVdCU1FEaDliQkI4RzhtcUxwQXlM?=
 =?utf-8?B?M0R3LzJNTE9XRkhpU3FYQkxxVTF4aGtVbnBmcEdud0Nybm1EWWRPZEJ1ZFBR?=
 =?utf-8?B?MTVwTDNPdi82ZnlKMVdXZXVFV003UmwwMUdDTkxtK0NlcWx6dW5DN1haZENE?=
 =?utf-8?B?eXBHMU90cVZlNnJMR0ljVmxNb0tZWU1nTHpqbkE2aHJyVmxMN0w2eXhzekNi?=
 =?utf-8?B?OGFINm9TVlFVb0pocGIrYUhNL2REY29MV0FJaCt3U3hiNE5idkpscHplWVdK?=
 =?utf-8?B?VVZrTG9WcTBKcDY4cEdmaHNuZFpSQjVORVl2aG1ZMmpmQjYyclhCMFRydGJT?=
 =?utf-8?B?OXAxZFhOK3dqT2lySGxUcXVKcGxNZVZaYWMwQUFWMU1SVTNpaHdWaUdLNzFk?=
 =?utf-8?B?WmNCQkF4R09SMUd0azdZdWFwd2RHL1RBSDBWcXhyZGpyV01MdnBJbUhQaTJQ?=
 =?utf-8?B?MXFSV2JUSkI4VXYrQWh6T21MUmlGS3FlSXRIaEM5MWVaa3VnNjdLMU93QUcr?=
 =?utf-8?B?YjBxTUFxNEVNMTBaSlgwNk42aXpWNmYwOFpRNHA2RDNnVVdkZTBiSnVYWFdv?=
 =?utf-8?B?cUxLaFRUYW1kTldhVnRGRDBNTnZwTmkzcTRaQXBQQXRQa2s4ckg3ZUlUdFJ0?=
 =?utf-8?B?UmpKclpoRVJBWTRhMjQraEoxUXU4ak5udmVRdW5JTUUxSHp4NXhYSUpJb1VT?=
 =?utf-8?B?SzlwM3dUcDl0N3d5QzNVUFVXeFVlWVh3VHJTZEowcmpUdXV5eG9nQmJvNzFm?=
 =?utf-8?B?ckhTdC83UkhDSFVIS2VQV0lCZ1lvRnB4UHEzQkhrQm5MaGNGL3I0QUs2dGtW?=
 =?utf-8?B?YlI1L2QwMzVnUUJXNG9IYnYzVDRqOEFPWWhKRHlzb1ZyWWg3UjZBY0plM2VF?=
 =?utf-8?B?ejhDaUFEWlhWS05QaTFFVUw0ZXpxbzZabHpWZzlGSE5Ta2lMMWs1d3Bqall6?=
 =?utf-8?B?NmpRV241T21FTDV3d1JmWnpKa3h1MEdnQ0wxVXM5K1lPYmxrcFhVVklwOFdQ?=
 =?utf-8?B?dFQ0U2VxYTAzMVFlNWlpY2VySFNCUVhvUFR1eHhNRDJtb0ZQWkYzeGQ1Q0F0?=
 =?utf-8?B?aFRTVEtyRkNaY1Y2azVOUmZWOTZJNWFtOU1LM0tDaUgrUyszZytoTVVNV0Nr?=
 =?utf-8?B?V1hvM3IvaWVkK0F6S0t3dU53V0FJbDJrN1grOVhVeHcrdXc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8795
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	398fcf9b-bc9f-49b4-d128-08ddaa2b1929
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|7416014|376014|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNZaHZyWkZ4N256WkxVSDhkUGxLampLWi9KYjNPajJQeDROOWEreThKMEJW?=
 =?utf-8?B?Y0ROSjhPZXBCRnRWV3VNdEkrbTROUmxncjNmeEpXYjNuZGRWaE5vbHE4ZURi?=
 =?utf-8?B?akpXcEdaV25tVzNMb1Iycy85cUZ3aEJUaDNZd1ZybjRGTzdIcmw4MDFtcGRF?=
 =?utf-8?B?dWxYZGM4a1NwT3djSlpvL1VwQktGK3J6Mnpjb1k5WWFLdGdVM2xCemFpVnNL?=
 =?utf-8?B?MlJ1dG83S1lETWtuZm9lU2tCUjhjQzBiMDdnbmpXZVJPK1k1ZHNxK3RyVE0y?=
 =?utf-8?B?L3p6RHZGbERvNG03bEllUUErc2hzSjVSWDQzMWZXd3JvallBZjlSTTVuNHBN?=
 =?utf-8?B?TkhVdDBCWHhoVklRVXlkdzdra21rVGtEckNFcE1aUFU5Sm9QaWtPNitrZFpD?=
 =?utf-8?B?ems5VElLREFyV3R2ektvb1AzU2dzQXNXQnBLVnlzeHFOcHg2Y3VCS3luR1Fj?=
 =?utf-8?B?d2ExcGJmaldvZE92blhPT042R1JNVjhGSTF3K2hsbDhzRTRoOWNoRmtpREMw?=
 =?utf-8?B?eXNEUjI3V3lMWG9LTDNNSGhoQ2xsZkhCekZzV0VMLy95TmdOb0pvSS9yeHdX?=
 =?utf-8?B?MVFGUk9Wa2l4a1o3Wm4rUnRwVlFFcnZ1Zm1vN24zejRZSk92NmVYTEIvcXJz?=
 =?utf-8?B?RlEvTzUxbmRrN1JabTgzd0NRclk5cFptUi9PVTNKREdPd3Q1T1Q4clRLajk2?=
 =?utf-8?B?Ynd2N0R1MWhWeHlUWWwxc1pCUG5uTXFvK3JRQWNKVGw1Y3hLK2V0TGxjNENw?=
 =?utf-8?B?VHJTQXoxOFRyQk9DdjhtaEdNTHN4ZmsreDhIM3RjQ3NlMmhFNEIzQjNHVElW?=
 =?utf-8?B?UGZqMkg2cTdOSHpJaHVKRVlpNGQ3ckpqTzc1QnZWS05ZU0MwNEtoUUllRGdJ?=
 =?utf-8?B?TzR4dG1DYk1tRytKOGxkcS9td2dETHVNRlNZYklrcnFodVNaMDBvSnZrVnV4?=
 =?utf-8?B?V3JOYlBBeDJuam04eHk1dmpIc1RWc0ZBbjR3anVscmZSODU0MnhOclpGbGZI?=
 =?utf-8?B?ZHRGZ1oxNVVPZ2Fhdm1IaTZ1MEpidG56eHBBOGp6OXZ1aGVSVG1GVkQxMFJw?=
 =?utf-8?B?QnFWQXUxbjlxOEtOOU5IMFpzaW9mdVNlSnJ6QUxNRktycDVZK0xwYUlNMlpx?=
 =?utf-8?B?M0VXYmExeXF2QXU4R012SjVBMnpnVlJHVDBoNG5jK3NtS09JT2dsU3ZjOUZF?=
 =?utf-8?B?Nmw0Qm5EZWp3Q2Y1QXN0ZzE5ZXdhWlNCcHRpWitUS2srWk0xWTJNWTBRN08v?=
 =?utf-8?B?U0dRQ3d6V3N4TWE5ZUpYa2c5SkhxMmkwV3dLVVF5YzcwekFVQVB5YW5iL1lM?=
 =?utf-8?B?cnl2aktKZUZlRXFOd0dzSis5emRkaG0zdGVGVHhGZy9pbnlER202TEV0eVo2?=
 =?utf-8?B?L3Q1aWxGY3NYdytuTy9RTDkwV1QrOHNaTFhGRk1QTTdIM2Ztek9SRXVaTHcv?=
 =?utf-8?B?aGJVRkdYcVVjZDBmeUZMdXZhS2g0Z2ZpRm9LZTFxN3BDaklBMHdzNEpJMnl6?=
 =?utf-8?B?bUx5K2ZUcWtoZlJDRXExRzJRcXk1RGhNSmNDcDBodjRRL2U2d21jU1F3WGg0?=
 =?utf-8?B?SHg1eXRUSnpxMWIzdFg2VjUrRDRWQlZHUUxUOThFR2s0VFd5V1BjRFdjSDNO?=
 =?utf-8?B?bmthSE9OVFVXS1F0S01RUHlJNnV0dlZQR3RlK3k5UFhMVjROZ3NjaXRKZVNZ?=
 =?utf-8?B?REgyMkk3YnpTdXlSM3ZoaVptUE1MUW5ERFA2dGg3WUozR1R5cTVoazZ3YllL?=
 =?utf-8?B?b000UnVaWTQxaTNoY3pPODY4dkI1eHhmUGxTOUQ2QWNmakw3VS9aTTdmRW5Z?=
 =?utf-8?B?OU1rQTJlbFdhV0VCa2J0S3U0VHlNWGJxa2hnbFp6U1NldnBBQlp2RzBmSm5h?=
 =?utf-8?B?dVZmT01lSnkxTUprQkRZOGRsMXZsVllQRnNTOXk2d0E3L3VDMjdxbDdRaUNy?=
 =?utf-8?B?bWZKTTh0UzRuM0phT1FqUm1WdVdEMmFDZHBnb2lJWHNZd1l5c0FEOFV5cDRF?=
 =?utf-8?B?NUNTV3pxZW94NU80VTJPdzd3cXMvMSsyenBxZ0hOQ29wQjRZMkFjNFFja3d4?=
 =?utf-8?Q?S0G6wo?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(7416014)(376014)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 03:34:18.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a308b4c7-48c5-4665-4f02-08ddaa2b2e0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10165


On 13/06/25 7:19 am, Baolin Wang wrote:
> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
> I encountered the following test failures:
> "
> Run test: collapse_full (khugepaged:shmem)
> Collapse multiple fully populated PTE table.... Fail
> ...
> Run test: collapse_single_pte_entry (khugepaged:shmem)
> Collapse PTE table with single PTE entry present.... Fail
> ...
> Run test: collapse_full_of_compound (khugepaged:shmem)
> Allocate huge page... OK
> Split huge page leaving single PTE page table full of compound pages... OK
> Collapse PTE table full of compound pages.... Fail
> "
>
> The reason for the failure is that, it will set MADV_NOHUGEPAGE to prevent
> khugepaged from continuing to scan shmem VMA after khugepaged finishes
> scanning in the wait_for_scan() function. Moreover, shmem requires a refault
> to establish PMD mappings.
>
> However, after commit 2b0f922323cc ("mm: don't install PMD mappings when
> THPs are disabled by the hw/process/vma"), PMD mappings are prevented if the
> VMA is set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings
> during refault.
>
> One way to fix this issue is to move the MADV_NOHUGEPAGE setting after the
> shmem refault. After shmem refault and check huge, the test case will unmap
> the shmem immediately. So it seems unnecessary to set the MADV_NOHUGEPAGE.
>
> Then we can simply drop the MADV_NOHUGEPAGE setting, and all khugepaged test
> cases passed.
>
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

The test converts from fail to pass for me, for the aforementioned failures.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Dev Jain <dev.jain@arm.com>

>   

