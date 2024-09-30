Return-Path: <linux-kselftest+bounces-18576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBE989B68
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782ECB21232
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7315CD78;
	Mon, 30 Sep 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIq8Evsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880115FA74
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681169; cv=fail; b=re7PJX1c82uxwRJFUJjknMpqbnBSfef2XwgQnbaG86qPc2UiAscbNnqqI66p8pAJ/dnTwRdPURL0oTAYsi7whGzpp6AzOT6oguPBpSUzAppssrpQtLcWPhZIACXxMidmQZI9gaVU0H+mrCp3I99f0BGqAAfcVBXJxipdlMzVd7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681169; c=relaxed/simple;
	bh=wnoTBpxXk0IhPpwFohWCPNdOzqHZ907LtGmR7OxLuFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLkG7bPTd4wkIBJfaVCPdcNXOWTKecA7F+lYlrfZjKpeNHz4AG6/HkZbS5E87eGXgpJIHhSoSHtGBMC1lgWadeiu+6HVacwE7Cu1ie1z50xKz3sNHuqcTvfaDhrIbcNt6GTjYHtPiySe0ABeXd9RQH7Z/ejhTS7Cf3WdIlrPASA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIq8Evsr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727681168; x=1759217168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wnoTBpxXk0IhPpwFohWCPNdOzqHZ907LtGmR7OxLuFA=;
  b=NIq8Evsr0b6vk45txnr7sXSqGC0+BYnJoeIGJdoORRQGBiKX25B3aagG
   8hr4NIa2jUBs5opVxSmp4cZ4socoLGe7l0hdjh2lS6ene52W6/FDRffVL
   3X3Gvlgbskti34+566AAzB6YQ1ql7QATDkeysrsekoSg6kB2JC8WDDncL
   TIiTHLDYPBFXK0kaZOIjgsB2lOALRQuXV5LIcBK5zEkG00n1PtyNXXmbJ
   Bq9m9hV9vCpiClMsR+/G0M1CdSmY3QF05/+u5oMTlvvnymzdVWfCsEZDa
   Sn1Xtae2hrdljML98ykQYBdlJ66s6vh3Hc/Y8bdqIAU/sE6I2+dATbMpk
   w==;
X-CSE-ConnectionGUID: hB6HUnukRiS7Ujl1zbmJFQ==
X-CSE-MsgGUID: zbmPeacPRVeYB0EB3OZZcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26563891"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26563891"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:26:07 -0700
X-CSE-ConnectionGUID: 98GnEhL0Q1+3+ddoKrdA5w==
X-CSE-MsgGUID: dSp5Qk4aQ4WhyuoTrmlPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73077952"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:26:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:26:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:26:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+95yXiJ+piVKCjNvfglp1/jdL8IcriM251UhZ6gHLw364Qgpb9KJd09auNBYYwi5T+dOMIqxjGAU+uMjLyjntz8sQf9EOObVj/ikI+L6f2G+APzZB/XkbxhmKg5pS9e9WE62C7iT0S1IaeExKzx1sbOXXv6dBtRSrlXsI2lslTfCL9XL3hegQdI8p8wRKg2X/oNlfjlkccSjA096hOdVHkJKhjfCw/JADLCkZC2nQsoFGiR4u4k0SgrZMxD8XQ7HhN1KYOfMtFNiujkIA5l+++2YGhyqoyZmT4veXQ4VioIvqdJcNWQgUbg4slZhhmhg09/vAPr/xbZcyIJDYz/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqpb+FUeG96V/cG2CY7pgufLCbJIhNaonc1MHutdFvQ=;
 b=rWaD79u3ikzYUuMSTtMB7+haLxgDnamhfTTU9H6NDocj7f4mEMaqNITga2jeW8fn29PHk5cjd/Dx33JstyP9DcPJTul6kWHnHeOpGCAoHXdJDuwaQDeU3kOAHLxPjQDnLCc3RywAtRl7QmOyozOHRvCp8xnOgyxrgBPH1A+1apWVj7WewboaQDio80gYTIr4nJcmh/8e8b6AkzaxzLqL5IhbC+BJ+LXEZ6OAYqajuuOEP4RWXKP/mGWHtXLf84xs+RZxQaVH1B5S+zybKzLAks5vGaqIZC0nDmBcr0YmtZC7WvI/5xV9DK1S2bnKvicSAa4abzdIV3bT4NMxLd9Efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:26:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:26:03 +0000
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
Subject: RE: [PATCH 3/3] iommu: Add a wrapper for remove_dev_pasid
Thread-Topic: [PATCH 3/3] iommu: Add a wrapper for remove_dev_pasid
Thread-Index: AQHbBRS0xnJyJlLTZ0G1KEcfHCOkP7JwCYbA
Date: Mon, 30 Sep 2024 07:26:03 +0000
Message-ID: <BN9PR11MB52768BA60635FD77D1ACAAE68C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
 <20240912130653.11028-4-yi.l.liu@intel.com>
In-Reply-To: <20240912130653.11028-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 665f30c7-6127-4f80-c8fc-08dce1212450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ebrkFpqQWiU0gr/Ng1w4rLCu58vJUVpj63TXFR+FYmZeBj3TUQn406xJYp0O?=
 =?us-ascii?Q?X/Zo1N3NJ4VWKrVagbs8gI60SJafm862dbZbouyTYOv5noDNfGjRhLdxp5PD?=
 =?us-ascii?Q?kCtKxAT7IFU6uY9CQwcOT4EC66LZEINgbThLaPDyxXFjVDUc43U9nFpGhKWb?=
 =?us-ascii?Q?l896Dd1YeD9NTXNI0icCVwPS60S290o9pF7SKO5YpyCa6cGvRP7XbwZ1yP+r?=
 =?us-ascii?Q?6+xGSCPYGOBQWx6jWB2zr/n4f0QvfX4FwSlxGutuaqvRrV0BeTW97xcItMgv?=
 =?us-ascii?Q?xvItRv7sWi3iqZR2rkarGoQEWiiEnpZdID4i/Hz/t9yG9YymMAhgj9s9jKo0?=
 =?us-ascii?Q?ZUM9GyzPmEwUCutFN6NNaUssNxe/l4LMnURuXplfFkTypUZKtViXgIipLaC4?=
 =?us-ascii?Q?RnTZ8lF4qQW0oYd2dJIYFQUWTIzVMbzaC6ginzxTCqk3sJvK+Ni5im8DVfmi?=
 =?us-ascii?Q?HbuaF6e0Uy1ulyEgHOYMbNIVxlYUVPXiVk+soh7NwnW9bP2LU+72XpRZZcmV?=
 =?us-ascii?Q?ZdZ8VxFDfov62A5y5S3CeM/JNlR+vn++Nzor/9QkNSmJ5OfV3G+DxVGoBweS?=
 =?us-ascii?Q?z7xbHMIRtfFkXGwT2UXqB6daH090qR7+eSOnISthvi6cPpCWlcHjgbW7VJ69?=
 =?us-ascii?Q?HsfUR024yT2CJw77vVvxAQ+dUP1MekMiT+mpBm1Dmty+TmYxBiyuFJc+87Tx?=
 =?us-ascii?Q?BiZuZfhMpUgtymhKueTv/mPx3nPlTCDdjaljkRtb20gqpBfQLBKKSJeLxZQY?=
 =?us-ascii?Q?3IKEBfCKzDyhxpHo9j9/q29FyauTb6CICubOh2mC/MP2GlPNrq5R/2+g4+HZ?=
 =?us-ascii?Q?ygKSOS6iqs4MNL59FmhYEETVhgnCQtNiVjIIMhtmhqm1g0Gbk8fhuEil819v?=
 =?us-ascii?Q?BI6j7DmOIYN4RU6rjyzSJ2pMVgOAKUgsyZUNRSESXGQ0BPuzdQXb/Phq5OCD?=
 =?us-ascii?Q?jr1thJyevKL2acWJbF6nwPglItVbbLVI29C8daZ2Bsp0Mnz/VZBbpxEKjZ+B?=
 =?us-ascii?Q?sckDkfl0kO3qmM7PjWdRV6dkYNt5O7jxr5oCHw6kRuM4pSkt1jBRWaAbVxrB?=
 =?us-ascii?Q?lli6qAKWwBfdWAQDPn+Cvsx9sRc4WK0wJFfdV2U33Fz2q9JOptUqzRXDQ9qi?=
 =?us-ascii?Q?N0KiI2nObmu8SvTbY0QOucHR6wZkXgJak5gLwT2D5htUJ18fvBDGEhnvhDEJ?=
 =?us-ascii?Q?Pkoh0ygnyHDt7yREMMsGoF6DxlDIafJ5yl+ntNRZqFGKQ2aCN5wArmLv0MUH?=
 =?us-ascii?Q?CTXxfnLLuYtouxL7xUHsq4EHZFIQtV74HHZCaCYcqfn9FGQyjhinxhXABdZh?=
 =?us-ascii?Q?rn2deZ+wn4rBsxAueh/Sdc23b/LhLfx0+UcMEAAobhitKjcpVf6kT7gyIDBp?=
 =?us-ascii?Q?fR3Em/pF9So0x0QHLtiNUheQMA5JKPZghpHImDqrGtJMdM3Dng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mARz6Yf6kdEiqRwaxP5nBQOGC/pCqJqC7Dkwch5F3vWRDCunYtw9nSq3RKQS?=
 =?us-ascii?Q?oJ3xhRHXt1ch86T8CiyDI69tQRGSSf1ZVQJEUDWVElTqTRcYQvV7OJktU9bs?=
 =?us-ascii?Q?MqvWfxdjiItAapfaYAJ7hBwaGyAsxzuwT0kqGLMzVcHlO8kgUhXheLkm442R?=
 =?us-ascii?Q?9jBiQY0rT50a3Dg+j8nTwH8TXbsgwEO/lKx3K5zUgbN4DOGQQfzmIgy0pw56?=
 =?us-ascii?Q?4DO3kguq/2dtq9eDANC03bYuNU2MJVeU3lf+ll04lRvl71GWEkUj80hyS+vn?=
 =?us-ascii?Q?4N+ywMJcZYoeyEPfmQGPZoc7fJ2Xg6iaC80415rv0aon/sGr6O3YhlkBIJTD?=
 =?us-ascii?Q?pGQQ+YeCixm55CootJEbCV+eAcw5S7i7BQQ7+KfeOiP0o9e6HIRZCwmdhTMl?=
 =?us-ascii?Q?NJ8ajW+JCX4QOaUlmZBXLv2XAFA6CLnn1lGrLZTi2GHtwaovt+77Atz11e1e?=
 =?us-ascii?Q?np5+XuKGmwoJaopitjhs4MqxreXHoTYGpvD7YfQlUEjmcF7+R483FCpZlBeJ?=
 =?us-ascii?Q?HFefkRr20335H7Ilh//jlmmnPuoBux487ikS4ozr32syXiXK1q3VaoKv58Yg?=
 =?us-ascii?Q?qiqe4HY5a3P7ivN+ho60FpkzhpUbtbEFKKomgksv24x/zvqtnnTiOUwbt/d5?=
 =?us-ascii?Q?0zMUAYiQh1jJGFkK8EHrhJl24LiV8cD5UWiyy/iCh8Cq0W0lhBSLZnnaFmUp?=
 =?us-ascii?Q?ugOUa60QHQMlXLKQOdxu2P+BdZJPilBAS+UbK7q2olefTdaZxLvXE0omAeP8?=
 =?us-ascii?Q?qz7DFJgwT6Kv5NqpJG8P0JJVfsxQrpS7a6bJNoreqdUBFv2rR1VvQG21PLZs?=
 =?us-ascii?Q?dEx8DkOaWNnOrk0dMw3bdgHnSJoOdF8cRZ3OpzMBYaN5+BKbqGpStYQd9IUm?=
 =?us-ascii?Q?WVBQgCGtL3tZeWG38Kfc6Fhuj0as7f2E/Pb3l8IuTFtbKuG/7RVjUGmDhw8e?=
 =?us-ascii?Q?f/u2kdreM+WvpRt4AFJe72qEhriOUPfH7c37ln1czRwzALSj7YeUipcO4Zzp?=
 =?us-ascii?Q?g71eiWb6dmb3FC5S0k8v2BzQLzLupU/wX+CoWOFVtJYb1mVoDu/IHNlUpr9/?=
 =?us-ascii?Q?fByT+GDyb6Dtzu4c1cUbAPS+1abd61eRQAw7xgSW4nmQIIBZOd2MPeeF6k9E?=
 =?us-ascii?Q?Vy+cBgugfD5dPk04J9m58J6XSPj+6pjR0jIwhg1ZRjfL9euYcWA8W7G2B2lg?=
 =?us-ascii?Q?yTB/Fqi5qtaVuSh3a9EFM1cubXwGnGRjqCE3ayuBHEBPD/TRJvXarE0/qeak?=
 =?us-ascii?Q?RceNHl2wzbwHDHubnjUkHmPcCCQHxpWv4J8tB4m9MhUa7wWXAVN43NqbfQ0o?=
 =?us-ascii?Q?RXMo2an+W5ywxQozmIieQRgTDLMV55u5/YkHpXn2xO47zfXssc4b9hHsG/77?=
 =?us-ascii?Q?+oMIU3W6YgiF/MOV80RGRmkGidJU0dMcibgWKOB2+oOz+1Ejkj0MXaJbPYea?=
 =?us-ascii?Q?JYOpXOYLaU5imC9QPMDfwfXp40j7koODSz6YQG56LHJPc/5rxNam3RmWbZol?=
 =?us-ascii?Q?GlOuourncInv0SknLkuvQg7GlQeUQdJ4bzrpa7B9oaScow+iRN+iTQBsysqm?=
 =?us-ascii?Q?r46COfZzqPYWnEqrUfqw5RFAPx6pcthgBJD2qzia?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f30c7-6127-4f80-c8fc-08dce1212450
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:26:03.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vv/mvb+NWpa4e/banGW04N3lHHgF9v6DIjwXuvDtZ/5IV8jK1b+lSxTECZLaZ/t/+wto6te04ruTaVJk7X4SFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:07 PM
>=20
> The iommu drivers are on the way to drop the remove_dev_pasid op by
> extending the blocked_domain to support PASID. However, this cannot be
> done in one shot. So far, the Intel iommu and the ARM SMMUv3 driver have
> supported it, while the AMD iommu driver has not yet. During this
> transition, the IOMMU core needs to support both ways to destroy the
> attachment of device/PASID and domain.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f3f81c04b8fb..b6b44b184004 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3324,6 +3324,28 @@ bool iommu_group_dma_owner_claimed(struct
> iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>=20
> +/*
> + * This is only needed in the transition of dropping remove_dev_pasid op
> + * by adding set_dev_pasid op for the blocked domains.
> + */

let's be specific that it's gated by AMD's support and temporary.

with the order adjusted as Baolu suggested:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

