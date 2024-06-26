Return-Path: <linux-kselftest+bounces-12763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC41917599
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F4B226E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7B11184;
	Wed, 26 Jun 2024 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J/bZa1jn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wyUETCTB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B48DDC9;
	Wed, 26 Jun 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365355; cv=fail; b=QHC5PwJIa/UQMq2HOFo7CR2W9tliUviR3+CBd0xJvQmncEPQnoZpNRFq1uD2dcaT9bbKr/SF4SiBVpEekAh01ahfuc3hw60oSeE1A2a8VQw9NtYrt19aAKVjwpym/T2LOwGHi9A0wh5wGlM06iIaPFGsqJKEq8jjcsinvGAXKfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365355; c=relaxed/simple;
	bh=bHfOJRpmcl1dxD+DXwQwrl8nqV0HxhdoKYrrNML5wiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1ah7eON1Y9nVfY+umxAwSjoE0kmiB7Z8opgx3I9cgWLWZwkUSFYGrwDdzWIXgjPHx35Vrb4V49xFyO0VrFlMerTwQZKhkTWIUY2gPA9zbOqF3UUQVrjkOvJwYTr2dmZWQraJqI3YxA7u95L5BuUGL9i/B2F1zOwkLk6KClWCQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J/bZa1jn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wyUETCTB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBaQt022455;
	Wed, 26 Jun 2024 01:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=qhzt+kqXKapR2+G2HsiEcWFO0zurdU79OWMvj+7lipw=; b=
	J/bZa1jngrYHRV8AagC6dzXxaIlll23FFO7AtTdPdWcUOG4q+FmHecFK5r/1BlBf
	9t1aPHOHmKUQWM1SQneW8P7H8nhT2Zp3XG9zs7koDN4HuPB/ps8EFA/1y26UW3aZ
	VKblh1zqKJzZNPVrX/rXOpxFIzUkIOakV2PqY4X5rwEX4zADQM+xF9jnxQBOjZwI
	iyCn4UzymzWOVDILM2idc8/b/9WVIOBOukF4Bc9ez9Y/yEK8dPSBPztGfkAO84lr
	qjnq/yPYUXjPYi92tplqipuy5JemgAKboGSbTapw40Q+BeRjCuFDmX3anXAzdzGJ
	RNiZC7MJ9kVQfWqVLZu+oQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb238v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PMxQNO010948;
	Wed, 26 Jun 2024 01:28:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ev3dc-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obns7ilreE1LobOnr9+Pv5+5ZoNzZNLq2ZkWD8ujsfhUrgck2xM8tcoX6liLCWM3MWryCnBgRY62ktFUjajTFJw8XztfvTCsZpV9Ngjj5DH/PM+bNXCMIof/G1QY3WpudTscWgIKmIsT9z2iOf4qNAN4DLWGsBSN9GVnW6z8rUOvhUv5UKexQRFJd9enFudIPriIfu+YxtUWQfqeab+pt4wqgMy7GTJ4DGRPSvOeQdsf+Wk1dEyub44dwHpAidhoVJvYo/5r7lNkp3JblWycoUofDp2EDz9BTVq5G9O2lxkSwhjtA76C9RlIo4rRN1CEVLArpxEkHn7c9lZca7q6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhzt+kqXKapR2+G2HsiEcWFO0zurdU79OWMvj+7lipw=;
 b=PCGgb63dSWmvYDubDJ49YByGjexyruDhDo2mZJ8DLbRlYiq5+rUM74anv7JVT53mUac2dPaEnGLTcEg2nnaSB9X9FSE5v1OgG8Z35QpVBEzY4CNJ1/3HwfX3lJAUN9SWD5pHKHBtuYlrYGZ2HlSYLF4KbdIzH1ZpJ9UTjv2phleyU7c93GAt56J0cv9nkmYJWqL5VA6Igl4KVEBdFbAHLflH5ECJZHVoqTvIsUvOdsB47fOPTTatfQ69uCCr9o/QTtr6283q4m3mOIadhjc2Owiz6r0vcqH4AJrDemAtkEp20wbs7H3wkL1oDHMHq46v5gC8pJYzpJ6vCOZZ7BhQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhzt+kqXKapR2+G2HsiEcWFO0zurdU79OWMvj+7lipw=;
 b=wyUETCTB4ej9acJsl18WOv0Sdg54QVV9iOF5wU7VTOXeHBEEEuG3YUShriP/wT5ftVfwylsOxDhzXfnWhDED31UqwUkWe0Bk7LOtQW7I4lToC4hayE4XppPin1raEpSXtnzsmPFUsFpHzbyKWx5+XF++SeEPHhuyNL87TcgbQGc=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 01:28:49 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:28:49 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v1 3/3] selftests: rds: add testing infrastructure
Date: Tue, 25 Jun 2024 18:28:34 -0700
Message-Id: <20240626012834.5678-4-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626012834.5678-1-allison.henderson@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7e8de9-a289-4aa0-cca2-08dc957f54a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9F17SKFf0zP277mi36tdYWKeyCEAyKXIvUhDFoGfAbl0wYZdz9fRBH+gcS1w?=
 =?us-ascii?Q?2TwpFylQgBhvUTsJxs7OdemyNDI0LlNZHhDO9vLuX303g8HE+1b0ejjmC35t?=
 =?us-ascii?Q?v0dEjcckn4fQfCB5FUgfNtcq+mdD6i1b2P9+8kq7jRBxSf2aWZOWKbsT/E6d?=
 =?us-ascii?Q?Rv5VuCtICs5kEt1dI+4NWG0ffBOfeaPHvIsuZ2HXXWYFy7bdl9Fv1CgVzn9K?=
 =?us-ascii?Q?aRwNvz+VdFHjdwJUDeMajAXOB53tC0xD35ssXILuOOHgI7LgsW++/2/fuftC?=
 =?us-ascii?Q?0AgqFLeRA4G66C7iq/Ri00oO+wjBXhJcGry3F1Wm5xG+qeAIB/l1B9edbBcN?=
 =?us-ascii?Q?IRg3Us0B+0OYDnkaF5T8L1Yt02MuDqfl5H1OLCcLytsN+FZaWIcEU4CsCj1D?=
 =?us-ascii?Q?Uv4b2yuZnLkG4x4pkVnd7W2zM6LlEAygQ0RmPLEWY+gw3kmS6TPFd5/67pLD?=
 =?us-ascii?Q?FNfE4RxQGOm33l448AOoJ+8YXgFRoKOID6jWWZgl73dr+GE5VZXXjulXIImz?=
 =?us-ascii?Q?+cyLxfHkQD+1kXuvz77QwZk294csCTLhFzOjKcWuCIFF/OiATsaPvior5kaD?=
 =?us-ascii?Q?AribjThf7N10rrrua+zg/GAMFVi42fnODWV1aSZD/WVREwD2cWp3QcGVgVTw?=
 =?us-ascii?Q?flkgNKjVSAHsgBi2kGCJfnkUS0TFv/fojQ+l78lbiTLlrX/AjlZzKc5mEhrt?=
 =?us-ascii?Q?ECm6nudnNAev1MQ37bnEc/Z1DY//dgorogMUgRaCuPFjqx080gUQ9n/6BihV?=
 =?us-ascii?Q?0RM0zinFx71ggFJinwuFvBfuZ7Ehlf9kjMU3Cb3xd1KXnmY06SEh2KLFftbZ?=
 =?us-ascii?Q?wmPmqbSGoVnppbeISCpJ/6mgTffPcVS2ixF49h25wkQKSlwviqpfYQaNmO86?=
 =?us-ascii?Q?ovXzXy1uvRieL0ad+VKQ0KOo9+BRCRzy+LdnhJ25dyaW/jhkgpb4ayrD41Vu?=
 =?us-ascii?Q?4TqH8w0E7rDFxwzzffI9LD/qpd5TAtRG5PEXo3OatTxMMmMdZ1bf3rev7cTD?=
 =?us-ascii?Q?xNFGC06YEs7rCq5sgnSK80lTS2MCmrPGYv7y44/juaqY/OBLoM/rg3JawVrE?=
 =?us-ascii?Q?Mj7l8fsEBKP4kU4R9+i9cSJFjtHbaNRi4A1FDlhn61I2lDDDhVBCAsnGrwrA?=
 =?us-ascii?Q?XF4qtE5Ak2Ily5wxhjS7CcTrNXFiP6t+VC6TlcBwBx6LoSU1u7kBR+tybaHL?=
 =?us-ascii?Q?Jns3tufpn9XXTdtY14/859KOWUVjAtv0nolCAj/VWTNhgVp+RB20vxO/mNwR?=
 =?us-ascii?Q?v5AaLPnFxTrKDHUt6+FWmblN7HEulT+Dj5JKUXjf/US7fWc6Dst35G/oCBx1?=
 =?us-ascii?Q?DxQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bW/c9N/Q2LVS0CY018WJK1Xz5Sbg8+40FFyph3rcChsqdmZ0pyQSOo6i9Dx7?=
 =?us-ascii?Q?w4RmoTzLUmrsQsRUiXtJfLZc30oGJ5ntpXPwrv8a1jDrbnHdtgTMfvByA8+c?=
 =?us-ascii?Q?BF7StS4CmNTJSvq9F/8dFcI8kjSHEj/jgaguC/GpEpx6wSmGK9GMxcD9aYS7?=
 =?us-ascii?Q?0joa8j3B+Jg2MvsiuZ6bN9cRTTPeDt7iksZu8HH8Em3K5z9K/0tjvWnlSXyL?=
 =?us-ascii?Q?jMH+dS0G4cff17U8iNryX46Pih39a4x9Kj7p1k6qdGOsSusw7CznQG1gDGas?=
 =?us-ascii?Q?66w/Ao6JRSpRlWRtn30XWVH8miFJ+u2nSHqqHZtvQuUOuqcScplxPPSqPsSG?=
 =?us-ascii?Q?e5NxmkZkJMBN7Yd+jrvvAsLtsHk1aJ8pEbIldBZlhYpGIjuZqOGLcIztbasy?=
 =?us-ascii?Q?SbLuu8L1Mvcd6NUSdWrd6h6fKpou/vfpNOhda7qRkXve/pwreO1Hpc/wIxag?=
 =?us-ascii?Q?9WINrdgvXKO0VOLjuI6kAOULKEvvX6EwZXHh7taHZkkzjuVMvo/jKC3A788Q?=
 =?us-ascii?Q?XLcydU8VJLKmKtYFyuk8Ub7QihIZzELuCE0A+XWe2RY7w/EkAhMUb/5+cL1r?=
 =?us-ascii?Q?0pPyZRRxxmowyTHrVaJLQzWUyjCQ3678dDYHqm+lZmVie+VE9UFPAZs/nbHC?=
 =?us-ascii?Q?MzcBbQ/oW2EBTRbM39ihZ4I0wXeBaqyP762/RG8dsKA/KpDQNny/CkackrHU?=
 =?us-ascii?Q?VMmXw+bUsD3g5iwDA7FI4Eyxi4Qa9F6y/xj3yR/HtoiJWumQJ2jJhEkhP4vs?=
 =?us-ascii?Q?BrnF3BcDvhlm8fc8hapV6EWCrAfA58tyndkLhtz/5jwQ1dE0AxWvQj672sOh?=
 =?us-ascii?Q?PXiDpM4JeiYedgYsrJ2Y4YXqT4q2fIexZmugT8Mc9iFrNgY/RX6YeHyNtX6H?=
 =?us-ascii?Q?6pqZmxMXFoJaXbbC7yakz+nkbgsXBVxT5zezskRSaZ0Qvu/OiZhu9ERGxn0u?=
 =?us-ascii?Q?WZJ0ZCCZzIfw6piSrg1Iy6JM0Cz1JvMFNCMWpS+DoqCZrirCFpkxKpEu3X8N?=
 =?us-ascii?Q?3i6Z7r08c8dyOTKUuWoDzOdZIUBcZCyLXdJ1ebI0YbLdjrynsW1q5hb6hMt7?=
 =?us-ascii?Q?bCwS5ljrsa8VVAmeaINub4pQgTlZfG1JBH4sjJixSml3T0dWpaYZEaly6Jp4?=
 =?us-ascii?Q?r0kbRP2xRD8j1SNhIlHNa35tBPhCnYdoVK4BII+LeYFkx56ScVAzLYRIhdWc?=
 =?us-ascii?Q?kvsFmlEQ7otdu2tJduZkYDJVxTgGD3DWutJENjxzKvdEi5iyyJ9biFlszLFP?=
 =?us-ascii?Q?J1okaoDjzdr5Z28rRrHUtn6fpTc7cJltP9P6zyiegGyknOSXGEWui37o34aN?=
 =?us-ascii?Q?XklwwOpTKjvKLGRLpZcAoMYcQ7ps4A80fg2NKHUm+Mo2VYxUBj2gB2WoK01t?=
 =?us-ascii?Q?TYoczNLkO67om5HWnza6CmaV8l3PQW/eRtgBzSp0oaOgsEzI2H1CFBHIRx2w?=
 =?us-ascii?Q?yMKJvhlE+wwFOsxW1DdOgDlaVFYFQndNAXZX1RpapWp/iNqNRjlTB7or0ZBk?=
 =?us-ascii?Q?/dkH2qmtINm0YEf8NRzWmT4bKcffZIJnueQPiJgzs94Bh7p0njCHRtzhxdhr?=
 =?us-ascii?Q?KYWBbX1uxOaoRvsfgYKsMF1xGadUY29Y/RdUezSpPLuTf6dZVgqi5FwMDD0m?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lqr6ocAFRihbTmxAPaF2//fDc8uLAuN8BXkbMmPInEk35ufgbIF/cRSN/RaDNYQUV+wrMfDY6YXL3aYmQ6lLqv7jyTzSUnalUoUK4/VsJ+V2IU1Sk41D92bWjg+zEsW3N77gt1JE21x0WhgjUbKmkv/ElA0VVIPozUzBCDKZ6lJNmo+I+f6LNjlLMGKg++CrSfICp4aP1C6nB3qmMaP7r1R8OZgt5Rd3r5/W7bhX6oy4gq3HP60M5VKabE0h4yBOKOFBcEbWKQuFzc+/lhKQQ2rgtPLcQ5zNH7+Clvu1tVaEM5ARURrtwot7ShtOkGlfQfaxwaUz2c7U4xOPLHb/fy1rrDnpfUKRbdUVx0N2GupKTfGAUlB92hEJWSkAZm5qV9hk4AIqsIyCCexAqcc/XfiHGLty2LlLp2n62io2JDrMBs8/BSEhiwkMsnJhXXezCnAaD7YLuYy236uEpAyqlBOoPwVDJgCPbBQ6uSgFBojwlZ+AJs83umgRFj3aw/IK7nPWY+80s5Mhd7GGUgt0cYv/pnA++MNvBBfDSd1onr+ykmRP85EnE8pq8Kn3NwNgFln4NTBa/7lhe8gyryjNTNhaujCftPnuVmVwM4v7YYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7e8de9-a289-4aa0-cca2-08dc957f54a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:28:49.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnrFbUeyeb3zo7Yzd70ziXkMasBDmP+h+Gpsx3TbkOB/wuQpf2IFAPXxlOrP4Kte4yYYoSaAyk7YP15XIkJ48sqVvNwJTvoCXa03XbHshX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260010
X-Proofpoint-GUID: 2Ce0AgJg4XCxIoMvrOi8ykPmlFaPbi7z
X-Proofpoint-ORIG-GUID: 2Ce0AgJg4XCxIoMvrOi8ykPmlFaPbi7z

From: Vegard Nossum <vegard.nossum@oracle.com>

This adds some basic self-testing infrastructure for RDS-TCP.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 Documentation/dev-tools/gcov.rst           |  11 +
 MAINTAINERS                                |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  13 +
 tools/testing/selftests/net/rds/README.txt |  41 ++++
 tools/testing/selftests/net/rds/config.sh  |  56 +++++
 tools/testing/selftests/net/rds/init.sh    |  69 ++++++
 tools/testing/selftests/net/rds/run.sh     | 271 +++++++++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 251 +++++++++++++++++++
 9 files changed, 714 insertions(+)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 5fce2b06f229..dbd26b02ff3c 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -75,6 +75,17 @@ Only files which are linked to the main kernel image or are compiled as
 kernel modules are supported by this mechanism.
 
 
+Module specific configs
+-----------------------
+
+Gcov kernel configs for specific modules are described below:
+
+CONFIG_GCOV_PROFILE_RDS:
+        Enables GCOV profiling on RDS for checking which functions or
+        lines are executed. This config is used by the rds selftest to
+        generate coverage reports. If left unset the report is omitted.
+
+
 Files
 -----
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d648af07cbd6..861dbd2f15fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18849,6 +18849,7 @@ S:	Supported
 W:	https://oss.oracle.com/projects/rds/
 F:	Documentation/networking/rds.rst
 F:	net/rds/
+F:	tools/testing/selftests/net/rds/
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..5b01fe3277e2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += net/tcp_ao
 TARGETS += net/netfilter
+TARGETS += net/rds
 TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
new file mode 100644
index 000000000000..52fe54006eba
--- /dev/null
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+all:
+	@echo mk_build_dir="$(shell pwd)" > include.sh
+
+TEST_PROGS := run.sh \
+	include.sh \
+	test.py \
+	init.sh
+
+EXTRA_CLEAN := /tmp/rds_logs
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
new file mode 100644
index 000000000000..dddf9d33848e
--- /dev/null
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -0,0 +1,41 @@
+RDS self-tests
+==============
+
+These scripts provide a coverage test for RDS-TCP by creating a vm
+with two network namespaces and running rds packets between them.
+A loopback network is provisioned with optional probability of packet
+loss or corruption. A workload of 50000 hashes, each 64 characters
+in size, are passed over an RDS socket on this test network. A passing
+test means the RDS-TCP stack was able to recover properly.  The provided
+config.sh can be used to compile the kernel with the necessary gcov
+options.  The kernel may optionally be configured to omit the coverage
+report as well.
+
+USAGE:
+	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
+	       [-u packet_duplcate]
+
+OPTIONS:
+	-d	Log directory.  Defaults to /tmp/rds_logs
+
+	-l	Simulates a percentage of packet loss
+
+	-c	Simulates a percentage of packet corruption
+
+	-u	Simulates a percentage of packet duplication.
+
+EXAMPLE:
+
+    # Create a suitable gcov enabled .config
+    tools/testing/selftests/net/rds/config.sh -g
+
+    # Alternatly create a gcov disabled .config
+    tools/testing/selftests/net/rds/config.sh
+
+    # build the kernel
+    make -j128
+
+    # launch the tests in a VM
+    tools/testing/selftests/net/rds/run.sh
+
+An HTML coverage report will be output in /tmp/rds_logs/coverage/.
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
new file mode 100755
index 000000000000..3454f4856d69
--- /dev/null
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+set -x
+
+unset KBUILD_OUTPUT
+
+GENERATE_GCOV_REPORT=0
+while getopts "g" opt; do
+  case ${opt} in
+    g)
+      GENERATE_GCOV_REPORT=1
+      ;;
+    :)
+      echo "USAGE: config.sh [-g]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+# start with a default config
+make defconfig
+
+# no modules
+scripts/config --disable CONFIG_MODULES
+
+# enable RDS
+scripts/config --enable CONFIG_RDS
+scripts/config --enable CONFIG_RDS_TCP
+
+if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+	# instrument RDS and only RDS
+	scripts/config --enable CONFIG_GCOV_KERNEL
+	scripts/config --disable GCOV_PROFILE_ALL
+	scripts/config --enable GCOV_PROFILE_RDS
+else
+	scripts/config --disable CONFIG_GCOV_KERNEL
+	scripts/config --disable GCOV_PROFILE_ALL
+	scripts/config --disable GCOV_PROFILE_RDS
+fi
+
+# need network namespaces to run tests with veth network interfaces
+scripts/config --enable CONFIG_NET_NS
+scripts/config --enable CONFIG_VETH
+
+# simulate packet loss
+scripts/config --enable CONFIG_NET_SCH_NETEM
+
+# generate real .config without asking any questions
+make olddefconfig
diff --git a/tools/testing/selftests/net/rds/init.sh b/tools/testing/selftests/net/rds/init.sh
new file mode 100755
index 000000000000..5d2577625769
--- /dev/null
+++ b/tools/testing/selftests/net/rds/init.sh
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+
+COLLECT_GCOV=0
+LOG_DIR=/tmp
+PY_CMD="/usr/bin/python3"
+PLOSS=0
+PCORRUPT=0
+PDUP=0
+while getopts "d:p:l:c:u:g" opt; do
+  case ${opt} in
+    d)
+      LOG_DIR=${OPTARG}
+      ;;
+    p)
+      PY_CMD=${OPTARG}
+      ;;
+    l)
+      PLOSS=${OPTARG}
+      ;;
+    c)
+      PCORRUPT=${OPTARG}
+      ;;
+    u)
+      PDUP=${OPTARG}
+      ;;
+    g)
+      COLLECT_GCOV=1
+      ;;
+    :)
+      echo "USAGE: init.sh [-d logdir] [-p python_cmd] [-l packet_loss] [-c packet_corruption] " \
+	   "[-u packet_duplcate] [-g]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+LOG_FILE="${LOG_DIR}/rds-strace.txt"
+
+mount -t proc none /proc
+mount -t sysfs none /sys
+mount -t tmpfs none /var/run
+mount -t debugfs none /sys/kernel/debug
+
+echo running RDS tests...
+echo Traces will be logged to "$LOG_FILE"
+rm -f "$LOG_FILE"
+strace -T -tt -o "$LOG_FILE" "$PY_CMD" "$(dirname "$0")/test.py" --timeout 300 -d "$LOG_DIR" \
+	-l "$PLOSS" -c "$PCORRUPT" -u "$PDUP" || true
+
+if [ "$COLLECT_GCOV" -eq 1 ]; then
+	echo saving coverage data...
+	(set +x; cd /sys/kernel/debug/gcov; find ./* -name '*.gcda' | \
+	while read -r f
+	do
+		cat < "/sys/kernel/debug/gcov/$f" > "/$f"
+	done)
+fi
+
+dmesg > "${LOG_DIR}/dmesg.out"
+
+/usr/sbin/poweroff --no-wtmp --force
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
new file mode 100755
index 000000000000..823631507230
--- /dev/null
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -0,0 +1,271 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+
+unset KBUILD_OUTPUT
+
+current_dir="$(realpath "$(dirname "$0")")"
+build_dir="$current_dir"
+
+build_include="$current_dir/include.sh"
+if test -f "$build_include"; then
+	# this include will define "$mk_build_dir" as the location the test was
+	# built.  We will need this if the tests are installed in a location
+	# other than the kernel source
+
+	source "$build_include"
+	build_dir="$mk_build_dir"
+fi
+
+# This test requires kernel source and the *.gcda data therein
+# Locate the top level of the kernel source, and the net/rds
+# subfolder with the appropriate *.gcno object files
+ksrc_dir="$(realpath "$build_dir"/../../../../../)"
+kconfig="$ksrc_dir/.config"
+obj_dir="$ksrc_dir/net/rds"
+
+GCOV_CMD=gcov
+
+# This script currently only works for x86_64
+ARCH="$(uname -m)"
+case "${ARCH}" in
+x86_64)
+	QEMU_BINARY=qemu-system-x86_64
+	;;
+*)
+	echo "selftests: [SKIP] Unsupported architecture"
+	exit 4
+	;;
+esac
+
+#check to see if the host has the required packages to generate a gcov report
+check_gcov_env()
+{
+	if ! which "$GCOV_CMD" > /dev/null 2>&1; then
+		echo "Warning: Could not find gcov. "
+		GENERATE_GCOV_REPORT=0
+	fi
+
+	# the gcov version must match the gcc version
+	GCC_VER=$(gcc -dumpfullversion)
+	GCOV_VER=$($GCOV_CMD -v | grep gcov | awk '{print $3}'| awk 'BEGIN {FS="-"}{print $1}')
+	if [ "$GCOV_VER" != "$GCC_VER" ]; then
+		#attempt to find a matching gcov version
+		GCOV_CMD=gcov-$(gcc -dumpversion)
+
+		if ! which "$GCOV_CMD" > /dev/null 2>&1; then
+			echo "Warning: Could not find an appropriate gcov installation. \
+				gcov version must match gcc version"
+			GENERATE_GCOV_REPORT=0
+		fi
+
+		#recheck version number of found gcov executable
+		GCOV_VER=$($GCOV_CMD -v | grep gcov | awk '{print $3}'| \
+			awk 'BEGIN {FS="-"}{print $1}')
+		if [ "$GCOV_VER" != "$GCC_VER" ]; then
+			echo "Warning: Could not find an appropriate gcov installation. \
+				gcov version must match gcc version"
+			GENERATE_GCOV_REPORT=0
+		else
+			echo "Warning: Mismatched gcc and gcov detected.  Using $GCOV_CMD"
+		fi
+	fi
+
+	if ! which gcovr > /dev/null 2>&1; then
+		echo "Warning: Could not find gcovr"
+		GENERATE_GCOV_REPORT=0
+	fi
+}
+
+# Check to see if the kconfig has the required configs to generate a coverage report
+check_gcov_conf()
+{
+	if ! grep -x "CONFIG_GCOV_PROFILE_RDS=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_PROFILE_RDS should be enabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+	if ! grep -x "CONFIG_GCOV_KERNEL=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_KERNEL should be enabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+	if grep -x "CONFIG_GCOV_PROFILE_ALL=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_PROFILE_ALL should be disabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+
+	if [ "$GENERATE_GCOV_REPORT" -eq 0 ]; then
+		echo "To enable gcov reports, please run "\
+			"\"tools/testing/selftests/net/rds/config.sh -g\" and rebuild the kernel"
+	else
+		# if we have the required kernel configs, proceed to check the environment to
+		# ensure we have the required gcov packages
+		check_gcov_env
+	fi
+}
+
+# Kselftest framework requirement - SKIP code is 4.
+check_conf_enabled() {
+	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] This test requires $1 enabled"
+		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+		exit 4
+	fi
+}
+check_conf_disabled() {
+	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] This test requires $1 disabled"
+		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+		exit 4
+	fi
+}
+check_conf() {
+	check_conf_enabled CONFIG_NET_SCH_NETEM
+	check_conf_enabled CONFIG_VETH
+	check_conf_enabled CONFIG_NET_NS
+	check_conf_enabled CONFIG_RDS_TCP
+	check_conf_enabled CONFIG_RDS
+	check_conf_disabled CONFIG_MODULES
+}
+
+check_env()
+{
+	if ! test -d "$obj_dir"; then
+		echo "selftests: [SKIP] This test requires a kernel source tree"
+		exit 4
+	fi
+	if ! test -e "$kconfig"; then
+		echo "selftests: [SKIP] This test requires a configured kernel source tree"
+		exit 4
+	fi
+	if ! which strace > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without strace"
+		exit 4
+	fi
+	if ! which tcpdump > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without tcpdump"
+		exit 4
+	fi
+	if ! which "$QEMU_BINARY" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without qemu"
+		exit 4
+	fi
+
+	if ! which python3 > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without python3"
+		exit 4
+	fi
+
+	python_major=$(python3 -c "import sys; print(sys.version_info[0])")
+	python_minor=$(python3 -c "import sys; print(sys.version_info[1])")
+	if [[ python_major -lt 3 || ( python_major -eq 3 && python_minor -lt 9 ) ]] ; then
+		echo "selftests: [SKIP] Could not run test without at least python3.9"
+		python3 -V
+		exit 4
+	fi
+}
+
+LOG_DIR=/tmp/rds_logs
+PLOSS=0
+PCORRUPT=0
+PDUP=0
+GENERATE_GCOV_REPORT=1
+while getopts "d:l:c:u:" opt; do
+  case ${opt} in
+    d)
+      LOG_DIR=${OPTARG}
+      ;;
+    l)
+      PLOSS=${OPTARG}
+      ;;
+    c)
+      PCORRUPT=${OPTARG}
+      ;;
+    u)
+      PDUP=${OPTARG}
+      ;;
+    :)
+      echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
+           "[-u packet_duplcate] [-g]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+
+check_env
+check_conf
+
+check_gcov_conf
+gflags=""
+if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+	gflags="-g"
+else
+	echo "Coverage report will be skipped"
+fi
+
+#if we are running in a python environment, we need to capture that
+#python bin so we can use the same python environment in the vm
+PY_CMD=$(which python3)
+
+rm -fr "$LOG_DIR"
+TRACE_FILE="${LOG_DIR}/rds-strace.txt"
+mkdir -p  "$LOG_DIR"
+
+# start a VM using a 9P root filesystem that maps to the host's /
+# we pass ./init.sh from the same directory as we are in as the
+# guest's init, which will run the tests and copy the coverage
+# data back to the host filesystem.
+$QEMU_BINARY \
+	-enable-kvm \
+	-cpu host \
+	-smp 4 \
+	-kernel "${ksrc_dir}/arch/x86/boot/bzImage" \
+	-append "rootfstype=9p root=/dev/root rootflags=trans=virtio,version=9p2000.L rw \
+		console=ttyS0 init=${current_dir}/init.sh -d ${LOG_DIR} -p ${PY_CMD} ${gflags} \
+		-l ${PLOSS} -c ${PCORRUPT} -u ${PDUP} panic=-1" \
+	-display none \
+	-serial stdio \
+	-fsdev local,id=fsdev0,path=/,security_model=none,multidevs=remap \
+	-device virtio-9p-pci,fsdev=fsdev0,mount_tag=/dev/root \
+	-no-reboot
+
+# generate a nice HTML coverage report
+if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+	echo running gcovr...
+	gcovr -v -s --html-details --gcov-executable "$GCOV_CMD" --gcov-ignore-parse-errors \
+		-o "${LOG_DIR}/coverage/" "${ksrc_dir}/net/rds/"
+fi
+
+# extract the return code of the test script from the strace if it is there
+if [ ! -f "$TRACE_FILE" ]; then
+	echo "FAIL: Test failed to complete"
+	exit 1
+fi
+
+set +e
+tail -1 "$TRACE_FILE" | grep "killed by SIGALRM" > /dev/null 2>&1
+if [ $? -eq 0 ]; then
+	echo "FAIL: Test timed out"
+	exit 1
+fi
+
+tail -1 "$TRACE_FILE" | grep "exited with"
+if [ $? -ne 0 ]; then
+	echo "FAIL: Test failed to complete"
+	exit 1
+fi
+
+test_rc=$(tail -1 "$TRACE_FILE" | grep -o 'exited with.*' | cut -d ' ' -f 3)
+if [ "$test_rc" -eq 0 ]; then
+	echo "PASS: Test completed successfully"
+else
+	echo "FAIL: Test failed"
+fi
+
+exit "$test_rc"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
new file mode 100644
index 000000000000..4da3bb933842
--- /dev/null
+++ b/tools/testing/selftests/net/rds/test.py
@@ -0,0 +1,251 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import ctypes
+import errno
+import hashlib
+import os
+import select
+import signal
+import socket
+import subprocess
+import sys
+import atexit
+from pwd import getpwuid
+from os import stat
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+setns = libc.setns
+
+net0 = 'net0'
+net1 = 'net1'
+
+veth0 = 'veth0'
+veth1 = 'veth1'
+
+# Convenience wrapper function for calling the subsystem ip command.
+def ip(*args):
+    subprocess.check_call(['/usr/sbin/ip'] + list(args))
+
+# Helper function for creating a socket inside a network namespace.
+# We need this because otherwise RDS will detect that the two TCP
+# sockets are on the same interface and use the loop transport instead
+# of the TCP transport.
+def netns_socket(netns, *args):
+    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+
+    child = os.fork()
+    if child == 0:
+        # change network namespace
+        with open(f'/var/run/netns/{netns}') as f:
+            try:
+                ret = setns(f.fileno(), 0)
+            except IOError as e:
+                print(e.errno)
+                print(e)
+
+        # create socket in target namespace
+        s = socket.socket(*args)
+
+        # send resulting socket to parent
+        socket.send_fds(u0, [], [s.fileno()])
+
+        sys.exit(0)
+
+    # receive socket from child
+    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    os.waitpid(child, 0)
+    u0.close()
+    u1.close()
+    return socket.fromfd(s[0], *args)
+
+#Parse out command line arguments.  We take an optional
+# timeout parameter and an optional log output folder
+parser = argparse.ArgumentParser(description="init script args",
+                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
+parser.add_argument("-d", "--logdir", action="store", help="directory to store logs", default="/tmp")
+parser.add_argument('--timeout', help="timeout to terminate hung test", type=int, default=0)
+parser.add_argument('-l', '--loss', help="Simulate tcp packet loss", type=int, default=0)
+parser.add_argument('-c', '--corruption', help="Simulate tcp packet corruption", type=int, default=0)
+parser.add_argument('-u', '--duplicate', help="Simulate tcp packet duplication", type=int, default=0)
+args = parser.parse_args()
+logdir=args.logdir
+packet_loss=args.loss
+packet_corruption=args.corruption
+packet_duplicate=args.duplicate
+
+ip('netns', 'add', net0)
+ip('netns', 'add', net1)
+ip('link', 'add', 'type', 'veth')
+
+addrs = [
+    # we technically don't need different port numbers, but this will
+    # help identify traffic in the network analyzer
+    ('10.0.0.1', 10000),
+    ('10.0.0.2', 20000),
+]
+
+# move interfaces to separate namespaces so they can no longer be
+# bound directly; this prevents rds from switching over from the tcp
+# transport to the loop transport.
+ip('link', 'set', veth0, 'netns', net0, 'up')
+ip('link', 'set', veth1, 'netns', net1, 'up')
+
+# add addresses
+ip('-n', net0, 'addr', 'add', addrs[0][0] + '/32', 'dev', veth0)
+ip('-n', net1, 'addr', 'add', addrs[1][0] + '/32', 'dev', veth1)
+
+# add routes
+ip('-n', net0, 'route', 'add', addrs[1][0] + '/32', 'dev', veth0)
+ip('-n', net1, 'route', 'add', addrs[0][0] + '/32', 'dev', veth1)
+
+# sanity check that our two interfaces/addresses are correctly set up
+# and communicating by doing a single ping
+ip('netns', 'exec', net0, 'ping', '-c', '1', addrs[1][0])
+
+# Start a packet capture on each network
+for net in [net0, net1]:
+    tcpdump_pid = os.fork()
+    if tcpdump_pid == 0:
+        pcap = logdir+'/'+net+'.pcap'
+        subprocess.check_call(['touch', pcap])
+        user = getpwuid(stat(pcap).st_uid).pw_name
+        ip('netns', 'exec', net, '/usr/sbin/tcpdump', '-Z', user, '-i', 'any', '-w', pcap)
+        sys.exit(0)
+
+# simulate packet loss, duplication and corruption
+for net, iface in [(net0, veth0), (net1, veth1)]:
+    ip('netns', 'exec', net,
+        '/usr/sbin/tc', 'qdisc', 'add', 'dev', iface, 'root', 'netem',
+        'corrupt', str(packet_corruption)+'%',
+        'loss', str(packet_loss)+'%',
+        'duplicate', str(packet_duplicate)+'%',
+    )
+
+# add a timeout
+if args.timeout > 0:
+    signal.alarm(args.timeout)
+
+sockets = [
+    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
+    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
+]
+
+for s, addr in zip(sockets, addrs):
+    s.bind(addr)
+    s.setblocking(0)
+
+fileno_to_socket = {
+    s.fileno(): s for s in sockets
+}
+
+addr_to_socket = {
+    addr: s for addr, s in zip(addrs, sockets)
+}
+
+socket_to_addr = {
+    s: addr for addr, s in zip(addrs, sockets)
+}
+
+send_hashes = {}
+recv_hashes = {}
+
+ep = select.epoll()
+
+for s in sockets:
+    ep.register(s, select.EPOLLRDNORM)
+
+n = 50000
+nr_send = 0
+nr_recv = 0
+
+while nr_send < n:
+    # Send as much as we can without blocking
+    print("sending...", nr_send, nr_recv)
+    while nr_send < n:
+        send_data = hashlib.sha256(f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
+
+        # pseudo-random send/receive pattern
+        sender = sockets[nr_send % 2]
+        receiver = sockets[1 - (nr_send % 3) % 2]
+
+        try:
+            sender.sendto(send_data, socket_to_addr[receiver])
+            send_hashes.setdefault((sender.fileno(), receiver.fileno()), hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
+            nr_send = nr_send + 1
+        except BlockingIOError as e:
+            break
+        except OSError as e:
+            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
+                break
+            raise
+
+    # Receive as much as we can without blocking
+    print("receiving...", nr_send, nr_recv)
+    while nr_recv < nr_send:
+        for fileno, eventmask in ep.poll():
+            receiver = fileno_to_socket[fileno]
+
+            if eventmask & select.EPOLLRDNORM:
+                while True:
+                    try:
+                        recv_data, address = receiver.recvfrom(1024)
+                        sender = addr_to_socket[address]
+                        recv_hashes.setdefault((sender.fileno(), receiver.fileno()), hashlib.sha256()).update(f'<{recv_data}>'.encode('utf-8'))
+                        nr_recv = nr_recv + 1
+                    except BlockingIOError as e:
+                        break
+
+    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+    for net in [net0, net1]:
+        ip('netns', 'exec', net, '/usr/sbin/sysctl', 'net.rds.tcp.rds_tcp_rcvbuf=10000')
+        ip('netns', 'exec', net, '/usr/sbin/sysctl', 'net.rds.tcp.rds_tcp_sndbuf=10000')
+
+print("done", nr_send, nr_recv)
+
+# the Python socket module doesn't know these
+RDS_INFO_FIRST = 10000
+RDS_INFO_LAST = 10017
+
+nr_success = 0
+nr_error = 0
+
+for s in sockets:
+    for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
+        # Sigh, the Python socket module doesn't allow us to pass
+        # buffer lengths greater than 1024 for some reason. RDS
+        # wants multiple pages.
+        try:
+            s.getsockopt(socket.SOL_RDS, optname, 1024)
+            nr_success = nr_success + 1
+        except OSError as e:
+            nr_error = nr_error + 1
+            if e.errno == errno.ENOSPC:
+                # ignore
+                pass
+
+print(f"getsockopt(): {nr_success}/{nr_error}")
+
+print("Stopping network packet captures")
+subprocess.check_call(['killall', '-q', 'tcpdump'])
+
+# We're done sending and receiving stuff, now let's check if what
+# we received is what we sent.
+for (sender, receiver), send_hash in send_hashes.items():
+    recv_hash = recv_hashes.get((sender, receiver))
+
+    if recv_hash is None:
+        print("FAIL: No data received")
+        sys.exit(1)
+
+    if send_hash.hexdigest() != recv_hash.hexdigest():
+        print("FAIL: Send/recv mismatch")
+        print("hash expected:", send_hash.hexdigest())
+        print("hash received:", recv_hash.hexdigest())
+        sys.exit(1)
+
+    print(f"{sender}/{receiver}: ok")
+
+print("Success")
+sys.exit(0)
-- 
2.25.1


