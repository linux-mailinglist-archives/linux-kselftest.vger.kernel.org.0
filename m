Return-Path: <linux-kselftest+bounces-33342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B839CABC796
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 21:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447703A3B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE0620CCE4;
	Mon, 19 May 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VmaDkONg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802D13635C;
	Mon, 19 May 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681850; cv=fail; b=ZOv3pGfd5urdu3/eAg7WyNUy8EGyl3S4bu1KvnQrwC+sfztdcU0q9WX5HpjJ8mTCgT3FlD0aeag2uR6300zpkpx0+MvwnlroK4RDlNH1mqYIa3gChXKlzvlI3Nq8c33IDpl4FfR9apOimJFQHREm7DWlFKXW7l3Qj0z9s33k2YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681850; c=relaxed/simple;
	bh=m9XGYEXloQI3prIfp2Af1XRZyuPBjLdGrzyq8ySQxmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hcXzqQ+YJmHjJZ3OvXJSAI8XETURF8obepT+yCKU3t/S1FwoSspDQDQwT+2snnead+WjEsvseWFmQ0GUxPTFy/aTR16fEEtK1oYUfSeOzs89Wds2VojORxEWaBVb8sxUzv6gaV7Ial7wq/bSkAqQ7upmbT73l+6ruNsjEGngnmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VmaDkONg; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUtjmsNfM3kBdSIBlaiW93fNNu9rFeMlk6Pyvm7+q0c4BXbXK6iUlh8gQeWzG9KbDelOJZrO3wX7LgmJ164PcQ9DUpOlngqwqOIbrgPJo9EfWv6FW+ocOlidkgTj7Q7awbBgh22seFS564NthYwd/xQv+0/C/qWVEdzRHwWakfVYbDk2maHopfjpAYkceOsySwOKXOG02w/NZLIj2YkboU5QxPcS1bLMgM60QJyGWSi/kpM0ajXfazwEKY5jasJh4J+MGQBfS3wUJbkRIO6IV21SMmNwjXNc8CdF6J95U3CDJheWg7FuIVXUIQ3kZMlR2M3dSwo6t3L0/5V+8Vab9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFVXiM37Vrh7GcnxFuvxl0YrL2QhcUw9G7SwvS69u0g=;
 b=uJ0NcCj1Hxc3Ez9Z8M3pmqgbx0Zyqao526q+BewkK9Ae6NKBPT8xtNlKpbj/qbhpzAYPwWKB5h9RIzTlXrnByX0t7zFVqGArfvliV3hyocZd5H7COPhTTGrETCKSY6rtNejfiEYBIYMz7UC9y6R0mVbzKHPKAoMUW6YHXpOFFdp5s2X1VSTBO6KFZ19STMZeqeXgQSG43d8qO7RT6cgf4j+5qBnDaiOQONQy2eYmyce7BK+pTA8uejlmCDSD5DTVSQ7WQCSuct9q2BSrlBENZBRpJco64in+JwfY3Y6OTd/lodoydln72PEZtXBdHxRCKa8QOdjZKbsDLalHqTmqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFVXiM37Vrh7GcnxFuvxl0YrL2QhcUw9G7SwvS69u0g=;
 b=VmaDkONgwsP145+fq81o0/J9Qeig2H3wN+K1BJIBdKyMJl6W1/ptJf0z9ByMQZDRrBWsplCFET57lu6p+f6qAmKb6nxXDXmNP+klg72vqIicrC3sfuy/tfPLvPMF1k4k6MsuaByxqMTtv7X4idfZK5Pf8ul544sJKW9BHrVdkmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 19:10:43 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8746.029; Mon, 19 May 2025
 19:10:43 +0000
Message-ID: <96529b17-5a1d-498c-9bc3-229c8ed484b8@amd.com>
Date: Mon, 19 May 2025 14:10:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: SEV: Disable SEV-SNP support on initialization
 failure
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, thomas.lendacky@amd.com, shuah@kernel.org,
 prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, michael.roth@amd.com,
 sraithal@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250512221634.12045-1-Ashish.Kalra@amd.com>
 <25fbb9a5-496a-4c70-bd54-2a285391fca5@amd.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <25fbb9a5-496a-4c70-bd54-2a285391fca5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::17) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 081d4d27-c1ef-4a58-80f8-08dd9708d9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elRlMzQyVjZnVnFoQXZZYnNMUFh0WFVieWZxdk5WMy9rak1IM0RmMjc3ZEtH?=
 =?utf-8?B?RXNGb0xodWdWWk5zRUZsMEc3c1VYbko5VjRUYy96VlZDRks3bm1lNk5PNVVV?=
 =?utf-8?B?bXUvaXR3QVlWKzBGbXFMb096blRtZEZlU0p2Vzd1TmcvVXg5Nm5lZlNLbDNs?=
 =?utf-8?B?SXlGVkFnMGFabVN4SXd6T3VLcjdIQVVKUlJ4cC8zRlIzSGp5Wi8ranEyaUdZ?=
 =?utf-8?B?eUxYb0l6Njh6dHFzWGZvbStBWXY0UW9VTTlKVWhtN0tjR24xOGsyQmJISUg3?=
 =?utf-8?B?TzdGdW5jQ0NiakJWU0FEUklpSmFHaUN0bDZLMFRHaks1REJQNlh2WjRCdlhi?=
 =?utf-8?B?aytQd29sQTRLaFZ1by9xc00wclNoMmErT295Q2FKNldaL0JMSlBMRjVFRkF1?=
 =?utf-8?B?dDJOcTlMR3pXNDB4Z0ZlMVcvaHZ5YTN0SjJWakZqOVI4Zk9HTExSQTRtSC9E?=
 =?utf-8?B?dmV2S0xlMzNOcms2K1FVWUo3cys0S29YaEJDaGZjSG9ZMHBQbzhlWWtZV1dW?=
 =?utf-8?B?VVp5bXcvalBHaVd0TlpiaWJ3TVpGWTZyVEYySWgraU1XODFzWHZEREdEa3M1?=
 =?utf-8?B?ZThIc2o4RVNTMEpmVkpmUnFyMlFrbG9rWlhtbXRFYWNxSnFFenBJS2c2U1pS?=
 =?utf-8?B?RUlxQkJQTkt4OUlGNVpycmNwY1FWc2czMXdmdEJ2cGsxSk4zdlZxdkNrdXFj?=
 =?utf-8?B?MzMrbnd3RDRrVjYzZkoweGdWZHNpK3YzQmhzL0JIY1RNaG5SWUw2b2x3UHEz?=
 =?utf-8?B?bjdLZTFnbWVmaGtWQU0yTzBZeUNiTE1jTHErY29wcy82UUZqM0p0RU93U005?=
 =?utf-8?B?ZEh5V2gxUGdNMVRMNHdZS3N4QWZsenFPdEdDOGtCazV6bWZtZytVVm93UjVO?=
 =?utf-8?B?OEExV2JEbUJ4dzZCUFp0ekdpU0pvNlEvKzVnbVMxdEt1ZHdabW40Tm1Ia3Nh?=
 =?utf-8?B?RHZKMDA2OUV0Vlo4UnlkbWhjcnFVb2VVKy8raWVKVzQxL2FoTDdQcmdtam1q?=
 =?utf-8?B?OWk1YWNSRzFXZzVBRmJsTXBFTWVXaXBYdlRQTXk3RFB1SmYzYlFsb2wvS25z?=
 =?utf-8?B?dUp6b1gzKzA1a052RDhYL0FiVTcrelZCR2lLR3h1dWJZRUxweWJXSkhJb2J0?=
 =?utf-8?B?eTcyZGZzMms0dXgwOGdFTTRFVndSTGJPZTQzc0QyTzNUNTNJWlBLa2hhd05a?=
 =?utf-8?B?Si9jL2VRTS93NndiVGpXaUxMNTltSzBINHo1Y2RjOHFUMlNnR0hDUGtTN3A3?=
 =?utf-8?B?OFFUOFo2MityUS9LRVZTQjlSVlExTDJXZzNGWmlydVpWc1AyZWk3MVAwQWpI?=
 =?utf-8?B?Z1gyNmtjajc5NDFpcVgwVU8wRW5xbGdTV3FKZWxJU1NuckNSdVVWcnJDUGNt?=
 =?utf-8?B?YVR6UVVnU0J4VzY5TVdrVG5BQjNsN3UwYTNFRWdaQzJLNnpSV2JvZ2I2Tndm?=
 =?utf-8?B?MkI1S2NrQ2xQdWJySWx3cC9tOCtsdHZUcXJrZmhwNnppVUxTSkY0VEwvU2h2?=
 =?utf-8?B?VTJ5VjVaZlJOcHVac0hCSHd6MlF1UmVPYXJvRjZwcHNZYVN4NVlHcEo1clNM?=
 =?utf-8?B?UHhQNENCMkdkVkgzWVFWcm1TWTVkZHYvSzBrRU1RdDM4WEREUW4vQWxYMSsy?=
 =?utf-8?B?TFF6NVNGUE56Ylh6eE90aUNPM3JwczM3aEoyZFN0MlVPb1hMS0tmZjR3T1RX?=
 =?utf-8?B?UW9PY3VpYjltN0ZjNS9EVml1QTNVUHkxYWY4UEkzVVVPdlpLUzdMcWl1c3Jo?=
 =?utf-8?B?M2hKeEtuMWtTcUFLVExqaVBFMWxyMy9TTkJWM2VKRFAzWXFQZWVSOUU5OVdo?=
 =?utf-8?B?WHQ1SUpEN1I5SU9lcVNrOFRWTTVWMS82ajVTaDFXTlA0YnlXQXJnNHcwVGpX?=
 =?utf-8?B?S2lCczIzdkVVbTIvMHJERkZLTVBXL3NsU0lZUVFnYmt5cVlQclFBN3d4ZFBB?=
 =?utf-8?B?UVlHMStWTXY0WVdCVXRCLy8rVzFWbmlFZndxQnRYbDdEYlhMZ21rYzQvK2cz?=
 =?utf-8?B?c0ZDcDhHZU5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGE4S2ZiZThMcXhGdjVyblNGdS9ibENZam1ib2QyUlRqYVh0QzBmajhML1ls?=
 =?utf-8?B?MzRrbVJEM2llQm04L212cEtvbFBJM21JaXZZNHNnSmYrQ3YvMHZXa0xlRWFa?=
 =?utf-8?B?ZEg5a1oza3Arc2VubE8rRElUSnE4Z2JBc29NeTZOY1RVL3BhL2Zya001TjZ1?=
 =?utf-8?B?MEd5S2xNb0FyQUczSnNHa0pwS3dQc1doL2xCcGQ1NXBvRFkyOVZlWGdSVkY4?=
 =?utf-8?B?U3I1c3Y1ZFR5enQyMlJXTGN0SU8rdEZaQVM0MjQyeG5xZVU3cjJrQ2xsd3dC?=
 =?utf-8?B?NklIOVdqQVlhSmVtbzFVOGZNV1hVbDJnL3FoQmIxK2tYQ240bmloVm5ST08v?=
 =?utf-8?B?OUlIR1FFN3RyU0hmeEVBdk1NeUMremc4VGRlUFAzQk1KUTFteEdOcloxbWM5?=
 =?utf-8?B?ZWdCdmNVYXpSdDBIRUlvTHJNUC9uSnpncERRaSsrTm94Q1diUHlIemxzVzVj?=
 =?utf-8?B?QVc2c3BPUm0zazdDRTZCOVhrU1FTUXE4ZHhGbmxubCtmV2Nvc2tCWEVOV3ZU?=
 =?utf-8?B?ZnBDaDJNSUFCSmE1NVBNOEh5emlQNnFFWHF1S1lsYUhaM0pIQTBCa0RiWHhT?=
 =?utf-8?B?Rk9CUUUraUt3Ukg2Zjd3QnNlYlFPMGlLU0FKYTMwVnFNQ0UzUmlVcFAwMkx1?=
 =?utf-8?B?VHhLbVpxYlJHdWUrZzRTWDZaVmhTb1d1Tm9IQkNVUnBOdyttM3BpczlsTkl2?=
 =?utf-8?B?VU43dGJENDRDa3dWd2c4WFlwWHZWbzhhckNaQnd2QldmRGlMTStJSll5VENu?=
 =?utf-8?B?MG9tdEdWSk81V09SdFZTNjZmMXptdG9KMDJUN0pCMUhvZU5VNCt6TEpqT2lQ?=
 =?utf-8?B?RWxhazY4VS91NWk2aUl1cVNUd2xvanhjZmYzbTVQdkU2UjBsYitQTnIrZTNW?=
 =?utf-8?B?K0FUYS9jZEUrUDM5THhra1Z4T2xZdEJhK1podGlwaTgweHE5cm9BekQ2cGZl?=
 =?utf-8?B?SjZta0FHY05QMCtRVUV1OC9sRjFkaEF4WmZkTFRDRjY0UmYzcXBtYm1rOWpO?=
 =?utf-8?B?TTRuV25VMXVPUlBJYXRoUkp1QzJEdHNIdjB2ZEt4KytxKzN0K0k3ZklYZDEz?=
 =?utf-8?B?K1lmNnIzY054LzN4dlBEa2oyK0RsbGJsMVRySU1SS3Ewd3d0RlI2S2F6L2ll?=
 =?utf-8?B?NGVwTFgxVDMzaGQybmNSMjZ5MjZmWXR1a0JodkgzSTVJV2RubHFwWFBYc2Ix?=
 =?utf-8?B?WExSTHh6YWpNQThObjZHY3UvMFdKengrZ05UOXpqVkV6RUhjdlIrMFpFYlYy?=
 =?utf-8?B?cGp6U3hYdXR6WEhndWFkcTk1VjJIS3hqUENGejlidUdXQThYLzBkSVcyQ2RJ?=
 =?utf-8?B?ZzNDalVNWGF2Y21ZeG1LYzFqNnFHT0VqcFJCM0pJa3MwK1JMWGRTaGVacDNl?=
 =?utf-8?B?MzZSeURYSFNuUUNmNVhVdTk4T1JBMU9ucmVIeTRUNVZqMXA4SDNmUTdqbEs4?=
 =?utf-8?B?YWFvekRNaUtZVGNjbjQvSm5PY3BRTVdWNSsvVlI0dGxURGo1aUViNGdXTFdt?=
 =?utf-8?B?MHUweTU3Vm5DQVpEbDZVOVEvbDBKRldZeDBjZGliUkt0V1UxSEpxN3ZHMHFI?=
 =?utf-8?B?TDhzaDdPV1paTyttb2F0OExnVmd0ZGIxVDhUQzVla3pBSnpLNFZhc0Y1aXk1?=
 =?utf-8?B?SGplUXhzeE93a1VhandVZHFaOXpUSTlNdXNBczhwY05zSktBWWs0czRhYVow?=
 =?utf-8?B?QkkwWkVObkIyMThnbjJLd2lYaVF5Wk9ZUmQya0RvUldHQnBUeVRvRURXQ2NK?=
 =?utf-8?B?QUR0eURhNW12aGZIZ1lMamNiQ3U0TkUyK292MlJsaDZDeEtaR1VpYTI4bEo1?=
 =?utf-8?B?NGVwc1BHUTlwQWtOekVucDUxRlFIU2FJQzBvYW12Q2V3aFFPMXp3K2FKMzdS?=
 =?utf-8?B?bGM0VEd2T1lKaWJlcUpKaHhiK3pMWHdlMEhWUCt6OG9CY292OGtIUjNVWmJC?=
 =?utf-8?B?NklrZjZzRDVlb1U4SDRZeTV6amJybldnZm1VU0F6TTFPaUNzcEpIZGhQQ2pL?=
 =?utf-8?B?SEtZNkNlWDQ5QkxzVW8rU1FMKzIyYW42VTlvWk1FSGxWaVFRMXhHZEVITmdY?=
 =?utf-8?B?NkMyaFB3OUhlYlUrYkxxQ3dUaWpFVVFxRld1SFVGWWpnTVd6OW1DMEhZUFlq?=
 =?utf-8?Q?mZypJ/GI7+GOoaYQQBcuzfz78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081d4d27-c1ef-4a58-80f8-08dd9708d9f0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:10:43.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4aF+ZLdgascganezR21gVJcFlacPXdZlMNVO3BflOHh9S0yWzg1+piIwMzgK2NnWNCGWU1d71cl0363RndmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Hello Sean/Paolo,

On 5/12/2025 11:46 PM, Gupta, Pankaj wrote:
> On 5/13/2025 12:16 AM, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> During platform init, SNP initialization may fail for several reasons,
>> such as firmware command failures and incompatible versions. However,
>> the KVM capability may continue to advertise support for it.
>>
>> The platform may have SNP enabled but if SNP_INIT fails then SNP is
>> not supported by KVM.
>>
>> During KVM module initialization query the SNP platform status to obtain
>> the SNP initialization state and use it as an additional condition to
>> determine support for SEV-SNP.
>>
>> Co-developed-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> 
> LGTM
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
>

Can you please pull in this patch.

Thanks,
Ashish
 
>> ---
>>   arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index dea9480b9ff6..8c3b12e3de8c 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2935,6 +2935,33 @@ void __init sev_set_cpu_caps(void)
>>       }
>>   }
>>   +static bool is_sev_snp_initialized(void)
>> +{
>> +    struct sev_user_data_snp_status *status;
>> +    struct sev_data_snp_addr buf;
>> +    bool initialized = false;
>> +    int ret, error = 0;
>> +
>> +    status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
>> +    if (!status)
>> +        return false;
>> +
>> +    buf.address = __psp_pa(status);
>> +    ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);
>> +    if (ret) {
>> +        pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
>> +               ret, error, error);
>> +        goto out;
>> +    }
>> +
>> +    initialized = !!status->state;
>> +
>> +out:
>> +    snp_free_firmware_page(status);
>> +
>> +    return initialized;
>> +}
>> +
>>   void __init sev_hardware_setup(void)
>>   {
>>       unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
>> @@ -3039,6 +3066,14 @@ void __init sev_hardware_setup(void)
>>       sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>>     out:
>> +    if (sev_enabled) {
>> +        init_args.probe = true;
>> +        if (sev_platform_init(&init_args))
>> +            sev_supported = sev_es_supported = sev_snp_supported = false;
>> +        else if (sev_snp_supported)
>> +            sev_snp_supported = is_sev_snp_initialized();
>> +    }
>> +
>>       if (boot_cpu_has(X86_FEATURE_SEV))
>>           pr_info("SEV %s (ASIDs %u - %u)\n",
>>               sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
>> @@ -3065,15 +3100,6 @@ void __init sev_hardware_setup(void)
>>       sev_supported_vmsa_features = 0;
>>       if (sev_es_debug_swap_enabled)
>>           sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
>> -
>> -    if (!sev_enabled)
>> -        return;
>> -
>> -    /*
>> -     * Do both SNP and SEV initialization at KVM module load.
>> -     */
>> -    init_args.probe = true;
>> -    sev_platform_init(&init_args);
>>   }
>>     void sev_hardware_unsetup(void)
> 


