Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAD70ECD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjEXFEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjEXFEJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:04:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A28186;
        Tue, 23 May 2023 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684904648; x=1716440648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPJ1+bG+ZKFcfj7qnzFv8BLuiwdJXOG/wbIJYQ7UoPY=;
  b=h7iIseWvhemwxzB6uR2R6QW/Uiatogvim1YmfXACz0QTzHZ7LFuZ4vFu
   etBUcUZRGZNI2OIB7jrGm4YrMUQUyTpTZ4ianzNLV2xyXTupgbY+M6MbE
   3lTBgtpFjI2Qt1dC62jx4eKBJpPlEx0vyUiDb0mkDVOAJmMv/u7WRSYdu
   pGBsuz+kKQ3FtCHQgeI9c1VSvMet+lB8FpvU7TXV105LW1g/IB6wab74O
   v+E5Li44cew9f0BBMFvAnP9sJCwi9CXXeqHcShqUhbSvqhRBiJlZe0fzB
   SuFNJBIiWgVm5PslyUdF28lJPjws/7D7BDHgSUbFsC5+yHdcrUVeeMMfV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416918466"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416918466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="681701073"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="681701073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 May 2023 22:02:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:02:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:02:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:02:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD8/5yLQcNLGDaOZPS7gfaJfoUiPpVr3FH85zB6XbGSjudATo6HzXh9XamOBlluLkvCC39oWM6cX4DWSRxkNhtZdTsYds1mrN2nT04Ob2PuvLUJgzhFYqeUiOTVW5+VzjftqZK2O//I8snCefIAZaDYDuHl+feBzspq0zCCHX1b7atwVrPqMhTBU6o3zBX0Pf0243b+NWCVPLi4u2ZzF2dzOzUwAtuLL0ffE9dhrvSBpWzIeQk9BHt09ciMbmzfMC8O0btIRRWG51J/kFDK7IdKVz9f52Q9mb01MVZ+X7uNf8V08cGL70Helj2qCEi4xrxXRMKRn+N7GBs1OMUDHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyfFLOAyN4+iBBxl17ec3IGkNhlzZxiDi6JG6VP0OrQ=;
 b=CebMDKKtGleb1Dssi/f/v/OPQbuZPye37nAH6qQCCbkIMT9oI9Ow4CP+IswzKG/0hU7rqWK4CxLfR+rh06gN7bytusg3p4HsNYYUhfrNEu+h64vaF0pA27vSO1owFYRjigblCTXMMY8kfiR4UO1DQUzbGNWJRNKvEdkLE118xZiV9TUYwcfNM5Eo2rLQmT6CnLbIdaQZBOboO1naA5aXE4/KvMOkmrIDKNAeBugKcO8zwPKyRzFnDzWMR9JXqVjpOYDrtOi94KpMmPZA/k4H2xvyDkQLuUCsxkKyZmY7JycytIlq1NTlUtkMi/TgINaz1aC1bVei6ii1GpH6VKClaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:02:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:02:19 +0000
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
Subject: RE: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Topic: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Index: AQHZhBZR9BAjlz4VKEe92tc9klslg69hVLPwgACnKYCABvWhcA==
Date:   Wed, 24 May 2023 05:02:19 +0000
Message-ID: <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
In-Reply-To: <ZGfDrRDI50oGih2r@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: fb1cd8e1-2d2e-4510-0125-08db5c140d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQJuIU85gJcq+cTgx2tvl0OTFylxbOA7eErksgdh+bqO63UevMFNw17YOawHlctFrl+srAWPxsXaygupgMH2T5QRslqzPsXTtC6TI/d0com/vnGIfGmx3A6hUxy3JGJFk36Mc7rZI4c4Y6nmQqgigN6Cx+kUxG9k8Qs9n5i7s9xFLQ5FmeuM3SY8mp2dmcDHBLrX/4Bv5QAqwnDCqlbZ3FeJ6d347RkQdkVopM1+82/31g1Z2ufTByy2gTve7xqEnmtNLbD7cEm3SegEvQgH+0+qgu0wp/72WNUWUjNbKyFX3xeo/eYXNrww+m/ykGTTi9SsSSKtN86PeuMOn1MlzacNRPDFqxJYRO6wyp31UuLvzr86be7glnhDS21XWtxA87ESAMEXlfSMGxWjSjaX0ieKkatGuk/qim92wmfrNyMTbV2XZuBcuV4d2E0AhtXUVkmlC6G5GYjgJXzg7CdQUTqvgxsA/v0WQrt6PrjdI0xlws8ZYVyzzWOgJIiljSniiZb8xItm3Mpjvpy6+pNA/UG9KR1cWlM+SDlagmTJfe5HcH/OeJOSkQZyVAyrpZicwNYx/gxgdat6oWjthRRahTfSXDR2WyIRR2sGo0ssA5gsybFpwxsVOXdwa4vNqkB6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(86362001)(54906003)(41300700001)(7696005)(478600001)(71200400001)(316002)(76116006)(6916009)(66556008)(64756008)(66446008)(66946007)(66476007)(4326008)(5660300002)(38070700005)(52536014)(8676002)(8936002)(38100700002)(26005)(122000001)(7416002)(9686003)(186003)(33656002)(2906002)(6506007)(83380400001)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MIVIN9eFIXnsjQqpVWuGYQZCtM91XIvAhGRjRq+PpDPZKKdEclldoVffI1KA?=
 =?us-ascii?Q?6lLNqjbA8Gsbf7c8BNDFBRWq7KAc3ED0EqgAAd+zLmO/Aa/KSPpCQUczqQlI?=
 =?us-ascii?Q?tsCJ35rgEUrgyLXiZJdDrVEoa1c65+zf9QctuznvcQeFToDg1LACOb0v2Ute?=
 =?us-ascii?Q?fvauq2yHS4ESDP/n8H7TESTRvVOnD9l0w8DekmeJenQR1a520XGy0gFJ9t7j?=
 =?us-ascii?Q?5Kg+F3NUzXZsdyG1xzBAEZo1e+LO7dCAB8IsjCwskciwd8pejBtTRwmPlqCQ?=
 =?us-ascii?Q?A++AMuthYt6uzSIfC5fe9dcp4h8uzftQTL8MkNySwJml7TlElnSU5bh2B6nm?=
 =?us-ascii?Q?kX1s8bwi7XmMkp79u7wqp5RkvWpnUFG7T8/DSZU1AFVFP2fTZA4A6im8Os3U?=
 =?us-ascii?Q?1OnO+7WM+WntEQNwFXH2rkh7jLT58Wfu2b08CHlrJ5318vWd8688LOkj+Bw1?=
 =?us-ascii?Q?PDMgD+ofIon/zhOWg5QyNTychjmVcSKZaRipF0FYQ2QYX2bFPZEIya1LbsMR?=
 =?us-ascii?Q?DjTJ/FvyBHFZCwOJszrpLlQSIjpmj3XV2VtjlY9Mlwb3yemguQOFNdxcsTXN?=
 =?us-ascii?Q?xlIQaRo8NVMo3Y5uGT8OhXupf9pLxncX+eZWVgDkmTCKftEWYz+rLEe5ZBV2?=
 =?us-ascii?Q?OXLWyipETKVNXcODcXvc2C9Vd4ICyQeCHYi/CCVq/B3zNm6eN/B9b8Z+Ns0J?=
 =?us-ascii?Q?o2XfW0QjJogBaXHkB1pv93M1bbKAOJfJleTFD4td01c4SXz2cDwpRc390N5/?=
 =?us-ascii?Q?PNqyymnO4A+UpPrG4Idx8DloBnUKFGR7wq+oM0ExaF72jhsM0onyAOEAni+T?=
 =?us-ascii?Q?bBvvTCb6+5f2C/LEOlK+piK8POQwnfyoADyjfEZnbzNG7lNyABbwv6Z0nkkU?=
 =?us-ascii?Q?rp3ypzEBZpea1eafcv3lE7rlg7MCDnEj5HyTemSFwgsFlj7Qc6lHGrcFloid?=
 =?us-ascii?Q?SrKK1wSz3iWjXWvScXn32o9tiAhZe1TnIr0i9q2pWjSxAYWoTpxwBVPZ8Dde?=
 =?us-ascii?Q?U0aSiGULvQeBK7BC0AbU0K8IoOxQcd0ZG4ojfMzxzTsDk+7ql0q+A4Scm8NX?=
 =?us-ascii?Q?+Dl6hey3j0nNXB/FKStqaL3I31+LZ/TXAmyaRhbI7lqSpwJyFcsrzeXJ6mKU?=
 =?us-ascii?Q?8z19fB3HCPs303C+J+qy9LAXK7ulAPSxwASPBh5pqWxqL1LrKODlwm3LneCg?=
 =?us-ascii?Q?SH+0PFqbJ16rP2FQekr6TkIshUNiMBhxoSEgykSWK6H1CP4YCNBMVmmdMu/y?=
 =?us-ascii?Q?8C2epopaRidwq3qiZFbyvRZk8U13/ATSc4B1YXbx//GSy2+qrjfRb6GUerqs?=
 =?us-ascii?Q?AlSXY0sEqrh5f/nTqA31x8tYb0pjdXyrGWcAkhgwjD58zrKslL2f96/XELuv?=
 =?us-ascii?Q?7qPLodc82eK9R9Ztf8hbUrVkHlUMS8PBr70H6GK/EjPWXQvKEiM0cUZaGBkW?=
 =?us-ascii?Q?Q5sSU3hyLGIWL3iZmMwSdcLV4wXzChq1vA19HK/l53V82aEKOGhkL6KpSYrU?=
 =?us-ascii?Q?lIJe8JPDZKT4eJKSrJWHm7jbMozfuhLvIzzwxGcUrbbB/E9Q69Btabi+HSWC?=
 =?us-ascii?Q?MkcD8rgx4Y2F7o6DFD5opc1Vo8dgmD0V6BoSX6da?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1cd8e1-2d2e-4510-0125-08db5c140d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:02:19.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAgyq/okEWAJ373CrNNzq/heCCTN7ivbksHqVpY4qmcGjZ4o3JYSLCxgkWBmYqMchQ92iMw2KE6jFRTVqI11sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
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
> Sent: Saturday, May 20, 2023 2:45 AM
>=20
> On Fri, May 19, 2023 at 08:47:45AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, May 11, 2023 10:39 PM
> > > @@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
> > >   *           after use. Return the data buffer if success, or ERR_PT=
R on
> > >   *           failure.
> > >   * @domain_alloc: allocate iommu domain
> > > + * @domain_alloc_user: allocate user iommu domain
> > > + * @domain_alloc_user_data_len: return the required length of the us=
er
> > > data
> > > + *                              to allocate a specific type user iom=
mu domain.
> > > + *                              @hwpt_type is defined as enum iommu_=
hwpt_type
> > > + *                              in include/uapi/linux/iommufd.h. The=
 returned
> > > + *                              length is the corresponding sizeof d=
river data
> > > + *                              structures in include/uapi/linux/iom=
mufd.h.
> > > + *                              -EOPNOTSUPP would be returned if the=
 input
> > > + *                              @hwpt_type is not supported by the d=
river.
> >
> > Can this be merged with earlier @hw_info callback? That will already
> > report a list of supported hwpt types. is there a problem to further
> > describe the data length for each type in that interface?
>=20
> Yi and I had a last minute talk before he sent this version
> actually... This version of hw_info no longer reports a list
> of supported hwpt types. We previously did that in a bitmap,
> but we found that a bitmap will not be sufficient eventually
> if there are more than 64 hwpt_types.
>=20
> And this domain_alloc_user_data_len might not be necessary,
> because in this version the IOMMUFD core doesn't really care
> about the actual data_len since it copies the data into the
> ucmd_buffer, i.e. we would probably only need a bool op like
> "hwpt_type_is_supported".
>=20

Or just pass to the @domain_alloc_user ops which should fail
if the type is not supported?
