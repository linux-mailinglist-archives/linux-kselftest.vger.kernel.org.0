Return-Path: <linux-kselftest+bounces-35115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE680ADB789
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AE0188D8A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C751E32CF;
	Mon, 16 Jun 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bh5JBhBT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uIgecomu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B374A0C;
	Mon, 16 Jun 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093589; cv=fail; b=aGv9HJ+An4+dQjLFxtKd3mIm0Uw5WuFHi2JCFJqqKHzUzniLBZEGH0z+z0BYDjWq43Zhz6ZIaKPCHG+NnpxvFegSk/ODPFdyovyTnW77uob5hY03xPq6mBe3AWc9iUxiISzrqwR+xrGDvhodFy77TNm8vbBWh7y/NXYNiUOc9z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093589; c=relaxed/simple;
	bh=Sr6V6vAqa1nlYs5EuFQyqnscimUiVxvNj1FrF8Gq75s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3jd4mXwCyA7fL5LEUZ1gVQdWSOASPvBFNPZLQ5hrm7GHUzIJdSUUJ73v3lUcCinK1iAswv2TnulS4rX0sWeoWL9rGHYddbK84MN8b2+wPERRafcv1syZbHo3O0Wr4SEtVm8y7M128IarKfhoffwA/ZXxnhBjVJY07HSvM82PT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bh5JBhBT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uIgecomu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGtTiE010179;
	Mon, 16 Jun 2025 17:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1dpULu89SsqMyWQuAK
	qOxaiksn9jFClkTbSN7rUbeU8=; b=bh5JBhBTkwBWs6S/B0R+hJ2g7pl0WrA/E7
	uM9cbPj9AsaKG6GdGXMZrIfClW6Mts4RepgMSIvC0vLbFScCA1/DrCtW92Y8vO7J
	JJ7UNzC9U7KZRQ74OE/4YMi+AsR+TmivqmSYMFMf0lqQpizlauHFcfH9R99/n2S+
	8eipIvhv315NTej5+FbrIz7l3apAmdYmMmZqLtDIEoRY2yn4zU3hHLhPOzlOutIJ
	iMo0yqJoxUd7FSZguVPw+yN6iEjEgLCxfptgMDVJ+QIsgLfAbOgPsV/g0w/vTSFO
	+ptbuuv/XPYR8Bn8YcwqBHYSCyBAMz8SDGYK0Uc9bSMTkH+BKk8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914ek60v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:05:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGcq9Z032042;
	Mon, 16 Jun 2025 17:05:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh86e93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLCbnPFUNeMhDepw5Dsn01g8s4NOulBEOnKFztsfTht5v4gj9M0htEL+zouot41K7x24Dh1fI/K2+W1WT3LUfmG5/+cmGYUKb9tlP4MJo3siZbnQx5wbcBKgh5KTcO4t6avQma26YiXMYHyG7zLNOYtlL/r57ROXuSMfyYiqZt/fXZ7EEId9A8NWkrDKc7QUy9wat6LmZ2kwcXNd0bB2sHj9s8AYjKCB3b8uNCw9xAy5szFkMLakDWQjs53U9p4DVJANIXct54ZwryPE4diPykuLhAtqEnBKuHTLUjSWRfqS6UkDpGKrZIgx8pfgcnruMHsbJVLc+DpcdpERoQ/5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dpULu89SsqMyWQuAKqOxaiksn9jFClkTbSN7rUbeU8=;
 b=WqtF9shdjq5xqTqbL/e7oyrVIMArI4IiPd30ryF6bQQumFxbP2d/wpMrVgMGjnEZ2SdTRTIL/4qLvCaMCfu7KoR6qaFh1vd1fEe6KlVMkjQ88/3zfOCSAoAMwtzofuM7yCH57ecjecMBqTqQbnv58MQ10vTPGhHGQVxW8dQ3fr4viDi7wGUYFVN0dEwaZ3IEeo6NIQ/zMzKfOc7UgvjB+KK5KqhpV9z/8+IbM5jfssfj0k5W7XLTr9RFRI6IFHXRrSqbO+0uaQT4f1ElzYNJ9rHbW8R+g7PpCTe0SqoftQqzwqgtOVkw3wsWWj0BPWVmYUPbo4WDF6Z+AReJu8QgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dpULu89SsqMyWQuAKqOxaiksn9jFClkTbSN7rUbeU8=;
 b=uIgecomuwlj8TmU/4zCWrZqPtNJmEpmEATGQG40Qo9/a7TNr4ElI2XMxXbLZsEziE5KPPgULVNtlyS6wXtTAE9BkmT+a7jOwqf9qa6qM5cnNG9mK08XZgpCT4aMxxyNQRZXYUGEFqqGViRnBJhaIziH427EkHcHBjPSdwl5JDEc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7620.namprd10.prod.outlook.com (2603:10b6:a03:53f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 17:05:00 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 17:05:00 +0000
Date: Mon, 16 Jun 2025 13:04:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH 2/6] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <5xw6iujjihdqy3sssmgo7z7rghsi3jgusc3kap7w7gbowisyc2@gfq633qx4bra>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	shuah@kernel.org, pfalcato@suse.de, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-3-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616160632.35250-3-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20250404
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc866a0-b07f-49e9-3e5d-08ddacf7edc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQ6aXkRQ0Ma2R4PXS2HDR7SxQ2unTCoLGvPwYxeOS+NriVU5rY8o3lFU2yiS?=
 =?us-ascii?Q?Z126koG6Kb+VcL2UBoPYZ2kOUP2E7KQzndS1oiUIhiMNr3TnYX6GTfEJt6jK?=
 =?us-ascii?Q?sXErPzy1AL7GE8ZjAEw45qjCqevNoTS1H0DF9NMscY5aebNfWMIsYPYvVwBD?=
 =?us-ascii?Q?jV3DN9ErqaWeAGkmarJweDtVoH18/ih7sAZhI58YZ6ZDrnLieXfc/1man0We?=
 =?us-ascii?Q?8e1BcxBgMfOmFEIEuvIDpTiqZ2L3khY6/Q+lXn72fzm1zyU4OcMwrKzsypLe?=
 =?us-ascii?Q?XnRgV9AOn6yOaFj3Zrq162jPmMONvqMcbCc3j72GmMfRd3zTfhM+w0pW5UQX?=
 =?us-ascii?Q?iPEm47VmpR6w+9VQW8MJUFHQ7u1AKAKubzuHCH3x82x2OV+KzNdNM5S1QcCq?=
 =?us-ascii?Q?wdGEH2mgbwcL427Vs6JAwKC/A9v5l6QDS++SeqAtSvNadOhv9RKD2phhFyjV?=
 =?us-ascii?Q?yL1F0hp5+k9IRASW3h0uU9o/fJhPf8/b66wtnYUf6kwfUgDsPC2KjGksqx62?=
 =?us-ascii?Q?11h910tPU0/KBMYDHNsvri5Xh5I2YpKbg/O9ZqHpoK4Z77PJxRqDvlrBuefU?=
 =?us-ascii?Q?yXT0RVcoK1LwXfmRIg39AIlQ5PH7yCQ9JUA0OJGbQ25N7frQ5bLdpapaEcJt?=
 =?us-ascii?Q?a/0d/v+zKZWql6wx8PEg7tSssIR62zh0nZAuxGwFFOeiaX+SK6cp4GF7Q3Sk?=
 =?us-ascii?Q?9pv4uaQHL7M/W7k8Rv42kbXwaAjeI8/kG0vPOPcxuxN5KPQDmi1Z7GNhAPYt?=
 =?us-ascii?Q?GOQc1RmQL1qfhe9QxMe7xIQZak7NS3AjMNI1e5+N5VBRYV0XxwvECMfNi/y0?=
 =?us-ascii?Q?Py714oFSjROdcu69lTHP77TOHTT9/ck5xfV0De6KDIe6QyXtEdcjd+E9x+hV?=
 =?us-ascii?Q?lKK07XmC1HIdD79Qmf+h5U3rTZeGZbcIiKc3iybWA700wr1TNJfAghU4NnVT?=
 =?us-ascii?Q?jN2ym4u5U5wl0CM4Gza60GPzjUPRt4WmeLhcujH7wrYC1rFtSxb1OVNtZ1Ww?=
 =?us-ascii?Q?GZ0b3e4Sdln1GNV4JADK4oRZykAhAUmKvyX/gVeEzDehBwD1B8kgbuFxXVnu?=
 =?us-ascii?Q?CbnLp3cPsvgscXSan9+LaUofQZONuUfh53g9ln99ZkQSwbA93buHVezofigm?=
 =?us-ascii?Q?vhkpDq0txh3LW4+153CiYJQ1gGYiVKF3Pgon1aPciD4Whlf0lyYeatPbXkjj?=
 =?us-ascii?Q?jjWoiqNXRwmpGewjUU40V+pcdEf+Q6PYC5pnlxPcVvRGou6RFGXT1I2P70cs?=
 =?us-ascii?Q?WCOstv+CBk59OvCoBS8OPbDERTIcytW8MXpgRhMiYRNw4PzyPLliH7lxCcke?=
 =?us-ascii?Q?xhnKgH5SSdUZ4spEv339xkFvU66b0mFzIG/o8bCgB0ACOhXXnj4QtN5m3gBa?=
 =?us-ascii?Q?xyqIMrKH5rSl2UgoPGw97iiN9UXxP2mEFtBqKWDgL7vYGgt30wgw4FclRLH+?=
 =?us-ascii?Q?5rFvWrSR/TM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ms8HSbxb3YxOQ2415zCymkWcKNovVJAoVZr2RfXCo7fHHd5gg8LWTGhz3X8?=
 =?us-ascii?Q?/kThyxTqXKoufCL1BVkHafCEwebe2vLYgyJJdSm9jN8X6JrmfFWF/EnHWjwI?=
 =?us-ascii?Q?lnkg+zDS2VopYMoyJTnBXvDWo0Fx1zpdzTe7Fk54VZskqu289wUq03n91t0E?=
 =?us-ascii?Q?w3GyU4MUTkz8GlA5T9GZJYKWoDxQdI5kaDWQ7hgrkKuUd0GxkOyt3o7Ca1Ny?=
 =?us-ascii?Q?2/yLlrMG1bhX4RvvKCrQxj5e+HfFtveQZptSo3eDXVKz9iKArP9+yMkTn+iy?=
 =?us-ascii?Q?YXyo48GMRdXkq22otcF+ZyQ7/8LbVTANHoJpQd6D21mpgCQGqSGgE4KTQZf7?=
 =?us-ascii?Q?bppzLoWog+m3DLny12rsNCtGOPESrdrG09Uwwq3zAEvrgYWcH0cvXvjlIJKj?=
 =?us-ascii?Q?9mIQfgl+1Rx0YkQao0ENjBoDH2xbcLoThg2A094XFePQoKIMwbD4Toez+6ZO?=
 =?us-ascii?Q?ALL56TaIj1WhDx4W9gq07dc1iinV0TmbFna+8efkS4/WsBkq6OSzCmtq4y71?=
 =?us-ascii?Q?Mh0Advyv63LvRiUhZ1s9b4uM0ph6Ea5v0bVd1upMTvng4Ot8w+7Ouyu5nOI+?=
 =?us-ascii?Q?yVPK5HvEjMJlS3egyyFcK+LyY7vF8PlCyhp2UIQfPz6kQFqk8XVx+wphDR3Y?=
 =?us-ascii?Q?0WArAf/F0eSBQA/B42NrLNZDroklc94cNRm0uCQkKZvqh1TQGZxC4FP1fLe4?=
 =?us-ascii?Q?8sG4iflOh2rPOfY/oOVlJUbpKv21nH2O65uBDsc46BHolasYz13ZFK4o+/Pa?=
 =?us-ascii?Q?UOmazwJr1FAoQlakOwlbCRY+V5sbuadHLduQ3Z2lV/vm3dNkMfAOvFJkVC4Z?=
 =?us-ascii?Q?+PgQGdn8ij/3UTgOMPRahEjvQT1Vgz4kHlfftYxdNjVFtm/Yz42OTQVqFSoT?=
 =?us-ascii?Q?U2p1SbYwgRk7ZpapV2zRs22eW3t32AJSo1U/TRA7i3rgupS6Oepkxq7obmnz?=
 =?us-ascii?Q?TKFVaczQ2uo3HcUbLxVB1yXuA4d+n5R5dnAJnZ6MYoRQSLFSm/ruCa04pwPR?=
 =?us-ascii?Q?SPkH2FFmdRHeKOPH2qoY7236+DG7BRWkpzy3Q5f2egXd6UPn1RlEwifm0moH?=
 =?us-ascii?Q?NduCn6Gq0GsX9Bb1rxMl/y3ijnW3Yd0iWbus6HyEyTrqPq4bifDbyYgK2bwv?=
 =?us-ascii?Q?sZH4mbh3KtnQaD4QGqSTQ/Fy+FKUIGd1bHhoNWZAJ1pQGnLre4J4lp/P8fjg?=
 =?us-ascii?Q?4n8Dd/jvsGQjSaH/LUZBbCfCHkFPFNwNATwJm56XpsSDe6eGko1NLcqCEE60?=
 =?us-ascii?Q?kZcjW5ciatDtmaBldg4tKvmP0n55qjdTwpUtSy34OwetxRpjmTyFxCZiBj9E?=
 =?us-ascii?Q?GeWBP+pdhVcWBQA1Toldt8vbRDGnE9fxKvxn1nCI6Ty3yXoNXtQeUtF1torG?=
 =?us-ascii?Q?1YknL4PKT2/lBaZHo1AGbJl2O8iE+qMUgTSnstqj9MhNYmra3a6UXC4vYwMD?=
 =?us-ascii?Q?S0N/XpVvvqQgMmkbGRm5ErOc68+igjRw4TYvV/NFl/GDdL7Qylknuah8ycEP?=
 =?us-ascii?Q?LA9+IqdJ/eQjW0bBIomebG5c44NujVpw1e9FWVczfHPZcD6Mng+WR2xjrHUX?=
 =?us-ascii?Q?zqJSdInsF752/f3znECqT5fzD0rsow2iO+3mxPOg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RznWkbPU7/cMEKA6XD6bMqwsUlH8vopF8a2AHGM6hwMwbx7Ssk59OdSiu99jDTpT8SGlNc4vJrAJ1Htjbe8soEYTT/dKGLv+QbzA9WLQ4k9LAxuT2+C5Xv8b8a7n7LFC1Z1OLtVVatu1s4mIBK7rRK3OULtmSnoWg9thjGv+6bhkVZ1qQhVB3In8VQh5UegnMnsyf+HZ7yWhvxHyGRkRzD0a+aQKTjUGXGpSYL/JdQz3ra0802DkAA0DpmTjyYxgh5sVRV8HBspVKRZUWWtuyQPt/E0BOaIFhd3YZmpLVJ2yEmm4FQYcr5TDqqmczk9Pf7T1BqCPfbBtqCZLIjJFetnxl8wflQ3Yj4cOgTsIMfF4/EIGn9bv46kea5zwcOs3Mf2EGcIuoGz/EUOgV3xudIl2kM4EJnUxyamnxJhcgGlZ/QTfvfakRspG3bS9ugah/G5iKPx32bKuGqD93IeCzRaafE4na9Tv1vTP/akd1LgddB49ZpEsgiJUbvSZEjan+30Hjfk5ry9Vf6Wqo8LrkR41sKUjFu5suQstZubUjH8D2udDUzy9d1X9y3dw6q2zRZaq0mJcayXPwI8UTG8TdvjOaehN1Qn8cr+RmnKqpF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc866a0-b07f-49e9-3e5d-08ddacf7edc1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 17:05:00.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7efVXFfozw8kql4rJGwQKU3lH2k9e3DSQaNiw9OSGCbVOj9g84+5TLu5SdI50DILuhOoboJ4BaFUAioLEzjXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExMyBTYWx0ZWRfX/50ZtI22kvhv zqfkIM0PrarHzifKIbpzRXgnazXglXfTmiY95BFo2yBgR6F1XXBlNyMj/OcxTJjYzGdIzlEnEZt MNx3ip3mNYNLpW4sf03Wi3dn/BEkWCHy0fj/uGy13Sz5COInH9EKAI2wqsXRf9oqTpn5H1B7HA3
 +/j2AfHAc3WJZdH9EK0STF+rcjn2xeEYLxfJG16SYGaJZaON53qYmaNg9IMzfDnfXMXjIt4a8zx I43VqEo0p17Hw3tAzgZ9i7gx3p68IPwZA+0djECgYp8pWtF+NULvYc4Yu6TzBjSBE9gr//A5xcv X/86cPIYu71v+ybeFb3p7QuviOCOrzq/ZlV4QcoMTHrobAfccT/EHl8L5Ob7NPWrPQbCblHn2re
 THkKBwl4yv5pkX8VrWsAfAJ0sXd88KtUZilbZL7/2uGRtQix1vwy9SPFABbkUtniwOO/2LIz
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=68504ec5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=hc34BjPHerlCo2-mhkkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4bFVMNozcCsQt5amyz4ag6g_eRyQncaO
X-Proofpoint-ORIG-GUID: 4bFVMNozcCsQt5amyz4ag6g_eRyQncaO

* Aboorva Devarajan <aboorvad@linux.ibm.com> [250616 12:07]:
> From: Donet Tom <donettom@linux.ibm.com>
> 
> This patch fixed 2 issues.
> 
> 1)After fork() in test_prctl_fork, the child process uses the file
> descriptors from the parent process to read ksm_stat and
> ksm_merging_pages. This results in incorrect values being read (parent
> process ksm_stat and ksm_merge_pages will be read in child), causing
> the test to fail.
> 
> This patch calls init_global_file_handles() in the child process to
> ensure that the current process's file descriptors are used to read
> ksm_stat and ksm_merging_pages.
> 
> 2) All tests currently call ksm_merge to trigger page merging.
> To ensure the system remains in a consistent state for subsequent
> tests, it is better to call ksm_unmerge during the test cleanup phase
> 
> In the test_prctl_fork test, after a fork(), reading ksm_merging_pages
> in the child process returns a non-zero value because a previous test
> performed a merge, and the child's memory state is inherited from the
> parent.
> 
> Although the child process calls ksm_unmerge, the ksm_merging_pages
> counter in the parent is reset to zero, while the child's counter
> remains unchanged. This discrepancy causes the test to fail.
> 
> To avoid this issue, each test should call ksm_unmerge during cleanup
> to ensure the counter is reset and the system is in a clean state for
> subsequent tests.
> 

Fixes: ?

> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/ksm_functional_tests.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index b61803e36d1c..d7d3c22c077a 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -46,6 +46,8 @@ static int ksm_use_zero_pages_fd;
>  static int pagemap_fd;
>  static size_t pagesize;
>  
> +static void init_global_file_handles(void);
> +
>  static bool range_maps_duplicates(char *addr, unsigned long size)
>  {
>  	unsigned long offs_a, offs_b, pfn_a, pfn_b;
> @@ -274,6 +276,7 @@ static void test_unmerge(void)
>  	ksft_test_result(!range_maps_duplicates(map, size),
>  			 "Pages were unmerged\n");
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  
> @@ -338,6 +341,7 @@ static void test_unmerge_zero_pages(void)
>  	ksft_test_result(!range_maps_duplicates(map, size),
>  			"KSM zero pages were unmerged\n");
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  
> @@ -366,6 +370,7 @@ static void test_unmerge_discarded(void)
>  	ksft_test_result(!range_maps_duplicates(map, size),
>  			 "Pages were unmerged\n");
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  
> @@ -428,6 +433,7 @@ static void test_unmerge_uffd_wp(void)
>  close_uffd:
>  	close(uffd);
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  #endif
> @@ -491,6 +497,7 @@ static int test_child_ksm(void)
>  	else if (map == MAP_MERGE_SKIP)
>  		return -3;
>  
> +	ksm_unmerge();
>  	munmap(map, size);
>  	return 0;
>  }
> @@ -524,6 +531,7 @@ static void test_prctl_fork(void)
>  
>  	child_pid = fork();
>  	if (!child_pid) {
> +		init_global_file_handles();
>  		exit(test_child_ksm());
>  	} else if (child_pid < 0) {
>  		ksft_test_result_fail("fork() failed\n");
> @@ -620,6 +628,7 @@ static void test_prctl_unmerge(void)
>  	ksft_test_result(!range_maps_duplicates(map, size),
>  			 "Pages were unmerged\n");
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  
> @@ -653,6 +662,7 @@ static void test_prot_none(void)
>  	ksft_test_result(!range_maps_duplicates(map, size),
>  			 "Pages were unmerged\n");
>  unmap:
> +	ksm_unmerge();
>  	munmap(map, size);
>  }
>  
> -- 
> 2.43.5
> 
> 

