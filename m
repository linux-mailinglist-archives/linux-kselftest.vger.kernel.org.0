Return-Path: <linux-kselftest+bounces-15321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE34951D7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655E71F223E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D2B1B3F3A;
	Wed, 14 Aug 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBvbdj4l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oDOSgvpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B921B32CB;
	Wed, 14 Aug 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646436; cv=fail; b=t0E6IoeNl9qbJNWx2p4THvrBdnLrP7xLVl3BivlLlJbwpNoxa4qGWC+KdBOgjKn0DVUsEp15LduO807UzTxRxITkoSId3MF6iA1wKHEM8gF6A6p5UbnOxPO3SevbgsregKBFjEJ1ZHcPhhGbYmUCogOUJ241AzRsqcBGbjlvb/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646436; c=relaxed/simple;
	bh=A+89koSdBWqQ+1zvimVVO0HARRrqKXANx4uULdUh4Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3tfw9nN306TFuaYTZEfpTQh/VziJ9m+ISaeooXo7HseBynyBeTfue4sQjuSvrNQ7QUKHb0LOHJIRJBYip5fn1BPIiCrMN319f3Vbn8PFQ8M908YGRcD6PqGbtkxKNxtYvpOhITGId4HVzok14xI3lk7BImNWb/ZIOtFRXcpfNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EBvbdj4l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oDOSgvpy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtlSK013818;
	Wed, 14 Aug 2024 14:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HQoA4AT9mT/ZEY6
	lvH2Q1t4PHR/nhkOkFXtisZYeu+w=; b=EBvbdj4l8kHc+UDB5Q7j8D2xV2q2yBk
	4mvjrVkEGXBIK0uhzMRXKfeYGhmyhqN1caIATI8sZ/gjzvqDUCnybNwJ8mm0ZroB
	8ySO36QJJv5ROdQdZzzfB/vyr1Yu0VY0PJW/dHtDcd1VbMelddgOdCgW2vi30Fm+
	WbdHnqbW3QraaO74HjhtdFK2/JaLlSkrQZ7TIR544e9tJFVruqWv4a3lddq2i0hD
	LeHY09k0X9/JuBtr+D/ye/6is8UujqIITEcfdbQvDMUe67bt4B08v1Y86TitSkcM
	YdZScRZVIdQI6C7d4RdkwqSQWN/zraRgybI0ul2mpi30jdL9KBpqLFA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtrhjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 14:40:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EEe0Nc003739;
	Wed, 14 Aug 2024 14:40:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnb0vf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 14:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlKuKLT5qPp7AXI39s4/fSc1geN/hEOnaMl25dubFUcCOJ0TG5HQbuGd5GLHyncsEXX63+owRaQcqNQlK9s36rd+s6BP41/DSlQWhAAwLFVD/+NIBROX8auE/dRgTmXg3Ftvf5uY508Jy0F8dwgNXqdOcVyoIkkNq7w1C7Z3B/k9pjsPEbx3OwKiNrcOwtD6aPz0Hnq4c/fu4SpYc8ToUrXjvnQof2ZRrYXpP1hwUNcL7FX85AIDzezHUCQh3nvdQGMrXE2PqyGlOlsae936HGliSfMzEPc129atPs8pU/D5rAv4TXVpDoBq0QIYY2vKaVoYhvlQVC+waByGHHAxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQoA4AT9mT/ZEY6lvH2Q1t4PHR/nhkOkFXtisZYeu+w=;
 b=V6pVZZhwYfhmGNJmBD5izvQPEaNMVaayRl+mMSe2XvHXV4YkABRD7CbrxUIDKxJqBJxuTWQUCgTLskXQ24501lY8Mn86B7qclnF5mlbktT55ozXwhdVCE+/6VsHNBow6P7D51a4YLiDcMqXj6h/rLidigL6TI8+rY0P1JsX1m6rla8698E9+g7I04hRhy33/MM8WnwogRLkjgd4N9Ecmn2GeHtVUUZ68KqBC+le/fEscuuRshB9/bZq4YPf+ALWaviL9r9DI+uLz8M2c3hj3vm9vA4s9QESRc0b9ehxvDZCwA5q00D6kP11NiyeM64d7Ud4HkchXsn3GWrkmnFKD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQoA4AT9mT/ZEY6lvH2Q1t4PHR/nhkOkFXtisZYeu+w=;
 b=oDOSgvpyTzC9veOz9j/EXeixINTmKcpfwuAQn7srjWL8b9xJ+0/LlnlDqZ48rshu1tSX6PNBQFCGEg09cYvS2f1upszCHIFPoUvCl5u2rfX8wiBM9RLTq1uWZeLzSqSnTNB2b69b3She5Eavn1+17dwoSJkWDleCK5FuD4wbzII=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 14:39:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 14:39:59 +0000
Date: Wed, 14 Aug 2024 10:39:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, willy@infradead.org,
        torvalds@linux-foundation.org, pedro.falcato@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com,
        lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com,
        vbabka@suse.cz, keescook@chromium.org
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	jeffxu@google.com, lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, 
	oliver.sang@intel.com, vbabka@suse.cz, keescook@chromium.org
References: <20240814071424.2655666-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814071424.2655666-1-jeffxu@chromium.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f2ea88-482f-4f72-fe43-08dcbc6ef919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCsIwP49R0e4iEd9VGakCPnAwCocJ+x6SlwXlrvgUjtJyB7/Gr/WMrDOTIt+?=
 =?us-ascii?Q?mql9k9NEL64sCtrcntxvfvHPvVqnaPaqrvHcRoZzOCcgZsa4Tmuid9sF/q8G?=
 =?us-ascii?Q?THqowCLO6GeHu+HQ7/EdZITT31OuQnOFUP3H+62xIoWKTaH7YioWScN3daFB?=
 =?us-ascii?Q?1jGsAt7dnEodax3huPUWwCh/a0ReTEf+KQSU0PjD07mWZ/3tRypICFuTe578?=
 =?us-ascii?Q?gz9S5zfVjpxVhEnBRdu6wrYJeNLnP6YJRapuew9p0L2iwWae6HOBJML2UuYf?=
 =?us-ascii?Q?Io3FA+4kN9KqA0gABN4UJ4QWoCnLz2QLKqsltbKgir/9KHonYISF2aR7duCy?=
 =?us-ascii?Q?FfVxaL2/0xrQR88BIV98BgJG2bmb9z9M5/GQBZUJlq7QOakfOAlBQl6tISpe?=
 =?us-ascii?Q?Ngbtq71FgSZIAFlSy3yeP4pu9NFXi5p1RXtHCRcQFvYRyD87NkmAGJV0St7W?=
 =?us-ascii?Q?+/Fetc3fdU21vpss6y/0GEi7TtmzfIuUT9m2UpUeeOntGjUqKN/pf5u6BleR?=
 =?us-ascii?Q?0ybLjPv22SitO8K0LV/3KDuUhHRKmKUHp43YlTWHXzX86+pKoDdVSCKq6Wbe?=
 =?us-ascii?Q?LkutG73OnR7lRspoFV8HRkQe27FGZQ7P8SCNl/X+d+wScU8ZMjhiCDG2KpCs?=
 =?us-ascii?Q?0utSeP6L834/omt6fguoXfujj/oGkfxdUWy3LiH2esnkKXXx127l+tJLsz9y?=
 =?us-ascii?Q?/bUfvuI0WM8in+hvxKbYxvZpbutapUaN9DGJvX2eAm3ueG2YMLwJ8zoZnpF0?=
 =?us-ascii?Q?3B4e4ntYPJitM6Se3v+eKSNWZRnCmj+tjAoSWJCtoSHqH3z30R84KN9kJwBR?=
 =?us-ascii?Q?GDOT4yk9+GvAvVeRWY0fwrmgNDSvpVWDwVFvIxt7fMnxeYBN+Zz1EnFSC6cp?=
 =?us-ascii?Q?JBQ54Knbdx0nPYIEaFNQyBSNGlKwIcgzXR+2FHWHtgzJj40bF2WGFp8GZ6nM?=
 =?us-ascii?Q?eQjxfhAykkXi2+xtLtV7DAFWxqKT5j3dUxzcUzP0KrHfqjog7P1t5CMLci+V?=
 =?us-ascii?Q?cy8n1O0tl3ELNe1wgJo3eIvQxiUz3ue3bx5DhXWci6nLOA1JHaaNXDrQqk7m?=
 =?us-ascii?Q?aPZiKgxkSiPM4gPK237L2ZhGDIDh/cR6RMNanGgCEjCWwXgMjgaOKvVWkR1d?=
 =?us-ascii?Q?Kat4KBmBbeCSIQcyqyCxe/C29bknscWYDp03jxhBNyvrmOfPcjDaIUjqtLpM?=
 =?us-ascii?Q?qWVrN5EO3p2XgEP06rF6csexG+zKcELoIWHI5qAfXtYmpF3abXsiRgdDFk5R?=
 =?us-ascii?Q?fSoXmiqNH6WGQFLLRMsl3pbhfhsPQVFon8tRg0PKGKnf8ZfkSovvyeja1muu?=
 =?us-ascii?Q?wCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8Jm6cN2Zd4oYNg4SzfPjQn4g1BnxWG1DJRpKZPwUM0VgumfSDAiUzoSLnko?=
 =?us-ascii?Q?KTnS/e/KzXGd8eJyF31Xhe06KvukvE4ArWAswgIcAMWDPF+AjL2s2qzbYKVG?=
 =?us-ascii?Q?P7g0C6UwR47DrhO4FOHmDl9N5qFrds9WnMjBbZK5CFC/AHd98E55JxJIA3Q3?=
 =?us-ascii?Q?dqdIPr7IxVRdfkQE4o8pmQ2xHtk5DYON5rJ1O0nLMEZwwgKFmKUvAvVtqrii?=
 =?us-ascii?Q?k0yXhyGyPvJUt11CZYQruGKKheat03hcA13oGTLmKhHoPLXeHnULPNyYheaz?=
 =?us-ascii?Q?DMsIHTkj8Gj+PBRHNO913vOj3rHrgRvbriEtn5RuEIh26ZNbMUIurcxzr+A4?=
 =?us-ascii?Q?hTkSVBHuz+oa21/O6xKCJlkujEoDcBFVHpB04HrKk6xe+b59gl3pNxzuZvgZ?=
 =?us-ascii?Q?OuwgXWaqk4Ng/3dxkAdlIBvpbbaaMSXtd1ZiQi5eWW9sNEffDTqGZLaphPLO?=
 =?us-ascii?Q?PDmpjnXfRTQedXqoZvOEXdfYkA3AMKhZk1RNfeRqBtqqkjh5A2RFNb4vMqu7?=
 =?us-ascii?Q?2Cl4hWfihZ/dpymo4sfQ+HWP15lInUKqPV23k5Li00zdCdrEH9hoXyEM4siQ?=
 =?us-ascii?Q?aLrHzyURfIvEue9wddTE8LAD4HFetfJAAPZUR9YhGize939fbQLuPCf2bw4o?=
 =?us-ascii?Q?pM2QzYYsdN5lEDtheAB6SMr78dBHLwbAw1oM2nQRAPPDImR62wrTnRZNcRz0?=
 =?us-ascii?Q?p956Pc1u2sKqgCwGgQgeH0LoyfSTkmd6r6B2WetVCC2fDsfDitWgCoQbccIu?=
 =?us-ascii?Q?74Edk5Rf9x8Bqy5XcLrBojpcFoSu5vffsvPgMedOMUUXOzni/XjA4j7irM27?=
 =?us-ascii?Q?O+NeDoKadxTdBd7F8kBL8JMZTiNeuOKUAoFW5KLFLax3xGZZyPlgtvFpzzwb?=
 =?us-ascii?Q?CSBYbyxAXZYFvM2SY5Avg19ZJgG6dWb6KgYnAQT5WBbdIwyXGhYpZJZ2maGy?=
 =?us-ascii?Q?8eLssy0wDFjgT0FFXRwhmIJUjq3idRSKrq3AIqQqR0xN00woczqHJONCTzcm?=
 =?us-ascii?Q?JIwdZnRpGZ0C47GjJqpwO+hFWV2lqUYrui3VPSxov0SCnClM/NTrVknEXgS6?=
 =?us-ascii?Q?+73l/9QI9MuLkMsS4mHZ9m6Xjrw72o3OK/lzYoWddZPsJhIw7crPH9WdyPGE?=
 =?us-ascii?Q?fEiWFFNcKAvtBtkqVP87KPnIud5MMTuhpSYZ+9WpVpbqM+u1s4ln4emDagTQ?=
 =?us-ascii?Q?uDL2ivb0CTX14v0eJ5n42HlmO+CYnhtYTtrR5uJad8Uy1m9vXgTeiKy0eZak?=
 =?us-ascii?Q?MKKapqxKIMdVLreVCOK5v4Sg++LMHsHhbv8IuMuOX67ImAwc1H/tv3Wdo+La?=
 =?us-ascii?Q?+g5QrCZ/rSmiD1p0q4IFCQXQIRfnDJfNIpiOj3nAiOzppZYzG19zERZbhunQ?=
 =?us-ascii?Q?QSRrfgtS4de8IAjUbVBR2pK2L778Q2HzCbhc2XfpwJIZsT3S6Xxjc6E0E3GJ?=
 =?us-ascii?Q?4NIYV3wkTuhxEzRdou3V7Hygxs2UA9CW09+QgVBKyzyjfDWmnXh+IGDnq4pb?=
 =?us-ascii?Q?c9MPGvuIAbKWw4HoawIbSrNA3x8x7FYzsIc2bWHiX4la70FshrE5fJMimir+?=
 =?us-ascii?Q?WCjb1yrxBSyyh8s7X5PeWcVNh4z7cElfbbavqr6h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KL6MVk9nZNW3Nk0/JytE4ORMdGUJsGSQBrTKMg6d7nmqIp8zKDHcvKONqb6zVzDUk9vpcJ2v/B4scb8Otqj8YQdvKtjEXaj2czCWCbtaU6PiseHqQFdFuhyxWI4Lsj8PUZzQj2DxQSlNSb3hlrzkn+3M5pECrRHG12QvYcnGEmo7gba0k999KvL/mN1M/ZXrDLAkz3M1XdIALuJ8GT4e1jlCdmylmK2+VFjrjDh3Hq8VwHzeRM0JLD8/snJKjfrNcEp5HyW1jgt481Wspz7bQqrYnc8JfpnnHCkWAxKIkNhSryEdRN+zZtFoYdsD0wmzZ8fAqbkH4SYD1D/L9w/EMd502H+mVf/ufTtTH9w6TDyuBDSTv34wuwQRSDLKDXS+7Prp1QH8lHN6XaGv0NwaSoiSqhik0rStzpXSF0N3X2hHta1ljvnUDHsjGtDv4H6wtU0XsKTvMJWlN1tif7ynGOn5Xkt3Y8k9eNgOViFGBWYPMAM1mGLk/yRD/tNqrKOzZbKv4MqAYXqXUYInOr20MAgaSnO2X8b+8KVderwOQW5RYHoqxlwci86qWlMF4GB+eIktghD8lVqE23bhrd3n4nXAs9insVwtrB38fBIhevU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f2ea88-482f-4f72-fe43-08dcbc6ef919
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:39:59.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxSlxInPKuJCxqHKmfb2JO6N4w5a5Q2RGT8AjjmajhiO7czmPHTrF1z/JVuQ70qYp4yPWFDgA0JXvPyHRbj6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=838 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140103
X-Proofpoint-ORIG-GUID: JmMqP38ubM3w0p7BULazrml33nLErckk
X-Proofpoint-GUID: JmMqP38ubM3w0p7BULazrml33nLErckk

* jeffxu@chromium.org <jeffxu@chromium.org> [240814 03:14]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> refactor the code to check src address range before doing anything on
> the destination, i.e. destination won't be unmapped, if src address
> failed the boundaries check.
> 
> This also allows us to remove can_modify_mm from mremap.c, since
> the src address must be single VMA, can_modify_vma is used.

I don't think sending out a separate patch to address the same thing as
the patch you said you were testing [1] is the correct approach.  You
had already sent suggestions on mremap changes - why send this patch set
instead of making another suggestion?

Maybe send your selftest to be included with the initial patch set would
work?  Does this test pass with the other patch set?

[1] https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.mail.com/

