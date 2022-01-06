Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97166485DB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 01:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbiAFAzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 19:55:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:3915 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344008AbiAFAxd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 19:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641430413; x=1672966413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y/grPKTRyoyZtI9LS99cxUGzW0ADNcmp0VuCTdoza24=;
  b=cFPSEz7J9y4O+HMwmpNKKL0LC5UfD2+OiUAXFYIgcAihGX2xTB3mkg8G
   A9NGLIYhmzZBrasgLH6+UtEXta3iG57isFH3S1jBSNmSDKzdtcX3K+igE
   JHFGpt8nFMlxjGofJQOQcojIW+H6cS/ishc65k34G9zcBug8fXX2eEEkn
   88UmTlXwfS8nqG4+Vd2s6cU1O/M2g5tBG3TtATE6VWPPpL0K3XT9nu2KQ
   b5jfuGYoYkIOjO8BaT0EAwpSGwNvRV2KfLPJHxli4uLSoC5A1ZwVSEjs2
   V6dGLwouG15/hIrlCI2smBzbAd0jlQ+fsEDA4UGEK14YbwPE+Ap+SDSwl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242360558"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="242360558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="526770384"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 16:51:30 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:51:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:51:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 16:51:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 16:51:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLzmZfTMTc0UkTd3KlNEVlxuuqGV9ozhbrDsJZNrYPQdW3KITFBjHGfqyxPoGMd213GP6W04LzqAN8DMaZQh/3h71ekuYGmm2ri8A+LUOXthAFQyU4M1nMZHxPhxUJ7BiyNNLhUuBfkbyKawqQFRxC6aMeogh1qfMkBruxP12cToErKBaA4zPT/3bqFII7MOrdNBINEfWdGf68QBST5tzxwpnwNMfgedZ+Fphb0+BFi2QzfPa4+dMetEB+ncxEGsNE6K09MifXKMHAE7OvZMjX4uohkrTYMTQKiJWSVefAELmUXMwVAzGCJVfBDJ1noUKZ14fZHBaIS9UAp4rx1Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xm2UjZhSaLACaNGqw3GkHq6t7ioC04POCK2bPbjzM8=;
 b=VkycYq1ENkZXI+i5O05zythR18zPOGrR56XAACO+/o/6QCX6zCXpd+AfsBAgkVbSGlwDX5xhxWQH2NVFdGDp7F1+PMMl99IgFbr8Ymng/72dK6xaofeqDdMVYJKV9iVxJplzzjEoSVGoTIcT7Aivx8UEwGGGjKiNgJUgzoRbvghctkZUKZDGB3IRijgoXBDpq5d9q1YDYRjOx1acqoMndaREs6yjKYyBlsCKX/ErUaxfDCaWhRZ8tL6GD4xAuDSfol6K0IpdhXa/UFYVmSf44JbnjoAhCZNL+mwcux9HYytF23XYDXGLVe+fHkBKmbuL9EVV+3VTqZUF6uj3v89wEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 00:51:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:51:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Zhong, Yang" <yang.zhong@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
CC:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v5 07/21] x86/fpu: Provide fpu_enable_guest_xfd_features()
 for KVM
Thread-Topic: [PATCH v5 07/21] x86/fpu: Provide
 fpu_enable_guest_xfd_features() for KVM
Thread-Index: AQHYAjDEAJgtqZjHZ0esbz6ewfT3/6xUZcYAgAC+0/A=
Date:   Thu, 6 Jan 2022 00:51:20 +0000
Message-ID: <BN9PR11MB52761DE1C48A5931B5AD93B78C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-8-yang.zhong@intel.com>
 <c99d0b82-a44f-db8e-3f81-93d2394f9a02@redhat.com>
In-Reply-To: <c99d0b82-a44f-db8e-3f81-93d2394f9a02@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb4fdcf-7659-48c5-7bfd-08d9d0aea7b2
x-ms-traffictypediagnostic: BN9PR11MB5275:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5275CDF83F0A52BFD6D71FE18C4C9@BN9PR11MB5275.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+KE2yPnFbpyAsoHQoZAg7GQrMpA31zsMX0QAxcxf7sUvq9IwNMhDxxBy8Vygfe1gJwbHLm89CHNDZ1+p6hwuEWrxVPeG/GczzyM3TG3UaIV0XiYmgRLphYu++/uXakU58h3a+0/gr2k89XEDWU+6lq2kbatPAiuUNbiZxT9E2o/LFU4gAt8sqitsW8iAxWFJg/Cg8C+TQG2a6dIBokzWAjBGlbsCt2luaVN0jXpF6ZyqfEx32Vk+p9wuKAgOzmljO5eZGJgVm/4qr7G+lwNnFYcUjROeDDoTQ74gvm/ABM73IXK0D10vS/FV3ISJS1xiNBWqDq8oviehqG9EQhLxNcnZn5bB9akEk6snEJ2ALYc747WOvuuRq9+M0vga509FPXOuhTVkS2MgXt0cZZleu+Vw9PiwamOGYFZJv72dXZi3KUh5bmcPlqm0qyCcn2VS0fxbdvH4oAPXYy31PQ7mzbtJXWHuEGL6BSRYLok/Ndlu8Zre54TdOhLSIOHfE11DvPiRarDacjWenFk3sc5yCV+9vNKgkvhddNTa13qMu47P/xAqJnkDAKrOhSMIB8MpZq8U9FN5qgJhqUDnDT51Lmd7Xfjd504S2lzO1MDu99eVyfICTpQCdeKtCwOp0NQ7M02G5tw2z54NSyfc8ZsHEizZRe7JEQwyECjwlRZX0DdqIRF40ix8Ug/bs7R9EhY/R0+YMwnUxnZd7o7fxNqWW2zBv2B14JDwU4KaZvJgOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(53546011)(4326008)(7696005)(33656002)(86362001)(26005)(508600001)(9686003)(71200400001)(6506007)(54906003)(66476007)(921005)(64756008)(8676002)(55016003)(38100700002)(66556008)(76116006)(8936002)(122000001)(83380400001)(110136005)(38070700005)(66946007)(52536014)(82960400001)(316002)(66446008)(5660300002)(7416002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTuC94hDiHC3IhrHm2nVVy0t38aQw6QiPPdl+TndE2xV8RyLUBzyIFRm6b0F?=
 =?us-ascii?Q?LwXdA0nh7bie2jmGe1fTimT5SkrVnWUiQ8FwMzS3PJzTjnpGljfesExBkmGy?=
 =?us-ascii?Q?WYtgbRkZdyumv+kXp8qToc6Yz3eY45pNw1VAk5heAb44BHSuiuIORrqzjUSB?=
 =?us-ascii?Q?dMpYroFzQrgQASFyEyunn1ThsrmuAxWInZ5UxSHJD7FidmxqTv+ywDqDIV6x?=
 =?us-ascii?Q?b4Pq8YeP+4j/pXEvjHCUrPvmQ/CCuxD3R/hLo2QCyy78xyQKxx2Xcf9XhEzd?=
 =?us-ascii?Q?K/V5dmRqvQ5qIsWW7BhTKVMzbXvABfxPjQa/48QklPcsR96/+5U8KVqdU4TS?=
 =?us-ascii?Q?0Wr30KLhyIxDaSNbLdrDBs6E0E2eNrtqRfh4YAYCjP/DVG8vPz8Ig2FpokIL?=
 =?us-ascii?Q?e9a5ixQ4zqEEqV0KAzhoesRNharH5G/0OfWpR5q3TsFr4V5oW/o9mo2bHI+i?=
 =?us-ascii?Q?HI2iUzQw4ekvPElS4fxJ/3aSVWZgszqnphFwzyNjPmF3TwC0MPNPWPnBKq0I?=
 =?us-ascii?Q?BKxiXz3em/FJ9huoGwosYrx/LGejp5ABaDUZUTrvznL0B0z2FJmxbK6ddage?=
 =?us-ascii?Q?d+fLWFoniOAN+FZZkYazdzSoFIMEWl4yeXXqCRISVOiROvU1BpwmOqE/HdY+?=
 =?us-ascii?Q?07mQzYkDaUsKlmnM528H6lap4LDU2e9wo9/NDSvB5xobktS+T0Sd5i2SIeSB?=
 =?us-ascii?Q?lncs5WKKTzvEZfoGlaUO9SbeFvdaP0f/Owjz7wLOpwK+P9L5/shQW9RPouOD?=
 =?us-ascii?Q?Uyctfxss17SCmpul11W/T/O2JDWN/TNjitjiB1J9iP1puhMX4uHcKj3tN+o5?=
 =?us-ascii?Q?9s2+o+6qTpwz8h+jPHoRU6+y/r6i/JjkPT94+4ZsXBDww7MROpipZ5dYSXAx?=
 =?us-ascii?Q?wOL5S56wpFdu8iN0wlW2Hlk66IcpzbQHlzN721nL4wqKqcyAwDf3p2q55ObR?=
 =?us-ascii?Q?KlfqTy/jaLlZzO+hN0Te3SVioPnY9KF8BNODKo+12KRzSCDytj9HW6gkLn2W?=
 =?us-ascii?Q?qj/UREHVzcBc2YvUq1lzGcIyO5gUS2LV+u/Pzgb+9IW+/9MGpfKL0vNBUjgV?=
 =?us-ascii?Q?v/pnXUfIVbEsYi85aVH2e2ttwEdIb0IOySlSZeXhX+Xfq/fL4Hyol+a+1Mg9?=
 =?us-ascii?Q?XV+GhXX5H0h/De0AspRQv0F2OYfyoBMabFR+ITQBmRzZapY92vcxFMR7hFFj?=
 =?us-ascii?Q?oVeegnh5RwbDLVXJuJwV/U+/rWkzDm2Grmkqgmnf4r1G9WIQaEmTkId6/YSZ?=
 =?us-ascii?Q?niWhcp9h+CC2PwtKCUB0wY0Azr9rL+xyStdDukRNqqW3k7TQavsXgVutzzBW?=
 =?us-ascii?Q?B4enkhSJhR7YJPpHYvo/fAP/j1UJn5ULJzNwFIqN1MkoUP8p9jo8dVCWOHJv?=
 =?us-ascii?Q?LbA1Wn6w+Y0c+G/Gt4kz4Qu31lQtMDKtK+Ok2j02VBRUcRJ9J7ahISpSwsMY?=
 =?us-ascii?Q?Urg26GuZAPf/uH8bZjkwz8mI0aOSkK4+HvmQQdh9NIKjN75WevmlfeKgsxwi?=
 =?us-ascii?Q?+NsjmGOh077esDB/GBFwhgW6QVbUIGfafEgJAPWDnrK+bgfdrXg6Cautyt4P?=
 =?us-ascii?Q?0C+egPrCVHKOMPeBQ0cy8l4ld+7++lufvu+QIvU+3i9ziwHQp8TDsNxOA+zD?=
 =?us-ascii?Q?rRujwmnsiprmhELAVT8B0FY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4fdcf-7659-48c5-7bfd-08d9d0aea7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 00:51:20.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ry1JePrRt/M5C3zh4qo4xI5XC+EkotlVAE72ey9k5IPQ+Pd0WARTFDEkdztiYnICgbpfzAc54GL85fIMoJLZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Wednesday, January 5, 2022 9:07 PM
>=20
> On 1/5/22 13:35, Yang Zhong wrote:
> > +int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64
> xfeatures)
> > +{
> > +	lockdep_assert_preemption_enabled();
> > +
>=20
> The old fpu_update_guest_perm_features(guest_fpu) is equivalent to
>=20
> 	fpu_enable_guest_xfd_features(guest_fpu, guest_fpu->perm);
>=20
> Missing doc comment:
>=20
> /*
>   * fpu_enable_guest_xfd_features - Enable xfeatures according to guest
> perm
>   * @guest_fpu:         Pointer to the guest FPU container
>   * @xfeatures:         Features requested by guest CPUID
>   *
>   * Enable all dynamic xfeatures according to guest perm and requested
> CPUID.
>   * Invoked if the caller wants to conservatively expand fpstate buffer i=
nstead
>   * of waiting until XCR0 or XFD MSR is written.
>   *
>   * Return: 0 on success, error code otherwise
>   */

It's not equivalent. The old interface enables all xfeatures allowed by
guest perm while the new one just enables feature bits according to
the caller request. It also becomes a more general interface instead of
being only for conservative expansion. Since both points in the old
comment don't hold now and this function is obvious, we didn't put
a comment here (on par with other KVM helpers in that block).

If still necessary we could add one like below:

/*
  * fpu_enable_guest_xfd_features - Enable xfeatures for guest fpu containe=
r
  * @guest_fpu:         Pointer to the guest FPU container
  * @xfeatures:         Features requested by the caller
  *
  * Enable dynamic xfeatures and expand guest fpstate buffer accordingly.
  * KVM should call this function before the requested xfeatures are used
  * by the guest.
  *
  * Return: 0 on success, error code otherwise
  */

>=20
> Also, the check for 32-bit is slightly imprecise:
>=20
> 	/* Dynamic xfeatures are not supported with 32-bit kernels. */
> 	if (!IS_ENABLED(CONFIG_X86_64))
> -		return 0;
> +		return -EINVAL;
>=20
> since we only get here with xfeatures !=3D 0 (if it compiles, just removi=
ng
> the IS_ENABLED check altogether would be even better).  With these change=
s,
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Thanks,
>=20
> Paolo

