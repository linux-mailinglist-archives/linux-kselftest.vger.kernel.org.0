Return-Path: <linux-kselftest+bounces-33114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54AAB8F4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182B41BC0348
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24428540F;
	Thu, 15 May 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IR6fHYan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bEJyOlBZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43120A5F1;
	Thu, 15 May 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334995; cv=fail; b=XUotzANkpqDvMS2SrOgBYQ8UKAO4wkXo4BmabHa4ZWQciQl7pGtPTe8UJfj8xSLhKgogN+hCVD+ikcSMVnfQv0OIF13JoPp4YWnpTa5WfOu5x4uHQsgH28etvz4VO9w5Fd+0GhEotjuXtfg9Z5Jjrg7v0ESGcm7YBSd8mbDbf1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334995; c=relaxed/simple;
	bh=zEo0k23TVADYCB6D05Sc/c79p0MPeIo3LGcoB7as94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzne8+heVUKapKghneF5et6yox+E+MkaDkM3CdJJmfxCBS6URn4KLUXGu5UAZc8yt6E4XBWr6PeBl40ML+t9ur0u3cUCLPb5ak8FoS1BnL2Hmgdcmbf4/xefxOjmaJa0v7XsARFEqUTWnFSm7eBrAVm6jhHVAnNgfFYJ4DjiiSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IR6fHYan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bEJyOlBZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1nYl007267;
	Thu, 15 May 2025 18:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eXZDyleH4BIon9kTW7
	use2aPSwHTFD3jLt6xVmMrmOI=; b=IR6fHYan902KH9vZhZPUuLIFez/2HtJuXm
	PLS0y3tshbAZsvhIOdT+Zi50qr56x+gKWwUW+qc4JmiuqUFkG2aOMivTOaPDQVOz
	8Ysel2uX4H5XG8ArK4ylzkeF/nIeN7xH3I5nBuKB7zOlmoudhRdtGlqU+YPMJRwg
	lxrATpOz5RyEfCVe3UBSFQZQI4idRrDgbpI0C3Rl9EJ1lNNzFAh3Le4EXT9VKfkb
	7GNT42jCnrVLxmjI3VyjjBDBDggDURpGlM696afSMN74nwufKKJTeI5Em/m01jcT
	4V3F1XSTNWBO6xYIPbBoahx51Wbo0dnMY3lWNW1jU4WUHSJvvEhQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7bus96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:49:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FHJV1F026220;
	Thu, 15 May 2025 18:49:42 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt9qtgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoH0v9BD5OkNNoYm5jxW6pRXVHWzmzabEfdoWU17FtQ8F31a6WLCm8/2t3eLq2w/rUh4Uaxgq3X5V6L77QMZoaJPP8v905y6EBGEjoZOC3Pl/ZnMiZXUT6hbH8wJIg/2YWht0SrVubBy8nVcRc9hfvvYDp2cJfW0PTBl32Jl2ewcgHamakextq4aWEF2jZ+gTIBeeATumAcMxhgzpHEBpPtwgZFlR4Mh7Js/vnPK55UWXpYD3kr/nhOFgdtAfLWe9B1vDhq+zW9+duNDtzgnyqth7QEYB4tiWRyDzpPm/eF+rsa4LNi/btJ/McVLHAVBvLlEAXwIIqnHheh12vDD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXZDyleH4BIon9kTW7use2aPSwHTFD3jLt6xVmMrmOI=;
 b=cNFnPNg7Gyh06GT8/jlzpgbUZqxYgqcRwB66o1x7AgTfD6F0dgIEjR43WHtMXAlVqELPVSisJoOQFO3IxxyiOxeEg+cJQE/N5gbkMGJBdFelIzfn3JrlmpgYH3HMvM+pF4tLlNxILazmTsu3XTWDKo92bZk8qNs2W/5tNxKTakL0gczZIfRypdDxRB0m+qDSsXLRfh/mzsjl+c9Ci9AA8k8RK2IoS3AlA9SIBbpUzz2LeWrK7C2BRxxOMgJ/UUyYumC2IyOtJ0/+rz0k2EwfCK7HYhPpQIS0lU2il0DFZZ5Xi6wuxue0odh+3FQDiqx1CuSfO+9icKt4VAshz5rKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXZDyleH4BIon9kTW7use2aPSwHTFD3jLt6xVmMrmOI=;
 b=bEJyOlBZq+xBA+2D6LtSZhKCiOeW3eiVPLPhGskQPHSKYTCE8Il/GkzqgFO9wBRLQwgJR3+LGcoKVJjMCly5esq+Hu9Ir1IEFGSvyYAU47LeGLFU8NwD9Q2xbHBA/W5p318es+C3ZF1zbxi2XtN5fjwbSKAj0pdFwLVxrsN7PF8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 18:49:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 18:49:35 +0000
Date: Thu, 15 May 2025 19:49:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Adam Sindelar <adam@wowsignal.io>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd
 is not present.
Message-ID: <21c39cf1-6c8f-44a3-8bea-b0c8e6eac2c1@lucifer.local>
References: <20250515182333.346587-1-ziy@nvidia.com>
 <ec648245-c771-4e4a-b355-a86c99ad8143@lucifer.local>
 <6601AD88-C2B7-47DA-B75C-46AFEE1BD2AC@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6601AD88-C2B7-47DA-B75C-46AFEE1BD2AC@nvidia.com>
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8209ef-2ec1-4a42-0f78-08dd93e13cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+mnVg9WXfL9Y+uabATLk7jw7dG/yGuNoZ59Mt9vrmfaq532duIFmm45aFuL2?=
 =?us-ascii?Q?Lgvwb8GwyEkrwswwuOAtRYDxKCKGZX7r4iQ8GO3vAerqKjzqWyUGuvLe8Dq1?=
 =?us-ascii?Q?qYKbV2TRVATUeOB5w2lQohUKThKURmmEmy2Bcdn8emn6dIQHQ5mZ3Yvqb0j6?=
 =?us-ascii?Q?9VLJ0FiSfSLoGcNZKPntKQeXh2aA/1rVsRYWn68KYwSu8Q8c+qvC/afIqkXX?=
 =?us-ascii?Q?Fw8Zwa2RS4rMr6GZnQbeMKrKZewwjqjIP6hjGs8InImW8QodyzfHKDdo6sYX?=
 =?us-ascii?Q?8Tmf0EqDFmCPKihOFbR1cDeQ/I3IfqD6daRAdz/w5bxtRUc5qPdktDDo1rfK?=
 =?us-ascii?Q?ug2c+XQ7SUyjUp4Bw3ytdJSz84WurQY5jIvHCGU9JyzZCMukdzwAl0X4Z1LM?=
 =?us-ascii?Q?QoW/S5HBxgErvLhRoJBsRzNpghP57DqmdKFIvO2MSjSQV02AgURLqzUVGvjt?=
 =?us-ascii?Q?ZK0l0eTspDPMNZL4XQ1uHDj1hlStZpGYmZM67sqWWYv2x6FjbNl/VvnGyDx9?=
 =?us-ascii?Q?W4EyRu25MU1pgvhKRWgWRM2JTi7NWhRmNMh6dazcuFxFw4pXbU8GjIm5I3tA?=
 =?us-ascii?Q?/NmaTVL3u8PczBnNy7qh/0OhPsPm0+6DKFYUyb9BPEPeMIdinUHmWYXaGc2v?=
 =?us-ascii?Q?I6yQyb0cx+MjmKRKU0R7sj7NHJjoJmgXHr0putUTPQlNnb3vv/raQOGJ7AYn?=
 =?us-ascii?Q?nB99/vOc/HNY9BwTtY/zCtcoT7/gIUiRZYxzSl9ZJChZOm9M0jFJGDnaW1E7?=
 =?us-ascii?Q?HEQLTlnQX4QXXM9iOHZCy1r6lB3QQjhBWK61YbiyUmF3fCbAbUOCXcG4JgPw?=
 =?us-ascii?Q?kMe+Wbx+rigUWWEIBEoro6suKbbalmlBbF2VPRaVGtlCmoPX8nl0cRS7jpTz?=
 =?us-ascii?Q?hHsOJFg3skuVgAy4GT9MRGU8TqMW+zUKXu/J4LSYcD2AXuZkkG+dSszf6W+G?=
 =?us-ascii?Q?Vfkh/hm8Ww/QnBq7XnmlYMgxN1sS/joD1FM2+Psj5KngjlmmE4sxzVZRK3sr?=
 =?us-ascii?Q?9T0UQymaqk+a1sy14HVz9lL2AJsMKCsuidk0rfiDU4aert8RFRo1ukZ2T3Cp?=
 =?us-ascii?Q?Z2ykCL01ZhqfDINiCPojBl64deV8hz7hHA+IMCSJs64GU4ohB4IXg/QAgcJB?=
 =?us-ascii?Q?HEpPpw77ZgqGsab3MrQ0d6VuoRVikMrPkXgV/8QEhnm49eNy/E0fLxkwhrge?=
 =?us-ascii?Q?PeLIrJlkMa6WY1QKZZIy/SvwafJrMunYkAHugIxhzO+NFjXQzi3HVyIK33sr?=
 =?us-ascii?Q?lGYF2GiQ+lcgbFPsxZMLfv8GUk+iqMawrbYR6O6SW2voBh+8rtY/eBNPvyo9?=
 =?us-ascii?Q?ABUTGnXBuSgQPo9MPlifQ4oSBJMScnjcX4IpoUi0VKVv4fnjYWXI4IV8pL5i?=
 =?us-ascii?Q?bxwb4Hy6FBIWz6z9AZIIKvxpzZn418osTPeWy27k3TDLsPOwS3q0IsufJIOh?=
 =?us-ascii?Q?+oTd8PQi2nQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgGank7+lZU9GLKd1T7VKyZ7aOgahDuqCnTlfdFdc6wXwLa7EBdHsw/Qmrv+?=
 =?us-ascii?Q?4aQmKFe8+gXW/TiDELeLoSUxJZp11iDA/11pT1f+F3uTLCmHolg+MEH1lkqh?=
 =?us-ascii?Q?q4+IclCUymCykFjQJdWBU/qVEAyuVK6cXQNY20ssT5PQI+OrDUAzpKyNqC1x?=
 =?us-ascii?Q?GPfOk3MgvO+7OcnZoAg2mbjrwpiNzlyo6M+3Mszau1sO69V5JWNhL2bdDkd5?=
 =?us-ascii?Q?2r4jv/4s5QX4UngVya1jgvss5xHLbUb7p9DU0qh0yb6+iShs+gvNtriAvc6x?=
 =?us-ascii?Q?fCa7h/diYFUwHjw/Mh9VgkOVPtnlh2sB9IIYvWIg92DvLwNDMwahUy/h09zF?=
 =?us-ascii?Q?L+OMATtoVH3RqOodPbU79ThOXtE0dhX1iKRWt9YLwYF7q8BkNqSQL8rHg3xY?=
 =?us-ascii?Q?SsFCvOzeQsWlrzRP6Nl5zIZQEowR3inkvMppqEHALf+u2/0h3DdOeukpx4ye?=
 =?us-ascii?Q?nMFwbMzc70+rvaccQJTQYKqVFdBJG99nVC33LdoaY/FizNw6TcsnNVheuGii?=
 =?us-ascii?Q?EmSalZ93lOUceYuaw1nyKwfgNG+Zry23WyouqfszbquWUzetVq0ZoaLYm140?=
 =?us-ascii?Q?mxfdLTSvjyOV8lKye5ecC8cSHRrbc/4CVU6Z8b8jB7SGNKXDumT8l7kja19V?=
 =?us-ascii?Q?BV1gQCF8rQgqoEiBPhIrM9iByrfFM+pdj5hD4usOIXOxwAPVfrqGIEBJGz5/?=
 =?us-ascii?Q?iEOp2gb+rTo2MWBlMkT6Wfnp1iquCZQM2gBmieKpRaH3zzaEHOR89I3XvC6g?=
 =?us-ascii?Q?dSRkORFPYro3zr1H6ZgmzzzGVaG9Ohxr+O+RE1ciodyWAJMrf22l4Iaz5CaR?=
 =?us-ascii?Q?TIyZI3igR4vKhNoEQC7kFQssxYwrs5U+LTABTslZypPN1AncFfpwKnHd3QIp?=
 =?us-ascii?Q?4bh/rb9tsriOU5pXLH+Zwua8hQazBUba2KhiNlMjogg4VHS6S0pVwblajbEF?=
 =?us-ascii?Q?9pNDcyiLMXjWoX6K4lMAjH6xyAjlQDXBxWzKGgY163caD5VOMMmePn8i8G47?=
 =?us-ascii?Q?R26m2NqeeY0cadv6HomHmNtMYKvWZfV/g09FRKu3xN0fQO0c165D01rDVTEH?=
 =?us-ascii?Q?NdL8ddF5OgUxYsKgslgsK2BJkZHe2LN1AJGddO76nTkiSbvC3pywswLDB6y9?=
 =?us-ascii?Q?D5LKLYKVlgl2RojMhL80xuo0/UfEa91z8T3QagR/4KiY7sdJmTjcExS29O3C?=
 =?us-ascii?Q?30v6XIrDjoeyN5xX56kTQ43FSTaTVEVqKWwkbElYkVIT8cT79TQ8qu1VFnUp?=
 =?us-ascii?Q?4SeMCKGzZbPy+9Ll0RxCHwXwUIxEPonF+JfnDGZ2KqHHFtF9MjwbHEDQVGeH?=
 =?us-ascii?Q?TkRe8nEbLhugth0n5Rd5fSlainmwNm1MJPQ3wQOd3SvFXjDIHFmVgIuEJm+9?=
 =?us-ascii?Q?VConYJpISjCqIDcj+XReLrQoXYcVkkDzKHncQsRssrpp8T2UGAy2SMq4lX/D?=
 =?us-ascii?Q?qWaRR/BDdd9cvTycAt09LUFjs4SZRwZGalHjhXTFN54FhbDqMMmZ0naJa53m?=
 =?us-ascii?Q?IvjtQySV7MOTEAHKj8xEI3hjw/HXNjxNw1H3Um1C9QiVD2olWndzHcCkY1D0?=
 =?us-ascii?Q?NLY/TkAhB2zQ3fSlk/bXXHk/NmB9t2LTTNViKZF+ifvChTxkFLuAIDL4zks9?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XoPKKlo1it9Fp2K3/DQ/qYcsFwnNuejhCGwvTTsYhoZ6pZUUsYAYJAv5CmPS+7CWLLxH7BJIh3m9YUVn2WgoyzD80MVLRLMjeLaMD2K3RzRgts8fNqJMQOyT+TQ18IcWUH7fqCr1dZzVTmWxFyGTqNqXtKPGRKnKOL0ngwSMjF/KoMZEQrWXYktkb99r1QhNgIdk4u7YqEZZjms7Gqb6AeiPI09Qf66FFyPw3x20sbqx0zAuNbcfDex9M7FKyqm8fOKVL63z7SREqmmKLjtcNIlMNZ5e2qr4nDFd3kMXQiWliw7x7zKMNy4Rcb2hGUVSRm2v9C+z+bP0tQFiGtDobri6Xdo1xEaY2NBdJa5Pr/0FbzV/rlKilo+mkZB4yshJYnscejsqW1QWHVTC5I601nz/tLEdZM0WSH4q5V1qdYO3jskRQDzQzAichK9SnmBVRzE4DMxWz5p/le0nVMuRkstNZNtDCdHqZPJewiHjgqNSeX4ytFdyNokoq07B02tjw4L4dARTj8gKoaEwExCm0F5GGR3boCLvxPnW4KB13Q/YYVFlaIiFM1exWxAMrGc8G7vD2Rp3/Jp8rNkk6LOE2EAg5C2pRAZ/VABD6RL6J3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8209ef-2ec1-4a42-0f78-08dd93e13cff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:49:35.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk+bZW+doEur3CtPi7GEEzdPcZeOg9sUpYy2m3lAuyDPNUdN2VU5JsFEWF/mg2yt1dROYvxFqJWXE8vk3DW/PZ4kL8a56IIST7Z88+Dsshc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4NiBTYWx0ZWRfX6+cDuSxJqV5b giCPT49VNH0C4TZ1Mmi6YdTgQUHHJKAX7GBqN1rYDZcQ7DnQ1IrnsSUAZC6y93OtwurT67/S5iS xyWO5+1FJGqSRzP8+EaZJ1Sv8P/6+FLTuXYalRrFsa1xw6FtTvtfDP8ORHPGDNhbOO4DVmX4eVM
 pbbYAWgxlH0UY6drQ76szvy9X9NJGjUUHe4UfyPmqLT2mcD5XTS91YT52hrqaJ+RGMkZgHlCA7W suIzFim4SQE/yj4QEimSJ6dPPdU7Mm9CntneV3gg44AaEKjf7jjtTYEAhZqil5HPWzbFFasAol2 KKEhWXI/uEye8BznwJ67M2Y//cheWfSyvRARQWiWIe6L47Qhe0SiRkKBQfRJvoCUfagKpo0MJ2V
 jHSu8Smy4wlc7B9UYG336vqEOcK+BLcUqYOzY9YGVq2/jdldTevVwUgK9Dzd5g404ktgz5bx
X-Proofpoint-ORIG-GUID: lCN7VChqtmURScUnzPBpqDTyZW6l-KA3
X-Proofpoint-GUID: lCN7VChqtmURScUnzPBpqDTyZW6l-KA3
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=68263747 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=R3cn7-wTmvi5nefEhVIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694

On Thu, May 15, 2025 at 02:46:41PM -0400, Zi Yan wrote:
> On 15 May 2025, at 14:41, Lorenzo Stoakes wrote:
>
> > Ah you got to this first :) thanks!
> >
> > Could you do this with a cover letter though? It's really weird to have 2/2
> > reply to 1/2, I know sometimes people do that, but it's just odd, and it'd be
> > good to have an overview, thanks!
> >
> > On Thu, May 15, 2025 at 02:23:32PM -0400, Zi Yan wrote:
> >> When userfaultfd is not compiled into kernel, userfaultfd() returns -1,
> >> causing uffd tests in madv_guard fail. Skip the tests instead.
> >
> > 'madv_guard'? I'd just say the guard_regions.uffd test to fail.
>
> Sure. Will change it.
> >
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>

Given I was being an idiot below, now the patch is fine as-is, just resend
with the nitty commit message change and cover letter as a v2 and we should
be good :)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> >> ---
> >>  tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
> >>  1 file changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> >> index 0cd9d236649d..93af3d3760f9 100644
> >> --- a/tools/testing/selftests/mm/guard-regions.c
> >> +++ b/tools/testing/selftests/mm/guard-regions.c
> >> @@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
> >>
> >>  	/* Set up uffd. */
> >>  	uffd = userfaultfd(0);
> >> -	if (uffd == -1 && errno == EPERM)
> >> -		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
> >
> > Let's just make this all part of the same switch please!
>
> What do you mean? EPERM is handled in the switch-case below.

Oh man, I'm the biggest idiot on Earth haha!

For some reason I read these '-'s as '+'s :))))

Yes please ignore the above, I therefore - like your approach - and am good
with it.

>
> >
> > And while I originally used ksft_exit_skip(), I think we can just use the
> > SKIP(return, ...) form here just fine to keep it consistent.
>
> Right. I am using SKIP below, since when I ran it, ksft_exit_skip()
> makes the whole test message inconsistent.

Yes, your confusion is warranted, I apparently can't read... :>) and
indeed, agreed.

Thanks for doing this!

>
> >
> >> +	if (uffd == -1) {
> >> +		switch (errno) {
> >> +		case EPERM:
> >> +			SKIP(return, "No userfaultfd permissions, try running as root.");
> >> +			break;
> >> +		case ENOSYS:
> >> +			SKIP(return, "userfaultfd is not supported/not enabled.");
> >> +			break;
> >> +		default:
> >> +			ksft_exit_fail_msg("userfaultfd failed with %s\n",
> >> +					   strerror(errno));
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >>  	ASSERT_NE(uffd, -1);
> >>
> >>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> >> --
> >> 2.47.2
> >>
> >
> > Thanks!
>
>
> --
> Best Regards,
> Yan, Zi

