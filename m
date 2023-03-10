Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C756B3E62
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 12:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCJLun (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 06:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCJLuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 06:50:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF71116BD;
        Fri, 10 Mar 2023 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678449034; x=1709985034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kNeRt73AebPQE++HZkkHdFEUXlyZTxVwdnfsYONxLcw=;
  b=hXSMRp+Z5UJD4Bzlruei96V8GYN0qEf/J4Op1OO9YJ9OndcNw2vazU1c
   SgHa5OWFnls8WJ5b1kjOnrcFQ4+FgZFEZ7cWNIrE+g5crcMmrURI8B5Cc
   n1hS9fdMcZCJpSlkao1d3preXY21LtJRCErxA/u2Y3UNxsvtPsiCWMAc+
   B+oVAg+Hm8cyp6YjkwBBucXnYtSYWe1ZRt11tX3lCzc20jO88i1sZ+xML
   MjxVi0ueIu0T2is5ke3RMp3+v1FForbo1O1dNw/B/NHdqNtQ2ciX2zuMK
   H/i0FilpTn6f3VubJENognoUwCzXT/HIKEtO54PEuz7jDXmw7NWIz+zqp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422978310"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="422978310"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741945176"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741945176"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 03:50:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:50:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 03:50:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 03:50:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 03:50:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVxNEI8TTILWc0HA0F2TjYmn4ce7PeffBLkEJ2RKtzOmyCQi7X7j3pUR7RI/C43TsBX2DwJx6uGhTJn2uj1/H48Lp8UVih/Lq5RdEEd4vqzPy+npHAwDTgmJGlg+CSaS89+2Y08gwylZ0LoukzYmxi3Af8JqDoBlibYGxsqmJdTcMxoNvNoOWFi7VEkv9wsrKNs93PQ18r8Hg3HdlXSFxbsLbQPreLFH5QN47MdYvE990sB0XAyFoiiWQ6n6mGKFODkBHFQyypRYZjgG9/PlBvkAtex3xzvE159VHrMNM3z2dKZJoI/YrdKbVRjfHpUCm6sRRQFPS7SjpFmnzKn91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNeRt73AebPQE++HZkkHdFEUXlyZTxVwdnfsYONxLcw=;
 b=csKtyQxDZkPo7cIosceFD5L++rfb3SAECMb+1WIxG3Jd2l8cY9ERItSSp2cx80Nbdh0hPeez7CJRE7C3onz7bhWcVgtVKlS4IsoJAowCFMJyl6u+Op5sg/8bE7PX9nUWywSX5OtBJKgYQAfCHrGw9Jl7bqjGFjbAMZmadSWNOKvh0tqiJpqqwoe0R7hfQfITTA3EdttrwVuAkefRR7OAzwzzY8N+csuT+s7sgNfbyBMko3wFuRVjGfbkzZGTn137uZhSOiX4iTZvz+2PjHIeg5vbyPVeQyE3hx7kzfA449RFu49pw5jvWeT7DhqyXQBgD0gS7ZvnzAza3BqOZGaTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 11:50:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 11:50:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v4 3/5] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Topic: [PATCH v4 3/5] iommufd: Add replace support in
 iommufd_access_set_ioas()
Thread-Index: AQHZUcoA6oJ+7IOogUWP2G43AQ29aK7z6V8g
Date:   Fri, 10 Mar 2023 11:50:30 +0000
Message-ID: <BN9PR11MB5276C5D72F01CD7F79833FD08CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <58b67ca78925186b246ce8ed3639a1c92e56f98a.1678284812.git.nicolinc@nvidia.com>
In-Reply-To: <58b67ca78925186b246ce8ed3639a1c92e56f98a.1678284812.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB7702:EE_
x-ms-office365-filtering-correlation-id: 50536a9e-17bf-4e03-0133-08db215da5f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROQTtzlaTwamyNq3CUGijRxc6w+854mjHzs/E7XVr5JWP4xHEFJxJBMyT+k/MxGO94/AHlhW7WCId4uG2OYuyS8+u/VldhRVcPwOjfDyGvHWMSsds5ReONsMoh3c3/Cqhyn9PkugcmWgjSs4bYo5CQ1LT/vU5b/LCLv3TrthWv1Fk38ZZGOTzZQ2TFni8Rjc2VerilQ2FgZRCGgRJyuGwRdR7JmZa4Bo4LpAuDT0C0yh8Pvoj46UfwWy9GlTHaN2oLKLxpIQiour+3UNj2QZm5m8hLNZb/QFOJPS26eHwJ3R6CGpQ5NasmxPUq/ntR4bR3c2CHM218+5JnOZLuQnnH+mtb/eSAgsAsaShuQTr1MmNPjUK0eRHes2Hrf8Iaw0W24VaO/xP/b2rAqEp1nHPtnzVk4tEnwPKMi1M5uFHsCNVrV0P1qiVzLLcSIopHs8UjrtZ/yclm1jbY8gH51uUdNWjk4EHhOk7Q2/LckowbMwxMEzEvQjYCvult4+oUwD6ObUytwyOnxGv4ALe8zFDpMo5WjNUGj9x3wZy3nbWDjkci/4nKDpO/hZPG8nLKMVUm6ZXMAz5PyhgdgGq01ahQe4E4ci3JtNtvNB2cc4Ps+A4udC8ueuENwiJJ44/G8C0DgyODC9X+zrSgKb4S940B9IP7DmS6riYOb71iIPbSuRxKNSw0PhSOV90s55tyjPnc976cEhqCy1xRreV4OQTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(33656002)(82960400001)(110136005)(54906003)(478600001)(8936002)(71200400001)(316002)(7696005)(7416002)(5660300002)(52536014)(8676002)(2906002)(4744005)(76116006)(66556008)(66446008)(66946007)(66476007)(41300700001)(4326008)(64756008)(6506007)(122000001)(186003)(55016003)(38070700005)(38100700002)(86362001)(9686003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyxisefvpB2jPrtmRKV64P+wwTxnsHdCFbNQw9KXopN+3LRyTNiEKZ5YEfKp?=
 =?us-ascii?Q?vkiZc/wpHRa8dwtan92J8nrjLYKfmdlwYnjJK3HgKwO+n8rfz5sAp7+EfUAZ?=
 =?us-ascii?Q?6VFMk9Xe9Ul+nZ6LoDyflR3pQFaxZmwKcpcbHORDAl1FEEOYwwNvabgnY3Ik?=
 =?us-ascii?Q?8O8G8wUwHbiwbYMo/L/emP0mgOBGVUD2qPeySC4KF5r5ZBxeYmTCpCzAvNRW?=
 =?us-ascii?Q?lSowIil/ihxzlmgC6+p7hcxhMK/D+MY+WKm9RSColeYjUDXP9YhJp2NI5CE7?=
 =?us-ascii?Q?GM3PHt1OHykxyc3s7UvlhBGoj8v81YCd9WMgeAWL6Vtje+BSvN1/IH3cE4HJ?=
 =?us-ascii?Q?wXTJm795HdIoLeoktZ0M+5cZOG8afrVOmoktGxRtSClXJ7pPWYmN18WTuXC+?=
 =?us-ascii?Q?B3P8atb1Pqee9RWOT93tQV8otLCmSxsXVOOAZ13aLyJgMOp6JDTlW1pnEheG?=
 =?us-ascii?Q?dCGb+bbKND1Q4FSp3Qar+aNV5GzCuoHsrBokOt5W281OIHVBxRlXBTlERaNC?=
 =?us-ascii?Q?LlTl9FKXnk9g43W6iZshcKBq8d3p1oHqNwQsCg0VUq5bMb+bMcIS9by/Wq9A?=
 =?us-ascii?Q?GIMcHkNhl82/j10jHLtKfPrdbpq6TFgSNhobX0WBXxBmdbYbHaLxB9xLgXVg?=
 =?us-ascii?Q?DjKd7ic2519grp9QTMjJw1XACDSyaUM+jsOALP8FjKRKajtCq4stqVnfmSRg?=
 =?us-ascii?Q?eAhAekRvrYB9cDo5FJoYIe42Ikyui1j2/1JLVOidUEqG0rle2pSecsal1XT9?=
 =?us-ascii?Q?TiTP6jZMeyiFAHCmU/1KCxuCuZVGgB5RFblUkeA08ZONaDJWv3xXFxBEDQ+z?=
 =?us-ascii?Q?OAFtSW8H7HhyYuZ28VFh4MDPQn4Cx4gw3js6DabZs7IaHNrKRarQLJsLrly+?=
 =?us-ascii?Q?TN9NfBRYxSaiFZeISDYc68q6Uxt1tITqGZAluxgHhO/sGNORsuX4xDrN9QQ3?=
 =?us-ascii?Q?jgud/7pjBhzd90umzD5l2C6O86KZeFEEkb1mXbJsaJ5XU4tLL5IR5yCpn0bC?=
 =?us-ascii?Q?N3UPLl27XNNYXBcaztfna2Bjc88shnYlMRRCg4Z9lep3NwV+swG63nhbdQCI?=
 =?us-ascii?Q?IcZRZpZ4JP8gE36H959zK4fXGdPQqCLP5UqwisPZNTtuchbjYiHpaElrIWb7?=
 =?us-ascii?Q?TDBQfvkfF7bbXRKrTluvax6U8n6w1MTl45pIFiMWaGKOXXi5xTFy/KEA8qgZ?=
 =?us-ascii?Q?pIs2vEUOKlnbMv2bAv+8CPHc7FQ2e4Niuyvbq9fbxoCuSCHu58auXLYTOqUg?=
 =?us-ascii?Q?UK2+GeXWg4+zSmrnoEJFs4Gt/Oe5eoFhkGJp5WDemasfMR3UI40toVWlTSxV?=
 =?us-ascii?Q?/MvFGv6HFYcbwRgfBd7S7rDn7wgMutn0RQSbMjDoPrbslKgaUmYxrSodGTIr?=
 =?us-ascii?Q?Vd77CyMZqDUvyZfaHcniWZy4q1fbbcVr9nQ8cAwc1voMVBmJ/QuMxgVhnMOB?=
 =?us-ascii?Q?erkXM4VfaMF5ZJI3PvIDybdAbBaNCuEf3NLizJRU5p5/SR3T7oGd0NEM/mPK?=
 =?us-ascii?Q?OOPRQ9vcc9nnt/mN2ot0tePF1CsMF5zRc+tAPiHG1p1MJpISOC1lYIF0opta?=
 =?us-ascii?Q?k46YgfnCAZ/yEdgXwxrBZWBaShDXl9rH7pETeArZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50536a9e-17bf-4e03-0133-08db215da5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 11:50:30.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KKSQlIjL763+I5V0tknfpsFq0iiRQa5JRT2qVAjAYZQQ9bBwLNbznSaJ+wowBZad/WfSrfWszT/1eR5CP8FPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 8, 2023 10:26 PM
>=20
> Support an access->ioas replacement in iommufd_access_set_ioas(), which
> sets the access->ioas to NULL provisionally so that any further incoming
> iommufd_access_pin_pages() callback can be blocked.
>=20
> Then, call access->ops->unmap() to clean up the entire iopt. To allow an
> iommufd_access_unpin_pages() callback to happen via this unmap() call,
> add an ioas_unpin pointer so the unpin routine won't be affected by the
> "access->ioas =3D NULL" trick above.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
