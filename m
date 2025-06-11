Return-Path: <linux-kselftest+bounces-34705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606CAD55F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D7916EF06
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F3280CD0;
	Wed, 11 Jun 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kRW0LXr8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kRW0LXr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624C13635E
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646260; cv=fail; b=u6mPZkpCtz7O8Wn9E9XABQCqz3ANlKcSb+HMthuUV/RAud7V1zkOBoeGPG6+Vedi1hyERT+/kXyPS2s57pNbdPqnqWt6h1Wa+LDj30XQIZTSFacbz559Ir5OdK2AdS10eLD5qMa1VQlak7V7SYSlmc/E8BcW7hVMZ0WUSQE/H5Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646260; c=relaxed/simple;
	bh=5HBPZluzjrocaGTWF40yAvHUJhWj472ifxolYdtQJJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8Aw07nfojgdHa43VSZwF3hEhyR63KyWwxn3Y93agXsYfuK5nu97ZPChgsZfPQuo4cqFNq/AXpwz8AScRbAgN4Y5rIk7487+tJ480lkuB/tPrxrD9DiZQMod5BzHIon7erUjDGbOPu2HVvg1lEtGTjJRTwmIE7BOqOC33uHrC1I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kRW0LXr8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kRW0LXr8; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lKfamleRnlwYwOXvtwM1ITrpzPDL866wMFCqeZdeEVXbhWJv33gp+x1ltlUYR0ERFZkq8+mgpp2z23xgUmEs23vDLH4gdYtqwH6xyMwB91l56vSiXHPP0E96nNezLWUjwlT7iWvnj7TKFZs5O+b1Cu4xHXn4G0jY8k+SsL83iBehn/u6dX+tBSKZjDwlC+e6F9DXrrSFByY9ycYDktqsd9ZzfpZOX0t1Zl5AUiKJ4niVarAHnTR2F3r7jSG6I5yTJw9QPqwzKd0dcyX9eoLSBRya5gvy9tDYCoObwOVwPB+ftybSsB02qw9oR3OYUImHCJ+BTDx6Z+CyHIOiiZoBLw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxj9v7kqHf3mnXTDGKrL9M6LAPoqQI7lAz7giu28/IY=;
 b=Gx+KTEwhPf3eugxS8icRgJj9E+yYlucS9iQcVXZjfQCkzjCjLPaJtm1iqa8VES89ObEWIkM2enmXNtaq1hMyWlWNDvcVdXP2gvYu0fBA8uzbRcxFn1x7Db5pv/rrKmtV5CaBzPmXHr1m1lM3r+JXo5MRY+4osePtXTZFLTGFCzqsxjUAs3ww7dWOXVDjziHpZ3sD0sfvdEtpyGdisXfo1rVDQBW1DR8Q3YezZ1if6tr6JB3rbMvFSK9k/30Y7f2Lp5P8V5xrjpPg8YXgTicORG7Qu8tvDB7Qx6DxsPtgUyOMGsNKFllVBd6r9qXVTZBrx7Tx1o9Bkly7qLltgYEZmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxj9v7kqHf3mnXTDGKrL9M6LAPoqQI7lAz7giu28/IY=;
 b=kRW0LXr8rOuSPrwrGvLPcN5ZQ7iIzKvo2K6GvL5PbYRQaTw6xkGIyAfqsGPHjANW2KhHPMkr1SOO9GJMpYeuA6ur5TCXXWN7Ef+bGAomWf6z66edA8hLGB8OfDCTrmNSu664B6F5UEiWqZGvm7mjKaHha618zfpLYnyLVX5lo3g=
Received: from DU7P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::26)
 by AS8PR08MB9044.eurprd08.prod.outlook.com (2603:10a6:20b:5c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 12:50:53 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::fa) by DU7P189CA0018.outlook.office365.com
 (2603:10a6:10:552::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 11 Jun 2025 12:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 12:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh1NRiCFCIYGJ4iqJM9TMoKlPj0TiKz74nWNSki7TeTeieK4X1xC+e1MdCjyI5ybzxh0uP+8AtgKF6Zi2az2i9VRLqOADFBGIkDwqjV+dQxfREl0a3BCub8Gth90BR8QK8PZS8/GocmkxcUOXqF2ZoE+J4Ixtn8ilYG4dMovX1vc5lELsWE8+WRUzBKqYhd18c1MSkb61nMwHcw7xOZzwDH2/pEap3injfse+Yk8za+ZaZJn+asM5DyoQ8ci6mIftPIU4GKfMY6kvnpB/nI4AJQeB8enV84ph+qPtqpEafloUvZfEcM162XngF2epkybhMdIU5xXLDA/uaximYODhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxj9v7kqHf3mnXTDGKrL9M6LAPoqQI7lAz7giu28/IY=;
 b=hUi0VScW+H1iLBIIHoEfxeURFytJ8U6YJCzCoKO/TfqpxB2n6yT6e9nwJqqtKrMh+W/ogoXd9qzsooTlPIRj5ZwUwyzEpFKPr1FO/stoCM4A4YhXw5qNwzFInudKFwTVrFGNOeMtE1cv1Sz69iK7i/P4zfGBWNB0sjjjN97UVpm9N5UV87XpN5pOYEeiQhWRjpkhEmx3M1PDI7k9e1At1pBVArbpnrr8QH1F888te1Hmjdve41gmZPwGTM/ZD3D4QNuZM5o1ebj7MHGTWdGL0OWM9PteHzVxpzACrBYtQcULgGOtFKkzZBZxd8CGh1kkiOoHl4DNzQqW1Wm0U4ItvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxj9v7kqHf3mnXTDGKrL9M6LAPoqQI7lAz7giu28/IY=;
 b=kRW0LXr8rOuSPrwrGvLPcN5ZQ7iIzKvo2K6GvL5PbYRQaTw6xkGIyAfqsGPHjANW2KhHPMkr1SOO9GJMpYeuA6ur5TCXXWN7Ef+bGAomWf6z66edA8hLGB8OfDCTrmNSu664B6F5UEiWqZGvm7mjKaHha618zfpLYnyLVX5lo3g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB8394.eurprd08.prod.outlook.com (2603:10a6:20b:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 12:50:20 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 12:50:20 +0000
Message-ID: <41daafbe-50c0-4707-8004-55826dd3003f@arm.com>
Date: Wed, 11 Jun 2025 18:20:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
To: Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 vbabka@suse.cz, jannh@google.com, pulehui@huawei.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com, ryan.roberts@arm.com
References: <20250611121011.23888-1-dev.jain@arm.com>
 <8e0925e3-70ae-4b00-9f70-3a0325fd1fae@sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8e0925e3-70ae-4b00-9f70-3a0325fd1fae@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
	AM9PR08MB7120:EE_|AS8PR08MB8394:EE_|DU2PEPF00028D00:EE_|AS8PR08MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b46971-29a0-4355-e988-08dda8e6999f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SHY1SjFlak5TOG10ZG9xY0lzZGpqOEhzRExYMlFXeUQ5YWViRlpnSmpqeHhO?=
 =?utf-8?B?ODhsZTYrdGw0WU9XQlpOWjd6RGcxa09uaVdEdmszZGYzSDhISWorc1JZTVNk?=
 =?utf-8?B?Q20rSCt5WGdBdEcrelJScjA0blJOWStCQ001eHhYNlhrcHJhaU14d1pLYXFl?=
 =?utf-8?B?VmF1Wm4yOE9Wem56ZVpIRXJ3aFVnY3ZQWE5lRnppdEowVjFxMW1DMFZPL012?=
 =?utf-8?B?UklYNmFXSGtVN0ZWZXNOem5GbG5MbmYrZ1M2elcvcCs0V0tJRmhPdjBZaDh2?=
 =?utf-8?B?cE40NVlmaFhSYTZaQTV3djFDeVNvdVpJRXBnUkpaOFhYY0UwZG4zdWswb0dM?=
 =?utf-8?B?YjBRclV5SEUyT01OUG9UNUhrdk44N3lObnd4WHBvdTEwY1JqZlZHMGtEeWdv?=
 =?utf-8?B?cTkzOVFYTDFYWk1yZi9GSEhCOWZmUlduaERMWFI2cnkyRndTZE1YeTZLcVBW?=
 =?utf-8?B?cml4c1V5Z2pMT3dYWlZLdFN4QlB0ZG41UHAvQnZHb1BhTTBMZVJ2RmZNd0tr?=
 =?utf-8?B?K0hzVkNzYzNiVC9raUpWTUN5Q0FJbHZWVkg5K0Zad29uTmdWeTByVElCSlZM?=
 =?utf-8?B?SFBydTlIZFo1bW5help3YnYvVkcrdEJqVXdIK1kwMDM3ay9lUW5CVzlOQmNn?=
 =?utf-8?B?ZERKY3d6WlVsY1RZb2tSV1ZUSHdRZURrL3NtSFdDcWhBckdpN1dnSkYyem9R?=
 =?utf-8?B?R08xWExmQ2t3bE1OcTlHaUdDQXRQUmZ4OVZNMjRCN0xEdXRsdlR6dXJsVmFE?=
 =?utf-8?B?R0lEZTZtZHpxTGRDYm03MzVERFZPR1pGVFN0RFNidFR0NkdVdjhWUUlBMkNX?=
 =?utf-8?B?aHdNRkhpUWhtbTRBWDBqUzZ6dmkxVDJmWHcvTDV5K3EzY3duTnMybnRHWExW?=
 =?utf-8?B?SVBNYTBUMGkwVDRncm40WGhnWm1odWZRejQ1Z0R3b3VaaGVMcFMyQS90Q3Jy?=
 =?utf-8?B?Z3lBZm13KzNrUkN6K0s0dStiSVkzZEtYL3hkWHl2ZTdzSjVJS0I4aFJ2SG9x?=
 =?utf-8?B?Rm0xNUdhOGJGZ0VGY3NjS2lMRGkwT3Z0NFh3d2NwbXoxZDZsMDhmVTlHWmNE?=
 =?utf-8?B?OE1lWXQ3b0h1cjh2d05MazhPN21QZHFycVNYTVgxYjNWUUN1SGJyTmhHa1Vk?=
 =?utf-8?B?aGFkZ1B4TjhMYmJOK1REMEkxSGNUSHZIRitYZ09zTWI0N0l6UElBa2pXTnNH?=
 =?utf-8?B?NERvT1lJQ0k3YjZJZi81d2Y0Z3hscmMwY3RZRlBDN1dUS2Jtc1VqV2JSMjlC?=
 =?utf-8?B?b2Z1Q0lZcWNvbWt1Q0RBZmhoSGJZM3pjYndsamF1Nm5iRHpTbGN3WmZ1RjBG?=
 =?utf-8?B?eHRLbWh0NGFLMHdFNFlJZzZoMWFhbWNJSVN3NXRicDdIYktQaStDSTdvS3hv?=
 =?utf-8?B?WTdVR20yVkcrc3FuNHc4SEJUb2FrcnEzcm5Kd05LdGlGMTBvblIyc1VTOHVo?=
 =?utf-8?B?aWN2WllPY3FsSDB5cEJzSytBMlh5Y01aK083TVREQllhdm12N29QdEpVc3Fm?=
 =?utf-8?B?c0lVNC9NWkZqWEZTSGZOcXBFT28yWE56ay9uU3lpQmlIdU5rR3NXRFdJNm1Q?=
 =?utf-8?B?cFI2OGFiODRncGFoSzZJM2sweXJZUW9KZVJXd3BESGRlWUpGanN6bFE3S2py?=
 =?utf-8?B?M2JQWDRxOGNzc3B1UDFoMXNIcjlmYzByR3VjaTMxQnVhNmhPaktWWElJV0ZM?=
 =?utf-8?B?Y2o0amNPTkE3UFQwakRWaGFRRTEvSTdLSmMzUDQ0VCtNVzZuL1MrRjVaQ1E4?=
 =?utf-8?B?Sno0N1htMkF5MkR2V1R6c0RrMStuNWxkWWhDSk84WDlPUkloNTZDaFhOcDVp?=
 =?utf-8?B?OC9DLzVBQzhGcmgwdmpLVkluMFI5Y01xYmdEWXNGMWgzQzhsdS80TnN2TjBj?=
 =?utf-8?B?V1BiaHlYZ1JXNkM0OU5rNi93OFBlK3U2K29qMmZNTWVrbGc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8394
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	44f93f15-6886-4cdc-f0aa-08dda8e68620
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|14060799003|1800799024|35042699022|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEZKSWRmMk03cXNBd0szMy8zbjg4RjFROUVMaG05YUQ5eEcyZU5qVk4wRjVv?=
 =?utf-8?B?YmgrMWFyUjdXZjJxZXowUkpoMkNkZDVNYzE4ekQ0b2MvMXdpbHRab0lTTHEv?=
 =?utf-8?B?NVZTUE45NUwwMnFTNUZMMWVDbFRRa2RFbVhvMjk4ZXZyZnBKME02eGdVY25m?=
 =?utf-8?B?aVlCNFlCRFNoK1NWV2tZZUxzTWswMmo1bmw3QjFnVTVzSER2SFlFYnNnR1pL?=
 =?utf-8?B?NXpFNElNUVlBcVhYSDR1ZXFhYTJqZDZDbXc5RmI5V2wxbkVvclBtb3ZIVmw2?=
 =?utf-8?B?VWhMMWRzUmovLzlmTWxpMlMvbStOYjFtR3JBMjJyeWQ5bERtMkk4cWxMSit0?=
 =?utf-8?B?V3QrMXVrVmFaU29rY3U2QzZVd3FMZUI4ZU5oK0ZsVGtROTA1MldQVW1melVt?=
 =?utf-8?B?ZXhjcWRqUkFYV1I2Zk16bWhMTzJsVmhsQllQV1FuNTZnaWJWbnc3VlV0dXls?=
 =?utf-8?B?UGNJMjkrdGlTQVg2SnV0QkpwcmFOQy9WRkNJUjNOWVVXNEh5VWZHK0hFcFRX?=
 =?utf-8?B?czk1d2dOWFZBL2VQUllpYzVlaWdDTDN5Z3l5NThkRWVId2tQWjJJbUgvbXU5?=
 =?utf-8?B?UDhjeVRhakNZdkFhWjRRWVdMRnYzYzdWRFRGZXZTWlc1Z1RzbUIxcDF2SDBB?=
 =?utf-8?B?QlFxSjlYWGNZR1ZPMjRZd243bzlGTks2QWlIVXl1bWNvM3lXNEtMU0lvazIx?=
 =?utf-8?B?YkVCNUNRWWZ0a051Z3M2YjFGLzRYclBGMEVkaUdNZXlyZHhqSzNkYUk4VURO?=
 =?utf-8?B?RWVxcjNWcDZ5TUN1SjBBbXdDckNPZm0ra0s0dUt6dllnVWNZbm92U3BFeTIz?=
 =?utf-8?B?VHh2ekFWU0VOaVlCYUgraldhLzA1ek1SY3hhTk1xWS81UHZRZkpEeld6RWRP?=
 =?utf-8?B?MG0vbDhUWDBSQ0FNQXBpcjhNcTJxZEJwMDBHeDZ3V00xMFlYNUUrdnJaMVo3?=
 =?utf-8?B?Z1FZK2lTZTZmbTA3cnRPbDZLOVlta1h0UEZjcWlOM1I1aFlBUVY4UlJyMEUz?=
 =?utf-8?B?akRYREJDZWp5QklyT2JMZWNvNUV3bVZxVFE3QnBXZDRsVTNjQXpXOEV5Vmtu?=
 =?utf-8?B?OFFrcEJOM2RJUDVUMXN4RU9peHRRSC8vQS9BZGJURi9sZjVBeTJzUnliOUdN?=
 =?utf-8?B?QTlibUhyRW5MZER0TXNCcWplaEFxcWlWQXFZVk5oWlQ2T0tBaTFYdnRNMHNo?=
 =?utf-8?B?UFRXRmwvZDVwMVp5ck81UktDclh4Zm9FRTdmTFlETWRMeitpWm5LbGJHNVlD?=
 =?utf-8?B?SVhCaWpOMHBDM1NnQitYYXFpbGZvcEJRUUtueXlmNzNMM0lPL2lZYUJpdFNI?=
 =?utf-8?B?YjJ1NVkwY2J5NUpjc21QRXNhUlBmS3kwZm5JakxHayszU1hFeUt5MW9USjZO?=
 =?utf-8?B?dm5aVVZVVXk5UW54WnhnVDI0RnptQk9ud0dpZG1UTW1SYUwwVjY5ZElKcTRL?=
 =?utf-8?B?cFRFRnVkdTc4T0xQNHJzMXhKdC80bjVNeUcvd2lLaWJ5Rkpsd252THRRdlhz?=
 =?utf-8?B?b28zd0hmeEx0MThnNzBQZ25HOUFBOVpzYzRWVjN4SFo5SFFvWDRkVE1uZk5F?=
 =?utf-8?B?NWRUcGY4eW93K2haQkdJUGVYM0dnZ3FXU2NPalo5Q2FQU2Fwa0dyWkNpd1FE?=
 =?utf-8?B?cHhkS3dZdS81amhDQ0x6YU1adXl3UlpWMGRHTmFPU2NPRnlKczZOeDVsYUR4?=
 =?utf-8?B?dDB5RFZkbzhMMFZ1M1BrTERBKzFvZTIySU1hdC9GK0s3U2tOSEdkZU1nZjll?=
 =?utf-8?B?azVhVTZadkdSbmM1MVhyUm5qbGp1TW5ZRTBnUSs1L2JUcmpWQ2hLdVphYnBL?=
 =?utf-8?B?RHFZTnpHWFBXbEdPM21jMHdMcGRNZ1AzVC93azdSMnpoRHViQ1ZzSENvaHBP?=
 =?utf-8?B?UnNZNUdNazIrZFJBVEJqK0RaY1N4cmZOWU5sTHFvamlqV1NPSEtVWlNKQ0Nx?=
 =?utf-8?B?ak5odVVpdEpnTHhYdjFDeG9majJGUC80dFd4VSsxakVQcGZyOWVDZnNXWFVE?=
 =?utf-8?B?WXlkeU05cVFoeVk1U2o3TDkvM3FjeW1JWExkT2plcW1xdjZtMG54dkM4N3RW?=
 =?utf-8?Q?qiHU0y?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(14060799003)(1800799024)(35042699022)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:50:52.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b46971-29a0-4355-e988-08dda8e6999f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9044


On 11/06/25 6:09 pm, Mark Brown wrote:
> On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
>
>> If CONFIG_UPROBES is not set, a merge subtest fails:
> ...
>
>> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
>> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
>> CI systems can include this config in the kernel build.
>> +++ b/tools/testing/selftests/mm/config
>> @@ -8,3 +8,4 @@ CONFIG_GUP_TEST=3Dy
>>   CONFIG_TRANSPARENT_HUGEPAGE=3Dy
>>   CONFIG_MEM_SOFT_DIRTY=3Dy
>>   CONFIG_ANON_VMA_NAME=3Dy
>> +CONFIG_FTRACE=3Dy
> If we need UPROBES we should enable UPROBES explicitly, otherwise it
> looks like we're just randomly enabling FTRACE even though it's not
> used itself.  If it's a dependency for UPROBES and we also enable
> UPROBES that's a bit more obvious.

Fair point actually; I'll send a v2 if no other objections are there.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

