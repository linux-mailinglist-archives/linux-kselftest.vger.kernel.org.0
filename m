Return-Path: <linux-kselftest+bounces-28081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9377A4C8C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EB8163371
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39824E4B3;
	Mon,  3 Mar 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fSTF4Eb+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HpMtkRbm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D62206AF;
	Mon,  3 Mar 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020286; cv=fail; b=kFFGOZL+QQdpU2tPXjk+E5GVQ3gsdste1YV5sUr0cZlrglkErLq0j6MMrQ08tG0y+zNusARY5OihbAp6MV9+7OrGfX1fq9aEVwkrEOKKDIeU748Q3f8xlsFKKbkTrvTlhwhx6411tFc5a0DRM+YONnBL6EIz+MvqVMhtBcbvZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020286; c=relaxed/simple;
	bh=kIVbmaRy79wVwKk3F3mkacb8PWMl3QS1CEkJWAwPv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GkfAF43dPg0PNBOWFBJu7U7/X5wnKDMRCI8QfjV8OKbOhvyzx3mHa/sf0tnraH+aodQZAaIcbJrv7/m44gYKrgulJcEPRiBbh8NIHb2dKF9oDB8u3QU+HWwqt/gYvcz3FQxC1V9Ha+1s/tTU22ML6IWIohBDQRNvcHSQkD1zcS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fSTF4Eb+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HpMtkRbm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GAhLh009352;
	Mon, 3 Mar 2025 16:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SvzatOsSswobadSAvQ
	Ecl9GvVvYuhHn3jX5jv6WRZ1Y=; b=fSTF4Eb+hOKKP4IY2Ia35YVbMujfgLqeyx
	SO5DBqzTxGENQEGve+6MFS1XVdMLbs0XRnEe7XAly91gtuRaKeC8V1CLaT8Qrnpk
	rEcSkbDKRTg/dxc6QkDu8k6o/GeZflZaKHH6QuLTpZU3sIAqdFhHdlFIWAE0RjfP
	8llGSA8feLhUcWnI51hyqosxmZOzsDksKapNM8HUvea4e/6IlW4jRxK36EBE+xzy
	RElFukpeBQvVtPxf1MZJs1mLAYcyt4djE23vqT+AA4smYrLh9uXnyYbjmFVtshU/
	+CLBKQu0JlTk2UiIIUiudjF19o7zRqV/dunkgq0BEaUaNSAiR1XA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wk2v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:43:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GhRdv039109;
	Mon, 3 Mar 2025 16:43:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8f1mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRSsdBEjbMLig7eVPELpz/3gHnR2n58IE5I7uMZj+01I90yqfVgC4/YPBh0hQPv3f9KEYSgio/7OmpYBq9M1O1TVh+xeccn5eW6dQ5LdL/UQUubP/OJPFfDwYNJcNnRdhsUMY2hmrkK8gtlLPw743Us8GnOS1+JTMUeV9QTJ5MbqNk99R1Nnm/ZAucdAFdlOl1THNKs8M00oNLqiyYx5UjIOkt/9SlObgJ4KuC7gtN7H/KnK30wvI6ywjDGkrZcJjqSYxAnkoGcEsz9bnkUYvcgFm7fsz+SkD5rfEKsrfawyGfSsCT1ZWzj6wUInUdvVtW7djSIMsbfWgecvOs2FRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvzatOsSswobadSAvQEcl9GvVvYuhHn3jX5jv6WRZ1Y=;
 b=xlAde5ebfRDHxOZALa1PEpjLoz/NE+wrT2RlA+vllNy4shpXbGx7BStziP5BeIyw9CTSR3a0/wKJe2YdOYDdjCatpQNiYm7rAQ+kJ0iIUAQ568VvwguXPIGphc+utpQLzLUzerwSR7xAlalnK0yc/wPMWaJSPIPIoxgYp0swvpSXC/UvvxuvJ6Rd7qnxUwoJQuex5t2uqI3oWSMS2WshLJg8alFKp113faLGvg41HmhrvsZbyR96ETb8Qq5659xTnRKYZnKdKx1DaXXLQ/Shm12nscyC8bqDUsKe6wdtXdgZ6v6Sasouox+UxFQQiuHuuRuwCNDFezJoFXfCimLBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvzatOsSswobadSAvQEcl9GvVvYuhHn3jX5jv6WRZ1Y=;
 b=HpMtkRbmkIxCgwG+nhYZ5XbI12sJq0TYqKZpE/Eie9rthCglDdPhkIs07TsewkJMbWX2jDUiBQccaaYuHQEARRtF14USH2WX2CHBuI6ttQcXkJbkL9NgrWpeWwAyBeGhgieYLvPIxu47xCAKHRDiMNmWoqHW5WygG+vot9XIPj4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB7834.namprd10.prod.outlook.com (2603:10b6:610:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 16:43:49 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:43:49 +0000
Date: Mon, 3 Mar 2025 16:43:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
Message-ID: <8285bc26-6afe-4141-ad1a-6d8c5d6d76f9@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
 <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
X-ClientProxiedBy: LO4P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be043d8-39bb-4394-bd08-08dd5a7292c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cs3CyqnUGxikNnBB4ajWrjYp12zjgbq3NNCGyvnliWzVtP0FCas8RUMcGGKP?=
 =?us-ascii?Q?/yRdAQ++mDgSOlkq/9hlW28VtAEZTTa2jZEavZhuuLTe33XDTUFtUg+Yb+O5?=
 =?us-ascii?Q?byvk6e6G/5RUIiVefesGMMe7YobldapeZq10lTK2gn3vyu4n45lygUThkCe/?=
 =?us-ascii?Q?Zmov4obRf++6GVUG1bJpR/JtmiBme3LpfRNj3Johk6xE7YKfqtBKcy5Re0sV?=
 =?us-ascii?Q?yGQb9Kl5QAUCXVZNvA8gM91UgM5p86bz3DBLOjoyxp6VxRuFY5XBcUeHC5Ln?=
 =?us-ascii?Q?jJbZUo/1+G7XWPCrXeZmcRoN/EzOvbSRGG1pk3Kzo5TLA0JinOyFbkdNxxuG?=
 =?us-ascii?Q?cdXvcx0oJWfCFtot2i4kObHmVwRxdWX5hKUqlNQJb8vUBF5HuZQFAWLqZw/V?=
 =?us-ascii?Q?XCq4S0c50PIK/L29wkzc+zPgjgY2rscK4PwxQ5TNZtBirtN7t5StUcdi4E6X?=
 =?us-ascii?Q?/B2k575X7Zk00rwiysDeZH8g/c0QydZotCiCUl4fjGTF6qeZfLwQt6FDSuqk?=
 =?us-ascii?Q?6tMDc7xPDZ3UlQQIDiPVorfPoo0qqNN2QM7xbxvjDuOh9e7O2kY+FxrExYk0?=
 =?us-ascii?Q?WBrfZUMRHuNDluJkpr6fVMqWUQEU3Sm6pTngFQzJzEo4WN4euNCq2DODUJ/z?=
 =?us-ascii?Q?tFa4AZ+qzAF0Kg0xDBguboCI3skx646dbnYNKTLxL45qxwYMEahcmgmm8kAX?=
 =?us-ascii?Q?BDMwRTq1e+GcVI9j2xiqcJXj69lInwaEFMkwmsoyEXCxcj33/rd4ELmrX880?=
 =?us-ascii?Q?LOHcxTUntMucBv3WXPOssN1w8nXZaUye2sA/iu0PHLEjZ33ku0M9/xdEIeEC?=
 =?us-ascii?Q?uYLanHTNT+30cq/urvXaFb6mo7Q9Wv1BzX0GonmZbLKwtaITgc4kOBYVuK2d?=
 =?us-ascii?Q?XBSyIplZXDqtw/E5Qu8e2E6OGlZ2o1fZmFVPcHvKqwcJv9ykDngdk+xuKk/W?=
 =?us-ascii?Q?QgA3G2NrUjD/cTLTRi0IHe44+vq6DNwn8QwASTBiiUINUviQ3aXgqVeXMTYB?=
 =?us-ascii?Q?JyYgYsdWTOYlyCk/oT/nyvxwJhsoi/7KNK/xRPGVZBHTCMMEZ631Hr89KHzj?=
 =?us-ascii?Q?ER4JHbRHz9datCPvNjV7kk/P0JRENtCW9YMVh5fMFZJgbanYwfVm87qjSdyZ?=
 =?us-ascii?Q?EpCH+l0pR13INRQDnUdWLv/mKaXCa7pUjKgE7PcEotBirEIftPnVFxMEsw7o?=
 =?us-ascii?Q?Mq6xSv/fH5XFCsN5uUqrLTt4LOz0vFQRUxDVhgI0e9htWSQNVxHuC/elninr?=
 =?us-ascii?Q?J8T5yMMkaGc+xGrNFyt/U7AC71/4YxYzxMiOi3NXtOv3PN6b4XzDmCvL5LwA?=
 =?us-ascii?Q?z3hyo58GsYfqnNXzHIgoIG8YGV/nvAQ66qcfJLOqt8J72csy9OzuhSRxaTOc?=
 =?us-ascii?Q?IMOgbrUxwM/WRC+TVE2P1JH9hHs8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UFSd/4oPOlqC0Q1FSen9vSG8Cv+0v4CNq9B/d37PA4yhv8Stu0u2WntTgMy?=
 =?us-ascii?Q?7REPFTqrYvzDQA3bySNwGIWylaMNMiNWqFrgnbHCE97tCHT8RWWQBMGOMihD?=
 =?us-ascii?Q?zd0fV0alvhyTnOhjex9X+G/XszPpTvkRoRL8KNQsW7aG2s5nIQgYNG+aPiov?=
 =?us-ascii?Q?0c/OC8CHnn3HcBWAS9IItKah3bdn3rKbyopVkjguyDoQiVsdhsDp65IapY3n?=
 =?us-ascii?Q?i6c1ru6SdrVPQIPETS3R+MYu0YK8xE8wjOQF1/x6ou69pkyXmBGlRQzGi7Vo?=
 =?us-ascii?Q?QOT3r41pJ/XQ54DDSW6yW5EBcNKZAfnJ07sEzfrIFaEL7018RF04Blk+iAgZ?=
 =?us-ascii?Q?fNlg7qu//kL2VIjI44SRv5YWNScSkCczqaOIOf+8LZ3taVBJebYzENpFHd1k?=
 =?us-ascii?Q?LwRMqSulDZTb4GSq5pJgVnt5Sbe9M44sDkdJGwtmLVdfnACm9b6CbSiYmPtf?=
 =?us-ascii?Q?wCBxcdYu419bl4uJ836puBASqzCRu+nECdT4QmOKlbAYqkOaTATMArqQKjqo?=
 =?us-ascii?Q?2VynuZ0LFkmiOx2lPwgIgNSUaSB+3yHmQO7Fvu8rMutR9azEBfczt843/fhY?=
 =?us-ascii?Q?YHczA0uRc11i36A4vBGwcVsSaow5XV3YMY3HxmErKUPG2ogatbyKIW9rpL7+?=
 =?us-ascii?Q?nHHPVTTX95E2R1ns4niXBWaMkbWtntExRapLhpzn+R3m5Wwc0c8Bd/waPQOg?=
 =?us-ascii?Q?rHryO6IL7Xei1PawnDugyoAfjjDuaCOsMwH72/tK46p9YSoM54bpmKxSKVKR?=
 =?us-ascii?Q?PPpGmsvgA1GsLlDA5rfTyqK1+FudzpUE571J1y3dF62pG5Cqqf9gXz037Z4B?=
 =?us-ascii?Q?CG2rDLTCsMvifwzmbazBXdUj6ldTzdHk8JlR9Md+WdVMVvku38dQIBm9vTpP?=
 =?us-ascii?Q?5QxybkjSn8pg9mOhNdVaLnXIEVZsM94mKNMwu6B87eiMyXQxCdy2EHru2Rp+?=
 =?us-ascii?Q?+VVJ0jMP/NUNx09udNKWJxJUuNYta19Kb1OEYGNXF0uCCJqDCSFlPBCAcjGH?=
 =?us-ascii?Q?Ll07fNbnZyxTV1yICd5V+SVvooQ7MYQXwzoP/YN8fi8i4oBAU5QOy0EPrYKO?=
 =?us-ascii?Q?0NqysYtIy9YmraumWtxsC1llp2ECw0BkVhV6R3JcYsyE531z6nP1B1OceBop?=
 =?us-ascii?Q?n+DgGv0YN0+RDS2pJiefHpLutqXBjHLUh240LFvQX6F8qQD9guW9MQUxKj4B?=
 =?us-ascii?Q?vvaahNdaQhQaD+0HYNiKah80ZYbmndYBbwbvMsj29hMsOt5qqX/oe3vpG9NE?=
 =?us-ascii?Q?ip70UxbaejIWpFKRA7/Gf/CzenzwLJnPtFDy/ZFEoJiQxshM4vmeggCYvp2Z?=
 =?us-ascii?Q?Q3ZPRPtDxMdKdWHu0tWxZfeuAH15hve4qm1bUIMdapZrLEFL0QRQPrbnA9aD?=
 =?us-ascii?Q?yf0Ff0W4HTkm3fsJFpuauGTVjU5gEmdKIjAySvQG+iRtgrgADxRZAbRGOY+6?=
 =?us-ascii?Q?t8zg51/NDyjQrV02JFcub1IrE8R94BCHDuCsCcG69Jv9OssMKqN0JRBklM4h?=
 =?us-ascii?Q?C9TsZbxYWquHlvbvIiBHejVegE+9UkZ4NNR8fEbr30Q00AHKjHwwHA3hhZoT?=
 =?us-ascii?Q?PVQM4L17lKcxyOuEdgChZztxsTW5wECthybdXsPAp62sN8JxbyXzVFe2AQUm?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kCcEu6OiZZ/wiafMbCQCSWyXuiqDNFQAGTuBAiCJuXGKgnKP5Nm87n76u1wnstTEo5xaDgY+dZnAnNWv7/NR6Mt9vh5f/q1zfze9LhCC8NOdmwB/yglic8FhK0Sc1LlhyN6iqUByfa+bvg4uzcjjDD96PPJNbo4eb8iFHajM2QWJozQgiPgCY21SxYdlrEoc529y5nDcKlZvQGwrypcT1MfFvkVGrrIwMU4Z+H6XHcijb5cZwvhC34asN3OiHLj08pwX2IkPC02URXNXqGqnEcj9SrRGF8n+QlnHqsoRe2vv6c9VfxhQ3vvInsJvR9PFrdl7l6Ml/0gwpS9VXti3eRDY/c+QnbU4ta99bWIdRk/X5LyjT5kpETP8POpdMYCkyATSWBWWo2Ppg4ibEXyC1Y69s/UHTP+vI+Gj/XWjzo7l68kGX5xJ/VzpvMwjs7ASwM9X5eVRBudYz7JHuKKJaqdX4D/XJkv3pvtRmOSByT4iBjCQx6NAfsYxLWLDiZ/R3PMJPL7pDlOEjVNGSbYCjVYqM6JqPpjQpZrRFii1muioyD2xoDIhVMgUf5gFs+0DjPe2C0yfpYgv8Ia2nDc58ZG/xP5pBiUX3v319DJ8Oa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be043d8-39bb-4394-bd08-08dd5a7292c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:43:49.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9++PLMLReRPLq4t2gyyW2YTStKMB5LIUqCPlpgjrix/ssqAE6eTkRbc+M5mjHE9ZnpXNbEET2boFsS438Pfgak7eLjTmBWjT0HCwKoldM8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030128
X-Proofpoint-ORIG-GUID: rSgYhHbfvzRqFLHNDgOdA2zyGJov5SDd
X-Proofpoint-GUID: rSgYhHbfvzRqFLHNDgOdA2zyGJov5SDd

On Mon, Mar 03, 2025 at 12:08:49PM +0000, Lorenzo Stoakes wrote:
>
> On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add sysmap_is_sealed.c to test system mappings are sealed.
> >
> > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > config file.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> We do need to add this to the general selftests Makefile, but this code is
> fine, so have a:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Congratulations! :) and thanks for addressing the issues that were raised,
> appreciate your efforts on this.
>
> Maybe you could send a fix patch? As it's such a small fix.
>
> Cheers, Lorenzo
>
>
> > ---
> >  .../mseal_system_mappings/.gitignore          |   2 +
> >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> >  .../selftests/mseal_system_mappings/config    |   1 +
> >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
>
> Can you add this to tools/testing/selftests/Makefile? I _think_ adding:
>
> TARGETS += mm
>
> Should do it. Thanks!

Obviously I meant to say:

	TARGETS += mseal_system_mappings

Doh! :)

>
> >  4 files changed, 122 insertions(+)
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
> >  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> >
> > diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > new file mode 100644
> > index 000000000000..319c497a595e
> > --- /dev/null
> > +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +sysmap_is_sealed
> > diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
> > new file mode 100644
> > index 000000000000..2b4504e2f52f
> > --- /dev/null
> > +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
> > +
> > +TEST_GEN_PROGS := sysmap_is_sealed
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
> > new file mode 100644
> > index 000000000000..675cb9f37b86
> > --- /dev/null
> > +++ b/tools/testing/selftests/mseal_system_mappings/config
> > @@ -0,0 +1 @@
> > +CONFIG_MSEAL_SYSTEM_MAPPINGS=y
> > diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > new file mode 100644
> > index 000000000000..c1e93794a58b
> > --- /dev/null
> > +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * test system mappings are sealed when
> > + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <stdbool.h>
> > +
> > +#include "../kselftest.h"
> > +#include "../kselftest_harness.h"
> > +
> > +#define VDSO_NAME "[vdso]"
> > +#define VVAR_NAME "[vvar]"
> > +#define VVAR_VCLOCK_NAME "[vvar_vclock]"
> > +#define UPROBES_NAME "[uprobes]"
> > +#define SIGPAGE_NAME "[sigpage]"
> > +#define VECTORS_NAME "[vectors]"
> > +
> > +#define VMFLAGS "VmFlags:"
> > +#define MSEAL_FLAGS "sl"
> > +#define MAX_LINE_LEN 512
> > +
> > +bool has_mapping(char *name, FILE *maps)
> > +{
> > +	char line[MAX_LINE_LEN];
> > +
> > +	while (fgets(line, sizeof(line), maps)) {
> > +		if (strstr(line, name))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +bool mapping_is_sealed(char *name, FILE *maps)
> > +{
> > +	char line[MAX_LINE_LEN];
> > +
> > +	while (fgets(line, sizeof(line), maps)) {
> > +		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> > +			if (strstr(line, MSEAL_FLAGS))
> > +				return true;
> > +
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +FIXTURE(basic) {
> > +	FILE *maps;
> > +};
> > +
> > +FIXTURE_SETUP(basic)
> > +{
> > +	self->maps = fopen("/proc/self/smaps", "r");
> > +	if (!self->maps)
> > +		SKIP(return, "Could not open /proc/self/smap, errno=%d",
> > +			errno);
> > +};
> > +
> > +FIXTURE_TEARDOWN(basic)
> > +{
> > +	if (self->maps)
> > +		fclose(self->maps);
> > +};
> > +
> > +FIXTURE_VARIANT(basic)
> > +{
> > +	char *name;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, vdso) {
> > +	.name = VDSO_NAME,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, vvar) {
> > +	.name = VVAR_NAME,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> > +	.name = VVAR_VCLOCK_NAME,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, sigpage) {
> > +	.name = SIGPAGE_NAME,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, vectors) {
> > +	.name = VECTORS_NAME,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, uprobes) {
> > +	.name = UPROBES_NAME,
> > +};
> > +
> > +TEST_F(basic, is_sealed)
> > +{
> > +	if (!has_mapping(variant->name, self->maps)) {
> > +		SKIP(return, "could not found the mapping, %s",
> > +			variant->name);
> > +	}
> > +
> > +	EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
> > +};
> > +
> > +TEST_HARNESS_MAIN
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

