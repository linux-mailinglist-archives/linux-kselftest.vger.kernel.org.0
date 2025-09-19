Return-Path: <linux-kselftest+bounces-41945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6DB898FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BE23B69AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908B2367AD;
	Fri, 19 Sep 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="az82Dd22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012059.outbound.protection.outlook.com [40.107.75.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8362AD16;
	Fri, 19 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286840; cv=fail; b=UZeifjNWQ8cqV04zzN/0rEjCRSOf+ADjsMAWeNWx9t2EkPLXo4zwxwtoqSu/iDc+26yxeYfTQGfauslTsVgDr4NexDS6yWtWY2tlKoDFCey4XQA7b+hV/RSoh79LcKemTcizEaA+8puWlMMHVahY7LEWWzcQ8ns3dqLeqlOA8v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286840; c=relaxed/simple;
	bh=nbICLxYsb07Nsg/g2T/4wwM4AZ8Jp/AxW2OPBbO1+h8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5p24Jm24y2Lei6Jhz6LVPU3W/ueS3ATwR+mM4BC/SQIRn1//7rI6Kp5AOYTQMYlBlCCK6rV0Y2JUKvnlNJSEBYHkElony3zl+He8KAOi2VFb28jzYZfV4yFRPQcaTILYbGuZYrnAHQcs/16Coam/7vjvt00H/3dnyriWOqvUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=az82Dd22; arc=fail smtp.client-ip=40.107.75.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrddnGM08nlwiPF3zLmqAYSi3+KmM6ES/9tQ/kg1lbHYs1N+h+DjDLjHjf7GKEtPGu6P06QqzbrBGyE1NwvqeMjTQw5z/Dmk3cvaIx91BJtNy4zgQjO9glwzQ88nXkfR5IwYzkVbuxUv0AfmTV1JIRqeIMQ0/1omfUbygLA9zCKhcsPdav3F+NvQhz5Xfpyd+PJtvIimHhgJUm702HEhI4y3VdHK5MueoV/No74K2pRTvavBufQ33ADi+rf9B4m31XvG3VROD+LMfTIRWUKjzFg4oiJPiBWNeskvcQBEoOYKCeDG95QYjwhZ7SuO7dKJMQ9RF7kCWja0b2b4YFju5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcRmDNq6D0i2iIb8V9epm/MxX3Aqzx9heVLAUQJQEqc=;
 b=bjJyEE3hL71hsI1Y29YoQjiXpWvd1M4wcUSuDNtNF+2tXCB/RfXAQmHTuju7l2cTlROHla/IJI4uDJaVQejK0QZoLm5L65N7klWzVdN0pUmKbNFS7LnURhvPIu+mQSU1DWU0qGl3dD6iPGFqU5GkvHJV+fphPxJohjmf8fgQ34rJwUdQFV4zL4C5ppBzZeZwP7PA6nHqMHmzA3qKDJVwc+XaQNpEgC83UctcDuFVsGBxtyQO6EgCzIqyuOOrVYwTxsSUqnWuqZ2X7I9IeILvJck8p4lYgo2GMmMnSk1Mbvcv2MmgloNBcf7nyRv502y/M28q12sDbfQv5PssXYc4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcRmDNq6D0i2iIb8V9epm/MxX3Aqzx9heVLAUQJQEqc=;
 b=az82Dd22vv+yfOlmltWk/DZ5e3dJplNqe94v3keQaCyW4MT0cBsKGG0qgPjMCyioaQjK0alcaJppyIFp7LNfv+eHn7eKdDW/C9U+BVImWvZq/Xbg1xVU/q/jtLLLROXpJQGugsk7pDST0TANt8xOyda0kDqVy/mzfSX91aYUPoG/ZZXkn/bCL9LZP24ibkquGzNBSzXw4E+kobYFAGwHeH5avHWMBkKylj0jj+gbRoXo5ymLqrcghqJn5U5M+G09D7KTNUaXpyqgYHpkgtSe9u30IVPP9C/Q6Nc0zfnUvGYZ0zDlY0/dKkl6fqvXy2njMvhLfQXmhRgBV3HG9SCXZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE2PPF6DE20C888.apcprd06.prod.outlook.com (2603:1096:108:1::7d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 13:00:34 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 13:00:34 +0000
Message-ID: <787f5dff-7ac0-4193-a5c9-5eafa9a7b4e5@vivo.com>
Date: Fri, 19 Sep 2025 21:00:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, yonghong.song@linux.dev, haoluo@google.com,
 eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, paul.chaignon@gmail.com, chen.dylane@linux.dev,
 memxor@gmail.com, martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
 <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com> <aMvHE-iW5eAwf4km@krava>
 <9cb5b3d5-97bb-4165-9a84-394d3d45a20e@vivo.com>
 <20250918113234.3f9e556a@gandalf.local.home>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <20250918113234.3f9e556a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE2PPF6DE20C888:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e93ec4-4418-43c0-3baf-08ddf77c8509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d29NbjRoUHBVTWlYQ29CdVBUSy94c3BtU0JON1VPVG82ZUdzckRndkpnMlUz?=
 =?utf-8?B?cnM5Q3J4UitjWWdyZDJzeDJFWmsxZ2hIVFh3dTZZcGpWaVNsb21oTFdrTHZR?=
 =?utf-8?B?SDZlYzlZM1JVME10RFg3Wjc5YjZ4N3gvd0ozTTk2UUNxTm1oZDl3cE9WenpG?=
 =?utf-8?B?cTcrdWJGY0V2dXR3alM4NndwV2tVb090ZWdvOTJ1bFlvTkZTYWxiUk1Dc2hP?=
 =?utf-8?B?M3pXWFZrVzBqc0dPMHRkbXRuREZSY3JRZ1l5bTQyQ1dXTVJCVEdKVHd0cDFO?=
 =?utf-8?B?UENsOXdvYXg0Sm50aWJad3hva1dUc01uM2N6T1VrQkl5NWFFUHc3R3JHbFBt?=
 =?utf-8?B?VHM5a2twUU0xc2taUWFydnE4THk4RGo0U2xieTZZcmJNWjAwVjlPQVAyL2hT?=
 =?utf-8?B?U0NReVVpbzVXR2svdFRHVlNJbGNKN21KRjVlemRpSFdteDBYS2NYUGlFWThJ?=
 =?utf-8?B?QlArTVFKU1JRTFdvYU5tK1hYb1BSb1BJSUZaZnhrTnV0cWVjaVE0UHMyRHlm?=
 =?utf-8?B?cFpVaUlSMlh6ck1iaTBhMUpsWUdDdGFobnRhenNSZmZhWnY4Ly81OFVFemxC?=
 =?utf-8?B?UXl5enNzNDNqWTBHN3FsU3RkejhkMTNxUFhVWXRWRk4raENJY2s1ZE9HWmZo?=
 =?utf-8?B?akRRbi9pbUZYMXM0SGltOXRJU05rcnBtOGpod29PWGFUOHJZMVNmS0hrT3U2?=
 =?utf-8?B?V2VWMWpPVWRwOGZ1WjlBNE5LK3VtS2oybG92Q0tDaVMzSVYzeXZ0cXlXYTZ0?=
 =?utf-8?B?UlRtbmp4YUFBSmhBeHRSd3owanZ2Yk9sczBVNHBOcXZWOGlOaVg2RHN3ZVoz?=
 =?utf-8?B?dW1CUFRUakNMMGVKckpQTTZ1Y3NndnR1WGpGKzVaVytZOFFXclZoZi9HYzcw?=
 =?utf-8?B?MVdkcXJCMVZDTEIrY3ZxWmJkb0VMSi9uSVZ3aTJPbU9La1QrWmtZWjA0dERv?=
 =?utf-8?B?bnBjVG1ZZDNpVmtuTU1UVUNoakNoczJYalJMRTFPNjZIS2x5eW5xaENXazlo?=
 =?utf-8?B?TEM2NWJ0aWJ0dEJBbHY4VTZJZjdhVTRDbVpqVTRQL1BESGdHTTZaSTZmU1k5?=
 =?utf-8?B?V2hSYXhoUlZMMVdrZEJ4Z1FrQk45dk5aeVNrVG9ZazYvcjd6eGJGMHhrY2J4?=
 =?utf-8?B?UmhZUjRya2t2M0tCUEhIWlJNVTZzb3JGY3Y1Z2VicmlYeklFekJ0UUxtaHFz?=
 =?utf-8?B?MWYrVnFqM1VnYU5PRnA4dWt3N2RWYkV3d1Z0M2p6aXRlaWlvWTdmeFZaZ1lu?=
 =?utf-8?B?aXdiZmJBL2hDVjllQWxWNXIwMmJMdXFLTGlCbFJGSjkrY0M0ejFvN1o4UHVX?=
 =?utf-8?B?ZHhnT0RkOHpLMlBnS2xpL2xCQWgvTXJ2emZIbGhhZTVrZkhxSzFTeEhqcUJr?=
 =?utf-8?B?WVp2dkVhQ1QzajN1RTlweEtxbk1Vemh5YlF0TWZhK1ZTRk16T1NDZm9YcGxL?=
 =?utf-8?B?L0pubHpSUEJnZWg0WEhKOVpNbk81cjFoNWt6UWpYUFVKOWxobDdZZHdpSkhY?=
 =?utf-8?B?TmFtTVRUNFlVV0wvMGtDR2lEOGM5YW5SNnU3MURya3VCQ29QQlpFSkorbFFj?=
 =?utf-8?B?eW94M2lpREhrTFhGVEQrUkw5czZweHhEdzFsMWI4azEvdnhtcmE0a1Y1VmJX?=
 =?utf-8?B?ejhMaTAyTWhXSmJwYUlqTkVLZWU3WlNnWG40ckJSdmkzb0xpVFNPQVhjVitz?=
 =?utf-8?B?cVZYbytZc0hoN1JwZWI0MlFuei9vdG9JWGVWbVZZNEViQ09KNUpYVmhiVjNq?=
 =?utf-8?B?NFR5aUMrZFFTSUhmV1hPRllQbm5JMmZSMWRyYTM2dm0zMERuL1A2amZNdnY2?=
 =?utf-8?B?YlR2U3pEemhzNEU5Sk5GeUhsMFVPb2hNUGlPVUQ4cjZrRTZabTh2SisxbGFG?=
 =?utf-8?B?Mm1KbE5uQzUzUVlRWGRYbzhIczhkUmdkSnlrNzkrZUoyck9RTzA0a1FHRTR4?=
 =?utf-8?Q?BzyQ6ZYTXmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFd1OTNxRHJ1YmhDOXhxZU1kU3RKc3JXK09TR2RBbTJ5ODVlUjFidE8zNjcr?=
 =?utf-8?B?S280dDJpWHZYTy9IV2c4Y2R4WkpIcit5M0t2M3JzN3VmL1BEUEpSVWpPR3du?=
 =?utf-8?B?bU1yZVcyQkpQd0JnTGIzY1oxUE0zMFlGRVErUWl4ZDBnaFQxa0ZVSytFdWd6?=
 =?utf-8?B?UXFBRU9UU0NoellLdHlOQmFnWGZRTUxIMnJqL0U4Q2Q1ZWxBVDl6cGhleW9u?=
 =?utf-8?B?UStwcjNXWGhkV0ZtV0RON051YXFHY3hEejBaS2p6bkY1cW1lMXo2aW9WQ1U0?=
 =?utf-8?B?WlgzcWRyRmtXT3o5Z0pya1NPb2pWbnZpUjJzbkVWS1krWm8xN3RURWFWanVF?=
 =?utf-8?B?a0t5dXV2YVNlSnN3STNsN0ZkNG1aTU1pUndFM0VGRXZxeVE1eWRBUmMrN2tu?=
 =?utf-8?B?OWxZTlVkSG9uVVpIUEx5VU9IZGdtQ1hjUWJ3QmhBODdmMWYvOFZiUmR0U1p1?=
 =?utf-8?B?QlpGQUE1SmhGNnpSTUcxeU1RQ080RlByS3FBZ2ppYVhONzg2UjFMNkNpcXE5?=
 =?utf-8?B?TlFtSjh3MkFnM1FvRHQ3cmF3RllkcnR6Y1pNa0lxdjVRbkZ1NmlHQ2l3ZmRn?=
 =?utf-8?B?anVSMEVqUUd1elBCWFYwbTgwanlIUnhkcHNRcjNMU2RwNXdVQWRXaGJlM1Q4?=
 =?utf-8?B?SzZOMkt4RmFsaHNqcGxQakdpREVyQTBSUENBM0VGN2kwc3A5dUx2YldNbjRm?=
 =?utf-8?B?bitrZlhmQkRBZUdkTW8vbHRuVHY3Q3g0cENaZWtoYjVteDUxUWUxY3RmeTA4?=
 =?utf-8?B?czRzcmN0OTIwaGxpUlNyTHJMeXpZWk04MUl2VWxWY1dGNHdEZEl0TmQ4SmV6?=
 =?utf-8?B?Q3BWaFpaMDN5NmxXK2lMTTIrS3ZBbGM1eVhmMlBvcnJVL09CdmQ3OExrWFVq?=
 =?utf-8?B?eG1SSkJVam1XRG1abTNDcVFIdHZ3L3pmenhyY1VtNHJYVHFpejYrSmpzRVZV?=
 =?utf-8?B?aWwvRWF4VVhPWUlmWDFnOXcrQ2R2YktvSG9oTmM4bUoxS1FqQ3J0cWZncHY5?=
 =?utf-8?B?K3hjMXMrQ1N4MW8rbVVrWFg2Zmp6YzYyL0U0bFVrTFYxdTlmN1p4TXRWSi9Q?=
 =?utf-8?B?T2QxS09Oc3VEdlBMN3QwVWkydTFRYnRUYUt1UXpHaExYUGFQV21lNlg2UVpK?=
 =?utf-8?B?MkxoL05YSm1PcFJIWG1DZmhGL3RSVjk5V29BSC9URjR5RXFtRGN4ZW40VGpl?=
 =?utf-8?B?ZjF4Y1A2b1NrZkoxN3VDTjc5SUxJa0E0SHVXK3hIejIxcG50azF5RUdVV1ZR?=
 =?utf-8?B?YjdkaGlNcnVWYVlDUnRTTUtQWDNpZ2FGc2VHWW1JN2EwZk9NN3VOUm9Xb0xp?=
 =?utf-8?B?UEltWEcwTitJZkwzMkQrNjN4S1NBclFqSHpheVNPMisxTmc4cTlRVW8rRE83?=
 =?utf-8?B?aVBnaElyR21tN0x1Z01JKzlod3ZZYWh5cFdpT2M4ODRwNjlPQzJJUnRoMll3?=
 =?utf-8?B?WGpubkFDenJaR244YnVFZFZFZE5xT3Nha2Yra3Q3UWxYRzV3U0hlUWpNckgz?=
 =?utf-8?B?aHNseElGSVZpdnZwWHhJZjZmSGY1TnR1VEp0azVlNEZXY1psTVRkdHk5aXFD?=
 =?utf-8?B?RGt0NFFKekhSbUcvRWNQNlRMN245TlJBTWNRbUhmVDdkTE9tb09zWDhVUWhN?=
 =?utf-8?B?cmQxL2FtZmZsc0dNN2NMNGVUWDJpeWRwN0xERUErVDFHYUJZWkZLVzNIRSto?=
 =?utf-8?B?WU5XcDlYNkRWNlNuYTZlUFlPUmQ1K2tZZ3FmMFJxTTdhOVp6ZTM0dUNLM0dx?=
 =?utf-8?B?cFZzNm1TU0JUVHlDMU14RE80NXZ0WERxVys3QThlSnBoQkgvQk44Zk5YTWxs?=
 =?utf-8?B?WVVKWmNYcDZJYk5PMGxkTHUxcTJJOEhQdkFhVGdKOUxreHZPQUNxd1pNeElL?=
 =?utf-8?B?UUJOQUl1RjQ5Nm5qdVhVOE1waUs4QmN5VVpzMnhQNVNlVjI0MHA0aDIvWG9X?=
 =?utf-8?B?MzcyUFNCNVBiQkpOYktmc0hLcFVGVDZFV3BmT3pKM2MzNmFHNjRadjMvWTB2?=
 =?utf-8?B?cjZESmc4S2hldWZ2NzFsUDNOMVFzc1Z5UGJMUHFrU1F0ZE5aRXlnRFhHZEpB?=
 =?utf-8?B?QTZQeXF5RkJOZFhzTmcycTVpNnAvNndjeEY4TEg4VDFkOGRuMEkwTHVENnk4?=
 =?utf-8?Q?nQ5ryE9ia+WDT4zl9m97SSIkg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e93ec4-4418-43c0-3baf-08ddf77c8509
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:00:33.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVasHYJWu95iaWaPNN1jqfhjsCmN9BMYuDgrWF+NVr7XKxSTLPb1TgqsrhLNpHp6E2SwQJZBk+OqoGnJsWBkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF6DE20C888



On 9/18/2025 11:32 PM, Steven Rostedt wrote:
> On Thu, 18 Sep 2025 21:15:57 +0800
> Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> 
>> As for the reason not to unregister and register a new callback:
>> callbacks registered directly inside the kernel cannot be unregistered from
>> user space. From user space, we can only attach additional callbacks
>> with BPF programs, but can not remove or replace the ones already
>> registered in the kernel. Therefore, an override mechanism is needed.
> 
> The fact that user space cannot unregister or override the current
> callbacks, to me is a feature and not a bug.
> 
> -- Steve

I see, thank you for sharing your view — I’ll keep it in mind.

Sincerely,
Fuyu



