Return-Path: <linux-kselftest+bounces-4581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B12853C62
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 21:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C20828C24B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EEE612F0;
	Tue, 13 Feb 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYpzxq8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E0612D2
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857309; cv=fail; b=TjEGaD/T1ONcKyk2d5I7Gthx5LthcElbip/Hlk4xs2yenyfhKatQHlpenQwnqCUo9lSUS++XWt4P4B1izNPWrYx4scY5TZ15UPO31aqn6mVGcP9f4SR1pY2/ofbhLQB7l/NDwk0z1OFCoa16gvK33jW7oVh5xkF5EJLOjqxH7lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857309; c=relaxed/simple;
	bh=SgBsmmetjJihUoDVjIFcuZFbPl0W/FSH6WC3LDzEMnQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVGI9C6oOVESfwtCwbwR/PgSAj5PPCYL9K3B2Iq+XeD7A9xB4F0h+36uvnj7rt4bx+2Vz6u588ls6/dvQ+yPic5yCx1zEAZXiJCjcacKre0bUL8z0UcvmhmAoXyqhm+Fmuc9t/zee34p/r7X4F9DoZ9YM8ovQfIelOkB6gtudBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYpzxq8C; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707857308; x=1739393308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SgBsmmetjJihUoDVjIFcuZFbPl0W/FSH6WC3LDzEMnQ=;
  b=MYpzxq8CafORMfht1ZT98lfADEafpN/HtNmNIhZ2P10cxd6NC4jZSEdO
   fPZ4iA+D4tBgy+iB0ige2J9X0/NwvAiAOB1BtFUb/9PckInbYzVjivQD9
   sdan2yL+/TJcY73JKuc5CKVWrsYSzr07wE3x3Xsu3KuYVannF+rcW57IE
   6UU6tlCxGhz9ahYUaP+6lstBEwlV+JOZ2DN+Lz/nDvqwR9WNXK+y6FDWv
   s6SkZfxd5m8ecLRJ0qf+nzojI3PDdGFv5JQLZ+LHFHq9lksQjzE1KeanM
   KaaqwQP3qe7q+9qEpKy9VhcNYyJ5en0+/hvydwrsSoemb+xVpxgVIJ4Yk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12516875"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="12516875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 12:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911892053"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="911892053"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 12:48:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 12:48:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 12:48:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 12:48:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 12:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwkFHOh6kgotENs1YF2Q9lIZhgxX1lEvwTW+0J3bSCnS9LKrcfiw7miBlQF8sqIEgFANe5GRH1LrlB6ib9Twh8w9YJ+OLcXzs88nOe6gU/rr8yGKXhSm2A/cfM1im4pzIZ0XY5kc/xysRE5S1VHfab6XRWGCJ6u7FKNi12wlc0udQaVSYfOOVO36T8RzLjB5feCNC2c5CtdQSMTzFERO2QPHqB4/5jqDoaTX5IjZhIJe+mY3J20CJWgDHfScW36Rff2RWVUdBvxP/SZ2ohy0RZRPjqT9EUWETbf0fpO1FYCBZLnxPnULk/gPuHjp6GpoAXl4iCjbz6wXq07KokZQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frIez1O/jUEwXaQwlYyVH5SWACBrJjMos50wr0hf2Vo=;
 b=AGGPcGns4Yvj//Q98z4+AaWsicKhZhyLjH4ygBmpjGqn3wGdsJgAwtdo/NQOOACRYJBuBVqho81MPX6wiVyo6kEdyzbtcHxOqN/VUNRmmUPbGz7+ND3W7+cE08KDHYGpDU11p3Pnoi7NA3pZIG5KPujLTFf5GFSuPfKDK1uZdbbnJy+Lx8LNixvw4fZYDUT9dEFzRZdWZ81StBDr4+8PebdKcIgAVulKVyU6uCHKZ6SyilJZFI//2HuT0OCW67c4nN5NzGrs+izhrf1roElOuRoarIkCje3VzR4IY6Uy9BvSyQOVc3lzvGzb2XPOKhjMrHAX5vq+HmuV/DIWm8+i9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 20:48:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Tue, 13 Feb 2024
 20:48:12 +0000
Message-ID: <df840413-fa3c-409e-b20d-7e2b69eb626f@intel.com>
Date: Tue, 13 Feb 2024 12:48:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl selftests ready for inclusion
To: Shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
 <c1c08466-2eba-4f54-a557-ffa6a0c3b4cd@intel.com>
 <6a035dc4-92a6-4220-bde6-a0b5e532b8ed@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6a035dc4-92a6-4220-bde6-a0b5e532b8ed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: f2774e89-3d34-4467-62d6-08dc2cd5180d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf7tTCStiXmtFsPSiol132Gag28uhIndwlMO+jpJVY1hsltLd0cgXo9rd3aI/YNZ8NhJLbKvQHRB+LJtTgy0I+tLn0DpWmHSNaaC+TNu9Z7JGUIUr7/blEhsepJuZhcX2Wb/PRBGHhIaTRzftkct89ScrUcdy0r477TeYQlkmUxmbL4MVXjCpV75PXSxT+L8heW7NMID0KZAtDdjxlXdpn6F1QXpx8rm5SzUBWMXGIR8o1FeqjBmCd1NhymyFd0855o+BLmTI5WW2F1PlJ7NvFma7uUCViOlEswqox3JtZH+glktpUO1mAawtzuwuRKqSJfzLAm5hGaMaHTLui2K+j5KAQtp62Sp5CRFqreZ1CvN3V789BRvFiirVpw58D6xAtOXq59c4e6yB9jtARcTNwco5Up4jdRKmgE5BlXUg5nJVaZ1KlRmGIYusrCRD7C3LR2dVdb7RyUa/KNZghYL7W2Lhx/ahY31yJZSruMCf3p+N+05es3Yo/gj+KYe9fHepaeF5zI0FKxBmxMd43gaqRq9izFRY8v0p1rWFUCIj5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(36756003)(66476007)(66946007)(53546011)(478600001)(83380400001)(26005)(5660300002)(6512007)(8936002)(6506007)(6486002)(66556008)(4326008)(8676002)(54906003)(966005)(316002)(110136005)(86362001)(82960400001)(38100700002)(31696002)(2616005)(41300700001)(2906002)(44832011)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTB0L2ZManNDc2tIM1luSzN3b2dRbHFGOFo2VHhBcDJOYS84dDdKRnkyZUNt?=
 =?utf-8?B?YmEyVndVUDcrSGJzQVZhVWtCTTlIOU1paml0cThGaWEwcUpZcE84NGFTYnFw?=
 =?utf-8?B?alpsUDlJODZWNXBla0ZmRDlTN1FCdFJMMDNhUjNVN3ZvMk4vZk02VkhVN0RC?=
 =?utf-8?B?WU5USEtQY2VJQ3lFRXZtMW9SRkl6RmczZkh1T0Zkb1RucElBTjl4R3VTS2lG?=
 =?utf-8?B?bjRUSEcrejZ5bDVpbzJWOVREVTJDSWRVbHN1UmJJSWZXL0tBUHJHci92UDlj?=
 =?utf-8?B?bDFhbUFoY3FlS1Vwb3k5b0lXeHFHRlA5MVArQjdMTkFiN2x2cno3aEJiTFQ4?=
 =?utf-8?B?K1QyV3dkNlBGbDllUVFnUXptN290dklLMG0xdzhnS3AvOUhNYzJBdENMc3FG?=
 =?utf-8?B?dE44NVdhM2p3N0p0b291WmVaQ0drUlFhOFdJY1JrVkVCN29XR0llM0pYUVJP?=
 =?utf-8?B?Rm10dWQ5dGs1VlZkWmZLSTV4Sm4vUE9sQ0czbjBlVVNhMm5zRGxxRktJRlFQ?=
 =?utf-8?B?bWljdUlsRWJhTFg2YVh4ekZFcm0vNUYrRW5uU0lNVmpiR3BnbnBVbjRUazFr?=
 =?utf-8?B?bTZ3bGNiK1l4aFFsZUZHaGRYWEhWZ1lPcjI0a2hBdlNzQXY3L2tScWs4TllX?=
 =?utf-8?B?OUZPU2Zza1YzTFRyM1ZZbVpoNjRMQjdvRmFOak43bGZ0TFJadXE3ejdCL0tS?=
 =?utf-8?B?dlFBOUJtNFliRmczYVN4eHk5YmozcnluSWVpVGNjTEh0eEVmUWlwK3VpYkh6?=
 =?utf-8?B?MTBHR0NQbU1SQnBjV3JHb01HK1ZZK243SkpBcXQ5bTFrRThVRWNKYy9iWUdw?=
 =?utf-8?B?MXo3YVBYRlJza3VMcmdrVzRFSnBwOXRuRTlyTk9VMDg5Yi9QblV6RXYyTWZ0?=
 =?utf-8?B?T2U1VXpuaWY5MmZncnVlVTc0YVUySUVkc2JaUFlBQWN2NitjZld2TlppZ3pa?=
 =?utf-8?B?YWt2Q1ZyNmRxS2hUK0l0RGlVbnlaTWVEUDRJSGFUUDhSV0M5aERGa0orMXVx?=
 =?utf-8?B?YktodHdDR0hGV21mVGFQNWpXa0dYaC95UWJQa01lejhVclJDL3FQTnVoT2RW?=
 =?utf-8?B?Z3dDQjg0VmN3N2V2UThSMjNmNVk4N040d0FiNzhYNldZNkJvZk5HM1liOW5a?=
 =?utf-8?B?WHVRRExMV0dvbDJSeUhUSHZKUXRDZjJwajB6azgveDRobEpRSXdMZXk3OXJy?=
 =?utf-8?B?RjdqYnZnNFNLWXN0NzRNQnZjMHlHZVc4cUZyYVFZcDdjbXlFbEdEdGtDM2ZF?=
 =?utf-8?B?VG1qYTNmUVlLY3p5L2tKa28xdzRpQXlLcWNlQXZ4aHVmK0VNSEY0cm95ZDNy?=
 =?utf-8?B?TGsvNXBCaXVmUnpQcFNVTXVybFBtTFNIb0hyd3FnMHdaSkhYMG9hYmwwZG9i?=
 =?utf-8?B?MFN4d3AzbWc1aFR6aUgyV1RzdXZldzhrQW5iSFcrT05Ud2JsWFh4d2Q2NW5O?=
 =?utf-8?B?TnFuTVNyOXEwV2NSN0ZLMHE1aHpPOU9DcFZoSkZhWlVaMmg1dHF4OTVNYStB?=
 =?utf-8?B?TW5SSG5TVWVTQXRjUDdIdWx6c0MxSkFtY0M4Zzdpa3JRZlRZcVJ4RDZPT21L?=
 =?utf-8?B?dmRocFdjS0k5MWlUeTZNTVlEc2pEb010WEl5MXhERis0blpwOUFmVUFVVzND?=
 =?utf-8?B?eXNOTmJKVG5PRTlLYkFHZkl3aTZaaHk3UkN1QlJjSnZjWTY3Ti8zZEpFbVox?=
 =?utf-8?B?Qzl4V1JuekpxcjZzaHBjR1ZiWXJYbjM0MThRcVBPZnFjMC9ZVEpTam5ab2x4?=
 =?utf-8?B?aGpRMXBQUEtmOU85R1o5RHY0UU91N3dmaHBJVXZzWG15TFJGcWxDSWtHb1Fw?=
 =?utf-8?B?UWpaa1pIVnZ0U3BLMi8zS1lBZjFNQ2tWd3JNSkZmMlNKSUhucC92R25tRTh6?=
 =?utf-8?B?Y3RVRC85dDgxSXBJQUVNakJIV05VdjMwbDdMYU9scmY1VHdmQ3F4UmRUcm10?=
 =?utf-8?B?OEZkdHcza0R0UmlyMEszU2pVSTV1RENURDRBQk5CQ1VUclZGVjd1MzBILzRW?=
 =?utf-8?B?K1YvelFraGNPQ3V2TGVuOFViT1JTdTFwdm1POTJXNjJMWDlaVzRIVjV3cFR2?=
 =?utf-8?B?cWUrTVJiK1M0a1lvNVVHcGZaczdkcko4TEdTdmhmL2V3VG5SdnkybTBidFM4?=
 =?utf-8?B?MkRkZm1EdDVVSEtNVTFqZWFIaGtLdE9EZzUwYm1oRktpRWRvVWJDbGFOd08x?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2774e89-3d34-4467-62d6-08dc2cd5180d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:48:12.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTiq28nt6bDyPSQXXPccgBw/SFZ3rjoOEPMORg6CquavMxwR4Y6jcoSOrxqk97st8CVkA1nNwPxKwqK4NyyyRuxhLzZLBaEE9Ab3rL3sejA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

Hi Shuah,

On 2/13/2024 11:02 AM, Shuah wrote:
> On 2/8/24 13:10, Reinette Chatre wrote:
>> Hi Shuah,
>>
>> On 1/22/2024 10:06 AM, Reinette Chatre wrote:
>>> Could you please consider Ilpo's resctrl selftest enhancements [1]
>>> for inclusion into kselftest's "next" branch in preparation for the
>>> next merge window?
>>
>> I just confirmed that, even though [1] is almost two months old, it does
>> apply cleanly to kselftest's next branch (tested with HEAD of commit
>> 6a71770442b5 ("selftests: livepatch: Test livepatching a heavily called
>> syscall")).
>>
>> Could you please consider [1] for inclusion into kselftest's "next"
>> branch in preparation for the next merge window? It has reviews
>> from the resctrl side.
>>
>> Thank you very much.
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/
>>
> 
> Sorry about this. I found this in my spam folder. I will pull
> them in now. Thanks for the ping irc.

No problem! Thank you very much for considering this work.

Reinette

