Return-Path: <linux-kselftest+bounces-27067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C6A3DB1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F83B5F2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7EC1F428F;
	Thu, 20 Feb 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TIjM+5Cu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lxH8eJEr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6ED8F6D;
	Thu, 20 Feb 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057514; cv=fail; b=bvdL0E6hQ3/v5GDy73bx3YUUTW0DRa66iYZyyte6D0/XN8m4MjWqXZYaRsjjR1NC/q/BVRnMEJcYa4jUm+GWFmgkjXIQNc6tHqFiuNSWn/D8llFAZBQjaMAroK26FfV0CeurZe5qAg8DUG0OtmhlDcl3+zzqNnN2/6VF1f4NOxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057514; c=relaxed/simple;
	bh=efeOsUYQ7Q4EiIAxp9crMJoGGbt3LYrvcpjctbvdNyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MlLf2lbS/+vaY9Qo9XEOo6g/3hX9/3BpgUi3ZLR/Zzagz2rvy9peSBL2KXzkQWHM5QKg9XgTGwsyepUUdfP9gphXVkdX9h2s6Bu3UW3/pR5+q+9M2NozMJiubn3NAe/Q6Pe83fWjytbXWcPb/IHWGv/VauFWzkrMo0Ct/Ofc19c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TIjM+5Cu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lxH8eJEr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fe0E023324;
	Thu, 20 Feb 2025 13:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=efeOsUYQ7Q4EiIAxp9
	crMJoGGbt3LYrvcpjctbvdNyA=; b=TIjM+5CuDhQgmoGRdnGgJ8sf0KLyjjGL0I
	PuPm/3RswCHpO6IUDXNdIN9LKRfZaXiKoa6IQ4hHz/MGEasRP6VpxaRgSUTbGZuc
	KDq0iwQEwf96HXVyk7Fbnafvi1lSguFZOPuX63MxfunUYr9MKTUFpUsa6mdSbILj
	V+ECg3X6uHdthZ0USTCQxaIlJy04O76G/ZSof7s98s7lR8+CxyuXYY1B6QBfu1xd
	juNK0y6qRy50NQi4uQ9pyflAIcTgVIm2uKVBRg9yoA/ZL6HNW+GSHWF1ka1my4p6
	MT2Qc5GanJG1l/aTWK1CWGNNBTY971L2TmVA6bvVutRPC9DzmWyQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02ym2st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 13:18:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCliDU012031;
	Thu, 20 Feb 2025 13:18:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b3v7b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 13:18:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR3mFkTOdF1/91zXH7TwWswStkrb8OqepnFHW8kra8JbRs91a0bh1KTDw2+O5LlM/xUKnWR8XN6T6Q/3rlva2Jqe6jc7m+IXme+lQ7eG2KuALlvc/J8GduYulS2Mpxqpjw4nRKDRL603EllWAFI1IhSR0aNt3NXZhFqsdr4yFZbEgO8S87iTeQ01jB/k0uuCgYu6fPD5wCDcHFuKBGYbTWlFQtY1vXsn4NRvIlVrTzEqdiaDaV+wrDUvy3W4z7fdpGP5kIIPfU9pn8dEYZ+vKh0KJTokkzTIs3BQn7+hJGsuf98gBl+xANsgHGJebvApkfm4Ei1oImquUTndvUEJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efeOsUYQ7Q4EiIAxp9crMJoGGbt3LYrvcpjctbvdNyA=;
 b=dzTV3iGpxBZrwa7Am9r7U5Rn0+6xZeNm2JYYsOfsRpYMO+kakPKfvqliR6kltcFfQvfzoSjmD2E66SOBtY5zfcmUBGIRkMgtxix3hKXTHvy9sUzhi/teyy+GZUQh+qMluZOzdAzdemG+gQLqbDXX64r66kZiyjqINHlbNON8idCOFiG4ozl74jcWdj27D9+PFg4fshnNirMO3/scUNwIu47o2P6u/Shi8y6lyRbqqaG5hSLB2YbUvR9U7bqyWBsmSB+2rMj/LUXjA2VQHwROIrRbQruo3+7nWGhTc8UqCFjdSOeS/e8FB0V2lnXDtqHmHBPyD+k2auKQ0r02CH6Xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efeOsUYQ7Q4EiIAxp9crMJoGGbt3LYrvcpjctbvdNyA=;
 b=lxH8eJErLOhu1OEFGJZt+B4mbkO5zHuCmOOrGmCQVwppCj86/z6KqtBBuWQ3QqUnRho1Psii5AnQWRmMiRFG3kB4Y82cngZbV0kB6pX9lXKdoRAxMbunp8gF8qpgzkHpXJjVWfJZZDWsPPXx8lvFkQeQm9iEhTo5uYyndgQw30I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6742.namprd10.prod.outlook.com (2603:10b6:8:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Thu, 20 Feb
 2025 13:18:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 13:18:10 +0000
Date: Thu, 20 Feb 2025 13:18:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local>
References: <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
 <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local>
 <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
X-ClientProxiedBy: LO3P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eb8207-0707-495f-541e-08dd51b105a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMDeypruQRCGAd0Ob8Yt4qJUQXINONlXKmMCEgdU9hxXYBMj3EGqaVROyLHi?=
 =?us-ascii?Q?E0vH36GiauVIneYnSDFPh/i/8aek4qJzUs2uzg8S5I8NrZC54ucbKvWm/+R5?=
 =?us-ascii?Q?xTfvmNKZg9rM8UKgbdFOFYP7NR03elSl0EeH0lquzkRZK0+SLQuRDB5jmqoB?=
 =?us-ascii?Q?rt5BbaCxtIQa0GIbI34XESrG7bX5WDI5LpG6SCADCPC7IpeLmi6WVylKTwpY?=
 =?us-ascii?Q?V9Ere/e68KNLxfAEEWenAJA+f2TWA9NrSPrJVVVKcmeDIXwe/7gOItiStFlm?=
 =?us-ascii?Q?1J97XErbXejNLBZnTOowPIupFjEbM3GTamLAuTo42kVrCXkOnJB7BUqTyHrS?=
 =?us-ascii?Q?phA/lRNq1xFDkKOhR/8pIjjdFxe/dWTiwmJAlLVvBY6DA60QyG0n2Rcz8qY9?=
 =?us-ascii?Q?+5qcBWHNeM2SbhCLln6pWyHrtTArtMJgYwW5C2ky3JvuPbmFIYHazfIQdvEt?=
 =?us-ascii?Q?EAdvP9UGFEeNUOCyHbS3IBQC7D0Im95TjgCb5hUwM+qIgMiMN94xaQ6Qzt2/?=
 =?us-ascii?Q?3t5NH7zo5oUv/abIpo7miKgA3CMY6Ss9m/Lx0GQPiDa7ruFhAxByK0WP03pW?=
 =?us-ascii?Q?RGaPVhFXI4sX9Pd+htcd5gb8Cxrv+EHkhqajfmlhY0fR60vMTPNVZHgXh5SR?=
 =?us-ascii?Q?3ErfI4npIT+PcJ261ul7b9t5GaaKfhFu+rQ5MTfEUSChbQieXC6RU+810DiP?=
 =?us-ascii?Q?hMVqD+Y3BdkAa8QRMBlyUh+v4oeoz1st0olcIw3MqOE0TFd3Y1mlXCGYEWri?=
 =?us-ascii?Q?e2CfLFNtDRjiCHejXK+bHR9Himmzxk1xSMJSenp3+C5MMm+n5rJXD+XIwH97?=
 =?us-ascii?Q?wRwchzzJZBzS1fUUKV6g6u5adQRF2JxkDMdfiTi62Bgc0MhSpL7xkhPP7pM5?=
 =?us-ascii?Q?HYMqtBHZJJAkvNWt7HV6zmwsqy1mANs+3lFfd8K3KSirNWzwZJXfVcrNsB+8?=
 =?us-ascii?Q?S3xv6LMSD5f+5CZLJNDxLekqraye8HSvqClmoeem9rM+dKcIDzYJ/2mYcKaD?=
 =?us-ascii?Q?HU+eOGopAZIVExRsXfTFnEjzTsA18uQURONdnXcHNlT+h+sbx7WVQgo8iYpz?=
 =?us-ascii?Q?sEl2Xc5LN/1GyKFn20YlCZQtmY8zLGppx06Pk+aZK9V5xBjdX8i2tGdHGpo7?=
 =?us-ascii?Q?5xhS4JRh/gY5p/qSI9sutQHDlwGKqG/HyJo+gHnEDL+co0f6T/fveRtSi5HH?=
 =?us-ascii?Q?QE15XqiZhD4bB1J6onWBzpCY6dbpisE01+2Tab+SSn2uCECglFOCBpdp57BR?=
 =?us-ascii?Q?Ro2X1XX3dIhcJiV0iOLr3A6MVkW9L2Y9MtyFJVFb4apV/JT/Bfwg/8ry1N4J?=
 =?us-ascii?Q?sb/7DFQaJ4oMEwTpk0n57sWCC9ylEfAttOjr4d7Oc3crPE+/XbGsbMQooL2e?=
 =?us-ascii?Q?EuX1w/QOHoERs69k+NJtO0Fnai0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lM5g2oLvfzH4OvbMZa1vA9/mduckPWLyxMZpnQ45XPZDZXVHhsY83/b0sDDD?=
 =?us-ascii?Q?Ri7CCBo7y3Rn7IUcPqe/vSCJ06k9g0H+r6InbeN3ZKhaFRMwFr79JqBTERxS?=
 =?us-ascii?Q?60poAfLUBVPk9CJmFbGRzo32MeKvE2djQg/pKt+I0ROqCLP9+vM7BL3G6byJ?=
 =?us-ascii?Q?20kWpr8PFnfDys3FpTcYzZPGh4mZspLEWoKWDllh7sun0mPUbV7AVV+D2WSG?=
 =?us-ascii?Q?zJyPK5G9GNQ7TgGQeg0uRyQYqkiSdmYDbogG8yyswgUlO3wgzNzMgdqPEUVl?=
 =?us-ascii?Q?wEIzVBcZ7XvC6b6j5A20Bx2+bIJZBMqJie4m/E5Tgufy+CBPbM6klUS/+LFu?=
 =?us-ascii?Q?yhqEJBBNiI7aqlGeUxKokygkOCF2dKa2zcwgTWXD0BFGQTvXmJNNQIYJBPAo?=
 =?us-ascii?Q?7ZlKUL9INLKiVw2ZXVcgZK0wKomYqMi14jNkEvf27OT9oCl+LkpWyIcZB50Y?=
 =?us-ascii?Q?QwYtiyEX35pw3oTktDX9Qg1GTbfblmTR5uV+LMxUsSbYTAXMMaYeMpM2HI5H?=
 =?us-ascii?Q?8WO9cwISn6agTZ72bU+4fvrg8m8ZczG1NMFTTjKjIRO12qxVfRiAYbLaaDvA?=
 =?us-ascii?Q?tTb7cyXUBJ3Y5iav1eYBdTbN0iyzQis0Nc3JR4QFoam1bewVIQHLcNPUd9OY?=
 =?us-ascii?Q?1xRQBSryG30w2UEm0CZjkkBonSVmGf9V5U+9cQFKnD2G8nZqTf0rU3J081zu?=
 =?us-ascii?Q?NjMD+KgrAMNHdCZT7HKlsx/3b71W9Eq6staPD4yPh9M3+PqjuIu7iacXHyqe?=
 =?us-ascii?Q?LXqYEonffe+gdE6CuBXb5fe57l6X9Aku9qjustJY32hLv8UmhdHyWwzWqHhy?=
 =?us-ascii?Q?W9UebPTqRpXcf7Xtd0WAGgCX4VtjYjI4gPYch1UpP2qPooMY0S+QbIJi3YqG?=
 =?us-ascii?Q?H3cbdGJNWJ8cDjV7bffNiojEiQF8t5Lu/b2Vu0sw7+rwIsdes0kxhTFddd0+?=
 =?us-ascii?Q?F9isTrTXUQTBHtBeFymBCbVxTR5GINLk5RuAQqFuuJkho4PXHpWSZKA7mzSP?=
 =?us-ascii?Q?8GdxXEsAcP11fsVfE1u97LRuUgGjOUehuBs9aMBlg4bdu76+6jFqcWP0d0gG?=
 =?us-ascii?Q?1NOjvzYA41G8C7otfUq4wiS+qubkQ6Gb1MbtqHnYLJezk8hTWhPYZBIdW6eB?=
 =?us-ascii?Q?3f26cJAYWQb8TYKev6sPE2q2PsoeIEb2CE721ucmhuw3J1mw3uuZ/TB8KEz2?=
 =?us-ascii?Q?W2tYg+J4OnJCmNWL0fU6dTWnd2roHKaCDokUTr98AE07ep69Esoryt2yvmL9?=
 =?us-ascii?Q?552Arxqwu0uSpHbRPqhiUlkMWvRh9z9fUYx5lXCINTfb9+o8FVfDxSCoyLjq?=
 =?us-ascii?Q?ITfIwIYotjei3nkyOk1krbtV07K3XYjslMHoZFDiCIST/O23NNK7KDVceOIf?=
 =?us-ascii?Q?LG5jhyK57H0giazuSs+lL/ZcvF7L2VBTjj5WfLUQcSM4ozInUa5wDrlQHuRZ?=
 =?us-ascii?Q?bhfdBqvgnS7HaziYN2fk/sxW2ROV71zhchYzwilBUhDc+eqEDptMdIcxMOYt?=
 =?us-ascii?Q?//5/tvBQhtpfLYaQOSERXgKvzfJMYhON9UHxO8kMThM/nx5hJS1iUtUBUK1B?=
 =?us-ascii?Q?EdC0wGwQaP0fKfXbR3Rij+fm1FnLButj+eDrynSyrg3T6uJnu13rIY4JqQln?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e19lzT4kBlq3/oe9VTFXWebx3zb3urtOkQgx0iSBTZbbpE45LDV8sU5Q7IkcUrTULTfVrBWvC3Yt8PE5Q/DbyjWmPflS9yK+iTK8p/J7KiE5Z5LDMC5qrsvK9xHYwxOYdaBGU8V317IXV/7ll0Ub4y6hVksUPxW243C/ibrPOmJxXmC/b/NRy4gbkBKRAZE7Q6/0f3wdR9HgjJE0ByMJDsIgGErVRz4OOm4ulSw5sLgKBPqQXYWTRsVbRbsGTsJznKXmiT050KABfjYzO6e9DPK2HuUhKScf3HllvdPMsrKg72z4nKOhQ9J/fd510Y98HbrMhRcKBLB6IZrdpWyqfauFgir829xAqSYqQbJh/7CRJt93KUna7kaNelbzJtnjd/GWvUaoHmhxG9HdJ5a2l3dJLHU4oILA0CkHfat+hrdfsO28no7xjATeEkdSRWisPk0IwfN3ScUOhkFd0Tacl5u6OF3PJaqEiL72wEmJQ8dGSnxjpWTCP341Y7YbMpHSZMfIHhF+tRuFkQvpWMsIoFUjS+pRmHSmg5pMpXaU2F1jftApTfIKSMmghF0hWD5UuitqVRhGPOIfweBUDQ1rYlVjqUyZ21hZzCzmM/iyBf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eb8207-0707-495f-541e-08dd51b105a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:18:10.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTDL/5BllxlTyP0XHBboNDgtbTyq/S/QPCZMp0tKkiH+sF+A0zqab5uthbyEW1v2VnI34jLuW2je6dn1x2ImeaB5LT/1sWutyogJ3MYUzkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200096
X-Proofpoint-ORIG-GUID: geSeL3YzUr1Xfj47cqX9Hb0DSEJ1Y3OB
X-Proofpoint-GUID: geSeL3YzUr1Xfj47cqX9Hb0DSEJ1Y3OB

On Thu, Feb 20, 2025 at 01:44:20PM +0100, David Hildenbrand wrote:
> On 20.02.25 11:15, Lorenzo Stoakes wrote:
> > On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
> > > > > Your conclusion is 'did not participate with upstream'; I don't agree with
> > > > > that. But maybe you and Kalesh have a history on that that let's you react
> > > > > on his questions IMHO more emotionally than it should have been.
> > > >
> > > > This is wholly unfair, I have been very reasonable in response to this
> > > > thread. I have offered to find solutions, I have tried to understand the
> > > > problem in spite of having gone to great lengths to try to discuss the
> > > > limitations of the proposed approach in every venue I possibly could.
> > > >
> > > > I go out of my way to deal professionally and objectively with what is
> > > > presented. Nothing here is emotional. So I'd ask that you please abstain
> > > > from making commentary like this which has no basis.
> > >
> > > I appreciate everything you write below. But this request is just
> > > impossible. I will keep raising my opinion and misunderstandings will
> > > happen.
> >
> > Well I wouldn't ask you not to express your opinion David, you know I respect
> > and like you, and by all means push back hard or call out what you think is bad
> > behaviour :)
> >
> > I just meant to say, in my view, that there was no basis, but I appreciate
> > miscommunications happen.
> > > So apologies if I came off as being difficult or rude, it actually
> wasn't
> > intended. And to re-emphasise - I have zero personal issue with anybody in this
> > thread whatsoever!
>
> It sounded to me like you were trying to defend your work (again, IMHO too
> emotionally, and I might have completely misinterpreted that) and slowly
> switching to "friendly fire" (towards me). Apologies from my side if I
> completely misunderstood/misinterpreted that.

Right this was not at all my intent, sorry if it seemed that way. I may well
have communicated terribly, so apologies on my side too.

>
> To recap: what we have upstream is great; you did a great job. Yes, the
> mechanism has its drawbacks, but that's just part of the design.

Thanks :)

>
> Some people maybe have wrong expectations, maybe there were
> misunderstandings, or maybe there are requirements that only now pop up;
> it's sometimes unavoidable, and that's ok.
>
> We can try to document it better (and I was trying to find clues why people
> might be mislead), and see if/how we could sort out these requirements. But
> we can likely not make it perfect in any possible way (I'm sure there are
> plenty of use cases where what we currently have is more than sufficient).

Sure and I"m very open to adding a documentation page for guard regions, in
fact was considering this very thing recently. I already added man pages
but be good to be able to go into more depth.

>
> > > I just want to find the best way forward, technically and am willing to
> do
> > whatever work is required to make the guard region implementation as good as it
> > possibly can be.
> >
> > >
> > > Note that the whole "Honestly David you and the naming. .." thing could have
> > > been written as "I don't think it's a naming problem."
> >
> > I feel like I _always_ get in trouble when I try to write in a 'tongue-in-cheek'
> > style, which is what this was meant to be... so I think herein lies the basis of
> > the miscommunication :)
> >
> > I apologise, the household is ill, which maybe affects my judgment in how I
> > write these, but in general text is a very poor medium. It was meant to be said
> > in a jolly tone with a wink...
> >
> > I think maybe I should learn my lesson with these things, I thought the ':p'
> > would make this clear but yeah, text, poor medium.
> >
> > Anyway apologies if this seemed disrespectful.
>
> No worries, it's hard to really make me angry, and I appreciate your
> openness and your apology (well, and you and your work, obviously).
>
> I'll note, though, if my memory serves me right, that nobody so far ever
> criticized the way I communicate upstream, or even told me to abstain from
> certain communication.

I wish I could say the same haha, so perhaps this was a problem on my side
honestly. I do have a habit of being 'tongue in cheek' and failing to
communicate that which I did say the last time I wouldn't repeat. It is not
intended, I promise.

As the abstain, was more a British turn of phrase, meaning to say - I
dispute the claim that this is an emotional thing and please don't say this
if it isn't so.

But I understand that of course, you may have interpreted it as so, due to
my having failed to communicate it well.

Again, I must say, text remains replete with possibilities for
miscommunication, misunderstanding and it can so often be difficult to
communicate one's intent.

But again of course, I apologise if I overstepped the line in any way!

>
> That probably hurt most, now that a couple of hours passed. Nothing that a
> couple of beers and a bit of self-reflection on my communication style can't
> fix ;)

Ugh sorry, man. Not my intent. And it seems - I literally OWE YOU pints
now. :) we will fix this at lsf...

Perhaps owe Kalesh some too should he be there... will budget
accordingly... :P

>
> [...]
>
> > > > > > Yeah that's a good point, but honestly if you're reading smaps that reads
> > > > > > the page tables, then reading /proc/$pid/pagemaps and reading page tables
> > > > > > TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
> > > > > > /proc/$pid/pagemaps and reading page tables once.
> > > > >
> > > > > Right; I recently wished that we would have an interface to obtain more VMA
> > > > > flags without having to go through smaps
> > > >
> > > > Well maybe that lends itself to the idea of adding a whole new interface in
> > > > general...
> > >
> > > An extended "maps" interface might be reasonable, that allows for exposing
> > > more things without walking the page tables. (e.g., flags)
> > >
> > > Maybe one could have an indicator that says "ever had guard regions in this
> > > mapping" without actually walking the page tables.
> >
> > Yeah this is something we've discussed before, but it's a little fraught. Let's
> > say it was a VMA flag, in this case we'd have to make this flag 'sticky' and not
> > impact merging (easy enough) to account for splits/merges.
> > > The problem comes in that we would then need to acquire the VMA write
> lock to do
> > it, something we don't currently require on application of guard regions.
>
> Right, and we shouldn't write-lock the mmap. We'd need some way to just
> atomically set such an indicator on a VMA.

Hm yeah, could be tricky, we definitely can't manage a new field in
vm_area_struct, this is a very sensitive subject at the moment really with
Suren's work with VMAs allocated via SLAB_TYPESAFE_BY_RCU, putting the lock
into the VMA and the alignment requirements.

Not sure what precedent we'd have with atomic setting of a VMA flag for
this... could be tricky.

>
> I'll also note that it might be helpful for smallish region, but especially
> for large ones (including when they are split and the indicator is wrong),
> it's less helpful. I don't have to tell you about the VMA merging
> implications, probably it would be like VM_SOFTDIRTY handling :)

Yeah indeed now we've simplified merging a lot of possibilities emerge,
this is one!

>
> >
> > We'd also have to make sure nothing else makes any assumptions about VMA flags
> > implying differences in VMAs in this one instance (though we do already do this
> > for VM_SOFTDIRTY).
> >
> > I saw this as possibly something like VM_MAYBE_GUARD_REGIONS or something.
>
> Yes.
>
> --
> Cheers,
>
> David / dhildenb
>

Best, Lorenzo

