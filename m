Return-Path: <linux-kselftest+bounces-11976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB8909268
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D51D1F2191C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C419E7D0;
	Fri, 14 Jun 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYSd/HIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7C19AA6E;
	Fri, 14 Jun 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390307; cv=fail; b=eu/Q1FmxPP1gWbfLYJDo2QpYdgbrLZ4J1XwMbjJsiswEI40JKDwbqs57OnxQdt8ReMDBgGyk7zPX2HApKrT6ON2zd8pnu3aCI4+Q3QDcq4J5A1Il1sDtVlRdv4j2CYKQJPlWszpgJe8MRIwCi4PFmPtMHUxHrR/H/G3XxEWKRSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390307; c=relaxed/simple;
	bh=QSonZ4XcHBix2Tg5aI25EeTDop0L96betV6Uk6QROEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pzya82uZq6lq+qMyhBCmcLlTLhD0CIMRdotuOrMoTmM2EXMbelLnjQUjv+kgPz737iXAr9ykv4YSq8LWt8NU/lagWBcAANCZs0ME11hmkldFTw9iU9t5etUEX7V/AZI8NUfUc2W3OV/6LANQDhliW3aIq05DqfGNO84334rs1lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYSd/HIL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718390306; x=1749926306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QSonZ4XcHBix2Tg5aI25EeTDop0L96betV6Uk6QROEc=;
  b=BYSd/HILAh3FEDcg+UwBCKEngKOP2WDdplVkKgPCHpAdv03N4Ygg2UdL
   zkiwwcq9iei0aTKokaGHhxmhw+xx2cVRt3OGO1nwfeCmTtnYfASl/yuyE
   IE0E1upMjytIpPTHzRRIFnxxiDNVD97HKRStDQWqUI4ybjnR85sTwSC1B
   HVqU5PXUTunEQm07ke9rMe+EjwKowbsl7Dk5ol8bEkL+iAv2eM82NKoli
   61PnQMSluqyLrVcMLsHoFqDd+MrosJEgkzALGERJrdtT1wdnVF2WjaDiR
   EYvN58oV3pVl4KIgnfzGIIeoynhOM2nIAe0JEzkHYk1L42Rrghx4PX7CW
   Q==;
X-CSE-ConnectionGUID: eGWbm6QCQAihcz7VT5VUXg==
X-CSE-MsgGUID: rvf53ym1TnCcs39kN3dCyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="25971315"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="25971315"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:38:25 -0700
X-CSE-ConnectionGUID: 0IssD+MISlG25JyIMMOeXw==
X-CSE-MsgGUID: bKjaeG2UQ8SPme0SANFzrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40435524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:38:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:38:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:38:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:38:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHLKkUzmyc2J2sz1iD9imEEj0SNfK8WExYjw5vnzPcfLaFVR4DOuQ2nRh1reXl44aaO8ZLk4sY96VCKshTSbBTnQW1utCS7axANOsLp24EhM27QqwmDy3AVTRVFu2tZm3J2zJ2WaFjAVzdqLtQhlufxLU53MNYWzD2cmYztkwlJRXrsIrUI2iWIxLG3XTDuN43noujT8RbS5hQxqIVPJL7/NDgxDC6b17T6IQYMigyaA8RHF3gIrKrYT5teVU3fw3wGnGA378w2FQ06W6GEkuwbBaXDdC4Hkimgq5PT6ax7YZt/XILs3UY6fa3Z6v/aRShgc36ADqaBFMFiLvnHpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAcDgGtATYDyuObZS/jIhwXtP2PpmlUGbPGO0yevCac=;
 b=VhWYGJ5JN+tA66EBc+VS9K9c3icc6GFLdrzQl+ayyg3X/DJOOSbKdWPpfXnfXo6txJD4kQEfzxPydTTqAF2fjVX+BzBiSXqk2DZdBqQ8LH5Ge5Ih4RO7uXlno1iRZypAin0PIkkAYBD1jdWNIBcQYx4WxQhVzLsu9aSNxvrjbHkGPSbIJYb+RkoADLNp2bra+SgkdGNnFLrVRGZ7jbqPBFMgXvB567pHEOOiic2YsT7Ge91p06YRLMrlM2jDdCcKQ+PCaW/tZ+CqkJdqhMGZYNgDrJXjxSxfhBrk658uc2FzvIpMrxfOy73IG6QZRAXkW2ZIiIASB39JdGoYBA/Znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:38:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 18:38:20 +0000
Message-ID: <fc551b62-6afa-40f8-b030-9e43253881db@intel.com>
Date: Fri, 14 Jun 2024 11:38:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] selftests/resctrl: Pass sysfs controller name of
 the vendor
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1717626661.git.babu.moger@amd.com>
 <f45784f8882fa41d454ac3b35b203ee6d04ecc25.1717626661.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f45784f8882fa41d454ac3b35b203ee6d04ecc25.1717626661.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e70d80-d2ab-43e9-12a1-08dc8ca12a4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU9NcTVRa3BKMUR1YmU1NFllczd2S20wWnJoRC9MWXpsdTlabW5MaU5yMHIz?=
 =?utf-8?B?VThEc04wRjV1N1U2b3BWUmhVbjRBMGlEcUpUd1IvY2kwYnpVVlVDRHd5NnNP?=
 =?utf-8?B?MTJkSGYvT3haYUVBQldydHE2NEk5NVQ4YkdwN0N6dGhhdFNyZkRpNjhRQ3ow?=
 =?utf-8?B?emdWOFBrRmFESkJBdlh5UHNFQmVsM1RwOW9pdzUwblVjRkRacW01WUEwWjNW?=
 =?utf-8?B?NmNEem5jeGt5Ly96QzFzd2d2dnZkNjQ3VTBKejFEOFRPTUdMS1pXQlpVbGNE?=
 =?utf-8?B?bWYwa3JjK3hNVndGRGNsemNDa1RzRGhXaXhwZUVrWHRZQktDWDhuVC9SQTBW?=
 =?utf-8?B?UURRbFBrbkd3ZFNCaktFV3hVdVJaUzhVVVZSUjlvV0xmSEdkcXBtbmxYVTF5?=
 =?utf-8?B?eVA1UzJ6aE93bmw0SXgyUGtJWEpKdG9CN09YaFNLYVFhSnlJVHRkVCtkYlpP?=
 =?utf-8?B?a2tYUUhsdW04RTNaTDF6R0FDY0dJWDdtYncxVmZiNi9GaE9rR1lsbThwNlJJ?=
 =?utf-8?B?bEE4N0pCVFZlOEhsQklOTVZrUUFDc0drNVZGUEpzenkwSDV2aVdUTnF2R3VK?=
 =?utf-8?B?cTNOcE4ySEU5czVVbW9BaVNETk5oZUIrSWcydDRxVEJ3aXE3ZGpzdiswT0FW?=
 =?utf-8?B?S0hHR2w1V3lzam9GdHR2K1JVS2NKeERObkx1VFVyeUdVWnFIWFRBOWlTMGV2?=
 =?utf-8?B?dC9TQ3NTZmVoLzgyM3ZGOWc4NDdOdG5HWmJJc016LzcyQzd0WjVKQkN0VDRN?=
 =?utf-8?B?NmJVSmtZakE0S3ZVSHNTMGh5SnU1Nk5TL1EwYnRyYk10ZFVrT0MyTTRRcHI3?=
 =?utf-8?B?V1ZlUUdheThYTFpQcDk3aEd4UDZoMTJuaXlxaUVzSzY5cGhucHZNUUhWNGFy?=
 =?utf-8?B?ZUthSFFSb2htak9Bd2ZVQjVlS2x5a2JvTE92UnBpOGtHSDVRSlpjUnpUbGUr?=
 =?utf-8?B?VFpaVUsrVHQ0WWNnZ1RJS0dUN1JSUWVrZm92Q2taczBCOFd5cCtzUmlRbit6?=
 =?utf-8?B?eEVjeFZ2UzZNc2pva3pYN1NYZG1tR01KdzhMZktPTWwwMEFxYmQxaWlLNk1V?=
 =?utf-8?B?T21VYjFhTFVZUVJQQnkvNExKRVM2OHNBWlk5NjRObDFQaWNYWkp3NTJPYkJL?=
 =?utf-8?B?eXlwQ1pzaEl0QnFtbzhKUEFxYUZJL0pWNFJvVmNPME5reWdHN1owREJ5eTNG?=
 =?utf-8?B?QmdwQ1MvMC9paUVaYVZUTncrZTRBc3RSZDVVL3hOYU5JWmgzU3hsQW50eHNl?=
 =?utf-8?B?bUROSVFCYTZyT0I3UkNVWG9jZFVxbE5UT2svZms3bjBORW0wZG9HVm9ETFJ3?=
 =?utf-8?B?Rlk3MXpYdzNWQzZndmpvU0RNaTZnN0dKN053anJ5dDlxTW5qRjhqNkJXeDRZ?=
 =?utf-8?B?U3lMMzJyT211a2taUWdsSXBydy9WMzk4b0xhWnlpRmIyK1hyM1VpNUxyV3pH?=
 =?utf-8?B?ZjFnQlFVWWZrU3pPdVV2THhjTkltYmpsUXhWbVdVVzVXcm1BMStVT3lacFJk?=
 =?utf-8?B?bVhGaXYzSXV5YURuVW5Hd2dwalQxUzNTbmc0czNpOGJvZUljU3FuK003MDI5?=
 =?utf-8?B?bWYzT2NkYTE2N0NSTXZHZ2JLZmVIK0tQZk5XZUc1U2RWZVFGdFBJejZsYUlJ?=
 =?utf-8?B?L1JOYUFlMnFvd0tUTHcyVmJ6eWwwUTBTaWsvd3ZuZFJVeElRWnBYdi9uVDJj?=
 =?utf-8?B?YmxRdU1tVGJFZndnTVdoU3NJNHJzeVZUNE96Mm5GYXFoM3BwZDZ2b1gvZ09k?=
 =?utf-8?Q?Vdgy8/eVlDj2IyDQh67dc2Wh0+qDh+4m7dfPChr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGo4Q01jbzYrZnJnRThwSU5EUmVhSjV2eERtejB2QWZVVWtTajlXdVlta09s?=
 =?utf-8?B?dkZjV0JPNDJjTmh4SkZIN3diNWU0VUFQWmp5QlFjSGZxWHpxYzRqVk01dGl5?=
 =?utf-8?B?d0pkUk9TTE9sR0laOTE4cUhtcFBuVjJJOUtwNWxoaUNiYUp1SWl1eVN4dUNF?=
 =?utf-8?B?WDJGclpTbkxXc2E3RkZ3RHBBeGNTMDdJUnRCUUE0RXdEcTV6YzBxaU1kajZw?=
 =?utf-8?B?RUtZRDhxdWRpVFRQdmVocm96K0JCdFJKUjYxZS9tSi9mRDBkdm05NEtzeG5t?=
 =?utf-8?B?R2M5aHY3dnVlTGZnNHdLQW0xSkNUNG1CVFV1MXNhd2lkbHNaRzlJRzZlQjk5?=
 =?utf-8?B?TXZJN3Q1bU5aMHk2bVJHQkNPRG1PeFQ3RWdwczIxTTJlelE3U2VsZVRyK056?=
 =?utf-8?B?R1hIdTFVSksvdGpQQTAyUVYwZFJjMzlubFZlZEdNSk0vRVdYT0xNSit2bEQv?=
 =?utf-8?B?MUwvZUMxLzNza2x5b3FSdzZEaEYwTERMb1lydFNhbW82b01vaXFzQ0UzWm15?=
 =?utf-8?B?dEFZZTJUTW9sbnlyK3pYazJsZ0hoY2FSbE5OQTVQS1o0SE5nQkdpZVgxVThG?=
 =?utf-8?B?SG9sUjJOblVYWGdJM1UyN1YwZnRqL1Z1UmlZTjJTbkh1SmYxLzFkQlZ4OFZv?=
 =?utf-8?B?L2piWDV1NTh1dUdybWYyK1pCWjNVdUhPYzRDMnFYWjl6NmQ2ai9UaFdkY25M?=
 =?utf-8?B?MmpQK056RDlHVllZQnNnSDIrRmgrTzViZVRiczdvQXJVenNSM2dHNW4yOEhs?=
 =?utf-8?B?M3dNUERMbndraWkrNjEzd2FiOE1wWHBXK1VCU0tzL1h0U1hnZWFUeEJRZE1k?=
 =?utf-8?B?R3RadVErZERYdDdvcy8zTFpwdTU4NGFQZ2NyUnJRTmlNQzV3R0cwUTRZckc5?=
 =?utf-8?B?bGppNG5iRzFVSXhUTkNNdjdYMUxxSnZybjlGdjE0Y1BIOTdSbkNVMGFVVWdD?=
 =?utf-8?B?Rit2ajhsSndYaDlkZHd4MUtyZ0dtNjIwamZ6SHdMaDUxRyt6bEREalowN0hu?=
 =?utf-8?B?WUpUVkN2NHdqOGxRdE5KWURJYlVNRHFZczFHa1VPV3JvamJEME5uOGZxaXNz?=
 =?utf-8?B?cWs4QzFMRjBpMXQ4bTM0Yi90cHpjRHJzWFllSytHQjdCbEF4YmNFUUl6KzIv?=
 =?utf-8?B?UlVEZTZRUUNRTFRVRXdYTkNQK2R3cjdJbGhyanNjbnJWUVMzcHY3bDlvWW8r?=
 =?utf-8?B?TDV6S2t2WTdSMWNCQzRXOWxhUUM0T1EyY0RCZURscktJMjZnV010UWVlUXpH?=
 =?utf-8?B?SlJGLzJCcXpZMWd1VUlFZmg3Vy9ZMmhQUnpFeWg4dndkOWFjaE94azVDbTNR?=
 =?utf-8?B?VUsraFkxTlhrU2xZK3RZdkExc0cwNlkrOG5tcEt3aS9lV2x6NCtnS0ZmdFpk?=
 =?utf-8?B?TDl5aGFYN3lRazdXQXBKK3NuSkZWRndpc2wxRWVrc2JtL3Z0QmFDcHR3K0dY?=
 =?utf-8?B?UWw2a3dDajJoZkp2MXZvUXRaSnZtTjdyVUQrOGJ1TGZHZUtZMkdmVUd1bkhC?=
 =?utf-8?B?L1RHSnZaMmRwYXVKYlh4dWxZQmJPU3lBU3A5clJLZjdySWRtWThqYTZpbElU?=
 =?utf-8?B?dCsyTVR1Q3VVWXJteVQ2Q3NXSVRvQTE5LzBOTmVVenBiOTJKdlZyMTBSS0Ni?=
 =?utf-8?B?L2F3a3k1cU5mTHVDcDg0UHdQd3RhVm5jUEZIRHZYOVV4ME5pQjBKMVZOMWdx?=
 =?utf-8?B?M2RZRkRXNG1UWU53WTdoOW9OTTMvQmdhaHlaZ2pMcStxeWNGR0UxWlhUTXk4?=
 =?utf-8?B?dzFzell2TXlaK2hvWEQ4bWIva09tSmRJYUt2UWJlbktybHJLZkFIZ2pxNWRl?=
 =?utf-8?B?RDBVK284RFlJOWg4cmo2TzFmRG5tM1ArZk5zb1dxSUg3TStENnRIbWdxL2N2?=
 =?utf-8?B?eENRV0k3SDIrYU5EMWlwcXBGNDBsdEV2Tmg2emp5Q21tcU5YclJxcEl2cVBD?=
 =?utf-8?B?OHRkbUpjczI0OE9ZaU5RSDhHbDRXcVphZEZxN1phZGR0cDI5QXczUDhpZWhx?=
 =?utf-8?B?bVVXR3VuekQ2QkFZdmFlVnJteVNJek1XUnY4eXBlOVlSNU1JMk93c3JXYkly?=
 =?utf-8?B?c2xOMGU0Qk01b2JUWXpqd2V2RjgyUFlzLzNJbjk3M2xYTHFRbmZsaE9DcmM3?=
 =?utf-8?B?cWx3ZVRtcDlUYXdKc25TM3JjRVdYUTM4SjEwNW1uS1VZUVhQb1dQTFhrMWo2?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e70d80-d2ab-43e9-12a1-08dc8ca12a4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:38:20.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1qGmZNZkLD44KhnL3s8fvt7L/kXoVxV5lTTgR1qWAG4aR35QtEes3qSpIE96VVlAEn4rG1K9ax+uLxQv1M+t/RvAMIYxkpIO6yhbqR2PSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com

Hi Babu,

Subject and changelog mentions how controller name is "passed" but the
patch does not seem to "pass" anything new.

On 6/5/24 3:45 PM, Babu Moger wrote:
> The test detects number of memory controllers by looking at the sysfs
> file system. Detect the vendor to pass the controller name appropriately.
> So, that rest of the code will be generic and can be used to support other
> vendors.
> 
> Also change the search to look for the full string "uncore_imc_". Replace
> the sizeof with strlen.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Change the search string to "uncore_imc_".
> 
> v2: No changes
> ---
>   tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++++++-------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 2d5e961b3a68..23c0e0a1d845 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -10,7 +10,7 @@
>    */
>   #include "resctrl.h"
>   
> -#define UNCORE_IMC		"uncore_imc"
> +#define UNCORE_IMC		"uncore_imc_"
>   #define READ_FILE_NAME		"events/cas_count_read"
>   #define WRITE_FILE_NAME		"events/cas_count_write"
>   #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
> @@ -206,24 +206,30 @@ static int num_of_mem_controllers(void)
>   	char mc_dir[512], *temp;
>   	unsigned int count = 0;
>   	struct dirent *ep;
> -	int ret;
> +	char *sysfs_name;
> +	int ret, vendor;
>   	DIR *dp;
>   
> +	vendor = get_vendor();

get_vendor() is already optimized to only need to do actual detection once.
I thus do not see a need for a local variable.

> +	if (vendor == ARCH_INTEL) {
> +		sysfs_name = UNCORE_IMC;
> +	} else {
> +		ksft_perror("Unsupported vendor!\n");

ksft_perror() also adds a "\n" so adding it here is not necessary. Also
please drop the exclamation.

> +		return -1;
> +	}
> +
>   	dp = opendir(DYN_PMU_PATH);
>   	if (dp) {
>   		while ((ep = readdir(dp))) {
> -			temp = strstr(ep->d_name, UNCORE_IMC);
> +			temp = strstr(ep->d_name, sysfs_name);
>   			if (!temp)
>   				continue;
>   
>   			/*
>   			 * imc counters are named as "uncore_imc_<n>", hence
> -			 * increment the pointer to point to <n>. Note that
> -			 * sizeof(UNCORE_IMC) would count for null character as
> -			 * well and hence the last underscore character in
> -			 * uncore_imc'_' need not be counted.
> +			 * increment the pointer to point to <n>.
>   			 */
> -			temp = temp + sizeof(UNCORE_IMC);
> +			temp = temp + strlen(sysfs_name);
>   
>   			/*
>   			 * Some directories under "DYN_PMU_PATH" could have

Reinette

