Return-Path: <linux-kselftest+bounces-11312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9A8FF5F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6392B1F23A7A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB319AD7F;
	Thu,  6 Jun 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZ0vnayK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85319AD72;
	Thu,  6 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706044; cv=fail; b=X+t0tcTkZGWApTyHv3teJ0NIKsIIsYORyVe7Jb4YkFnDEGSUCHws3EeQzls4odqft0w3/EFe++xafGsZfZd6x9NxrvpqunpK5Dq+unq/wIwZvrNpZvk7qm+x0S9imBoFTB5piTex7czHz15E6XyKDAcbdjagapnSJ7UOHOhQDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706044; c=relaxed/simple;
	bh=PPJBPf5BdjP9r3c9zCYKv6FYaeNFI+TXIZ5/cm6e4Ow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b45F++V/rzazZ2GWE93kPcxyzms2UvLr5NfXlK/OFzx+nLkhRd++N5ihs0Fi/hdSydLHD5wYlEZrn1ZzjWgEw1kofOX4/KVS/T3wkjXCzdWLuZSPY/A4HbbvYPzu43OsA5IM5m7+keA5wW4lp5qbwJaekvJHxdre6njJJ9eV/Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZ0vnayK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717706042; x=1749242042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PPJBPf5BdjP9r3c9zCYKv6FYaeNFI+TXIZ5/cm6e4Ow=;
  b=LZ0vnayKrIoN4X6VOXcfRdRovAsNO4XBfFjYugFdYBWDP9hm6UgMuKr6
   WhHx8Rj+dXNpvvWgyYjMM1P6a0jb3zQPaVN7FAhaSJZrTsIrV5GlH/iZB
   XzDc8jtZA4oKYLIO24LSfDIsIxu/AJUHqIk/AwanwR46Wvnmbn6SayQoK
   sIjhL91SAHj9rvilioHDKAl/nmYWy0aSz2HyLoIDAUVD2K/2IHtkH4teW
   auUkLyl++l1J7bAJjypKpQi2x/YIcHHEFiU3T5qO8Ket8T4RqREV1H8Zg
   kmqtMl9cXXEL9+m3jfM0mI4NlpPGPfp/SqDHiMUg1ayZTBhJBn+wXfdQF
   w==;
X-CSE-ConnectionGUID: zGw1QGAoT7CIWsUdfJKf2w==
X-CSE-MsgGUID: 6JC2kaCPQcyw190oRamJAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14586034"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14586034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:34:02 -0700
X-CSE-ConnectionGUID: kmcdXIpyQdqt1xL0EYINew==
X-CSE-MsgGUID: 4Wh1m1qYSiaSyuSc1fNPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="68879253"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 13:34:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 13:34:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 13:34:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 13:34:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 13:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fll2IpjGZSEa2QCtn40cF62tYZNQdlV0Oy3EUWsKp5BXW/jr1wDCfc2XEAbGbLOUiH9xfaj9gke7fYPPqOhBJmQ4fOHTRiEV4t8OhohbyO+dnfHo/WH+I3g6e76/qVVYfdKVUh7GUC6n9UFLQnnJQEeynZ8l7hxZshuAgyq9lMSegZnep1Lr1AhtqQtHnTuE0yICltpmLyHmssDI+Q4J1u1Z2jVrIEK0rTP5LXYZHFa3MVsy2CNtt6f9GFBseMqP6xissp+iHlal8FFlSHeVoVVFotNnf8A6yGvF7RW39++4nKECUWgu/ypLrRXOssaPJOEi6hePrvvamdABJ2izZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HhS7bKhwyvUYnvgBjbxpSmMW2ICvdkgwf7PrWLpn6U=;
 b=oXkO4jPRuOA2hlcXzkGo8wSnJJUGfM3U83VTOQnBn62un4NXAsojxbzNm4axWe4IKAPdTefvKlok5pqN03qnVAZv08BleoZOugDcsIpWhu5pkr/avuB3yCMtFrTi5H50sPHIPOg9tJdPaQX/B0bIg3z/cET48tXr10QjGpPHbKX0wKcif0dgsbVeoAWWfIEFOsCfDRxXMiy+JfEF8Hx9oPhhk9HZ4XzPKt19LAj37CjNm8k2gUXY7R1zUZCWKqRk1l+t86JSiKpuDGhwLYm5gZwa37qzYfb6hmTx+FcU85GrLVGe53M5DcJtqDlaJX7NAbZXsbPSXQva1tMbhtAEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 20:33:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 6 Jun 2024
 20:33:54 +0000
Message-ID: <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
Date: Thu, 6 Jun 2024 13:33:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5dbb3b-6c27-410d-2989-08dc8667fbb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3g5UUozaVVxN25pTVNPWllSZFUrd3RXT1psd2krWU9xdS9RS0VlTWFEWUQz?=
 =?utf-8?B?TFdiajluNk44NEpqWW5mQkFRd1dLcUhhOFFhNlZaYXFta2trV0NyU1o5Yk11?=
 =?utf-8?B?aDRMbTF4cG1iMlo2dm96M3NKcXZJUUlvMVhDbWRHMUNHa2pndjhIRTY5bmVB?=
 =?utf-8?B?bHcyRUV1VTQ4RzNtR2pHMnU5dEl6WmFNRTdXVSt1ODVRSnNXNzBrTHpybzU3?=
 =?utf-8?B?TFg2YmUrMUFtTTVRNkxPdjRVd2tZakdZWDB3blY4VmFDQ005SFNhQWVDOG5h?=
 =?utf-8?B?b1RvbDM2U0Yrb2tVUGZaQjdpOGVLZHlUakdod1h5UjV6dHF2Y3dsNUc5WUNI?=
 =?utf-8?B?alZPS0FrZldTOGVNZVVOOU15dUxuajFoNFZHcnQ5RGpIVnJENUE4aFlJZU1x?=
 =?utf-8?B?TkJlOVN5RDZqVE02Q3NnakgzdkxETVpFQlBSUW0vR0kxN25lR2lOR3FQZ3Rl?=
 =?utf-8?B?TmpXNnVUVFg2clVuQTc3VVpMWG82M25NM09HYzZDSmxIWFRkNVlYbm9LanNT?=
 =?utf-8?B?ZWsrMnlsaW5FZ2xIRnFjRW1oUGl0Y0pIVmhhblFEMzRVMFJmenUrUmhRZzha?=
 =?utf-8?B?YThJd0NBVTgzL1V1Y2ZFMnJQT3UrQW5PVCs4MGZ5VDJ6cWpCT05MMFdRRTU4?=
 =?utf-8?B?bkNIdmpld3N1clorQ3NXWGx4Q3d2NThEblhldkZFdHRnTXBPRVhEdDBWYnRP?=
 =?utf-8?B?Z2xHSVRCS1R4VEVHa3RXdXNUZnhmcTYybnMrdkREbEtkQVcwL2dFeEs3OWVV?=
 =?utf-8?B?OGxCV2REMElKZlhIbEtvOTVSaXZGZjZ6SStSL2krQ3F6RFBka2RtUGFjbjNC?=
 =?utf-8?B?SWNRMFlicVV6YU9LTkZtZmtYUVpaUnVMb3RuekI5QlpZYUhRdlMvTjVjZG1h?=
 =?utf-8?B?ZnBxcjVubzRFbkcxVWNFZUpDaTBFRGEybVRXbEk3THMyTU43S1JJRHI3dWw0?=
 =?utf-8?B?ZWw4c1o3UUlOZnNXOFUzc3dVZHgyNlBWWjhDWEhQNGozMTBPN28vVWljR0I3?=
 =?utf-8?B?R0lQc0lQVFphdytGODIxQ1c1bHdUdGhNVkozdWxTeVhNZ1ZieWhoRWwvSytW?=
 =?utf-8?B?Z0g0cUFmSzhZMGVTTnlBTzluTUdqY2JVUlVrTFF2MDFidU5Jcm51R2QrYmQ3?=
 =?utf-8?B?dkdDa3pWS09FZkVCNW05eGpGYkhsNnByMy9yR2tZK0tCMkxyajdPMEhWOG1t?=
 =?utf-8?B?dWFWN2o4TXBJNHY2ZWNZMUtoYkdzOGd2VE1DNDZwVlU2WUExZ0dSSElRcUZa?=
 =?utf-8?B?RGFBT3pnRURyRTNTczlUNmtaWSsrSkpwMzAvUGRGN3V6c2ZLSGxWdFBrWHZK?=
 =?utf-8?B?UDVIUUFSZkQzYk1rdmQxN3dZUzRDZnYrbnVMWVJZNDlGcllaNG84TTgrYUgw?=
 =?utf-8?B?c1B0Q1ZqQk1rYmN0TXYvMTAwd3Q0UG05cGVNRWNRUk14b3ZpcmxXQUx6QnNW?=
 =?utf-8?B?enJKSGdyV29vY1NUTnZNeUhQSHRkdXdrTXpTcGJIL3Y2OS9HZzhkWHpNSXpV?=
 =?utf-8?B?bkhCT1RhWVE3RDU4TFR0aDhoemdBTUNwaU01K2Uvd3I5VkNDMXBtY2FkeUJV?=
 =?utf-8?B?U3pzVERVLzJxdWErdmhGRjJ5dUFkRlg2aDN1SFQ5TGR1cGliWFlrTitVV0d1?=
 =?utf-8?B?QlA0S09yOVd0RC9MVFpWVHJqYmVoeWtUZU9VQXNEMm12ZFpJcGhKS0ZwaEVs?=
 =?utf-8?B?N3FjV0VvcWVJdFRScjBFaWVKWFk1K0lndVJ0Y3BGNE1wbzkvOFVQY2xkWFVr?=
 =?utf-8?Q?Ry4lyXsAxAvqs+7vrZ8JsHTpfV7TkjB2wgJhBiS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpvZmxmWnZiYlBScGVJZlhpY1BTTU9NVmdkL2FQbDZibFhBUUwrKzdpS01U?=
 =?utf-8?B?Yis2R1M5NStSU1IybURVc2xzZ2pEdm9hN3JWaFJmb2pMVDh2R1FseG9GRXV5?=
 =?utf-8?B?dkFpYVZkSDA3U1psdkdnQU5oZ1JMVjJqRlFRZndGL0dkblJyTSs1TVdLU1hs?=
 =?utf-8?B?d2pGMlVsN1hXQndRdHBvL2ZEYm1vcEwzSmwwQkNWTGE3OHdsR0hremJuQW9X?=
 =?utf-8?B?cW9GNWJhU005WTBXUkNjMjJMM2FWZFlldmplSlZjd1NENVlhbjBZNHBlcXVn?=
 =?utf-8?B?akRjeGlhcEZMTVpFS0wvTkNQUnRhU1RySmpiUFhkNEdIZFRMTGJrSkcwM2sx?=
 =?utf-8?B?eUhCSS9GdWgvVDlzNldIcTRYOFJzT2FHdkp2MHN0YngrUEQvQ2tSdzdBRElD?=
 =?utf-8?B?WVZZY3RGMkw2dmo1MEhHckYzK2pOUllOZzljWXcyYWxFVlU0ODVLRGR0UWpI?=
 =?utf-8?B?ZmZkcFJNZDhRK05razFpWnlqdW5nQ0xFUFdTN2c5Q1BGclFBQ1ozSWFYVWdz?=
 =?utf-8?B?M2EzMnl6dUNlODIxZXBLdUM1S2xjQTdSZ1Z5V0x1bnBzWlBEN09XUktyRXJ3?=
 =?utf-8?B?bzJjOUxwZkg1TnVqVlIvelVzc0VWd29TV05hNWtWakY1aEJJdHhvMjllc3Ns?=
 =?utf-8?B?bzZKSERJcVVTQU9XaDE2MGFNS21xQUZFR09JZmRwbi8zdlYzWmlmRDJyZGU4?=
 =?utf-8?B?OXBIdjJxSVdkV0dkNytqR2lQK2o1RjVhelgrMmNNeENQSXBRMU9pNkRMenlJ?=
 =?utf-8?B?Ly9RQkRET2locEJSc1F0RjVVLys3TXdaRDdIZW1mVVA0cjVCT0lHcXpnY0xX?=
 =?utf-8?B?R05IUGNtQm9YYXB5alpmUXJ6YWROdUUzMDVLMjNkR24vazJ4NlFiVGN1VllN?=
 =?utf-8?B?N0JFZkU4akRDcUVnOXJCNVhMTXVkUDYwdStpdUxKMXJ4N2dxekt4UXZpZ2NZ?=
 =?utf-8?B?SGFqay9kVDZZVDF4SXdZazlJTmhkTlZvYW9wWXVSRHcwcHB6Z3Bxa1RRbmZk?=
 =?utf-8?B?UmtucGU5TGhwcnFIY3pLcVlLREZoUE5FV0RZTTBieUlNWUF2dDRsdzQwZXZu?=
 =?utf-8?B?QmZtNERxdWV0WlpPaEJ3Ri9idThTaDZ2L1NZeFpnOG5ud3kyK0xISjBzTXhh?=
 =?utf-8?B?bVZhMzRha0d2RWcwL0xKVFFPWVFmV2lFeTZiemppSXhOb2dlK3YxNTdWK1Nn?=
 =?utf-8?B?Z1AvMENJNXJVTGNiUzd4dkUwaURJazRiakl6Y201azNyRkJxeGdQTUpsVENY?=
 =?utf-8?B?Y3hLL1huR3JWQXNMWGNQR0RXdnZnYWxNSXlyQmFENXlTUmwrT2w1cmpsdUpK?=
 =?utf-8?B?dEthS2gzZGhCdVhPVjd5S3NUQ0o5VCs2NHUvREVFM3Y2cHpySCtkMzFjR21s?=
 =?utf-8?B?V0wvNExEZkhJZlU1VndQS2pqR2hWa0gyekxQNkdEZU8yMlFWY2RHejlBWHV1?=
 =?utf-8?B?eTg1bUIyK0s3a1RzN1JLMjBlNDN0aFZFYmlzMEc4U0c3aVNvQzZsdyt2SFM5?=
 =?utf-8?B?OVVJWi91VGplNmZZM0lhcEdOUi9vcGsrQmc1VVFtcksxaXFIYnNkUDdXR283?=
 =?utf-8?B?akVSUElySU9RUC8vT01wYjR0T0FIWGJOQVdFR0gwWC9EZTgvd1d1L0ZNY2kw?=
 =?utf-8?B?NXQzSlZ6NnZWL0M3N0RlQW1rWmZtNWsyN0FhMHNBY3Z5QTR0dC84eWxHb3Bu?=
 =?utf-8?B?MDlKeGpZTkRYbHdLV1FLUVorY0VVaVREcVdlSnB3alNrQzNWRXlVdjZybkZD?=
 =?utf-8?B?SW9yMjRrVXRtL0p5M3lKbldhWCtPL1B2TmZDSzZ6Yk85OW5ZbnRrai9ucUNw?=
 =?utf-8?B?VDRxaXk2N0IrSng0NkpLck1ERnRDV0pNeklETEExUHowOUVXVkhzQVZaUGw3?=
 =?utf-8?B?Y2tHYkFuQUdwclkvSWl3c0VSVksvTWtXS2x4cCtXdk9ZemZ3QjNqRXFRNlZP?=
 =?utf-8?B?OFI4VVA3MWhLWEtQcGU5cEJ1YXpIeFRmWno1VzJhWml4VGNZR2hIQjVmK08r?=
 =?utf-8?B?MDBTQjBaaVBmN3BieDAvcE5CL3hJSWNsOFhwKzJLMC9yS2dLR1ZGWGtMaXl1?=
 =?utf-8?B?ZGNzY01pL1FrOU5sMUo5YndFMVhKNGEzTVVXbEc2WC9iUVVROVk5cUU4UnpK?=
 =?utf-8?B?MXZoa3c0cjMrSlBHRTdwK20yL20ySXpEOUdQSGV3TGg5anRLeHc0RFVBV255?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5dbb3b-6c27-410d-2989-08dc8667fbb8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:54.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e+0e5CTduj1Ypyuot4PfwLW2mGV8bJE7QLnhprFbTdXA1KKdP8s0p8sUk0UCXOAvkT/+UFrT9+ZXOwKHuyzLNgnChlEtowI/E4CZ3eFyfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com

Hi Babu,

On 6/5/24 2:36 PM, Babu Moger wrote:
> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
> is, AMD supports non contiguous CBM masks but does not report it via CPUID.
> 
> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
> 
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> This was part of the series
> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
> Sending this as a separate fix per review comments.
> ---
>   tools/testing/selftests/resctrl/cat_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index d4dffc934bc3..b2988888786e 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>   	else
>   		return -EINVAL;
>   
> -	if (sparse_masks != ((ecx >> 3) & 1)) {
> +	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
>   		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>   		return 1;
>   	}

Since AMD does not report this support via CPUID it does not seem
appropriate to use CPUID at all on AMD when doing the hardware check.
I think the above check makes it difficult to understand what is different
on AMD.

What if instead there is a new function, for example,
"static bool arch_supports_noncont_cat(const struct resctrl_test *test)"
that returns true if the hardware supports non-contiguous CBM?

The vendor check can be in there to make it obvious what is going on:

	/* AMD always supports non-contiguous CBM. */
	if (get_vendor() == AMD)
		return true;

	/* CPUID check for Intel here. */

The "sparse_masks" from kernel can then be checked against
hardware support with an appropriate (no mention of CPUID)
error message if this fails.

Reinette

