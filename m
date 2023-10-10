Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3437BF5A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442640AbjJJIZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442525AbjJJIZG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:25:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93CA4;
        Tue, 10 Oct 2023 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696926304; x=1728462304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n+hj9Pmj73RnBte9d6u8rswpZfxe1njv9bBvVcwtyLg=;
  b=CeNEyEjFxzUCESwM1u/eYIOvqHByFvBLgUhJ7ECJJMgB/acgyYVqAT30
   w8bpvpBBZJYLfmNT/lz9btokYDy+0K4Hb0c7C+NUgJG9R5th8G4bPk8iN
   6VhHq1aUYF8uiqr/uo7tQ8kpLyY8GUB4cGq1gtoUUVNKGsEuI59kXbNn9
   hnx5xhhqhZnGiFhuQUjn4npY/WLiMfh9oW1BXzzGUaFuh+Ge2H/9aNBwL
   hNhXVK+QY7SB7oMX35I//lrN+adXqTPUCeWf7u7IWj2hVJ72c5otaqDZu
   5dZJrQVLEMb6kRbnjku9//D5Yn4NTgMZnvOXVviBf2jMd6tEVot7aL/tT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363688115"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="363688115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084684631"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084684631"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:24:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:24:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:24:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+f/+xpYhNdFAqEDOx1/o+RJbjFGA8CC8diwjgWnxxzcQ3vFCtc/lg5wpHqPKEsyyyt3rPDTAevbr2k+T/QOiAHdXanl63qlASUYyIfZl9LXnfoRJtRjiG0ctO5HOjuFu1WZDc210Z52Qm2omOpYPCgLlpyljdpr2fjTfhsmJurfrJEIOvPzOwsiA2onq0dYbl7Fi6gcC8n9rZ/FuEC+1yiBnfa8frTFdMqJ0hnLyaIpLx6pndvlU/n6hsqG32HxajvMooQRwNFcTBI9iWxdrgl/NY6xKCojQDDlZC6U2yyH1xcXlZOY8qrap2bFMp47QGkvB8NiZpsRWoHV+SBjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+hj9Pmj73RnBte9d6u8rswpZfxe1njv9bBvVcwtyLg=;
 b=L3Hfa6AzDWZm6Hqslm7nA9eLWoYVZ7kJ0nSKBGpHePTcYSfrr/6R0el+0LKJX4XTmZgZQUhGK+iJEhBu04oq62j2XXTDnW6QrAronTOXmDaldAF+P7opf5GGEd2BNmLbIeKRa755dXOBVoYnEopn+gVT60gG2+Edfc1wi75RXskcK4NNfsTxPIK8azoIwoDXsKU1CfTzrxSPpbUlTJSEgkzvZIoQbNJzYMROVSClTTrUBSXKl0GHgnlY0Apg22o8kI6ZopJZu9wChSZDIG2BmU5OAosqILGHt87DSMn224GBLTo75TZ5ohyUf0dia12jaitL8Y2/v6sLortbANbtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:24:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:24:25 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 4/7] iommufd: Support attach/replace for SIOV virtual device
 {dev, pasid}
Thread-Topic: [RFC 4/7] iommufd: Support attach/replace for SIOV virtual
 device {dev, pasid}
Thread-Index: AQHZ+o3TGRj6hZeZREyTEbCUScXqbrBCsA6Q
Date:   Tue, 10 Oct 2023 08:24:25 +0000
Message-ID: <BN9PR11MB5276EE3482E71D50B3296FAC8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-5-yi.l.liu@intel.com>
In-Reply-To: <20231009085123.463179-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: d0f083b1-e50f-4aba-cb5d-08dbc96a507d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J06BSv+hY7p7fFgdU33BLEAd+Ln7YnNziU56umqhOsFQm1Orvk7IE8vdP+t/09YgiU5sUVLq+fY3jNZb6s1bSjCMAVX/evOnFP4fQa5ZovkUQG+oEbMRmVLZX9pWvhDnyYskAYW5mC1lI8ZAo/JjkrFiFvbCJyt7Xj/e3yFudVpFxVfSGS9Z4uE1Nkjycof723ZVnnpt4xHc3esDOVliMzds74wgdMUxHRptCBCTlTIim47ATXGhXd7+xJKXGxU1nQNVwUgdfPZMM55qpupnFPyvO4GurAcd/x1RNICwUCwxMKzJRhLRHVnkKZk6xX2mSL7in/dKHa9FW0yXZDovUHS8E1dY4pl09UAzpbs7HG3HtAjieE8xZXGwnsRw6OaYiKIWgKlrt3fjAK051Fhu8isdnEMZMGj0/+x44uqL0Ply/XZ+rViTj8sjZ1hAXmFoBbFYJ6D5tOeYfLw7pgxImYgbtiDoFLA/jrCD/8cPFkqIXDzNxjo8XH8JWHKbQZbms127f5+iURM+BhMLC30V0LCtwcnColawMVa0dBp+s5zIXnF2Kvyt3V6vX+5Tktz7xP5caLgCMFoJTKLcx8+G20T1YZdr/k8iqNy62rlhKZYsM26Nof0j496r8czid4ZD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(9686003)(7696005)(6506007)(38100700002)(54906003)(64756008)(76116006)(71200400001)(26005)(66446008)(66946007)(66556008)(66476007)(110136005)(316002)(41300700001)(122000001)(8676002)(8936002)(52536014)(4326008)(5660300002)(55016003)(38070700005)(82960400001)(7416002)(2906002)(4744005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8UZCDjEAqsDLfe++Wuz7EQKcbqqSuB9Uo8SLVGiCVSPvhB34W1smQRVEC/aL?=
 =?us-ascii?Q?b6hrOeRQ2y9EKwOKGq2t5XQ7odmi1Um/77pi5OP6rII7rZ5sGNZ3U+MbVTLQ?=
 =?us-ascii?Q?KPxQYFi5B3dQSnRZIIfuksMXRHM3hYF0+RngM5fPkqYgy+dxQG+DdezgbeEX?=
 =?us-ascii?Q?D4YDTVLw1l7/zmBspeLFSw0nVdpVaigI8KIUuYRv8PxWYmTrOfshmxT6B28i?=
 =?us-ascii?Q?SWI1aCIKokpL39/Y3uNSmxaN/6U4NX2XSnQpL6e3eIZAUUSbrkxcVAU1ZO3c?=
 =?us-ascii?Q?XnzJsNj1SRl6DowfI1H2o5BkR4xy0UKdRa+6LKPsEL+PDgJ6xKlmbr/Gx05I?=
 =?us-ascii?Q?fnMcUdlZF2o/uQikqh3ayEapgLgwdq0VVuByiJLIqdHW+FsGPgawUVZ9NTU9?=
 =?us-ascii?Q?4iVrtEOZuwMWpRMPXPT2FNiNncje7hUaGnFxyLuq4QK2xpF6mE0SX+5XZRde?=
 =?us-ascii?Q?rC3dnr0Ea2zVBgquM76hjb1q9kwKSfVd94S6GTgdZgPMVpcscn5w19cAPixW?=
 =?us-ascii?Q?UEthn9s9VtvxDvwD91DTvtgTVaaFq1pUYqr3czmJvCCax8l97CG7/BM8HJHv?=
 =?us-ascii?Q?30PnpYRUd3s/iIGwe34hcm8FTSUDMgex2NCzzJ1czTOhtHc/o8rOYj+wwlka?=
 =?us-ascii?Q?DuTGTPenQZjBP5D4ziQbMaY3rypL5Xe/MMZp+I7xH48oSNJc5il5JTrP1O/f?=
 =?us-ascii?Q?q1jbNViUgdgHQFtcOdKt1I4zyWSrWbm4pI8b4+Vj0Rcuh7RVH3vHnCyogxwg?=
 =?us-ascii?Q?z/6cxDXM38LLzUI1jyi49msw4tWF5R6XOTbBtHW6wU1LHq9zWnPLDunPVTRW?=
 =?us-ascii?Q?qViBDJ3oRQudWKWgRuvpse+zd4b89YW3CYcS6/fxMZ6e5w3utoKBk5AUWiuJ?=
 =?us-ascii?Q?/cD4JVkSgaAWqHU36BI92Tm2eiuhGcGNGSTOsMSrE9Hf87CrbuLg4zZ9Zle3?=
 =?us-ascii?Q?hrTkF9odVhw8KSrWY7IoMzsDFiHoSyvY5ucfDQ7akD7VYkAXd9hZj35WUYhT?=
 =?us-ascii?Q?7+VZC6HfFC3J8CknWtIGN2tLGWx39yocDpSu2COpEkC3SmLCw4/A4xfvKg7K?=
 =?us-ascii?Q?nbhsRIy2lsfWQhq+TwxAJ+KSUmd9VVA1pMDYNf8JUiyDKY8z1TaDMYhFrM/U?=
 =?us-ascii?Q?DjtCaYfRxRLSRXGAKY8fe5aydTpD9ynr8Z8Bqfyczt4l+zZ7yjJzTwJZiTB0?=
 =?us-ascii?Q?EjQbJBGtWeUrue27mtxb0OX/Hko11PVa6WIxvYnlEidfaL6k8mQgYmatEAvl?=
 =?us-ascii?Q?lzC04f2HLIPLdx+ZFQ1HwqXZOQ4r0+vbex6UdBpqQgkGGLk3p2+KHrQ/5JPE?=
 =?us-ascii?Q?cTfqX6uF7X92V9RJpoy4170G6qT/xEqTDHTOVG2ry6moCFo5PzYbmTkSXG+l?=
 =?us-ascii?Q?wgGo1dWKRE/yz+c+99BaagWFvlSR3IJu2FGSVTb1ralHYWpMj8ZejAgXOxqK?=
 =?us-ascii?Q?m1Zn80wiufPuaXsX4aWNoO3bLcPNdGwkCNCR+8pbDadldx4xZVj4CVLjMRd5?=
 =?us-ascii?Q?g2suD48DeybSsWUNlsy078lf52KFLsDXLzDvYB54ozp2ZES7CMvA4/HRM/5U?=
 =?us-ascii?Q?r64lWgPu4dMZF7sAd/HXKHC4Qz7HXZrGhywi7uCp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f083b1-e50f-4aba-cb5d-08dbc96a507d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:24:25.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nV2n7m8Xe+vURblXItLJ/VykBx4oQDmn7yUoRuRHwJaSDozZDGiDnh/hKBVv+yevPFpFe5HWIgBZYQCBToP6yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, October 9, 2023 4:51 PM
>=20
> From: Kevin Tian <kevin.tian@intel.com>
>=20
> SIOV devices allows driver to tag different PASIDs for the virtual device=
s
> within it. Such driver should call iommufd_device_bind_pasid() to connect
> the pasid of the device to iommufd, and then driver is able to attach the
> virtual device to IOAS/HWPT with the iommufd_device_attach() API.
>=20
> Unlike physical devices, for SIOV virtual devices, iommufd_device_attach(=
)
> eventually uses the idev->default_pasid when the virtual device is attach=
ed

s/default_pasid/rid_pasid/? or just call it idev->pasid. 'default' adds sli=
ght
confusion instead...

> to an IOAS/HWPT. Also, there is no need to do immediate_attach per iommu
> domain allocation in the attach/replace path if any iommu domain allocati=
on
> happens since the attach/replace is eventually pasid attach/replace.

immediate_attach rationale belongs to earlier pasid attach series when
iommufd_device_pasid_attach() was introduced. Not here.

