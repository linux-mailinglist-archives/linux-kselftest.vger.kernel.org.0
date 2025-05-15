Return-Path: <linux-kselftest+bounces-33023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6DAB7D18
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C14C851A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD34289E00;
	Thu, 15 May 2025 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK5pS3TR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C0274668;
	Thu, 15 May 2025 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287792; cv=fail; b=Wf7Z052RWk1ijtblMDJWi99HfMTfhDgQqNb4h7U2OlzixDLc8iXsDwmiggXlN5OmC5U/XeGaRqiiRGIdA1qHvjri+ujjIDmX5qw+CYS746ekZrkSiuM8Po5IefbKASden0oPihd+tVHvQV5wXKkMISXAXa/hAitQEp0oIBNQ9jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287792; c=relaxed/simple;
	bh=zHHsbzf7Gfd7o5FgzuTM1iz43QfAlIqINLFc7H5z6hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ac0CPoMBp9eW8mWGRAew0pyEnW+a95hPCXqRc2XISO+e7l2ATuwjO2smtP+rHrBSdvLDZFGOsuXGGsH8aOYG+9do+2IIKW17MjuhYRQrHeEmXgn5p4uqcyWnIo+MU1RbhaGFpm+HdxvH9rfjRav073nhdIp/8z8f3ODtRuT5UUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK5pS3TR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747287790; x=1778823790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zHHsbzf7Gfd7o5FgzuTM1iz43QfAlIqINLFc7H5z6hs=;
  b=IK5pS3TRhy/qygp3hek4pX7pdfQ3H/SfrCRCpiNKf5Isz1Bn5TQKFdxK
   fOzhAgf5LsI9H5KTXhi4U46uFb58G8JMYXW4bwFf9Zfp2MlnDAat99V0m
   KNsa7QaEMn6ZhePvC2mAn0aRAlvx/B9GwGcgIOTpksLGDpocM/Flqk8+N
   PONBs1KNBkbZXtl4DBEX+4Fv1cQb/EQtjhyT8hoF3t/6AAUaKmv498/qJ
   in+2P5dJI3tJK8K5x5jvsLfoJZyyxqQx4D4mhgRv3lCM+4MV08CO0uMGZ
   NGGGRCVwEN99Icqxoqua3Wz0b/UBggW8d3PWh4AOv+qS0yzxSHQjNOOkB
   w==;
X-CSE-ConnectionGUID: uDul3rcSSeyuBWQUxO75mw==
X-CSE-MsgGUID: wUTIg/soTgKLxCVJP3A6nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71718499"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="71718499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:43:09 -0700
X-CSE-ConnectionGUID: 1rpLBn/UTZOpaFEgcSkH0w==
X-CSE-MsgGUID: 3jgNlhOoSpenPv7A+RJ/ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138313415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:43:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:43:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:43:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrESy+FZv/qYiDuUqOj8diNkLgzelWOiFKY2+TGZmmY7bR08cpsxZ1BVa1gXJUt5iOHHIjHbyntnvVoM2/rdZEYa+OkxvI7onY3QCDqEj88GcTnCUoZQ76Ed0Jf0R8SGyAAU8lqsPO1Du1zkPTGRbXQQEjtl1bATNPn4C+hxpPLZj7IrDpXj7vYY9j5W+sW4qnoBcAEBV06J/b9/pQhGOpYQd46SgcJBOzCYTWBHW9zdvlKZEI5LlJPrhphmKKZ1E6swIsB8h01F213KCxmxODYgnPEa51+viLsZTLfejbUl4LdsvPBY1/8P1thayohC+qqXu/4GMGiW03WX2FHH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdblWF43CHrhngoTmPTcuxlnjtEnDA3P3ugt2AVUwyA=;
 b=HkVFdjqq+tOOjt2VhzB0jNJo7nzJ1ImDPcxzaOvlrDm6RN4UnhoO8QqSoA0l7t/DTSvfwweOIXXliohXQBoCw8Rm34Bv0o9Aw/6qSBc2RyXHs+kOmesn+MFlLtSAlTCFoqGXjdIUf/q2bFkFs5VYvYrZrJy2wljklDd+K4CPzWQEMyvYYBlcWrKlbnmMJO2Zot97V1OdH9dq69TqQGYvUEr6r5AseX2VX/oy7M1fsxCclYdWbedrRoVC5WOkf8MMtzOoVlW6vG1MYHwLIy9iZ2zCDLOM68F+x8yzLfJvl5xpSmqoFr5BiOfcx0NM5veBGx5LKQLDCBqU4EdCvkLA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 15 May
 2025 05:42:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:42:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 01/23] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Topic: [PATCH v4 01/23] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Index: AQHbwI7zW8egeSiSOE63GohcDKrLQrPTNsiQ
Date: Thu, 15 May 2025 05:42:46 +0000
Message-ID: <BN9PR11MB527677AF23F5CF1605666B388C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <cceddd59f04599e120e4620ed001f5d16fb66ce1.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <cceddd59f04599e120e4620ed001f5d16fb66ce1.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: b1a18a90-8108-4286-b032-08dd9373522b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nHiBRg6i08yP7/zaWXZ3zsNxMSYFyLP1JwswH6QVnA9MOyQmAz+ndCR7Wjt1?=
 =?us-ascii?Q?jyKPZtAqiiWK32aoNEUbWVQ1rBMapKe1lX6VA1mzIQq0SdCwuscdcuX397UC?=
 =?us-ascii?Q?+LSil1r7p08Sw2z9tvt/eio8LWxki7LnroYYcfkh1utMPduKhYGq//Loj+6t?=
 =?us-ascii?Q?cvC0IRkdTw2GX0RqpWxOi56MWTF5equE0Gi+uvVjCueTKPmx9wWqsnb3T05O?=
 =?us-ascii?Q?LApSNmOtkdQpB+GUYTMp5AlWS0aA6mrqH5Uc7NJbvXSF2SgfUA7XzujXr2Z5?=
 =?us-ascii?Q?Ht0RT//uaMSKsWc9wJAQNkW08EDNAZUvso5eIDhdvqBbbqwwC+3QbQ9OTf16?=
 =?us-ascii?Q?KE/cTtYHZ0spjpVW3FCeow1irwPkoh1yJyEwVFwTbRsJh3t6y5vNYFa4F7HN?=
 =?us-ascii?Q?ye1VhVUqvCYVE26hCVLy2uP6rR/WLEX4DzFIdZsd9/jgokidsY2QkfbDmEPS?=
 =?us-ascii?Q?IE3IOlPVgWdXev/zSsaqr9Ms5LTy4LxGiFX7QmoHZnNwMcVpBe5oBCRYr07U?=
 =?us-ascii?Q?A6q+MxFs/mB5j29xoh92kl3T5+LPcPkV1xmBqPCGWHAVjmYZNa4jYwLGSYL/?=
 =?us-ascii?Q?VW23OLRX47lUpAQRUOE7f+ocwOseZ+gEm3i1TaV4iAXqchvuYhYATdJCPRuh?=
 =?us-ascii?Q?W5CJURZDBRhLtD5HoGUC31AdX8+r9lw8IZJAT5yBL0zb3j0ILs3zz5lixA0x?=
 =?us-ascii?Q?ERhYzneD6w/xA5gB+58Y6uTakX5usWXfmWFsrHHQ/t9QC7E29iUzLRSNKCO1?=
 =?us-ascii?Q?vQTNNparuPsnmKJnpn3OqYgKgHJIKf90N+lHaWw2dm9f8PC3Avgo1wxwlvQM?=
 =?us-ascii?Q?DkG19oDQVfCAx+Du6nm4nceEkD76Tw1prqeLvnUwnFGDK69wXYMBzSnHnvk6?=
 =?us-ascii?Q?X03Kr99/gL8M+5a4nBf5xM1L0FuECJCfVWR+jRHVRkM4Bd17g+8KT5PSVzLI?=
 =?us-ascii?Q?VRdm5V5+3XDgZ2z5ecQJPS3Pbg7V7fNzjgaUbt0we/EfU4Rtd9M89KlHr3LQ?=
 =?us-ascii?Q?5c5nLb6RxAEiB7APd78V1lDFPcsdDrOBNzOrhP5HdLngU2eb/Pjt8woXpFqK?=
 =?us-ascii?Q?w0mGYMmrveD6QEIokjF45bbfhcLN1YuBQdUWBMsVMQfSJS4ITxpfvd/sYO8O?=
 =?us-ascii?Q?dH61omY4nQqNviJvlouygjOXmNa/5W+ClA+CtpcwhUaxtTIxl+IcocCTA7NE?=
 =?us-ascii?Q?MFzTpo51mVJkLtUu+9UAZokir7YV1R+ugrto30vEsfwm4/zv2OCQZCb+YsUH?=
 =?us-ascii?Q?3GWBJod+e3TxUZ8xEACRNzE4PICCv/xYkXE7ZTzDopUNwY5abzw12cLS2cKR?=
 =?us-ascii?Q?l+0UzEhInvS3ZimwEu0ASgCqP/Mwp9bNs84FEB4CMev5ABvoloCTSJvBSkhJ?=
 =?us-ascii?Q?xEvYnabFCyr6MwxaWqVUdEFMRin1MJjv74S7PKndSo9vgOitkFiPTCEM3w35?=
 =?us-ascii?Q?RZTgkdoTRAbAwyPwFugOIjZXxYp8Ek+HTvJ6RDrKqbHr1pBeYp3pWY70dOPj?=
 =?us-ascii?Q?I/koyg1Yx7e4rFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ckDRNnYMN0Gqh2qQNhkvnlYT0vIrj1KovIeYUFylcBzUz3eYWhatIP+b0cta?=
 =?us-ascii?Q?a+4W1vNEHB+NOxC9lpKDilxqkHq/5jfBrQQRsLV1P5Mmw8/Cs6zWOEd5fLQE?=
 =?us-ascii?Q?JajhFSLjleZT6mYs4ZNimXtMfTvfMVDetK+V6FXEPbp02BJig6oHY78tIdvh?=
 =?us-ascii?Q?i1hX5wYsmhKDj+tdtvllpLNaBom9KT6bhogIWXx4bkpQBWEuGKkVcbB6aIH8?=
 =?us-ascii?Q?KWROpVHRSDzw0A/+q1mCjuYjRywM+8EtFeeElHTkFcbbOG3U3jgFYx75mX21?=
 =?us-ascii?Q?4JsfnpbyPLEIzYP0Mk0VGL68xdpzQQe/oFBx0hJkjKkka6nfIJnpPWZ2CKgg?=
 =?us-ascii?Q?ZPmwLLmYzCgwST/UZDi5qr5yJChiPnugx/uT0qrAAgHZcm3Cqz+XHspivB0F?=
 =?us-ascii?Q?I+FJ6nElT71mcXrxaFPnCs1H/x92hCSJZpY+IT4UUThg0ROC8/ViJuFnPnfF?=
 =?us-ascii?Q?3J6DSjW9T7loiIkpBn6SMqlKji3LzdfbwsWngmCdNEVN1HnRNFnIRSpF4rwb?=
 =?us-ascii?Q?5ITuDD4drSmbpOSYNPWbb6DxGOk82p+rR27xxcekwZu8qvXqiGOHrgr41GR1?=
 =?us-ascii?Q?mYaaNgPpSZpUelissfajELT4XeGMU8IDpLDkNkaRK6euFYDD1xAIexHSrPSL?=
 =?us-ascii?Q?h1y1/xWLX5QmxCyCLB10tDfx1MRRgebQbLA7AXN3jpTCDruqCYdLKwcomW10?=
 =?us-ascii?Q?nch17ORa4AmmwAxsQ03ePB77kzjvRX4QsORRRNglOixUkWT4FsRpRX7dpwAo?=
 =?us-ascii?Q?f3LvVDx5XZiiBzIZNrDJvUtCjlLHciKA+mzw+O4xT5G4HHBsunwvhhbP5TMo?=
 =?us-ascii?Q?EWQ/xkcOaP4lquM5BpSoz645cyRN9/sTmnJ9a/9CjN7mtkzL62mFtDtPWEcW?=
 =?us-ascii?Q?CdKzMeR7K53jfQLY788u907sQGzyf0ZwTbNspOidj0OQfOnsEO0vh9hXH9H+?=
 =?us-ascii?Q?moj0JT6d8RC0OWRkolmV2gPl85O9iIsVSsK5kj3LYbOKcQyoQFEFYFDIS6H5?=
 =?us-ascii?Q?nHuUs0D7Poo5ri4vBRbucJS0cFTO3FdKSIr1+TBVUTIcrjyWqimvuvAQY6Mf?=
 =?us-ascii?Q?QJ40ngAoMPy5WnNJctDJ06vEsZdLDqGciv/D8YormGiCPi76UhkYpZ8NzXqz?=
 =?us-ascii?Q?rRZG+JfEra56EIUJ+OxxlWZazUJMvZ3LCH72wAkcodnnDZCFFAZJxH2yB/If?=
 =?us-ascii?Q?n+eAmM9PdGKA/Mb9kw13Zi3ahL9abutZKKU3H8dKdqTG7/JuRuUvN9/NCStP?=
 =?us-ascii?Q?tUuvXBM2O3iD6smxW+UCGU1WRyMERT3G3kgLVcOOMykltVQ7JJPDkPNUkfWx?=
 =?us-ascii?Q?6wASXHVzbXqzN5+0rxNiG4aAjOF1PlijA4yhyiGwSgmeDCpIph8C5oIZXbm2?=
 =?us-ascii?Q?QMzkBuILFNGONIzuXr+pCpGFAECTR91WYb2uy9T6d1NHn0hVbIa5cpJaiP29?=
 =?us-ascii?Q?spo34cUr+KzhX8M3JTFvNPo1zQ1kXcvMcrRTF/IKl783SG9U8UJRGlu3TUii?=
 =?us-ascii?Q?1U9F8okVZ4w/56cdoiWabQ3vIIAE6R0Xbmt8uNkNzsWM9C1ZznEFsfL5iRrh?=
 =?us-ascii?Q?kpNELww5FkGUASoGq0zEYjRmj7cONPxZ0fE+xz62?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a18a90-8108-4286-b032-08dd9373522b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:42:46.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81uLxFUcPtBOcJaaJDnl5BWUWyzd/yi40ipXllrNY7h2zSU2inqXTKgniE5IfFog4JTD/9TZrDIhfVVRaqzC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:02 AM
>=20
> +
> +#define iommufd_vdevice_alloc(viommu, drv_struct, member)               =
       \
> +	({                                                                     =
\
> +		drv_struct *ret;                                               \
> +									       \
> +		static_assert(__same_type(struct iommufd_viommu,
> *viommu));    \
> +		static_assert(__same_type(struct iommufd_vdevice,              \
> +					  ((drv_struct *)NULL)->member));
> \
> +		static_assert(offsetof(drv_struct, member.obj) =3D=3D 0);          \
> +		ret =3D (drv_struct *)_iommufd_object_alloc(                     \
> +			viommu->ictx, sizeof(drv_struct),
> IOMMUFD_OBJ_VDEVICE);\
> +		if (!IS_ERR(ret)) {                                            \
> +			ret->member.viommu =3D viommu;                           \
> +			ret->member.ictx =3D viommu->ictx;                       \
> +		}                                                              \
> +		ret;                                                           \
> +	})

viommu->ictx is set in patch5, so logically this is better put
after that.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

