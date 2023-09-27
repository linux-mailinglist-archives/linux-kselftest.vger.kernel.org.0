Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A397AFB51
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjI0Gqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0Gqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:46:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3EA3;
        Tue, 26 Sep 2023 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695797189; x=1727333189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SKToQjhVlfnCUN//lguS8jpQWJwh6bZ6TquJgnfHMo8=;
  b=gS3qxB/7osdNoMxJ6Zu0YnWbKcK40dwNZFnRfADHrslsU0Ng6uLQKDny
   kdtWvHhAWsSvFJcnf2KICZJOJBS6GkQzE3j2/LeVseEPN/kTrCNx+lMb4
   nGTR1DYHwKnuTF3rWZitPS7mr8a5nCe/gYEMZ/J4ATg8tEO+7L3bw5YhW
   1HAVnSAsHCPulWlb9KTtd7V5fFhRbjrq5+eKDjIdv3eQYnPl9uGTjCWx7
   a6qlit1TP6CijyhTwxl5wfOGPRXCTpJTnqc4NFtpCLKY2wzfRqlDO9U0p
   8j/UmVVUXCJILoMNGA3hTjYR4uHzSzPJ2gFxQpnWLCil+52mbty2C75UJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385602548"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385602548"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752461393"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752461393"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:46:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:46:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:46:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d86gkKH7foXbROzAlwNEJb5mm0DAll1PoxwojALFWyFXsBJqIJYZmXhcIADLl0I+twmP+1DgftR9YqSWmnxzp37U0D3VZTFEb8RWC1llmHut1s0/MhN3Gc0D+xZmBe1/IMBQhGZg4dJv8d3vf1/BmuyLEZMqsGGp4ByvT7RwENEnLoxj8vrv/OMgnXuN9PRi9ZCRnkYTTHUpPCsgtdZEimBQH3vKNtE4GH+Hkxtpproghp69a+2UvhwJhgGP9EQpHjggK0XWQYoAzInQ5HY5OzX4AY1xhpHi8wNAPlLUELaPSjqVUUFi0NerEeB8a0PLbmSU4sFYb5I/FLgXI8ZrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3rE5ri6zjoVoN6oDeHOpbws5nxTnMhwjBozOXATDLg=;
 b=F8W7huHYP4kin+35SsqYWiQ7vJtC4QXzYIidBy3eIUR66rhWnbGdJ32RAdmT9/RbE0EoiqrSXI4ye2Gx+tja0ERDXVwpmuf8Et35YCHygxjmPRhHFh7TA6ee/fjVrT2VKBvq5SZLJCiiVq1jm2GhgypdgnnnJ/1dIUJuOUYsfcDB6ur5DI+sXIiwsPB0tTh/F1tdwwtG8Xgr9dy06XD1r0Ub2fGbQZ7NVJ6dAZywW80cdef6eef+c8cLdaKBaD6wOKp64s51xI2NtihMv45fnv+I3MDoXcFmsOPDAQiHQTmV0ai7URFvV8/gOenXQkeemNKS6UxAi81Q0P8t4a11/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7976.namprd11.prod.outlook.com (2603:10b6:806:2ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:46:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:46:23 +0000
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
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v5 07/11] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v5 07/11] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHZ7GDu37ctDRm8jEeyC19NQT1n7bAuQvxg
Date:   Wed, 27 Sep 2023 06:46:23 +0000
Message-ID: <BN9PR11MB52767E1D31F05A9622BC00938CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-8-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7976:EE_
x-ms-office365-filtering-correlation-id: 517a5a06-3a77-47ba-1acc-08dbbf2576d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AK15DhcSvByjip1H1uObBvF3MgyfR9cTjsA1DHpEvZx4MbJLfrlSNRGh42oALpcM2D0YfTc4IWgGyI0y7bcHA5fOuw0wvROIaG3IaDtI50UWygztIP6+FwhP5zlkKkPqtOqYfTH2OI5WWlSyKRRctYt2DeSNHI6/RUHGhd2mqsoRBjrzcBWePywjo9oFP+UMi2WZMs7wvLxSnzHKsG9YvaH3Vdp2ZYi5PdeA9OrkkwBAfSiMN8t9ozgsiBvCXQd/MgrHUQHFeUrFQnIXHn6yJgN4iogXOi2Xfdu7QcPQLUsw6SwhZudmSqa4j3RTZgnz8+cLkEMJe452vuH2L61/uMqNWtHIIjX9wB/cmU723coBr3jIo3bSh6aSsvpRp9HFKhSvcK7WmhOcYL3YF59ERj8y89TsZHJQii067HxpwlV4sc+aVoDL8zwdx2TjvT6Kw6Ts52PhdCC9AQl1DQOmJBMJMxlMCHZrKcSnnHd6gI4goCcfFKQ48+0BPBzQEmZtnnF509XkerlO4ZYjxNj0DJSQWrM5w+8jttIrbpBrdWjGzBmyQQkivnpHE2+MQrUXkr7lWC8AVb3LpygvAq4qwv8R9Sc0gtqI5072Pxh5VbvZdOV3cE+um1gsIHN+2DmR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(7416002)(52536014)(83380400001)(66946007)(54906003)(2906002)(55016003)(41300700001)(5660300002)(4326008)(316002)(8676002)(8936002)(64756008)(66556008)(66476007)(86362001)(76116006)(110136005)(66446008)(6506007)(7696005)(9686003)(26005)(82960400001)(71200400001)(33656002)(38070700005)(38100700002)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OG/Q3aQOGaIBdY+jUYA6Yo3CwAgdkE+BhkKFGkZF4j/f3KAkXXhsEM2aYfWh?=
 =?us-ascii?Q?iQSvtpKupEz0fEaJdcljI7Isfh9HLzuQVT11BIFYvDFoO5EaSg5ITdBQxf8B?=
 =?us-ascii?Q?IM908pLndlebla1LYbCldWbWW9QuWBLGlg7C9K6sR+oaqdBCbAPJRQ/yJzT2?=
 =?us-ascii?Q?TGS/dOdQbKiSYklLwA1BTq2/FY+uvnwtdpAK8XpzzT3cOtE401XrfbZOwZEM?=
 =?us-ascii?Q?Dj8CmL5Vjo7LDeFeA6FZGoRayZw8RaMwRInk64mo7NhsMIsZ1/O4dOBiHUeZ?=
 =?us-ascii?Q?gxpH63d/TSKyY2p4Jnaro5vBbi/6nYRnzJCLlMhaXVX35/lN5V5M5aV2d5KT?=
 =?us-ascii?Q?S+vru+S5v7mtEet6RPHlR9tILjeKN9Pzs3VCYEgSBZbS5E3vNRaQSNO7tobj?=
 =?us-ascii?Q?tZIay1TzqY3nalvTr6sgSLdZjSvBz40p8rWdARyAG7B5IGc4Vuq71sdEU+vm?=
 =?us-ascii?Q?VoX5flr1GF1Es68AJ01588rntbr/23/7hK/IrrDIk+z7LWdnE6x4rKCjwxA6?=
 =?us-ascii?Q?Pg/LGCGyFoy+4Uzsrhh2eG5G5NikRlJD4WfyJ9rhC4imwXJ14jhItFdOnp1S?=
 =?us-ascii?Q?YrUoig7CptSMRGEZ+LpKEpNNj48JFQBNG1JFhAGFwjyBdkx4Hm5FW2a6Coki?=
 =?us-ascii?Q?XhJj7AgCMckBGKDQu0k6YQATCaFkVZSo/iL+eN9BksPvmz/4uNWkZXNhxszF?=
 =?us-ascii?Q?DkWyfqgDWRVMq3PF33Q6o+TkChq41L+HBysBBjzRgXNFBC2ryv2Y0Vj04zXU?=
 =?us-ascii?Q?OUFBvYyTZ5PfXC2CPtfSDBN9pidELpBkrgKa++dMNtv5O4sKRQTuJ7dM21v1?=
 =?us-ascii?Q?wNR1ZlXfNchzwfb3+bkREkr6W/4Xy0UUnJtayUXh9BrCNKb089gtI/aw6qHX?=
 =?us-ascii?Q?dECw2KwH1vnxatDq/uiXj2flSW7UekzDQuoBNgvEXExAdTbavDSs4cigJkKY?=
 =?us-ascii?Q?7ADl8VNG1VhPoBOALnaQkZ06IIHWcs0xMd/Iy6l+uj1hkQkxTTp6VWkBRi/h?=
 =?us-ascii?Q?olmXw+U/t8+6NYUYkvmqSEeNyIr1yA0wBKWKGNNR1kPEZYEL99O3f3BSUt9+?=
 =?us-ascii?Q?3iaL4IBD1egIUQY3lMdgXy+9aZKzbyTCPZIC4+tMhnRtoPgJEeriZzVIE84/?=
 =?us-ascii?Q?BPo5YYSLs8tPrcroLi6PsPEv2MVsRaIpGmvZAhvlGXHW9iN8EEH3W0jheVGC?=
 =?us-ascii?Q?kmPnaRI+067+/TIUF+D029PhVPuq/FhD6FbwCgE8xnItMRHxuVdZalP/7CdH?=
 =?us-ascii?Q?LgVXmGbJZg0lMfFzoX1AMkX+pD5p3h3FMEFxQt1T55lnCbGzTUJrDEu4fx7E?=
 =?us-ascii?Q?LLVb9ioxFykvUW+GzE54j6Xj1NFoglU29axti0GJ/4f6Zp0oWpcHbeyh+5PL?=
 =?us-ascii?Q?8ogrm/Ks6MbQsXOgMc1ecVx7mpdoEGoeNX65NGnCK1hYrG+ddr6U+8LlK84q?=
 =?us-ascii?Q?Cpp/yMfnGLKzTexOM62DiveaUqx8xGlQVrYqLssCfPW3UgK0QK0kY4xNlkak?=
 =?us-ascii?Q?ZyO1BdbBqdnVpGFEB6uHzqVkYdVgxT2jdHuitTZVTp9sfRPCL6awf4zjnbL0?=
 =?us-ascii?Q?e/oo65Dcpo3NQhbqLduZthSgopXm8dwV2ryXw5QY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517a5a06-3a77-47ba-1acc-08dbbf2576d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:46:23.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJs6+fNfTyogoKWEH4cK9nZhVbv68Kg5dspUl+D6zFeljaNEeH8m/2kWh7WDO21lFeody3Dlt70FrzZkwzPztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:54 PM
>=20
> +/**
> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
> + *                                           stage-1 cache invalidation
> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
> + *                           leaf PTE caching needs to be invalidated
> + *                           and other paging structure caches can be
> + *                           preserved.
> + */
> +enum iommu_hwpt_vtd_s1_invalidate_flags {
> +	IOMMU_VTD_QI_FLAGS_LEAF =3D 1 << 0,
> +};

QI is iommu driver internal term.

let's use IOMMU_VTD_INV_FLAGS_LEAF here.

> +
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> + * @addr: The start address of the addresses to be invalidated.
> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 ca=
che
> + * invalidation under nested translation. Userspace uses this structure =
to

s/under/in/

> + * tell host about the impacted caches after modifying the stage-1 page
> table.

"to tell the impacted cache scope..."

> + *
> + * Invalidating all the caches related to the page table by setting @add=
r
> + * to be 0 and @npages to be __aligned_u64(-1).

This should also call out that device TLB is also invalidated by this reque=
st
if ATS is enabled on the device.
