Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B66484BAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 01:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiAEA1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 19:27:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:21136 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbiAEA1S (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 19:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641342438; x=1672878438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eUP8/d/xhCayDuoPXmPyDz2zORVI/WD348rd3eaX/eI=;
  b=MkqSTRteZb8Tx06bH+DSTIypsUPh8V6mVOrMiI0egix63BMUgx9lcLbu
   DKCk5ReUK1MHHLCmtFL2diJwI0ZR7B9OkiedVHS6x+uN81MEUb3yMUewj
   /gixhUpedOa1fy/eFiYSFcobjt4xHEPXnVWRHS08/vI0ABxhIsVN33xV9
   75uC75h2cbd7uuqtvnW99UiTBQX9bc+8shtklp7/hoOo1nanEJvqHJG/q
   IVjmrDRQKAIJbbTnWwBT7cNRunHRszVjURHa5wFzIzi9yP/tZIIFycdw7
   agkk9HBU4LLMzG5FM5ShDknngaxGQfet7knz7Ipq3jo1nz0RSbKsd3HBV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303088224"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="303088224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="611273733"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2022 16:27:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:27:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:27:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 16:27:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 16:27:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grtmDnBxCzAjdpCnyMNnjWObo3+p/02j79xR6TMs/BvkITPBf5RcrZd/RoNAA/ACsN4gXjgym3jZSbKcIpuQuqaIBVR3AwPQubk1Q4B4vpw+Zhlv+h3iPQ5Ray6Hg2rlLkISUNLpDRp8F4VUon9uvjyTnyvasQ7Yt2VVRxZynku51nxLfi93nkP0rl24JET/DswPKJFGMe0IvSSQ6aUPUpP6M8Y0o9oLtyVpQAZbasAJFxqnQyApSLYs46wevzwzp8nPayUCqzGQvRFBGhVW4K+TRJIq3a2YNsCqTDXdoflh79+SJZ8ych5ZTSaZCvmyRFp3pgyeJsz/n82PWsIcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JujsHSLJW8ce1GMID883JV0mYhOckixt1TVBlD/VoCQ=;
 b=DGt4D6tf0Ir1C6lBSjsvyejBRxCpXREtRyD6l6fychgz0zFrIumOhv3BT+qqGqlxhxKCfU1JMh1R01EgaXCKNhXKF2MVqVfdjguMe7Y8L/v3RSUzbhRfUdRQUhJVI2E4VgI5crGlEescr5CMklQmwuPYAewQ172ji0YwUwJmHJ3Izd+N4kDShChG1FRxu0Bcsrcf8Fs5/eoZu5HRgSJGec+C9QzmMROhZoVYEn86WUXQVd3CExLHRifMDWR+bKTvxWPcPg1KH6rVQPUR0o9Nwcnw9BVCWdx4Onmkp6NawVStJXxoBu85mzcAW/b9gyXlR8TEqW02wZD+wCA7sL8S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 5 Jan
 2022 00:27:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:27:09 +0000
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
Subject: RE: [PATCH v4 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Topic: [PATCH v4 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Index: AQHX/LXqqOUf4s39oUyv7TWY2CUvkKxTUkkAgABJVCA=
Date:   Wed, 5 Jan 2022 00:27:09 +0000
Message-ID: <BN9PR11MB5276B533C168E2DE3AE7D0718C4B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-13-yang.zhong@intel.com> <YdSnlmO4dUnwRxxc@google.com>
In-Reply-To: <YdSnlmO4dUnwRxxc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b739450-c131-435d-2f2c-08d9cfe21ca4
x-ms-traffictypediagnostic: BN7PR11MB2708:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB2708BE46B3D852E4D9C38C5F8C4B9@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEjPRqKMpvDUJ5emO1KLrQ1hrfyo1GcS0x8ZMvAloObu0ygTixRS3rxkmLP1mSmuzGa5QViK/MFNBCJ0xGY6KTH2tcPnPiv1UuNqo1FDir389tAx7l7mojsnWAvoeI1RN8YfFffRpXKEQ9gaS5Z56Bm25Bblbk0YIU6esGRnsaifSwSImFK6fZks724/CiiU4xC2j064z5+EaOO6hPw9KGQLrthYaiCZfPvgdU2KuDhSlQ206fnk7BWnc+1O511o9LEZcsUA2ETsfcvgWJS15O4sfr95MAymdNsNubwn3Wbq6dQCKyQKN/ZWM66/SMpIqDggwS0MO3fz93w3tWVucFPBRtdyVOZtM2O5mW3WRgLQGjxZFYsj5FNweiEZxBepKaXGoEBvltqV7UkYVhoBr1WfEPd8gnko2jYq1o/dGAQfRHGrUR0XQVHctuX5F2JdUhCXXhrJZ0QazJ9eI7mXW9Wp3jp84GbMCWkTHAoh93alQZ5TcUltYxSIEuNm+0YdukTDDAFbqd5GmqagTNT1RtU+T5qZJAVh/Pob75r4fdhT5zx16f9vD9d7pnLM4iugC9LYPFk6FYwS+B+c3ReybLNjVGmk3hf5eH9ewrnq4fpqXSCjNBjGXbaP4S2NMlwow8Z7PaREQ0D917PZ/5VTCEqgPTK7E8r+2lpkvIPhaMNi/dh2NIyLQTNZIvMrpftugCoVoJGi5JFE7/ordUizPRWGuWiRTWRxSyijLU8TwU52CeVka4tWO/XVyLr17poEtiSArfhJrwNckLzHWAjNaQ+RtG1TAgKtpdLiDwwYtBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(82960400001)(38070700005)(6506007)(966005)(66556008)(76116006)(66476007)(66446008)(64756008)(54906003)(110136005)(71200400001)(33656002)(26005)(7416002)(8936002)(7696005)(508600001)(45080400002)(186003)(52536014)(38100700002)(55016003)(316002)(122000001)(4744005)(6636002)(8676002)(66946007)(5660300002)(4326008)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qDHex99QntHuXksTLGYJUE4fnkQ0o+VbtlgeVbpaw5ThPUD6rzSq7NOzViQ?=
 =?us-ascii?Q?reY8zL30pYdPJ+h/dg7hmUs5bqiassA7g/+GyAZGY0dZEQtxbb19+Q2Tn7l5?=
 =?us-ascii?Q?+Tv6ftwgHNQAYFup6DojQolq4j91u5nNmpCOywugIUmP0alH8siVOtItcs2x?=
 =?us-ascii?Q?nHVNm+xtQFNNwT0RacB0x+wGXlizsrhNlGQR8q6zzM3zyYuPw6ffoyIm0cgH?=
 =?us-ascii?Q?XoElum+kAmmowdJYRJjLnzHVtgElf0qDnoq57aikTWVIgt0PcjXH+e8AV2DJ?=
 =?us-ascii?Q?IgsPAWebNnMJ5GMNTXVOAgX0NK/P7yVz+XSVz0BEXiZkv4KzCDApA2HUKHH7?=
 =?us-ascii?Q?AD3kQ2AOH5Ba1i4Q1FPbtViQb/tOEkJfR9XFKHg9RKaSBcDw0dUPUW2t7vlN?=
 =?us-ascii?Q?FZKjVCpkfD7K31kEngumqaluVPCam5TRB5NcWtk2eNCImpB8MMwiTZ7eYfyA?=
 =?us-ascii?Q?dd+als62yb8mcx8NKTd2NPf2Iwbix5d7Y6fN4B+Pc7eZYPxDGFidweHv/A5v?=
 =?us-ascii?Q?8+nOCMLe63VP5ZCjmhShQT9EExnnugG07wQ8YSlEWgWLhAXP9sP1siNdRYzI?=
 =?us-ascii?Q?7Nf7wXKP4iKsdl3araklNLC5AH5oFNyYb5BuXdAqUK9c2xIHnD+uIEktKL5s?=
 =?us-ascii?Q?iWuITWwY3ayqGNoZ8SRfAnfMIZyrVFy6ztflh9SCU0GwF08768agLW9CJusY?=
 =?us-ascii?Q?26PwCxq2cgn+Eg9uWoedF3giEw4VtUa3GNzmTtIqPH/ANXbk3dyak/hRfIno?=
 =?us-ascii?Q?S6lDrCfP9UfHPi069YWJByOF5LpfwPHs7NYfvZpDDWGDZY/zG2RYI6ipZiAx?=
 =?us-ascii?Q?eBDsoRRLNU3z4tTmYoJ76BsMpAkrgjLEkyepXlzbh1Ltpl7ybdTqJXg07MNb?=
 =?us-ascii?Q?YStFWS3NSVV2xTFUkP6wP9KvMS9JlMrZru6oPoDa9xuiAhPk4j2k428waMGP?=
 =?us-ascii?Q?aDOvg5DQ/8AnxExauQKnBFG3WULVhrFlsEoWw6iNKSZE88+Knz1MyQvF7WjR?=
 =?us-ascii?Q?hgwusye7zlJWSpdkvIUvROmY+k7cJ30TRd+Z8dNnOjGo90XgZNVDZRCT8l43?=
 =?us-ascii?Q?dD2s4hOLQzCbUcRvp+ZEuozBGPXk4sLkhYuJU1Sb2Mh8bFfvv2nSooERYI87?=
 =?us-ascii?Q?T5xJYvUW0ctjEKrcAmsDPBRpC6J0/SzzuChg4drUUMwB3UAIlgFu1uSaAiE1?=
 =?us-ascii?Q?lHrrHqY9nHJh7epSUQ45OPM23BZMBidnuxLPzwraMyHtBpJ0Ju/egQY+DBe9?=
 =?us-ascii?Q?9yRp7toOX/zPRkWQ1Fg5RfqvGIRtQ4PB6o74xYIKGC3PPo3bk90JaKSnEZyL?=
 =?us-ascii?Q?1z6ZYphT0WquWA6NFZ6ar54amHmxnqhOxB5FIL/6qZsk28DGB66h57b/zjIx?=
 =?us-ascii?Q?hV2U9vZA0R++7siJSUY5AKUpTKsPLbTK/KkzEbCKA9OtmjhLCNMMwr0NIStw?=
 =?us-ascii?Q?HS1xSILLlV2BzZT6t7dNMjJDh3K8TiJhbmBpeZRIqt73Ln3TmCJrbm09Jymc?=
 =?us-ascii?Q?YmhMo/EhailzHVm/HKvbpzcMZn3zsIgTZEcyKR9BmeGAz4DrjEnV9wW/NV3Q?=
 =?us-ascii?Q?mst9Qb9TWn7RLWbzlaL85BtbYLnIr5dHU8OAtp8Zyyj3vyR7QozbKLjMqq4o?=
 =?us-ascii?Q?JgwFno/hkvFjck2ld+J4ufI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b739450-c131-435d-2f2c-08d9cfe21ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 00:27:09.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UF5poIm7Mq6xQqvWC/SnNDI8SlJa3PIQP+9kK1i0WC9uji5Gh8WCaSoYuCN8o6MWDsq82BEZXFhLUAIgCUlytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, January 5, 2022 4:01 AM
>=20
> On Wed, Dec 29, 2021, Yang Zhong wrote:
> > +static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
> > +{
> > +	rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> > +	kvm_queue_exception(vcpu, NM_VECTOR);
>=20
> This is still wrong, even though no additional supported is needed to sup=
port
> nested XFD.  If L1 wants to intercept #NM, then KVM must not inject the #=
NM
> and
> must not read XFD_ERR.

Sure. This v4 was sent out before we settled down this open in v3=20
discussion. We did fix it later and posted the sample logic here:

https://lore.kernel.org/all/BN9PR11MB52767789D59239DF5DD524758C469@BN9PR11M=
B5276.namprd11.prod.outlook.com/

Will include this fix in v5.

Thanks
Kevin
