Return-Path: <linux-kselftest+bounces-3131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B706382FF81
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 05:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21946B23ACD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37346BB;
	Wed, 17 Jan 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKEu6aQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE198522E;
	Wed, 17 Jan 2024 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465073; cv=fail; b=UuLXybEHxUqSJQkFDvptPUtNBP06Am8KHw8J3A+ZjwBhVZe1FDZV0+LHtAl5/Gzl2mAPWE+Lt5e3UUj6120GhHh9jelJBSy5vcGCArQfyuMmXYDV00dt1DbTbcC4GS2yfeI6Px+g7IDALnJ9DwA7foFy9rkfSp43LWh8p6PFZGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465073; c=relaxed/simple;
	bh=L3lbRzmkPcfZ3i98IvgvqVIb+X90H7x8p764jJlq6GY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=MUJGxL2dLwQxvlpCmp5BELqvEBvpbm9dec81NX1eQ+PIVW57JiOoZ6rtcX86PIyCRUkXMyM2KeT+J3mp9qJmHvHuK3p0XoeLlpqy+CIU9Awsoy44HH8KGt/G1tqrsYPLNW0P9lClBTE+sdGt4ES8gFLWHkjQvDfUGmWSCn6R3eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKEu6aQY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705465072; x=1737001072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L3lbRzmkPcfZ3i98IvgvqVIb+X90H7x8p764jJlq6GY=;
  b=cKEu6aQYHaYaAIX/C72BjNY6okp2iiwjWiMx4gvWPPnUjwSw1Hhhic6L
   Lu06yUArklGgmTBgRiwzk2a6F0M9OFmc0Shk12+yn3kN0Ps6b+BED0ibn
   hzp3EbkXJVddVCa+ou0E4SUeJRietfZPtsZi7KPUOndHmpTS6vZTZpvXy
   ePhMnpbOgdo5UrdIpsQQlxu2aOCm6J++lkoz4s+xCXziMSxTCHi+n8oRE
   UG/UBwACSgh8hehBx6HrI7ysTv3Wxychni0UlSeWGAiPUNwZI0AxY5nSF
   UNw47pGqS6NzldgFt2i+JPOD6k1Pc/pzJnfS94GsNDsVdPz62eJrKLYJE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7457529"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7457529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 20:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818389281"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="818389281"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 20:17:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 20:17:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 20:17:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 20:17:48 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 20:17:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0qvklsr+ukE3IEpw6uuE1UyW51Mpl5akx2UsU2iXVycb7cfTW51UdlvHTeDNi+jmbGJZ218a73JBYAYIZyoQixiIF+YNgVwSsTLd8uW2U4oBHGOOr1vzIhpVdD4WHfiYN5F3IEtmvGuTWHgf0ZP6k/5thpbBXWFAJcnJ0ooDJlhrzg7zBsYkzPnLcUolSY9tQkUUUU16JfdKrLalSe9ToOKwWcXzzcBvOTdFYBevzOyZrGn9fhL3GmAJH2ojBNJ8g3x4VsqPgq6phYfJsOQ9gkpkLnR9iyp0LDZmPgeiRAw8r6v9LLuNZDBosBGy3K0bSxdsXvnHWSO4izk5Nmqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCdniO41beVP7HlBvpazYE/4LKjcAActbhSunzrBUqw=;
 b=O0qlBRsAtF4fTU3X8elFpF4ffq4u8jZGhrzkAyt6kqV4Lcta+iZo3RO0Au0LP3ZxRyB9Fx5FTMnu5Q9cP3Un8b/zOE4fo7c58KjWsx5YCRYABY4RI9Wn32bhiaaMPuy2vJ/vTaZoT0rmuAonjvyD3v+g/2rh1kHu4TgtShFQv2XkTlLMDt5/8Fo/Dz+9pIxUwOQMo15tScnS/zhGUVJGzDimWTFcskLIOnk4drLNgNTWTyoK8gARfFr5/YKkYHZs1N8bYS1YdUQ+JYL7uMocQ6ujVmGjIyDAlHNk7piHYrIzNyZQUUtLD+7g0FqZXAV2UFcOMJTU0Z8sKVQnSuuAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 04:17:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 04:17:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Topic: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Index: AQHaIPvOp5q2xzg/c0eyE+dkyLAmKbDbbW0AgACBx3CAAMYTAIAA//LA
Date: Wed, 17 Jan 2024 04:17:39 +0000
Message-ID: <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
In-Reply-To: <20240116125756.GB734935@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: 3e9e8353-9665-4943-aa9a-08dc17133e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdlTLquN/vQpJm+Xz7zaG0GjX1Mpqx2FBp4HwYIDqJV7WEoLx+eFjgXh+Z4ND67mrIb2RbX0Sw9i9Slkc/ys+plbZg2r0N5RuA+yO2ZirxXyxxHNKHqpDsBzpfMlGumptslJoPTWONEOR5P+xPsFAP9YmEOluNOIqLlyML7F98SDolORUi/YVgf52OpzhxqSsQtIOgPoq5br7ozQFEkUHGFld6ylh/Ef9knaWvwxw6hrV1TfERTMi6iwvaiDSalHOcDmHgzDMko/ZVilY1+xZZxkUIlPqCj6zxzmIcdw99hGEwfswIgktuJEir0zpMo1QrNuIqKy3oTsPukFnSl3JWfuri2XJcZNP2sLIyHx68HkUPfJqJBSnViLQt0aQ6dLe8bBQiluGk4GqzDTBYgLt7dau5xn1GeVEV7tQagJfUftbwlVTxYaQ75wInXquz5wU1sFvmli8sNBqXpw5dV5wcZKiYJ+4/+sSPHHtOLJzjp5hcGL2Z4fRzeYNSBK4EKNkoPTSFejwIDkqfogvgFEb00wRm7+DhcqqO91XgNGirHnnQQ43v1D3kDojndnTg5EG2O4nsKuwJ6pjQlzFumpgwITx09+qKHoyBvkmMp2PyALNeFmeX7kI4hCjYyj73IH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(38100700002)(316002)(7696005)(41300700001)(82960400001)(55016003)(122000001)(5660300002)(54906003)(9686003)(33656002)(86362001)(6506007)(6916009)(4326008)(8936002)(66946007)(76116006)(52536014)(66476007)(66556008)(8676002)(38070700009)(26005)(64756008)(66446008)(2906002)(71200400001)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jn1v7oDeGVKMvKz9jL6kScnO1tzLQT5TmlrG5Kyi7e0VGvpVj3+/tFRbjQSZ?=
 =?us-ascii?Q?/PrZEzOa9BPVhaR7L9qiojh5ja5jOthyKpXg/KCrrnsiTXP9SzSEKvPBLqns?=
 =?us-ascii?Q?bEwKwuVQVaytb5y0SbfJOA1UckT7xtZW7K/QIpKWxSSLfXU5FuIcPLG5KAZ7?=
 =?us-ascii?Q?a79CxDqU/HmcdMxD2NHT51I2fZEsW8Icu54muym+V0qrNb2LutAiSRLo5p5S?=
 =?us-ascii?Q?X8vnWc6tia+9nS6YZdBnCIRPkRFn13JtWQXb5XXr/O+GIYWuPcmVkHogo2vj?=
 =?us-ascii?Q?YWZokAKARYCB2LKAUSSsQ4yqoyI4aIXxwWdKwhDpRgcPnbNUY62yOY+JHCfr?=
 =?us-ascii?Q?GJXTYv5u8poPsHC6M2QvCjWknIgLrmaj7Lcxuz9tOGpKJVo1v8nWr4IBPMjZ?=
 =?us-ascii?Q?s+Cqgj9Pis1azg7slpAdQr40VYqMAPrA4A3ywEuVRo7fTdFieLdBZ+mSYtBz?=
 =?us-ascii?Q?nHl47HlYZ1VvAwqJFaLGTnlsIXqCWho7FpgihmrFrTsOo0mJ99MlYqxAGEJ3?=
 =?us-ascii?Q?skkZmRdSaewd3uAmPYu/tvW8OyIT8XdVb/qEo32UHyv+BPfudGTDSFGrclgK?=
 =?us-ascii?Q?FV77E7kuks5QaBTgu4oPqLHlGGVIZMgM+ZCFTQniMpOyYLanT21zdDjBUxvg?=
 =?us-ascii?Q?S/GBtFjKqH3bWgWPGFEz5zrNviiA0ZiMf9qpVF3yUPjDPe+x2/bOE4B8AKx7?=
 =?us-ascii?Q?wuNPwniVWi6RQ/WX1Ha5dcXOMuc2jpj8PAJ8Gyqz5hhxUQgUNasMoiXlkpOv?=
 =?us-ascii?Q?iT9IGI75Sdra9v8KakU9R3lxtSVcrN9Y0ydXMavA7TvWkln80JThKGgoLbqu?=
 =?us-ascii?Q?MLu3+qStKPz+5lE+q9B0jTg0607FtY1ks7KaGSACIIW44gJDDZBk01Mq+UPZ?=
 =?us-ascii?Q?Kyaz+Ng3iDz4fcWbVgBmXpgbtgmslEpgoa5S4+VklwIYkq+EL2l0WyMVzL9H?=
 =?us-ascii?Q?Bj4Ql6snh1Nq+yTeG5NwcttJMxxE5nitOBitTFtU/+mACxMEmtSVj0rTxVZU?=
 =?us-ascii?Q?zDTiPi9WgsAMrZFNFFsoXNwFfdEDLeU0IxwoOkAi3A3gY4FwY6UTggheet2J?=
 =?us-ascii?Q?N1uQidwzQ1VL5alD8MHHQecFvzL3mAuY2NasKSvQNFu/NGmXJbd51xHEkw2W?=
 =?us-ascii?Q?EdYdYDFMA0Ksf0ReOKCKRD6y2W5VMBl/RzxGwZbq7yhqBhOB/IMAl0c6tNUA?=
 =?us-ascii?Q?sOkLFkTbpeKESdER5rZ2fyKhhtwvifVaNUUCKI1+iOpjfQq6KM765AJISydl?=
 =?us-ascii?Q?76nyvnPm9nIJqBqGnZ962VpR9FXUx4x0RhatgjI+v+1VP+W2JEVlQGS6z+s/?=
 =?us-ascii?Q?BqNqXznu4zbxw5lwNUybuOncezN6TePLGNBL+j0JKdGX6iswgcpdsbzb8qHP?=
 =?us-ascii?Q?0aHFbjUV5sEHHU/XO/mIIse1fDtnWrJ26cHfs2hOiS0qnnwANrVyeTlT7f5G?=
 =?us-ascii?Q?Ww9iioBlxh5eB5mnedkcOzAiWLeeQP7sP0d1hiXpP2Ea3X3x35XXONtG1xl4?=
 =?us-ascii?Q?UdnzjcfSe/l4q7CsZ/ZpdQAin98oWgGkglpNo/aUAJ5gcE82dsvfC2fRzcPo?=
 =?us-ascii?Q?TF48EpZjL3w6Q6IsPBhHcF4c3eQrMOnmWXLpAjpj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9e8353-9665-4943-aa9a-08dc17133e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 04:17:39.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACdxOW1yFIyNI2Xyx4c96nVUwNx/MtxzIv3iy+vS+U5mEflMsA9TsRphWLR4VofbFeuN5mcZuGUGdcdo9KZBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, January 16, 2024 8:58 PM
>=20
> On Tue, Jan 16, 2024 at 01:18:12AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, January 16, 2024 1:25 AM
> > >
> > > On Sun, Nov 26, 2023 at 10:34:23PM -0800, Yi Liu wrote:
> > > > +/**
> > > > + * iommufd_device_pasid_detach - Disconnect a {device, pasid} to a=
n
> > > iommu_domain
> > > > + * @idev: device to detach
> > > > + * @pasid: pasid to detach
> > > > + *
> > > > + * Undo iommufd_device_pasid_attach(). This disconnects the
> idev/pasid
> > > from
> > > > + * the previously attached pt_id.
> > > > + */
> > > > +void iommufd_device_pasid_detach(struct iommufd_device *idev, u32
> > > pasid)
> > > > +{
> > > > +	struct iommufd_hw_pagetable *hwpt;
> > > > +
> > > > +	hwpt =3D xa_load(&idev->pasid_hwpts, pasid);
> > > > +	if (!hwpt)
> > > > +		return;
> > > > +	xa_erase(&idev->pasid_hwpts, pasid);
> > > > +	iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
> > > > +	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> > > > +}
> > >
> > > None of this xarray stuff looks locked properly
> > >
> >
> > I had an impression from past discussions that the caller should not
> > race attach/detach/replace on same device or pasid, otherwise it is
> > already a problem in a higher level.
>=20
> I thought that was just at the iommu layer? We want VFIO to do the
> same? Then why do we need the dual xarrays?
>=20
> Still, it looks really wrong to have code like this, we don't need to
> - it can be locked properly, it isn't a performance path..

OK, let's add a lock for this.

>=20
> > and the original intention of the group lock was to ensure all devices
> > in the group have a same view. Not exactly to guard concurrent
> > attach/detach.
>=20
> We don't have a group lock here, this is in iommufd.

I meant the lock in iommufd_group.

>=20
> Use the xarray lock..
>=20
> eg
>=20
> hwpt =3D xa_erase(&idev->pasid_hwpts, pasid);
> if (WARN_ON(!hwpt))
>    return
>=20
> xa_erase is atomic.
>=20

yes, that's better.

