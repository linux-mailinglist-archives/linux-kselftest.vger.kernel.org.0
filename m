Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C96617605
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKCFLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCFLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 01:11:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291821144F;
        Wed,  2 Nov 2022 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667452270; x=1698988270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=amTEqRG159+BSOOk/e2T8yE1Pxpirp/8unbTC7Ugxu4=;
  b=XiPFluNCYLEPco5RJYAIihXAacKwuzs1ty9QWVOa96l0Hs28TKgVVkG1
   CWU3zgl58nYq3xtLbX2j9z75qDEPgQD0Xg0hCmra7ksLVmT4pVKFJMiph
   furP5XbSZPJWK/Z8VZixMQh67/wymcGomZVfjpgBMapJc3Vf7e4OwIEwI
   WTmb1BlU3joGTRXCOnbfXhTIyDe/xOnHmX3NDoa5Y2kFZpmpxa9Mccewd
   YfKfyPbsopWbvAX4q8pY0nRMJDiIovA99uKB1S3zvfjB7mmIQLo13T7yO
   Zz61XSuF/GsOZ2D7HjivdR997sjjcRcmeNpn4ZaLuQFH2ARROFaiDYSLQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310702059"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310702059"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 22:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="703535137"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="703535137"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2022 22:11:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 22:11:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 22:11:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 22:11:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 22:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyKjIh8f42tl2a3jQ58x9+fikmMBSm5RQQKCzDMvFnAFPOlU/1K0SXkBH0N+1OHcvDgs4rS3ClOrULMHdsWc4wkVSmuH9gPt8wlFOOcJrbAuHYHKHivaRHzKXb3zc60YO2AiERCjYWZ/DWSixZA3FHzfbkA0L6i+XC5VKVJFgegWtWxK1czoLgvJHx4nJVxVK74zIuKNE3XERczpO5sujZkmZRnc8vnjINohHiZ5RfO2ffubdihRP3qaU8CGjLCYgwUBgNoHjIxDnX7JHflzd3eg2qjNbsFE44MYalYF/0sU/CuKys0FDH3IOfdKGPyjSALsUo0ELy209dp2Q2yqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRsJBBzpeS/BKqkqx/6EOsRbvxL5c+XdPuK+QgCrpXg=;
 b=eJHWpMPFqHwkC5xyIMBn0XyKGP8yGLmcOSHE9EKjsP7MLiGdcJehLddi2MgWvmSnIR/hsc3stMBWVdLLMn4Yi+vUrxw77oP0U10kMQVxPy3xGKQf0Ki+UevimxRhdAvoLCGRlUf5w3huoewvhxJjOaaFitrg0Pu7jsds3iHihATH6lMsFU3lqPPxDP8uukrlNvYreXg/aQQ/qCnxnSVHwwoFyLEoiAJBfWEpq77Hd+LayS5Tw0C2KzBrxRJt256UI2g1nQ6RuBvOkCdchPu14y6tz0pWa0uDRApnQNoAma/fMXB3bB4lZ32ovBPnE0kGHDX3X+0fB26FvJfTzD0QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 05:11:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 05:11:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 02/15] iommu: Add device-centric DMA ownership
 interfaces
Thread-Topic: [PATCH v3 02/15] iommu: Add device-centric DMA ownership
 interfaces
Thread-Index: AQHY6J1lQ6YMQqbaVUKcRZgYCAOWmK4sseLQ
Date:   Thu, 3 Nov 2022 05:11:00 +0000
Message-ID: <BN9PR11MB52762C2E65492270AE58FE268C389@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <2-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <2-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 6494c13c-e07a-4061-f92d-08dabd59cca0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8pV1dqHAWxke+ikHZiu6EzU0fWcb7nUeqJzp9w+0AXKk0L6pLuYpS3UXtIuMJSrF+SK9oVupbBj22/LWE4FbckWCnHKpBDVCNztpKMB+zPeNK2UWpVUoquscghR+ttTew8vqXXhmcnT2aqYOb+gQNe+sH0xx5sNg07U8hiDvo2uRqnRuUOQORdq8Mp+5jpcsRWjuEI0+pBhsddCR05F4GZXRuzgp7nTq/q+FtN8X8mQchYxNp4weO0+VrpotDMyjInVMra8ApLWGofmiTpbm0kXvhfB5xrPMUS8LyKkqiUgUxiK7NhF9gqdwJNmX3UnXFCSlwwryaRgdf340QQMsFuLz0adSvDaorcUIeA0vCOCSAHqX565vNbIlSwMCMfV8t3Rx0eiBWTmoWoRARBQqKG33GVP3IXsgBujkPHIPbK2GkmvZA9oQb1PppNBvjCWxA6dTYdVchTyUF/zzAbFkCMnvyr3y9UTw0nQP2eV53Rir+u8tI8ZnnAZnsB0H/8raj2uojBVqTzURMA2jfRzFd+6oNRns5RrGQ5Zv4oxCClJiWOXqDfRYfHNDeLDI83Lccm+7Absk23TAqRYFtr296c/fAmkzr6+6EdyjEYXlqodN/a5rkSIwFceJqZlui2l/FooVXmBNz95eehLGWPSMyhJUEKKAS+k0S+McFOrtCrV7B9yVJq5OpPc19yCu8mpXa0huRuQ5URIn3Bq/gsRdpyDjH4vxIVNzPHleCUm6+uE3AHDqHi+HdU0mT7yUSqZMj1ZUfJbLATsMqbqqXOeNdnsDVO5tsY25tW1Zo1T2jE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(4326008)(316002)(110136005)(9686003)(52536014)(71200400001)(186003)(64756008)(6506007)(66446008)(66476007)(8676002)(7696005)(66946007)(2906002)(76116006)(54906003)(7406005)(26005)(478600001)(7416002)(8936002)(5660300002)(86362001)(66556008)(38070700005)(82960400001)(41300700001)(921005)(83380400001)(38100700002)(33656002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5WRD2J4QmssQBMEw+cmmN/rEmKwULpgIMVfXc4iFFO2NdTN0EsH0MKGHxO03?=
 =?us-ascii?Q?GptBi5/XsoEVu80QI5fx9uaQuTZXPkFfvPnSySQUp7+Mw/CBKiNhrzB7UG+H?=
 =?us-ascii?Q?e8lrQPePO4elC+lW56khTrqBOUdyrXvtk69LALIfBLMdZ0nDW3B7c84T1ggc?=
 =?us-ascii?Q?XN3ODenzTneDuxgoZOapvT5TmRMa/wZfDnQoxpPmiFMLWMnThvfc8RlqzusG?=
 =?us-ascii?Q?RAmNiJSlDsFsluHr4wgx63aYJeZoaPYGID0xl+eAV8ro/HrXxoAN6n4aEkSu?=
 =?us-ascii?Q?d/HPFhOPuUJd4nnCAbN7h/nsj58DXt5WtURJ44uh3wNz4+9+wCNtkCvIp9Ew?=
 =?us-ascii?Q?s4MrKyIKBYsGBp0sKsQrSzZrroFRHTH5S86hCoIDdJihlWLNI67pcj1ipKDs?=
 =?us-ascii?Q?8kT2fltu4EJO+FYf3QNbfr5AN5kR1NapMUEiG3LjUeK8v5dy+EAaiW7cFCY5?=
 =?us-ascii?Q?H5e57g+34eTfn5wERDv0kB9JY1TurHyNccwxsQdzIU7TLgNdlDfSSR3y3OhL?=
 =?us-ascii?Q?z6wPjB25wRZM5NlVyugmWcbDV7eBYhfBhzpB//arcRQ9b1zAx+OY3yDPAm0p?=
 =?us-ascii?Q?FDmRBVWDvieBJocvCV63kxZDCYPxFUWkl7tFgKQpJkNtKX3hYqdRiZIcTUAw?=
 =?us-ascii?Q?WaZ4A3/Eks5r5i6jNlLvdeVS+QG9rBNjBwQXsDcFTz0+pjLSmUe6F4CLtQeq?=
 =?us-ascii?Q?Y23akq8O+k9dg2VTSCGzGWD7Uo9EYGq2z3DdIPCnnvR63ZkvCb3+4Vi6S9EJ?=
 =?us-ascii?Q?Rw1zt5JFVWFYm3phBfzhXMQZIlxyfXofvhj06jAUd4VG3iQu4IvNQj5max/t?=
 =?us-ascii?Q?7MQ4Pj/kjAycB5M+z6ZjlJE8936iJj+2cQIyxjfDR5APvi7Fqt/lcolbcjNs?=
 =?us-ascii?Q?T6Kcnj6PDh6pOlGTlYTd5KIgb36v3joZG5HEChfKs5aLmaQ+DRlpdPajXmmM?=
 =?us-ascii?Q?x1ERJbDZcrLVHYYL/Ye37eUTztqxinPbvLTEV2O2dN+EcpFSU84wydSLx35d?=
 =?us-ascii?Q?6VeECpSF8cCsEj7NEbTGvmFMcg4wRaoMz3AZ1iZgb1pLejpQKnbiCS/W/x7u?=
 =?us-ascii?Q?WhSAJfPmM1KhprHGT7XFRLlk0jmMFbBq7y/94vztQmx96ftl1atF+i+pjh1V?=
 =?us-ascii?Q?GJgLyInCikIL+Pc4A+1J5bIEQTYG4uHVuCLQYdPI8/4/2ejGZZO9XcgGYiKf?=
 =?us-ascii?Q?oulI7jCLQgwa1YF+bcIJvqXxxAUM5sNN1xUKdHSfISpPEaPfTm5GvmSa8ebI?=
 =?us-ascii?Q?GsZLsoc3RGiEcsKhNnZdC3734nJ/Qmu4oa1rVcFqL81xCbdjF3rW6arX4OOX?=
 =?us-ascii?Q?yL0UwvPS1gdo3STqjanq0WVdsqgaUhL2LtohHYZReL/2pRv6y56aZT/Et3zb?=
 =?us-ascii?Q?V5bIEHh3vFjKgsLDVNpBtYcMkttvNLr0/AuzDzK8MiIaLpkpxvxIN+UnNaJQ?=
 =?us-ascii?Q?F+RYN1hBE/zENadeJxMnNp/ursEetK4v1CrYzmHtY+Mjt8Yo9ZHyhQWjOpzl?=
 =?us-ascii?Q?BTkF4enNX+eP1vmnNkSxtO6T65QS18sRblNDHOT/acQaqLQk5GtKtqO4P24d?=
 =?us-ascii?Q?gXAMoAAJlibp2ymBiN6UMZnpSLjVIf+apMbhuHoN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6494c13c-e07a-4061-f92d-08dabd59cca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:11:00.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0O1Z/XVmn+SEqdIfbcSMQpEMAs3crgDnd6tIN9gvtGageH1zn1jZPgPdP9lWEFP5f1E2cFJDx20lJIHIxjsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> These complement the group interfaces and are for use by VFIO. The main

s/VFIO/iommufd/

> difference is that multiple devices in the same group can all share the
> ownership by passing the same ownership pointer.
>=20
> Move the common code into shared functions.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 116 +++++++++++++++++++++++++++++++++-------
> --
>  include/linux/iommu.h |  13 +++++
>  2 files changed, 104 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 65a3b3d886dc00..e34dde68ae2b0d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3148,14 +3148,33 @@ static int
> __iommu_group_alloc_blocking_domain(struct iommu_group *group)
>  	return 0;
>  }
>=20
> +static int __iommu_take_dma_ownership(struct iommu_group *group, void
> *owner)
> +{
> +	int ret;
> +
> +	if (group->domain && group->domain !=3D group->default_domain)
> +		return  -EBUSY;

remove the space before -EBUSY

> +int iommu_device_claim_dma_owner(struct device *dev, void *owner)
>  {
> -	int ret;
> +	struct iommu_group *group =3D iommu_group_get(dev);
> +	int ret =3D 0;
> +
> +	if (!group)
> +		return -ENODEV;
>=20
>  	mutex_lock(&group->mutex);
> -	if (WARN_ON(!group->owner_cnt || !group->owner))
> +	if (group->owner_cnt) {
> +		if (group->owner !=3D owner) {
> +			ret =3D -EPERM;
> +			goto unlock_out;
> +		}

check owner!=3DNULL otherwise this call may inadvertently succeed
if the caller assigns a NULL owner while the group has already been
grabbed by a kernel driver.

