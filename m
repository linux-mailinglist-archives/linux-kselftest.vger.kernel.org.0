Return-Path: <linux-kselftest+bounces-103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A147EB25D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FA1F24FC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C899405F6;
	Tue, 14 Nov 2023 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="0V6piuLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7E41239;
	Tue, 14 Nov 2023 14:37:12 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C5173E;
	Tue, 14 Nov 2023 06:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJl5dByr2EVDQNLIoDXezCs3afl66xMtVbvJLnZyVNtgnp9d7bgzyJtKqJVaEaTurPlHTklUEbHVDK/cXFf6woLvu/o6WjcbZEi4+njy/gJkjAkFVDJ7lckFb5Wh+kcZE0JMoimlwCDp6dT49+FdcFdFUMk31hrgUxNXBacSdYBOuEaJtVosOdNf+u6RzdZaKiJIGXehZvT6kqgcbmtcehG1UJSFfpcxhRev12mKkBfGKtqQ95vnzPs8IB2/1iiAcvaz4cMS1NRgTlwucNPzrnrfsCUrJ++kI3CgU9NDovyXfc94NyE0XQvEyeFAB54HkDWB0WVrbTBykzU7ygEQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIp7OUZzg+QhnQ96ayhhLPJF21ZFpnDr328N3mBePF4=;
 b=iaVgV++ffTxZCBHT39XcUs06k+Eo+bvVjcNvipYzI06iXDVebXJagEPz4U0wD1teXddtb9pz+3AQfHMQGIaW+9dZfYalNYPhUfkU5oWItzrrslIk1mDvQFaQKcitB3kdTl+GBI6702DMfqBRqfbJlLAl53xgNcKOjlWNQdb2H6cmKqzCwlTXm7l8yAbETiRxQtVANv//MXa2aSWtDUFhTflxG2nH4NKNGrseqg2un/cMMb5csiztHB1Gcrbpn5CEtH0tL9eGOOIws6lfSgMApU4qg9OSW+a3QveB+KmksU5b79Va2ykbvHL5AUNErOSamXnOQbsKiGcUo+vwKiF3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIp7OUZzg+QhnQ96ayhhLPJF21ZFpnDr328N3mBePF4=;
 b=0V6piuLy1Cq9SgD1vJgXEVP1f7iW9KB69EL1PHBqqHX/JYR7bZPSXnVwGMpv0JHqfRu1KwywO9IDm6QN6IHBn4MqudK8iTN1xI2FwMmXxPcXziXR/KPs3UZw8ylL6hEVGifBbGCkx2kV/WAZIIR3qswgj0Qsd9vHEjvwGB4g+IHpL+/cBh7XfAi4TBY62sHlusPasCz9ZRP7LUL3gIFeWnBb13ST8x7d32Ug2NmMPrByhSvvMFdd8CT9COiWbJgkmhuEK7UG8abCc0ROgaj+tETwocRkOc0mmIdXLz8TdwLRFs9TzUpeQMfnvnmn/BfvsmX4CHL+2HBf7SkIX5rp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 14:37:06 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 14:37:05 +0000
Message-ID: <71636309-3bf1-4e7a-b586-c61fea30f7c0@suse.com>
Date: Tue, 14 Nov 2023 16:36:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/23] KVM: VMX: Dump FRED context in dump_vmcs()
Content-Language: en-US
To: Xin Li <xin3.li@intel.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 vkuznets@redhat.com, peterz@infradead.org, ravi.v.shankar@intel.com
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-15-xin3.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231108183003.5981-15-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: f56ab1d0-0f47-4c60-4fd9-08dbe51f2c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VuzdpoEvH9l5gF96VrW/BYUyPCtUMKYQH9UxfESN1ZOrnjflh5b+/lOU/WFsnuTgSnUUM8PNNJqtiXDrKbEHhAZx6w79yh7Ziotp+VBDZsg6STjkw9e4VctckE6XcpY/CLdNdn7kdxXViKhwGUOX7wTl1SUcfN8Yp2erWu363HbHUlGVHGp6MX1n7O6U2bjFZ3kkPSGe2lLH7Ro7ot1zxqRVKDR9dI/bd1ZJsTSLtnLn8hdA2zjsVotfgV1yu2t4uFwY4ZnG/YXKmMkl4tJrVeTGJC+0B6QZvDaI9b7R+3OhyNdVdUxC6rWrjA2O3Ohb71PcJTAVPQhF+1rCoUJFYXryWh6ssde23DwcQH6SbAdSpWf8zD+2xsNcj64U0J9Zqd4tm6+ON37ti3OG7clICg8DJmCbF/BUmhvVI3/vMgPDgBl+9MgpnF4P2x+p/ihvwmrzQdzlVM+u9n7dlNaIzFWktv5UkgdHf9xUkq4G8/bml0DJr96DirCWEMg3yV+GT7LXPd+XKliTm8if+fX+H5btrkM0hQJoOe+203ncxk546plz9qQCXHxUQronYBSiHPYNT+OthDCB5AXZX1wb+H0uEFjCyI4sqNk7RUdG/Xavc7tbpgKUorIPPIBYdk+A//zkfr40Mas+R8Gnu7C2Kw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(31696002)(2616005)(6512007)(478600001)(6486002)(6506007)(6666004)(38100700002)(83380400001)(2906002)(41300700001)(316002)(66946007)(66476007)(66556008)(7416002)(5660300002)(8936002)(4326008)(8676002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTgvVTlyaUFMcUNuNXJ0VTM0QllRdmxuK0xUSlE2KzN6Zkx3aXJlMXhlRWNT?=
 =?utf-8?B?Mm0ycytLUTVyWGNvUnMwM2dwK2QvMElYN0FXeTZmbU9kdG1YeWpQLzZVUGZv?=
 =?utf-8?B?R215U0dUM1J1MGVlMWxuZlBjME5yOVJwL3A0UDA2Z2QzVkdBSWJVWjB5YTA1?=
 =?utf-8?B?NFkwRXc5ZW42WVZJV1ZTL3pZdUlpcGtCbDlqNkIxY0hjcE5sbUc2eXNscE1P?=
 =?utf-8?B?Mm4zNUN6KzBTTVYvUnV4NEdja3JRWUNCejlBaE9RVldpVWpiSUFGWGp6b2pu?=
 =?utf-8?B?bWdVSDYzL2laakVxcWtCSFF2VmZJMWpUTThlOG1PU2VDSEJMbTFQZWcxdktm?=
 =?utf-8?B?cGZDUWdPQmRwZlNHeitiVTdjTXpJam5adUxkNFhGdWxKSnNjQmtMd3MzWkVR?=
 =?utf-8?B?cXVBZS9RcENRdXNOaHVDWkRyT0cyVHdmZkViUVd0Y3BZMnhqYVNXbTN1bHhT?=
 =?utf-8?B?Q1JJcGFqbnU3WDhzOFVtNjBac2gzdkRvWmh4WTN5RjlKWWppQmNLaDhGTjM2?=
 =?utf-8?B?ZEVVZHpoZGtiZkhVcDN3R0VzdTcyVzRhNHhKZ0hML3lwM2ZjNVQyZlVrNUpC?=
 =?utf-8?B?Y2c1VkxsNmNRU1B3UGJNNmtRU3BiM0JlNE1sVjA1cWRsRjlCTGdvUGJJbVFE?=
 =?utf-8?B?VVltb3g1S1ljSEQwMXJwMlozWEZ2Ky9SL2p1OFh3dlV1aXlkVGZDMW1zOHRN?=
 =?utf-8?B?MUxGeEF6MEdWY21MS3hVRXk2bjBoVzFmYlhmSEJJZlp4N2Z0Q28xamh1U3Ux?=
 =?utf-8?B?cmJZMGRzeHNoT2IrMmtPWFREYnh5VzJ0bTliZm5jdkNvUkxCb3JUYzk2ZmZa?=
 =?utf-8?B?RWtpVGlEMXMvc2pvSmI4QmQyTmx0K05iVVhOYjZ4TUlWeEtQVkhzWjZMcEt4?=
 =?utf-8?B?QkQzOFZLR1M3UnJqaHZYL0wxZkRrSmwvSkpxY1lyZFpydVkyamtUZTcyS0tU?=
 =?utf-8?B?L29rRFJhNmdvMTEyQkdRdjYzQ0QzQUM0eThYU0F1b0lLaFpEVEJRMWhZcjNO?=
 =?utf-8?B?a0psSytsYnJUeFFDb2pjeC9JdkovamZscXpCaUZteVlCdTByVTJOVkJqM01H?=
 =?utf-8?B?NStzNFJoNHZUanhEQ3FmT2RjdnovVGhteExwalhuQ0xwS0FnLzBuQXFqanZ5?=
 =?utf-8?B?RkRvRXMzb2x2UThXemoxUWlKWmx6cmhFeVZtM0lxV0REQm9MS3R0aFFKZlY0?=
 =?utf-8?B?V3MrT040UUtDak10WXpVZGtJZG5LdDhuVDAzYWdhaWxxVEcrSGRmeUQ1NHNl?=
 =?utf-8?B?bTh3SWhsTkJMMVBFUjZoRTliRk90bkdIRndxb0hKRzlEdnl5MDJ6Z2JDemp3?=
 =?utf-8?B?eDBuZ1hGVHVJbWY2b0RjeGI0bmZERXY2RmFFOFJXQlJsTGZaRjVaT3ZmeVd0?=
 =?utf-8?B?eHVMZk5Rd210MTNmYVZPS2dybDJTVitiUUtHcmo0WFJDdDdZcHVLNjl1YmVr?=
 =?utf-8?B?dG1pczVwRVZGaW1MbnhPZk12NGJURzFQT2lFTCtQdkVjZHgzcDF6bkJaZGlI?=
 =?utf-8?B?dGhaeElLODU4U0RNZnBPWFQvQUFqdmNsbEtQNmkxK0FqanJLbjQweVpoZTJr?=
 =?utf-8?B?eTlCaVA5cTRSVVFRZWRhVGdpU2xEVlVtK015bmd0MjhFK1o5OERDQ3dBd1B6?=
 =?utf-8?B?RFJpZVRScUV5YTJ1L3NuWlgrc1VqYkJLeW1uMVNZbmRUeCthNlBHY21Mb1Qx?=
 =?utf-8?B?TmVvZE8vcVR6alB3V2VBb01ZN0F6MzN1R2lPV25Ia3ZwWHFyYWZhTWVKaWsx?=
 =?utf-8?B?d0krVGlpSlVHaFdncVdiZGJHLzg1dGExRXQwdlpYWUpWdGxTTS9LZTJ2dE5u?=
 =?utf-8?B?dlk0MzR6S0UvTHVBVjJVOHNBMXZnbkJWSlhZdE1EOEc3ZUIrM1Q3MXdnZW9I?=
 =?utf-8?B?OEtPMEczT1BmVFY1TFg3NGdDTUVZWTRoMkEzOTZWWlNIc0JLV212QXhEdDNz?=
 =?utf-8?B?VWpPdGx5RTZEbEJLTnFWUmdOQzdFb0F6RVZZcTdPbzc3NzNCRDliZFBVaTVR?=
 =?utf-8?B?Q0x4S0ZRYmxvcGFpZTRZYnR3Q29IWi9admJrL2gzUU51ajNzcUM3SnhPT1pD?=
 =?utf-8?B?b1BMN3VJWmN2MEJRRXR1U1hZNnI3anA4MXRWUUZjWlE1OEFrbHd3MkRDOG9a?=
 =?utf-8?B?VkN0WHUxRnlZUXY5SXFjNUxtRE1vc2tSUU1ML3I1eUo1TjJxQUZCU1F0anFY?=
 =?utf-8?Q?sVY3Tg/ZOd4OLo3gAIMeRo0lNw+i4H/0aWxFdK1MJBOM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56ab1d0-0f47-4c60-4fd9-08dbe51f2c14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 14:37:05.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwdCejv0FO1iXWIkDXjjf/b+tOSEB4e2rpggmksbwcOKAxoaYCf0lBMLhVh1y+ShBgq/m5uiCileXgCV3aSAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456



On 8.11.23 г. 20:29 ч., Xin Li wrote:
> Add FRED related VMCS fields to dump_vmcs() to have it dump FRED context.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 48 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 518e68ee5a0d..b826dc188fc7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6429,7 +6429,7 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>   	struct vcpu_vmx *vmx = to_vmx(vcpu);
>   	u32 vmentry_ctl, vmexit_ctl;
>   	u32 cpu_based_exec_ctrl, pin_based_exec_ctrl, secondary_exec_control;
> -	u64 tertiary_exec_control;
> +	u64 tertiary_exec_control, secondary_vmexit_ctl;
>   	unsigned long cr4;
>   	int efer_slot;
>   
> @@ -6440,6 +6440,8 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>   
>   	vmentry_ctl = vmcs_read32(VM_ENTRY_CONTROLS);
>   	vmexit_ctl = vmcs_read32(VM_EXIT_CONTROLS);
> +	secondary_vmexit_ctl = cpu_has_secondary_vmexit_ctrls() ?
> +			       vmcs_read64(SECONDARY_VM_EXIT_CONTROLS) : 0;
>   	cpu_based_exec_ctrl = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
>   	pin_based_exec_ctrl = vmcs_read32(PIN_BASED_VM_EXEC_CONTROL);
>   	cr4 = vmcs_readl(GUEST_CR4);
> @@ -6486,6 +6488,19 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>   	vmx_dump_sel("LDTR:", GUEST_LDTR_SELECTOR);
>   	vmx_dump_dtsel("IDTR:", GUEST_IDTR_LIMIT);
>   	vmx_dump_sel("TR:  ", GUEST_TR_SELECTOR);
> +#ifdef CONFIG_X86_64
> +	if (cpu_feature_enabled(X86_FEATURE_FRED)) {

Shouldn't this be gated on whether FRED is enabled in kvm aka the CPUID 
bit is enumerated ?

<snip>

