Return-Path: <linux-kselftest+bounces-5389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36C861FD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DC6B221C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E91E508;
	Fri, 23 Feb 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQt4VfU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D99199A2;
	Fri, 23 Feb 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727633; cv=fail; b=cAxh/aXPwK306alxa8HElkrOE+YGg2Gb7YR0F5E5tWXCfYJlYfZoIXysy4/wTcUc998ryV87/r28MTqDjcSU0YHUwTxvs1VdQwYcDJxfALOUKZvSkDVZGhdVnRPD4/wCLbIZRr78FKffwV0ivBJuNc5ZJZ8b1YeT4uRXJBtZFEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727633; c=relaxed/simple;
	bh=q6LJ+kRBTEWXCgw8KdWkT/ZnIJSXEae1GkPFWonEjSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k3p2mmpKi1Qm6AaK2/A/jx9cwjL/urbS2xNvlxCkcmbON3r+cYCXdtVpYztsw8lt8BK6Cs1ew1BvHMglNsHMnZzTTven0u63jx+FM4K/eMKAJkp8OQbD3Gvh1J5TWG/wwhSjKJUwv2vUsfAaSoBf4XrYwEzjLRPeummEVVIwXh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQt4VfU6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708727632; x=1740263632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q6LJ+kRBTEWXCgw8KdWkT/ZnIJSXEae1GkPFWonEjSk=;
  b=JQt4VfU6Vl53KuPDl5LEpPtC9GUdFvGwJMhMTg64Jo9vr470YRTAf//V
   DyqBXUrUP80OgDpNvbaxOv8ONNMRuxpNdKK1kpeVp2ZTHVmNETlhBBZq/
   SlbA67Tkl/qvJbUzVvsgyIZ3nx23ujKNXDv8EEXh1wzE8t72ChBxPSfj1
   XA4brVzIPFxmRTghGJd7nZUfW//wrYIDOULzkYwUnOg6O00GagLcbmQnm
   G7wni4NgtC20d+5mb9px8MKTCcIs3XViRqChdlRpiL8fFfYFI2GFPdpZj
   z85GTKdfEvOFKKSWepcpy0euTI6djFEz0BMsX94uC3pT3wtFkpqrSSBlW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3197995"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3197995"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6189749"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 14:33:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:33:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:33:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 14:33:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:33:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSMx7+/vXv4yzB1WUQxKBZTYOdJh/NlW7YIeFkCE/TRB+dqtWDTgQVuI2v/i/UrWhzPYC5J/++d4S0qOXFQG8pFGJAjrqLx4yKYsICW0b2r0f+pRo+bFNmuNgjIBK+fbitUBQmBF67etNsbSwPFkOJiOqmS5hbOWNq2Oq0Iwbqc5LDJSn5X1sivF1hTH2VYRzoA9wUgeUfeUe/iE3JHIl81RZx6S0UmRbNzJbHpD8r4YSecms2KgASz0N3H3oicMQVUa7Ut5W9CdTePJMYFci4uYOzvAXV3PqoFJU1Fe7lwp8OKVqWqc8nPOHOqujza6ddPyMJuAmHu7XM8feMfAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psXFvO3x0VnrBi8HCSTyuugNWRu3Vs0G6CddbckrWag=;
 b=TSkkAYyZfAfAZjSvEd2dTbAdipv9+sZ2T0P/YwSbn1efC38LRX4KJBC37LwcddXROl06ucKMWtocMxecL6mH5K/goM+41ZfGNFLQRjHsQXS/C+sGBaifOKwwY6QSq8ib/ez82ZTXP8eRj6UW5kVFj5JUHVS0tv0nStQ4q17BccdwAgjgP8EckSwbf+new5A/TSxZS5zsSgBDRzG6QI+lbGF3vIDK893edcAvzDND8uVPs7L8fmf/94Iyyg6bjbYQd8RwmYuo8CFZTV5shaOODat4ltLeULTy0WKjUSf26i/o0dL0+zkNOtGbv/c4meytHEVwn4FjRY2TG71vaLS/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 22:33:47 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:33:47 +0000
Message-ID: <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
Date: Fri, 23 Feb 2024 14:33:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: da429887-a255-4d15-e5ec-08dc34bf7ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MCY31eWV3djCRAyKgvGONj/esivRXEHcPzhORHsnFFL39gaLxtWoRmlq7P0evZbILDPbz0O2rnTk0JEbxF4Hvf4fXEGQ9z88jcTscE6yRcFZ6NeNAxokIyC1ZzooIgDA2Rm0qEL7CAYY51wlsuTEU7DUDK+OBJdoJeW/0h6raXeM8tmC5Rnjjq7lJEL+eIK6beWtXL9An6jyt3d50vobXURdzWUdewADZf6v9R0tujBH04/ezZ0jlj7DBeH33rBrEFp3u8VQuGig9/S3k853VNoqiATJtTqrDKvSkxh5eL9MpXvcTM4y+cy9aaY1A16z5KmQIkXX++g4IqQafcH8TZUVWCgvJEmr8uD45+44L7LqRgwvzMRfWSSce6w3ax32mhGFzGQ8g+W7lxCPMdT/k72ij8vNo/Rg7rIjWVu5Hvg6PjSYGOErIE5e6JFIvPkPerqC7FZ364GcIom8o/hiiT40MARGxL5Pl8KYW/5IsTSXYfkhEsh30+Ev66ejQlg8NFq54GM7uSVYngtVygT8D46f5dz4c7sQaD6kg+40gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWowQVBNVEh6RFY3TGVMVVAxaDBCa3U0dTZ3MDZzYS9EYXVnK2srYzMwYzdw?=
 =?utf-8?B?QXZKTzJ3b0ZGZkt0UTgzL3g1WFh0aDZHNWpSSDZzTUZIdDRNdXlHSi9IWlNz?=
 =?utf-8?B?L005bElBdnF5c3JxSVpxc0dGYzMwSmtDSWhaUXVMbHRtY3hHTzdpR1V3OWZr?=
 =?utf-8?B?M1E2cHBqMGZaanRtcENrQWVrNW82c3dQbDdmTHdYMytwK01lWjVCcGFCRDZP?=
 =?utf-8?B?VzExUU56UFZNRkFiTU5qUitTQjUrQzVQNlcrSUZOYnBUaFZlZjVmNE9odHQr?=
 =?utf-8?B?RzVLMlh0N3QvWGdUV3BRRjBlTzg5ZHJrTElmRlhIbGhON2JKOHd4YVNrQVlE?=
 =?utf-8?B?MldJWjUzeFg4NzBjWi93UlJ0ZkhFM2paRFVJZUJlbDhGcHMxc1ZyL2xRUnZk?=
 =?utf-8?B?NGRLSm1jYi8yNTJiWUtpZ2U5ejljTU9WemZkZC9EUlZxdk1YOTRha1g2OVM0?=
 =?utf-8?B?dXNEOHBGWHh3OUdnTlJBZ0ppZ21BZC9XUlNqOW14blJJVU8xSjVLUTQwVmZo?=
 =?utf-8?B?NEU5VzhlUWtKamQ2b1hnTDJqNmpCRFo5TFdYTmExZzI2alFMc2VqZVNNZ3No?=
 =?utf-8?B?VCtTdHBWOVJydnd6WVFRdGJkVU9qUkpEeHJ0WU4rUkFpWjdvaGZMenp2Q2x3?=
 =?utf-8?B?M2NPN3Q5dTFRSEc5b0p0Q3JKdVlYUTB3a3lvM2svTG5rVXhVd2M3bnA4dDZa?=
 =?utf-8?B?Nkg0WVE2WG9LUms0R1BQUW9ScVpucTdTYURrbXhIK2NXNzdFbGpvMFk0OUZv?=
 =?utf-8?B?cGN5c0dWeThldXBpODIrUnZYSXJhL1kzMGJGZWgrYWo4cThaWUtPZWoxM3lQ?=
 =?utf-8?B?Z2dvSm9xalFjNWRNSlpyVjlYZ3dpOHZaTXgwWHlWQjQvQTRTdHR1aWg3bUJI?=
 =?utf-8?B?NktuNU5GQ1NGaXF1TGtKNmhlTVF6amtnb3dxN2V6bWR6K3V4YmRCTGRacFpK?=
 =?utf-8?B?VlBzMytmNVhFSUNFQ1lFUUhXdGlhVmx3UkJNUnc3bXdjUmlzRkV0YkIzb1lu?=
 =?utf-8?B?U3cwaDdNUjd5ekxoSS9wOUNvdkF5eGtpc3VBMnAzU0Jxa0M5OTRCNmNBbkJP?=
 =?utf-8?B?S3dnZCtiSlBMcUpseGVIR0ZwaHA1T2xFVzNDT1dqR2xyV3IrMVBwY1drL0Ri?=
 =?utf-8?B?UWdpUUtWMmF1a0ZpczF3UzR0L1VXNEdCR3YrVHE1RlpuWG96RUtXTTRvdy9W?=
 =?utf-8?B?bEhPMFR0bGtHcVhrSHNKaVJML1JPOHNpYm9sUkkrRGorRFpIKzJ0OXdmbTRR?=
 =?utf-8?B?Q2ZucW44dzF1SDBrZXpCV1MydXlXSkpRaDd6bnhuSGJhUjFlYlRxWnFTUkdn?=
 =?utf-8?B?Mmd5cTVscVdwYkVzd0V4NzdzYythVzRXV1NOeVdrRGFtSWxIOVpEKy9ZL2c1?=
 =?utf-8?B?SEY1OTFvNUZDcGZSOUZWNVBkWUhXbFdGZU9YWW5Vd2ZBMGswaFgwYzhhTTdG?=
 =?utf-8?B?Mmg3WnlGcWhMV2xWZTgvVGxhZG11Q3B3Q0hmSTVQUzRTc05pUUc4cG1tckl3?=
 =?utf-8?B?a3E2U0xFUzNFcWJaRGlIQTY0MitIUEZrcGpWZHEyOFl0SGsycnRHckovSmJZ?=
 =?utf-8?B?eVpnZTVRODVwWGNFeDhFRFl5VTNaNWVicmo4NzFOL2poOE02Z3RhMDErU2M1?=
 =?utf-8?B?djNNSlN4cnJ6VGs0ckt1TzJIWFB1aUVzWnJYb3IwdTl0emJTTTRJVWhLNEVo?=
 =?utf-8?B?UHRjSzByNWlZejhCajllZWs0VXNEK05TL0plNnVlc29GQkFIbGFiMVhQd2dS?=
 =?utf-8?B?bXUvV0ZBV3dUN242WDVxWm00bEY0WmZqaHpPenFtcVY0b2NJN2E0TElKYlNw?=
 =?utf-8?B?WmVTNmRNby9nK2JQYUg1RmdSNWQwRlc2OVBvTVk3bUV3Z1VualJSbjJHZUpx?=
 =?utf-8?B?TkRjM0FPbTZzOVdIT1NlS0lJVzhkUHZiUTVDSkUwT0dIcEtmb3lzQ09OeEdU?=
 =?utf-8?B?NU04TjF4cm5WQVB3b3U0Q0FHSXJGVUdVQWdMc0d5SlZVSkV0WnRWc1d2NG0v?=
 =?utf-8?B?QXZTSytvNTdYSWRJVUFPZzYrOVBydWF6Z1hWdFhGWDl2cEJsbm1tb1ZXQlJP?=
 =?utf-8?B?ck1WV291UVJ4WTlWa0xNUmZ0Z2FlTmdIamVxVEVBbVRZUGhlWmxYSVNXYWNZ?=
 =?utf-8?B?OWJzOVBsNHI4QVMxdDJKS1hiU21OejZIWlowdGltdDZTeHQ0c3F3akRoenpa?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da429887-a255-4d15-e5ec-08dc34bf7ff6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:33:47.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvEWiHDQGy2sJwB1Obo4NkscZ7uV9axN+BA1smkppdK0DWDDW2Or5AeWFmbghO47H7qg3O/0qOeI3ZoCA5amOQKPgr0HT+OtgqsavsGzN40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com



On 2/23/2024 2:29 PM, Shuah Khan wrote:

> 
> Applied to linux-ksefltest next for Linux 6.9-rc1
> 

Thank you very much Shuah.

Reinette

