Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1270EFBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjEXHpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjEXHpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:45:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1391;
        Wed, 24 May 2023 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684914298; x=1716450298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=krFLkK1i5DTqs2wxDrK9/zUXO021C+SH6hgSBp172mk=;
  b=cG+i/lMFo9ttpL/Hm8M5t19RrpuleF+0N9XuM77FSeBZ1c16OCHUuxxl
   4WICf6sWcpc4COjoPYSm9122mI13A5hEZMGdqpP3RPM04XjxU3j1YnBO3
   3fVyaY9ZVqij9vM+crBi5y5tVyw0E3geKceahgWcQCYlN3tG/nOM3NFgo
   ucFj6Fz3mfc+zztEyncxsJ9FUMxyhZWb5j6cXFSPvQan0qH92yVq34NQP
   to+JQBBAGlQhtI2Lt87pdIx+QwLI5pNfFORWK2NU8+uYNLokhlXsJiybs
   QNjiysVEydJmji40RRoQO+sM3kwWnLuASn/eHRnsqJO05Bws37Kx3XS4y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355845042"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="355845042"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707396678"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="707396678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2023 00:44:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:44:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:44:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:44:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4CVhiqtfFsH4uNssHWVbE4hautddTdAESfVQU0MCtviKHGKQADKTv2GLWWQ7ysBe4lXytAw38TkGwVmZr8Ew1lX6sjBmib2lzFzcVaioyGJvFSyM2whHn/VjoFeMwDMhuFhcmQ3u5+Qeiest2t60NDmWXPHwDnjzVPil7nyl0bcJnypivj7sqe8R9vokru1JocQitmRT5UiBsg6o0KH7t8sK56YPmbsd5YnUp3++1RGiIGQD1xVTgY7utRzOc1aVVgVJEpwKKw9ALW1nEBBZMhHYutVtA5oCEa/6ALBREhiU0rlznnu5l4vJAq7k3alu/HHlhemJeTRu8NskZXEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su3zlrTMX2tabpiZmrEaQOmPZRumi81l1MSiaMquDP8=;
 b=dv/XuWqO2sTeC74e2wUjkCnxDfgTIhO13gk89dgYqh3jt+z90IYeFfuHcwEowWhr1zVc1UIt6MLQYe180obxHAFWBdN+YhLGz2myUUBYiKOdxTEqJI2Kx86R0H0pg6w9UsmZQncE0G/ErmU7GLfHW/kfmWkDi3gHNm/UnlaZrshisShUp2CLvHW2gExxK8nkmtKoD1kId082gcjqY3tqnwubxcndF4RSWVpZ+5++/quX+BZwqnLj8SBA68C1ky5gRlGdEQnv1JiQUMovzDexA8IPBnY8EDca4J8JVjKG7ibT1304v+0NMS1ZqRhO8EiCHTMzmnAhth8L0qhh7yKXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:44:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:44:54 +0000
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
Subject: RE: [PATCH v3 10/10] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Topic: [PATCH v3 10/10] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Index: AQHZhBgSYJ72BBeg/EuD31moJcjTo69pHH+Q
Date:   Wed, 24 May 2023 07:44:54 +0000
Message-ID: <BN9PR11MB527673E35A8C123648997A238C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-11-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5406:EE_
x-ms-office365-filtering-correlation-id: 4aa04d42-6b93-4d3b-85ef-08db5c2ac3e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OQL37vjIPY/twyqNWszWl7lXHr0WCdL6Aqyl+QbW2DE5TyLjUz64NhDxBGT8nnROWtZ9Ms8nXHzuP30ybnuMLBGqETv/kkN0hjjcYwoEqFGF+9BVgpmzv92gapS70+VybYzhK9gbpuUkOlz69Nn/d3eXwzllEhyoXhMNxUB1qALq9wur2f4jEjROopzqLzvFP9Qxga7mOpUTm48pE6AedXvZEy7GBHcUIEwSY3bhTkTdfU4zRwvDv0FmlMRGL324e5QBMhheFJakFrq3YCwHHkiV7HvlRI5hr6p5Bt0oEssWlITHqnj3aO3jbbg2rXm1P4JRywvfLrQyH+VG+NJBIMATqnhLsnlDzbOsjC4gRt0ZKh99vCamNshk9NtCytXyz+Jorsf7pqQRl4gpRbz0A8tK7ZTNBCHt6O+W9211hqEbKUlorquBCnf726I4FfmndcU0n8jpzzgMH7FGspAxRmRnS1pUV2iytdbbuRc94/jgIWz1F/5QCc9G2aockg2uXiPM7svnNL7DGLAKGPYymD/5o+Qvsn+g6uN0sHluQMWVl+dyP0P5H7Ck7yuUNO/Ik9vl974JWwOS4QAVvVeMFvXql1bkCjIkZGphEUyGuRqSRgeFmQ4mjgXE1VZqilJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(71200400001)(7416002)(8676002)(8936002)(5660300002)(55016003)(52536014)(26005)(186003)(9686003)(6506007)(41300700001)(33656002)(83380400001)(38100700002)(38070700005)(82960400001)(110136005)(54906003)(122000001)(66946007)(86362001)(478600001)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(4326008)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eyaCp6xmotwMZ3+x1WdFQ/4XFelhgTsKd8U/y/hRVmvC8AOIJWyknnUHPVzJ?=
 =?us-ascii?Q?wQdffA7WI309uM5b+ixEUXxcL9pmgKab4e/iEBcN4/LetrXXkz5h4DGQ6c1W?=
 =?us-ascii?Q?G9Bo8DHvDxepp0VBPuOZsSYBuS65xYDZ5RjQ9jfUP9fS4/5caacyhKZaimmL?=
 =?us-ascii?Q?nDkbKpcjepuETpI3ngWQc6x00rl+jwzNXj7uCXAKjIcNKYvhkAvRToWIwawY?=
 =?us-ascii?Q?sjOVwQKpKENPMgTVHizKFKW4KSsF2j7U0GdtTv0a19UDRJB+U+VXZflpVD+v?=
 =?us-ascii?Q?nzn0g1HQ9zB65ryJX6tc2rLo0YvvqcBo6OH0vGyNZd/6bop6z+QHMsRmWt83?=
 =?us-ascii?Q?MmyU2yXM2L7LX5ouJjGsIwJqx1wpJI8ReH2ElQJhyxroj2bSAnZ+vL21oiQZ?=
 =?us-ascii?Q?tLXcYMnBZhUot2lSj5asOraVv39Pt5K7hhD5tBh89j8e3u9/YH91Sbp2Ymgo?=
 =?us-ascii?Q?1GDGJr8tqCQyVcEoRU/L/T3Tep5bnmDp0TASJy5YPwn3CGwCwre7I4k26TfV?=
 =?us-ascii?Q?D9BcWjhMMr1hzFtLFFXAGNoP6cUx0h4yfmbUfK8IkyJYY7trTvu1JOv7+mg4?=
 =?us-ascii?Q?Fswp6NDqOjAB5Lcubr7hMv2aEGslo4HiAmxt9pGZePqHMuUSPVDAjyQE7OY9?=
 =?us-ascii?Q?WfxjfFhglFXdI/WQRahC8TuKk/CMUKRDroa9v0H0N3u1ZgvNwnZlVfGG+xqq?=
 =?us-ascii?Q?9T7cPLF+p15WIOGtknzpe+xKGzXYARilC8sR/msIrFANIuf4S4SiE0DrE7NF?=
 =?us-ascii?Q?36sUOj6sI67l/lrWOqiGRqg1dFETzn3PkrkGgm+tmUNVUmCu+5BafV8SQUbf?=
 =?us-ascii?Q?U9ORjTwMgaVN5qYyCXVtjmRwmC3+Q9xjyFyTA7dM4JlyReqdMXon0jlzlKKE?=
 =?us-ascii?Q?EEZ1UuHzX3z68aG/D5zN0tNZIMvNrFjDVKkt7lN3P7gL9FwyY3jIvnp4vjAS?=
 =?us-ascii?Q?KHgRPN3lF55wXQBPvagKv/31UoYHUuAui/ZW5dauByK+kiD06wCjtAcIdHuw?=
 =?us-ascii?Q?O5PgeVgYf15BF1y5JqEBD/qo9WQmXEbfdkc53BiiNYQ4R9KLgjioyXztKAal?=
 =?us-ascii?Q?RA7cmYjNFTliOJKl7xVSVf9sxf21t5MAY++XpHA3Rx99fO9kNk+Sx5+Ql7e4?=
 =?us-ascii?Q?QdPp9MRWWsC9FO67MvpcvVeosfNXYb9F+ch+1iab3cp230QoWP0J4xI4xaoQ?=
 =?us-ascii?Q?+i7jtqGIvd1Hm9hJ9hk9w7W32rV+6/UX900dz/lvpTYYZ1uMM3jMUGgia6cy?=
 =?us-ascii?Q?uS0fP36NKq6GGeliVkdbIQzUVSqglJ2vwozRHuj8Yx4BlZ/FAloKKltKUYxw?=
 =?us-ascii?Q?Ysy7MDIm9mcQcRsKUuJ608q1n/jFP+AlVY8mRJ5e2FGtWhotv6a5451XYNS/?=
 =?us-ascii?Q?j+zC3I15GzGW4j78rgYuo+mwiHhm9tfpXaFsCP1Ybk/ry9YensndSnqLCHTL?=
 =?us-ascii?Q?DtIPDQD3DyPWWR4P4WbbTFX3iKpuFnBZfiY1tQYqPhouSGhETpcIGPso2H0J?=
 =?us-ascii?Q?eTNZQ0UGYEzlnZBDmdxYrgvST8vlFUlMzCSjLgOjIdqc8PAtmzKFr93r9jqK?=
 =?us-ascii?Q?teGZs6OSmowchAqjpTIRKhAt4xd83cZla2npYMD7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa04d42-6b93-4d3b-85ef-08db5c2ac3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:44:54.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0i/hEd8deqmvMj/vwbqFjPTreNkCuM2sNpTYWVimiyHCrXChEnfP7ZiJHltVtCNvOhoU86wQfB3rVSszB4uJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> When remapping hardware is configured by system software in scalable
> mode
> as Nested (PGTT=3D011b) and with PWSNP field Set in the PASID-table-entry=
,
> it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled=
)
> in first-stage page-table entries even when second-stage mappings indicat=
e
> that corresponding first-stage page-table is Read-Only.
>=20
> As the result, contents of pages designated by VMM as Read-Only can be
> modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
> address translation process due to DMAs issued by Guest.
>=20
> Disallow the nested translation when there are read-only pages in the
> corresponding second-stage mappings. And, no read-only pages are allowed
> to be configured in the second-stage table of a nested translation.
> For the latter, an alternative is to disallow read-only mappings in
> any stage-2 domain as long as it's ever been used as a parent. In this
> way, we can simply replace the user counter with a flag.
>=20
> In concept if the user understands this errata and does expect to
> enable nested translation it should never install any RO mapping
> in stage-2 in the entire VM life cycle."

IMHO the alternative is reasonable and simpler. If the user decides to
enable nesting it should keep the nesting-friendly configuration static
since whether nesting is enabled on a device is according to viommu
configuration (i.e. whether the guest attaches the device to identity
domain or non-identity domain) and it's not good to break the nesting
setup just because the host inadvertently adds a RO mapping to s2 in
the middle between guest is detached/put back to identity domain
and then re-attach to an unmanaged domain.
>=20
> +	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
> +		spin_lock_irqsave(&domain->lock, flags);
> +		if (domain->nested_users > 0) {
> +			spin_unlock_irqrestore(&domain->lock, flags);
> +			return -EINVAL;
> +		}
> +

this is worth a one-off warning. Same in the other path.
