Return-Path: <linux-kselftest+bounces-41615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DDB5A061
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 20:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBC3B591E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576427A46E;
	Tue, 16 Sep 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHuc1L3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC82494F8;
	Tue, 16 Sep 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046586; cv=fail; b=u8S8b1YZipN2qMwHLQ6v4J/Ich4/m5ZvhR4neesz6mH9joJ6r9vLgulPv1HttgC1cvs82a4y0jmTu82BPKNp0X1M6EcpSpl/RxaaJ9pF3pwxvva0or38tfE4gCmkDzfvEwXg5QvQMYt1L4J6lLYXx6Wx8jlr4co2gsaoS33SFsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046586; c=relaxed/simple;
	bh=WJblEtYt2WcC9ad0R1iTyfL6prHMpAevnc2ZGBUJX60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BaVniXfM+XtfdqSaLXZuVmzI3MaeOiZaYZNvXLSSj8HjZZfj2wmv7rkix/XI7D3ybq/gv1fx7cbGQ0TgFkSFzeFyJMB8BPBo1dvc40FskvIlQSDGHdIyd8EXzxvIlw2y7s1/nqBX16g2AtHlZVYS7h+nzefcB7vshdKTJDJG2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHuc1L3v; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758046584; x=1789582584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WJblEtYt2WcC9ad0R1iTyfL6prHMpAevnc2ZGBUJX60=;
  b=UHuc1L3vR9DzjkV7tI/CYX4Q3LmjGsMYDqITYNi5AdwYne5MFE9UqCnQ
   qWa+2NV1S1p2yamNwcThm+srH2K7TOPM6lFkY+qWrVZMZvosZ6M2ZBv37
   OonmJ7RHsBKQkpYK6+mW2EsGJa4Jzty6FSA7XiAShiOuoFPhxHL5aTn9M
   8/NM2liwUzdtAM3OZQ+a+LYCoRQI95S/H5GnDDuvbQUx0j6uPLqUuJMUY
   7l21Bme0gFmtwAv88Fu59gsfJz2gfSVrWjWPjqdtUv1eR1GfBrtnaKwFW
   46mgLdaV2CEeCJr35KA2q++q0rPJw7Z1vNNlb0jMkkpbtAf2CLQFaj+0Q
   w==;
X-CSE-ConnectionGUID: VxQyd/7qRWyQnLLMdQUmjA==
X-CSE-MsgGUID: e75L3Bu6T1OonZgqUgUkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71705762"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71705762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 11:16:23 -0700
X-CSE-ConnectionGUID: A6/eyw+vSdiK6tJk0Hmh0A==
X-CSE-MsgGUID: CKDj5EHjTpuH6cLtfEA0zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="198710081"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 11:16:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 11:16:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 11:16:22 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 11:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiF7odI8IZMvBQvKWJSAtH+B9cagLzZ0vPm5zIOtaDuMYqRM+VIidEmntad1cQIGc2abCWaF0RecwFlmRcUu20/4nQ07RQIhLALa+D76qAPoY1J/PphDuKhb96fro4zfNCFDDvkeMPxMkFKkU/OQBeQVcp4v/ZIbC3OhsKC3NGW30Oeindmylj/98lXZ5rpYp6iB/ygpS+/EBJ8HJr8hxe4UYQc/0YdmkIwrnhFTur+y4j9ouEwNTUcpjupzHu4WmeFn82MJXZsGs54XqH8FjqqqEbMPgvBlNWAamrqxm8/KyLm/0JdytohZ7tHPYUqOQCrNB5U6o8o7WRtkmREk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKC/CRcBdBeyW0guvcQt0akJe08VPdfEFyMFoVVTFaE=;
 b=EkN7RQ0WSL2dOYlSX/K3VU3/KRBOdgeGvKUDVLOPXUwn0qyysfVU8Z57Ti5YNT20bA2mI0ZdyKvPUt456aLXFOIt+DF+yhAcSkD/EN3hiPd3zuOp3WGv5F7UzLxxye5ZbpGeJelh5oAIm1eU9jx4zby/TNWNIohhR8MBJDJN/HeiibUpfENlYVaRw0J7dDBDrL9O421ko2PGH1Ubz53CYpGEcKgOJwGaph7Y4CjZJ1cfpr3ldBgYk9d8jHG57ShVwLsfqSWdQ9boB1gck9TgUBBPBS1mnzgrMquE8S3LAYY+spVm0o+gtOiVSr80mamWdtHni4ojwTFOJ1Dogj998g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.23; Tue, 16 Sep 2025 18:16:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 18:16:19 +0000
Date: Tue, 16 Sep 2025 20:16:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 14/14] selftests/bpf: test_xsk: Integrate
 test_xsk.c to test_progs framework
Message-ID: <aMmpYilJr35/acaP@boxer>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-14-ce382e331485@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904-xsk-v3-14-ce382e331485@bootlin.com>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: aeead6a7-ed16-42a3-d26e-08ddf54d226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/BRCrmZ2futXboLI58DAtecElQ9ihLhVGiSv3mUMTZDwIXUdCI3Yr+pNo+nh?=
 =?us-ascii?Q?lSvqAIHkoOX87EdhRNu98A7oFhgZxpBLMLPrFv5Tf163hwsOlSRfEiB0Wbu4?=
 =?us-ascii?Q?HAk0efvUSj5WLoWU7iogVW7tiwP+mwxTJNSBlFjzUUWiYHQxwkmVFQoFnaQT?=
 =?us-ascii?Q?XgvfD8A2X7+1Qs9kS8TE9aJA/axWqH/OqqmXUIEN1ujBOAYmO5HG9bAh2gnR?=
 =?us-ascii?Q?Ld0Cx28uF9UoqbgON5UM3xFSNbwySeUah2WcTFKqDez0LnxCwYK5VWUi1+Df?=
 =?us-ascii?Q?luNKlOQ6yq3f346pAcmpKgPC1YIoHFuCMpWGGl5232ZNW3aabgwvTxpSlvH2?=
 =?us-ascii?Q?D/K9KFxg1DhL3x/+t9DnTkfWsnRB+qqiBlSyg4Gpdt3jtisP0dSl1KCfj4N5?=
 =?us-ascii?Q?OD73MSd5CuRQEwHi3zM4HWFRxzuwNSd8SVqOx/08qdQQmaooXTBXAkjF+EmP?=
 =?us-ascii?Q?OlAaycZYpXMoOpHAexntGC1CuvaZiOeGTetZwZcyTPkZYhqN+joPDsbWYq6e?=
 =?us-ascii?Q?wV/lptAI70A3AsWqEsVmL9+Ij0i7TYf1MuFUSQVtEVYMr6JiBmqeR1LCiQQq?=
 =?us-ascii?Q?jXZ/yfd0bShbdjyQTtNwNDF6vHWmOrJmurDx/GEnm5G0VYB+xIGLNTfJuRQB?=
 =?us-ascii?Q?oLiYr1gnVPlZhzst0TohQSy/hhyK1tXoFTRY3kQPGqwvXA1P61+9cdlg34le?=
 =?us-ascii?Q?9TM10+b6TnUYnUxgLjbYp7mDUrugHG+b9iJgaKZPVfwTlySSSeunRIfyiK8t?=
 =?us-ascii?Q?Id+cpFZNwPxNvUEOiAKhmrggUeQRNVTi2/73JuRtGWmllKv9pD9B4XhmP34A?=
 =?us-ascii?Q?GGsgWEk7CMTuLzkQjMCcqFV6o/mfC32822V8Hu8f7HcIlomBzIW5ZFlmx5hr?=
 =?us-ascii?Q?9H3gkCdPm5gzNNI/Ho9jx4g0kWpDy18PF1A1KAYCVRlEU7DdhPNmisMi3zyS?=
 =?us-ascii?Q?aYhyFeBldxvDC5nJPjB+VWMLtIpFdoQpdrY8e4Mt5kvgX9qPeoNZItGs1pbE?=
 =?us-ascii?Q?bvn0Y8EtIfMKbl+4y5cOzgibVQGlTg3rO6FlNcoRnwBil4F01/coNdtmwq3y?=
 =?us-ascii?Q?jDVTgrMsXJQ+NVu3lBiYwkUeYcu1Zp9OKMtV1IC//Z8cXRZLkwXPrWOduZBq?=
 =?us-ascii?Q?O0vJIKLKFJ6mLhqwGyLejE2YQNXtxMwen7jwoofTqJBycR5uwIe2lRryyWZL?=
 =?us-ascii?Q?KmWNw1402LIy3sQVaOQgc2hIYWD7a1WlFrsuo27MGzAXkNXMSm0XFm1M9OUf?=
 =?us-ascii?Q?e+LGi2UkazxbhUurxNSwg/TDf2i3E2rHfeXeu1fmXR2EbQ96MS775o5K9bAG?=
 =?us-ascii?Q?KFqsI+FFOqc/BrXNAJUraNHYXqmPIlX7nTXDcp1xcE+9RkMalKzY42niH+Cu?=
 =?us-ascii?Q?VpwAjIgSC/vtvMDE4I7mrxaH27JWtkX681mqSIyJpySe1q8o4jEpz6x6fsdh?=
 =?us-ascii?Q?NEu9IaNV+Hs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evt4pPZ2DrpmoKhSN0pLJdYslKG+HPIgMuGZWtQg39Hth7csareBy+sJbgcp?=
 =?us-ascii?Q?MXxonV7Sb3k9+vHZZ2wLMKpOLiw6Ey+2IA/11tbUXIewHaP6+IbXxaFtgumJ?=
 =?us-ascii?Q?LCmTdiH2gyUDAWPFZouBZQPnQLSuK0WIblKWi3SOJr9KiH4hAgWuQGol51n9?=
 =?us-ascii?Q?9RkpFKVIbTM/hw5/1NojkgEXrj8XZRhjv6Apq8vfax/M5hOc2YnPKaPZ+3W4?=
 =?us-ascii?Q?7nBiDUJH0ylgSp/QL+EadZ8R0zbzfIaTkSsLzsRAaatk/O4OEDyksLDlNj/T?=
 =?us-ascii?Q?CL6GQyw+dSwrqZCmyy80k8gWqJUuAjRVLGkOrZDRbUX8ZPhvTcBpSmmUjZCF?=
 =?us-ascii?Q?IgUbm2EZcRuv0IzsvnxmLmVFAqn+V0K9zyYE3Vuhd0quo84PSNDUJfFkAVSu?=
 =?us-ascii?Q?7TiSBBQYWZTOBH2gAZf++rgbNYmFK79Xs6tIGWCr2bKgaqO5mdS5juPFIqwB?=
 =?us-ascii?Q?LCSzmYqLXLrUVRqpgIB3XbCly5F89Yb5L+hVSDGNKQtL25wr73hpvogdSxQZ?=
 =?us-ascii?Q?RDF02F0YeUNt4Z0wuNRULIMVaM297DPDnkzQ0xEMZXW1Wfi0V7hdlFWVao+Z?=
 =?us-ascii?Q?ShHiCz/EPe5nT/FKrQPxxtSOYJcomvPuCyeYnb7DCwc3bqRhtEtxtX9WgyrS?=
 =?us-ascii?Q?BiVBtvL0uRWpdHfsbWCVeYS5XJ+bzCMSWPl/EKmA7Y+NoG6M7tq7LgWDOBB5?=
 =?us-ascii?Q?KT63iwOSvIpAt95Lb+NtQbUe+QXXj1TDyBDCVnX4NwmDfL939Lm9J2zORlcm?=
 =?us-ascii?Q?190FH/axhWpEebH2uS73o6fXtuTJM9BpSmPfNjiS3SKdGELe97Zdyu8hisZf?=
 =?us-ascii?Q?HW9K9N/lYL1djUr1yPK/JifoJozRxb+bT0ZH5VB59Yxvm2l+Od97kjMH+TFL?=
 =?us-ascii?Q?x/XxGMlhEZMIjCwArPoveuNTnoTErFPcPlUW6+0hQOEY2SjuweKBSfgX/0IN?=
 =?us-ascii?Q?WoBYaUhwwRHDr26dZgUZveSrchvN4HO1rApQWfobvaqAA1p+PqR0tVAKFpdb?=
 =?us-ascii?Q?SUCp0nKRw7FDnmVkwSxWyLSWpbJQzOP/E2yocNUfk3RCnFtBSC1m5QYWiVW3?=
 =?us-ascii?Q?YbMWR1GJbbcvcyjIP1r1lREz6USyAC8OpCVMhU5K5i8uhSP9qgM+DnNCHWx6?=
 =?us-ascii?Q?Rca3RKc90qlSUwwQxlTrc0EAEC7LDa/pguvNvT5a5nk8vLbnbteEV9s/eLuB?=
 =?us-ascii?Q?1ZLQehClYQuH7B1nEclKpGqWtn+LiYkoxN50CCtaaiatibLYg5pE6QKxbjpq?=
 =?us-ascii?Q?U30y7gyMXrqmXd1kfm0ICk2M47s+uEFOcA9H3SoJvCX+VQPhzUjrlELijb/R?=
 =?us-ascii?Q?W0zJVlIyTJ/0a2PeN699meYbmZriwrrWOfahBpcYcLSxT2UZDRKCqgkZK3h2?=
 =?us-ascii?Q?jAffJo7Wwf/+gX4XxlSkaQ2bNyl6FUOk0/XEkkrAmDpKKXUpGFv13xpbJye3?=
 =?us-ascii?Q?0s+MSkOHOoA985l9Oeht/094QHO9mL7ws5MH3MpgGM9qVNnEIvbMmxrgXpLf?=
 =?us-ascii?Q?h4IpA132epvXv6lykOK8RxRbAAXsFCoYuDuUgbp1u47V0nsVH6XjlLmL/wje?=
 =?us-ascii?Q?C6bLULsWx62t3yRje9OoJPk/huOovhDASWit78NqGcrfvAeeRSCRuJhL5t0g?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeead6a7-ed16-42a3-d26e-08ddf54d226c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:16:19.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ETl1KipttAbZHpJnyeB9O/E4fhJJFrAL3RHALzFzzSc5uDeoBiOiD6N6J6xdmqsrXnkh2nGVnfRWRdLb5REi4VaZlP+90a5odPFlgSjt7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 12:10:29PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> test_xsk.c isn't part of the test_progs framework.
> 
> Integrate the tests defined by test_xsk.c into the test_progs framework
> through a new file : prog_tests/xsk.c. ZeroCopy mode isn't tested in it
> as veth peers don't support it.
> 
> Move test_xsk{.c/.h} to prog_tests/.
> 
> Add the find_bit library to test_progs sources in the Makefile as it is
> is used by test_xsk.c
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  tools/testing/selftests/bpf/Makefile               |  13 +-
>  .../selftests/bpf/{ => prog_tests}/test_xsk.c      |   0
>  .../selftests/bpf/{ => prog_tests}/test_xsk.h      |   0
>  tools/testing/selftests/bpf/prog_tests/xsk.c       | 146 +++++++++++++++++++++
>  tools/testing/selftests/bpf/xskxceiver.c           |   2 +-
>  5 files changed, 158 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4bb4f3ee822c1adce0fbd82725b40983695d38b9..1af7d4b9fe54b777131bce0cbb8ca328c885c23a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -541,6 +541,8 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
>  				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
>  TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
>  				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
> +TRUNNER_LIB_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
> +				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
>  TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
>  TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
>  TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
> @@ -672,6 +674,10 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
>  	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
>  	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
>  
> +$(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
> +	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
> +	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
> +
>  # non-flavored in-srctree builds receive special treatment, in particular, we
>  # do not need to copy extra resources (see e.g. test_btf_dump_case())
>  $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
> @@ -685,6 +691,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
>  
>  $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
> +			     $(TRUNNER_LIB_OBJS)			\
>  			     $(RESOLVE_BTFIDS)				\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> @@ -718,6 +725,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
>  			 json_writer.c 		\
>  			 flow_dissector_load.h	\
>  			 ip_check_defrag_frags.h
> +TRUNNER_LIB_SOURCES := find_bit.c
>  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
>  		       $(OUTPUT)/liburandom_read.so			\
>  		       $(OUTPUT)/xdp_synproxy				\
> @@ -755,6 +763,7 @@ endif
>  TRUNNER_TESTS_DIR := map_tests
>  TRUNNER_BPF_PROGS_DIR := progs
>  TRUNNER_EXTRA_SOURCES := test_maps.c
> +TRUNNER_LIB_SOURCES :=
>  TRUNNER_EXTRA_FILES :=
>  TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>  TRUNNER_BPF_CFLAGS :=
> @@ -776,8 +785,8 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
>  # Include find_bit.c to compile xskxceiver.
> -EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
> -$(OUTPUT)/xskxceiver: $(EXTRA_SRC) test_xsk.c test_xsk.h xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
> +EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
> +$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/test_xsk.c
> rename to tools/testing/selftests/bpf/prog_tests/test_xsk.c
> diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/test_xsk.h
> rename to tools/testing/selftests/bpf/prog_tests/test_xsk.h
> diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ce5ddd7d3fc848df27534f00a6a9f82fbc797c5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <net/if.h>
> +#include <stdarg.h>
> +
> +#include "network_helpers.h"
> +#include "test_progs.h"
> +#include "test_xsk.h"
> +#include "xsk_xdp_progs.skel.h"
> +
> +#define VETH_RX "veth0"
> +#define VETH_TX "veth1"
> +#define MTU	1500
> +
> +int setup_veth(bool busy_poll)
> +{
> +	SYS(fail,
> +	"ip link add %s numtxqueues 4 numrxqueues 4 type veth peer name %s numtxqueues 4 numrxqueues 4",
> +	VETH_RX, VETH_TX);
> +	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_RX);
> +	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_TX);
> +
> +	if (busy_poll) {
> +		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_RX);
> +		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_RX);
> +		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_TX);
> +		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_TX);
> +	}
> +
> +	SYS(fail, "ip link set %s mtu %d", VETH_RX, MTU);
> +	SYS(fail, "ip link set %s mtu %d", VETH_TX, MTU);
> +	SYS(fail, "ip link set %s up", VETH_RX);
> +	SYS(fail, "ip link set %s up", VETH_TX);
> +
> +	return 0;
> +
> +fail:
> +	return -1;
> +}
> +
> +void delete_veth(void)
> +{
> +	SYS_NOFAIL("ip link del %s", VETH_RX);
> +	SYS_NOFAIL("ip link del %s", VETH_TX);
> +}
> +
> +int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
> +{
> +	rx->ifindex = if_nametoindex(VETH_RX);
> +	if (!ASSERT_OK_FD(rx->ifindex, "get RX ifindex"))
> +		return -1;
> +
> +	tx->ifindex = if_nametoindex(VETH_TX);
> +	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
> +		return -1;
> +
> +	tx->shared_umem = false;
> +	rx->shared_umem = false;
> +
> +
> +	return 0;
> +}
> +
> +static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
> +{
> +	struct ifobject *ifobj_tx, *ifobj_rx;
> +	struct test_spec test;
> +	int ret;
> +
> +	ifobj_tx = ifobject_create();
> +	if (!ASSERT_OK_PTR(ifobj_tx, "create ifobj_tx"))
> +		return;
> +
> +	ifobj_rx = ifobject_create();
> +	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
> +		goto delete_tx;
> +
> +	if (!ASSERT_OK(setup_veth(false), "setup veth"))
> +		goto delete_rx;
> +
> +	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
> +		goto delete_veth;
> +
> +	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
> +	if (!ret) {
> +		ifobj_tx->hw_ring_size_supp = true;
> +		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
> +		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
> +	}
> +
> +	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
> +		goto delete_veth;
> +	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
> +		goto delete_veth;
> +
> +	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
> +
> +	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	if (!ASSERT_OK_PTR(test.tx_pkt_stream_default, "TX pkt generation"))
> +		goto delete_veth;
> +	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	if (!ASSERT_OK_PTR(test.rx_pkt_stream_default, "RX pkt generation"))
> +		goto delete_veth;
> +
> +
> +	test_init(&test, ifobj_tx, ifobj_rx, mode, test_to_run);
> +	ret = test.test_func(&test);
> +	if (ret != TEST_SKIP)
> +		ASSERT_OK(ret, "Run test");
> +	pkt_stream_restore_default(&test);
> +
> +	if (ifobj_tx->hw_ring_size_supp)
> +		hw_ring_size_reset(ifobj_tx);
> +
> +	pkt_stream_delete(test.tx_pkt_stream_default);
> +	pkt_stream_delete(test.rx_pkt_stream_default);
> +	xsk_xdp_progs__destroy(ifobj_tx->xdp_progs);
> +	xsk_xdp_progs__destroy(ifobj_rx->xdp_progs);
> +
> +delete_veth:
> +	delete_veth();
> +delete_rx:
> +	ifobject_delete(ifobj_rx);
> +delete_tx:
> +	ifobject_delete(ifobj_tx);
> +}
> +
> +void test_ns_xsk_skb(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		if (test__start_subtest(tests[i].name))
> +			test_xsk(&tests[i], TEST_MODE_SKB);

Ouff. Feels not optimal to setup everything per each test case. Was there
any stopper from keeping the veth pair per each test mode?

> +	}
> +}
> +
> +void test_ns_xsk_drv(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		if (test__start_subtest(tests[i].name))
> +			test_xsk(&tests[i], TEST_MODE_DRV);
> +	}
> +}
> +
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 0d8e240864c747253d72319efeecd46f0fdeff03..4c8b931d9e3d5b5723df87922551d1b5b97293b1 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -90,7 +90,7 @@
>  #include <sys/mman.h>
>  #include <sys/types.h>
>  
> -#include "test_xsk.h"
> +#include "prog_tests/test_xsk.h"
>  #include "xsk_xdp_progs.skel.h"
>  #include "xsk.h"
>  #include "xskxceiver.h"
> 
> -- 
> 2.50.1
> 

