Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DA07D639F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjJYHkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjJYHkL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 03:40:11 -0400
X-Greylist: delayed 112 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 00:39:30 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46837326F;
        Wed, 25 Oct 2023 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219571; x=1729755571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ivp/FOguYwEEq2B/Rp4D0Vhac2t3g/9rKxXED4N2qc=;
  b=RxUmB0/2qV4HF4zss7mSoqkp3NYRwrGNHED889aaTBq9CFAEjkUeIt+O
   TTULl7f4paCgaXnoWcTSGA72JyQhTOoLoJ4xBU/GIPnhU0BUGdqmMz5A1
   MGI380bgLIDc7RcnQrUGjPdiNQ5X699iKoG+d2ITVbGi+ooWvgk7b/YhQ
   jppkehOMs/nLasswrbOy6ccdWH5/UhHH7zk54Ibdf5djIaEZcgwF9uVIa
   ReqcMJOPHCTrNvp8+nZJREij85cvW1j2UBBOpNwRSJxeX3mxHAliw+ZNB
   SJI1u7O8CdvBoFuc2T73ZYXV34Ig2c8WKvW6MCWZ9D8uoyOEJefLgpago
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="19015"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="19015"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758787437"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="758787437"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:37:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:37:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 00:37:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTZQ6B98uBCcxm22We7kXS1Rh42Ik2N4iuPIHMauHZ+059TRgBg6sMYcagBZU75Xd3+5MypPTxYZPcZtkkzaDTPaC4CxxSAhvzQNdlfD9lU7mMz5uPsIBPBhk6k8V9ipMZfq9b1uZcd7lwDkatKZhxycz77Z4ch6jE/XjE0M4v8tnNrYWVnGpXWGKgf0CLLU0O4m6mzxX9fVKF/CVsmxzndq9HaGPvYFdOVUz154lbWRILKgFdTwV0fRL5F2fYDRE+BYeMYmNrZ1N3amNQFZXzSblupHexq/6lc6t1MfQFCLpFGvDDd0slcKLPIF5aSvoRtuibPHqb22W0qS+x+6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ivp/FOguYwEEq2B/Rp4D0Vhac2t3g/9rKxXED4N2qc=;
 b=ZuQZxRnHz3Rm3x/D2z8/a6wqSv54Cu+TfX3DC2qGvrl3+Wk1Ky0STthX5Id8DCfcllBRynOdW6+YXZsvyZtxAJj/YPHic2MHMxXldlNgOIk8v1P6mlyNEdq9x3CCrhq4tVNqC15u8UcIlHhaV2ls5m6Y/pxufPmuAO6HQ5b+ZnQCgeIVUv+/GZSjSLs3jxpw30cL27EsoaO8IdbrILW/txfa/1ybswrDqhs8KgDuBYffASDX3LbAs56Jg0cm/KLqHEbXv2qgf4eP98xunFNaO8eqHB18bf8pBSiNDbXFv5ak4CbgPE+YWywcn+HeJcx7uywOs9S8hdo9zhVbhWgzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:37:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:37:25 +0000
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
Subject: RE: [PATCH] iommu/vt-d: Enhance capability check for nested parent
 domain allocation
Thread-Topic: [PATCH] iommu/vt-d: Enhance capability check for nested parent
 domain allocation
Thread-Index: AQHaBorb53ixZf3YA0SmpGP4jnQvU7BaHwOQ
Date:   Wed, 25 Oct 2023 07:37:24 +0000
Message-ID: <BN9PR11MB527610737C0F1D6C92A55FFE8CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024150011.44642-1-yi.l.liu@intel.com>
In-Reply-To: <20231024150011.44642-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: 1f52765d-294e-4f56-3b7f-08dbd52d3b6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvC551GvujgdykzK9uwVe5Nbmr6YWbhkgUX9auF5R461/bSSdjX4Jyz7UYcAwDEhw+oAOV+MXQV+VZZDvZBwlq5G/9buNDChMBHACDPKAR/nBkBQ5QrS8uH9uaq6UPaoobgNz7/Fo2iRRpwDoUG/0Gxdj65OcLs3WuTipOo35rovJtr2JGz3Z7olZTifnx16rW8sFVoQSgbrxKYld/1+7Ufmafhmo5z7cNHC28jFd90aqHgLZNnWCPYScx3VQEHlQWOVpmA4ihAqAugR77FctG5B/Yaywo5GlVL8aifg0bQ97EyLOMmLIWWusQckH2KAGRtPbdS9o8QbcSx4OHy03nyTQJ2F0u02G9LvFYgHHxWWAEoaCLsrYFWYn1ns1OxiOiEahpihOp5HSq+M+rN/LTJvrwazRfurlVQzIxzAtu3U62uk+8O8o2Nagz5j4sLReWXa+2IPopXZ4s3p8J5sQAxO6HC/xVbs/3XCdw1884M0jXIMzurT2ZH9CrnswVlN5pkp9ucHOHtDEJh8LiIwuIugjpi6yxwdcVnyAP6GqRTwRV2IITZGpqf51w9Dh35SI6RMqa1Edif215NUKRBJTjiA8k8MxC9Xs/PwWPLeEq07pwQ700xm52jSc+mLoZly
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(76116006)(86362001)(6506007)(316002)(7696005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700009)(33656002)(52536014)(2906002)(4744005)(8676002)(122000001)(71200400001)(7416002)(4326008)(8936002)(82960400001)(5660300002)(41300700001)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Guz/1qPVd7iVAstK0iky6U6g/eW8tFgmF6LhNRc+GhoXuuDr0PnmzAxCi5T2?=
 =?us-ascii?Q?UOh5STHAPVVSPvj2MshQJDcFDGL0wpu9tST/lQBQw9qIkOcuIf/wj/Vab3V4?=
 =?us-ascii?Q?AEDxfF60YINoBg3XC/sQhwXVmtd9QPfy6KnAg2JlkS/R+365Vg07ee3Wf04M?=
 =?us-ascii?Q?kgI9RXNBgnJoyx8B/REdoHgdruiA7meTgcb7q95zkufNbY3tfRW/6sU5vh5f?=
 =?us-ascii?Q?cVPyuA9Uxu88CVMYAVfQqLyqRq081H99neTjU51F0ewt9RsXxoTz9YSoyR2O?=
 =?us-ascii?Q?rwL9ROyYi/VIzKHErrAU6U/GeAV2R2sqeoVeYLJDOnMjEVXA6bxCPkp1cTOy?=
 =?us-ascii?Q?9v1mnN7V8HGS04lLOSkf5bHAtBZ0UjzyprankG9gvcf/IPlPMfR0XIr5sDDO?=
 =?us-ascii?Q?Y1MajdZsyWwlDiivHCnd/cFmavBmx1B8n8GCq5hyt7+KJXj5vyw065WmrSyf?=
 =?us-ascii?Q?EfzS3INHZuQPesc1J2JKLFm1ngrLVPFd1VEh+irpIax+2BMHqwgTcIOX8kAO?=
 =?us-ascii?Q?ZJuhjU6FXmSF4f0XeXIj3KMVQbjr4ow45/elYUtTOihpb8sYvR1DoPKUmeSb?=
 =?us-ascii?Q?jqAE+T3SVvKAvYDELhibbEHPWRHmEPE+VutiLyopJx5N+JDqcrFM2lZxB7BF?=
 =?us-ascii?Q?s8OjSqDF8iAyU2sYJdcxk6Na+tdJ5aeFs3uIEdtSsdDY6I680HtZ8F9e8Tjn?=
 =?us-ascii?Q?m4mY7lF4G88HiuBbN1aZvDq/ysO+gAcUN29sY8Of0eFDdjYWlhojvSBKfQMc?=
 =?us-ascii?Q?mYmyxU6iwOmmpa52NTy/ku0P9vqeW37oy0H1Ot9lksLtFX3swadBN00syrfg?=
 =?us-ascii?Q?YqAlem7rYAYq65AKsbD8pJYA2+RYA1N+613JJMzWNto0/fJ6RO8cNuTB2KgE?=
 =?us-ascii?Q?5RBo/FQMC32xpYoSdyyzowSC255ivY1KtsayQqnQu7y/d5KRHXwEqSDFYEWN?=
 =?us-ascii?Q?iAzNEhm78KY6PzJ1/FHXxWPkFXKkD4D/R25GwLWpf9eUOFMwXDZ86wrXFHKK?=
 =?us-ascii?Q?A6zuJVULZCdqDUueUcTSNBmtAWG5uWpYvoISJbikKD+tV+/izxMxtlMS1x/I?=
 =?us-ascii?Q?/fC7+EslStqmFMqCzMpcR21hvYuV5ecYVjWrPC+xmGx4MMg/l/9gDU5jL8tm?=
 =?us-ascii?Q?li3mjJlj1J9hYz6X8Kz5kbpsllt1lQHiaoTYemKjA81JaVC2uXSO21aIJWxx?=
 =?us-ascii?Q?pCVd+zSvjMbsx1FYLi03d9r3JuUKnkcj52bBpKr+E2ABrKsL0E//VPsNeF7W?=
 =?us-ascii?Q?jGLtoqOTPKSk9V7t3OhiXcBSmnrXldRv0joWNnKyqkg0Ym7DJ7IL95uL+W4E?=
 =?us-ascii?Q?O23ZAHWwZ5h1WZIyoTgKfA+Yqv25ZYQPgsm3Vj8yx9wyAcJOxGQbEfdmEuqh?=
 =?us-ascii?Q?/iY0Nzc2oVfyruCV1wNjx9iFrPPzjxeqMUg0Q40TqPTCpYMP8NXU4rXBCJi9?=
 =?us-ascii?Q?9JGtNXI66TZek7rcBb/+l8J+m9ilSFWBsBuLTqocbLi3nETGhFsxryB6dcnf?=
 =?us-ascii?Q?/9KtPBylsj22Es1v+AarR67BSah6zfnJkYCevaS5BiBFYuX7r6PDS0DfI/t5?=
 =?us-ascii?Q?GP99OK+KcvBjLugddflvKKbkVhjh9yVpn1bbNdTL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f52765d-294e-4f56-3b7f-08dbd52d3b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:37:24.9940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTEq87QHAqd7Jpds8ysv4+oCBaM3oEh4x7N3Lg941UPXIsgOPkuieLF3XaUPquex6/QReH/A1Q5J8KW8xqecOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
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
> Sent: Tuesday, October 24, 2023 11:00 PM
>=20
> This adds the scalable mode check before allocating the nested parent
> domain
> as checking nested capability is not enough. User may turn off scalable m=
ode
> which also means no nested support even if the hardware supports it.
>=20
> Fixes: c97d1b20d383 ("iommu/vt-d: Add domain_alloc_user op")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
