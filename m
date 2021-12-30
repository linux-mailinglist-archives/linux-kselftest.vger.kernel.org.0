Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3F48187F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 03:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhL3C27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 21:28:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:60678 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhL3C27 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 21:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640831339; x=1672367339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PRkXvUwKrHAff4FGMIMmVvXr84sFXsIeUDzsmQbWe4Q=;
  b=JNYRXIKpqPD/TLPBK32rH8+Kr+q9+3FoF+/nQfhnWoDnX1ZuqMnWmCh0
   /txatCVzNjMwHiDag8thASAnzIeeFFTEoNCACHrOc3I3DbhZBanbS217o
   LU8YdKQcTjwQ0zTaNlRdKAMxiAUOmRPuLufMcXU/dsJ4YXzv7iT1MhvxI
   eIyls5ahSTdGB8bzfwbr2xCQpDIJceM9mgVPeNhzrCYPtZAmZm3NXQwQN
   XnfHyxdpApipgpE25F/Qb9Wm7w4/StrQqoZLWVA23CXHZgyQ8q7iqnj+Z
   NXvocU0r73S5Fs7zrVmi+WuHbjxQAJAkTh6zuoDNNJpPGem7pWYQbwn/Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="327934435"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="327934435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 18:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="554671435"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2021 18:28:32 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 18:28:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 29 Dec 2021 18:28:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 29 Dec 2021 18:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy8iaIexv2vgBed+mJFukcBgzYV9sKbq3UGjL6bMdTAaCEy7WXMDN9IDqm9OXS9j1kd51YGTWCR88iDQNyhdE/jmMVPMik5qVmaT9FrL9mUNWrIw/GRwAKi27tQCK5wlde+oY39uXSKs/ZHUvDWCNvGhYKmogsRmI0uUWO2lrggl35p+Zi/mR2ey755JwZhAvTcfEEBFAieh9TEZ+DiHETLtrQymQBgfLuN8rY+Tn2+/A/hzKRYQrMCHkXc5J8qiOU3/pcDQVyRv5HmeS6vpx3jXAVcPsnmqzTflsU70eOnhwPpWLMzAxz3mDUucG0UtXgkcUQWuBfYdw6cnpm8iRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa2KvMLEQz7wtM/CVk7mmHiWpLU+Js8ajJk6nMRNZZg=;
 b=EH+czcCJ5G8Raz8ykOhfI8b3jqS1n2O8ARjzK2FW/zISxlPYH/HwbJNSPzhVA3lGBg0/lupOaR+8vyViFJ2NdcHnA8FAM48OyIs5oMEMd2F/J3j17fFEJS4a0RFvKeJkpXJYXWLaLkh7iCXJjIsI9C7AjvqHwlaQRY8U4rXzi1a+mBDItSD9aB/Yx3aHuoumQ1YzzEgl6MJQT60pbUuXA+mbaN0iqP+WDAoZSaQUJuQVGxV8lPd6BEBG0+b9h7PzD1g76qj0S+cTXiFARMYBE1LW5CnTsLCRQ9BMW3Yjzb6vcJZoRQatj3NNRIyXtsj6vQHXJCoNHQoUNgZpJiDQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1490.namprd11.prod.outlook.com (2603:10b6:405:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Thu, 30 Dec
 2021 02:28:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 02:28:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
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
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v4 08/21] kvm: x86: Check and enable permitted dynamic
 xfeatures at KVM_SET_CPUID2
Thread-Topic: [PATCH v4 08/21] kvm: x86: Check and enable permitted dynamic
 xfeatures at KVM_SET_CPUID2
Thread-Index: AQHX/LXqR7g9C8kko0aEdnXcyLdjPqxJsEYAgACbssA=
Date:   Thu, 30 Dec 2021 02:28:25 +0000
Message-ID: <BN9PR11MB5276220CE6BE21025797A7BC8C459@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-9-yang.zhong@intel.com> <YcyS8lG7vq+jJtLy@google.com>
In-Reply-To: <YcyS8lG7vq+jJtLy@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6cf03d8-ee66-430c-03ab-08d9cb3c0ee2
x-ms-traffictypediagnostic: BN6PR11MB1490:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1490A8EF0C681C7BB387224D8C459@BN6PR11MB1490.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNbW7+UdvmYbikr4vSDNoxEUPRGwk2ZrQtbU8ctdqj5tNiQvovSZ1xyJ0oA3AEe1MtHe0FBiJ+tR6bMVD9/eqZ6wJE64+Ity6RRWvOcexK57jAlURB8y92PPpeSSExLnsTcn/TUjPXZkSHjYlCK7uhGpx4MllQSgtTTOcSpSCAvkFfiIzcDHNDjZkRhhhX4tjgDElubA+8zHjUXInzXS53HyDp1TlfK+sJGlERETZSqEl1Znv7szGGWYwuqFZkc12wNs9PYEn8xRvd41IQf3hBAHychjelbbG1pXsGb/HV9ItWrGOlRKuXMckz6+eEsRSTsEBCIen2emrdDosBL2C0JdI5JfAJQp57qO2SIeWjJreazYLItKQ0xkknWNmH4Wzf67mjYBju0BF39XEg07I8qKyvweDTJFXOW7PgyGcmQzssrBeMSSg485e67Vh8Mv1IFNC7lquNmXlmu+P+QMLoVGQGl7CWw0PcYlW+VKo0Y7jKA597j0zeaDlDlRzeArMyghv8b6AtexFrI4zV5Hk3iF2RmWVyEqZ1yNJZJmsqwLtffQe7Y9Jaevy72QyRnrUCRnca2M0MOkeCJbQCfD6otpqgk1wlwmQpeQaD9v+wNJ+F4zXcCQKzcRRSpjySO/LXcjdOQmk8dH3VV9rOwSUiZT/L04PFxlC/bmthU6ChZFUO658EfSwz0lmdMnsIO/QbHTUvgbhofX1hMPYFINJHfKozfPC8bCnmQMGjFL6xROliyO26WugFTyLk7dywsh1LGdze3Mb85XYbTUsXSgoCltyyHMUqzA0PUZSp24rt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(316002)(38070700005)(6636002)(82960400001)(4326008)(55016003)(64756008)(66556008)(66446008)(76116006)(66476007)(26005)(186003)(66946007)(52536014)(8936002)(110136005)(54906003)(7696005)(6506007)(8676002)(7416002)(508600001)(2906002)(9686003)(71200400001)(38100700002)(86362001)(122000001)(5660300002)(966005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pSNg7hraVIXmx2fpnqq9VNWR0WvjCW9RZ0opEuVgD6amLLa4yzzqsL93cTUf?=
 =?us-ascii?Q?NgjF1pY3ehvQfI+pPp+gNZ94yACD3LhcdnqvVNpWZP54OOvoSucOAtmC84ig?=
 =?us-ascii?Q?G630+TFvzAgC/pc0ez/5aqddKFF2jzz5bsEN1yla0SDdBXN15RRZQ+GRdqC0?=
 =?us-ascii?Q?MCt5T3jpcs8puqZowXLlvzNpaVQrNh/2hWiGuRg9P1ps+E9TdQJ5txwvIX78?=
 =?us-ascii?Q?xoSRVdrXLrHoiDsp2P8OgistMvra8kkj3aHIoN32AvhyqH1BhBDIkZRjmBGi?=
 =?us-ascii?Q?XextZB75kDbf6R/55P6zqzqKd2LDeI4eo+OL6G7V1jN7M6GzsEUXlvQtW25G?=
 =?us-ascii?Q?rXmoYeDsBSNFcqt2tT+vX2j/wyUL883OvNfHVGemLSJu2zzxeXrzbHLB8Cay?=
 =?us-ascii?Q?JZzU833Xx/bptZJksJOk1OQ2tkGmWtEefEocIjNBrLv7lTuz/JlucxSJ0AcK?=
 =?us-ascii?Q?P4g2R4heHEklQ8y7y4vzsY+oMnFLNgUFYfMd2ahEHi0MTWv2eRSRB7QJsSYc?=
 =?us-ascii?Q?6WWzkWhdxJCqrse2nfXDSJ4/ySbr3sMebxex4tciSW0A09RE3aG4FRM1Y+bL?=
 =?us-ascii?Q?+fSuClwzY2doVETUiKlJWk7T33JHqjwQr3lXARMAqKxfnWP0qusL9ssXD+bP?=
 =?us-ascii?Q?DmrtYH0ZD83Pn+1SnjfplpYbH0PzlVDymRYUtKSbuuP3HrI4F8rPBQ9ivnlZ?=
 =?us-ascii?Q?94BHXdxHFpypaKiUN7Iwxq+xn2oWGsUMjjAWiQOESNYjDIUNEfm5Wxv3ihHM?=
 =?us-ascii?Q?NsmrvkR2XGGwqiVuUUSBuxwFTjEGxZUNnIegTsf3cLdsWNum/vT3DCpK5gIG?=
 =?us-ascii?Q?nxqGOa7yx2ErywVhctuT8hJeb7RdGJ4JoYh24xyVhvdvD6ieOscWWYscLBYg?=
 =?us-ascii?Q?z83VNaky7GOcH0ONyOsL9NJE3wRzA+dEIlb1lrZDHXwU4OPgWz7AKiUQA5IJ?=
 =?us-ascii?Q?voyAHvC9wKaeUwu103G+Cm1yrIbptk4jno3/7wX9SXuRlxvoCOdCJfEGQnKx?=
 =?us-ascii?Q?inb1KTRmxskpZFgn6hGuX5RK/Ca+x/QywmtkbYtXeHJ5p90zvXrrkAe1mTCW?=
 =?us-ascii?Q?ePLj+czqDPOplxJTwGk/YuEB9wQ2HNasmfXwMx4pqpNq2O9FP9YWoZ/oqIgJ?=
 =?us-ascii?Q?z5D6WE3Amv3+IyMxX70sNbw6rUM7N1l5d2+atmId+Zx/i48fmESitZYfqsGj?=
 =?us-ascii?Q?CHQdn+10O/aCshOc5dkk5Fckb/FohlbiiI2kRsup/+/cMERkGlijKrD741Kb?=
 =?us-ascii?Q?8KYkmvjtfjsISIall4PzB05ZEIMfe+5yteE627TmanyEphnORnA6m+QXpgz1?=
 =?us-ascii?Q?vED5goBTrKQK9N7/3Y2y99zTQEYZ7aE9Y78rua3uwqi7DvuuFae4+wNlNjCb?=
 =?us-ascii?Q?NflvVOkc3MRBFcpA8twr7HpFo16bSgC/QzhLjXOvMY5K1xgZk6zTnYpOXsQD?=
 =?us-ascii?Q?ktOSQB9YMXdvfeFbiNjCCKCRHm9nmVri5dPw5IbWp52EMuAkBeQCtUsoRb/o?=
 =?us-ascii?Q?HKNFs5N4corcqT8zM/jEgA8wYELLn4LPZ5HDKJ5a9uJUUa7qsVgA97URaPAp?=
 =?us-ascii?Q?rrcGuqDr1nTt9bxRMxwiPTJHnSPBkxz882uuCpPccpLOfWBA+fw9qVPPea31?=
 =?us-ascii?Q?6KtyC9MD+pyrJZ9HddkiBTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cf03d8-ee66-430c-03ab-08d9cb3c0ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 02:28:25.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50mq00UAg/4FW4fw5J7Q/7r88woYcUAfViWbVfvjVPT62EBDRDbWQPsQdoL50EcMIUMQu3KoUeJN8+akTy8EKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1490
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Thursday, December 30, 2021 12:55 AM
>=20
> On Wed, Dec 29, 2021, Yang Zhong wrote:
> > From: Jing Liu <jing2.liu@intel.com>
> >
> > Guest xstate permissions should be set by userspace VMM before vcpu
> > creation. Extend KVM_SET_CPUID2 to verify that every feature reported
> > in CPUID[0xD] has proper permission set. If permission allows, enable
> > all xfeatures in guest cpuid with fpstate buffer sized accordingly.
> >
> > This avoids introducing new KVM exit reason for reporting permission
> > violation to userspace VMM at run-time and also removes the need of
> > tricky fpstate buffer expansion in the emulation and restore path of
> > XCR0 and IA32_XFD MSR.
>=20
> How so?  __do_cpuid_func() restricts what is advertised to userspace base=
d
> on
> xstate_get_guest_group_perm(), so it's not like KVM is advertising someth=
ing
> it
> can't provide?  There should never be any danger to KVM that's mitigated =
by
> restricing guest CPUID because KVM can and should check vcpu-
> >arch.guest_fpu.perm
> instead of guest CPUID.

Well, above explains why we choose to expand fpstate buffer at=20
KVM_SET_CPUID2 instead of in the emulation path when required
permissions have been set, as discussed here:

https://lore.kernel.org/all/20211214024948.048572883@linutronix.de/

>=20
> In other words, I believe you're conflating the overall approach of requi=
ring
> userspace to pre-acquire the necessary permissions with enforcing what
> userspace
> advertises to the guest.
>=20
> > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 62 +++++++++++++++++++++++++++++++++----------
> -
> >  1 file changed, 47 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 4855344091b8..acbc10db550e 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -81,9 +81,12 @@ static inline struct kvm_cpuid_entry2
> *cpuid_entry2_find(
> >  	return NULL;
> >  }
> >
> > -static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
> > +static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
> > +			   struct kvm_cpuid_entry2 *entries,
> > +			   int nent)
> >  {
> >  	struct kvm_cpuid_entry2 *best;
> > +	int r =3D 0;
> >
> >  	/*
> >  	 * The existing code assumes virtual address is 48-bit or 57-bit in t=
he
> > @@ -93,11 +96,40 @@ static int kvm_check_cpuid(struct
> kvm_cpuid_entry2 *entries, int nent)
> >  	if (best) {
> >  		int vaddr_bits =3D (best->eax & 0xff00) >> 8;
> >
> > -		if (vaddr_bits !=3D 48 && vaddr_bits !=3D 57 && vaddr_bits !=3D 0)
> > -			return -EINVAL;
> > +		if (vaddr_bits !=3D 48 && vaddr_bits !=3D 57 && vaddr_bits !=3D 0) {
> > +			r =3D -EINVAL;
> > +			goto out;
>=20
> Please don't change this to a goto, a return is perfectly ok and more rea=
dable
> as it doesn't imply there's some functional change that needs to be unwou=
nd
> at
> the end.

will fix

>=20
> > +		}
> >  	}
> >
> > -	return 0;
> > +	/*
> > +	 * Check guest permissions for dynamically-enabled xfeatures.
> > +	 * Userspace VMM is expected to acquire permission before vCPU
> > +	 * creation. If permission allows, enable all xfeatures with
> > +	 * fpstate buffer sized accordingly. This avoids complexity of
> > +	 * run-time expansion in the emulation and restore path of XCR0
> > +	 * and IA32_XFD MSR.
> > +	 */
> > +	best =3D cpuid_entry2_find(entries, nent, 0xd, 0);
> > +	if (best) {
> > +		u64 xfeatures;
> > +
> > +		xfeatures =3D best->eax | ((u64)best->edx << 32);
> > +		if (xfeatures & ~vcpu->arch.guest_fpu.perm) {
> > +			r =3D -ENXIO;
>=20
> ENXIO is a rather odd error code for insufficient permissions, especially=
 since
> the FPU returns -EPERM for what is effectively the same check.
>=20
> > +			goto out;
> > +		}
> > +
> > +		if (xfeatures !=3D vcpu->arch.guest_fpu.xfeatures) {
>=20
> xfeatures is obviously not consumed anywhere, which is super confusing an=
d
> arguably wrong, e.g. if userspace advertises xfeatures that are a subset =
of
> vcpu->arch.guest_fpu.perm, this will expand XSAVE state beyond what
> userspace
> actually wants to advertise to the guest.  The really confusing case woul=
d be
> if
> userspace reduced xfeatures relative to vcpu->arch.guest_fpu.xfeatures an=
d
> got
> an -ENOMEM due to the FPU failing to expand the XSAVE size.

You are right.

>=20
> I don't care about the waste of memory, and IIUC userspace would have to
> intentionally request permissions for the guest that it then ignores, but=
 that
> doesn't make the code any less confusing.  And as written, this check als=
o
> prevents
> advertising non-XFD features that are not supported in hardware.  I doubt
> there's
> a production use case for that (though MPX deprecation comes close), but
> I've
> certainly exposed unsupported features to a guest for testing purposes.
>=20
> Rather than bleed details from the FPU into KVM, why not have the FPU do
> any and
> all checks?  That also gives the FPU access to requested xfeatures so tha=
t it
> can opportunistically avoid unnecessary expansion.  We can also tweak the
> kernel
> APIs to be more particular about input values.

All above makes sense, especially when we combine permission check
and buffer expansion in one step now.

>=20
> At that point, I would be ok with fpu_update_guest_perm_features()
> rejecting
> attempts to advertise features that are not permitted, because then it's =
an
> FPU
> policy, not a KVM policy, and there's a valid reason for said policy.  It=
's a bit
> of a pedantic distinction, but to me it matters because having KVM explic=
itly
> restrict guest CPUID implies that doing so is necessary for KVM correctne=
ss,
> which
> AFAICT is not the case.
>=20
> E.g. in KVM
>=20
> 	/*
> 	 * Exposing dynamic xfeatures to the guest requires additional
> enabling
> 	 * in the FPU, e.g. to expand the guest XSAVE state size.
> 	 */
> 	best =3D cpuid_entry2_find(entries, nent, 0xd, 0);
> 	if (!best)
> 		return 0;
>=20
> 	xfeatures =3D best->eax | ((u64)best->edx << 32);
> 	xfeatures &=3D XFEATURE_MASK_USER_DYNAMIC;
> 	if (!xfeatures)
> 		return 0;
>=20
> 	return fpu_enable_guest_xfd_features(&vcpu->arch.guest_fpu,
> xfeatures);
>=20
> and then
>=20
>   int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64
> xfeatures)
>   {
> 	lockdep_assert_preemption_enabled();
>=20
> 	/* Nothing to do if all requested features are already enabled. */
> 	xfeatures &=3D ~guest_fpu->xfeatures;
> 	if (!xfeatures)
> 		return 0;
>=20
> 	/* Dynamic xfeatures are not supported with 32-bit kernels. */
> 	if (!IS_ENABLED(CONFIG_X86_64))
> 		return -EPERM;
>=20
> 	return __xfd_enable_feature(xfeatures, guest_fpu);
>   }
>=20
> with
>=20
>   int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
>   {
> 	struct fpu_state_perm *perm;
> 	unsigned int ksize, usize;
> 	struct fpu *fpu;
>=20
> 	if (WARN_ON_ONCE(!xfd_err || (xfd_err &
> ~XFEATURE_MASK_USER_DYNAMIC)))
> 		return 0;

Currently this is done as:

int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
 {
 	u64 xfd_event =3D xfd_err & XFEATURE_MASK_USER_DYNAMIC;

	...
 	if (!xfd_event) {
		if (!guest_fpu)
			pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
 		return 0;
 	}
	...
}

is it necessary to convert the error print to WARN_ON() (and also
apply to guest_fpu)?

>=20
> 	...
>   }
>=20
> which addresses several things:
>=20
>   a) avoids explicitly restricing guest CPUID in KVM, and in particular d=
oesn't
>      prevent userspace from advertising non-XFD features that aren't
> supported in
>      hardware, which for better or worse is allowed today.
>=20
>   b) returns -EPERM instead of '0' when userspace attempts to enable
> dynamic
>      xfeatures with 32-bit kernels, which isn't a bug as posted only beca=
use
>      KVM pre-checks vcpu->arch.guest_fpu.perm.
>=20
>   b) avoids reading guest_perm outside of siglock, which was technically =
a
> TOCTOU
>      "bug", though it didn't put the kernel at risk because
> __xstate_request_perm()
>      doesn't allow reducing permissions.
>=20
>   c) allows __xfd_enable_feature() to require the caller to provide just =
XFD
>      features
>=20

All the sample code looks good to me, except WARN_ON() introduced in
the last bullet.

If no objection from other maintainers, we can incorporate it in next versi=
on.

Thanks
Kevin
