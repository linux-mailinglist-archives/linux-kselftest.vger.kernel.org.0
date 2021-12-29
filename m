Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132AE481080
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 07:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhL2Guh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 01:50:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:41565 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234572AbhL2Gug (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 01:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640760636; x=1672296636;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qrkBDIom48bPMiuMm+ObTI0ScuDtbt/mV0eRg+qPHkk=;
  b=gZ6Lvc5xPrdEJSmmceHNZlHyPYqTz/OpTz0gFbmkqofO2uOb3FCdaXxM
   1W8mYJBN57TLlmZVDmW+ClgHJfZFYZ39NaPnSXo5Gl0zrcYnL80Wowfd1
   VjySUNujx3uVBN2/3wyTk2sql5c380JWjNIhuNSPgpxjzaa7adcyQsV6w
   UMOqMSfq3vMuvuywCNDOW9kurhoSGLcUqFZrGPB68gbKFY9O5WJM33FSN
   LD9t6aoscqOgsssJAFnZOl6l33M4vHhLovL6HiNqkRivZ3p/0t9FHyeI5
   HOfBH+y89k3XWjmrpx0Za/gpKTO7OKguyypB2Dg1mkt4baA71/LTH/Ljr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241278895"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241278895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 22:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="609523277"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2021 22:50:35 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 22:50:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 22:50:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 22:50:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 22:50:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtlL8TX4Pn5NH9dfMvmKaL/9AblYqWipsg5esB4Osm8yMjH2HJ0sEroTVKZuiVQqgXd62WHandZwha7ZosE6/LfkwGvY1cOHrJUEfQCGsIjCkV2Hzlbnvwz+zRIhR9V4j00A/e5K9tEPVNtb5QO05VnHt+UaMkDTr/UJ+6P8DbOujlqm1UZwWLL+wPAeMEPEpNx0+gytLSqRIrrUpZLpPcUGjxlhLvv1ibbx/PeT8M7duH0QN0JCmhHIotUDyQ0kbncQA2dtLyJcwZmWbG5WkD8Gl169DPDBlx3MtIT401mpQ6YtNhYPcW1pzXt8YoL3NI/1fvXy6a9FK6wE1bUBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSIHOVZ9O95Qr36OML+MsAv1YOmy2g0AlnoB1HqnInk=;
 b=BVK9yZHJ/0tJDWoN7wVoO0LsDtUfeBIg2ze+YVFiYS5oIj65pjKbqKWxnl0J9X0/m5ZrhLnYWJ8XP9YFhSndzAU0tnkySkO/5duL+oN6PIh7yDLsyl+Ga67Ek1qrK7AqHSBxnm3GZfL89tzfEF6Hjt453fg2hozAuUuQsBgcz2oJoAuf6+DbjfvpswomTQA2JjPKEzq+6IeSzhyMYlYpFoizA61VeFQr2EiFH/RMMuqLjv/FIGCb8CmwAlL790aNex7H92zh0OFpy0oQ0vY0p6g4niv5ymbAgHSOQl7KR8KTsnudKPkolZTF9DtmxLPLOqgjDXQe+a3aoSdXgPln4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1249.namprd11.prod.outlook.com (2603:10b6:404:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 06:50:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 06:50:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
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
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 13/22] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Topic: [PATCH v3 13/22] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Index: AQHX9zE1lVRiv1UsgEq40a+CF3C7OqxIomKAgAAmHcCAAEjrMA==
Date:   Wed, 29 Dec 2021 06:50:30 +0000
Message-ID: <BN9PR11MB5276E07D7D491FCD49C19CE38C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-14-jing2.liu@intel.com> <YcunSb52LlGKT7dC@google.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daffb3b7-7802-4c0f-5b56-08d9ca978152
x-ms-traffictypediagnostic: BN6PR11MB1249:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1249EC19C024912C95E1E5B18C449@BN6PR11MB1249.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xinJu/9t9D431JTJAlqc8VGM06T7F3e07Hk9gfeIduM7aUT87BtY8duSyGphGULXz5uyeF7SNc+40lntR/sCbH7jxJp8NtVJ3Q8k7pnBjbdQdM6krWeo+7Ane0uoLnnVngLKKirX8g3Shz+Z78JYXayqIom/DiFzxOb5nsXOVh5Cmn04iZJXN6fiTNsedx1j7FHSB0psq8glU+ayD9kvqi/Z+piEpsPdEwjGhw4wSWBPVHklHG+if5dFDAwtj16OocJGXo2r+K1zUE0f75jV5XDlyeSMlDKIf3gdn/TdUzPBVXS0yk8NyxKlI4DblmT2Xd1EiVzfjfGvx00X9aB1RND8JGqCZswWnJUixY9KVahtCG3EdPfm4b8fxgzJmanHibXeE5wU0WB/ux7N8lW/B6ciwWAiOXJUMWbGTE9Gf+Rz0FmXIWrbn4vGhdl9/NGnWmr8vsRovGVTBqPGEPFPtdxqdcLPUblZkwKRjIgz66hjUoDXBKyajS0XoRoBX39D0mk7dXV5U6MhMYzbuXbt4nu0wNE8JhiAu36nbiFvaKEXwhk+tsRuCjBOVlFWeueqNKNsPwaUv/0VKjrV3k3uk7F0ZSUYS954kJCcdbbGurWZ3DkkEcaHo+O2TeZvUEwRvWb3SjUO2309TXYbM2oXaPjVnYN6WyBsnoj8R7KsYOn5b1bRu8dMJiCSfe6WWDPFJYzn07ZTs0lfH9T4zX2BvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(122000001)(186003)(6506007)(7416002)(82960400001)(9686003)(71200400001)(66446008)(33656002)(26005)(66476007)(64756008)(4326008)(38100700002)(8936002)(508600001)(38070700005)(8676002)(86362001)(5660300002)(6636002)(110136005)(316002)(52536014)(83380400001)(54906003)(7696005)(2906002)(55016003)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZxdK/PBm1bz3j0j3icJEuT4Lpg3xtfpBuqdFfuqaqsuM8qbaF2JeBZ8Zha9?=
 =?us-ascii?Q?VRUCKkeyKxSxLxgjPhnSW4Ty4voXkPtqhJATfyrL/BQ3zKAxXYUFUoGr9nC+?=
 =?us-ascii?Q?Q9LYJLi9Th/mvZMIc01sZTXc/O5/FkMj0Nqx8YN+G1FDkPXeWn6RRMk9qwiS?=
 =?us-ascii?Q?FUkrckUD7f+RSl2zPV6pWhcYYsCb9YEAI+Ifax+spNekbIClT386/bIjOClQ?=
 =?us-ascii?Q?CIbU/7bK9cEpUtKz/X7mGa5XDHLwCR28ej3hE4lkeuigIXsxm82i4hlp1IvA?=
 =?us-ascii?Q?V+xoh9BZK70lHrojO1W/0677LjdnLIXgtoMkL/K6gDzXGUIS2PD2FNRWT39e?=
 =?us-ascii?Q?p8GRovI/tjPqVuKG6otb5mbJ32x10yuiEe/ob8oUrjwrXV3CS0WiazAarzSj?=
 =?us-ascii?Q?xDcMzTOaTI2/djA0hnO5PZYg1ad+QAGWS1ruRnvfhRtPvVPF1Uc+rN4lZA7R?=
 =?us-ascii?Q?uU54VB9XpTIJ5S6HBYYoUPvl4l7yxwe5FW531Tc6KbQY95PiZKzsHh/oOtP7?=
 =?us-ascii?Q?8zan/qzkSDO4Y4Du+LMG8Sx6P2h4EbgnZi5NAGslFZXKBVAWbXweeR9H/DlZ?=
 =?us-ascii?Q?3rpc3MMocy04tfS8qIEDXPcgyFWWGoB/Sj+4W3tCivGeoZXo+6FQfEg9xI+9?=
 =?us-ascii?Q?ZuLt2OQZU4WS/9uYnm09Wm3FOoxPICKSZOOGOwYch762dir2wlImpNGLtS3U?=
 =?us-ascii?Q?DcCo8+s0Thd+9jOkedCkw5h082JeAQOji0DbFfwY3eeUIp+qqh/3bHiX8+hC?=
 =?us-ascii?Q?WJmYMndlyPm1y4nKTKNpP9F+TjiRfgzwpukAM6GUzbA3ZAflY6s8NOFdxATg?=
 =?us-ascii?Q?Jb748ba13Ce4NFZRNhutfKGTMTz8AGtesEtDjpAE6UONSReXjb8lu3XtNMol?=
 =?us-ascii?Q?WXsASQ9FOqkyMiFaxMrrxU2ZijnkM6R0aTVK461UJYr3a3PDfJTEOPgmL3Js?=
 =?us-ascii?Q?c/nHB465uzG8N6w518D6gZYj0PCRjEsfTekhv+6fmyh8tqI5pEUOF07DGRCV?=
 =?us-ascii?Q?EcRD1acuI/FqFZTKckvF7YmslaUoMcwewW2xyupi17Xh9PJmVX6evM+TJLYc?=
 =?us-ascii?Q?md8TaWNHwiEFikP6AgoOSGVVEBr+6AcyV95BwIngkjAPK9TQxAzuGuEeFwNq?=
 =?us-ascii?Q?8NciOmxtzCltwmAjFaGt+W98rO+hTSAGRuVkDCeNefogV1KWuB5Fe3QYQPw/?=
 =?us-ascii?Q?rfFCiKItqypLOu/IO7LL1zaSaUng/Y5xpGu1HD66Hk6mCciaL4+2xSbOyjFL?=
 =?us-ascii?Q?6yZCg4HDImH+q4fcqBYU1nzLQvfcj559a8PRFV0LbQ2qpCnTIFon9kXPyyVo?=
 =?us-ascii?Q?lq86Lxx6ReU4n1BGfNV6qdJm2N/JnhXdaTYi7YaJztp3wm07W+YeDicH1rB/?=
 =?us-ascii?Q?w8vM5Pu+vNwNcpVevHjx5ZuZeMxq97LgbuzTB1FDhOPQLM+Uf1kMQ7jn3Wik?=
 =?us-ascii?Q?Bs+iA1BSvcid26eZMjWERHawXTE1Oui+wkXwMa3KbOTJP0u4521q54qMieyx?=
 =?us-ascii?Q?ONYxdEcZqx3G6EL816BZOUzQXB4gXk67hPoprSAGKWC84+VnPAfZlLnI4krS?=
 =?us-ascii?Q?abSQLnXcgUeItRf/6Ds/Mk5NoEkBEcRqkf8ftlxxOJrALOouR+gB121R8g9Z?=
 =?us-ascii?Q?OKHPObbs9PE5Ek9wqSdiLVo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daffb3b7-7802-4c0f-5b56-08d9ca978152
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 06:50:30.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orz97maWIGk+VUnMeD02kjGOX4Rah4Y7+kZrUaCLxw1LdldsKfVaQvfBoKgf7tCQPwIwKkMz60dippb6Szbf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1249
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin
> Sent: Wednesday, December 29, 2021 10:53 AM
> > > +	case MSR_IA32_XFD:
> > > +		ret =3D kvm_set_msr_common(vcpu, msr_info);
> > > +		if (!ret && data) {
> > > +			vcpu->arch.trap_nm =3D true;
> > > +			vmx_update_exception_bitmap(vcpu);
> >
> > This is wrong, it fails to clear vcpu->arch.trap_nm and update the bitm=
ap if
> > the
> > MSR is cleared.
>=20
> In concept you are right if just looking at this patch. It's pointless to
> trap #NM if guest xfd is cleared.
>=20
> But here we need think about patch22 which disables write interception
> for xfd. With that in consideration we use the 1st non-zero write as the
> hint indicating that guest might enable xfd-related usages thus always
> trap #NM after this point.
>=20
> It's not a good ordering, but Paolo wants to put the optimization in the
> end of this series. But we do need to put a clear comment here explaining
> the always-trap policy.

Given write emulation of XFD is not disabled in this patch, it reads cleane=
r
to always update exception bitmap according to guest xfd value at this
stage. So we will follow your suggestion here and then change to check
msr bitmap when write emulation is disabled in patch22.

Thanks
Kevin
