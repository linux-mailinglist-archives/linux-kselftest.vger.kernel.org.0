Return-Path: <linux-kselftest+bounces-27389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB9A42F13
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E573AFE8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE871DD0E7;
	Mon, 24 Feb 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PespLxNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922822571B2;
	Mon, 24 Feb 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432545; cv=fail; b=D2rzGW4W/ERmV4DaaT9PRJ03Ru9J+aJldyyowX3hwD5VVCQiSPevasq9V9dxf9cYea6SkOZkF+GOD9KSyA5INr3jP17RLxnvhbzf2jqloHQUEU/pF9gNl6zkBITaxG6c3TGTvASbirOmzmHafvbUW9t4BFWOxeqdeJP1VIQ0tpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432545; c=relaxed/simple;
	bh=iiHaHi5dqptjZrBrk5tPfwn66aYQS5LNw2EQRhd2gRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UiUKNYM8/2Fw/uzAuw9xUbd5ovxW0crg8eJB7ST6cpwiUz/A/yn0XELGmqBGR9Xbzzbps3BGxepBaGD83GI4YO45QCxcQ1S6IAJhqoy3j4AvpWWkB5dhtrzC5xSxXAQuta3+Vz0+7bqq2oabQYNWXfnLIvuX4h6c3rJUKK8ZIcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PespLxNB; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhUzDG2DyxsZCVG60sp6UhBomyopb/pMxDuHsc69p6nt+kFDADs4O4BHyIOxXRkJkQ2l3QH0AAJOzsUgp+xQQw9YGX1wSnyLUPpehnOm0P2VKp31Y+0KUVEGWB45mSSLY3PfKZ4BezMlh/ytOLZ7/NzsYz0maORIrjPZZcjsdygg3DvkNkUgXzR2Om/kbZzaBCJtbGsZDvfYebMTYpxzgooBP1dTNVft3XsckV2Hi8KUr63jFViIbtLwKm4MqhUSZTHecKTwFj/+3NLc/PWhsZVguNt4/exCzYQgDXaDwLObKoGCgUBZszDEJ7Dz6u3YrFPIcyYOovRRvnJYEddW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HKl5x7sgGUI0Ckr98jtpMbkcJZBmVf5YSuCrbzRrMk=;
 b=xXAevV8PjFxFwU+N3aRMUD/WAfWdzpFX1VpJOm/SJlYBb2xrMrjZ9CA+/Ienk3hoUr8a+ycZc6IoKzBkeGNB2qPgvKicbl2p5XllaaSPvBUstQWVDeftP3m0iN7ICOeMTD5pjpAbohsiFxLGO+N/LQtvltOXOpJkPOs74vQD77lPW4DC8g1AzUkuITotWCfvx4x8fp+BQ1Hk/x5ohQXnWgkqTY7EeTfgeYt/JrOWZdnCPF6O0oUZMbNBjtgM39XWMpOUMyiIRFcatgwhmoX5GxGwGFTy/X6ebsUZ16jNgl6wgE0iz41lAmjSXOprZQXQjOS8eNpwVkWc9TEKRcTnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HKl5x7sgGUI0Ckr98jtpMbkcJZBmVf5YSuCrbzRrMk=;
 b=PespLxNBI6Aq9FRJxX2pfU41LxV4LfIIThdWcfQbRNY2m+gYnxn9BU7h/+W3mCP6BTucE5NGnoRykyJkKcFCl0MtYuUf2tTTz8ys7HImB+P53Ive6EgfTAwQq/GvhT2+sOV8L1mish6+34G4nsJuDSKJ2qYGAB7mvzk42IW8xdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 21:28:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 21:28:54 +0000
Message-ID: <88fc49a9-d801-5d8f-f156-28fa06910cd6@amd.com>
Date: Mon, 24 Feb 2025 15:28:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
Content-Language: en-US
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250221210200.244405-1-prsampat@amd.com>
 <20250221210200.244405-2-prsampat@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250221210200.244405-2-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:806:121::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f50310-a7a7-4678-22fb-08dd551a3d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si9hek9JMWVRUEY5KytBVktvaG5XT1RpcUYyZmhhZk1JcDMrbmx3MEZ2dXpE?=
 =?utf-8?B?aHJSZkswWitDYUZyMlpsWGJlREFNT2hvSHphZStGZloxYnZKWkZ6RVpkRW5J?=
 =?utf-8?B?UjUyeXE5SkpxNy93SEhLRE5EV3ZmbWJONnJzZVMxVFhqWThPVnY0bEFlTHhS?=
 =?utf-8?B?Q2Z6blZINTZXTlZpODNsVE9kOU5sTXlGaXBwL21WV2ljRERmZmxiS0FIRklL?=
 =?utf-8?B?N0h4aXBlR0VUc3BJQWZYaWJNWUt2VDJZVkpvaWx0cXlxS2VGUlUzbC8wcFNr?=
 =?utf-8?B?OFE4Y3hmb3BaUzNXSXJFVzhGVWdVTVpxSHpHVWFGVGFYTGZ6M0VXc0pWd3pJ?=
 =?utf-8?B?M01veXRBM1RYVFVsaVN0WXFleC9pM1Bva2VScVpEaGFQdGNwa2FGdE9aQ1A4?=
 =?utf-8?B?L2tiRUNPOXQzZHRXNjNBY0pHUC9zYXVvVUlsaUlCT1l6YkZUdms5OFZzRlNy?=
 =?utf-8?B?MGoxTnBlQTRJbHBNU0Vab2hoS2NDTzlWcWNpcU01NW5GZytOVWZxUyt1VmNa?=
 =?utf-8?B?U2luMXpmOERIU0QycTNuQVNDM3hyN2ErZTJEYytIckJTNmQ4Z3BTU2hZNm8z?=
 =?utf-8?B?VzNNM3RvOW5nUENuUWEybmFVVXpXRkM0c1lPb3liTkk2YW9CSFIzQ1UyMk5M?=
 =?utf-8?B?aFdNcGkza2VXSlZlaHFOYm53SzduWjh2ZS8wazRuUTlXQ2xFTWQvTUpTa2xJ?=
 =?utf-8?B?Y0VpVkhWdEg0ZEZPMFlMb29Cd043UUJLVXFBZ1RpeUJNdFllVmhRRTE0RGVi?=
 =?utf-8?B?VGEyVW5HZ0FJR1ZVWjNIMDRzTFMwVVpDdTBGV0tacTUyNjhZTC9tTk10UXp6?=
 =?utf-8?B?Z0lSSENlOFdVWnlld3Y4NnEzU0d2RVJHU3BZczhoWWNIcmdCQ2s4OUZHNEY2?=
 =?utf-8?B?a1I1S09jQ3lKN084RHQ5akNJY0o5cnFaRkFpdlpEWFMvY2JQVzl2UEtlVGJC?=
 =?utf-8?B?SWkyUGhTRnYrbW45cVl2MTAyYkxLNXB4SUpOMUxxa21sYmlJOXhvU3VveUFl?=
 =?utf-8?B?VUQwTHdUTERtQ1NlSHdwR3RXY09NWVdkUEFpa2FpODBkZm54TEVwQmpPSzM5?=
 =?utf-8?B?RElQeXpaWTc2SGVzOGkvMkdicys2TXJDMUlqZ2FmU0xma3ZicTIvOUFzRHlN?=
 =?utf-8?B?VUlNNlROZXhpNzhubXFZbGNzWkl1cGpmNWJwUGUxcjJlcEZKQ0RSSENQRVls?=
 =?utf-8?B?SkFwU3REWGdHY0FLRDltUVdUenhVemFhMjBLQmJuSHQrY2pVMU5lOExoVFpw?=
 =?utf-8?B?MGZuMzM5enFIS3B0aFlUSTR4cnRCUklKaFp4N0dWMXlwTDZCNXk2NTNJY3g5?=
 =?utf-8?B?b3NtN0RyK25udHQ4K1BaY05IMm5QcGFMMXhoZ0J6dVVCaVJyc29RcEJGeCs4?=
 =?utf-8?B?RjdTK2ZzWms0QlR4NXZLeGoxZEZjcUtKZkd2ZnZFd0ZqenY4OHZ2ZmN4Q05h?=
 =?utf-8?B?clN2cVUyWk81bjErWDNZclduZW9TOWhBWVRaaEZGMVAwUGxxRUFSaTdyWWRq?=
 =?utf-8?B?TVBKcnBFTFhjUjhGM04yeGVNcnVtR1A2YUtCM2VPMWdNVDVXcU5HejdxYWZD?=
 =?utf-8?B?M3pqUzhwTCtwc3lIVkZHSzNidjJNRkxzaTBGYTljUFcwOGVCSUI5TzdhRzNX?=
 =?utf-8?B?OWFzUFV0YnJXVHhzeVhaK2xuOU54SlprOTZldXdwd1o0L0ZPekxXWkhzZGtU?=
 =?utf-8?B?ajErRHpIKzB2SjNyblJWbW5kRUJWNi96T3QzYysvUXFFYkpzNnpETlVjTTZR?=
 =?utf-8?B?OW56ZWFBTW02SmRRbnhOVHJxenZVRXBnR1ZMKzB6TlZ3VllSMVRQRUxUdDhw?=
 =?utf-8?B?RjUxVk1PZk5PdGpBR1hNZndkUXI5ZGRROW45Q3FHUW9KQXc2Z0tBMUhuZTRS?=
 =?utf-8?Q?Vi6J0ulK7kNY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5rQ3lCbTV6UHBGT1I3UWhtMXFYOTFPNnEyd2hrd0ZXdUJRYUNxb21oYkFu?=
 =?utf-8?B?UlBBdjF3MG9yWGg3bG9NNnIzcHZjYWV5dFhzYnUzN0FwNjdMeWFOdU5qMHBY?=
 =?utf-8?B?Qk1DQis3bWs1UlkrQ3ZkNm53Vmw3UjJNL0I0T0RhOHBLb3YvQ0JTM09DdjNj?=
 =?utf-8?B?VkFMZ3dlWDN4WWpFRTNtVTYrT3EySndCdjJPdE0wRFNkUytISTdBKzJHVHBu?=
 =?utf-8?B?cU5LTnpqQVZoYi9QY2lxZVp3cjJQcXI0QUxXdHBRanB1VXE1M0RFR1NwUFV5?=
 =?utf-8?B?bHgrd0V0WjBYVVBsSWxIdk1JaW5tR0xBTVVxbjdld2RxbnRZdldaV1M1ek9u?=
 =?utf-8?B?VTlKWGF2U1J3RmZwc25VYnJMbHAvMlR4bDZtWTJtOTAyTVZRQ3dEWEd4c2k2?=
 =?utf-8?B?ME5vQXQwKzJoUVFSSnJsblhYbURpYjJtL2dZY2k0L2xuVGIzb0ZTNFpMbXVh?=
 =?utf-8?B?NE1GLzhKSkVnNitvV2F0dU85T2l3YloxYW1kL3hKK1BTa2o0U3Y2TlpxSDNE?=
 =?utf-8?B?MUFyKzlqcEEyLzF4L2NMaDJSK05rWlhIRkxvYWxJb0ZzYjluQzhaVXB5ZVYw?=
 =?utf-8?B?ajRNOTZBM2lMNU83MXBvQ1AwdzJGVFk1cTF0ZnJSM29TdVU0d3ZrM1ljOG1a?=
 =?utf-8?B?VDZwRi8rREpqQy9wY2k5MzNUdXlxQjZqZ0tscG9neHNUYnYyQ2xNMWFHOFNk?=
 =?utf-8?B?UkhVUUsxODFsUDJYNFFkTjNWUlFDWkVWWHRmc25NZ1N3L1VhdWZZOHB4bnpI?=
 =?utf-8?B?dGVKZ0tHdFhZQjMxTk1DdEM3bTJNekNDekJOVFFYKzd6Wlo1MHh2VHhhVFNH?=
 =?utf-8?B?T2lHbkM1cXIvR3dEajd3TnVjTVVlMWsrcVdTQytORktNempFdWJ1VGhYdXdT?=
 =?utf-8?B?Z3dYWG5aakkrWTFZM2FyVmlkV3drUmxpMC9QeTVidGJ1elVNcThYWU9PcjFM?=
 =?utf-8?B?dk54ZDJIb3V5T05lWUNRSm9lVTN1WlNTdlN4ME5acDR1ejlDazZ6cWNaMjZB?=
 =?utf-8?B?UHNBNXJWeG5yeE9sdk9MREt0Z3ZFcDFaWE1DT2NicWtqZTg2ajB1YWZhbUdt?=
 =?utf-8?B?VEhqZU9VWTJHWm54eUdaMk9IRWphakJQbnptL2JCMUxvR0U3S0V3K3dOb2RR?=
 =?utf-8?B?NjVUNFd3aGRQci9DVzN4SlI4NVIxTHpxUjFBRW9LZU5hRlpuNG9CN3FLNG5r?=
 =?utf-8?B?SVBZaHpseXdPcU5NTWJkSnlCMzNLK3IyRkYvNnYrUEljQnpJQktxTVdmTmdP?=
 =?utf-8?B?VG9NTGhUYWpVbUUyaUxJa0NwNDBkbmh2U3B2bnRiblJsWXIyWEsrcXlBMkdr?=
 =?utf-8?B?UFhWdzFVK2pRb0EvWmlyMkVWM3FJRHF2NVorT2d6djE0b1F6M2tOZldBTm00?=
 =?utf-8?B?UmVEbXcxMXM1REgxVTRvRnJ4ek15M0tlL0pNVUticUgraXZKN1FMdUFKaWtj?=
 =?utf-8?B?RDNBaVN6cmZib0thRXVrdldUOFhESmZvM0pxTE9TdnRCa2pnbmllN0ZuMmEx?=
 =?utf-8?B?VXV4aFFPRXJHT2U1RWwyWVk3YXBCQzNpRmk1NnRjSG1adGhFOFI5QTdsYTVh?=
 =?utf-8?B?U1pmanEvTTNMZ1pRU3U1dFNjemNJc3EvdjEyZDhXMEI2YnV4UzhnY1R4WWZr?=
 =?utf-8?B?VXR0YlJnZ2VCN0p5UlFnRjdzaUxyeHdqYlVHLzVLMlAzeWFza2FjbEdOY3RV?=
 =?utf-8?B?c3NRdWFLWnJzNitJWUpFZ3ZsSCt4d29BZHV5WHJ0UHhMcEZ0TnRNbTZYdklw?=
 =?utf-8?B?TEhxeHcrOVJsYXpKa3NJZitDV2J6TlBvbStaN0pRSThQM0wxcEpCQ0Myenp5?=
 =?utf-8?B?S0V6eHd0Q0xDSXZNNHc5WkNtbUR4MDl6TExwVmpsNzZuQTUwRXpDeHo5aDFC?=
 =?utf-8?B?S1grMVNiaWorMEZoWjMreFVMaWg2NFVsbkxoM3c5d3p2SkswcHhrU3hpRFVO?=
 =?utf-8?B?dzNSSTdWc1RoaUhYNk9sNkpUdnRYUmwwM29SeXdkVWMxR3pqV05aRGtNL3J6?=
 =?utf-8?B?VUNielhlZERuNmhub2xuRnA3NjRIK2VHci9ZNjBUbXpxckRGbUNGL0oxN09R?=
 =?utf-8?B?VklvMnZWMDdmd2lsUWNhWWFzVmNRS2hrNEZiSFZzYnJVRTA0OHhma2dJQ2d5?=
 =?utf-8?Q?xPmCUSOMD5Fjqqcyszi0rUBvr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f50310-a7a7-4678-22fb-08dd551a3d91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:28:54.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WachUw2quuYa7nTlnNj4JFjH865XeitNIXoz3bbkTC9/ZZJhlqPGG7SciUBo63z8N5oeXdhECaEb69qCn67qcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

On 2/21/25 15:01, Pratik R. Sampat wrote:
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it. Export this
> information to KVM and withdraw SEV-SNP support if has not been
> successfully initialized.

Hmmm... rather than creating a new API, can you just issue an
SNP_PLATFORM_STATUS command and see if the SNP is not in the UNINIT state?

Thanks,
Tom

> 
> Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
> v6..v7:
> 
> * Replace FW version check with sev->snp_initialized (Sean)
> ---
>  arch/x86/kvm/svm/sev.c       | 4 +++-
>  drivers/crypto/ccp/sev-dev.c | 8 ++++++++
>  include/linux/psp-sev.h      | 3 +++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0dbb25442ec1..87b5d63a5817 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3050,7 +3050,9 @@ void __init sev_hardware_setup(void)
>  	sev_es_asid_count = min_sev_asid - 1;
>  	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
>  	sev_es_supported = true;
> -	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	sev_snp_supported = (sev_snp_enabled &&
> +			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
> +			    snp_initialized());
>  
>  out:
>  	if (boot_cpu_has(X86_FEATURE_SEV))
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 2e87ca0e292a..8d2cf8552bc2 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1352,6 +1352,14 @@ int sev_platform_init(struct sev_platform_init_args *args)
>  }
>  EXPORT_SYMBOL_GPL(sev_platform_init);
>  
> +bool snp_initialized(void)
> +{
> +	struct sev_device *sev = psp_master->sev_data;
> +
> +	return sev->snp_initialized;
> +}
> +EXPORT_SYMBOL_GPL(snp_initialized);
> +
>  static int __sev_platform_shutdown_locked(int *error)
>  {
>  	struct psp_device *psp = psp_master;
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index f3cad182d4ef..d34068c87a28 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -954,6 +954,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
>  void *psp_copy_user_blob(u64 uaddr, u32 len);
>  void *snp_alloc_firmware_page(gfp_t mask);
>  void snp_free_firmware_page(void *addr);
> +bool snp_initialized(void);
>  
>  #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
>  
> @@ -988,6 +989,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
>  
>  static inline void snp_free_firmware_page(void *addr) { }
>  
> +static inline bool snp_initialized(void) { return false; }
> +
>  #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
>  
>  #endif	/* __PSP_SEV_H__ */

