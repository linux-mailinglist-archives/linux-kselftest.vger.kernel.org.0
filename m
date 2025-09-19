Return-Path: <linux-kselftest+bounces-41944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A7B898D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E250B189CDCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD31236A8B;
	Fri, 19 Sep 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m5tCggpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012009.outbound.protection.outlook.com [40.107.75.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EA223DF1;
	Fri, 19 Sep 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286472; cv=fail; b=BWs7v337kqD5V8V3dbV7TSP6AtDTF1SNzWxfGV3zKlRgDbPsn+Nf//xKqG/67HhXuPPPQxr+qw84wpTiaSCO+BkyRiunhNqHJn47clJzHEy0yvB/yMaP1LNnPQ90AmbMezoYhNCxpe8FXduWN0hI42bFDaaY1FL2WOFR+qru6d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286472; c=relaxed/simple;
	bh=ZCV7LY8xlJU0wLxJoU2OinvQkN7xmZJS8gYnM45d7KQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tz6brNn8Fg4vY4scTymIgpGSIHmuowAJF6KY0qGhXskjOurNimtmhBsSbpxhVANnDX/lYpoe+Ojlo83ZR3vAaUBEH21EuTZTaH4mi7a7bbIdAEYyelOFgHWiLEJJbozw/vbEhT5z3x84xi1YLGaFOtcvXaXigENS8rmKpxwEoZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m5tCggpO; arc=fail smtp.client-ip=40.107.75.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G34tHaGWnYWjqwwU0+30crkv5y5ZrCYLsMIKOdgJOA3FRwzdj3W2ywIDrly4KKK8CXgU/lCTDOK+2khnqytH6TWeoQ1tRbtfHRT0NeJuEvgORGPdNb5VSzpCzfDQLXMC8JDXYGHGoo/Av6X78aBgvBk2WimCYIUgx695Dk6iaoSpbMHS/WzzUIFlghjqBObClgz6c0Ns8dv3yMtKXm2fwrrWEW34dvYpIGKZYDu4DMwinvxJ80dnDEDqwlfherWMyv3YN/L1YAoaB5UJa5kKlg5LaAeTcvuNRHqwjaXZEUxRYlGiLDxCBLxgqFaocuTbXS5y2C+YrPXUsh6p6pFrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO867iXFZxUCgrYqdvFYvPzTFJqa4G8CNxZQYavv9qI=;
 b=NGqCt4rSzxnlgP379piLO6qPIUZ/8pZJmo4K9vfqSXgGyJBb4Y56u7ruGL0Tu0SRlDbfvJpN+fsIbT5EqZoPHiPyGnkN1uXdG7ngCPv7pOxTAex8md+wWQHwG9cC34ejMXBRXOnFpBaj+nfnZ4jeqVLfyTnLIncQ+HEzQkLBTVoFZMb9nuOaX5kzt8Wp0WJIs2Mi94A6lHBq6vdwJ+U3Kc0efe9NrUQsXX4UP9pf1fcDI8AeymnEhEGyV8OFFKY4rLVoNOy43mQsaPC3XGlaQ0y6Lh5ysuPop1+MoLMyHXkbw7myHp959dN3Eudj83w7cKwRT2f8r0Xjli6NLf5RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO867iXFZxUCgrYqdvFYvPzTFJqa4G8CNxZQYavv9qI=;
 b=m5tCggpODhbm+Eu8rBywz/znHmJTHbQZrjQz0Ow5RgB0bTyNV2tdnDr3MrCTdY3GDGo3O1ZhitbWzpLFEyRjh1RoI3wTxgnU0kBdZqdukpywAx+kY9B7MbPWDL56rIl+0Ur52iFoV161VrytO0IlCqB66iPZY6hZF9F+J0ODpBu83Gz3o1uCvdJvISTdd1westD5NvVapZbcGHXNcTvZLg6aK+doHZJHdTQXHo3HrOOdfErpUjtQe36v55pvxOEMSVfgZjBgqgELJ9e3j3tdEnKgGYv6puk9xVs9KoEAwr5/UICJbxqrNzDMp2vR9pDnEO5d21NaHWgabtt3UJ2Tcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB6471.apcprd06.prod.outlook.com (2603:1096:400:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 12:54:27 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 12:54:27 +0000
Message-ID: <c4a62603-11bb-4e93-bc7e-75f8b4574c63@vivo.com>
Date: Fri, 19 Sep 2025 20:54:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <20250917153055.6fee814f@gandalf.local.home>
 <e8e8b5e2-35fe-43cc-ba41-c84ccba189f7@vivo.com>
 <20250918112425.23d4d379@gandalf.local.home>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <20250918112425.23d4d379@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 54defc9b-af17-4b9e-b30e-08ddf77baa25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVkrRjJSOVowc0ovVmxQaGhDaUxKZVNkMFdYNmJJbWJSejE0SmZ4RFphaVV4?=
 =?utf-8?B?blNZVnJockFDMEwyWHdtajVIMU8yTXBzeWpsQU16RmhKVGtwWDJRVktoMkJ0?=
 =?utf-8?B?SXJFUG9ya2tzZFRHS2hUY0IwZlBPMUtCOUFWVXVkeGpyREFLeDQ3M0Fpcjc1?=
 =?utf-8?B?elpGcEhJdXVKYXNXSVhXc21LSk8rdzd0Rlk4TW5tYnpNMkVhWTVlTkEyN3Bn?=
 =?utf-8?B?Nk93ajB5YmhUMEhoZW9Vc205MjFId1FnREFpeUdDY0RUSm9rZThFRUpraWNY?=
 =?utf-8?B?YnZDT2xRSVkvOHQ1dzdOVWJhRGJBT1k4amVJNXRXaW5uaTJRdEJNTmRFZmFl?=
 =?utf-8?B?ZjZHZXBFZ1VWY1JxemJkbGd0VjNON3I0aW9rOXpVZUNJOFc0QXh2bXQ3VkxT?=
 =?utf-8?B?WDdmYk5IYTg0MnZERG0ybTkrR0ZkZDkrTkVEQmF1R2djVFA3U1U2VE9ZOFZW?=
 =?utf-8?B?YjMybjRTWS82N2ZXRm5GdWs4cEUrYTZtc01iOXdkUkZ0d1ZKNENIK243T2Np?=
 =?utf-8?B?bzNDSDNscWNta3R4QjdCNHZmSy9IWUFxdVA0anNBeU1iQlZ5bXEzZEFXUVN0?=
 =?utf-8?B?ZHo1bnpZSXl4dXhNTUdmeHl2ZVBDanFyYURJNDYyTkpqMFV4V09NbkZUc2tH?=
 =?utf-8?B?NHdKaUIyOHdFbnoxTWhMSkZaNzRkbkhpcXJYVDBFZU5VQkY1aXQ3OFFTTjFi?=
 =?utf-8?B?S0QyTUNHRzZBTW5JM2lQK0JLOHRhU21UNWhsaFJhNVJ1dlFMQzhQMDNNM0Ni?=
 =?utf-8?B?bWlmRTdFU3c5U2s2WGk4UkdSVXhoNWNlOG8wS2EvUHhnaEloSnExY3dJV2pa?=
 =?utf-8?B?VVlablArT2VLVkpFcklZbFoyK29FQURtWm9zdWxVUkwrdWdWZVRCSmwrMlNq?=
 =?utf-8?B?THhGditqV1YrZlZhQVR4T0hvVXFHbE5QYjNFWEVFbkUweDZzS3gydTE0dzYv?=
 =?utf-8?B?MFltcHNubS9jUitIVTk0TmtRai9yQjhKZmFFdmVHN2FRbUkvNFJ4OTZtRzNk?=
 =?utf-8?B?MEhTRE0zV1BidXNSeGd0YUt2Zm5xaFpBMHdOS093MW80M21CMkExNXlZVkEr?=
 =?utf-8?B?SjZuRHQ1dEpvRm1vK0FOTFhOMWI0d1hGTjFqaUxNa2twWldmK0grNFpaTlR4?=
 =?utf-8?B?MlR4OXRVdVpsMDdUZHluN3FuSEtnRUF5VE1qVkRCK1l2WWtXQkk4VUFoUUY0?=
 =?utf-8?B?YklUREZPL2pVMVZFUFN4cVhsYjRsaWRwdDBBTERNV09OTEpybnBlWnJiQlV5?=
 =?utf-8?B?cnRJdFNhWEpWR0c1azdLcDZmREpnTld5K1hEVGF3VUlKYTFuY0wyRXdYa1Nt?=
 =?utf-8?B?UEt6eHNYMlR1LzVvSThYQjJ2RUU3MVI1YmE5Ri8xc3pvRHpYWGtnNjM2K3Jx?=
 =?utf-8?B?cnNORFNSa2p4TUtqRGlhVCs2dXdDc1pQUlNLTWRyaG93Y2JQYWs2T3VIQ0R2?=
 =?utf-8?B?NDFXNGtHdXVKa3hZNjZwYTNaajkxS1hqWlNiTHB1RCtVdStKVVdOTHpFMnRY?=
 =?utf-8?B?N2dEZ3NVWkpxUVNYa0F4MDRUQkN1TC84NmZDQVdUUk1IaC90aXBlWVU3S20x?=
 =?utf-8?B?aTJiYmxMS1hhcFhwVHQ4dytZd2REckhCa2dQZDRSTllsRkVOdG1LMmIrdmZD?=
 =?utf-8?B?OU9jQlRvWlJhV24xYlpJaUVMcUY0UTRlejdGVFZDeVZON0hQZXJac3pZWGJ2?=
 =?utf-8?B?VEh0ZEtPbmtUZGV4czJNUVVoa3VIVEMzRVhUcHhXYWdDcTVRWW1hV00xYmts?=
 =?utf-8?B?cmFmVHczOTEwL2Y3ZVdzazBFQmowQWU5dGs3cnNsK1Q2NXk2TXBEbDRrVHky?=
 =?utf-8?B?eTNQUjFYdGgyNEdLV3JsVE5peEFEa2R3WlhvV3kzWm00YnVSS2hSamZ5MDZI?=
 =?utf-8?B?d09mTisxenN5azB0MkxIVFl2bU9SQWVBM2Z5NFNqOUdVSWhVRFpYODdxVHFS?=
 =?utf-8?Q?7iWhJ1nxeTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZNb2JyUG44TnFQT1ljSWRQMWlGZ014eEg4Q0lJd3JSa3FSdHcyZjhQbFZu?=
 =?utf-8?B?V0RMbStnQ1V0STdHNEVVUkdqZXhvVUQrVTlHYnF5K09INmVNek11U2lSQXJ5?=
 =?utf-8?B?MTN2RGJ5cU5LaDlFeXdWV29DVFg2aW1xR3Bub29XWHJXN0JlbnprSTFKUkZw?=
 =?utf-8?B?YVBhdmFsemM0VmFpa1pPdk1yT1NXWlp5WCtXWUVmcGtBcE14SnloakFGZFBR?=
 =?utf-8?B?elBObDRKazJrd1I3RDk2aUdDWHhTS0JJdVJvaWlRSkF4V2g4TTRFYXB4WFBT?=
 =?utf-8?B?YUJVWGQ3WWZYNU1Da2owcGNiUG1kUTNlZUdNeEQrL0o3cHRTWjcyUkFLVTVT?=
 =?utf-8?B?QlRPRXA1Y0NnUEVVc2I4OWVCU2Y1RXBPZ1ZnSzUrUjdLTU5hY2JKUER4N2Ew?=
 =?utf-8?B?a1c1THlLcGhZaTNJKzFzTDNybEJOeWNUaEozQXlMYTZ3cTgzZ0N1M1M2SVdJ?=
 =?utf-8?B?Y0Jtc0RCMWlNRVI3TS8zb3FDaHVqUlhQZStNWjlHUmFqYUFwNzc5bWhlSGJq?=
 =?utf-8?B?QzltbEZUSktnSzJ2Rk45emJHMkoxanVHUTZuWUNNQXh3bTM0bjAvd2dMTURG?=
 =?utf-8?B?MUVLYXI1UWkydkgyN0srdi9CM3ZlbUhlc2tNdzZLcTJPVFE4RjBQQU5ySHJU?=
 =?utf-8?B?WnVTNDJSUEZDVWV6MEZnQ1NndjhwRVVyRi81VkJEYnZrQUU5UGNpQUllTE9V?=
 =?utf-8?B?NUZxeEdML0doWFNMdDlwVVdsVldXZXdFR2RtM1IzMFR4UThOS01zNjJKaHJS?=
 =?utf-8?B?cGJhV2pBV0lGS2hpRE1neEhXYVVsdmpMN0hpckJKSk5Oa1NsQlliWFRSVnJ4?=
 =?utf-8?B?bCt0d28yVktaK1lVeFJPSHd2NW5KQUkvN2M5eCs4M3MzSjJTaGxCdng4TzJM?=
 =?utf-8?B?TzJXMDNQViswbW5ZZ2htTWF0YWwyZERlVzhxZC9KSHAveFFiRWt1dGt6RGZC?=
 =?utf-8?B?SDcvQjVqMEJhNWRtZCs5UXhLVHJuNitZKytKc3UrMzhsZGdKU1QvMkM3U2ww?=
 =?utf-8?B?c21UVExBaDR3c2x4Z21XbkFFOGxKNU9jdmJKWGVMdzhHekVWV250NWF0Wk41?=
 =?utf-8?B?V2hmVDlNckZmUnNjUjVyT3hxcVppVXQybktkaVhjWTRHSk5oS3VJTG9CdTBC?=
 =?utf-8?B?K3NaU1RuV1duZmc1NHh2R2V2M21pbTV1ZnRnZnI3ekJoWCtId1pqZXZ4ajBq?=
 =?utf-8?B?YVcwVThTTm1Rd00yd3ByYW5hVmlmOWViNE5CSUpDN3hVQUoyclFiSjlQNVVt?=
 =?utf-8?B?WTJSQitOMHV3ZTU1LytCQXZvY0MxUVBETHBYR0wya3Vsc3paTlZLVUFQUmtB?=
 =?utf-8?B?NTEvT0k5YlFRallQYmFNQmxaT0FDOTZSRE9XdnNJYU55d05qY1IyNjhWTWl0?=
 =?utf-8?B?V1VxQ244T0laaml5UlpoM2dCR1VrNkxlNVhrTFVjZEIrNjlLeGRIZTdJQmhK?=
 =?utf-8?B?THJ6T2M5RUQ1Y0FEWXBrVnFoRTAvTWNweFdKelpWRVNxbjJPSFZFbG5TS29y?=
 =?utf-8?B?dC9IcUt5WFRlbzdzZEZ3bndJUjNqZEVzVklQRkpRMjlYV1VFZ3lwT3lKOEtk?=
 =?utf-8?B?TVRJNklJR2MvczJQNTkyV0xmb1lxK1pvZEFEbXRvV0VkVUxQbThHcUpwWVFI?=
 =?utf-8?B?bFF1NXN6STVDYy9WOFROU3NpKzBOMlpKN1E3QlUxVGZZVDV1QW1ZdFVjZjdD?=
 =?utf-8?B?OGNFN0oyVnlzVzhvWnJnR3FWdUpxTU1DT2lqd0NjdkIxSGlQZ2NST3o1OGZF?=
 =?utf-8?B?Ui9GS3VCblFwTHZzNVkwQUVqMWJRVmlESHlKa0ttZm9HVDdPRjZ1Mno0VHZM?=
 =?utf-8?B?cVg3VlI3R09JOWFKU2VwYzFwUk04NkhUdzRtMkhRcXJFUENHZEltUkNqd3g0?=
 =?utf-8?B?V1l5RzYrL3RHOTc2VnRWYjFZcnROVWhTaWNkVWk1L2RkUjVTRGhIcnd1OGQ1?=
 =?utf-8?B?VTAzUVRETmpiS2dMU25kSUdnK3dJZ3FocXlBUXVNeUVROWlaMGUwa2llZXJq?=
 =?utf-8?B?Z3hoMG9FUXlvV3lERlBQNGdVT3ZlejV2NTE3cm5keThCRDkySFBNekVGVDJy?=
 =?utf-8?B?MWhRZm1ZOUl1VjFBQTlHNm1sRmlEN3AvT3RNQy9MNFNaZndrYlhtc2VuQTRl?=
 =?utf-8?Q?7+GfzqyeTX+t2u8ZEYYpGvoe7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54defc9b-af17-4b9e-b30e-08ddf77baa25
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 12:54:26.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H/5nzeQrD1XSokxUBzKVt/MFj8vaE8DDS0e++jDKkUhaf4kK7gqXBN/2R2ZteIpnBZOQMKYfq05dmaXCdb2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6471



On 9/18/2025 11:24 PM, Steven Rostedt wrote:
> On Thu, 18 Sep 2025 20:33:22 +0800
> Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> 
>> At the moment, I don’t have a solid real-world example to provide.
>> This work is still in an exploratory stage.
> 
> We shouldn't be in the business of "if you build it, they will come".
> Unless there is a concrete use case now, I would not be adding anything.
> 
> My entire workflow for what I created in the tracing system was "I have a
> need, I will implement it". The "need" came first. I then wrote code to
> satisfy that need. It should not be the other way around.
> 
> -- Steve

Thanks a lot for the feedback and guidance.

I understand your point that new functionality should be driven by real
needs rather than exploratory ideas.

I’ll keep looking into this. If I find a concrete use case that
demonstrates clear value, I’ll bring it back for discussion.

Thanks again.


