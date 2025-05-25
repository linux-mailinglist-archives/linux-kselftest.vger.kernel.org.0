Return-Path: <linux-kselftest+bounces-33758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABCAC36BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17991893D38
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47518DF80;
	Sun, 25 May 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXnybs2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39247F9;
	Sun, 25 May 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748205077; cv=fail; b=Vt/TszH05yX/Ph95GyXSFE6PGeSryPkOm2AFkGFXtuyWhvwQb1WetYDC8UjZtaMd+Ja0AbWfpvg1drmNYuNyt+g/iJ5GJ1fLCUaLNY888LFMTEY55OOkJ5OJfjQagkxbSK4mVEpY36TZhiVqat64eaykoU0LX1yr+sqqg7cz+6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748205077; c=relaxed/simple;
	bh=g83MZvlDdbyM5TWteeR6U7U3oyTvRd5TtxL3rE4tTjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpXyT2IVtBx4+M1Gelzdn6xdn2y0ZcNbQdxjiv36F0SgZQfHUicmQwka07Vxt3eTcVDU5ddGkWp4jlyosC5h2hEcFZGkiXe3IvrOUyvYqnxniFjd1tzoWr0D8rnHPi+LitiHMewN8+MMn6Po6pNLNncqEmeSgMwurASZqzAhc9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXnybs2X; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhyWJHKe5s1TLeRI0rSWaHdOKzOkTvY9PmlUJyrn3Vk3+yyawStnoG8GgnmG/MrXtm7IUoNE9uxCH2f0xAb5pubrqwgHji+81mG8zbGpBwFoz0iyW6T0WgsCFOUepDsrJ11Osbza2FZG7T2PLxI3cqFM8quTUNhdtMtJQcJvz43j7GzcXOAr33F7g70wXYnVmjNoO0CqTEPDzo6LqlXFw6wUHJVrKykHu/cAjGeluc8g2ilkeRqmmQ09mJDX4+lPwgrstfBC2MwLMhN4N2pIVbAd3Ojrm8xz/FydKbCyZizTWF1Evmhay5SQsKyLnhnmJ4M7ZUqHhK6qJIhnSV+NFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krnJaukq++C57Z1QDW65zgCiwWvQHJFfQoRxOlXY9Ig=;
 b=sQ2f5t0HX/Vih6bUj02eJupO0iwV90YQUzdVyz5InhqlN0HCFDzvswasDlb5cPGCltuo0Ojzc+5c1ED0ySkKFs/7VmJbqTvrLGZyQj4zp0N3C57rj+dTOACNewEQiR7zEuZpHCRTVJ6GhxKK1+BqX6ty0BQ+kLIXuqfCas+LYbkbjTpVB3sWOKkAuKLidOETIzpp0zW69nCR1gcg6s4JgcPsujiM0ytymNLrsuoacxxl3o+Hq1iDn8H+9iJj0aiRAJ2UcytkJ6rzZ4seSNjo5x7Oz9zkvOiaODfCwq7rLgLnrFsaBO55Y7H+LcDBohNU/89Ixgh13RO//itjkzaZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krnJaukq++C57Z1QDW65zgCiwWvQHJFfQoRxOlXY9Ig=;
 b=QXnybs2Xz0KLusaJsVFGzDvU5PJTD/mD4VrXw2VXnSQhwzrugs9WanIAlkV2CiNcuLLD+WKIjMLRsUeJKxo1HBc54qe+mUOEMkCUCSngxwYBoy65JwxhH0k49qp6YGWjopYL7ouB4CwxEDaNgs3kSldF+DUKUY6i8x/I+F5RP7YkNCQ+zzhqG5X0UJAaCw2ya/ovOiDpcVqLok5Xv9ud3Z0x+ZD2m97rfLuwX1p21TCM7/8t6i47Tedj7AO6l66M+yXV1epXgIRADxm/hTqgoXz8IPGWYhd1h/jiPyrVdD20lusLF5HfroriRAuQJWR2rTg5tkH4DbiTBHK63AMtPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 20:31:11 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8769.019; Sun, 25 May 2025
 20:31:10 +0000
Message-ID: <3a3ce4c2-5cc1-4deb-be47-d936b61c42c4@nvidia.com>
Date: Sun, 25 May 2025 23:31:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
 <1747766287-950144-3-git-send-email-tariqt@nvidia.com>
 <20250520155957.04b27217@kernel.org>
 <80b40828-8fa3-4313-8c98-823ac7c055c1@gmail.com>
 <20250521071007.0cb6f546@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250521071007.0cb6f546@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: c03dc37e-ec15-404a-810f-08dd9bcb15b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVhDWmFLck5FY0pFblFINUdEdzkxcnpmMm1yZWRUTlZCNHl4ZElyU3RleURF?=
 =?utf-8?B?SmdTQk5RaXZxdzkzQWF0MjJmSzUwNW5oM1A0bjVCejZDOUwzbTkzR3hhOUpo?=
 =?utf-8?B?a0xoQnl1YjZjUUd5VWFBcFlZODBPOWxKTlhvRDB5TDhnYkQ2YWljQUVwS0oy?=
 =?utf-8?B?cDBtZTJBSFhQY0tpM1hGbDk4QWo0ZVFsOWI4d2UzcWtFODNCcTlOQ0FDRWVn?=
 =?utf-8?B?T2w1d0ROaHRjR2NSenBVNUgzaU5mSXI4bUhzS2lzWjlmVlc3NTFpNUZyUktV?=
 =?utf-8?B?anZMeVBIdUsyUVYrWnVYaXlBMzAxNUlHQ1FtY3ZMZFV0aUFISXdSQXdtdk9Y?=
 =?utf-8?B?MmtBdXhIN2JDY1A2T29sLzJmUHNPWTZabGJGTUxWSlBkcm1jNWI5UkxVSk1u?=
 =?utf-8?B?TU5yOXpiU3FWTWwxeUYxUWxQZnFES0ljYkwwUG1XbU1xSU1HaUtoQ1daeDAz?=
 =?utf-8?B?L2Y5WWJxOVc0UVdSVTI5bVhqUFVOK1Q5cUVtWVBRM0JuRVlnSFI4amRkSmJ2?=
 =?utf-8?B?YkpZcjlsZWNYN2dxNjlOa1kxUlEwSWd0dzM4Q1Y1MFZ5bmozenV4WXdyTE9i?=
 =?utf-8?B?Z0xsaXZ4bjhtaXBOSXVZcVdBNzVDUm1IenpzRDRjYUVqckRra3RSMDl6Ulkz?=
 =?utf-8?B?dVlWejNJeFgzMEEyWXZ5L3c5WVdHWGpjSXNtZmVTT0FyWGNBSDBablVsL2VQ?=
 =?utf-8?B?Z05iNTlLTmJLQUwrRzFTYTgyZ1VNZE5xWnJBVFMrZTh4dEQ2STM0Q0ZjajJq?=
 =?utf-8?B?c0t1cTRMUS9sZHV2c3pSNlJ4aHBBOTQ1cEQvN1p4Wm5QOGVqS2hTRTdETzJr?=
 =?utf-8?B?T080ck5yLzRkajA2OFZibm0xdUh6VC90ZjlrK3pWcy9rVjBUOFRpL2JMREU3?=
 =?utf-8?B?UjdoeS8rUklyUnFGUUx2OTVlK3ZtL1JVeHhtYm95VUh6Q2FkWnFESkJ6b3V4?=
 =?utf-8?B?UVpxQkN6WXVGaUZ3cWV1ZWdrQnNkTkFYRS9yV29PUnZxdDJsdEI4enBaMmdY?=
 =?utf-8?B?bXIvTTNBWmQ4cks5MlF4Y3JuQjRXRTdUVXladGhWR0NYNlpQRWRUU095LzRB?=
 =?utf-8?B?ek84VnIzSEV4TENSbnovTTZYV1UzNW9JSjQzTkdFVFUwWks0SXFhRGdDWDJ0?=
 =?utf-8?B?aU1MMGpJMDR6T2k3ekZjT3JLRVhmS09BSjNqVXltZ2lZMzFIc1N4VmtTeG1O?=
 =?utf-8?B?TENrUWd6S2Y2Q3VZQ3pHMmtaS0hwWTYwUFZZeEg1N0FtWEVKc05UOHJJUjUr?=
 =?utf-8?B?bHIyNWNVNThnWE0zNE5mM1FqeGloU2RhWGF5M0cyS29SR3EvS1Qwd2JZY0dx?=
 =?utf-8?B?bk92SWgrWEg4ZFJLbVN3NkVVU2czdW1pQmV0SGJNaGpDVnlRSVFKVHV0KzVB?=
 =?utf-8?B?cE43dzBHZHlhUUJZamNycVEwenphM3FubTBKVmZ0VlBpZUVadVBvRkdBL2t1?=
 =?utf-8?B?U1ZHbnpXVi94MFAwQS9VUTJ1V0tFZGtVcUVzWkh3OWRDZXU5RHZxR0REajJl?=
 =?utf-8?B?RmtBTEhUTHRnSUE0UGZNMkhRcnJPVk91cTA4Qk51VC9PWE5hdm1RRnBsd3RO?=
 =?utf-8?B?eTVMd01jeGkyL1Q4SXJ4KzV0TkJ2VUMxcWZTY0RJMW9rbGlWZlpuVEdNMDhn?=
 =?utf-8?B?RnBhcHc3VVA5enZJU2dUeE1uKzZtM2tyeDNieUFUbm1PcUVHV05JdHVFc3RL?=
 =?utf-8?B?TnBkTGNaRFZNcjZMUXVabjloVjZRS2lETDFPdlFydERiZkt3aU9mTTVKd3lk?=
 =?utf-8?B?MzBRN1V0VUIrTlNhN2o3L3creW1peEFscEhOMk85UU9LaFhKV1lKUGRmM3Zs?=
 =?utf-8?B?NHdvNWoyTGt5Mms1TXZzZTZLbW9vNGlJNXYxNmQzVitkaks0NEFLcW9OamhO?=
 =?utf-8?B?UUFtd05DTWtVUTBOL2RvblUxNFZKdkJ3YWs1SDJBellzUUZwaFFuMWJXcDhi?=
 =?utf-8?Q?oorg9qQtyHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cURQNDVJZlNyLys2MEhrTDBVcnlkdndBbkxjcEtkbUlFTjMvNlZtYW85eUpY?=
 =?utf-8?B?Zm1PazVmQ1Z3TUZYS3ZyZ2cvUVI4dytpTFR3M2ZOMmk2YjZsNEE5ZFZNRzVE?=
 =?utf-8?B?THRCNktLZ3JOWDNndHgycnNtOVh2RmpudzZkc1BxUllXVisrYnF0UTN2Zkti?=
 =?utf-8?B?NDFlUVlHZjJRTTArS2U2enBPUTJyNXZtMTZLMTVpREpOL3BYZmNGaVJBZktw?=
 =?utf-8?B?cGVpSTdKRndBZ2JoZkd0dUVybUNqS3ZtbTE3OWErWHFTb0VoRnJYbDhUM2NH?=
 =?utf-8?B?cHNOU0hQR3p3TndkRzlHYm8rb1pCZjVmSnY4aTAxcWFJNi9iV1I2bjd6bFpq?=
 =?utf-8?B?QUQrdWR6SHVpUmRpVHJrTk13ZDdINWJYdTB2NGRadHNPQ1VoQWwrSEpOMVJE?=
 =?utf-8?B?OGpoUzBZL09IWEgya3JoalBhaHRmQ2svNVhVSTI5RDQyTnFnaUVKN2JBNE9Z?=
 =?utf-8?B?cmUxQTZVMUdxeHNnS3JOOVd1VGxiM2tvUVZSckV3bk41REFGeGVkdHkzZGJz?=
 =?utf-8?B?MjRkaS9pV0hHaEdSd0hNOWFtNEdmcXluZ1I5NkhyMDV2akpncWcyUkthbm4w?=
 =?utf-8?B?NWxVcjI5bitRK0dyMnpFRDYwL3cyNkxReThKUkhyWGlqWnFOdHhsQkpxRFNq?=
 =?utf-8?B?WEV3U21xV243WHN3Y1R5Y3I3RGFxWFNzVjNjaXNMeEpjSFFJRmlWZU5OYVNm?=
 =?utf-8?B?aEt5cVVkb1VEaGtyM3dXcWwvNWp5Q1V2NjBjY0JXK0ZpRk9wSnM5MTFRMkFP?=
 =?utf-8?B?VEQ4eUJMQmtta3ZtZ0I0eG9uMW1ydFI0RlVEaFd3OXFsNW5HY1pCR3duSU5x?=
 =?utf-8?B?TEZjL1pVMFE2TVU3ejBaL3ZSVWtqQ09JRm5UWVRKTklPUktkbGJPMEpvaFZy?=
 =?utf-8?B?NHJwZndlUmQ3eUs3QlZPQUpEeTg2NXluZmh5dVArNVFBS0x6em5pTFBPTFlk?=
 =?utf-8?B?QnlWYlJsRTZQc0dYWEtOMzlNa2dmUyt2QksvMEJkdTQ3am55cVZQWEpobXBR?=
 =?utf-8?B?LzhBV3dZNE5Wc1B4RVBIQkFiZ0ppOThDenFMb3pqOFBIekVlczBmTlZWdWpo?=
 =?utf-8?B?dWs1WGNzQVFrS2FnRk5IOVhJUXhpSXJoNzRQdDY3YTJqOU1qdy9WcnUwS0d0?=
 =?utf-8?B?aUcxaHJwNGxJV3ZybVFkSXMwYU9qSEplMXNFM2daQUhoc1BqdjArMUNlSlVM?=
 =?utf-8?B?MUk4UHo2UkhzTFUzU0Y1ZEx3LzVuRjZDK2RYRnFON0t3U0hhL1dqOVlLUFA0?=
 =?utf-8?B?cmhHVi8vaHJPRDlVWDlDdDM1L2RRNVZCTmVOd0JvZVdlaU1kMXkrejBQZDJ3?=
 =?utf-8?B?eDQ3aEZ2MThSVG1kQTJPeEwycFFxaW80ZkhjazNQNndyQkJZbDljNGtEaFl3?=
 =?utf-8?B?c1JQY1R2NHpmbnZIeFRkY1I5U1Nvb3ZwczhIUjVsNkZrOStEMzRiVUhPRFps?=
 =?utf-8?B?Y01jVkFscGp3WDJ6a2RFWCsrQ21SMEFoOG9aWHkrazNWWjU5WURYclF5WXVy?=
 =?utf-8?B?RHJhbWppS1hhcmhHVGVZU0lWVmdSdC96dzlldExPUXRhakRFejc1eVkxSU82?=
 =?utf-8?B?R2NuMWJacGVXOGljd1hhZFRqSjZlOTd1eVNiWnB3blQ2OVFQVWtNOWpLRlhp?=
 =?utf-8?B?MHVMNndTbmdnVE1oSWNjWEZ4UHd5bVk4L2FSUzg1U0FmcDNPcTA0UnluZWxx?=
 =?utf-8?B?eEFUS3J0R3BTUWx2Tm8zbmhVY2g4RUtrZUpHSkxhSHQxREdEOElDLzl6YVQy?=
 =?utf-8?B?QXdXL2pMYVFHZXY2Y2VBd1VzYWgyNk1tckRYWEIxNWJIVDlQVTAzTUNqaDZY?=
 =?utf-8?B?UnhUNEN6bVZDU2U4Nk9lQ1FXM1RHbElMd21aUTloY3VWWHgxWHB6VjB1QkNO?=
 =?utf-8?B?MGl4R2RkYTZHV05XNlNRNzRoazVPVW9uMHpHMXRNaS9rZXpnZkx4bHl2cTZY?=
 =?utf-8?B?eUNzYmpPMHYweW1iTXlnMTVVTm9VdWNITnpmV1lDSXRidGZOMVZ3VlBZSFdW?=
 =?utf-8?B?dGRsRTBVZkpDU05OZEdWSWE0dk5SL2RIdEIybUhlS1pQSHk5ampic3IxVUls?=
 =?utf-8?B?SUJhZEJrMDFKOG04R0MrcUpuZWpnK2djTlVVVUFadXBUcHhhbHBZemNpMDlM?=
 =?utf-8?Q?MJgDCoEQJhPXzogDU9am8j65m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03dc37e-ec15-404a-810f-08dd9bcb15b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 20:31:10.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+QKUnzgttlk7CCUSU4/x2zCCM9BKNjC5EfB64yXFNx2hMAghm8FrhOjrgR1j2DC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

On 21/05/2025 17:10, Jakub Kicinski wrote:
>> We could've saved this extra cycle if my questions [1] exactly about 
>> this topic weren't ignored.
>> Area is vague and not well defined. We can continue with the iterative 
>> guess and fix cycles, or alternatively get it clearly and formally defined.
> 
> I started a couple of times on answering but my hands go a little limb
> when I have to explain things so obvious like "testing is a crucial part
> of software development" :S

You're acting as if kernel testing is obvious, and the only way to test
the kernel is through selftests. The kernel and networking subsystem are
tested regardless of selftests, the fact that you don't see the tests
does not mean it doesn't happen.

We are not new contributors, plenty of uapi changes have been merged
without selftests, it's natural for us to try and understand this new
requirement.

> I mean.. nvidia certainly tests their code, so I'm not sure where the disconnect is. 

Absolutely!
Our testing and coverage are far more complex and valuable than what the
existing selftests provide.

We have testing infrastructure that predates these recent selftests
addition by years, and we don't plan on switching them to something
inferior.

Writing selftests will not replace our internal tests, we're wasting
extra cycles adapting our tests to yet another project, just for the
sake of having them in the kernel tree?

> I had a short conversation with
> Gal at some conference where he, AFAIU, was doubting that device testing
> can be part of an open source project.

What's your point?
Did that prevent me from being a top 10 netdev selftests contributor in
v6.15?

I don't care if tests are open source or not, I care about having good
tests that run often and report bugs and regressions.

> 
> It certainly is not advantageous to companies to have to share their
> test code. So when you ask me for details on the rules what I hear is
> "how can we make sure we do as little as possible".

No, I'm asking for predictability, we've been circling this point for
quite some time.

We shouldn't have to wait until v9 to guess whether a certain submission
requires the addition of a test.
We shouldn't submit a bug fix, to find out that it's blocked due to lack
of a test.

As an example, we have well documented coding style, so:
- You don't have to waste your time commenting on things that could have
been handled before submission.
- Rules are clear, comments don't rely on personal taste or mood.
- Developers learn, number of review iterations are reduced.

What's the difference with documenting requirements for tests? We can't
read your mind.

> 
> Broadly, any new uAPI should come with tests which exercise the
> functionality.

I'm fine with this definition (though I think it's too vague), can I add
it to maintainer-netdev.rst?

