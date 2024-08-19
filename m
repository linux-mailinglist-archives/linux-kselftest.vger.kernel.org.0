Return-Path: <linux-kselftest+bounces-15718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C4957579
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C6282BC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44012C52E;
	Mon, 19 Aug 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HILzo6q1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LXQaYT9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E149627;
	Mon, 19 Aug 2024 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098537; cv=fail; b=fopYb2UQY9ZPna2UMkDqLT8p8HLBJFQu5S9Xh5Exa48o+2Z94nHeIsLGZOy3K8YQGNI1/vY7o+fUuqzkfgOTpFWD3DeWg0n15iGUVkzs3q4Q1yqeNvGMlNn2kLoifg9D0SdAdYKBCcy8ZyAaoyTaVlzusQQ+tAuAzc35TNWST0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098537; c=relaxed/simple;
	bh=vtrV7KwJqpMOy+i1KD0XCGj/vTkePFFjn2KK4DELFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEd6dVkkXbkcNom85dsMXz/nwYB4HT6/y9GhV//PBHQ1KXZXWEeMD9cbgosmXxAzbAxuu0ZdIyug/ZIS7eZgM0QsFp2Gg/UG2gDPf8eJlJ+zln6iUi+3QT4Y256HBZIv4Pr3zrvCcW/vF91RYIW0K30qxj6Yk4IdV3p1NWsEKRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HILzo6q1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LXQaYT9g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBTrS026729;
	Mon, 19 Aug 2024 20:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Xmk8XsO4mEH+vIu
	FhAfBm+owhrztB7LZwl/+NX14uI4=; b=HILzo6q1e2ckGpCv4aaDeafGngnNY1E
	Rl+EIBkuWCGwOotaZ1OtW6ZIlaIV+TZRJpmclwfRxQ4U4ycEV9lwWwVDIfvJ1E0O
	MBpfih36P8DVYfrPoKpmmfrmzbWvgMLby5JmkJ/VbGT4H4r67TKti1yWDEcn5YZO
	OONEOPuxxim8Cv0tvJ85kbHWxMFWayD9ZulwhEfxLQn3/gI1U7elqOZFyFLbinCb
	iJuwrSh//l5zqhqsZOcp6M/6egCdrMwuVxHoOW00yNLODSD2xZwN3opyYT6lwrII
	r2KzFVgzpiHqyGRTEiKtfg8ktHgNpGbSAE4WgmS/n/thmNALB6Z+tMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dbhdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:15:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJwp7O020181;
	Mon, 19 Aug 2024 20:15:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 414cpcrmdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKAlAtvXM3lRe0R8uL3X1QOq09717YvKbJnkdu4ibMXWIHGNM+iQLf0xQPiTkSO/7OUVz9sLNobv08H7BK/UUEC6Cvb3qZrJcFAdkxD0yMn8fAArTEKuRJdDJdPA8ooucF5R19GP8TEwSpOepEtEinnc/mbVp86PGLaYzBHwUKIH0saovcacGStDIFhiXERfZn8/g+nvHfo3GyacQmUHRXkBlMidiSE54ZEcGqt65+V3aRgT/tcpasQxD9ux/jI4wJWCrlrWYODyzNWC1zeKfHdEBtWYCWyCXlfe3ApN6QbizZlpuG2Qw5Bwt4PrW4+FLS31YLh0gCxqHralsvEBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmk8XsO4mEH+vIuFhAfBm+owhrztB7LZwl/+NX14uI4=;
 b=H7b8HjqAFJNrzKJXajs8ecQIJe7R9KDRMyIHfd1okpOg71bLazemGmSnR/MtvH+5PL1maoymCEK9L+qm8Ul/zvQ/t4wzC+ztgHtxrRu1SCRycRkvKj9rm8gfvdYHvAUeGnEmCiGpqszhcfKGvEyLfO1bkYmoyTrkGRPWL7M1eVcNssUyIDRVoPXBJHVTOZK5t6WZVmLs9DyBDjpkSb4qC+ql89Ozp6vqGD7oYUkIqJVK0lgRhUTkoKee1yIvIZ0kIgXarRZ9sd+QtdcKshNXd0FyYOPDTh8T9simCcP0ffOZfmk1U3RcKVf2EwxNuAu1Twzi08KR9XzBrnjTum+Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xmk8XsO4mEH+vIuFhAfBm+owhrztB7LZwl/+NX14uI4=;
 b=LXQaYT9gyUqzUrrfju47e46JHT2kNxvMwbO8GS+HGDr23H8p101ENI1w2GYypKzy7Lrl8wOZcClR7DfPhkHTFaMiDjvhGoAYQzn5hyH1Ot6YcP+phuSwEubOc8llj/3ApT056xbDYA5VhDJr7xpuY7lfo9vB5R5SdM2pj4QZdnQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Mon, 19 Aug
 2024 20:15:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:15:09 +0000
Date: Mon, 19 Aug 2024 16:15:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jeffxu@chromium.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Move can_modify_vma to mm/vma.h
Message-ID: <fp2z3jevyvhpjqutv4a6aziws7bittmz3imelu4eh3eyp7niie@hnyca5qt6nmm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0427.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4d6be6-fa0c-42f8-7f77-08dcc08b9fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wb7Imjx+DOGPN3wNbF1+rMWEY1coOBYn1NJyQk98Nl+ThsJ68tuZxKeWKiga?=
 =?us-ascii?Q?VFQs9g3Ejg7S8unu+8LpF51L5ibvLXNuSfJyhMfc5M+5iRlQV9rpIEzj5CBy?=
 =?us-ascii?Q?axQOZIqqa2c30CLexqVp9OWS9PjlOOJouLPERIJzNbbPL/HRO51iM/OSQuEz?=
 =?us-ascii?Q?txMMDTuqDlynJQlpbFAWHYNqkBuqNotFFAE5F5eIOyQsgHxCWwXRCikpngQY?=
 =?us-ascii?Q?DUq+hIgG1YKkktRy9NDt4uatyM4/8DHvDQSoMU4EzeQDC8aUOeP+0x9i39ui?=
 =?us-ascii?Q?h08XCAeOb0LLBThaJ3dvJ7XDZ7lxp0NHmZAoMhxPWDsnbpftIQDwqXqps+gr?=
 =?us-ascii?Q?uwv/fnyTH9/kYPiH6j8rCD27lFTUBIG9N7AHmRCahQYlZu6J9EwiAlt7y3wu?=
 =?us-ascii?Q?Fdg/vvK08uXTiFZjCZzMV4p1SAhKTJd77jbssmZyRqFxDENBmwF6DBvHWf3n?=
 =?us-ascii?Q?DZus6qI3cccp6gmRQo8YfTSTL2Nznlyw1QFXqFCcuXY9hcxQgMC5Q+0FT8O1?=
 =?us-ascii?Q?vacpQU/FC7NKgs3yZ4YYOjAPDpEUgILAxuYbWhT3zNmVsawG5bbQRJnRWJJO?=
 =?us-ascii?Q?zpAtc44Sa1qFR/o3uKWxnLUTRVQsyA4dn54YoJJmAOHaC3zi9rWs4mEf0fIQ?=
 =?us-ascii?Q?Yl9LTOZDG6/CDCz/9bAMSVsdqfyTiUZrNdd88Pju6e4glFilTLwTrLXyFfJv?=
 =?us-ascii?Q?fqvXKuXsMDC+RhUmyx/alk7fg/a2ZXwl70tnbbPHeWhT8Mp6JlCe2ejkb25Q?=
 =?us-ascii?Q?bVuIn3GU1q97OE0dPbZF+zcTq5suGDVVd6fyrnmeQ4XyH4kwwb0JW0axu1nk?=
 =?us-ascii?Q?fjyfDyYxrJ4VFsSSJlrUufCj2bPQC59F+Q7bIY5NcI4gmm2EHUQ1Y3qSLybC?=
 =?us-ascii?Q?f4DcbeJ5frX6zg1VAT2ehVFB7o15FP4zgjjzfPzoXxz/wSdzniiFafKJ68R0?=
 =?us-ascii?Q?FCtoGel+9TUbINRMT8WKNyHkLYznh429a9RukSYv1R2pUDY6lQ1z2gvHDzJC?=
 =?us-ascii?Q?2VIMjkkwRExryvKEGIbNrXpTdwLPof0F+rgssf5SJnw3MWc/aaNmoesPP72d?=
 =?us-ascii?Q?3KyWGVcEgH+q2JHypGRCmwG+O5Ek6LrNDV/EDK0lN6WESKWDczR+EfDFV0ES?=
 =?us-ascii?Q?+cJfuPyJ1Vm/lkWFaOTdBQh1HOyz88sUFD0cuQki/NAlIJ2UDFAK0Mg/HC5P?=
 =?us-ascii?Q?UAitFT4OQlWORCNNATluesWXnqAbsS7sat7/JvZiHkmsOdM1ti5g3ThV5qHU?=
 =?us-ascii?Q?MLsTsCWJKKcQgmkWXaMQHJgifWv56U7pjidzZVGh/f1+PtxAoMKPQFuVGxXs?=
 =?us-ascii?Q?vs3oGqXvU3piXjpX+t8bLsY4lzdlqWI5s9RrQq/axL3qIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5Hsf0/fws65buNxXyKDL4xrQ7UGTlrszaTkKxbvaExfQEfRLM6Sa/reQ4su?=
 =?us-ascii?Q?CIEYj8QU5W8MiT9XJwm2h9ii82Jc7JUDiCguqInvdnis+4TpcqDdj4MRQJ9s?=
 =?us-ascii?Q?HoZXJzrpkfg8nJymL+WyJnjPs2pCmci8nsCanoZZf2FKSCsRS2vZyDXK0i4Y?=
 =?us-ascii?Q?QzSc62P/o4hoXf8eWMWnLcJAu8mEitVoCMUe1wLKXf9lfmGWysmsX6JkV3yT?=
 =?us-ascii?Q?KN3e/JoYGA5dl1CxRLSFO/kHythgoRprgpL9ZgY62fZvwHA/WMRc+/15ALcc?=
 =?us-ascii?Q?Ze54+4Q7RA6093b8yh2DmY7gOHEAgZ6BRmUsCFP1/C5fSM1GsMwOliOenOXx?=
 =?us-ascii?Q?YdR9bwsZvguEMNMwr092RGF3+EKsy2c9s6dm8gCPUEmPnXr2srb5mej+FyMG?=
 =?us-ascii?Q?b6E4YxcR+k5yK1pq91wBpmwgDtuiJYzeFzke7htexKvfrWyX1tafqcgjBPUo?=
 =?us-ascii?Q?fITq/M7VP8BmSajRZ+B93mnyelyXniFvw6xAFOKPizAJR2ipCNT/LO2ktk25?=
 =?us-ascii?Q?w20Lh3xCcBtxrYHm61Cw/4tzh44Gx1uFIuwzI0iPFdf0LsRLuKI8tWyAL9oP?=
 =?us-ascii?Q?gLomXfcKzRHRu+AdMoZkhuGQlWVruxw2hF9FgzGplls1OPi7SoObdgolrYTN?=
 =?us-ascii?Q?prkC1mw+W5fx97IS+obciUkfaKDembLL+UHDfOvzYePgYCBXh52xC/72JKEU?=
 =?us-ascii?Q?g9nZXRIagxYBGYBm0WY4GvswcJtsvphwSHoeDHuaiV1e2V/2pOZiRIILzuLs?=
 =?us-ascii?Q?KtIp1M2P5Uoyaami7Q8bMzjmdhHUV2j/dopUGwChNpaEHtgx3CkATGMljb5h?=
 =?us-ascii?Q?Nxh0PsKjeN1WTcH4KF9UDrYvpWnYvvEaHjQEq0xnTzAwmdGYcXN3jxKIWBLD?=
 =?us-ascii?Q?d4+F2qWZ3izE20iOdJX2SEpZ6s881DFUOLtZ2rwmNqCheXpbkelNVN14/XpS?=
 =?us-ascii?Q?vpGIVWrcNtIlYi/b1JhiU5CUonGS5k6S5DAmLz9gj+bAsHEtvqfWHA3MbneK?=
 =?us-ascii?Q?vMtQV1lwGkQM+L+lgLMrzkgjSI0fM7z3Os43Xts0KxzhB1tKqfEQfjH1FCr+?=
 =?us-ascii?Q?xZSxIhOx2nwaTfGO67YIPrHdlC8eF7jIz6yD4cV2N+eS1NxWp32DpSriG/et?=
 =?us-ascii?Q?qhXrofUcXJqBU3JdtKRIJ9Vbx8vZIVf2S8TatF2mKe9c6CdZz3QnFu5OKPLG?=
 =?us-ascii?Q?RUAjQJtZnh8OTdfEvWwBjpF9w2E1aMkSctgq3zPER+vNnfchkegy+Z2JFaeX?=
 =?us-ascii?Q?yoKny2PI14yFdu9fu95DDuhIJ2jkHIdkBdiONEfF03saEQcSpPe8+Ef5EaHv?=
 =?us-ascii?Q?BbWxA20Da36n40509FaEBzl+wqJh8APQt5Qz5EqCQRZ99i3sUFp/UrDqJBVx?=
 =?us-ascii?Q?o9GzlEzSHmVyp4LJAsBYZobJHHw7pK8dKLPpeTrAQKLMGd8z8AuQKd4HL+m1?=
 =?us-ascii?Q?aCJ9HFOeVLqUkcrHB2Vt2Vx5bmDKap2wFD9MqvTUJxDXSNQhNZRN/QyZO1LM?=
 =?us-ascii?Q?f+LfP54D94djtIGNjIRAfF/rpDZ6n4GPTOzvhUbLfY6695MFLWXcSZaFadRp?=
 =?us-ascii?Q?4PdP34SBTlI11BuFToH+SC5Ks3aL40dK9N7DOSre?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PMlWbEcDrP+gZzVUUShi2TnGspW5dk31jPl7nuHLQoBD8aWRkysE9PbIWjpsuj08RQHm3ea13YMEWCvTmXaOFBlUvEA1ThG5YBtqUeWE5sMtJ0PIN7ThpQs7d/u5shkLFoHuy6JlFG4F93UgxWSJhBxdndCimAjRSpi99ZudmhqHyl3rkwVmIeaUDU9yHEypds85GpXcSz10S5jSX9OussII2jEXCx6roEtm2g53VllMUXYzOcw7AxJexf3fKl/ZhZCprRkFTRFog2wD+s7d+wz5JDiVlQLiJmM3mSo9jfMLFyUHj4JOKOBHOd/J0GLIedWPyxbZsJ+k/JVhL90X4M1wzZzkF/3co3d8/1Bk5NI0EYFeDLC/3rEDeEpY1nRU6F5ino1YKcmWY+naq4Ar+pQdIuTWnvN3CpZSPE8fNL5XemzQmuDvk+K1OOXp6ZL2AQvHBBd3rhiH55MSwI0tO8s4NX8vMNBvaOdHvLlO8ct9oe5wPJCJyNJtCGu1OtWXbSOgPur2AlBvazWi1NZGUc/wLF5cP4yUgWkVFEbyEh6V3TKj1iUS33AZAu9psZUycoi1VrabENjszpsFSTznMPg4iz3WIDY15zuh2PFyRBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d6be6-fa0c-42f8-7f77-08dcc08b9fd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:15:09.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTO2zurvLKtbGbxYwPR0jeSGSSlnTievdpBztu2XvfNrbRmoYMuOCwvtjk6d4PaKiY5OYG1NHpfzLvZmo0l+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190137
X-Proofpoint-GUID: 3_eJSkJaKni8SvvHiR2Twuh4l9AsCt90
X-Proofpoint-ORIG-GUID: 3_eJSkJaKni8SvvHiR2Twuh4l9AsCt90

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:18]:
> Move can_modify_vma to vma.h so it can be inlined properly (with
> the intent to remove can_modify_mm callsites).
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mseal.c | 17 -----------------
>  mm/vma.h   | 28 ++++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 15bba28acc00..2170e2139ca0 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -16,28 +16,11 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>  
> -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> -{
> -	return (vma->vm_flags & VM_SEALED);
> -}
> -
>  static inline void set_vma_sealed(struct vm_area_struct *vma)
>  {
>  	vm_flags_set(vma, VM_SEALED);
>  }
>  
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> -static bool can_modify_vma(struct vm_area_struct *vma)
> -{
> -	if (unlikely(vma_is_sealed(vma)))
> -		return false;
> -
> -	return true;
> -}
> -
>  static bool is_madv_discard(int behavior)
>  {
>  	switch (behavior) {
> diff --git a/mm/vma.h b/mm/vma.h
> index 6efdf1768a0a..e979015cc7fc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -361,4 +361,32 @@ struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
>  	return mas_prev_range(&vmi->mas, 0);
>  }
>  
> +#ifdef CONFIG_64BIT
> +
> +static inline bool vma_is_sealed(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_flags & VM_SEALED);
> +}

If you respin, I'd support dropping this entirely as it seems
unnecessary.

Either way,
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>


> +
> +/*
> + * check if a vma is sealed for modification.
> + * return true, if modification is allowed.
> + */
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	if (unlikely(vma_is_sealed(vma)))
> +		return false;
> +
> +	return true;
> +}
> +
> +#else
> +
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	return true;
> +}
> +
> +#endif
> +
>  #endif	/* __MM_VMA_H */
> 
> -- 
> 2.46.0
> 

