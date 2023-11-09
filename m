Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1F7E754C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 00:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjKIXuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 18:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXux (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 18:50:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D13868;
        Thu,  9 Nov 2023 15:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699573851; x=1731109851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vRiO16edNZkgPzULuOQ/IUBTwsOBdUZa0yBNmPFTM/s=;
  b=AHvnPBCQxvsUGQu/mI86LxhIoUTMXaxlnj+vCI61dK7meJFo2PEx9Gbs
   BZDgyHJfOo4rTibMXqCVtlKB7lvay7Yf3aOsBNS8V6LQrMfKMV4r442h0
   tnPCQ4XZXgYQOWLrwb5e6VpBAJN1oPdE4Qv991c4EikDYN6Xn+yEas3DQ
   StDMMED8zbliBUifb1A0aBGm1wuT47Bo6FfvzsxsRtmS1y/n52TI3P/Be
   iFCwbld+TTjhkkJkFdtQuE4gT36mVEUMWeHaKRW7xNlb9Juy1dwn16bhp
   OCq1jocGbhFIRjkAAaKtdiHDdBUGM8HPtA1cLecmLoQoizn9yKQYZh+cq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375137973"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375137973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="937013280"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="937013280"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 15:50:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 15:50:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 15:50:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 15:50:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 15:50:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRk2xY8Id/Hd1LZISO+XVI3JM91XmGylm54g2K5muQ6Eu/o2L6FlRay/BbDXl2GTlWd7lJMBpVTgxcOEeyh+Qr4/E03z4b9pbmMBytQpU660oYVxVlaEZtFA1CN4ksrMq6HeUNE+s5VBND1QW+YsH4EzternyfToX4fjMjTUckEc9ARIvMOHxSbJOYhcQ8/WC3ZMPY56glIachLlgs7wCM2Af0+cR8oaDLMXcaSG+I0dZTS6sremcwkB+RrX8oYDmHxVXV0vobcyiFknbkZJvxZIqobmeRJUTWVFJisez5pZBAFz/AlfJeoCAM+Qzpqjcu8EcFIlQtGe5ibHWIVTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsmRsGEOB0ofWifvbx9SbeXYhmkrLGcTIbMgegTwUCM=;
 b=GegR1BOF+1YQibQYXsrQuypUSxih/fvKBn5BfO86jsTzB40BIjVrp6qZi8Zr5FDOVit+JrUC9PwtRsJJrW15TJMcb2YfsSLvg4OJ0EZiHQlU1Uaff2tmgLfehutAiOFoPzRUc6GRVKhjOicIcNVGNVLMNPNkDnc859mwbq2yF91BfcvGxCSYjB5ps9HChYWquAz9bI+QxmUBe/rKoK0Eh6OPPztNdEVBYxhn4TRseGKKYuY+HozwPLRtfa2nNej5qQJPVj565pXma4H6ytwg1mVARr4cSBVWqMaDq16QFiOEC7rJA3xZSMxOgHb70gi6KQZ01uyzfeRbXRzVK02FjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 23:50:37 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 23:50:37 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gao, Chao" <chao.gao@intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Topic: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Thread-Index: AQHaEnYK31xdVTOu4kKzxsXb22qo7rBxtbMAgADxRyA=
Date:   Thu, 9 Nov 2023 23:50:37 +0000
Message-ID: <SA1PR11MB67347A31E38D604FDF2BD606A8AFA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-7-xin3.li@intel.com> <ZUyjPtaxOgDQQUwA@chao-email>
In-Reply-To: <ZUyjPtaxOgDQQUwA@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MW4PR11MB7056:EE_
x-ms-office365-filtering-correlation-id: 62a8b1ca-2883-42e1-37a4-08dbe17eac51
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRoT+4q+CdYe3skxZmKFFatTNU8ocIK+CXcIoh0+YUkP24g5/Ccpp7fClYnduv6dPm+vpSeQJCLpdbbjuILZ/j2RNJaqAz3vHJc7ijQqNPVfc1KL87rtO7sa9hqKuQLBzgDSHCrSV7izjMR0p1bjOvDW9mWn7mg4+VudjaOD0dNstV7L0un1oono9thxrdM1LZbYQ7fqMDR2SSH19KVFrbUzP63wNXghSW8Thzf4QAihgsJNkNAkW+YC9NA+uCzaQ5fx5GffCNQsVWI1GdCDfQUHMOeR4jZuee8/ml+0Apx7LPjXS/0cQu+8wFSxPawfrr4WNWXtD1NMWAGXftR4pRTuHEtUK1F3A6V3P/zt31PD3mvOXmC5OQIbOfVzoCSRBIVDkFoOTATWnAHTMBu/uUV2SG+slS8owxnctmZBEaJs6oJ4s9Mo1TqQKyzBFTBfZ3y5+WzVcI8Uc28wMUvRSV4id3A373SQvC++zBRE+P7zE/vPVjcDf4Leq8Gi4Q76se+Vy3Vcj0eLTKj8Bfx/SiroyuLb4Xj431aI7gGMDhXR/tXkdmgazxZz2PKGSnXXrpztqVbvq4fdKnSooQI6/MyBQSCP91/Qi7lgbualsMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4326008)(8936002)(9686003)(64756008)(122000001)(52536014)(82960400001)(316002)(478600001)(26005)(966005)(66476007)(66556008)(66446008)(6636002)(66946007)(54906003)(6506007)(7696005)(71200400001)(38070700009)(5660300002)(8676002)(76116006)(55016003)(2906002)(83380400001)(38100700002)(6862004)(41300700001)(33656002)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRhrnBH8UNe8mS0h/D4sNVpa8Ty4dYYpk82unXQvVxDYP7Wf38jQAXbuoeXj?=
 =?us-ascii?Q?NHWuAhsl8jIuAzz5g64RHy1MCPvW164TiZweU+rD+qrmbMtyI4ozGpH3G9QQ?=
 =?us-ascii?Q?q9dFiwY60+CW51uT2IMDBTE5TjdRDkhVMcs6s0BZ4ymHKwM4vi3DdUe2pFX3?=
 =?us-ascii?Q?tff48OnayUMTnTwFMSHMTh29uJsLRvwda4yrusPTuMEkKTof03yAWvtxN4Qu?=
 =?us-ascii?Q?gbqA5U8oKofJxxInqbbChFI56VCa8m18ACcBm2lHhnKLWqOdgLhbOQ/aylD9?=
 =?us-ascii?Q?T8tJz27C7vqKvupJNFA7Up1REv7Mh+jKYTyaqwfHCsQmlZ1+Ip16qw4fHzSl?=
 =?us-ascii?Q?SyGcDNeVvBWV24SRAp2wYJo7JvEVMJrU7MjYM2QNzZRKI08JCW8quFCG7/Sy?=
 =?us-ascii?Q?hHnPs8RVM4es1pfJswRHNJsjXDQcRc2msxmJxWYHn0AQf8w8r6u+VN6tmGti?=
 =?us-ascii?Q?orM+k+ZWKIJBN5dqnWqhdt96F6NpqC1FV82QQhLg9F4h+OiAmsHZW/056eHJ?=
 =?us-ascii?Q?zv1/0WNhE3UGWggumqjOOW7/2dgqyRXiZiIqBS+x7kUn/NVguJDme5kRemRJ?=
 =?us-ascii?Q?pf/2J4uqJfx+ruuTva1Twn/NItjoaa7dkZHX4g7FL1NncJMLpicozs10mDLD?=
 =?us-ascii?Q?0dheiDKlsd+URP0/Ng3phVZxNGaXZATjkG0DVwePT1ms9YljJ2HkttLBrBnP?=
 =?us-ascii?Q?NkaJUDt8zeR6i4PE24Lu0Osm8ADl+VRfsIGffRd8FoNhAnRu0sIpAW64+wfa?=
 =?us-ascii?Q?dx8gc6wWWMJ1p2E/uKbaveIYCzVi6QE2dmfegNZRULdRCm/TZ17aoAbyXIjF?=
 =?us-ascii?Q?O0uWKQVtkG6fOBLVoG8W/IMlM1lmdNPVeeIEFMahuwmU70u06vlGUNU2GfjB?=
 =?us-ascii?Q?/k0R/wc8GpArxq48apx3o5pZEVAQQEEQTIkErRhz+F0WyvJaReqMaB85ShR4?=
 =?us-ascii?Q?MQ6gD43kBOSspdNhxaV6cpiA93dTHxnJ4uJ9dJc9uUnl4KSmj2yarg11F9kX?=
 =?us-ascii?Q?vk4NKXscUMO+Psl49TG2lV5smantkh08eZA8/18NFO/VeH0FA0Yj0DJD1TC9?=
 =?us-ascii?Q?dG/9/Hn2S0vafCWxbYBe3Ug4lkWrAXqHY5hLFqI7EDOax2VdHKt973Jrs4Ht?=
 =?us-ascii?Q?YDj7qt/feiyKUf8Ef729nzihCzLxEJV7gtX4uEuV1hm1XbasVIJ1LM0F1J39?=
 =?us-ascii?Q?JD1hkRCEjxkk/Nqm/ydcGjiaImK7el6NBWFe7YeWVcWaqMiWjQn/ub/cZSys?=
 =?us-ascii?Q?DGb0YwkFqqA7k2OoRH9nj6M1oI59S6mrF8Pv9bT2WBjICStEKm3CgJwLtL8O?=
 =?us-ascii?Q?xPJ5szgAQrEnVuwFmPw4W1YCVzrjO3UH1hAzpxVnfq3OYP2yWfGp/vLErQQ0?=
 =?us-ascii?Q?cPae7C2OJaBIbtZYyvAoXY4G/p4AREkScxpvK4NbcjG2ECRwy8j0GcAeqVLy?=
 =?us-ascii?Q?vCYqEDQqw/hQxt5YnAYxStFb33Wz3+Nr6cVXtTQZrN6ObwoHwM5fi6RsL5bu?=
 =?us-ascii?Q?uWlo9kjLcWcnSFt8Dy+L83cNOUisO1UnwOfP0prLHWLK61++wiAHBaMgskot?=
 =?us-ascii?Q?WxIdKCl5Jg26RaKxEI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a8b1ca-2883-42e1-37a4-08dbe17eac51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 23:50:37.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTNXHg7RtycSq4dq2y+fWW6h9M9nsCgk9myfgYYjP7f4ikcJkEWmQu+VkdPepyUfUxmSXIMoy3b3uaARtmy1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> >+static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> >+{
> >+	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> >+
> >+	if (!cpu_feature_enabled(X86_FEATURE_FRED) ||
> >+	    !guest_cpuid_has(vcpu, X86_FEATURE_FRED))
> >+		return;
> >+
> >+	/* Enable loading guest FRED MSRs from VMCS */
> >+	vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
> >+
> >+	/*
> >+	 * Enable saving guest FRED MSRs into VMCS and loading host FRED MSRs
> >+	 * from VMCS.
> >+	 */
> >+	vm_exit_controls_setbit(vmx,
> VM_EXIT_ACTIVATE_SECONDARY_CONTROLS);
> >+	secondary_vm_exit_controls_setbit(vmx,
> >+					  SECONDARY_VM_EXIT_SAVE_IA32_FRED
> |
> >+
> SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>=20
> all above vmcs controls need to be cleared if guest doesn't enumerate FRE=
D, see
>=20
> https://lore.kernel.org/all/ZJYzPn7ipYfO0fLZ@google.com/

Good point, the user space could set cpuid multiple times...
=20
> Clearing VM_EXIT_ACTIVATE_SECONDARY_CONTROLS may be problematic when
> new bits are added to secondary vmcs controls. Why not keep
> VM_EXIT_ACTIVATE_SECONDARY_CONTROLS always on if it is supported? or you
> see any perf impact?

I think it from the other way, why keeps hw loading it on every vmentry
even if it's not used by a guest?

Different CPUs may implement it in different ways, which we can't assume.

Other features needing it should set it separately, say with a refcount.

