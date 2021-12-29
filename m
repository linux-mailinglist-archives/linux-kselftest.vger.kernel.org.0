Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37029481070
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhL2GhA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 01:37:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:19993 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhL2GhA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 01:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640759820; x=1672295820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7zbY9bsvsLMHLya9iAZXXS/yPinVrFxUIFGqUUDbab4=;
  b=W6HlJ/RUfK82h9oES5Xhx5P6wEc+5tB9f0nhTwgRbLipFhBWR4CGrxSx
   X60gKYB+2P0kYt2NEnYEXjn6BXV0ciJCAxCuoi5BXk/ObBJEPiZOEt0gD
   +/YVim3qZLeMHDiVG/OuOX9jfnhSpBmW7FnH36A7oqslJrzpDj2Q1clOX
   2CkOjanDcSv0S9LzWrLK7OX+OyBRXH9K1ZIs2n/GFSCzx+DXrpZmhA0+d
   YmWTRloOCYVJlGC0pITbZl4plNBngxnan10JEw9tb1q08egNASqsQZj40
   TOOEyqLzZqM4r7hCkDbxFHwl7TTveXHnMzQc5bgqKinK0uFxvmrLRhbdB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265708093"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="265708093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 22:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="666208910"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2021 22:36:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 22:36:49 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 22:36:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 22:36:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 22:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofag2g8lmX0vZwFHIOijQ4bFWDfdUecDDW5ekCx6HdPHkkYze5e1rMT7tbxLkjj43ZhhLTAxJ46h3avdRQzAsCYaM8xLjoTF7CdEif/ZJGIQHMzRRdy82OONpZjydTGry+Z9FKJilnct7sMEK0u+01pSzZaWsJw/XTL8qVj3qTpmpqrEy4wZfoYZ40PQ13MhRe+1Eg8f3nsnYPUVXATPBAp8zPZbwyqgPIHCveZpXrGEiH9uVwVDdtl2Aq5XwhkpjxaqS9ICHvOODH+bARJH8CjsURlanGAhlKlA2cqPHOLX3Sr4RY4VguiBB9Li5OnhJuZSBwA4MWAkPD1TiFLtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zbY9bsvsLMHLya9iAZXXS/yPinVrFxUIFGqUUDbab4=;
 b=QeFgZLWKQYJlgmVgZ2ywZct/5DrIQ0ZaqcNHyjsgyvC+57CG43O9/6ptqnB8KKDocFJbjjdihGpc8kbqvRROlnSduuOcb+rcGDYBMpRfADzhGdjOnQA/XF+hzVg4YZc6EQIiB8IZZ2FasjLcHgCgLWrCM8Btj8v6bs67juiu0YULqrpreFkxm9wgIAu/XaXliNN2bOwFKsSW05FfLyZf7GoKokwdWh+sQsqdjX8m8kGR9b+Qbh+wG3E/x/BSdLDdeZ6qgbKtJyMiW6zUuyLzyynOglkCtEw9x7wOuXrvluRG1Xkxbq+X0LMPkCcqj5MG/ySEbw+2Uk2VIcDdpWb1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR1101MB2196.namprd11.prod.outlook.com (2603:10b6:405:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:36:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 06:36:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Thread-Topic: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Thread-Index: AQHX9zE4nQc2VVNaCkmSJ6dfEGDKnaxIqm0AgAAm9QCAADtnYA==
Date:   Wed, 29 Dec 2021 06:36:43 +0000
Message-ID: <BN9PR11MB5276411D19957E7EA51C53A98C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-20-jing2.liu@intel.com> <YcuuCMCQryzUFoAZ@google.com>
 <96d1266eeeb8434f9e23f9a051e252e6@intel.com>
In-Reply-To: <96d1266eeeb8434f9e23f9a051e252e6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b2234f-48ca-4c91-c74a-08d9ca9594a3
x-ms-traffictypediagnostic: BN6PR1101MB2196:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB219629AB87B2F67C5D2196488C449@BN6PR1101MB2196.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKW5s9QEkhG+Yu1JA0gvoSI1iI2jZLzU4d2+MNJM2Adq/KAqR17hGl/youf7A3qJaO1HOdF+ENM0m6BhEtNDLuil4fPif+9AW+MIqnaw4BLb+9vj89AgHRMSzBkK7ts5rW4hfeQG3fT2OgIEtTRQLtYETM05Amr6HLwzBjcUdiVE0TRx5zYAJF9txZaSUkqsU7sjHHMmXTWs5BQkfbp3rC/kbFEevcpoXjjTJ9YFLa/rTK87bdUUytA0fThhHD50e/BZD/wpwLOTjgCRKY9OoF5aeEdk0Gsz8pfAgbhU9/Q4fHbhruuativSfAmdT91hKF74FChvaNnLrD2uYV8Von6fjuQOFRUMNesmKPczfEtEc6QypH9AujCVHXzSoIiJYixJn2UzYYfH/rxqsooccIuODXjQBpvz5rOfcIPvK5rWUl1sBC56Ca1wNYIT1DwzVUiKq5sMw3o/P4DDN1gZRS1g3MdzAMicNVgGATTnEMjUOTLVzg3JSVqdpf84Ti7pyptOEUTMAdIY3FWcnY0kTy5+Kq/kUdGNzsXUFI92s29uLdiwgaLk0yes3nRMbSX/mfrSDNNa9w9dFPdgf2qJkD1ULUoC3Es4Q88DDhMeUPzjEpUj0lryM3VOcGIOLI5CFoEroJzQSx3wwJL0B0kYm+yHl9TQE/JDrNuBzIphSTdAl11maohPOVfELa2EXO6l7UmvWHb3+bmAiZmjHc7+bXJmiyAd29XHKw4Qyi7vN8aFC7Fto08/jVZQxeGsWomU9wMOY2kpiV7ObVCcGriiuWWtS0zb8v2Hcq4WDaKKLXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(64756008)(8676002)(66446008)(110136005)(76116006)(6636002)(9686003)(2906002)(83380400001)(7696005)(66556008)(82960400001)(8936002)(316002)(4326008)(33656002)(966005)(38100700002)(55016003)(54906003)(5660300002)(186003)(38070700005)(508600001)(6506007)(7416002)(26005)(86362001)(52536014)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/nFYEiyYCdQwgz5weEP8dZZkdr5sC8NErwrzawobc9SpcQ+kBRgC2ctPZO/q?=
 =?us-ascii?Q?grJopTo7gjEosLkfjcLdUsV2R8QqhX63d70j7I3SHpSFPxn6lhZJZ/21tAPT?=
 =?us-ascii?Q?dGRqS+F94B3JVFSNuB9H8pbKFqjbvFqk4tyx4eD8mD1zCBeqrLeGXFpKY5fo?=
 =?us-ascii?Q?JHD12e0V8XX8OuM/YgZaLTlugjMOeMXm1OJEg2HTozK0uCA3FG15e6NNFuo2?=
 =?us-ascii?Q?KlvFfuF6azCBIr4jOyBoibh4pyGUWLJJH/GasK1PJygt3vrIKCb4se8Weaug?=
 =?us-ascii?Q?x1fTRitByOBvIV0qZ+0/X9CxujB+LfVrcMr+YEGknQiobMizw5gDAZKgn1iS?=
 =?us-ascii?Q?eL5Khk/pJVYkx8HVZ50L++wnKO1ev3B1DB1esinZ9LNcCMCtGJR+gNdVSNnl?=
 =?us-ascii?Q?EYKHURJUFY9BXqiT1iKVPo2i64M/swFmRSEUOOBhVfd0O1C+iWQmB0J5OGjM?=
 =?us-ascii?Q?m9PlYA2H0uFYlJHwoTO7w6ugnk85lZuFjNjBRMDT4zej0jSBDwkMaN/ejQlv?=
 =?us-ascii?Q?8edonM4z5dYIs6Wo88KPbdoo+0p638gqU4W2ngq0Zkdx8V0ibc/PDPL1qXZZ?=
 =?us-ascii?Q?GLmS91Uz+G+2x9T4HQvGpAfUptK0nb1iXCsL99Pf3XRNRwQ0yTjLv4iV8em+?=
 =?us-ascii?Q?81PGMZFkNvmlE1SSK15iJBppqhz6PhFYRut9wMobWOTIHlKFWbkkPxfb78sp?=
 =?us-ascii?Q?S8NiMI/SwI8zlqGvi3RCaAp296edp1iqLXzVD9Vx6RmWJfpBjYXhGGZzbjCD?=
 =?us-ascii?Q?aj/2eM5MNdQ9D8xJ95oo7iWpKwb/MgmsCzjz6QJoWa42NFFH65jRFFBZ6qLG?=
 =?us-ascii?Q?WVf11aYn7w8y5dpe2lCnvU/HlNOPwZQphY+7d+6c8DHbaVgMwX7qgmKfqEY8?=
 =?us-ascii?Q?dKie+LmsUkgqWi9Lylgpa4xuldZYyo9Nw+RUS3Hs4YQGKYr6htE8iTyLl0V9?=
 =?us-ascii?Q?Vk6Vc/gwjKAIlsvrz98xrN6eBXOWqyciOvE9iJNEW83Ao/wBxNn0n9mAUP5a?=
 =?us-ascii?Q?yuVdcbuAwx8YRjNlrVuJvFfRd6JsmJpXTBhxk6fpH4CSIiv36hcswC1uqHPk?=
 =?us-ascii?Q?N1QBrNU6EuM2N0C+FyVPdbodijW9wKnZqGyEA4zCKE7+XRf9HiY3zDw8ipP6?=
 =?us-ascii?Q?ZcWvZ2sngOzTtqXgVbHOgOo++wtFxCLF+51E8dnLCAwBkNNqfFfJeyh0PxtW?=
 =?us-ascii?Q?YqL63E2xR/n58IFHdN5AKQ0jcFUVj83pZQKJWq0wtiCS2TyHdvWw1M6EON82?=
 =?us-ascii?Q?gHD24o89+JthpU6plHeyjE0aRvZA8Tgt+j7RFXT0T6Aw6CJMQ14Rd5NnuNbl?=
 =?us-ascii?Q?HFrWL35HG/tUWfDk5Sww6BxcmsiroB/fKGX4K9eun+S1FyOFzM9L+7HCCxno?=
 =?us-ascii?Q?xsDs5whkzpjVwtPYdavurjjFCnrP3SKQf4sOrgWh4iahen18e9ZpYgw7lzNB?=
 =?us-ascii?Q?Vg2+p5ECl9WaWjpZjv2eKPB8Yg+jWBO68CUl9r5UlkwJohB27VIZp02HiPtM?=
 =?us-ascii?Q?TksWJA8HQU6FBiU0LN9P5SfFsYxwOSpEaGklJOe0LPnb+heU1/SH4MqA8292?=
 =?us-ascii?Q?1XGkqkXZfTriauiaUJ87Jk0dOLjgECAE8he14RAyfAdTRWBcTsmfbWf4YtKB?=
 =?us-ascii?Q?7cx167gtDn18SPf42LGUjt8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b2234f-48ca-4c91-c74a-08d9ca9594a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 06:36:44.0075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpAZlBdWyLdwhp/xMBBxymYRXpXdzjXzVbLG6KqOen0/lHwdAaOhWO65fF7n1f1K6STBxRx+NicOptO/ZIbGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2196
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Wang, Wei W <wei.w.wang@intel.com>
> Sent: Wednesday, December 29, 2021 10:58 AM
>=20
> > > Reuse KVM_SET_XSAVE for both old/new formats by reimplementing it to
> > > do properly-sized memdup_user() based on the guest fpu container.
> >
> > I'm confused, the first sentence says KVM_SET_XSAVE isn't suitable, the
> > second says it can be reused with minimal effort.
>=20
> Probably "doesn't support" sounds better than "isn't suitable" above. But
> plan to reword a bit:
>=20
> With KVM_CAP_XSAVE, userspace uses a hardcoded 4KB buffer to get/set
> xstate data from/to
> KVM. This doesn't work when dynamic features (e.g. AMX) are used by the
> guest, as KVM uses
> a full expanded xstate buffer for the guest fpu emulation, which is large=
r
> than 4KB.
>=20
> Add KVM_CAP_XSAVE2, and userspace gets the required xstate buffer size
> from KVM via
> KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2). KVM_SET_XSAVE is extended
> with the support to
> work with larger xstate data size passed from userspace. KVM_GET_XSAVE2
> is preferred to
> extending KVM_GET_XSAVE to work with large buffer size for backward-
> compatible considerations.
> (Link: https://lkml.org/lkml/2021/12/15/510)
>=20
> Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.
>=20

Revised to:

--

With KVM_CAP_XSAVE, userspace uses a hardcoded 4KB buffer to get/set
xstate data from/to KVM. This doesn't work when dynamic xfeatures
(e.g. AMX) are exposed to the guest as they require a larger buffer
size.

Introduce a new capability (KVM_CAP_XSAVE2). Userspace VMM gets the
required xstate buffer size via KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2).
KVM_SET_XSAVE is extended to work with both legacy and new capabilities
by doing properly-sized memdup_user() based on the guest fpu container.
KVM_GET_XSAVE is kept for backward-compatible reason. Instead,
KVM_GET_XSAVE2 is introduced under KVM_CAP_XSAVE2 as the preferred
interface for getting xstate buffer (4KB or larger size) from KVM.
(Link: https://lkml.org/lkml/2021/12/15/510)

Also, update the api doc with the new KVM_GET_XSAVE2 ioctl

--

Thanks
Kevin
