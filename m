Return-Path: <linux-kselftest+bounces-18581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C689989BCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7272827D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B746444;
	Mon, 30 Sep 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1hpMkvF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4532F29
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682345; cv=fail; b=qE7OfUnIsUqWngyt2E+tEJqX4JfcvSyEAPplwnvf2Gz0O6HXeEpCc45EYdg85WQhVHYBX5ZwonwBj2ZdTx5dIBWPAwVmkI82atbs4NtmMACYI2cMkudYKlF/VXui6L5XHGFjYHVNgOmFplCX93f+S9XXNC2ZrcyX0ZBo8e6faIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682345; c=relaxed/simple;
	bh=jholFczFJ0rXVMV1v2uPgc8ZYKauGkWA7Xm+KA94RU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KaYTdhBdQd3QOcaJu67SbEoMaSBMujXfWeDMWbXD2kpQpic/1HmPxaZSG59XEDUlkh7/NpqVKW3iyvtYsPGgOhE+u+Z9R6idx5thyabRXkiKe5cs8t+qJ+C7V7f1sbJRE0Q6tzK4LUNy9VvNdaXKhDL6UXgC0NzjNN1VwhbDmiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1hpMkvF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727682344; x=1759218344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jholFczFJ0rXVMV1v2uPgc8ZYKauGkWA7Xm+KA94RU0=;
  b=f1hpMkvFrw6497YoF1gIBa0z8UNXYS/SkyzoKtagrozN3vSo4lTPnxu1
   fLguR9EwwfMgXQg7RaDePRziI+PIt/G9fzhxJkXB+/MkUvyKKgYna7Cbj
   Y8N1ZCO3DMptZKIBmOh2Qgp4Zxh3fzYZhpxrCtydfmey5ZT4eyLfKUidm
   C4V+8iqjrTv14HkSmJWgz1uuwru5+ZGWUCoSLl7YCk8PU3bQwXbbm5iVH
   loADt9fuycYDexCMcBUMcImlXMN8RIoV0td6+FbZOQdUJ3U67KyVQkUTZ
   7h5KeRQvheZ9FUYINwGo4lY/f3YdHAvkNb/Jwy3M+VQcuzn6v+Mv4njX2
   Q==;
X-CSE-ConnectionGUID: VkfYZJvGRL+HHUgzjS0u8A==
X-CSE-MsgGUID: AZEY1O/dQLKbEC9sgGQxwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44272865"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44272865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:45:43 -0700
X-CSE-ConnectionGUID: yjWI8NFBSdeI8PqFDdakuw==
X-CSE-MsgGUID: LUb4hGOnQr2eSBbShXwuAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77290361"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:45:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:45:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:45:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5DEeBhOdnaFediPA7qF4yLChhDRfSK8IoYY7QMtsRapx6sgRSthqVlzM6vKHaqIC1qv8Ivac2ezkogu4mQ0A3mphICRY1SuzoK+rBczOnbFKTgaDXbxNJFGUOlN6gRT6rXc4bAqcvrTSKe5DDLQQFILImOL7FX1PU5gA2cSLZeB+GliNB7YBiuS4EaxU+CjbmeIe9IeSmdKa6fA2+dfSwXdvDJbNYT08XbQ4ToKAX/e8nYHy8Jjsz8m76Wzw7kYeLY04GFgXHAePU3FrJqzCwt260pp1RHDuW6nkp4UlngALS4mIiu0BHe8qMVATf8RZ4pKwAnt3fmC2JaHxb+JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jholFczFJ0rXVMV1v2uPgc8ZYKauGkWA7Xm+KA94RU0=;
 b=DZlRq/IE6d+mfpl08pqyMyFsxLG+V60ZNOJfOjOLuj6fMpoRFW9Ao1VWXC7KDdnq9qB8gtEDHRXcb1fROfJOAstOiK3x7EGVmjH4LM6o4aaqaB4z67F1eROXjmupjo/Y03CNfomf6D/HsUAwl02zUY2uj7FicHsehv9zVoPDbUly3pnaNoWH8gxKqB54hgWRxdYrCcd8yFpboL5eGqGOQZBfTsSxrSOzf8UGyUk7zHAaG8hR2alz1+G9bmGcEwJSmvfN1l7LhZGhT3YyG7HUxSWEHkyVqNiGQsSqeYhnT0DXd8JM3KXAewIWIqFgKfh2sx3GMzDHxTppVfGym+25CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.24; Mon, 30 Sep 2024 07:45:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:45:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v4 04/10] iommufd: Always pass iommu_attach_handle to
 iommu core
Thread-Topic: [PATCH v4 04/10] iommufd: Always pass iommu_attach_handle to
 iommu core
Thread-Index: AQHbBRWJWh9lcGj+GUyYYz6hKWFaibJwDwnA
Date: Mon, 30 Sep 2024 07:45:40 +0000
Message-ID: <BN9PR11MB527688239D992F80D77756C38C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-5-yi.l.liu@intel.com>
In-Reply-To: <20240912131255.13305-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: 19f4e026-7976-4fbe-9a5d-08dce123e199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1RA0lElDNLbfVwZynacnXgE+n8kBIZvhXXr5w+bMN92yY6mpeqk83rXvsgP0?=
 =?us-ascii?Q?41G3k2mr5OMQZLo8zAxdUUNiF/JWnWaBxowAhEP1OhelbuyvMqrfm9CwztrO?=
 =?us-ascii?Q?r1wpZZRFBoRaQ+z1ol7FUmhVbaFtPPyNpe005P+15YQCkTWcvfTbU2+IKiQN?=
 =?us-ascii?Q?xQHlrHVG2G/i/NXpOi3sXN43UQaYW934E9qiE8Lp50g6Suux5eMVSRd1Uamk?=
 =?us-ascii?Q?Ye8wzCR7W13usJnf2faXeo30Uu0+0IKwxzRxRczE4dPiCUaKk/CDHFwzra5P?=
 =?us-ascii?Q?o3MXTX7RVQTcXgIRDHlzsoZ/bc4DPCyd5iVRrh8idSsk1Dr8glA16aeEmlu4?=
 =?us-ascii?Q?xB0mfoAPhMFhzGB509BPZ3Td+mXF9PhyBwIx/S5nwTHtVDolvAtRo98J86FK?=
 =?us-ascii?Q?OktGeOPaEe8k1NUZcVxw7hYvktI+S7WF9ywQk2V8k18S0d6fXwMaBxW7kbki?=
 =?us-ascii?Q?JFOZqWqHsw6PGuBxiYbjD/ffP0fbKfHn9W8/vawj+rdUHVypf8zsXKXsuOJ+?=
 =?us-ascii?Q?OfYBr8BXPciSfjkYs19BYyZMUJlkL453Q8QwwhNyvYtS0aR3BJtvY7M5hPlX?=
 =?us-ascii?Q?qtkbP742eVAtjxI4lEd8+lJN3GHOcMExh0ObqYiL606k8ACPX9qChA3S6T5V?=
 =?us-ascii?Q?Ep/KhaaG28Mp1G13gNckDEiJ5Ki27Mp9edPhnqfZaqXgF64R09f1YFZ2t+h6?=
 =?us-ascii?Q?DQ+XfGlJLBRr2GzK6mwNPpxM9pFk327HsPjcPXttNosY/5fK/j3rwPMWCTJs?=
 =?us-ascii?Q?WuldWGHyTarpasde+7RgOhhu0S6Gof2mHldj6iTEzCurjN/sa+JnQcBYF/tF?=
 =?us-ascii?Q?UY0wmu/9h25Pni0RUaRQA5jTPXkg79qbBzP1dswVue1mHJvCbrNWvWNhTiAt?=
 =?us-ascii?Q?gAHXTtt4jY4Q+qxnCKf6rl2gM7Cklx8OuGoKQIXsdyMgM/cSeG4WbNg49xEx?=
 =?us-ascii?Q?NNY5u6MhDBnTWJ8c9jSxif/8bJ0EFb0BkJk+QivLlk/AK4DgoOEbJmzgNlBJ?=
 =?us-ascii?Q?NwRiDZOhnNER2X2p4vC+2eZoCzvpL58OqtspJlUEVl8RC19Cx2FdfGK2X/K9?=
 =?us-ascii?Q?8J7q5pzHW1kbQO9E6uM1syaQ7+ZCfqtTB7OC/87PseM21/kKOAzy6tU5JSXN?=
 =?us-ascii?Q?SaKk06RAvMm8jjwxHNYRpq2XTU8hZi6ZN0AM//10/RdAsQ987EGURSILZMOm?=
 =?us-ascii?Q?e1+CbMRxb9fVT5+xD1AyAwBYJTRjG5pkdl7AKwbZhOFkGVMW9X93w6iLEw/a?=
 =?us-ascii?Q?wRlz1muc7nSrYX1M2VFRjROmi2RNO5mYq5fc986JaXWGtBDYGLapUTqafa7/?=
 =?us-ascii?Q?bl8dJ+3v+jmNOfh9ZGLtNTytOCaImJ/Pg9H/2GhKMc/UydGgGK6nryEU0PYG?=
 =?us-ascii?Q?UHFD7d/A9QSZXkjdZ1ke46fYc3MDV+hxUycnbBmPPjMCnWO6Jw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgvvebgBna+j3VDvKQuONUmrVDfXAArBxLQqsbvXjUBJbyiosYMJQ9cmyUIi?=
 =?us-ascii?Q?AmABKcgP1uyiGw7ftnp4ajeReNRWZn1kBVW8rIUjzcQT3jKXvuQFqmD8IdCN?=
 =?us-ascii?Q?sD8wAmaPD5dnzfqpE3b4v9BzcMHSBd7r2wb0mXQSGB0OGc3LkpyZEG0ZaDkU?=
 =?us-ascii?Q?b29IuntMmLS6q7YKostzCN+g/k69b8qu+7o28EEdz2LRzSl5QrlQYIBnP3yf?=
 =?us-ascii?Q?kgkAjiCyMgaLdJfpf6mFBTqcfhCkKlvSgHYUPhOOB9tbyVnOEv2w5Ey0mbhm?=
 =?us-ascii?Q?ndQ41bpbN3an87+o2/7YxNXZl/x8pqfkbORLCNBABBfwJSNP0SAF1tY9X3X+?=
 =?us-ascii?Q?U/A0/vDGvdszq9PITXUmpb57tr8XWoRDw0AY79NdyLO5829nOPWRS19aToht?=
 =?us-ascii?Q?BHI4CUE4qJEERiYvmD/P1NPnySdJvuRyWvvyoQyE8WXQss9jkAMEiue1OikG?=
 =?us-ascii?Q?YUiUoNsOMaG6cGQeBHhUP8fFs9Gq2cJDR/uysmfd1XBRz+5GxoM170Mr14mQ?=
 =?us-ascii?Q?m1HJ9N+k5s/ADfrUZ7Ibizm1qlp8mpqGjs/G1VLLPLoonIUZaSiP5kY3nycs?=
 =?us-ascii?Q?pORmSJyl3UMm9neflhAWsQOuuCkgcQkWHBzhXdhldNfHyurp0QEFQR7WNvzV?=
 =?us-ascii?Q?5k3gNGGpZLfwB+ggPbTjggKZbpRug78khxD9PEpNeGociXYDlX6wLC3mFprK?=
 =?us-ascii?Q?Nj2mpghICaFXDIYb6zOpP3PjwMm6h3TfPKnVBfT2F26iFegIQ/9QP3QafyfW?=
 =?us-ascii?Q?lvQpZAArYRqCNqqdpKT0MyxI4rzrvCENFZHyrXxN9MqmAAe/jypcboCQZVTO?=
 =?us-ascii?Q?0XRc1WdZ+THLHYj2MoiMRuGFeAA+SvEC84d9bD16SK88wL882ycG7Ldu2E7F?=
 =?us-ascii?Q?XHV28o0H0Ry579wWlXA0x8dLjPkvOlmsyW+QMVrxiBeyp/Bv8j57jh5U6lQF?=
 =?us-ascii?Q?W643wtZg4A9UHF5a35jFZKrYmWk9z9d0AF6iR9gadL53ibPunUnQtzphWrYx?=
 =?us-ascii?Q?qaLfdwrXmVZlTqb4vPQIB8NYHWtVJ3ayrBX3pxz9QhwbskIBZTJnde32nyW4?=
 =?us-ascii?Q?M58tYmPc+TF1Zwhe2WxiBbX/SayFCCfRxDNSqlISsuZ5Wxzv32mZwgZwUfgv?=
 =?us-ascii?Q?BVmVN369cQ6cW0FdDvIVYwz8fX+i9tgfPP2LAIyAuEtQCbcCpRRdfQke0zoJ?=
 =?us-ascii?Q?ovGnrie3//VmwuK4vqjJQUMotQRI92lUpaBsKGgP8odQjhQikD66R7BY4DWu?=
 =?us-ascii?Q?kj/b7JCVvsnRJS3z4wtrLdqG0aaxG8nF45xO4LpegpX0p3/fMRkpsTW+MBdU?=
 =?us-ascii?Q?9mhtOySV/cp6CZ+/S7KnjVqQwq9RlEGg1OYstoHDMlbb6++Kw+h2xhYY7Pj/?=
 =?us-ascii?Q?7FCKxnSxoCUNCS+QfXZsKS6D5CugSqEq5XisvDTnDpiI++o2PWk+aQir9ed+?=
 =?us-ascii?Q?jP7tfijl8NmjscweL5wxyhcLah1C8ckFO1dqI7PK8lqhLfv7qCwhzHhCpw50?=
 =?us-ascii?Q?rA8LCcxsncNUQCWQXOzWvz8RT3KlOeiwmwOf+WKrL+52XnK5nANFn6/FaGKN?=
 =?us-ascii?Q?OC4dTWzgo71XYBFT/QNE3+BmTdUrxsLPjdZ4URg7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f4e026-7976-4fbe-9a5d-08dce123e199
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:45:40.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VokPqMvcrEnUoPnFK3NH6v0GXSvi49hhOzCMvq9r/UUF667DjHZA3v8D5bTpmQ8DuxLavSsA6U/+uzQIW03O/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:13 PM
>=20
> The iommu_attach_handle is optional in the RID attach/replace API and the
> PASID attach APIs. But it is a mandatory argument for the PASID replace A=
PI.
> Without it, the PASID replace path cannot get the old domain. Hence, the
> PASID path (attach/replace) requires the attach handle. As iommufd is the
> major user of the RID attach/replace with iommu_attach_handle, this also
> makes the iommufd always pass the attach handle for the RID path as well.
> This keeps the RID and PASID path much aligned.
>=20

hmm this looks more like a design choice instead of mandatory
requirement, e.g. as Baolu commented you can also pass in the
old domain. though I'm OK with what this patch does...

