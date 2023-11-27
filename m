Return-Path: <linux-kselftest+bounces-637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CD7F9A38
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AD3280C0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEEAD291;
	Mon, 27 Nov 2023 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJfXOmaJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20962133;
	Sun, 26 Nov 2023 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701067844; x=1732603844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMayF5VmU4Ve89pE4SGyqoIeQPRuVuLvr90TFDjvuyI=;
  b=dJfXOmaJGX2L3MXchrS0EdusCX0wgy4xivIGxV3gYBn82Qyj4kOlKZD/
   +5uy8F7HjmRyqAZ26lzaGi1nthD3M3D/wuVc+6ADt5moD3rHCSe45yR4L
   spKWG1wc0TiPzhVZOuFukhN3QNFHR+KyUWw5x3UYwIYKGRL+kElyEQs3V
   P3i6+sG09UO3goD/j4JLpa687Nh9JzHBrIi9Wc+Of7avT6nNsQVvVW5bI
   o9PYpNuKyKDb48E11QH3+LpjHZ2dfCcAAv9ralQbnHeCs4NB2I42h0w1E
   864i5vmY8X5NzaBVZd3AuCl4S6/sdWLsrjNpwfX4uqQ20qe5AN7TXUm6C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="372803356"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="372803356"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838610782"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838610782"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 22:50:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 22:50:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 22:50:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 22:50:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 22:50:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDcj+dgdsxOEckUHGz6/sANvHPBk85M5gJ/5mdJx0Yq663dChPNHmFLpjkrV34DQq8NrDPe4Ce1MhiDjGFjNHlsleaiq56kwTpBAFzy1RqTDJQ7ydobfBgoKZt6ZhvWTAOIFEVwdzQEvY3SseygraML40eF+pVqlwyXA6f4bLWDi+fSeMjY5xTQFxLNVvWqnOgC5I7h3v0054EC+Xiw9raJo2kXlcLFeNOkqArmW7ojY3mMXKDXfU1hLmMdI17f5QuWjFxMO+WUGcSh9qN88SCg+eWL583JL36OhZrt+Fl73ayTFvjTIsDkgDuZajIULFR2ZmZuvBJKoULJXfhFVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEU59tT/I7NAR/s1nUCv7/4jOUrvUnEUOped9eLRBvQ=;
 b=KwJ0KksXLf6CIdJJD02dI1NZK4A880P+K9oRQausluoLczLgw/6D3LU6lQy9YE0JtFbvboV8oEAAn4VLnCvN3JDg/bc+yslR3tI+wekkihUbJyM6AKCYEjeGLF6tIyDHQwziFeQOWQBsT71/We/dSRzr+nvnWBhC8scdXKIG6CIQWER8BCh9zQUka56VV9+dzBEyxIBft332Rv4flkQctp+TJldc/oEnOD1Z81T2kRpIAe6lidsSN3ZDrKg6VbE1c8Rpt269/q55WKOFWs0M4UNqHA5auy/TSKlZxeMx3eluP8jOZgb+uABt1GrHAz6eYqf48L4LajB18qHaYyY75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 06:50:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 06:50:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [PATCH 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Thread-Topic: [PATCH 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Thread-Index: AQHaIPx2CEiCWPjIVEGBOBlj8kNZAbCNuTFg
Date: Mon, 27 Nov 2023 06:50:36 +0000
Message-ID: <SJ0PR11MB6744B5CAC867EE643958078D92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-3-yi.l.liu@intel.com>
In-Reply-To: <20231127063909.129153-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7893:EE_
x-ms-office365-filtering-correlation-id: d93bc964-6260-475c-cca9-08dbef152916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8NQxwQ7/Wr5UD0hpDvcTrxh85Hg6njfwcWpdtHWe60ByOKt9HZD9LoxptDtlJc5zdtDZUrG3UeGbFwKKLmqa9eFjpw0CNUSZR/9P3YDPhktH1v5vmT7ebXbl/6rrrfJtuAvQQKhZd3/hfrZzWJtROHwaeEW+IBr5j93+88Mk4H5NYuFDm2zTq75mCysBU3eHUlBmi2dST1TJas3Y+RW4DClFQILYUzS2bKQFFfJnwRRMBWwt2gzKpSDBtT+AJHqB8yuoNv96WX7yN2zEHQvVQiWKn5t/ujS5akCMLF3T1KLn377SksdmTSHVs3Dl48NtRFmCLVP8Xla67EYIdB+A2rDzlTyU7HaSyKa5BJ6rfvhze1+il5McqcLXOjDbzoTa72CG4wkrCDmOnewgM2uSqBLJ1YAMlUFTzjxUv1HhtbT5D3r0IJthgCI2wAaccgcPZJ/FG2fQECs5+6wySdbCJJWSzI9Y+/zOOgYRLhNxcW86Qw4X9lWzjg7M3qYy1eHUa1YE7VyUwdLTY960D2kgGz2s/XCr3HaHDmahT7uQBBhrG4wfAGKy+WSk492uoGmi1zxtyX2QxqlFSbTBom9VfhEwX0133ksT0GiBn1G+H9Lhj3DBICSwF3kg4arsnA9G6KN6NddOGJ7rMSQBrsv9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(4326008)(8676002)(8936002)(52536014)(7696005)(9686003)(6506007)(66476007)(66556008)(66946007)(66446008)(110136005)(76116006)(54906003)(316002)(478600001)(2906002)(122000001)(55016003)(33656002)(38100700002)(41300700001)(38070700009)(86362001)(26005)(82960400001)(7416002)(83380400001)(5660300002)(64756008)(83133001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EHRn1zR6+2/6HkOm64cGEHHjoGNc52eYglHAJRlu7GqGsQHG6yOn3dXMwqvm?=
 =?us-ascii?Q?7GFeK71DO/EdLSVSE4jdK2NJAPW9c4EZKHS4hov0iO22h20ajBI2MlR40yGg?=
 =?us-ascii?Q?lJ8OwzuWSN5rENwbZXASjV5BO2k9E9ny5sm/CuaUIf1OgcNmxW0y+GtdUv/x?=
 =?us-ascii?Q?SvhDRQwvwq6HNyFtu4WZfeM6me3ZQr6+mfKXzX1CHgSBX0SMN9x6ba5+Xpjc?=
 =?us-ascii?Q?WA0OXavB/Dt7Tqf0vutkuwefojAnv0mf3B7Br1Npqytl6WcX+MZE+trW55g3?=
 =?us-ascii?Q?Q89Fym/ElN3ZAj6YtoR/SC1nPWhcVPyXgme5Eevq0KeyO/SKlS3cXUPnVeIl?=
 =?us-ascii?Q?4rfuiLUkgnp9kVQveJ9EiYZbCqkOv4SjL5uKILqzBh/g6Djo9LFuJmfov/ie?=
 =?us-ascii?Q?Esm9q+36p4Zo43l3ZAh+HLUpYBC56JH2j4z+GXxtFcBYvNN1nMIvuJLN3XK8?=
 =?us-ascii?Q?+JTAjXcb+l/NWYJn4hEP2QwLTjNIDniVwoDU6gZ5JZ25jAgHS+jM1t+ti5Cr?=
 =?us-ascii?Q?7t/SoxkUAtcHORilyZxvxDVvCJ5dbo9IJZeIUjUkgYKStPmGq4SdEKUAsCOF?=
 =?us-ascii?Q?eLoA4wXSsL9eX0Sz9OdBY2UJ5B81Th5/5EcrEJLyg9ElrexsTPfSPtIZUtwT?=
 =?us-ascii?Q?MyqR3o84hJh1H/GfpOJQYRYNX38yG7H0vWhLexPgr5KGVD13rVoejUhC0zZf?=
 =?us-ascii?Q?+cfj9Ct5UPv4877J2svvvZjgTSL+6Qx258j8Gz4bluwWzmxnkjjssdAarAga?=
 =?us-ascii?Q?z/JUPo7/tIWlraTKYnMGqMd1qLd+nSBjDGa64tdfJpjwlvFetXVtdTRKYCZ3?=
 =?us-ascii?Q?axUKpE1HUKg44acJmwssjkjJDBUFI+ZYz0Iizft0j0c8qtZOIrVgjFvi6Par?=
 =?us-ascii?Q?2w9DjKx4l+TElwOkIeaC2oX5frlEsV4SFPID10+7a0ez1zcGo1afbESdXlt/?=
 =?us-ascii?Q?rTJW89dU7zB9sM148g+rMnZee10sdwGUUxww5rHkChyuPni+R7C/2klU7230?=
 =?us-ascii?Q?nH+jBihf4+J6Hh3n+0Gl67MAzkMkERz9QBRXYB/IF2sxcZj5S9SrwW/Qwclk?=
 =?us-ascii?Q?jf9jNAQnuVecp3sDJwCADEz18sl2T29Luf/KZmTa/S/3hKId3q4Qt2vG28aN?=
 =?us-ascii?Q?/TaAyFloj+y27qQJ0//wMWF51hqzPAC/aDR/7jsDa7yxWzYAP5a5ytsBPJvJ?=
 =?us-ascii?Q?3SgSfpkw4obC7ZQuMz2W2zCQnXl92cexzyJqY+04lljjnrWv1AJ2ey8yYHQz?=
 =?us-ascii?Q?IdWbpRPoHsMGhniOVQf6S9IlXu25rcrvAM+B5Eih7For0dcqhM0WJ5FS1Xw1?=
 =?us-ascii?Q?b3biwndHATUy9GE683/4BpGYkz4H7jMm39xG+6M9Rb1HieoZL/LJ3+7MklyJ?=
 =?us-ascii?Q?qfSV3rIPawnvT19difbhZ9tnK4p0MiDCDA127vFq98ar/ox6MVom7u/vLjTD?=
 =?us-ascii?Q?/jbEE2Gft28UKi9WgZTzlLMmbaaQhkLQRWFrXPwhMPN3ZruuoAlzJ9eie0H7?=
 =?us-ascii?Q?p6MPwObMqeT17oXEbRICyz/5pyBrque0hb6U4T8Dy8zeSvgd8wUOUgHFPzCG?=
 =?us-ascii?Q?RWh/Pq+IIwANkaaWQp+9g8wjs5cbeoGAtK8ntjM8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93bc964-6260-475c-cca9-08dbef152916
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 06:50:36.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+BiwjYM9IO/bz8a/0hASQc932jrcbD8aGaC62JqMIdbv8VADEPAHH4SUJXKIPCnKh3slM5w19+ddd+OgiCZ3m1DRC3wSmfrzp5hd71ca1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Sent: Monday, November 27, 2023 2:39 PM
>Subject: [PATCH 2/3] vfio: Add
>VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
>
>This adds ioctls for the userspace to attach a given pasid of a vfio
>device to/from an IOAS/HWPT.
>
>Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>---
> drivers/vfio/device_cdev.c | 45 +++++++++++++++++++++++++++++++
> drivers/vfio/vfio.h        |  4 +++
> drivers/vfio/vfio_main.c   |  8 ++++++
> include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
> 4 files changed, 112 insertions(+)
>
>diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>index e75da0a70d1f..c2ac7ed44537 100644
>--- a/drivers/vfio/device_cdev.c
>+++ b/drivers/vfio/device_cdev.c
>@@ -210,6 +210,51 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *=
df,
> 	return 0;
> }
>
>+int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
>+				  struct vfio_device_pasid_attach_iommufd_pt
>__user *arg)
>+{
>+	struct vfio_device *device =3D df->device;
>+	struct vfio_device_pasid_attach_iommufd_pt attach;
>+	unsigned long minsz;
>+	int ret;
>+
>+	minsz =3D offsetofend(struct vfio_device_pasid_attach_iommufd_pt, pt_id)=
;
>+
>+	if (copy_from_user(&attach, arg, minsz))
>+		return -EFAULT;
>+
>+	if (attach.argsz < minsz || attach.flags)
>+		return -EINVAL;
>+
>+	mutex_lock(&device->dev_set->lock);
>+	ret =3D device->ops->pasid_attach_ioas(device, attach.pasid,
>&attach.pt_id);
>+	mutex_unlock(&device->dev_set->lock);
>+
>+	return ret;
>+}
>+
>+int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
>+				  struct vfio_device_pasid_detach_iommufd_pt
>__user *arg)
>+{
>+	struct vfio_device *device =3D df->device;
>+	struct vfio_device_pasid_detach_iommufd_pt detach;
>+	unsigned long minsz;
>+
>+	minsz =3D offsetofend(struct vfio_device_pasid_detach_iommufd_pt, flags)=
;

Pasid isn't copied, should use pasid here?

Thanks
Zhenzhong

