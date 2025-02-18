Return-Path: <linux-kselftest+bounces-26874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D06A3A32B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4280518898DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F726D5C5;
	Tue, 18 Feb 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWfescyg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DGA6IFD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5522A80F;
	Tue, 18 Feb 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897388; cv=fail; b=D9Y+8ioFmxzuZvom4prraLM//Ffv+tsyA5Oqeep2lJM5ErHvWBEzPCfcGXdyZjYhwphQ2yykBGnRkJN1TJqUKFjO7TPT8A5xV7yx+sn8hXiD3FAE7m0dF+N3Dibrz9cqHz6bf8z/40xTM5Jm9Q1xZhWTdkE3J3GV8FWM4QzlBLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897388; c=relaxed/simple;
	bh=il3YJuX30Qo6/jUeuWXhAu0YYHCpHiQ99wKvllcscSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CvpmYz6srO/W8RrU/k+5Z4mcSojO9a4Ojp5moNFXwdugByk8/Hdv8pn8fZDRyWZiv9F9lbw+qQxat8mPuXIshEuYwCZdrPUGMBDgoNMRBc4ZS2TAEZpBU8wP8XZHPuPQgBDqSqDCucRtveXtnqOo9zkPzQcxE6zPcQo3SXxWfnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iWfescyg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DGA6IFD1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMagO008568;
	Tue, 18 Feb 2025 16:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xE00lQmZQt8zeqQzMf
	zyfSYn9O6cuxRytvyfdWjqA3w=; b=iWfescygguPAiJvOYMjgJi0uuq6S4gWZFw
	JcBWnr5zpqYMF66Ie3DLBGViw4ctSBizj4gNrxq4ci1G9UDPU/oknepeZ38usvds
	7eaIrD48LYPBE69RLD+AwQmk5KrI77Z2IhnRzMuvXrFpPYS67MjDDArcyfWPsxvz
	LNVYNYyHbaZ04Qr1LbJK6KuTbCEqcIs8K3EGzN2dJ2374I2S+Tv+diz5dhNAqBbF
	9Jo2ihztsO06lQVn0JpQpG2kkc4ZC8YFVa5rrc1qzjGNZ++UjKibP96pUC78kVXa
	srGS87hOyJST2e2epnGGwNcucHUGX2xxlNvhbVtqka/RCuq2UlLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thh071wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:49:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFttaH002088;
	Tue, 18 Feb 2025 16:49:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcfjr7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2xTeRyhcPrgcFOmkbm5hA/0asPUPCEdCKFzcBfyPlWkvUZwU0W/NwczYDNzx/yn4q44zW2v34phjHIpmSdh4acEXjsvPE8MePcp9dw9nJ0H367VajzEL2JXL9J88GaFdmB0kBVcZy9MDAT32ebUVYCFaSe3yMcQ3918fHaFJmYFBIyN1aFejP03Djjuf32N3//6GCrDsQGvbw+H8UH6RfjMhHH4Nbco9AmsidLOAGyKGhn37YZ+wXKHOFlZfezkWWnWEfGprqJaz306F4nKAyFiMBL5qberOQkzom7qlmFVnbC3NtE/+rHiN29mIfx9a3iRYfEHNlU4l/279uKOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE00lQmZQt8zeqQzMfzyfSYn9O6cuxRytvyfdWjqA3w=;
 b=WpDL4rTvaxx6S0W+9duw12oYTOpyYCfn/hx0aUt4zG594C4Q9XdEHQEVL0xYzD93O91t2IOcNzlLI4rlb1JXDlXabcOZRmUoxnSXmtcfuoQoT6zdkDPaaeIw4gPjAxdDnNPx5E7wZ85slj61f+qILOrw/K3Ow6iBxjB8Q9eGSy8mQP/YoFOAhTbF4GJsDCCHm/M/irmc+IJs64gS7TFL1q7EIX0m59bWVnCKRvxnSonGrf+9TL2475x6jwUzrW1REKzQSNcNYfji3TTRW7xiaIE6z0xCwDHrk2LwOhmYpJ24loAnu/D+D/+//wLiel8GC98u31BnI5Npj7h/Mx2v2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE00lQmZQt8zeqQzMfzyfSYn9O6cuxRytvyfdWjqA3w=;
 b=DGA6IFD1Nq4h/Hw/aEO4DmzyIS9Li1UcdPAUQH8j7hNQHTW1hwIbYL9OfPteKY2yeYVspim13DF0JdlxLQkk1ROKJF+EkZtbYAIyRExEJ4kwZhbw+cO35q5Kdnmedg7n9LGJQaLPGdHXztbcD//HwLtk/iZcogyaz2VNpijKpb0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 16:49:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:49:24 +0000
Date: Tue, 18 Feb 2025 16:49:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
Message-ID: <195a2b04-2968-4a51-9308-855da9fc12ed@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
 <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
 <4d6d2942-10a1-46e8-93a6-7ce52b6af3ad@lucifer.local>
 <90a00957-02b5-440a-9168-de93c760fea7@redhat.com>
 <d219ab1b-9fb1-45de-aa65-b6071d049dd1@lucifer.local>
 <de79890e-86b5-4f43-8a25-1e50c3b1daea@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de79890e-86b5-4f43-8a25-1e50c3b1daea@redhat.com>
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 4081acb5-8b8e-4361-8a3b-08dd503c3349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsWrYylPMt2XbVT98mk0LByyY6BKBozJlWOMrEtj+XITsjQGAjTphQooE/+j?=
 =?us-ascii?Q?KKKd6p5uQvOabkLVshsnIs6sc1yKmoIov3molNKd6pBIjR2mnefkhIs0euWX?=
 =?us-ascii?Q?lLskNNwwj8+NVCsua/9juA/SnQLsnUB5UQfg4vo+n6dXuEP1dXIAl1kzUid+?=
 =?us-ascii?Q?/m8UYjHlBrqc69/i93hlou2K2ir018RiyGdEr7MEzCK66Gfy0I9OCgcmAl22?=
 =?us-ascii?Q?tzi6A6j2jdUjflQzU8LQvsjTcGURgHUziYeyTOYcnz7VU39zv6SiiMl7ur/p?=
 =?us-ascii?Q?sfdLFep8/LMgRpwTKsthUCeVVwYDQcPKLHC7JE7x0P8FftAENcStpGXDH9cl?=
 =?us-ascii?Q?kEtQTfPRPXhi0Vm9MjhPiRD3aJo1aVSI+nyVR5LLPaFh4TPfE763HvIyLGJW?=
 =?us-ascii?Q?XEX6vQ1YLrdLsjEj8BFfAjXIkCPIuxUgcvS+oc39qbUGO0rfbFMygPB7wYyI?=
 =?us-ascii?Q?LZEtBXZgEwxVyIJYWJ9+OLUuD1ggTQGMXchrpRuF21ty5+CKDMHbB52Dhlg0?=
 =?us-ascii?Q?8UkfoEs/n2S1gWrYS+DeoVBgKt9qUqDm5DTZHsFZzHuERYtoqGqa9y5z3tUk?=
 =?us-ascii?Q?RHPgsAxcMskU2rUjSnZ9l745FmfcfTGcDMdYwjzQDnuWAiaYiSdJdhS6r3W6?=
 =?us-ascii?Q?+NOvKicNPDdxvDwC7W7DvzwqycRYYLcbxVXXJb7dC9iinE6Mys/90K6CCu4Q?=
 =?us-ascii?Q?pp+JBPGUoKuZDR+DKYPMBDOyQbL6cH5rFB75xoFNRg19En8CGNiCyOHes//q?=
 =?us-ascii?Q?bC8RyGNkLynxlkucBr88dL9pX4llqsi4+I8rpjF7ikD8ndVtfpNRLrTGFNAx?=
 =?us-ascii?Q?QQhANNiwKhKYEDPVY/RPdc43r1DUUp0OCdPTlV7rgCy0Bfc0GPL8wL+ohXQs?=
 =?us-ascii?Q?xjKoEGz1aeUfu+FPNe6oNPdOWpHV5vDDfJxOcmbka4zltlKr5PCZslghMYdq?=
 =?us-ascii?Q?CeaMoFMdezRZASkB9kVuyChb0RHQ76J9V5BsZOovTSDC0rMar/fyvrsdV7tI?=
 =?us-ascii?Q?0lhQfhbVJv5MzruYESaACuNJNi4p0Z3NP714f9/gEZq+vF1YGR8nU5+eeJBA?=
 =?us-ascii?Q?wTDDkqiyvyJvTatdnqMJYzYLBJzek/pceWZSq/FhtMtSbv7ECyBHBsl+R0e7?=
 =?us-ascii?Q?hWT74bLXPjqCNGr7kJp4jRcfUgsgObvk/Zt3p+27skukPFGGNoZxUc5QIwm5?=
 =?us-ascii?Q?wPjMPOvCO7MchnOc0Tu3IetNhUAMCZ5qeqFaELkKNWKDRw4cpBpYJObQV6Fp?=
 =?us-ascii?Q?8WpwjjRx6Fn7NoThk9JdapAdTtJJBCXqtaAVIA7WeABJWSxt/Z87wr23rPEN?=
 =?us-ascii?Q?7rhMyKWY+1mSt8hGDVBrPbgmmLADyMISBxEXkj1wG0FTUVitetcM7avGFjVw?=
 =?us-ascii?Q?tdUAkExxIeWRMarJ1YQfp2FCZFqx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+X20OQlSJTaz5W0giQXvCoKX3ciXp71xakeraOglVLrZSFTc3n+XciShHqyX?=
 =?us-ascii?Q?v1qjceTtQaYEmDw/Z3TSovPlO/Sj9qIcPMCLsD7YnPTuWGCSWpwiwUjN0qEG?=
 =?us-ascii?Q?7lWUKqlEC/6vmtwdcnIcO8jmARCeEDdfJXGEJOMwNcAji9L2EfXQd2spKook?=
 =?us-ascii?Q?PcYZ8RKTj//o6pNiNtshAh1OpX69iCJftpKp6klafboUXsjmrjjaW8SkTeW2?=
 =?us-ascii?Q?vCRUe3N2HRfmuj4DnIOTXsHshuB4OiPttD/KlELfVeW/Sckj+pLKVbonMSrc?=
 =?us-ascii?Q?D/1cNTvKMzAqyq6Ig0oWB3QeJHnjv38qDSJQ5EfDmuMsBw8F8eHJsSk+nEv0?=
 =?us-ascii?Q?eDir26ebmimBGFowEPwiR12n207pRt0YMqiG9akY02detoxbxsshVTltgw9E?=
 =?us-ascii?Q?/huMgqBOjkcdiks2D1qO93iGCud6KoWgedZR/eMCK6zRp/Pq485Qi/UpKk27?=
 =?us-ascii?Q?x451CHXSQpm3AAV6b7bo0TQkABdcgPhhldDRA67ejrWENIjl+lSIG8a/U9Ug?=
 =?us-ascii?Q?YYuZEaU5qg4UEmSF2WTC1RYeIOJjyFoJi/m0b98obAyTfXfV2minY0rvtbCm?=
 =?us-ascii?Q?QgttQ1HtKWPPK3vAxJTtvGvZD7XGtlKoTwNDPpXwNbZ6obqDY/nMZDoc31bh?=
 =?us-ascii?Q?2nqlRZdkPshvcslY3bcB8vFC3sfg1mg54U4Ggg0neD30B51sN05FznfpGeM1?=
 =?us-ascii?Q?FPF9OPA5rOJtnlQokq9t8m6H4Md8jwlRa4xWmxgVQcarHDHwlOIc6TBIAxmX?=
 =?us-ascii?Q?uhP16sNjkbUmC6MOphwvkOU/i4DuIwT8vg9c7fn/i2N6LonuE4N+aDVksM8x?=
 =?us-ascii?Q?vjsOuBES6xwBEXqrkh65fyrDfUlLl3tK88SOF6BDD23+PIT3Jbjt1QqMb/zX?=
 =?us-ascii?Q?Al1eGmQbzZBNGYxosh7cSBUCWjIxMx1yj4KNl5SdQSeDFxse/iSk/IUIcLEF?=
 =?us-ascii?Q?nNyYIMW8655KYlvFdag3jAOvdMCghNaLxnUwhakaJMgAXuxyEq5Twp5x5S90?=
 =?us-ascii?Q?lMx1gIWxbrtYeAMYuSFLv2F4XpPOMm6VZeYrZuTFgo0OEOCrEO82z1RnKO8P?=
 =?us-ascii?Q?ztN3o+BnENwUSER4sJ1WF0Cd+9HXU18RqS1CbOqrYZiwo3cEUdcfWy/KY95p?=
 =?us-ascii?Q?8gBqy0kvNvZw8H2Fr/KmHVjGQ1s6GPTLT0SVlqiRj8N35ip9zIalY7LqFDuW?=
 =?us-ascii?Q?czuRz1P+NlRgjwZCT3Td21duBF/td+hUz//CxBl83LK4SR6PsJzW8uG/3ZKW?=
 =?us-ascii?Q?F5isVgAoq60no7/IYPLibnqNoDIC5eUI1p5W8P3v6E95jhhgDyF22OZSSoCy?=
 =?us-ascii?Q?OtlwQAH1yIljhkFeC6csjt3HkMpgRSewUA0Op8tNkQKKACuJt0FsPuHxrG8p?=
 =?us-ascii?Q?v+6KKHDDh1yqx/toE3plA4lwlvxe/bvnID5HkQn4oldiMWSAdZPP1jMBMhYs?=
 =?us-ascii?Q?bJwz7LOsUzTpj3me1xR20cOXNTx77waJuSFjmWEHfhcmQ85lgJZM83WueNrH?=
 =?us-ascii?Q?17OL66rQmn/c94Wf59wFOethGmp85XheRfOetiS2i3FbC8l/Y7xEFfLkPwMy?=
 =?us-ascii?Q?bxki9ovWbhn8lJX+p3nOEfhNe/YCXWlfXC6qp6CjOAP5T8r2diNyvUD9JFN0?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9kipQe2EG6qadliJkje6X0bakhoYGYoC6EcpWTJyKn6aDT0y3Ab4qm2wZTbwZOLb2Vv52b9pateIKawopEqqszFcTIU0b3YnD9R8TkRkF106uekWAL/CTIoAl2XMOlHoE0SgkniqopmW1/ox4xEie0bqR48kLNrD4meJbqav1Mf2m03aDs1Pn+UyDsYe7f7mD4AGcYf5k0sNcZYg6ZcDRHWgp9t/pb6YaCecPcql7YxtHK02MwI0crfw9o1NicHRaIfP+h2UdcQSpk8DfxeMYsu3i6ZTsVrNBbqIy9m+kPWQRrClafM7MAuTdT0jCwCeqWaPZCNomT6ju8LtovRfZsvAxiKFFhW4HQlrfOwmcbuDKaZ9l6tDJGOt8msqNWATIV2YJw9m2Yd8FCq4kRRPKaX8hSzfdnpAII2p7cOqkzN0JWg3JkOEi+JpIICnjbv713eDRg+Bxul3nBkkeqW/lqQScj5zT+2YrJQaFrYLtxbOYpyYAp9Bq06J8JB1lDfQsC9ZiPkAizYqmrj7NPAhtcJzoKKmi5EGemWpPPhCXPVrRy6dMe0A9l9XRLOMktiXnu2F0e6ThvQq2W4XpdYl8ZXL2uezZCWM807szxJc2ag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4081acb5-8b8e-4361-8a3b-08dd503c3349
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:49:24.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z63ohBHimYqDlUmw1eP/Hd2yYeBEccgUwFUtFzodAQ5yhUvXkGyWYe1ydLrhqYjsx0e50XoVXjjWbSj4nLErVUJwyfLcuu16Qq9V38ztE5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180120
X-Proofpoint-ORIG-GUID: YoCpGx6Lo-8TnWc90ukV4eYe2708103R
X-Proofpoint-GUID: YoCpGx6Lo-8TnWc90ukV4eYe2708103R

On Tue, Feb 18, 2025 at 05:27:24PM +0100, David Hildenbrand wrote:
> On 18.02.25 17:21, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 05:17:20PM +0100, David Hildenbrand wrote:
> > > On 18.02.25 17:12, Lorenzo Stoakes wrote:
> > > > On Tue, Feb 18, 2025 at 05:01:16PM +0100, David Hildenbrand wrote:
> > > > > On 13.02.25 19:17, Lorenzo Stoakes wrote:
> > > > > > There is no reason to disallow guard regions in file-backed mappings -
> > > > > > readahead and fault-around both function correctly in the presence of PTE
> > > > > > markers, equally other operations relating to memory-mapped files function
> > > > > > correctly.
> > > > > >
> > > > > > Additionally, read-only mappings if introducing guard-regions, only
> > > > > > restrict the mapping further, which means there is no violation of any
> > > > > > access rights by permitting this to be so.
> > > > > >
> > > > > > Removing this restriction allows for read-only mapped files (such as
> > > > > > executable files) correctly which would otherwise not be permitted.
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > ---
> > > > > >     mm/madvise.c | 8 +-------
> > > > > >     1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > > > index 6ecead476a80..e01e93e179a8 100644
> > > > > > --- a/mm/madvise.c
> > > > > > +++ b/mm/madvise.c
> > > > > > @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
> > > > > >     	if (!allow_locked)
> > > > > >     		disallowed |= VM_LOCKED;
> > > > > > -	if (!vma_is_anonymous(vma))
> > > > > > -		return false;
> > > > > > -
> > > > > > -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> > > > > > -		return false;
> > > > > > -
> > > > > > -	return true;
> > > > > > +	return !(vma->vm_flags & disallowed);
> > > > > >     }
> > > > > >     static bool is_guard_pte_marker(pte_t ptent)
> > > > >
> > > > > Acked-by: David Hildenbrand <david@redhat.com>
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > I assume these markers cannot completely prevent us from allocating
> > > > > pages/folios for these underlying file/pageache ranges of these markers in
> > > > > case of shmem during page faults, right?
> > > >
> > > > If the markers are in place, then page faulting will result in a
> > > > segfault. If we faulted in a shmem page then installed markers (which would
> > > > zap the range), then the page cache will be populated, but obviously
> > > > subject to standard reclaim.
> > >
> > > Well, yes, (a) if there is swap and (b), if the noswap option was not
> > > specified for tmpfs.
> > >
> >
> > Right, yeah if you don't have it set up such that dropping a reference to the
> > folio doesn't drop the page altogether.
> >
> > I think this matches expectation though in that you'd get the same results from
> > an MADV_DONTNEED followed by faulting the page again.
>
> It might make sense to document that: installing a guard behaves just like
> MADV_DONTNEED; in case of a file, that means that the pagecache is left
> untouched.

More docs noooo! :P I will update the man pages when this is more obviously
heading for landing in 6.15 accordingly.

Current man page documentation on this is:

'If the region maps memory pages those mappings will be replaced as part of
the operation'

I think something like:

'If the region maps pages those mappings will be replaced as part of the
operation. When guard regions are removed via MADV_GUARD_REMOVE, faulting
in the page will behave as if that region had MADV_DONTNEED applied to it,
that is anonymous ranges will be backed by newly allocated zeroed pages and
file-backed ranges will be backed by the underlying file pages.'

Probably something less wordy than this...

>
> >
> > > Okay, so installing a guard entry might require punshing a hole to get rid
> > > of any already-existing memory. But readahead (below) might mess it up.
> >
> > Only if you are so concerned about avoiding the page cache being populated there
> > that you want to do this :)
> >
> > Readahead I think will not readahead into a holepunched region as the hole
> > punching extends to the fs layer _I believe_ I have not checked the code for
> > this, but I believe it actually changes the underlying file too right to say
> > 'this part of the file is empty'?
>
> Well, we are talking about shmem here ... not your ordinary fs backed by an
> actual file :)

I am talking about both, I multitask ;)

>
> --
> Cheers,
>
> David / dhildenb
>

