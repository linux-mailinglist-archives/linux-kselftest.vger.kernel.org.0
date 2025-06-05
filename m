Return-Path: <linux-kselftest+bounces-34382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFAACF43F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4937A2D35
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3D1E5B7D;
	Thu,  5 Jun 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ecyt3C/h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oymLTDQa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032C2E659;
	Thu,  5 Jun 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140782; cv=fail; b=uqTZnUUBNuFwZyJ0gNMcT1oeu5KqpnrZa9ecHY9X+3yFompRSidcxI2e8k0YYlw450aU52oqd91nPGd9NgZaD8PA49Xle0W25O66d/NNFr7blgsDX9LEm6B3UKYnYTJiD2wVAGcdS9YNqTW40JvGUt4VB+GFE39C+CNsCpcZiVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140782; c=relaxed/simple;
	bh=3F4Gonc52BdzGbTqyeule21wn3IPeBOXvDtcKYhz8LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W++xX326pSu8J+OXyNmcz6sOTWFEdD7O2v/+AbqwHjKrkj7tyXE15GxEyJKmiNBflRVL64gwA2Wl9p/uHXCoglQLDJ7c2taKbaTQtdheOMrRnj1Crzv1cfrjY3t9qgqis6HJX1URT8fYAqpU+7DxsLvBIXzne9/aCXxZP8dq0zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ecyt3C/h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oymLTDQa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtX0B030865;
	Thu, 5 Jun 2025 16:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3F4Gonc52BdzGbTqye
	ule21wn3IPeBOXvDtcKYhz8LU=; b=Ecyt3C/h/dZL2LLbmFfQ4DKO6LhzpP08gl
	iQ/NEPA+v8vYCPOtlwy3+llvSf6nbDNUK185CaC4tvfu3Om/11+qPeX6CW9sIZyi
	APsFjT8MU5fQ87zlfZezWdWve4uN1dUaYCYJs3KNp4E4Pem+EIYO/zsBh8DR5wY2
	d2TmzDK6dQm1rOqJbgdzQVM7VvER0hbZ8V/z8WMsu+8usePQpXSIZyviK4pRZHMz
	e0jN2LLwsjETZmCcC91rDFbOsylmSDHaMDCnbqF11S/Tw2ygoT7/rZWVmjH/KX5d
	yHl6StK+ApZfzBX7ZBDaTMfsZwLqd06hygDjgBg5XBdEpR/jVrUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwheb13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 16:26:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555FAfew033811;
	Thu, 5 Jun 2025 16:26:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c9dwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 16:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdcDP+mjXdbat1byGtYWocuYKfkmV5wv1+8FyNDEVtC6D/WcmfO6OBGWB57rVtv/O3dEVR14WEYphhWzO/pnAMFYFGU3mCU5TK3jtJ/oh74lLvPLhm2yH155MvWjhCvLulrhLt5Pb90GrRAGxBoP4wLbl9E+hhOjWUxrr7HAQj5wZ6w83uNKd0/tV8DFGGUsrBSp9+OZaYgcMA/dFnh4uY1YllG/7sMRLshAHZwRo6Rxx8aF/PGub9qCdJ7WUuSfKmpUNyAcw2I/6ZCEYl7XpLierzO2q1/aCwtcCeG2l+h9vtqnG+sYYmcHg/gl364REUwv9nylxiFqCzRT+GqYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F4Gonc52BdzGbTqyeule21wn3IPeBOXvDtcKYhz8LU=;
 b=M60PDScbgX0Kdi28UADk8kLAG6XEyPTG8lxtTq3brxJrL8UlDnPP92jc9rhLRuX9myV87nMQ1dYuq4KWqA3/hxo4glqoeF4Q0CXJq/R2zMXEFhjuRZ4PQGVSvc5C3qXelDptD3fMJsET0HALobwKTZoAdyWKOB8jnCEyW2kn7TPJAagmcGL1IMgnL9lah7PZJtJ8M6Gd5o8S8k3AknUJ3/Vdobq3643+PMCEMTippNRDMhXsfSuCs2oFDibQCfn+/O2P8/di7Ov/5bGd0dfc5jWBftRlvcVNI8C4AWquuQEOWwEsKEs1UDwZo/F2MEVlHDAtfzVIBE2eDoqbiJVXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F4Gonc52BdzGbTqyeule21wn3IPeBOXvDtcKYhz8LU=;
 b=oymLTDQatG8Co6n7IBBKDvW3eGD9B2r6AWIOtAoV3uuHQq7wlULpDmwRnBZjC1GSF3uJDidyw6ANbpRCwRN3ira6dbyALw4DzaQgmbQIWkKsLYecsGyHZBNFGhD55FMjzUnjwxa05finatLHxKZAdhYvRtX8fja8WdnEVP/2BGc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4262.namprd10.prod.outlook.com (2603:10b6:610:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 16:26:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 16:26:07 +0000
Date: Thu, 5 Jun 2025 17:26:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce779cd-2a31-45b1-ee5c-08dda44dac92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBCH3PzN+wN2BhZ/wuhFKIgnM1d6ZUAh4a4OTTz8BL4Lu/Xp5Do3mOlFbv8g?=
 =?us-ascii?Q?52wyJDzia2LZFdJc7gqlvZ55ztpIq7EysyOrMRpSOsiywpPWUf65gUIGFFsf?=
 =?us-ascii?Q?0aNpgOymG7cIIe/JY5CELePr1SbNiy/8z/rQ54Gx6FolMNx/0lZ/TqVFhjny?=
 =?us-ascii?Q?X691gDGCOfarBmzs9gTkn2GtHk4jiZbjLl9eqrMQSvOke9mYbVet8dZsJrav?=
 =?us-ascii?Q?SPmbTUkOMzuQLqPsI/nFLMfxhdfUdDhNELJESs4wduRTm4b9A7t5efgx7JAT?=
 =?us-ascii?Q?Y2gIu8R6IzO+nbCAuLhRdEYDcKv586qC5DUiFX6WxJTkOwwWs9Of5q0V1InB?=
 =?us-ascii?Q?OszT72qh4NiY/rwGpprn2UDAbRuj5npFIU+vJ7SNImGLEqi0S+SfCXShvWyI?=
 =?us-ascii?Q?jzCcbd+AJxq8sv4DrONC22xc2EU2tfiCYivcavSKExMZ4U46X0CzRKAMP2fz?=
 =?us-ascii?Q?uCdXO+axGox2MMM4UgjhEM5JObSRcuL8f7tbTqnvU7iQnLshvQfB2jTjoxn8?=
 =?us-ascii?Q?W2yJfQZF2HC5k6YdhfFRqGSGvKnYdvgFSnnY8O/HSxJAmUGgbLtLmW2/rPi9?=
 =?us-ascii?Q?jrJ9UvW6qbXHWFjKb534Q7GNpLk6iNlet3pH4H0rpRoentqib20aCwZmUp1j?=
 =?us-ascii?Q?9uqeSA902PoIqy03an4Zh6K5SixTPEZZjLsWjhiF7Nwflfwb2pkq6EgD8Cvd?=
 =?us-ascii?Q?SqCG/ehJhH0XHK7czrE63CRyqBuLNJRxtYYe2Ndvmk8lAgqZ0xVNaq5yNnuq?=
 =?us-ascii?Q?VwOxAhm9yZ/t1PJn+3CU1QY1cLL+qWZEfEVhS1FlV7aT4T/C9wMQZpk8kpGN?=
 =?us-ascii?Q?gSaBGpQnKxZ1pHhiewfjRXfE/S95Xz6oMbf4om96TUApEZ+fGx/7oo2pNFcK?=
 =?us-ascii?Q?/dg6xOta9WMSEVlBKdVn+Qb8haEexE4IE2hxYpYyLkZIaW7vwKCu3JY5AUb3?=
 =?us-ascii?Q?ap9Z7K5278BbbZZyLp6oOGmVx4amaxuGHeBhV5yNTZKYX6eK+opvNgr9uWT7?=
 =?us-ascii?Q?aGrTnbaRIunj3FiRZmz20okA2BEh7yibBFX3csmTnKRf1h7660MmhW6gaGe1?=
 =?us-ascii?Q?zKVlLhyXoZYg/51dkpTNg/N33QkWetjMak5xf9KfycfBNjjAI7axkwIT5Wcd?=
 =?us-ascii?Q?hfafmZvHEaktLGE0ITgheCGx2LzjNqZka3l74/CFw/waGyRPIJCyRyX0nrVA?=
 =?us-ascii?Q?TfYSD72SpxESYZwB4eo3BlqpRULuzI0jadsCDXsoc4N0B3R1cLr8x5I1lUVS?=
 =?us-ascii?Q?LsqxrP8AUkNIpeGTB3sbpw+vIUgodp/l8qM58DOhlmXuDNWuR7VER5VwooYa?=
 =?us-ascii?Q?GeDZ861PmHA80/aeiFnyb5xAvXpL3rXEY+PE0HsOUzu3/Vo8fNH7xR8aCcU7?=
 =?us-ascii?Q?N4uh2DUSZp5HbK97OuyommYWKSmMvVufpKy8Jk95deFWtQZ6t+RYOLqi866s?=
 =?us-ascii?Q?AKmrN5eZOEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xpb1E8pDJAC8eNJRtDjghkzJJLj4T4dDjDfzPMi8hwMFegwRx7LpWAzXoy9g?=
 =?us-ascii?Q?xwHOu7+0SdOVqUPz7A3rlzCgKHIaCZqiS++hvdHJ4ZKxRNyj+6y4khDVlN6E?=
 =?us-ascii?Q?c50b3/qgdx0ctMRJdqQKxBePmA6ddYCtSktf7wncYWxU+gVp3lcZkEwY8k36?=
 =?us-ascii?Q?yyJUxvXC1/Z72B6sUEPxZWhV0YNdlkhv1JILoRSh6oXApeBgOsDk2dWE3yzG?=
 =?us-ascii?Q?zbiGp3vtZPLV68ugazJKQFtx6oVzNn1nLRbkfcUAasYdCpFN2RQbWlHUxKB5?=
 =?us-ascii?Q?yDC6Ja18Faia1aQKk8xCpuTNYmUtrXizwBvseokKGnLY/zEKIQt303TCC0P9?=
 =?us-ascii?Q?WArt3sNbnGOpcPc6TlpPPtx/GahOGbuo82EEVIorBgFmOa3dOIGmI+85NwZ6?=
 =?us-ascii?Q?2mcDwSLwLmqTGenC371U3DRSWLQj5dj2BUFD7NlKKBensl1OlOrlyo8RJju0?=
 =?us-ascii?Q?aX97LpA6nH5h24iQw7PR1QVUOUeYoDZg3KG6Z22Hs80/4piFGyPABDntfdnR?=
 =?us-ascii?Q?iQvMI731kZHQKiQfHbM36wyH3aHfcFK551ImPSgFsSO1jhpDBI1EdWENsiG3?=
 =?us-ascii?Q?JSCtXhvBz1fjPbHDHtKtjRLxOMDtzWEfoVwu5j5NsgyCCv/sbFwseLVtJ1LG?=
 =?us-ascii?Q?jWpjFcubH0QL72YwzoIaTB5N4QC5q5lXX2yn0XfhplwZoACKayX4CV3aOvpu?=
 =?us-ascii?Q?y6hag1JR6E8s7n7I40bsEcIBWO/z36IwioBmm3ZKkds1L0sMNLyoLywheVzR?=
 =?us-ascii?Q?HPncFkZCE8wu3fGnvIavrg4xf6LiUWrsMkBfTWjALHw1BEIgPb9mrxz7nUsE?=
 =?us-ascii?Q?hfG2B8ojgZyKHL+2p1gNrCL+mxwenJdFKGLglQmcHImJazNxZuDe6F0H7yrN?=
 =?us-ascii?Q?RirV2EWFcAkRrS5A+njtGKyCErd8bVuf5Ndzx4wX2WFrQOp4SDPkt/S+w9mH?=
 =?us-ascii?Q?9C2mITyUvfXgFogsUnsAIN8xgaxfS4Kzjxpzvd6/3UzQ7JXPz8y2tSj2c7ju?=
 =?us-ascii?Q?BpMD21ZqO3rzl7WnHRFRs2B8pQM5y6BsNoaEfuWHsPZg7L03oWUNnlENUHDo?=
 =?us-ascii?Q?InICo9Ky3qqkVNI4uRFv8pEU0ILpQgIM1L8efCFKs5x3vaKi5BuSrXyq/bMb?=
 =?us-ascii?Q?m5S3QjWJ1+aByB9/1CkvgoKYog2I1HUKQpnfWkxefLzOjIDV1BgudmPx4bFA?=
 =?us-ascii?Q?0uXKqBNirCurxbeqLtvIb+z+9y5aEf854FV6cNjT0zpYxNFETVWqv+Tbc1rE?=
 =?us-ascii?Q?zGkf5OQE7XYACQ/y2la6ysmI1e3JeJWvs5r/HMup+l2rPVSxTK5mbYvZJrx6?=
 =?us-ascii?Q?7QyHs0KOYNtXUTxH+CzwwaVi2Go5Luok7xrODv+PqaGS92ebzjvhmjlXayd6?=
 =?us-ascii?Q?zTzvvSK9C4ZIveId1qEAcjwyo3vUJrR7AwUVPlvivs9VDOBGCCq66GByeW+Z?=
 =?us-ascii?Q?YUU+Fq+seld+DOt8b/sbgqySCz19dEbtdO1QVNF/yr+wTyFO5CdPUtPPzxel?=
 =?us-ascii?Q?mdqSByBrtGKfMyop+L0UhtkDJJIBLFwdhAiwukzjJbBlyFRWyrg6VyyF/MNC?=
 =?us-ascii?Q?bJ1MGWg6ibenkoQwkGT0/aZZGXYldyvIUfr4b0oePtIpIkdRYhGELGqd17+a?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZJ3xsUQPek4sppG2OOHwZjqMal9vfi7hQ+zJJL/nn4Dh3G4f44AGuTIT9Pb09eeioy0F23obHQhNYj1bl1fhDGe8kYlr6cPBNoJA1a4KrvIJz7n3WY4QYhqztPvmarDBXxmZDPrbksKeb6U+5blQRKZ88Uw1DLwmGYJ5wwG6/BM223Zt3a1klljBpsI3i1Iy5jfGCk3Ty6bV071rMpW6zgV209yQ2/xJF695rbtEg115R31N79mW2dpjHBPDg2SkdiX6A4MufHRxYABnPKfl/o+YZfy/eCojNT/6fHvriB4A9h9TpfaZVG7hRMzmAGsUSesGfu5gkoFXypEqQi0HfGs4o6L0QREEB3myoF9yMFXO25g/yy8K3i2ss2VPimpCaZefG7en+gMI87+Jx4Gq9iMvar7vnRFdeRNHVNtQQF3z6E5Ugsj/3qjJZSGxHhXX33gwhJ1vSI5riYwMcF4xN/zN56Fiy5EMO60MAZr9Cm4o4oJMoBWI0oFdHY/6vLzPZpvpQp1Gdve4ZTJiWbTMJ0Noq7OKWgGIS3yeG+T7c8gAbQlaWv4C0g9Qgvp0KzbfHbIBjX30Guwlq7COdkgF5D28X+bv8OHb9m2Gp1N37ng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce779cd-2a31-45b1-ee5c-08dda44dac92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 16:26:07.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eadW+96RvDUccpLkYVIRgyFZtc13kdrQWCNcNks1JnxtNOiZYQ3nnJVJO3eebiwEzOP1r8HqOi3n1pKWWlO1FnllprDvnJc+waW/SATZjiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050144
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=6841c523 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=DcMNablWdiy7X42mhUMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: K-5QKpCfTgzWgfdejrEoGgkHec6KgV-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfXz/t6O0SsWluZ DSFkG5zjBBws2pXWkCXVxwmdPtbWHuS6l/qZHDFD7i/CfiqvHeCEdJAn+gZT2qVucwlZVojp8yq LOwpnJwWOYLjK1/a91MnLXctye6UEaRRkZMBzYmiuzygEl8UGDRNE2Nrt/jjVsE2Hjhq7Ag6b10
 qjNFdq756rV/9brdQZQGen0T2nOAmoeOEAIFF3BEldAHEKZd0zq9wFgWMokF5Ca1BNWxEEsgBuX CdAb3fnfepKzgapQ0+ukgs0cv664XgNv/Oh57EEGxuzxIt5SgjwhvA8fmNb6T0kvb1v4kwnGDs/ c/A+rscnDsbqmMV5560fvhDVAW0HQGoR8/qYKNsUK/tQA1ft9yjmEDhzOfItgnuzV4PjMYqmmPH
 OCotm2s+/gB/SacM83QKJiz+adi090lpkaH1P11n9xrF1MsGA7GTXSG+OxSaE0Wgz+BjI305
X-Proofpoint-ORIG-GUID: K-5QKpCfTgzWgfdejrEoGgkHec6KgV-P

On Thu, Jun 05, 2025 at 05:15:51PM +0100, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 05:00:49PM +0100, Lorenzo Stoakes wrote:
>
> > This seems to be causing tests to fail rather than be skipped if hugetlb
> > isn't configured. I bisected the problem to this patch so it's definitely
> > changed how things are handled (though of course it might just be
> > _revealing_ some previously existing bug in this test...).
>
> > Using a couple of tests as an example:
>
> > Before this patch:
>
> > # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
> > # memfd_create() failed (Cannot allocate memory)
> > not ok 39 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
> > # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
> > # memfd_create() failed (Cannot allocate memory)
> > not ok 40 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
>
> That's the thing with memfd being special and skipping on setup failure
> that David mentioned, I've got a patch as part of the formatting series
> I was going to send after the merge window.

where did he mention this?

I mean I'd argue that making a test that previously worked now fail due to how
somebody's set up their system is a reason not to merge that patch.

Better to do all of these formating fixes and maintain the _same behaviour_ then
separately tackle whether or not we should skip.

Obviously the better option would be to somehow determine if hugetlb is
available in advance (of course, theoretically somebody could come in and
reserve pages but that's not veyr likely).

Anyway, mm-new accepts patches during the merge window, one of the advantages of
having this separated out from mm-unstable, so there's no reason not to send
something now.

