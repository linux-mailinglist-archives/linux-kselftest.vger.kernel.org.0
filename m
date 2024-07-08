Return-Path: <linux-kselftest+bounces-13322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B092A777
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD011F211C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F18143881;
	Mon,  8 Jul 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNnPfbrk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FB81751;
	Mon,  8 Jul 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456750; cv=fail; b=EYqd1TBNlWMwO6SzY02WQ9tHFzP/tPn3GJBToWf6t5szMeGnwdELVNe491AUrD8dUV3GK5l/nFc5xxtYoExlZ9ElX8UBtcHILI40oeewyMMCwsHWlNPLH147CDM/lu2W6Bke1RzI35B1bkVmvMXUC7BoTkQ2H5geZbeiMpZSlYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456750; c=relaxed/simple;
	bh=PHzK7RoDyoTFYi9aTEmbB7K2cOf4B2nCoIu/Wg0yCps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0+WrDOUH0tPUuotkpGMPtkrGaUUBFoeFSA1DTl0rP8dC1SaiLNQ9jtdatuHna2jve3dklkqVVJsVq6BX6NES6IUVfrYPa4namNigglactHQZUbg0ZkH3UiR6WLIyVSgXxlOggusKYSJB+6NSB1MzVft1Q14CEBAkFDo6bdZqqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNnPfbrk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720456748; x=1751992748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PHzK7RoDyoTFYi9aTEmbB7K2cOf4B2nCoIu/Wg0yCps=;
  b=JNnPfbrkBHzTDR+YumwQ8uuusIG0LogIEpD8xdLIFntd4+WEfUXDQDoU
   6Op9IW9qXcM8NeaovuJb52h/ZXWxj8C439JqhPMZYDNtIqwogimWpQhlG
   w6+7dEsB18ReWTVsRDFRqk8BAoKTVRLFQZeAygLKavqlOMFq+Cgq9PVrO
   WqGNJlfON5SR2D99AZSwll0+rcl/zDWLytN8YXUM43fVL8bsjSgxuWPKt
   1CLQSB3Ju2PrLP3GIBNF9pH1711hMGxw/Yezi6ojx3MRtxx8AVkkrfqfc
   NWXVy+Gl95gfSHQYVZipnqyxB90tZU/pjFLl1ESRtKUCMCArappgrRCry
   A==;
X-CSE-ConnectionGUID: v5jrtlsJQIWub/ra1gMzag==
X-CSE-MsgGUID: 1vGHTCCBT0Gx1Yc0NYAyKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35205547"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="35205547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:39:08 -0700
X-CSE-ConnectionGUID: gg/E1ghbRx2C9KM3E78ilg==
X-CSE-MsgGUID: x/6XBmX3QaGT0wzl4rfvWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="70769644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 09:39:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 09:39:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 09:39:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 09:39:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 09:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmJk4pclNmKOfJkTmozLAa8tRaonQXKjJDvGRsnvGrnu5ZnNBmTrxHBvz7QmRmvGdAWOayuDX2PGi4YZV2a/LTGJVfF1xCFOUt52sNMPwjsSDbXROtle1595bcOkru8ZqYHF+ktms3ZA9Ae9EIqRQ9bIm0OGQl1th0SN0M6Lxu8CNlLrQzZ8Wh81a7zRl4osSr5+w9MuJungqODYiXIf0HfdD3iieoPFNqKpbcjBvFFCcf8chWgXPQSwTVPbAL8b8DMjW98gFpaGvOD4ymIWeYphcVmk7dSMQXAoNViuKIryGyo6+VQjKfd7J8aKKUzLlA3tf9ojSd9J4mh/l8k20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HMCc8lKVXorHGxZ1eDhh8SOpegG9YLkVHWu6GlEu1s=;
 b=YfmdWGyshxp3x2xVaVFtFqbn9o87jnOtN9gjED8PPUshUVYElLdTrMXi7FWF3V7n0n74IkLodXXr7cBWvfPhe0N6lDDnuBtvx4O/mgajzyJf/PYUxdZ+tGainWBSoThSXcQ+5B3XGz52rR+uL/sgs8HhEBm3EfC412gscpeDPHbJbEbIA4xaar9iIPTBVEb20ZxoIZgu+P633SdN0fEgcKWE/47GYkKHKrLu/udwokUkfE3KyN3UMN5PD8qS2NR5zXrnfBK5+figayudJDCftPtxwxsTGSjz0/ibWTpx0z4MsIx7V9dtMyFhsic3fMD0liWtIysTPGBjoqF+aQxmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 16:39:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:39:05 +0000
Message-ID: <fda4f2d4-b0b1-4fb9-ae0d-0a5c4c1b65fb@intel.com>
Date: Mon, 8 Jul 2024 09:39:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
 <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
 <d5bd6275-ab86-439a-887f-17c04a586716@intel.com>
 <xfhv744t2ol274w6lddon77rn5dkf7dzbwqcoknok4kk4guehz@hwjsusvhoerb>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <xfhv744t2ol274w6lddon77rn5dkf7dzbwqcoknok4kk4guehz@hwjsusvhoerb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:907:1::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: c5505d44-a18d-4ad2-57da-08dc9f6c7b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1FWRzJCWnFWZHlSM25sQjJyYlkyUXRTTFVPM0dmcU5mN21RMlc5eVkwa3F4?=
 =?utf-8?B?bXFFenlRQW9Xb0FIOUV0QkNQRW5Dbzh0ZFkybnh1cVl6b0lrcXJXd20reXQ5?=
 =?utf-8?B?ejN4d2tXckVuTyt1NWtCcnVKWEpLYjQyNFdNanZLamRSdHJXUk1DYk05TzdC?=
 =?utf-8?B?R1VUaUw0V1hSRTN0NlZqeThMWFZYMUhCZGVhQU04SC83UVdCTksxRExrMGdQ?=
 =?utf-8?B?Ny94cWUrNVdVNXVPa3N4NUxvdXJrYXFYYjBnblY4bGR4Q2wwcCtab2lkOFU2?=
 =?utf-8?B?TTl1Uzc1RVdjQllrSkRtdytPUER3aWVjYXNwRytyOGNnMTJuQ1k4STQ5NTk0?=
 =?utf-8?B?bUdieHRLc3RvZ3BqTU9BU3d2SEdIcDNCU05YeEtJTWpGRW1QL1ZPVWhtZjA4?=
 =?utf-8?B?ekVLcHNBWmRIRm1lQmovRWcwZEovN3BydXdha2ZWZzV6Qy9pT0pSVDNBK1dz?=
 =?utf-8?B?VGNEcVFxS2E5MU1rUmlqS0FqNk8rc1ZwaUpjSVdHZVhMd1pQT3ZIWVF6alNO?=
 =?utf-8?B?d2Y1VCt5NjYzTW9rakxyTFlsVDY1MTd2MlF4cVdNOG1EeVBLa0svQWdLVThH?=
 =?utf-8?B?UFE2ZDRoR1E1MWVLbEFTaVN0WURPYXN3dFBGN3ZPYlFtYmUwekNIMnVHWlBy?=
 =?utf-8?B?N1gwcEdDREJZRGNzN0xRSjNoZHJVa3VqU2NaZElHeXlQdWUwVVhTbTdPbnM2?=
 =?utf-8?B?ZnFQWHZ1Wk1MMCtwaDlRQktnY2lvRllJNmtYYmh3dHlNSGFvcSs5UVFTNjlF?=
 =?utf-8?B?WHh4UFBZR1ByRDlMQzRudi9YakVhM25pRitLUmpuc3EvU2x3WkNpa0JHUlph?=
 =?utf-8?B?c2p2MEN1MDVGcXBHYWN0bWswbm9xS0NwQXBVc1AwUEVwWktxZmFrTjhCUG1J?=
 =?utf-8?B?dmRtWkxWc1kvT0lKaE16QTZLZGZObzhvYlZYOFBMUURlUDVGeHlmajJ2OSsv?=
 =?utf-8?B?Tm5tV2RHUW1qNGZOdEtEcTdDeWpVVEQxQjMxQld2eXNyQnNDbFJDR3FHazBu?=
 =?utf-8?B?L3VuWWRxdFJQSlhKd2JQSml0WE1NdUhTNFc5ejBoT1FtYlZldGlGNisyUi9i?=
 =?utf-8?B?NUIzSlJpUElCdE1tZTBET0R6dUZtUmhXS0R5c3NTcHY4ZnUrVy9pc0FpVHQ4?=
 =?utf-8?B?dU4yNTlJcytTUXI0dFBCYnZvbmNlSlJIRndoeVZURzEyck9QNXc4N1k2amlD?=
 =?utf-8?B?eFd2QjFVS3d5dW50Zk9TK01wSjNZUFRtaURjczdDZEpqR3hZMUZUS0U1K24w?=
 =?utf-8?B?UWVKVFhUTjVGQ1JVYU9WOTdyRFBhM08yUWJJaE05YndObldKNzlUNkJLbGc2?=
 =?utf-8?B?L2xjcU9peU5wOTkyaHpFY0d5d0J2M2ZhZEhEb3VnUE5xY2lpRmZaSWRqQWJ6?=
 =?utf-8?B?WG5RMjI3SStScXhnbDdKQ1JjamlnSXF5Z2pLYk14VXRvTngwd0JPVmxJN0FX?=
 =?utf-8?B?dXZqazQ2YlVDYkNDMG5CUWplVDVRb3BhZ2FUelM4WjRiYjdQa0pFWWcraTkv?=
 =?utf-8?B?cEpHS3VQK0thZC81c1dnaFhrelB3S3lka3pySmFsNGIyYVZNSzlybDZaWHJC?=
 =?utf-8?B?TzlFNUNXWlRrblQrcmUwbnRndnJsTHAxZkV6TFFDYWMxVlR3MVdqWUcwS2Q5?=
 =?utf-8?B?STkrTDlBWmpBN2Z0R2lSbkxJdEFvSTFWbmJ5OFhqaUVhUEtKVmtRNzJCWUpa?=
 =?utf-8?B?aUI1dElVM2lWVWJES2lOM2oyUDFWNkVJVkwrZEx0alpJbEt2a0lBVVc0Z3lt?=
 =?utf-8?B?eWd1U3JMU1NLam1aYnRLUjVaMDhHL09SWi9QSjVPY0J0ZmtmMDQvRkxsT2JE?=
 =?utf-8?B?TERpSDJ5VE85Ym9RWkVRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skl1UHZWRXRSbVZMbTdFb3BQL0c4VURybGtoekNVVVByVURFa3pWOVF3TEpX?=
 =?utf-8?B?WUx6NTBVWUlqVTVlMHNkbWlWcXV3VVpSdW5qeGUxMGVjbTVBWVYzczA5MndK?=
 =?utf-8?B?c2hLODl3Tk11SExLWkF4RXIrU0lDcDBHajlvM1hNeGIwbWhYVStFVEIzYjE2?=
 =?utf-8?B?d3dDazBhb1c0UUxweUJaeE9WdWNKa1hCLzNkVkt6N0ljZlpyM2gwMm8zSnNS?=
 =?utf-8?B?Sm1SZzFuZG1tSFJUeEtqeTZsNjZ2cGRkYmQ5ZmkzUGdEaGY2WkF3bG5reGU1?=
 =?utf-8?B?TmRoQmUxYXIwc0NZbm16ZkpObW1qQ1Q2aXVzZTlkQXJkc2hIMHhUazd1clIz?=
 =?utf-8?B?MmxraHUrd0lYNHRUSnQ2ekljZ3R5K2pzNDlONlo0c25wdzEwdWhMY2E1VmRz?=
 =?utf-8?B?MFVNQnpWS0lJb29VWlhNRCt6Vmp3Q3dKQUp3V2RCeXVQc0o0R1cwbHNaRGg4?=
 =?utf-8?B?L1NyS3NPajRweHpaWHVYNTdSaFdwZW5nU3lxKzdJNkV2YVFBakZpT05QZTJq?=
 =?utf-8?B?T05ZVzFFTlZnUFFqaElzY0t3djI4VHdmcUw3aGxhWEswMUk0eXhTOVc2dUpi?=
 =?utf-8?B?aDhhcS9BOHpua1RtZXJacmNqYURNUXNPUUtkNDhFc0tLUCt4N0I3YUpmS0xH?=
 =?utf-8?B?dVc4ZGl1Y0ExNmRPaDBxditHQTE0am1sTmRUWmd0SWJ4VnFaQjRNbzdyUnhE?=
 =?utf-8?B?YWptaXFOcmtrMDlpYWd5akxUSERZamlCL1NxaFBrMm9mRlZMYVphVFhuR012?=
 =?utf-8?B?QTJiMGZMQmtzaUYvTVhveHNoZExRcUxFL0VLT0hna2tpcUxrT2tBRVpMbld4?=
 =?utf-8?B?Rk1PdFdHYTZtZzROb2daYk5YbVFPOWRzbHhVOW5xTDJBSlhJM2ttQm1yNVJh?=
 =?utf-8?B?d0RuZkd0T2RQRTU0RCtEQmFXYW41L0grSnV3c3hCMXd2djFyeUJSZGJmZzBN?=
 =?utf-8?B?d29VMXRuVmU5UEx5NEY1VEQ5RGp1NHFoRFJHWVNXeUJPcUx4MkFtWnBEU2RM?=
 =?utf-8?B?d3Myeko5c3FESVl4bXV1ZktHTGFuQW5kT1gxTG0wcDFPbjlFSCsvSzRjbWtX?=
 =?utf-8?B?RXBRMFZEbWxYZjE4MFVIRDMvMlQ2MXlzOVNDdTcvT3hISEtzUzQ2ZHJVT0Jq?=
 =?utf-8?B?V3BLTXlIUzAxRDZ4bDhxOWpRZGxzR0liM1VsaXhVbmRzMWZhc1dkbjZDSUJ2?=
 =?utf-8?B?U3FpUUtwVDRNOEQ5V2szM2EzdmlpM21pdjJRU2NLekNMK2hoQ1dGRTR0NVBH?=
 =?utf-8?B?RG95am1yeVdRekxqME5iZDJTdUpYRU9mcTFGRk55YVhOYTJBRTdOOGpCVkI2?=
 =?utf-8?B?OFpQN0lmR2hXVHZpMnNObEU0OFFrWUFNdDc4RklJZ1BzYk9KR3NxWXBPRDdv?=
 =?utf-8?B?TXBOZWJMYXdKQng4TWN5dVBlUDhGWThCcSsreWEwVERXOURpTlV4WXZXY21m?=
 =?utf-8?B?ZXp4cEFKUmR0bjFOZDY1aTViMEVOYU8yUWNEeWdXdlYrYU9QMTBjNCt3T3Fv?=
 =?utf-8?B?eDZKZjlXV2ZKcEtnbjJSQ2dZaDRjbVR2M3psZ3FOeW1sR3pPM3VrQlFjS25u?=
 =?utf-8?B?YkJGWTRPdG0zYW9jb0hMa21pMFNWdkU3YTVmTVhrdSszNzYwNis4UUxVRm1k?=
 =?utf-8?B?OHZ4UmtuWTE4YlFxTTYrU01naHdGK0txYkIrV2FYOWNjWWViNE9hdVluS3di?=
 =?utf-8?B?SWFOYjE2eUVwSWw3ZFNEbEYzeWNEdHlDTkpGMDliL3BxR05lblB6QVRUalFt?=
 =?utf-8?B?VjFpYk8xd1ZacGRmUG1yUld5MnpxSjgvUUpxY0kwUWZHRlRTZjZzVS80dW5R?=
 =?utf-8?B?YzlRNmdPVTRySkZkZkp2ek5KeUFDWG1zc1BmemZnYkM3eWM5REhDWHpRbFg2?=
 =?utf-8?B?ZjVLbDRXdlUwTmNSaytCODQ0Q0xkbzFKeHowenBGblhDS0tTOTZCUTE2ODlp?=
 =?utf-8?B?MnFwVy9rR3NQeFFmbFlSUUZmRE5KY2JPNkFwTGx1ZlU5aUxnY3hIN0tXb1ht?=
 =?utf-8?B?S1dZbTI4Y1lGMGZjNjJrOUNuM0lmNzZVNjh1VXdPc3NGMlkydmpFUkhDOFlI?=
 =?utf-8?B?ZThXRjdPaWNicnZhN0VmU1lhcGtMNmk2bVFDVG9GUVg4bjlsZExNWS80ekhw?=
 =?utf-8?B?Ujk3MlJwamFtclRnc1JKcXBDUnVJeW5LL3NGMk90ZnFObW9FNjVJeXJqbXpv?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5505d44-a18d-4ad2-57da-08dc9f6c7b04
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:39:05.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYf1VeC8RBZ1RpXDFGj5lM2yrKuLgBRFwZvk1O1iBhL2b1joonvOwXQtxn7+DmIOtCYtk6KuH29c3DjB7gO4eztv0MdUvQGfdO8MRMolaf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/4/24 12:23 AM, Maciej Wieczor-Retman wrote:
> On 2024-07-03 at 13:51:03 -0700, Reinette Chatre wrote:
>> On 7/3/24 12:43 AM, Maciej Wieczór-Retman wrote:
>>> On 3.07.2024 00:21, Reinette Chatre wrote:
>>>> On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:

...

>>> SNC might not be enabled at all so there would be no reason to send the user
>>> to check their BIOS - instead they can learn they have offline CPUs and they can
>>> work on fixing that. In my opinion it could be beneficial to have more specialized
>>> messages in the selftests to help users diagnose problems quicker.
>>
>> My goal is indeed to have specialized messages. There cannot be a specialized message
>> if snc_reliable == 1. In this case it needs to be generic since SNC may or may not be
>> enabled and it is up to the user to investigate further.
> 
> How about this in cmt_run_test() for example:
> 
> 	if (snc_unreliable)
> 		ksft_print_msg("Intel CMT may be inaccurate or inefficient when Sub-NUMA Clustering is enabled and not properly detected.\n");

It is ok with me if you want to keep the message even if the test succeeds. Without seeing
the new implementation it is unclear to me why the SNC check below is guarded by an ARCH_INTEL
check while the one above is not. Ideally this should be consistent to not confuse how
the architectures need to be treated here.

The message does sound a bit vague to me about being able to detect SNC. How about something
like:
	Sub-NUMA Clustering could not be detected properly (see earlier messages for details).
	Intel CMT may be inaccurate.


> 	else if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> 		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");

The "Check BIOS configuration" guidance is not clear to me. If the kernel does not
support SNC then the user could also be guided to upgrade their kernel? Perhaps that
snippet can just be dropped? To be more specific that SNC enabling is not a kernel
configuration but a system configuration this can read (please feel free to improve):
	Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.
  
> This way there is a generic message when snc_unreliable == 1.
> 
> And as you mentioned at the end of this email, the user can be expected to
> backtrack to the beginning of the test if there are any problems so they can
> discover the exact source of the issue - offline cpus.
> 
>>
>>>
>>> Having only this one message wihtout the "if snc unreliable" messages would
>>> mean nothing would get printed at the end on success with unreliable SNC detection.
>>
>> Having a pass/fail is what user will focus on. If the test passes then SNC detection
>> should not matter. The messages are just there to help user root cause where a failure
>> may be.
> 
> My train of thought was that if test passes with broken SNC detection it means
> SNC was used inefficiently right? (either the portion of L3 used was bigger or
> smaller than that allocated for one cluster)
> 
> It's not exactly a failure but I thought it deserves a warning at the very end
> to alert the user.
> 
> If you don't think the warning should be printed on success I guess the
> condition can be:
> 	if (ret && snc_unreliable)
> and the user can look at the start of the test if they care about more
> information. And the message can lose the "inefficient" word since it would only
> happen on error.


Reinette

