Return-Path: <linux-kselftest+bounces-17096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2D96AEC4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7E1F24419
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87ED2562E;
	Wed,  4 Sep 2024 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mvm3G0Ju";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KwvdLiv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62B10A12;
	Wed,  4 Sep 2024 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418017; cv=fail; b=nImceTYxbrHnl4nLzxO0itJFvZKodUJ6pl5JvslORQuQxSGbm/q7cjI0X8cD34K04rKTZFXG3H0TEWXmXChhXQbFiXreG2dPJgKjfHKor11SFyw0UXsJ3X4DID2wx7P77l/g4kndyszkyJF0gI08ca/t459FzixMt4t+qnRbJoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418017; c=relaxed/simple;
	bh=UvMZ7iVR1ZO/GqbESyK63+OFRLiPEyAa79T++Wnp3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EvcLbv4zgIRx/Su30AAoH0ehydg0GetbZkABUF8nPRdwbzZnqEbsi7BhE3T8VW0kEsqB6jYWgPX8ogWnaSPI4v0Wo/sIcWp8vnVXL8V1HSAlAqFdFScyXTt0fujpTjw8xKTK1if2xOCmHZq43Taksx0mJvX180o2d16A2/sUZnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mvm3G0Ju; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KwvdLiv4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841MWoa029462;
	Wed, 4 Sep 2024 02:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=707zmDN2C/mjR8I
	yCE+5lrSVp1JnLTGTr+9yQ9EgcsQ=; b=mvm3G0Ju4Lt6hwhiEFd8uKygYrgw740
	TIXgSS5MwrxlIFZHmwUceYoo0qAhS6l3XBD+9VvOsSPjg45QCyWmKwkknJ+jP5RN
	6pKRAPZJztt0nmoLmrag6G4z3F3CISnY/UuQjF4ShkzZMshhhYNPPDYmYjO8RApm
	IR7cVgrWOB9Ha1Y2tE2EXPghRbihlzgcwmclJu+qOEccsnhjoV7Uqpkse+rOXfrc
	E9sdhL3MFivgdW9afUwqTK5s+RK8bTqFBNunJwb4uw6Dq5UsN95+dMynT9l8Exqy
	GCHhDvxE2Cmns+Hq1NiG+p2rmOlH7/lRtoZlaPtAQQCM8qzHx/aAHhw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj2dmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:46:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4842YHKH039591;
	Wed, 4 Sep 2024 02:46:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9hfxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDuOZ5Vppv9CR+l/7bxmIp6vNbraPXqjdahDNilxBJsXKlZDsRG2hoJvmQ4F6FUY4fUhw5FGk+vrboiqw8doEieUGTY6A87ZCsUOUgkslZVlHPVuXoJaMrWFzucodMUeAfUMybRu0kDajNOd/Hztm1SjtigYSt8CC3o2j/1zXP+359RqKLI22RVJJx2X5AxYrWE9AwgLrX9y7g4+4OJFEUrR5JfVYI/59qD7PNG2Bq+PzCSENxLUlI+dT6Yj6GHJ2W2GV6fjewq/5TNLHKZU7TDKBp7Cc8KbD7Oy94hw93B4+/4WqZjb8aBUx7VXjkwrWrRbH9lFbQU9C+3epWanyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=707zmDN2C/mjR8IyCE+5lrSVp1JnLTGTr+9yQ9EgcsQ=;
 b=YTdxcXzLxg0l3GvsqwoAJaQkxKKEEV7grQ03zpo/ZqobdQ1hP46o7B+gjzxWoG17p+G0+xCEFnTiO6lI35n8J0q2/YXEK3IM1Mry1iZBHhwqCDJ9EQxg5gdEE69R43kHSsW3AkVNAYBFjAmGLlzMdgPxYQalTclMNHxibdF07qV95nGksEV54X1erMJxCnODCgxLb0Sxfn/qKCOEiuapM9he7Qbp0XoFtazVLJ+PHgrdoXpEYUTqgV6gje2QS2Xu1sv0O2SifXOc6Xh7fl9p7E1bwm1EpRG5W2sS9rLMIaaDn4D6CCvZG19ZNHyzBVf6qbB6MuKvdS7A7MfM4U5Npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=707zmDN2C/mjR8IyCE+5lrSVp1JnLTGTr+9yQ9EgcsQ=;
 b=KwvdLiv42Sj4kR1qq8EJ+jB+5YNp48GZdHZ8DFngInP0JGjCGhfudJFBeHVpY2Q6Ogg8fz13vZpuVrJOKFjCM838RlysmJpxlOjWtz30QgrVlKpIlQ3aW23t4IGyX1hm0MxUz0kX6hxH3g9G9uSYAd78LX8lG5anfl/af2fQgCE=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by PH0PR10MB7077.namprd10.prod.outlook.com (2603:10b6:510:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 4 Sep
 2024 02:46:24 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 02:46:24 +0000
Date: Tue, 3 Sep 2024 22:46:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
Message-ID: <zi5ahfi3pwwmirkbxcipl7jjx56qsgopvgjb2pnrj6yz6dxb6p@fhjivxhiiweg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Guenter Roeck <linux@roeck-us.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::9) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|PH0PR10MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 151afd4d-a5da-419d-23fb-08dccc8bc44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X68DkbW74bpDxT9FOQ32kpk0xeIONDQhhEttf/OBkI8NIgJguYyfPzsXXex+?=
 =?us-ascii?Q?8J4phGM7RjUC+OCD7CPJKHT+Av0lNOsKCgLmgXDiI+kmIUU8BGEEJYBc3j/5?=
 =?us-ascii?Q?xAHdGat5ejwCg2QGpT5OgG4DsEV51Z+vQsXHDTYAIiBJMMaYG7nYsWPyIbcI?=
 =?us-ascii?Q?glu4IdC24b/8jPm7QDacBfn9NzfaBO+FEHWbQ1oVmQ5+x5T0gd0hPNzguHBr?=
 =?us-ascii?Q?9v3Wx7LYuQZG2rJk1UtXNSUxg2/axy3NeJTz+GVIWZe1uK/CzfTRQyJ+NUY7?=
 =?us-ascii?Q?XZwG+QbZbkKKyk1k0vv55MVRdlVEn2wraRNaPJoZTVZS/cP5wUJp7U7sqtN4?=
 =?us-ascii?Q?D8+AAzLB4IC3NriOsjWO1Bn8/OgxQpolKCbmjDAZh3jKCx6QRYrHGQ7ehUZM?=
 =?us-ascii?Q?ybHxciJjijiEUsgirUC3VDqShbdcr5wjBh8CjF1g/HLWCfQHz0xVz7rg6qfq?=
 =?us-ascii?Q?d+Qm7Gt43rkl9nyTINnP7ImBsI4jfFf4WgbsMlzIWtWRdbiQxnrJPwd3NROd?=
 =?us-ascii?Q?zhnYel2jQcq37/wyXL3CuUPNJHC1mut1T6ve/VddFbzedWG//QSm19mI7aDl?=
 =?us-ascii?Q?Jf2b76k+eJIMSoaQA2se2hYEdOV8IhGuw+sVhLjtQHDNuavvcxwpvJoa2hzu?=
 =?us-ascii?Q?5c5/I67diD3pcz4/P4dR4Nm6HztiW5X21lo+t+1Kn87jGiMG/hmtb0EWKU7e?=
 =?us-ascii?Q?/38RUFg/yDZtjr60+eWBVRtFLsWE+8AKgzxglJJvuAb6aoxErug0y4cMsW3r?=
 =?us-ascii?Q?tlHcjrdoDb/7Um99CnDPsLZIiRVzDBWnFQg/aER1jvCpxjOaGrv94T+2us0u?=
 =?us-ascii?Q?+dBmqXJV6cF89qIJrMA8eulNbML+VCHY6iOVgFP4o23hDCb58hwjMVHLf+uZ?=
 =?us-ascii?Q?FGl2okHlz6VbzaLgPUHsmPsDnpWPYvd4rQspIwnSMqeWWL83iUekjUElTWcX?=
 =?us-ascii?Q?sbdo9NB646thb7jJDJf7KhmoC6aWzYf3WF9GUEXPfFAIi4i3HKrZx/LAlvn6?=
 =?us-ascii?Q?Avwva7cAVPjH/rTf2804S3rxXDZVtwXZ0zk+UtJDCRSLVXTmHkLjG8kZYTZp?=
 =?us-ascii?Q?dAgqt9WZyroLOHRfA+HhHnpepdmIWRii46j367W2O2vcHdT+pN5+4ni0HSHN?=
 =?us-ascii?Q?3NHLTn0aC2o2Tn8hP4xUXjpmP+ZS1hg6511EXsoaJG1OvkVqp8yud/Q5J7/Z?=
 =?us-ascii?Q?74gTWvh29MFlazKDRLKstqCPFxii1Siu08eAfl/PZR8mmAqzVoyPjaWT6Csr?=
 =?us-ascii?Q?PG3nfN9dSSHIfPxwtxpAx7oOoQaaVdqa94UvSU5zK9RGHXV8H7mUpLzAvPgj?=
 =?us-ascii?Q?NMHNnAMx0BqaNR4rDRowf5dIvSr2mz+G1PYgqYE0kOSVWL5v7oohwf5kGdBs?=
 =?us-ascii?Q?MgDdgf9TIfNscrpQgXLANmbDLYOtRkdCorb4irLuwM8g2vF56A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFGO4/tYZYYFPbSswFTfX7M9KILmYtw7GYpw39Fzac320eZl6Va4eAWlMKSK?=
 =?us-ascii?Q?RocAeewkwV+ucxJOnEJmT+0XE32DPd6bv/JL9ujw9fsoisEqrjVnx86eyqFp?=
 =?us-ascii?Q?VV9QXLL7cgb0URjFMyxmaMoMEFTMnP/bRBwQuURVSZc+01gEYrdXE3Za+WoP?=
 =?us-ascii?Q?cpa6KJ/L3STQxQZL3MfxcIAk5RqI/AErOoLM5mnaoWSjnH0U6GCg77JX5jdD?=
 =?us-ascii?Q?fMEAtFd1+akFkJMuol9V2hLhRVXj85XT+SCI1jvC5LXzfaog0ExR1dQyPMGS?=
 =?us-ascii?Q?tzw17JKA+TUika6ZKhHTHlFmTwNMPcFUBZDN/ZTKrWdvzqmrUbHscjUvEMw9?=
 =?us-ascii?Q?mAPNsL0Db8VBzqD4YFIb7l1w4FlrYYdKgbe02LVChSzQvq/7avOhp8RjcTVY?=
 =?us-ascii?Q?UImER1t+4x2PjPblrOtoro5b6kx7NNTC/v/2z5fg7AYOrOlDzliiJidMaAHH?=
 =?us-ascii?Q?5KEfeA5kFZM7llHjuYzT1ZGZ4NGGUlwxB46rkNsk7WjCBbRjNkJ+q0Q5lRPy?=
 =?us-ascii?Q?tgHQlmKfD1CTvcovdOoz9JZbnolcFigAON75MCYKnlk4xGZ6n2oBebeqO4N6?=
 =?us-ascii?Q?Wc6xr6ZnhNof4t5UYxactrzdZwLh+V/jzWNCviXYz68hBXhKlPwhfPSpo9/V?=
 =?us-ascii?Q?9hRmo/G749i5lVCFTaXVyY2vaeZmbAkcgzd/p5jDxwPbPhnJR+dBOqb0mmlg?=
 =?us-ascii?Q?504a3u7WD1RZxuFeZyXY3YGAEWFrIlHkjH4bRr6sMeUeJnBYguon1F2Td8MF?=
 =?us-ascii?Q?NV8pT8i6m/19UC94RJmrX38+RwA8qmSbxConAGOR6MQrE2uFSQMPvVInNb0u?=
 =?us-ascii?Q?mKqTJyXRyl46l5ulo2QLo4a8eb/OxaY3erL7rnmyH3q0cMSzZdk6cUF6skIS?=
 =?us-ascii?Q?niWluF8DpgzOxM5BHlSy7Vtxd5AXi6nlp7PsBmka0xBWLj2Gq64FPXWFOnID?=
 =?us-ascii?Q?sejnjukvnLBzhDC2He6v+oxDnZnxiZ2n1U/XuwMQQCCsZn5au+3+Mt95Nt3I?=
 =?us-ascii?Q?O2ZMxT1bDeJoFHP9r+w/xRmYLkbzs4FxGAYKyUs6Et/0isSIOTsVFrp8k4kP?=
 =?us-ascii?Q?TZoMFISQhfsM3HaBTFZG4jIowel9AbzXcYKRk82alWhYDHJvqnLJsyRDxhCT?=
 =?us-ascii?Q?sNnto8F8CknWYojW405Gpvow4e8MsbX55QAUWXjCF4d87HTb+hZTl81C174K?=
 =?us-ascii?Q?idBOli5UK5PNMqZN+dCn+Qf5ODGcUkAatBjdhxW5eX9udPgvYqF8xJAfRnIP?=
 =?us-ascii?Q?zcOxrTopX3i2OkY2PdghopotbxKwlf9I2gwgPY/gMXdotFM/PZEqwah+Ozgw?=
 =?us-ascii?Q?ebEXTmHUSqN3Jx7mx8zwwPbk1Jze/ONFjTNcM3mAPOtryfWW6YZxllA0jpX+?=
 =?us-ascii?Q?SxkCqUxltHjQESDlKw8wkQrVwLmvVsyDu7vcbplYAH0g64EKp8S/A0UL5yHM?=
 =?us-ascii?Q?BCNDt3uzrNqxcd8F5nLKWv5dEDRh2m6s2oj4iMiShvFZNiiyC/RRVIzBLa2H?=
 =?us-ascii?Q?PIG/QqhW+YiRyNT5e/3946lVLUQbKp2pul/5Zzk1knrgdgmAJWZe76FiF28c?=
 =?us-ascii?Q?JXx6iRj+yzP4k7ZWw0wQaLp2FFI4bz83oEpUSsV1TWSUTJxGihBil89+L9i8?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CVszeNXBeyibMoPpQdGZ06BZNIkt7Vf3w3RWXjf8JNHAAjFGUKmqO8o1sZacSIad26gfiOEElLzCZYGKZ4pG6pXshfkFxNk9rKQE1xCbbBKlTiZL4439aU7q+Pt48DzWvW+8Iy3fqvaYQ1jrnbWGOej601tyJM0nO3d0Vw5aAMjfMu9yXbzd7sxgVyzTJcgoVpP1Rq1ZvQuNZ5BX412uPwxPzBTFKi+DbujMh6VhgVrjr1r/hnifRS1IFkq+3xuOcUoH1cBmG7A+s4JS2+FBW5Lsu474Jq+cOA739SmVUI0VtfPBH8uf3+G2OAwvDBeJax2vXZapwtrQZyd6N4huwgKOpLq7fopOG42jkeycOhgMheN8BNhm+HntXnhl8lpGvaI2W1kZEEmn2BLifG7WPs7WtBx2ZaF+CTJOHrppwxHdEQNEMe5fGPngtYe7Orb7X31kwZTJuEQFKqakFHXg58YxqP17yk7lPCtfgzHY9UzDnR6BgnZeNOT5jOZGt3PmNePt3V7s0Up3PYg85j2eTgbCB1XVXy22kiCnHAO4kuHXz1I0lNSd0gpy8yj8+LSGngdxXgRBHLVkVQLi+PZ0d0LbWk0gTMPYTAWzS0agClA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151afd4d-a5da-419d-23fb-08dccc8bc44d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:46:24.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/9SyyBfRg17B2fkDXqvY1Ksl74kTLTOSKcLU5+MBRisce9DcVfv8NTeQQDmHiwklwUxzKAKl+V0PflsjQWgRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040018
X-Proofpoint-GUID: AdGj198ReTvjA1ERqK1G5zM6ruA58yI3
X-Proofpoint-ORIG-GUID: AdGj198ReTvjA1ERqK1G5zM6ruA58yI3

* Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
> On 9/3/24 19:31, Liam R. Howlett wrote:
> > * SeongJae Park <sj@kernel.org> [240903 21:18]:
> > > On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > > 
> > > > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > > > as promised.
> > > > > 
> > > > > You can't do this, lockdep will tell you this is wrong.
> > > > 
> > > > Hmm, but lockdep was silence on my setup?
> > > > 
> > > > > We need a lock and to use the lock for writes.
> > > > 
> > > > This code is executed by a single-thread test code.  Do we still need the lock?
> > > > 
> > > > > 
> > > > > I'd suggest using different flags so the spinlock is used.
> > > > 
> > > > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > > > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > > > better flags?
> > 
> > That would be the lockdep complaining, so that's good.
> > 
> > > 
> > > I was actually thinking replacing the mt_init_flags() with mt_init(), which
> > > same to mt_init_flags() with zero flag, like below.
> > 
> > Yes.  This will use the spinlock which should fix your issue, but it
> > will use a different style of maple tree.
> > 
> > Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
> > you ever add threading you will want the rcu flag as well
> > (MT_FLAGS_USE_RCU).
> > 
> > I would recommend those two and just use the spinlock.
> > 
> 
> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
> the suspicious RCU usage message.

Just to be clear, you changed the init flags and kept the mas_lock() and
mas_unlock() ?

Thanks,
Liam

