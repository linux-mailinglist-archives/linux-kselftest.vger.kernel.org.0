Return-Path: <linux-kselftest+bounces-23614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CB9F8355
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375BB7A272F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0531A071C;
	Thu, 19 Dec 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHEdbtLk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104B35948;
	Thu, 19 Dec 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633370; cv=fail; b=BHuF5C50HxD+wKWKMd5rfi7EcTp9HTq7/DswYTHVPbsTcKRAJLrKvwn6OsLwrhJhij0zfF9iN/fIZ9DbLZu12+5BnJMmrZipJwVzbfbe1asFnDfD1tYx70ugROlv8oyJWca9OYAHytaUmhBIzNrdY/NYdgHq0mHjSHBHiaGl1x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633370; c=relaxed/simple;
	bh=ftjVbQks7KN1C1szNEmTavAchX7RX6OeKALlycn+Is4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LS0s+zttiqeZiIZBENe7jrRvsJvWm1nV2ttkXaYID8vq3wuaiZyGfKYzKkyuRW4OBDKm5LCPZ3cpDRDuroMi1BmZKT2GEoMMH/juN2ItiUOnHO6bqGFC9X2jvJhW8+joBC8uBIzxO52WVZ4mLVEuo8Cq3N1pXW1Q7aJ6l4mgzbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHEdbtLk; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734633368; x=1766169368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftjVbQks7KN1C1szNEmTavAchX7RX6OeKALlycn+Is4=;
  b=DHEdbtLkf1FhiH1cRCeCf1TrOVR+a6oixc4+8QSDklS6ryUMIoP7YkNm
   MyYpKKjL3B2dwHftOaG2B1c0Jruxt5y3Zb8wPAeSAdDCrJ8UVEWrrL9i+
   /mY8mwT7m33kg+0JJujFfJZPBQwiniPipZejQAum7Q6pxm01eHlUK5bMe
   cqNcSLbdhuv8dyems1l3BDdx1Lk5gdBufKcE7l/1LiY/85eqboeOHr7Kr
   nMj9OORUATINpd1hlfiQ0K5o7JIoR5e+a/fY3JH+SlfvNWYZOLw4/1/sD
   65IZ9aPlFENpXN8AuFOCJ/F0xGf7VWhH/pZahOzukaaBMp7V20Yg63/Aq
   Q==;
X-CSE-ConnectionGUID: gtjYJTeUSS2y9qqBbbN/Pw==
X-CSE-MsgGUID: 3jKBzSHxTY2kJPLGmQ9pKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35383296"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35383296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 10:35:48 -0800
X-CSE-ConnectionGUID: uTrzkhypTcaG0zOLts32sQ==
X-CSE-MsgGUID: HhvF1+VUTNCULHiKx4P/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="103260867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 10:35:47 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 10:35:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 10:35:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 10:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjZEUe1erjKe+y7mkJfFwitlTiUtmVMXEm7xTu4r7kV/PLc/AH3LzBnhdvwQlfVzeMtggTeAxxZ7olKhV/NV+7LQnvO5zymgvbWadM0zajsZBgr8tGCed+SKpkm6zIyA2PEsKMRcwzim7Eym/oqfYvV8rbXb5lIoeWfB9T4rN/oL0VXMY07hoPrWcntV2XQGVph48++JEttGuUNZrBs3KsR4j115DPll+AFae3FSr6Ulnk5ZhPOB1KVUmRBw3vZ32bzTA3VUOcb9JW3A2bAzVpd8q1QYzbWbfjEaqOA/oAGux66j5M3Q8YXBJlahRhY0R25Zgq3emQxkkHK2rGT3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/d+2pQ1CORRWvL+h5yEZUG6f4AsiwijnnWDphNrKVw=;
 b=GR7EI3NpIFCtfqJuoybxAHQETfXcdJEvOse0Rwi+FtIe4rcEUtUQYGN1hCsOQZYDZczZk+GGptzy7nvQCebIpihg01CENwglHjcwWHXB306W6708Uws7WrQOeTYxhw1YXq2XLULNnnM7wB+8kBsvK+pcA/J5cbuFH3xVrjE3ldSQZBXYKqlniaWBwMw2mn0+tst5kwX72rzCP2Me0CWiL98ir4747MMV5GFREwGuhCdFnyqdf/4+I7fDWZ+zTnpL3wow7Y4i6Z3jrNZD50sEoy6MigyEK4O0u4yb5uLo/9tHW28oufKQ835f79j+XJaZSadCKMBI8hb3CKQsB+Jsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 18:35:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 18:35:16 +0000
Message-ID: <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
Date: Thu, 19 Dec 2024 10:35:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:303:86::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: d6349385-4716-46e3-9d8f-08dd205be226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpjdmwzUVhKYTJKaXZYT2t5YUhuQnYxem9kNUxlNmFEZEtCK3pJSXZMb0d4?=
 =?utf-8?B?M3l3NWdWWmtqaXJxZ0J3TzJKQkM0U20wWmtFbDVaRWFma1dYOTU4SXgwdEwr?=
 =?utf-8?B?ZFFSbVdZWlVWcGJzN0JnY3YvZ2pQZzBSenJzek1TTkFrcjdCRXRKUlpDN1k2?=
 =?utf-8?B?N2gvRXVzdG5rdmxCTXZGdnYwUWZqaGliY1c5VmxoOHF0S3hGRHZ4ck1KekFG?=
 =?utf-8?B?MkMranRXUW9zTitLRG83SlAwQmJKYnZnLzhyRnlnYWxrZ1YvNlJFTGpzRHlv?=
 =?utf-8?B?Sk8wSUpXdjJhNWFEMlo0dlZCZGFlSmloU0Vsell5WWtMS2w4STdsN1ZyWjlI?=
 =?utf-8?B?cWRPeTBpc25yTE9razdlTC9Ra0NDaHZ1RjVySFN2cEp0TEF1aC9Ma0Rxc1o0?=
 =?utf-8?B?RFlmK2ZHM3lwM3lEZXRldTErNnNoblQyVzltNnhobzdOcU1IWjNSK01KdHdM?=
 =?utf-8?B?U21XekFMczkweUV6NXVwR1pOaXpjVm1tbWhSRGxHMFNCODhoN2FyVWo3ZzVH?=
 =?utf-8?B?cVpmdjJHcFA5R1hvcjZpSUFwanV3ekdxQW0rQ3FjSi9pUGVhelRQTE5lRlZK?=
 =?utf-8?B?Q2dtaXFVRitWTmlpUFpveXZRVnlOY1hzNEVyWnVpSUNTcWN1NTB1MUZGQi9T?=
 =?utf-8?B?Zk5kWHliRjRMWGFvTlhoZWliR3NkbGsyb3ZuTEdDSnhha1RJMDFjbWhBcTYw?=
 =?utf-8?B?NEx5ODNMNU9Ta2V5eC8rbFpkcldDd1MxYmhaYUFhSVNFV24rdXdrN2MrVVJJ?=
 =?utf-8?B?MVdaMVFlUC9CaGtZZmdJc3ZhWWNIejczL3ZHdk9peCtRbjUrTHNoQW1jZDZZ?=
 =?utf-8?B?ZFBpNUwyVHkvTG9xSFJLWXdaUXI3SFRZWkNqVmZBOUliUUhXOEdlMzFqbWpu?=
 =?utf-8?B?a1R5NkcxckhMa1d3MzZ5TWFyUTRjYmRDd0ZVL1Bia0Znc3ZlR0MyLytMYUFt?=
 =?utf-8?B?ck16aTA4akJSUmticUtPRzFWWmREOGNEYzJETTl1MVNva0JuSk9DUEljMitr?=
 =?utf-8?B?bERTVjFmUnNScGZ3UkExbk1oL3JONFpVNi92TzNZVDNQNHI1dVdBYklsSm4z?=
 =?utf-8?B?bEZXbjRRWUJhNytiQmZiZ1RyVitWZ2ZtSklTbUFjVDUwK3cvRDBSdDh1OUFm?=
 =?utf-8?B?eXk0anpyY1JRRmZQcTMwc2F5WktzSkdhVjJia25kSnFuOXJ6S2c1YXpFZVN1?=
 =?utf-8?B?SUtlQ0tDMjlSRkw2RkdCdUEzZStCRnVQRTNZNzV2bHp5UkdlZktsWkRzTXlp?=
 =?utf-8?B?MXo3SkMyY0lPU1gwdUtBUWlUWkxvYW9PbEVsVTBtYmxoOERUZThMK2pic044?=
 =?utf-8?B?alhoWVVKa0FBNW91MnVuSCt2K0gvbFB6Szk2T01MNFZhK1phQ2ZkcTFlNVJI?=
 =?utf-8?B?N21CUG5ZTXNPcmVyUjQwbHduYVJYL3YwcWxxbWxZZWpLSmFsUGFVUXB2Y1RV?=
 =?utf-8?B?NlFsZ1BuU0RSRDhBMS9VS1hhQUFZd2hWQ1Rvck5zVzZNNWNSV3I4U3hVa1dh?=
 =?utf-8?B?V3ArKzVXTlUzWWRsQUd0d2x0Q0FVUm5DRDFTVFJrV080WnBkNWRCV0VFYk9K?=
 =?utf-8?B?NElhY3MxWWh5enZLdkZwN0V2SVNWTnlGdms5a3p6Z3dXSUY4eld1MW9OTDN5?=
 =?utf-8?B?alQzY3BRbm9QNUlCQXJPK1lrOUwxL25rWEtEV1VVYTV3cjBtOUpaMVB4R3hE?=
 =?utf-8?B?T09oVWNnV3B4Tzlsb3UvaTNsbjExam1rb3czTEVHL1VjWml2aUpSZVN5SVAv?=
 =?utf-8?B?Q0YxMDRianJ4eGozNVd6d2RhK3VoYXpDRmU3ZXlMOUl3V3pJWVc5enV5ZlFO?=
 =?utf-8?B?eWlhN08xQSs0L096a01xU21EUUpuODNyNWZSc2ViNWVSMTNYMm5yZGFXM3FG?=
 =?utf-8?Q?ZqWv8wLdPE4sU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxjM3NwbGpnd2RtZ1h1ZGYvRDk3ZEZpNHNWL1M2NGxQOW5tL2JYQTVlQk82?=
 =?utf-8?B?MngvQlFPVzZZSHNjN3lRb0Q5eDFyODNzbUEvcHMwZGFoa0dvSTl4dVJWWU91?=
 =?utf-8?B?bjJZRm9iMmFQTzRjQWVreDVIOUtPRXF3V3ZURnU5dzBCN3BHWjBFUDdZSlVT?=
 =?utf-8?B?WVlFRFQ0OUI0ZGhLRFdpUU5OdlVyWTduVVh0SnNMMVhNZUFxaU1xVC9HeDRw?=
 =?utf-8?B?V2M2NU9jWWZUTm5nWDFQMWVsMGNvS3NiZDZkQXFaQkxreGlPY2tJYXVwR1FW?=
 =?utf-8?B?RUJHMWE3QmJWUmlYbGZ6cnBhTjhIWUVLTnVDc1VlaE8vUFFHdTI3Q0Mvc2Nu?=
 =?utf-8?B?eFdsMEtJWmgyNGtWS2RrKzROR2hnTW83azJNSzBUV0dlNWtOU2JzVXlXbk96?=
 =?utf-8?B?OUw0VmZkOGFtQlcvYlhrbzJweXVGVGJEM05VZkowdjI5WEQ1dnN0ZC9GYzg2?=
 =?utf-8?B?Nmo1RldlYnk3TWFKM2ZrTVU4WUNkbjhpKzYzOUhXZnFhTFdOc0FCaXcweXVq?=
 =?utf-8?B?VkU5MnhMc3g0allhQnpTbU5XbFg1ZDI2eDA0QW9wUWNUNUsvS1FFdGh1L2pD?=
 =?utf-8?B?SjQ0REpaL0RkYjdRVmo3YXNqTS82ejJUTU16dmJqTXo2SlNPS1pRWVZ2cmpl?=
 =?utf-8?B?UytOY0dEVFhIaGFESVoxMUhnZVJGY3ZOV3M2ZmJ1elRQbnRnaWxtb1ZZQnF2?=
 =?utf-8?B?ellyeEljQ1J1aUlwVDB3RllnbzlyRmRLckhHQ0dBSHdnVDMxYWw5YW1PQ3pi?=
 =?utf-8?B?YXRnSkRkeU9mYjV5MXQ2SS8walVDR0pvWnAwanZUbmVZbjJYZ0xORHcxaUFr?=
 =?utf-8?B?NFJCZlMyZDNEQVQ5MVZkc3E0UUJrdHVDODUrNCtNbVgyeHF6MnFjdjNBeCtG?=
 =?utf-8?B?NkoveGRnWjkyQzA4dE04S3pvSHhPZ3h1cW9Mb2JYYlAyTVAwdmdqM21wbS9R?=
 =?utf-8?B?RUdveFNGbGdsTmQ5T1pSZEx2ZEZxV2ZkZncwT1NmUTRobHJKU2NDRWZoaG9B?=
 =?utf-8?B?YlRJRU8xMzRzS3YyeC9UN2lLZWhaNWlhdFFteFJaekZzNFllVVZqYW9UK1BK?=
 =?utf-8?B?d21MNmxqWjVqb2F6NmZJUFF0MitLNjh4cDluamtBV0UrTVBKTjBIeTY5eEl0?=
 =?utf-8?B?YVFMSHRmMWRNQmY5SEdsbE5kdXpPa1lqWDVvaHlXbFgycWVFWFdnTXcwN2E1?=
 =?utf-8?B?a2VxTTVpbmtYWEYzMGx1YUphTVNPVWRvS1FUWnVEcTR2SHJnNm5aN3JWaXox?=
 =?utf-8?B?b2JGWjRQLzFsNFdnQ0NxdXJmYk9MODZ4L3praHBYVlNTWmNxazlyZmdPVkRw?=
 =?utf-8?B?R2hBc1FvQ2EvQkNnNENGQ3JZNG93bE5XN29VbmVPOTJQQzdvYXB0aGFkN3RZ?=
 =?utf-8?B?T2xvcnhJdTVralhXRzI2QnZ0NzYyRjN2R2Z5T3JEcms0QXgzRUh5MmhsbkVV?=
 =?utf-8?B?RGpsRDI4MTdtUzRwODQzNHBiRWRlaC8yN2h0ZlpKd3Q2MExHU1ZMdFRSdHBO?=
 =?utf-8?B?a2dzZ0hId2c2L0ZKRE5KbGhHM2lmL0VUZmpYZkdWNE8yY2FKckxLVGc1T3dS?=
 =?utf-8?B?MmFyVWIwSUk4MjVTLzBwTkRCNEI4MHpWRWR5ZVYzdldaVjg3aUZRMEpaS0U4?=
 =?utf-8?B?SGFrQXlvT3htU0NzUGVXeStvVVh6OWFkSElEOFFRVU9naW9XOUhoTTlDL2tI?=
 =?utf-8?B?YnpRWGFJVzZqd0d5Y20wMjEwN1gzOWVMcjFVYWpXNTVTZ2UzVnV2cHFBbS8v?=
 =?utf-8?B?ckVJY3kwUmtuVVhLNllYV2ZuYVB0bjVVREVvcE9ndnUxMkxCZTNYaGFYcXJa?=
 =?utf-8?B?WTZvZ3ZGWUVSWG12M0JScjlGVEprNEtEdEFZb0E3cUVIUkFONlFwalFjWTdz?=
 =?utf-8?B?ZnZGcnZmSXNTaGFUUzBBS1FBd0MycmwrN1V6OUtKVUx6c2hjK2krUTZ2WXZp?=
 =?utf-8?B?NUpicFppMFpQbXJ3RjBoVGV2clN3TmhEZ3JuUEwzWE96djhUZ0VySXJ4UGRp?=
 =?utf-8?B?aDhHWk9jSUltcnhUdE13bjdYMTlZYnF6WTQ4U1RNOHdodzdyMGNUOXRPYzlQ?=
 =?utf-8?B?cVd6VU5CV243WjVYck9qNEVBdE8vWTcycXRsRmQxMGJYbVpqRTE2Wmt0NS80?=
 =?utf-8?B?bkt2bmQ5S2gxQjNmYUloeGVGY0c3Y05TTGQrV1dzMG1qSWxaZTFsR3dYTnlO?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6349385-4716-46e3-9d8f-08dd205be226
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 18:35:16.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0U83V6YWozZyyYgnXMDEy6oZztPEEWmPvqL9GK4s0TXdXd0kxSEapgx2rpcm6JnyxdHMw3oHCr98rPiLIOu7k5mq+l9guoDA/gjwOF2pjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com

Hi Shuah,

On 12/16/24 7:18 AM, Maciej Wieczor-Retman wrote:
> 
> Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
> into multiple NUMA nodes. When enabled, NUMA-aware applications can
> achieve better performance on bigger server platforms.
> 
> SNC support was merged into the kernel [1]. With SNC enabled
> and kernel support in place all the tests will function normally (aside
> from effective cache size). There might be a problem when SNC is enabled
> but the system is still using an older kernel version without SNC
> support. Currently the only message displayed in that situation is a
> guess that SNC might be enabled and is causing issues. That message also
> is displayed whenever the test fails on an Intel platform.
> 
> Add a mechanism to discover kernel support for SNC which will add more
> meaning and certainty to the error message.
> 
> Add runtime SNC mode detection and verify how reliable that information
> is.
> 
> Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
> and SNC-4. The tests were also ran with and without kernel support for
> SNC.
> 
> Series applies cleanly on kselftest/next.
> 

Could you please consider this series for inclusion?

Thank you very much.

Reinette


