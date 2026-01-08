Return-Path: <linux-kselftest+bounces-48538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65771D04503
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0C7D31DAEF6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31C17AE1D;
	Thu,  8 Jan 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="euFXebby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020136.outbound.protection.outlook.com [52.101.191.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77339FCE;
	Thu,  8 Jan 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887877; cv=fail; b=NkroVtC7dQUQ+MruLGgNUuUU4cE/rKYCy1BvY3KK9q7IRYBH9MgFIF+kIlenEWtSjT0+OlPhGm3a12W8OdHrLjMuwyfrXx1Ihb/qAoS6Xe8WbzlkQR0mR8i+b7C7nMYV6Z59CXw0MT7zGHLuPqnVZZUUF+9MNafG6tQd6sPfj9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887877; c=relaxed/simple;
	bh=+7I43JHEqhxbvTcn0BTmHT8NQmRS3yaEnD6FMzyHbbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDAsyA5iE8NKW7iRuRbEEtkROn1p7gAYsamelcRdIGHd9rgR0tva0Rr+eW7Q9J0g2TM9yZP2jP8N0AKCVmlHEqOfChzWTB7MaQLAMIuqwmqiPtc9n0nFyy8aRwRN1qtI7R5THO1RGomE99ZyX915nD1m03Z6IL4Rngk7N50GsUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=euFXebby; arc=fail smtp.client-ip=52.101.191.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhBqyWpRT95wh3aCOdmjjMcJt7LI3BhoecULj/Hi60n74vmJGbo7yZdgZoCTc0cB2spU1lkqS5opogxoElf1/7ZAhbr7E4U1PtPmyw73oupJ1XClWdaZhT5qxp+wp784r6vmB765L2xzc9TLF4PHCDo8WB80PRdAsP4bfAg2GVA+YMgzYpOFFcPliVN2i5LlLSIOZma1aohqzyBrYbkE37JYE/rc1WLYKKG/Bi3d+fn8VCThYAjEiG0hBLp0YLygsAmae6iPfDkT1yoC1THTkOQCW5B3LF4YLcxPRX02pg2PuB0MDYyOiCu/PECA9q7DWnP+z9LAd+cd0Wy7S1kQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNLEx54vcn9/A9vhMctvlnqm065DSj88wgoFGXQOUYU=;
 b=dBGUb6tKdgbzw8lBYbP08TcyxIqyYtfdZA9aQnGLiujW1R4Be2h/+kTZxGbNqoAMR8lkkFK2Q0rkaSbgNZLFA6Li/F7PDd2dDpZlV0qXH35tIiYaj7XWIfzURussPLNo8+eBJMzF4eqa+rSqzMAVE8O4ikms1DhUJY2AjBw3YL3NyFxvh+51YgXyOmVqrSdvbqTqohEveT0UKi0k7fcz7I82+iZZ/IEoAOcIi5jrY+s/QcMb647FTkAKiGIEFiNP27efOmxzqL1eIAPF6vCBHhnvZTG1IRCHOp8vGvFD7qWMrOJijSco35eQ60ibqhpAK33CYya5eDAe7RBrr82rHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNLEx54vcn9/A9vhMctvlnqm065DSj88wgoFGXQOUYU=;
 b=euFXebby8QhFIkMww/IAtXJWsLknzj99y+Xm3iRtZiM3kbSKfwkxLXIU7xQIPEUyeTmSbuLEEV1Bt24AE0r/Fci5Lset6sEFtfLDYAseWH8kcND1j6AK4UaqpYKcGaYuIudqqsSiNu+bSB1+fdsofJpDBTKCReV4wYVrPxIw0nlYFSdQ1yYeEZCNA5gZYHiLjSWWUwbxY/DSccDkd12APsWd4d0AO+YlEBEdK5O7UWAOTzGCR0WdwN2Xv91qr8EU3C8+VPs2KeQZaA9nnd2Vov1REhXN9cQgcLunaU6Kmzq0vdNcgy6jJKYNg+4WoVJDs4/YWYFSHaANVCH4JdbIug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF4C719E46A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::23a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 15:57:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 15:57:44 +0000
Message-ID: <4dbe929b-7864-4cee-8f19-d0db970ef95a@efficios.com>
Date: Thu, 8 Jan 2026 10:57:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
To: Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 Paul E McKenney <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kai Yao <yaokai34@huawei.com>,
 Tengda Wu <wutengda2@huawei.com>
References: <B952AB3F-16CC-4D28-8038-23DD052D6DDC@joelfernandes.org>
 <9086EA4F-0393-4E01-AE74-1B428904BFCE@joelfernandes.org>
 <aV_Pp5BUxB9dwp1S@localhost.localdomain>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aV_Pp5BUxB9dwp1S@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF4C719E46A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec2d03b-6e92-42c2-eba3-08de4ecea968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFpVaFhVZkFzM0J2Umw0M2pGa3JKTFBYcVNTNzl1dGN3R1BCQk5TOWRMUFJr?=
 =?utf-8?B?UVMwRkFOYmNlWVBUZUJXYjF3LzZkK29kUUIyUDc3cmFIeXNZMStRSEJXVXdz?=
 =?utf-8?B?UmhVSkFGNUl6bE5MR0czY2ljSWp1aXFqQ1QveVBmcXdlS1BUQ0RiNVR3V090?=
 =?utf-8?B?OXFOTTdIaTZYQVJzekJ1Z3lEWnB5czF5RnJvZ29McnFDM2tYVGpLWFNBbkZV?=
 =?utf-8?B?c3ZIT3BwbndwVHpZdHU2YUYyRjB3MUQwYm1ZNWhVMG9qU0N5VE8xVHo1Nkkx?=
 =?utf-8?B?THdnaEk0dE9BdGhISHA4dWlBSVRoSGtqelFCUmxlYWRsVjZMUDhQUEYrSFhy?=
 =?utf-8?B?R1M1dnlEbmVvdjBseHF4ZWUrQUE3WDlTMEM3bkQ4Q2YrY2ttUzl1NzUwbmY1?=
 =?utf-8?B?aS9yQ2dWUklnRnQ4bnNoSzBHazRwdDlXMVhDRU9BTDJ0ajhyMmw3WjVIL2RY?=
 =?utf-8?B?UGFxTjN6RXdRQkJhbFA5ejZDOW1aQ2F1N0ZLSThPSzhNQmR3Z3EyMmNOdnJW?=
 =?utf-8?B?M1ZzVFBjbEdlcE51dnlucXpUY3Brb0dKUlB4eVFXS09FdlF0N1VMK2RhRjVP?=
 =?utf-8?B?VDh4eDZwek9WdFFhbGtqQ3h2U1BCdmtRWm1MdjN6OEV6Vjd0MnIzNUZlRWVE?=
 =?utf-8?B?MU1TNm10NkM1MWlsN1dtL0Myd3cxdW15KzkxZWU3N0pldWtFeFNlYXljV1hR?=
 =?utf-8?B?R2VKbHU1SmNXMStDN1c4anNKMnJKbFV2Z2F5aHVTWGl5OGVtYjNpc3JJRG1D?=
 =?utf-8?B?ZG10UGJLb3QzckNmYVJ1aDZiSC9nZ3lpdVlNREFKUUFCaU5QWURpSGFNeDcy?=
 =?utf-8?B?NE1acG96MjdBRDRkZlBYd1AxOUdReEJ5L08rQXVZeE5ZOGVrUjFNdW52ZStN?=
 =?utf-8?B?b0tKSW1MZTR4d0doWENOZTdCVGVvZ1FCVEZ2QmZlYUsvOHQ5TXRIR2ZwZndU?=
 =?utf-8?B?STdNbWNPV1NZMDVKNi9WeEcyd2NmdGQwVmdRKzhlc2RWT3RsMVdKMUxCUU55?=
 =?utf-8?B?K3czWHlYRUNHK1Y5NUVlZ1l2S1R5bGhDamttUkx5RmxYejhkWnI2NW56Mk4y?=
 =?utf-8?B?N3lLQTl4Y0F5MElEYTAyTUhsSHM0YXY0YU1Md2Q0cEQxNHVkWTFpamdSUWVH?=
 =?utf-8?B?QmZYb0Z3ZDRVSC9tWjB5bUlUVXZadDIzVWhpRnowRzNnT0wxcmpuNVowTEVN?=
 =?utf-8?B?WWNacExxdzgvNmZnMEhmNW5Wd0lhQ25WaDM2REFtcjVXQTFvcWdvTFlOaTRF?=
 =?utf-8?B?MDM0V2tBY01FOUwxbHhiaGs1aGdvQVc3MVlURUJRTHpiYnI0bWZVTktpZmRs?=
 =?utf-8?B?cUdlY0swMlNiWDR1aXNRT0EySWtxa254RDdhYnBIY0JwNFNIUlhvSlJtZldR?=
 =?utf-8?B?TW9WcmVwZ0VKOHZtbU9aL3FtWUtEQnpuamNqNHZrWHBmNlZjdjQrdU9yVFZN?=
 =?utf-8?B?dVlldjVEYTNpdm5NRkhNZ0YyZnlnRU9ndVRtYS9FKzZURytkK1A0alpNVFVu?=
 =?utf-8?B?T3dtK0NyZ0lSbElQbWtWNWl2U1crQnN5UWpHUmR5TVFyRk1WSEhFQmNQVFNx?=
 =?utf-8?B?TU1MM21zcUZqQXFuNkZ0Wk5xWVVBNmtGVTNlZzhFSUdEUWlBNFNkbkNzM2pN?=
 =?utf-8?B?RDl1VFVZMUtQbWhXYi9NSVZxOTNEQVBmaHBhRm13ZnY0RXFKQ0IzekhjeUVB?=
 =?utf-8?B?SFVrQXJPOXBNNFFmejRuNGtlQW5YUko5VVUycEhhYkxwTTJOeFRRdEN5aTBE?=
 =?utf-8?B?ZGJIN0U5SFJaamtCWXBJVlpSaXJZYXJBTktNVmU2aGwwc0tCdXFyV2s1UWcx?=
 =?utf-8?B?MWlXNFpsVXVrdmxsMVdjVjhNSE5JeFJ0M0JZQVZ1aW9VTk8xNHN1c21ROEVW?=
 =?utf-8?B?ZzdHUm54TEIxbmMxRm9QMTJaUVdzSzBmRGg3a2dodzQ5NVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU1vKzNFWGF5bXpISDhPVmFCK2JCblNPcnNWcmZvSXd0SFQ3OXZGMlhqV2Q3?=
 =?utf-8?B?c09UVmtwTFJWM0RWcUJBYnJYcThlbk8yMjBsVHIrckFiYkQ3REJidktWMHow?=
 =?utf-8?B?RVFKVXFpb2dEYjN4bWdnR3Z6bVhtWW9SU0hXRk1OdlN6NHFmdEEzS2ZHYVlB?=
 =?utf-8?B?Z2JrMHI4V3IxM1BGTDFsZ3VjRFFiNjVPOTI0T3Z1Z3NOTTcyRzM3TmVudS9Y?=
 =?utf-8?B?UmUveFdLSmlwUi9rbUFMUmgvZUYzVXFaNll6djRrR2M3L1VyeXpLamhJU0Nj?=
 =?utf-8?B?VWdjcEp0RUlPOEZ4bVFqMUt4WHdvM0lGQzZqazhjeXpML0FzSGF6UGRaUDZz?=
 =?utf-8?B?cURkeVFZVERCRDQ4blhrS0FFU21pVVg3T0pJQTJ3eFoyT0JwSXdPenZ3SGg1?=
 =?utf-8?B?eFpoK1B0YTQyMXVkd3Fab3U1QzI3Ukh2U25WZ1JGWGFOQStwWWFRSlFEblF1?=
 =?utf-8?B?cUloaUMwVzkvcG1WVmdEN0NrYzlyQU93S21ySllDditxNVpJSndEdHQ4Nkpi?=
 =?utf-8?B?d0E3ektJZUI1Rk0wMVRXcGN4RWpRS0FzTlRUdHNRSTdpNXFWenRsdmNCQk1r?=
 =?utf-8?B?MnBuc0NTbXRvTTBRZVI1K2lySEFQTnVCcGFBV2E0MkNHeE95VFdEUWMyekJq?=
 =?utf-8?B?NkNTaDMwOTJ2R0ZOd3pSekFQc2luZklxZEdMOU4rb0Z0QkI0OWx0bmNmeG84?=
 =?utf-8?B?NVIrMmxaYXFveE4wLzBsYkxDSEtFamlOQVZ2R3hjSlpZTHp5L1JzTDJSZzVV?=
 =?utf-8?B?bHpyOW5OQVJDczFIZ2FRa3ZlblF3amR1V1QxSmM5SnFMcGR4d1VUZ1RWWlhR?=
 =?utf-8?B?cTBjMHMrbHNEU1I5dFFSSy91Wm8rRFdoa0lNUkZGWFNHeDI0MTFpMTBXM0FY?=
 =?utf-8?B?TkpkajJCdDlPN1poVW1JRzI1WTJPUXZlbFdKbjEwRTRQbmVDRlpXUVV3UkxT?=
 =?utf-8?B?MVcwWjRyRXR1cGxzTDFkMnAyd21QNGx2RFh0YUw4ZlBDRktnbURzLzM0emxp?=
 =?utf-8?B?TVc0ZndoOUFaWjJjbmtkeXcvT3ZNc0w0bjEraGlFL2RGNnhHNmkwMi8yT3FH?=
 =?utf-8?B?NmlWNGdxalhCUXNVNFhBQ1V0UzFwSzJFZHp6K0tDK3lKL1V4YmhSeUdwSVBN?=
 =?utf-8?B?dDdzQ1YzRmFsTTV5Sko4eFUvaWYwNXpkZjRzNWJTWjNYM2JrbFE3b3o5OXIx?=
 =?utf-8?B?OXpkZnllL21NMks2UWZubUo3eTBLbGlQQU1Vb3BnQTJZR0E2TmtmRG1nV0VO?=
 =?utf-8?B?alNNWW5SREVEbmEraU8yMU1lVjZDcGNJd3ZlT0ZMV2lGTHpMQVNWMUw3a0VG?=
 =?utf-8?B?cFZhL1RXT216YkoxWndRL0tXbVFzMU43T1lHVlVFSWNYdXlLSVJpMXZPYzAw?=
 =?utf-8?B?MktXQ0pEOHRvamJIbEhPRDVNVHU5YU1raDdVckNDdEt1WHRqamFrbytrVHFk?=
 =?utf-8?B?djZFUHBkQStjRit6cXhUWkdZWDZBZGFmODAwcE9BRmF6UzJRYzgwUktUdC9r?=
 =?utf-8?B?UVhmWE9idUdhcERpZ2xwcWF4bytOUzZpLzdjQTYxTkV4Sk9sL2hib3BrUDlW?=
 =?utf-8?B?SWV5d293dlgydWpIV0ZNS0xGQXBUMmNFaFpjSkxva0xZVWFPcVRwVzlrVjEz?=
 =?utf-8?B?ejRoVEh3UzdQVGpUSFVsUEFCb0Y3L2ZOVzFCblJURmhtdlAxdDdxc2xqZGVI?=
 =?utf-8?B?RDA1bmFzakU0M0I2Qnlwc1liV1VDY2dYeGNUcE5nalRpUjJEMUdMd01uZ3BH?=
 =?utf-8?B?U2s1OWcwYmxRQ2FKMzFLc0FFV2ROa3VsemJSWkVDdDB1bjJaSi9pQ2NObjht?=
 =?utf-8?B?dmV5TFkvNkhRc3hxV0tOWi9tSllhbDhKbWJXZ2ZTN1lXdU9NMUJDS01RaVZN?=
 =?utf-8?B?WHFWb0QyTmxIVWNGQ2tIN2k2Z2RkZWJQY2ZYaXl1bTJRbU8rWlBMR0tPdnc4?=
 =?utf-8?B?TWMyb0RlYUJRVjZPSGx1MTl2QURVRUZwakxKZWhpYzdkeDE3TERzZllxMzA3?=
 =?utf-8?B?L0V5WG5ZYnFsSUx6amJ0NWh2SSs3aDZ2VmJ3MWVFcC9QSU9WZEZIL3pZcFNv?=
 =?utf-8?B?dlowbi9xVzZ0aFZmS3lmVmJWU1hxNnVvdXdONzE1T2NLQ0xvdGlxQlF5STNU?=
 =?utf-8?B?czFwWWNQa1JoeTVabTZ6emZCOFJZZlJOVFhRWlNLcW5DYURFOXFUd1J3cDd2?=
 =?utf-8?B?SkVmK1RUOVdhZ2R4cEJqUG5VL2g5ZWJCUXgzcEVtTTRaZ016cDM1TitINUg1?=
 =?utf-8?B?aElZaUhJeUY4T1gvNVdSUTh2a1A1REVYYUZBZVpIWlB3L2pLWko0WGZLMjNF?=
 =?utf-8?B?dWJ4bG9JSjBZUWhOUUc2TnhsMmEzRGtMSkp6WjB6SldyQTJ2NXF5anhUVzRY?=
 =?utf-8?Q?UEXtP+FoYxN4j0q5Sd6cQLcfr3bitYdfU3Sdm?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec2d03b-6e92-42c2-eba3-08de4ecea968
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:57:44.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sNprPcBq37wnTXyxN5k5qvOvOl/tANXkXCChWlHwVEoo+ws+2mJmKlJppcQZqKsfQvRn98mJbM+d4yULosdcFpu94lAqRJP7/l8uu1yM+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF4C719E46A

On 2026-01-08 10:39, Frederic Weisbecker wrote:
> Le Wed, Jan 07, 2026 at 10:35:44PM -0500, Joel Fernandes a écrit :
>>>
>>> By the way, when I last tried to do it from rcu_qs, it was not fixing the original bug with the IRQ work recursion.
>>>
>>> I found that it was always resetting the flag. But probably it is not even the right place to do it in the first place.
>>
>> I think we need to reset the flag in rcu_report_exp_rdp() as well if exp_hint
>> is set and we reported exp qs.
> 
> To avoid needlessly reaching the rcu_read_unlock() slowpath whenever the exp QS has
> already been reported, yes indeed.

This seems related to:

https://lore.kernel.org/lkml/6c96dbb5-bffc-423f-bb6a-3072abb5f711@efficios.com/

Is it the same issue ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

