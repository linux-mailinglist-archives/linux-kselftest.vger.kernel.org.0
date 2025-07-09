Return-Path: <linux-kselftest+bounces-36823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17854AFE96D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153B53AEE1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D52D9ED8;
	Wed,  9 Jul 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6J5UJ7H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqEgP4af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076B1A285;
	Wed,  9 Jul 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065537; cv=fail; b=qD2E8QGbQDid3uhYp3nzOydmKlmblqdBxKslPwOjZBIRlTp1Gosf8K83HnTiC0j3zV+CeqsZlSr3yV36wjjk9svZJ5qXa2S8krqRIMDJMPnjwDPzNNXBBSlaHouIzVlzk+lof7zSv/N+uf54wdukfFF1LvjNwrNtgUCMe1WTnug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065537; c=relaxed/simple;
	bh=YtDU5bZ4ainQLSq1n7H0ny5yjOgpgPypzyxPQWDpIxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sc4Dq38/g+f09jhWpIwL5BVtWlsif9axBhToB6PfpRCcPl/VugqS2HyMnoqYN5Lk9pvn256dphtsGAvE9pCmG8k+8TVeyC8KEMCVRNElfEWKbl9yMM8/Wiigh2076eM0aKZoo7U4Zy35m5H6efP7DWPpNIyoIY2RLz+Ipqilvjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6J5UJ7H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqEgP4af; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CKq84009645;
	Wed, 9 Jul 2025 12:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YtDU5bZ4ainQLSq1n7
	H0ny5yjOgpgPypzyxPQWDpIxE=; b=f6J5UJ7HFnz6BSAxdMdwDua4Jqku63ozuD
	TbdYrAYSFPC5uUpexfhUVilEq7eeVdgKvJ8JLFzdFbVoKSKwgbwU/UVu0kvbbEBB
	RAPpqepgOLNdxnumf6PihBnQWEZjrJxnjqI2ouB/SEHldbKUaez+en4P9t6y5775
	baOe5LGHIXj9tsgjaRV2vjAzesU/Y+BBuuXBQIHR06Ijp3xV8PqA5UeSXdRww4U4
	wmOpteo/Xj9HRTnpTf4c9rAdflj1n/aeDaO1x8Phc4jkXIqp0+mK87pOwrPjPHWd
	gCuPsBVdAM0vW79j1QAA+A2nedDZwHuhfmLMtzHiQwyHmL695EMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47srbqg1xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:51:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569BB1Nn021371;
	Wed, 9 Jul 2025 12:51:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgawuqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLHdC9boKqDhhWuS0ORygC5Z2kJZiUyW5qPtXyxWAZusq0AS8HLmPUvS6gNRG7TiziXHdTVhhTOdIij4oAwDbuUGINfLp+LXBMalMR/3vXgTMdiHuTRCOrdeZLFU75mlaG4UzFw6JQA/jSkTCyESOyyiMl2WULAP8P0iCqbURD3XxHx+da2Lh9iVOc1tD8evErpOoAI9Hme72oGMRJOFdOYlQxTh/L9uCY1KCuKLUb6AgzoB2KymBJ0p61dZ5u2nufHNkDiGvr3BEhqUkUZuUdF75G6id9RKj7o9hSSGqaBXyj9lcqma0gf+ncaDT1fjjLJMkGJy2h/3NQN6Dz5V5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtDU5bZ4ainQLSq1n7H0ny5yjOgpgPypzyxPQWDpIxE=;
 b=ZWcl6XfGhLjYsjzqFt45r6q2mn51/Y4uDax23i9MhFmKe2ytugqe/U3qHXt8V6r/Ol0piPhU+iDyiwY4ooPHcT+xaAwg6QJkQk8didon4vlB6WDJFPAW8VBXUbF/1s10JdGqRx9eWfZsmpzjqAFVTYtDMKoKYmvacZBOlgLMWLg75qnV7Qc84zT20jA6qmCAC3uYrxndEEOfIT2KNGnNo0l8/dAtThZmtcaIdopJjBzAy+491KujwMqEMzLslubma0oR4BLZXdh4eKRJ5sQ6zUppyGJ4FwnWvYJ4be30kdsuqifFwWramS0SaoQ5X8to/YAYOwqWrZLvsZWWxsERNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtDU5bZ4ainQLSq1n7H0ny5yjOgpgPypzyxPQWDpIxE=;
 b=vqEgP4afn/5c2WwnTBugu3vziEghogjNu+cn7NVVkybQn+BX7Iw3/UJfBph6PgFQZwSkR6hi4TBwyoWwij0Ef1Q06qnhlrh8X5vmzRzb1YVO+8L8HLqKDQKXB7LWEaaK3KJ4Dp8i9f8nuu71oIfKE6/Ax4IA8lo9vK0mdyRMSJI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF9C7B9A88F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Wed, 9 Jul
 2025 12:51:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:51:37 +0000
Date: Wed, 9 Jul 2025 13:51:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: ziy@nvidia.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        brauner@kernel.org, david@redhat.com, gkwang@linx-info.com,
        jannh@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        p1ucky0923@gmail.com, ryncsn@gmail.com, sj@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Message-ID: <9aa51324-10b7-4bd0-9d83-5722d1ea0628@lucifer.local>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709123224.6593-1-lianux.mm@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF9C7B9A88F:EE_
X-MS-Office365-Filtering-Correlation-Id: d4500338-289d-41f5-677d-08ddbee757cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RNKYp00cdtrqHtxr98ALgq4nLAe/1MDlE08Ty191tLNIYXnH9GF5U49ZQ6Lq?=
 =?us-ascii?Q?tYevZQ5nd8uABbOczVu2SbTi2b7IXzKeijnIhRkSxD7fK6yXHV2oYpgY0vpm?=
 =?us-ascii?Q?joNxalRsCdYZggCK9wUE8pFPzMndVoJFG9JhibDCyyZX+8N+D+Ck/nUoTR3p?=
 =?us-ascii?Q?8PNmFd+wwu0JAT8uquIg+yzyviP5/qN4dZX4pML3GMaQZwVpfWwc7jQqq0wB?=
 =?us-ascii?Q?A59/C+zUKk0r7lBvQZiklZ7/MEYIMf0+NIQcG3HbeCBitljztlVswEvxlHt/?=
 =?us-ascii?Q?ynHxz1tmPqvPqpdsDD9sOOPQCEII6fZhwZV3SHapybYZe80GBkAvnAlIUdI7?=
 =?us-ascii?Q?HnLgYpSbp2l0ewtbJE9X8q5joCasjte5++Qu7gRWJD44nQ0HkTe0y5dUMeYX?=
 =?us-ascii?Q?wtqM4oJOKH/kdjVcsgx0lEgJiEuXBI36AefKPUjaKqJmzxx+oKCQOyIWt/94?=
 =?us-ascii?Q?kW0+IcFc0fseins/dQ1r0+cGItH2+QE79BvV9V/+zPmKloXAs26ckLj2tPUr?=
 =?us-ascii?Q?oz+dgAXAd6GY7aYjZ+L88BM9lUOv4rt3rgkDsLIwJSu6MSlKZvU4Q8urQDmh?=
 =?us-ascii?Q?mQPcfhSPZY90m5Z+AS9QvzkNVgJJ/bL2WV5Vsr1fwy/rYoT3HtgQiOmy/LoE?=
 =?us-ascii?Q?bMXV6i8XMm9maadxMiXXoGdZiWxCBnls8aFi+Fj0/0kFaH/z9TbScxFLgfbh?=
 =?us-ascii?Q?uFcWrbKOqx3Sek3D6Yyw3ZjOBtNfT2TP4lYk0b0OyUV9a4C3COPHKIWoUhlO?=
 =?us-ascii?Q?bGg0R5U2FHrMsiCI5gU5R53PKJbPACB6ddq2Pcu3+a++2sPqfRRK7zkeTGps?=
 =?us-ascii?Q?jmc/0N+Q2dNfJZqXTTkAVwx4Rc2HNEnhr2nNvMVcNVDuNSgc3izELyu/ANUg?=
 =?us-ascii?Q?StNu/bdA0klZLO6q88+J4fGboj3D7eVQKF8i8TsoBpBIl/e7e/3Ag8e2XiXD?=
 =?us-ascii?Q?0Gem2LaA+Ck64/tzZm0FDLGcJFiaQZfV8V4s4lljGGVz9px8nfn0rQhHCyPc?=
 =?us-ascii?Q?uqJXSc4XKP69jS1YfKqtg5r6OShP/zrLSswTjJfpLCE6paubHr1xdpyEMs0y?=
 =?us-ascii?Q?IvGLUM52yeWhdrZQRJwPnqAMi/vhXZD43VAmoq7/LdLdz6Q5F2Joe1BoV6BM?=
 =?us-ascii?Q?cKUmzcOu8pUJ46nTT9dgCqHN6t64x9+Cn+zKHTZs4IV2hPKMthQAdFSCs+Du?=
 =?us-ascii?Q?Iuu3YwX3ivAxSUPzrUgSB0yIFUNSUC+Das8M1F+MJL+Ux+kdHk1v59icmMNd?=
 =?us-ascii?Q?O41PB6B14RBR0f7Fkn17SaEWvhxe7/cahEPqCB+rtIVR59PlLvAGZBNVRQ3y?=
 =?us-ascii?Q?99QSLGPcjeWwiW59oisOnGBRl6dNLc7dS6PtH9VJvNU0OPV3E1n1MrK1W75s?=
 =?us-ascii?Q?xRPuqLCztTBouap21gdsgX/Ap2+vVF8yw9R3Qwlag24l1UlvypEpVLHuwdCz?=
 =?us-ascii?Q?o/Bn+DhTN4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUKnLfIh+vX3CxvzvXiClzZT0idjPo4ojO0Nil5vNJipE5VywNO/HmCOhQ13?=
 =?us-ascii?Q?VeIvCjDfHKPDOs6zZbozCsMN/pY7aVMPliynmcN3fzdEvEYR6kdtFtkshb5w?=
 =?us-ascii?Q?vUNk9irNrLF3M+VT6a0czST2XXUIlctWwMfu5hl5IeOWPvk8RMZpqU16iILP?=
 =?us-ascii?Q?Q0dfyqWJyhxSJu/T/YAkB3tG/sF3265Xo78kY5dJ1GEfapEXhj55dPtsulBb?=
 =?us-ascii?Q?vyvz5Lmz7y6r2zv8adFA+dpoJu+/8OOiAAHFFRXti9AcIDduMQmHCwCvLF3u?=
 =?us-ascii?Q?qhmZnYojZk+/NKaXymcFwdu05ug8mSNrQvHEq/qmDrGvA1vztyB+UE64GTME?=
 =?us-ascii?Q?1hLUeEJv4YdupM9apBhtuNOFf36BT+R4a6vWsVvCbM6QAfj9diCi0mAVYiRi?=
 =?us-ascii?Q?kDWZgxLSB0Nvbks9e68I9jQ4sWemYD/dDGnJuZ+N1lrN+EEnlX9BXa5o//qc?=
 =?us-ascii?Q?8C0QHKSGY0CJPnpEbGW9wsW431qwEoSsHqlt0IgF2KYburFDrfB3q3AeJrvK?=
 =?us-ascii?Q?gJXDT/20nO429qIMRvu5U0EAwIby9vhRToKpYH9pmTQSwX+HyiDM+0ZV1ypp?=
 =?us-ascii?Q?kvFkZ7LdyBnYEopa4VeVoC3aalBisHYfjSOnqx7EL2jT/gxJ9DsHOzO1w5je?=
 =?us-ascii?Q?/2DMFOCyW8I00d8pphqcS+uG6Qw+3XaauuCg1Lry3wFUciZjbDc5aDdXBwDS?=
 =?us-ascii?Q?k7ZNbjmgxsuA/noiPghNqPjmMtr21LItRjnx+pmlhGEFACthU6274YNnaFgQ?=
 =?us-ascii?Q?XnQL/bc1KRmqIFmWSDyJqLTNW0wpGtEyUm8S0k51O19OsnJtQAzL+SEF13RB?=
 =?us-ascii?Q?PsrY0vSwtO8c0nzcF6D4dTxKWr7IuewkwZ4PE7wN6rl215qGLJ0tHXALPYrc?=
 =?us-ascii?Q?pdhTSq+N7iuuptxh6EG3+ucUiO/U2wm8uwL8GQq6yJRL3IR/Nm2CnN8PJQYA?=
 =?us-ascii?Q?l7VwK9P48kUzGxiPlh0aGYH9SRk5VUWSIwGl0G10BJ8x4O0ftukesUkHEfCA?=
 =?us-ascii?Q?ubAcx3/rI+GHyh4Jj4HaiUkpwdRm2vV02JJ3/4A/4iteaQamyKmzIUnmwz2K?=
 =?us-ascii?Q?YVgGqtvmdegR6oeaX6giZbjMrpYLoI6zr5mSbboNr2kVAzLzr2djwdOgrt2i?=
 =?us-ascii?Q?1802QTXGZnVWb9YMqEIroccnRAMheFY9PH02ctCumRmazBjueUxSphQF0EyA?=
 =?us-ascii?Q?A0YoJzIWB2WyfqpEsFlwpl0+6Wm3BolO25WgVq0ihvk+FuVIbSmAqF8l/Gya?=
 =?us-ascii?Q?uH5VlIjb1/UvLyNaVDQzlomFL3qrRckj1swXLrRd6T2A7UWNjBXoO0PyTPL8?=
 =?us-ascii?Q?aV+Ez8DVuH7Cvrj1xZEeLXJJ1Uahvu7Ud3Mdfa03ccMbTodHhfh/MJojJMQd?=
 =?us-ascii?Q?QIUtIW1rVi+9Rm6TLdmc0aPf8YXrbxtoCC/aEwhWmMIaPEc84BVTxFFSbKzn?=
 =?us-ascii?Q?ojBiBQnXUebm7S1aE8iH1v6qURSFtUpYe7FxIrk0H6uJ5aBJQOkLRZM9d1zh?=
 =?us-ascii?Q?ik+52hNHMF5/hx1SrirB1pOzOc+IPu+HUOtwZEwIMUmrVs0Trh05/dGSKGPf?=
 =?us-ascii?Q?SkEj6pV0ca56aHkABTfmpqAeYs0ZvFjWpKZ0sYU+XpHci6exEdrp4FT0yDvD?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N7XJ1Xcg2jIl7Ihte2IQ4jdciHpZreWgkb3FRLmN5SBvEhr9NncDM0Y3/Y591BCl0YXy/1pjOYe/Wz9SDmj22QE3wpSgPCvjp7wP11bgbKd4x34B3ZS90etpSXoXxP9gi3tsMzrPE3gKURElyanzijwAeo9+MqyURnG7UEMUCLG6BvZtU/0Bg8YlPwlRiMBR7diGS/zjHEixlUHScg5RTve3omYg8vAs91WyzzxIqjuMzHVwE+V6P2Pi1HPwf7NC1nG2+IySfn553FI+wVj5FUbyhxYEGjx5VVYIbqZPEAHSpG5o5aClpGUqJatiLPN1EzzY3RuOEszpcqwkBzGzOcpMZ4dteyHcWo7KDNexWhWssZFSZ4Nq5fKnrs+YcPGVnRShdyhEM1RfmXL2lEO5ETWeTQAOsK9Y/cPykDsDZPv24eK7NvlMM9XkgddBJGm08Jz4sz2xh2MEBRQh7cCPimZcp7l+kLxFN0ks9LqOzHJF22U0HHr3s0R0hOZqOK0xtOSWTcHVcig+kbupFv31qK/U1/6pwGJXLnz2ugpCIpijV4phHad7gpqG+hkTHDZhwAyFEawQRjMCPvyvgRuFHKfXuYQY6bxtWYlNXkHwuTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4500338-289d-41f5-677d-08ddbee757cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:51:37.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WmT7IM/xObMJp6/tllrKX5koIDB8W6/NRaJnoMOKCpc3cxQ1HjtPLuv6bx8zsRtXtp/FOVcO/jgyU531LgZRY1lNiQHntrgw/89HRGfKRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9C7B9A88F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090115
X-Proofpoint-ORIG-GUID: _pxJCPG9JN1QTmooGtbI41QhcJkZL4Cu
X-Proofpoint-GUID: _pxJCPG9JN1QTmooGtbI41QhcJkZL4Cu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExNSBTYWx0ZWRfX95ReLG8/3sQx wK7lGJioMWVgPe5oEzy8GPHHSRo048Pwvp2WdlAaErjJKS4nP0xfy8ZJtPHxAXBasU6h+neDQPL yn+SfWalFyG4RCwa7HnBopiovG5p+j0S767Vc4VPdBAuWfdvwoWXbch9lpGtA6zSHp/9zoOe7P+
 eh2GfXSSKZTa394F2IWDkaPSj24aZ0O90p8jsf0enT+x9JXH+ljmnhbhl1aGPFDKs5JamxS91KO AmdM740CbDjwF9F2pXDIadxEt5dR6WA32v/8U+mkVswg/vIRTqFZpTT3UWvKrcQ3RvV8SaJ7coh xpNhdrt/2e0YFP5Y5UYxCaPiDgipcM7y88n4ira1cEY65B45GcGoTzbirDf9XjqW2J0Pe+naMvo
 hvm+7wYAEkgRkKwFzB2iAwdBi9ny7+2h2lTxYAuOTlWAkVe/Z9nnMk+WPZO+h+WMPFMXFTB3
X-Authority-Analysis: v=2.4 cv=A+dsP7WG c=1 sm=1 tr=0 ts=686e65dd cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=dZLTm4hFAtb4TV4Lci0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10

On Wed, Jul 09, 2025 at 08:32:24PM +0800, wang lian wrote:
> Hi Zi Yan,
> Thanks for testing the patch and reporting this build failure.
> I don't have an arm64 environment readily available for testing, so I
> appreciate you catching this. I suspect this is caused by missing or
> older userspace headers in the cross-compilation toolchain.
> I will try to fix this in the next version. If the problem persists, a
> good solution would be to manually define the syscall wrapper to avoid
> the dependency on <sys/pidfd.h>.
> I'll send out a v4 with a fix.
> Thanks again for your help.
> Best regards,
> Wang Lian

Hi Wang,

Please try to include the context of what you're replying to in your
messages, reading the above I have to _just remember_ what Zi said, and I'm
old so that's hard now ;)

Please note that mm tests _must_ work without make headers_install being
run.

Your test must not rely upon those.

Thanks, Lorenzo

