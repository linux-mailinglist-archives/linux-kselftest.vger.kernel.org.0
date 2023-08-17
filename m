Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53FE77F123
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 09:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbjHQHY5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHQHY4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 03:24:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BE1BE6;
        Thu, 17 Aug 2023 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692257094; x=1723793094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sVJ418+173oPWqdKtWXbnLNO701Ba5UoqTYk1cJzynM=;
  b=PML0kxKz+OArdAfsmDxJDawLCuAxoGqsuzqsVF889QVjB2wQhTOa4X8P
   y6h6o+SFb1eA7v8pGUpbcCdRhhd1/0rkZBG/W5XaZ16etypnyGU4gzopE
   2LArAX5OxBhn3u6HpVkrEPCAOt/cxqas2PjnRKeI7+E/HifV5/Px3dReF
   2G360OiDHAFy/eGzYtfikQSNQbA/iDbdpeVSUityY/s51Fu8ynidDWROU
   /ksT1xQ3xLctQrQevrtBrlaq3yTwtoCbonOlWxHsRzTym9PCBgEmr1riY
   5U4OBSUf2OJH6dC8hnxKrmZQ4D35y2tdo5DPyVShsL+9aw+BE+rkWFt5M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439090756"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="439090756"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804531451"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="804531451"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 00:24:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:24:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:24:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 00:24:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 00:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDVykSg87FA1+T0j9NiZ6RK6PDfEOH92ZN1brG7lZmEXbNsbkyM3CMRI6904ByS0ArUtmAssOnvbJD7O7eEFEynZfINJLr7i0LWuWq96LHjJp6J4zCr4HcEMvkGjphkicoWicKTGOvFxC37jmdrff9sVk4h8jqalZADxn94QQKtZtPACmCgqz4gqYyAvb8GOWSdk4JcKL2xraD/vnp+bMFC6TKr3E2i1mm4hMSoXUXh6bVijcg3s+GI4T/Hcta34NaQkF3DtDT0QD5SeOVErvvGkzKx2nSOiRqoLfvYZSLo4Kpn1c5GNdznlFea/RCVDYRb5hGwkl4nlc02A+dZuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2duEz0SJzDspVIWAdoLRTmYId2FwmR1tAc92d8rMCY=;
 b=ie9jYy2r4kMrrqS35pOKOTOMF0uysQKnHzePrTA/llRWMBWzAO8CgDV2k1PLQFoCpD78SzUPx9FHfIysJv1KQ2L0VTHcjkxA2C8po4GFT0WO2kOpQDRLOhVeo/09aK+j1lJPKI6GxNNfn9I1CyudMCvCtCZclYVfQEwZldXtVlndXWgD3mrSjVx72xpyB8k40PoxVqo+/YmncXBP3YitnHfJ5AP86hWQ5Q6vACGkcK/0QmyHzAIj1sJ3rZehU822E27vQ4OxJm95biQNRHHe4PgX8yINNyM5r8pSi2VLQG/6Wdu/CsO6qGFSEQn2yXzlyMy2Mq3AxU3x86ErhsV/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 07:24:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 07:24:44 +0000
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
Subject: RE: [PATCH v8 2/5] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH v8 2/5] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZ0DstfL3bha9We0yor2Cm+Z3Qqq/uEyoA
Date:   Thu, 17 Aug 2023 07:24:44 +0000
Message-ID: <BN9PR11MB52761250777AECADCF77D88F8C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-3-yi.l.liu@intel.com>
In-Reply-To: <20230816121349.104436-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8210:EE_
x-ms-office365-filtering-correlation-id: 54714b0f-9e09-4732-8ecb-08db9ef30781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PS0Q4zjmybxPbaB8QedfJ3SnHyTym/blG16CUk30CAXjL3ncUj6E6ay0gPLQEHh+pmv0uM9mHlEFF1Q7z66veYCiPD4E24q7RJcG5m4iL7WLuOzMb3KUo/zwXKY5jRiLGxqCdsy7dwiv1yqivsuAYyfKr0qp6H7jqL/+9xKNnD6hez2snDGrRBvB3zVHJ+HV/eyxE+0lhTkcPHRDiZ7apx1w4EMEttJpAQ6zPlZ6Xle8D8T6kOCAJzQ5OJOCdufH/B/b+gkIHHt4o0xnjLlnqv5HjT4oy4xqbLaiyMycXugvxSDiPc75vL/f8NgO/3E8D49xTTdb8hG7JKE6vEMHouuCIES8eITbp0NB5zGznM5u2ynHx2bsU1YTXf6ZHkfE5VA8p8ORiwM+kft0ohJeNqTGFQ2gPNDw3Bz7XCjtXDSo/WDhHcDZzo39/aH2lR0VEPJYBIEXfZhJ/x6Lwlsfnq6f1D9WA5fUj2cxnpReimf7RY/OpbzOl9td/mrvkbWu6TGiyWfoLMFQRV6gDluSpja4xVpnEC7idqDC/nKiSCezBBHBQiScKGGwRJQgLmS0umgfIMpLxdihYK2OAv7NDU9r7TlcBAgNO60GMQBOXqfldB2d09wMf2vAhxYaGDmc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(26005)(7416002)(86362001)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(54906003)(316002)(66476007)(66556008)(66946007)(76116006)(64756008)(110136005)(4326008)(8676002)(8936002)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/SO/2siH+xm/TB+naCP/YUk5yEQaZM/RSHNfn4/Bxd+k93GSl9RZVHeIz4zx?=
 =?us-ascii?Q?0u1z+XYZEXCllZa3ysdWkY8THF1XFxYyepwVarAzHLvhRWNz4Hlu9RSWSvxx?=
 =?us-ascii?Q?JeKcKIbrq5K6LS59tNeJecyhuuwvmeg3k+D060oUWGxJWeh0vJbz/GjhN6YD?=
 =?us-ascii?Q?sbYhiLVnMwXgiqPlW+sBdmR5Ok7z5PXhhQhG+3EHeTPWSBYCGayjWOt7+pFc?=
 =?us-ascii?Q?GJiTihCC8BQ5DwuK5I9HDeG7eYQHpQJ3OGhnVmCsm67/obkQTSFKt+sKHLnf?=
 =?us-ascii?Q?JX2cKlVh7yqffupW2QxpZ6kO+IwtVniOX3F59O6o6LGTCXOkt7WC9h1datHx?=
 =?us-ascii?Q?I+YJzFmda5je5iMe5SwXZUqxM7M3O6ob1nF7DB1cgS9UCBP4icOXqEQKaZIf?=
 =?us-ascii?Q?XmWo8RPNiMnNPGEZZxAliBlRiE1tw46dCmVMUHoMwfy5+PdEktYo24F0T+fy?=
 =?us-ascii?Q?MoFngU+AS1rEobAQ9A79YIjCDfZvY729IJGKxvGVoamVFCz1IRkHDUDMtCU1?=
 =?us-ascii?Q?PpgQ6J5t/zszwtol9p5tGn+fVhzLQ4ppAjEC7/r8KcBCS146AAMggyEY3i6P?=
 =?us-ascii?Q?bvK62rOts441kg4/WaPJIqjFVRk+5p0fmhUao82W/fFm4qj0Smtiy9s0AV1c?=
 =?us-ascii?Q?M7u27nddlS5v6T/yEsGsYPKZSXRlPS0MNqLakIPQe3rfB+utj9RjhTn1PufV?=
 =?us-ascii?Q?kl9pUMuGtIP6ecECllrXsbDn9lcUqudw24BBjK4iSDs6rcaxAmKyllp0F8mv?=
 =?us-ascii?Q?IaSNPzxBbqk05nftzEe3cfXxI24wqiyWEYhW9QiIM/QnkJvu0fXFVX3u8pW/?=
 =?us-ascii?Q?OgyP+UJFjuODM4GahjKJqvl/046IOKZwPuv9L6PGIjbp0TTR0ngbhzuY03V+?=
 =?us-ascii?Q?lZNynRHdVU8nn75S3UiB1Yym6GuhcGoZuLgiyhrWLfiG+g8f6RoyV5afSBEL?=
 =?us-ascii?Q?alnWGMWJyyMDfJVQVv2GoVs3FJi4Cwj0CdNEcfAICwKTnM9szxmgiVvJzwyl?=
 =?us-ascii?Q?G9AV0FShmVBqWHDYOhje3ajxEPXK/fQbh1aIGctxltce6TuuC0M51Cr1E2Q/?=
 =?us-ascii?Q?lZG7LACSYASXDZJ81AwsgYqxBlq5VULaAwKLx8YhSG7vtNd7S9hwUGJEtjnY?=
 =?us-ascii?Q?22l3hFbRLDeeYpbu36X0K8uzzqT9xXhJAHr7dIynylvpcNxH82mTQxq8PNHC?=
 =?us-ascii?Q?Vb93F2sUzCTa1O/4vKC1d8P/ZwCu/AVKLJDNDpDDqeN7I7j4IxI2g8spVkm0?=
 =?us-ascii?Q?OdbPaW+m5G14KKHvYzjItBiluxRua3ejR0Cgo/TTN5lN2n9R/KBBylpRn0qb?=
 =?us-ascii?Q?8Jk/bwKicrTQfTboejdm+M9vKNjTOSiINlw8LvhMR6AtRMHTgRssNBvdaztF?=
 =?us-ascii?Q?8jNEVzT9+gDjdJ2FKM0+aFGRfaZbQdVajcoa9+iDzYwjZc9i1YHnPGFFJYeZ?=
 =?us-ascii?Q?PiZ+xGEfNy8rMNZfBXA1P6oSuLuxnNo7wHmA34vFnFCq5bbGpxdiafULmd/1?=
 =?us-ascii?Q?sbsWrQdyEF+LYSRGuIraj0IQLX1d/O9CJDWH0BjP713q3NvwOkioVH+Z6ek7?=
 =?us-ascii?Q?tNmKY3xzUDjSzh4G8f6I0b9UitTDNeCps5hQYyjZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54714b0f-9e09-4732-8ecb-08db9ef30781
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:24:44.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joKyxGxsi+bSf6eLs3CrCgLc5LZBEIqNbty9a2Ph0icnAwjOWceP5SIGMgyWuYv3AtBmb61z3rYpgekAFG3M0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
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
> Different IOMMU hardware would have different hardware information. So
> the
> information reported differs as well. To let the external user understand
> the difference. enum iommu_hw_info_type is defined. For the iommu

s/difference. enum/difference, enum/

> + * @hw_info: IOMMU hardware information. The type of the returned data
> is
> + *           marked by the output type of this op. Type is one of
> + *           enum iommu_hw_info_type defined in
> include/uapi/linux/iommufd.h.
> + *           The drivers that support this op should define a unique typ=
e
> + *           in include/uapi/linux/iommufd.h. The data buffer returned b=
y this
> + *           op is allocated in the IOMMU driver and the caller should f=
ree it
> + *           after use. Return the data buffer if success, or ERR_PTR on
> + *           failure.

simplified as:

 @hw_info: report iommu hardware information. The data buffer returned by
           this op is allocated in the iommu driver and freed by the caller
           after use. The information type is one of enum iommu_hw_info_typ=
e
           defined in include/uapi/linux/iommufd.h.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
