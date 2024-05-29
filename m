Return-Path: <linux-kselftest+bounces-10848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2B8D3D9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A131F25ABB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C9181D07;
	Wed, 29 May 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrkGIgkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7F7492;
	Wed, 29 May 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004837; cv=fail; b=enycwE30O96dsC4cHSTEmAxuaKRhGczmBUyuymv+skUKj5IvkJeY2bFtykGxirIVnu75De9xOUi2Kwtn6Y8N/azlvJCBSGEgzbKi0DBeZMRbiuzWbPsyRDBZplctYbYIMNSlPZX7e/gcs24sEdT0egh9qYhqpAch5m6hDeAf5r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004837; c=relaxed/simple;
	bh=MxDPDEkUNDYEBkxf3by4qolKrl3LwSjNHffoErZp+jk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uM7JfLftzjubQ+PJvjrDay5sZF+XTiUPtMjVp6cQ8X9m8ELXYCAVz7h0GFbJppMZ0i7fOJYY0W79qm3V6o3Pjrv0Km05VfG/yEzOtzfg24EdR+gSOzM+EfiIDFMuTeCmGVqGRruLxRK8waSh4y7O9HKn9YXnJLaewV2AtBpxUwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrkGIgkO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004837; x=1748540837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MxDPDEkUNDYEBkxf3by4qolKrl3LwSjNHffoErZp+jk=;
  b=OrkGIgkOa1ONhwy+maIdCeLb34xnp0Mls28nsDRXK1sDQwk7zjwdFHE5
   MPs4LLCQhmO7IGy10oKpIp1IJit72ld/Q7W/OFhcDuHTkLk3UThyK7aN7
   KY7N5F+wT/ekQN2Mm3xpUWoR44tR5XmxMiHRY77O6SAa0fp0Hv0vr+ZpK
   KjP2mMmqPDORZ7oh6Hx9BFeETrR1sOYVEp6uGAa7BMy6wSXh2AMJbUV5W
   XCk9BHGfSYYUowE6szAOLO8LM28tlIIYdlq4Fk25yYRVp1JkCsDQp/Xok
   cdMhzLu5ff6W8OO0n8JLEfYo0eWLlQjgEuNVtMHlS8vwdE2D3nh4i8dp8
   Q==;
X-CSE-ConnectionGUID: v3AYl4JbRtWC2BYbtYH7YQ==
X-CSE-MsgGUID: s7p6YxNAQf+hief1ZYQuIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17263596"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17263596"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:47:16 -0700
X-CSE-ConnectionGUID: lV6CI2txTL+avsewLv5Qmg==
X-CSE-MsgGUID: rTUi835KQjqLGgjEpRqpFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35476109"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:47:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:47:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:47:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:47:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccAwyrQp/P3MHlFjxcjHNtngS1IuX1vbSOr80tTvA0ZUjbRx6p7KxjTSnlGoDrFCmhjyG2u4fHBW325f9OQ7L3z/+ojH+0XrER6+tIhQdwAX3haD9ch0uQY6U1rk51ji1p/YGnDxkz4aLuFjLgUDVbam+eR2QI5vmUahX5MSOEwKuJeb0QLdCdVpoxspA1oo2yNexohIEoV5h5SE3qVVrii+IHI8oLBz/C5dlLsCqjRmOOTf4FymT/pbIxI34ThXAXbHkGDXlNyeUYRKUSH9MYVpoYZAGohdhIABFFjiPzuCj2d4dPL5WD6gkeOFAmm3QVwU6Nwkcl/LJDSB0hJnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ad/YwYLL0XdactNM8l5CeLPO/sFqkOFhJgf0UELYyc=;
 b=FZFMnbv9tCDItrtRNeqQsgX515FVmmz6aaYSYFMRCQ0DSeks1oIbxiT3M9DSPS75daBY9V/H0Vmk8w29WjrqntzucopRROBiewvXN2Ow5QNU1d6BLbRwhnRvOGupb+kIGMZqhl6ZS7xv0r2P/rt7pVylqxAbDLwR8CQv6Ec+8SwwEzSuLcl3xBB316zGfjZtNiGYbyIU9nWXo4a7WXkILmx69aSatHZw53VbvbsAHXduHbAugJJ6yhG1yvZb7hmzuV8gujunmafF0LXFqYyRVI8EhZYK5GSeU9N2XPD7k/Aae7+qFwE7LzL16S2Z9umMu2FQks65+h+AliLcJtj/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 17:47:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:47:12 +0000
Message-ID: <083f8f41-5192-48df-9498-b448cad2d23c@intel.com>
Date: Wed, 29 May 2024 10:47:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/16] selftests/resctrl: Make some strings passed to
 resctrlfs functions const
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-13-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: a27b6c9b-b57b-4d7e-94d9-08dc80075ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1daRzE4S2RDcVU0NThvcERSK0pHa2p4SlFwY2RuQnh1QU5VN3lhL09lVUpY?=
 =?utf-8?B?bE1ucThzVlN0Yi9HOEliYnQ2OG1jM3ltUE9hd2JaUUU3TFlFMFdjNGI0NXRC?=
 =?utf-8?B?OGNtTG00VEh4bS9sb0drQStOWnU0SWtETms5Tnp5eVVTQ0tsa0dKam5GNTBs?=
 =?utf-8?B?WE9YQVFmOU5SLzhaRGJjM0ZuN2tPQldWQXRUVEdEYVdGOWwzUlp3Sjk1a1J5?=
 =?utf-8?B?QW5ybjdiWTlZRjJvbGlMYUo1NEx0OGYrdzBZTDhRc1ZsWXk4eHJ2REZ2TVZp?=
 =?utf-8?B?SDgwZXhBRm4zNG1HZWJFWlppSjdRZHgxcXAvdWVOWkFvaGJ6cE5xc0Q2bnRp?=
 =?utf-8?B?bGxoQWVIMXNWellBb2VNUzJsckZNaC9WTlRONXkwQTZjNmxvTDFkK1krdWMy?=
 =?utf-8?B?Tjdxc1oxNHA1MllrRWdyUGVGa3gyT3B4dm8zNzB2RmVFS1J4cm44S0VaTnVF?=
 =?utf-8?B?bFRMM0RCeEVoVTMzNGdoV1R1ekgrS0FKN09KMUx6V3NwcnJFK0dnUTNYa3F2?=
 =?utf-8?B?OHZIc2ZmWngxSW95NlpucUtLMVNQUU5qWjZ3T21yeXZJNDY3dHFRdytsdVRM?=
 =?utf-8?B?b1pWTHZSMVhSQlhtRHlyMVNESlJPNHNkNkxha25UM1dwdXlBbHo4MCswQm9O?=
 =?utf-8?B?aGRpdWhhejk3aVVmMUFwS2NnZjFncjlidHpEc1BZRlpUblZ0SDlkdzVDNHkw?=
 =?utf-8?B?azJOWkR2NndSY253eHovTGp6L1BiMEMyZk9RQXFYQ1EzM2svd1ZjUnBtdllZ?=
 =?utf-8?B?bzI2ajRJb28zbnZzYk9OKzBQOCttVGZ5REZvc3FhdTJNOVphbWIwZ2lLdURw?=
 =?utf-8?B?RklkZ3dVcG5ZcXZYZGZPRzVaZTRHdW5iV2NYL3RpQlZXd0xGRDdtLzB1d0tG?=
 =?utf-8?B?aHB4d3JsczJOVnIwMGdrWXd0K2tpdnB6SXB3S3FTK3VZYUdZSlBENHpiSStw?=
 =?utf-8?B?WHRBYjRCSmRCYk9wTjlIdzcxT3BrRlVxSkZKWldpMFRIcHA5VkNFYXlUMXZw?=
 =?utf-8?B?RXdIVEFJT0swUFlnVk9OZkJIMnhOMENKMnQ5Z1ZlVXQvbFZRb2pJalFyR3RH?=
 =?utf-8?B?U2hsSGZ3WlEwblpVQ3k5K1hJa0p1Y2NnM0c0WXBpdGlTRFlOMkZkWEppOVps?=
 =?utf-8?B?L1BHNXN5L1pZMUlvb3g5U1ZUMTRmSkJXVnhsWEdOcU1yWEk3S3puK2gycENH?=
 =?utf-8?B?a010QXJ0VWY0d0Rnd3BWYXpFaWthaTk1VFQyZk12SWZ2RlJobFpoZ3ZMVEFT?=
 =?utf-8?B?cUE5U0gxc0JNWHNtZytyREwvU3Y1Q09FR3FpTUQyd3V3VUREOGtNTXIvV0x4?=
 =?utf-8?B?NG9kN29GV05jTi9uUGNWVFNnQVRFMGZpL2h0T2tLRERKRG9NaVM1OXAvYndK?=
 =?utf-8?B?djlxMHp6RjFOdm45S0I5S0lHMTF1cXpXeEhSY1RobG1UUnBMRG1NSk9GWFN3?=
 =?utf-8?B?WFlyK29vRWVpWnlpdHJnTWk4Tk82VWt2aWIrYVVNU1Y0S3lRdXZZbUd4dUp4?=
 =?utf-8?B?Z2RlRWJvR0pFWkFDNlVaVFRJY2lXbEVoV2NYN000bnZoRCtBUVFYaXVramR2?=
 =?utf-8?B?VE9jb0F4UUlsT0NUNkcwZFFOeE1xVDJVL3czSmlqSDIzVHdSZjJqOVU2anVr?=
 =?utf-8?B?SitvQWFCOE9KNHp2QzdKanZBeVdlU3lGZGQ2OFluZTgwREVSYWNhVXk2QWg0?=
 =?utf-8?B?OWJwN2o5dGdpY1lIN1BqTHI4b2pOOXpPYmtwaThvclhkbm8xdGFJSWhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FDeklsSHJjZEZGdXlBaVJkaDlsTFJUZDZmbFN6MVpjc2RpOFFnY1hNK1du?=
 =?utf-8?B?SDNiMUV2cXE1MldScUJCdUxua2RCQjU3WHlMUmJKTHhQYVhhN0hRVEFGejRC?=
 =?utf-8?B?Q0c2N1AvaTRSY2g2alhIWmdUQjBLRWxuak4yUjhvTEZlSnNPU3JadDRsejBW?=
 =?utf-8?B?ZWltRVZUNXdTRXJKa0hvTjU4a0VDZ3k2ZzFBRFZyRWRrdlU2SWx6WUV5WnNr?=
 =?utf-8?B?UVovaG9GdW9TVmFLU2ZoMHQ0WGxFdmM5Vk93dmswd2ZUYXh6RGhmSDhHaUNZ?=
 =?utf-8?B?c3kra1FZQ25kRjRRakdBdzluSE5MSVdlVW1VWnlEZTlxazN4akN1SWFtOXg4?=
 =?utf-8?B?cWVLK1NtdTlJNzd2c0FoakVNS25ZS1NkUGRKZHZBTEU4elhWa1NNZ1d5TzFq?=
 =?utf-8?B?R0kvZXkrN05kZy95RDlVMWdhRmFyNW5aTS9sTGtmK1VkUE5XZ0N6ZVhVNzBG?=
 =?utf-8?B?aUNBdzJpa2ZmMzNBVVR5VEpNRDNXMzN5Z1phVjZXSVUwcDFqRkxERGtuSDNn?=
 =?utf-8?B?d3cyRFpPbllndEdzSzFVby9MOEMwNG9USjUwdkhUOE4ycis1bk1ObjdlOFZX?=
 =?utf-8?B?RnV3SVFFZGhHZ3BwVEh3UEtWWkxoM3hTeGMvam5Kbmp4SHByTGFzUUdhZklw?=
 =?utf-8?B?ZkVPbmNSRXc4RndtSS8zNU0rL0w2MGFDcXI2bU1YQVYrdTRxVmVSbWZodFZU?=
 =?utf-8?B?d2lFSXAzNUlUL1c1VjRIM3EvbGdtbjhxYW5ma1ZqVXU4aHVXVlhJSXVKaWR1?=
 =?utf-8?B?UDkvODZwZUJTRnU4dHllaFp5NEIyTzJ6OVBxb3k5dDB0RHgzbmo3cWFmcnJD?=
 =?utf-8?B?MU5Rbkd4U0tsbG9VRjJOMDk5dGk1TkUyMGozTkszVjc0Y1kyWkorcG13VzB2?=
 =?utf-8?B?U3ZlM3Nib2JhMEZSS3h2aXdnN2xUSCtnNENlM1p3dUdQM1MrUlRqM3JxZlJB?=
 =?utf-8?B?N053QXpGQ3ArUHFoU0tNcFVvcC9CSTZyNHBjR1lyMTdlSU5VWlphemRTVDI4?=
 =?utf-8?B?cnBwRlloK252NHFyLys4b2JaWklLdGsyTTdwSk9KQW1oeThYcVJRcDNnNytm?=
 =?utf-8?B?Qm02KzFBdW5QanJZL2Q2cGQrRXIxb3lPdlRRRWdSOERDeGtVVG92aXNqS3cx?=
 =?utf-8?B?eHg2eGMzWG5VTXZIejRRd0tGUXdrN25uNThpSTJiS2ZFNXU3MFlkOForUTFp?=
 =?utf-8?B?dVBVWURsTDMxQU1zQkNJcDdwS2J5MnJzVk0xSHFLd29ndzUxcGo3QWtnOUFo?=
 =?utf-8?B?bDcrVTVmYVgrM3hwV1BQODZCZnlHNEp0eUxIeDJoMyt1TGVFNzZ6cmduZ0NG?=
 =?utf-8?B?Z1RyOG5KbFBhZ1NHTnlWWkVRV3d6NkVVOHFKcUYzd0lwTGVXZkJLK21tbXRu?=
 =?utf-8?B?SVl1UXhKY1dyOXNLZGYwZDAvMTM2ZHdXUVo0bFR4bVNOby9aYmYwcWszSUJv?=
 =?utf-8?B?V1RBSy95dkE0MTY5TEhBTTZDbFhNZjB1VVlnczE3dHB3S2Q2TjFkdGpXb29s?=
 =?utf-8?B?L3o4Y0ZrVHVVL3prd0ZDRENFT2NON0ZFcGJ5Z1J5ekpueEJZMHhma0ptZ1NV?=
 =?utf-8?B?OUpJZWNqMERWVUFtU3Q2YWJLcWNyYWhuL1pvOFJ0dGpPM2Q4aWE2eS9NdHRP?=
 =?utf-8?B?cWtjNG9vUXVITjVHaWF2ZjNmSUFlYSs3WGRrZXdyRXNtRjJGY0ozNk81T2J0?=
 =?utf-8?B?WEFpYWI1NUhIRWROaUxwZzUzVkZ1WEV6NGVQZEI1RTk0VkNBV1lySjBvV0Yr?=
 =?utf-8?B?ZGxqUGIyZnZLdXdRZi9kZ3ZsVytMYVZmeEw5MjlQWExXc0ppUkRPVVRCV2tD?=
 =?utf-8?B?aThmeXBOTTdSMXE1UjNmc0Q0Wm12Mm02eTB1dWFVVHlBMmxNdUkvZHZ0Rk5r?=
 =?utf-8?B?QU1PMTQ5U0d6Qk9pTFFWSXQzSzhPVk1lRWFqeldVN0REQ1hvSXhvajFETjVk?=
 =?utf-8?B?MzB4NS91SWpHdVpqT3ZPSXFwR3FjMGpER20yRit3RGdkOFdvcXg4VUV3MXpS?=
 =?utf-8?B?aHk5YkV2WHdTaU9RVUtxNEU4VzZrVnE5QjZueGNxZXJVclNBVG05bnlDNEVM?=
 =?utf-8?B?T3BtTDN3aVFyYWRWR0ErQ3p1K0w1UUtjQjFpb0FiVGxyRjFPK1c3cHJDQmhZ?=
 =?utf-8?B?OWFnZFhOdEEvcVZIakE0VnRMb3cwendkR3lORSt0cGIyNFpUWmNYaExZWWVl?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a27b6c9b-b57b-4d7e-94d9-08dc80075ecc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:47:12.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bizJhyo+PrFPQEUEPMBfpssh/J2IR6e4WkQIKWvf9w6435VKaCTUZnnrIKI0AmTYhT1oh5OadNTwpTEfFpcp8LhdzIqfxhFMXaNjnx5qFAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> Control group, monitor group and resctrl_val are not mutated and
> should not be mutated within resctrlfs.c functions.
> 
> Mark this by using const char * for the arguments.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

