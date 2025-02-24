Return-Path: <linux-kselftest+bounces-27374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED553A42C3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6137A288C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B21DF98C;
	Mon, 24 Feb 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeaA/g0n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NSyut9mL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DD1946DF;
	Mon, 24 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423714; cv=fail; b=k0Nfkh9Bs+sCzVH/zaXHT412NP0Lk5xhLc10Z9CV6IweAnHz3YksLhNM0j6afq7K9vT5DUOC7M2Yowt5M0gvlMOl+fJbsSwekN0ZdJ+6FjDy/P3q6UMkOs7SCNouvaULRpqZh100hMMfuJDBr4Yp7gTtc4LWSiqxqlaccX9WKYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423714; c=relaxed/simple;
	bh=Bz6rwkLl7jSVb8ZQS19Hsoyva9VldSJGu6xuOIgJN0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IRTa38lkKYTNrLKI/yXGVxkMb7l20hfZisOHrHJbEooxz3Pr9boHwnePg/lVXXX+5Ebyf3xfGuwsGmFgpHoL65s+s5I7mgByRd+M+07ERsGF+S0hnXNbL894qR6SKhQSwS+gpBDSomn0dqzUIZDi3OD6t50BN7Roca8ymLaRgA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeaA/g0n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NSyut9mL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIfe3x016423;
	Mon, 24 Feb 2025 19:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YvcJr0lcT4iujxIdea3ZlXJcZ0XecX1G/RqK2C732fE=; b=
	aeaA/g0n4PlVO3fVzN/RXHVUjKPRwFHMGxffJGP0kFfduf8K/mXDPksj0fo40Nrp
	gchc8skZGnGC6DuLPjfJJIn6qkS7JfyPjnwdTWi4uKYBA1eCARZ5BtkSjKubBfxe
	KQRVoxJMaZfFBYMJTACtY7vCUkQKzRqsQ+zhWqUq+X2eBOOsDuEpDz3WMSNi8U5I
	FkHejJ03zSOCLV2DDMk4G3PSFYBiKlnSBK7lP9OWa1r3bdY+QNx9EPAM4fHX2asj
	6QdYU/iJUdf9Hpw0FDTmiWrVSdBFwr0BDy8H1i1tpIh8tPOGTM8UYGLE6DHphDY/
	BpnPqf4mOEqrQI+3a8SxCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gakc9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:01:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OI6cLc012524;
	Mon, 24 Feb 2025 19:01:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519c1rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTyJkKxl8LfNH5XdFeuuSF/JCJ7/Ug9f4W4I6gALyaA6is/Gpf/fTHw9pO63n9U4EDpro15DmZpy/GBG73Cb9J3YzwCyDmLGoGkUPA5/rs42UHDqWFqn3M7zS891q0uX9pvjOHbto4nd9omsavszB7yKUFGEFLY227TwqcqKGW9lY/y9yJTzxlftf+5qE4BRvSghcnzy0rxgPnI+/Ih9azNfdWOy08paVnNiCxoPIg8lC/Cg52PZK+teDzI+6aG3jvPWin8RGU7qi3AcF+bNlMPX2Z68GRwqd4jup2nrmGvnUEpMfZZJ6ZRBIMg69kEbePE3LnQbZIIDsJ9usnZdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvcJr0lcT4iujxIdea3ZlXJcZ0XecX1G/RqK2C732fE=;
 b=j9X8S3EQl1XZgMMrNu4oaxVLYYERLuTsf8oYa6ol01Jf7VQv/QKOis0QjZ4kC3yMExCwNr93t+drk+Rj13Em4k0NJWYGZOkEWnFURw+Dmr1UXWJBmcE7uQ++ne5+2U8BRk8fHA4ninQEvImMb9qZi6oq5E4x910gqMR8uzUZ/QDfZsG23bsBVH13aVJ+Wm/DpC3X8TvX3fCulS7RPrupwBBz5xMvEUeypdu4EtYDleCfe3iRe0op+nJqCT5W6vsYDiEGvt01MCYJBTtPUsaMQQ2BGg2DZedgmiYntlVcP60Y81YN9KBzpfQ1M3AwreGrGKL/f+k6mbmW1tOExXcWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvcJr0lcT4iujxIdea3ZlXJcZ0XecX1G/RqK2C732fE=;
 b=NSyut9mL+WUlPcAnChMv+lxqXmc685Hnnw0vSZ1AhtzzDlcxlaSMTqE8CxBEoyxU+8Vd66xzf6Uj9btuLOn8Dt++RziiZb2thvKhlVzbfKA8MMtGEsGrqoAYjXWpaps+gZ0QUmwiGXx4KNeGPKOjldiDSDvu3paM0zUrAhIVMcA=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SA1PR10MB7595.namprd10.prod.outlook.com (2603:10b6:806:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:01:13 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:01:13 +0000
Message-ID: <593571c4-39c5-4647-82f2-98094ec9f437@oracle.com>
Date: Mon, 24 Feb 2025 19:01:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
        ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com,
        michael.roth@amd.com, sraithal@amd.com, liam.merwick@oracle.com
References: <20250221210200.244405-1-prsampat@amd.com>
 <20250221210200.244405-2-prsampat@amd.com>
Content-Language: en-GB
From: Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20250221210200.244405-2-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::18) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SA1PR10MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 46582393-0f1a-4ecb-75b4-08dd55059bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NSttRVU4MXYxMGo0S290TnpvNnMwQU1qNTZNRWs2eWhKY3Rva1VmRXl2aVdI?=
 =?utf-8?B?Y0h2SFkwZkxITlkycjFzSmovRjB0QndQT0pBSWRLZGxKZ055czVEaUp1UDNx?=
 =?utf-8?B?bWhPRFkrMzhtQmdRaG5yNW5YT1c4NnFISnA2czlnZE1LVVdUMldUNDFLYURT?=
 =?utf-8?B?WFY5YzlJdVdUT2pxanFCZjQxakF0T3JqYU83NnNocUs2d0FLaEN6Qk1VZHFh?=
 =?utf-8?B?R2drdFlObStIWjROaVVkK1UveDZUaHEvR0U5dVZzMHgxYTk0TE1BaUF3dGN3?=
 =?utf-8?B?bjNIRFhPQXh3ekdGT3lZWHM4cWdGVEZDUk4xZ2dORXRMNFhNV2Y0UnYyTEhC?=
 =?utf-8?B?Q1FDYURBQk41RkJvQzdNMWpCcEhMNEJJVlYwS01USnFoZHBrSjlWQitTWjFs?=
 =?utf-8?B?M1RsYStwZDluZjhtcExmYktUbHVUdXB6SDV2RWRCOXArY28vZ0NIbC9acnE4?=
 =?utf-8?B?M0pnZ05WYUVjSUorN1pycVVIZTBJWldIRVlScW54d2twejRyMnY1aFJQdzlF?=
 =?utf-8?B?Zzc3WmlMQmpRN1pZT2NrYjNEV3JaMEsvM3RNS3lFbkRGMzZqMzJycjJmazNV?=
 =?utf-8?B?anJUUlVIeGYzbjZYY3N5bXNqTGo4Rkp6c1VTK2tLK3hFZ2dOUmMrK2NjOGNF?=
 =?utf-8?B?cU1yN3UvUkxVTVUyMUZDTm0wdkpWMWFWM25iSzBodkxYTHVTT3VUQUV0cHhl?=
 =?utf-8?B?dTRGSWx0TWUyaWU5RDZ0ZG1VaXZMdlhJdlRBTjU5R3dVVTlEK0doQ1E2T05B?=
 =?utf-8?B?V0VPRTlPam1BOHcvVmFtT2RlTW56YjNVS01CekhDbzI3dlFHYTJSUGx2UnZi?=
 =?utf-8?B?TE03NkxHS0c5b3JKSnZQWGlCQjNuSm5uVmtxZHk4N2x5ZXJ2SkQreVdLdmV4?=
 =?utf-8?B?S0FLblk0L25Rd0xCelUzVWVJc0paeDM2ekc2eXU2TVpvMGFHMzdJVzlyT0gz?=
 =?utf-8?B?QnhneXcwOGVtMGxoeVgvdEVmaUd3a3B6Wk83c2dkVGIyTVlKRXR3U1ZTcGJR?=
 =?utf-8?B?U1dWRy9tUDZzRUNMc1czUzkzcVI0b3M1VTNDQzZkcXBBWmYwUFRNaVBCVmx6?=
 =?utf-8?B?eGRKVTdocWlHT2pyQ1g0VWlGRnFKMVBkNHNNd3lFbzNxeTZwbEZnM3BXeDB5?=
 =?utf-8?B?YmNGZmhrakpaZDdtbmtoREZOQmxJb2tKWkJHZHNIaHl5UGoxYm9FY3FrVVBs?=
 =?utf-8?B?cEtwVUZtQWRmR2UwbGExdlVSQ0QxbVErcXNmTlNuaUFWVy9SUFdNdTlRVVI3?=
 =?utf-8?B?R2tYUVQyNXQvV3FHMU14MkJwNkZRYnJhcVkwSWVyZkVaTmRrMDNpV3RPQnpv?=
 =?utf-8?B?NGsxVUliQTM2dEo2K3BPTmtGTmwvL2ZOVDlIRGNydzRrSGVWZXhkazJic0RO?=
 =?utf-8?B?SThkVWJkTU1TU2xmMllPQlVnSFVLVXd2TFl4d2NkVVZodDRGM0hIMExuMW9B?=
 =?utf-8?B?TUxsRDFtdjVyVXR2TFZOeDNvc1RaaGFlNUxHbTdaWmo2bTNMajdYaFpkRlVa?=
 =?utf-8?B?OHViUVl5TlFpVExoL01XbWs0VkZPbWZJUHdWUWFqcHhxM1JMWEF1WEQ5S0hq?=
 =?utf-8?B?Y2VDUnpyNzhqSHpUdTV0aU1PYVp0VXNMNDdRQUhPQjJQenRTNTR4b1NieEZU?=
 =?utf-8?B?UTdQdlFhRC8vakRDOXN0WDF6K290bm1nM2U1K2FsY28rK0pCYlNsaC9LODE0?=
 =?utf-8?B?S2U5Zmw0dFBscFVBZHN4b3hsb3o1ZjVGNnRzWGpmS2dvc2o0UWwyb1ZVUFUw?=
 =?utf-8?B?WWZKTUhYVVd5WkFCN0NpMUN0cmlENkF6TGNHbVA5NkpMZVgrbzZkQmdDeERO?=
 =?utf-8?B?WGxKcklFKzNNZXlPakl2K1BFZnRsUXRXb1lKOE14SGdqT0RsRlJ1UTYxN1NW?=
 =?utf-8?Q?TNGIuj48NkkSJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFWc0dodmU3MUdJMFhEWmp1RnFBa3YxaUYwTU8wYnFWRE1VTjRzZTlpUWE5?=
 =?utf-8?B?eWtybzZ2NUVJVXFiUmxoTHptU3ZhVWRMTU85ZEZoK0FEZU5WZ3pzczBMTWxS?=
 =?utf-8?B?SWhmSS8rUFRGZFM1Z1lEQ2hoTk5Xc3E4OFdUVGtCYU9ZZlBUdnVwL0krNXFL?=
 =?utf-8?B?VkVscUFyVE1XZGpSeVVUeExxTWorajVtOUxwWCtLV0V1K1NiVVBtdExYM29t?=
 =?utf-8?B?MlQyMTcrZkFkSXYyVG9NNXYwYnowam9pTHBHVEVFZmhDaURDZEFlUCtRTkNn?=
 =?utf-8?B?UnFJaTFxMmsvVTZFZjE1eERZOHA2elprVEpsMVpDYWRtcmZOaCtld2RHNTV2?=
 =?utf-8?B?Sy9zYXdCdjNSc3NVZ3M4L3QvQnZQNURTUXB2SWZRb1RicXZqVkhDalJ3c3py?=
 =?utf-8?B?WXczRWlyTXI0N1c3MEY2TG4wMmVqRHc2L2RCOWwwVTlKekJWSFZWYnRwd0pz?=
 =?utf-8?B?aFAzYjJHSk43WDlwZVpKMXBtTHBVY0lRbVdkbTBQd2lPeGx5L1I2dU4xM0p1?=
 =?utf-8?B?bGtKRHpuRklQS1BwdlVFOVhrVTk0bk05UHU0NzR4aTlSekhFbnNtSGhMSC9J?=
 =?utf-8?B?bERyWFVmaVYyTVZMSEMrRlNsUEh4YW9XQk8zMFgzTTF4ZXJrbi8wV1lxUG5n?=
 =?utf-8?B?b2c1TnlyYyt0ajk0ZFVWN0pKNVZPRWdxOVNtaXFqc1RmWWttTDEzU2FXUHpu?=
 =?utf-8?B?RnBqWnhGRERxRkNqd1NVQ0s2cEhsV2srZ3Z0ekVmN3N4dTJxUVU4THBLRGIy?=
 =?utf-8?B?Q1drenc1R2U0cENaOExJRTYxbzlVekxTS2RtaGhIbDNBQnJ1UnFsUTZXOFZC?=
 =?utf-8?B?alNOZEFKN2k5NndyTGYwMzYrOUd2S1g1S0VubGd3TGZHUUVERi9weFhCTGN2?=
 =?utf-8?B?NHQvZXJ4U2JOU1l5RjU5elZnbTJYVnhld01XN1VpY2ZjN3RZVS9uYldGQm1j?=
 =?utf-8?B?UFEvRzU0QjZjTktVKzFkZDRjUllJQ2JxNVdtS3pqWVdUdHBQOTEwbk1uUkRQ?=
 =?utf-8?B?VlE3QU5yckRxeXVHcmVkR0hKOTlBSGdzRU5pajJxMjU5bkdJVEozb1ZUQ0o2?=
 =?utf-8?B?MWd6RmNTRkZRSHdSZW1TS1J3ckNidjVHSzRkcUZ4Y0F6blpPaUdFUm5jZHJE?=
 =?utf-8?B?ejBEM2hzQklQS3d3VzlpRkx6U0pPQWk2Z1kxUHN2K1NWU0ZzNy9jVDNwU2NQ?=
 =?utf-8?B?R25OUEFBNXAyL1Y3NWtkdU0zb2xiMnZpVGU2MHllQ1Y4UXdHbTE1VjFpWWtw?=
 =?utf-8?B?d0Z4alBVV1FuM1hoUFRuRlU3MWhvUy81WWFqVitlRUlmTTRvNS84b0I0SDBE?=
 =?utf-8?B?R2hjc2w2WjcwNTZWUW53SEJEaVo2LytYR0t2eGVTZERZNzM2eXJKOHczcXhE?=
 =?utf-8?B?Q0FjWUtYRFlFOTg1Mm04YlZCdEsyVE1OK0ZJQ3g4TkE1MjI3QXNHQXNVNS9a?=
 =?utf-8?B?eUdNcEVlclNzSUd4RGFPckxnQXFUWXJraFVjaU93ZURPanNXcCtBMUZKV1FJ?=
 =?utf-8?B?dTZQZmFUcXNmWDV2aWJaSEloQ3RIMithaUE0ZklYb2p1enZGSkdCNnZkdFJz?=
 =?utf-8?B?bENvMzZyOHNaNEtNWVJjSHJGdFFLelB6Qm1jWVdaUVZraEtFZnB6aVRJZHM2?=
 =?utf-8?B?NUpHem94d3BIZVhINWI2WnR2MjRPSkNZaDIxZzFKVm93YnUvYXY0QzlVS1hR?=
 =?utf-8?B?QWVLdnZTcjdBUkVXRE5QdWlDMjVySG1sdnEzajdLVzZCVzNPQjJGU2pJNWFD?=
 =?utf-8?B?RVY4TFVjcTVlYXgvZFNDbXNVZ2xaZlArSkdtVVpPNW5kSTd3T21Hdi9KWXQ4?=
 =?utf-8?B?clFkS3Nqc1Jla3hEK2Jza1RQTlNDL0RUUnp6RFNkN2FmYksydWNNUWZyUDUx?=
 =?utf-8?B?dlJ4K1RtdkVjeXp0OGZ4QzNIdE9PUHB2SEppSEVrK2J6UzlGSXNOajgzL250?=
 =?utf-8?B?NGhwMWhSY0xlbGUvM1ZNcXlhdUZWd2k2WlJQYnQ4UldEbENBdThxaUx6RG1C?=
 =?utf-8?B?b0xnSWRiR2d4c3p3YnREeStXYnBNNGtvOER5aHlvL0NGbUhMUlNSYlo4M3pL?=
 =?utf-8?B?VmJQS2xjdFdhWTJ4a1VublBuYWFyaktjOGkydDFxSzhxZkpWUWFndmVsSkgv?=
 =?utf-8?Q?yo4peRJCZix/kdVPcOoFR7c2p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lo/lHpx4NSUPKremyZWAgLQ02qnJfRgXdfyfqXYaRMkbUY9rBAR1BSBqTkCnrsWzLJwbJ0p9GsUYXtCgJYjJMf8CKAZ49BN2De+meLHpJvbZJG6jnW7IkPbNb7Bti5K4QkYzIwqda21tQp87enUfbtBeb55cL8K1inx/7OcoC+WtUNqib88YvfOUf+L2KNf3Mzb/bT2Vw/6TI7SCaHaXU1XiSgmwcKGFG7tW+5+1U86oGavcO00OMOY+AHvgWI67c5VN2pm5m9qaoNR4fDXUSX75JWrl/o5YGSxzWSIBOXbm8LPIz2267Y2Svp3TKdaBAJtNWHDokpsmpF7G0vXDUCrmj9pRgv9+YqodllJi2Tb69t+FNBD1nnZ3Nz2jiLwe97VDh2KY91NciM88cNwzEjBoC1fDzRmfrcloC1uwNKV+N7LAmivPzT1+cAW9zrAw+X1VlVAGp00lZ+EON4EE3OHaXMjegrWauYghfLPnvKQvcdvD6oajZE5ieyBsXD6QgHCFyIR4Ar9ETR6sOT05DaNpu7pYoC/X4UJZXrCNv0+Mp45ItBNK5ffLSTyOrVvqsfNciJp6sDwroPbXLdqrPnSV2d0DES9Wcn/p7LqQst0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46582393-0f1a-4ecb-75b4-08dd55059bc8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:01:13.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0mICgSiBo9KFBvQKawlKaqeCFG+5eE60tV6BYjau1qmFyddjuXsz0EOSIk3psiTwF3gJxf0S0uWXpRJJPuzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240123
X-Proofpoint-ORIG-GUID: MlNIbDfNI48osxBsKWC-OHd8fcfgcVZ6
X-Proofpoint-GUID: MlNIbDfNI48osxBsKWC-OHd8fcfgcVZ6



On 21/02/2025 21:01, Pratik R. Sampat wrote:
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it. Export this
> information to KVM and withdraw SEV-SNP support if has not been
> successfully initialized.
> 
> Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
> v6..v7:
> 
> * Replace FW version check with sev->snp_initialized (Sean)
> ---
>   arch/x86/kvm/svm/sev.c       | 4 +++-
>   drivers/crypto/ccp/sev-dev.c | 8 ++++++++
>   include/linux/psp-sev.h      | 3 +++
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0dbb25442ec1..87b5d63a5817 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3050,7 +3050,9 @@ void __init sev_hardware_setup(void)
>   	sev_es_asid_count = min_sev_asid - 1;
>   	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
>   	sev_es_supported = true;
> -	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	sev_snp_supported = (sev_snp_enabled &&
> +			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
> +			    snp_initialized());
>   
>   out:
>   	if (boot_cpu_has(X86_FEATURE_SEV))
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 2e87ca0e292a..8d2cf8552bc2 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1352,6 +1352,14 @@ int sev_platform_init(struct sev_platform_init_args *args)
>   }
>   EXPORT_SYMBOL_GPL(sev_platform_init);
>   
> +bool snp_initialized(void)
> +{
> +	struct sev_device *sev = psp_master->sev_data;


Should check psp_master isn't NULL before accessing just in case
(particularly for future potential callers).

(e.g. see ccb88e9549e7 ("crypto: ccp - Fix null pointer dereference in 
__sev_platform_shutdown_locked")




> +
> +	return sev->snp_initialized;
> +}
> +EXPORT_SYMBOL_GPL(snp_initialized);
> +
>   static int __sev_platform_shutdown_locked(int *error)
>   {
>   	struct psp_device *psp = psp_master;
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index f3cad182d4ef..d34068c87a28 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -954,6 +954,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
>   void *psp_copy_user_blob(u64 uaddr, u32 len);
>   void *snp_alloc_firmware_page(gfp_t mask);
>   void snp_free_firmware_page(void *addr);
> +bool snp_initialized(void);
>   
>   #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
>   
> @@ -988,6 +989,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
>   
>   static inline void snp_free_firmware_page(void *addr) { }
>   
> +static inline bool snp_initialized(void) { return false; }
> +
>   #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
>   
>   #endif	/* __PSP_SEV_H__ */


