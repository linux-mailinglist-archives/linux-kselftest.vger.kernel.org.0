Return-Path: <linux-kselftest+bounces-35100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53520ADB65A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6016383F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D4286427;
	Mon, 16 Jun 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQj73weT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GCHRKk7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7B21E0A8;
	Mon, 16 Jun 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090330; cv=fail; b=tLDBJZ44pS7iiwYLkvVFSPsT2PvdJEujcMzqdJIZQLE1Rhyx9vemx1EYV6wbvlDSsCKqUXwjEDufjnRJ3yqRd/Oa/NALNWqo12eTnBoGx/mYt8O3AJPGFBRE5uWoTeT9at65CUBbrtMhe26FtvstJJJXrw/58FbAiPg2zLBIk9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090330; c=relaxed/simple;
	bh=aZr9kUBb5hFSuoKUeml/04D1hHi7kg1AhKb0eW17UMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aVhcfhytswgCjMI6c++B5xbLPu7JBJKTE4WhwhaR85FG79+uC1zEZ/4KO1OhRF9GWZ+zn4FM+ldJXqyKyVs8cUbtCRBl1Cx2GSzrsECCVTG9F1NMm90vZF3IPfiPmH/K6kHI7HU88ixB6T9GZx6RbWBr0xgEjfwHdijTb1/G044=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQj73weT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GCHRKk7d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GFfan6026113;
	Mon, 16 Jun 2025 16:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h5zlXe7LF5i2XubvbT
	d/FpjaP9cSxSRrPK4qcYSbnQA=; b=eQj73weTU4wN0dUeSjVzAIrUJ3X/7cnEWB
	oSIUSAktQ/7ppPMYOhwyF6kXTIpNoTT8YL+IbOHXYcz35Wjhj8QoTuTPuDbsK68F
	JujdmrZlQFgwlzkjiqIg5B+IIovOKavOwwPLyERwCRuz6bWD8EOt5s3NSkJ/8WON
	8hfivYx74s/k/pdIJ967Uj9kB+0CNb8Jx9ife7iRrjUKfrnyfWq91LKT7UwmLzbg
	ZCvhDfVDW8mCpH9sk3C/8rmGcSmqjQquNO3EyTysSYO0/AW1tSIfMbqM8GNP/Z/M
	CnlnDr3wlVpDkNs9+fti32rNBOkw8CohRfK82dt6uncgyrlbYXJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxk02v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:11:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GFoGlp000846;
	Mon, 16 Jun 2025 16:11:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh84emm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXJI483fMpcutTlYJBwMvAa0TesNS1mqrD2znNNpc8sEeXZMA0lcCtgNbU92hwFxWKCZo6t+fgenL3MwF40LOLRFQA1oFUas92A8VAmmmLx5YakenfGjXajW3jymvzIbyLyy1g14WimtecpZXe9I+Apm4MacvWpCm4xVro0PhIsJbrGD0L5yF1xv4lvwo1CJpZLOENkKG3LbZl0KrwoQPwo1PAmQWsCghXI/SNIvDL5BQoFybAt8F4ZRQW70Kfqi1yijCI9QSG4ZfsgYHXG7YjQAOsV8lzk0ObiJB9wHK4hS2A6DgD+6oDALJydDUujKaDt+SvQ545nmUlMfg7I89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5zlXe7LF5i2XubvbTd/FpjaP9cSxSRrPK4qcYSbnQA=;
 b=gt+uWXNoaLn6IxwkBL9tKg4FIWPAqnsbNnC8LaRWxuBa4uZzx8vDoasY0nB6L4cJZD9LupKuuzrE8IEw47q/FYcBvuHegciX5ipY4Gg4DcD1t6Dpk+t9RVvcOkD4XMTprlG45zFXfJ2Z0odvnClLFzrlRWzqxPbHePBlCu6C2VLdoSdj2rbI9+5v5Gzkxf9GXUUEktNA+o27oUxkJDXxHH/bDeluzXBUqieWm5sONS/Ptvs6D2KIt2cRiZF68NWBnPqOZMj/bzQEKO3z/43+TU9XKX645Thc5+k3gURoTySofyjFEswZ/uPkAc2TzdxPmsbXn/r1CL2ImPWf15fQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5zlXe7LF5i2XubvbTd/FpjaP9cSxSRrPK4qcYSbnQA=;
 b=GCHRKk7dm+sRWyo7U+hu8NK/zUC+ZEgEOeD7WRXB83ZZe2Tq6crwvIhMTa6WzBwy/G+jXwNwgu2znPl5fMWmGJzNqKeaCiMUUxcBcr2ieRp3aEdtBJ/7OOOzM7yBkfyLz2hdu9aJP3UH4PY0R1iAycD6V+01n9YjX5KLUuadW7Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8190.namprd10.prod.outlook.com (2603:10b6:208:501::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 16:11:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 16:11:27 +0000
Date: Mon, 16 Jun 2025 17:11:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH 0/6] selftests/mm: Fix false positives and skip
 unsupported tests
Message-ID: <55d74681-c5f0-48f0-848a-a062f37682de@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616160632.35250-1-aboorvad@linux.ibm.com>
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be0cfbf-9e93-435d-65b5-08ddacf072e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VF9RKVrfj/cnX0AvY3OD0AZ0PIeLMGxyhgETXdBKeM6I3W2LJbkyLfwTiVQT?=
 =?us-ascii?Q?F0rtFahf0kEK5exow7hmq8QD3cyQy8r925TVSKLPcetusKxZlQuWvi2Esfcg?=
 =?us-ascii?Q?TWXIEeMevRMVwmuMkCeRHFULlrSe7A6fpdQgkYjVcv1TOdqAcJNniCo3Q4Zu?=
 =?us-ascii?Q?2QcXOoCcSSljJe/a2P7wr+WAaol6LMvN8JRJ0aBsqsOcIiUwfIDWuALU7SsY?=
 =?us-ascii?Q?RH+i33KpliOPCFV8jorwOEYgnT95J7AJSN8WxiZu6/xHwUxXEtKcKTxpQajM?=
 =?us-ascii?Q?9dfOq1XrD1aOrglcv989w8uYKfCboDbCAgqkPaza3jj+aeBnhnQP6lwMaQwo?=
 =?us-ascii?Q?rCjdO3iaBfs5fUPkUY1oZ01OIdajOkIaCmipu3po3G1b0ofL7MmJKKcruJ7k?=
 =?us-ascii?Q?7EK9LCFZU2dljGR11TvDw8PgnsnSfia/7sco0LK24zkOMFM2TNuZU50KqtO2?=
 =?us-ascii?Q?F0CVJS4AFQpDQJ3g8muPD1d+sJJpRnRgHuj2NlwyW055CoxhdJlNSwiVxCHq?=
 =?us-ascii?Q?scCNgG7YIWSb2Nela0+1Xi37QFAOqL3y5JOMIACueURCZi7r/08DgIaBNKGD?=
 =?us-ascii?Q?rHwZaeU60RTVFRr/1Ad2XCLTx+iZIXyeXpNqjbxoPl85/3etLtPousKead6y?=
 =?us-ascii?Q?94MIXtsAtlZluHDL/vw4BZ1Gr91/hwhhLzploP3CPbRX6m/o9p6imN8LIRE1?=
 =?us-ascii?Q?S4/0lf0jhQHSc5tLHAiWrgHxMOvfW/grIRNbuSbZUIYz3GpQ4UYzeEcu89J6?=
 =?us-ascii?Q?lRZyTvpRREW7xrXZV096MyUblJMzidoMM3ffd+U8m0e8neFl3n5cYnW7PFYi?=
 =?us-ascii?Q?1gahugk36m0kF0Aj2EhD8hq9wLkuTUqepozNg5M8qLdBEA2Vhf+SVwJJ7kWW?=
 =?us-ascii?Q?yiGzu4xQUyNYBkP9NGKM4TKeSb2k0hZ8yNTCGMmY0ne46p5qhOhd/yxJ3Kx4?=
 =?us-ascii?Q?DFPLHkmTnHW1vryfsuFUmVsk+7b2juQkAV9LcHt4enSupF5aMNU9sVVGhStK?=
 =?us-ascii?Q?XErUxicKARjQZkoNoDYkdo5ilbeB2bB1ynS7uGRCZQq8ffmYQcCc2i0H6bKR?=
 =?us-ascii?Q?e6tKWN6A2f+/9azRSez3VuqvC0Df3Qg/c2Dowku0JGjKs0lFHnYp8X5X6KTz?=
 =?us-ascii?Q?Wj+JyVX31TLrCE3WVSNWETea78lr8GUVLujda2s6A+dxB8lNsznMaHvZ1SFU?=
 =?us-ascii?Q?Z6qtcTjxNQSO2GJFqjUl4m1C//AQzahDSPRW2WtguxIJ75POpr6gJSuHcmcF?=
 =?us-ascii?Q?Wy9H6JrJ8WRqqPIx9l5SItMwznbbz1KBQ2DmHEVGk8lDYNChXBuF2wghIcKJ?=
 =?us-ascii?Q?pe3fJWXqpqHZeMidNQ+2HQz4h0Xryz7QsLuNTMqJBTrOBHG6jvo3yHojOP1X?=
 =?us-ascii?Q?ZwWIa7lkAxsA28HdOcCuwx12u37P6f4Zf+oy3u3d8J6dmq5doA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVlZIo41oQ4Wm03q0h6N+vxnuCUPMBs+RijvukU+hqO0isP7gSt4FL4/Usrs?=
 =?us-ascii?Q?wb6JkiIj82eES277tGopATLHIS9Z/fP7sv/sM/0zTp3KgeswuUstPcTBwpoO?=
 =?us-ascii?Q?ByuZeHAuXUfTG/re9qB9Kv8uwoRrd14KeZiQ6JxXVFUsotiwKc4s3nGiFZYN?=
 =?us-ascii?Q?2i9qgy3PZrzwkSKXWEHNmObc305Apa2NAlyhYr/0xI3kc3gpfhbxfENYC4hi?=
 =?us-ascii?Q?XiYrA1Gbjl183mnLuycvpUQBJ1XoyWKWNy4id9rvrMW9C1YB0SWRpyB9oYd/?=
 =?us-ascii?Q?/Oka3z8LTmkwVOqWFhZAej9BwD2jOq2c2ra6m3L4e60bdFY7Ed8diVMsXeVJ?=
 =?us-ascii?Q?wk2jGPfCzMcJMZflqSyQSILhoU/tZ72Ne5H2rZbHuvoknyj/ZpmzjAEXVSdB?=
 =?us-ascii?Q?WdJTeMIC6WdNjj/8ShFSQ+2CWzSkm2V0rOqAFP0E7n3xEWyBp9YHBVkvO0nk?=
 =?us-ascii?Q?t/vrkG8LnesEVpWWMNBXlgIKugsK7OORTu/070D4I8k/8Y1pw9u9e5Kb8zzm?=
 =?us-ascii?Q?RBwfM6KX4GqVlJkdFt8/nncrzuPRD5esT2R9pMAWSM5oJ3ji1RgRq3EMUHqw?=
 =?us-ascii?Q?5YiWjVptedW345kbdYjUNKnPX3FUcDyFCnRkMsvZSul6bD0prLbyEYKoXhn5?=
 =?us-ascii?Q?VzQ4LLKL9oOEcoZ7ReK31/dmxgviUmTt9EPhTNQAu2REV5wKlDy6xaiMwBwo?=
 =?us-ascii?Q?ePNmlP9cM19ZL+dPND+Uw3mPNYiedAAXE5Q66lYjynDEz6noFHTZXnp/8QGj?=
 =?us-ascii?Q?FSEE3UnBH+JsEaxguIUBHcGYGpBPnkdhDcDOCm0mq8UoLs6UKgmPuHMcD32v?=
 =?us-ascii?Q?99M6XCSLKAAyD/QzIiGW6cf7qR6AXhP1W9DDBWWwZlct04Uf43TMm0GoBOvp?=
 =?us-ascii?Q?h8T2tYmKyFL7MeVhGESUx/Zfp6/tbshntLF/IAgkhSSURCNddslFoU1ukcec?=
 =?us-ascii?Q?H5PIkPMx3QLN7RTrwyrNFmEqezefpr6FL6x0Iso02qgqbBI6hc6N0BAlugWY?=
 =?us-ascii?Q?zK/v4d/7fgTAh/WG2q3xMiVToIi1lxIxufKn02+mLQ1G5EPz89asTxYNkgsg?=
 =?us-ascii?Q?cFOip87Ha3Va5ojtd1swCDo08I8xXTLQdItp9/42ug8cb/Zng6eEJfM60guM?=
 =?us-ascii?Q?VEP93RiXguK+LtRwwLBXLaQi2Do5/uw0ksNaBg8wGT1kBasHGEQGYa9crhZE?=
 =?us-ascii?Q?htISyMhGDj+Guz5hZzJGhkZ7z+ztKiD6OUJeSqs+69GwOXJXclxYmWArgaYB?=
 =?us-ascii?Q?TKfKpubdid9EBAfAOX0nXADLfwrZY5USP3BL9OmPIa0QCHIfVMDm/StZ5LXY?=
 =?us-ascii?Q?niCOchLUA8IE4fm3L0p7fQO2IH6F/6rKxHtSFblqXxsbI3GwdcT0ZuUnqrtj?=
 =?us-ascii?Q?hI59BV1AHXocE3J8z9LXb3smAvhqHq4L4oJnd8dC2CbLge3hGof7h1wfER9l?=
 =?us-ascii?Q?tPIOpQLWWyR8kyN5Loe9R6Z2TjUYpX9WPgSk6VRrIcQ2ToIkRQwybVqve6Nl?=
 =?us-ascii?Q?+DcuPwN5W8X73wXSeOfH+dIkIt1YvpNPzID99tJqZfGo0Aj3pThHqeiJMphg?=
 =?us-ascii?Q?dq/j27R1bOdthUSxAlr3L7FPXdH0rd8cTFEfhuOTcg7CuRB59UgqfPGzNzCa?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcjBi87BdOogjhH19cqq7eXLVQHtU+9SDXSkGWqelyP90nKPLNcNEBfsiosE+eaefJUebhZKtxkLYMfnuyxDe4OWGE0ZoLJpd2VoOn0cm+huINzoPS8foH+659C1fcoL6QEukhf+HOIuRUKXNCH2CbYG5viL9Lzf3m78z5C4w/RRjD7EcYKCx1hUr6xWhU7Oc7QbkFiSUect/NQ/DoEqSXuGLNmalNVPVzYiUY6IonKl7JtiPdlHQd1bmfacLo5eNd7OvsNL/FFtK+bDE/YD2ycSW/k+6fooy0UA9/vK4wWMtPHJPAXjRcmsMcP83WzRPo4WKs19JkqGZf6Jzt8Od4kSQHY4Ey1bRovi5eUa8t6v1cJvraF1Ps7wnGJ3rDBPwgLxgELzp6DqcOiRBXaL9904ze9lOGCFVdE9VHg4WJwsGpPeS2SCobnX62Bdqr4r9nK79OXUtklToibRtwvST5gY7VqA/yMyO/37frL9Zj51F09r+G432t1Am4O7Yuc0KgiAwR7UpUDpnp5huvqphNi2U7RPsVzZQPLewq6+BRza+q0z4CFkAIiVyvuQo38INKnAJ6tppfAilcg1IlaH09+39efTj0AxBKYR3GSJCY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be0cfbf-9e93-435d-65b5-08ddacf072e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:11:27.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6J3TjeTB71nqWu0aKZxpoOqiM7QPl27aW+uuxHGsdQLFL4XD2EDIunIIC87gR6xNGreVgG1JTUm5EZJjKU4ypFfcGzv775f8BXncBvm0lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwNSBTYWx0ZWRfX8fteJ73SfPcT +PHe54q5LFTThZfwKCGVHqo7ju4DwQJOeXg5CGvR+xcHM4C2sYEw9n+1YRyQ0XxsMe5uTq2lej+ Q9H6xYxs5RNF29x3b+PJDCWQw5BZhWUQ3NgjY50UdH2Fw0X1OZjHd9Y83m7Bv44NsmqzGeg3fU2
 lUfKR4UoZTTFIxHty2jQpoTYo8lTvKoUOLTfZQfTs3yoQ77qgqVJfpAUqA1KqAaZDZLTus9wqWK LdMxGLY1539ZmJDWln8gYRhjZyKxZKJGUjiOE+6VePTVGR2C7f7qt7EF+kIgMk+optjjFfniA4g pNHyWQ19I1W87ni63s3oLWB16G/iC3QWtRgUI5lMMSmRMlWwWEIL9wBRKhxvCB8kxBW68gBSMKP
 yAwL8IjrGKXF7GjPK+YpO3yf+lL+qvBvRO9kFcUSTMq6OunDQhsALZi/+aINzwvIyY0ilFiW
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=68504234 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=-95aJnM4ZrDioTBrZlIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: VNIXtgmsxgVNe2nR_IOwjITfSMPcR2ly
X-Proofpoint-ORIG-GUID: VNIXtgmsxgVNe2nR_IOwjITfSMPcR2ly

Hi Aboorva,

It's (highly!) forgivable as things have changed fairly recently, but the
tippy tip of mm development is now done in the mm-new branch, against which
this series doesn't apply.

I thought this might be the case, as there is a series I implemented there
that changes the split huge page tests (possibly affecting more), hence me
checking!

So you'll need to rebase against mm-new, unfortunately!

Thanks, Lorenzo

On Mon, Jun 16, 2025 at 09:36:26PM +0530, Aboorva Devarajan wrote:
> This patch series fixes some of the false positives in generic
> mm selftests and skips tests that cannot run correctly due to
> missing features or system limitations.
>
> Please let us know if you have any feedback.
>
> Thanks,
> Aboorva
>
> Aboorva Devarajan (2):
>   selftests/mm: Fix child process exit codes in KSM tests
>   selftests/mm: Mark thuge-gen as skipped if shmmax is too small or no
>     1G pages
>
> Donet Tom (4):
>   mm/selftests: Fix virtual_address_range test issues.
>   selftest/mm: Fix ksm_funtional_test failures
>   selftests/mm : fix test_prctl_fork_exec failure
>   mm/selftests: Fix split_huge_page_test failure on systems with 64KB
>     page size
>
>  .../selftests/mm/ksm_functional_tests.c       | 24 +++++++++++++------
>  .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++----
>  tools/testing/selftests/mm/thuge-gen.c        | 11 +++++----
>  .../selftests/mm/virtual_address_range.c      | 14 +++--------
>  4 files changed, 45 insertions(+), 27 deletions(-)
>
> --
> 2.43.5
>

