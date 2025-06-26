Return-Path: <linux-kselftest+bounces-35811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFBAE94D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90B6166EAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A220CCED;
	Thu, 26 Jun 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="apnv+SQ/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="apnv+SQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D917C219;
	Thu, 26 Jun 2025 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910592; cv=fail; b=urTh7xl7/LmgPZs3WfhbG9d8xCzeld3j0ATfCjBi8GeMIkwJlRwoOfcUID7xGwJIukDm/F4+Cbm4JNF50ddLkW6vlai7/rtVZ34sqVZZRctJNvsaU1zp4EGsI/SD9vDEA/n1Dt7uMnoR/1Cr9PBKsyQgLwGKwNfiMyDH0eQGJaw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910592; c=relaxed/simple;
	bh=hlu1BPsOGk44I+78AmNfHDbqoJllyKsnjXKZfw7xioU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gG8i7z4o1mOPhd1NafUZIGrI3W513q830MRKxOH2epJ29rbjqLTzPL+K2wDn3nNwk5uW16lzOO/NFhseiNo5RCyD0NZTp4NL9uNt+tX7sAVpyCJvp9FxGJyea49BFdJNEz139umEjlKQ5im/sjsMwl3XhKr/xaY7cwPvR+ywxcg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=apnv+SQ/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=apnv+SQ/; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TccHFuqcgudMuP6Q/E4Sx0lxQlZG8HnAn38Gy4OzipYyVCRO/q4RHPX7RxYu681AXtBdAix241E8gfGclubU+2HrD0WMNUz8pMfEwVHr9TVaMvAlZjAwQFuilGncXF6t3cZ3JDBjdTbt+fHnZE0FqMzMTso0HuUg1DsZq+gDk2pi4xZ5SevQM2/UZcbtLRA1JXIC731uEDVIoXrq4pmCfcQB5Zjvz5ib/XOLbObyrx9cnxqN5i1vxD1AOgBzg5/S6Tg3dAspGV8U9m4IFrzbeIDkSWaG0DU8+haL7sG3r2LNLbbGns5PSTOVkJdLso3OnAOJ15LfT/wv3SLqMGMCPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=100ELhDUKSeNxCb+WZjIor2fQThzKBppu3DS9tnmJQE=;
 b=dTkHzzrRS0JbWT61FPeH76sKHju3XfXIS0d/YQevrhTiCabNTmRMw1CY3ufMJbGV5HOIEvHgWVw6y3cxEydcCBuOBmogZSzPy21nZ0IKh9sL+zyjNiXpxDtwpiuLg0k6JDItxrSMJIDt/30o1Pv6tWakC/A1egwX7YKsCLDrEKsQkBleZtMKnBwL4rktVgLWu85ATwmmjvYrUuQP0Y72fiSY6UiCnEk6bnV80/w6Avc2DOMZZ9SvN7U+UChIG9+pEPrrCwJjOdqzRXaC7vR9q8X8W8G4tw69rW+GhymLlHbV/90npjuV9cG0hvaU2WNeIV3lfHngCnG80js8oxgyYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=100ELhDUKSeNxCb+WZjIor2fQThzKBppu3DS9tnmJQE=;
 b=apnv+SQ/7eR1DiuZ3cFsNoflf72vVjdv+D/bczvGscG2evjnF6dXy7BEQxzO2qn1pD5lN2as9mOWvlKdn5sZlp0SEBDv3ySm/JMB+3MDb50kfPTX78oZLfFNZTS/a0IIMtKPSqEZorsE8GNkkHWah7qb1Z1w3B0bltEp3yHm7Kc=
Received: from AM0PR06CA0127.eurprd06.prod.outlook.com (2603:10a6:208:ab::32)
 by DBBPR08MB5993.eurprd08.prod.outlook.com (2603:10a6:10:1f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 04:03:05 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::58) by AM0PR06CA0127.outlook.office365.com
 (2603:10a6:208:ab::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 04:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Thu, 26 Jun 2025 04:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7tMDzzsT92R42LaCvpLuWXZRRIornLgLe8v8uzwt9lvZv2R3EIUiVSttZurPZpiG+rlrkmo8yAvRhi226zOfzLjoyjxkNE2pa9tZtYUmgNmzda9bOme/gXTbapgspxlP5zn9g1ankP9otFRZI6CARmBHfy60bfbHa5AF9HsBS14Z2sdw93hf2RaAZ4Msboh3NGwRltuQHyR8Ltg1iS6MSFuBAcNSPNhLZugZzhGUZdFpjbAHhpEHCWDZ+F4t8SmwtA3+9fntnnQgr3ok/MZ5lybM8ANFj/fL2EM5UHVRTBybzUoiA8ZlBzxuUsee0oiqf1qF/thc+3sb7r3MJOpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=100ELhDUKSeNxCb+WZjIor2fQThzKBppu3DS9tnmJQE=;
 b=LbiBVMMA0mLB83+iXaY2uSV1yFLEdhTmK8EikgME1vJGo78wrMaBoALnxgiW232OsZ/WsXsYI4Fb8OErrgkQRNQ71I/7wrGyh6vNMNIWxkm1Fd0b23WIE149Y2AEu+Gm+RYuM8ZPe9hvfffBJOx9mOfYHvOtVv200uPH8VsfRVjs+caswJ1afYED9uHk2iFB3kvFFPQuTWj8KMat34qwmTlLlGHuidWJiiZP9+AFxf4nHRUMh1C0AQM5dQk0l6RH1FKek2cmdAS2rqrtbQrSac6akXDHl8lKe3+QPVpGqDvub117pW0laQQ5FXk0eqH2r650Ux4QXpAd6bweZGA2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=100ELhDUKSeNxCb+WZjIor2fQThzKBppu3DS9tnmJQE=;
 b=apnv+SQ/7eR1DiuZ3cFsNoflf72vVjdv+D/bczvGscG2evjnF6dXy7BEQxzO2qn1pD5lN2as9mOWvlKdn5sZlp0SEBDv3ySm/JMB+3MDb50kfPTX78oZLfFNZTS/a0IIMtKPSqEZorsE8GNkkHWah7qb1Z1w3B0bltEp3yHm7Kc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PA4PR08MB7570.eurprd08.prod.outlook.com (2603:10a6:102:26f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 04:02:31 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 04:02:30 +0000
Message-ID: <ff213ab4-8d3c-476a-83dc-8cc74c399f88@arm.com>
Date: Thu, 26 Jun 2025 09:32:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove duplicate .gitignore entries
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, akpm@linux-foundation.org,
 shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250626020758.163243-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250626020758.163243-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PA4PR08MB7570:EE_|AMS0EPF000001B7:EE_|DBBPR08MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c0d9f7-f789-4fba-618b-08ddb46659c4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eEk4Vzhxc0o0ZUxleURZc0xsb2JPUCsyZ3pUUHR2VHdEeHRrbjB0NUw0eW9G?=
 =?utf-8?B?bEZqMTkzTU5lR0c4bXQydk9YbGdRbkNkQVFaV2hiZ3dURmhwRUhJdzhnVitI?=
 =?utf-8?B?a0pyTG84RmZUNzVtalg3N3ZvNUNHbi9rSmFlSGVBUzI1NmdGRXFZTFdkTU03?=
 =?utf-8?B?MDJ5RjNXcG9QUlJ1TjZhYmNRejRSSnREQTB5Q3hXaFFTUFBKVFNpOHVCQzRa?=
 =?utf-8?B?b2tES1JSQzFuUFFwTGlxU25RNzZxRGpjWitGdGJmY2RWVUhtZjBHQk5YN0tj?=
 =?utf-8?B?NytOTGR5VjVzKzlkYkp3WlhBZWRGcVA1UFlGRzUxS0o3SVZMNnhhNXJXak9R?=
 =?utf-8?B?cFp4b3FSNGJDekM2dkFYQjJ6bWFHYlFHZVZRai9CaTZHZDRUS2RuREFDazBV?=
 =?utf-8?B?U2VVeE95RG5aaGpvQ2Evc1FZQjNCNUZQL3d2Y1d0TWVjMWR3bE9tUjIxSS82?=
 =?utf-8?B?UElZMGRJRkdHb0NUbHY3SSt2cWl2SEt2enJ5d3NSMDZiYUFEVlp1eG96ekRy?=
 =?utf-8?B?M3F6cDJqYXdZbk5HRFpSdEZUd3VuVmUxSGtoMWFKTmFXSzM4VVp3NkxVcEZU?=
 =?utf-8?B?YXV1T05VZWhyV0NWQ3Z6VHB3bkVia3BKc3l0ZnNPdDdFVEdSSDBxbkdKUml1?=
 =?utf-8?B?VXZtc256RGFXT3hhZGRMTDRvK0UvZ3VTRng4UHdBZkR0NnMzNXhqL3VFcWVP?=
 =?utf-8?B?ZHNZUUFPTy84QjZpRTNzUzB4YVFzK0R2a2t2bFJCekFHWTFCM2Q1UW9XVzFB?=
 =?utf-8?B?Q3FVYVhya2U4S0xDTDYvZForZEs3NVFkM1JKeWNXeEs4cGlTWVFoNmpSZWsy?=
 =?utf-8?B?YUFGa3ZRWUJlWkl5c01McTVmQTZxTWZXcE5oYUo5UWFCNnlQc3c5UGtENzlX?=
 =?utf-8?B?Tlo3VzJ2STdnbjgzUVExSlFCblZFR0lUc3FGVVFQenlrZExtZUFEbUFIMjhQ?=
 =?utf-8?B?NEZ6RDYrWDFnNE9OT0xNd2tmQ015WnM4MGZiU0FuTFJNdWw4V3hoSWwrRG5r?=
 =?utf-8?B?K2pBcnp5b3dZK1FLNEFsdUw4OVNwd0tsYlBGZUlLQldrTzRlQm9oS0N5bGdD?=
 =?utf-8?B?anNucEo1N2M2bnJzdkpKakFIUzBQN1NZK2QvNCtYTW92dTBQRS9GaUZoTGxJ?=
 =?utf-8?B?Q0FVeFlPcFp6SVR6UCtLTmNObDZxVnIxVnpaM3lDQjR3NjJZRE1XellHd0VW?=
 =?utf-8?B?UmlCTTRvci9BeURtem9aVnBwUGk2SGNSYml5SFVEd09MeFIrcUFqOFg5MWZC?=
 =?utf-8?B?TW41a054UTYzVW96TGFaZVVmYVZZYUw4dmxFclNUbmY1Q2IyUkN3U3FZWlQ0?=
 =?utf-8?B?NEc0a2xrNDNwU1pBMkYrdXlGSnhCdDRoK2dyMGoza3RPQkVXaTcxdlNHZTNL?=
 =?utf-8?B?akc5NW05ZXQ2THdvbXRKTFo3bTVONFhYMURIQ000NVV2d05CUERFcTIzL21C?=
 =?utf-8?B?Wkt6dGp5dmFUKzdjbHJoblNZSnBqUzBNbXJkQjZqcktRSUx6QW00ZjkyTlJQ?=
 =?utf-8?B?aUpWNmlhNG1UTnpWWEp2STlWN0Q2VllhMFFNU2d4cHRPeFVsTkVnWG15ejVS?=
 =?utf-8?B?VHhUSDFmNGVUYnlxZEJDYXdpbmNyNHgzeUpzNHplZ0ZCblNxeUJzUThzM1ZY?=
 =?utf-8?B?ZG04czZaa2xGUlgwUlhiVTM2ZGR6MEtPSlNZazJ6Y0tSNytPd01HYVFUMy9Q?=
 =?utf-8?B?Mm1zMUZrVE5ZN3FDSWE3M2NEeHlvUi9PSENJQkIvYVBkbnpxcTNPTlVhdmxV?=
 =?utf-8?B?M1FrZjhEYUl1MGhDNTZabCtxLzMxajJJTlQ5OXU3RnB1MzVpRDdLSG1ueDZT?=
 =?utf-8?B?TG5SbmkwaFEzLzlFU3ErZlpYWndBOGxKMTJpNVpzSGxnNUlIL2FxTUxZRFA2?=
 =?utf-8?B?ZkJqd09Nc0l6eTZidGUzeFl5VTNEdk9RY1IxTlpkMXYrQ3YyNjlZRDMrQ3hQ?=
 =?utf-8?Q?zQJmu5EF/NI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7570
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	00e91964-7407-43df-f004-08ddb4664574
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|376014|36860700013|1800799024|14060799003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHJ1aE8vdmNrbTQ4MXdzZENBNXV2R1VvWXRhTGFJbUgwS0l6SGhZNFdWUE1V?=
 =?utf-8?B?WkFOcmo2c0JhRVdWZzFzNXJSakpUbUhCV3FYMmZqTTlCU21xVnMvUWpUcmpt?=
 =?utf-8?B?U2tKV2xNdmRSQkFLeHN6V0hOZkhjT0YrNWF0bHZQY2NSREhLSHpDMmFGZXVM?=
 =?utf-8?B?U3RrZGo3dTAvUDlZQUFrVDFKS1NyNEtQL1VORDBqT3NDVnIrcVlweXhoamdz?=
 =?utf-8?B?OWtWeFdoZUF6N2lhdFp3Nm5zMWJnbjI3L3VSeXdyak1jSEZ4YUFJa0Ribk96?=
 =?utf-8?B?SFM0bWo0ZjhhSEZFc2Z3QlM2eExXbmFOOWtWREl1M3VEMXdzMDRjeEQxdWFp?=
 =?utf-8?B?Nnd4WEFVeXZld0tsTmtqTjZMMXBSRktJT1NoTk9TcTdCNnFMZW9vamlzMUtO?=
 =?utf-8?B?QkV5NFMwWkxIQzVEWVZGQVJlOVMxMkdoOHJZQXBTV1IwT3N2TSt1MDZydWVS?=
 =?utf-8?B?bGRxd2psUXZZUUgzU1JMQTZlR2QwTld1MmdodUtYUUM1SVJwMWVKRlpKUitj?=
 =?utf-8?B?SzRDQ2Q3Y0UvSGg5dDZXQ3IzM2NzQ0hyUXd0TWNoNnQ0Rm5WSjBGNkJLRk01?=
 =?utf-8?B?a3BSa0xxYXZYZEdPYWh0cmNIV25qYkNKSk1wUHFCeGR4cHJJUEJaQTlTL2s3?=
 =?utf-8?B?QzAzS0trczM5VEdYb2t5c3J5WXZMbjZHZGJVSFBYbHpYUFg3Q1Z5MUM2R3pk?=
 =?utf-8?B?UHRENy9CYTV6czU1L1VId3lCaFk2VlZMMmZTci9Nams5UkRhNEhMYmwrV1JN?=
 =?utf-8?B?aUw2YUdIdlhUdjRQVnJUNC9QOWhlUzFrTDkrdG15SUZORXloRFVPVzNNTm04?=
 =?utf-8?B?clJPb09Ucmk5ajl4U2k4WmJTWThqUE5mM2dkWlVVL0RTWDZOMGhVY3VsYzhG?=
 =?utf-8?B?anIrNzRuVmYvMW03YWI5RHFHcUVBRkdlWUtzVTdXS1dtUGVPaTFKOTVFSFhS?=
 =?utf-8?B?a3dvekVINnNOaGNhMmlNeFVOMmtReXFWQTd2MGhZQnd5bzcyWEVvNUl2L3Ax?=
 =?utf-8?B?RG1lbHEzMmtycElUS2dRY2Z5QThDL1JPSWdwUSsxeXdBVkhRa1lUN01ueXZZ?=
 =?utf-8?B?MkJIU29wVG5uQ2hBWFpHK3FyNlhNelo2OEtjS0JTdmpDNmVSdXMwMzBwVXR1?=
 =?utf-8?B?anByRERFekZTSFNUNnRlYmlFWjQwOExnd3VXcm9YbDJVS1dudUxLa3NIQm93?=
 =?utf-8?B?YVBXamMyclVid051ZHhJZ0s2YllZd1dvOVpyTnVpWFlNenZtbXZWUWFZd3Jn?=
 =?utf-8?B?dUg2NmFacTNTeHorUUI1dVdUUHE4RVFINHVDa2dxOWN4cDlPTW5YR0ZUOGYr?=
 =?utf-8?B?NVpxbGZXM1BwajErSlc3aFpQMW1JdUxUeDBWdmRyQ0tBZGEweitReUlhQ1g2?=
 =?utf-8?B?cTRZZWZrVkZ0TG42NDRBK0wyR2VhRUJTT1oyVVV5Tm45cjgxTmxwUm9vaUZB?=
 =?utf-8?B?TUVUWktkdFZqcitMZmFKS3FVT2lxZ0FkbE9nVjk3WGw4WXg4MjIxKzdBSXF1?=
 =?utf-8?B?Ym5vME5QbnZlSW9sKzJSWitHK29Jb3NIYmExbXVEQWV1akt2MWdpM2ozT0pW?=
 =?utf-8?B?V1FtVys5THppT2lraVNyRXB5ZjliQUc1b2RMWURCd3ZRN0gwSGxpTDRaZWFU?=
 =?utf-8?B?SncvdTNVV3FVc3hvbUxTaG5VaUpzTjNjUWh5MEtsbEhiSldtOGdPKzMwbHh5?=
 =?utf-8?B?Y1ZYYlIvTGtJOWZqSFJvbU5GY3FPeFI3eXRLQ2o4b0c1SjQ3bTN3K3J5SGdR?=
 =?utf-8?B?SWhaSjhxbDFNbnhGejAyd05vWXhObHBldHJiYkdMMDdTeFNjVlp0alZsWUVl?=
 =?utf-8?B?KzZPZEZwNmh3b0x0SjFnajdjTkJqY2dyeEZIUG1reDZZaFk1QVFGU3lFZWNE?=
 =?utf-8?B?TE9KblZXUUdVVS8vZjE3SmRNb1dGRXRXMmpUdkNnZE9kdm9UQzlDUkJSSEJY?=
 =?utf-8?B?cWRLaUhKd2JmMndIZE80NzlBWmIyQitpbDFJVStXcXpPK2VPWk92d1pDR1hj?=
 =?utf-8?B?dkFEMWt4VmJyQnpXQ0w3eU4yOU56eTFzMCtuNDN6NUF0SU5sU0xsWlc0WXVK?=
 =?utf-8?B?YWlGVjFxNURDZkMyU0ZnMWVueEs4MWlmMFdqZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(36860700013)(1800799024)(14060799003)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 04:03:04.1226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c0d9f7-f789-4fba-618b-08ddb46659c4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5993


On 26/06/25 7:37 am, Moon Hee Lee wrote:
> Remove redundant entries in .gitignore confirmed by:
>
> $ sort tools/testing/selftests/mm/.gitignore | uniq -d
> hugetlb_dio
> pkey_sighandler_tests_32
> pkey_sighandler_tests_64
>
> These entries were originally added by [1], and later duplicated by [2].
>
> [1] https://lore.kernel.org/all/20240924185911.117937-1-lorenzo.stoakes@oracle.com/
> [2] https://lore.kernel.org/all/20241125064036.413536-1-lizhijian@fujitsu.com/
>
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>   

The two patches have a difference of 2 months in posting - someone must be running an old kernel...

Reviewed-by: Dev Jain <dev.jain@arm.com>


