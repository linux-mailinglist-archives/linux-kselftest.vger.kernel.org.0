Return-Path: <linux-kselftest+bounces-27058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798EA3D576
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5DB7A4E27
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85031EE7C4;
	Thu, 20 Feb 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hk15EKrF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JEp0M8AP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4C1E9912;
	Thu, 20 Feb 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045224; cv=fail; b=lz5FYRX91kUpv6OBfvRqLs5AUw/d8D0EtdvoGcRmzNsVi0Jk6x7G18YdrBR6jIgGJHlatP5KLGUgeKZ3Ux8Lmt1U9ADqxO8N3RphF7mdZ8cahi0SaziyGYLkVHZeuH4kqgCVjL4fWeU3btiUzpiZ6xrFQRzA5sJnnG9RV1RLt3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045224; c=relaxed/simple;
	bh=l+15/4AiIQHrID8c3I/BdxnuEAh886D5xe6+C3rIZ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mzQAxV33ZABs4Q9Z9nlkSMiSUb70KHSLjP74zpeAUDZBqySEY6PRQDuiXyAL/6UJmYju/mw2dhDxvgZiZELGRxRhIakjmM0rzwRjz8vpeBGEyYg1Z46mrPM9Hx28jb6EAvk89M68ewM2g99DAQqSs5j3X0Y2+83Vb5ZG4IoqD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hk15EKrF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JEp0M8AP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fcfb032022;
	Thu, 20 Feb 2025 09:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=l+15/4AiIQHrID8c3I
	/BdxnuEAh886D5xe6+C3rIZ6o=; b=Hk15EKrFeDiLRykxOMG0o9nO/t6t2qH4Eu
	ZrQ+pyEriclxYV24GX+cdleOmLW9JpGBCYGVtl6sKk38LqSQd+1dCDXVCFs2cwaJ
	wGjeXxcBh/LBcTtRSkl1YBoJGgkagzzX74n5wpVCsYNc8sFVgpvwBJih1q/jH6dL
	pGxjbjYgZZiBA0AvyFvuf1ZrkcWlqjV7IQrBDyec1zYzXS0pImCQLnMB01Y6Bh2f
	ctiy180coq/3NZaan0zMW8RlIm1xa0Rou59J1IBT6ftcD51PBYDIAacGuZJ0znht
	FuaP9ERYdJ8OKng0zUbvRMvhNTHi7Wut4yUXT7qqlzFuPNi3ZUwg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kktea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:53:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K8EqPL025255;
	Thu, 20 Feb 2025 09:53:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08xp5f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvEh0jnCS271muIrv4fJMuHppuecdMD+FWnxZmEuPnXzGagBuxpkrYC6dT83OQlS/Dv8IVX3zzoy+A6RHmZ08hcMXroRRSU7bKumWHLtAJ0cQuJq6NzbqQL041BJ4TrrA7bSoWPTiIGf9ciNY0EXk3LyFLRk+Yo7+Q+gXkX0pc28M3b/WLAzltbN5i8d+bWUEpc3Jm8YtG1CWvGFCZzAbY6HsA87fc2s3ygfJDW6BPiiKhnYXhOGw0hOyXTXDi09fF5VVGQoyLCRJESMSUmhdMpj7WWiZXzx836zUdu0JBq47IKvNlRyvmqh8UqM3BKxQ9ioq4KAuGKtWfEVQED0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+15/4AiIQHrID8c3I/BdxnuEAh886D5xe6+C3rIZ6o=;
 b=JJ+KKvwKHcRf5e07APXweekwo92bdBV/F+bFAsYsSZkjjpcWSSqSBUDH4DSTm06fKr+TsULdcAyliw+s3R/cofPUYYJFwNWd4KGokycmnkZ7JtaMCw4De4PTMMeeVE5zfZjRhDRcSSnazKSJLKW4GTJ5LS+nGh0qf5PW4FgQdRUj859CxfNrkjtyDY6ccXLtFDOI9Hktppe89AHSY7TpoBNSDH9pa9gCis/pe4/bpXI9QrWSC2IQyyQtmQGv/rSqi/m+GWpdNfwJ/hnRyMSHvS3U2dHOxKafhs80fYmUlM8q4qH9nCp5b7WMlBI44x2eada/xZsadd2vcybvzP8Pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+15/4AiIQHrID8c3I/BdxnuEAh886D5xe6+C3rIZ6o=;
 b=JEp0M8APL975V1TMSNlVn/ezc98vf1FaC8o5jy+ZRwwwwv4j2qNc2LOk2OMzgho9DhD5yQOss5KMC9BctRjtTKrBFgqx9OM41OlhQ6A2tBKyg2N9JZu0wgiyP+Fmj6KIr8YHCCUSLX78vzinMoXvj4WYprEZK4KOAg3ZAgEt7pE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 09:53:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:53:07 +0000
Date: Thu, 20 Feb 2025 09:53:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kalesh Singh <kaleshsingh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <7eacc1ca-f890-4ae4-9965-ee1a5832a59c@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <5fe78422-f348-414c-9ff2-78812ba9a949@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe78422-f348-414c-9ff2-78812ba9a949@suse.cz>
X-ClientProxiedBy: LO6P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 4166bbcc-b31b-46df-0f30-08dd51946055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hVeewtntjgwLUZebDCWu1CEQmRkMYoGx5rYJtraQ8Z2uyEAUbjlY0ykdps7m?=
 =?us-ascii?Q?py0SKE+U4vBc9bJi06OlCw4LqyynZdY1JlV5V6N7uEo2DlrDGo7vtj1vviS9?=
 =?us-ascii?Q?UNyPyQUy5UPfBEU0D5PLQOTlI0kqCZOI00VsuUFZJPLzpyJt0DgdGij01jaV?=
 =?us-ascii?Q?PwzS47U3f1ORXMEY1IS/fzkoCjuyYWdZW2dr9s3auPXy5pQbI50hiteFESa3?=
 =?us-ascii?Q?4qzrVbcHL8PUQ5ZEPpmhxzchYVQZeXIcRFvLlqPvw1+CUsmuYx5E0If9+Akl?=
 =?us-ascii?Q?fT9Z2jpQl6CYq+g7k1YjsMjYOEpWgne9D9Z1ZvB3euFT+2bdm9GfmzAr42bw?=
 =?us-ascii?Q?SYWJRdDceBnf1pIkENaC8I5PG8sBO/0UiLfO8rr2BoXwvZ6YKAXiGxi4LhJf?=
 =?us-ascii?Q?+O3z0z+XtZcf2PoJhyQilxZUFUDZYJFXXuSXFlUbNxzArsdTaCGAvjdke5ks?=
 =?us-ascii?Q?zmplNtleEMdHxrM9Od0Uknmp8OfjfaWd5RSXoMOzvaTgnm4PzdzET15whm5x?=
 =?us-ascii?Q?jI1d9XEnK36ktrYiQT39kRMDugw2jHZjaDKF8EA+04VS9YQcP3UC8v2/DpEQ?=
 =?us-ascii?Q?+PF01zA2p5PYbIW1rfEWQRJE46zxKfYfRvsCOfVZvY6JwTamwTTn4YY2q3SL?=
 =?us-ascii?Q?Sm6iKHhwwxspgyCftjA6q8GfYSfLLZI+9qUH9lvaE2bYgKM8u8LDG8Y+JpEm?=
 =?us-ascii?Q?OknYTiJfkd1xeuefUGPbBi071UZfUpYpKhZCnOiL6FypLvmzrtlBqkR1P6le?=
 =?us-ascii?Q?2k4PBW/h0lyBEBSSF+ebk8+r7p4gRCsXjPV0m9KWdp/vST+6jbydDupUJN1T?=
 =?us-ascii?Q?1kZ663StCo4XwV9kAANwn5Re18l+eI41QIuKE+DsuOH9QHRBVcqsn/T1xyDv?=
 =?us-ascii?Q?KgO6Pc82vaKlqPhCeZYu5dHNYW0LvdOjcT+5XWEaRVkl4s4IDJe1P5MTPGiz?=
 =?us-ascii?Q?7s2exICvPdZHYJAxjTjNQXo1cfskDfbIM5hOxEoGtVVrAuHK6e8XgRiVft9h?=
 =?us-ascii?Q?AFNxxHiG+8x3EyauPR0pthFPOU1BoTDDzcdT0e2klFYNe+e5cKdBkFda0dK9?=
 =?us-ascii?Q?JBLjCtXGfQ6vUEcW9frMZ14eMP6BTfX8177lrzf+0ZkulKjl5/wjVjrbntM4?=
 =?us-ascii?Q?+sEf+lCqkmSg/DhVNTSl/vsYq4vc7qXuB9693Gp50kHZwTtDfX9IlZ2oexef?=
 =?us-ascii?Q?a/nMTEyiFsk/kbCcXyBMGjTeI5zOIffigmnGvLAQ0BaDdlUNLoGf3VgIvqpA?=
 =?us-ascii?Q?gxc/nmrPmB7C//ptI9Gaf2kTG7G6yAiQtAK5MhoTBCFYonzvGZw1n1nSy0Gh?=
 =?us-ascii?Q?ql8PLZlCRhVX33Q3vh5/7knHKJ+2xwd/nsaSX5z0Q8QPTm8uhGQYUNLM8Dib?=
 =?us-ascii?Q?GUAFHOt3CK/9oNPTQbbe1yZxkPyP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23dKgWI0ttLYbiVhJfhhACFkUJUzn97YO7nXLRC8IFcdmKEtJD7In6rwH4sd?=
 =?us-ascii?Q?3IKmnV+kUJvlvD1sQt7pTuj2aG9phGlmMgZ1Bl9lsC+Kn2q9sfdrMaChBHvg?=
 =?us-ascii?Q?+kCI7llzn0jJyJyzLyutZkwDqozhtAOhcyGvat6pzEk1DsFo4nd5duuJ4C/E?=
 =?us-ascii?Q?a7J5SUvkC99k+syJOmTGENf4U8hUdgc51cWEfKUkIWKpDgHw6MeQAphKLi0Y?=
 =?us-ascii?Q?9mSb7A3TJbYtZuY+w2bDZZw7gzOnA/FUxrgAn4vK1piN4DmhyrRUo91ZB1hU?=
 =?us-ascii?Q?c7h2NZI33WnS/NtZV7pMltWc5GecaOJsr7nj57qXcqIiayfBk7aa6WPNURNB?=
 =?us-ascii?Q?2y7WgB5o1T3HalYwldqtHsLNDqAtLBr99g9wxfpok+LYa49s5IgPBwoI63Wa?=
 =?us-ascii?Q?sOShvZukMeSGcAhpHvvCmFq+CkM+HeoDDlO//ZQjmgZEx3MbCGXOkEiwapcv?=
 =?us-ascii?Q?bza9WpHKwBPXX1nmpaZrWcBh75xP3XnVaE6871aD5pBJzoH2hoeiyOR3rCsK?=
 =?us-ascii?Q?aFpaeREZoEPbnxwcONaG94VM2XLqCtcmK4FCuhfKf43wsULZaJiN1LXOTYNA?=
 =?us-ascii?Q?li0wPWOD7RYcR0nAQMIcRO8SrgVCQ7d+8QP69BnfC3/AEMIzh/LtWg2pv6Hs?=
 =?us-ascii?Q?7xQhVxMTZ796MUfLNgGwY/Qg1DxYVWBwpSJnWGhbQq6VzXGNrqZ34aS6DDhL?=
 =?us-ascii?Q?Z4XO9lqikLGS9R5u4GhP6uA4diAWshRlDYkj8L8/ZEGQLLVRH9UkmRzZsRjc?=
 =?us-ascii?Q?NaytXqLr8MfFUNoXWt86U2BVNdvk229ihpaRNTV7dppmJoSg5WPbpJIPd6iL?=
 =?us-ascii?Q?+reMi8WH/lYcAAhb6YqgAMGwiYxWtJXUZfhqddFhet6UVzx3JNL9i/cv/cZr?=
 =?us-ascii?Q?7EedSGd/kkFwzME3RtU8nsiJd6vHBd7g4x+OWFOsgMo2E2pO7Z72SSXW4DY1?=
 =?us-ascii?Q?Q5JSTSvjXK4f9Jw5NUISwBnSkfYo3zR8vsQpx258RK6DYt6V+KRSbRQ7Q5zp?=
 =?us-ascii?Q?uFbzfbqDk/zs2NxFwfKQ0W+IhSt2RaXcw+7gHlBH1441apQwtct/0CqIFUXJ?=
 =?us-ascii?Q?VEQKgdtESb3uQIxyAG2pAIDG7Pu6sTb5VMryGDVemf0SduoDdY/ikP+xOchr?=
 =?us-ascii?Q?zcmT29nkW3tzbqy6K672iCDGD/ZrttKtPyvUK/HFHv1a1Sl6BQ/9OPXoxBpt?=
 =?us-ascii?Q?ej+hrfxVEsgPC1cryQedNTSIT3qFssze5ebw7xdUnn1eRCwpsTzWWZI6j83u?=
 =?us-ascii?Q?gs7JBbu353MvDFqru/IcGLv7tcO9iFkrZvexiVoyIkkB6jkxehULWoU3uIvK?=
 =?us-ascii?Q?8pie27usuQ0tu7gIHMAGdOqMpX3VbAaHHHAghfa83Dc4jYm7gHH1/oGXsUaK?=
 =?us-ascii?Q?vhNNkzVNFQHaQkQjZUNDXjIlZC+yewhrLsUpzf9ew0YffLYmZxOSW2H9YWVJ?=
 =?us-ascii?Q?vL0LASQCq9BEFNmysPantBTycTApNNHG1T7XucPDKQOv8dAsMTqclPGMbFqV?=
 =?us-ascii?Q?t7xKIPJBgHshWtP/swMRd4AFZ9EXyb3UOKaDQUac3uw3PD19hu2wy6V1u3es?=
 =?us-ascii?Q?D+eMHWBnIUasVAY3MVbD6HJ6dmAir+8MhMMen1D6Obt4gvgNREHon+qG8HCN?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kq5xz5u8tJ2jR8tso2atlPb1ZnfoSk8dGoUwe3TUhiWP0E5+mk0yXEYB7LjLAjo2L75tSg2cZ4huOeQJD40Bs8VhC7Zn1cjKoZ1r7oauzm8wUYlB3u4lMC2Ba18e3ktnZeRwD4ZB+S2K70hP4CGxPqtNwoIVCk1yRGeArfn7dPkPRaHwXMeZVm9W7goJ45z3WuHr4juKPClzvt+/DHkVvxsnVM9xFeC6Pjny463LMW1QNLVRTo6gLE3lP4/hlV4TgLZlRB33l4f0GXogltHTDTBaOApoEi7U9lM/1eNWpevdiTLXzm/l5J9Kt/+rPKq3G0hTU/xAC8AHP1aVVoKYcb/kvOUMT5/ceGwEMIJEfgUPsR9dCDuunXElacieYmezIQFu5D2eTzuDSs+rLvmLuICjNVzgkTK1+lVmbjNFvxCi/mg8jkXbGq0ktcGFrZvgrHbq8rBrdf9KkNHvdwbZywhIkk7PY+nI1A7hPavXwyn+wt6jmPYDnY7th/5cc13jp4mkzOCtAxPp3xWBdc80ew4mImeb1rVMGS1GmHapHdwWUvzNU+0WoneIwILslnQBhI/AryDXBdjlkEy5M5Z7tsHbBut5tHcZvQMWEHxKGcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4166bbcc-b31b-46df-0f30-08dd51946055
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:53:07.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30YiqdkUQgPpZygKo36q1P9Uu2s8YpI7jeHg1SaOaQnD9d3NzADx88k+XxpkAmLpN+2P6BgxpZerUcUIxLX0vPoYpeZ2156emQ+9sHmsGTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200073
X-Proofpoint-ORIG-GUID: szy7iu7uTcDi-E-nTDY-if9aHhREOj8r
X-Proofpoint-GUID: szy7iu7uTcDi-E-nTDY-if9aHhREOj8r

On Thu, Feb 20, 2025 at 10:22:29AM +0100, Vlastimil Babka wrote:
> On 2/20/25 09:51, Lorenzo Stoakes wrote:
> > On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
> >
> > As I said to you earlier, the _best_ we could do in smaps would be to add a
> > flag like 'Grd' or something to indicate some part of the VMA is
>
> In smaps we could say how many kB is covered by guard ptes and it would be
> in line with the current output, and the fact it's already scanning page
> tables, so virtually no new overhead. But it wouldn't tell you the address
> ranges, of course.

Yes right. Sorry, I didn't think to suggest this, the fundamental point
being that there is essentially a 'flag' or 'entry' saying 'there are
guard regions here'. And indeed that could include ranges.

But it doesn't tell you the actual address ranges which is what Kalesh
appears to require.

You could equally well find these, and the sizes (albeit less conveniently)
with a combination of /proc/$pid/maps and adding a guard bit to
/proc/$pid/pagemap.

>
> > guarded. But I won't do that unless somebody has an -actual use case- for
> > it.
>
> Right, we need to hear that first. Also I'm a bit confused about what's the
> issue with the existing Android apps and the proposals. Do the existing apps
> expect to see particular PROT_NONE regions, which would be gone (become part
> of the surrounding vma's) when using guards instead? Then clearly there's no
> way to use guards for them without breaking their assumptions.
>
> But assuming future versions of these apps for future android versions would
> have to adapt to guards instead of PROT_NONE, why do we have to promise them
> to represent the guards, if the point is just so they adapt to the new state
> of smaps in their dubious security checking code, and not break anymore?
>
> (but geez, if android apps are to use the android apis, which is java based
> (IIRC?) why were there ever allowed to read /proc in the first place? such a
> mistake, sigh)
>
> > David's /proc/$pid/pagemaps suggestion is excellent, avoids all the
> > pitfalls, exposes guard regions to anybody who really really wants to know
> > and doesn't interfere with anything else, so this is what we'll go with.
> >
> > Regards, Lorenzo
>

