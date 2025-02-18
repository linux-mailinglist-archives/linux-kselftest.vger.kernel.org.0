Return-Path: <linux-kselftest+bounces-26877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5FA3A386
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456B53ACB98
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1326F47A;
	Tue, 18 Feb 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfoidhZt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="clMLC5Yd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD626988D;
	Tue, 18 Feb 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898291; cv=fail; b=aqN6qj+yFue8uXq7QJTeXkywk6iMxWltoZBN3PJ8+PwW/R8k6+ho6K167fAsVFtldNXo4T3P+R+TliHPIy1bqqsgHy5o59Nx64wzOLD6/aBweFapO4zwckGCfHN/GIaMj7T5eGG6muaQRsObeMr1fn+U5KKsiSswYRm1Fafe15s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898291; c=relaxed/simple;
	bh=fnGv+RdOofyiRvBkmkEOHCUG/dXFT5sZL58y3/NgHwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XW9T3GykJglIKwTFTVkjYxCHxJEMokYpDu0tgXtLPGs09527F7FgwEdkPRRhSXVD1WA+CcQom8JmcXsOrBsdUQ61ggfi+LqTbWi1h7WCO1HV9cRWqmeC5BA1ZP6/5Ja9ra392BTQZSep7Pd8EuPTH4/tHrkuPkhCwOqRIed9nuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfoidhZt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=clMLC5Yd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMZZa023808;
	Tue, 18 Feb 2025 17:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NZZImTKUGi7y+2FtIJ
	ueSYq5NhwxV4DcsT3naSh2hLQ=; b=NfoidhZtg3vg9I446/NXU7XzZkWxRCNL5F
	8nfUvI7g+Q+Cv3wbgronJQZn6cLaQtq0e/xW/q8yPoD5OQ2RdkuJIZOCJUVxmh9C
	Ieo/Hq4vDnHI7bVW1w4Z7bOxmNVd0jEjiYsTmw3mQdIAScc0pnrVQlNdqCSWntVi
	EXIADWs4OyCk56mNE85sWVMfhv0UJWddiDFChunvC5N6vNMMEPIPORtRKmfdFs7u
	yQIjlUD8tFc8NX9DDGUYD0EsFjgWPBtsNaapb1sTgRWYtwOt/hx+JwbkNutuhcy5
	jXY6X82naNqIL9Jr3xOfLJwvmbKx38ByADEbDabrEtsEP1Tdsuyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thbcf1f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFghLF036718;
	Tue, 18 Feb 2025 17:04:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc99ysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb26uCZC4988hl6ulo4r1CHF1BAP4d/TLmoO8CnqDka+TE/dDI1eP7naju8zQnRA1GCDS3Jci0VYxK8AfWr5nT1eE1ghO2ki2bLaqkJS0cYV40Kq8V2acLb5/oQoDLoF5Z9VezoR0msBUPnjnqhBNTI0rdMJXeMIbpLlarJ6OL3mZ8CA7257WZDJG9Se6lSRITYzOmPn5qGDHJhMh7WW5J6e3KZZdDwiJTiKRUtVMyLE/DF9UQwzW+2ww0rYE8AJjWb8v4WclVQ1XizM6TnBwwf87TefYvKVYRJN9ztf/4u1l5luivAo63YaTs5JMreZZL8rHvdIolRXGQpMTBzynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZZImTKUGi7y+2FtIJueSYq5NhwxV4DcsT3naSh2hLQ=;
 b=kHHBMLULktlzWkgRLILNL+qIKVnGpUeuFEJt8GghFDBnBP9KvB48cTDm9rTSjSF5xpsgX747gAHwLtyISK4+PWUAenWHKGzoEcnA/5d8ZQB72UVGMX64IeWKdkWgM8CAQvZZnn8EBHDjKHXtn/sW8xdUMVO99XpAeTnLnuL6LRF5ymbW4cJ8nwG3VZnp1kYNHKIpL3JSDyrhrio4mLmgJxlKek3FlV6hVL7iAgJaXCxh2/vPOBvm/80ZWnYsReeNlMR7HdDKx4E/zNfXMr92YTl5b+a7aSrTznCl025bGeRtqPg/qtuFTK7BTUW4YLyRnNRBOgo7qGgw55DUOgrbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZZImTKUGi7y+2FtIJueSYq5NhwxV4DcsT3naSh2hLQ=;
 b=clMLC5YdA0puiDAzVQsLGv0h75erXo9gLzLhhkcnhBGNX0lwgzAWNUzcrbFnnk/dJjypXKm+wR+uj6bDSu/oCqf3pCRj9FhIaIAhcr+5J/1BtTKh5al0Ekk/VHKPEt3P77Majn0IRM1293cKI/zcCESJCxr/pGOIhggQR2npk1A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.22; Tue, 18 Feb
 2025 17:04:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:04:26 +0000
Date: Tue, 18 Feb 2025 17:04:23 +0000
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
Message-ID: <34b86f75-4fac-4cdc-b13d-82086d8dc078@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
 <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
 <4d6d2942-10a1-46e8-93a6-7ce52b6af3ad@lucifer.local>
 <90a00957-02b5-440a-9168-de93c760fea7@redhat.com>
 <d219ab1b-9fb1-45de-aa65-b6071d049dd1@lucifer.local>
 <de79890e-86b5-4f43-8a25-1e50c3b1daea@redhat.com>
 <195a2b04-2968-4a51-9308-855da9fc12ed@lucifer.local>
 <d3da8c0e-bb9f-4832-afbe-ea862084339e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3da8c0e-bb9f-4832-afbe-ea862084339e@redhat.com>
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: fed57ebf-a99b-45b1-c0f2-08dd503e4cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbKu20KowzWlZ7qCUfCQ5JCNjOKpGxxll1MgRExPuNYpeNmsDbkz6pmVu2V4?=
 =?us-ascii?Q?yqjz97ng0EdFjHVeh0P6c1qY0RQ5K8yGdmyyY6T7bg1g0u6nPLgN5IFu3OdS?=
 =?us-ascii?Q?ka5G/4xWNTQNDUJuRRjtYHrCGg1AqDIt4BNCssvqqVc8SnGXQaV+iRbAjj1m?=
 =?us-ascii?Q?6bTU5aRifdi9Gp5ZeGHsQW9HYLgAofPpIYc4BSn3pvWxURiRr8aNn2BnUYIb?=
 =?us-ascii?Q?uZn7TV8yjBdnHheG78Rbd5gAMeYY9bvlCiyIDd+sSGBaIe7P7MisFgw3Pu1I?=
 =?us-ascii?Q?fR/H0ODZXoEM4RMtMjfbpQxojIpcVOT87zeYIaLc5/1cMxPNOPEX4IfGbfcA?=
 =?us-ascii?Q?1B1deUWipIesw0/alTft3894e4QgJgZmHfxXeNycvAto9k2Swxb60cwn6rhF?=
 =?us-ascii?Q?CC1Bs3/cggfWS9AYLH/amQVl8pFH2eLb3uuM3L3cDbdJjyi+Ffjm9JnrvDcg?=
 =?us-ascii?Q?MzrNrGEtHeKsHjUEww1POBeP2oCc/L1L2Yae5riCyTEFhD0jRj5pAG2DB2JF?=
 =?us-ascii?Q?paKPlg5sP6OXZJZiF3lmdD/uW55it8sEJnJhOsoWC/dbbohBGGAYrmdyspiL?=
 =?us-ascii?Q?fkyb7P7632is2x02C27QdztD0tgV6vRfaWNY+8w4Vlhm6kMWRUJUMjQzCA7I?=
 =?us-ascii?Q?5KEH9K+j5x6/lzQRpv8rbzMdtpLuNsqdi5+G4y8BEqOCdCLYW7kGAjfYudRK?=
 =?us-ascii?Q?+TFL7ScWSF1E1b3c+S/ziGdYq5gsjhhxAT216IRaLNgBtHGAgQUx5oUwiqus?=
 =?us-ascii?Q?Dpf0/a5h7GnphHVIE8etBr+JNL1aeimuzJpfygrkMCprCOxscT+Llk6kTak5?=
 =?us-ascii?Q?gGjI4i81g8GKdwFejr9phIOpp/ZJOS060Jx74pLEa7g9oPB6izijZuQg2KMJ?=
 =?us-ascii?Q?9QDlYVjoMyQKueF0ystiP9gE625UgshK29FGeZUbJIMQyBQvC6ngKxyer12P?=
 =?us-ascii?Q?k7ND1wmBWiswqT0MjHBORQNUCMm9Rt3G4NsRVuhyBBF2OgFNi9dO+wSDNT78?=
 =?us-ascii?Q?AVzD41q8azLKrcTh/D/DR2yhv1W9v2k57sB90XlUDx6nfyr9w7WqQTW3wu7J?=
 =?us-ascii?Q?BdfiAS2WZ6Af6UQX7jyjm+ULc+VkEFwyE+l81ThRzydy9z7M8m0n5Vn5RVqX?=
 =?us-ascii?Q?/Pd4P+6nJI5QsGxtvct5nwIYDGjCR2+4AX+Ut2MmWNFvmuI30gHs6Yf7hEkD?=
 =?us-ascii?Q?QD2AW/vT3iDWasXEqzdnW6QGFSHJar/vhz9faCcDK5FLNfwgaIlspQ3a0f4A?=
 =?us-ascii?Q?gBmS6Oq8hfKAn4+C6kh86h5OPEEh48pScHOsSwZddZL/xstJiSH/c6Fvw65k?=
 =?us-ascii?Q?CtqSzM33cytSTPHB/coS2vyoeMR6BF/9H3fIY38RzciPA5BUFRXAMOWSQNFO?=
 =?us-ascii?Q?yPEXCugzVBvnVPeqU3C9h1UTFT6M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsoZAVq2IDZJyL3NjmtBvVRRMJ/JVhwS9YqrHEEL5PPrmuwc3SWkDqtsGR6D?=
 =?us-ascii?Q?3rhxUN6iJ7zL9z9v0UF+ckrxkO+QBQ8k+CHGdjkKmsHHPDFt8QnyVJbrBcLr?=
 =?us-ascii?Q?8bqsTUQ6JMtXw4Hr92qditz0tailHFctlDgJljJV2auLHmlLHdZcmK8R58NJ?=
 =?us-ascii?Q?VluMvNgamipkX+LMtvyUzhZz1y3e190/7T8D9Wel8qiF8yWk2m28RtQ1PwwZ?=
 =?us-ascii?Q?J1WxfeyIw48HJhcANq9/HN6YYnv1eCUdGlmGw66U0OuxaIWHKzroyIihqrJS?=
 =?us-ascii?Q?1JGqZy0PpMHVASybezIOakuI1xhH739+VggBrzkkdXshRp++p/4zdiwXjIH5?=
 =?us-ascii?Q?c/TObN5dvQmiuuWYOaJ6JUnJLJnXroy1Hg/4owRx4dDyfgEsibyAWFZQu6by?=
 =?us-ascii?Q?tMpbHa4cc+Pph87H0qkQPit3PtnOFgQokEpDxcZLzuMu+KclHNpFyGgiXqLX?=
 =?us-ascii?Q?Oqa7ryyLixljmu4PESBofOmjKJ9l5laEyWkcug6BZSo21L5cf/ydL2LmZKlc?=
 =?us-ascii?Q?Fqse/AzLv1VmFbtQpndYq/5szXRHNB3+SA/O4FXS+gpeoORK5X7BPRZnaO2t?=
 =?us-ascii?Q?U/jm0FqYjYpgZouaxqsfC+/SpLiRlGPRpPvCQYaG1PmIMbk+9hB1d0iRtdcb?=
 =?us-ascii?Q?VJSscVw9yavW8sYi+tjI7C9gypsNFPMtmQ9yDnUzI3BrvScJR84jP9/05jf7?=
 =?us-ascii?Q?nf7p7/M8TxUrv1ln0X+CWWhQ7eP9VqUze0Byn0djygmBF5ovsW0VlJcDMkMg?=
 =?us-ascii?Q?wFwjMYDZBDlgakXBOflVNLCyUHX8tddkUGazT6IZXU/eKge8MmL/etsOOwSj?=
 =?us-ascii?Q?Zw3eQWiTTK8d1qlN9xaNnsefMqu4oY3WuK55mBWXd9huxEtmilXlWT14CZiH?=
 =?us-ascii?Q?aOVjFkKQPZ8KqZ41gnT74xGPMSKyiIlLFVbZldrJAC2fF3xIU84wTLFapdBq?=
 =?us-ascii?Q?joZa5/3APg8ocVi1E6vS7Hd9BFUhemqT+yDrrcW70SKr8fFoLZYNqBf6lsLN?=
 =?us-ascii?Q?EEQzyx2gv9EN5w1ha/wB3t7vrBgCAC1JH1DHBwoRQFO2Aem/V8jVUqwJY+G9?=
 =?us-ascii?Q?xyctc3aubN257vZKBVX7yPmQFNw14iW/JilFDfWXHJI1VmqALGDMufg8EE1V?=
 =?us-ascii?Q?VuODfQNs/116aFRyN8kPSeG3/pClnhRhoBjdItjCZ5fMuppvXqe6is71PiLT?=
 =?us-ascii?Q?CsuNzJ3hnT3dwgBryVgTmgY5mjBHpDNXOmc0Ts35RpvlTXGNiKlRKuEapV8B?=
 =?us-ascii?Q?rE1zFgRezQY0/9ZY8TU1Ya8QYzM9reYm8myDDdU1J1pe5j94G2B2l72GMI76?=
 =?us-ascii?Q?W5+g2FpTQ92T/C9x+/YlwWSjWLw812kxzCNnnJk86ZwGRTqpd6hn8zBPkYS7?=
 =?us-ascii?Q?pqZCp0EamXE8BFJsJ2j2rQsbtfG6HaLF5KMsGjxzkXAWl+3JV0A/8cuJaTQw?=
 =?us-ascii?Q?YxHlcJvjPLLp+XFqtV+7feKxUhx3TbYlsM09H/iRzOi7ON9GVaFAUQ/vPycA?=
 =?us-ascii?Q?rY9nBwdfI7aBLbXpDXIFFWyNcXn4sA0teyAH9U9uLrq8U6/3yPHYYzqOlNpo?=
 =?us-ascii?Q?L8bwhm2FbiPjaYQrhaL9unT+cYfirTdqglw5qesJodY9O/SiuLMSh59XgDJT?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3CdlkorOGu1gj0guYWirexKpxWBdZKmkHFJnQlKjueYYouvcl93aI5jVQsME8w8boCUjKeqdaRRaEVmiT8EvCq/6FocBzi0ox/eTmlFbrSKZ1yUCHPafs51BTB4NfuBczcLkV3j0KQenM3d9fYH1uj21hTara95PXY5uVXbvB33x+w/rFza2XeFUQviR/Xtzb/TgvCIcn2hjS3GYqxQ/qNoQ3m4Z2LECosZQh2VJIq8QXnhbegX6uzAhE5ihs1AZ+JCstgI87vK4wzIyBseHZ9f4Vd6b9lWWKk7dJgOsMIiJWyQPusOiIvY7BlSYZ+nMpkU7SkT/+p8IBqpsK3zcN639qnwCndzh3l8jx8WSzuYeaGMAwHp4Cl6nRs2e4/Cst5bsufrzb3QoQUUmqTnuvNhPlWOMqzc53KxLPDExmiitT/56seTXArORsAoXpmaXAxg+dsFrx3IkBQIqCXeR5Kfim1NzmbBcPiwErKKBUUZQn3CWP2aeMYn+nSfnq9zGi4oWtI6iebLgJE/MYt/6d72Ko8Q1uJDkEqbAU6YA5i2N+f57M96iaUGZsYMO4mtv7+DJKCs8K3gMLkLkm8MI7qyM2xcY6ar+P/tXXc9cwnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed57ebf-a99b-45b1-c0f2-08dd503e4cd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:04:26.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z4pv6h4w+YD5mILogEpJ44qeE81o8LBwr4KNfQO2Oh/55PyPqotdwDhGa6tfWdwGEJKGUU+ECBBnWbrPqMQMaTRRBwR0MckYybfzlR+CK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180121
X-Proofpoint-GUID: hHpna82JSpPWxJbmZky4hGycOqsMOre4
X-Proofpoint-ORIG-GUID: hHpna82JSpPWxJbmZky4hGycOqsMOre4

On Tue, Feb 18, 2025 at 06:00:36PM +0100, David Hildenbrand wrote:
> On 18.02.25 17:49, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 05:27:24PM +0100, David Hildenbrand wrote:
> > > On 18.02.25 17:21, Lorenzo Stoakes wrote:
> > > > On Tue, Feb 18, 2025 at 05:17:20PM +0100, David Hildenbrand wrote:
> > > > > On 18.02.25 17:12, Lorenzo Stoakes wrote:
> > > > > > On Tue, Feb 18, 2025 at 05:01:16PM +0100, David Hildenbrand wrote:
> > > > > > > On 13.02.25 19:17, Lorenzo Stoakes wrote:
> > > > > > > > There is no reason to disallow guard regions in file-backed mappings -
> > > > > > > > readahead and fault-around both function correctly in the presence of PTE
> > > > > > > > markers, equally other operations relating to memory-mapped files function
> > > > > > > > correctly.
> > > > > > > >
> > > > > > > > Additionally, read-only mappings if introducing guard-regions, only
> > > > > > > > restrict the mapping further, which means there is no violation of any
> > > > > > > > access rights by permitting this to be so.
> > > > > > > >
> > > > > > > > Removing this restriction allows for read-only mapped files (such as
> > > > > > > > executable files) correctly which would otherwise not be permitted.
> > > > > > > >
> > > > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > > > ---
> > > > > > > >      mm/madvise.c | 8 +-------
> > > > > > > >      1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > > > > > index 6ecead476a80..e01e93e179a8 100644
> > > > > > > > --- a/mm/madvise.c
> > > > > > > > +++ b/mm/madvise.c
> > > > > > > > @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
> > > > > > > >      	if (!allow_locked)
> > > > > > > >      		disallowed |= VM_LOCKED;
> > > > > > > > -	if (!vma_is_anonymous(vma))
> > > > > > > > -		return false;
> > > > > > > > -
> > > > > > > > -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> > > > > > > > -		return false;
> > > > > > > > -
> > > > > > > > -	return true;
> > > > > > > > +	return !(vma->vm_flags & disallowed);
> > > > > > > >      }
> > > > > > > >      static bool is_guard_pte_marker(pte_t ptent)
> > > > > > >
> > > > > > > Acked-by: David Hildenbrand <david@redhat.com>
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > >
> > > > > > > I assume these markers cannot completely prevent us from allocating
> > > > > > > pages/folios for these underlying file/pageache ranges of these markers in
> > > > > > > case of shmem during page faults, right?
> > > > > >
> > > > > > If the markers are in place, then page faulting will result in a
> > > > > > segfault. If we faulted in a shmem page then installed markers (which would
> > > > > > zap the range), then the page cache will be populated, but obviously
> > > > > > subject to standard reclaim.
> > > > >
> > > > > Well, yes, (a) if there is swap and (b), if the noswap option was not
> > > > > specified for tmpfs.
> > > > >
> > > >
> > > > Right, yeah if you don't have it set up such that dropping a reference to the
> > > > folio doesn't drop the page altogether.
> > > >
> > > > I think this matches expectation though in that you'd get the same results from
> > > > an MADV_DONTNEED followed by faulting the page again.
> > >
> > > It might make sense to document that: installing a guard behaves just like
> > > MADV_DONTNEED; in case of a file, that means that the pagecache is left
> > > untouched.
> >
> > More docs noooo! :P I will update the man pages when this is more obviously
> > heading for landing in 6.15 accordingly.
> >
> > Current man page documentation on this is:
> >
> > 'If the region maps memory pages those mappings will be replaced as part of
> > the operation'
> >
> > I think something like:
> >
> > 'If the region maps pages those mappings will be replaced as part of the
> > operation. When guard regions are removed via MADV_GUARD_REMOVE, faulting
> > in the page will behave as if that region had MADV_DONTNEED applied to it,
> > that is anonymous ranges will be backed by newly allocated zeroed pages and
> > file-backed ranges will be backed by the underlying file pages.'
> >
> > Probably something less wordy than this...
>
> Yeah, but sounds good to me.
>
> >
> > >
> > > >
> > > > > Okay, so installing a guard entry might require punshing a hole to get rid
> > > > > of any already-existing memory. But readahead (below) might mess it up.
> > > >
> > > > Only if you are so concerned about avoiding the page cache being populated there
> > > > that you want to do this :)
> > > >
> > > > Readahead I think will not readahead into a holepunched region as the hole
> > > > punching extends to the fs layer _I believe_ I have not checked the code for
> > > > this, but I believe it actually changes the underlying file too right to say
> > > > 'this part of the file is empty'?
> > >
> > > Well, we are talking about shmem here ... not your ordinary fs backed by an
> > > actual file :)
> >
> > I am talking about both, I multitask ;)
>
> For !shmem, we should indeed not be messing with a sparse file structure.

Ah right I get you, sorry missed your point here. Yeah MADV_REMOVE for shmem
will just explicitly drop the pages which doesn't have any underlying file to
impact as with actually file-backed memory.

>
>
> --
> Cheers,
>
> David / dhildenb
>

