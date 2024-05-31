Return-Path: <linux-kselftest+bounces-11034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5A8D68DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977491C247F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C9B17D36B;
	Fri, 31 May 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6A+//f4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE717CA17;
	Fri, 31 May 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179456; cv=fail; b=eQDGEDoWSnEmvwPkxWF7GPjDvUhO8XD5Noj0f96UXeA35LzBCMKnFFFf1KjXDvxGeqy3Sszg5N0yFKwaSIVJWBPckQV+RrdjBLb4tckh8tQIK/16UNUxxAsQ07MzzPH5z+MMo/LFWjBX9pkveosMhWD/UnXuutJirY7vBdh92P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179456; c=relaxed/simple;
	bh=Rgrv1QMNVptM9g8Y9hMkp7ge/IuU1ezkSnq5sQsnhzw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt6uany1HOKGbDD5hfI6wlx1Yq0fjJDJJXHD7SSKuHQx/GDp3zch6sahpwKMvVtVyY+Dir61LeoglwDrYGxqrG56d7NwJo18PPH+cFsv9Gv19VpKdkYJ+AzWMm14b1z1rwzyoJ2Mo88N7ABp1qw4bPsifOzg6Hz8Xck5946uZAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6A+//f4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717179455; x=1748715455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rgrv1QMNVptM9g8Y9hMkp7ge/IuU1ezkSnq5sQsnhzw=;
  b=I6A+//f4uGdsiY+kQUM1RUmuiW6s6ketoE9jDt8X7vpLSuAYjxzPbra2
   0aTohjXULqub8f17a/BsGR7Y+mS3vyJ+OpBAPyN9500CqoHrOfmRAMa5A
   Lk7BUHnby5hIUDnGAtQzjz/cVqaMcDVHOjpy+jkzRKfMxTTah6WP2VNgn
   qtd5+ljKSbf38WQNaW0SMFUZErryqUWMiS4kpIiVlRZrgx06j7bFZLhWl
   gb8RdTY9WICCtxrii9ygk5ma4eIFbngsmewveWi4APMWmKDIM1g9RWJaM
   2Es+090RdB9XuymGLkghOUY3XF6+p1m089uhE6M0h7nd+X/zN93YnSA4n
   g==;
X-CSE-ConnectionGUID: LUUJ4oZ4SZC74yyk/gkCSA==
X-CSE-MsgGUID: BWEqST2QTc6EDHNSJ3Upng==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24398738"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="24398738"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:17:34 -0700
X-CSE-ConnectionGUID: K8zrnU1ASQa+WzQKkemyMQ==
X-CSE-MsgGUID: gHaUv1bWSker6Hj0u70BWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40686561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 11:17:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:17:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 11:17:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 11:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGSMU7HMM1gmQJUUVae09ljo6JZ1LHQFCc21UFw/i9T+E+e0PcgCjzZBcMeUMOsayT1nQJ6pE3VXsH3+pYNwkg+nVyhh6TQI5KUEVQssIXkgPpyUBmwc+L9wstyoNA4JE0ZZYCjHNgeQqR/ULtg3P1y4OubCOCKBm44/vx7DV0uXuOI9Adruz4C+kAnA4FsCzfKt4QQNS+shDU1qzChi1e01HsiUKwtsKuln0EXACAjQzW8dnXn7ea359XyZ9VxFlbnYhorsayRpNJ4ElxxW5aBEpsRtgvS0qwHqRmxcMLMIjRvPlXh7t9HFVuU8wzfAyryn4T3OJwTaeIwWHm90gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n+XT8BG3EhCwM+Kdp7iXmbfKZlmn321rIIHvJe3d/8=;
 b=L9nHpcyFw6tdjeOZ4/ibp0AccuKqnBKZ5bDi/PS6RiJOXpxtNbNPuU9P02jHxTZSg44neTx9gKbSQ8gF1HXccYFv1n2qzPyJrjU4fSNByo5uGGfsgef/7tZFBVZLRB4+BI5l8JfIr0VMYimOQCp6EOgDOQ6ukVacL2ZsV+YL5uaoI+0BnIxCI75klO+5BtGGzBymnwrQGGyIdMcBwTlTFJff523HGaEgqiB5qDq/s1v8D0Z4GZ+ftkY/caVlUEZYX/pSYGZSRi54MoQczimiMB1UlLmFBS7p27xZj8zsXBZ4CJ1Z5BzYzLrIyRj5+kvCCSJo2LCa+uiIJE/uWDoL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 18:17:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 18:17:31 +0000
Message-ID: <d8972012-269a-47d8-a150-f97aa6312efd@intel.com>
Date: Fri, 31 May 2024 11:17:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] selftests/resctrl: Use correct type for pids
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
 <20240531131142.1716-6-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240531131142.1716-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: f5093481-88c9-4491-36ae-08dc819def93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkhqSDg4dTRGcFk3bFlMMDcyNHd5R2FzZ2g4SXJmb1F3dis2YU1sRVM3V3ho?=
 =?utf-8?B?UTlQN1ZaQ3NZSHNZQUpUOVBnNmRSOVVtMGlOMmwxTE5pSkhFaXcrU3ljdXMx?=
 =?utf-8?B?THNLOS9aczRwU1laSFhJZGxvRlFLU3laYis5WTg5MDFRTzFJNFpacGtQdzdQ?=
 =?utf-8?B?ejczS1ZST2JqVDZ3a0dkM0Q5N1ZxS0RvNDlQdjUvamFHcVUwSUgvR1BiQTdT?=
 =?utf-8?B?alh4bFBxcmJpcDVRTGMvczNmd1lmYnM5cDc4NFcvSTJ5TmxoTzI1Y2tlQ0pP?=
 =?utf-8?B?SFdlUHJxTTBBTHB6OXNFTWg0Ykg3NGR1VUszZVUzd0dlVjU3SldQNG9IbG50?=
 =?utf-8?B?eFM4LzRVZTZGSEYzQnhoaWpvTmQ3Z0FKb1YwOWhPd2JlSE56d20valpkcHFF?=
 =?utf-8?B?ckRlOGJWY2x0Vzg3bXZncXRoVGFZWEJHb2t1ZGpZaGZkL05HQVlodWdLOXhu?=
 =?utf-8?B?T3kwRzYzOGF4YzF4L2ZON1VVMTNoUGhxbjE4d1pidHJoYUl3L0x5Uk55cnFm?=
 =?utf-8?B?SUgvaWNaTnlQTHk2NWFtSjNVbHVkaHQvakZ4MG54aEkyRm13dzZKZHF2eGQ4?=
 =?utf-8?B?WlZKWVdvTDA0NUUzOXlGTFNiWG42N2dvZEkvS09lZXVIV1MvTlRXOGxRYmNx?=
 =?utf-8?B?b09sUTZNOWVrNjlmV2w5bHJ1VlZCSU56c3NFd1g1ak1FV0JhYis3bGZHelpO?=
 =?utf-8?B?aUtHMGU1OGNEbUdlL01IUThtOU1MUVE1RWg5TXNqcHBUZXR2aDVoaEFRQlp4?=
 =?utf-8?B?MWpQY2lsaEZOSXhlZnNmZnNiQ29OYjIwcFl6ZUJZMVYzWFN1NEdvMG1xblRq?=
 =?utf-8?B?RGZrMStkRTRUV05VZXRIY1JxU2JDa0hGSFlhOWJjeEI2MWovNGVUTW9DaW1Y?=
 =?utf-8?B?YTgzQ1Y3T1J0WEsxalZDM1pvOTRVRG5NdHZnQTJOY1ZJVjJTWjY2cU53Yk9q?=
 =?utf-8?B?Sm5DZDR5YXhyV0dXMEN6UEw4Ym1mQlJHS2F3dU1pN3hnd28wcGR5K05odkNl?=
 =?utf-8?B?Z1NOZGIwWTA0a1pZNHFiRFlnWmZLTE1wRTVPUGJqZnBRSTZmeDRVNnl6MGUx?=
 =?utf-8?B?ZVRyVmUyQzlON3o5YjZFOEMrTWF1SnR5VklQVjNxRlRSR3Z3SnNZRFJEVlhY?=
 =?utf-8?B?QWZxekF3U2NTSGNIZjc4bDJZTURCblltbjlIT2lybDZvdWxBRlNDdHJWMnpw?=
 =?utf-8?B?ZlpjT1NBWmtDZ0psTUxVNFJ1VDd6QWJnajJSWmNaZFdtS01XWVVrbUQ4ZExk?=
 =?utf-8?B?MkVqT2FRb0NOam5ld1JoVUIra2RjUVFMbE9qaEhBS3NRQWRlMlV2bjFsRVhm?=
 =?utf-8?B?ME1ibFRRNWpQZktNY1BRL1d1TGpDWWdYQWNGWWdJeXR2dHBYRTNMZk94OWFx?=
 =?utf-8?B?RFN3WmRRTk1weDZCMzBFclhOeHFFMHpwdVdwWEZrVVNZRERmR09zN1VMREFE?=
 =?utf-8?B?UkJ1TExOWGQvZitRZTd3VEEyMXJxc0JFcFlJaW42aWl6dXQwRzlxZFl2VmZS?=
 =?utf-8?B?ckw1SG15WFR2SndsVThZclY4Und1T2xIbWh0cVVJUytCWkRqbFI4bXp1SmF4?=
 =?utf-8?B?d2hMUXVKZklOa3JDdWdBeUtpd2dOQTUvL2lycWpYclNXQWdJU0FTd2JlaDlo?=
 =?utf-8?B?cVlFbHVQOUh5WldteVdaT0NUUkZmTTNKMCtIbHExdFNTVDBGaVRpdXFMck5Y?=
 =?utf-8?B?ZEhwc1JzQ211VTIzTGUvY204ZERrODN3YWFrQzl0Mld0aUg0OHRIeWxnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REx6RWxrczlEV1ZFc2U0eDhESVRKVExOWWljR2pHYUJmQkhsYUh0Qk1pSEdH?=
 =?utf-8?B?SFZFN09uS253aGF4UjZpTW5VVThMcmdZUElwenowaWcrc0pUL2hWWGgyYXlK?=
 =?utf-8?B?Z2FFb1pTdENLWmcra25pUEptNlcveEFCVzQ4Z2thZk9KazFrWHA2WVVXcE9M?=
 =?utf-8?B?QXNRVkdwVk9ZNTRBL2VvdEJCMVNyV3hJMGRKWU5oV3ArT3hNZ2tUczZlOElx?=
 =?utf-8?B?MG1Ra2xHbW5uWDZPMHFldDA3bHlzYWd2UWhsTGF6NFgyNHM3RGcxaU5ZTEs4?=
 =?utf-8?B?eFZLdGlFNHdBOVF6YlloMHI4eWtxZFJ5eDROOUpDTFY1T1BjcWlyQWRsSFJ0?=
 =?utf-8?B?SmNyOGx3a1ArVXk2VzVtSjdpWWZWZ3p0SmVXS2ZWMkVvdldFRGdqc1Z6ZDMy?=
 =?utf-8?B?TGlHbFVwM25SeFlzWCsydGcvTUd6TUIzSVpnRVlyOHRKS2xLSHYwVGpuZVkx?=
 =?utf-8?B?WHE0em8rNEN0aGZqSldwbmFkWXZSa3dBaTcxejJ2d2RQY2l6VG9KcEVEZ1h1?=
 =?utf-8?B?TTNmT0FYQTY2OFloVWF4SXJzOFNRZmJ5NmxvUFJZb0FlcXhSdXE4MWtuWVVB?=
 =?utf-8?B?Y0ZaOGc4Ym0yVkdiTUZaSTQ4K1E5elVsNk9JcHJ1S1hXb1dJcjZTcUNKN25Z?=
 =?utf-8?B?MUdCMi8xMVFHWCsyaUVQdWlNRDk4dDczbjBISGwyTURkTk96QjNNbkNrZU9y?=
 =?utf-8?B?R3Q5Z3dYVWlxZ2FDeDh6amdIOHltYmNTWkVIdUgzbEs3WTNTWm90MklFUW0r?=
 =?utf-8?B?eTc2R1lGb1hITEk4TmN1MjVYbWlYaUorbkpqRW1SSks2OWY1R3YrelM1M1Nv?=
 =?utf-8?B?bXU1dlRrbHlJOE9oY2E0WFRzU0M3UXoyYXpmNGttWFZXUEp2SFpxMHhkK09F?=
 =?utf-8?B?SVhYSmNnekorL0JCR21nNzNuUnhYVFh1Y1pyUXBGc1RlRkRuOXE3UFJaUFFJ?=
 =?utf-8?B?YmJSNmUxM3hnbVFxK1d2c0N0eDdsdmkvNytQUCtueFBUaTJQZTBhUDFRcGhy?=
 =?utf-8?B?NlpqQjZtVk9zczlTc1NRc0RJOGxvWWJ4M3B3U3FpNHQvQUZidy9SbTNOaENS?=
 =?utf-8?B?VmtDdUtreXdrVW01ckJwcGl6TTN6SHdsUkdjdGZMVFhMZS80R0lTSm9zUGRa?=
 =?utf-8?B?d0NjVHNOQjR3OFduTS96ditwdTdXd1lTOS9wRVJSbElTOHZvbStLcEhEUlkv?=
 =?utf-8?B?UWM2eDFvRXcyOWZReVRUL2s5V3htSnQ0VEhLY2FuQUZlelN1TFpRSW9SYVJK?=
 =?utf-8?B?T2RZS1BDZ250ZkhVVG5TVFFjakVTTXQwVFl4akJheHcvMVhpUlgxaVpjdEsy?=
 =?utf-8?B?ZGR5VlNMUThXYW1NUVNuUlNzdmRUVkF1RnROUXYxZE9aY3R0VlJiT2xWNFdq?=
 =?utf-8?B?NkZMRHZLWFF5c2hvY2xQbktqaGNzckpVeWZpVXVtMWdTVlNPcHA2SHJQdWJi?=
 =?utf-8?B?SlF6cTlNOVQ0a3lpRFk3b2lodmV6TGdJWVQ4ejQ1WUVTbm5IR0pSKzZhOCtV?=
 =?utf-8?B?bmp6R1FNMlBTT0NmbWVIMTVCa3BiQng0R3ZHZjRsN0xUbTU3cm1aaUI3NElm?=
 =?utf-8?B?MXlQbzgwSStuaVh1aFZMYzFNSzIrNlp6MndkU2NFek5GSE1FN2cwMlhVMWJG?=
 =?utf-8?B?Z2t2TC9iVW9QazZwdzlkVjNtZVNSOWNUQzl3WThaSURmT1JvMDVqTmE4Q1RM?=
 =?utf-8?B?RXcrMUgzN3BGODFaY0o1d1pTaUtNem9Dc2pGZjJUNHdrOVhKSGhRWWRVOHVG?=
 =?utf-8?B?UVRSNTBCYnpSbW5QUWFMK0VUa2ZGQjlMMGF3SmlITE9kRE1SN3Y2KzFKeTB1?=
 =?utf-8?B?b2lzcUpaYm1yaGdyV0RYM2F3UlNOMzhNNmE4UTdsb2hhOXN2aFIyUUpsdTlS?=
 =?utf-8?B?UUl1Q0w1bFdxN3NxNTVXYTNzeFB5WnRpWFVCc1VpYUVQejBDUFRxVDRGN3Fo?=
 =?utf-8?B?UjFuNE45bTJvS3daaE53OUgySHJGY0pORXI5ckNWdm0vMVBMeDMwWWVGQ3Aw?=
 =?utf-8?B?R0svaE9YVXFaNklYUVFZSmZkVVNxcGhXUk16UHBaT3VxUEVxNS8wVmFRYjJC?=
 =?utf-8?B?VEdRUHcwOUhGNmplM2lwRHU2OWFXZE9NWnRjeGRUQ0dCSGhMQ1hRTWt5VDN1?=
 =?utf-8?B?YzMrOFBOVGRDbDFVMmpOMXlLYWpCUlcrMEV3U0tsNS9xaWxCTVlPUFNuYUg1?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5093481-88c9-4491-36ae-08dc819def93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:17:31.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1s4CnEb0GQRh5SC/fIOftyY3sZ49fslSnxe5XfDK/pSMDinZK6J5XIAE0bk/YeY89lBUn13Odj+IxJFB1SK+XoN6esLYQSjuHPJI+JVSus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/31/24 6:11 AM, Ilpo Järvinen wrote:
> A few functions receive PIDs through int arguments. PIDs variables
> should be of type pid_t, not int.
> 
> Convert pid arguments from int to pid_t.
> 
> Before printing PID, match the type to %d by casting to int which is
> enough for Linux (standard would allow using a longer integer type but
> generalizing for that would complicate the code unnecessarily, the
> selftest code does not need to be portable).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

