Return-Path: <linux-kselftest+bounces-38005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A3B12420
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394DD1CE6C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996625179A;
	Fri, 25 Jul 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/BU/u8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE1253B73;
	Fri, 25 Jul 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468644; cv=fail; b=LBh0/0uTTIiI9GA36DLtNbhUpU4TqWANKTKpxI6qnZp9UOGMTHbXyXsg+SWGF3MX9SQPdRSe7qY34jxQzi65Xrdp4ac8ZhQq8RY7S0KGbdfgpXX4ZiOFOegXn3ehfYuk5HalmZ06xdSkEMZ/PU+Ta09ylg/PA8Sq1kJTMkFNHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468644; c=relaxed/simple;
	bh=tVrkb1A9uKTjaBlse341Z8zvXyGCsLRctRjB5xvTyDY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=siaINiwWxZwHNazc3/oJTliOuzsJzFwVW5O15XAlnp9G0Xdb0z9BhyZjyrh1/Vf+N5Pt4J+8RhuEKJSubMKrtJXaLgbiWgtGcezvh21JxqOxuKgwkNjlA4ZTOoqxmunZmd0B3fzrfepLKbIYn/GfD7atKczBNU2RlLLMmdtPHEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/BU/u8p; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753468643; x=1785004643;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tVrkb1A9uKTjaBlse341Z8zvXyGCsLRctRjB5xvTyDY=;
  b=g/BU/u8pfHu31ghhTluQqSsvEYMGvHHbFBc6gwG8+mnphQnfMKOQvHK6
   HCOzHr7PYyYArbUAtwOxiVDpubEJHuvurbSBCrdhfvZp0D4sX8Q24Zv9K
   SVP+xRQHh18b7qLEuXRe47Fd0jd2G98tSQ5BMfqt3kr9qAxnnzrgbdXCQ
   aCnMuDfdKh2IOgxWFdrKTcG8ePlG+U3z4mWrPSohKgOXSKQr/oJa/eRjX
   oEK1k9ZHoG9c3REdPp/fVrihZpHr9Hk8EQ633Ls0QssWzxB65U7j3Y3oF
   OK7ayv+lkPVQdU18eXVjN7PCQ7nASEYEs+kJp0DRDqsa8IZhUpI/UHK4K
   w==;
X-CSE-ConnectionGUID: x82lhZBHQJu54a5/rju2VQ==
X-CSE-MsgGUID: bHS08ilrRPeJsmOTifgwOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="81252676"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81252676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:37:19 -0700
X-CSE-ConnectionGUID: Mhg/IbPCRDWSkzqM0B3U0A==
X-CSE-MsgGUID: E1Q5LNdgSS2tTAaayLtDOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166542345"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:37:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 11:37:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 11:37:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.77)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 11:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyKmtpbRxEUVpbJo8OSo9j7GBiRP19AqPLPSc3ZFPvrKyiGwvpGJh1+UemGok3iwfLDpTBzmY96fIFUN25/Y0cO6j6/JOrajf7Py8ZBSAZrOWGvPSu5pVGFkm5j4Z6ZWbvrbEi2mcxyBkZ+XjECFHRtCXJA8tAvuWkjlXXDmqFDfR2gkenuiCqPKg+DLpP7BqlLGTOWg5AJWrRA/VX/98tFgYsqOtbZRbKL6wUoM5pDvEYPNLIIRqQDWJaTUmSQmy1Cj2IUn0S9JjYXEQuDh2METJ8l+7Q0nmJu1SehygXODDikyeATkrU/vYMXirGZW1+34MM6Wo6ze0n+cXVdGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGUanCUfT5KxXGAfSd1UDUCwpYn0wpG9EPjObwG3TYc=;
 b=MHDJFkocmJdwJJkSQbVnxFOGCRKGkNg6EWeoajR6DOVJ1JRbNPzb8PMLJ9opsJsmBkGh7ePY4TCnfFZalz1w6oHAi+29LyCVLehAq3/LzIKmkGYNBw7JqCDUJjZ1QPOl+mRW9agEdu0KWARK5uDWiACYFddr6YwsoQMz01L3FAg3ATBFxCgX3qTtSWH0EfJ+HoaHZmO394NuOnyB+zG/NuWj8kZOT+fkWv7Yyf305Sbuyz6u+jKs+gssG+htQj8ZcKYaw+1Tm7aLQ8ivZduGCDhAYGRaaiOTs1vWzCUYKAQJgZ6T5vaBfYh27xZkBG5PLTEtHRitRITqpRSMgtA2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:37:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 18:37:15 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 11:37:13 -0700
To: Jakub Kicinski <kuba@kernel.org>, <dan.j.williams@intel.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <6883ced97d944_134cc7100fa@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250725102019.7add0be0@kernel.org>
References: <20250725080023.6425488c@kernel.org>
 <6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
 <20250725102019.7add0be0@kernel.org>
Subject: Re: Crediting test authors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: e1111fc5-a469-44c4-a84f-08ddcbaa4734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0FjVG5TTHpBSEl5RmJtNWwxTDFoblRpL2lla3kvbUNJdTBMa3BCOEdVVXM3?=
 =?utf-8?B?UW90OGxVWks2ckF3K3hmbmJ1UjVRNXlFQnRmOS9keHNNYlBCanlMTnVDWUx2?=
 =?utf-8?B?RWNYYnAyM1Z4b0lpQ2JwT1VRMWwrUmVrTjB4aUlPbmpBYWFBQ21ydFFyNDZQ?=
 =?utf-8?B?RG5hemdLakVKaUNiZ0tJRFRzT3ovSUNncWhUZ0k5cHRPbC9XalBwNWNYR2Zs?=
 =?utf-8?B?STl0TmI1bGxlSXFzWU50VXNHeDF6OXN0RGlUNjVxQ0U5VVZhaEhKQkwvS1Bp?=
 =?utf-8?B?WXErM2hPdGJ2MEd1NG55N2hKbFU4b2xmejhWN0drTW9keVNiZVFoOC8zcG5i?=
 =?utf-8?B?TW92UkFRV0ZSdXplZ2trSzN3OWxMZXRzM1VmSjY4RjhyQnkvdGltUmUrNW8r?=
 =?utf-8?B?TTRJS0hrWGRBaUd6QmhRZ1pWZGpvTForOU9HRi90cy9FeVJzRHFUYy8yZXk4?=
 =?utf-8?B?S1Zlemx5dTkxTHhIcUJjZmJzano5V1hIdnlleUI5bm1JVWd2NlZTZTY5RTAw?=
 =?utf-8?B?cFhUNXRPaHpPZDNOQk1pblcwRG1Zb1FqQmdRY2swRUZMVDZuK09yUlIwb3hj?=
 =?utf-8?B?dFZ5ZzEwMHB2WnR0UFBhRVl4ZHVoT25lR0hSMW9pd1RUM0NoMjFpRVBsS2xq?=
 =?utf-8?B?UU5Danh0YlROODd6K1BIa2E3RkxmK1BhL01qRGdkbG9VR0pNdEFVLzZiZzRG?=
 =?utf-8?B?c2MzV1k0K3VrNURCSStEZi9CYkViWlNYaHVVYnFNekVWUGViT2V0YTd4Qm5V?=
 =?utf-8?B?UjB1b0ZGSnJNbVFOLzM0aEl1bUg0ZDZJc0NVWFM0Q1hTMjdBcDlFTXl6cm83?=
 =?utf-8?B?Ti9wd2N4c0VvUXRIT0xjeERJdWZKemg2cWNIZG9qeFdTcXpyKzlzWm5ZRjdr?=
 =?utf-8?B?SElEOHJNTFNTODg3QlBiQTlLLzJQVFh6MTc4WVBFT2hRWlNGaHRGT2hLVXVK?=
 =?utf-8?B?VGkrM2MzYjVHWVl3N3VCZmFBRnhZS2xxbmUxK0VKa2VERWs2OWVqU2pWVy9Y?=
 =?utf-8?B?c05HMmVXK2RMYXFrNkxWWk83SXBaKzVCSlJVcDB4MGZYVWdEYUQ0U282WTJB?=
 =?utf-8?B?Z0tJZzV0ZndldXArUVErZjdBcmFtcTNTbTlUeGgrdTA2RE5rUzVuNUpxQnZi?=
 =?utf-8?B?Mkh2YncxOVE1TFdzdUttdnVQNVhMZE8xWlJpaXZaRGE3Rk8xYm1ZbzczdXYv?=
 =?utf-8?B?S3c4aUdwVWVQdW0vNWtOZGhjdHd0dEk2YnZkWmJwZ0RYYjRiaWlPNi96WHcv?=
 =?utf-8?B?WUxXV0hHQU00dDdrS1NhOWtyWkM5Sjd2WEdHNUV3MUpxNkU5Mk1yalF6OEJj?=
 =?utf-8?B?dHhrc0I2TWtPWHhjQXQ0dTQ3WnNjUmwySGlrNVk2WStXUVYzaVhPWUNwS1NB?=
 =?utf-8?B?TDQwMnFmTXNuTXVtUHVXUzJhZU9wa1owTnNWcExYVXNMSFlnTlRZRzROOG5q?=
 =?utf-8?B?UTFlSVh3WTNlenBWYXNDMGh5N3FtSkp6aThNOVRBS0E2bTdxV1BuTjZKR21Y?=
 =?utf-8?B?aEtxbzZFU3dRN21SY3V6eTc2SEJvRG9yRmw0ZHpQZmliWnZGSS9XYkUwOS9v?=
 =?utf-8?B?UjJoRVdmOHVEdDIyZWRIdmh3QVgraW9tUlRqZnV4T2hhcnRRMVRFZ0s0aWZH?=
 =?utf-8?B?VFcwdGlDU2VBY3JqZTh2WUdjeFJGVjRUMTRZT00xdkVWMGZsbnlObkNjc0Iy?=
 =?utf-8?B?b2NuUDgzVmtaNWVtd0JlMHl2ZHMyZHFnWFVqNWduUE5taDhYcE1TM0V3L1p2?=
 =?utf-8?B?QW5JendzU2laMjlDeWVPcEN1UVc4R0FqWUMxTUVnYkhQampuZ3dwR2J2eWpS?=
 =?utf-8?B?aW1YUEsxQWY1d0tkL0lvMFl3bEJNYnZPWWNMTTJFM1ZvSkMrcVVUd1NaVWhW?=
 =?utf-8?B?VTJnT3RkZ1I5ZFFqK1RmbTRRL210SFloZGZ4VnJPa2RmRjRMdkNHVHI1ajVm?=
 =?utf-8?Q?e6Ed6KziP9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpYdTE2N0VKVzQ0YVlpSWJjWlROdGhHcG9ZMDBGODZPU0R4WkYzUkxFdnlm?=
 =?utf-8?B?OUYwbTJ4TTVlcElDU2ZHMmVqZjkrQnQ5Yk1oOE1Gb0lBNlk1VEdYcllYUTI5?=
 =?utf-8?B?UHRhNzNyV0N5VW90WVllLzRlUlRUd2JKd3U3UU9tVmw3dU90V0p0TjJKNnM5?=
 =?utf-8?B?UE0xYlZTZjFoZGZwZnQwamZrTStPd0xldFhUZDlwemdSZmxCaTh1S0JPa1Br?=
 =?utf-8?B?enJXVUJ6VHBSbjVidks0bTFrR1IyaEJPa0tCenM3SDUzZ01kMjRBTVJxYlNU?=
 =?utf-8?B?ejFrZFlJOHlmRHNONC9VS3lQV0VuSU9Na1VUc2FNM3JWT1ozR3BMUnR4Qm9m?=
 =?utf-8?B?V0o1aFBORzBURC9QNndaL05vaExtNGtUUGNaNUFwdHFLeXRDUEFZcTA4Mlhh?=
 =?utf-8?B?Q1AxUjJ3Rmg0bFVTdkNCU1ZpYk1PeHVkZyt4ZncxZ0NiS0RRd0VKRGh2anZH?=
 =?utf-8?B?Z2RGZ1ZrQWVnbHdjM25vZlp4TE9HeWpoNDhLOUxlTlZBcndNMmxOcEZnTEQ5?=
 =?utf-8?B?STZMZjVSbjgrU0V5endZcWNVc1FEeEJPMEs1RUN0dWRzNlJzWFZ3dGRSWTcz?=
 =?utf-8?B?TEV6cnViZjIraTRKSTFjc1Q3dnRROWV5VjF1UkVhSVNEdkVFWU9GR2JXdmdE?=
 =?utf-8?B?SnNtbHNCTDVaM1JVa2I1MnplWGFWeHBUeHk0Nkdjd2I4a25mU3FPSnprK01Z?=
 =?utf-8?B?MzFlMlI0bDdxTW4zTnZPaHdKRmFRMFArVjZZbFpjT0hNc2FkQ0JQcFZqS2Ry?=
 =?utf-8?B?d3QrTVUrQUxRbjc5bXJZQlZyUXRCViswQkRqcFpIdnowUml5TUJYUjY1dVFn?=
 =?utf-8?B?ZmF6Yk15M2xXdktYYjRSMzhJeUdVS2lINGUyZDJkUnNlUUFTWVZZVnpZbHpW?=
 =?utf-8?B?aU5rSVpJWXA0dVM4SVl5bS9IeW9SSCtWbVhuQzVwNUFjcURHUDNlV1o4RmN5?=
 =?utf-8?B?eXpuRGhhS2xKWHUrQ3hqMC9KVExkbkd4L3F1b0NQUUFVNjBLcEZKYnlHK2gv?=
 =?utf-8?B?MXdQTC9YT0pFMXZjRXh2V1FFRWdoODlyUU4zeWVKN3BpM2VveDNlR0VhSFBR?=
 =?utf-8?B?aE1JY3BMaUNpY0FvZDh0dVNWSmdJd2t1cUZNWExqQzNvSXZndDBOdkVrZzda?=
 =?utf-8?B?cDhDbnd5NlhQY2pOeitTMkRrNnJlbU5oeFp1ZDFYM00zaDhCSnhQZk9tcC9B?=
 =?utf-8?B?SVVTRFNXbmVOOTh1WE8rNmtIZ0NrRXF2TkJNSTl1ZjdaazNlMjRvTWR5dU93?=
 =?utf-8?B?d0tnOXVzQ1ZHdHFPTnZNOG96bks3N0JlSHR2Zm1oN3VyWUJkcGVaU2lIWlRr?=
 =?utf-8?B?R3VPcm9LWUZRUDhOUnpiQ09NdU9LMFljbDgzYkx4TG9QekFPak0ycmRPKzB6?=
 =?utf-8?B?MlBZb0pZRWgxbzl4OGZ5cEhiMSt5aXNCWWxuQmZzdDZDRStNdUFpYWVRWjFk?=
 =?utf-8?B?WU9EVXMrTTZaVjEraGxrS0VOWGNRUkN5ZWRoWm8yQ3dPcmtPNW9SdWF4V0Yx?=
 =?utf-8?B?SUNTMXhJT1BaeHFXd0JCSmt0akRmNnAzZGh6RlBXWTJWZm5IdEVvOWlCWlFN?=
 =?utf-8?B?cHpqSDNwbk9GOG01U1dqZWkxUGtwT3dDSUtlZjNTNFNWZ01XM1BqZDArMDJr?=
 =?utf-8?B?MlZ0RE1ZTGJ4U3FVOENsYThxcW9CZ05jMGlqa3pkam44UEJJQUE4LzA3YWFM?=
 =?utf-8?B?bUVCV3dGZ0ZTQzExSTRKMUJyVk9QWWJHU1owQWFHYkVKWW1FdTU5dEw2WUZZ?=
 =?utf-8?B?MkM1ZDZtYUhlWXRNa1JKbEpWRGJ3ZmZEeTFuQmd4REMzanRkL2UrZnFlUUNi?=
 =?utf-8?B?ZmRiaGw2RlhoRHYzdGMyTmo1blNLa3hPS2N4M2hEdUlaeDljV3ZReTg3Tloy?=
 =?utf-8?B?VTBQQUZlcnY4bXZJS08yRkh3TFpOb1RUSHYxcEVqUTF5TU1YZmRtTmJJOXRR?=
 =?utf-8?B?bkhiRFdUK3VwTW9FT2JnVW4zWHZmelovaXhISXVLQm1PVlk4TDJ0TGE2cTk2?=
 =?utf-8?B?b3hHQTJFdmc4QW01YkVnV096Vk15eUpUUDR5aXNBSGorL0pYdG9IMTNLVkdY?=
 =?utf-8?B?SmZiT2lLZlVwTmR6MklOUjJLV2Q2MjgzNW9qaVVYUzBrd21qcE5BMFpZbW1X?=
 =?utf-8?B?VktXdkdnTHJSSVJqaW1hNHVIU1k3eHRPRVhtc3FSNFZGb1YxYjROdWl0REFM?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1111fc5-a469-44c4-a84f-08ddcbaa4734
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:37:15.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g85xF7eHsXjq6pnSHixzW0jEZnaGBlsQuDufSUR7QAiIBw09vf6BI+Sia6GKiqzv09NDGA0/Ob5VZkZiIzUG76SHfC0hnKftBeJZofDiDtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 09:38:28 -0700 dan.j.williams@intel.com wrote:
> > Jakub Kicinski wrote:
> > > Hi!
> > > 
> > > Does anyone have ideas about crediting test authors or tests for bugs
> > > discovered?  We increasingly see situations where someone adds a test
> > > then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.
> > > 
> > > Using reported-by doesn't feel right. But credit should go to the
> > > person who wrote the test. Is anyone else having this dilemma?  
> > 
> > Is that not a "credit in the changelog" situation?
> > 
> > "Big thanks to DeveloperX for their recent TestY added with CommitZ for
> >  catching this case."
> 
> That's what we do usually, but I'm a strong believer in (LWN) statistics
> to help people justify the work they do upstream. Feels even more
> important for testing than feature development in a way.
> 
> So a tag would be ideal. But it's a hard nut to crack. Best I can come
> up with would be:
> 
> Reproducer: test.case.path # 001122aabb (optimal) commit of the test case
> 
> ? Could potentially be useful for backporters?

That's true, more than a few times I have had distro folks reach out to
ask "how do I verify this backport" and end up manually pointing to the
new unit test that backstops a fix.

Although, from that tag I would not know where to get the commit. Maybe:

Test: <git url>

...as a new Link: type?

> > Reported-by: Some CI Bot
> 
> I guess we'd need something like:
> 
> Reported-by: subsystem CI # Person Who <developed@the.test> ?

That looks like a useful convention so that the statistics gathering
script does not need to walk URLs to get author data.

Also:

Tested-by: validation person # test author

...might be another convention, because the validator likely has
interest in getting Cc'd on backports, while the tool author likely
wants the credit but not all the notifications on what happens with
fixes.

