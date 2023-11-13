Return-Path: <linux-kselftest+bounces-40-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CC7E954C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 04:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D612F1C209CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC88493;
	Mon, 13 Nov 2023 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5lTXLyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE5881E;
	Mon, 13 Nov 2023 03:04:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF481704;
	Sun, 12 Nov 2023 19:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699844691; x=1731380691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kmmIQa8qQV5gq38CilEc/h4Y37TeZbNo+ti9f9vYQUw=;
  b=U5lTXLyp8ysJUnRxMZe1Fh5LVzUCnbfLw5ppPHzG82aL31jjOK/34rcu
   t5l7R+H+u5OUpf5HcaYVD7+b/9oI6Y/8EFTw9wrRiXhvM1rIJLSm1ZOia
   kW6gU/A/rBT2yGAjGBhKsjE6hY3vDlrZeDG+rtA/elE8aWCwDeC6X7OUP
   Rs9WYlvfulxmFm5nPZ467Ir3x/iKuQBiCzuEn4acHkeRiLSIEN/FiCr/k
   3Lg39irGYcnwZoXSysE4kk518RVTqqGJB0gcQMRX9FNT9sdB8xH+oPBzI
   BTiA3XOBfZTkTTnEXTtipCKqojXlMbpuMF4/SE9Fs8SZRETL+CQ5lLYFY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="393236374"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="393236374"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 19:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="767785558"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="767785558"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 19:04:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:04:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:04:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 19:04:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 19:04:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+cF+GJe49uEs3oyzNcJFHScghkinlOVOpur2E4r39BeyHsGi6Yya1PQg6DWyJbU6eIZCTnMYB1dK2J5l9bfWHc4HR/1tPlvhKaBS21lDhv8ZmRdzpC0edoNH5f3oscnOE0nHKuDIShPbeau5AEos+alKkhDv1ZwTbIB0R5jiiqee5dzOJgWDUS2byKK4ePjT2aQlzV/ykGtGHGAQ0TbNeSnM9p7xGgn8DgqZArQcFA23axfSqc+0d9gHzwI/5KnhPgYcdbF+Eoy1lmDRCQJFaZBoC3hYu4SwrN6ER42pACFqri9pkbrWzuHQIHRM+eh5DcDFMm7UER1y/LkeTu4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIWvVcUbfALKouYT8kYtWBulDvz2UQLzUPRCFs2f8j0=;
 b=gWUtTmeKB3qvFeGuaNWPOQ+2AY96k0fqk0/A1nlaVugEWZfAr71z+tX+nf4QtpN2mTCGkhLig0eBq85oaxW2t1iAOY93IMxyITw19T++Lszjq4oxYBsifqiwb/ECKOvXErkAJolPH20+fHjpEVp6ebm3i6Hy6w+uyzxyK6kFos1eQI6QWfn0t3Rs4OyhAHgCMO/AEVgjMo5rrrwI2fk/042Uusmlpibtvu097REjdp5T59t99DGe5NLKbUuo7TafSwF5IlByBnoX00SVNjsXEVoIFCgK78ux7HAcaqs9dYHRyvtbTack4P2JdHF+nthEnku9zpKsb2cZaRL4OM6ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL1PR11MB5511.namprd11.prod.outlook.com (2603:10b6:208:317::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:04:46 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 03:04:46 +0000
Date: Mon, 13 Nov 2023 11:04:32 +0800
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
Subject: Re: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Message-ID: <ZVGSQHdt39vwkeRh@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-9-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-9-xin3.li@intel.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL1PR11MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 74779467-cf8b-4e71-8d52-08dbe3f54a6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh5blXHagZeRCsp6R0AsiIKzAMiEjOSm3MN7D63uQJnrghbPAplxaIQUNRXgL8uVTqNNF1eWi5whdApgG1IZ7UaB0fxvdX0vCPacbfn2nxxllldOm900XhbTNJZKqpZnhhzC5VhTLmPxK+byhp2c1qblP10h+nw+MtDIWaPCDS266YxD02vc5V4mQQeg52R79PbpmKAFlho2bWCtm8rTGFfjgUMn68KmKIHvC7CdAGYgIWZ+CGB2PpOaS0oC0uwp6hEaNGDQnzKrvYGQLdmvK5jZ1ST1gNNEH5IlbR5eEN49QTziSLOzHU0PTXL/gHnG0qGGUO0RaJPGE8OCbX41mJJC46wmTE6SfSIDuXTMKqT0U+8S5DAHJEPiaRzRSnk54R3GH75+Ny8xn3zk3q1oOpZ5Zi7Lqi2gPaD1cmLaBvIiTzhO0OdPVdLVdDLRzFb9mzwJgrmoxwP3MP+ZJPUlosibJl5YKrW5ZjAsuvYy4J7je7cf4uUoyucy49LVipZGDlPNlKMAO5Ws1uQQU0PIDxZCa4IE9AfvmBXlJFK3zvSU62zvHGsfmxLDgjVDuyIK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(6666004)(82960400001)(86362001)(478600001)(26005)(9686003)(33716001)(6506007)(6512007)(6486002)(83380400001)(6862004)(4326008)(8676002)(8936002)(44832011)(6636002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7YT7g/U3twAjgBc511GwHhz3AzWZcCbIu72SMskLihuRZwmGsasS0XZ2U4m?=
 =?us-ascii?Q?LFacukZ+YCiWGxH+8ty3HI9iZCSnrKS0koInLiCXUvs5A7jrcBW6Pj4FcbUJ?=
 =?us-ascii?Q?WWaGCdJwbswhLJcPptIaT4kPgDU+XqYAi6nA0o471SLuhckgT3/imblcTqdp?=
 =?us-ascii?Q?dVkEiw4mO6IEWmMr4A1Pc1xkgRAsx5MTm0WH8eWEOp1WIcnya1BR7ihWAr62?=
 =?us-ascii?Q?J/vu+f1LQLcAY67y/POdCy4ouVm372pSthBMsq5D6E9E6qIWunnlPXbCB04f?=
 =?us-ascii?Q?8dpQNGqhjKabgcIkZzbv66OT2HVLlKreOnUZ5r2YnvMiObyy8WaG+OK0Wb1Z?=
 =?us-ascii?Q?W85/YDmEXF2lW4sDLfJ/cMIAlfVbUwhbQnJ9J4LCZRkUvBClHrw7T8BD1w1X?=
 =?us-ascii?Q?Igb27RixUkwmzlm8FR5LGOtiJat7DH8s3gjBM8778QiWvw9J4A4ds8XZs/dN?=
 =?us-ascii?Q?HEFtEByRz7CQqqIDGpl45hSWcMNdB6RmxXbhLu+ByoGIkXGQQBiJ3Kdv3PT5?=
 =?us-ascii?Q?mcz2hFerfl5HVBm7nvbBe3gCgseXCeRhm5NDoM26X03+tvXHJMatJOZO1t8G?=
 =?us-ascii?Q?+jcptAIOCivEkzEQaDTLEdHWYPrgNLlCHuOZ7ucqoo+K64FGCzGpTPwBw69P?=
 =?us-ascii?Q?x06whw3gl93Airo/XAPw4r3aFfR0VtyQQLiMVt6o5i3bDUYfFjx9XydiRhib?=
 =?us-ascii?Q?MY4fpbhlMABW5GIzUi8HXwe2Wn+iVAFP+purPdgXrnuaTlS90uR8x55z/Xcz?=
 =?us-ascii?Q?k0OV/SPTnLtxdvWE+RM86nAXFibQ137yiCQFPanUMIoCuA8fYlM5ygRs429M?=
 =?us-ascii?Q?2nqO3rGKq1+2N85yS1aftya72si1Ixj2bO8M7KEAZcJjIY+eB+v6VwsNRDIh?=
 =?us-ascii?Q?d6157UQGKHc7iK+GEovSMMMvFYp23d2JAaXp26ArtzmhmhflH6DF1aaQwUCa?=
 =?us-ascii?Q?f5l5KxDqDkdvzsuXPEh7FfnqRwuHUDglb2ClHIYd0wzN4Xd1PSIO53StaKCL?=
 =?us-ascii?Q?H5voSEe9WmPxKl1EzPWCBiFpYnfN1I8XXN8enxzBpf7w1UZJfPBjwW1MenVI?=
 =?us-ascii?Q?9tmbYmG2fpJK5Q+rsvBoLmv6agg/hxWDHLLEVzv0DQOVAiJBAaoNR2h4Ey5M?=
 =?us-ascii?Q?sybH+cWMGKIfUaLkZzqA+8bDKHhf9Dnpnp1EH73V/8L6+dknmpv2fY3/02FK?=
 =?us-ascii?Q?TDXKj+AC/4D/lAJT9j2lAWD5vdtFDn5n7RDc7vSp7ig/03+v6k5aCKt7RCla?=
 =?us-ascii?Q?iK1msWeWFYlcsQsA6L3Yb1YNxwZyZrSWJwNbNOg4AYArktNnnMTiri5oqHo+?=
 =?us-ascii?Q?suwzOafVTG90uUohGq2GBPCkvvx4wAgIGebw44yPPMUQ6Rx9bvc16HBrPQ0S?=
 =?us-ascii?Q?SjbOE4JIO1yjVF33cxrlo5QVvXQRTEcrwoJ11MyxergfVui28D+ZAUrKPu0a?=
 =?us-ascii?Q?PRd86I15QJAvofB8AAKllfnGzm7lDGRZUgvM97u0B4XfW2M4CgOYbMiCF6C9?=
 =?us-ascii?Q?4glhWjvdu20+yJYxE4ErhT1n1bnGoEMwjLmCNqerXAKh1iX/qpOxMgZrTLnh?=
 =?us-ascii?Q?44kqpAI3pybLhOmeSgsQpQ87EmuAK/jdcxbOUng/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74779467-cf8b-4e71-8d52-08dbe3f54a6d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:04:46.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwjOVRNMeNntnk7xFh9EDFK3mx2u1bOoca9SG4lKCRNqNNM1V6GvX3s1OX/+L0mFt2OQ7bXM3AbtuPc/e48x7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5511
X-OriginatorOrg: intel.com

On Wed, Nov 08, 2023 at 10:29:48AM -0800, Xin Li wrote:
>Initialize host VMCS FRED fields with host FRED MSRs' value and
>guest VMCS FRED fields to 0.
>
>FRED CPU states are managed in 9 new FRED MSRs, as well as a few
>existing CPU registers and MSRs, e.g., CR4.FRED.  To support FRED
>context management, new VMCS fields corresponding to most of FRED
>CPU state MSRs are added to both the host-state and guest-state
>areas of VMCS.
>
>Specifically no VMCS fields are added for FRED RSP0 and SSP0 MSRs,
>because the 2 FRED MSRs are used during ring 3 event delivery only,
>thus KVM, running on ring 0, can run safely even with guest FRED
>RSP0 and SSP0.  It can be deferred to load host FRED RSP0 and SSP0
>until before returning to user level.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/include/asm/vmx.h | 16 ++++++++++++++++
> arch/x86/kvm/vmx/vmx.c     | 32 ++++++++++++++++++++++++++++++++
> 2 files changed, 48 insertions(+)
>
>diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>index 41796a733bc9..d54a1a1057b0 100644
>--- a/arch/x86/include/asm/vmx.h
>+++ b/arch/x86/include/asm/vmx.h
>@@ -277,12 +277,28 @@ enum vmcs_field {
> 	GUEST_BNDCFGS_HIGH              = 0x00002813,
> 	GUEST_IA32_RTIT_CTL		= 0x00002814,
> 	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
>+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
>+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
>+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
>+	GUEST_IA32_FRED_RSP3		= 0x00002820,
>+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
>+	GUEST_IA32_FRED_SSP1		= 0x00002824,
>+	GUEST_IA32_FRED_SSP2		= 0x00002826,
>+	GUEST_IA32_FRED_SSP3		= 0x00002828,
> 	HOST_IA32_PAT			= 0x00002c00,
> 	HOST_IA32_PAT_HIGH		= 0x00002c01,
> 	HOST_IA32_EFER			= 0x00002c02,
> 	HOST_IA32_EFER_HIGH		= 0x00002c03,
> 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
> 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
>+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
>+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
>+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
>+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
>+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
>+	HOST_IA32_FRED_SSP1		= 0x00002c12,
>+	HOST_IA32_FRED_SSP2		= 0x00002c14,
>+	HOST_IA32_FRED_SSP3		= 0x00002c16,
> 	PIN_BASED_VM_EXEC_CONTROL       = 0x00004000,
> 	CPU_BASED_VM_EXEC_CONTROL       = 0x00004002,
> 	EXCEPTION_BITMAP                = 0x00004004,
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 327e052d90c1..41772ecdd368 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1477,6 +1477,18 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
> 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
> 		}
> 
>+#ifdef CONFIG_X86_64
>+		/* Per-CPU FRED MSRs */
>+		if (cpu_feature_enabled(X86_FEATURE_FRED)) {

how about kvm_cpu_cap_has()? to decouple KVM's capability to virtualize a feature
and host's enabling a feature.

>+			vmcs_write64(HOST_IA32_FRED_RSP1, read_msr(MSR_IA32_FRED_RSP1));
>+			vmcs_write64(HOST_IA32_FRED_RSP2, read_msr(MSR_IA32_FRED_RSP2));
>+			vmcs_write64(HOST_IA32_FRED_RSP3, read_msr(MSR_IA32_FRED_RSP3));
>+			vmcs_write64(HOST_IA32_FRED_SSP1, read_msr(MSR_IA32_FRED_SSP1));
>+			vmcs_write64(HOST_IA32_FRED_SSP2, read_msr(MSR_IA32_FRED_SSP2));
>+			vmcs_write64(HOST_IA32_FRED_SSP3, read_msr(MSR_IA32_FRED_SSP3));
>+		}
>+#endif

why is this hunk enclosed in #ifdef CONFIG_X86_64 while the one below isn't?

>+
> 		vmx->loaded_vmcs->cpu = cpu;
> 	}
> }
>@@ -4375,6 +4387,15 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
> 
> 	if (cpu_has_load_ia32_efer())
> 		vmcs_write64(HOST_IA32_EFER, host_efer);
>+
>+	/*
>+	 * FRED MSRs are per-cpu, however FRED CONFIG and STKLVLS MSRs
>+	 * are the same on all CPUs, thus they are initialized here.
>+	 */
>+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>+		vmcs_write64(HOST_IA32_FRED_CONFIG, read_msr(MSR_IA32_FRED_CONFIG));
>+		vmcs_write64(HOST_IA32_FRED_STKLVLS, read_msr(MSR_IA32_FRED_STKLVLS));
>+	}
> }
> 
> void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
>@@ -4936,6 +4957,17 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> 	vmcs_writel(GUEST_IDTR_BASE, 0);
> 	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
> 
>+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
>+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
>+	}
>+

move this hunk to __vmx_vcpu_reset() because FRED spec says

"INIT does not change the value of the new MSRs."

> 	vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
> 	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
> 	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS, 0);
>-- 
>2.42.0
>
>

