Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8666176DD1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjHCBZn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHCBZm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 21:25:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E22D5F;
        Wed,  2 Aug 2023 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691025941; x=1722561941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KcfCF4ufvSRQa2JQiMihKFT9r1cQz0XGg+HsI8QDj4Y=;
  b=NxtDO+1IU4U30jl3Bw5ZDQEEmT2+VH9lt98iUnvTmRu5lxhIVSnN2gVw
   P5/myLak+yo5+OJloPc3MLiEhCqsgDyIpuFf/+ZDoKc6VNFbyfCSB+POY
   gFZ6gLSgaZDerikquPN0A2dKVUZmm5eFZOhpcrXCbpzy4kltJ5CLouf7d
   n2rBHRVFFpc7QznzpA+xk0Tpv5nc5n2P0K7WngX023orFvlGvaxQ8KoxV
   bxAImzyhtvf1xW1snoIEBYB+1BUAGep5GDxJlOYT31a76rF1OdyovwMMv
   fgl186/xoW96A3W+F1ztdvPQChj/EHKpNxjkzggvSdPBdOUw7wujabMR4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350037545"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="350037545"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060045164"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="1060045164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 18:25:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:25:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:25:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diPVXisWzH5HP7szBsCQqjuMubLtqYh0BY+JIiR3LfJ1cSbY8gi+Pwh8wR9VEsbEnCco8WwRwmo3a9cf3XQN816k9pHSVZb4jYzqPW77JX7HU0dpOLPVOl+RefgoZaVU/7U5B1hmVmuGfxiqStaZW5GDYwpMPMNUWGSqYKybg6IhAn5V6vlLOvHab8cSXQC6QXZwQoBks7Ci5FU5MfAdtFBXH87uZjMXZbUZA3JBpLzlKnYEZuTlGPawWfZnUMsolWI10zhWQLHpG+jQKb3Ac8MrDXdeXymlylCsGgC5LDwWCWHAc0yok3yYzXF2i5HMyzB08Fkd+VDC9mV3gzZ+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcfCF4ufvSRQa2JQiMihKFT9r1cQz0XGg+HsI8QDj4Y=;
 b=gjJkLkfpzbT73Oo1YkAr6h+6fqWGoXKl7pb9M7YkowUHw9hHhn3ybau6n88fb79RmgSEjB0DmhYMI+Bjoak9cucB0fzH7pwLkx97z1gXUO4fm4Mb+Hsjbt71OgkPnCbROgRFe30vz27d79XCKxL1NYbIavUvnbwKXbG3CE+kTzVSS0mjJMa8ydpWvE/tW4Wd5En4PBDBl8q3AKzVRKhLC/hfeW8U6I+8oTfzdErNjLbBdOk+WLlkFmp15MaluGvhAREYjRyw40p+PmrB4TC0Hl4lXGwZqh1jA9NUgPAkNvqGbAZonI5dRU04mds+Eglp8I/klTqnWNLs6GHFYWwFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:25:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 01:25:37 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Topic: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/PejEAgAP2ODCAAHfRAIAA3SWAgAEItICAAGrGAIABnRqAgAAAjwA=
Date:   Thu, 3 Aug 2023 01:25:37 +0000
Message-ID: <BN9PR11MB527633F9EFD1EFB52772CD158C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com> <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZMlNcRgMYatv/YqO@nvidia.com>
 <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMsBi24W2+ubtmkh@Asurada-Nvidia>
In-Reply-To: <ZMsBi24W2+ubtmkh@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6977:EE_
x-ms-office365-filtering-correlation-id: 6fc471db-d55b-4260-4ca5-08db93c08a91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h88XJvNdc3PjXWghV3tvCMQbbnXhRbn12JFl4aYIHNMYchkufeQpbqSPA309Rzexf5O9EZU7Qy1X5sbnVmPK0IYrkZXaDNopiuAWjPiM48raqN90YWlBNTCxPCAwHL2WF8+hE8bDieIv5PmVvXA8X6dJDa5jRfOnwIR350AAyFMAI/oIqOvIF0AFFvwbRFKLCa8wjzEoNGSubv+aReEq39aPDlWTmBj/0+d6x1S8Pntl8Mowikkr6HiWEnIQMoqxSfUyw2UlF3KdUCcrCKPTo1p+OmHfXccwXi7s13/H6TrXQuH5sLgmZIq9gNaAJuh2jNoWe7WLydNpheCXbrqKyh29TBzcaYwcbxr2BE7B25v4A09/jyaGRAxhfp0bf3CmZTf7O6oQuDv6OM/zClv1UPL03VghVQI6WzxgoDrOw4V52SnJBbmILjItSep6RR/32WpD0p6VlaWUMoNoHfsgovkIfxMk78KaQyr2KVmhUB/euU8lmj7opykm99+UIgJNw2bJe63jm+Vi7lHtaNyZZjHB9k9Ml2sGYPs8jCnB89ZeEIaeTB8ty7LIPiV5DBjbk21/MqSfSGW2usRebSuXc2rBVaBGZnBgMiVrg8OoYE+PAlejvv3I2AMGFvJ2eQVt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(6506007)(26005)(186003)(83380400001)(316002)(76116006)(2906002)(66946007)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(7416002)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(54906003)(55016003)(38100700002)(82960400001)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IgRKhkGveGlOneQHVcu5iNZYQ0D8mju9m/QXmmslNb+iVEesrOW4PG8Wemb0?=
 =?us-ascii?Q?REMi2RCzG4B0Ztcy5rnbj+I7Yadd/lSCbZezdM0ZK+wqOTz2YAS4J80iTL05?=
 =?us-ascii?Q?ZbTO0r7kmgogLRKdndt6h8eeHNHga1Lw9qcu8sQ9AsHiUJGDzfGt+4a0IbEn?=
 =?us-ascii?Q?9GmLIfGFwVscIO8uhtbaD4OiKVpn9v/4kyGC+5XvEFdVGDBiSrnkAv+G9XoR?=
 =?us-ascii?Q?sjtZGQpWAeRjLloXm7wRTtuLIGxauWgvezWXEreELGacMZAGU7r9SxmaHP86?=
 =?us-ascii?Q?rqsYHw7klLQYf3MtIIT49vY8GXRPAHbfYyMowLxsxj7q6rUpPJv6uYg9gJmT?=
 =?us-ascii?Q?oHH+yhBl6HuDvymjk8qfx7DRomafjLkRxbYPBhSy+VtZwNeqNlzVHnMJ2scJ?=
 =?us-ascii?Q?mC5fRZHWCVD5oNs0MH/YtN+BQr9GaBe08yOqV/Zzsavkxjdtu2S4xbx9Y6Fw?=
 =?us-ascii?Q?SKxWYvzhFhkBfk8+tIkumTFMZpHojxrhs6h5Qx8L3ZJYa4R/+ENtE0eKwZ8L?=
 =?us-ascii?Q?ErVuUx35qyaQGgwP0uFhGSd20tPK1kAOw9GS1ALJ3LzUihY0F2Jjy56ftloP?=
 =?us-ascii?Q?jnZGXe4RK7qC2wYaL6Vte/AdOOTq5naG347FH6ABBIXcec1CRLjgxlmYhiAd?=
 =?us-ascii?Q?1LH7aXX7PF/6BSLjLkK6sBd0QJFmNblDvSKsLSysIDDZIrS9CGoG3o4W8IKw?=
 =?us-ascii?Q?jLxDcNxIrhKKZzsNPZT2Gi2TEKcA+CyEMFuxn+FqCZlHiNk3Ifhhcn1ojQQj?=
 =?us-ascii?Q?i9IWIV/TN4baiC0I5QdJXWR6u+wEkb/p/xRrdVKJeYlgrGmoxGCe1MwedFk7?=
 =?us-ascii?Q?hzDwomtCqJZ+WCpKZSfiygujpJLPSK+VPnq0KRgAjE3HOoBh9oRF7UhIqXCs?=
 =?us-ascii?Q?k5qSYbMRMO+qBoXGYIREtP/5ItwAgEAbIj5/D0buwiTl6VZ3ma0CF9d2h+zR?=
 =?us-ascii?Q?IB5PnM1G9HU8sYzmoORr6iKj5g907oUCMBKLa5o7N1RJB4iKhF3O+Yr7DT8t?=
 =?us-ascii?Q?braxX/oiRupInUeprO3aJ0r4lLCO/Jptsn1FNl8BZxwOKV49afm4XMw8DhXM?=
 =?us-ascii?Q?q/6rVVlta1yJy1VwX2gaI3lc1a5mZBkQb0FDmSF8FGDGprw8sUvoFY+9H1zl?=
 =?us-ascii?Q?qEdQb4vSca8UXQxTX/PX2+rRh+AL0r92zcXij5ZeNaEE9hoTXcjAK+lhhuU7?=
 =?us-ascii?Q?R2BCpHWnQb4CBe6MdLpUlRvjAeqs8tXoFDQdIUio7cY4JqpFhooYzFWz9NlE?=
 =?us-ascii?Q?jph6BfmR6AuKIk4D4RwuxRE3fk4cWUidTHvcix5pjRup80cnQJi8vGdyOC36?=
 =?us-ascii?Q?JkJ+Gi3FJihqUUEHF0RlgdSJ6r7+o2BN/Zl4quiTUB8OC1SyJK2dpBaiVKV8?=
 =?us-ascii?Q?JAGiKtFJvvZaxNRoSbzt6ZJ1LIQVQjkKCxygrX0kLS0DgD/T7SoaGwkHAI+s?=
 =?us-ascii?Q?1tDpxtbYEJQgwi/8xEKwkk9or51t7QHOA/pdukNqXAJpnwdtLGd8EQIx9wtR?=
 =?us-ascii?Q?Pi3VMveVksg85uU6J+0GNsno0bNgejx3m+anZ4XOz66JR48Do9bfP+msWX14?=
 =?us-ascii?Q?EJN9+gClyG7EgEKdlhfk4nmov4K2o1PQlfsXD/XI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc471db-d55b-4260-4ca5-08db93c08a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 01:25:37.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdDVtNbhA11E5+KPcokb3tAPyBxYqvFAVxtTFqDVlPKjcV/Yi8wrVgNhUuZZM8B1qLfWon16AXGjd1/byCzY/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, August 3, 2023 9:23 AM
>=20
> On Wed, Aug 02, 2023 at 01:09:28AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, August 2, 2023 2:23 AM
> > >
> > > On Tue, Aug 01, 2023 at 02:40:44AM +0000, Tian, Kevin wrote:
> > >
> > > > > So, I guess we should leave it like this?
> > > > >
> > > >
> > > > Yes. Along with this discussion (including what you explained for
> sw_msi)
> > > > let's abandon this new cmd and leave it as today.
> > >
> > > You sure? This makes it basically impossible to write a "correct" vmm
> > > that is aware of what the physical memory map must be early on
> > >
> >
> > emmm... I thought it's what you meant by "leave it like this" and the
> > fact that existing VMM's memory layout happens to match the reserved
> > regions. Nobody complains lacking of such a interface for years then
> > we may postpone supporting it until it's really required.
> >
> > btw even if we add this new cmd now, getting the Qemu support to
> > use the aggregated list when creating the guest memory map is not
> > a simple task given currently vfio only passively acts on change
> > notifications in the guest memory layout. It requires a new mechanism
> > to enforce strict order (probe all vfio devices before creating the mem=
ory
> > layout) and then injects vfio reserved regions into the layout.
> >
> > Preferably let's not making it a hard dependency for this series.
>=20
> Should we drop this and its selftest patch from this series?
>=20

Yes. let's drop it.
