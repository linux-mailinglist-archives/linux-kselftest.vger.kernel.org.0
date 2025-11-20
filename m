Return-Path: <linux-kselftest+bounces-46079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3FC72B78
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8F3372D817
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D59A3093DB;
	Thu, 20 Nov 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB9ww5FP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45C2F9C2C;
	Thu, 20 Nov 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625937; cv=fail; b=PMv2lXjNA/s0Ne/eyl9J6OdG1pPcd0ki7AJQfPCUMlopYvv1Kgj0e044VOpsew3rdb+riztSb0nv4ZKcW6WQAUWkeN77GpyqLqnevyqrJJ9M6mGJVmMCOa4YoF+tf6v+qwsyOi6LiFps3tVGxo/tdo4LKk3cA8bhMu6esB8w/vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625937; c=relaxed/simple;
	bh=whoFXzi0hdRX8xP/mZI0D0YMX0jRArYXDGtEEbmZNbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d2abN2oS9T1KYj/bKSM4O7AFtm5qfLcnfGoVwm8C5JqHOPgZyi49Qr6BNIwZH80KHW8cvltlX8Cp3HmQZ2n2WbGdgF+hsFRk2stB/HovF07U/ox+f9lpCOw3EYNU6w646snhZtMooQxsGrXCGsTcKvXqwLe0UCr7etZ6RWaeQvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB9ww5FP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625935; x=1795161935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whoFXzi0hdRX8xP/mZI0D0YMX0jRArYXDGtEEbmZNbg=;
  b=eB9ww5FPQQcqjoFPWEeM1yWc5MXPEvzv0BfS4bR1CASbQIDMCuk5pmxv
   nc77anoK+wqYSKe5rhQEh7xnOBroyt7i5N6HAz4HMBr8aReUnL1aw49Yy
   7Rw1QdJM37WILJ/8K39g42eMSCRolUYZ2wuV+p+xtRnJpYOenWMd45nAM
   vefMsmDfitFMIm53DQkU6Ig2wzTaFOHTCZWFoaJgPQFLThf6gOejN0TGu
   kjv5lfNRhz0qZRMh/C7x8Hn0lHC3G/Lqdj6bSBYzRd+KkHWZt9lbtDLM5
   d/wNuayDdYL3tFJyaOoj+6yB9kb0EkgFQzlb+/NezOc7pxtdYDxUdv2I4
   Q==;
X-CSE-ConnectionGUID: izCrW39ORCSwnv+gam03BA==
X-CSE-MsgGUID: Et1ItPhvRrOLkZx1P1Bt0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69302244"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69302244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:05:35 -0800
X-CSE-ConnectionGUID: lHvDledoSEmjpyVyLePNaw==
X-CSE-MsgGUID: 4vl2owZGTCCizTCa3T1XPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="214663952"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:05:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:05:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 00:05:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae+NbxvCt8iRSqmo1BXuABGegEBg7avsm5wNzuFRMcrCYMKiOcne9j9JUiVYyn3uQ+qx7ZjG/ATbGziodkTAMXVa6VTyB4tqyzJ/wE3vUjtauMfxQ0hNoKl69S+DZuESwXU6onvGMBj4yYtQtOCo8jcbuR0f+J3jc3o7MPzfwuAy6Rxm0qOf28ZPjSulCBjoSVMjHeYsfy/59oGX1TySz4X2EfUa2F0/Seoovc1ZiQ63iZXZteSLoF0IqOaSLcp5aqqLhzrEIr3TSM6epMEyex9lX6FXpHZtZHO6b0p/Z2y7bps+ARufbJkznfkbCKjvawqFogBftjU6ue2DXF5SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whoFXzi0hdRX8xP/mZI0D0YMX0jRArYXDGtEEbmZNbg=;
 b=wXLQio92yQpUR9CC3HIXWIG/BxJhkrfc8uJvZwx6V07XI+dCROokGG9W+jSklT/B2GN49PEYJZExasMMyZJ8UNE5Q54L29laWkPh0wqhdCJcikgKs0yY2FH7VAwLMj9P9ceoSiz9X61bdg9GDgPfWHtYesAqTD8xEIouQ8xY6r+JHad9DRUI7PRgIQ2gGFaSjzX9fOHF8tMbCxFEEoxwVMQBE9QmktGYSzOy4xlqXLO5Puz28yqBdkBXEJgINT6vFm6Z04BUqN7exjWYC+Qpg7Bp2ZuKkLr/RtxKr/uihAPpkCsc8Q4n/Xr1+4XBhutRlB9kmLIqnjIqwxPS9YQOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:05:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 08:05:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 7/9] iommufd: Have iopt_map_file_pages convert the fd to a
 file
Thread-Topic: [PATCH 7/9] iommufd: Have iopt_map_file_pages convert the fd to
 a file
Thread-Index: AQHcUAaTxO37QF3lHECTKAZcq0vQKrT7SLlg
Date: Thu, 20 Nov 2025 08:05:27 +0000
Message-ID: <BN9PR11MB52768520A8F1D216E9D837B08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <7-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <7-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: e325404e-65d1-4176-f8c7-08de280b90f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OPAFEdJ3vGyBlr4ZmEsvnZQMfg/V4PwUgszQLiFe7QULx3mmi9f/GWINQa?=
 =?iso-8859-1?Q?uwBUDzDnvgw5YnZBIyqwpoT/9hlXxEts25GqQTkTLUfKoZ78GuGpxv8ODm?=
 =?iso-8859-1?Q?bjZ57meJ93srF2sjWeSvvl902bLzlyJT+RtxtoQKrr6WCvQuwgvyUobya9?=
 =?iso-8859-1?Q?+BYFbErrQfiWSG+VmsH67noVUEjVAi/5qzGv3TQ9A/bh7hyML4xmo0ji0b?=
 =?iso-8859-1?Q?nR63O4q4HiNKsJXZ8Ug6UrS7Knq2+ALpvlaH8zJNt/IYPRksurqtWW18wB?=
 =?iso-8859-1?Q?LBgSxJPnfun1jOc+tt0CMbs8fsrT2KzsVEOVGQrecDmmT5RJ8eZGtAO2sm?=
 =?iso-8859-1?Q?Hol2UtmTejTIsKXQ78JrakzvmCdc/bfaz2KkFWQM2PR5SfJcQsIlCTrH5D?=
 =?iso-8859-1?Q?vzYxXZQJCBSMVkaYYFcuDYmEx0GP8t3v1aTZwYJ8uoA6vZke8xI+I7jqcP?=
 =?iso-8859-1?Q?iplz9UKknC0Xg1/MvI0Wt7qMwmjUbGB7UqUWNqijWA/JE2qivMBQROsYza?=
 =?iso-8859-1?Q?NN+1WQk9GqqBR7+BAXrlWhdms0dNvIygjSbB0V+r/ECIfZ0LszL/kQolUW?=
 =?iso-8859-1?Q?caEgxdyxr7qK2UXzjl3A/nFdm8Tt3Jn+A6XbogJiOXJb7cK4XOIcLLn9rR?=
 =?iso-8859-1?Q?d/QWiIa0mi1wfcTI7pDgbTlgefxxkM5T50k9I9pAI9PGprXJcFrIPiXbf7?=
 =?iso-8859-1?Q?lWodBuibmJJAWtFIRAKud/35csQ/+SbsrdnXYOgiffbHM6JVx/AFupqf5a?=
 =?iso-8859-1?Q?dxs9mTPba9GH1Rhg10/hSdZKXwaCttuRXbx3Z3ERrguxFuzloOVyQVWhK0?=
 =?iso-8859-1?Q?lKhX4QRZ/i4bYIfkgbgl4t/4XOYXS1Ha33GOtk0mRvmWiZV9wyeWrn8OP4?=
 =?iso-8859-1?Q?3OkVb9jM29MOusLIVvEqGlKrnCdcn/oVSI8ZlVvXiXcnQL1YiB1aDpsylv?=
 =?iso-8859-1?Q?nbZ/vZXf2GV3ANWjr5d7eE4toANNx0oOeYpWqP6wUTYrbrS17dlzifTg7p?=
 =?iso-8859-1?Q?YQcG55+W8olgGHCJ2v3JTX6mOJIN3jUQe4/ZOzbQnpvp+axUrUVA9x5aUN?=
 =?iso-8859-1?Q?ZvwrnTkth/1JCfRVaOhgqHJ9HKcDgSquUAwLNY58ci1mo1tLRmc5YYrjem?=
 =?iso-8859-1?Q?DfvpheBxCMN0nHQoHltBc6gvm2YScVsr1hQ3SIqIli8ndQHR6GkpG87Dlb?=
 =?iso-8859-1?Q?8Gt6VD6B21KFvQxhf0h+pT/mWeZjSV3fspcUfkXwxwR3ySCZNs1EgvFTOF?=
 =?iso-8859-1?Q?tvNP56kIMYnHxOX2ikjX7LDdES/WKyMHUfzTeID4oclYpAg3+7tS/xjbR1?=
 =?iso-8859-1?Q?BEO7t38jtbsW2EnSQWtn/YjBcyPNPNWwGB8R3CwU6vvMroxNruEhdUMwF0?=
 =?iso-8859-1?Q?I3qY8fsqFKFXRHxETq/K9Arg3vh+6VQSgCarsuXcsVWnmMTAGLEoV/eC5j?=
 =?iso-8859-1?Q?jDYX1SsSuE+e6D6VCnfqslTsHXl3ZF9zLpo9bdaPvsMFamjKjI6QSOjK7C?=
 =?iso-8859-1?Q?pqomEPVny4a4OgpZU9HUy+dfRBS+7lYGI3rYFpCsa+Hohj3LINrRzJJhzh?=
 =?iso-8859-1?Q?tbbIM7PN3/KsjzQuCpuWOTT0Cg1r1bGjDZPjAuFPxfMlj/yZrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r1fSpbq/I4vv8cU90Fqi9/pQ35lVQqlbvFuzChpjQcVRB557Q9mBJGksrU?=
 =?iso-8859-1?Q?ePQJi6uDvaJkGXmHVcTCpi+kqFzMWA6egzNpWuXwKsWoBJugzLTw0DpSLW?=
 =?iso-8859-1?Q?Ff15rlF+bzAeANWVyU6vdCMPGOxtIz6MiU/1DZEzSCHKZE3sOq/yhKVRg/?=
 =?iso-8859-1?Q?D13yi+XHcW7Mae/eGuYrmZivo5LiCoFiWNOaf8NH1LQXwwvnSlQjwa+GKa?=
 =?iso-8859-1?Q?uqj/l4lQOJSX7rhQ/+WemfGnvsZ4wsRj5lfvqGLjrE2XYToHNr/7uhhyuH?=
 =?iso-8859-1?Q?X70JJuzqT4tox25+lwMTsKVyhDNC5h1QNyByMpw2uoYaf0/CGl6ZBbiK5J?=
 =?iso-8859-1?Q?v6Vvc+ww3ROJS2uWGMGXfaLjJ1RvgGrnqX58HCkxIUYQUkXYftcaz1zX1i?=
 =?iso-8859-1?Q?dZ1Z/gIhhaOuHP+YvaVauK97tcqmdr5zQeyvf22tRGesMstIgc7RD5AHfy?=
 =?iso-8859-1?Q?IArd0EkNvILugW2aD8yNHnXnSyWHyldGkNyCxJ6R9hMoeO8nd/+b4zWWZ+?=
 =?iso-8859-1?Q?+wFMG6LQ1q+6Tkssy0iAbPHYQq9r1J+5vnRCo61UK+puaImQiqVI1cFTKP?=
 =?iso-8859-1?Q?bkHFTLMTIa/IblUeXC2FV5ZrZ5w42BO67eQec04ol0lLf7Lx/QMs5OzHl9?=
 =?iso-8859-1?Q?RtlYZRwz/UZxwqLqQrtZtzqki4Xd9pqnIP6ZtyBGiHEH1zXkvTWjNuOIsR?=
 =?iso-8859-1?Q?xBLH5YvSbSn5tlqn6vu9UkTIAoW3TLVjeul5WTEgAsc2EH/TSF6sPSdmHv?=
 =?iso-8859-1?Q?PJdXL108tJKHSTKSKjS90bzSW0hY6LswejpK8HiLMZPTrb3+J8tXLKdJFj?=
 =?iso-8859-1?Q?+BLbv9AIyk7+HjS4JxBsJkr8EWzKkwC9+PDGNDTB3kgDFJ8mE8NGsXI4m2?=
 =?iso-8859-1?Q?8PYkeIMSh9Tv6a59snl4xuSKc4q8aa87y7dJLwFYutFZU1xNVABqNzNVfI?=
 =?iso-8859-1?Q?xlaFqJuz7W/b9yvt8Z/wI662USF4pTHL7L0lcRnVGsBxQ5jSYteuk+LWvT?=
 =?iso-8859-1?Q?e8Mitnqk3qgln1Rtpw7u+AZCScQS1B+6e3kV0Y9epUHp8IuzTlRWJ6RWpT?=
 =?iso-8859-1?Q?rcJlUPf1rkg7gr38t8CjuapJNqCxE5U3+SgspriTh93X8A+n79tLHRc8xe?=
 =?iso-8859-1?Q?z1QOhSq1bMMa7Hp5p3wBq5TgK2FtPIs6ylCZ+vG5kgqcI/C1FQShH3fCJd?=
 =?iso-8859-1?Q?9tXmU3q/HzXjJ4jUjrK7ES7ee1CtT6dmc6CDhtZvF2dpjLrXoAOAxOvE96?=
 =?iso-8859-1?Q?TRy9XspoykuuOg5t5DReSkTNct3XqQTFQoBpmarM/CNmXxhZavmxUSsnjV?=
 =?iso-8859-1?Q?SVdR4NizYUtzkFB8QUYugD8xGZjU+MoxUJ+EN6KU2t9UpjeONE3YXKLpEY?=
 =?iso-8859-1?Q?TnI6TslrH0dW+h33PUvyhedEMlnUUGKmBN9g7Xwa90HzTeEaZXG/GppMbo?=
 =?iso-8859-1?Q?QZROj4tQ9dUpzJdFGqCUxllDEbFfA31u6UuWD7qBYLvYkyO7s/6Bx24wYw?=
 =?iso-8859-1?Q?hcTHU8PrGwKAphovNyXiY34UOdsdAruvgImrcFIEBYcxJ6JDnrr3Cg6FtZ?=
 =?iso-8859-1?Q?JBeCocIpCEL9lbZ7EkMbxneTE1Kn6NkXacZG8pUiMtXnFzteOJ0MMdRJqB?=
 =?iso-8859-1?Q?97/2V+di2mOqzGCmv4fH4S/ZIjfTZC7FTR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e325404e-65d1-4176-f8c7-08de280b90f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:05:27.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPh3KPhZi5YmnzGryZel9qA7rM5AoCMLyyjHd57oYM+Ev2qmGZ5AbJa64SXiE0L3Pwva8xhBQzuohH5JYEMwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
>=20
> Since dmabuf only has APIs that work on a int fd and not a struct file *,
> pass the fd deeper into the call chain so we can use the dmabuf APIs as
> is.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

