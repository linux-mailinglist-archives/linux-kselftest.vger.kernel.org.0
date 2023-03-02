Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149A6A7C56
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCBIQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBIQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:16:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1132502;
        Thu,  2 Mar 2023 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744994; x=1709280994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TvhBKhkgpn1EEX2MWhpTv2mRBsNlu6tdmFhjAKZuRQU=;
  b=gf6/Bb4fH84LE8NOHt1ZqTCkfHFdRaGsv8slhTopDSTy4NzwA3iDQmIb
   sABfhwPpTDXSni/PhJys4ttjAWkKbbyyoXF2IGM4pvj8RuzDbNziS7gMu
   bsZLA+0M03+9aOYOVq3S3pQsRFG6zyrA+NMqsbD3ArI4MY3kYLAYa2knL
   HXhg7A1ALS0kExgyawpwdSbuWfzKgbF+LdB/4MZD2n3o5kcbnTcwB7P/A
   0FZSXq2Sk+sFaErbydEBSfdreugnVIwR3mxYXKd54CI0RiSCiECAnHP/T
   Lr5cnisiQEw8AI/oL45lM6etYJ2g97Uqow/SvZmG72+Unf8h9R5lIBH2B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362243311"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="362243311"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817906103"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="817906103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2023 00:16:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:16:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:16:33 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMFXQhJ8LCcZo4ah0D/lgS433i5HEC5XxeVs4YITHSBEqs/YP4XSw+i0qB77KtxOvmS/VTB9R1/BlS9465n7XrHOLHX6nt6QNsprkNtQ8ZdQ/ZmwHjE6YTCdGeBNiMeGXtccZ3mNqL1v1CWoWgtcz+yv0imtZNoW4UQk4n6dPwV3sxcN1iOlHZrRaf6HXkDWtcU3atrLPMor7VLIKEcBojg+ghEmU/aNs6BkKIHP7t/WpIbb7oPdu+LSkK0G25D3r9tNq/rCIYNFZP8GSufOtHifBEl0Xcg4KyNQHkNjQixVuWjXbE2/eKlpKj3U1WhB5joYEBZ6qcx7+aoPDLu+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvhBKhkgpn1EEX2MWhpTv2mRBsNlu6tdmFhjAKZuRQU=;
 b=kx0hBkkBc1yrwn054c66QpKghAwpQ4H7n52hwigymS13scDZa3x+5XFKMECRQKX5p27AgeIs4394DN1SVbUhM14j5KFprmTj6m5PJPysjZiLuINGwC6/2fUqMFJLmey6DVnrjVkptSMVaaxQ3Fbf1wTUTyfDEDVCZ0HHar8PijeR0Md2Odn0PMbCzSQzN+eTW5D3R9bbCvUAlT5HchOAHFlZxrlYHtiuHSYQt0AA4wr18DaT0Vre2K5Rd3DAK2+EwFZuFSMFrd+ZGkotLDZI9V6HJJ5pm2kMj9e0/2MC1oM3aQUzv81psMB6g+1g9tr82qwJYv0ZOWuevkxcCQGm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:16:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:16:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 08/14] iommu: Introduce a new iommu_group_replace_domain()
 API
Thread-Topic: [PATCH 08/14] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZSLAPVvqXKAKNoUODY7XvdUF5LK7nLRXw
Date:   Thu, 2 Mar 2023 08:16:25 +0000
Message-ID: <BN9PR11MB5276C2ED14E2846EE65EDA678CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <8-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <8-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6208:EE_
x-ms-office365-filtering-correlation-id: 7dbc683f-1fc6-48f2-c48a-08db1af66a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXmXbXvQdL7RwoiTbIYOf9lKVlc6R4vff4lWZ1QD3TlSFsYGxXhJe6yYljjXBEHsJ7A+1Mua/Tn/LQ8V3vzWVAkbNzhiZ4+Qdy1wB+tu49pURqVMiDVO8C/H8FsQ8/R+MSl4s2MO8C9Rh9gu+0H8AYKa7o+q21wW+ogjLrph8JPSecoXr5bZxZtb1TUBrGC0LkyOd3C30CMrjR/I0Nr4Yl8A68vvuyzEZ+GZZX7XEEu6kV9wjiLmbr68yueTXuvDNwvxJtyNxKmpiurTCHxbuU4o3Za22zdKOOM+P8rISZE3fSRz6FcFyVnA2SQkX1lg1cnRx3Uj3VFQ6oA8Sxv8HEurnfCDhsP/nKbGmXGCz3vtMAOyCtQHI51qaT7AUsFX9TYiLyRn7BdfGEmw04qoNKo2B2wwrhsPf9jcRcQXvyEIAIh/arANJr/Hkx3r5+24xPrCr18vH7LXC+C8+SLZMLkGWguL8LaH2GDItwswyPxOZCD04QHImjEsWbzxVBFEgPcSYSBEfB4DkhJ4DR1GCLtPans1OVNd+ifDJBOj5FhG7X8XsyzgPR7AEsUlz8OIy/n7PLk9N8SvIKCD0qJnLEjyZhmfD0Xa+0+nRLXBOd24AlE+7KI8ebhLogWWHCyEb/uYxpCo6ltptaZVmVvXIawphYaXl5fhSYWi3i347tiNaSeYlN+dRPNTw66BSJaILbsUE+VDZWohjY97RY8Uzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(86362001)(41300700001)(64756008)(55016003)(66446008)(66556008)(8936002)(52536014)(4326008)(5660300002)(66476007)(66946007)(2906002)(82960400001)(38070700005)(8676002)(122000001)(38100700002)(7696005)(71200400001)(107886003)(54906003)(478600001)(316002)(33656002)(76116006)(110136005)(83380400001)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cce1raFyTs8rknhli0LWAXroAVoNJ9fDHoqWdKi/e8bbs4OHUsYAG16cpdjt?=
 =?us-ascii?Q?VWmosMRgdAf0Vz8yN7uqRjAmoaIKVkzLXzF2BV9QlPx5jmDuUjaWD8DEdS+u?=
 =?us-ascii?Q?PtjF/n9O2BiMX2MRsdaEgth6QB6a08YN/xyBzHejABawH2YYVCmyK3I5ov4/?=
 =?us-ascii?Q?NYWrDwcwX5L84IVlLS/aoxfboUjHOFH8R7MAsCrAe9RbJwttm0KtUOn9B4Et?=
 =?us-ascii?Q?8OpmhyK27TRo4/3EshEMjpnbrpGA8bYW228ifDpR+1GZ0/oUXSGDey8/iHaA?=
 =?us-ascii?Q?Xros2vydznjd6fXjHsK6K4ax6ZV9HxBHPGLT03nXSosrIuao/ygEFr/zSLAh?=
 =?us-ascii?Q?8noFDu4oD9JIKvliwa77YugRFmtTh6lajr6ZDpsLV1ls7Jj1zgq8uIxbcII+?=
 =?us-ascii?Q?NEs7+hsICBbPtMYqKUl0iI7UaHEGWzz2iO/hnTqssP9vqlo1G0BuOME5FFAp?=
 =?us-ascii?Q?Q+OlfGwdWy17rc3numzW+r2XHLR4Wd0XIHhU+32ZdDYod5ytoNh0h+BzgUBo?=
 =?us-ascii?Q?U9x0NuXzyj11B8QAFWEoSRDPCuTkkLel/Z0s6jeNbZobbwUwShL9H2Ri4/fD?=
 =?us-ascii?Q?52g18d/qCy33gaEE6vzFPRi7d2QjX79aifAS6uomYt8nVviynqy7FE797+ku?=
 =?us-ascii?Q?B/enaWf0VCNtG/CDzpeG/D0RUEiKQQQ6+hSgVI/MxonTxdftNF2ZshasKxde?=
 =?us-ascii?Q?VfbK7H1yT4Q8u7otgQYbJU6NLOoSGDwowQdSmV2O19Jr86hKPeROIbTC8NcN?=
 =?us-ascii?Q?l07ZkAtQqB6XcFUEuJhYa6h6yG3/7ZWaiHh4UPax/cbmUtd5DXjKHlLjldsq?=
 =?us-ascii?Q?AP7C/7inzo6WMwEIVwM9c9UngDVqYh3X+kSj9dZRQVCBsS5kToah11zT0R6R?=
 =?us-ascii?Q?7XJvQc297gmaqvUzE6a/YvGcxtwhODy2cn0ZdgMKTAD2fkoMWN0RM9dQ0AgG?=
 =?us-ascii?Q?JAbT53rWyrCYDsZPv/ERRSOTTVQOA4ynUsscPqfy2Plr4M85kM+jjyAP8LDN?=
 =?us-ascii?Q?LbJIt6L1TvBFyWdb1DD/Plxa+vTvK0ce+g++RL4iYbBl1UtR3T9994zP6ztr?=
 =?us-ascii?Q?7sTe63V5RxIZhJhEG4uza5DnCs3vg0wqscr0zEtfaPS0QgKyXXJCXz/dSBT9?=
 =?us-ascii?Q?gJJ/OpyYuP05ewFZuxxEDFUn0eNjpW4lGGL0j/HSTgUrBM7KjZOFFq1JdMSW?=
 =?us-ascii?Q?LTVGxuD1U3G9hdAwj3qvD1TxGm5KOFYoBDZd2/Gt0cyfsbURGSeEALTENiSJ?=
 =?us-ascii?Q?buk9bkoe/Sl+RHL4lf/m5zbx8o+qc4Nv6YPmm5DTqA8D7W3Pt8Muzxnfnaib?=
 =?us-ascii?Q?wkhAMsgMSwBnQYnBAheW2RpX55G2oTEPMSNiGuEF1yslplxF0pOYvmuJwnnO?=
 =?us-ascii?Q?HRbTgWAFXtFIR+Gi22q7njwFr0LoUK55qeycOAqNCfUPeisPdhYJWF8t1tJN?=
 =?us-ascii?Q?8Gy6kvnSe6XDx859RtEQgV0h7hvF1iHUNMgbDIdJ+Lcz1rYD71ZbqVlSzWdD?=
 =?us-ascii?Q?fbQxqVCGnnwqxIfh2+niFB0Av9/uNIzJpFBLl2qBLJVOHgwxIA20kzpXiLO/?=
 =?us-ascii?Q?ypKEzNiWyr7Scr96/TIzWR047w8rApyie1vUYI3B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc683f-1fc6-48f2-c48a-08db1af66a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:16:25.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEgrpQ79BNkmjqFi6ikkPtkchSWGJ86w/5cjz2wo+zlB95KGBUinomc9AauTIBCKvmGufywS5jmqJZoPv/eUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> qemu has a need to replace the translations associated with a domain
> when the guest does large-scale operations like switching between an
> IDENTITY domain and, say, dma-iommu.c.
>=20
> Currently, it does this by replacing all the mappings in a single
> domain, but this is very inefficient and means that domains have to be
> per-device rather than per-translation.
>=20
> Provide a high-level API to allow replacements of one domain with
> another. This is similar to a detach/attach cycle except it doesn't
> force the group to go to the blocking domain in-between.
>=20
> By removing this forced blocking domain the iommu driver has the
> opportunity to implement a non-disruptive replacement of the domain to th=
e
> greatest extent its hardware allows. This allows the qemu emulation of th=
e
> vIOMMU to be more complete, as real hardware often has a non-distruptive
> replacement capability.
>=20
> It could be possible to adderss this by simply removing the protection
> from the iommu_attach_group(), but it is not so clear if that is safe for
> the few users. Thus, add a new API to serve this new purpose.
>=20
> All drivers are already required to support changing between active
> UNMANAGED domains when using their attach_dev ops.
>=20
> This API is expected to be used only by IOMMUFD, so add to the iommu-priv
> header and mark it as IOMMUFD_INTERNAL.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
