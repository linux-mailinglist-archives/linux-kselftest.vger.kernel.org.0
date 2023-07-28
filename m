Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87BB766916
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjG1Jid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjG1Ji3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:38:29 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00F30F7;
        Fri, 28 Jul 2023 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690537104; x=1722073104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z46yyzYPye1GIWHST36FRkDGkXGeBxvpe/w5T4a/ZXw=;
  b=CvjpkKkwmLBKJzIbaSyrnUggVzhSmKf9C75FyCwXq0F0UOjYfn1T4z6x
   XQHwdbUAyDdje0iQkmD3OUN9+F3d2q5H63oNWzfSbEJmPpLbXKWaGcBnc
   93Up2uJt37csNkGuRE86zzyAhzOkcaipO/78+pTWhGCy6FyrbqCE06v05
   e/FC9NDovDJ1DePMc0xvRgjQ3syPDValyFoo8Ssw3UL8aaGYTIpz9zaTh
   1JPU4uyRoFpyQHuXxhEQ+LbKDZF650DZ0EP1rjQsDnebOqYKxZiLWKTEB
   bkwtarMfhLJ3gOibB5ieyfmSC/tbzWZsXKK+qc+IsIQrh5F4LMwAMwOy6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358579573"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="358579573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757105459"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="757105459"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 02:38:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:38:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 02:38:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 02:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG0CZZKXKAAXr5vNoTeh/YsMpJSr8asAf8ir8bA4/75zyetrzkJXsVh3TehL9idE/OOVYRywlg+GA4sdtMb8o0HzRwXiBSLTQCbRe0p01k5AglGsqNv74whNXYk8IgXV2DUQct8a6eoew8q2PsjNVX8y5p1xV3u5j6TUunr7GtGL7F4QSRQ/gY4rtpPqQFHfJ1bSB7BI0Q+muz0+iW6QUhSkos4huDR+KZbZo6VMt6f3MeHWvpOVUQrZSZ3MUWYaYC3E9SzMRdKNrfVBjYEtxcVvhIzz4nlmdwOPKS4TvBQYPQSlzSJ6xRlnxB0YQL+UT51YOYWoENybVEWUlN/OzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z46yyzYPye1GIWHST36FRkDGkXGeBxvpe/w5T4a/ZXw=;
 b=YcSDtFd5jwQrq+VYItCOYFOd7SOHIk56x0APdKzfa7RHB2WUaTVQ7eAHxTq54TLEVAowW9xnI6QQTDerxDhMKk60eikPozmS7ib1dDDuHje5RTr6k4OQYDxikuJ4c4kDtSnPlMlwhlM9Y5MHleRhoULTYuGOoAsZ4PkOce8aGXpkVgTlr+WuGIMiMNVqW6YoNLNKzUaYlBLZWm6Xljid6tG754jF1I3mQyL/BTpbXoU1BEs6RNKT+/qJvhi683sYDs/sB9iQkrq63ADl/8x9qlqgzqHCjZ0Lg4KxBQP6d1n4Q33ohaMLseswovdiv16epD+vWaTr4Y1Sme1CWT2+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:38:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:38:16 +0000
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
Subject: RE: [PATCH v3 02/17] iommu: Add nested domain support
Thread-Topic: [PATCH v3 02/17] iommu: Add nested domain support
Thread-Index: AQHZvh6gjmB8RSMR3Ey3hKIm/iaBtK/O8iQA
Date:   Fri, 28 Jul 2023 09:38:16 +0000
Message-ID: <BN9PR11MB527607416A209EFC19AC32478C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-3-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 7e3db10e-d324-45b3-d8e4-08db8f4e5ef8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3BLpUytK45iyS6W5wl6qG1Wzqst1RyT0AEflQQ0PCg464ha7KyjekHB3Y1sMvtd8kxakNjjFfTBa87tXkIhCPK7mlS5sliOGObQZcJN7WQcNBTJAdbv+etS21fxL6Q1JJ6iKGUQonwts3PdSJveLo1YwSRrOStYmdy5gHAxEGH7OWSwNW5d0LkyMttYTlBJsTGp8g66nuyAGaiI9qHAClOPbBkFaTcqtj8G6Q8KTIhoLCdyAgoZgnqL44GbCheAU9lKtmZEW39QfsUuxTYrdP4yuRgupul0RtaWybt4oDrgQCaJHtkQjOwitdXAHD8nWRVXLZVBv2UhtYzjuCpQnCx0F99uVZUMxD4y5G7xpObjKe9S2Zrv7j2zHMidR4Wws2WGMn5zKRYEOY0U4qYAdS2txN6/TnmNw4cT+mpa2S4kfUm2IIXusFRrEtcpKUqBIIO9o+9HZO//PdBjWACyWNmpC9DOoHtMYNPjdo6tAetMg+EvyTHPzL8pBL19cpQxB8132VT+SWmHIZ/maPHCA+FqdLeByZfB6bLV+7vZcFY4RoHyrJ42YObIQr6zSwvEL2NK5DFSDWhJx8RN5XPUze/wJgTiQcb6GnuEAavUZdW9WT/1aeqEZpgIyxzkU3Wt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(110136005)(54906003)(82960400001)(26005)(478600001)(6506007)(186003)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F7l6H7Nd1UaXL67Ci9eVsfyBQYv2epCUQ7zG0zQctBsp1sAT+wL4MDEVo1PN?=
 =?us-ascii?Q?OoRz+A4DpX3OYcw+wOO8zqhfezMlz0D6MbWRiRbiK+6boLBUPvxyA+msHKZV?=
 =?us-ascii?Q?lfb04dUnsDLIVSTV5dTFvakHZPgm+P1Kn1uwJK2pMCLu2glXLdN/MoyACv6v?=
 =?us-ascii?Q?onAEkIMi6aekci65IEjIAMlFN9lIqeEHditfiJUXb2+c78P0RuYPJst5JRlF?=
 =?us-ascii?Q?i1n4Y4YPyN8njTrt9mg7aaghMU6oVmg3wg/TV1qlubF2Kp2jB+qgfmJV5KT9?=
 =?us-ascii?Q?Nr7PCIViyJbwn/dclQVKJBUqFXXbZHmnrwSKsBYa2Ifkuz2W9FFolwj0Q3Zz?=
 =?us-ascii?Q?Gq4Sj9KKY+Yyha+FL5nWOYH+KhnNe5kzjkWOJQV6M0I5lwdBOS1OEfFpcwbl?=
 =?us-ascii?Q?qgTVGMnPhOjjBvzW0aBpfVyHwYh1PALIRdwVszMoyY6+4CXw3Mrtr8IKrVWB?=
 =?us-ascii?Q?9LFojtMMtgro7kF6yRxsdRuj1BD4oYLvxZrAUSM6UZkHinoFqzmfMJKw4vpI?=
 =?us-ascii?Q?z3kEa8CsHy7NOgf8E+oB3HcKDeR4oPT4GGORw3ZiadHDQtyyE7gjwJWREpkW?=
 =?us-ascii?Q?7D3nO+0dHvhSqC0QhQI0RaqZdrzrmZ/VNxThr1AOm9KRl/OclaYAo0jYb3OK?=
 =?us-ascii?Q?v/Qor3foownhzM9pbmnBiXdkCQS8J7nj0FlVsw3hxMcml22Tlz1IEQDbZjys?=
 =?us-ascii?Q?OHEgpe8PAlyLbDOtMuu0XOTzugJ5l9A5tohkhaO0zXXt5sh8BvMdsWR/GL4X?=
 =?us-ascii?Q?gIm/mkjTz37RB/Z/lJRpLXvch1f5/JDPDYozz99VmEQbWucLEyWDCjSWhsxc?=
 =?us-ascii?Q?jjz0c0wq0b3qfbgRPr0smzyqb/uhN5sodq/lRysWkig391+EgNZSVDnMxJPk?=
 =?us-ascii?Q?jybU1DKB0KN3eex1HOIJIZH7R53vZJuLYb9mrkyI38kqPDNmcNlXFr/vtLQB?=
 =?us-ascii?Q?zbUoP8nk0OHzgfRGmu3/wx4PwYNoViVNH6rAaA2FCaJvwSIQnjfWH7i4Iq9b?=
 =?us-ascii?Q?BW/wIWTzOMWlnks74EsV5SKf7/OFgCys/HjOfy8fl9H4ev7qfF6W76w772XZ?=
 =?us-ascii?Q?b+M8zbyg1655m6zFyr7TuXwoi1ZU72f15BGyxk8+JKYXj3jeMmMNAvtA1xGA?=
 =?us-ascii?Q?7Pv/Z6y95VBr05u2TmjGbmUrgk+hbdE7Zc+Ml4zgEfpI/XHXfYpUHybuYZgL?=
 =?us-ascii?Q?NNh7qdb5vqHXrUNy1O/HMKSKOK+iRgPEyAKyj40vrZbKfkM7VMzMXnYVh2EU?=
 =?us-ascii?Q?L0OEvXTGwsEk9srt9S0FdKN9XvtgmhxRCr3I0WKt8kIeEOK69oYRX1MwNqqi?=
 =?us-ascii?Q?0ia0gDhvTr2ERE9PLlpXwuYhOMuhTFxVF3c4i2HzwKPNVWlke1D5aJfPdvMw?=
 =?us-ascii?Q?quokmt03P3MT0GkhS2EZD5dgQhgCKa2q/YgVz3Vy90SmgFqPdGMDgaUfRuE1?=
 =?us-ascii?Q?7myiTuGNEAaqIe5N62HmjUadXAcAao8r1lOC5rheKRoDv6uVsxpkk3Jkl8fY?=
 =?us-ascii?Q?gavEkmx5rzeA4MeRDTnFl62OLTFjC9RhajRSkq8C1VDL35VjqdMhpOhTMBnh?=
 =?us-ascii?Q?lLJNMXGA5ALNqeDMSl+A5V5jjLBRBXx/Rth4NPgt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3db10e-d324-45b3-d8e4-08db8f4e5ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:38:16.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSTllWcNHz4sv8d063lKb/1Ok9OOuIyJYHTYJdBTC3RLmM383lh2vwGKdnKTlVxVFV5buXIuREHkZHEKm5z6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Introduce a new domain type for a user I/O page table, which is nested
> on top of another user space address represented by a UNMANAGED
> domain. The
> mappings of a nested domain are managed by user space software,
> therefore
> it's unnecessary to have map/unmap callbacks. But the updates of the PTEs
> in the nested domain page table must be propagated to the caches on both
> IOMMU (IOTLB) and devices (DevTLB).
>=20
> The nested domain is allocated by the domain_alloc_user op, and attached
> to the device through the existing iommu_attach_device/group() interfaces=
.
>=20
> A new domain op, named cache_invalidate_user is added for the userspace
> to
> flush the hardware caches for a nested domain through iommufd. No
> wrapper
> for it, as it's only supposed to be used by iommufd.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
