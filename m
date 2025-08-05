Return-Path: <linux-kselftest+bounces-38311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE9B1BA85
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D42184343
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9629994C;
	Tue,  5 Aug 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N/OplnzG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dzva+/ZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B72E36F6;
	Tue,  5 Aug 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420219; cv=fail; b=IBjFjmkaxd7AhFHVetC0so11bBktTuwYPjZXsMLxkH7mMIxieL3zNWX90360JBetbN9bbrx8Xi6NMxqtjXbyMwUi62m9yGthyA9Q6NKtLllZyS6kJ1lmQ3D65dIXI4xRlaNgHkMc21o+WNFMic7JWvSLwqkDOoAAkFznE8K0ANo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420219; c=relaxed/simple;
	bh=uUWS8oBqSaupTMJ/T86A2SrkjIAd5oOFe/Q7xpc9OGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U6o4VHfzhNvNcgtesuSFv60trbu9fb//xwbSY00jcJqmdS3uw3b+bCd1n3A5w0uwjhxGk2xDpFJlo9Z0Jp57YESUgp698GUh1stxjQzjtnhlGKo3Hg+9IGcO/HS8vjNnc6If+PDu3djeiBgCpNXP2bo88RjpiBT0c7n9egyMs1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N/OplnzG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dzva+/ZP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575Iu9l0002355;
	Tue, 5 Aug 2025 18:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=N68EWTbzAwGVy+tN9W3Pk6y5gHEVHmWjzPsA4z7R13M=; b=
	N/OplnzGpfROnT3+NJxO2RKONt2qqqVuOseNMwsF/yZK9uP5GMy14+hOPAc7aDWb
	Ew74IMDJgchmVi6RAFLiu3vgfPyKSLlloUzfaO3POCNdpYKSFqg/XlQYQGyEcT5g
	W+QyfM1ASBtOF6mSAKEvil5YX5fOGqcZh/hiJKF7faYXw/S8UCv7dbbsTTKRX9O8
	jsvT/9gWuorjitzZ7kn/+zYOZVxP43V6oumH6I1LeEQYomjOlxXuh1frGB/rYghx
	z23mUwja2q6aHIhFtfw2A8CTFMYdt0xgvSg/l20Tpw8IsCZzQB68k5crmYAy9MzJ
	Xb8vOCRa++fhQfjPraoMHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy02x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 18:56:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575I4Gtt033762;
	Tue, 5 Aug 2025 18:56:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwphx2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 18:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCOu/APBjE//Y7BBxMRg/1THgs81YOksHLf4apM5YbbVBFcCLOnCEzTk6glju6eQJHzDzt2rnyrYam0F4bwldo1pFtIT4vF76IKDveS1qMHusLbTqWezzBW79MImc8KT6w57b/n1Yx6mg1ru6x+ZDWh4/1HsmZovRuSIht6OZpki1Ila5s1hR6r6ip2uPYFLVpsVF4+vNcCeoWNVvImR1PkY0DkbC6aDyWnPkR6KcTYvVnghyuFQAt8Lhw9Hs12xsUe5icqwYs6//iZgzebUKQxkZ5j3QRM4CstcbSI5InhJu9CQsnUl0Lz0PgLAAaN4W1p0RsA+bWtni4t/hfxG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N68EWTbzAwGVy+tN9W3Pk6y5gHEVHmWjzPsA4z7R13M=;
 b=Ph15D8273I7amIp9yk9yWkq/+epLehKmPJyOTSP+FLki0lLljkivA8HNOA8bZwB3CBXvYVltTGzncukQafjdUa1LHDGC/4XkpifPlmjO8XIXmpPJzMJQXz2WqlPO1xPb5LnO6Gp5cuXE6Ns+FdsjabN2dwjsuIQsiqFZ/pQkEAQTjWwEPph3BoxA+IzMnI8R4L/6pxB/mPJ5w5Fp1eb4NgK6uZ2YHOJfhOkGu/r3ZQsE8lzbzXMFad1q3ogPhnisrKEH9bivOKNeIjscBplalQBP0Y6wflBIlI0py/PmPQ4wrpAEcOkbTzqkwgE7KjyHBORzr5hlmJ5wJASfh3g7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N68EWTbzAwGVy+tN9W3Pk6y5gHEVHmWjzPsA4z7R13M=;
 b=Dzva+/ZPgUr21LHKuranz1nSthGHnUByVlRGgwq+N0ztVIULsvHM/wTQOc+Rt08LbLRV1nr09l3OmUtKs405aU0Pzkbz4dMmdd4YmjttZinfNGKLJlNxpOhBEIy3xobEVp7HkG7qGkW43hcSU9eWHT7dOhbdQt3NKR9EjoNEI7E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 18:56:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:56:39 +0000
Date: Tue, 5 Aug 2025 19:56:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Jann Horn <jannh@google.com>, wang lian <lianux.mm@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian Brauner <brauner@kernel.org>, Kairui Song <ryncsn@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Message-ID: <ea442b14-6f74-41eb-a315-7cbee0f0eae4@lucifer.local>
References: <20250805175140.241656-1-ziy@nvidia.com>
 <CAG48ez1wKqyCKZX7J2eJekTuzRshVE2btPEWQEm2hW9Ri46Uuw@mail.gmail.com>
 <76EE266A-7E9B-484F-AF97-85A99D109005@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76EE266A-7E9B-484F-AF97-85A99D109005@nvidia.com>
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 66383294-2bfc-4214-04ac-08ddd451cf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmR3QzEyS285SGN1RHBnenZaOEs2b2tTVGZ1NnRzYVN3dGFvZEk4aHkyK25p?=
 =?utf-8?B?WHUxQmszN0NXOThpdEUvU1ZyQ095VFZmTWt6UDFhSVB3WmRBZDdrMzROQ2Vj?=
 =?utf-8?B?NlBiWDZXU0JraXZPcHlmZWgxcm5HTVoyRHIxbCtzblpTeGVISnVDT1I1RHkv?=
 =?utf-8?B?OXh4RDVWQWpmQVhCaTh4MnU3bHFua2poUUtqYTVMYitKY2hHazZqNldCbjBm?=
 =?utf-8?B?UjZ5c3hWaEd3cEZmQi9OMzkwQWZFdUthY2kzd0dJYm5jNHBjYjl6OHlDRHo4?=
 =?utf-8?B?M1VTSFN0ZnUwMld2a2xyZDhRcWI1cFkrN1JybUE2Q1BoNUZTS2d0cXNGUU1M?=
 =?utf-8?B?QUdsS2lHZitwK3VibEY3SkNVOFNRR0dpYTlYSk5JK1BLSGVXN09CYkJ6eUxQ?=
 =?utf-8?B?WDBNNlF0dEtxZTdKQWZuN1JEUGlEOGFTTTNkL29XSUhiZmpGUklmakVWaGl0?=
 =?utf-8?B?d21mM1M5dDZOVDh2SEk2TmEvaS9qV1FLb0JXbEpESGRVR1lWZ1hHVWovRUY3?=
 =?utf-8?B?TTNFYW1zRjdNR0NzU0UyeTFaUlNhSFVZcWYxYVJBeUxtdXZGMEs1VEYxQ1pv?=
 =?utf-8?B?SmZsVmhIcFlpZUFWdklRNDFORnlOaHZEeXZwSmc5c2JWb3d1Z3A1Vzg1Y3ZM?=
 =?utf-8?B?UmFxS09vWU1tY29jNFNjOU5TbTFFODdSSmYyNjNNY0ZaWWdvR1gwTEpmVW8r?=
 =?utf-8?B?SG4wSXBqcUtDVG95UUhIT1pVdzVQZnFTL2hYY2oralJYYnEzOVFjV2R0MVg5?=
 =?utf-8?B?aGQ0RUxaeE5UNTVDUFZQM21HOFJRY2svTm9KcW5Vb3BIaml2R296QTBXOWxC?=
 =?utf-8?B?UVJYOTJkNEx0bC9NSm5wMU1HUzdvb2ljZ1A5Z3o3UUE3czRGRXR4ZTNMVTRl?=
 =?utf-8?B?YWtnN3RZUnB1K0pNY2VsVFdnN05ZaTdndW11amtVaFJlSXdKTnEyV1VxbFBE?=
 =?utf-8?B?c0NzTWwwZlh2dFBTbTdwTGpIQUlQL1RkR3loVmJWZnVkRVRERVppbGJKdzQ2?=
 =?utf-8?B?L0Npc255YVQ5NmJHVUhlZTR5T1l4TmNkWEFiM09zbGQvMWhLdGFEY1FOS3dv?=
 =?utf-8?B?K055T0lLeUxXV1FyQ1R4WkFFNmJlbWtKNkdTZUxrNm5Ya0V5S05HNzM1QVVF?=
 =?utf-8?B?bnJ5MldrbHJMYWdsMTB0UVhqK3NlT2Z1RXVzR2hXbFMwd3RwcHV4YXdpcUhW?=
 =?utf-8?B?eU9lejNmcmU1OXRBaFVrTW0xLzVmTTRvMVlGcndBT0x4ZG43bGZIUXUvK2FZ?=
 =?utf-8?B?Wko1NEJyUTVtWXkrNG5KNXgrYmJ6QW9HT3huVjFSb21YNEcvUzZDSzlJUGpo?=
 =?utf-8?B?SnY2VTdVUkQraW5MeFg1emtuZTczN3dBV2JaYVpodEJneE0xcWd0Z2hnOHhn?=
 =?utf-8?B?QXBjc2VaVnhlTjZ6TFJlY2gwVytDRFVqaFNydnJucXNaR1pVRnd6Ky9Cdkdx?=
 =?utf-8?B?cWx0Z1I5ODE1U0w2WUpTWFk3VDBVWjFGbXdHbmhXbFJ0R1JKZTlXeXhMNkdP?=
 =?utf-8?B?ZXZWczJKTUpnVVFwcTEzd0FSdU1SekJpT3FVTHZtRFNNMTNKcVBnVTFWNlYy?=
 =?utf-8?B?c2lIUkE1ci9pZEprVlExc3J4aDNSTk8wUW9PWG1xWHAvcjcyeDdvNGlueGo5?=
 =?utf-8?B?bGhPVER3TmN5dDBVRVM3WUd3elgvYVZ1SFhvVnAxaHhjLzVKNVhCVU1TYTM3?=
 =?utf-8?B?YW1JeGI4bUpWVDBaNzJ6ZjdyRWRoSFNQM1R1VzVwVU5wckZkek1oZlprZ1ph?=
 =?utf-8?B?VnQycVBHV25UTy9kZmhoakpLTEhoSEJiK2sxbWc5WktHYVI1LzdQQ28rZzJH?=
 =?utf-8?B?M0FVRkRLbEM5ZXBMMUZ4VmNyallBaDFlcmlGL0p2NGlsSHFQTk1ZQldWV0Qz?=
 =?utf-8?B?SkxWaXFkS3ZKdmxPV240a3pBaGJYYXhSRmtuNkFGZTlrOUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0k5R2dIWjBvSXhWWUp0Snk4cnJoK3loMWtXNWlHZ1NZRzF3UXA2cllwVzZm?=
 =?utf-8?B?UG1ya2lacjE4SVZHUTVkSGczY1lNYXRnSDdqMzJ0clpoSWJTYVoyZzhzak85?=
 =?utf-8?B?QTVBS2VESklQdjFPQmFXcUpzVE5veXVTc1pwT3RhOTFRWmtZbFV5UVFjZzhR?=
 =?utf-8?B?MERJeGRxUTB6T2NIMlBWRW1ZaEc5eXdxRDRxR05hc1Q5K1JRMWx4STRBaVds?=
 =?utf-8?B?N3JNRDhqTnNucE9Mb2ZOZnZNWERwaXc0MzJEZTU4Mjhyb0Nmd2FzRld2TkFr?=
 =?utf-8?B?L01tQ013ajVFVThvY0UyS3k3dGdwWHp2aHJnK09KNzVMaEtDS1ZJUU00eXJR?=
 =?utf-8?B?VU02UWkrK0lNOWdCNGV3OVpIa29naVNxV043RHNBSFRFVEVxT0tjZU14WkZt?=
 =?utf-8?B?TFRpUUdlQVFpOEhqbitIOFh5Z0NLeTF1M0xjOGZOWWFMdTV4UVc0cTlCWXJs?=
 =?utf-8?B?UEJOUHp2ZFlhcE1QQk8yZjhyaEVBamljR3gyNGhhTUM0TnZTYWRKRXJORmlE?=
 =?utf-8?B?KzdWcEZsVTZTMlMzM25xdnNWRXMySFNSMUFtcG5yWVZWVHhZTm1CM2JjcC8r?=
 =?utf-8?B?eS9BTCtiZHorNlNrUWlzdW5sQklVQzI4M2RHbHp0MkdrL3V0dHhxWUhEY29x?=
 =?utf-8?B?WDdTeEprQSs1SlBWelEyc1lIOGU2dzJJYlpEWnRTTU9GYVNDbnk5SldMTlUv?=
 =?utf-8?B?b3FtRkFZbDgyQmsrM05qOW5HUVZaQUdaSWtPbExlOWdPRC83MDI1Ky84K0lE?=
 =?utf-8?B?MmQvY1BJVzNuS2szaHlVeEdMdTVCUFZpdFhiNmVGci8vWHBZMmhpQWVONW1X?=
 =?utf-8?B?NGQwUlVLUzVrVWZUY2V0NnJhYVZzaFo1c09LNGI4MXdxMEtFVlNIRTFuYUp0?=
 =?utf-8?B?M0J4UmZ6UGpiZDEvdFJaM2krbmFFbUxhSktWWmtxMm5oQ281a29zanIyRk9V?=
 =?utf-8?B?dTFyWHZWYXVzc3JZaXpJbDJ2UWtjN0ZlUm1OQzZVNnllSTZ6WHVteVpwZStH?=
 =?utf-8?B?cjJlYkpKYklOZGdCZ041LzhIOFZleFl5QVUrUFk4NzFzR08wdzdNOWp2SE0y?=
 =?utf-8?B?WHB0NzkwQ3Zyem40cHRMTGcxV3gyVEVScTJ2b0szVTZiZjBhSzdyQnllOVRh?=
 =?utf-8?B?MndRcUhhNk5BejV4VEhDNXc4ODcvYWJ0TzZXYk5PRjA4c1BDTHMwSUNMd2Zi?=
 =?utf-8?B?WVAzNkg3OGNjSC8zMzAwZmdmY1cvektOSVZHeVRDMXlJajR2UVIxN2FEL3B0?=
 =?utf-8?B?VlZIaGFERldTYy9hR0tsajQ0VCs4Y3d4Y1BIMldZY2w0R1VDb1hWUFFvV1Ev?=
 =?utf-8?B?K0E1dG5VdEVXNFd6NDNUd3JsTEswTGRPNUVPU010WFB2NEpyQzVJTnNLeTR2?=
 =?utf-8?B?UWZOWlFldVJaVGcrQXc0YU4vWUh5ZHJFQ0pEdWNzM0tLRGcrM0RRdWlvOTNP?=
 =?utf-8?B?QUdSVGR2d0FNYVJMN3IwSVZvMWN6dFVZUzV0dnR4aXh5aEZOanVKc2cxQ1ky?=
 =?utf-8?B?QmdpR0VvRXYzMWU3Z1ArTVpoSjNCRS9rR0hpcXJnRk5pQy8wSXNGOEozSUpr?=
 =?utf-8?B?dVc5Zk53M3o0ams0TEhPeEZ3UHFGa0ROOUdYWEdRVGU4M0ZtM3p5SURIV1hW?=
 =?utf-8?B?b2dZUEhXbWovR0xrc2hxMWU1eitEeEVBd01rcjQxaWg5U1ZMLy9pbmNudkIw?=
 =?utf-8?B?TjNPSFVRTjEySktUbEFkd1NvUnprL3p5Vi9OOSsxVWduU1JZK3BvSWdGSnRH?=
 =?utf-8?B?VzRHTXJYOWhCcG5ULzk5WTVDUHVNTGNGd1JscWRQUFZFaCtXd1JYSHpJc1N6?=
 =?utf-8?B?NHlmRGF1QzFTQWtUT1ZSUmxBdWR4S0dWa3Vjdnl4UGlwNWxyOTBBNHZnaXlE?=
 =?utf-8?B?TFpUTWxXYVBkU2dhdTVsV05iRkNHemdGMkMxQVBLeHdubSszbWNRSlRtbERi?=
 =?utf-8?B?bnRSUThtYjV1cWx3Rk9aOGg2OHJ5SEF3aWNhaG5QM3hZV0VrR1ZNU2dFb1pl?=
 =?utf-8?B?aUN4VWg4Zk9HM2ZZNmo3bE9sN1p1Nm1UR292TklDRW5VSlRtUmQ1ZHdmS0hC?=
 =?utf-8?B?R2hPcXRhMlkxa2QwbTlwSVkzYWk1WHc5dkZpUGNCNnJ6NTVpM05xMWRPWTU3?=
 =?utf-8?B?bW40K2Fud3ZYUko4WTRoWC9UbVBkVXZXRHFHRlFteERaZXVsMWtyZVRrSjNk?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gv3dfzQzDwhhS2HFuwTGliGagGpBVMIAxTs+c5p6zsxBDDRnSF+pQwsUG67HDxlc2zDudDuR5bQjWMN8hPhcsva0J2lpidRbwgY7NA5/JDLSF9/CC8y8zwoSg8GHPTca5Wufoq4mDcYlDIxnKPbsRnFeS6G84i7PSoOi6IHXmLF06CkaV5h0Lg0hg5eKam8rdt1KJ8f8P7qvsj41Lw5hxZz/SoAl5zQQgWoY6x5p8rpRuEkJWcYlbPaDRNnw040NMO3r5p46+t3F0+mIct9dk4fEdHZ6ngvOSHD3TXDnRuzrps4zklraTMk0OXDoq8bCA8nrn1HcEwRAbuOFHcaJKnxlLHluLPe9fBI5uawcaT9lYTRXZ8xk5kQzc5BabE1L5TfO/vfqjK1G9jkEB6XIINQOdKCjz8RL6VwWR+9tymxdVc5Ncj3KCZ/G1e+6YSTO2FVJFgDsEQPjNO8qkPNmN2cHFpTw7CbDf3aT0r+D6WRCqmPDymbr8dQlpTFDCPg95C9alrzTBEcUnTLjZg3gc3NavLZVl691uZsXgjJ2w/7dwgiOJvU2uYIEnxIU701I0XmJpe1F7m/rY51cNCk1L375dWbNclqFSryaJTDptVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66383294-2bfc-4214-04ac-08ddd451cf8d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:56:39.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+3fryAZD0aOuvYV0lp1CZ2bZW2o4CA4xljJz5+pIilIIiA6v33QXrD0B+jys3OWs9FBUAo44FXzQioPSTY0aulOeC6cg8OU80YUDAm7NbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=930
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508050133
X-Proofpoint-GUID: PUsG32lQULA-EeHMtT8w6lEGXL1yqxlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEzMyBTYWx0ZWRfX8YwqcsmmsWRA
 tC/8oMPR6VpM9wO5Ughepcb1f6mCE3E4uP37EUBsXUsYRKsj8bg300zA5PW3ecCUqsBo8vzVik1
 CZKyG0g9PtuAGZA0h2cEQH1Jms909HB0hkYG2vQjqLm5xC2yfuKoS3Q0ZfOpZ8uWBEKTRl7EOiH
 7zMw0/d6wVbAhTdJv0llr43YnV6kROl5dNF/edEGfLxbbquFZD3tV3ky+EQfnNGZJoX9GeHXJPV
 1cDQ7A5BLSCw5tTFGfSnZzXxImI49ZCSkgYlKM2cjNTNJiV30eKaOe16atH9w+T3QN/vZDuqywU
 pqZBr8zYtHokOwqdhSQvtclSKrk6O151j74mKGaYouce8KeUrYCkyA05hx0wPdphUlVxIm0C9rC
 fN/cd3MIU3ESRyILx0J3DOSVXsIDFakt0gP9AwD3Qh/NykiNaQr3zK6FVTQLHzFapj3g/DFE
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=689253eb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=SWTlfMS_py76FdEXo9QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13596
X-Proofpoint-ORIG-GUID: PUsG32lQULA-EeHMtT8w6lEGXL1yqxlK

On Tue, Aug 05, 2025 at 02:48:25PM -0400, Zi Yan wrote:
> On 5 Aug 2025, at 14:38, Jann Horn wrote:
>
> > On Tue, Aug 5, 2025 at 7:51 PM Zi Yan <ziy@nvidia.com> wrote:
> >> FORCE_READ() converts input value x to its pointer type then reads from
> >> address x. This is wrong. If x is a non-pointer, it would be caught it
> >> easily. But all FORCE_READ() callers are trying to read from a pointer and
> >> FORCE_READ() basically reads a pointer to a pointer instead of the original
> >> typed pointer. Almost no access violation was found, except the one from
> >> split_huge_page_test.
> > [...]
> >> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> >> index c20298ae98ea..b55d1809debc 100644
> >> --- a/tools/testing/selftests/mm/vm_util.h
> >> +++ b/tools/testing/selftests/mm/vm_util.h
> >> @@ -23,7 +23,7 @@
> >>   * anything with it in order to trigger a read page fault. We therefore must use
> >>   * volatile to stop the compiler from optimising this away.
> >>   */
> >> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> >> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))
> >
> > So is the problem with the old code basically that it should have been
> > something like
> >
> > #define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))
> >
> > to actually cast the normal pointer to a volatile pointer?
>
> Yeah. That works too. I would rename it to FORCE_READ_PTR to avoid
> misuse. :)

We were having this discussion on IRC, generally I'm fine with it as-is,
though my version sort of intended to make life easier by passing a ptr,
but this version makes it closer to READ_ONCE() so probably semantically a
little better. :)

>
> Best Regards,
> Yan, Zi

