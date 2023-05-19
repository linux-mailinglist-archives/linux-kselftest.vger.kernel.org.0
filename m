Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091A709213
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjESIvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjESIva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:51:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54945E5D;
        Fri, 19 May 2023 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684486289; x=1716022289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0MsVSCUOF52zPsyrr16oHivfKYIrLhRDzcciFvezLr4=;
  b=lMtsQciCMPHDTvD8/cAb3LOaGpg8Efw8M67ZbzW6baObsHThEIMYVl3X
   RG5ZCRgbXcbJI7DcOV/4n1UpNv6dxqVd2uewy6lftJOmucV7Rglz2MVQL
   aHZfvx3/Ny11fGa3bDzOqlOsqjBUiX48t3UJpZnWNkGXTrbSveecu3jDg
   woOxggL8RRgG7mQTONDFx+aDd93hdCxPvVnR70pT4hkRS6bld/ghcOXzG
   iOxRl1PkIcCHRgdaJzjRW6nBB2FrwagpFkmc/jwRGX2s2tvCfQF+CJU1z
   9HUS91YDkPuWGGpkvqXYWkqxVtGjOiEXwanOiHf6PjjYkN2pE36PsxTI4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="332683993"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="332683993"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 01:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702460882"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="702460882"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2023 01:51:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:51:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 01:51:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 01:51:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 01:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGX86Z08NuQ/VOxsNyiC/6nBdsqIrLlPAxUCsHYzaNOFb9oj/RjuKGWTNhG5EcqkhGlQezwuG8A84N9VpHPJjQ4NExFtNtwLPYn1g/sLQg/7Sb8BIEOSIue3xHPnC8oYy4y+bwpUJiIY8rAxTZiBMphH207tl5Jp7Gg1pCNcr5M6Qrv2LRgo1Ri9frIxNzswO8+2mlfnTsxOxrhcn0VRBCnJLCs18Z6RW4DsBn99yJ4Q+NwBIipsE0liDJEEbdx5Z0T2P9en11/VKQM3UNrtSMdnb2MO5aRG5hMSJieEYnR4KKoURk+WQLsCzabBcdrdJOSRuNrPSONPgjeSlcnzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmpDrkMg7d2rxptr0kBMpIwLTPY3OKtnjnGP2q4nJAI=;
 b=U9gSPSQia8Xi7USg4cbBExZzRjeCkUR76oneD/mg454B/a++Ig+/DjS73za1UnWo4nRtOHxTPVZmHMdx6jSt1MXsP4Efaq5nkzhWBS6dwRhRCVDk6jeTDwjoHVrM0gshSdfRow9DkUo291VK4bPRvRRNo67ajOhjVnLegEPFVOLNZc7/W+DMGsnTIJOX6FsxX9x2QVC/tjjhdUKbAK2UfvUKCW3sN1Gxo79sjuneOw1FASCN/y2WURJwQs1rKrFR4vuaQDBHcA9FRh+HbTE2Kv9idaHLS/6RWSRC5yapAIMyF/aZuyYp8ealh9ACQwopd3X6knG+DJHelXBUWD1B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 08:51:21 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::6f80:cda7:a88f:3cc1%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 08:51:21 +0000
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
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: RE: [PATCH v2 02/11] iommu: Add nested domain support
Thread-Topic: [PATCH v2 02/11] iommu: Add nested domain support
Thread-Index: AQHZhBZWGCZiHoB7mUmjDNXa/a39Ta9hVaYw
Date:   Fri, 19 May 2023 08:51:21 +0000
Message-ID: <BL1PR11MB52717388249F052433A7FBB08C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-3-yi.l.liu@intel.com>
In-Reply-To: <20230511143844.22693-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB6786:EE_
x-ms-office365-filtering-correlation-id: 02a9ef11-e732-46a2-0103-08db58463822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgKJKJrAToPSajGUeFD7nt8cBciuDjU9kfpngYY+yaqDwS4ofNbIlHhXkali/FUbWt+t2SRcdZlCOYl5c322NqkZ3bjMqUJo4nxspqbr3/TV1TC/emg9UTB96pqGDg9vF1n5QQEmYjVTw4UBiGAmg8rJ7OJsPwFnfJtXh+E/TROgUNms9b5FtwxLwSaNIV5X5D5aAiYCi1jbaW36/rDiS292AeeTHIXBL4BOy8pO8+32i4W/UqQHBhWdZ3tLLSX1/hAm1bqz8/TLM7gM3wJdCfVluh7a+WjyW5/ru0JLGYnj8eygq37XWA66UTYZ9rSv+aICnUArXp4J4ojN99mWiibWSqarGRoNtTC0mSoGkl+8Uw1MEXSgXPdymHCNqKRGWtro/2O0QoBrhiiySC4B4cDyf5bFRPsZ8ppGghGpWdIBmOmqgNFfoSK53+8wq1vQQ9hlVrBG6xL+HAnaCoKwjA8ISrHfUoHMy15Vawti9Xq/k8Jt8t385qKUOFPixay2o2nTE82QYtOr8ow5eUsECtb1mi7SI+XHX96EaJS6PcTlKhEMhRJHCD/0B78jR3B/dRWCrZlPScVv3NvSQ4ai6ozC2qdonsUoX/TGlpXNP2NHz4m/cv0tXksFgD+Ydjz+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(2906002)(4744005)(478600001)(41300700001)(4326008)(8676002)(316002)(8936002)(7416002)(54906003)(110136005)(7696005)(71200400001)(66446008)(66476007)(66556008)(76116006)(66946007)(64756008)(52536014)(5660300002)(6506007)(9686003)(82960400001)(186003)(55016003)(83380400001)(38070700005)(86362001)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uMYlCcoP1Wh/cjA25rwdgnejQ0lI2+NTBHxoUD1WvZeCA73WgC+5JfoUpZw9?=
 =?us-ascii?Q?LyOqHUhr5k2Jq9xA+4Q/TZq0cTJe2AtMpPxdH+6iBiCbWPIh5IMiWC6A+ZP5?=
 =?us-ascii?Q?cimtiJYL25ewABDx8e3jNvEnOBH6WxSLRAoxtnKUpFo1ZZ7gSb5RCOz1SC8I?=
 =?us-ascii?Q?IigOPi+GwMvHQVWUK/3urPStX8CPASePs/pGEfexC+Jn01KDk9WDG+/Zj4/i?=
 =?us-ascii?Q?HeQrdEWBLm0lp+CQ6wNdaDKNDboiJg9+LHGp1rD4i6xBW46EWAa2kXpAAsI/?=
 =?us-ascii?Q?RZ+x3VLfPyc/w1crcVGeAFOQU95ylnCxmHq3ZCa/nTKKXFGF2Cjno5G2enN1?=
 =?us-ascii?Q?paLxjXRZBs9ZjTG7RvWvLinT7cy5FO/lwu9fwvM89SVpikJ2pDXfttu+kRh9?=
 =?us-ascii?Q?Ad5MxM9JNjSG1aNbioGiV71/hafvOMAFUkKoAmo/gTa5NbL6Z8++2sC466PG?=
 =?us-ascii?Q?OO+Lh23joBwusMhWJvwiUOXRevgcO9wT3fSsZlEO/IwSO0PCPADEZuFpWah1?=
 =?us-ascii?Q?1SrKr9b/aT1o0R3LT7B5YYbcVMAVXS0tRhH31Kr58HwYkXxTFa3XMz79IHTC?=
 =?us-ascii?Q?3tDKp54HvCfNrdT1LLrDLgB2aeoRP/S10zkwm+RwHVyt9JkFX2Pm44cZ1heS?=
 =?us-ascii?Q?byy2Ye5OWRfHKOrgSj4iVLSRujQVx0+LL2ct2ASiUnfd/QwkYcg/YagzBPdc?=
 =?us-ascii?Q?Nwy4/KH6pIUX//twx5O4f0Zv1ckQtt666p4o83xSPnZsZs3jeRCAy0WFzJSG?=
 =?us-ascii?Q?eUeUKv772ySoDAl/0ftpwKOiG9QtbZI2uoV6DKjmik/hQdL93LLrEViSkedI?=
 =?us-ascii?Q?P1xQcgZBgi0nyYB5RKTHSirPSrB/vzG7Y3Ze4ImdT4Aby/R5zsAvDXMj4Cae?=
 =?us-ascii?Q?QnQN5hSeSgBae+o27+IvHX1x2d4LWOYtvN2q153u06hDdyt4r7sgaFtk8GjQ?=
 =?us-ascii?Q?jWY1SXGMKzA2CdcqvkbOJWcN0aC2brpiZiQcdMDg7wqPC0pJQnJSeM0qTObL?=
 =?us-ascii?Q?LxRCcjPR/vu7uNcaLYR6eAAqXo7iI+JglcXy3Mwwo6GIQ5lzNjYHCXJmQupc?=
 =?us-ascii?Q?aQu7sA/jy9uLjA4AVhfcm5orEXq+tgNJL0ewOTdss3MpjLm4nELYxzptxRUg?=
 =?us-ascii?Q?1pQGe3yRalAZdXrxEQQ53oexNjqI0J8zscMcs5L5b8UXf6Ox3trCrEiFK3Jq?=
 =?us-ascii?Q?UYsQugucohDGYIw3B0YddQpwUQHKF7EhA8MwkVAjM2rzD+NwQpxFPXNgXsKz?=
 =?us-ascii?Q?ND7ej0ZlB7fuTyq35r0Ud+RSQzGc23s9Frgf1naUD7yhcrReILUAWBwge7aZ?=
 =?us-ascii?Q?C48Rvt7OSveSu/URf2hRWsct1/yXqsz6r+Vy2o3wbP6BPvsjjufS73oZSkm7?=
 =?us-ascii?Q?60YhlAglWSGUEvwsQJpXdVgnXJru0JRy9wRKaOazKmlNU9xgk/ZRTpKdFw3u?=
 =?us-ascii?Q?WrZtof0oVYPhbvF34/YgOk55tJcdBIlyqjSxyrHcMyFv6B9T6SZDGQvE2NDx?=
 =?us-ascii?Q?Z/hqv8AaN+u3WXSvtCB1Nq2lLTNum5RZ5mbcEqChgX88XzCrOmAFUDU04tG4?=
 =?us-ascii?Q?6gd4u8AS2MfDZClvXPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a9ef11-e732-46a2-0103-08db58463822
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 08:51:21.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vx8qxZjPlh5dLiWb3opCuTSPRjwmzdyiErYmA+MDaKeo7KSD8JTxmcd5hulysDc8lQgoGiAN08qcie2a1mFw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:39 PM
>=20
> @@ -66,6 +66,9 @@ struct iommu_domain_geometry {
>=20
>  #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address
> space */
>=20
> +#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed IOVA
> nested on
> +					      a stage-2 translation        */

s/IOVA/address space/

> @@ -346,6 +350,10 @@ struct iommu_ops {
>   * @iotlb_sync_map: Sync mappings created recently using @map to the
> hardware
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty
> flush
>   *            queue
> + * @cache_invalidate_user: Flush hardware TLBs caching user space IO
> mappings
> + * @cache_invalidate_user_data_len: Defined length of input user data fo=
r
> the
> + *                                  cache_invalidate_user op, being size=
of the
> + *                                  structure in include/uapi/linux/iomm=
ufd.h

same as comment to last patch, can this be merged with @hw_info?
