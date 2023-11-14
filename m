Return-Path: <linux-kselftest+bounces-74-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C17EAAF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09240B20ABA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF511CBA;
	Tue, 14 Nov 2023 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PICG4Nix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9711C8C;
	Tue, 14 Nov 2023 07:40:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02119E;
	Mon, 13 Nov 2023 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699947625; x=1731483625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i/ZO/mVlUxd5UMF+JzO1mFYPNBs+DllmILBb79HC11s=;
  b=PICG4NixOFoMi3rPk0XMC0qCNUJEsqfI0uQY7+7G1f208BYQBhJwD6U9
   pYp8VUeAQm3VPmhcdMJEWOQeMTe/Df9oWsOBrjmqOb4OSZGwmlZBAQtbp
   wKpM3km0tGq9WPhuEH9jU0xRG337iQiLD7uR+eskpwsiXE1FijiGW1kvC
   WS/XJV+j0rJ06PgD2RlsRX77JcgW94vlizWIndrGdMYfxf28t0Tn8CuF7
   0TBOrgitSTuZOMtX5HoPxlLsW1gQ59FA/GHRKiAl+dTBm+jPqLwcJx1Fh
   eoiAc+trKBNO8SJnRakt7Dip8GbBIz3ZY56w0+Ne+JD5ngqpartA3n/3u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3657142"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="3657142"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12716094"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 23:40:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:40:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:40:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 23:40:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 23:40:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WquFUCOv1ZIzoQN7tlQC2mPna5UVaOxLn0uze6NUYa7V4S8EWaEXje5gC7SuXOw3bZYhVEmOcAopM4mHagOPo9q/2m5O1kcRs53/4g/w12/XNx0TbC+vs8Md7HEt5fJsJiuDpjlJkpBTVLDe1WKa2yqtv2KXlAXlAmj2/9bwSNbooim4VzhD8gZ3oZybxMGDhszMqr2lJRzFEPBvAot2ONXN90jg3FiuZ9pSd6HkkuGq78F7XQyTjXbWux3uJJqL0pgHDY+Lw80iHmqU5lMFQFre1iFtZYGaKsT67wSFYt5IZPTHhelhJxRAzYxR7QQG4aGNSXe4eOFygCSwrTC7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc68VVmMUaLTkf8cNDLab6eQe42N1Hh0EQzXEvl1V5I=;
 b=enGwuTXrZPHrh0A9e5gi6yeNNjOmq9DU+4no8gSWeQr5DLensX6FYTAqzdi+D9jbws/fm5lr7VDpF7Tfy1mrUa670dEjjDsbajqu68CuJ2V19a6dDznjGGtVCr/Uil+c5r1O08wZM01fG2/VDwYOeQt52M95ukCCmyiQj1T1mjt1WJ7aE//09jiKMHHbys0LfSZR4OtM8Z7AQnFzGy58Ttz7bfDOYv4uJ+n3huZ+mxqc9jBPO/qykSV19Cyl6T7bAApPcLzOO2NYZoOhL+wnKOX/Iit5MRcykeS0b+4E15fXMqlK5ugd73We1mwdQ8xXLZzvdFYqShE8OrIeOszZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 07:40:20 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 07:40:20 +0000
Date: Tue, 14 Nov 2023 15:40:06 +0800
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
Subject: Re: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Message-ID: <ZVMkVmBPVfaMjDTL@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-14-xin3.li@intel.com>
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: ba340ff2-8ce5-4dd8-a2ca-08dbe4e4f3a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uosy1tb9R0+ixVcw48219CGLX4iTpjjAjDULFQZYDoqod7wSkzz4fzsJlazpl/nHUv6s2Hwy87hw5Jckt92iYPGL59/PypVc3Floi0LN+/eQt67ZKDI0eIfBXMXHJ8d9lrxkki5ifTVkwPUp78R+Tys/KZPysW99EljYyvHKB3oagxiIqdD29HoH+/vc4mNu2fsKxDoH+Qs6Cv8CvplB6qTSvwNqQKLeevvGwvMhhC0gsUyiiAntw+ubTaIbVKK4O41hm4HFSHFHBVlcz/yk72P8me6YDAfV3GMZj1thotAEmLn4cxaYdknebef+N4P7UZJRnCV26fPBy6+LzlTELe2aVFDZ/VGdtN0On0AG3c7bvbypehWBdGw1o4keQPruB71szCNT0EVTdvCtg47uF+9FXE43tn7UKc8dbUMWRm4lHmKQ+z6hZ385PxIDxt4hv4rb1NBr1VP7ch3wSSDfhn3D+UuTg5OlXtxK1UMWJmFS4muvOt+spAr2OgfyOErfKtThdfbXAKMB/lKJM5BokoBMJQ+kPaINd7V32UJyBZPhbWzuWuUKaOZ37cWovXCh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(66476007)(66946007)(66556008)(86362001)(82960400001)(6512007)(83380400001)(9686003)(6636002)(6506007)(7416002)(6666004)(33716001)(2906002)(41300700001)(4744005)(316002)(478600001)(6486002)(5660300002)(8936002)(6862004)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5R/wpIjJc/6QlUW0B3RN9ag4DMQaRjk9SPeBQ4uDeM0145F2tF7gz5W1qN24?=
 =?us-ascii?Q?HVG8dXXKyUsz1/pAiidpeuI1Iu78opv/HctmuBCSNfoSAhqFYuDkMqkyF7zz?=
 =?us-ascii?Q?cYAtr6wIW55JfrN+raqObGfEDDfMkYi2bf/DJeGs+p0BEVaVYuprj7HG6MTj?=
 =?us-ascii?Q?+MT3mgMp4qcmue66IPBKU0SrL2DPq+3+ETRNLlHwWdjdENIy2c8UMvQt4wJj?=
 =?us-ascii?Q?2PcfVIGtomW+tIeBC3GiZTvYD/AiAxWlOV188daHRSjpPdwAAEPazyxWRBdx?=
 =?us-ascii?Q?kjGOGSGJZx6spHm0/q3r3rGdnzzFAL0zd8nggOpyF+dsJUKgBMaEUoLuMLUw?=
 =?us-ascii?Q?Hbej/jqklCz6CKSjpERqKPKw+HA+H5cE8woRxtyoqie5VMDjcaKq0DSVwNwc?=
 =?us-ascii?Q?5McDGmetp0U9WDhQ+6OnAbRaQM1k+uXBdCXhG7htZ1kO/fqTAhI8ID7OPJce?=
 =?us-ascii?Q?fFvAAPOfHKKdgtHm2j4iJ8goUFDDaMqMjCK0QqYaJfR1DbOyzzpqI9n4yv04?=
 =?us-ascii?Q?6luu3+7Gq1ig8ih9E6/k77nPcqp9ZsOZaEVeykVjNG1oCaLo96icSRYdPw0r?=
 =?us-ascii?Q?aX9ytGzsefQljfHW21XNokPynZovUFnMnn0OWbiefGtbSQ0hR1nEWbn2O44q?=
 =?us-ascii?Q?xrFvTPcr1I5sbo+9KdypeRR7VQWoqGZ5wuDCokTgLyoKrI4Gj4E+W8Yrh+ec?=
 =?us-ascii?Q?02C80rbcCY/QQEJ7gHXVwDLH3SdUkgVgUPYrDe6yE8S24WudgRPQ1jWJh1Ns?=
 =?us-ascii?Q?mXNrbPCJBKqEMQQzbVl6auPkSNTJeoNbKxAqSNKdwevxguBLqyf6CdyDDenD?=
 =?us-ascii?Q?aYESAKl73JqV4PF+1Nu7IngYhB5XYDa77mMioP09FxYFqK/J/8TRQFyXkqrY?=
 =?us-ascii?Q?GvCHOhVoXsrl77/MU9+p9hiDsMi+XorxPEmLaVO9fnGxJMhqV0UbkccHPdkg?=
 =?us-ascii?Q?tywJ8rZpnIsewLvvQevM39iab+eqR5TFv9GscmhIgclyO5eQuOAEeXXm6ZjH?=
 =?us-ascii?Q?27+pFZESYZNq181mTrcnG0urb637di6+X5D35uJIABNrCkVcdg/PUj/X7W/t?=
 =?us-ascii?Q?FnkCwmZ8NVPnrm49gfCbySYsaKzulpsI25ju855Ljc25G2gXCuDv6851nTqL?=
 =?us-ascii?Q?d836bE68HH1n0EtrqsgzsQn6A9LKAziJnKXyWPnZNJI7xfK5zXvAYasHDOvs?=
 =?us-ascii?Q?b7g4cZayezXaGa0eNpABCQGCDeeXZN58h06np8iiKy5iL83H2v9xGddeen+y?=
 =?us-ascii?Q?NQN9qkCm+WtdR5Yugzk7+2NI1D8amDeYOkHwyTcc3Tvvc/sPz/vApiiQe8/P?=
 =?us-ascii?Q?8Hw2LDglx5c7Av7cN+EMcAzqOLwAuhICk5edf1IaQ0FZGFyIROqyHouqFnvj?=
 =?us-ascii?Q?xN9S3+y5C/sZhZkw6UTYpahh97wkGORPw50LAz6ZZAvg+OhIe9rB4fERxjtW?=
 =?us-ascii?Q?doz/6+qhz8tXUp+aG0zA6Tpm5wYRyRTM5FTkgYyRDp6iAx1VFQfHUBnLZaMp?=
 =?us-ascii?Q?yi0EG36kBGsOKnUWPYTD0CKnykbnyo4n/ER+P15lNieFZ1jqhRHrBAEZfBMM?=
 =?us-ascii?Q?FIiIIywQU02AyEuue1Umkmw5D0uWo5zQ31kz5Wqy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba340ff2-8ce5-4dd8-a2ca-08dbe4e4f3a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:40:19.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB8Q70lXuVx9JPWdMdgqWSmHafNzn2WRIMsxJmfGj44SU1/uRxtx7IYlVC2i8pre/6Ph/Yc9InGfS0t4aazbdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

> 	/* Require Write-Back (WB) memory type for VMCS accesses. */
>@@ -7313,11 +7328,12 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
> 			}
> 		}
> 
>-		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
>-			u32 err = vmcs_read32(error_code_field);
>-			kvm_requeue_exception_e(vcpu, vector, err);
>-		} else
>-			kvm_requeue_exception(vcpu, vector);
>+		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
>+			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field),
>+						idt_vectoring_info & INTR_INFO_NESTED_EXCEPTION_MASK);
>+		else
>+			kvm_requeue_exception(vcpu, vector,
>+					      idt_vectoring_info & INTR_INFO_NESTED_EXCEPTION_MASK);

Exiting-event identification can also have bit 13 set, indicating a nested
exception encountered and caused VM-exit. when reinjecting the exception to
guests, kvm needs to set the "nested" bit, right? I suspect some changes
to e.g., handle_exception_nmi() are needed.

