Return-Path: <linux-kselftest+bounces-26578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D014A34D6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F411F1885B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6E24501D;
	Thu, 13 Feb 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MKmj1Qin";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c131nM5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C66205502;
	Thu, 13 Feb 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470753; cv=fail; b=UnVbxA/7JO505Km32voD+L83W+GbND+bLKXQa1HdNO+IeS8eOvstsJvT9uL49pMm9GFxWyR3Y4yiTdy4SaFyvVuU3OwiAKBae47/tyaABvEQl7XF7fKnNSAnIIONzDy4rzclswvTmBnh8doi4QuqlgYXrblXP324Pk8izd5Krf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470753; c=relaxed/simple;
	bh=DHQZRKxcCzjZlj0297c/p5rZF81xnLYAtJ2U28nGh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkWM2yFom7rjcuKnNhDA2XMQKhzPjbHYFNeazuyPoSsoXlsyOXI/0K+DtHX7hM2MSAAcTc58yqFNh+BfUvQeVIc58s8pFiDzu3Dt+pYh4v7BkZ2ykKc6xef55kk4JRvxMO/6K/NH1pK0Lp5IV0NWERQmB6I3OmV/oE6nVy8kiz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MKmj1Qin; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c131nM5L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfY1h027481;
	Thu, 13 Feb 2025 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ga6vAO3xLWeENYcr5F0yrXvgrNaobjLFfYfpEeC9QgQ=; b=
	MKmj1QinPWP86nFnJAO0qj78XzpyDkP+49y3ku7KqF3GkRb1sx5kDawNw4e2ShOf
	z4bjLZd07eCn0eNTuAsSlkztt1XHmyJjdPtN6y8E6N1Pm+z6IyfanGZMye6Ull1q
	eEMk67vVwdSZQaRG7i6WaLirk9f14gOJeIM+OfmroFw4g5fSRuAqpGOioei7+116
	o4bxZEByZRtOCM4DN0pvgO3TQyIb2LbkTnkVEkp2gMts+EC8LwM/GFuCWb2U9N4i
	v/FTteFkGr02N64yEiLwlTcKYvo4yyPzn33eLF5INc3xLn7hwbL547nqwPQXzDsi
	6Ff76cUxT4peP4dsvBwMWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaj5c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHG2W5005110;
	Thu, 13 Feb 2025 18:18:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc2ahq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsvVvuQgcCj2UuaQYKAsR0yOORey4TGWJ880L26EJv/4Av0CMojEvMAyyb/VTj/g4Mk6Lb6TwEg54W4DAHDcD2FQnvtmy9EI1eN0myS7qIaaHPtR3+4K4RL5WK368FgzyWCKSNh0Q7pMeiPcyY3kgnOmWPj4MLR8Q+4FzkTjJC5Z7Q1igeo2FysL/lv91HTwfAfSwEl5Vs5Z8+bDIj5AWmOywEoXas+Y/zqXiaFopWNTTs7VyDinapEozRFkc/gEo0BnPmAw1fcFnUT4xGEoyy4bFQVFa17265U/YoKYmd2a2ONq6RNJYTea6xVadU5vbly61njXL7A91ASCFQwnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga6vAO3xLWeENYcr5F0yrXvgrNaobjLFfYfpEeC9QgQ=;
 b=VxWlGeUv9/FDCmZwW/P5QKQd9AlhHm50F2plGczq6t6UYQPYFr9rJrPIiOZi5Lz2KdlNLKTENhvs8AhFimwGhRLz2uHuR0sOUW24jez1CdXB3V1O8oQvJajfwtH+ed8EbrxwNaLuL+xSXzxnToMcIwSuzcTeXbU8rIKkGhBIV7mz40PYso8CZTNor2LOVEwvKkVhVEwpLx2OcRBl19ZHwFqnooitd0za2R7vV1EK158mNUOtLebaAcbbGle2znyHS/b1sx7cdBpS6nOvaTcsILHVuuzZLq4h6GmVSpi+2sNqu22PMDHNqKHg6z/ASzklifSJR2agcxJS0E4ZB38z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga6vAO3xLWeENYcr5F0yrXvgrNaobjLFfYfpEeC9QgQ=;
 b=c131nM5LvvFd7mZNN/pioQXQGzDOSCZM7RI2avwHXtxpGeLL72gMDQ6k6LS2A8xwFfhR0QQnznmUXbKgMfASnjleP8N7CKq6cPEEyzh8hOH9u9TmBDzNrvmaYS0JupCVb4PvcocbRhRifCKSE263vom45k4vulYY3fpo6iEV/Mc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:18:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 18:18:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 3/4] tools/selftests: expand all guard region tests to file-backed
Date: Thu, 13 Feb 2025 18:17:02 +0000
Message-ID: <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8927168e-208f-4eb0-5d3a-08dd4c5ad767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ETUFvYL1uUYYdH2Jfd6S3zl49VAozOE6bqYwaN2rAn2DglfZ5thCAhJw4LaD?=
 =?us-ascii?Q?7EEAbwdmnvJ8M3zTUtBu5vG1BtYEpZSmXX4xxsExudqyYzO2aqt4okoSRcXO?=
 =?us-ascii?Q?Zkn5t3pL/RltuQYVOMbLMT2xbcxNJNkQqQmQuyjvpBJIb0HGv727/VM9aHQm?=
 =?us-ascii?Q?WHAoIOKnhUTlSsSYSnC/yxl1x0xOMh5ZzjmqnJVCSCt1Em/BDI4qV9q0vdBS?=
 =?us-ascii?Q?0NF/A6KVa/X6nIHPuBWBGWTcCuNgKpDHM7MkRz5Qi4xx/e6Tgo2Qd3lXBcIR?=
 =?us-ascii?Q?qAmtuMvBJT2GmU5j1i2QuIAVQTaNj6KdtM5UM9qg7Lk3lowg3mNphWV17VE+?=
 =?us-ascii?Q?KB3KGSkM1C3MYJ8Qrr+pzJuphekWKV1RUAqLtUX5dUYWvDGdM2mkPQsfjkVI?=
 =?us-ascii?Q?NMEVvuaCDsJLGGcJkO0oyBXqizFYLINfldD8SbY+gXgufRpZlmCI/L72Ps+l?=
 =?us-ascii?Q?fUiCw1a0Ak56Gxdu7ZQ6xqV82J2J0wcQBddNgMZm+iMBfG/tZERszUUvQNlq?=
 =?us-ascii?Q?6g3DgLLmmfWqDjlreBSirT3sMVpeaaVrx//UYf5RwSMmNCNhyaXuylLwJpfL?=
 =?us-ascii?Q?N97IoF24Z3quSkDZP6d40SulCQDjXJydYjII+ZCS9NSI3BkLMgMVFEz9hwk4?=
 =?us-ascii?Q?oObhcd6KWnKRg587OxI0ZXhbQHywKf3l8w2D9TREOr0ejVDnUTqDOQIRkqZk?=
 =?us-ascii?Q?t0CmDGVwNNWq0t6iS84XeCb0/IMf7HqjA9Q/4auPJB4s/HRVFuwaQWNreAOR?=
 =?us-ascii?Q?A4uZZ/Bu3N9cyvBUjmKLY3mfff7AMBqdaeDjF9BOV23pBkc7N6+5oY3dlJr0?=
 =?us-ascii?Q?M90Rj3buyUTn7puNgHPCDLFSirjoYhIfxhvT816XuWfRuDNJ9kXm+HpgEWsz?=
 =?us-ascii?Q?6DPceeLnJYX1Wx4ZZOW+TMtfIL5MK5+29mGOcw1bw4wvc5Bbtc/rQrmZVtgh?=
 =?us-ascii?Q?moFp1euFuEoKOfKkYWFiYGiJG5firqU/HgyOjPchRwgLxMAOOj6Em6ureZU3?=
 =?us-ascii?Q?no/IuZ4zEz74xE8XY+bXeXaoMkLTBzZlipwPGkR22p1tdy0hrm5LFpzwN8Yc?=
 =?us-ascii?Q?TUVfRsjbiLTYkVgh8fI6k8L3RUBiSb0Jf81OhZJisauhL1/Dove5joS7r9kG?=
 =?us-ascii?Q?EerCRLI5r/JWXvrSNeGZ1ajpPkxcV7stQTIAmJArFboWQvo+rv0BHYvz5OX4?=
 =?us-ascii?Q?hksu/YWRVSX55mX25bQ0bPx91YAqzJnvYMXDw4cjduvP2UbhswqSi2qqjIAg?=
 =?us-ascii?Q?6co9D2LTxD6c+dsNIm8mneGB25k7Hah3+M5w8nkEFeP684t7V6M3nPmpbM/F?=
 =?us-ascii?Q?LaVPM3zbeooJTGsFpbi01MBKJJOveIFQ+7HxctNHkmHjd86lB/eXSKKXhcuc?=
 =?us-ascii?Q?PABbEVdxvhdANa2KCEe1VbBxbfqj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uId88eQJY8ZHOhHw5VfNKDvTlCL/fZgCQ979wmCb/57ZyI4EZEKhNibQW6Fj?=
 =?us-ascii?Q?Klkm3tnHfiVGn5aPmK4rb3D/3XTuIJnn9spm91xMWNMKR+yPTh2HlrSNjbkG?=
 =?us-ascii?Q?hz771FXFFyf3T7e+U5t73G+m9QeGk1QdsJbTh7MHDsFJh6lLG3qvAb+AFEl4?=
 =?us-ascii?Q?5lFt5rorln4EMqX5F/VLzyNfQCaEeD85YKqjmrlaDFJEY28mxsk4vV9jJl7x?=
 =?us-ascii?Q?oOqep9tlUdHvfJwjrSb7GL/I0ss0iwB8XOXeB2339ejkkqGSUUU7m4VZTqpV?=
 =?us-ascii?Q?+eNFXm9jf7pf3pLG66JcMMME+Q1JMh9erkMdkmlPp3Sz9KZ7xyj9dPlNNFSQ?=
 =?us-ascii?Q?mjLfRCR3CjutOKJWKRm/5KeoU2/k8tdOsimED1mNA/SPtkvR5ELBvUbA54uf?=
 =?us-ascii?Q?gP3mghvERjpQBsWEY7h0OXr2tppP8mpY3XFa1fpYxUcT+892ZFrBwX9gDu+P?=
 =?us-ascii?Q?aTpsegvNKwxExbyMQas7vGLp4zgS5eLx4wz9NHZ6rkrjMvdJ6Hc7N2Notivo?=
 =?us-ascii?Q?WaiPcq11zCBQgfadv6jjRUcEgaGCQnC9pOcUarwpbrZcLSIgAlroYAAqz2/C?=
 =?us-ascii?Q?g5rFvPKq2OEGP4xC8as8EgTQu2INlnae6by9BYF10E3+QuntuEzjRcqFpzCQ?=
 =?us-ascii?Q?K0Mb8fuvisL9vWK1+TEEquTPj40W6dmQZzcue1yGtGBQLelfOmQBDeXoEqGn?=
 =?us-ascii?Q?abzfVoezb+SKFEo8Fp1uoFQAj27w6Ytjt067hB6o9hkQqCCEiDVdnnlX6MDT?=
 =?us-ascii?Q?9qQ5aDsSYI+A+7vmtElvX/KGIhxXPvlJyUPwRAWcwPn5ef/Dvz5tc2pZvaoD?=
 =?us-ascii?Q?FlsUC4tdY9dZiZ07rkELdL2Nsfy74fTijLJAdaU74PCRHh7h8Qc9fwVg32ze?=
 =?us-ascii?Q?l+xqGqy5XV8499EOPB0qlYjnzkw0dgr3wM1/qlSVwPMtdO3zpzWgpT97GLzM?=
 =?us-ascii?Q?YA4U4jEcRZicDZlnpcoMROcfhITGOfC7PsPmNywc8c4KYyboM/vEa86jdpmW?=
 =?us-ascii?Q?1NEQ1WNhz6OvscaFSoeRVHmm9ZnFxPljPYi3peM/VhZjRNB1DsChbKjg5RmQ?=
 =?us-ascii?Q?XlViLic3BbypWpakjI7BNqCYymLywioFjM4isBRi5BDeUekPf4iAwVc3kQkO?=
 =?us-ascii?Q?0aTGYDxWeinwS2/YB/Rbh6OIWOKQeVzQmT8DezUuzob8KoyyIPeIbmzHg7jC?=
 =?us-ascii?Q?V2CnhT9+qi30XeCOMg0AGdEoYTvaPQNYe/AA9XfXfzTwcxWxC5NLya0mEvrw?=
 =?us-ascii?Q?S97rvSFQTIJB+VTrEmuGsLHj+YYDfhHnU3oVYwp/Lmty8kjiiBSvHVZUmDOF?=
 =?us-ascii?Q?uSkv1lwTd1Ebtychbma6FgJnpYtAcjKS2dol3e76Y62U3WRIrIIGXGLGTf2J?=
 =?us-ascii?Q?ffdjs9j3XsFW8b6SeAhwyydEUgbm+X5rVER4eH1lf9md0DpZx2Qp/5ZDW93o?=
 =?us-ascii?Q?fzAWs2JstfK35HmsKVKOH5VU1v6Ilcpu5cn9wW+jaRztLxff5K2K30QZ+3bE?=
 =?us-ascii?Q?ZEUREisr8+DIiW6vJd/Vipt8nZUfIIciXwjOlPvuXS2esLH1ISkJM/08sZ8v?=
 =?us-ascii?Q?HOvPRWvnj3eu/OUaOLyeo/Xt2JTfm35YmfVZhaTEBpNRbzk+uDjgP1RU43fp?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U6VDyxUeIIP8eMpOhdZMmOAuBX1w+0RoM6aT8lK6VBUb9pmlptnpXHX5sBGH8urhgg/ePBqL6A0EM11iLH1bDJ8ToEctaqNnq5m09GJwp2aVFHT7AKY+goKMKgzbCGkh90FdR4q9pPd5ReMu2lu5gJHD24hJInP1Uok45a2WLXHMHf5AVAC+3myxHzWcaPGmLMFcP7Zl5doMhvABECH/xduMKVDBzBWlQmvr53/296ETdWiMyAS5YK8G9+zC9OtglJohTzJl6MnijGpjak61vX7LqUHiM7Sog3uYGEcOQCgE+uD/OtYFZ7G7Py9lBL34vEiF75u9754+VbsnczLFKgc1NgDqUjZG1CHANLa/BvFEtHwzmry9MkJsDeMFt94RHzrxOsifk0ZZ7qK0mWB/PfvsnIJsOyVL6vMd1ujA+X8SMjQC7mNpdhUeIN8h3dlOn9A677kqTDCuo5unRcs2ZOXdp+/WNcNh5PYzopPpDWLorVTm6WAJTMLAYTAxF+MzW+TXUUeKyD+vTaNmyCda7bGahQTeXXLkHjRJD9K02KbufRERtgvUZcx3/a3DuzZ1nW3efFQlkvoBK47eI0V25677B8raP56ImvL1ejm+gkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8927168e-208f-4eb0-5d3a-08dd4c5ad767
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:18:40.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVSdaZDSFmh0/87cC9rijJ98mKADAfqCqb0kjUS7fsbI4rtpDLjuXLocMAY/W30Y8GFZQVhDu2Oau1sqDvEyM+8EmzZjt3WdVTe4Vl1HQ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130130
X-Proofpoint-GUID: Hr3JxZ_bEJ-navJDw1pMlNuZDxjh9GGS
X-Proofpoint-ORIG-GUID: Hr3JxZ_bEJ-navJDw1pMlNuZDxjh9GGS

Extend the guard region tests to allow for test fixture variants for anon,
shmem, and local file files.

This allows us to assert that each of the expected behaviours of anonymous
memory also applies correctly to file-backed (both shmem and an a file
created locally in the current working directory) and thus asserts the same
correctness guarantees as all the remaining tests do.

The fixture teardown is now performed in the parent process rather than
child forked ones, meaning cleanup is always performed, including unlinking
any generated temporary files.

Additionally the variant fixture data type now contains an enum value
indicating the type of backing store and the mmap() invocation is
abstracted to allow for the mapping of whichever backing store the variant
is testing.

We adjust tests as necessary to account for the fact they may now reference
files rather than anonymous memory.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 290 +++++++++++++++------
 1 file changed, 205 insertions(+), 85 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 7a41cf9ffbdf..0469c783f4fa 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -6,6 +6,7 @@
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/limits.h>
 #include <linux/userfaultfd.h>
 #include <setjmp.h>
 #include <signal.h>
@@ -37,6 +38,79 @@ static sigjmp_buf signal_jmp_buf;
  */
 #define FORCE_READ(x) (*(volatile typeof(x) *)x)
 
+/*
+ * How is the test backing the mapping being tested?
+ */
+enum backing_type {
+	ANON_BACKED,
+	SHMEM_BACKED,
+	LOCAL_FILE_BACKED,
+};
+
+FIXTURE(guard_regions)
+{
+	unsigned long page_size;
+	char path[PATH_MAX];
+	int fd;
+};
+
+FIXTURE_VARIANT(guard_regions)
+{
+	enum backing_type backing;
+};
+
+FIXTURE_VARIANT_ADD(guard_regions, anon)
+{
+	.backing = ANON_BACKED,
+};
+
+FIXTURE_VARIANT_ADD(guard_regions, shmem)
+{
+	.backing = SHMEM_BACKED,
+};
+
+FIXTURE_VARIANT_ADD(guard_regions, file)
+{
+	.backing = LOCAL_FILE_BACKED,
+};
+
+static bool is_anon_backed(const FIXTURE_VARIANT(guard_regions) * variant)
+{
+	switch (variant->backing) {
+	case  ANON_BACKED:
+	case  SHMEM_BACKED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void *mmap_(FIXTURE_DATA(guard_regions) * self,
+		   const FIXTURE_VARIANT(guard_regions) * variant,
+		   void *addr, size_t length, int prot, int extra_flags,
+		   off_t offset)
+{
+	int fd;
+	int flags = extra_flags;
+
+	switch (variant->backing) {
+	case ANON_BACKED:
+		flags |= MAP_PRIVATE | MAP_ANON;
+		fd = -1;
+		break;
+	case SHMEM_BACKED:
+	case LOCAL_FILE_BACKED:
+		flags |= MAP_SHARED;
+		fd = self->fd;
+		break;
+	default:
+		ksft_exit_fail();
+		break;
+	}
+
+	return mmap(addr, length, prot, flags, fd, offset);
+}
+
 static int userfaultfd(int flags)
 {
 	return syscall(SYS_userfaultfd, flags);
@@ -107,12 +181,7 @@ static bool try_read_write_buf(char *ptr)
 	return try_read_buf(ptr) && try_write_buf(ptr);
 }
 
-FIXTURE(guard_regions)
-{
-	unsigned long page_size;
-};
-
-FIXTURE_SETUP(guard_regions)
+static void setup_sighandler(void)
 {
 	struct sigaction act = {
 		.sa_handler = &handle_fatal,
@@ -122,11 +191,9 @@ FIXTURE_SETUP(guard_regions)
 	sigemptyset(&act.sa_mask);
 	if (sigaction(SIGSEGV, &act, NULL))
 		ksft_exit_fail_perror("sigaction");
+}
 
-	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
-};
-
-FIXTURE_TEARDOWN(guard_regions)
+static void teardown_sighandler(void)
 {
 	struct sigaction act = {
 		.sa_handler = SIG_DFL,
@@ -137,6 +204,48 @@ FIXTURE_TEARDOWN(guard_regions)
 	sigaction(SIGSEGV, &act, NULL);
 }
 
+static int open_file(const char *prefix, char *path)
+{
+	int fd;
+
+	snprintf(path, PATH_MAX, "%sguard_regions_test_file_XXXXXX", prefix);
+	fd = mkstemp(path);
+	if (fd < 0)
+		ksft_exit_fail_perror("mkstemp");
+
+	return fd;
+}
+
+FIXTURE_SETUP(guard_regions)
+{
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+	setup_sighandler();
+
+	if (variant->backing == ANON_BACKED)
+		return;
+
+	self->fd = open_file(
+		variant->backing == SHMEM_BACKED ? "/tmp/" : "",
+		self->path);
+
+	/* We truncate file to at least 100 pages, tests can modify as needed. */
+	ASSERT_EQ(ftruncate(self->fd, 100 * self->page_size), 0);
+};
+
+FIXTURE_TEARDOWN_PARENT(guard_regions)
+{
+	teardown_sighandler();
+
+	if (variant->backing == ANON_BACKED)
+		return;
+
+	if (self->fd >= 0)
+		close(self->fd);
+
+	if (self->path[0] != '\0')
+		unlink(self->path);
+}
+
 TEST_F(guard_regions, basic)
 {
 	const unsigned long NUM_PAGES = 10;
@@ -144,8 +253,8 @@ TEST_F(guard_regions, basic)
 	char *ptr;
 	int i;
 
-	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
-		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	ptr = mmap_(self, variant, NULL, NUM_PAGES * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Trivially assert we can touch the first page. */
@@ -238,25 +347,23 @@ TEST_F(guard_regions, multi_vma)
 	int i;
 
 	/* Reserve a 100 page region over which we can install VMAs. */
-	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
-			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_region = mmap_(self, variant, NULL, 100 * page_size,
+			   PROT_NONE, 0, 0);
 	ASSERT_NE(ptr_region, MAP_FAILED);
 
 	/* Place a VMA of 10 pages size at the start of the region. */
-	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr1 = mmap_(self, variant, ptr_region, 10 * page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr1, MAP_FAILED);
 
 	/* Place a VMA of 5 pages size 50 pages into the region. */
-	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
-		    PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr2 = mmap_(self, variant, &ptr_region[50 * page_size], 5 * page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr2, MAP_FAILED);
 
 	/* Place a VMA of 20 pages size at the end of the region. */
-	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
-		    PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr3 = mmap_(self, variant, &ptr_region[80 * page_size], 20 * page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr3, MAP_FAILED);
 
 	/* Unmap gaps. */
@@ -326,13 +433,11 @@ TEST_F(guard_regions, multi_vma)
 	}
 
 	/* Now map incompatible VMAs in the gaps. */
-	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
-		   PROT_READ | PROT_WRITE | PROT_EXEC,
-		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, &ptr_region[10 * page_size], 40 * page_size,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_FIXED, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
-	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
-		   PROT_READ | PROT_WRITE | PROT_EXEC,
-		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, &ptr_region[55 * page_size], 25 * page_size,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_FIXED, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/*
@@ -379,8 +484,8 @@ TEST_F(guard_regions, process_madvise)
 	ASSERT_NE(pidfd, -1);
 
 	/* Reserve region to map over. */
-	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
-			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_region = mmap_(self, variant, NULL, 100 * page_size,
+			   PROT_NONE, 0, 0);
 	ASSERT_NE(ptr_region, MAP_FAILED);
 
 	/*
@@ -388,9 +493,8 @@ TEST_F(guard_regions, process_madvise)
 	 * overwrite existing entries and test this code path against
 	 * overwriting existing entries.
 	 */
-	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
-		    PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE | MAP_POPULATE, -1, 0);
+	ptr1 = mmap_(self, variant, &ptr_region[page_size], 10 * page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED | MAP_POPULATE, 0);
 	ASSERT_NE(ptr1, MAP_FAILED);
 	/* We want guard markers at start/end of each VMA. */
 	vec[0].iov_base = ptr1;
@@ -399,9 +503,8 @@ TEST_F(guard_regions, process_madvise)
 	vec[1].iov_len = page_size;
 
 	/* 5 pages offset 50 pages into reserve region. */
-	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
-		    PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr2 = mmap_(self, variant, &ptr_region[50 * page_size], 5 * page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr2, MAP_FAILED);
 	vec[2].iov_base = ptr2;
 	vec[2].iov_len = page_size;
@@ -409,9 +512,8 @@ TEST_F(guard_regions, process_madvise)
 	vec[3].iov_len = page_size;
 
 	/* 20 pages offset 79 pages into reserve region. */
-	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
-		    PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr3 = mmap_(self, variant, &ptr_region[79 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr3, MAP_FAILED);
 	vec[4].iov_base = ptr3;
 	vec[4].iov_len = page_size;
@@ -472,8 +574,8 @@ TEST_F(guard_regions, munmap)
 	const unsigned long page_size = self->page_size;
 	char *ptr, *ptr_new1, *ptr_new2;
 
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard first and last pages. */
@@ -489,11 +591,11 @@ TEST_F(guard_regions, munmap)
 	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
 
 	/* Map over them.*/
-	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
-			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new1 = mmap_(self, variant, ptr, page_size, PROT_READ | PROT_WRITE,
+			 MAP_FIXED, 0);
 	ASSERT_NE(ptr_new1, MAP_FAILED);
-	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
-			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new2 = mmap_(self, variant, &ptr[9 * page_size], page_size,
+			 PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr_new2, MAP_FAILED);
 
 	/* Assert that they are now not guarded. */
@@ -511,8 +613,8 @@ TEST_F(guard_regions, mprotect)
 	char *ptr;
 	int i;
 
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard the middle of the range. */
@@ -559,8 +661,8 @@ TEST_F(guard_regions, split_merge)
 	char *ptr, *ptr_new;
 	int i;
 
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard the whole range. */
@@ -601,14 +703,14 @@ TEST_F(guard_regions, split_merge)
 	}
 
 	/* Now map them again - the unmap will have cleared the guards. */
-	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
-		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new = mmap_(self, variant, &ptr[2 * page_size], page_size,
+			PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr_new, MAP_FAILED);
-	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
-		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new = mmap_(self, variant, &ptr[5 * page_size], page_size,
+			PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr_new, MAP_FAILED);
-	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
-		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new = mmap_(self, variant, &ptr[8 * page_size], page_size,
+			PROT_READ | PROT_WRITE, MAP_FIXED, 0);
 	ASSERT_NE(ptr_new, MAP_FAILED);
 
 	/* Now make sure guard pages are established. */
@@ -690,8 +792,8 @@ TEST_F(guard_regions, dontneed)
 	char *ptr;
 	int i;
 
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Back the whole range. */
@@ -721,8 +823,16 @@ TEST_F(guard_regions, dontneed)
 			ASSERT_FALSE(result);
 		} else {
 			ASSERT_TRUE(result);
-			/* Make sure we really did get reset to zero page. */
-			ASSERT_EQ(*curr, '\0');
+			switch (variant->backing) {
+			case ANON_BACKED:
+				/* If anon, then we get a zero page. */
+				ASSERT_EQ(*curr, '\0');
+				break;
+			default:
+				/* Otherwise, we get the file data. */
+				ASSERT_EQ(*curr, 'y');
+				break;
+			}
 		}
 
 		/* Now write... */
@@ -743,8 +853,8 @@ TEST_F(guard_regions, mlock)
 	char *ptr;
 	int i;
 
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Populate. */
@@ -816,8 +926,8 @@ TEST_F(guard_regions, mremap_move)
 	char *ptr, *ptr_new;
 
 	/* Map 5 pages. */
-	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 5 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Place guard markers at both ends of the 5 page span. */
@@ -831,8 +941,7 @@ TEST_F(guard_regions, mremap_move)
 	/* Map a new region we will move this range into. Doing this ensures
 	 * that we have reserved a range to map into.
 	 */
-	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
-		       -1, 0);
+	ptr_new = mmap_(self, variant, NULL, 5 * page_size, PROT_NONE, 0, 0);
 	ASSERT_NE(ptr_new, MAP_FAILED);
 
 	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
@@ -863,8 +972,8 @@ TEST_F(guard_regions, mremap_expand)
 	char *ptr, *ptr_new;
 
 	/* Map 10 pages... */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 	/* ...But unmap the last 5 so we can ensure we can expand into them. */
 	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
@@ -888,8 +997,7 @@ TEST_F(guard_regions, mremap_expand)
 	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
 
 	/* Reserve a region which we can move to and expand into. */
-	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
-		       MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr_new = mmap_(self, variant, NULL, 20 * page_size, PROT_NONE, 0, 0);
 	ASSERT_NE(ptr_new, MAP_FAILED);
 
 	/* Now move and expand into it. */
@@ -927,8 +1035,8 @@ TEST_F(guard_regions, mremap_shrink)
 	int i;
 
 	/* Map 5 pages. */
-	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 5 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Place guard markers at both ends of the 5 page span. */
@@ -992,8 +1100,8 @@ TEST_F(guard_regions, fork)
 	int i;
 
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Establish guard pages in the first 5 pages. */
@@ -1046,9 +1154,12 @@ TEST_F(guard_regions, fork_cow)
 	pid_t pid;
 	int i;
 
+	if (variant->backing != ANON_BACKED)
+		SKIP(return, "CoW only supported on anon mappings");
+
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Populate range. */
@@ -1117,9 +1228,12 @@ TEST_F(guard_regions, fork_wipeonfork)
 	pid_t pid;
 	int i;
 
+	if (variant->backing != ANON_BACKED)
+		SKIP(return, "Wipe on fork only supported on anon mappings");
+
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Mark wipe on fork. */
@@ -1166,9 +1280,12 @@ TEST_F(guard_regions, lazyfree)
 	char *ptr;
 	int i;
 
+	if (variant->backing != ANON_BACKED)
+		SKIP(return, "MADV_FREE only supported on anon mappings");
+
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard range. */
@@ -1202,8 +1319,8 @@ TEST_F(guard_regions, populate)
 	char *ptr;
 
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard range. */
@@ -1229,8 +1346,8 @@ TEST_F(guard_regions, cold_pageout)
 	int i;
 
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Guard range. */
@@ -1281,6 +1398,9 @@ TEST_F(guard_regions, uffd)
 	struct uffdio_register reg;
 	struct uffdio_range range;
 
+	if (!is_anon_backed(variant))
+		SKIP(return, "uffd only works on anon backing");
+
 	/* Set up uffd. */
 	uffd = userfaultfd(0);
 	if (uffd == -1 && errno == EPERM)
@@ -1290,8 +1410,8 @@ TEST_F(guard_regions, uffd)
 	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
 
 	/* Map 10 pages. */
-	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/* Register the range with uffd. */
-- 
2.48.1


