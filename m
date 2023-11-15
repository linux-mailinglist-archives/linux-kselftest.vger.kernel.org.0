Return-Path: <linux-kselftest+bounces-121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E737EBB66
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 04:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4E2813AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273065A;
	Wed, 15 Nov 2023 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGlN2Hv2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6006647;
	Wed, 15 Nov 2023 03:03:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C00D7;
	Tue, 14 Nov 2023 19:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700017417; x=1731553417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R36i9XtPZ9jCKXZHB+K4pZUv/LS6aqw3e6pDgsnP3dM=;
  b=dGlN2Hv2q16JEM+6ncK4FeXxBlD1vgxkVjdzvl1mwHvgIySLd6Pm3Lzg
   rN7HpKua9XGiWnRJMfUXuGA8Q9JU6sImw9BBWCR90+/8WLiGJeSJUf3xN
   PLOy87B3MkjFPxYLyHsPeD5Ee6FucF3tGVC4CgBrhTsv4ElnMwFl8mygN
   o4Pp7/dNmz0GLeEHFAJhSSYeut+F0+xqDsel19PvGPVK6sWW8E0PZpAAQ
   lpdcjIdLDRR32YSiqkfWcxMJgajIrEIkvLwLH2P/bAuIcmE8hWdbYAedU
   CPTqr3jqcUDFjUAQIGVZ12dmchWIbrSJObUSqiNRVljUl1YvGkeD7bJfJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370148354"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="370148354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="888443604"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="888443604"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 19:03:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 19:03:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 19:03:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 19:03:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 19:03:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0cYw5yTMy9CyNTascWLwytqVFUGg/ZGhyuU29+ZERQSPJUN1nF3Kihh1AgrO+miFYFMU/iEieREb6lmxTKsUEhML0mlDJCEXdKI17PDq2yG4KWU19eUfzBgrKvIiAdEBeDLsRSryUYWH8PjaHo8/Y5BJkCvvjuD3etmNd660p+iFMEYCrVMJ9UZQdlTJXnQx9PvxhSlJk7qvsJU3Ey6KVH7p4m1Ftnd19NE15+o1fWhXIuNIsy7+KdHQdSbgbuVjnnr9d7l9nfftj0QukjDbldj5RFWlJkFl/1OKFHpap43EW8viOraPCvW9rS60DhqXOXx/zu2RkE9EXQUrnA4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfd7B4D5DqdBhSc8OWDj//ieGbtwD9FwAXGBgf3YJvU=;
 b=LsDuG17Yovu3+YM6n6+2qZLPkIZ0TfkKl+s6LbERZHhREHh1J8bwG1+K8i73in0wswR/J1ph0JW1YjkCE6QzcpxcH3ZaBgfyElW7HvwcYwt3BSKYEXKTAUSXKRZhluk2tMt+uudT4OlxRwlQJULUfgCggz0AGiKqtliSL3tcp/EY1sZy8ktp25digfslniUlZt2TcjWLk5xoT/+CXhxLagCQA8q3wsIQz9I7zjrQggGOdzOlLCWnbFxttJFbUC8Ysxl4WTGQEaUFstkBsqIQgHM9ZFqTWDqJVJFGv0SGUszC9AgSj+XANB4BPYY0CkiR37E1DBhr09xykxB/g29nhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM4PR11MB5503.namprd11.prod.outlook.com (2603:10b6:5:39f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 03:03:01 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 03:03:01 +0000
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
Subject: RE: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Topic: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Index: AQHaEnYXOQlvFLhpWkG4lt/jksLCm7B5dqYAgAFC3tA=
Date: Wed, 15 Nov 2023 03:03:01 +0000
Message-ID: <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com> <ZVMkVmBPVfaMjDTL@chao-email>
In-Reply-To: <ZVMkVmBPVfaMjDTL@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM4PR11MB5503:EE_
x-ms-office365-filtering-correlation-id: 8fa4e901-e36f-4029-3fa7-08dbe58760e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+BifyaZ+xzJReGYT/894yMGvEMEAwgw3egmkBujprR4dIHpjqD20Mw+HF8jbzASPKrfcqL3sypNYyBM0P15xL0/hxXYgODv4/JhfWRMoEfHOBDWltV1jgeTakC4yvSNFQYNMJvZwfZRSkCtzbo0NFMa4kfxHRx47yGE+lDp77E3xbJjjdIH0BeW8kRd5Aw3FDA4M03rJ+e8wvrTnud6UoRMji/yuXrR/oMHjM4zmvq7EsCa4An7tXl/yJYTVwSEQyqgpqOHYAoLoHwM478fA2rSB7R9R3F8CBuUA7aizxEacTV5mWp/53qVtlb/qxcLqSDAsX7Q4gpjBHCc813uD4fC5cQAakoYyT4dJ2dI+yjLaHvTDmhnsuPTze3UP8xAve7tI9gBB3zQrBRTFM/OD0HeNcReWk9SdgUqzJxrXQzJeePa3n1Vl/6HNoph1PGRdJbMrqMneGnbocx7A+6vkcQCRLGFHLMiMoZ2aLaJShF3LpWbuQjiwxg+pUz94vT52/HpYfEzO3qXAc00XIlQcM91Ie4FIRMofuiAgKY5keKp0XXgSO8mpPKE+hUDvv6qr+WHmQePpwnZADADRB956AHg+ffbXSl15WU/R52vEfSop3WJD6WFEFlXa0y5fUXc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(4744005)(2906002)(26005)(7416002)(38100700002)(33656002)(122000001)(86362001)(82960400001)(38070700009)(41300700001)(52536014)(66476007)(7696005)(54906003)(64756008)(66446008)(66556008)(6506007)(6636002)(316002)(66946007)(478600001)(55016003)(76116006)(71200400001)(8936002)(8676002)(4326008)(6862004)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vA7z32PMQa32YOUUFlzAVyWjOMgo2MDgfMGkFUaOZOAWrTNfFwcEmHrruRVr?=
 =?us-ascii?Q?lVXCfOglNkmyUaIYaza/lHlNopPbU4nwkbKQYF3ENIBcXy3zwxrmCITvujMS?=
 =?us-ascii?Q?o0iTsXXCVb8t4R+XUQt7HBTW4tBQTMbFb/8UpNzC4igMGfHqChTJUcSrUWK1?=
 =?us-ascii?Q?IWMTf8sf73pM4iyiV7hALnyyKrVHQPXDtt5Gq2i7RpqboDUOeD2z6dNo+Xxa?=
 =?us-ascii?Q?5LSaT3B8dTtTsVbOWSf54JCuZLgbg6yDZqCXTVOOfksJr/JwQ3CQMFWE9xkJ?=
 =?us-ascii?Q?z99Zkka4jCh/nrEfG1YrbDSr/4Z5wSPe+MuklcWhKKWI4Ynvwe3nGyvZqDNM?=
 =?us-ascii?Q?HYsr7pvOUByw+TIC4Fwo8A4GxSV7btzSIwBfhP6+w1cOTQpUN6VjciK/F+K2?=
 =?us-ascii?Q?ZYAzSNmQz+uLmr2ysBlpq9dI0fLKC4uIx0CLQ9YIDnFbaUMAwgMe5o6s/NGs?=
 =?us-ascii?Q?tLVpxD6pJqm5W9QzxUojBSaoZBOh5NZX9cZGWhXt29FK0PlQsq4v4sfJ5jBv?=
 =?us-ascii?Q?gOV9DDf7d1uyRXV7T0P3aLLYhJ28RHQnm/ryiRdyoVkG8vKvX7qo14oT4uo4?=
 =?us-ascii?Q?bhoeqgETufDtOYxr+7CRlz0nUBqGyxYa6y1fRwFNfY9mdlaVdJgs5oQY2fTb?=
 =?us-ascii?Q?o20LtySwHWhQ9hXGc17SXg3HP8LZQeS1fFDVlz2RR3ViIjYViQkJ8Byuiqks?=
 =?us-ascii?Q?IgsLrlSLjqmIAT4VU+iQaHaWh5XXgqdGnVT2j1P/k6NYF0E68vNY/jBmkHDp?=
 =?us-ascii?Q?BGqu7BYWZpDuwByBGajAcNbhuo+MSf7iyfVseUp3hutxoiATGTaoO8+0WK6k?=
 =?us-ascii?Q?/AFeAQf0QNxpFsqD+IzVyCyPPaml5/Aw/7ty+9ABz4YKyohrlqhXbD0z1hFx?=
 =?us-ascii?Q?hTM5fEsyqCegUjb4SfsyL0P91zXwhHGL9jJvMeem/+ZPPNvxiewh50MiPEWS?=
 =?us-ascii?Q?YJBVKRjajy8XfQS+IfZmmNqFyFP/msGiFk3zplspDmkodzw7vGOtuL9iiSzv?=
 =?us-ascii?Q?ybWtQK14Rq2zOs9Clr7pzbyJ1SOmKxSvEPJPtQOoun+TSXH4jY/tOtQwGdKr?=
 =?us-ascii?Q?43RtbY0jUfFxuFz7nFKGN0LEUZ/7vaAhHCmKTPsiMkHEcpF0o+ST4+UFkgxW?=
 =?us-ascii?Q?9oop9PPlwdwVkgpZ+8RvBk9MFjwBwYCuig3UcKxhAWTtAgM0F1VaCMIZuk/N?=
 =?us-ascii?Q?WilKeZOCPSIFMWf6dSCxvAMOmLEYgXsGYfsgwlbP3l7DdViAFvBMSowlreKz?=
 =?us-ascii?Q?R5un7H4EWpeOs/ULGDxYcbqWwRiB5748OBerBnzxKtnnBHVhHPnI2SLULj6w?=
 =?us-ascii?Q?jxK6sTSIiN5cxRskfIeIp2v05XG1Rb9cmer6TIaG+vaKaZhIXC42XGN1Ee9F?=
 =?us-ascii?Q?kXZ0QVyH8/9hmtWRtCG8yXD8kVAgFEKGpTLjEEsvGLj88sjzEwSoEzsfiZZW?=
 =?us-ascii?Q?ySB2m6RZI45b9doZxJKjFEFeHXrgcUaNN9BYZ7/QMla6wNrnqGATNtilGWEB?=
 =?us-ascii?Q?EF/z2mpyaDA20V5EWISabjE8uHF5J2gkc4vSJajTHMgbKuvwu7C2/ODHC9BK?=
 =?us-ascii?Q?OIoDzkGAQJ5Ws+ywPXBe9OgWsIgsQFu6RynWAaFV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa4e901-e36f-4029-3fa7-08dbe58760e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 03:03:01.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7yqxqvOWZzllEJld8bCau9OYsJ+aas7Y9dxzp0gBheJdpYnEeBVFa/jODhVQPUOXUAN+948kpokWrZu9CLc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5503
X-OriginatorOrg: intel.com

> >+		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
> >+			kvm_requeue_exception_e(vcpu, vector,
> vmcs_read32(error_code_field),
> >+						idt_vectoring_info &
> INTR_INFO_NESTED_EXCEPTION_MASK);
> >+		else
> >+			kvm_requeue_exception(vcpu, vector,
> >+					      idt_vectoring_info &
> INTR_INFO_NESTED_EXCEPTION_MASK);
>=20
> Exiting-event identification can also have bit 13 set, indicating a neste=
d
> exception encountered and caused VM-exit. when reinjecting the exception =
to
> guests, kvm needs to set the "nested" bit, right? I suspect some changes
> to e.g., handle_exception_nmi() are needed.

The current patch relies on kvm_multiple_exception() to do that.  But TBH,
I'm not sure it can recognize all nested cases.  I probably should revisit
it.

