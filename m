Return-Path: <linux-kselftest+bounces-10850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BF98D3DB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE46B2512E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE9181D11;
	Wed, 29 May 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5WDA2Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971C1836DE;
	Wed, 29 May 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004937; cv=fail; b=F/NHaBXZG4uo+dUy4D4k2giYgPbPiYbrPU6+vkGuf91Luhsf9r2yAYfQsD7gyhWudKCZQHlF+r3KtHy9p0xSv5bxVUngJtnAnZvtv3RSZtCLqbyXjP/2/CHGEVJAWKa3RVPvY3tcXvXcgJFEKQiBDxc0Y/mCA8KTmOxW+Hdbwf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004937; c=relaxed/simple;
	bh=FHcOXAz6QsQ3OX3aX79JxzDldzXrOfrEgXtxxiWFxhY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9ehNl4gZI6nSUag0w8/IUScBGPWELdMJYFaQrD4vAdcAwE+CzHI2MLTV2y2QAPTupbLpPbdsfJTFyvJQzfYX2wydcIGyjpXchb0NPIOnY8xNTZHAgrTey+BpQkDondRjPSAGhLfBXadEHqYLin08h819RRJ0BUBwP3JJ/wJK0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5WDA2Sx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004933; x=1748540933;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FHcOXAz6QsQ3OX3aX79JxzDldzXrOfrEgXtxxiWFxhY=;
  b=F5WDA2Sxi1J4XdExZvvAQ0+HAfKyddwE1X+KWEh7PM3UShUIP/0pFQCx
   xynTbbzWtuThGcsJsWNxaRrwkRAk+uW9U4V32bsIJjC+YuGHiMO1RA9pf
   1eozlqHD8bLnUL5ROTm+Quxj82R7Sr2jf8qaYbOeEJW8ZIO1BUsMCdjdp
   pOGFpl7Z4raUrdUjDXXwK7LxTj8JdnI7kr6bIGDSzfQw6rBgrhWJ5m9iI
   FWTRyg27Av3IjWvcL9dNsVlapZe7CtAJUFyQVKWHlP/SC/4+KfY9xg8q0
   dznDLrFNTuudQ/nkAoEZxLdeL/0AgipwrUzqnzijnzGRZugpx6vYdfTx9
   A==;
X-CSE-ConnectionGUID: 08HadQ6+QdGKLRo5hQgjCQ==
X-CSE-MsgGUID: qT7gUdQpTQ6aoJ4Rj46qkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16378460"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16378460"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:48:53 -0700
X-CSE-ConnectionGUID: 4mpbrTmYQOmD/6a9SCVrQw==
X-CSE-MsgGUID: ICOQk779S+yL8U6TwVzjDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66393662"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:48:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:48:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:48:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXzTsQ+EgWctE7LhLk/GhXHt52XzFvtiBiok5iHsSJ86TnHDt+xhmcpSZA4yn5vHDMExbPCrRygMH+bqp43/lBXMxZbHhRLn20yN+/AVjNVs4sKaNY85FcoCVgT2OZGNq9gXGJFfDuy2HtZ7fZe6JvaQpg51rX8r3LLSP0kmXnhnXeoTwI7zuXoGNyM0lgATkeyjo5Uhdx+cHKwlOFI53HxTWyJnue2qWY5vBsiPLLdwGYKDNmSS+KX0igL28VXk7O+x9v94jspStItL3vghnP9JkzPRp5Anq8y+TWyjVOhRnzHTsh3ma/RQxIoIW8fMd+54UKvMa7qb427E7f3xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ALVnBVz2Nsum/Yz3XTl90z11JXd89ae6Ie6IAyIuQo=;
 b=nHx8cAk+ItcJzvJRoeJBi+WUJEg0S+1iCHl/A0UKW2wmrYVim3HTR8dNzy+epWRSKGKZ0h+g2x5yRNemwZ8nkoh04HNAFysY8x9voVlv4S0efjFV3W/+75WeYf1YFRXqW3dNILHqrGuyorGGB5KFjYVwDnket00Zl6lk7XMaaO13aYume/j6Gx9AgGP5PF0ceKlmbXH8i0BQO57JuFwDNveeNLdh6JXU/rGx+PluyIWTdaYA+fy3wd8qvA44GqrGKwY6YP/jmnq683Y/l2/FMz4MasrtF+RWtDGww+5d5B+fD/j+w+nRS728ppnoVoLwRe338Sy1GqsNRsk/FCmI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:48:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:48:48 +0000
Message-ID: <bafcfe0c-e052-426f-be0d-9bcbb4c16a62@intel.com>
Date: Wed, 29 May 2024 10:48:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-14-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d0e134-6068-4205-e6a1-08dc8007983a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVRhRG5ha1Q2M3ZHYWZPWGdpN3lyRkFwRVNmVCs1OGpEMnl2eHpuSXdYdzdr?=
 =?utf-8?B?WVpqRUg4RE5xZUtBNUZHaUYzd2RSRm1iUWJKZWFZL1dEdk1hNHBVdWM1WXVo?=
 =?utf-8?B?NnJvNTcxUUI5NWZVMHllUm9IV1RDb3RLREZXSW9GczBBc0txd1k3WXVYT2xV?=
 =?utf-8?B?Slpic3ZLc3BST2RPQ0tkTGVlOC9IN21Xeng3VE96TEZFWThRZTIxamtpbXdy?=
 =?utf-8?B?azR4SDNuSE1LM2lLdEZmMnVIK0hNRW5jbFQyRVdXaG1FNmFHa3B3WXg3NmtX?=
 =?utf-8?B?d2x0SWx5NENSWjdSTkNjMUR1OXREWkV5blk4aENuRTI2MWd0NDR1cDZPM28w?=
 =?utf-8?B?amh1S1B0U24xRnRiSitqMWFucmlzZmpXZXV5ekZFNDlsTHRsWWtWSjdSS25l?=
 =?utf-8?B?clo1N29tTEZSaWhxbXNUOWJMMUNkOVRJSTllSE9NQlV0TXB5eWR6RkExaXB4?=
 =?utf-8?B?eDRVWitvMmlIQ0JqbWVjcTdkZ0pGQVBrTElnZktRYTFicVVaVXhtQ3gySktt?=
 =?utf-8?B?V09FdXV3cjZ0c2V1NEZITW1teDNLejRZaC9HaHYrdHdWSUsrZW1HOUxhSSth?=
 =?utf-8?B?ZDBCRFkrL29KbEF5dGdKTFFubUlFMDAvc3lGQ056ZG9TQ3dPWUI1MVViaWRR?=
 =?utf-8?B?Z3RVU0JxMjlGTnZQWSszS0ZQWXVPOUxLVnloNWF3MHNTajVrL0QzTk9QSUky?=
 =?utf-8?B?K3d1RHZQMDFVMTFLV1I5MXNnZUsreit4d1Y1aFdBOVRwRDRscWhxUlc5ZHBG?=
 =?utf-8?B?UmJwemVORUpEZ21wYjBYdWFzbm5yUDQyYkNNNkFuQjRreS9hRC9ac1JmOFJx?=
 =?utf-8?B?VktBMDQreGQ3WFdTclRJS1I5TXdBdlRJcC9lL0xoa0o5ejRXRnpVQ1ozR2dF?=
 =?utf-8?B?NjBYYUJnMzVhMXNUVHZwSmUzcWdMcE5FVFhxeTBwaW1jMmZJbmwzNVZGWncy?=
 =?utf-8?B?VUpNeS9qV3NPOVVxVVo2cHlVR0E1WlhFYmZhd0NpU1hGQzEvL3cveUh3Z0Fk?=
 =?utf-8?B?aEsxdDFWWGhVMnI4WDJaNGZTUko5YjhTYUUwMk5FbGlqM0pQQXkrRGdINVkw?=
 =?utf-8?B?T0FFUlJ6WU9WVmRXWDgyMDA3eUNsOGdtM3B3SFZRdmM4eGxCRlBXbGJ4Rlh4?=
 =?utf-8?B?MHBRZlhybGV1R3ZOcndVS09aMHNld3NQTDhNR0FzOWFTK1dQbkxrakNRNVUv?=
 =?utf-8?B?alBYYUpwV1BIbkdsUkM1TnBoeHVTRGcrTW55RHU0TXVpNjcwNld0NXdWbDUv?=
 =?utf-8?B?blJkT3ZQT3NXTE16eURLaGZNT2UxQU9WWEVFd0FjdU1OSitEWkJVbDNhcTF6?=
 =?utf-8?B?SlVNdkd6YzdNU1BnOU1IcnpOc0NycmpqVmZOYVkydWtFZDVTTzZFNEtTd0l3?=
 =?utf-8?B?dWV3UkFPelBTUU5aNDJOU052cjFBMzNGQjd5QWRTelNEVC8yMlZKQyt0eXYw?=
 =?utf-8?B?UEZnaVZhNWgrbWZ6QThWVE1qcWtZd2Y4TFRkVHoxZjBHY2RIcDM5cHE3djY5?=
 =?utf-8?B?VGhRdHR2NDZvUlhibVdmdjUvSDJTNS9CdkcyYXdCNHh0SWNIZ2hWMTFNUUVi?=
 =?utf-8?B?ZHVrWUwzUU5TLzlIMTU2VFRIV2toRkJjYUdPYU9zZXFKckk4UUJYeVcybkJD?=
 =?utf-8?B?OWYwSVltQUFmeWJYV2oyUG1VUEp4TXRmNXBKOUlPMjdvUnNIMElSQ05BWVZE?=
 =?utf-8?B?U3hxU3hqM2tLelBRNGxPdFVYY0o0QUhRRVRCTUJhNnlTTE5reVByVThnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnltcE1GNVVaN2xobEsvcWNLcmtiRWdjSlhKS2F6b3RCTlEvYlBTbVJqV2pW?=
 =?utf-8?B?c3ZoL1doaFNONUlIZG0xcERKd29GMDNBWFdRenlEWTNNdzc4Uld6NVFJSGhk?=
 =?utf-8?B?a2VKRGEwQklJSnZjWWFsNm5nUG01QWdHcW8xbDhKRVZJL1lFRVIwQ1lDM2U0?=
 =?utf-8?B?aUh6Vm1vQ21URXhrRFFZM2JNS2VyV2lPd3dmazZodWxqSENMUitvdmQzMldF?=
 =?utf-8?B?dFJ2NHo0TmpJeXZkK0pRWXRXdEdBY1ZYbDNyZGQxMHhBS1JKZHZORUttK0po?=
 =?utf-8?B?M0JPa3htQmxhdnEyUG13UFFEbWlCWGVWR25BcjBuZmgyQmVURlNyN09zMTlr?=
 =?utf-8?B?TGFaa0FRNmF0VDc5cmlRSFExQ09HcFpYd2w0Vi9wYnpMRUExVzV2S3huUnhJ?=
 =?utf-8?B?REJoUENoTUV6OUtXV09uMXRCaUZDS3Fxdzc2b2o5ZlZ1QlpnOHZmS2o2U1o2?=
 =?utf-8?B?ejl1OG9xeGk3YmJIT1B6djRRQzdMM3lXeE5sb1kzcStUVXJXUERFZ3NRbHJJ?=
 =?utf-8?B?eGxoUmtOUTVzdHlLRG9GOUN0TkIwaVJHclBsZkN3bE9XdENYV1ozWkVIR0gv?=
 =?utf-8?B?NS9XSTdIc3FHSlc2T2dpWGd6NGg2ODZKZ0paNWlFYlNPRXR6VVhnSmdKYVFG?=
 =?utf-8?B?Q2duRWVMOVdTNkc0eGNFN0duNTRQMW96RFM2Z0pDSDMxcXJ0ZTF5UGlPTUsr?=
 =?utf-8?B?cnltREZNY1hPS1Y4SGNCeWlZMDBra3NOcjlKdU9GT21BMGJmbXlhRHlsbnMz?=
 =?utf-8?B?azF0NDFkL3lLR0x3dms3Yzd3Wlc1c0NNYkNmZC9sY1BhZTM2ejZ1d20yN0Zv?=
 =?utf-8?B?dlhCYW5yWlk3N1A3dkRQVzZFb2ZycnZiUEVpTW5ERi8rV3BaTlQ1a3pjL2dM?=
 =?utf-8?B?b3VWV0pldkVvblFpK2pHbTdjeUNJQ2dFM2hKTHRFMmUyalc3cUx5NTVFV1ZH?=
 =?utf-8?B?bDZBdnRIQlRRczd1WTFub2IzbE5ZM09SRDZGV1FaNzlES3Q1dXNoL1JKbFR1?=
 =?utf-8?B?SmRrVHFEcFNOVXBKd3BOVzYyUWw5V0NqWjhpQ1h5aXVJTFgwOFk4RGxGK2Yx?=
 =?utf-8?B?emZDK0JCZGhEaTB1enpDYTdRUFRNSUJYQkRIRXF2MzR1NXRpSnJPL0xJQXM0?=
 =?utf-8?B?cXVuRmYxNXBIb3JZQ3haY1ZNL21OV3M5MDZISU9WbmlGVE10ck1YcDJReXB4?=
 =?utf-8?B?T1hHczlNcWFhVUIxRDZXKzFiSlhtMHVYMEo4YmpTZXZYL0EzVVdleFd3UkY3?=
 =?utf-8?B?Yzg5YTUxRFdHVnU1QjJFVGNoS2Nhd1luMnBBYWtIYkRqcSt2M1A0d2RFcTl3?=
 =?utf-8?B?NWlISUpWR1FMTHUyOGlVUUNDNkhIdnEzaEJHTTI5T3pGMEJRUGZWdmN0c0lC?=
 =?utf-8?B?eldTY25xZkhiWDNUWW9KL2U4VjdDUUI4WFFoQ0U5V29BbVJwZzBJOGRpcU9i?=
 =?utf-8?B?OFBKa2U1UTU4bWV0UHVFblVkRVNRYituRVJ0ZTVJdzRqUWRSV2p6NHRoWm5P?=
 =?utf-8?B?UzNiVHR1aW5NbmlJa2dZemdpNVREVDl2Snd4THNILzJ6WTA0N3hzTXJRdCth?=
 =?utf-8?B?SzIwUVYzQ2I3WklrR1k1MG43YXFUMDJOYzdoYUdPUEppbDZnN2U2WktEUWVU?=
 =?utf-8?B?VEt4bHQ3L2lLeTl0cHVvTnRUSDM2ZE4yeGVBaXZHTjVQaUdTalFDQVlPQVVP?=
 =?utf-8?B?WmVjU1JaZW4zS1g3OVlNZmVQSElValdEUW5wcGdWbEp6ZUd6UG5yV3IvZTVI?=
 =?utf-8?B?Yk44a1c1WmJ4cTdwdjJhV2lvVWtCV294ZmdYMWhaYzVYQnFTSmkxb3NEUjlR?=
 =?utf-8?B?Ykxzc1RSR1BZL2c3QzU0RnF2LzZhcmJsS2FyOExUclJpeHkwQ0x4dzdYRUlZ?=
 =?utf-8?B?UmVnYks4K3E3Y3hhK1FQQXFFVkVrVXhPb2lzaVdZZ3c4MjY5V0FvN21rSjJ1?=
 =?utf-8?B?dXFlb3R6TjRoVkRpbXlBeHpoN0hJeVhrQ1c3OHlPWEtzTk0rNE9EOEM5QWlR?=
 =?utf-8?B?SUp2NE5abEF5MXNESm5EZW8xaWthSmNKTGZMNkcxOXBTUHRxSHlYQ2JkUWVs?=
 =?utf-8?B?a0RsMzdyY0hIbGNlUkVUZU44eTYwcklPU3B6RytIY1JERWpXd1E3QnRDZzlO?=
 =?utf-8?B?cjlWVVlyK1NMZzFtYXcwaEtiUjI3bVA2SUtVd0JhbXEzOHBXWHN2VU9DanFq?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0e134-6068-4205-e6a1-08dc8007983a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:48:48.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3vDvgm49ykouhjsZ/uXfIuJ1ExdjcQh3pJvraBa4y5imdXaJv1kuXKGkn4H2wYyPKZG+5DmEwTLVDPtTgPE4BnCXeJCoSxKTWENUeOed18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> The struct resctrl_val_param has control and monitor groups as char
> arrays but they are not supposed to be mutated within resctrl_val().
> 
> Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> plain const char pointers and adjust the strlen() based checks to
> check NULL instead.
> 
> Convert !grp_name check in create_grp() into internal sanity check by
> returning error if the caller asked to create a group but doesn't
> provide a name for the group. The existing code already abides this by
> only calling create_grp() if mongrp is non-NULL so the error should
> never be returned with the current selftests (ctrlgrp is never NULL).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v3:
> - Removed wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> ---
>   tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
>   tools/testing/selftests/resctrl/resctrlfs.c | 15 +++++----------
>   2 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 5967389038d4..a999fbc13fd3 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -91,8 +91,8 @@ struct resctrl_test {
>    */
>   struct resctrl_val_param {
>   	char		*resctrl_val;
> -	char		ctrlgrp[64];
> -	char		mongrp[64];
> +	const char	*ctrlgrp;
> +	const char	*mongrp;
>   	char		filename[64];
>   	unsigned long	mask;
>   	int		num_of_runs;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index a0e84157eb63..6b4448588666 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -464,13 +464,8 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
>   	struct dirent *ep;
>   	DIR *dp;
>   
> -	/*
> -	 * At this point, we are guaranteed to have resctrl FS mounted and if
> -	 * length of grp_name == 0, it means, user wants to use root con_mon
> -	 * grp, so do nothing
> -	 */
> -	if (strlen(grp_name) == 0)
> -		return 0;
> +	if (!grp_name)
> +		return -1;

As I said during review of v2, this should not be an error. I went back to read
your comments and the argument that this is done for benefit of API is unclear since
the default control group does not have a name, exactly what create_grp() supports
when not returning an error in this case.

Reinette

