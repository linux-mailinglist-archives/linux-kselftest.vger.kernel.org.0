Return-Path: <linux-kselftest+bounces-49143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE6D31B9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 052A4300532D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369425FA10;
	Fri, 16 Jan 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qaixT4vx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NlTfEVFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E591D5CDE;
	Fri, 16 Jan 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569673; cv=fail; b=uzkaSy2etI2KZm/Rytplwdj1IduonvaQSvUbaTJZ7GCnrwdhxyJR8/m6TiaoGAvEfjNqVhfUE5oATqQqFrqAbIh7Xiu2tnAb5Dap+fdH1Gd33j/h0afJ7Lo1VjAPo7vmBH0p9uZwh6e7JbdgIXrqGPhWrC2XEA7sKWT2cuxqsKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569673; c=relaxed/simple;
	bh=YP5YJEePDfWo2a/kV6ohiy6DCAbIlT9X4q1/da43qXY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WVyS4ejryJUF16uOOyYYvhPj9kNyrUBDbF/+gIcdF1UBN7/kt3UqvC9AX7rObWc9bZKbkn2N82WnCammWYaPjQ1FJhPC/0aONY0Ik3w99gR9eq4idLJkvaSOv8LsZ3MgG2wjAWgK//Fed0rU6MGLff2Qy1J4UAreaptpc2qb5AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qaixT4vx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NlTfEVFQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNdnk2456646;
	Fri, 16 Jan 2026 13:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=8mfg1VZq3dLbAy0a
	124JTpnXsc92vCNQ3l9Ukeyieqs=; b=qaixT4vxZNQff5uwPvvSkIM8g3lv7sGY
	flmw2AmJc/U1HTVHWOPBQKrGi7tSee6nyr8PIF1/nD4GU21kzNTxjS1DJHS9qiQV
	vpolLmjV71mD0T0zh+YounWnjal7xvbdfzJQXAMA8T+HbT9oH0hC5pGgSXnXuzjB
	DGHjP0CDvRJv8PtvzQRXjUdU0umPn+47N3YciLDIEi6PAOxUoncrN6U5s/jYM8c0
	hvZMOaWw4WhmYtH81emU5lRBHLnYAD4pQ0uZ+szITnCysQgKwA6eF1R0usI1Uai1
	h8InMmaaZcVak62VAEY6u/A01Om68o5xuiabblehiDoglJEw0qbqWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p3d9vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:20:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GCu5p3040453;
	Fri, 16 Jan 2026 13:20:55 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7gp64e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggK9lrRuQ4EEP1DVtq8mYIw+5LX6ahJldK+NOxF5hFfY0bH6Q8+fd5pnpaC4AaFWw93NVz2P0adgFguV50AQNIWSGmw14HagPMbrqfiYEdEN40KbWuGl5yPVYqo2k4vKvla3j2csHAuFIwfxgkJNaay3d6RdefMe2hjYTYhFAOXmWkkppYF8hlfDYLUDDrEBi+vrqD6wPkxeJwuHhXGEIGFtL1cu0EKtK78Q92zDh4c/kPvrDdiVfSfyeccYNK/i7FkCSbwJzxooDhbeHK0fkE7apfGqVChmEcvIltA6QKsECih1ePXoAvzBbeqmfXENVz0fg/jP5uq7UMDuNeeV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mfg1VZq3dLbAy0a124JTpnXsc92vCNQ3l9Ukeyieqs=;
 b=eAgra/7C24FtTo5S7+ShgwbzANmpSwgMYvQ5X+eKkSWFYN9x/kQ/xIKoS92Brxn1FysOqotn72tHHt+dvVLXsVZZu1MbcDlHhvMJww/6mFaXl2eGOr9cXVj+UsoeFE3xRUzcFco1XABuNLkjflk+QJHo0fYYdU8EnWB01X4PAEoOrn3+GSWpYekPCSkqBj7ilPsm6b/zRXu0eH53Ap/x5L1HwFXxFLwUUM5N6p5CMTYNQ3ddAF+DtbqNBB2kjkVZw5GF+8RTnnEvkfrCZkiImcKUl5TRL4LmFOzSj1bI/nPdOEVxsv4NYnuo9fRKs/n/63oQK+zm4vNQ0Jjw7pq0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mfg1VZq3dLbAy0a124JTpnXsc92vCNQ3l9Ukeyieqs=;
 b=NlTfEVFQddGuS1xOa94rD/Q8/KoochTzndFCq/p+TYMM9xrWbisiiMttaELdzq2ZjpYtG3wfSj8ghD8sjkrSn4i21Q8qOd+9UaRnT58EgKI2E8YIRERIiNKBLn6+bQ2Q6lhmQwhSanMPhs3K8qOzL+t6/GDt4gjoD3VXG9YHDT4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB4870.namprd10.prod.outlook.com (2603:10b6:408:12a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 13:20:53 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 13:20:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests/mm: remove virtual_address_range test
Date: Fri, 16 Jan 2026 13:20:53 +0000
Message-ID: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aec3526-6375-4fd6-d6ac-08de550212d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSqsFnMaG/gqXUCOr3TM5KXrHqkBmxsEHT6uo6O98MgDwYlbJP698dzWgjWC?=
 =?us-ascii?Q?xV+OPt/tOiPxnDpfJNbqtak0h9rGleX6RYVC2vRgrNna6/BLrF1HWFm05Y13?=
 =?us-ascii?Q?Ys7B0tJo1b5g0sxAbX3sfDF2LB4e7Ybjv8HadBtDX2VzKYHyyBLcfH5MWJjJ?=
 =?us-ascii?Q?7xlspBwGnYVgcULh/RUD/6HdJfc0iJT4RqeIedfhM7x/ZPAmXi6u6YEEWUvm?=
 =?us-ascii?Q?GbU4Z150eCkrSIMuLJ5RzsKekwOd+sATak8YveHpM+i7NzcvhpJlqr/Bcr0z?=
 =?us-ascii?Q?fIbpYTADVybDcRloTuCq+qYVTLPZBIZFyiGYgPYI8ePZkfDW0cdGUkonADtX?=
 =?us-ascii?Q?ebBDNlvYxK7GqfXCBaxg5HsHxVJ0CkjcOMSv0rdFsUj4fZAsUf/JJginZH0i?=
 =?us-ascii?Q?Y3BYov3epvxrgxpBNY1wyp+3xcraB7Zu5uqqiU8QalOeApPR1+jhZcZ8w/vo?=
 =?us-ascii?Q?dhYh7bLOyKQslr4Yhum3e9EC5MNyyHzq73VKowpgckxxAoJArg7NXyYJ0gFD?=
 =?us-ascii?Q?+YICxhJ6j5f8Y7V2p8a4gRjSXHWENQdlgp9JTQKcjADvHZXJ28RJS1ethLo5?=
 =?us-ascii?Q?Hp38dg8C2Am85nH/8DV7kSryahemy7ASjLb1hX5qjXsrSNMx5obwWMKNiqy8?=
 =?us-ascii?Q?n8o0YBLNiEk7sKAmsCO4RWF5uxMddj6kIhyOhOxUJmE7+Kvr4KUNjECTzWFQ?=
 =?us-ascii?Q?q9oVhoey3L9nsYETyP8htEXEaffGbKZsWIHqOQ2ATmDsVulG3pK+EiEnce7s?=
 =?us-ascii?Q?/Cl9+1IcPS1OXk56GfKnYEjHv2uQdkLkoh9Yj+CxP5LSQRh3vYDjffjsBE30?=
 =?us-ascii?Q?MZbQeMP6NJiyl0HQ1UyI9L5hTGH99si+SFbdUGDVGFGM62R6ZlLcnQhRoOeB?=
 =?us-ascii?Q?pHEHxMAZZ1oYueB5B9A4N1iEL/I7kwi1Pmeizncv/Kb9RGRJBv5kwww742Xw?=
 =?us-ascii?Q?+Z+PGujUPLha0cgnCa1V2i8TYTyNKeRCkwesHmC8tOiCwHGQ53OYvZIUc7Rn?=
 =?us-ascii?Q?G+FfX9G+Frry6c98EfT7F9oUZarniKeB99pKdGQL3Uzq0qOX/yWoZ/AvMQrp?=
 =?us-ascii?Q?pzm6Q9+0MsKccO1eX1fg///FY5YDkMlN6RcuViSkB2GXkMHG3RBbMiI+whAH?=
 =?us-ascii?Q?37/6gPhsAANDGCb8OrIhoYBnZmtkQymp8Mu42gWPzUzLsMIZsXThnHzXCQhb?=
 =?us-ascii?Q?k8Bxok/nA6TEs9qfd9SrcAxdrOBVKca2wbqIDg+AS4qffSN6rZkRNAQJHEvH?=
 =?us-ascii?Q?QHq3F7qGwGERwVkP7l81WFGZXdxB+sPLww1VJrDJCZ0z10VpN6WbF5b24dxi?=
 =?us-ascii?Q?4D2PtTjHpgK4VO7k4MeELdXdHPK4daC0SzDCmbgSSf7ZVWHToaRIY9EJXJJT?=
 =?us-ascii?Q?Qy/5jdY44Tiw+z9EhaS3MnTp5n12NLDdyLCREvrsOYQgW1KVaEHBgyZVfoC3?=
 =?us-ascii?Q?7fW7MWPswMxhZGt4MxdJaYVCKy7P0V22kCRIIluTVt3N4iWYiCf5zzqLf8Ea?=
 =?us-ascii?Q?YPNrQsH/XgSjSgXECOaI6tJNnAc47Fd+08TGWnVAws23RWGC7/yB6ZaukzD6?=
 =?us-ascii?Q?ReAGRAhCnl7QAwIyFgE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kI7mFdKasD+sRzA5Xqv3/Z93a69h8OvDkzWitr30oQSUlR5Qw8XA4wLdHUUB?=
 =?us-ascii?Q?SMVKD+/68ob/TNOGccMFVcsgs2Cp2lTzv+yZllTCl9wwRmI4z2ciJ+siTKrK?=
 =?us-ascii?Q?JjiC7rwrzagQwvqrJk17o8rDxqzKWVUmLPBYNvWhkXi22PGOwO9h92oumgkY?=
 =?us-ascii?Q?4Xmn0xU/DAaEdiq/95bjPqb8cgF7xG0Vldv7L4c4nnfA4IsBsxC44TCGAQaP?=
 =?us-ascii?Q?n2voTpxjybPN/eeinRjaZETeGzhheZShDuPRrUgTrFXwXwux9ExLpQusR9I5?=
 =?us-ascii?Q?DjSS1zgilQoM8xXG8Xl8iyIYpfvVpc/iNw7QLL2bv+sw6pDzzfAR3B8T9Ve9?=
 =?us-ascii?Q?HlA4t35YQ0hSkYwl3eSf+/C+pr1Olt4X9UBg/T6aT+xGJd3zyJwszHVSuedP?=
 =?us-ascii?Q?QVZjfwM5fWweSFyr0chjsJ3GEbeESeHFa88BnscV1sXXsrJlR5jFoCTIQ42r?=
 =?us-ascii?Q?NUhyUM4D+q6DXACHkpioz3LUlhQ4FFE8anNWIcI+HIWPfVYv59IadGr8ZJ6x?=
 =?us-ascii?Q?hm5GEfzNsKprQphSCqwnXnpXN69txti/MAkiNTp7oIsBVINwWojxxuPLuccO?=
 =?us-ascii?Q?NFKPpDJLuvpuEkatiPtu/8y/3x8FiZ2wDBtbOJ2I9IQpIEZhw2V+3Y7KarXa?=
 =?us-ascii?Q?tKApimVLMRwkoHaKg+d/gdnfJtOtLS2L4xzxtzyTlkAcT1S7jbOUQvKA5kbF?=
 =?us-ascii?Q?SABXVnFWVsvvPQbUyhGRFyBkk+ricZnTmI7EREpRuvhQ9vcVnUjQCidxQuDp?=
 =?us-ascii?Q?oOQAKZyWarB2LsDx/AF34FKCvf19i+o3MEJ3bA4pgPhdnO+UhxqbD6cmFjol?=
 =?us-ascii?Q?uZGU6wHY34601Xtcl5QQ+ct27QmImjeVPswwrc6o9YbdJGJr6VfhvqpwQ3Rw?=
 =?us-ascii?Q?GCR4a6+i//NF7tnWy9dscSzfFvK1ju1TRNydr1jFQ/L3kUq2RBSM3+hEh1i5?=
 =?us-ascii?Q?91QhLB05TZ1ZsZvD3QZq78QRqU+tj3F8DyjBPmh4WnlvM6jK9/24APrgET4O?=
 =?us-ascii?Q?luF//W0Vv/StCMqGKGgQRu5RKutqnPs6VwDVMTu37Ya7dZCnVm9Iw7krC1n1?=
 =?us-ascii?Q?cKMY9ZTs5UqLcmmftT1Cj3V73H2tKpF7dYsG2xEfBkfnTuL6d2129nMXJYO4?=
 =?us-ascii?Q?ljmcS71l+DCmIs9aCWSPiCO35yZcwnS/s99Z2YnbboV0jDH6CH/KMgmnTjoh?=
 =?us-ascii?Q?y2f1GbD+dopnu1KPkgM6ADeXZGItSvkcWElcAlFifIKGoZP9DkIu38IvgYur?=
 =?us-ascii?Q?cMLskIk5gapYuIUfrhwQ9C9pkQnrpUUwFYXF8atQ9zDmp4UcqaiYOlfljQTn?=
 =?us-ascii?Q?XsBqs6vVmdqWoDHbrfNhRRFvZMgXsrD5BdmKPSYfm/nQVn9xgUZIm99iq+K4?=
 =?us-ascii?Q?bIpEPMda37soA9Ks553nCxjzIOGek/d36FlH589IDfpcrFpO909CO9qYBDQW?=
 =?us-ascii?Q?Nev88KWaQB+cnw5HNzDimRoLxT9DMgPhOO3aXaRVok1D+0TF7WvIFZLqu86u?=
 =?us-ascii?Q?y0muUE0Nb0AV7frXx9wXb0poLJjaqmB4JUQ9QB51vGJ9fKvd5WSvyH70eOo2?=
 =?us-ascii?Q?fsRLpI9QOXmLkgJVYUTY8YH3D+DVAyCVQQ8+Xa86OdAv1KXX4a+PcFhK70/f?=
 =?us-ascii?Q?rkjvf8hU/+uTsdId6g9HmvXU9/9dNEYq/hviatk4xmlovfvOs3YIyEcaE6yh?=
 =?us-ascii?Q?SNpp4N4glny8RE6GIxEowLcnvu27LKUFl3hKf0RSg/2MEnsymJKLmMujPMxW?=
 =?us-ascii?Q?dFPUPqBER/mA5URJUij0PmLubj120Hs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nT9ZS9NPngYmRZ8LDm9UOk8msFGdX3Rx4jekpel2r4N83LsuI6jh/vChVu5BnYBMvuCMD0RiElqD5X9mxg/t6eaE00138jd/T5vOrqK7X/6kW/9+CW/mRzco+Euyjj5xePRc0hvc+1m0u4zaFEsAInNLedgSyg2VdWitrI9i4h3egHZDTs+Drf+vfeGufhzJYrz9AYPU2mLOy1wLT9oNLYVpHxfhEefcI9RVjBrwNNlR6bpW7bH/Eu6XSVCj2jfLmzRtj+HUxuIYXhZWIjIfrLggZz391v7WDjZmcXloXlxg6jseGcuwanQCJL1W4QY8bYOkZ/JisQFxXHcpGjGRbHAynWreh6tC7BW4C9nyETWuJch1MOG1PM8MG8n2rMauvCIKbwVrxCeR7EMNPRBhVdRDSeMckKnB3O7E/utWtGn/hoLUiOSK3eY/hHCporziDRXqdSLEy6XbGJ38H6yxKr4ErVh4O3PmykeeQ7sS0bxgc2IkV7rkeJYd0Sqp9SeZc25Ptd6CapohAoDQOaFI3d8rNM7Tj9a4WWNWqhWEeCzYLh6j/itmhyAxDRSD+awnpepU4+PdwwSIGr3zRP7OMyUHyfH0mmJrUlokY2/IdX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aec3526-6375-4fd6-d6ac-08de550212d8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 13:20:52.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXdVd/609HZNaA3seGs/4b0nFd0VygCrVrmwFSyHVsKeQlXWcSoyOVQFP62jnhvYSNRdoaOC8tH0vLWQawcINURrbeaKLm/YWXYHIcWggwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160093
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=696a3b38 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=dfovEp1khH1dwBqV30YA:9 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: pIy-gwmSOpgzvQDxOxkBBu4aLhPt35Gm
X-Proofpoint-GUID: pIy-gwmSOpgzvQDxOxkBBu4aLhPt35Gm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NCBTYWx0ZWRfX/RbQ9Vp0Q+m4
 ato1tiik9IFLup8A0fv+dOrZ2GBAMNokVMfTrArbV2kNWrCeOfXkjbPb7A0S9sMTiHFU1UckbxT
 2kkt7w7NYjIZjJhKZwPu56PdTFCVYFKEt+OXOL2XxfuliBznSmmzgAQ5liUyx+VudB2aoZfo1lP
 DsM/maDCqd8E43EEWur3myBe0xCrad6YYnlsccVAT3kCSEPobjzYOplI0rnSRwkcNWO1tpzpD3C
 5ub/WL8rPjYkwiVw+VQcpyCkbC8JPqbPvlvbqwdHHNW2wXuSGbLxxJQm3Imtvlt9Kt47F+ce8+7
 FJIst0A9n7J7XPam0TWLkwRAM+NzUB74Ckyuw9GzgJYLUV3/0FWav8zmKluuCNjHxQeVz6Y99Sp
 hf+4j5Zzl0tocC2PA/TqzSF20Sr09Uc1WZga/qSkoG3wFHbfV2IFr3hpDdZP/n9+uRz/QNw60+g
 eQs5tIeeXvV8LavGEZqx5PEpV0/tFAdP9O9vXxTA=

This self test is asserting internal implementation details and is highly
vulnerable to internal kernel changes as a result.

It is currently failing locally from at least v6.17, and it seems that it
may have been failing for longer in many configurations/hardware as it
skips if e.g. CONFIG_ANON_VMA_NAME is not specified.

With these skips and the fact that run_vmtests.sh won't run the tests in
certain configurations it is likely we have simply missed this test being
broken in CI for a long while.

I have tried multiple versions of these tests and am unable to find a
working bisect as previous versions of the test fail also.

The tests are essentially mmap()'ing a series of mappings with no hint and
asserting what the get_unmapped_area*() functions will come up with, with
seemingly few checks for what other mappings may already be in place.

It then appears to be mmap()'ing with a hint, and making a series of
similar assertions about the internal implementation details of the hinting
logic.

Commit 0ef3783d7558 ("selftests/mm: add support to test 4PB VA on PPC64"),
commit 3bd6137220bb ("selftests/mm: virtual_address_range: avoid reading
from VM_IO mappings"), and especially commit a005145b9c96 ("selftests/mm:
virtual_address_range: mmap() without PROT_WRITE") are good examples of the
whack-a-mole nature of maintaining this test.

The last commit there being particularly pertinent as it was accounting for
an internal implementation detail change that really should have no bearing
on self-tests, that is commit e93d2521b27f ("x86/vdso: Split virtual clock
pages into dedicated mapping").

The purpose of the mm self-tests are to assert attributes about the API
exposed to users, and to ensure that expectations are met.

This test is emphatically not doing this, rather making a series of
assumptions about internal implementation details and asserting them.

It therefore, sadly, seems that the best course is to remove this test
altogether.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 -
 tools/testing/selftests/mm/Makefile           |   3 -
 tools/testing/selftests/mm/run_vmtests.sh     |  12 -
 .../selftests/mm/virtual_address_range.c      | 260 ------------------
 4 files changed, 276 deletions(-)
 delete mode 100644 tools/testing/selftests/mm/virtual_address_range.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c2a8586e51a1..702e5723c35d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -32,7 +32,6 @@ uffd-unit-tests
 uffd-wp-mremap
 mlock-intersect-test
 mlock-random-test
-virtual_address_range
 gup_test
 va_128TBswitch
 map_fixed_noreplace
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index de4afc34e3b1..2fdb05e5a56a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -136,9 +136,6 @@ endif
 
 ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
-ifneq ($(ARCH),riscv64)
-TEST_GEN_FILES += virtual_address_range
-endif
 TEST_GEN_FILES += write_to_hugetlbfs
 endif
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 2dadbfc6e535..452875db532c 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -399,18 +399,6 @@ CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 fi
 
 if [ $VADDR64 -ne 0 ]; then
-
-	# set overcommit_policy as OVERCOMMIT_ALWAYS so that kernel
-	# allows high virtual address allocation requests independent
-	# of platform's physical memory.
-
-	if [ -x ./virtual_address_range ]; then
-		prev_policy=$(cat /proc/sys/vm/overcommit_memory)
-		echo 1 > /proc/sys/vm/overcommit_memory
-		CATEGORY="hugevm" run_test ./virtual_address_range
-		echo $prev_policy > /proc/sys/vm/overcommit_memory
-	fi
-
 	# va high address boundary switch test
 	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
 fi # VADDR64
diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
deleted file mode 100644
index 4f0923825ed7..000000000000
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ /dev/null
@@ -1,260 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2017, Anshuman Khandual, IBM Corp.
- *
- * Works on architectures which support 128TB virtual
- * address range and beyond.
- */
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/prctl.h>
-#include <sys/mman.h>
-#include <sys/time.h>
-#include <fcntl.h>
-
-#include "vm_util.h"
-#include "kselftest.h"
-
-/*
- * Maximum address range mapped with a single mmap()
- * call is little bit more than 1GB. Hence 1GB is
- * chosen as the single chunk size for address space
- * mapping.
- */
-
-#define SZ_1GB	(1024 * 1024 * 1024UL)
-#define SZ_1TB	(1024 * 1024 * 1024 * 1024UL)
-
-#define MAP_CHUNK_SIZE	SZ_1GB
-
-/*
- * Address space till 128TB is mapped without any hint
- * and is enabled by default. Address space beyond 128TB
- * till 512TB is obtained by passing hint address as the
- * first argument into mmap() system call.
- *
- * The process heap address space is divided into two
- * different areas one below 128TB and one above 128TB
- * till it reaches 512TB. One with size 128TB and the
- * other being 384TB.
- *
- * On Arm64 the address space is 256TB and support for
- * high mappings up to 4PB virtual address space has
- * been added.
- *
- * On PowerPC64, the address space up to 128TB can be
- * mapped without a hint. Addresses beyond 128TB, up to
- * 4PB, can be mapped with a hint.
- *
- */
-
-#define NR_CHUNKS_128TB   ((128 * SZ_1TB) / MAP_CHUNK_SIZE) /* Number of chunks for 128TB */
-#define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
-#define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
-#define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
-#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
-
-#define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
-#define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
-
-#ifdef __aarch64__
-#define HIGH_ADDR_MARK  ADDR_MARK_256TB
-#define HIGH_ADDR_SHIFT 49
-#define NR_CHUNKS_LOW   NR_CHUNKS_256TB
-#define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
-#elif defined(__PPC64__)
-#define HIGH_ADDR_MARK  ADDR_MARK_128TB
-#define HIGH_ADDR_SHIFT 48
-#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
-#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
-#else
-#define HIGH_ADDR_MARK  ADDR_MARK_128TB
-#define HIGH_ADDR_SHIFT 48
-#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
-#define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
-#endif
-
-static char *hint_addr(void)
-{
-	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
-
-	return (char *) (1UL << bits);
-}
-
-static void validate_addr(char *ptr, int high_addr)
-{
-	unsigned long addr = (unsigned long) ptr;
-
-	if (high_addr) {
-		if (addr < HIGH_ADDR_MARK)
-			ksft_exit_fail_msg("Bad address %lx\n", addr);
-		return;
-	}
-
-	if (addr > HIGH_ADDR_MARK)
-		ksft_exit_fail_msg("Bad address %lx\n", addr);
-}
-
-static void mark_range(char *ptr, size_t size)
-{
-	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, size, "virtual_address_range") == -1) {
-		if (errno == EINVAL) {
-			/* Depends on CONFIG_ANON_VMA_NAME */
-			ksft_test_result_skip("prctl(PR_SET_VMA_ANON_NAME) not supported\n");
-			ksft_finished();
-		} else {
-			ksft_exit_fail_perror("prctl(PR_SET_VMA_ANON_NAME) failed\n");
-		}
-	}
-}
-
-static int is_marked_vma(const char *vma_name)
-{
-	return vma_name && !strcmp(vma_name, "[anon:virtual_address_range]\n");
-}
-
-static int validate_lower_address_hint(void)
-{
-	char *ptr;
-
-	ptr = mmap((void *) (1UL << 45), MAP_CHUNK_SIZE, PROT_READ |
-		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-	if (ptr == MAP_FAILED)
-		return 0;
-
-	return 1;
-}
-
-static int validate_complete_va_space(void)
-{
-	unsigned long start_addr, end_addr, prev_end_addr;
-	char line[400];
-	char prot[6];
-	FILE *file;
-	int fd;
-
-	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
-	unlink("va_dump");
-	if (fd < 0) {
-		ksft_test_result_skip("cannot create or open dump file\n");
-		ksft_finished();
-	}
-
-	file = fopen("/proc/self/maps", "r");
-	if (file == NULL)
-		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
-
-	prev_end_addr = 0;
-	while (fgets(line, sizeof(line), file)) {
-		const char *vma_name = NULL;
-		int vma_name_start = 0;
-		unsigned long hop;
-
-		if (sscanf(line, "%lx-%lx %4s %*s %*s %*s %n",
-			   &start_addr, &end_addr, prot, &vma_name_start) != 3)
-			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
-
-		if (vma_name_start)
-			vma_name = line + vma_name_start;
-
-		/* end of userspace mappings; ignore vsyscall mapping */
-		if (start_addr & (1UL << 63))
-			return 0;
-
-		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
-		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
-			return 1;
-
-		prev_end_addr = end_addr;
-
-		if (prot[0] != 'r')
-			continue;
-
-		if (check_vmflag_io((void *)start_addr))
-			continue;
-
-		/*
-		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
-		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
-		 * addresses after that. If the address was not held by this
-		 * process, write would fail with errno set to EFAULT.
-		 * Anyways, if write returns anything apart from 1, exit the
-		 * program since that would mean a bug in /proc/self/maps.
-		 */
-		hop = 0;
-		while (start_addr + hop < end_addr) {
-			if (write(fd, (void *)(start_addr + hop), 1) != 1)
-				return 1;
-			lseek(fd, 0, SEEK_SET);
-
-			if (is_marked_vma(vma_name))
-				munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);
-
-			hop += MAP_CHUNK_SIZE;
-		}
-	}
-	return 0;
-}
-
-int main(int argc, char *argv[])
-{
-	char *ptr[NR_CHUNKS_LOW];
-	char **hptr;
-	char *hint;
-	unsigned long i, lchunks, hchunks;
-
-	ksft_print_header();
-	ksft_set_plan(1);
-
-	for (i = 0; i < NR_CHUNKS_LOW; i++) {
-		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ,
-			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-		if (ptr[i] == MAP_FAILED) {
-			if (validate_lower_address_hint())
-				ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
-			break;
-		}
-
-		mark_range(ptr[i], MAP_CHUNK_SIZE);
-		validate_addr(ptr[i], 0);
-	}
-	lchunks = i;
-	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
-	if (hptr == NULL) {
-		ksft_test_result_skip("Memory constraint not fulfilled\n");
-		ksft_finished();
-	}
-
-	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
-		hint = hint_addr();
-		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
-			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-		if (hptr[i] == MAP_FAILED)
-			break;
-
-		mark_range(hptr[i], MAP_CHUNK_SIZE);
-		validate_addr(hptr[i], 1);
-	}
-	hchunks = i;
-	if (validate_complete_va_space()) {
-		ksft_test_result_fail("BUG in mmap() or /proc/self/maps\n");
-		ksft_finished();
-	}
-
-	for (i = 0; i < lchunks; i++)
-		munmap(ptr[i], MAP_CHUNK_SIZE);
-
-	for (i = 0; i < hchunks; i++)
-		munmap(hptr[i], MAP_CHUNK_SIZE);
-
-	free(hptr);
-
-	ksft_test_result_pass("Test\n");
-	ksft_finished();
-}
-- 
2.52.0


