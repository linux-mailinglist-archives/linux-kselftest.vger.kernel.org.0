Return-Path: <linux-kselftest+bounces-21440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63E9BC441
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 05:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF08D282259
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2016BE2A;
	Tue,  5 Nov 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3hWkmFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6AA2D;
	Tue,  5 Nov 2024 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780182; cv=fail; b=ZwArZUKjSk0i8O7/uo6sAEG8TOhPa/evMUBY1UDGiJkeTgBlMSvDoatphJs4jPLBjmqDNdKOG9W5ZKrKhpKHq81V5Mp9lg/rUZQXbHRd1eLjTwGgXxb7bxbTyVJTLsIuYR/bhPYZ7O57qfUYQS9EWoIFyYaKfjFSrvq/VZcdpt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780182; c=relaxed/simple;
	bh=q8IhqjYkBfbQDJfkj8r6lJFPRRXJAirDQGY5+vafnzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dsGgabIya85uDMfJBgxYhM7oMPgGLg8jih6G3a1uR2PUlj+ZNhGx1xh4C2M1DJFjnFnzMWQKaiCWTzRyAYZ9wsa6/CbizdwIoEV3vaIHoeHjEQGWOmkN+4iTiAUpI7aIDxerCr3J78rvz7BBzUM3bWMAhK/1kChhqwEYM1i5msk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3hWkmFr; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FptecqUZNedxjVezOx5VOPVn++hpjdilWDhp4wYkNdrXS+oyGVOcqLuGW855cCZLtTfLmarGo7lD8f+v8KJS7CHUlC/wQeYaJH55UPEHTLC0lh41XyldVAXGptUNlr+KCIanD/opWTi51+S0WQuJGw6XUAiYPZNNCSVmETBlFM50ERzwAUkbr7GQDW0qDAFqNI806E489uJ2a28EoI3eqFk9wXpKHe4RIwDXh9hRe2ISV/RTyvyRwz/jyKcMvU0oQwqRE2kI85d/H4eedru08ND2k7+lSvYE2ML2J1rizD+ch0A6BewRW4+zIEichqSRwiGHzcFlDdLBImqKX023+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVl40cnr3tvY8cQTuaW2fo3R7UnZBuSG99wWe+gNGus=;
 b=Lkwl0Qyi680KXd5EARDyStx6ZHeBZbrCNBqVTHlaFe0G+yhzXi1XsFY3G4Qx1CBNv5mTaimlr6ZHXnwon6Sa/CZM+b0JrREOwaQzv8a0hwhZBdGCqc8w+seWusjG+KBGjfyHG/fcPKHCgo2GV7lWjXX/UzIWH8YfAFXFfVoPliNHAODkoQeGEQ4zzcJi8SuaHDmmJOwjlOaFmh7EmzYPSsMYizZ4I1EEgsztqnGDx8Ts37qqakdOlE0oKCG3R9Y9SMKuyyJKAXp5Q5w8+ANjO/kr8/Y1SnPPnU83P40Z5Jjlu6qF4YcCt0sMftTGMa8mrar++IepDgr4qW+g2C79uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVl40cnr3tvY8cQTuaW2fo3R7UnZBuSG99wWe+gNGus=;
 b=p3hWkmFrUE/h5SnTakzyzoGb/EYwu12omwkj+3+R5HCtOH3GsTAxU4MFSWiezeWk7QiAA9NgxPyhfz9Y9+qye/8Uz8r2wQwP7a3Jsztq30BkecyqamibDNtUWEPgoHUugyGI1OScUIMkfhjTCj+RuB25k3F6To1roS+DwJbPK3E=
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 04:16:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::4e) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 04:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 04:16:15 +0000
Received: from [172.31.11.224] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 22:15:10 -0600
Message-ID: <0efe04cf-9b12-4a22-ad76-b7cd1f719f45@amd.com>
Date: Mon, 4 Nov 2024 22:14:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com> <Zx_QJJ1iAYewvP-k@google.com>
 <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com> <ZyI4cRLsaTQ3FMk7@google.com>
 <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com> <ZyJzcOCPJstrumbE@google.com>
 <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com> <ZyOv5US9u22lAiPU@google.com>
 <99e64d8e-2d10-41c7-8b7e-cd059c7e7f29@amd.com> <ZyldJ_ociCLg-b9a@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZyldJ_ociCLg-b9a@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6217e0-f78f-42d0-a1e9-08dcfd509725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXFObDJLbnViTWt0ZEt5SEU1ajcreW8zRVpqZmg0ZnhCZ0UrV3gxTko3N1hK?=
 =?utf-8?B?R3ZoTTNlZ3BHcERrRjRWTndEakNTU3JOaS9nVUtDbEQyMmlxZnQ1VVpqQVB4?=
 =?utf-8?B?MW94dmJ5UURJY3lINDNUMmkvRmh1ZTdyOXYxNzdkTU9NQ0dLeUtQWG9yYTYw?=
 =?utf-8?B?NlJXcDBiNWlBMDltMHN5eEc2Rno2cmdTRmczYmhYU05nRE5zekJWNHJjTXNo?=
 =?utf-8?B?NnFlNzg5QnZVcGkrZGlSQ0NDbGFDTzBqWDhOOFBZR1JQaThNNmx0RlUvSHZy?=
 =?utf-8?B?WXhoUWlEYW01c2lUV29rQWd0YUlhV2FyNnQyRENPcWhSWUV2TG12Q0dSN3Na?=
 =?utf-8?B?WmxRWGx4bjdIY2pTQVJHbWludVBlV0E0eDdwY3RQUGd4VTZGS0x4clNReWJq?=
 =?utf-8?B?ekxzQUtXanFrMnUyM0R3WVpPVENnVGx0WEhER0lYZ0V5bXI2N3p0cTVBYlp6?=
 =?utf-8?B?U2dDUHF5alkyeTVkMG8yNEIyWkROUkYwMG8xOTZZcUQvYUxRUGI2NXpzdlhO?=
 =?utf-8?B?dXI1VEs1UnN0dlRScmRTSW85Tk1XMXhKWEQrSFRZTHlWcnRSZlprZ0IyK1Zr?=
 =?utf-8?B?WllHY0k1czRPeDlabUFoYnFINkZBVHZuaVczdWpYeFkrVW1MNnVBelJmYUlD?=
 =?utf-8?B?aWZ2T1ZEQlh6c01kbDEreS8xVHA1UThDQjBRSDJzcU15VmFnbEdEa3RCb1lJ?=
 =?utf-8?B?azJla2dIaHZuU3dOSXBGVzhFQWJqMkJvV0NXb2NmcTRKSTRNN0U5cXVaMXRX?=
 =?utf-8?B?eVVIRDQyYzF3c3FHY3BoTjBtdGFTN0dvSkI5WFhxekpyL0tPK1JMUiszK0tU?=
 =?utf-8?B?cnV0VUt4bWlTM0Nxd09PdWN0dmp4MGhtOXZhNGZJZ2poWFBkeEd2SXBhRUpz?=
 =?utf-8?B?UU9tOEVxUHlZUkt6WXhPK2xVV1RKcmZHTzZzMHJCMTd0eG9xcnE1UFo3bDFN?=
 =?utf-8?B?WHQ4d1dyS1JrZXBESlREVUs0QnRGM0U2TWtOVEc2OFl6QVR5SUk2bHBKa1Vp?=
 =?utf-8?B?Umo1b1lvRHJEM0tIQmVsOE1wM3MwaW5JOEtKWkQ1RkFpRWtoQmpDRkpJZU53?=
 =?utf-8?B?WnhJR2IyT2pOcXkrSWRwQW5QWDFDWmZ1Nkp4aDVJZE9COWUwYXFZNTUyYk5Y?=
 =?utf-8?B?a0dlZlJwcU04TGlSTHVRRUx0NTM4MFc4ODI4bU84Tkd6Mk1lZ2FPME9PV1Rx?=
 =?utf-8?B?ZmVLQ3dPNFpvZ2R3QUFNN2FweEpnSEE2SkZpaHZ2djZ3YVlkWGswNVBHaVp0?=
 =?utf-8?B?cUZXNFdXNFFtdkl0OVp5ZCsyZnozZUJlbzMyL0lDdUdUbmh5WWdMak1wenFM?=
 =?utf-8?B?djVHVHhwSjBKc0hMdkR6NkZKRDZYdGgrUU1FSlkyUkNJQUUwSGdDR0I2aGVY?=
 =?utf-8?B?RXFDd2dXUGtCbkVtaGI0VUFaMk5KaFFYK3FraUg5NHBtRm9lWStDQW0zRUpF?=
 =?utf-8?B?aE1qdzFNR3JVdVJOaG44OTU5RkhuL2t2MUNLWkpyZmNFZ0J3bVdZM3QyQmZl?=
 =?utf-8?B?T3hjeWxGcjloVEd1UVFzSFlobU5SSHQ3ZlZNcGJwUU1hemxQUEFPMnpHVVZ6?=
 =?utf-8?B?U0U0WlJlQWxQODkzRUNJYzF6VHk0UG1SQkdVVG15QXNFUElRNlk5NUhXVno5?=
 =?utf-8?B?MDkyNkxJNmo5U2Q0TkZRckViaEN3L2ZWejVnbHBmL2xyY0F1TEZMYlZDOTVt?=
 =?utf-8?B?OC9zVGZPSHRhRm9kTldMMFdjNk42S1VrR0c5WDhhQlcwSTZHVFMxN3ZsbmxO?=
 =?utf-8?B?WFg3STQ2UXJJU1dEZkVWa2d2SzI3OUdMbG5oTk1QbXZtdXM4dEdoOFh4c0J1?=
 =?utf-8?Q?uffIB3M+cHyxZz5BS6o2J9T8O6Msf5ZZ1fM5A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 04:16:15.4179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6217e0-f78f-42d0-a1e9-08dcfd509725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238



On 11/4/2024 5:47 PM, Sean Christopherson wrote:
> On Mon, Nov 04, 2024, Pratik R. Sampat wrote:
>>
>>
>> On 10/31/2024 11:27 AM, Sean Christopherson wrote:
>>> On Thu, Oct 31, 2024, Pratik R. Sampat wrote:
>>>> Hi Sean,
>>>>
>>>> On 10/30/2024 12:57 PM, Sean Christopherson wrote:
>>>>> On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
>>>>>> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
>>>>>>> +/* Minimum firmware version required for the SEV-SNP support */
>>>>>>> +#define SNP_FW_REQ_VER_MAJOR   1
>>>>>>> +#define SNP_FW_REQ_VER_MINOR   51
>>>>>>>
>>>>>>> Side topic, why are these hardcoded?  And where did they come from?  If they're
>>>>>>> arbitrary KVM selftests values, make that super duper clear.
>>>>>>
>>>>>> Well, it's not entirely arbitrary. This was the version that SNP GA'd
>>>>>> with first so that kind of became the minimum required version needed.
>>>>>>
>>>>>> I think the only place we've documented this is here -
>>>>>> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
>>>>>>
>>>>>> Maybe, I can modify the comment above to say something like -
>>>>>> Minimum general availability release firmware required for SEV-SNP support.
>>>>>
>>>>> Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
>>>>> earth is that not checked and enforced by the kernel?  Relying on userspace to
>>>>> not crash the host (or worse) because of unsupported firmware is not a winning
>>>>> strategy.
>>>>
>>>> We do check against the firmware level 1.51 while setting things up
>>>> first (drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()) and we bail
>>>> out if it's otherwise. From the userspace, calls to KVM_SEV_INIT2 or any
>>>> other corresponding SNP calls should fail cleanly without any adverse
>>>> effects to the host.
>>>
>>> And I'm saying, that's not good enough.  If the platform doesn't support SNP,
>>> the KVM *must not* advertise support for SNP.
>>>
>>
>> Sure, fair to expect this. Currently, if the FW check fails, SNP is not
>> setup and there is nothing that indicates in the KVM capabilities (apart
>> from one dmesg error) that the support does not exist.
>>
>> One thing I could do (as an independent patch) is to introduce a CC API
>> that abstracts the FW version check made by the CCP module. Since sev
>> platform status can be gotten before INIT to extract the major and minor
>> version numbers, KVM can also call into this API and use that to decide
>> if the KVM capabilities for SNP must be set or not.
> 
> Why is CC_ATTR_HOST_SEV_SNP set if hardware/firmware can't actually support SNP?
> KVM shouldn't have to care about some arbitrary firmware API version, the whole
> point of a driver is so that KVM doesn't have to deal with such details.
> 
> I'm a-ok with a KVM selftest *asserting* that the kernel isn't broken, but KVM
> itself shouldn't need to manually check the firmware version.

Clearing CC_ATTR_HOST_SEV_SNP when the init fails is one approach to go
about it. Here we could clear it from here and eventually that would
prevent the the SNP feature being set in KVM capability.

+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1099,6 +1099,7 @@ static int __sev_snp_init_locked(int *error)
                return 0;

        if (!sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR)) {
+               cc_platform_clear(CC_ATTR_HOST_SEV_SNP);

A suggestion where we could more directly approach this could be by
exporting an explicit check from ccp instead?

--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
        return false;
 }

+bool sev_snp_fw_available(void)
+{
+    return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
+}
+EXPORT_SYMBOL_GPL(sev_snp_fw_available);

which could be then called on will as follows:

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3050,7 +3050,9 @@ void __init sev_hardware_setup(void)
        sev_es_asid_count = min_sev_asid - 1;
        WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
        sev_es_supported = true;
-       sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
+       sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP) && sev_snp_fw_available();

 out:
        if (boot_cpu_has(X86_FEATURE_SEV))

This would ensure that we could enable and disable the SNP capability
even in the case where maybe the firmware can get hotloaded using the
proposed download_firmware_ex[1] or in cases where the INIT could be
deferred; all while KVM wouldn't need to be bothered with the API
details.

[1]: https://lore.kernel.org/lkml/20241029183907.3536683-1-dionnaglaze@google.com/



