Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C97BD1B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 03:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJIBNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 21:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBNf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 21:13:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811DB6;
        Sun,  8 Oct 2023 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696814013; x=1728350013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yZrelvBa3uXFq1kijTD3uFsV3zNSfXGOasHi2EbNMas=;
  b=O4XZLDFqrswRV6dQZfUDgc4mrBY6xwAQJJguiaqHWmCxsKed+rgY9so7
   egKZhhuwrhxb1/6U9PBIyZmfTXoeZY3GcMweU3kKGQHfAshtfu72CptnJ
   4vZQTcqyYCUkCYbmbphhfxeihbXn0il30kdyHA6g88IU6yUJC+gYlwqem
   8+xEVwsSnHmB9/ZisxY0n5MJP0yZuOrzu1dls2762CWlVwfXpffu/70FS
   TQnxkNuzRxB8C8Sw088AR71qBjLtilMibrM06qDwSyVi7axJlBt+xgf6D
   vEDbUB3k/Tjs00qauMQ9sEXg6HPf0mpZczi09X9eZB3vFp3l8SeXYqdua
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="450545421"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="450545421"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 18:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="876632053"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="876632053"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 18:13:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:13:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 18:13:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mldTdnpbggTm4RQruzuELn4YGbdU6ksCufR4RyFUX9+m2wmTpzZRD7+Zk77LZiLj2Kv8YhXKEMzogsayUj4hKhTPmY8nFgArLsuPI35nff+g6wzzZY0Vg8Hed3SVOeTswjAgnfoDUq9f8xjgow0KR1g6ZOtIiWdduRFtKdkVeKocr+rU2qwO0KPrNSbjsp+kHEj0fZ5LKcHbKFYJ+fSaEh5LmbVnTyxJ5SGJyaC41aam/GTntbup4kEv7lG9V9InBu4O0Tf7ZRFzN+GIoxrGAcrBwQi63YFIwuZbqlVmmhdN4WwnjLYc6+bL+TBTZytzby2N3RHJxDKJZ0mrBiDwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZrelvBa3uXFq1kijTD3uFsV3zNSfXGOasHi2EbNMas=;
 b=dc/SNL5qfTY9RT31qjrNyF7D6zjpkuZZfW36hknaOa/xIzXqN3lpwo387r1elEmrLqX61/1IAUHScS5cXnJixrQi/TI6QWIfT7D9uYkCVoZfBdvLsQVJlJHsf5RN3vhNtN19mC/Bi2faGyU/k9cspXnMx1exwulB8u0EyJ36i6EFZTj5Z925zd/dX+AIcUwsnAPmsXqSkP+5bkC6MtofrbWA8HL2R7NCF39P50z9PQtxMWZAmTkQzlHXzvq00YxuXF4IcaJ4z1c5SvNF1/pZTIgFS7QrXn9ykVB5woXjZLnkHeNrbeL+iQyBZhTJPEAOjAdvFq199Z/x34ZKQwY3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 01:13:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 01:13:28 +0000
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
Subject: RE: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Topic: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Index: AQHZ8dub6ZRQ97RBvE6V8dgIn39zAbBAt80A
Date:   Mon, 9 Oct 2023 01:13:28 +0000
Message-ID: <BN9PR11MB527623E05D1D3595E33186F38CCEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-7-yi.l.liu@intel.com>
In-Reply-To: <20230928071528.26258-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8278:EE_
x-ms-office365-filtering-correlation-id: 9c69a76d-c08d-4256-c325-08dbc864f23e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8abxAyIec2KxzUgvuWoqyNMtAANOjiy5HjMBO0LQ64Gzt9GPkIYmOznn4r3gbalJNqDxzC4RinRJTErhGMgSgEIE2ZI2MUjJNFURuKpvcMRF1Q2wR1QYyDzsEh5/kPPGim+yKgNrUiS9gzaX11b6LrwzQ4WUk2kbJWspplk1PkcdnNj9Isx3fidMYEJ1Svmi1oIOH0614SGgrAw7xdQxWpaFYw1xbLa9x6Iuwl6/cE77M+9j5K9n6V0kBJ4eR/+td54TkbCkBI+hgI46PqGp9IkJ7bq/aonfUI/g7xXjRXKVeYO8DR/wGSWShmW+kbbxXDb9HHp5kYNOFkkfX67FAZPDcT0Zo2dJF+0osSPLg7BkIsoR40FYMmWm7XGDT+kY6mqTqmAWe9fUJlitmzZxfupg+ac1V9ec2Zu31EKmpcg66Hgkq4+Fh2HjGSLn2Mb4gaoYeKO78CL5MEWcdp31hAx8ZjQIXGf0oVBP9qYv1ZHyCu57ZQjFQaYZ2F3jh6OXiEmtTjx5gi3br3m7mICrZjJMzHuYok2q3mXl0Tjdk6pUVg9gaj5BbZeMWM3J49kiogDnBM3lTG9jAMt5B4lkpRHjQ/p9PDchmMusTGzQIkOygk5e1UqU4weT5rHONGN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(66946007)(26005)(316002)(66476007)(66556008)(110136005)(66446008)(54906003)(76116006)(7416002)(64756008)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(71200400001)(9686003)(2906002)(478600001)(558084003)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TOIvjONvH3kz+jhXojsZJYAGpVLdWDJJeK2lsytqFqerP9s2ajuEp2O2GcT3?=
 =?us-ascii?Q?2J+fpkdkPd8SvQ6Se8BkSC7l2sZLwEFmUt5/oEBydEArAOPg6nNwh7xvfaSV?=
 =?us-ascii?Q?FdOSqoPVY+hv8kZwEuOPmdfkzt0ybMeC9heptf8KRizRgmykJ65EkFKyXWSr?=
 =?us-ascii?Q?BhpYNcxCuTxTe80fWesSUm7xy3QZmYkjnoBgzpVvFyokpNfkligv4zCDQUUR?=
 =?us-ascii?Q?3HOFQeF6SM/NkzHgNDw7m9V+Qu/9oESEjFPSS292Ces84PszHrPkPvbHHTEM?=
 =?us-ascii?Q?uuwFdB/VEReGwbn8+zGfeD2+c3H9OovtTAIfZ5SbcQyNRN/3NHkmbr2ksUcT?=
 =?us-ascii?Q?smWNOy9xMTohWcxHjcq9kguZqmY5iMoojikdX3TOdr1EXrU+/vekaXFvc29y?=
 =?us-ascii?Q?4Jun7r1R580NustPGUD3u5YWK1fELPU+47iWA8Z/0lyYhRQJEE7gPfBDQd3h?=
 =?us-ascii?Q?ImhLVC9HXWiae7TcEOVGOY7yc1pXCrJXa/QTyi0CwYJTQOalcEHmxc+qeuZ9?=
 =?us-ascii?Q?0yynwPzqb0H+9zBeimvYowroDhYJQvCiva2YUQ6/MOOUljsRcDpA1r8wJYqK?=
 =?us-ascii?Q?xmCOwoq/8LP4KAK8KFVKDNnBH1e0UI3X0vdwCrP69axoZoalb++biEvWnpus?=
 =?us-ascii?Q?7Kr2KV13JxzwBx9ZxZheosRK5m2L+7qZ9GFtCRt7MHyEx9hi5gUqVo9pzKLN?=
 =?us-ascii?Q?RvpeMeFI287ZJ5LUTNehSPZmIToBrEjtIImbPshMYAzjPb/99atNu8niHSMK?=
 =?us-ascii?Q?S+lcUJsI647OkBSWPshPWcJvFEsU7AOEH4GccH+aUoFTJTosTZjffp9+Pn+o?=
 =?us-ascii?Q?OkwklqNfz22zFcHGgM/VU9nRtKqirUMUoAVUyPX+pmngaAmRPo4e6AiNRfRh?=
 =?us-ascii?Q?vMJ2SJQeatVPFghKH440Qv0NSaHvFvjQ6VnbDMzU/jKT8Y2AHAtJKcmxs7bp?=
 =?us-ascii?Q?vCF9bznz5i1mnzIvx4jp++X3ZHcEtoG/Z2LLTEErl+g5a3j/lXup/OFwzx5l?=
 =?us-ascii?Q?fvY+XUwVFCnhOTGS1jAP8T7rk1XtofGoUO1NGGXwV9s2lMhKWeVIhUNrPUvp?=
 =?us-ascii?Q?SfVjOikdnEueINe5ATcvu27m9L5QpKnoj7O6RlbXMc3c5XGI8VkgFugELD9x?=
 =?us-ascii?Q?GM3MHuoeSl/Fh8B6n/gW5d4Ix++Vtedna4eT2koljmpd9rfjjqAsjMkpSWio?=
 =?us-ascii?Q?d4EIccUfoTJVuFFEbVRoJTmWzeO4MkU6OqbKCk+hfhzca6gm2fJitbz4H09g?=
 =?us-ascii?Q?YfKQ9IXN2u1L8vN0UJkYPT8PN8P3RJQ6koPHldKghWrNa27rl0yc86ujAej2?=
 =?us-ascii?Q?73Yye26hvxXhnZp0XuL3FGz1A5ldmGER8HWJjUT84fi/vZNS+n9jmEl0GmGT?=
 =?us-ascii?Q?STnBFs462bx7LePYcFgU4MyBvx41hC22DCj+ei09FxzecEjn1NaVIxUGszQX?=
 =?us-ascii?Q?xBRHJhSXE5No8yjJrOUpIP8DtTEgaMe7xKypO5q9b77oabjV58wsttrAZwuk?=
 =?us-ascii?Q?+mq/TBEvPd/gXLhVRc9u9WBvQnGiHwaukfZkM5hc2fX3NJSsqEDTcb2lpmP9?=
 =?us-ascii?Q?aVlzJyylvJ6H7gJKExrF57unPepTpIrxIRhflud0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c69a76d-c08d-4256-c325-08dbc864f23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:13:28.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuu6VYX7cGiqOw6lF4VYaWZBodJ3L+mQtsMW2FMaXIpO2qyzJ9l4/LpgklCT/0591FD5M5d4A1JM36yGAPgWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
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
> Sent: Thursday, September 28, 2023 3:15 PM
>=20
> This adds the domain_alloc_user op implementation. It supports allocating
> domains to be used as parent under nested translation.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
