Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9276C572
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjHBGnd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjHBGna (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:43:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15C2D40;
        Tue,  1 Aug 2023 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690958607; x=1722494607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NiRHEd6AvyKAl20rYOup577Nf58TqyoT0wpaqvHodNo=;
  b=nkUqR61WTbiVZmePpi+EU6HeE/E9G+/OOJlaaf5ebCLNqyXBvLnL37pZ
   Yp6+zbzu0tAkiuGUnBmOd1pcL9rkXq2Cd8DoipomUmCyxIcUEywVlko3D
   mrVnjPqjQnEiPQCoiLkvPIWxHYXpJn67jC9vF4gim/NbFN1z61AuE5rgR
   Psq1Gp6VTKzeH46s8N/SJTvEk1BpIGwxByDsznor0i1vIeKc1epJyrR05
   zGxgFKyi+x7BA5ZA2LWJJ8tRUhdXfA0j30ny45L+W67vexconFtScddPj
   7/0ulvqYNkPNwUF9tPqhF/p1xSk2v6jAiB/7j4GS1guOQVvJAGYXhx+EW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400442408"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400442408"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794467867"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794467867"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 23:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:42:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 23:42:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 23:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA1c3XtBJoMcITmp9gkV8HT68Xx83oZMAJkjGk/2rCObmc5sR4/BQgvB/ntPdgS46g8/Zi3ZniCPkHYXq+UsnYIBXHZaxPuC7v9gB15zfAxB3BPVsvLTbshZ2tYDl5u2AoK+qmDA+2L280MR3bx+0e1e8z+NsNbAPYf4sey2ozFJqzIpPWWIu7FU5CAg2sbvZHJs2rNhMUcgd5tGfC8zzf+KBlZZTgcqnZkyI5i7WID/QBG5p9rpiEEhu1LBGd/A+xM3w01gQcJ5V3wFgXRobaT4RdhNvgLeb5SUHOvQecVGpmWBUevkYUv7iiaXH302UzD+RDw7d+TlxeKLE+9KdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiRHEd6AvyKAl20rYOup577Nf58TqyoT0wpaqvHodNo=;
 b=G2JWHw2oG0jmbMmcLSaCFr9jqiar5O6SeeVyfGoAl6sRc0ZoGfrb8+p68h67vpRaKmNZqGLNA01V0mGJm3kRoIZInru809jLSuA6oReQS3E4Kti+XbAULcVADyS65q++hlTiNc6QFhvYU/F5frDdtf58rJflynlh4GIm9VvgcYgdDzUvgWzuIY2qSOXa0gykGe0wBzykvrhnIzcWW8/BGxoE5NNWgGCRenASY0lCc1h2sGgdNqtzPdU76s7g6ZDxQsQGYHeEDAjoykxHQtjNxDYLY/zL0/Km+G2Bxo9MbBVWXe5Hu/9pRye0gnIMlp56YvIrb9EYhblfaFxHr4d3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:42:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:42:30 +0000
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
Subject: RE: [PATCH v4 02/12] iommu/vt-d: Extend dmar_domain to support nested
 domain
Thread-Topic: [PATCH v4 02/12] iommu/vt-d: Extend dmar_domain to support
 nested domain
Thread-Index: AQHZvh/rK5UbOo8quUyzAMpuk2nnmK/WnH/Q
Date:   Wed, 2 Aug 2023 06:42:30 +0000
Message-ID: <BN9PR11MB52763041ADE3ADEE06E9E1F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-3-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8465:EE_
x-ms-office365-filtering-correlation-id: ece8100b-ef68-4a62-177a-08db9323a4df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0a+pGKCVzI7UzkdzpKe9N9kpVuAnCoqbHhXuTiS0Km3XiRmhLSIahKTJa9AcVg2JjFH/70MBaAola62HibYhvUY6yGZXC0lPaOu8ZbOPOFRxLWDi9/SZ/zNNyZvE4QeVcvLxM4g2diOTiTpHScYbvEwYXNpmV34QjuCSOwNFpzQ8r9ORYiPi4EaiKIMJsqTjfB8dgHeR9EFbgKPXhvmJBQ8rQHKceYkoZksOlliB9eVCgnq1FCOsBbhFrLNDn33t4D10kzQ8ZqXAnkuRIdJPx4RmCFNYP5wlFzvYsXbP+uANk4MqwDJ+vgJtUQU1iaK2XQZrFtc5uKqZEW0gmR5b7+h9VK0D/GzXxuMQ0d+EkN0YztfQYyNIrG9ouGmN5S1Gs9EqKzhZH+yLaqIIwGxAF45T8ERKiOgPYUREodGIe/9jmhU3wg3SBoAr/g8jcWK2FM+milYMXPz2pK7uw5p0k45GSUxOoT5m+imDy7DtN4pkKnOBsRY2IaLkP1U0RgRdBsxqoZEgMRQgCtuESmhbd0Ja4PWI9b0C01L0y4tWtQf0QFDq0vE8dyBrC4AXT0svsj0k7ZBu2wLANY4Dr2O6FlJ4Cn7KrNh4eGafASw9HxAZEsFDZOsMa8APqVbCiMvZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(66946007)(2906002)(76116006)(66446008)(64756008)(66476007)(4326008)(66556008)(7696005)(33656002)(71200400001)(86362001)(9686003)(558084003)(478600001)(186003)(82960400001)(38070700005)(26005)(6506007)(38100700002)(122000001)(110136005)(54906003)(55016003)(41300700001)(52536014)(8936002)(8676002)(5660300002)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z4fDmcDMoCOenyvv7w91a7BkvaTTgCqchjQEQcurFAjfNVUBA5UAXuQrH5X+?=
 =?us-ascii?Q?UdFPKybuFX7CEGweTHAczXx1KvUKR5V9P4liGfebZ/XJc5QUum6Oytd4aOtB?=
 =?us-ascii?Q?L9P+OSse/J7GUUVejp6grkMgAZgNdwjhjsJopu8fEQmQzsHp81dbyJG0il/G?=
 =?us-ascii?Q?9i32Gffo1hKF4DV1TcWUF6BqLxvvR4vpDJiFKyqN0Ug9f/5XRKgEHYcuV/2c?=
 =?us-ascii?Q?20yMR6hvz8bDtiW1h0ZXHoCMtJNGWFy213/lU84G2W7LQboSaBgEq6HrOFZY?=
 =?us-ascii?Q?HIEr35DC92gS5HWVPGpIVHm+Ew59oYmVoLmVjgV31IRKiOlHZ1Qr+jifSw4T?=
 =?us-ascii?Q?OpYMs5Ze5PjZdWU/BzBtnyaIrHQ4ra96W0uPYhp9uN+nnDX1Bon/yGJw8zld?=
 =?us-ascii?Q?VvNa/5vwE6DMGOW8QJd8xqpVewNzBGt79d3tk1hMicCH/9ad2oJrDjTw02ZN?=
 =?us-ascii?Q?yYtdCIdNiyUAfSRzdiqDj0NTjvtN9N97/pwfg6rqhhkg+JLe1rbFPGWxtATA?=
 =?us-ascii?Q?YLZNT8vCOg4Bj6KdC38gc1FZHeyr/1cLQ+wMNRV2N2l0Ln1YiICqEnZprQ3y?=
 =?us-ascii?Q?I8JjkL7vINn0s5117J6tFPjn7OAfjPp2qnlk1+dSpYosAeLo3M46kSnulfv8?=
 =?us-ascii?Q?8kJAzgI6t/YwDdarJrodXPWPuJQ4ZLgK1OiUgvj3xIdUR0BCiI/OelcCPzpN?=
 =?us-ascii?Q?D893J5nYRO6b8yyllJEzzyBDTaXigMlanAoQa3VI0n/fZx4Y4Aj1xhuKqByM?=
 =?us-ascii?Q?rLCs075i72KeUqDKEg4eVVPUR8Jjl09dTMos7Tbd0OPNV+QJgRLnk8SF6KmK?=
 =?us-ascii?Q?idOrh/PsmXZ8jWny1WJ6+oA0QTxaSSu1dag5vA81eu5PzQfewlUw6rsF52DJ?=
 =?us-ascii?Q?dGxEXrkhd7K4RoZhSjWdfovsjkQrI4EojC3v/9fopNoewAyckidFulpi2Acz?=
 =?us-ascii?Q?if9K8rZg3yxoRiZhBdbLREdWGRhiYBDvrwvKAyqWQFj5yFdyLXs4ZA2PtkKy?=
 =?us-ascii?Q?Vtu3hG1vRDo94+kTcNSGZ1NISZstubYCQa+tGHr9GVF7qLb7yUk5cbHhTLRV?=
 =?us-ascii?Q?hVv5cZfUN6fSIiw+5p7vWl/7QSEWG74fQHgdaoWfiHN4D3z5XRVYJoknfNy7?=
 =?us-ascii?Q?qaxmqvLEfYqVoNrfyOZonVzWm2KcsiQgWcytp9Pj2ex3vxY8SYrja8n8R6OR?=
 =?us-ascii?Q?c6PlwGoEUILAtjKpdz0nQFMjqFScrU7nvd4zdEB/GiTNtn0G2gFvlwPMSaxy?=
 =?us-ascii?Q?jXu+TRJqzWTx2BtKROr2r5m5xMJ/4N6fY9VjFpd/JVgTcf24OcrNVXTctde9?=
 =?us-ascii?Q?/2k8aapb6l3AUaJmNWp+B9HOJMpYdEPoy5uUvfHTG9VckfqhPMI3TXaYxY5G?=
 =?us-ascii?Q?MqeXVO0BG/2A+yTBgnNQwgbQDgltfJa+V4x2h0V8pwTkd5po5ufrumgAUUix?=
 =?us-ascii?Q?refKtmFUaok/8U6WwSOXvYPklfrKuWurrYeULfFu38JXra/g0erRv48b7RHn?=
 =?us-ascii?Q?r4e/naMwwn9C/f/+n4/5ywy6ruIX1WGYk1oknrOrn6+gX3iORxMkeaJh6zZG?=
 =?us-ascii?Q?xyo/xnuKG7md20NkC47bPcb0pLOPKIlCxMG8rEj/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece8100b-ef68-4a62-177a-08db9323a4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:42:30.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8rJlU+a96pi/mwO2ru44c0w+XudnNh+TTLd5WQixeCH8H2YWYSIXIMAUOz07SeFom2WTj3rLz5a9gG0nM+1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
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
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The nested domain fields are exclusive to those that used for a DMA
> remapping domain. Use union to avoid memory waste.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
