Return-Path: <linux-kselftest+bounces-2341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9281C35D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DF9287CF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2715AA;
	Fri, 22 Dec 2023 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLUhc8hI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843E23AD;
	Fri, 22 Dec 2023 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703215165; x=1734751165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ut2Vr7DaUrijUSKw3ezGoU7U8p5oPAxC4kSB6odEK0s=;
  b=aLUhc8hIFykD4yu6/WOAxTF7h8w902R4LQNLTDchFQZDaVOhNc+7SeUW
   eF5m6wQWnXNwYeQEs5YiGnRJb9h/IxK66CL+1wlC+YXR5uwgA22rgd21I
   5f1mwWY3Jv4Mkyo8DRbHLmrsobOQUUDTU0K8fqK1X0b7SJRUvVL+U2GXc
   gjd39L1ogq94g30fB9MjKRDcW5+02veP8ju/16AdXasy5ybtI7NbbdiQC
   C0v1ImBUZXsOCPS3gkgOWCN43szbpvY03WPrX2yNboTc4Q0eJRH/7ezeD
   pyUXOP3zgrxuLh87BS0MViX2gJeNYiL+g/x6AW+DwPSO9DOZf+l17frZ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3307204"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3307204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805820320"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="805820320"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 19:19:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 19:19:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 19:19:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 19:19:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 19:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi4v1C7bTOvpcuVAEk6Xg7Sz4zG70XoeweuDRhuJm7lVOFFCO1fAtpnut4lSZvlPG2VgeafTYO39H9J7plZnkO4N3D8Mr4DoxicaDVRJ6iM88eSj22U4Dj84niqqTtuozVyD7F6XrQnAsXymmDSYRSDtLCgfpNA1FF7WUctU88xVS2akXbnQ5oITFFE0aaiqF+tqamfo1qMU670/RGCJ8BPJ+hBvB4Kdaex5EMtUC90EGjQL9q9ZQuJ18bHN0dyjnq4ski7J2RgYRYSVYR9RYyBbvldd9D3l0XEnBF4Ud2HduiC1/2hth4NFfXcdjwQBsFT6fxXoD2bYHl2D5bqAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGtE7T2Bkz2J73ksbrlyAJELP+2JZQlzp+B1Y9AGfzk=;
 b=SpICwcb90o8tK1/z2LWyuCSf5XToTVWaghY8QXHBTOIL3WIbaoQ/U53H6KEvM/3yfonTuOg2QreyUMpeShaODk4yVEllgKXBODrQ32mfYE6Y3gkgmI93YGA2Fx0fxjM2ae4UjyUzhBK+EA8KLc+o60DEO54WB82gtWgF7Ii11VDVROmRdLH7x7oN0Vvj9JzwgXjF5NYC+pRakWwG4ImYCWHhKEdOCl1qZuTJ1+X8Yphodb3V5dLduq2Tybj7S6k0T0oVZRCzbONrSTeOQ55jcAfzqXHPSIFwGqBw5IJ61Wgm+9Da8z4MVxGEdZE5xnzf6chsXi8Qf2r/qIfPKpx2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5576.namprd11.prod.outlook.com (2603:10b6:8:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:19:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:19:19 +0000
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
Subject: RE: [PATCH v7 2/9] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v7 2/9] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaNCP1EpUK3RyZoUKHm/byH0S9CrC0nDRg
Date: Fri, 22 Dec 2023 03:19:19 +0000
Message-ID: <BN9PR11MB5276A3AFF358A0E822AD22B08C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-3-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM8PR11MB5576:EE_
x-ms-office365-filtering-correlation-id: ca807725-4586-436a-c211-08dc029cc948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZ7OiSmkQ2RGI/Dm+8O1w+BWvGpBmVYD/TuKDG0cKcDuCoy8Oee831IP3vsXTZTjLZ0jbwFShSUEdNOnqUxj4XbAjrkyUl1fA4oXr7Y/mFXv1HnvkqV54wfu/Xhwv7w/JnwIecdXFu6g6e3b3KfmDVdmMo4htT8p255DgauYIBCR4Jh25GOzK6gLVmQr0RZV4MQNCobD+hdcbYYIyWcB3epK4+pt/aiBLkSNqm/wgi1WGJMdnptJewYGRsTGJcbtXF+r0DBoVisbGkfRh1GVqzCUWmkgQKMHCZfsWJJ0bksEwFKoHVnIyFzs8u2KeJF6jxaaktdC4AM/YAHc4QODrDZpMDWx3artf5ET4KoLxl821Mx+xcl79YRmYLiTytX5C/ka9siBEoNvVmpuKBoQugLKvXGcxmH0obOgKpKNDk7B0/g1rQuqzAVcEsO2n563KlMd40bUfs5a3/INu3WEN9O4VSp4wIog9SVhVSGeG1+MYAE2ygmIEJGGnhc3sjipz6Bh7mZkNzTPnvo9b9aeTeZaan4AljZHdEPGrf8UtSFdwEqAk4cP6+HvhlJIayGKQZ9meEixNWpPLDDx/cAEy1B+HOMVJVB8hvFwUnjkg70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(52536014)(5660300002)(2906002)(7416002)(45080400002)(478600001)(6506007)(7696005)(9686003)(66946007)(76116006)(66556008)(54906003)(64756008)(66446008)(66476007)(110136005)(316002)(966005)(122000001)(41300700001)(38070700009)(83380400001)(38100700002)(82960400001)(26005)(71200400001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PlSS/gkllTLkqX52jSPCDMz/vTCBSFAfy/kiI4AzEOVplM29PGiFPdUL2lWd?=
 =?us-ascii?Q?HHNzku71sET761ZR+ArcbaxHlyUxK8zANfw3yM7DDAZl2Z53d5Zojh77UrnO?=
 =?us-ascii?Q?Z/l+a32nCjJ7XC3qxiX0sqj9CpuupXIMg8EYgtAklBhAhYeb1o4yHa46NYIP?=
 =?us-ascii?Q?VfJCCJ4qC8NMVTr5vYUhYmaZBRtf8JCbvNslY0Ycj5gLhPF5UUT83dTWayL4?=
 =?us-ascii?Q?vROJ2VIoRC7+BWCKrTRBT20rIowzM7c9j2L/ielHtW2luG9e37QpHgOyQfxh?=
 =?us-ascii?Q?nAynZy3J59UZzlnE9i1oA/LUBIN2Ik+wAYNlHms2z0dCA6LsSmNCVpUHCQBe?=
 =?us-ascii?Q?wp7E72dG7TpAeQBKaFHeH34fM4+H0A0lR9EzEat95UqEUhiJ8yhS6TMuxODZ?=
 =?us-ascii?Q?M/d0/ZQxFfu282AktJX3DrZek/3FFqg06O1fGA1DIyJ6F2wNG+MsYcmjkFsx?=
 =?us-ascii?Q?G11LgdUFHxSRHseOZg7Wttzh2f0qsLvnGC5C8T/2U6YA+jr/NwF85A21XquS?=
 =?us-ascii?Q?IZ/CVwOLMebBuw2omSAFvOh3uoBivosxAWLOnubOdMJn9Kuqef7urdNeQQ3l?=
 =?us-ascii?Q?MtG+6yUUHhgumoZ+9mV3tmj5dS9q8uFa1pOe4LBO0S2gv03rKYMZ33rjXGZr?=
 =?us-ascii?Q?OoXZ1wZG63mMsuVRMU8qDJMjrYwIw8gG4rAlbEYKQ+QqHJVx/KnYAKSw+hsr?=
 =?us-ascii?Q?LctEXn8fkR/8LsyUO5HFbrVHfuNNyDlwL67OBHQdDZwdqN+dT9UpWMLZH1R9?=
 =?us-ascii?Q?K1RssJ1RjfNZzF63pronp42SwFDNpQDO69iTW8NC6/H6Ll0EGtPOdrvj9ABG?=
 =?us-ascii?Q?a6iuB2YHm8bUpi1c3qUnEZQb8ktLpZqqqeU2edbvwnS/2Y3Nx0iTGzG7TF7x?=
 =?us-ascii?Q?OHVN4zKc21noWPPmVUgT4r/95sBisnCUAaaBWCgVk7wrVD/yeJStfMxMC5cL?=
 =?us-ascii?Q?A1DhmPDPcqjpsJlnOs24UBItTwGkd8GxPT8YnPl6ho+8eBinrG8SbSA0vBbf?=
 =?us-ascii?Q?jOIvIDrBGCJnqUrdQ4SaLm2YOCcv5gs8iOamNK04jN/GtFEBCFJEPYch7zaU?=
 =?us-ascii?Q?+bqg/9mO3Qm00VdQCDfv17KBUcB82F0z0dG2+KYDATXlWAQ3HzMmpU+hGZrm?=
 =?us-ascii?Q?OBqavhS9Ai8Uv2uDwgjO2RVo+bfir9qvbnB8sG5XG3IWBp8vEpFs6vGq97M9?=
 =?us-ascii?Q?JQbkN9DbzPRax5Odre5kLphhF3GsLt4Q6E9Z/PFzUwp6bSkdWHy9JqdjAPKJ?=
 =?us-ascii?Q?PR8cVgzcJPF5ieetQez1viEhDRamZwk25V7xG8GguQKjHeqMq4m51lgdWeL9?=
 =?us-ascii?Q?5DcU2fxs1RjcVE13IxdqNFDEDPfcPbuCCHNHBjDC02hlpAmtSIRMyITTFq4o?=
 =?us-ascii?Q?Nxcu+UbcH4Yfti1ExYiCPEvUVWBTRXqdC7FvlkBrhUTHB29lrhrNQehvmAgy?=
 =?us-ascii?Q?jG1bY0UvaFTqfxspVin9H7oGCVktpLD/KCvxPSc1cdvbkqYhLSR9Tv978/qS?=
 =?us-ascii?Q?K7UNjP0TPeZFQ1JE44JyvkqmylR/Zwcfe05af6X8fyBD65clUCYDuQ9mZdJi?=
 =?us-ascii?Q?tRLTbOnBruG/RLdUSL3TxZXC4Zt+NSiv7J55k7Ui?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca807725-4586-436a-c211-08dc029cc948
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 03:19:19.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GG+1mhqdFYQwrUgdX/CqTCFZ/K9CLtW65GneEKsM9yEiEhTYmklU3cPqUT75ypamf6fmSTc0377KY9bmoZZF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5576
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
> +
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_invalidate *cmd =3D ucmd->cmd;
> +	struct iommu_user_data_array data_array =3D {
> +		.type =3D cmd->req_type,
> +		.uptr =3D u64_to_user_ptr(cmd->reqs_uptr),
> +		.entry_len =3D cmd->req_len,
> +		.entry_num =3D cmd->req_num,
> +	};
> +	struct iommufd_hw_pagetable *hwpt;
> +	u32 done_num =3D 0;
> +	int rc;
> +
> +	if (cmd->req_num && (!cmd->reqs_uptr || !cmd->req_len)) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}

miss a check on the __reserved field.

> @@ -323,6 +323,7 @@ union ucmd_buffer {
>  	struct iommu_hwpt_alloc hwpt;
>  	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>  	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
> +	struct iommu_hwpt_invalidate cache;

this should be in alphabetic order. I gave this comment in v6 too:

https://lore.kernel.org/linux-iommu/BN9PR11MB5276D8406BF08B853329288C8CB4A@=
BN9PR11MB5276.namprd11.prod.outlook.com/

> +/**
> + * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache
> Invalidation
> + *                                        Data Type
> + * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for
> VTD_S1
> + */
> +enum iommu_hwpt_invalidate_data_type {
> +	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +};

Defining DATA_VTD_S1 at this point is fine, if there is no usage on
DATA_NONE. But following vtd specific definitions should be moved
to the later vtd specific patches. they are not used by the common
code anyway.

> +
> +/**
> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
> + *                                           stage-1 cache invalidation
> + * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only
> the
> + *                            leaf PTE caching needs to be invalidated
> + *                            and other paging structure caches can be
> + *                            preserved.

"indicates whether the invalidation applies to all-levels page structure
cache or just the leaf PTE cache"

> + */
> +enum iommu_hwpt_vtd_s1_invalidate_flags {
> +	IOMMU_VTD_INV_FLAGS_LEAF =3D 1 << 0,
> +};
> +
> +/**
> + * enum iommu_hwpt_vtd_s1_invalidate_error - Result of invalidation

"hardware error of invalidation"

> + * @IOMMU_HWPT_INVALIDATE_VTD_S1_ICE: Invalidation Completion
> Error, details
> + *                                     refer to 11.4.7.1 Fault Status Re=
gister
> + *                                     of VT-d specification.
> + * @IOMMU_HWPT_INVALIDATE_VTD_S1_ITE: Invalidation Time-out Error,
> details
> + *                                     refer to 11.4.7.1 Fault Status Re=
gister
> + *                                     of VT-d specification.
> + */
> +enum iommu_hwpt_vtd_s1_invalidate_error {
> +	IOMMU_HWPT_INVALIDATE_VTD_S1_ICE =3D 1 << 0,
> +	IOMMU_HWPT_INVALIDATE_VTD_S1_ITE =3D 1 << 1,
> +};
> +
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD=
_S1)
> + * @addr: The start address of the addresses to be invalidated. It needs
> + *        to be 4KB aligned.

'of the range'

> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> + * @inv_error: One of enum iommu_hwpt_vtd_s1_invalidate_error

'@hw_error'

> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 ca=
che
> + * invalidation in nested translation. Userspace uses this structure to
> + * tell the impacted cache scope after modifying the stage-1 page table.
> + *
> + * Invalidating all the caches related to the page table by setting @add=
r
> + * to be 0 and @npages to be U64_MAX.

here should clarify that the invalidation applies to device TLB automatical=
ly
for VT-d.

> + *
> + * @inv_error is meaningful only if the request is handled by kernel. Th=
is
> + * can be known by checking struct iommu_hwpt_invalidate::req_num
> output.
> + * @inv_error only covers the errors detected by hardware after submitti=
ng
> the
> + * invalidation. The software detected errors would go through the norma=
l
> + * ioctl errno.
> + */
> +struct iommu_hwpt_vtd_s1_invalidate {
> +	__aligned_u64 addr;
> +	__aligned_u64 npages;
> +	__u32 flags;
> +	__u32 inv_error;
> +};
> +
> +/**
> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> + * @size: sizeof(struct iommu_hwpt_invalidate)
> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
> + * @reqs_uptr: User pointer to an array having @req_num of cache
> invalidation
> + *             requests. The request entries in the array are of fixed w=
idth
> + *             @req_len, and contain a user data structure for invalidat=
ion
> + *             request specific to the given hardware page table.

Just:

'User pointer to an array of driver-specific cache invalidation requests'

> + * @req_type: One of enum iommu_hwpt_invalidate_data_type, defining
> the data
> + *            type of all the entries in the invalidation request array.=
 It
> + *            should be a type supported by the hwpt pointed by @hwpt_id=
.
> + * @req_len: Length (in bytes) of a request entry in the request array
> + * @req_num: Input the number of cache invalidation requests in the arra=
y.
> + *           Output the number of requests successfully handled by kerne=
l.
> + * @__reserved: Must be 0.
> + *
> + * Invalidate the iommu cache for user-managed page table. Modifications
> on a
> + * user-managed page table should be followed by this operation to sync
> cache.
> + * Each ioctl can support one or more cache invalidation requests in the
> array
> + * that has a total size of @req_len * @req_num.
> + *
> + * An empty invalidation request array by setting @req_num=3D=3D0 is all=
owed,
> and
> + * @req_len and @reqs_uptr would be ignored in this case. This can be
> used to
> + * check if the given @req_type is supported or not by kernel.
> + */
> +struct iommu_hwpt_invalidate {
> +	__u32 size;
> +	__u32 hwpt_id;
> +	__aligned_u64 reqs_uptr;
> +	__u32 req_type;
> +	__u32 req_len;
> +	__u32 req_num;
> +	__u32 __reserved;
> +};
> +#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_HWPT_INVALIDATE)
>  #endif
> --
> 2.34.1


