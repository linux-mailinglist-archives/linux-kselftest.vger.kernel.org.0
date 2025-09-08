Return-Path: <linux-kselftest+bounces-40985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACEBB4999D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B2417F9E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEE239E61;
	Mon,  8 Sep 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ts7M+VN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5701B21BD;
	Mon,  8 Sep 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359000; cv=fail; b=Oq4V1AuL+7SEj2vKcNWHhEpuXAtySiRKSZ02hTWJP2QZmjOhxQYVWbLJVI2UYIhUSHopWVM4fjo7GIVQfailoQgd2qbEfLI37LlIycA96Cv0lQPqXz0iLx8k0bf1EphhqGyIMWZW24FXAbuZYD1qckdPbxDscjP2q7FLanFRSsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359000; c=relaxed/simple;
	bh=7MRqYhTU+j+UeZ5Kn4EPKXxaOEYL5MABJCuOdzKYxb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XsvO0k7KJIeQaExtL1X8pnQjJ0bdjm0p90mlbwX+KT8r6988lNQmi570WzKeKWTyCypIIxaSe7VvKo53xj67sdNQ5mH1tfMgmdfjmEvNpr+s55U5ccELDBiGpwHW+aDwLMaETqXEfXMUM2n8UPPs4Qlsoesru8gOMCDsKKp/v6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ts7M+VN5; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5JLmp76yi6TRjP9P7afR3T4711KS/8fV6hqFDxMwZKg5SaI5KyE2ayg/sPXpXlklYu4hcqDPrH7n0KpK0JBSYUtDrVenkojPNc26tblX9Dggurpun0KnPBFiPu5JCtHGoctCYBDjVTYfjS2BksWJoF79cJ7dT/USRSQZzFIigiU4teHvrytoZlwEA02HRy+PAFSF6fruQkgspUDwP2cLtJurRzYmRhBqSWhNKIyOv9jV8U5gaV3/Vvz8FGfXHlLvRJ3VgCy0Y0kEizXGayJBwCLTkfdkEjD55iDyLYNVD/UBrwU7edh4KQR+8DU335mrS97XcON+kl/StsoRlvsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MRqYhTU+j+UeZ5Kn4EPKXxaOEYL5MABJCuOdzKYxb8=;
 b=yxHGLdqZUnKfENMWv/cyQXXEa0R62OSDZ55Nso7Ovv05KDSfFcklnSMFC8jkmjrcEH5SLINvsh76mhqtOwibDXavMxIcbYSCTbcOca0kXD+ZxKOZDhRZ/OPRxH1vtWOIsZoHmAvVwWX8W0E3C8Cdk+4ob2Kj9py6tFac6XDS4zMrtpY1q4czwuzjNbNjajPKx1vs+57+9AehDXcC9IqZRVfoQbczkXJfptkWFzm4UOOzLUIbrzdfwe/3QWbR4tT02+/7jVtHcBjjr6i7rfISTnnxL/+J6u7OmfGu+t9rc+UZgDaI9ZVwfUsLndnisbETXcZ0I1gVf9iTqFHHyfEL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MRqYhTU+j+UeZ5Kn4EPKXxaOEYL5MABJCuOdzKYxb8=;
 b=ts7M+VN5wu8nMeMzptYrRQ2Lkj6+2ZImJh/rQ/u4XAwqIrEBQ7moLkwbx5Fl4el0to7d6Rh6gETgOMYM+QY1FTgfRodMZMSb2O4kNr4uPSHglHWPEl0BYG7R0t5JPrX8xJzk+qXOammMDzKwuKmGWeASbEskT2KDbI207DtU9l6+IO+FG09abPZjrqKAqFmuTbHsRDSN65HIaq0KiS/kZX5aK+PgnBldnUoNhIZwv9qyt7fxnV22cfh6k7zrP+LA8QEZo9ovAzdIRnFWGEa7i905Iy7Ca7t1FoHs6GowMbtV2Ur1XpLrr1MAVXGl+s9f71L9QUU0MP4GNyM8/7OJPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:16:36 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:16:36 +0000
Message-ID: <0cd98e25-b387-452b-b1a6-414ab20a4cf3@nvidia.com>
Date: Mon, 8 Sep 2025 22:16:29 +0300
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
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250905153243.6c03e257@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5ded5f-c472-4868-bc8d-08ddef0c3a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUJ5dHhYVlhLekVVbTRVOGlVOU40UmNDNnp6N05jeU9xV1VEYnNUaHdUSXps?=
 =?utf-8?B?Z3BSTUJhRDV0UnBHTVgvT1VlT1ltdW1LOCtIM1puK3E4bWFkOEtVT0FRcGg0?=
 =?utf-8?B?dGFIMU5maElSMDV6c3YxOXNTNXRmc2prcysyV3FrVzQxeHJiOUJ3WndZaitG?=
 =?utf-8?B?a1dwampqL3hTTlVyZE80dk0ySHhoUFJYUHJoRFJtNzBweXFpV2RYVEhTLzNw?=
 =?utf-8?B?cEdoTnJtRG04blFmcG44Y3ZlZzduSUlZNUg0QnhJWFFYWVo1UWNPMVlHZlJ3?=
 =?utf-8?B?TFQybVZPZUdQV1IrdHc3Rk90ZGJWM0VYUUdNaGpESjVxR1hmbVBwSkpEUHJS?=
 =?utf-8?B?K29DOVk4VmFydkgwU3FHY2xVVVNaQ1pVL0JWcHhkYm16cmlmRDRJeExncytD?=
 =?utf-8?B?YmV4aTJyRktEUXdESWFpLzV0Z21vMVpOd0lXY0d6L3FBY290ZDU4TTRwbjdJ?=
 =?utf-8?B?dkV3SnpzNkdSOG1weHNjdm0wVjlEYmlsbTFlNzc5MUVUUWpPYklXMzNsVXFJ?=
 =?utf-8?B?Z0daL1dtendWeTBXbzk3UVFOWXdwUnRQdWwrZWhjcndmL2pLRlRGOWZ0aXBK?=
 =?utf-8?B?M2wxYWdDZlNJdWxnSytTbjVnQytrZUwrdXZjaEZha004WkNSUUFCNmZBMnI3?=
 =?utf-8?B?eFZGcWRtL3pOdTA3M1pRVXIzdlVTZTdqZmY4SzZOSG41c3lDbEg5WDJNb25B?=
 =?utf-8?B?SEJJZVVGQ0xlcENWU1RLd0hLK3FNTzV3bTExWWRwejVDS0s3WUE4bWowcXpZ?=
 =?utf-8?B?Y2tvYU0vWEppSDNLVVdWT0p4aFJpY1VBejJubmFCYTRmdWJBb3J3L1I1ZDZH?=
 =?utf-8?B?OUphSTJRREpJOXdnb0daVlR2OWZzVndwSEtNQ0RZdkxXSWNxSm9kMC9tN0hG?=
 =?utf-8?B?c0RqMitvdHcyeTVRak1xaEljNG9vRlNpd1ZKUjRzME03eDlTaFhtZTl0b3pX?=
 =?utf-8?B?NUp6cEFEQjNHRHcrcUlUU2Y5ZDYzanNuMFRyelR5TG9uYkJFRmwrM3l4aURO?=
 =?utf-8?B?Z3JvSURteVM4RXAydmlTUGVHVXZzQjZlcHZNS0JDbnBWTjJSVFhQVUhDSTVq?=
 =?utf-8?B?MExRakxIQ3ZHTGVNMlpBQXM2M3JoTGZLYUh5VGVXMkF2Z0JtcUlHRmdjMFpL?=
 =?utf-8?B?c0tGS1dwcm8zbklud3YxbHhpcWRQSjNkdC9ad0xiZEt2c3dSRGZsRjV4OGhi?=
 =?utf-8?B?K05YTnd4WDZvZjBWeHJ4TnlLOWRteUlsNWZzV2NlNlBLbjBZQnRoTUxFSEdT?=
 =?utf-8?B?YkxzKzdTWmdWSzBlTjltNFB2OFhmUmMrYUcrTlhyaUhsVFRnVUd4a2dEVG1T?=
 =?utf-8?B?NXJuQWpVTGEwUkV6NTNwMURadmtXeE12RDQ1elQ0TFlrQlRINExiTDBYZnht?=
 =?utf-8?B?MDF0cGs4dzcvcnpDcURSZnZ6M3hDemZjUmFyRTVGL0g4aW5MSnhIYldua0V5?=
 =?utf-8?B?U2ZmNDRDU21Cams3TFVXQndqeStqdHdaZDBSRDNnSWtiTlU1VjltS1l1dHl4?=
 =?utf-8?B?bDZkcEpPT3B0K3cyZVQyckZqMmpzNFQ3WHB6S28rVEFYSVZjVEFjZWI2UFF1?=
 =?utf-8?B?M2xWd1MyNU1rY0V0NktPbTFaR1lTUjAvN1Y4UEZ2T0JuWDBsbWlFNDlrNWVI?=
 =?utf-8?B?RHhyYmVzeHA2d2pvVm9odmZMUDlFaCtaQXBNWHVRNXd6U3JOOXFUMzRrZk1N?=
 =?utf-8?B?RW02RVE1NUR0ZCtxL0xXaTVKQmhBaU5vYXZZaUxRZHhxYURmeC9VTmo3TjJK?=
 =?utf-8?B?NmNGN3Zld2l6RWJWNUxnOCszbm15bHhsK25GSzlCNXNiSlFDaVo3NzVHRTV3?=
 =?utf-8?B?RGNFL2dvZzU1U0N2QWdSUFhYc01IeGwxR0ZYaCtNSjZuOTJhbHB6QjZENkFK?=
 =?utf-8?B?aTlLVm5FOEwxVUk2aHFoRDE0akN6VFpWQmw2RHlnMWI4aDdJY0pjYWNEZFdn?=
 =?utf-8?Q?Y8CTAbP+lOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNWWStuS3BEWkVKK2dBcGpWSWJBbnRHZFllYW9oaXByZFh0L2cvZGhUaER0?=
 =?utf-8?B?bWN2enlGd3JuUEJaZ1JhZUN2bkNsUzQ2eTcvYzdNclNKTWgvbDdEYnE1OW1t?=
 =?utf-8?B?ZHVmcGhmMThUbktiTXZTTkZCZ0N3UEhQWmZRdUxlWWJsTnFNRE1reVVHVVVX?=
 =?utf-8?B?djV2QkN6QUVNNU5XcmdoaTJnVXpYbkFub0RiOWM2K1JBT1lIdE1QMGh1QnpS?=
 =?utf-8?B?VGNQdHdtT3J3UWRLQWFpRVJoN2syUTd3cE0yQithaVNXY1dzS1E2bytMZnBu?=
 =?utf-8?B?RlBpbkNmZWVUSHRhVWZCWE9mSVE2VC9xb3QxVnpIb3l3cG9QVFlySkdFeUZB?=
 =?utf-8?B?V0xTejlRMDRUSnZaeWRzRG5BUW10b3lRWVkxb0RFU2ZsT3JDVFd3SDQ4eVlk?=
 =?utf-8?B?LzJmZ1JlSTZ0b2JzVUlRLzFoVitxMk5uS0xGREFzQThPSnc0Tk5MTEpsTGEx?=
 =?utf-8?B?QzByQW9Sck1WaTY4WVRLVnJ2QVczZnhSZzNXN01hR1pWTk9tdVVZZDVoYkpt?=
 =?utf-8?B?MDZHdW9NNVorNFRJOWM4dFd2cXRBUjJaRVZBTGJBamdjMUdqcE1TcU81a25W?=
 =?utf-8?B?N2hJRmg3VGVIeCtWWGVCZkxPMXF1VUM1SnN0aEcvL1BwcWlOdkQzZUd1R0Z4?=
 =?utf-8?B?S1Vrc3hNVyt2RXJmVlUyZUlqSjI4UVM0ZzFJN3IyWXFWR29EcmpNOVdxLzZ1?=
 =?utf-8?B?Y2Z5ZkNtS0t4UFJUWFRXOFN1Q0J0Znh4NHl4UzZETXI2WmhHYTEwanlSd3Er?=
 =?utf-8?B?dUQwTUVvRVdET0I2QmM4NE5FelBySWRqWUNBaWdJb0k0eHFkbmViZ0FDZnBl?=
 =?utf-8?B?YWNHekdTemRtd0JNWGJIcSt5MmYwVDI0OXdvNDY0YVppKyt4UWZGcTl4WkVC?=
 =?utf-8?B?WUk2TlM2US9LWnZySFRhQ1NhMTgxZlpzZWt3dU5lbmVoNmNsb2YrWHZlZ3Va?=
 =?utf-8?B?a2ZxdXplTnFaaEJJTi8zUG82K1dlM3VFbGZ5QjU3T2tuUHljSmswZWJ6a2w4?=
 =?utf-8?B?aDVxbXoweUFkWmw2ZmxnSGVWSDUybkQrQUlVbkJEenVEcEplRWpmNHV6ZFZN?=
 =?utf-8?B?SUhUV0l4anpyQzVxR2tXUnhzVTIxU1VnR3VMT29ZeVp1S05zRGd3VGhhajhm?=
 =?utf-8?B?eTlnTVUvR2krV0crYU1zbXRSV1FDK0V0aVY4d3hSZkR0RU5TN05pM1lNb0Rh?=
 =?utf-8?B?cjBBNHp0VDZkVnVHNFkyTnRWbEN4RDFyQk95bGdoT3pXeDkvaSsreEVLOVpK?=
 =?utf-8?B?aFhjQWdaS3NOS3U2ZVlvNFdVcisxcm96Rkd0aVV0WjdVUnNQN3FVR0Z2a25W?=
 =?utf-8?B?eXdjc3pJRDRmeW1QcURhWVN3TDk1ODdXTWhCLzZpMjA1L20zZHJtRnREdjVn?=
 =?utf-8?B?eDdKWjRVUWl5bk9PdkVSbU54ZlRlc0J3eFBQU0M0eUZsRko4djB6ZVVqSVpv?=
 =?utf-8?B?UHB5bG1oMXpCVXlzTkd4N0J6emhwZ2lZaXc4OWh5anFDS1d0MXRkM0NNZTkx?=
 =?utf-8?B?MFJRajdiRVBZd0hJdnRreWFMWG1wbzl6UTk3VkZ2WnQycUljZ0cwcEhPVVY0?=
 =?utf-8?B?ZTBWMGNNS2FYNFhrSko2elBwK2h4UGt0RGNVa3piaThmd3RMcm9KTjMrTkoy?=
 =?utf-8?B?Q3RTeXExd2ZiY1dlSExFbFNPRVovSkRyVER0VFJXSytOQnJOeld5RWxlVExQ?=
 =?utf-8?B?ZFpoRmwyZUpSRllydzBhTlJTSXRXRzg0OUZtR2M0ZndZY1U5OVl6TTdlR0V6?=
 =?utf-8?B?N1F5QWhxNVdLbnhVeU93NFdKT3pRbHJHZUNoTEhsaW5EQTNJNEhRM3FXQmox?=
 =?utf-8?B?eEZmQkFvL0FiTHRlVnhOTm9EcXhQUG9Ib1U0djQ3YnI4ZUROYXhMbEt6eEZ2?=
 =?utf-8?B?WG4xbnZzbnB6Ynh0ZFNKNnRjaTVqQnAzaUg0R2xna3JjNE00ekYxVUdXZXZ0?=
 =?utf-8?B?bG95amkvcGszV216YUwzOERjZXZvVHZ3NUI2UFVCdDNwWU1ramRYZFYrQ1Fm?=
 =?utf-8?B?U005YWZ0MzhTTTRQWEdVQVMwRTFlV05NMktpbkQ5RW5FR2dwUGZmTDdCRGRU?=
 =?utf-8?B?cGNDOU1PcFNHUEhSTXphUWpsc2pISnprSDZ4UHh5aVZNWGYyS2d0Qkh4MGdC?=
 =?utf-8?Q?Ns42aZrPLcIiqFHVwTx7hgrsJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5ded5f-c472-4868-bc8d-08ddef0c3a9e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:16:36.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmH0nITkoC1vgLteIESU7nHXHRz+8su+LzHYLR5GNZUE1vujKEQTrcxC3n/Xm33V3rLv/YMNqkP/8ARiMkmtCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752


On 06/09/2025 1:32, Jakub Kicinski wrote:
> On Tue, 2 Sep 2025 16:21:01 -0700 Jakub Kicinski wrote:
>> On Sun, 31 Aug 2025 11:06:41 +0300 Carolina Jubran wrote:
>>> Because the measured total is the sum of two iperf3 streams that do not
>>> always start or stop at the same time
>> That's solvable, tho? iperf3 has --json support, it will give you
>> the b/w readings in the configured intervals (1sec by default).
>> With the interval based samples at hand you should be able to select
>> only the period in which b/w is stable ("middle" of the test).
>>
>> While at it it may make sense to switch to lib/py/load.py wrappers
>> rather than threading the python locally in the test.
> Hi Carolina! I think you replied to me but the reply never reached
> the list, I purged it from my inbox before realizing.
:O Sorry about that
> I think you said that the direction of the flows is wrong for load.py.
Yes, that’s exactly what I said.
> Perhaps adding a reverse= attr which will translate the --reverse in
> the client process would do?

However, I’ll also need to extend load.py:

1. Binding support to ensure traffic flows through the specific VLAN
     interface.
2. Interval-based measurement for iperf3 --json to analyze only the
     stable period.

So my plan is:

1. Send v2 for net to fix the current test with interval-based
     measurement.
2. Follow up with a patch to extend load.py with reverse/binding/interval
     support and then migrate the test to use it.

Does that sound good to you?

Thanks again for the suggestion :)


