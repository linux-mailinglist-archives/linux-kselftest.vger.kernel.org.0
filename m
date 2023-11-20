Return-Path: <linux-kselftest+bounces-286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918C7F0D7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF71F21D48
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC5E578;
	Mon, 20 Nov 2023 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABLQafcY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F874E5;
	Mon, 20 Nov 2023 00:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700468798; x=1732004798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xS58H5I/SG/1yNRCWjeT91hsNhNIHwV6cMjaC+kOU2o=;
  b=ABLQafcYD5cJeF8BLe8EEDwOjb23hGvf8U51QcSW/3gj2htCau3SBIYE
   R+KEdKzhZHJoO6JLN3UIxrK/lv1MbJNxyaCKP7v/iXPsUbGJAo7fzt8BC
   qfk2nDgmz+UESNGwAS7a+Aw6sev1DbkYfPICIJdl4WHQUMLn00F0Yh1Yo
   9dB32KaETcsIjSOtOVd3JZnN9cxGi2Q5NaeGrqORjLFdy7nSacT/lrQGv
   pp4v48XZJ220e/OB75ySO1jUvWi3Rw0yPwiEX2lV+gq9Ty2BS2T7sloJP
   JnIbARdKLFFNUVCl4lR5d5JSiWrrJm7G0i8lw6nafKukxrBfLt3rhjyuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376609799"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376609799"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="801087652"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="801087652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:26:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:26:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:26:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:26:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:26:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHQQCqrpdKRprgeGzGJqXU6riqNaTfifndrIAODowFlX+W2DsCsRG5LPr33QGWmacwZalkz6KQezeXBCap7joNvUhS7RLMKzPYQJSp9NpRS/HXZgbW8feWmxexlCbpjipsdsvmJBcR3fI976p6/Rmsfq/WfgxCcUhlqEsjADf5TfeKRkvPYrh2lnnNPj/2iLA0AtCnHdELpbWXY4jx0VAQuEivApgJpOGe9J2CLpAPfuKThUk6Qw+8ki1gyY+a6yBMUTYmgcLjsqAE2td5eJoTkMYP03CXw47T4q0R+Otvi6WdlFLyU8Y9gOq0VuUH6nhnZOFUs0Dm6tnI0LQCPVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHaomRCS5lpqPzf5jUBF8wsdStM3bByVBReVGNadhbA=;
 b=Q9exrrFJ7h4oUzlasDST/lbGoqOsBzLfcL5v3kl8sVaNSRxrHombL5ADYdEryLOGYNr/UMk+PCtLK2GM4Dsmo4iTtOundRqydoZdPGj5icgm8Pdi58bhp8HJ2YMgT6p2reQbKEgh0sYf9NoTbCJImeaJzv2DJSju0OVnlVs2E6bdzp/DIFNr3znSmXD/wCHTkLSqv8RTBSbseBdoTyhTWzAjyK6Zl5czZUHBDwAGgyk4TpARTT1alDVkXumAAH/GgCkXdtNOmZ07rpRQsxjQGUkOBMVObH5SPSHTjoJzOrIFMnaMu5L4FFc0JyAgiRyI2LhSfEimDgiV7rLA/fMuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 08:26:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:26:32 +0000
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
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCC4vag
Date: Mon, 20 Nov 2023 08:26:31 +0000
Message-ID: <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
In-Reply-To: <20231117131816.24359-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5995:EE_
x-ms-office365-filtering-correlation-id: b261aa3a-b5c5-49f5-bf57-08dbe9a266a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcPsRS5LfOICKw/MTBw6YObsuyElMpPMtjtdmphin6MIGwGSSqwmS/QCUqFzLX4X8YpfJtkKWI5EXKmEGkI9yPfX4dCksZDf3zBxKJJSD7h6x0X/eT19uCycM9FkKJFfB5RFLksHWEDNu5vHHFU3k6IH1LNspuTZlEgy28LyHQGk0v0q6VJX1fBGln0x8I6sO3uEdEfnvFTMRUpxalzAOfHY+h+NFrRCTsZ2cq/tvZTLIbV6nWr3vL8YfOYfD5iLxKeBLr72LNdE6PPuuo0DsKMoEx7LKQUOUcyJnoY8fGIzswJ8n0fxz3NgcY8W6pYOgWKhvh/bnYow7yuLaQOgMZwH/ClZNyYUCZA0TiC+Xn1tLjUo7Qk9cLksblzgHc4a53JKnIXQmLVdX+9VjxJkJ5wgdysAaP2plvZRroHaQ+pCIoQrC1HykUoh5a/yYkdqP32nG2qX+GWD1nmsGXKnN4jOOlxFbvDbKzHIt9apiVtqPJJHb/aI/Id1t6+M//EtIrzOa06/TXTMaiLiJarjh0Fo4kfX+WjI5JbAY1nWdqkzxGLYR7nuYhje7BJWABy/N1FB7I/yh6KeyRFdyhDvPHf4bh9pSOFiu9fFLAmnJp0TJhyv9rxEqIsGgHFjpigJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(76116006)(316002)(110136005)(66446008)(64756008)(54906003)(66476007)(66556008)(6506007)(7696005)(9686003)(71200400001)(26005)(38070700009)(478600001)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(66946007)(86362001)(52536014)(5660300002)(7416002)(55016003)(2906002)(8936002)(4326008)(41300700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgIfpCEbEEmM5VI0Xcn8NBdl9S8FKh2bWd110T2lce4QNEKSFwehSNKBHz97?=
 =?us-ascii?Q?/my4pnEmZd3ySSudw7xOUuffqqJpTNFH/3X9UZsNomWPOPgpJJ6ttG0bpGNd?=
 =?us-ascii?Q?1XCCt+B14jl1JVxTsZ8xK4Y8/GON6qqVKuZACM7bdwd8fnjbg47i3GMLn3sG?=
 =?us-ascii?Q?uJeQyoc+spx5qLw2pMBBtjDtpz/ljOzHb0WEit7T9zg65mVFP0LDZUVJvG/I?=
 =?us-ascii?Q?ADCF4OByT7zl5YU5nJAchEexOKrWrEBFROquJQ4dSBGoFKljPvan5w43CxiI?=
 =?us-ascii?Q?GrdLvn7DdjjmqDjvEBzYJA6lWRpSgdYbs8TQezHyfbneebyDRuu9UckNQouV?=
 =?us-ascii?Q?g6ZdjAPa1ZQYZrlP0wljddcx4QVgJHjHZc2SimNpOPY4grPP02d5IylU5sw0?=
 =?us-ascii?Q?haDvtGnNi2/DKO7Xgyp1HH3jeiR472D6c2PUJRBjlLtWUyqLmRKIrtslWNlJ?=
 =?us-ascii?Q?JUKNYq1TRy594HAbKEPHlqPbtf+6RSS/IZ11o6ec92aZeD7qmFkVHXTpy2Gt?=
 =?us-ascii?Q?2DcPLDsYSTE0vzRHufdzzaj0OkG/nNtYtBuwAxu9qdq5Rxd1N8W3WuIst7YV?=
 =?us-ascii?Q?0dGgtTKwOW7WcN0Y/I12xavgEeK1i1xKG2cX/57KMKmoiyEICP0yo6M2le40?=
 =?us-ascii?Q?BiheMhQ2zYFajgToHUQyWawTaHAl/6cwyNSsP4j66Qq6MswFxDjzamYSKAkE?=
 =?us-ascii?Q?1tneuIOCmkJ5qqUNKJrfbO8YALSAg0l283jO16DV/52SrpYtjV2+twSljvcz?=
 =?us-ascii?Q?f3aoz9qS9G6rlvXuiBYB+8v5itGDb1iSYRoVdii6fdZLvcZT84p7MCtiqCpt?=
 =?us-ascii?Q?c/gC28aUK/Hnkq72EUIymjIUcNO3mNVtAmXmm6kdu8rsNG490W1nQWJERwL2?=
 =?us-ascii?Q?kKhiEIvBattu7jG3HHUkNdGLLC2pR+L8u7O1OrlLgeMfAlqzX7I35Ih8Ptu9?=
 =?us-ascii?Q?+Ms1KPK+8BpHmGCm40+BMEgSh1Cc3rjmRFV2INSeF5ut3yYuajQbTVR+olJv?=
 =?us-ascii?Q?zS1WqMktqr40vNWoiiyz79tctEj2XqLz+85bZMQb6diXoWL8kpTZpd2v7liL?=
 =?us-ascii?Q?5+MMlJ7G+A8YnBNMbhvbq5cJHk/VAD+w9bj1e4bw/L8/dB4TWaJLcJlYDCXt?=
 =?us-ascii?Q?evEn9p1dxmIK2+7Z5hfY8d7Gq+rHr4DCRDPNfW1t4GsKQp0TmMYWRhGFIsdg?=
 =?us-ascii?Q?jwZEKxotpo3DZX/avgFRA+qVoSAT12lPXsEjM5WPutz973O6X0HMPV3ZN7Ch?=
 =?us-ascii?Q?klB0PGZTv+PECCDM6eoFZAEuOyqEVbnO8BO/ic+EE34TAwYohzpl9Adf2zXR?=
 =?us-ascii?Q?Tlt0Sups/lWI+E829LZ/Pz+uh70h0wTwzq8ZQzpih/NSQyVPBQOxUAAYMF0s?=
 =?us-ascii?Q?Ykeg9BSIqBkEv3ftKY9Ps/Sq8rqGWhk1OCMLVIad77ae0TzxiIpRdJSEkwPH?=
 =?us-ascii?Q?FnlA5E3fLkUimOTlOictWYYJ0bKDQzvPG4Sa7Dj+Rlqsz2bq6VIx6oAgplgT?=
 =?us-ascii?Q?sF5DFsqK40hOYfc0Tvdsdccw//fw76kyy4U3R2j8BMLrSwTHCVmpzmlC4bAX?=
 =?us-ascii?Q?sRsLvMjhCzSsi0W5tBASpjIlMtfd+NgJRniT0IjD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b261aa3a-b5c5-49f5-bf57-08dbe9a266a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:26:31.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRNKul8qATZQkMuMdEgvObvNY63CQUBW0h/uoQn7F6nSY+9/8QWjgr9sLl3ZIsHyWcWp2SZ4DBvwQXCyVg6/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, November 17, 2023 9:18 PM
>=20
> This adds the data structure for flushing iotlb for the nested domain
> allocated with IOMMU_HWPT_DATA_VTD_S1 type.
>=20
> This only supports invalidating IOTLB, but no for device-TLB as device-TL=
B
> invalidation will be covered automatically in the IOTLB invalidation if t=
he
> underlying IOMMU driver has enabled ATS for the affected device.

"no for device-TLB" is misleading. Here just say that cache invalidation
request applies to both IOTLB and device TLB (if ATS is enabled ...)

>=20
> +/**
> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
> + *                                           stage-1 cache invalidation
> + * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only
> the
> + *                            leaf PTE caching needs to be invalidated
> + *                            and other paging structure caches can be
> + *                            preserved.

remove the words after 'and'

> +
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_DATA_VTD_S1)
> + * @addr: The start address of the addresses to be invalidated. It needs
> + *        to be 4KB aligned.

remove "of the addresses"

> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 ca=
che
> + * invalidation in nested translation. Userspace uses this structure to
> + * tell the impacted cache scope after modifying the stage-1 page table.
> + *
> + * Invalidating all the caches related to the page table by setting @add=
r
> + * to be 0 and @npages to be __aligned_u64(-1). This includes the
> + * corresponding device-TLB if ATS is enabled on the attached devices.

put words about device-TLB to last paragraph. Putting it here is confusing
as if it only applies to invalidate-all.


