Return-Path: <linux-kselftest+bounces-9671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC718BF406
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456E4285F79
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436979EA;
	Wed,  8 May 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJVHNZPz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA88F5B;
	Wed,  8 May 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131303; cv=fail; b=j0hvER+3luXHohmsgtKWWIQOHKLAFbNIVEh8GOwa1sHLmgvo+2Y0H9jsrhz+lu8jJRLjU0GXHlonUEasgeVxquUy969MhDt3zzlcbiKaaXe46rfPhgGk7fU5L6lDda2k/tGYOeYtC6Q2CkocwTn1pMJj7tn8V4FhfQcv3enqbLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131303; c=relaxed/simple;
	bh=kcSndTHctfGTASJytAoNSqzUZiEPiw6dQUQCBfoCfO8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USALAFvuwiZBs2vdiD4Z91aHSlmqu+RxvRepiZHuitBsieVWwDLbxXW2xO/OlAp3DLEnbqGlUbaLg2lQDyB53jN6WXt0Yn266qIIVTLd6hD7Rbt84ZvfTOcXPFhB95bF/FxqCUpR/t2VWJT9T2/WWfb0/beDPqyhsGRKdxOdKvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJVHNZPz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715131302; x=1746667302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kcSndTHctfGTASJytAoNSqzUZiEPiw6dQUQCBfoCfO8=;
  b=cJVHNZPz5NTUpOyn8rCoJFpNciBHsG2HwPhiHhl5p8h6jXiCnpHsRR9M
   K72r3jNal3FXT2m7C0YAsnzqoV1h4PJSKC0TvNZFHmKPo8aEmQd1XOyRy
   4EUcXES4EagTSvaF6POoI47Asy2LhgiQLIm8xpsG+RgX/C4/QE2gxrbq+
   pAPPpCqRj8ye8osUVbbceJd2i87TEMWDsJOKToSvYlK9WNoXsJaCX6J//
   u9YMzV5gRow+qVl+0u+Kf4NO4AeMWFmmm6HSGhEYB8SARol3pLErWeI5N
   dO6kYkHZnnRrwkV7XxyKhyUmpd56+VdG2mgiqJMwgRgPMIb+dLWcnhVWZ
   Q==;
X-CSE-ConnectionGUID: ups2tgYfTaex9PF3flOw9g==
X-CSE-MsgGUID: OjqKayfQSeerBS7gksr7pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33475189"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33475189"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 18:21:41 -0700
X-CSE-ConnectionGUID: DW9B2mLoTjel5gWIYt/urQ==
X-CSE-MsgGUID: +EoonF9FS0WGtmnbIoAKgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33541863"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 18:21:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 18:21:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 18:21:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 18:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQbbxIGYqjs5T0v18oTgw7ZyTled1QLAQ1rcRlpdqkSurx3aGhKYNJl0CTVpWZExdCJVbds7/f0FwqIrOm3iwQFiO8a0reV3PvFQcY0W0pxGnoR1qWEHCJJzxhEPQ+PMB9zXQMpjUFPXqLaQ+PAV/84YVg1RDEi5V4nEfBrI1i3Wg1ShVjXsq4iIKMd/X6iNOYYjiByBqi1ZQYH8vk+zNe5Wwu4Dm+zoHPToeEvfy9nKuH6sikqttqIO6/n7dymRLO2CwTuTfcNnPO7VAuHGdkBRHqoGKdJAch1YMB3ijn0Bsao3zFMsEusKILNfIrXZ73gdF6uRYVoiPM9fWGDEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnQwunx3XnjeT3f2+90hqEtqdCzHoTh+xPOm2lA6FEE=;
 b=nnfeXdEsTDjnaNs+AmNEXQvQG4dj47uzK9TPIRv4f02V8V8FUxaQ/5sbcg2HNYCWWwzkD1sXokqM9crenJ9giYzkPEc2oevaFL1iEbJdp18yfnI+gSMKPJkDJE1QFeLn1e78tocA2Ix+rm5at/ah5lMctSFum4J5sj8ur7huTEYsDmZH53ONKVihaj7l13EU0v8ykfRI8bzcrShztbkYaX/Yy8KAlhqqj3t76W6lXMGKfOkYgMK44fOA0MnUhK1XoIh8OudTteONTTV4DXkddWE/xQI9QMbMQcjQYxNQsFptv9ZjlEXqWfJHvJoVqrTVMLt+yU84R6A+zA2if+vQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 8 May
 2024 01:21:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Wed, 8 May 2024
 01:21:38 +0000
Message-ID: <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com>
Date: Tue, 7 May 2024 18:21:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503234051.21217-1-jhubbard@nvidia.com>
 <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
 <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9953247e-9495-466d-29ac-08dc6efd3571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFNEMW5hb2tZNHlqUUEydWlLSmZkRXBWRkdDRVpRQzRCM3RIWGhzdUcyRDU0?=
 =?utf-8?B?VUYvTklHckJOVWFwM0dyTmx1YTNHTkhZQjROdGg0aldpZE9DQUlqeE1CbDRs?=
 =?utf-8?B?ZFNTT1B2dzZLeUIxK2xBTHhka2VDOFNPbElLYlNybzA4RzBLbVBQT2thVi9I?=
 =?utf-8?B?NGx2T2V1OG1Iam5iODN4V2w4NlVlNUVsQ2pnNHhQWWhmZzZocnF3NXpXb0ZY?=
 =?utf-8?B?VUltYUtJOGFLbzRsMWx6dW56bnBOb0xTcVlCc1BINTBqL09TTDB4dHRWV2xj?=
 =?utf-8?B?eXM3RHBwUGl3VlpnOFdSN2RscXZpMFdvSFk2WEtrSVZhZXFSb2tXTWdsYVNk?=
 =?utf-8?B?MktyS01jR1JtVktoNmZSSGR0aFE4MFdRV1BpcGZzclBtL252NjBvTVZjb2cr?=
 =?utf-8?B?dDMxWm9JOWlTK3M4dS9GYmJmdlJhazgvVEJlL2MydGRhQ3pyWE94akoxaW9F?=
 =?utf-8?B?aXRvSXVmNkpzTHYvTU5TcHZGTHYwSnVhcnVHR3RLblB5bGFFcVpNZW9XNGRU?=
 =?utf-8?B?NUhrdUZkeVdEZzMvRzZGenoxWkxwUWdjcWxHbkkrUDRRSkgyYjRSL2Z6a1NK?=
 =?utf-8?B?bjY3R0FMSm5Nb0dqSEQxWllUT0JiWmJDRzdnTk9Ja1pHQlArWkliUkswMk40?=
 =?utf-8?B?Tk5QOWhKcFpHcVFJSllTUXVubEVCcWNMVFlqVUl3VWdoMEllaWdSaW1tZVZX?=
 =?utf-8?B?M3IyMFZaWFk0OXZZV1Zid29LQUlzZFJ2QmJ6c01jWGpDcDZIZmJxWmY3QU9l?=
 =?utf-8?B?b0JweVdMUmNKZW1vdFdOMHRKZUlNLzdPNHhVZGRjK0g2VTFlMlVQdG9NMTFX?=
 =?utf-8?B?ZDM0NHlCZFVQSlZ6dWM1QzUwamRkNW90L2d6TEtTUWJSVHQ1NjVPdFNtS1VZ?=
 =?utf-8?B?Yk9aUkFDaW9RbVY0eGdOdVE2THFyd2pZWlBXbXZ2UFBaZ3QzUGk3YmRoTjVO?=
 =?utf-8?B?bVpldlc4T2JSVDFxMHZBQ0EyT2V2YUxRV1hyMzdoN0VZTTY5cjZKU0pwSVZQ?=
 =?utf-8?B?V3R0VjkzemVwM2N5eUZHRVhYL0l1V2V5SHg3MzR2S1RKUG9TYUxuRkhBK3Bm?=
 =?utf-8?B?T3E0b251UGRFUWpCYXZQdVJMWVdldXgrenl3RnMyNWQzVklKb0xYZFVSU0xN?=
 =?utf-8?B?Q0xCVU5EaW1BQ1IzNlFWT3JWR0pGUmlCcUVZTC8rbFVLdUkvYlVrOFNNbm11?=
 =?utf-8?B?cUFuMC9aaVJVTFQ0YVRsVndoanNyYkdhWURSdlJ4N1o2V1RhK1I0THJUb0JO?=
 =?utf-8?B?OEEwaUVZZmxvV2M4QU1oL05LVlZEc3lybGI4ZjlnUk94SkZ3N0dQak43Tkw4?=
 =?utf-8?B?Y3ZRaURwNE56RHBabWJoYTRJTWhKSVZ2VTVYcG5LdWtDZk5TdStJcDBLRWxJ?=
 =?utf-8?B?KzVrTjh1Zzg3aGpveU9saGYxV2JFYlFlSGZ2VFVqdEl0Y0diVy85SDM1UHVV?=
 =?utf-8?B?MDFMZU04WURsdWxrVE1zbk9PNGZZcTVDMytObDU2UkFTa0RsbGxUbmFXSGtx?=
 =?utf-8?B?WVFMU0hVQUZYeU04K2J2TnNyb1Fpa1UyblZUUjQyNkNHUituNThQS3BIZGhk?=
 =?utf-8?B?TkoyTUdZVUZwczJ0UjMwOC8rQ1QxWVFNZnIyaERKUDdoR0pYYUpVeE8wbzVy?=
 =?utf-8?B?L1NsMVBMQ2lCV1FJWm9lU3NiV201VTRGYlQ2OHI2TVpFQnRUVlpVUVJTdzdD?=
 =?utf-8?B?MWhWUkhRYURtSG9FelBaQkNmb3QxL1htY0cwbVh6Nkx6cWFrTGVuRkpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhWVFJKSkNqVE12WkZzenpVZURwN3g1emdLZ2ZqL2l4Y2wzcjJpaXhmRGdP?=
 =?utf-8?B?THJ2OHVnZTVqMGlPVjlua090T2VDRXBxVHlWWnZIK08rYmp2QitxaDFqMW9z?=
 =?utf-8?B?VEFrOEprVnFvZEx5SzhNMUxKKzExak5hclA1RmNnc05xSlVOb282MU11R2Fa?=
 =?utf-8?B?SnJkNHZVVGtsTGRVeCtsL2hicnhhM08xeUVLUG1DSWpOUElaMkZzVjRQMHhE?=
 =?utf-8?B?WmZTQm4xWWt5NVhUL0REYzZLalQ5TXRiTmR5SXBRaWlVZTh1ZUZoTlZaZHdQ?=
 =?utf-8?B?NmF3VDRLdVp2NWNJb1g0dEFGMkxoWlJPU3hOa3hxNDVEbGVvNFJkcGJadk5Z?=
 =?utf-8?B?MFNESXN5ZldNQ0N1Sm01VkM1YjNIT3JiSnhLS2krNEkzV2pqc3AydkJqc25K?=
 =?utf-8?B?V0M4SGJpZjRZNURKM2FjdTNiMlI3RXgxQjBXNGQrMkFBNW0ydlQ3eVo0K0Jr?=
 =?utf-8?B?Wkt0d2lIVTJ1WUhEZGhNMWdpQTlhSWtaMFpGblpyaXR3V2lsczJQODkwa05E?=
 =?utf-8?B?THJyV1VCYjFETEkwaldHYUNZc1I1anhUaTVPckFoeHFrbDBwaWZWeEF0d0xw?=
 =?utf-8?B?NVc0NmpwRkVkeGoxSmdFam9venY0NTNPWXowSnRrZFNXTmI4NzVwT0lCclE5?=
 =?utf-8?B?dEgyWXkycUNvcnpWM0IwclRGY1lZbmhUSDVFbHdMekpPNElzaXVCY21NTlA4?=
 =?utf-8?B?RnhTRVFaRVF4TWpwRmFJNFZGTWwyUU93bW85MHU2NmdQa1ZqWFJydkRFZERk?=
 =?utf-8?B?ellnekY0dmV4WUIxeDdWdFhrYkppVVl1VUllUGtNdjBlamllL3kxMmpwTW5K?=
 =?utf-8?B?UmxmcjQrdW9RSTZPRTBxcEhOayt1MXNvWnZYOFoyemp5T21XYmtOR01yOFp2?=
 =?utf-8?B?L3JlQUhTUzBnd0UxVmZLSythK3NQbyt6anRCOWtnakVGTS80Qjc5YldLRlp4?=
 =?utf-8?B?cVdJbnc2U3IzbTNuNnlRcEVKcFZ0eWZKUzZ6SWo2Q3ErcHh0NmxiVHdKd1RM?=
 =?utf-8?B?VENrSUw5NE04ZE9Jb1liWVpyZUtGVFNOWkNQR3IrY2xRUmRheWhCTkFzZUtC?=
 =?utf-8?B?RVM0NlNtd0RxQXg3Mmk4SWhxZ2ZYbnJsYVdab2IrTC9odjMzVjZpOVdYa21Y?=
 =?utf-8?B?MnVKcXZFTGRyZ2ZkV21EcmxxOENvdmY2RTN1TlgwenpkNlNxY1JOUlpNWHZl?=
 =?utf-8?B?M25TMkQ1V2p5R09UeUQremNTUlVBQWs4S2RCQlE1RUI0TWVkQU10UG9vZm1U?=
 =?utf-8?B?SFVTVElLdDhucjNVNGpyZEtsMk5tbkJoT1R0NlpHdE1rNVNpbmNvRFlwczd0?=
 =?utf-8?B?RFk4SlR1bUJvNWJVMmU1TVpnQ2FhNWtFQ1ZEcW1MMHgzdGdHeFgzdGtEQW42?=
 =?utf-8?B?ZkhYcGhjTE44dmhVY2l1ZmtWVC9MM2lOWGVkb0tIWTUvUkh4K3pLWXRqUVpr?=
 =?utf-8?B?RFY3SW1pa3MzR3JvMXJJUnVUNWEwbWgxVGVGWSsxS3QvUjhVa0RjWmlNb00z?=
 =?utf-8?B?dlkvSjg2d2dsSVljQXJPOWhXbUxsT1FOVXVXWW1HNUNtcHhBR0taeVJxRC9Z?=
 =?utf-8?B?d0ZYa1hOcGUvc2E1R1NLdytpNnVYeVorNTFVZVBWcU9sdEVFT0czUnlMTlE4?=
 =?utf-8?B?dE5uY3FmS0ExckhjTjJPNDgwZWUrN0NmUjBHb1pPdVRHdDV2czlUQnc1OWZN?=
 =?utf-8?B?ajY2WnJLckZEYzBJWHQwWGNJMzJHQk5zSFhNZzFzN0lKek9YeWh4NmJ2OXVo?=
 =?utf-8?B?VmJ5bFA4WVI5VXRNNmhmSnJnNW9JQWpSK1RpaGJVcktGRDYxV1F5RnJneFNW?=
 =?utf-8?B?T1NRUDdETWx3b0dDMjdGVFpZU1lPWU03YWk3SlovYXlNNHhzMWJMYm1GRjRx?=
 =?utf-8?B?SUhxakRPWllmSGNmMHBlckl1Q2hIM0dhK3ZvV2pxT242c0wwcjVGaEFJanlM?=
 =?utf-8?B?ckRib1hjeXA4N1NFRGdvQ2NGYnRzS0xwZVJjMWc4aVcydEplK242UXJRQTRF?=
 =?utf-8?B?TW9rczlrNTg2eUFCREtHazI1NS9BUlV3bkhXbjlCcTA2d1JxSWdvMlM3a1Bs?=
 =?utf-8?B?QmFxSlpHdSttd2hMYkhiekFYTHpTa3UvZkxkYkxjUThMUlQwdFIzVE00dzVs?=
 =?utf-8?B?MjBMRzF3UWNpUUdHdzBZaVlLRkRkTzVrd3RIYVZ4b3dEUmZLcG1SWmltN2ty?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9953247e-9495-466d-29ac-08dc6efd3571
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:21:38.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsMQ+C1iYeGu+de2t2GIumaVOtHgs3G/agZ6cAYO+SUoevE0nVs4lLucVDU67cKlCs6OVbyUoK48OCwD4i/00SP7V9jhXJYc4Cy/mwGZB9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

Hi John,

On 5/7/2024 6:16 PM, John Hubbard wrote:
> On 5/7/24 3:30 PM, Reinette Chatre wrote:
> ...
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>> index a81f91222a89..af33abd1cca7 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -29,22 +29,22 @@ static int cmt_setup(const struct resctrl_test *test,
>>>       return 0;
>>>   }
>>>   -static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>>> -                 unsigned long cache_span, unsigned long max_diff,
>>> -                 unsigned long max_diff_percent, unsigned long num_of_runs,
>>> +static int show_results_info(long sum_llc_val, int no_of_bits,
>>> +                 long cache_span, long max_diff,
>>> +                 long max_diff_percent, long num_of_runs,
>>>                    bool platform)
>>>   {
>>> -    unsigned long avg_llc_val = 0;
>>> +    long avg_llc_val = 0;
>>>       float diff_percent;
>>>       long avg_diff = 0;
>>>       int ret;
>>>         avg_llc_val = sum_llc_val / num_of_runs;
>>> -    avg_diff = (long)abs(cache_span - avg_llc_val);
>>> +    avg_diff = labs(cache_span - avg_llc_val);
>>>       diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>>>         ret = platform && abs((int)diff_percent) > max_diff_percent &&
>>> -          abs(avg_diff) > max_diff;
>>> +          labs(avg_diff) > max_diff;
>>>         ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>>>                  ret ? "Fail:" : "Pass:", max_diff_percent);
>>
>> The changes in this hunk are unexpected. The changes to this area made by previous
>> version was ok, no? It really seems like this just does a brute force of everything
> 
> Well, not entirely. That first version was when I still believed clang's
> claim that abs()/labs() was a no-op. I've since been corrected! :)
> 
>> to long (while taking labs() twice) unnecessarily.
> 
> Which part exactly is unnecessary? Are you looking at the function args?
> Or something else? I've stared at it too much and am not spotting the
> issue yet.
> 

The following (what was in v1) looks good to me. What am I missing?

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..05a241519ae8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = (long)(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);

Reinette

