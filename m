Return-Path: <linux-kselftest+bounces-11456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27584900E20
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 00:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E082873AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5415532A;
	Fri,  7 Jun 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qc0cE15C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D8155312;
	Fri,  7 Jun 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799725; cv=fail; b=DYw3+GPwkoHO7nfVmZCqkG8fwLyuc30yZ7kpnHnquiSFTRMGK5zqmvK4wLll7cDrGFC+Vq921E1S+lqSw4m07MzbP74UzYvhOTsqjUr/5ZtUZ9ZXpmbc02hkIdj1kVumTGfTsIvZOvEAcQeEDKyUKKHLy1+87GQX08G7D6WbVKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799725; c=relaxed/simple;
	bh=sJk+3s/awW4Oio16ASBbbaRH0/Zd6e1aBHsFzm6nu9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kuGz6hlIukpdR8MvOf8hlDqOf3Wxohi+/VmyMFcE1SqosF0YTHGva3rlDQro5k77CDZI+uHvsrPfM+GxLvQpDwsrFKOUTxcIxekJm6iKs2+mme9KFcTCTVLBDPVvtgi7Y6OofPFLCEFbxtvRUiAHU52ClJu73KigUgXMxwH0NTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qc0cE15C; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJPIDgVMpFUwMj50G0yhO6Pz06TDfY8QYymnC1Lf/huvTgeng5Delq8AN4EzHyiTkGNJ5X1BcSe6GuyuYKwPS8ldKzsKKSlzmKtFJT79h+zpp+iJMaX4kgwEKrA2VM+4I3dv93hNp++nthtb6r54fAvtg4nOiSNPZBK28notlNZAndqgS27uU2mA1oVNO+Pv6PWoGMySiwFRT/P9Ap5fEfFM5X+G3ipQ0H9Ds1Q4ocAHGEYGkBwHr4vhMCnEw+B8YJyByR7LtFv8qX7cmshK4PYCQP/D9Q1Lubh8z5I1kYLKX9hYszGxTrZalu/vgA4IjsSjQ4YhTfCtluJuFsaGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhCvMIzdNjtTLIPqiRru9fZDeHx3mtFqAAC6GoQACCQ=;
 b=mdc3dnBbV+gB95TeQ9CPSzqbDl+2hLc6szMmELACqlfWfdTCOHB+K+FFYL5WUAXDb5AxIOuBF/JbPf9MY+vUVzPX8oeun729A+hfGFIfV+3bGlFv14Il9M4B1rOBAVurEHCPvqUSHv82Au6wWqFj3iijGf/6e3tYNCc1wChqYbI9BAdrTJRI5LN+aZJXow+OwdqVrPZ3uvAfnWAEq6iXQ7P34cQVSOgzxBloO0pyCj2oMcZyaBTNvtKy9UYyZIkCrla31YldHQVvqu5xlhTmXIqOqhFcyciJBiuoWQGpp1/kJniVTIAJWv1dHbCsIkxR3F80hJJACLYk7R+LiaXY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhCvMIzdNjtTLIPqiRru9fZDeHx3mtFqAAC6GoQACCQ=;
 b=Qc0cE15CAtiCaPee8fz6ZM9klh2suCyJp43oSGnQY3kYPWLNRVcyVh6zlZXYW/iHl0oq2x9361+kJRCcxh2176JPtf4/wE3IdmFKWNB6zgZRLz6w92MdsasUkm9gAPom8HQhHcpy1CwHeJiyz3g362RcOqAMQXs7cmjnKKz8/IU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 22:35:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 22:35:20 +0000
Message-ID: <948cd6bd-68d8-ca39-4ae7-d7d9b0460e5e@amd.com>
Date: Fri, 7 Jun 2024 17:35:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
 <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
 <8553ddc2-ee0f-447d-8fe4-5a7dd84375f2@intel.com>
 <edc31538-3aa1-a35a-ea67-b13f626a84ec@amd.com>
 <2491e8da-8664-428f-87bd-40595af7af47@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <2491e8da-8664-428f-87bd-40595af7af47@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a3a134-9487-44d7-4777-08dc87421cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU00SFlyZXJtY2QvM3dEaXdoeXFSKys1em91elU3NHc5MFVMaC9NWEg4TURF?=
 =?utf-8?B?M1QwcjA3ZFF0ZXZtdXZLOGJGRWsrNmxVWHVXYWc2bEgvZ1JSb0psazZwNHRC?=
 =?utf-8?B?Z1NVVnd5Q285VmI4bEI0SGVsUEtyeURkVkxVMDZrWDd0Rkp0UytoaHg4KzNt?=
 =?utf-8?B?ejlpbDBySDBPbzNVeStjVXNhN0pmSFJLc3pBbEx2Q3VPQ2t2eFhqSy9kTUJq?=
 =?utf-8?B?UjQ0SGpoU3A5K2RoNlJBdG1DNFhXTzlHSHE5N1BNbnNPaG1zUGI4SUo2eHlt?=
 =?utf-8?B?OHlQNlpSVkEzY05vOVRzNmZrZ294dU4vd3pYd2ZlVG5sTnkxbUxoaUxIMWhP?=
 =?utf-8?B?cjM2OFdOaFYvY00rdFhEZWV2ZWNRUng4cW51ZEVZYW5JUTRkcWdXR0czNW43?=
 =?utf-8?B?emcyVTBUcUZVRWpwMkthbWQ4VXVpbVBrbjhxUTI0cDBiNytqRCszKzdmajhN?=
 =?utf-8?B?cDdTQ3QvQkhiWk1WSFRTUlBJWURVODI0ekV3djEza0pzdEd1ZG9wZjhzRW1p?=
 =?utf-8?B?VzZZMVRwL2lBeHY1TTBhSE9Jb1g5eVREalJ5WDdHSzROQjVKSitPclRiSlVl?=
 =?utf-8?B?MjNXNWpKQWt4cG5EZ3VueTF4YnNpclU4OFBqL0dJZFdTR3h4V2RpK1hyNlQ0?=
 =?utf-8?B?aHNHck9XYVBJQlhqN3JjdGk5Y1Q3RTF0U2F2ZkQ2WllQYlU2MjRmNHoxT3lj?=
 =?utf-8?B?YmNPWTZQSlVBc2xkY0dwWHV5YTVvWE9IM1pvN0NUZWFVZDZkbzM2ZjlZSUhv?=
 =?utf-8?B?VlRlNmJqYmpzc3lrbnVHcUVHWGdYeVRBTlN1cEpUNHRtNmZVaU5hc204ZWk3?=
 =?utf-8?B?R1VZTjVBRmU5WEdsQ2VoZ1p4aHhMMHZ1bHkwQWhsVThWc2kyVU82d3lBNFBy?=
 =?utf-8?B?MWZBMDRFWkgxL3RVc0QxVUZhRzhxYzB6VkJMaWU4a2dpcmVuU3RGUXh6aWpx?=
 =?utf-8?B?WlpEWkpQM3hJVDZjKzlnQUtzUjRVcTBFckI4dEVJeEFlaTlLa0lwU0E2K00v?=
 =?utf-8?B?b1NoTG5ER00rbUZOWjBQZStLQjRaV2o3enNzbmtVK1h1TENDZGVGMkZlRURj?=
 =?utf-8?B?NERuQk5VNmNEbUJabEpaQkFYbExWbzVEOFJPdk10SWFkZEVUU2dUQzdIZi9y?=
 =?utf-8?B?WUhZbkp3Mk5IR0RvUGdpaGJqMFd6MjRWYWdlc25ROFZNR2ZGTTFvK0QwY3kz?=
 =?utf-8?B?ZFl0Nm1MWFA2QmkrS0lFOUZRMzlBbHZ0dlZxczlXdGZGSXNINzhxSzVxMVN1?=
 =?utf-8?B?OUowajdJbTIrbElvYkQzd0xhV1FiWTlBL0J1UUJQQmdteE1BZW1idnp1bmo1?=
 =?utf-8?B?Zk0yODNFSnBZZDl0KzQ2cWNHMHdtU0pSS3FOdm1PVkxHK1c2enVYcFFpYm9l?=
 =?utf-8?B?dWJFOXBZZDBsd3AxRkxHaHBHc1RyaW4xdkxCSEVoNVhtQ2NWV05hV0dpU0hX?=
 =?utf-8?B?SjFJZmk2TjB6amsvekEzWUtIdFdVeVliWDRYTTNjczFJWE5aUEJlTGswRWtH?=
 =?utf-8?B?ZXlIS0xNQ2M5VTlNRE5TN2pTUk5qMy90UXZkdjJkbS9wNkhDZlY0eWhhQlNU?=
 =?utf-8?B?bGJxSU9MNittRmNXSXloM2tvMVJtcHFadDZjTTZlMTVlVUV0VG9FM0xuNDR4?=
 =?utf-8?B?WHA1U2IrY3VIK3VlblNMZ0ZMVXNhVDNBeU1rb3ZSdXpaODZhL2lhenF1V2Zn?=
 =?utf-8?B?YTJLd1R1Q2srNmt2SXMxVmF1ZlFzSFZxQkR2dTR4RDlVcEtkVDBmQVdOUnpq?=
 =?utf-8?Q?fF5xzzVxLYlXQ+fs5IR1L4myq1lhhab7U+D2YMy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk0rUE5Oc3lrMGx5QjcyMDhZV3dpR2JZenRRV0xHOWVsdkVKRDRSVmZuWlRF?=
 =?utf-8?B?Z2dTOWlTQ1c2MXBiVXJEb001Y3B6aUkvbXpYZkJwb3NZME9lYkZxSDAyWjlv?=
 =?utf-8?B?dnc1UTRvREQrWVluMjJObloxWGs4MUJyNTY4YWVYV2JBaVM2K1B0WUpiblZl?=
 =?utf-8?B?WUFmSXBIOGJMakNtRndlQzJlOEx6TzJYTHFuZ1doUHV2NXRZdWQ1S0pTbVdG?=
 =?utf-8?B?VXJrUkZvRE03SUo3czlzTi9KV3VhbU0wK3dXOUExSG5uV1BLdm1ZMC9RWFg2?=
 =?utf-8?B?dUJReEVGZk1uLzFOVlVnWlVDRFo4b1ZXTW9XYVpKSlV0N2xxeUZnUlc2R0d3?=
 =?utf-8?B?amdlVjZUb2djTFRQNmZKVlYvQ0psU2E4WTBKRlZELzRGL201REdTRjB1ZmRP?=
 =?utf-8?B?S1k3VGRGSExFVVFOaGtVNVNNSUZmZWQ4eGpUZ0h5RUk2cE0yZW5hV1htRkZ0?=
 =?utf-8?B?b3ZjT0RERUlvM0ZiTWUwbDM3dDJlb2pyQkg2TEZBUUQyb1lVUEFuZmR6azY1?=
 =?utf-8?B?RG5FWHgzU0xxTXpyYVI2OEg2c3phNUlTZFdjb2MzS0JkL3A5SVFveDRHWDlk?=
 =?utf-8?B?VGlFVUFBU2hGTFZXcVVsbDg5L0dYVzBVdlc0NFBPcEVFQ09rR05rNlljR1Nn?=
 =?utf-8?B?bitHTFNOcWdENnIrcVMreSsxb1AvZndSeG9lSHlEMHNHaEwvRHN6cHFld3M5?=
 =?utf-8?B?RGlGVXNLTU9CK0c0V1M4MHJqQzdSYWVTQVFERTc4Z21uNWUyTFlrUmROUFBp?=
 =?utf-8?B?QXRwZ1RHd2dwNGdYN2NKRjdobnlXcDJtQkhKYkU5WGwzTElhNE54aDkxUHky?=
 =?utf-8?B?a0kvRHN0RWpjUmFISDdjWW11TmpIRnh6VHZUaHNvUCtLa3RQUTQ4KzZaL3ll?=
 =?utf-8?B?Ti85SllVZU13Qkg4aEZvekFGMDdBQ2V5RGpzbmNESHFZTXFKWXNGN0NWYURa?=
 =?utf-8?B?d3FsQTFoeGxGcFRjekJGU0ZKRTdVK1ArQldrcGpKSUpUVURkcXViS2lZQUhm?=
 =?utf-8?B?SU1KMXhtTitsY3FxN2MwdzNiQnBySkc0ZEVCakhwRVdEektqVDlRVEVYWm9j?=
 =?utf-8?B?WlM3akJVcDlvemllaXdTbDZIdytZMzI4alFLL0xjTGlKVGpMSzJWRE4zTXkx?=
 =?utf-8?B?TTJjZ3BXeTRwMnN1UVFBTzF3VDN5bUZka2NFOVhQdmNLTmFVdlFkK09rTlBK?=
 =?utf-8?B?M0wxWEx0ZWVQYXg1REFWM3lFU2RjeERwcUc3SkV4YmNsY241Tml6a0NTR2Y0?=
 =?utf-8?B?djJIaHN0aHZDbGxwYk8zN2V6Z050OFRHRUZUZ0dHOG55aGdrQ3FGeWZ4akNq?=
 =?utf-8?B?WGZVOGpsQ1pjSWRoZTlnNTgwTXV3YWF1YjBjbmpadlZkSzY2Z0R3VXY0UGlq?=
 =?utf-8?B?OERaSUcvWmdiR1UydnhBK0w3RmJPZXJFRU12Q2tIRW9sNVZLdGI4akxLZS9R?=
 =?utf-8?B?amNjSVk4TXp5SitZNWFjZ2FaZnNqNjRZYzR2VkFLWkNMd0tZNWIzUnVQNnZw?=
 =?utf-8?B?dFo0ZUF3K2NXaDd0Q0JyRW1rR0IyeWQvVTJjK3ZxVmVXMmE3OXFFU2d6c3d6?=
 =?utf-8?B?Tk56NDA0TjdrMUE0UEhzNEpHS3lNMFFGajl1ZXBWRXhxSkhMYStic1BRRm1O?=
 =?utf-8?B?ZkJlUDNGWkdRNU9TeEM2VU1WQkVicEc2QnFONGRJY0ltMVN4UVNNbVdPT1Ay?=
 =?utf-8?B?YkFvRTJUT2FReWk0Yjg4MHVraXVqdDEyL00wWWF6cWxJYjczVjM2bG1yZm52?=
 =?utf-8?B?RjhwUEd3Wms0ZmtBNytyNmk2OXJXVVNWek9YSC8zWmgyZlFTaEJBc21kam1u?=
 =?utf-8?B?aXBxSm15UzBCb1ZzWjJsM2dlbjk4NXdxQ2RFekFtTGlMa2MvOVQ5L2pDbUY4?=
 =?utf-8?B?aE5DVGNOQnZnMHc1bVg0aGZRSHF2Q0NWNzZ5cmFsMm1INWJpRnU1YnJEOXR6?=
 =?utf-8?B?TlVFSFlsV2F5NmZBZVg2VkdnQ3M4a25OKzBKaitHTmJoT2FuT0N0Z3dFY2Ju?=
 =?utf-8?B?UVBGRlp6elg2N0dEMnFmaUFzbHhPcVdTTUQwbS9PUkF4Z0RRRkdaR1F5UTFD?=
 =?utf-8?B?VTh4dEFBVVprejZMMWpWalZYbUJURU5ObXFFY0VYK0d1Sm5nSzREbHBtZ3ox?=
 =?utf-8?Q?3pWyJeXwJizzp/GNobiSYHkOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a3a134-9487-44d7-4777-08dc87421cbb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 22:35:20.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve87gPYsysHZ2mvE1bif8T9WoBmw1H+nY8W8SNO2Unajd/EqSSdbSlHBOT94+GD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

Hi Reinette,

On 6/7/2024 4:47 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/7/24 11:16 AM, Moger, Babu wrote:
>> On 6/6/2024 6:58 PM, Reinette Chatre wrote:
>>> On 6/6/24 4:09 PM, Moger, Babu wrote:
> 
>>>> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct 
>>>> resctrl_test *test,
>>>>          if (ret)
>>>>                  return ret;
>>>>
>>>> -       if (!strcmp(test->resource, "L3"))
>>>> -               __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>> -       else if (!strcmp(test->resource, "L2"))
>>>> -               __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>> -       else
>>>> -               return -EINVAL;
>>>> -
>>>> -       if (sparse_masks != ((ecx >> 3) & 1)) {
>>>> -               ksft_print_msg("CPUID output doesn't match 
>>>> 'sparse_masks' file content!\n");
>>>> +       if (!(arch_supports_noncont_cat(test) && sparse_masks)) {
>>>> +               ksft_print_msg("Hardware does not support 
>>>> non-contiguous CBM!\n");
>>>
>>> Please fix the test as well as the message. It is not an error if 
>>> hardware does
>>> not support non-contiguous CBM. It is an error if the hardware and 
>>> kernel disagrees whether
>>> non-contiguous CBM is supported.
>>
>> Not sure about this comment.
>>
>> Did you mean?
>>
>>   if (!arch_supports_noncont_cat(test)) {
>>                  ksft_print_msg("Hardware does not support 
>> non-contiguous CBM!\n");
>>                  return 0;
> 
> The above changes whether support for non-contiguous CBM is treated as 
> an error but the
> test should still proceed since the test goes on to write different CBM 
> to the system
> and verifies results are as expected based on what hardware supports.
> 
>>           } else if (arch_supports_noncont_cat(test) && !sparse_masks)) {
>>                  ksft_print_msg("Hardware and kernel support for 
>> non-contiguous CBM does not match!\n");
>>                  return 1;
> 
> I can see how this will work for AMD for the scenario being checked but 
> not for
> the different Intel variants.
> 
> I think this can all be simplified with something like:
>      if (arch_supports_noncont_cat(test) != sparse_masks)) {
>          ksft_print_msg("Hardware and kernel differ on non-contiguous 
> CBM support!\n");
>          return 1;
>      }
> 
> I modified the message slightly since non-contiguous CBM does not 
> actually require kernel
> support.
> 
> What do you think?

Yes. That is fine.
Thank you
- Babu Moger

