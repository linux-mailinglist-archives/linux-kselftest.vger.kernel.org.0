Return-Path: <linux-kselftest+bounces-41020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187EB4A235
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015D41883D40
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E12FABE0;
	Tue,  9 Sep 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nwrXrGnG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nwrXrGnG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE008235074;
	Tue,  9 Sep 2025 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399279; cv=fail; b=epLAZJofY54ZysZrGhh3E4RtLQtHuAJSTQGCfE1GGIT8JUVsHaK05CT5k0t7sHPpO4KIZUERPaWu/KfS559GUfFK5nOMy/0Jq9Utnqqv+V8cdcvZ5G8fG55oZ0hJJ1+YhJz/yZ5i7Vo8t5hU3oYtU1ktZkHHnp03f15QRBpNanI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399279; c=relaxed/simple;
	bh=PnLicTGWHbYW5HHmi3Zj42Cg8UA2IHyUEKYK3zqXD90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pE4emG2pkvcjbIdl/3TNV/lUMLuP4gNoSrxSjPC3T7SQ3TY7oBLwiYT2Js0ZZJ33YEtpS5JPPlW45UpbIcgCpkEagq4UK0fMopdnMKf5HDrujKaJ9/CvcP43p0dOvRj8zRPMx+pCbwR+I6qoNUv5mIEo3fIztXWwOnJjc3OBG2I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nwrXrGnG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nwrXrGnG; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c8IJJEk9nEX4G5PLjhKfTl6BITLgtI2ybGjfQnIwh0ddgpEQB/Bsdd33NmtNIXUYnsyCA23Hsh9mXXxViCUBGmBipQxiD1aru1dBBDt3oChNFk+cb9W6YzwfuQzCtozPoOY0Ohd7qiMh1EasDdp1qXrxFKejdQTHw4OaBjweRBQ+rmVTozJ9IDDUJNrwYQFSpjXthCpqMe7w/A/Sp9DamQBSa/Gqu97a5e3noKCqc7tTTs1/zp4q3wmC3Yi4vqwVZsXkXxgN2KU8VPH7eTLNjQOabtXa8nSOuDg0oExsYZOFKKRMF6EfyqJ5WYQImXm2up+/NV/DPAHMAxUJ01A2nw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwlYbybMx/gJZU3yDVlptA+p+CgnHftpFPmOdtymDH4=;
 b=VbldMbC8KzulZBnZM8wBmmUorSbZeYOYORK0RRKj4OZcTz7CxhsjhiV/qUdpVWJY0gu7Yv4DVUYX8/m36OSq0VUM6XLfC9HXAxN0Cv1qhPbIjlXRpH5jP/zrONuIRUTJ5qXW7cGXWz76TkFy8ZYAV5P/dJ7ctx40lDddbeEXe+hvPI2Esfmn4giK8OiL/cZsCVM0k2suwS2LYOBUiqezrLpK5AJHbq3rCCdhhYtGeZ6XWzz/IZnb4EUE+mosFRs19d2rz8aqpQ2NFXNz9dTFY4sHyzmxPuAiPjZfIN+YEZsteMz+QFwSBsxuQV0n+IOg68Fr9XHd44nZ31x+0k+xHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwlYbybMx/gJZU3yDVlptA+p+CgnHftpFPmOdtymDH4=;
 b=nwrXrGnGE/ApUbmgVzfTNi10fvQ3D/Jj1ydvfIE7P2g+ApPVvgg9zCyD1lf3gPDbzqDGX3KDkPL+aIVOyNqQpO3f4lqUrZhLk5vZVQvheM737l1vrpFWBlkMepMmhkTYgJ1qhVN+CFELxyUG8djtQ6Qr3SSFJtWBOVmAj60o1ic=
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:27:50 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::54) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 06:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 06:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chn+yakpUSGd8jfW/5mggTmCY/zxgfQFokvjKO+VVV8aLUkog50pTxKijAjPLzW/kj7MCM+Xow8A5qsgccNORbAfAjD6SLqsW/BO5NG9bkAxGI2VbBSRJY7gjkGCzzlART3q7BJyiQXeJUYfMxM1DSi5M1RGmVXDyjegJQZpWC2R70AIIFk8Qjuw9Oy5C0gLF6l92uqlP7KHL1s1kXuzCd1TZGw7mYoLcC/UiqLMA4mZ5E52i+SaRo3j8uItFBBxUJLonlwK2SpU+QOZkPiLROYkYLXJkV+SX6oWQ9CcNyllMK1SUZOd7spp5ursBTjASDu1dIGNxMRvrI6HbdYswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwlYbybMx/gJZU3yDVlptA+p+CgnHftpFPmOdtymDH4=;
 b=jMPBUV0C9ZTJSevlVoWxMsboCApoKknRFJbrtHiMwev+BkZ7Xc56QKSr+ep/jXn51l9peHYZ/2ZymN2PuQoftVm8QQ24JHCEnbSVxU0H4FzraCc5ljv/nXYXOBoGi/oCwKdLmo0DwjHfmdyrqJUeNTTYQTIjz1tfNPzCp4ZaycJ1lGJ6wbWR7ys6YxBjHZ2JBZpEt7ux4RmCXKaOCjUb22hMZwsK/P4KFheHPGiPp0zl6fYPImyUdL6qhsXd5RJHsJ3Lz+GlxW1wWbYVmFQPQUwKzhQs0x2HXraza13fYrDYm9Cac/gxD3tYTnU6MxuvPAjfsBXH86NNJRbMxeJL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwlYbybMx/gJZU3yDVlptA+p+CgnHftpFPmOdtymDH4=;
 b=nwrXrGnGE/ApUbmgVzfTNi10fvQ3D/Jj1ydvfIE7P2g+ApPVvgg9zCyD1lf3gPDbzqDGX3KDkPL+aIVOyNqQpO3f4lqUrZhLk5vZVQvheM737l1vrpFWBlkMepMmhkTYgJ1qhVN+CFELxyUG8djtQ6Qr3SSFJtWBOVmAj60o1ic=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB5PR08MB10061.eurprd08.prod.outlook.com (2603:10a6:10:48c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:27:08 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:27:08 +0000
Message-ID: <bb746eec-9788-4c42-af45-ffc0f11d0182@arm.com>
Date: Tue, 9 Sep 2025 11:57:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] selftests/mm: uffd-stress fixes
To: akpm@linux-foundation.org, david@redhat.com, shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, npache@redhat.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909061531.57272-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250909061531.57272-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB5PR08MB10061:EE_|AMS0EPF000001AA:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 28966180-bf11-4ffe-3eef-08ddef69ff28
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UkJvMng1NE01enZBT3dNQWVobEdSK0V4MlBjYWlNaGY4YTBNcHVIMi80aXZP?=
 =?utf-8?B?Tjl4dFRFbG5VUWFwVlFkL2hKL2poQUJ5MFhqZ1dYNlM3VjJpT2Y5UkNQN2RT?=
 =?utf-8?B?MEpjV01WUlAxZDdNR2NiTnFzSm4vWVU3c21ZTFFRblRoMWY4NTJBcWQ4M1lt?=
 =?utf-8?B?RkdHaUZ0REZKUFYvaVNLZUlzaCs0R01jNlhyUzcyUzlEci9hQU9uaFE0T0JS?=
 =?utf-8?B?YmpGN29nMlBGZzF2ekVSbGVkdis3bEwrYVdLeHFwQi95b1h2dnAxMm9YbEh3?=
 =?utf-8?B?WUtWRmczZm9oU29zcDJ1UWJ0S2toWnBCSEJsSTl4ejYrOURqQmpqUjNtUXVQ?=
 =?utf-8?B?YlBrays5Z0hqbU96cFRsQUlpVlBMeGlJcnpjcm1WVGdZaHpkZ1FVSzJKeUJW?=
 =?utf-8?B?UGJYRDBneW02aXdMU3hUclpEUEhKRFZOTWxTVys0KzJ0RnJQUVZuYXMyMSsw?=
 =?utf-8?B?a0JNaDM1cnp3VEt4eTg0R3pkTTRpZVZlUlZqUEJzV0lsaXZjU25hMTdsalNG?=
 =?utf-8?B?d0xHZkNvbFJ5YUtCMGtzZ1dLOGc3bGRESitrY1paVDlFUW9RbytDdVRqWG9Q?=
 =?utf-8?B?dE15WmxQT0dxUlUyaHBCVlNKVCtHdjBGN0NUYnVHdnBPZVU0N1ZFbGtiMG0z?=
 =?utf-8?B?UjJnaEJveVVCb2VoUXBIMXlGWWxLVlhxaWpLRnp3WDJ6UU9GOTE1emJLZDlx?=
 =?utf-8?B?Sm9sMjJXNzlmalZpUW55SEpWMmdkMU9sUENlbVBBQlRrcVdWRmFqbDkwRTI4?=
 =?utf-8?B?MHdOc2VpQ3g4NCtyRmw2eXdhQVhTZldpTGQveGErRjVKSm1nQVplVXE4WnlS?=
 =?utf-8?B?L3NJbllrUmw5VS9JR2VvSUZoSkQ2aFk1cDAvV2IzMFJEaFhNa05aNDNvWENG?=
 =?utf-8?B?NE1hbFp5Ti9lRU1FL2cxYnU1d3lGVWhYcThXeEpsN0pnUHRsNzdxK1JlZ1Ns?=
 =?utf-8?B?Q1l6NElBcjVzSzUyeC84S1Z0ek13bXg2QzkvTVpSVUQrVXhnUDU5aDFyQ2d4?=
 =?utf-8?B?WVdIUjFyUVhJcnhMZllBUGZmaklpZWtSeExDK2ZtRUpMMVdCa2I0WHZ5SUk1?=
 =?utf-8?B?QnM3MVJuRnlyT3FSUW5YUEttbXFJTmtyMXlRa3V6bFVUZHBLcFBqZWpuQ0ZV?=
 =?utf-8?B?cW9xZnBSSVlBY3pncFNvRVFQbVZyNC9mWVU2cFRKTXRvUmUzSHFYcHZ6N3g4?=
 =?utf-8?B?eDFYTTlDN1IvVURKNVhETFIzWTlldzZ1RnN5SFhqakNqaTZITVYzK1dhNnU1?=
 =?utf-8?B?RyszYytIM1J0cXNoWVhzc1M5NEM5TDBtOERmenBNUlpRRTd4VmFNNDA5SHJO?=
 =?utf-8?B?aEc4aGNRTW1IMVlHbGRFUGNnMkxTY2V4MmJVM1Z4SFYrd2FFSkh3bTNzR0hN?=
 =?utf-8?B?dG5LTjhHWVhOS0NWRWE5cWQ1T1hYb3dINFpyd25HUVNzNEpiNkxnWnpKdGxn?=
 =?utf-8?B?aFVORGhBRi8xSFRXYU14YlBxS3dmWk45UzVaZWQ2SE5hek9PQUd6RDdkeW1n?=
 =?utf-8?B?OEpzWjRXdUFGTVpITkJuUWVLSytlT3ppUWUzTTlnTlFOV0NCMUpZWGw2SDBs?=
 =?utf-8?B?ZnVkZkpIaTVaSU1hSmIwK1pRTzF2ajBnOTJQa2s3bHI5dE1yZnE2aENMeitj?=
 =?utf-8?B?K081bmNMRldRUUFJK1hPSUltajU5V3JIWG8wNVBZbm5CZ2VEbnpMeFErcXUr?=
 =?utf-8?B?TStYV2VhT0JZeGF4d2dyS25RU3ZCRkFFUDNZUXY5N2NhcjlBaXNkR3BuWjdB?=
 =?utf-8?B?SXZkbkE1QmFYaUNNbHMwSHpkTk00RGYvakJjRTcwcWppUTkrdlNCQUp2UEdS?=
 =?utf-8?B?c1pueFlqVHBNYmFnZFdWNnNpYnJGWGU2T0ZNSndrckxlZmtUMFdKV3NGYm1w?=
 =?utf-8?B?V3Y0VSs2Sm9vd0x4UHJKVEJKZmg3STBYUWp2QkE2RmxXUm4wSUxyR2NCZDdQ?=
 =?utf-8?Q?uX/FDh9+RS0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10061
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eaff36ed-121b-43a5-c64c-08ddef69e6a7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|7416014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2s4N09mdGRFM01rYys1ZS9zN0QzNDE1SWNRY1lHL2RhejJ0OWRJOEc1L2VK?=
 =?utf-8?B?NGJ4SUxtQmRaVXMvbC80czFZT0k2Z2xhZWsrdmZoNEhWeFBpbGpOd2dNT2lZ?=
 =?utf-8?B?M2VYS3hMVmk4ODdEY082VjY5VWpPRzUveUNaNjlrZHBYRHRBL0pVZGozdFN2?=
 =?utf-8?B?QXhWbXVGWnRLZEJrN01NcE9Qd2xsTEIwcS9ncGN2K0luNTc3OUI4ZDM4L3lH?=
 =?utf-8?B?UHdyN09WUVZKTVdhS01OWkxpbmc1ampveGJndXR1UTZLc2k4TmhrQ29Xc1Zi?=
 =?utf-8?B?TXVCYm1tT3ozdm9kbWp5K2JyaEROUFh5WFB3bDZDeldOUjBSQVloeVUvZG1x?=
 =?utf-8?B?SmRKaHhnRndrUDB5cE9LNGF4WG1jWkVPZkNMVlpkSVpMejJIQ3NXeFZ2ZWJV?=
 =?utf-8?B?bDFXS2ROZ0g2Qm11ZUUrWUdQbWw5ZTEvbXRialo1VHJNQlJpOXNESGtxSmR3?=
 =?utf-8?B?QWo2Q0JDNE14NnRJeHNwR3R3K2UzeVpycENnR0V5OWdFVUl1R2EvRzFTcXBq?=
 =?utf-8?B?WHdaVUdRa0RIczBCcDhibnlyVXpHOW83VzJ5eEM5T3gxNStreW00MDc0K2Zk?=
 =?utf-8?B?ZlcwSnV2RWxsSnQzTTdWbXh5Vi9GSkRNdGhOZVB2UmFPL1hLbVF5S09jTlBF?=
 =?utf-8?B?SDY1N0lTdms4TFkvVnNmbzB4L2hZWHJGVnplTTN3RzRoNXJnUkpJMUsxSTNk?=
 =?utf-8?B?MUlZYkRjQjFuUGNtTDNGK3RQWmdVQllnVFZvUnBwMzM4NzZ0NnBtbVhpTlha?=
 =?utf-8?B?TDVkaGRqQVhVNHR4b1VjaHRSZ1BCeUhBdDRxV3MreThSTDBYMVJ3MzdJa0Rs?=
 =?utf-8?B?M0VNRTMvZVBrcUQyejI0S3JDZzY3ay9sYkdwRWYwMkViR0dFV3N4SFZtYTIv?=
 =?utf-8?B?cHpMMXhoZ0d5dHN6Y3liajg2ZjR3cFhnclo2cFVwMzVqRDFYbE5wWDRhVWs4?=
 =?utf-8?B?MWZwY3JVNXZoOWZPMVZVWE10VDVwU1BQZGw1MkZURW9sL2lzSnkzUEUydENU?=
 =?utf-8?B?bGtUcnZCMWNXdTh1YnROUTUwNTVjWVdDbTJYYWZNcWV2MlI0NEwwd0d3bUNv?=
 =?utf-8?B?UExwVGhSbklxMTlsQWNOT3dLUlNDcmwzUEJBRlNPUTBKTytrV3cxbStTOWpk?=
 =?utf-8?B?VnFVSnpwWlFVTzRsNENGcHBWZU1OU2dtVlBad1JMQlhEdDdoTloraGZpeHY3?=
 =?utf-8?B?akxVWllTWEd2eEhTWHJScDZwZnlicTd6MCtaZXpVRGlWQUxIQzlKbHZIOS8z?=
 =?utf-8?B?eFRwQ21tQ3ZFczAzenpEd3RCZjJ2UDRSQnI1VngrTUZ5eEhXMmdjRHFWSFNM?=
 =?utf-8?B?bnZyb2sxZENISjFzdXVvWkk2dHVkZVY4aHZ2ZHVMZEdxNkdZNXFRRHZ5bUxp?=
 =?utf-8?B?K0xjcXFGcmYvSnZLVjY5d1Y2Zm1wOTM5bVEveWQ4R2l0QVRSU0FCRVpyd25u?=
 =?utf-8?B?eXJiWHlRNTJ5QjZGQ1pjQWs3SWUrRFZmYkljN0Ewb21EakhRVzdYd1JlRFE5?=
 =?utf-8?B?TVZUQWRlaUptTnpuY0pDb05NemlGd0gwanNBVFlhMXFmcDZCZEhnSVNQTlpx?=
 =?utf-8?B?aTRFdnpGbXV1Q3d2SG9EMVEzTHhVNHByRVNRMFd6T3RJSnAzYUVLY0FsMXVz?=
 =?utf-8?B?eUx2dEJPbmNvTUhsM0dzUDFBNk9CaFE4QjVGR1FFWWUyeTVDN1NqUkpsbUZR?=
 =?utf-8?B?ckFzOTduUU81WlYyUmo1KzRiQnZDWkZVM3h3bUVVT2dMYjR5SDJRZXlWcGNB?=
 =?utf-8?B?bUI1VWw2VWpKenpLRGlQWmZ0emJWTVdzdHVIb1NQRTB4cTRPTDEzcTBya3E5?=
 =?utf-8?B?WnZXcEtqOVY3ZS9jandNZVhMMDFET3o2QkJKOUtOMVYvdjNrNDJ6K3hSVHpQ?=
 =?utf-8?B?U0tGdE1SU3pJd2JsZm9sZXp1NDB4ZnBiQkdPVEh3cXRWN1dMb09hMklzU0xr?=
 =?utf-8?B?dlU3aVpQcDJiazhxSkpWQXB3NkhORFZDVjNiVWQ0QzdlSWozeVYyZjgrWHN4?=
 =?utf-8?B?eEVlZTFqS2JEV2tGYUlxUVRIYm1KM0NQMlZmMGdNM3hIQ0VXc1dxZFkwTGFU?=
 =?utf-8?B?djZhZ3M5T1hMVzZmNDNHdkxIMm1iTjBySGl6Zz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(7416014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:27:48.7046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28966180-bf11-4ffe-3eef-08ddef69ff28
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632


On 09/09/25 11:45 am, Dev Jain wrote:
> This patchset ensures that the number of hugepages is correctly set in the
> system so that the uffd-stress test does not fail due to the racy nature of
> the test. Patch 1 changes the hugepage constraint in the run_vmtests.sh
> script, whereas patch 2 changes the constraint in the test itself.
>
> ---

Missed the changelog:

v1->v2:
Compute adjustment as a function of the number of threads

v1:
https://lore.kernel.org/all/20250826070705.53841-1-dev.jain@arm.com/

> Based on 6.17-rc5.
>
> Dev Jain (2):
>    selftests/mm/uffd-stress: make test operate on less hugetlb memory
>    selftests/mm/uffd-stress: stricten constraint on free hugepages needed
>      before the test
>
>   tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
>   tools/testing/selftests/mm/uffd-stress.c  | 17 +++++++++++------
>   2 files changed, 18 insertions(+), 9 deletions(-)
>

