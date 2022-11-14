Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F66276DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 08:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiKNH71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 02:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiKNH70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 02:59:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4610232;
        Sun, 13 Nov 2022 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668412765; x=1699948765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=evywZJYpIwUqvewLPcv7nV8kI+p0Cb27xbjSIiqRzN4=;
  b=EvrPm5xg77uMFzaBDqwqBoCRkaFZMUIh8AfBZWjdVdsjFQATeB8PjOSC
   vCBQbPioItBSx8sPQV7yP9XEKf6pyb/j+b2FBg/JipcEXbAhYWQOHp98B
   Q4MMd65pFY9gS0SDh+cB14PYur/m5SsOZfzTIKohfziBOJDw+zaRl48dn
   7GnRYTzE7os60BwlDK2QFczB77UI9AYbugfRn5JW36pSCHCz0KJBbOpAF
   2Qs8vuWd5M/5uJnshJTMublZlD2+hP5UjIeQhjOrl7DX+X091cASxcUB8
   686Ni+0oFDjSEKKKLTm/CjmWipNSGS81B8VCoQtpSEPUfroKsJmb34gHi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398198990"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398198990"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 23:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="640672634"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640672634"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2022 23:59:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:59:24 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:59:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 23:59:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 23:59:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfnEjK3ZYWbybwVYFwUSyrA+CQCO9NwViBdUPDj/Ut0ORgrdmIiVK2c0beUBPbQ1oTzX2qIuUP3V4BJ4hMHDKLkIrv8KJpuAEz/unWG1OHkMW8vtaH5MpLupueSyuBTjq7bzSJGBpL7gTRruSg1xPfrH3k3erAI9TUB8VVn3G4kvh7FmChfuzP/c76M/sN/UWq6/scooO6S3Of+ZygTbsxVw64dwqG5qQh6+HV5DAo7CBJ15PMRFsIG1hvZY8XixpGrn/5ohIm2Syd8WEu43EbcZN0dMFPui3uERRBcnwMDlebDFt4YblOO1GUm6QevJea9SFGnNZ4SjulLCpMyv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsaFSLu9/nKASWVE5/5/dn8/ulV4gv7tL2Ofap6o94E=;
 b=bHEtkd95QGP8atwC29+WPR5k2WVEibZKonWuhOCR9CGuXfQlKgV6EZCMgp+BjMqDS2EFgESphz23QLvC9tLW+t/DFd6UJClI8hePJwF7g1D46dafVoWdy5H39VxDXFLNAVeiIs5tG22x7TyOg0vigCyLbGCziZtsTsaOUsM1wIu6ozuJd9YOhZpiiaUfmr6y0yShbWf6ga959wXJUlkpswcwYMcaBw9TzF4R7x8spZTJmYUM4cV1GRCkbGOcKCCZbmgXDVq1K+GE0KdNIYdqMNQvcOD5JZ5vucZ8PHgR5mMmOz8ltu00vOGSUD8KyeWWm0+E2b7JZluMtnH7ALgTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 07:59:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 07:59:20 +0000
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
Subject: RE: [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Topic: [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Index: AQHY8wv6CA8CJb32DkCNRqc1fvgrX64+FLig
Date:   Mon, 14 Nov 2022 07:59:20 +0000
Message-ID: <BN9PR11MB52761A3A0F28380664A009588C059@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4672:EE_
x-ms-office365-filtering-correlation-id: eace3faf-44a7-458f-c1c8-08dac61622d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbyeBNC6fjBzo2NjFjrpPfeviTBGqU6u2Bvr+ozVQYsrrYfD8BV2dMsmJOUYuB7osZURtfNG0zg9OxwlngPDCXDzgZkZ6RQwjfNJqpm/CiJjI4YDoVvTBfETDt6WRzkHg4/2BBPC8eENo/XcIai+zQO4P4Rj52nrjqAiW8uIcM/l0LT0pXTrhnHHlZxvl84EO3s6o4jeq7mhq8Ru0Lw7WA/btNzw0aVoQ31Khn2CMUtfe1guKrxf0yQHcmOVkBjjSld4DujIIsicEcl7RmLi4TM9cBqKQbw3lHhMSoB39cbMvBFrpgdIDevJ6Uh4dp6IWTcuqU35hUnsC9P8So6pzJW1/JOM/mBSBjkBMCAyx0t5/ryiU5ZG0w+XrObq5bTsTe2iWpW1r/y13JAwYaEwAeOPekvWWQt4EoB5RHOQdyNRxRAkzzpY8vWSjDG9K6/xWd1B6WDDeVKkYbh1bHzyaBoAKmFa9KVUHc7rd7/VdZ+LdL5ZLZTUZ6l8vn7KIRZvvw5UB+0QhdgRhhe0zDI5e5t4vpkU5jJPmnDUJ03h0TBHH4/JhqGWpXblU9crclgTVL49zjWHPiuav4p0xcG4btroq/IAROkgYh8JkSfzlX/25jMr7lz/p8DGiyAatkBqmiKGarzteOXU0ZOUdZkbfAhzdATjaqaqRgTZVbx7FkmTEQtHNInjMljx/Zeb3znEYIIMUc1Ag4BJB0TOnQ6Vh3HzyJ7M41VKlHheUSXmdaBOIZocO9X/s8rY7CvMv+2Sl85wX1dF1PTMS26zf/5H6RdvgibExC7Ay6DYZia/LYs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(186003)(71200400001)(83380400001)(64756008)(2906002)(66556008)(66946007)(110136005)(66476007)(54906003)(4326008)(8676002)(33656002)(76116006)(66446008)(316002)(26005)(52536014)(9686003)(921005)(38070700005)(8936002)(7406005)(7416002)(38100700002)(122000001)(82960400001)(5660300002)(86362001)(4744005)(7696005)(6506007)(55016003)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fsyx1zM4EFNmNzI30UC7KiEbAfHXjh2/S/NAPsmAVbBFSoeO2Wf9MzL/V7w4?=
 =?us-ascii?Q?P+dl7VBTfjXDyE+ol2KiBow0eMo1mmmhpxITLGqOVHnbKX4eEEqOfdwd6mWX?=
 =?us-ascii?Q?Gt3T5AWIUhFjdNdDxiwGI7NY8ym5225TgggSdBGjKlVhdiNbBw8LrTeTRApg?=
 =?us-ascii?Q?LhFPtF5wwCDbVNguVxpbqI4ASTc7oCqMzkK1R2gEvfjrrR1883aHxYh85rMW?=
 =?us-ascii?Q?9MMQXRx8bq9uFb3TmuvL4D2LENACuEplGBbrZQ59zD4kV+4rx+iItI0gQMFb?=
 =?us-ascii?Q?xftJ2mFahdEAQqGoV+rmkofgPJtpAIZE3+05idkvw3flCJ/IiVcAGEkNZGBT?=
 =?us-ascii?Q?ynpW3fhlGZTth+6G+fvxyy1vvTuski+DqXzIoa45yXm4TxturrcBJnCbsdyN?=
 =?us-ascii?Q?7opE3/LLAqXWbnT0yStq1pEThe5LTOwPoXMNm43o80afV2u0aInMeUqoRBol?=
 =?us-ascii?Q?Fpy+c8bKH8iOify9PWrGYC6EjyysNtrVtpam4eO+C7zqyJXJ/6znKWPLCIpl?=
 =?us-ascii?Q?egEPoRD9RrvslyPIFBoj/rVXJMCn1c993libx8EiICiH1ReHJ0oMYtCaBHYI?=
 =?us-ascii?Q?HHHntO3z8EcYY/zzA+AXYNDHeMEBdzliv8QWbRCvrEULCW2Jt0rJ4nDu8HPi?=
 =?us-ascii?Q?ioHq118eXIuPxD7YT/OSFNAY7XPG5BYtPR6Y8RvVxgjhu5upDtCG0SnG5HzC?=
 =?us-ascii?Q?d/DGSH56OHjmldS9f98F6dVaV46c1WNLYWtNeQs2NIVT+d3VNECeY6eH5DgQ?=
 =?us-ascii?Q?0LJ5bHufeciN09zfDXrSMQvYhwAmwElU7Xnx8GznaIOgYJNnc8a4LCwsSZoS?=
 =?us-ascii?Q?T5Ta6LdAfeCTogZfg1c7fzR1QGPucWPcsoQFgRc8HGJTcIVdyB0o1A8LS7up?=
 =?us-ascii?Q?UBfchLs40GvJ28P7GRkPhBQx/RTVHCpgy342VH6FUwQiC+mh9RvTOIAYRvBM?=
 =?us-ascii?Q?efl2LOyXEX7t4voUNTG8/XYBPTRv3CbKPaxrDktF6YT5zmjCfIa7bO+lfOZd?=
 =?us-ascii?Q?DVWJflpMVC4wWZhPx1ZbGd/sp+KO+285TuvFr01rmRF9g4fGSIKTVWJBTFjD?=
 =?us-ascii?Q?VN0VK3gBbRIC62vFKKu/RI8SU23FZiNxAf5LORX4nFwiRyrPfAg5Mr7YBpx8?=
 =?us-ascii?Q?7VTtNVhmDQ7k3Ht+RFDLHaIwPIJbUISCn4wY4irQhVE5nH0hlPKzGjem5YRR?=
 =?us-ascii?Q?Pyt+isFv/VkQxfngsQxTeDdmNgHTGhJ1Eoyo8mpSpQgyvfjvfsRcwmjFK38u?=
 =?us-ascii?Q?KDjwNbEX1++RmY1YClcUJq32DdcGU/qVLCeS7mwsF9LfU2G6scPU0kundQN7?=
 =?us-ascii?Q?JJ+dlTirzZYlIqbp/gAca42pvMoMYTkWLn7lIf8C2ZO9NpfzbQw0D63YiBhS?=
 =?us-ascii?Q?Nz0yMG7lAp6L6osmYotwSZQxQ16jGZvxSToIWl/XlAB2U5InZcTvPvxQmJwR?=
 =?us-ascii?Q?ln0zIXZ5tviQ/9frIuuTPLynCcmga5QrtaPi2tvSG+FxlIuJLSa/xUWH5kWf?=
 =?us-ascii?Q?3q8Vr8qahjR3ZImsuFTl5blRbhlgzraeOQmBQYZKewhfsB3C9FMqYBlsVhvt?=
 =?us-ascii?Q?Ek27hfGbTp2plbYs2zYDkJAHsWXjEYqjJ7iq0yvW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace3faf-44a7-458f-c1c8-08dac61622d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 07:59:20.1629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9OwVf5EPSb1oCW/4FnnyYCVQUj5qevw39zdvlTPxXjEa1lPF7wOq43z7hyPItka6lL/+FzyOKqucMMRlIWc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
>=20
> Add the four functions external drivers need to connect physical DMA to
> the IOMMUFD:
>=20
> iommufd_device_bind() / iommufd_device_unbind()
>   Register the device with iommufd and establish security isolation.
>=20
> iommufd_device_attach() / iommufd_device_detach()
>   Connect a bound device to a page table
>=20
> Binding a device creates a device object ID in the uAPI, however the
> generic API provides no IOCTLs to manipulate them.
>=20
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
