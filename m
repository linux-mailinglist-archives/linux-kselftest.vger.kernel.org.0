Return-Path: <linux-kselftest+bounces-10261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25568C6AE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FFB1C2244B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C52209B;
	Wed, 15 May 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDSS3ECk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273939863;
	Wed, 15 May 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791739; cv=fail; b=EYQBsob4svxWphH+ixAm2Vmep+FgjzOwWzgVB8T9f0qVH2YCbKn5pdyVC7lX1VkvHQ6WzjPqJji4bZ4uIr2FWfnA/bKFVM3WCNMyaE1CO1MMHtouT0/rCl+dyU+cg1JR8l+wl9ME7sbEs9PwKoB2khb/h3U5LAuZgBCaRqdjg/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791739; c=relaxed/simple;
	bh=XocV8HYGFxyh31l9Aw86uGdFXo1FFAT4gSPD+9rzgpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUau0mC+9mF7rj+zMkm0UH1ruEvw/WlQrfRKoYBgINlHuI7T7XU/qNEZAjszHXt4bzuBMADpBAIP7QE4xriYD1BjaU9OoQZDPCamV2mUIoNwZd0kjLyrHbD9haWexd0ayu9JAb5PWkHsqV9e3f8cLmDlXG7P1O2HAPj+vJ1vqOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDSS3ECk; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715791738; x=1747327738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XocV8HYGFxyh31l9Aw86uGdFXo1FFAT4gSPD+9rzgpc=;
  b=CDSS3ECk0Vw0fw2mnSlPj+vLQGSklL+3n5REZXFIK51Wsa7cE6ROWu8J
   Ah1xTGjLrdW2dc73PH+FcixjF48X5zb4/sy58j0YDM0PPvfbS9G711n/I
   yg+1h0n4xKkeRukcaFjSmTHPLr/9snPyDm/b5inE/4x9a+ZkyY+2jHGN3
   0SwXoeOeYEBYl+WNo+5fRzQLYcTEqLUrD76sW54WNPq57P0RwmaXohYI/
   mhtLQolPFLbLyFvzyJ861BuGNoAnEgWfLYWxIyNR4yiqQrdwtDNHPMfrL
   tfygG+EYhXbsL8L9WClbnJNvc9kNG1XjnmJMj/9KxirnzXKOrKiYxEIAJ
   Q==;
X-CSE-ConnectionGUID: X2obMZUrT2uu+qxBBbbnmw==
X-CSE-MsgGUID: EB9KjMRnQN6nr+JIZCT1Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11799942"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11799942"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:48:54 -0700
X-CSE-ConnectionGUID: d+19vQXYTtaEXp2YM4rBWw==
X-CSE-MsgGUID: QVkvdiS2Q2+x0uScJw6P7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="62315794"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 09:48:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 09:48:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 09:48:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 09:48:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 09:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4hJvu2l3M74xLNcuBlZzSEPiXCxRWXQsgyr5jGkARqs5X83ZFOtZmMiXQd1eNMEtMFOCowVNNmSQVtHFqVQqX0qHjh8QeZuM03CXKXaBZR5r43ob3WiiSRIyD9HL7aortkJ6aMakNjfgVJeja4E2PxsJcMIyr0QgdLwl5DgzP74+96P5btVZtwfga0blOZYCuvbK74jXNaJSyemve6I+7WSAUnGNixnP71EaIC7+7roypmPxmDGvjj+jQKGi4Q6ZXzh7tY3uIm5u42gLYyrwhHcEfjXH2r46wu/WYGgYZt2tat5V+95+bM2rHI7EnYZyx++ogtJwB3qz5dXgh3Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XocV8HYGFxyh31l9Aw86uGdFXo1FFAT4gSPD+9rzgpc=;
 b=hZ5TSM3EbKcbq2IH3DeC9GCGEbnjh8zHSLMaa+NkS1Qi4KE1iVrhjVoPhyx9bGOfAzvhB2DsKMalt0BxcNWG2Fu7hmnE4tufEJ7cgFLEdBKa8oyd7qQSu/y2sXxvZ2tqUA9V99l2gILfeQC8YIZ1jnyzjiasrWHxQz8XSxgSjermlo2rovTX5dyl4l+sIpkPqen9/mQrrzUFKoI3uxyR5BVE77pMTyV9O0EK+Bd1rjCLbtgMQGsxLPwIRI7BNI4Ax+CS0KuB4lrKmb2L0pJVR8cl6wawr9x8GmkhG1ZfUW9yXTJ44wpBrTapIRTjweRJLmMMazQ5V6jJWUN70DuJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 16:48:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 16:48:44 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Topic: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Index: AQHaprmme8fjFWvJ30CJk2uljzCiTbGYgXWg
Date: Wed, 15 May 2024 16:48:44 +0000
Message-ID: <SJ1PR11MB6083320F30DBCBB59574F0BDFCEC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: 98327bb5-46e0-46cc-48e3-08dc74fee213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SqDypS5C1C02V1qGMA5bESsJk0txyHN5mWBSSvE45iltFBwZpTZ5F1st1PtR?=
 =?us-ascii?Q?igZTbO7aDqxkU02kBSkoumbrG8Hr92BbBFgpa2gDtENrsBlaRbhmIM45Ytqq?=
 =?us-ascii?Q?CrRSvzeA2NjKaE1xfrrGXLnrb+e75H3GxOzeUSiwV3GgxF3S8Xk8IvOSrFOL?=
 =?us-ascii?Q?5vNczPPTDMablpi7UUse7u4uvvMJcaBSfpfcNUZNnFjfwDKUQdfHxyiudJn2?=
 =?us-ascii?Q?E1l+1m0Li35vf02wgeDapiaImOLlrCsZNItn0BejRgW3sTQCb7oi1Dkqdpy0?=
 =?us-ascii?Q?7z2p/Vk4NHiJ9PKWIj+V9eENSe61U53/CYCUkrdhluXL+0/yDaRIR7QS/XkP?=
 =?us-ascii?Q?JeX/jjMV7u9CuPAoOzCy0jXZ3zgSTpCyJYG+PkioNGc3H7yPJeM/WmPQyWtY?=
 =?us-ascii?Q?8VGcCxXIcLSor6kxxQmwi24iDmYf/JUMYQv2piUWGNwMe4wZ635R7m1PQm4e?=
 =?us-ascii?Q?2JfZz1zEn+G45aRDIAb0dWt35HuzLMwAKt/qpmUNp39F2G7U/q0PpqZW8F2W?=
 =?us-ascii?Q?Yu74ScGhPa7qFUU4tsg3WCIrTTTw4hu0vjPgm0Xf+RTfsD+DBOWpCLI6eXPc?=
 =?us-ascii?Q?Sua12klY6fLNHAZIbxwAoDcDT1yFh7kjT6XmZcpa2I1zVP8+FM0K+1mY7o3i?=
 =?us-ascii?Q?TMv4PackoU92C4nnIFvUpKknuIC4fpSDHAFGF9VDr95hjsI2aV71i09JhuXs?=
 =?us-ascii?Q?UgSbymJWAWT+Gl9X9S1H9Yh7apjLdDDYWhNGHi/yo55hm6ONh6VKmmNDNzKp?=
 =?us-ascii?Q?0rm+oIKc8KntfZXAh9YVhYZ7jobTuW5vm58cpw0whd5JsuH5iaNcpt/x0QAZ?=
 =?us-ascii?Q?/7OliU8OWYJrFTIcmeO5ezcCoA/C2+A6YJYJa/23MSXuWML6+1CU1mwxPc7X?=
 =?us-ascii?Q?3xjfW1A1ttNIkNz6sU49EHUk8nzhyxWe0rcXEOvSetdkazonPAcol+HZueF9?=
 =?us-ascii?Q?MsgujB5IcGN5qdGIzjN8mnyElky8NS1iNh4m71Qg9yS9vs0Ut+qdIbeMb8gN?=
 =?us-ascii?Q?Jf+Dj2uVg5d/FoYcNijxU1Z54AsK3c/Ed3Lz4LXq277sbKGpjRwiMK7hO8ii?=
 =?us-ascii?Q?E6gcJKmGTTZ0i0gyNRfYzrw55HhR1PupyNwlgfrWyaTB6lURZzZDvsUDN7s7?=
 =?us-ascii?Q?rV11XeUaIFfxQXdzFzN81MpPYdRLnmi9/H3knIcTHsq6+akf+hIX0sm42R+1?=
 =?us-ascii?Q?xERw5hatKgtUI2O+1zo0Jt5cOUrGOFPqThZnwbq41rx9A1yLIiaH6WXx5cuN?=
 =?us-ascii?Q?GYJbM8mFjHnl5W/mHPILRXbKkFvdGLuttqYWrUFWc0aDLsIX+VYraQd4Cx+9?=
 =?us-ascii?Q?HVBD4vz1qLp1RUt5rm3RiGA9fwp5FpxibHAECGtbllvsZw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UXSgKXToHBKMvm6OMfEh1HPx6D+Bij4ziuerD7YHEfWNshluPtEmmIYTkz/k?=
 =?us-ascii?Q?HGAcbKzphC0cqiQqU1w+x+0KBj+RPtd1AjX+7G7K0EGY8Z4SzdnDDSX6bnhT?=
 =?us-ascii?Q?O7/Wktk3SflgCAsHsAz6OX8LrMFgAj6x0PkSf2gMuW7RXAPUsVwJZ56Ij2nO?=
 =?us-ascii?Q?3KanO2BAG1M6Kz02IxtUERRnIb+f94u73bz5/XGRMMmi9EyyWWZreeHMl3Yn?=
 =?us-ascii?Q?hqFBSJnsQvjq7B3r80bilkQAVMw9eXNHCrkr0zF3wDVbwz+EqCWjPUWj9FjT?=
 =?us-ascii?Q?b7s/eLriXdD14RV3D2QLszVUvzZYipdnWn6vvRKMZpT3brcddV01ykJC12g6?=
 =?us-ascii?Q?OWqq24bBt3j7Lp3dPneanj34cIaDkzKzMfz6qn2KQFDvka6t2NJOxRR4B/bz?=
 =?us-ascii?Q?9D9tD3dtWwDhCmqq4OwsNNOqat/nDu4uB0QDJgHYgaeVuCB2ao0N+wiAWdQK?=
 =?us-ascii?Q?G91eYXa/5AnaHOMl6zadzTw3gxDfSh5SRyqd93aKusKhpG3hq5m6U+F0EnDm?=
 =?us-ascii?Q?MpddAp43zIyVtJW2a8h1GQrvYOWgLNVhbzA5RRpltyybKWBJGn+nTkA+y5dQ?=
 =?us-ascii?Q?jpBlgThDeYyQdF0KjigAp596dnLPw1q0vZKwaxUlRbpjKVf7BFNwiATgKlEC?=
 =?us-ascii?Q?q//UM6Ljasor5Aqd8W6d31jGvyfR0yM+fdiXIQBXSSfShNzDs1tStxrzlaG1?=
 =?us-ascii?Q?R4FLVeAg+ZQdKtRc/aqpaKhf/j90a1wEjvQzcst4r+apsFpP4xgOktbNkOOG?=
 =?us-ascii?Q?z/t2WyPVwLx+EzBWGviU5Nnxd3wksFGB3JGA0KnhqlSWEch+p1xKqsUFeOpq?=
 =?us-ascii?Q?24Vk9+khkYfdrPWr4/msyWQFNiYnF1bpFVjLIaC7ez1Ds9eWwSjuZvR6mxaE?=
 =?us-ascii?Q?6vBcHGx/Vs7IUrQeyLkI/Diiql1at0XsnoT7r0HVfQGuynTa325bF8rpw0ve?=
 =?us-ascii?Q?Y76TzGsN4a5u+aFJRvFoJd/4GyKkzXt5EvP77DRcu4V+llDsOMCz13b314id?=
 =?us-ascii?Q?hiiBdbWkuH8bTrXZ1On02LK+2+hIw9mSShKxZuCiOO6bbOKgOdLevz8mj70C?=
 =?us-ascii?Q?bIp5sXTZcm38MnzE1YxUocAVX/opLAOHw/HUYEbSk8OWRR72rYabRyzuB/V2?=
 =?us-ascii?Q?eLk3tAhspWi813hAQfaEhOQaCehaqtlIl26oPtk4YsXkoQxG6vYyaNtIWa0y?=
 =?us-ascii?Q?XTb7UGR7mdHUxvpEA2Vitr9GBc6KSMIxbu60cdxsxdpNd1iz2s2M0EKr6cRI?=
 =?us-ascii?Q?BQPhAfnU+yqsUqCwNnKL1toSwtlWEu4VV0+usGxDqpTMxmMLOXd+QA9UpiVj?=
 =?us-ascii?Q?gzXg/n/ksb9ILxpl76RwpJZmldTkGL2xaANcvQnkpKgzbWdDjVR1a+rotxYi?=
 =?us-ascii?Q?2COMqAhQsNlHMkwDbBR4Dd1eQfFi/AjVWdl7NThvxSVjLe7SOmOxYhOa90km?=
 =?us-ascii?Q?3RqxNVnpXAu/N+5gcm3KQHyT6a1V+dPsYIf5+o+iTjOrqjO70bP1fTFNhEXD?=
 =?us-ascii?Q?qvBgN/ithfjSxeLykVCoyB1osN9JjJ4xKLb16Asod5K0FW6Nh25XrBTQYPvn?=
 =?us-ascii?Q?pHVrCGkvD9E91e8uEOh8qTj7+i7Pvn7tnU0p/ljX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98327bb5-46e0-46cc-48e3-08dc74fee213
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 16:48:44.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kcpZzwEaJDU8V/krJp6hOZAekES7OSN27RTAGGdw86R39EhzhFS2DnO2MGqBmcq8wN4zrDXU0FdZJirl74TQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

If/when my SNC patches go upstream the SNC check could become:

snc_ways=3D$(ls -d /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_* 2>/dev/n=
ull | wc -l)

assuming you have /sys/fs/resctrl mounted.

-Tony

