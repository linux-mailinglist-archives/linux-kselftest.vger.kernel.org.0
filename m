Return-Path: <linux-kselftest+bounces-34632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFECDAD46F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 01:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF08818890A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF1220F2B;
	Tue, 10 Jun 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JcilSOcL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F491E835D;
	Tue, 10 Jun 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599223; cv=fail; b=jRtNsml5DfHHB3oXVpzyy5aal6t3ojZ0ILsw9GE3OKAoVVQ4pI/VU7QLp7OZwTgiu4Mxr3f3oFPvPmhSHR6r5WeKchNBVFELiFjgA2vaWRkyb3tPJOy7Fd4j2Pj1yqNkS2gkDZJiSIQVg5QKs9bRH1AMd3gadxLLPRYip29ksPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599223; c=relaxed/simple;
	bh=RLWPpS6Yb6RG7giFPvAVmMXOelNWhh7dUVefA8kfmXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjOlVXtbhuENRv1/yABxTsbYBR/UOFkj/znLb6bqODC/ufe9MmY24CzIlGS9uxgyGw5g8917c+xmapRIDE7+OYwAnDUk4AxT3cmhVqS5nI/DKuXubGzNKT9zSCknGuWj1gRyFYKppfp0rBNse7ZGxL5ztndZtFPk0EoAWhwBWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JcilSOcL; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGueSFsyYJxdCUomhwWIeA3iz88Mf3VVpYL7eZBKV0FnnjCiJFPoxCZv11FXvmodwm5aRRY6A0P/Pse1LEud2kiwg8V9dBXFY1wE7xC+Z80pzTDN03VNScbjY/T3BzR7cKyt/aUH6GhRGe6vgVZYyBWrSfekMDhvQjp0F+x01t3fFqJCvLiHfjCMax3v7dQP6eJv8dpkhKE02w1AS0TeFWiubU0KCszwB030pE/20CmYNvxyu185eu4Z3xnpRkXanqXXBwaOQZjAT2EFiFTt2M2Jmtc+HDWcUHDwjwkWNsH3tFH30ml4a5LucWP1uo/hIHmEYnTIDiFMKr1nnAzxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uHtrNdVXuNCWCbMXj5mIBrxlziasw4jzxJY41lj0M0=;
 b=XYOYlyFvBcr5/BZyNTA2YGTm8l4PkEPa/m1wOEEVo2ka6tuyzWeCFvjr31npdgdsBsbQ17wZWDqZoZUvCAWo0hJ3jqTkFvsYeZ99YHMi3EfFw/f5I57H6wBDhfQwxYIazqNvvNieB1vvr2MggjD/n93siPx1e06FCgiA+39Njyb0iPlun5sTAu131jvGP8zKYwkdIIvjm8IF5GMhygNi2IqG9zEGlT5ihH/MRB40wrbysyCSgIvWwv/X79/oiXQdnQOMOmy6B9QrFQjT1t0WT4zBs+UdwCLCRjNH2Se8bss13HNw/ENtwx3XlyUMtv33oMcNp9G0u+tTeqqpSW5Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uHtrNdVXuNCWCbMXj5mIBrxlziasw4jzxJY41lj0M0=;
 b=JcilSOcLxaJJnh0h3HpbKCWRn57lgEe6g7rDPFDfLN5BRnEP3JoblwpbvlEj/vXu0BqvZcEc/x+VjpVscPPymz/HoystjSuMJo+UISwBJY+8SQdCcGQ49q2BFFuLTrXI5QWJZaDI5Be/Q1niXt9+3jR3VNXd20vcTQPo5cnCh2F/AeLXwNWVre7XHFYpFdFfu2+YbGKwjT+JnsmvOfpEry6a8uvbBYBk5r5Nj/sOI7SXRxaIwUyx3P1CLb0DyDivNNLtvu99nQXKAb2VkpQQERPS+70jPoV+K2vG6Qf2QSXue8SZBZGgxUN0zPLIouqQMOgHmNA3vhwgnRihdqZ3OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 23:46:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 23:46:59 +0000
Date: Tue, 10 Jun 2025 20:46:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250610234657.GO543171@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEh+DNmbZrqg6rHR@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f5388f-96ed-415a-ee3a-08dda8791716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXkvVVNLc0NrUmpCZnRGb2s4RW9YaS9CMkZnMmZKN1pDWXJVQWlON0duL0Y2?=
 =?utf-8?B?alg5Mys5VFFBbkZEbk5CNy8wYnlZcWl6N1UwQlEraVZQSm9qTmtvTnh2YnRI?=
 =?utf-8?B?VklnTG40RVc2QWI4cDRjcjhMMUx2SDVHZ21wVDVkZUl5UkNFcEJhZjhKbzJz?=
 =?utf-8?B?b2FaRFFvZGdpQjJuSUd3akdBczNuZFhKY2FRYm05aU43THZTbkkvbEl4M1FZ?=
 =?utf-8?B?U2ZLK3Z5emlxUThsaVNqSkc5QVRBcFZOMldsc1RMYkxlcVZtdzJLRjdDTGlt?=
 =?utf-8?B?SUVJRTBrcVlmanBvT2ZFSFlWOFJadXJ6cmVGVTBZSUIvL0VrOXk0L0ZCREp6?=
 =?utf-8?B?c2xpOTUxVnM1U2g2MFYrZUZGYWY1VVVrZU9RTm1LYlo3cFJGRlNaTisxQzJG?=
 =?utf-8?B?VHBNb1FtbEY0SlE2QlV2cnFPZkNNSUtiWHdaOHlJRnVlckJGSnhjY3dkUmN5?=
 =?utf-8?B?NGg2SENaTFVQVHNsVzd1Z2t2Y1lMd3RKcHF0QWVHdGZ4dVBNblZPUzRSc09K?=
 =?utf-8?B?ekpoWXk1YlpLVFhzeVhjV3NSWk9SYnJsRXM5aWNzNk9vWEZyeUI5amR4UlNR?=
 =?utf-8?B?NHRnUEhMSzJRcDNtRjFUaG4rNjBYTnFPcnk0M2JkcXdSR2k4UVBOMnp4ajRP?=
 =?utf-8?B?aTdoeXNlKyswaktyakJVSm9US1I5ZFR5UTFESng1S1Z5MlZCY3Fjek02QzJX?=
 =?utf-8?B?cWt4NVVrQks5Nk9xdVR5ejR5YUdFL1MrSkdKUm5hWVV5QU4xSTlnOUl5c3N6?=
 =?utf-8?B?ZmZmcllHS1dFNUtXWTZSSVlQbERkYWhEZVlxZjlwbGJkSmpoYnNsWWNNUzhr?=
 =?utf-8?B?L0h6S2wzTWwvbnl3c2lxSEo0dlc5WXZwSzdJQVhsRlhSM0NLdHFXQ3hxNVlF?=
 =?utf-8?B?Ym1LeldVUXpKVkx3Y3dMaEhLY1lFYlJrVzlod05lcERSTGFJODdWV0pSMkxl?=
 =?utf-8?B?MnFvQ1JYSUJuaFZkWkNVM1VSbmdVek9rSGI1aWR3cElORURVSlNuVjRkZ1JL?=
 =?utf-8?B?OWdRekF4MTRmd3Rzei80bU10UlhibUwxbHVLek10eFZIMGR1SmNJckVMdkt2?=
 =?utf-8?B?NXJPVXc1UjdQbVAzckU0LzNURVRDcFpyQzhwUzFPKzFIVDAvZUQvVldjdXdO?=
 =?utf-8?B?UjZqbmpBWldyM1czcUxPdEpNNnRBbGNPc2pPQi93c1hXS0tmbGdWcGVtd2xE?=
 =?utf-8?B?Qi8wWVU4ZEZqUlA1ckpJV3hNU3p5ci9pOTFLL1VXeE1rTXJuWXVGMWJVZXJE?=
 =?utf-8?B?cnhORGMxWGRBUmNFKzBNTklybXhCanBJMmdnSVlYL2dYcU4vdWV4WXp6Wmpp?=
 =?utf-8?B?NmsxTlpxYUszSkVRWVVScUN6a3R5TzN2SVhQZTNBU0hWZVNqTUdhSHdXbEFT?=
 =?utf-8?B?WkJiaFgxTEdKZEpQWEJVL2FsVHIxNzN5TkFqTVFvR3hzd2IrZUk2T3FldjM5?=
 =?utf-8?B?SFVWdEI3ZEVYMUpRNnp3Mm8xOGRwNVZPVjJoSnBDK1o1U3dzbVVTYkVlUXh5?=
 =?utf-8?B?Y2IxaERRTVNRTDQxajhPZE9tUlBxUUtLTWtla1hiNnREZFo5K1drcVJQWS9S?=
 =?utf-8?B?SVJxaks2YStSa01hL2Y0eDYvKzNDQ1hrN2IrWXkyVVFSSSs3MGxtTnEyWHVN?=
 =?utf-8?B?QTA1MkFpVW1way9SL3ZBMnkwTzJFR2haNUFZTTFvdjlRMXphb2crVWVqRUhl?=
 =?utf-8?B?TW4vY28xSHI2SU9PeExrZlBrN3BHNHNENUVzdWNXNmNTcHpnUk5iVE40WUxx?=
 =?utf-8?B?ZG9Mbm5DeG0xMS91SmxOTDJRSzBQWlk0Vm5UbXNIdzVtMzIzd1lERnFVclVx?=
 =?utf-8?B?bWhYVndqSUNmT2pEd0syakVSdU9tZWRwaFhqb1JuZkRrWFNEVFZzaGtPVmti?=
 =?utf-8?B?bU9sUFJIOFV5YTZCeC9DbUVFakZDNVE4RlV6bklWMDNETUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FRU2JqSkdaQUFFdkViWjFvK3dIYlJ3VVNTSElCOC8yRVlPZWpXdnpwc002?=
 =?utf-8?B?bTlBNVY5Y0l3elA0OHFqWExsK2dRRC92ZVEwSHBuU0QxaEg0RXcwT1FoMVZo?=
 =?utf-8?B?QnNLYTdUcjVwSCtLS24wOXRpSHh4STExTVFNc1VpTkNQOXZOMU9tTU1rU1I2?=
 =?utf-8?B?Q0dQMWh3ekdKd3R0UWFLV1NrUldKZURUNU1kUlltdEh6Y0JYVHgrRnpPbC96?=
 =?utf-8?B?QlA0cUtJS3JmR1lKdTBOUUpRYUJQN0ZubXdzTFdwZEJMaEFPOXNqMk1rS1M5?=
 =?utf-8?B?UXF5QXNzTDlTdnA1RDUzYWJhZ01NeExmR242cVNGajBURVVTTXRyR3dLWHRz?=
 =?utf-8?B?cDVITU9RZ2tsSnBxQnd5RWpUcXh6L1dsRWVZeStwNmFBa280TjJkeERSV2c4?=
 =?utf-8?B?SkUyRS9lMTU3RTl0eGJnUWtDRlhDQm0zR0J6ci9uaUU2STYyRy9kUGg2cnQ1?=
 =?utf-8?B?Kys1NUFJT1M3cEc0cVpTZHcvUTREcHdIU0RqMENMbm9JRjhObmlFWnBVUkRq?=
 =?utf-8?B?TzFFQjBMTlpDd0lsNWZNcDFWcEdZRkV5M2RTelBqMk9VVjBaeElWRDE4U2Nt?=
 =?utf-8?B?OWY2OWh4YzFLT3ZvS3hvdEVIc3VVam1jN3lQTURCYnhQYjJhRUpucVB3d09k?=
 =?utf-8?B?SENWQmpqVXNYdkpMcHEyVDNIeW02eVhJMkdMWFdWQk4zRm9IVm91VjYxdE8y?=
 =?utf-8?B?QS9GdTZyYVArU2l3NHVFTkpnNTlGd3MwcWdwK2k4cFdPTk5HeVBBemhJOGZq?=
 =?utf-8?B?eWVYZXpPNHMyK0tSUlJlL1AwSFIvUUZpSHNBaG9pT2RvTlJrOGRwWmpCL3F1?=
 =?utf-8?B?TjBwTUtPWWxxYitHZ2ZlSytHWlFBLzFEOHlWbVAvUWFRRDlyTlBvb1RNYzNy?=
 =?utf-8?B?d0ZxVGk1eEU1RTlGdW8rZlJsZUVRWmdFYXYxN0lPTjU5RHh1RFlBM0ZiNnQv?=
 =?utf-8?B?MVhyMGRqbnVqTjZxRnZQbXkzVU4waytTUDk5cno4MDdxL1JydzJsRlpCSDVP?=
 =?utf-8?B?c2RHQlBJdiszbzhQOWxuS1ZtbUNoVmpCNFFqWHZuYk1xckVjUVRBYlRkcHVI?=
 =?utf-8?B?K2VSY0ZjWWhHUTVyRGY3cWxnalZxd3UybW9tOThxTGk4Q1Q2Q0ZlYlBXeWZB?=
 =?utf-8?B?Qkx0MXlyRitObWs5dS83TStPMnMrVFYyNTlwMHlNbWxsb1FpOHM1Uy9wQ0RJ?=
 =?utf-8?B?Vzg0QlV1eFNRZjBTV0lhdFdjMC9CTkNjWTZ5Z3BJZUVLempBTlg3dzFybS94?=
 =?utf-8?B?aGxVdk14OElmN2h5MDBvbmpaZDJ1NURVWW5BRTZSMGJJSGEzeXprMGE3SGRU?=
 =?utf-8?B?TEYyaFB5V2VSWTJSc3dieFdXdExCZVdwVlB2YmE3ZmMzTDFzaFZPckhjWjFo?=
 =?utf-8?B?RjArOGplclpzQzJrMU1ZbkhGT3ZTOVdQUzNVUEFSckJkejE5bjZYRy9WSW10?=
 =?utf-8?B?WEtpQVBIMG16NzJrNmYzMlBQb1dMdy9EcG5mWWpNMExwbzFmL1FOS2gyc053?=
 =?utf-8?B?aWJlNnZpYm52N2VGZHMyUnhhMXB2NFNla1MvcXB3MmU1WENIcUM1RDA4Rys5?=
 =?utf-8?B?ZUhoNnQ0VDN0dHNqWWR4WkRxWkNTeHlscmJNR1F0Nm96Wk1OVlpxNzV6OHNW?=
 =?utf-8?B?WndaVUtUQlBydnFZaTN1SkorT1ZVbkRPWUdVaWpIZ2txcDVUNGp5WXYxR29w?=
 =?utf-8?B?Q1NvL1FvMnVDWlFJTUx6cm81cExDbVhGUHMwU0tEZkxRTlVkOHRKUGVxNmNn?=
 =?utf-8?B?S2QyKyszOGI1ck5VbTFWVldBWmZnVTRTb09aRFEzcEd4SzQveUZsRjY2MkVu?=
 =?utf-8?B?ek0yR0dQdmlzdWxOblhyYWtJb0sxZkpKMVpDU2hwYk1YNDVMaTF5Zy9idGVU?=
 =?utf-8?B?V2x6cmtOcG5RT3BVSkF4SVJPYVdvNXcrMExEczdvN0djcE9ldkhjcWZXSjNq?=
 =?utf-8?B?N04yRlNPSWFWTldZMkhGYXEwZEozaVBvcndSaGwrK0N2MHZEckhwVGRNNkd4?=
 =?utf-8?B?Z0gxbnFCOWtqNWNBcmFaWVRBQzRIRW1kV2YyWmt5aHlpVSs1SUpmSkt0RmNi?=
 =?utf-8?B?c2VRRzJCeVlVUkUvZ3p5QVBFYkVJQnNDVThEN0NQVmYybndtZUVHejhkZXJ0?=
 =?utf-8?Q?pwz1ppS4Gta0QIiFUQlAWcZHt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f5388f-96ed-415a-ee3a-08dda8791716
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:46:58.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVw7WEzwVkx4XViqEAHeD5TLGs5ZIveLOIrorPz4gTnj0UEftl/vkZhqEXpabaRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221

On Tue, Jun 10, 2025 at 11:48:44AM -0700, Nicolin Chen wrote:
> On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > > ------------------------------------------------------------------
> > > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > > # enforce_dirty: Test terminated unexpectedly by signal 11
> > 
> > Sig 11 is weird..
> 
> > > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > > macros instead of plain assert().
> > 
> > IIRC the kselftest stuff explodes if you try to use it's assert
> > functions within a fixture setup/teardown context.
> > 
> > I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> > it is ARM specific, I think Nicolin is running on ARM..
> 
> Yes. And I was running with 64KB page size. I just quickly retried
> with 4KB page size (matching x86), and all failed tests pass now.

That's a weird thing to be sensitive too. Can you get a backtrace from
the crash, what function/line is crashing?

Jason

