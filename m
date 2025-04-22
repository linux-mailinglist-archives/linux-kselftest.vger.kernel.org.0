Return-Path: <linux-kselftest+bounces-31292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84FA966F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BEF3BB942
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8887F2777F9;
	Tue, 22 Apr 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XUoN1xi8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vKGA7aB3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE938276034;
	Tue, 22 Apr 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320138; cv=fail; b=dGzKtWIdadx7kRK28918GW8Wj2OmGwEGilFoQlfnccFal5CCSkUNdE75fkvECEeTgmOASNQpihAOszL2ZjAroZo8iCpU6WWq+ukDPBOvBK8xDCw/czGxst6oKUKDra+G+wFDc3vwGyQy91305S8k5S0DTOSc2FSGm9T24lqc9uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320138; c=relaxed/simple;
	bh=y+LaKS8maCmbIyWSxHK6D4zrf3JCthajiHstMTev+xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bj44TiWDCsxUNWN3pmpEqpJ2uNXCInzraYR/kkx9UCXAvF1RnLXmvAB6t49I8N7BGGVHYUfLb8xfwbXkgIdu7c1oPydJYGjrInXo0L6Roo9ZyWl8qroYdYlulWLb4QnwAwrF8rtG0KRiU/rxpF6juxEenoDCUdmP98eBW8WnN9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XUoN1xi8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vKGA7aB3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3GiQ008344;
	Tue, 22 Apr 2025 11:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=odwOxl6TYLZ0nIIs+I
	WpMzcjj49wLiTP6t+jTedvuzs=; b=XUoN1xi8uHU9f5Bz9aHI7u8uJiDIqtJAcP
	MRNMcf81psz0EQS3w2ZKU3Kx8PWaeIU2n22Tbg+oNuXAXYAjv2Aj21gf7yYRo337
	XfdDY/obnFOpiJ/jLi/MNhZVRsZ/uqZyQZNZB/3iM0qBRLg2JzWWizlkif2jLtd2
	VFlU86tc6lQoFiZ/vq9CwoAMYtQ/60UuO4A2tVYjqWTCdceVU8KBllJSJVbI8qm5
	5acSfZQdHl1VoyCsOk7RVonduE9GfqrMTjp9CmgLhaSs2vUFp7bLifO7E6krpa3a
	PBILUImM/zHcU8qGM3LKcSquwHsY/xCOEtrm8HzUXvq+SqiZdChg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0c9nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB6vdo010181;
	Tue, 22 Apr 2025 11:08:33 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299qg9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUqMI/j5qwdgmnUdH5dawwy6b5fNdrG+7eFqCazPoM0INszKrGdZSYKdKSag5ssW4Kbh19o/3ckrDX8P9xo4bF8Q0KwFBnEmDK8/An2S2bOVTetJ3fCsoxeOadO+pLDkl2hNDQ8d5dkBv84Ca4oEyRw28PB+gYn0ZlsaUwB7aRnImz/9jJxkNMfp/foL/txB2PkXFqj3xfNyK0VbiQOp+x/IdH77mubRGC2LHO5wAKyN5WvtGv1BNap2Apikao/if1YwRw1sEZGz22C5/fa56HDDt8dAbBkbbgLmpcPXO97QlmArNXxscD6EjfWg4Pp1zjrj6gH52QaEgDPAKLG8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odwOxl6TYLZ0nIIs+IWpMzcjj49wLiTP6t+jTedvuzs=;
 b=rL3Fj/jDqIPc/8kryEfSg2Qc+vP4gzAonL54gyA2J/Tx8m7GwXofmOGhf4Kj175u+5KjPwCmkTX6axdTyreiet/Ouc8Tluwl52M3TacnS5najZUEYlMwWtiFLZvs56oWBtGQtVBWVH1p5AIZ9aKvCD1kh0TJk0mq4lShsNuA2zG581qAOFvpjUFWlUfdhtcKadzxVVRazqJ5t6Hy5/bDXajcjw0xvPeDEwkrib8Hbihrv/Hu/Pa+2hIygsQ3HrFobm2vtlXPB5RgEeStb9qUhnsD7aXD5JRoWX/UoTifQBo2q9Xnry7BBjxv1wIypNkMNl6StwICGAnkW/GNeohq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odwOxl6TYLZ0nIIs+IWpMzcjj49wLiTP6t+jTedvuzs=;
 b=vKGA7aB30Qbu29zHtZUC84BqK5MPN8M/xmq58tAQWaVtxoJKngpWs2fbnKn+MvmdLR4NYJgjPFdpkAK7BtHU+eSexqIuLVqyOAhSACM1sGgOm7mTXsqClXpd4hUSmE/KO6/Kgcywbh9TNttwuI4fd+H0Crx1HvBlk/XCwtg2Csg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7175.namprd10.prod.outlook.com (2603:10b6:8:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 11:07:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 11:07:49 +0000
Date: Tue, 22 Apr 2025 12:07:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 3/4] tools/selftests: expand all guard region tests to
 file-backed
Message-ID: <f0344770-fd17-4f7d-b802-ba2f3570ac57@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
 <a2d2766b-0ab4-437b-951a-8595a7506fe9@arm.com>
 <7d5e0f61-66d9-471c-b6ef-bf68dbffa614@lucifer.local>
 <c76429c3-2689-4722-99c5-f577af679aa4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76429c3-2689-4722-99c5-f577af679aa4@arm.com>
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 66172063-c665-4439-4401-08dd818deb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Idc8k+RLwc3Osbg3l3H8uMH6NyWRHE5cCwHOYp1h+tJpASqefLskLu/vVTb?=
 =?us-ascii?Q?IrLgHW8+RGlrQ3BTn1+7ELYYTJupxfmW25pX8gx2P96iuolkCv44pvlKFCa8?=
 =?us-ascii?Q?WwJODB7lOgtrMbVPiq7ZtZbXxXC96L+NZj5GP/zLkh330MMYiQ12BIgZ3IW+?=
 =?us-ascii?Q?tJr+CtT4HHsEyFWTqkfQkioHD2gilEKeNBppPWJ0A7cPphMFS919IoKTkAkl?=
 =?us-ascii?Q?kNYfUZEfWoNLJQovBlWeu9SyndHHkoPuBgRWVYHmqT7WLF3OhedT+QsS0Kor?=
 =?us-ascii?Q?pgRs1K8puun2/Su/6PRGZ/tlsfSgW6yS/XVvbthXc92d03E3BViUxbPZzC86?=
 =?us-ascii?Q?AcHbU6RnS6O//675NCOmsK3N4kQEl34Rfnw1EhVYqdGdTahmPHoHgJbEId1E?=
 =?us-ascii?Q?gNl4v+VFBTvXrWmJD76zTWKU+MhJledOx8ACRVXFe9MvdszWQy6VDwr+wDOc?=
 =?us-ascii?Q?uGFDvrvl1gKD4iGI9oEIx+AD0OsNLJNg+THWqrIeyMqJUvKbGYk1tV8eWbAC?=
 =?us-ascii?Q?FoETA10LxZFREXn9PXM5Yp/0onOwztl/Xw/atSOosCagQHCWqlEHG+E6wHZ5?=
 =?us-ascii?Q?DGKvezypOvIEtpJTDlfxHNFGrd34ZVrJGAI+U74EcXKqB0McE1ugPWqQBxhm?=
 =?us-ascii?Q?VLu2rB5FW/sOSZSSTpq7QuXs8kVCSOAkgyxlUriCBICk8hQ1rgbD4Uamx3I6?=
 =?us-ascii?Q?74fdqSm3bYVGcFdjdvZFJLa3ZVsZcomrHH/apNJQ43jTHWodKY12TP0kSJ/q?=
 =?us-ascii?Q?nbHLKZkMnV8nvXxw2o9biCG3fkGDNh96Mm0rk3D7uqg/fWaFWGkYIuvoKpJ5?=
 =?us-ascii?Q?wsII5zjwZAwWLDQ/j14pwCXs2tgwu06TbHzN4dmJSoovh3vNRfWWyP5aKUnI?=
 =?us-ascii?Q?jfMAOqMy8bduXjFKrGWxaFJH9R6djM88RBxTEOU7UA+5AzvtexNB5hVylOW3?=
 =?us-ascii?Q?HR5t9/Rojrp6cRjDolNYXiMr2+4XtSm/Xxk/tK1VhT76Dlfz6qDAnN1+3Dpb?=
 =?us-ascii?Q?yHZUSPJCRbohHASg8Iqj5YOMkG3aR3b+8J8cvheBAWFSXs/Iatm/pXxvSzkj?=
 =?us-ascii?Q?QFfn9ChRk5Zpqx6UD21vD+nXSl1jpaxj43paBP1xP1twSpz6QRZW6dr1gMLK?=
 =?us-ascii?Q?iTvAKdrdJBC/aGwY/VBnwVw40YhqNNQFMHAehwEe7nWx/q8+Ksu5L5mBUxGj?=
 =?us-ascii?Q?0IPvr+s9yiIHTsjSswYhDtTYMFegCFyBuWH9D6h8nTnygrLIUs7LfBVtA+eX?=
 =?us-ascii?Q?aVOqnGIzUMk8t4IKaf3D6ZfDYqR+HcKK+07p7FZ8ST1kQzPgm+GVoLSp7Xt4?=
 =?us-ascii?Q?nD7yn3D2G3qRaN4qCmm1xitgev6p1RphlKjExRX2tTqL5Y3kXFC25WkNo6W4?=
 =?us-ascii?Q?p0uKAJx/CnS1UKO/EdpaPhvVhZotDnwIl1C3FsKeTUPbKCBxdWzeKGj9vMFj?=
 =?us-ascii?Q?gHD+gjigmPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ks0T1V06kY3WD4/5fF+QA0X85q/749gDGsxG7od+2h1TlKKQ3tQsLbQ8o4j?=
 =?us-ascii?Q?bYxDM757xmzk6hmEq5FNxD9NZ4K7JxhCT5MH767fhxkC18MSOJ4eLnPoJ0Gi?=
 =?us-ascii?Q?gYfE6S/6pUwRE/ZzKVG0wivJmApf3J4RzVlGf7FLC5Cy/1YzOQaUtdWA1IFz?=
 =?us-ascii?Q?GjQl2QZ1wOkAvr0L9UfGgrPkwLM0R9J2tbaE6ODY9kzoACtmrCDR1l54cvGM?=
 =?us-ascii?Q?LUlZbD5BACkev/FRt7Vh4G75fnDvM2sPjSDZuZ927ZodxGZ813Db9SiT2TyJ?=
 =?us-ascii?Q?WNeaH3ha+11rlUHUHQINNffaNrEcqayCcUhXbY5dKb9On9MmogCQvm78Vutq?=
 =?us-ascii?Q?z4jLx8/8r79gLXP0jkuAavS2aRGGdHPLXrXgmh0WrLC6yAYempU2jt9KjVw6?=
 =?us-ascii?Q?3d92aMAt6bmv4a5GJL2Em9bFzGd0fTRLk7clPTy3eVgvCc/zhSuC275apX35?=
 =?us-ascii?Q?Ish8hWaOYYizN/j+7AGE9yCz1r8g5rUVODF66MJQvXIa0p76lkDRWEfVEhm0?=
 =?us-ascii?Q?SYI2IzBU+Fy1p+3vsIsx/ihShkp1YcoBvjcuEqlu2U7NUJZN7ix2xZpVY74h?=
 =?us-ascii?Q?8Pklg5fPXk8PMjAbnljF3C1JzbONoOGP2V5vPvCHcDZNxZVfXb9UQrbG/2hg?=
 =?us-ascii?Q?aieck6wCsK2VlyC/9xEs0hhAJI0XeeeE/kZf873CT/rJ8x60tmEvADHByjs4?=
 =?us-ascii?Q?VGh+tfgE9kAEYBDeGXbBf5AnZMYWNZxhnzNSLGDOlqtjGzcaqZ4Wn0bBqNh0?=
 =?us-ascii?Q?GWay6JJaAlpWrrJGWTZiZHsrjMjqy1ph9XzVpiKnv7XbNr5vNMidh3PMDaji?=
 =?us-ascii?Q?aq+j6FO9CI17c68J0kbILorkFeR3QULDFlvdrpVDw+5f+cfcaY97ZTdsVqYC?=
 =?us-ascii?Q?fQ2MJBgEC6C7eLXyyHs1GkkPfkYIPZn6GBQauGeFPSZruEQTIlsLxkLDqJW/?=
 =?us-ascii?Q?X2FjE7INZVcB8Qcp2mApZc9ByWgjQzUVut4m+S0QNPBjbbodqT/dmWTQt+5k?=
 =?us-ascii?Q?TnZbobUASuf3Tj7OId5/0jDa+3HR9FYCn6ZeHX+d5N2ZZYu3oSgW3xs3PrcK?=
 =?us-ascii?Q?yV2OaIoLa6psH24ozyKl1/FUXxw4cGfE1B7jXSEggI3PRbEHYGIktDJw2qk/?=
 =?us-ascii?Q?MNccB+pkZZE/v5L0A/D7mYYt/iGiLDTX4JmlFpxYSgGnKSnGhI1evmyHwFUL?=
 =?us-ascii?Q?Np5TB/LRHzjWv2ASr0YEpMW5nqcJbGl7Ii+ZjXwDMRVM8it+R/4DjhXJ96rT?=
 =?us-ascii?Q?euhOrGXF/v1s+9qYqXtWuPPO9+UCRa3VIUdJk2ZAyNNvUJV+0JnKqXQZJL23?=
 =?us-ascii?Q?zCGNp5xx/7fXsw9G/vDUD0SGFEFyeXsIj5fRaEwHv5uQy3nSJbQs48NgEAqA?=
 =?us-ascii?Q?TCMedLCp4RMsfy69eZb1+6vPgLUBcEzpzlQdGZbSuw7ATtbhOX4//qdg/yYi?=
 =?us-ascii?Q?vdXaL/MsjiAwA53vWm4KXGxGt57t9AV65+UeGwxhjSqy4ppJZ+ceN8AtI+L4?=
 =?us-ascii?Q?AgrLd9gWuh1DfRFAmrPAz6vGnkMnPGGFqPKH7p7KeDSUL4WKOqbyAv5ftnxo?=
 =?us-ascii?Q?DQ+AQ3APgI04ICPes+w1e9WbbdXsn+W/8/0ExyETTWuLHTVUDGtazvBpeleL?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GoJCtUy55t/uvky/MXWGoyQjhjJ0LSpC08lTwfQbe2eaeGaZTP1INIjlpcnJNgZJZW6P2mktgrWMbUojpScKxqPBr/+IDjUqXm9HgvuaFQR7DFyGAUvFuGccRvtEQw29XovQCmBtPAtSjPxKj2JvFgeSRcCKgBYYjT4Oi1XkUn1gekWliuzpBnHj26GqkSQ7R2JJkHaBE2IFyikFGsmv3eeEgHFhcChfR56oWziGBH6tf1dzK8XXmMSp8+gny+jQuv4LM9/xrHUx04V4yYbqah9yKgpk8B3ZgIRnOAPvcenQ2r+sYtPIRZHp1DdBKuqnbGvgxecE53aoZx/a/XznuWmtIomI3mLAT6sGpMctFJfIBkRR9R0Q6d4smJbMOdKUg8Gkg3jYOOecgr1nti4aD7haldz+dc+6wGjvcVH5cRZYrUXLlwwrqrzczuYCXRnjY1e2KtixiYLExEo2Ok4+EqA+A1Q/9amlDD4EkM3/53gfqzvAEmKOJj7WMZdMSt1h2dkxcb0egPnTdqzyi0xWivvFWmI5Ra4hHDLNdqkLwlOoXbFQGqmm/3aUEvZvD3BWCzT6Mnzv74jsPd0HiRg6SkGcvQDvmF2L/Npti2wVNio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66172063-c665-4439-4401-08dd818deb19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:07:49.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMocpBejkR8MhIJdsS/mTjg8yU3wBJv+O+9OvzJFNLJXboaDV+whGjDI6JOz7ufIjP6/rIZhLO1kqG9tuw62bl2veDUei4Nj9S+kQN+pBlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220084
X-Proofpoint-GUID: IRIHe2qgPa7bFigNDSnzSyRdUdfh5aCx
X-Proofpoint-ORIG-GUID: IRIHe2qgPa7bFigNDSnzSyRdUdfh5aCx

On Tue, Apr 22, 2025 at 12:03:08PM +0100, Ryan Roberts wrote:
> On 22/04/2025 11:47, Lorenzo Stoakes wrote:
> > On Tue, Apr 22, 2025 at 11:37:57AM +0100, Ryan Roberts wrote:

[snip]

> >>
> >> Hi Lorenzo,
> >>
> >> I'm getting a test failure in v6.15-rc3 on arm64:
> >>
> >> ----8<----
> >> #  RUN           guard_regions.shmem.uffd ...
> >> # guard-regions.c:1467:uffd:Expected ioctl(uffd, UFFDIO_REGISTER, &reg) (-1) ==
> >> 0 (0)
> >> # uffd: Test terminated by assertion
> >> #          FAIL  guard_regions.shmem.uffd
> >> not ok 45 guard_regions.shmem.uffd
> >> ----8<----
> >>
> >> The ioctl is returning EINVAL.
> >
> > Hm strange, that works fine <resists urge to say 'on my machine'> on x86-64. Is
> > userfaultfd enabled in your config, to ask a silly question?
>
> Yep, and the anon version of the test is passing, as are all the uffd tests.
>
> >
> > It'd be odd for this to vary depending upon arch.
> >
> > So a factor here is a _stupidity_ in the testing - does your system mount /tmp
> > as tmpfs or an actual file system? As the test code unconditionally assumes /tmp
> > is indeed going to get you a shmem file.
>
> Ahh that's probably it. I'm on Ubuntu and it looks like /tmp is just a dir on
> the rootfs (XFS in my case).
>
> Forcing a tmpfs to /tmp solved it.
>
> Looks like uffd-unit-tests (see shmem_allocate_area()) is just using memfd.
> Would it be reasonable to take that approach? Or just use anon+shared via mmap?

Yeah could be either memfd or MAP_ANON | MAP_SHARED. I think I did it this
way to make the code a little easier given all the variant stuff.

Unless you felt especially keen, I can add fixing this to my todos :)

Sorry about this! Entirely my fault, knew it wasn't ideal when I wrote it,
but with test code sometimes you (perhaps incorrectly) tolerate things you
wouldn't elsewhere...

Cheers, Lorenzo

>
> Thanks,
> Ryan
>

[snip]

