Return-Path: <linux-kselftest+bounces-20145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E49A4267
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34331F21726
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4D202F7A;
	Fri, 18 Oct 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5N7uKKo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cDUf6zDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A7202650;
	Fri, 18 Oct 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265519; cv=fail; b=PlaEth5HBPHAGrmz0IVIPDi2tMjg1uAMH2C3Tjj38yi70QFZ2Hp0JAeORzdeNrDNcE73TZMDpoNW3TkylvhTtN+ztmLbJvfAsnmpMsHqLKXrCDYPLpiUzd9EWu7QF2Tvi8DWfkTlXYGA7fIn+J8294D3hGl27J1HhmBQRFc1Cvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265519; c=relaxed/simple;
	bh=7VWIMEFyvNIMKPBqRlcE4BrNz/UGeISsVzPkjvGiYz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWAw/nrzLsY+b9TtAnar8nOzQSK+gvdniexaC14VImxm89Zzsn1kOB0+cGqKaiUapFMr2xvGM3/CkmjCYLDCanQoKHo27E204tBzhjAnQermeL4nZXPR3QJcKjhmYsyDaBWgf4y36ena7zb0RvM9C7QLSYNNwSPdUowLiaK3dpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g5N7uKKo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cDUf6zDc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBbYs022657;
	Fri, 18 Oct 2024 15:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7VWIMEFyvNIMKPBqRlcE4BrNz/UGeISsVzPkjvGiYz4=; b=
	g5N7uKKoHHIbVbou0Fy99thCa1Wu/SLtJPLlQxJ7Ok5lXl0rXOh6j/SecLzDiE4I
	oG558yXkM3QP75RR+3vK7+Mk5yITRz4Ql5UxAUhe4ZnzF2x02fRT8a1df/ikIeR9
	YHaPBK1RX+xxugiPhdiip4N2xXasb2DqNn21mr5s2hAvqeU3+Rfhp5gBGJNY+7v6
	MyP23cswXw0ipGGUFToe2Bc+GLOUnXwTB3tqqsA+UoE5cNhvhgyfa0HV4gQbHF7l
	/CyUoWwZVVEZPBmFX0NcCxuHrvlXTnmw13wETBPGRdof9i+PYah1fHBvI7GziP7S
	fhuf8aD4O4uRRjhoCSfEJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5csjpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:31:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEDQVm027182;
	Fri, 18 Oct 2024 15:31:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjbpxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdQ/JAlRgKW14rS0kBWEbolMta3Z3Wcbyhg7unBqcjikoLHTzV5RSdifCsgWFLqumocfTXWQNrfly6Jh315N2dIfMpZHNS5uDHE97wewY0UMBUTSdYgWoeWNiUyBceL3wXkQh2xQdqgC5zXGQq+5qC8k3B7DBn+UK2/h2TQY8Li0BfB2MO+byA/2sq+oF2c1CpWm8r9HNgIBAs/S1KRZQ/fk62VBBfnXThKdKPlF4vJCGxoKTvPmgIbD04YDkYENRsahwiTzND+gm2uUvPkuOV3ink6EObar60Sj9/Gp3Ux6v7WTh6Hw+ECjy7EKxh8oD74CiVFZ031vqn/ehnClPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VWIMEFyvNIMKPBqRlcE4BrNz/UGeISsVzPkjvGiYz4=;
 b=fcScbPEDdMbQyEvGbAdTl4IxIXJYUW00ffYvu/gD+Zm9m1Oh7sOQ7xZq9tIQo+AMxvvGhS7ooD5RQJVT/1bft3NVw8ywIti1nDwfIjO3gicDBQTcccV7wwCLFffxjNZN2Alq00OAi1eOa4XQuiVyMEnrw6DUhDKU4xKikXDBAEGX6qrPR7cmzmhNZqBF38ITfH/v9Cvd6Q2em091zV9CcAGVsWD7VlzrYbrJWnmIM2dx+ar5EsEkAfvJ+knsdfVJf9ybdo2OXkasDmnaqpuCxvUnoW2Fi7Cl8+Cis7hgCwjN3Vorh/Pp6ve9PEqISQBDBU4t/LLlZANPXuIFpK0gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VWIMEFyvNIMKPBqRlcE4BrNz/UGeISsVzPkjvGiYz4=;
 b=cDUf6zDcYMcz5inYfJdOeF+upz8FzCsGdw8tvcTQ0KFJFKG2N51g5hagNKGZrO8PpcWH/ILjUJyvG/zeRhdHhIAhu8lBHJpRJrV1Ovda0qqxRYlkgpNma6VQbnWumdMzIo+DbyKlT2tnUKmr/berqRAIEZCwXOppL0YgkmKV19c=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DM4PR10MB7528.namprd10.prod.outlook.com (2603:10b6:8:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 15:31:32 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 15:31:31 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com"
	<vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v5 0/3] Threads support in proc connector
Thread-Topic: [PATCH net-next v5 0/3] Threads support in proc connector
Thread-Index: AQHbIMByQZ27YszgP0S1ru3QPhWgNbKMRJsAgABfcwA=
Date: Fri, 18 Oct 2024 15:31:31 +0000
Message-ID: <2A147599-3991-4157-886A-68FA60B71EB2@oracle.com>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241018094942.GE1697@kernel.org>
In-Reply-To: <20241018094942.GE1697@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DM4PR10MB7528:EE_
x-ms-office365-filtering-correlation-id: db1d6edb-7973-49d7-7223-08dcef89f128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3JqUEl3WEU4M1FDMTlOZUM3U1dNdUs1VDl1ZnJtVmNoRDRseC9CaGtMVVEv?=
 =?utf-8?B?SGQwZUdyTXIyZ2NRdmNXNTNwV1Bxektzby8zZXkzSXp3U05WRTNVVE45NVNJ?=
 =?utf-8?B?U3gwZXF4UGY2akZvQ0NQWUlzVGMySjVVN0JyeEMzUWFZeUhDUHlCRWJlbTQ4?=
 =?utf-8?B?WmV6eDc4MnFoOUxENWJGNElvU0FmOEdjUFI4cEU5L215OGRHTmd6YSswS1V2?=
 =?utf-8?B?VnhFQ0lQZzRJWVZkUUZSNjVuRXlHQzlsV291dGcwbmN3dU8yUFNwQjhKTnRx?=
 =?utf-8?B?WXZSVThiVGtCb25aN01ob0k5N2VSVmJsSlZFTjJ5UU5CbHFpYXdlRTE2OUVO?=
 =?utf-8?B?c1JZbTVsSmxVSTBsRHBzcXl0TFlodzFaQy8yY25WODNLMXFXZEY2R2l6eGZZ?=
 =?utf-8?B?aEdEVWhhVG1GOWg4WTl5aHo5aG83U1FGT2NITWlNaWRrUmlNYkRlV3gzTFNU?=
 =?utf-8?B?VFdnWk1xQm1XQmVVakR3NVZnVS9WQXMrOUtvaTlwZFpCaCtKT2Z2Q0VGamZD?=
 =?utf-8?B?WjBzREh6RjNNYkxkVzFmbWZqcG9oeXNTcTJ1NytPS2ZFa2Vwb3dBK3Fvd2ph?=
 =?utf-8?B?KzBVU0RXeDZXRVBnM0hnS1gvVVZmY1lUOGRuM21kcU5ZOWRXVkUwUExuUjVX?=
 =?utf-8?B?MHNERTlYUk1Hdjljb2E3VFFDWmUzV2NMaHFrUXBtUm5oakZSMFZ4SEE2SDRS?=
 =?utf-8?B?VXlvUG90M01tZjg5ZjVlUVBNMzNKeWJzdERXTDFISEJ2WEE0dUhSeFk5UWJZ?=
 =?utf-8?B?c1FSMy9wZDFuU0pMR3lPV3F4Wk1GRUl1KzJEMHVYKzZzODJIbEdOaTV6aGcx?=
 =?utf-8?B?RkxQaEtNb1pTalBxWmtGOXBFaWN6SlZsT1V6dlhjVXdMOU9OQmpCclZIUGI0?=
 =?utf-8?B?ekxyNmY1cjB5WHNRbE1Wd3BjOVd6ZDQ1YjhmN0xNZjVNUkJ0a25ZS2hybzEy?=
 =?utf-8?B?c0VtN21WUW1hTi82bWwwREtldW1RSGViSXY4ZWo3UzQ2VlZnTHpSM2RvV0F0?=
 =?utf-8?B?QnlLbnBMbWpwMmZoeUcxaEpZUlo0bUFJam04U2M0aENGYnlXY2g4R25CWTZ3?=
 =?utf-8?B?MW5KTCtXRWFDOCtERGVPNWh6c0pNSVROTmtJcEM0L3FuZjg3TGpJazRDY2V5?=
 =?utf-8?B?MTkxNWVlNTE2bk5NaWNBZFJIUWlEaEJRaUdNOVIwWVpoekpOOUkrZEc3RW5q?=
 =?utf-8?B?WDBlWVJrTlY1UkNqRi9lQkdwamM5TVV3TkxHTkZldFVaWjZWNVZieTdzWEJ3?=
 =?utf-8?B?QTFpUVlrOEpVZ09HZ3JjTDllMUtibnNuZi9ZeXdOTlZuVlhVQVBOeG1VYld3?=
 =?utf-8?B?QWZaRjFRdDUyTGdaWmFzNnMxNVhYQ0s4SndYNWN1aE9YODYxNVhLaFdFanlS?=
 =?utf-8?B?dm1ZU29PUk5ZdXZ0cll2TmpLNjZvYU9hd0l3d2MxY1pVMmFBdVNqQW9FYkFF?=
 =?utf-8?B?eHB5LzdXSTRqd09JVzlyT2JGMzdGVXZQL1drU2FUVmdiYnc1cHRuU0IxZWsw?=
 =?utf-8?B?c3RyZkgva0RCcFMvbnUzUG1ONGRvZWdYaC9GRXZCMjQrdmJUYWpLV2FwQjJ6?=
 =?utf-8?B?ZDlwN093eTNoZk5xcS90QmM0RGNCUmVPZm9zOStwVU5CTUdpa05aRCtqeGtu?=
 =?utf-8?B?ZFNqaWJPYWRGUjZoT20xWXFQbGVwVzNuNDZTa3pDWFFtbG9JdWo5WE1lY0ho?=
 =?utf-8?B?elY5NGNIaWhDWVkzQVBxQjA1LzZidFY2bU1yVW14TlBTQVJaU1Eydmc3ZE43?=
 =?utf-8?B?c3VNWUNmcXBlRW5EZFdXTExqMHhVMTJjRkR4b0ZncEh1U3RvTkY2eEp1MVY3?=
 =?utf-8?Q?OKTAlSQEMxGr/3iUMaLJJcUPx2hHUYx/0e530=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VktvSGpKbWxZRllNVERLUkV1dFRlbjBmTHBpNW0wQ0hvWkFRR2lYUmdXT0tS?=
 =?utf-8?B?V3hWYk1QOWRPMUMxQXFWNXZVWk9EdS9MSHhuK2hqdmUvQ1RVSCszR2RDSmxQ?=
 =?utf-8?B?b1FUd1QwSU5ZU3owdDZnK1ZObHhVYXE5SnBuemVlUW1STHBTR2laSXJiQ1lW?=
 =?utf-8?B?ZGZ6MFU1TmZsWXV3V0ZEb0haRFJKNFBCUjJuc1hyZEFZR3VjRWw4WUJtNmZw?=
 =?utf-8?B?Qnpadlkza1BCRnhFRVYyM2tzM2EvVVJhcUE4WStYZk1DNXo3Rkt0QnpDZS9r?=
 =?utf-8?B?VjdGbHdZUzE2RFVNMFJNc1QvK09rS2tEWE9ydkxQNlJjR29pM1QvdUZoMmxB?=
 =?utf-8?B?MmJGRWVCUlpFSWh6UjlGMU5hVGJlZ05mdTJtS29MdUo5UEE0Ty9DUGc5RW81?=
 =?utf-8?B?eC8weXIvSXgwV2NSdWlJaExMNmFNSlUxMDN4WVFRcDMrZTJCOC8vVW1pVG12?=
 =?utf-8?B?YnRwVHBmdmsyK1g5L2tZMVFnS1ZuR0loR1ROZEZsZTJsNFArZFdmaUJOWnZ1?=
 =?utf-8?B?MDYrVFI1c0wvODNvVnhnaGFpblF3OXFQajJYdi9nOEh5TE9wdFRObnVramlW?=
 =?utf-8?B?K0RWa3dacVFwdkRLdTBHbzMxVmtScjJwNjR5ZFVTVDVRWk9henYwYjl2RUVK?=
 =?utf-8?B?VXpKMkpUUC9VTEtDWmx2Z0dRbDVjbGNmZFlzTnEzUmQraFdybURtNlB6WG02?=
 =?utf-8?B?QW51SG5lVnl6RUZDNXYzdUxaajZQbUNycUczc2oyMFNWemU2WlJBRjhwMEtT?=
 =?utf-8?B?Y2dRTGFsWXJGMWhDbzNrcHpXaTZNcndTMGJLTGRiUExEdThoVkU3TXhMblFJ?=
 =?utf-8?B?NGJsYzYzLzdBcmE0QjJXL2NvOVNXa3NnRm55MjF6N2dMKzBpaXJtdXdsaUhm?=
 =?utf-8?B?b3hjZlVlNndQaTNKR0o1UGVPSnM0cWc0eGJ3R0tadENNenZzY1NJZ1ZFZ28v?=
 =?utf-8?B?VEpQRHQ1bWJJdmpFZ3daTVJQNVF2cjdIT1BWTHFIeDRPRjRiZjdLRUpVRm5p?=
 =?utf-8?B?bkU5RFlaekw5c3lLQVFIRXdEWXkvcmJXZXdDZVN3MTlPakUrcWNza2YrRjZR?=
 =?utf-8?B?TGQ1aWovdFdQVEhBcWpvQUNwWTVpUHpyVVdGMHVmbVV3MXNYdGlBRVN5RUpJ?=
 =?utf-8?B?cmROVGRTYUZmRERJWldSeGMxdlFGTDhwL1NtMkhWdGhMWUZycVdaK3dwK3ps?=
 =?utf-8?B?TmppdjdNNU01SE5WTytoSHA2SlZVQ2xXZWFIaklVcnJsemIra3JRZFpOSEY4?=
 =?utf-8?B?WjJQR0o1T0ZydGRJR3lxWTQvRlQrd1VvTmZNb0pyY0JMTXI0eTRlWklHNk4w?=
 =?utf-8?B?eUxlS2pZSFlYSVZvdnNIajlSNHhDWUJCZklOamZZSmhjblZVc29Xb1RjVUZB?=
 =?utf-8?B?WW9yN05EUE5QUXNGRkx3c0pOQTZ2TlVBQmpka0IycVJLVjdHYTB1eUVPMkdw?=
 =?utf-8?B?Y1NFVWtld3ZRM0Z6ZjVKek54ZEpTU1RIWTAyeGpmQ3MxVkxFWnFlUGVmUWxQ?=
 =?utf-8?B?bHdVVmE2WEM1MjdDVjVSTENGVXRKK2lrNXUreitXNzluSHBCWmliK3Uvd2Nr?=
 =?utf-8?B?NmNyRG82WWUreFRRVWNzYUVCdElURCtmb2J4bnpWRUNmcEhncStDMWdmQ051?=
 =?utf-8?B?MHVzYzBoc2R5MG12QkJKUVExdzR6bG0vWjRwMjdQQnZjMHdQN1NDZ1RYU1dD?=
 =?utf-8?B?cTNaSUtCZ1ZpVDBhVkYzcUtjREhOL0ZCTUZiOFRDTEVvVDZuVkgvSnIwWnVN?=
 =?utf-8?B?cmN0WFVycUU4RHFLcFB4aDUzcVdtcGFJOTVJYVRka2w0ajNsc1A3T1FhVldh?=
 =?utf-8?B?Sy9ZUnVwajN0Kys0d2c1dWJoelNvbGl6cTc1ZWg2QmIwekFDT21QMElpNHVn?=
 =?utf-8?B?U2NIQWxOOWRMbnk2Y2tUSVZhbzhFWFF4MXlQRjEvbThXLzVOVVhvSUwyWU9a?=
 =?utf-8?B?cG9veXpLMVZFNWxYOW1sVjQyM3I3ZXh0WllmTms1d1VwcEpiNko4OWVIZjlu?=
 =?utf-8?B?SU1MTjh3TGtWUmZadFVibGFIRS9CVFF6ZmxHMVZoeUJyZnlDQStncXVCUzlo?=
 =?utf-8?B?aUZBYUloYXozWjlTazJ5TngwNWplTy8zd3greUJNZFN6ZEF5RmRjWmdoNkVo?=
 =?utf-8?B?NG54QkJpS2d5N2IzM0E5Q1pVb1RBeWd1bU5XMHZSa0QxZVY0WFRDNUVjSkk0?=
 =?utf-8?Q?YJap3b/toDK+MxDfUEaWJn11kWPkd7WRVDkGrFbyXhrn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFF771FB73F6F44FAAC247614DE1B68E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RI6TLsC4QN4DLw4PLnCLGdscyWvLonVrAMcNPYKd9MImLsE+rjfuNPz6PEHZGG3lRLoCl14LZwLQCWUdBClVJeu+8UGg2Gmu1X6s0wWIyk2qokxrFQZIdcFOg6NLhVeR1WAqCNd/3oSx4RjyyI4QEv8Rv25YI0yGFFt8GLccww31FgbeEPsVPQy69WZYUJiY+8QQx0k02XsZ80u5TvS6049eO2c+BWfgPACrtuBz79rhwD05jQOuMH30xFFvStGE70I8wVE0Qr+JbvGSzVNBReTIAyRAXqWjBUCCTrA6kSnJvxHVleTS9HX2jmjRABEUJKle9lW5yYuBGfyS5b4o3Q/iDwK03P8azYwGWFvDxuPptV3YEKmZ9bUPXgIulwMej901g6FroY1Oee0YKom/vTZS0rZgM25j6IdHF2d68tMbzydPZlcy45Oh7/Ha46rxneoyjeuUURfVKByJM5dOBkycjzuEnp9eyrXiYMcGwKLicvQMbOYXwsopRukjHNT2rXAWDfBs1Kqtx2s3+7/kTYwIfs4aDK7x++WgIbCwZpHwKxfJr8V9//8DXB1+E5uhyOtVTINlSpgHMW7OKrypiMf8fOpnMJoYNOew2WdPtMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d6edb-7973-49d7-7223-08dcef89f128
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 15:31:31.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxDMwHu7XETj9WbUMKgZmNAXdhNr1t9D6jaAIAecs76cD4iw4n3rpQMcJ3D4BeW56Vr6ZjMmOvmlrZEtf2aSpEbheouoWzq0KlfPusCvbxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180099
X-Proofpoint-ORIG-GUID: qYTDZAI4xNq_bF4fcZeuwnmnqnCt76b_
X-Proofpoint-GUID: qYTDZAI4xNq_bF4fcZeuwnmnqnCt76b_

DQoNCj4gT24gT2N0IDE4LCAyMDI0LCBhdCAyOjQ54oCvQU0sIFNpbW9uIEhvcm1hbiA8aG9ybXNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNywgMjAyNCBhdCAxMToxNDoz
M0FNIC0wNzAwLCBBbmphbGkgS3Vsa2Fybmkgd3JvdGU6DQo+PiBSZWNlbnRseSB3ZSBjb21taXR0
ZWQgYSBmaXggdG8gYWxsb3cgcHJvY2Vzc2VzIHRvIHJlY2VpdmUgbm90aWZpY2F0aW9ucyBmb3IN
Cj4+IG5vbi16ZXJvIGV4aXRzIHZpYSB0aGUgcHJvY2VzcyBjb25uZWN0b3IgbW9kdWxlLiBDb21t
aXQgaXMgYTRjOWE1NmU2YTJjLg0KPj4gDQo+PiBIb3dldmVyLCBmb3IgdGhyZWFkcywgd2hlbiBp
dCBkb2VzIGEgcHRocmVhZF9leGl0KCZleGl0X3N0YXR1cykgY2FsbCwgdGhlDQo+PiBrZXJuZWwg
aXMgbm90IGF3YXJlIG9mIHRoZSBleGl0IHN0YXR1cyB3aXRoIHdoaWNoIHB0aHJlYWRfZXhpdCBp
cyBjYWxsZWQuDQo+PiBJdCBpcyBzZW50IGJ5IGNoaWxkIHRocmVhZCB0byB0aGUgcGFyZW50IHBy
b2Nlc3MsIGlmIGl0IGlzIHdhaXRpbmcgaW4NCj4+IHB0aHJlYWRfam9pbigpLiBIZW5jZSwgZm9y
IGEgdGhyZWFkIGV4aXRpbmcgYWJub3JtYWxseSwga2VybmVsIGNhbm5vdA0KPj4gc2VuZCBub3Rp
ZmljYXRpb25zIHRvIGFueSBsaXN0ZW5pbmcgcHJvY2Vzc2VzLg0KPj4gDQo+PiBUaGUgZXhjZXB0
aW9uIHRvIHRoaXMgaXMgaWYgdGhlIHRocmVhZCBpcyBzZW50IGEgc2lnbmFsIHdoaWNoIGl0IGhh
cyBub3QNCj4+IGhhbmRsZWQsIGFuZCBkaWVzIGFsb25nIHdpdGggaXQncyBwcm9jZXNzIGFzIGEg
cmVzdWx0OyBmb3IgZWcuIFNJR1NFR1Ygb3INCj4+IFNJR0tJTEwuIEluIHRoaXMgY2FzZSwga2Vy
bmVsIGlzIGF3YXJlIG9mIHRoZSBub24temVybyBleGl0IGFuZCBzZW5kcyBhDQo+PiBub3RpZmlj
YXRpb24gZm9yIGl0Lg0KPj4gDQo+PiBGb3Igb3VyIHVzZSBjYXNlLCB3ZSBjYW5ub3QgaGF2ZSBw
YXJlbnQgd2FpdCBpbiBwdGhyZWFkX2pvaW4sIG9uZSBvZiB0aGUNCj4+IG1haW4gcmVhc29ucyBm
b3IgdGhpcyBiZWluZyB0aGF0IHdlIGRvIG5vdCB3YW50IHRvIHRyYWNrIG5vcm1hbA0KPj4gcHRo
cmVhZF9leGl0KCksIHdoaWNoIGNvdWxkIGJlIGEgdmVyeSBsYXJnZSBudW1iZXIuIFdlIG9ubHkg
d2FudCB0byBiZQ0KPj4gbm90aWZpZWQgb2YgYW55IGFibm9ybWFsIGV4aXRzLiBIZW5jZSwgdGhy
ZWFkcyBhcmUgY3JlYXRlZCB3aXRoDQo+PiBwdGhyZWFkX2F0dHJfdCBzZXQgdG8gUFRIUkVBRF9D
UkVBVEVfREVUQUNIRUQuDQo+PiANCj4+IFRvIGZpeCB0aGlzIHByb2JsZW0sIHdlIGFkZCBhIG5l
dyB0eXBlIFBST0NfQ05fTUNBU1RfTk9USUZZIHRvIHByb2MgY29ubmVjdG9yDQo+PiBBUEksIHdo
aWNoIGFsbG93cyBhIHRocmVhZCB0byBzZW5kIGl0J3MgZXhpdCBzdGF0dXMgdG8ga2VybmVsIGVp
dGhlciB3aGVuDQo+PiBpdCBuZWVkcyB0byBjYWxsIHB0aHJlYWRfZXhpdCgpIHdpdGggbm9uLXpl
cm8gdmFsdWUgdG8gaW5kaWNhdGUgc29tZQ0KPj4gZXJyb3Igb3IgZnJvbSBzaWduYWwgaGFuZGxl
ciBiZWZvcmUgcHRocmVhZF9leGl0KCkuDQo+PiANCj4+IFdlIGFsc28gbmVlZCB0byBmaWx0ZXIg
cGFja2V0cyB3aXRoIG5vbi16ZXJvIGV4aXQgbm90aWZpY2F0aW9ucyBmdXRoZXINCj4+IGJhc2Vk
IG9uIGluc3RhbmNlcywgd2hpY2ggY2FuIGJlIGlkZW50aWZpZWQgYnkgdGFzayBuYW1lcy4gSGVu
Y2UsIGFkZGVkIGENCj4+IGNvbW0gZmllbGQgdG8gdGhlIHBhY2tldCdzIHN0cnVjdCBwcm9jX2V2
ZW50LCBpbiB3aGljaCB0YXNrLT5jb21tIGlzDQo+PiBzdG9yZWQuDQo+IA0KPiBBcyBpdCBzZWVt
cyB0aGF0IHRoZXJlIHdpbGwgYmUgYW5vdGhlciByZXZpc2lvbiBhbnl3YXksDQo+IHBsZWFzZSBy
dW4gdGhpcyBwYXRjaC1zZXQgdGhyb3VnaCBjaGVja3BhdGNoIHdpdGggdGhlIGZvbGxvd2luZyBh
cmd1bWVudHMuDQo+IA0KPiAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCAtLW1heC1s
aW5lLWxlbmd0aD04MA0KPiANCj4gQW5kIHBsZWFzZSBmaXggd2FybmluZ3MgYWJvdXQgYWxpZ25t
ZW50IGFuZCBsaW5lIGxlbmd0aC4NCj4gQnV0IHBsZWFzZSBkbyBzbyBpbiBzdWNoIGEgd2F5IHRo
YXQgZG9lc24ndCByZWR1Y2UgcmVhZGFiaWxpdHksDQo+IGUuZy4gZG9uJ3Qgc3BsaXQgc3RyaW5n
cyBvdmVyIG11bHRpcGxlIGxpbmVzLg0KDQpPayB0aGFua3MsIHdpbGwgZG8uIA0KDQpBbmphbGkN
Cg0KDQo=

