Return-Path: <linux-kselftest+bounces-8465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A738AB374
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAD7284609
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C312F5A7;
	Fri, 19 Apr 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwDWX/fI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA319F;
	Fri, 19 Apr 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544649; cv=fail; b=H8t4/v15jskpIxMGhcsmGTO8EB3ASmRWXN+lACSbO2iZ7rWXsdaPp71544+8JvSMliEGIsTVtVg5a2sZRpiXfcgZ99bL8qMIQ81ZgwFbB5rjzY/aP0OwJDVkQRogXHrSeA7+wM1bUJrnRAfldUM5rHWhvWjGpTbvBACz8GIqoIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544649; c=relaxed/simple;
	bh=CxuXHyWbWIIY5LognbDkLsBYU67KskSEDAC7/gK3dXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOMH3tjQXbHlSa5cLj6OAu5y5sCBdpo1qoLh+R5mk+QB9G9E/xneD/EXdL6XOxt7AoIgQene1doulwNakPymDqwegBBRAbkhywYXjf7dVR+EgtyyCiyQpm/h/l3FraY09kRP95/RyEyaVxya93PByfW0FnYARF8RB8XzY5GyNEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwDWX/fI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713544648; x=1745080648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CxuXHyWbWIIY5LognbDkLsBYU67KskSEDAC7/gK3dXc=;
  b=MwDWX/fIcoRRoGWypFiITMd/f5O9gRPuEIc9FfAFf+iQ5bCLD9/17SKY
   sF+mvisEA78UXJyJ2dbKcbrLqVF4OW2Z2UYQcFUlTOx7R2DWDlQxXyOYt
   rRf73cv4yBnz3MtLJBBbX69pUpjz7A/lEOgFu5VIWmgdw8OWPKBJ5HutG
   2KzTCtKH9BPZJPFgW4Bc5vLBwBJSIAF+T1/I+Vu7uYDSbyN9pIOImqGLz
   Th5jSEohfTJnJ3zZ9A3D2t8H8G41YtDdDr1BEqxRSsBKJ/o0Tsvi5Yt8w
   KmZGlQWWPifM8mZkolgzk1asEtvzlb3m6L3yNkRDJFRgAy601uIt7wuGG
   w==;
X-CSE-ConnectionGUID: cPdnVtxOSJCJGvYH08frlA==
X-CSE-MsgGUID: kcXkW1MWS7CmIDkXUp2dvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9269605"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9269605"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 09:37:27 -0700
X-CSE-ConnectionGUID: SikrWuEhQt2cRlVFtI/PuQ==
X-CSE-MsgGUID: z19acvIoQ+yc3Xx/UAub0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28202401"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 09:37:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 09:37:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 09:37:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 09:37:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 09:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2iP2nFMLWIJRHM/KaAvri70bt+VofsbBF+5eWU32NsmwIrklwQVCjgrUOGCl4v6ci82Pgp0bEhOND4PRl71Rcmrocw3QY1Wni/UBwwOibvjpyJobfoGZfdoQK56uwbDCAhT/kSm6MmLC1XiFUju8VY8+iAS5/V8eGmGB0Vss5sDb1kILptho7Gj2Tjt3WIsK4tkBUHdiZee9eP1/8EsVotzvA4VO3HcGUcp9pOsFlUFztQSq8fWhlK/dq+7gj9Z3QTC9sebJsfgI9Tl+KNHYk5KDJtbPtp0XvS84CzgV7QEL+h8k6ErI0BgX5DyhmZKX2gMPKQkVILVWSRr5pBj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZFXPeDAz2HRQltCM3Lm1RN2sStLnbOuJBo9VH05JH4=;
 b=deQIqMGdUJ6qWOLCebEa8OSzXuvXbnIfVS2wtOG17BXdxF/o57ZJ4Hfu7jaV8SOyF/funS5Xd2OpIauKhWWuJaiHhjjaLsmQLOFEhinxFxPO9YydU1/aDHvGivZD3deEN7EZrDp8AOp3L33VpSJwWgS2rY3w600mWgAr840YiXruGOu6HWrWOC3FETspLl7pSZBfKIPaQwDqtJFY5lINLo+xb/zIpEla7Q9lMw+2QsYbxCoFRLQarWeWdsKx9RvFga3KPanXt8Go0VtInF9ii9eB3nLGD7RavCc2HSavqlYrnrzgCEVf2S//CmtiQIZkcSbQLZ0ezW5dLfvy1Fqapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB8051.namprd11.prod.outlook.com (2603:10b6:8:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Fri, 19 Apr
 2024 16:37:24 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::1d15:ecf5:e16c:c48e%5]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 16:37:24 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07FwFkwAgAAja6A=
Date: Fri, 19 Apr 2024 16:37:24 +0000
Message-ID: <SA1PR11MB6734AC2442F6615CB3DA7203A80D2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZiJ+RkHDJzalqN05@chao-email>
In-Reply-To: <ZiJ+RkHDJzalqN05@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB8051:EE_
x-ms-office365-filtering-correlation-id: 4200ee6b-5c61-454b-324a-08dc608efdde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ssgc7AbMjmuVybITdFhsm/BP6oKGxKb4S3h+mgcQ75bzfarx5Csxxa3uKnEAaK4qbLB48uGZLBBTdgJP0eVw4jzbj1AXkCS5pMD+NY6bZEkb/K4XFN9wIO3zQCtoWiOMbIA+fmzk+ArtJCnXBtl9vunViedvBhJZNjzTxb7cKXhxrrd/OdsjsA8ZHVeCLjxjnzpBEY8qWQIzRJ1CWsgnbxwlZwyV2FP31I4JdT57BC2lx8EBTjEk3qaCbk2B4pnvq40CgcAUFJVSbgnExPCVtdURu1bse/5o1/f4uEmsmZRbGgifLL1lIoArqcdldLrn5Ze5BYHMTZ7ScQe8hXXepUPsDRejqs969qZlICM7UOOx0oCes2uhwEFHn4LVYF2D0GYq+C5NgCNM3/SiAQRY+7JxCO9J+ivelI1z30zmoz7UCS0tsJqacinwoCTBw3L+dQ925qzY8A3jjrTQ/HPrChfyWSLl8R7KRoED920a3yxtBF/MWnUjqPsA3oY2QUR28hG2nRNcuJnZe56jHSCuJls0uZN66WYl2HiaeMUx1koxKwZkOFEH7rDRGezVxPj4kNZDBl6HlX10j3WMxpANawYpNl4JpC+azIE+ayLdQWm340V/CeO/HJCQu833q+me6AT5bqx8sp29D2XTLSK6CO3fHt/2pvBVtBNYHmzAcaAjc6z788CIEaBfPtLI+RRIX4fsqxI99AFZKPYgTJ47fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jw+syHabGdQG9RaRPwK+NFwlQ6hDzZPkobtCtmL1ZPVJlpYyKKizYJg66br5?=
 =?us-ascii?Q?UTKXkVnBiAk82mBTDliQ+y/DWYuh2kFJtr2J0lTf0og+64gvkTvBe5/Ki5MP?=
 =?us-ascii?Q?dtn6aJYK0ysRe+WUIkyuUp2ob6mObUcIs8oe/lMRiHmAw3wFb2tDqek4i46w?=
 =?us-ascii?Q?S8NKNd1jhOdcr8lf8rrYSHtliLIbF9pP86yoRv166Rc6vd0yKNd3U/AXaqcA?=
 =?us-ascii?Q?IgQUgufZfnIJSYygiTxze0FN4FXAwmwTPq879nIzcI9HPPZNg7Jx24WfVsJm?=
 =?us-ascii?Q?EXbQnEAXTt+9sWdtyCdh0UDpvifZVOu4AheyjZaGvTIw9Y8+o+ZmeHDTW2Sc?=
 =?us-ascii?Q?TYH9tl3Ve4/epDKQPyqeE4JjhyS/k4J4W4ETHFDU62y0AGS6FIJqiz3TyigD?=
 =?us-ascii?Q?NDA8Uyb2K2wPX8lWolrHgGTwtiqB4Wf4QkolJbqjr9Keh35ZB8jsrMkC673/?=
 =?us-ascii?Q?2yBHsum+p90muL1HhXhMsBW2r88Kuar+hictdkqbNYhqwtSFD5QwATQ9QEMw?=
 =?us-ascii?Q?9vyURPUUabiNAmjA8djstTPjJoATIdTz/sC4Nl4bu8ds7z/pJzIcbmhLi+FG?=
 =?us-ascii?Q?duxntDKFphFHXL76JA4uNmJ3d0dMLNPWkCa0MLW7w/y+wPBvdLx3ZSlZumix?=
 =?us-ascii?Q?sWTnb/GZnIjcM3bqP5YMqs2X4QsSAN1vtfHbWFHDHhLoQaviajHvhrysLrl1?=
 =?us-ascii?Q?qPU4nAQmxq/z8MXcmrn5Z8dz6k4beYaUhnNw7Z5cm0dZhhOgnBJA+HVyATPd?=
 =?us-ascii?Q?X7EavX8NP402fRZke6mZ3m6wbROd7sijC3nkHJ0vxcZclrVb4h2zefwb11er?=
 =?us-ascii?Q?oKV0nr/Mvc3lSLTUXoeIQTnk+j59Q0hUyKFort9FfExazhg+qiUZ62vMFm+a?=
 =?us-ascii?Q?UVMU8dCmP0LzLmnBhsexTrezpM8iiypb0t5lVB7vnNnwaoInkgFba+UAnJBu?=
 =?us-ascii?Q?3RStuDzN1k73Nhejgl6apECUzPiEbD72XOIMM9xSNnvNjyJ3OvUHGC5VVKTD?=
 =?us-ascii?Q?mOmTHqDw1oMYVRPfjNDw+KYYPBM9QOYOBRjG2TsLZUdxkPBlf7tXBPQoVqoH?=
 =?us-ascii?Q?f+80e5Mj1zHXmg9RpLkF/9saV3v8kxNl8ACXZakVHRCxLqL821UVW/xilcPu?=
 =?us-ascii?Q?2uL3v+FiT7r2w+m4pih+GJqitoQnW3K3hUcBIChHDCdaUulQBCuURmg5Jqa4?=
 =?us-ascii?Q?QnzddKWQK+6r71F3gtmd4DUCcKZVfzLusMVIfOXaREqS7oNw6/Z09JmLC9sW?=
 =?us-ascii?Q?q/crg619q+bV8soUHnBDzFcmAtdCXrgYcHdNgDn1AGMHTeoi4SazsZTI8noM?=
 =?us-ascii?Q?gv4YEl9KZx7DPYbIV2PuYUPnoJV1SI5cVnKWkvTcWwJQodUnhIT9a6EO7oRQ?=
 =?us-ascii?Q?u9/F6vmc7sdKziNtxn+ASHiyaYVqdV47N/6Ps+PHhDRYt+bi4FQzS/O+UNNJ?=
 =?us-ascii?Q?1otTM5Wv30cxtWJlspc4rBMklDwI6iEhr3wTpLw6CSePtuB0o3cyHudIVXOE?=
 =?us-ascii?Q?KIEbqcqCktjMDgrFDSCFmVAnW6BvwmgcogtmhqjWWj9um8g6NBrMYr1zpOBl?=
 =?us-ascii?Q?GdZjSKvz8ozgsIIAMGTqA60s6vJAv0Z6tsMzx0GJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4200ee6b-5c61-454b-324a-08dc608efdde
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 16:37:24.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MoKENc4arE40Oa4qVGM8RbvW+g7gcYlwcF8rrvAVOzSU2goErfAh1FsfiVcIghTHi1epXkVDAHq6PJvrd2acQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8051
X-OriginatorOrg: intel.com

> >+		if (unlikely(vmx->msr_host_fred_rsp0 =3D=3D 0))
> >+			vmx->msr_host_fred_rsp0 =3D
> read_msr(MSR_IA32_FRED_RSP0);
>=20
> can we just drop this and use "(unsigned long)task_stack_page(current) +
> THREAD_SIZE"
> as host fred rsp0?

I thought about it, however, don't see a strong reason that it's better,
 i.e., is RDMSR slower than reading 'stack' from current task_struct?

>=20
> >+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
>=20
> any reason to not use wrmsrns?

Good call!


> >+	}
> > #else
> > 	savesegment(fs, fs_sel);
> > 	savesegment(gs, gs_sel);
> >@@ -1381,6 +1391,11 @@ static void vmx_prepare_switch_to_host(struct
> vcpu_vmx *vmx)
> > 	invalidate_tss_limit();
> > #ifdef CONFIG_X86_64
> > 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
> >+
> >+	if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
> >+		vmx->msr_guest_fred_rsp0 =3D read_msr(MSR_IA32_FRED_RSP0);
> >+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
>=20
> same question.

Will do!

Thanks!
    Xin


