Return-Path: <linux-kselftest+bounces-3171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF0830CF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455F91F225D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC9241E6;
	Wed, 17 Jan 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0p4bVC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE82377F;
	Wed, 17 Jan 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517342; cv=fail; b=FIU2K41lDYGoYYZ8+iLD7LZqKBd+tkjgAi9h+MoyQo7BFIILyTLxyD3/3VXj+LMdAUT/6Mss42GD6CpcAMYvTWCUBOWG2nr9c+akDmakzSHZaQyR7McEi/coMseC4REQq3Mf37zsX69Y3Buof+ERMn15mdn7c/WpoWhd3ogJ9C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517342; c=relaxed/simple;
	bh=qhM0PyVq4KD85IVTFwP68mXZw+O0b/aE5WRXkzsf6Ww=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=I4AggpiaqP8FDTNyx/SGhjZpp5r+0OWik3FmLTpFtM02Z7odCfTJtTmpB8zlt263tp54oYderDoEtPpynGdwe1IemvWsydfgnh/IK2Ceow5Fr5HsmwtaB1+UVzgrL9B+3htm9TY8PCeTmyKoJNGa2Rfj3LMroko7YDZMArSM6Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0p4bVC8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705517341; x=1737053341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qhM0PyVq4KD85IVTFwP68mXZw+O0b/aE5WRXkzsf6Ww=;
  b=e0p4bVC8BT/SM3C7cQ9xqgDTyubix9t6bDRHAQgpmGGFlv3WhZw10Ggx
   z6Yk5XSt2GzHV9He9evTxlqjuOfe+t2sukVxDongOSFTW1bhlIyRXCdMY
   iRAB9QzdXP0OWzpeZ1Sf+BlIi+oMXZu6PrS3tew62a53XT+Uy1YaMuKiX
   +ctflouR447aCC0s+E+/PQ2vtZhIQT9abDhXle2jOhZWmIZTkTHYBxrjt
   DcsbRE3mSy8mrOQBuhfonH8Inw3LT1gxR60KIfbTQ9aCC1fZ+kA+NXH6b
   LCxNyM7u90IAWKwuRk2dK+GTaDwk1DKkH2ormm+tYV7eDGOeuY+fuFf/B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7335367"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7335367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 10:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="854763024"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="854763024"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 10:48:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:48:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:48:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 10:48:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 10:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgMWNcxFwQ/t79GCCpUC+AnT4DaDsKO8kRc81ZdAJ4HJbKmXFGX+ZvTAELi0tTZDrU4PNM5f59TZgMXlIgulLn2Lbx+ZjmpkCli6sgFKPB/TQisa1gITDwVlKkNW2szTM+sUyTkGhWpq59/71f+Sz5ieXLuKzrDutj0aR/qKrEm0hmvmQH10Q4ob5ZwpC5j+HIxlaHp4SKx8SVQH7w1DpjxT/rR/X+/hc97ItFx51gKZd5wDThgUQxc/Z3+TR2rK7PNXie6XNLcv+NGa+0R6QyxP/cvZVW8MqJhi4q+uauobS9VhskD5pSVDEplrjcrNzpzfrxB0hjnDVKTVmGHSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYXILwc8RPvP3n8PQlcn9Bq7f5uogtvd0Uv9lNaSihY=;
 b=U8n0ADgTpak60numVjFFfehVDU7crxpcxjCZUDAn6+m8cXuU5jbI92gN1iY6xotcanOcHEHEuZAiXPTkAfjZT6Eg+9he9Wy2S5V6ytC/7ZZBySWa6NrXdIOU5wZ1DndjK17oeciL2wNgiON0ReEMqaGrDEb4t9tleqZKSvZ/4oLW08TvQlsFuqh0nLtbOsSryEH1Ke1nLOap+ThB/DfzKuuW7I79Pg7JjgpNc9+CxiArz1iiY1uvtajMLPG18cfnEM5vaArk6bCOQJimHAhNqADLOcsbSYQPDm/KktDLEY6tTxhD7dvjLMGD6Adm6YVedsLj7ujgxmp+T8tFr+abxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 18:48:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 18:48:55 +0000
Message-ID: <fad02d57-318c-4d66-92c9-3c8ceec6a743@intel.com>
Date: Wed, 17 Jan 2024 10:48:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Split
 validate_resctrl_feature_request()
Content-Language: en-US
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <d6442103165be849d32585e861fc2850f7c4e8ea.1702392177.git.maciej.wieczor-retman@intel.com>
 <64b6767a-201b-4c61-98e9-f01aa271dd33@intel.com>
 <2o7adr2cos6qcikcu7oop4ss7vib2n6ue33djgfeds3v6gj53f@uu45lomrp5qv>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2o7adr2cos6qcikcu7oop4ss7vib2n6ue33djgfeds3v6gj53f@uu45lomrp5qv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 09edf0d7-c482-4e43-9a95-08dc178cf4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icDV+fBi1E4Bs3SRWd50dBGDTawrIOsWkUd107fY098oW29RRJ9USOoqDPWYDnb7DTevrXWjdU5XteS1ncganSEYWfAeZDYrk9SZwYGIk64/qcAToEaD0SGZHmfmfXx0ChzQD8/taTn0VFQ6vz/AdlukHCARdYsW+Mu/DNwQbPHzQA7ZIcHAwjeGhCfRPTO+cSqWiQRCwPJH03EGoGXbsvO45P5PJNWcd5UWDTqOrM2rJ5m1aSwFyQ7kwPMOqEPFRaC2wIHe0NxeBI0fLWRSbthNz4ycFRKYEMSiqE/g06qD/8IkzJPV1N7WD2UmXukNB8RhY0nNEGeFFL/ix5rXVbwNNTesKxR35l3Eqj2VkGH5Ejj/a3DmGi4gDRV006QRmMa8fHjK1DTa10P6Uy0Gb7Hpymjk5ZzRgvC4E1XXKF/9Xn1/7hg4vWLApWKM5TNYt8i1OwnvzBIuQTT7e/5Q/NlcxpPQQooCpmU61BH2m79fZQyLb5EiFytbbHHfGDiQpBeXC2/xbrjK5W1oAX9IvGo2KUjn2Urrqan1AjMsLXgR47m/b6+sPWIwqVWOJWRKXrYZv97AOZNACUTJo2d71hMOao+Lo7UONOPT+5rZ6PIhJeDxyPoAqAKflfFJKS/eGyGLh3n2Yo3HNGW3QtScuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(5660300002)(2616005)(6862004)(38100700002)(44832011)(8936002)(53546011)(2906002)(4744005)(8676002)(4326008)(6506007)(6636002)(54906003)(66946007)(6486002)(478600001)(37006003)(66476007)(66556008)(316002)(41300700001)(6512007)(86362001)(36756003)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alNKaHA4YStUb09nbnJuWktnaU1tajdKL2k2MkRKc2xDRStGVThFSVJPRkVw?=
 =?utf-8?B?aTB3aEZZNURCMFNtQlhuSXFYZmpVdG94MVJBVTdCbkpJZ2U0ejJwTmZIOE9S?=
 =?utf-8?B?QlBScU04dlZ6VTZkdm1DdERkYnZ2Y2Y3ZzQwVzhpK1RXNVpic1d4SitpL3N6?=
 =?utf-8?B?bmpKSnVlZ1d4STMwblBaREpzREc4T1RwbEF6cGJMckJFcjZ5amVSOVIzOTRO?=
 =?utf-8?B?YnpxL2hsVlYvVmN4Y2FuRkZUSER1T3VENGZ3bzl3MXFxeGhhZjZDT2VKZkZP?=
 =?utf-8?B?ODVOM1RBV1NwWVM1bzJYMGNUZUE2ZGcrN25nblRQdlJIWHJVYjZ6dVBmOFhq?=
 =?utf-8?B?ZXNEM21pVzIwdWtCekEvdEVoK2hOcFU3TTA4QTNteFRvdmFHRGtUeDVnOVZy?=
 =?utf-8?B?bHh0OWVuaXRsc2VUYkZ5N2hxTHNHU1c0QmJaaU10VXM4a3RrUDFkOEhyUXJi?=
 =?utf-8?B?ZFAvUExTWEkyeWJQaXFlaWJ2NE1ndlpkak12Q1FibWJJWjArb3lzM0VydGEx?=
 =?utf-8?B?Y0wzUG9xQkprV3h2bEFFWW8zOUZKSnlIbDZ0UThOTVB6OFVDa2cyWHoxSTVr?=
 =?utf-8?B?RUR6NmhrRkszVitCWDJDRG5vWFdTTUpyV09oQWNqVHBsZmpNVWh1bHE1eWpK?=
 =?utf-8?B?U0oyQ2kybjRycWZlVDZMWkh4N1IwaG1VcGNJcGl2UVJvb1B6MjhOTjYvMHVW?=
 =?utf-8?B?ZnF2cFp5UGppOXlOajdid3VrU2RUdkQvMk4xRStPZU90bzJmcWhtUEVPVW52?=
 =?utf-8?B?dHBDVE4vOWhadVJDK3BLbGhWVVNBeEN4ZktrTmV6RVZLeXVabjNIRFVPWXJo?=
 =?utf-8?B?dnI1U3I0S2tHWW0waWlsRkYwZFYyZlg1YWJ1dnFmL2VYTnk3cmhCTnNMVWFX?=
 =?utf-8?B?MFlna2kvdHFjanJFVHBIeFc2T3VRQTdHaGp6OXdQVmFhcnBJK2dneVBLVzRS?=
 =?utf-8?B?NkRzNUs3bzlIRTFxU0J1di8xbWpUQitGb3czU0lKRHRNWWZYZE5wcnBkdjMv?=
 =?utf-8?B?SGJJTW41T0pGUi9LU0FTVE9YZnRRUFYrZ1RHZFFKZTZ0b3dlWXFOUWthUUJH?=
 =?utf-8?B?bFkxY2Z1ZzErcTUyNWF6cnZIZng4MHV4TTc1cnVwZk9Cd250KzB5di9MOEc5?=
 =?utf-8?B?OWlLTFdWeXVvSW4yMm9ZM0c1VGF1dnlJMXUrbUkyWnNETmViVlNwS0Zqemw1?=
 =?utf-8?B?RTExMWFDS081MnlwRjA1TzY4QVBVT1M4RnRlSTVvenlMMmJldDhpcjFmcVlq?=
 =?utf-8?B?a0gyTm9ldWZJZUQ5RkJCMTYzbWN6YVpWVS9oUXRXZ2JXK3lsbGd4TitSTFN0?=
 =?utf-8?B?Snhmd2JUVW9jRWxycjBpdzA1WUpkUnR1aDFOUDRJd0NoK2xMYW51WTJxVHcv?=
 =?utf-8?B?d0grRnVMSWN6d2lsQ1RsbVVuRnVoVS9pU0svbDFPU0t4SmMxM253UW5HeGZC?=
 =?utf-8?B?RlF5elpueVRvUU5IWWFLVG51ZHlmSSs0VWxnamVrZEVGbkZKT2h1Z2ZyTkhx?=
 =?utf-8?B?U2FXTWhHMm92djB6OUVMWERZZ0dLcUo3WER4VTNvM25hVFZWUXNPS256T2xC?=
 =?utf-8?B?UE83bTUzenowMHFpY1ZOYWxsVHgxWlBHN2d2SW5KdFdOeVl4Uy9tZnJLUHh3?=
 =?utf-8?B?a2V5Tlp6MWdxMnozZml3NVJXOEZtMlE3SVNrM0Jwek81RUIxa1UycmtyL3lx?=
 =?utf-8?B?eGlBS3Y4SjJGK0pCR1RGNGY3eWFKbEFHRnQ4TVBycSt0NkNhaEJuenZ5Rmc3?=
 =?utf-8?B?YXFaTkRSWlRzVHBCVmRNRlludTNjYkdxVGVBM2IxNWhMMFduS1RJcjN4V3Bi?=
 =?utf-8?B?K05EWkkreWE1MEREOTlER3MxY0ErSUd4b0VIUUVoSmYwWktnN2hvT3FybkFp?=
 =?utf-8?B?ck1DNGdMWEVsRC9DN2lmekwrdmZZa0k3OENOZ1FwUmNiVU1hYjZiTTlQL0xX?=
 =?utf-8?B?cU5MT2VISlZ3K1I4VXJ0dzEwZXJLNjlhQ2tKaW5KTG9tSExRWUdMQU41eW8y?=
 =?utf-8?B?R0VVcE5hSVJjZHhjS3Fua1d5YWtvSEpVZFJBQVNmdlFZUFc5YzF1QS8vVity?=
 =?utf-8?B?VjFUbEQ1YmlMcVNnend5ejBQNm5HMmoxTzF1Z1p2bUxRZSs4bzF6c3RzNm5E?=
 =?utf-8?B?eTVyVHIvR3NyNC9kU3FqdVBxOENXU1l2S1I3NlpMZzRlVVVuT3lsVmdjY0NQ?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09edf0d7-c482-4e43-9a95-08dc178cf4c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 18:48:55.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dQ011wVoPap/PEwoiH4+YUwSKfmGkh6xVcc+pWxG3Gn795tysIutpbsrVAh/swSy0aJ+LPy4slyodjlPaI2mvn1aWtqWooBlRgh5JXBuTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/17/2024 1:49 AM, Maciej Wieczór-Retman wrote:
> On 2024-01-08 at 14:38:45 -0800, Reinette Chatre wrote:
>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:


>>> +
>>> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
>>> +		 feature);
>>> +
>>> +	if (stat(res_path, &statbuf))
>>> +		return false;
>>
>> I think it will be more robust to look at statbuf to learn if the file type
>> is correct and the file is actually readable.
> 
> Could that file be unreadable or of wrong type?

It should be readable and the correct type when all goes well. Hence the term
"more robust".

> 
> Also I thought that since read_info_res_file() opens and reads that file any
> errors should be handled there. Shouldn't this part of the test only return
> whether the file is there or not since that indicates if something is supported
> in the kernel?

ok.


Reinette

