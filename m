Return-Path: <linux-kselftest+bounces-31215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45FA945CF
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 00:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126EF176690
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC381DE2C6;
	Sat, 19 Apr 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Go6nyvYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95720155A25;
	Sat, 19 Apr 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745101505; cv=fail; b=qOo5calp9b3a8nG4t0aUhovorPSjkY5Vgn1nq8P7+Ol+qmQkRCSbP7GQUDl7eu66OLrQPqg7BqJgxWbP0nyJHEwBReGtr2S+HS2E2ZMg2HH5b99SRJSAL604QShofWKaFl4e64NGFBr4XsBijXrpucab7Aj2VKlXj47bZSMzmQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745101505; c=relaxed/simple;
	bh=yRI7IZhDI7WlXnlqobaGIXYffSDH9hqln75fU63E3ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRe5fYwxV/3/qrH1kp9tAUGdZKB+Mpn/D6zCOm2iu5zvuAwd8t0j6a5tMZsMS/986Qj3qnD1K9HelAKUPjQSfwcdSHjYnxLvLAKgq5mCxKr0TjMzLP4N24+dAal503XXvRtKsB5z2ln8oZU3sccHnhmhw5R42FsQzynOt+VmTNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Go6nyvYB; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrT2vMoRHJr8J4kpR8lTewr4KwxomErxzgRSFdLES6+R8bAcWnHKat9FqdjsGWQbzSD6x+12fLl387PNrp/fLJetRJjUlXiewqu6qy38h/js12LqvEX86GJkdaz29GUvei2O63jOj9b0JPjVzwMWjii0f3xOfItVPHcPZx7EGoCIQawWHYqpJ0CWmgGiHoYraNRaxSL2634MrF9hTl9sHxfKMFFXvkJkyNeYlB5dSkIzA6Dqm+pLiJp9fZQaOn0VDvQSEScsmHTAfzo7qBDh1Dqs1KDXPYuISL0XYqwTsi+Qqt1cBvEoRv0Z8ozJmBSe+ny8tRsKkZdqlArrDhOk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn/uHQXh282D6Soa2bpii2dtKWzltwxcPVBBInyU+IY=;
 b=n8mJ7vVroN9PVAf5e5qca5m97E8aaJQc82faM6vlUHpEGZeMwMMYvU3ombYWNgsAMBiuHabSmpk3NYoE9XSj1I2F/kvsGTsCdWDQJczNsJkAPJBEA3tazxZlt8c5KkEPDMQUPYWTaIf9OUFJWfSGeSaNXJyskPnY7I3uuxcP1698t5p9KTWUdSERvqCNTxwNGB7qsvfKmQS9FanvGaOQvuReyuty3Tzz1Sx3aN+Reqz4xrzgrmKp14SIlv0k+RQOhuWi/XpIK25miP3lfTAXnwHNK59fhpJ8+A8f1o5m6YDbeHL94D0gpzyOBsBrYUS/SahuY4PNTTviOef/sNyvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn/uHQXh282D6Soa2bpii2dtKWzltwxcPVBBInyU+IY=;
 b=Go6nyvYBIm7fJPLVUr1JRutzI1ZJuOFKLWyR9h1A+k3S1Rg5WqrnC7J/Xij0/kFDMXXPOiKzt/E8iWls71UYwGQbYr+EvI7w5XVy+5gT6JAvVS5J6xN6eswTRKwXXDGgqYnM1/dhVa7tSvR+JPLElY9AT72y+ysifVjMQuJVpjb+KNlhq1E4U69huTkUeUiO56AKY+G2WdkiKrHxeD3W+1giO+0/pJoWdi/Fm+W/JO9wz8Z4CUZCwx9D79H1d1RcdhF2rYyh87i1P8igRC7sb/rXgzasS3qbVxUdwaeb1GCpkOdIxDone3S5DjQHtA9EDw08x9B61OoB8h4b3tF+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sat, 19 Apr
 2025 22:24:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Sat, 19 Apr 2025
 22:24:59 +0000
Message-ID: <b26e8dc2-ab0e-4d68-aaa1-5c2353f2ef52@nvidia.com>
Date: Sat, 19 Apr 2025 18:24:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [12/14] torture: Add testing of RCU's Rust bindings to torture.sh
To: paulmck@kernel.org
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 rcu <rcu@vger.kernel.org>, linux-kselftest
 <linux-kselftest@vger.kernel.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, llvm <llvm@lists.linux.dev>
References: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
 <174501535977.2294.12061268025763464111@patchwork.local>
 <a0743fa8-7676-4930-b9de-73650b577bd9@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <a0743fa8-7676-4930-b9de-73650b577bd9@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:408:fc::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a036502-a07d-4bf9-3d1f-08dd7f91057f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtvQnN5blRlbFduRWUyRm1CZmkvODZ0UFZHZnVVYWo0aUlJYUROb0RKYzlQ?=
 =?utf-8?B?TUdGVS9vNVhXVHVXOG5PNmVhbWxLY3B0M3lWVWlTKzl4aWRmUzh0RkpqVDFt?=
 =?utf-8?B?RkZrRFhUTHl3YTZ0UkZsWjFSc2cwUEhoc1pkMWNiU0VQY1JDTFE3NXJrTkU1?=
 =?utf-8?B?Q3Q3V1ZXRnFmazZKVEdwbngyV1c5blNISnJYRCtQUnV2dklvN29FTVExSEFX?=
 =?utf-8?B?bFlPdWxkNldFb05KclJxUUg1RmFYRjljZ0dJZ2NNTHdXcVJZNVBUNEZ6Q0Zs?=
 =?utf-8?B?RlkxbnlWQ1pEVkZiRTZQWXVtMWdTd2JXYjZtU3VCem1OcjY2a1NLRG10Vlla?=
 =?utf-8?B?NVY4NVRJYjVaS3BjNUc5N2djRW5pUlZwWHZXNHRqdytiUFVjRDVmUHB2VUlo?=
 =?utf-8?B?Mlh4ZWphU295OEljSUtxSjNjL1l6UWVWS0wveGt2NzhadThnbWZFMHZjUXA1?=
 =?utf-8?B?Z2ovaitucHBvMTdrMmZSYXBzY3hiZCt5VERkZjNiZ2xoTi9NQmp1a3lnTDRs?=
 =?utf-8?B?UkROakxRUW9yem1wckFOMnF0RmhJajJGVS9RRjlpNk42S1Frdi9WL0pnNWlI?=
 =?utf-8?B?Y3FGeGRsREVJSU1PeGVua2R4ZUZYeU1PcHoyQm5VVnZxSExrZFltWkkvdjl3?=
 =?utf-8?B?WlJhb3MvMVNxZ0h5NXV0VEV6ekp4eVZnR3dzbkI5L2RhWS9xcHc5eTRmNGow?=
 =?utf-8?B?M01CNG0ydDIzTURrVHJXR1N5SUp6ZFVOanczQy82Y3Q0cEtZQVlGWHA2dzFN?=
 =?utf-8?B?cDNVNnpUU1RVUDhsbWtXK3JPUFpxL3pwd3JpeEEvdFRRSUhpUDFFVlpQS3lT?=
 =?utf-8?B?c2FyZ1duU1EwNWQ5enU0dDYwZFI0UlhzNXBSVEJHYTJ6WmU1WVFQOU1mMDV6?=
 =?utf-8?B?WStTZVViNDNEQTQwZ2ZQbVUzNmZVVzFmd08zQVlGTGs3czRqUnl5TFByU1pm?=
 =?utf-8?B?a0dsV0p3N01pTzdrdGNPRC9DeStYUWFxQkU1SFBjbmMxZUh4R21IcXQzL1d3?=
 =?utf-8?B?WHEyNWVOYjJzQTB4NUEvWmM4NWp3TFdtYTJjcndidUw5djVHaHBPV0JjcnAw?=
 =?utf-8?B?eEhiK1pPa00wdzFQUk5ZbWN3emJxeVl2bWhaMGZKTktoMEQ2OVh4bEJXdFJY?=
 =?utf-8?B?ZllGWDROc0VHUjVReXlnTmFWQXl5YmVqUHYrRThZVUpONzFaZmlhS2NlaVNx?=
 =?utf-8?B?KzdYMUxpd3A3aW9vRzRLd3NUL0hZNGJzeEcycEJ5TXk5WDhsT1lwMS9rSGQ5?=
 =?utf-8?B?eW10ZTVJQ2t0QUpsQ2p3YjNOeHBueTZ4bVBiTTMwMGlQZ1JSM040MWRDcEJw?=
 =?utf-8?B?SzFHRzdyM1BmbUlNY3JVbUVqNHJTbU93bVZTNERZK2pGMGhKbmtLM3NWNjFO?=
 =?utf-8?B?S3FNWXdETXlTT2lUSUloWS8zMXMyQWVzdU1jVU1WdkVWQTZHWUN2QXU2bnpa?=
 =?utf-8?B?blhkbXpaZEpyV0dQcTNldTR4TEU1anI5OWdHSllTNVZVVFdwbWUxSGN6bXlO?=
 =?utf-8?B?QmFNa01qL3lWQzczYWFnMlZUOVhvYWtoRUFueEdlbTNKOFZ6Z3hKcFY1K3RT?=
 =?utf-8?B?eUJjVHBtUlU0TGJ1V2tDQWVNYkVzL0U2ejVoK0FOMEhPSHhnTUZ3L3RBQ056?=
 =?utf-8?B?T3FndjExZ29XSHlqbnNpdERhNGxkdGhLeE9zU3JaL1hMQXp0V0NZQ1VDdE1m?=
 =?utf-8?B?UnNxejB4dktjY2FWZlQwRTJPZjFJYVdmWGtaMGp6VGM0YVhoVDFuWnZEZ3Zy?=
 =?utf-8?B?MzBqOFpZcDlSdXV4cXVpSlpodXZBajdTK2EwQkNTK203eHdOVDFRMTZyU0hQ?=
 =?utf-8?B?c2Rlb3lFMTMxTDZGYkc4WEx5VXFnSXFpa0NuN3BMTk9VRnZtU3c5UCthMlVJ?=
 =?utf-8?B?Q0lnQlV1c0M1QTRlMGt3ZGVYRUdSdmJYdzUzT3Y3ZmppZlZ1UzFBcitaMGNM?=
 =?utf-8?Q?3LJCZa00QhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZIdnlJMDBVcGFEUS9TVXA0bjNueVczMGt5c0hsRkZIL29LL1dnWnZWczVy?=
 =?utf-8?B?cjA2SzU4ak1rSVFqaXhKNkNFMG5aMkxWQnREaGEyWGJBc0lTWXFHOC9UZUxz?=
 =?utf-8?B?TnprMnJvaG5PR1NWU1dvVy9qbCt3K3FUMFN3dUdlREhpY0w3L0Y2eThQWkd1?=
 =?utf-8?B?RlY4clN0Zi9WQ1FKamFZRlBwNkVxU2ViMFQwYytmbFdWRnNFYm9QV0VicmdQ?=
 =?utf-8?B?UGVIVDY0UGxZMVplYTdyL1BHOThhd2VCU3dMUjNFRjdwbEVRaWVST2EvLzJ0?=
 =?utf-8?B?RUFGK2NJazBNWnVrandGNlphQ09zSGNjS0cwL3dBZUE3VDcvRmRtOU9OVFJW?=
 =?utf-8?B?TFB6UzRLZE1jUlByMk9wMWpXMGRBaW1PVHl5eVZUNHZtemhkRnFkeHQ2NlY3?=
 =?utf-8?B?WTJFTFhaYmV5ZWJVdWlJWklxWitaYVo4eG1lOW5QSGt6aytmMHJpdWtnTXdK?=
 =?utf-8?B?WTJVR1Q1b0hXTjhIQ2UvVU9WbHJIUnZCU1hjNDA1ZDU2L2pHa0xoazlMTEdk?=
 =?utf-8?B?cm50RFlBazB3TXlyUkk1aEpjSjB2Y2JXRUtFMkxxekp1SmUyQnVvREdMT294?=
 =?utf-8?B?bGszRFhPdjB2WmNWN3JIVThqK3VYd1FocWw1YmVWYU9tYWFjRHE3dkppanJv?=
 =?utf-8?B?M3ExUk1vamxIbkxLcjFHSDdNZFByWU80aUtUL01GeGtXTjRnaCtWMFFnTG9x?=
 =?utf-8?B?YVRZTGdGN0VGNVlkYWl6N3JxeFZISi9jSTZqSFhMUVkxbDRyc25CZmlVTFc3?=
 =?utf-8?B?TEpoNkU0ZStHTUlCbFJGR2pDSllndzcvR3R1d2g0aVpwTlZjdnlCY0xYTFp2?=
 =?utf-8?B?ZW1WMzByc2lJaVcyUlp2ZVBLVDI1MEZDdGl0MTYvLyt6VFBrV0hPZ0xZQVFO?=
 =?utf-8?B?WWk0U1Vsa2pGRTZ4YS9FQms4c1p5ZmlkZVpRQi9nSzZyQW92YTM5cWF4WVIy?=
 =?utf-8?B?QVp4bm1VVlVzWWFiMGY2aVliWmVHTzlHakNxQU9laVM5dlVKOEZodFhXc3dr?=
 =?utf-8?B?czhGcFZIazZFVkFyOTVKOE5JeTdEWTZ1aktNb0xSd0VucFlXcmxQUktoTnZ0?=
 =?utf-8?B?emZ1SjZ6UmhPRVpESEZTZlV3dDZUSjhyNllrem1WY2ZrbXFIK25uWVBydFli?=
 =?utf-8?B?S3dwQjNGRG1ERFZLTk5jcVBuaFRWWlU1Q0R6cW00bGptNTdjYXBqWk9jU25o?=
 =?utf-8?B?NnVpY2dadXd0cW9hTlkzMkNPUUxVelp1SnIzMm95eWM1bXdreHkxdUoxMzJD?=
 =?utf-8?B?ZmlOR3NCMXYyUUN4ZW0rY1VLYW5UeTd0aUxKbmpjNW5jNWZRWFJQQXRXQnBR?=
 =?utf-8?B?REpLZVlFcVhMOUVzd3p2ZVNYQTNlYWZmZmFqTnVrZCtHakRrWUpKUlRFM1ZR?=
 =?utf-8?B?a25xTXN4Q1JPWkwwZnM4YlFkUnpBcjA1cUhUK082VitxSXJiWFpTWkVadVEy?=
 =?utf-8?B?QlpYT1lrYjNjeG9VYXpMQ28zaE0vdjVKVHIwZlB5OGFMT1ZmY1BxVll2dHkw?=
 =?utf-8?B?L04xdHpZRlV4OFN4SWhQbUk0YnN3L2p1ZXFXMm5oTXZZVnVwMllKZ0k3UEx2?=
 =?utf-8?B?TDhxTEs5cHYwVDlLZUQ4aUVOWGR1UlEyYzhXL3lqVS9nK1JRNDZMcnNXWEU0?=
 =?utf-8?B?WkcyNjlVVWwvajY4V1JxRkFqRWc0eHM4bWtLRE1jYmlxRG9lSXU4aC92UjN4?=
 =?utf-8?B?aE53amUyOE0yRG5wVTJ4OGtINkdnN3FoWmF2a2RzVi9RbjFkYXd3TkR5S2VH?=
 =?utf-8?B?M25UdGtWSkxsL1p3MDhsQmFYRmNOeTV4T2VnZUNSUkFaVnZjNVhEei9OcUp2?=
 =?utf-8?B?bkc4MWhtRnQyajJqVHNZdHk1YmhWNnBvVGxyWUQxUjRyNTRhSjdRdEc4cEkx?=
 =?utf-8?B?Um1yS0hoY3MyRGdWcmRzUjFXTzl1WFFmWVJpUEw2TTlwSVJJODhlalpRWjNK?=
 =?utf-8?B?eDBvTUJ3QkxmUm82dEJUMlhKYlNWMWxIYVVZQTVMVDF3MkEzeWNtSXRvbUhH?=
 =?utf-8?B?cHhjM2JlS2lYWDJoS1ZpNWcyTXhyVEZjVVZVbHJ3TXBWdXZWcjBjYW5DL1di?=
 =?utf-8?B?dHkvWFd3VGRaSEhlWWJpbm4wYXFpYUZORWtTcUZDUk1hc2RsVUYwSmZ5OUp1?=
 =?utf-8?Q?JnTBdK+qjbHZ0DRF9trmyCVKg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a036502-a07d-4bf9-3d1f-08dd7f91057f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 22:24:59.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/tAYsaQ8IAJxyMXr4D14VRZ40ZDeRB0xQOmTKtXHPK5f2FLH16j0SL+L9oR+qZrRhsomH1HfMV5jVgSs4Ti5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

Hi Paul,

On 4/18/2025 6:45 PM, Paul E. McKenney wrote:
>>>>> Suppose we fired up a guest OS and captured the console output.  Is there
>>>>> a way to make that guest OS shut down automatically at the end of the
>>>>> test and to extract the test results?
>>>> Ah, sorry, I thought you were already doing something like that, i.e.
>>>> that perhaps you could reuse some kernel build you already had and
>>>> avoiding a full rebuild/mrproper. The KUnit Python script uses QEMU
>>>> and parses the results; e.g. you could look for the results lines
>>>> like:
>>>>
>>>>     # Totals: pass:133 fail:0 skip:0 total:133
>>>>     ok 2 rust_doctests_kernel
>>>>
>>> Alternatively, I could clone a copy of the current archive into a
>>> temporary directory, "make mrproper" there, run kunit normally, then
>>> clean up the temporary directory.  Extra storage, but quite a bit
>>> more robust and user-friendly.
>>>
>> Just to be on the same page, is the concern about the
>> slowness of mrproper or that it kills the kernel build
>> artifacts requiring a clean build?
>
> It blows away things like tags and cscope databases.  Me, I have my
> cscope databases elsewhere, but lots of people build them for their
> live git repos.  And they are (quite understandably) unhappy when their
> source-code browsing tools are blown away by some random test doing an
> unsuspected "make mrproper".  😉

Cool. One thing is, running other test modes in torture.sh also reconfigures the
kernel and potentially recompiles the entire kernel as a result. So if someone
is already having their own kernel build, running torture.sh already may cause
them to have to do a full rebuild, AFAICS. But yes, and to your point, the
cscope DB and stuff may get blown away for additional disruption.

> 
>> What kind of improvement are we looking for and why would
>> this patch in its current form not work?
> For the near term, I am OK with its current form because it is
> non-default.  Longer term, though, we need it to be tested by default,
> and that means making it avoid undoing people's work.  My short-term
> approach is to enable this test on my employer's test systems, which
> have Rust set up correctly, and skip it on my laptop, which has a strange
> FrankenRust due to my early playing around with that language.
> 
Or we teach kunit.py to not require a mrproper? :-) I wonder why it needs to do
that. I may run into that too considering my other kernel project requires me to
mess around with rust.

thanks,

 - Joel







