Return-Path: <linux-kselftest+bounces-32027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE262AA49AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 13:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331271BC71D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768E18BBBB;
	Wed, 30 Apr 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A5D+7siF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6698615A;
	Wed, 30 Apr 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011949; cv=fail; b=HRdQjTOyuu+vV2j11OOjBFDDTV7bMswdVZHs7I/kTTbxduxqXAW1v6E4reEGixcc2SQTYAWOymD0qugw6yf58CcJz/L968NFmuE5mXB1HetfzUoudOfLKLb0AR75MF7F4J8ZNwVF5YVUv/hnu63xCbddMopeSjLoqvxDumcMz9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011949; c=relaxed/simple;
	bh=8ffowvpKIW7rwGLUKe+JD2fzNvXCHAjmLJzElCK+RLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A3ZnrEOkd5QygfBILQL/JZRKcZ8v8c0CobQshs/YqanlNLTFFJV/aF74K36/RtIu7XOzsMtAosZIULP0e+Ijhde9BXefWGZcC3scVfZaN+rseONNCzE2hOGyqs/5IvK7TbSjpGg+yOW6JNhKMQwtyrk0MkBAPM6OUp0uRglOIBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A5D+7siF; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xbm0vhlKCcV/7+sU1pgEKNdOfULE6i9ZK6s9IiotmvU2+f8Rgda9QOKii5ZFROJ8jNM/dHIA+WldC6rU+IWHRTsaNGY8gjuilENdFSZE5uHcra8nEHELQrVzXJie4E7MPSVm/joiqMJhCmvDeM5ztHkMQiAEz0P3jWSfAWxS8AVqMGLYUs3iGSJ1grlmkffNoz1WlD4XgY2Y4cmr+LbraPBmsMQLWCETHuOkz/tZeq+tTkaBd+OnxLpOmiPsjNizbp1BifoK/11rcWYxuIxvsKlK4E4nYNNgKuZk/cymj7bNNlw+/w3tS8Q38Xqo5fuxFlDvCmp28dkzojhTwXLNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdajLPvFSLFse2P9hrWkw73yVOhAUxvbBc9RYoFNmpU=;
 b=KfNEFtfW1RTsHpBDpY2HYLRrvAFJp29R9kE3RKY680C2sMCoFEoEjNlve3HgDy3l6aPSk/aLt7GQ9Ijq7LdmJa5IDwdxvaxgLC1yvH9BSOdfFWrIjGc5fUO5IZ+9vLteUSM7OkyFMrvjugnaAwWEIc+HzmooyTgimGXmknxFHPrylD92X8+ovI270VkIAydIGNCOR0GYcKhgLSOVlW1uS3oIujcJzmbG+a6xnMQswUVn6nI58NR/AT6pZZ4KmITGSsS9myK2U9waESPMXBDCTfNbdEcyiMI3Q5OiXHDhAkfCDTSsGOMMw74JBzO57lSCAaTjSGN70pxe+Adv1kJ8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdajLPvFSLFse2P9hrWkw73yVOhAUxvbBc9RYoFNmpU=;
 b=A5D+7siFx4MywnhPt1psUU+vqTKE+DKzeBxvaHAmcvk8EmE30wpS3JaJNAYpbLioNaayuwsltmEpsiA/iujHHGUCB8HTZcYOZY45+RbVEQ82rCZvXj5c/ydM/K2/eubODoWdB/g47PD3pR4jGLbUkZdQMXA7IUGfitWh64J8jnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.40; Wed, 30 Apr 2025 11:19:05 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:19:04 +0000
Message-ID: <7adcea90-e730-46d4-9a6e-7377b1fd4557@amd.com>
Date: Wed, 30 Apr 2025 16:48:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for
 KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-5-manali.shukla@amd.com>
 <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
 <aAkHiL_N7QGND8Tj@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <aAkHiL_N7QGND8Tj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 5353c0da-039f-4f10-edf0-08dd87d8d0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG9iMGRWL1UreXpmTUNXbXoya2RRY0RpU2d3cFo3a0Fid0VjUTlxenpMK3ov?=
 =?utf-8?B?NXJuVWxRQ1F4aS9kZDEvN0FCY3pJTHNVWUZhNVhDYmUrZHdIMC94QTVVeE0y?=
 =?utf-8?B?RVYrdDBrcENrRGR5ZWNMakVZaDBxY2U4V0ZTZ2JQdWcvSVJHS1RJY3Nva2hX?=
 =?utf-8?B?bW9vcTBXTDZFOFpLTG9JMjNkbzEzU0dsSG9iUGVZejEreXdyWjJDK0duMGF2?=
 =?utf-8?B?NjkrcEFzSWZwOEFabmVkZjEyR0I4VFo3ekUwYUwrUDlyQzRsUVBBbTJ5QmYv?=
 =?utf-8?B?TU4waFY1M3RqdWgzN05aUU1ldzlkQVVIT0hKdGMzM09icjlwcHJ5dlUyUWRU?=
 =?utf-8?B?anNWU3REc2lQU1QydnV2YVMrQ2NHSEpidk5VL21Jc2ZjU0MxdlBxNUVLb2Y5?=
 =?utf-8?B?UEpzRGdPSmw3eUozcmFGRGZOTzBoT2k5UEJqWmJ1clZPbEppcVRVMVB1bldC?=
 =?utf-8?B?ZkFqcFFlWGJ5dEgwTG9obGMyTmdCNDhzS3B6SWQxaG56VW9BT2hKcUNwYzNT?=
 =?utf-8?B?RzFRSUllZ01KTnd2RUZIeklJekFYZWhXdTVWSkV2RVdMT2JQWVl3VnE1a3A1?=
 =?utf-8?B?UTJBcnpUVlVRVVhramxTQTFHQU94OFhWeVhwblB4T1lQWGdGN05wanpIY2wx?=
 =?utf-8?B?R1pFazJCY05VQWZXVkl6bDUxdTVZUDcwMCs3bEVEa2h1MWo2TktMK0o0Y0R5?=
 =?utf-8?B?ZU9udi9xRmNwRTF0VytQSkwrSDVlUm5zQks3RkhpdFFUcjRUdTh5Z0xCcmxa?=
 =?utf-8?B?VjJvWlRZZFprOS9pcnM3WmxtMU1xU3A2MDBMNzV4aFprc1poditkOG10MHd3?=
 =?utf-8?B?dEpMa3BKSmtjdURyYUs1M1dMZ2xFVEV0TXFUTVdLSis5cmdFcFZyM3VCU1hL?=
 =?utf-8?B?dktjblM0bnVqZHNaTGRHOExickpBQWdRdmo2VjdsREg3ZWVVSmd0MDlvbVJK?=
 =?utf-8?B?ekdHS1l3V3ZJWkRTY2pGWXZlRDF6cmZKT1p5NEpqTG01dGlBelNaQ3VTZzk1?=
 =?utf-8?B?OTdyZUZRVmlBR2RVUFE0Sjk5SHkvRXNtczk1cjNYS01RT0xmTzB2S1B2YUgy?=
 =?utf-8?B?WGFkL2hCbi9JQnZnYW1KYWlVVmRMczBTQUR5QUFBcnh0cmJGY2JDV1hEQWJp?=
 =?utf-8?B?dHlmUWlUN2JSbTJwS1NTV0RMTTVHblowUDd3eWJYNjlLOEc5SW0wNHBQN0Js?=
 =?utf-8?B?bStUVTd4WEZLVkZ2dVJhbkxuaG9renNqb2dlVVBGRnVmMys3bytvWndRRFAz?=
 =?utf-8?B?R1FyMXl3a3NqWVdGY3grU3NVMFdxVGRtRFFQeGlMNmdRR1FMV2V6YzlZMHc4?=
 =?utf-8?B?dmVlK3Q4NnFqMnIvZjBsRDVUeVU1K0FFemxaREd4ZmhuMmphK1IrcVNDS1Jq?=
 =?utf-8?B?YVBmRTN0bVFyamJ1MmFkR0tlNnVETnZqOWZpWWVqbEN1M0x5RVkyTE5ob1VJ?=
 =?utf-8?B?TzBYYktod0laOTBuQVlsamM1MlFtUjIvN1RYM3Z4RHo0ZmFUcmNlVW5VRTk5?=
 =?utf-8?B?V0VudUVVelpRNldQZFkyVzBPMUVCVVFYc1hWeUowdzNyaFFxbEhPVjVHa1hY?=
 =?utf-8?B?cE1mQlpyZzRjVHhlT3MxYU1FMUFJWWZrelFrSmJpWDI1N3FFZHRVSWh2Z1FP?=
 =?utf-8?B?S1l1WUNlZG1MOXZkbVl5MGpUZHNINTMwUkJaSUFQSVRib1FadmtFZGEyS1pE?=
 =?utf-8?B?cGJEOEFYSkk3NmFVMHR1QUVKOWtoSFFaNXE4Y3FDamF2RTdveVR1RTdtZkly?=
 =?utf-8?B?R3ZOTGpUbzd6N2EzYm5hZkxqUksxcCtVWkp4eEZIdnR5VFJlbTVNNktGM2xy?=
 =?utf-8?B?cHVnNFdmVlprbE53cytrRVZ6NDVaN1cxZDRqWGVnM3gvUlpDWlA1K0tGK2M4?=
 =?utf-8?B?VUFpNUJWd0tpOE90OWk3K2ZwQkdiT1RRazNWa2VidkpiRkU2OUR0QWhLSHd0?=
 =?utf-8?Q?mesfSgo6JF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JVUnpEbVNzN2R2SHJSODVOdndFdEJLRkNKRThwN2JjTk43OGpyRHZrL2F2?=
 =?utf-8?B?SjJYZTVCajlKNEZGcmltY3Zrc3BEZ3Y2QThQUUZDRFBiWENjVENQdWtDTDQ5?=
 =?utf-8?B?TkJQaVVDSEMxVkcyREloRnRLbC8zOXpCa1o2QzFOZmMwM1dVY2o4bDlDUFo2?=
 =?utf-8?B?NURHTE91dFVUMVk4Vy9wMmsvM0pyV0cxanhlMlI1MUlDYWVCVTBES1pjL3I0?=
 =?utf-8?B?YVNmVGFGL1lqODg5UDZMck54RGdkdU9XdmRVQkQzRkYyQkgzdXVSN1htY1M5?=
 =?utf-8?B?ODgveFNMazhMUlpuZzQ0b0ZXK1UxN0JGOEQ5SU9yYVU4dEVSN1Z0N2lROWdY?=
 =?utf-8?B?amlIOWowNXF3YUdHZ25Nd2RNT1JWcjFJSG8zdDBOWEhBRTVSc1JVNmorUitY?=
 =?utf-8?B?SkQ0UkRCbDFmRGlleUF2V1QxNzI4RStNRURuN0taK1BSVFlSTzZhZFU5Yjhy?=
 =?utf-8?B?NTZUQnVIeWp6WXE0UHhiSUY5a1lWTW5hZldiQWUyUEppVC9QWUlYbFo5QkJR?=
 =?utf-8?B?QnJIdXdwV1VWR2FESG1MTFp0ZnQ2d3h1MHBoQU9DbVIvNmVYSnIzWEdtanZS?=
 =?utf-8?B?dEN3WkxMTjBwRjYxSk5YUHZKcU9DSU1WQ1o1K0ozaC9zZVFqcnR6K1ZOOEFO?=
 =?utf-8?B?YUNTM1lvVkRTZU9qU0xJTEpqVFZ4S0Qvdmd6RFlHQzZBbkRjWE5paVhDQVNE?=
 =?utf-8?B?YVVWSm4rS1BIL0czMXhCS0ZQWVJXMC9KYVZWQzl1SWRGaWdXcEFZTFB1bGll?=
 =?utf-8?B?WFFYc3hjVE8vYWxETFdXay9ENlF1cUo4T3dSRVZvYndOZkRFVWF1RTlHNjZk?=
 =?utf-8?B?WU1BZkdRVXpnaXdzRjRoczR5RTV3dDkxeVl6Uzk5Rk9YeTFYK25IT1c5RnZL?=
 =?utf-8?B?TmwwOTdyVFh0VGVraTRRamR5TWVkQkdVZ21OVW5MYnYzSnpHQXdpK3JEcG1H?=
 =?utf-8?B?WDhjWm5SZlVoVFRaTFIyTVFJcElnTTBtVHhKNXVhelRWNmljWmtvdTVyWEYz?=
 =?utf-8?B?OWVTL2NDZENGMnVNSjJqOVlKcWhTNVBleHZwWE5ySnJ2bFpGcjEwY1FoZTdk?=
 =?utf-8?B?SXlpSEpMTkd3WkxRQ3krbmxBT2x1b3NnNnBOUlRJYm80N083a292QnNGbE5V?=
 =?utf-8?B?NkxvYkd4S2lRS1h5QlYvZGFBOTRMRE9UendQV0d0TFRtdnY2cmRxTTdUcGJ4?=
 =?utf-8?B?MitndkJDYlNXSFVtZ2NVNnlPS2lYcmFlQ3pGZ0I5REV2emRlTitQRm5FSEJj?=
 =?utf-8?B?TmtvWXgrbzFkcFErSkEyazh6QkkrOTNlR29RelduSWxHeHhzczJMTmREVXdT?=
 =?utf-8?B?WnpYK0oydGtYMzMrTVZXVXovRzZBSzZHM2tKRDN2VDhyTzBneDFqdTZGLzl4?=
 =?utf-8?B?L2FFR3BPV1dDV2syeEppMEpoZmppcUkyUVZhNmhpZExxRDloeURwK2NVSlIv?=
 =?utf-8?B?VENQNW1YNmxWd3UvL0RDdHNJZlVESkJBczc3ekRJNmxWUWIyUXVGQUtrVmpF?=
 =?utf-8?B?d0s1SzliMCtkMnlWeXdMVUh0b2JKQmRaWld1R0hTOWhOVkcwMUpzMmFWNXhs?=
 =?utf-8?B?V0JUREpsbDRIbzlKeGZUK2NjcjQ3aU12eGJ3cTl6eGtUZGpQM2RWK2syTzB6?=
 =?utf-8?B?Rmo1WkNhL21XMlgxSm1xcnh1TFFCU2RmalhpOWxhNEplby9xRDh3ZjViL1gy?=
 =?utf-8?B?MUNRODBtYW1SYmNHVWtLdmxVM3NGZnJCbWJDY2dGLzJockM3dlduS0hLWUov?=
 =?utf-8?B?bTQ5eFV1T2lCc3NiMjFaUk5KYkVKbUM5MFlOd3BhL1BtVjFjeFJyUEd3ckFs?=
 =?utf-8?B?bXFxejZRV25NVjJMaU02aG5ObWtMekxUSnNYb2pLVXVjMnYwejk0OWV3VDZw?=
 =?utf-8?B?dGxzbFF3TjVLdFdMT3UwTWZIREUwbkZGd0ROS3ZwNVJlbjBoNE1FeHlvRXpz?=
 =?utf-8?B?ZzVMOUFKUUhJbUE3MHBQenUxWlQvaXVmVlBUbGtMeGE2dEpiYnJCY3NkRXlN?=
 =?utf-8?B?elE1Tjg2LzhOWVJKTU5vMDB2VWdGSk9XUSs2ajErcmVNazJYbzROTmtWTEN5?=
 =?utf-8?B?ellmTDJWZklCWDh3WUtTeStBMCtlQ1h0RStzQm9qYVFSUlA3TFFOZUJmbDdI?=
 =?utf-8?Q?q1E/HHctMYVuumx+JaF9mJ9gq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5353c0da-039f-4f10-edf0-08dd87d8d0dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:19:04.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70eqOggnci00v8O4SjMUD0gLQeUQbh0Z/p8cr3lezXaeFLRnJ15UfC/Tt4oIZJRG3+9k1x1E8kB83peTb+qMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

Hi Sean,

Thank you for reviewing my patches.

On 4/23/2025 9:00 PM, Sean Christopherson wrote:
> On Wed, Apr 16, 2025, Xiaoyao Li wrote:
>> On 3/24/2025 9:02 PM, Manali Shukla wrote:
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index 5fe84f2427b5..f7c925aa0c4f 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -7909,6 +7909,25 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
>>>   KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
>>>   to KVM_EXIT_X86_BUS_LOCK.
>>> +Note! KVM_CAP_X86_BUS_LOCK_EXIT on AMD CPUs with the Bus Lock Threshold is close
>>> +enough  to INTEL's Bus Lock Detection VM-Exit to allow using
>>> +KVM_CAP_X86_BUS_LOCK_EXIT for AMD CPUs.
>>> +
>>> +The biggest difference between the two features is that Threshold (AMD CPUs) is
>>> +fault-like i.e. the bus lock exit to user space occurs with RIP pointing at the
>>> +offending instruction, whereas Detection (Intel CPUs) is trap-like i.e. the bus
>>> +lock exit to user space occurs with RIP pointing at the instruction right after
>>> +the guilty one.
>>>
>>
>>
>>> +The bus lock threshold on AMD CPUs provides a per-VMCB counter which is
>>> +decremented every time a bus lock occurs, and a VM-Exit is triggered if and only
>>> +if the bus lock counter is '0'.
>>> +
>>> +To provide Detection-like semantics for AMD CPUs, the bus lock counter has been
>>> +initialized to '0', i.e. exit on every bus lock, and when re-executing the
>>> +guilty instruction, the bus lock counter has been set to '1' to effectively step
>>> +past the instruction.
>>
>> From the perspective of API, I don't think the last two paragraphs matter
>> much to userspace.
>>
>> It should describe what userspace can/should do. E.g., when exit to
>> userspace due to bus lock on AMD platform, the RIP points at the instruction
>> which causes the bus lock. Userspace can advance the RIP itself before
>> re-enter the guest to make progress. If userspace doesn't change the RIP,
>> KVM internal can handle it by making the re-execution of the instruction
>> doesn't trigger bus lock VM exit to allow progress.
> 
> Agreed.  It's not just the last two paragraphs, it's the entire doc update.
> 
> The existing documentation very carefully doesn't say anything about *how* the
> feature is implemented on Intel, so I don't see any reason to mention or compare
> Bus Lock Threshold vs. Bus Lock Detection.  As Xiaoyao said, simply state what
> is different.
> 
> And I would definitely not say anything about whether or not userspace can advance
> RIP, as doing so will likely crash/corrupt the guest.  KVM sets bus_lock_counter
> to allow forward progress, KVM does NOT skip RIP.
> 
> All in all, I think the only that needs to be called out is that RIP will point
> to the next instruction on Intel, but the offending instruction on Intel.
> 
> Unless I'm missing a detail, I think it's just this:
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5fe84f2427b5..d9788f9152f1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7909,6 +7909,11 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
>  KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
>  to KVM_EXIT_X86_BUS_LOCK.
>  
> +Due to differences in the underlying hardware implementation, the vCPU's RIP at
> +the time of exit diverges between Intel and AMD.  On Intel hosts, RIP points at
> +the next instruction, i.e. the exit is trap-like.  On AMD hosts, RIP points at
> +the offending instruction, i.e. the exit is fault-like.
> +
>  Note! Detected bus locks may be coincident with other exits to userspace, i.e.
>  KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
>  userspace wants to take action on all detected bus locks.
> 

Will update in V5.

-Manali

