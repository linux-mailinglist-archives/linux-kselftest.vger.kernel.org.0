Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A496B3C7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCJKld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCJKlb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:41:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95659CB;
        Fri, 10 Mar 2023 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678444859; x=1709980859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y00kB7IO+uHJMT9J5L/oiFHUCoQo+Y1dR6bQ0pvbDt0=;
  b=QNherRe93BlZI7dH8AkixR7+W4fCbiT8uc3YYChMuBU21hCIbG0jUPHT
   UwVkdIcc9ZXunXpR5hHi14B2poGtGZvZc8/WuEISfXsg0pM2KaflKQYFa
   pnifevWu3QumtuzFCanwitrK59ghVfJbWDTHmYqIuav16S5KrB8dAwSUb
   8TdEU+Z8vypzts7pGfR5uVRHtN6MbLG1DckYo4qJjwW8fsey/Visxjl2r
   1C7fsc8wkHOJaUVQDiPRV3KfN/VnVMAlJQME+YuI4jnfB/9N0YBD/uhNR
   0/xPccFgMKskMTvFscFBsTOD1KjEt2I0qal93dxBol0DqClKlVIdpXPxJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="339065385"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="339065385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923616966"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923616966"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2023 02:40:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:40:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:40:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:40:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:40:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDxRSqRy0yej6PTfHqZRfrnJHLBzjJN0MXosRbQNcjGZWriRTiIKd3jvblYP48NBFBXyAUINFqAlK4d9kBK+d6Yj/RwkFxAQuw1zDfc/8Cwn2IbkxaFzujOKJWmpWBjcVlNFX+N7Dp//JTIPANHYHhlf9bHhxBK+DS/FB3g0ak8L1Nwgo+X6UrI3xjf2lHBdCBTTYC0WGoysDfCZZOLH1nanjXrAtAEmUQ4OVhUqsr543SbmM40d8wtao+XD9MG83i9pvPV0Kae1u08r9Y7mj4Oimy9bEgb6/x7HTqlMfX4KSOFThKKFVE3LFZ2Hzosorr3hqfGP+xKkfVbnusgkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y00kB7IO+uHJMT9J5L/oiFHUCoQo+Y1dR6bQ0pvbDt0=;
 b=evEImBjklZXphHZqPj1laAWBG4EOUy2K5Nke7jOERR3xMxggpNW/JgqrP2rX549YuFVLODl1hDqkrpMbRtgUl46onsIkMqpUeSuL5uepQ8N4rdoNx1UBeExUqQhJlKYpJvLTnoo4PlVaNFrMD0DhO+4PqmhwdKWWlNZ8tBs7FCYFOCA9lKpYZeWF0aW0tuLn404d8THhloLRNkrjCbq4ASYX+4NRWV/alDobxTJyRzjedimSQED6EG3BIyGI1H4x3dgBCK3vHzbpzK7H6fT/uKR5y2jVQ1EsvpVsnMwGhy+2NqwJooyxHMsxeT5ELqx9rVzuPbfQ9IsyGYtb3BDN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 10:40:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:40:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 04/17] iommu: Export iommu_get_resv_regions()
Thread-Topic: [PATCH v2 04/17] iommu: Export iommu_get_resv_regions()
Thread-Index: AQHZUVYBIGQJXMaN1k+UvI5Q/MJqCK7z1nxw
Date:   Fri, 10 Mar 2023 10:40:42 +0000
Message-ID: <BN9PR11MB52760E9705F2985EACCD5C4A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5228:EE_
x-ms-office365-filtering-correlation-id: fc0d0bed-e243-43e2-9a30-08db2153e62c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxqbJws7GbEuyoUcQEzMctpYi5ATiQMXq3M4orKTdi+QRRR6wXXHdmLxUS+eNa91J7AU2Nahu394K9a9/6f0D9+zGMIVtUNJgUfp7v/WFV8RKQ5uH1ancNevTgCsS2bl7s12JVTYgpRyaxD6uc0FlaMqu3Mo3CBFFZkCho3qRxJrzdq8p2igLd3e30n6K/DLxaasjB9oFAM03rWlKapcbCuHQojOMDviUAkIPMCjPhVq89azJf9PkJYhSW18bVUVCXzIwCdRPXrJ2O3vAGWNXMtlkbn4HluFAXlPa9+4zg/FYuOoIcdtj3SRkwnk8b/OLrFs6VRIW8bdnd680JKy1fOWiXDF8ooslosOxWcUUIlUyfA2oR69Tee8L2LB1NwmEqJv/X9U5mXHJC8DnIp9iNt1aFnZHArUgENttc3EpJ9U3eTG+W4dAxXqBpd9Fprv400dRQUX3ulanrgZOYjUlnLTDdEMcVPRatjJUm//trCrT1TTm+34vdL35XKUN8+KqKixxzp6I9jHP8ENJXwlU7/Zht0w40rVtZU4VJNWtudC0WXm/tXpce8svopshStP5Wjlyi0q0GSJy5rPVFFOoEp2s1P/MFrQ+GFepcSo37DoiHa2pt5flD8EN3IaWAY6vzr/gJngtz+ATTnCjogIzI9VU4EH2qwBGUkR1+P6ILXU/WZlXvUFLqf6YDONycEPHIahsFalaAoJLgRTYkzuyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(82960400001)(122000001)(2906002)(33656002)(4744005)(5660300002)(55016003)(52536014)(66446008)(66556008)(66946007)(76116006)(66476007)(64756008)(41300700001)(8936002)(8676002)(38070700005)(4326008)(316002)(38100700002)(54906003)(86362001)(110136005)(478600001)(7696005)(9686003)(186003)(6506007)(71200400001)(107886003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M1hh6WDd4PwaT30XHjdS2oVC7Xe3pbbtjv7SNA3xMUOelUl3VZ1IGRcO7wK6?=
 =?us-ascii?Q?0Skzpf9uUip0Npj0pFNjq+KoMriwg4NiiITHhc2xAWD8+8dUkeFJNJdS7suW?=
 =?us-ascii?Q?Im5CgcBUU8b1siTjUh9yVi9dO3HLdHl7csvaRPViAYtYORAiEhjLww2NjELt?=
 =?us-ascii?Q?UpxhFnbFOCN7m4SvlYdUZpjPw07//0RNK15bbXmcZmX6/Ox3FuIMCbXC7awv?=
 =?us-ascii?Q?nExQOCNhJoUJfVMRoAvWsA7BYKZrfWmjsjBUGwF4a3XpDlxMRtcc346bZ/dp?=
 =?us-ascii?Q?J+QOfufllLB4r8rIrSe7cUiSB//++5RGNkkqorHkjGaCyw9GuD6jWLEHtFXA?=
 =?us-ascii?Q?gO/UFW2NM8XhePJSsUvOoFR0PgBxKqiyy8HnBBHtKWxaSg/n81tLdTn70Kbw?=
 =?us-ascii?Q?PLQpdQUo05IJrIqDGQznWKio/4jFMgCeheSDIlIBnPfzILQNfL/456zVjP++?=
 =?us-ascii?Q?QaBhc5EPm5k/pZqHKESKmZlpiuBX7e/2cmwz6kl0yszY6HAWQZc+dk1RYjZf?=
 =?us-ascii?Q?jNE9BRZ2pjMbsvBsprhkbyV0/GEE4I4sXvrCPZTLUzqldOuJtjtDpvMYp5vC?=
 =?us-ascii?Q?v5XEDZ8wFHcHkFsxEaTFpAz8iB12j1UXmZSCjouxa+o/XATdJm/+HlEm5+Ij?=
 =?us-ascii?Q?i9fsMXXqYLIPaOWGG8ZCT9mALEKMyCYbdFotHk8MY81ag6WQkrreI88wGLE3?=
 =?us-ascii?Q?IR51O0hpq24C2RgC8sAY0LkF7oGsTa6YlU9gNMy0Gvc6peZxxI5e6Xvyanhd?=
 =?us-ascii?Q?j+shWlw+TfNQa4oCSMB7lEGmRQ86ABV8hBzAyxDAba3+tVkBxtg1mTT/GOcK?=
 =?us-ascii?Q?YhqRawgM+Uu5EEuGqLNRr/mYbXkoJqManTB4fGI/kJbjVBYN5XuJMq9okBSb?=
 =?us-ascii?Q?qKM5Nq/eDpns/NjZSksMtZ9yb0IqAo54frzoMTyD9cRjovKcsTb1uZ0VOVU7?=
 =?us-ascii?Q?maFZDJY1gF5eY+j46CLhK4oVJBdz9YwXXomPQrL9okvH3kZfRErShrfccPbj?=
 =?us-ascii?Q?5RXp7WvhVBkQRuErjhV1nYH7kbcUFei+5L2j1qgBnGsQKGdoBmr2ET3m8WMs?=
 =?us-ascii?Q?p6z33dOg9Bin+uHYijq+zaWVND4vugoSnK8O7Trpycw8/pIPXfzR6YNQ/Fqv?=
 =?us-ascii?Q?PgCmc4139ZO9bE2y4EIwVFDP4cUmUowPo1L290FFJkEzfCAUGBxLLtGO/rJN?=
 =?us-ascii?Q?mvk10jShFHP0djZUwmHDPCM3rYgFZk2TQ3c6iM4fpxVQmHj/pVeHVI7ASc7H?=
 =?us-ascii?Q?H/s3EkA4Iq35yl2TY+BujVHv1U5zGdXb1lYQLUvzIh9dOlxLJfkDOfH6jVsD?=
 =?us-ascii?Q?Dv3HGrG7HS0FWJ6mUhf32yi9nVh+C6KAWa8JKLgx79NPoBtFUmJyY0m6DAfg?=
 =?us-ascii?Q?Wv4JSPRcox+nJQYyDOcOa9nFs1s1uJmq2Wt/Mhgf8Tu4Amq3j8lxK0DwdLsD?=
 =?us-ascii?Q?jzO4P6wcBu8iL8uv6v0iorsl6DoZky+RyeibR1SmityVvzQRqlW6CnUVSvgP?=
 =?us-ascii?Q?UY9oN/bMjHNQQ7fEzBS7hQr6tJtPHp29hNlGDoUUQ8bSTHwrEAyiw3Iol294?=
 =?us-ascii?Q?BVSlbNtN28ZuiUgD7eMgiAT8oxaoxs0ZCpdKC9UU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0d0bed-e243-43e2-9a30-08db2153e62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:40:43.0273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtAyUssdqnziQVglkWju+kK1i3L7OnjVBfFCeqtGT3xMU5eJ6M5VAcunObJMk6hfTJEQFoFkRaceEatFnQFvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> +/**
> + * iommu_get_resv_regions - get reserved regions
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list for device
> + *
> + * This returns a list of reserved IOVA regions specific to this device.
> + * A domain user should not map IOVA to these ranges.
> + */

s/to these ranges/in these ranges/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
