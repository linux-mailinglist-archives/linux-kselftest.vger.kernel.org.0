Return-Path: <linux-kselftest+bounces-26577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A14A34D6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE903A4B4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7A24292F;
	Thu, 13 Feb 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMLV+GU5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yluvrh9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF72036FF;
	Thu, 13 Feb 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470753; cv=fail; b=Ygcj7MBoc2KLDGzQWIyvpnbBLgONON2x8pE5SRXXibVkuQ4U+lTdm1OJtvd09JiUONVngvwMqV0Beb+edD+gNf+bz/VF/XYU7FtRpTbu2enR2z2GJpvVC1ehWZgIesTdvFHzpr7VNDRs9O14rOcq8sXfW8o0q9miVxEPaSet2NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470753; c=relaxed/simple;
	bh=LS57ijaYlm3z1XRCqptFHmG89ICUrmeKyzh5wEGrpuY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FNMi1dDRjsBV/DkLV99++EvZMq/wIgHueNSIOS1IxjQwAb8ExGvUgjr23fkYeHZZWSq/W5uU+buUE7fTFPA3K0FvBgi/EDFaXih5fyOiwrUf3CQnFT51PDWuPjfO/viXbaEFulp1mo4nw2x2sf1zLEQHRFjnQB5/ZRA9eeiLrIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMLV+GU5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yluvrh9v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfXYk026063;
	Thu, 13 Feb 2025 18:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=t4soA2hEgvtIwobU
	3XdgjZxFYCeqDQEVJg/J09mfCwY=; b=QMLV+GU5SQ7oB0rHpvJ7L5C4HTT9dHNv
	XdK+B82Bi3rIzBGQkaWNN/bG1ga2NWTbHUsprQ9Fsq/NK+ZFuXfHQjX3CRP3EWcr
	BTMi1Ynft9Z8soIlKRNVDczbkTcG31Bj71/a+cMSu1+tOeN7i/mSb13kYXCo2uIP
	GYt/nUS0ET1cNXd7j7TRouKRbnCaB6bBq6LtDUBGsiynDo1GfeM63kCr1wrzpg2Y
	3f0asInoGtx/bVQLuClayDNusJeLbUcwXYqbGo+7+mgCIn66lgjQaGsLmWlYawzk
	663cVPj/yq6X1X59N0OKpur4Trxj2DiI6n8Bi/+PJI1U2dUJjZU3jA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyt8np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHG2Vw005110;
	Thu, 13 Feb 2025 18:18:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc2ahq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0u8tQAPXjJF4J20a3Gx+i9suBzH75qZHDjmWqqOz80Nf+12bR0YDD7O53OI0/3LBCdShL3WnVeKdfPqSbMgz+ylTLsFGWHvw0qyak7jGiVQSBYsW3hqM04ZSCxjjejOIKUhigzBpOEEFY7O9j3qCC0NKZerC74mCuoFd5rzev67NUXkiJ2VEhKMuah7mOG3AraqfjYfjUTZFFRRs0OTcp/Y+oxcxhPPW4oYBTY0k/ch9ToRHoCM0vNEys+dg3+3VJQHCJTwqMwZrxu2t1BONKjWtfPgZlbtFxKe8hw9BMNwXqULGwoOl6OBgpHzQ0mgdypdU/kg25SSRnNIBEr20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4soA2hEgvtIwobU3XdgjZxFYCeqDQEVJg/J09mfCwY=;
 b=KFdWMQ2kdh100p+OjJ6CMFQwchq7l3UC7bgWKfXEYSYbfOBpgLrmNCldgt6i2ri+faSMqdqb/KV+/4TYgiryXEJCyc6O4asC961B3+fj6UGbzqag3AZc7p+HyzETcKvEG6IbzY5YGhWWhBek8CJHYBFWoHPQ9lHQ6eUaDvtUCMw8R6zf2KN1fQ9taESpM91OXwnq/CWu6l3vFZna8xViQ56mfxYQ9xPhSsH3EWtM7wzImz/A+GWLYgzMEGBeY+/0iU1Bu9o5HuIseCPN1BW/ngy/o4yDTMtZ3Ibgb4mWvpup0/AdVYz/p2e32lTCBLpBFxdqmqxTGdhjupbivZat0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4soA2hEgvtIwobU3XdgjZxFYCeqDQEVJg/J09mfCwY=;
 b=yluvrh9vUmpG3zKq8BVG53F9n8hG2CkpitV8LcSluzQt/gxmIBn7Z6X/49ztwef/uJMjAtxNvLA+ehllPX8prVEiVFdjZIJKWf5ucyreLroDzImLZD1gxRHzS9XA5RMYfCOU/SmLKk/RSYJTeJYc/dAzPqbOhmZGn4Js4d0dw18=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:18:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 18:18:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
Date: Thu, 13 Feb 2025 18:16:59 +0000
Message-ID: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eb76ab-2908-47dd-40fb-08dd4c5ad204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0koNAFI6HJyW7+tNA48kmcGj29xS0/rOcVPGxJviovGu3WveOW18z7KEhc3?=
 =?us-ascii?Q?6SlRq6t20m/PVmnDNd2vRKZ7+mVO//d0OZYAr3QOiVWUfKp1IdP64G2crTte?=
 =?us-ascii?Q?GNOfAdAf9YBzlWNmwB0gc8Qhl38s/PfZEjxcqHIFO5BVUkg+yPTznwXAAtsz?=
 =?us-ascii?Q?msbIY+n9rrfjX006S0FE0a9yZtvzigjAXK+QsPZxKHnddJdn3wEQCSD+bz/V?=
 =?us-ascii?Q?gfNPbMlvwFZCKC3YY2bggMNUp2Fn+HDgLEIidFA6tsqBZflXnmp8DzSAsWVR?=
 =?us-ascii?Q?lGg+cDDAL9WRFm4iw0M6MxUM6nGE3Znq/K4XRI1bPo9G6PlO8NgD7ollaDF/?=
 =?us-ascii?Q?HF1D0EamwmE0ZXkUMi2lXzXjB8BO+4V4IlkBshHlB2uKsOlKO29YTBp0FaGM?=
 =?us-ascii?Q?iIqgMekKhWx/zGG5LxQSLQcf/eNZT12powNF+Q2KwdVd4ECC+6sfmva3M37M?=
 =?us-ascii?Q?tOBXKrmIjXJrMVfRCRfuuHDQ8+Z5kM5GIEBdlYIVsjwKax2kOXkUA5fBFOeS?=
 =?us-ascii?Q?UnlMEodAO3DW6MddQCMEb7DAWpKATLTaWeg6g/No5GsJmmkTpwbewdD/Xhre?=
 =?us-ascii?Q?/ARBQZfOzJUnRT88o40X732dlJg9XOk7/avCdBQvCUVUqyV+X9a54wmXv+U6?=
 =?us-ascii?Q?Qcxh6m3t30F472dnYPPcogfsWPAj2HyF60b6GhvZKH8INjYFxbCJigpDHimw?=
 =?us-ascii?Q?qRvWFPyKo4ey1X7OSLf9mqpM1zPuyXQCiyBFhkl690C3C7dN65d3fR0yKB9x?=
 =?us-ascii?Q?XyFIZzLkeuq+ZSmR3bFA46yRHuusKk2GtMirKAF8g/uaZGGeWtIf9gXGbs7P?=
 =?us-ascii?Q?SrtF5wq9svW2b4fj3OpGgf+xI4dXaPt2RzCynb2oSQ9WRWBPbF7fVyoFzNs+?=
 =?us-ascii?Q?92RUq7TLMewRVVXjFT6w4nzFHLnFoN61HWbUxaUpjec090YUyGgl5sGPydnn?=
 =?us-ascii?Q?rNtee2mBy04F6Qk2e5TWI3jScaPsTLebqQvv8l9diCNkH6yXgWc8mBNQsUYP?=
 =?us-ascii?Q?dwqT9WTGBIqOV3U0efkcVEyyjr+KgSg49xOn2EAQ6vkIabI/7mHogGDVs088?=
 =?us-ascii?Q?GbvmtzmfTeLvzzSHlIkioR/IeX3yxgTCGq5i5tFf/ahY/kpZ6KtlW4gNhRH6?=
 =?us-ascii?Q?1ha377ZNP6YnTivLh6JgE9+F4x+0XmOSa1v9QQExL6tbgpyvxfoznPRius7/?=
 =?us-ascii?Q?nDJ7kMgyzrCVOXkeMIt/A2ioif1xN/zjnonZbX9kIyS1Xd/j5MejDcjjGbRN?=
 =?us-ascii?Q?sDOvikCVmIg6piylO0Mryf5/bBCFxBvc94EjG+nty5YCFeF8IU0to1aRUpVB?=
 =?us-ascii?Q?q+4/5N3CSMJtk7UaQ/3HbCKgMGmBNJ4LdkrcRz81RoVcnt0DdVTsOlcSnx/q?=
 =?us-ascii?Q?E0KHIZDKDNol8KJZ4cFBpJ7nOzfY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?488+lPuVFTHo54bJ9JawkuyCPUQSLqP/jc6reSczIaXdnXkw5xNZs+b4hY9n?=
 =?us-ascii?Q?uFCTg866qdk+SZ4an+bK7ELXrX1crcGHVat2Ug5L6XwGcLH/8g0lxaB7pvM2?=
 =?us-ascii?Q?DkCxMKea331eGqZ1HYMomnEI7/zACMcf8XfrMuGaj9EjTNs3WvofKRZuvXx0?=
 =?us-ascii?Q?ilDoCyus1S2RtOQ/LDcJ5lhCZFVUToueeutf6VFhDfBxAQRQnJiYZSBBgBCB?=
 =?us-ascii?Q?50Qx1of0VXjzYiBu0Lentq6QbLTEbdePdfFVsxOyAXy5BCeSZSHrXRSbaLAL?=
 =?us-ascii?Q?hdMdqC1y69sE4DAhShUxCpKWsYZjUlvqodyMUbkmLwzgSAe6zr+3N/dLfSiC?=
 =?us-ascii?Q?zIw/AT60c82d1sUqFKhwuiKTn/IAIljyOG8Gw5gwCcimtNkfyJdndqixycAu?=
 =?us-ascii?Q?GikFSPs37w5CVs0/YdpOmRqLJ/JnZ3ponipMWA/MU1AajHqQYEaUsBWJBSwC?=
 =?us-ascii?Q?IrWGBdmUObfYACWI4MIdkKVosQa4gO1aG9ysuMFHxezwfHXUkvsrkPT4paZw?=
 =?us-ascii?Q?qX9NLozZgwBfmI8viBZ1eAo3vtelEI+XMXAYCQraKXPZKtuOEL1NAuaVZHv6?=
 =?us-ascii?Q?E0e2CzNXEAKj+1xsKlnz4S4XA7/sJN23g9ggzXJlu2LD2lRU1vs2Qm8GbKW5?=
 =?us-ascii?Q?g2ig5XhGkCIVQ4aXXFqbI6nJdO3KCGJX4Mm/T/5kXxWK6cppFRX9NfMvpLTS?=
 =?us-ascii?Q?CUG5lQujmev62xF/2dQw2y2uBf+cBykY4ByhjWw4snFjAcSDcTJ6FGU5++i+?=
 =?us-ascii?Q?Vi0HCPosGiCW/QCDUuTTjozux5QoiMDUhWWcbJJzANnUP+02tbhxtpyJJV8d?=
 =?us-ascii?Q?QxyqYT1ALsOWcry+pwUbYaWcNYU1IfkUaUmcTad4WRM6JykEP4suukw5VjDm?=
 =?us-ascii?Q?XlxkS6HZbmRRriDPOfcc8HSsmi2FKyDDDSNapYIayUC5FEsF2rT6+Sznhg+V?=
 =?us-ascii?Q?3tJQjbg6kejhgcLBhBWYBJFG2EBgXxWbbDN00SSlb1XTLxizuWCymXzS7O7Y?=
 =?us-ascii?Q?DBHK0Zz7MWbgn90YThf/Qhn2Y6CjLf1GmZTGoksK6g2Uiz9ezFW7A63215lS?=
 =?us-ascii?Q?kaxvBSXHgFZXlclmO+zeei3VfTOIAg/D+Unr2++Wwq2hWn09F9WQ5fUk1HFS?=
 =?us-ascii?Q?ipeCzO9nCgC7icdA27so5cTZN5hER65O1iVplTNSYKPQellINKQdhzQFvIdz?=
 =?us-ascii?Q?YzubI/m9uoABrdYOoPE8zs8ufKl+OxwKK7zZKtp+MvZ1xgGHa8QaTAw7K5Xa?=
 =?us-ascii?Q?XED2ijaaD5kO1TuaOXrnMGqnW9T/LTpS24hz86fW8BBh0XKyuLdAvogehKca?=
 =?us-ascii?Q?UDGyjIjPbNVYhwkrbFA2mu38LcycJ2SuxR79E6Aztoq+sx1Nz+P6hxAc9mO8?=
 =?us-ascii?Q?gxSumDgcSE2k/nZlA1iaUN4yiPPhHk9YPG95Iy+pE/bLOz1YKdc5ldE1S1F8?=
 =?us-ascii?Q?wwrbzhNOcxwd+KLmp3lnvTv8ZVORjJ0ji3afR/9scu3DQiVhG2m/h9Y8YM/B?=
 =?us-ascii?Q?lGJDtm7yQ9TCNiPcFllNiFYAhTC7NwXDO4JpHH/iew3s09n49QKika+OQcNL?=
 =?us-ascii?Q?vYotJRd1jzkExHVpENDuNtF/n3mSN0w6fbdQ6YSqB8hkX5r2wNMPpKPRrbmd?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6T2XG64/uUBXXHpGGukLBJKThVc8TVDEFopd2GazrwnWShBCmlrGAHRaU+jpLWqwZGfFYFZ3kqbUnCq5rTFJ+LS33E0aNAcSDItmY91/Z5KLWAa1jExh2b9po7dg5lEUX19uTuwHGusWdLtqYAORvjDi4xSCHLAN6xmmXS0ZbQQh97YbbNxA7G/bd97FD4LZxRJkE8BPB+4bG8E3zn3EDJHRw9tYtENKxfz4kGlg/7ILbju9BG9cI9EhVF5a+t7uuIuiCZzULgWY0RYW1FmxDTUt5+fnboNhluBNK5uWUgsbDJbFtSDga4JoslIniInPR8H+c7XUc5d1VQ+eK9CbTppk/kfxUcJYuvA+w5bSpkjoQHELrv94PC7OrREVgNW2J53RKYaC32iYwUzkuQHbYFoWlgYelo2Gb3gqlwbJrPR6oAjv9BBfHQVg/NgtmU4w++HdVWD6Tp5TlQziw/Lka+7Kcs/SL4x7wPvN1Zyy7BkJxt2HJ3UshNoJKioTLz14fbjijgg4kmJTBL/ma/18U1DXdhbZqbRefd/MXB+m023U6yODrhqwvJ09tNZd4XnFgzztQYhskxDhdMXX5vVlHU80lPG3YRH+NKLF9Tc7lX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb76ab-2908-47dd-40fb-08dd4c5ad204
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:18:31.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDsS+4hzkPFE1gSaSbLuy1Xrtj4tgo8LNNaDN2pvsUmCLni61im00TNn9iEEnqVyLKcsICUmjOlPjkWSJ/ChrhUpBPS7VKqpea2XqXBr7x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130130
X-Proofpoint-ORIG-GUID: ezObmzxW1aE0OvWPznlvukZmNPaMq5Mw
X-Proofpoint-GUID: ezObmzxW1aE0OvWPznlvukZmNPaMq5Mw

The guard regions feature was initially implemented to support anonymous
mappings only, excluding shmem.

This was done such as to introduce the feature carefully and incrementally
and to be conservative when considering the various caveats and corner
cases that are applicable to file-backed mappings but not to anonymous
ones.

Now this feature has landed in 6.13, it is time to revisit this and to
extend this functionality to file-backed and shmem mappings.

In order to make this maximally useful, and since one may map file-backed
mappings read-only (for instance ELF images), we also remove the
restriction on read-only mappings and permit the establishment of guard
regions in any non-hugetlb, non-mlock()'d mapping.

It is permissible to permit the establishment of guard regions in read-only
mappings because the guard regions only reduce access to the mapping, and
when removed simply reinstate the existing attributes of the underlying
VMA, meaning no access violations can occur.

While the change in kernel code introduced in this series is small, the
majority of the effort here is spent in extending the testing to assert
that the feature works correctly across numerous file-backed mapping
scenarios.

Every single guard region self-test performed against anonymous memory
(which is relevant and not anon-only) has now been updated to also be
performed against shmem and a mapping of a file in the working directory.

This confirms that all cases also function correctly for file-backed guard
regions.

In addition a number of other tests are added for specific file-backed
mapping scenarios.

There are a number of other concerns that one might have with regard to
guard regions, addressed below:

Readahead
~~~~~~~~~

Readahead is a process through which the page cache is populated on the
assumption that sequential reads will occur, thus amortising I/O and,
through a clever use of the PG_readahead folio flag establishing during
major fault and checked upon minor fault, provides for asynchronous I/O to
occur as dat is processed, reducing I/O stalls as data is faulted in.

Guard regions do not alter this mechanism which operations at the folio and
fault level, but do of course prevent the faulting of folios that would
otherwise be mapped.

In the instance of a major fault prior to a guard region, synchronous
readahead will occur including populating folios in the page cache which
the guard regions will, in the case of the mapping in question, prevent
access to.

In addition, if PG_readahead is placed in a folio that is now inaccessible,
this will prevent asynchronous readahead from occurring as it would
otherwise do.

However, there are mechanisms for heuristically resetting this within
readahead regardless, which will 'recover' correct readahead behaviour.

Readahead presumes sequential data access, the presence of a guard region
clearly indicates that, at least in the guard region, no such sequential
access will occur, as it cannot occur there.

So this should have very little impact on any real workload. The far more
important point is as to whether readahead causes incorrect or
inappropriate mapping of ranges disallowed by the presence of guard
regions - this is not the case, as readahead does not 'pre-fault' memory in
this fashion.

At any rate, any mechanism which would attempt to do so would hit the usual
page fault paths, which correctly handle PTE markers as with anonymous
mappings.

Fault-Around
~~~~~~~~~~~~

The fault-around logic, in a similar vein to readahead, attempts to improve
efficiency with regard to file-backed memory mappings, however it differs
in that it does not try to fetch folios into the page cache that are about
to be accessed, but rather pre-maps a range of folios around the faulting
address.

Guard regions making use of PTE markers makes this relatively trivial, as
this case is already handled - see filemap_map_folio_range() and
filemap_map_order0_folio() - in both instances, the solution is to simply
keep the established page table mappings and let the fault handler take
care of PTE markers, as per the comment:

	/*
	 * NOTE: If there're PTE markers, we'll leave them to be
	 * handled in the specific fault path, and it'll prohibit
	 * the fault-around logic.
	 */

This works, as establishing guard regions results in page table mappings
with PTE markers, and clearing them removes them.

Truncation
~~~~~~~~~~

File truncation will not eliminate existing guard regions, as the
truncation operation will ultimately zap the range via
unmap_mapping_range(), which specifically excludes PTE markers.

Zapping
~~~~~~~

Zapping is, as with anonymous mappings, handled by zap_nonpresent_ptes(),
which specifically deals with guard entries, leaving them intact except in
instances such as process teardown or munmap() where they need to be
removed.

Reclaim
~~~~~~~

When reclaim is performed on file-backed folios, it ultimately invokes
try_to_unmap_one() via the rmap. If the folio is non-large, then map_pte()
will ultimately abort the operation for the guard region mapping. If large,
then check_pte() will determine that this is a non-device private
entry/device-exclusive entry 'swap' PTE and thus abort the operation in
that instance.

Therefore, no odd things happen in the instance of reclaim being attempted
upon a file-backed guard region.

Hole Punching
~~~~~~~~~~~~~

This updates the page cache and ultimately invokes unmap_mapping_range(),
which explicitly leaves PTE markers in place.

Because the establishment of guard regions zapped any existing mappings to
file-backed folios, once the guard regions are removed then the
hole-punched region will be faulted in as usual and everything will behave
as expected.

Lorenzo Stoakes (4):
  mm: allow guard regions in file-backed and read-only mappings
  selftests/mm: rename guard-pages to guard-regions
  tools/selftests: expand all guard region tests to file-backed
  tools/selftests: add file/shmem-backed mapping guard region tests

 mm/madvise.c                                  |   8 +-
 tools/testing/selftests/mm/.gitignore         |   2 +-
 tools/testing/selftests/mm/Makefile           |   2 +-
 .../mm/{guard-pages.c => guard-regions.c}     | 921 ++++++++++++++++--
 4 files changed, 821 insertions(+), 112 deletions(-)
 rename tools/testing/selftests/mm/{guard-pages.c => guard-regions.c} (58%)

--
2.48.1

