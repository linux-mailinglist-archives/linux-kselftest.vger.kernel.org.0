Return-Path: <linux-kselftest+bounces-26177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8175A2F05E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2011188294F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C22230D10;
	Mon, 10 Feb 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Fe6d9U4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020106.outbound.protection.outlook.com [52.101.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C6204860;
	Mon, 10 Feb 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199200; cv=fail; b=kmnSigKiA63UmTzsWg8kn67d3R00abocKQVht+GBgEc5O8ZHSeBID52x2ciaJLLlmq8KMTY9co270D7EsOmWJPhBDKboLkPObfCo3MuSuHX152IWxPCUtUG4MeEfxCG1G9hBoOWaOREx86MpBTPwRuC1ijUdCQI/fvQxtZvGlew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199200; c=relaxed/simple;
	bh=z4101rnXN1QxL0HUFeavXfIXWNfJOpPXlxLuZLjUWYQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZNBuprYrhOE6Fy8TzpCu+NixSZ4QGJ/nyE0xGKhAsSf4T2+9U9mqAkCGs+0PQUofYwNcmDzjED7RdxBka9KKuBoQhomCvTGwLjiiTgzIKZAFneoDu8lsCaqJHKD4aISs+M9eMXRbp9ddmEoJWBiRf6VfNmidQ60gU2R0GtgKdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Fe6d9U4/; arc=fail smtp.client-ip=52.101.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyfNCaSZN9Qn1qZNQH2y+xJdXbZt0QEOGu4n4OdWhERcck6l3Y5m061F7vw3NNsR+87lB94zvGHhCISHmjCbN+jq0vtpNzwfjZ6EonBBIp2zUk5ACUjdENW92G3dG/gS1OWdgGtfg5ridzi/L/s/ebcXoc5lzVZYPKjqj7B3zYRoF/BbtWdDVR8yZvmSe+IBtDaAvpDrA46iXRIZzMZbqTUGXeZKAeOk6Nc3fquVy5m2ORYl6emo6d1FhcZoKAOVJBSyVJpxz7tCGfKpvNafB8res/X3gGE7RGrjui2WXITgJUIcGkJ/qOu4luLXWvSAe+veEs+p+bPMj7Zy7pa/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZFW3KXztCACWLPFGbX3yQDZIhAWf4A5ZsjruxIYapE=;
 b=BVnE9UbDyO/mYlAYZ+PalqGWQF1AZAGipTgU5c+xvm7UESNqgSmiVFnO/HcBpr+0YjsgyidbZQ+ArNbS8o7WRcplvEFTgLcwM7CLeiZIq8r+oyBXhd8d92qB7kXXrBI6aFlaQgZYOZ7GJYwsrwfH2JnHYNhNqHaTzqXrkEOKYa4Tt6jS8Xl5bQnzR23gGTmdWEd6I7knz+kSc2ZONd348qwa1eUXAOMLEB4pG7N4MV0mXA8FN2pXolIyNjjkVOhbIHrJ5/HtiGacwBLdVdNEqm9t/CD0lQ0Uiclqtwd6EAT6dAvwO34B21vRPDyxPkcN6XKdxy8gv8qwVgIqorSyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZFW3KXztCACWLPFGbX3yQDZIhAWf4A5ZsjruxIYapE=;
 b=Fe6d9U4/+fbJeFVqPKRGbIm4KVLIYDgLpHmJa0LGFGAoDpok7JzSpiAP9UurpdAv+Y6v7X6c8gwKFpgnG5Ph5JsywC9/2gTP/tEfQnoiDVBwIQdDU4koRLPITwK1g6r9PpBONYs9PIjCenGq0on8m0wM1xKDpY0y8y4lvF9Hk8xSP2DfoQ5o0ECkFrfz37JUPL22a1IxQSkFsRkU3DkN/mJwWkorMzXhXLQR85LsTPx5zlENSvi1MmKJWNmZFhODffWcLwpSzxVYUiEio23AEO+O42N1oWgSGPzFgUIdNdm09bpp75jKwkYjxu3GbTQ171X51WidjEqESHBFPkzFkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFDF5E99EF2.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::494) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 14:53:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:53:14 +0000
Message-ID: <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
Date: Mon, 10 Feb 2025 15:53:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
To: Gabriele Monaco <gmonaco@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250210075703.79125-1-gmonaco@redhat.com>
 <20250210075703.79125-4-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250210075703.79125-4-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::30) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFDF5E99EF2:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b38b28-d53a-4a4e-8516-08dd49e2a52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNvTUNRaGxGdUdVN2x4M1NrRWpBc3N3eWFrR3h6RjlYbDk2eWEzWlFLQUpF?=
 =?utf-8?B?a0VkeWNDQ0NoWE5ENjBaUHIyWWZzY3A2OEU4R1ovMzQ1bjZZamxlM0JwR1Ra?=
 =?utf-8?B?dTB3a29ack9Bb0x3VjQxdGhObEJqRHh5MTlrUjBmbTUvQkZWUVZHRG1oK0Fl?=
 =?utf-8?B?bDNuMkJzb1JacDRJUi9MREpOMlpYRTV6SzJ1NmZGM2RmSFN6SENqVWpOZHpn?=
 =?utf-8?B?TlF4eFlSV2E4NlJ1ZGkvckRKMHFYVk5pYW1GS0JqUTBDczFGWVZDYTNpZzJY?=
 =?utf-8?B?Zi81Q1RraXUrenVRS3d3cCsyRFBucVlGSmlPWUhQdXJLMEdXQ0RCQk16ZTVW?=
 =?utf-8?B?bkpBWFhaaWlwdkpXc1hLdTlZcVNGY1ZLK21SRXB6ZG92TWVvcm5kbE9ZaGgw?=
 =?utf-8?B?MlNWU3plenk0NHloNlRyVk1aN2JpdlNvYWhDSytVdWxvc0o4ZTV1L3hWemVE?=
 =?utf-8?B?TCtCS1hjR2l3Mit4SEZzVjAxZnp0NDBhb1phdnYvY1JvajF0bkkyWWloQnN5?=
 =?utf-8?B?dVRSSEFBVDAyM1BTVmFjcTFDSC9tWm9BR1FSMWs1SGkzbU9VcEl1T1BqKzlq?=
 =?utf-8?B?ZDViR2Nid3dsdkRVdE9aaTkvRXcxTVZoUldZTk1TVk81UGh5RTQ1YlV4bzNv?=
 =?utf-8?B?M0ZjRFh0TUtNVS81ZnJsWXhJWjNRdEpFWG00ZjBXalNZUTYxaXNkT3VkTmlZ?=
 =?utf-8?B?d21sUm8wbUQ2eFB1Vi83Q09LK2YrdHk1MzU2TjRZZjZjRkFSNHYxRGRaT3hC?=
 =?utf-8?B?SC9HbWNuTFcrRmkxSG1HSEt4amc3dmtuL3JWaFRRV1ZtRFIwZm1MZDIrRE5q?=
 =?utf-8?B?bHNkQmsycjdPWnF0ZjJrZDZMTFFYU0RIR2RDK1A4RUFEVGgrU2pWd215Y2E0?=
 =?utf-8?B?aUtOMjhVVnN5SXN2RmcrdWYya0p0RlVkZTN2TmxQaWIyWFgrcDBGSGhiNEJq?=
 =?utf-8?B?WkVnNFFteEZ1YWlEU0VhN1M4NklSZ0RtNWJHOFVoVzdaWktZSXJyYjFVN09C?=
 =?utf-8?B?RTZOb3Z3cTYvTEp3ak4zN0d5Z0J4TjV0NTVpVU1xa2F6bCtud0EwaTUxN3cy?=
 =?utf-8?B?cUIwMjRWaXFrTEloUE4rV2FORWVaV2RrcXIrWU9mazBtQUFMaW5QZ1lrN2JI?=
 =?utf-8?B?SXJZc0dGSHE0ek5QM2J1UjBKUnRKVGhvZU5IQjhxT3V6RXhrOUM2VHpaSVNv?=
 =?utf-8?B?Z0traVo4Vm10KzlvTE9GcXhlbkNEbERudEc4VXlEbmtaRmNzZm1iWFYzYVhn?=
 =?utf-8?B?QWpxNTQvcVErQ0lEZTE5ZW9vUDVNSENBOGJBZ2RKcVlQTDJPSFlQOGhNcWVM?=
 =?utf-8?B?L2xKbTFBSGxLcDZ1UE1Sd2E3SDcvVzlnWWM4SjBoRi9TV1hmdXlaR3dNd2k5?=
 =?utf-8?B?TnRGS0RUWlFoK3RsT2ZJckdxejdpQmE5OEt2L2lLOWU3Z1ZxUHNGZ09Wd3Js?=
 =?utf-8?B?Rkg0cHhHMisyNXNnbHJSanN0MWMydnl0MHEzQW5tZ3NmRWcyQ1lqUjJEODlY?=
 =?utf-8?B?aUFLZjJPb1J3VmFkaUFNNmxRdkJPTlNvRkNkVmRBbkFCSTBpbVU1WnVDSVk5?=
 =?utf-8?B?MDZZUVY0RC94OGVpZSt1ZTRUVUF4QkxBeDBUdy9jdXNMRUZNM2hhakxVeXNw?=
 =?utf-8?B?OXQybkNnT1hBU1NZeXFNUlRwRHYwVFF2d2ZMcCt0ZDFxUHkvM2twcTIzRlhI?=
 =?utf-8?B?K1ZxVlhoenIwcXhhZW5saGlnZk9kTnovOGhySHBSVTAyRlljZTZpZ09KZEY3?=
 =?utf-8?Q?y0b22tbjwKqiRrs2pxXDWYBZwQfoVQ/Zyd4sRVV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9BL2xHYWlpTVZpbERMR0FFNFd0VGwxRER3WFp4YkM5RDZzSGRBY0dzeG9G?=
 =?utf-8?B?ZVpaQ21ZV2t0MkJ0UWxRVXBpNzNpczN0N0ZjR1JZTjJUREI3S2FhSTNCVnBG?=
 =?utf-8?B?VkVoKzhzZXlsNnNzNXI3QktidEwyN1htcUI0TVA1SmU2dG5XaVlWR1B0dHF5?=
 =?utf-8?B?amZ5YXVKY1ZDL2pKRVJEaG5YNG8zblkxc25weUthZUxvS2JyMXFJY2xES0FE?=
 =?utf-8?B?WU5BSkw0aTd5YjRZdUVLWnRhSmNqMUpmbEN4akdCai9lQ2tOZ1p4OWNCV2Vq?=
 =?utf-8?B?VUxpQnp0MWNuU3l0djhkbUNpcndwTTRUVmwvRjhPQ0V0THRBanRiV2tYa0RR?=
 =?utf-8?B?cU5ZWG11aXN2eUVwcjZaVzNQMWdPR0tUSHdzUFRaYVQvb0JOQXZWZFVkdi9H?=
 =?utf-8?B?VGVnYXhjT2E3aXRId1BCS3N3cDh3Y3J3eFl4T3NyM0NaR0pnTWExQVFHU0lL?=
 =?utf-8?B?bWNzQ2ZsQjFaWFNOLzVhcWRKcFNJcGtOMVhXbFdMQTZBM0t5MGxPd1hQQy9n?=
 =?utf-8?B?TVNLd1JYRHNYZnpWR3dNWlNEckY4VEdQTW9YcmpnV3NwNlpEVFhPbGhMbkpL?=
 =?utf-8?B?SHFPbTZLMFZ3NkRBamxlZzdYbEd2NERJNXF0QnBod0cwNzVXeVZBMXU2U0RI?=
 =?utf-8?B?RHAvZVlBbmlXQW00SXdGWVIyU0ZjdUdkMkdjVU9iT2RiM0NWbFBobVJwR2RP?=
 =?utf-8?B?Zi9UME92dW5rRjFpOERQbEpwaXJLcU9zWFdtYUowQUZLcE9obnl1UWR4U2N3?=
 =?utf-8?B?alFpSkp5bzBWNEwyVGsvUklDbi9NYVhhOVltSnJwVmZ1Mzc4ZTNKWWpRV1RQ?=
 =?utf-8?B?SkxaWVpVWGZUQXRqK0F0enU0QmFnUEJQM250NmR3Nk5qMHFDMHU5WDhuRnNv?=
 =?utf-8?B?SVVoWFR1VTJLdHplTnYvaXdFZEZSMC9SczNJOTRSaTFrdEhJVkRVQy9oM3Nh?=
 =?utf-8?B?VFVQNlJLRGxick5nTmxGZUtpaUlrL21YOXg4d3dzaFMrN1JSd2trKzR6Si8r?=
 =?utf-8?B?R2pqeGI0a3NzanFWcTd4ZXloYUZrclA5ZWdLWDlkck9mK01mUTY4bUxRRjRn?=
 =?utf-8?B?dTBiZHdJYWVOOXQ5WmZLNTdKbjBpKy9JeEtNc3lET2N0YzB1MEJzYnBGWWdD?=
 =?utf-8?B?QkxvVWR6RzRaZGN4blRJVUt5WXVsNmY4cDlLL2U3dmtJVVBrdjQzR3ZEZHg1?=
 =?utf-8?B?Smhmdkc5dHZBeEs2L29hMHg3RFR4U2FhajF3SXBUV3lQQm5iV3BpNGsxOTBw?=
 =?utf-8?B?NHpXU3pjUGhnZ1lINkJZUm44SnZIQjM4dE5hZVVsTURQMWpmcFNnRmN4SG9D?=
 =?utf-8?B?ZWxrbllCWTZVZjFLNWl6clpxcTBSZ3hNWGM5MEhVRGNGUkxMblNZY2xJOXh6?=
 =?utf-8?B?Zi9aS3B0TDZtZE1YV21yZnBkRjhJKzEzODk3VVFRaEVabUNrK2ZvMTdMSjdU?=
 =?utf-8?B?OGM4c0NQVGJrSHdLcVNGUlhYQUxmMjJSWlYwQ0d0SnQzRzV5Z0xYckF3Q2d6?=
 =?utf-8?B?b0lYeFdtcG5UVnFCREVmdkZ0ZlVnRWdDanVUZnQ0QVhnRTh2UmtTV2N2SFJU?=
 =?utf-8?B?aDl2dU9QYmcvTVg2MGx1Mit5cDJLUnlqOTlGLzQxUTZwRVQ4NFo3bFM0K25N?=
 =?utf-8?B?akNOWVdWUmN3dzZiRlhGSU9yd1MyK1ZNcGRZU1U2OElTK2RtUXZxeHRFRUsx?=
 =?utf-8?B?bkRadTdJYVRPQlBJTlg2Q2RFWVVRQWx6VDAzRVg1dzkydWkwRHZ2WXBlY1dL?=
 =?utf-8?B?Qk9nNWlOODd3RWRmVklsU25DMGQzZjJuVEVZNGhoU0pwQjVlZEdySFBpMjl6?=
 =?utf-8?B?ZWJpQnZBZHBpRzNXQ1NzNWVFSzFxZXdrMW5MaVJWcmg1R0NGWkFGT05DSzJC?=
 =?utf-8?B?OXFJYVZVeFN5WjlJdGtPN3hFVVA4Q2xaYW8vUXNSUys2WHkvbjZwQW1adjkv?=
 =?utf-8?B?SkpvY01YWUF4N1ZXNldLY1ZrNHBTZjhrNnpLQm5jdnFSSGFyZzI3LzNhMDNF?=
 =?utf-8?B?Y1Rhc2FJZkRpcHBpaTF2WngwRzFjWFF6V0VENHVoaHNMelp1dHBOZlk4RjJi?=
 =?utf-8?B?cWU1b3NlUDJ6dHhRdXFUblVYOWk5bm0vTkl4K0h1Tk9HRWhiRzJzbXVCb1Bs?=
 =?utf-8?B?dzM2VktqWDR2V1hsK1l1YzlBdEorUzN1NkU5bllEQkhtYWtBY1p6cXhFNTZU?=
 =?utf-8?Q?hMZPGAWK/etJ9s5zxCmDD8U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b38b28-d53a-4a4e-8516-08dd49e2a52f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:53:14.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Kcyzwz+9/IWZj8Jko2R1JaQl2fQnAJwpQ2xppxQfqI2xKztKQMXS/SQ5woIWJmlXyH23TkdEPGqAvMVLCDOO9tuCJSTfGeR+oWkKdKlYEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFDF5E99EF2

On 2025-02-10 08:57, Gabriele Monaco wrote:
> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
> compact the mm_cid for each process. Add a test to validate that it runs
> correctly and timely.
> 
> The test spawns 1 thread pinned to each CPU, then each thread, including
> the main one, runs in short bursts for some time. During this period, the
> mm_cids should be spanning all numbers between 0 and nproc.
> 
> At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
> is selected to be the new leader, all other threads terminate.
> 
> After some time, the only running thread should see 0 as mm_cid, if that
> doesn't happen, the compaction mechanism didn't work and the test fails.
> 
> The test never fails if only 1 core is available, in which case, we
> cannot test anything as the only available mm_cid is 0.
> 
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

tiny nit below:

> +		usleep(RUNNER_PERIOD);
> +	curr_mm_cid = rseq_current_mm_cid();
> +	/*
> +	 * We select one thread with high enough mm_cid to be the new leader

Missing punctuation here (...new leader.  All other...)

> +	 * all other threads (including the main thread) will terminate.
> +	 * After some time, the mm_cid of the only remaining thread should
> +	 * converge to 0, if not, the test fails.
> +	 */

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

