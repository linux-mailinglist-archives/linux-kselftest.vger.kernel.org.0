Return-Path: <linux-kselftest+bounces-14456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD48940B16
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10AA1C23081
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F858192B65;
	Tue, 30 Jul 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cgHFJa+I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OeTj9+gi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639F1922DF;
	Tue, 30 Jul 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327407; cv=fail; b=n+VDS9tvy2GTpfY8O0cmr6LeDGrez1MVvJh1b9RiNBazhzIIZsP5Le+1rYiZL5N+qnyNkkY74897l/tPmrFez5c/CK0Epm+w2O6pOpU4PBkKnW4tXTWLzdlWq7OVfPQEdG3hnjY2gjdYd53FtOg+5Oma3A49KKkoPWBVK7TclUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327407; c=relaxed/simple;
	bh=a2aH9prO1mcdyRxnwNFMw/DhFX4QscrZxdrJ0E5KNs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQ1DghjHNZEe+G0DhgwIsJykpJgRBlj/G7K7x+lLRbnelOSyCHsj12oR8qb1Aldv75JjHPiFm5qVPF+FyaMKR8WfrYNrqFFfvrxM/colezxn+ZyyBJRwsX45d7LS21T8zqlbAydnCae1XiBIpcqRH3jsKK6KWbIR/W6zWVDlVnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cgHFJa+I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OeTj9+gi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TKtVGW024171;
	Tue, 30 Jul 2024 08:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qglqRWJN6jQlZeF7but04/F+U6qkfOru65KZEHAwmQs=; b=
	cgHFJa+ILlQpVmQBedDwFt+MV18GD/qOsFyq/F7s84cbqAKSW/oIBl6oFaT8K8iC
	sAZjfCsk2wX3Ny33cr5w2bckh7KU+1RC7b9gOdzAJzTiD8hTY+WZZPTfC74qZU81
	3xQA8c5sOl2368mf9fDxKJm10GSrRnXpDpT3pz8Z8RWjtcHICGgx+DnglIN8Zjgf
	tOSMbIDk0zvpqf6nPQMtxcuSNGREtRarbjLJqyRuKzrSkd8XTP+AeQLsHTXowjFo
	54NxCrxI63h1YJie+wZfiULy3CclVAwhIDq3XJpo6VP/w/cfJWsGf4Eq/0hmhueJ
	B1Gml3+IZgFEbITOT5syJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxbvgap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 08:16:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46U7UHK5037991;
	Tue, 30 Jul 2024 08:16:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm82wyht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 08:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT4q8y35/Br/BRmapB38Kt/b0bXN2wKd8SWT5K6e+OVUROw/wb52O2GA3demK9/Hx7yZBSo6WDXfWwe2scK6eepd+uG/K6Had5w9SWeSQrksXOiqad7g406BYHHzPOYreHHXaoevxt9qgBVffLLRee7x9zUgRQP9LudeUssdT+MDbVGoupz3KoblrUxFvIG8j7akKusvyBmGrw1SDFizrMG/yXqDB8Tk5mDTw0J/Xfaq5YKo4D583gbPwGy0Q0/+UfEerg9sf6vTIJcP2ROFKIfWXUFdtV3/lvEllL9P7lzBBRl5ILwdIJWEUbxpdj6GQWSwHOLntXBp0/h2Jun6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qglqRWJN6jQlZeF7but04/F+U6qkfOru65KZEHAwmQs=;
 b=AThCvKpEKflM65e8fX+w1EIdldUx5gZc8Ba9mh2suX+vU8Vk83Ldc05xurvlXOwGPsbvByx5/WQfCPpNDK4G0awczHRSomfUIj5XiaIOMYTLEKqV8lbNcvOOc+fcq75r9q9Xpid3AOHuAei31wmTWt11XZWi6KRdfBJIW7diIG2BouNaGqZZ9b1bhIEtv43ERa26G+C8lTnUwrpHFeehPcTDcn0OT9rItKGrQw5mCOtyPU8nZLKinq04uikhWZuL325jmJlyesGm5dsSloIzYANllVYF1V5P67JcwjtPLrsJPRcPSc7ArG650nMl5pAL1hSwGyiAzkm74J4oaW6VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qglqRWJN6jQlZeF7but04/F+U6qkfOru65KZEHAwmQs=;
 b=OeTj9+giw+jTzqvHkbAXpZvRPnC8o+w/znfGPLAz35Vm3albAyB6RGOGj4Xfj0zR2koe6uHG8nnL6UTE7k5RtmAdFwq/LoHvIiSv8ZAG50HWCIk81vNY266YFtAdOKeh2NxdBRfRQh33Efaxow/aVDovghjKExXdL+mDLcBXXlo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6772.namprd10.prod.outlook.com (2603:10b6:208:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 08:16:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 08:16:09 +0000
Message-ID: <012176d7-646b-49fe-b139-c8072340ecdb@oracle.com>
Date: Tue, 30 Jul 2024 09:16:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: do not disable /dev/null
 device access in cgroup dev test
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-1-4c1fc0520545@bootlin.com>
 <39781c99-95db-4c48-b363-a482a426e3b0@oracle.com>
 <3d809ae0-d228-4ba0-baa4-c1b299024c55@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3d809ae0-d228-4ba0-baa4-c1b299024c55@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9316f0-bee4-4f57-8e94-08dcb06fde3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZnaERmWlovcEFDRUx5RGpybUg4YUlSL3haWGJaZ1c4ZXlTZS95dW1VV0FG?=
 =?utf-8?B?V0w5clBLS0xjSkNSTGpIcXBKQ0xxekM2cWpqQk92ekJvNjhlZWlRWXhQTHpM?=
 =?utf-8?B?MXVxNmZDM3dWVTZoVGFiWjVidXRLWEk2QU54Q0RrbGx5WWVQT3ZLM0ZncENI?=
 =?utf-8?B?ZjZTa2U3ell3blR3L0RoY09DWEovcy9NQ2kwbWZTUGhsOGhISUZxMlNjL0JD?=
 =?utf-8?B?dUxMcStMQmRNTU5wemxRTy81QUdsbVpJS0EzczVubWtUV21kR1JuU1JkTTFG?=
 =?utf-8?B?TFJudmhxSkVwcjZBc3hvVmwxMEJYeE4rTXRxSmEyQ21qTkFYdkhPS3RFT09u?=
 =?utf-8?B?dHBzbTl3cHdLd0VEekM2ZDFEeitKUDRhbDBCaG9veUJEdzNJMDZka1k2amlI?=
 =?utf-8?B?OGM1ZDFQTXdpbklPT2QvWkpPOVJLOVFzV2VLcTZvNncvRGV4TFh0UVcrRXQx?=
 =?utf-8?B?QVpvK1dPR2FDb0hNaFZwaFRDdnU4VkRxZUlFejU4cTJDWXJza1R3Ync1WjZT?=
 =?utf-8?B?Vi9mZnE2TG8vTmwzQjNSaTMyMDk3NWx3TUNtNlU3YmtrZ1lEWlVPQklvZUdw?=
 =?utf-8?B?WXpUUzVrZWk4K0dxTEZEMUs3VThFNitpYUpBcDgzR0dySHJ6KzhRYzUxL1pX?=
 =?utf-8?B?eUV2ZlVGNGJRdTZBbURrUVk5T2tyajEwR3pPcEdsN09lZklCcjBXZjB2ZVQ0?=
 =?utf-8?B?dy9XdlRnM2JOcWw3UlpONTFUK1FjQWxDNmhzZG9yWVZTZTlUa0RHSEFNeTJm?=
 =?utf-8?B?S0Q1VDZFRGhIbTFjVEMvdTJYWGFlSXd1amxoVU1nN0JRMG5xelhjUzUweTNz?=
 =?utf-8?B?cDF4WDFESlRMOU5oYW9ZY0FNcHlCcktieE05eE9HOHUyYTFUMmRnZEttSXBi?=
 =?utf-8?B?TXJwYkdtQVBWR2VXeDZQOFJidmxVaDFDR0lmNmlYL1VXWnZxZnFIREVNclRp?=
 =?utf-8?B?am9wQ0tDSlFuMk1aQTVxZUpZbE5jaUFIdzdMcDdwVkYvSGtiblVSWFltVTJt?=
 =?utf-8?B?OUtpeG5xYkFrNjk3N3R3b1ZmeGNQZFlpQ1l0OTZ6WlZ5dEpkQm5Cc3k4RWJE?=
 =?utf-8?B?ZThiODZPQXJ3dmJxT1JXOWxJNllUcGdCL3NXWE9GalArNVMyT2hpcGliY2lw?=
 =?utf-8?B?ekI2SzVSdURKcDZjbVR2ZTBjazRiZ1JlOWxTNmtiZzFCN1VGcExlWVdQMS8y?=
 =?utf-8?B?S3hsVVpUSEdVVXcyNUN5ckMwcmx4UUpwandLbGdWSHdWcndPY1pRQjBpL1pJ?=
 =?utf-8?B?a2R0S1pJbHJMYXB2NGtGcnluUDUxdW5BQzBCT3VIWlpPcDdDZm92aVR1NEJl?=
 =?utf-8?B?UlAzNXdaNHY2cmZ6RzlvYXBmK3BiMDFvQ0ZhOTVpS2w1OWIwamQxZjAwN0tE?=
 =?utf-8?B?THlLWG1NMHpITGNDOTVzeThDZFMvNDh2VjgwVXdGMnlqUFk1QndWR2Y5dndx?=
 =?utf-8?B?dnJUbzBxYnB0ZE1IbWM4eWtzemQzMGJRcEN4MXRIeFIrSTJjbGFmRm4rSWdF?=
 =?utf-8?B?aTBBQTVWeTQ4anpwaXliS1h4WFZRT0sxTThPUWliaG1RTzBDNzg2VkJNWWp1?=
 =?utf-8?B?ZmxYQnlCbVdvN3RuN2JPeFFRc2NSd1gxV1QxZ21EYVdVY3VOSkwyejdaQitt?=
 =?utf-8?B?MWp6RGNLMUxyb0ZCS1BGT1JpK2poY3VDTlhPUWtHLzBWU3ZqaEhQVm14OUIw?=
 =?utf-8?B?WDA1REtuMGN5bUdKTTZuUDBZOUpnbHRlR245cVVRS0V5eW52MFJEUmFjNHhv?=
 =?utf-8?B?bnlYNG1xcmc1ZnBzWlNOR0c4Y1ZiNlE1UDlRNThlcmZDcFZyd1NXeUlEanhZ?=
 =?utf-8?B?MUwvR3dMcWdUUWR2VGc5anJyMlJ0OUdMU3lPUEJlNnl1TTYzQWFqTURuOU1G?=
 =?utf-8?Q?SEyRRAhsBzN8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RtWTNFR1FRNVVuczBQUVI5bjY4NnVqcnJRVnBBYmt1elhsSkJlWDVaaEk1?=
 =?utf-8?B?K1BSamVNQlZUdDNhNXBDQzVCaUxWRURzaGE3YWl6Q085NHdkRHJXdXpUVWZI?=
 =?utf-8?B?TEE2Z09wZGhVd3dkVkFWcWdVUGljeDhFNWEwY2FBUnV4aTAreGdvcHliMFll?=
 =?utf-8?B?dmVyRENxTzR0bTRvcXllWVd3Yk9ZTmVJejVpNEw4UU9SQy82OHBkSzhmMGRo?=
 =?utf-8?B?c2gxOGhaLzRwNUNIbStVNTdVUHJyKzBjbnBBY1Fza25uZjZ3MVk1VEQ0SUxm?=
 =?utf-8?B?ODd4Tm5yZG42UWpoZWZwRHY5dko0R3E4b3pqMUczWXN0djNqNWhzWlp6SlMx?=
 =?utf-8?B?ZEdUaTBrZW10OXdBcEF4ZXNacEc2a2JWN2IrM2Q3WEVRcjgwRE1pamNyL3J3?=
 =?utf-8?B?UC84Y2FaREhjZnBPV1NUK09OOXJCN3l2WDBQWWVkaGFxb1ZZd29OcVh3SHpC?=
 =?utf-8?B?cFJlN1RhZDRsalNGQ0ZwcFdRUU44N01YalVybW1keXUvaG8vTFNvTFNkb3JZ?=
 =?utf-8?B?bDhIcVpCVW1ORjQ4d2s0RFJ5bkJnZExObW5lRGt3N2pYbHRqVm9PU2k5NjN6?=
 =?utf-8?B?c0xRQTJyOHhEQUF2cDZERnFScEhOb0FYTEQxUllNdHlBVnBuRWM2VlBJSXVR?=
 =?utf-8?B?ZWpURmVxdk1SYXh2akJteGhEZFhPYzIzUCtXQ05ibUF6eGdNWHhHNzlpbTFn?=
 =?utf-8?B?U2lrclFKRVZ2MDNNc0JTTWp5ODdpVGFueEZOZ1U3MmVVeWIvUVR4SFJlTU9P?=
 =?utf-8?B?NnJxa016NS85VkovV2FLNFNzTWVqY0lxbDlNbnhMdms2aEVmczhoWGpTN3cy?=
 =?utf-8?B?MHpNNlE3K2F0UzhuaVJHekNuNE14QWpCcXFQcjRoOUZlNnFTd09MQW5vMmQ1?=
 =?utf-8?B?aTdVM2VtZk1QTjRSWjdWYnVzM3Q4VTViS3lFbkhvM2RGUis0bmR6eFYxM3BC?=
 =?utf-8?B?YjJpc1Y4ejZxYmpSM3dpYkNvak9LYldkQ1RGR2RNNjFUT2xqLzdpTG9BNjBu?=
 =?utf-8?B?NFM0WENsOFdHQndsZXpndENKaElNekowV0JNWGxBVHJKVFN2VlNUcC9GUEdt?=
 =?utf-8?B?K1JJY0M1dGhhOGJtc0Q5L3NqU1E0TmhXNFB2bm5FbnMrekFaY0hIYmJjQ3BI?=
 =?utf-8?B?OFdKUW1XZm50T0Z4Rm1CTWxPYitSL2ZDY3RnZW13bGhKVjVrVzZ0eGZkaGxO?=
 =?utf-8?B?VXRqYXpCU09wRFYzTVZ3VXRScGU4WmMweFEwem1UQkxtUlBpR3RycVRxMUUr?=
 =?utf-8?B?SzRhaXE1dFhoUmtqT25qalkzWjk5NU11MmcvN3ZZV0NNek42NDVSb3VCaXdi?=
 =?utf-8?B?dENsUXloYk43S0ZudnhBa0UxSGNSbWNJY09EaDkyb1ZjRUdhYSthT25kQ0lC?=
 =?utf-8?B?WVhPZUtHVjFNdFVNdVlZV0NjSkFXNGhxRlY1QWl5a1RmWksxcFJQdmNmL3BX?=
 =?utf-8?B?MDF2ZXNyZnYxRmZTYjZTVVVxdHlLbnBuRzlVMDU0RCtOVHNZc1JmUnFxTVpk?=
 =?utf-8?B?SGxpYmVqMG1oZWdyUGFYb2VaQlRmOHlOYndXUHV2SFF6MG5DS3ppVjYzaUFJ?=
 =?utf-8?B?a1cvZElxM2xNSGRnMDlvcGhzSGtGN20wM1BBd2xKWE83eDFPb1dxWlZhRGQ2?=
 =?utf-8?B?aEtZdDB4Y2VQL3NFeTNUMTVpMVZianRRNkhuMFNZNzdlN1owQVVpdXB5eGlF?=
 =?utf-8?B?NUUzRkR3azJ5Nzd5cWtraFEyYm10andvQk5iMFdqMUpUZXlpVjl6WitKSnJq?=
 =?utf-8?B?S2Flc3orZXk2c0ZaMDZiS2ZZQU45QUF2cWpyeldmM3NJOGJJWmhpTmNzclRH?=
 =?utf-8?B?WXl0MEZtTVRZbE8zcnFoMDNtREFCS0YyN21SME9SZERxbThrMnJpUW9adHRC?=
 =?utf-8?B?YlZWOVgvM21yM0ZlU3lwVHQzVU01QmI0TEZNd3hFZ1B2eUJIbVJZYm9uQmVZ?=
 =?utf-8?B?NlU4Y3VOK0liZkQ1VzJHNWYxWnhTMUhtK3E2c2ZGV1cwV1pQQXZZYXF0T3JR?=
 =?utf-8?B?WW9ESmppVnNtdnJPaTA2bnB1S1Vxd2Q4UTd6cWhGcEppTDl1WVpndGsxY1Rp?=
 =?utf-8?B?U0VERFc5SXFZZFkzS1JSL1VsMUIzcERWck1jZ1J6YjhnbVBMWWUxVjc0UW5G?=
 =?utf-8?B?L3VhNnVCSFBjb29WTlp1T3gydzNtZDc1ZS9zM3htL3QrTmpEeTlaKzRRYnV3?=
 =?utf-8?Q?rsf8pUTxoXrlQJEeoI9YaZk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tj6DH8ihEVy+XGrJUt89Slvr0gmgjgdV1vTMU2tkDSFkW6bd/fsNujSJHrP2wRJ/GdpSWoD8wuntWG87ihxdg7FKEFOxLk9l6vk5aUijTRU0CJExHi6NU2+ECu6E4hLRKUv9Lns6JRET/m3+2jTr5XC5MVogmSJGB0wXlA8PlQygWB8va8uHxnnj5lpKPYCcCDamVt/Gx/Y8e3Dgzy3t1nNRp68UitiPC7/x7FwpDUZ+6bUN/xkqPdlUEF4duquhXG9t+zxH8SpibKTPqVw+HX7iNklSZ5kyHWbKoqdBJvznOnMyH5xHfI8HCN1CsFmmnmiarlSJPl0UmG2FpgiZLVS7xFie5seWSLyIGkQXGQiEIKHlZFJ/Z/3hJAg3UA9gbGlO7Ct89nU8Tdm9zc8t/AozDGkQInCVovrANqmIGg5gIeb80LnmmRPAwDVrqNJ3ZxvsLY7cnUzO0Z1I7aS0J+E1p2xUEqhqSfL0ZVts0jdw/wnNqvHsX+k/MY7BKJFEK1BDJbiEQNEgP6eV+THRrIjgDpnFg+WmgN+SAVCL67O4/h/GLPHZZnZtCChND/Rz9PR9kbllSyR4nd/35dctmT0PjOMKczRhNFbXYN7mnXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9316f0-bee4-4f57-8e94-08dcb06fde3e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:16:09.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBN76FG9F7DmRBUV16w+h5n8JPVWTdvQeLD8yUrVBBJx+C3IPoeB7J2nUQqbwMGI57h3kUfTk2zgH26H14RVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407300060
X-Proofpoint-GUID: LeTybu9m9a-SjDetYgr8kCchiExoqco5
X-Proofpoint-ORIG-GUID: LeTybu9m9a-SjDetYgr8kCchiExoqco5

On 29/07/2024 18:30, Alexis Lothoré wrote:
> Hello Alan,
> 
> On 7/29/24 18:59, Alan Maguire wrote:
>> On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
>>> test_dev_cgroup currently loads a small bpf program allowing any access on
>>> urandom and zero devices, disabling access to any other device. It makes
>>> migrating this test to test_progs impossible, since this one manipulates
>>> extensively /dev/null.
>>>
>>> Allow /dev/null manipulation in dev_cgroup program to make its usage in
>>> test_progs framework possible. Update test_dev_cgroup.c as well to match
>>> this change while it has not been removed.
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>> ---
>>>  tools/testing/selftests/bpf/progs/dev_cgroup.c |  4 ++--
>>>  tools/testing/selftests/bpf/test_dev_cgroup.c  | 18 +++++++++---------
>>
>> Not a big deal, but I found it a bit confusing that this file was
>> modified then deleted in patch 2. Would it work having patch 1 stop
>> building the standalone test/remove it and .gitignore entry, patch 2
>> updating progs/dev_cgroup.c to allow /dev/zero, /dev/urandom access,
>> patch 3 add cgroup_dev.c test support, and patch 4 add the device type
>> subtest? Or are there issues with doing things that way? Thanks!
> 
> I've done this to make sure that at any point in the git history, there is one
> working test for the targeted feature, either the old or the new one. I've done
> it this way because the old test also helped me validate the new one while
> developing it, but also because if at some point there is a (major) issue with
> the new test, reverting only the relevant commit brings back the old test while
> disabling the new one.
> 
> But maybe this concern is not worth the trouble (especially since the old tests
> are not run automatically) ? If that's indeed the case, I can do it the way you
> are suggesting :)
>

If no-one complains, it seems fine to me to stick with the way you've
constructed the series the next respin. Thanks!

> Thanks,
> 
> Alexis
> 

