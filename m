Return-Path: <linux-kselftest+bounces-21406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99E9BBEB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98F61F220D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7F1E47B9;
	Mon,  4 Nov 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTpHFr67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A111CC178;
	Mon,  4 Nov 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751674; cv=fail; b=SjlY8XGZCShmqF4M23yNGSDoY0OZ0/FQf2MB9IDIBECZzSskrLiWd+W/wrXr8v9NWlQG/TBjRxBgpxCjktoBDXO4itheLOFYBXc6CoCbkG86cJjBYQSo+dtXNp8j8FBo1a6YWtG01Xra1hokq6P/zAO2IzrpmYGA+WOsk6kUvBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751674; c=relaxed/simple;
	bh=KctQztkk1I/pMJtn2AsF2kv6H1Bo3d8N6MphDh84A10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pY1dnA4qWeJ5ZqRxiPSWcSENCUtPRE/4ASta5XwGI+3MDXhN2g7tmNsQwX3nHylgBu6o43/tuizUBjYdD3J4OCVZSzORRYfD/Wfx1pGoeb6Ieydp2KC4COKZrSbxBIstPcBJyrxgLRY8jukDYIFMAaPA0Goc5KpwG88n9bsWg0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTpHFr67; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqVL9/RcIbmf0w2cKV5pHi8TFlsud7oPMZHBqWXz+QBrT4/JFSlb57At6yB10pmBS+ckma9oqHa0iPbBafFxPdbBA8B3D6Zq7rj/9wpBaardlIVtllWGGTOBMijHPGXErbIMvY4Oc+sdl/2Siirw385a0i7KvxhSUTSxMJ/1k/WYcz0nBP7kjxNAJAWsHrtMhYgXwhRKE2gRIWchl8rxsvChem33Fqa8ktfKnXyJFBVK5pqs2VCX62iZ8PbZI/Mawylee/T5ko01Af+yCW0eS4JD3bpyl1wpRFPm9+IXKhHV0ITf/KEPA1JXXG8LEbEYyljHVG70P83QqAKwCwecvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZfyNmTgA+52VDM070oLcwsQJuEu6OgWpd61Cfs4b8M=;
 b=JtUOYUurBd/FdM5BX7fk5mdTD/PGptQTShr04+aORNnUajTETrRCx5HT6IxpiCD0Dlz0xYNnwS/ljzN1Z5PwkLQ+3b2lpIqy2bEpjfqSxHt/1UNsBFY5LJXMDOz1w2eBqKxQ2841IxHCBYVTwhcDIdEboRCWs3KkPhdHyXuK3uQ8mdQ4cYVki4uCbzzcwzNt1RrcFOmH5zunbmZRlyUQcFQMCkieAcHv+QsRtbanUoR9bSFeMOBu7OB83hGNxS0D3yQiYrLDWtyqX4HxsijXx2/HEI9/V2/4qMjlWpYBu/AGrM6L2W0gP8uqZhBmrt+6cE0UmYM72HNILU4/7IZLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZfyNmTgA+52VDM070oLcwsQJuEu6OgWpd61Cfs4b8M=;
 b=TTpHFr679Wrv3tkmfUBkF5yyR+l1kLHdZZXDd1mPnRzvKyC+yoLGhgHERligAcGHuRkyRsZ5kqY9Umc/4NwyjKJfm5YobeQ7Yg55q+QIW2e3YtfIYilOQdjAqoruY55Mu0gmLBIoL2SggN7QrCR2iGjurHXv/cnF1VIWCVlTKQU=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 20:21:07 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::76) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 20:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 20:21:06 +0000
Received: from [10.236.191.107] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 14:21:05 -0600
Message-ID: <99e64d8e-2d10-41c7-8b7e-cd059c7e7f29@amd.com>
Date: Mon, 4 Nov 2024 14:21:04 -0600
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
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com>
 <Zw2fW2AJU-_Yi5U6@google.com> <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
 <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
 <ZyI4cRLsaTQ3FMk7@google.com> <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
 <ZyJzcOCPJstrumbE@google.com> <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com>
 <ZyOv5US9u22lAiPU@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZyOv5US9u22lAiPU@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c27493-a17f-4f22-ce7b-08dcfd0e3685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNWaHlrbXVaNGlnV296eXFPY3JqU25Dcm00WGthZGNyTm9weFpGVTBBTVdh?=
 =?utf-8?B?SWxhMmEvQ3grNXhCSENoQnNiTjlSNXY0RVozM09scFMzV085VWxUMlpTcUFU?=
 =?utf-8?B?UFUwWC9nVlRDN0xLSVVQeFpDUkU4K2tZbXNyZi9zZld0M0VPZ3hKZC9HMms0?=
 =?utf-8?B?NjZ4ZDBlZWNpVlpkRzhkRVhMR1h1OEIxK3NaN2ZtenE2d1VpRjgxeEdHRHFF?=
 =?utf-8?B?cGFReWV5UVcwSzZBTWdHUk43dnhKNVVLS2labjZUeDVOQ0poUlUxMm5Uamts?=
 =?utf-8?B?SnhGNW9UcDNaTkp2Y1VIdy9zY0x4YVdoZHRmOG1NaHpRMFU1NUNpcFZBclpm?=
 =?utf-8?B?S2NUUzJ1djFrRW9vdU5CQitucGZSbXJrRXBSWVFYbDl2akR1RTh5NFlhcVE1?=
 =?utf-8?B?UlFvcGZ4U2tWRGdZREswc3RzZGVNaTBrYWJPbGNkanNQUVc3WFJmRkRmbDVC?=
 =?utf-8?B?UWpNSTB1MlJwSXQ1Zlk2OWJQVFRpQW16L2poUDhrZWlidHZPbE1iaFBWMUhh?=
 =?utf-8?B?T1pmS0FnaGdwMzBkcElTVlVmSkFMVUh5TTNORDB4QXVQLzJUS1RGVEhZczBV?=
 =?utf-8?B?akhDNlRxT1dqTnNPUWo3dkNlK1hIRzdMdzhTbUZYUVo3c1V4R2hMendmR0RR?=
 =?utf-8?B?QW5EVjlhZ01CYTc0elNmUXVCeWFrb05oRFZTQXRTaThyd1lCdUtNNDZYRGFZ?=
 =?utf-8?B?UlRraVdub2NxVmVXVGo0OXRYTXlFNE5VRDFSY3dlU1pvNHVMY0RhL0s2aTM2?=
 =?utf-8?B?RitEWVc3VWVNVVNaemtqODl3WU5kZHNrY1YzY1VxVzdOeDRyOUlqaDd3SHRO?=
 =?utf-8?B?R3J5eVd4eGM1NXQ1ZkZJK3hRZTdzZjJGT1BUTisvbWZiaXdqZHFvVlh2RExa?=
 =?utf-8?B?WkEweHJqNFhRdFl1L1E3L21QZ04rZkp6L3Q5ZEJSVWpvSE5KUkp6MVp0dG85?=
 =?utf-8?B?QWFkRU9ZSlhSMnZkMjhpdGgzYWJEKzJWLzNwemZlZ2NrVm44eWJXQUIrTXJO?=
 =?utf-8?B?TkYxWDZEb1E4QjNJdTFWMzlCUGFvaFVOUWsyVTNVQ0tFRC9jd0FBNHF2Z01X?=
 =?utf-8?B?ZFY1VWFpa2FSVmtkdEtXNlQ0eWhCaWk1enhabmg3NkVuSU9uZTRQanhjN3RR?=
 =?utf-8?B?NzJndVllNE95MXNxRGhNVlFWaGpzZU5pL0NZZHE0enIwVm9icUFTVGdFb0Jq?=
 =?utf-8?B?Q1pMUEg3VDlOQW52YXJvTEZZSUJVYngzc3IxTFkyTWUrS2orZU15M2FKUjBE?=
 =?utf-8?B?d0dCVnZwWVBGYncvYnluS2Y2OGkzdzVtQzJPa0VZQnRUNzhOaTM2Z1lpc3Nw?=
 =?utf-8?B?MktYK05aT1Q5d3ZHbngyckRwWnd4MG9iTGtMeXJkcndDcm1XaEdlV2xIaVEy?=
 =?utf-8?B?VGxCcVpzVlFTYStjUFpGVGZybzRiZTROQnVoQnVJKzh1bit0dmxjZFNtaXR0?=
 =?utf-8?B?c3M5b0kyZFFBN0IwbzB4bERKZ2xTYUNjcFdZbGlpQVNKVEIvbnc3SUF4Z2VK?=
 =?utf-8?B?L1BENFVZSEZBTUhnQ01VNjVQY1pmcUdtSlZ3aUVYRENidnlUUWxaNGh6cWxr?=
 =?utf-8?B?KzRHS2swdWJqMDlEaUtyK1ZGbHBWV1ZWU1BaYkNQZC83azM0QzI2Z1pUeGpS?=
 =?utf-8?B?bW16UU1ncWFFbEJvMHZDRWpKQUVrQkNqMENGcjdLcERTaGk0ZTVZY3JkT0ht?=
 =?utf-8?B?VnhZbzU3d2dwaEVRUXgrZXpNTk5QcDZwQ1pmQ0ZvelczMC9sMlNHVVhqOUI2?=
 =?utf-8?B?YS9memRrT2dyQ29uWTRNZkNwOHY1THIxOXVRR05vQUtrNHQvQmgwYU13Qlh5?=
 =?utf-8?Q?hPmImsnUEIDQeh4MmA3R8MV3Y6YV2X4IL071E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:21:06.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c27493-a17f-4f22-ce7b-08dcfd0e3685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715



On 10/31/2024 11:27 AM, Sean Christopherson wrote:
> On Thu, Oct 31, 2024, Pratik R. Sampat wrote:
>> Hi Sean,
>>
>> On 10/30/2024 12:57 PM, Sean Christopherson wrote:
>>> On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
>>>> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
>>>>> +/* Minimum firmware version required for the SEV-SNP support */
>>>>> +#define SNP_FW_REQ_VER_MAJOR   1
>>>>> +#define SNP_FW_REQ_VER_MINOR   51
>>>>>
>>>>> Side topic, why are these hardcoded?  And where did they come from?  If they're
>>>>> arbitrary KVM selftests values, make that super duper clear.
>>>>
>>>> Well, it's not entirely arbitrary. This was the version that SNP GA'd
>>>> with first so that kind of became the minimum required version needed.
>>>>
>>>> I think the only place we've documented this is here -
>>>> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
>>>>
>>>> Maybe, I can modify the comment above to say something like -
>>>> Minimum general availability release firmware required for SEV-SNP support.
>>>
>>> Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
>>> earth is that not checked and enforced by the kernel?  Relying on userspace to
>>> not crash the host (or worse) because of unsupported firmware is not a winning
>>> strategy.
>>
>> We do check against the firmware level 1.51 while setting things up
>> first (drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()) and we bail
>> out if it's otherwise. From the userspace, calls to KVM_SEV_INIT2 or any
>> other corresponding SNP calls should fail cleanly without any adverse
>> effects to the host.
> 
> And I'm saying, that's not good enough.  If the platform doesn't support SNP,
> the KVM *must not* advertise support for SNP.
> 

Sure, fair to expect this. Currently, if the FW check fails, SNP is not
setup and there is nothing that indicates in the KVM capabilities (apart
from one dmesg error) that the support does not exist.

One thing I could do (as an independent patch) is to introduce a CC API
that abstracts the FW version check made by the CCP module. Since sev
platform status can be gotten before INIT to extract the major and minor
version numbers, KVM can also call into this API and use that to decide
if the KVM capabilities for SNP must be set or not.

Thanks!
Pratik

>> From the positive selftest perspective though, we want to make sure it's
>> both supported and enabled, and skip the test if not.
> 
> No, we want the test to assert that KVM reports SNP support if and only if SNP
> is 100% supported.
> 
>> I believe we can tell if it's supported by the platform using the MSR -
>> MSR_AMD64_SEV_SNP_ENABLED or the X86_FEATURE_SEV_SNP from the KVM
>> capabilities. However, to determine if it's enabled from the kernel, I
>> made this check here. Having said that, I do agree that there should
>> probably be a better way to expose this support to the userspace.
>>
>> Thanks
>> Pratik


