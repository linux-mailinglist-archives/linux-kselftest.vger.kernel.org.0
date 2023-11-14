Return-Path: <linux-kselftest+bounces-68-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3437EA98E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 05:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F0DB20A80
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC45688;
	Tue, 14 Nov 2023 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRFLFHth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BF1857;
	Tue, 14 Nov 2023 04:34:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CE1A7;
	Mon, 13 Nov 2023 20:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699936446; x=1731472446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TZVLVMhjFb55AjDV7HCvtu2XixMVp5oBfrwDyqiBeJ4=;
  b=FRFLFHthGcZKwZ3C2LrCCltv+hoxX8chQiw5kxRzFBI/Wc2FpPh16QbY
   PfVYG0dKDL2ZMD0R2jQxtPVFSqfibdLh+zYwx/iVBsGWib0klNpQAkOWt
   CtIlIH5In1BnGmp1rzdUbCAkhRlZhaHRa7zaV0cL1VifaBAiHJcPXnqxZ
   d+MdLEcWUimFerC4FkT7y/ersnz0eBCzqHudtKnSSECITMAvy3lsQGxio
   DDO7lu+FKPfDb309EQ7Ft0WBrvbo0UcaZyVmnc7xKQ95jAr3IJ4qRwh+2
   BdiS6acpQ+Fyowyzucor80fZ4x9A7C9j/5azthYVleDsiyEo5H0iI2pvT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="369919726"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="369919726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="714449276"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="714449276"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:34:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:34:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:34:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:34:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:34:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUPonELrF4t6lvewYkJc5LRmCl9J63bPRtmHD9frdnoxy1jNM42iOEcF84p5tf9KLHN1eJLs0AgbQhIKZ9sFfVFR9DX3HENqMtb2LMD3SmToRzWYbIr3KU4cnwfSa/PwIzLF7TyjeXBJGQ7I/6diooDXfdc4J83KSFx2gIZqQpyT3M1UHWaQzvoDMThBPymKBu6ykoVn9qsNiX5/bcEPwwOIyo52ZQmBrPrm7KbsecQ/RGitPLs4o3JNn0Ob/4A1BpzDvUFYxsXvaAyZBib/lyHsfGDXflV0ECDnaq5JsCnoyeoKgzTIKR3MRXIJfvUIvtZyt/lJUYH+OWBdNe3mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj8UxaByrlm5p5ibuQf5XxCe4tOLeMSuX+EfTfXKi+Q=;
 b=CjSDpBMsU2rZBWKfgcdHd0TXF/rG7KGEzKQqLo+Rl+omA0dXwERBuvVFrOG58ERidm3twZbEgPZCMbrLbFBEJf5uM5PtSAoLfzHZOAX4mLDlukNIQy8ERAD/LTt9/ZARMbAr8s8H+wEZNpG6xqDyuxhrKm4TNoYG1tjzW4juhqEzllZQ7tzx9nOGt2jhCWO9VE5yist2qGwU0VIGLqqxA+Y6xfmWkEy0VAAOZ5ZmUv/UWy14RKAAQz4IzxS9g8mKSyztjCtl2fjIyxuRDoijrvUUEfGazDNHuRxNqaZAYfiso+gs/1srfHsGXLQQ/vHKhOzFZti+jl/pzmkyqQWbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:34:03 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:34:03 +0000
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
Thread-Index: AQHaEnYZT2abIZhNcUyoZ5A/RVnRc7B4D5WAgAEtDsA=
Date: Tue, 14 Nov 2023 04:34:02 +0000
Message-ID: <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com> <ZVH3IUsfvzuPaj6L@chao-email>
In-Reply-To: <ZVH3IUsfvzuPaj6L@chao-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CO1PR11MB5074:EE_
x-ms-office365-filtering-correlation-id: 55d40c91-192d-4bef-305e-08dbe4caed9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzfVrL7GTAq0UW1zhacn+xPIuWv9nyv+Bq0voQuVDBugx9Qao7hqcFA5xGEWVkiM0EsWiotebX/zP8POprss3FY3L/I+pBPHM9RRg71ALKnMsOZ/m3l5duM8DIRKDTODUzXDxF6Rg/hSdPPrqpEtFAng7exiOHTdJKTHJ/65EDpZF19cQXh02BwwjDrNHOHYTsl9zq6+OKzQENhM7Mvzh0Eq6jOtzh7d6l8f/uDU6MaxjzQNzuxdAFrxC42Y8vJouaCiJYirKViimdjmMSSi8yab+arM62Y3mndOwU1cD6G7xpTdPIxvVYAceH9sZbVrwT1hgjfCRPSAFKeUw72kxW6sQSK5evuCLPGQ2PksoTtwXrMP288771iI3nyYvjGTvjWlho7oUpNi/xkq4+pBxkIZ+emxPBT3pWYs3OMkbhIbc6GgBskx6DuxUVbpvUTdcPmTVxbviWzlhudqVmCzXqTsgCqvmbfe7TKSdZF8yJaMANPftjrW2F16hYZ7KrcT/6AGiWU5VYnEj5/4KdaG0RfDDUSdSuqBsxpM2U1duxyt9WyaTr7vS++vsMj6Cv447SpEDl65mUKuTF2zUcfp6IfVcmDWUtuZWFmYMrR+qPDWkcLS5JlJu8LhuusJ4ENl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(122000001)(83380400001)(76116006)(26005)(82960400001)(7696005)(6506007)(478600001)(71200400001)(66946007)(9686003)(55016003)(86362001)(5660300002)(7416002)(52536014)(33656002)(41300700001)(2906002)(38100700002)(316002)(54906003)(66556008)(66476007)(8676002)(64756008)(66446008)(8936002)(6862004)(6636002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y2Ws+cJWJl9R9IFxlbJ5UWhs/dVetuxzSMpVA2a5/SxLXny86lfotox7w3vu?=
 =?us-ascii?Q?VUFNZMWKw0JpH0Dr+nMmJ5mJGDmSfqiIm2YoBr1tBSuiqZDzQPHGf4Ux0G7c?=
 =?us-ascii?Q?cfDSrA3BCPIKWYIBTVbqik08OZnPECle0bHmFfFocmLanRH0mi2birx+XTqE?=
 =?us-ascii?Q?qP4ftMqrpqj+Rsc8JsvBHB0WWVgmcB5UIj0jLBQv9lESocnCkjgyDCRPh/vO?=
 =?us-ascii?Q?itsSwyI/nmJ2DccpjiAZjGKhg/Us7rAGsOB5KCp0Z+K3q8eQVZApA/RJUbTh?=
 =?us-ascii?Q?50CSTUHF8ZUrhX57oubYzHQYoy8rTgE2Z6ZsCoQiLFx9ZED8f9amxSLPrzS+?=
 =?us-ascii?Q?VSqW2uOyiO+oyHNNskAyOOB24t/hnIoAX5H6yty8EhiAuBvXDiv3MyVTCwi3?=
 =?us-ascii?Q?mENwIbYVjSha/ZmoDFPRVC0vFMG5DNKGn7wULbbc4aSfuifwKShPHEj+fq7B?=
 =?us-ascii?Q?6Q153wxXVFSsYUvQKlnQF+XaklzpVb9lui/yO/c1KEb6tOa+1ZRqL1pwYbLO?=
 =?us-ascii?Q?ZM54/hA6bz3EIG1vpBJN9Zw3cRPOlfHKNEjQJLdhaIWykZRi82QrDC7ZIqRh?=
 =?us-ascii?Q?BjzEFalVkXZOb08bIFf9NXzEv4HQNTAiEW3AQLoIXu90e9KL8ISzTTVrY+xr?=
 =?us-ascii?Q?hU2awPsyi7J1mw+AMT/iukgU4dsR8+UtFlERxUsgw2FQy816qKniGnv3Je/E?=
 =?us-ascii?Q?sUHI9hu7kEDVWO7VEAYeaEKpQO2r8Q6n//3fd4sYFjFVzUPgO+FIcRiEpIjP?=
 =?us-ascii?Q?2RHy3kqcO6gJo2Qd1EcdGUvej8YoUL2xYkKKzk//vfOrVLYRP0i84I0Nc6kO?=
 =?us-ascii?Q?RoWBMWZQyy6zVV+8zHWkz7FLGMQBM/WGuyA2qW3X3P8QAdXlSrJifM8mh7VN?=
 =?us-ascii?Q?A8MM5k/DztcGecAYRuVlxhIHWa9OjvXWMVKB/lXNF5joqUwnF8Nh6lbpPuRJ?=
 =?us-ascii?Q?5r+sYtbaCoj46TS8rGsBnGmnoGS3bnA3cRAG+tgykgnzf/okmV5FAWW6FJ12?=
 =?us-ascii?Q?ps6tlHNiF2P++1cFEtycS5nHXwBFFpAa5ZRZwsvE6NbqnZqRNUM6mO+wFu8w?=
 =?us-ascii?Q?vm5ZBnIjTcoisYbKbwPzQG5Ig9y8CIngOFhcmVMGFcYR7SbOlEfVnZRHTDhZ?=
 =?us-ascii?Q?fnUT52+1e9n9pY/x+aUfOL3g4SfAezVmB9fOjjjxpcqxLBFosM9ZxOKEFcv9?=
 =?us-ascii?Q?0tePvc4XM8U/BEUPFuxVe4jKmVwJjiGJthVGnSIYFhXuvsBW0TYFh2etQ61f?=
 =?us-ascii?Q?Ehh5g/RDmpwpnVbVR0alzAmgLcflPsuZiMKlYGBOgW4hipEufez5xVT34cdC?=
 =?us-ascii?Q?eOpqgVIdb2U6PocCgseSismYfKCVVRDyRp21uPDQGcxJtCJEVI/U2pBxZkDz?=
 =?us-ascii?Q?q/8LMINaT3Ga8kkiGgo3iU6SfT0t7pKGgohx0n4VARvrrdCewnpYzX1MEzmb?=
 =?us-ascii?Q?aYUv8xScNR0KaEEsDMr69UN9GA5Pb2sWY0wUcvv5bPO3mGvtdd+hc8UMJ4OQ?=
 =?us-ascii?Q?hwsSJhV4nWmIZrp0pkF9BYAtd5vG0aXc62+JjrrWy8ykINzmzeSKshKZT3tV?=
 =?us-ascii?Q?84TTTvj1jvycyG6cYn8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d40c91-192d-4bef-305e-08dbe4caed9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:34:02.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiySNsBczhZvShkNeZY5eRQ/JyGa88+GpEDeeDHo06+w4GWSXMf8cSK4WeP6lLB4fYEEJ2Wwi1hqAtGppNq2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com

> >+			else if (is_nm_fault(intr_info) &&
> >+				 vcpu->arch.guest_fpu.fpstate->xfd)
>=20
> does this necessarily mean the #NM is caused by XFD?

Then the event data should be 0.  Or I missed something obvious? I.e.,
it can be easily differentiated and we should just explicitly set it
to 0.

>=20
> >+				event_data =3D vcpu->arch.guest_fpu.xfd_err;
> >+
> >+			vmcs_write64(INJECTED_EVENT_DATA, event_data);
> >+		}
> >+	}
> >+
> > 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
> >
> > 	vmx_clear_hlt(vcpu);
> >@@ -7226,7 +7247,8 @@ static void vmx_recover_nmi_blocking(struct
> >vcpu_vmx *vmx)  static void __vmx_complete_interrupts(struct kvm_vcpu *v=
cpu,
> > 				      u32 idt_vectoring_info,
> > 				      int instr_len_field,
> >-				      int error_code_field)
> >+				      int error_code_field,
> >+				      int event_data_field)
>=20
> event_data_field is used to indicate whether this is a "cancel". I may th=
ink it is
> better to simply use a boolean e.g., bool cancel.

I'm fine with the idea if no objections.

>=20
>=20
> > {
> > 	u8 vector;
> > 	int type;
> >@@ -7260,6 +7282,37 @@ static void __vmx_complete_interrupts(struct
> kvm_vcpu *vcpu,
> > 		vcpu->arch.event_exit_inst_len =3D vmcs_read32(instr_len_field);
> > 		fallthrough;
> > 	case INTR_TYPE_HARD_EXCEPTION:
> >+		if (kvm_is_fred_enabled(vcpu) && event_data_field) {
> >+			/*
> >+			 * Save original-event data for being used as injected-
> event data.
> >+			 */
>=20
> Looks we also expect CPU will update CR2/DR6/XFD_ERR. this hunk looks to =
me
> just a paranoid check to ensure the cpu works as expected. if that's the =
case, I
> suggest documenting it a bit in the comment.

These checks are not intended for hw, they make sure nVMX FRED is correctly
implemented and catch regressions.

And yes, in the early stage, I prefer to be paranoid.

>=20
> >+			u64 event_data =3D vmcs_read64(event_data_field);
> >+
> >+			switch (vector) {
> >+			case DB_VECTOR:
> >+				get_debugreg(vcpu->arch.dr6, 6);
> >+				WARN_ON(vcpu->arch.dr6 !=3D (event_data ^
> DR6_RESERVED));
> >+				vcpu->arch.dr6 =3D event_data ^ DR6_RESERVED;
> >+				break;
> >+			case NM_VECTOR:
> >+				if (vcpu->arch.guest_fpu.fpstate->xfd) {
> >+					rdmsrl(MSR_IA32_XFD_ERR, vcpu-
> >arch.guest_fpu.xfd_err);
> >+					WARN_ON(vcpu-
> >arch.guest_fpu.xfd_err !=3D event_data);
> >+					vcpu->arch.guest_fpu.xfd_err =3D
> event_data;
> >+				} else {
> >+					WARN_ON(event_data !=3D 0);
> >+				}
> >+				break;
> >+			case PF_VECTOR:
> >+				WARN_ON(vcpu->arch.cr2 !=3D event_data);
> >+				vcpu->arch.cr2 =3D event_data;
> >+				break;
> >+			default:
> >+				WARN_ON(event_data !=3D 0);
>=20
> I am not sure if this WARN_ON() can be triggeded by nested VMX. It is leg=
itimate
> for L1 VMM to inject any event w/ an event_data.
>=20
> FRED spec says:
>=20
> Section 5.2.1 specifies the event data that FRED event delivery of certai=
n events
> saves on the stack. When FRED event delivery is used for an event injecte=
d by VM
> entry, the event data saved is the value of the injected-event-data field=
 in the
> VMCS. This value is used instead of what is specified in Section 5.2.1 an=
d is done
> for __ALL__ injected events using FRED event delivery

5.2.1 Saving Information on the Regular Stack also says:
- For any other event, the event data are not currently defined and will
  be zero until they are.

Or you mean something else?

