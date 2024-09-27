Return-Path: <linux-kselftest+bounces-18448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96152987E23
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5711F2246C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0415DBDD;
	Fri, 27 Sep 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmNMXfzl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3347381B1;
	Fri, 27 Sep 2024 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417423; cv=fail; b=i+40wqINFEFD9ODd20pvr9yx5+g3/RTZ2CnL8Mfe5fOhCWAUPtCDio8hyZrf2ZM8j9Nbxg6nLqNhLuKykedAF1fFyQSY/54gZ6+79O0MzfAiQ0F/bAZMmnSY5XwS3PCUSNVFC7lV5Siag857PJGCowas00/uFt0fVkp9doGD+N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417423; c=relaxed/simple;
	bh=ridy9oShnFJNnB3xvIMfP5PR8sMwTp2pKchMPIBxyBE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSF11ImM3BV0xVVHotYr9vR1Brv5TCQG3ye2NDrBzilmhrJXCi3kM4AX01ULXsXU5TjxuGpMNt7THFFwicY89QxgRI/WKYpcxBO1rxcUQzMGlDno+UmE3LhmPgPBAyyzVjcSusB2Y7xwPxIRgP4KyknewygIpb2XzIf6cpC1hqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmNMXfzl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727417422; x=1758953422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ridy9oShnFJNnB3xvIMfP5PR8sMwTp2pKchMPIBxyBE=;
  b=XmNMXfzl4HoUWPe5vP1rP6g8YJtGkaiDiW39s+ZkqKggIW5PVdiv2zvN
   O9dsZQBNGVVNDlZ4FyjmjEl8HjL/qMoRj55SZVZi3YrT4YiuexSFDu0iq
   aYtwLJTOefCizaX9hHh6lTmCwJ4EQyaHHsXqOkALYMPkSppr8coRV0Wtp
   mEfDiOCoJ6jxp44G4qvz1ImXdU6tRbYTe5s+bvtgCjepoQwGAxXdPWHMo
   nCbdUJmGg/TgwnvxXCqLzkqknFkj9x2ZlseTMJ2+n6oR/WpsL4N6/wIbw
   4XvIlgACq9/TSRGx7wGVQAueyV/zhdTDupvfL752G071sjKuKvw3gtM46
   w==;
X-CSE-ConnectionGUID: xwusqBLsRU2wdoqScWzn8g==
X-CSE-MsgGUID: yS+TwIHsT0WePchIEW9rEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37688827"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37688827"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 23:10:21 -0700
X-CSE-ConnectionGUID: g8HUILvDQa+Ml6H18uIbcA==
X-CSE-MsgGUID: QMOPXCOZQKC1GKnLBf/3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72017653"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 23:10:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:10:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:10:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:10:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxoYbDn1qzQqWn/6jG/nf9DDu6cDSFNzjjeARRS7DJ2QKgxQxSSvlEyoUWKZeMOYPxJi1cvRgRtoYvKu6ddYTQo9SQCxJB1HtgmzoyFgzVayl9teXJ5kjBcIEiIvv+iPhoMeVNfoUjI8y1vEQ8yXQxCy90IyeFiIfo+iZDPLh/9F468MAj7Jele1wWGzO3n/j+KNH/cjaXIXhJ+dzWRSh8Or54SPMO/FR5N4iWDOEXx70qVTU+kvJdUqvfMkuOaSeFk8ry7mkCPX9RqtyCvA/cV76A6uAme1Fm6VsMSK3BKgWnSMvso1YtmnVIyFjcMd3tvniiwM4EUHv0WbGyDR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhFrXIEvWXDX2fGDui4+wVWbgWtRs9AXexmzENzCDhs=;
 b=g5nGRa0teo6czQ2XDeJ9OzMRN2CqaJFi9psSb1eNSANLgoWALjqY9u8ElgMRT1C8fh+4jMBF59/YqzbQpaX9617gII4b5yPx/4KLSw4B9bdDdZxhLop25plpc0GsasFZC6YlcKvM3IJ5B56aGBJRTSkcgtxlcpkBJaqydYNbrSQSQISvqnlgfsGRme/6llvQbt5Rx7EuwnJq7NR/EOdKrz2b+yUmA5KvSsZMVGiGt/A26K4Cz0xCMGGiQTOLDYaX8n2XKoYhawy18V07B1o7RyPlFijlm/LK0Rmux5s/3+CZRqTB2U6jk2aZqqgDNtwjcPNwK3Pu6xAoLlhFV9VKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 06:10:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:10:17 +0000
Message-ID: <4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com>
Date: Fri, 27 Sep 2024 14:14:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <05a6b098-8197-4ae6-af80-6dcc16c9f29f@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <05a6b098-8197-4ae6-af80-6dcc16c9f29f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eb2f5d-9c2f-49b4-438e-08dcdebb0ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?and0cSt4TFFaWlN4WS9vV29Selc4MGgrbVVhY04rd3czWGFxYUM3bk1mZ1M1?=
 =?utf-8?B?V2hiV3U0SDFIM0VaTjQvYXZ0YlZ4WksxVGsyTEFJY3ZtSWE4OVZWQm5aTFRK?=
 =?utf-8?B?cTdTUnBZUzZHTU9BczNvdjNvcUEyLzQyRzFvMmVmdThIc3ZuZFh0NGlsUm5O?=
 =?utf-8?B?Wm1QbHJQQ1pkQVVjTGl1RU1wSDFtYWFRRmw5VkI1Z1l6S2trRkdydUxnemlD?=
 =?utf-8?B?b3JzcmFMQTRteHY4NkdKUjY5ZCtiRzhmcDJHa012emwxaHV5SmRpS3hzSXFr?=
 =?utf-8?B?QUVWR2ZvbXFZczhBVE9sa00rUU54SVRFNGtsQzUxQkR0ZldwS0dkM2N1L2cw?=
 =?utf-8?B?T3RObWkvNWxIK3FJenE0L0gyRDBaT0JuZUladW00K0JEKzhHTjhEcnBQcmxJ?=
 =?utf-8?B?OTRST2QvdjFBcklqbUpiN0RRbllkWnpRdTd3bTZQaVFGZndMT3I5RzVENlVV?=
 =?utf-8?B?UVllUlgzemNNdU44VHc4b2oxeGRDQ1B6V3RVTkJaT0ZiNUxLNXBpVHhCWlJk?=
 =?utf-8?B?TnkxOWRZTXg2ZS8yaUM1VGRmMnhzc2NMQmNYQWtLY25vVGxVdzhQZ2VzTVpM?=
 =?utf-8?B?QnowVHVwZ2NRdjdFZllxSUFVaWNmZ1B2NC9iZmtmVUgwMTVmb1hvekJvK1ZG?=
 =?utf-8?B?M2hybnBlaGQ0QnhVMWtTWjJhQ0krNjFZWW5qQlBLYnhFajJaZ201MHNUQ0Ny?=
 =?utf-8?B?VS9tc0hXamhYWjFFaWlLUGZRbzh0T2UxaHRkYTdMYzRKbzhtYk50bmIrVm5Y?=
 =?utf-8?B?QnJJV3NFbnJqRU1aVTl0Tm94Z0FFV21vQ0xxanpiN2t4SHFlcktCU2dLbnYy?=
 =?utf-8?B?WXZRcDlnc00yemQxT0wvUDNwQ1ZSY3A0VE1SM3pWSnlHQUw1QW0wZ3M0QTZr?=
 =?utf-8?B?bTZneUc5d0lsNHpsTTZnN083L0JPZ1NnOHlzUS9ndGJJQXppRGVrcnpXbmlm?=
 =?utf-8?B?Qit4RHVXQ1ora21MZ0YrYTFBMHNWY1lEandWcFBFZk1nTzVPMzdZZWVpb0Y4?=
 =?utf-8?B?a01BaWlJOHFlU29OVUpocmdqeEx4TmplaURqRWNibVR2WERYb0QrMjNlcmUw?=
 =?utf-8?B?S3JBRTNnUWcyUFd3dHpHWHRPbk12a2hNOFo1NUlVczYrc0sxS3VUeVJmZEVC?=
 =?utf-8?B?eDdiWFFxRzBTT1g0akdqMlJHS211dm5waHlEQUt0NlNYOHNNTlFSQ29MWElp?=
 =?utf-8?B?K3lZSitmU3hENy9WRGVCN2ZYSGZiVkt3cFRKNWQ5ai9TMU1YZUp5SzAvRmlq?=
 =?utf-8?B?eHBaWWZaVkwwbzdxMmpEU0RkNERadTJwSlRic3h0MVBjNEp0RjQ0blIzQWpO?=
 =?utf-8?B?Y3NwTVpaUlR1MHROblVBM0U3M2wyMFQ5c2ZGanIwZ2xYYTVvVEY1TkVOQUhK?=
 =?utf-8?B?U1ZFL1Q0RmcrS1FhZmp4eVhMZ0tLQ2w4UEVNVUJqZEhybUtpWjF1YmpDNUlU?=
 =?utf-8?B?VUdKdUtHSHBCZjdSMzRkaE1yL29zLzE3V2tURFdHaGRmT1VkYkJjbHZvVTRs?=
 =?utf-8?B?eE1PNmV4eS9FM3ZOTndiWW1mZUN6OW1zc1JrUHFwS0R5YmJEV1ZxWW9XSjA0?=
 =?utf-8?B?RlhGVEdwY3VaelRDZnpZdk9MNFVQUFFuanlKR0RYQ0hnb1BtWjhDZmRrR0tx?=
 =?utf-8?B?bXZLbDRoTndGRFlCcDBRUEMyMGJDYUtHS0FseUxqWlZIRXFuaDV0MGd6SUR0?=
 =?utf-8?B?SnVGSGt0S1V5aGNMWlpPYlRmSVNjSXBhekFJZFpHbHNmQnVrYlFieUt6NXp4?=
 =?utf-8?B?YVg4MXgzdFBBRGJMMlkzU0MvejJKRnI2Sm8vUFlGRjV2NnUzcWpmM0NVOTc1?=
 =?utf-8?Q?IOzJ3N84NfFTcXV6EdKBetiMS74ZZAE88ABTg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blUyWjJGYy90ZDJhbUM4S09BQTQ1YkRvZ01IN3NJdEJNek9rZG0rN1I1WFZz?=
 =?utf-8?B?K0FQZk5OMUZOSUpLWDdPaEM1L3JkaEJFdVNZWldiWEw0MlZMK3gxeDZsUXZt?=
 =?utf-8?B?ZHZMaXlNa0Q5NGtpQXlDZTZhWkhsUmNlZThvOGxtU0R0N3VycXFMSXJxQTda?=
 =?utf-8?B?TCtCWFlaZVNCZERYU3AvY3JQRTYvd280am5weVIzbG0yS3huUGY5b3J4dWF0?=
 =?utf-8?B?eW0wZVRGREg0OFg4bHQwWFBsUWgwOHIwRlpVa1JhaXpSVGdjM0treDlQOWhT?=
 =?utf-8?B?VlR5QVdZN21rMWNoQ2RISG5zRWpkTU41NzJoUUxUbXNybk1mL1k4bEdaQ09U?=
 =?utf-8?B?WEJyam5VNjJDNnVKQUw4Zk12c0hrTU5WRS9tVG9XRGg5cXVMNWZRSWdNZ1BZ?=
 =?utf-8?B?Q3pjekpzYXVGc010Z3c5dmQwYlEzK29wLzRhUHh6MW1xREdjUGYyRjhlRnVt?=
 =?utf-8?B?Z2psUURTR0VzNmNJTEs5SmFQdzZWYk9IaFE4KzU5bWxIa2hSeGdNQllsWFZn?=
 =?utf-8?B?aXdQU0t4eHozc1hDZnlNVklGbnlIYXRkTGUyb2FGbHplSGR5SlowQXJ0MXhQ?=
 =?utf-8?B?c01RTU91U2VqZVBSdEVPS0ExTENiSnIybTZ2WEFYL0kza0NlVlhUcFdOR3FT?=
 =?utf-8?B?TytFUlZnQ012b2VjSDhuWmNjN0dHMWNiZGNSeFFLRnhXZHZMNi8rb09lcVBJ?=
 =?utf-8?B?U2hOMTVUeC81S1J5RGI1TjdnRUU5cTNXVzFIUVZyc0dzY0pRZDhNc29ic3gz?=
 =?utf-8?B?VGJNbUpmN2U0UUlHamtHcG9oMFJma1g1RWREaXhkTk9WTHVobFZKLzBPNEVh?=
 =?utf-8?B?WWpsc2dFU1dKWlQzS0RXTk1mVXRIM1lONVVsVjNTaGNMRStVaU9vUUE0T1VW?=
 =?utf-8?B?bzJEdVQrR3VLT0FxNVF4WER4VnNWZDArWG8wbDQ0LzdvemRwK2x6L0VaT0VT?=
 =?utf-8?B?R3JLWFFaRWw3VjFOcFhOVWdjVXdoYUVPcmp5T0Y3UWM1OFNaeFBtejVQUXVK?=
 =?utf-8?B?S3h6VXNWcUZ2VzFra3BiK3RqUyttRmJWd3EvdjFqTlhMUGswcFdEc2FXbnZZ?=
 =?utf-8?B?VTJtNHQvQlc2d0gzZTZITVhRQzQ3TjlOaUVyUFcvMHZ3TmJhNmI4b1VmaHEz?=
 =?utf-8?B?SUt2WGdHd2VZMmxMRk15Zmczc0hCSDRxWXZGNkVzaFo4a2RLZmhpdTYrTGIv?=
 =?utf-8?B?cTNzajcrVzhEbTB2eTFWVUt5SlRIaTMxTWFJdkdra1hlbFBKd0h0YzNCOXJj?=
 =?utf-8?B?U2pURHpTYlhsWjJjcjRiSXBpa2dBQ2F4NlUvNVBxZWx2OWdqZ0NyMEVaOUFs?=
 =?utf-8?B?TXpOMHNYQ0J0bXBVbWtUaitWV0hLVGpmb252Zlh3eW9WeEZYeWl1QUJPQmN5?=
 =?utf-8?B?R0JQWEUvd0tobTd6Q256RWc3Qm1hc3ZoNTlqd2srYlIzOW5HS3EwOEU3NGpv?=
 =?utf-8?B?WDMrcGJnczlXQTdPeDN5bHRkempSME4wYTR0MjRDczZuM2VVNTIvTWRXM3k5?=
 =?utf-8?B?c1J4ejlRbi9aUE55MG9ucXNKVE4zRUVpUW0wc1RMeEJIbzZJOTlERnBNT21k?=
 =?utf-8?B?TE0ybHMydlNRSEc1Vy9ZejV4blhOV1NXT0JKNXVUaDFDTUpOV25WL0h2VVdw?=
 =?utf-8?B?MFJwNSt6OWtZb1VvUHVJYzk4SUV5aGxpOXNFS1FHZnhzYVdXNDRsMEM4SzYx?=
 =?utf-8?B?WmtkTFZHU3J1RE1ob1hlMjNkSGVHejUvS3VvM2FCbC9EdHZkdkhVSWNpS0FV?=
 =?utf-8?B?NE1jZkhaREs4MHRuUEtsYkRQQWEybnNLWGk5WnYyOGloQkpDZHBHeFZyU2sz?=
 =?utf-8?B?OS9NTjNzUmZhUXVmQU5BVXlWQ0hreWVVcU8vZUNZanNBcE1RaTNkSStSQkNx?=
 =?utf-8?B?MlFCRDR5cXJjZnMzb2FkTU85Y1NWaXFMUlA2MGdwa0dkM3dSM2pVc3p4VzJu?=
 =?utf-8?B?c1M0NjZWNFY1cWZVNnMzc0l4eWdwN3ptbG91YzNKVFJMUjlsVlE1dEM2aEEy?=
 =?utf-8?B?OFhKakJqRmRJS1NQaVhBalIycnY2UjZJWmZMcTIrb1l4eVduZStQcTArZUR1?=
 =?utf-8?B?bU91VnYwZ2RCQkNRWGU5N1FYTnduTkFPa1Fid09qbFI3dGRqZVBYV1oyVFJD?=
 =?utf-8?Q?2Inq9eymPwc9Logccx83Hbmub?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb2f5d-9c2f-49b4-438e-08dcdebb0ef1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 06:10:17.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ+Pq14kDOXh5+eYS8Fo5f2ZNYDN4xsIVecMHkIQ/KtP2RZDrZIme0twClkGtESzG+biSS0dkPPqtS68O4Pqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-OriginatorOrg: intel.com

On 2024/9/27 10:05, Baolu Lu wrote:
> On 9/27/24 4:03 AM, Nicolin Chen wrote:
>> On Thu, Sep 26, 2024 at 04:47:02PM +0800, Yi Liu wrote:
>>> On 2024/9/26 02:55, Nicolin Chen wrote:
>>>> On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
>>>>> Hi Nic,
>>>>>
>>>>> On 2024/8/28 00:59, Nicolin Chen wrote:
>>>>>> This series introduces a new VIOMMU infrastructure and related ioctls.
>>>>>>
>>>>>> IOMMUFD has been using the HWPT infrastructure for all cases, 
>>>>>> including a
>>>>>> nested IO page table support. Yet, there're limitations for an 
>>>>>> HWPT-based
>>>>>> structure to support some advanced HW-accelerated features, such as 
>>>>>> CMDQV
>>>>>> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a 
>>>>>> multi-IOMMU
>>>>>> environment, it is not straightforward for nested HWPTs to share the 
>>>>>> same
>>>>>> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
>>>>> could you elaborate a bit for the last sentence in the above paragraph?
>>>> Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
>>>> domain across IOMMU instances, we'd have to make sure that VMID
>>>> is available on all IOMMU instances. There comes the limitation
>>>> and potential resource starving, so not ideal.
>>> got it.
>>>
>>>> Baolu told me that Intel may have the same: different domain IDs
>>>> on different IOMMUs; multiple IOMMU instances on one chip:
>>>> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
>>>> So, I think we are having the same situation here.
>>> yes, it's called iommu unit or dmar. A typical Intel server can have
>>> multiple iommu units. But like Baolu mentioned in that thread, the intel
>>> iommu driver maintains separate domain ID spaces for iommu units, which
>>> means a given iommu domain has different DIDs when associated with
>>> different iommu units. So intel side is not suffering from this so far.
>> An ARM SMMU has its own VMID pool as well. The suffering comes
>> from associating VMIDs to one shared parent S2 domain.
>>
>> Does a DID per S1 nested domain or parent S2? If it is per S2,
>> I think the same suffering applies when we share the S2 across
>> IOMMU instances?
> 
> It's per S1 nested domain in current VT-d design. It's simple but lacks
> sharing of DID within a VM. We probably will change this later.

Could you share a bit more about this? I hope it is not going to share the
DID if the S1 nested domains share the same S2 hwpt. For fist-stage caches,
the tag is PASID, DID and address. If both PASID and DID are the same, then
there is cache conflict. And the typical scenarios is the gIOVA which uses
the RIDPASID. :)

-- 
Regards,
Yi Liu

