Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A470ECF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbjEXFQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjEXFQo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:16:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2F186;
        Tue, 23 May 2023 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684905403; x=1716441403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LbPD33uUsffsDDu4ZZUUEhX/rgvo+iCuRcZN4pltm+g=;
  b=SixKQ+B2cehArqfgozkKp0PLx36IbsMZ0anEAANESY0+GCNI/SqhkfbL
   cjYNMmVPz7H01QFzZD1eej3aBUG2NomcfTKALKKmYKb5nKYRbK4JbJjzg
   YGcptoVf2xur9FhqA96MXUuwmWcdG8EVAY8Tz8RmpSsu+uzfwFndUkeHc
   A0OFV53vSOUPtle0RsAf1jfYcZX8gYzuCcpuE6/pK7m563ErgdXzw9FAl
   gd413JLsAOzlYNw7z9AdoW22ofRGb80Ip60i1i4HaDx3ZeqvrGNAjrcEz
   xDB2bJDGefDFMdaLFHvEvlROu7Ie9ojz2Hip+XnnyWbYoHfzd+fhl23pI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439810949"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439810949"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950852063"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="950852063"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 23 May 2023 22:16:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:16:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:16:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:16:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbIOBY5x0sMl46fvBG8n44mjg9PnjfWu1sRDGiC/aRWK6dM069asNj5kzC0k8yI7TbyRCfvlMHT7KAyE+uxD0WMY1EnIsLd4RClAvY9BB0QBHUwKyG+yep3b6S8zpH0mEIlrsBzjO/X6gt5yJkGpDMUfOrbaJXgxGkg8w4Rcttn0EgX7MKgIPp04E9wUxeOUalNSvt50QE3nIMNtYVSs4IvGTObFLHk5e5uEvBdUSuijG/S8vGZ6di0uff1+oWE1190mgiKP2Dpn1YRPdVZ7JTJ7pJMKSOpd47NIb8MyiCKmEYc7OY4e/6C/7InN6snGLMU0fGNVQRr/dXtILxq7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0LZxxBVMmow6gRdJkwA2XyDjUVZWp/Ohm5MvQMFXCA=;
 b=TPmasXy5RNm4APyohL7VzgzW/a0ddbjM1PhuBZEe42XrPmZ3bTMr+meveqQUSYHW3Vxsag1spiCVZl0au+ZUCc8bEhi5VpLegcb2CkvVQzfErelHhlA8irC7w2aQVh3ABVMkWOl/k5IGzUOc2gYyZFfjaa/uTwi/+M+DFU+SpLOAiVIKjXM+5NzWLmZ6Q20gFs4zU9+0WkcPtSED25IiQAJXJc4eMq3AsAO5uSjDYAP5k1KN7F7torN5iFshvhRDOEsDOIMZU8GfxHcO6HaZJ1dpKdiwgV/sFRRoAnoBdtmrQN7deJ8C294Q6kZregOkOscvIxQYTKqeEH97SNfEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:16:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:16:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZhBZXnOm7clyQUE+6OxnZdoaXBa9hYn+QgACrGICABubsQA==
Date:   Wed, 24 May 2023 05:16:35 +0000
Message-ID: <BN9PR11MB5276FCE1CAA5556E0CBE0B628C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
 <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfSjYMA06PmaI+Y@Asurada-Nvidia>
In-Reply-To: <ZGfSjYMA06PmaI+Y@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5023:EE_
x-ms-office365-filtering-correlation-id: 2b875fb6-2057-4b3c-b321-08db5c160b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV1XbgxcEiRg7A3oi+191bNkbWcdnUwimV7AEdcHzcjm27zjWT8RU1tL7ObsCNSEgDND2ncKTk/0x7hsf9Zv0NBtINtZXfMqMApLJNDD1cmvesGdNhWOB9Ak3qfGhe6+Sj37mF120j9g+CQf0uOYaH6R6VjEiesFoXFqpTCQlXLfqXSCnjXxFsJCNIlci3HmViuzor5iu4H5dLTZvP9r+iPRTtkWQ4iZ7i73EBFhucSuzVsijvL+u6M8VXycosIoqWj1oTvarUa1DAbnGY3sXCMS+Jc4WoppcA0WB6CwNfGY7Jm7kkD/JQ46Mgu9UNZSDgX9c+Cn5OPGTRjiA9HAaJmcP1cGPvGxZ1F4xNlrB1EI+2qMhrEO1wkC/c3L79s2l03ycx694YeuygmvV6y9V/dgXAvMCEs1sLlZr2/15dxlKoQFMBwrqG1t/H3uc3rN9xDWEkLyqAWTQnHLeN5lsmqJ00dhK14pF9EyWQcUocKbByAiIuTi8jGxMGLL0z8LpXbE9kzCJhJSoo+S5N/hKIV8Uu8/elcYpjtd6TUOkiYBe8OrhmEIAC8LvxvQcnnMxwd6phexiJS1C/jS0FSXszwkoUZIfm2PB0iTrYNEnLYmrW1Bf0fXA4gCtlPsYek4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(4326008)(6916009)(66946007)(66556008)(66446008)(66476007)(76116006)(478600001)(64756008)(86362001)(54906003)(41300700001)(7696005)(316002)(71200400001)(38070700005)(5660300002)(52536014)(8936002)(8676002)(55016003)(38100700002)(6506007)(26005)(33656002)(186003)(122000001)(9686003)(82960400001)(7416002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iCYFLmuNfgXE3U0FlV5RJF/YD6nM3vUBBZzxOocf7y3BMvEQgUHPocdKidxV?=
 =?us-ascii?Q?mBs5VnTIhZxCGIb+WJwzze1RIb5uwJZnzZ/4WrnxR+o3Rdf1wfDFxS3fymAp?=
 =?us-ascii?Q?AYSbw11WzIdtORSNNGKmWRutTQGErfCX0vDdrrXQPM1BBM02NYaXdkxDl6XX?=
 =?us-ascii?Q?A6ky52ZhI0iV8Z+IZOCtppIOn2VHyiPY4DoDx0tn+q++5+tNR+XWwAFihp6J?=
 =?us-ascii?Q?xG2oGjZ89qO7nHtxAFk1Z+5BhmDVxqkrQK3EDak2Nk2f97TN5VGIX/claiKY?=
 =?us-ascii?Q?+3jJXfxxvg+kVd2p7wxgBPEjmWVGQnkxxQXEd73U1CKUB4qgtn/8oUv1hg0j?=
 =?us-ascii?Q?dpzjmi6Yo+U8YIncG8YGaHbhX/KNQ3KL141H8ViXc5hVPkgDfDWmvnpeOaQy?=
 =?us-ascii?Q?7qO8Pb2nbz5IDZQnIw8Qwp07g11YSVsdY5Zs6bx8CJmf2xP/Ye0XrG1qYgiC?=
 =?us-ascii?Q?CBUWIcWK42N+0f9sIXYpK86JjQBCpCyxv890jesupg32IJHUffjxZnjNFBPV?=
 =?us-ascii?Q?YjjTsZ5txUFKJDmgy96ZIwTfjzS6OVJJEK7AMU15jVTfFI2LUu4i43+3NdGf?=
 =?us-ascii?Q?/8Fbyafi1EtO1VeOaEP2IvD1bOxHKJSD2HJB73VHBLOu2XX4a+cSYAXY8Ay7?=
 =?us-ascii?Q?E7XLoyckezLUOPaAMqaaxwczC/RBlkIwbCtO5e/2zllhsn5ZLnEz0y5K29Jz?=
 =?us-ascii?Q?FT2csc8/k5/OvXM7DlWCvBaX25XYbX7m1jlu2F4BfggObrEeigZNWltOjMWH?=
 =?us-ascii?Q?gYl9uRBjvF6YsDzycKEiENOVUo7FW/KDPxmdcoXQ6+xgieSUBqfCDRQi9vhm?=
 =?us-ascii?Q?B2f85GAeJQe5VObRxxfBZESN2q1Jf73uSS78Iqq5jH1oJp53x8ogQzUwRFKn?=
 =?us-ascii?Q?O1i/QLzIL+t75Ttc8G4cfFtMC1HtEgtljcgac4eUvOLkkJ4nbfQjp074Lx+1?=
 =?us-ascii?Q?rzP5XN5D8z2PxFGPPt8OG+6Xr0ts1AQPtpH7HkJ039784TGA2gcAiTD7ebnN?=
 =?us-ascii?Q?x/QmIwabznyqLAch2UJVvAcS7j9QutyB7FeuNyWYv0hI89cjuClolXVYKS+w?=
 =?us-ascii?Q?aJpkmR3BqqnpVYHBCGSD4kB6RqeJOhv78gZoG7TJvTlppUyUfVaDLXfUlL3Q?=
 =?us-ascii?Q?tCXu9b79JP6ig1vVa3m0VvZOIb4IToivus6xKyyy4XF4L65ocg+IL5gGF2oR?=
 =?us-ascii?Q?+3H7bGzc7dOf4FsCz1g9PDtnokDHs0I8KoSbqklqZpxEtZ0IlyoxL++izTHq?=
 =?us-ascii?Q?FNoB0J1r0jz4jJas0Aj1lSQ8xaXVK9mBd78M2Nc9xlF9by4SlEAAjoAR0oaH?=
 =?us-ascii?Q?1acVfBOyy5xUb7RKNhnpCehL8Fn8e2jekqMzgCXGbMWGtVkT+a8zLeDT1p8p?=
 =?us-ascii?Q?X9JCRHuCo3nTH4oOE1XwqPRzVNVlV2p0bM0BFidsNkHRtlI0DLMGmv10CrsD?=
 =?us-ascii?Q?AFk/9gPa6sweeJt9wvQBZSYoaR+XDCdsJhAHUD1qwvykZp2/Aw3gkwZpV/6s?=
 =?us-ascii?Q?sOVslMwGwinF8A9NaE/ylI9jZwBbfIwABdAIFev9JAYI/1kGvsxpfavquGUg?=
 =?us-ascii?Q?qv6cWJK/zkqNNPDekuuWjLyWyRFKWN1rRgX0WDPD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b875fb6-2057-4b3c-b321-08db5c160b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:16:35.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaUdlehh+tpLhN9o6Tm2dvORZdpFTiCw5wR6MyGwrwzo2P6LatMNDS8hcEmHro0aIvOCT9egRmtv4gQIBn0K6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, May 20, 2023 3:48 AM
>=20
>=20
> > >
> > > +     switch (pt_obj->type) {
> > > +     case IOMMUFD_OBJ_IOAS:
> > > +             ioas =3D container_of(pt_obj, struct iommufd_ioas, obj)=
;
> > > +             break;
> >
> > this should fail if parent is specified.
>=20
> I don't think that's necessaray: the parent is NULL by default
> and only specified (if IOMMUFD_OBJ_HW_PAGETABLE) by the exact
> pt_id/pt_obj here.

I didn't get. The uAPI describes that only hwpt not ioas can be specified
in the pt_id field as the parent.

If we don't check here it means the user can specify an ioas id as the
parent?
