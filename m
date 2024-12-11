Return-Path: <linux-kselftest+bounces-23152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB889EC586
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3530284D14
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E41C5F11;
	Wed, 11 Dec 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1bOJhmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DE1C5F0B;
	Wed, 11 Dec 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902082; cv=fail; b=rcCCb0VSqDn+mLoyVwTNgxI9/IVD15J/TWI92sBxFGXziLe8hOj17ql3r6rsHTt4LY2Xv9GoAaTjGhxtBHWj5crUE5bNzmEjWa6gP7LJ3PpxLK++6rUKSM1mHcA8mEnLOARs0AAcsFcgAH969AzuEGpBH3UZT0IZebcQcGpoyLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902082; c=relaxed/simple;
	bh=DuNNXy9lgd56pCoejvfMh83rXfFG3Pn1MxuaqFFtgv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jrgqlNkn1jzUhSX7tz0HiqV4WPrM+P6A5VD/0gorM1KwcKPzRSyaJkL9EMROST32QWzoAXu9MCTfz2rmemZc/VxqLRLW7L2mQUcZtMpl2jJOM/BoOCqt2j/wkAOC+Ayp3fbWVliWuZtfgvDhxTJFfPX3gEDyAIzjS9aLGXPiXrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1bOJhmG; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733902080; x=1765438080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DuNNXy9lgd56pCoejvfMh83rXfFG3Pn1MxuaqFFtgv8=;
  b=k1bOJhmGNBuisSepv+DPKu7dPolMxbhVtlUNjTwU/ARQGSXncRSlEBAw
   xXwpfv/ckRxnCbdLThNKRYB3VeqZc0LdMistFcKmpP0l4LUyFH7o554Qy
   LE/8FxGUvNxPSCUD1uyq387qcj2NftRfcvgfd42MHZGcM7XK+H0NZnb/a
   OcQyPnDC0MxfIZ+jcbZcZ7UHysO7DGFcDj9KDah0VKIm+SC4rd8WM05I/
   fzX3MAIgBVBsEHBHxTbr+slLTR9QtqqliQYlzORVEZjXyUZk5c1G2+ep3
   6aHuKDvFUJzt/Y62Z6xxMvxg7fs8xeiBv1sMIYC993G3ukPHfsyNrDSsk
   A==;
X-CSE-ConnectionGUID: WNvKnbCNQGuHqzbXnRqEXQ==
X-CSE-MsgGUID: 38bFgbx0SX6vynL/celo4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="21854746"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="21854746"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:27:58 -0800
X-CSE-ConnectionGUID: 1GgazKeMQp2l+WrGdmyTug==
X-CSE-MsgGUID: 1B1+XgIJQc+3Rnz8FqEynw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126619530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:27:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:27:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:27:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:27:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUQBWhC2tvRqok6MVshW0EEDB1o1i6hkBM452saEDKJWIZOF2tTIosL0wRoztki+qgeTzBGEY/uYZAEyyNgogT1gT+cDM77iAc5O3AOma+uRNyTdi7rxhYHPWk2ThI7ETXCdIq1/g+c0oe4ushXcGk7ROKEywx5/SDqHgJG95r/0Uq8JL8Y1DQ94tPQR2L7OMu1XaDjt76+6SbY5n1AomBMAAZyC9V+2CyKKIlghc6ap6Bqh6ZySXg9AdFbWGVyhW0ZHzHWjYr1nBThHP+Z0gADB3FYKHQpnFilbqbyUIkq4KhZ/410vgXgi3UtihItZ4ZVN+GdCjKF4E/QBHdtpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlylXyVD1Ev4BGnT8q3VBcyrXHmTIsC5wfGjOxlyauA=;
 b=Co5+oQGZyANGGuS37uvdq4crDzBizlQ+Dfomak7PVWgSoVZI6lOBUr7la9U9wUpSCXmioRexrV8106l5uaj3msBnhUaRhogHv9+N1DiqwxwZfEmDrCmO4dg52QLBtuePQFMBbFnm2YI7uPP/uVnLCiU6qAoulHk8CMhcr3ZtuWyacJ2W4hX5i7zSrDANcmhL5CVIprRW+rHPs1wUOMaUTcXfx/7UkzC+vVCkjIidL/53n1vtoYKvZeCjC9MiWruY2KGHDpwrH/oSISRGF0mXLMDLkmbSm4IIxSOOOMUxsY371TJttENWDczstGH5w/CjrfuEc4aHbUYvDTO2Ebq89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 07:27:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:27:40 +0000
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
Subject: RE: [PATCH v2 01/13] iommufd/fault: Add an iommufd_fault_init()
 helper
Thread-Topic: [PATCH v2 01/13] iommufd/fault: Add an iommufd_fault_init()
 helper
Thread-Index: AQHbRdBGeLxaINfdSk2XKhoLewYkS7LgsEXw
Date: Wed, 11 Dec 2024 07:27:40 +0000
Message-ID: <BN9PR11MB5276A65935F9E6339FBA49918C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <3bc49512a42b88130cf447a7ac10acf5c02e056c.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <3bc49512a42b88130cf447a7ac10acf5c02e056c.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6537:EE_
x-ms-office365-filtering-correlation-id: dacc7a16-fbe9-44c3-d81f-08dd19b54bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WQN8e7dlXYNQ7KWHoLut1yMeW1IPtw0Km9DlNnT+eUlAvCjvmQNOTJQol/2a?=
 =?us-ascii?Q?IvWuR8cxzga2MTtcJYqLwIZws2nB8RgY4R0VyczFNhqClzS7yT8GYz7JqtNz?=
 =?us-ascii?Q?UGqohIkNouJlUH/ejaGnlztTtfrBnSbM/YeeVSfYHmPIHUfpmllwDShNdWjN?=
 =?us-ascii?Q?AINC3sJOdNrEDF59iGZYb2aWVMzh2QCawhWXexzbBfklRAqmRyXQ9MhEkgGX?=
 =?us-ascii?Q?+E85cUOhGFsv5g9K7fnuacn+DnwJYClB6DV39Vxkybp8yHFQc3idgT1v7RfW?=
 =?us-ascii?Q?rAbtDECkxgG7EblYJF18AisS1Y1xcETbieT3m6Y1/I7t9oG6Z7MjekiuAtcF?=
 =?us-ascii?Q?r0yqOO6mQ7QL48VKj5ne5DdaEru37yv3MO3iamRxFqJubFBkc2bXQFDGby39?=
 =?us-ascii?Q?QhY9ycCqqYuJjxzT3HGFdtIN1ex7JgjTYDdgYFvVSBKEWYwTHJbw0wN4nt0S?=
 =?us-ascii?Q?hgT9V4ipm/RUcxFF6E4EiWE5OZiGYoeSLwDUH/DzG1w1+PpiFiwJNlC3wmf5?=
 =?us-ascii?Q?Mg6hk/cMTpmLr1leQ+g/F5GOj/DHGafkaDk0Dgsqq2TT3uroe4OqXUeLHb4K?=
 =?us-ascii?Q?Tf8UwrD8TbeFPhWlWJECvus30yF9wPd2yP+/ySvF8ghzW6o0duSU/nMO2ccX?=
 =?us-ascii?Q?yv4mIcgYO5vaHbf7r0K226pfzc/ZbMVtCHK7x2baHymv6r+rzP+kmhEPWRO3?=
 =?us-ascii?Q?ZOXyvdhYF9O5fcEtrJmwG6f2ujB9mOjXKIFCO9gDgggwQgf6/7WngJ/O60iD?=
 =?us-ascii?Q?uxdsDVTc3QomMfOhTJN0O7EV7EdZyOQ+vJztuk2OOG3vYyMR7QWEIM3Rx3an?=
 =?us-ascii?Q?olOY/p+hn0B3Gxu/0pppqczMl3b2LwNDv3wWnsDxnjuYCblJel6cjGCvyjAg?=
 =?us-ascii?Q?WP3ltG4jfrzceH72sJsBus0kriZ0+Q/mbpE/eUDgwYi+q0IgKJ3svO+HcnwN?=
 =?us-ascii?Q?LOowPJ0MAvHHmdzAsrAORoRkW0FU21vAJiCu5Nu23D9qr1KnpzR8qEfSVg2U?=
 =?us-ascii?Q?2BLNxqn4VgGcajE4oSqcckCfUgoBARDHrVy+Wyi3+6LOscbNaLOX3McKM/u2?=
 =?us-ascii?Q?nnR+d8728k7e0G/VgoyfeR2qiNJde+Oam6sMWwi/tLReAzy+nei2FVNROkom?=
 =?us-ascii?Q?H8bXHJP38w1QzTaE9h7BhWzEkxLGO/AwaMEucz/ui62VK4/jVj7iLR6vU2Oa?=
 =?us-ascii?Q?4hUb7hzQWq8OujVwiAlgTgj3ZGnPYowaawPx5VKbvJzvndcyvadp1NnrlnbY?=
 =?us-ascii?Q?i9GG0R9Gh84+VQcEI6vcnPk8OcUCCkKt+TEvuY30V9zP0OB+q2KxLxKjYlba?=
 =?us-ascii?Q?R/kM0E/xRLtqRktk4VJmYChprXJY/w9nMKOJZIALo0n60tyhmxXvQJMuWaBw?=
 =?us-ascii?Q?kLIKeo5OK6PQPemuB///AVn14cUQgTR7609MEcdyptYz1p9Hug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtRCASdD84lL/gcEcd2VX6o+AHyClCZ9c01sDFJLewN7i27r35YZ33JrGNZy?=
 =?us-ascii?Q?2srnVovV3JOCGVhvXPb+usIrBg+5SejaULT94z4MzTGzTdr0d1jESBxjVA6e?=
 =?us-ascii?Q?NfVMr5BT1jn6majHCZkzm9C9VZ+bDnpOpdqgT5+kWJlEfAPdFmZlgtbevfYr?=
 =?us-ascii?Q?hQv+ZEeheSCT9shV85vBsthlgcI0u8CaiCjTEqaKMmvCQ6VWTO39/aXcIBJL?=
 =?us-ascii?Q?Fd8qWHtSsJF3DCCMeHf2TwikB0PuQ2GqyRYb6K53Rh+nDR51yEwRW/A+2bic?=
 =?us-ascii?Q?I1KszGjFDWaRAv1vHX+7kXKgVNzdpeifFbA9vnDSfRMpOZwk9Gd406VpMRTJ?=
 =?us-ascii?Q?vvXK2l3DoV3GMk6dqMirGLRktj394+rYsNqtibb6dQLW5Zn62kSV6h6qiloB?=
 =?us-ascii?Q?vaIOkrudnhIhS+t9kV24xbnNtImrb8v2n2ykWq4FXDSA8fPacqP1pvjjSAc3?=
 =?us-ascii?Q?wHrdhjSe1bM5TPow5cYC1tDIvom7OI0jI8V4do3jFa/aEt1Uxc+7JyUl7hHL?=
 =?us-ascii?Q?GbqyJ9QhaUIH9cuM0Tl7jKPEVcWdaW3QiphWGNr1W2EHzuL8Jj/cD9WqRcbh?=
 =?us-ascii?Q?mR9IKGubwZSL5pOkAbYHXwJENlVwE0mrOAl+vkN+9Nl1Zm/2i7YN6Vt6G7VN?=
 =?us-ascii?Q?gUzQOmP1kb3Yhb7Jnf+K10ypYl4sVPxHMYjLTeV8ff2yHWLH461rvw7wE8oE?=
 =?us-ascii?Q?gEMuN479ZDmnNJge55u/XkoX7gONExYnqvIkKar8xJ8PYN2wf3VK006BOQlB?=
 =?us-ascii?Q?xn9e3ZV66z7vvi5Kkc/7VlZnjObOiRFPaZi27aw/Z/uvADLEFtAceNVv/0by?=
 =?us-ascii?Q?nZVtMMu73dQjfa79luZo1CKzkbFDgPylWWll566qnKS/19WxAZ/OuJx3f2VL?=
 =?us-ascii?Q?SOyjStDONHwxgRndF+BFpnfkGJiE/Ny1KpS97qoJQGEWkeMxvyOpUPxxTJVB?=
 =?us-ascii?Q?MsnfxxFaEDdbdkFVjavZyn4dW/VrEbtWT0IWLxILtXA8Wq8JGpAwhH2RmMsl?=
 =?us-ascii?Q?NmYPhF2oUTtWAa76BYeFGTxQdFKUQM4jjzKlMK5P7Q++oHYBdKVIyCH/tYFt?=
 =?us-ascii?Q?H1iTd1+MSrPwuoMPCE10DpXt7RW3Wje+f8SrYLewG/UgtPG8Yg26oLBKwPQL?=
 =?us-ascii?Q?ovyTeBrXChD/9ybG6NugN2//q/Hsea5JRsis1fGWlEaGgSKKJXbjfpKq345o?=
 =?us-ascii?Q?oxi51SfMA/f5j3mtJbqq036cxpfhcbijgTmTlJaCNGfiPKRvv6UHZZB4Ibp/?=
 =?us-ascii?Q?d5MRlffZfEEVUA/paKGwYbrEjmqC5HiKLHx8Qy5NcXFLFdbgCY3BJyR3zgR0?=
 =?us-ascii?Q?i1VrywUBGSb+95me0bfMfS3lFXe34ncZMxW/HkYg8KJdKjdGbQSMlx3eoI67?=
 =?us-ascii?Q?0DnvrBQ5ZTG9lOpD2vUcqnwKZXT5TUrEmIfoQy1tRlBEPguooebVPjWh/4Fv?=
 =?us-ascii?Q?AaCGDJs42Vyl0DP0LpjcPezly2NsKUuDT8m+5CkzP6R/pwStR/eFuepkaqkb?=
 =?us-ascii?Q?v7BVePZmBWyZ3jVhBIF3MJbHK/FLHOnfq14pJAp+0dyGVo+n6FsdBig11jHp?=
 =?us-ascii?Q?7AD7KSBoVW3BW3UJydI9LV7qANxo+D9LU4zZ/5Iy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dacc7a16-fbe9-44c3-d81f-08dd19b54bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:27:40.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAtu+tHgoJsmMaYAOM/Fx7phPopqYDvG5GlxfGfidClxp/yMN3Z9nt8KxlqVkE6nSbxKyOwllqdKxxF/T5e8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> +static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
> +			      struct iommufd_ctx *ictx)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fault->ictx =3D ictx;

while at it could you move this line behind iommufd_ctx_get(fault->ictx).
usually we want the two together.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

