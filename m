Return-Path: <linux-kselftest+bounces-40272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472DB3B9BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF585823AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0530F540;
	Fri, 29 Aug 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sBAk4Yuc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sBAk4Yuc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE153A7;
	Fri, 29 Aug 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465843; cv=fail; b=cPHj2zX8FFkxfCDjJx/2QKT73sLj3tCRPD0S6YJgpR4ptmArmwa2GfXJBT23DkPMkL1USKEmAjdmmFC4t423m1i5rOTBEyiwBW1KanrTCtKMMMciYzQcm1uDH+z/qaxvWwL1lZdkW3IthTJd75g6yVjSz1zNIbPWis2e3Lv5XIQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465843; c=relaxed/simple;
	bh=uSBq/ALS4FZwQD6vuAImbsSqYfRwaK7wSwD8L6GKZM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=moLRUYNhEXUMQPjbiA9YbrvAA9TEIJqAGCTbOYuZ7wR6NLya8qskgNCqj8nCUi8qIw5vXQINK6GsiH6pPbu4Ev0JlCWl5JbD8uGzwNm52szA6aX648hsFqxJMRZDAt+JNHmFnX/hnUOk4kTqSg40DT9pi0pBjb/EAGiLyB2s9w4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sBAk4Yuc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sBAk4Yuc; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l3QRXXpNjCG0e6vc/10nH+nwGHYwIuUn+4L57j7gxASssu22nAwCe9LNZtuaH+x6MWO4Pg3Jp5X+yR3tz+JRCrP7ErbIl7rggGVXlLTc5ynLWFWVdw++g0x+CQ3gAdSs0tls8/i6jcDicKwHEXn5BFTZZHh/SZMLZ2fw+gE9FUUwTK2ICX0tNemS8DFILHUBPQTJgcbBE7ZLxrWWAPT5GSc/CPkkrCxqdct6HDZY3sO+1rTKcpgO7667CJ6RsI5TWc5eYGAOrQSn4DCN54q2FfMcckrbSNaZpz/NZ/LXWkBtg5x1AtvpDIddjT5Hu9Xs0a/JY/hYPktASmzunPb3ZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xRFQJAbPP6u1mazyxpZieZX00MAHGxy3J9G+QdKkUY=;
 b=QNXs5/X3KQVNgvT5JMii4XBBblDHQjv3/Yow0gVrxHwoud3sELAntKJG5MkTm5WdC6rRfH1jFjKG1T+rhA01cofKKMTs9FvJcyAWCo1Er1Qq0AwGE75K+gYrzrWSsgjuoFK0u1yM5PBYX4dPuZn7fqz8V9p48eWWq+yDwho1oMSWwI4T5nd89s/LTV6TfvQ2CASPqnuCta6EFrsPIR+3qUpHFesmwqDWOL0/kVZamQaY7rt16EZfJThWgXdLuUDXAzlkPAMugiGfFDkEm6tSpcz8QTKTboZFUVI5nWy9OXMLKmAWsVJRivlhl4EqXmKbPb2Tvhnk9JBqEt0FF5GlnA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xRFQJAbPP6u1mazyxpZieZX00MAHGxy3J9G+QdKkUY=;
 b=sBAk4YucAasEFsAMvIjBJWs2cze/k7przL/QDXPl/mkGDSmyLcNnWV555JEaOVgAxydD8tCgYbm51YzbIdXPf00leciQwzcO27w3lWwHrPwJn/0TG6H9zLt0cp3sLq1aEgF+3BAdCET7mIXY2JE2DFLBgXdFQxZ+b4RxnkFIzxc=
Received: from DB6PR0301CA0100.eurprd03.prod.outlook.com (2603:10a6:6:30::47)
 by DU0PR08MB9583.eurprd08.prod.outlook.com (2603:10a6:10:449::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 11:10:33 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::b0) by DB6PR0301CA0100.outlook.office365.com
 (2603:10a6:6:30::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 11:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Fri, 29 Aug 2025 11:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UelJRHY2NQn3pfX3hIteQoxawODdOBDC0w0QU9evrfgC9SvNZYW1zwyPRkufjHk7MLCSov9wI0ojumeAv5EVquBTE4wo0aw5aGKOVIyzQxb5b31LG5GP/hOIbSZ5FFm9yzIHz1DmbwR+n2x4KaLAcjMYJruqkRV8ni3hXuylZbQrWwyw3M/Eq/g+/g5cV0+/Sy9eRf+tqxT5nxjGAW+5egkyJi7Kmy9uMCWZQ//n/AWj8Ad5MoMOYeVMKq6auEVLL44gXt1cyrZTmzDFa9JdsntU4W3Lomik1VWPI53gpVzonU089bKzT/N56L3fOGBVTswNd43OK+pv9LMzdaP62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xRFQJAbPP6u1mazyxpZieZX00MAHGxy3J9G+QdKkUY=;
 b=ozAIdnVcjECAj+heOwpofJw1OLmm2eSpn1kMEEi/7RVAgjqN72hoi2JSHVDwQ1zeZneZPzXdvlIrpyB6xCLsYRfGu4O/eV3lysJ868F0EoEEvj/YNCZe9oEAbCxCwE7dvQ1RmeFY5JUT+socfnrTOnx2r9wlYP8NVfEa+RdlvqArX0vo4nCsb7nF8ntM/Uq035KoAwDpjC0gp067pQR2L223+NLZz40Fqrm3Hw0unfvm2Lbkeknb5mLg2iMbgMoDxC9e78l97TUQR1Trs9r8DFVfStNXew/gCT3QRrEz506p8cNFfoFOvmfhozNy3h173+I+7g0tiv7ELipXR2NIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xRFQJAbPP6u1mazyxpZieZX00MAHGxy3J9G+QdKkUY=;
 b=sBAk4YucAasEFsAMvIjBJWs2cze/k7przL/QDXPl/mkGDSmyLcNnWV555JEaOVgAxydD8tCgYbm51YzbIdXPf00leciQwzcO27w3lWwHrPwJn/0TG6H9zLt0cp3sLq1aEgF+3BAdCET7mIXY2JE2DFLBgXdFQxZ+b4RxnkFIzxc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 11:09:59 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 11:09:59 +0000
Message-ID: <7a104117-0b38-4944-8cc3-9942add668b4@arm.com>
Date: Fri, 29 Aug 2025 16:39:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm/uffd-stress: Make test operate on less
 hugetlb memory
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 david@redhat.com, shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, npache@redhat.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826070705.53841-1-dev.jain@arm.com>
 <20250826070705.53841-2-dev.jain@arm.com>
 <261fceba-8485-4015-af72-582c4507cadc@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <261fceba-8485-4015-af72-582c4507cadc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM7PR08MB5415:EE_|DU2PEPF00028D00:EE_|DU0PR08MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed16761-5711-4998-2c6f-08dde6ecac94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V25Ha1Q2Qy8xbVZRWEl2bS93VzM5eXpBNzA3QzM1K1dTRkpBa3Zmem1Jcktj?=
 =?utf-8?B?dFJYZ1VsTytkZ0o5ZDU3WmlEd2x1ZjZWZmQ5RDRUKy8zL2xCS1F1MVJtNHRM?=
 =?utf-8?B?TXduY08vbFo5VDdNODBmc1AyWXJNbjgvNHdKcDc1dzRLUzlkYVFmVjMrUzdI?=
 =?utf-8?B?ZUZZVzZBUm5NZEY0Ry9jWUtoak9KMnRnNnNYV05RYVl5L0VBREhudnRtRkNy?=
 =?utf-8?B?NDdzaG1zU2VudS9XMkZZZUpQRW9jZnJ4eEpqdlllN2x2aWc0VVp3Tk8vb2ZH?=
 =?utf-8?B?akFnU0VxSi9ncGRIU1R5Nm12aU1OdG05b2hYVzRCN1FDL0w4Qmp4SG8xZk1o?=
 =?utf-8?B?dGZ2ZURHYVozYThPeWlBZGdyODQ4dVVmTnYrR25NMlNBeGZFL3RKam5hY3FU?=
 =?utf-8?B?UzFMc2lObEM3Ykd1TXIrSVVLK1BESnRhVFNCQnVwMXZPWk4xWFJDS3RHbTR4?=
 =?utf-8?B?NHFnV2xrUTdwa3lqdkNkOGNTU0prZ1BkOTg2eEE3MXBjaHJtTWZIc3k0OXc3?=
 =?utf-8?B?dEhLWTlJNHpuTVdkYkRySnRMdjJSa1JrVzYxdkdIMDNMWVIvZ0E0SEJ6MEFi?=
 =?utf-8?B?YXVoZ2dRc2pzellGdlNOR1BwS0NPU25zWStDbEtuNU1zODRxVUJCemphMVZ1?=
 =?utf-8?B?eGtWSVVNQVRlaVRiK3RteUY0WTNOK2FRb1NRMnk0eklxb3R6WW0zSDZFeUkr?=
 =?utf-8?B?K1ZkK3FLN04rRGFpd28xNmZYN3lQUVBwM056L0pPZDF2TnRzQmo1bDVCeDhK?=
 =?utf-8?B?RHVQV2dmeUZUc3FyS1lkVmh2RW9uSlowWGY3bGdqL0RucFlNM3BqQ1VOVkZX?=
 =?utf-8?B?bTBqVE5LWE5NUkwreTgxSWh6VEVvazVQTUx5SFluMXJVVGcxWS9Mbk95N3Iv?=
 =?utf-8?B?MlNjMGZLNmg4R1dyd2YxOXY5V2YzODhBMlVacG1aSXo2VitXNWZ2THl3V3lp?=
 =?utf-8?B?VFFpYUI2TVFQTitvL2lrZStSbmVSeTRSRFZudFFFZWtyUWVWRWdXUUpMVXdG?=
 =?utf-8?B?RUNva0ZSbThCNnh0cER2RjdMWGxoTGxvcWZsOVVHR3Z3OGFuaUFjSWkzbmxr?=
 =?utf-8?B?MTMrZThwZllSVFpmUHFUNVE1NWl6aVo1dmNZYVJEcUVaZ0wxVjBqWTY4ZFBm?=
 =?utf-8?B?KzJaTUxCbHY3ZlFkTnlrdHRlYmNOQXV6SHBWMWt5cTRmdzBsRm9FOG5OQ0Yv?=
 =?utf-8?B?WmZXOUpIWkdLY0NCNWs4VTBVY0xLRG85ZXlBc09pSGhzalBaY3hDS01qYlJR?=
 =?utf-8?B?cGJiZ1ZJZDVxSHFDa0NOc2IzWDBDMkdVVjJsWENzZkMrN2NVekNmOE42VkM1?=
 =?utf-8?B?ajlSQnZQTXIwVHR6aFFKSWo4QkVWQWxjQ0g5TU9sZ0NqMXFJb21hK0F5bWpH?=
 =?utf-8?B?NFlmektuNUNDNWdHdldzYkl6U2s2YTMvNmRrV25aVnRqbElwM3JNZzlLUEFC?=
 =?utf-8?B?UGNqaFhHMWlvN1JoL0E4UithUlhPdWZlbmNlMGVUNVNhNEkyWDV0VEJ5RUlI?=
 =?utf-8?B?dWpxMHdoVXFzUWViUjFRZVlVV1dnUHI2VG9razZYaHN5RnlaUld0cTVUNXEw?=
 =?utf-8?B?YWVmME1Gd1d6YU83QzhDUmpRbTgrcTVGdS9mZG8wRkJtZWFFcmt3QjZaLyt4?=
 =?utf-8?B?Ny81YjRIVVh5QU5KVkxvTzdUU0tqekdzWWdQTW81OHQ0QlZsK2pOVDlFcG11?=
 =?utf-8?B?NXY2RmtGYVkwb1JUQlIvS2dDZnF0eEp5OUZXRHNkcEpLWTRtdjF6Q3dDNWdr?=
 =?utf-8?B?UlBaMkwrWHNKQTJYN2lueXJxUkptN3RjVkJJc2lUckRrMFBYTEZZamdXZU1B?=
 =?utf-8?B?b1g0Sm9DT3R2amdsd1l4Y3ZIN0c4TWJIaHRranVqbGNBNWluenl1T3pZc3NB?=
 =?utf-8?B?MzlwMG1TSmZSTTNnNnlTL0VhRTdOOXhNZ1I1S0xmQ2JKWlE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a90e800e-e58e-430b-6f43-08dde6ec97c1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|14060799003|376014|7416014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b054Q2ZnSjJPMG1DbWdyZFpsU21RVnBmbW9IZVoyMzl6RGlncGxzUUZTK3V0?=
 =?utf-8?B?WHJ4R2dXK05jV3dNeDFocXJNUjZtanBvdEVuMWVXY1Uvc1NFNFdYWmVoc3dl?=
 =?utf-8?B?N1l1dFVkUzJQMUloMTdVbHJGQjBRcVEwczVEeTVIMU15ZFZldDBjVTMvazYr?=
 =?utf-8?B?Vk5xMDAveWE3cUcvT3dpMWVubmtKcUtjclVzV0ZMY1M2NkNFakZaRGxFMVlP?=
 =?utf-8?B?RkVSRFFLdnVSMWt5WjA2QStodGptTDI0ZDBoWXlVRENETnduM0Y1VnZpeWR4?=
 =?utf-8?B?VmlNVWQzUjVHMFBJVndDNitVaUdYN1NURFZnaTZ6RmNtWG1FY294MWJGMFd3?=
 =?utf-8?B?ZWh2c2QwQmdydEY1cTRrdXBEdzZTUmlML2JHWFdPRGlNSENxTUwvM3plYzFj?=
 =?utf-8?B?YWlYM293MHhva1VDeUdnWTVjcFVJb0JrQXIwcW1wQzYxOXRHdStiaWYxZ1Ny?=
 =?utf-8?B?WU5oUlA5YVJnWHlONFZVcldXZ2NsNWRINk9ocG9Yc0FYRTY5cVIwN2w2cEJC?=
 =?utf-8?B?US8wenBaZzVjR0JuL3RHUytuemRwZkphVVczcWQxSEYxRTNFS1ZMYlNWR1RE?=
 =?utf-8?B?SGwvUW5FZXNEMlo1MmRHa2NkTTVkbTByUTJlbFArNEl3RVRGQ0NONGI5Skxp?=
 =?utf-8?B?clpOK0NiMFZjZnZOblJxYUh2Z3ZqRjBDYzMyM3hOY0JuR0x0a1pUd2RGdzBE?=
 =?utf-8?B?Q1hCQUMrS3lFYURacGFpenBVWTBTZFR0THJteEJDQ2I1SWNQTGNQdC9Wanpn?=
 =?utf-8?B?VDJNVHQ4a1RJSzBOQnZaN0pYV1dKZTZTYUozWEF0N0F0TEZDZ3Y3SHEyMFBG?=
 =?utf-8?B?SDI0MW84cEVvdDRxZ25wUTZyQTJPTlIrZlJjVHRNUU1BelhQNTlvaUQzMWlX?=
 =?utf-8?B?OENtWVpTcXV6QzVnOFJnRlRyRjBGNDIvTGFmdHlYNm1sWEVVS2c3UXNSYzJR?=
 =?utf-8?B?OGFKY0JRUFhTZStLTG9GUW9OWEVScjVyemRSL0pRcUdNVEdqZFlIeXkvVFRT?=
 =?utf-8?B?ZllJS3ZBWmpqQmRSaU1STUVEdXA2dEJYdkVFdEw4MUZZSWhmSkRiWEFvMHZC?=
 =?utf-8?B?TVowbmF6WDZEMnk1K1EzMFl0ZlV0NHk1WlEraDJZd1FWWEVSeUhmdEx2b2xG?=
 =?utf-8?B?ZTM1ZHpiWjNJU0lScTY4bk5aUDNzK1V3Y2dEWnY4d2N0OUkzWXI5ZmNNU0xJ?=
 =?utf-8?B?bW5aQ2JPZTlKOTZzSGtjZ0htWFZVWDE1cnJRTjduNWhnbHlCcTR6TTlVYlVQ?=
 =?utf-8?B?Vyt1Q0xIMzRzdENyazRhRzV1U2d4YW1vRGczVGtjTmtETE4vMzBqb2h5N1hk?=
 =?utf-8?B?aENPbFl2TkpnYUdNZUZYMktVandZcC93SHB2anA4YXlMMmFueHlJOXRMMVN4?=
 =?utf-8?B?eUgvR1JIZyt1elpyUm9UbmFUUVROZGtaaWtsUFJsS2xmVE9NYjBGRWJQaFRD?=
 =?utf-8?B?SWhTTjU4ckcva0dCOWtoWjBINkdzWURBUnpJYUFQVWtoUnd5V1Z0dGNEKzNx?=
 =?utf-8?B?S0pENFFla0YxR3BaOWs5TjNPWUQxYlh5QjJaRWp2NlVVZHhJMFAyaWYzSVVX?=
 =?utf-8?B?S0lWd21uTjYzamF2V3VOVWNrRCtwZkJKL2ZTUG1NLzRpaDlMblZmS1l4dHEy?=
 =?utf-8?B?ZEdwbXFuU1BLSEMxb1hSSjhIOWJ0eFAyOTRpV1ZGNkh0ZVh2dHp2cDkzVnY0?=
 =?utf-8?B?ais4djdHeUJ5RmpveXZkL2FDUnpJRnZWaFFvRXJFd2U2ejFtZTZYSmd4M1J1?=
 =?utf-8?B?Q0hxOVFiOW9JU1ZtNXZ2N1lici8vNi9IdWFZY2xKbkNUTVZ1TFN0RCtVbW0w?=
 =?utf-8?B?cVR1eUFzVlVBQXpJWkZXVGlwQVNzdXQ1c045Y0RSaDFnZzFTU1ZVOVRIWUEz?=
 =?utf-8?B?U3hCN3VVZ2x1OGRTWW9SUVQ1TDByVU13SVR6R3gwYUFrZzZDb1c1OWdBeTlP?=
 =?utf-8?B?OStLWEpXMDBTV1dkdis5T2dXejhnNDg2MGVzNHVETjZlMTF5WHZ1bG5sU2NM?=
 =?utf-8?B?Vm11TmFMM0c2UjFXbXNkUjdqdzRhQkk4VU9QRURnNm5GOERpY1R6NktxL1hs?=
 =?utf-8?Q?U+VpTv?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(14060799003)(376014)(7416014)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 11:10:33.7442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed16761-5711-4998-2c6f-08dde6ecac94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9583


On 28/08/25 8:20 pm, Ryan Roberts wrote:
> On 26/08/2025 08:07, Dev Jain wrote:
>> We observed uffd-stress selftest failure on arm64 and intermittent failures
>> on x86 too:
>> running ./uffd-stress hugetlb-private 128 32
>>
>> bounces: 17, mode: rnd read, ERROR: UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:617) [FAIL]
>> not ok 18 uffd-stress hugetlb-private 128 32 # exit=1
>>
>> For this particular case, the number of free hugepages from run_vmtests.sh
>> will be 128, and the test will allocate 64 hugepages in the source
>> location. The stress() function will start spawning threads which will
>> operate on the destination location, triggering uffd-operations like
>> UFFDIO_COPY from src to dst, which means that we will require 64 more
>> hugepages for the dst location.
>>
>> Let us observe the locking_thread() function. It will lock the mutex kept
>> at dst, triggering uffd-copy. Suppose that 127 (64 for src and 63 for dst)
>> hugepages have been reserved. In case of BOUNCE_RANDOM, it may happen that
>> two threads trying to lock the mutex at dst, try to do so at the same
>> hugepage number. If one thread succeeds in reserving the last hugepage,
>> then the other thread may fail in alloc_hugetlb_folio(), returning -ENOMEM.
>> I can confirm that this is indeed the case by this hacky patch:
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 753f99b4c718..39eb21d8a91b 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6929,6 +6929,11 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>>   
>>   		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
>>   		if (IS_ERR(folio)) {
>> +			pte_t *actual_pte = hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
>> +			if (actual_pte) {
>> +				ret = -EEXIST;
>> +				goto out;
>> +			}
>>   			ret = -ENOMEM;
>>   			goto out;
>>   		}
>>
>> This code path gets triggered indicating that the PMD at which one thread
>> is trying to map a hugepage, gets filled by a racing thread.
>>
>> Therefore, instead of using freepgs to compute the amount of memory,
>> use freepgs - 10, so that the test still has some extra hugepages to use.
>> Note that, in case this value underflows, there is a check for the number
>> of free hugepages in the test itself, which will fail, so we are safe.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 471e539d82b8..6a9f435be7a1 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -326,7 +326,7 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>>   # the size of the free pages we have, which is used for *each*.
>>   # uffd-stress expects a region expressed in MiB, so we adjust
>>   # half_ufd_size_MB accordingly.
>> -half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))
>> +half_ufd_size_MB=$((((freepgs - 10) * hpgsize_KB) / 1024 / 2))
> Why 10? I don't know much about uffd-stress but the comment at the top says it
> runs 3 threads per CPU, so does the number of potential races increase with the
> number of CPUs? Perhaps this number needs to be a function of nrcpu?

Yes the race will amplify with nrcpus, technically we need nr_cpus - 1 extra
hugepages - the worst case is that all threads will try to perform uffd-copy on
the same address, one of them will reserve the last hugepage and others will
fail. 10 was just a random number; I see that run_vmtests.sh already has
nr_cpus computed so I can easily reuse that. I'll send a v2.

>
> I tested it and it works though so:
>
> Tested-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks.

>
>>   CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
>>   CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
>>   CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16

