Return-Path: <linux-kselftest+bounces-25133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001EA1BD38
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3663AF31B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E394224AE9;
	Fri, 24 Jan 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ1nshBj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EF1DB156;
	Fri, 24 Jan 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749883; cv=fail; b=amZ/2ANIHWXWEF+2FnYuALZMEZH4A48GWqMGNyKj7sCGKV8cl5D5DyqSPG9trjVUCagugcLT+bXKLL9M13N3zie9hedtvsA1UCMPhTr0R4w9mIpcTqAsAlijPJdX9TRzUJ1t1ywDX1MGiPsxPz+vrobMotuvyQ4rSxyb3/HB6mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749883; c=relaxed/simple;
	bh=nX1wTbIRacq1zbjc1dCRtX4Prw6Xo17dr0PLC6kTrac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwYoLFrg86bhExIvcnr24c2IcNQ/lG5wQD4btVJuvB7Sb8h3FfWLEVuM0fEzo9Ca2kFXHziIMh0PMP35UYh9/Tqn663htFE4NLKCp9OgV0+b/1fufUnygSjp77Zx0xTQ7Ak/B7nQ91Ztxd7eOeI+hhUa9jpnwY4dyNElp3Ri9Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ1nshBj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737749881; x=1769285881;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nX1wTbIRacq1zbjc1dCRtX4Prw6Xo17dr0PLC6kTrac=;
  b=ZJ1nshBjrUbNLXP1chrdgzlc6opbC9xhPBALirY199/UU31tKMOUQo13
   NrIgQofTY+Q/MxX1m/Qny9Q9E24ACSLS5tUIkpfFwHTtVX85alxQOEAHy
   G81FrYa9Z1jJkjMzSyLUg9NtaRiAVRJ9HSJFwCFFkqeeHDo3EvEQiNBNk
   G1TZefMpaUxd/85jXOMJMTQ+cq+hy65m/4q7JN0/n7qKzu2YjA9A0MKoA
   5HTG5un8P2vmqJctdljo8WWxS0AC66x30jZKskhp2eDlbl8/ux4+opfgp
   /kp/rAdbBJADiNBNWLqWhS2U9M50nRNDzzUjc8OJ+gELs0MPQFDWCJ6b5
   A==;
X-CSE-ConnectionGUID: QuFMtrCeTAaCrUi8YQKSlQ==
X-CSE-MsgGUID: iJJ64ESwTwqe03hWI0Tu3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41135455"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41135455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 12:18:01 -0800
X-CSE-ConnectionGUID: aaCgmtSzTeSQR9KA1zmLXA==
X-CSE-MsgGUID: DwAUO+IhRY+tYXLionTh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="138736375"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 12:18:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 12:18:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 12:18:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 12:17:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3GeLlw8lHsz2Vo5QYLXr+8tJckJ7VGmme3HTdZ7lNjuX+LuNfk1cNITMYxu3hxB9nFtJIOYZv2qsTLqb4pjMgRLi/jTe1BUJ3+1Lycej3l73xutg6OtmMFoMdDBXjD8yToWkaGplYJ9FIAkOfAw7rBV7ce9x5bMvEz3u2nHyTV/Mo8yKPDNC/2aZhMWFb+ZTkSjlyGR1mu6Br1vKaLVwtRiR+sDl1TXrO2IgNTjAMxa1CvOlmEr+FCKUkzI6FW5J2mxU1DHuDvpbDsMM4wbhreKTUCJFPMz+5fsAIqyXK9+ilf0wxuNdilas14dPOe13kWkYOmYavkbLaPqybRlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n3g3p7CcL4Oha4HRvWYFkqv9Kth0VO8+pKGBFsO0nA=;
 b=n+9g0qxVpjrsNCaTqT8i6yF0Y6IJByGbR3Uni8aNSqka1yu9yRc/ThMrcs487g/i0/LrhgyjdcWYTrmsTflRsGomwaEWvUFYwkn0YT4i3GwmcpE7knFdzzI96ncAYMjVfzg34tEhFPr1/W9sJUal0K2u48PrU6UiJzdZ0VKfmhXcoVh7x4HuPwqnlvGJflfRJdATfL/9ivQy0/xIzmnEE3KJ6pnDeTWReMH3QPeC2aokImOXZL+EXUZnCmx6eI6nvPgD7ocGPm75c/JKBPcBjgbWWAH/RxBE84AFKOQ2rlDrm0v+pzysXYl3tSoH/j870SIWXK7blmVM8xqNPN5TRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 20:17:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:17:27 +0000
Date: Fri, 24 Jan 2025 21:17:22 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kirill@shutemov.name>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo
 flag
Message-ID: <yu3pbemophlzqgd67xongzdflsj2yp722x5brj5ikaiyprxckm@b4vmk4kajxlc>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <63f8fa8ac016f9f294230657e9069a616bce6141.1732728879.git.maciej.wieczor-retman@intel.com>
 <e1aefeca-8f85-48c9-8972-1c23b34aea7b@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1aefeca-8f85-48c9-8972-1c23b34aea7b@intel.com>
X-ClientProxiedBy: DB8PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:10:120::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 65225e83-8855-4e39-699e-08dd3cb41f51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YdMC75DDYsxHCE77geov/rgnVIiA1zbpv8xxlrlV8d10H4S82MhhUVSx41?=
 =?iso-8859-1?Q?ORAnHnGLwfvOG04I5+WY1n43rJsqH9BJ92jjgRsZ1E0vq5aLa2J7u2IGo9?=
 =?iso-8859-1?Q?WubffS635Do4R7d/fspfP/0bax9CGqAK8ckex9+nw0qNahNQ8XVTTNcJr5?=
 =?iso-8859-1?Q?2InYLh5K0CipY7+4+U7a+SLUQO1IzBBN44sbHKWpIKASl8YDvXRDs/DpbE?=
 =?iso-8859-1?Q?X4X3gKTOn7Vq08RPciFHB2TA1sB90T0U7T6SrQq8mUDVf5u02vvhZdBFLa?=
 =?iso-8859-1?Q?0+CNtbyp3WbQHlr+o4hQutB/VcrWs+1vnVquK3C7cpKyHYou2CqJBIY0SN?=
 =?iso-8859-1?Q?4U+2DomUU3CP0HFt539QCrFoqgt5IyUGW1TrFyAJWLwOrO8cQ9tl0BnPS9?=
 =?iso-8859-1?Q?MTkVz7a6POllc1lK4CAd/fbrFvqUJGY2IPW6yG0WYXBVweoyyA26lsO2nu?=
 =?iso-8859-1?Q?hGTpzAcOGYKz/woVybw6yOwkQDxIWmIKMOPEwDV1OgXRUHLYU/FZx+8YLm?=
 =?iso-8859-1?Q?yjg41z5rNqJVdc5P14tK0p8pJCKX8W/blT1a0KJgbuDGPDf5pOsSORS6UN?=
 =?iso-8859-1?Q?/jnnP74y62grQHc7ZF2g/HWC/CtjcK/2g8wrySKASSzxH2yvG/axRv5ZA3?=
 =?iso-8859-1?Q?4Z8VqCdZnyZIFqvBD2w5b8CNC4yojhyRSUOPJz03axzCwLcr2945E7C1Rh?=
 =?iso-8859-1?Q?YUO/jd5J2VEX95eZfnDLR1kC9MoafDqRXbT69JQG60tvEyGJb9/zfVuptM?=
 =?iso-8859-1?Q?u7Ci2CZ8GUF05r7o1A/dwgqFc9G+gLSn+9t9b1tyVKDGH2jz7coZwqoP/7?=
 =?iso-8859-1?Q?8AraZLP/9L4Fp3W1S7gk9RVmoBEDXDkbJwXBSeDByqM2/AQQ98oNfiKf7e?=
 =?iso-8859-1?Q?Sp8HrkDWXfmqCvjzTYLi2b9V90JPh8UlKYppw3bSGk1IaU3HIjpd5vocz5?=
 =?iso-8859-1?Q?fEFqA7Fbajew+ITkzmuFS1DyX/zOGrtSvU9Alx9CBNENOARObtcvmNuPLH?=
 =?iso-8859-1?Q?DJrAVNyFsVp22YFOc5lMb+fr2bRIVyC/Pc5R/iph+Sw7/WAVqNrpn1ThGQ?=
 =?iso-8859-1?Q?7HbbjgOpjqfSEZuSxj7kPNQjTKlVSlErOazhgPcSAXw2lijYCVf0Upeb8W?=
 =?iso-8859-1?Q?KeNpQYk45iG5OVOzP3JtWqOfp+/rq6F8Q2Sf+qVPIRXn5hw85uRxfyK8aA?=
 =?iso-8859-1?Q?OTxpDycn+IZm2Dn89zJTIIlLdGJdrH0LpooMV7x9M57n/A/KxJCFTkJ9gQ?=
 =?iso-8859-1?Q?sMRzIw14YoLJmD+2TNDjwbrRd77votSsORHSa2v4weJ+qx8IgQcad8Suq+?=
 =?iso-8859-1?Q?fTcLbjkXQUKjoRfPxvIhfe4nDrCukxPetz4uJ6di3Vr0nrz9fgY8t0LxH2?=
 =?iso-8859-1?Q?5CGQ0XoT2hg/i2H5mc6IgcMy0Rvuzq5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wZ9H0ZXV8cZhdJ97F8kg0DOGwlETLi2bCP76wHpwzo1YjO7xlS0YJaeus1?=
 =?iso-8859-1?Q?d8+v1X1eSE7ltWuSkgz6OWu9yllbg9ouITVjLlrRr8WnS153bsuO0dY3Gk?=
 =?iso-8859-1?Q?Mkn9hBpDk2WoxdOCG1f4Z2MQ0dk83tmwwjJ8GN+1NlyjKM3DpyR8VMyXJD?=
 =?iso-8859-1?Q?6rzxFt0PR94vzxcLnIUY7q4vnc17mmqx4J1S3NkH7ZVMiZh4l0QCATMe8Q?=
 =?iso-8859-1?Q?qvNzSXeioEW7Xf2z8zGhCwUu5UFI/2HF/kalVf/vojooWcB6reSHaqb0St?=
 =?iso-8859-1?Q?/FPHd6a0nmjQfeqlpThQCeFsyzeTJ8I3leLwupbBrM+orrtnKn5+3nZOeE?=
 =?iso-8859-1?Q?y0YKOFVHQB1wMKPhOJ2s5ANOHrURe0RphDyxB1br3Zm42enXtC73zFa5X9?=
 =?iso-8859-1?Q?E4KNV2DLgpLaVWKJHIYIJDvreHmGIBG5hFxOIx+xw0pSWy2q9OR5VxWQwp?=
 =?iso-8859-1?Q?aL3dX0XwJfosOyU7kMSH16+RjH1cKOQg9EDq1n8ghPKNuAWwJg2+qzMmdZ?=
 =?iso-8859-1?Q?q072iqqHso4zYutDQCA9XL1NxTHiNqaWKPjagfva8dYe4mKDYk8/9MyBCc?=
 =?iso-8859-1?Q?Igy1MhDh5P+eXw7t2nkg6pLnUh5qDCTZMj3cM9ZjEM8hRvS93EoQbXzJqZ?=
 =?iso-8859-1?Q?BKmKtx7zGwg+dATrO48tJ9W9dPewfGiTjFg3pDfF5+cLwmZF3KANsMTKyS?=
 =?iso-8859-1?Q?qtzzcisHJowrVLg5km5uV/Y9NVbYXWI9yBKV65FsilGedJV3OZDqMShTCc?=
 =?iso-8859-1?Q?n4U8/nNFggCRufZnpf4AuE/qS6YIpd4vjHO7zjq1S/Gp2J0GuMoN3GywF0?=
 =?iso-8859-1?Q?9t+ReX72G84sLKk74o1oYMHGjjb9zevIigYQOBEVNW/cixVRy1GbcVWO7m?=
 =?iso-8859-1?Q?BNp7O0LuRVr0ehN/La1zwUQi4kyHYZbp0gI6vC8T98bQBeGVOw+03Ns7oS?=
 =?iso-8859-1?Q?ivr5vqelAqVqhV/36k27A1/L2OTnta8HErIdz8HqZg1m99E3rPcxe71W28?=
 =?iso-8859-1?Q?opTsjKhVWpMllBkAgLfPEWPog6CxGhoqjnQUDEPkJKbbNIhZpKi9TvGMah?=
 =?iso-8859-1?Q?Yxn40whZ8qZDVo6xzs/HSoD2dLJ3LFjJ05fqntchy3L3PNmkisosAcomRe?=
 =?iso-8859-1?Q?H5v6lJYCvUT5Krq3wVWSymGKJqoCrSKbQZXDF087ZmLYVvllAJbjIohK1M?=
 =?iso-8859-1?Q?8gl4065SllUvpaKDw+ZodAWnDRkU6bEBnhIgqE5g5yNHoYwbQe2AWIHJ/m?=
 =?iso-8859-1?Q?aI8vuGBVtFLzEaIyqCtXeBt67NyWTYfTMUYDm20DO3VJpa7prZtbTWokGR?=
 =?iso-8859-1?Q?d1pwe8ZkZfTUAZ2jmkkKJT46fMBRhqGuU5zh403W7yzMFfnwJopIwR1EXg?=
 =?iso-8859-1?Q?ZEezSu0i8MEzWyiSHKfQLVoF2lJYJNeEnEXwNzv5rcIPhkaEvDNOdNhm8k?=
 =?iso-8859-1?Q?vzLXSzX+Qbne00ciQ9tRsOeLv26EsntqemQK4d++E5mNwoK+CkSXRENdN3?=
 =?iso-8859-1?Q?/dtqC8HDISwiU2HVn/ohMPkO8rBDLrPk/olo2dxoQHPuwP9hZMhAEaPoFY?=
 =?iso-8859-1?Q?1MD0aovPCEMEphF7QmWZ1e5An7GxbImPa+SnbfXY4v+JjV5qPK+kFCSFmn?=
 =?iso-8859-1?Q?siSGOR666EHd6IVs8GfRhAWXXG0e5W+inT9J2FzYvV0M4uO+zdviy5f1ph?=
 =?iso-8859-1?Q?qUtuim2DavkMFMpRseI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65225e83-8855-4e39-699e-08dd3cb41f51
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:17:27.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk0A+aMpSg5Nut1fO0QjPyNy3ZoKA1qgdVtyDgkx1nuZ5aezzd1YAQLfZuPHjvf885JFhSU4DJWuwAYZh/lJx7UMSdjyZXIkvyd+21oGCd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com

On 2025-01-24 at 08:14:41 -0800, Dave Hansen wrote:
>On 11/27/24 09:35, Maciej Wieczor-Retman wrote:
>> -/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
>>  static inline int cpu_has_la57(void)
>>  {
>> -	unsigned int cpuinfo[4];
>> -
>> -	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
>> -
>> -	return (cpuinfo[2] & (1 << 16));
>> +	return !system("grep -wq la57 /proc/cpuinfo");
>>  }
>
>I would rather we find another way.
>
>First, we've documented the behavior a bit in here:
>
>	https://docs.kernel.org/arch/x86/cpuinfo.html
>
>The important part is:
>
>	"The absence of a flag in /proc/cpuinfo by itself means almost
>	nothing to an end user."
>
>Even worse, let's say there's a CPU bug and we say define a bug bit:
>
>	bugs		: spectre_v1 spectre_v2 ... la57_is_broken
>
>How is that grep going to work out? ;)
>
>Could you poke around and see if there is any existing ABI that we can
>use to query LA57 support? Maybe one of the things KVM exports, or some
>TASK_SIZE_MAX comparisons?

Sure, I'll try to find some other way.

My previous tactic was to munmap() a high address and see if it works. Does that
sound okay in case there isn't anything else would indicate la57 to userspace
reliably?

>

-- 
Kind regards
Maciej Wieczór-Retman

