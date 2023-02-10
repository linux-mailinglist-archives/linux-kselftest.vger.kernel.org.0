Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817E691D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 11:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBJKwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBJKws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 05:52:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4A1ABC0;
        Fri, 10 Feb 2023 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676026364; x=1707562364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtWF48qal620K3Hde2qpUhW48S4Ln2Itf/rXTe1e6U4=;
  b=c0st+Z2ohiNClhm1oLMSJSunywlHJEgpqNFB1LHjpzFLYBCqcWfviYX/
   KXNoOlOsYtX5J1S0KkG9C8CRZDgwOnh1juJotuAiOQF2i5YjtXyIM4GzA
   yCG4LLNAi5LryfKXEyxvtmSb4yKXfpVJ1sc+4RRih6B+ffJJHmRnqlKCr
   0+LaseqUR6FGBlIIDmPkVBMV/kS8izeen0b9+VrImDSFiZTRbHXW8QMVa
   nIRZnttCSO5GYAO+w4386q2KKszuD1wNqHgw6fH/UDJQ5qGGU6nPqSoDo
   CFnt/J8ZVqDDxBKBt/jS7wGYP4b6+do6XXYBFGeX0DrFeKtWKXHW2eIoK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="330398200"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="330398200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756739817"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="756739817"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 02:52:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 02:52:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 02:52:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 02:52:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 02:52:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDP8wLcU8JqEeD/Ly6PIjDBjjs5giEjLQmPDmBrFYPJXY+RJRGlsDZ0osSBWZDK5ctRxEkEtrh5wqJ96NH0B0OBBURWQk6t1e08Oe4vvRRQizOgQ2gtsq+Z/nnUqASdljzfSNuKreRxdDqbCc13/bCUbGQH3xY1rIWQuggAe1Kg7Gf7YUtqszInk100JEBbvxme1xK/4akM1akTdJAZrfev4vg1cQ1zESaozqh6QgmTD8XZ8W3hZIck4rCqAYSIuXtMQU+QpBOe+WAV9GuyRKycEowS9apPir7qxOFEvGx+XHFbWShP89+gFrSjsLuoICI88j71JJPzzJqiptApC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEY6lkUu0QmCzfxTafCU/t1xn6xqmCECGVpIYe89yx4=;
 b=Z2kvOi1O9jKzlB+33iBP/co68RdcIwTKNx7qvNHJ626jHL/8M5JvG5eteMode/R4sEB/6oc9AkDwfEReM1TlMHfeZKnZF//IhHDpnG750WWmaEkB4q4WBKqoM9VsYoRqUtQQVjpTptwvISXdqW8yYrzDXNHGVr3yYrXuSrEIQNZX19W49CXL+z6iTU2ZBVHQ34J/OOgKarcV2J9UYvxOfnZ3p/7yvF/VwAtbVXOCThOK1ygOFa8kKIA19UJT7ZGIW8C9Uax1ZaGzfgpiQj8lr3W4zGdbtepK8vnBiQjEcMo4POdcnPBHMzDqOWgKs3sBfZnHD732zf4SvNYErlgDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 10:52:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 10:52:40 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 09/17] iommufd: Add kernel-managed hw_pagetable allocation
 for userspace
Thread-Topic: [PATCH 09/17] iommufd: Add kernel-managed hw_pagetable
 allocation for userspace
Thread-Index: AQHZPD+BoQeVhsA6akuRGDX+dgTekK7HFkkAgADsacA=
Date:   Fri, 10 Feb 2023 10:52:40 +0000
Message-ID: <DS0PR11MB7529D9A66459E54DC7A64EA2C3DE9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-10-yi.l.liu@intel.com> <Y+VbUrpPQWkOVyW/@nvidia.com>
In-Reply-To: <Y+VbUrpPQWkOVyW/@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SN7PR11MB7438:EE_
x-ms-office365-filtering-correlation-id: 79f5fd62-e4e0-4159-195a-08db0b54ee17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uNr/w1HH6ISmcJvG/YSmtAALhnxCzeMaVtGlhOpZnQIHpprE1BMa7WlPCY7K2U5zqy2POSHArMTnu4Sw1oLxl5jsD3j3cTWoJ8/hKERLW7jrKnYJk805QW38qORaC/7OhUyHUR7XZyIXR47cMvgpEz8X6iAmddkUAuA/Qb7XMGYKhTJrj4f8TXKOSsjTzPaQFsVX9qRWyyRIqzSpR3GIOei8fW8CUnLdE6Q4Ue0JwizQ1DXc8FZ1K/wnRO9KQEXHxEo10qLxV9sUSNCQbhFyBt09jJnqqdplKJN3XkSwlNyXhGSR6xnOwH8glsf7WuX0NUlfiklHIxm6WorN25Gbu7nP/JLIeGxnhf6+uTF5iwJnBvd+WlO1EIVeAI29QmqtpY4POGrO7XyZIyXyJZjR19Kdv7wp5Ad1BUubu3EXzD27RIms2FrW47sqVLxtQp6sV7gLyyEGcC0eaLZueRhxjPOwUWE1ojQiiFcD99EMghEEsqDzPBSU5EmuRbkpI3BITw9y0BOlHNqlYADUMICoaB3jCFE5mH24q0V9FfclTP+lphi13VZOmp8sABvq4V0ClUNO1KQg4a5oh9NM30kpgMIS2qdAPtSsU5Og3/Dyz00WgAUYxAbBDiWKW8sxNXhM6JPOD5pyk8lpbMOvcod4QcEseQDQLjF9Rqdn0kE9JN+5DKBR9BwN6geXnBz2k7jwSY8MZmXnNinX0V5A5V1mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(38070700005)(5660300002)(55016003)(26005)(7416002)(86362001)(186003)(8936002)(122000001)(38100700002)(9686003)(83380400001)(33656002)(6916009)(76116006)(41300700001)(54906003)(66946007)(4326008)(316002)(64756008)(66476007)(66446008)(8676002)(66556008)(6506007)(7696005)(478600001)(82960400001)(52536014)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ILL8P5Ch9mtEJ5hesUjxVTQKlN91nshJ4N1htLJgFS366pJvmSTOO9VA7Sv6?=
 =?us-ascii?Q?lsR3eScXEoLQvphd9V6IfSfB+JeE82PXHNiyd1i3/HfDc6wtyJheTXLyEawD?=
 =?us-ascii?Q?ZBUJig64ktx/Ui8SDI2uWQh4Gk8IZzcJrb3VrRKt5iIWhgBFsyGimnyj4DY6?=
 =?us-ascii?Q?X77/HfKVdwcq/+ChF7jlkpoHJM//OTPXGZ0hKetcz3x9+Vevt9tB3CCxdpSp?=
 =?us-ascii?Q?h4UqUM1uQ4gVxX4tYGUDFoibMIGa0tev1CpcVQYTDcUZCRJuMjtPGt0Lu4ee?=
 =?us-ascii?Q?smN2F/ByVvTIUToYXc/OuzdM5G8lWq33dYCyQKaL85Il2S0FDvRhx34gmLZQ?=
 =?us-ascii?Q?5EoqAZyHdfTTDFbjJ2aEPaZvXL8gwH+6C4hoWX+lkMSzmAnYN/kkwp63jaS0?=
 =?us-ascii?Q?t2eHLzQwF2aAsGTp2GQcKasCnlKXXciRaYvEx2TX9dHBLPiexSmYqVszi+j4?=
 =?us-ascii?Q?NhNLBWzsLOjZHXRW/nkV9yTe6ruLlx/3Z/DZ/fal22AoCWT5SBZUlG7+TKCx?=
 =?us-ascii?Q?duhckTo50vEsEa47JC1cgG39Z/rkJk45PNQo1UyNtMJg38sFLfJtzPVY1P0K?=
 =?us-ascii?Q?gbprIlkWXstgEyUvG8p0xZmlNEoLWAEIGrVMZn8F+aPzxuvoKSUgZziNLG4N?=
 =?us-ascii?Q?ATdGLzZqhRHwC3ImaoQCKg1bgARr4SfzMp82wgH5nGHiw490+FqyeuI2MFu7?=
 =?us-ascii?Q?EALTYKb/Pv4O2p0PJq3y3n8OG++9+6lNhCVaKxOSYsGQQHL8e59NICHAKf7O?=
 =?us-ascii?Q?qaD/UUZDbdZLLoxQ2Llak9dEHIVHqm5WJ92CUk2+8uaf26EL1+5fjdtOsRQ8?=
 =?us-ascii?Q?oKHKgBf6txsHxYdIuEg54FYJAKze1pQAymP/LM7lcU0ytTy8Un0Pj5IogdSK?=
 =?us-ascii?Q?0g6JHcT4sqtgLJEpwaqMiDqr8+QspfPXWuC2TzVsV6z0TW0APAF2vThTLWTD?=
 =?us-ascii?Q?c/x7A4pmhaCPqA0Z2dupuS/rac/sRLulfC4gQrigCVWQ2DsMg3BBCuL23+bF?=
 =?us-ascii?Q?mJupQvib89xexf9qxHr9HAagikaH0PgNXvut9vxNdewAzgZHjYflWiSBA9e4?=
 =?us-ascii?Q?1SMv6V8tvWXBOTvQ8reVg0B+idl6eSsJZWayO73lYJQaoCe9faj4pp8zG00Q?=
 =?us-ascii?Q?bL1mAOK3VSEUh4XuM6WD22GDBLgdLji7QyIzF71rBdGJiwLfOO7WtoCb3GDE?=
 =?us-ascii?Q?3KkL/C+ZJYntP6npOw7U+CnXY6f7HAsebLTvPyJYxm3bfypwZZLOknmrKw1T?=
 =?us-ascii?Q?Hg0Othb4EbZa05OWT+VpeDne6TOuf4fcA+2qw2T/OGRf/ajn2yXKWdjOiVcQ?=
 =?us-ascii?Q?4OoqwziKe6mK33qlAnHw+O6bRg3o6R/5ZS254vxk8STVhFPWm6dMGMvtjDM0?=
 =?us-ascii?Q?/ICMfAMFEdQ5FeeyjOwpL81eMZf6vgxeG2x/hEW3/yFqztDGgWLVhwb6yKGI?=
 =?us-ascii?Q?CONLFXc2N1G92rfTrHu23kMgwy+HesTV9WUOHwfGvmuXO9wE9v2lE19Ob7s0?=
 =?us-ascii?Q?Ih8uknKa/74FASz0C531tH8QLTGCeA7hesOBcKz0lVTDTQenM6pbtR29XuGd?=
 =?us-ascii?Q?+cWVEkfZNFF9hNrnzQJ6dIbqGIQwlQrKfxJw7nfB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f5fd62-e4e0-4159-195a-08db0b54ee17
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:52:40.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7lg7e5F1I8/gj28itTGGfC9a/Td3aLsTL0/R62Gpz5q+rIYkMx+OzcZSzO1eJK/ke2yCuVme0h0Z1YHd0rNWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
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
> Sent: Friday, February 10, 2023 4:45 AM
>=20
> On Wed, Feb 08, 2023 at 08:31:45PM -0800, Yi Liu wrote:
> > Today iommufd allocates the kernel-managed hw_pagetabe implicitly
> when
> > device is attached to an IOAS. This links the hw_pagetable to IOPT with=
in
> > IOAS.
> >
> > However, this is not the perfect way. It makes much sense to let
> userspace
> > explicitly request hw_pagtable allocation via iommufd. The reason is ev=
en
> > though the hw_pagetable is kernel-managed, the mappings are feed by
> > userspace. Also, this makes the lifecircle of kernel-managed
> hw_pagetable
> > more clear during usage. This is very important in the usage of nested
> > translation, in which the kernel-managed hw_pagetable would be used as
> the
> > stage-2 hw_pagetable. In such case, both stage-1 and stage-2
> hw_pagetable
> > should be allocated by userspace to ensure the life-circle.
> >
> > This adds an ioctl IOMMU_HWPT_ALLOC for the hw_pagetable allocation.
> For
> > kernel-managed hw_pagetable, userspace should provide an IOAS ID in
> the
> > allocation request.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/device.c          |  11 ++-
> >  drivers/iommu/iommufd/hw_pagetable.c    | 116
> ++++++++++++++++++++++++
> >  drivers/iommu/iommufd/iommufd_private.h |  15 +++
> >  drivers/iommu/iommufd/main.c            |   3 +
> >  include/uapi/linux/iommufd.h            |  48 ++++++++++
> >  5 files changed, 191 insertions(+), 2 deletions(-)
>=20
> This patch and its requirements should all be first in the series. A
> mini series who's only job is to add IOMMU_HWPT_ALLOC
>=20
> Then patches to add IOMMU_HWPT_INVALIDATE
>=20
> Then the vt-d implementation of all this, including the vt-d specific
> changes to the uapi/etc.

Ok. will reorder in next version.

Regards,
Yi Liu
