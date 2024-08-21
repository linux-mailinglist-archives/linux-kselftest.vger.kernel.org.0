Return-Path: <linux-kselftest+bounces-15920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B299F95A5EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72984285B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45116F0DB;
	Wed, 21 Aug 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QvadNzxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAC1D1300;
	Wed, 21 Aug 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272339; cv=fail; b=tNdo2j/EpYK4vTgo4emLbDnrqQ9Z7WFWsbl4sPYX6OMtbubSrvdh+0gxo1oXp1lYAM+YkUu3HCtH31gApJ7670Qa61ImL+8hDp93OQKCItwJUQFnOjKblUydNh/FzYr394rm48K9ucWQqoohKRvnUqiugucD4/gfN8LRFNp+YW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272339; c=relaxed/simple;
	bh=xDS1Mcxz1W8zquC5d8ep538z0T/9oa+wgc032lDMd1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SOzzq15yr6WIUb7WPRE6jj22kMbmh80+CU+/lQse+cwIQKjnbG8sGmQ6Q6HSoaGQEZu7vyOSRq5j/IwflbC1odgQC54uZb8WWaoKJ7JbqZNjQ+agn9XcfuDGC1gqb2UqrJJLcqA8WkZ7lJzuU6olvip2AM0QbocpFy8oYbnLlng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QvadNzxT; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LKLgMX029983;
	Wed, 21 Aug 2024 13:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=wRTciVYGfemizSthPGBE+vPUSY4xReYvUtejfRYNjBU
	=; b=QvadNzxTH+UbiMXQRHw2h9hM7z1uj4pRXFpyLdfXC5ye9fr4BbaOHyOxBNU
	vpcCJxxiMELNBNAVWlni06WPqNQZDu2C9vA0A6hOITox1yHiAUnpCQ/jGQc/0fWr
	s2W0GJw+wS6jRyW9YvOGtrIBqN0f47YH7h+ggbTcQJIX16u93B+/TC//FKp5Zvd4
	KewVFXDKw6lzguKvUCUb400SHWy7IlwKjHX/YPqBCLPmGneaYuF4A/IXUo6eocfu
	1SSOUY/C003F5kVqx+2GWm5/UN/Iwx8Z+9/VavCovxYVWXC/V6e2p1yJ0tkeRCLf
	O1P98KoOH9qre+aZdDIswlhAdgA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 415n53h0ar-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 13:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvuD+vIHB0/EyUVXZGXXXetRuBzaW5nHjLTGUsQ3DEwP4qV/QLjqunNRPVBZVVLEyuuyF+PLcRlQ6yZMfRprFYi4GxrL4cyfkFqQxSN8cZlwicNYXGBoMe/3OHqdn4XrhEzjbQPUZ5kq/9WKlAO+IBxNOItqpzJJLODoaEfltOKDVNv3gIkSdjywBUSmZrxKlmu/sachP63p9oacN4cBA38G7hVWvvQULp0W7UPWiczcflYqyiZJmstoPp24hNHFl1FOFSJq8JTzQPba/PLRuXwbchFt+W6GMpkDuWOgCq9K0LqKdVWiI9Bi1UjuDIvKXROyjv+hPTdwYX8fFAWqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3rMvvRHN0LXT/jZJiC23gOc/DxgMgfbuh/388eOFXw=;
 b=a8DTmTainQ+tCnUpd7h+8ADNjl+5ICZEGGTBV2brkttdd0uZ2PginDi+OJuqlbO+6l2xA7EyCDIrnQG+u1mM3GGVJoFyVoO5fvq4KyqdGY/zYvlrbi01oZJJpwrTN0QjMv3bef9KEkUqw7Hd+vSRweei6uUdhoV+Fu2tflp4bkEb85xQo3QDmrYTz8YjqmsuWrv78qtFz+nEsd6n0/YCcx4abu2JmipdCKItP29IuKLt+ezB/5z4lXKuUzgU+6O/f17crIq8YZZTNK/w0GVNhd7qGLiX6qBlaKdNMtqRMn1TFP6m4D/5MUSPz7cSg3O6f4mW2GtVgYut9XEEH2zMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by SJ0PR15MB5823.namprd15.prod.outlook.com (2603:10b6:a03:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 20:32:12 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:32:12 +0000
From: Manu Bretelle <chantra@meta.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
        "mptcp@lists.linux.dev"
	<mptcp@lists.linux.dev>,
        Mat Martineau <martineau@kernel.org>,
        Geliang Tang
	<geliang@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@meta.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Daniel
 Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Topic: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Index: AQHa5x15c/RoJYtmCUOQUAQQ0t4xmrIl/8mAgAxEVwA=
Date: Wed, 21 Aug 2024 20:32:12 +0000
Message-ID: <364C4C5B-27A0-4210-84E2-8CA9867E4127@meta.com>
References:
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
In-Reply-To: <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|SJ0PR15MB5823:EE_
x-ms-office365-filtering-correlation-id: 84cc6a78-6b4c-4497-7964-08dcc2205691
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkE1eWdvTkxtbGtCTHhnYlZtU3V3Rmpad0xnSlBTbW5BZllKN1NaZGMvL2tw?=
 =?utf-8?B?OGd2bE55TkJ6WDI3TVBKdStBRXZUV2JKYXBMNm1LeVp5MVdqNUQrWnZtMUc5?=
 =?utf-8?B?eWE0cnJuZ1g2b2lVUUN3RGVCT3NpOTF2N21LZ1lEaFNPMXpGbXpGZnhjZUcx?=
 =?utf-8?B?UHlwcFQwY1ZyNTU5d0hoWFhXSGp2M0dkOGxEK2tpTlAvM1UvRDJhNmV2aFRQ?=
 =?utf-8?B?cDRDbmExblBhMElvbVVJaTdhbHYyTEVONXRVSlQ0VUdvZE5HOC9xbGtBYVNh?=
 =?utf-8?B?YVNrS3RiVFZodC92K1ZjSlJoWTBudzRmNHp2SWY3ZnhTczdjN0cybC8wdnBa?=
 =?utf-8?B?M0xvbkQrblYwTDAxK2srdHpQZk9sUE1BNDE2WXBsNnNlajZ3dVc0RHkwejZT?=
 =?utf-8?B?YmZGN3hiRFRUZlh4c1hTQUxYUzZBeVhjcnNTNndMYll0c0tVV1A1M0tpOFlM?=
 =?utf-8?B?MVpqMlY3d1llQ3puLzZPSUFmV2FvekNDYktCMi94SjlYRTBZK015eDdxblR4?=
 =?utf-8?B?Q3NTM2o2RmVTSTRLS3ZjYjFWelViVDR2NTNOQ2psdW5IUzBuMHhZY2w2Q3Ax?=
 =?utf-8?B?UWQ5OWI1VURMV3A3ZWY4eXYrZGF2UWwxa1MrcHp5T09pZW1TVEpybXUvaG1y?=
 =?utf-8?B?RHRXTDQwTmFGM3gwVU9ZZE4vdHNualZlMG1SN05pYXVFZlhaYkxaZC9LUXBp?=
 =?utf-8?B?dHJNK01EQlNQbHhUSXlJOVhEYXJXY3RSTjQ2WFFweElsRmNYS0FXMnNhZHpl?=
 =?utf-8?B?UjdNZSs0eVhleks2OGlVZnpuTHo0cHRvM2JrNDBQbXl2a0d6aFlBZm1hWkNx?=
 =?utf-8?B?TVpNcmZWQ0huN053eE1BVVZrWjc3R1pFZmsvOUI5ZWl1RkZGZXpHUXJuRVFK?=
 =?utf-8?B?V2tZR3UxTXBaRk01K0o0WU5hMC9GSnRoNjd5UDhiNDZQeEFVQnZhMGNJMkdG?=
 =?utf-8?B?aUFJbXFtYktiR1RsSHFoVjNhUjdCOEx3YWMwY0VRaUZqcUYxL2lHeGtpMDcz?=
 =?utf-8?B?bUR6SW93M0hDN09nbk16MDlIZFVMVEl3V1dCV1BxcXdyamFsUS9jZzZyYmhI?=
 =?utf-8?B?SDk1NE45NVJSaW9QZktSbnk3RElGdmhvVUJJYVhjTTVxV0E2SitmdmhQVTVj?=
 =?utf-8?B?dncrNksrNVo4OHZFRVpzZ1FEWXFuRlBtckpEMklNTnZBUjhsek4vMngxc054?=
 =?utf-8?B?MEYwN3p5UWV6Y2lXaEZFa0EybGpKZTlzdCtTa0d1aFJDS3pLUnhBQzZwYU9X?=
 =?utf-8?B?Q3lpcitscmZ6SWJDMHJNVGZURGJWN1pSZ0RRMy9sTGJhTFZVMmZjWVBuVnBJ?=
 =?utf-8?B?cjh6MkREUHVSQ1JqYTB3QUZtQmFEL0N6cklRdTdDMGhSRXdXV2xmS21YQUx3?=
 =?utf-8?B?em45VWFLMERzaHpRNTZnb3NxUXNGYWdWaGdDZzFFazI0ME9qZkxhSEhDQm5C?=
 =?utf-8?B?dGRHdloxeTVmZ1Ivait5QWlsLzRqS1o5UzkzVC9DUkxOU0NFQ0xjQXBhRk4y?=
 =?utf-8?B?SGE4SFFFS1F3TzIxSDZLZEZQWUdVeGtHcVZMUnZUOHAwNEFyc05EdXFnb0dL?=
 =?utf-8?B?YzBvNnh4L1piT0xHZFZCUVVDMWY3NzFJN25pdU1HYm5VZ1lSTHh4R05QRERi?=
 =?utf-8?B?dUNqUXpDL1FUMWdwdGl3WlpDYWpncUovZWpWeXpFb3Iyc2ZOWlVvZ1ZBK3Nk?=
 =?utf-8?B?OGxqK3RMRWhkUzFqb0duekNtRDg1NWRxTEk2MUs3MnEzNEtvMDdKRUcxYTRT?=
 =?utf-8?B?MlpNZmdzb3lGTlpnOElmS3MyNnJFSHJMWmltRDRLOFdrRkhDQnM5RHJidWNu?=
 =?utf-8?B?OGNkb3d5UDZrMERJNStJNUI2bjVkQTVIckdyRFBHcHFzYkF4MFVUWWh4eUl0?=
 =?utf-8?B?R3J5VUllem1PZ001VjcydGFTVW5FdHphSzQvY00ybmMyNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c09TMUoyZlZLNkdCNk5VTHVjUDhoUXNkL0JtcW53dEp4bTM5TnIweEVremRC?=
 =?utf-8?B?UnozWVowT284VUQ4RFdMOU9lTHkvQUhMWGVXQUFoVndTWURxdDRocmxuZmxh?=
 =?utf-8?B?MDYwNkw5L1MwNFByTUhXbUgxK3JCSkVPS2N2NlRDckRjQzZQMHhtV1MrSmFQ?=
 =?utf-8?B?KzNsR1kybldSbUh4aGhTZFBkQk45amxIM0R3V1lSZ01ZSmFzQ3A5VXcxOG9Z?=
 =?utf-8?B?K2tIQTBOWmpmcjBacm9taW5Tek1HRjdldlJ0aFZQbFV0WGkrNUdab2s3dmQ5?=
 =?utf-8?B?ZGozdWl5cGxxd0F3QktNMzc5dE5zOElROTcwOWlCU2tubW05RWpmRGJKeVhH?=
 =?utf-8?B?cEl0WkVGVWw3ZkhqR1hDbWwwWXVRR1NsYlhUU21nZFVDU0hrbTFDSFpzMXF3?=
 =?utf-8?B?RE8xWEcrcnFBN0p1OGQwdUN5MHFDTWR6ZlEwOU1IbmlTMzFxTmdOM0tZaWti?=
 =?utf-8?B?Y2xONlQ0aWNzTE1wWUxKYzFtWEpQL0FVWWM3WHJhdXVFbGdjU05qNG05WHF3?=
 =?utf-8?B?czd6RnJnWnRTeCtiWnVmVFlUMzl0VDFhd3pqWlgvTjZXRmg1RzhRWHRrMDBp?=
 =?utf-8?B?M0N3R0FsZk5KbU9BdXFSYWFSTU85UlFuU3diaElmL0U1K1FDK25zOEhpeWEz?=
 =?utf-8?B?R0pOVFFOeDk2QUtWWk9LOFp5NDJpeVB5bUUvdms4aHdrWkszWVduTWlIWXFn?=
 =?utf-8?B?UzVNeXppVWFNVTNMRG8rdXBGRndRNWp2RkIvNHRqbk5HMnlSRkxHZ0ptSVFP?=
 =?utf-8?B?UDNTeCtIaHNvRzNKZWRoUjBzaUV0YUZUalJUb0laRHZaL3hTQmVXWHRmRlNv?=
 =?utf-8?B?V1ovRHY4Rk1oNHpZdkFwTXUrUk4wRC9rRWVlSmpSOUNqcjZaRUdXclp3aDVh?=
 =?utf-8?B?bzV2Qkx5b2FrMExmYmx4bkNqbmUwMDl6RnQ3ZWVSSE1mcDN4akc2bUQ2Q09t?=
 =?utf-8?B?c2FXUHhHQ1E2aUFzeUpneDdValpZcE5oaUNKaytqWC9kSWdGU3BQZzB4T0xu?=
 =?utf-8?B?RUdCZDlscytRSDN2eGhjcXpzc2hrLzR3YW1tUW9MQ1BOZTZlQk5vRkhRODU3?=
 =?utf-8?B?eFlsVjhCYnVqV3FoY0NDRDBlQUozM3djVnplS3dycDBoR2l6N0RTT0RHb2Rr?=
 =?utf-8?B?TG5jTEM0VkFDbHB2d3BSVnQ2eFZBbVlhNWdjTFVXTHhldDVPd2pBOU0wbVNp?=
 =?utf-8?B?NVJaOERGckFLSUM2bStxUHNac05LUTlOZXRhS1FheXdKNUYxeFhGL0o3SGVi?=
 =?utf-8?B?bjh5N3lFcmRKYmFDR3NuY0NMVjdKMFNod0pqMzFRdTV6T3I1eWJZaXpoVEhI?=
 =?utf-8?B?U2J6dXhXTmFUTkhDc09ORDdCQy8vVUUzTEJlejRRN0JGWjhFNVdML1JYOE4w?=
 =?utf-8?B?alg2UFJmb1RQY3dSZXhhNzJLL1ZuQU9BQmJ1dEVQQjlpb2xQK21ETm93c0Vu?=
 =?utf-8?B?M3F6WXBEOElaMHdjcTFuKzEwQ2FxdEsxd1EvU2oyNmxjUWYzbndIdmwrOS9q?=
 =?utf-8?B?Q1JFc3Y5TEF4a0h0UnExRzBPWjRGSDlyWXQrOWh4RjhCK1VHdy9jYzRqc3ow?=
 =?utf-8?B?QWFZNWVOaXF1Y0dKZFpWSzN5MjIrRXIvOUlsZ3pRL2w3a085cmFRM0N1c1Y2?=
 =?utf-8?B?N2ZwSFdGZnQ3SnQ0Z3QrOGdxVmNQb3F4M25tTG1PM1dqejBYS0sxYUFHKzdP?=
 =?utf-8?B?YVpjeFZ3MnB3d1daRnd0S1JUYUh5b01qdk1ScVdKMWFINThyVHZuNFBHNVI1?=
 =?utf-8?B?Z0lXWmQwTG01djl1STJMSFFBNGlPNWZMVVdUcytOQVE4cnBDMTB0MXFtRzRr?=
 =?utf-8?B?MUxZUktZSlRlOFA2dTk4WVl2eGhsYlpIWmFaNml6aXpRS2RVaFNsaTh6R3d0?=
 =?utf-8?B?dFlheWdOWE9YaG1MR2psM1V1MS9PT05aUzNKVStzNndkbWg5OGpIbDRuMnpi?=
 =?utf-8?B?WkJ5cU14bmF6RWJCVDV0Z1FsK3hQMGloUm1ENDRnbVlUd1ZrcFJ5SEN6K3pu?=
 =?utf-8?B?NTVQTlI2RXp1UkY2Y1hNeEhYUVJMU2crUWF3bitKU0h6UzRRUkpmNGs1VW1z?=
 =?utf-8?B?VGZhSTVjVnFtZFhhRkpDdlQ1dVVrMU5XdHRRR1BvekJyMUlMZWJiLzd3Z1Zt?=
 =?utf-8?B?cFFWWVIvT3VIUUpNSUMxZFBrZ3BOTHlrbnN6VUdGa0o1QlJoOVExaEtDWE1T?=
 =?utf-8?Q?dY9JYx36A8Gglo5yb05umAI=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cc6a78-6b4c-4497-7964-08dcc2205691
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 20:32:12.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUnCJBDY7ACUDw/BEv5H8ZBT73lnGf6jpNxOk5huuXpxPcq859MuLdyNQQsoGL45WvXvrW0y480pMadv7qrBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5823
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <ED573CC667F6ED449F9DF4B24856BA89@namprd15.prod.outlook.com>
X-Proofpoint-GUID: C6AMepS68PFMRpoZjBizAgwFMybgTxZw
X-Proofpoint-ORIG-GUID: C6AMepS68PFMRpoZjBizAgwFMybgTxZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_14,2024-08-19_03,2024-05-17_01



> On Aug 13, 2024, at 6:12=E2=80=AFPM, Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>=20
> >=20
> On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
>> +static int endpoint_init(char *flags)
>> +{
>> + SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TE=
ST);
>> + SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>> + SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>> + SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>> + SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>> + if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2,=
 flags)) {
>> + printf("'ip mptcp' not supported, skip this test.\n");
>> + test__skip();
>=20
> It is always a skip now in bpf CI:
>=20
> #171/3   mptcp/subflow:SKIP
>=20
> This test is a useful addition for the bpf CI selftest.
>=20
> It can't catch regression if it is always a skip in bpf CI though.
>=20
> iproute2 needs to be updated (cc: Daniel Xu and Manu, the outdated iprout=
e2 is something that came up multiple times).
>=20
> Not sure when the iproute2 can be updated. In the mean time, your v3 is p=
retty close to getting pm_nl_ctl compiled. Is there other blocker on this?

I have updated runners to Ubuntu 24.04 which comes with:
root@1fdd5d75581b:/actions-runner# ip --json -V
ip utility, iproute2-6.1.0, libbpf 1.3.0
root@1fdd5d75581b:/actions-runner# ip mptcp help
Usage:  ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]
                                      [ port NR ] [ FLAG-LIST ]
        ip mptcp endpoint delete id ID [ ADDRESS ]
        ip mptcp endpoint change [ id ID ] [ ADDRESS ] [ port NR ] CHANGE-O=
PT
        ip mptcp endpoint show [ id ID ]
        ip mptcp endpoint flush
        ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]
        ip mptcp limits show
        ip mptcp monitor
FLAG-LIST :=3D [ FLAG-LIST ] FLAG
FLAG  :=3D [ signal | subflow | backup | fullmesh ]
CHANGE-OPT :=3D [ backup | nobackup | fullmesh | nofullmesh ]

Assuming I don=E2=80=99t need to revert back to old runners due to unrelate=
d issue, you should now have `ip mptcp` available.

Manu
>=20
>> + goto fail;
>> + }
>> +
>> + return 0;
>> +fail:
>> + return -1;
>> +}
>> +
>> +static int _ss_search(char *src, char *dst, char *port, char *keyword)
>> +{
>> + return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | gr=
ep -q '%s'",
>> +  NS_TEST, src, dst, port, PORT_1, keyword);
>> +}
>> +
>> +static int ss_search(char *src, char *keyword)
>> +{
>> + return _ss_search(src, ADDR_1, "dport", keyword);
>> +}
>> +
>> +static void run_subflow(char *new)
>> +{
>> + int server_fd, client_fd, err;
>> + char cc[TCP_CA_NAME_MAX];
>> + socklen_t len =3D sizeof(cc);
>> +
>> + server_fd =3D start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>> + if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
>> + return;
>> +
>> + client_fd =3D connect_to_fd(server_fd, 0);
>> + if (!ASSERT_GE(client_fd, 0, "connect to fd"))
>> + goto fail;
>> +
>> + err =3D getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
>> + if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
>> + goto fail;
>> +
>> + send_byte(client_fd);
>> +
>> + ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
>> + ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
>> + ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>> + ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>=20
> Is there a getsockopt way instead of ss + grep?
>=20


