Return-Path: <linux-kselftest+bounces-11261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7228FD7F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C18B20EDC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDD15ECF1;
	Wed,  5 Jun 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtI8ashJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD229AF;
	Wed,  5 Jun 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621015; cv=fail; b=ewlGQ3dL2JweNDfsMHxkUHJchOoHKYZ8+vjBV3qySvn9xnvCqbzX2yYbUejE/SJMMEskODBGL8ALjIX7x9i4ZKrF/oSCjrkfrD7g8CrUSI7QJXvwIpvIq0Usu96bMzRn8EbDNE8lr2oXcqzxriCtCFX5NjBgXbGhVOCsQplbe+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621015; c=relaxed/simple;
	bh=UL3bgqbWY2Z4NP6UBFYBqlRXUr78XnQXX8FXcKO3fXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MHWCbqQA+hvyl5nPAk5ifPxdvDG5TqNiUjnTDUQSUT34o+iOAvraVNYM2qYLVMghiFm4Tsvr3Mxbgq4W9Maw2K49opJJ+kgV1NQVOkvXXmOecSfoNL+5QgNLsAETUXA4VJoy1d+j3uhAi/yCtfuU3M38BJFTFRzXz1hsGBDk1x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtI8ashJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621014; x=1749157014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UL3bgqbWY2Z4NP6UBFYBqlRXUr78XnQXX8FXcKO3fXM=;
  b=TtI8ashJpW3AZnLWJffmYkesoy2UZbY9nFVtFYEQ8voLNFcR7psx7DTN
   8aK+6b/W8PRrmpLI61SwYvtJRs3uN2oP0ZQ2dSRTw4H1ClM6P8G7qZwlp
   9eEuaJchwvWJ6MA4LMloCFseH7fHmHLynvhB5n68DhcwU3VsOfy7esWFK
   dTW8xRdQsfYMHgOUm+HLB/coV6fsO9ojq6gvh2l7Kq1QvQiqLv49tl5LJ
   x5XTs9GzN2lsmkpMMOd3f/oCW+f8VLXHjn+Y+2s65dPHeAnmiZpQTeRFJ
   rFaFifmonTNLyXNBtPtqqnCaf69LudWTs0H43UImlKjyKeP3V64KUzZAL
   w==;
X-CSE-ConnectionGUID: fRjzdj98QRWhJy41aTYMHA==
X-CSE-MsgGUID: Wub+N46+QtOSQrHGXZICTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14095666"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14095666"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:56:53 -0700
X-CSE-ConnectionGUID: Pm+U6G2JQPW0dtMkVmentg==
X-CSE-MsgGUID: MK90qQyGT7OPwDtqlXyfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37643010"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:56:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:56:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:56:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:56:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIFmmAJ0PUzBlgI/tUHrsq9iKFidzNRNIqAiI072TK7Ifjy2bWDCDrIZCQS/nLY9dELWPwPOx7dJoW4fI7YluzOhusXYGB9lTfaBovZ72FsDRsYp7LZuqgWa95AWggqEEyJiPy6Y0IpNLai8Ya8ZVVLABjRJfCOrmrwEvNFSJAyrKN9kTnpQEtuCgRtEpZ633ixCDIqQ4nskpy1VVqhleDZauHqNuHuR0T3sa8UXakCEOQo0b9pIl2Plj8fZkRKwPqjwYhmsquJnyhYBCIouyuUR4mOzfoq4jJHuJFaPMx4ck/74eGfAh/Kb8asUPs4J0+I/8rigs6/lcg1XLBRsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL3bgqbWY2Z4NP6UBFYBqlRXUr78XnQXX8FXcKO3fXM=;
 b=M/zmF0mn7ZuwjHKWmmyW5L5wY4dD9aGz5zDYZTz2E82ef70zmHFIVa2hI8U+zTlVYW+OBkvrtBl9iQ7eY5YOjpimJyB3jZa7kiPR5OhLeqjx2YWomz50jdErMayIGpvhrsa5xogBh3v/3MDSniQv0TMNhPtzx2hNzxNYCSVi0QcToiV70/ucHmEcw/P1RPLhEoyZ9LJ4WXlLg0qkY3VOFRTGkalHfImAxdWDfypTV4r0Qw0sd4KLQbnJ5Z0WHHSctECvkvtQ0nPovDsBh8qo2TY+lc2lGWGQIVcNjbmctgZQsOeRVLfPmDt+zUCnmxro76dDXaornErdX8rG5ed+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 20:56:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:56:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sagis@google.com" <sagis@google.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>
CC: "vipinsh@google.com" <vipinsh@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Afranji,
 Ryan" <afranji@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "dmatlack@google.com"
	<dmatlack@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "runanwang@google.com"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "pgonda@google.com" <pgonda@google.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Topic: [RFC PATCH v5 00/29] TDX KVM selftests
Thread-Index: AQHaLTxo7g1LHBoyE0m0HNgVI+vn07G6lI+AgAAZvQCAAAF0AIAAAN4AgAAGnACAAAQQAA==
Date: Wed, 5 Jun 2024 20:56:48 +0000
Message-ID: <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
	 <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
	 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
	 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
	 <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
	 <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
In-Reply-To: <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6917:EE_
x-ms-office365-filtering-correlation-id: 781838f5-f09d-4822-8a94-08dc85a204ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QUVJZlVEYUw1OU8ybjNac1ZObG1WUjFJdGZTOEcxVGJPZitxR0tNWHlsa0Mw?=
 =?utf-8?B?UmVEVldTb0wzS0paWlgrR3IrQmpOMXFEMXNNa1dDYzdaaGVITWdDRmpOcnFh?=
 =?utf-8?B?VlFwMU9rNlpyQVhqUzcxODl3LzhkUlluRnY1SGJOVzFGb3BqMWhTd1g2ZGpu?=
 =?utf-8?B?aGxEK1UzRGRISWlXOG9iOWgxR0Nrb3o0QW9QSXFyRXBHMkYrd0g5eWxlSERG?=
 =?utf-8?B?S21qRjlEaHRsdmxPQk0rOEM0RytTR2xCbWgrR2pubW5OWXBIdVc0aUtETXk2?=
 =?utf-8?B?MlQxL09tZmpzSTFETjRJK1RCV2llOXhTd3VLeXZQVGFIMnhSd01iditBNFpJ?=
 =?utf-8?B?T0Rqdm9WL240ZzhGYkJrMHIyS2k4U05Dd2VvdHN0S0ZHb3ZwendiQU9jaVNw?=
 =?utf-8?B?K2lUcFhHUGNhclFsVzA3ZHFkY2JYc0FEejJITGg2OTRFR28wSjdLbCtLdldO?=
 =?utf-8?B?N3NYSU9tSEYwcXFmR2JhRmVPRHlkR3NVVlZKd3huNVkyRlpiR0kzZkRLU3pM?=
 =?utf-8?B?OW5KL3ZDQlB0N09rUHh2SnhzUUQ2UkNNN1ZvWVRKdWpzUlBvM3V3UmpDeExt?=
 =?utf-8?B?ZFhGekMwUm45UzB4RDY5TTlGaE84cjg2Q2Mvai8zV1RVUlhZZHZweGp2WFFs?=
 =?utf-8?B?NEx4RXQ0Ym9LRWtUTjZ4NndscThXTzdvaWcyU20vMC9WZDJ2Mm9aRFR2YkhM?=
 =?utf-8?B?WDNlSjJ2cXVQallDZWRlZEpQZ1M3VmV3Nk1maWpwT0U5ZldsZkJZUVVIbjBP?=
 =?utf-8?B?SjFLK1lnQnhXWUxqVVhCcm9tYjZRZ1R6UG9BUEpLQjlraXBFNzRuamtoN250?=
 =?utf-8?B?ZVBmS21qOTNDYSszMzdGYW9XQ0xTeE1Wc29uUDNwd1pBdDFYZFhDdk80bGpK?=
 =?utf-8?B?YW5EWnhLVElZVmp6K1hlNzdUZUNQMTZ6c1ZEcHBRdU82cExaR2g4NHRwQmhz?=
 =?utf-8?B?SnlkdExJOHFwbnorNWxxTmZMc3dIanpUOE1oSWR4RDFySWZuVG9iKzJVRzZa?=
 =?utf-8?B?cUtaU3V3S25ZengwU0pOL2hvb0t1cmZ3c1o5V2xwdldLaDAyR1ZYWmgxSjkr?=
 =?utf-8?B?QlVrelkyUGlUSG1panprZjRQcU5MRW9uY3pNMVR4U0tMTGUxb3VJb1kyK2Zv?=
 =?utf-8?B?T3FCUVpiQ3gzSU5qVWdkREVqNHRLaVpSYzVPMU9yWm94SU5rTUlGa2E4SU55?=
 =?utf-8?B?RCtoTjVvNnZsUUQ4S3N5MEVMaVAxWDhndW9JeXB5OERGT0QzWi81RjJHTkdq?=
 =?utf-8?B?VmdkTzhFaTZVV3REOFVPcE5RczgrWXc4OTZ0Q1g2aE1sbncxQm01TnlhMGdL?=
 =?utf-8?B?OEFvb1lFTnJtVGpvTFZ4RkRRRFl2ZGhuclFPNFRnc1diaTd0YTcrM3dwQUJr?=
 =?utf-8?B?UEo5TUlZWnlFTzF0UFRtMDlKSUdhNjVYTkQwZ3FsZzk2eHczWVZkTXlxMWk2?=
 =?utf-8?B?YlF3TXkvMUR0SmhNdmw1bnRlNjVCRHdwck1ybjB3ejBMaTlhMzV2Vjc1L2tF?=
 =?utf-8?B?N2VLVDRWMnljRDBmMllKek1CbTVmc1dYMEdheTRXRTAxMm9aekJkVjZzVWto?=
 =?utf-8?B?ekJBMHNEaC9IampqMnZvbzhiRmNpU3FZeTNYbzhiSmRXWjJNdmxqeGxJeU14?=
 =?utf-8?B?UGlERm4ycmxIYWkrM1RKQzFCNEhHeGhYSkZyRU1Rdmp2bkFrdlMrcmd3ZGE4?=
 =?utf-8?B?S0xkdnNFaGVJdnZQenhLck1haDlMTGlqRTRMcmlxOVF4UzZNcnozeC92YWJp?=
 =?utf-8?B?V3o4QU5rclNkb2ZoYWpCeUk3ZDdzQVhZUlkrMTUwL3dvclNYbGZmd2M0NHpl?=
 =?utf-8?Q?r97AyePiZrM+1qQfNOHnhsKVEfgbhiQ2wOKdw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNwWFFHMEE3em1YTHkvMFdlVVdqaWpGc2FsREMzaVkyNzVSVXV2Z0lrZGwz?=
 =?utf-8?B?YjF0SEZzY2JlcDNvRys1SHBva1kzcklrMHVFTXBmeU9RQXkxc1hWaVVpdXJ6?=
 =?utf-8?B?d09GQUNtaDVUc3Yrazdya05GdmZnZkFzR3ExVkFlcHE4WU5FeXgrZVhvdDZ0?=
 =?utf-8?B?NWdxUFYxNWdQcU56Tis3Y2hjZmZ0QTRIeEIyOWo4ZGM4a0hJcGtLcEZYcDNG?=
 =?utf-8?B?cXlWSDZ0Q0hvdnFWTjBmTkR2SUdYditiMWcxUEJaeXlSQzhtMkg1V3poS3Rl?=
 =?utf-8?B?WDhhYjJyaURPT0pkbVZDWkRzTU94QXZhRWh0RURTRVNudndMZ0l1RGVndVJQ?=
 =?utf-8?B?VDFYUnk1cUw2Ri8vNG1hemdTQWlwVjhHYlJRY1RjL0U1MGYvaDZQZGhiZk5h?=
 =?utf-8?B?WVU0WDhudUNCb2N5NmJzelNjSmtHTWVwOGhHT2JvVzN0cGVGUVlSbGVKa0do?=
 =?utf-8?B?dm5ERVVnWEczZlF2ZWNvMVZFVEtYbTdQbUpVVVVoYk5KSkZtdHNlNUNvbnF3?=
 =?utf-8?B?M3RCTGxCY3ZWMjhlZ294My9wUTgwZUVFQWxPMkgyUU1mVzdUUGRyRjhBSFdR?=
 =?utf-8?B?NUFwVzhUSnpvcWZhV2VjQnJET1k3a3BoMFBzZi9ONlh5SFlFVTZ0NUU4MjZo?=
 =?utf-8?B?WTJSRXIvbWRPSllZTnJIQi9qRkJXeGpmUG1WY091Q2ZObEpxV3o4bEk1OXQw?=
 =?utf-8?B?c2hjMWFqZ2JmWVg2YlRVVjJuVTFUVldQVkVlcU1zVmdBdDdCYWMzUG9VMTM5?=
 =?utf-8?B?UDVhYm9neTlHZW9sMUM2TEJKaTVpYWFFbS9kOHNJWGoyayt2MmNRL3NRYmZ5?=
 =?utf-8?B?SW03eEdZZlRyaTFzOGF3UXBSTUxoM1dhYlRaNHdYLzMzanRRREp0dUZHTlJk?=
 =?utf-8?B?QWJUcElZWWxMOC8xa1VlZnF0bHhiV05aekl3ODN4VUdGZUZDVEJMU1RnS3pB?=
 =?utf-8?B?TDlYd0thZjg1am5TcEtGcjQ1VzZ0QXR5dW5GZk4xclU1bjJUeERjYU5RQStS?=
 =?utf-8?B?ai96dWdhRllUbUZ5RnF1SWJkVFdiOEJ4YnEwK0tGKzlWVGkzdkg3d3pSODlW?=
 =?utf-8?B?Mk83c0RrbUxTNnNwUHhlbUZoOHRmY24wNjdGUW5IL2FEWjhnOFlMYlVGa2Nl?=
 =?utf-8?B?WjF1ZUY2NU9WdENEOUY1Sng5QnlZeGpCMTBFU1d2UkhabTZtWWhGelkwQ1dL?=
 =?utf-8?B?Zmk4R1BldWczMHlEK1BjUEhJTXVEY284Um16T3c4ZWNBZ0RyZ2xIV0lYVCtR?=
 =?utf-8?B?Q2Zkb3QzK0M5Ulg3VVR2Q2ZLTEU4dHkyaThyTGRFL3JvSFYyMmVjd1RDZ3BW?=
 =?utf-8?B?eVR4SVZoN2ZweFpBQTdoMjY0MThFRm5BY1AyWjVmbWhjcVpFY1ZMWFdhWUxu?=
 =?utf-8?B?ekt4d2lsbTdTaGVUcTZ4Smd0M1ZpNGd4NXBmRmdFd21FYitZclhUZ0wvVUVN?=
 =?utf-8?B?Y1IyRHJ0dmZ2K2RvbUpZZGRsaDlCL3o4d2p5TXBVWk5vQ1c0TjBxUkdRVzNs?=
 =?utf-8?B?SVpRdHBWKzlaRkN0eUV4bUR2Snh2MzVNYWptOHo0VzY2bXd0QXFiTkswbzZG?=
 =?utf-8?B?V2x4alRsMnR0VmZlV0NYS085bG1NVUVySVlPVy84SDZScE9LL0cvUHJEMGJC?=
 =?utf-8?B?TnFsY3pTTVVlRDI3NnRwRmRYNExWTDdQNEpGRGd5SHgwVmdqdkRBMHNVYVNk?=
 =?utf-8?B?U1RwZ1g5Z0xBVmtZYmRZVFBIM1hVVmE4eU0xZ3VVWkpMTisyaEl5ZXhvY2c2?=
 =?utf-8?B?WFJrRW5JZDYxTEMrVmdSTE43bmV5OVhNSUtWMjFMNWFxcHA5TW4rcGs3L2FS?=
 =?utf-8?B?QkFrZG9nRW1Sc0FpOWNMVDJBbGE1VkRCckJSVVhDWUpaL0h4Ym9YZVJGaVla?=
 =?utf-8?B?ZzY0SEhTMDg4a3NZTWRVVjBuaDZ0bUtLdXgyZEVVcWxveHltQmx4VC9Wd0Vv?=
 =?utf-8?B?VzBzTDA0NXlNK0ljbmc1U2RZQis1eGVLV29lcHlNWStZejcyK1dUSDIzV2U2?=
 =?utf-8?B?NmhWcEtETFIrQ1ZnMzFldzlVcGo3c0dtRE9pS1dhT3RHMUhXOTJGWW9IRlhr?=
 =?utf-8?B?ZVNLNlVBU3NOSTdKUTVmenpYdjc3NDZPcndqUFhIbHY4NHMvcU9xb0NtTlNB?=
 =?utf-8?B?UU1iMERHMnV3OVlnQlB2RnBLSXFjWUg3QkxrdFoxZ1o1RjlJTzlDRktrVnFa?=
 =?utf-8?Q?g7jebIsgJ4HldusH9U4FUOc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD56983C86EA0445804A3EBFEB914289@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781838f5-f09d-4822-8a94-08dc85a204ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 20:56:48.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NniT2Fz9+OEcUmvERq8P2/sV9PdR0Osj6ZTqtd/PgGLRth14bEMWivZs0vEtd7z6i7Z4IlhuwIQzOFMxzaw0PwThWxyvY51FPnu/mdiLtXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA2LTA1IGF0IDE1OjQyIC0wNTAwLCBTYWdpIFNoYWhhciB3cm90ZToNCj4g
PiA+IEhtIHlvdSdyZSByaWdodCwgSSB3YXMgbG9va2luZyBtb3JlIG5hcnJvd2x5IGJlY2F1c2Ug
b2YgdGhlIGt2bS1jb2NvLQ0KPiA+ID4gcXVldWUgY29uZmxpY3RzLCBmb3Igc29tZSBvZiB3aGlj
aCBldmVuIHYxOSBtaWdodCBiZSB0b28gb2xkLiBUaGUgTU1VDQo+ID4gPiBwcmVwIHNlcmllcyB1
c2VzIGEgbXVjaCBtb3JlIHJlY2VudCBrdm0tY29jby1xdWV1ZSBiYXNlbGluZS4NCj4gPiA+IA0K
PiA+ID4gUmljaywgY2FuIHdlIHBvc3QgYSBicmFuY2ggd2l0aCAvZXZlcnl0aGluZy8gb24gdGhp
cyBNTVUgcHJlcCBiYXNlbGluZQ0KPiA+ID4gZm9yIHRoaXMgc2VsZnRlc3QgcmVmcmVzaD8NCj4g
PiANCj4gPiBBY3R1YWxseSBJIHNlZSB0aGUgYnJhbmNoIGJlbG93IGRvZXMgY29udGFpbiBldmVy
eXRoaW5nLCBub3QganVzdCB0aGUNCj4gPiBNTVUgcHJlcCBwYXRjaGVzLiBTYWdpLCBpcyB0aGlz
IGZpbmUgZm9yIGEgYmFzZWxpbmU/DQo+ID4gDQo+IE1heWJlIGZvciBpbnRlcm5hbCBkZXZlbG9w
bWVudCBidXQgSSBkb24ndCB0aGluayBJIGNhbiBwb3N0IGFuDQo+IHVwc3RyZWFtIHBhdGNoc2V0
IGJhc2VkIG9uIGFuIGludGVybmFsIEludGVsIGRldmVsb3BtZW50IGJyYW5jaC4NCj4gRG8geW91
IGtub3cgaWYgdGhlcmUncyBhIHBsYW4gdG8gcG9zdCBhIHBhdGNoIHNlcmllcyBiYXNlZCBvbiB0
aGF0IGJyYW5jaA0KPiBzb29uPw0KDQpXZSBkb24ndCBjdXJyZW50bHkgaGF2ZSBwbGFucyB0byBw
b3N0IGEgd2hvbGUgfjEzMCBwYXRjaCBzZXJpZXMuIEluc3RlYWQgd2UgcGxhbg0KdG8gcG9zdCBz
dWJzZWN0aW9ucyBvdXQgb2YgdGhlIHNlcmllcyBhcyB0aGV5IHNsb3dseSBtb3ZlIGludG8gYSBt
YWludGFpbmVyDQpicmFuY2guDQoNCldlIGFyZSB0cnlpbmcgdG8gdXNlIHRoZSBzZWxmdGVzdHMg
YXMgcGFydCBvZiB0aGUgZGV2ZWxvcG1lbnQgb2YgdGhlIGJhc2UgVERYDQpiYXNlIHNlcmllcy4g
U28gd2UgbmVlZCB0byBiZSBhYmxlIHRvIHJ1biB0aGVtIG9uIGRldmVsb3BtZW50IGJyYW5jaGVz
IHRvIGNhdGNoDQpyZWdyZXNzaW9ucyBhbmQgc3VjaC4gRm9yIHRoaXMgcHVycG9zZSwgd2Ugd291
bGRuJ3QgbmVlZCB1cGRhdGVzIHRvIGJlIHBvc3RlZCB0bw0KdGhlIG1haWxpbmcgbGlzdC4gSXQg
cHJvYmFibHkgbmVlZHMgZWl0aGVyIHNvbWUgc29ydCBvZiBjby1kZXZlbG9wbWVudCwgb3INCm90
aGVyd2lzZSB3ZSB3aWxsIG5lZWQgdG8gbWFpbnRhaW4gYW4gaW50ZXJuYWwgZm9yayBvZiB0aGUg
c2VsZnRlc3RzLg0KDQpXZSBhbHNvIG5lZWQgdG8gYWRkIHNvbWUgc3BlY2lmaWMgdGVzdHMgdGhh
dCBjYW4gY292ZXIgZ2FwcyBpbiBvdXIgY3VycmVudA0KdGVzdGluZy4gUHJvYmFibHkgd2UgY291
bGQgY29udHJpYnV0ZSB0aG9zZSBiYWNrIHRvIHRoZSBzZXJpZXMuDQoNCldoYXQgZG8geW91IHRo
aW5rPw0K

