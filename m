Return-Path: <linux-kselftest+bounces-10221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6478C5F87
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 05:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB93B212E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB0381D9;
	Wed, 15 May 2024 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA4uYOHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71829381B9;
	Wed, 15 May 2024 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745321; cv=fail; b=s81o1jtvQ4QfjlxblBtWsdPdzwXV2aVVPPabWrdRSmtIQ+skjBcL5jAg3jMzUXQsp5kHITXTtd39tpmTpE7bnGq/1dfB3X2qvsjGjc/xU9UcXXv41/aRJCUc7mkWKj+AzuLWSiCOfzBmJEUvGU+IS/pH+pO9I6wzdVhMYijcmG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745321; c=relaxed/simple;
	bh=bkagphKGNXVNC41Y2SK4hZfaOp+l03A1QnGcSKtIRls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bw6ryGce1anLhetFQ+7gh1DNFqn+/zz6lbkRD+1X0VyLzZ/dCjypr6qnDD3FX9qyAS/q5SgrhaKGr4P13KNBJcnqzFUbVrXWH2yYwOopiZuCWHnokup422V/DuyMl4Ka/4FRn1MGwoZok2xNvYre7JPpXxo5+tCSVxY3fRDrvw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA4uYOHa; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715745319; x=1747281319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bkagphKGNXVNC41Y2SK4hZfaOp+l03A1QnGcSKtIRls=;
  b=ZA4uYOHa0upgluxIoELryplkxPem42/kLB/XqiC5unjRhdg9Ws8Pc6EA
   085tC8rCms5CJho6lHL8HzE5TkWLTx0fcMhWRncbZd/7qkx4Uq1/VLlLa
   hEd3Nxr2w9ZVLtsPQsf88snpIO8YLlOkMdlh4kVY75uR1ukC/A1JXtZZc
   hrdenVFwqkZZUwz6+9AClHeIUj6Uo77M5te9C+VGgcJ4koQlWj9XqfKY0
   CIiF/STLCeGRWTgo3yIgZTJbUmdzlkHKje5HGnmWVojl8HNB3kapijGHa
   0DbSsEyk85HEEoAyF+1OGDrkls6tYGDcBk+DCrAZ+n0vHi3AOkpYQuQ2O
   Q==;
X-CSE-ConnectionGUID: FTsw/Gk3RUuXJwaS/3KH8w==
X-CSE-MsgGUID: ly0rXaeVTJaXQz06IvBwPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11901698"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11901698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 20:55:18 -0700
X-CSE-ConnectionGUID: vCUwHWfjRnmNo/CP/dgbtg==
X-CSE-MsgGUID: eIwV+X1QTkmGRae93Cy1tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="30741492"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 20:55:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 20:55:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 20:55:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 20:55:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 20:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezd7qlnQ1igftjX7Hq4NCQ56DqrqA8CoT9mWtyjHIUC2n92wkRWsoyTrMFqISbaM1PLQmtH7XJfUgKTbcW4CC3t1IoM8Y2z1EQUYSAwpmIpoJngopVsGk3EecTyU+zVbd+v2ENMPVfd5KMOKXn/+V2G+M2muwBoKSRx5d2b0Z5UZdhNK4tHr6KpNgSz0BQfHWtgU2jX1lyfhlhDnuO5uf4mbnJ6OBqH/d7ss/ynQfsZA4whq/J8COVSL8wahm/8Ryb4Z9DZx+39UQIMAnwGs4Lx/YkSMbMfnkGbK/J14TWoaQjbc1o0qTo2cGa3rEgdAyLXT3lqKA1yDrm/eReRjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvap0MK9seJBPVx8CdXvUMqIWQJ0UjeCXBf7z2AqtWk=;
 b=H5Dg5Kkkbw368c70nKQeqXdDfbWtMU5RWCOwNVmb2ZPGAtpEtTy5OIRxmgGtHQOmcqwTTXwMH8eX1XveazS+cgqz+cudGGKeF3GGZcxqyqgDO8qUNIk2z309HOFXuGu7Bd74wnZmNTGEgse3ru2+vMntYuOvOuUJzWOzDKdekNBni3LeqE6NVNqtYjj+0puik7ohrRx0TVlOZDKptYKkIqRyM/PdP9yvbn56OD50SGS/QojVN9WPQF+4cgb7MhN3mPQawmRA6k4rSNtlM/FrrEka6UWOW42NXkm2RdEea8GDDO/u8XPXt1ewB7ag3I6gr/FfOruCD3XHgjfdM/VhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 03:55:14 +0000
Received: from SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::c677:a64:79d5:b55b]) by SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::c677:a64:79d5:b55b%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 03:55:14 +0000
Message-ID: <d3e4761e-a44a-400e-9aea-df5322169c87@intel.com>
Date: Tue, 14 May 2024 20:55:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: Pengfei Xu <pengfei.xu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>,
	<shuah@kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, <jithu.joseph@intel.com>,
	<ashok.raj@intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Language: en-US
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To SA1PR11MB8279.namprd11.prod.outlook.com
 (2603:10b6:806:25c::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8279:EE_|CH3PR11MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7462dc-67db-43ce-4b25-08dc7492d3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk01UzhteWNwazBZcm5ubWFWV1lwaDl4NVZWTzBqSUMwZFQrZ1k1ZHZhZ1ht?=
 =?utf-8?B?TFZiaWd3c0o3b0pldS9KNGxnVzk3bjhoeGNPWjdPSC9sa3d6VEdjSGc5MnF0?=
 =?utf-8?B?cnFGWWgyNFZmREFPSkNpY0tjSUprVU15a1NLTFlpTFRZRmlKVVQxRmZ6UzB4?=
 =?utf-8?B?Y1h1dzRXR2VZSFN5aWM5Ui8yQ1JrT3NkTWQyeERhKzVpdkNGNnRBbitPTUZ6?=
 =?utf-8?B?VHlWSkVJMDZURXVTSWpGQUFsaUhubndrWkJyNUpDcmJuYmdDVHFaSkdPdzVU?=
 =?utf-8?B?YWs1dkxRM2V3Q3ZnM3pQb2wvanIxdDdaQmhMNkVxL0JOQlR2SkRjNVlJZTds?=
 =?utf-8?B?TjNSL3kwM3Roa2lBVSt4bno1YkRBQWQ4KzhSVGt3VUVydnUzSGxndnBBU2VN?=
 =?utf-8?B?NWFsYkk5bmF4ck9NZlVra01MWkVxNTl1TFg0SVJEQU1uL0RuTHJhdVZGSDRh?=
 =?utf-8?B?Rzcvc0ZiNytOUmVrVlNDSVVER3RDcWQ4ZFFreXgrMDhpNzdkZERjellvTkd6?=
 =?utf-8?B?N0tsamlUVXBMY0R0Z1IyUUpMbjB3U2Frb2Q1UWFPTjBMakxaVm9YL3lqajNs?=
 =?utf-8?B?bDVDVU85VDJrYmhXa2JLT3p5c0hvZXJGTHFDcGduYkhROFFwRG5KTEtzZXEx?=
 =?utf-8?B?eFo3bW1oTnZNMUpzWHhnNWF4eXJhbG5pb3JmTjhQQlBZRzFrTHRWY2ZNcXJW?=
 =?utf-8?B?cEJOdWZPb2hGK2lHMFRzb3h5Z1djaGxHcVNuV09CWm9vZmkxWkd2MHRPNHVk?=
 =?utf-8?B?L2tQd0RRUVhqZ1NxR1o5bXczV0FlZVIvUUFlY2oxb1FUWmIxNjRjS2VtYWIw?=
 =?utf-8?B?dWRMTXRicGNvSlcyQlRTaGFlTUVvZHkveEx5eGd3TTNTdUdRbzhYSitkR01x?=
 =?utf-8?B?ZmhjcUY1WmFLL0RGY1l3U3djVEZROFE2MXQxRTZYUEUySGFjak1oOUI1Um5V?=
 =?utf-8?B?SGlzb2ZLZlp0bjZvcjArOCtoc2s5SnRMNVVtRFc0UGxhV1lpK05XSGxrWEFL?=
 =?utf-8?B?SEJzZXhGd0xNWG0vVVhBMVRZdFBKK0FxTHNYYytUWGFMdTh6cUFMTzBuQkJF?=
 =?utf-8?B?cVVaQ2hWclppTUFJNkpUN2ZzUVNUcGExYzA2SytHVW0rcVIxUXhIbWxiL0xR?=
 =?utf-8?B?NWg4THl2YjVpTW01bW5pK2tmYi9PcXRJeXU3Ukt3c2pVYWMzVG5qbGtZSGww?=
 =?utf-8?B?RXZuUUwwWU1Ya0ZrRmZSSXNoREI5NHI3am5NSEc0b1VNS2U0M1JkZktOOUo3?=
 =?utf-8?B?TDhNRndQR0pNZnpubDNLUVhJTmYyeGNlTUxJaE5BOWtGWjlWL3BvSzEwVkdt?=
 =?utf-8?B?aUZraGdkV21KdWtGd1J3a2hXSmxmcUhRY2xSVFd3ZTI5OEdCYlV2SWZackgz?=
 =?utf-8?B?aHc3eHlmbHFEL2tnR0tvR04yQm5mdnRqTW5wZDZ0dDRhTjh6SCtvM2Viam1K?=
 =?utf-8?B?QXlpVjhlOUtSQmpyVklucHlKUG9Ga2gveDdTcHR6bCsxbzVkditsU2M5Q0JO?=
 =?utf-8?B?R1U3NXVCVXVSc0VNSC83d2sxUVAwcXVZSUhmalVNRXFMU0JOQzZMWTU2bkRW?=
 =?utf-8?B?Z1pySGNJZFRhZFBSUm5scDNWM3l1K0g3aUcyQkJXcm5sN0FTNnBMek5JRC9W?=
 =?utf-8?Q?U02BB7jlZBiihuIPM6U9YNzegm8iv9aS+8A5PvhJrC1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnd3MjFhRFVndlFrSU55VDBYb1BVMk5HWktDYXJkVkJ1RGFzZExFdVRCWkV2?=
 =?utf-8?B?NnQ0bndPU1BYcm5mQnR6Yk83bXlpR2FMMHc3MWN4RGc4NXppSGh5alhUcjlz?=
 =?utf-8?B?UGVQeVp2RXdsaUREOGZVaVZwWXR2SU1LcHNpZDNWdVo4Y2hLeTlpT05uWnNq?=
 =?utf-8?B?S1RKalRyaFBXRTFMREZHVnZZclhWVENEblgxbm9ZM1N4QXFDcG00dGU3bXVw?=
 =?utf-8?B?UENqa3hzcDJhMU92YmM3VVc2NlJHZVlsaGk0aHg0NmJ5YnRWZ0hHc2pqV2pv?=
 =?utf-8?B?MTVKRWk0dENEVzhjNmgyaktHVFFXSkxaNU9Dd1ZvLzZJaThWZXpQcDhicXEx?=
 =?utf-8?B?ejlybkQzeHNOVXZvajloK1ovVUdWYWc4SVJVRkdiR3hlTGJXUUVrV2c5QW9I?=
 =?utf-8?B?bXFQME04OG5tOHFxeGV4dXJIWHBDRXhDUmdZMjNLN2h5Z2hPOEpkdHBPOTMr?=
 =?utf-8?B?UmFZcis0RmJGQzRlbzlLaXJ0NzhUT09TSmpCbjU4Y0xjQTd4K2p2TG0yWUVr?=
 =?utf-8?B?S2N0VlJxR3BNYjJNRUFENTRuWWhXTmc4ZDJnK3dYVFdJYTRIckg1M25YdFZC?=
 =?utf-8?B?cWd1cjBYNVU2R2tzUDBrVFBlS0lOQlhKa1NvczFqNWYvZmZsQUlMNEcySm1D?=
 =?utf-8?B?R2pBSHZjUUpaRG8yT08wV1RYL1B4ZXFQTEJ3aGJpRlZmSXpWRGh3MWM3Y0hE?=
 =?utf-8?B?Q1FUVlZmeUVsejU0WDEwWlR5dFVRMm8rSExkazNFdDJCbkI1ZHV3VHg1NWFx?=
 =?utf-8?B?blFtT3VLek5pZlBRZDdQaUUzVHlPWXRoRUZ6QUdkZ3BqaUhINDdqa0lib0ky?=
 =?utf-8?B?SXdleFhHQzJ2Z3d6OEU1bWZFRzNtVHE0cXF1dEFtK0lyTURCakNySmQyOXRq?=
 =?utf-8?B?NTg1T2VyME1NS1VTcWVyQytLb01zSFpMaEROYy92V3pQZGpqK1FoOS9hdjB5?=
 =?utf-8?B?b3RWelB1YVBQTFZXTnpaMjdVQm9tRmxTZFlqbmxObnRPMG1neFZVMlA2cEFN?=
 =?utf-8?B?VjRMcmdWRWI2Vk81VldRaGxXZ0pZaysrNWhLUGpjUmxEa25vUVVHVVhDeUpD?=
 =?utf-8?B?QUg2a3BVR0NvS09VMU1KSmFnTnhXZ2g1OGNxUVBCMnppQ0RxbGlQWUxUR1Yz?=
 =?utf-8?B?VG03ZElJemlDQ1h3OFpJeXkvaS9PbGJKV1kzY05GNXZBdkNwbk1sbVdRb2ph?=
 =?utf-8?B?TWxZVjJaM1hXcXJCcFVXalZONXNyK25OSjdVY09YTTNSc2V1WEhOdWN5bEJD?=
 =?utf-8?B?dGJabGNxemd1NlRxQTdvVHJFc0IrY01PeS9Ta3ZPZzM2cEJTbloyNDVnR2l1?=
 =?utf-8?B?bUY2cWYzM3V0MXBnQmM5d1F0MlVibTgrREFpSW9Eb1hYSUlJUWY2WThaN2do?=
 =?utf-8?B?ZS9oVGxxNFIrT2xxZmtRTlpqdXdrUkJPdW5xcUNMbXB6TDNVM0FkekxMZHJ1?=
 =?utf-8?B?RWdWaXo2R3R4eEluMzkxUFRtR1RzdjJ4SnZEQ1U5S09wdGhMc041NldJYzUv?=
 =?utf-8?B?OEN1cnRRRzBtcVV0VlV3NUh2aFhGN1pHdGQrOFgwNDVZN1FmSG84b3hKOE9q?=
 =?utf-8?B?Y2Zpcm1taU5NaWVGYzhzazVUdFNMVERRWDJSS2RFdFM1M0tqRHZ1WVlIc2Iw?=
 =?utf-8?B?VzdtcFNtNjZOT09IZTU1S3BZaEU2RHg2YTZrV0szTTZ1VkpGM2xnelVOejJX?=
 =?utf-8?B?RE1sWTlqbUI5ODNxOTlqeEdBVnRvdFZXcnNnMFpvMU9vN0xWdzRNektqSVRS?=
 =?utf-8?B?ZkRLbDFNSzdZV3FTUHBtdGRZQU9EaUtGNWNOUy9JcW1sTHNFdmpOZWZhdjhv?=
 =?utf-8?B?L1d4dmhpV2RJN1BpN2srRDRRaEpTQUdPZXQzTFkwMFVicHpXR1FPZld2Z0dY?=
 =?utf-8?B?bUVRMnUzRGVWVklTdzlta1VuNmhEYUJxakExY0dXVmZKU1VMblNxbnFPNzdp?=
 =?utf-8?B?L2FtSGxCRzFWSit3bnMxeUgzL1gvTmwvN1V6SElraTVhaGpFemV4SlBTU01I?=
 =?utf-8?B?WUNsMFJ1ZU9Qc3c1WVorQnUwcWVFbVBrUHhySHlHZ2NNK25Cbk9WcU9wMzZR?=
 =?utf-8?B?aUZJRDNNUUZXM09mVDU2WE1iNlZqNTFjR1NSdHBobDVNS2xoQXVCR3BySlJi?=
 =?utf-8?B?NUY4VVBSYzZUMndVcW9qV0VWbkp3Zlozd0N1L2lERkgva092anRQcWU3VTlH?=
 =?utf-8?B?dUwzMW4wUGFyNklGQjJOV3pVN0g4YmYva0dpN2JLTVRkQ1F0ZGMrcDBYT3ZK?=
 =?utf-8?Q?w0Gyf0eD39HZ2gzKY/JRJt5YAeGrr6SYmN9jSsSkiw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7462dc-67db-43ce-4b25-08dc7492d3a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 03:55:14.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RKYJdAkDTu4fjc7XgeticsGHwhnBNgD2MBTS+pmFuXiF7RuBrStQKhscSr3hHZw4XfiIrBH2ScnE8Cwt/FXa5KA3zMvaNgkRRS7DRP7BavfXJ14eN1mhVTFlcn/mn3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
X-OriginatorOrg: intel.com


On 4/29/24 8:31 PM, Pengfei Xu wrote:
> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> test cases:
>   1. Verify that IFS sysfs entries are created after loading the IFS module
>   2. Check if loading an invalid IFS test image fails and loading a valid
>      one succeeds
>   3. Perform IFS scan test on each CPU using all the available image files
>   4. Perform IFS scan with first test image file on a random CPU for 3
>      rounds
>   5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
>   6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
>
> These are not exhaustive, but some minimal test runs to check various
> parts of the driver. Some negative tests are also included.
>
> [1] https://docs.kernel.org/arch/x86/ifs.html

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Pengfei Xu (4):
>   selftests: ifs: verify test interfaces are created by the driver
>   selftests: ifs: verify test image loading functionality
>   selftests: ifs: verify IFS scan test functionality
>   selftests: ifs: verify IFS ARRAY BIST functionality
>
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
>  .../platform/x86/intel/ifs/test_ifs.sh        | 496 ++++++++++++++++++
>  4 files changed, 504 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
>  create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


