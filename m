Return-Path: <linux-kselftest+bounces-48154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6112CF1A07
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 03:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A763004B9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E92C0293;
	Mon,  5 Jan 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wierOOhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022093.outbound.protection.outlook.com [52.101.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1380C02;
	Mon,  5 Jan 2026 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580106; cv=fail; b=Nf1xKg5TCCWBJRzyvE929ukJXzCaWUB6bu/D5PaFYkR8+JMQYHa6Oehyh4e+J3IdJXoWehT9Bus2adv0Vy/z65sfretr6Vz3lYFWasPxfVJNIJwD5H7zROK9vmJn1y4VOm3UTs5/Sur7/4pjhcqDeGVemgF5aj4nfD+4vfPWPGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580106; c=relaxed/simple;
	bh=L7NOXguhTpLUBCloxRFBn98AtIay/R0O7Yc/iP1pfYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJIX9AfZP0lQkYlAOULPTaeRvQLdi2/PbyluCWH/gnjTweS7VWzHiPvwZh7gGwA1Ygqyjm16Mbbb2ySH9AsPbDJdncnYu32jStr1MB1zTfbVmERyL4b3IBJGycOepkwdlnNn+ZKQ6oXh93qATK4v1+JQqkOavhyGsqSkfzJT0ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wierOOhI; arc=fail smtp.client-ip=52.101.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dREX2v08NuWc1YMYOtrZUw4aJm0/N/Hn4+nBYJgQTq01rcZQme35ABpKEzrwysjLWzOTQHTNqK7+uA9feP5ofCJ5AdORkceGIN68tvZ65squDSl3JQGhshSsfy+VX+ti6KY+9DXOrvshdFo7FUJx9TaTgQBtYt+IxbaGT5MechIz1ch403Wiw0pdjFw4bzHwilJ3IeSoLgzeRpBaDTsUv3zseRa2VTqPz3VjzyLrsRlFtDxXX3TgokDRdnPZVG+cEQGFoaqBvD2AkIYrnbLFTSECQLr+PJwKbbHRrHHlsnE0VjUn5fuY4ymSe6Fnvv5yq4c45RnspjpXymsJqq01jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aPwAuVwnFycEhkwakyUPu700UtfNVMZw7kwyVAixAU=;
 b=i1tqAgaqWyy2UPH3qJvJB1UOM+eQzL/y2ZBRDt1FEZGdJB3EfZC6fOR5tPlAH4IlC3arkh+PNEfZjye0uq0gVG6y/jPy9sL1wiFWcWjEO+n0hCNZxq9G+TUwvCd4V+q06l2xZyYaB+mptwWcxlxKeFwBmu4DmAewf/s6rMWtXsKQOFetEv7jhvTvH1RMAy82+zzlmShrIwcqL3f2FjqH9pxb8fLkSWPsEwMiQ3LS8aW8b7rwXhFMO4FU3asKrO7pnGUMgP/kmZ8UtoAvb5cVp9QOQcdi6f3ohE5yFR/vz3uwdwzpc4O+DBiZFzwyj2sEdaUSz3GSg9un/BaK/k9t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aPwAuVwnFycEhkwakyUPu700UtfNVMZw7kwyVAixAU=;
 b=wierOOhIDn7yfkMto2yefVJeUdhp+/9+WslHN8BVl5AXzurHAGwweUKUfbr7iI68Io7uWaS+c6vVwFbWK0Y9KONMhlI2/ShwMWiGObBF48dYF49Mx9TkC/hNEyoggwcEtGeRDk7ptAcIZWiYotMNzGgLswiW28WSMvPqyG4JKoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5403.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 02:28:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 02:28:20 +0000
Date: Mon, 5 Jan 2026 02:28:18 +0000
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, Guilherme Giacomo
 Simoes <trintaeoitogc@gmail.com>, Patrick Miller <paddymills@proton.me>,
 =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] rust: macros: convert `#[kunit_tests]` macro to
 use `syn`
Message-ID: <20260105022818.5a5c839e.gary@garyguo.net>
In-Reply-To: <CAJ-ks9mCivfa3kL6ep3QHYw_-p56qGeZn0ApLKo7qvsES-0ArQ@mail.gmail.com>
References: <20251211185805.2835633-1-gary@kernel.org>
	<20251211185805.2835633-9-gary@kernel.org>
	<CAJ-ks9mCivfa3kL6ep3QHYw_-p56qGeZn0ApLKo7qvsES-0ArQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ee336d-768f-48ad-7460-08de4c021798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNwRTlvLzB1TlVrT1FpVTJ6RW5PVTQ1MlNrenVvQ0c4cjdzVk9TOWR6UWx4?=
 =?utf-8?B?blYwd0N1My9MS0l3RGpoQUViOTRUenlLRHlpOFN1alpHaG8xd24zUmlpUC9k?=
 =?utf-8?B?ajNubFJJeHptWjhtMEE0YTFrdGFiL0lXSlV6NGtUY1VVZFd0cHFEemFOTlNh?=
 =?utf-8?B?SHBHU2NpdDVaWldoVm5Ldy9qS1F0YXZPWTRjTExkaDJhbk5XTENqVGZtYlFt?=
 =?utf-8?B?SUl1dWo2LzBVbVZDMTAvVFFMajJibU1KUkNOL21Pa3pxM0F4eWVxMmZWVDlN?=
 =?utf-8?B?L3RtTVp1MmlJU1R0OVlwZEgwOU1CNmFlWUNHNW5UOXpkeHRxTlVvejdhZzRr?=
 =?utf-8?B?MkZpYld5N2p3Y3A2Z1FFQ0pyY3NCaDhUek8zdmwvaE1pMksxR0RjL05uZVZ6?=
 =?utf-8?B?L2pLaVNFdHVJQmxMVXIwMVFsenRBZlk1ZnE0RFJkTG51L0JZVUpCNUxsSWVu?=
 =?utf-8?B?dzVqalM4SmxDeDFOTG5LS2RWNHBnVGhCOHFaWnVaSmJjZm5YTWx5RGhlUFFm?=
 =?utf-8?B?ZEl6MG9ubWtHYmVKZWlNTDIwcjFTQ0QxWGE0aWtKS3VWQVlUa1hFVGE1dGhI?=
 =?utf-8?B?ckViSjdkMVZwWDJYRy9FWkhua1d6bUNQV0k2MkY0UXRib25kenZOVWo3QmZl?=
 =?utf-8?B?dkp1WmFwNE9jZ1BiYU9tWGtZSHFtckFxTFh3M20vSDlYYVlPa3krV2pHd2Ix?=
 =?utf-8?B?bDFJeUQ0eTh1a01oUGZMVEMzTjBVZ3pMZlB3TEUzRStFSlpNYWtRLzFSTUp3?=
 =?utf-8?B?bWlrT3pSWENoOVkrR3BUcVE0c0JHQ3pORk10aVN4TVJOTmVPZUU5Z3JBYnhR?=
 =?utf-8?B?dUV2U3o2M2ZoSGNUQndwK3plM2lVMlM2YU5rbC9zNVBwMWJXRDk2M0dWTTZE?=
 =?utf-8?B?REc2WFdsU3ZyLzlUQituQld0OXNtUUhlTi9lZkpZclZzNkRkU2JvNTNpc0hu?=
 =?utf-8?B?S01yeURGc2JRcTMrUkorTlhST3M4em51bGlQZEZDLzA2QmpIbFMwNW0zb2Nv?=
 =?utf-8?B?M2V3R1hsQTNCaWZvVEtTSndqTnB0dG55dVAybkxtUkFyZ3ROcy9MV3VXTFpy?=
 =?utf-8?B?SHFYQ2R4MnVYdlJNekt2YjViUEpwd0hlZXp0NzhBc24zeCtTbDgwTVpMSlVL?=
 =?utf-8?B?bCtCYVVTUnkwTzFUeGJNSVE3THg2K2JDR3MvWEpDK3oyUlorOWRCYiswVHJS?=
 =?utf-8?B?R2Z3cXJtOGtDNEVSQXk0M0JlSVZLdm1kM1NEVEEwYUk0MU5LNEFGZTRoQW5D?=
 =?utf-8?B?dzA1TlBhZloxZGFhWXdkQlkxV1dKT205eUordUV5Rkg3V3EyczNVV0xnQjhy?=
 =?utf-8?B?M2dtVE9JT1R6SlpaRVFYTitUTG5SR1BtanV5QTNFUjVOb2NwdEtoNlJNaTIz?=
 =?utf-8?B?d0MzQ0F4S0d3Q21oWHpnUUdQSHdSODY4K04vVXBJTTBlcHRQQ1g2dWsxVytY?=
 =?utf-8?B?K1p4K1FudGZINHlDYWJldVE3YzB0elBmQk4vbDdWeGxXOWw1MDIwQllNdVI4?=
 =?utf-8?B?T1FiajJuclpuZmJRLzh1dWRLUG9CQjB6eVBXMXQ2aGdMbEZIQXVmRHppUFF1?=
 =?utf-8?B?KzJKbHlNclM5NzVpZTdCc1NXd25iWXcvcVVsdHdUMFFGazF1c3B3N2FmN1pX?=
 =?utf-8?B?dUdJNW9SSnI5UTVrdjlVamszdW16K1IxWFFPWUc4V1M2dVpzbUxjajVjZUg5?=
 =?utf-8?B?UVcyT1hPclVDNUdQa0JJeXhvZzV5Vkx0YlRUa2NLS0NCWHFCZmZJTW1DSys5?=
 =?utf-8?B?ejFianZzMllJazFZbzcreUh3UTBHOHNXL25VbWhrMWVuMm1laTYxSndjV1BD?=
 =?utf-8?B?Ry81OXp5bnhxZ1hJcUNSdGtiTFV1N2hhSG13aTRNN1BjYkJydk95K0xNTVYy?=
 =?utf-8?B?YkVSWEIvMlgyeVNzTjBneWVXVlB4Q21NR0I0am01MG9sS2ZBdWhudk9mcTlq?=
 =?utf-8?Q?spl3Y+hq3SrYnIx00DMRJwNHIQVIDhJ6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0E4d2JSVEFMMXhNbGF4VURaZFVOZHgzbWUzeEdjMTRraERVQ0NtR1F6Y2Ji?=
 =?utf-8?B?dnhydzY5MTU3TjZJMGd2TnpLVlVOYTBoeklUelhxczFJdnB3ZzJ5b09xb1Jt?=
 =?utf-8?B?TGRQUXBOU1pNaHJldHZwK2s5MEtOTmlkQzg1RG5qbm4rbHNINFUxVlluZ3h0?=
 =?utf-8?B?cWVBNFBQNVZBZ3VYWVY2T3RTRFJjRE5zd1RuMFNFNjJKRG1qR1l6REhtWWpu?=
 =?utf-8?B?ZGF6blhTdUhPamYreWZpQTJ6cVJxTmpxcUJVUVUzZGgwQkhvUi9rQzVXK3BH?=
 =?utf-8?B?NHFjUy9rVTFXTEp0WkxvTnJ6Z2xqNzBmeG1zZzBFWGI3NkV6SkFJcnRFV3hy?=
 =?utf-8?B?ejBWbEFVVll2VnlkWVN0ZjJKd25JN2svYmN6dXI1amk2SWNEMEw1NDY0MVFq?=
 =?utf-8?B?ZTVVcjhpVWQ4d0YrWGVOU2gxc25tMWlueUF6NXNrb3FTaDZ2YmVEbnVOZmty?=
 =?utf-8?B?c2JtK0FCSDl4NVNSTFdtbHNPcm9saDlZalg3MEdOQ0g1Yk5OdHVyb3FoVkJD?=
 =?utf-8?B?UGdFQWZuczlGT3NiNEhIcFBUbFJ0UUZ3TnVjYk00NHBJMmhBWHpmTnRVbjB4?=
 =?utf-8?B?MG1Sa2RoSytrZlhwRkZLbElTTnJBR3cvOStZV0ZnQlBVQTBpeDkvZ0p2NGxI?=
 =?utf-8?B?eG5EUUM5U3V6S0VhL2RoeDdOd0hyUzdLQmM2MG1jUGdwSi84cm1Pc3FBRHhJ?=
 =?utf-8?B?aHNqWHVzWWZxYzlZeDhrWGZ4L25qMFdLcFBuWEpmdFJYLzhNWEZNKzE5Y2JF?=
 =?utf-8?B?SUNoSWhjMHJzdnZsWS9XTUJNQVVkTVo2Yzd3Y1Q0VVh5Mzg1UkRxWFBrQkNJ?=
 =?utf-8?B?ZGI0YzhlRGpWUmdYTWUzL1pvN2RUd1dOSHlTc1BXNzUvVmZySFQvS09PWEtW?=
 =?utf-8?B?TWEvT0Z0V0ZGOEdkQUZrMFdLVzFscllsVWJ2Tzg4UkhzMWxwS0J1cDM3N253?=
 =?utf-8?B?aUpyekRMS1FEOHQ0cTJhSFZrMkZnR3hyeW5tOWRBcGEwMU1jTUtOaVdCMWRY?=
 =?utf-8?B?SFhtd1hDWER0TDRIQjdjKzRDNzQrb1JoajZoSjJLR2FtdTJ1b1Z1ZkwyUXd0?=
 =?utf-8?B?dUFUcVZDNm9xc0hhRE1haml3NWJ0dUNvUkJNY0YyUHRzZjFRdElCMlNvcXFB?=
 =?utf-8?B?UC9VV3VORWNMWUQxM0hjNzFlNnNFaUVQWWttdEtkRng2b1FlWGU5SFQvbTFM?=
 =?utf-8?B?T3QyZGluWU1pMGJzYzlGaTNPWWpxeTdZa2phVFBNOHRvd3cyT0FkeHRNa3c3?=
 =?utf-8?B?VmVPUTN4eVZwd0RXTlJ5VVpQQi90azdjbll1YXVVbzlzWkc0SWNDc2NzYnBT?=
 =?utf-8?B?cTRhaklrNmRQdWRRNGZWY2k4S3JGaENUS3RIRHhTRDRPa21qVnhZYnBaMnY2?=
 =?utf-8?B?TWdVczAzUXR1UEtaZE9nSEtmVUhiSlBiTEMrQy93VithbXhMZWJRc012TDZQ?=
 =?utf-8?B?WDc4S3pralNEazV2QUZKS2NVTHoyUHJiYkpOanJwbk5oSDM0N2wrRVFLWlFq?=
 =?utf-8?B?TGlOZlprQ3FQekh0MlJINzk3OXR0S1lKYnhsZFJxVmZ4ZXQyTVl2RHorUlVN?=
 =?utf-8?B?dm0zZ00rYzZCU0ZyL2JoWUVVd01jYWF0N2k3RERnMGdBOGt1KytkSlFmVlVU?=
 =?utf-8?B?dmJuc281dVlQeDM4MHFDQWo2T2pWci9FRjgxSzZIZ0JLWjYraGFUbDNHUzF2?=
 =?utf-8?B?a21KY1Erd2t2enpEYVZLejlDcllkVmpjUCtSVGlQdE1GSDBMOHdzY1JaT3ht?=
 =?utf-8?B?WHU3RjYxRzMyeXR2aEVLWkdjcjRTcmsxdmtzNjBKenhuUDhiQy9vSWVMcWZj?=
 =?utf-8?B?SXlnZTVkanB2NWFCMVYxSmF1NXJjNG5zT0NvNHBmNysxcGhhU1lMT2hMVDdj?=
 =?utf-8?B?MG4yVC81YjFEN1IvREFNSVYvV09tbk1sZ2gzekhnbjZrWTA4aXRvN1VXUncr?=
 =?utf-8?B?WGlYcC9sUE5GWkJ3SURqemRwWmNLTjNIa0wxYWhseThSeGNjWitTTXBIYnAr?=
 =?utf-8?B?ZFczbVhLWGNIWGVWaWN1VE5vbGRMdE95dGNINEJBNGdwdG13S2dPcFgzNThx?=
 =?utf-8?B?RE5pRWFkWXZGcklMeklJTTgwMVJwKzNKZHlCcjIrMVJXRlUzRktEbGtoVytU?=
 =?utf-8?B?bGNuTXNld1FLTkFWMjhrWkpxVWlxeXZDdHpSekc3c09aUFU5MHZ0TUovYW5B?=
 =?utf-8?B?Z3Fra3cxaFNYdVpQNG4wenRCVWhKRXJGNVVVem5rdml6ZzBreGpVcXZoNGo3?=
 =?utf-8?B?RkdGNWFieXp5S1VsK05NUllDL3dHbXFjY3FVMFg3YWJyWGdqSEdmV2E4MDhp?=
 =?utf-8?B?T0pNZlVWK0ZobitsM3MyUE5IWW0zZE5TL3Uvbzh2N0k4VzVjSVpzMU5mYjRM?=
 =?utf-8?Q?cg3Uot4T/kQLk24QM0r4vBSVAtiC2wkUpdpbn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ee336d-768f-48ad-7460-08de4c021798
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 02:28:20.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAAc9AyYROd52uiNhcvDf3iPMvxLpxLWC0AUa+ZET81zzCvg4GHsPxp2pf5oac6+MX3N2JShtX4Foy2982/4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5403

On Sun, 4 Jan 2026 18:38:53 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> On Thu, Dec 11, 2025 at 2:30=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
> >
> > From: Gary Guo <gary@garyguo.net>
> >
> > This allows significant cleanups.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/macros/kunit.rs | 274 +++++++++++++++++++------------------------
> >  rust/macros/lib.rs   |   6 +-
> >  2 files changed, 123 insertions(+), 157 deletions(-)
> >
> > diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> > index 7427c17ee5f5c..516219f5b1356 100644
> > --- a/rust/macros/kunit.rs
> > +++ b/rust/macros/kunit.rs
> > ...
> > +    // Make the entire module gated behind `CONFIG_KUNIT`.
> > +    module
> > +        .attrs
> > +        .insert(0, parse_quote!(#[cfg(CONFIG_KUNIT=3D"y")])); =20
>=20
> Does this need to be the first attribute? I think it can just be
> pushed to the end.

This is the current behaviour, and I think it should be the first.
Other attributes shouldn't need to be processed if kunit is not enabled.

>=20
>=20
> >
> > -    // Add `#[cfg(CONFIG_KUNIT=3D"y")]` before the module declaration.
> > -    let config_kunit =3D "#[cfg(CONFIG_KUNIT=3D\"y\")]".to_owned().par=
se().unwrap();
> > -    tokens.insert(
> > -        0,
> > -        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
> > -    );
> > +    let mut processed_items =3D Vec::new();
> > +    let mut test_cases =3D Vec::new();
> >
> >      // Generate the test KUnit test suite and a test case for each `#[=
test]`.
> > +    //
> >      // The code generated for the following test module:
> >      //
> >      // ```
> > @@ -110,98 +79,93 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: T=
okenStream) -> TokenStream {
> >      //
> >      // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_C=
ASES);
> >      // ```
> > -    let mut kunit_macros =3D "".to_owned();
> > -    let mut test_cases =3D "".to_owned();
> > -    let mut assert_macros =3D "".to_owned();
> > -    let path =3D crate::helpers::file();
> > -    let num_tests =3D tests.len();
> > -    for (test, cfg_attr) in tests {
> > -        let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{tes=
t}");
> > -        // Append any `cfg` attributes the user might have written on =
their tests so we don't
> > -        // attempt to call them when they are `cfg`'d out. An extra `u=
se` is used here to reduce
> > -        // the length of the assert message.
> > -        let kunit_wrapper =3D format!(
> > -            r#"unsafe extern "C" fn {kunit_wrapper_fn_name}(_test: *mu=
t ::kernel::bindings::kunit)
> > -            {{
> > -                (*_test).status =3D ::kernel::bindings::kunit_status_K=
UNIT_SKIPPED;
> > -                {cfg_attr} {{
> > -                    (*_test).status =3D ::kernel::bindings::kunit_stat=
us_KUNIT_SUCCESS;
> > -                    use ::kernel::kunit::is_test_result_ok;
> > -                    assert!(is_test_result_ok({test}()));
> > +    //
> > +    // Non-function items (e.g. imports) are preserved.
> > +    for item in module_items {
> > +        let Item::Fn(mut f) =3D item else {
> > +            processed_items.push(item);
> > +            continue;
> > +        };
> > +
> > +        // TODO: Replace below with `extract_if` when MSRV is bumped a=
bove 1.85.
> > +        // Remove `#[test]` attributes applied on the function and cou=
nt if any. =20
>=20
> What does "count if any" mean here?

Sorry, I think the last half of the sentence was missing. I meant
"count if any is removed".

>=20
> > +        if !f.attrs.iter().any(|attr| attr.path().is_ident("test")) {
> > +            processed_items.push(Item::Fn(f));
> > +            continue;
> > +        }
> > +        f.attrs.retain(|attr| !attr.path().is_ident("test")); =20
>=20
> Can this code be something like this:
>=20
>         let before =3D f.attrs.len();
>         f.attrs.retain(|attr| !attr.path().is_ident("test"));
>         let after =3D f.attrs.len();
>=20
>         if after =3D=3D before {
>             processed_items.push(Item::Fn(f));
>             continue;
>         }

Indeed looks better.

>=20
> > +
> > +        let test =3D f.sig.ident.clone();
> > +
> > +        // Retrieve `#[cfg]` applied on the function which needs to be=
 present on derived items too.
> > +        let cfg_attrs: Vec<_> =3D f
> > +            .attrs
> > +            .iter()
> > +            .filter(|attr| attr.path().is_ident("cfg"))
> > +            .cloned()
> > +            .collect();
> > +
> > +        // Before the test, override usual `assert!` and `assert_eq!` =
macros with ones that call
> > +        // KUnit instead.
> > +        let test_str =3D test.to_string();
> > +        let path =3D crate::helpers::file();
> > +        processed_items.push(parse_quote! {
> > +            #[allow(unused)]
> > +            macro_rules! assert {
> > +                ($cond:expr $(,)?) =3D> {{
> > +                    kernel::kunit_assert!(#test_str, #path, 0, $cond);
> > +                }}
> > +            }
> > +        });
> > +        processed_items.push(parse_quote! {
> > +            #[allow(unused)]
> > +            macro_rules! assert_eq {
> > +                ($left:expr, $right:expr $(,)?) =3D> {{
> > +                    kernel::kunit_assert_eq!(#test_str, #path, 0, $lef=
t, $right);
> >                  }}
> > -            }}"#,
> > +            }
> > +        }); =20
>=20
> Am I reading this right that the macros will be repeatedly redefined
> before each test? Could we put them inside each test body instead?

Indeed. The `test_str` is different for each test so this needs to be
redefined for each test. I experimented about better approaches but
none of them are too satisfactory. I think the existing approach is not
unreasonable.

Putting them into test body sounds more reasonable (I suppose the
existing impl doesn't want to parse functions), but I'll leave it to
the future as this commit is focusing on converting with minimal
behavioural change.

Best,
Gary

