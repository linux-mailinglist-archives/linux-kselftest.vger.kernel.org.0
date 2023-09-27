Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45F7AFB2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjI0Gh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Gh1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:37:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B4A3;
        Tue, 26 Sep 2023 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695796645; x=1727332645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/31TN7qx05CLWgEifSMQsEsX/mCtprWitliy5hQ806Y=;
  b=YNpiGtQi5e27E96wVrlr6Nz3B8R5Fk+GzhgOt2WRgZqWJYdFQcDtRcIo
   Jjpw+w6DFo/oXdyNAb1t57JDgyjrHXBUGhdIEP8CZ35vVSNFFv+fv04Tp
   1ttjSA40JCAvyOr5KnUXed7X+bvzvoLbT+5ZlLUYVCnHux8kKVwQOZZVD
   bvu99rwh53ypQrt0EeTpnsak1de61OBFpBHr4WoofLxX+meq1NpJWQ7jk
   8dzJ6+d4q3LPGrRI/FZWGPzjcXwSU/4zgeBcJadPPbgw6P5pZGlGtkWmX
   f52dJlDaine5qDv/LEpQD022moFIJy1166t20E6EoFVME65bdrbQgQ8Q/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="468031045"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="468031045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="996050891"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="996050891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:37:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:37:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:37:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xne40dclKGjj2ozLItJNn27TnAf2Mv2Rh6Yhe4RfshqWXMIa7xsBGDdZkYcHqjAlqrvvSSdz8Pb4eAQzFi60Qe90h4xKo+VlhHqjEPCHtxgH+audLUV8ZKAmYLbzieUWpvJMbqEKlH82YPc8nxe8JNKuTmxNiKL/raOmmQXWKrvFfX9HdayDSRoCehE0JWxstQ2yYCiSBiaZommlpptgMCSzPOSg/qLYscYzsFMHYXT/DDMuu4vwaYt3WqQ+IToRXxnZnMeYewQaEi18M8pCMOAqgaeOl4dQtnJmbf5SabttHCQv9Vg2nfayxbQG7UUKUirdczQgJqr+tdkyCqw4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqEQgdxStawluKAa79eqc6IIiUxvgpT6Hih0lAHks8A=;
 b=n+nGsvHOGmoCibN6SlizGFUvlkmTk+dBQ2JdGoa2gdgIheNZiL++RPiFicLH5Rk5PqY0nDQjtUg6szFUBGvtVmJ6Sv8acO9B0Yz2R39/v0FpSnijKgP7/35eW6fbz3JomZhnKbM8vEoSchuXuUFwLvpkfFq7Wq+ZuAwPNvM+XcRjen90i7sCeq6Phl9xFfjgfoJ2ClD/fKopPOlx/3h7Ksm1FTjZ5z86q2o3QTkwUHuueHtBGPxIXkyF6PotLlrD7VPB6BrVX2FoEfjvP85LiArOBmT4MvNzwjrVs7eUFKiWYYBNfzGUpEUEySZUrlBRC4jmh/JdUxnbrJEcY4vVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 06:37:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:37:20 +0000
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v5 04/11] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v5 04/11] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZ7GDwiGb7p1BX5km9r7wlHOUAzbAuPcTA
Date:   Wed, 27 Sep 2023 06:37:20 +0000
Message-ID: <BN9PR11MB5276DD2D6E5690F8FC7B18378CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-5-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8153:EE_
x-ms-office365-filtering-correlation-id: 6a8e315e-ae95-4b69-7af5-08dbbf243321
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjSJ3xvQiO9yzGZhkcERFFiMRExTqzGRnTG5by5YRcKAW7C4TcfoFDhZamSlwn8lgtjgiQvf/lTgFlISghsrikULO0n4oyOQNyK/RzTF6qZwucyovVo/SWPjcyyN95hflc7Y83LELtqxoKc3JZ4g8DsMpzxyTvwmR+jA3MkuR0JCGuNDYD84eOQa0u23kIVIDS/1T7Hvlkhh5JTctMCJfO3x1g+2xSxbkJAJFxL+nrPBO+i/h5thrjOWh525pLgaNloaobVxCbiEIowCg3Xcsn1WP4yV33CLu+XLYw16dMy4OwAN1ffaiG78+9mrnWZ7utPEoP2wZ2cM0HZUpSfR1aRNcYbn8KrdWfxwvvQxUPXsPB+DUywO0Zn1Q2R3NYZd3h9pDQxQJfzInMSOLPG46sEYf/Lo3iM4Uneta7NlBjfAHs/CW0XdhIlbhZMEALMTiKH6egIUlT8Zw5pmFuC4B/n0PklLGWOWdzGVj0VHoYHn6oeTjspWpvL3QOiipWBVNIsROPTzbR6IHLIsYpoPRl7eB30XUaVeHj3RnOuBEjLEfRhw2jchKEMs3I79VTBN20B1gmAdj0n5rcwvRWcjF5vhajDi+59x4UZSbIi1q6BxNMmT2HwrBoXIYKVgHmSSbEn+82f4UofNmtOjP7myBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(66899024)(7696005)(6506007)(55016003)(7416002)(9686003)(5660300002)(2906002)(122000001)(64756008)(41300700001)(316002)(4326008)(8676002)(54906003)(33656002)(8936002)(52536014)(478600001)(86362001)(38100700002)(38070700005)(71200400001)(82960400001)(110136005)(66556008)(66476007)(76116006)(66946007)(66446008)(26005)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?teBUV2tqalnYuzZ9BzO+GMf/DWth2hxoOGZ7Htifm/8L4OtWfP58yFGBL9S0?=
 =?us-ascii?Q?x8o4gkXP4DzooVzTTGEJIC4ngG+awJXxNl1Ak50o6JaAct8YFWrpRhrEsvsx?=
 =?us-ascii?Q?aSnv9cnIDzAHS46/qSqyvvRr9kjNMENTLVCGoY43sZ8Ib+eSAoFV91SSEuTb?=
 =?us-ascii?Q?UsEtODUEdGfanYwCTDNNRoAY21F6rnXHIScVRsqUAx7shaiuEVi/rTKaHESv?=
 =?us-ascii?Q?E5kZCIhKALLjUpHiP2ucj6psAfMOq67j56Pra4zeTifCRDVy8EvIsY2fZF9g?=
 =?us-ascii?Q?QSOA+5qqMa4kjxxKrPb6XcjUkLNmKUvskiHw8sQnqJ6hc3rcpgZKBKd61nvg?=
 =?us-ascii?Q?k5OS/cZIFEz34Bw9PE2goXxPztIpCv3wIDpWl0kpmOIrKeYLd1hVOaigUbq8?=
 =?us-ascii?Q?0OqjoLzmrPKF7QrHfAzM2P97omcDhoYL6ND4i+HZkZ12KiSo9REnWPjW0DkZ?=
 =?us-ascii?Q?d67m7rcO9Fms3uUWXvcRIJK7gQ4i4SJ6u7jjbz+V41CMHeHy7NxjeaJH374C?=
 =?us-ascii?Q?qW9gP00qBGozFOelMoExqAnUtbIsn9UOy6AQ3g+kzxUDXYoAkGEuvZSGR/r0?=
 =?us-ascii?Q?m0ek4nvSEphv6ZjfbGm21+7nJ1nnTJk4dfOgHVUMOFWxtdbb0SFlUXOCV2xW?=
 =?us-ascii?Q?v2Q7SqFg204rg3fD4bpFQm6v8PP7r+fyBEbwGGljs1NfK34C/A67g4HNvIAm?=
 =?us-ascii?Q?Mk0RjP1VnIg3sYDRvOyUYTG4jHD4GV84LT/f4f/5H/adfaQClj1gRMEZS64C?=
 =?us-ascii?Q?DqENjc76zGLdc8I0Tc0NWVcwDO0P71XWmetNZKooH6gBJCaRgoZr6CMA8hx2?=
 =?us-ascii?Q?QmbMgaO1/HsjzEK6eTpaQBvjspnzZ5t3I0Cn3rju0+IwGeETcwz5mRUHmrVi?=
 =?us-ascii?Q?+ZREl8X6/vlIYvrQ7X9hihiWOHpcTPENRxRkTVJPoLdX9lfZTOVdZYkfUoWp?=
 =?us-ascii?Q?uu+hoIdD2S/eYrfXGkm+SAk6fDvZiA28tnsaqa4vKHK0jc4cOqIWqa/a5fY2?=
 =?us-ascii?Q?4LyqbsaHVs/LvZHHtU96bqWF49ht/rE0PetbfHylE9lpvdHMoWMYX/M9lhJf?=
 =?us-ascii?Q?q5sypBHpAiLoyK3sspOSAFJraMzWRTbd9ASNrs79AffGMIuXczDmPSSEJJHI?=
 =?us-ascii?Q?YtVJty7Zqt9RI9lTT8dhSRwIbJavDjZfEMrEMN8JUsfTzLVENvbeBt6XwIlv?=
 =?us-ascii?Q?c8SoNP3ySR/j7iSMliD9kb6uYr3aTbNwqcaTlMUcMElppS30xPX9hIGvk2gK?=
 =?us-ascii?Q?1fZlyZnZkNiHVlM2HmmViG4h0P28IQ79D9+RCFwanPKMs+HHavvKK+vLR1tO?=
 =?us-ascii?Q?7AE//h647ZMFgxl6HPJ7fygqS5cphzr0e1jm1d1jy1Itp82y/536dPQTJOYW?=
 =?us-ascii?Q?QZvx1M8B2colFo+r9X0bFzCUoHkb/1OcPKqrfRv3gACB7VRb8tY+w0tCX/dd?=
 =?us-ascii?Q?S14JCtKkGvQIVyreuRwTAbSGgja79UZjalsLvkhDiGjgpwUWPm2y948EY0oc?=
 =?us-ascii?Q?IaJm/BcodX4sY2Jcjw/GzH6B/eedtcDy2m8aS37tBfQCtBjYOoa1TvGfFzW7?=
 =?us-ascii?Q?ZyNtv64hRx5tMmt3V7hi2/iVArEDrQNLmAZ7ZYB2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8e315e-ae95-4b69-7af5-08dbbf243321
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:37:20.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJ/LYPn8TylvBNi3pSQYdPtK4Jyn9XgLHnrY960d0nGAVgnfB8gpepoQg4VcBJdL46YZ+Ef1GXHrre+hIj2OMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
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
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translatio=
n.
> + * @iommu:      IOMMU which the device belong to
> + * @dev:        Device to be set up for translation
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @domain:     User first-level domain nested on a s2 domain

let's use stage-1/stage-2 consistently

> + *
> + * This is used for nested translation based vIOMMU. e.g. guest IOVA and
> + * guest shared virtual address. In this case, the first-level page tabl=
es
> + * are used for GVA/GIOVA-GPA translation in the guest, the second-level
> + * page tables are used for GPA-HPA translation.

No need to mention guest or vIOMMU. Just stick to the fact of
nested configuration.

> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
> *dev,
> +			     u32 pasid, struct dmar_domain *domain)
> +{
> +	struct iommu_hwpt_vtd_s1 *s1_cfg =3D &domain->s1_cfg;
> +	pgd_t *s1_gpgd =3D (pgd_t *)(uintptr_t)domain->s1_pgtbl;
> +	struct dmar_domain *s2_domain =3D domain->s2_domain;
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	struct dma_pte *pgd =3D s2_domain->pgd;
> +	struct pasid_entry *pte;
> +
> +	if (!ecap_nest(iommu->ecap)) {
> +		pr_err_ratelimited("%s: No nested translation support\n",
> +				   iommu->name);
> +		return -ENODEV;
> +	}

this check has been done when creating the nest_parent s2 and iommufd
shouldn't request a nested setup when the specified s2 is not nest_parent.

If you still want to keep this check then a WARN_ON.

> +
> +	/*
> +	 * Address width should match in two dimensions: CPU vs. IOMMU,
> +	 * guest vs. host.
> +	 */

No 'guest'. Just that the user requested addr width must be supported by
the hardware.

> +	switch (s1_cfg->addr_width) {
> +	case ADDR_WIDTH_4LEVEL:
> +		break;
> +#ifdef CONFIG_X86
> +	case ADDR_WIDTH_5LEVEL:
> +		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
> +		    !cap_fl5lp_support(iommu->cap)) {
> +			dev_err_ratelimited(dev,
> +					    "5-level paging not supported\n");
> +			return -EINVAL;
> +		}
> +		break;

I wonder whether this check is too strict. a nested configuration doesn't
mandate vSVM. e.g. for guest IOVA the s1 page table is not walked by
the CPU. Adding a CPU capability check here doesn't make much sense.

Of course doing so may not cause a problem reality as very likely all
Intel platforms have same 5level support in both CPU/IOMMU. But
code-wise it's still better to do it right.

Ideally the guest will be notified with 5level support only when the CPU
supports it then it's the guest's business to choose the right format to
match the CPU capability. Misconfiguration will be caught by the CPU
virtualization path?

> +#endif
> +	default:
> +		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
> +				    s1_cfg->addr_width);

ditto. use 'stage-1 address width' instead of 'guest'.

> +		return -EINVAL;
> +	}
> +
> +	if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu-
> >ecap)) {
> +		pr_err_ratelimited("No supervisor request support on %s\n",
> +				   iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu-
> >ecap)) {
> +		pr_err_ratelimited("No extended access flag support
> on %s\n",
> +				   iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&iommu->lock);
> +	pte =3D intel_pasid_get_entry(dev, pasid);
> +	if (!pte) {
> +		spin_unlock(&iommu->lock);
> +		return -ENODEV;
> +	}
> +	if (pasid_pte_is_present(pte)) {
> +		spin_unlock(&iommu->lock);
> +		return -EBUSY;
> +	}
> +
> +	pasid_clear_entry(pte);
> +
> +	if (s1_cfg->addr_width =3D=3D ADDR_WIDTH_5LEVEL)
> +		pasid_set_flpm(pte, 1);
> +
> +	pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
> +
> +	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
> +		pasid_set_sre(pte);
> +		if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
> +			pasid_set_wpe(pte);
> +	}
> +
> +	if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
> +		pasid_set_eafe(pte);
> +
> +	if (s2_domain->force_snooping)
> +		pasid_set_pgsnp(pte);
> +
> +	pasid_set_slptr(pte, virt_to_phys(pgd));
> +	pasid_set_fault_enable(pte);
> +	pasid_set_domain_id(pte, did);
> +	pasid_set_address_width(pte, s2_domain->agaw);
> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> +	pasid_set_present(pte);
> +	spin_unlock(&iommu->lock);

All changes within iommu->lock are specific to the device specific
PASID entry. Probably this is one potential cleanup TODO to
use a per-device lock instead.

> +
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +
> +	return 0;
> +}
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 4e9e68c3c388..7906d73f4ded 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -109,6 +109,8 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
>  				   struct device *dev, u32 pasid);
> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
> *dev,
> +			     u32 pasid, struct dmar_domain *domain);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, u32 pasid,
>  				 bool fault_ignore);
> --
> 2.34.1

