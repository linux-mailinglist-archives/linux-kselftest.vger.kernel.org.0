Return-Path: <linux-kselftest+bounces-20435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D967C9ABB6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 04:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7F283D98
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626043EA83;
	Wed, 23 Oct 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OxQkxxUH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ErXfOghw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF54174A;
	Wed, 23 Oct 2024 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650306; cv=fail; b=pxxZEp+AGim9wJfVTknXnN4DhkftYTwxYl60Goqt6W4U7E6JxlLX5gIcF1bih/EpcBr79WwV/Ka1JVTp070V5o77r/RppYrRwInssayMvFh/HIOqvriORkWM7eF9MVml8lI1JwZofoMC4a84Dv5ApMd0us5+tMOK6wi8L2jBybs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650306; c=relaxed/simple;
	bh=amntWE4Wh12jb+ukSM/BglZFw/5NOi9wniExwfi6qug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oui0tufN0ekEpd8JUUTP0Maidbuwsr/zYUzJwxoYrF3+FnS1lA4IdGkQrUyjdcBz05iZCZvkW/ICRPCOgnl2qLFPzEDbe2NdL4DoatI87WZCltgSG1bCjIkB3Ofzw51MzrLDGOlDhJZQoY8/sgpfQ85aR2mYrawWJbJWrejrZiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OxQkxxUH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ErXfOghw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQZx6020909;
	Wed, 23 Oct 2024 02:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=amntWE4Wh12jb+ukSM/BglZFw/5NOi9wniExwfi6qug=; b=
	OxQkxxUHWI28zoYOQXSIc9dCY3g6GR41OOt2z/eZbI07PWSmj4+pGVKLNSouQbJz
	3y2NiLBmoOcwWYows84hsS9eHKOSjbpG56Bq3r0/zIfba7u3tqG9u+yFX8jMDjvs
	DucXuwIX9fHcuCu4uSr4o+Edk3IZMdYrnWfd5qMdtrc+6I3cmoanLy3Ocgbouia3
	jqinTytgcxqT18/Lenp6WEivd/quPmXxroowuj+Vr+QyUBto0V5bH0lmJqwDVVdp
	Q3K2tek/2LreyyjmtNL51e60akKdidlfVcQMnfy0KFZXBoXG1cSRDDl4v71HqVEe
	B4jVHNdoCx0B+sRWyI22Bw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqxbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 02:24:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N19sin036141;
	Wed, 23 Oct 2024 02:24:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1wrd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 02:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYWOkU2CtSUEeE3d8e6tnbevaB7I0SRE11YYAaGrL5R/gNm7inHsy/NZ1aIAFBZu08YUhqRH0kYRhiBRKVSrlpku8x9eotR4UykiyRVl0c+P8Tc4U2N81xsrZTKPgcH0fZkQ6SewEhQUL/UbSqZq3sIbU1Olcrmx7yiG7RwTnr5j7TmFFaqJZo78cKHuHjTqWvZn6MXFrFuSzxuZXy0Y6TcxHtywwmdgqSQHqwf9oWARhEYg7yf/vEVNZaJVH94CTtNuAsyF1LgIwJ/6ZOD++ojfsMgP992V2yQ0NOg0hOAeqs/L0JLnsrL2sx7ZPVUDdFbAQaBAUzoB7k2Bx4e8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amntWE4Wh12jb+ukSM/BglZFw/5NOi9wniExwfi6qug=;
 b=NophjEBE/TMQO5TF1kVTz80LiiSn7l6slezcTLc166R/cwP1EBWFsgjRN+WC7EKV0ZYpns8I/jLBGo6PiXZ4aaqptzF8+TnA7IfR6uZZPuKIrNtk4Ba/hiX0yPH/03NRu10GzTEl5WvnP9nksSBYIt6EFkdh8J1kMo0i2C1TY2IzOJkXKLYHSrmJzbt6QtPNqFMBUtJWbABBL8ud6ygwhT4zaAOaCwerdm9RZGbIqhJ2aiUaMedwcEuilhKD6AzSUTfzaZl6gkbv3tV0tZ2qj6sxkzdiPmuypetSvxdcJx73/KmwnHAbCxwRFrYFcRO0Thr1Bu5CD/BslevROyLdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amntWE4Wh12jb+ukSM/BglZFw/5NOi9wniExwfi6qug=;
 b=ErXfOghwXXgA4ScYs4MG6sme5fdCw7wNn1y8XN0IrsX+MTi7IZeGGQhRdiRlNhU89Xp2Fc4aKVum3kXO71BaDFvRk5p3BVGPM386L31lpUXhFmpbbz32VrWO9e7kXeKxPZTJW5AmwlkcUeHSE5geBBbAy+ynZBdZlzsodwS4wkI=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:24:37 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:24:36 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
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
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Topic: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Index:
 AQHbIMB0xnnjqPmQVEKeaxqXStpTkLKLo7gAgAAFlYCAAAXwAIAHk0YAgAA2NACAACUtgIAABfcA
Date: Wed, 23 Oct 2024 02:24:36 +0000
Message-ID: <CDE1D110-A3F5-4BB7-A8DF-4D24E2AC98B0@oracle.com>
References: <08EFFA25-7C8F-444A-B229-2A9F99B0C028@oracle.com>
 <Zxg6KhhpCGc-5Mw0@mini-arch>
 <39B736F3-F7E1-420C-9567-0447464A95BA@oracle.com>
In-Reply-To: <39B736F3-F7E1-420C-9567-0447464A95BA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DS7PR10MB5149:EE_
x-ms-office365-filtering-correlation-id: 0992af51-eb0c-40f4-5469-08dcf309d717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZU82SmtzZU1YVUhIbkRibzg5T3hPUjcydWRUUC9EbnlLcDFUajBjTXFndWgx?=
 =?utf-8?B?SUJGYS9zSm81Uk5vNyt3OHRxbEgwVE8vSmE0MFN1RU4xdWNzVis5VDB5THZx?=
 =?utf-8?B?OFVSNlhBZ2ZMa3oxTnlJak5UZC9TeEk5VTJyenNaWWszQ0ZmTDVLK2s5ZnBw?=
 =?utf-8?B?K1pOcitvdUdPUUU1TGJnamlLeUJyeDNnaWNOS2ZhU0l3cmFyTDdCYjNLTmFG?=
 =?utf-8?B?dVVuQnAwbHJ2VnVUY25Zck5McVR6R1BtRUpVOXJKTWhyVXNIa0g0M21xbThI?=
 =?utf-8?B?ZVpnb3RMdEVFR3NxR0c4VzRUemowc3d3NFQvU3ptMUl5QW51YzJ2YjdXb25L?=
 =?utf-8?B?T0NHekw1a3RQMjJKOStsM1lDU3VYbHBIVzdxdlZ6RVZnbVhkWHVJbndtellU?=
 =?utf-8?B?ZFRHRnFuTThGbXpPS3pkQUh5TnFrNjJFZ0dDU2ZoRWdHTlRRWnMxRnJ0bUxQ?=
 =?utf-8?B?T0Vtbm9PcllpYllvdkdTSkdQM3JtQmtNdHd0MmlmdXNVZEdTNG9tODlDNDB1?=
 =?utf-8?B?TVpzdFdmZ2daNUxwd3BBSldxS2dDR3VBMzlQd1FYMUNzWktTNS81cHB5VkQx?=
 =?utf-8?B?ZHBUdHRvejlscUVBSUZjVWtPQUdOZElBd05ESzF1dkVhbHFERnNnaFZMTGpV?=
 =?utf-8?B?TjZBZG9YaWR3NS9SYnZxWDJ4citBSzZ0SzRMWFJKajV6TDNTQzhaZWdLakRj?=
 =?utf-8?B?UE1XaDZzSUlrTFJKYTFGZVArOHRuUXhrSjIvTkpTbkpCRnl0bllrdjhGSG9p?=
 =?utf-8?B?WE05YkJMQkNibExDSlBsTGZlQ2cwc2E1dFhpM2VGbnRPMEpYNUNjNlZ5UndX?=
 =?utf-8?B?Rm1tSXY3MjEvYXYyR0VXTU9ITEc1d2dKY3R5azJIVVl3d043c2EvM1pEOFRu?=
 =?utf-8?B?NUNPM0hOR3VVZGlFejFObXg2aXVPY2hyeVJKQ2dURWJlN05GbU5zVlI3enhB?=
 =?utf-8?B?MmdsV1FwV0lOVEc2SXpsaW15THd2ampWOEI4aDlLTEtsQ05pbmtwc2daSXV2?=
 =?utf-8?B?RDZVTGFFVmlUV2lTemdYdisvQTk3M2Ftam9Ecm56N1dZdmp2eW5odjhmdWhE?=
 =?utf-8?B?aExST25KQnZBZUpkNUt6c3pPdDJyTHB4WjJ6YzI2S1JTaTQ5MThMRnk0Y0d2?=
 =?utf-8?B?UXNlZkVxejdaMXZiUEJiVXFHWEQrZGYreU5wWXdrUzRrbGZaRnhTcWppMEdr?=
 =?utf-8?B?WHJuTFZjL3VvdXhzcDdGUzV1ZTluUlB5K2owSGpmQmNwN1cwTzVTTjZtRThs?=
 =?utf-8?B?Y2pJcG5hTzU1WlE5cmcyVGhMamJvcEJZZFhNOFBjYkVGd1psd3dEZ011d0lm?=
 =?utf-8?B?QlJ0bWxrRmRHNjhKUnYrcEpGTVR2ckE0eUFDUnpHMDkyMDNOeW5IOEZNM2RV?=
 =?utf-8?B?Y1VqeVlTYzRwVVpDN1M2dnMzS092bzcvMm5nTnV0a0czMXJIcDZadVNuVy9T?=
 =?utf-8?B?ak91NURNVmo5VU9vb01DT2NkeE9ZZVRncUowVzFNb1hEVGl6VjhVM1ZsU3l2?=
 =?utf-8?B?Qm1zWG5DK0tZK2NNUWJxeGxhUlVaU0QwNDNyM0tYUEU5bzNjd3Y0dzlrU2kx?=
 =?utf-8?B?R1JKTlFoTkJRS0RSRXdydGRLazR5UXdIZUFOODJFQlI1R2VMWWIwS3dPcTdS?=
 =?utf-8?B?cU5IK3VxME53SGdNd2M0TVlQdXlLbEtvN1l2V3l5bGp3L2MrVFV3ZzVXUkVH?=
 =?utf-8?B?Y2h2Vmh5WEJrbGxrVGhzNVdkVXJEbjdGSzZlQWZvVmhlcUczNTNWSUJjbWx4?=
 =?utf-8?B?NHhQNVJOeStaRUt4Z0JyNWRrd1RmZk1Lbzk0Zm5nOHRsYTE3Ump5ZlpjOW9D?=
 =?utf-8?Q?w1OIY1EfIVObUma68HQ/68AXcgBO41xepXGUg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ykx2L3JBUHpBeFNFeWRsSzl0SWtyOWx4aVYwdWYzTEJ0Zy9mS2x1aFRaeEx3?=
 =?utf-8?B?OWRTS2FzQmkvV2hEM2JzUkp3Qi9rQThKMm4wMkhmckFNN0NCNGJJY1VOb2N1?=
 =?utf-8?B?MFMwdnRCcHA0UlpSSXl5bHBxR3R4b0xFU2ZrV1IwWUNIeWs0Q2U5UlYwU0xD?=
 =?utf-8?B?V1Y0ZS9ib3lWTXV5Nm43T3YxUUhNNFlKZ1BnMnd6cWVhM1gwY3lJcmpRaUFy?=
 =?utf-8?B?bXVOWm5GSFZ6akNtREpYbWpKVy9rMUgrcE54K1lheG1uTnduTEQvUUZ5VWhU?=
 =?utf-8?B?ejhkYldtMFVxOFk5b2NiNjZCcG1pcEJhWDkxRnlIYmVYWisvdUJPdm1IVU12?=
 =?utf-8?B?MVd0Ky9rNzZxRmdqWit2WVBHQ25IZ00vN0VzQ3dEOUxuQ2FCdExJMEpLcWZm?=
 =?utf-8?B?NitWVzRMT1FDdWFqZzJWM3IrRTJOV05zNzlKb2ZwYlQxZG04TC83YmhsWUlv?=
 =?utf-8?B?T0RyN1NWRlZIL041SzU3VGRMamV3VmtVTEpSV21HM3U3eGIzYXgwTG5QVnZX?=
 =?utf-8?B?Nks4MFQraGRyK1FFeUJQcDZCbE1DVVIySk8vME1uRG9GK0poa3ZVR2lSTVVW?=
 =?utf-8?B?ODNJL3QxclErZmFkL0IwV3YrQU0xVmlJV3NUcS9Cc2JES2FBNGl6aDNmbVVX?=
 =?utf-8?B?WFl2Rm5tOGZZMXJuQWt4c0l4VGVnTlhWMlc1bWFSVitIYTNnQ3hrSUFOQ25W?=
 =?utf-8?B?UTdWbjlBVi91NkkxMG9PRldsSFlRWkxHR2RRdWZwU1VTYWJGSHhTSi9qMEFu?=
 =?utf-8?B?V28wcmdCQXp2N3Y1NDBlcW1pbTZrSHJBTUtEY0NhQi9FVSt5cWI3Y2FjRDBB?=
 =?utf-8?B?UVJwNkZUb0YraFVLWENCSU9mdDl3WGlnRmYwOUhNOUoxRFNjOWovOVVQSkVn?=
 =?utf-8?B?dVJDT2I0RENTZjc2dTBzeEc2bWNzRHBSMEJmSjhlb2oxYTM0WUZtSEZZbmFE?=
 =?utf-8?B?Y3RLbGJRUkFyRGVHaVVaSk8rYnFEZzJsVUU4c0hraTlxMHYrZ2pJcWhCTk5F?=
 =?utf-8?B?OHlWMmhYa2Vvd1dMNmIxRm0wcDNkMGFQQnY2VnZuaTkxV2dIS2tKejRTZEho?=
 =?utf-8?B?a0w1Y1VhMDJuQlRTOHFGT2t5ZGR4WTN5S3ZpcVBDQ3RnVE1IdkRaVTVaMmkv?=
 =?utf-8?B?R0pqSWpObzRYWlJtTFhla0tJUVQya2tRUXRubWwrYlJlekx3OVlaeW83SFZV?=
 =?utf-8?B?aStHRWtTd0lYNjJPYTBZb21xRkpqQStzc2J2NXZKTm9DTnhFbHE0TVNMcGU2?=
 =?utf-8?B?LzhHNGx0Y21VZTlWNFJLUG5JdzZJZVBuZGJKRGQyUm1kRlpEMVlPbVFKUGt3?=
 =?utf-8?B?QmVaTWFoYzhVak1MVk9XcngrYm91QXZBMUVJNzF3aUJVODA2WXFNT1AvYmhG?=
 =?utf-8?B?Vm1yb3Q5SlNRbzhkbTR3MEl0Y1NwNnVpc2g4NnEzK2dzSUdGN054YkYydVpW?=
 =?utf-8?B?dVZDYm9pdUkyK3hiczZZUml5TFFSR1M3Wi9pT2Z3OGRvR1EzOXh5ZmVGQjlh?=
 =?utf-8?B?UzdzUnpqcFZYMEhNU1hWZlRDL245MVA5MnNvbzNpaTY2bkh3VzRRcEt1SmVi?=
 =?utf-8?B?MmhMOGZsWHRZRGltRHFJR0pqNXVKUkhYTlRoeEd0ZnB0QVNhTWlFc1NPYmxn?=
 =?utf-8?B?TGJvZFlPQ0hRbW1TaThtYTFJKzNQQWNYN1ZadkZkRUd3ajd4QzU4M2lyQnZ1?=
 =?utf-8?B?b2E2NFhMK3ltQmVMSVQ4SE1wQkdwcWF6TTdMcTk2ZVRRSFh0dzJSang2cHdG?=
 =?utf-8?B?eFNOTHk0cnZSZ3J0SzZMbU1SbmdaNFBYem9TcTNDQWpRbU9MeHQrUlFwRFRJ?=
 =?utf-8?B?NUZCK2F6aVRiMXR6MDMwblBMTXlGL0g2eFBCV3hoN1dST0t5MWlEM3diUFNj?=
 =?utf-8?B?NEYrbXErTFlrN3pZcmsrMXNVQXk1NVlWRG1rZS9Fek9BbDNSVmlneHpaTVho?=
 =?utf-8?B?SGF4c0UybHNmSFRVRXE1dkQ0cHVQNlBiLzd4YjRrRUhUMHNLN1Z6em9kM1dC?=
 =?utf-8?B?K09ka1ozV3RmUXUwcmhnM2swTDJOUm1sak1hdjFpOStJa2JmSDVDc3F1bG4x?=
 =?utf-8?B?Zi9BbHV6NHpsRXdEcjBSVWhTeHJpcUlqcHpoN2FUcnprU1pSaW1SOUlodkxO?=
 =?utf-8?B?dkcyeFpkeC9qZlpRSHBUY1oyRVRKOXRsdmFyeWc0QmtRaUczUWVNOWU0dTdI?=
 =?utf-8?Q?t1IWVYQpoQeECfVVtIXwtuRzpJfm2n8k70trXDwmotuj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22EB20896983D84E9A7FC11E3F0BE229@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LwzhjCcmj3PBCa9/xZAvk4hruDUAuYV4RcXImnZHVOsunpUhfn+jmHzCvxpH2qL3CNFB8Cvsw9gLrUya/BeKtVOUj9FjmwTEy7od0+slCX+A7Poc3n70qxYG58F5e6+Qbbot6mznGJZDiANk9Hi2qlW6n6KSxT3oeHftTu7hubBOtFjvJt532Dn2gUGaDcnmspcUIP7bp1t1w5WsaFL9BTK7iGc9FLkVvodHKzR3RIpeDx7090H/jt4Tw6uEVnkR83LnxBqjyUQnoSiZyiXLs5SueLUJ+KoOz/31rqSB1NmB9Ilv3ohO0JmR8urDvo4+1gQ7ii++bCexIxjBLS2jPCpiKNSxAp4eCrJpi1n2T9HlpBSGwLJ0IIwBkcjvENd+DcLO+2TseA5wAgfLjVt+TOfkY4xjS6s9AAfHN1SDODhZllyCySrgakHnGWCs4rsfHZxbd58tXsyfggMefgU6L5x6YTwGZZyyZJ6RG/FNpmcTaeKlHbL2dKK6cxgUDHX9E+vcpWmc2nhD4VB2A+5xd9Yb8jIS5WGGO90znreMyr18eBP0ctcPN85iPMX8+ubtK3hXzq4ghKlaBVrdy9pyYoAf16unuNICJ1450P2jPmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0992af51-eb0c-40f4-5469-08dcf309d717
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:24:36.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sI+qrsoF3rqylCiG2XxRTg8zcWmfEL1eucMWLJMNFuX/sFZeh7lEJnAbcQfH4463MIRqnid2ZW9L0Du2zFNFXDT1eGkuU6lH93ZxrNeGlUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_02,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230011
X-Proofpoint-GUID: Nwmk2GXWh-TKWLSeo5nkoLgRnrkOqqDE
X-Proofpoint-ORIG-GUID: Nwmk2GXWh-TKWLSeo5nkoLgRnrkOqqDE

W+KApnNuaXDigKZdDQoNCj4+Pj4gDQo+Pj4+IFllcywgbWFrZSBzdXJlIGFsbCByZXF1aXJlZCBv
cHRpb25zIGFyZSBwaWNrZWQgdXAgYnkNCj4+Pj4gIi4vdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5p
dC5weSBydW4iIGluc3RlYWQgb2YgbWFudWFsbHkgYWRkaW5nIG9wdGlvbnMNCj4+Pj4gYW5kIGRv
aW5nIG1vZHByb2JlLg0KPj4+IA0KPj4+IFRoZSBlbnZpcm9ubWVudCBpc3N1ZXMgYXJlIHJlc29s
dmVkIGFuZCBJIGFtIGFibGUgdG8gcnVuIGt1bml0LnB5LCBidXQgbXkgdGVzdHMNCj4+PiBhcmUg
bm90IGludm9rZWQgd2l0aG91dCBnaXZpbmcgb3B0aW9ucyB2aWEg4oCUa2NvbmZpZy1hZGQuIE90
aGVyIHRlc3RzIGFyZSBhbHNvIG5vdA0KPj4+IGludm9rZWQuIFJ1bm5pbmcgd2l0aCB0aGUgbWFu
dWFsIG9wdGlvbnMgcnVucyA0MTMgdGVzdHMsIGFuZCB3aXRoIGp1c3Qga3VuaXQucHkNCj4+PiBy
dW5zIDM4OSB0ZXN0cy4gKEkgaGF2ZSBhZGRlZCA2KS4gQW55IGlkZWEgaG93IEkgY2FuIG1ha2Ug
aXQgcnVuIG15IHRlc3RzPw0KPj4gDQo+PiBUaGUgcnVubmVyIGRvZXM6IC4vdG9vbHMvdGVzdGlu
Zy9rdW5pdC9rdW5pdC5weSBydW4gLS1hbGx0ZXN0cw0KPj4gSXMgaXQgbm90IGVub3VnaCBpbiB5
b3VyIGNhc2U/IFdoYXQgb3B0aW9ucyBkbyB5b3UgcGFzcyB2aWENCj4+IC0ta2NvbmZpZy1hZGQ/
IElzIGl0IGJlY2F1c2UgQ09OTkVDVE9SIHN0dWZmIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQ/DQo+
IA0KPiBObywgaXQgc3RpbGwgZG9lcyBub3QgcnVuLg0KPiBIb3dldmVyLCBJIGFkZGVkIHRvIHRv
b2xzL3Rlc3Rpbmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29uZmlnOg0KPiANCj4gQ09ORklH
X0NPTk5FQ1RPUj15DQo+IENPTkZJR19QUk9DX0VWRU5UUz15DQo+IENPTkZJR19ORVQ9eQ0KPiBD
T05GSUdfQ05fSEFTSF9LVU5JVF9URVNUPXkNCj4gDQo+IEFuZCBub3cgaXQgZG9lcyBydW4uDQo+
IFNob3VsZCBJIG1ha2UgdGhlIGNoYW5nZSBhYm92ZT8gSSB3aWxsIGFsc28gY2hlY2sgd2l0aCB0
aGUga3VuaXQgZ3V5cy4NCj4gQnV0IEkgZG8gbm90IHVuZGVyc3RhbmQgaG93IGl0IHJhbiBmb3Ig
eW91KGFuZCBydW4gaW50byB0aGUgZXJyb3IpLCBvciBkaWQNCj4gaXQganVzdCB0cnkgdG8gY29t
cGlsZT8NCg0KSSBzZWUgdGhpcyBpbiBjb21tZW50cyBvbiB0b3Agb2YgYWxsX3Rlc3RzLmNvbmZp
Zy4NCg0KIyBUaGUgY29uZmlnIGlzIG1hbnVhbGx5IG1haW50YWluZWQsIHRob3VnaCBpdCB1c2Vz
IEtVTklUX0FMTF9URVNUUz15IHRvIGVuYWJsZQ0KIyBhbnkgdGVzdHMgd2hvc2UgZGVwZW5kZW5j
aWVzIGFyZSBhbHJlYWR5IHNhdGlzZmllZC4gUGxlYXNlIGZlZWwgZnJlZSB0byBhZGQNCiMgbW9y
ZSBvcHRpb25zIGlmIHRoZXkgYW55IG5ldyB0ZXN0cy4NCg0KU28gSSBzdXBwb3NlIGlmIGEgdGVz
dCBuZWVkcyBtb3JlIGRlcGVuZGVuY2llcywgaXQgbmVlZHMgdG8gYmUgYWRkZWQgaGVyZS4NCg0K
QW5qYWxpDQoNCg==

