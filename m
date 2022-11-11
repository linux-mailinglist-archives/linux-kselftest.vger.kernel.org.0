Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4775625347
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 06:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKKF7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 00:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiKKF71 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 00:59:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEDEAB;
        Thu, 10 Nov 2022 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668146355; x=1699682355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sefUyGNtXfOQ8tppXsH6yjtd3YD2772+cQDzLbdRJsk=;
  b=nmEBmT+tidEdqwDufF3DS2v0pqZCwaYc25myQ1IU27zI5iq06eWMqjHX
   QyT3wI0dVd1VoHWvTP/wEg/nub3Ld1LeaPTnWanCzH3bBpB2bQgeOwn/K
   EiWqUcgyF9uvK+pFLhEWUsK6lNqX+PQuROMNt4Brf+bgFWkRGiTyCsm88
   n61PKD4hivufwMjn0JzNF0n19ntfzm4xrrOrLPAtk/M/7TvQfSl0uXsn8
   /mW+WIPKStXnt2E2uYngnm5OVweyqbg/7V1pWcj9ELtIqEXbWOFAuBfLv
   TDzJyXkk9+pu640Ws/SZ50ptWUgttPuWW7ZHIdfnUaBtbU8xESMgEYlia
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294889813"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="294889813"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 21:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639902959"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="639902959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2022 21:59:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:59:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:59:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 21:59:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 21:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io1bnWGRbd/E6wjBQPMAGM3Rsj5qMQMpWTcBQqevr9Ub4XrpXdaNowtL1f4A0fQbFgyzENh1WSqWaO0wp7Knu/MtlVULlVNxyHvZJ+kfyfbDf/Y/mdg5sk9Y5QPIlTxL+ljprTLnNdxuCaxX5a2wQs7bpq0pi/PVvRc+rQIvI7vphg+M8yZKo5DkFdEOjZc3iNGs5/WMxvN1JB236WWCAh5y9RwMa92II8r7fSHJhQslqFSU0NmKdkA4vV50+fimrG448Ivzbzn2nCZBFSy+yCnE2m/EIlvjpoCBK/jVd+sU4zT+iyi1gHMyJsFztsa6tR33VWhXJp4EA07ko/6Yww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sefUyGNtXfOQ8tppXsH6yjtd3YD2772+cQDzLbdRJsk=;
 b=LfNvAjV8wc1Gl3m3IrZ8eR8Z2RHk/hS6u781sew5aEvy3v3a4z0n9Ew23eSvx3sMdN5padCWz81lcG6yLLtLkp0Oh5DNKpxMbxeP0YPmgONm4Z43e/vfxjPZjrQwmlGAGXgwYcsEsrAqNEzcYMc2cLUBNtP9kRbQkY5TB5XOmQ3RXIYG9kQ6Bs084ZVRNiHH8JcbTNDvunFek9Mb9MxYaC5fGfNE/RwNlGNZroINLBg2+fewMKgHkb0rkmO8q5Mv5/UNYeXGhmpz0Ue14YKGFTrn4Z2cq+Y3LBJja1aBRlM0W0KyEtSF+JzlPnNvEOd/ruxwdATFQSRfGbrYUoe/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BN9PR11MB5404.namprd11.prod.outlook.com (2603:10b6:408:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 05:59:03 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 05:59:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Joerg Roedel" <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 4/17] iommufd: Document overview of iommufd
Thread-Topic: [PATCH v4 4/17] iommufd: Document overview of iommufd
Thread-Index: AQHY85Ug2rC5+2lEE0yNlBjXjXuC4K45PRoA
Date:   Fri, 11 Nov 2022 05:59:02 +0000
Message-ID: <BL1PR11MB5271D83054967E20CFB937A68C009@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com> <Y2qNaNfpBG3dcBV6@nvidia.com>
In-Reply-To: <Y2qNaNfpBG3dcBV6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BN9PR11MB5404:EE_
x-ms-office365-filtering-correlation-id: 65ad8c78-4703-4f0a-2496-08dac3a9d5ba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSGU0+Po2JIjbb55UwvANAenPh15BeqpOymxE2mVMtspyjmxgvdiXk6TrtTx6anKrUv3uA76jW7aceA9Qw57TTW7Ey+MYzSqSOOhg2xqC2cfemfJqjFkvhM1pvDMNVp64pfmif/iTwff0OXBT6fUyjzQ5R+RZgSJqxqB0KWaiP038jRnTSPHeIbZI7VOfuN2GXOLy83YFY7f1H12B2QAFfCukPO9Q6DeaR5YYCKanxtCZI2oHYpMTJeLf80lZW0Xwo0HoozQ2i6B0qw51NEPRpplfU14csAN9HtSEP3tNuCA7SXJD358UAJ9Gi0qfytFVrsnSr9fTYFwR5ybi/qGjZAzKgLkNeD/cMkct72ob4g02vjqsDkF1H6ESo2QPetqdk8KimF3TbTyT/vC0tU6Dt03H80WDrORZDObGK9Q5pfWOy30ShUfCX0PfKJcjPX2YY9+5ewURIA5/haqMQARGazcwkh2F3TPtY228F/4XAuyT89z6R4aUDVkO4R6cuYH32Tvri202m8u6BFkEH8rpkYqmuBU8+8/kLvci9RnNAopyc8yy6oXqmVpng3Enpoeps9FtiSVYzI+6PFAAQmA4xqEw2YqT0zGp/DtxnkBuCJXFOf6SQBOwxGhOdHzwLRMhCPZNVwQVk7VReV1cBAOv4P/nd/VhxwvkuO3U/0lOGbmonLj7mnk+OuizettgPM6jP/Lxndm65OFTC6Yt3SM4A2zMTM24xfljUkfKUFfSELgt1aPrZc4/10G2lK70MCHW6TKhuUr40fugivPS9Me+NCzMebvRKQ2g4gmFcqYJEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(38100700002)(55016003)(86362001)(33656002)(54906003)(921005)(38070700005)(66446008)(122000001)(41300700001)(64756008)(82960400001)(52536014)(316002)(8936002)(7416002)(4326008)(4744005)(7406005)(5660300002)(66946007)(66556008)(66476007)(76116006)(8676002)(83380400001)(186003)(110136005)(2906002)(478600001)(6506007)(9686003)(71200400001)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PfGbKobOuOkB+TEzy8r3FkzLqDF6dhbGGC0ptdKeFD9yc6NW+dCO4MnySvCF?=
 =?us-ascii?Q?vh8VN55eBW/RFSkicBVQOHiu+3HFTsxmQzRIXObV2lCNfXxdlSpPum/TEhK0?=
 =?us-ascii?Q?dX2vhMAr5MNdzGp+t0NtNy38RyEW86TY+/LogVwL9XqWzJCyKHscWzUh1/0Q?=
 =?us-ascii?Q?ZtzmL+9fRXykP44fHl2ecUCDBW+uOmTIhXzIqC+GoYH1CkI6Dorvg4ABdqh3?=
 =?us-ascii?Q?NaAugmN+ph+ulBoJrEusBwrjshXfsgeb0J083vxZRBpVP3+Ro+Zm9jGpMxok?=
 =?us-ascii?Q?U2tgfHJqkqOdtCFq1lzaFyiGXF+HqN+kpWanA2/Zm4ALuEqJuuGwgn9MDJIl?=
 =?us-ascii?Q?XaYASD0hlXbyXOUEUzzP96TxhpyggnD7J5MOL/L//BKWNYlUCGngjBnUOh0o?=
 =?us-ascii?Q?j4LHO+Ixi3Y1xiSAJvz9MDvBMDwm9kOGBbRbSCnLIDMr0J9YEPhxb6e3lNJb?=
 =?us-ascii?Q?6NBn1ACz93yh5oGjvaOMYHEJ87xIINOYGluNGkzlV6XwK4TWKmA9c59CVD3/?=
 =?us-ascii?Q?bTz6QvQ/23oXFM5gYE90ojnMchcSb++F7GlIRkgFLjBSwLOzDb8yTQ9VSmLZ?=
 =?us-ascii?Q?ns6xXrSFYwbozl6SU/jVJII5ngzZsYeRydJgl7ESju06WnKMvGuDDrqEx4yF?=
 =?us-ascii?Q?w2Volf5OkHFVysjuHv1L91Gc51wMqXQKcvJ5C4XW1WqdQyyMaoK0cIHINh7e?=
 =?us-ascii?Q?J7Q+kqC3oC0sUP0VzLilIIlhYRzwYKQYT8SizkDhso3fIZoTFH/4Vc7UjOd0?=
 =?us-ascii?Q?vTFTV+62LKZ58EGACFDuzc/YTXwF92hGLWqWZmM+1N2t6k18OyhFsjX+FdfL?=
 =?us-ascii?Q?RgxZi8wJI5QpgDEX604XmirDDiXxoNY8wOwTOHAx7bDSxP52U1Rcv5eD6QTD?=
 =?us-ascii?Q?qFrFE9f6G5ECFgBRj6Mgrtk+FDVZfFLX2hUA4oWnIJQBitDj0t8KqMUHMNWh?=
 =?us-ascii?Q?eqZ+RUdMy4pmST6BszHFx6kkA5ksiS16teQ20asrWv67bacTpxvHGc0mxWcf?=
 =?us-ascii?Q?B98RcCAHgGRDUCh+eQnkh1L2xsvChtigScW775q7pQt+b41HTcioKR5VYErO?=
 =?us-ascii?Q?W77iaxP+EMd2v/Cfa4i//MLDSUFdmXriNLVn1/IghNhAUzFmckxgSHAwfW+3?=
 =?us-ascii?Q?AnlsFIjqSAxPxAL9b/Z8KIrpjxgUakVr8uiiSkq+bnb9YMO05Qgeqw5/jVtu?=
 =?us-ascii?Q?LCnj4PXKcrsjFIM5r6auOzDBxw0FpmlBDliP9xfoS+SlTC0m7CzqznSIw8Qc?=
 =?us-ascii?Q?3PM6BL2EFQfsFlp7yNP9BRwo2i8fi7gG3evHYyl1fQitPDHYrNDN86rNV6/Q?=
 =?us-ascii?Q?fep7qDRz2RPtsk6ubd8EynZGovTJ9acJCeg8Do+keXtM3PBuXcaXnjLDGcnL?=
 =?us-ascii?Q?VQc3f6GjWNBWpHpIWdioy+Og1V7QegSmR7eJ+yuUZGonxqSZzactVrCEVgfv?=
 =?us-ascii?Q?4qzKTYfZl6TL3ly+JiQOkENLzN2dqCx2iiosPwGogFV8veF8kBwYPIovYd9l?=
 =?us-ascii?Q?KEpP3xWppxqz02s4p8eUXLqCBZe9Ei5e2P1mHp0T+wMplJ8DMAINZNp/VRzo?=
 =?us-ascii?Q?xGnmqAjR0zJsfKQEfi6J0z75EhDMbhFZoSbdVxCu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad8c78-4703-4f0a-2496-08dac3a9d5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 05:59:02.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqyUC4Lbj3FBlOH9KiTrBsy4y+aDrJF0iV5gokxWEvndG173lT6T7o3n9Dor6sGyF149yJhCnx9XYCIDUoU9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 9, 2022 1:10 AM
>=20
> +/**
> + * iommufd_device_unbind - Undo iommufd_device_bind()
> + * @idev: Device returned by iommufd_device_bind()
> + *
> + * Release the device from iommufd control. The DMA ownership will
> return back
> + * to unowned with blocked DMA. This invalidates the iommufd_device

unowned but not blocked DMA. iommu_device_release_dma_owner()
will decide what will be the state then, e.g. attached back to the default
domain in most cases.

> +/**
> + * iommufd_device_detach - Disconnect a device to an iommu_domain
> + * @idev: device to detach
> + *
> + * Undoes iommufd_device_attach(). This disconnects the idev from the

'Undoes' -> "Undo'
