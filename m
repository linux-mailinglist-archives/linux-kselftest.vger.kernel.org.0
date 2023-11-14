Return-Path: <linux-kselftest+bounces-71-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD77EAA0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 06:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FD6280F83
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 05:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1FC2D0;
	Tue, 14 Nov 2023 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwdjU7gx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD3C14F;
	Tue, 14 Nov 2023 05:17:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5129123;
	Mon, 13 Nov 2023 21:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699939071; x=1731475071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Zw9LPyTKVynhVIlLlX3fBQHAYr62any9lO2+ue4TB8=;
  b=UwdjU7gxZeej5I96BdrPub7xIcys4NM4LRBTeyuBDtK3+iryie6+xqUb
   GVjSZBizNCrlNJbQNk+eCYf+zbEo2yOHRc0O2/3AOuUA5ed4rV6CSYyOc
   v0QlGe4S1mz7zINif7/I+mkp5m6ayFdhsvRQxj6N2tmgf+B1p1PVvhMfm
   GAr2xioFyB/Wjm5jxwdsb6DK0/iyRLF5UV4JnAb1vUCrLbgEZLJ6ZZ8ws
   ZVRTUgS3aQ/gMMyasQe9Q7YL3D25eSM7hQSf/Y2MpwvQAFAYxCekSZsvc
   qC5JTijWBCFmmEdkTh/AsFQP1ebwMlln7t/2o3SBQaEP8HfK/1DDE6ns8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="9223359"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="9223359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 21:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758051752"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="758051752"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 21:17:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 21:17:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 21:17:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 21:17:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrrTag1gg10iiGf2kfhrM9tFWYjoczUQwgK1EDmIl1gio6NTfiDUaa1JrkyNuDU1Xpy3cbgnRRu7dF9wAlRsJstIVJEtJL92bgHSjw+9/fn4EwZdS3I/NVOV1gUaDbU/26a9EVmiz4ZhTeb84orJXMe2aRuzRCQuCk0OkoBUBpfULtB1y6lqTOsJTSo8gvAEDCORguRbhaN3rSg23JdCUQzQJY5cSgGHblqRQS+EL0H/vUK2tlBJR+XQrsViTmHYEXRGw4Ae/Wl2JK7D2cTjwEnDlLWKS2I1eYIxeEEoclv07BayglwOvi8NOEwD+FoLkv7WGv1i/d+oz5ixh78LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYUl1+1EJXwoAUPqFHFsF9y6ep3DsVCZwwH4TuyQEQE=;
 b=RN0AunG2hyhqpVlA0kTRmE0jv4Rd6r4bdvgbvpepTmkNPBJ7EdVrayBZfhy9/lA99jpWToL8GNxS1VkdCFYgCI7QUtGuz399IJT/r5A/ydDvSpoeo/v4D9qoVSS9gBZF6XjWjDdUEIs7Nl4ZM428G31MQN+Pt1Fw3ijcns3zAfQCZH8OqzOBeiHWXLxEkMC3uDw+Xlh6AxcQA8nuqmfXnIeF3l15jEj01fFwV9BO9+/76YTrWwAzTFW6a2T+Xc+aFULZkc507/5Qdw9aQMhgoAWfCX4/9IMaXyBdOOKh8aB9fXPxeRwfRY8MaSjmGC7CIlfGOKuatz8fO46FpKiZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 05:17:46 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 05:17:46 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaEnYNVp8W1/G6UUCgoF/AFks5WLB3o3KAgAGj5fA=
Date: Tue, 14 Nov 2023 05:17:45 +0000
Message-ID: <SA1PR11MB67345297BC929DB49B422D2FA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-10-xin3.li@intel.com> <ZVGcaxYtabZxGt0s@chao-email>
In-Reply-To: <ZVGcaxYtabZxGt0s@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB7309:EE_
x-ms-office365-filtering-correlation-id: 1f7177f5-ff46-4305-88c7-08dbe4d10928
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rkPzlGh/r2oRd2wteq2TiyAm966FcMAjd4AJDKN21Goi7IwrRyxyFOoo8oK3BBgUL9U0fMovD7X9tGs/pDDss3IDHhLPpx+YUbu0Nqme7O4BXjIU6Rzy/vnkF64rNFfUPVwTHKvsjqiAxWe6BGkHfR/YqSDsrGg45FJPtW8ACQj85C7M3cmejtSjtj9W8C/75OITwzyDVE/lxZlQDQPTdEmcceDo1lU3ms3Q5DSXex5WoH3YbPMQyt7ioSx6Kar7BBtqh11b+MsMoBMI/cBbhyJ3qGjQVvVG2yErQnXRkJ3g+YSZ4Mzr2B9zZAAox6+rzZo1WNm4fK0jlWC6T/CRTjgSgdDyOS47E9GXRacBGCEBxb2TshuGk7HbM3v0HNg9LtcoDisM1Vu/4ATMDB5RjMFvdx0ugY0iELuT4zxp2ru+QgcL8nXZ9ca3qFchhzaoCKYMJrux7FnG5J13sD5hG5v1sI/hLC0T90K+VWYaLgV4h2fCf2xlWK3LATu9ETQ3WRpum3WLDCmzRZsDM9XV/zlGOCjddJxRDzOMD0c7WdRpLfBpeUORbT/1CBu2lypO+YaSc7HyQRfutU1IhWdnbt686C37qg4FN4Qve6x7EpNDnfWyxKLaREhY5LlOoFJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(6506007)(5660300002)(86362001)(8676002)(8936002)(7416002)(7696005)(38100700002)(38070700009)(71200400001)(2906002)(478600001)(4744005)(6636002)(66946007)(316002)(76116006)(54906003)(66556008)(64756008)(66476007)(52536014)(55016003)(9686003)(26005)(6862004)(82960400001)(66446008)(122000001)(33656002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGsc1EJyS2lZcPN8KYfQBlSCMGm3KzR4siePoDHYtwDJFY2IxaUE2A3kzSm7?=
 =?us-ascii?Q?/KiFFCEVswB1Ge1orn6bQ4QCtqx2aIIJx7ov90e/2z4QzyGAkfGzhjuAIsUQ?=
 =?us-ascii?Q?9PUVsD2DW+q4Kh5vrTKujhemGFesnq0bfd1GLUBnQNYhbHC/0+mpQjJyxA7s?=
 =?us-ascii?Q?fkZGE1sZz8C0C+EXPr1jM8qQNaRZkelhh23PfedV42YZeiOje8ZBC7zkGBzP?=
 =?us-ascii?Q?eno8Caxy/5a+pyG53FAxPAqUssBiWDcxkn81gpvNK1y5XOw8anRhfpCPIGuY?=
 =?us-ascii?Q?8eM7VH0aBdfq+xNEwu3rNfNlZ13rZgqKiHgXvIZM9ZLgJyIm6crdXRveKuYl?=
 =?us-ascii?Q?IZ8GisZbuETfwhqL8GS+Z+dtaBbKjoEpgcJXyynWtYXie8mduTraRV1nTqL9?=
 =?us-ascii?Q?LcLK8Llbr3EW2uEFvp24A0Cf+S+9j5CS6CRy5LlIHzYBH9Tvpws6Kp60CKwg?=
 =?us-ascii?Q?89c2l9uKrLD7OXzKb5ViQkMPuKwiqZbjci82QXZ4KNzhr2+YPezZolHu+5Rx?=
 =?us-ascii?Q?CC/OfZ6fEU5rhiB2e6aUG0Tlx684suSCUy0skX7hRk1rt2ELJwkyVuf4hotS?=
 =?us-ascii?Q?I9eKzmL9BChAj9/NuQxz9eJGNXE9c9gZqSgvuJDx7qChYKXzl8VxMCvPND0V?=
 =?us-ascii?Q?dcQxMTmbNxlJmHWTl/yefVjbCKVtmAx2ZJhz4T+IvLgUMu9oxZ2bkPQOmwS6?=
 =?us-ascii?Q?E63yG2yzIblUTx7YS7lALN4dciJCHbSnFDA2dc0nhN/DmVN/kX3KB0p/Wo+i?=
 =?us-ascii?Q?TBmRcQLzPiIzpMG1bvzu2HB0gC5DMPheUlvFD2G5T5/9DtV6iANUHXU2jpre?=
 =?us-ascii?Q?UUCKWBQ0SYxhQAE29yYjEF+UsaBNt4oH58NaYBXFizBlyvRGGjhsTW++i2hX?=
 =?us-ascii?Q?sCsmWYv2Eqs7n3kjV8pkyqRfznd1BZKuKxH7fybVYxmE2BPOaoD0Dckc0+k7?=
 =?us-ascii?Q?FoLfYSRKkvIVvY31u5p4QEPFzThwFY6kcBBUahcYIIVbeEJc387kTcoqPMpE?=
 =?us-ascii?Q?ksSKAWuochjOILjQO8iZfImfsFC5XHZSqIiWrHCJLXMd7O1g2zjA5i8jjBp+?=
 =?us-ascii?Q?KC4+QXDogNOZ7Vd0R8q5CAg1vBv1bEVGf+apB0DbPlYGXYPlDfFBo1NtwKCe?=
 =?us-ascii?Q?q5ZGlu/9UKeYslXfDKoS2p0Kx28RRLajRLXzFP6t6SYlC7D7B/W5joJQJyxO?=
 =?us-ascii?Q?qNdfYHxEpw2qNytDqXW7gs8vlC2YweYi39SrgDlI0O1BYE31uUV0HAcQofo8?=
 =?us-ascii?Q?8luTSNWp0GPCtWTZZuivV3Jl5WfwHnGOurqX99db2+HgNUEVRCZd7KSr5v/C?=
 =?us-ascii?Q?gwflhwhiQk3nsVo9HXRqsFz8VAnOsjjs57XzH8LOIiCQMGwbq4j+uDiwS/t1?=
 =?us-ascii?Q?IAfRJclABROBUOnY6hqUUWXL9OQze11YYslXzAPwFcnB7B0lmGWrq3IV04af?=
 =?us-ascii?Q?W5OQx+SYzuOQcmxgFiMyyhC/gHwRi8AXgqFn0EIyg8/x4J9OysqVhFHY8t7r?=
 =?us-ascii?Q?6a9oJrNsKZbplluY+tCgSauphsYtPh38C0fW+9csfqSfTgd1jV4bSJ4hv+4U?=
 =?us-ascii?Q?MwHQAsMVqFl+ufFZBaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7177f5-ff46-4305-88c7-08dbe4d10928
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 05:17:45.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ntlBS2adQSAr3BELimlBoqFBt9hZut0lFlHeFcuLfNl5WCg3e4XKUjoA/cDLW0hC709wuN18scNsgZGEMZzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com

> >+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> >+	    guest_cpuid_has(&vmx->vcpu, X86_FEATURE_FRED)) {
>=20
> IIUC, vmx_prepare_switch_to_host() is called from IRQ-disabled context. u=
sing
> guest_cpuid_has() in this context is not desired, see
> lockdep_assert_irqs_enabled() in cpuid_entry2_find().

Nice catch!

Anyway it's a bad idea to do a search call here, let me find a better way
for all FRED CPUID checks.

> >diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h index
> >f8c02bd37069..328a3447f064 100644
> >--- a/arch/x86/kvm/vmx/vmx.h
> >+++ b/arch/x86/kvm/vmx/vmx.h
> >@@ -276,6 +276,8 @@ struct vcpu_vmx {
> > #ifdef CONFIG_X86_64
> > 	u64		      msr_host_kernel_gs_base;
> > 	u64		      msr_guest_kernel_gs_base;
> >+	u64		      msr_host_fred_rsp0;
> >+	u64		      msr_guest_fred_rsp0;
>=20
> resetting guest fred rsp0 to 0 during vcpu reset is missing.

hmm, I assume it gets the same treatment as guest_kernel_gs_base.

It seems we don't reset guest_kernel_gs_base.  No?

