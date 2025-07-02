Return-Path: <linux-kselftest+bounces-36279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C37AF0E65
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F4D1C23397
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A11DD529;
	Wed,  2 Jul 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BeipKe7B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKJS9ZY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24F1E5B6D;
	Wed,  2 Jul 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446067; cv=fail; b=bdGGrfnbMFP15p39lbeqjik+2VNDG3hWJL2BCyEvGLj8sB4cHSuIPy17yH/pLGsKmGdJxLae5Yt9ju0xodzGJnqh0oh9pVXKf7mcPJAtDy5QrA10NNNz9RgufWO5tCIsrVeCVxgUavJ+y73YB0chofHcAeg+wvKlaFGKZKtbjAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446067; c=relaxed/simple;
	bh=oNtlwzIq8G8buoKMSm0iwR54K1VkdmNQRGTwlzzAcGg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QQ4v9KGxwJGEvNMHuBT2GcH7YJ81rGQJUKw+hOrQZbR4bC0Mn2h1w8rHeTQy1RURKv+vruXCj5S8n0smJ536cCYpiYGCVqgbIcst4NG2wiYSQQnV+GpK1VKPD0JZwBOzuuJQ0H2Olfujd+n3JLhHqKpuDsqYFGE/GC9fvqMc+Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BeipKe7B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKJS9ZY3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627Mi0j025725;
	Wed, 2 Jul 2025 08:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=aoZV/LxI9pWJgUsJ
	WWor4nvfB2jmHITo7wLp0iWIzhc=; b=BeipKe7BrDx8TerdXhriIW3JS1Hi/BOq
	JDm/kGbhyZSY+Fo1txGeTX1wE0pfPMx0R5Ce2Zqr1cQEJOVvZiMjUdCNQ2cljpcT
	WLxT7saOhPBx4GDNFgVxKaya4W9gcSeuVxGfa9bJtfnXUeaAbt4MzfAt1cgaDkgQ
	+s/Hps+JSpmqp3IVI98uVs8FGj7j1pFYONmdswqD1xWUEivQvBqCGKiEn/nZt+Xr
	ehvaxLZeTKTrDWgUlbEKVBEgO3VpkjSxMypkECwK/cz6PfVAhwEHw0BJ9Kdn0b3F
	rwjkpmBhUIjo+x36vWK7XDm2mmzjpevLIYNKR7hf6wtnSCp6/ApTTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766egbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 08:47:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5628DAYp024947;
	Wed, 2 Jul 2025 08:47:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uj6a4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 08:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBYkWnmgWXn9GMDk4XtQm2gb+taUrDUkRoDVR12cour4aJG8MmCvbNxQvJJYzbZ42FmUMAkHpZEOg7me0J3d+RejRQwPECwgekcrXOfHLM0wH+VFyMZZ7gk2NdSIDfj4nBA8WyLGw8T+ni2fLYBXxz+npbfYZd1BWl5XcFKHzMR47qGoe4/l7J4KHb+NcK1l4cTMTE6+DGHfPMa1bO8ka7ljOhvOQTKjN4GpuQQ2dmpA27iiTVD7gIh3IGdCzcpaEpf2q4TY9b4DAJ5id9l6MQAD4heJSN0RWG0knCADR6GoE+zGh8Ec2egr0vKQuAsBoo7WGo58Jw1lqaCx7K5+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoZV/LxI9pWJgUsJWWor4nvfB2jmHITo7wLp0iWIzhc=;
 b=i6foU2/koyVeG+cviSo1CrJeE2isMuXFwuLtdc5xL9zGK0x8lD5Z92tof1z476LsuiRBj0ZZg1egOBHPhWWCb2i8KKPpR91NVTgweWkzkJQpJA+H7tDwPyEOuF+Fvc5hdT79xzi/NETYH63A5lJZafuEa9i4Eirrap8Bye4FvJUVHJG7gqAQu91M00vvJsxDhNQY8US0rbfHz5znGtZxfhWbm0KQUd0f04kjHT8+ukfoDK6blQMinmOauvMS3N1p2JfAPude5cECuVtGqkQf513W4IZViZDZrqAgZVru2G5XlnU/RZM8/unkvG/5lHOdSadwCy9LruuJ3Rvy/jqOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoZV/LxI9pWJgUsJWWor4nvfB2jmHITo7wLp0iWIzhc=;
 b=zKJS9ZY31h7L9iF7i25bETBlZHhbu0Zeyr/KSc0oFSBI3q7VN3BioPZcOOyaF/3wlt7Z2XBmGuLjZLlvtJW8mnL97CV05gk/nhdf4CJWZgCclfysPW3PCd/+ARIR2g61SwtCuxoEQsdRAcH1L5+muDR17DS2Pahmeee7kfqxMPA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFBE86117B9.namprd10.prod.outlook.com (2603:10b6:518:1::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 2 Jul
 2025 08:47:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 08:47:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/selftests: add mremap() unfaulted/faulted test cases
Date: Wed,  2 Jul 2025 09:47:17 +0100
Message-ID: <20250702084717.21360-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFBE86117B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 367763c0-5c41-4c82-48dd-08ddb94514da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QEx0LacgJ6jbKAXv20mimBEO2bibBoBMeeoVMgDX0GWp/oGeOGd+86viGxg1?=
 =?us-ascii?Q?bLDmKxfzMqitvGuNxpnaeJ2y2uCIUDqzpFtIC3DqIpz2RPwaVXun9ojiIJea?=
 =?us-ascii?Q?/FylXFUIRD+f/wIH80KHPPDzlcFWZKWZc9OfckwkxEm1CsOeMRGL4yoDv4Qz?=
 =?us-ascii?Q?Lq9aU+yWhfsf8XLZJThjSx23MedO6DXHMrLJXproovCbN9/DWr7/eccGXzHR?=
 =?us-ascii?Q?z7aC2OE9bKBxXaGWkXJYhzVxkZK2Ivnk/kMsrdYmXzS0e6chOQVSgb8ZtMM0?=
 =?us-ascii?Q?pfDCJ12HrPqZZjd71qzU7fBcxmmyM2C9Y2FYOEG0MCWJI1vOTX2y5WJngvKW?=
 =?us-ascii?Q?s0cBC6pVNJTwKgf2hhXuaaeJTgT6HnVwZOg8ZmRvZJ6oTfwatxu+yRygFVrm?=
 =?us-ascii?Q?tXhBjSMdB3+cFwRLmehMYxDQCZvCPUV16Ds44oq7ZBTFm7aJUJBavB2BGq7c?=
 =?us-ascii?Q?XMVQk8y/22exw7fPLHM5w2BM+Ad5xC76K3DOLD/WO9FY1Oo39T5OteaHC5BM?=
 =?us-ascii?Q?x8/wSk0m4LCLjlvHTisoWLtq4mCatwbSfgfa73Ah5uKN2ud+RebEUPq3T+5A?=
 =?us-ascii?Q?NpqZC++iIzbIn23+X9t6L6OcyFzUvwuo7hcexnHKLzxuK9JVDj/qpI7K9Y+/?=
 =?us-ascii?Q?ARvkmAgEzHbagv1Ozr6h0gSNC5nP1aO8FLN1f4NAhti/QAggs0D0icBEBlBW?=
 =?us-ascii?Q?B8Daaz+m3m+MXvBsVpnsVXdUfuyon7KOHO4DyJGcUnpKQQgUt18v53t5JFom?=
 =?us-ascii?Q?yChpzX1mW0N7vo4xblt/QCllpwTYQzNgs7MZN7F1qnqpZTmWilmCxM7ftC7l?=
 =?us-ascii?Q?S4Lpx/xL2eB0Q1H/fSN1TecvLScXuKuBfGpzcszaP2chBHPkDsFIuV8+xKOL?=
 =?us-ascii?Q?V4AsqVd8xNVv/0Ve4sbEL9aWsrgNhnuk2vo4t8vjlN+PfS19Ui7gb2v7DLDH?=
 =?us-ascii?Q?ZarVO03nMZCj3ew2ccnUd2CdoJtQx0fYW51dUOvh+kt4SLtU5P7bKwFkLQM2?=
 =?us-ascii?Q?8u2V+CnHJIcSRp6TOJmwBcQ/yd+xzFWaYXAI3g7HD1W6gwYNi7ippRXCnlzh?=
 =?us-ascii?Q?sdyxa/Mj3qCf1ItfE7YPqjxnIwIvBM3zsgRx6ab0ENuIKtEiOfuvqgOcakIh?=
 =?us-ascii?Q?Qc+MzCDL/d/QtP63wky6GasFSq/P63kAehBoZzlRWZyXZPi+Yv4wQ2YBiduJ?=
 =?us-ascii?Q?y6TTQ8JV1uM99udIKQTMA2soP3H+BBWp217pSDU2ABZG+is6oa0eAdBHLIhk?=
 =?us-ascii?Q?/GIn6LyzTUzG2HEQFvbM3TbuuwlNDnDEZ24vQhfTazvwOXFL4c99kb0r8M0C?=
 =?us-ascii?Q?VZ/mG797Pyae7Zj/MQNb3dQMnHGsmMY9bq3XSQM2Oa6U9d6MueVY+RYzHLCl?=
 =?us-ascii?Q?CX4pZW+twLz6j0H2wmFs0IVlritXSKeYAMlKy8C+znA9M876JZMdxa0p7kne?=
 =?us-ascii?Q?Hlgul+/0PhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?THZYCQ8iIasgh7FELsnHGnHOA0vm92xhaOtT10zbXMoOpSGFpHPimCtAf9Gc?=
 =?us-ascii?Q?OpWhCv7o51GDaVFeekPd8h3W9G6mqbx1arqEdYyNL0tev6eRsefPL7JeiqsK?=
 =?us-ascii?Q?+2ksfRFrxSNi6yFOB1xfchQdV/bFfo+8zDb9qZ+XEu0uDvL2mRssT3e5vz3x?=
 =?us-ascii?Q?LOgN0DfSvoq6LrBPjdyBFPsdvA6B9wcpIGN+rXA0eVG9bDWPlVfAxvRzmKag?=
 =?us-ascii?Q?4R9OGU9SwbiQ55YO2OQtxH+aFk63nIqR7P+1khUode7WT2rEoP4zsudr8DeO?=
 =?us-ascii?Q?t3s6e0rkUiB9MUWF9W3aebf+cF2ZzLt2NCG7zoCssoQaBmgXDQIiH8fP8nf6?=
 =?us-ascii?Q?OwYK+R8uK/GwFD/54m7X+cO/J5z81UwZ6tbnxZKcWjA0miPLbAB04CYG0rua?=
 =?us-ascii?Q?0xJMM9rwCIIG+Ejp7OnXhc+Zw50yL7LeBJ2vvIgRN/VXzC0+rFQeg1UmedUH?=
 =?us-ascii?Q?P7l1mgBSOMq85JE1uJIn4aVg4jBIQpzfCMWFAyy99KNbT1WNjyx8RSgesdgr?=
 =?us-ascii?Q?2YAr3Tk5RiDS2zLmMuNylUOgu/Ttg7DVrci/rgdb853eUDgB+VuQR0JItYu9?=
 =?us-ascii?Q?lcJ9nxt8qpIovfYJb+9cYTsdlL1CP12Mv0VzRS8mfhb8LLp9+cC9cpMa2dK9?=
 =?us-ascii?Q?OSm2bMgPlM/UbUcmhIQN2wymOzM8BRBYon6IjcrXLotu0eKTW/cIuivTW3rI?=
 =?us-ascii?Q?2vOMWskyLQZuQnSgXmjDV5IalDFFF9sQFpOF8dk1pPtNWs7kh0N9UrovbaAn?=
 =?us-ascii?Q?XY3c8JEbB9/wwGl00pDrVFSiIRHo1ffppTDdEDYshZbFjEreIjOIIFQlHcox?=
 =?us-ascii?Q?C7M9pDKd90qW3MDcWpzCSu6o4OnDiBE93OR8PAERhWsK0aApqsw6mIRZC3fS?=
 =?us-ascii?Q?U0scd0nyZZjljNqMDchqfxSWR5//EH4+5oLc0ZzEciodXjthz9zVf2T6Qx26?=
 =?us-ascii?Q?Wsl9e8Z3M7jK+r/r0T7GytQGiz+3OUhR777GnWha89A2McWkgREQf8pIHF/j?=
 =?us-ascii?Q?jp6z38IrHFaqeKmHb45rjbFpcYt4no1lYHYa1Mh106gfTOHQdh/6Vs5ZPYDY?=
 =?us-ascii?Q?3MVewuPFokq2Eb4L21LLRuXFeUi5dVc/2k+64fymGu03o0vNIs2g0AbMLGt4?=
 =?us-ascii?Q?FNaXOM7LjPJEkJW9FjyXTSTfliJjL/lT95ZrtLD5yYD9ceSsqNe37iNbZ64B?=
 =?us-ascii?Q?kZhOzOvR93YKJE29iCUBaJoG8JpL/3Zs6VpjbSFU2S/SsB3UPOgSnticDzXk?=
 =?us-ascii?Q?Sv+Cg8DFM1bYRDuNv8z+PFRuQl/MRfOkeXYchK3k6LStSpP8yhsyffdBlQP5?=
 =?us-ascii?Q?WFSC9tZlygwpWtxMhTTt5e9odKI+1Ymzh1kPkxPEoWtWmJjia/GrcuBcXCkY?=
 =?us-ascii?Q?p/P7zxPUF2QYFVvhJ3ZBOEIIbfXl9/F66tDsW7td52xXaQs1WuELDCusk4n9?=
 =?us-ascii?Q?p+MKWDhzpUhIKc5TX2mII//QIJW9G6pG6G4cGM1JLCnhxeoGg/ao+uRtPO9a?=
 =?us-ascii?Q?z2izqHqG5Z4FzV5d5GjWncn40egg2+uHgzEvSFl+GNpKDMcOoVGXtyM5UNeX?=
 =?us-ascii?Q?HkAWfPBawRLKKItJ74A/ft8aWCI3Yu65ehQawz2ZMkoE06SM3N469D/47yxL?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0YDpmlx9FyzFhVadKfVg6DbYPgRYmGA7uIiJ+zZCedB+QBUio1M1NtWJInAFDSTO4YP/l52pqQxiNkOcrlYD7ZQy6Aplpx2piaizCCefv2ggEwOmBLk5/2sVUppxWTSDCjP5uHC/xZB3T2YPhS4eHbrMmhiqZSXK7/yCBxFcrEFsQyza2efoXTBcysuJA4ZGh2tu3AYhie7Um/85Oj2fjGqGhCW3dWUmx+z3zSivuIXjKk0kicuGGa6Hwy5Qc5cfXGGutU/4wpkx7PrBA46npqZ4QhHbBp5rmZHzR22Wu6AIEIEKA3XfOjr2LnZu+j5wcv/r5jjnvBqYClto7EGCV/voECl279BhKm9VkGO/En/SRY4/7ZePzlJaUXP4Yz33fLQ9yTzuaWHUuxZjLHil8MJ76JruKDeemKh05bmVqQhkuDsMHGzkOGbZmuFqRWp+Oseo4/4JgyFKxrQWQDkKTB+jmQ6eLMswOMJ8LjXM7p6sB+etIhT2KHA6DVWWCbnn+Kc3Ff7266wmMayDAOzX+aW1zYuQZKoncBYvPWOwL5ExUoBcoqD6Svhztvr4OgybDhkTjl2HcaefpYgaBnUJZlFJbYFUR83SNt5Ll36CiRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367763c0-5c41-4c82-48dd-08ddb94514da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 08:47:31.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMCZrXkbT8CKdWdphSWqX3Y9//YqXsPxlu1VzkBM6uig5FC4E3JSbI5uuHVYsF5iUy3k3O5IgvjIdvSHZMBzKwWrvBq5XhTBzOiXGycJZLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBE86117B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020069
X-Proofpoint-GUID: BJHUMYoxRGs4s3pJ2C8au-_jNHM-Rg2F
X-Proofpoint-ORIG-GUID: BJHUMYoxRGs4s3pJ2C8au-_jNHM-Rg2F
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6864f227 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=17aRRUwdhcp-6bMbmpIA:9 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MCBTYWx0ZWRfX2ZIUCN/SYLKB JqTv/+p6QU/ArRIfyvsovAhtbr1acZ19+wPBRUHWmV1TtkjgaqDfLC91gd/OI+4BAR7JzFceLd3 uldEWAOpBOltkuYvpbIShFjyvIo/LAsOferJz0jJxRnDdnqFJwYla+ctFbHFfZ/MXx5J9pTpssg
 V7O9H8tW4pRoj5cyP4Asos0+KViVp4oDtgZNqcn/ma7YBX1uHUTZyTpgtS01vR8o8VOYKRKRIFw dCT/nwGTM0F1Q+Nsv+g5YivDEhjJaC9Xh2r4Zpr897DchipxkG24gskV8Bk80LsAj49abPk6YqE HG5iJlINm4wCv80nOJvOvM7mFa0zuoFu1NaP3PGlRcZry9gBSlez80Nnu+STGMPf6alzmitAcCc
 aZlSw4kz658TpHC4brUj9D3v5eCFmDy3jYHi5Z9I4a77k5FyX3qhJv3qu/mLiR9CTsZQT4RX

Assert that mremap() behaviour is as expected when moving around unfaulted
VMAs immediately adjacent to faulted ones, as well as moving around faulted
VMAs and placing them back immediately adjacent to the VMA from which they
were moved.

This also introduces a shared helper for the syscall version of mremap() so
we don't encounter any issues with libc filtering parameters.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/merge.c   | 599 ++++++++++++++++++++++++++-
 tools/testing/selftests/mm/vm_util.c |   8 +
 tools/testing/selftests/mm/vm_util.h |   3 +
 3 files changed, 608 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index 150dd5baed2b..cc4253f47f10 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -13,6 +13,7 @@
 #include <sys/wait.h>
 #include <linux/perf_event.h>
 #include "vm_util.h"
+#include <linux/mman.h>
 
 FIXTURE(merge)
 {
@@ -25,7 +26,7 @@ FIXTURE_SETUP(merge)
 {
 	self->page_size = psize();
 	/* Carve out PROT_NONE region to map over. */
-	self->carveout = mmap(NULL, 12 * self->page_size, PROT_NONE,
+	self->carveout = mmap(NULL, 30 * self->page_size, PROT_NONE,
 			      MAP_ANON | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(self->carveout, MAP_FAILED);
 	/* Setup PROCMAP_QUERY interface. */
@@ -34,7 +35,7 @@ FIXTURE_SETUP(merge)
 
 FIXTURE_TEARDOWN(merge)
 {
-	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
+	ASSERT_EQ(munmap(self->carveout, 30 * self->page_size), 0);
 	ASSERT_EQ(close_procmap(&self->procmap), 0);
 	/*
 	 * Clear unconditionally, as some tests set this. It is no issue if this
@@ -576,4 +577,598 @@ TEST_F(merge, ksm_merge)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
 }
 
+TEST_F(merge, mremap_unfaulted_to_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Now move ptr2 adjacent to ptr:
+	 *
+	 * |-----------|-----------|
+	 * |  faulted  | unfaulted |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |----------------------|
+	 * |       faulted        |
+	 * |----------------------|
+	 *            ptr
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_behind_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map two distinct areas:
+	 *
+	 * |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|
+	 *      ptr            ptr2
+	 */
+	ptr = mmap(&carveout[6 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \
+	 * |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |
+	 * |-----------|  /  |-----------|
+	 *      ptr       \       ptr2
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Now move ptr2 adjacent, but behind, ptr:
+	 *
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 *
+	 * It should merge:
+	 *
+	 * |----------------------|
+	 * |       faulted        |
+	 * |----------------------|
+	 *            ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr3 further away. */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr, ptr3:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |  \  |  faulted  |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr[0] = 'x';
+	ptr3[0] = 'x';
+
+	/*
+	 * Move ptr3 back into place, leaving a place for ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge, but only ptr, ptr2:
+	 *
+	 * |-----------------------|-----------|
+	 * |        faulted        | unfaulted |
+	 * |-----------------------|-----------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr3));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr3);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr3 + 5 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_faulted_unfaulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map three distinct areas:
+	 *
+	 * |-----------|  |-----------|  |-----------|
+	 * | unfaulted |  | unfaulted |  | unfaulted |
+	 * |-----------|  |-----------|  |-----------|
+	 *      ptr            ptr2           ptr3
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[7 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ptr3 = mmap(&carveout[14 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Offset ptr3 further away. */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+
+	/* Offset ptr2 further away. */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  | unfaulted |  \  | unfaulted |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Move ptr3 back into place, leaving a place for ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           | unfaulted |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted | unfaulted |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_unfaulted_between_correctly_placed_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+
+	/*
+	 * Map one larger area:
+	 *
+	 * |-----------------------------------|
+	 * |            unfaulted              |
+	 * |-----------------------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Unmap middle:
+	 *
+	 * |-----------|           |-----------|
+	 * |  faulted  |           |  faulted  |
+	 * |-----------|           |-----------|
+	 *
+	 * Now the faulted areas are compatible with each other (anon_vma the
+	 * same, vma->vm_pgoff equal to virtual page offset).
+	 */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Map a new area, ptr2:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  | unfaulted |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                               \       ptr2
+	 */
+	ptr2 = mmap(&carveout[20 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Finally, move ptr2 into place:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  | unfaulted |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr        ptr2         ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
+TEST_F(merge, mremap_correct_placed_faulted)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2, *ptr3;
+
+	/*
+	 * Map one larger area:
+	 *
+	 * |-----------------------------------|
+	 * |            unfaulted              |
+	 * |-----------------------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in ptr:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 */
+	ptr[0] = 'x';
+
+	/*
+	 * Offset the final and middle 5 pages further away:
+	 *                \                 \
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 * |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 * |-----------|  /  |-----------|  /  |-----------|
+	 *      ptr       \       ptr2      \       ptr3
+	 */
+	ptr3 = &ptr[10 * page_size];
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 2000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	ptr2 = &ptr[5 * page_size];
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Move ptr2 into its correct place:
+	 *                            \
+	 * |-----------|-----------|  /  |-----------|
+	 * |  faulted  |  faulted  |  \  |  faulted  |
+	 * |-----------|-----------|  /  |-----------|
+	 *      ptr         ptr2      \       ptr3
+	 *
+	 * It should merge:
+	 *                            \
+	 * |-----------------------|  /  |-----------|
+	 * |        faulted        |  \  |  faulted  |
+	 * |-----------------------|  /  |-----------|
+	 *            ptr             \       ptr3
+	 */
+
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	/*
+	 * Now move ptr out of place:
+	 *                            \                 \
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *             |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *                  ptr2      \       ptr       \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr + page_size * 1000);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Now move ptr back into place:
+	 *                            \
+	 * |-----------|-----------|  /  |-----------|
+	 * |  faulted  |  faulted  |  \  |  faulted  |
+	 * |-----------|-----------|  /  |-----------|
+	 *      ptr         ptr2      \       ptr3
+	 *
+	 * It should merge:
+	 *                            \
+	 * |-----------------------|  /  |-----------|
+	 * |        faulted        |  \  |  faulted  |
+	 * |-----------------------|  /  |-----------|
+	 *            ptr             \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+
+	/*
+	 * Now move ptr out of place again:
+	 *                            \                 \
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *             |  faulted  |  \  |  faulted  |  \  |  faulted  |
+	 *             |-----------|  /  |-----------|  /  |-----------|
+	 *                  ptr2      \       ptr       \       ptr3
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr + page_size * 1000);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Now move ptr3 back into place:
+	 *                                        \
+	 *             |-----------|-----------|  /  |-----------|
+	 *             |  faulted  |  faulted  |  \  |  faulted  |
+	 *             |-----------|-----------|  /  |-----------|
+	 *                  ptr2        ptr3      \       ptr
+	 *
+	 * It should merge:
+	 *                                        \
+	 *             |-----------------------|  /  |-----------|
+	 *             |        faulted        |  \  |  faulted  |
+	 *             |-----------------------|  /  |-----------|
+	 *                        ptr2            \       ptr
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr2[5 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 10 * page_size);
+
+	/*
+	 * Now move ptr back into place:
+	 *
+	 * |-----------|-----------------------|
+	 * |  faulted  |        faulted        |
+	 * |-----------|-----------------------|
+	 *      ptr               ptr2
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr = sys_mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, &carveout[page_size]);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+
+	/*
+	 * Now move ptr2 out of the way:
+	 *                                        \
+	 * |-----------|           |-----------|  /  |-----------|
+	 * |  faulted  |           |  faulted  |  \  |  faulted  |
+	 * |-----------|           |-----------|  /  |-----------|
+	 *      ptr                     ptr3      \       ptr2
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr2 + page_size * 1000);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Now move it back:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr         ptr2        ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr2 = sys_mremap(ptr2, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[5 * page_size]);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+
+	/*
+	 * Move ptr3 out of place:
+	 *                                        \
+	 * |-----------------------|              /  |-----------|
+	 * |        faulted        |              \  |  faulted  |
+	 * |-----------------------|              /  |-----------|
+	 *            ptr                         \       ptr3
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, ptr3 + page_size * 1000);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/*
+	 * Now move it back:
+	 *
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 *      ptr         ptr2        ptr3
+	 *
+	 * It should merge:
+	 *
+	 * |-----------------------------------|
+	 * |              faulted              |
+	 * |-----------------------------------|
+	 *                  ptr
+	 */
+	ptr3 = sys_mremap(ptr3, 5 * page_size, 5 * page_size,
+			  MREMAP_MAYMOVE | MREMAP_FIXED, &ptr[10 * page_size]);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5492e3f784df..1d434772fa54 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -524,3 +524,11 @@ int read_sysfs(const char *file_path, unsigned long *val)
 
 	return 0;
 }
+
+void *sys_mremap(void *old_address, unsigned long old_size,
+		 unsigned long new_size, int flags, void *new_address)
+{
+	return (void *)syscall(__NR_mremap, (unsigned long)old_address,
+			       old_size, new_size, flags,
+			       (unsigned long)new_address);
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b8136d12a0f8..797c24215b17 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -117,6 +117,9 @@ static inline void log_test_result(int result)
 	ksft_test_result_report(result, "%s\n", test_name);
 }
 
+void *sys_mremap(void *old_address, unsigned long old_size,
+		 unsigned long new_size, int flags, void *new_address);
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.50.0


