Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E37D7C25
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJZFYd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 01:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 01:24:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2537DE;
        Wed, 25 Oct 2023 22:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698297870; x=1729833870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3CPW33dw8E+rfnatzv4xjyTx4hZY4gtXXGIe4Ric7G0=;
  b=Nf9IJxjmt8VxRV6i2T9BB7Tw6Xy/5Ruua3UdY5Uv8rLmY5KV9MEH7VAL
   7GpsKMolnvjCjK/0hFKyOgIyKmKpM98dtl2p86+FvB1f6xpSys7cOZJ52
   w14VmaNSdfdH0nFyJOvZKU8qIQ0FTaRdFxdhYcVt0mEHPY6NUUgu6iH1k
   RvPDEYZ8/BjLISQxo6KloMlKcm6bI7txLdbn3mxRYiAvo3mw36z2RQWfZ
   yHDS8vq+l+EQbDZLpC3Nc4JqtGWaZolX+LsK+OvaTurnJwoIjZ9pILWFm
   i/BMs0In4sUIVhGJsgndlDAa2h5CJVjEsdTA+1lr4e6/72CKJgM28+s9J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384668497"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384668497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 22:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882699609"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="882699609"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 22:24:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 22:24:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 22:24:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 22:24:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 22:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbG+33vRr5/mGyAZ9W6p1KYJtmKGFmEImYdLB/uMgJyqfSoSTg9QTgGf9gLrUpvC/ci0VebTqWVgotXZRhsR3uujSyIghR8c2DzJe8PDDUheqNh+oi/y8a2+E9sFFzs/BeShKDF1rm1PcIyBULEd6Qmnc/xVXmNG1DzoHZy0Y9bI2fhy8pmCQ6ad2c8JuPx7PObpWPAnTWf7XZLXcuuTmWgIvL1CnY4ydbCh1lN9re7kXkzdJ1q05CaPGYnDZJi6xziSpwEPzfVCCZDEl3vn/cNQvv4DmJJJFjJWXe6rwPFnETjayX6k3t6cGboD+pgx00k3dmqIqW5/fxPTKr+Wsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CPW33dw8E+rfnatzv4xjyTx4hZY4gtXXGIe4Ric7G0=;
 b=MyTzk0UHv3O2Rt4BsHZEqmNGAOJNkpmDePETw2cA5N9AiO5GKoiEklOUwhaJpOuoZV5S2GwHke/MYpCgjaEfiOFLOeg00LmsLtVogCId1rPyg2jLYZaEy/ZOyMNQk/DadOSjaD8b7380m1TmjEK2OQG7pc4xQwWCSGq6DMz+c3v2RA+0ScK0y5n7bZYhDV6+SJigCXvOE/XeJo2ztQWsOus6plRb0oajq0mVq/g0visb+Y78BuNM1Rsi6MzUX7tLyCddNzifVQ4k2Xb6bX808Lhef2bajrH6yRaWRvSxxfjTtWv4EMoQpZsnh56dCl0ez+DmT615QG1Qq4SLz0yI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 05:24:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 05:24:26 +0000
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "Zeng, Xin" <xin.zeng@intel.com>
Subject: RE: [PATCH v8 7/8] iommu/vt-d: Add nested domain allocation
Thread-Topic: [PATCH v8 7/8] iommu/vt-d: Add nested domain allocation
Thread-Index: AQHaB8baDukoOEgD/ESJ34Xy2HVN37BbiZeg
Date:   Thu, 26 Oct 2023 05:24:24 +0000
Message-ID: <BN9PR11MB5276DB4C494507CA5271975D8CDDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
 <20231026044216.64964-8-yi.l.liu@intel.com>
In-Reply-To: <20231026044216.64964-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8208:EE_
x-ms-office365-filtering-correlation-id: 458b7a50-d3fe-4c9b-2edc-08dbd5e3d14b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH829fGT2PVfkCCdKPqYel+chfYopUvyVJO2Ct+aoESRECez5UqeZBfWLENRVozHPticKZxI0Ih+yl3UsIzkb7Yfpm8SQu4/UNWTBx6pn7mAWlgj0qhZr4OUQRyn1yavZAGwqiSlb5nhgA2Llc4SZuLeJSSCvbYFGVQMdziAoVlVvgQ8T8MCYImvpkp5Rb+MXbdTfJPaZ8eq+xraKFFNf5fLCujwvellEQm7NpgHwHtPZmUp6bok9tPklonBCGjNZxNUsJDGnIoTFrUCZgYnzh9NOmbwyQMbUpiAzmpKklzG1X2dbe8zL7WuiUPjpCzIMysfaqECEhdeSNV2MhEdFDgALGJ8gw96bJJtfh6Ws7c8n5Eelsw+rxSwpcyYostEEjdean9mLJ2y7sO5J+kPhcAZDXHDJGY9TCm+RGkSGOWJFCJyTOnNlfNQ5aAyRwEpd+7B3mMTc+OeQUZT8LGZXWnWRiLDgzPfp3Obrw6qKQ9amGNzd1rHCMOLLqPxJ8S5UH3nSuHagpPkAYS7zpO9r/tJC7w4HkPIfQMZhDFHEIpyw0QudqLQgjlSbljWuPziWVkt4DHmJs+0RlmKrpkQdl3afno4Ikb+KzyKGWmsXFe1c4Rc0eetDXKVNggouzxe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(478600001)(7696005)(76116006)(86362001)(316002)(6506007)(54906003)(66946007)(66476007)(66556008)(66446008)(64756008)(38100700002)(38070700009)(33656002)(52536014)(2906002)(4744005)(7416002)(122000001)(71200400001)(8676002)(4326008)(8936002)(82960400001)(9686003)(5660300002)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lFSJqTGPAg37/rxJS64vS/F53y0sLtv9ucwZhiE1Gbnqh5VyTCr0ei83A29H?=
 =?us-ascii?Q?cTFaa01qiVCQ7Gv7Dw98Zx8nRlMecKw+4TyGmSe3wG0COY3uF9Qc5WVxwMU9?=
 =?us-ascii?Q?7GpWZcoQBqyi80lhPnL6czuAHDAk1lSXvrzmzN+aecYm/vFXKVQtltJ7F9O8?=
 =?us-ascii?Q?FJUCZW1kh/1zyzgW61g78QW5v4/iQHSvPOPiI5s6eR1klmHbga3IZm2R/EEl?=
 =?us-ascii?Q?swkb0ZmwI+tzPknNRdGfSRoiqKJClwbm/xLwz/tQjiBR7zKBbLBdWUunmg2D?=
 =?us-ascii?Q?W+tkb0fNQSxNCikVBUaZAMIOLkKmC6BNE60TMqLVZcMtcGMUNc0lfh54AZLT?=
 =?us-ascii?Q?Ke70k+Yw2CaoO5U7tM/OM9c2zDIqcUPoCC1qH3DLFwJ/+WpvaIunma5pkWa4?=
 =?us-ascii?Q?Ijuo/N2e7UJKkOEkO2NiV/jhttVBXKp3hJZHh/xD16ndHSGYJ8B+jYOWaeOu?=
 =?us-ascii?Q?Y7y4K+RoDh21mmgnKrhIx8CCC3iF2nUmV1/PXMYpqESl6P68z92QV28D0Gvi?=
 =?us-ascii?Q?uMR89SYZiYlKc5nXOwaDUsFcJLeGVxKVNoLm7MRI85CmmAF7bxNwbyFJqrmq?=
 =?us-ascii?Q?Ka79wmo3sCTKMybJwgMjlWdeS0KrKPCdEG9ukmWviwYfJXi7CJJJKTsiKrYs?=
 =?us-ascii?Q?58B7fPm/4PL88ITPhOCF4WIsUMarzE9HW9/GU9y0L+e/aS83rLrlc19pAa+z?=
 =?us-ascii?Q?fpyCMkXnQhrmH75/8/y6YQaLgKZ5+Vt0L4xTGcyoLOiJY2S7J/n06PvR88n9?=
 =?us-ascii?Q?sEZf2R3gGcJZ8Ar43leh/gMtEpnrXfqbS/n9GYgx/c3+/XifEjp/ZyWgGinW?=
 =?us-ascii?Q?zm4/0kt+MprvHp5dAr5ZIwaxXJARmvCN69e+mvjUgDHkLp5fPEhCnz24zFtO?=
 =?us-ascii?Q?HSMZLbcrPIJuk5zlkUTDqNflz5QFyuRImAEjPK0YggRbdF9bfcEj4OMn7Wct?=
 =?us-ascii?Q?F7QGgGySzLV7rJf4df+/A0Y//g3Tn7xwSNPUnv9ZsNBlTUDtbfG7/DVqmppr?=
 =?us-ascii?Q?CkGIxmzJe/LWXG2c+n+Z9dgdM66joJEtwmWOuJBKexUFzugFI3szB58GdgTC?=
 =?us-ascii?Q?8B0aM4Zned233FQ+HNYh+T68CfUT5Ddpv4E4DJBCh2aoBw7enJSxCwpeDdDz?=
 =?us-ascii?Q?lYuHKc5IZybPg5WGaH2SYJpK9H+6/JVjYtyt2pJgjAA8oBTu+MhbiJ00B0nh?=
 =?us-ascii?Q?4MvNhsY3FgvJp39alIMWsj6ee0Aag3TQ29CDEwTYaxyd1QrS+URhPCN5Brrn?=
 =?us-ascii?Q?89h/HfYPAeJLDIHehSfc8inr/vPLFTddoDQkSMdjky5R9rxlAsQKB22ouNVl?=
 =?us-ascii?Q?aLAMmmffFGiIZ9GjtI2zU0/H3+MQeIeIcV51Sivd9b3hUKXyNOr74yaKyo5n?=
 =?us-ascii?Q?b/kbRNLoT67LxVo+uQR1+kYYQBmU0PhnUbwmaQT5B5yQbZc7NttRd7sy+NOX?=
 =?us-ascii?Q?lYDW8oVVxFNdsOVaqCi1AJy42YdHSyOcd45UgtdYZdrZ2AW3Ia+6seGQ515U?=
 =?us-ascii?Q?x5WQffEIXKsdsJS6xi3izpk6piNdnXHGroUTZAg4ppvg3yl/yCNcq8ygMrDr?=
 =?us-ascii?Q?vWFRa2q8k3DBNqt9pZs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458b7a50-d3fe-4c9b-2edc-08dbd5e3d14b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 05:24:24.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhD3RoDIiI9B/iFtoGpBopG9oWUWqiNtZYA0ZzZaIaY2d9aDgXx3PXbDdS4M3q7bEZK9/PB0TceHENBpKsfSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
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
> Sent: Thursday, October 26, 2023 12:42 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And
> 'nested_parent'
> is added to mark the nested parent domain to sanitize the input parent
> domain.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

I have given my r-b on this when replying to Jason's change in
last version.
