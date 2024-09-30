Return-Path: <linux-kselftest+bounces-18700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D663098B0B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E828227F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E7188A1A;
	Mon, 30 Sep 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9aMnG/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FF187322;
	Mon, 30 Sep 2024 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738324; cv=fail; b=mnPneM02n+weHreAknq2GTd75BWyFd8TawzETTKLd82gzPgTGvReE5n635/MGQs9tq30jqHicXbxqk76SVozzZdHlksClGvgNp3emZiQlodtsQSkrFqe0U0xrghx1uVc8yMD/duAA5n+iuWlkSPXB1l540EUhsvEwBPDEbSixNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738324; c=relaxed/simple;
	bh=sMSTCptB0hcv6LocGKDNLEecG/BZwsi/qQlLeBmqde8=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SwUlIA+xoB8Xyij6QPRdv8wZVUbQ0B/6Sd0ZbMomnW2ny12hhKCVQ4V4ZQu21SYe6MFVKUXkVqaPSDFh0JfWyS5k0pnBi713tqZuzPCbtpm13H7TJgybhhQ2fGAutO0uoVvbSPbGDOXp+HIR13UCOf72oEtyZhsixMsiAbtC6Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9aMnG/H; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738323; x=1759274323;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sMSTCptB0hcv6LocGKDNLEecG/BZwsi/qQlLeBmqde8=;
  b=j9aMnG/HATV94efK3NJLiqX4Ax3nQZQsyVciweFvFKqWTQ8HY2BVYhPn
   ASBzd3Qkx69ywcj2fCqkqR6OMA+uRgHluBiJK0bdTpqvoVjoR7jLyVOTS
   ekggmOM/RvVWA8FU8kThA8BPswm/qfjczH8IRJzKN6GwG52gWurzIRySA
   dq2QoV8CYIL2JrZUxdwfrs2oX7crsS9BUNyaLB2plel0aiXLF6G82TCw2
   AN0g0L6oP1BQ7NcZPNCIhVAG11J5cHICtGNEd3kJITyNMKcHVqmkGor15
   +13wm5KgWTElZoS0fNc3G5UOYE7nZmZJvXHBXkPXmDlb/AGiyn1jm9rHu
   Q==;
X-CSE-ConnectionGUID: N+AbAlR2S/GM5AWkIIIERQ==
X-CSE-MsgGUID: WSMtOEKSQK2L4HbsTH77bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26309974"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26309974"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:18:42 -0700
X-CSE-ConnectionGUID: rvEKRqLwRNC8whgCAYb/Yg==
X-CSE-MsgGUID: RAByxd3jRGScPxebRXcTVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73507601"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 16:18:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 16:18:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 16:18:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 16:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G02MNwx6kFxTKM8zzrOWbzq1thvSq6/bl10MrWBzaW/rfbnjaJs58GK9WeW7/xomqrNG76tp9q5Fow+dWOtPDUUXX1TNvjMdy45AMIMMdEtGeNFdTAJB0OdbAUPGzHCzkg0vAkywsDbXXa+ioDRUZSxHgiV2Auc1BJMgoNrbBH1yhgBwow+LzPUYj41NcxsjnE8yhEtr4VaF6aOlB6KEPbPrbowcMFS4UabUpXsUq2+ooJU/MuWxTN98s8R4H71nc0BqfA4HaroHJgy94sKop+ZhlSQ0PDH/LSPUDRYkPq49z+DQ/Pio9OrHMX9Qczu4uWKghMgEzqVUhjZvsEoqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3jpSQATPKjbQktD7hb+zWyFP7bVA66C9qg9b3oXrZA=;
 b=EuqzAv/Yy17YWWvH4rZ/RH0WyX0q5fMO6L5ZthGsiA9Q6t/rdGFBoit6509MgSNk5Ki9pmlCM/qWM5xC9q+wZKZpa76QW8sn/LmAIpVHv31SJxJgNSU1nc5h4ph/m4ztJXsS7QYqBbZu7JBIn2A1JWMJcXlOxHLEx51wyRV/XdloV37z/eSNQG/YtI+oFEfevpLz9intdNPWC95qgpmcA0mmoSLqjTmQsEazQRJ5fBKyjvXGOb8SCkNu7DpQAL65nuffyGmqhkcOq1fFKk5CdceLZsyYAbo01O0rEF+MrXotn7UpKTORRROOXQJNCHrlUA+Od97pj/5cJpAeppqrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 23:18:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 23:18:33 +0000
Message-ID: <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
Date: Mon, 30 Sep 2024 16:18:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "list: test: fix tests for list_cut_position()"
To: Guenter Roeck <linux@roeck-us.net>
References: <20240922150507.553814-1-linux@roeck-us.net>
Content-Language: en-US
CC: <akpm@linux-foundation.org>, <davidgow@google.com>,
	<kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <richard120310@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240922150507.553814-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 026b8f66-0db2-4539-84b5-08dce1a6341e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1VyUjFDWEZCdGNvUHZDYmIvamNVcVoxeE5GMzVoN1dPZ3pvMEMwbDNPaGNt?=
 =?utf-8?B?UnNHUUZLaldxa1d4a09xTVlrM0tuclpyd3dyNGZVQVFRbGZHL0tzam5JM0R3?=
 =?utf-8?B?a0FrSjFmU2hpdTBJYWV0aS9FY3o1Y05sdlVFWDZoTmh1bFh5MTlXNFNPcStj?=
 =?utf-8?B?aHl4azJjRWhkc21YVHpIcVFJNjZ1ZEViSEtDK0RMdXJvMUhvZ0p2QitwRTBj?=
 =?utf-8?B?amRhd2ZCUzU4cVRRR0JuQjU0TW93SHgvRE1LKzNsSXNvVFZ3MVp5cmx2a0hW?=
 =?utf-8?B?NVhPVnZqS3hJRlJKOU14WkNtNHNzdlE4bTU1S2wzcUtUVUZ2Wm5HUExMbXJ3?=
 =?utf-8?B?L1dJT1N5TGt0OXNWc0V1Vk4yVlVYWUZMa3ZIaFczZjNYMXVxdVg5MEVzQzNx?=
 =?utf-8?B?WjZldE1HbVZWZzVOUytYV0J5QWRWT0dUSUszUUhNbXlXQ290eHVjKzNGam5x?=
 =?utf-8?B?cFAxWjBPTE8wQytJQXVmQzNqWUlzYUtsbkxDWHRDSWpQWm9jMlpSS214bXY1?=
 =?utf-8?B?ek82bjRCcnNKbWNocmkxL25tMnBSSzVMeEQ2STZTRzB2eWhub0lZVVBwUGZS?=
 =?utf-8?B?TjRBdmR1Tm5wNUhLWVdKK0hXZEI2ZEVTWGQ3N2gyVFJMUWxuRTRjS2dlblNT?=
 =?utf-8?B?bUZ3MzZJbGJwSmZwbWs4ZXQ3L2JKcHZlMlVKd2tVR1l5dTNmWkhLVWJUcmE2?=
 =?utf-8?B?Y3YyYUcxWFgxc0JpcHBIRDcyRFBraDZJcHRuRGFyWEo2NW5CRmwxYk9ZUjlI?=
 =?utf-8?B?dkQ3TGlwTVpNZXVsa2cwTmQ4THhwRHkwZjJ6RFQ2QmxEWndYb3B3T3JQSjZF?=
 =?utf-8?B?MmJMdTlnK2ZzdzA2ZE5YRjl3WjVWQUFOZ0lqRTMxb2hoWkphb0FxanFCTUti?=
 =?utf-8?B?VyswWXdWSGlnMW5FaWFzTnFMQkhFamVLT2szdE9ybTBvb1hoSjVNOTBlV0ww?=
 =?utf-8?B?dnorRmlHRmcrVWFGeG1yNnkwWldrSFUvUENnTFYrQ0QxYlFOQWUrL3o5YmI3?=
 =?utf-8?B?TWtxT3FkQ3BjdjB6Y2ZkTXlPWXAzN3FySWI1bHpJYXF3LzNGR24zaUdXZ0Ez?=
 =?utf-8?B?dDVPU21QdmVXTnpHb2lxVUdkbmJrbXE0Y1FFV2RieVhYQUh0aVUwWHJKRVRp?=
 =?utf-8?B?WTJLNnIwVzk1UUVTRkE5aDdTalFJVG5RQkZCMTRuVkJxdWNYVHRxRmJ2Snc3?=
 =?utf-8?B?TFpYUVZTSHVtbjBLOXNJL0Z0ZDVnVUg3REZtd0JjWkNMSVlMWEpaT3hxKzJ2?=
 =?utf-8?B?TTZQR2U5dE9mT3o1L0duZGhMTGg2Q2c3NFdqYnNVSXh2ZUw3Nmp5ZmRvNkpC?=
 =?utf-8?B?Z0xRVU9sT1U3ZDA0OGdTYkI2WGpZUW5XVjBpQk5XMVRER2dhWWdpSkdFTGpG?=
 =?utf-8?B?Zm10NkdudWUzWk1EZ1VCK1Fabi9VcXByTHVLWkg2bWE3TU5zR3NzZ05JQ29D?=
 =?utf-8?B?d3pieTRTcktvWEdpRWJhMC90SmdieDZ5eFc2RXFWMXU3cWNwMVJHa2xrOTA5?=
 =?utf-8?B?L28zVU85RHNkZkRVN3lWYmZXZ20wcXBLc2pqM0xnYVF2d1RoQXpSc2RRN1Nx?=
 =?utf-8?B?NXZQdUFJcEFSVFdUd3RUZkFBSmlYR004RCs3ZmQrSUJudnpXT09nZTJtSnBa?=
 =?utf-8?B?VG1JejQ1OHVDbSs5UEhoRlBacS8vWlpDK21mRzZrZ1o4WisrZUs0SnZHSjRT?=
 =?utf-8?B?VXJlL2tJRXQwV0xGTGppa0VYUXpjQjBmZkUwSllpMDRlTE9seXdlY29nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRxUXFRQWFvbnVFQlRnQ2FYdXRtd1ZQWWxvT2dTaXJuWThJUkR5a01XRG5w?=
 =?utf-8?B?QytZbXcyaTVtcWhBdEF3cHlKdG5YeWVZR2M4U0gxdTBrTmpSbTMvbW85VDRC?=
 =?utf-8?B?SzBZWnkvYisrVHMvUHh3TUhNdTRFdmhjeHdob1M3UFpsdFFUdWtpU1A5REhm?=
 =?utf-8?B?KytqNm01YmtzQkExcVFzWFNHWm00ZEJoOUhNVTZseFZhUjdhV2tjZUJuT2Rn?=
 =?utf-8?B?VE1FbkNSK3VpQWtFdG1majNLZG9MdWhSNEZCNmtPZFJEMVZhKzcxcnlNdWxr?=
 =?utf-8?B?VWpzSXJaM3U2RGdwTGMxSE9ZaXlaRzVBMG1KYjB1VEVpNkdLQzdOZXFvRDNN?=
 =?utf-8?B?M2xlYUltVjFJc2l6NUs1VDd5QkRLc0lYRVVaakh2QWJFb0xPeWRDenVaMWh4?=
 =?utf-8?B?TDJBUk1pR1BZWEtEZlpUbEw0S3gvdVdQb1VRTEwyL0F1NGtrdUp2S3pRY0xY?=
 =?utf-8?B?Wk1YLzJ4cnhJZnYzVXZCN1ZTaEk4d1BteWVQMEJtZ1ZhMHhYUWZ0d1RzVDRB?=
 =?utf-8?B?UmV2aURUQy9hdTVHZ2w3L1JHbnZtWmFCWS90OUVnMUQyZFIxblAwRHJhUUsx?=
 =?utf-8?B?T2JFazIwM3UyRWdtS1FjUlhYNkFPTm9UZWxvdjJtZGdQZ1pWQzlPcWtTMmhH?=
 =?utf-8?B?QS8zVFJsR3EwTWR3K085RjRpdnpKTFZodmU4ejZ4Z0NZdlRlbXFmakhaUFg5?=
 =?utf-8?B?TlkzVEtqWnd2MitFM0ozVUxwY1ZrN3JuZE85MXVPQXZjdnZwR0lORDJBSzZ4?=
 =?utf-8?B?Vnh5SlB1anhMaDd2QmpDU3VJUnZFaDhUQ2NmYUREZUZPcTdGenZBbEMxS3ZX?=
 =?utf-8?B?RnJyY2hEWHkrUk1hSVhLNkQzeFBzd3QrWTRxRjExWU5Gek1RNGZITVFnaGNM?=
 =?utf-8?B?S2JIR0IwUkJEa0F0cGtYRUZhR2psY0VWckFzMkxIcnFmVnJ2WXhmUWFuRjNi?=
 =?utf-8?B?Q1pJUWVFOHpIVDMxa0ZBK2pySFVvZjIyQ0VsQkx6cGUwMHNibnFnOS9xQUZs?=
 =?utf-8?B?Ukx4UjlGS1dVay85WkJIQnVMV3VPT0N0ektBcnExS1JIRUw3eERQdmVncnZz?=
 =?utf-8?B?Wkw5eldySHJzeFZkYlZ3cEF5VFVlbHRqeWIrOTZWajFxcC9FQTVFRUtjN0Rj?=
 =?utf-8?B?NXVxbS9KNmR5NU9YdE5lOW1SNS9ESkNBNEZTUXBYcWV1R1hwdTB3bEFhYUU0?=
 =?utf-8?B?a3pycHR5T210YmYramx4Q1c5TEU0cEloQ1ZHZnpicUlhYXV3OFBFbG43RC9x?=
 =?utf-8?B?LzNkSUpZYS96bkVEQUJCQzdUM0hnaHdHQWpla2RzbUZqVEoyUllYc1ZVODJH?=
 =?utf-8?B?OGxIdmlEOXlqTHZiK2lZUUZVRmVOaHpKeHdKV1o4NUM0R21BWDFYQWpKVzNU?=
 =?utf-8?B?RHl2MEx2WWQzRkFKMDkzV1VhNEgxU3hyblViRlUzTmE4SmtQejJFdXQ1ZlBC?=
 =?utf-8?B?QjBNaHE3UDRLMnlacWplcVorWjBiR3oxVFA2Vmhka2Nqc01wQ0gyMkdDMGMv?=
 =?utf-8?B?NkFEQ2NWVXp4Y00xSWNJbDZyaG5YU3BWc09tcVdScmRFSWJNSGE5QkFWR1ZV?=
 =?utf-8?B?SmZYOXY2RnlrV2lySjEzd3h3bkF6SDNyTFB3V0NXY00wQ0lwS2N0YlFZYVl6?=
 =?utf-8?B?OGFwTzhhRmxYYm9aL0ZvemFnV2htclNSdEJienJyRWVqRE8vRXlXaEx5ZkJx?=
 =?utf-8?B?NkQrdVVXRWJoWlhjMDVjN2l5TjBscGZSMElaa2pTR0FKb3lyTUZ6VTBuL25r?=
 =?utf-8?B?WEFBL2t2NkNnTm5aWklzdWNmWUFZbEpqWWx1d0thcUJ5Q3dJSDlVd2oxaC9k?=
 =?utf-8?B?dFk5VE54SHd3N09xbUZPMGlxRUx0NkY1anBISVE5OFBRVmdLTmR3MHFWUkJk?=
 =?utf-8?B?amtIVHdLTWl1NWVMbnFKb0tOWmtWVE9zSWlFeG5pNmhySnpDMWhxOGhWdzlP?=
 =?utf-8?B?VDN3QWtWRE9CaGM0cVhFZXZEaGFHS2lieHIvTjYxZ2ZYZlp0aTc1MWFVYnox?=
 =?utf-8?B?SVpjSCswODBMUnlkdFVYbFpabGVKbUZmTlRMK0g2cFc4d2xzT3pTaFhPWEtZ?=
 =?utf-8?B?YlNiSU9FSVdRKzRKa2h2VEpRUkN3N2ZUM08rTEQvcFV1SlJxNGJKOFlCNG1k?=
 =?utf-8?B?Z3dEMytRczlvMnVlWDJESDVKSzUxbFlJczdmdnRtM085RjVreklSSitYQUpJ?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b8f66-0db2-4539-84b5-08dce1a6341e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 23:18:33.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYnB9mE70efcITFlqp/AI3SQpyVDEyz6t5DqmWrinAejNBCAwpQbDgLXauA4PdG51QRz5n6wHK1CEmlTuH6kns23pUBSnVQavzT7xVw67eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
X-OriginatorOrg: intel.com



On 9/22/2024 8:05 AM, Guenter Roeck wrote:
> This reverts commit e620799c414a035dea1208bcb51c869744931dbb.
> 
> The commit introduces unit test failures.
> 
>      Expected cur == &entries[i], but
>          cur == 0000037fffadfd80
>          &entries[i] == 0000037fffadfd60
>      # list_test_list_cut_position: pass:0 fail:1 skip:0 total:1
>      not ok 21 list_test_list_cut_position
>      # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>      Expected cur == &entries[i], but
>          cur == 0000037fffa9fd70
>          &entries[i] == 0000037fffa9fd60
>      # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>      Expected cur == &entries[i], but
>          cur == 0000037fffa9fd80
>          &entries[i] == 0000037fffa9fd70
> 
> Revert it.
> 
> Fixes: e620799c414a ("list: test: fix tests for list_cut_position()")
> Cc: I Hsin Cheng <richard120310@gmail.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

I ran into this as well.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  lib/list-test.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 4f3dc75baec1..e207c4c98d70 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -408,13 +408,10 @@ static void list_test_list_cut_position(struct kunit *test)
>  
>  	KUNIT_EXPECT_EQ(test, i, 2);
>  
> -	i = 0;
>  	list_for_each(cur, &list1) {
>  		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
>  		i++;
>  	}
> -
> -	KUNIT_EXPECT_EQ(test, i, 1);
>  }
>  
>  static void list_test_list_cut_before(struct kunit *test)
> @@ -439,13 +436,10 @@ static void list_test_list_cut_before(struct kunit *test)
>  
>  	KUNIT_EXPECT_EQ(test, i, 1);
>  
> -	i = 0;
>  	list_for_each(cur, &list1) {
>  		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
>  		i++;
>  	}
> -
> -	KUNIT_EXPECT_EQ(test, i, 2);

This test failure was also pointed out during an earlier review of the
patch..

> https://lore.kernel.org/all/CABVgOSmn=SEwq3je3+vJ-S1Rwb=cLT2a3_WKOQsHu9xZYEZhrg@mail.gmail.com/

I suspect what we really want here is an explicit check against the
length of the lists.

