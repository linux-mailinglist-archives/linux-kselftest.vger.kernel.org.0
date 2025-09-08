Return-Path: <linux-kselftest+bounces-40954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526EB4946E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CA43B9BF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8530E0CC;
	Mon,  8 Sep 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmtWr8sZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398130BBB7
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346932; cv=fail; b=W2i2Jv0BBskd3DAN4WSk6FmS31LTwlnXsJNfp+eXqLdmidmKgDY3/Fm9wz/NMWOVeyiOXCyiVQ9FW8kJXFZJvFCvLIPD6u92zz9/ga/5a5jEvkQWCZZnRZQtWY8yX2zs4mROHGYfMfYX16fVgrUJK4dDpD9eG7G9q8rGpyb8UlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346932; c=relaxed/simple;
	bh=vlpsI0jT+9Ff5bGdYS+gda30ANDpF801Fik0C/iQmX0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tSlpVHrTss7Ke86iqx7gcwqqLfSxgk2Z2/WISAbE5bBrw319OcOaRwj7tpuhdDX2VgjA1EabE7svUc1vNh3pXAHIvTPCJHNhzEsmZ3z3wEkASQpouwXi78RuazRymkmCcjpABS6YjSgbNJZFCdaTTKh+bfbI8oLYG50IUAewMH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UmtWr8sZ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889xW2H031713
	for <linux-kselftest@vger.kernel.org>; Mon, 8 Sep 2025 15:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n2JsY5
	H2M3KKYp92/drrSvxtxNWuqVarNIn6kCSaoUI=; b=UmtWr8sZTEoDR+Vp99xcix
	3h7eUXzj7b7QTcjCksNnF7WXZEE3bkp4Akb/S0HtcAsjoDhdyvN5a6Q7j/lvwRld
	TBxM8geuPWc7CQ2zmjO8MW0WTN5ATu78JE6J2wA96H63J7xKN7CBln31qNQhkBPe
	ugHTpcT6OkUHdZ8aPYaLto9GbwSbbrXsXurdbtxR/yFiJsqOrugg4EPNkk3A6v+r
	snSYIzxr9psxRjKWZck9q6cSM+xkdypOMZH9YoHScI/nRJyXUIr7ViY8hW4bzPft
	yX6ygRtVbb4Jt8GYZVwQkcwnhrrAuhPLYOj+SOvt7cVC5uoNOcWWuHDUaqXpUMHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsjd7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 15:55:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588Fg6FH013774
	for <linux-kselftest@vger.kernel.org>; Mon, 8 Sep 2025 15:55:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsjd75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 15:55:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588FqjXC002285;
	Mon, 8 Sep 2025 15:55:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsjd74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 15:55:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGwXF6HqSy2AlJ1g7mhwTN4wSJ0wiVtAExYaw86qFx29BISfRzalaktWU+bOu916IsXgJqaAGOI1xK+hw9LlSjT9Bh7+6Hp4Qx1d96GgI1Gtd8j5XqeBmQ3VOtot6yVRJKXRNZLNGG1UVOmY6h0Xvs6taDkHeTd2BIUPPbaFDCv4MW76pRHihqto9/CenvKGn6W4ndd3Ia1hufdGKhxBt4HhCoEZthhOkPoY/iLQCFRCHhvNu9nR+n6l4GgVkpuepa33emMUz4/iBXgVUgUtVkVFTU4G3vpe3ZE1mUEO8yoJutbLzB2HaoR2rZcr/Q95bLEeCErZ1N5UseGuaj4A4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQH/3D/eQGu6fK6EI7DCOh8C81L3rqwpevbBP8/eFak=;
 b=D6l2QRHOWV7oxGwdx48uJuWMqZi0YrKl0DtyYq0+qyHQXQPKZUJOd7ahZfCfr7OXMgnIIPOBSqgwjAVveB2GGNJ2eQcPOXwCl8g0FvEyocWNEavjZizugRdGBUKI0rzcVAOGLV7TP2D/tsmpcJhZIlQkfIjqe1evFhdfp32SlLpMbycQB0fGkArp/RqczATpkEbKnp5V94Y6kRwxNV5pxg5foK5KqYr7tmF8zdjmnz7Ek39iogUaVT/87xTsIKS/lgVIoApC4nq8FQRFrA2rJYchtHzUcLM+zzR8SwiVQLFaH+SBI750G90jaZFPHuAdNh4/GduhcjAqTKrCo+WaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SN7PR15MB6070.namprd15.prod.outlook.com (2603:10b6:806:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:55:22 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:55:20 +0000
From: David Wilder <wilder@us.ibm.com>
To: Hangbin Liu <liuhangbin@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCHv2 1/2] bonding: don't set oif to bond dev when
 getting NS target destination
Thread-Index: AQHcIInDnf8WoMqaO0GW3jyZVxkHM7SJb1lh
Date: Mon, 8 Sep 2025 15:55:20 +0000
Message-ID:
 <MW3PR15MB3913C6107F92F772D84C1750FA0CA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
In-Reply-To: <20250908062802.392300-1-liuhangbin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SN7PR15MB6070:EE_
x-ms-office365-filtering-correlation-id: 679ac1a2-cff9-4ba3-edb5-08ddeef01d52
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ay7XaXz+OgmwNnG9CwSpRZ1wPqUwjSuGklru+g0r+VSa/8ABo+vrW7f7YR?=
 =?iso-8859-1?Q?C81tTnsYQMaBZLqdkWUENj0E1WOaDi/T64G/AqUISJleNcoAh1sJPueGb8?=
 =?iso-8859-1?Q?XeZv0Ej9eUCvG/EBga+fOUPZ4cLAaoZcSuBH8ZGnSmw737LyFC+as7IRhu?=
 =?iso-8859-1?Q?8cNDibzz7ABKkSjhle+JhImpKVHN/J+Uftpy8ELQhF+gBStFvvl5ol6ugJ?=
 =?iso-8859-1?Q?ut+Cafh3YcUFpAdka6d71dC36LB40wsI+WsCR0qXPvABkhm3xl6KsQuplw?=
 =?iso-8859-1?Q?n/kdualp1ewfmJRySWfcVzwbypdOHutqsc++tQHvHuxpUpZ71X+4pkEbgB?=
 =?iso-8859-1?Q?Y/CdN8ylIC/N5/hD7JiQHMzynGRoiNSvLXES0C/YmuYMtiHd+cqCL0xUq+?=
 =?iso-8859-1?Q?sJe8GyrQcC7UDDJ9fk86wtfdOrVLneonEqHEMlrFzFno3yiURPf5a1kXuY?=
 =?iso-8859-1?Q?V2Xhj0TBlNvECucKaikMt/H4iI2b7MhNTIRtQ3AmB2C+OXS96x7+6vsiEU?=
 =?iso-8859-1?Q?fT6oehRXHzHvOn+Sd1YNTt7Cvs8XS61zGaw3tpRFZW0BWym1d6BqbwZFt2?=
 =?iso-8859-1?Q?R2QuF6S1kXlCqREN2SYqQSNY2BFDuNufkGtC5Vyi4j1s0zFOhRgRknZcMm?=
 =?iso-8859-1?Q?Yz2X0M38bnZ2RA21/BJVR3sb4/oBZEFJ5OZeh2bllv5YRSUObF46JluZHI?=
 =?iso-8859-1?Q?iR976UCSFx3HhOXfacxP31X0sAUY6dTbdNRZ3hnACtzW40e90f3H3HnhBN?=
 =?iso-8859-1?Q?sIs0ZDMdgUwNC1JSqcqhCNJaLCRgcGLwUL66iS+DprQ9mKzzYGJTjjEk5e?=
 =?iso-8859-1?Q?XHxsq0W7NDRTlKnxw0XRt/0h9u4SUJtJ76JhlPjhjqigjgPCn1+S6pw6Cq?=
 =?iso-8859-1?Q?A4NUTJQwTa43y3xBBjoa/N2MWjQYf8shdqAZNJSwCn9xlobVxKp/u43lql?=
 =?iso-8859-1?Q?FC32MIozOMoDI2iBjDSY+2Mk3UBaYFwqj+zyPh3pqYLsAPrD+ouzBJiiy8?=
 =?iso-8859-1?Q?RZAf22wqHVN77RtuRcDpAsZAPOJ0FnPpn6UAZ3mJu5JwJveufq3z83qpW7?=
 =?iso-8859-1?Q?SJmxm0UK+sehN87+6SidDAyFYKbo/evAYSnvmYSgCj07tP2VfRcH432eUv?=
 =?iso-8859-1?Q?Af8CHQuP+5iuaWcQaE5Cr5xnYdEUKm/9uYyIKipn7eWaecw8QRVSmizgEX?=
 =?iso-8859-1?Q?9HzCNY2g4BtE3RJiBTe+QRcbRFcBV0yoM2hEvhIMdJRsqAvM3Utbk6u3uI?=
 =?iso-8859-1?Q?7kfQDBky0hQnlRcbp3TZm+nr8Tm0VOCnpUKKcXo3qXAsS7KqZL3bR5brKU?=
 =?iso-8859-1?Q?N0ZLJSoDWFzYPeKbQbhiJqcF3bPxgTZClc4MwshMvS0GYRIjWlLIw/YWRV?=
 =?iso-8859-1?Q?QionFygMB/Bs67faY/R2mbSZFfl1aygpBtNE7KOg+ZUtfx8jYisTPwwgJG?=
 =?iso-8859-1?Q?rzb/LsgNesMKPZddYXkMYo3cP8JWWfSzUGR0WU8YCeern/6lO8F4iNAszW?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fl/UKineBnkxXoUtSBS2JOF8jVpzzlvUce8isi7jjqt2PS9jpRxQOCuOmM?=
 =?iso-8859-1?Q?AdOlgBSdurPcJK17p/6AVZB0ImFBS/5nKS1XBDZJVBYxVF07uEQZ3lg1Jz?=
 =?iso-8859-1?Q?juiKPHRMQZfAVsvKn0OimS180SjYBjSp1xfwoLVmmDDMh0NJdmCrMyc1kp?=
 =?iso-8859-1?Q?ZCr0C4fomGVY+KTiK0DlcAhx6HMCbwymkwxj/cctabMAXTWyEdE6zTM+6l?=
 =?iso-8859-1?Q?yRukWYU+tiUqAmSxYTLci9VeVmrHu3bk3nzpMh2f31PDQC4kK4yCJlix78?=
 =?iso-8859-1?Q?6INW+3xQBMKRWMpwRHtH16YnItvp+aMrKxwTSZS4kdLGiSbcOw5gCrS+Jd?=
 =?iso-8859-1?Q?OJSBN76kBK83W1L2tE1noZKwCXDYmAig0FboHmoFto71I6Nap4lNRMTIkV?=
 =?iso-8859-1?Q?bbsxT60I8j9xSOKkH67DFX5tat9JHfjysxAg4bsI7v5vsg7VqTOPaIHv9R?=
 =?iso-8859-1?Q?B2gZ3cOwVurk7bnSEqNsYMFAQpH1jJaTNqCgiGumwt/1Q7oy804JbXHehj?=
 =?iso-8859-1?Q?0jQTBbt6ZVj54RllxzUxkczPvokCO9EC4YpHi/vdO2pYqaGlnQoij9f2/c?=
 =?iso-8859-1?Q?y6GjHCOWgNEpi8ayZf7MZMKVMFAnKADKtYeyCw6lNUWwCm2gWO3qjJMb6I?=
 =?iso-8859-1?Q?u863SUzYZ2+Yz3168mEWDWFQtP4YC/IvO60fGHZa8IuB9lDWMFJkNvvw/I?=
 =?iso-8859-1?Q?134o1jIFv63YFOHW3vC6fhPAnUxdcMfSg/Lj06fqmL3QFN6erpy7a5JHFo?=
 =?iso-8859-1?Q?BJ/1bj+FRoYP+V+cImrhkfIUVEUFxr3aax4DDhlsZgv/alwnk2ShYer1C8?=
 =?iso-8859-1?Q?Y0YdeqJIAR0FdHbdstVDEJr0VAv/SHzuYcyOq/BliH6smjaQJZH2KqE9mj?=
 =?iso-8859-1?Q?1FUaqcUKx61zgdR2/8qDkTZYIAE1mgjHj5XfVCG7AUAM9SYfjM4NityidO?=
 =?iso-8859-1?Q?0WSBu5e5cRI5VPz+0Yfh+Eak98xII4KyAYZkgsp1KvlAFpFyqn/xO0TFLQ?=
 =?iso-8859-1?Q?bY/QarXRR1bBlbM7yF194ItUAZGWKUxZWfdHPkZF51WdFMQxSLvG7ra/UV?=
 =?iso-8859-1?Q?gVdPURYpvuOpVeudYO7QGKsn2Z7dtQqHUQ4hFV+UqpTbh7f+nva2UhdGpk?=
 =?iso-8859-1?Q?UEWbKtGJaL7vFBNo1cC6jzUgsr2QqnI4eQfAM2ERABsUwz6bGnBfA9SHef?=
 =?iso-8859-1?Q?bBQCA2tqf43DA98kUPQS+WaJRy+mpmJcQprHvlw7xOtXuvQPSgCrpTeWo7?=
 =?iso-8859-1?Q?rfQitUODNZHJVK9shjaKt8ubx6ORl9AMlxESEHFsoCS6DTsO2KT7d1hSG8?=
 =?iso-8859-1?Q?lxsp68yoLQZ/TL6BTn4i5n7pTcKk7nq/wIoauJ/puXl4ZhJYOjBMSid1qK?=
 =?iso-8859-1?Q?CijaAd2RnwH6tz3Ic4BA1uSW5MrJMUe1Ylg3b7c5ASAA8q/TWR0Ei8Wt5Q?=
 =?iso-8859-1?Q?TBp9p5aHE7Nq+urEgneivdqyivuT8Wvy8Iy06HbyEh6y+B6SJZZGYv76xE?=
 =?iso-8859-1?Q?FOYThWwAKsoLvUpI0+1uhhpqPRKO/XfXl/z867/nbFN5D+N0JkzLdGNkNI?=
 =?iso-8859-1?Q?jqq452rucpUsGXHpKmprpbkXa3hcFax0W7HjbKcZdcvLQ1tXQPgpGuex/g?=
 =?iso-8859-1?Q?IvksJmRiDG8KBs4A07osjaMuLZqEoH+xDoyG9c/BGZt4D3gsGVS+LiqCUA?=
 =?iso-8859-1?Q?WwPfksp2w50LXHY2cYk=3D?=
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ac1a2-cff9-4ba3-edb5-08ddeef01d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 15:55:20.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCeogLW8P6nMcwSMn46VbdQfNlEAdId2y7QNkXLAuBG9ttVdAGnEW2Myo/E9q2krfNxP4/QIH/QlfLCUV5JDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6070
X-Proofpoint-GUID: 1r8PStcFuk8BLRldZ4JNF6P99zU1pZhZ
X-Proofpoint-ORIG-GUID: v6wRoVxXMSHtnlNawT6q8k3TGGFV5ZJj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX1OnPHRud/X1R
 Kbyuniu9+JT+k3HkaNbYQKXBln9q2UI903oZeRkjy6iChD+136yrkHASRXV5SS6Zx5qpnAjZkMM
 HmnZzahaz7l0jtoCGzYvcmVxsBi6WL5aZJ2zSE6Vg1nfjxkHyLjTardxBeh++fFRcHqQ7Qn6KFJ
 RNzKRI5ql2A51D81NjmdiQV8yDSxd2fUsY5M+rOfDb49iQR409SBTBmN5Wfbu9iCE1qNLWzAX8v
 WckREZmw3YPudjEh3jxR6qver8gjSErZk5wn8ZMy7X79bfiNKbQWbBpgFD+8rgeS21x1OcJYwEd
 regdqfFm5u2Szm7RvEDWFLoPgVTb2l+dQCRPNO9YTBehx0uQeSObPzolCqmLiUB5L+3RvQgp7L5
 5ROj2Hoq
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68befc71 cx=c_pps
 a=iNbKu3seLnfQiesHBt/AFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=2OjVGFKQAAAA:8 a=0tQDRS-zP3QmMU3WfwsA:9 a=wPNLvfGTeEIA:10
 a=IYbNqeBGBecwsX3Swn6O:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCHv2 1/2] bonding: don't set oif to bond dev when getting NS
 target destination
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2507300000 definitions=main-2509060010




________________________________________
From: Hangbin Liu <liuhangbin@gmail.com>
Sent: Sunday, September 7, 2025 11:28 PM
To: netdev@vger.kernel.org
Cc: Jay Vosburgh; Andrew Lunn; David S. Miller; Eric Dumazet; Jakub Kicinsk=
i; Paolo Abeni; Simon Horman; Shuah Khan; linux-kselftest@vger.kernel.org; =
Hangbin Liu; David Wilder
Subject: [EXTERNAL] [PATCHv2 1/2] bonding: don't set oif to bond dev when g=
etting NS target destination


> Unlike IPv4, IPv6 routing strictly requires the source address to be valid
> on the outgoing interface. If the NS target is set to a remote VLAN inter=
face,
> and the source address is also configured on a VLAN over a bond interface,
> setting the oif to the bond device will fail to retrieve the correct
> destination route.
>
> Fix this by not setting the oif to the bond device when retrieving the NS
> target destination. This allows the correct destination device (the VLAN
> interface) to be determined, so that bond_verify_device_path can return t=
he
> proper VLAN tags for sending NS messages.
>
> Reported-by: David Wilder <wilder@us.ibm.com>
> Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/=20
> Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>
> v2: split the patch into 2 parts, the kernel change and test update (Jay =
Vosburgh)
>
> ---
>  drivers/net/bonding/bond_main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 257333c88710..30cf97f4e814 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, =
struct slave *slave)
>                 /* Find out through which dev should the packet go */
>                 memset(&fl6, 0, sizeof(struct flowi6));
>                 fl6.daddr =3D targets[i];
> -               fl6.flowi6_oif =3D bond->dev->ifindex;
>
>                 dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);
>                 if (dst->error) {
> --
> 2.50.1

I verified this solves the issue with a single level of vlan tags.
Thanks for fixing this.

Tested-by: David Wilder <wilder@us.ibm.com>=

