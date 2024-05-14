Return-Path: <linux-kselftest+bounces-10186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAE8C5A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08131C21B78
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA417F39D;
	Tue, 14 May 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nq7e928c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCB18133F;
	Tue, 14 May 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708370; cv=fail; b=Kxo6WxhDEffsH+ACdd4vGM+81xaEfrVCsO3XKlIX20h4qkMyizkdda/Cgqk4vjdEHgOPaxQ19KlbP/NZOODQ8CrPEULMiJ4hGdg428Xk3RKnSZxUHoWySSSv8VqLwHOY6fHUQO3SNPL1nOMjhqg+C282se15uqGDe5q3zIWP3Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708370; c=relaxed/simple;
	bh=8UeXdFgH7traAZBYBEhNi/oWL/5nzJ+Qb+UBONarjLA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADmDzZ8m9PLG27J32KCQRqHljcOqhmt41TmUYVTkSZ3hGYsDj1Ic+t96fk5RmkHbYBgPZQpu+NXLTZv0VjlThTdaCoS0xKFvQLMocQFI9o1d7lfVU3AtXbo/z9AIQgkAEH5Ffbc59+l3UeiPNBjOmlVVKk7bfSW8tByGY2P+rKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nq7e928c; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715708369; x=1747244369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8UeXdFgH7traAZBYBEhNi/oWL/5nzJ+Qb+UBONarjLA=;
  b=nq7e928cPDwvt4UBCoCcKb0P+dqQlriLipqaG+RRtYuYJjcVx3UiXaQJ
   4/fk8AtcOshX3FcBW3i8YBX9pMvPNamHdUohehs7+OXPUCK+L3BBuKQUu
   h1sEqrMz01AGa3ZIlbMSX7pnUM30u1CW3l9sLwYnH9uPWaxUGqXSWeaeB
   Gp+RAkd832+BVgEECUfOull9tiIZsOyM9ukgyzKFMn2xUpLm/zYSHMGB1
   Y1Q7bK1XFuS03GnJQ5meJix5JGVwbMKj3nVufh+51V/6Yr38nRcFoBZOW
   F6//u5akExmYYTm7EhcmQQmyfk7KlGr6XxIBP5oO1thvHB3LLfqKdtXZM
   A==;
X-CSE-ConnectionGUID: WWwMuTq9TQmq1LGU9X/qOg==
X-CSE-MsgGUID: jkonXwRCSMi8uByjFhUgdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11522067"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11522067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 10:39:28 -0700
X-CSE-ConnectionGUID: HSMO31pVQ5CFPXd/wTj8Mw==
X-CSE-MsgGUID: w7WRub8HRS6Kjf4oQwRM6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30807916"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 10:39:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 10:39:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 10:39:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 10:39:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 10:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPbsH8lrpOb11ml/D1Wx1yLs3qLJj56V2MAAohxMGgZz6uiNIuoiGtE+EXNCD4e1u6LPX/ugG+YtAkzuSyNMqkW5tBV+vuxSpVdma0VVik/h8BLbhHcwNPJK+y4CDf0aIVDwyDQTE2xvVR2hy4zeGTmm/olXV9dYhuOJ5lUvX7QLINmw0F7xXtBERZf2qH/yb1egBQ7h0W8heLApwGSZQukG0AxWc8ihyjtSBNy4GtiWk9i7ZOaZMCQPjbsH7C4Ush00rlU5KG+mDCQdgETd4hbyrcTHCZZCVNjueXzNGWEY7U5v4Xzq5keCzdyb0V3MRAhu/XG/JeKKeGpb7xJiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCqJeixNYBkqGTk+Z4ig24s8OFjl6qDOTnRdIKcICZk=;
 b=GPh8MqI1Sg0+75qdZk6FxIQfR6co548QrNatLvPTdcIMO1qYR6JqnPTJiFy4qLs8bPMJaOnMFyPkSA2LShH150aoaYA9ziy95cd6bpOAAtgIPGZSdHj7eJm93HP19MoKpQLYxUaYe5sfq+VVx0PaC7hv/0qhrP22GxfQX1qg6un1SSxvA+0k1xNNkibuyJD04yMIQfrN3vTVeLlfwPxhYluf7cWzzMLysZHRTYJT1f3L+F/Y/EDnFUNXNsJYCNkA5kva8FFKXb+u5zAz4lwJbPk0Z4cBuWReSHdaTqcYU0KGgoaMd6y9xlPmg55LfJMzMDbwGc+SGliPvofoKD6Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CH3PR11MB8494.namprd11.prod.outlook.com (2603:10b6:610:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 17:39:24 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 17:39:24 +0000
Message-ID: <bfbf8ec7-4deb-47a5-88ee-7d836ea13470@intel.com>
Date: Tue, 14 May 2024 10:39:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: Shuah Khan <skhan@linuxfoundation.org>, Pengfei Xu <pengfei.xu@intel.com>,
	<shuah@kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
	<sathyanarayanan.kuppuswamy@intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
 <58fd25ea-c444-45cf-a41d-c3022e9d5f80@linuxfoundation.org>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <58fd25ea-c444-45cf-a41d-c3022e9d5f80@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CH3PR11MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: f5556767-cd9d-4dcf-f015-08dc743ccbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFNnclpiTFo3SGMvVzhNNU9NSU5xQXhWTFk3UnNIWFpPVGJXMlpOMmVDUWlC?=
 =?utf-8?B?TmRYczhsTVlySUdWZGJXYnpxbGpiWjJpbzRVc2F4cEU3cHp1MTZFM3RtUXZT?=
 =?utf-8?B?QnNNWHdscFdMSTdwOWQySm9nYTByQlV0TEZrUXlnOU5jdmVMRnB3RmVtbGUy?=
 =?utf-8?B?enJpek9aNkpmT3NRM0s5cUlvQW1hVklkSVhwMEduUmdaVHdEWEtSSll3alZm?=
 =?utf-8?B?NDAzS3o3dFc3QnltRERkbHB0WmJGYitmb0ptNzlRSWRLSjVqTndtWHY4Tk1E?=
 =?utf-8?B?eXN6VGthaDVHTGtMdXc1d2szVCtYalVlMTZrWGFGUHB1ME1PVUovbmJCZ3Rw?=
 =?utf-8?B?MDQ3cU12VG5Ldk9rRmY3c2dFckQ3RTBTMERwbkN6eGpWNklPdE0yTXdsT1VU?=
 =?utf-8?B?eHVSVTFRdHpIZXFRM0c3YjQvbjY1eWFtbGZNVGhWZUExbmdZbitGNEFybnZF?=
 =?utf-8?B?RXB1YldjUk5VaUhvRjRYVnhSdENGeGhkSzlRUnlWVnFUODRCQ0haTkZ0amhl?=
 =?utf-8?B?WXBuNDNQMmNWWk5sNC9OSnBrc2ZZREZ5Z1NVUjhVb2RjU2ZFZ0Fqd25sU1hl?=
 =?utf-8?B?OWVqNU1BR29VSjk5MCtjWnBpM05pZVlkTEFMSk9uWWhocWppVGNIODB3WWQw?=
 =?utf-8?B?bktZTEl1OGRycmwwUkhtTytDMGF1VXF6bC9XWWRFZnpUMnExeG1lYkE1Y0wy?=
 =?utf-8?B?Sk1QamIwTkF3UDRPSXJEWHhNTzl0OHE0Z1gvMXJRR2d0UU9QQ0czQ3BycFlW?=
 =?utf-8?B?NXpjWHBqYUg5K3V2bTh1SDdUcTdqTWg4ZUZXeTB0TGs3MEZ6NDVXbncvbVds?=
 =?utf-8?B?THp3R2t3aVBxU2Z5bXBKM1VSeEZUbVlybmN0aXk5RnlucGxlVUhQVkdNWDFO?=
 =?utf-8?B?RE81U1BVck1Hb0IvemVMNC9zTURPZFowUzl4MGRMSytEWHlUUHZ1SjVFRmdl?=
 =?utf-8?B?Nlc4bWdjMFZES05lQUtLQXRqNXRzbmFWcWFtR1NPWDYwSGI3WnFUN3VWVzY1?=
 =?utf-8?B?REg5U2d5cTNsdDR3QzlBQnFvNS9TaW5VYlk3dFpsWHFaRmxLSE1WUkRCVUFB?=
 =?utf-8?B?d29XeEM1dFhPbithRm5OVUdEQ2lnc1N4aHlQUnp0NU1RTlpnZlVabmZRek1I?=
 =?utf-8?B?VU5BcEVyaVpvR21mcTVxSnhyUURYdW5ORXRZM3NxYzVybUpOSlZJMVJyU25X?=
 =?utf-8?B?UGpMejY0ZlMvcmp0SzZ4UGJhdnpXcnBLaURsWjR2cmdabVpvcHlHNSt3cmZP?=
 =?utf-8?B?eTRHVklKU0xNZ0pTT2Z5SHBqbEhtTDZsWDhqMzNFQXlQL08vV2hOcFhWWi81?=
 =?utf-8?B?UzBzVXF6MVRiN1VEaWQ0TzBXMk5mWjYrTjRVMVR2UlAydGpFNTlyMzU1QlBJ?=
 =?utf-8?B?QzJMdGYxMTVsZHpIc2VZV2twaTU2N25lZ0xzM2V3NHJoTkNCMUZCdnJoV1Vy?=
 =?utf-8?B?cXZsVVAzd2FJV2t1QXpUb05CQkhDQmRIdGsrUnhCSzdab2RFOVpPY3BBUHZW?=
 =?utf-8?B?LzNJMHY1OXA1VzFmenVDaXdYUStJZGlETkNrOVJJNHd1aTJiN3kzVWxQb3M4?=
 =?utf-8?B?SVRBUm95VWRhTndRUkxXUW8yMXlvdFZvRHNKRUdENjFraHBmWHVkZnNwdDF2?=
 =?utf-8?B?NnVxM1FrNzRDQ3FxeUNYeTVuRUZhWGFEMDZLUzlxSzlqdTk1NTZITnlPUVU2?=
 =?utf-8?B?Y3lZdDgzb0c2cm5iQnR5NUhKdXk2dEdMYTZZTDNrSkpoUzhoTUdyL0lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhLSG9jSExVcWppM0VaOGhWUElBSmpvR3JabnZJak9mbzNEZGlQVGFEd042?=
 =?utf-8?B?ZnU3YWMwdjltU2M3MnFSVURwQ1RQM2JMekxQMzVaVWhqOHpYMlFVK1Q0K1Iw?=
 =?utf-8?B?amg5dktyaHo0MjllczZ6TnNKM25JaWtvdHZtRzNqajJiaWkvYUZRVVNOK0NZ?=
 =?utf-8?B?S1BRS3d2RGcwYnhMK0FQWW1Ia2FoT3VDdmgzd0xLUldnTVE0dXIxbEUraUky?=
 =?utf-8?B?dmtaVVhwR1RnZWd5SXZrSmlqY0pGTkgrTUlYcTVHdFh4bEVtTGNZUWZVYUtn?=
 =?utf-8?B?Y0luYzZPSUxFb2xhNjkzbTZOd2Y2SGphZXZSd0FMVnRkVnVlVWQvYVBMeDdj?=
 =?utf-8?B?cS9LMDhOQlhsRHZ4SEJWU09CbzRWOTdya1cxWmMxV3FFbTlpTzdZODRyZndO?=
 =?utf-8?B?SnVaRW1xaHZTbXg5bGpFY3pHc0NFOWY4VDlyUERmMXpURGFMcFQ0Mi9yNEph?=
 =?utf-8?B?eTFxa0lqSW9HVVNjcTVMYkhIVzZCRTNXVUJvMUFWaW1IK3djWWxEZFdxK3VF?=
 =?utf-8?B?ODBrKy96NFNZTDRxYXVJMHFYZ1MwdUtScU1BcDVrNFUvQWp3ekJ4cVpJeW1i?=
 =?utf-8?B?TWZzVzQrSzBDenZtZThZWmpoZDVacWE1aEswV0JUZm5Kbkl2dUdlVFphNUp4?=
 =?utf-8?B?SC9qZzdTRTNDRTE3cVArVzlGME03QTg5Zy9tc21DUTBNUERUd1VFS1IrbHRh?=
 =?utf-8?B?V2x5cDBjYUEvVCtESG1JQlRaYjNlcG0reXl5M01lZEJpbHplSVZKMTFWRnA2?=
 =?utf-8?B?L2xNVC9CMmwwUGpZN2RNditMNk4vTUVCQU9YYzlEUEJ0L3EzZGtDUjY0cUcx?=
 =?utf-8?B?VjV1TlpiNnkyQjd2WjhUM0xGVE5Ib01lOStDbWtmTWlsWFptYk16VG1Ya21w?=
 =?utf-8?B?TEREaDZ0M0ZwVHNIK09zKzJreWk5Z3JJT0lwUFhhdCtXTUN4eTJPa3BhUHdm?=
 =?utf-8?B?aDU0VWdWRmNPYVFiSEd4UWd3b0dGNGs0TVB0a3hUcjlYTGhQbzNUR0tCRnJw?=
 =?utf-8?B?MWF3U3kzSUNJQkMzeVJwdkVYRmltU21TdFBUbXZscXY3K2txTWo4cmI0dDRF?=
 =?utf-8?B?dDJHZHhuMmVQaDNPa1RCWGhkYnVGMEMzZU9DN2pMOTgxdiswNVE2MEFrVmw1?=
 =?utf-8?B?UlQvSHlBODVVcGFDL0k1c1JJdlZ4UEU0L084TGJ3MU1XaSt1bkNiWitVOUp0?=
 =?utf-8?B?Vlh3RmRzTG9RUTV3azVIa1dNU3JWV0k4UHhzQXg5eE9BWWhEUVBUak5lbnJU?=
 =?utf-8?B?NnJYdnFNdDFySGdjVm11eHRldisyS0dwVFhTRy9semU3TlR2Zk9IZ0poTFZW?=
 =?utf-8?B?UGx5aWx5TkpubGsrTVVyNzRCQkZyL0JsaExpeVh5amZXZ3BWVUhxaEQrUVVn?=
 =?utf-8?B?UmIyZkdvL1lJTGZKVjVZNDlCYS9YRHdSL3FPY2tFcTlKRUJodUJRYkhIQitW?=
 =?utf-8?B?bGNnZytpUkJVTU5Sa0VNajdWdURMT0Nqbk5QQXdNVFBFL05qT0ZHU2NzWVJz?=
 =?utf-8?B?OWh6Zklqb3N0cW1wczIrSFZkQW9IMkFkYWtkY2ltRG43c1RLOGdBUFQydlBo?=
 =?utf-8?B?TENUV1RxRXJaaFJWdzRKT0FaMlBXTW1Ib0diZk5nZyt1bXRMaUhqUGFDZGND?=
 =?utf-8?B?UEZWUklMdkF3b3RmVGtQK3lqV0tWeW5zTXZ2UVA1aUJMSlEvYmE3WGcvODQr?=
 =?utf-8?B?NTNyWWZXa2RHUmhuMDQweUdWUm1BbWZqQVpwLzFCcWlQb0tOSGh4VGttd0VG?=
 =?utf-8?B?cWk4K0tFdm11eGRVK2NBRGZZL09zOTQramtsbEFmdThkNVFQYXV6TWtXMG9T?=
 =?utf-8?B?M2E4SG41YlJHOEhxRGRCYjY3L0ZkdVo3cEZPMk1hMWdQZ0l2MUxQdjFRTFRt?=
 =?utf-8?B?OXJUVXluM1hhTnNiQjdrREJQM1J2ZGY4T0c0SHNYMTBDckVWc28xcGZyR1BL?=
 =?utf-8?B?QTlDS1lZSmt0WDRVVFhEYVFlY3F2MFpERWRTaWx6bDlnbGpJaVRySmU3Mjky?=
 =?utf-8?B?cDhaeDdzemJVWmVaS280NHVxTDBJQU82aFFtUXUwMWtNZ0ZuR1lFemRpK0d4?=
 =?utf-8?B?bzFpTXh1UW52WU5wcC9xU1ZPbkQ4S0VHUHhlL2RRYXd0NE4zSWoxWThhOWhI?=
 =?utf-8?B?SGVndHJaOFE2b09mZDVTSXRabmNwU3pjQjRkZytsKzNjV0ZOUlBPcU5zUFIy?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5556767-cd9d-4dcf-f015-08dc743ccbdb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 17:39:24.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVPs1i13tiJ1Vv3+RYwvtkMsIF8Dy6XS59URnQZpFi59lvNYWWsCaB29hnG0xhPWJgYNy4QfRw6lpIPaLZWWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8494
X-OriginatorOrg: intel.com

Hi Shuah,

On 5/14/2024 9:45 AM, Shuah Khan wrote:
> On 4/29/24 21:31, Pengfei Xu wrote:
>> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
>> test cases:

...
>>
> 
> I am fine with adding a test. I would need ifs ack or reviewed-by.
> I don't see ifs maintainer on on this thread.

I am the IFS driver maintainer,  and I have reviewed the series and Pengfei has
my reviewed-by tags added in all the 4 patches.

Thanks
Jithu

