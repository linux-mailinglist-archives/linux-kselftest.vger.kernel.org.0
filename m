Return-Path: <linux-kselftest+bounces-31380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E33A97EF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 08:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EBD188A37F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290EE266B55;
	Wed, 23 Apr 2025 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hCnG1frR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB8DF49;
	Wed, 23 Apr 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388971; cv=fail; b=mrKTGWrQsiRcHq6qo9w3dCM9CZV3ZpmAJeKWEW63MQDtoB0uA8/JhaARvmgsOJmggVZCuDFt0cj9YSssjLn2dPZ99CfN512sxET7Y/50EYhsPZwypDP/RNVkUhmZcnXiyoFjuZLzU0doFCEgsGGIyxYih1T9icVCtwrgTDZjIoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388971; c=relaxed/simple;
	bh=BPKQxajRqeY9VW65HymYS0esBpo/JfeD+yXrpHzZFCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NldJvcl6DovaZBOLeOqdofSxS8z8sq5RnODsajwrfID/rAulZFz3z4hwlMt7G/iyetxqMaWCoQB+3FyCl/acIMUcKwNi/c2XHJkIUAQ/FtOUSAUe3w4B/rhvqVMruK5T72ZAV4fC0LfMHnht80FIhBWrcET9mby2aE8hMc76GIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hCnG1frR; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrUvM5JRBQNU51vU1KcHyVmJuucdA7rgFo7xnB78ZIuuYIHkHYdGAeBmh7KGuSB7gBqGQE9+w3zDnIw55pSJKnEaXZ+hJKy+O6Dmr+CT39ROeQYNOzGK7UTBFlq8Lu1xshgO9d+it/RFCsjP6pMCT/XiQzxiI+8x0+T5F/ZtRreFoQT2MGeYKGMkHSi2JTE4JkeU510WCTxyNKF5UcTynZvIKk6zg0C5eO9H3Qo0dAVDCKCAG+H63awJ3A164jq+ubiTOD11sVh2pzM/+vvGjFr0VbP7PbBPnaZ1kZtYO9jgGQG6O4RwWRQWEmt5QWidxGSM8esPIBzzslKYHVulUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AroQ1FObyxVLuaRYPq3rt2kwDWRMBj/EVbC+XW16oSk=;
 b=JT4Bc9DfFPCxZJ13c7OV4yn7a6YyDukzkFXixOr2XTbb5XzWIYKrmUX/seAmpzsqf4vL1ZBWu/6Uuy3IjdwrjDrVh1m0wATbJhkm441qcIsEu2fM+lw64CbY2RLVO2bHy0DGA8IrC920q3PsTrl5aFmf0iotyTq2RKR+MFbNpNFQBc2oFS0Qh1vb1QTtWQd1NnR+iw3dP8hkJZdt/txokg9XPfQX4w2lC+rbpbroFLebjmVfhbx4/kEwAKkfg39DDdJlTXCpKY2lqTbrSh131hNZ69EnvC8lZAPxYHlkNPXgz/O4dU0aD2Wf8yqGWxod+cVqYyyoSsl3mYhlx7/NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AroQ1FObyxVLuaRYPq3rt2kwDWRMBj/EVbC+XW16oSk=;
 b=hCnG1frRsgSaaLdnszVlxHaqcMdrYeNjppTXmY4hai8HfDG3s8Rl59RrAEx8vOhsQuoINdJHXIwaIDzhNGAsJAZ4KMVaez7YMSuQXiNXpidbcs1q1c/nZ+Cj9Ac38xrrll0zuyrJ83LmtnRZlB+wJDEna/i6m/u1hSz+TFUGoTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:16:06 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 06:16:05 +0000
Message-ID: <52276154-79b0-4029-8087-77ca499a12ce@amd.com>
Date: Wed, 23 Apr 2025 11:45:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] KVM: SVM: Enable Bus lock threshold exit
To: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, nikunj@amd.com,
 thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-4-manali.shukla@amd.com>
 <b03f3593-e56b-4a98-8ddd-e54fe7885c81@intel.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <b03f3593-e56b-4a98-8ddd-e54fe7885c81@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::16) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: c58495a6-2c8e-4afe-a899-08dd822e5470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2E1QWoxemFVTGpSMjlpa290WUFCWEl5QnN5NUdOeDFsWis3WnhWYnhhT0Mr?=
 =?utf-8?B?K29qSVJzSExkYXdFZm1RZU9yOCtKS2IwR0VQRncvS0ZPRTZJRHhCckJYbGo3?=
 =?utf-8?B?eWN4bHdqaUpSbjhrWTJNclBGOTZhUTJQT3d5ME9VbHZGSVQvT2dDWjc0RC84?=
 =?utf-8?B?VUZEVHpmUjRyVWlhMEpsdXUwWkxJWm1nUWtZQzl5bmhpempxMWhyV0lFTElm?=
 =?utf-8?B?QThlTFFlMEZhVGpySWpYeWovR3ZBNitmWk5XTlpQb2ptbkRFM2JGZEY5NEMr?=
 =?utf-8?B?czhIU0xBcHV6OUcrbVRJcXEyZWxSWUNiR3FyNHIrS2grOGlpQ2twWW9ZSFND?=
 =?utf-8?B?V3Y4eDNjR2lzU25oN0loaUJCU1M2KzM0bUNsTmg4WVZROTl5ZnlZRmMwWlU1?=
 =?utf-8?B?NXZPd1JGcHNwcndMRVR5NmV4WnN3K2NjNURuR0FLVnlCY0RJVXAyNFA5cUZT?=
 =?utf-8?B?SWViVXh2YzdDWnNKOU9ZOWlHcmttYlV0RWtVTGxGOERhdVJmNk9PemwyME9R?=
 =?utf-8?B?elY3RlNIZGlIeGhYOHFtTmtwSVZ5NHFZWW1WUUE5cFFRN3g3SW9rWDlXcnpC?=
 =?utf-8?B?bC9RWXp0SVR2YmNmUlZjUlRrVUJZOVYvRU05ZWVWbVpDWWhSdzBGMkNuYk1t?=
 =?utf-8?B?QUZ0RWVZQzlFdmxxUEp0TGNPRVVHeisvZTk0NlJ4MWhVcWd4WW9SVU9CVGZ1?=
 =?utf-8?B?ZForN2xZaVBOaFRvL0RFTUtWMGRvZURweHlGQWpKaC9QdVdqaUhjdVRvSjc2?=
 =?utf-8?B?NElpSXZlako0bXg5a0hPY2l6L3BRWkZDTFI2R0tURnpnM0gwY0VaWDlsMUQ3?=
 =?utf-8?B?TGp6K1hLOHE2Mm84SDFlZWtmUm9xYmZ4ZFBVQUZmMWlPSHYzL2lJL24vVnQy?=
 =?utf-8?B?ekE2RTFrNHdxRmgzbmxwTmF3WmFISEVFQ09nYTQ0b01JRm9SWEhQRDQrWW5Q?=
 =?utf-8?B?RnFGdUxHZUxjVFVuN3N2UlJHaFJKc0lIbHlsUEd6dkY4NVUzSFNKc0w1SUZj?=
 =?utf-8?B?eVlpR1QzZ3dtZmFBbndGdnhvMStBSWNWMVRNTUxQc2pkUy9IOU9WcnhnOHpv?=
 =?utf-8?B?eS9Qd0tyOFp4ZXlJSEtPOUJRSVpGOFpITjVNWmFFZVRXcjA1ZWdqc1VwWTls?=
 =?utf-8?B?bDA0bHBXNDdLSTlQcVFNMmJQcnBaT2V4V2k2WVRNMmd4SkxwMVFwd1hvK1NS?=
 =?utf-8?B?dEQraFNwZ0l2bndzUG92ZmUwS0t2Qi9zeXl2dHpQdHgxT054QTU2c3kwY1NQ?=
 =?utf-8?B?TDBtRmZJbmMrVEMyZXdiVGtBUHJmZ3VJNGIyRUVzOThlK2k4UnVwY0IwRUNa?=
 =?utf-8?B?d3A4bHR4aDhPNmFESWJHZUZEd3JaQU5zQlFrVU9LS2lJTzd1V0JmMHo5aktN?=
 =?utf-8?B?MzkvM0Z0QjZVbUJFSXlicXp5R1UyajRCaDdLMnNwNXQ0MXArMWpCMlRFbHlr?=
 =?utf-8?B?eUxsL3U5aW5ROFVobzJ2NnVueVlLZS9sdGprK244YkgyNGhwZm9ibnhRZ3Q0?=
 =?utf-8?B?Yndza3B2YkRrdXRQVWxiSi8rcjlpTkpEOVk5bzhMaEpnTVEvMEZ1dzZrM21y?=
 =?utf-8?B?blV5TEc2dVlYdXA1U2VKQjVrdC9QY0tsVHdMRWR0VXMwT0szSHlLbk5NSWJC?=
 =?utf-8?B?VWhiTy9MeU9NdlJxTGdrbVJ3YWNQb2Jnb0cxVmpoL1NkRjQ0cTV3aFo3U055?=
 =?utf-8?B?bzd0TnJIYjQxWVdsS3lUajlkZmFRT0NFZFBkaGJ1WVhncUxaZXBvT2VsbzlO?=
 =?utf-8?B?ZXZNYTlvVWh2UUpXbFVkNHRMaThac3JJNkJpWVB1NlI0cTJNZFhjbFM2Zk9a?=
 =?utf-8?B?bFpjUTNMS1cvK3MyenFnQ3oyYkdGMlZYS3U5Zzk3NWZVanJwK0NHeElrMTFY?=
 =?utf-8?B?ekRwOUlSUUc3cjJycXdjTnlGUlhtN3diV084bjg4cjhvZHZFVXBQSThOR1NI?=
 =?utf-8?Q?+ZdK21l6Apw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1sKzhkMlpnTSsyc0p1bi9mbEZWeFRFWkhkWVk2bUVPSW55amVkSURlQ3Rx?=
 =?utf-8?B?ZUs3a0FNUjk2THRjMTZ1bW5pOVdWcHp1OC9Sc1FQaHRiWEcyQWY3R0I5WGpX?=
 =?utf-8?B?b3NIcEljaWFwNGs5UEh3OHJCaUd1d0dtQW1XWFNvcWVwVVRkZnFrSGtlL091?=
 =?utf-8?B?YlVSdXRwT0hXWHlyWGxPbjJDdXdmUEdzdTNxL1h0eENZbVJ4SEM1T0FsRHB0?=
 =?utf-8?B?VW16bFRzRjI2NnkybzBVL3dlYWxCbVZ2MWltQnpkaU9MbmlEa2lJc09xbGdD?=
 =?utf-8?B?YjhhZVMwb3lxRWtDbEt4emFPQyt1NGFPbVlQTVQ4RG00cUI4WVkvZ2syRW9p?=
 =?utf-8?B?RWZZcmp2V2oyL1ZOeUU4WG52L2JqOEJITFd6OUdlUHhhTVFTNXp5VEZtQjRW?=
 =?utf-8?B?ejRCVWN4alJrR0NzeDBKdTJYa2I1aTRWTVdmbjNxeVJsc1Fzc2U4eWUyakVJ?=
 =?utf-8?B?YlNsYy9oVTQxb09XQWlKWHNvaTBoY0ZkbmdvcTMrZjhOcS8za1c5azlEZWZ6?=
 =?utf-8?B?SVF1aXZheURoUFh5ZzRFUjd5WDd1Z0hzaUNYbUFaZmx1em56K3FicjZCbmk2?=
 =?utf-8?B?T3pybncxWGxOQi9nbnRRMjJwSEwwbWNGa2NaV2srRlp6a2ppZzEvTXNTcjJT?=
 =?utf-8?B?MXFTcU5GSFFGVUdFTHFNNGlwRkl6ZXRtNlRPVDNJYm4yd08wZlorWmV5WHRF?=
 =?utf-8?B?TzFoWXNjT2Q5Z2FmZHliL2VlNk5aUkxMTll4V1ZmRC9lYTEwYmJ5dEE0N1pw?=
 =?utf-8?B?RFZZZjVJSkJJOUVqc3o3aGZrZ3F1a1l3akMwenNkZ0ZPOXhBbjhFSnRoMlEx?=
 =?utf-8?B?Uy9NV1BpM0JmUlRDVEFybTExUFZoNEt0MmQ5ZUpydUN0MjhoUjdQNnZSRDZB?=
 =?utf-8?B?SU9EbmZENStFQlZ2NHlPcG9tMTUzdGYyTmhLODB1alNyMGQrSmlUbXExV01G?=
 =?utf-8?B?bWNzRjgwS3Q2SStMOFZ3U3AySll0YUZFMEZDRlRjMWQ4RTFFUWt5RFEycHZa?=
 =?utf-8?B?ZFNhMUJSU0pBMEVHOC9Cc3djaU9yVVBGUjJHRHNDVG1aYUNoK2NXc0wwSzdo?=
 =?utf-8?B?WEIrL3hKWGpzYTl5bC9CNzVsS0VsZmdxOUJSQ1hRYjFHTkY2VnRRdXdTRnkv?=
 =?utf-8?B?d0w5OHNWWmFWQnZlVHVSbDVMZlV0SHgzYkNEU1A4MzVZdWVFUndteEhVaGsx?=
 =?utf-8?B?T1ZlZnpZZmlTbkNmdkEyRWZUaTNIRTJ6L2ZuREJDMzJkdkczRmw2Yk0wektj?=
 =?utf-8?B?ZDR5cGI5dS9mbHA0SW1nSjQzdVJJcllIMGNtdlYweEtBaXlvZnd6bTNzamEz?=
 =?utf-8?B?bnpLNHJtTzFtd3VrMHBPL2ZHZFZ4U29DWkdqYU52NHlwYlB2ajdSZGJFQWNp?=
 =?utf-8?B?dDIweGkrcDlrMHJFeUIvZjJVQnRReFJOUVFKdmJ5K0toR3RkZlZJZzZkeGE3?=
 =?utf-8?B?M0xFczhaSEY0MXlmUm12ZDZjRVNsNTZ6SlJEWVA3Z0hSWHlFOWhCZHh3bzJ0?=
 =?utf-8?B?ZGhFWnZVRUpXWVdicUdzaDJsdU9mU3JXcWNVNTFmaVFZa0VGUS9TQXRmcTZv?=
 =?utf-8?B?U1hjbzZaU1BVclpKUk5OOVpGam5DcXBRYlY1RmxYcCtCWFdVYWNXKzFiSnVp?=
 =?utf-8?B?NWxnYnZLc3FhbzdabUxWT05ZYlZRbC9jam53S1VFSEdobnpSRHF0NjlGQmhz?=
 =?utf-8?B?V2srZFJDRHhuQkJvblNXRHl1MkJHbThBeUdobHRlbDcxNVliM2NnRCsrcHMx?=
 =?utf-8?B?SzYvOVJoYzdkRXBhZGlXN0s5SEdJNGVvU0ZxeXlCN2RqdDFRVG1udHBQKzQv?=
 =?utf-8?B?b2J6VXpmclBLT3RHcU9qTkIvaFNYb3lnODdSZVVnVVlLa2VFTW9IWXJVSUY2?=
 =?utf-8?B?a0NSVzAvUDBHVlZldVRVbGt4L3NUc0p0d25JbWs3STFDQVpFdXBLRnE5S291?=
 =?utf-8?B?b2dxMUs1YmNzeXVQOU5TZGVFcjliNzY0QUZPQkxTVXJudzhLM2h3YWFiUW1x?=
 =?utf-8?B?RlFTdVE2WG5mT2Vta243d0FySGltYS9MTDNXTjhIcnAwT21aa0t0NXdpUXlD?=
 =?utf-8?B?bXplU21BeEt5cFFBSFRxVEh5RkhDQ3RaS0Z3c2pGZUFrOUFEK2RUUUdaWDBJ?=
 =?utf-8?Q?kDwIB05nxQ7CLPBt3F6oWP13H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58495a6-2c8e-4afe-a899-08dd822e5470
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:16:05.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcQNbxvOyzDnNl3uS/ttbat4jYPxrHtvXR8P4VswELxSX4UhP9kfFMKUmZE7Bu38aLVHIDXUMU4ZPfn94eTN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

Hi Xiaoyao,

Thank you for reviewing my patches.

On 4/16/2025 11:30 AM, Xiaoyao Li wrote:
> On 3/24/2025 9:02 PM, Manali Shukla wrote:
>> From: Nikunj A Dadhania <nikunj@amd.com>
>>
>> Virtual machines can exploit bus locks to degrade the performance of
>> the system. Bus locks can be caused by Non-WB(Write back) and
>> misaligned locked RMW (Read-modify-Write) instructions and require
>> systemwide synchronization among all processors which can result into
>> significant performance penalties.
>>
>> To address this issue, the Bus Lock Threshold feature is introduced to
>> provide ability to hypervisor to restrict guests' capability of
>> initiating mulitple buslocks, thereby preventing system slowdowns.
>>
>> Support for the buslock threshold is indicated via CPUID function
>> 0x8000000A_EDX[29].
>>
>> On the processors that support the Bus Lock Threshold feature, the
>> VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
>> Bus Lock threshold count.
>>
>> VMCB intercept bit
>> VMCB Offset     Bits    Function
>> 14h             5       Intercept bus lock operations
>>
>> Bus lock threshold count
>> VMCB Offset     Bits    Function
>> 120h            15:0    Bus lock counter
>>
>> When a VMRUN instruction is executed, the bus lock threshold count is
>> loaded into an internal count register. Before the processor executes
>> a bus lock in the guest, it checks the value of this register:
>>
>>   - If the value is greater than '0', the processor successfully
>>     executes the bus lock and decrements the count.
>>
>>   - If the value is '0', the bus lock is not executed, and a #VMEXIT to
>>     the VMM is taken.
>>
>> The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
>> code A5h, SVM_EXIT_BUS_LOCK.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>   arch/x86/include/asm/svm.h      | 5 ++++-
>>   arch/x86/include/uapi/asm/svm.h | 2 ++
>>   arch/x86/kvm/svm/svm.c          | 8 ++++++++
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index 9b7fa99ae951..9dc54da1835a 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -116,6 +116,7 @@ enum {
>>       INTERCEPT_INVPCID,
>>       INTERCEPT_MCOMMIT,
>>       INTERCEPT_TLBSYNC,
>> +    INTERCEPT_BUSLOCK,
>>       INTERCEPT_IDLE_HLT = 166,
>>   };
>>   @@ -159,7 +160,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>       u64 avic_physical_id;    /* Offset 0xf8 */
>>       u8 reserved_7[8];
>>       u64 vmsa_pa;        /* Used for an SEV-ES guest */
>> -    u8 reserved_8[720];
>> +    u8 reserved_8[16];
>> +    u16 bus_lock_counter;    /* Offset 0x120 */
>> +    u8 reserved_9[702];
>>       /*
>>        * Offset 0x3e0, 32 bytes reserved
>>        * for use by hypervisor/software.
>> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
>> index ec1321248dac..9c640a521a67 100644
>> --- a/arch/x86/include/uapi/asm/svm.h
>> +++ b/arch/x86/include/uapi/asm/svm.h
>> @@ -95,6 +95,7 @@
>>   #define SVM_EXIT_CR14_WRITE_TRAP        0x09e
>>   #define SVM_EXIT_CR15_WRITE_TRAP        0x09f
>>   #define SVM_EXIT_INVPCID       0x0a2
>> +#define SVM_EXIT_BUS_LOCK            0x0a5
>>   #define SVM_EXIT_IDLE_HLT      0x0a6
>>   #define SVM_EXIT_NPF           0x400
>>   #define SVM_EXIT_AVIC_INCOMPLETE_IPI        0x401
>> @@ -225,6 +226,7 @@
>>       { SVM_EXIT_CR4_WRITE_TRAP,    "write_cr4_trap" }, \
>>       { SVM_EXIT_CR8_WRITE_TRAP,    "write_cr8_trap" }, \
>>       { SVM_EXIT_INVPCID,     "invpcid" }, \
>> +    { SVM_EXIT_BUS_LOCK,     "buslock" }, \
>>       { SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
>>       { SVM_EXIT_NPF,         "npf" }, \
>>       { SVM_EXIT_AVIC_INCOMPLETE_IPI,        "avic_incomplete_ipi" }, \
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 8abeab91d329..244e099e7262 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1375,6 +1375,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>>           svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
>>       }
>>   +    if (vcpu->kvm->arch.bus_lock_detection_enabled)
>> +        svm_set_intercept(svm, INTERCEPT_BUSLOCK);
>> +
>>       if (sev_guest(vcpu->kvm))
>>           sev_init_vmcb(svm);
>>   @@ -5299,6 +5302,11 @@ static __init void svm_set_cpu_caps(void)
>>           kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>       }
>>   +    if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
>> +        pr_info("Bus Lock Threshold supported\n");
> 
> It will be printed every time kvm-amd.ko module gets loaded.
> 
> I think it's for your development and debug purpose. Comparing to the existing features in svm_set_cpu_caps(), nothing makes it special for BUS_LOCK_THRESHOLD to require a kernel message. So I think we can just remove it.

I didn't add this for development and debug purpose. I added this pr_info() to make it easy to find whether BUS Lock threshold is supported or not from dmesg.
I can remove it if you think it is not required.
 
> 
>> +        kvm_caps.has_bus_lock_exit = true;
> 
> Besides, this patch doesn't ensure the bisectability. It allows userspace to enable KVM_BUS_LOCK_DETECTION_EXIT and set intercept of INTERCEPT_BUSLOCK but without providing the handler.
> 
> So either move next patch before it or just merge them.
> 

Oh.., my bad, I will move the next patch before this one in v5.

>> +    }
>> +
>>       /* CPUID 0x80000008 */
>>       if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>>           boot_cpu_has(X86_FEATURE_AMD_SSBD))
> 

-Manali

