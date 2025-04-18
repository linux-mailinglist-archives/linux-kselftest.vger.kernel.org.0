Return-Path: <linux-kselftest+bounces-31188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999F1A93FDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE5D1B61D14
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777024166B;
	Fri, 18 Apr 2025 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9xXImXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B71DFFD;
	Fri, 18 Apr 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745015374; cv=fail; b=BwSDm+VXPIjtUIZ1ANINRiQPQlUAAvwkpBH9af54SffSwBRMa8uNPqcha1H7F56kzHG5WOkf0ceKMVCYB0rEDduJAX+ZifObw7Dm13WHSUWgEjVSxcjGewyXEGPAxLT/ItHOiVkEq+SIYl+u0surjNbuccmnLN7n1WMGPvVNimU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745015374; c=relaxed/simple;
	bh=hasNDgrTADl9v/TWMI5zSpCpZiD2DXhNSForHF2DZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/Ip/CruWjxtrwaF38HNk5xcbhTglCWJsl5pxbepB5gqEagRKfphnsZwr2Wzm5+KLU/aFStq6en7Ir0opOXNfOSXgLhPhL1axA7VJJQ5R6OD+ss4lH8hzSQrXTSQYynGjiyTm7Bhzb1KR4kOV7t8hPMUXDx9R/4PwG6YEn29dws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9xXImXP; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW9fVkju+xQgjrodE4CmWHVFijDGfICTIF3iRDBVTiOCy3yG33mVl5Q5aSZwPmMWEt9AYH4jiRwYFo2/XS90x1qHmHSlpmvGjrJmUvIV7S9P+6y4WF7vbU2TVeJUj4A1Qkl/exsycb8Po60UroYjneTmFxhAZBb625DhETIoCIB39d6Ge8FlNviAnn3aJHyijIhlrlG4dJ7d2JlSEvR8i6LlccP8LKAbGjwmefAletUck/LaHlbLm2S+zW9EFK9pfKWZoIVzZ6VSibVHvSpEinonA5zyaH9W+4c+6O3nlu5UDCHE6hz/UnegtIEREK/lHuL6E7LXeV3N9SnID+RHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N+e6D+zMDPmbZ/gbgWivtsGdIDtDT2SHPgwABl2lQ8=;
 b=baB0P8KdveeANobA09tSkTtiKQObGf9P8+nNCLc2AEZTrs9B72KiWFYXQD/LimJiwTrMbP1UVzSgdCFRpkbvD1o6ywQuiz/sCaPYKS6upJPrPO1AKcbCPIg4aoDvGrO8DRXL8BySbsv7PaiS9NekuwySLPm+WeuEcOGRGJ7f1UcK30TKrsf5YazzHgsIjHLQEsCP1KB4OKhVC2tz0jZ3vR2D3gXznUb+xDa9HbBSYdlgGJdD9ZVQnkuFiRGMOc0B9Xb1BxxjUoVxVqr9rSuWUmmuoGbhdhdMfDv3wNx/ZD6eiixK0OoTT6b1rbtwEPYiMkAJBuBe/mB2sf4dScY8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N+e6D+zMDPmbZ/gbgWivtsGdIDtDT2SHPgwABl2lQ8=;
 b=P9xXImXPLc3kVF15CYRLfX6mK9Dr0ofzM0ZLgmCTv7SwAkS4wic4yxcK2v12Rnu2TwbbfwW0i8a8k1/b7FjRy88z2w+daPNVwcqe9YZeC27hBclKE9Q/O7B3LusZJ897mmOJJ/1tuTVhzvvjHa/+ziQcTsQj07yNW9XlK3GrocnfGqdYhxh5fWR48mI9O4RyYJcAXADjbqEMGnoL7NIy3AYbgL8s/DMVeEI2AY+nWeWc3djQWAXjbqAXqmPcXIW/ea/e5BhiHwRecP5cdfz+biNsKfRpOvQpKvyhTTpLn97/kxQGsD36suRuzMyz4SdeSM8h5uf9r6XB6wS/QqHntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 22:29:23 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 22:29:23 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?iso-8859-1?q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, rcu <rcu@vger.kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.
 kernel.org>, llvm <llvm@lists.linux.dev>
Subject: Re: [12/14] torture: Add testing of RCU's Rust bindings to torture.sh
Date: Fri, 18 Apr 2025 22:29:19 -0000
Message-ID: <174501535977.2294.12061268025763464111@patchwork.local>
In-Reply-To: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
References: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BLAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:36e::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e87ac2-4ac1-42d7-33da-08dd7ec877b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW8zT211NzZyd0RPajJqUjFjaE03aXN0aDNtMkRYZWN4WUszL3pTcStWek1R?=
 =?utf-8?B?RGNJNTRqdTg3RmpiOFFhV0JMVFh2MzRLTDdMVlZjZWl3dkM4M21QeWxSbmxT?=
 =?utf-8?B?OFZEZVhsRTFGTkZyTEhkTHV0bXgzV1c3T2N1aTlxbXFDZ2NqdXVMMVdSR3ZK?=
 =?utf-8?B?ZmF0VlFoZGJEcnYrbVpLdHVRWUxVVHNoUm9PU3IxZDdNRytmS3ZISktGeklm?=
 =?utf-8?B?Ym1VdWlyQ3FvWE0xREFtTUVIUzF3cUg4Sjl5dHNWQ1cxVGZwS3RpeVhJZ1Ju?=
 =?utf-8?B?OXNqMTZLbmhqWmZRbWhSaVBmVnBTekJ2dUJTalpBMkdEb3lrSERPdjlIUXRE?=
 =?utf-8?B?VlJrWSs5VmRPZnBEZW81Z3dFQUhmeW4zSGNrRjYvQUlLdDU0UTZSRlRIaDRw?=
 =?utf-8?B?enZyOWF1dUZma0hXVStqOVNkNFY5QjVWaEI5Y0g4MGFMbEVDREYvYmVKTGtz?=
 =?utf-8?B?aTRzUE9NSWRDMU01bkgwei9zZHR3UDJjS1JLOFhtd0JHZStUbyswVHFTZkRG?=
 =?utf-8?B?S1ZKTGM5MGV1TDI2N3dCeTkvWURjR1MxeFJrUzlNd1ZwSzl3M0ljNTdpbk5l?=
 =?utf-8?B?dTJvVHhBdm1pMHZnbnJHa0NyRy85RjQwanVXcTB4WnpwcGw1S0tqOGNTNGxS?=
 =?utf-8?B?LzZpMTdqTS9FM0s0RXAzYUdPcWR3TmJlUTZsY3RQdkxIWlY4U2tkWU42a25s?=
 =?utf-8?B?bkRtT2kyTGZCZHJKMEtpNTYzekRsSWFMb1VhZjNPMFV4bnJITjRKaHJDYXR6?=
 =?utf-8?B?dzRoajJpUXdJNnJLb1ZxOVF1NGh2TDJzUDVsOEFLbWxwdlJCWWl3Vm5IOFkx?=
 =?utf-8?B?OGd0RTd5Slg4MTZxdDVBcGlpK0R5RGVEa3p3eklISTN5NmhFM05ZYjgvN0JO?=
 =?utf-8?B?T0ZSclNhU1lIVFJwU2h4YmY1SEJMeXcrdkpxOWVMV2syQzg5RWxtNFRadnpC?=
 =?utf-8?B?eG1xeXZ1cnJSSjgrT0t1TmQ5Q0k2UG44TGtGcEFNVXhuVGt0ajU4anIxeEJi?=
 =?utf-8?B?V0kyajNsUzVCMEd6d0pyZS9OZjBsRDlNUGZCTkppWW9rR3hsc0w2T3ovb3lD?=
 =?utf-8?B?QjBBczVtUjNIdFpJbXl5UmdTWjc4U21zUUNjdU9jbkRYOVB0NGEralNXMkJk?=
 =?utf-8?B?TjltYUF3RUNqeFVYeHFzc0IxaC8wcmZCbkZTV0QxSzdITE9YVW82MzFvWTBk?=
 =?utf-8?B?V2NpUm9zMFNYcGV4MmdDSE4zazNMOE9kRHNZekU4RjBVNlFuL0JwcWdLSHND?=
 =?utf-8?B?bDhrNUVBSWJRS3pzRHJLRTZTa3dRamxsK3hZUXF1ZkpCNkVYcHNOYXJxakQ4?=
 =?utf-8?B?MEpmWHBIVTQ2dWtsNmZLbi9DcVhXd0dNTnBpdE5FcXY3WHpTNU8rOERzVGNi?=
 =?utf-8?B?ZVNkY2lwSTFYVzA4OEQ5TlV3eU80bnJTUnJBeVdzOG9nNE5yOWQ5S1h0VmFN?=
 =?utf-8?B?cTNyejhjNS9ocDVhMGNoK1NjOXpCcVFMNi9yVVczSlNaTzhBQkZ3ZGpySGdY?=
 =?utf-8?B?TGlZZDJqQy80QWNTeGxNVzIrWlNjaU1MdmNqU05ZcW9HKzVES2Q5Q3g5cWMr?=
 =?utf-8?B?WldWVjExeEtwRXdRK2JwNGJ5d3UwSXg2dEZnSzZORm1VUjJ1aU53QXE5WkVG?=
 =?utf-8?B?NUlpSFd2V0VPWWhlanBxeGJoS1Y0VXlkZFRYVkRlZ2VaRDZDbnBqTExYdC84?=
 =?utf-8?B?aWRzWjh0Sy9yVUZ2MEp3RURvVkdmTlJZSU5pSVd6YVBkZ3N3b1R5OW9IeUg2?=
 =?utf-8?B?bmV6UGZuR3VhRk1WQk1iNnVsMnZNZlhVeE85dEZ0T1oydkQvU2tJUE5kb2dS?=
 =?utf-8?B?bnJRd2xGSXUxZVdOZVE5SUpvQmV3bnZudmJBWEVKeEpBVElNcFRLUlNmYlFk?=
 =?utf-8?B?M1VVSnFUWk1LN1lEbkFUTDBnMGFFcEVRT2lyTmFHUHJUSEdlZ1ZFSFdFK1Fp?=
 =?utf-8?Q?e6YIpSReB2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0ZqZEphR21mUHlmSFRUcFZCVU5jbVJlWU5tSUZ1dmM5QUl6dXBBVlFoLzN2?=
 =?utf-8?B?ejVRNFJKQWx4VklpczY5c2VRRTZtVUFraXFpcDU5Nm1BTG03eE9UTVExL2RF?=
 =?utf-8?B?Z2RreWcxcks2TnN0WTEzUGVWdWh0ZjJFOFFlL3dib2ZwbXIvUklGL1ljdVh3?=
 =?utf-8?B?Zy95azl0WWpyQy9HSmErS3RhNjdjQnBoczNMZVBORHdSdHYvbnBpYmx5UHhw?=
 =?utf-8?B?UmVlSytWbWw5WGxORkFPbng2OE1hSkFvc1g1TUlqRHp1L3pNQXJrN0tNa3RK?=
 =?utf-8?B?N2kzeFJ0UXV3UkJvbFV2YWdzcjJReTc1UUdMRFY1Vk5pdEZZenFrcE1iMzgz?=
 =?utf-8?B?R1J2cFhXRENGMWFRd3RsdGR0Zi9Xbm9pKzQ4b2dhd2laREpOYldiZHFQZ3pv?=
 =?utf-8?B?cStmYmNEbnVFRnYyTVlMK3BOOGRQT2tsYVdNNjdSTU5IRFZ6KzhWTnE2OXQ0?=
 =?utf-8?B?REIySnJZeElMVGFnM2lqU1kzS3hjdGY4VnowUEV3ZHJDeWl4b0lQVlNGclFP?=
 =?utf-8?B?NklRREQ4VFZFbHJYUythcVNDYlpmNVZHU2ZvMTY5ZWFaSFFIWHMwUjRxQ3Ry?=
 =?utf-8?B?OU8vekFzakZNanlpdzArQW83eVZWZXpxZkxWZitHd1lTaDlkenRUQU04V3Y4?=
 =?utf-8?B?ellLdkNYdGtiNXVyWm44UTBpWlMrUDRvYVZ1RXpQNEhCbk42VU0zYkpmK3hZ?=
 =?utf-8?B?czcxR3VXdnlzQUFaSUdqWFZrVjlDMGJtMWZBbUZvOEZJM1czNXZGRzQrQzdI?=
 =?utf-8?B?d1h5UENlNTdSTEgrYzV5UWw1WVBtcFh1ekpIUFBzRHMvamVRN2RoVWJXUW1T?=
 =?utf-8?B?djVGblp1a1BsbEZXV2hJTGhXcElTNi82M01uaEJPdGVLTmxzdWNWNm9HODhn?=
 =?utf-8?B?THkwajRSaUhEcG9FTVBDWnMxUktiKzFqUlRZTDM2QWR6SEtjRWE0c0taZCt6?=
 =?utf-8?B?OGR6WFg1YTlYa1I4clo0QUFkZStZQ3pLcm1zZVlzM1h5Z3JRMGVrWDZobWpo?=
 =?utf-8?B?NG5qb21aSUppTm1MZGFSbW5TdW8yV0VyZjhIWHh3VzBlK3VyYk9mZmlRTWJK?=
 =?utf-8?B?LytDUmRGNDdIcGVwenhCV1Z6UlpzSUNNN2xhQWhEWks5RGYwVWQyQ2VyV09o?=
 =?utf-8?B?Sk9YRVNSMGJyN0JHRFliNzIzWmU3bTZBRTcvN2JBVkEyOHBtQnJkVVFGejQ0?=
 =?utf-8?B?eUpPYW9XVVg2aUJUZUkwbk5QcmZmODVWbDhkZG54ZG5FQUI1UHVka1hla2I3?=
 =?utf-8?B?RWJlbTJmNmRkUVRNWkJoUjA2THpwaEZ0NVlERFMyNVRRUjZ3VUgxVXEyVnRs?=
 =?utf-8?B?M2E3andldUxpQVFnblljRll5QXZpQzhJKzQ1RVRKTGtjWEp6YUdTRWg0akFu?=
 =?utf-8?B?YTNQNlBweFVWWUNLWi92VEpPSTY2ODBPMVNzT21KVlhwMTE1RFR1VExlWGZr?=
 =?utf-8?B?ZWcraGllbzNkMmlKQm5vd2JBMUt4TGl1dld2OFdBVjZLZXdjdERwSjRZb0Vt?=
 =?utf-8?B?UWNzdlFRQm8vMEZIZytrc245dzAxbFBZSnJkUXBZMjJqclVhUkQ0OW44N2dZ?=
 =?utf-8?B?YkdHaG1LRkhOd2dMb2p1ZjVYcHl2a1huUnJtdlNyMWZweHJ1RDFNZUprSUZJ?=
 =?utf-8?B?cngzUkVYSG9IY290RjIvUHh6UUgva05reE55Y21LSWpNZFIra1dIcGtLT3ZL?=
 =?utf-8?B?TUZ1NUVvdTJvZ25NWDB2ZXZVY1ZXeHdCUXNZVG1vNmhkcWlrOHdJZmpLQzZ6?=
 =?utf-8?B?K01ZUzBtZmo1aFZtUmsrMmhPbEV4WmcvY294d2Rma0JvVGVOZHo3VVBmd1RI?=
 =?utf-8?B?ZWlBczlNUno4N2RxQ21GczE3ZHQ0dTYrcVlNZ0orc3BDM1h5dlJHaW9GWlhi?=
 =?utf-8?B?RXVKcHVqcG8wM3ByMmJ2K28vanBCUGluMkNGZW5Kd0JINC9VL3NrTmN4VzFQ?=
 =?utf-8?B?RWZtbnhjT2tDWTlnMFRPaEpkS0UxVWZXdjFacDRFT25ZUXE1dnExVVJERGsw?=
 =?utf-8?B?a1I2alo5bmV0eE1OM0YrVkVWbGtTMXErM2tXWDhiZTFJQTNobFJGek1TSHdQ?=
 =?utf-8?B?QkFvVzJhS2RjT1pKdW1DZ28wUiswbmp6aUVCWUFWSFNBUjJZZFVwOGNnYkpD?=
 =?utf-8?Q?/1DSmSl7zvNITw4D1fhve+Wvf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e87ac2-4ac1-42d7-33da-08dd7ec877b6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:29:22.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WRzMpelj9Jg38t3PPQUyVNkdeIyAoubyf4KpCT0kJ0PSDZLxu4gEi/CoRBh49JH2U1eNuD9RWXuIAu/p6dSzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

Hello, Paul,

On Fri, 18 Apr 2025 22:26:17 GMT, "Paul E. McKenney" wrote:
> On Fri, Apr 18, 2025 at 08:32:46PM +0200, Miguel Ojeda wrote:
> > On Fri, Apr 18, 2025 at 8:04 PM Paul E. McKenney <paulmck@kernel.org> wrot
> e:
> > >
> > > Suppose we fired up a guest OS and captured the console output.  Is ther
> e
> > > a way to make that guest OS shut down automatically at the end of the
> > > test and to extract the test results?
> > 
> > Ah, sorry, I thought you were already doing something like that, i.e.
> > that perhaps you could reuse some kernel build you already had and
> > avoiding a full rebuild/mrproper. The KUnit Python script uses QEMU
> > and parses the results; e.g. you could look for the results lines
> > like:
> > 
> >     # Totals: pass:133 fail:0 skip:0 total:133
> >     ok 2 rust_doctests_kernel
> 
> Alternatively, I could clone a copy of the current archive into a
> temporary directory, "make mrproper" there, run kunit normally, then
> clean up the temporary directory.  Extra storage, but quite a bit
> more robust and user-friendly.
> 

Just to be on the same page, is the concern about the
slowness of mrproper or that it kills the kernel build
artifacts requiring a clean build?

What kind of improvement are we looking for and why would
this patch in its current form not work?

thanks,

- Joel


> Other thoughts?
> 
> 							Thanx, Paul

