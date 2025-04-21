Return-Path: <linux-kselftest+bounces-31237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA8A94DA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 10:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1CD16CAAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602E20C005;
	Mon, 21 Apr 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUc1Kjzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126412B63;
	Mon, 21 Apr 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222746; cv=fail; b=SQrZHnbDhN0Wi4z3KeWgcCmgVT/xi3HQfGoOoLRcOwlnGDmnEmxy+a7fumEB9GIvoFh0IdBk/WtVFM7BkXXHTgThX5n53QroLkJ34C/zg8rqHZI0OBmHeZqT692GaxKrisHRhuXLvdI1tlwk9L14ocH5VSGiWaYYaM7UeOUnwH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222746; c=relaxed/simple;
	bh=hlI/uLtNGz4LsrKd0yoZ6XvmvXEEed7JH1ADXnBkNxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMkwDhkCSaB6qV56hUbzadrJEEyS3eby0HcpnXf4B1jvkFRwVnjAh8s+SV1nAvLp4JuKbNernBBlCCGcX6aojm3DSOVjYJzUBcxfTOFM0xZjECyj911sg7S5KIiBMSq9lk65CtgAquuhFIJLebtlzG7sdlZRrHMUoUAtAi9ISQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUc1Kjzu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745222745; x=1776758745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hlI/uLtNGz4LsrKd0yoZ6XvmvXEEed7JH1ADXnBkNxg=;
  b=FUc1Kjzux49gGC71V0qLdGmEjSFNhwQLVzVlTYPgsR2DNLCu76+G4MEr
   /Fch4nD6fRNX8UhU3y8bb+FtOPmqfuM/8ulWZuT5PS8aUxd2uZn/uZdbB
   7Ky3OfKzzFI3gOylrCWHcD2PxeS0I+pNejZ6Bj/hm9VkBWUGnHlSIf2gn
   rst4OLAIN7xegtmYlmWzMBd2PQbt9n7s4L8wexwhP35dSVuC27YPsDlaB
   1EdzWzG8xdWbNJt3O+Fgba2lHMYlFsCkDzbwuwQwNXYxaJ+YmL8qU3q9J
   ahUEKyMHBVM0eCacctlWir5kRNL4OloSSTp/to6qjkdEy/WwX8Bb3DiHF
   w==;
X-CSE-ConnectionGUID: b5GLDscCRSaLV4NtFuRuQQ==
X-CSE-MsgGUID: kXr8aiy4TSa1YGjmGwVSJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46923250"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46923250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:05:44 -0700
X-CSE-ConnectionGUID: VqL8sTsDSr6bklRpFN5ugQ==
X-CSE-MsgGUID: Pv+y0/cfQnCMi3QIcMaWHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="135743914"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:05:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 01:05:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 01:05:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 01:05:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxdZF1a5xkt36LsH8oS5GUADweTG8PzoPfXS/D5oe3i0kxc18qVEkC14/MXD3N2LRcYCeJ551ticYi6UgZJECVzTV9zeWbqD1sYG+InMuwL042H2OSmX7W0l8K5jcUWx8rwtTAbRvDCz6eL6Vzd0NEFRCXDsFS9wrZPEWrPSWvjauEEwCrrU8cEoBXvLNJL68CtxmkmfgA3CC1+8Vh9apzTiFt5//72H/txILHmL8/MXPYt3T+kDxlXveVNmRMNaCH5JjdbQcxXNvFhkMQ/ElFoacTzSilSJENGj80ItRdpYmGmNp+Kgyn5LDF1KzYADg+4XeT1Cng0/lELN+dFsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cezWgZJXsBTUq19mEpO6MRwuHQqIX3DY/Ixv3+wS7rQ=;
 b=p0e9K7Zsk4PwQ44wIn2jkhs6IidUpb7e03zt0EgiNsn2PoMuWqOO95lyU5JPdZ2C65Bi51mLsqhFwlUrns31qEvi6vMw91Sxfg4wp6Lu3XFSnwgyE2BUIpwfhH1nX/gk0Ks0J0vcquj5VTJseYW4QuGaqIMO0f6M+dh21KdPuGpd9D8T4hdh8eG4LfjC9E4YzVlGlxaRjGS1r3VP8MrP4w6MFKuIjtu0PVbEvNhwMUIfD0r+g1QXKgvFIFjqOljmK3f684Hy5O9Ukz8oVPxAwqWoN+i1MCGIuNoxdD07r1LY8iBwODm7xhGKvdKlRpZ+9GDuUJ3IeQuaXIDbQnJ/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ5PPF5DFCDEDFC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 08:05:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 08:05:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v1 09/16] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Topic: [PATCH v1 09/16] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Index: AQHbqqxlS2Ix88CW7kC+m6SKBAFmpbOt0ksw
Date: Mon, 21 Apr 2025 08:05:40 +0000
Message-ID: <BN9PR11MB5276F362FA971F6A5861BA418CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com>
In-Reply-To: <5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ5PPF5DFCDEDFC:EE_
x-ms-office365-filtering-correlation-id: 503e4785-d4f4-4474-2119-08dd80ab4ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jFXOOe/W8IEP1/rBYzXhNfUEhVEyQBVMPd83gT9IHMvNwTZ6+SdGYGdeQnuJ?=
 =?us-ascii?Q?GEPuPJz41JIyl6cPKve2BEjHbmPLFt/ZKw2QHo9ksigm2aVo+raJtwU2GsQt?=
 =?us-ascii?Q?7ohgQHAsGtfvzbkPHAUpTXp0fbYqSK/qc8OEZgYEBxU+MNZiKtWhMqcQIgO1?=
 =?us-ascii?Q?rnNBw3CmBZ4LKN22TtchPfF3Swvoz7sykt9fpGVEi8GZKq9gFV4EFkJtskdW?=
 =?us-ascii?Q?MPXoAfebsSqqKMDMGRG/o1b/UD0lpHqNSWO32rVlsLlsasRXc3AhCXPTSEDE?=
 =?us-ascii?Q?n2LvXGkCRqylk8pD2Mvnujv7gSsvyhaCAtTNy39X1xr2Hqq253swnic5qmrj?=
 =?us-ascii?Q?z7r5PrESzRSUuCKJva/LvAz0+pI9GONuHkwEzTKvY9i3vmke31UHIGPM9U1o?=
 =?us-ascii?Q?J4Eqq+O7mcOym0U2waDoBA7u2K/wDsqGPDbaWtOKwjGgT+8No73dgustqHaq?=
 =?us-ascii?Q?CrbNyXuAos+RzTH236ThAPQxNf8+WOH9ElfY3aYZRff3LnaSXyWqzmTHXIGS?=
 =?us-ascii?Q?VDvwnFx7NQGMNkbV3tOZknWDbkcWtNEk45ZtY8LXlsP78Nlehystcrj6dDXI?=
 =?us-ascii?Q?y5P5aqRU9aN1byTnPfymdpoahgu8Li+LizVu0A0ntl3P0+5vo+US76LIwf/X?=
 =?us-ascii?Q?GTxHKfvwhYAZY7mLov7Sqhntgtnrj9ICV16ITt3eqm7/k4w6B7xcFNeq9uZk?=
 =?us-ascii?Q?lhvHWCUiuX8Mh/28AtuViVBznF1nVrXqT34pA3OfjNia4yWgqLLg0iuCoLoj?=
 =?us-ascii?Q?2fAlt7MC4llFTICeWaM7wdwFKO0h7tP8OMEJ75z+0Lu28coxQEMx25ttRqVW?=
 =?us-ascii?Q?YgnLtrEC/WM0fHDcz8AgTMYa2ybmYodKz0VKFBHAbkvw0TRh05r4q3RM3dA/?=
 =?us-ascii?Q?9mgJpEovlDzcJKEeKV6t14l3LWxMmrPR6ZEvhseAIxFHyU4GjR0PC0P1ojMU?=
 =?us-ascii?Q?Yc0jbjaFJb4q255p7sZm+WFH4jU/WHC1JtwUuDrEd4QDUkLKAGD5mCDglwK7?=
 =?us-ascii?Q?YrXgSc2e1Tb2S3PG90k+Kuz0+pcrA18gUR1UWXEvLeFu9VPCImbU2Xc4LTIW?=
 =?us-ascii?Q?nEUhVMO9U3vAlK4xQ+Ju7TG/ytRt+pFVsbTcxVYTKvKItBMlgiVYASpANYu6?=
 =?us-ascii?Q?t3shmVKPybaqcW56H5/ZgNO2j3q9lQazpz1cmhaPrKU7OpFYeYCBoB6Ky8PS?=
 =?us-ascii?Q?kExhQKwabKkPVG4KveMcaKZD/5GoCIUpuqi4q6Y6V6HvHP9B0joSXAhPZjDI?=
 =?us-ascii?Q?LOU83+Kc0vBgnVRLssT/C+3ZCxn4pelAjM/ERkndvM0ryqxdNLxzp5GukJ2U?=
 =?us-ascii?Q?8mra5e//oOyCfzDV+GnoUcpDKwhn7PCScobFVeMlHv8mmZEUStfVbJncvKUN?=
 =?us-ascii?Q?HcgMqeyyGIMY/YH3ac+P48bCEZ8Xh0CFhA6RnxU0lN+c+Ukl/DLF8yxqJod6?=
 =?us-ascii?Q?n3LSEy65MgJf2KUKEPOBB8+jmox0LctNFomGGFeMkWDJGeB4WQWGRQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bJdGFNGN0/GC2pEQxj78cG7LS99MunAZB+LsAVDJqm+OVmW4nxF4I3yyUisl?=
 =?us-ascii?Q?VMquA3S0al87l9/1GQwff2g3jKl8YP+QLKpuv6+HTY+h0iwvriXhnD9FlZdN?=
 =?us-ascii?Q?QPgBpSCKgnraZk7MurKvbBGKEpWnwlLGXZBxbiL/9mAq59Xs2SjfixtgMlNV?=
 =?us-ascii?Q?akvHbgY7wqZBPdMcuyd+1P+204KPD/eyEPVf0G6BZujLjS4lm1azVhOKIeaU?=
 =?us-ascii?Q?lDrCj8uP+8WxwDDeAG0RpwF1QwbBipxIhuwY0VfEKKE39efuJJd+NBNmLeCZ?=
 =?us-ascii?Q?RHa8HXBc1AYy9X2nmxAUjcWRYvu8nZdopLfv1YAfd7uXDhcxWVXl8dHG9Ap4?=
 =?us-ascii?Q?9L0PsmsglbNApVJxRgpIuLiLQeDwAAUpaWFVbRlqMsd6EFJoUvUCJSBzlsH4?=
 =?us-ascii?Q?RArPW4HkFbBmeLMuCy06uJvV1LqYEKgZmprbj9vX0cza8osf5XOygo/LADLr?=
 =?us-ascii?Q?xblii6Crw9ogeTMQJfBCxilp8j94Qa0LL7e/TsmHwni3DJK9LedFLZHRAcQU?=
 =?us-ascii?Q?ScZhpHzYGQaYFp4nS+00elrxEnjALKcuX7io29PDtz8CTaOuVP9c6wHniAAc?=
 =?us-ascii?Q?iTCDWOo7advJxDg/gqsnO9KWQ7aV63azbAyXAqTEKUyxwSjSfXtVjbZwFHPT?=
 =?us-ascii?Q?Wiep9qQS8cug5pYII2utc5PGNvdoKx+CqVTMG4ReZ7gV9++HmQ0OkCwQk/9I?=
 =?us-ascii?Q?MpRnXFcUmQ31Ty2w/sJZXDlpoZrl/zPSL9TdU69eB377m4QJlf/M3oKvM+VG?=
 =?us-ascii?Q?v87amOULp1kUZQCHUWeippfSGtSb9P7Tm1m3y2TNezUkyvLaAjjn9RO+eaM4?=
 =?us-ascii?Q?CXVK5U19MLEKxEdShU2tDwCm3ekv/L2lmSWJgI++Vh1q3m8inTzsH7d5wMRN?=
 =?us-ascii?Q?1czmL0uBWGHfSn/Ixmt1ADVraxaKJJM+cKU01d3PZ4woHozeVTIdVipf/iHC?=
 =?us-ascii?Q?1DV+xDyJpJ0H1vYq+1rsH2u3PQEp5P+xasDIbDBelb/dmGZcSjFPXhvVOQyA?=
 =?us-ascii?Q?voohhQeATlnBq0S13jDwruOidA4YZiqGvmXnvmKalaHIH3Tq3CkKhWfqjKL/?=
 =?us-ascii?Q?tModJoZC8GlEOTzntYa6YfvRk2y9MoO3KpO7/fsLZ9gCyBhIyIqM0hJ0ItWe?=
 =?us-ascii?Q?k7/FjZUbjXp49JFMRWfE5Atz/Z91GmP+RPUtOF15Bp5Lj9fTzWT0tFiH3SMd?=
 =?us-ascii?Q?ShBcD0XA9ik2Lsj3VQHvcbEmHvBcUah79zEFNJ8qqkTkPEnM7d2p4N7AfzGX?=
 =?us-ascii?Q?sgnHQob9gAduSQBgHOp2aXaZdTStUTvdLasJqoLmuAOAGUxezZN0skzKOJGM?=
 =?us-ascii?Q?E2sMDvekTCO3xjTLWk4uXO5Hjh6MKbFtN7VsJBD+38zZHnt2EP2Z+SIzwt7U?=
 =?us-ascii?Q?3Vj+Jn7SVenCkIl07CSyVzvMUhGoL/Z+rG0yWd7auAVW3wrgoCnSkWFB82ZL?=
 =?us-ascii?Q?09atl3vtbTZ7TNwL+65DAX7nsb5tYULTNja81efT3D2pl394HRlFb185Pgj5?=
 =?us-ascii?Q?9+2hOO8udIYh+5Ifc/XKX+Bhkfm8XhNnqg0fF3O7QhefoHEi6xv1DT+Kb8lF?=
 =?us-ascii?Q?9iCKLEocWm6kEiflNBLI4Dcotd2TJ4fGIzTXy4VD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e4785-d4f4-4474-2119-08dd80ab4ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 08:05:40.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xxVGHn8YJO/3BGbUCr3c2MD9A3X/68TACHDsLD2Ukyutlx2AxvhJKy/rU93izszxFeQmJwja5OXBn0XaqhVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5DFCDEDFC
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, April 11, 2025 2:38 PM
>=20
> +
> +/**
> + * enum iommu_vcmdq_type - Virtual Queue Type

"Virtual Command Queue Type"

> + * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
> + */
> +enum iommu_vcmdq_data_type {
> +	IOMMU_VCMDQ_TYPE_DEFAULT =3D 0,
> +};
> +
> +/**
> + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
> + * @size: sizeof(struct iommu_vcmdq_alloc)
> + * @flags: Must be 0
> + * @viommu_id: viommu ID to associate the virtual queue with
> + * @type: One of enum iommu_vcmdq_type

s/ iommu_vcmdq_type/ iommu_vcmdq_data_type/

> +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vcmdq_alloc *cmd =3D ucmd->cmd;
> +	const struct iommu_user_data user_data =3D {
> +		.type =3D cmd->type,
> +		.uptr =3D u64_to_user_ptr(cmd->data_uptr),
> +		.len =3D cmd->data_len,
> +	};
> +	struct iommufd_vcmdq *vcmdq;
> +	struct iommufd_viommu *viommu;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type =3D=3D IOMMU_VCMDQ_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->data_len)
> +		return -EINVAL;
> +
> +	viommu =3D iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	if (!viommu->ops || !viommu->ops->vcmdq_alloc) {
> +		rc =3D -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	vcmdq =3D viommu->ops->vcmdq_alloc(viommu,
> +					 user_data.len ? &user_data : NULL);

the length cannot be zero at this point due to earlier check.

