Return-Path: <linux-kselftest+bounces-9673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703318BF42C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B951C21A60
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05879EA;
	Wed,  8 May 2024 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVdwVcqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9859441;
	Wed,  8 May 2024 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132270; cv=fail; b=br8EQQtITeqVvI7rrWudfs6p5trFoPNXiGHJsfagb1rpD3OmoVOWc4akxqkfp2rtV4ilITYeBl4yQ4zg/Jllu95f4bUdNp/LLoeqZNu3iIUD1KLMjyUOQOSyVUXEqBp1rFqfxag7gwByyNiGuMvT3bR+fGJt9SPEM1jTxifjpBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132270; c=relaxed/simple;
	bh=2EVqEihA/4Mjva0/4l+94uePgFN03r7UTqnN36Q1n60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omnmKq6JYicji690pBsLHYZbGGDLNeNNsPu0ZYDnPYvUVa+cT0kS4oJJXOeZAeN+URPJjmhzVES3qTLEYQxhgBcGAdX28Fap1R74PkpaX9wbpt9/VWPt+aRY+fgj/rWvWfEFKF4VR2luQrAd4Dh1Slh48Fpm0/sJQEW3Ectz/+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVdwVcqV; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715132269; x=1746668269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2EVqEihA/4Mjva0/4l+94uePgFN03r7UTqnN36Q1n60=;
  b=KVdwVcqVHKLd8Vu4FRuOF3cxbfVKvePFesMxRdU3o59tX2x5yGXlEgHr
   lpTlEjfL72kFSMOwLv/riyKZN3axHEp8/7TuQhAEu5oqZd+oEZPNCrcaj
   HoBtWqfw1tNDzIv8nrkTH9jTcEj27Bsd6R5OhpM11pPLDwZYMJo715983
   f0Yo1PQ2j39wf1BS/zra2A5TML62tA2cRW5R7JNWLKH9vA4hEruKgrNkv
   AK1n0vXfk0r8waogLBJjGEtlUKh1a9zu5NBo5kHZnE0CXQZi/WV/dtNHy
   d8Gh/e7ysc2Um1djG7tzlfKM3pOBmNH1WFjvzNtOgA/Gkanjng7Uj8z3b
   g==;
X-CSE-ConnectionGUID: DeFljejoRMWR0NDjS0j4iw==
X-CSE-MsgGUID: Gy/0odpUSzuDNzE1SFjFQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36345228"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="36345228"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 18:37:48 -0700
X-CSE-ConnectionGUID: Flz30q0sRVG/JO7akIMLnQ==
X-CSE-MsgGUID: KYw1wMOJRrKWWIqZXD67Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28703251"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 18:37:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 18:37:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 18:37:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 18:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgqtilmLXihrgv2Z4PKZPVf66Cfz4whsnjumL120hNZ23Zw3am8zXKkISGPJjLeu0xOu0mbX9HwcdcynatD+UET2NZcsPL4cDLTLvxb+E3Z85ysNzcddQRsS4qcSg2qiixvkB4bAc/1MSIIo+bIKmHd9ctDOnDP3o4E5K/Hw9jkYc3tkmuPEOZamzSU0+UnX5IR4OjtzTgKUrVIdzylzWktoXUokvhw33mSJZXzDpii1M4M64m1/RlfsDL4dS7RWntKz89EEqeiTCGqc4RXv1hhcwLS4BMxewDzpxGB9gttZHdKeauv1H4FiM3nHPEezDkR1K8GPZJXnT7pAhgu0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yiqe857E32KyO+lkrF/R2pj60U7wK64if6BT7aMDQ0E=;
 b=JxYwlWilSIP0ZJmxywoP5VKkjHfujA/L5J//GsUjsrvuCm+2ohuojsg8v0odYGZ+TuU6JwhjpkH/ujOcl0PAkO5tY7oRks9xMahaor10qrNa8FqPUI6qF20QugnS64lkuXbU+t+p/r5jBwFkNSxiMbElpsmUWH8ZPABC62k2X8SDPlys89ONupN20fIGj6wx6mTlvcSAyVeN8jI2S13ggk6wwcW42e3Q7QsSJDGdAJg63v3AJamaYqSO7B620fZC52MgYO5WqgJ0r6ccmKndir+3u/CxGVWifHBR0i+fKiPiDsPACPFjUxOWoxCLpGtwHjZMsNZPFOg6UvJ6tjuFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 01:37:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Wed, 8 May 2024
 01:37:45 +0000
Message-ID: <076d9990-6253-438d-bc92-70eba6dfbca9@intel.com>
Date: Tue, 7 May 2024 18:37:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503234051.21217-1-jhubbard@nvidia.com>
 <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
 <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
 <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com>
 <7dd4b09e-b9ba-459d-bfa4-150e712f54bc@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7dd4b09e-b9ba-459d-bfa4-150e712f54bc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 60557a27-4687-469e-64c1-08dc6eff75aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K24wQndKaVVsayt1UUdmSlZ3WTBuUFppNmZxNERsREx1QUp2dGpnanYvY1Ji?=
 =?utf-8?B?RGY0YlZWQW4wL1M4cGVab2ZkcVN0S3JpaDA0WW16VHlQSzRWSHZ5S2UwN0FP?=
 =?utf-8?B?Qi9ZRDFIQnMzSG5PRE44dXl3SFp5MTVGNTFkcEsyNjVvbXMwNEN2NkZ3YW5S?=
 =?utf-8?B?L0JhbnBkT01HZHdhWUFKZXBtUjdxRjdRdTB6U2YrSDJKM0t0ZFRHU0hoM2ty?=
 =?utf-8?B?UVYzUEVCbHk3bk5WclBrMFpoM3RNcTVCeVQ5M0grTExJQWQ5VjI2T3NVUHJF?=
 =?utf-8?B?WjRKWGgvWlk0Z0V6NjZsS0xOYk9XK1dsWW1mUU1kVlo3M3htaFRYcU1lU3Ix?=
 =?utf-8?B?MWlMbXVvY2NGRjQyTjlZU2dpSEMvL2xNM2RIcmw5N3N6TzhUT2lzQjFxWHFK?=
 =?utf-8?B?SjZJZFdMUDRyVlIwY0dYZzBPMVJDT1RjQTZhdVU1YzRWM1RsRCtwUmZWeEVh?=
 =?utf-8?B?RURUVXk4R1YrbytvNVZVT05oMVhROXYvVFhmTGo2ZjFJd0lVVmF1UWJrcjFM?=
 =?utf-8?B?ZjJHWWM3OVREa1p5SDJTK2hOUXZpZ2EvYXRtU2E4QU9PemlYcHFxdmVRbXdF?=
 =?utf-8?B?Nmd4VmZWcTlTNS96dDdhVklzZkJkNDFsYzhXRzQyaG5lSW95dUZiSk55bXVr?=
 =?utf-8?B?Unp4eGdQYkpjSCtTb0NTS2RaS1lFc2xFQlB1YjlLbSswaTUydW81RzJTSWVI?=
 =?utf-8?B?eEN6Y2NJbks4QTRCb3Y5dFhOUnFQb0lYZnp2MlA2SzRnSE41cE1BL0hPaXlN?=
 =?utf-8?B?Lzd5NWJWcjI1em56dEZ4aWFvVkRIalVLVVI4aEsxOFpyVHlyRklPOWhZU0Zq?=
 =?utf-8?B?eHlMSmZqdWtzZS9KLy9IQ1RIL1p5WUttSktzRFR4cE1rVGVmN3FvSkZmcUhy?=
 =?utf-8?B?RDBwVTg0RGU1WXBVWVBoaitVVnlxWTZzRkJ1YkxRSmZBVmQxUjNtNEh2VCtk?=
 =?utf-8?B?VGxaZ2xEaDJzWnF0WlJZUkkxOEtYVDJ3OGU2UDlGNmcyeFVpdGlsWmNOcjBQ?=
 =?utf-8?B?T1dHTmpjNUNjQkJDOU5iNkRodkFLU1Z3S05KME5pWkNCOTdBcVh2cm9NZDBa?=
 =?utf-8?B?QWJyMm1nVG9ldTZYa0JWT0ErNEZXR20zaEFXSzQ2TU5pS25RWnBkZUZtNWs2?=
 =?utf-8?B?a2p1UEJoTTErUmxVZDNYRGFXa0k2OWQwOWloZWFoOEJwYkpiZWtjd2xvOWJo?=
 =?utf-8?B?ckVCYnpibEk4VStBWHVZa0JKdXVKaXhadTVBdkhZQ2pTemJMbGNEVGt6ZkM2?=
 =?utf-8?B?UHNnTVNWanhham9MNEk3SzNFUGphUXVuY01QNmIrT0dKY0NTMDlVK0t1QkNs?=
 =?utf-8?B?RGpJRmQ4ajcwaHJ1Ti9MdG5rQ3dSekpaOCtWTDZtSFhYa3FVUTdFcCtVcTVL?=
 =?utf-8?B?UG9KRXBiV3dpV1UxYnY3SFhpVGMzUlhpckFDTm5YWDNnblI0dE4xNndkTmlo?=
 =?utf-8?B?eXBlWjNsUWpkcDErdXd2cjFQbjZzaXdWMHpNcWltMTNSTDZYajh2SU9vQlVv?=
 =?utf-8?B?R01yUmE3MEdscCtMeVJlM1o5S3FrOWNXdjB3QUdTYkxXUjI1Y2lkeFNDQnBC?=
 =?utf-8?B?NlJla0dvWWNZY2JJNjF2YlBnT3lnWmJGbUJLaWRVSEM1eVZWTGJzQXd5N0xT?=
 =?utf-8?B?eThGSWxlYy91Ync5aTZwV05ZK0xWaVFGckNmSWRrT0ZoeVNzOEVBT0k5aG1B?=
 =?utf-8?B?TkQyZk0vSGxLQzZSeFQ0ZmRWMzQvWVlTNVducFVhNkh5S1ZOQS8ySk13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9FemVJaHpvYmxRRXNGeFNkMXB1RkNKLzRkaGRBK090UlpRRW1xS1BzTEdo?=
 =?utf-8?B?UFdoYi9wVHlxYWI0dDVCTWszWTIyUEc1RVVNSXczbmdqZ0U1MTlvZHJaY1Fz?=
 =?utf-8?B?cTZlaTZOd2pzWHptWFBkdHJldlhqN1BkYjFIVFJxRGlhVXpPa0V2VFlTTEJy?=
 =?utf-8?B?T3dmdWRFbGZaRGswdi80VzdwalppVjlCbThnbXFrZGhqOExicEw2bC9nVXlU?=
 =?utf-8?B?Z0ZGVDkzalUxclgybURwZjdlZnVCbmN5V202R0RpMUdvWFRXS3lldCtmUy93?=
 =?utf-8?B?b3hDcGJFNWpBTTlUMGZreHZKUEFPN0x5V01ra0dqUERka0Z2WnliTHA4eG11?=
 =?utf-8?B?MmRKWmZCVytaU0hkTnBIRXhtRzBucWpsaHd2K25PRnV1OExsMzhXUWRFMXFC?=
 =?utf-8?B?bENCRzlCV0I5c2FSTjBTYXpnUU1GaCtqdzRoRGlDQWh4Sk44N09pVnRpNGt0?=
 =?utf-8?B?eHZBUk5aeFlVM3VYcFljVlBHQWU1M0h6RGw5c3c1Q0dseHJoNXlWK1hXbHFE?=
 =?utf-8?B?RWJvRmxtTjZ4WFNURERUSmc2MFJwRk5ISmR1SWRQeGp2QW5hN0pnaUc1RDZL?=
 =?utf-8?B?ZHVjTENQbE1rTnI4dnVmc2JDTUhuaGpuV3ErSThZS1RpNnExNm0yK29CcDgz?=
 =?utf-8?B?ckpvTi9SZ2xBSUluakdKTTkyNUtBN0h4dTUxQlZyc3dUUEMvS1Nyby80Yzdm?=
 =?utf-8?B?OFFYcTBuMUI0emZVYndmdk5ZWjVqbStZVDlCSnNPWWptTnJ0bDQ2RHUxa082?=
 =?utf-8?B?SEVacVhMWGhzcUNlbi9GWUF4ZG1rZkovY3pRSUgwVzNtRXFiTzNTUThqZTZm?=
 =?utf-8?B?QlM2Q0N4TXFsMXpWejJscE1taHR2Qy9EUm44SldDQmZOOGtESW54U25pL294?=
 =?utf-8?B?anhGVllOMk40SnVHZUh2YVc2WlZXZkswN2JSTDlxUnVabng5aXllUXduN3BB?=
 =?utf-8?B?eFIwQjBCa2lONnAyUDcrM09SVTdwdWZBM3NGQTdkRmNHNTZ4YkRUdS9ycUJJ?=
 =?utf-8?B?K3lYVWpONWRsS2g1Q1g1TmdpdVhsNjk0QllGREdrMjFRT3JGeGhvZXJSZkMz?=
 =?utf-8?B?VXE1UWQ2U1hsMnpETnh3QnA4STdIbnoxT0Rkc1FwNFA0RU1BMUx1Yy9rU3NW?=
 =?utf-8?B?UUtHMzlLTzhYOFZRMGxic250c2RTWlhuVGlnYWN5OTdxMDZuRUk5Z1dlT0Nl?=
 =?utf-8?B?dU9rNURDcFFhSDhaNzlNczdUNU1FV0UwU2FDVG8yU2x1eWIrSXMvTUZIZTNX?=
 =?utf-8?B?VlZHcXh5eU0yalliRW5TdnA2S2tvaHp5bExlZVBTYldoTHVZcDF2cUNSUHBy?=
 =?utf-8?B?Wk5JTUhVek56OVRCQnA2L3ZPRGlWOGJ6L1NLaDJhZTkrMkhWajNpUll4QTNN?=
 =?utf-8?B?SEZQcFNoM0IwNnV3djNNTmNtaVZMUVZsYTV1eUlzR0s5WEwzenVpeTdmb1NY?=
 =?utf-8?B?eVQvd0RodllEenJHR2xWRXlGdUhhZCtDUmYzdHNUVEVWN0laRmxaYTYvbDRV?=
 =?utf-8?B?SndtanltdUpLY0hWMFFvK1hidnNSbFI4UkZNMGRxWHpETC81VjFYL2czWklD?=
 =?utf-8?B?TUVVN0pMUmE2VUpvL3FwMUZ2Qk5FWFEwQzFib2xxUERMbm9qWWw4RGNXZHdP?=
 =?utf-8?B?UFB6U3p4VXg0anhud1VrYjVreW9iNFNsY0RwY3NaK2lEMUNycUxjTDl6aENC?=
 =?utf-8?B?Ylh2eWNWdEFIeW0wTzhMZHY4UHJnMGJtKzRLQnBCdGNidGFSMXlJZEdjcmlW?=
 =?utf-8?B?WDRrUFNHZTJ6UUtMaXBLK1FIYVEyNEZVM1VySWhDUDBRaDdBTC9HSHRVdjVu?=
 =?utf-8?B?dWVUMEdMRnlSeC81bFEyNEFYUEFuQlNzWkxrOTdmWWEwaUl3d1oyclduWVpz?=
 =?utf-8?B?Y1FDeldpeStQcHRXbDRzNXVvNzFGUGFjUENlNnBsMFk3aHI0TUxSVjJlSHJX?=
 =?utf-8?B?UCsvN1dWa3pWNUxrTlN3dzE2WVI2di96RUZ4eDRXckx1L3lwdHRQUTNXKzBy?=
 =?utf-8?B?YTlFV2pKcWx0alhzVm9ic1RJSTg0SlpXaGhYd2xTd0E2QVkreEtUZGNNY1lZ?=
 =?utf-8?B?MG5UNjJTQ1pYM1BHRS8vMENLUmlNRlhTZm1EZXJob3VhZ3UyL0ZCc3gwQ1ox?=
 =?utf-8?B?MjNWUTJqTSs0OFBYcS9hS05Zd1phUEo2TUg2V2p1dFltNUluRnZLSnBLYXRm?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60557a27-4687-469e-64c1-08dc6eff75aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:37:45.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI2FoHvuaICe6CTIh7aR1ydid8K7r6B4hLwt+JVXuH5+gthnENZH82m3ENk6b7QtzAQ+61wKjnwxBDXFxPr4PVB+WgdUsz3Z1NV1cSW+a2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

Hi John,

On 5/7/2024 6:25 PM, John Hubbard wrote:
> On 5/7/24 6:21 PM, Reinette Chatre wrote:
>> Hi John,
> ...
>>
>> The following (what was in v1) looks good to me. What am I missing?
>>
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index a81f91222a89..05a241519ae8 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>>       int ret;
>>         avg_llc_val = sum_llc_val / num_of_runs;
>> -    avg_diff = (long)abs(cache_span - avg_llc_val);
>> +    avg_diff = (long)(cache_span - avg_llc_val);
> 
> This deletes the abs() call, because I incorrectly let clang's warning
> lead me to believe that the abs() call was a no-op. But both you and Ilpo
> pointed out that the math breaks if you do that.

To me the extra abs() was unnecessary anyway ...

> 
>>       diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>>         ret = platform && abs((int)diff_percent) > max_diff_percent &&
>> -          abs(avg_diff) > max_diff;
>> +          labs(avg_diff) > max_diff;
> 

... because it is repeated here.

> This hunk is OK.
> 
>>         ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>>                  ret ? "Fail:" : "Pass:", max_diff_percent);
>>
>> Reinette
> 
> thanks,

Reinette

