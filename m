Return-Path: <linux-kselftest+bounces-36448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2984AF77FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471AB5668BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E732EE299;
	Thu,  3 Jul 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pd6Fx84Y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pd6Fx84Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012041.outbound.protection.outlook.com [52.101.71.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E492EE286;
	Thu,  3 Jul 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553920; cv=fail; b=XLPHjusz32/OakN42A989B3HGDRNZcwSO+Rh8WMWwwrwoocRU8iWc+Ri2L1q7xq0uNyH/p1gXwTPXAG7VFIZ7HwfLxUKVamB3dhEktVGwfrkQetiZIu7ltC0+U9ylb3rN+TkUG03sLGaNYzjk3JWztop79fRMzXMGGu3d/leh14=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553920; c=relaxed/simple;
	bh=OkXKt0WKmNTBymQZ7VHl5s7n2Yh7jpgvGXDKT5Zq4Tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OX73bh5/RtuFWtHpTRxyh3J/AhBa9ygAlTMM9Z1Wtl10VXLQmEWwmNYxYvkvCqsOXKBepnkojZKFwETEK8vR2ZlV2DKTjeWshqNMMpfrvcRKOjQnweeVNgPaH30ZnhIpyfkVcXMGQRnQSicEKcUAzxmUJNis4VfQwoJ0v/etXG4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pd6Fx84Y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pd6Fx84Y; arc=fail smtp.client-ip=52.101.71.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=h6rKXJNuraDCs7vmBU8g6CLF4ZfimZ/PzKSDNUTN4Itbme+RbMnd8pWS3PWSVuTP6vpqlwZZJSihgGlhQSKg+4oiift+wn2SbxzBtI89LEaaMEhyyDCVUjoqjlKkBBfta9H+fZy5N9AYtNCEySatOnd/ymHVv/YTXMzRUdK5u+l2SNzyM4wNU2NZ891OJTHSEF6YlQyLkC1qLYBUwcN6GoffsJahbu8bepeAjFLIJpOnPdPs2gnH2zhnwd1Y8mUZalyePRl1LiilqKAJwc/duXkccm0CeVAh6uvw5O322kBKXXOQxjWanmxG/wswTZiNF0pQIAUVKEIScnfUDdXoDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s64DKesQcPo5XGi64N8cFnbbHMjBnUodbu+Mdrc+3hc=;
 b=Tn8xoZlTYU9CC3re6p9a9JnrJhcuD9u1txWnlmaXac8kt9gP3S7V8iiEZ4iQdSOoLkJmX0K7KeqS+jO0KsF1BNXzvhMiH9RuU32bB60EgYYBayK++bmG4OpiYk9mZZ4JhRz+X5uRRj0S41YmyV7JL8SpxUH6IAQOk+jrtH0u+6s4NdVgomyoOWoTvm0BBhXf/EBqVvo3lcOTFHxCmWuDQqfXDFcWCd5ACQ9uEuvP7s9vxP7bKuN2gGDZPNiugpGuTraj6Zx+PVsNs/aisicPaafzwt+fmL7mvWLMWLEbwl7ICTBGeCDfS3NqvQbNuXKwl8X/t2M3nXxMHQPE6DozTA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s64DKesQcPo5XGi64N8cFnbbHMjBnUodbu+Mdrc+3hc=;
 b=pd6Fx84Y6z8Cpgkgd7q8RCCK3aWSsBk8fMMjUYDOw2JqtG25U0kslC1mykBlkXFoLIuuU3NGLB+1YAjKA6wp4bpHtUihJWNWfmtFkZt24BMwJVUDhr0k297RfO7Lakk/+uiM09YbWVIiX7amUm1OzaoanZzN5vJ5qksu1yHohcE=
Received: from CWLP123CA0088.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::28)
 by AM8PR08MB6436.eurprd08.prod.outlook.com (2603:10a6:20b:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:45:12 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:401:5b:cafe::72) by CWLP123CA0088.outlook.office365.com
 (2603:10a6:401:5b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 14:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 14:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwJUzCksEm8tyF18VzVCUSORRYgJsy0Ln4M447TVzykWp6vEUj6McwA7rh1SCDny112fs/VVCG9+BKewT81RR14bgIlVMWW9PJguu1v6TPNW1MH6BzNKs1qJ2nbFkU5bX/l7Xm/FIEVfhY+KZ+soDrftlQT6jlmZ6BLhqGSVMg/CzwvFat38UNG24wNT54IRagYuwHTTyTIo4sWBfrFn+otpu0VSmxamwue7Mg1JLX4H9tNB2LIzLAOXfCLZghgZePvd9SvSxhnFS5kemC3RZmFuGGv+sEa+iTZMJlFuflDqHVpO2ZuWXK+Olb9NkSToC7xLqzPvhRU0FPYIcpqZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s64DKesQcPo5XGi64N8cFnbbHMjBnUodbu+Mdrc+3hc=;
 b=LAtny5HfyttK0Ejsu+bxW5IghXigHkSaP7zQe5FWJYUgpdyygJGIksCvfN64Wj/dWWuGoQe/FUmMW1j7eBn8UdS31O2JvUJMf00BPETz/OenQKYNt18b8Fthv4JUR+4DcT+K/DEpNkNZnj4wwtqEMqW9FYJmwPzCt9uDKtE1YR3VqpyfGYIVS19gdXR0HGeDfmBgiQnSaMzA+EoV+HDThKHXiQ/T8PyPaOpHtm5Kg3KOVl6LkhBC7iQ7faKoMKzUaMu4mDiUAF4jJ0ZpY45ytxOX3zphNcmJEzpQGk7gdyAOK15uHPxiO/85JdeHXv1lfUSav4GkG4bZ1toUt3Rg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s64DKesQcPo5XGi64N8cFnbbHMjBnUodbu+Mdrc+3hc=;
 b=pd6Fx84Y6z8Cpgkgd7q8RCCK3aWSsBk8fMMjUYDOw2JqtG25U0kslC1mykBlkXFoLIuuU3NGLB+1YAjKA6wp4bpHtUihJWNWfmtFkZt24BMwJVUDhr0k297RfO7Lakk/+uiM09YbWVIiX7amUm1OzaoanZzN5vJ5qksu1yHohcE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB8357.eurprd08.prod.outlook.com (2603:10a6:10:3db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:44:39 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:44:39 +0000
Message-ID: <48b7cc42-e5b9-4103-85f2-7a33543329a9@arm.com>
Date: Thu, 3 Jul 2025 20:14:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
To: Zi Yan <ziy@nvidia.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-3-aboorvad@linux.ibm.com>
 <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::17) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB8357:EE_|AMS0EPF00000191:EE_|AM8PR08MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 42826047-5a43-4354-2c14-08ddba40370a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZGM0Q2dabDNsME81RHJwTzY4NTE3eHovbG5qTmdtS3oxekY3OGJTQWdCbnJM?=
 =?utf-8?B?VmRjNUNjeFFqa1BpSWdiTUVDYThtL3BKRnZTTS9xYW43K09RUk45WkJsWFF6?=
 =?utf-8?B?V3ZnNUYvMWxMNWloYVc0NGN3c05NMGxldHNQZ2Y0TlNmNGQ0MHJnS3Q5ekU2?=
 =?utf-8?B?Z01tSHk2QURvK1VPRnc3WVJ0R2ZWMnUzMEN2dmZiTnU5TmlUanltL2ZTNjhr?=
 =?utf-8?B?ZnJRWVd4SjFZb05JRURrZ2ZZNnlSazBhNWRDbWpSYjNqWnA2SFozVzhCZVdO?=
 =?utf-8?B?MVVsV0J0cDFRREVYZHZuZ0RYc3BwTVF1QkJvQVNuQloxUk9Wc3AwOGp5UzAv?=
 =?utf-8?B?aDFuekduNGlxRy82M0p5WW8rTUZkeVh2eWliQ1NUd3FUZnF1OVpzbHBxRmNJ?=
 =?utf-8?B?ZER0Vm1ZOEhDQmt6SkRya2tlVGhxL1dpUXJYei9yNENMWW13UFRpSjBqNXRx?=
 =?utf-8?B?VG55OWp3OEYyYUt6R3Q4cjBudERZdzkrUWZXay9oZWRKQ2lhRm9xR2JFNGtJ?=
 =?utf-8?B?NTY1OVF4ejg1WG9WbHJ3MWlUQUZUMFhZVzBSL3IxQkxMMFUwS3RrU0ozTjEy?=
 =?utf-8?B?c3RvRTRWMGR3NDV0SjFOYUFLZmg4cE1jRGNiLzdFcTZnUkozb3JtQmhoV01Y?=
 =?utf-8?B?SWxBa0hxSkxIMTZpODBXZ0Rack5vd0h5TEFMSWp1dk5mbkNJZGVLT1gxd3Q4?=
 =?utf-8?B?RDhxSmozZ3VZR2k3VExoTFpjblRUY3lCV1B2YWVwY2dibHJwYnhuWFJ4eDVz?=
 =?utf-8?B?VXAra3NCOHIxYlh6cVRJZEljSEd3T0Q5KzRvdm1kSVoyME05R0ltKzNOT2Uy?=
 =?utf-8?B?OHlpTDNDWVl6ZWxpNUc4UWpySmhpd2ROKzM1bXVieHp2ZGpITGRIbjVDazlB?=
 =?utf-8?B?VnpGSVpyMklKTEJ4RVppbmxHOFhaa1RTcVJxV0g5emFGWFIvbUJqVlJQcjJp?=
 =?utf-8?B?WHNaeHROMGhuM0c0WVlTMEdjQXl4dDhRRTN6ZDBYRWNBWVVvRldUcEdxcjB1?=
 =?utf-8?B?MUcrU1NrZDR6aU8rRTlxWlN1eHA4eDZuUVhocUJIVkJGcVZhWitVYlhkOTJV?=
 =?utf-8?B?WXBMdlU1QjhIendiTkVlUXlzdHV2cnRielFiaDZtUGVJclBBek5aMDdMeGg5?=
 =?utf-8?B?eVpDSHB3K0ZtMm0vV1l1YlpqN3AvWFNSVE92VTJzK041RFYra0FZenpaRHZP?=
 =?utf-8?B?S1ZrK0VZa2tDL045N3B6SHZqWS82TVFkT0JCbnQ4VEZEU0g5V0E1T3phV1cx?=
 =?utf-8?B?RzFGWUpSWGhacytqU2tCbUtNeXI0NW1zbFl3K09kSHQ5bUtodW1IOXlUZUNC?=
 =?utf-8?B?L3dhOGc0T01UeWxRbUVwbUNtWXBiRm8weGEvNkZmMENYVzJsZGxzbjJQNzBO?=
 =?utf-8?B?WG1qeUVwNzB3bTV5UmQ4UmViTnBKQ0w1c1lpbkFlQ3EyUEhZQmlpYU10d3Rl?=
 =?utf-8?B?QTJLelowbFN1Q3BvRHd0RjVZMTlrMC9hSlVZRzRiMXlmZ25JMU9XRnA1RkhO?=
 =?utf-8?B?aGl6bVNWbE9BSno5QnVoTlBIRmNQSzVzem03T2RzcENGWE9HNU1PaCs5ZDFY?=
 =?utf-8?B?Rjc1ZXBzK1VEdHZOeUFCOWg1V3JlRmUrQ0hjRVZlQlFFQ0F0bmQ4K0k1aVJ6?=
 =?utf-8?B?U2JCVkVxLzJURnlNcGpHMFFWcjdLTWtCRkdRamZWbVNsK0VLbFBGKzRyWTE2?=
 =?utf-8?B?eW5VVTQ3LzFnU3JkVUlLTmxSTmdnODJ4QUMwRW5WeHVvMzRham1YMjJHWHpj?=
 =?utf-8?B?bUJ4SlNNRXRnZ01mM0pBTCtJaGwrUjZNZ0lrbVRpaDZ4YXJFMkh1U0h0MERQ?=
 =?utf-8?B?a1VpQ2JUNlVraXU0Y0lQT2ZDR05WL3AvSFpGMXJTR3JuRTBQaU5jbEhkSnhQ?=
 =?utf-8?B?UDJzS3graWtJRG5PWi9BY2FEYTFNOUlRaXV6elFJVFJqank0U0RsV2VIbFpO?=
 =?utf-8?Q?PxHlY2BQ1/k=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8357
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4ab08dea-e68b-42f0-4204-08ddba4023b2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|82310400026|35042699022|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmdsZXlrelhKT2gvN0tsdFBlck9hN1hjUEcxSTF2NTIrb1ZhbG56UHphRVRE?=
 =?utf-8?B?U1Z0c2RGcktwTmRVcCtGcW83d2tqQzVIRVVkaHd5MFRaemRxL3ZyUlRkOENy?=
 =?utf-8?B?VHJKOW0vUUlTeXpETWJ5WjZIRkgvQ3hjYzlSQXNVTlA1cERScDNCS1hyN1VN?=
 =?utf-8?B?dlA0N2lVUGNQcWNiV0xBZ0ZQcEJzNGVrZmgwelIyeWlUTWZPT2Y3ODdVTyth?=
 =?utf-8?B?QjlJZXlBMFpPUi80bkNwZTkraDk2K1hpak5iSlBPdzZQM2gvWHpac0RKWEJt?=
 =?utf-8?B?NDEwNW5icEpNYXRCRXlOYW0zTFl4VXF1d2YrZkdYVEhFRXl5M2gyU09yYWpF?=
 =?utf-8?B?VHp1TkJFaTRyS3JNemk0UEJhOUxQSEZOR0xFQnpsMjJYcjNacXpmZ2FGdDhO?=
 =?utf-8?B?U2FNSXlmRndROEZKK3Bqc2hhUndjRnMzWHRBZ0xOVmxyeFpPaU9lYUhZeTlF?=
 =?utf-8?B?OHFycnpNN0t0KzVmVlhwUzhsYzM5cEFRMG1FeHFmUldCYzlJMnEvYzZlbkg2?=
 =?utf-8?B?UVdDdHdKOWhFdTlnazYva2Y4ektYODNOeXpwdnU2ZEpmTkV5MWJ4aEJoS3Fw?=
 =?utf-8?B?ZS9HT3Z6eCsybXkwRlA4QnNHMDRvdFhZNXkvMStBakFtaCs5Y0tHeTVCUnpY?=
 =?utf-8?B?UDArUU5adXJXVGNVV0M2RWdHWWJQZzFJZDVZdXQreTZuaS9CWUo3NFFrV3k1?=
 =?utf-8?B?Mkh3WWx4ckM2ajBTK1VVYXQrTmR0dXlsU3krWDJaVHV0TU5mSEpZNml3R0t3?=
 =?utf-8?B?VG9FM1ZqQmxWU2NobUowQ25tRDQ3YkNaV2NXQmltMmtvVlpQOEgyYUlFVUs2?=
 =?utf-8?B?RXUzbDBmT1FUbVFXZ2RZUlVHcGRTd0p2QS9BVi9aRlJzTkxNNThaRGJ2Mm1L?=
 =?utf-8?B?TlRYUXdPN3lVME5KV1VmazRrcFZWWE15dGhObzFKWjI2Mkt0dEJIamxFNCs4?=
 =?utf-8?B?ZTVPa24waCt3ZmFkdWp1bmtRZ2ZINUNwNDlFUkZRTENFUUNBTzMrWW5NVThh?=
 =?utf-8?B?d1Q3cjk2RG5MOERLekRtMy93eHdiOVN4NTRWYnl5dHo1STlLaTFRTlR5aENI?=
 =?utf-8?B?aVBhUXY3T3publRiN1ZQQUt4c1Njd3FwQkVLQkpZdHlIbFdxc01zVk11OG92?=
 =?utf-8?B?VE80bWFVeGJqZXh0ZkpXaUxTVUlubG50Myt5Rk5qYmI5STBWT0J1TEw3QXd0?=
 =?utf-8?B?NU02bDBWMEJEUitFMmNPZy9rMEpMYWlUZU5zUm9Ja2xJVWtQOVdFT2IzQU9h?=
 =?utf-8?B?Y1JvaGJyL3JyR2pPZVVZSzdVbVZvSjh0Z3RHOWtha0lQdFc5QzZuUmZzMk1Z?=
 =?utf-8?B?bmVHS2tnN29wK29iN3ZLdUVjbnZaMnVLbE9sNHp5dXRHaVRDTGtvanl4Y1Rk?=
 =?utf-8?B?OFZYZnB3dXA2cys4MFkySStnaEhqY1JUVTh3czljS0QvMG1pZ2ptbTVNa0xU?=
 =?utf-8?B?bHlrS0NVTEd4dHVYTzIwWHJNNTd2dmtWN3BEdjJFczBxd3k1UDBjcDUyL3lU?=
 =?utf-8?B?VmgyYnBVaW1mMGg2L3Zkb1F1c1VjVGlxS3VibGxnb3RWOWtJU2UzSnpPOTYz?=
 =?utf-8?B?UEVNMlRMUHM1bWNxRnEvUmY5WlBSU3lVbU5lYWJzNFVITmFaOU1HU3ltQm5q?=
 =?utf-8?B?eFVORm1VQVJmOGtjSDhSUVc2WXB5L2l4UnZNKzRBaG9FQkNLNE1pdE4xNklx?=
 =?utf-8?B?ZFZmbmtHNjhDbDkvVTlua0J1aXNHTXlBZjg0TW0vancvblRNWE1IQmRSL2dF?=
 =?utf-8?B?dFNqSnZySFFhc0E3OWNBTTZXSFNtVW8yWGJySmdBVDQrcW95L3RTQy8vRFZR?=
 =?utf-8?B?bGRJZXhaNnNNMTNweWppRDNTTTQwYmEwZGZOc0Rma3hjZ09UQUpWRlkyd1N0?=
 =?utf-8?B?SllqR3RpNHUzVHdsN2dOWldvQmNIcjdwRitMRkNBTVNGUUpVSzI2cnFZZ0NF?=
 =?utf-8?B?QXFHUGFUVXdITzFxZUxEdVJWZ3lkUjZXcGlMZ1lxSmZuUzZmSThabXJJZTI2?=
 =?utf-8?B?ZFU5Tyt2VnVJY0NDc1h4L1gwOGFwNUhHdkFleXJrU29kL3NPcnFsR2tjQ2hn?=
 =?utf-8?Q?QMfA9l?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(82310400026)(35042699022)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:45:11.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42826047-5a43-4354-2c14-08ddba40370a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6436


On 03/07/25 8:11 pm, Zi Yan wrote:
> On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:
>
>> From: Donet Tom <donettom@linux.ibm.com>
>>
>> PowerPC64 supports a 4PB virtual address space, but this test was
>> previously limited to 512TB. This patch extends the coverage up to
>> the full 4PB VA range on PowerPC64.
>>
>> Memory from 0 to 128TB is allocated without an address hint, while
>> allocations from 128TB to 4PB use a hint address.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>> index e24c36a39f22..619acf0b9239 100644
>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>> @@ -50,6 +50,7 @@
>>   #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>>   #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>>   #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
>> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>>
>>   #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>>   #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
>> @@ -59,6 +60,11 @@
>>   #define HIGH_ADDR_SHIFT 49
>>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>> +#elif defined(__PPC64__)
>> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
>> +#define HIGH_ADDR_SHIFT 48
>> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>>   #else
>>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>   #define HIGH_ADDR_SHIFT 48
> Could you also update the comment above this code to say PowerPC64 also
> supports 4PB virtual address space?
>
>  From the comment, arm64 supports 4PB but its NR_CHUNKS_HIGH is only 3840TB,
> whereas PowerPC64 here can get to 3968TB. I do not know why arm64’s
> 4PB is smaller. ;)

The border for high VA space is 128 TB for x86 and ppc, for arm64 it
is 256 TB.

>
> Otherwise, the patch looks good to me.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Best Regards,
> Yan, Zi

