Return-Path: <linux-kselftest+bounces-41047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32AB4A953
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A828716C638
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C25E31770E;
	Tue,  9 Sep 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M6aGSLol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C242FB606;
	Tue,  9 Sep 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412397; cv=fail; b=Mrra9GzYbJzlFj6cEs9xoU0r81FPP8fU6RW2oF4GNVdBfQlMz886Psq4x8FMxpa15xa/D2gtM6fMid6PX6oZfGDWa5A5t/8GTzXOF7GXtCZkXrEt3lZcfiQAG8RPpcJBDdIZ0G7drIWvWcP8vdpXO7je6RT5JRmM1vufqdjIStQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412397; c=relaxed/simple;
	bh=uYC+peagU/RsWley1F2Jr/sJ+c1bovGi8O+HoiAj2D4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMsabsGg2QIwMePvAL2wTHYIQOH0l9/57zmtNf7I299bQWiaU+U4LSQ6dbVeH6N7YnlMPFbuwcj4lPg6FXBKOoiGZQ53TJCDmFlDMEPQfWa7EdOPulHNRFJ10xbhxZv0rPwN3z9do57dULtVQmAikAlrCIBPyN8sYHsj7NJrGnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M6aGSLol; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDwetHTSTIZioRkQY768XbeoBxErzFGnoIW6nhRfZwADclXvLjKe75wl2GDwAEOvQfmDf82s3rsiRpKu6gHR8+KPuLh897+bxDkrTxQ/1jEuGNfVU+psmxQKyvpx3RKFviyGm7vnN12V6lk360QUTXWR6upP+bU9DgRhZUqOPxYgNNEoF3a49ImTOJDMFRVtVx82bnZI0Sv52rY2FBnQCQ8rSLkan4RVasuTKtXA/waDFI1PRDC+6FSnwnXJoX+i99ZblywBphCjV1YhZ7q4LqMitdCP3nqM9zlcnnCe6CuOjBMmbxJRokMhZu2rUZlW4HXLjchGGfUmewRmIZx3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG3A+QqfZbblXhZ1+sv53MntlkvqQef/gxoMui4EsL4=;
 b=LgzjNmSsUxvyIgRudlqrOD0AciaDEfvHBUste2tM7h3X4g0h/veb5WCs+m+82/SYmoZt142S3rdNFoemDBIITHwtMDQAHGAgQ2NrjMgdHqLUJjWAA+wCijog5LKOFxkvidcK1TE/Vou8Q0uD0dw56xTuntM96jvS3RaBwM4KdLQeQXyX+FmU8SphmGAjsWX4sJnQ/Gtruk7fkIMZQSqlQXfg/kXAqUKziGFpIjrvFJd+wKLSxcXlyZDunwl0ZrghSceFoKGhdviBgyCc+zGLUb96F4QTG9Pub4ZmluRNuLG77h8/OjWH88gLGXsYY4TTp6oEDzp8haNuyt0VzzlpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG3A+QqfZbblXhZ1+sv53MntlkvqQef/gxoMui4EsL4=;
 b=M6aGSLol67OLSMjCrN9xOPdzhxamVNK1REPxANTOd7JEP9rEBdUTy5jq5Fo+v+vIDEiXzUK/0gQ8w+C/8j2r/XdQRWQNg0ilt0Kz2AC/g6u4tCuY1F5aLLx9wgJsRTbf14AV6q0tcJ2CFcwzuQHeTETlw4znv42491VfcbtxwVLrCjDJqa9LSX7FWbStmRsVa6m+58HtCDUp/WsCZw9Hv8lkYvFE0xZLv55LveeSUHBQH+tyaq3IV+ANeOaMoJ8J4WwYqyxFJXqiIGvpAIZrQ659noj1+NXIw35M5zgtKy4biAikB70bHxOkNuqTtda4MSIxD7UHcB3DYIyQgzPd5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:06:31 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:06:31 +0000
Message-ID: <2cdd9fa9-9fba-4880-aa92-c73033c668f9@nvidia.com>
Date: Tue, 9 Sep 2025 13:06:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20250831080641.1828455-1-cjubran@nvidia.com>
 <20250831080641.1828455-4-cjubran@nvidia.com>
 <20250902162101.5c78cc88@kernel.org> <20250905153243.6c03e257@kernel.org>
 <0cd98e25-b387-452b-b1a6-414ab20a4cf3@nvidia.com>
 <20250908131917.10785ce0@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250908131917.10785ce0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: f72767b7-3a7c-4c23-4c14-08ddef888c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekl4OHlHM2F4bmRBRlFCUjVaN2pXV25hbTVUWXdVRXZWM2FvL3B6Z1J6THV3?=
 =?utf-8?B?K3RnYVp2OFVYU0ZXQWR2RkhqOENlR01FSEVpeHlqdEh2cUMzOGtmNlI4STR5?=
 =?utf-8?B?WkFDRTFzS2l4aWFtcHM1bzFaVkY1WDFWTGJ5eFNoRlN6UzZtRkVrUXpUdG9q?=
 =?utf-8?B?aFlYMjZtbzFoVmdGb0NpS1NZaHUzd0lQSG1ZMS9RcUF1SFhkMmYxVThWdnpa?=
 =?utf-8?B?ZUZybG1HYWFoUlRMZ3crZTlrazBUU0cxSzVobVI5eDRYekxrY1d1cSs1UUZx?=
 =?utf-8?B?TWhjbVp1Tlh0cG5kQkNjd2lZOE4yTWxxVU0wQnRuZXVnNmhyQ1k2ZnhSQjA2?=
 =?utf-8?B?bTJjUjhWQWZwUVF2YVoyWHRGUmZvajNBT25kRlhQVVFDWmtGZHhHWVJFbWFs?=
 =?utf-8?B?dGVDc2NqMDJJM3BleW1XY0NTaHdSbjJmemlNSktSVTUyMTl6cUowZDF1REZz?=
 =?utf-8?B?WEtmNTdyT2RtS2IwUnpteDFFTGkvbzRpT3Z4ZUJqeVB3VXhOalJyNnRJV2NS?=
 =?utf-8?B?L2pSOHhOZ3BYV0lPaXkzTVZUbnV6ZDVPdHVKdFQwQThsc0JCenYvcDN0TXNL?=
 =?utf-8?B?R1RnRCtUVE8zQllDbytnOE1xNDJHcFlmQktPYXY1YWZCaDF1Q2lwUGhIcHhl?=
 =?utf-8?B?ak9kZEplM3VmZVFDZGxwdzZEYmVoamtSZVN1dVlMQ3ZwUzNsczdNMThqbnZw?=
 =?utf-8?B?UE54b0hoaHpHWXFFQnhJY0EvL1ZlNTM1N2FUb1ZsS0lKSmw0V3F6eWhSbEYy?=
 =?utf-8?B?dmZnMDU1NFBTQzZJbnVmbDNVdDViZ0dQa3MwQTZSV1Vhem9yL3JSaXZibVcy?=
 =?utf-8?B?aW9Rdi9SaTRKM3ZRT2lvZzY5bUd5VXlkNFp5MUpLU3RXSkhBTHRwQ0k0bUtF?=
 =?utf-8?B?Q2YxdzhKdU9KOFFRK29IUy9xUmdyOFVkRWJHeWZYOGE1VkFpQ2dXNnppLzNl?=
 =?utf-8?B?VU03bTV1c2dwcUpsaWdRUGl6bmF1RytlMjVvNFJmU3V4MSsyS1FFd1lwYjYv?=
 =?utf-8?B?cGZXVXZjbndKUFd1RVpubzBOUnlDaXpiaUtGdFd6ZTZMQmVrckFtclNkcC9q?=
 =?utf-8?B?dHBzK0JEdXREc3dTTzFRV0xKUUNYRDZjeXRWVXl1NytFd3VJUExWUzFadUR2?=
 =?utf-8?B?SmtDWFlXK21iWDdWbzJEdUQwbitqQzlOM3lmeUJKa1FaT2pCallIYitINm96?=
 =?utf-8?B?SmRXY25mUTdlY3l5cS8xekJJNE4yME42SWQ5RTVaTk5vMTdmaGNEeHl6K1Fw?=
 =?utf-8?B?bmw4QWVmczFNK1k5UUgzN2RBZWZjbmc1b0wwMHlEZys4dmQ4QnlQVkJkQWRD?=
 =?utf-8?B?L25FNXF6eFM3T0k2cDhIbC9JU1F0MzBhNEZsT1RVMnBKUzBMZjFmODFKTU1w?=
 =?utf-8?B?MDU5elkrN3hxR0VqL0RIejN1UnYrT2JzM1RiTkhFMGhhUHowSFhrS2w0RkhQ?=
 =?utf-8?B?ODcwUVhtYTlYdkNXZDl5Ty9xRTlXaFUyN0laTGgrejNPeW83OFYrQWZob3lT?=
 =?utf-8?B?SGFWa1VhbnI5a3VNMUx5MnNBbFd3bVRxcTBROGlMMTd2Ylp3YzMyZXBZMjhN?=
 =?utf-8?B?a1JkSWEyeDZTZk9VWEY4QWRPSGNsTmdFZStkQUM5OHk1QnpDYzNUdE5NN0Q5?=
 =?utf-8?B?bC9rWnh6N1g1ZXJxSTNwd0pwRlBUdUcwTXlhVHQ1ZmtnS09XMzVZaG8yTmpp?=
 =?utf-8?B?Zm1NQ09FcTN1ZzlGTFY3RmkvQWE3Y09MbGR5WTRpWVNNMDZ4bG1BdzNoSGNN?=
 =?utf-8?B?RjNsUW00Vkd0VmEvQWVOMGFzbjduQ3BpbmxPNUUzM3kwNklHVEdZbVd2c29o?=
 =?utf-8?B?djZSckptMVRSWjdnWFF2REtKNC9oeTFuZzRUandFOFVDVXZiVXVmS2tzR1Y5?=
 =?utf-8?B?ZXVHa0NoVjVqL3FLRUlCaWVEWTdXMFdVZjZuT2x1OGZVUnBtRTc3eHdJbnlY?=
 =?utf-8?Q?yYXBlxTkbaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHVOaW9pRi92a0FOd25VMGYrR29FS1dsUzBGcEF2ZkFQY1kyS09sVjJGZThW?=
 =?utf-8?B?eXQ3dFlPRmxuQXNSVkNGaWU3MGV2REJMdklSTEJIRWVqSk5FMEpIZ2w2dGU4?=
 =?utf-8?B?ZmNuUmZxOTVYdU5iZnpVajUzZDdTRERNM1Y4NGtDZHZTWmFaZktSUnpDaEE4?=
 =?utf-8?B?U0hZa1RDVFROajlzSnJyaDU1KzJTaENRelNsWmF0bVBtR1AvYmRsazErRnkz?=
 =?utf-8?B?a0lIYkVDSXkwRExSazJaWWFSSi9rdDNkdHJKNzA0aGhuOHE4dHYzbFQyMno5?=
 =?utf-8?B?U3NuL3RXRWs5a3pFY2RteTNnMXZRY3lWd2M2T2ZOcmxEeHVtdS9XZWNqb29x?=
 =?utf-8?B?aVpDN3c3S1V2ZHByZTE2TmFKUEVXU2NaQVk0S0kwd0NKdGMzSnM2VHNHUGF6?=
 =?utf-8?B?ODdOeVJiOUJTNWU5cGRsK25SQ2VCWm1jTGRlNXZ3V3pVNFNlMGVjbWxyd1Nw?=
 =?utf-8?B?NkdiQ0YrVnFUa1ZtZ0JGbnhmbFFUcEpxN2RwRDhkR3hseHdhSjFQem1LUUs3?=
 =?utf-8?B?VlVTVzRidGhzVUdMQVpqczdWRHdNM2JyazZhMVNwb2pkajZobThIUVJIT3dO?=
 =?utf-8?B?MzZ4SkV3NlZoY3lGSUJjNzZEY1pqQVhJMkNrdmJtZWZMWnlTTGxaL1hIVGZn?=
 =?utf-8?B?ZTVIUWhmV2JpNmlCdTZad0tDN3BlWFd6YVlFKzhURzcyZlJyNGxsdGNUSVIx?=
 =?utf-8?B?ZlY0N0ZEcHNHcGhWL0ozZGZiWm5jbmxpV2ZWemFNTnFQT3UwbmVoaVp6K3dS?=
 =?utf-8?B?Q09BUzFrL0hMRlM1UjQ1eGJURExPd2NyNTdUaVdnaUdKS1B3Q0t0UXlQWFNW?=
 =?utf-8?B?NGRPVmNYQmZDSEJxMEVVSVRISk1lQlFNK2IzMGVzcjZ2TUo5dDlxNGFnS1NO?=
 =?utf-8?B?T1duY1R4ZGNNZER6eWFscFdxSTVaM1E4Z045OVFKY280OE1kZGRLVFFvbGNh?=
 =?utf-8?B?b3FiZHIzNDErT2RZeTRiT1RTRkJRbE11Nm1Hb3hjOUJjMXhpMWQxZE5DbFhB?=
 =?utf-8?B?YUdrUDJCbjdUcVdFY285WXhVWnlMVlI5UEc1L1dvZDY1RThQOGpyUzZqSERw?=
 =?utf-8?B?OVFKNkJKUXZ5eTR1R3BlM01na3Y5cVREQkRUWXJWcTBONkE5U1NjcFpDcy9z?=
 =?utf-8?B?Y0xYTzJPODZUSG1pY20zVkszeUUxNkRyZ2tVQi93TENLcUJtWWRNdVkzaHEv?=
 =?utf-8?B?NHc0eUFyNmR2bjA2M2IxNytGamNGV0pkeklkemVQd0d5c2cycWRPNUdSTk5W?=
 =?utf-8?B?dGc1bnNwYnNKUDFYYVBvWXBSa3Z0OGlIc05XWEVnNGxrWkxOMXZHRTNYWDFL?=
 =?utf-8?B?Z1EwQ292Y20wSFBBM1VGSklScXlRN2Q1RXErV1RPR0lSSXJ4SU5FdWRsSVlk?=
 =?utf-8?B?VTBaY1l3VXFPS1M4bTU5azZ4ZFhqa3pScW01cjU5MHExUGxVRHN2MHFQR3ND?=
 =?utf-8?B?bHRWaThFcHA4dVJEMnA1M0pnU2RBamg3Y1QzemRzUFN6MEREcGRzaTJ5ODJQ?=
 =?utf-8?B?bjQwUkFqeWpPZGRERU1hSmFMaUpPb3F6TlVpZGRZWWlRN2FoVnFNaVN3SUYz?=
 =?utf-8?B?S1hOMzFrejNSVmVveUR3ekhuczBrQ0kydDc5V1JzeC90QVFvZTUvN2RwRVFF?=
 =?utf-8?B?MFU3WitjblNqVkhSdHczK29ZNXRCMTlLY1ZBYnRjZ2lMZTFmaWFIQW5JaUN3?=
 =?utf-8?B?WTVDUytTZTFBcHg2bWpyUGlkYkZuZ2grZmpJajBCUE9rRld1TFd1NFU3UG9P?=
 =?utf-8?B?ZUtBSlkwbThNaFIzcERWSVEybGEzUWlCMlJkSlZ6UjVNay81Y1lBMGNjRlEw?=
 =?utf-8?B?bUVoV0JlRnFDWExtdjdqUHJpRVJVV29INTJzOUJmZjJobUVMUWFNSzhEa3pS?=
 =?utf-8?B?NXdmV3dHcnF3OStmK3BoeGdQTzJkS1dyWGg5UDlBaU1yelZxYW5iaVdubWVG?=
 =?utf-8?B?Tk1MSnBwZzNVSE1nbFFtT2p5Ym5FSzNrSGpYVjBUcnRKeEpmaExVSkZ2UTZG?=
 =?utf-8?B?T3h2L2ZaZENta3p0UGlOdGsrQnR4N3R5eW9tUGlXK01yZVptbk8yeGh5YzFi?=
 =?utf-8?B?ZWVla05jaUtGTDQ5eFovR1dUcHovNktFcFROcHpnR0FpWkRQRVpDemtCblVo?=
 =?utf-8?Q?dCErq2Sh3R/MIKobnZ3HH02OR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72767b7-3a7c-4c23-4c14-08ddef888c94
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:06:31.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH5gAT2DaeP1kULajc5unN8jeivrVlNZxtF7g3dN1ez7G24g5ZlH74y7yeKkyxtJpAJYPPTYd8dtzpV7VmH1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670


On 08/09/2025 23:19, Jakub Kicinski wrote:
> On Mon, 8 Sep 2025 22:16:29 +0300 Carolina Jubran wrote:
>> However, I’ll also need to extend load.py:
>>
>> 1. Binding support to ensure traffic flows through the specific VLAN
>>       interface.
>> 2. Interval-based measurement for iperf3 --json to analyze only the
>>       stable period.
>>
>> So my plan is:
>>
>> 1. Send v2 for net to fix the current test with interval-based
>>       measurement.
>> 2. Follow up with a patch to extend load.py with reverse/binding/interval
>>       support and then migrate the test to use it.
>>
>> Does that sound good to you?
> Sounds too complicated, this is just a stability improvement for a test
> which works on single device, and is not exercised / reported upstream.
> Let's jump straight to step 2.


Ack, I’ll drop this patch from the series and handle the migration to
load.py and reliability improvements in a follow-up.


