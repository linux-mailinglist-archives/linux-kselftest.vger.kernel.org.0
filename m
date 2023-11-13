Return-Path: <linux-kselftest+bounces-48-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F87E99F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 11:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52851F20EF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678A1C2B7;
	Mon, 13 Nov 2023 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmBLRtIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B01C2BC;
	Mon, 13 Nov 2023 10:15:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5FD4C;
	Mon, 13 Nov 2023 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699870516; x=1731406516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wwg6aWheJc0So6B/oqtSbhvT5odSsezfAU2b/LEAjNA=;
  b=fmBLRtIMRN9q4XQVGSY7uwgvWTCT6OleAnP+t5Ejny1QIqL8evTeTrGQ
   kFKwD9CRghHwLSO/HTuRva+w6sZkbXNpuUPo8wpfPugKDic6D0HJMQPov
   c82c7HAuTU8YWbKFL7FDhtDy+WvnNLLyRwe3rTZ3iD90mfpShXpBERVFC
   2usL7q4MVRDRQvyXl3frYCyAxYVOajIdOy3fF4vdUSpXTdcpzWeL8VIYS
   oeaS6LcMiPb1TE1nP0sVL4gIH6us2ISaZLAaPME/5N67r/SLYBzYJMlrp
   T/rI0n3NNZqBOsiSslgp3vyscgMixAnld8RD8PUy5UOIiuxihGfGf41s0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="370609579"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370609579"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 02:15:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="764290907"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="764290907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 02:15:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 02:15:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 02:15:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 02:15:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLIiUCdVsPFFCS7AMB8agy0bTTafdbhaIfTbRhAneyRRzDNTCtDpBkQaqB/tdtu2O6HuULazX1VjmMyv+8I38aRQnsxbazxip5h5R/nTpfY6yghLTBHtvdoqVci+ntQltlksLGY0a0lV1rNK039LuEUT18oa4WZgA0B/DsMnlIqtpulDqDdwq5qq2btXrP6t1WOfKX+b2LPTOR+k9h42XtXRUhyECX4VY9Oz4SZ7vnucjQwJAWptuHivCkxL9F4lDpaiCvjmVHs/I7tzz9BRErFpd0+zTGjOvt/ARXnrr6NqNQq9LKt16Awj8/c/87ZnenkOcCLOya81ZuTPtye0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX2QYOpa5TKlPwPkNcG+yLTD9nl4tE2JXwNK5pXmp1g=;
 b=RumASucUJDdsmtwGIC5abpfYg8uf395/hseVHBqQsf8YaZwoCjafnSbSNmeyUN29u6a+7VLApAp5jnBBxjE1M8eFVvKYPAHCyeANRSLRt7lLO/tVhYxjg8+3IfQm1T+FmXDFUSEMF7MzMO7WUUOLndWyeL2IgeVMK+EOydh+BHkXRcF9yOmAW2Vprwyg2Cbjd7frGkcqOMrQtXgJ4gKsJwbYURpmJSvRJf/Pm5vG1cS/SN4qYHjEr7RyIcSCWihYmMHDY1TGLX0FaXBix0bbQKoPgG5JAuXOfwHWKXpBbtkP+UhQi5JOyTWlcedobk1p7NmdBHUpbcr2IHKTwD3u5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 10:15:12 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 10:15:11 +0000
Date: Mon, 13 Nov 2023 18:14:57 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <corbet@lwn.net>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<vkuznets@redhat.com>, <peterz@infradead.org>, <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Message-ID: <ZVH3IUsfvzuPaj6L@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-13-xin3.li@intel.com>
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b4c953-871b-42ed-8e43-08dbe4316ad7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGTaev7K1H0+aPq+/4O4KHJEqitC7WgrR2GD0jDbnGBi41VwUGUMgAimN9H7a2US13eWGU+IgK4LvKWMRqC6mCkapxFAsbJgvRrZ1JP6cLZ6lKC2602ALP+24W/2rymXBPsd2gIFVyN6Ai4a1rFi/yydsrk9V2sOSze9Cb7y2uUhg+xzbR6wHde5jqtCCEgR09hNHELiP3EUQpnIfNQSLToULKU9edBTiyBwnlxIrhiDxW7MGVI3urk7K2FlZ2VXLzfJqzUSZKmjKGiqtxedBfG67GLDjdKQfV5cRnQ2ayetcIdLZd3vsD0GHMDa+UZXXtaTLnsRG26XaIxksbKX4acKgeOKwAsRMUl2KU5qnz6vlnxjygLi8EzE8eIYlDlP9kZYfdmmc8ODE+3nYANxwYGHMA87biulNg8DRG0x2+V+u5wynvrsKnC373HPOAZh33CFnMFo5gitSnJ+Dp6ViK+4Y6E9YuLmkuR8zxI8dWb+smPTf757KlTZ2FooBiJYsNp2L3Alox54+GkDXfqrRwmsVMNzkp4KGShqZbdvK8s/EOQ+ZTF8uyaoKngL8FtO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(6506007)(6666004)(33716001)(9686003)(6512007)(83380400001)(44832011)(5660300002)(7416002)(4326008)(8676002)(8936002)(6862004)(41300700001)(2906002)(6486002)(478600001)(316002)(6636002)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIX7IZJooTSK+aptYbs6MrunyA+tPAENlZRt8QQDuwNJ2zaqAHib4E13C830?=
 =?us-ascii?Q?eN0EATkNiPSqVhpUyg2gzptJyEOK1ZmOKf6RlQfgNkAlbAXW+rhvoVgzz6Tp?=
 =?us-ascii?Q?ZxdecmeEOh1jXMIiqiEIkxcObl7dUUNdnqSgEugZzk8z9928hhdk+KMiQWwO?=
 =?us-ascii?Q?w1bYvyKtURCTW2BZUs7Aqmaw70tJDI6wqX/WQkZIZPHM6iKKVO3NKKR1hnzz?=
 =?us-ascii?Q?IFrg+FvhcyWnKKxxm5Y5/sgBBqAmoYuv4AkDTYj8jQt3PUIfoiMNmsjVz+n2?=
 =?us-ascii?Q?aZBkpSvdD23O78VHTmKyGenftQV10Wgs+MbeTMnALjrXhLV9zh7gcfwmLRR7?=
 =?us-ascii?Q?j8o8Nw4KYtxoRQVK9+kO5tMPorWroyvadQc08eAkkgtd3rVFzQNLIVoKvOch?=
 =?us-ascii?Q?9V1k9Sj4PYHXHyPw2PQpxw7+7Gms61wntDg7y0OGxWteSoJCtnHNaxdBy7mT?=
 =?us-ascii?Q?EXjBAd87R6MlRIc2Bxg9qk3eI/26d0AsFHt62uepqhGvLmLWtXqb/d++eRjz?=
 =?us-ascii?Q?1Rt8U29XkQpdpPV6BQ3vo+6xlA4AfSiHbc7l4IDmxQ6lHC9Pwohn/jqkzQ+o?=
 =?us-ascii?Q?hpB7ixOZkpF8D+ohXDellNRrCcfsj9uNLPVLtijdXD4ntyRcj2DmUXfmEXCA?=
 =?us-ascii?Q?5W0oP7PXlHs22sxwi4hlgvgUW1UBtmr4lvP4k7qNT3YDvvncwx2hj9ZCxoN2?=
 =?us-ascii?Q?vDx43hor1ZASY5rgCLXqoZ55B+b/kccSuXT3Z5imHgHyvfHyNgNQKJuJTTFS?=
 =?us-ascii?Q?WO0uqWsm2YQ1JOllC/EV+4qrIzVmNciIro0DE5a5RJ+A7VxK/mimLmxsr+Cb?=
 =?us-ascii?Q?IQESS7x7p53lpPQJJ3ZTTgoEObj0L8a1WMw9C6ZlQhg+Eg7Np+v05uzkwJ0X?=
 =?us-ascii?Q?3eJ65CkASITBexm6fSMcOxWdQgKjRb2Cor97Ff+LR4oLPUvDxwlvNCbKDaUJ?=
 =?us-ascii?Q?zRUMtD38zrqcUGuqzuQg/AGJmL0445BuWMwCbnCfckt4XmtKihYNVB2Li5nr?=
 =?us-ascii?Q?vbStKk7UmTDQVex3xYr4ewLv0fqk9XIXD9PEuk3fPRoeAMrxEzO2g9MGhDtD?=
 =?us-ascii?Q?TB7fhBqDOqcuqnQ4sKcgCworIKcxZRyRbKK9PdByTx+5taXlkQrFq0WiLa5k?=
 =?us-ascii?Q?WpmLo2fEQhVKgT5PnwLAEJrdyLhQuxqyz9by/iIZj+VMYHxFW+mlLJktHROP?=
 =?us-ascii?Q?8KP8sE1IC1EQLv3GzxDmBPm9OKHF8lQ7zBA+3Nme6GZXpicsHHe8Stt6w5d6?=
 =?us-ascii?Q?PhBI8sLj6+fuVSp9tuxVRibbLyEwjOJUful20UTi7lkj1l5c/T9vCoef6yef?=
 =?us-ascii?Q?Riw/1U70WXmjZBeBY+2SqtnmLF/obv+YWrDBLWTfePLrHT3B+7oW8o3BgkE5?=
 =?us-ascii?Q?tV+KWs6IeRJYbV4IgXXeoku3NQT+3eQhjg/qMs5gWPaLYf6Tp4KasEE7G67P?=
 =?us-ascii?Q?5nss3QNNPhq3Y+w0h4eeI0iQpd5Upffb2cY5xyjP5JIAY7AVRwvS/vWSg+/y?=
 =?us-ascii?Q?x4Pp/Er/qIBmXqbu3AX5bCMIhzfwBnTQHqLvYUuSk7wA92RkeJrOscofeARd?=
 =?us-ascii?Q?Ch8qG3X6ENml8DV0nkMYNGC7T71zjM05L9n+mZO+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b4c953-871b-42ed-8e43-08dbe4316ad7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 10:15:10.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mb+j2ZsdPVTcJ+TEkrCjbcXzfoRpYyTK+7yiTkTph8BzGzpy+YZUVi3jXrS7XMg7yPIfEJf7e2FLuQ28UPjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
X-OriginatorOrg: intel.com

On Wed, Nov 08, 2023 at 10:29:52AM -0800, Xin Li wrote:
>Set injected-event data when injecting a #PF, #DB, or #NM caused
>by extended feature disable using FRED event delivery, and save
>original-event data for being used as injected-event data.
>
>Unlike IDT using some extra CPU register as part of an event
>context, e.g., %cr2 for #PF, FRED saves a complete event context
>in its stack frame, e.g., FRED saves the faulting linear address
>of a #PF into the event data field defined in its stack frame.
>
>Thus a new VMX control field called injected-event data is added
>to provide the event data that will be pushed into a FRED stack
>frame for VM entries that inject an event using FRED event delivery.
>In addition, a new VM exit information field called original-event
>data is added to store the event data that would have saved into a
>FRED stack frame for VM exits that occur during FRED event delivery.
>After such a VM exit is handled to allow the original-event to be
>delivered, the data in the original-event data VMCS field needs to
>be set into the injected-event data VMCS field for the injection of
>the original event.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/include/asm/vmx.h |  4 ++
> arch/x86/kvm/vmx/vmx.c     | 84 +++++++++++++++++++++++++++++++++++---
> arch/x86/kvm/x86.c         | 10 ++++-
> 3 files changed, 91 insertions(+), 7 deletions(-)
>
>diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>index d54a1a1057b0..97729248e844 100644
>--- a/arch/x86/include/asm/vmx.h
>+++ b/arch/x86/include/asm/vmx.h
>@@ -253,8 +253,12 @@ enum vmcs_field {
> 	PID_POINTER_TABLE_HIGH		= 0x00002043,
> 	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
> 	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
>+	INJECTED_EVENT_DATA		= 0x00002052,
>+	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
> 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
> 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
>+	ORIGINAL_EVENT_DATA		= 0x00002404,
>+	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,
> 	VMCS_LINK_POINTER               = 0x00002800,
> 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
> 	GUEST_IA32_DEBUGCTL             = 0x00002802,
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 58d01e845804..67fd4a56d031 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1880,9 +1880,30 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
> 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
> 			     vmx->vcpu.arch.event_exit_inst_len);
> 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
>-	} else
>+	} else {
> 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
> 
>+		if (kvm_is_fred_enabled(vcpu)) {
>+			u64 event_data = 0;
>+
>+			if (is_debug(intr_info))
>+				/*
>+				 * Compared to DR6, FRED #DB event data saved on
>+				 * the stack frame have bits 4 ~ 11 and 16 ~ 31
>+				 * inverted, i.e.,
>+				 *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
>+				 */
>+				event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
>+			else if (is_page_fault(intr_info))
>+				event_data = vcpu->arch.cr2;
>+			else if (is_nm_fault(intr_info) &&
>+				 vcpu->arch.guest_fpu.fpstate->xfd)

does this necessarily mean the #NM is caused by XFD?

>+				event_data = vcpu->arch.guest_fpu.xfd_err;
>+
>+			vmcs_write64(INJECTED_EVENT_DATA, event_data);
>+		}
>+	}
>+
> 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
> 
> 	vmx_clear_hlt(vcpu);
>@@ -7226,7 +7247,8 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
> static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
> 				      u32 idt_vectoring_info,
> 				      int instr_len_field,
>-				      int error_code_field)
>+				      int error_code_field,
>+				      int event_data_field)

event_data_field is used to indicate whether this is a "cancel". I may think it is
better to simply use a boolean e.g., bool cancel.


> {
> 	u8 vector;
> 	int type;
>@@ -7260,6 +7282,37 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
> 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
> 		fallthrough;
> 	case INTR_TYPE_HARD_EXCEPTION:
>+		if (kvm_is_fred_enabled(vcpu) && event_data_field) {
>+			/*
>+			 * Save original-event data for being used as injected-event data.
>+			 */

Looks we also expect CPU will update CR2/DR6/XFD_ERR. this hunk looks to me just a paranoid
check to ensure the cpu works as expected. if that's the case, I suggest documenting it
a bit in the comment.

>+			u64 event_data = vmcs_read64(event_data_field);
>+
>+			switch (vector) {
>+			case DB_VECTOR:
>+				get_debugreg(vcpu->arch.dr6, 6);
>+				WARN_ON(vcpu->arch.dr6 != (event_data ^ DR6_RESERVED));
>+				vcpu->arch.dr6 = event_data ^ DR6_RESERVED;
>+				break;
>+			case NM_VECTOR:
>+				if (vcpu->arch.guest_fpu.fpstate->xfd) {
>+					rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
>+					WARN_ON(vcpu->arch.guest_fpu.xfd_err != event_data);
>+					vcpu->arch.guest_fpu.xfd_err = event_data;
>+				} else {
>+					WARN_ON(event_data != 0);
>+				}
>+				break;
>+			case PF_VECTOR:
>+				WARN_ON(vcpu->arch.cr2 != event_data);
>+				vcpu->arch.cr2 = event_data;
>+				break;
>+			default:
>+				WARN_ON(event_data != 0);

I am not sure if this WARN_ON() can be triggeded by nested VMX. It is
legitimate for L1 VMM to inject any event w/ an event_data.

FRED spec says:

Section 5.2.1 specifies the event data that FRED event delivery of certain events saves
on the stack. When FRED event delivery is used for an event injected by VM entry, the
event data saved is the value of the injected-event-data field in the VMCS. This value is
used instead of what is specified in Section 5.2.1 and is done for __ALL__ injected events
using FRED event delivery


>+				break;
>+			}
>+		}
>+
> 		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
> 			u32 err = vmcs_read32(error_code_field);
> 			kvm_requeue_exception_e(vcpu, vector, err);
>@@ -7279,9 +7332,11 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
> 
> static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
> {
>-	__vmx_complete_interrupts(&vmx->vcpu, vmx->idt_vectoring_info,
>+	__vmx_complete_interrupts(&vmx->vcpu,
>+				  vmx->idt_vectoring_info,
> 				  VM_EXIT_INSTRUCTION_LEN,
>-				  IDT_VECTORING_ERROR_CODE);
>+				  IDT_VECTORING_ERROR_CODE,
>+				  ORIGINAL_EVENT_DATA);
> }
> 
> static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
>@@ -7289,7 +7344,8 @@ static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
> 	__vmx_complete_interrupts(vcpu,
> 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
> 				  VM_ENTRY_INSTRUCTION_LEN,
>-				  VM_ENTRY_EXCEPTION_ERROR_CODE);
>+				  VM_ENTRY_EXCEPTION_ERROR_CODE,
>+				  0);
> 
> 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);
> }

