Return-Path: <linux-kselftest+bounces-44880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9672C399C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 09:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DEE43505F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979B308F2E;
	Thu,  6 Nov 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQxthHjx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC53081C8;
	Thu,  6 Nov 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418497; cv=fail; b=oPPc16ThdNL3Gauy6YRh4vjwCEPnLh++28HqPkxXqqF7fpGTfwwGaWNfxUmbNyZ9ZThv1+jXCFVrkt31FSFA9llZaMBfgb3XLCmnSJWAN7AXjSozVi7VCUVj+CK8lFOWC/Lpe6oSAvFG7CyRZ4iYZRKN1au3mnnuUIzM1CXFjm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418497; c=relaxed/simple;
	bh=CsHq55rHISM1nc/ZP/PUQYMp+qwZvcgZbgUXqDUDhU4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OZKo73jybJ/2AOvRZRVWqjC8HU7QaVwLedfohe36Yi3wPDDSdyE4YYajTmEgngEqRnjGhP8skU/NVStyJgpDqVhBbv4voF2UC9OO+X1DH7eTwjA2QKkwLsmQMkXrR4Tohikg2z1HcKOQpiJlvNaahbztUsWzsG2XL59A3tDY79k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQxthHjx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762418495; x=1793954495;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=CsHq55rHISM1nc/ZP/PUQYMp+qwZvcgZbgUXqDUDhU4=;
  b=EQxthHjxKKiKsMWHKYT0QEIclxREOzfCEwkJiKKqVIr8T3dLdS6at7Cx
   mcz8KC7LncyuDd25RGrVM9jwquxqYN7hl8gVp4edfMwEZJXo8Qq370tWP
   vfqupBkNj+QnB53D0ALn1nxc5wkAxaauPTB3eXR1EWzEC16hvrA/yn/cz
   /TNglzT9rGwtwjRAbzKoYc09t/1dqJL1YTJ0JrSJgqsJOqTl2AwMkXZr2
   /gaKkaTvhJWHlT8CY4WJVqFlV8A4oUaaFzxPxPC+RLTrC/bm8V13xGUxT
   JTGB/9iLWVo6xFHTVQCl3ca29XJv9stacglmO+ZqVqtqy3fwFlKu8yZ6F
   w==;
X-CSE-ConnectionGUID: vovvF8+8Td29CzLeYExhUQ==
X-CSE-MsgGUID: Pjv52+76SbGNk+m2NjQBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75999678"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75999678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:41:35 -0800
X-CSE-ConnectionGUID: SGU6gwX9Rw25VkhEVmyqNA==
X-CSE-MsgGUID: 7xqvqqXaQZOuGXcEQqE/eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187545020"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:41:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 00:41:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 00:41:34 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 00:41:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGKc1T9TFU2KIP1JiRj8GKDzmHAmRFcZJ6fiRMDhurT1CSyh1Axmop8QKDueJAcZto+h15Ahbl9MouwQ559k24sj0SP2IW6rZR2CpR/h/i9dPc+KQn1j5qS1LfVz/Nh0r0d770PuxWIZkztv3SYg0CitaBazppR//v86DfwdkLL9Cl5FhNuTfusePXaBDCSR50CneQCmL/OoFJHKrRzt63/Ws3rrsDAkwevkQ2ASqRDOP7olUFUzW8DXI5BSzwKPwmfcobyOAFYY0dU0a5EGr4l6VGqHR31kVkQaIHBM+TZomSWjPgyf2WwB7cHnvz2o1WqwrfmdM6n00Ph5iL5qOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MODUgEIL9QYHu1jFzfFf4ip2M6yT0CwEJ5/P/CnJLrM=;
 b=S2s9HEJk0JamlSziWc57a+l8ZEjLmSxy3q42BF+9MF5y7zSp53cK//bEXgIXy2atkt2mp5R2XqEbpp23fj1A57k3rKd+EwXQ9G6NdE75hE5eAq6PSUmX0piLUTfzXMlDcSU44D0VSsWohp1StpQdzIJLOiPeVNcqRxB1SxbA7zLpoLV+2fdjYr07oCSDhByUsnPsdr2db3O/JqagvF2o1+gG76nRmCLgy+2hdCBr+r3GLTyNl+RXjXSuvNhdRpOq4oHicA5iMHY7F1wv9hxgrwy0tyfSF+ZFV7I6oS+eP4biTJG+4MvTodPb3NYoCSJ9oP3IgGU6Ejm5Xjov1Eriyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:41:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 08:41:31 +0000
Date: Thu, 6 Nov 2025 16:41:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <brauner@kernel.org>, <corbet@lwn.net>,
	<graf@amazon.com>, <jgg@ziepe.ca>, <linux-kselftest@vger.kernel.org>,
	<masahiroy@kernel.org>, <ojeda@kernel.org>, <pratyush@kernel.org>,
	<rdunlap@infradead.org>, <rppt@kernel.org>, <tj@kernel.org>,
	<yanjun.zhu@linux.dev>, <oliver.sang@intel.com>
Subject: Re: [PATCH v9 2/9] kho: drop notifiers
Message-ID: <202511061629.e242724-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251101142325.1326536-3-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MA5PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::9) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 436bd3f5-2845-4b50-9eb9-08de1d104855
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u5QPAVKODwtKttwqmxKheiXWi38jUl/k3L35H4pX1FnUSPcqzNj0wWtndhG5?=
 =?us-ascii?Q?GETVj3BK3Bc6MmezyY4L5HhN9JVnGkwNjrhtaAHpv5NNPA49kDViImqiM73H?=
 =?us-ascii?Q?iL2GqkolulssVDsoNl83cV+8vlxzvN9xvNGMVCTkpAaGdJkvmlzgj73Si/fa?=
 =?us-ascii?Q?1dpHNQ9jfiAxWFJtIAzxFJPJO9uWIf6JGqCvyDVz0P7Ht1ZmKos9vye8ujQJ?=
 =?us-ascii?Q?/hzLs3wXHwN21u1FRenXej5CawUvEEW6hsiSyrAy8Ey3JT61gx7D8b7Qndyz?=
 =?us-ascii?Q?tK2c8p7WkxKy3cYbK4ofBetpZsqZs0epdtnQ/RUZo8cKJWkhcEHmfqto6umr?=
 =?us-ascii?Q?MGwSyPDdV6ILkWbnv6hEMZMAmJyi2BbzIu/P9a0q5z6KaVpl2dpjWT8g8sPY?=
 =?us-ascii?Q?33vxnKphFkh8ghLCsGbboiThPWLWey6sYEIvuWXbPOfSqhzKUpp8WfCBTzWd?=
 =?us-ascii?Q?Rw89LYtaqIQzdF1NAfQ+UfZt39fJ1fG2SdmT7SJXFOqtBMo+lT7PM4hIicOq?=
 =?us-ascii?Q?maumo/5tGuC2em+4L5JYKVtq9HY3la0S1h1pBEurT/yOE5vjPx2wxCHL97Bb?=
 =?us-ascii?Q?2Z4IZJANbczIX5CwORERJN+6V88AQtguCNqQBpiIhOud92bADYTRuLOAPhj/?=
 =?us-ascii?Q?MwAI+Fz3ALsgedgFFoY/8UsMx6aUGcqq2zV1SPOSz3R5botiUdtR9l9Zh7CK?=
 =?us-ascii?Q?7W5THAh9ru38V6f5YccFz9oi2qvKEhXoglLUHDdgZFV1RcNef/N5zoQB+CUd?=
 =?us-ascii?Q?kHWz8T9KZXcfyUoE+fKhbgkQ0Y/i7pDIAOf9HzkTbyR1jxFx//BNT+sadkUe?=
 =?us-ascii?Q?Zg2GEfNwhdz+tReD6aHMkjBYhh4VxJpKc1jSo+gRY3k+wSHUYo6mj+wuEQzP?=
 =?us-ascii?Q?pasqhBUZ9kYcoiXMa7alvKdWVVToZGtZmLwyNpX2+UZcQcdru5z320mYhkoH?=
 =?us-ascii?Q?rN6GAmQQeooXUFQ/GG1FHTAyFnNjjQXemS9OuE06bA+Iort5jgskSYShkyPa?=
 =?us-ascii?Q?QfWGzWNm669hOZ0hjMdAOqvMCgy7JauzC9wsE731hYph0GjJcHQNo8u0wmsc?=
 =?us-ascii?Q?WRpVjQgZQndlUTXDx8cpa9nviMTyBYTHSnypj3h7B7L3NM9fQ0BSCxdUnzQv?=
 =?us-ascii?Q?5rUnwV618u18I1+/pL3ICLDy2NiPBE7crWsk6gNhR7oi4rdsIyRpiqJb26KY?=
 =?us-ascii?Q?NNPY+YeZJGmKdcbSR9SMKuOmePZDgtnH/ZYMRQZhOeD9utcyphWjkQt9e+oF?=
 =?us-ascii?Q?Ou47CmQH9CZHfpesFdvj8+9oKMWcykYkxsySVePUrIsRCdiSn58dlh8t++6g?=
 =?us-ascii?Q?2Y4aQMLWH7vj3Myi2/EA8b+yZaCmslsOG7Oy9QKgXrBkn9zkztNQMJmclRwG?=
 =?us-ascii?Q?xk01x1flJPTpyzHuiVl0VUy8pkdgiSiaDBPaH0r9GZ0HslOUa44ZiYN4ABJu?=
 =?us-ascii?Q?xjEzalGtTDw/IMLnitdOd7m07WH/xDAfc5H9hsYP3JpIevFMlFbiSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfZvPqCt7rFLJKTd/Q87O/e52GActGi3yjvnGCLuVXsg9Kgt74JObegmizS8?=
 =?us-ascii?Q?Z4VTR+HHvKgZ/tLXcjnFv4cvNxQtbzgdZ+7ZJWpuuOTR2DOpYZ8NcYcFzyjq?=
 =?us-ascii?Q?ojqcFyxNi4+wowCq9p3Hle4b8qWcgSzYI7SuMFiT90hDW4lzN/aHN75/d78+?=
 =?us-ascii?Q?c/vAvLHwUZOsalvX8yv84xLrBQUNviK29b8i3F1I9vKK1WRbwdzR0Q1iUYZc?=
 =?us-ascii?Q?4D4A+8Vx2WRUCf1ScC9r+a8pYeTj/yg3buVIt+M/rIEFGbzKwiStJvCW5ryH?=
 =?us-ascii?Q?VuD0Nac9vOa9PwYYEOcew0EWdtGWhUZlZ6cG/9OLe1z9GTavhjKNi5Vo9Zj/?=
 =?us-ascii?Q?1sUpD0mUH69FMjPhhsbGtTh34oWfhZiCXzuDbDtdSWEAmpNP0M2aJAcXs5w/?=
 =?us-ascii?Q?Xw73mmOnR5W3O2abk9/YJdcBRUKWtOjDL/kSGBCrllJy7U++MjJWlcgDmpl/?=
 =?us-ascii?Q?6Alg/DuyzHr2QwdX9r3eLPhwQo45AynCNgW4QlLE/KFWZKY//q4fZKXtZue+?=
 =?us-ascii?Q?u2alvYOAjMMSz8eGNZnjjnVJmCVlSQVgShnW5x2QBC3swY3KEdEO8sBzXggb?=
 =?us-ascii?Q?o1/n2s8kkWHBO3xv1+7buKDB1jb5iHhOtQty8qAf2B4lzb1OFUQyB1WSSFi2?=
 =?us-ascii?Q?SuUY34ASUkuOdKiJSG4LhAJxe7DJ62SZgi18jk6c9pk/sQeu1Nz/ti3AONJm?=
 =?us-ascii?Q?0UqavWj1lkJ4XYVU8WQ5ReES2rO4e37eBx+CX7AjoRPhuaPuh1jcrRl1fupe?=
 =?us-ascii?Q?ECT1bVnc+Nst0U3G20isaHin1t6djA2UYtKcdlRL0rkEXgZNkeMlqc1jx6IF?=
 =?us-ascii?Q?h/Dw14ZVXghY5M43Y94bRNyfRpJeQHX9LsKAKa8dc5BohqIbFdulUuj91+qZ?=
 =?us-ascii?Q?Y8zany0YM8nttvI9z2kaHQC3dAf3n/CRRLCN33fjGQ87Cairh0mZrVpnftiC?=
 =?us-ascii?Q?LqaFI1uTD2G+RuIksQ6R9WzaV+LjmRt5F2aO4y1sx4I9DcE5aZxd1HHdV+pd?=
 =?us-ascii?Q?9FIPyMlLkIaj4zAVyDMp/sepGX7C/lJvf1Fvpswwm1B4fiZiDJHUGi3zOJdM?=
 =?us-ascii?Q?bjPcvEyH9kslBQbkLwbRWhqADqtGZVtdVmUiSCg5DdzPt4XbvUmEA1aWNGXC?=
 =?us-ascii?Q?EhrdpG1oJn4w0pkxYJ4RPHqU0B9Jwi8YlutaFBQF2MJWIlwWkSi25iV7U0wH?=
 =?us-ascii?Q?JUJia+IQyKSvxW6fSazh3R/dtmfPzEMkJOgF5ixoHXrI0Q7GyCvMnT0GC2MU?=
 =?us-ascii?Q?JvnIq8vb2DSqdLiEuDUzdArdWn6xw6qqIu6CnQ69oaACuyJGJcmC5APfSui2?=
 =?us-ascii?Q?TF566KGxlsatxbDOdGQ4uzt9/8jXor5Zi8hXsdEzCyWDRifsHrEL7w+o2DqD?=
 =?us-ascii?Q?04VM4vJsh89bIyGWNld85qnIGgxE07kWSOpAPo6RaKJUsQi+Td08qcNMC1kL?=
 =?us-ascii?Q?/tbAzvhQyVwS0AmhLG/H0UdW9CCZD6PsRbsowWyE9fTLWctRNXvOsuWgBzbF?=
 =?us-ascii?Q?Rj0ARfQsrak6U9QTPiEkRNfiI+8hi73H5qcXnP8BEWETMW/EAnoyYrAFSYIk?=
 =?us-ascii?Q?tLwnDcOSfZpgXCfrZXKu1fT9KUq1xtQDK2E1iyxCPBGHP7MB29CRHW7C8DR/?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 436bd3f5-2845-4b50-9eb9-08de1d104855
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:41:31.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyp2A8fJ1RAvYxwwBNpuJKMFGoI1GIu1L1aojJ7IckrGL5ptICTf1THv2tlRVwsNOwaozbQybuyYTf0GM1F7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/kexec_handover.c:#kho_add_subtree" on:

commit: e44a700c561d1e892a8d0829d557e221604a7b93 ("[PATCH v9 2/9] kho: drop notifiers")
url: https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/kho-make-debugfs-interface-optional/20251101-222610
patch link: https://lore.kernel.org/all/20251101142325.1326536-3-pasha.tatashin@soleen.com/
patch subject: [PATCH v9 2/9] kho: drop notifiers

in testcase: boot

config: x86_64-randconfig-001-20251015
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 93e4b3b2e9 | e44a700c56 |
+--------------------------------------------------------+------------+------------+
| WARNING:at_kernel/kexec_handover.c:#kho_add_subtree    | 0          | 8          |
| RIP:kho_add_subtree                                    | 0          | 8          |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com


[   13.620111][    T1] ------------[ cut here ]------------
[   13.620739][    T1] WARNING: CPU: 1 PID: 1 at kernel/kexec_handover.c:704 kho_add_subtree (kernel/kexec_handover.c:704)
[   13.621665][    T1] Modules linked in:
[   13.622090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc3-00211-ge44a700c561d #1 VOLUNTARY
[   13.623073][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   13.624054][    T1] RIP: 0010:kho_add_subtree (kernel/kexec_handover.c:704)
[   13.624596][    T1] Code: c7 38 b4 ac 85 31 ed e8 01 1c 00 00 48 c7 c7 70 5a ca 86 85 c0 89 c3 40 0f 95 c5 31 c9 31 d2 89 ee e8 37 b5 0a 00 85 db 74 02 <0f> 0b b9 01 00 00 00 31 d2 89 ee 48 c7 c7 40 5a ca 86 e8 1c b5 0a
All code
========
   0:	c7 38 b4 ac 85       	xbegin 0xffffffff85acb43d,(bad)
   5:	31 ed                	xor    %ebp,%ebp
   7:	e8 01 1c 00 00       	call   0x1c0d
   c:	48 c7 c7 70 5a ca 86 	mov    $0xffffffff86ca5a70,%rdi
  13:	85 c0                	test   %eax,%eax
  15:	89 c3                	mov    %eax,%ebx
  17:	40 0f 95 c5          	setne  %bpl
  1b:	31 c9                	xor    %ecx,%ecx
  1d:	31 d2                	xor    %edx,%edx
  1f:	89 ee                	mov    %ebp,%esi
  21:	e8 37 b5 0a 00       	call   0xab55d
  26:	85 db                	test   %ebx,%ebx
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b9 01 00 00 00       	mov    $0x1,%ecx
  31:	31 d2                	xor    %edx,%edx
  33:	89 ee                	mov    %ebp,%esi
  35:	48 c7 c7 40 5a ca 86 	mov    $0xffffffff86ca5a40,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	1c b5                	sbb    $0xb5,%al
  3f:	0a                   	.byte 0xa

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b9 01 00 00 00       	mov    $0x1,%ecx
   7:	31 d2                	xor    %edx,%edx
   9:	89 ee                	mov    %ebp,%esi
   b:	48 c7 c7 40 5a ca 86 	mov    $0xffffffff86ca5a40,%rdi
  12:	e8                   	.byte 0xe8
  13:	1c b5                	sbb    $0xb5,%al
  15:	0a                   	.byte 0xa
[   13.626370][    T1] RSP: 0018:ffffc9000001fca0 EFLAGS: 00010286
[   13.626951][    T1] RAX: dffffc0000000000 RBX: 00000000ffffffff RCX: 0000000000000000
[   13.627737][    T1] RDX: 1ffffffff0d94b52 RSI: 0000000000000001 RDI: ffffffff86ca5a90
[   13.628523][    T1] RBP: 0000000000000001 R08: 0000000000000008 R09: fffffbfff0dfac4c
[   13.629330][    T1] R10: 0000000000000000 R11: ffffffff86fd6267 R12: ffff888133ee2000
[   13.630101][    T1] R13: ffffffff85acb340 R14: ffff888117a5f988 R15: dffffc0000000000
[   13.630869][    T1] FS:  0000000000000000(0000) GS:ffff888426ea0000(0000) knlGS:0000000000000000
[   13.631727][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.632370][    T1] CR2: 00007f586df260ac CR3: 00000000054ea000 CR4: 00000000000406f0
[   13.633154][    T1] Call Trace:
[   13.633506][    T1]  <TASK>
[   13.633833][    T1]  kho_test_prepare_fdt+0x145/0x180
[   13.634446][    T1]  ? kho_test_save_data+0x210/0x210
[   13.635097][    T1]  ? csum_partial (lib/checksum.c:123)
[   13.635546][    T1]  kho_test_init (lib/test_kho.c:177 lib/test_kho.c:284)
[   13.636018][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
[   13.636508][    T1]  ? add_device_randomness (drivers/char/random.c:944)
[   13.637485][    T1]  ? mix_pool_bytes (drivers/char/random.c:944)
[   13.637955][    T1]  ? trace_initcall_start (include/trace/events/initcall.h:27 (discriminator 3))
[   13.638498][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
[   13.638989][    T1]  do_one_initcall (init/main.c:1284)
[   13.639477][    T1]  ? trace_initcall_start (init/main.c:1274)
[   13.639998][    T1]  ? parse_one (kernel/params.c:143)
[   13.640455][    T1]  ? kasan_save_track (mm/kasan/common.c:69 (discriminator 1) mm/kasan/common.c:78 (discriminator 1))
[   13.640948][    T1]  ? __kmalloc_noprof (mm/slub.c:5659)
[   13.641465][    T1]  do_initcalls (init/main.c:1344 (discriminator 3) init/main.c:1361 (discriminator 3))
[   13.641924][    T1]  kernel_init_freeable (init/main.c:1595)
[   13.642441][    T1]  ? rest_init (init/main.c:1475)
[   13.642891][    T1]  kernel_init (init/main.c:1485)
[   13.643345][    T1]  ? rest_init (init/main.c:1475)
[   13.643788][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
[   13.644256][    T1]  ? rest_init (init/main.c:1475)
[   13.644703][    T1]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[   13.645213][    T1]  </TASK>
[   13.645540][    T1] irq event stamp: 132025
[   13.645971][    T1] hardirqs last  enabled at (132035): __up_console_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
[   13.646887][    T1] hardirqs last disabled at (132046): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3))
[   13.648253][    T1] softirqs last  enabled at (131286): handle_softirqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discriminator 1))
[   13.649690][    T1] softirqs last disabled at (131281): __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
[   13.651128][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251106/202511061629.e242724-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


