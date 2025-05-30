Return-Path: <linux-kselftest+bounces-34045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47AAC8A2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 10:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091DD17CC04
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F21C9F2;
	Fri, 30 May 2025 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dmlo2vsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3921B90B;
	Fri, 30 May 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594969; cv=fail; b=XipynjscRIj/4ejBZSpj9WYORuHuWv3/UJGc2mIRf2CEWze/qYV6U60bH+GR8l4+fukvj+XanI1CxBiFdiaZvfeYr3B6ucGdhfpEigrX3Du4gRotX3MKOIJK9wtfHLs0UpmmOZD3aNv5mEtdpJERpKRChgzCM7CB16ClfmfF270=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594969; c=relaxed/simple;
	bh=5llxRuECByZJwQ/dd+tYGTgRWJwIGgk2RYukAhzNmmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OO8aFsGpmFqzkTn/ajsT6ptOrsv77oaAFxo/KPDxMY4QVy5OGA8pu2hOsOZ1zmgsimy0uEZB5Z4goR1SJGNLnS/lh6XJHdGNsz2jOpJ149boovZR0oVCqMns8zArQY/maAqSBjR/DAoTA+IQ5f7/Tzuw98v7RknXFrL3L299ze8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dmlo2vsq; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTxY4pKi0PXCG9Z80FXAElglz+qjmwVw4GeV7mY5QduQHyQ6E1lJMsy4hhBHtVOD25twEWjOgOpxKlpmCuqCOmMUVNRc1DRCAq2I/I8U1X/PjVk98yO7U7iCIgFQX4y8kg/noIFCPR0cLg7JXzbX1GFkg5sVCljbKr1xYSNhMjV8wAZSg0sCYcqiCc206Iw0j4jemM5CiXF8JgbNa+AmqIelTfpIbqmMIOYrITCMEIOfXUgO3yXybhZCg/FW1/JDSCN2Ls9hcMl6NQsmoGu/2HlW05wSu6Uhj2/vyaWMkceAvoAgugqESCeTV57jwn1KWvWYSyEVUM/JwMmHF5TaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6CORtijIU0rbtjzNzihjEFoP6F4ecd6+LLcqcA8XXE=;
 b=lPmhb46x5k7lv07lelREonM9Bh0svJUTs+02sdqSymdFTk0weOvGwn6q4KDNXCs3WgQNf+dOMdtvTyg85sTnLfIRJIJ5hOmHtaiFs+nm9sWYMKQ220bTGYiNydHtXulyd9sV16JdrMXzu2nEMk8Rae/n+Nyq3PpbYpX88x6pQ/IMlIXa3VBr47xm0Opc4HW14Eo4qq0pEEZ6VO70UmALer71SONfKtZM8Sn0SSZvzrxhpGA4KNU7wd79tY6AoKscnwK+/HctK3kqpElQTxVP9IdKMw2/a2Wf9Y1NWz1ePWTbzDMT/XM5LU3ffCLTy5zhGdJv3YvtBiEXVUu6mR+hHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6CORtijIU0rbtjzNzihjEFoP6F4ecd6+LLcqcA8XXE=;
 b=dmlo2vsqXOP+USkEaGTdcqUN7QwsjdwvbXCQ453ssXk3hySwXimAGQWkfX4PNEew5qrtkbPNil1G1o3YIRSLh03sXdvwHQXahRMePyscf84K/2geuD1LL7uG4qCqINLvVS9b1C/mH1+SrX3PLuhgGMSWuw35B8/1YLwscd0GO+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 08:49:25 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%7]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 08:49:25 +0000
Message-ID: <64902e02-0808-4e0b-94a4-c1a57441a8ee@amd.com>
Date: Fri, 30 May 2025 14:19:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] KVM: Make irqfd registration globally unique
To: Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, David Matlack <dmatlack@google.com>
References: <20250522235223.3178519-1-seanjc@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::7) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6bf19a-9db7-46db-9d5e-08dd9f56e0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW5YZGluMENXUCtWc2RYL0JCTklkUFRnWDlhMGVCaU1PQjJjVWpyMGJxKzAr?=
 =?utf-8?B?MW91VElxUzQ5dXdkYjVVWHY4TmR2OExhR1ZFU01PQ2lVTGNma2p1TmRiRGJy?=
 =?utf-8?B?ZjNUYncyZmkya3RPTmd2YXlBZWZvSmRvRGhMMFJoaXpFTDcrVEVpeitpclhw?=
 =?utf-8?B?SnZOZitvdzgzbXoyQTlWUjZReldiWXNDbk1FTXUyaHVlQUZWcUUxbzN1R2hn?=
 =?utf-8?B?Y092ZFREVkllZnhrTVQyMzE0Y3kvWlRNcWF0aHJudXkxNUVRZjBwRDZvVDEx?=
 =?utf-8?B?dms2bWZoU2ZOWisvK0VmL0kyZHFyNjkwV08rcGVMdHVuaTljYnZiYyszdWV1?=
 =?utf-8?B?U2FUVWZPN0k5bmRSNHhhZGdsYXkyTUlRT1VYSzJMTmUwTkZ5c05uNHNTbzls?=
 =?utf-8?B?MW5pY0RneDhSNUNaWkl4c0FGMzBjbVVMVmkvKzA4VE5RdFhKL1lUYzlvNUhN?=
 =?utf-8?B?Ulg1RFFJbHhOaWNpUEhLbDVpVmp3T25tUWFKdUlTS1AzTWhIald6VDYyMnRp?=
 =?utf-8?B?dzJQTk5jSVJ3bi9XZ2Z4cEkwYUp2Qm9UcFNuN2RrY1o5ZWczdkhiWk9MdzhZ?=
 =?utf-8?B?T1pXc0plQjFiKzNDZU9KRVp1STIvb0tzdVZLQjRVTzg0TlYzaDNaZ2dLK1Za?=
 =?utf-8?B?aVJ2THpNVml2MjZsSERyNHA0UFhyTmZmMEFYbHFpM3EvZTBRTXYvZnVkL05Y?=
 =?utf-8?B?RW50MEsxWUFDckovR0R5NEZJdXJrZXJabWpGZnRvdFg5cmR6aFBaN2pnNU1T?=
 =?utf-8?B?aHo3dmdRQklVVGhqQXZVNWNxdTZsbEppaTdvOFhDSHZ6eE9wUnpVblNMakdC?=
 =?utf-8?B?K0JwOU5wZkdnVXRsVnMwNzBIam1YTXFWZUF2NEtyckhjQ3I0K1VOQ0RwNUZW?=
 =?utf-8?B?amFXRzRHUC81QXZvZTdMeE8zeGhrMWkrbmpjR281VldkMHJzWEdYT1g5OUc2?=
 =?utf-8?B?TUxDeDdJK0UvWit4YnNBMUdPdW5ua0JvS3VsQmxaYS9MVkNsd2lqZCtuNWt4?=
 =?utf-8?B?OXltY2ZvM3ZPbVhLRFhabW5RYS9DT3NyaERIRS8xUFBWL284T1ZYeWFLWTQ4?=
 =?utf-8?B?bVhHU0lPQXhzdjB4T1ZOOVdZOGR6R2gzV0p6ZVpHZ29IU2pjMElIeDlwWmdH?=
 =?utf-8?B?QjFaUTkrdG1SNGMwK1VPaHRlcThHbCtLYXdQWmFkUmlyUGxRemVVWjdQYzM2?=
 =?utf-8?B?Q2pZY1M0VDhFb0pSb0VVTlBLTjdHVjJ4YzFrRDdEeDB6M0ljQWc0cXlYTzc0?=
 =?utf-8?B?ZThjaVE2TGtYeVEwc0pMOTVGa000R3orRm9nbzVZdkdzOEoyWUdmVmx2UTIz?=
 =?utf-8?B?TER3bSs2ODQvRnhEam5BRFNEU05ZZzEzQmdvdmQ1bzlWVlFEWTk0WTZ4SjBJ?=
 =?utf-8?B?Zk85OUt3dC9KVXVmaDl1Y0g5TnRaQXdST1IveW96TU9iMU5uM2tMQ1RPMzJE?=
 =?utf-8?B?STBXS2pJT3JueGNzSENOdjcxOUtqcXVPYjR1aDN1Z1A1bDEzeGdWK3k0cGtY?=
 =?utf-8?B?KzVvU0t6KzZYdzMxSSs0eVZGRWpKTTYrTDlKWUNmZzJMd3Q0eW0zNmh0NGUx?=
 =?utf-8?B?cERERnJtYzlYaUVIcWUxRW4vbDNQZjd6SVJ2RkY3WWZnQUdkTmRXeUhPNHJH?=
 =?utf-8?B?bTRxeWdreHlCWjlWcksrSjRObWJVN1hQM0lYN2dCSnJtVXNGZ3NZVXJITVdq?=
 =?utf-8?B?czJRNG5qcmp5a3k1bnNRVU5XRkkzdUVEVXZtWTVNajhQOXF0a2RtQW9PTVJw?=
 =?utf-8?B?eUFzeXVjN2QwVzRNWTF3clZVK0pZZTZmWjk3amJDTGlVU3BmVTZMeVdmbEZz?=
 =?utf-8?B?RnhOdGlTZm1NMThsTjFUS1kyTFprcVF0Slp4K3BXNDFNOHJQUk1yS2FCa0oy?=
 =?utf-8?B?OGN5Rzl0Qkw0YjFlL3AraTMxK1ZjY1BnTzZZajJIQjFQWk1ha3hiNitHeXJF?=
 =?utf-8?B?a1BVTStodlQ2Y1p0N0lWakcwcjRsR3R5SjNEZ21ZTFB0WnFnQkhjQUJVYXc5?=
 =?utf-8?B?NjNGeDRtcVNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSsrQ3ZVWlB3cTVTR3R5ZXpmK21tVmJ4U0lBNTdQYTlRaUR5di9GSm5ySmJO?=
 =?utf-8?B?WkhaZnZnUS82TTRuRTcrN1lTcGxiUjk1VzBIc2JzaFBUM1lTSThxcU02NmN3?=
 =?utf-8?B?endkSDQwNXBUMzBaMjE4ZXc3YnZlMWN6Ym5UMlcwOVlHUE0vK2lSQW0zUlR4?=
 =?utf-8?B?RDA3Vnk1RzErMHNkck1va3l4NVRHSmdMMmNpUFVpRFk2bis5R0RrSWc5VEEw?=
 =?utf-8?B?bWJXTGpmQVdCUkhBL1BvZ3BnU0pMaFpDTSs1N0lOOVM4OW1PQzV6NWRaUXBY?=
 =?utf-8?B?RnZaSzZKaXpsa1Z0ZGVwa3ZteW9QeTN1bmEweVRseXpVZzZTV0hlVkNvbDZM?=
 =?utf-8?B?MHA1ZWt0ellhUzBNTlFHRStmMHkwS2s5dmNlZFgyVG5TaUkxYzZtOG4xOHR0?=
 =?utf-8?B?UXBBcHhsSXRLT1NQUkFFWElkVWRzZUNHS1h4WExrbk1KTi9yTVBFUUNWdnk4?=
 =?utf-8?B?UEJDZG1TVWxsTFIxSFJiUTBlUFEwckZLcm9sMEZhNGdEdG9TdTlJbFMyQVRI?=
 =?utf-8?B?T2hYMmNMSk9kalVUaTN1RDNZcm55TGNRNTFQb3BsWUNnMDZqbUhyNERqSHJ3?=
 =?utf-8?B?NnY3K1RXcFY3R0lhcHRobnBWYWVvcm5lOWNQNDV4R285cFlRN1RrNzRRWm96?=
 =?utf-8?B?dnJlelBGeExBdUJqcXBmNStodzkzMHArdjJ0ZHRhN2xMMjk5OTNqVVZYZC9V?=
 =?utf-8?B?a3BzNXFvZUE4YnRmTzhvb3BHb01SVGZ1bjVoRUVXRmtudHhiK0NodkI1c1hh?=
 =?utf-8?B?MXY4empWbEVKelBmR3lXMkFxZ09HSXlxc29DK3QxWFNWbzczOENJbW1nN2JR?=
 =?utf-8?B?ODA4RVkxUE5QNm9KeFpQSTFtVXk0VXpiUk42RmpEejN2U1FYbXlVdkhXZWFK?=
 =?utf-8?B?NGN4S1BTc2hWb1RodmtjT1J2TDlHMDI3M3doOTdaNkVURkg3bGRGckcwa1VM?=
 =?utf-8?B?bGhDT2h6RnpsNnA4OW1HcHl5bW5KSEpBbkFranEwZk1ISTkybDk4QVpQYjBT?=
 =?utf-8?B?TlUvQkowM3ZUQU8xZEVXWG1yTlVycVFKaVE3VEF4NDFiQzdGbTdnTWJlNWRS?=
 =?utf-8?B?OUoxVWdBQi9pcE80L3QxQlVORG5yMjdUdTc2TWkyWVZMUEJWYVRrbnlWQWlO?=
 =?utf-8?B?RmU4Q2FOR0dBUU5VSEs5RHZ6WTUwN1JUYlN6VXlWR2FGOEtQV3RRUXNMT09J?=
 =?utf-8?B?a0htTHZZblk0dlVISVh0OUlEWnhLNFQ3eittTzVTaEM2NDZ2N2dVUjI1SFY2?=
 =?utf-8?B?WEQxZExUcmp2SEJHVFlrQTdTUTdIcnlQQTlYU3UrNjAxTlJBRzhkdVdMV3NC?=
 =?utf-8?B?aGtEZExpc0Y5a2pBeWxTUWlkSFQ0Tlp6dWJsYW0xWE8vMHVYM3haRnlGZ3p5?=
 =?utf-8?B?V09YVlhqd3h4RUV5dFhuazQzVFMzWWVCV1FTbmZJVGNXaG9LUkwyWXRYdjRx?=
 =?utf-8?B?NkJoamRBUkJYTEhGT0d2bXM1S05xUnJPQUdESlNSa2w1aWh1SGxvOGxkT0Fx?=
 =?utf-8?B?a0prS0tsN2xrTjFOQXB3QmM0ZnE2dkdBWEVUdEM2cUZVcy96RjdWOGpUVU5U?=
 =?utf-8?B?UCtwTUZOQVBQWnZockhOZVlHMkNSTjU2Y1pNU1dZREViWGdQemNXR21ud3I5?=
 =?utf-8?B?WjR3OXZTWWh1TGNzUHRacmxhcmQ0UVczbU0zWU5FQ2cySGVnREZIMFdrd2Zs?=
 =?utf-8?B?bVY4SDNQRFBvSWxGZWp0UnA2NFBaM3VtMGt0NStsMDFadVVhemx5N2Z6eXc5?=
 =?utf-8?B?eWR5dHZrUjB2bkk3V0I1YXpMT3p4SjFVYWFGNDdWbTBjdnlvSUxkWVZ5bWhu?=
 =?utf-8?B?ZzNBYjd6WVBXbVFQT0p3anNQM0hYWExSRzAyRCtxcUt4OFBWZGRWaUZHRFE5?=
 =?utf-8?B?TVcrQi9UV0JNV0JWeS95TkxiUWFjM202R05hUzBLVS9WdzdUanpOa1JoRnhQ?=
 =?utf-8?B?UFNMVlZodXlnaGN0Qmp6YnBMUkFQUzFvL3RkcUJoc1dpczFhUSsrQyt6MG83?=
 =?utf-8?B?RExubkxnZXkyTitQVW95OElTOVo5TExRYWwyUS9oRUNqTy9VU2pOYnpKMVdn?=
 =?utf-8?B?dnNTTkhVVTRWTEFQbURNQkRERjlzTUw3OWJpcXNqTkpJTC95QVl4YlpYK3dU?=
 =?utf-8?Q?9dn6+JucxyO3C4WozczQYgfko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6bf19a-9db7-46db-9d5e-08dd9f56e0ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 08:49:24.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqI1Dn0cGj2uuzh7d8h6/mpPYxVhKsf//t3lftjpILfrQz/TVmQvn/3J/tl+VXOb9lRLfgpyfRloQjdRJ8eHNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

Hello Sean,

On 5/23/2025 5:22 AM, Sean Christopherson wrote:
> Non-KVM folks,
> 
> I am hoping to route this through the KVM tree (6.17 or later), as the non-KVM
> changes should be glorified nops.  Please holler if you object to that idea.

I've tested this series with the selftests and also ran KVM unit test
on top of the specified base and didn't see anything unexpected. Feel
free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek



