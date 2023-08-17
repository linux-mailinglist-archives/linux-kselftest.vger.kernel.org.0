Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12577F147
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjHQHdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 03:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbjHQHd3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 03:33:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020AB12B;
        Thu, 17 Aug 2023 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692257582; x=1723793582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aEHySjqF4LB+RIGboQRXozTWJbNCo7z/8GNVa33R8XA=;
  b=R5jS9OsS05tc5QwxTnN77EErWimOk5jLkHNeWWDb3VdaEarQv2OcwnYK
   iAjNrko2HNTpFJhemA3qTydNfU6OwyuPnUYzAxy8a4y9Yfc+Y+jpjNe/o
   MOOhzlFV/XEFWPp2pIrDYIVbrU+LWM0b0jUdUammuj5+8bRYkKduL6Jdu
   EEMLfWCnfADKJ9TGdfjHBXb0ErGDWDz7/5Y6oNnJlY4cZ+SPV/YRpmUIg
   xIf6qiU3gLCiuyspgn4a1gdZVSQtz1vD6xmwL8gztbaAgPlCNc+tE4kO+
   eRMIMyKhmBjcdJ/I4fg8aSRXcQIh/MC6Ih+D1FX9nLKVZj/N49YbDhR6Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371637412"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="371637412"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684344734"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="684344734"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 00:33:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:33:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:33:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 00:33:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 00:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGDPXl0fktyk+iXWlZEH7acJsbxLzXarXH76wr4xskJ8L006uF6dsovaxT8TXoFAcDDxtOy1HOEqhfgk5C44qkq4iFD0PaqJ2PA8ZzqCWEp5B7VGqg+oP60iJPeop+i+HwpHhaPtv/aMtYqDIShCSZAD4o9nBr3U4hNFu5oDw4T5zwGuODKQAv9mDmbfdqNw5rDiCdylb3nHhWDCxrAsDEzu8P1uX7RC//c1UiO4LnyiND2IbOIZfQ/8XZJcxiRNVa7U8LTlDObmemjdF5wIy5MyArJjV23j6XKDMLjKwARj8yy6Itw6xFrj0rri9jYyh9TGAKn2F0UBBD1/XCzECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmp3TgDJdKU0TG6DhdKWPJikxEZC831aJI/dlLHx1kE=;
 b=HJeRLG7MVrQzfQ/gsxLu77nGa2hToPIhdhGgmiiEdjmahG2Rc0+xhw8aRy8YoOOPFpZZqBiwjwJIrRfUvHKwMAdKiKLbUPNBctweM5pkOsyu/OEW483QSDj/JlIipuCxoi/lbTVNN2CPW4xsmw4heQvgKYpciSfqQlm/AN7CIm0xUdrwmPmFmni7QI/27HbcyPw3THfbHqASJSUFXoFm+oSNUmxOG1X8p3nZ2usDCw/qMRyb1S747kP7g/BdE7pTzqqVJDZIzWYohqIWLvDahu+U6z7NjXA1AuHlZyR3MC+EM2COo1tqrqsbexU0WPJbu6dp6qvjQXNbJh86X7Wc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 07:32:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 07:32:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v8 4/5] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Topic: [PATCH v8 4/5] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Thread-Index: AQHZ0Dsw8qYQvph0v0WpJO5RckYQjK/uGUbw
Date:   Thu, 17 Aug 2023 07:32:52 +0000
Message-ID: <BN9PR11MB527613651F0A023EED967BA18C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-5-yi.l.liu@intel.com>
In-Reply-To: <20230816121349.104436-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 9665ad99-c86a-454d-f5b5-08db9ef42aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+mnX8UQVZ6WHcUkqud6U/dlYS/eK2jY01IZlf8Om4h+LpIHl36+6WWVcFDb8pn5LqA3gHJTTJ6O6Y9NU1wo2NvWyr6eECgehNQn0DR5XkRNI0MFazHCFdRlcQIbJl3D8XSLFPSm2IEv08MrAd7Z8kcu+cyXJClDIZfTIJrvkFENGu0VlBvKnZtQ2BKqTLrV5tq3JsIMlmMbzOiRdU22FGYlo4EjpxJltEPhMwVE9dEgkEKsonmspIRzZJjETk7/T0F4Yr7MyoiWyb53JZa7qUBeSYc2m+Mn9ENoNPJjfKVzQKaEn+59CU4Z4S7+WZsuEx9+AYjJ9Xvcu24CEo+Dlls5xiKu/8CLeEtmKT6M5e2J/zD2Hk8bTtqs03HziQlFWnfoWTEPcZTMh7rGxMBLDk9MimX3UbvzeYOi3NB69AkrVlSm2TpP/62kCzvgv/mgEZh0F7RFVPKKT2LQ1diQiVqcg8hJDdYAwv551U2O1X+NERi2MocrViq2UyxiVM6t95OXE8NmkJ151ELO+R9sU8corcrhNJN1r2xwE4aSkS4fXfyj+p1xGBsKnCVT775mWR5kGhQ3lWROP5rELqi0rZWU89TN9oxRFJXW1OHEY38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(55016003)(66556008)(64756008)(66476007)(38070700005)(38100700002)(76116006)(54906003)(66446008)(82960400001)(316002)(478600001)(122000001)(110136005)(66946007)(7416002)(2906002)(4744005)(52536014)(41300700001)(4326008)(8676002)(8936002)(5660300002)(9686003)(71200400001)(7696005)(6506007)(26005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L97A37Z3yGb8iXzLXJKMc0+xJZqlcXZHuBWLatS/9x9FTIsOUbrMwRPEFqmo?=
 =?us-ascii?Q?HAIAX+v1/Mu1TbjxBBG189sb1PTCnuoOF5975cCWhKUZ5K5Ye/I008Va6FRw?=
 =?us-ascii?Q?eKwCJu0uj7SKoBOndEnrnv9/AqAsrmAzcKGJ4iAjDghLGzg5itgd3i9vNZbN?=
 =?us-ascii?Q?BZVSn5z7w84yOd6iMdEaTs3OFlGBoo7vD9WajWNct8Hwv57/AmJHvu2gPNGS?=
 =?us-ascii?Q?cXMGPKZauxPsgcd1H4mxJkGsoiT0/3yZcm1xYz5/iF8UXFdleoqgvY1lwlAd?=
 =?us-ascii?Q?YikGNWPI7IyXF8x+wITGR9Me7z/zEc/qb2PrZctJY1o0mXmNKRS2c4OZmDop?=
 =?us-ascii?Q?7ILH1sSt/c3Dz3DS9T9lrsoEcvkjoiCsZxeFgvcyLfZB7Y7w0TuFkFPBjbkv?=
 =?us-ascii?Q?xRhQkLzWvu8V8CJtoFQk/XimgjHVSuczLUcwUR35Qu3AZNkVxnwbkojS+FkT?=
 =?us-ascii?Q?+TLvM5ylNpuvhlLWn27oXcGpA93UrnyWkwxLj1FHLVWBlfI4dirKqM3QNx/5?=
 =?us-ascii?Q?Y/zYSxx4xoRDnfbgVHLlmXh1TSHyqfODYTRXXO0NwckCBKVE6cjRmGto0Njq?=
 =?us-ascii?Q?+H2VVXj8Trq9JcGmZ9ECEzJqQ6/SAQymglZ259mM+BcghJXjoDbv04d9Mn06?=
 =?us-ascii?Q?nsOdf/cr/nXv4NLLzP+/WEX6VMAqqzuXSWBS6YXWtjm13YnxOVw5ugE2vX41?=
 =?us-ascii?Q?8FEmKvNLjwmZN+OIIngezFiZVQwukNblD0OObrxRrdjiy9u34C9ki33lULl3?=
 =?us-ascii?Q?jMTKK7CG0bF0DGISefajWSD3qZDYVkHcZuxunJz2sFXO1PLvUp3WqfYlxM7P?=
 =?us-ascii?Q?QkU1pOh6NIDEsnMyiKRZUrKT6eiVlLEdn6FE5fJrl+imqijUs/Iw79gKKHtq?=
 =?us-ascii?Q?FUybB/ERPCwlV/V5xtC/R0O1PtSxsP4yyUoeUaLgR3arCU/7uJAlqB2GUDf9?=
 =?us-ascii?Q?hzEwX05Eo8+7xZNw251vgXs0OADD/zqZS4FfFNZgcCMw6m277ePiXmD4IJ0m?=
 =?us-ascii?Q?jm4xT4jSCsUcwC/601BnpFvQjHyJYWqnUR9+yQlbUzkQk9+6iZu9mzXfeE1a?=
 =?us-ascii?Q?wmPgfObzzlMnaYHg7N9goT8BkJDYTJOI7f6iJHT+OeqM9ih+zkQeuA+cavKO?=
 =?us-ascii?Q?66PnkxNLitYDt2DeqLS81CZ3Qh5oJtDTtLIeO5+nxxDvc8+s7cqnIbzJnDD1?=
 =?us-ascii?Q?yCDFV0QKGqKvP7nHxnQJj8qxzYmsLzu84VEoMEY167S7cOIOZaJ8T9TGycT2?=
 =?us-ascii?Q?wvO1aAZDg26CHdAGM9ricQSHu6bRKAnaGyG0Qv9UxtOnNvT/EjrxtZs5zcHF?=
 =?us-ascii?Q?9zYcvZ16UHzxNemlEtvkh8kLph5kcMGvRM+GeByANMoV80yi7yRSlf8OQJqa?=
 =?us-ascii?Q?xFQnv7xS0GFnL8tnYGWmInA60aV3sRWDsOX9+jJSLCE5614FOCgJ+dFX/E7o?=
 =?us-ascii?Q?6LJrySM5MD3L1aJJX7ahqjodVQKTE4OLbOWcKjeDO/tUPXeOfyHz0xQnp/0d?=
 =?us-ascii?Q?cuHyOm19tuXxdG8hPK9vKWlsX2RvjULOHoGJ1jMV+iZJJLGE+QPW3PXR5LSX?=
 =?us-ascii?Q?C+3UTyLPSc2cHaEwELn8xyen1zp5ol/OXGDeMFKH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9665ad99-c86a-454d-f5b5-08db9ef42aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:32:52.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emZdeMPVIAgx5lSD0B6l8WDq4QfKAyaQqBxVKIjYWgknBMLbRSuF3sZEp2/kA0yYq6y7kRhUmKE6ouO3UMF36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, August 16, 2023 8:14 PM
>=20
>=20
> +TEST_F(iommufd_ioas, get_hw_info)
> +{
> +	struct iommu_test_hw_info buffer_exact;
> +	struct iommu_test_hw_info_buffer {
> +		struct iommu_test_hw_info info;
> +		uint64_t trailing_bytes;
> +	} buffer_larger;
> +
> +	if (self->device_id) {
> +		/* Provide a zero-size user_buffer */
> +		test_cmd_get_hw_info(self->device_id, NULL, 0);
> +		/* Provide a user_buffer with exact size */
> +		test_cmd_get_hw_info(self->device_id, &buffer_exact,
> sizeof(buffer_exact));
> +		/*
> +		 * Provide a user_buffer with size larger than the exact size to
> check if
> +		 * kernel zero the trailing bytes.
> +		 */
> +		test_cmd_get_hw_info(self->device_id, &buffer_larger,
> sizeof(buffer_larger));

Do we also want to test a case where size is smaller than the exact size?
