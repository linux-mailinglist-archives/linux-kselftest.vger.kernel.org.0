Return-Path: <linux-kselftest+bounces-11431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7AB900BCA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F8C1C2219B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342913C83E;
	Fri,  7 Jun 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLrIkfu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABA7347D;
	Fri,  7 Jun 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784193; cv=fail; b=U/TcospTeGbXFd7Yj9hBkJOpnvlTgqDMw3/pIgVunDQ7yyjHkie55UHsWnR/jDGCzQ5UdSpRTi/pM2F8UBk1hYLniEkt15gSO+YV/cMcbC4n1WePY2jwD1iWdENkLJKAucvICscTLmLg9JRgy04gQPejmABxY+HqwhJVjYEvb7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784193; c=relaxed/simple;
	bh=v5ndSTRZSVVtxuET0u/5Y+m8JwViWre8hTFK/WktoxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aF+7olv9+Wg0+h2+6OsdzNAw79IP5gsPfuwAcyCZtSrNC7bEYuL9xdQUFqvO6h9ChDDvh+5lrY0wTPS9hOH5FQTpepbqdl7nJL7hU290ERbZilSL3B3wkYlTGZ5AkkjzVS3Nte8PRhzsjDVuGYd6JztoEGiwEi+rO4njjbH5ZxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLrIkfu0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717784191; x=1749320191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5ndSTRZSVVtxuET0u/5Y+m8JwViWre8hTFK/WktoxY=;
  b=JLrIkfu06wz8wblBCOkF+ZVOZQ4wSo0zpBqv9oHUL3eIpb0Yu2dyqbi5
   xIqlp9L2/ktWm31U0gBquR3cgzdbJ7QBVk/JoolHOwnyqy5WqOXCj6A9s
   NEAyq8Hv2Y974vLRZyuPpKSajL9wAxMFoZ2H5V9xJAvHCzxLyLZLVoSsO
   T7nFHKyPo6OmotllurhypaV9FC1cb1TO1wWlvmi6XGqw2pEHi+xaAehYI
   GBYXlAjz5/Sv1OR4YyGsi4YFwxbZv8ERKDehOdBgvE1Q4eZUamGWVuBd/
   nf2k62gx88l6vwbUxuUCHcsui6RsjFujphexkJXpNzeqsOP5g+9Baac72
   Q==;
X-CSE-ConnectionGUID: GrPiUTj6Q5qsN10X8T/uKg==
X-CSE-MsgGUID: +8DS2wJWQkWTx1QgqYLxkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25921726"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25921726"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 11:16:31 -0700
X-CSE-ConnectionGUID: oJLqSzWWRS6QWGkJZGYTUw==
X-CSE-MsgGUID: hnDbmqA1QH+O2ZCLGL0K0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38524030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 11:16:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 11:16:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 11:16:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 11:16:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 11:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP1eaUxu9c85KuOO7iGPiRHvWKdw6P5bkqysGkNsSNs+jMnRH/OnBZX+DTyfacwRj/FlIaDJwe0SqMmeaKIAui/c9m/qGzuyAQ6tJXJiz1UVkt0BkRqYxPRiyE+zcN280CNYJD92TkCCc+wz/zVL+PIABDmFCvOW9taRDXIaHMM4d0dzeMa3q7wjxnVZT+a5IXXrNy+Sky3QtyV9/E6zAG6ujq3PWeia12t5z+6uJv8crQJ3Yf7hdorSYWWc+v/zF4upXOOyHVIoetpI2D1S3Ydn3rcKUqo98B6XkEvrXu51Vdo+WtW3nlJ8RZV8ghNa1X32CWwo9p1XZgGhebKoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlMhuHt5C3uUgVTfXRqBeodMQkaphoYSRV4TN7h9Sz0=;
 b=T5AxG5Yp0uHouWZP4T+n7zw+19w3szPlHNPOyF5vEgdI4+N+lffeI7q//oCNPJ7UT+sTW5iIvn4J/Yc90YVhYd+EroDQZRIrsjA/kkYZccwrA56cMAqncb2d7z1uQx5jW1cKlnmPFg6ztW13ItXnhdY1AmYVCC3+0TzK6iFQ2yXfYolmClzFDgX+iD6zcfrEwN90z5SvqSexXq1//6t9D8e0m5BAFVou0Jh6oa885wdOE0oYssCoGd2668xfY6LJwSrNJQWfOw4IufpnCO8tdIoO0RowqXonWv2uPuKD5Z9ZNsy/tEbUE37lrvPPWYtjR4E6u0DvJQN2d4mFEFElFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 18:16:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 7 Jun 2024
 18:16:27 +0000
Message-ID: <45758766-f3f6-455d-ba34-36b9fbad80cb@intel.com>
Date: Fri, 7 Jun 2024 11:16:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] selftests/resctrl: Remove mongrp from CMT test
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
 <20240607125316.7089-16-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240607125316.7089-16-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd7559b-939a-4494-1d8c-08dc871df261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEtMbkxoOFlmVmRNVHg3K0EvZXNPNmhPVWtHZE9VQXRpT3dyVzkyRTlqcVhJ?=
 =?utf-8?B?cnNwck12Yzc2d3dqdmlNNVZPWElkTXJaeUw2UUxWYkNjZ1RpcTcyS2ZiRXUy?=
 =?utf-8?B?bnhFT0xMcXplUFZCUk1ldGpQb21JR3hlQkdJQ1N1S083d25NMWZRbnRRbDEy?=
 =?utf-8?B?WVFhSlBYQWtHZzZwTmdVUC9DUTZOaDRXZ2Erb1BIdmhzMEtPVkJmVm00U0hz?=
 =?utf-8?B?T3BiTTk5azNDTDBzV0hNcU1KdWt3RFlQdGl6ZFg3OXJUQVFIaG8wNEVlcGN4?=
 =?utf-8?B?bXRXQkdxK1NzR01ZN0VxcmRFVnNJRTQ3bzBkcjZibXJRRkRYNytjOU5BNFpV?=
 =?utf-8?B?KytrSUxuV0JYSnpyQ2dqN01sVGhhelU1OHlrd1VobzRSRnJhNUNVVVV5S0h2?=
 =?utf-8?B?V0k3bVdoVEFyeFhiOVBRL3M0VS9VdHZIN1hvRkFlS09KWitLMlRqOHhUMkQy?=
 =?utf-8?B?UjBpVy9aeW9ERWVnc0hBZk9sMHM2ZTNlMlJEQUxqc1BjZElPcGUxWUpWQVZq?=
 =?utf-8?B?VTk4alU4cmRqdGxXb0wwMDZLR0FWMlJVd0ZuZGd0NCsrUWFBa2hERTZ4R29v?=
 =?utf-8?B?TytMaUtpUXJQL3E2d2U0RGMwUTc4ajZQL1hYQTNCaWZJVHJsbmJERFlscVZq?=
 =?utf-8?B?ZUJ5ckkraFE4bHJQeHdBdU8rM244a284NTFGTExQZWhHRGNPK1FtRFVaTU0w?=
 =?utf-8?B?UFV1a253WGJ2Uisxb1ZZRHFQVVlybGtOZGZnaGxxcnFLMUV1RG9VekNPVlJR?=
 =?utf-8?B?aWlPd1NDL1VweW9SbmdUWWhoaXVGTnV4V3BscmoyTDJVeTdiWlYzQURQdjVl?=
 =?utf-8?B?S2Nubzg5UGZPMWhBNGg2aFd6SmtJRmF4WUhSV1lhd0FsRmtrQ3E3KzdBNkFR?=
 =?utf-8?B?NVR1WDlTRm92QjY1S0tpM1ZxMEdjVlhTdUZ3VmRhbVpsK2liWEFTU1pvam9C?=
 =?utf-8?B?dXhJbnc0cVArZEhCM1hrdXVhTFo0dExDSEY4SWNhTGQ2SXV2NkNud2RRRGg4?=
 =?utf-8?B?bVljYTQyWlVxQjhobWt2NXBDQURpVjdtdWJtbFVwQ3JhOTJqNnFPcWIrYjBD?=
 =?utf-8?B?eHk2bko0YmpiazlvWGt2Sis5eGNBd3dWOXZXaTNNeGlTV09KaGRlb210NlBa?=
 =?utf-8?B?SzhzYUdVd2RYUUhYUWQ1UVJkekU1aml4ajR2aVRpMEZsWGEzdTZSN003c0Zt?=
 =?utf-8?B?Y0NyMVFWV3Yzd0NHdXhhRVgxeGhTNGxvMGNXTE5oOUhQdE01eGRBMzgvTnhM?=
 =?utf-8?B?b2YwQTd0cSs2enFiNXU3ZjFUaEJqT1Z1TDZzUHptVFFEUG9oYUhKdGE2VkMx?=
 =?utf-8?B?TU1XOCsvTkVJemtGRFNtYWgxVU45Vk1zbUdIK2tHblE3QXA3Vm1mWVkyM1li?=
 =?utf-8?B?V3lDdHRHOWU3ckV4YVl3VklNcmxCUm5hdWVlRkxrVWh6RENqZ2Jhc2tKWGVV?=
 =?utf-8?B?dmdNcDNHYTRaMDJpOWRWbUkwTFNyWFNodTIrYTY1MlhIZkxNNWtNdmh6TmI3?=
 =?utf-8?B?TGYzN0RFZFBGb08rczZURnhsWFN2NjFzczJWZEZJd3picUVCOUZRNWRsaWg5?=
 =?utf-8?B?QmdWY0ZTcWdWWVd1VCtCbWdJZWJXMUNlU2xwU3RyU3RNZXV0Mm1Wdmh1RHF5?=
 =?utf-8?B?WU1kQk81QmFzak5GaldMcWJqYVFVL2pPZDNYTkhPTkxIV1BvYjFadlo5Ykps?=
 =?utf-8?B?V0dZaStYRTBrRmVucWhWVm9CUHBCRFJoZG1Ydm1oSjJycm1reGNmWGNqa3pS?=
 =?utf-8?Q?p+3+GqxTKIJrFYfz5wCVu2/lLfWYAcugL5vPe3U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFQwTGYvM09vVHNJNzRYazFtMXZQUm9qZHlhVkJJTHUyRVZoZGtLdkRFaGZL?=
 =?utf-8?B?UnZMSVpPOHFxa0VDVU1nZnFacDNqQVBaZVNXRm00NVozUXVLdGdhOUhwN0dJ?=
 =?utf-8?B?amE0YlJoS3BWZFZNOEZEdjFhZ2pUc3h5VnZmdHBBVDlzZzFVUllZWXQ0d0U1?=
 =?utf-8?B?bHdtV1B5a3huUWV2NDhRUzNWRHZNL09JOFpmbXpaaTNSZDcyUVBNOWlVcUQ0?=
 =?utf-8?B?WitWbWxXOENaWk00RElNeFZDWStqUjQ0YTgvdllzcy9LNEVTWDFjUnF1Ulpa?=
 =?utf-8?B?M3orcC8yT2MrRDFLcktIdEpzOFlxWjJlNDZ3d2g5VURjZVc2Z1FlcnMzY2du?=
 =?utf-8?B?bVlVQ0pRQ2RUNzVLNnM2NHZCRVArMmxJOWFrYVVOVS9IT2JsSG9Hd1c2QkRX?=
 =?utf-8?B?WHQ4b28zOXdGQ242bEZwanZER0ZyNXk4Wmkydi9ScklTVWJ2Z2U4M3BnakhE?=
 =?utf-8?B?Qjl2aDBBWUV3V0g4bmpMVnoyaU1aaS8yWG9IT0JSeUlMZmFRSlFMZ0RXOFlR?=
 =?utf-8?B?bE40MkhKbGZaNHBWa0k4bzZlZW5ISVpFR0k0em5MdS9tVnFVL3N1V0xibFZq?=
 =?utf-8?B?WFBQcmhxY3ZDNzdoZE5tRE1VL0d1Vmc4UXFKMUpZTWpnWWJjckxlSXl0NW5Q?=
 =?utf-8?B?NW0zUUpwb1ZSR0FDL05samxPaldnMVZBYzNRbks3dkVjSldTVlp6UlJLYVdK?=
 =?utf-8?B?aHlmRGVldVFvM1JSb2Y3cmZsazIwNzV4NzhxWmIraTNEcm1DNHpVQ0d3dkZX?=
 =?utf-8?B?d0ZVM3VYTHBXNzhlczNJcW92SzdkViswTWk5OFVQbEZVQlBVeUtQV0hEMDlo?=
 =?utf-8?B?N28xSnE4TXJjS3crUGhsUGpaS1JiTDZRWkxlOXlBYTQ5SmJVT2lVRy9JSkRp?=
 =?utf-8?B?dlA0Vyt4bnpWQ25IOGxyN0RhTkRTdkNqYk1vU29oMktpUEtSRDdHRHZ5TEEv?=
 =?utf-8?B?cFAyWFhicVpDcTlqNVNyd1cxaGJFdE1ZRG1za21HUUpmL20zUmRNMTZaV2po?=
 =?utf-8?B?KzhTK3Y5WjA5MTdmc1FKY1dBRUh3WnN5RlZxeHNYYzFCeFVuRUxLeFoxVW9S?=
 =?utf-8?B?aUFFcjZhcHNwU1dFUks2TFV0d0tPdjdCWkczUS9TaFVFZGZXN1FVT1h5cytG?=
 =?utf-8?B?a3p2NXFCUGVUR28zT3huZGRUalkwZFBXek1SUCtaMFBXMFJYaWt2M1BRZWNX?=
 =?utf-8?B?Q2Z6U0hZTHh5ckwraHYxVU4waGZHZG1vRkpWVzRzZ2cwUWhVdnRYVlBlYTJY?=
 =?utf-8?B?K2ZlNTdndDNHL2hMMk9hK3lIaHZrc2EwWHk3SEFNVlFFQzllVjY2YnFCL0Jy?=
 =?utf-8?B?TU52YTYvOE1oRjA3QVpndS9SVlF5SEdCVU1ZK0xTSlNOOE51S1AzcnhpRUZp?=
 =?utf-8?B?d2ZOekVGaVpRSGluYTYwVnZjcVNqRjBCa0swSWxKajZMcmJpbERzdFVJRExF?=
 =?utf-8?B?R3A5c1RROHkzK0JtQUdXWGszM1ZGTHdlQStpSmNhZUhaRjU3ZG5vWE1KNU1q?=
 =?utf-8?B?V2Jna3lYbS94LzFGWlBlVGx6aXBaNFA3M3hEd0hQYTFDbEJIOGc0a1lyem9V?=
 =?utf-8?B?RjR1K1Z2NzhYM0FxUU5NdHRGM3hUUHkxazYxTEZ4aFdtNWJvMkg0Q2JiVWdm?=
 =?utf-8?B?ckwzZUhjU1B1MXYvSzNWVFp6dlk3Y0tpTmNuMWtZeWE3TGdHWHVTUE1HSDZj?=
 =?utf-8?B?ajY2WGRsei90VkFmQWYwbm9wbm9xZGgrY2VoREd0MEVUT1dhRGlJNlBudHlv?=
 =?utf-8?B?ZGkzWjQ3RTJjdUpnOXNVdUlibU5xdmhObUN0V3BaTWUxc0RFYVJLaUh1TTN1?=
 =?utf-8?B?bDVoWWx5cUZ6UEhEaEwzb1BXM2JVMHhNMnZKWDBlTWhLSmJSMTcrVjd3SFlx?=
 =?utf-8?B?T0tRVFdWMnFlMjNqYjErZmxKNVN1QmpZdzFReUJhdWhhUE5DNnhsTEVWWFNm?=
 =?utf-8?B?WDdHbEFJcmFwU0lmb3Nmb0h1azNxOFpJUTV3R0s1RXZnSS9MKzdYeEJyUmV5?=
 =?utf-8?B?djBkYWFVZ3pMUEhGZ1lXbzY2S3Uzc0xoT1RjQ3VWTVdQZlc4M0ZEdWNsTXhl?=
 =?utf-8?B?NHo0VnY0aFMzU1l6R3d5OUhvd1p5djdHWFFFZGcydUV4bGpRQnp0NUdnaWo5?=
 =?utf-8?B?WWxnZ1NCZENhazJGcWpZL0k4blJHSlZ1djFwOWR6MUFZUEpqZkxVZ2NGOHpm?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd7559b-939a-4494-1d8c-08dc871df261
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:16:27.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EgFaJaQoqd546PvIArIuJ8uqAjRVe8bguwwBsehUPpLA5djKPcQiRj47MUZzVDbG7OQNRzUPtqxLG6ocD/D1prDZQCTwIPu6t/x3QlCogU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com

Hi Ilpo,

On 6/7/24 5:53 AM, Ilpo Järvinen wrote:
> The CMT selftest instantiates a monitor group to read LLC occupancy.
> Since the test also creates a control group, it is unnecessary to
> create another one for monitoring because control groups already
> provide monitoring too.
> 
> Remove the unnecessary monitor group from the CMT selftest.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> --

"--" -> "---" to prevent snippet below from being included in
changelog.

Reinette

