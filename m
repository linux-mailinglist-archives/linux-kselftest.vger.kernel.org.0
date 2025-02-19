Return-Path: <linux-kselftest+bounces-27009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E99CA3C86A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 20:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2D176A4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2496522A817;
	Wed, 19 Feb 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oxKj83kN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ga+aZBRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CA22A80D;
	Wed, 19 Feb 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992877; cv=fail; b=Wh/pu1llb2/wNmWp3OL5qC8Vg/18ItHgGbynShlaOY873tWLmBcBHXSBGuH0h3AmktpSMe5nL14w7SHH+9wPojZSkLTh7oQtU2ZCFNhe0x2InYqsRj7ENA3uZiNQb7zSVENloFq6WBdjOxfN3sEPGCl7hmxQZGwa7rjGAFCnxdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992877; c=relaxed/simple;
	bh=gZTLjwL7Vgkxl4b5dIww+82thbIrks8+UxwlKYdm0IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/k8RCFL/VEbaX9vTXi5ENm2C0mqXkq/yJYCfda+U2nrjfbN4VwVGN8Mwpbs+cjrVeaL15jRFain/khD22NACMLTGa8lqJJfQ8t8Ls0bGhbheIMIkHgPj3plU+ZPHJnbyFQtTwL9lSLyCCmv6TIRPcIanbHZqfKMWFtdAyymPLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oxKj83kN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ga+aZBRw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JJBYOQ030380;
	Wed, 19 Feb 2025 19:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gZTLjwL7Vgkxl4b5dIww+82thbIrks8+UxwlKYdm0IM=; b=
	oxKj83kNsIcE+pOTbL2FWUKjZK2UjSTy3iNJslM6Osq9bCJDRSzQMTed7zq+RJ4h
	PQbHR9VUERIeL6RUFX1mioy8CFVvGsYEs38mTv1KYcgrRm6DAjRpGm5m8cq6cxfs
	5ZZ2IEqYA4cXcY4vk/AnOP6mVhoO5AtuvuPsaCj2qNsxl83Ma7/tAh4EVdPdkc5V
	bLROG/GTWicJ3NLAXjmP66tFw7UZmx906SuC9s7K0Ew6V7l+Xk94T6G9fL72/qpU
	r3ym2r0r9XxmNTe+Oa+4NKi6dWVJQR5W3og6nS6dAgkL6ItM8F1aY9k0ZglX7jlL
	nkhzF1EDavoW7hjB2Goi1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mtguj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 19:20:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JIDMIK009872;
	Wed, 19 Feb 2025 19:20:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09cwx7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 19:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWbKcMA0EdUKX29VZ1up68RxFp6OSZyPa6czOEg/dzdhAyf4pazocRJqYBTtJ4E5uKp2NVzaMkBTs1aCVoNolNcBAcKdsMn5WKe7/DEaS09Sc6jIvHnT7vbxczkqfpdGQ2qxtA1KyKzSc4yMgoGNm7HbUeAZw81Glafaf1q0nwm39JM4YLExSOFI/tiMAnzYukT3dtHD+YhofZBcFa2AyToe1zbflLNv7qMquidsGQJ4hTy5Kl6rQ4kNRB/6X2wgmmlw2Tnj0eLD8D/3D9JutSSJfNsWpgPC49Y4vqXjimzm9FJBn400185L+yBmN2lyswf46Z5/5WDlcLq2bMNdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZTLjwL7Vgkxl4b5dIww+82thbIrks8+UxwlKYdm0IM=;
 b=yU3QluM2Pr2f2MJuXomsts/7VRKtQ7oZJul90fdgz7qszp6/EVEN1oBldKum6EeVlQxudOz0Oo8TgFOoynloZhXuTOheAJA4cTp278t79YWCvxnUrl1YtxcibB1TIAj/wnOXTqXRKu9lGMGHXluOi+nrMN5FusrDyR79P95Q7oiCrx4xeG0uH7WfCo3C3Y/Gk8CpGsWp3x+Z3mJOBAkLT4F3OoMmCaCS6w9FugYUtCdcmi/yrZD/hRw9SYPMkYUf1VcUOgo9fpUCGXD24hNWcyNuSckzx0MTta1SEksGyW5QWIwvC48y7B3i1miR9FzXPa5jPzB236FFIL47SNikRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZTLjwL7Vgkxl4b5dIww+82thbIrks8+UxwlKYdm0IM=;
 b=Ga+aZBRwR2Err0SlFzfsPYbPlbIZhh/gu0mZIXsRvVO+XdhdVtKl5DOKEgRfjI8GSwpYFFmt0FdPC2mgvLSqRAPC0BBO5H9UH1a707U69tmicIieTPhg9/nkPOkzw1V+0tByKPh1iPZc0CfyHhrtbduu2ayWfVxeVjJimvL1Psg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6159.namprd10.prod.outlook.com (2603:10b6:8:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 19:20:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:20:46 +0000
Date: Wed, 19 Feb 2025 19:20:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
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
Message-ID: <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3e92bd-5bc8-44d0-862e-08dd511a8296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTN2YUJuek1TQjF0aGhONmFtVy9BaXpJN1E0bFJ4YjVOZ2tNNzR3ZGcwbU5R?=
 =?utf-8?B?L0VxeHZEK0NqYmxocWdYM0t4dHYwNCtJRmJPL3RUL3RSVVFzRDl1WXBxVUFv?=
 =?utf-8?B?alFuVVBKajFESG9vM1I3b0dQYU5ySk5QQk9Lak40T1ZpZ3A4MkdnbEVpYXV1?=
 =?utf-8?B?dWVJK3JFU212aDJ4LzN2V1RNb1oybHc5SXk3N0dYbk43dFZmcGw0NVZGU0lp?=
 =?utf-8?B?bnBNbGFFNWZ1QmkvRzQzRHJRcXdZbkl2Y2ZWZGhBM1RJVjJJQ0NsMCtRMlVL?=
 =?utf-8?B?RVFnVU1HTU9QMlZoaVdxZkpIT2JKczFOVmlrdkJnVmdmMkRMRHg2THFMSHpS?=
 =?utf-8?B?ZmNDT2w2RnNjeVJYeU5nTmF1NFRJQWtvK3U4c29OSFZIWkUyUG5CSytIWm9G?=
 =?utf-8?B?RldGVTVGOEYwY1NDWEpaWXBVSnBMNitnTkZDZ2tNUTJ2T2dwV2FmKzliYUt6?=
 =?utf-8?B?ZlJHeS81Z3R3R1V2SFAxZkRRL3lYZUw5RS9iTGdCNEVkbUpZS0Y5TkwxbGxE?=
 =?utf-8?B?aFl0WUtzeC9ES2RRdG8vMXc4L21BcDJDT3FFNUIvckxqOE03WkVjbnVkb1ky?=
 =?utf-8?B?S2l6dEhmOCtxZ2JuSGNCQm5XUkZqSTBLTzVkRFVBYlBEUGNJN2RER09Wa1RT?=
 =?utf-8?B?VkRtNUtqeWhTaHRqRlRzYXByOEpDN0FOb1ZsRGQxYU51SHNNVm5Ydmo5dzgr?=
 =?utf-8?B?cVQyY3lBN2FJTHlONkVLNitzVC9kODE2a3FHbGR2V1hmVFkzM0M2SjhBY2tk?=
 =?utf-8?B?TUs2Rjl6d0RwL0ZRMHp1K09wb3hPaUZGdGdrNDV6b0Rsd1kyTEpZeWVPS2F2?=
 =?utf-8?B?bmZ6YWsrSlNGSGFveFlHTmNuMExlWVBodDZ4N2czSENqS1BqZzdVYVA5dUwr?=
 =?utf-8?B?RFBKblVHOUE0bWlNTDlTNGNGVFdyRFM2T1hkUjZ0bG5Hbk1VR0lVRXZpS3JL?=
 =?utf-8?B?MHQybFNjZkZ2Y2llVlRqOWhsS1dnYTB0aEZKeXlNbVlDeTZOT2dKYmZJYkhH?=
 =?utf-8?B?VzhuZkM5c3ZZWW9oK2pWV3hTN3JrNHhUejIyNGdlaWpIaEtXeEZyWnJ5Uito?=
 =?utf-8?B?SkxMSlBpRmlmMkJLV0s2eDA2SiszYkNUbmtPa1ltYW1rdmtkMHRPZEM1Q0x4?=
 =?utf-8?B?bnNCdE9UQ2NtQlcxOU9Ed3BXQVpsYnhCK0tqK1F1RCtuUTBXd1RHNkcvS3Z5?=
 =?utf-8?B?YjR4ZUpnYmNHZUVMOFlKWURodFlEZEtlVlhKQ0NDeUFZQ3BLRmVyQUxXRU9l?=
 =?utf-8?B?ZVQyVDlWSndwT3dYUmk3UWZmYkpGQ1NuMUdvbEEwa1gvc2d2RGZKRE5Gck1j?=
 =?utf-8?B?UVlKY0hRQWJVdHF4dmMwaXFKTVhJYUZRN08ySDUvTENIdElaTW5DalVpMHY3?=
 =?utf-8?B?UkJTZTFTb3Jkdmk0ckZXN205YjFwZDdGL2dOdDhRN1M0cDZ6SENqbWFHcHd2?=
 =?utf-8?B?dWdOSnJCUmIrU0lOSnV3SmNKM0pmbVlaY0lnakZubk15b2k4VmZheVNMY2U5?=
 =?utf-8?B?c0hHQWZuVVpXUzYrZ0RRR3Rmb3pLVGhKNUFISUVlYnVCTHBlRW42WElBeHhK?=
 =?utf-8?B?Q3hYQVRuWG5IMXRPbE5DVVNkNjZzQTdCMFA1NWdOZjRTcDRJNzlrYUczL0o3?=
 =?utf-8?B?R2Fva2k0TE9LSFZ5WmtoamVNZ1pBWEtkb2NNZzByTWgza21aQjhaQmNGTllX?=
 =?utf-8?B?YmpHb2JsR1ZoS2dEYUEyTitOcG9IakNTOVNkTWJtQjJ1WnNBK3pwZ1J0ZWxh?=
 =?utf-8?B?UUJCM2d6eTFoMWRuN2paN1RybGxBQms2Uks5Q21mVC9iU0V0enhvNW95Vkdq?=
 =?utf-8?B?T0pWazB6ZFFPSWNZL3hPYk42N2RkeVltLzBKQU5uc2VaWUF3Wjh0MmFxWk0y?=
 =?utf-8?Q?dcD2AdZCwWBJI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NCeGpuRmJETTBkd0V2bWpjTlNRY1VGWmdDWmRkVDNHbW9yM0dRbEMwNmRD?=
 =?utf-8?B?eFhUbzl5VmtBQ0RlM1IvVTZwbGx3dklMZXNKQlFjaks3dkhrYitrS0tqR1pr?=
 =?utf-8?B?cDZ6NjkxWjdubGtwekxzSi9tb2ZlTjEydkMyOHFycDZVM2Fnd1JsNjQxdVc0?=
 =?utf-8?B?cFJrUlU1YXA5ZWRkallpNUs5NGc1bGFrTTFpU2ozNUpqTkFBV2dXUUdwQTFw?=
 =?utf-8?B?dVFFVmVObEE2RTVkMWVHYmlaMnFBVEs0ZmV1SDF3c29wVVc1a2dSVGgvdEdq?=
 =?utf-8?B?MGJ3YXNJZjBRUVJDM1dub2t1Q2I4SEl0dU5mRHRzK1BLYXh0T09Oc1dtWHRG?=
 =?utf-8?B?TVlVWGNJSkluSGk4K1k3ZE82cTVQbXlpK0NZbUo2TUlDMll4QTlsdXZLZHdk?=
 =?utf-8?B?UnRIUS9UZmVOUWk0VnAzQThFcENWRWRlUFRUcUhodjZZY3FQbEZSMlVXZHQw?=
 =?utf-8?B?QnhPMmUrSTRiZEtpKzhTd0RueStGdmxXeGl1UTJZcXBRc1lsNkFsSkl1NGtR?=
 =?utf-8?B?ZFgwL05ET2h6cWFYenlSS3FtK29lQ3BTbTVvOFJUQ25KdkJsb1FjNS9aWlp4?=
 =?utf-8?B?QnpyS0R2OTVBNjVSaEVYNkg2TzNYRzVKanpqclZtMXJsaytENHFVekdmazBK?=
 =?utf-8?B?QllKdEQrREJtR1FHcDJDbE1RUUVTQ1RLZGE2L0JHVmgxR2ZOemw5UE1FU3Z5?=
 =?utf-8?B?VWw4OHBkelI3cXhNSllDa0ZVZFVpTU1Yc0I2YlVaU3hUM1dKZ1ZpTlZ1ak9q?=
 =?utf-8?B?NG9IQWNLV1hKTHhha2dQQllWVjlqNnFLNTBuSHE4OVFvWUdzdnVMQ3VIMkRt?=
 =?utf-8?B?TzB6UHRmSTE5Q0EreTNaakJ4aVNuK3JZVVI1dGRQc25ETndkNFpmZDlYdFVM?=
 =?utf-8?B?V3pJSC9vVHRzNUhkYTc4MDFoSmNOZUhMUHZXZXVoblFNdHNyYU9YaFduU3FQ?=
 =?utf-8?B?VHBoQmZBa0tCSklGQzZFOSt5UFl1OWdQRVdSL295RTBrZmV1MU1LajJKQ01O?=
 =?utf-8?B?MldsZFZHZC82c2VCbkorakdHdnczemZ2N1FCYi8wblU3WHVmQjZzWm94bWt1?=
 =?utf-8?B?ajczVVU5UDdnbGtyV2ZHRFlsR2VVUlJwTTNRYTJrdjhGSWthRmJJSVo4KzFS?=
 =?utf-8?B?dGc5TUl6RWZyT0VqbCtWL3VObjU4VXNsTy9LOUhOVTlzeXpaRlR6VU9uQ2s0?=
 =?utf-8?B?YThVNE1qRU0rb0dNZnh5cSs2QUwweUN2ekRyWnVzcHoweC84VWRxNTdaZVFD?=
 =?utf-8?B?bWRCUEVRbFY2TXkxekQzUXJyYkJSWEdJVzgxbG1SYUdCZGVtUzZqUkZiT05a?=
 =?utf-8?B?ZDYvVzl1aG5TKzcyS1JpWTRhT2xtR0VjNmh4bktBOFBRVm92d25PVkVsa1J1?=
 =?utf-8?B?ci9XempvQnRlY0xjWngzWWg2TmhoUWhGR0pvdU42Sy9LZE5XRXlEUGo5ejJF?=
 =?utf-8?B?UHZyMFNPR1dhSXRHQUlGSlFJWEMzanNkRUYyT3kzM3hpeHZvc3RzMjUzSE9r?=
 =?utf-8?B?RlJSeEo3SW96aDZqdjAzVjdFNzN6dWxFY0lZNDQvQklhWU8wUzhRL3RGdmM5?=
 =?utf-8?B?R1kxZUErbXVuVGdKTVNhSlVuSlVIOE1wNzkxbmJYZWdjenVwbHZORWVPaUdx?=
 =?utf-8?B?a3h1bDNZcG1oc2VwaWZ2eUtHWVYrSHA4T1RsdDV2QzkwZVVvSElLT2tVbkY3?=
 =?utf-8?B?T04zVDJQQkZnUmZzcXpkeFcvdHZRK0hPVmxCOUtiS09XTDV4cWhYMitiZ013?=
 =?utf-8?B?QjIzUWRvMm1saWxtREJjWUxZVG15dHRUWnZFWlNTVk1POGoxM2d1L29RRGtT?=
 =?utf-8?B?cHc0emkrQW5DNU9ERlBmd2E1a2RYWVlURE1obVR5aUxqUVp1by85ODRtclpV?=
 =?utf-8?B?bjFScXlzV3hhVG9RRDJlbStSd2h4OG9Mdm0ySi9VMWMvdlR2VEpxejgzM0Vj?=
 =?utf-8?B?VldMWTBKQkZvcWNjUzBQam1veWQyMDN0K2wwMlJUMm50RE9XbGVWQ2phTEhs?=
 =?utf-8?B?d1JSNFFaVTV2SHdzNDZSekd5K2hwaGY1N2MwVkJrZmtXMlUxY1ZaOERQVlF4?=
 =?utf-8?B?WHp5Qm1GeHo5VWxqUWQ2S0JDSmYrM1d5WmN1YUliUERIbXVzcGFOVDhrb2E3?=
 =?utf-8?B?czhPaTBTWWZpOXR4Uzk4aDhZbnF0elhSYmd1ZTl3Rk43SmdQVVE1UHV4UVE1?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	smPzjl/hdXPjsVs+VzoI2f+nrmWNwxVIMFkU78d0kHjyBVYGE9wTPkiiGy9Az8UIgcy5yJP4E4Z8B3B6NeYn/h0cJJOrRK9ks2793j2hbKgkra1KlGvZp3WmcS0MqUAl5z6DQkfglks6QdvSu1KsPZ20j4+r+buRe0+nDTXx78jd1S18wG2rd56KUle8n+KuktXxW5fCe4RSNs1H7kvI5m7KO7GMVV96sqyHnkC8o4/g6+Gz4tCk7DVBYQg88tIPVp0dAQil2TiYoVOzu1Vb13jk2GBW9fVqANiAjDj8gLpIJn5T8LVymaHvwkl6c0RAX1jEWuJgChzNTT/BbO3hRO4KqlQX/7D79hMeCGWymWTuJ7CKM21TkRV+Z6kIzpMFIS2FBENVwws1wtDj7vip4Dsa70IwiAdsO3OMiO4ZGlp4bOP1D48h3KeMBj/u2Tn/nu9KahJbc9PzeuH7+qpyqj6wVFevHiJsKRnzHAQZ+7JgYf1ZaxUm84G+0MUh79Vkjb/WV1H/MbtdQkbcFLY8ofeLhSiDcPasnwGwmGnqmSfH/mL2FIUQTPLkajOh+WO8hL4EqObeeF/w12MTnQBNQsJ9ybcO2Q2qpMON7Rt6lrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3e92bd-5bc8-44d0-862e-08dd511a8296
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:20:46.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxngISMSj5J9QkqZqy6gGNaI1bs1s/nHzROym9ZOqanxPJTM1oNFknUMMJZMoUscg/FiOjQnYd4IxC5VG2NVouFMbklxuAjLUJToEKQNVsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190150
X-Proofpoint-ORIG-GUID: bU1xMFnbrAlV6GzrTZkr57QFsPxVTIhG
X-Proofpoint-GUID: bU1xMFnbrAlV6GzrTZkr57QFsPxVTIhG

On Wed, Feb 19, 2025 at 10:52:04AM -0800, Kalesh Singh wrote:
> On Wed, Feb 19, 2025 at 1:17 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Feb 19, 2025 at 10:15:47AM +0100, David Hildenbrand wrote:
> > > On 19.02.25 10:03, Lorenzo Stoakes wrote:
> > > > On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
> > > > > On Thu, Feb 13, 2025 at 10:18 AM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > The guard regions feature was initially implemented to support anonymous
> > > > > > mappings only, excluding shmem.
> > > > > >
> > > > > > This was done such as to introduce the feature carefully and incrementally
> > > > > > and to be conservative when considering the various caveats and corner
> > > > > > cases that are applicable to file-backed mappings but not to anonymous
> > > > > > ones.
> > > > > >
> > > > > > Now this feature has landed in 6.13, it is time to revisit this and to
> > > > > > extend this functionality to file-backed and shmem mappings.
> > > > > >
> > > > > > In order to make this maximally useful, and since one may map file-backed
> > > > > > mappings read-only (for instance ELF images), we also remove the
> > > > > > restriction on read-only mappings and permit the establishment of guard
> > > > > > regions in any non-hugetlb, non-mlock()'d mapping.
> > > > >
> > > > > Hi Lorenzo,
> > > > >
> > > > > Thank you for your work on this.
> > > >
> > > > You're welcome.
> > > >
> > > > >
> > > > > Have we thought about how guard regions are represented in /proc/*/[s]maps?
> > > >
> > > > This is off-topic here but... Yes, extensively. No they do not appear
> > > > there.
> > > >
> > > > I thought you had attended LPC and my talk where I mentioned this
> > > > purposefully as a drawback?
> > > >
> > > > I went out of my way to advertise this limitation at the LPC talk, in the
> > > > original series, etc. so it's a little disappointing that this is being
> > > > brought up so late, but nobody else has raised objections to this issue so
> > > > I think in general it's not a limitation that matters in practice.
> > > >
>
> Sorry for raising this now, yes at the time I believe we discussed
> reducing the vma slab memory usage for the PROT_NONE mappings. I
> didn't imagine that apps could have dependencies on the mapped ELF
> ranges in /proc/self/[s]maps until recent breakages from a similar
> feature. Android itself doesn't depend on this but what I've seen is
> banking apps and apps that have obfuscation to prevent reverse
> engineering (the particulars of such obfuscation are a black box).

Ack ok fair enough, sorry, but obviously you can understand it's
frustrating when I went to great lengths to advertise this not only at the
talk but in the original series.

Really important to have these discussions early. Not that really we can do
much about this, as inherently this feature cannot give you what you need.

Is it _only_ banking apps that do this? And do they exclusively read
/proc/$pid/maps? I mean there's nothing we can do about that, sorry. If
that's immutable, then unless you do your own very, very, very slow custom
android maps implementation (that will absolutely break the /proc/$pid/maps
scalability efforts atm) this is just a no-go.

>
> > > > >
> > > > > In the field, I've found that many applications read the ranges from
> > > > > /proc/self/[s]maps to determine what they can access (usually related
> > > > > to obfuscation techniques). If they don't know of the guard regions it
> > > > > would cause them to crash; I think that we'll need similar entries to
> > > > > PROT_NONE (---p) for these, and generally to maintain consistency
> > > > > between the behavior and what is being said from /proc/*/[s]maps.
> > > >
> > > > No, we cannot have these, sorry.
> > > >
> > > > Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of this
> > > > feature is to avoid having to accumulate VMAs for regions which are not
> > > > intended to be accessible.
> > > >
> > > > Secondly, there is no practical means for this to be accomplished in
> > > > /proc/$pid/maps in _any_ way - as no metadata relating to a VMA indicates
> > > > they have guard regions.
> > > >
> > > > This is intentional, because setting such metadata is simply not practical
> > > > - why? Because when you try to split the VMA, how do you know which bit
> > > > gets the metadata and which doesn't? You can't without _reading page
> > > > tables_.
>
> Yeah the splitting becomes complicated with any vm flags for this...
> meaning any attempt to expose this in /proc/*/maps have to
> unconditionally walk the page tables :(

It's not really complicated, it's _impossible_ unless you made literally
all VMA code walk page tables for every single operation. Which we are
emphatically not going to do :)

And no, /proc/$pid/maps is _never_ going to walk page tables. For obvious
performance reasons.

>
> > > >
> > > > /proc/$pid/smaps _does_ read page tables, but we can't start pretending
> > > > VMAs exist when they don't, this would be completely inaccurate, would
> > > > break assumptions for things like mremap (which require a single VMA) and
> > > > would be unworkable.
> > > >
> > > > The best that _could_ be achieved is to have a marker in /proc/$pid/smaps
> > > > saying 'hey this region has guard regions somewhere'.
> > >
> > > And then simply expose it in /proc/$pid/pagemap, which is a better interface
> > > for this pte-level information inside of VMAs. We should still have a spare
> > > bit for that purpose in the pagemap entries.
> >
> > Ah yeah thanks David forgot about that!
> >
> > This is also a possibility if that'd solve your problems Kalesh?
>
> I'm not sure what is the correct interface to advertise these. Maybe
> smaps as you suggested since we already walk the page tables there?
> and pagemap bit for the exact pages as well? It won't solve this
> particular issue, as 1000s of in field apps do look at this through
> /proc/*/maps. But maybe we have to live with that...

I mean why are we even considering this if you can't change this anywhere?
Confused by that.

I'm afraid upstream can't radically change interfaces to suit this
scenario.

We also can't change smaps in the way you want, it _has_ to still give
output per VMA information.

The proposed change that would be there would be a flag or something
indicating that the VMA has guard regions _SOMEWHERE_ in it.

Since this doesn't solve your problem, adds complexity, and nobody else
seems to need it, I would suggest this is not worthwhile and I'd rather not
do this.

Therefore for your needs there are literally only two choices here:

1. Add a bit to /proc/$pid/pagemap OR
2. a new interface.

I am not in favour of a new interface here, if we can just extend pagemap.

What you'd have to do is:

1. Find virtual ranges via /proc/$pid/maps
2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.

Since anything that would retrieve guard region state would need to walk
page tables, any approach would be slow and I don't think this would be any
less slow than any other interface.

This way you'd be able to find all guard regions all the time.

This is just the trade-off for this feature unfortunately - its whole
design ethos is to allow modification of -faulting- behaviour without
having to modify -VMA- behaviour.

But if it's banking apps whose code you can't control (surprised you don't
lock down these interfaces), I mean is this even useful to you?

If your requirement is 'you have to change /proc/$pid/maps to show guard
regions' I mean the answer is that we can't.

>
> We can argue that such apps are broken since they may trip on the
> SIGBUS off the end of the file -- usually this isn't the case for the
> ELF segment mappings.

Or tearing of the maps interface, or things getting unmapped or or
or... It's really not a sane thing to do.

>
> This is still useful for other cases, I just wanted to get some ideas
> if this can be extended to further use cases.

Well I'm glad that you guys find it useful for _something_ ;)

Again this wasn't written only for you (it is broadly a good feature for
upstream), but I did have your use case in mind, so I'm a little
disappointed that it doesn't help, as I like to solve problems.

But I'm glad it solves at least some for you...

>
> Thanks,
> Kalesh
>
>
> >
> > This bit will be fought over haha
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >

