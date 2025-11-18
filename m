Return-Path: <linux-kselftest+bounces-45829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF0C6794B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F787361538
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF080286426;
	Tue, 18 Nov 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgMwf+Q4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44F281358;
	Tue, 18 Nov 2025 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763444289; cv=fail; b=Wyeb+Pl1gwhMjclJsIOVaLc7UyfFRPaNPWXpB5XOD2ICd94Gr+ZbwQwF1M5KK2kSGWmXv21QIGiEJaAB4GvEGLQ3qwXzjmwdXJQwgcpEy7yFfyUI0QA8Safzq2V8qWR9jS4WUlV/eT0tfL/Ajt75Nk0XdUJm/42ZxpjvGu8RE0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763444289; c=relaxed/simple;
	bh=0cxLHAEgN0u4oPVlszaNOX8AEVrVvPhF1jsyy3bZ0ZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4GHY/OjGGvFesVITSUuTJ8xkHzIq20pBZ6sXrRBcE3R9/5P7P87e9qdldWjG/KUMsjHvUEgq3cD/sDLWkLnDOh5Ug2xYFN2VXRebcwqkK21leUjb5/BNHaqkC+2iXehYCi4dAwxL8J1C5o3MNfGktKYMV71v4soQdjmS4Z9/qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgMwf+Q4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763444288; x=1794980288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cxLHAEgN0u4oPVlszaNOX8AEVrVvPhF1jsyy3bZ0ZM=;
  b=kgMwf+Q4IVMSeY/b847lqq+j8hbSQjFZ2wtmyr/ojqe/D655/JBOh8w7
   dF4PPHzF8Hcuc5UNpA2xlg3xsJ9zvkkazXgNJXZhj4YH/uIBN3kf0/+XF
   eMgT03CRCzzQ/rjDbjGufBdtLGqqdBgRwTtbuGF5qn8nR0Tn6kTwgMjp+
   13lS9Sz6+f+Yi8jZHQPPF/Hr5OiiUSYUuVYygLihlppPAyhKoGcSokX8P
   1J7ubtMd26uUYYzR31+VXcqJNVG2xgQQPtMOUPOWo1raLwHSCAElbpBCi
   Q0eRRnqSWJBzJi65RB6YzqY5icUbxd3jtnSwKVoOJM5/fAXFYYBR0zUS2
   A==;
X-CSE-ConnectionGUID: knJV8cB8TGitvwB+DTO+kg==
X-CSE-MsgGUID: mAunFniGR6y3gKZ1GseLSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68060653"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="68060653"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:38:06 -0800
X-CSE-ConnectionGUID: PGJplaL0TOKfVoBY4L3wcA==
X-CSE-MsgGUID: RLWNz75ZRNmtR6FRREjPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195580023"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:38:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:38:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 21:38:02 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK4NG39GmS1E1DNVx6hx8GyOzMkhbhw8hbK7sHA+EVrgy+so0u5vmbbUOZSE8wQoBfToNsBLS1NZhN74NoFppw664/IukSTLObe6gcsDuIFakQAq9QxbpXRJv3fPIeMpwslg/ULW87jgpfTtR7vHQ0hC9vKnfnjv8nRrBdvqfPV2pXx72r2Rg+LnF17/mtX4x4EW8kzSRndx2ebFzN+d4r8PmD6asY8N/AcS3/TDgBa5h+nIdNGJBnTc+jovoGSAQAPiVZuxXe8DiZ+/G58zWWUNEQmpy+9Xmq7MSXmK2mi3SX3gSEhLAPs7C/lHfwdB4UgNF6hUCa9fsYK4C8Pa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKlnSLOnstA0JKglKDU0iGuXFgW6O1PX85B2ir/XYyE=;
 b=H6z9GXMgx6xKDdxbQZXMDvcUSgqr/gQr8jwWdMJCV2U3SZ9ACgTLIEubMrQs4QPohOnMkrUuF1ockN3ZRezZQiIf6ZXb7Uw7j/wKGh8HChY2FTSLSzEMjeyuLCDYq906I3vFkZyd0ZdYo6dn7TxE7IHBfUl9eUUaa+5+zBDJizqec4sRZayDOYfWwLAbb7fnj8ANFkCY8yfUKqrKnKa1cGzpbqFJywPwN57ffQkRCnRJYB7N0xqBe9QkTgqBEL7Y98glJ/wGUGHfsEXvihx7hOEAvbb3lU93O1k5eat8bVo4qGgwYY51rEa6vpuyeBYhiNazkxHZGHB1jDbAwfzzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:38:00 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 05:37:59 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, "Tian, Kevin"
	<kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>, Krishnakant Jaju
	<kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Matt Ochs
	<mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 0/9] Initial DMABUF support for iommufd
Thread-Topic: [PATCH 0/9] Initial DMABUF support for iommufd
Thread-Index: AQHcUAaVMMmqzwoPyES8obFVM7+i87Tw+P8AgAYasYCAALoZ4A==
Date: Tue, 18 Nov 2025 05:37:59 +0000
Message-ID: <IA0PR11MB71850B9B3A4D284BA7967445F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <20251113113712.5691cbaf.alex@shazbot.org>
 <20251117155017.GF10864@nvidia.com>
In-Reply-To: <20251117155017.GF10864@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ0PR11MB4783:EE_
x-ms-office365-filtering-correlation-id: 1c9b391d-e6c8-47db-ac8f-08de2664a213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CvkjXG75bexQ9B3jLRpiF8/eC1uo0fGzG4q9TdIc1FEf6NbMGuF+9JfflO?=
 =?iso-8859-1?Q?gdH5hfLziTdORGn2G4BLAcV1oepPR7Bujg/JO8YeQE11SZQnjQyuLC5lwV?=
 =?iso-8859-1?Q?B0eefa8eJ6yF3s4DGExdM2FkZc0kLD87nbGb/KxxtcNSu4zBJsTCsx59WS?=
 =?iso-8859-1?Q?vBWfNCi+4i+/0ga1ufziO+qrTw+I14OfiJ1EikoUU4jw8PH+pKW1SKlqXn?=
 =?iso-8859-1?Q?Se/VfDNXkguC12I1wtIpVojsVp5dpQ17rPL+Gz9cQfyVikyy0nk4XClwP3?=
 =?iso-8859-1?Q?PKehmHW7y1RznVr/95RlAYkd6GAPqS/I+4Afde+yplBhBxZ6ENskXQjEBj?=
 =?iso-8859-1?Q?AY6uY/dWRPNw6lAyhEXbQ8f3I/hTXKmMUCtivrhgbyUTfBJ3J9CQf7pR41?=
 =?iso-8859-1?Q?oWTXwiMI2BvF2CBreHSuG0eDAKxrSBd6HK+t+yS/gchGCIZ2A9o5j4/+t1?=
 =?iso-8859-1?Q?bOi/EcOPc0904WO6FWpd2J9/gG3TWRrSzr4pbpgIzYgTrsW5GKCBzSfjYj?=
 =?iso-8859-1?Q?6BisBqgXP/U3ObVyARWW8vqBwkJ2eaoRMKwHpCOmZAm9jkmpwdtm6sFNrZ?=
 =?iso-8859-1?Q?2W/VDKM1f0yU4mI9ien2AkeqO2CARC7YxPsSd1qaYQMqo6VJVpY/rYORdE?=
 =?iso-8859-1?Q?DXBpeyizXSh49EWp0Vu8lXDVvSpfyOt6wQNyCdHRE0BbDpXenDpkXxdgyp?=
 =?iso-8859-1?Q?d3m/33rekdDQmgVkXb6aXCcPKeogQ922sBX9gbqAS9hwIZvDXJn+139Net?=
 =?iso-8859-1?Q?ihCcsjsJTHL5fkJ3RE5pcPjYxPndEHB2Y01tcuacONIoSYsTs9LwgijK2s?=
 =?iso-8859-1?Q?vBBgEpaMMtjZ2XWouwOKxtF+5ChHoP/Y22AlrP2UzoBIIi2vMRJ9kuMbja?=
 =?iso-8859-1?Q?ibhPh7qEKlck8bR4lH+GMiV4xJD2bIMftV2VFWFpiC9Sla+HCXlyo8KTw5?=
 =?iso-8859-1?Q?ATcs4dPgkR0/bXRbV2TT0tPBwdCRBgtGPp7v11sBoISMfMHkeL7uYSLtf5?=
 =?iso-8859-1?Q?dqbdlWXqVziPMjWvjnfU0AkfU7yQhrHXQBtFDc0DfGK+KKfzGXYZscnba0?=
 =?iso-8859-1?Q?NdD363OM7xmUzKUg0O5+rMM4pBs+0TUEhOTjW0RLzciG5b0uxZ7Tf2AZok?=
 =?iso-8859-1?Q?aDmpCCFElULmWIaCDN23nSkTBnZb13Tdl9GdZomIyXsNhl+nkKu3L7fDay?=
 =?iso-8859-1?Q?oj96MM2oLmNo0BYqq9II2Dr+kj8xkrCVRYUqJFxnyCrgokKF5ibmGS6fIz?=
 =?iso-8859-1?Q?PMSV1Q+n++AjqVBFmaVJPBU/QemFadigsprln9NleOVvpiChptwvV5D2l5?=
 =?iso-8859-1?Q?f7xXKwRUIXgs63+DDLtYMBCDUGyyCol0aaIY2RLvTS5v/Yg1pCizqP7YaY?=
 =?iso-8859-1?Q?zUDbRW4AHwTSxMm2Pydh728hM0hLOmwoYLgJSt66/1cEMzQH7c7b1MLncI?=
 =?iso-8859-1?Q?1jsCb3tNfm0ol+Qct4zL9em46MvsCnm81ta5hIU5H7KwGEEOG5phEgZcXq?=
 =?iso-8859-1?Q?ELA4ZuJqIBLVs5wLLs6mJrX7IN+qvk6GnwEh34OQPG6wxmU4rNQlI4NKuK?=
 =?iso-8859-1?Q?3iO3laTpitE0ZvjMzb8RhKSGuzWa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4xZOIIQcOWNgtGH+CkkKge++a7+K2vcoQXAABR5bmxl0hrjrLerpI1xudx?=
 =?iso-8859-1?Q?zKrgw/gckOUQ+wf8ZCzLtghMUBt8LDSgHtNc9hut26dkRsukVtV6tCMpfk?=
 =?iso-8859-1?Q?Tx/MqBgay88g9hdOe06HmuL5+eov0uc6c5Z+dq9VJj7UliwyJ191SXf4Wy?=
 =?iso-8859-1?Q?VzcQ2UQdO57vefzmxCsErKy2SG7/O5H8plqLGO0HvpIeIh2lLzTGDUAncc?=
 =?iso-8859-1?Q?XSNCSnEMqSHMDIkO9JuKJF83OzmgJJDnBB7GCnPjO2vKE7fUV732ddOh+N?=
 =?iso-8859-1?Q?jfTGBuCSwsPbxp9pHMLsooZrw3Wkj5GGn3BcAtsWqQudfwbk9avXCB9NQ/?=
 =?iso-8859-1?Q?CCc18Wmn/AaiSKrFea8ShDRyFmx6UfSaoUAisc+toptgE/gyXZs/7HhNHQ?=
 =?iso-8859-1?Q?phNLeHwBzSIhc6VGzFRWgoMcuDtduvrp86HWS8AYaqa+iI1fwQ1xMWNuls?=
 =?iso-8859-1?Q?pdleXI+Rnu54IJeHMGLUvBp343p66LTCk86TUaIPLP22RYv4xUtQIYDRmo?=
 =?iso-8859-1?Q?II51kDAWVe8J+zDXjxCsbYcyU+uJx2IKGAO3avW+JVn4sJmPTy89FaD6is?=
 =?iso-8859-1?Q?c539wELTjUh0iLNSSnvQhjvEisqS1OKu+yIJG8yYbCWMzGvQJMyqTeEXTj?=
 =?iso-8859-1?Q?C8+L7tu0Hp+iqLEa1zUOBkYot1vJ8iv8GMIj68aMY+jnRbZuzNEacOgGp7?=
 =?iso-8859-1?Q?R6pUiBmwV6yEUdUIDiL7BYOd/VeMANCC7h9tXEEOHQnsQP7oqZuXi/jhrW?=
 =?iso-8859-1?Q?IvA+tUc+no1q8BiO+sznT5nrADHwXBw4QamtLqXJSBZ4OJN63t3wHAjJsE?=
 =?iso-8859-1?Q?WEpXlABeXo/tpcGhTvs7Ytd7kYTHP2dKqYsmC8O2gtqd1O0MweHBzqxyYt?=
 =?iso-8859-1?Q?DyIdpKxUgfevCHC5tyr0bBGDAQD2ogn6iCjFTfPyMU/GPfK7HHNp1L9BkO?=
 =?iso-8859-1?Q?Mi1Mh2mRmDfQwYjiBL/bFfL1FMHHgyO4EzcVdzeiHeYtixqGoPEQomhYyS?=
 =?iso-8859-1?Q?1892mKalBlekB5j5sVEaZG+gTdnSm9KS7f3PtgvE9qxQ7MQfknf8HeoRuK?=
 =?iso-8859-1?Q?sR+1i3oCUibQWMJnvo29CYYnNBHN/wIQ1ugcO5RXZwVCkdGLfolV1rutRB?=
 =?iso-8859-1?Q?AZPcObd7tGff+Ha6KCB5t2UK8cYN8NCRc6XD0FuZjwjqux9afjTGcSkSNN?=
 =?iso-8859-1?Q?Ouzztc9aDpAyUExO72qQrx1uVDkyWaVAQvepu3vI0QzsgivAaBETZ7ahCL?=
 =?iso-8859-1?Q?mS93gYI5dDlFc8mAfE35aBSNh8OYQHgUk9O8H7pJHDXwSOJsdxBHBHVigS?=
 =?iso-8859-1?Q?MMzikhHoOx9tGeqegPD+kO5YZUI+oD6GEtmNWb+Kf+VNy4PM4LfBMm6Je0?=
 =?iso-8859-1?Q?13Uyg6m6KnSyx7zonMFiELZONoWH9xfH90YoKU+46DFdDyeky3vhkjHNj3?=
 =?iso-8859-1?Q?kWQu4ecAa3gYO13Ts1PU0jBvMb5s7ObTHftMSuHdX3QZGg2TpRGfR2zR9m?=
 =?iso-8859-1?Q?W3kPvhyYoWFrXljivvzaZ7DZcUfXMGQJ+Cp8v9D6+xtcYzUJUJ5ycEnkB3?=
 =?iso-8859-1?Q?Y6cyTnzt0nXxzLxvOhix38MsA9/R5SuJBBsXTtPZeEFElJ5uos6v8oa++g?=
 =?iso-8859-1?Q?RTqjNH5xJzpk87Urq7p5WStJ8WsJX6O6jD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9b391d-e6c8-47db-ac8f-08de2664a213
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 05:37:59.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4Sxkbh5m1rEgdBqom5Lmc70h055+azRsUSbHULn+L5rBQC0juMra3weqtgD1Pi1xzkq1mbcDOn/EV46FrfW871jcHJZ5aN2CcmDjJ/BIbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi Jason,

> Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
>=20
> On Thu, Nov 13, 2025 at 11:37:12AM -0700, Alex Williamson wrote:
> > > The latest series for interconnect negotation to exchange a phys_addr=
 is:
> > >  https://lore.kernel.org/r/20251027044712.1676175-1-
> vivek.kasireddy@intel.com
> >
> > If this is in development, why are we pursuing a vfio specific
> > temporary "private interconnect" here rather than building on that
> > work?  What are the gaps/barriers/timeline?
>=20
> I broadly don't expect to see an agreement on the above for probably
Are you planning to post your SGT mapping type patches soon, so that we
can start discussion on the design?

I went ahead and tested your patches and did not notice any regressions
with my test-cases (after adding some minor fixups). I have also added/test=
ed
support for IOV mapping type based on your design:
https://gitlab.freedesktop.org/Vivek/drm-tip/-/commits/dmabuf_iov_v1

Thanks,
Vivek

> half a year, and I see no reason to hold this up for it. Many people
> are asking for this P2P support to be completed in iommufd.
>=20
> Further, I think the above will be easier to work on when we have this
> merged as an example that can consume it in a different way. Right now
> it is too theoretical, IMHO.
>=20
> > I don't see any uAPI changes here, is there any visibility to userspace
> > whether IOMMUFD supports this feature or is it simply a try and fail
> > approach?
>=20
> So far we haven't done discoverably things beyond try and fail.
>=20
> I'd be happy if the userspace folks doing libvirt or whatever came
> with some requests/patches for discoverability. It is not just this
> feature, but things like nesting and IOMMU driver support and so on.
>=20
> > The latter makes it difficult for management tools to select
> > whether to choose a VM configuration based on IOMMUFD or legacy vfio if
> > p2p DMA is a requirement.  Thanks,
>=20
> In alot of cases it isn't really a choice as you need iommufd to do an
> accelerated vIOMMU.
>=20
> But yes, it would be nice to eventually automatically use iommufd
> whenever possible.
>=20
> Thanks,
> Jason

