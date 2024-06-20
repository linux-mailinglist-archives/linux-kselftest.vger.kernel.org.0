Return-Path: <linux-kselftest+bounces-12338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2531910AE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574AE28346D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0351B013D;
	Thu, 20 Jun 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6v8bw6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9A1AF697;
	Thu, 20 Jun 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899335; cv=fail; b=eeueV9X/BmsBKw2GNDHieSRDwvxX8Y6hRq3XwIsBN7LkJVQ0Inpu85zz4IQScYgUp6UvNugEgn0sjscNAg1OeWE77y+oYIanivssgOkkczNn3TmaBSvbXCe4ICKpuRpFklCCCim6hN8Uf+EGUM6T9MEmquM/u+Z/Kqf1ZvRoJ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899335; c=relaxed/simple;
	bh=3ymn12uF3g4uVPRUUaq9GldcpYujjp4qYD6yhpXYRKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E9RbZyyLOWyp/vhQXi6vhF+Wk/G1YY7G06yz7u4Pri9PUWFdiPVMboLnqA3b+SwlQlP/2hcP77fv44Lrx/nFOBzHvbqgj3MO9NPe7Sv2QZShjcdkbJmjJNoXcCFsAfBgok8x9XjhNv4FbNCfPobBUpWr+A/8Qdj9gM6ddVOpkMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6v8bw6V; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvOIUyu/xL7IkcvQ+Q27hHd3RVpz4vmpKq/1Zy08Wp4qoNTWarjtORRNEoa3Le66u2cC31iz3ax6idfumYift4+D98z7bJA072p7Mb5ZGvZuzmfF2dx2OsKhrNWndyiKbsaL1XARmigkj5U5QrqHJ4IcL/+Bf7aguHl6Wft21Uxa7D1sWZe7Wt4klJmKyst//bHLM8i0n37hxpPlK9HF+f/jaA6mdmJUvTmxXyRVgR3f+8noA3hNaSrhdSKDvYb4Pk7MX5lYuvDkh+Mwd2EBw30P2FRJuLdwR2F3FTa60GidJxQTuvmQXGPY1YpleBUy5PhyZbM7XK5qcw2G9gentA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuIxFDWq8d8H3la8u4mZqwEraKjtqDx4ujrK4gG/gTE=;
 b=hsCx98Rev+JafKhQDRG4tZKxiEWOGr38bKit9wVlejlGB1uSA5zRWLm5okFrN83zU+t4ZLefQ3pLh73Ffnw7HPe1NONXMCrj6QhQf/ts1iNyrL2r8mUTNi2Po5A57k6FLrxfd4SCaroUdir6IeodULRUwOHX7IFi+Ef8jdqAEUsY2byUbtVbiLp+WcLUYlLM1kI9DxZCoQH6wNvnaGCbGZEG/ocZc3GPtOwSANwHUIh1+yQELEZ42ZSDhDQlfFrsraq+iJur/MzSkmSlRWZx40op3U9CbDtODO0fYVAufd1RsDCQF7jbwkH+Nc9Oz7rDySmD3ak40zzntLCP5S+tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuIxFDWq8d8H3la8u4mZqwEraKjtqDx4ujrK4gG/gTE=;
 b=w6v8bw6VH/VmMuqqr2V8SyYI3xNJEUnEbVMm9PCTDpvyCcgupZVvby60ZDq01zLfUUNGeuAzgJL7tbBuD4GiIglNLP8ss3Xq9YAX0uPqgc5cEVyK14ySh5ywLbXKPwgMWa/Rwaxkj1CVGm5/dmNiH1tHjv9QKAPwicBYuLfp/2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:02:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 16:02:07 +0000
Message-ID: <9e129e55-daea-4941-96cf-fa2a14d89627@amd.com>
Date: Thu, 20 Jun 2024 11:02:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 2/4] selftests/resctrl: Pass sysfs controller name of
 the vendor
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1717626661.git.babu.moger@amd.com>
 <f45784f8882fa41d454ac3b35b203ee6d04ecc25.1717626661.git.babu.moger@amd.com>
 <fc551b62-6afa-40f8-b030-9e43253881db@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fc551b62-6afa-40f8-b030-9e43253881db@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d54ef-2ae6-4d6e-ff17-08dc91425581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmVWV0pYd2RlN2NkTnNncFFUdkNacDAwOXJNeitoZjNrQ2JwZmN6bU9PVnVM?=
 =?utf-8?B?a0plTnlnRFlwMUhnRHg1TUNYTzFEaDB5NG5UYTk5WVNUS3IzL3o0K05NUzcx?=
 =?utf-8?B?czRzWmY2djM3K2hUSFJkeTVGb0l5UUJrYUthQXRwNzlMV1FiaGdpaldCMVk3?=
 =?utf-8?B?UWEvVHl5Qm16cm16V2d4bmdKMVBFUk92TmlreGovN3hPQlNFUVZ5TTE5MVlt?=
 =?utf-8?B?UDBDZjlWMW5UYzY5SU9ZS0kwODM1cjFvU01rYWRWWURGdnlkemFDQmVMUEpR?=
 =?utf-8?B?MXdqZm15dWVZSEJyaHA5UWJMTDB4STJXMTJhOEs4cmNYSGx1cnpxWWdVRWEv?=
 =?utf-8?B?dndIcWNkUko2a3QyRTR1aVFXQ2c5V2k3YU9rN3J0UTRhclkyVURaVDdYRmdV?=
 =?utf-8?B?UkNCR3EvVUxSdTFZMk1iL08yY1lUUHV6N2xIdWovazZiQVpKTVluYnRLUXU3?=
 =?utf-8?B?QUl2dnppcjROSTVJWWNFZlNVakhrY255aXg0emljUk9yWWNEZ04wSlgzUUtD?=
 =?utf-8?B?VE1HT241U1VBQXBzaVVIZU90VHlCYkdvQWtSWTJvK3gyQmQ0cEhxVUpUYlI4?=
 =?utf-8?B?RHV2SU1wOTZORGxvallwYk9xb3dWendzcGk5enV0Q1NpQTFLbUovaUFMOVhx?=
 =?utf-8?B?T0ptaEYyUFNJWVBiZWlyRmh0MXdnM3MyeHBvdzRzQXUxa3g4NCs3eWdVZDBn?=
 =?utf-8?B?RGsrczR4Tko3L3BBU25UUUJ1U2FLYWdpZ3RFU1FpYllDQWtlU3g0eFIvdmli?=
 =?utf-8?B?bnpyODEwWGFxc1htRkRBOUV1R2VhdnMwVE9xU1UxSi9XMU9YRmpTNWQ2RWds?=
 =?utf-8?B?b2l1RFdMb3pObll4dCtUR09mcVBSdlJsYURNQTlMVVBkby9jem40NSsrc0Iy?=
 =?utf-8?B?ZUErT0pGWnp6RW9JMzk5R2hJNmpUWjZFNEtTTTdGZkVrU0ZOQ1Q1TEVjem16?=
 =?utf-8?B?WXBXaGxSclVvalhQN1BZRjNhWlhqcXNNYnlGbUZ2VmNkdmxJRWppb1RvZnl1?=
 =?utf-8?B?KzBOUWZxY1BiMm54eVloRlRuc3h6Myt5WXgyUmZoR0NSRm9tWkxJc3diZGhS?=
 =?utf-8?B?UHhjOENvVGsvREtTd3Fmc0RMV2x6SW1ma0RpNnhzZEk4K3NVT1B1aEpiZkhP?=
 =?utf-8?B?em5ZY2ZBeGtTRmJtOGdUbGorN2s1Q01RT3p2QmY4R3hRQ3NuMnhsdkxFYWJh?=
 =?utf-8?B?R3krOUtCQUJoQkszUTIyU1pNZVJpdnJWQ1BrRTFXSDZ4WGlyb3cxaW9aZzNC?=
 =?utf-8?B?QlhsNXlUejNoQ21sbkpqSFZFUDNkeXNVVXNrYUk1QTdkRm5uZ2JTNHVzUGpM?=
 =?utf-8?B?ZlpINUczWkJkM1NxZkJnaHFnK29veU9zZ214ZEsvYXpjM083VTlyYjR2b2xV?=
 =?utf-8?B?UDk3TXZ5Yit2alFMZ0lxUERyVWppZXhlQ1hTU0ZmS3h4UG84ZmtnUFkwcDBh?=
 =?utf-8?B?RGpweXFDSXl1RXVjZzY1WEFkelhsM08wcG9VQlFVd3Q2dGhuM2wrZnJMMmZx?=
 =?utf-8?B?K3NhNG9YcVFBMW5nTG1mWlFKby81SGhkbWlXOUZNTThlTFpLMjhSMmpxMkRn?=
 =?utf-8?B?d0lHZXlKUUZ6VjFCNkJTVkRNRXp3NFFhcWU0c1FISHF1eHo1ejlVR1UxOWc1?=
 =?utf-8?B?dVNBQ3hLWFRwSFg4WVpueVVwRnhicVhvN09xeTg2Z1JHNjI2WXJ5ZVVzWVRv?=
 =?utf-8?B?Tkc1aXRKNzJuNE5GMnMwcWNQTFREeVV0WUZzaWZJUXdNMTNzMEt0b1NJYWY0?=
 =?utf-8?Q?WfspQAtSaLpWkV/1fRB6wEqpXNo1r8P1WmGdAE2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9DUGZMcWRWSUZrSmtwd2JETkx0cm56bzNSVkU1OHAxcnZocTMreG96dUE1?=
 =?utf-8?B?K0hEQWo3SjlvK3lFbURlamJEa2lXcjVWbzFaclFIK1B3VHVIVG5LVzJUT1dn?=
 =?utf-8?B?cEZ0dmFNaWRhZTUrNTlVTnUwVU5aN3RaaFdXQjZYb0xrbkNXaVpvR29sWGdz?=
 =?utf-8?B?S0I4KzR1YnVDeFV3YzVwak1QcVJML3VRdjliakduTjV0WEI0c0tYeFE3ZGF6?=
 =?utf-8?B?M20rVGQ0bmpmME50TVQwaStYSysvTnRaSGhsbWJQT1pZakNlYTByeVlLUXAx?=
 =?utf-8?B?Y09leXNSblgrZ1IrTXlzdDFIN3JiNGtkb1ZXVnNuUy8yM2V3REY3ckFRMGNZ?=
 =?utf-8?B?WDZLV1hsQmpsTEVoMzIyejUyMWp0VzM2MGpyTWU3aDNtUTMrQUt5L1JENnhq?=
 =?utf-8?B?eFBiNmx6Uk1zMjQrc0g0QmVjU3FKZmdqT2tMZTBXWDJPMlRKYmFoUmpDK0lL?=
 =?utf-8?B?Vk00QW9uemFkUURpU1lCT2xMR1Q3MS9nVUNvVEdOaThRRWxBMTl3elg0MlZD?=
 =?utf-8?B?bUsyWlIzUXhlc3BEdFozZ2cyeU9udnZubXRSOXdCL090U20ycG1UeW8vWlNj?=
 =?utf-8?B?Wkd3OTJtcVlmRWU1dS9ldUEwdHhwaXFOd29XZWpiRm1KSzhBSjMzbTJoRFEw?=
 =?utf-8?B?MDN5N3BZSlpBcDNqMHdZb2draXByQk54TjZzbjNLVmNBcHpsb2JDWFFwS1FG?=
 =?utf-8?B?RVNGNWUxV21HZnUyRG1mNUt6NTdrTFFiTmFIcHdmRG9oci9ZNFNOZ3oxT05U?=
 =?utf-8?B?SFM1czJhR0RpS2NTZExHcGZPMlpDampnYnh0NTluNWVuUmk0ZFZxbzhVRjdX?=
 =?utf-8?B?MTB6Z0hBckxIckMxK2xBQVltN2hDbjVHVjk5WjUvSHU5bVB1NWt1YVhJS21a?=
 =?utf-8?B?ZjNVMFdxQU94WU5xbUtqekxBeThaOVJNTWVWMGVjMG83TGEwSXBnSnZzTjM2?=
 =?utf-8?B?WW5wVm5oNWQyRkQ4REZjOFpZYzhBMVBFWGNQWksrcVVWaThWTnA1dTM0dThK?=
 =?utf-8?B?VmFOLzIwc0ZDR09PZTV1MjRzWTZqL1B3OVBZcnhxOUpWSkZhN1pneWdIb0Fo?=
 =?utf-8?B?NTduL0FMN2RjNDU3aE5SUVhKN0Y5Yjd1K20rTHN4S2lwWjZQRTcva0h4eCt1?=
 =?utf-8?B?Z3gvQzVLYkNEa2NMTGFua1JqUThKSmZEYnBtV0pnNkp4NThtNkV0dFZ2NU9j?=
 =?utf-8?B?Ni8xRHBRb21nK0c5K2FpUFhqVzkrRDh4VHBFei9GeTNXMndLb3dsZFFWTDFJ?=
 =?utf-8?B?eW1Db011c3dBdjFWeXVoSWhmdE91aXJ3cm1LZFA2ZSt6VDFrb2hnazY5eWhq?=
 =?utf-8?B?MTEzMnVWYnlydkVLdFJ0ZHdnZGJGeVJmeEFoMGFwMnp0ZE5iVXlxbkJZdjNt?=
 =?utf-8?B?bmxXWVRyOHJxNjFxc3FaNzllMzF5SVZ4YUMrSXR1WVhybks2a2FlenRtbCtG?=
 =?utf-8?B?eWZSWW4rcHRYNnZxaTdKRlQ1dUYrd3dFM0JXeHlvK3BxeEVHbEY5eUpEUUho?=
 =?utf-8?B?VUx0WW9ZWUZqTmpBSnlBeU9JKzVVMUdkMTQ2Z1hLVU1lYStxUWMwN05aa0l5?=
 =?utf-8?B?Um4wejNhVkxKSmp1eVV0cnRlaHFmRnhlT2lvcVFXVTVVZ2U4WUdHMnE2TG5k?=
 =?utf-8?B?bFdZNlRMUGNMOUR6OSthSlJIaml0eGI2a05lbEFRUURXVXh4akZFSExsaDcx?=
 =?utf-8?B?T3NVM3dXYkRRM1VQSU1Pa0p2RkorSTBYNjRYd1RENTN5eFA2V1Vtb25RMnlZ?=
 =?utf-8?B?UCs1TWJVV3ovNGR4S2pUTmhNTjIyT3RxNDR3MDhLdUM3ekc3TEtlaEZiNTRY?=
 =?utf-8?B?NXNyZW93a0ZrU2oyTllDOWJxdzk1SjFabzJKTmk2NldZN29kS25tTnk2SUFy?=
 =?utf-8?B?Z3VNUmlXQjArMm1kSXh3ZTI4TWxWNTZMajRmbSt6bkRaNnhLRkY4cGE4NlR2?=
 =?utf-8?B?d1UrRU1uWFIwTmF1OENLbS9NaVpmUndkYXVLRFlOMWMvOXZyd0RCcmc5eUtS?=
 =?utf-8?B?WnRvamhOclo5Mm50aWx6ZXFubm96M2w2U3AvV3VtVXEvbHF4VFc5N2ZzUmw5?=
 =?utf-8?B?ZVV1RHgvM05NdS9kb1J5U0FuZ0pldUw1MWRyL1JLMUlsb0pGREcrT2Y1SEtx?=
 =?utf-8?Q?OCTU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d54ef-2ae6-4d6e-ff17-08dc91425581
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:02:06.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt5yn2ZQp5LskHk3qwvR0mog6+yv4AjZ0XoVH4fRE9DRipZNPG3k58q0AYpdM180
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

Hi Reinette,

On 6/14/24 13:38, Reinette Chatre wrote:
> Hi Babu,
> 
> Subject and changelog mentions how controller name is "passed" but the
> patch does not seem to "pass" anything new.

Sure. Will change the subject to this. Also will update the commit message.

selftests/resctrl: Dynamically detect sysfs controller name of the vendor

> 
> On 6/5/24 3:45 PM, Babu Moger wrote:
>> The test detects number of memory controllers by looking at the sysfs
>> file system. Detect the vendor to pass the controller name appropriately.
>> So, that rest of the code will be generic and can be used to support other
>> vendors.
>>
>> Also change the search to look for the full string "uncore_imc_". Replace
>> the sizeof with strlen.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v3: Change the search string to "uncore_imc_".
>>
>> v2: No changes
>> ---
>>   tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++++++-------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
>> b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 2d5e961b3a68..23c0e0a1d845 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -10,7 +10,7 @@
>>    */
>>   #include "resctrl.h"
>>   -#define UNCORE_IMC        "uncore_imc"
>> +#define UNCORE_IMC        "uncore_imc_"
>>   #define READ_FILE_NAME        "events/cas_count_read"
>>   #define WRITE_FILE_NAME        "events/cas_count_write"
>>   #define DYN_PMU_PATH        "/sys/bus/event_source/devices"
>> @@ -206,24 +206,30 @@ static int num_of_mem_controllers(void)
>>       char mc_dir[512], *temp;
>>       unsigned int count = 0;
>>       struct dirent *ep;
>> -    int ret;
>> +    char *sysfs_name;
>> +    int ret, vendor;
>>       DIR *dp;
>>   +    vendor = get_vendor();
> 
> get_vendor() is already optimized to only need to do actual detection once.
> I thus do not see a need for a local variable.

Sure.
> 
>> +    if (vendor == ARCH_INTEL) {
>> +        sysfs_name = UNCORE_IMC;
>> +    } else {
>> +        ksft_perror("Unsupported vendor!\n");
> 
> ksft_perror() also adds a "\n" so adding it here is not necessary. Also
> please drop the exclamation.

Sure.

> 
>> +        return -1;
>> +    }
>> +
>>       dp = opendir(DYN_PMU_PATH);
>>       if (dp) {
>>           while ((ep = readdir(dp))) {
>> -            temp = strstr(ep->d_name, UNCORE_IMC);
>> +            temp = strstr(ep->d_name, sysfs_name);
>>               if (!temp)
>>                   continue;
>>                 /*
>>                * imc counters are named as "uncore_imc_<n>", hence
>> -             * increment the pointer to point to <n>. Note that
>> -             * sizeof(UNCORE_IMC) would count for null character as
>> -             * well and hence the last underscore character in
>> -             * uncore_imc'_' need not be counted.
>> +             * increment the pointer to point to <n>.
>>                */
>> -            temp = temp + sizeof(UNCORE_IMC);
>> +            temp = temp + strlen(sysfs_name);
>>                 /*
>>                * Some directories under "DYN_PMU_PATH" could have
> 
> Reinette
> 

-- 
Thanks
Babu Moger

