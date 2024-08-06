Return-Path: <linux-kselftest+bounces-14867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596029494A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6FA28A07C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CA1CFA9;
	Tue,  6 Aug 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k5lmAMIa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UYscdn0R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B9F9E6;
	Tue,  6 Aug 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958711; cv=fail; b=pwEUFDoApQqPkpYgRiLesdHJ9glel9FmGUvNZVOGwu22QnbKNRpzAslDX0biFbkc6OlDXobqBX0zuilLptZR8noeZgjzobNaZmWZYR7T8shX6APch2nILLgyt+N8YFXt2tYVvAmqJ5Ay3+rfq1viom6CDOL1h1mQnJtiCaCoJc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958711; c=relaxed/simple;
	bh=+sB1KpuddCgXnsZak6Peq26JGf1pIWRwhDjPhd1YGQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYayLi3vM83mdYSmTycdX/TolBHnHaOsTlQJnoto3Uaw4OO1CBJiWLu93zvRdLoka4QrQudfIFOYNE8ldvD6Acjr14bUYg7JYY5KX434FW321wj1suy7YKMiiq1LK6flj/GX4RlMqg5zqUH300jaazTpTZm6Fsd6B+DhFscRR60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k5lmAMIa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UYscdn0R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Eb1F0023462;
	Tue, 6 Aug 2024 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Oro9uD9djd70taSSB9xcXI2OVh2rzv/b1Z+CQ1KJ47w=; b=
	k5lmAMIaJ9vLjQLNSTorMBDAVdsdiCZ3Nd6kV0vDm8TgQTU330d3/rGikHkwqphv
	Iu++/8dKuxg0YN2sFC7dVzW15zQOvT9D/AA3jPExjn67Lr9zd3n7Vs3Gu8EaSwxR
	U9B7OYJu+xHG0yuYuhT84aa0D9WmtHGqbGKOm4zOmU1Mde8o+o4ORl1mc89hUwPx
	nzFIoadTPIpqfrwC03kAczfcKrCEzYBM0K09M2fW2Pz2zNG+HTWBmCdTv/Pn063j
	fJdZm0v31tohV5hUoMZuwqg2MEnTEMd4VPdLQHBtPXHp9a8pwLAiSY1MKu3SvQiL
	aGyLUezssB2wxwMVcUekDA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye5mm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476Efm87004885;
	Tue, 6 Aug 2024 15:38:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0evu3n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv79l2SDZfO8psO/zOko+rLjkxK4iRA+rgMvhs/AZYn1Ix7RWZpVN1VWzRh3nh1G8AWUBVWhilgKqITZc3PxMqYlNCNekbfRnBPzTbjVZxgtr4s6Wvr9nxpGSG5bmo69Z2dTnjDkDEgbqprBaHjCvMSByA9hLDfzFWtjVni9lDqsdvdXs6fcpRqlvOk2y5N1Gm4VPEd5vdDJq5SwP+SJ6o9UymGr3H9I/7Y1AWHVlnNgyobkli9+cHvNQSBu4r/6UCus6v/qL78U2NaKWZdfPtG5NAngJqgBU1oBudXzt+jOEAQjN3crXkFQD0oIjn7pUOZI6ic5U27r2DY+RlE9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oro9uD9djd70taSSB9xcXI2OVh2rzv/b1Z+CQ1KJ47w=;
 b=F9xfX4B+0QAVcMyGSTIkAXl/t3TVFsB/pdOcGgdmIA9l9GsRtGUhmxuOg4ryXh4qZS0Kg+/hTL04Xi0ZucWdKirlkH3T300ckr6f+p0hSGG4iyfXLIl3qTs9Jj4F8xVq9/ROH7Q9INluawy/4Rys0Or70pSADIt+eIn76l8M55diI86OyZDlTq6lj+j9hvwNcMhM2gS3B/WLIMCskh0PLvPqSgjM8VmCkRfQVGLJK2Bi+i5ZL6NLw4qdTGAtWZXtLC+Nj4iWAuZJUzAqkcBo6++o7CziaVuP8v0batBPbPnV8Jq94p54mNFGhUsUZp4fgFvFV2KN+DQrZZx2GCrdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oro9uD9djd70taSSB9xcXI2OVh2rzv/b1Z+CQ1KJ47w=;
 b=UYscdn0RXe/yPALuJgUVFVakcdiTMznb+a+oJ2ZjbIajHkrFVd96uA3zduMqvO29DieKjOmcMDkrT2O6QJoeqUvjleYuhn6sKWgLUEGCpvb60h/i5mgvsQ9OI30nZbvnun39B6ZoEdfbeaPn9NdKXWZxD9fEcmstI6XKIxv4toI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 15:38:25 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:38:25 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v2 1/3] .gitignore: add .gcda files
Date: Tue,  6 Aug 2024 08:38:07 -0700
Message-Id: <20240806153809.282716-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806153809.282716-1-allison.henderson@oracle.com>
References: <20240806153809.282716-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed6edc-12b0-4a39-532f-08dcb62dcf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmcmA6n1scxa8m4YZ1uTSB4VPJa6XTmg0ds4cabq3Ay9N+Ogd236Wlwoj5xV?=
 =?us-ascii?Q?BClkirPo2blT1eF/X28sn98esIu79+LhOCg4wwsQOiMBLe/QPBLmfhiPded8?=
 =?us-ascii?Q?6ZPfGbEXCMu+UOmq+grhM0CmguiXgoYbFfU4iDN6NM0R9/34jwWqPxarTqnH?=
 =?us-ascii?Q?OPzHS0SC0bNzbox+IADt0RVnZJyk0E+u/QZPkbC0bOhbpA/DwVol0Vl1fokL?=
 =?us-ascii?Q?sD/8lNuTmqTdQhE7o1QU8Om/tEytRNO+8sIGX9WFIhLCJQob3WDYJ0pTFj3J?=
 =?us-ascii?Q?JQMbR/myIpWOmjUcPosX6lKWQO5xBa3B17Sjjx+7tjpyUd8ACElqb1s1R2+F?=
 =?us-ascii?Q?TUUnD4ftS/jRst9L3mHy+DdEjIqehMMik57AsgCoe/Al+YllMosyL2ohS482?=
 =?us-ascii?Q?8tQMMHUJjg25YNDY2pb1+IAu3193OZucL33WH9GyMV3K2L1Ayav8/9qPT5NT?=
 =?us-ascii?Q?EOUhscuhJJgYeIghTi7+iKNLWhD8pCDQ2wnhHRbKGzrvk0bL9C5K5X6nYIUk?=
 =?us-ascii?Q?lKK1ByUfswCPWAJXT3Hgj2x4yP3dkseTMwqQkafx2syx2ChoPNbK89KOtfUm?=
 =?us-ascii?Q?ItCIFE1oM+4Pnsx8stiJP4EPwmslOiFhADaj5wHmQVDyrKk2sNOyj7aQQy+3?=
 =?us-ascii?Q?oPrqSGQ5gB9TiduVFZ6XtfEenZiX/02tpSwTCWcug/HkpvX/qlhzTISHEDlV?=
 =?us-ascii?Q?9CAZHgv+wBkJDLTyc3v+3DPFGjO4j/tOSkTqsJp9h+m1KF4geLP5udoZygGX?=
 =?us-ascii?Q?hU0h4LlTdXwLD4p2qVuj8Sxs61TfSyhM5cnlqDdQF3TjkPiCZvOUJm58VG9T?=
 =?us-ascii?Q?Yqkflg6WNLRhEpBSAEX6ODInl7Z24JdX9OTCwd8qfNiysEtteey7Gh7WTPwd?=
 =?us-ascii?Q?0TUqWsoaTqeubBDSy0kE9ugz33yJph33ccPJR0K2bpt0bWDdaOxKvXTthZO5?=
 =?us-ascii?Q?APFSQ/vyGtbP4XqLGXY/UrAyYGSpr7aVgJ2vxaxXFyrlCtbz9lhAUolTGEll?=
 =?us-ascii?Q?AU4LKP1rhAvjzchpImRzEeNx8DHExglVc/yiSBoYEOm9MzbYYUBCZI1W3AKq?=
 =?us-ascii?Q?FBrYbqXXWy28VO7GYBcXXyrn9ppHsuH04Qf5TEKT6cTEfIb7Pppj23lO+0N3?=
 =?us-ascii?Q?W/ZM651DLLjN508Tpv6ajOoB224RdAdv9uCaD2gyK+qEpIlYGf5FG+8PAT99?=
 =?us-ascii?Q?MU7uhv57QxmQbYQrn2/VhtKkusnZmpgvCOe4PswrRobpWbbrDHr7lakeWMKD?=
 =?us-ascii?Q?ZLdC3sEyodBQ4bjr+3iov3f7Ernh/zW73dOSHdQr9cYMk+y5dbTshAIgkvAW?=
 =?us-ascii?Q?YERoxDL7y0xLCObtclZAImGjdWoNv7m8vwFcrBBeIhpndw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqRINcZHnOvkd9GNnixCKv/4UqFpPabhw/pfX0IhDuH0vYXg9E0CPTnaHYSh?=
 =?us-ascii?Q?GvsJG5qTKRj0A1MMVKpNI58L9J+Pl1x65fxQmbVLHhvFzNQFLaKTd3zhFPsp?=
 =?us-ascii?Q?XPURfE85doIFR8hwIp652Z52E3j7nKLxHUgEqg+Fye6obvQQ5Ni3WNf5BWcm?=
 =?us-ascii?Q?lYaeF7qBzPitMfet7ajUUtgtOIqKyXV2A286ytOBEcueDlSceYf8RTNh6w7x?=
 =?us-ascii?Q?22vs+TYMewC4jF09fugjqCbi/cs7nt/2Ax8UT2d4kNPp7zSZdNiYtfaV0vmY?=
 =?us-ascii?Q?mb7E5YrGJ5NU21l/dElaRqA6Kw37IEoMx7Olg/xJdrqNiTwfO18bRiVN6X75?=
 =?us-ascii?Q?JnZrRWAaxFU0kM5Tms3nYyVlmwvFECURyV45LHwknZdx8jhkxzOll61n1gV/?=
 =?us-ascii?Q?RvlGWuZRcw9fPs8SWo7787M0/d9+Ket167VG9wEszSUyhlelSETKsxtIU+x3?=
 =?us-ascii?Q?bha6/T+aFOjmIIdsRwGhoDo1rTfNSpSrUt1lGPcC33+BjUSzB1/qWerxxa4B?=
 =?us-ascii?Q?E4EXPexJ0l9f9YRmg4wIlCnIscMw870qOYU3O99GkZtb3sGNCEfx3dTOO0xc?=
 =?us-ascii?Q?eP4ivWEf1cjRVIG1D8OUpojz8Me3nNKRz67BLcoBvHvNQSCsqIEavkSB7WMa?=
 =?us-ascii?Q?oT6Q6+40oFRQN3hq7hhhDjCIcv+h9/wsqLexjHk5ZEikH5ePiZ98eTqjqrv/?=
 =?us-ascii?Q?vUvydWStsUwk773iJE+v5cpYeBOQ+BT+iF0DJLctw49/fHd9qKuHWN9osHE/?=
 =?us-ascii?Q?K1Kunl/8kn4O7ysUXFCNi9KNlND2zQfuCu3ZUq7qWt05DyI01VihAYlbb4/i?=
 =?us-ascii?Q?jow7y65Tj61BOLmKWl6uvdC8PMIByZwPIsJVXtVYtQ2i58Zh7eSj5tS/CduY?=
 =?us-ascii?Q?b+z4bzshtsuesw0mh3X0Wtf7Raa3uGEZxOZJi1+mcMg8Aqdu82qg/BHbf1dl?=
 =?us-ascii?Q?JvhyF66jozcu1yn83aT3Y03Kp8HiiY3GL0+93GO1zwsEPTeHhQjk6ZD0oLjw?=
 =?us-ascii?Q?RKHvfvHF/q/YGm7KaoKTODh34xZ1mjL9i6mV6A9eRT9BoeLIyHJ+SMRGCeoE?=
 =?us-ascii?Q?iiQoNrSlFOgSTS9+6aBclZMv2BTmL8C53lzZQLiSsN5LBEEHBSDtFV00+hMR?=
 =?us-ascii?Q?Iqu0f3ddTWGFF54oCPULqs+B5F0SEaI5c7CMGcshSYmsWCkOuXl9cJ8HrXB9?=
 =?us-ascii?Q?r0ecSAkiPnLSCThU52AjgPY7oyAYOgbMXH81fHGaW+mkZAW8cssvvk7QDIlH?=
 =?us-ascii?Q?R1pGq3Ftcc9FtFO426KQRzDaeZ3uQSS56lL0WajG/vzTi5JTmwuCc214O3vQ?=
 =?us-ascii?Q?exwUkQ3S2ETPQD42TA28sFJGb3tHSJ6Yzne4ALt9N7tUM3pg9JeBfUbg+tkX?=
 =?us-ascii?Q?e4XrE7sZqdAvNNXzEnaj1Et0oN1JoKJpP6BsuKlTsNHty8Oe1AQVyyN0uOBj?=
 =?us-ascii?Q?1RrNJ84zkKxwNl1C92L7IrqNDNrmQpgRkIvrSGwf4kK4SC3ZuxdGai7AWNy7?=
 =?us-ascii?Q?lgtZnEMvdDOuWJZ6mm2Y1MiHy9Q62PTS5jws7QerimgUL1EH3rkM1AuzdXMa?=
 =?us-ascii?Q?N2d8gFdy2uvRw3k5CHaHPZnaVr+XYdKgkr0kIWtJbACo2Kb8iNXV35a8B5UD?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HBScJ8z9W+STmPaYpvBufPkhgSnbun5Q8ZLt5Xj7TRFdJlvxUWuLSbBq6IKAHsmUdxboN8ZAgYG/bD7YsVJ1XwlonQB2B9C3wcarJ3XjG9ilKWmv406ykmiacKEl4YUU/X5Q3ir44ZRaxnNzvp8/BVRtQkfZY7lMn1GGTukllsVCTlsd3VpJ4sgwGwt92D1byDHg/lwcqRE9DhJ51WDI1k5v9uk4Aa0e2kvPIXfaBUWmeHvWiD/hthfUwOUEJ43Bowovc3ULY+k29URdyPHIhPgCSfU4H9UcpERbwHj2IJbuyMFR1Urq6Ez1So2/wlseuo7jWa9vbI5yTmqw1LtqXyC0jjhWflvUL0bu6V38oanspKprYunvJIB4BS1eNWYTIM3JdQMS2+gF7IqyQasZi+X8/vKzwZ15vnCvSOUT4k9yeJY+aosQ6Fm+WwYZVgcrdZfxO1vR4H7W908dIxvvfILdoVwTVxw3FTgSrpqKmVoEU9/2Z5rhkYvR9OGyraKkQptA4WWL/Vp3TPIHrsnt1JIUMMPDxm4V35ownHxPOq1Z8wNU5s41+xFaAxU2lhUg724/9W88HNjScb1Wg6+sbGIgeI7Z2DIphpPMt6QZotw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed6edc-12b0-4a39-532f-08dcb62dcf62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:38:24.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhEx4OUvKGyE0A1iq6Z+jwrXWVYqqXkCICUCI6NVl1X+zLqNojafzrKEGVzooupsQhb6g+F88mvlDZQAWiXlcQRbhoA3ZlTmKKoHBQAimS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060109
X-Proofpoint-ORIG-GUID: g-TgRHTLL3nj_85AMn8qyeUvBZqeGYTf
X-Proofpoint-GUID: g-TgRHTLL3nj_85AMn8qyeUvBZqeGYTf

From: Vegard Nossum <vegard.nossum@oracle.com>

These files contain the runtime coverage data generated by gcov.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 7902adf4f7f1..38b7ab9e7dc4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@
 *.dwo
 *.elf
 *.gcno
+*.gcda
 *.gz
 *.i
 *.ko
-- 
2.25.1


