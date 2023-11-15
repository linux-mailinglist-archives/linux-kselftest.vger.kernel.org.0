Return-Path: <linux-kselftest+bounces-120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65D7EBB57
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 03:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7E8281393
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB16659;
	Wed, 15 Nov 2023 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nD/87Pce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E373644;
	Wed, 15 Nov 2023 02:52:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506DCE;
	Tue, 14 Nov 2023 18:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700016755; x=1731552755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EuiDMLcdQ9D+8OlNLNbcxO32e4ToQnIQq0gkqlKrKC0=;
  b=nD/87Pce79qN3QMrzHB1Iv3WeLcMLQteEBQ9DBegZX+AmIwpgurzenb8
   1Mwz2REnkVIWBax++pFk3NbA6B4fraTABXqIJIudLc/GrplfRPdKoJ/1e
   HNKSwJ0hyI6biOOA+Mqruhkdj3DU32R/hfM9m4MB7Qn2wLYudMd9Vr+qi
   aRstPdpzonxWMr30LvRnE94lLgQ6lUT4Mcqf+M0rDgDWWr9flSlUWUs67
   +ioGKn8IbgANKh/MDRJUbojo+62ore7ntpn+fthF3ZfVLQLasXCQfThHm
   vLRYGdIKhfLd7vE46nkQlICGsTwlSnIvVXAvVX+dkpE8KL/qLFCumjiDn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="477019938"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="477019938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 18:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="13024671"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 18:52:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:52:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:52:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:52:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:52:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJuhoVZHfRJIbfNne8+dpEx18s1m4wwop/Orokbrc5uoe0Z17tX6mpXYv0GNDVpBw/aAj9GH/4P7foDXyflX5muKTdS69EIUJlqOBBdJ8jftXCBNFO8C63THtNkj1fIUpp0tYRxbfhD/5qf+h1X+emSwGPsGnOojdoo+28AzC1N38WpKJD5m2NSmYxDRAouvfgklBMlVNba3l5GUv0tQ3qTykm5JbGnD4LUkCS+QhN4+EhSzeESOTO/fUdkJXxHZjWuTYWoDxYA1ay47xg6Qw8CT+CbX4qy5NuOITIBFnTTpxUm2Sdvpa5gSSNZR6zaykjP7q4bEXocNDcZtMvb9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsdPnasitMaOSNhj/ZFw1U7pEzdeOKQ4hZzidDZKuEE=;
 b=T1YzVVF1VRL6EcLYRgksSTx+SBvkSlcJoLil2r/0YeGkC1MUf2jjEFrxiXBGomR7OmapZywdwNmwWhmZGKb9eKWsbCiyH6xThUsVkXy/zzOURKDFEqN8G626nVV+qoPgAs1GxupqTPSQ0SoryHcsv1NHBeRlGJ2idx8meTzinEQ2KN9Uecl7MCCyqeRkxiGRZ5EYMfYXxah41s8wRigCYSiJrQ4PTB7KSPrB9LbhNvjvrtwz/boelP9S1v22tb1hiXZX7K4efmL+RxjrLzSJpWdvzIJyZinLYthAsGoWn/iPJ7knldl8Qhgog9/K9og2SJWQaA+RrhXrfmBH06uFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 02:52:30 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 02:52:30 +0000
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
Subject: RE: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Thread-Topic: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Thread-Index: AQHaEnYZT2abIZhNcUyoZ5A/RVnRc7B4D5WAgAEtDsCAAFANgIAAotQw
Date: Wed, 15 Nov 2023 02:52:30 +0000
Message-ID: <SA1PR11MB6734FAD33CAC432ABB5EF7D5A8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com> <ZVH3IUsfvzuPaj6L@chao-email>
 <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVM203KI5D3o+ksS@chao-email>
In-Reply-To: <ZVM203KI5D3o+ksS@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: f66a938d-d2be-43b0-42fd-08dbe585e8f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qo5CNxTX+H9O7oRdNlG4PnmtoESB7TZgS85D5JZCb4dKQ5Az5yQxrP/Y5LPD1/k1OhNgVqA42AeY3vF+fXcW/wP8iRtJybjeE3GkJ8bqfIGJfOFHbC5sF1oqGokcQK/ikbExQ0YaLhvLKzKmAzOhJrSWPOxA6Ftm9yIT+TUoipsl8+DzXRLqsXcduVOan2xAJ1TkfOj5HB+AzWhc6jlSj4gNOC6E+ijLOVtgp1awaWjaKkHIDc5WKfckTct9B//RFpYh9x4iRKDE8AiLQ/FqQx5jD77+EObWLkk6ZDC6r94FDMfGr87DKn7gcAPxsDArf3hfv9FGvcd+PQcT/EIF3Lqqfn+BqzfWEICPZbgFcqoXLJWGOOCc3gY3O2xKBDqjSYrFU4rM41OGzXGStVp3fLj4HILoeq21sfxNBpSxsYlsMwf5Ace6bPAP3Pt6FQNFexQqgfz5hAj0qt6tmJB/05jtAwb57W1LaZOncj89YZJyU7uapLGPPzPr/B83pY6s608X8qRVEcRWHx2oI9SS6puOLfOzaO+vKOHTCofWU0Fj1DrhtNgR02ewvuVy3kCikoG/EKVEFJaI/4ct4e9vub9H/U9UEDsf9FJ3mZlPY5jCyrEYeIVZ7FXk+d6opljJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(54906003)(66946007)(64756008)(6636002)(66476007)(66556008)(76116006)(66446008)(316002)(478600001)(71200400001)(5660300002)(7416002)(86362001)(38070700009)(41300700001)(33656002)(2906002)(52536014)(4326008)(8676002)(8936002)(6862004)(9686003)(122000001)(55016003)(7696005)(38100700002)(26005)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eEWVB22PqQ6t2f05xtxKOm2LQlaLSSsXdKOeiWpjb5n8NTHLMvnCLHfOBZQH?=
 =?us-ascii?Q?AyeSBFSF7sS182yP3kCD/ENBReFyHhp4LcX4bCEVXxADk+7kvycIrwjhdA7T?=
 =?us-ascii?Q?vopNMHL19x15xNUJzKKEUtCxNDcH7wZeh/j3N1XWO74Url5zf4X4hUZGXCot?=
 =?us-ascii?Q?GJQWWlULkaCQNaEayhZSfxYw0zfDatKe2xFyDwqpAs/owPOi+ywCGkBUDaId?=
 =?us-ascii?Q?l0gnpdgWyMKd4AgEWhbC6NAaS7yvUzkpbXOmrdcIiv0crtgquVNXWDMBtfvd?=
 =?us-ascii?Q?o0eUnzHgnn0XrB0RABqYq6YBu5M2zPZRGh06eKrrP6y9yxAj+lQfTOL2v3aA?=
 =?us-ascii?Q?S6LJTenq7CWgUHCkfeE//kfKHW99jvapyzbiQmDf3NlU06F6qHMCDHUS7SHe?=
 =?us-ascii?Q?Z94owll0ohwqJMB3EMZbk/dtvKqlIBQgycn4NeD1Kx4xmGAxt7dDsaEoBBrh?=
 =?us-ascii?Q?ntP3NHgf92kCF84pQy01M52n0I95XIPnoI9IIkCBcRDdL4dTnPVQ/YAFuCcO?=
 =?us-ascii?Q?j4n6H/czsL+L2UeW0WAHSWOb0jyNrWaculMZsG3fkBMQ5sn0/gcfYwEyu+np?=
 =?us-ascii?Q?+AAWixx1UG7JR/WrsG12tB64/MZDPXdtA/Py7+wx0FmiASYB9GYpYTSLqiVj?=
 =?us-ascii?Q?6T+Px6jYrULG0DQacrguQojuMDaCmx4wZMMQG1XeqZ64lAu5xW36j+nC8L7r?=
 =?us-ascii?Q?jioUXAd37uQDtXC0BPuxZGhNDbBPbm/KEXdH9njainTAMfrDOQwMFPLvHIwG?=
 =?us-ascii?Q?7zfiWf9PKOYwLhS1hBzqWZHEjiz2Rve9WokzyDcjHw3ffA2CmQ9AfZrKFD6r?=
 =?us-ascii?Q?3+TSy6i+2ngkuhezhXhp8x8WIPgvEB99X1M2EaA5/V01vm2bz9YCvP5NrPMJ?=
 =?us-ascii?Q?IVQj3R2Jx3eGhygKc4AOZGozaeMS+wRa5lDxlQoWCZEFjNvEkIPEKkD+bKoR?=
 =?us-ascii?Q?s8oN8nT6O8648E+ehUpyakyUf8F3c8r1VFPxzEIWOqVL1EODVLrpu94LH0Zz?=
 =?us-ascii?Q?PA2hYhm9Com7BFi8NjWhpyU+++G1jOrvl9Cp66NEvqvsrE9KPgfViX/4usQx?=
 =?us-ascii?Q?M7Q7GvZ+lz+6Lr/uAEF30xuljxwhaln5ypbQj8VQAhwZ106cuU1LWCKBET4b?=
 =?us-ascii?Q?YS6cM2ke4AF2ERKsfW/HR4maPI4dmeYAO0+TAMkhwZeTBkX8Cg21fcFDB+vq?=
 =?us-ascii?Q?No8jOy4j5nIYN9xsUKKAJsybV4fwmc9vE79KfgkEF25CAb8oKjsXvnig7eaj?=
 =?us-ascii?Q?0YM0BGqKWy4yYmxenT5n+uKcKudb1ToJAdUcrzhbYHmyeF53Q61c1faF/ESB?=
 =?us-ascii?Q?BnlXvnNGt0Xgi/ZqXJSRBAcGuCFu7SIoFtYgBMC4Lr29Z5EEj5ZBine8YrpY?=
 =?us-ascii?Q?cuY3MjU1H9Yut80B+TfpiMd4KR7IEc+kIjeKp6tR4OocPCmXgwvzSFAHuAS0?=
 =?us-ascii?Q?bt8dDZ/8GrgIjUr5lz+rOVvk7XeKySxxtnB6Iae5it+e5lIFUK4rlZAsiRWS?=
 =?us-ascii?Q?vsCO0Hjub+DsEm2nWGwZ13hDWKB4Nh33smKXDTc8QugFX1YHFKKmfh6tUKAU?=
 =?us-ascii?Q?0UPGljIW8GQT1O/PjtNl2WrzmSWuEGWhvM9HkpH+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f66a938d-d2be-43b0-42fd-08dbe585e8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:52:30.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUBCX0Fzcr8CB1YnOxBz1OvGdENnuJrVGjrJU5cstTEWq6eKwdMN3OgLzPDbKvJxkM9IC0x+07dj9FuA/yXofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

> >> >+			else if (is_nm_fault(intr_info) &&
> >> >+				 vcpu->arch.guest_fpu.fpstate->xfd)
> >>
> >> does this necessarily mean the #NM is caused by XFD?
> >
> >Then the event data should be 0.  Or I missed something obvious? I.e.,
> >it can be easily differentiated and we should just explicitly set it to
> >0.
>=20
> vcpu->arch.guest_fpu.fpstate->xfd just means the guest is enabling XFD.
> I don't think we can conclude that this #NM is caused by XFD only from th=
is.  i.e.,
> there may be some false positives.

Then we should get 0 in event data.  Otherwise, it is a bug in how we deal
with IA32_XFD_ERR MSR, w/ or w/o FRED.

> >> >+			default:
> >> >+				WARN_ON(event_data !=3D 0);
> >>
> >> I am not sure if this WARN_ON() can be triggeded by nested VMX. It is
> >> legitimate for L1 VMM to inject any event w/ an event_data.
> >>
> >> FRED spec says:
> >>
> >> Section 5.2.1 specifies the event data that FRED event delivery of
> >> certain events saves on the stack. When FRED event delivery is used
> >> for an event injected by VM entry, the event data saved is the value
> >> of the injected-event-data field in the VMCS. This value is used
> >> instead of what is specified in Section 5.2.1 and is done for __ALL__
> >> injected events using FRED event delivery
> >
> >5.2.1 Saving Information on the Regular Stack also says:
> >- For any other event, the event data are not currently defined and
> >will
> >  be zero until they are.
> >
> >Or you mean something else?
>=20
> IIUC, L1 KVM can inject a nested exception whose vector isn't #DB, or #NM=
 or #PF
> with a non-zero event_data to L2.

No, this is not allowed.

> If delivering the nested exception causes a VM-
> exit to L0 KVM, the assertion that event_data is always 0 for vectors oth=
er than
> #DB/#NM/#PF fails.

