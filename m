Return-Path: <linux-kselftest+bounces-67-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F17EA951
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 05:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2476CB20A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9E946E;
	Tue, 14 Nov 2023 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDncFrS+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B09947E;
	Tue, 14 Nov 2023 04:05:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCDD49;
	Mon, 13 Nov 2023 20:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699934731; x=1731470731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RYibocqtJ5NpSPlw8HSh+C6oWGabwT+dVaKE0V9Yzxg=;
  b=RDncFrS+oq4J+DNu4CxWzG/BkMqgsROSFrqDhRjeW6mtFijIRf+i2oSw
   kjwtAlW88nGgWilwW9IolWLARP/V3BcXQYa00O/23ZEDaY5aoNsIwWsaC
   UOFJiiClI94uzVyhlPPOJ44SxCIgZ7xFkRNeZU1Yi99gtEh59y9wuLHX9
   W2T8n1uDF5Vi8kyN0gTpVO2+ex+RGCMUOh6wyKhU+qMQQeW2wn/3C6Dtn
   Phd2pOiaDifmSIE5Qvpw1FPfeH6GGXjjlXJOmlBZbt8YywuexHZgC06he
   /I516uF3ycyA6S3mdwrlGbht9zc/4LN41N+Z0PPDR8mK43z9qjeK4E5yC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3663347"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3663347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937927860"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937927860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:05:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:05:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:05:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:05:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7eUmqCGmbDVRjKUE131/44F1OPwdZU2uGvqDdpzNEyBmv0DjUHp7c3vChQFYZRYWDnYoqS6P+gy8442D5slaAp8QOHxro9s0sOlD8Sl/OqOm57yQ32c38HHT5X4pL3KT6Sux1qfORTZR2cBXp+y/HERRckbZd9hALIXgDXBLd/m7aGqTgMzh8fOoQ/QnG1u/RTqvoW5lE0dPB8dAZl38ypmIzirEXVQW7l8hs/xrCupG0lrmuVGl/k5aLXW5aR9vTfh2TmYRBbdW6/RRbNS3VdjsK/6wKSooI5i7KB+LPqvJzEXaGnY/zEyuZEffzKIP7kZPSPlg/SXEcwR+72ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEDgEP3p4chy5bJMheTFPEIIjE4uiRJeKZg9IxuFiLY=;
 b=aQMa4RetolOn4Kdhvoct5DmNHiPO3etMOok3yvqZe+Jy0DobVdCePZ6KjBqD4wZUIZ13rPJ0Y/ArXvTkrniF5NAUw7SJK7glt0dJclToMrHOULUqrWkjfx2LZjuVrq21j2eFNS9OBcA8eKyuKIK6OA+IuOjJ4q23/wTKzxYeQBNGWtBL7iB452Z2QJTF8TlIviKejxX69lnm/avvFvRfaEoxtbuAarXnr9EeBfrJUwdkT+z0LvcRvwrMcmclPPqG3WyLYr2cvpQLf4DZ+JLbzGVhi5R8Aa19IKdKipM6ffO9PsW7//Y//UTbGlmfOD6dTRdnQRF5SEWcKSjZbu+dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Tue, 14 Nov
 2023 04:05:25 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:05:24 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
Thread-Topic: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit
 controls in vmcs_config
Thread-Index: AQHaEnXtUpNORx09eEG1bKB7uAQ1LrBxr3WAgABqx4CAAJBi0IAA/iuAgAWO8hA=
Date: Tue, 14 Nov 2023 04:05:24 +0000
Message-ID: <SA1PR11MB6734FBE99A7FB30FF4085B7CA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-6-xin3.li@intel.com> <ZUyeATu4Fd2xI0+h@chao-email>
 <ZUz3cPmnqSq7Lol9@google.com>
 <SA1PR11MB6734B37AB5DDCD14A41A6ABBA8AEA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZU5F58_KRIHzxrMp@google.com>
In-Reply-To: <ZU5F58_KRIHzxrMp@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 01aac2d0-057f-41a3-571f-08dbe4c6ede7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r61FqGYksydIBhyMY0OsufCU+Bngvw8PlY3UOFuIYFc63MHSySTEC48Vj59dn0ckiYaXlcM5C3fPn+voPslISQDhkZzYadT9qLDjf9Ii3jxhRXkNcX0nZK+rS0JYwj9Y/wmRUHiLqRUR5lrfg9yFlOdKiCFFe4kfqmmD1/T3nKCLIqB75+QS7jQ1C6c/uGacSJs4kbhpF8oYsVNCqQ1/nxkg/xRCPrruZJY0N+6YzsfT2/uv6niopWHkeuqJbfjG9VqGd1mqo6ZSZEjeA7ab1uzL1pw3+rBzTZJwZAFKdox8TdC13R+5/NS/mdbdEsiSJ/ivD1glr2omSjESu4ojiqhz8uzTsFLm+b1vLIOeuoBvGRqXLPj/ZEOVymR8SloOUPnd8Zxzj0ARBUbHWv/EkICpbY4NPGIUxpzmZFRTGBWdfSz16PRwoRaSA5H6FPExqOfemvccAPGvzIrCTUUUjZQrrOFi2Z7EPQUgCNU+3p40Iq/a4HY0WOyWsYIrDo2KGhPkG0P9LtDkijAM+PhTHvwrJLJnzeeC1ugTS82U46Gh7Bq30zurGq2OFofeHjWlPzIDbQsErtQrgyBpBNgamsbjtty2Hdo5PwrcVYOos17T04jvb0akSdyUv7pHI9BIVrjHr7ClNnTe1ZDeGKA0rEXDmPyxwID+u4poGS8mqMY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(54906003)(55016003)(9686003)(66446008)(6916009)(76116006)(66946007)(316002)(66476007)(38100700002)(83380400001)(64756008)(66556008)(82960400001)(8676002)(8936002)(4326008)(122000001)(478600001)(6506007)(7696005)(52536014)(7416002)(86362001)(5660300002)(71200400001)(38070700009)(66899024)(2906002)(26005)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vx8IfmYX1cGWRXcpnh2ZSQXs5Jbxv+RdatUtwIqk/aIjfDeUbfrVQ+aTnSsw?=
 =?us-ascii?Q?TUX5pfUQnMn8SyEEnFFLLAMViNDScoKcVMZBnEkF5iWcUu61eIurSfZepTtK?=
 =?us-ascii?Q?Ej3P5E9hbYltgzQulg+kGm/Q+3wwF/hRSc+F+i2bKyrRlgsa2mRKkfwr2FDx?=
 =?us-ascii?Q?0HjfTNgVujrgT4CXo09snW200mdiHhNa8jwqPTAN+NA/KlssBi06SuDs8OaE?=
 =?us-ascii?Q?lbS/avLDguyVg3DOAmwWGSMCZyVDZOQrmFydGtIYp532DyMKNhE9IMKccAcZ?=
 =?us-ascii?Q?cWE49XW+LGJ38WjQzMRmDihhpvGhFYIrbG+tv/KpwKDG8wPFqQGprMMP11+l?=
 =?us-ascii?Q?YaODyPk9x/mCD5o8VffK7wdWfwSDtuWwHjy8Ch9auajGkfvg3xUX/oCEGhbO?=
 =?us-ascii?Q?HTq/O/JpLei2jq0J70NIGJBKS82Af6Oax5MchGxuzl3GcFlGpUNLzPymIOR1?=
 =?us-ascii?Q?mO7szUY0cD4uNNI0wl7WtQdac3uBcyPH6QXAbhf968T2M6b0koN99MAERt1e?=
 =?us-ascii?Q?7LpnUr0hbNlXC+JohXuFjNj+XQ/v0lpCJwqUDnuMTISh3Cu7QYT/JwZdJqDz?=
 =?us-ascii?Q?QhYLCZmg5m37qa7JjEUFZtbme+ZLJNZZuQhHLTVQZgfGc2uHwtAMDgFy8Svl?=
 =?us-ascii?Q?EW7dZ02Z5gx57N5qV2TsDCBbh0+XpGSyK9mZgUJhPe2+hd0qZrddfMQ8HAA7?=
 =?us-ascii?Q?rv0hLA+y3oFUrZYLNhJr4XPnQXP+aIRV8mAnGh+VZ7DliusaVXQVVYateJt4?=
 =?us-ascii?Q?tMAv7ThCofVIv/kKDv9ZKzCW2xx0sJ9xmMR2HFWimC9Z0yqaJNV2TyniFhWv?=
 =?us-ascii?Q?BWf8wbWIGWGWowdv69pDYiMmC283iSYD+4KVICpWU8C7kAtL1OQ5/SF8tHFH?=
 =?us-ascii?Q?roZBhScpGl2u4o3vhX8y28TqjaY1jVrqgZvZQElMA51AOUQMnga36ax0ZfFj?=
 =?us-ascii?Q?hnsLimslnT37gH2hgUasv9+J/ePQrIh0q8279NgQnmWZc12d40iYyT9ttgXJ?=
 =?us-ascii?Q?ClxZ9C3CCFkroZfLTVOjsNZod76zxpDfdW3JstihuqswQzdf0GQ3HOeeMW6r?=
 =?us-ascii?Q?l/kujm2PxRqsMJS5bWssI1QjQbbJCIS2KAoGSDp5ZcZ+P7SX8D3s3hKnrsYe?=
 =?us-ascii?Q?wCu3yTN+Us7g1C67pNJVrLsA3RRSbAx0WG3+dr9TBY3tolEd850xnwhWN0UL?=
 =?us-ascii?Q?kaa3001WkhNduGeAzyb0dyNrRTlKcJxUgL+C4vlsQK5KPrOOdlakLYoemOGj?=
 =?us-ascii?Q?+WcnuLO+kd/bH57nTguEWT5K7xXVoZpVTo72rRO9v4OkvFlynZoqWtFwaBaK?=
 =?us-ascii?Q?lgm1tqVdjyEIiFCUgObrZleBiBp3VB2T1aOOf6lNRCss3hRuYYOu7XLmZA9L?=
 =?us-ascii?Q?oFFmBi2GYxxIWXaTTsZr9z7Z24/ggJZ+68kLRBiiBqB0OGfHRbPooytu1uxI?=
 =?us-ascii?Q?F1dshpQEh2DEmEfqx0S8hPzWg55gYCeICubdeWzuJpGl6nrfVoEZR9e7JsYd?=
 =?us-ascii?Q?7/WyMJYAA6c5RQYJaVaFn0SoNcTn2EgG/Uyr05mDN7f8iZy6h+AEMvgUEPk/?=
 =?us-ascii?Q?4jOEZFcOa/JOfQ0hyRo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aac2d0-057f-41a3-571f-08dbe4c6ede7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:05:24.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJasJxxV46coWAcWywcbVEYo+WriNmv+Z2rU/akUFXlOc9u5jvj5JSuvW2PO09SyXq2dSWpVt7Pa2lYcp9lVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

> > > > Can we just hide FRED from guests like what KVM does for other
> > > > features which have similar dependencies? see vmx_set_cpu_caps().
> > >
> > > Both of these warnings should simply be dropped.  The
> > > error_on_inconsistent_vmcs_config stuff is for inconsistencies within=
 the
> allowed
> > > VMCS fields.  Having a feature that is supported in bare metal but no=
t
> virtualized
> > > is perfectly legal, if uncommon.
> >
> > I deliberately keep it, at least for now, because these checks are help=
ful
> > during the development of nVMX FRED.  It will be helpful for other VMMs
> > being developed/tested on KVM.
>=20
> No, remove it.  It's architecturally legal for a CPU to support a feature=
 in bare
> metal but not provide virtualization support.

Like the stage when native Linux has FRED support while KVM not yet?

> > > What *is* needed is for KVM to refuse to virtualize FRED if the entry=
/exit
> controls
> > > aren't consistent.  E.g. if at least one control is present, and at l=
east one
> > > control is missing.   I.e. KVM needs a version of vmcs_entry_exit_pai=
rs that can
> > > deal with SECONDAY_VM_EXIT controls.
> >
> > I agree there are better ways.  But maybe after or before VMX FRED.
>=20
> Uh, no.  This is not optional.  FRED is the first feature that uses
> SECONDAY_VM_EXIT
> controls, so FRED gets the honor of adding the necessary infrastructure s=
upport.

The 2nd VM exit controls is a must for FRED, so I should do it.

I think you mean the consistency checks can be done in a better way (which
is not just for FRED controls consistency checks).  No?

Thanks!
    Xin

