Return-Path: <linux-kselftest+bounces-24595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D370A12B84
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826D11622BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA61D63C7;
	Wed, 15 Jan 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oGjd+9BO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022140.outbound.protection.outlook.com [40.107.193.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4C3BB54;
	Wed, 15 Jan 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968092; cv=fail; b=f7y/XXalRbxCa06iloTMX6sQa5LFxK4MrqeOb3giPiMbeXKldRzG0TSaO9meB9MQLFEmD1WmGTRkpAMOjiF+ai0FYKduIXNJB4WCi5vJi+xaWWpbNapIrSit9Un8FVUvsxGxt6RXDlPKHpn/9t+0L6cnaUA9bLGxuOLVNLxtjJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968092; c=relaxed/simple;
	bh=Ed66PXanBwonF5KV60BT+ybfFuyr81/m68gJSX5H1J0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKQQFAZUtXcm72Z265GwuNP+DqpNINA5NgdW+HyqJMCFxhrtN7m75S3U5lxrE5b1g9cowHzAQ23kSuNrh1c7gL2BFAmGxL//jbNxj0zEkRmr48gWGVUMNhK0YAsc7HoW4aIfGzODka82GOz6ibT/HtcXUFo9/JjnXJ2dp6YonG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oGjd+9BO; arc=fail smtp.client-ip=40.107.193.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UULhCZjSCgxvg4nZMrQ1ZFtsgFSwWl+Z2f+eJ1MvpGanRjcHvWzhNtuBiXl1R987mIM6UPe8iYKJCr06BOxtWAP19L3rNP4F4wQKCuZ1ANZv7clNuLdV8VZQfknE0srFP+NA0tF+AkVpt7n9DPxuLMbpeQ6fScCq4SJpvUVz3UgaC9HWjXcIZij5cBEgN5KEfd+FhEf+5iXqIGQ4NPGmw9FKZheVx6nu9BlIBrJL9q8hDx7McUIVviYUded8ZrNL5uXxPqvlD9VrpKnsyi3mmhSivGok5VsnACscG9DiTDgGdcFnoubkmI0VMlwg/puP761Z3R4IlLYhNH7J8dNnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsfbR3WzxSPC1r4AJhPvC5nyXw5j0lCoX2oTRehQuV0=;
 b=xTXMGtbI6BXrEp7fmPudsSOoqr3nb2JZ55Nu1UNS6mxSCfahoiUp9ep9Ly5ouCSbTnN0/c9ITwjFhz7BiEvNFeLrGhjQYbIsm1/DrtnsQ0B0p+CAO0BRBKx9GgNXXYjGU4O3k2wXtqcwKGE4uqSUMsC1XCDlEJVO4rOS6dDq1CxzqkX9AdhBu0zyiz6FXlDeAkvumUdVzpIYg1W7+IO+yrxwJF3RTvVO8KUaxXi5nvnOveZ5uwmnldSbwxtAFPdrrx+EvCIpCTvtY+2SUFApykc5vg531QjXZxmqU1YYPIkBTDGX65cVxPM9Vx2i3A+YsuM8OvuGAaxVq6POJ4PISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsfbR3WzxSPC1r4AJhPvC5nyXw5j0lCoX2oTRehQuV0=;
 b=oGjd+9BO5hXX5SQN4+FlOXSyrK/8v0pDGS1BLTVD1KTDEuttVbYpuMyrQ5MZK0eStkP83DjvLH/jSNt8dP0hyO4ktjLRLWdFXjZe6VvhycxFzQ8IuqFqpbtdRqy95/FnpYmZerNwk9To0F7TNvBsazQQIHn53bfKeOzRLRiY6bofcOl4GB0ElQy4T1E5nu6Uha0b3sqUDPZXSvUXwcszRXBZW0QdYwWty7dVPlXVRIw7xWQ5Zw+MItCQERiXhP4z38+QS8J49yJvIAzja6Hl6iOarGQEYYElqp+EjKDY09HcyqfGTJj8LL5/lwnKJcirzcRJkDStQTq8Sz3MUuSyHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8232.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 19:08:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 19:08:06 +0000
Message-ID: <b236a849-93aa-4df4-8fa4-4c1c19f49ab3@efficios.com>
Date: Wed, 15 Jan 2025 14:08:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix handling of glibc without rseq
 support
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Raghavendra Rao Ananta
 <rananta@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
 <9b7228cf-29ed-4f35-8b8a-b4f8482c434e@linuxfoundation.org>
 <28c050bb-d844-4b85-a49b-39f2defc20ef@efficios.com>
 <0e4bfd16-76da-430d-a7a4-f1d31448ea43@linuxfoundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <0e4bfd16-76da-430d-a7a4-f1d31448ea43@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: ead75664-b7c5-4636-e40f-08dd3597f12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTVDT1ZCR0tEMjhpUUlpZ1YvcWZmbmg5T0srNGpNS282cnZ5YnkvUmhaUXRz?=
 =?utf-8?B?aTMyci92YStWWXJaNkRPeE5qSGV1RFJqbzlJUmh6dVYxaXVOTGVtLzl4amk0?=
 =?utf-8?B?cFZSSHRYQmVsY3A2aGhvZXZBVVJYL0pibzdSZ3l0cFZoOFBDTFVXeFd3d1V5?=
 =?utf-8?B?L3QzdEdISVd5Y2ZNdHFIcTIrMDY5VG5ZRWw5R3FpOXE5VU8vTkxsU3EweWpl?=
 =?utf-8?B?WEM1L1FKUjMrWWhLdUo1MmpKMkw1U09EWDVkb1IvdjQxWGtrMHo5dkdtdTFl?=
 =?utf-8?B?eSsrRXhhbjlBWXE1L3FQa01Uc0EzN1ZaYlcyVjZOdXB3TW1NMEcxaUpEYlF5?=
 =?utf-8?B?ZFhKQXhDNTRkYlJ1Wmx4TzgxV1NiV0xJekFiRk4xNTVhWHVNdGw2eW1rYnNB?=
 =?utf-8?B?UUd6TDBiK3hHMlVUTUV1RTVQS2QxQVU3d25QbTdEbUNKU0JOQUtXalhmTkc1?=
 =?utf-8?B?L3hmVEx6cUV2blpIUzZWS3l1amc3bXFod2lsaDYyQ2Z0WmU2L3Jkd1Q0cDdr?=
 =?utf-8?B?VUdwalhLVlFLQU16TTk4T1BONzMwdEdUOXFmV2hNSDFUZ0ZlRmo2anJiWUZi?=
 =?utf-8?B?UnljMUkyLzh1VlQrM3ArR05PalFQbk0yNk1XNXNUZkplUC9LTUw5S3RzTTZW?=
 =?utf-8?B?NllISklCckdaR3hnbktHRnNqQjd1bmZ5Z0x0bWg1dkxsWWU2WGwxSXFxdUpV?=
 =?utf-8?B?cVFGSnlObkJkTzNJT0F6YzBMdzNqTEZtU2E4MXpSbER3S3NISFpWMG9jVS9v?=
 =?utf-8?B?TlBjd0VjaDNObW5DaVI4K28wRzlJaXNJMnpHK0xBNlpKQXFOMjdwemhuZm5h?=
 =?utf-8?B?R3pqMVYweng3YlczaXBjNkNWcEUyeEhsMUhNVXBrNzdFWEh6WDUwWHRQRkVn?=
 =?utf-8?B?SXREdC9OcXZZVktPZzRkcklQQTRhTkxuZFdFblFPQ3hjQm1KdUNUNGlzSFQr?=
 =?utf-8?B?UkhlYlZkaisyRDYvWEVFQmVSODlwYVRRN3lNejhOZXRLSzFWZDFUTzhFSDVK?=
 =?utf-8?B?czVFQ0h5MFRMNWFtMmVMZVh6NHl1eDRZR0l4bGJFaDluRThwSFBqLzBORmNx?=
 =?utf-8?B?QWI4SlpZRnEwVHZYK1F2dmE1M25RdTFLY2lnNXV0VUN6N0QrY0RZQllGZUV1?=
 =?utf-8?B?VlBrMmU3aXhDallpOWtmK0EzNE9JNCtqdlRJZGlyYzNUai94OHdLUVJKb3VZ?=
 =?utf-8?B?ZGhBa2lqcHJiZFNJMHNTWFNwcXFCMnNIbHVjVy94aUNKa0YxMllVdlgySjRQ?=
 =?utf-8?B?b1RrSGZLSlpVS29veW82bXJlTjY2VXNsSXV6UDRlVllXeWZtVHpBb2xGZnlx?=
 =?utf-8?B?dXNnWlNJdzU5M0pOb1V4VFdYaXhiQ3JJMHNrMmpuMWRGRzViZHRTUGpNNXcr?=
 =?utf-8?B?UFp3cnBvVmtMYmYxbDR2ZEVzSUpodWNCcEpnWkQrVnpuRDc2REt0L2wzbTQz?=
 =?utf-8?B?VWxyVXE3d0ZKYW0rRVdqMnpvcjEwcGcxUHRRZmxWOWwzS3kxZzZmaWZHWURV?=
 =?utf-8?B?TnFocEhXcnNjc3FDeHJkeC9lQUdqaVo3VldOdjNDY1VOU2ZPUnlxTEVUNTU5?=
 =?utf-8?B?Q3J2dUQyOXhHanN0Y2p5VStpY2IzZlBQUUpKZWkvbEM2YkJBZS8zbU1hYWZO?=
 =?utf-8?B?NE5KU05XaThVbUo0a1dkQ2VZZTdidVBVMnR0TEpHSWJ3TDBIbGt0M0RuNUFw?=
 =?utf-8?B?OXRVOC8xQWJ3YnVCTmRkUU54N3QwenF1VjBBdHZRQml4VlU5V2RSS1pkcG16?=
 =?utf-8?B?THZzVUVrQXRmNy9wQTNuaHhoTlhETmd0RituQkx3SWdxZTNUaG1ES2NiQ0Nk?=
 =?utf-8?B?UkMrYndrb3BCeXVHRWpFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEtpaFZNNlhjNWkxZ0dQejhENVliQlpWWlBlZUZSL3VabHFxSFpjQitqa3Rx?=
 =?utf-8?B?VUFZRzFrczg4RytNU09iVkFmRkxFR3N4K2YzZnl0b0lMcmE5NUF1NEF2Y0Jp?=
 =?utf-8?B?NzFQMlJkT3MwSU84Ni9SZWFHRnNBeWxBd21SQ25xV0JUdTAzM3pCSFlmaFlC?=
 =?utf-8?B?eWdKYm5FQ3R3bmMvdE9SUUJ5VnFvVkFrS0h5dlJqSXFwRU0wcEg1YjgxRmdu?=
 =?utf-8?B?RUFUQUVEVDNQbjhjanNxZng1OGF1U3JGTTZoR2gvY3l6dHE2a1ZBNFgvOW9D?=
 =?utf-8?B?TEhYWG1oWFNmU3hVMzB5cVR3b3plaTh0Z0RVbTFISlZwem9tTGR1UlNwWjVh?=
 =?utf-8?B?TllTLy9za0dsRjdXa2NMVDFLNEd0ZXVhbm52QmtYcm54c1FGTHVyTnR4T0h2?=
 =?utf-8?B?L1V1V2dOQ0FEOEd4bFdLNFlSR052YkRFOFptcE90QXhMV3V2KzRDODdyVDBP?=
 =?utf-8?B?UjI4L0trb3RSL1dsUHZWbG5KNFdjbXRTNHFTWGtkSWllMnpWQUMvbFpscXpX?=
 =?utf-8?B?SFlYbGRic0FMRmZiQzA5THhqSGRkYXN0ZWVWU1lNQVZSclRsR3pvekVmOUV5?=
 =?utf-8?B?ejVRMXZDN2l4N0JENTBqdkdvektGckQzMlp0VGVRTDN5bklGQWVUcVQ5QVFZ?=
 =?utf-8?B?ZHcxenFYbTNVT3VNR0RtTjVNS254cklYYUVvSmVhdUVubDlqM0JUK0VIV04y?=
 =?utf-8?B?VGZsb05HSmx5V3FuQlZxNzI0S3UrRTJEbGROeUt5MkFqaDFvMHduc3E5SXhR?=
 =?utf-8?B?eDZpeTJHeWlWd0xSVlhuVXBoZzZCK29FV3Jtalk0Qi93NVJUZWtHQjA4STRN?=
 =?utf-8?B?cy8vMjJEVHUwT1hReFRJOE5pUFcvVmZFMFdsazRmclh6N0JHWkRNemNUaG9J?=
 =?utf-8?B?cWN0K3VLcmllellwVVF4aVRXQ0lpTFp6QUEvTVprMGZ5WXlGWGw4MkxEYnov?=
 =?utf-8?B?TFNvWW1hUEU5YXdVY2kvNzVObWN3czJLUDRISnpFV3VOdVhCb2hxYjcxSENi?=
 =?utf-8?B?RXJhT1dQVi9oM2lkemJ3MGxNQjVoMTJJNFdVZURySXhHeURPMDIvWnNzZGhJ?=
 =?utf-8?B?YjRyTHpnc3lMSTRGMTh0THRQUUdKZjFxVEFMUFZYVSswRnNCcUNDTUlENzMr?=
 =?utf-8?B?dGwvTTVBa0xWYnpEdDYzbkloSWUzeUwwbTVLYzBVd29kQTlrNHFPODE3N1Nq?=
 =?utf-8?B?cXNVRkxkNEw4bW45amx1OTFUbGZsajJPSjNyMU5jYjRCMi9GbXFSTllmZ2ZC?=
 =?utf-8?B?TDAwSEZVVjNTc1lNRUtTM1FqRExTWW1aZDcvVHA5OFBTVkQzN0dwRnhNcGdP?=
 =?utf-8?B?N09RRDNUYWphS0tuZm5QRzNBcm1YMUthTThtdXpPOHlHQVJFTENlVXVWUTFS?=
 =?utf-8?B?UHR0V1UvYmlJWFVUSTZUNHVUZ1ZyS1FXSEdrc3NPcW1vb1VzZndBVGFUV3BM?=
 =?utf-8?B?akN0cTZENDN4RnR5L3RYWjZQY1hmV29IQlVUKzJkY2djSUpqRm14RHFMM0VU?=
 =?utf-8?B?RmRGWnJ2dXlPRUdTN3cvRS91bndzZEd1ZFNkcnhwNzBEbHcvQm5PbWJPNjVR?=
 =?utf-8?B?Rjk1MFVteHpzczhxWFhRY2x4S2gvRHJkSmRIU3YyblRhRkZYUWY2SzkyMlVl?=
 =?utf-8?B?eUxTQ1dxbUxVQ3FRREpVclN5VDhYSFFWeVlibWxnZ3JadHVva01xd1hWMFQ1?=
 =?utf-8?B?MHA3U0d6N0NaUncxNXRQNlIvdGRsS1RMUVcxaDE5eWNrcm1PTGNqR0lWMVZI?=
 =?utf-8?B?SGxZdm05dEhVQTVoMEFUeWRKRWlTbGxpd2tSTTZrM3FOSXZiQWUrakJ6ZkNR?=
 =?utf-8?B?QlZpc3Y3dTlTWnpYSE1uOTNLdWdvbTA5ZDhkUitveCt5UWRYd1pZRGFsSXRU?=
 =?utf-8?B?bkU1OVlTTktiTDNVMjU4Q3VpRUxqQ0E1dUtXcGVFQVp2U0FBa1BDY3JBWFdF?=
 =?utf-8?B?Q1FtUW90VUM2b1pNVVN6MStuVzlDRVhLTmdVT1VxWTNvUUl6Tm9tLzZFR3FF?=
 =?utf-8?B?OUhid25GS3pqT2lqZWt1Tmxvd1BGL0F4YWJKdTlRcHdDNi8xTm9oZHpYNWNB?=
 =?utf-8?B?TnBkazhLM3VKQU8rZk5hVlJkNFpIeWV0bC9LRk5lWXNDaXV0R1RJeXVGQVRj?=
 =?utf-8?B?cGdYREZnWGREMzl1ZVRsTkgvQWFaRU1iUzJ3Q1BYQUNRYUUyU0krSnR2SWNH?=
 =?utf-8?Q?5J/zEFWfTrujAq0wNc48nvQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead75664-b7c5-4636-e40f-08dd3597f12d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:08:06.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJx5zBk0CUv6SoGd1uZG5Xs97SA/7MeIbeHKsxGlKnyeqQUGxHypeI7ssTp9eetu+FZBhkk9FNcVrTu59p9zaIUs+r4Fw1cjBNDxTOMyieI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8232

On 2025-01-15 12:57, Shuah Khan wrote:
> On 1/14/25 17:45, Mathieu Desnoyers wrote:
>> On 2025-01-14 19:14, Shuah Khan wrote:
>>> On 1/14/25 07:51, Mathieu Desnoyers wrote:
>>>> When porting librseq commit:
>>>>
>>>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>>>>
>>>> from librseq to the kernel selftests, the following line was missed
>>>> at the end of rseq_init():
>>>>
>>>>    rseq_size = get_rseq_kernel_feature_size();
>>>>
>>>> which effectively leaves rseq_size initialized to -1U when glibc 
>>>> does not
>>>> have rseq support. glibc supports rseq from version 2.35 onwards.
>>>>
>>>> In a following librseq commit
>>>>
>>>> commit c67d198627c2 ("Only set 'rseq_size' on first thread 
>>>> registration")
>>>>
>>>> to mimic the libc behavior, a new approach is taken: don't set the
>>>> feature size in 'rseq_size' until at least one thread has successfully
>>>> registered. This allows using 'rseq_size' in fast-paths to test for 
>>>> both
>>>> registration status and available features. The caveat is that on libc
>>>> either all threads are registered or none are, while with bare librseq
>>>> it is the responsability of the user to register all threads using 
>>>> rseq.
>>>>
>>>> This combines the changes from the following librseq commits:
>>>>
>>>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>>>> commit c67d198627c2 ("Only set 'rseq_size' on first thread 
>>>> registration")
>>>>
>>>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
> 
> Fixed this commit id
> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")

Just pointing out that you did the right thing in the commit that ends
up in linux-kselftest next:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=336d02bc4c6bec5c3d933e5d470a94970f830957

Fixes: a0cc649353bb ("selftests/rseq: Fix mm_cid test failure")

Which is fine.

Thanks!

Mathieu

> 
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>
>>> Hi Mathieu,
>>>
>>> Can you double check these commits and make sure these are right
>>> ones in the mainline rc7?
>>>
>>> I am seeing "Unknown commit id" warnings on all of these - my
>>> repo is at 6.13 rc7
>>
>> This is because those are commits in the librseq project at
>> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/
>> which is a different tree from the Linux kernel. I am not
>> sure what is the preferred approach when citing a
>> commit ID from a different project ?
>>
>> I've been keeping both rseq selftests and librseq in
>> sync since 2018. I plan to eventually add a dependency
>> of the rseq selftests on librseq, but this cannot
>> happen until we freeze the API and cut a librseq
>> release.
>>
>> This was premature before we reached the major milestone
>> of having extensible rseq support in glibc.
>>
>> Now that it's merged into glibc (as of last week),
>> we can start looking forward to a librseq release,
>> which should eventually eliminate code duplication
>> with rseq selftests.
>>
>> Perhaps we should add a Link: to the librseq
>> repository ?
>>
>>>
>>> Also would you like to add Reported-by for Raghavendra Rao Ananta?
> 
> Added. The patch is now in linux-kselftest next
> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


