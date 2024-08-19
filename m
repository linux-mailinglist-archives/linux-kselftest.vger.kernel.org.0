Return-Path: <linux-kselftest+bounces-15721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1726F9575B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D1F2844AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC3158DC3;
	Mon, 19 Aug 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUoCyc9n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oi//tPfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F6158D92;
	Mon, 19 Aug 2024 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099580; cv=fail; b=bLGXKHtgGf8IgmWpaY7Ri+g0ftCtHWHweM2RVTGP8d4WHGFkrcowSZsOBy+Tbf3GrMWPNeY+tF/n4fHpPyOhLZf7mSYzU2yfrqu+atFAN4jnBV37mABRWs0LfmRV6N1fnd/v0Qn3VgNHP+59OuCf97kelVWEyLRe6hH3N1WvHrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099580; c=relaxed/simple;
	bh=9xN+TNsxdXae31gxm8W52BFA2u7gme0Ak7bQXtkyNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9p6LT2xXzdql5bMDW6cQeH53HjfaUTPhKfW+wYHfPbCE0UV5xi2zGQAf11EpQ6FMw3VdrKss/i2/EX/4Kf253xwvxo96ZY5HTYtevHKTdmAfdQWJKBe3rXXAw+ISpBDQkGaMzPl9zB80Xosm+0H3ptCrR1Cb7eU/dW4YKTaP+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aUoCyc9n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oi//tPfZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBTgt026715;
	Mon, 19 Aug 2024 20:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=75xlJZhn7WqU3O3
	0D+vzmr1I8YzvRYQOEJsejMdA8C0=; b=aUoCyc9n/l1NPSExQYTG0gBUVSyLDLy
	DQu8cpN/eKU7tLyuVdYhFI/0YMA0+PwZQrVAqpTSUUFbF13RgzJKPqVk1PG3vGbc
	qmLni1NWuAPadQ+ZJNsCeRRaXKQ0yIt3KCSw1d5YHf68wbzKYmoVqwLXpw289AkO
	w/XlPFNTPGgho2CKK62e99+ZPZhBWB0fopRcYuthXB2XkzHVSh/V4MIsRzi/vNq8
	FjMddY/QasWaEKOqm5PAiLEyhigN5PSzYzV/H/SbwjS1ddf6ZndrMy6XwX4k0+j0
	dDa7a0diD+en9DFz+jJDuRA/ei4u9CU0kiCedUyaKrIa3PrBUfTswAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dbjnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:32:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJdVNB037674;
	Mon, 19 Aug 2024 20:32:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h5sm3wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnCcVTfJvG39clD5ubAzIaP8UerQXtgQ+EHiDb3XaEooToBzjhRot0vKi6EHUoFINJU45tp1XHZMhqGiVx0gCyCGPsBm3zycFRuoOprbVprGAc3zPvLayzGpWPzBspaFIMiyInJR05TagzP+50mjJHqXzKSRSGg0OwWr5VCT/cOSrmwS6EIFmj8F07D+L2kqlKQPb9pDyDUHKi3/vnpvW1E8PpkiW45j5PVx+WE8B04KFVcIOz95FC4dtkoWYHSp7JF07v3lDYPnzZNjeL92xFdc0EBZ/UZfhpOcDLAktZl9Oph+tqTdWV7yDSf7YLFAwJ5ZHlX0YV5ZSlm8omq7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75xlJZhn7WqU3O30D+vzmr1I8YzvRYQOEJsejMdA8C0=;
 b=r+oXo90NGZg3bFOs2y7DnH0piohc7pjqFX1Lg0ZMM3sCQMPq/CvYfWG2zDDxxRR6gzU4irYM9yfKi6YlU1EqLmrWIjkloVsU7B69a4yZsG2KjwRcuCChJQ5CAcWKVBnSK4CZ/jDvB1nwxXPDp5YSeQRePwMqNg7KahxFPqmN3XaMi0hn9NIVTgELABgdcQZx9i9GdgKq0IyCaJUU0RS646fW01NjA8/Q5fgXMac0Iso6AKNaZYeI7gp81fY3yx9B4+Y0F8BuO0GKhkAnYEqd5zCQ104I+loq5aXUpTTlNB9KcTsW9tqBxxVMSNRgdOKudhdJY8DkRCjdm5a+9SRjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75xlJZhn7WqU3O30D+vzmr1I8YzvRYQOEJsejMdA8C0=;
 b=oi//tPfZMROePUAgA/uJPx9nmBox7qz0McoJ5G0B9qJElzxQAZTTLZbOKJ68hf1pb507kPKs+T8rgnLJqaIZfv6K7Fk3nrlZIzafSgeHW0pfFtxVNWF+hA44dA4n6K2vP2wyZ5cGK71gJCXUJWo5SuGAoevX5BG6wEZlB2lbu+k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 20:32:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:32:41 +0000
Date: Mon, 19 Aug 2024 16:32:38 -0400
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
Subject: Re: [PATCH v3 6/7] mm: Remove can_modify_mm()
Message-ID: <fkg5t5etq756jjpxqpedlud6tkbvxtevfzledwxog6tbmhu7wz@wb3mtvjglpdj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-6-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-6-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a683dd-1463-43a8-8091-08dcc08e12a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b578y5m65mZcs+7ZzyTeaV/HOcr261hijSZtBC2uGsEO8rDH/I+uvagMNoDY?=
 =?us-ascii?Q?DIbdQo531VFTGPNuwWzQs/C0xwmk8+S9/VYDRstEMMb/efGlW0L6/0Nj8ucD?=
 =?us-ascii?Q?I/n571Ew4M7oX6ggCdoSLwjCVGcY5tm4aqZruv69piZq30++XTD+3ayYpwgw?=
 =?us-ascii?Q?XfPz/0v60Li1HgEW3IYU+yEGHOGnpu9KUSTz4r90IhQCOMXhCXCs3AKL8JVn?=
 =?us-ascii?Q?9ddH2JcXJ6Fdwx6iIQeG2mZc25Y8oQFrt7VH0gjrU39JwaD3lYHHpw8DNXbx?=
 =?us-ascii?Q?s0DGxVcVh4LcNnwts+wgw25IIf+CwsmrW73NR3QDDdjRJtpIW+eFsl8FRWLH?=
 =?us-ascii?Q?+VOZNATnVzM2/fbqctpZFtBI+bSJDHYTaFeOdvtPG1+J0nlF/jfQL/Pfo8eC?=
 =?us-ascii?Q?IOdLm+Ps+XCCnwIWEWiJHrC7ZkNaQiEBPH610CV4ItdvKfTX9totl/Wc0XIo?=
 =?us-ascii?Q?sNtMQW5JzVf9NFx+W1fTGTAcie75Wj3eqCustybhlA1xNdkiLT/PSVceTSSh?=
 =?us-ascii?Q?aN5J9htLuyWgxPllKSLz+YUx6K9BfVpmPjalWmUeKo2EbeY4xEflZJI3BhFf?=
 =?us-ascii?Q?X7H7W6jo13UX5GyJZs1SSnKwi46unG4TTWSLct0+AOqdTBzLbTtR+9htQ7hG?=
 =?us-ascii?Q?gt++YLqJqnQzEEhVOWw5FFumVotWAUcaaSe4SDqSJ8jdGBrI8oiKNRkWk3zL?=
 =?us-ascii?Q?nq0fA1+1V9Zp2pEKHIuJTKcVcwfoIGruSTRck5MjjLRUYQEqxmq0J4fLTjOR?=
 =?us-ascii?Q?hHaBlFA2jrXWwWcllNxWW54liJmtyWAzF1YRvE02lKfC2fibW1T2J/vJX+ii?=
 =?us-ascii?Q?og9M2/nTLt/XDjvUC+Ts6VVBbA9eBaKV1bhFs7q2sQbTiEdtIEnEbS+BF1yh?=
 =?us-ascii?Q?pzR2XQpkynpL0zqlb1MN8aKCY7GSdZkHjw3mBQ3A/jKIN4pZHzKOTBsnQdLL?=
 =?us-ascii?Q?dTl5WghQhgMv8upt6qp+LELdQWava342YI3eyQd0gxb/fXTtq3lEYL+MBKnT?=
 =?us-ascii?Q?lAmJ1h2/EQkHy7LikDPbdH+KldFoPWKYoHHeL5pv7n7eEoPhZ0pkTSUg/Rni?=
 =?us-ascii?Q?N8mRkLvkunfkQ79syySmWjdMrtQvZUXXxJCRpNy0GwKIgm/Y5ZRSyx1BzenV?=
 =?us-ascii?Q?Xzc/p67jbRu9QcRqI4p19DCX/NXBKPIhtbB0pFnMR4VwskOcKkI22NSFZ3hn?=
 =?us-ascii?Q?5sTp8Uen2DVfrzXzaCoOUxp6hip5Jhn7V2wla85wrVRxCKzHXR55Bw0JSWd5?=
 =?us-ascii?Q?ceY3tE93E1PE/f6+v8EUR4GkEzjGAdWgwFJm0b+pdl6oX3FQdppETX7vsxk+?=
 =?us-ascii?Q?+9toddjVVl5xZQSSYJ3hddzipp2xp+T0GLrMd2YFbJOMlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adbRaeeoEt5mabqp0sx00Fpy/WaGzYYTLFxgHhR/ftzPJ21HsWGrhGYLsbH2?=
 =?us-ascii?Q?qrLIIkQU9w6b/pOEunKCg8FdDJJdFLejNT2gU9b2WcQVBCX9Poq9vNnVhMXI?=
 =?us-ascii?Q?9ONtxmqpn5FcK+DxrFYgSzre4GHqjiTfraqIhNgBTYA1k3uRiR+9JoVMtJcx?=
 =?us-ascii?Q?+36yIhDRBwrFiC2pBqTBkmG5D8V0aCO+kUyHz81F1oDlmo3kyubnno1kvx2g?=
 =?us-ascii?Q?+5ps8ug/OVI8zGLL5xDk8/SzUt8t4nUVIZXxpUuzxmJbXXxL3GM4lDIF83KR?=
 =?us-ascii?Q?b3LiFQAGRwkgAARw7v0lM1rAdO7izH51oO3PpPXV0Hg1MtYJ19iPpZKSEEkn?=
 =?us-ascii?Q?0VDJQcXbaSPMoOYJ8f+w6H/KvZy9t/vqnj/o383ixpGa5Q/QmAPIwcBt06p/?=
 =?us-ascii?Q?AtTYP3vM5+DRa+1o6AJDRufeLKUcQWRNqMvh+YbusY5pVc21XX5nxJshFxiw?=
 =?us-ascii?Q?UFv6rEAIatbTTvf614pUsTCnDn0HVpGlXMaZSZTZDZ2ciUMXOqLbpqnxVHIR?=
 =?us-ascii?Q?s8z8NMAP+Oaq8KOi25ujhJbCfJ7MFTYGffrJtOEKOMN7+IFRj23g3xtE79GU?=
 =?us-ascii?Q?1/IUeukZz613wg94Re4K0sY4Gahhf1i1FnG+EnXdDvibYhzoa53Vesuyj9wz?=
 =?us-ascii?Q?axouqcYrTCyiDnRt1396Oj7Qzr255oWeA6xSu3JuxpyoWvi3zEyqS4IN+6xR?=
 =?us-ascii?Q?KwaNIdfsis7+PjTrusMw5Podu7b4g7lvpPsWRlagmqvMmFdpu46SY1NI0tmM?=
 =?us-ascii?Q?xnlwfy9ZB0nOpNvnr7uhuJfm6iRqMBB+kvKc2xJHAY47k6YqXRQtl5C7Od+J?=
 =?us-ascii?Q?h3N+lNc0Ql/9G0WjmWpeiI3PRuytoNXYh95qzouwzt/pgBwEa1RQVOvPiP0w?=
 =?us-ascii?Q?rYr61AhTTit2txus6xnMo74EgeG6T+5txQKs4UokQQYA5yx/AHlwgtkNTrYa?=
 =?us-ascii?Q?A4YQnybW/j+UsWBIpKb56Fn0Id/i2RIYmAGwgCGy9vwDV2Rd4C+JPfWnqSxN?=
 =?us-ascii?Q?xhdJQmNmE+GwoVJLM4P3x7YLQnethc9eeAYJLh6evUW8Prrvf4Y8kPscMi2B?=
 =?us-ascii?Q?H2HcOegHMbW+DIUztLdSKh5leXiLhbiBTCv/2ooJDs/E46H9camUKr8PEnmv?=
 =?us-ascii?Q?583HVEGy2SbN038ExV2ojlQiy2FXqKXQr7Tz/GljvT8G5lkgWgKS74s1LMw7?=
 =?us-ascii?Q?eR2p8IFgezk+a/5BnimL/WFgNk00ix5mbO0VaXu0MsS4DJyfTR4TPfzePhrW?=
 =?us-ascii?Q?bv7U6R5+S85fd+sPb2CH6VNrHemwpQelx4Xmj1cg5/3opPPV5rUxbvfgcjji?=
 =?us-ascii?Q?rvf1StaduDdNf5RIWEz7o84h2kWyRH1Gp8Zq+ikMFpEGkQQXI132tL07kwOw?=
 =?us-ascii?Q?rDOWPTgjz5YxW9qQwCOdjVDlYxRB6zfOGkD0xbTQRJHgv+WiospTia5a34dX?=
 =?us-ascii?Q?qd1FSzJNXYJp7d8Y59ZyoopKI4fycqeXGD5p4m8UcDNX/2359fr9YCiou7T0?=
 =?us-ascii?Q?R/+tabUys+IN9rAgMYqGi07H8h5BIm3awkkqFJF0U0oaIfvTOp4j9GbSoMXz?=
 =?us-ascii?Q?kEBglJxU/m9JnGN1tDWw0O2cQ59Stv8UuPZTPzvQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g1SVIDPMRahU62TFVnMMH5M64HsZhYq/F4QlmcalM/5+Xpklvj636vvVzVvsGmrTrx0DKE/ThRhniznx/4wnsVqlHT1dpyS5GNgJjOP5xQIoPP91hpK7kycpuVkROV1r4/Dqxp+IqUJ6PV77E4iVVsQjSSOM2rvL67VcO0gNtphJPdr/sbETu7imMj3l9I5fpI9KQxfiVq1onPs3C0DFGqADD0iZBrFy9X3YmjvJqFGdMxGcWeX7A4YbACRLAhmrlnTSl8KI9B9WfkiHLEBru8+lNwaS/wSimL4CgSiFiqCjIiPTGDW/39OJEtQu4647Wb4Yk66+x5Q15Fv8bjvBuX0aoeIX0QXPNSmrHcxCpF4xhesxyWaNKrGHvsGCeHV60ndMtx56t3k+CpW6zxNgaQ3Lkesg8cATyVGDFc/JJvXNT3SXn63t1n4aq0foKGKHPmQxSknxcI1UP7xhXBRCE/zWX4iZg3dB8EWmpyOh54Kn9zf12U9W1e5vxlzXT9gLQ/zECoXpZsvrqAF77+52MQccJCjORIo5yR7Na9v/ASByYfVjC3WrzTZUsqpCSweceDEJGQBEszJNkpf4gOLP5aqobNGbyfLN2U4KJ+HNsEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a683dd-1463-43a8-8091-08dcc08e12a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:32:41.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUvn8ndOFGqnMbrxhoiMGen6o7s4q1cfx5HDGlf3B3UdGYwYHw6+/XAsJV9k7seZuyteL99yeWglZG2JVqwfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190139
X-Proofpoint-GUID: 6JsnEI1UHXPNsQEQDuAI8ZwpCabJVR4C
X-Proofpoint-ORIG-GUID: 6JsnEI1UHXPNsQEQDuAI8ZwpCabJVR4C

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:18]:
> With no more users in the tree, we can finally remove can_modify_mm().
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/internal.h | 14 --------------
>  mm/mseal.c    | 21 ---------------------
>  2 files changed, 35 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 1db320650539..3b738b0ad893 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1361,25 +1361,11 @@ static inline int can_do_mseal(unsigned long flags)
>  	return 0;
>  }
>  
> -bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> -		unsigned long end);
>  #else
>  static inline int can_do_mseal(unsigned long flags)
>  {
>  	return -EPERM;
>  }
> -
> -static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> -		unsigned long end)
> -{
> -	return true;
> -}
> -
> -static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior)
> -{
> -	return true;
> -}
>  #endif
>  
>  #ifdef CONFIG_SHRINKER_DEBUG
> diff --git a/mm/mseal.c b/mm/mseal.c
> index fdd1666344fa..28cd17d7aaf2 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -53,27 +53,6 @@ static bool is_ro_anon(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> -/*
> - * Check if the vmas of a memory range are allowed to be modified.
> - * the memory ranger can have a gap (unallocated memory).
> - * return true, if it is allowed.
> - */
> -bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
> -{
> -	struct vm_area_struct *vma;
> -
> -	VMA_ITERATOR(vmi, mm, start);
> -
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end) {
> -		if (unlikely(!can_modify_vma(vma)))
> -			return false;
> -	}
> -
> -	/* Allow by default. */
> -	return true;
> -}
> -
>  /*
>   * Check if a vma is allowed to be modified by madvise.
>   */
> 
> -- 
> 2.46.0
> 

