Return-Path: <linux-kselftest+bounces-16288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C895F533
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F2E1C20F3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DD193061;
	Mon, 26 Aug 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7RiAJwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61907155A5D;
	Mon, 26 Aug 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686404; cv=fail; b=gpVL5/pgRUajoZ6GFwy2kroBcERlHNlaVm1Zb9OJ4SzjIB1TZHXUfpQebFMHAk+i8mJDsfJD4hE7Hgx69juNzk0vtYLdcu0LSEEW7ENsyglUU55dq+ZkKfWijbXNTNQ7QU444aKQp/12/UzAL/dOnjTTY1p3yrg+4n8g78HG6t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686404; c=relaxed/simple;
	bh=WU6bLb4NkfxoWZRKfy441D+qUSZcb1g68YjaT1Ey48o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s7jtSMXXOuL+v6XmfuApTgrJh/GD2mLdLMG8TIFOhzuODUKXM5JigBEHDHSr46EJxi+YBNxyhdlK5c74awnWsn25aaAGbRrZ85kKZcmHY2qwlP3skOd0qAIpMj6+WsAWzLJ7+J0uGodAWtwq1K94UHvaQWEqaJCfIyiTPEY5uiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7RiAJwT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724686402; x=1756222402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WU6bLb4NkfxoWZRKfy441D+qUSZcb1g68YjaT1Ey48o=;
  b=b7RiAJwTyHO2P4ICRzaMaK4OwxGObTXpl9DGjMvK9n9hoGGbq3QJVEsg
   NZx9QLzuDuy+AQKAJvfTHblAoXTYc9kvqag3h4nP7n2+ggdZj08truoJI
   A0ahzwLlnGm8s4Z6PH7X/MoDKHpBfT89i19uR5VEbdVsSgq7U3L4Me9RZ
   wwUnpjHuxBeCPRl7dHX0IoE0d5nKe/KEQULRnPvhdY3zBGmO/964VFeW/
   sYMhw4gaI0tjZXqr2jpR9j0vjxPPV+6Q4WK6Hp8yumPqTP6pHC7gUMyyb
   73cE5w9O++xQ+WwedtYwcabN7k/f2Tpxar23Q64kwsN1TxCf+75F79Iy7
   A==;
X-CSE-ConnectionGUID: sXkK2gyUTZOljgDqrXyP0g==
X-CSE-MsgGUID: cYuevw6eRhG7Ke75UfBoeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26014832"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26014832"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 08:33:21 -0700
X-CSE-ConnectionGUID: eyX/70ATRTuYVLrKhnluOQ==
X-CSE-MsgGUID: 8OjRmsIFRYq8NnUtFN7amA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="63077486"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 08:33:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 08:33:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 08:33:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 08:33:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 08:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEu9kXPb3xY2aMLEONoKyZzwSH7vJcmpCUhoeEgycZGZhMHJdQvqFxejWrlWDgb7HcTfaFLVY/M+wwwHV0X9FajMKwK49ECPw4QpJ8OSxoB80vL6Tb0WcsKAEVWLhSLVoXdUvH9d3x4aYbYHxbYVlhGGZxc9KRIAnTb+KQ/JYwtm52yU4uIWut03xhs9PTlqhFOs8ceBegYCL7oFp3qlE1Npp4jy+IvOV215dgQhOCVnZt+no0ooaS+lmWCK8vIcvvLPVia54zjkJVxhgnOf2U2zxIVBIg3fCRRAcVmibKJbAQ2NjEYhMwnxhiUdtMEJtQIm4nwfxjK0otDfA4KUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htczEWJuV8zHtC0yjnBW/DMeqlBJGW2MvbxQzsgoiYE=;
 b=HZrq6jBZe9U9CcJGqXG66BZ68HAiA/4avw3DEEdR9gXxiVgrF21aQ3poP+yx02AEV3JRBziEFKOwBJhO6RQGGeHdI9n8p5sfuhJoIqBRUlJAYza3uf5ADnHeRH8JQIdX61Gvkvp4IdXEdn/PCIF6anXIr+PeU74xio+Qrp86Yje7hU1sKcQJfyE/vQkyGd8Jliq+FRSLRJBrhJaB5aaaXn+KLkl5fulL3m7GSR3+XBW5JocsloC9Vk0m1aMriNy1BJNyB4rXvOEHVAGRBANfR7M5yrwh/dfjHdFRZ6sIdkQBeNX+i0ywEzjuIJ66cpcOmS3gRFargG7hgIKZEYvxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 15:33:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:33:15 +0000
Message-ID: <ffe7ed9c-43af-49ec-8428-cb911d3abd1e@intel.com>
Date: Mon, 26 Aug 2024 08:33:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
 <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com>
 <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com>
 <3f75d979-44f9-6386-85df-e45214f7da7e@linux.intel.com>
 <d25ef936-4cf4-42f7-bccc-54b8e7e590d1@intel.com>
 <0e315405-6b69-bde6-0f3c-aba0086c11dd@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0e315405-6b69-bde6-0f3c-aba0086c11dd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: e35d6497-9b67-4eac-6976-08dcc5e4671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWFrMHo3enNQQjFuWHBla0FjaHoycEhHdkRRWTZ1OEVxRXpkTjAwb0w5cWRD?=
 =?utf-8?B?YVIrY3dKR2lJcUdFaTNBNkk3dGNDOHJFM05vMXNMQXJMNEF4QWxUTnQ3Z1hn?=
 =?utf-8?B?Ull4ZERHU2ZhL0Q2YXB1NE9XREg1S0FTZUliNTA0dmozRHkrLzlQMTJHQXhE?=
 =?utf-8?B?TlJ5amhMdzNublp4bTNDT2VOMUZPTHJYRFBFMlhoT084dEYxTXJFeE1vbllC?=
 =?utf-8?B?VmtJTWFqYzhOWjgxcW5jSEhPa2Y3N1EwL0ZCaVRXcXRMZWgxVVN5U09PR1JU?=
 =?utf-8?B?RlBIWVI4QXNTNUE0dmlKMldjYmcxY3FLNVlPeVgwd0dpekFNQkdqaTBvTm5m?=
 =?utf-8?B?VVdkZEVWM3lGZmlHRjJoc1RDTkFRZWtpU2hqZnlBTllVT2JTVUtuREYzRHl3?=
 =?utf-8?B?K3dCaitZS0p1ZGNPVU5pWDlzVnhHSFRTdE9oTzc5N2FFYnpZazZoZ0VjNHhR?=
 =?utf-8?B?Sk0xY2wvdlFQcGx3NndCYjRIckJuWFVIZStjL05FVFZQdVJUNExrb1puSUty?=
 =?utf-8?B?OFJOZDBTWkpTckFaRWMxeEJjVnFKa3RTNkVreVN1bDVKNVc0ZGJTL1R2VXdJ?=
 =?utf-8?B?L3F1R005M210akVaUVlGV00vQVA4bng4L0Y5U3E5SjdYU0NMUkwybW1qSTcx?=
 =?utf-8?B?ckVESVZDUEZmVHVRLzBwenlLcmZ3MnQ5QVd4WmZSVTZsNlMrTklGRVJVWGg2?=
 =?utf-8?B?MmViME40RmJTYnZQZW5OdVlZL3RWN0tPb3NZeEtsYzE4OTMwTDBzRVZENzFh?=
 =?utf-8?B?OTE1OXZsZXl6clNIeGhYYkdQNVVoTVRoM1FmT0hJMG5WMXl2VjRuV2JyRzFs?=
 =?utf-8?B?L0pBN2pHV2xKMjhmbVNMMS9uR09sc2ppVUJZQ0IwTVdvaEpmZlEvb0hpRUxz?=
 =?utf-8?B?bGl0d3RoTjNJREQzMExQWHpaR3lSZ2pHZktzS0F6SjlQZXRaU1pnUnVoRGg4?=
 =?utf-8?B?MzkwY05NOHZDelZEOEZjdEoyQjdIcUQwc1pldGkvS1dLaGEvZE0xYWVkc05p?=
 =?utf-8?B?c3ZlWkV4bjRFOWU2ZGZhWm40aWxJSzZpOXUxL1dEdGswTXQ2N2t1Rm9jQU9h?=
 =?utf-8?B?eS9sWTRIbURyOXo0MzRPSXBHWUlPMk1ualR4cW92NjR1Z29GVExySTVYMEkz?=
 =?utf-8?B?dW41bnhlUC9PL3J0eTVVc3hleDFNTC9yRTRCdFVyM0RqYmlUQjN1MW4zemFl?=
 =?utf-8?B?VFdycHJtTmFvQ0s3YmZvYmV6cG9DTG9RKy9GdUIyVzYxY1dBTVQvZVluRE5w?=
 =?utf-8?B?Y0F3VFZCek5qYnhIdlcybE5xL0NxVXFlYjJMaXB0UHJxdXowRlgwQWRoVUN5?=
 =?utf-8?B?Rzd4Yi84THJVMzhEMHdBaTVwNlpSNnkvdWJnYmFjVXk1T1lpMnpOVW9yZXpw?=
 =?utf-8?B?T0FGeHlvWGkrTDhDUm00V0lyclF2M3pBR0FKWUZvWWlYdCtEemdzOEhaNXp3?=
 =?utf-8?B?b2MvRlVTZUNkQ2xmV0E0S0N3QmV3eWtvUlIrQTRvRmRzN085M3F4OU55OGRs?=
 =?utf-8?B?T0g2RmdsUExFWENYN25pbXpwRVIrUWxONkxYcjR5Z1dUdXRDdHBlemVLT3ZL?=
 =?utf-8?B?NFgxeXZ1a2JLYXNUTWRObGRXbkNVaGtGZHNuckdFeEVObStCMWN4SWJqcVJp?=
 =?utf-8?B?SElPQjJYMU9BODl0eEpzbWVpWjR0ek8xTkpBSTRPVExnQ2pRcnk5NTNnUzNp?=
 =?utf-8?B?NE9DZ1hER1hZN0I5T1hoSWcxRXg4M0RYVldGNndWZER0dHRTSXFaZUtjWktC?=
 =?utf-8?Q?PNS2H+ZAIX3dXxS5Yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRXMzFreDh6QWUrcFJmaXpTSm9sajRma1RLQm1Gd2xCV09vdDM2RGNFUXpj?=
 =?utf-8?B?aHNwcTkyMmduTDN1clA0aWZIWG5YWkVGckNpYU9HdDZUWnhZcURvakZCK0Qy?=
 =?utf-8?B?Ung5UDNSSGpjSmZQTVplL3dQZytNZmVqTlZFT3hsRnhHdEhpM2pYY3dxWVlE?=
 =?utf-8?B?R1VWQVBXZzdCZDgvT2dKVmVBWlFYcmg4bWFhdC8ybWpocEI5WmVnNE5HV0s5?=
 =?utf-8?B?cEc4YkVibUlvZEpBTlVFQTFlN2ZDM1ExdksySFJzT3d3a0ZMclNXR3NmRU95?=
 =?utf-8?B?RGpGdWc2TCtuQ2dvZTh5aFhQeU14K3c2TW5IR0Uyc0pkcFRROW8zbTNVMHVs?=
 =?utf-8?B?MlQ5TzRzbnM3dC9vOFV5ZVFFdVJLSWgyQjhGRkMxeE5xNk5WdERvMnRTUTRZ?=
 =?utf-8?B?OGhBNGwzV2dLZlRldDZKWTd2S1F1ZWVEZFpmWHNxVk5VMTdacTNla3dCcXZ0?=
 =?utf-8?B?TkhyWXlmeUJDZzc0SUdLNUh1ZFBWVjhkRjNCeUlzOVJlZ2xWRWNmSSsyVXlj?=
 =?utf-8?B?dnFSbGxla1V6cTdzQ1E5QUxUdjJFWXR2QzM5WmFlbStmNXduMGZkS1hNV3lM?=
 =?utf-8?B?Q2czWmxDR0RlMDRmQitFbFdxUjJYemVGSU5nL1dHR2dvSktDSmxETTFNNm9Z?=
 =?utf-8?B?c2lLR2VJVXlPRDlRVTdEYUpSV0JpMG4rMWNibnZwMkxXRHhYUGVBMjc5aitH?=
 =?utf-8?B?eWZWN0U4Ni8rVExmWTh1OXRXakZiZmJmK3BFN00yMHRKN3hlV2hOMzNZRjdU?=
 =?utf-8?B?anFsYzJQeGdDTHAzcEE2cHdtY2I3eVNJUjJROVRkSlFiaWlVLzlHRnYweE95?=
 =?utf-8?B?TnFiOXo0OEd5Mit5SmxxclpIV2pQSmdNU05ML1dIK0hnNDE3eEsxWDFYd3Fk?=
 =?utf-8?B?R3l2ZWYyanNESnZ3bGR3UXNNQ1hZOVpxQlhQSGg3T0xJSmo2c3VnWjhRRzJM?=
 =?utf-8?B?a0JtQkF5cVdNR1c0Z3lOWU8zN1l1WHBlQlEraUxKdU9EQXNPcVVJL2dJY1p6?=
 =?utf-8?B?QjYzWUY0di9KdzB3bURCUk10ejAvNDNpUU4xYnE3cFR4TnhpZGZDTSs2WUxp?=
 =?utf-8?B?WW5QbmdvZXB3NXpWemNKam10czZNWGlzRklWMnJVWWRiMWFCcXJzTmJDbGVI?=
 =?utf-8?B?bVpxc1ZweUUvUVpFRnRiYmh3SnlGa01MOUxuRFIvZFZ4OCtBOGYrUVJqZm9T?=
 =?utf-8?B?SDF0bHQ1clVqU1ZBamoyL20zQkhvTXM3OHZSd2lBdEx3NnhCU1B1V2RGbENI?=
 =?utf-8?B?cEpiVitzNGw5SlFpT25KNUZCRnEvUUVpaWN3WHhzenRxV05Ock1WK0VkTms4?=
 =?utf-8?B?VUtvSGU0ZUdFNm9pR1JjRWlsTm9NeEd5YnpseDZCaUFxZVExaXozaDR2N1ZJ?=
 =?utf-8?B?K211U3YxQVhwWmlSMlFjUCtCTEFuUG50VWVzNjdoY3JrL2dEME5vdHZTc0hI?=
 =?utf-8?B?VEFXVlBkM1Vmblo3RXFCcXNUZUh6MVA4WGM5UVhIcEZlWjJGTC9yNEtwU0F1?=
 =?utf-8?B?TDFLRmdBSHMvTzViOVZkNk04UFRac0ZPR2ZHRHpTQmczbEZUaTVQU1dTY3Qy?=
 =?utf-8?B?MEFmc05FQVpTSVFGMXFUV2oySExQbU8zcEtFK2F3QjRlMDBqcUFqOUZXYms1?=
 =?utf-8?B?QU4wL0RrR2RpT1UzNE5rQUJnZkhkVno2SENzMzQ5bnZIR0sxK3ZSTzd4Y3Zz?=
 =?utf-8?B?RGp0UlJKN2JhZTZ0bGZ5OFRtdjBFSEQ3ZnVvcEJ0NGZ1WlZuM0hqNTFHTEdj?=
 =?utf-8?B?Y3FpaFpSd1puK05rQkxpaC8wcjJBK0orZ010M0ZDVzU4blJxTHNwTm1KbWZ3?=
 =?utf-8?B?K3VPejlCU3B4b2RVWHloUklvclUwYXFGWCtsVUpBZm94Y3NnMmh3b25CN2NX?=
 =?utf-8?B?cldVeU5IWXNlbExERVZpS0NYKzVVUGI5RDd4UEVlekdQOTIxWG9MNjhkSHA1?=
 =?utf-8?B?dFVkY29rOXZFVE4vMGF1YnNTdTFrdHRVV2RrYzFoZGNBSXFNbFhoUjdLZkxN?=
 =?utf-8?B?dTFidm5lYkZPcUFuSlREcVFSRVNSSlV1bkZWanVPUkdBWklkSVczb0RUUWxt?=
 =?utf-8?B?UWF1MVN5dkZaVDIzMUZEK0tjNnlwbWV4OVVXejNVRlBBMklvdGdWZzJya05S?=
 =?utf-8?B?clZDOTFYUE9pRHpRM25OS2tRcjR2YWkwSDFZd3ljUmEvMEtMS3p1Y3lNUHJ6?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e35d6497-9b67-4eac-6976-08dcc5e4671e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:33:15.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIE1015kvsfvqrTjDxDeqQLuaZ8kGN8zQ18C/V7A5yEep/B7Cstyx2kdTGRLCDuhvtlEbGCwnBSBIQTA9PJkPEQ+NnUKaZ28GK+dzJ+BV30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/26/24 3:44 AM, Ilpo Järvinen wrote:
> On Fri, 23 Aug 2024, Reinette Chatre wrote:
>> On 8/23/24 3:47 AM, Ilpo Järvinen wrote:
>>> On Thu, 22 Aug 2024, Reinette Chatre wrote:
>>>> On 8/22/24 1:11 AM, Ilpo Järvinen wrote:
>>>>> Building resctrl selftest fails on ARM because it uses __cpuid_count()
>>>>> that fails the build with error:
>>>>>
>>>>>      CC       resctrl_tests
>>>>> In file included from resctrl.h:24,
>>>>>                     from cat_test.c:11:
>>>>> In function 'arch_supports_noncont_cat',
>>>>>        inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>>       74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>>>>>          |         ^~~~~~~
>>>>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>>>>      301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>>>          |                 ^~~~~~~~~~~~~
>>>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>>>       74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>>>>>          |         ^~~~~~~
>>>>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>>>>      303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>>>          |                 ^~~~~~~~~~~~~
>>>>>
>>>>> The resctrl selftest would run that code only on Intel CPUs but
>>>>> as is, the code cannot be build at all.
>>>>>
>>>>> Provide an empty stub for __cpuid_count() if it is not supported to
>>>>> allow build to succeed. The stub casts its arguments to void to avoid
>>>>> causing variable unused warnings.
>>>>>
>>>>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT
>>>>> test")
>>>>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>>
>>>>> v2:
>>>>> - Removed RFC & added Fixes and Tested-by
>>>>> - Fixed the error message's line splits
>>>>> - Noted down the reason for void casts in the stub
>>>>> ---
>>>>>     tools/testing/selftests/kselftest.h | 6 ++++++
>>>>>     tools/testing/selftests/lib.mk      | 4 ++++
>>>>>     2 files changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/kselftest.h
>>>>> b/tools/testing/selftests/kselftest.h
>>>>> index b8967b6e29d5..71593add1b39 100644
>>>>> --- a/tools/testing/selftests/kselftest.h
>>>>> +++ b/tools/testing/selftests/kselftest.h
>>>>> @@ -70,10 +70,16 @@
>>>>>      * have __cpuid_count().
>>>>>      */
>>>>>     #ifndef __cpuid_count
>>>>> +#ifdef HAVE_CPUID
>>>>>     #define __cpuid_count(level, count, a, b, c, d)
>>>>> \
>>>>>     	__asm__ __volatile__ ("cpuid\n\t"
>>>>> \
>>>>>     			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)
>>>>> \
>>>>>     			      : "0" (level), "2" (count))
>>>>> +#else
>>>>> +#define __cpuid_count(level, count, a, b, c, d)	do {
>>>>> \
>>>>> +	(void)a; (void)b; (void)c; (void)d;				\
>>>>
>>>> The changelog states that this casting to void is done to avoid unused
>>>> variable warnings.
>>>> It is thus unexpected that not all parameters obtain the same casting
>>>> treatment. It looks
>>>> to me as though this only targets the resctrl selftest usage where the
>>>> "level"
>>>> and "count"
>>>> parameters are constants.
>>>
>>> The reason is entirely separate from what resctrl selftest expects.
>>> a-d are output parameters for __cpuid_count(), they need this treatment
>>> because they are typically not initialized but set by __cpuid_count() so
>>> if __cpuid_count() is doing literally nothing, nothing touches those
>>> four variables leading to unused variable warning.
>>>
>>>> This is intended as a general kselftest solution so
>>>> I believe
>>>> that all parameters would need this casting to handle the cases where
>>>> "level"
>>>> and/or
>>>> "count" are variables.
>>>
>>> No, the same issue does not exist for input parameters because it would be
>>> a valid warning. Passing uninitialized (and thus unused) input variable
>>> is wrong so the calling logic is wrong. Thus, I don't see how the same
>>> error could ever occur in a legitimate case for those two parameters.
>>
>> If I understand correctly, the scenarios below are legitimate cases and
>> will produce compile warnings with this patch applied. It is not obvious
>> to me that the calling logic is wrong in these cases. If the output
>> parameters get special treatment to avoid compile warnings, should input
>> parameters not also?
>>
>> scenario 1:
>> 	unsigned int level = 0x10, count = 1;
>> 	unsigned int a, b, c, d;
>>
>> 	__cpuid_count(level, count, a, b, c ,d);
>>
>> Above produces "unused variable" warnings for level and count.
>>
>> scenario 2:
>> 	unsigned int level, count, a, b, c, d;
>>
>> 	level = 0x10;
>> 	count = 1;
>> 	__cpuid_count(level, count, a, b, c ,d);
>>
>> Above produces "set but not used" warnings for level and count.
> 
> Ah, so you meant a different warning. Yes, I'll add void casts for
> those input parameters as well to avoid this.
> 
>> The changelog states that the goal of this change is to produce an
>> empty stub. To me this creates expectation of what we are used to
>> and expect from if it would be an actual empty stub. For example,
>> static inline void __cpuid_count(unsigned level, unsigned count,
>> 				 unsigned int a, unsigned b,
>> 				 unsigned int c, unsigned d) { }
> 
> For void functions, yes. But if it would return int, it wouldn't be
> literally "empty", that is, it is still be empty stub but does something
> so a very literal interpretation of "empty" is flawed anyway. But I can
> drop empty word from there, "stub" seems enough for the purpose.

Considering the context of the discussion my focus was on expectations
surrounding parameter handling. In this context the "custom" appears
to be that stubs do not trigger compile warnings for parameters
that are not used.

> 
> If you on the other hand meant macros cannot be called "stub", what should
> they be called if not "stub"?

I do not know if there is a more appropriate term. "stub" seems appropriate
to me.

> 
>>>>> +} while (0)
>>>>> +#endif
>>>>>     #endif
>>>>>       /* define kselftest exit codes */
>>>>> diff --git a/tools/testing/selftests/lib.mk
>>>>> b/tools/testing/selftests/lib.mk
>>>>> index d6edcfcb5be8..236db9b24037 100644
>>>>> --- a/tools/testing/selftests/lib.mk
>>>>> +++ b/tools/testing/selftests/lib.mk
>>>>> @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>>>>>     # Build with _GNU_SOURCE by default
>>>>>     CFLAGS += -D_GNU_SOURCE=
>>>>>     +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>>>> +CFLAGS += -DHAVE_CPUID=
>>>>> +endif
>>>>
>>>> My earlier comment [1] when this work started remains. This technique
>>>> depends
>>>> on environment passing ARCH, which cannot be guaranteed. Looking at other
>>>> usages of ARCH in the kselftest Makefiles it seems that the pattern is to
>>>> initialize ARCH with "uname -m" if unset.
>>>>
>>>>> +
>>>>>     # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>>>>>     # make USERCFLAGS=-Werror USERLDFLAGS=-static
>>>>>     CFLAGS += $(USERCFLAGS)
>>>>
>>>> Reinette
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/db16db55-5f68-484f-ba9f-3312b41bf426@intel.com/
>>>
>>> Ah, sorry. I'd missed that comment because it started mid-paragraph.
>>
>> Where are comments required to start?
> 
> Obviously it's not a requirement, but I'd put each recommendation into own
> paragraph to maximize likelihoods its not missed. Despite the paragraph
> containing answers to two different questions, my mind I only registered
> the answer for the trivial program question. Again, I'm sorry about that.

Ack. No problem.

Reinette
  

