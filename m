Return-Path: <linux-kselftest+bounces-33771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B406AC3C5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6633B72A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14381E8324;
	Mon, 26 May 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqcnSqxO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423621DFDBB;
	Mon, 26 May 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250471; cv=fail; b=t/2j0FfCJs182ZmuOi/FXUDZ1NnbX9hWmFoLHANIM8Mawu8VD8TiDCZ9YVRoyLsf1G1oZhyLFXkJgT51W8eEvVHNaeHVxxHrtgNOJsqEDQkVmPzeHcYABg3bylbXfPjtjZQVMK5bjihmO3i9EJMkNE9uEZYnVbAWy/1Zz+9eZYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250471; c=relaxed/simple;
	bh=LWP9QfdB/l3McTolMVK+1wxg9IJWAgcrTqLVc7ztkuA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gGsoZgRTZRHmeAsqShJcOjQXr6hrs+NkT0Yn+8y4pfq3s7CKS0pz31Yy/2xXy1OpBDsj/w39tjBp4qt6DViFIYYXhJCRvtgxOkUzZUci8tVUG367LlW1YmG15q4EiwkDKzCRNMuHj7AKx45AJMEghIzNdq6/Wk3ODcPVZW3RPmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqcnSqxO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748250469; x=1779786469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWP9QfdB/l3McTolMVK+1wxg9IJWAgcrTqLVc7ztkuA=;
  b=YqcnSqxOtpTHvTmlmq4VGx5ZvfOvKI17Y0HT3zN1MLj83PHVaMvAAWuW
   2ZCC2sd+EChX17OPGnwu9mOVPxMmuob2L52xDl+ubf1SEuiQaZEVBdFx4
   GsX5Tw+Kdj7ixMfCtQijDIEDyj4/SjW0e+hATYCgBbDF6lx/ldkzFSXwb
   WSPvFDKzjeXAJfWCRG0FHDzGpdBldMJhKGeAZjQS1D1GEYP23h23TCWMJ
   K1zZzUfst0zIt3HepUaV42KqhBLZxLczYbQP+yTwmsL08+w/L4rMHII4d
   Tdkph1Qs8+X2mhmVopw0xd+qa1t7LWCLJUvRqE59yITFcqQIQzxodPVao
   g==;
X-CSE-ConnectionGUID: n3Nq2NoQQ+q6FigczK4mkA==
X-CSE-MsgGUID: ItAlfvOCSZGUsn5dHUvdhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="49332914"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="49332914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:06:46 -0700
X-CSE-ConnectionGUID: dKDtuu1FS3qZTviOkpX25Q==
X-CSE-MsgGUID: DESbDpi2Rm2b2SS6qIZh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="173209310"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:06:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 02:06:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 02:06:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.81)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 02:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSKQ7ywPYtgzYav331i5tiEIuQNC0w0VQoz0SASqREHtfFHQ+BcIeCB93vcGzB/oahUjLDhFTAzUrJ+VKBb3JObC3Nva4INyAaTG1OpFzTE5GsgYwNPqaXQ1xx+3XlDGvoTOHAaIOC4vH5eOrXuWthaEcnJo4L8TawAk6IhlJm2zAJKKu5J1N00FK7Kl3N7FiW6q5kzaZAUOiBO6HofZIWAaqZuRdueUfJbAEO7PZ4n9ZOyWhHFpqxGcMS4Q2gVDdboLgDD36l6KeW7uA3hn9J8bnCtRF7nPbH7P3iugsX8cyLD3m+4mLWOGFTvBEZ+Vexd8+nKyscUZyxL7s+YARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L+QQFICxXtJxMPX04R4NZ7wbirIq0ZPJVMgyJkBaGY=;
 b=VoPWIbyluPpZZjat075/Irc/nIO+XZLymf9r8R7kHL19sj6Yk7uM3+zRnt0wOWiwHblYg7MQqD8Bgzs1PuIifYp68yF4qaO49CyXtrcGBRuivTegfJWq0XUMd9/6QQNIYMGoLIUYBQuhxBGacCKkmYIm8kuJUufFT+RysqFIir9hc47qv5xJZ6YLvteDdSlJd+hfcBnRBaHM1xe1G04uizt7g6mVoXhGDEl1bKeKi+urLUK901kI6PXgVjRecjF0IdhLRKfWQS4KyWwW0Jw2Lw4hXMve2nznvfD+Chh6EiyyG1BiAyl8yUmfQjUKsE9bINY1v9eztrz5LtG1vzu0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 09:06:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.019; Mon, 26 May 2025
 09:06:26 +0000
Message-ID: <a2149117-7b52-4d18-8eb0-baf14e80ee06@intel.com>
Date: Mon, 26 May 2025 17:12:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
To: David Matlack <dmatlack@google.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Vinod
 Koul" <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella
	<adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, FUJITA Tomonori
	<fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, "Sean
 Christopherson" <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger
	<eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma
	<vipinsh@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd8ef89-e368-4f6e-aeea-08dd9c349855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWNteWtUQnlZWTJoWGdxRnF1dStDaW1WcjZtOTNRUzBTZlBSQ3VjdmJEam9M?=
 =?utf-8?B?UjN5aEkvL2JwMnZJaDV0djFDczZ5T3duUkZUcGtydEVRL2NJQmFNcmdua3B4?=
 =?utf-8?B?cGJJbEp0bVNZV3VISkhLZDdXYkQwUkZTclViRDJWdWRWdVhRdDk4NUQ0KzJR?=
 =?utf-8?B?S1M2Q0lzU0I4NjVXZTRQLysySVNvOWlNRTk0ckxZd05JbHgyendPOUlKbHVW?=
 =?utf-8?B?dHdOQ3NOclhzUmFBdUNBMGY0YjRCMy9Pd0JGUTV2R1V2TEZHWjROSWQwVHpo?=
 =?utf-8?B?S1BDVEk3THJhOWFQK2lnS0xkYlJUczdJU1dobEk4dFY3Y294Z3ZoUXR1elpv?=
 =?utf-8?B?MTUvWGF2SHk5am5WQTFYOG9mWStXRXZJYzF5N1g4V3Q1K3cvTzYzMlB2aER3?=
 =?utf-8?B?bkR3bU9xTCs1TzRKbGRqcU5aRnoyQmx1T2phVUpTR0dqMU9nUGNkSHJCT1Y4?=
 =?utf-8?B?UWhrZlovME5wc3JJZEpmemxsSEhqZFNXRXR5cmErVkx1SGRpd2pueGxEaFk2?=
 =?utf-8?B?bkUrUU1qck03eVROdnNQU3Y4OFNRbWtGYTh1S3MvRzBXQmhmV290Q3pDWjZs?=
 =?utf-8?B?S1pUZU0xdEZsZnVoMlVKeFNlVFVhWjN2WDRrTklJTWRBOENaU2JScldrb2p6?=
 =?utf-8?B?Ri9qUkVwSG51RGlSYXNHWk1kczdGL1dOYUprc1RMWFVVMVROczk0cWNrV3Rv?=
 =?utf-8?B?eU1FeWl0N2l3Yko0TTlNOEtsWFBOcURLR2NXVmZTREJtRlFSNTl1K0k4aXFz?=
 =?utf-8?B?ME9PdUI0SVVaaWFjZWh6Q2VjNitMY2ovMnU4bjIvVDZMYkIrZDJHTkxNM0R5?=
 =?utf-8?B?UERhVTJqb1UvVVJmbDVQRm1FeHM3ME5MWTdFZU1UMS9zNDhuaFZudWQ2bTRI?=
 =?utf-8?B?TDAwRnFVSEJsb0kwZWhYSUpNQWZQVjByZUp0ZEM3eUJkT0hpNzBVMldYalR2?=
 =?utf-8?B?aWZVaEYyN2tORHZGRUp1dktVUFBmN1Q1QkM5R05sQWdWM1ZZZ2lUNDhFaCtJ?=
 =?utf-8?B?aE9idkNYS2srZ2YwQUZnc0pKWUlOTERZY2tzVkdNdXNleGIvQkZlWWhHOHA0?=
 =?utf-8?B?bTRRZzJyaTViYmZGaVZoakUvQmdkRDBsdGdnQisrdVJzU0M1czQ2R1FUYnZK?=
 =?utf-8?B?bmRUTDM0ZHg3UytJN0JteURPK05DeDZvNWxRNEFySmVnZFZJSXRRYzlPU0tJ?=
 =?utf-8?B?aldwd0lTaHRjelViZ25sN0ZmU0ROQm5HSUhTUlJObWxZTjF0NWd1T0d4ak5o?=
 =?utf-8?B?NTlIWXA2QW8zRWlIYWZtaHZNK3djRzRCemo3clVHMDlqVWdPOWdBNDA0OGxD?=
 =?utf-8?B?Q1I0Z2RkaGdCK3M2b0ZNaUZEM0g0UWFGYVBPcnlKQzdPa3lhREhLaC9QRGxD?=
 =?utf-8?B?RGw3MXM3MXYxdXBVVmpBWmJ5SW9ocGo5ekZmaFNod3hyTHJkMllqQVBzOWx0?=
 =?utf-8?B?emdzM0RReG04TmMvMEM4RU9Wd3JuMHQ5bmYxMUp6UitsTTd2RGZxTjgvc1lR?=
 =?utf-8?B?WVZ4SDA3ektIaFBIMFRzQzNrdjUwTUt1enJnUElaL0cyaDAySERMOVhjcGJq?=
 =?utf-8?B?L2RCZ0JSWmhrQlRZb2xGMlFxVHVaYVhMSitIV0UvaGpxY3hFamxpMzQ3Y0JF?=
 =?utf-8?B?NytJS2xUcWQ4TUd1M0dHSGhFelIrWEI0VmJVWGk3M1FodWF0NGtKWXVJWS95?=
 =?utf-8?B?QjF4eG1wdGlLaHdHZVREb0dpeWRCZDEvWjhqUW1wSmtBb0lTS1JHUElaT0lx?=
 =?utf-8?B?V3RxdXZ0R0JiUlI1WHUzdEl1YjNCMEJJd0cxbDlmcmVFbmVpS0pObDYza0xu?=
 =?utf-8?B?b3I0SklxV2dBTFV3S0FzR3E2K0h6NTlReGpGL0ZVSmxRWWVYS1YrYm9ZUisz?=
 =?utf-8?B?ZkMvZVQvV2Y3UTBaWlF6QkN2LyttN0Izd3RwT1ZPWmxNendkUHZUTHU5N2do?=
 =?utf-8?Q?+6rFhgPbLVaFgMud3MHPWrQnvN2SWoJl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm9FbVR4ZENseDU4NVNXQ1ZHeHBNL0duWTZ4NjZvL0loaGFMWWZlbWcrcXdB?=
 =?utf-8?B?eC9xbTh5TmlvdkRHc2NqZ2RSQ2YwaFlNTEtOWXRZZzlIekhWQTNqSXdqSGly?=
 =?utf-8?B?Y0k1M0Y2VUJLcElvRTNheHNTb1VUcG5DUzJpeUhOSGsyUXJHaWYwVGN6NFFB?=
 =?utf-8?B?NE9sbGVRSHpETXdmYkpPb2NIU2c5Ylh0cjk5Tm5GaXVVTVZLSXUwbHpRZjNn?=
 =?utf-8?B?d21XUWcxNDRNWm01Q0NueHh5Qk41cWQzTkdKRVpxRnJhZE1mVlZtYzA1R2Fq?=
 =?utf-8?B?d2lCYUhta0c2cThwV1BhS1pmR0pzbFFZYVVueDdpMmZnKzF1dnFMWE9XV3Ax?=
 =?utf-8?B?aXNqTlIxcnpQUDNnYTRhZ250ZTRwOE1wM2FJUnE1cVFXZ3VXOFhoS0h4OWcv?=
 =?utf-8?B?cXVDRkQ2cUQ1b3gxNzVzVjN0U1lJdCtObEN4b3ZyUHJ6eHJQSEFXVHE1OWNC?=
 =?utf-8?B?bVNaYTBjT0pKWGlRUUE3NjBxc0xMVTB6RTd4SWFhUXRtSkg4OFpUNGloem1q?=
 =?utf-8?B?OWJDMkFQMDQ2T1JkU1NFZFZwK1pwY1RPSVdFUnN5RDRLaUZJRmJoTkpmMUwy?=
 =?utf-8?B?QjBiV0xhb3pDa2EyS1RDbU9RcXAwaU92OXZXZWZjcmxyUVBldXBTV2M4Q29z?=
 =?utf-8?B?WjdGYUYraTNzYTBBVTFrZjRJVk8va3o3c0RVMTVQek9OUWYvbkRaS09paGJJ?=
 =?utf-8?B?bDYwaEMzcUdRU3hFN0EvRm5wTXd0WTZnbzUzajNkdHE0VElPSVptOWxnOUl4?=
 =?utf-8?B?MmFBVjdvalpvdFFQL056SHFWNnc3NndxS1RQZy9iRUhwUUZzQU1BMUwzS25W?=
 =?utf-8?B?NTR4QkdySCtFaXI3cGFOQXBsN2Z0b0k4VXV5ZzVTTkJOMzZrNjhPdEV4V01k?=
 =?utf-8?B?S3FnN2YzeUs2VzhSMVZkdjRCVHo5V1NPN2NFRFpDMnd3QytvZHdSL3AvNlJO?=
 =?utf-8?B?RFk2c2tDTHR2L0h5SzExUW1NRTNRbWhGdDYyNTlDMVN5V1dtM1NRd0lzalVj?=
 =?utf-8?B?djJUR29NaStiVzVCOGZXTG9xZXg3alRKUWlqd2FCUDhlM04wK0ZGZHB1L2tu?=
 =?utf-8?B?b0UvRnd0VzFWc1FGeG8vbUhQQWIzUnQrWVJyMUUxeGNhVithRXBSbzZFeGx0?=
 =?utf-8?B?SU1DcmxCRXBaMU0xTXVsZEtYWkpzWHdTbnBldWRRN0kzb0pHZ2pBa2RTQURG?=
 =?utf-8?B?amxzMkR2WjNGUUxlMmJFZE8zS1g1QjlRRGhvMVZLZWoxSnRObWtKSG1FdkhX?=
 =?utf-8?B?cFBpYVdFWVpBVFE2bnlxU2ZxZXBwQ3pGTjBDSk1LYTlDRUNZelhiRll4cVVQ?=
 =?utf-8?B?bG1oQUlLNEZwM3ZvcjdxdGVybXlKc3d4UlJkdHFTTFRpc0V0OWNOUTlaZGpV?=
 =?utf-8?B?VlNVd0I3U1pqVFd6SWQ3YWcwM29RdTAvSzFHbktKZkxBblhXRDBWNVdKcmEw?=
 =?utf-8?B?YVh6ZlhidEllVWxDeHR0OG9ZZmtVUHhSVGZOK05vVE1YY3NWZ25VdUIvN0Vp?=
 =?utf-8?B?L1pOaFFUcHRwMTVDbWVzaFEvSDcwdWxtWldWMlVDWTcrY1ZHTi9UZTU2TFhZ?=
 =?utf-8?B?ZDhvTmlYb092UG1XZmJzMTVOb0I2VXBDZ0dhc21TQU0ybG5UVDNlRkI5L3V2?=
 =?utf-8?B?dCt2cXZ2VzQwdjZJdlVYcFJ6M0cxSjBkditHbCtUUGNORWh5eXI3eGFoNU1m?=
 =?utf-8?B?YVU0VFlOb2d1VS9ObExPVitEUVpXdFVwUVhnRlZrbERlc3FkTDQ4c21rTm1a?=
 =?utf-8?B?MW9iNXNVRkxTU3VqaWpFdnczZ1RXUkRINmJtRVk5akM2UGxteSs5cTU4U0Z1?=
 =?utf-8?B?amJSSFRVUkNqT1JSYi9TSFc4Y1hpbEo4Vzg1aUR4S1RGQVMybFdsK3hraGUv?=
 =?utf-8?B?Rk9LTVRxUFNaTzdjQXgzSzV2SjNJd1RRMWhuNExqSXZhM1M1L3g2WDNFM3Zx?=
 =?utf-8?B?dXhhdVJ0OU9YK0M4NzY3MVZDUTZ5UThhVjVzbzB5WjBoeGRtL3VjMlNnUktH?=
 =?utf-8?B?TDJ2T2dtVmptVi8xMlRlU2lTbkFHRTZldVp6a0Q3VVFab1M3bGJzdFJZbWI3?=
 =?utf-8?B?aGg3Q0N6UFp3d2ZTdU1heDhwd0pQckxWQU1xV3liMDFZbXFpOGpVL0ljNjZB?=
 =?utf-8?Q?+/gV2YeKYrFoqJRYTNaBAddeO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd8ef89-e368-4f6e-aeea-08dd9c349855
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 09:06:26.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO3CLW6eJPyhbFkQ4yXgWecoCzv6ToGOwCuiBz+0TyJyWtBRjjNaovBGcyQpHQxhruLSUdPvq/ANND9geIp44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com

On 2025/5/24 07:29, David Matlack wrote:
> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.
> 
> VFIO selftests aim to enable kernel developers to write and run tests
> that take the form of userspace programs that interact with VFIO and
> IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> new features, regression tests for bugs, and performance tests for
> optimizations.
> 
> These tests are designed to interact with real PCI devices, i.e. they do
> not rely on mocking out or faking any behavior in the kernel. This
> allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> driver, interrupt remapping, IRQ handling, etc.
> 
> We chose selftests to host these tests primarily to enable integration
> with the existing KVM selftests. As explained in the next section,
> enabling KVM developers to test the interaction between VFIO and KVM is
> one of the motivators of this series.

interesting. Two quick questions:
1) does this selftest support all the vfio iommu drivers (typ1 and 
spapr_tce)? Maybe also the iommufd vfio_compat as well.
2) I know Alex has a test suit as the below. Has this series referred
    it?

https://github.com/awilliam/tests/commits/for-clg/

> Motivation
> -----------------------------------------------------------------------
> 
> The main motivation for this series is upcoming development in the
> kernel to support Hypervisor Live Updates [1][2]. Live Update is a
> specialized reboot process where selected devices are kept operational
> and their kernel state is preserved and recreated across a kexec. For
> devices, DMA and interrupts may continue during the reboot. VFIO-bound
> devices are the main target, since the first usecase of Live Updates is
> to enable host kernel upgrades in a Cloud Computing environment without
> disrupting running customer VMs.
> 
> To prepare for upcoming support for Live Updates in VFIO, IOMMUFD, IOMMU
> drivers, the PCI layer, etc., we'd like to first lay the ground work for
> exercising and testing VFIO from kernel selftests. This way when we
> eventually upstream support for Live Updates, we can also upstream tests
> for those changes, rather than purely relying on Live Update integration
> tests which would be hard to share and reproduce upstream.
> 
> But even without Live Updates, VFIO and IOMMUFD are becoming an
> increasingly critical component of running KVM-based VMs in cloud
> environments. Virtualized networking and storage are increasingly being
> offloaded to smart NICs/cards, and demand for high performance
> networking, storage, and AI are also leading to NICs, SSDs, and GPUs
> being directly attached to VMs via VFIO.
> 
> VFIO selftests increases our ability to test in several ways.
> 
>   - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
>     test their changes against all existing VFIO selftests, reducing the
>     probability of regressions.
> 
>   - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
>     include tests alongside their changes, increasing the quality of the
>     code that is merged.
> 
>   - It enables testing the interaction between VFIO and KVM. There are
>     some paths in KVM that are only exercised through VFIO, such as IRQ
>     bypass. VFIO selftests provides a helper library to enable KVM
>     developers to write KVM selftests to test those interactions [3].
> 
> Design
> -----------------------------------------------------------------------
> 
> VFIO selftests are designed around interacting with with VFIO-managed PCI
> devices. As such, the core data struture is struct vfio_pci_device, which
> represents a single PCI device.
> 
>    struct vfio_pci_device *device;
> 
>    device = vfio_pci_device_init("0000:6a:01.0", iommu_mode);
> 
>    ...
> 
>    vfio_pci_device_cleanup(device);
> 
> vfio_pci_device_init() sets up a container or iommufd, depending on the
> iommu_mode argument, to manage DMA mappings, fetches information about
> the device and what interrupts it supports from VFIO and caches it, and
> mmap()s all mappable BARs for the test to use.
> 
> There are helper methods that operate on struct vfio_pci_device to do
> things like read and write to PCI config space, enable/disable IRQs, and
> map memory for DMA,
> 
> struct vfio_pci_device and its methods do not care about what device
> they are actually interacting with. It can be a GPU, a NIC, an SSD, etc.
> 
> To keep things simple initially, VFIO selftests only support a single
> device per group and per container/iommufd. But it should be possible to
> relax those restrictions in the future, e.g. to enable testing with
> multiple devices in the same container/iommufd.
> 
> Driver Framework
> -----------------------------------------------------------------------
> 
> In order to support VFIO selftests where a device is generating DMA and
> interrupts on command, the VFIO selftests supports a driver framework.
> 
> This framework abstracts away device-specific details allowing VFIO
> selftests to be written in a generic way, and then run against different
> devices depending on what hardware developers have access to.
> 
> The framework also aims to support carrying drivers out-of-tree, e.g.
> so that companies can run VFIO selftests with custom/test hardware.
> 
> Drivers must implement the following methods:
> 
>   - probe():        Check if the driver supports a given device.
>   - init():         Initialize the driver.
>   - remove():       Deinitialize the driver and reset the device.
>   - memcpy_start(): Kick off a series of repeated memcpys (DMA reads and
>                     DMA writes).
>   - memcpy_wait():  Wait for a memcpy operation to complete.
>   - send_msi():     Make the device send an MSI interrupt.
> 
> memcpy_start/wait() are for generating DMA. We separate the operation
> into 2 steps so that tests can trigger a long-running DMA operation. We
> expect to use this to stress test Live Updates by kicking off a
> long-running mempcy operation and then performing a Live Update. These
> methods are required to not generate any interrupts.
> 
> send_msi() is used for testing MSI and MSI-x interrupts. The driver
> tells the test which MSI it will be using via device->driver.msi.
> 
> It's the responsibility of the test to set up a region of memory
> and map it into the device for use by the driver, e.g. for in-memory
> descriptors, before calling init().
> 
> A demo of the driver framework can be found in
> tools/testing/selftests/vfio/vfio_pci_driver_test.c.
> 
> In addition, this series introduces a new KVM selftest to demonstrate
> delivering a device MSI directly into a guest, which can be found in
> tools/testing/selftests/kvm/vfio_pci_device_irq_test.c.
> 
> Tests
> -----------------------------------------------------------------------
> 
> There are 5 tests in this series, mostly to demonstrate as a
> proof-of-concept:
> 
>   - tools/testing/selftests/vfio/vfio_pci_device_test.c
>   - tools/testing/selftests/vfio/vfio_pci_driver_test.c
>   - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
>   - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
>   - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
> 
> Integrating with KVM selftests
> -----------------------------------------------------------------------
> 
> To support testing the interactions between VFIO and KVM, the VFIO
> selftests support sharing its library with the KVM selftest. The patches
> at the end of this series demonstrate how that works.
> 
> Essentially, we allow the KVM selftests to build their own copy of
> tools/testing/selftests/vfio/lib/ and link it into KVM selftests
> binaries. This requires minimal changes to the KVM selftests Makefile.
> 
> Future Areas of Development
> -----------------------------------------------------------------------
> 
> Library:
> 
>   - Driver support for devices that can be used on AMD, ARM, and other
>     platforms.
>   - Driver support for a device available in QEMU VMs.
>   - Support for tests that use multiple devices.
>   - Support for IOMMU groups with multiple devices.
>   - Support for multiple devices sharing the same container/iommufd.
>   - Sharing TEST_ASSERT() macros and other common code between KVM
>     and VFIO selftests.
> 
> Tests:
> 
>   - DMA mapping performance tests for BARs/HugeTLB/etc.
>   - Live Update selftests.
>   - Porting Sean's KVM selftest for posted interrupts to use the VFIO
>     selftests library [3]
> 
> This series can also be found on GitHub:
> 
>    https://github.com/dmatlack/linux/tree/vfio/selftests/rfc
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Josh Hilke <jrhilke@google.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
> Cc: Parav Pandit <parav@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> 
> [1] https://lore.kernel.org/all/f35359d5-63e1-8390-619f-67961443bfe1@google.com/
> [2] https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com/
> [3] https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
> 
> David Matlack (28):
>    selftests: Create tools/testing/selftests/vfio
>    vfio: selftests: Add a helper library for VFIO selftests
>    vfio: selftests: Introduce vfio_pci_device_test
>    tools headers: Add stub definition for __iomem
>    tools headers: Import asm-generic MMIO helpers
>    tools headers: Import x86 MMIO helper overrides
>    tools headers: Import iosubmit_cmds512()
>    tools headers: Import drivers/dma/ioat/{hw.h,registers.h}
>    tools headers: Import drivers/dma/idxd/registers.h
>    tools headers: Import linux/pci_ids.h
>    vfio: selftests: Keep track of DMA regions mapped into the device
>    vfio: selftests: Enable asserting MSI eventfds not firing
>    vfio: selftests: Add a helper for matching vendor+device IDs
>    vfio: selftests: Add driver framework
>    vfio: sefltests: Add vfio_pci_driver_test
>    vfio: selftests: Add driver for Intel CBDMA
>    vfio: selftests: Add driver for Intel DSA
>    vfio: selftests: Move helper to get cdev path to libvfio
>    vfio: selftests: Encapsulate IOMMU mode
>    vfio: selftests: Add [-i iommu_mode] option to all tests
>    vfio: selftests: Add vfio_type1v2_mode
>    vfio: selftests: Add iommufd_compat_type1{,v2} modes
>    vfio: selftests: Add iommufd mode
>    vfio: selftests: Make iommufd the default iommu_mode
>    vfio: selftests: Add a script to help with running VFIO selftests
>    KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
>    KVM: selftests: Test sending a vfio-pci device IRQ to a VM
>    KVM: selftests: Use real device MSIs in vfio_pci_device_irq_test
> 
> Josh Hilke (5):
>    vfio: selftests: Test basic VFIO and IOMMUFD integration
>    vfio: selftests: Move vfio dma mapping test to their own file
>    vfio: selftests: Add test to reset vfio device.
>    vfio: selftests: Use command line to set hugepage size for DMA mapping
>      test
>    vfio: selftests: Validate 2M/1G HugeTLB are mapped as 2M/1G in IOMMU
> 
>   MAINTAINERS                                   |    7 +
>   tools/arch/x86/include/asm/io.h               |  101 +
>   tools/arch/x86/include/asm/special_insns.h    |   27 +
>   tools/include/asm-generic/io.h                |  482 +++
>   tools/include/asm/io.h                        |   11 +
>   tools/include/drivers/dma/idxd/registers.h    |  601 +++
>   tools/include/drivers/dma/ioat/hw.h           |  270 ++
>   tools/include/drivers/dma/ioat/registers.h    |  251 ++
>   tools/include/linux/compiler.h                |    4 +
>   tools/include/linux/io.h                      |    4 +-
>   tools/include/linux/pci_ids.h                 | 3212 +++++++++++++++++
>   tools/testing/selftests/Makefile              |    1 +
>   tools/testing/selftests/kvm/Makefile.kvm      |    6 +-
>   .../testing/selftests/kvm/include/kvm_util.h  |    4 +
>   tools/testing/selftests/kvm/lib/kvm_util.c    |   21 +
>   .../selftests/kvm/vfio_pci_device_irq_test.c  |  173 +
>   tools/testing/selftests/vfio/.gitignore       |    7 +
>   tools/testing/selftests/vfio/Makefile         |   20 +
>   .../testing/selftests/vfio/lib/drivers/dsa.c  |  416 +++
>   .../testing/selftests/vfio/lib/drivers/ioat.c |  235 ++
>   .../selftests/vfio/lib/include/vfio_util.h    |  271 ++
>   tools/testing/selftests/vfio/lib/libvfio.mk   |   26 +
>   .../selftests/vfio/lib/vfio_pci_device.c      |  573 +++
>   .../selftests/vfio/lib/vfio_pci_driver.c      |  126 +
>   tools/testing/selftests/vfio/run.sh           |  110 +
>   .../selftests/vfio/vfio_dma_mapping_test.c    |  239 ++
>   .../selftests/vfio/vfio_iommufd_setup_test.c  |  133 +
>   .../selftests/vfio/vfio_pci_device_test.c     |  195 +
>   .../selftests/vfio/vfio_pci_driver_test.c     |  256 ++
>   29 files changed, 7780 insertions(+), 2 deletions(-)
>   create mode 100644 tools/arch/x86/include/asm/io.h
>   create mode 100644 tools/arch/x86/include/asm/special_insns.h
>   create mode 100644 tools/include/asm-generic/io.h
>   create mode 100644 tools/include/asm/io.h
>   create mode 100644 tools/include/drivers/dma/idxd/registers.h
>   create mode 100644 tools/include/drivers/dma/ioat/hw.h
>   create mode 100644 tools/include/drivers/dma/ioat/registers.h
>   create mode 100644 tools/include/linux/pci_ids.h
>   create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
>   create mode 100644 tools/testing/selftests/vfio/.gitignore
>   create mode 100644 tools/testing/selftests/vfio/Makefile
>   create mode 100644 tools/testing/selftests/vfio/lib/drivers/dsa.c
>   create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat.c
>   create mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
>   create mode 100644 tools/testing/selftests/vfio/lib/libvfio.mk
>   create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_device.c
>   create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_driver.c
>   create mode 100755 tools/testing/selftests/vfio/run.sh
>   create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c
> 
> 
> base-commit: a11a72229881d8ac1d52ea727101bc9c744189c1
> prerequisite-patch-id: 3bae97c9e1093148763235f47a84fa040b512d04

-- 
Regards,
Yi Liu

