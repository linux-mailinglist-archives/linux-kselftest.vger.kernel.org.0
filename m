Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624770EF44
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjEXHWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbjEXHWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:22:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EEA90;
        Wed, 24 May 2023 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684912931; x=1716448931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9juaCixqgxTdLV0+ZvF/0w6ZJtbQtz+KaKTbZinLgvQ=;
  b=UJpFvxwX4S77mgTuEOQi9i7t6p9ixAXtZ8mz4c+dH152hV6j/nesvCpy
   ZVWrE5QnElu3xbewGNjP3qxArEb2M/LV56ASwjKmF8M1php00wvtt8D2U
   ieKWkNnDd9d2CX+wW19Hrz2tMDSut8dMcBX1B6BmsW9soOwtEV+YU9A0T
   pQSB7RR5s2PQUK1yHG1xnLlAuCBoQxia1+yC+WjywV+aQReG6taOR9buC
   RSm8k9CxXTPkK0+GZIfh5mMvzGJL2LBiYp2x3ubiIXOm+H403XoEk0cRM
   XlzI1PjhHBJu6f0Dujt1wRZ1JLrSTV0O2HfYhN83OBFaNT4WWDQ2CQK9j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439835422"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439835422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="816462869"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="816462869"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 24 May 2023 00:22:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:22:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:22:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:22:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:22:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7K/ma2r4ihkixu6EZ0RKNQxvLq2CS1TYzP4yRbiMIrByiL9tCC3VRGwgHUEIgrH/Jn/tWCdd/E1N2+PP89SvUN6JAb9cAs10F8uvNvoAobszti5N/YRVMGRSvA/X52/3xiAN2ghpRLfdAQ7sjrObQBcyrEP3+dfiSUt9tCk59ZcU9/do1XoQi7yzW4CP/ru/oJjywuONnh6mAnxJASFXWscNBbPwuNoD9U0KU8rK0kGGMOVAmiWGvNmGgXP1Vmbp06aTnRFHhpDDUnBXqdwzdx+8RCtYqoAHetkTjZwr/gGwN0oMuiTQceGvpnhqtIjEKlVbMrYQtLwEtHn9rXJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6j1f8UG4/esevdGgUJLrdx4ypl1JiQAsQcGBbT0Ems=;
 b=ErmQU4Cww4Ts+qQQK/vfJsRVb2TTYeIXxNSVD7N9X2vG/79xOoRQsPhI9ejCPA4fq7LyvZrWgsfj1nY4EbVRODT4p16w2QvM44Md8ctUgkAN9tnAT3bfZ8Y2/hHc4aiYRn+5qdYbwm935dCxhEPx8WNig1GWoAus/43504Y4IcXA7MErbwENABwHtGcPuSU7U92NubIaE8uonjhKijwDvK6GIiz2dSpGNsaut47g6OnQVvH6m36ru0aH+jmlnFjxgUN30Uae4Wqsqjw9Lu7AK4/rkXlLH1TWpZ6hXqQ1pdem01mfij/yUZQ7yi9wvC9KF0l9rqeXNN/u2cG5z5fueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:22:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:22:05 +0000
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 06/10] iommu/vt-d: Set the nested domain to a device
Thread-Topic: [PATCH v3 06/10] iommu/vt-d: Set the nested domain to a device
Thread-Index: AQHZhBgPNIRWoP6oD0uqqyIwlq314a9pF0eQ
Date:   Wed, 24 May 2023 07:22:05 +0000
Message-ID: <BN9PR11MB52765BB617AB5611A8B54D328C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-7-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: 99a87da9-1eee-44f9-6074-08db5c27937f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUwDMbcEpCb94N0lsosLWLO9rdpkggH2MivgTO4scWXPny3PxWmEf3/433Coi7FdHLp17vUeiKWlpTvd4uWtdfLMVZFQGdtwMSHBydsXqmSpEMb8z5cp7BJb37oULsh1jslWF0UtSKWgx59CcFj6R6kccH7rpD/wpzVIeQdNI9WQNHi6sR85Hvk2pneLRJJrRlwbP7OYYwuCPPymfsO0kKHdOZ852pnR9ILE82/iylrnOuhl8hIUnsnTIg9Xng7XUM52b62V8aLinYhBx6TZ/xbO9lhabpJKCw4tTah3r49k4lm7UsHl1uWyToKmxFk4w/2o5HxT+pZlOCelcXz5RYzOULPlrSEzlKSWgrVh1LmxJAFKHC1Ga5tNlgVKGjbIaQSJZrbxtcGJ0/w+F3vJNthZvsQPfxOQr5iEqsbUIiIUah6nVaWLIG+go7kREcy4xI0TUPm3V1bpS03FLARPgfhouP0hon5HJzYS65V14n5ycUwxQDWeVwtqDYSY5GpfWme/+qmGB8OB25C7+ednibUJc8BwS+2bFRD2ABnt07hDM7NohzoKfen54MasmFzIYE0YuIYWvd8yt5sEkvbimyQV3tqQgrScX+Icd2uaupiWRsBosBi/QtvzOLOeAt4R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(2906002)(54906003)(110136005)(7416002)(5660300002)(52536014)(8676002)(8936002)(41300700001)(76116006)(66476007)(66446008)(66556008)(66946007)(316002)(64756008)(478600001)(4326008)(71200400001)(33656002)(7696005)(55016003)(83380400001)(9686003)(6506007)(26005)(122000001)(38100700002)(86362001)(186003)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XkWEjh63WS7KGz7gDuzuBJ8Eu+UvRo4XkUAkOTM/yhUpBjKcrefmGvQLNrE?=
 =?us-ascii?Q?9jluklUs8L9ieplFmIhLD6XnpDRS+NZ/Ipg5ayKflEOONoLcALgNxxpjXbe5?=
 =?us-ascii?Q?vKlmgKQrV01RnwXNxoUjWKgv0sRw+I/W2u2Cg+acMuiR5Cvke/lt0j235SGF?=
 =?us-ascii?Q?+SSGBtHtrcIlCMIt5+ETQ4S+5GLcSFlkB6xNfadyEnBme64rbSRuQ//qk3h4?=
 =?us-ascii?Q?d8KyQ3WkMPeNGuQjjNDVaYsE1hG6Ja4QmuLYhhOi3yjnOWbN/aM+FnAtBqEv?=
 =?us-ascii?Q?hN3sYdipMkkEpNGvw8mWxsETDfeSbr1QDyEKmX4HhwAbHr8qv4BZEzmoS+OU?=
 =?us-ascii?Q?h/20hVYgo4R1EmHwvHg1t9gzsM350U0vfhPNRT53UbE37A4EPQtyWPgPdSfK?=
 =?us-ascii?Q?6Su2oKXrHI0s4dnUo4iltETSHfc/HHx6sJZLzEan9fk2DebVXINK6yPX/y3N?=
 =?us-ascii?Q?VMuKDV8R8mlBB3P9EpfVbuiVjspO+YFaBrBFul0PeOyrgjI2nqPsKRhLvn+U?=
 =?us-ascii?Q?Ha1pp6JnrqYXPpZnkpIO1DRFHtt7UU5s88FPNFlc7awONmZrw81EDNkiLgMZ?=
 =?us-ascii?Q?DV1YDYMiE9Y7kqYbp4gLp6OqswawpExl2JWap/322mgoq4uOjGEqSZo3Xl85?=
 =?us-ascii?Q?Du1d/hSayAwpyw5bKOmNFSambe1ab6ZaR4zH+ybN7vsh4XOOBA25pjnYdvub?=
 =?us-ascii?Q?CWVOZRCYEiMYXPOe4JiPNUUfqqtYlfZHrPtkygdULPS0Z/OW1j7WIpurXv0a?=
 =?us-ascii?Q?Lj4v5HSlpgB5OGMtyD/dZl4+bTZ5yNmtdn/Ooc5OEwANcQfHdzVB96zDR0ec?=
 =?us-ascii?Q?38a5yiL66OjYqW1RmxxbOZT4gOxscpNfQeQZC/GGfaThfmlUOH9W6AkBeYxQ?=
 =?us-ascii?Q?bxFpdq/k6Hg/0TAAL2Lml70F+G0KcLAXCbC3zort7l9Ip22jdwbrGhRIVW1x?=
 =?us-ascii?Q?16tRelJNJxqzGGQ4k5ICV/Gs+AdTy/ObWwhbimymgWX3lXfknjD4rJ6fvm6L?=
 =?us-ascii?Q?QFk0P3ycPOKJtLi54J8e1EDNxAV+0RcD6VzzQxvwcQOJtN8CyunTzqbv1yWA?=
 =?us-ascii?Q?2tTUUWZ0L1STUz1lmGLmlJG2CNveA7A36ED5LWWhXsCrsoWFLwCwQs1X8Vym?=
 =?us-ascii?Q?rIIo8SfGaokxur0APl0PUMcpFKvZFWZ+/zAZ/6ksUbHj2y0kU3Zh7yJAlUfd?=
 =?us-ascii?Q?TXsYNVSx5sP24FDADAcHzZYUdjiITXyU3j2z+GgoLILHYiGnef1k6deodpiJ?=
 =?us-ascii?Q?Yl0o+oGhNdt4piwxhWr21u8bIujbiMj2JtvzmsgavlpJXA6GyqLeb/Jzj/RD?=
 =?us-ascii?Q?Ow1GgqL97BBVpq40NuBJWo/36tlaVTwhY1xrTYHYAOluzsDfcw52w3Dafyl/?=
 =?us-ascii?Q?2IZyhRvwQVO2WyKsdskVgSxAvzIZvRT5EB7ajYU7KG62R60bjdUCzRkHT3UD?=
 =?us-ascii?Q?9+NxzuLOa8PdGzavnk6WzN38HH7GhZXF7M+Y+yAQDrnNeK/2IgGn/shW1Sf7?=
 =?us-ascii?Q?mdRAxIqBbMi6zZJO2XDk7IlqLX6YEOpm9CCTvRO9IuvD56PPffNDFKiV9Rnl?=
 =?us-ascii?Q?S0vdygOAHTXJxGKbinvWTKH6DXnyf1FUXG1FQpDH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a87da9-1eee-44f9-6074-08db5c27937f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:22:05.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMzEszU+Yc4O5QFeTfT2JLsOYHPXdQeA51o3Byci+uG2QW5pkaIVo6gpdlA7faqgiZ7I76N/FpeMjcXP4MUszg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
>=20
> +
> +static int intel_nested_attach_dev(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (info->domain)
> +		device_block_translation(dev);
> +
> +	/* Is s2_domain compatible with this IOMMU? */
> +	ret =3D prepare_domain_attach_device(&dmar_domain->s2_domain-
> >domain, dev);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
> +		return ret;
> +	}

this also includes logic to trim higher page levels:

	/*
	 * Knock out extra levels of page tables if necessary
	 */
	while (iommu->agaw < dmar_domain->agaw) {
		struct dma_pte *pte;

		pte =3D dmar_domain->pgd;
		if (dma_pte_present(pte)) {
			dmar_domain->pgd =3D phys_to_virt(dma_pte_addr(pte));
			free_pgtable_page(pte);
		}
		dmar_domain->agaw--;
	}

What's the background of doing such truncation instead of simply
failing the request?

In any means it's probably fine before the domain includes any mapping
but really unreasonable to apply it to an existing s2 when it's used as
a parent.

