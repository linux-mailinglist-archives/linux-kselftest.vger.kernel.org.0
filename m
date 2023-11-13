Return-Path: <linux-kselftest+bounces-50-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526E7EA1C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 18:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AE71F2108E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3E224CC;
	Mon, 13 Nov 2023 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="zeJDvY7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84380224CA;
	Mon, 13 Nov 2023 17:18:59 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6591A5;
	Mon, 13 Nov 2023 09:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRRnlB134HnO80opHYFzCraoyU1NaWhixmRt/ZW+ALwQazjTgpwfXko7Yrh2TxtivZ3eA1q20st/n+bEHdBJXb2+SmEsw7d5khZPyNjROH+OQjjbmSEps5uqLDwsEic4VjXTTpVkRWIJEAylpVtpDZp06GtMyJ2xUhnCz8ZV+VMoHAXv5+jr57xItxfAwMAgjpc5Ynp6bPIF0hLZYuudbF50PDcZ9Mm8QKdU6PR7/lkQe/HCv2OoR9rP/gozCmCdQahAadla9ISmBthNHipiflVYmNhLil1hrjnj2doQBP7J5YY5zsthurRET3CtvQtFptZx+ZbfVLmNYrzIpRMA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkhsRqviEtH1C56nh6LIMOXLO046NU8it+Sb7LhksrU=;
 b=iw+KXRFk1SSv52l8PR8y8a8yL3yaOkE02wFtxj1tFjVi/ROc1d5EnM5yuffmHlet+xbsIegRBc861QJ+ZYJR1mCLGrhB2MNDdb3fim59uqB1qxO7q2960kc/hWf/fUkcvYtq0+tB8wFD3e6XHnD9Z3STntzpFO0ulbNGlj2tn0oenHwjQgpdy0xptCd2aSggO/WN/0qxCTKrEGD0oM8Abqzj3LaNXvaWUoaK/kn0L/1ct9bDz812zkjHqgZOvtTJ6g4uK+8MLJmKSUmVjLWNRTzAr6XDKqyGqAZCCb0Bu0A5uBqMPQfafZhyqjobqB8s7j+Qw4ZlWvfSIrH49Jab7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkhsRqviEtH1C56nh6LIMOXLO046NU8it+Sb7LhksrU=;
 b=zeJDvY7FClVJ5WD2LJNc2ETjgLUOl6U/qsO4osYQwBKrG07Px2KIlUipu32ftKTxo6478lVTizUi6dZ4f1fG6QM/9bUJXu8PfTGGTk95DNo/cyWj1Wa4/WiTwwrFZ8E3iRKRxjvf7pr6DYGnR9zr9U0mJMhr6LW96c+GeAxsqmW0XFTLI13kmPHSGbmX/aL3lv6EBfThL2cs4VDun0GA+5F9Cap7I2wkK6qKY6TPKSCaLWO/blqacJXvaKpeTvmNXTB6sQlt/CEbD2Gg2Th2ViBwbsOcjjM4TtzXKDW0vXESGZyPt08tHAhJNV+lY5fanjLrlhacPdUEH79aNBLnIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 17:18:52 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 17:18:52 +0000
Message-ID: <9a4b7340-8ff8-426c-b25b-4ec340f96fd5@suse.com>
Date: Mon, 13 Nov 2023 19:18:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
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
 <20231108183003.5981-6-xin3.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231108183003.5981-6-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0031.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::20) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 475b3d86-4c23-46d6-cfd3-08dbe46c9b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vzN0btYIgSU28JpcR2D2y82oT3w022KhFJIEOgxdsQnk4CGZ8SfwXDhdCZpT9l9TQMXLkMfhkc0z5lO4BocFTaCHjdw0Wl/aSApeJds+ew6k8xsTynTTfZ05hITxMau8f2UbL9zB853kBgb7DptSXyh6HKp7Qa9+0GHFIKB6nkjD7D7xKxxkRQ1pmRj45FnYkyBO4Fq+1B0lABb06p+adldMM24Y8EDWPZbDjYz2l6/f6MsbwCCE3vCvthWjMIzWiWV+bHeRHZ0feS25J7FPELt8opYiGxtbP/re55jhZfiYr4cdAwdi2PXj0A6t8oIvDrxvOMlg09/oJA8JllFtKj56bZqrbG19U1hsIN9OGcQxu6MLwlYqTqSfQo1WKnCB1Z8w211LrvvSr7SfAuiCaQLelk1TD+bAj1Ikel7NSIzuwSMyssBADqR5vlsTQkYRKW3WQuiA+hdFCG8gvWO9Yht2BaVA3WRJhcZs36aSi/A58MismJbCn0yLRbVKvTr6TzlS9saZfiPRhEb7wDnNl2oL6KYHAELMUFHrmRNZbWU1PuDvz+8u/Aa+FIMPQNPEpzBbKzd9Wk5ngcznRMMWH2R273nGkNYGFjerFRU4co+gtQJ8pnr+aiqnNH9WZeewEM2puBh35nRFxMevqVUlgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(8936002)(8676002)(38100700002)(66946007)(6666004)(6506007)(66556008)(66476007)(478600001)(6486002)(83380400001)(6512007)(316002)(2616005)(36756003)(5660300002)(7416002)(86362001)(2906002)(31696002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0QzV3hndHBPUExqb01JdWdCaFBJWGVSZVFqV21wT25kNUFaUGpRU0oxV0NU?=
 =?utf-8?B?OGhGRUpDY21DOTBSOGphVFRTOWJBNXhVVWdPNUZiZ0hUdDJna2IrYU1Pakxm?=
 =?utf-8?B?VjZqbUhqM256a2IyTmtVdUFvY0l4dlkwY24yZDh5dWZsSHgrREJsRE5yY1h5?=
 =?utf-8?B?OGtDdVFMdzhucXQ2SEE2bG4vK0p3V3dYZHdXVksyUFZmdjEwdEhWYkVUaDdm?=
 =?utf-8?B?MmdNbll3Vm5IeXo4eE5iV1B0TnRCeHBPU09wTE8zbmtoZ1ZGQmduQm4zdDNG?=
 =?utf-8?B?MHh0ZEh4NTVycnhrS3dTMUQxKytCRmR5TnBSTzNHd0xFM3JnTkhvVVVVMEl3?=
 =?utf-8?B?Q3JGT2wxbXJTMjlpM2VyM3k4a0hQTGlWcXdKcWluZkFnMmZHcHpnUTI4RE9R?=
 =?utf-8?B?MXBJSEJDWnh4anJoZHBMa2lGOW9QbVFMckJ2VmozUGsrajdFZkFvZUZOcUho?=
 =?utf-8?B?cHFsaUN0WWY3RDM2MnFEMG1pWWttY2g4eC9mVklUM01vTC95bkhHb2pVRnVY?=
 =?utf-8?B?N092VnpSWHpaNFNJY0pMaHhPVHdNZExyOUNMSzJlcFdSamhxVFJtNjFzbzJV?=
 =?utf-8?B?WHNjbk9DZFJTc1VHQWIzQ2E2L2xuWVFkV09PcUtIMlRoVVFYWGlQVnNkeGhN?=
 =?utf-8?B?Y09od28xR2JmWDJsVkV1UCszZk9DR3lNVkVUK0JjSHB6MTNMYTVVVXlFZndJ?=
 =?utf-8?B?MThsQkhtaDFxOTlZM1hmNWNNWTZWK1FrbitsN3JvdHJuOUhWcW1qeHV1d2N2?=
 =?utf-8?B?YjhwOGVoUDQ4UmhPYVhpZi80bEd2M0xvNit6cFJVUnB2RW52djFnQ2JZZHdD?=
 =?utf-8?B?RWxaM05pbmVpS24vcXNyck1RTXcwd294bk5HcFNWSHFDNDQ0WkdQYlJGcUhX?=
 =?utf-8?B?eG1TRXkyUXRRUXNZaDRHQVV1V3ZETFdENk5VbnBEaWpuVjlYOUNzS2o2T0JS?=
 =?utf-8?B?L2Y2cUtsMlRjblFXYzUwYkt3L1JlVDYxMWloUDEyOGwweHBEWUQ3YVhaRDZC?=
 =?utf-8?B?bzlMRm9FbjVkckxMcFFuZEpSbEtiaSs2S29GMFZTek84NEVJbDNwcW8xT2Fh?=
 =?utf-8?B?UUpocFFyeXp2ZGdBbm1NcFJyQmJESFJIRTYxS2RBWEo3Ry84SDlHVkZpaVh5?=
 =?utf-8?B?b282d3lPSVNwWVRrY0I5ZkNkeWxqanhROHdVYjY1c1l0UXNTVU51VjVhMkJX?=
 =?utf-8?B?eURJK2lLZzFzQTVOYXFXTmx2eGFJblhIb2FqRi9zNkJ3Q01BaDdxRTdqWEk3?=
 =?utf-8?B?WmMzSkI4YllkTDEyMVd5UzhpcjcxOXoyMVR2WU1YOXppdUNEdm1UcDdwdVdH?=
 =?utf-8?B?L3NWdzFTRjBmK1ExUDFHZ2ZkRDM3Smtaclp3VVpneFdpZEk5d09TU2FUY0dE?=
 =?utf-8?B?NDJXT1pqSGtzQ3NpM2Y4NWl5cHE0anVJemlFZ05aeDltb2labmVnN2NPSytR?=
 =?utf-8?B?a3dBc2hCTXpEZnVBSTlBOTR2WFhFQzZTNmpSbXVPWTVJSDlGMWVHTkQzU2kx?=
 =?utf-8?B?TWFrcGVHQkRxUzZiUGV6TjJ6Q3lvZHhKSkhVc3ZzcXdjTjk5amQzMmkrTUlv?=
 =?utf-8?B?d0tMUlZBUDV1cHNxUW0vcUc4UGIrWVM4c1pFMm0yVURWUk1qSlVqMXVBcEpV?=
 =?utf-8?B?MVg1Z1FkQUFqVThNM3J1MDNjb1B1TXNqam9YS0R5blkrV2lJYWpnaDBtSUQ1?=
 =?utf-8?B?K0NBQ1BtNEJFVGs4anBsY2hsT01LV3dXc0R5bjh0eEZReDBXeTFVdlROR093?=
 =?utf-8?B?b0pqeTNKZjJwMnQ3TUxLSG1mM0hpVWNkdFRJejhwclRjWWkzeVNsc2pOOWU0?=
 =?utf-8?B?NWlIc2lOYlFpUkZlQUd4OWt0VlNoc3NMV2ZpMTNJQzlTdjJqMzJZVlRFU0Y2?=
 =?utf-8?B?Q21wVkpnamZOc2FwTFhOdnEybVhORkYveGp1cGsrdDZtdW5FY0p4NGREV3g5?=
 =?utf-8?B?UUlISkdRczhydCtZNjNWaVJFNlVtNzk2QXp5ODFMS0xUMDZYbVM0emlQRDNk?=
 =?utf-8?B?SkNaWHpkcWtRSkg0NmRnQUJsQ2c5N0E3SVczMW04WnNmSjZOQzU5cWNQbVVz?=
 =?utf-8?B?NWJ3aTFWVHRVbWRpNGZwbWhLNmMyTlFuRng2VkliS3VlZ1JnOWZFVkt0RllV?=
 =?utf-8?B?MVBDc1paNkFydmVFQ1ZwRXFaWDRpNEp4S0p3WEFPZUFJNGNuMURyR1NvQ2pp?=
 =?utf-8?Q?irFynQibSKY1VyZKssHrLlqWJg1Fydyt+YzuMToF/ip/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b3d86-4c23-46d6-cfd3-08dbe46c9b97
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:18:52.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkQzgg/vvMU0fAEFVnn6tKZkaBaFExS7k40RmBAOQoLDmjNCWETukJUmFE8R0uOL47kau8XtSOSl6Rikvqwx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404



On 8.11.23 г. 20:29 ч., Xin Li wrote:
> Setup the global vmcs_config for FRED:
> 1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
>     have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
> 2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
>     KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
>     guest FRED MSRs to VMCS during VM exit.
> 3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
>     KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
>     host FRED MSRs from VMCS during VM exit.
> 
> Also add sanity checks to make sure FRED VM entry/exit controls can be
> set on a FRED CPU.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>   arch/x86/include/asm/vmx.h |  3 +++
>   arch/x86/kvm/vmx/vmx.c     | 19 ++++++++++++++++++-
>   arch/x86/kvm/vmx/vmx.h     |  7 +++++--
>   3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 4d4177ec802c..41796a733bc9 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -106,6 +106,8 @@
>   #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
>   #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
>   #define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
> +#define SECONDARY_VM_EXIT_SAVE_IA32_FRED	0x00000001
> +#define SECONDARY_VM_EXIT_LOAD_IA32_FRED	0x00000002
>   
>   #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
>   
> @@ -119,6 +121,7 @@
>   #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
>   #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
>   #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
> +#define VM_ENTRY_LOAD_IA32_FRED			0x00800000
>   
>   #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
>   
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index df769207cbe0..9186f41974ab 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2694,10 +2694,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   		_vmexit_control &= ~x_ctrl;
>   	}
>   
> -	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
> +	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
>   		_secondary_vmexit_control =
>   			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
>   					      MSR_IA32_VMX_EXIT_CTLS2);
> +		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +		    !(_secondary_vmexit_control & SECONDARY_VM_EXIT_SAVE_IA32_FRED &&
> +		      _secondary_vmexit_control & SECONDARY_VM_EXIT_LOAD_IA32_FRED)) {

Can those checks actually trigger? I.e if FEATURE_FRED is set it means 
the CPU implements the FRED spec. According to the spec it's guaranteed 
that VMX_EXIT_CTLS2 will contain those bits set to 1. So aren't those 
checks superfluous?

> +			pr_warn_once("FRED enabled but no VMX VM-Exit {SAVE,LOAD}_IA32_FRED controls: %llx\n",
> +				     _secondary_vmexit_control);
> +			if (error_on_inconsistent_vmcs_config)
> +				return -EIO;
> +		}
> +	}
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
DITTO

<snip>

