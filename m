Return-Path: <linux-kselftest+bounces-10638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D775F8CDDE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 02:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C68AB217A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575D36D;
	Fri, 24 May 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoBD84+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320418E;
	Fri, 24 May 2024 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509449; cv=fail; b=Hw8enFoOQjshpXFNZu8PuL1/Hia0AlCMxyFOxioe6Vrda6Q46/Dfx+j+B8cV67yx7JOtqxcdG9h6XelyhiGnffcaQTLawCs1OsdXUhaDv55NEZWO5ex80+88qONp15Qk05ik2aM/vPstYZcbg4THlG+5Y5Bi7zOkLmXFNcQW6pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509449; c=relaxed/simple;
	bh=WGsXzqggPveZpztjqyh80NOYvjts3iZhXOXiGkKzgFI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOsz6tUXnkyoQo3QCbS74mSYtVsxKOC0+4DxKT81p9oHbCEwNhYEl0H5jn69ZHSYWehVWuVp8UHP+CltOoCyKzEf3SoseWtU+QeZBNd92sKWu+G5AjZczUuCNEUa9HrIavp33S8gZOWvTaADCjgP1vWDMHKNaRac7rQygagXnHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoBD84+Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716509447; x=1748045447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGsXzqggPveZpztjqyh80NOYvjts3iZhXOXiGkKzgFI=;
  b=XoBD84+QrbBMYMVStv3ats7DliriWqpbBmM69NHXN84nFnx8s1UOvcvV
   dPAkhCL75R4M0o2Dk0avqjlguMFNM2V+UWK6kKuUwSgFqU26LhsLb7oES
   i+KyCJ6oiqdbW6xmLQrX6dZjOk6erRwPEqIfOwVPwzgFvpEkgTPLclwjy
   nSW4b8CViNC1toMERce/rAI7xMrH+lIymM8lBE3WbrPuwg/fhg2b95Zgv
   3v+hHHgk2fe1IdS3SoFAdzW30bK/0nwYPdaOOQdvH2EtvURo9tfhhzFXO
   NER3BdpYKTAK4CNZ1x5iTFNDhXQ+ouTL+6KSXkXpNMuHq1IOxx3pjuXDy
   Q==;
X-CSE-ConnectionGUID: RVciLagaRK+CrpvfF7Gpiw==
X-CSE-MsgGUID: Hr7g4Cf+R3+IrLg2uzTQIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="11671803"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="11671803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 17:10:47 -0700
X-CSE-ConnectionGUID: b9IjA+/rTGGzsOK1z7vlLw==
X-CSE-MsgGUID: TFVLPCZ0TNGeJNHfhlhvKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33952861"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 17:10:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 17:10:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 17:10:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 17:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buUsqu9oODnWhAjXRbD6OVYZitCEE2IaLCkVnCe15sWFAKpkLDACwyBGzRQzlTHaeakuI5fQIxwAbNVKYPDhJHW263ZM2rWNe1vTkly1RxmZMKpxvRDQIvPtvmpiHh88eJu+nQbDnHi77PwdmlF4qvdntP9109EsMNix05sTfjpevf/b/bWto5eWbC9BihQH2EUtJfEYXW1XfG/TpzcNHDL/v0txxecn3ijutBvW93vuOCxP2Oe2gCTtkCWWzIX1TrsjXOx1dLS5+lE55BTLUR+tMsNnPkmCK9JwZ5OcS3lO5bSgfQ7BasyyuxQLZHSAa1FrA9txY6tVzu55gb64tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpGI5qthM7szU1WbEqGVwSMwI7c4stGpiq456v52/lI=;
 b=io/ij2iA/FfHjipMvCnox3oSI2L1O5uTBwrVLMY+6IzvthQxUmXczpHo0vql2eDqb0WlfvyHe8ooyWlVTszPyr/4Q04CPJDi2DS8z8zbZKTkKkdvYxnWExuLLKerHGnlH1TZnhbTi3aMg4jg+epG4UkYeybY4APnrz1Y1PY9fp1HGLl8shBGSDgMExir0kV0mB5y/U9kqBXlMLW7y4kj5Z1LE7TkeqjlaCWvWeeCZwpsLC0G2u0KTIekcBJGVbiEOkpwcpoJOpSgAs5o5j3/K9JXw7N13kWF8vbNlzFQyOFGoc6Z5JLVGBeuetCyqkPpmcT3LFfPXsJKen10oJhstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 24 May
 2024 00:10:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 00:10:44 +0000
Message-ID: <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
Date: Thu, 23 May 2024 17:10:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4a0724-64d5-4a60-1d10-08dc7b85f44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlyMTNoNkxyM3lTRDhxdXJpYzlKUXEzdzRLcjN6V2JtQndOMlRraGlWMk54?=
 =?utf-8?B?anJXSTAzN2VBYXNkdzAvWXFzM0JhQVhpaUh1aGJVVExPWHFvL3J1WEZxVGhm?=
 =?utf-8?B?cy9oblk0cElWR0l5eWhzYlRwU2Z1R2xUNktYbXRTTU9vS2s2cWx3NDhTU2FR?=
 =?utf-8?B?UlphekJCZEZDclJjMmtKNitBaFRDTTJjM1hGZW5YNERoN3Mxb1c3dUtucGg5?=
 =?utf-8?B?VktmeXh6SUlQZitRN0NMcTU4a3RBLzA3Z2FnUnF5YXJqQnh4UkcvOUtKamFJ?=
 =?utf-8?B?N2hpYWJodUNyNGdGYWdWSjlrV0RXbThKTFNvNXdleDR3SXBxcVU0cTVKM3k1?=
 =?utf-8?B?ZGRmQWxKTm1rWHlYWFJoVlRiQWlYNit0a01ONGI4MmtXdllhTVNzU2l6YXZu?=
 =?utf-8?B?aWRiak5KUE1PODZDY2pZeWJ5RGxFRVNENXZqcDJHZ0d2ankzUzREMXJlTVZ1?=
 =?utf-8?B?Y2FJcFRYUjA3bjl2aGZ2aFhDTXRwcEgyOXJmL0pUcHFtSDNSblBUUnRkaTR2?=
 =?utf-8?B?WUtSZklYMVdDMFNoT1JLcDZHL0xEYXZrWWtXSC9VMU5JcHVxazBQTmpOL2wv?=
 =?utf-8?B?aTAyTjZzcTNrZVJDcHN1VjlMNkZrV2U5cVhvTGpxa1dhRGtSN1hIYytSS0ZF?=
 =?utf-8?B?MEp6dDY1UUtTVVlZRHR2Wi9EbCtrMGJrd3lsUWhjTHhGSVJjaURsR0s0bVRM?=
 =?utf-8?B?UXFtamFqWDVjdzJNR3hXZVNzVXpjaklOc3drSUxjM3AvTlZUR1Zla2k5N2xH?=
 =?utf-8?B?K3RxUnhrTXRQM1hQUDBxMDNDZVpGek1xUmhhM0JSbU9JZ2NkZ0U5cFltOGFr?=
 =?utf-8?B?TXowMk8vcTBKQS95bmRzRWY2V2c1aEY5WmtwZnB1clpXeFVxMFJpMjBuOXU5?=
 =?utf-8?B?b0FqTVpHMnlqaW4zWW9SWE1vVnNiK1hMRk4rejlVYU80REp0cnBsWXE3bmtC?=
 =?utf-8?B?d0F2MDlhRmd4Q0NXWldwMFZyaWlNM2dwMWdWeTltV0xWVGF5SDNEUDJ3aEIr?=
 =?utf-8?B?MWg5VExTejFkaEgyMldpTEdYdG1CS2FGai9jclhka1QwTU0yVDRtTDg2bW5I?=
 =?utf-8?B?bi9yZU5EdGExaWo2Tm5vR2NSTHdZeTBPNy96djYvNU16WWhJTG12ek5wSzht?=
 =?utf-8?B?dEtVL0c2Z2hCVVBxV0tFRzlUVENSZFFrU1gyN1VzTVZkOHpkY2pEODdHcEZ2?=
 =?utf-8?B?TFhXNGFQMEIvSS83d0lzR2FQMW1PZFFhbUE2OVR4a0ZqdE8rV0ZxVDQ5M1RD?=
 =?utf-8?B?SkpFTlFlYVFySlp6R1NWY2V2T2JUM2lwd0VOMnh5Z2NTa3VVbHp2L0hIQWhk?=
 =?utf-8?B?MGNQZ2E5VFlLdTMwZFdjUjN6VWI4dW9HL3FMbTFwdUU3NE50RXB3TmhUNldh?=
 =?utf-8?B?cHlRUVdJVngwdmF3QklsZk1MQmh4ZjFtNkc1TEI0emJGY0c4NStPVXp2Vnl4?=
 =?utf-8?B?K0FvditMTE9lamRUeS9peHBFV0FJbThIQ0hLdjRYblZXZ2JaUXRWbGYwQU1U?=
 =?utf-8?B?NHRqU2d5Q09qeW84UHhKUXBLaG5ES2drRmlaZ3pxdUgreTFaVlJBU0VFOUtC?=
 =?utf-8?B?OG9qT20xd2FFZDdYbTlHUVI5M3ZnUzRmWWt3ZEtFQjFyV2phSHZxWUJOSDlP?=
 =?utf-8?B?ck94N1JVRlZKck9PTjhhcVNMbHYvT3dUWDRvVjB4ZzlLYmZ2L1Z4czFqMWc4?=
 =?utf-8?B?YzJsM1hKb0RkdlFGMGk3dGJiZUV6RDMxZThxdkV5YXZ3d1d5UlFuLzZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBoQU8waGFVc3RWQ0U4akMrbXlTZzZ6R2JDN1ZQQUJtWmN2MUZYN0hrQy93?=
 =?utf-8?B?K2VSVmtGZW9oODdwZG1vUFZSdFpsV1UzWkpFK1kyVXVGTlZpUnlVT2RRVkJX?=
 =?utf-8?B?MWQxWnprenI0YWxiYWwvNWNBbXJFb09odFA5aTAxWG44ZDFnRnhKMDc5d2x5?=
 =?utf-8?B?TWZQelAwN2dKVFZ3MWN1U3N0d0lubE55N1pFSTZRWEhiSXhyUXNCbmtWWWVu?=
 =?utf-8?B?dENZMjZqczVUM1pCNHpKMzJZclJNQ2JNZ3l0azNvMzMxUUJNQ2pXSkFwd085?=
 =?utf-8?B?ejJFQW5Ed0NCUmNPSmVicWhGU0k2SjdKZmtjQkJoSHRYUCtPUU1VVG5ic0lz?=
 =?utf-8?B?VDMvOVd2eFNURW5IN2RKMHQzRUNzcDd2Yk1TM3daOGdBeGVoZDJJL1NLQXJx?=
 =?utf-8?B?L0NBbDljdlVkUTJhSktPQ3FDdHNwWTJiOVNDLzZ0OEZ1Wk1LaklWT2FZdFZC?=
 =?utf-8?B?NHhNai9LTVVIeFJGTmhHUW9wNGRrT2NOTC9rcGFZRTJHR0t5ZlByZlkvT2Ux?=
 =?utf-8?B?N0hDeFF0SGpXdlBJT0FjTlJTRGdTSFMyL1dyb1I3UDBtMk4zTGQxTDljaE9v?=
 =?utf-8?B?MFNURnpvK0lGNjBQeS8wOXBXQzdKZ1g5UVVMRFNzRURhRldmVXNoY2V6OFZX?=
 =?utf-8?B?VU1MWnFSaEJnRzNQMGtQTDhLWHRBaklURFF2UkQ5NngxcFh6Mmd4SUtSak9X?=
 =?utf-8?B?WnMrL3BEZjlsNmtjbUFxc0RnRXBPUmkvbVFmZlc5ZXptb24zcEJDK08xK2lH?=
 =?utf-8?B?YzRwbDJUZjFwbk1LN00vNktNSTE1cElXUld3OERsS1BrMEkxdEM2RmVCK28x?=
 =?utf-8?B?aWhHUldwYldQMHdGZXFUcy83cUdVMVMvVFlucUwwTGFPaXdEdnJjeDJIc0o2?=
 =?utf-8?B?UUthc3hXYVBpNzZ3N1hPWXpUbEdxTTlYWEdQekhOaVhyaVlsQlpmeGRMYjVo?=
 =?utf-8?B?QXBhTzZ4MUlKeGF6TTNnc0dGY0RYWnFWeGdGTGsyN005VnE0TEdJckZYY3BU?=
 =?utf-8?B?SjdIZ3AvK0hmV1VqQmhnczlYMnRPRnhkcEdaOXlINUR4ZElCYnhQYWx0bWZF?=
 =?utf-8?B?RlNHSUNVeUlUMG4zQytZRWpwWTQxWE95SVlMWXl2dXRkZDErL2xRbXVRYWVM?=
 =?utf-8?B?ZldNUVZhTjU3eUNYNEZscnpwWW1FUUJIRE5iOWNPa0VNYnQ0NFU5NFRVUUg1?=
 =?utf-8?B?VXhja0xpdzM1N2x1Z3pnWU0xZ2l6K2Vyc2cvV2wxZk94MnFWNjJrRDBHdnMx?=
 =?utf-8?B?SW1lQ1h4aEovRy9LbE45SkkrTGhjVk81ZG9FeUpDcjZzalZUK2JkaDdOakx1?=
 =?utf-8?B?UEdzdzZJaW1YdHZacTVzS3RSdFlZRnVDa3R3Rm5YekdTcGxpTHRrWFh4Umpm?=
 =?utf-8?B?RWxGeXV1TTNnQjVOYXd5ZmoyRVZKMXg2bVhZdE9TUEFINktKUHYxeDRiNTF2?=
 =?utf-8?B?VFV5R0ViL05oUjRKZUFyczRKYlB6ODVpd2V6NHE4Z25wRFpLTEFnbklNa0JB?=
 =?utf-8?B?OHlac2habW43dXY4dVdzd2t4Sm0rU0YydThJSlVKWWVXeDVNcFNaM1AzLzVY?=
 =?utf-8?B?MXN4Q05iZldCZk9FUi9pY1NmTkJTTjR0N0NKTDVXL3diQ3pQZTFLNUlocC9Y?=
 =?utf-8?B?dVJMdWgvNklZWXkrL3c1bHJ6amI0bnNMMHVhVWVNNWd2M0NFNlYvendyWFBm?=
 =?utf-8?B?S1V2UUdqeGVVNU9PdTdjTmNGUTF3SWZ5M1g2OVBhOHY1d3dxNm1KZ0d3MnR2?=
 =?utf-8?B?VkpzVkhGQTdRMEZSelZJbVVLR0Jsekgvd0JWekxCcnJHNlRWdlBzb1Uxb2t3?=
 =?utf-8?B?VWsvSDhxUDV0a0xraVFDT29EMnR2eU1zRHJHbFRRTWYrdXZtMWs0MXNHVElY?=
 =?utf-8?B?U2JUS2Rwd3lyYVdtaml4Ti8vSWpxWi9OYjFVN1hwYlBqRFk2QURVS2czREF4?=
 =?utf-8?B?ZW1US3MyWFNrMC9Ra3U4ZkkzRmdsYXNZU3ltRUNJSGR5Z0NJM1krbVhpVk9B?=
 =?utf-8?B?WlM2bmQxOGR0dHZPeHFCK2NML2xWNlFlcUM0SEJISS9mK1JENGx4QVhYVFIv?=
 =?utf-8?B?dmxIZUl4RTFzODhBYk8vL01wOVF0NWVPL3RsYWlQeDc0OU8yN2FVS3BDc3pY?=
 =?utf-8?B?SXRHb0txSmwvTzFLRGs3UWxtVXhlT3JOL0xZcFFkTjRMQkU3NFJqc0Zac3cy?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4a0724-64d5-4a60-1d10-08dc7b85f44f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 00:10:44.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukE0jXfyelD+c4L78puG6wMqFrbheI2MshBCvss9Gx+rFVO3Vd48F4GWcVMhzPjMocRVn+s0WVzt8v73dBrxVbAqBI7hS0Z4GIHKQG4jg98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> the measurement over a duration of sleep(1) call. The memory bandwidth
> numbers from IMC are derived over this duration. The resctrl FS derived
> memory bandwidth, however, is calculated inside measure_vals() and only
> takes delta between the previous value and the current one which
> besides the actual test, also samples inter-test noise.
> 
> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> resctrl FS memory bandwidth section covers much shorter duration
> closely matching that of the IMC perf counters to improve measurement
> accuracy. Open two the resctrl mem bw files twice to avoid opening
> after the test during measurement period (reading the same file twice
> returns the same value so two files are needed).

I think this is only because of how the current reading is done, resctrl
surely supports keeping a file open and reading from it multiple times.

There seems to be two things that prevent current code from doing this
correctly:
(a) the fscanf() code does not take into account that resctrl also
     prints a "\n" ... (this seems to be the part that may cause the same
     value to be returned).
     So:
	if (fscanf(fp, "%lu", mbm_total) <= 0) {
     should be:
	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
(b) the current reading does not reset the file position so a second
     read will attempt to read past the beginning. A "rewind(fp)"
     should help here.

A small program like below worked for me by showing different values
on every read:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

const char *mbm_total_path = "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";

int main(void)
{
	unsigned long mbm_total;
	FILE *fp;
	int count;

	fp = fopen(mbm_total_path, "r");
	if (!fp) {
		perror("Opening data file\n");
		exit(1);
	}
	for (count = 0; count < 100; count++) {
		if (fscanf(fp, "%lu\n", &mbm_total) <= 0) {
			perror("Unable to read from data file\n");
			exit(1);
		}
		printf("Read %d: %lu\n",count ,mbm_total );
		sleep(1);
		rewind(fp);
	}
	fclose(fp);
	return 0;
}

Reinette

