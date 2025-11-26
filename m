Return-Path: <linux-kselftest+bounces-46520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A5C8A9CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845003ADE45
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B1332907;
	Wed, 26 Nov 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPznVB1V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xN+yWaru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A9331A62;
	Wed, 26 Nov 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170654; cv=fail; b=L/p/c2Wiq4LUdxPTZFRnloO3e6AnJnistkU9LlY4lAB0OWGEBi9LG7H8Ao9JMHKpjwW2tYk0w24+GDpaJTw5jfInfpcyCHZ87gbl3hS675mp5EGvLbDRCCUif7DAKx78Eo3CAabFmit5Ok7rlRpQNmwVakM++DoMueBunikjnss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170654; c=relaxed/simple;
	bh=P2Sr5JXgD679XyJfrOMSKKQ03Sf2qXcG9SrYujmkrF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWWrfkLRugb/jPCvezAr+ir8wqa8qx1YY4IWjqKCH5JNyNtUZ1MhEdTYQNOMkFfMSQZIEF2vSThN5Uft+Q00xrCkGiF2BLPUAK5d+d9Tste8yPKKdYgyMAd2rVOjoYaule1NyVMQwiM6G6FgTRZ232ggj/W8GStvdaCtrmckXHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cPznVB1V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xN+yWaru; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQEuBXf2424678;
	Wed, 26 Nov 2025 15:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7Sqsurk/ZruOB+1iOn
	KStWHLDHpbUCvPspOGzQlhohY=; b=cPznVB1VRolRiIUVAfIsd4ilVicyPnCyCI
	Xpf3N7fywnxmKi7Xd7h4p9GqCM/WjgvnUfacLzjneICrktkJIj1bKAoYdef1AFXP
	dI9JkpGioDssyY1XtVyVA5mtXovssPWfiiZ784GcSR7QAyMHbFG/g9Jolqqqiopp
	EEUjZSgBPhiYONihCK//eBhGMrDM3/U57FzoeXkHfj1ZBSunikYF/pQ94B3Vg0UK
	PGiW4qZKSuQIJnNyqWyYFZp/iu9dYNV9g+eBWtSWUhtuW/gqQYOEpWkT5lRjg7oo
	HkJ4w+6dghiDd6yrr1xfWxy0KZgzEzSJxw1UDQNJKNuUSNvd3KLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkc75f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:23:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQEGW53032886;
	Wed, 26 Nov 2025 15:23:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb48c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrcI/indvDbJ1FS/DL06Jck/Upf9E5gQxSXmgFookDS0HJ435dhPHSiV4rDM+sVk5CySwSeUdc9l39SvifD9NSIfWiz5GVZ2VaDkHEu5/hOXtIvFJJZPgIu1GaArjbKe/GKRKsrMmmIDy5fOi9xtQiWCoi9+w2vpZ9ROYttQAhnrBMa/p9+jxKb6bhwA4x0ri/KjPXvtKUpPS6omZ6UE5auUh1VT/iI5UZBHQL9QAQrN3SARNKxuhOeAIY+cUyTz6RiI1EIuG3lDGuPnhnHxPH52QEJAIgIiHrDU2LsEjNWQixypvmADhgY9Lm14QO8/SLoA0gSdIBVKIXUfe4sehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sqsurk/ZruOB+1iOnKStWHLDHpbUCvPspOGzQlhohY=;
 b=jbuwq9aooFSTaxnKzWN/DZwqgzQjZyeR8zWnCKTdyqxDkLzGoNhA5Bbi2nxYluu+jiRn8+NwUzsowCy8yoN00fw9q0t6uyhA/CKAC/TvPeMiN6iCqVgTQT+izWmz0x5cWy9+f4CPnytuHxCiD0w5OojRIHdIVL+yzDEWDRobPY6U2BVCkgpi0ZEOSKSRPYjNjLj4J/TCOPRmcL04LrjX+dXAtFGJCG3mkoxvuFX9x+9XaRxLBYFacYJiQjTp4cHu18g8pIBeZXdPH6/I2gZjoU8Q5fkulVsuwCX2b4o/nFnqc2kn1JJp0oXBj4WIxl+i0X/0z4Q3sv1XTMVliUqTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sqsurk/ZruOB+1iOnKStWHLDHpbUCvPspOGzQlhohY=;
 b=xN+yWaruYuM+/N0vnlI8xsSG++lpkWmU3FmiUOSmlIDaVBs3iOViHnM68RBMOdI1TUzFHvYoQcghlirGm3Jd5By8fAX8oANCX104eXXXOSrfOAA4qFQ0HL8igLSe7WBjTA3dfy6QReQ1pfrbWoCzj4j4JuGug/M90cJoZUs99Js=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 15:23:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:23:43 +0000
Date: Wed, 26 Nov 2025 10:23:38 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/5] KVM: selftests: test userfaultfd minor for
 guest_memfd
Message-ID: <fml27mxsuif3zbnbpperflml24ftis7uhdu5jymrajb3hroqts@wlxrnzxaigrs>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, James Houghton <jthoughton@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Xu <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-6-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125183840.2368510-6-rppt@kernel.org>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YQBPR0101CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 7390ea56-bc83-4112-5ef7-08de2cffc8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1MNjI9ADFmQyeIX7oNlCleT25s+ULpBKzyWBk1cHxcUl2AD/nal642Hrvd2?=
 =?us-ascii?Q?GVMLlEVGLUkx+4BWW0vguJ9QvmzjLY+V2sOkupj3cnpwbvmEhTJ1/lyGM8uG?=
 =?us-ascii?Q?uW6beY1sjnQLRw+k4LrWtAfUpHMwKgu4RGzPnIoZNtt8PlppA0oA93v1gmPs?=
 =?us-ascii?Q?DY3EgwYiFpKGYbFp6x++fCBZbjx4j8VfyDzUkAFT2hEtMuRVSNfu8gT2Gt3d?=
 =?us-ascii?Q?pJpxCyiG2kgHT2Un6leCkfMFrGiEG9ZuN60vJs3+/GV4I2XTDu2esbEZmU8h?=
 =?us-ascii?Q?hYJXyTMUJ3Lyq+P0JgWqTiYD7r17xAs9L93PojgSSId5aHqOfPLoRR/ElO0f?=
 =?us-ascii?Q?4Sb4CV3vXNjAaJBW1CMz/yHIua0krtSqDrq8/3/TtGldaSb4f2A+h8bSK/Gn?=
 =?us-ascii?Q?gXRLgsPqgxHvKwoZ5oAa7jqQAKhackkHLeVPfDaJ4FFMO7CmU0WDnr2U9Xu6?=
 =?us-ascii?Q?W0rvrBtPOYjwKe5xkApkWZo3ELTvKVoFrUBKIb3RYgJra9mOTlgUgg0I5xZ1?=
 =?us-ascii?Q?pZMrlnVgEEc1gvHBagpnS5nLT7MdtQyR1m9VI9/8Pv7xAyHqpwkNhcYnN3Cv?=
 =?us-ascii?Q?6NduzHGLWWzyABBGpwgwCWfKnW0Qb5qD+e2ZBKE2CZgGW6/m6yPy4DUPZXvU?=
 =?us-ascii?Q?aZBIHYV/phKCQ5DwUPxFkL/SImGqoTi/m24yMeG19H0gQahorQXCyZNEEgov?=
 =?us-ascii?Q?oqqblqIbbIeG/qJApQTn2+lKTPHJSW26PARUJCw6WPrsg9hMoJIYlovCr6KF?=
 =?us-ascii?Q?hNWPzkBs0tU5QY55OpquX3BaOuCOU6pYCs101yndmdkR+h9Uk4TUZVYk5gkL?=
 =?us-ascii?Q?oDkfzqTn5qBv59OW6xMc2RZjes9WjPSdNSGOvNyM7O5WKbeNnsj1hiFHcnkP?=
 =?us-ascii?Q?ihuUEN0OqJl3QIywcsrY2O3Cm0zEJxvT56kIUZ8dkeaUGWw4OU1/Ev2Xem5R?=
 =?us-ascii?Q?/2iRAeXP32rNhwTpdc/0lfw803ZPKFARXiVMmTvZYj3Kzvdl7twxvZMO9tkU?=
 =?us-ascii?Q?2qxMZv6FFWgAELzD9zE5yIByrTSgM6Xs9lr6RqrWp+IKbmCBud2GEBR+zJFV?=
 =?us-ascii?Q?mWPCX/Zt2/qCC0PV1us1b3wGOsRZcSJU31cyOdyDXNbfnxcWpNIiFP9n3QSV?=
 =?us-ascii?Q?CRlzo7aLTICoZarwboGooQ8gbpS/l9CD1wCKPeJEMI0eaWpdAiXQLWdW0TGV?=
 =?us-ascii?Q?TKGpRgT7av5MsBYBgQvKOYTlkIaGIAMRm5WmBdL970IFU1kpTyHtYQ40oFlN?=
 =?us-ascii?Q?ioBh0kU2WlMV3EzfuC2jl+mJB5XYxuuIlfy4KFOF+Fy2ZX2iX8PAKOwI27kk?=
 =?us-ascii?Q?O3DruCGFwnITDvosWC8NWXuuw4yendL+zMECHEY2OVmWiM1HTqEU4semZJCX?=
 =?us-ascii?Q?lckhahbAV/4645KhXLfVpm9bRkNjbSaLBfXyjlLdRK9t5GzQDLJgmPn95/cb?=
 =?us-ascii?Q?6GVn+k6o4cTmKuVw0xF5xOiyUQFEmB/HirPUKu/yetjZlAl3qH5ZTB7VkeO5?=
 =?us-ascii?Q?K31L5MlLnU8LvVUMx7sjlxNNliWVoME44p+5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZfr8mZLoIl9fgQeAHQZP9kzFYPtp52LaAfnYAOJ2lW1ipy2OPD96JOSQdaR?=
 =?us-ascii?Q?AgX/4EvZBCDDBhHgCMnskDIBkmOMPWymHH4E0KrYsIG2tfnX7Z/YuFDoE8LP?=
 =?us-ascii?Q?/teOE0/1jO/SQat3no5keuGna92zT5CRWsQEl5380pF2i2MicboFsk43f/7U?=
 =?us-ascii?Q?5iKRjXhGKEjjSAY+nqRPiPSxVYBcwXycB4pzx7hmiQStVbFBZ0Ca2ZfIycAZ?=
 =?us-ascii?Q?FSHi0WBkX4gvWDaXonaH6Qi+ovSVz7bbwh+D3ltcR0cUCgFV25g91vVDPN6V?=
 =?us-ascii?Q?CYX/iLjgBWPRBaQtYnUk3RXZDt8jxBDCwZmbbfiMxU5kA4pQsu3gnBb4JySJ?=
 =?us-ascii?Q?ePppEjkJUh3xLGbjxEoN0k62mkFQVQaU6JkvpMJx8P5mJtAT6KsLZNSI9zww?=
 =?us-ascii?Q?cax4lxW+wbfTT9tPDz/N7xSUgU7MjJUfMhZJ12Tw+ZPPbEOWuPvilpzldfME?=
 =?us-ascii?Q?BXxsKb+9caaQcBUQtk3hpJBNJ3fC5vQU7i6AEsBr7xBcDjf2Nlc+pwwUwyxz?=
 =?us-ascii?Q?LNWdjZMIQVjdxGLcMxnl5/ANF63Vzk27uQm6zl87zQ+hfRanRenHmxZfvW25?=
 =?us-ascii?Q?/xUAJbQvsrMaWR0Zl1cA9aI6XMoNVusYgEa8aBnykWgFZV27Zsw9UAWUIO0c?=
 =?us-ascii?Q?l7lS0UtA8Ge9Kh5XPbUMIi4+XvsYfeeQu3Fd6D+6qB0c42EnfjEgVMQNzePZ?=
 =?us-ascii?Q?fw07lUmVQdF9iyRCVSEWLXU0TYQQTbBQ25I/ORRimQdzn/yl08NPpD0sMTvs?=
 =?us-ascii?Q?Y6e6HSzgvFmQGteWk1tYn6X9Jz5WANjAytF1bgoR+3sTNdMjKw/NdtxH6MOw?=
 =?us-ascii?Q?2zgyfeyT9OqQlkUPyUCxk/AX00AyrcubekO8FuyalEQ1rJFN1dCz1Zk2afSq?=
 =?us-ascii?Q?XXG/fOatpRzHIkip2UGeviMyfGQZZk7N4dMY5TJXqAGriY4Xq2kVrp0shBcI?=
 =?us-ascii?Q?gz04oopI1vnwQw2aj3biePBpV9s+KCKLZx76dkkIjRJt+w+tJAL+vYn03p1w?=
 =?us-ascii?Q?oLS9+LWjpedPruCgkxgjZ6RL6znfCU+dLlmrlHYhYJaNZe4M5xpT7lQqE0Cp?=
 =?us-ascii?Q?kyg3jEUMeGjBVPXn2UVwVylO43YxqzBOvKvhKRZnsW5gkGwnHh9DDhV3W4s2?=
 =?us-ascii?Q?N5ubJN0d4dkWm2igtwlP43rqW+BXZys1Bch3c8vf/HXKijDuEFmaC++kCy74?=
 =?us-ascii?Q?7nAHZBmpisxoMQpTUVN7pqJj0EVmrXXwNDoXFt2/jLdDj3SGUjB+fUrqKEE9?=
 =?us-ascii?Q?g3M5pioGTMieuikLq+fZYuHutS+60CNzDprToc+83BPhe7l66hPy1hmHjAux?=
 =?us-ascii?Q?zNld9MLyLoiW/te4xaCFS5SudOSTeT9Tlbhq4pPxL3nJAyTb8D2OYg70U5wg?=
 =?us-ascii?Q?os7sWXHUBSogUlYxeLxWcsM+NbQgsZGDzoMGixsRM42UmgImRrxBa4GiGAOj?=
 =?us-ascii?Q?OuSKVtF7e3SSN8915nYzuKuRHSZF9wxZTElq4S1N3GqAe70BiyqKXBj0H39Y?=
 =?us-ascii?Q?erBMxqWhUk+Am9SZZ3ahJLM8E61+qh7IjA7Ih2rr448nkVKj7XyVZ5PTpiiU?=
 =?us-ascii?Q?STvZB03SaeX4k4OsVoxA9MMVOMIecyiHOqu/LJmq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5qOLUS1CtkOpy3g06JLMcDzPHP26uxZjvQhYn+c02YxEQiFozchdIugrkmD9831RnC+h6gnv7Cz8ZZmt90++HF4BM9OlfqOMHcXBsnC0+Ib64LANXyarbsShiFd54SrREtZEfSC4L5W5tJOoqOyHVoSRr3rzPKxns3pwxYntRYY5zBMHqd7Lo970cnTAKNoKaJg6PkGtSBTm+0RNMtoZEQagLB3+JtHy9HrwlWgldpwtj8neTU/TRARAPX6ZTNcszCzfLXVS5r9qaBvI4SDVLmOD2qnAR4Yt/Yqxho7HDNC/YCMDU7W/gUpaDMZUzOP2iuJGs3Jd/Fc9mNlgxR6KP+65eHXEDW9BqHUFI9pWXP7VZJb2dr4kuhXkiGPHb4GwHUB8+nk100SL7DlKqFv1sLe/LhQ68SWf4WFcojufd85en3n3A+pQ8Pj4T9HvkKzSjii8MjgUOl760xSG9L429TZyxsABeCcSKZCEidzTZWS0Ym4LuUpawFyFOzeG0VNDY49EY1KZfgMseW/SAaMslNX6geM+hkQfMjivtzn1FfaDsPGC7f5GGvsgwBePpCaKMB9HaZj6al6u2iiIc9wFD4/TdN3FcAWzL36EzNzQsjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7390ea56-bc83-4112-5ef7-08de2cffc8dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:23:43.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKvmWFORdiGBBdu5bGJEBGLAO1w+idJ51ViOcTSzm9u87/H5lcoIJG7Q/Az4d+jB50i1PCnDYNdaPdTWYYRy+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260126
X-Proofpoint-GUID: c5ymIP-GhEAa9dn8qh7ixM5sSB80AR8f
X-Proofpoint-ORIG-GUID: c5ymIP-GhEAa9dn8qh7ixM5sSB80AR8f
X-Authority-Analysis: v=2.4 cv=L+8QguT8 c=1 sm=1 tr=0 ts=69271b84 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=dwWKZU7a46N5ckcqWlsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEyNiBTYWx0ZWRfXw8EAYW8B8ILg
 RFxVYTnO3m0OCsvlJMfsh0SviJ+pyG0GmGZFXLbAKyKyajab8Cr67a4x8bV4acj+n5M0zjwbcFG
 GFjREoMyrcTdLhBmGY7z5nKBEmo11rqd1ryfyGws1mvnDOp6kdZmZgyaiBxUY/4W8UVeZOAlhNQ
 RET0YvhfaqYVrbJATMKW5G25w4TpAxdvhcxyWuZ8SxsE1tauece+W9YDp2Db74v5UhWyX0zbgfb
 ER+OHJCyhUSbe+SQROowq75yYH3SroxvKjqBwPhkUClHj9OubR7jnmFL0z9qFxuAQIFgyCB1MC8
 RK+7eSPbSnAR3mOMXF5cxu8PkPfFt2OTRA36CETmx1wnBlEjYao4z1HfpZd/aKptmifEj3mms0u
 K2kCET339/DrAQHlMjN39R3DqdT2yw==

* Mike Rapoport <rppt@kernel.org> [251125 13:39]:
> From: Nikita Kalyazin <kalyazin@amazon.com>
> 
> The test demonstrates that a minor userfaultfd event in guest_memfd can
> be resolved via a memcpy followed by a UFFDIO_CONTINUE ioctl.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index e7d9aeb418d3..a5d3ed21d7bb 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -10,13 +10,17 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> +#include <pthread.h>
>  
>  #include <linux/bitmap.h>
>  #include <linux/falloc.h>
>  #include <linux/sizes.h>
> +#include <linux/userfaultfd.h>
>  #include <sys/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
>  
>  #include "kvm_util.h"
>  #include "test_util.h"
> @@ -254,6 +258,104 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
>  	}
>  }
>  
> +struct fault_args {
> +	char *addr;
> +	volatile char value;
> +};
> +
> +static void *fault_thread_fn(void *arg)
> +{
> +	struct fault_args *args = arg;
> +
> +	/* Trigger page fault */
> +	args->value = *args->addr;
> +	return NULL;
> +}
> +
> +static void test_uffd_minor(int fd, size_t total_size)
> +{
> +	struct uffdio_api uffdio_api = {
> +		.api = UFFD_API,
> +		.features = UFFD_FEATURE_MINOR_GENERIC,
> +	};
> +	struct uffdio_register uffd_reg;
> +	struct uffdio_continue uffd_cont;
> +	struct uffd_msg msg;
> +	struct fault_args args;
> +	pthread_t fault_thread;
> +	void *mem, *mem_nofault, *buf = NULL;
> +	int uffd, ret;
> +	off_t offset = page_size;
> +	void *fault_addr;
> +
> +	ret = posix_memalign(&buf, page_size, total_size);
> +	TEST_ASSERT_EQ(ret, 0);
> +
> +	memset(buf, 0xaa, total_size);
> +
> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
> +	TEST_ASSERT(uffd != -1, "userfaultfd creation should succeed");
> +
> +	ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
> +	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_API) should succeed");
> +
> +	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
> +
> +	mem_nofault = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	TEST_ASSERT(mem_nofault != MAP_FAILED, "mmap should succeed");
> +
> +	uffd_reg.range.start = (unsigned long)mem;
> +	uffd_reg.range.len = total_size;
> +	uffd_reg.mode = UFFDIO_REGISTER_MODE_MINOR;
> +	ret = ioctl(uffd, UFFDIO_REGISTER, &uffd_reg);
> +	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_REGISTER) should succeed");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			offset, page_size);
> +	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
> +
> +	fault_addr = mem + offset;
> +	args.addr = fault_addr;
> +
> +	ret = pthread_create(&fault_thread, NULL, fault_thread_fn, &args);
> +	TEST_ASSERT(ret == 0, "pthread_create should succeed");
> +
> +	ret = read(uffd, &msg, sizeof(msg));
> +	TEST_ASSERT(ret != -1, "read from userfaultfd should succeed");
> +	TEST_ASSERT(msg.event == UFFD_EVENT_PAGEFAULT, "event type should be pagefault");
> +	TEST_ASSERT((void *)(msg.arg.pagefault.address & ~(page_size - 1)) == fault_addr,
> +		    "pagefault should occur at expected address");
> +
> +	memcpy(mem_nofault + offset, buf + offset, page_size);
> +
> +	uffd_cont.range.start = (unsigned long)fault_addr;
> +	uffd_cont.range.len = page_size;
> +	uffd_cont.mode = 0;
> +	ret = ioctl(uffd, UFFDIO_CONTINUE, &uffd_cont);
> +	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_CONTINUE) should succeed");
> +
> +	/*
> +	 * wait for fault_thread to finish to make sure fault happened and was
> +	 * resolved before we verify the values
> +	 */
> +	ret = pthread_join(fault_thread, NULL);
> +	TEST_ASSERT(ret == 0, "pthread_join should succeed");
> +
> +	TEST_ASSERT(args.value == *(char *)(mem_nofault + offset),
> +		    "memory should contain the value that was copied");
> +	TEST_ASSERT(args.value == *(char *)(mem + offset),
> +		    "no further fault is expected");
> +
> +	ret = munmap(mem_nofault, total_size);
> +	TEST_ASSERT(!ret, "munmap should succeed");
> +
> +	ret = munmap(mem, total_size);
> +	TEST_ASSERT(!ret, "munmap should succeed");
> +	free(buf);
> +	close(uffd);
> +}
> +
>  #define gmem_test(__test, __vm, __flags)				\
>  do {									\
>  	int fd = vm_create_guest_memfd(__vm, page_size * 4, __flags);	\
> @@ -273,6 +375,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
>  		if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
>  			gmem_test(mmap_supported, vm, flags);
>  			gmem_test(fault_overflow, vm, flags);
> +			gmem_test(uffd_minor, vm, flags);
>  		} else {
>  			gmem_test(fault_private, vm, flags);
>  		}
> -- 
> 2.50.1
> 

