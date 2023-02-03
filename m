Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0E68938F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 10:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBCJYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjBCJXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 04:23:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F03926CEA;
        Fri,  3 Feb 2023 01:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675416216; x=1706952216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QGoCc3GtwRCcTmavGEHyaSP57kpmvXw7nKGPdB0nKAU=;
  b=Qwx/hhXK7WWL/wTvCPn9rCgaaUYQQsD+23g5cR1FhzDItzMdwhj56Q2x
   wcsnuieGZK/LDMOBMmXvQMHy9r3qsP7t8Od4twYlHXG2B+oIqP+Z9z1dr
   Kxh705H5o4/jH64NAuM8bWGhBeBseG7oCW7EseDJdA+Z4L/MF7BoxW8dL
   AVELz7VmKcuKXm8Vy15MUOHgUfAIScaDcMZHjpolPqsr86f3ZuAAMKQK2
   TSxN8dp5c8uDoDFwxzN+4i7w3yWdKFoniLkgMmuCndp5o/69PvuSNHWuc
   V8o/hcAZm7fMBAKGs1UhexhD3b5j0ORN75bCm7+gfEgE2OqscVfzRajKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326398433"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="326398433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643207241"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="643207241"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 01:23:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:23:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 01:23:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 01:23:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 01:23:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQNa+B8tj38KmCHCOM1bJ8Lpt8OWuiHqa2Xs/FprJfB6TOJAqiYM7e8iVcvGzaqBr4vNuLaRI8xeDnmEsqyNoB2AElhMPtTBzmRypT/KTqiDtF6/rTwj9jPnx7BRREUMMMqfDBnr8bHSOr74acv/j8+MbV4z//3Rx7bglSgTtCC15EOTInCfcg3LK+vx67Idyqz0tRCZUnvoAGm0jvXv5Uv2FPBv662m8Dm0WA+reA8oaZh9exR4KF4/AcS6/uU8mWULQDaRuRzOCv0NtLvSbzWGR29CiLri254+tG/FZ5Dx/BI2qkm4qfk8Z3ErtUgKvfblF+CAPJlSldcUhIIJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGoCc3GtwRCcTmavGEHyaSP57kpmvXw7nKGPdB0nKAU=;
 b=fIMOMkm0C+X1x9auPe1HtPE6TRsMRCOVsUn3yT3Nm0HW65oVvZY7RfCP/Oq4SWzdD0W2tCcCYV8OB27hDkbTVmvmEALBAqzms++exmoafX9rOTp/2MT81NCOAtkVvZ+UiLiuKyNMA66U8xt+FtiYC8HGv45U9rSwcyY1qBJ2MEYbq45T2qRey0M1G80KC0TI7jb+gU1Z4AK4Xu9gR6c3OzSgS+TaWCEQIlpWCchTPzGUKkSrg+SdHj3u/BaGVPYHSyZuUQJW7hX4liKFf/cNwcMJRABW8iOON/wexC/n8K3K4HhARDcBe+DX/5POnlWm2BEHijygFd9yyWCoX2+LqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 09:23:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 09:23:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 3/8] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Topic: [PATCH v1 3/8] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Thread-Index: AQHZNtTJDNGdO3E9fUqqSA0twolHd6688sNA
Date:   Fri, 3 Feb 2023 09:23:32 +0000
Message-ID: <BN9PR11MB52762E0F30E88F9FFEBD94308CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <f86e468509886c8fe59d2326f83bbf95254e0913.1675320212.git.nicolinc@nvidia.com>
In-Reply-To: <f86e468509886c8fe59d2326f83bbf95254e0913.1675320212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: e586f879-c455-49f2-0ed1-08db05c851c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33W9PW6eg4vW8Z155SEsBgreuVFTp8K2Gu+dLtsKN4jx3MvjjYoGBrNTWDJy1zmteqeF7sa/sIgbGNd6pVAdjhH8e1mO7KH7tWzDAUUqMjWOPmW5OhL/EhkZ4NbUyD3bEyXSE+5222AGKQJzaJhJJlEC97HXpbrmw/KRzxYQzZjoF2pp0CNN0A/gPiNKrkCewGihKxqF7LHcU0bAI7Vmc7wSk0MqJWA1Yf7cEXU13CDwhUKfpMw3xlaQsHDwuiGm8U/VZax6o+BXJNBp1xp9nNYf2+xKaqOo4k6w0bfu7D+lGii4Aik8ogmNR2oftS3yPtAe8S+dln9VaabAO2lCgYO6v2mIXeceuNETT2Ba4ZY4gzjmx+Vj5cWrp+6QOYWcy80IQKAYJBQVLPh3bfBH8qB6y8chynJwmU+GM9Kq+hh2WOko9R9kkS1pfXrbF2rcwvvq0Ujupg+2t+JoBJmAnYjWYqfQvJ/nyUuJnIfeiJPLlFyDKCG+MWtIrjxcn/uZYE+A2+AcemacgdP8hgAKt+3P+tmzGMk0SKOA/hxYHBy3eJFuCpWta9sCtGEAleuTTu1NgB/f2PWdt6Edx7ACdyP94m0X82w6DXwHlgTjyWjmH9NUmq/98+a91qUvHRF+aJbGRInHhdr3GaH7S6IpGV75ZlWwZ84tQu33FaxJHavKfBKJucHqutuTO0ecbbrPVwWEwSKCgpsb9KhBYnOjLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(66946007)(76116006)(86362001)(41300700001)(2906002)(316002)(122000001)(55016003)(33656002)(52536014)(38100700002)(7696005)(478600001)(8936002)(38070700005)(82960400001)(6506007)(26005)(186003)(9686003)(8676002)(66476007)(66556008)(54906003)(110136005)(66446008)(64756008)(7416002)(5660300002)(4326008)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WYHmwsuS+Of7PnsEiDMD/4idHT7JmPZhlgAqQ5FLjYq/4k/pKmbEC06eCaJ?=
 =?us-ascii?Q?uh1UD/kjfpQ9NOYXtClS9TZNpWVIot8zQqhxWJMlOl56srJpjmL0ly1QnFjx?=
 =?us-ascii?Q?VoKlKAoIx5KGJOf1NWubTDW/anIUKCugKvD6ievUu/mcLifRGj8ez9jfIAoN?=
 =?us-ascii?Q?IqDiuUsnJ9CS11QWtwbJR4T2eFesJrW/CATLmy3gzsL/T3JciGdVXIV9pku2?=
 =?us-ascii?Q?8VftgAKTPmeIjjTqbM37CtgG94/8L6jCTtMmfjyWvvbtmZqF6PJ0NWQ4hD66?=
 =?us-ascii?Q?6GvlGMVaR+ff/wzZj7t/hYXZk+bnGx2IS/KAL4UzmnutJRy5GerKCCNtjz3t?=
 =?us-ascii?Q?GegYoxVwdfqp15H0awG0ECOIiG97xppQ1sV2z3Zk0s4Ztyn7bsWJwjjs5GGE?=
 =?us-ascii?Q?sq2q0XQ3+j9T0eFUCOm/E8O2IjOF65LmU7v2OvVVis/ZM1bO+9IU/8XqnEHL?=
 =?us-ascii?Q?5wHiafN1JlreNyrgBJqvjLoSsY+wJhXr8Wof3LFmoibKu3b+NCJkf251UHuR?=
 =?us-ascii?Q?oSvQuECuoNkAofLjHLcAI1Rtl4LqZ2u9sJ879z9RbQC2aTKjono/5sKXwKnK?=
 =?us-ascii?Q?eM9tdkWYiQFoXRKS/X6TyUIjGrQ+S6N5mN+3dtiVoRd8HpO7+j1biMShwCJq?=
 =?us-ascii?Q?Gr17hrTwAUq5GHoUK1k9GlQtVFjuAt7hri9/pPtJWCnZrqpDTvC4pcIc995y?=
 =?us-ascii?Q?NNpRpirze/b8Z7Qhj2MJNYDP7UTO2CV5MeiVt1ZZfarVrBvblPBRIkjd19hV?=
 =?us-ascii?Q?eJPcxXvffa/X/FUvFoJqpMjphfS0uDjeqCf2y9kwKQV0fIs8Hb3/ewT18EYy?=
 =?us-ascii?Q?0jQCRDaFbJiY+NIIJULRSuqNiy1U5WmcNisxXnoloP9IAsd1D0dRyo+f1Ivi?=
 =?us-ascii?Q?YBSuHGv+7YB5sF+yEi96naJhE4aavjFUrG4WtV2DDT6smlQcH61xE5EMrm2w?=
 =?us-ascii?Q?RWg6fvmCJO57Bflk+JcBgp9SZxPPdKg4rPbdwxFm1D5KT2dfkLCL8Fu9qhEq?=
 =?us-ascii?Q?bCnFJuVsMKbEwJi+DMLI3oXZdZsY7IjoVEGPndRHKZHgLBaNVGB2cP9mfihs?=
 =?us-ascii?Q?qpoX/9NXsrttgH6T+802UQv/RJGIcssNyob0Q7fQW3dc0Nev7TCoD1GwuVxg?=
 =?us-ascii?Q?kPxPIB519YuCg19Hw6oTpEp6+m3fT2uOik0Jej5ewwn7+nL6j8cPtnCXMHMM?=
 =?us-ascii?Q?wJC+ArfwJEruFp8UAVanwSfSk8XmEjaYxF+zQFjFKBic6Bmst/EqFEkwD1Z0?=
 =?us-ascii?Q?rntUFoHI2TiRPOmQ5Kbb+JUHIrdnMGeuHs1o/Now7iyPPQjngORfWH3DCJYX?=
 =?us-ascii?Q?rQDMLQoPNqlKTcv6ys4N4F/NtTHQGE6UGc/5ihqXiDiNoY7OizQAgyOYDyay?=
 =?us-ascii?Q?Q+Xy0VaTsOhf++7M57+nYvapV8Ks79y8JswRWmjGIN4xCs0Nd4dPUzkFTDBd?=
 =?us-ascii?Q?T1A10V5SYj4DAwhwIzU0KALfdBk1VtVD8i5/vXZGboKxC58QIlkGgTEIslkl?=
 =?us-ascii?Q?8CfPI+XIw48RGGmVP4hb4x3KTwd/ReJyhsefJoAvTIYtP6ZxA4aqeSC9zO52?=
 =?us-ascii?Q?qL0BuaaGjggT+sy9Jp5VJHUGD9+WO1TpkCaGx7ty?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e586f879-c455-49f2-0ed1-08db05c851c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 09:23:32.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEom130QUBts6kb3GKctj8KYWCi75UFRPPTsdq5sfqTzINShZMyhPOMdOSQIM1znM7/k31Zx2MPpeO34/dsvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, February 2, 2023 3:05 PM
>=20
> To prepare for an access->ioas replacement, move iommufd_access_create()
> call into vfio_iommufd_emulated_bind(), making it symmetric with the
> __vfio_iommufd_access_destroy() call in vfio_iommufd_emulated_unbind().
> This means an access is created/destroyed by the bind()/unbind(), and the
> vfio_iommufd_emulated_attach_ioas() only updates the access->ioas pointer=
.
>=20
> Since there's no longer an ioas_id input for iommufd_access_create(), add
> a new helper iommufd_access_set_ioas() to set access->ioas. We can later
> add a "replace" feature simply to the new iommufd_access_set_ioas() too.
>=20
> Leaving the access->ioas in vfio_iommufd_emulated_attach_ioas(), however,
> can introduce some potential of a race condition during pin_/unpin_pages(=
)
> call where access->ioas->iopt is getting referenced. So, add an ioas_lock
> to protect it.
>=20

What about introducing another flag e.g. vdev->iommufd_access_attached
which got set in vfio_iommufd_emulated_attach_ioas() to fulfill what
vdev->iommufd_access guards today?
