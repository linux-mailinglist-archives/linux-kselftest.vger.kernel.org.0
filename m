Return-Path: <linux-kselftest+bounces-29830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACDBA71F17
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EED3B2633
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7F253347;
	Wed, 26 Mar 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IOwyt8lC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243423C8CD;
	Wed, 26 Mar 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017161; cv=fail; b=Zr+XwKTXwD6EOk/mN1nAxzh98MmXAm7n1Oravhfon0rD2egk74dH+OSt4/K8oSG1PYGoWosJfptsYZOJL7cx9Rr+qzdotgKO0FwWF0mBSXF5smxEWfSH1sgqsdZAVC81rWu4zUb9dTokfH8dJny+cgNrQ+ZckzEXyBbhmN3Yu4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017161; c=relaxed/simple;
	bh=kR8KuNRklVhbrcrTjj+3DShM5ZEt3wLcZgD1QXbVbOk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ckd1Foz2oOtKGoeVHecekZxnmdbbXwSEIm1Prneq3E25Lw72ZhwPH188E+nJ7LrYEAGbZPTbtETNRAFEiMit+Iu8PLkSDW7oSEnF/ED81XBo/kzMDaZzdwEHL8e+q8fGnV19LjdJcCOtwGKgvUQL7d5B7Tr+m6RAUa3g3+wFBOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IOwyt8lC; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpFLBx4ZpmIF30fn6jcFsvczny+40E4jaGi9v1mPbcSBkymfckYSqh1O8m1VUYdWjTQCMtafu9WXSKUa9hRCeeJqq2NOug2nWKtHDpoFwUrOEPaLhAQR8BVVwqrhax+Lgn9avNln8/sYT4ohYTgEFI5Zcytvamve9WpCc4n7a4VLkH2y4YlXcW7Xz7Km+fJdDkO5FBjBGtrhozcbBYS3FL6zqdQRvRU8XMBBcT9hXmQM1tzGmduT5opcP3cAWElX270tgb6pQVQpRXvl4vq2Tnd5yhG6YiOdocK+82HUAUBrDSBoYcRTRd5Ia64V+/aHqq25E82Hiu3P0//wDZXRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KCf/sp1j7qUBa4QN4NX7YCpUc7uaNL3Xfe8l29beL4=;
 b=WjqhRT6THV877ZZnRN/vu8l5HroN7VblkKypPqdkHe51mVfMSyzHc+w3UflxLZvAQx4OF/vM6jovFz1n1wzaICSulBl9GtcOdoU7LvuxBw6P66T/suMDlDWtPnbrmGgZdN5/zT0MdvSmHm/DWf4F1kPANctQufh0onRNP2RD6vJYr9ifkurgcCoYtW6SvLFv/BhjIqREu14Wbh0c0fc9gyf26Gp0XBLlvpI8uveIP5GhKp7uN/wKGui47tLX2Ev4DfAyg/UcM4OmMWxnXULnXRpGo1djgy62x14geJWfvaJQAfcCoMRHQlYTAGImZ5R9vwA1f/S7SWXDppKKyVNYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KCf/sp1j7qUBa4QN4NX7YCpUc7uaNL3Xfe8l29beL4=;
 b=IOwyt8lCfrkZqmEtoLOvwxpdraBXfRhFz6QzSbUKhxdfuUnsvZMoCJpxI6efeQDBsxm6KMg1F22bAT+m3mQyZGoPDQJIRdhd11v6zxnMQG2K5zEw5ECOInYyAHDLARxWqjH4ZdV21+oXhHmM3i8DWiyn7pe3DBZMj5c9hganP5lnRb4KrXEPqIYRl20/tKlSyUlgnbxFbD/2lYBc84ZOX6OM0JCHvK/Ex5H4izs6Ma9Wt93VQ5oPT++Dp12TejijAbVJPwHSIk5Z/iQZTvBO92Ydhl/dWADlcby0R8gQ0D6nn3knRs0J2nC1MooQBJOcoXbH6BzmSAe7/jW6OPJ1oQ==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AS8PR02MB7191.eurprd02.prod.outlook.com
 (2603:10a6:20b:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:25:57 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 19:25:57 +0000
From: David Binderman <dcb314@hotmail.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: bug report for linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c
Thread-Topic: bug report for
 linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c
Thread-Index: AQHbnoR5eR3ADo08qESxhVQPTY+LKg==
Date: Wed, 26 Mar 2025 19:25:57 +0000
Message-ID:
 <AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AS8PR02MB7191:EE_
x-ms-office365-filtering-correlation-id: fb3a79aa-61df-4793-578c-08dd6c9c0904
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|8062599003|8060799006|19110799003|7092599003|15080799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qhVU/BYJ4IcxCxGA3EGlVUP/ncBCLyv+TlJy/ZInLqLju0t6BVFBFahcYy?=
 =?iso-8859-1?Q?kErF1HAhoCQVBoF8mOrRJ2wWB4KIAOD/Ut6J4crh7vr1Hfrxa4z5rw5Nb3?=
 =?iso-8859-1?Q?YxjudUV7pA7ZYuVSi4L9NGrAwYNp85LAyrLqooHmq4w21kDrZMw9TUDJQ/?=
 =?iso-8859-1?Q?JtPufzDNmkuuoYg44eb1A1IWS6vT3yDJhfmUV5sK+0ifJ/HYz3qSzcyuI4?=
 =?iso-8859-1?Q?JBLrCDZGZ/thHeC92+qVkh3tuv3KhAjCByVSjAZE88PqxMfa7VDrD/atQP?=
 =?iso-8859-1?Q?879I/plpnhRUkcwJZPihE3fIJfWwnY39tMaN7i6n2Kw+aPmUkO6aINTxuD?=
 =?iso-8859-1?Q?B3hTU7yCFt4qLb994O9Z7TRIC1SeSx4EyNvdAnTjlmz2At5nZmplrkacU2?=
 =?iso-8859-1?Q?0weu8NxdDA2QJMH317k1eP9cANH28L9cIhjn5sbL6Jm0801CKkigXvyu/0?=
 =?iso-8859-1?Q?O2K3Ooo+9c/3hJfeeHWCw3J2kNwrxp4SEeGIo7rkKUqsZiSfspJZufy9hg?=
 =?iso-8859-1?Q?dDBEyZmdCO7koRsLWjjgn1v9a2lFWw1paVMd1XAbbAISETOyl2yQUS3X2s?=
 =?iso-8859-1?Q?lYrdyTrrfVv17WqapUaWnULG3gztfWm7WW6ka/fxocct8kW25HDQkbxNFy?=
 =?iso-8859-1?Q?om4miGzuvADgNhypxHZP7o9tKSYMmCLc9CO/zr67ClBH0kdK/U2BY/OA1Z?=
 =?iso-8859-1?Q?VrXRm9SXdvl7ALWRYz7L3bTea6KVtIf/XC4daFVa70yZ/yIQDNz+OV3cAS?=
 =?iso-8859-1?Q?NJoLcEfBhZV94LSDrXaEfvSB12Hy5PLDUHU+OaCq0LgcdK3hzAB1rE79Ih?=
 =?iso-8859-1?Q?6UiqXN5PPPKN7P6lag5fy8i3U3cz7pODpep4wUxkM+2sUTlGs1EalJVPmk?=
 =?iso-8859-1?Q?kmK5fnE/05n2A92onpbBDpNxqTrOvUqDS6VcBPXxmA2KhuKipqa08babjX?=
 =?iso-8859-1?Q?Lie9Ak8MQ+dWLm1yQVOMbQtg/S4iUwwscu70TxHildxflvJNwHefFH3a8a?=
 =?iso-8859-1?Q?bnlqfrBPme1xi3b6ZCxJB0jn34N2VyUivyFqdXQJFJM+k70b/pclBwMV/Y?=
 =?iso-8859-1?Q?EJ+hye+lfbDmpverlAH5+LtEDWjLnE9HCRWmeqQd0MSbETwATIfPvlodip?=
 =?iso-8859-1?Q?iqNYrNHBrK3995OplgelKbgZ1hWaD3pOBxkuPV9z3BPo2X547r/JCIM8XH?=
 =?iso-8859-1?Q?cDVTJ8sJMjXcmA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ztuVBiabltmzSG5lQ+USZ3f4rFAqXyCL2GyAdwX6TZgwlje0ho22SNb+db?=
 =?iso-8859-1?Q?3nU8UQ73YzJux1pYlx3pS57R3SBbokFWle4ByISOrKJBck8D/pVlY8mq70?=
 =?iso-8859-1?Q?PX0LvrjsQmr7i2T/j+L+Qkf+SQVwRafEyjeOE4jNt9LfQiZB7zJKRCctX/?=
 =?iso-8859-1?Q?JcvSIL50fV1ki/0vOEME6DQSyOu+u0n2DXFY7SiesrQc3uUStmdq3K2R/H?=
 =?iso-8859-1?Q?W3wVfySWa9ddxzsMDB/IOCKIIINfnODrsXntMsh9gx7mAoRJnEnSy+RTF/?=
 =?iso-8859-1?Q?ETnHu3nWfQVBLc1hFY7hU0gXYOonAXCOWY9mbSqtLqD5PP4l/BZuY0ZWjN?=
 =?iso-8859-1?Q?JzxYTBRur7mRB79okckeJtS/dDvhlGuBbERE2qRXScvK9VOn0TGbPSfP3X?=
 =?iso-8859-1?Q?kCtDO+bfHVe7KW1+JSc5A6fkHkrlgqYVT59knDldwMOExyMHbYgTGfzNGk?=
 =?iso-8859-1?Q?jtMw0IegKsnymfmoX5pOpk0vvl76vg+5Y0bBWd/2soxvs4lmA3EDzzdVYW?=
 =?iso-8859-1?Q?KF4UCUby97kNHJlgqr20WCPhudYQhDDIHULQuC4P2eJ46k7y6H5lUEwtLp?=
 =?iso-8859-1?Q?7IyhQOkid+q2GjbSaIMP9LQ6yFYESPU+BpfoUC1JEdZ+IspYQtLORVjGhr?=
 =?iso-8859-1?Q?Z428IFRnYrhxmyl+RJUHSzldFAM43+QcfWs/ZqXt+5F3LVFyFX1Q/iuQCI?=
 =?iso-8859-1?Q?UiIIP9DlMzQ48D/SqGauaIBmzs8EPbO9MD8WcowyTpJETqHhpdGGOiTSbr?=
 =?iso-8859-1?Q?jtrL6nCwbGohVo/fIdFQikY3QPRcSPN8kTHob9bfbq3CmwJXcEkrP3Bzsu?=
 =?iso-8859-1?Q?TzOn+6mIS49jBb7VqSsmHMeBv1eKSlNZ8KfyJktX/Hh63e4L7wXig25aNy?=
 =?iso-8859-1?Q?eY8zkcxXcDrzS0DqcVCN8gBsZCyk4HRQPHc5ITpCspZGTBFbBmNTwrHY4E?=
 =?iso-8859-1?Q?QIBykiLKsVLTYRxzWfSNW0NyuNAKPUaTi+KxaHzq5WUipiF0dDDC3yH5zi?=
 =?iso-8859-1?Q?ADWqQqY8GGPZouksCAMVqiqfuujqnqOB7xxaySY89sC4kvISKaks5nuyaS?=
 =?iso-8859-1?Q?zYBcNA+yU9qo9TCMbgjbbA0RpiSfflHZTCVzQ43KJcoVbs4zByoE99LZ1t?=
 =?iso-8859-1?Q?fAfZh2si4KXf7nO4+BmHk906bzBR6bWYVCUKZvcZp75IXIzPotbwpJxrOX?=
 =?iso-8859-1?Q?09HQMOOSnPtFCK+ydQffemlqlZ5CReHWcd8ygCW/1dHc66FVoa9lMZH2iA?=
 =?iso-8859-1?Q?KmKOCxqqSCV7vRtCGTMg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a79aa-61df-4793-578c-08dd6c9c0904
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 19:25:57.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7191

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1061:11: style: int=
 result is assigned to long long variable. If the variable is long long to =
avoid loss of information, then you have loss of information. [truncLongCas=
tAssignment]=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1510:11: style: int=
 result is assigned to long long variable. If the variable is long long to =
avoid loss of information, then you have loss of information. [truncLongCas=
tAssignment]=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1523:11: style: int=
 result is assigned to long long variable. If the variable is long long to =
avoid loss of information, then you have loss of information. [truncLongCas=
tAssignment]=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:247:11: style: int =
result is assigned to long long variable. If the variable is long long to a=
void loss of information, then you have loss of information. [truncLongCast=
Assignment]=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:435:11: style: int =
result is assigned to long long variable. If the variable is long long to a=
void loss of information, then you have loss of information. [truncLongCast=
Assignment]=0A=
> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:490:11: style: int =
result is assigned to long long variable. If the variable is long long to a=
void loss of information, then you have loss of information. [truncLongCast=
Assignment]=0A=
=0A=
The source code of the first one is=0A=
=0A=
    mem_size =3D 10 * page_size;=0A=
=0A=
Maybe better code:=0A=
=0A=
    mem_size =3D 10ULL * page_size;=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=

