Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7758876C6AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHBHXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHBHWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:22:40 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7C430FD;
        Wed,  2 Aug 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690960949; x=1722496949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7bQ9bMwA6bKLmISGZ+kMfKw4/7LfWilQoQwt8EjUtr8=;
  b=Ywl6ODKP/NF6YECqCKHiWihOcKN0oq/Mm+FbsK2qyBfIq1Ae9eAyzWSd
   EdEazlWaPnZaR26ye6bua5WnyHRZXq86TyajfGErtkcZ4H2QEsOK8o6Ju
   4tbD/+yJV5vUDf7bUi0gDlCfDvqTYb2LDN4UZY/uPxe3MhphmCkugvOw1
   Dt5KM1+sSk2qdc8w0fSMSI/AU/rHfPk5PTwxqxhq43zAYsdir95Lk5gu0
   jLaBw+NM+cZgouAnEcJ/cpd7EjloxqzN8iEfi8WzW+LdIKManRNa3DwcO
   msmkPQuzlkf7GwhIbwIWRXpbb5e98b3c4f5B8NxZbqak76waMlYGnJMh4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368401231"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368401231"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="843027335"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="843027335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2023 00:22:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:22:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:22:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:22:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:22:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTI6j7QVn9wwPPZf1ihnxaOVL4GnawG/buVQp5O4vrvg9B+QXddhn6ORl8Xf8jZ8vVj73bvu1N7Nl4S0LJMi1HtByjn6jwfwAKyvCykyiykbqhSR9e6PEX3JNMQeluA/VhL5eidxLluacChruE0qqRqell7y3JZLE93bV53lvnQ+K8y3K3QKT4zTkTbURk4pksQZkK/kuWG87fIzRKx8nUKgZxBNoGfBsFNsQh50VGZj0sfjQQU+opReFrXhzPzMSoG21EW7qZNXIbrf+AwnqZp33w0mVabrp8vldX0JajgNtwK4vlUECd6xfz8K+dv10E48aGLUdTCUCDh8SMTlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdAvvivL0F7IS30CInt4oN/WD1+7edEM5+SOmOL7vxY=;
 b=Wjtt9JiWgbahjjGqIykueMof7y3VhYHw9nHn3jrGwpLaC386Yp799ExqU9qmwHlWinpPGMBErhzk1z6U86MxQYqg09suLkKXdnyxNHgZYaeKiep0AvGnL04zVdM5712WshTV2gvInqbN24o8b2D3FL2LQNIDGvrVkahafzfcMMSVreSmywoc9U9EH8weDnTPvX/Ibj3Dzr9uMt6+88BjWlC9Z52YkFUXvzu4QHx5iVwicg1F53nQkIDEfrrg6qkpP0BMbCcSGrcNVhkQmuj8haPY2vYfI70akMGgujEvArV/UcZJCPUkcOhn6RYXMptI2qL3SZIi4TgumUL76Bw9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 2 Aug
 2023 07:22:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:22:19 +0000
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
Subject: RE: [PATCH v4 06/12] iommu/vt-d: Set the nested domain to a device
Thread-Topic: [PATCH v4 06/12] iommu/vt-d: Set the nested domain to a device
Thread-Index: AQHZvh/ts7qREuoIFUOhjQ3keq2Bhq/Wpp6Q
Date:   Wed, 2 Aug 2023 07:22:19 +0000
Message-ID: <BN9PR11MB527652A8EB70FF1FEB0E74308C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-7-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8404:EE_
x-ms-office365-filtering-correlation-id: 7251a0cd-a959-4391-4a10-08db932934b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pW0fabRE7NBTS4I8BRydfzhy7F6QLyuoz386gfsz4TvRIu7hOsqeK+RRGcq3wWwoIWTFZT8V/waHp4Wic73jUifXieNOV/SOfwladcP2cjF39+/eYWFXp7YgteaLJZKQw6aNdmWakYcIFTTGnr5B8G8ZntCsunPBEPXzZG30lq5e7VegW8UT46Aexn9bqd996aa7SN2uIfeTop8DH32LGyMiW6W4kgeuzk1iuvf6BtAVTh7gKh5IoN8u5u7+Ts/jZYi+7PnHzspyHXJ4pVO74T5qD3+F2S8z6bLN1Ka0w2uQVMrrOYLQ5AHwaSK9GIMaOHRE/Zvf6Mv6Crl5sxiSD/sXm4QeQnYLfJv+/P/+cfnPW+EnqKO6r5FRHzsLzd4izkFBX64Qyx+g4On5LD9fjOkMC/I7gU/shcBW+Eg7cr7Cd/K0VwPD+9R9GSMyFADn6VQ45Z0ohcfNhpXcNeVtWwKzFa4BMLF8kw5vysgzSD0TwzL3VvzOGu9bBIOqfyVDc0voF8xCRwCrVfCuCc9M3rK7PU7tjkrP0c84bPy3njJYeulilW1n5cNPdTJnmxRZ7sHfqC5qJQvJ448AmgB9EkDITahdkwJitSciUmJiwjJ/TztgLI2ZLq9jugf9uWip
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(66476007)(86362001)(316002)(66446008)(8936002)(64756008)(4326008)(8676002)(5660300002)(54906003)(122000001)(7416002)(82960400001)(66556008)(52536014)(76116006)(66946007)(110136005)(38070700005)(41300700001)(478600001)(38100700002)(2906002)(71200400001)(33656002)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQLIanfnow2VMlBDT26UKawYTRgw9ymc+ba5o4O+FPJfFS44KPeawYZkcit4?=
 =?us-ascii?Q?q4gHvHYegmcsqFZuDaZSKOhkuANukhoN0wvhfSwdv9GDRE+Z3V/htiqA16dM?=
 =?us-ascii?Q?G4AWtF0AlryfC+xfn9HWuGpWO4MLP+n2Vxx7C8qz2DGhn7DUd8ykr4M1K0Hc?=
 =?us-ascii?Q?1LbJ/8hxRJq2TTXKl9du7+5kPowPUgtEBs7cVNIfRVn76SlwTTJSGH1k55xm?=
 =?us-ascii?Q?vWYIsCSaqFisxE/fM9K7OWt7CARASXiZPE5HPiPM0aSOYeJ8EqHPxJobf/94?=
 =?us-ascii?Q?0L8W8/0cc0Iev6vfGTvdCJwjIMGI2RDmspZqx/hdRh6lVM0XOpx9QiX5jc0r?=
 =?us-ascii?Q?OuNJijJwK23meYs6MRxN1dp3hSkNILwN1ORArRwrByWW7LJdpxAmirZKhews?=
 =?us-ascii?Q?YjLwMdXq2mZpLOuPCwAhVs9M9p5Ks4vr7zpLe7p4uggr5DKJqEDs3fiR3qlE?=
 =?us-ascii?Q?y2YEw6BYOhaPedEDjzIgu7KvZU3MEBGpEADEvdIyRq0ksmQllvppFOjY+IX4?=
 =?us-ascii?Q?/EDsZyzhJ6KTY+hD36f68quiil7qkZJSniZooWmmuAOS7O8l+A4jhZpFpzfO?=
 =?us-ascii?Q?sfb7N54cFJaRxRbNUNhBQLAc4xlzfTdLYc4e8JVt2QxiZboQ2gEBeo/JzKBw?=
 =?us-ascii?Q?AZV0/H77o3JNXKGIq8P4uxnDhVz0q44PxLjgf1Rzrvy3bfaPU2LqmlVyrnHW?=
 =?us-ascii?Q?2/d8K5DSteB5IFUskQXH/jNpfWhrFXaUIDKS3nBFVDS6IQ3Ra+utN6lEFaWY?=
 =?us-ascii?Q?2bYw7fKtXZ1Q0uDWQeBrQbgtlKANpr/DmUNCQGXKk/OLpVtLS7OwWeRhJAgP?=
 =?us-ascii?Q?oYcVNY39bgvulFy0PfEDxmYH2VA6BRpaW5x+fGlo8IkbnN9/eVVPTNHvIWbk?=
 =?us-ascii?Q?wduViv0+U+NjTluWJGOx+K+KcaDSZRpLJRJI9boRN1dooKJyGgbLCxPc7h1n?=
 =?us-ascii?Q?8yS4ak0yN/ST9t2dfy2Ejg8GkRXjz8bsbMJU4csKuARERxlB9HyxfDcQcduc?=
 =?us-ascii?Q?4xFhC+fkOINqb1W2o7PKZJ0rOUTocwgtmekBFfi1ZzKu3kpFB/34lr0I/IaL?=
 =?us-ascii?Q?2MMWIXdh3/invjJnISaQpY6R5X1O0/8qOQ7c5EyXLiZPkxoGxYwXEUF0J6rI?=
 =?us-ascii?Q?QScYFucKU/L5JQU38OSvN9MiXarSXSru72y8ZKLg32VI3dQGVmZnJO7LEmX0?=
 =?us-ascii?Q?TPiI5C+loVrooRyjy5yg3UyXlOw2qmXlfhdgrLlRy85Caup5woPC3IZt3L/e?=
 =?us-ascii?Q?GlHj5lioxLlGtsopAuI8d004bEqdC3D4fg0Lmsljhb5003L6Ng7T9B8gneZh?=
 =?us-ascii?Q?T2fgU3ON7U5Dk1LqSS5MGl4N7Lp0A18G4Mipc8kdBjjGDDKhvVmpMce57rSZ?=
 =?us-ascii?Q?C2l8ftCBMmPE+yHb96I2L3b5H+kp+jQqt9Q1HcPkWbaf+o3cOJJn9NkmCHXz?=
 =?us-ascii?Q?UwbstnVDnl+7R/njL8VZcwGiyTOl0yh8oUjcwYqcCKL+orP5onpKWRj+/dQQ?=
 =?us-ascii?Q?eVhvr1UkaKjQr3/te8wpJSE7bQA6xI5nEQYNnJa8xJehlThyp//grO+QJLcg?=
 =?us-ascii?Q?VnxGhpE7uDOdY7TMfnfAlFxS+einAoiFCrjyYSxe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7251a0cd-a959-4391-4a10-08db932934b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:22:19.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZPmYjEXSF2JeL/x1TzN5IQNPKNzeTfxCPRBPxyq2uBIpIdDIJ0ZSgiI9jp0dCBDWE+xT/Qln6Sw/2H6K9jkwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:13 PM
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
> +	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
> +		dev_err_ratelimited(dev, "Adjusted guest address width not
> compatible\n");
> +		return -ENODEV;
> +	}

this is the check duplicated with patch04.

> +
> +	ret =3D domain_attach_iommu(dmar_domain, iommu);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to attach domain to
> iommu\n");
> +		return ret;
> +	}
> +

[...]

> +	domain_update_iommu_cap(dmar_domain);

iommu_cap is already updated in domain_attach_iommu().

>=20
>  static const struct iommu_domain_ops intel_nested_domain_ops =3D {
> +	.attach_dev		=3D intel_nested_attach_dev,
>  	.free			=3D intel_nested_domain_free,
> +	.enforce_cache_coherency =3D intel_iommu_enforce_cache_coherency,

this is not required. enforce_cache_coherency() will be called on parent
hwpt when it's being created. patch04 should check parent's force_snooping
to set pgsnp in the pasid entry.

As Jason explained it should be done only for kernel owned page table.
