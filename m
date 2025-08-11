Return-Path: <linux-kselftest+bounces-38653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE7B1FE7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 07:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5739178518
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471E25D535;
	Mon, 11 Aug 2025 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiXB6xMM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F31D52B;
	Mon, 11 Aug 2025 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889877; cv=fail; b=NNTj0GrrTxrZqiZEre6BFRRG2mXEcQRWdE/lbEfNXb0p2FTBtmlJCW+hjzAUC6xUWJuU+woVKabo/unQMKadel4Sq2zNrF0p+cdRjTPvmiPHai93wQloKbiHAGDJBBnTsNZ6mE2AVLNXcGeBmuMfuGfli+l4s2lDj3gwTJGmaZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889877; c=relaxed/simple;
	bh=SbRkyKNP1Nsgrrch8IjrAkT7EtFSHSO7Os8B8roodho=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b/goqxQwZZWZsBQlXPgRdfqU10rBJqU3Q21h9fVPYyFyOPqcFIHLrFKqh9UyceEyKlC33/NByZgsFYMlEZJ9PP4GHag1AYYXAZswHghCmW/ExZXzGgAL67IQ3wM8+PxMSS2bpB6I8ynJlxVHg7AK6x96i5OBygl6u/sV/x7iNSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiXB6xMM; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754889876; x=1786425876;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=SbRkyKNP1Nsgrrch8IjrAkT7EtFSHSO7Os8B8roodho=;
  b=YiXB6xMM0kHkWy/Gt1nx7Dg47VfhYmshDJTB4jbLkaRGTD3psSAeAEnG
   xQrRCSFZtBBMqVdhpG+IGrBD5+isGtjgwjQlKODiqrWfjin4sOj7aMw4i
   p3Wu9TN2zgAuoauXbuqcdXCYLuFkCaZ3u6osATODtwxxlhOj78D2kPW/q
   NPJfAECJhepIRVfI5tCqTfvUbFVMuwmL85azV8Jhm6XthOwv5ps/YSse1
   tc3YR1E8Ld3YaOtY2ePZ+Le8jybeFF34d5ThbdN8cVYtfcZAO23lpQrdx
   VsOKQZucotjP62q+0ElKtFheCp+uRSupRxGjV4FJPxyyvE92fDfxIwBkZ
   A==;
X-CSE-ConnectionGUID: no2RShroQaSNc0+HG6+UpA==
X-CSE-MsgGUID: fBDG4hgrTwuqNi+WTJIHSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="44720141"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="44720141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:24:35 -0700
X-CSE-ConnectionGUID: 8vBgGt7SR+6Utos1B4f/1w==
X-CSE-MsgGUID: ej5QNlUvSVy7eI4LBBwC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165062531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:24:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:24:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 10 Aug 2025 22:24:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQcDrrJucfRT3YVXUc950+SnfMr3okOC51XjozBQcxnlY8KhmUiyqlqvk6j2J4eppdHvvXcfwvL852zUgfEmBzf3Dvm3LUTR1GKr0+TS5gt7TbDteNNZ9d7HdS88ift29Aa6fxPUHGh0R5mwDUfFCSaASiXmfs1GUhA9CfvbRsWfLkNAXHZzN6pVxWa8KBdW+j44iS0hwmv/j6WM9GubUo/KPSYCuWSlk8eQE5Pk8Id3CJCi6Pj22NDzD4tceT64609jXxSgBv3uhj+f8DAjUZND8uJeE+l8hz06fYhcNvUIMQbsEu4JW/uGFvSdVTcozar9HLqzHpYdWd364s+6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC8o/Br4XOny3B5AlMSfrWcRm+C61L+pWmfI3Azx7XI=;
 b=Pcmc+rAoK11XBIA0xc/XuFmh70Hjp9vtFqp4HHr25Y7LsfXzlb7tmiN+YsAOXp1otXYTaJY1R7E68VcjDuWZI0Z57jR3wacgu9pptQzzcIvoXhFXZoXQaoQASkMSakbd7Detn3sR7W6Q3PCj8YavBizNWmXUQxEEXQxpktOdwmVRN2pQeN1ZA14cbQbHqmls6mXEQID7Y5LEFA6YBYrno7TZcUipOL0gljJu83aer80cuNTPndmGc+9/Q5bzQ7EUbOJzYXCTu8EjXxt/rC6bP8rvnN63EASaLgBo4XxLVufPuJvIw3oweYqgnsUwucvUuvIS0F4bjGAdLb5J8BbSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:24:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:24:32 +0000
Date: Mon, 11 Aug 2025 13:24:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [selftests/fs/mount]  c6d9775c20:
 kernel-selftests.filesystems/mount-notify.make.fail
Message-ID: <202508110628.65069d92-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 33210df7-6ef3-4d99-80b4-08ddd8975a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnAwTlJ4bUVBZVZiUGFtUWhKa1BEWW9KODFoc2ZUeVp5TzBlTStqUTZFaUdN?=
 =?utf-8?B?QlR5QzQ4ZVp0dlJMakFKZ3RyL29wU01Cc2plVXlVaGIrNFZDTXlmU3NEMjZY?=
 =?utf-8?B?Z2xsYzUxQ0FtNUNvQXNwcGVORHBIbVIwQ0MwOWQ5L2hlYm9TRGxJcnVhdUlT?=
 =?utf-8?B?dDFpdUV3NVF3MGp3cXRxRXU3UnphSkxLRW1Ibm9HRGhyelBzUVRIZi8wUjQ5?=
 =?utf-8?B?K1Q4aktaQ2VQenR1SlhRc3gyL2NvY2xCZ3F2NUhFNlNQOEVtNmlxVFoyTmpi?=
 =?utf-8?B?YlhQMUs2eDZnb3I2UWt1MEZGdzhSalVMWUhqbHMxbFp2YUIzSnl1M0dYMHdu?=
 =?utf-8?B?ZFpvdHkzem9KM25zRFZMSGVyZ2tLNUJ5OWNCMlExZVZFSmJCd3JHSU5tc3Yx?=
 =?utf-8?B?bnVWNHZSOHIwYldWaHFxM2h2VGpCRERzMzBVaEh0NUsxWnM3emMwQ0lJNytI?=
 =?utf-8?B?eVhPWWM0TWtieUUvemw2QjZta1FrRXBGZUdJM1prWUNLN2UvOGhYT2NvNjRj?=
 =?utf-8?B?TTNxZ1EwSitQQXFzNTdpWlNISnlCeWFvSjU4bUlUTkVVOEFHM05DVzVJLzVP?=
 =?utf-8?B?MmlpVG1tLzR4VnF5Y1EwL3ZMa3AwQSthYVdIWmwvTUNGZFZVb3hCT2lSRkRl?=
 =?utf-8?B?NnVDUkZjU3lkdUxzNS90ZVNxOFIrOGFjYlhiZjNDTnFZdFRTbUhSbUdKTG81?=
 =?utf-8?B?TzdVUG9Kb2RSZW50QzRHRXphNzRLV0xSdnNwZmZTNFM4VkZBR2hkWE9lMFBw?=
 =?utf-8?B?eUlrd1dGM0Y1V1pCN2lld3hoREh6ekpxWW1NL01lTzhLU3M1NWl1UGJaVTE0?=
 =?utf-8?B?WkdTRmtKMHNpOVVNOWZtTWZYanJLRStuK1hqbndGTVdTNTl3NmR4aW5rVGRH?=
 =?utf-8?B?WWQvYndTZ1JXNjl2WXRSY0NyNkZmZjR0WTM3dnkzem1TS25JYmFiNTRycHNH?=
 =?utf-8?B?Mnp3VkFFaXViRE9OU1p3azhZS3NMTmptYTF6SktlWitlL1FodEd6bUJYRFBu?=
 =?utf-8?B?OUF5dWpoZEdCYlJZODFzL1pmRWxxMHBqYTg2cjdoU0VxYUgwVDhXSGNJUVI5?=
 =?utf-8?B?M2RMSWZsTzhOd2NTY1U4eWUrWjNHZkNoSWNScUJSYnhQVlF5cTdZa1RlRlg3?=
 =?utf-8?B?RmpWV3BHNjBVZ0ZBSy82TmFDRkxyalV0R0p0ZWxDYWRYUXFoLzF5UlhkNnRm?=
 =?utf-8?B?UmNHYWxBQ292MDBpV1FsR3NmODZTc1dqcXZqZDVpVXM0VmFXNWNhVmcyRjR6?=
 =?utf-8?B?MXhoMkRGaEpzUk5nQm1BNTV1WHFsblhza3hFVmVoemZOOFNTR1BCTXpFR2pQ?=
 =?utf-8?B?L3paSXdDUFFEL2IzR2hJb0xyMGx5SHlNeXN4TGpiMHNTYnFtRkxFK2M1Wkor?=
 =?utf-8?B?UUFNRGxqdmdhM3NnTk1oZW5acTkwK05NNXErbzBFV3RnQmdtSGtveGdIMGVY?=
 =?utf-8?B?VjlhQlRxa28vOVkyeS9hcDAxUE5uM3BNNVQvQzZKNFEvWHlFSlpZOGJ2MTRv?=
 =?utf-8?B?NDhucGFrWGMwUXl6L0QyTGFiZFdxQ2JRWG9WWERSV3V5V0RwT3kvUkJSa0wx?=
 =?utf-8?B?bElJaHljSmZUV3FVZVNoVWdPa2drUWxGOTl5SkdiNmNyam9Cd1JCSzV0cjZo?=
 =?utf-8?B?cGdKM0hmM25uRjRsQlZhSEtwU00xZkJERDV2cVlUL3phWWF0VVMreTdqQkxY?=
 =?utf-8?B?bGNoTE1Bcm1NTFJxelBKRnIvNmx5eklpcEI4YWtNVUZ5VWRqT2dBNDMrNCtz?=
 =?utf-8?B?NThnOS92OEJENGhnY2lKVVFxZ1dJeWpoNmZSL2NZa2JhMWdtS2J6a3ZOeGJ2?=
 =?utf-8?B?UFNod1RnVzBtekFCalRBRnNibFREOUlrVmloVXlwSisvWko3em10dlV0dE1F?=
 =?utf-8?Q?Qy0tGEJNI/Ds0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpoUUpnYjUzS05pckpvWmd1K3B6ajdHZEdiN0h4WkZuUFkwaVBCbElPcEZF?=
 =?utf-8?B?QnNBc1J0RXJFUW1RUU44WjBmR0ZrYmtIekhDY2M0SUVjN29zZTQreDNSWW0w?=
 =?utf-8?B?R21YQ2U4MmdWb0pUV3ZqRTBwUmJ6Q2xsYkV2MkxQbU40TWpPK2pCRVo1RHFk?=
 =?utf-8?B?ejUzWjNFZE56N2VBblR0YWdUYWhIQWtXVEZ1NVp1YlpGU1l1a2VDakRMdm1I?=
 =?utf-8?B?Y2VYa0lxYjdCblByMWZwL3FCTzhvUTNCZFoyUVZnWVpnNGlGd0ZUb0QrUmFT?=
 =?utf-8?B?TXluWEVjbm02dUllZjNSbjQwYnpsT0wzb0pNVXV6YkhwSGNnNW1iT0xqcUYv?=
 =?utf-8?B?bzJkWGQ4dnhZNVo3cTk1Z092aXdBM21lRE0xL1NGQmxWOTFIRHBISlJRVHNK?=
 =?utf-8?B?R3NEVVgwTFdLN2FFZDZTVzNKV09STnpWa0h0RU1OK2dyTE4weUE0eVhDaExs?=
 =?utf-8?B?WVM3MzlkalJvRmliZmg3OFVRbFlFWGVHZmVMUnNFVkExUlYyL0RHTHF2MTdJ?=
 =?utf-8?B?TWJVajcvcW5LMDc4OUJxZE5rb0ZWZE90b0czbnQzc3Z4elluWWwwTVI3YVJP?=
 =?utf-8?B?dTJXbk5YUTBuTFpJTTRGNmwySHZROG5DT01sUm5zYWRCeFRzTHpUR1U2MmEv?=
 =?utf-8?B?NWwxWWNwcmJDbEZQbk96N0J1QXE4dEw2STE4VWpPdHZKMmdtUlY0RVJrUHds?=
 =?utf-8?B?dWlycngwTE44Y0tabHIyc1pCTjdZWWU4cncreTFoczlLWTh1cHU3VHkrVG9a?=
 =?utf-8?B?VlZhV0VQM1dCVVNlRmg2SUlQcjFWcUw2cDJnSWtVQWVrN1ZEdlRCK0RvaGpK?=
 =?utf-8?B?Tit6YmR2Z3plbStrNWFOMlNuOHRpYTd1b3k2U3lYU3hDUjZROGNNZGpKQzhR?=
 =?utf-8?B?dDhJQ3lUK1RaU3JCbmMwbjU3dmpad2xvUUthbGRTaitUNGQ2WkhIS2l6ajJB?=
 =?utf-8?B?cVBqOWZrSkUzTU1OYW81RUFLakVXUDRLdWwvMkgra3p6d2ltN0grckU4VGZl?=
 =?utf-8?B?aXJvRzR4SmQ2UUV0YmdTWC95Q3hGL1B2QWxENG5rTEFSYStEdThXcmNJZjJ1?=
 =?utf-8?B?dDNCUmk0ZTRMMDZkOVZwdFFoZERHNkxTV0xicGcwdHZINTVqUDNaYXpBLzhN?=
 =?utf-8?B?OTdxMnBBb3VCSFR6SG1IRkNPeHRHRmdidjRUUm52ejd0SU9CMWZIdTMvT09p?=
 =?utf-8?B?cy9YdVZNcEx5bnM1Q2RQOUp0UHRZZFcxNXorU1BwMFd1eWVyRXg3QmhsblFk?=
 =?utf-8?B?c0cvK2FSSlJqUWFsUzVMdC8xUWxjV0cwVXhWOWJDMTRrUUZyYS9UTG9nVHZz?=
 =?utf-8?B?bnV5aGNZWDhyaUN2S2lFRFRMNzNuM0VVK3dFZ1hrdjl5clBaRVI2eTJLbnJW?=
 =?utf-8?B?U2xpZ1FPMFFkRXMvQlJIM0hjd1psei9HVm1Tb01kaFNEQ0tDZHJ5Z0lQeHpO?=
 =?utf-8?B?QWU0VStzLzV1WGJ6RE5SQmJVN2F3MVQ1eEpXOUh3RVBNajE4a2IzYVkzYk5H?=
 =?utf-8?B?NTZXN2RzTFpzeW93SGd0MkNaeVFRVjluMnBYZU05dWNlS3A1TE4yWng4U3VD?=
 =?utf-8?B?Z0VNTDEyVjdXalg3Y0JhTE5kYWtUdUlGWGxrdlBhd1hFMzlUSVdPeVd5Z3F4?=
 =?utf-8?B?dlNqUklraHdGeXI1SUhPZVNBVEJhRUoxM1ZuSUpKNk44aUdVSGRkTnNNSEZP?=
 =?utf-8?B?YXNDcnpZWHlHeE03STAwdGNsd3Q4R2xYeWdRdmlHbW1zcWc5Wko1Sk9NM05H?=
 =?utf-8?B?MHZsaFlacHEwbVRSTTY5ckpjTGlRYW1vUXg3WWpTcGdleXNFd2VXeFFkaHJa?=
 =?utf-8?B?bTFwQlhab3B4MEk5T3dlcU11RWhmQkJwNW5MYTgyK0ptQnhXNDJ4MlJad0JX?=
 =?utf-8?B?aWw1L0pDMnBqdGlHekoxRGhqblJMQ2hxdjdtWXMrSlN2RGtSbzgzNXF5bXRL?=
 =?utf-8?B?TEhIb2RNRk41ekNjTkNTZHBkK3k5VWl4M3c1NnF5Ylh5WllOU0NvZzZKM1kx?=
 =?utf-8?B?c2s3U1NsTExSU3lHMmRLYnRNS2M3d1VKVjc0YzdJM1Iza2ZQVUpUU0NiZUV5?=
 =?utf-8?B?VTkyMFRLQ0dYT1ZUeVloVFF0RnB5dWtOb09GQmJYR09Hd1NKdGM4L1F3T2h5?=
 =?utf-8?B?SnI1eHhVV0hzdTl0WUl1eGhpRWI5UGdUbnhhSm1jV0JadStHbUg5Ti9iTVN4?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33210df7-6ef3-4d99-80b4-08ddd8975a48
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:24:32.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcpDdLHOQbrCFWZPes9YJDlOwJtqqAx8GZVbK3X6lu5zbqhec2XGQmNMQt85CFMmKbrFxSk+HBdx/mMFbrvjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "kernel-selftests.filesystems/mount-notify.make.fail" on:

commit: c6d9775c2066a37385e784ee2e0ce83bd6644610 ("selftests/fs/mount-notify: build with tools include dir")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 6e64f4580381e32c06ee146ca807c555b8f73e24]
[test failed on linux-next/master 442d93313caebc8ccd6d53f4572c50732a95bc48]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-186f3edfdd41-1_20250803
with following parameters:

	group: filesystems



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com


2025-08-06 18:21:58 make -j36 TARGETS=filesystems/mount-notify
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/tools/testing/selftests/filesystems/mount-notify'
  CC       mount-notify_test
mount-notify_test.c:21:3: error: conflicting types for ‘__kernel_fsid_t’; have ‘struct <anonymous>’
   21 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/asm/posix_types_64.h:18,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/asm/posix_types.h:7,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/linux/posix_types.h:36,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/linux/types.h:9,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/linux/stat.h:5,
                 from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
                 from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
                 from mount-notify_test.c:9:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/usr/include/asm-generic/posix_types.h:81:3: note: previous declaration of ‘__kernel_fsid_t’ with type ‘__kernel_fsid_t’
   81 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~
make[1]: *** [../../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/tools/testing/selftests/filesystems/mount-notify/mount-notify_test] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-c6d9775c2066a37385e784ee2e0ce83bd6644610/tools/testing/selftests/filesystems/mount-notify'
make: *** [Makefile:203: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250811/202508110628.65069d92-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


