Return-Path: <linux-kselftest+bounces-288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864E7F0D98
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99CC1F2223F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A11F4FA;
	Mon, 20 Nov 2023 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8dy7KXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4929E;
	Mon, 20 Nov 2023 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700469139; x=1732005139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hu4NeYU0usREUCRf4bfLN5+gDD5KOJ5ZYh0k6h4YJsg=;
  b=B8dy7KXpVeCIyDwHph1lDjmThFw3P7nRkYD0hAR3uNIkpuCph5ctPBI8
   zrReJeZZtFwufkSusjg16nZyhlzrTQ25iWPbrQSu1N2Ia3xySZJRrXQ35
   N2Gz0uYv24urQb8+xHExgmYvqWw9VMeGqskjNaVXCKu9MzjWS2wNbnQ6r
   KBeKg1eJW2fwLq3xph+F7Kuc5qG0JyZHw5kku5JrajoSxBBfsVTli68gx
   YIK58gAeB/LydJxyrJflCflT4aniej9SAIH7oO8WUuRCa/HsEClN0BKbi
   2YBG+70TUNhIDjmN/kPbKuC2vPZqWcy6rU2sdqvqphP1aC8LgxF8nn3FW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="391362555"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="391362555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7632350"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:32:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:32:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:32:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm1a9Sgqc9n1pFCONuU8NlrhI4etFfO+1GEcWnlBv7YqVM9wUfbTnHhPSHi18UUciTtS6wvDrNpwvDZwDKQ5RKfjWCJoAjLJa8OKunhjRSMOJCEB1hfMhbMVv/JgICUunPfnF6IzKelcafyt4CI1qy6I7iReQ0YBGgRNIjkiag7BH9pfOoNDe330tS1IXtRFYXT/NtL6OwHHhd5nV/ABwG6RwEsGEltV/Hte8DdmM98L6aUx+H1uGLb1xrqNyEqJG+/kGMiWWn0HYiKqCq+V8plI0yXmWZrm1Y7S1Q0bRQNaQs8E61G3U7mMWeVmUysvBnSF6jvVeUN7VmKrLcyVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfWjqgG/RWud1IYd4kszlowYT9VF0OBsVoEEKdCNuvQ=;
 b=asnsqYTHsnk4sJIFh9YUQXDavZtj3IDqT6+FEg3r74INOqfJV5/5htYOlm9wEDfeRMTHDlyf4P6KQtK+jLWd+1AAsTSRYJ+g1x0kjXx1213y/zj6BVV9xscpe0lsTW4Z1MwiJq9CXLa8upSjgTPOBNKnwDKJ+hr0/ae1KIWcfF440qvNu16/vAJWkQChRs4DkvoNyVlSlh49QFlXlBcbYmTGlufJf2u3JEHUICOpvIz6HD210XgP4TYXE7YI3dyfss8xxTd/rmiImjbGoPl9zcjFggBhCIdy0SJBo5op/uBK2lI0ziAeaY5wpcOyXuCYDg+xWE5E5We65e6WGGYBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 08:32:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:32:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaGViRtZDYl73wL0G8DOHg0rG+PrCC5SoQ
Date: Mon, 20 Nov 2023 08:32:15 +0000
Message-ID: <BN9PR11MB52761F99B115765CCBCAC9F48CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-4-yi.l.liu@intel.com>
In-Reply-To: <20231117131816.24359-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8549:EE_
x-ms-office365-filtering-correlation-id: 985ed2ee-de31-408f-b619-08dbe9a33392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ge96ESleZi/73rNZYfcXlUAcDK4wuMr9VSYREkfh+sqq173nMrUTOKi8cE3RMsCyeCCsF8mP3eAjNHUT3Pz7p8E8rPn5JJABQAmaP9CdOBLetSW7yJPLweLwEap28nADG8yf8tb1G9o+sycDSJktnVD1WEw5L+BO8ZRMpuvCiyVtTCwF9VMF2pcyP1geKBxDf4o1aNlByMnJt+xaJAJ77jlQK+HWvIxN4tJqEEvY4NdjivhXf10KGM7v0q8GQf14nTTopSdXeMgCktVvnO4MBClZQuWZbVaFp5g/Myr+/Jce6+8siA/GPg0wk1hUphnmZC3LO9urUx48qoRe6G8K/ZjKGUlLt2Xf29sL2nkBgXl+gKmHK1a4Esh9Z47sCkbX2Wo/BDI7a/qzbjvhs845VvshFby+uMP8rcUBYMMktvx36gs4vQGmZZAn3VQoPNLQOdezSWk9RqMM9UrHtYnH2NizRtUn+9Zudw1mWYH1e3Omo6YlBlh7i5XzXkydq4cFlmQnztkgoe0iSfyHo8EDuYLxzwmh4k59v73TqzfhfZt2soezChU8OkcO6V0is/0+rv5jiw1HN4O/IJAizY+AJCo/EqY1i8DnBmJZpgRbhQOMvJKkrGVh6n95lFQnn2nn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(478600001)(122000001)(7696005)(6506007)(33656002)(38100700002)(71200400001)(26005)(55016003)(9686003)(82960400001)(66556008)(66446008)(76116006)(316002)(66476007)(66946007)(64756008)(54906003)(110136005)(558084003)(86362001)(5660300002)(7416002)(2906002)(38070700009)(41300700001)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+0pvMT4THnhKlaID4UEkB8sYX6F2YN64wGtN7WPZjb2AnNvwzuP8Zw5isDP?=
 =?us-ascii?Q?X+x85N6Dvtrtp/dyccR2iiGw+3LYMxJtgwTQv+NE9S3u3fx8z4aOPL94wCbD?=
 =?us-ascii?Q?GobsuH+ABp4ErEljT1KlH+ai/9G3u4RMV/ZKQWE9v6yA/5S/8E5EMLEYir8K?=
 =?us-ascii?Q?RRzD781Cw3ccoQjtciEASM0e4jVVgpTMuvKsJIKKMCfcDzYH1D1sjoLYQPW6?=
 =?us-ascii?Q?Hcomzd08Mfi90TFU4qSkzUqnL63yPXKPuflIRhW7rr6v40o4L9wmdJ88ood8?=
 =?us-ascii?Q?0qBcwnKgPuvXOpo7b0My4C5NJamfMsVXXKARznJr/wo1JzUjdFJD67Y11GR/?=
 =?us-ascii?Q?R1ZS9QZlEfbvvgy/+EFbk6f4WvKsqlaN6f+LX2WBlHgoXO0px9soXwg7Rzou?=
 =?us-ascii?Q?C1GcELHoFBlj5oR9DTsCTcqTSwbA4qD0hC1vOnC2CUsWx+A2oavpYL3fD6K4?=
 =?us-ascii?Q?Ws2LvXRJiiV80axedcR5d+xZEYtYqYTV5W4HcDqTJiwFaWB5fkkIt8fTtiXK?=
 =?us-ascii?Q?cofGgLPW04e5cBDC7x0ibHr7otW3GKVRP+2Ip0WW+0CUA2GiZdKX95T3XgCz?=
 =?us-ascii?Q?no+9o0i1fS99N6GgrsLq6/tyPCGP7YO8AYturDw7osSeH8e3KNCgCEza5DHK?=
 =?us-ascii?Q?PNFMnardzWLGC8/YSBkztFHvLAVqIN86TE7EOWti96vj/VDKV5/CY1zBaVvm?=
 =?us-ascii?Q?V1ndChHNTX3p91PAeRGUwlkRBJkOcCvtWdUFfjut/WqDN0lJ7hkUgWIz0LnG?=
 =?us-ascii?Q?VT5o6iu3vc6XHuCR8GiCDjNBfLLAPFU4XFfnnnXxxR1p5pNeXWtSpraqBazg?=
 =?us-ascii?Q?MadSlfyqQEQO5+6+Ii9NCc/n3NsY8Hnz6dh5fFATqXXIcBT36g74SFkCQIqU?=
 =?us-ascii?Q?wH+gsgWUo1H2Mm4vgIxJw8bSyP0lyxIhrS/SFMwtDzPZPZnXpxXE81MIVXL6?=
 =?us-ascii?Q?g0O171ZZKdx7DxFWsIHiV+LLjsGLp262LGoadFjuTYh9idEeg01W9JRiNIzC?=
 =?us-ascii?Q?PL9lf9sA6fVeXQoJHQW0ZkU/qMhTvpjhgb7QGPbeYc2GXouW4Ke31SRYgs69?=
 =?us-ascii?Q?/XfniFl4qrrdmZMPm4CY9SWZK89iGzhA6ZR5NDSuAUO3Xs3dixEHyurq0gdn?=
 =?us-ascii?Q?tDZ2pejbZQk+p1pqy8BNGvXTMQ+tilARXMoIK/VUtorQ+mTSDO9cz3tlFYVN?=
 =?us-ascii?Q?5Qtyat+5Jkh/8QbiMtBhYxRFsVJnR7DG35LkaKn78nsMxkdZeJJP1lRLesZE?=
 =?us-ascii?Q?5q+6OX0b6u0l9hjXHX2I7GaKcGzoSPmuY3zI1wMds+eeVw7GkHg8/VAB9E2T?=
 =?us-ascii?Q?sKHPxMrlubfYcqcHea5SxalPrA3hBKoi/TgDF0G969zY9f1wk1b/wGe++VUt?=
 =?us-ascii?Q?saXdAf1imH/QwA/jn10jePy1rHu7spwHm/mvpDupsLwc5SX4oUMX8ddjPN9w?=
 =?us-ascii?Q?n/JBnqVLRpHrq3769h/xt65FVd7v3mvkzLjLTy13U+LlVsxfrgSEk0jzpAv4?=
 =?us-ascii?Q?S2YYT3q14AG2vUDaApl6ibMMMt9ZPWcAtWDw/roO6CGP8jRN9QXJqn4npCUP?=
 =?us-ascii?Q?ZQkhdCtIq5+lgxD/GzNVGaOdES640W6aKT+A6xU9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985ed2ee-de31-408f-b619-08dbe9a33392
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:32:15.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfdrQzeZkafGMuy+D+hHjoufAUFk/oWR/WcasqYLYyN65h9yA7m8scdly9T1TxcMdxwY3Sxliid7g5pcMT2NGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, November 17, 2023 9:18 PM
> +
> +		if (inv_info.__reserved || (inv_info.flags &
> ~IOMMU_VTD_INV_FLAGS_LEAF) ||
> +		    !IS_ALIGNED(inv_info.addr, VTD_PAGE_SIZE)) {
> +			ret =3D -EINVAL;
> +			break;
> +		}

-EOPNOTSUPP for the first two checks.


