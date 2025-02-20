Return-Path: <linux-kselftest+bounces-27057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC0A3D55F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCED17BAC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226161F12FC;
	Thu, 20 Feb 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/ymYg4/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NxrMiWN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724D1F12E0;
	Thu, 20 Feb 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044882; cv=fail; b=HYOo8Tpoesy6RQjEI9cTL7o9JJ3MjeNWpVV36Ug6Grw63wKdcz8J8Sj1Ugpc2gAigopKi6MLv4YEE1LK5m4a6L0K4gZfbAc+zEQAvba7FdVUdIJr6OW61jKqsiBlozS1WduSFZiMZczikXqsKUae30MBB2l25bi5palVH7kIaxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044882; c=relaxed/simple;
	bh=969UfPgq7WKKRnfnKD7F6qWlFCYRyRKOwDqyFhvydVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p17DjCT7tDtMC0d9zPyBQ3nfo2lHmr/oV1r/BQTD+sdGIqO0IVAA3Ep7OnMZOJSrZ44iHFFp4pN8+n8Epxhh/yNeuGZhamjxnNbRGjmaSsM/tuc/7ZLguNDpx2y2QrxBY5P6XSYSCbmH8GrJqm+wgNQQHUGqnoYYlND92tuCEtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/ymYg4/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NxrMiWN5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fhMw003585;
	Thu, 20 Feb 2025 09:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=969UfPgq7WKKRnfnKD
	7F6qWlFCYRyRKOwDqyFhvydVI=; b=X/ymYg4/icewmnv7nwrB1hr62X88PcbLpJ
	ac2Ks44LiHkK4b0i7y6jXrOCjCbkKO8Ufx3wybsWEjAmwcrmi9SVs0DuTdq3XpL9
	yUqRojJfP8fDNf5pIN6T1Hk3U2KPSWV45VGwCoaM+n638b0okhI0Yk1cDlC+iz9Q
	fo9RR2tWjAj7v5jUnGxQs2kM/NZtQ6nOOhdB0MumIWuRPJkC/1cNGl7WvBGUQe1G
	Txp2VSquAnQQ/FKsZkt3YQPYAeap1tRkWodMIUEtHHklv+dXEH1OYzB9k33mL3N+
	n7wOS6QG1C4Bl6bWWKDvzuDuAEj3DmZQplhnvemjl3JbTmZZtZoQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00puqmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:47:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9cJVE002129;
	Thu, 20 Feb 2025 09:47:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tmx9nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKH6hYSVNA5br3c2i4mxIHvVv+QoLZf63WlzIRFobePFqLK255LJQdF20eK1eXojbn6O0N6ZgkdIIGuxuomYB414ztXxG2Xcwdljw9lZJInvdi4ahVq2PcgzXEw/rUW8pFgU3o55N1n6iYOloi6ERD8ywOqSNHwIrW6GZLZ0e91sgNdPhN91qkRbVuYfloswKTuNlAMQDsJ2nJJLkMfOg3Rnr3j3XdmA4LkCYQIM2g+Hgs6lzUzy3KaZMsRUHQKGXw1N71dOfVnlMdq2Bv4GFPS0FN/osq5HecFEDcMnSSKqspfnR11PhrtmBWRxkVq7tojbwuuVuT4Oh5UNNnzgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=969UfPgq7WKKRnfnKD7F6qWlFCYRyRKOwDqyFhvydVI=;
 b=JGaF0hDgLOmX0MznXgoJ9ZDQW6ByNBh79vPVkwpg2oqCWB5Eb46L/yCIdvWe8l25bzqDvsh8DrohwJQKnK3eE60XJUhF9MgGL9UQU8oq4i7vetj0L6rtwmCySk6Ihmrqm1kD+CFDq8YNStUKRds/BUAJkrr315WQvyOKDC9R5xofJLzYFL3kWP+5KvkycFVPh9uaujpQcB8yebXQRRnt2FXnyMu4dDFHhSsdbXWPXDq1ErWJDb+CMnBzQPr16A02pcg8TtRv4kQ374I3JRjfB5FasR7rNkZhtZdHc+2Hw+tH6Xt3NL+IxuyQYXB9VPgNCFPdJHvW5iCjReduhfm15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=969UfPgq7WKKRnfnKD7F6qWlFCYRyRKOwDqyFhvydVI=;
 b=NxrMiWN56rtXOVw7Jn1/W1Vh+Fw+cTMH4vecAK3g39imJC12qMqG4gL50lpchjhTC4kJrdR0Yxo1K+EUFIhh1oNe1ZJsn/VMSbcogF1YzaScKHblFu0GNpry1d797Ej9sSuGX+A0AHVTGD/CL5U7qRFYf1VP/Jh+yVc8VdRRApk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 09:47:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:47:35 +0000
Date: Thu, 20 Feb 2025 09:47:32 +0000
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
Message-ID: <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
References: <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 791dfe15-f3a3-4eeb-9cd8-08dd51939a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcA7MNArPkqjZtPk1bfe9214ForC9OKl+dVyC/uYl5cTDltwbuj2/Ejva2ls?=
 =?us-ascii?Q?jXUInbdWEIW8CGN2vzgwt/KvyW8IzKfsSku4nYb5lhp0SGJJEan0RCRoA3yr?=
 =?us-ascii?Q?00H7tVRhcIpBa33FeVRmF2DRSmeCdGYD6jmZ5lXThykSYg289rE8N+9+WYBQ?=
 =?us-ascii?Q?02SS6YKyXr5JZgu7nkrrRlkkAi1PTBEtyEd+F6d2fsOPzQ3d3mo7uC/PhG3x?=
 =?us-ascii?Q?xtmtCOdg8ByLs2HDtFDpJVhegZZwSktkViEn2q50LS+lNVt6zPPfrJfkZvBo?=
 =?us-ascii?Q?grDT9P3gEaC7n5SHw/O6dyZLuHheAzf/aIZaVdBt/MzOJD9sywd9ILk9CcUA?=
 =?us-ascii?Q?R7cYHvgTIB32ExHhs4uToyr1Klu4IO0EaAtf7ZpvcghTkmkXB6hBWSbsTXWJ?=
 =?us-ascii?Q?8ZlCilCPuDI4C0fmYRIhWhYOk7bW/u2DdCT7IA+IvCrEVLgpLZ9x++up5u4t?=
 =?us-ascii?Q?0kLCCvdtG41Ir4OsL5AvB4FN6Ob0Z5nWsnAOp41Tm1ieGFVeyC8/YbP7HQDX?=
 =?us-ascii?Q?eGFMf9o0ZUsymkETZ7PUAJiRP1qx5hb8vq+FpPTJh3ZkT7Gy8iGmgUGRVO5o?=
 =?us-ascii?Q?dtB/wy/vaLLomVxkzTNdcE+P/ZQk5iCWZhLbI7nDmM1+eVD9KhJq9cbEXXMc?=
 =?us-ascii?Q?urQOwu2JZs6sxSqhR64YQNsNrdNy+sagFhOWX8B1gvac1PQkSMNk1C3MxoLR?=
 =?us-ascii?Q?zpA5lFUruYsTH1J6Tz5ju5wpeDzVYWDYLeEoDX18jXApYISXEb9FCOLpzNEh?=
 =?us-ascii?Q?uwmXgupSEqeNS4VMGYLcN14INZCNsozI8SU6Ni96wbbEDRcS3CRbEQwQQ0wY?=
 =?us-ascii?Q?6Bx/UAUn7kHQYdENuCcC+mD5AZ2J0S4ZYVHHsxOyUjvlAJ/K5XQxS7rZoEOr?=
 =?us-ascii?Q?zcRaYjjt5DqLqt0xnvKxsn2tZCNon42+S/rtufsGLFzXNAmIFRynsrJIXmNN?=
 =?us-ascii?Q?VG2W+hlD5QXbw0p6gGwMOkvSkrE1aQ1DxOx7QNYsNYeE88g/2i4seg92jbKY?=
 =?us-ascii?Q?nfJCRBkkswGkKEqo+GY+aVKZdB+qqPRBPmysAWgA+q5ac2I7vtnqB+hiQaj3?=
 =?us-ascii?Q?EZ79OxpVKS4/m/gaJobTlgmfQIX8pnt6jr9ZpIVA/1M99dbOzwEwX6552pt6?=
 =?us-ascii?Q?9sqGPdqT952szHfYg9t1519IGw8Yj8UTV9sU+XxPiEcJXpkJpPPcbcy9vlHg?=
 =?us-ascii?Q?2A7Cg+lIqOyPQ9wsrl5hDYV6FajfiOwYlO4YiXW8NhoiPUrjXLAIFc/TYbrb?=
 =?us-ascii?Q?TbnF2u67KomMyhDRhtY8t9EG4GLFZajh6fOBbS2rtWLcZClyqE0+holCw37u?=
 =?us-ascii?Q?fHdCheY/22UDd75X/3gO6QnPTM5OScWTXatwz0O4OlEyKSEcssUi4Rcylspn?=
 =?us-ascii?Q?Gmmf/evR+lj9D66VZaT2WZppVeRM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6KLgZzcbgqi4z3Rm74790el2ndmzc3fjoZbmvKiC/nEb9p88e3kAS0Dzjms?=
 =?us-ascii?Q?ddv298v1m7V2aPVkaANxu0lZzIOJo+Zm/6I5pItc5gtgNe7IvbL/+rgWVx4c?=
 =?us-ascii?Q?QdsMSjPBFnQLs4bFizuqKLnUecID+s6p+kBmZyiaMbOylg7H2KjqHS2ygUAV?=
 =?us-ascii?Q?Qgog5UJcBVXFGq6CRo+I5Mz0DVfjU1YILyqGFamPlqKAqD7FC2+UAi63zwwu?=
 =?us-ascii?Q?WeW+eqibxeOUl+T1Ah7gjRmSowX8v40HSMxWSvwk3755yEpjIvf21r5np5No?=
 =?us-ascii?Q?XsfYOq5clvKaPlYvV2nT9O4IRQ3KrDAA9PaFVCu9WBc/CQClYEvw+P2Dqww2?=
 =?us-ascii?Q?cHCFf4GLHfqr19u0IwOXTF6/nTLsib75EffG+u/X2SaO1Gp8WxOJghmi/AAu?=
 =?us-ascii?Q?lNRhx0FMEyDRa4Sn4/G+l8lSidfmITGYSxO7i9B0esDeLpFf9RP3uQI6r3sX?=
 =?us-ascii?Q?1osXpnIpsFy41fwrJhUl2hrdItEIT34KWQCW9uGFRH1UY+m9Hm3AhrCsvXDH?=
 =?us-ascii?Q?j8ZJbZ3cTADMPLFn/MD+/J1JWHSlZXoNNivuFcY8LZUUv3aKLsySSruvJg4A?=
 =?us-ascii?Q?0KfwBhhcJNagdEHhlsDdJ6oeF4ke8CvFcxZ8dm4Vkp7QtPLqsho2qzyt0YKy?=
 =?us-ascii?Q?QML5qF5hZZXlVUslsjhRWrmTjX8rlt87l5KG3UxmoxTQ0ruzkN1gO16kVqGI?=
 =?us-ascii?Q?D5vKfECSWJH13C8Bhq0F9pWSiCY/Vdsafcnor/vKFGLtamISwck1nBeQWzP/?=
 =?us-ascii?Q?lhUGAb/p2Xn/UtX/d1Vd1VuQf5CkEvHjIwtQ602OqEFCvnEOxeNug6eTm+yI?=
 =?us-ascii?Q?zHrY/ImhCAQPR6XzWZtjBUg1NBHmYHY5rSvY3aNiP7iACRCUwmzrWcPf/njM?=
 =?us-ascii?Q?mjW8N2LBYzNNf0N277GVYD1S0D074JC1TsC0E6zgNNIBW+2K/kWnuvXWMoOT?=
 =?us-ascii?Q?kTs5kAoYAGcPsW8PwqLJ4T+U01KFMvRHgHYyHNwbITKPF5K23qMb03ZEaxsR?=
 =?us-ascii?Q?WSC7JKEEYYK+l9KWlZlWtUgtE4ZbKrxqEmWoGFmpHLiuvSTNg5mabVSsToDo?=
 =?us-ascii?Q?cL7fI3xg6IqMBZ8vm+5ZVcotLpXBSg3bcqLRJspsVZtIwyPSpAP9gQsiZj6D?=
 =?us-ascii?Q?DPSpGTurXSJqSFeyQuNzDYETmE/XqAvxlAC0RM6UtRNRyjRWJyjcqbymAV6g?=
 =?us-ascii?Q?tH9YAT7rvk9yyu2aJL3RB/LMc0h4p22i0DDWr5mI/L9c7/+qZ2ed+MsRKPnn?=
 =?us-ascii?Q?LV+vsRz7ZZVNNUztU+d8628Yh4DnBWvboOPWg7b9YYFBX1TLnPtYlvZsTPIl?=
 =?us-ascii?Q?KesCrv3X/ZJ8tYXQv2hC11OZ7WlKgPb+PZXCChYB2qT2mxTtknF3QUjxUJBG?=
 =?us-ascii?Q?6LZrqiKUd8igAuAuTWm42iVA7CWucLMNrHh2lYT3VPZqJPLJCyFnB6zdQHcH?=
 =?us-ascii?Q?olSLVQ8ufZOOfKY61Fk7DoA49T5LHY4187VEJEfRZlNLi8I8+f1HnFwCj2yC?=
 =?us-ascii?Q?b+KRQZsryBEs+DeiQV9DwbFDoNJLCrhjZ3A1Edmz7aXO+0fKnlhyW73J2TLj?=
 =?us-ascii?Q?01h/lXw+SU3/po3JNsfB2aVvCPbQc/NnaIzuaLKl59FC12Urd8JITUbVa/kA?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N2x/PqgwjozybmC0uGY5nxu7tywcvKkOpHawkWQmGHWayoWupmIBmP+xHgipsHW7rKj/2Ppf7rbfmFTDXIm4QegbVs+BsJ+UetNU+gEm9CXDAp0s7GM0CzZQe9zJsHqK643mEv1xqabN4N7eCwm8Gnkg60heasFlF2HEHPf+EjynvfKlXONIeZdeb95SrES+C7umUGhYWE8L6k85IuzL3p8gh28o5PDoatYBOSBqvqj5JfLC+qn/sG86ngtEcp7zHE8hgF7DnIg1rj6+M4vfbsuBQNJEZS6jbRIIPXeQ3qFwkRGFwvJ2x31mrgH93X7CiCQFZ93Vz0ETLCyF13J8x50EYFInecTxGN3ArmD5Tc8OkVlRiUUx8aqVJh/HRq7WrsGZbFz3EeqbopezCujmnmMQ3Py3CtS9V4CJK4io1R6At2CGCogOKtjrFL7xImTlXiXhm29KPlNgnL9v2ZsS0hRLMqAguburSb1e+x6iVszJemp7oUw2aBm/fms7bq2tmHaV83yTBWV91J9iVkZrPqAIHs9kRRr1TV1bjzAw33LGXSLtgamQtc8LZUR/YFMU7jpguL8tQTJZgHukkYDPBz7tMPn8ym53yS466OlxeSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791dfe15-f3a3-4eeb-9cd8-08dd51939a8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:47:35.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy+mpQ2r2yLW8a+WivJQecDx45s2/QC4RWQ6uwLBig1oK5XeIZ1nYfkHRWDvlusMCHowAjfGK5jSPiAEt2oMrLxhDTTYDToNP3qy8BRAnAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200071
X-Proofpoint-ORIG-GUID: i6szBFUC21D4ZQy_OaiP4VhauCTDPTMg
X-Proofpoint-GUID: i6szBFUC21D4ZQy_OaiP4VhauCTDPTMg

On Thu, Feb 20, 2025 at 10:23:57AM +0100, David Hildenbrand wrote:
> On 20.02.25 10:04, Lorenzo Stoakes wrote:
> > On Thu, Feb 20, 2025 at 09:57:37AM +0100, David Hildenbrand wrote:
> > > On 20.02.25 09:51, Lorenzo Stoakes wrote:
> > > > On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
> > > > > > We also can't change smaps in the way you want, it _has_ to still give
> > > > > > output per VMA information.
> > > > >
> > > > > Sorry I wasn't suggesting to change the entries in smaps, rather
> > > > > agreeing to your marker suggestion. Maybe a set of ranges for each
> > > > > smaps entry that has guards? It doesn't solve the use case, but does
> > > > > make these regions visible to userspace.
> > > >
> > > > No, you are not providing a usecase for this. /proc/$pid/pagemaps does not
> > > > contaminate the smaps output, mess with efforts to make it RCU readable,
> > > > require updating the ioctl interface, etc. so it is clearly the better
> > > > choice.
> > > >
> > > > >
> > > > > >
> > > > > > The proposed change that would be there would be a flag or something
> > > > > > indicating that the VMA has guard regions _SOMEWHERE_ in it.
> > > > > >
> > > > > > Since this doesn't solve your problem, adds complexity, and nobody else
> > > > > > seems to need it, I would suggest this is not worthwhile and I'd rather not
> > > > > > do this.
> > > > > >
> > > > > > Therefore for your needs there are literally only two choices here:
> > > > > >
> > > > > > 1. Add a bit to /proc/$pid/pagemap OR
> > > > > > 2. a new interface.
> > > > > >
> > > > > > I am not in favour of a new interface here, if we can just extend pagemap.
> > > > > >
> > > > > > What you'd have to do is:
> > > > > >
> > > > > > 1. Find virtual ranges via /proc/$pid/maps
> > > > > > 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
> > > > > >
> > > > >
> > > > > Could we also consider an smaps field like:
> > > > >
> > > > > VmGuards: [AAA, BBB), [CCC, DDD), ...
> > > > >
> > > > > or something of that sort?
> > > >
> > > > No, absolutely, categorically not. You realise these could be thousands of
> > > > characters long right?
> > > >
> > > > /proc/$pid/pagemaps resolves this without contaminating this output.
> > > >
> > > > > > Well I'm glad that you guys find it useful for _something_ ;)
> > > > > >
> > > > > > Again this wasn't written only for you (it is broadly a good feature for
> > > > > > upstream), but I did have your use case in mind, so I'm a little
> > > > > > disappointed that it doesn't help, as I like to solve problems.
> > > > > >
> > > > > > But I'm glad it solves at least some for you...
> > > > >
> > > > > I recall Liam had a proposal to store the guard ranges in the maple tree?
> > > > >
> > > > > I wonder if that can be used in combination with this approach to have
> > > > > a better representation of this?
> > > >
> > > > This was an alternative proposal made prior to the feature being
> > > > implemented (and you and others at Google were welcome to comment and many
> > > > were cc'd, etc.).
> > > >
> > > > There is no 'in combination with'. This feature would take weeks/months to
> > > > implement, fundamentally impact the maple tree VMA implementation
> > > > and... not actually achieve anything + immediately be redundant.
> > > >
> > > > Plus it'd likely be slower, have locking implications, would have kernel
> > > > memory allocation implications, a lot more complexity and probably other
> > > > problems besides (we discussed this at length at the time and a number of
> > > > issues came up, I can't recall all of them).
> > > >
> > > > To be crystal clear - we are empathically NOT changing /proc/$pid/maps to
> > > > lie about VMAs regardless of underlying implementation, nor adding
> > > > thousands of characters to /proc/$pid/smaps entries.
> > >
> > > Yes. Calling it a "guard region" might be part of the problem
> > > (/"misunderstanding"), because it reminds people of "virtual memory
> > > regions".
> > >
> > > "Guard markers" or similar might have been clearer that these operate on
> > > individual PTEs, require page table scanning etc ... which makes them a lot
> > > more scalable and fine-grained and provides all these benfits, with the
> > > downside being that we don't end up with that many "virtual memory regions"
> > > that maps/smaps operate on.
> >
> > Honestly David you and the naming... :P
> >
> > I disagree, sorry. Saying 'guard' anything might make people think one>
> thing or another. We can't account for that. I mean don't get me started on
> > 'pinning' or any of the million other overloaded terms we use...
> >
> > I _hugely_ publicly went out of my way to express the limitations, I gave
> a> talk, we had meetings, I mentioned it in the series.
> >
> > Honestly if at that point you still don't realise, that's not a naming
> > problem. It's a 'did not participate with upstream' problem.
> >
> > I like guard regions, as they're not pages as we previously referred to
> > them. People have no idea what a marker is, it doesn't sound like it spans
> > ranges, no don't like it sorry.
> >
> > And sorry but this naming topic is closed :) I already let you change the
> > naming of the MADV_'s, which broke my heart, there will not be a second
> > heart breaking...
>
> Lorenzo, I was not pushing for it to be changed *now*, that ship has sailed,
> and personally, I *don't* find it confusing because I know how it works
> under the hood.
>
> I was trying to find a reason *why* people would thing that it would show up
> in smaps in the first place. For example, just when reading the MAN page
> *today*.
>
> Doesn't really matter now, it is named the way it is, and all we can do is
> try making documentation clearer if it keeps confusing people.

Right, but I disagree with your analysis. In case as you say, it doesn't
really matter at this stage.

>
> Your conclusion is 'did not participate with upstream'; I don't agree with
> that. But maybe you and Kalesh have a history on that that let's you react
> on his questions IMHO more emotionally than it should have been.

This is wholly unfair, I have been very reasonable in response to this
thread. I have offered to find solutions, I have tried to understand the
problem in spite of having gone to great lengths to try to discuss the
limitations of the proposed approach in every venue I possibly could.

I go out of my way to deal professionally and objectively with what is
presented. Nothing here is emotional. So I'd ask that you please abstain
from making commentary like this which has no basis.

My point about not participating with upstream is that Kalesh is now asking
for an -entirely different- approach to guard regions than was implemented,
months after it was merged.

This is after many discussion were had including with people at Google
among other organisations, an RFC which clearly delineated the limitations,
a talk at LPC also.

I feel I communite these things better than many people actually, I go out
of my way to document, add extensive self-documenting tests, etc. etc. and
to participate, engage and take onboard feedback from others.

So I'm suggesting that clearly - something broke down here. There was a
miscommunication, or there was a lack of awareness of a key requirement.

I mean a large motivator for file-backed support here came from the LPC
talk give by Kalesh and Juan re: ELF guard regions. So obviously that this
breakdown in communication with upstream occurred is very unfortunate.

I am not blaming anybody or being 'emotional'. I am simply stating what
seems to me to be a clear fact.

I genuinely don't understand how it could be seen any other way? How can
requesting that an entirely different alternative approach months after the
fact be anything other than some failure to engage with upstream?

I am emphatically _not_ blaming Kalesh by the way, whom I respect and with
whom I have no problem, in any way whatsoever. I apologised when I realised
that he simply was not aware of this limitation at LPC if you look through
the thread, having politely suggested disappointment at this not having
been brought up then.

I am suggesting that within Google clearly there has been some form of
miscommunication or failure for one aspect of things (this limitation) to
be expressed at the right time to engage with upstream.

Sorry if you misinterpreted that as something else, this is the _only_
point I am making here.

And again, I am going out of my way to find practical and helpful ways
forward - though I cannot see how we can possibly fulfil Kalesh's needs
here.

>
>
> >
> > >
> > > [...]
> > >
> > > >
> > > > As I said to you earlier, the _best_ we could do in smaps would be to add a
> > > > flag like 'Grd' or something to indicate some part of the VMA is
> > > > guarded. But I won't do that unless somebody has an -actual use case- for
> > > > it.
> > >
> > > Right, and that would limit where you have to manually scan. Something
> > > similar is being done with uffd-wp markers IIRC.
> >
> > Yeah that's a good point, but honestly if you're reading smaps that reads
> > the page tables, then reading /proc/$pid/pagemaps and reading page tables
> > TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
> > /proc/$pid/pagemaps and reading page tables once.
>
> Right; I recently wished that we would have an interface to obtain more VMA
> flags without having to go through smaps

Well maybe that lends itself to the idea of adding a whole new interface in
general...

>
> --
> Cheers,
>
> David / dhildenb
>

