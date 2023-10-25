Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB07D636A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjJYHgu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjJYHgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 03:36:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54305273C;
        Wed, 25 Oct 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219264; x=1729755264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0nnJgZ8mQ17MJ8n33q4LXPG/mWrRebn8C/moASuSW1g=;
  b=f5RwGMnoJzqTK/CSjyHMWw/zrpCtIYVdwlc1YzbBquTPLc3xD5zqk/m0
   EBZzrYT1euUqskAaxiptzfgn37QfovFT5OhcM97nNV9x2Be0qSSyEnzFU
   jq5/EJDbuy6zjdPUgY5R1Decvl7wCGOtQ2pvw/F8aCv6wzf4PgkeowISf
   jn1qvfIzElx8MNgcqj9YHD6uDHGDM+LgJeFmLwQg4qfg96n7SloUvf4Z/
   EGCH9yDmJbKKZGUT4jaqJ6f8NrLd14si8/lxCMQo8s1FozpS9bWZy0ma0
   /v5VYtXbqcANGr7PzybzojX5bGikumZ/zQupE219Sfs/36vmUXMmkvYI7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384465599"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384465599"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824571091"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="824571091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:34:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:34:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 00:34:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8jaHTkUsMvE4T1pveqgL+6jqGejNN5zD2zhKwwLhhcl+pIB9bZ1w4Wsn/KEUMvq9yuM9ybks2AM4+TADWoxifkVuM8mI23hmtEqY9aHsMBw3NwBaioJnaieq1ysPZyDyQMy7dSJ8lfZmJlwKraEybclKsj8tY3SYNjwaEc4dIk+yVsqVUuS7ZUeFI3wn8txYFSyv4lXWVQVU+swRutA658+AYg0havndQTXly3JFzqQ0wi+C9TBlCOHl9b3cvieuVISxVzYUsb95eqkjKI/Jex+cp7lIGGej4jPYs9UwrGnF/jI0bQxaHrIZntWiXKcmQ/+Nv3UBbU2BEfvg7Zj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MivptBCrndqBrYUNSrMMB3CXBaRmiIZ1ap8DkC2qIbI=;
 b=ML2nBXTItFt8/IJuaiHUFSX7A+RPfotZp7nESh5QfyoWDXPheth//0gHB4G/fdELJO/95zNsZV0NvjzShSz2MRHj5tg3xAdJyy3t4ofx1B4kwU/ZxCEe0cEr7xVyQy/aH1fU1ssxLjLD0izHw8JB0QGix6QDajZ6Kl+QM+T2mnn9Mc3+LSXsr8ryJDMD/8Vs4KnOYGpu9LjR/XHhJt/d9uFVRI3Sw4sa0f0MDiOWcYcoJ0JEjmCKGpe3tO/zV0u3cqDGqGpZxRb+ZG+Jax+r03VnX9BbzUUxHfCNIyspGamfmQPjY4hP7I6vSkFkgZb0oKWcaUMA6O0WVTRHkr+oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:34:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:34:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Thread-Topic: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Thread-Index: AQHaBozMdUHOtbvzQU22Xk0Ng6MCWLBZj3SAgACOfFA=
Date:   Wed, 25 Oct 2023 07:34:20 +0000
Message-ID: <BN9PR11MB5276D670DF35BEDD75FDE9C38CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-8-yi.l.liu@intel.com>
 <20231024230319.GW3952@nvidia.com>
In-Reply-To: <20231024230319.GW3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: c511d4ff-e56a-4ee2-b9b4-08dbd52ccd5a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOFY8xEbRbrn4lBq8XnAlEEqemwNvmUiH6P0CQQeln4Bd6OM6g0QBURx8c/RxFS6K0wJujAjdySFaZzpPyDBUNdoSr9IJIPbwb2liaF/F4b7tzPbOC01i9CXXKfsizhaiXvZTLdtXAr7OHSrkFLYXhptBa4SgCdjhoLrlxYlV46slcHLBCKWgQH/+T1Jh/Ioj2CLkgr9FCFzjQaYAlb45DMgVhs/u3B3A85VdEk8JVJC3xuJLWoYZeP3YDao1+lIYYDH+9ZFepv8udhCdN6z3w2lPcisFV0PAZnoAyti9Hs4ObdfrKtGwdGsmXxfnk/pIEKe9Gaj5IHeB2b+V8fnD/DGTKEQmLfnykjxmpDHWHdLy0CGT9ovSm0wqX6tpWcNambMtJQNZK3NwHeWEpufA5hoq5d5Vr7Wph05UH2f2DbBin5BDqoLUpFvQ2vDNBGbW9A+IzJrETz43E8lMgaL2U+bzT/RzaCdZKr8gQB1Nn0pihH5RX7FF3ps0UjALP/V8T5kRAdTQ7kT6R/PNR20xxHRJXajwMol3HMSVTvBQwiLq8YqO3zR6GSwWScUAwQLLhSv5xwLF/4T7EqxRK3y2GlKlwsf9XhnDT7YIwLp+xizYQLanwudzfgV7RtWUCH5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(76116006)(86362001)(6506007)(316002)(6636002)(7696005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700009)(33656002)(52536014)(2906002)(4744005)(8676002)(122000001)(71200400001)(7416002)(4326008)(8936002)(82960400001)(5660300002)(41300700001)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HvvrERNJNw/VgZ4USDjZJ8Z8/TJ1ZZYhpCdFu2a1R0AKkZLSnoF/hh9DC8KJ?=
 =?us-ascii?Q?wdenmJVgjL7W4BAflmBqycVj0hFIv5tIaut5Rz4/SabLj1WnHfjn/iejhk5k?=
 =?us-ascii?Q?kbqa5q2pBjGl2BFuOW+Azh7BRCrHC4dVDLOJK1k4v1FYjlijhfTLTxW9EHCt?=
 =?us-ascii?Q?vSnDh7F4nCvY8OhbmojSAQHwLZUSwlQGiB6su/1ZvmnYc6QKweD1O8S7jhyP?=
 =?us-ascii?Q?cdPtGRwHPFxzrIx3bRETCERTWlQZrtsGzPvC1PZEYMfJiGFdflMfMTrSLuT1?=
 =?us-ascii?Q?V27T8TjlSAHdEodWGV2JOI1sU7RjNICxU4UG/bvKXsrDXnLVG+CVJflkF3fY?=
 =?us-ascii?Q?T8v2V5gUhWHZ9N9SVwlHIf/d9zW93MawJTH9LtMiqdjF0tdzDib5HP9hJqMy?=
 =?us-ascii?Q?o2zFXW6q9pBT3c4JzhiUolgiwkARkEzzxKkCcFVQ3QwqEQiXM5mls8PSks0V?=
 =?us-ascii?Q?lz9Y+EAophscN9ikik9VAjQPUUUwDK1bzQjSKeGNzVkEeKt1QiPmSpM8p1fg?=
 =?us-ascii?Q?BwbzBnBH0x4rkV9VUeWDWVBT69tTrdlyNqPS55FOhLE1JlIsko5yULal6Ovd?=
 =?us-ascii?Q?43dCcHjzTHqg6f02R/KUiQvIGfzzb0BPAH/31mmPGlhP8a/IoNSfjZo13ZF7?=
 =?us-ascii?Q?mO8h4CXsIBoRfTmmSDFDaN/EqH/Nx8RpPVw9hS2s9pjb/9dt2kbVextSjHOb?=
 =?us-ascii?Q?KHLnqRkfdqEh35HwDneBnKSBMUxQQw2/kahwEfEbOiwcGrU8jTOad2beHBpt?=
 =?us-ascii?Q?6hIsngc+5sFLupvsu/s3qrJ0MIlwnESOA4SEh6joaiAi2NsVnPUEp6em25cA?=
 =?us-ascii?Q?63bDj8cKz+g2ol11FyYodUylZ4Br3uyH7itjFbZLABfy0eMHqrmuHqy4mgJx?=
 =?us-ascii?Q?wAVHNasMe0ljBNh56EPS+hpgQb0Ee/sl+IoNj7l/afn+Dc2Y3H9EGgstxBih?=
 =?us-ascii?Q?TBiGaCqc0fRhXoKOTynQhwvRTFoJB2s2ZAjFkSdkrXHsOUIOzGtFHCn8v7hq?=
 =?us-ascii?Q?xqLgK18p1yRpZLxW9O6WH1y2TXyQbOB1KpFY53xKJOg+EoatJHnvGpBmohg5?=
 =?us-ascii?Q?2YmILUfdetTengAjEHyAey1ra53w/ywrapVuL73vtzzismfDr9eOlQYQRiGk?=
 =?us-ascii?Q?KdwXrsAh3yph6Sef1A7YQcF4pTzlMl+pFT8F6JIBgw6P0mXerLdmzRuvOmw6?=
 =?us-ascii?Q?GzWqFIRg/7yVc3z0sQH+u6XsgjyohCh/oUMQv3peyBbDEhrWq/LNrSPthwHD?=
 =?us-ascii?Q?TNFV4IrpHH3X8VHyXHT/VHSZgc+FnewG83mHvYFnq6Kmtk7deLGhuu2OPVZt?=
 =?us-ascii?Q?+unzAQMxCfn8QQx+cGJMybA/ciCE/0Qh37bSyBIBTol79QnAYEBgUnblsG1n?=
 =?us-ascii?Q?Up3PGcVLKDXQS6LvPfL12RjgHWJyJLFa82uQhGyjscaf/y2mV2VQlMQjlPO9?=
 =?us-ascii?Q?P3t6IwAVuxPF5/cPLTA2DQsBybCFt+z5BZFdm4FgEzC/UQ1Ksh9NwHcLwLT4?=
 =?us-ascii?Q?ygD9KCQ+14oNx7ZOrYkIdg15hPTqreTmXnn8HwOnl1sweR6B3Tr+hekR+b2Q?=
 =?us-ascii?Q?637pl9lTcIPylxh8KefL07ZI4fmrdeptZxH0Gyxh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c511d4ff-e56a-4ee2-b9b4-08dbd52ccd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:34:20.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVKlX+OjYJzgso3f+M3wzhpJcSzOh920XYcfIFzTAWTPNQiLWehJ266NE9bCEfCoFYiBjkk9362JF6ZpwLWBZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 25, 2023 7:03 AM
>
> @@ -4849,6 +4855,7 @@ static void *intel_iommu_hw_info(struct device
> *dev, u32 *length, u32 *type)
>  	if (!vtd)
>  		return ERR_PTR(-ENOMEM);
>=20
> +	vtd->flags =3D IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;

this doesn't belong to this patch. otherwise looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
