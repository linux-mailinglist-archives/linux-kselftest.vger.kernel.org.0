Return-Path: <linux-kselftest+bounces-34431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D714AD0A54
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086921890951
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 23:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D542397B0;
	Fri,  6 Jun 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXpBMotI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF442A83;
	Fri,  6 Jun 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252892; cv=fail; b=RY8e68ZZA2CSdAeBRnla+XtNWy2orURj4Spjkd1mY2CoT6W3E8pWDDqZqni4SckaSbtthWg/0wtVrQPUq/AkuJo8m9eSJr7qDm8MB9kUDaFoZGOZ4l8CocM9/zM5BJkcTWkCrveFqXVDwUbOf3wZymRUk1AcL9+2erAyMpxIQOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252892; c=relaxed/simple;
	bh=F/f2XByr1KQYTZeEe22CqxqpJxwSF/5mHFd5B6iqQQo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2yKganZhgxuG4pOhWz9/SRYzfQKiFvdSmITngv4aP8BI+0ywX36m/E1n8dfa/jNX9Frl+7zpcbNhdODrN8mTEqk9gHxASD6iKwMAy/KRh623fPRP2WTxlb11gxG38UOOy6TfI76V2acTVnY4Glip4EMo5h9+XpIKkBz50MMSOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXpBMotI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749252890; x=1780788890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F/f2XByr1KQYTZeEe22CqxqpJxwSF/5mHFd5B6iqQQo=;
  b=QXpBMotIyLAe9Ld9RY44cRzjIJmggWH940YepH6PiF2nG2EPnaLMC0f+
   0WatcBn27pm2s75v/wRvmfsgVeJqH3E0JAkA3b7nuDD0nVwDn10RQx59M
   fidS5drgQ6ruKX7hMBHT+AwVcOMfX7RsVEdB6XUWrX1OwwyCq9Igs19O7
   l0GLWZT//ZErP+tXhhR8sUSUIgisMy0tO+nfs94D/JL3l/kdq6G1Z/Ltb
   c88O35XjqeHGoonwpXb0xSharalHSsLsX39NldC+FwGj283mnZLZDVzLF
   9b/invDTmJrd+flC7jeObOi08d1QZv+nVC9PMqOn/WX8HrzsmladanAaC
   Q==;
X-CSE-ConnectionGUID: 4LuBxqo7QLWdGjr3XkSqCA==
X-CSE-MsgGUID: rj/w0nbaSjK7Hoo9ucmrJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62070845"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="62070845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 16:34:50 -0700
X-CSE-ConnectionGUID: 5ALt6k0dSTyN5LieZTyr6g==
X-CSE-MsgGUID: ortdSgOpT0iqcyHeb0v/ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="145961937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 16:34:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 16:34:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 16:34:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 16:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXXSoUl6ytJJvb/dISIeH7If3BsfSgHb7z6+Uz5eh6DCDL+71Pv1GEzg5RvJ5bQeY1gmQn3kbVhJB5Z60N1XNuml0/SavDQY77b9Z9zPWJaOU/lAb/LDV6kSy3jvADV1EhP/XNlM5ClriGtQMDSvSxMndoVPQ2a3I4v7Ic/6y7IFH9Ze/2dqHYySXudti3cLzmTZdihX+Aqfsfu/GorQ4bA4nFsA64WYlahTFJM9snzbwvjPs6bbAiwAT7lLTLM/lPlW1HDsmA76g4zJleywZRsLeM8M/CBd8eU+gUo9i2YLNgpNwXNUy4ly3C3oXuPOxko86m82U4MNxNX4gMtemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHZTUln7H563GzDydt7aMkAI3fyO3+GoNNpkiLGqr4g=;
 b=CFfiRJFjKPyjozmcmBnFk3hdrqOgVqIezdtRFDtma1ZJ/Cyz8etc6mm42ThA8/xVtgZJVUZGNV78A1mTnnz/CuIfSdli0KY1JFYbC2VWh0OEIztoZ7quKvO6d7Bm9J419OMfh3kI91jw1FEE+ef7pCZR4cyDEey9uG1JINGcPGzlO/vW6+M88gqHj1SaNaQNPHTrddKgWzV2BmR+nCutpzijHQKwjSmv2rs6SQyXdkY0qi5mkJvJJTTiKc7hFb3Zi4FsI5go/a6btBYK8m9+dSw8kEfi1WhMysMNeTFeQ/MGbHRNNcOOIKEiLDtYPoLO1WmvVaQGq/uHIacNNw9wZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Fri, 6 Jun
 2025 23:34:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 23:34:44 +0000
Message-ID: <978ad8e1-9fcf-451b-bb55-fbe297d6a31a@intel.com>
Date: Fri, 6 Jun 2025 16:34:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] x86/fred/signal: Prevent immediate repeat of
 single step trap on return from SIGTRAP handler
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <andrew.cooper3@citrix.com>, <stable@vger.kernel.org>
References: <20250606174528.1004756-1-xin@zytor.com>
 <20250606174528.1004756-2-xin@zytor.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250606174528.1004756-2-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA4PR11MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 178153ac-f402-4fb0-63b9-08dda552b7c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2J6YzZMNXRDTzI0VGUwaHlwY25UN1drMHkyU29QR05rQURiUFp1QXBLbWQ4?=
 =?utf-8?B?a0lLTnhDbGFEWktaVlArV3UwekMybFp4Zm1Gbm1lK3RIdTBRWVFLTU9xaG8x?=
 =?utf-8?B?M2JxSlc2WWZQSFBYWk9CR04xTlVLc01hVWFreFNYdndjdUV0N2w1WDBYcis1?=
 =?utf-8?B?WEFDYlUyOVNvQmgwMTRodjRidDlLZmo4Q0doZlVPYUJPVVhudWsrNWpFaFdj?=
 =?utf-8?B?a05qYnVXMlpGd2t3UFNSTEdScWlVdEk0Sm45a05GWWtaNDIraWJIaFh6eTRC?=
 =?utf-8?B?QzNXUzY5bFNRSkpaa0sxand6SjRUYkE5Q0VFT054TjBBUGE3QkpsOGZwTmwv?=
 =?utf-8?B?Z2hHcEpmT1RBNzRGdm9IMlRocE5tSnZtQStNeUJrcWtzNTc3T3RWbERMdSt4?=
 =?utf-8?B?RGpwRTArTDVaZ0ZHRlU2V2dUNC9VazczcDBQd0dxc3ZYZllKV1lKbjROQjlZ?=
 =?utf-8?B?WmZ2dlhhcWxhTUFhcnNmazdscE5nVE4rYklmcHljYkhCK0wyaWZnRGg5SU5R?=
 =?utf-8?B?dmpraWJ6b2sxbG9KK01VTWMza25OY1k3V2UyZlNFSWRGMW0wMUVwOU1TcW1H?=
 =?utf-8?B?TTNGcmpHV29BTmt0cGt6azMra3RKQ0RWUjI3SGR0Q2VmNVIrejRhdlFKNXhl?=
 =?utf-8?B?RHVXRStxOTRrQk9ucyt3NlJLL0VIaktsUW9QdnVkM3ZWV0xBcHlQdnFxUEda?=
 =?utf-8?B?WGpnUjZBN2xoU09jVG5yNGgyYmZxbWlPNlRoZUM3dWc2VFJXZFlOVXppY3ZR?=
 =?utf-8?B?NjVDc1VsZFNUNVVlekxvcDZUZnhKamtML3ppS3dDQ2J4bi9wMFZKRmJST1dl?=
 =?utf-8?B?TkpCUW1HMHQxQ2taTkx5QVFnQVRiNnprQW1BWTBGSE4wbkhqWWd0cnVsNmVJ?=
 =?utf-8?B?RmVFemREemRjWjdVSy9wQkFPZnlyd1JmcUE4eHg4Y0lKcGMyWVM3QWE3ZWNC?=
 =?utf-8?B?RkpxbEpTY1ViaHgxTnVUTjR0MVJreGtCWTJ1ZWhvMmRma1hCTnFGZU15MkYx?=
 =?utf-8?B?MHk5Q0lvckJxN2RETjF5bDRPcGVOK04wQk9pTktETFFHY2Fjemx6YmpxMXh6?=
 =?utf-8?B?UGVFMWROSEZTWXBObU1Db1MwZ0prUnFiYk5mYW5LZUFVOUVqd3V0WXJ6ZGtB?=
 =?utf-8?B?Sjd3NERacXVzSzF5S0hIRnVXcE1pa2FwV1YvR0U5czhyYkswQTl1Q3JsZFhB?=
 =?utf-8?B?emltS1Q4UG9iMUZSekI2RFZPUDlFZXpFVjJaUFBRM1JrMU5nWGpTRFNKRFVy?=
 =?utf-8?B?d3VyM0dMN1p3Sk1Dcy9icnU2c2U1MXBTZ3YwaFRvWTZTd2RUWmxHZ1l5cnpq?=
 =?utf-8?B?cWJmdVczUllDWEZ5Ty91ZXpyajJGdkRyNkEzRzRMTllLeFo3RnQxS3NYWTNa?=
 =?utf-8?B?QzI0aVVhcG5MZDZDWGlXLzl4bDRURU9hTXVYWFdUaE4rU3Y0cWZ6SVdRdEYx?=
 =?utf-8?B?aHppL00yQWVtRXh3VEp2a0V6anVyeUtjMmxUK0tEb2F6MTcyMnFPQkxvWkxS?=
 =?utf-8?B?OWUvZlVTbEw4d0NueW1hUjJ2ZEtYU1YxL2tnUTFPYlVDRVpuclFGZndOU29X?=
 =?utf-8?B?MGE2OGJZamN0eTZpTE5rYmNQaWFBUXJvRlQveEF6ZHRyNFhmeEcrdjdhT2I3?=
 =?utf-8?B?L2s0NnJyN3hGREZCeXlQOWNvbDNBenF2SVdrb3pIS1VmbVdmOWRYUHRGc0xl?=
 =?utf-8?B?RlY0dTIycWhhWVlqKzVUd0Z2NE82Nm5zbEZPK0M2cDJrTmQ4Ti84eC9QU0hl?=
 =?utf-8?B?M1ltRHZKeHZNbjFSaCtHZkN3SEVmcWZ3M2JYOXUxbVlpSVlFTHEydXRWbzZ4?=
 =?utf-8?B?OXhUV1pTZGxpM3BhVk41NmgrbW10SzZCUEMydnZFRGVJeTd6YXRlQWJDOW5K?=
 =?utf-8?B?NFMyYVFrS2xSVVFKY2xraEsyM1dZRS9kNTJMQlViT3lTZFdmRHhsVWJFU2Ri?=
 =?utf-8?Q?LDqbBlsK1Lc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1haNlBlNWlvNURuY1dpYzJWMXd3ZllISU1RcVNUMWt2OFpDTnlZUHFHdDJI?=
 =?utf-8?B?bTdzb1RoRm8xaVRWMEFkUDROZTVXV01iZ09mZnhQMXN4NFpZdUJsMVhibkNJ?=
 =?utf-8?B?N0ZmQTlmamJrbUR0N3oyamFDV0NEZjI4MDVvTjUwc0xCYjVkYUhHYWlDSDVY?=
 =?utf-8?B?UFlERCtzY1NteGR3b3p1Q3Y2NXdzdktGMFZtaGVsdmFUS1BDTnJQc2srZDFU?=
 =?utf-8?B?dzR6K2ZiMUpIdDFiU0tENHpBMFhXZGszci8vNHhJR1ErK3BnRjFUeVIyMXRs?=
 =?utf-8?B?OUh1L3RuazBWVjQrMTlBdXNUd0pyY3V6a2NQS1BSQXVwc3JCcUhuL1dCemxY?=
 =?utf-8?B?MDdhWVc4YUxmQVRXYTdLa3lXczVXbnRqVkFMUENBQW55ZXRSc2RGSmN0blhR?=
 =?utf-8?B?NnpnYWYxVlhzSFlLTWhnd1c5QldaeDFUT1pJWm91OW9KbE5HYjY3SXRoaWc5?=
 =?utf-8?B?dUpKVXNCWEpkZys5SzdaeC9LZVltaTJSNi96a2w1SUY2Z2l6Wko3OHQ2cTFj?=
 =?utf-8?B?c2JXUFFSem42a0xwUmZZamdvaEVjZFBubmV5YjJxNURWYU5XNnJ4YlQwbmcw?=
 =?utf-8?B?UElkeDdhMW1RY04rLzQ1T2JFYnU3ZUFXc0xPbmtwOWJJSmdyMWxZTFBQL1Vr?=
 =?utf-8?B?cE9PR2tQVFNNdE9DMWh4Mm5lb1BJYXBCSzBOZkhzdS8ra0IrdlVpM01HRWJI?=
 =?utf-8?B?bWRUcEF6eE9XUElHdnQzUmJYQUE5Uml1R0lOaDZCUEVBWklNSldiNThqM1pO?=
 =?utf-8?B?S0FpZHhPK2lZSm01aUp5VkJSZThQenZVNXJOSnVmT3NZai8ybEV6cCsyNnd5?=
 =?utf-8?B?WGVzSjBNVmRyUVpOQy9lcGVRL09qTFpCa054OTBsbFlXVHJDbDBGMTBtR3Vn?=
 =?utf-8?B?eTJiNS9sTnNTQjM5VFZtTXJnVDV1TmhLbXQ3KzV0NzlxY1hZcnJ2OWVtMm8y?=
 =?utf-8?B?YkxlQWtEWDg1OEJiaHlDazcvOVV3bDFFTWgvK2lMengvNzlBT3NRbXoybWM1?=
 =?utf-8?B?TnU5bkgzblhrbzNWekVHYkpwSXhkTDY2WXliMGFGRVptaXI2U1JyNFRWZWNT?=
 =?utf-8?B?b1pnRVdSczlqRzV5ZUF6UUpTTGpQelRiYmxGMHFuK1RmVTBSci96MGVwZTRw?=
 =?utf-8?B?cWdZVmgvM3BtamcwMVg0cVhhT0FRWjVYNmVkVEQxcFByVEpIK0ZjRENHU3BU?=
 =?utf-8?B?eHM3NUF1ZTBQaVQ4M0tWZ2txaUZ2RmowWnQwM1N2TGNjcHRERytYSnNjL0Jk?=
 =?utf-8?B?eFFnWUkra1E4cXA4QnZpcXNQV3VUcXNBTkM2Z2VUVThRTTFneUlFMEV6a2tK?=
 =?utf-8?B?K0Q2T2hoMWFZMnRsZnl3cVdaQkk5RGc5UjlsbXBaUzFvN0VQc250MFJDQjQx?=
 =?utf-8?B?WVp2UmJBYjZhYVl0UFp6akloOUlIZ1hwMWFiajR2VjFLVTZFWVdMMnNOdXBq?=
 =?utf-8?B?RWhiU2QzN1JyUkh4cS9jT2QybTNVdWlyeFhTTUxwelF5TFlxeHlVNkhKc2di?=
 =?utf-8?B?L0g2SWxiRWEwa01wSlBMdUp2SDEyQjg4TFlZL3ltQUF0RW1wcTRxYzdrVzEy?=
 =?utf-8?B?ODlKNGxtVDlnQlhRUGFsOHpiVlp4cUIrVDQxOVdRUVptdlhWZ0ZjeUE3TVg0?=
 =?utf-8?B?S25rNE5EakRrTG1vbWZOR2EvRDVzOGYyd3J1R2Y5ZkdURkpiejJkUERUNUo4?=
 =?utf-8?B?cTNldEh1cGJrc2FBSXczRWd4ZjI5YWJYb1E3RUZZam83a3ViTWt6am9vQ3Uw?=
 =?utf-8?B?eE5VOXU2cXEyWVFtTE1SL05GVHpJUG8rNjBJekpGNWdNOUFCQzJJckVZU3A5?=
 =?utf-8?B?SVFsM25adlVqWWhoQkg3VW9GV1NUUjJXZElIZEx4RmZ5L0hqYzRmSytxb2xi?=
 =?utf-8?B?ZlZrUjZyTm9henV4R3VtaTQ1QnRkbmpvSmZHc2lNbVhiU01QeGpRVlBwVVlX?=
 =?utf-8?B?L1BySFowVC9JcSswT0IvdFJKRUtOUktGRU05S1hBSkIwN21iREpGbW04VjdE?=
 =?utf-8?B?RVpGTjNtdGVDNStoWlJIOTlGbzkzRUJsT1NyQ1ZsTGNlVFFqdStLNjlnak8z?=
 =?utf-8?B?UEdnSnpyejZkTWlIN0VCMU1xaU43djRURmgwTHpXMmhKd1JLSTlvYzBsdHFR?=
 =?utf-8?Q?NQLGwdtlSiSwQLsUFF3C/HNRg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 178153ac-f402-4fb0-63b9-08dda552b7c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 23:34:44.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo7cHaRHQc7FRnWUmOxYQnjJgtFc/v4sU5D0ilgu1pTYtqmgQp/opkgVtHC17WcsD5XIB7H6xqtUK05x7iSuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
X-OriginatorOrg: intel.com

On 6/6/2025 10:45 AM, Xin Li (Intel) wrote:
> ---
>  arch/x86/include/asm/sighandling.h | 22 ++++++++++++++++++++++
>  arch/x86/kernel/signal_32.c        |  4 ++++
>  arch/x86/kernel/signal_64.c        |  4 ++++
>  3 files changed, 30 insertions(+)
> 

Tested-by: Sohil Mehta <sohil.mehta@intel.com>

