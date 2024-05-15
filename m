Return-Path: <linux-kselftest+bounces-10215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693618C5ECD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF42827C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42944EBE;
	Wed, 15 May 2024 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z46wG0BH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA81FB5;
	Wed, 15 May 2024 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736757; cv=fail; b=YTshKBVB7VtCvLSkriUDxdXYdumJk7OKdEZWXRDKoepHtbtCdfGa9E/R+Jzn1YV/arwvgtVo8riuxjb1+whgYCVPiTywmQC71I1aizBPCTl6W5zlf44fTGjyp+tBPCF3LbwIsLR19kPl5J6vwyBg04yAMiAmTbOEI2d268ms/K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736757; c=relaxed/simple;
	bh=xLexVHKzAKNYGCdG2q6yswzdSTh4WDVlKh4EFOKTz54=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G0p9kqmmyW/08u7PUOIw5bbpqwi+/iZoj3UxucrrV62WH/P0xI0DdBcjz7JJhBEzpq61vv0zBCFhNqkFDjZsmVPi+var+Xz8u+cDt8fdVxeOPvsJ1IIeHMwKbq/1NfdckrA9NP+2LQJeZm/g3MD97idMcm6ledYOXoC9Pzujfy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z46wG0BH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715736754; x=1747272754;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xLexVHKzAKNYGCdG2q6yswzdSTh4WDVlKh4EFOKTz54=;
  b=Z46wG0BHaAPeANrMl+tMLw+fSN/pC9Dh6iTCAHWLi7UFITI09mPx8pK2
   J3vfd63o1TWv1TCaw3WyxC0CAu+Kgkl+b08boaZXGqqXwAJF1Jm6tGgy1
   +0d9gBj6tlvzKixBRTD90G0+B7Xz8oWE7ObDHZKU2djUGVHmglGvj39+R
   vS8ZSQ1svjAS/bzOtty8VCSi/AKiMdCZwihQncWBoI5qPTwvsovOQUw87
   45OP+TVpVmFsr6hfa1Wkl5tt+4ElartCt6z66xe0VR+mNjw+192Cf6mfl
   flcA0TZyHFNG0ZsZ4SVuaRsVW/a28pMXVj7qQC2kQ8IW3/zCcLH8wMWCi
   w==;
X-CSE-ConnectionGUID: +j/oxsDpSTKN3ZZHU94IQQ==
X-CSE-MsgGUID: 6EHhHjl/S42bej5tyv3usQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22346577"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="22346577"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:32:34 -0700
X-CSE-ConnectionGUID: NrVKDgRrT8yrfY1kkzxgWQ==
X-CSE-MsgGUID: 0567ccJaTW2zZ6luLohWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="31444691"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 18:32:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:32:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:32:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 18:32:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 18:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAoLT3pQ2wXaUmPZ79Yj9g/3lvtdjYOctkLvQnYvxjGeDecefYzCxosw+St1CMak584AXvCF/zkugxcC4v4EIpBSgkTfUS0D3vr+w7J/qu5oKkdbiGN8mrF/RUavh5KNAc7PcW3NOVrEckbv//u6WTnjPY8wK6xTNo1kvaoi/lLq6LAXRAbdBDiXDxzpFu72GEQlH01w0fNiBxSODCFTU+6NbwptU9b09c4sQy5kRVnJXQEUK/88q2cSITbVAnp284/LQJZmYNQr2yhnwBmTbV0cD3K69dwY3EGNWjCVpTZvR2g4rgDYjmVcuZQaNqrQND9WkDXp59KJ6Rv0zIGB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIUL1jFkPaZkQeEZ9++O9b2qyGqUZLttuXerr8CL+4w=;
 b=g/jFp51jLZlFZ4ANQekuhX1Kfm+jUV5rCqFgJskWxbv4VoreX/r8PqIFbO3K4/MZFubR7xDVae1VK8pl+kjvxmRrYMfQCFJxRp7vHMX/vmU1oSip0dyHK4j4dDSZSiq8mTFY09tbNyRQifFvJWnlirs9v4BPWZ0amrn4JJg3tJXkyOzvGfFVtPGuwKllpKoLSXXuHkuRj6J1lcPUa/+cVcTHJ0X/5TVSMlyBXWkx6S8kRvt8el9BXnTDv8zokm8jl4fwATpAUle9vnPo72cuYtaddYObDE5IGfjq74XxC1fH5XL5d5u880Dw+GEx9RYufII+B6HYMeL1tMCGP92YUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:32:28 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 01:32:28 +0000
Date: Wed, 15 May 2024 09:32:22 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, Geliang Tang <tanggeliang@kylinos.cn>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add post_connect_cb callback
Message-ID: <202405141220.s3qJcZc4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2da67a207bfd53057db219e13bd68a7ee82d5d30.1715396405.git.tanggeliang@kylinos.cn>
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|MW5PR11MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 563cfdf2-644c-49dd-f48a-08dc747ee176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9u2Akl7tP5hMZEC4j6p05n0/FIwPkh9DRVcRbmTgYarSA/WkPbVRFflB46my?=
 =?us-ascii?Q?B/Jv6w42kcmIajIhrqsqIuCxA4ihGI1Zoi124OmolO0/Eo5qeBme2WIvJyrf?=
 =?us-ascii?Q?PnJ7QQ79AWVUFXf5tLWqHtofcU2QzZPaFFSYRpTDBliQazwF3e4+lrnlieps?=
 =?us-ascii?Q?+X6do10jOhEHHTXmtw1zwd6/9D/n1yB0KuY54fufQ+t4L0dm8czXb4kZiGuW?=
 =?us-ascii?Q?NENr4prvzu8LTq/6X9F74pQesaddJSyNKsicr9MAlpXNj8vGWks4HviDNOq+?=
 =?us-ascii?Q?FsHvee8dTDVhn1MxPDgb4ewU2Fh8YvLU3CLMKF6rTrtXt+ZqEzjnQW9Dy0rK?=
 =?us-ascii?Q?VFye/I90azeMWj7KYtbkuW79Q+Ma+/s6ad5qv74ESJDQWqIAArwicb8xsc3L?=
 =?us-ascii?Q?r7egO8n56SqFkHgz+ifpHr2IV75BqjiLATdF6zwqbIRXl/YDLvLUIPfrkd2j?=
 =?us-ascii?Q?3wWuky7UFUHhEvDvRMHptguV0XOedmtgPHywJQUPc4bsfqFG1+FjuNKRF7pr?=
 =?us-ascii?Q?hPT3dX0N8DWC4krVUzqE6gb8a06nMrfjZfpt3K37Pu2m8Ziv1otPj7WZWakK?=
 =?us-ascii?Q?+STea9M3cdBHr9P0yjx0stAg69RXXKugO0i+T1Tm/dEZBWtGsCyA7a69KoEw?=
 =?us-ascii?Q?ne2zjVH2LrQ/xgKii+KO2ynaFc1BpxEfVyAERHZmp40b4WhtbOMpTS/FgRLm?=
 =?us-ascii?Q?HsPaWoi+BlxDnxtK+B6v/bUEzCivnMXYTzVqY3c8zRIBVST2K8ZY8tQXSIzn?=
 =?us-ascii?Q?VxRGyGgOjVdLWAESiqJufLPpSCh1A6TMEVhHg0PtyPVjHoKc+XfwbyBMc456?=
 =?us-ascii?Q?Rp0tKLxR4QsKPDKugPwmdJXoeOCvikkI5aEXDUXBFwskM0jxRZcYLrdOUrpi?=
 =?us-ascii?Q?dbMaNTfaJto/svjDjgaIcxgb+mB9pwUYca+k4F35lk/czg7BLNl0eUlrXCrM?=
 =?us-ascii?Q?ztmqh2omDinmkVVkJyLnbMgIogGhJHDlYzjQIiwmyvdy5WIwAr3OjJ6ded5H?=
 =?us-ascii?Q?xy/2BzFRvTZxpoE8iv00qzJo92uN0bVj+lL1J22tsyFJXqs0MKPAfva7BGTn?=
 =?us-ascii?Q?qtyvawLKvy2u1tHYw5i3dp2D1GMmnVTZCa/nenvDUZrFGotyyeN3wubcOWbF?=
 =?us-ascii?Q?BrdS/BiOQblxFVm87uyL3DEax0qmKrn/ni/lLYlZUfj4CU7aq53Ofy1lYpv0?=
 =?us-ascii?Q?AAAQ+iV6UYudIw9fD6ATH4y5Y2SVnLjNQ/kaDY5UUKmtalmEBjGydgsFbnVh?=
 =?us-ascii?Q?/PLXJhj9fnvJsJZOkx6f7nS7kmpDuxTN20Y+WGseHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFuhIrenw5y3VnjUFTmlMpTuu0u7g1tnUBOF0AYE5Jm0yrMyPrk4wYE/mwNv?=
 =?us-ascii?Q?whAhT5PXcgtIECut/nVWr+f4L8UizVKVVmR6HI3JHNUag+lVjfymVE8ls+vN?=
 =?us-ascii?Q?um37/YHSAN2vrfmQdcwonDXeOd9RISo+/7GFoWpKUoLsqge47wItF+0jiltU?=
 =?us-ascii?Q?HTFo2+RN7ehuI/SpYOKAghTdYFwW3XZTeuVPN4zMemUIjvhx0++V1ixL+Eb9?=
 =?us-ascii?Q?1IuoAGQlHKkqz8HCAHPKz0ItZNltOJ9phzGqiR1yXL9u3odBNm3ZnFahE6UF?=
 =?us-ascii?Q?2J3Kh03JTAdRk27BshQWJ6JR/vghmngKPfO/Rjhsfo9JOeYOZGaXYDErYoLA?=
 =?us-ascii?Q?YapSjn5HJh3UTq75rPQ3ZwcZKxPaKBcweBnQUd8Jd20sFGl9ZwOuIwNucRKy?=
 =?us-ascii?Q?fi5qJQZbrzVYvsB35fdqh+Xu9q4US6YsfN/FaX9QSZnOwv5hHeCzpfGnOK1y?=
 =?us-ascii?Q?q7xcXeq4kHG01mD8f9xEi5LNSKoM7VHjKQV2q1TUwpeg3li6OYXZVhkyk28f?=
 =?us-ascii?Q?rFzRpjasCfV1LDbrvRNhLPNocjqhqSQ4FQk4r9mfqFpZB7BxCFZer+BOwlrR?=
 =?us-ascii?Q?+9t/QLS6kMtwdkPFeW6Jkvo4tAEs6X0VF6lHda59gcquERgxRr/2vjSCJajf?=
 =?us-ascii?Q?/j68FAvbUbBYS2gSjCQiHXcBpwe+Doa4qcBhz1hUooTJc1Dcm4jSCvZo/V27?=
 =?us-ascii?Q?YPubXbyZd/mQjdvqCqgz5HU8vzaCzLpmqgXRUwn9wGet4CIIXK4nMO8a8vNW?=
 =?us-ascii?Q?GYduo8Apur093XSFdYkcjdQXvkzlXN2Wxwy601HberCT6mpJFjfCWh5dkvNm?=
 =?us-ascii?Q?vFzKMVb3YneBepeaShQ73yZd4lAsJUHI/pbjOzrgrG1DX1IK8DlhCc3+/uZW?=
 =?us-ascii?Q?lkZk9g4pUwKiPkRR/lwiNaRdEqGCERn4UjLKy1WxYle7aDl9bChyI568GIGE?=
 =?us-ascii?Q?piM4bmwD5CX0uFMgI+4lbik8bh+vw1kfcesF/YWpO/Dz9eVgnK5gIP9cAJqs?=
 =?us-ascii?Q?y9W4Ex44oPDXYG5KzIJE2RfWwVj0wD3BHNkkCkq9+4/D2BD4T31ybS51CVnk?=
 =?us-ascii?Q?fvuSP29T+Ayv0ArLlKqMkyvOa7LmQZ0rvb/CKzZtsMZYL8CqTx6I7BU/7PL/?=
 =?us-ascii?Q?to4dlbLwnIMe1iA1Qd5HBlKNeOaQQvolVDYFHO28sxMuGH4UCtfgQtaGY9CG?=
 =?us-ascii?Q?Wk7Egv0uw/W0FuLSyAhro5TAXpIKpcpkw1WefZiXjFgO/gfZAeDBT5sCSJSP?=
 =?us-ascii?Q?XqAUqCDupqrIo8dqPOuadqq3nlRErjJKIjJMF0hyAgby+rRplCJ/hcn24+CU?=
 =?us-ascii?Q?Si1heqjmtaC/Bc+XapqoKc+z+IhJBDyBs6d2XKsV6rCxvQQA/RdAc3KGOYoA?=
 =?us-ascii?Q?AtR4UbeZ/2q2907D4i9rKbZffkTXHSLGPNpUyX6Md8+CKyDy4RjFwlNa4p1e?=
 =?us-ascii?Q?FvIc2TYKxeZ7862KSljuEM3IJZBEp9fWDHuo7gYXHciqAf9Orfp9ESlwGAny?=
 =?us-ascii?Q?hs3zVCzKLa8H20hj8iR4pBJhIVGD7GGp/2y25uO6yDoodwtYTYWRaMZFe1ZD?=
 =?us-ascii?Q?7T6/tR08QSDFk2pVI3aJJ/pHPon4Xmwsf3II1ZvO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 563cfdf2-644c-49dd-f48a-08dc747ee176
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 01:32:28.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUtk1wLfQBb4LLsBKXsdYhR8Lt7xNeULGa4/2bIp0rqHaF6QCxc46gACRDo0RLpLXc+9bVEpc9Oqht8taf+ugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884
X-OriginatorOrg: intel.com

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/selftests-bpf-Use-post_socket_cb-in-connect_to_fd_opts/20240511-111755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/2da67a207bfd53057db219e13bd68a7ee82d5d30.1715396405.git.tanggeliang%40kylinos.cn
patch subject: [PATCH bpf-next 4/4] selftests/bpf: Add post_connect_cb callback
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202405141220.s3qJcZc4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c:500:26: error: too many arguments to function call, expected single argument 'opts', have 2 arguments
     500 |         do_test("bpf_cc_cubic", NULL);
         |         ~~~~~~~                 ^~~~
   lib/clang/18/include/__stddef_null.h:26:14: note: expanded from macro 'NULL'
      26 | #define NULL ((void*)0)
         |              ^~~~~~~~~~
   tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c:37:13: note: 'do_test' declared here
      37 | static void do_test(const struct network_helper_opts *opts)
         |             ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/opts +500 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c

5da7fb04902b0f Martin KaFai Lau 2024-03-22  484  
96c3490d6423b7 Miao Xu          2024-05-01  485  static void test_cc_cubic(void)
96c3490d6423b7 Miao Xu          2024-05-01  486  {
96c3490d6423b7 Miao Xu          2024-05-01  487  	struct bpf_cc_cubic *cc_cubic_skel;
96c3490d6423b7 Miao Xu          2024-05-01  488  	struct bpf_link *link;
96c3490d6423b7 Miao Xu          2024-05-01  489  
96c3490d6423b7 Miao Xu          2024-05-01  490  	cc_cubic_skel = bpf_cc_cubic__open_and_load();
96c3490d6423b7 Miao Xu          2024-05-01  491  	if (!ASSERT_OK_PTR(cc_cubic_skel, "bpf_cc_cubic__open_and_load"))
96c3490d6423b7 Miao Xu          2024-05-01  492  		return;
96c3490d6423b7 Miao Xu          2024-05-01  493  
96c3490d6423b7 Miao Xu          2024-05-01  494  	link = bpf_map__attach_struct_ops(cc_cubic_skel->maps.cc_cubic);
96c3490d6423b7 Miao Xu          2024-05-01  495  	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
96c3490d6423b7 Miao Xu          2024-05-01  496  		bpf_cc_cubic__destroy(cc_cubic_skel);
96c3490d6423b7 Miao Xu          2024-05-01  497  		return;
96c3490d6423b7 Miao Xu          2024-05-01  498  	}
96c3490d6423b7 Miao Xu          2024-05-01  499  
96c3490d6423b7 Miao Xu          2024-05-01 @500  	do_test("bpf_cc_cubic", NULL);
96c3490d6423b7 Miao Xu          2024-05-01  501  
96c3490d6423b7 Miao Xu          2024-05-01  502  	bpf_link__destroy(link);
96c3490d6423b7 Miao Xu          2024-05-01  503  	bpf_cc_cubic__destroy(cc_cubic_skel);
96c3490d6423b7 Miao Xu          2024-05-01  504  }
96c3490d6423b7 Miao Xu          2024-05-01  505  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


