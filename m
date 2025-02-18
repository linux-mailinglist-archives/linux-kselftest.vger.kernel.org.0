Return-Path: <linux-kselftest+bounces-26870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB5A3A2B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3575188F8A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7926F459;
	Tue, 18 Feb 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9NHGzaV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yw42EUzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415A26B0A1;
	Tue, 18 Feb 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895741; cv=fail; b=iWCVhueVFW4LFbXwlaKBuCjwFliPTXAFL0JkK/V6W7MgN5zyA+fm4t/bOWEDnNgbzCc4j2t3sy+7CmgnXjc4/B2tGjnG9L88jshgeHN+p1obk32RM11dl5tlu9PUoj2nAi6Y/DwTpINfakWJzmL1B30gXWI5p+ZAUTwrpK3q1HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895741; c=relaxed/simple;
	bh=0tklptpYQD+YipWKi2yXcWibWYnqJNzAOBF9IeP31fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ls817uLj6L7kexSkbpT/nSWwcHPlEeCNYG3D43N4aq8/HCq3Zoa04CgPgI9B/0zmFU84gSlgDleNABtVHRu3ldusRNvGMVUPklLTeWOK3O21Vdla0wgXTX1Eil4wQD7HC0vi0hOOL9TuJMddl0L2PKXEI0PrXMQN+0oI9Lu+Y48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l9NHGzaV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yw42EUzv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGF0oM020178;
	Tue, 18 Feb 2025 16:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eAO7O+YrATVpeB6rn+
	FgtDgj/KTkv92+z+DeOgUl7q0=; b=l9NHGzaVt8gouQkF4RaewXQBOr+vl8RCt1
	pfalRP/VdqhxTUdhHWpbVdtuJXc2oBCEDRIuzbLCqhDUWZV/YLlHHLDLWyVeG+k4
	PmkyAMfc6g0YPS9LYuFERhSUxvuGS4l9kKQjFQXcwBwxgY+tZU11tXKlMENAuLuw
	8Rfogz5ofxk2sPDferOS//I1aKTHhI3cQ0WRgpzUlnehAxRgeiAsXBoBySA/xJ4i
	CTnmOwkeg+1v3yWcafbbDCxvTREc4gdCbaQdNEq1R2wVQxWD7sgbI9L/uEjY7cuH
	afLVHpUkrLZJSOxanns8bBn+gnsGTseJPiyZVoclj9WVnPsoZG7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft6xp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:22:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFCMRQ005248;
	Tue, 18 Feb 2025 16:22:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc908rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6s781empGsfFqidrtawkSb0xFb9VVso7hlwS2YqUPWRsPDmjFHAnsXXrSdUotN2XPRjL5DZbtCSWUj+EzshAaxqsmN8Py7mgrqKOMi4fyQAB85M2OQn7RnNoh5MmuMFW7AzL1pnjWFBGW95D6q8TrH1q8EodVZjytXhmmZ7tzk/WdziBYK1DnIZKl4pnKV1AitDG+cdz4qhFnprW5fzeBSAkpujv5xmNPR5lO9JT4FJa53gbpvg7nJIj4y4zE1oMfUqGa4gb5zqACc2TSspyQNst01FeWTkT9d+GGIINECkv1qcIEMLY7vgyWagx+7cg08wXmrZ6A20na+osWTjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAO7O+YrATVpeB6rn+FgtDgj/KTkv92+z+DeOgUl7q0=;
 b=Iz4WJdoIq9fzqAmDmxZxKBTGZTKx8UXt3v+NNLECRp6wwdyeXyTxG4KYm1DV6bSBpz5E6VJulipRnGDEYcHX+DAZa7YRQuUcBkwzZNL+r//8TJN5H/dSpGTZ8bdiBwZGahNg5Ggya5f/iITyYX/0kMH7sXFBHuemU0QgGZn3t7BdW3vFvrdKj7Tx98evStgH2hiZkAtEBW435gE57wi0Qu+GdSCW/9hVUDlYxAvY/ENGotXLM72MMgehsamizEwrSsobdhUTzbGRgQZImFVe0H10Srt+dvyZIxqyXSsZZxl+3znPV72VEtBE86LV9Q3DF2E9XX2UBlC2XIh6Be5P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAO7O+YrATVpeB6rn+FgtDgj/KTkv92+z+DeOgUl7q0=;
 b=yw42EUzvEa1ID+HOcpl2bl9T5bBr/MC22WYxYzKk+97eqoE5XSva6MeyHcuie0PWB6t0dQavMe+qMH6w87up04omQ7ormn7RGrnmMAQ1ZbfGa4td2a0Il4/gWvSoD9bG0dkQb3Srp9g2c+/kIcbqTOqCxV/Y8cEsZ0hurA5Ygog=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5010.namprd10.prod.outlook.com (2603:10b6:208:30d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 16:21:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:21:58 +0000
Date: Tue, 18 Feb 2025 16:21:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
Message-ID: <d219ab1b-9fb1-45de-aa65-b6071d049dd1@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
 <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
 <4d6d2942-10a1-46e8-93a6-7ce52b6af3ad@lucifer.local>
 <90a00957-02b5-440a-9168-de93c760fea7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a00957-02b5-440a-9168-de93c760fea7@redhat.com>
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce585b1-4b4d-40c8-fbc7-08dd50385e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KLWXWiiBzbLWDepKfI7b/ngYJlXStQIiDO/F54vcE5dLknamK11SJ+uK6/Co?=
 =?us-ascii?Q?g/gmhN8bjPdUA+DzQBM6A49Ek06y32L4RJdnkMbri4co1RwZobYNCwuAGHpO?=
 =?us-ascii?Q?1+JiM7Z3WgtAYkpc6gNYxm67xe7OwlSI7KbG0esUFyVY44IEVEw6//gPiZVL?=
 =?us-ascii?Q?lqk/vzagy8SJeoK9OmIDsx/lHyOJmGzceoH3LzaMwS8z119uUIuMqhIZGisP?=
 =?us-ascii?Q?WOse6S2x5wobr0VSVG27/OOzthuP45kv2+xmrtWQFceJRzScwNkmAELUepvw?=
 =?us-ascii?Q?hNHwyaGk6V4GJ6L7PmivuMLW3cAa2wi45n2ZE6axR0dVEIKXJM0unbDQGmrc?=
 =?us-ascii?Q?sHNRedCBXhXdKs4AFRyzg2+QfUzsPyV8S1v8c1A2v0xQVK7o+BkUM/S/Mfde?=
 =?us-ascii?Q?N/iMgz7EoKpiS/5Q4kE+A+caqCfmgsMdPxxfLXrZx1u9A2DxwScgwgmwHWKm?=
 =?us-ascii?Q?gSzbwAqKZE6lJP6B7YDi3K+tODh4+uG30dPoDXhMjlu142DuEGGdsbrOMwZL?=
 =?us-ascii?Q?q8/InaB+NYaV0scoV8Qxid4gf2beuhElpnchaRNrxwDFq3AdtkSROmZIgcSV?=
 =?us-ascii?Q?Znzq60vjQ/4lPeyQFmRdxfo25M7QwN2atG3VB0/f8fo8iZDiK6PKhIdfV1mm?=
 =?us-ascii?Q?kvLBSrVOlTQeXTitBcBrQHMDTdoXzxt4eXQZnwSwnUkv1uzgwcIXSd7Ow45a?=
 =?us-ascii?Q?1ff7Oo5WS5VEq1iRkDnGXddn2KVi2yn+LYi2qFfuambABB2H3BninbzS+t53?=
 =?us-ascii?Q?5MXWxKryFzEzhAQkAniwhoN9HHXEDsMpVWKj3qcQ8x/b4m979ePd3tCbiWwG?=
 =?us-ascii?Q?7qvh2uFfyHkXsy+tgZdfcySh96yG/bZstsReBcWROUh9QkHYOGTdMozYu+nI?=
 =?us-ascii?Q?F50WrHpiukJFvjA80abPvNX8j6sM9UyAXIdvrCfrRK9J/bEKmDXzWFirHLW2?=
 =?us-ascii?Q?vnSsizWjgUpCAap6F17yG+hLHgSOs9SR+N/qdjO2IH9GUzaSIjXKO7b5CqPU?=
 =?us-ascii?Q?VWGO90ms5hRbkh7PRVoZfYFKA8uDlOL3AizDWw9n6LgVz9300Kgn9Wk8PpmK?=
 =?us-ascii?Q?NTKqedXJ5UR3Dq3RWQ8AQnWumZMwTbxrDUwBkMEYT1d2/VIWwvC+LLuiMEN2?=
 =?us-ascii?Q?H5ncxy+rrw0h6gGhhxkUHLLApUdUGoY2UUS9dDGBl2q0bStX/HybT21YBHE5?=
 =?us-ascii?Q?eklNM2JpNzZzU5Hivabg5hZ/RkgdvBIULLR7Wp8LqnLSkcVGLWc6T7X0m1TU?=
 =?us-ascii?Q?yCd0t8bRdRNAT0rgIbkMFo4HT/k8XdwOF8dI6HEcRcLJtgqXRdRRgxyMI2aX?=
 =?us-ascii?Q?4hRpPAQ+er5YidPEhTIXZDNbk4heqUUfwc8RgthoGOzszVFOx2CIdm2vkLDp?=
 =?us-ascii?Q?2Fh3u4Zv/P02aHB9uxLyoYr0YPeV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5QazvQHA/Gxiw8HKfjh5LFJoJaf69+x4InG7z2IjGFFG0+6IPL9WWM3HyYb?=
 =?us-ascii?Q?f0MId9nh2kM+QNUOtscdNgrg2XFbmeRMNw38dom4Fd9tkAe/0Wz2FNJ1IzZ9?=
 =?us-ascii?Q?JbC29PckW/mCHtIZxS8ZLE5XrZ6AeoOTkJxg4O1Sx7uh+X8uyZs0EwSA0CFS?=
 =?us-ascii?Q?Xx2ZVG9j+/ppW7+wbcWjqjV4L8GRnJu22WQxrhqSNR7y1LZTIkTfeljeXr7T?=
 =?us-ascii?Q?xt21h21iOIckYknbTluY4u3ALv1Ut+AuIdNZfPdbOblzSMISMwckF3emPPPj?=
 =?us-ascii?Q?qbfP/1NHagPHgN6eXh5u5N1eZ7Yldd6PHLlfeYKELugVjvyLRjzpMFGXGwiK?=
 =?us-ascii?Q?aE5X9mnG/WDLccYN1uh3krtfu48C4hvpurwVrpO+HWaHYMeQXfb/Xi4hmblc?=
 =?us-ascii?Q?gWcPr9cOqmSOd68NhpK8eVUYGSw8XGkCFBRFg26Qj58XZxKq4D/Hsk77d4Lj?=
 =?us-ascii?Q?7pqVGJL9VTFCPHVh86kBeJSPByUzUWyj8VCxN8tvWtOtDw/tsz3WozmQVfmx?=
 =?us-ascii?Q?flLfvZZS4QbtASPFO8UuHQTkvw4tDcxRfMoSBcdHC2JJO4HxjhNS5+HdMWc/?=
 =?us-ascii?Q?tq58lWxQYalrFgXhNJ+u/U1cZBcL8lLMEqCU6Ai7P7zV51ln5+MJwKydkm+L?=
 =?us-ascii?Q?K37p+g9qOBxSJ4ZimhdIkQLVZEy3WwxgNVkpytHtudMf518qT+IOgBKvkDd2?=
 =?us-ascii?Q?yokFdmcWxAyc64P/fcVansh3sREcZJ+IDUI6xdSN+lh91IP/0dmUnpnjdjKG?=
 =?us-ascii?Q?e23zaETnIE0cTSreig17khpvlhKn9LsVVPPqqOciMCRdtEQUzAv79LIINGwo?=
 =?us-ascii?Q?9lwibZtkhzhrrmwImiw5dEG/1jFYyO6zKOFU22OCwVez/xHYJuLI6OiLXxgc?=
 =?us-ascii?Q?Q2+MTKd0FkSxqndBatd72PZ1zP+6/JcmwMnXaTArqZ2nVFzzSXJuqLaljF4/?=
 =?us-ascii?Q?0fBUAYBCWZUPS41kxgnopJUouNGcWle41/gaP/zJQmTSTQjFXurh0ojSz9sy?=
 =?us-ascii?Q?Rvx9BYdvKwwSXR2SIio92LPi9kSCgYQGAVK3oCh5xEE7fiqDkxGD65o+J970?=
 =?us-ascii?Q?cRiSPpx+WTkNXAjSJttV/wbUevNIvX5ItEyKplw/pDQ19qQ0nwe7s83ddnTj?=
 =?us-ascii?Q?A/4ALAD65zof+6YPoXs552JpisAodRfTp/tzxYfYXdwgQNhOTb0+lCN7xC9J?=
 =?us-ascii?Q?ILPNYQzDpDGBshGqFRfw9iYIHh4WD88X+yc+3WbzGABJ5m7D4NpVrwcfolpq?=
 =?us-ascii?Q?haoFbBOOqrK3jTGL7HQQFSqbcbINwbvqP2yToQyBWwHf9EC0C7o6oRA2N7F5?=
 =?us-ascii?Q?mnhULr/3Ssd749GplduKkEZxR2CoheO0iraDl/V2RW7FTsvXF4nEqKUH3drn?=
 =?us-ascii?Q?raY6qciBFJg6RxhYFht3XFJQRska0W+OuIb9nkB52w+ZwoZmcxy13YsRFiUb?=
 =?us-ascii?Q?BMmjU0MFBm/96qiWM/is0uh1IRXwwgP+6+u5bVoyscWzi8jkM1jNumUJobUG?=
 =?us-ascii?Q?kGefRmXKAeClCKluKFK+HQ2rSHUUOKJ0Iad3wcfbhjyFlBbkV8T8WTbGlqvG?=
 =?us-ascii?Q?WkhBEBxQkc/LJ6JXBGtEOzJbg4ppW9ut+bqdMkH8358FaG4954ux0fZnd1bJ?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	950CMBBsMOrrIZuHr/vj+X3fMXCalKTnSuPyG7z+yH2CHAJ6QQcelg6q6LGe9drkJ8jMACe4zZAgRmM/6+xgZRnMfEKf41SltLuX5RB/WOSmtZteZPfD6kA+h7CpOYJQEtN/uCWAl3hILd8rUb+exmyAS8kL8iCc2teVMQyQsg/ZmG8vwHoI4hWSxQnxVRWLEHdC4y5QA+E+Ln1vhJ+D3ZChc4cIDs2pjb4kMt4mNsBE7HD0fhYj9x13ek41PutzEjU7K2g0Oyd4sPEHTxs5kTyL/tm+CIrbQX9YzMtnCQm3sZdzAWOvX0AjyMYfI52bah95m8JZ1mc3rH685Zyo8bP6BOVC8KlNcnDdnzywT0GQlz9t2lfCnFb/oQ7EqEZhxFPW+q0mb2gC7fQ/qp2YOXy62jx5VmUpdEYarLQkbm5lXBZ+6W8s4PonfJshiGnX9M776pGDMD3y6uFocYjUPIvwFEQd/X3gQhggfNQT8ML92KcRwA1n274pP7xGf9ImUT5BTbs7KZn9hA2c/lWwKqRLH028xngTOSS1Peso2WNttKVD3vEMxqUgy5gYk3jhXb06gX4jPxMzIOYdJWCUHu8bQsl3MNkL8n+JxbfP3CY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce585b1-4b4d-40c8-fbc7-08dd50385e60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:21:58.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxw41K87cD/1pfLMg/pwoyLIdgzkm1SJ6ofl+G/cfscaju8aQsSv8QhmtyKdY84qEEyNvxuWIlxn8NRdFbwWJSdNdyE0hqENXFJWn/w3+EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180118
X-Proofpoint-ORIG-GUID: O9JJTZ6JGsWIW4-FikwxPlHakFNTu5aD
X-Proofpoint-GUID: O9JJTZ6JGsWIW4-FikwxPlHakFNTu5aD

On Tue, Feb 18, 2025 at 05:17:20PM +0100, David Hildenbrand wrote:
> On 18.02.25 17:12, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 05:01:16PM +0100, David Hildenbrand wrote:
> > > On 13.02.25 19:17, Lorenzo Stoakes wrote:
> > > > There is no reason to disallow guard regions in file-backed mappings -
> > > > readahead and fault-around both function correctly in the presence of PTE
> > > > markers, equally other operations relating to memory-mapped files function
> > > > correctly.
> > > >
> > > > Additionally, read-only mappings if introducing guard-regions, only
> > > > restrict the mapping further, which means there is no violation of any
> > > > access rights by permitting this to be so.
> > > >
> > > > Removing this restriction allows for read-only mapped files (such as
> > > > executable files) correctly which would otherwise not be permitted.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    mm/madvise.c | 8 +-------
> > > >    1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 6ecead476a80..e01e93e179a8 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
> > > >    	if (!allow_locked)
> > > >    		disallowed |= VM_LOCKED;
> > > > -	if (!vma_is_anonymous(vma))
> > > > -		return false;
> > > > -
> > > > -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> > > > -		return false;
> > > > -
> > > > -	return true;
> > > > +	return !(vma->vm_flags & disallowed);
> > > >    }
> > > >    static bool is_guard_pte_marker(pte_t ptent)
> > >
> > > Acked-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks!
> >
> > >
> > > I assume these markers cannot completely prevent us from allocating
> > > pages/folios for these underlying file/pageache ranges of these markers in
> > > case of shmem during page faults, right?
> >
> > If the markers are in place, then page faulting will result in a
> > segfault. If we faulted in a shmem page then installed markers (which would
> > zap the range), then the page cache will be populated, but obviously
> > subject to standard reclaim.
>
> Well, yes, (a) if there is swap and (b), if the noswap option was not
> specified for tmpfs.
>

Right, yeah if you don't have it set up such that dropping a reference to the
folio doesn't drop the page altogether.

I think this matches expectation though in that you'd get the same results from
an MADV_DONTNEED followed by faulting the page again.

> Okay, so installing a guard entry might require punshing a hole to get rid
> of any already-existing memory. But readahead (below) might mess it up.

Only if you are so concerned about avoiding the page cache being populated there
that you want to do this :)

Readahead I think will not readahead into a holepunched region as the hole
punching extends to the fs layer _I believe_ I have not checked the code for
this, but I believe it actually changes the underlying file too right to say
'this part of the file is empty'?

(I did explicitly test hole punching with guard regions btw, by the by :)

>
> >
> > If we perform synchronous readahead prior to a guard region that includes
> > (partially or fully) a guard region we might major fault entries into the
> > page cache that are then not accessable _from that mapping_, this is rather
> > unavoidable as this doesn't account for page table mappings and should be
> > largely trivial overhead (also these folios are reclaimable).
>
> Right, that's what I had in mind: assume I have a single marker in a PMD,
> shmem might allocate a PMD THP to back that region, ignoring the marker
> hint. (so I think)
>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>
>

