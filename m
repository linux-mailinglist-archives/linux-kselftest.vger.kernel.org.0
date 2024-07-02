Return-Path: <linux-kselftest+bounces-13088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50950924B8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7571E1C226E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502C17A5B5;
	Tue,  2 Jul 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpK2tHtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB714F109;
	Tue,  2 Jul 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958923; cv=fail; b=pt8EQoHFiIJreqWMOCZF6K7NmE8BfXuyp2C60XBKT8O8pw2LqU4xnTgbTtLQvbVelpX/s40fkJGt6rUVkfUnUEUN1CFv0X+PoeyEhgN7QsEOVAda83F080y7yrXBF4cnLBEhzwU6s9MjvEx272fQ4fQYZA9ASTvmo+k66od5zfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958923; c=relaxed/simple;
	bh=vexpXnVjnzv/m8sFmmiW1utiKaPNQhe/157nJCYCRmE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZ/b79EJMlh96XAZBdoh7UFWJ77kx2dv6bV+0qPV0CLJ0bFarTRC4nbVSHNheXQHizc9Q9PGU4MNmZvIFkefHa48UJ7GDgpBtOYMcSEFSVhp6Fd9/Q8KRT8ITYUtnPJSR4uzvjkARNWWTqw9cgJN9C4M09vMsWC+FWd8/L3jsdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpK2tHtN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958921; x=1751494921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vexpXnVjnzv/m8sFmmiW1utiKaPNQhe/157nJCYCRmE=;
  b=jpK2tHtNIFDMMm/4irYtTwHvfvhspeuS/l2o0WivDd9qBjEW8q97hC/R
   8hpTu3IyZqkBOwFW/VThDcJ+zqyvCEOgSz788YflA7dfkYVF81IagNIxa
   VOhep7yDVxqA/icgnFXUvlejgzmysV0syxkEqrDj0voqgz7DZsiht9rUO
   OAdL6FngoPBlRF2qDtQt5gSnrnnAe7PAkBuI2CudlKf6lc0gWLpX3ZI/h
   7QkzBumdVfDK8BJ8ZxC03fG5kRmprY1942scPoK34Qn24vZgs2caadxLp
   HVP/rSReAi7kd7b4fHZsbue+ZV7Z77FvtLm5WrUCfNZ0VrZx3PA0om4R+
   w==;
X-CSE-ConnectionGUID: o/AL0s2HQmODrfu48Ugsxw==
X-CSE-MsgGUID: H2G9/VZMRYC+LXEZ8jr2MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27777805"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="27777805"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:22:01 -0700
X-CSE-ConnectionGUID: WwXsMwm7Q++tp0a+K/gAFg==
X-CSE-MsgGUID: rEpncMYRRayiiX6IhDlyNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50372238"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 15:21:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:21:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 15:21:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTBxgxZoglWqyagU4R2emTz5gnUuH+lzkkGrdeI9+vSUBcMKXtN1+nF/KyWVYUPkj7X5zp+4NI7tmlDDIS+0lNo5DCcgZt3KwGEBqGU/D7dyhe0BXZH/1IsWHPiNMys6FectYKXdOUjcTxiGz/CSkMnI1eG0OWy/8WwXAgJ28ohm65ClE3FM7/xH4D7agO5mkT0hiqO8ofvV4DEMgpEMrdXgaCBcjWeKY1vEI0Lw6P+Zm+Clit2lU/qv4gvG5XoSvwDTf263XuEjk6imxvHGLGkQf8JJx8W0zZhogXf7ZmwcJTdZIeL1/qcvHYL0aR/D0CYP6V4k2yuzNBLgHmbo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTRmGnU51preCYiIv2TEhMPJ/soB395dVc3oBSEHss4=;
 b=a4zeMAXvMFqyAuPgzYjNqLemZZbNsWVT/Ik2RTGtOvPII5Xao9xPPci4m24aCXYLaKoPJvbHk4pQVa1SzKicD9OBm/7yuxKOJ0xUZQF98hQml05Mi7vb+BkPOkJYUbsm/waMrM4aI4Owvbukwb1No8G8RDjMevu1DPMnIJ5ovqpvN9yRMHTbHaOdWL0jzKv58EM6biibhdsy3/dUMptgoIKlkT6JlGZ7sQjdXJiXfd7txA6TrUPY24m4CYMEyV+akNOYoTD6pz/+QidwiLyeNyVnTdylQxmfC7d06DZZueWcNgQsRpIIbQV3dFtAE7nxY1xsW9iqdkEU6iCgcA0QKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 22:21:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:21:52 +0000
Message-ID: <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
Date: Tue, 2 Jul 2024 15:21:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 238d2357-3261-4b93-07aa-08dc9ae55f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2RKeG5rUVNXNGw4K2VZSVlFUzNCU1JJU2w3N3lLVzBVS2RnRHJBODd3TElj?=
 =?utf-8?B?WWFiZHRKcmtYTmREUUdQOG80NEZEYXNnS2ZtcC9jbFBneGFGVHJ0cVN3MWxB?=
 =?utf-8?B?cEwrVDFaZXdTSUF1WmdVcEx5cWVXRldVbUNSSHl0a3RJQTNuaUhuY3I3MmVh?=
 =?utf-8?B?UlhSN3g0c2dVZHp3NWMrK2lYWDBIWXhUSlZucXM5eTVhRzFTUEQ0dUFRKzZN?=
 =?utf-8?B?YmZ1UlNGWXVMMWNGMDNXL1htbi9GWm5RU2h6OTBRcGhOSFF4ZTJ5WXlhZVM0?=
 =?utf-8?B?a3ZJcmNsSStQTUhHcTcycHNTKzdTV0lpeU1ocmg3KzBrTWJTZXNuRnlVLzJC?=
 =?utf-8?B?bVFRQ0J0a2N4Y1RreUNxVzcraWJSeTJCbFMxelBiaW9Yb3Q2czhLRld3YTRy?=
 =?utf-8?B?QVJoandUa3krZ1cvbC9LWkJ4bnNMcU9FOW84Z3MxSktZcFROaE5weHVRWm1D?=
 =?utf-8?B?a0xkK0Irc3RuRitpeW5JQ2o2YVBSdUFtbGVVcVp3UkVhUk5Ua1FPMlBZNEZF?=
 =?utf-8?B?eVNFc05JVmZyZkpjaS85UTJrSXRPNWhXOFJHN1RzOVRKd0txRGI5ZU5sbTIy?=
 =?utf-8?B?WHlXNkpQbDc1c1dKbnhjUHltUnZEZHNrSGZBN3lPaytrZEtuSXZZWGVPL1lz?=
 =?utf-8?B?SmtPbXh3c2M2VDF0TjFkTWhzVDVTbFFpNVd1K01KcmNIWE0yMFA2N1I1OFNw?=
 =?utf-8?B?Tmp1VEpQMGcvN29lQVN3SHVPbjliaG9rbW13aE8rL2ZaU2lOVisxUjJHSXk0?=
 =?utf-8?B?Ui9BTFdreTl4b1g2blJ0OW1jOFVLcW01N1pDWk53U2tXclZKWENOS1o5cGNr?=
 =?utf-8?B?bWZoWmdRTURkUTV5UE11UWlUcGpzNHJQZkFtWGgzb1BNbFpFdWdFWHBwV3NO?=
 =?utf-8?B?RUl3YnVEeW9SSTdNcmM1MThxVGcyYWlMOERoQ3RoME8reGN4eTR2dWpBenZT?=
 =?utf-8?B?dGdjZ2JjT3dyYWdLYTQvTk02ZnBGQStRQ3M4SkQ5MHNXdkQ0WXh5TXJiT293?=
 =?utf-8?B?TVdWUzYyL0U4eTFjVEQrSmNzVzJKeldkdnFhbU1zc1NPSkRHZHU1VXdBeU9m?=
 =?utf-8?B?SlVNVVlOL0swcDFYcU9KME03MFRwbUwyRkdPV1EreEVWbUdGYmUyZ2RGTjdG?=
 =?utf-8?B?dDEwRnZpc3diaDBXQk5lc0kvNFpETkRvWjhBSmhzeFJrTitwRWR5WnFDeTAy?=
 =?utf-8?B?OVVzK0xaU0wveVhja1hHODBEKzZaVEJFdnJ5L3U3Y20wcVFRK1lieXJKWGRy?=
 =?utf-8?B?bnVXMGFMMUlhMk9JSXQ2WVNPR0IyVXc5N3ZOVC92ZlJrNGViKzNzbC91S3M3?=
 =?utf-8?B?VlkrWlVGdWZwTGE2ZFdIYnB3cFR1b2Z5SkJFbkl2VFVVemp1STliTGdDdVd3?=
 =?utf-8?B?N3JEcVlPVHFRelJmWko5a1U3TDJHbExHaC81VUNhcURUU3A2L0VpWGtwbkF5?=
 =?utf-8?B?bWFuWmwvTkRNcHdsRzVJT2xwL0dENCtrSGlHQ2pLNFk5azdtOFJrS1B3U01p?=
 =?utf-8?B?VVFxUG8zQUVzNExmSmtkMndFcVRUWjVpRHFvd3RSdjdmbW9pd3hKWk51T1JG?=
 =?utf-8?B?TklhWlhqRkdObEpucnFmOHYycFR0OGdGSzg2dUloZWlrV2t2cGxZTDhLdEFu?=
 =?utf-8?B?T3R3NEplSXpLQnA0WHJwc1UvcEo5aVpnTEowTW9NU2J4UDZabUVQdjloMkli?=
 =?utf-8?B?M0pPTkZZQWhqNkdxS1hGUEpDZ2w2S05SLzU5RXA5bnUraDVPcWwrNXNpbkxw?=
 =?utf-8?B?NHRjSU9hUEM0MkRjREExUXpGUWhIVS8xQUZTVlQzY3d5T3hXNW9manIwTEJz?=
 =?utf-8?B?MDVpMElOdGtnRWZ5K0RRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FhU09mdjYxYWtHZkxBQmFoOWlieFJBUzFYYVIzVW5IWmZET1NMYkdpVUph?=
 =?utf-8?B?bWFzQlZ4TXRRcTVIYThqSE5yMEgybzJBamZXM0VKMnE4Wm1URU1sWVBUcUxI?=
 =?utf-8?B?VDFUVG1mZkVYcHlTL1ZYK3U1SzBNOWNEWWJvZW9MTVVONEllNnRVay9ZUWRT?=
 =?utf-8?B?QWZ3M0FFUWZnN3hETWRPRlltU2dEVnpUZVhpZUVFTEFmVmlFaFFPdmQwWjVK?=
 =?utf-8?B?UEJJbndUajYrNXNMblRrYmRZV1JCM0ltODB6Zlg2UkFpZEJ6NXJieWN4SDIw?=
 =?utf-8?B?Tms4b0V4NW5rM0RqUFBrNWxZUFdmTjc1bHp0dWRRUjZSMmdML1R2QkZ0WkI0?=
 =?utf-8?B?OXhUWlE1OGFESUJGMVlkdzUvV0ZrWlR3NUwxNlg0aUNyUktWOXRZUG1JRW5U?=
 =?utf-8?B?QmpJMTNaaW1WY0p3N1ZYdCsrazJSZVJPa1o1SzUxUnNiWnBJSm1ZZWhuaXZH?=
 =?utf-8?B?S0RWL3B3d0EwdmFDWEhKQUdJYmV2d3pCUmtSSXBibjlUYjQvNTRNaWVud01x?=
 =?utf-8?B?UXRBSmM3c256YWxUZjUzNzRweUYxMUcrRjBHWDM2QkxBMmZDL2xCaVNUbHpj?=
 =?utf-8?B?UWNMemZySnJHNDZTMmg3Nk1CTU1MMGVtWnA4QXFPQStYWlcyTW1iNkFSVDFo?=
 =?utf-8?B?RUdIcU9kL3NRQ1ZIUE9VcG5wemJXdVprN21rVVk4NHdkVWRYeWNhMk94Z01o?=
 =?utf-8?B?L0IyTFdzcFE5eVk5T0QxZnNEUEdnRTZLMVFSNkoxaUcxRWpENWg4VE9vcHNu?=
 =?utf-8?B?RnlxU0tnUmVxVXBPanlNUEowNWU3SC9DUjAvZ0poWEZ0aU91NGhHQ1JSMXZW?=
 =?utf-8?B?dVdKVW5sQ3JVQUhvWFhKTjJGb0RiQTJ4cG5YZFZmdk10QlNtRFR2ODZDTGpS?=
 =?utf-8?B?b0ttWWh3YXR1ZUhjVnN4WGRPZk53S0JjZXVIcmRkcUxnNUpwTkhZYnlBWHpX?=
 =?utf-8?B?TTN2Y0h2VG5NbTUvcTl1RlZtMU9OSjRNMm1tOXRrcks5eWhIV29MVnBxQWNj?=
 =?utf-8?B?SS94QnYwU3crYVdkRXpFbGdwSFZLQnR6bEJRejFva1ZBSWtEVFkySDdvbkF4?=
 =?utf-8?B?OGtRZjkzWWttREtnOW9jc2ZoeUE5bnc5S0ZDd0g1QzZ2Vi9BYXRrcCtLRmdE?=
 =?utf-8?B?Y2JHdG5rdlp3VEtINitDWEdNTytOSTVBOFljclZlS1M0bFB3L0ZPYUw4WmpT?=
 =?utf-8?B?NXBNcUlCMzF5dnVWNkFldUFnL0MyUXg3U29SVHRiQVVmZ21hemU2V0JIU3Ft?=
 =?utf-8?B?elVMQ1hxNStIa29Dc1JVRDJJOFVzeUpYeit6R01ESllrRTFwTE5wS0ZobUtL?=
 =?utf-8?B?aHdyMWtmNXVDNVh2U2YvcEoyMlpoSVJUb1U3OW5MZkwrUVFMUzhta1N5YTBM?=
 =?utf-8?B?UnlpMzZwNTBya2pGVElUQXNDM3lwaEVTUGx2d3dhK3VQaVlJcEhhQmIwNXZD?=
 =?utf-8?B?d1pwaFY1aG05N3hsMStRUUpsQUJGOEJyQmFBSWZQVFY4ZDJpSk9Wa0NxU1Vt?=
 =?utf-8?B?MzF2UGV2TXFqemdJOFBWUHNVdjJNMi9BdTVwMVlWSGxUNkdSdk4waEVxNkpl?=
 =?utf-8?B?YXdlNUlRenJ4OTZvdkZuekxaZ0hlQjR4bC9ESmVjRFIydlptSmRsVEk2Ri9t?=
 =?utf-8?B?ZEMwTTF1bFdNM0hTcGtJZllyK2VENFkreitBSXN5STZWTXRGYVp0cjNqS29T?=
 =?utf-8?B?S3NnaG9TV3JnTFZLOW9LUERRRENraVlWWUFOUTkzV0ZaUzNhd0hraUxvYTFj?=
 =?utf-8?B?TG11SS92NEtnQVVMVld3WTA2WnBKcWkxYlYyaWdoOWlmOVBBL2x5U01zV1pL?=
 =?utf-8?B?U0RXTUU2L0UzTDRZQmZ0anAyOFZ4Y3A1OTlQcS9LcERwS2xMZXdTOXJuUHRI?=
 =?utf-8?B?TWJoV0EwRE52Ylo5MzhyRHh0aDVBd01uVEc5enowV2xRbFo3V0h2R3hMYmF3?=
 =?utf-8?B?cythUnEzNG9iYkVOWVQyQm9UQ2JlR0FQRW93TzNtcjNRYW9STWYvc3czVlF1?=
 =?utf-8?B?Ulk0b0tiMlM1S2NoekZ5UVgwd3V0amtuTTVWV2dYN240VmpnK25DM2M1cFRh?=
 =?utf-8?B?b1V3cTZEc2JYR3FScFVPMXA1cGNiZmdUNUoyc2RtQlZVeHVQaEJSUmwxdjl1?=
 =?utf-8?B?VWVGV0srWGtSaVhhRXU1L20ybWFad01iUnluZ21RcFUzVzNVa3JQTEUxMW1N?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d2357-3261-4b93-07aa-08dc9ae55f93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:21:52.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiFcM2vhlPYYTu3SFG1918HiuMt2lsZOBMmR1bQi6afhwsoqApkJZKk2iU++adQiXZbhdkCxeYmSNPyOaqWFBqF9JS0Ia/kML7IByTC57rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
> Resctrl selftest prints a message on test failure that Sub-Numa
> Clustering (SNC) could be enabled and points the user to check theirs BIOS

theirs BIOS -> their BIOS?

> settings. No actual check is performed before printing that message so
> it is not very accurate in pinpointing a problem.
> 
> Figuring out if SNC is enabled is only one part of the problem, the
> others being whether the detected SNC mode is reliable and whether the
> kernel supports SNC in resctrl.
> 
> When there is SNC support for kernel's resctrl subsystem and SNC is
> enabled then sub node files are created for each node in the resctrlfs.
> The sub node files exist in each regular node's L3 monitoring directory.
> The reliable path to check for existence of sub node files is
> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.
> 
> To check if SNC detection is reliable one can check the
> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
> are operational and the ratio should be calculated correctly. If it has
> any contents, it means the detected SNC mode can't be trusted and should
> be disabled.
> 
> Add helpers for detecting SNC mode and checking its reliability.
> 
> Detect SNC mode once and let other tests inherit that information.
> 
> Add messages to alert the user when SNC detection could return incorrect
> results.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
> - Add printing the discovered SNC mode. (Reinette)
> - Change method of kernel support discovery from cache sizes to
>    existance of sub node files.
> - Check if SNC detection is unreliable.
> - Move SNC detection to only the first run_single_test() instead on
>    error at the end of test runs.
> - Add global value to remind user at the end of relevant tests if SNC
>    detection was found to be unreliable.
> - Redo the patch message after the changes.
> 
> Changelog v2:
> - Move snc_ways() checks from individual tests into
>    snc_kernel_support().
> - Write better comment for snc_kernel_support().
> 
>   tools/testing/selftests/resctrl/cache.c       |  3 +
>   tools/testing/selftests/resctrl/cmt_test.c    |  4 +-
>   tools/testing/selftests/resctrl/mba_test.c    |  4 ++
>   tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  4 ++
>   .../testing/selftests/resctrl/resctrl_tests.c |  7 ++
>   tools/testing/selftests/resctrl/resctrlfs.c   | 70 ++++++++++++++++++-
>   7 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 1ff1104e6575..9885d64b8a21 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -186,4 +186,7 @@ void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool
>   	ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
>   	ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
>   		       cache_span);
> +	if (snc_unreliable)
> +		ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");

The message abour SNC detection being unreliable is already printed at beginning of every
test so I do not think it is necessary to print it again at this point.

> +
>   }
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 0c045080d808..588543ae2654 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -175,8 +175,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>   		goto out;
>   
>   	ret = check_results(&param, span, n);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");

This message does seem to still be applicable if snc_unreliable == 1.

> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>   
>   out:
>   	free(span_str);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index ab8496a4925b..c91e85f11285 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -108,6 +108,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
>   		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>   		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
> +		if (snc_unreliable)
> +			ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");

(here I also think this is unnecessary)

>   		if (avg_diff_per > MAX_DIFF_PERCENT)
>   			ret = true;
>   	}
> @@ -179,6 +181,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>   		return ret;
>   
>   	ret = check_results();
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>   
>   	return ret;
>   }
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 6b5a3b52d861..562b02118270 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -43,6 +43,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>   	ksft_print_msg("Span (MB): %zu\n", span / MB);
>   	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>   	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
> +	if (snc_unreliable)
> +		ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
>   
>   	return ret;
>   }
> @@ -147,8 +149,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>   		return ret;
>   
>   	ret = check_results(DEFAULT_SPAN);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");

This message does seem to still be applicable if snc_unreliable == 1.

> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>   
>   	return ret;
>   }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 851b37c9c38a..fa44e1cde21b 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -121,10 +121,13 @@ struct perf_event_read {
>    */
>   extern volatile int *value_sink;
>   
> +extern int snc_unreliable;
> +
>   extern char llc_occup_path[1024];
>   
>   int snc_nodes_per_l3_cache(void);
>   int get_vendor(void);
> +int get_snc_mode(void);
>   bool check_resctrlfs_support(void);
>   int filter_dmesg(void);
>   int get_domain_id(const char *resource, int cpu_no, int *domain_id);
> @@ -167,6 +170,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>   int signal_handler_register(const struct resctrl_test *test);
>   void signal_handler_unregister(void);
>   unsigned int count_bits(unsigned long n);
> +int snc_kernel_support(void);
>   
>   void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
>   void perf_event_initialize_read_format(struct perf_event_read *pe_read);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ecbb7605a981..b17560bbaf5c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -12,6 +12,7 @@
>   
>   /* Volatile memory sink to prevent compiler optimizations */
>   static volatile int sink_target;
> +static int snc_mode;

This global seems unnecessary (more later) and also potentially confusing since
the get_snc_mode() has a function local static variable of same name.

>   volatile int *value_sink = &sink_target;
>   
>   static struct resctrl_test *resctrl_tests[] = {
> @@ -123,6 +124,12 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>   	if (test->disabled)
>   		return;
>   
> +	if (!snc_mode) {
> +		snc_mode = get_snc_mode();
> +		if (snc_mode > 1)


 From what I can tell this is the only place the global is used and this can just be:
		if (get_snc_mode() > 1)

> +			ksft_print_msg("SNC-%d mode discovered!\n", snc_mode);
> +	}
> +
>   	if (!test_vendor_specific_check(test)) {
>   		ksft_test_result_skip("Hardware does not support %s\n", test->name);
>   		return;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 18a31a2ba7b3..004fb6649789 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -13,6 +13,8 @@
>   
>   #include "resctrl.h"
>   
> +int snc_unreliable;
> +
>   static int find_resctrl_mount(char *buffer)
>   {
>   	FILE *mounts;
> @@ -280,7 +282,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>   	 * with a fully populated L3 mask in the schemata file.
>   	 */
>   	if (cache_num == 3)
> -		*cache_size /= snc_nodes_per_l3_cache();
> +		*cache_size /= get_snc_mode();

hmmm ... it is not ideal to use second patch to change something from first patch.
Just having a single snc_nodes_per_l3_cache() will eliminate this change (more below).

>   	return 0;
>   }
>   
> @@ -939,3 +941,69 @@ unsigned int count_bits(unsigned long n)
>   
>   	return count;
>   }
> +
> +static bool cpus_offline_empty(void)
> +{
> +	char offline_cpus_str[64];
> +	FILE *fp;
> +
> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
> +		if (!errno) {
> +			fclose(fp);
> +			return 1;
> +		}
> +		ksft_perror("Could not read offline CPUs file!");
> +	}
> +
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +int get_snc_mode(void)
> +{
> +	static int snc_mode;
> +
> +	if (!snc_mode) {
> +		snc_mode = snc_nodes_per_l3_cache();
> +		if (!cpus_offline_empty()) {
> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs!\n");
> +			ksft_print_msg("Setting SNC mode to disabled.\n");
> +			snc_mode = 1;
> +			snc_unreliable = 1;
> +		}
> +	}
> +
> +	return snc_mode;
> +}

I think the SNC detection will be easier to understand if it is done in a single
place. Can the static local variable and checks using the offline file instead be included in
existing snc_nodes_per_l3_cache()?

> +
> +/**
> + * snc_kernel_support - Compare system reported cache size and resctrl
> + * reported cache size to get an idea if SNC is supported on the kernel side.

This comment does not seem to match what the function does.

> + *
> + * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
> + * supported, < 0 on failure.
> + */
> +int snc_kernel_support(void)
> +{
> +	char node_path[PATH_MAX];
> +	struct stat statbuf;
> +	int ret;
> +
> +	ret = get_snc_mode();
> +	/*
> +	 * If SNC is disabled then its kernel support isn't important. If value
> +	 * is smaller than 1 an error happened.

How can a value smaller than 1 be returned?

> +	 */
> +	if (ret <= 1)
> +		return ret;
> +
> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
> +		 "mon_L3_00/mon_sub_L3_00");
> +
> +	if (!stat(node_path, &statbuf))
> +		return 1;
> +
> +	return 0;
> +}


Reinette

