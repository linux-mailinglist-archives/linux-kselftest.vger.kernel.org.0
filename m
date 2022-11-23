Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE56634CF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 02:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKWBdb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 20:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiKWBd3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 20:33:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AA31351;
        Tue, 22 Nov 2022 17:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669167206; x=1700703206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OBr1SWvvRRJNaLpbI8xYygfZ/hyzWk2QVYdIoyZ3hxY=;
  b=aEIvylNkrv+t446QvpazgSCvYzTCEARMIcLtD7MIDbu4JcFNvqIL4Ynl
   hUwo8aB1lewf8RcIiav0pQKT0jzg9eOFaQyiS0o/NdqfdB2fXNLkmVE6H
   LIHsDfZr9SY5Mp3RfdjxSyj95PehY5Z0odz8+ITu+Paj0Wf2XoKY729rp
   iQwj/BHotNx1ggxWBGeGGYzETOwR/X144iUScY+GxZjY+RtnYE/9OppPN
   MGP3alSMV6+XN/MpfmnVFQ6BfHw2e1nDcgT+AXDBoIcsGbTOIm8UgZ4d/
   prXGwNsM6G/O4/s19fL6/Ef3wfup/qrinYOvnC+pigj8mgZq7ChNKXFuy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315109134"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="315109134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 17:33:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705175801"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="705175801"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 17:33:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 17:33:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 17:33:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 17:33:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvEYRl3irCLKO2W5sfnGjpTwTKbI6Sww8Epw3bXIqFhV5iWZU1qjn37JsIQgCG18DiiCZBhUCq53YLasP1hqhjwhh3yojR3b68i1fOHYg6iZgzsjb8CIO9axVWVEUtOA1GTrrDX11K0NLd5rierX11u5yXUgimDVc0o7AjuQbyTN5rS7M74yvu2X9cvZf8BZxnd9ekZxlTmNPxKEyYQMsRLw+XLGHCoP/JQE76EaSf63qOvtf8ACoupCR/UpEzx+VpwDiIo68XhFXhPFStIoe4N48g6K3pwVFircNJCL7p9lyYk+fnucUAQ2gFfDK/JaIyA+tZhFwhzlEvcHnp8+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq6yRl5PHRvsiRUq6OItBws3V3L6qQXU2d5QLmAVGIc=;
 b=jqkqy/HOZT6wn1Mo6PJ4mtbS0PBzutwNnFoG56hf6Vs3bw+sGTm5ujpVcbxZ5C9m2tryITnBDyWfjwtVETztwuxuRQEAIG8EZVcNQ+2VCJ3VNpUlbF1/T7ZP1u45rkKTaXhDisPTk9E5dJo1Sr5p9aQnXj7xn0Wr+IUlO3KwYOV8PGdf3cd6gErYd3f8oY7TgmDrw/a0sktyGlm0/mbMEAP1svfvrmNX21zeltG+PiHQahSIGXFnWTsT4BtuzRB+mVwO93xBgmy6ZW7MuLlFtqUJe8y7opaJo8XyCHDSFrmkPmXCyCT40P5jxMqZLT4sEGuGVfVvNdofrpo7UVvpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7508.namprd11.prod.outlook.com (2603:10b6:8:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:33:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:33:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY+f/RLyRZNBfk70CFqNn2m/63jq5D/xhwgADQB4CABvLRUA==
Date:   Wed, 23 Nov 2022 01:33:22 +0000
Message-ID: <BN9PR11MB5276939555C1460EFBFD15A68C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3ejMSTWvJuELQ7K@nvidia.com>
In-Reply-To: <Y3ejMSTWvJuELQ7K@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7508:EE_
x-ms-office365-filtering-correlation-id: 606c289f-bfa5-4bc3-aec8-08daccf2b53f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNblUVIEfnm4/625qXv52blcJTXylvDBbqYJGnhBnOaQhbq5zwrCwLZg6Hl8/qnfJOO9xLo2VvAEmzEuONDJG5icr+fG4HWZQ7zgZEWax6OCxfIrUCkdNc3hwy3PK1rg/WELewoJ9T/PMEGjEYEZxMqbrHdbOMOKRxXP8F7zhRYO+qHqOYoJyHXjwU7wkrOU6HU2dTAuLloldH3gUMKG+ls/TSkzZ9CBd/KWNYiPzbHA13SX32EsXVwV+pZYWMPvOIAGPAshBS2uRZU/5nx0JmiqbH/VeNpWN94iD+BsCitzAx34b1nf+GGMQc+RKoitbMtARNKilSnqritHLwvGyxAkdiSBC7hYssSg8ceVHzvR6y6wnWsFqeuah1wlYomURUQZS5hljqI4p5S80r6QWFAJf2OBcE/pouimE6EPl30kfoAkU6ACDDvxxUc0i/pEoV7kc1CamJ0Jy/InGer7I9u/IaCiK2OW2d1ln5MzKHuM9HS669NI12kZ92qMuBHx7TDqONU4GHw/v1NTFp4HJ0ckGp+lkZ6Nk7LLV2p+Bpam//yzNOsmXS9L7s8nnqVqy0Ipiaz6bz42BdWIgLoCJkOvDamYL0HaAU3cBGGZyiVMsM7FYuncv+1rfj1TIiYOPl0AWNGldqQPMBEJEcvyLoSHtn41A97g2eeOv1JZuD6xchS4zy0Hk4qbSrWEewxaU1ez1yumF3x9RzQrKrgbWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(2906002)(7406005)(7416002)(4744005)(8936002)(41300700001)(316002)(6916009)(5660300002)(54906003)(55016003)(66476007)(66446008)(478600001)(66556008)(66946007)(52536014)(33656002)(8676002)(76116006)(64756008)(186003)(6506007)(26005)(71200400001)(9686003)(7696005)(86362001)(4326008)(82960400001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KicMAzzoaXzKRfIsCzayrLnV8lEMqV1n5JsniVmtjKDJaVu0Ae6mMtSjTt4o?=
 =?us-ascii?Q?8FID3Zyco40ARi2CugtIBEsOKV2dt4qP454nowBWQs6IMHIAcYhwZeUCaxZg?=
 =?us-ascii?Q?OLIZuAXAC2JFJ7B6n7W0eXa7uuO8badEHSRwtCkHCWGSsa2Wc2cpoSJgtRkn?=
 =?us-ascii?Q?zCeEGaxPIl69A+l4h0IJO8RkSgXPGmtsDuPWXQpJ2uZdo/21Gw1PEhQw/D5x?=
 =?us-ascii?Q?WQDxQIf/2XfLHh17mODePwZhkfitnhd9dr4RDtjqITiTu6iEI1YGCw+TbSB5?=
 =?us-ascii?Q?Qo562R+KnUR2vbpWvf1Tt7SScJAjypOxm5r9TUTw4Obh/pxU4fdws17HiHvM?=
 =?us-ascii?Q?rwHczW9ONsbupPqDEtIGXN3l6CfMzoqE5Ce4U1saUFimPOklL6RhOCTunZgD?=
 =?us-ascii?Q?QU7wYC36IK6fHGPdI92M91LlkHUEmYMp8G27yrL/Oa9Y6qjT9bvrSYqQc9Ld?=
 =?us-ascii?Q?GXRwbLE1B1x7ebjzsd11LLCS0lF1tqgV1ATNmR2ZQdD8JxKiI/72v5hf90sa?=
 =?us-ascii?Q?19PRXsPNvJWHPpi3smP1tl/L7B3wZX3ml1jIOYRyEA2E95aHp+bWEBhlk68R?=
 =?us-ascii?Q?yOshPeM+qOPDQs+9vk9/w7rF1DvXXJicyad1alAo1Jf8Ug1dmfjzne6cK7Tr?=
 =?us-ascii?Q?iRfPD93nFka5l2jjzM4cbjOMphneV8ql1qsKiI1Iz0fTV38jwGN5NqgeFgyR?=
 =?us-ascii?Q?Cy5jXQhKJhVmkO/RpsmUjAX0EnSHO4LGr96sIzEGY6FgrI/M0gYji8cc72Aj?=
 =?us-ascii?Q?1mwjMji6ImWxQ7Kj1P0SUYipnXa/5h3XkyMEo2xfOFniDl3fUbx05aqkJ3oh?=
 =?us-ascii?Q?xjmhrxOdCST/QJcI+ipJjopFhK8B4Bx220rXx4xDSH9lV9NSOs7YxPs/Jnnj?=
 =?us-ascii?Q?9RT8t+0l5ivguFOXOluXhmu3ldoUF3O4QipLrr+bZqrU/JdqSK2jIEMS9x41?=
 =?us-ascii?Q?+UjxE2HrUzCDQixAbkdPrKQGit71ziVEqtBUK73oPjq3qWdySX0+2UAbkZ07?=
 =?us-ascii?Q?KyUJKHw9EQLcWaQq4ze/dqiAHPadpSsXLcbiYWfjVE7IWlxcQtoCz9bowcMe?=
 =?us-ascii?Q?yDHYYaPOQSxUJ+T5x+yY2330m3lPEGlJF7lN8h2VM5ySFwKi7Zt+87P0zTU6?=
 =?us-ascii?Q?Lwdkdtz+KoaH3oNqagP0U/hz+qxQSrJC/as2Jz7y0tO5rBvxSxi/YdBDM80w?=
 =?us-ascii?Q?a8A/dR86mjBGLnG5b7CDTgH3tpnKk8jpdxOmDZLM44snhHAXPmU07xQoIkb5?=
 =?us-ascii?Q?tBrH050eqSRnwK0Ztz2OeDcvzuhKmgw3mavQj/1MAMElyLh8U5huof8Br4tT?=
 =?us-ascii?Q?V2Bau0k8NoZm+ZNc+gY1VbeKu61dQe6YfNwEpNCRldPROrWp9erPMjuQeDOh?=
 =?us-ascii?Q?o9DM/bk3oRCQ+fyKqoXJJk47h6gr4X5kpzIMDSEyAOkvP44JP00SLW9uEKUo?=
 =?us-ascii?Q?auP/QWzZAGVW+n6tinxSXXI7qncFow5g+NdbcAIRLeWcPGeVkX9BtmVR4k0G?=
 =?us-ascii?Q?Uw9hjl3OIzG1Ut2PIj7JmZpPtgi8HhaYY8BOemc7itCpC0VJokFs2IWzRMQX?=
 =?us-ascii?Q?Ym2noQvrvNHj+cOPGus5z9aYA5x1hET8OLFIfFDH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606c289f-bfa5-4bc3-aec8-08daccf2b53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 01:33:22.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1R72EJz6qjKj8W86h7UWtC8W2tdl2zoZcsdt648Bhi4iWNUeINeLHb3eJ5N2pIqtBIxjMPKv9t23fEubxHG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7508
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
> Sent: Friday, November 18, 2022 11:22 PM
>=20
> On Fri, Nov 18, 2022 at 02:58:49AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, November 17, 2022 5:01 AM
> > > index ca28a135b9675f..2fdff04000b326 100644
> > > --- a/drivers/iommu/iommufd/Makefile
> > > +++ b/drivers/iommu/iommufd/Makefile
> > > @@ -5,6 +5,7 @@ iommufd-y :=3D \
> > >  	io_pagetable.o \
> > >  	ioas.o \
> > >  	main.o \
> > > -	pages.o
> > > +	pages.o \
> > > +	vfio_compat.o
> > >
> >
> > move vfio_compat out of core? it's not required if VFIO
> > is not configured.
>=20
> We can, but I don't know if we should. Compat ioctls are part of
> /dev/iommu, and technically have nothing to do with VFIO. A native
> iommufd application using VDPA could use them, if it wanted, for
> instance.
>=20

I'm not sure whether that requires further VDPA support. Be safe
I'd like VDPA to explicitly select vfio_compact when that new
mixed scheme is supported.=20
