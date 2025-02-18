Return-Path: <linux-kselftest+bounces-26858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C7A3A083
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9892918843E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2226AAB6;
	Tue, 18 Feb 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVBo0z3s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UOb4/TOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3B26A1D3;
	Tue, 18 Feb 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890406; cv=fail; b=rgfnlqwrDAgu9N0Q0Nu/pWSanGch8PwNqXgEKFbcQWvnPTkFQ0OKlRBNg1JbkeWW+s9O/jLt5Tq1Me7nrcEH5qnyGpsSPrm0zZKrBsTZagibt/QUGiy4hlws6Lvf4hgZ0QCgFEMWRNUDDpCwX5GGaQanIzUaIXKaT8GPg1L+zSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890406; c=relaxed/simple;
	bh=gow4xfUAB4sqZAiNfbGt5xELJYJyyKhPslmY8xFbELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jN6mLL/eQUHsVETdMpVLS3iUDXJMieF5c6qr7SPm1WeNDJRQq0lRgE83Jx4rWQ9usR1LIoMg54lzo+ar9bWYVVUQwmbRqVN+gEt+ug/2hgEL8qa4VU5gYV/wf7CIJREDahCGx2rF73WqA+AxXsIWJLpuZF9TUP6/4tcHOYixlzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jVBo0z3s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UOb4/TOE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEHrx2008208;
	Tue, 18 Feb 2025 14:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=m4AbTK+MUT9Uq3NIVG
	rSHFe6Q3Hs0Ps0s7gtWeEMGmM=; b=jVBo0z3sWnUhg5wVISqdbF7gP+xLqry6Ga
	3mQmMOnuH3Q2N4fl6P6rrLYS4z1EJswonwlIugOsGQrwSI0mbSh6y7b/BqQIN92k
	By7saG1/gSj2ygqsJZPw1/qTti8UFXYUJMwIgjEi83mVCq7vqRnK61wGzgw4MyRq
	MyZ9BiEynzi0iEf7co5jN0YIFimMi0YsD8PhpLPA7Y09NwqmyVKnJQheoGNtRjuV
	Ggn/WHAa3ZQKs9iX2rn6l7C6VEHmjT/RZKJUvexm06hPmEbwNCKglL2EK1vAUm3S
	IM1cu5NrWRBoWUZC1PgzaEPag4wdlXPOvh52GmHKONE6q4EHrFmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tqxh6b48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:53:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEkZGD005194;
	Tue, 18 Feb 2025 14:53:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc8vgx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etlxOLYIAcDyQnfsWs3dpC34EE2hdLAmdAmTooO0dzzCMPZ2P74sTZxC4winHJajAqpwhlqGPDnlKPlPnmbF2wq7lT/9vWzfiCIJNHPtZlhFySXH0trMiMJtLCUqSYB6XlPWyqUn6+JVdp5F1tdt6/n5wwun1srAOVNwww5Sp3Od8r/92b9sd77tpHB4maqW0Sw822rRdGauDJklBAEephXEGRU53zSmgu1eMRNxGRa5VqFuMenGAbL1Tx2fXyobCqdgz8+UhmUaORY2P039SwJKjcFTq6kX6/sVOqsbEtqVNZILaEn8qCX2Fj/IFKyR/rOuSyFYOvRAmzJ0M7nsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4AbTK+MUT9Uq3NIVGrSHFe6Q3Hs0Ps0s7gtWeEMGmM=;
 b=LisKbl0aUVsTN0Nw6LE3yADC+mqoFL8O/M/QWagq36s0X/zeTq9M3KUwB9O5T3b+moU0HEiUpuJ2v688gc5aXhHK7UMVR92ifw1I3qJfAHisLLDuFRmUT57xisCnpbbBTauud78iXxRIxfOSuzQFxl7pB7oTV0AFkPcSdmDwENsI72gKNcKkqxPQR+S6Ucb3GeJ7qWMpudBwJ5XqBwPLm0Xjn2dOKbyh8+1HHev2nUTOlkJp20DdZhKRlzjlWzAO/eT5NbLtDWmA6eQb0hr4fl7fnf/ceEiubeaYfILXfSXPsohc1DzFRU5kbwXOlP3QK4rsdtHe8uCKliP+p4qCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4AbTK+MUT9Uq3NIVGrSHFe6Q3Hs0Ps0s7gtWeEMGmM=;
 b=UOb4/TOEwnfTeVWxx+9/WRh8FzSTKxYCijBR7hBFIyLa8+NJJOdP/hH3fYNFTlFULPoc22ktJQahPc/gb+KwWoLL/6RYWt5PJJljjsTsdCDv+/BE7id5m/sG6+7U4sqQJkogI142mTO73KTgukHYM8vc3MrQ1sXxix7dnEzamuA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7765.namprd10.prod.outlook.com (2603:10b6:510:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 14:53:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 14:53:04 +0000
Date: Tue, 18 Feb 2025 14:53:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f79209-44dd-4696-dbde-08dd502bf2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yg1EJ7aLHzrjfQ9QLvxbXqcYOJm2RT7SzdjujwQC9MXPiwavKEfzBVcPVt3h?=
 =?us-ascii?Q?Lr3X+hey3ulL23F9M79LBixedEeil+piAdJp2hwFSCWOBynFscCgZwvwQZDn?=
 =?us-ascii?Q?jhFOGqYEuYrCGTotTLwjUhqsaJ3DJMDcjhHRmOoiZ+NbhdZz/YyZz9JMSZTX?=
 =?us-ascii?Q?tFBRnQmgp/6vM1H+SHPUckivLQY9yRbdyeXjA4Uq2Jw2n/Ng0STQgxvclcEe?=
 =?us-ascii?Q?MP833sX844VgVJABAo8/pOd8nL/WORbWIVcD0xCQSj2P4O+z5Ttjm9qzCF4X?=
 =?us-ascii?Q?LAga+k57XwvKt5Aw5rR9Ju3kScF8AsK3/VPyQLxlN5SWLrF9mNangxPuwhvy?=
 =?us-ascii?Q?NiMaD03//eShEJKDUPc8btTDdO2XUzMsW2s8d+5Kk36UA267CKo/9CwlDvWl?=
 =?us-ascii?Q?N5mTYW0Oa/h/q1+xir+IveCChVf+IjD4MWR4f/J0WnJBaqZpAfY6fjcDZ2Cg?=
 =?us-ascii?Q?wLTlEYZ8P9XYSb8r90LiEos1FOupHJRbbEc/7SlfamVmJqY41iHM9ALT7bDB?=
 =?us-ascii?Q?+L7xfowuyma1NlvYpQX/bniuY8u9qaQcWbRgd0jfwDsy4AIu+UnFeNqxrvw0?=
 =?us-ascii?Q?TogTNVIArHTG3T/omxdIaVSUCaDVAcB34iFTvdohhKsfeZZHxEYJW6kDhvZ/?=
 =?us-ascii?Q?NmIdnCnAbTvvOaf4zRcPSy87hciZMEnW7kMjsOe1SzLKyTJikpX1uuD0JGNJ?=
 =?us-ascii?Q?oYsUTx6R95OdyRQnXEAPo8zZ67hFD8xDFpY7e8KilbPKFa9ukfTX9XU8VFrS?=
 =?us-ascii?Q?PZorht0SH3/RfArzEhTa/oyiLoG5P8kZmYdhCN69oYQWE0gajAELIceSscg+?=
 =?us-ascii?Q?h0AaHLKPzc2TpEOf3fP2m9DKswVAeSboZSamwH/h6IpbPVzJxFniZRnGstJr?=
 =?us-ascii?Q?7IvALWAqhg3zaoSmr4WYltaZiRns0a0jSCg0Si3NvtzYkHB18MQCUxgUYJyF?=
 =?us-ascii?Q?1ulHtfDfKIc8BhNPw1Zren7MwVZhl26FS/fi7HDRvxdaOnsXqSPTt6wIty44?=
 =?us-ascii?Q?347YRQcMH55SfreNEKupIVLhvLjkLrTP9fOTl928l5x9hjtjloyA2VjY8Tb6?=
 =?us-ascii?Q?Tb4VjjJqUj71RK601MxItyVMMorE0p60/KLa66X78INBnAIfJcCTw/CupbUi?=
 =?us-ascii?Q?k3p899RjHGYXvH6gOmQ4nKOe3cwfubs2AgyiMZ9KAiLZnRLsxpXpNWPEO6v/?=
 =?us-ascii?Q?nTjDFMljuGiOJh0x1vdkMA0fsmx/FhRXg+Tsc05j0+vmFnfOzl7hWwH3r2N/?=
 =?us-ascii?Q?9f44dv0+WZi16cT/dmcAwAi1riC8HnIkLptlT2CBPhDBszVbExZgdaFaRlTA?=
 =?us-ascii?Q?dyZFXQ60bY+BMwcmbcvyQ50Q16PLPfNHWNzeTHrbuxyzs/s8L5zS/d9cw+l4?=
 =?us-ascii?Q?5ND8p7s85TVvkC8t81nlMD0hIKMf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z34Cf/TYq0UxxPNq94uQoKTRaJ7fpNimaysEBUsbklDTUyvbjHCNFesxYeAs?=
 =?us-ascii?Q?HSUfXVwJexnCEqxGeSDbBmosOZLtQCD7I6W3spYFgGBNUdYyQvAOppVIaPtq?=
 =?us-ascii?Q?AK0vU5DyojW5RDqAAqqoEhxiPcySsewvKaCkuDwoXXXkM1iuTAGVtiYBt+HX?=
 =?us-ascii?Q?DOwsY/Hz0n8fg1EJku+TZxNHcPWhi849s+iS8mcYI+KXMHS6A5moWz/IEXtM?=
 =?us-ascii?Q?eGsGSwlyLxn9AGWcbn4ztiawTiBluzCcK+Kmfk6b3lt1eylcD9xzAT1nhNct?=
 =?us-ascii?Q?VHcq5UY8/WsmBrpRRKmABLPVacQOBRGi553iqhFOJyDuJ86PgBhgAzktkNm7?=
 =?us-ascii?Q?xXA0kHYoHxAQ3yGZOAK4b9ZyWj94Zn/UyMAiFWCYvqClVqiHYJAYHUq7h/3U?=
 =?us-ascii?Q?ksuQ7jzfC+QIuxmF2/gfKgilRIL2LYvn9oSyFdUtRylS1jYu/5lgVyi66y1w?=
 =?us-ascii?Q?A+lrIAIonIxWI/pZ/Cr+v+dojCwg0A9OLKa0qUh9QyVPCm50DDAxXu6Nkb4O?=
 =?us-ascii?Q?1icZQObaF1mKytQlXIH8GSyWxIMArsO/WKnIjNxSyq4kZaNzVoQcnomeu5Cu?=
 =?us-ascii?Q?agRJlqVmpuwld4s6Zt2ZNZZvUGAXiiwPMDJ6FJkq8nOjfKqyee+4tVh3L/VU?=
 =?us-ascii?Q?zVnIhRQWPw++mhlUU9SrIgRelyzSMeVjeN0DivyoFT9cRnEDR7cfmNWqDBZp?=
 =?us-ascii?Q?f3h3SDtRDVMReQUYFvjZFPphbuQpUgjLBNCSAfkU8EmqNYB9E3KYUMXs5Y9i?=
 =?us-ascii?Q?uRsekl2ItN/NuKC8naNAnlhVR5o+HRWbUcxc6CA7GogORxSokxBkRr5uD/oH?=
 =?us-ascii?Q?7Ly3v0g0AqR/GL4CPE+EJvFgd02SU4lEn8wvNFYZ1PmCHk+s0KpF6D0yNH1v?=
 =?us-ascii?Q?m5SZAnQ1gnn7DzXarcuhIdYvhbpVOHteNo0KvWd15mgdHoIuy64uO1KhfWqV?=
 =?us-ascii?Q?8Kl6uEmfuykf5kpPjsYXA36sbzqqo9ZhDGXvAxhfgGophKoaYpqnWwKcnp5O?=
 =?us-ascii?Q?GAoOrd97CXypeVO6z7gXVQcXc4FCR4nurPPIkbEFpVGsegmpAMFGwEsM6GHF?=
 =?us-ascii?Q?NitWUgWsF/sHJ9twDXJqYxNN2YDDxxyFj9PRawoLV3/44/yeW8TQ32o/8WtY?=
 =?us-ascii?Q?bEB7bSZ5r1DND2de90DFbP6ui7tpBC+5UMHovwue4oq7RoTwJiiK1wsSpBa/?=
 =?us-ascii?Q?HJUHdIfUraqsB69+WpVrsH6H5QCI7AWu5yuiXlZNNUvRZkSNQ3WnDhQ46grP?=
 =?us-ascii?Q?IbE6yL4KWFbGRnq4dA4cYcCvqdIRSmvMIKqV445CjKXSvX6BFbmCV19xASsv?=
 =?us-ascii?Q?wrSfXblomNDDsc+qk0Afa/WK4vhFKKbsGj4qYNdOyXAXMyMIGGZSNlM4BjvZ?=
 =?us-ascii?Q?FJA4c6brw/Tow4Dt4qoA9Y+SX5k3peGMEUPFQ2uM7a91WauXimcdc3zeNVZ9?=
 =?us-ascii?Q?2PAPoJt7iBIW/PBRw+YMvzH8XQXqy9UJJFwJO8QIYeOYlKXXCDWk4VgToeBb?=
 =?us-ascii?Q?qqz8yb9xwxc8/xvRi57QVvEUcBamRMFl3D+jqIpAAlMVC/qaHYFBpkkggeBf?=
 =?us-ascii?Q?nSG6o2MXnnU0sf0JiodEPgMvIymw0CKiOyJ9Dz37VPhIpZwy1i0is9o5fkv/?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hmdq/mwktn9oXc6kBMxlet7ejpjdyLWFVeXY7BJVcgBsRhyPkaX5hFpSkMWyyu13RpGQSfaeHEQygQx2XbegEbLZmY8oK2XMW3ZFHmtNcWiGTxVWShOxw6nWCapjWtzKuykqMWPKUlWx80pe2d5ONn1Ef8+jWr4u0sR6bQlKaMnFT4WFZN99neWl2w7Z1BEcGZH2Nj8JGIFIZG8xroKfBClgvTYArbGZO0Ow0nqMFdcZA/uabAaKmgoU8fhSWv7Q2jxxgqCUEzd+vU/rH/mW91ssqpKcsrwgRlQyE0OAjB8qj1HPg+K02uZYyFJ7FkwYeR9mOMqTnx1U89TeBmN0j7EkA9AyAqw+Ix2OfT1OgMhr4U9Uv0hiMMBRQWcb6onfLGe/kVHFLWyuOIxgBj0LN1Il4jsJWzrzZ8ZCfFp/6wZBOowYzIBjpChLv4ejNYDjgMLmYbkYE6RE4fRp8u88zSDLIT4tsa/8l2Kb/dGAJButns6ruMKpfTZa86S+i7AWxlPLjQASHaDWFel1Bvok1zLX7TrrQNfUX5UWgVgm3LzStg3C8ocjeXggnUQ9qs/4wUbngyzUSDUlPJIpBBpU5gAIB1hslMrQK9LWtkWFKvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f79209-44dd-4696-dbde-08dd502bf2eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:53:04.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bgj3vCTBk1nQ2Ut+N2fVgtBXxaJ+X9sK0+ksBX1U73ethJu0yOCb42zgI0v91Fxm6Wm7ffA6+z+SbazoPzPqExaOml13HzhNy/TQEC3XxGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180110
X-Proofpoint-ORIG-GUID: qCP1Zfs39O2QSwvqD8m8bh2Snxy0QyUc
X-Proofpoint-GUID: qCP1Zfs39O2QSwvqD8m8bh2Snxy0QyUc

On Tue, Feb 18, 2025 at 03:35:19PM +0100, David Hildenbrand wrote:
> On 18.02.25 14:05, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 01:12:05PM +0100, Vlastimil Babka wrote:
> > > On 2/13/25 19:16, Lorenzo Stoakes wrote:
> > > > The guard regions feature was initially implemented to support anonymous
> > > > mappings only, excluding shmem.
> > > >
> > > > This was done such as to introduce the feature carefully and incrementally
> > > > and to be conservative when considering the various caveats and corner
> > > > cases that are applicable to file-backed mappings but not to anonymous
> > > > ones.
> > > >
> > > > Now this feature has landed in 6.13, it is time to revisit this and to
> > > > extend this functionality to file-backed and shmem mappings.
> > > >
> > > > In order to make this maximally useful, and since one may map file-backed
> > > > mappings read-only (for instance ELF images), we also remove the
> > > > restriction on read-only mappings and permit the establishment of guard
> > > > regions in any non-hugetlb, non-mlock()'d mapping.
> > >
> > > Do you plan to address mlock later too? I guess somebody might find use for
> > > those. Is there some fundamental issue or just that we need to define some
> > > good semantics for corner cases? (i.e. if pages are already populated in the
> > > mlocked area, discarding them by replacing with guard pte's goes against
> > > that, so do we allow it or not?).
> >
> > Yeah that's the fundamental issue with mlock, it does not interact with the
> > zapping part of MADV_GUARD_INSTALL, and that is why we disallow it (but not so
> > for MADV_GUARD_REMOVE, as if a VMA that contains guard regions is locked
> > _afterwards_ there will be no zapping).
> >
> > We could potentially expose an equivalent, as there are for other flags, a
> > _LOCKED variant of the madvise() flag, like MADV_GUARD_INSTALL_LOCKED to make
> > this explicit.
> >
> > That is probably the most sensible option, if there is a need for this!
>
> mlock is weird, because it assumes that memory will be faulted in in the whole VMA.
>
> You'd likely have to populate + mlock the page when removing the guard.

Right yeah that'd be super weird. And I don't want to add that logic.

> Also not sure what happens if one does an mlock()/mlockall() after
> already installing PTE markers.

The existing logic already handles non-present cases by skipping them, in
mlock_pte_range():

	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
		ptent = ptep_get(pte);
		if (!pte_present(ptent))
			continue;

		...
	}

Which covers off guard regions. Removing the guard regions after this will
leave you in a weird situation where these entries will be zapped... maybe
we need a patch to make MADV_GUARD_REMOVE check VM_LOCKED and in this case
also populate?

Actually I think the simpler option is to just disallow MADV_GUARD_REMOVE
if you since locked the range? The code currently allows this on the
proviso that 'you aren't zapping locked mappings' but leaves the VMA in a
state such that some entries would not be locked.

It'd be pretty weird to lock guard regions like this.

Having said all that, given what you say below, maybe it's not an issue
after all?...

>
> __mm_populate() would skip whole VMAs in case populate_vma_page_range()
> fails. And I would assume populate_vma_page_range() fails on the first
> guard when it triggers a page fault.
>
> OTOH, supporting the mlock-on-fault thingy should be easy. That's precisely where
> MADV_DONTNEED_LOCKED originates from:
>
> commit 9457056ac426e5ed0671356509c8dcce69f8dee0
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Thu Mar 24 18:14:12 2022 -0700
>
>     mm: madvise: MADV_DONTNEED_LOCKED
>     MADV_DONTNEED historically rejects mlocked ranges, but with MLOCK_ONFAULT
>     and MCL_ONFAULT allowing to mlock without populating, there are valid use
>     cases for depopulating locked ranges as well.

...Hm this seems to imply the current guard remove stuff isn't quite so
bad, so maybe the assumption that VM_LOCKED implies 'everything is
populated' isn't quite as stringent then.

The restriction is as simple as:

		if (behavior != MADV_DONTNEED_LOCKED)
			forbidden |= VM_LOCKED;

>
>
> Adding support for that would be indeed nice.

I mean it's sort of maybe understandable why you'd want to MADV_DONTNEED
locked ranges, but I really don't understand why you'd want to add guard
regions to mlock()'ed regions?

Then again we're currently asymmetric as you can add them _before_
mlock()'ing...

>
> --
> Cheers,
>
> David / dhildenb
>

