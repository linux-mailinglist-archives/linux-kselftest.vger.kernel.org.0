Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B676691C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjG1Jjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjG1Jjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:39:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64F11F;
        Fri, 28 Jul 2023 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690537181; x=1722073181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Z5w38BOPoi5B9/M8mS4VJGZ6GZGn0u6MnrjVlNkqq0=;
  b=kYFNCZH23BrYL/w+MMxuafwV3mi39eOqHF6QfAFmu4/Ov6SZNoPOPRd5
   MzkRXlpJHFGP/A6oDTJeWYSSEKkGYwxbeRuNcZZmsMnqGoR/b59SVagxA
   ZuMexJcsZiMPSZwQDhRYVKWQhSOcGHbzfBZV1+BSX6Yyuc5pIWiLYGEOt
   VCrU8c3LRLFn+FBnKtrMk+cI4B0fU2tSLhRl5emAHtLJwEnANz3fu1Uj7
   MOjznwW5vYw5ILbtl1EmCdkPwj80J5RRQdGEQf8vb/wQPKy4vtj37bzS4
   XH/Y5fgeQgD209P4jllIjvUcT1Xc/NDWEd0TXkllDeWLSfAIg2XQyWPyK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348154457"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="348154457"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841250923"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="841250923"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 02:39:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:39:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 02:39:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 02:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VshM2wrlWXyYbPlsp5eHgUrRXMZgZi3K9g9Rg29nJjakSnUBQc1eQhXCshHb7qPiqSO4TGXVEQKaKC7vz6XXz0cyiQcOH6HSdCCre5c8wEP5vrkH9i/f6MUvEJ3yxRF2r9f/lEkkMjr9p+8vKGSDb2wjWWwioeAh6wsL+gqlgvgLqQSIr8X1bvfl/IstjFnh2pVDJeYznb7mzTIJrHeUCTafpdPynh4IEjg7iE/jmx4Y2G/rxZ4WGEq7c9nAsO4q6Jy1viFliRfOSIEB61O6Ia39ZMbo6A9aoiSkPmlw0wGtF2LUDg04pZXGlvqQ4zz5xOJaE7tey3PrRjcoq4L48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z5w38BOPoi5B9/M8mS4VJGZ6GZGn0u6MnrjVlNkqq0=;
 b=R++LYOyW3MrvDvH2IJE3Pez45Y0hRGT3uBmckEIBPOl7vmIMTQQ/OGPsT9W5j7eGYYnCNHHckteYXiMJG3M/vB+fF26d7ZUwoGNssTeNBOHFRyboNtrayWNJ7ssLHMBlT4zUZEEKvKBQEME2mi3DNPzocAX3MJ3/oIFeyNlOrloHa0ehhaNSSX+ptwP+bK82kiypYzofd86I9kD9uI6f9KD81gKiMt6nSqO5DyTcU6bn+1RpyV2KDQDeRQTF78WWTHCssRiu8Sa/xz9kixUGZWmiSqycfwYsrNDgjB/c3zzi0W879o/DFuVZo9s91QK30dWxocf6I3LyYUowcnYvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:39:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:39:35 +0000
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
Subject: RE: [PATCH v3 03/17] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Topic: [PATCH v3 03/17] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Thread-Index: AQHZvh6XCUjcwLimCUClCN3//G/sAa/O8oFw
Date:   Fri, 28 Jul 2023 09:39:35 +0000
Message-ID: <BN9PR11MB5276FE5312DEF2E79B2F61728C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-4-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 08fb54ef-c3d0-494b-90d8-08db8f4e8dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +q/8ekXonZyhX8z7GDEJ/b5DNCElI64Y4kFNoqM1x8vQhx1d/UyLHvvpWMx9HznC7XoWs5u/VQ77HS8qA4bRNjAeSSCtNoh1vUnj1Gn98njjjoQHbp/356MMpRGsJcoOa1LpkLQs67G6fp0G3nhJsh4pac5d7v+rbF76CnflccmKVUeEKeLg/iRODTlWZwx87s0vKjyd9KjRWoLG4nqmL0myUQSSWaoQCs8Lfmns7dxZELs1v9By4rTATIL4D67roIg258o2G1eb1LrszuDMQbtSef1xmUKStV/fEA+/uEAvX9GV0I9Aup55jPYALQ8TmXHXrldrdzV9/7O/B1CrN1rnYhSA3LgRYAyqn1Q9QH5JRvdiuELwamqrR0KAfj6taPHqEB2Ilw7vlbFKV5FUzLWs+xlI9qFXg+i1Eonk5OzvC+4MQQmMtpF7I12ktY5JQfLj5scJzO3+waFEriFgx8OdlEYr/hgkVuJ7vkHOJoCuWy8i1b8TX2csFVzaCBQlOlZ1yuUEPVEhAaqGt4prwJ5fMv/VAqGWxogvEqsrDcIyHKzcPa+PpyVAFYGstzjtDeGjCtc6tN5FGE61Mp2UPlXxmRHW4z2tucfAr6GfNeNBBc+q/2I9Irory4kXTx52
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(4744005)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(110136005)(54906003)(82960400001)(26005)(478600001)(6506007)(186003)(9686003)(66946007)(76116006)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6SfEBuTMUWzFZrYAE9mMnyWcx9lhFg4MjIFilWZJ/9afb2MXOTGzzTT/y06?=
 =?us-ascii?Q?1vGUNazOIrMYSp991Yi+pM3GQXEj+3vgnNzBP8wYX4nvOYd4vhaYlj1VujbJ?=
 =?us-ascii?Q?kEFt//4tYtHBCCGi+vNZyxcWTi2G+hHREczvNm8vLZT7POwpO1ZrQiixTb14?=
 =?us-ascii?Q?UXcEzaPamNaEcrIs/xvuzIoTUnMmSt9pbylhq2EQ4fO42R/JhuTxwh80vHRe?=
 =?us-ascii?Q?RCfV3jWK8QN9ItWQhrEWh0vNsSGDU3uEOXvrdE4e3/YeuiH++vyQ4+Uh7LHu?=
 =?us-ascii?Q?Rm+JOuQI3QKFBvNFpkLceBMrabbFzCFjQRlpqGEa8LtyL8RqvRSrJZpHPp+D?=
 =?us-ascii?Q?q0Z+fXET1WzIvvLqbiSetCPn9Gfld/HqhCzT/HRrFI7PHHRFPTa/ZQTktpT7?=
 =?us-ascii?Q?yjHTbA8FAZX7N5wn5Rc6VFPCX8q35qPM3pHGGJpP91BocudDbO8PtELAxA+M?=
 =?us-ascii?Q?NHVvuYzvvamch4PLLRlOSfTMXkKuCu1V3dZPUR/GaGSZH5cg+L853NbnuNvJ?=
 =?us-ascii?Q?YpmfLSx+h9hzsTQgFYaRasl56O9+34cimHpiGscCbu5LGJjbbWVAN9jtoLpo?=
 =?us-ascii?Q?Vh0fJkZDayQm7+0az2LmAQVOudA9grwV3Ss0Pay4E+3KNLKCKCgRL08Xd2W0?=
 =?us-ascii?Q?oOCGiaetIBsPihsDSfhxP3Xvyqt7yVEtsgpxPT+3kpPieS4oA9GIaRRNLqVb?=
 =?us-ascii?Q?8BRJPVFfhiCcshFWETOPcxiqhAxVQFc0+YjL3q5wPGZwH9Ear97z6ARHEqHo?=
 =?us-ascii?Q?Dl3Wzc5wzWtT67qLcJAnVZXtxjaSbjaa5efTvC03BducgVlnEuNlexlsssY7?=
 =?us-ascii?Q?LIvULeBCUB/PV8dBNUXEzmnFjRpwtRLnGygz16z/FUv363PhaAlZ3paXxcFm?=
 =?us-ascii?Q?SJZhvrCuumJ8Yz1pliHc6cqcFI5/j3OPZSTmY2raDWCxwLJxs6jViewvadNb?=
 =?us-ascii?Q?0fYWNQ1IviPERIH6+pJqtJlzjCzkExrWq+CtKHx6BpiivWqSYFHDxFchNIbc?=
 =?us-ascii?Q?MLREYSDmEaH6rwo140eu9KdDDfLyPOeAjHvLEru07ftZo+9VTAsmLKTwyxLJ?=
 =?us-ascii?Q?4RQpc5jEA4yYai33EnIfNYje5QnU6GKIPJRJA5dicdms6LvC7ytzWhozp1qn?=
 =?us-ascii?Q?GgvlTSTLd5PaetXyKQvaYfeUjv5FYS7pOKREr8I5GWE/qKHF5xkJy08ObTmz?=
 =?us-ascii?Q?YF2zNI4u01jCy2U44slNSAEy1b5rapKBNqUaJkRSurGlJbBwQLYYTXxoBY8u?=
 =?us-ascii?Q?MyeOF6Ih5AcI+GLW0LqS91h4THPKVih0ve30FeiwJqQ1M5QKeLuSFyvgXg3D?=
 =?us-ascii?Q?FIxuFEL8jhJyaeDUq0xCsTmZHs/vhlfEdUscIHa6k9eWWbqaFkg2w9k9brg0?=
 =?us-ascii?Q?Vlh/RukV7g4Gjb2wTC8Ss8aVWEE2q7RZDm6LLsogXMBlkAt+tvmS9iJ+aRD5?=
 =?us-ascii?Q?ts2C9MTEkW3p0hbzLbs4o1sMYsYFYUkzkDpIVFjKMJaiioqgxGEJCFZcwauS?=
 =?us-ascii?Q?xBd3VIj0MyA4DyqrjfsfGXxAZ2qjWEWKVsLLwBtdgzRrgFvGfoN+MOd8F3UZ?=
 =?us-ascii?Q?gWoHtyYtINbKjPnkHBG8EH0auR0IwuToWKI0CfSN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fb54ef-c3d0-494b-90d8-08db8f4e8dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:39:35.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkSZPqIGsGodvyknDazBGZtny1PYWB/LoaH536hkQlPFNi8ivsgE+7Xxe1DYqN24v5T5+aaveL/3bk0UNzc3tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>=20
> This makes IOMMUFD to use iommu_domain_alloc_user() for
> iommu_domain
> creation as IOMMUFD needs to support iommu_domain allocation with
> parameters from userspace in nesting support. If the iommu driver
> doesn't provide domain_alloc_user callback then it falls back to use
> iommu_domain_alloc().
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
