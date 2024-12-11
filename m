Return-Path: <linux-kselftest+bounces-23153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B059EC59B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A7188A923
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C01C5F0B;
	Wed, 11 Dec 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS+i1BL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74B1C1F06;
	Wed, 11 Dec 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902236; cv=fail; b=qQdhSQXeL+gpdzE+FbaTxqcKInczUgzhBBh2PmmHjXmoNnd5Abtvx21fJB7KTNtwT6b8Kkkopuysy+qD+oFHcJShC87y5fLjmDzPTQS3AT7qWqtnDjrCc6gMsFyl6QsvwUTk1LyEbE5jVkFHSyqPiDapV0Ngu7Q/7EEI/lApufQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902236; c=relaxed/simple;
	bh=1Fx2H6vZgWZJeBKcmMIyxfSiLkxvzDloKN7644NaU+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EK91SS82/60KAie1g91SzHOHM1mVWam84KKh9oEAVYYZiIjvv0eVEWyXZjxSI7me4Tr7mwk3eCo3CKF5J1/cEEjb0+qt03ve/4Oy7DBPjdG9mxEZsgVLcbV3p1KFwiag4ercA06eeecQ15qki31YicVzD5GAkszuXTrDOTXSmts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS+i1BL3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733902235; x=1765438235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Fx2H6vZgWZJeBKcmMIyxfSiLkxvzDloKN7644NaU+k=;
  b=kS+i1BL3EZA4u4shFEsc6qzgl/gWe/WH8fi+Wjeu3cXMXnmPC83iZ8G2
   HVX7KbrNc0wBK29VjGF4bPDmceD7V6Re4mpKoEj7Z0MYzxPdnFRS/LQae
   3T5E0oHfF76sDKBF9SEcvrfLTkt9AC6kNkJZIsglNvark3mcAm13nHLf9
   lmDQBImTqIKIYYdhvOXoiOB9EQGyQmgVrtArKXidd93YMLBXMBl1mXW35
   47L5Y0qV8pUgf7PpEC3uHPLopwFLX0I/7TbqN2WpmGVf3FadEukBw9P95
   1XeD+UOlRKu++SJEfvLbmHOjbFuOq8AbNHdKgiXACxLB262Mx7+9khSlJ
   w==;
X-CSE-ConnectionGUID: xZLo7KM/S2iNnQ8/6bSE2A==
X-CSE-MsgGUID: a+lPOgbDQamguvV7oZs2NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34517098"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34517098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:30:34 -0800
X-CSE-ConnectionGUID: odfaosmVSLSnKyuSQbhpsQ==
X-CSE-MsgGUID: Uh1zA6H2TNeuWjVuE4AuyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100645706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:30:34 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:30:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:30:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:30:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGieTgtbgaf5wwyQ7h/+wxsitfFF234r96Vkpb07Q5LhSDffOADJjZLlLKmEPb6X1B1QnLp+hwkcxproRQRcFpRxjEFJD9PBPm2UOYEZJtY8HfUKHzkPsvT+xa29jAEu8fYXHQP9DA/baha4xjKF3yC4OCNlLJI6Vw5R8RlGQlV7pthcn+Hms+caTWkWBSatLaySsWs/8ZxnInipQR+yaGgi5YfWqJIKTq+vo7kywlxvCs0eTqvH7INN6lfrcC/cbEJGtjMOFvePknkdqfrukrMiVnnv305Tsv38+M1O7fi9Eg9MLKwI0DTWgdc96RwzU5QynaaCu/mtlPzxYXrvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fx2H6vZgWZJeBKcmMIyxfSiLkxvzDloKN7644NaU+k=;
 b=fQ10hM1cPgX264ueNxuv2Svj+FEOs818Jhf7TcNRfxMUDahAcgQ3wbNX2k0eikfZackfui/yM8KwiFOVgU8dpgXbYFemUhbxctUvP+0Mda5ec/R5JHs7pbcDPfdcSDekas3q6M29nU1KlHWUjhkrUHi3hhD2GxY6LoptnAIoaklGIqxInMOwu20BsC29qypEGVUdXDFbIhIowgyVWYI1kQYcie2zWOdvtd1txio8/2gDF298OxGmCANgx3NGVwKJyfJlkfb+ovcEpm3cNoQdl/pFW2meyJ7Bh/vCyySR+bNvoB/Jj4G2dRXj5C6QFiRZjCxJvXVA1WkAXcMmQOvpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 07:30:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:30:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 02/13] iommufd/fault: Move iommufd_fault_iopf_handler()
 to header
Thread-Topic: [PATCH v2 02/13] iommufd/fault: Move
 iommufd_fault_iopf_handler() to header
Thread-Index: AQHbRdBR2pNouE6VZkaq2J0bR83fVbLgsWTQ
Date: Wed, 11 Dec 2024 07:30:31 +0000
Message-ID: <BN9PR11MB5276473A92C8EA6C973415628C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <137e3357f00b30a08c2b49c00b968a88af8cb5d1.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <137e3357f00b30a08c2b49c00b968a88af8cb5d1.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6537:EE_
x-ms-office365-filtering-correlation-id: f37e9152-1d9d-4563-6268-08dd19b5b151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2CLGdEvgdKSViSXf9M8nFZ3iHnwub7+s6OnJEYdgQGF0VvvABZ6HcrnCeEeb?=
 =?us-ascii?Q?9lohKoTvK2LSC9PbI6QRCRKhr3IY2c7TBe7ZUx3wCUBfbEQQKA8sW986RCYE?=
 =?us-ascii?Q?YjYECwEoRpbvcvpJCaqQaS6sJ8YEBAC42/bgh948SBKuAsMghWW1WG95zbbb?=
 =?us-ascii?Q?5GE7CGfnymezh3yHiOMTXA5cjjXopodtcPfirSBANJJ2lf0n+zH+SUutU/p6?=
 =?us-ascii?Q?/JlwH6CWAdigttjeIG4t/HJMuPO1pQeitB66rLWmc8KEPJtby6ZpCYmjCH4M?=
 =?us-ascii?Q?aIVp6NQgAu56Aq7GgJEITJ8tEydpMCAzXu6iM/iXU9elN1Xy375t9dDa2H6x?=
 =?us-ascii?Q?n06stZUC8T9VOIofs9JpRNtortRsc9OmukrW1cxv9Q0C0RzkL57O2PamqSUT?=
 =?us-ascii?Q?Po5FewU+YsDXC1HLjIT3mQbmsB5MX4ECSfD2b6pHp5/Ff1IPdhnT2Yuq0JlS?=
 =?us-ascii?Q?leL9DUz1xvy3BUeZiCGlo2UTzBBxPlQznFPGksaewr6enP3diUyPUpBn22yJ?=
 =?us-ascii?Q?RE7QyDQkmYpD8CAcTKUmEs6KIGOSGVWteDoFE+QSK/FoHvuvHmcCmZ2LXRUJ?=
 =?us-ascii?Q?f9bA13pYS4/5Mtd5UDJBdKwoKTWVOoVeTPd4tl+R9B+U9F8YxnJduxKUYOb/?=
 =?us-ascii?Q?1ZNTUajlhUY/N4A2NcWaqMAMqKi4dI8oNsduwsWyOha80H0lSuDz3LrArofO?=
 =?us-ascii?Q?jrI2eZtR4vLQkKognQ0yHPiCAAFQR+sRGqc3qH0Uac3i5BY7NYwX4RPIFtZ9?=
 =?us-ascii?Q?s4GeQE2/M3gM8TLqRPG9y8OCpxb77AnroUwzIxTzLJVbYj2dspP0jiACPRRE?=
 =?us-ascii?Q?vHNtQahRqhi9iE1UqhJ1gTEyneug7DS+3Pg6oYK8GKp6UHyniZ+kUYKVCLzd?=
 =?us-ascii?Q?IFeWVgbSoyPMAf6bvEMhS4Y/ars3wuBrLRVwRuKhlT1qs55i7NgH3RoQRmsg?=
 =?us-ascii?Q?80kM9DWlUlyjn/K7T2UPbwMXB9znLmRc7CfMLjyiGAX7GGH2g98kLHVd9lGk?=
 =?us-ascii?Q?p4aV9tHt9swYgqgpQOv2+FNbdq/txxaxV5SArSaHtwdt7/dnts9/AFvQskcO?=
 =?us-ascii?Q?CusI7N7nCeXaH3D5qzRGL4WdDl+4/FJp0f+e2SoTMKDqvneUvHIhmKYXjeyb?=
 =?us-ascii?Q?9vbYWZfls5NlxeaTl4EFndUdKWq/DlAjynZI3RWCpfwf/N+Mw/jp2ifwZrEq?=
 =?us-ascii?Q?aS4VtwiapRZuhbhkQO3OujL6rDL64OA8uA56s25anujY1bxB+R5Vi345qbvN?=
 =?us-ascii?Q?KJzX3KH3XsRQg5py3Lt7ssD0dXBf3dt5wl1y+/p8OMGe/sm/MRhRhezuOxp2?=
 =?us-ascii?Q?wDwxe0kuyfHGnWsTF1s+bzK2uC34RpMVstm7pbM9v7B4L3xIC1eeZ1M0YXGW?=
 =?us-ascii?Q?5gJb+Z52NqNrWc3J5tx5CEGNlo3M3k5R2nRSBTHKVWnU234WLg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zszIOmjl97y1th+Qxe7gVTX795YS1fXk+23wXUIETA6u/PSqbZ4SM5wt+yNR?=
 =?us-ascii?Q?bhBL0GupPpxfd5Kg+3UYX5iyai8XkWgnPWnAiloNS13uye52yFEuHCoXSObp?=
 =?us-ascii?Q?NzPZsBnq/NtSSGKcP2UmsT3GQ9t9vVPsSLxPVIbEp3/Cd9hMGbUIkA08ybbu?=
 =?us-ascii?Q?uuqQQoq5uiMXvQogymOaupiLVRQKiGAGOyrQsGa5/M9JIjWkC7NzxhV9fHyJ?=
 =?us-ascii?Q?mM6H4POzmZ3X0jAGahNZv+8QdD1A43wmAKpHWrgx7ZmGiXV7L3PW0IDW/A3g?=
 =?us-ascii?Q?iSywjULDFvMsirW+jDAPCSMHZqBa4qOlsJrGK7aZBACz4QS0DSakTqnIF122?=
 =?us-ascii?Q?5OBITXmnQ/N1VS88AI8pgCA4W+GVobgwrZKkDKpoq18c6Nu2NXgmLWY8qPuR?=
 =?us-ascii?Q?c3a3Tt9iIKRtyp/qSaNOIPoF0wd6ImpbmQlKiN03UK9Hq+04v3kU6kC2Wd/A?=
 =?us-ascii?Q?WacaHuRMhnwHpZAABffvHM073iK9cy45nAUqBXQCli/bQLV6DSO9h6NZHxGJ?=
 =?us-ascii?Q?2d869jPu/29et15KHZZuAk0z4Au7G92pR5mZ4fd/kVGNZe+itfkzq05XiukQ?=
 =?us-ascii?Q?bLLAbrwTEvtoiQwvGN2mmn4nY91ZYlc6gKlDfo4KY5nykFN0zdaLDa17iZzY?=
 =?us-ascii?Q?6bh7rc6eR3Z40HwDeAEKEbbCHkLpgKsXdQgR5a4tIi9yyA1+5fsn92DPwOrO?=
 =?us-ascii?Q?bv/q8m/QMAojGgb/0atTb6sULN02gV9eHtYmQ/m4JmNq1/zWViFRC0MitLOG?=
 =?us-ascii?Q?PIKwxVK4XChkDNG9Dhmram3gfRP5saBHWO6Iyg7Y3OhOCkUpoDMVDZO9uO5b?=
 =?us-ascii?Q?i0/mBr19rG44li9L43EBH77xqfUilkVNY5kSkFCbHhhPv6A4IA7puiGZP9J5?=
 =?us-ascii?Q?eM8ZR0/mkZZK8ChvH0AZdGfeQRAXAQ+DiZUBfdHeTglEKzQccrk5cO0j9syb?=
 =?us-ascii?Q?sQYznA0qpG/z5smi2sWhjajed8po8jpeAbDoMWJbSO7SDd3r6xCkv0Z7yvYk?=
 =?us-ascii?Q?XbKmw8nxwWWL3eBhFrRspJKsBn0uHtnd9vk/TZvmQUdY+1nNFih4sIGEbXqo?=
 =?us-ascii?Q?G4I8b2vdXZnlme4aUPPFJ0vE35CZaBOIQISfW0tfZXA8hkh5G/NmVxkcv0/H?=
 =?us-ascii?Q?bUAg7U/ht89RVpnzd05VjENk7IbqkcYWa1GnYxy/iyyY2ZPebVogzwFKtyVw?=
 =?us-ascii?Q?FQ1IJLiAhpKdkKbGBsC0d1yfn3BOOATo0KJZyMVZCpjMfx+ek+/fyYYXyqTn?=
 =?us-ascii?Q?qDk2YudlPrdzV/PolaJ7Cbrc1BxKf/sAXpcqX86ZMQIzLMxogGUaqob+BZrb?=
 =?us-ascii?Q?40lVCNZ/XYLp8n3LubqOyS63amEuyF+Sws9vw+E4il0J3D+rPJ5A0XUcYXeV?=
 =?us-ascii?Q?VrsRWXREcNvoOXAGG6Gksb4XTleXhTA/6Cm5lexHDQ9kLk2zuE8Rk4pKb8cv?=
 =?us-ascii?Q?1ry68SNDu4815Oyb/iUEByosg87IchTliHXz/HUQ3EfkQO09TYqhhkzNiql9?=
 =?us-ascii?Q?ax6MxkxYqdxXOv1MWxS8ae+IUHkTnVP1tJlkqAqY+9VDDORD8YCHf+NX46Ms?=
 =?us-ascii?Q?3sAwvCDggCgpQx1yyjk/Dghn4mXet5DroTdXAUfj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f37e9152-1d9d-4563-6268-08dd19b5b151
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:30:31.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sfP55zwdd7SjhFvJ6VzaurxLNzZhc2YmKklcpHS/s8qgihC/vDck2tDzJH00qVxAYC6PUjsqRxzZMSD6DBM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> The new vIRQ object will need a similar function for drivers to report th=
e
> vIOMMU related interrupts. Split the common part out to a smaller helper,
> and place it in the header so that CONFIG_IOMMUFD_DRIVER_CORE can
> include
> that in the driver.c file for drivers to use.
>=20
> Then keep iommufd_fault_iopf_handler() in the header too, since it's quit=
e
> simple after all.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

