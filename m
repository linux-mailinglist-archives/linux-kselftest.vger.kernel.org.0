Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4A77F14D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 09:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbjHQHfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348443AbjHQHer (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 03:34:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E02D76;
        Thu, 17 Aug 2023 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692257674; x=1723793674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rmF20ILiRewNhKSKPQF88rzUPRQH7W1WYihsAEsRiP8=;
  b=XfrVECgJ6HgtnY+j6QPm0hOXYqC+70ZbZQePyYpwBqEZUllelDxKdad8
   cw1FMljBlSsed+TO2cZjlM6sAAsj4iTMwGF8pmC8npBcc3sENkByTRX5v
   J69vtSVHTUAzqKTOVna34B1v9BfMUv8agazXJ5PWG1hpS6LGJ5xbhEyVj
   djDbIQEFM11HSFzajfPmSvvujliE8na1cmeRW+GP9kguG4tudMvc8aL/o
   tkjtUHC5MhEyFXJEM/dpJlqxf7cRA4FnahF6Vrd9+AQr5J11tDpxL0P2/
   BSq+PWmgA+aScnbH/+Nu2gE/chf+Ae8eYRK3y2EJsSlFOuAyNpGRIz5w9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403719190"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403719190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734568293"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="734568293"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 00:33:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:33:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 00:33:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 00:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/ZdOpeYb+D68XHZ+0e8FCWVsc8h3gjZJ5sAHr20kq108BCOLoUbg7Ci1bjjs7i/bOlsH3+rxDepWV2P8MU8z+b0nVhw4Eqi7yFCXi8d6nvnD+1dcxxqrdXftpIOOf0j+1HGq/86sCkLXsvflM43TRLf6YeZPl/8PRw7WpOdUO5Y+3oEb7ID4jTHoIG9ddaZP3OE/0Xvg4YrjHLZ2aC6DZVlb+mwTcrz5m+kvG+PRDH7PsU56mWYo+NJ95DQXPESNUe3NxV7CtYmkTBD0VrId2TAEJrIs2CIT9W767rLlM8nGkNZXIKA/rZhRcNoYt//4yEQ/L/iPwKN9BCJ2nFhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmF20ILiRewNhKSKPQF88rzUPRQH7W1WYihsAEsRiP8=;
 b=mTrnissekBTZY165hos67Ep6aiWSk6UBv/M3b3ZLtUIpex0N08gLhZS5y3/SoSgww395p+T4W2JQZMN68G1pJy3pLqlLquFuUT6R6soBedVi9vJuh5qKDPNpLAanEhfkwiVTidMDE12TSR8SUBuvPK+B7GLA69E3HAdUhGT8SNKmaJgUoaJWlJ5bGOVDn+05HW95KuZCcfhZmk4lFMnm7yL3mqla/u+fIRDfRzyqavGOvJ0z5jg6ihqSDY3hAfZN/uNQJu9BihO3nxf+pxl5BV+UIwOCSsEmHMjL8sXOGbLP4xbqhhl9S9tHJc3o1DsrO8mh7QJ3oYCnCZfEoFP6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 07:33:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 07:33:51 +0000
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
Subject: RE: [PATCH v8 5/5] iommu/vt-d: Implement hw_info for iommu capability
 query
Thread-Topic: [PATCH v8 5/5] iommu/vt-d: Implement hw_info for iommu
 capability query
Thread-Index: AQHZ0DswxtbPVo4wXkmPSUNmERqb9q/uGcyw
Date:   Thu, 17 Aug 2023 07:33:51 +0000
Message-ID: <BN9PR11MB5276D1526A8F929813244C4E8C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-6-yi.l.liu@intel.com>
In-Reply-To: <20230816121349.104436-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 855d37ae-c59a-4a8b-5a62-08db9ef44da1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfDjiLr5+K57qVo8lAIq+URr4AT/UO0D57pAZyibCwiiq+dnkIzCOFiOXQW5DcLtRM1+u6CJDnyEWKKOac0jSg1mQnGMNB005ibiPLRXZFRGNkS4LAH3Y2g8mEaDrR40CxiC+G+mao+N3mK7CC/ZLQeoNxiPHNWbzsGtSB1TIa3ekN11RGp4lLF7dMfi/jwoU4Z3zgKmepzd+9KwEVl1xnrOUxfHs51qxl0ivslQrS9fpffjNPxO6Urr5E1mdW7csofgUl3cI/y+83K2zzlY9jQpJtefHHl81PzoMdeS85Wfp4uB9ItTMi/DoI90bwc0C+pn4PhiasLxv07Pm604qF3y81MjAQmxlI6XK2sJ+kuFhxLdWA9kpD0/uhBYEulbr0f9d++QLl02UoNbw7IeCLHI77CKdnVu2LJb6N0WIN2NUadWbxqyA3k+Zibpxd3gN0JuqxXf4lqvq1Utr6pems0hbS9lXLQVd2p6+oIPDaJQmobsu42JaJEEgb1MiiNncOn+VPb450a1xP7BJdSH2b55mcq1PFWg8s+V8lvzhK7T6Gy97UZNu3Q8R1B47tSXU53pWqOB7qix4NJouqP8IO+9eiMkPcGBiMRJNzITlaYPDnTSSuJUpQRx0gXAXJnw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(55016003)(66556008)(64756008)(66476007)(38070700005)(38100700002)(76116006)(54906003)(66446008)(82960400001)(316002)(478600001)(122000001)(110136005)(66946007)(7416002)(2906002)(52536014)(41300700001)(4326008)(8676002)(8936002)(5660300002)(9686003)(71200400001)(7696005)(6506007)(26005)(558084003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?upbnSABoNq1zNn+9RKfccSa/0jBH+kltHVlGBbc5Jty7ACoPlSfDOVHbCKuq?=
 =?us-ascii?Q?8pcVoKdRGR3nsQ4MD2D5dMVTHrxlXIBy4fIICMDAr8L5q2QLwxKAoZ5L0fz3?=
 =?us-ascii?Q?fyinKu193A5kCUoKVupf3rsKFHk4IlEkNecoXsV1Wn+wPYdIvCDAlFifVwA/?=
 =?us-ascii?Q?HYtbwPB3zamQfByZBU9IIxQPiuH+J9FtclPpWqZ1QVNkPQJO1OxScKzCmk1N?=
 =?us-ascii?Q?SW0V6A7HSat48+YUhSpgCzhs1FgCoQXdziI78ZZBl6FEok6f46fGlal9b2FN?=
 =?us-ascii?Q?A3p96XitnHlpkMbtwAT8RtZmadorLQEMIhj1U62ULvN4XMEsLvmSnjcYMhTW?=
 =?us-ascii?Q?UnwCQsaGbD22yETVTBoE43uGTwfdG4rolmD9kivKq6vcO7eGea1rMWwtDg+6?=
 =?us-ascii?Q?9VMAbXotq5bQZiuuz80++gF10qGNPAW9cWgpzhcBabNOaRYIKlqG7iikE/L7?=
 =?us-ascii?Q?elONWw87azY+ynoBRnjMfNizeuOqBM+e3BDhMUOG+TZFMyvbKCRcKfzD3Uy/?=
 =?us-ascii?Q?1pkjfB7Pk2+1AWVDZHgVfVmnSk5vbEgCXMGko32cnRfoePEia9xYrybp95tx?=
 =?us-ascii?Q?ETWD6p5WsOmalqPC60VEj+V2TtHI0PKFoGEbF0gtrfkdiW/DJqI8ACngWgbS?=
 =?us-ascii?Q?YacZzAmBHaWgOF4YYCfBF861eqxdpz/gO3IGytlkAT7Kdvw1idOr++jgIlYI?=
 =?us-ascii?Q?/Iu06cCaZcy29ou9fes00d5lh2PgbYLuyKa2uolHfIwt26qL5NhLhWNizc3u?=
 =?us-ascii?Q?rbnMJqmplqmGycUpFgTJN1NU+Cr1BuMBrwXnjaC8LAYwMPqe6T2+8rUd8xGE?=
 =?us-ascii?Q?Bfb8qPRQRrtHbilmMk3RkkSgujJmyPvPj6zRu7v6yrtp8kyQgO4bM4cQApcv?=
 =?us-ascii?Q?gf7cfHtrIjcse9106BuslqIp0Fae9IQ1Z1f+zkE/CpF6ZamKwH7tLZAiVk0v?=
 =?us-ascii?Q?MKKqN0S2fQsaT5wpaBEoZFQ/ed1Xp/9puGI1ch+nit4scJkfa3VVIbVvqaXz?=
 =?us-ascii?Q?wuCPb3czr6XSBIUHOl+5/eGGwjiqyRL+mEuQuiSWGouu0ggaM0/8wIhtRL9l?=
 =?us-ascii?Q?yhnYKZwXHAhT7eYN0hrTIiEwh667w2hN1gABUAPQA2mV/+8gkjjA9RqLDTsz?=
 =?us-ascii?Q?WQyscIxHxmjIHmwTNt+5R430ZQK672Sih069oL1gcObntBQoBsPNyKFuDEph?=
 =?us-ascii?Q?NShJU1He2lhIg0BOpS6FRX3bXrEkTPZxwsDKLMMBGOwAlbx/p3gLihqeECLW?=
 =?us-ascii?Q?DfhBxlgcUClE3K6pS4Nx97BmMY6YSwV4aYu+2GptnTebPuQltdMuHlbYKFwn?=
 =?us-ascii?Q?Hd3OsqJdcG9f+dFoXFeeJfbILcSs9r4KhNoH9xwzYKHRWMrOQKh/Bj1Ko9kc?=
 =?us-ascii?Q?GjAiZVse+VSKTlSz1+74h8RYrcPDILHDmROIZAH35O3Wg+f7hYxfU4EXQGzE?=
 =?us-ascii?Q?Bq20Kn4HJe4X5oWm3EGGqY+OYUgEldsWSxQqsnrECuKCgDmzsVeV4oRSKw/7?=
 =?us-ascii?Q?mD87hDII2GohzUFqov+zTNoqbpg3TOUNz8ncG0h8XkaAeLa4TumXRDZuSAbt?=
 =?us-ascii?Q?njhGMtkojoMigljsMuF3P6pL2TtIVTx6swvsMekV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855d37ae-c59a-4a8b-5a62-08db9ef44da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:33:51.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9zmGFKoS1vM1P6shoFImJepx8vtiZQfCNVvKDkykJ41qXVkmhWHDrorXNzoAS/y0agyfag2bAv9/ZHtkyIVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, August 16, 2023 8:14 PM
>=20
> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
