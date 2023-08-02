Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BD76C63A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHBHOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjHBHOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:14:41 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1317171B;
        Wed,  2 Aug 2023 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690960480; x=1722496480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lS3kHUFeY0TOcC60Zx1hZ+1vyoLvS9anLC9CMcjiook=;
  b=UEtYVGhrTUbALrCBUsl/2KE/rNfqzT2YxetUUS00mJLcEsW+6FVHYuen
   Kq+acqsdYTSafnO0GWfVti6jFoXXk+XHtHGlrtXv444elCTtBg4q2qRq9
   lxOZXwQwoPUIoCa+vqNsZl3NpHFlazU5dpprWGXkfL66qDw53WjcRhXg9
   x4jgS/8XM5llHYiZbT5zhOGs7AyJT72kCTYaRUKAFzY8AIwWVhY1BkzR5
   sjZF2VQojYYOskQxlJFHaSOKRGZcG8Blw9reJBOfbBdGwSQk5EfhbGZ8M
   x2JLuQRJSnh+XqVhebo5VgefqrqAJ+alvY1FCLIppJGR4WVOsNatqYJBa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359543854"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359543854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902885440"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="902885440"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2023 00:14:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:14:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:14:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iafa0dX89oA01OjBaYHnDqGcR8tgwP/nzQc6+qtwA0ffEi5JW1j2NaITdYUQZTJahYkfjAYHtiMxrDjWtByeGO42IwGvchovn6rjK2W+31AutaiPHXVVkK0sQUc47OElmprOSExMGnynhcZjGJ84Gs3+e//yXtTeneHTx3WoOutaLoT6o9rA7WRlI4eXDEt1FQX/m64VUviesJH+3F2SoLuvmtNN/7qvoqQsBzSa7ITDUmJSh/e8Rq2HujpxGGVcEs+a5QBC/yY4Dr6bKI8mJp+7B5zSRXoplUKS/utc1/tj3N5gUyObcfi4AFhDpya9WK2PCPnmaNIvzuTcYLHANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS3kHUFeY0TOcC60Zx1hZ+1vyoLvS9anLC9CMcjiook=;
 b=YAes5uW57m9y9IICEUN5OFL9WLdMHbZiNGWZhCwnqzAchrcSbItFtT97U6K+WeWKd203JlwESCJaV3UNTbRTiHI1VF0KZdlSHJodaTfdO5B9ZSRGNWaP282qhByIreLKfxPfhI0BFEeM0OEjz9ViRNN90iUCodCt79MlEupxuqK9+w6/sRo3tP3Icz0BjWmnMaQz5mxdh4rdG2W35jOG78z7TWZmfy2G8XMKZwDBo4TUkrvKrjZWDAHrqCfT04XWzgzKU6LexYmYWWlAowpWnxGvKaWqP+E3G6AqB9ieA6P7aNwQWZCP1+nxdXoPpVEEX2JkDMq3OEN/9xVTz2xb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:14:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:14:32 +0000
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
Subject: RE: [PATCH v4 05/12] iommu/vt-d: Make domain attach helpers to be
 extern
Thread-Topic: [PATCH v4 05/12] iommu/vt-d: Make domain attach helpers to be
 extern
Thread-Index: AQHZvh/tubvyvmhzcE+QO2lxzvGUh6/WpZ6A
Date:   Wed, 2 Aug 2023 07:14:32 +0000
Message-ID: <BN9PR11MB52763B6D86022024A5A91BC48C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-6-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: ae290ab6-6329-48da-64f2-08db93281e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kjt2eFRuW5gQGtAWBeZ3YFXgW/eEGVwGuoHMoL2z/xsb7Lme2ZbLktElPMIYUhb0HCs5FuUiYgiA/dEhDqjHCBdUH+uqoYvavcjRp0WZylx23I8JaAVcFDSd+/p44k0EjqUhsnFQMRQxCAZ7PzQuPFmYEpJncpLS47NU47Zhac/1EsyqyXnxwPEyjez/8YS29RfpHjTZ+O2AzEgfcDni5UpdhoQAcprbYY/8/WC5y4ov40gf0d1x+WJE+bFLnsrnk3OWJwmG1v8a0bdB9JgDQQ02wibHJ5CH59q9/wKCDV+Y84fWuI9EmKlHmRlTengXv4YkwcpSl7OQGbjX4vK1qM5uSSuxDO5ykJ1fPHXk1w17rSG8mnZ6Go56doxuyMhMCkzTG+xZVkhOXm2jjRxHSF/ysMqwFv0efSfGmdDZ27TchfZnIltuWirJIcm9D0ZId+5XgsmKad9qBANDb6CQQOKg0GWmAtHZW2Lsxrqjnx0jj0LBRAzs8U+0gBmIiG06aDM9r31aU1/P4ySfPN3dYK1wWqVXBpBDkKcA7zaKBEO2Lezo1AySgdCphVMmfI4KaS84aIbyn5Zd5/maaz+O4wSLQbZ+FqvasS7zecilfEI6C9APbaVx8lxuLJkoivnz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(64756008)(66446008)(66556008)(66476007)(4326008)(52536014)(66946007)(76116006)(2906002)(38100700002)(122000001)(82960400001)(186003)(6506007)(26005)(38070700005)(7416002)(110136005)(54906003)(55016003)(86362001)(558084003)(33656002)(478600001)(9686003)(71200400001)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qPrXFnNJdlbeN78D+/vbxR8J5wgatfZ2bNH0f132h94LmPA4CXgauUkbni82?=
 =?us-ascii?Q?bl6W4yXCspFCbNtfpppKKsasSB9RKtS4DoU4IzFA9AJ7BSotpa5UGWzN4PbV?=
 =?us-ascii?Q?vkagqZzr/xWGAkb/kTy6egzIuB/wyh9k2wejCKzW8/RWbsSvW8R5C2uP9C0A?=
 =?us-ascii?Q?8NsF/x//q38u3P0kjMEsDWPKIjOlWj7xG5QIkRFnzGdBHmNalrpD4L9mNTS2?=
 =?us-ascii?Q?8Lb2jmhELRyFPNsr7nmk4aiV9A8HFvmrJ5iKikOGzyaxnI0ilhWu5tqXAeEh?=
 =?us-ascii?Q?tgNytrbwh5xCOUEWZv0SjestQGYCjkDU/CJByboYWJdNT4frPCjiaflniXeP?=
 =?us-ascii?Q?9E/spZeAck3F+/C1t0P6N/nxYbh939aH5Gixlr8Zz06J52gVuPqCpkxRqDGg?=
 =?us-ascii?Q?Q5KBTBtayLqWM/JWLdPdUnnpV/qmEl2ZOalMu8N5E6XflmbHTcHzwAXlp2vY?=
 =?us-ascii?Q?K3E6EvzQqfmVzjMNkDatFSzkvO+kPKHR10Am43nu67aMP5dZBOqXJiIf9nZS?=
 =?us-ascii?Q?n7TMWJbSTp4e1fKao/kRD/KEhNZze36a/QYdS4sL1cw7vRKrpLM8ehvOcPve?=
 =?us-ascii?Q?QqpdXd48HvgAvfS97kqaMG5UpIXlihYTF8hFRGtjyiHqB1QbcQTJhL1NBpqc?=
 =?us-ascii?Q?MzkgPX6bbi8wDPM5uTJwbeDZkqUva6bUHyU7LWQTaJ2ei/xg9eLdOuaKqHiK?=
 =?us-ascii?Q?O/my4JbYUdD547Oop9qycTirfcH6WhTYo6sS5X82WSaFKWcmfpqGH3cSBgUs?=
 =?us-ascii?Q?lHQfeOEwOLYwkN1xU+hvGqfA1Kxwbs7QOKKyWs8eeTEEAd57H8AqIyPd7Qa2?=
 =?us-ascii?Q?QBCXIWu1InHHSF3mJY4cwYoYoY0CpTEzLJuN2f0BgY9AMXHE1uX7PUhQ2JcO?=
 =?us-ascii?Q?Ln0ph+KN4wFW7+UXhlOW2Ku/uRW/n1D1QkMeau4toe6bgEJkVCPXmaGI9LKJ?=
 =?us-ascii?Q?XrogebdoOhO63oMaK2w+Yyto8EMJvmjc72xAs1QKJoDIv87TzNS7/E0GzIGH?=
 =?us-ascii?Q?k6muN+qZ3vsKE+fyo5aBPpW49SC3EItenNu4bA6HBOL4acbeVe3BQzkLeZUA?=
 =?us-ascii?Q?iJoe51ts0YrxLe4RRaSeT8OM4KFA4kacJWxBNtoKPaJ4AIh6WXi0VWw5GC7u?=
 =?us-ascii?Q?dRW8O0V+gpy2wg1GS7pYLPNGl74frthJ3wbB6qQYAfNIWc/UF9q9fS4c1qcO?=
 =?us-ascii?Q?7fIhAunQjHEyToyaTw8Acm7+f47aikjrk9uYR5zCWdCzFJL2sok/3ogAIK7A?=
 =?us-ascii?Q?AmLKop+36RIHbUvtiueSm9bqqmVKy9bFXGujwHfIlh+3xYktNoW1qKhEIJha?=
 =?us-ascii?Q?wGEEu7EgOZQMyoGpFFO4htB0/uZ0jtGB3Yy3YPD0Wew2rIh7TAygLv+uUSIB?=
 =?us-ascii?Q?Qyrrh7xsK4hPS2HdIU3jOdtNYNc+7jpWHsVibVtRDyWRiDoVM6IA85oIAo6c?=
 =?us-ascii?Q?vM55uJeU5UG9lwMfzebwPi6gjcW6EvkJJoBmX6oARYXhgutyunhScTlAOwzj?=
 =?us-ascii?Q?1+2MBIG3TqsItBNeTTLDtrezU0USbw6WWO4spwsoAV6WfIYqtB8DeLBCQCRO?=
 =?us-ascii?Q?3S8HeKC2adlmceeP9Ebqdap2EuJk8nOB84p6IOoG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae290ab6-6329-48da-64f2-08db93281e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:14:32.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5vCi+dI/qJY1lJ9JAquG12xPHFq6V+D/dVmdSctcfZZkj9I8EYY/IPRopHZMmXIngHV8TDJVR2edFPa+7BoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
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
> Sent: Monday, July 24, 2023 7:13 PM
>=20
> This makes the helpers visible to nested.c.
>=20
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
