Return-Path: <linux-kselftest+bounces-1250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2D8069C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 09:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFC81F215FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD968111A8;
	Wed,  6 Dec 2023 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrWybxzU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1BD3;
	Wed,  6 Dec 2023 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701851864; x=1733387864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LhkdOkCJj052LvhzCGAo/50vV/3GT8Dk17wptkGStSQ=;
  b=SrWybxzU/fNNo4+/W8jfAtaxgzLyfD7XWb9g9Oz8iBxtdLv+U5CSt/2f
   4179wz4p5PbD3FwIGzzfgVaIFTfJovtExMLOpUwtqbNX7upTK7E3hGJB/
   MOOwK89WE3AkOo30HVYd78F10doN0ne1kKG1pa8DF0aZpWKXt4fTXMWYJ
   tn35VbFNs6zp89s6wQ9D3XzZY7JinHkBjDdM9lqt195kFJMMO18qZ7c9b
   /jJwXsoXXLlQ9kqexGIEMJFk6UClQRkQzibpIu2y79O3IO7uC4+WoI1ft
   5lAzaVez139uX7MYUUyhSb3DfZCF84JMVgv79wuEIFAVLBLkvIDv84yz1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374207727"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="374207727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837243941"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="837243941"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 00:37:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 00:37:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 00:37:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 00:37:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 00:37:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMt1jaE0PSsKjh/lW9mjs7IXbMe3gnEmX83cvaJTxO6dot6rERys6bpfZVL6RE2lH6Elsfax4PEY+fsWfzGxSPmIt2MtId1HEiUJTa01JxhpsSiCxz0+TokL0EU3p0JV0574z2iweMaT4UfuYD/BU3ROsXgGCD4gnsIaPT5STWTLyftrrAHUWX3AL63SOw4Ka9e3rHp5Nf5lXrbjfG6wCZaBqSOdBxoGp9SkMPS7CMKYD07lRQwnBSwkMl4EA+NX+fva9SJAUGTE6J6zTC2DMzMnlqGeCfEQD04I1rnMwAW93fwioUgfe8svivLUn0zRp1Ane60kLJiG9LAQhwHGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeKtL401MT+h7lonnZqVcY5dmrvPG7ci+cX3NWotrHI=;
 b=K6ZtYzsMjhXYSG6d276HgILN3JcTBmZMcOXoQB9vIkjXFrMjZR2QcbyzWeEixDUAcd5XcgTScfvgYJCoorH+df6yuAAcGsOkzgolf8tG0lyOuxPxT2CiI9rgyp2ZGTv9h9QE/xL/sKk3mthCPbTmyxpcyW0ip7UK6fabIAJbJmbNiU6GgMWl8HEYiicDESv6M2aOpUPul9aFrfh94IQseyySD6yuYhsSaI0hbypOiKXz+hHo0ZXVfGz6k4zygxDEo9/w+JiHYljZU74omT9ddQm97QU5/JDtvkNbwQvphK+eVnbPAFrNBoKs2jPq8oW711rcr7IfzR2l66PNazfn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 08:37:39 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 08:37:39 +0000
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
Subject: RE: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Topic: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Thread-Index: AQHaEnYXOQlvFLhpWkG4lt/jksLCm7B5dqYAgAFC3tCAIVOmcA==
Date: Wed, 6 Dec 2023 08:37:39 +0000
Message-ID: <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com> <ZVMkVmBPVfaMjDTL@chao-email>
 <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM4PR11MB5325:EE_
x-ms-office365-filtering-correlation-id: 01ec035d-a8da-4362-1848-08dbf6369b2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thCCOwkwq/6Vrm0c3Th0rWb2HzysjVumgf9+KXM4fUoNMPb/Di7vwPg/N2OGkzGIgzU9tMxNN47BcQ+XbZs3r2UD5uV1oZVkr17+tOoRsPDV5bI6ZRPvxkjKAcgrY3tKJsFcvJNike4+cMhyiIZ+HrMPibHa+30zKj6jVeKQ2o5piNq8RtxU5iZiyEkMZvjDuICx73g8y83QIe2v0BowzOlv4rbCvKy6oH8Glp12ToSOHdmXGH7b2IqQuY0IMEmaHoy+9k3aCgi/tW89vniIC+5nrjgS4W+X0zLMxQklsCqSxdFVIC3HXrMa7Qutqvy85tKKsroiHCZK3IOeqwy39G/E8Bo47zvqf3mhDjIFPTrG3LBJBNA8tjtwjfBnAnmwhn1zIiCiq4FIQgMAI1ljKcBianq1nSeLWDVy+Xesb5dCwUifTl8Ess0emi4g/Oz8Fdb349znLzF6CoBGIXjXfeSjR6Sm6SZqT1ihwZS8qHM9GI7R1xzVxPXOsBG2+T7A3bqW/dIdwno1SKlHgGZki7RPcghRCZCD/uiX/l2aKV1afMvqtMJAlC8zP5ZT7EpEN9jHYXpieS3REb72Pw1xRTRuEUynUr9bPAQbvvP429zcsRtgQtOhwhzhJ6pmyI4O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(2906002)(33656002)(316002)(110136005)(54906003)(64756008)(66556008)(6636002)(66446008)(66476007)(38070700009)(66946007)(76116006)(4326008)(8676002)(55016003)(86362001)(52536014)(8936002)(41300700001)(5660300002)(122000001)(38100700002)(82960400001)(83380400001)(478600001)(26005)(71200400001)(7696005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDhCgrtp88cAbSyKq4s2HQv+kVtp189HnRkmrqhtId7GfUoBM3Osil4kh1gK?=
 =?us-ascii?Q?4PjbaAyhkoM3GQtNU+hXtVYwKNsXE6wlToKhEx/zQdiZ+ww8yaHWeg+Q0CI3?=
 =?us-ascii?Q?l4oSciq938zZahxzAAp4ybMATv6fY4u8p5YjjrV4n2IUcBwtIrPWn2E6Ue31?=
 =?us-ascii?Q?mOBhotE5W/kzMXpJXebtcP1YcIXysHSjSF6Zc7KM0dRUOJ0IuZ5hnLNFOHk5?=
 =?us-ascii?Q?BgJJjHn3Y+mhEYiX4osipxvC5uIyAKGlIq5dF9ytUVlexjOddL6HtOtmNMgW?=
 =?us-ascii?Q?wfT3nN8mWTiaCo5I+JcPB0/jeCYkf+Z2uC2u3CfX16b2a4k927S5aSs3unCG?=
 =?us-ascii?Q?Vkb3Lokt4g46Y4jeqx9u9GEEAeO9wkWag6rBVMTj89sUJBUl8CVWf425bOOG?=
 =?us-ascii?Q?lpkNpClqxmGD1sAVWZm8T12CU873ZqFXzUySlVyFmMIPB5qkoi6t8UigtKze?=
 =?us-ascii?Q?bvk41uf451XvpUzvu7w5qKcK57JKaC7RhOqgt1Ow4BAJvFN/uJhCxgEf6KP/?=
 =?us-ascii?Q?G4c1cerr1suSlOUNiZlinlEuw/3RIY2YSBc9QMJSWvrmGrkNaOOCXVRKjt9S?=
 =?us-ascii?Q?zywKnjfdV96/4X8QKGJk9dNVL6jFzL1VnbFs1xuQ1pp1K+prTwp0ZTjG2mZk?=
 =?us-ascii?Q?xlCwZ+GOogt1kzgcUehsZFA4WWT4EWLvouIk8nL3geB9WGkboWgD/ZgOPwM4?=
 =?us-ascii?Q?Wvh2cTsT7hDUdM+Ar/BxVsnhkmd1EB5cMiGf+mpFcBskjoAMdB5CpLQ5K0qX?=
 =?us-ascii?Q?lL05h6jrlf7GLe2GJlH2913bsw08II49gUjl53AwFsrhY14VFhNjW21tinzD?=
 =?us-ascii?Q?FqWW6sCMb7m3DHIvAG+CaOHK3UHEP92Q8ElRnrYOEDNp/UifD65GTzW4pk16?=
 =?us-ascii?Q?tAlped/A8qVtCd6sAM52OcshDSjm9sQKKVcWpxdPvWmlB9zuesWQxhvy5bsv?=
 =?us-ascii?Q?Nhf2kzcHqgxQmI77hXZVHsBIYuA6ugSMrZyZhq54cFBEsl9Oz9N9Yev2pbC+?=
 =?us-ascii?Q?tOltEJVpqUymMgTGIqcdkLqRC+QQCXluwCcQBQgNRgHLqE5najnUSfg/lg+F?=
 =?us-ascii?Q?a0QFKymMuslnMKBC4371tXvrWGyEXzvsVGuoc+95OmFl1eBnFFT1bPQX+nhY?=
 =?us-ascii?Q?Tg/5efY3T86qtQR/IhRpxKlETGOXx64g18j7qFmeth9Aloenw44/zzz2idvG?=
 =?us-ascii?Q?5Edz8O70AaMk+yWry328E8qBD1oCQPucC1qFRBXyDAWDWSMxYgvqpd/6qlEE?=
 =?us-ascii?Q?sNQuE8xFfkxP312OyPt3tZekfZSSTnm+nTUFhLKtofFTEYnwya+xSIq64X59?=
 =?us-ascii?Q?iPq8ijuHSXwPgmqlrHozAEvOVZezD6tnoD+qOV6NTuot0eVmeIAZIfgxAW7P?=
 =?us-ascii?Q?Chg5fxmUrYFGNyVKEbqXu9KeaiEvF3LJlQ2wcY1F5Gyay7ALngnsFZv2Jm4T?=
 =?us-ascii?Q?PDLJrsAqB72CVPE7npNNBHRP3MQymdcZNI8RFSpeVDGAGmF9ihCCee5s6SeQ?=
 =?us-ascii?Q?oEgma0wcnKkvUxvN/F3mVki6ZUOmQPmZE0oo4XfxNI4GpTAHSFdu2QfPHoWH?=
 =?us-ascii?Q?IdD6/anydC6mRdr0KXI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec035d-a8da-4362-1848-08dbf6369b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 08:37:39.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlJ2T55eEp+fbdxDc7gLoI2T3LARUmoLKskOqBjFbwA1JVPPCl1DaS98YwbEpEwd9Zo9aqir6ufnmB0HGrd3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

> Subject: RE: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for F=
RED
>=20
> > >+		if (idt_vectoring_info &
> VECTORING_INFO_DELIVER_CODE_MASK)
> > >+			kvm_requeue_exception_e(vcpu, vector,
> > vmcs_read32(error_code_field),
> > >+						idt_vectoring_info &
> > INTR_INFO_NESTED_EXCEPTION_MASK);
> > >+		else
> > >+			kvm_requeue_exception(vcpu, vector,
> > >+					      idt_vectoring_info &
> > INTR_INFO_NESTED_EXCEPTION_MASK);
> >
> > Exiting-event identification can also have bit 13 set, indicating a
> > nested exception encountered and caused VM-exit. when reinjecting the
> > exception to guests, kvm needs to set the "nested" bit, right? I
> > suspect some changes to e.g., handle_exception_nmi() are needed.
>=20
> The current patch relies on kvm_multiple_exception() to do that.  But TBH=
, I'm
> not sure it can recognize all nested cases.  I probably should revisit it=
.

So the conclusion is that kvm_multiple_exception() is smart enough, and
a VMM doesn't have to check bit 13 of the Exiting-event identification.

In FRED spec 5.0, section 9.2 - New VMX Feature: VMX Nested-Exception
Support, there is a statement at the end of Exiting-event identification:

(The value of this bit is always identical to that of the valid bit of
the original-event identification field.)

It means that even w/o VMX Nested-Exception support, a VMM already knows
if an exception is a nested exception encountered during delivery of
another event in an exception caused VM exit (exit reason 0).  This is
done in KVM through reading IDT_VECTORING_INFO_FIELD and calling
vmx_complete_interrupts() immediately after VM exits.

vmx_complete_interrupts() simply queues the original exception if there is
one, and later the nested exception causing the VM exit could be cancelled
if it is a shadow page fault.  However if the shadow page fault is caused
by a guest page fault, KVM injects it as a nested exception to have guest
fix its page table.

I will add comments about this background in the next iteration.

