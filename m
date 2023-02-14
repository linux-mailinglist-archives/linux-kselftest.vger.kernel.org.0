Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11880695778
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 04:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBND3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 22:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjBND3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 22:29:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606DA18A92;
        Mon, 13 Feb 2023 19:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676345371; x=1707881371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AgQu1u6yjJ7h2aQ0RuFoSxKN4eLMMEutPMEvt9Ydxeo=;
  b=G4L0hrZ5QZzzgpPp1b4doXqkITzxk8CjxDCHj4tXu/zMxo4SKLQQzThe
   rUGny7FhLuRLMo9GIwpvWt+61nv10d/1PhkFqKQKKGx5X8F8d+YiTCAjJ
   NmPCU5KofN8O/dvezIPO5l3LLP65inmwKdKgH1MNColOSS0FPk3D5CL9t
   /yeXS6R9KzmnQrWV6KbMPx10qZ6SRwuNfbuEuyLsR6zn92sJyYt+s9Iee
   uo2+DDIz47lE1r2UhuEg+OtOznl9ft/5/DZgn2cXzmrK7KUkRZV3V9v8c
   rKIx5e5JcWgu8GWi24yrCvZiCaB2hUKhAvD5vv+u/eLzx0Jn/X0ak8oIT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319097636"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319097636"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 19:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757831165"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757831165"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2023 19:29:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 19:29:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 19:29:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 19:29:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 19:29:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drktwwomBZ4Vm1/IUd+WPniVrnDit9mtWcIM1BFZ4Av/ZafWOTL9GCf9tDUE7W97IJJjkP0cFU/eJEcIS7wIA1a6HJH6gRAbVT6Rgr9bF1EvW489dXr4RC7KVH1copJxfZQblOX3RZApke6IE4RbF6WthQ/rZWvUtQts7Y92KcnjcY+pjaFeKIaJyurAWeJIqaJQTuHlN7A9JHreZJNJUNoyOhydvsZS5dm+4EV1CmdC5uDsw/QAxYX1a5ruJAJfDKFVRUBpUfeEK3S9Rb08hThKnigx0a/+tptoe3ARcrvAeNdPo6FqdAS4FJOWyXmduO6fgGy/Seq3/e178AHtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgQu1u6yjJ7h2aQ0RuFoSxKN4eLMMEutPMEvt9Ydxeo=;
 b=HgGLkFX61wcLfOO6xG2u8l/sk+HuOXcwUHO+hGieE7V2McIJydSz4XFMRwZGDu0XDtf5ODkziCSw5vUJs4LAEbC3huzl0JgUttHZxU3VUMTqovHItREXGWvGL7pRk9oelC0VJxmDNTxryHHifqFpxplG8rotip8f2H+FaZ6PE5Q/ix3Jvxh0trqVL58qqQCTB24iw7CA+72H4VJ165L/uONWgqGbd1ulwACdiPzheSPvUR4tZCSXECzu8C7dJo2Tg4EC/L11H2AOwDrODJn1lCOGnibFUBJnWc1G8BcZzFQGBT7iZL1NS6sPI0/TomIDuSbnO8QLF9NwgHyy99UpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 03:29:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 03:29:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZOzoL2+M6IjP2sU+QmVuzFLJejK7I3qUAgAAO8wCAAz6N0IAA0RMAgADVBmA=
Date:   Tue, 14 Feb 2023 03:29:26 +0000
Message-ID: <BN9PR11MB52762F851C2712C2682015068CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
 <Y+bk+GSCPKOJfr1f@nvidia.com>
 <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+pNEtgyAJwLjERa@nvidia.com>
In-Reply-To: <Y+pNEtgyAJwLjERa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 53186b55-8cb7-404a-b62f-08db0e3bacdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrhleqZTT3QRg1ifBmm3yhjExDDO1muB+YBKeMp/A/6KKcpsnsRQc6xpbnKTj1w6kvvu6l0okqJKbKEBbnkidXQXxhigNS6gomMkDNiw5Jh7wysqVkJ/3Tf6WEm1Jvq0rGSDCi8sREFnDmR7IrG5r3J1yoWxNsyL6LjIvUpu4/qviTPOZwExIVlOfhnaDM3+Q2jkKmkDADc/4GWL2yLW7tIGonbfZWdT6rs1p46DZECcnf9ue1iSrWPzNrF/XECu2KyUrHvnrupIqgb9RoH/wqvOUxo2X9P2gqY8mzWkRIPBZm0o9pygLlxknmVYm7YvS+bV8zAvJt9Z94LcBIgUI9ciQDcC9h2hokN1kuV3iS3if6AoNf2NPIzun5EILJuhCy7I2Avz/q/t2SXF7sBdZphwDM/qmiUdQkPDKhoZbCDSucsRbo/fB+4qobog75eXJxVPFWCdb9xZP0jYFtOfToZhtZEuWrFIi8CxqAATO9EQeiw1oLD7ijAa302cX4D99LFqoKaIIeZBmJlA9GSgbgSFF4zk8BUJTO8oA1yEvgyh6NB/194h4T6aEU7TK0UBtFxpl7Pe4skmSSHiVkwTx3AGT6Zz+Z9yOVWG21qfnqXTNKIIRgy4Lhanf8u+YhfhH4Fxq1im+zn8aF8/DbOJsvqrx9y1kNK8njXCYRMeAJpcDcFDkEdvObmjiIYbj2C1Dup/SZZbhYAZIZVrrRoi1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(55016003)(83380400001)(4744005)(2906002)(7416002)(478600001)(33656002)(6506007)(9686003)(26005)(186003)(7696005)(82960400001)(71200400001)(86362001)(122000001)(4326008)(6916009)(38100700002)(38070700005)(8676002)(66946007)(52536014)(41300700001)(66446008)(64756008)(8936002)(66556008)(5660300002)(66476007)(54906003)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k9AEOOVJCr7nBHntDwK/zLy5k3hzkC8SPnmFLzNFU7lUAT7ZrlItqX4MFohF?=
 =?us-ascii?Q?T1xG+qMBCSBHdzPbam6I80T+cZZyn9jQ/KtJ+o1aBCYba8q63jNvPwwxmagV?=
 =?us-ascii?Q?sk+kzd8rCDRXIp+ti9JdWV2oRNWD19o8TWD4Zot6+z1JoOKl9Bdd9eB4YVZW?=
 =?us-ascii?Q?RclzZv5uI1gMGQIP4V8DzkV5QC/5tHJLm5OD+jF5ms96PZiRYzsYYPVWGFld?=
 =?us-ascii?Q?0rsSTnQs5m8UG52le8QS3GSIo/LOLyEGU6miLVaznHtIIbjhdpnN6b3s2iNP?=
 =?us-ascii?Q?kN2DePvzOrug8uo1RShO0BoiHKhlE93s8GNJBytCyy83WY72stv2V7MZrD07?=
 =?us-ascii?Q?VEwlgGEmMlkesxT6O6IeX0tLmqPEGompb1MN/2OYqJQVMbP/sB4sEgqW2MMs?=
 =?us-ascii?Q?ZAuN7j5wiLm3j/VxPGoVaw+7vN+ijiFNACfkavmL8/V94fCRPp5mHdCElGwT?=
 =?us-ascii?Q?7FFUbI9rKWjdAlALWtXxYbWsTgDLBZl0B+H4daT6EsoKSIBb0Okafn8QrYAx?=
 =?us-ascii?Q?Pfm8tl07eH3hE5zkBm82MZTdnJmISlFNIo1A9ddGyyi/k2J/tU4GZd6o+oz9?=
 =?us-ascii?Q?jCulFPA/aoEXYhu3HWrxt7xUnPLZsGV5cMjhD+BZBtmTP+Po3ooCVlniuDpf?=
 =?us-ascii?Q?hizdu30ixHkMWHB1lC50RGsDhnaOgTojouvDZmAtaiuFVgQx6wn92rp8oqn7?=
 =?us-ascii?Q?Gth5qvhmySB1udBSeqeDnNfgJ5UP4nbl5IWrrLqi7dPop74R/AY5URDaqfHW?=
 =?us-ascii?Q?gCpw98Asd9DaIY9qlq92HJvBVMM2YLWpjjTndYzfqB9K4uZVUst+TdMXw1ej?=
 =?us-ascii?Q?1L47Uub3Z8YYSoAgvuMeMr2xKoOn3e1U+u1JzF7qRqzuRgoA9EaGaTV5ZWI7?=
 =?us-ascii?Q?YGro70MeM84AB+vIPQnqgyi7T5oNuZQnKyzLGH9dex2vXSsll766s1qCE2LA?=
 =?us-ascii?Q?brLRG+XcK5m7cq3B+677NAEp9oHpQm13letOZ+q0P6mCJX/ARpmOMY21i170?=
 =?us-ascii?Q?DUPlBfoJFv88SgmYzpzWC9wjDJJ3hTUH59VSSwK5dXUQIND7Gf+DOEaPxIYh?=
 =?us-ascii?Q?IVN57/O21RwoeIDBpK1ogxAEAfpA67hInvYLQyKk3Ft8hGHeUPF5zG47C6DX?=
 =?us-ascii?Q?E50arC1Wn6C7CRZVKRYTGJPdrBO7I5DRmt6TonA5bz7zJ4sPj3DMc5y7vGeE?=
 =?us-ascii?Q?14plcNRNvq7+dQ8TvenQ3zZTlg9lDQEKUBbi35T4TCEnmpZkrd7yHAQn+ni6?=
 =?us-ascii?Q?SJ5viAtoWzuEYqbJknm5pCPtm8v9Hxq8LxL6sw/oTOGpvAUbbeOr0qwkkPDI?=
 =?us-ascii?Q?vxLYEo7svMBCmcX9S28gqWlBgPkAxTq+gPolzXB4wqEBlG5sUFNe/BKUAii9?=
 =?us-ascii?Q?klhRqiJSI6ZhQ0BAgeDL4rYgRvjsiDju/1V8tS/uWT7xhMdsrfTBbHgmDVzj?=
 =?us-ascii?Q?sjIhOAL+wx64Q+gJZc6WvDqaSnJx2ak3z1sEG/BXF/9ojCBY7EVtlOw4AVBM?=
 =?us-ascii?Q?Js+j60Rqjt8iPdrORwBiyiDUuIe7itfahOeTZ+wyBhFoLPflUPt7LQrCCxJj?=
 =?us-ascii?Q?fobE4rpE//BesERsa6PuoTMr9c5PGXExq/OKX5Gt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53186b55-8cb7-404a-b62f-08db0e3bacdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 03:29:26.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 145iTsC8LgKmDYi0065YZNFet/VxyM4OjgocYJO7NOdorC/sekEOTTbDxDOBwyPIP/bLxCTZNiP+34eLBAsMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 13, 2023 10:46 PM
>=20
> On Mon, Feb 13, 2023 at 02:24:40AM +0000, Tian, Kevin wrote:
>=20
> > > This is because the cache tag and the io page table top are in
> > > different 64 bit words so atomic writes don't cover both, and thus th=
e
> > > IOMMU HW could tear the two stores and mismatch the cache tag to the
> > > table top. This would corrupt the cache.
> >
> > VT-d spec recommends using 128bit cmpxchg instruction to update
> > page table pointer and DID together.
>=20
> Oh really? Such a thing exists? That neat!
>=20

yes. see cmpxchg_double().
