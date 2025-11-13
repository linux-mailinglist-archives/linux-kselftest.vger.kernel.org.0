Return-Path: <linux-kselftest+bounces-45527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA82C56BAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E277B3BCE3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553432DFF1D;
	Thu, 13 Nov 2025 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eAUNmBKg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RA2UApyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944962D73B4;
	Thu, 13 Nov 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027705; cv=fail; b=SExmymlUBAUthqgcYc3mFe/M5I7lqFcHM5OR+g3uFLm2l4Q2cvskxflXudGljBd02G+6BZEm46Ukgmv7eDX/dRQfhmiZWkCtW/utbK6RmXx1QkdIuMXK2dGu08g8i0/BhyNeu+hmJor6x4k+VVSQAUagqJDVjaMtVpqXmJywnU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027705; c=relaxed/simple;
	bh=m2dGHZ+ABwYvBP/eG8nZNqhxIyGrZ9OmLlV7mJq0Qec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uug0KeJtgkJ9UH15zng1mf2YXi8145lBqTHye28RNFwWVzmy0gYttNSIDjetZiogafvJ5ave339NVxqbudnGz4jCVPslAgzIzI3wF78DMyzpzaLxrT0QegjGxec9HD/AiwtcHjAPxJ2Yv8ZbLzGr18/3my02D7YZNeX/pqRO9jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eAUNmBKg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RA2UApyr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gH2B020810;
	Thu, 13 Nov 2025 09:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=m2dGHZ+ABwYvBP/eG8
	nZNqhxIyGrZ9OmLlV7mJq0Qec=; b=eAUNmBKgJ1trPDH4MLxjyrV+vopnBJig2f
	+S93dw1mcTscMLit54WnQOy1bxGYrZRrJY+zyi35lTIU3z4paLPNAyruunZ6OJJt
	JiHZBoEIqxGqYlHXU1wz6PBfoGHbNS/tRaZYkKKf9NTNHqJnmockJMtpFQ0fzRoM
	HMaZrIGQj0RJh4fuDaTf2QI3lZgwY4DaKBGWPFg1sw/3iE8RchsIPSl1twYLTcWx
	kazgnHenmVTWeyI6wmkD49CT7qL2piurztjX3h7LsGOv1Q441SoCYgU7wcedFPYo
	+fo5hITF5z+ehrnzPgDbJ1ksVQfkr6542UsayKsS7/Doo1EAJJTw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjt9b9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:54:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9hojQ000546;
	Thu, 13 Nov 2025 09:54:42 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafes6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvdnLSMmW7P+h3AZ5d71Llkkw45scf4wZc4XLRGcPNaehM2GRZYloms4a2MdcF3uTgwC52ZeG6+X/A/eB2iFWFoDHPaLBLOuxmu4E9Px6lVrYutNvmwMRUs9CTVvwUCvYN4sTe8zKIf4vFHfA5BhHHi2NWQQZINsIAMcnDb+uhkvFophqw32CNxACcR9pAY2+27HOYBKZHi/Ia3gx61EpoqqOpbbORjU/QQjH+SPgOKMe6hlJuR5lkTz2GbhjiREI2CDezBdAA9j3Hh30Xz1OGYOXDqRFcX63FDovpKZffnPOp3r16c0sNqsa7Br6ll9cV9vhKKOjLb8jJOWGV6+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2dGHZ+ABwYvBP/eG8nZNqhxIyGrZ9OmLlV7mJq0Qec=;
 b=I+7SWOYiprRZWbZ6rJi30zhaqdu1H9nhgWZaLHVM20XNlOei+ODHyxL+4BApkqZ5Ziq9bdV60f4eAzMW4azXSDLeXzg+vRFwGPVHHasjeXaCuxn7uJUEyv4PSmENDqEATBty5h6MPfqNSBNuWP9f6+j4E3BgquTnzV0BnD0wt03hTyneu6C2yO/pwp/bgLqqPI9i9kcV/ouX9pi/zE++Cb3z68/DRPelDbs2BXJ2RIiaj8R8VO3B6aHdlBwRq9AdF5jVSE5R09224BqlzguYCrnrwQezSfnaaW1pNCcKyxzJ9EPcXltfhRKm/jc5/WeZaiodJ23Yn2Madn82EHJVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2dGHZ+ABwYvBP/eG8nZNqhxIyGrZ9OmLlV7mJq0Qec=;
 b=RA2UApyrOXKD3z9q6IKqOS8nYAcwJcRtO207vVwMSnKx63OY8ETzpfJJeWxUFueQHB08RRA02nGslQvsDbFSRtLMJ6agSxzy67FgPMCBl4kZyLymjVBghCu7hwU/7/6aLquGn/QTqtLVhd+tAgcov8AYR75mUknFoMYe28OIixQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 09:54:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:54:39 +0000
Date: Thu, 13 Nov 2025 09:54:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, Ujwal Kundur <ujwal.kundur@gmail.com>,
        Brendan Jackman <jackmanb@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-ID: <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
References: <20251113034623.3127012-1-cmllamas@google.com>
 <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0c9f95-af01-49ae-11f6-08de229aa92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaJrVPP9+swxrHF7c1yp/17kSo9QDcOx/a7pGON+SOeXi/v+Q6wgZUmvWZKi?=
 =?us-ascii?Q?yYDCapO7TqA7n1adRd6+NUFGY5Z2iruCf+vKLYFzQ5yPdoW3DUd5q/YfacrR?=
 =?us-ascii?Q?WszetuB8PZsQZoX3gumPnVuVBxjGe73hbAYC7G9IOLYWhczfQ2TMwjQ+SLEe?=
 =?us-ascii?Q?GJMbv2fpGvTbjqxBd761+3RNJtF35TIkQeztV2oGoOmGuDcMnQnjCktB5Kdp?=
 =?us-ascii?Q?OH5FLdrjoYf8ZYrtxEiFjuJ88C6FeC3l1YQ2StKPgCIEC5BlhSCoG+4t4Q9I?=
 =?us-ascii?Q?DHUlBXMQEws4XQTxMnDJbfRqQYHUq9C7eKOGqdJUrHSGI6yyfBnsA8QTxEa4?=
 =?us-ascii?Q?Kx7HsycFM66XKDJlDggG3/HvoLZYhGYzEvjdPHefInBOembPyzWYuiPS8DCn?=
 =?us-ascii?Q?AnNtNjCBGNibc8pLUot4xo7Xa0vBrFJhbrkm3SwFUlJQomh2v+pFqtR3khXP?=
 =?us-ascii?Q?8GlPcuwgu9vDOmrkz8rHHjploAlU78xxpMrabpGZg7vG6AjV3w30Uk4t2tfO?=
 =?us-ascii?Q?bpvyShldvYp46xQWaLF2E+qkPGJIgCFjFM/FvaQVSSdYQv8thjHlmlamuoo3?=
 =?us-ascii?Q?VocLmpOUCWYR0Av/3eizc7MJ0VpCGgmZcOcUKXBMm3Ldw1+rPcWJHg5ByM0D?=
 =?us-ascii?Q?rT3xudATK0YHLIQ1rBikmrYN6tcxL2aulvUaasBoTmxwKxZBeYQ68W3LTCmY?=
 =?us-ascii?Q?Eim/wOtFSi5zWyfGYfM8Xo47Zev1JbMfwMl1/ucoA28aSlNePPqcjGwFhoQn?=
 =?us-ascii?Q?SXhtMn1GCpdeXCxbpKVHyFiAv+3S1ap5a9F3fY6JvQYnzwoILTIJQnugAUbo?=
 =?us-ascii?Q?zvpcKtJSQPrXPVkDWSFpPxLsTzQy7uSIV9EZLMyAXESTm1Ghw33MnZ1oOtak?=
 =?us-ascii?Q?eBONXoFOBLSL9ebEfQmfG0tfSRDbYOVbvZP//q8CMIL17pFmQ6yOnzsvWCC8?=
 =?us-ascii?Q?wzjEt+xplxMwT85amiJY8bqTYN0ENpttaxwAtuxyvzCamYdOYhlcFo9D++NM?=
 =?us-ascii?Q?vKZSONexDGuYeiM0gv6hDe5EJU6pPFlMno0klGHE/TbD/tra19mvIqLo+Uk1?=
 =?us-ascii?Q?9n0h+G252yc4uh2v66IvjwGvNE6ewBtiN/dvnINdMt9BhF2ooh9lFOph2d/N?=
 =?us-ascii?Q?LqO7eZiMbg7b7mt0GJ5um14VLTm6tsMXKrut++Hh2lz/0oAy644ZqlcnHnM5?=
 =?us-ascii?Q?U9+AO3YfDpe/JCzvLimgn7yu34yDPCPUu4GlhqdzBnhNYqC6Hb72ycm3m5WG?=
 =?us-ascii?Q?4/OnMRvWQ5CXH3wLCRNwwNDTX8EP8loo5VUs9n2SIe/lLbrDOuf6opMrp06S?=
 =?us-ascii?Q?pnQ1W/TdyrGQCKJVAHyhoTKNz10mxICtkNL+uFL45Qkv6kTFGRY6C5H2U38X?=
 =?us-ascii?Q?p67huehXeJqRZJIpRsHILYcbtih5yHIOSTetojG2zNky5fQYfLMTwwif2+Gs?=
 =?us-ascii?Q?bBAoz3PvtyRZz3fK8xkQGkcYN5eWhbcj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wnc7hxKtwHbscg8ZOkbZkwAyd4wo+1nxzoEkUGBNAfIdUjeBBcUWgs/Y+yeG?=
 =?us-ascii?Q?B8xlGJqEacJLrCFWBT5nETFYJbEKW/5omkAzJBdkZuOSEgwow3whtFuOOFOk?=
 =?us-ascii?Q?OWTwV2wdamqjLhbT+JoNyaUWjTd9s33yRkZiqOPtXXhjeI0U2Ynod00VWAi5?=
 =?us-ascii?Q?Pj/iT8Dx2lpRwSkAnK+pvlFkV3g6SUWDBd+QzKH9tgLoX/eOkZll8Ypkg18k?=
 =?us-ascii?Q?gJAtAbgyDAQk8T1aUyrMCL/yRAovxaUdCefx8TdX+fQ4a2LVo/Wg6993hvYM?=
 =?us-ascii?Q?X3dcPbNo4lyZlOSqbcyq0RttXBgX9KVmjStDp5y4WmaZsHBFlNjs6EzPkB6t?=
 =?us-ascii?Q?0Yhs6cDhdyj+A+t/8j6cnRwNdl7uy/WnF0vb3ob+6l/haCMVW+2pQzXtGU6f?=
 =?us-ascii?Q?PMDW3TwkAYb5W5G2/zyC3BUQe9IBPN0VyeP72hDHAgfF7nOKjRN2vQIBQPpe?=
 =?us-ascii?Q?2mf64+I9EeINsKXV85OZg9nO8NuRAj+HboyMV0xjCkPsTELOx+Vsqpd+lHwH?=
 =?us-ascii?Q?hKFB5NvI1UqtIXkHORQFc7/ktqacvLpeZgssR3Cd4qEpyUeE0Ugi2dFVJitr?=
 =?us-ascii?Q?O2xu+f+aA/MRslis1UgtiQ4cLNBykZtIrrU2KyrVQo5UaO6544kTEB3S+fYv?=
 =?us-ascii?Q?f496J/bcJVnU2o8xV4VhV6Uqumlq1+hoQadQEoFZYJ9VIHVI9eNp76vTKT+5?=
 =?us-ascii?Q?/mDH7cZGoO02SVAdwiPEh8XmMJgvrU3VHoLyzPeaYbpMjvsrVYCLrY8+t63+?=
 =?us-ascii?Q?Sz7OYi7QIYvt0WDO8ztnmhAWjsWAb/NDBdA8rKz3TLEDzhYAFkiMbb/kzp91?=
 =?us-ascii?Q?cxpYgKlsTxJFcHsVZM4uaVsIKc8M0tWGuqw5sXQxXE2ui2bht+jb13sBpogi?=
 =?us-ascii?Q?7skYjik7ENd1H3RF244e3oudAdNK7jBuWZO3ahtREhMKyzLS2WmihFdKfVQy?=
 =?us-ascii?Q?2zf+wlvlW/JVB/gqvChzjCv4a2eOPf703bPEITGFuBb2iTricJ3f5T00m16O?=
 =?us-ascii?Q?izoGe33i0yP3hCjeUX7rMorS8+/6pkVJBdXouXswGFQMyn0RnElauJhvDI9J?=
 =?us-ascii?Q?cvyZL/Tzt5fipNEz4fmnR+BGMrZR91jdIWS+QDExnQ+d23iZaO1kckypdq4N?=
 =?us-ascii?Q?aPGLob+hT2gt9Rv21joCFJim95wfFAbkg/1xKC69Bq+DeEpYw9DIpN3FifvZ?=
 =?us-ascii?Q?qHf7cztKoqD4LM59FE/ZFJ+8fFENtdaXWBxR3O/jTgT+3zk+AD/qqHnXyZnV?=
 =?us-ascii?Q?ieCeqpTZEXcGqZ6oAX1BeUQWCPQSgZODAlOyNEd/8okIlx6a8jDimS9iGqJR?=
 =?us-ascii?Q?GWCzotxeRlc9TVw6D8jQpUIu+KJX1nOTtOuMA/KNvYOunbT3x++W53LvRaxY?=
 =?us-ascii?Q?z+dmbM4QWyy7CAR6wXwcTEOLG4kZzLWIcGpkNMNk6vKWpHZ+C+JFfIFU4lUz?=
 =?us-ascii?Q?/4xu8oEuFbg06r2qLbQPvBcF1q7NJ1vrFINDtDlV8ZsHDWla3S3g38HDAzE8?=
 =?us-ascii?Q?HshQgl4eknpCDpj8t1aAfO/T5nlpsXsDHWOUhCQ46FfDeXWgqbUU/EmrisVN?=
 =?us-ascii?Q?ReSDDK4tlCVnu0yCfL/E0kE/3XN9Vp22D5P/PoPGfyJ4O6qZYtj3xr3LNSEH?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2CYjxRgj+TglQYt9oa/rxTi157Wbz+lm/duWJepd36cxdtP6bQJwWUzJKPuYwaWVxxO+08rfRJpFw5EsqKMAKC6cXFJ+WwTsgv8CYVGSeUhnLrnNnic5+1VtBLXj4bxsJ+6GdlXx6Qj7vVMJOMmCnwyp/qO9s7UEovHNLoBIXqhR0COwJjg3wYrpzdIa8xx6YsWP3xqmoElPhW40Y4wW/W/NM0MRagwpk/hp+l4wA9O2+eCCXZpCi1OC0zVVw/w1hgDjJrdHJsPhox4Yy0lVQRCE2EVgZ02SuYixnFdHaNwk9Ph5fyMHBKTDUwTUB87C+4yb6xmsRL67vau+C3iTfqKUH4tvqdg8zZtHkxuflgB7X0X2IYuDlhyB2JJwrDFPIybtW663AA1E0VjGiCG/bqImWuxtq+rmdRYsijzPb5eniRO0Jw855GVApQbnnS5TwgeahyaYEHXZjR8/V84VvHFuwFyVffK1LE/T+5YCUV4Mx9GKCU4YvkNB+szvTS3HSgWxHVBbFE/EUmsfk8m4hFTDRBnKeYr8vmlfD3qeW2sxa1O+ba3g5qKVAjtPxjcV2lPnJx+o9EJcxs4JdbIXQglBkoEbNkuwd7lElGiQ8bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0c9f95-af01-49ae-11f6-08de229aa92b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:54:39.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSqbnwIxBBj4FovEyd1UoiOqPiTscg+52w6yuxLxp3IylNLTDYsKfhxL3jRAtwUMG/gpeQC3b+ZTKVgTRYMjPtPiqJknryV8YgURcUFrMd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130072
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX/4dzVRayn8iF
 W7Sc0A2h6U2g5X0FJm9wUjD4JEBxnxpYCEQN0+yFcrZVwVb8L8/GS12RBNuBO/AQNRndzTG7cOe
 1+xhLGTgkwvZE7nQfMGckeGQ1V+8W1ocM2BG7VZtjA3psdODO0zx9VT8McPCT/n3s52zQw7o6uv
 obPxsjbvz5log6+HwWSTI/uMkoQDnPYNZ2n5yK4rFpNVArr0b9tGowEDsqzHfuwtiKcOy9uGjZm
 L3z0Ze/MJeWnOO3vdpADyWKqk1VZTNdfJNks+mn7e0Z1d4UmFC4cBWEj450jA+JMLysNBl/gMiA
 s0WEA+Yd5JtJQwMAisgh3RCOaOnmsf9EwDqj5p9pvFiYmhJzzA561aDn88KwNT0exbFOYQRgWIx
 rwyUc/Q9bCxexzYJUW6akqucd9ignQr0YqwYdq7m/hzJ/CkrBHk=
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=6915aae7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=B3EugMhSmW5UjO9KI78A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 7KWAdhpzZFXdxpf4jla4IsvlvZ-uBLFF
X-Proofpoint-GUID: 7KWAdhpzZFXdxpf4jla4IsvlvZ-uBLFF

On Thu, Nov 13, 2025 at 10:06:42AM +0100, David Hildenbrand (Red Hat) wrote:
> On 13.11.25 04:46, Carlos Llamas wrote:
> > Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> > vars into struct") moved some of the operations previously implemented
> > in uffd_setup_environment() earlier in the main test loop.
> >
> > The calculation of nr_pages, which involves a division by page_size, now
> > occurs before checking that default_huge_page_size() returns a non-zero
> > This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> >
> > Fix this by relocating the non-zero page_size check before the nr_pages
> > calculation, as it was originally implemented.
> >
> > Cc: stable@vger.kernel.org
>
> Do we CC stable on unit tests? From my recollection, no.

Yeah please let's not.

>
> > Fixes: 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global vars into struct")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

LGTM so also:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> --
> Cheers
>
> David

Cheers, Lorenzo

