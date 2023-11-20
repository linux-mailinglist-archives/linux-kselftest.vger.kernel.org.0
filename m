Return-Path: <linux-kselftest+bounces-291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5897F0E65
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 10:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369DB1C21531
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B71079B;
	Mon, 20 Nov 2023 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZHkUCU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C7C9;
	Mon, 20 Nov 2023 01:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700471102; x=1732007102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YnjbBlGpw+M2hBCFRTeeAoP0gKWDGVFAZ7EZRVy6h0M=;
  b=TZHkUCU2vnv2QRgCHeE8PDmdZg3X3TnkRZTj/shiQz3lTMuRobOMi4xv
   gZHk1XfFfC2d+uEzvy+mspZs00XP+yiCMOPzlCbltX2gPRcl7k6Xtpla8
   oMVbKbcKtwNfM8eSzmReBeI1l3NDX7DXI3+dobrB4Oz4hrFIK1r6pLQyl
   NRfXtTeDipwFpx4WnBp6NJZ6wgVQVidMRfxkGY6iJW5jAIBlKDfi4Iw76
   jvHHLpKGgezQ8Uj8f5qzHBlPd9b4mOX625yEJo42ysQILj79/fEJwJyFY
   gHU2C/yE2bYJ5tSiAlB5k07dZmgPar+IS9r7uPitzU3qjCK0QyJ5MGIrU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477789519"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477789519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769832557"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769832557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 01:05:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 01:05:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 01:05:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 01:05:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOguPEKNijx01KR9azoGyqS4XZ2EZjmKXGszU5mUIcwdxbirYl6J2uExWSVQRzr2LYMZuAuMYwWDmm+ZFxYWskM00IITv7o1zt7wni0WFiB/QjWuyoT3NsFgJiusql6L3eUF0H0zO/Czj6XbrAS1Twf8tbWdpILo8ZqFCRcvgz5IOkCN8ZJwPsGbzLSXH1UJ7E4qBEbHGbWKdCE5bql021HZQxbRLE1WNjVOpiX8fDFpi4VxGqTyPEvOgxwTxvkAP3j7cL45zbj/cGcVH7D4yJgo0ixD9ERxjlCHul+hxd/3dOl3LP15hsHja57cBV2CrdAdNH3sR1iwy2ZCEXutSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPRynd5YoYNr+nZoCVWjS0hwYnevqQvdYq4qvpI3L8w=;
 b=KaGFBLIMysrL6ZbjjtPtGgvDGPMWyukpSRpSBxbwMithAwYML76PrHzgcyezjtgPutkq5YhONwPyDEWMaNcxyLfal00vLGpf4c6jicvoTRPuMSTb3eiRY6qy7cDKdbLiI6TGGxoYXyDqjdR4CLj0Cujo/y8UwOKuziq4FLpoX+/TcWPofn68NblWuttfBxipRtPcK3FyxAIVawdS9XcdOvAt2WosdFJTfVNWgpyAbphyTB13aFTCAp9BiZwF1rRrvPLZy+TIIKDCkJmVbLJfXvF7jKq8+H+JABNNZ8kwnwGZ+MjkyH+718DhZXF5vB3yWgJRWPZ67TSRGQxSJVYDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 09:04:58 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 09:04:57 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>
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
Subject: RE: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Topic: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Thread-Index: AQHaEnYQluTSIDRVa0GExAiuYWhTULB34v2AgAFfwqCAAD4hAIAAsgnwgAi0ObA=
Date: Mon, 20 Nov 2023 09:04:57 +0000
Message-ID: <SA1PR11MB6734703499EB40E2CB7B0D0DA8B4A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-12-xin3.li@intel.com> <ZVHRufhNmVTvJYWV@chao-email>
 <SA1PR11MB6734074A2E482AF6F911693BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVMs6vZyoqd2cUiV@chao-email>
 <SA1PR11MB6734EBD796D139957BFF2457A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734EBD796D139957BFF2457A8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM8PR11MB5623:EE_
x-ms-office365-filtering-correlation-id: 79d1ddfe-2de8-4337-19a2-08dbe9a7c4f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GSM1TCs1LCBF4CXKG7kQtuWACMaPI3ktSkT7h2pVvFQkbq5mG+9Dbk2K1YErKuDw8I7IVmhtLz6TTTvnllQjMBCOA/VFsCt+nD09dOwxrz2KIJGa46+w0j9kS8UXoxqH5KyvQu/0fFLEFZ2F6eC8wKm4JIw17AJ85L+sxbOBSAok6fJONKEsjMxKZXaYzuYDbbewwQwsyhj1fIeMWTvbunXwdT3RsJJ0dSMfBpzW/R33PTspOhGnUhhgfPpuQJY2mHwiT+8sgfbghLbXSx576cZ/e15IY6Gg3cB3DMRDnLUH3/8Mv74ZfzV01adC7VWBDOnzxmK5GT0c0VsJIkSJ30RLLiBgZvJS8230OnhrjMJPDWSj5Jn1PannT0iEbxSqkPNzuUa03gO7d+xGx4DD46uXRbLtOC4pkgq3wYpMpOsQ/gz4PFTV5aBSDgiMsvoCq4GxfiXdIocmIegFuJPWmR3m8IXHPAtBLurnDwPF7gtWcPCxbrPiQ9kQQZyMYkt6ATcsIZSpemXNVS67oR+Rw7TrjQ+LxFWXGU3tNFV25ogW/QD+Wq2Ciz0xLnL19gBUAh7pvUu2SlMof2dkvLPT1BajS0dLmrvWZVSf8ofy2+j0fT6wvhkVNC0vyNXEKGD8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(86362001)(5660300002)(7416002)(2906002)(52536014)(33656002)(38070700009)(71200400001)(82960400001)(83380400001)(122000001)(9686003)(6506007)(7696005)(478600001)(26005)(55016003)(38100700002)(8676002)(4326008)(8936002)(64756008)(54906003)(66446008)(66476007)(66556008)(316002)(6636002)(76116006)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ygH++8uHWh9cfnQkua337U1YEw5Jkb9qIIm8St2OdHiDUDvfqKXeWh809xLi?=
 =?us-ascii?Q?K4U/6GXoEfvirhc0WrPN3ZwpLcv5yDLyTDQuGu6MVXwy+odPA6H5Wyqe7L/Z?=
 =?us-ascii?Q?5eUSID4VepFXJEdRJX+vdfDaMFqEYjJ5QTXxIVDNjXDReU/edDaKQn07Dv3K?=
 =?us-ascii?Q?jAaOGEu4OReksg/CDOss0e1vmgsgnbc9Qg9GTpDB2r31Vda4wT5X6nGpDT3I?=
 =?us-ascii?Q?VCOc23tdTlEerVUpNtTjmeC2UGZ9u3RKHisJnm/dg3V8touoZrHxeOagOso+?=
 =?us-ascii?Q?YLuG+wHvzThRJRbARnw5AWBTiZvO7aKpfDDka9IanuHcVljv90/f4XZpZM9X?=
 =?us-ascii?Q?WYzuwrfopABUrFI38VMnx9UXO73xbTUvjVAEKU+Gcp9TXNO3tyjDeqLp1xaJ?=
 =?us-ascii?Q?IH4po7nqI/Air7ufRTUyuhO5UmiFbir6kKEKaCtZvVESRsTO9WrOkHqUxZlw?=
 =?us-ascii?Q?4gt+626hkdjaN+dntgCNKo+1yw0JNtLh1lzfcTiTMUNCAAw4EZkLRzbQdfh0?=
 =?us-ascii?Q?4jrb1FWX27CtMf0ramqB0sy+9znqCh8otqnDXAqvhCTctCUKr004HwgjONSv?=
 =?us-ascii?Q?ibkxEDtx/oANyKZ2sQw849hYLvVecwZm/fImrfpsRRLzgp17hkGksrmGnXLt?=
 =?us-ascii?Q?zYl9Z8ktO5hCp2YFmMZJCikVzW7swOXWm9ilgvnKVS/ZjvzbHBdCnwPnoNlI?=
 =?us-ascii?Q?7Awt5ogJfIpzzjoakCIGt7a0SltVIWjDlnIOLjrqDUPAOf5e6rBKquJjMWyR?=
 =?us-ascii?Q?/UlgqpI0lTuZ7BwSNrnyQSkbSjug5bOWE+GiXdcXXnviaTx6ifzdbkzLu8zt?=
 =?us-ascii?Q?EAvWJc7FOuJO/tEGat+GGl0NBJOVPsQH8HSYRCqvTm98Ko49xxoE+lP6sdH6?=
 =?us-ascii?Q?rGH3ZPYGMCWInnaCiXYTf4KowSea9TdIJe872ZRNqa7ClWFOFvqyQGL8J4lP?=
 =?us-ascii?Q?gMRPEsEd4rBVTWmXVSZxM/Ie4oWvcTBaZx8WRMcNwygAAzfEDO6RYjCrd5/T?=
 =?us-ascii?Q?S/PsiN/YayFhqPIgGC0pu/vRqt+Hv1SMDv79Ma9wz0VZqgi1mwXS0D1AR9iJ?=
 =?us-ascii?Q?eP1F7rCsNP4wbSwQnoxuxaYVQt8kErfsvnzS8lKRlu9qhy7I4Ek66QcRISbo?=
 =?us-ascii?Q?q60Udld652wCxW1gIGnBTGzBgYBJft5DDtqiZ6O3x6eQ5cdijVjDB2cruIzB?=
 =?us-ascii?Q?zPEu/4kbFrf2sZ//bPDbC606oim0XSs5l0smcnOdS/Ol+L8WBFsoLaS66oFr?=
 =?us-ascii?Q?TtUUHL9Zy0R9E8eHtbIRgpP0k2ovICEbJUi7W4SBvkvxd/gVirfeMCPn3M5g?=
 =?us-ascii?Q?LIs+Rx+l6WjTfLdN+TfM8gKA6mpY0plPbIgrmpyQmW4HM9YYINOoImcVQEVe?=
 =?us-ascii?Q?4wdRYWlkwPd4P6d/Xspd/MT35uL/lJFfeUC4gyCv8aF0dAQb5YAMx2etz3NX?=
 =?us-ascii?Q?x694Or2nnHWfNdgvKz9LC/5FmRpZZkOM7qbsq5myNz3TnAcb50pqCiBgADyH?=
 =?us-ascii?Q?fxd5ZRM+2gQFA6E6u37Pd6j3cd8/Wsv/uC+0FBuQHX4OcTIYUCVX2Bl4Srs1?=
 =?us-ascii?Q?Oxo4yrXMCuM6mdMvZ1I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d1ddfe-2de8-4337-19a2-08dbe9a7c4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 09:04:57.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2TQcgnchCGA2Ynz1wsAxUBD3/jkw9+LF3rWir6ZmS9E6fbwWWltqAfVV/JTkCCks8+qoEbGfxFffxRWPtZiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com

> > >> FRED is enabled when CR4.FRED =3D IA32_EFER.LMA =3D 1. Any reason to
> > >> omit the check about long mode?
> > >
> > >It won' t allow CR4.FRED to be set if not in long mode, I don't
> > >expect it at runtime.  Or you have one?
> >
> > I was thinking about a very contrived case:
> >
> > 1. the CPU enters 64-bit long mode and sets CR4.FRED 2. the CPU
> > switches out of 64-bit long mode

Actually, SDM3 Section 10.8.5 Initializing IA-32e Mode says: 64-bit mode
consistency checks fail on attempts to enable or disable IA-32e mode
while paging is enabled.  In another word, the CPU allows software to
modify IA32_EFER.LME only when CR0.PG =3D 0 (i.e., only in legacy mode).
Thus, attempts to do so when CR0.PG =3D 1 will cause #GP.

Remember FRED only works with 64-bit kernel, which can be entered only
if paging is enabled.  As such, to clear IA32_EFER.LME, OS/VMM needs to
turn off paging first.  And to turn off paging, 64-bit mode needs to be
turned off (to enter compatibility mode in ring 0 because it's not allowed
to disable paging in 64-bit mode).  Thus CR4.FRED needs be cleared first.

So CR4.FRED fully indicates whether FRED is enabled or not, which is
why FRED spec 5.0 section 9.5 says so.  But we can put more explanation
there.

