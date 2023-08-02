Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4776C7BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjHBIAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBIAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 04:00:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA41BE;
        Wed,  2 Aug 2023 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690963196; x=1722499196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=giGuHtZJAm5TX32Em94MFKJ/A3VAUq85/qhV90+B+BE=;
  b=Btic43IY0ElGMoNjwzdsYVd+t9E6kEp7Lx+GUm39Bjgu9vuua9yrj9CD
   fpL8YaVU0u5MUzqOTEMMw2JzTA9oAJ0VgupMcSLNBuKKewvAnImvAp0kb
   KyWS7y8SxEcltavk1HsiL554JSyZlsPrBlxvb7tjHNL3LsOrQicQnBJth
   ccfp1OQuMxalkl5enOqTAwaWYYKI4uinhK+MpNd/T2R1nf0IX+ND2+8Vc
   Ofd7rTy7dPY23f/BTcN65pPmIJcuwqFgYoUZi8K6S/PydGv0/hvt7Yxed
   byLPbbvj5sRPNSCb25af475epl0CgDX/FGx64//aI+iGcZ35xE8UVCa3e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400457018"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400457018"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852791189"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852791189"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 00:59:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:59:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:59:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:59:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:59:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULCoVK5a5F4LxIMEsp72e9XMo2S5Lk4aAffvzpQ8Jv5KL1PKXfMUdcxhbxDy504kG7QQlKq4RoXsuzIcD3cl8vaVqitywMcyYKs3qOVME1gaQSz3UzaU7k4F9avvKlsvc/CmvrzSCDoPd85bSp7HBBZdVp4KcC8EEWA8p5JYDoqpIPmRzSTYLr6/A8phidCbMlAv4iixYk7KtCSD/sJ36XqPhqH1OgsXycBHYgaRg2NkWV144tWWcds6UkrK0AZ35AdovBLkvryHg4xA0eqiu/O7HcJ5FB8vFwC1AQhSKznM1//xfEjV0PxYpehrhiqo34cCTi4h803By0JQS5u+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqTPJQqQk/lofFiJ6bQUKxnEE4OXYthBy6fVbjR0dSw=;
 b=bkejjt84ahWsTcaz9rr8qQ6ECrkY48B3n93V499B/muTzLOhZ3sSF+UXyDpdoXQtpyDsYKRLfrEXEUX03FGhsxosO5O5074bwIcxPCI/BDpQYGrA0kEfzQxCQGbVN7WyA+2nHvQEfT/fED1gFSugEWsmQPsORnRSvzFka3y2VcRbaRLOv0/L0cukh7Kv3fvHwJmNehJTpw+le597ztmIdnPvFRbqyZORYcjJKrzh4Y4gBTnOPwMh052mr4I0NcLRsAUJKDZcVwqPbOcv/SOYQONltqL/UIpvqZ/RV4nJ7BdNqpVcENmAX9wW81bVODjzfzPa8Wz5ZoUXURe45ABZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:59:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:59:52 +0000
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
Subject: RE: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Topic: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Thread-Index: AQHZvh/xpJ4WurReCk6xBF9LLfi+N6/Wr/7A
Date:   Wed, 2 Aug 2023 07:59:52 +0000
Message-ID: <BN9PR11MB52767DF0C8F25AB893B38B678C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-13-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-13-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5774:EE_
x-ms-office365-filtering-correlation-id: 0945a300-09ab-4d51-e351-08db932e73a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g848N5KJzwzj3oe3ZSiJ4VLGuLqaSEm5eKowXZhJGfpE9gHFwvCwwjOldR8t38I0+4OH1pcxRPR8ReO4pRKra39Kc/FPOg8P/7sd4+o2TKnWtLRsGTut4fzbY7R2u62ZY3y/+JsdH3M30uzwweDQl3SSNH86XpE+MfjEMaUO5viNult/8NeBNyNNRNocpRBvZnCUOmuOR8C2O/kY9uJwWYY97vgbZDjJdr6uxLd//FQvG0FxCk1A6jh0ertWG9zxpZCjyNC6vDrX1bP4N4D1e014OF/AEa6X6UFPdFML56ipOGMIgKqgCPfbZjJ87vzAtO7blZGev78X8wENqoXLnTnYyN0bSbmKo2cxJewVQpL7PyYca13RRV8PJ+w64jNnZ5qXUmD8BVIHRrEFmhpZaZg0JirM6YCkpn1Zg14U8Tui0Tsqhpg1J5OhMTePXXXBHcIChGyFbtjGVMW6xbt+PvLYPBnWgHRGluUZ/QAWAcyDKbRhD6jnWdZANofG6hoKeCidvFqeq87+TLIHewx7PBZygkQHTL6RdmPMHqH2pV3WstYNcAQcNEf4tO/0bRPQTx7dfcX3h4GralpWZN8dfXkvC6mi5J4AmX6U+vgro5HyhORmgZaMXQsJqXHNqGAi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(110136005)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(64756008)(7696005)(4326008)(82960400001)(6506007)(41300700001)(26005)(52536014)(8676002)(5660300002)(8936002)(2906002)(38070700005)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3g5ZDavB7Mv2obZYQVC+lkTy3xJqW8UvWZyBQm7FUfwZiTKt8mM0UuewmeNN?=
 =?us-ascii?Q?VFluyW+xVEZClA1YXitTQ8OBRxTZ+IAfav2j/p6kjDXO8TiX4PxyWz15tHFa?=
 =?us-ascii?Q?gGWbPcz2yOwW5SVRrKJJ3U18ClVFNvJ5nnOnpMzTBXY/mMMq2XRSJUouATpB?=
 =?us-ascii?Q?ZE0ZnidPXIrijysvvrDn/LMcn+gZx+oF66oNhMgKFmh4FKpqOHMf83BCaY//?=
 =?us-ascii?Q?IhdzZQ1xjfULc/1P29KM2SwbaPEqUjdWYzUBc+rIa8XGC/rKa2gnc/ouXZVP?=
 =?us-ascii?Q?HyzNuR1pcxJRB2BgzXNhrazHsG1gQQtNbVyGFucTmR+Cr8LSSfgbnRiUVD0p?=
 =?us-ascii?Q?dKJ+jqYPpv+kjQIM8+Rn9DT40F4/COQeyTnd9ARZ4b4jpEMgn2e74Phjnmr9?=
 =?us-ascii?Q?LuffQjVzNFHt+A3XEhcxRLzxMeDQ5rnX8R66NS4VGrVHuo4FUeMg2VTumBXE?=
 =?us-ascii?Q?X6KYjq/dzEk5YRo4Cg4uPiuEik08M+IFOFSyuIoRByCcvOlyF5BHiv93R1C7?=
 =?us-ascii?Q?o0VPWYVU+fxxmKgUZiyzJxtthhfT/DryHNwZTUVOu8jwcW5fI05WGU6hkCKd?=
 =?us-ascii?Q?i9oGt29pxYSR58zYrVPEkA0AenRk4sJUxSfsVAtJjBM+DrLJ/MUejna/Y2j0?=
 =?us-ascii?Q?NjE0QaAMihcC3qDwJQFPzR5FbXus1+Xl/WK9Byg2+sQ3S8/P5VavIq/Eo/rv?=
 =?us-ascii?Q?evzi4Pg68DjH92V8sDJt/xcxC5O5z91du8P1ZJBhE/nSVXMjLR7Ag1D+hSZ3?=
 =?us-ascii?Q?sXWa0e5FpXgIxmIT1DMW70Q3uk1nLhjWTF5+laPOW3xgqH8d6/g7yXgwcmj2?=
 =?us-ascii?Q?LGXjD7wctscRgCWzyJBZo587xNMLwhbOvX76TJgXi4mKs0jBSH1oHLigyP0j?=
 =?us-ascii?Q?QgfNT+Nmw9V9c/2wTHvRekesKW/N3d9mi/BkwdK3Vh1zPO6tf2mUbd6zwjXs?=
 =?us-ascii?Q?gOya8qUi5zruGspXWJ03hisi5cdOR8455rC98AE4m8JEhC9T1jWlZxCN8750?=
 =?us-ascii?Q?776nG405lNrnrvbJyO4wbgPK5nIV57pmTP+KG1HZ6mGDcKOW/xXDIHKZy/kt?=
 =?us-ascii?Q?ozERyKiA9p1FSGMqC6eWX82EQlVVOG3abUyflE39umDbnU+rOT0U9BvM1uGI?=
 =?us-ascii?Q?yrh7dUoD7xcdDu2vtQ6UOwq5rQf0Yg+Td7SYr09B0PzH0isVMKsJV4G2fjy2?=
 =?us-ascii?Q?42Ww/UdTbkxqxn854GPricVFpbDyAOKToVdogJlnC7uzlBu/tWPMzyeZtOiL?=
 =?us-ascii?Q?a/B64D3fYrUe1n1hDnUHYOuHUUHFvNbKyM/oiPznTzM96SDl/JdMnaRL8UkN?=
 =?us-ascii?Q?xqzeEcgKV0xgCbz4eRPIoU/gEauXs7l/q9t0yeymm4oNg35M6igINvDOUQ3N?=
 =?us-ascii?Q?yRN84Jq9rtq38anfyLnI/i4f2oZry/FNItjmROLoefpv/GBB9lI6suLDyXig?=
 =?us-ascii?Q?Tjg2q9BBy+mbSl60jjo3/mo1L9zL5hSHzP62DV21FymvEcXumxPdINg7gyJe?=
 =?us-ascii?Q?HgupELX9dE5ggFGVRB2W0s2WhYgBQz+8odIY1VeIaMu52liNpZqOBBUHEQBk?=
 =?us-ascii?Q?C4CqlIaf8xvvZQV/rl2hH44ey/Wpw/YN7ETAxZ6N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0945a300-09ab-4d51-e351-08db932e73a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:59:52.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0VUUDkwwEf55Povpx07EUJkjLDf3AmIB1fH/Ry9dOPn/bFlU8kE9mG5pfx7w1mYIYWtq9hc8zOwoc/NR7qLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:14 PM
>
> @@ -2147,6 +2148,18 @@ __domain_mapping(struct dmar_domain
> *domain, unsigned long iov_pfn,
>  	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) =3D=3D 0)
>  		return -EINVAL;
>=20
> +	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
> +		spin_lock_irqsave(&domain->lock, flags);
> +		if (domain->set_nested) {
> +			pr_err_ratelimited("No read-only mapping
> permitted\n");

"Read-only mapping is disallowed on the domain which serves as the
parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)"

> +	u8 read_only_mapped:1;		/* domain has mappings with
> read-only
> +					 * permission.
> +					 */
> +	u8 set_nested:1;		/* has other domains nested on it */

what about "is_parent"?

>=20
> +	spin_lock_irqsave(&s2_dmar_domain->lock, flags);
> +	if (s2_dmar_domain->read_only_mapped) {
> +		spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
> +		pr_err_ratelimited("S2 domain has read-only mappings\n");

"Nested configuration is disallowed when the stage-2 domain already
has read-only mappings, due to HW errata (ERRATA_772415_SPR17)"

