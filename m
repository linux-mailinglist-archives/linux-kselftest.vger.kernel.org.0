Return-Path: <linux-kselftest+bounces-21315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC269B978F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E341F231E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0BD1A76B2;
	Fri,  1 Nov 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSaQCnj1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E316146592;
	Fri,  1 Nov 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485963; cv=fail; b=VsBfNMUpNbkaEMKQUDCwGY9gz7RakP15JMitr66KLdYt4AugOQi4+lVuRz0zjfBKBqfA+jGq5uww5trdv8nVpLUrkkC7vgaE9A0EppWsRn2b0NgtJ7SBvj16Y3SYFskKObvKg6fY2GMIZS+GgamhMNZLBYgQqFg4Dna6HmEWPAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485963; c=relaxed/simple;
	bh=Aup3PSJBD1eZa9AMaYt6WUm8gJPcPV991GVjA/KLB9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtLnOJifj2/KPH+vYOS1OvlR/b0guAGgCRI1n6q0wTeENjr7QwEm/I6XWV3TI4n6hxLAgSwXXb1ivkuSKD/QXXo+6Bgi1Vm60S+tl1+wWWWxveKD+KXZKPPsU9uorE+2gXTACfovAUhJsUMrpTIBgjPoN6fmtoyY3cke7nxLvKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSaQCnj1; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRZVlR5j3hqtxRQYeFXTSErUvx1RRubGlDVNTvEjEntIacgQ6BJLn9ArXKrJwTl3k7Ay5k1oUjnfNARhOmnYY9nHkmrjCRJ8abixZiCoizVVY8qNufsNn3PNwutWMfZVzsg7ps2TszsE9jFRG/z1hWuFe22iogk3N4iO0CChAxCyFN+CipGpgzJqZXDmrxS+cw1Q1eTJdvLh3kAxKdPpd5mKWEQyVnMP+Rm9nBhCt80aSqtkT58907iIGnPhUuQ8R4fLafRMomGDo74bO3nX61GMXkPZAOp7THHQFyHzu2aMnS7xMeSk2+fNC1TLNAwSX68na3mB1ZdHe0zO9khU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHUPC37EGWnPKHcuK5ROYeSIEHiJg2nJ8tViRLOtqtA=;
 b=HpM10Zm9yxi3G8gnx6S9xvYrlZBPEOAZAX9EvIYsv0WDJlAztH8L06iI2pTkpjTFlaauASVVZFRcBKg/Vb7oPBOopPjCo8qi5WU3bcXVLQHm6ywu13CbJptzM43MF24b3v8AU8ZjOiX/sY4GoTojLjSqUY2hfEwxOqk9OE54xGrhDpKHp2XItL9PgHmZdNb/l6zIocfqxmKNnQYfFtdCDGlOQ4Yyxc5cno1AcbSSC1woPhysHTi/pP94EWhpzs2fPwrJOUTdezZ6XbvIPLnmplecN9Eey6QN4jrsL62ZUV/efxDxfBzyuFFANCPGhbiuV31+HKQJIhAHYtqJzCEeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHUPC37EGWnPKHcuK5ROYeSIEHiJg2nJ8tViRLOtqtA=;
 b=bSaQCnj1q8y+BfP4XvxUBKIe/oAFI2/nvu3T1rslfJnCr+z9WUfYONdZ/0qoY7tYL4XU6cH3YJRVjf87NHTmMNu1GdDtQ6rUX+VqXO8ZWm+Opt9xvswBE6+z9unJS+CIEeinVd1J0qwtNFgu8pp5Yd/JF2fwKg4ON+IpdxaRGkk=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 1 Nov
 2024 18:32:38 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.8114.028; Fri, 1 Nov 2024
 18:32:38 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Sean Christopherson <seanjc@google.com>, Derek Manwaring
	<derekmn@amazon.com>
CC: "roypat@amazon.co.uk" <roypat@amazon.co.uk>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"graf@amazon.com" <graf@amazon.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "jgowans@amazon.com" <jgowans@amazon.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "kalyazin@amazon.com"
	<kalyazin@amazon.com>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "luto@kernel.org"
	<luto@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "tabba@google.com"
	<tabba@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vannapurve@google.com" <vannapurve@google.com>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "xmarcalx@amazon.com"
	<xmarcalx@amazon.com>
Subject: RE: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Thread-Topic: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Thread-Index: AQHbLHFMjLMyCV8maUKgtkq2gP29j7Kivv0g
Date: Fri, 1 Nov 2024 18:32:38 +0000
Message-ID:
 <LV3PR12MB9265A91412AFCF7B65AD0BA694562@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
 <ZyTxM7Po4v7VkmHO@google.com>
In-Reply-To: <ZyTxM7Po4v7VkmHO@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=412bc965-1282-46ef-82c3-d3676a9be80b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-01T18:29:07Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB7198:EE_
x-ms-office365-filtering-correlation-id: f2cf34b9-4b5b-457e-e941-08dcfaa38fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aJQR+O09fnjj47ZLovde2xDH2UR/xeM01lIDlkyvbTKtPuU/Llw76M7WHlzs?=
 =?us-ascii?Q?c0RrVagrdsOTA/s3jPBOu208ZjqpXl1ZUC4XyrHx1I4fM0590MX1eiJEVl9r?=
 =?us-ascii?Q?6yMcWZKI7Brpp7BrFg8El7b3BmtgbIt6unZRWpcf154vh6j4v9duyWLDM4jD?=
 =?us-ascii?Q?s9YgXQAqORiyyPAvcWHGfpqslomQEEb2dLZ5FpgIwCp1QvyncL5AkPS/ouSp?=
 =?us-ascii?Q?MjqYiaEWxI7jX+wSx+2rCflrF57NhW67fSU6fxFGXLSwu2/wERAz1gyyUk4F?=
 =?us-ascii?Q?CZDwl/YvUdQ4QbXfJWcHqJxWlepA0zkTHd69vJ5b2aQrgt2uKDmuRSpcgI/u?=
 =?us-ascii?Q?LUXftreGn5kLOpyuCOs3gyTy7UXHiocJAUM95QuaDllQqlQ11M6P+KLjNI3V?=
 =?us-ascii?Q?AZkrvgqpTGnm2BOmck9knGba4ixQnhLmjHZl0zzVsFzEu108I7ZT9dOIdTPt?=
 =?us-ascii?Q?ZvhSjdbTsMT6AjNHzh/2qWBGWim3JZnC5PYT11RvGD7yTTad1vnLAcyM9fZM?=
 =?us-ascii?Q?3Dy4QAE7gqxjdMvwUE8OvueWzaqxvpAuQB/Cu2UeSabcr9xL8oQjMrtnSn+e?=
 =?us-ascii?Q?2fttmm6zY6J7T6NbyJTA1lhgfYa/WkUAlztdlVuPoikKE2nKZwN3gFxVGoYS?=
 =?us-ascii?Q?90nsWZ/QigEb4nNQZgp1UQqYEO9+s6+4DC5/RTuwnx0uEeYk3vBUC6/VM3IA?=
 =?us-ascii?Q?v3P7jJIIIukL73SIyjU/aOvUV6CHk0aQkQFQCFO+3mroPiG9uSmeK5pEi6uA?=
 =?us-ascii?Q?yR/7YVOiWmaFt8mDR+WtDlnHZgns9l3j5VHUa/V8TTtN6ggry2UXDJn/v+Mb?=
 =?us-ascii?Q?w2EmV0opnUMJzfum4D0U1kGXY70U6NMootyseII2EmuLDLKxzyOneahoNwP+?=
 =?us-ascii?Q?3QwJ/KTpLetchZ7ZNeAj0KjxyYM0ZhT7oNOYfiS1Ykj0hQyOCcGAzB1xBBM7?=
 =?us-ascii?Q?Bw2crZAlU11XjPRyswrPfWnL8RcEQBb45SC+o5OEYWAjl618jcpb0sIWAwrk?=
 =?us-ascii?Q?7zj1X7zbDOhzgRVk0IOhqUnKvQvh+iUYIiS2vdpK4aqxOnwiqOU5ZZQtYbdl?=
 =?us-ascii?Q?NuEY8yHUSvVRAWtLmvsKEqLmIQwl2Jo90UnCfBICHiuEQkYomiwom3aOi6sS?=
 =?us-ascii?Q?OD6yi9qTB/1ny++Yhj/zUYcxkgRT45jNsR6MlkWtqelP5LZyQKXioxqOtWCj?=
 =?us-ascii?Q?3aSks3hoQ2/+03qVCqO0tJQGHMGksIUKip2TLU7cfsupa7AF9OP/qbOQ1RaS?=
 =?us-ascii?Q?g0qpTD3nZQhzRR9HoKC52+QeBIY/CN15FbU9WoaDfUIYl3Q65jGBHB57vu8u?=
 =?us-ascii?Q?7Er74b7jIjDhppCb9aruzB6LxdXVC2t3A9NFTzMsd1uKZVglylBWKSAl64C0?=
 =?us-ascii?Q?ooXSL5w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KDdQKwnWYRiGTcOlRzhBWSpMmrIgmyOgQfKIhqsdYWQFDVzt7pQyPZsZAfks?=
 =?us-ascii?Q?Klk0WA83V0qLuhimnK5DMUEDm7EPaQEpaSQgYOkJ44QO6wShBJblTHBOpH6E?=
 =?us-ascii?Q?3NDpRQ9O5kvTRHcsS4jeg42rm+K8BL7aPttHBmZw9nqnRoSX3swcjFhszQ7g?=
 =?us-ascii?Q?VXETqoL/ITVa6Hiau9MUBOnpF7MVA0rN0msOc0ab7q4xWnsFgHDHvQM0tbj1?=
 =?us-ascii?Q?w0SsL+XrhZB/mX9wUDlDMiT2mtCBDkPARuY2duMXZU6GuUReuOhy7pdisS9q?=
 =?us-ascii?Q?mv5f4Ki/zwIpxijvysPFBgrORdGCWWcp3ztvwXDrgavPWCEWc+12THM2N+Qm?=
 =?us-ascii?Q?2fXD3G6Jihz7+vsQSPpCzABRTfLBakodNC1gWBXRlvuKojCQQ9IRZvhRdcwb?=
 =?us-ascii?Q?5A8+WYwSG9JVfcHZ5blBmfZhZ/Holkqcyb0tp3NOegbw0qnY3KMtq++KyP9k?=
 =?us-ascii?Q?+2D7QsybM5akfgQ2vNSVOy6FhfbXTin0GG66qSjLMeXi9t/5Fp67rEv8qN2a?=
 =?us-ascii?Q?ZVNbtGSSSzyygNY6cYxE2STKRSbs6bDV5VpWUh8WGsuIxuKa6j05UXbhTjkO?=
 =?us-ascii?Q?W1GlO//01LRiXiC3CIbJU2KJaZdLVTgF6tvhHTqTRgj6nt2PvadUDa530Uh2?=
 =?us-ascii?Q?P4zhZjTa48m5d9XPvvs0JUnEWhvRomFVogOfFHTyRhUysKJhxVkLcszNlgKl?=
 =?us-ascii?Q?KmuwJKJ5AtyrpirZY4A7M0R4DTc5zsDyWSCwLZHiWkv1mYJrKMKoPVCk1Ey7?=
 =?us-ascii?Q?lbDSoekqRo17gl/wPUXX/fe1CHIa95LKRlAYSKDKblCbFTYzbf0Sumu/4Pls?=
 =?us-ascii?Q?h+dqvEdaK9Klgay4nSvsLQc0IvBspD0XKQNBfFG5WqESpeZDVj4QMweP2bDq?=
 =?us-ascii?Q?iacWSsJw26XVrCdKdcBgzlLoE5ZruDG8UUzdvm+I5XjrDTxjQDHDLS4S1y5F?=
 =?us-ascii?Q?1yMwJcimB2uLZZRcKpr12LVnh6HARaU9Yq12QPnUbypdFe0mhboTpg0ELJBt?=
 =?us-ascii?Q?z/ocLth3MPcwDmV33Y/xNthSYqLxwEb4bPDNrMJ37UnxFQviBf1h2CnY87zT?=
 =?us-ascii?Q?6g3Fs8SXtlBk64dTOpZfSi0/Z06QL5DBwLRJQ1BrhGn7wQN6muqXrklsH7Um?=
 =?us-ascii?Q?Lowcnj2gANTeKDDi1wdSmgUBtL1PCbdq5gk5xe2jCbUgAGJNzRqEHUdgpnPE?=
 =?us-ascii?Q?afByuD+iqJb39cCIeFB36x0Sjz1urVkqKRklMafxEMy9FfDxW/hoxiVWb7yj?=
 =?us-ascii?Q?WHtH0pEwQ/akDwXL0jUdBe50fhTjP6Q/JELShvQdfXwini7Wo26cu/X26Jer?=
 =?us-ascii?Q?o7UUZvxIrU05zl0XjIc/ktUncKsz1tqlrP+V/dIvx27EM4UmUxwxWUP+FX7b?=
 =?us-ascii?Q?A0gyFlq37YQsZheO0mzmi0H1n+DNIN10XKlcx6VWEmnwlpuaGv9Dt8Mjm41w?=
 =?us-ascii?Q?KII2z0ro8Kg9AUGuMGThSDc4YjL+y/iwn2XpCPNGN1YyFhPZ7rngL/SEBmCB?=
 =?us-ascii?Q?u3HOxXKvX6M+q8oV4JL1blE1a/mHPSQGpG2iLuoyoB4tMYIuWcxyPOzUz6N6?=
 =?us-ascii?Q?Vyno17j+ZVCwMpgrvcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cf34b9-4b5b-457e-e941-08dcfaa38fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 18:32:38.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DRxfjXFmkfnfRxP91h4yuircTS0cTRkFMnXV9WNrHHh0+7Y7CorGFbo73beV2gL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Sean Christopherson <seanjc@google.com>
> Sent: Friday, November 1, 2024 10:18 AM
> To: Derek Manwaring <derekmn@amazon.com>
> Cc: roypat@amazon.co.uk; ackerleytng@google.com;
> agordeev@linux.ibm.com; aou@eecs.berkeley.edu;
> borntraeger@linux.ibm.com; bp@alien8.de; catalin.marinas@arm.com;
> chenhuacai@kernel.org; corbet@lwn.net; dave.hansen@linux.intel.com;
> david@redhat.com; gerald.schaefer@linux.ibm.com; gor@linux.ibm.com;
> graf@amazon.com; hca@linux.ibm.com; hpa@zytor.com;
> jgowans@amazon.com; jthoughton@google.com; kalyazin@amazon.com;
> kernel@xen0n.name; kvm@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-kselftest@vger.kernel.org; linux-
> mm@kvack.org; linux-riscv@lists.infradead.org; linux-s390@vger.kernel.org=
;
> linux-trace-kernel@vger.kernel.org; loongarch@lists.linux.dev;
> luto@kernel.org; mathieu.desnoyers@efficios.com; mhiramat@kernel.org;
> mingo@redhat.com; palmer@dabbelt.com; paul.walmsley@sifive.com;
> pbonzini@redhat.com; peterz@infradead.org; quic_eberman@quicinc.com;
> rostedt@goodmis.org; rppt@kernel.org; shuah@kernel.org;
> svens@linux.ibm.com; tabba@google.com; tglx@linutronix.de;
> vannapurve@google.com; will@kernel.org; x86@kernel.org;
> xmarcalx@amazon.com; Kaplan, David <David.Kaplan@amd.com>
> Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> +David Kaplan
>
> On Thu, Oct 31, 2024, Derek Manwaring wrote:
> > On 2024-10-31 at 10:42+0000 Patrick Roy wrote:
> > > On Thu, 2024-10-31 at 09:50 +0000, David Hildenbrand wrote:
> > > > On 30.10.24 14:49, Patrick Roy wrote:
> > > >> Most significantly, I've reduced the patch series to focus only
> > > >> on direct map removal for guest_memfd for now, leaving the whole
> > > >> "how to do non-CoCo VMs in guest_memfd" for later. If this
> > > >> separation is acceptable, then I think I can drop the RFC tag in
> > > >> the next revision (I've mainly kept it here because I'm not
> > > >> entirely sure what to do with patches 3 and 4).
> > > >
> > > > Hi,
> > > >
> > > > keeping upcoming "shared and private memory in guest_memfd" in
> > > > mind, I assume the focus would be to only remove the direct map for
> private memory?
> > > >
> > > > So in the current upstream state, you would only be removing the
> > > > direct map for private memory, currently translating to
> "encrypted"/"protected"
> > > > memory that is inaccessible either way already.
> > > >
> > > > Correct?
> > >
> > > Yea, with the upcomming "shared and private" stuff, I would expect
> > > the the shared<->private conversions would call the routines from
> > > patch 3 to restore direct map entries on private->shared, and zap
> > > them on
> > > shared->private.
> > >
> > > But as you said, the current upstream state has no notion of "shared"
> > > memory in guest_memfd, so everything is private and thus everything
> > > is direct map removed (although it is indeed already inaccessible
> > > anyway for TDX and friends. That's what makes this patch series a
> > > bit awkward :( )
> >
> > TDX and SEV encryption happens between the core and main memory, so
> > cached guest data we're most concerned about for transient execution
> > attacks isn't necessarily inaccessible.
> >
> > I'd be interested what Intel, AMD, and other folks think on this, but
> > I think direct map removal is worthwhile for CoCo cases as well.
>
> Removal of the direct map entries for guest private PFNs likely won't aff=
ect
> the ability of an attacker to glean information from the unencrypted data
> that's in the CPU caches, at least not on x86.  Both TDX and SEV steal ph=
ysical
> address
> bit(s) for tagging encrypted memory, and unless things have changed on
> recent AMD microarchitectures (I'm 99.9% certain Intel CPUs haven't
> changed), those stolen address bits are propagated into the caches.  I.e.=
 the
> encrypted and unencrypted forms of a given PFN are actually two different
> physical addresses under the hood.
>
> I don't actually know how SEV uses the stolen PA bits though.  I don't se=
e
> how it simply be the ASID, because IIUC, AMD CPUs allow for more unique
> SEV-capable ASIDs than uniquely addressable PAs by the number of stolen
> bits.  But I would be very surprised if the tag for the cache isn't guara=
nteed to
> be unique per encryption key.
>
> David?

How the stolen PA bits are used is a microarchitectural implementation deta=
il.  It is true that the tag will be unique per encryption key.  Beyond tha=
t, I'm not sure what other details are relevant to SW.

--David Kaplan

