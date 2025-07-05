Return-Path: <linux-kselftest+bounces-36644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD2AFA16E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1031BC3C61
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B1202969;
	Sat,  5 Jul 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Axeuphh3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DQde7cPd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42012E36E6;
	Sat,  5 Jul 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744012; cv=fail; b=o4ON/8y71oBmMvdJ0RD6LpPYwPfl43JI1zpwiPtYB6lFL+AVGeUyKXB4PMh4b7ENZh9LVKcsAQpcAg6+LaqU2JnM31JesZ9fHNzAGs2JhwjSUGCiOCx+HYfsANNfQlqeWhfB9zL4rfsr+tgDS1vILuzmaSQXprHGoYqIM0zoQOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744012; c=relaxed/simple;
	bh=JqSvUTkJZXo/pa/1FwKOlp+bpD4ZOCELwq80u49bxdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahJ0PJQBY82Wzo4w5xBjEQYxVucsz8QhPeIt6ObdZFA0mGwRG22UwAqd5phDy+EDIEUFBUfHuy4zXs71s4UNIM7jB+kfQjIAiufbnuYpM027+IM+oNKsGHgEWbCF5Ext4Wif0tU7ehmcmVizKA2Qu7wcazspkj6+R0LikHJBsLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Axeuphh3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DQde7cPd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 565IewQm014369;
	Sat, 5 Jul 2025 19:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GV3saY7Fz4KAQs89da
	T0YTZlxoJikn5yX+PXmSESW7M=; b=Axeuphh3OAKHWS+eo2gFzA40/+YCNQBz25
	cHFtsDVagUD9i2JSAeSBfJsVbCY24OsfDlnx0nggZ5m6kNf/+evsCHMU0ZvZ/Bm6
	oDqskGyH9a8XEGcr/VJd4Aq5cTu5zBIUG+rplYxJ4lfCfXB14zeF8gl6Mq1i8wSY
	GABBJWBvDxuCdShIPF3PTxyKCSfVLjDIsTuKDoHyg0b3lrhSR3eO1LWFFZFnXha9
	uUWaU66DLaPk9NCiEwkNjLSDnO3ONlwnozc5YrVZuGkfucaUY2vJ4YnHp8fHcbQD
	o0UN6E72jf2xrzTK9J+tM7+FTWOXEMEnbaWHxHcoqDpBqHeHRhWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptfjrgrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Jul 2025 19:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 565GbDaN021542;
	Sat, 5 Jul 2025 19:32:46 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg6wtr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Jul 2025 19:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTavLzkkuJZGXncWk/L+AJSNTv8lG5yylBJSq1xkqnFDMX1vTwmwGdXQmO18TzUQEoaveM74vHplJe3ALAyV3jvqD9/79xMPXbrJpYIXWfr7M5ZP9DCx5EFYsUg7XATN5Rrn0jAunTK6yAl69LEANyC6wkZCpEdhF+ov8WIMclTJw8oVny8GtEiTNZm2MGTknDZUrnaJqVonF4kMQekRz/kVjKsNl8U+O18CS/oZRQFnro6TiS3DQjTRW/J+NGx4kuz3Ryrb4jLrKUW7SaqBrFqT3IIqcp4XIBV6DsUA6aDKg5JLp/mmMyhocwWc94DJQ0QCkON4CC1fk+vfJPzJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV3saY7Fz4KAQs89daT0YTZlxoJikn5yX+PXmSESW7M=;
 b=D76vaKggZg9BPyQkgqC5nwxmRknf6UjR5zvbPaUvLMRqbhCsJJyzEqP3sxgkie4vOKUxPW+ewBcf8gnFjQHyvVWB9bFrVSvDZEOFE3DE23RbE0yo2NuxtHxcnrZOhDe3deDVC+zNyQlxk59NXGLbor6/ROJLE8X1KoFAJT9Rx0GQRlg5nnqkFoe18uLFnFpbFnDMtQkxp5qtco2NdyLHxz4oBzsxD3mPPCOSK3SmNACaqT2cQ+3XgRj7isGdO0npov90mYsoegi0SYUq+8Xave6assWTxaKRZo9TOvGqHtjG3OkVFHBH3EFgauyf5H3+L8520ylQzxmawzi7UbOuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV3saY7Fz4KAQs89daT0YTZlxoJikn5yX+PXmSESW7M=;
 b=DQde7cPdNNJgYRWd2tTTfMTO+kITiDpOnR0MsQPgHl+yLkDJM/M5Yo2dV8EP71FWQcSVqylG1Qn27EwDUrJtCCEB7KwShMFi+yw8Svtk08sFUQJAsPaoG+QDOqz2fjbq5qWEtaSBaN7brefYLJorH6fCxMuqydry9YaZVM6oNPM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 19:32:38 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Sat, 5 Jul 2025
 19:32:38 +0000
Date: Sat, 5 Jul 2025 20:32:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: david@redhat.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        sj@kernel.org, Liam.Howlett@oracle.com, brauner@kernel.org,
        gkwang@linx-info.com, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, p1ucky0923@gmail.com,
        ryncsn@gmail.com, shuah@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Message-ID: <f1975f98-dbe2-4606-8a59-8ea94169ea44@lucifer.local>
References: <20250703044326.65061-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703044326.65061-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e0cd7a-29ac-4654-4c20-08ddbbfab395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJIqI1bAGwYxJBUvtvrc1P9wStgRIr3/0WO9I65C094FcaPKXOrOjB1ZFsQK?=
 =?us-ascii?Q?KLXp6vnSzrQ383cxxh5tRphwpPacKh3vxaKFKftGnUtUf3EC0iJsdahDTiVR?=
 =?us-ascii?Q?2aSIRr1QRC0I5mPD9vsaaHMKWCU1g00ULjg9/G6PoGBCHLGCOL9oq8gqJYtX?=
 =?us-ascii?Q?EU72kjhv6xURQzXEyxxg8EHeWMMe1O0xdoIzRpfxK/7r15Px2SxKg8cPBNIB?=
 =?us-ascii?Q?rs+TXuTFl0m2hGA6hxibDOnEPeBX0xXMm9v+QiI08ZO/+Oo1bBJtFyFtdKUi?=
 =?us-ascii?Q?zo9Mu/1HvX+uM/031Wj++uQGTb4YcIsT2Ybr3DZFViplRXPlKxI7Uauz2uX7?=
 =?us-ascii?Q?ccjq3eekeJ7tDwR1km248pvhG4dWgKhRKklOfYzqoaRGInF7JZru1/BKs8XC?=
 =?us-ascii?Q?zKP5kPVoYTj+OiyNIdNjVoHwOK82h6hjdAvamMlxFjc0j0CoPVdfBAXl8uDj?=
 =?us-ascii?Q?FLU/TIVuM6YBIn5EAlj2BAgZzZpT+V9T223t+DqbBTBpUPF/UCPQ+1QYFGuO?=
 =?us-ascii?Q?w6ZpZLwyRRfL9VDXidXNUe28z3AdYgEc0Z/9xHtdsI2mU335owHx8CmP/yt7?=
 =?us-ascii?Q?K+Cm7xFmD3yF4obAe2LZyP41/Fd3BDtVLMJ6YNRazNgLIgRxNU9B8rVlSBWT?=
 =?us-ascii?Q?sSYIc3pgVLm4oR+8Pq9TxWX/kbIGXksUOprwQdjuGWrOo8U1extd0uzCptSx?=
 =?us-ascii?Q?Kzxz4lRRJZZgVz714F1FA2Uo7jN+1tg+Yy3RQgKzptOBoS3OcyFyomKsUJXA?=
 =?us-ascii?Q?l3lUEwOoXoC0jMR3g5mrI10T5+fGxMx0z5gTHQ5/m52reSKkhxWoS2i7uY17?=
 =?us-ascii?Q?xRJjzNS8B4Ve4B5iZtPrLBQpq+EC+bqDDw7TiMFK98xGhsGyNxkHl52YiFIg?=
 =?us-ascii?Q?ft929pF4XHdRKtGuzIiVpevqTjsgmay9Q7iJfcmn7fTnABaMFYao3+xf9fqQ?=
 =?us-ascii?Q?S7Gj0zYwIx8HvvmIIIVSfLUayRAPtn3myfdnmQ6siRn5nVxNCiN7TZSHjtGp?=
 =?us-ascii?Q?Uwrmab8OfF31vM9aC8/6Rno3SExG5rRNmoEYAupbFYLqChM41cb2Nap+Leag?=
 =?us-ascii?Q?mL9egyCGJ/xmQ3D/TcR5LalhlxGRluqvsqdNL8yh2xuWgYKFrEoiElFxevVm?=
 =?us-ascii?Q?gaC1xMBMbp15mEafY6Qqyv9vRlgR+oGDAO6SBONPavs9XRPbkphB5kN+KSYd?=
 =?us-ascii?Q?+bHZxURYn+ZztuEndMxPZVEVA6+1sfUO3NNjyXdkjvZOB6qb7XCfVAFRGCpF?=
 =?us-ascii?Q?1+M3RDhnGvQkvvq0nHEKNEPC+oxeycP1IQTxxD4Onn0hjbepCBT3tCHIsUje?=
 =?us-ascii?Q?W4Zr46unnx7uvmxz1+jSdHYGDP/5qyMHiJT+Arurf8rx+Y5Zc9W9RT3g3m/K?=
 =?us-ascii?Q?QazGfmn57VE3zH7P73LVNGhGZ/tCSDEfKgBISoTe53vY1B5mQCGfOcRn3JcP?=
 =?us-ascii?Q?WkGX95G+Je8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuJuzbtKgpBcMZ7/p1RphhwqQ90ncYBnkzJxnbTdLLbuSxx7L1CfVbNK+aGm?=
 =?us-ascii?Q?JXl8NGj3nzBSD5QJ4GFwsY4IKzbGS8wl6/2RPw5ksz18dWKcXmts6x62z5Zv?=
 =?us-ascii?Q?TibIMgcNIg2fpp1wjAwIj7Dr4MQygGmIGKhMkR+LkAEcEMdsxHEQedLolkzs?=
 =?us-ascii?Q?bqt1aTFOyUpb17Dy5FIGHjWbwLPKjGQwO/vvkJ9KfVqAyVd5bzkFoCQ2lMsH?=
 =?us-ascii?Q?FftV+4PLfmulZOTf85ZlEXz5wvEkAQDMoOLJViYMZdmWyM+P+HT7j3igxSxQ?=
 =?us-ascii?Q?UdFVdiNtkE5n7Zfca059VCmyJO+rht1wrOsD9K29nzqTuGdlQMMnfpO8Ya0W?=
 =?us-ascii?Q?ooZ2/6A86C/gwULOzj6wVD6Qvu7trXoGf5aiDiGXuYYB3Tdb32kEpSPFKc0n?=
 =?us-ascii?Q?ylZg3N/gUahtl2KTSlAlGPal4gd99xL+37RWE6gmwmobFGtG+3Xl9zrbtAmc?=
 =?us-ascii?Q?VfrEtnkAgHVEN2DobdNtOrQcGEPD3X4ug9pX9vfUnF26ZdvA+YCmULnYrJsO?=
 =?us-ascii?Q?f0QH6FwdGdC9FqjH4sBNWXkCI5PrIGyGRvzQ/V5ChxkVDjPClNxj8EKtZUDN?=
 =?us-ascii?Q?1ket1tU99xquxIa+NusN2fbsQ1W6er/i0oZ4D/slDpqakwpP4y0prC/MB2Ys?=
 =?us-ascii?Q?+vzbOeNrcEVZkIhJuysOopQCC0XKMM56ELcZn33UUmlHr37rwFUe4Nb9XPJ1?=
 =?us-ascii?Q?u2bATaRMv0L/B4E1fBQTA0pvSnvrDfQReesfvbdcPKRH+KUDItfdJm+FcM1E?=
 =?us-ascii?Q?MEyLxo9wr4GiDled+Dx07aBHskWyYXqA55mgrjYI2syRWp+Uw2z3nMOPgXx2?=
 =?us-ascii?Q?eKHRo9+LKOuo6uPTjEz4erIw0VILsOgL3zb3zTi1/47kyu9b25S4zhEFw+9T?=
 =?us-ascii?Q?/rryqklWwDhgnBvz2M2T7GKQ+1zRLCJRKzMXfBJhgRvvzUyX9GQ+lu0IfDUE?=
 =?us-ascii?Q?manrH0tnF+Al/NisoksErHUfKonb1XtXlm9rehbitDDTbd8qmLjJxWWBLRrR?=
 =?us-ascii?Q?MM5hn0TzBC5uH5b3CVQI+fdl0Wv+8xEbPLcjBU+J6g5K9sajBwUQk8ZBC7aP?=
 =?us-ascii?Q?KSDea5VsfJuY/Hz0H6QQCMxf1kCBBIZtr0DMYnLiTEKRCIiNVs/mHdXYErv/?=
 =?us-ascii?Q?oheAv2GcPti37Da0ZTXewD0VlxI5N9hHR8rqRY14ySXtF9ama05CUhCwppE/?=
 =?us-ascii?Q?6S8TEhVAxd+2OhV6rdHnB+shP+Hc7NNhLb+adthhb4BqF9TQjJ/4JgpnlpFt?=
 =?us-ascii?Q?i+fgiBNtBT0TKyV92RHAj4RpY+VbzjI5TrBltEuM9Wdj5m7e/9PA5ChtOib6?=
 =?us-ascii?Q?3zZxVNZGSusXTkYEWy+7S85yOQSPtWz4OK+FuW7FcljjJkJEuec3Y8hujWvz?=
 =?us-ascii?Q?T+hF079JOCbZcR9zzGbaCoFnALvRUE/zocOYAO9kzKojbSfaJETtahpVOaQ9?=
 =?us-ascii?Q?2kEGWDELVudYvloiXaVXWRWBW425YmuhG83l8kzHOMwMZDXAkZ+Cs9F+YIgp?=
 =?us-ascii?Q?pAIiUFEGv+x1j3bRzkvSSJwJ7uDn5NXG8g22m8PiPPb4JM6PfvLbyQ4pAD4x?=
 =?us-ascii?Q?K8uN7LGYBp8rqaJ1bxXaB0qsJ2UqLaRf4I0QYjbn0gkU+z80E5hDxtPjVg79?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qwgH2k2Rz+5czLiQlLYfjIJbMzjb/y7FPqbjF4lh4qYMFlsSUdTRlVrpO0tYm/YHKrvUNoWfavVH0WoUKfCq6Bz7bigCIVSBXhHt3kapkhqHGuX89AMIguT6h+fNqhs9ne1B2Odxmbgf8qdwEYoRgLEXBcfUhdoi3R5D3q26avoijJICjOt4/HhqxoLrqmVR3n3UXKjdn8feEqfW78owsNWtMrJaAP4+vHFHUfK9pX97QAhIAmO5DpoBhwVdsQYCOno9jKNh+avTrvBIuQNVXpa0DRWLFo3v9ys1nMPnT+fAsF7TqE3m8X6ERvKPfdcMYXxUkvXtYiWspr7S3vkxTgkx4JRZ0ROD192YNg/J/I3BJoZtYcDTYarhwd/ET2dHpTCyPy5kU5Yhac4uoVmxREDC/MLoRjm+r7OXmwnx8GdqdGzTtHgl0HAxPNNDZ6FWqSxUj9UERrLbaxA+hLBbmmYWpiLfkf1uB6zFWBm8VGdzge6q2jw5+kWeiakv84RzE4ICcIK1U/u8OWL+MvQTbT2JceyJ4k+4Cb4XLL7HadUeufYedgZgvh35DoaiXd4AMK8GF3hOPDHHy/qa1CpKJRrGYsebGd0Xe/3kRODj69U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e0cd7a-29ac-4654-4c20-08ddbbfab395
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 19:32:38.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSd6Tp7rpf3Lm2/uY4kkEyY3S9GmH6z9WIx4bf8tjQZVmI8hoq8V12c+grH9d9AeyLxA/diZfRweb2TWWLgTYYddVHY0Rf9ee+X6CvRyFGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507050129
X-Proofpoint-GUID: F0Iai6UrS061XG6tFdlADk7QhTu22lQG
X-Proofpoint-ORIG-GUID: F0Iai6UrS061XG6tFdlADk7QhTu22lQG
X-Authority-Analysis: v=2.4 cv=X6VSKHTe c=1 sm=1 tr=0 ts=68697ddf cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=I95fwQHBfEP3sCmEloEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDEyOSBTYWx0ZWRfXxYhmPcejiYNM YygFGVVDsYkVs/yOhdkXSgUXiuZX+pJ3cYo+IIWgbP94gMMhJsAF1TYilQUYhPdTWh6oO2XjswA Jg+k9kAbRwVBcsB6Klxt5VBcYCRVfSM0/u/795VIpi9adOF1B1Sk89K1ATzb690WxQpNxQg1aDd
 VzLjklBvuvFudSwheb6mjRJ7Ynpt5egsAf7Hy+n4t2g0A1JKgnV4sZdWgUzNdsLbjZY2+C2OVC3 Q0fSjf+zRpkBU73r0pgLm78BJWpw0Rauq0tbqQVtPs5qY30kaqjcuYnBq7uAviUiau43lxXvZ/l Kloas/siz/2f6amytaQuCBKPX0tUILWpylrhSpasOYWOUbXPX+Qfzq6t54QOqdKy+pPPrr+h9N7
 Tbn5XdDxPD6/0e5mBqZTf7TkvyqpW70WCQhXUZ6f2H6cpOEtQSoc/qyPVfhMbxJdqyHZPrp7

Andrew - can we drop this for now?

Hi Wang,

Something's broken here, the collapse test isn't working properly:

#  RUN           process_madvise.remote_collapse ...
# process_madv.c:304:remote_collapse:Expected get_smaps_anon_huge_pages(child_pid, info.map_addr) (4194304) == 0 (0)
# remote_collapse: Test terminated by assertion
#          FAIL  process_madvise.remote_collapse

And because this assert fails, when run from run_test in run_vmtest.sh it's
causing the whole script to freeze up because you're not cleaning up
properly.

Could you take a look?

When I get a moment I'll review properly, it's on my TODO.

Thanks, Lorenzo

On Thu, Jul 03, 2025 at 12:43:26PM +0800, wang lian wrote:
> Add tests for process_madvise(), focusing on verifying behavior under
> various conditions including valid usage and error cases.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: SeongJae Park <sj@kernel.org>
> ---
>
> Changelog v3:
> - Rebased onto the latest mm-stable branch to ensure clean application.
> - Refactor common signal handling logic into vm_util to reduce code duplication.
> - Improve test robustness and diagnostics based on community feedback.
> - Address minor code style and script corrections.
>
> Changelog v2:
> - Drop MADV_DONTNEED tests based on feedback.
> - Focus solely on process_madvise() syscall.
> - Improve error handling and structure.
> - Add future-proof flag test.
> - Style and comment cleanups.

Please try to provide links to previous versions.

>
>  tools/testing/selftests/mm/.gitignore      |   1 +
>  tools/testing/selftests/mm/Makefile        |   1 +
>  tools/testing/selftests/mm/guard-regions.c |  51 ---
>  tools/testing/selftests/mm/process_madv.c  | 358 +++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh  |   5 +
>  tools/testing/selftests/mm/vm_util.c       |  35 ++
>  tools/testing/selftests/mm/vm_util.h       |  22 ++
>  7 files changed, 422 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/process_madv.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 824266982aa3..95bd9c6ead9e 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -25,6 +25,7 @@ pfnmap
>  protection_keys
>  protection_keys_32
>  protection_keys_64
> +process_madv
>  madv_populate
>  uffd-stress
>  uffd-unit-tests
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ae6f994d3add..d13b3cef2a2b 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -85,6 +85,7 @@ TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
>  TEST_GEN_FILES += pfnmap
> +TEST_GEN_FILES += process_madv
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 93af3d3760f9..4cf101b0fe5e 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -9,8 +9,6 @@
>  #include <linux/limits.h>
>  #include <linux/userfaultfd.h>
>  #include <linux/fs.h>
> -#include <setjmp.h>
> -#include <signal.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -24,24 +22,6 @@
>
>  #include "../pidfd/pidfd.h"
>
> -/*
> - * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> - *
> - * "If the signal occurs other than as the result of calling the abort or raise
> - *  function, the behavior is undefined if the signal handler refers to any
> - *  object with static storage duration other than by assigning a value to an
> - *  object declared as volatile sig_atomic_t"
> - */
> -static volatile sig_atomic_t signal_jump_set;
> -static sigjmp_buf signal_jmp_buf;
> -
> -/*
> - * Ignore the checkpatch warning, we must read from x but don't want to do
> - * anything with it in order to trigger a read page fault. We therefore must use
> - * volatile to stop the compiler from optimising this away.
> - */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> -
>  /*
>   * How is the test backing the mapping being tested?
>   */
> @@ -120,14 +100,6 @@ static int userfaultfd(int flags)
>  	return syscall(SYS_userfaultfd, flags);
>  }
>
> -static void handle_fatal(int c)
> -{
> -	if (!signal_jump_set)
> -		return;
> -
> -	siglongjmp(signal_jmp_buf, c);
> -}
> -
>  static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
>  				   size_t n, int advice, unsigned int flags)
>  {
> @@ -180,29 +152,6 @@ static bool try_read_write_buf(char *ptr)
>  	return try_read_buf(ptr) && try_write_buf(ptr);
>  }
>
> -static void setup_sighandler(void)
> -{
> -	struct sigaction act = {
> -		.sa_handler = &handle_fatal,
> -		.sa_flags = SA_NODEFER,
> -	};
> -
> -	sigemptyset(&act.sa_mask);
> -	if (sigaction(SIGSEGV, &act, NULL))
> -		ksft_exit_fail_perror("sigaction");
> -}
> -
> -static void teardown_sighandler(void)
> -{
> -	struct sigaction act = {
> -		.sa_handler = SIG_DFL,
> -		.sa_flags = SA_NODEFER,
> -	};
> -
> -	sigemptyset(&act.sa_mask);
> -	sigaction(SIGSEGV, &act, NULL);
> -}
> -
>  static int open_file(const char *prefix, char *path)
>  {
>  	int fd;
> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..3d26105b4781
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/pidfd.h>
> +#include "vm_util.h"
> +
> +#include "../pidfd/pidfd.h"
> +
> +FIXTURE(process_madvise)
> +{
> +	int pidfd;
> +	int flag;
> +};
> +
> +FIXTURE_SETUP(process_madvise)
> +{
> +	self->pidfd = PIDFD_SELF;
> +	self->flag = 0;
> +	setup_sighandler();
> +};
> +
> +FIXTURE_TEARDOWN(process_madvise)
> +{
> +	teardown_sighandler();
> +}
> +
> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
> +				   size_t vlen, int advice, unsigned int flags)
> +{
> +	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flags);
> +}
> +
> +/*
> + * Enable our signal catcher and try to read the specified buffer. The
> + * return value indicates whether the read succeeds without a fatal
> + * signal.
> + */
> +static bool try_read_buf(char *ptr)
> +{
> +	bool failed;
> +
> +	/* Tell signal handler to jump back here on fatal signal. */
> +	signal_jump_set = true;
> +	/* If a fatal signal arose, we will jump back here and failed is set. */
> +	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
> +
> +	if (!failed)
> +		FORCE_READ(ptr);
> +
> +	signal_jump_set = false;
> +	return !failed;
> +}
> +
> +TEST_F(process_madvise, basic)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	const int madvise_pages = 4;
> +	char *map;
> +	ssize_t ret;
> +	struct iovec vec[madvise_pages];
> +
> +	/*
> +	 * Create a single large mapping. We will pick pages from this
> +	 * mapping to advise on. This ensures we test non-contiguous iovecs.
> +	 */
> +	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_skip("mmap failed, not enough memory.\n");
> +
> +	/* Fill the entire region with a known pattern. */
> +	memset(map, 'A', pagesize * 10);
> +
> +	/*
> +	 * Setup the iovec to point to 4 non-contiguous pages
> +	 * within the mapping.
> +	 */
> +	vec[0].iov_base = &map[0 * pagesize];
> +	vec[0].iov_len = pagesize;
> +	vec[1].iov_base = &map[3 * pagesize];
> +	vec[1].iov_len = pagesize;
> +	vec[2].iov_base = &map[5 * pagesize];
> +	vec[2].iov_len = pagesize;
> +	vec[3].iov_base = &map[8 * pagesize];
> +	vec[3].iov_len = pagesize;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, vec, madvise_pages, MADV_DONTNEED,
> +				  0);
> +	if (ret == -1 && errno == EPERM)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or permission denied, try running as root.\n");
> +	else if (errno == EINVAL)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or parameter invalid, please check arguments.\n");
> +
> +	/* The call should succeed and report the total bytes processed. */
> +	ASSERT_EQ(ret, madvise_pages * pagesize);
> +
> +	/* Check that advised pages are now zero. */
> +	for (int i = 0; i < madvise_pages; i++) {
> +		char *advised_page = (char *)vec[i].iov_base;
> +
> +		/* Access should be successful (kernel provides a new page). */
> +		ASSERT_TRUE(try_read_buf(advised_page));
> +		/* Content must be 0, not 'A'. */
> +		ASSERT_EQ(*advised_page, 0);
> +	}
> +
> +	/* Check that an un-advised page in between is still 'A'. */
> +	char *unadvised_page = &map[1 * pagesize];
> +
> +	ASSERT_TRUE(try_read_buf(unadvised_page));
> +	for (int i = 0; i < pagesize; i++)
> +		ASSERT_EQ(unadvised_page[i], 'A');
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize * 10), 0);
> +}
> +
> +static long get_smaps_anon_huge_pages(pid_t pid, void *addr)
> +{
> +	char smaps_path[64];
> +	char *line = NULL;
> +	unsigned long start, end;
> +	long anon_huge_kb;
> +	size_t len;
> +	FILE *f;
> +	bool in_vma;
> +
> +	in_vma = false;
> +	snprintf(smaps_path, sizeof(smaps_path), "/proc/%d/smaps", pid);
> +	f = fopen(smaps_path, "r");
> +	if (!f)
> +		return -1;
> +
> +	while (getline(&line, &len, f) != -1) {
> +		/* Check if the line describes a VMA range */
> +		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
> +			if ((unsigned long)addr >= start &&
> +			    (unsigned long)addr < end)
> +				in_vma = true;
> +			else
> +				in_vma = false;
> +			continue;
> +		}
> +
> +		/* If we are in the correct VMA, look for the AnonHugePages field */
> +		if (in_vma &&
> +		    sscanf(line, "AnonHugePages: %ld kB", &anon_huge_kb) == 1)
> +			break;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +
> +	return (anon_huge_kb > 0) ? (anon_huge_kb * 1024) : 0;
> +}
> +
> +/**
> + * TEST_F(process_madvise, remote_collapse)
> + *
> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
> + * on a remote process, other advices are difficult to verify reliably.
> + *
> + * The test verifies that a memory region in a child process, initially
> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
> + * request from the parent. The result is verified by parsing the child's
> + * /proc/<pid>/smaps file.
> + */
> +TEST_F(process_madvise, remote_collapse)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	pid_t child_pid;
> +	int pidfd;
> +	long huge_page_size;
> +	int pipe_info[2];
> +	ssize_t ret;
> +	struct iovec vec;
> +
> +	struct child_info {
> +		pid_t pid;
> +		void *map_addr;
> +	} info;
> +
> +	huge_page_size = default_huge_page_size();
> +	if (huge_page_size <= 0)
> +		ksft_exit_skip("Could not determine a valid huge page size.\n");
> +
> +	ASSERT_EQ(pipe(pipe_info), 0);
> +
> +	child_pid = fork();
> +	ASSERT_NE(child_pid, -1);
> +
> +	if (child_pid == 0) {
> +		char *map;
> +		size_t map_size = 2 * huge_page_size;
> +
> +		close(pipe_info[0]);
> +
> +		map = mmap(NULL, map_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		ASSERT_NE(map, MAP_FAILED);
> +
> +		/* Fault in as small pages */
> +		for (size_t i = 0; i < map_size; i += pagesize)
> +			map[i] = 'A';
> +
> +		/* Send info and pause */
> +		info.pid = getpid();
> +		info.map_addr = map;
> +		ret = write(pipe_info[1], &info, sizeof(info));
> +		ASSERT_EQ(ret, sizeof(info));
> +		close(pipe_info[1]);
> +
> +		pause();
> +		exit(0);
> +	}
> +
> +	close(pipe_info[1]);
> +
> +	/* Receive child info */
> +	ret = read(pipe_info[0], &info, sizeof(info));
> +	if (ret <= 0) {
> +		waitpid(child_pid, NULL, 0);
> +		ksft_exit_skip("Failed to read child info from pipe.\n");
> +	}
> +	ASSERT_EQ(ret, sizeof(info));
> +	close(pipe_info[0]);
> +	child_pid = info.pid;
> +
> +	pidfd = pidfd_open(child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	/* Baseline Check from Parent's perspective */
> +	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr), 0);
> +
> +	vec.iov_base = info.map_addr;
> +	vec.iov_len = huge_page_size;
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
> +	if (ret == -1) {
> +		if (errno == EINVAL)
> +			ksft_exit_skip(
> +				"PROCESS_MADV_ADVISE is not supported.\n");
> +		else if (errno == EPERM)
> +			ksft_exit_skip(
> +				"No process_madvise() permissions, try running as root.\n");
> +		goto cleanup;
> +	}
> +	ASSERT_EQ(ret, huge_page_size);
> +
> +	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr),
> +		  huge_page_size);
> +
> +	ksft_test_result_pass(
> +		"MADV_COLLAPSE successfully verified via smaps.\n");
> +
> +cleanup:
> +	/* Cleanup */
> +	kill(child_pid, SIGKILL);
> +	waitpid(child_pid, NULL, 0);
> +	if (pidfd >= 0)
> +		close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with various invalid pidfds to ensure correct error
> + * handling. This includes negative fds, non-pidfd fds, and pidfds for
> + * processes that no longer exist.
> + */
> +TEST_F(process_madvise, invalid_pidfd)
> +{
> +	struct iovec vec;
> +	pid_t child_pid;
> +	ssize_t ret;
> +	int pidfd;
> +
> +	vec.iov_base = (void *)0x1234;
> +	vec.iov_len = 4096;
> +
> +	/* Using an invalid fd number (-1) should fail with EBADF. */
> +	ret = sys_process_madvise(-1, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a valid fd that is not a pidfd (e.g. stdin) should fail
> +	 * with EBADF.
> +	 */
> +	ret = sys_process_madvise(STDIN_FILENO, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a pidfd for a process that has already exited should fail
> +	 * with ESRCH.
> +	 */
> +	child_pid = fork();
> +	ASSERT_NE(child_pid, -1);
> +
> +	if (child_pid == 0)
> +		exit(0);
> +
> +	pidfd = pidfd_open(child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	/* Wait for the child to ensure it has terminated. */
> +	waitpid(child_pid, NULL, 0);
> +
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ESRCH);
> +	close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with an invalid flag value. Now we only support flag=0
> + * future we will use it support sync so reserve this test.
> + */
> +TEST_F(process_madvise, flag)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	unsigned int invalid_flag;
> +	struct iovec vec;
> +	char *map;
> +	ssize_t ret;
> +
> +	map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1,
> +		   0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_skip("mmap failed, not enough memory.\n");
> +
> +	vec.iov_base = map;
> +	vec.iov_len = pagesize;
> +
> +	invalid_flag = 0x80000000;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, &vec, 1, MADV_DONTNEED,
> +				  invalid_flag);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index dddd1dd8af14..84fb51902c3e 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -65,6 +65,8 @@ separated by spaces:
>  	test pagemap_scan IOCTL
>  - pfnmap
>  	tests for VM_PFNMAP handling
> +- process_madv
> +	test process_madvise
>  - cow
>  	test copy-on-write semantics
>  - thp
> @@ -422,6 +424,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>  CATEGORY="madv_guard" run_test ./guard-regions
>
> +# PROCESS_MADVISE TEST
> +CATEGORY="process_madv" run_test ./process_madv
> +
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 5492e3f784df..85b209260e5a 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -20,6 +20,9 @@
>  unsigned int __page_size;
>  unsigned int __page_shift;
>
> +volatile sig_atomic_t signal_jump_set;
> +sigjmp_buf signal_jmp_buf;
> +
>  uint64_t pagemap_get_entry(int fd, char *start)
>  {
>  	const unsigned long pfn = (unsigned long)start / getpagesize();
> @@ -524,3 +527,35 @@ int read_sysfs(const char *file_path, unsigned long *val)
>
>  	return 0;
>  }
> +
> +static void handle_fatal(int c)
> +{
> +	if (!signal_jump_set)
> +		return;
> +
> +	siglongjmp(signal_jmp_buf, c);
> +}
> +
> +void setup_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = &handle_fatal,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction in setup");
> +}
> +
> +void teardown_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = SIG_DFL,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction in teardown");
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index b8136d12a0f8..6bc4177a2807 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -8,6 +8,8 @@
>  #include <unistd.h> /* _SC_PAGESIZE */
>  #include "../kselftest.h"
>  #include <linux/fs.h>
> +#include <setjmp.h>
> +#include <signal.h>
>
>  #define BIT_ULL(nr)                   (1ULL << (nr))
>  #define PM_SOFT_DIRTY                 BIT_ULL(55)
> @@ -61,6 +63,24 @@ static inline void skip_test_dodgy_fs(const char *op_name)
>  	ksft_test_result_skip("%s failed with ENOENT. Filesystem might be buggy (9pfs?)\n", op_name);
>  }
>
> +/*
> + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> + *
> + * "If the signal occurs other than as the result of calling the abort or raise
> + *  function, the behavior is undefined if the signal handler refers to any
> + *  object with static storage duration other than by assigning a value to an
> + *  object declared as volatile sig_atomic_t"
> + */
> +extern volatile sig_atomic_t signal_jump_set;
> +extern sigjmp_buf signal_jmp_buf;
> +
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +
>  uint64_t pagemap_get_entry(int fd, char *start);
>  bool pagemap_is_softdirty(int fd, char *start);
>  bool pagemap_is_swapped(int fd, char *start);
> @@ -90,6 +110,8 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
>  int close_procmap(struct procmap_fd *procmap);
>  int write_sysfs(const char *file_path, unsigned long val);
>  int read_sysfs(const char *file_path, unsigned long *val);
> +void setup_sighandler(void);
> +void teardown_sighandler(void);
>
>  static inline int open_self_procmap(struct procmap_fd *procmap_out)
>  {
> --
> 2.43.0
>

