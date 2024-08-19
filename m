Return-Path: <linux-kselftest+bounces-15722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4C9575B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76292B21303
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CB0158A1F;
	Mon, 19 Aug 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nH4WVJoh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sqnVTqtW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8B15622E;
	Mon, 19 Aug 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099620; cv=fail; b=Zdycd9K1/4PGrhw4oB1dPysuP+46p5W8xSy6od3LVDVHkiGZja0vkgquaTstWbnv14HZ22yPpfmyPW10tlcb4y8vkbpgZ9MKdna0vA9KGCAtRMx2Ocd/EWKxwaPwtkaQxEpEp/l4Kb6sb/eKWVOZFl4tdNwaJDsMmbf1o4PpX/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099620; c=relaxed/simple;
	bh=jNOLWVzZ6XkCxm+B2dk9ftHOTfnFqHLBVX6HO8HnkTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B8nKxF2vEhzRU9XrfzTPltJm6V695djx0vLWTidemWOeFcKQcGcfN1Ly/syxY+kbBBp1vhq+DzEXEpTzhry7Jv74tmk2GpusGbFHe0lNWPaxYgNh0PEpQDYUuZAvicUohFUNzObpXL7PyLpXnmyk3aih85Bbyz3x9yhbDVhMgOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nH4WVJoh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sqnVTqtW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBXPC006843;
	Mon, 19 Aug 2024 20:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iVYt9q4kbQfqCr1
	j5NnapSy1Dv1XoMTRyl7w+Sh5/Sc=; b=nH4WVJohQglQJtQqLrR1AZPXIowdv+3
	c6s3HT+f1JrfaOmgO7IIW5QMNizV7U3a9ikx4k2EobIXJDP2mQEMdEPZI5za8vk/
	3oH4guibE3iTVswky0kWlv+gwJ8FpSA4IjVh2EzEyWZ/Qcht2ETti7URqWWcxAs0
	X9x78++jcDcXy/8cipVAUqQfXK8+U2ya7Vm6KTolkf3FIP8sZANuYGFHbmmnDMOb
	IURwSTHm3PBDiDSAfcLYxm49TyT8ORmX92xgBpuu8eYt+gCb9EmKlZAHra6vBLT2
	X4b4kLcTlaREu4gXkrffkdqkVTG8CfWhANKzfEs6pgxp9ugR3PmbmaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsujjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:33:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JJeB8M013971;
	Mon, 19 Aug 2024 20:33:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h2ekd75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cToDOiDweLbN+48j2YkrOvOZ615VadsvpEB48im42wU1XZGzGSwkOcJjDaqIfbbFcyjTlZObNbOTcTOX4+8nn04xmqgi+lnXzOPymFpH9ZEmxei5CXsqkxji7rSoYS4vEdRdevmnOnBXzJZrJkNB4h7wsZbkqQtdzfDOO8DT6s3O4HQMQBS1icLYXux4o/56jUACse9uA+n4dZXMK7awHBy5a2WfLtvzQ5tKIBzvfjyumE/45lz+W1m1o9CKLea79RuOsr2O+WyzDsSHIJYYiYZyTTJ8DwYfrZ7Vz9mgJam9zbBUIYon1qBidCiYcvPq1qnjJ8+kq4y/PSKSjAqN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVYt9q4kbQfqCr1j5NnapSy1Dv1XoMTRyl7w+Sh5/Sc=;
 b=xrPL413TIbPztY0tVa8+bSdnApOLuzwZX03kcIM8h3HS2hEoRAtO/oc3OcsxMgYy+gjhrps2zEU4fcFGJ5dom5tjr/JfHbi3XwMJ351TLkP9YW6YtDv8UodOtAtOpzGjS3hrPUsHVhOEDVJXXxRlXTSX7e8LAL+dhTwbnRx2nT3IT3ORjsdLUMig5EB7L9jR4obN19MUPv3QGoGw/v5lvTZAKHiuReJyp3l6OM6WCrLYIc1z9MJs1ItdZ9ku0m4w6tN0obl0chIOtUQgsizvrLN97lSeARkg9VxiJWXP33OiMRSitkaHVQSx2he4rtXNw4g5Y3qSLJycQThrA2TLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVYt9q4kbQfqCr1j5NnapSy1Dv1XoMTRyl7w+Sh5/Sc=;
 b=sqnVTqtW212iCmASJFmm8lNAWQZUNw6wdRlxpdfP4QxLxsSrw3qsjYtjGyK/IZdz6wHhJkRFUP0cI0pzNnZoLavzSkyZT9CxJuCIPC+N8tQ4/guyMorfr3RD8YXt+/pq+R7uUKLSxveok29fNuhqZ8D5z/eVY8DXybMe4IjKGCM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 20:33:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:33:20 +0000
Date: Mon, 19 Aug 2024 16:33:18 -0400
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
Subject: Re: [PATCH v3 3/7] mm/mprotect: Replace can_modify_mm with
 can_modify_vma
Message-ID: <x5djrsgqvmk4gqnuxbsig77jwthjhlfcvtjtwxhopj6y54lil2@dfyavfeqf7ws>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-3-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-3-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a828c59-8ac7-40b9-32e8-08dcc08e2a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUVlnWzuvgw2fd7s+BJOmWFkabgEggFBKxFJra/iqpMW9n0lh30SmmYK6F6C?=
 =?us-ascii?Q?6wBp4WOLd+4NEHREmY4ZPjykvTslu3Vvsxo9Kt+1uVboxfYa2fjZJNGOIgPn?=
 =?us-ascii?Q?O2zzwpLfmg8vp0u4Kqwz0mv0Qx+DcmJnkLtgGe2hn9efqgij5jw5c4OPk2tF?=
 =?us-ascii?Q?e1CdzpwRpsMe8KUDJv+XUnBTNOULFuPgBtWkkw5ZOQHSGoMBZHFkSpSQYS0/?=
 =?us-ascii?Q?oYqD4toqQi5jiFd9aWJxQRiiuIdo70b1bZAhotPKYgG0KWgPF6bU9e5Dhc8h?=
 =?us-ascii?Q?7kz1f0fxr0XsrKabOFCgBWznjyo1UMB09CTMUEN4LKdNVkNT6pBDPcbMi9eB?=
 =?us-ascii?Q?2RZvUwFKSRLgFKv0uPbl+0bOBTFhhu9rQHwaTtDg/BsFs14CXz7aYwpL/5Yt?=
 =?us-ascii?Q?xwEJYR6X4uXR8mkYeV/wvi1uamFRjMKPbGgPdZLo5AOmUyga+NEgLPwjCvYy?=
 =?us-ascii?Q?nqqKMsnl4vohtGrFNm3lMJPu5khKtG0D5aHtDL0Y3734uMPuQB7BMbecJmt8?=
 =?us-ascii?Q?gEHfbCvLfNCcKMxkOp1jD/KIgpylaiS97H2hn/OaaBq1n+SNZQFGMTIqLtfN?=
 =?us-ascii?Q?5C49081WezRXL+vvzLc1s9MyyQvX0uRaeEJG+bRcPRTQTIoMq4AS/Ri9gHde?=
 =?us-ascii?Q?+1H4wNNL8PKRYcMOYjY6dkAqzaormb4grYEtepVMVzfe+UYTH05XXjjBxe8F?=
 =?us-ascii?Q?mW/K9LLbksXkH9o5GSxGrWwhDisI8sgySAll3KUUDCrvAWDGL9wOqG44NMC9?=
 =?us-ascii?Q?K8EwGrujWo/YkiaCP911nvPDsu444Ucta9+jPg4SpXMtiANe5HPMdP/NRFvo?=
 =?us-ascii?Q?MEkw+JeJKs0Z9x00DXL6w38JH/v0guap82ld5J78TL0wn23NJ7gZ0S5FNUlT?=
 =?us-ascii?Q?d4LM1+vObQcLVGWc7z88AJWmUtJqVJLxE+z1+zfuMmrh51ZbV0SZHliVE3ed?=
 =?us-ascii?Q?HBV7LLcHTTGRWEU6HOF9vmPELxqyCueaLMxt51l/CoXWWK5IUa+I5Jtidq7A?=
 =?us-ascii?Q?zjxWnr9XBhyZI+ca2brkWZptT+U9QyS7wsS4QOFZGqAci6N2Ix7fuA9TzfXV?=
 =?us-ascii?Q?9JSdBS5lhriR1GWNSIEXlwfjDTZrgdYXA1SGKv5oTvzV4Keb0EZQHz/p2+s+?=
 =?us-ascii?Q?sijcZ3FkRcnQMiv+W+0CPkStsKR2hzU5ksizQ3FJ/omBwk0g/J4pX9yItrDP?=
 =?us-ascii?Q?8Zj8Y6UKi/TnJDzfP1iigU3W9sKnNTGdqUycMpqp1IkCBaOyUIYoxdpXjtzc?=
 =?us-ascii?Q?EYkd/9IMacO7SGUQ2HIez0AP4BqOPJOEO+1l9SemGGP6jgJVZKjgJiEIritE?=
 =?us-ascii?Q?XqPkgX0EH8MENhZMa6B5r47vLlDCZzdVTpaij3laHSKvkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqIMrnsFl0mYt2UG9xqq7LtR3Dl3bzVW8A+hpVG8e/evqQF5UnmI/2CM+KE9?=
 =?us-ascii?Q?QP+EwyDz22rYG3QLU77BOmUKbs3Mh4loEeVEqLGn48gNWLMAUyVGlfW1Txpk?=
 =?us-ascii?Q?tpNn/vQzIu5vpPRV7qT5Rjx82ntam1q9WGcPSIly1Ggr0fMbqCo687V5QfuY?=
 =?us-ascii?Q?BAEGtOK9/iZ0614gIMojll0VSKtMAyiD6dDs3djTocCqdxVdFhOORMz/jMWk?=
 =?us-ascii?Q?eXIUMtwrCCU2CUdKUGWKVa2TBLxjEVWSPdhsDfXuiU3ZP6b7c1YNeNSWo9SQ?=
 =?us-ascii?Q?+JWTJzmtNa2mg8sQhNVGWoFlHTlKXgx7diBb5lwOwzeoAvNBbreNpFPX/4+e?=
 =?us-ascii?Q?8jJ3EJ1xHX9hgVPioWp2cwOj+ZHgNU2uuPHdVd0UgmK6OiMUMhRud4QBTOaQ?=
 =?us-ascii?Q?1CnM82xmtlM7OllToi74r/M0zJzIt+TTprUyruJjs38etCYq0ZzHbi9NgXxO?=
 =?us-ascii?Q?RUCKwIhadDYjbUwM0yHESEaOakszvXiJCMvka5SdfG5j4vBRCc+EwhThcqGY?=
 =?us-ascii?Q?dRAXqgjiOhvxl/DS0a7QuuAniXKmdwSdiOyXS6+6mAhmEow7bMFTKrxswiS5?=
 =?us-ascii?Q?1Qn9DEfPjtoSOoFwE9Qul75WVHW5H6RnOeCwI3YsfzysRlB0dm5dN68V+s+R?=
 =?us-ascii?Q?SiZoJBnEXJix4ocv5JhqDczQ02rfKUDpGatsgDzOJpMvyGfMJUIDLksUEjDj?=
 =?us-ascii?Q?pylLrUt/GdW3538YJicZ72S44Ee/eOn6Kj+weTVs6qHvHLHGLYECt0I1w48w?=
 =?us-ascii?Q?+PRUZBZoIqsE+QBwXK1hClu33wUVrzb382Fjj7iKCsRScAzMjiLwWt+WWYk7?=
 =?us-ascii?Q?F8/KVLVhEt1dDmmWB3c0k6i6yINivE2LeyNp2KYfv7r0WELAMkkSOFX0i2yI?=
 =?us-ascii?Q?6bgMzp0HP+64BFF5v6WblwZzqjoI7xQ8Gsa65kUZqy64UBjSHYU9Om93Bjo5?=
 =?us-ascii?Q?VAS7wBmmHD5I62iYvzJQRjunNmaYe8qiEhy2ZTxEFpi87mSWpsi5OD/wUN1J?=
 =?us-ascii?Q?+Ul3y//92ouF84pi9WAVRv5DrqDkSQFdBNA+YB6TyjgouZFV9XXIJLgf/9SE?=
 =?us-ascii?Q?hb15AduJDnbwE9uTicnMbjDJdkrG7Dg7c5yC39O0W98guO0T5IwDstI3lapk?=
 =?us-ascii?Q?qgg13yrhHcqvaQcwke1GfxTWAZF0IQO/VmJNbHBxgrEZzE1D9bM9/gcl9Vgo?=
 =?us-ascii?Q?si8zKaU9MYB41sArJbAN05++muI3iLPHEs03pwd96K7DKZ1SnKtf0H4TurTz?=
 =?us-ascii?Q?88qJF1MEIapjwATgXXgAB2JUfUz0WG+T05YGwEiioaxzrnu4+blYM2mXiTbd?=
 =?us-ascii?Q?u04sip3SSLJhI54HLk6xRl6zhX5ZFjgF2VcYejmHYISpbSN7pwlg1Gu1g82m?=
 =?us-ascii?Q?tDYzonc+ewUdlwLSy/BoBWq7LTREillPNThFifjDM0FAty147v44aE/ffbZk?=
 =?us-ascii?Q?hgwxjm0UkLn2oI8RXJ5ywiWwN3f74BrzS97b4Q4q+oh6LwT3lf1WSGqdMcKf?=
 =?us-ascii?Q?CqS3Rh9emRWWQ3D9Ss+079JQ6LfI10BACocFQ/BoKHn38DJdNVuEj5VeE2T8?=
 =?us-ascii?Q?BK7H7TUhx4y9v9b+y0l3ssixVG8m/ovKvIlewy5T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tQnPGDj/iONKDhuoF9cCKzNQqzIFZGg+k6amZ6nTHUH0XDZmS5E/3e9BYzfkGL525C4wSGeI5HKTQUFZLS3IeHsSTZdtHfalfx965AGQPMuxNo6iorniOcPyn7CVeVEdhC5NYeIK7mvc9jsR9hVjZm2/K5xAgkXjVpbt+tosjsG2A5YkMYO5bCi9x8qPmcsm4vhqceCm4DBXdQXuAq40NDK9nGtfIWPG2ijtV0h2s8twV29t1kYYr9S9ANmaVXOHdkTuNoXJEvD5A/7ziq+RXfrVrzIeuinygGnO3uVXTOk0MmjGac6VDpD3K90UUpe9gskpTG4wTVMHRCeA4T6NNy5WF4Vug9cReWi+Wfj92urlkP+6ofVC7BlZQZLGLcUihOU3U6dpzOsKgvrZUQDCKz93xW72e2ARNSZbeMwE+oudWXldC7bH21DNFPtP0A7CVIsQqnj3x2VFVt50MbMQNznpgfIb4zKMjC5b1sY9lo/kFpc6D4pXgVR+oMYoGX6hzVSIFtGGPo9IcPfz7nOGjwq1jxkA+HhOxlS+AW5tX8f8ZdDEhPa2EpYffmUUNeQ5VtTI+WOEvK4oEdXusUcoqR4PflDypA0T9QMSrXQUz+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a828c59-8ac7-40b9-32e8-08dcc08e2a55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:33:20.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4EsYA1QKCagfBSZgJV/35WnWjllebDGpsvW5wcbI43CvYY6U7x5G9mv1n9Dn0qlzPyV6HFmeQtoBM80ydkkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190139
X-Proofpoint-ORIG-GUID: sF3hlsfdQFHJmPVDHNw2MwpiC_i0MWSJ
X-Proofpoint-GUID: sF3hlsfdQFHJmPVDHNw2MwpiC_i0MWSJ

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:19]:
> Avoid taking an extra trip down the mmap tree by checking the vmas
> directly. mprotect (per POSIX) tolerates partial failure.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mprotect.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 446f8e5f10d9..0c5d6d06107d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -611,6 +611,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	unsigned long charged = 0;
>  	int error;
>  
> +	if (!can_modify_vma(vma))
> +		return -EPERM;
> +
>  	if (newflags == oldflags) {
>  		*pprev = vma;
>  		return 0;
> @@ -769,15 +772,6 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
>  	}
>  
> -	/*
> -	 * checking if memory is sealed.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(current->mm, start, end))) {
> -		error = -EPERM;
> -		goto out;
> -	}
> -
>  	prev = vma_prev(&vmi);
>  	if (start > vma->vm_start)
>  		prev = vma;
> 
> -- 
> 2.46.0
> 

