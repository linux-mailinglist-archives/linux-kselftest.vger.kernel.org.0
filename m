Return-Path: <linux-kselftest+bounces-2492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B682C81F550
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 08:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693EE2813A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839313C1D;
	Thu, 28 Dec 2023 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2iJj721"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222B3C0B;
	Thu, 28 Dec 2023 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703747514; x=1735283514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jvcHykd/L2dtKgTrTncTPL5acPllF9LIOhfyrmQkBQo=;
  b=b2iJj7218cuBFrNUK6IVuzXhsK/1lTuPe2j/M8kUIk4Ad9rhUysBL05G
   GIjVALnVtVglYCKjgozjqjV0OhyNbNFGhmeg7lvEZ2F+JAU9r1+10dMuK
   5/rTLH/+nlr+ex0F0YV3FhxmCh6FWpGSqko1zE/dHPlgiN3geXZUMTK4D
   PnJrxTDeLpveuXRATd8H7lIl/M+byv/JiW1WgVN9pWQ8fyFzy20WHIT5n
   QJn537HkeWiNpc2fr+PqP4p0GVaLBP3TeBcklubOJFgo2oi4+cYv/N7q6
   NBi1Cm9KfanBpebr08T/1XJVa+VLT66P3Rr7hSVvt9OaJN82H5eZGPaTo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="18077431"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="18077431"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 23:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="778439526"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="778439526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 23:11:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 23:11:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 23:11:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 23:11:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs3d3hIo3wQ0Qx9h2JehShnULG7vidCvmZGkcCwwpXgTbkTReo4GCN0rQG9BOwTNCSpswEcM7Ch06jvFs39cXhi+UQDiFGCHs7N9Uzfbqyuid72PnAblo/YGTwirYs7iLYbaIpgYhz5iUoNf9AWGwg8bcF7NNkEhlSouU2Kdosi3iBzZlLSl3E1gFEwybAmm8V4txXb5Zfxd6PLeAUWWbFNYbObgptDYbz4p4fhR+xj/12pfh+zjiUrdu7V+ZWWpjT9BvKhahi+qkKt7etB5znkr0zlK4uMdac/rMAA4lLxZLiBnhJaIuzuRk3qmR530PBNXpjHA3O1/XuKiccmWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igKevMPpcS2T22pDUjwb02Ui+YXaY0KPHA9WEged8U4=;
 b=HJEiLmz5ATzKRnb95nAwPCJakLabi7e0B0BRXGTAb6M/qMEJNCq9ye1dFw5H4BQzZc1oXT1cT2jUMifShWrN1gYRicHY7qoQs3WzaV6YP/czKGyqJ4JvKRnLJUxiu4rQsWQcPWqLJrpGKSVhf3vF2UCvuzz3Z4QSq6RVsDxSL3Y8AGUz7VDXpwUr3G0O8wrhUUEEsQlUS2fd3/z64MHc35Gm4YhO6Eum1WMYNBS8CfmRA5GHIzP1bvaDXZgmz4WtKDwLNkF3Lb7hQ6atf1xwfTGakd07XnkZYUoUqJ8NGAM51KSrYH/Oox92cEcNX4OBBvtYnG/2w4Iy5A656EAODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8202.namprd11.prod.outlook.com (2603:10b6:8:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 07:11:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 07:11:49 +0000
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v8 10/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v8 10/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaON+9l+zA44VLDUyKcHm82dBOTbC+R0mg
Date: Thu, 28 Dec 2023 07:11:48 +0000
Message-ID: <BN9PR11MB527696416E2B1F33900007968C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-11-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8202:EE_
x-ms-office365-filtering-correlation-id: d44abe7a-6c19-462b-6d19-08dc0774424c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJyvPI6u4OdyWp6x3AG96mlWHpwkbrQIz5I+KVUlXhctBNONniKJnN2PwWYVz0ZVsoKK29/bVhACSL+rudH0CLrs80bfxaKtMDnNlK7bqDkxn1yk04QZcQLKMIhQmzn7SB8xXMEqyw93FJkbFSX7c3Ij9/Qq+QPADdEdVvv9MA4CF3ugIZWe9Xba6980fzqC6NpeqACXOPm2fi7Y6aZYoCTokQKhVUw+kb+ruRRok9NZ1z2vP4tzBKSGyX9JRlnQMtZ4n0ZO8acOfKw8NOPBi29KdM7BNm6T7JB12JNqPHjephhyilseGhpwVk7mRtfqidmDk3AUkUYW5IAPc7oaFmvc2mC4uKiLJNFRNvNVdLhaqsBnjQ+QiFgs8wuFK1mpPH761SZsdRnhHmE8TZJ0UioB6u2OQbVYZWzvv9mrzISXNZST9dp+LOukrIJjwdt8kvtbm8pyLSVsok096jaJzBZym17rB1EKmIK9GdzM/1RT1cuI+LvNXaAGpycm88uz3kH9WH+3MzMIPZf0Rn9FXylhbiFn+kXb/eSR1rSOKFFfpVJfjHP7sD53xI9GT9dsiZoWDJBjrkWUvEZedUoKg2rN0oNvgruL+kUSvAssXduGyN437gALtcg93H1q2rS/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(7696005)(26005)(71200400001)(52536014)(4326008)(83380400001)(478600001)(9686003)(5660300002)(8676002)(7416002)(54906003)(76116006)(110136005)(316002)(41300700001)(8936002)(66476007)(66946007)(64756008)(66446008)(2906002)(66556008)(86362001)(33656002)(82960400001)(38100700002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zENgsyEkZfiQtdg3T003FPv/eFjewiEbpznKLemm6iq42Huha9yjQ1/jYv9F?=
 =?us-ascii?Q?XfXo9z0N3Ufbfku2mm9m30HJEeC07TXZfpffJXOZvf0yQAva930jZiM84y37?=
 =?us-ascii?Q?8M4qoGnPceOebrx64cgpr1sXCwlkeo4LGab64JhFuFAqqzIUgVLCNSM55rlG?=
 =?us-ascii?Q?HrSlUk48VlLpLLyKqJv0H/VS5IdkA9s3LGKEKpcpLnaIRAsnz5WTx75+VXVY?=
 =?us-ascii?Q?s17U07uvY4pzOBB9TPOlSSHZydg85RNyZLqyQpIYYaWBuw7aXpm0aCcbkx3u?=
 =?us-ascii?Q?uXNFlc8twslQSaihRojxIyLys+K4kRT4E4QILjtFz93Wm+6yD4OyFKvU8bHb?=
 =?us-ascii?Q?sWLNvXsmLxBRfOKVcVrayOx6ueeNIX7+a+yEoP0E8bM/ruKHJ4hVOhsG/BB1?=
 =?us-ascii?Q?NYVdWEg7JZ5cVnIjgNaBGlY9Gnb3E/ApRwmRMOk6tgDKPQ3i2Q5bEyGVUnCc?=
 =?us-ascii?Q?b1kZWog9Bxi+6VOj/Zk4gEbqWJWTkS2bV3yJhfrKbqXi8r1/QerDtULLbtxJ?=
 =?us-ascii?Q?nij4h1LsKck5Noa8hhqlsvLomiDnF+UBTzA8ljYdisaNaVaHvmY5BgsSx5qZ?=
 =?us-ascii?Q?VZqwHdqPSVn48E4Dd8iovsPaJ5kDgLkBiHT1PJSLcVsfda8T37/IWqLdL81g?=
 =?us-ascii?Q?DRLdFE+NmTPYvHENWrS9I6tz67iK0dVxKwzDeEyTd1qGlG4l8kKNRrB8FVm5?=
 =?us-ascii?Q?FbtCSpTkQyDG5j6A/iDymoJEeOX22p4nLDN2WyaFWdOQFnX7n7yGZ71NV0Lz?=
 =?us-ascii?Q?6bD2Buy0S+JOLi53duCoRG3cEDRhKcwOMbrlAkxOtOns6Vn+yk320PX9BZs6?=
 =?us-ascii?Q?H+LZiLXfNZaLiKbjpexDeSml7uK6+7luw4w0VxBjtryAUJQJ8030PCM/NNjH?=
 =?us-ascii?Q?UugltlMpBBbWErNaj4og5MFagvmmEccxxMJwXJDWXNyOtucryqm6jCPcc0ac?=
 =?us-ascii?Q?3YO4L5jIHnwDUl4Es0pI7saKDuFJ83iboI/6AlUB7TlMLHnFIWS5UlZsxny7?=
 =?us-ascii?Q?e9lDkzvJsSYwLZ5F7ndFYU8mVFhdKtNbw/dXayvnQy1FTiSJ0xAYKk+Nmzzc?=
 =?us-ascii?Q?coZAV6aLezggljtzFkJOkWsSn5C38aTWX1FH025DLPNx9nVSdXoqmmeOxhBW?=
 =?us-ascii?Q?1VH/aZUJzFocy+LedtwQ+J7W5aqXdFRS+ydp7IZULW331Y2yCEKBpdVgII7H?=
 =?us-ascii?Q?7cFvPVoe7Yged7lZaehxnZPmPHlod6sVPZ+jbjzEyiyTHep+CNzBq5cJfP1y?=
 =?us-ascii?Q?MWRFzl0UeufIv2vw/0KfpmYnH9SXYOZ9FvjTdAKh9Ek1f6DpSstpG6y/t653?=
 =?us-ascii?Q?boiTF6iPa0ElBlijLacOBvYSdC3GV+2gQGH2CfqOdWkf+3ZS3LpdQ1iNq15w?=
 =?us-ascii?Q?L2s9dA+8P4o1156+2smbQk6GiU5mGGu8RIZjDk+k/HEbpAcwhS1M8cA0Wwp6?=
 =?us-ascii?Q?jR7hpp04Q+4yQCs9gyhUR6jh5U9VajDa8rkDizHkLEZzjoKwoSqIMRkfwxke?=
 =?us-ascii?Q?BVvPY3CwZRVaoqxzpxf6hl//PFbHkWA/7ETp4h1ZGBy2cWb90G/7G6C5wtB1?=
 =?us-ascii?Q?AJzeVUS3ssRS30f52HQKykk13LbGn3kLit5latSG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d44abe7a-6c19-462b-6d19-08dc0774424c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:11:48.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkyInhm93D39BdIpHnDX4Weehi9hkM08Blu01EweNQSTHHQMG3P8DzdWnis5ALv2qEuWAS5dHM7QWACU2O4qBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8202
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
>=20
>=20
> +static void nested_flush_pasid_iotlb(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, bool ih)
> +{
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	if (!list_empty(&domain->devices))
> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
> +				npages, ih, NULL);

Not sure the check of domain->devices makes sense here. The outer
loop is xa_for_each(&domain->iommu_array, i, info) which, if found,
then implies certain devices behind this iommu must be attached to
this domain.

I wonder whether it's clearer to remove this function and just call
qi_flush_piotlb() from intel_nested_flush_cache().

> +
> +	/*
> +	 * Invalidation queue error (i.e. IQE) will not be reported to user
> +	 * as it's caused only by driver internal bug.
> +	 */

here lack of:

	*error =3D 0;

> +	if (fault & DMA_FSTS_ICE)
> +		*error |=3D IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
> +	if (fault & DMA_FSTS_ITE)
> +		*error |=3D IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
> +}
> +

