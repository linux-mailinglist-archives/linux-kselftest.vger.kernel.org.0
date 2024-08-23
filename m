Return-Path: <linux-kselftest+bounces-16126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8995C404
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 06:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2E1C22D12
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 04:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F963B784;
	Fri, 23 Aug 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeYULLXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096D347A2;
	Fri, 23 Aug 2024 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724385919; cv=fail; b=Wiz8JOqrUR4tJLdqMmDesxvsCVPB2q15HY9V2VuwHtCL0F6is0FTjz2L1HDtH6QF3Fz6N6+PSH6bkT8KhQafZbHNajH65wwFIZ/tLV5v1/BxlzeaRd5Wk7lbRfKhWMSYT6MQen0HTPXKvfwVMWXjEc5eDXeu34gLRq7xNy4HyUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724385919; c=relaxed/simple;
	bh=+smO74E/7B8Mqs6E9/z3SZCn8r7ts5lQCMq2wcV+EvE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TihtAIBdneG6XBPFKfVD7f0LM8mjCPc2T9gvd/QJJF7SpJGKyz7dwLPJnYGzzOAbMJrg5nnN7q6U7/wgzQWkG2UD8VhNTcnI1vq5SfYuswynDLsDB/u/O+sXjAiHuMPxvSej3Iu/RbYCMPGcS05KT1AM+F1ucsznDiseHlukdQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeYULLXp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724385918; x=1755921918;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+smO74E/7B8Mqs6E9/z3SZCn8r7ts5lQCMq2wcV+EvE=;
  b=JeYULLXp1+HvmPyKzStz6f880NRSsLWmqMywv5ri3LFKVmMdMq6DY4vu
   0IX7TIm0/D0CwT+Gfn/vr0G+pbiUaYNPhe2hsI8TnVdYon3pivg1R3Jow
   KNytwI9nnsEBs4noyg5IeryAl3tMbgfHmNyC9RHSjCDF3ly9DXHHdTfGL
   0+KesOtnuOm9YGQtaz92tb/NKOGJhM7c5WTMHL5m7oY5H9LDQdVCslJOg
   vqZf3qdFaAS+VAXHNzGouZLIaIuAZcLDIlNv03GCnogEksNgU5Tea0b9R
   YC7Xu3IlK/cIJCC8TuZCxcj345d/EFhuA1er3IbHbz7UPxtS8e1zylla0
   g==;
X-CSE-ConnectionGUID: UpJlmX9rTcuyL8d26be3DQ==
X-CSE-MsgGUID: MGNR37q2RFil0syoMYaKMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48233268"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="48233268"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 21:05:17 -0700
X-CSE-ConnectionGUID: cnnOQ0y6TkeQFMMUl3vnqA==
X-CSE-MsgGUID: 2JFVAtxEToS+tiOHDFUGWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="66004433"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 21:05:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:05:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 21:05:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 21:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN0hcpnitpH43xA02dnkjwrONkcW03Q83LD01bBQNvK+aJ1O+6/wSsrhTFkj90U4NJsIEkiFoH7aMgIYHXoO7HS0iQRO2xHUzp99WH/X6PYnzGaJ1YFZyRrnGN47IMdKktJwqb5/mYesC81yQVd5korii7NxyniYS6KohZ6ZUa4kCMZKgZEKqmLV5UFJWz4+8rZitsMOwy6bVa1Gu1pffs3YSaazclBEBZ2pU3V8oHiSk3jFsSIxzSNtVsuWZjwq6+k4P1TcIK5a1/tYQ2hSLp1mIhiBFc1fLpndqRdsxWHw054CRK4LAjFAkm41rXAwNYsywfwJCgoUtLypXb3v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF56hyIyKY5vLik+0EfMvo6tcLNCrZIG5Ptx7P5t3Iw=;
 b=yEhMZJA9xhiU9gr1rrq6CchxX/FahZHSwAqUguj97yVrlIAOq8jo65knVHAeIyjWSI+MeivqThwq/HANzPnoiqmvq4EdgeXahnonQTEjljMyowK2qpL1qNsAWTIgPxl8+6IplF1YtkMCxmF1azHPDOwKXEFXXmuJtgSmObxxffTS/9RQOJM5HrjYR6HZKFti13oP1Unot3AwdBDHXuw13rWAPPXrHRgZvG7FHjion+adup+qkvTb3MfEBEfNTQB+wFEOu6153E4x6Q7G0AvVOsQI56wppqLWpZkKpwgYgc7h+1+NLbGn7Zn2/OXiEG6Vjd02ukWcdTgYLdHBkUFrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 04:05:13 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:05:13 +0000
Date: Fri, 23 Aug 2024 12:04:54 +0800
From: kernel test robot <lkp@intel.com>
To: Eugene Syromiatnikov <esyr@redhat.com>, <linux-kselftest@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Jaroslav Kysela <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
Message-ID: <ZsgKZkhBpNSmqr7X@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812165650.GA5102@asgard.redhat.com>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: fd17b5a1-0fda-49f6-cb52-08dcc328c8c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55w6osg54KyIVNMVcovorIRynEaI/4aHyGooVtYZpkZZkr2gtKcvFPNUFAjX?=
 =?us-ascii?Q?KdBUuWZ7sENdqRgCD6bijOym5nyWjpuRjdhSHw3kchZVAsmKZeKPX+ajieu+?=
 =?us-ascii?Q?PGevL1MNGfoNOnUnKMVgnY95gGeL7TaMIHermrcu+kMiFTshtALkX4daqdIj?=
 =?us-ascii?Q?E5bm4pz4AGLdylNtL36UQX53mk8IebIODLPxZ+3xluCwkCwhbdB/WSTeHtSk?=
 =?us-ascii?Q?X9A1cnhibQa9AWsGm8EzT+BvbJtVe0GfnlqYlgVf5qppBqfh5CU0n32Qc4ZV?=
 =?us-ascii?Q?Uan9W/nsqGNz6Tas6MzdcL5zt/wb0+lZjerPAX6Bay8QeZY30XX+Iopvhccl?=
 =?us-ascii?Q?Wdc4J+0Fz5dW568jNqis46sH6xHJaXwp/+2LT9NCueq30wRUEbE1S9PfiSDh?=
 =?us-ascii?Q?EQqpdzp/mUOPLl9zX4821zh+73QmOAb+ylNnscLwpGv/s5lohS96mugfizka?=
 =?us-ascii?Q?/gCSpqGpH4FL74sp/hfuxrthMdjvgjGAs2jLSPFRFDhyRMnlMIAQ7zyLjb3b?=
 =?us-ascii?Q?ZR1xSagSsZI/Wo6v5978ADo0aug5KVR1E52jQUG1IpwAu0J/zrKAO/Bs+u7W?=
 =?us-ascii?Q?dc+zhZqu9bO1I+54MaQmOv6jqs87w3/95WednQ+ENWlaehfDWOCWXXNur6vL?=
 =?us-ascii?Q?eNkHxbrrCaTc/dRhB0HQFydREuUW7T85CCT7hpNLOs2WG+LwRnzIxPVerenz?=
 =?us-ascii?Q?GTm/iUyrImYshmThmnw87zkFz0RvVxmfcp1N8ok166IWlLzBB6o3zczNS+sG?=
 =?us-ascii?Q?YlXzqy2FwWED3ajuw8THqO1++l9L4POwh9gEBEGmoVzViKh8ZCpTq01cz1SY?=
 =?us-ascii?Q?DKh9lON8ek5N9otkVitOLfRV1smgHZgKUQSdncl5ZyRIK18mc0UG8UnJSN9S?=
 =?us-ascii?Q?nX9xw6REx5yGIwP2TT43E61xxSeeDgOZhplPFf3EtZc4+gRadOhY4J7BrDaE?=
 =?us-ascii?Q?FAxW1rD4+tNeDbHaY5Env750N8mfpSdMd7CxGQ5MqJKaJuyIZMmAJSP+xIlT?=
 =?us-ascii?Q?EmAxZI5sm5ZVt/dZ+yn82BgfW1mR4cCMMP74JGVnwrxUWUc1MZEtnhXhLPb6?=
 =?us-ascii?Q?ha72Opx49tsUJ7Z4LdSbRmK4g/qL2hpwSq7B3aU3HOtylRzTaiEFo4geYD+/?=
 =?us-ascii?Q?X4dPkObQUyz24zTYgPk/n4u/DobQFNTWRbtmk9j8XcRMdxzRNWldnUBJLYKK?=
 =?us-ascii?Q?DE2lk21/SlKhGtNgx4WOvUmDUBjFk7Hc9yozr79zw0VCIDfLkd2Nzzfu5oqJ?=
 =?us-ascii?Q?UmdGjHc/caUPae0SCasmnzPvEwHFiiKxjBaLs4Zyo2qf3E8IZO+AB0ShSdua?=
 =?us-ascii?Q?ODS50Y4iae5e6QDkMO2I/OtQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VClyo9Iw+f5qTaHdpd0rDUtxhTYQYPRDUMZZmPn9VKv6WGl9p1Ybq08jZVS1?=
 =?us-ascii?Q?Zu8DDmAZzxYXs8o1rm0fg6FfKEGOkbsz8noRJqMm1XF8t1oBflebrABQPLIK?=
 =?us-ascii?Q?DvUOU/ytcNlPH9YgYZ+VaYmQIi1JRZLX1q39yopHcRu0jbMqVF0MTyrOWpRU?=
 =?us-ascii?Q?DwG5vEcTIGSZxg6yFvTP90HCYHYhGrfFvExCbWsvpqfNZtwUbqpa+gBt52OM?=
 =?us-ascii?Q?qppWs9+uPl7jxQDDnLYDkpMeWkuBsTBDb0W3NiDABN//zFBuK49VKz9vAkuz?=
 =?us-ascii?Q?GCcbC4lIigFaUE4PcJmCCTt0+xmuKcfr/8RC+DhpqaoyhQJWGABpfU6q8pNQ?=
 =?us-ascii?Q?WmnbvKkGRfz5qyveFmydieLENxe85M2+x6gEgtZ0A/qEZ4zfhNdXUH3+hDZj?=
 =?us-ascii?Q?rN05TW2Gmr5Ao+Jdf53x3KfDkskftlRtTjonTczX/62fecL1ekItYwrnrL0s?=
 =?us-ascii?Q?sqSsovGMc3uKjHAIb6d4PMFj51sK+O3cp7SFptfFUl1LcFitsqlsv2iasiiv?=
 =?us-ascii?Q?mO7qY8Q50H3owO20pq2N7OGwyXij/jNiqoDW+7sBzjcaI0Htpy5JqkEL0/VX?=
 =?us-ascii?Q?xDRxUF7xiJcpuQhQnmetIwmta4bUg+QDFER9TZTNIqkdS9myGN4YwCP/jdPy?=
 =?us-ascii?Q?XxekGhF9mgoQd13M/gVW4qw1qP6MOXdLMa4YCX7cAnkZJcTSnJzYxv1sWEZ1?=
 =?us-ascii?Q?QCjPwWKdDZfiJfoTzpvemA4eg7VajHzvHYLPUU5PcZjekndN4tEBuUMSYN0B?=
 =?us-ascii?Q?JPaxUiKHeELXUftjuO279t8NLr36fi0/UaOokE8GyKM6agSJkSvHsm147Ss8?=
 =?us-ascii?Q?0RDje04cs9YKmCvA/NQSvFFTcBow0YWQbah0XdTSY1robZKYvUk3y+0xpVHG?=
 =?us-ascii?Q?hbP1skROIcl74hfPZCf8tAZn8bi6VOQznjADaCP7z7NOMiPrSOFR/+WKCaep?=
 =?us-ascii?Q?E+O2DBrYRqlqgtjpK2xbbH9gLkmX2MsC0X5pMBuHt+W6JEoM3tNaQIFL3wJp?=
 =?us-ascii?Q?hE95Xuxo4OYTovVquA716m1n38oESIoPD1Od2ofFVpSFGDz9gwnjHkiDwi8F?=
 =?us-ascii?Q?I38xz565kO5/8iO8jWYGHG/CIwjmU/GdYZGclZ9K02V9csECZIy011+BRlh5?=
 =?us-ascii?Q?tSjFo0iFMrdZAFi0qedidE1K7+OD+/qZ4jWK8T+ujjqFTqjVxwJtISMRx//1?=
 =?us-ascii?Q?XBRcERuC9wdBp/dqLf0Bg6CADs9J6Zx8AAwfr5+vaRzVL/1AKTD9V2AkA2sn?=
 =?us-ascii?Q?BbOA4IrYHF9BQt42BiXQb2ApXqMcuj4MpJBr6oeJSjZcordjGwZwNupHzGKl?=
 =?us-ascii?Q?fD+d+9vOeFgimlqjgs+FPXnJr+6Pt2mOp+v44tuvzk9NRI+dxQK/CaEHEulW?=
 =?us-ascii?Q?gY4M2ct4jnVrW5nl2nl4vkLHGz5I18vif7sQIkK9yRsGJe7QN00yKVM4Sbl0?=
 =?us-ascii?Q?u+XNXlPYKHu2/YD/7boeyuXZVD1gFGZ+96Ofl9Hh3HkruVNoSmatzR9P0+zN?=
 =?us-ascii?Q?bwXX7FeazrXKkA7V4qaxrTHRKXU6GSJzCljhAYXh14EbhBjzXfMPbODI0QHJ?=
 =?us-ascii?Q?woMAHhvCxM/CwUW1MOIOhnHwQ2FWhTYqXRts0sws7dEehS89tPFfaVqIbslg?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd17b5a1-0fda-49f6-cb52-08dcc328c8c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:05:13.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W7j28j+B0qRMTMxnRN9URBoFhEcyLYhEMsAFKCNNuUihWPX3EshR6CQersIx0CA6nMIL79NrA69vtUCDuRzEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

Hi Eugene,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes tiwai-sound/for-next tiwai-sound/for-linus bpf-next/master bpf/master linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugene-Syromiatnikov/selftests-fix-relative-rpath-usage/20240814-091042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240812165650.GA5102%40asgard.redhat.com
patch subject: [PATCH v2] selftests: fix relative rpath usage
:::::: branch date: 5 days ago
:::::: commit date: 5 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190453.wsHNZQQj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408190453.wsHNZQQj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> clang: warning: -Wl,-rpath=$ORIGIN/: 'linker' input unused [-Wunused-command-line-argument]
>> clang: warning: argument unused during compilation: '-Lkselftest/kvm' [-Wunused-command-line-argument]
--
>> clang: warning: -Wl,-rpath=$ORIGIN/: 'linker' input unused [-Wunused-command-line-argument]
>> clang: warning: argument unused during compilation: '-Lkselftest/net/tcp_ao' [-Wunused-command-line-argument]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


