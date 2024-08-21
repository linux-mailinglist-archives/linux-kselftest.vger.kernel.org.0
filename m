Return-Path: <linux-kselftest+bounces-15832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99279597FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A1A1C21821
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBB1D6C75;
	Wed, 21 Aug 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PtOylVKl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yPV04jEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D91D6C6C;
	Wed, 21 Aug 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230116; cv=fail; b=ZNoaJbP7+RUtmnx8uYm69W6VIseVqKiGzS2ufcUnRpKafMTv5Pq2wa2VHUGkLR1q6hYO4MyrHH2GZyMC+qcCsOsFleCJ+RkiPe0JF1qgT5d3VI9qgjSWL/jymk+PTHqR5/Snrddxzdx2f20SozRL2g7S/22MfHpLbn9io4glQmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230116; c=relaxed/simple;
	bh=83MTQ3ZIFzs1wK8FCuqpuOYsIcOtPiIlZgV0l0eCYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7zei3Y1cQCEgFxDy53ec3SqOGjzBlLzkHhtxeGP76TqM4oeBNPQd4taiDuM72URaXImf8TKZq6ogNoVDDBxKA0ZYZHLY+zl4J2YuW0rF0PI+nf3L8HYdoQdhBNwIBL2jliQwwV8ioaNLnzxyW4UN2TQBVeudja/a7cXH1TTx1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PtOylVKl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yPV04jEs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tU9T006145;
	Wed, 21 Aug 2024 08:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=3lPJmGY2MZ76xlM
	oG9opb1cJjD8x4I8LbIqWyLnaw3Y=; b=PtOylVKl+SzHPR8s72h0n4Vp4Ve8ajI
	PsSrpZ5BBlvn1xrFJdEr4inSGJiT8R2UK9Jh8bxj+135QSC7GCAXmkoYS+beNBOL
	70bUi7GONQ4pULQLCwTSXwL5qoasTC/5J4WKn/uubDqrquL4wT2sYXO13dyWCel+
	36HnjlI93+VHUqgrMMYDpHcRoJo/iFdrOfqpnzlDU7mWW4AqqoFT1YaZpyZzN/tU
	kte3AZqZ1oIpzAkpt8OFmvjaDM2gADADAXc9V9jWyR8ZzscCFZ5WTscD3VKRwhoj
	pQsYwH+WYO57SgroRIHRpJ0toSkdWYdblJcMiWpKl2317oXVgA2dg/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gf2bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:48:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8Y7No021580;
	Wed, 21 Aug 2024 08:48:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415cudghf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0d8AHEofm5jTGfHKpUVY6XdqE96HCxnTCGjFhshf6pu4cQAZOzrtY4cOatiGQEuChbkcDBhM8/NtAU93NMr6lSRPMrPQx1iX2o+YXHPMWcXtLsMM06cG4yd6I3Ec2otF2SuTyn2g0IloSFvpdjTtzSwRDfSSWafu4OLYGqr5l0AgqpsSOmk7z+dDCh3Drp4a9JVf1b7brOGnVrATiHuXRguPXia0CDiPYmN9OGxFVzMw/Sv9E2QkrGHG0WV2NrUpVUXpgf+NWWTh3IYqr5GbLO1hPtOBVOIPxVO1IOEYgS8JYtbmWvM2L7I/UP74iZUrwvc8424YR/8WdEBLkygPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lPJmGY2MZ76xlMoG9opb1cJjD8x4I8LbIqWyLnaw3Y=;
 b=dRxXMBRL2wvm7xhuul2qxqjdaK5F9AUB50lt6CdYSgJM/kBiN1CQjRcih46iJFf5N8d3wil2fY29OegNvvtfo6u08HolT/0F65nNrgoNktbrn5R5yszQEbvENdItbMOv3WYzKJhawAS46SI4asz1bBF6+pwn/jira4CMairA/o2+TFiCoT3NXgNgR+B5QSB+CqyMQafQQHVlRu2xDwHqSbm/Ih8yEgxidoh8TXB+3/HV7gcML7+wboWj5Pq3plChV7zwQuHlvr98aQoSJkPXNCMEQtoe6SvnpAU0o23JVryll5Zd9S9+0lPJtYTiZeRQtj6j4x3vQnfNiJYkIozo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lPJmGY2MZ76xlMoG9opb1cJjD8x4I8LbIqWyLnaw3Y=;
 b=yPV04jEsPcOLtniUqL64ZYlo3fY9W6fv7IKXNiiNbLxhHiDaTjbHTpRoZBdr+jmVd38A7NIugIUumhKU5VUE0qbQb0mZyu8zg+g79dfmwJOLQjc5zjyJDlOuF2FNJC7VxW2DAHX4rcNaYKVmnoVBSGi7L9hkG3+uaMw0nAv4Cg8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 08:47:11 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 08:47:11 +0000
Date: Wed, 21 Aug 2024 09:47:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
Message-ID: <b5e9b913-1a81-47bb-982e-435f04e7f7c5@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1e99ac-b817-46fb-848d-08dcc1bdd8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5UJ2PNb7fXHa4x+Djv9X8P4ukb7Kx18OdRFsIim0d60i1GlbvBNT+/WszF2?=
 =?us-ascii?Q?RivoR6UQa6xAy7/oazLcj6i0QgAIzOqRYRM32oj77Y4eCXEHpzoIvw1DazMe?=
 =?us-ascii?Q?oSk0h0QawoSF0AOGN6PN3GZlWUseB7Kng4myexH9cphOpXFoZbrsMyr/DaHr?=
 =?us-ascii?Q?MsoMwD8T0RURoRCuFKa+XzbMqueoa3diBqZcOTN1xZfEuafKyHe7hmSmGWB8?=
 =?us-ascii?Q?xTA3wLOm1pjIpPFDEpi9nfi8NmlAEKzzi1t8urH1yhfvr+izCH2N+cQa9VrI?=
 =?us-ascii?Q?DdNf6BTXVqxjFLEzNk703ca+l0UmocS04b3Wd/kKUiv68k46gYHGHYLwUFAZ?=
 =?us-ascii?Q?kmCucFbxXgfwmy2LiuP4FYhqhQ9l1anxYtRUgofRj23j92HsBijGULr27FK1?=
 =?us-ascii?Q?ZGNNZf4Y60v7MX8en5EawoA2xKIVs7ouPrr/JAhDW/I1QIk9CLVyvvZ2QZIC?=
 =?us-ascii?Q?bNrgwY/6husmI6HhDCv6ikoZcqU+QnfBd85VG8Ju0iACO1zr9Oaw5oXXFoAP?=
 =?us-ascii?Q?Uf0ZpWrA5kEO3N/xFDEGKeNwRroCN78c3F6laERdvVesNgZZjRPLaAQajPcC?=
 =?us-ascii?Q?WEFsTIMXThTTC6A3YfFHEGYZrxpX/xM1Tuw5EgTCoQdRP4n68mO+FQWw8bg+?=
 =?us-ascii?Q?qFV2mLkME4R/4EOlr77p+Bqn20YI7wYe+0AwiKeRi8xvVK8fPur3pUTk2ssL?=
 =?us-ascii?Q?xNOauvd7TPb9v93U/CxbKy2P7PiY91w6cihVlrxXXvsshQKx2oMO2anTkNjh?=
 =?us-ascii?Q?9KKkoi33Z7tDvBNfCkSdhkQpAgfOr5fZm/g42jjoqZ+T14sUb1Zf/Duu+TVe?=
 =?us-ascii?Q?gNHyi1SPXRDtrfrAwKIdKyJvtwS55SIVzsjYNx/rKjmOihpmhafvw35TXH8r?=
 =?us-ascii?Q?TKKy78VeSD1cbVvri1pQqsDquot4IKpyvtS0AjMbudwj99ZoZj0+83RwcJDM?=
 =?us-ascii?Q?/2SsRExXzD20cJKq9GJl+FlnI/SIMDjBp+5yqp+ScjNcmB8EJli9t8U+6DOl?=
 =?us-ascii?Q?ZmSX/4O165JX1/f75q3I/Y8uOQ2RPTDKF1SnfjNkLvCZ1X9L8sivIdQGjOjT?=
 =?us-ascii?Q?98UrA41c/a3dgkbB0n6xPUiML0to93Tt7OY8Di5zdnldQsQnI/5ak/lnurci?=
 =?us-ascii?Q?Jruyy0xJyuXqnpg/TagYHCSxFX88eLd3NT5KW16zFeMVR4Bdn81h4ahAIHqo?=
 =?us-ascii?Q?xum5Sw3VXtn6XR4JSv60c4IMKQiLZPdn1BDEvLT8uESiREnUT0l3MamdtubV?=
 =?us-ascii?Q?pcmPSS0rpPgZEu1uOj3WJmgc3qA5KEyxD6AiRcP/dmG46bcR6Fu1BxXEW5su?=
 =?us-ascii?Q?QBwwYWvrNsjSZVxohD426Q00nqckkoM8Zd9BT1TePydVcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkGnGlQDxSJu87HpxQkKeeszkDaL1/N/4CQ8JzDEyDGTT9XN2FcRTAkBsOsK?=
 =?us-ascii?Q?tz73eP2tMv7nAXCvR+9SREJjtZXVWYpduAq3uOGkrYki5vifnhBlixcZakWQ?=
 =?us-ascii?Q?3xHFWumHJL7rXW691jMV5ZNrZdXVb5pDHrfLYly0rYhBhpAkOiyoAEQpyQFZ?=
 =?us-ascii?Q?yhyysfIVFWD8D+nQBZFF9v9HQXoFXxCkiP+S+ZHn908dluzw9TbvoysnuzNz?=
 =?us-ascii?Q?R0EY2H9BbUin352tIwrsHbuKykTLHGx8n1QM/nOuy95UgMiu/PanHmhXll39?=
 =?us-ascii?Q?RAN3jh+WhV1ASL+IHGa4xM8wzcgB67Nszdp51YG/07rnrBdkgT5XxGbOgzOh?=
 =?us-ascii?Q?tr1B6HoZD29+bx71v/NJyMqhT2TwU8xGskutfWciIyZgpt8MU/0eAZa7DA4m?=
 =?us-ascii?Q?L8JRZaMnl7IlLPhkoyH0LncVKgtyp2OK8L66D8g8+qLFkLwT0ABTr1CoSr2B?=
 =?us-ascii?Q?HMFqqaujAmQySbMkC6yv9aLPLcIONY0ce7yQGx0+62td977t2toxMFNrJ3s0?=
 =?us-ascii?Q?OiDD2A60uGOKcIFV/I04wgPVLZSXQIFsCvN0V8s+XlNEpAfLBCTV3ufssAHB?=
 =?us-ascii?Q?Yh6RYjCyyz7PlPGXJR58BHG5JfHoHymUrl/beLWthUDmO+8v4m0nHIUpfOhC?=
 =?us-ascii?Q?SWBUFhKYU8Guw+IvrkgvgSbPSd1/Te7c212IrqBXblR671OKQe0KEcUd6t+V?=
 =?us-ascii?Q?PhmJFW+jghS1UCNkFXu1LCTSZ4gWdsPLj+a0TwWipAMEmbglP4RbKnfbZZfG?=
 =?us-ascii?Q?xlVa1TBstW5D3HwdvwB/bw4AWruN1WEwUNkjXw0G/QD+KuWsqmVZZbiPOCRg?=
 =?us-ascii?Q?jkJvL7Vtd44eESVT/fclk017L2LtJhfE9otvDhKuGqZM+OYMQndVx/F6wa6m?=
 =?us-ascii?Q?YupsxtQtdkfj9CXydqI0/OXc4flkEzqjRPtelMqBwQSEfJZS2xadTNAwItBj?=
 =?us-ascii?Q?MJv92DgfoxgApBzeNxyOKdzg/5IedryyVFJfwV42yWsTY5TrJF/5j5mTCf7a?=
 =?us-ascii?Q?8A/aRVnXH0XbVg6JoaefQPgzxWtoBj4Rn58BDViF/8Aws87YQ9IvLHvpKhDA?=
 =?us-ascii?Q?nXQ30lRUFeh7VWvaK8b3SvFYJGD+xXeytyDBqEHliBKvb5hYcdx8Yr/kE7RM?=
 =?us-ascii?Q?5Jh3D2Qf6z2wy4jDmOsEZBWbxlFfgIPG4fPZGsaNIEqhUHdJ6VrBtvzWdZAW?=
 =?us-ascii?Q?WYEXnm8cUu35YFuzBO5hsp/o/WjPDHgrEsADBoqwP0XR7CeUcYiN9i2Nwe5m?=
 =?us-ascii?Q?V8tDzw6FEdeBPFnfgKMDFj0aH9inOhtODc+pg2YGvpre8wJwzrAuRVvjonFp?=
 =?us-ascii?Q?j08b8VvFQR6I0KQx2WBJpAIItibMUgn+kSnqSuZK/sfjeUbAcDQXuB90pqvz?=
 =?us-ascii?Q?aQLic6TBFo/aCWlzC1NhRgx1v8TB4lgh9rZ8bC2uAvrb67qFPwW4yTvm8DLy?=
 =?us-ascii?Q?rVggjpOMXAVhLsPi+hOwjOaUDlLbsmVgeWuahGmuFnZHqIXz0lGD/e63HEmu?=
 =?us-ascii?Q?wWm3xWXt7sblNzV0rtE4tXYBavEwqor62qVDpDk/8n9I10DAAr1H0dDv9KHh?=
 =?us-ascii?Q?TEssua/NTWFLxsrhtjugHQC192hYksWmHr+yBgqZhf7Q3QtIJ04S7IE79OqT?=
 =?us-ascii?Q?+KUowBU6v7i7nXv4gn3c7vNzw2nCpB8bH1cbSXi+spqptVtrrzho/WcvXlcv?=
 =?us-ascii?Q?6pmC9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QRQ2SP9hP3+e2ejdmPW+IR6fZ4TrjAIKd6Ht9v1RV/UCxW7x0xtIA1BNI6htBZrQV5zR3Cp+K9K98LVSvYA+PqeRes1Pn+UvctQ1sMyWp6gjtELb/kViCBR20J7qBTp2gljODjTsyYebX6rI5EdcbW55pGnGWKeSqzQakDoY1ILVCQiV1rO4fnSKUsLpGP9Pf4UXmh6T40mNdhsZBt5oJTg3ZmYtTOa2bTSTy5ZYp5bB2lFfO8zdBsmZPomNyqIEf5XhlEPS+ctfE1x5Ti+xakG32uiWAco41GPeSyFPS9GzTW7y1fRU/PPO+dMgz5tOL4HKsIVWdLGjh71+YeSoohtHa3TelOnz4gVXLGdV4W3vdNkXuER5kBvvDdvh6gfAUdOAqCGyxFT3IGvUNJZkCGlzAXfRYtffCg6670IXpT47uzEeJetMtIwfs1DvjV52OHQSgXI8UEORb8D8ojUmunK1M6DsL2baBchMm6wGujO8t0CryG0KMo+RUf0ltSoSgojHk4pbGeCNvgFmX4uZGnvvm0Lyfd9Kl7c9EWIzf9EAzhKpmxc7fueA7RIt6sXPLNnJgE1c4+L8tAYlWq9NtDKASECsPfDHhUKZi8RlFpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1e99ac-b817-46fb-848d-08dcc1bdd8b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:47:11.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhIFHG7lP7lCAbmhMCe0/rfFcMmQKM01qcK5/svLAuFYWKQBXWUXiYrWs6ZCN+w4ugIRZTXwp84omC5RMANapmRwi7NTwI8QxJBvkg9fewQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210063
X-Proofpoint-ORIG-GUID: V4JcbsuxXkn0KPpqEbgifsDZpwvJHsDr
X-Proofpoint-GUID: V4JcbsuxXkn0KPpqEbgifsDZpwvJHsDr

On Sat, Aug 17, 2024 at 01:18:34AM GMT, Pedro Falcato wrote:
> Add more mseal traversal tests across VMAs, where we could possibly
> screw up sealing checks. These test more across-vma traversal for
> mprotect, munmap and madvise. Particularly, we test for the case where a
> regular VMA is followed by a sealed VMA.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Other than the comment, LGTM.

Thanks for this series!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/mseal_test.c | 111 +++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 259bef4945e9..0d4d40fb0f88 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_seal_mprotect_partial_mprotect_tail(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 2 * page_size;
> +	int ret;
> +	int prot;
> +
> +	/*
> +	 * Check if a partial mseal (that results in two vmas) works correctly.
> +	 * It might mprotect the first, but it'll never touch the second (msealed) vma.
> +	 */
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + page_size, size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	ret = sys_mprotect(ptr, size, PROT_EXEC);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	}
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +
>  static void test_seal_mprotect_two_vma_with_gap(bool seal)
>  {
>  	void *ptr;
> @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_seal_munmap_partial_across_vmas(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 2 * page_size;
> +	int ret;
> +	int prot;
> +
> +	/*
> +	 * Check if a partial mseal (that results in two vmas) works correctly.
> +	 * It might unmap the first, but it'll never unmap the second (msealed) vma.
> +	 */
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + page_size, size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	ret = sys_munmap(ptr, size);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	}
> +
> +	REPORT_TEST_PASS();
> +}
> +
>  static void test_munmap_start_freed(bool seal)
>  {
>  	void *ptr;
> @@ -1735,6 +1806,37 @@ static void test_seal_discard_ro_anon(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_seal_discard_across_vmas(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 2 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = seal_single_address(ptr + page_size, page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	ret = sys_madvise(ptr, size, MADV_DONTNEED);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	ret = sys_munmap(ptr, size);
> +	if (seal)
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +	else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +
>  static void test_seal_madvise_nodiscard(bool seal)
>  {
>  	void *ptr;
> @@ -1779,7 +1881,7 @@ int main(int argc, char **argv)
>  	if (!pkey_supported())
>  		ksft_print_msg("PKEY not supported\n");
>
> -	ksft_set_plan(82);
> +	ksft_set_plan(88);
>
>  	test_seal_addseal();
>  	test_seal_unmapped_start();
> @@ -1825,12 +1927,17 @@ int main(int argc, char **argv)
>  	test_seal_mprotect_split(false);
>  	test_seal_mprotect_split(true);
>
> +	test_seal_mprotect_partial_mprotect_tail(false);
> +	test_seal_mprotect_partial_mprotect_tail(true);
> +
>  	test_seal_munmap(false);
>  	test_seal_munmap(true);
>  	test_seal_munmap_two_vma(false);
>  	test_seal_munmap_two_vma(true);
>  	test_seal_munmap_vma_with_gap(false);
>  	test_seal_munmap_vma_with_gap(true);
> +	test_seal_munmap_partial_across_vmas(false);
> +	test_seal_munmap_partial_across_vmas(true);
>
>  	test_munmap_start_freed(false);
>  	test_munmap_start_freed(true);
> @@ -1862,6 +1969,8 @@ int main(int argc, char **argv)
>  	test_seal_madvise_nodiscard(true);
>  	test_seal_discard_ro_anon(false);
>  	test_seal_discard_ro_anon(true);
> +	test_seal_discard_across_vmas(false);
> +	test_seal_discard_across_vmas(true);
>  	test_seal_discard_ro_anon_on_rw(false);
>  	test_seal_discard_ro_anon_on_rw(true);
>  	test_seal_discard_ro_anon_on_shared(false);
>
> --
> 2.46.0
>

