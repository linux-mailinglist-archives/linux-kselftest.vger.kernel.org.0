Return-Path: <linux-kselftest+bounces-14481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE8941EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A41F24DA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D33189902;
	Tue, 30 Jul 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fRVUe9Df";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F616IO8n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960B1A76A5;
	Tue, 30 Jul 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360769; cv=fail; b=DX/Uu47o6q1zQuzL3a4DXFQcxNYG0/rus1/eRwLuv3uFnpJ9nBh0OHYYfR/yBy1riUM+dhZIKoPkU7cjkWUCz4xFs9JAz6uhLAcRuk+WjpxFSCb7Vj5/ecVpkRD0UD6Dnyu+HoO0ED2+FmBIt0D3ZAVMip3Cp34WiYtFvT3eHwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360769; c=relaxed/simple;
	bh=4AA41dRd6bvw1pjRWofTkJUqpV21gyGDhACTGGtMfFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ga6BqTz8HrjBgvOPnU2C6gj7JXAJIFYOyZbFGrAlOf3BUQR5FOYMVsDPHTEuJ8yrfT7q+UgrPZNVlXj34qLxx1Bcpi6e7CP+fZ5lCw47v7owtuoK+w2iqtLNmAbKeFmN1b58w45oQljCPy5d/Gv3f7GxKqEtdB8/SmQS5g66QHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fRVUe9Df; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F616IO8n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFtUNt003766;
	Tue, 30 Jul 2024 17:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=mlc5GVmTP32vAaMFXB2viAnHTVBkgKAkVjLdX4MDjWE=; b=
	fRVUe9DfW6XEaRsmK1tPvYjdL8DP4Mp7tpZ0BUQZBpUP3uVyzxy3Al8YtM6vRe6z
	GUwniDUU/snNqudojmKamtuogd0BmI60ULql/ftWmz7HTgPqgL9urTxQyAoziaBw
	XsiegpUbjH6YbBcxv+BOMRoBlnKeOU2EA5YK8CijQsmzZnTcVINaBbtt/Ee61Atl
	GZ4rrKyenyrlCxwUcLlcJhPDpqYJkmeTQ3lgwSLRI/q7D/dfTIbigR/T6tewbquG
	7vF0qAWvqBWRDv1iU8Nti2MicO7LnxgXzkXY3ggGhyIW4NDXhErVmIZybHycMR6y
	Fq/7QhalnVNQS9eXTNHyag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1wpkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 17:32:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46UGDbXr037663;
	Tue, 30 Jul 2024 17:32:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnwk175-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 17:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqZefKQlRbk2aHW3W9tJ79Ivs6EAsBiuyTXiU6jwxKBY65WOFLc4XjvWHBwn8nELHnN82I1PDen+PvFmn1pjss5t1e20ZHEQ7lnQZ2VvQxz1lID8KbWai0i2TcIYGyexhF8qagxGZYwsjkDNl7lTUNSyQMY3CcchOIzR23O9QcUcjjTG5T3BcQC2jK3Y/r5KDPw5ti9Gcvv8geCn156+4myj6KTCJTe0iwaMxN2SJw2lcx0sxjj11bdz2dLWBHR/b/q81xk9xJquqLYkROsm9NznofyIhjQx5mGke8/QUSQu7WgLXl6mX4jTOYLDeMK7DRaHxzP64nymqeoCmXmLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlc5GVmTP32vAaMFXB2viAnHTVBkgKAkVjLdX4MDjWE=;
 b=vyHFcK8JjSIJylmzBLm43OXipM9JAS+qGLP5ChdZkwLAB2ENAZsfPMyvsLueMNNGSW+3iYat3G5rE4CfYYxBrcH3tdzQQ0GRhiaDlpDus6JCMAFvNFt5GLMjeq8l+aT+B3yQQeH/QEFYaVZ7TEyidgpfmQegPglcQ4DBBomOhYJv0fDddESSrTaL4SppkFgxd/gG2T8oQNE+pZ/rZ4SAEz9K3h9kOTlOndCla3+LjuO7MhLmoiWJ6tXq5blkGou+QBL35DL2fLqXjr4yHaY4nqAjdvcif5OS0xu+zchHrNe5+mlKdsv5I9+wmBCFnSUe1IZxBPUeZZAuZ9KqPCM50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlc5GVmTP32vAaMFXB2viAnHTVBkgKAkVjLdX4MDjWE=;
 b=F616IO8nOg+NpMelB/u3Di+TDVe2NqpdJ+6dYGMfWq30+EPGo0miECOD6k+SOlJbp21oJArCLgEGpVm0q0GTrf9JrZn3EsObPgfo2KjMnkMVtZLhTR996jiVfDgnz9eBD8LsZAyMQiTLWnWtD73dCneyQ016nnjSc3qgdkI7ak8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 17:32:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 17:32:18 +0000
Message-ID: <55aeff56-157d-4513-ac19-fcdba91bc745@oracle.com>
Date: Tue, 30 Jul 2024 18:32:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: do not disable /dev/null
 device access in cgroup dev test
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
 <20240730-convert_dev_cgroup-v3-1-93e573b74357@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240730-convert_dev_cgroup-v3-1-93e573b74357@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3978be-3f7c-4050-b1bf-08dcb0bd8f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmtIODE4QTVLMVc1K2Q2QWN0bENKMVBzZjBQNFU5c1V1TnNEUDNRM2tRZGJU?=
 =?utf-8?B?U3U0aWJJVlRKT20xRVBOcjRFYlFaVUx3TXBDczRTb0UwVEtIZ1BuQTUwcDBi?=
 =?utf-8?B?U2lvTWkvRWN5UlpGZjl3SVhPZVlqMmIyaTRlc3VSQ204YnU5MkNETlF4azNw?=
 =?utf-8?B?Y01JZkIwVkF1cHJxbjNhVXNaRDZRbk15ZkQyaVVrNENvTFdRZUtaeS9ZcW44?=
 =?utf-8?B?Yys2YU5vV3J2U2E2WlM5TGRKT1gyTkd5enN0Q20yR0NZNklqZU1vblZpdEdn?=
 =?utf-8?B?OTNWVE1hWVBMem9tSXRtZThGUFVIdjVESW5EdVRNUERhM3p1NXYrWkl2OEVm?=
 =?utf-8?B?MDdwY3ppV1VTNithcm9zQkl6aW5QSXltUmI1ZEU4NTRac3VvZGxHWTl5Tml3?=
 =?utf-8?B?VVJHbklnODJaQWVPM0xFT25iOUw3dmFTTjFCbFFvY09IRlhGY0QvWXhEbGVx?=
 =?utf-8?B?ZW5iU2lvWWhrK01adjI4RzdjUVBMVnJEZ0o3WnkyMFNTOGlNQXpmOTFSODRh?=
 =?utf-8?B?QW5JZndOTlhwaGJGOEhEc2RQYUdRQlNmMUlxbmNpTHlDa3lxcXpaQzE2TDYz?=
 =?utf-8?B?dndXYWZ2QyswOXBHdkd0UjhxNVhGUWlOTXRtbHR1QTZSa1paaGRCSVhSUzRI?=
 =?utf-8?B?UHUvMXB6aFBNQkdzNm9rQU1XM0dJLzZ0Q0N0dTM1T00yV251Wm1mdFFTMGZj?=
 =?utf-8?B?RnM4ZlBtNWorWGtpUHQ1bzBUZnY0Qk1pRlBYWm5kOXoyMHZkNzIrVThUSTdR?=
 =?utf-8?B?dytsZnBoT0pGb2I1ekhpb01jTTVtNktML0tIbTVuK3JXMDl0YjcwVUN6dnUy?=
 =?utf-8?B?OXlINEtaN0hYcE9idEZ0alhqRi9LSm5yU3BvL2R2UGVlNHZLRzZxS0dMQTVp?=
 =?utf-8?B?V3o0K3VpaVZjSGV2aHEyN2ZDNWM4MS9weTdFaTA5Y0htSUNPWktqb0tVRVds?=
 =?utf-8?B?azZMR09WOXd6VzJZTzg5L3FwV2NQWVZLSXdEazhVWkZYK0RndWl5bStvRUFB?=
 =?utf-8?B?TS8vdUdOV3B5cHdBVTNCbXBnY0NaQVdvaC94TVZvbGUwK2Q3NlR0bXdVVHpo?=
 =?utf-8?B?VXdNdzM5NXFMR3dpYVpRM0NuZUxpNGNDNG1lQkFXRGgzdnJBaTBENXFJU01p?=
 =?utf-8?B?bFlnd1NteHI2Y0cwZ3MxOGJtL2Z1dzNnMGhQZTQ3dEIxYWdXTnFwZ0JDZ3R3?=
 =?utf-8?B?eDByU0NSZW4zcndEcjc0bTdUdnUwM3Y5eWJnY3hTQlY4V1Y0aGEyOFBkMHlQ?=
 =?utf-8?B?dU03S1RDcUd5V3psbGxBMDdsWUFodlVnWmttaVEyc1RVdUpvSFNhYTgvM3do?=
 =?utf-8?B?QS9BeHFzVDhiZ3dOY0tZSnNxd0Y2SGE3Z0dlOVovTzdqNDhCaVNtWUpYRzBa?=
 =?utf-8?B?TjhudWpsSEdFNERSck1RQmJIVitubkpFekZWV0ZGS3BwODFJejRkN3E5UGlU?=
 =?utf-8?B?elBsQ2ozV21RblVyU0FUZ0Fldms1SWRTNHlVaFpUNjlHd3h5UU83NitOMlpy?=
 =?utf-8?B?bzdQc01LNWdyMk5HbEpnSCtNS0d3Sml3Wi9rZUhZSjFlcDVRcnlMeEl3SHNi?=
 =?utf-8?B?MElORWpUUEFwVVErR2lHWjBESXJhTDRTc1Jhb3dvVEE5eHJPTXhPZXk5UmI1?=
 =?utf-8?B?dCtXSjVQdS9QWitBeVpkYStmV0xKZGF1Uy9MdmczZE0xK1lid3ZBeElLa1dO?=
 =?utf-8?B?QnBZU1B1N3ZXZTVXa3BtbHhweFZ2V1kvY2RYemVMVXRYazNJV0dsMWZweHRt?=
 =?utf-8?B?cjlyaUdEV21XemN3M2lXUXl0TzZBdTMwZVFEdGVKWkt6S2c1SUF4U1NQT2NU?=
 =?utf-8?B?ZWk4S0pPM2dOTEtYdWZKYTFJUUgrTlVqRzZpM0xvSUNsZ1ZsSnNDYStseTJK?=
 =?utf-8?Q?WPMoIX/o49B8x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3c2bkFpakdUTC8weE0xZ0JoWEdWc2hYaERHWm5USFFhdlhGV3dHY2Z3Z3R0?=
 =?utf-8?B?N3p0bUtGazZ4cnNNOWh0UXg4RHBZQnIyK1RxNU13bEZiNU1WWlk2cmVFL1Rn?=
 =?utf-8?B?ejcydlZFMm5DNnJFVzB1a2d2V3IyM3RUNS92RlVmeWhEMktraHVMTTJVbXR5?=
 =?utf-8?B?RDJtd3BDWi94clEraTdGWVFmaytCUHJHaURKckxHNVFuNVltTS91WWdDcy96?=
 =?utf-8?B?Z1p1YXZ6a0VkazVqVjlqaVVTdEFlYTh5bXRUU3RKeG9OU0xjUXVVbWQwNFpj?=
 =?utf-8?B?OTc2QXRqMjJQWmJuQUlmS2o2cy9hd2pGbUgvQ0V6bGlhUWpPeFlqeDBkZ3VG?=
 =?utf-8?B?TkM3cFhUMjJReVNCK053dU96VC9rd0ZaR3lUN29IQXlPa2U3NTZNcEkzSFB0?=
 =?utf-8?B?RnBIUVBtVFQ3RjdxWGhzcmZUcFNkTlNqNjJob1NEb2grUDc3TDBDbEE2dVVZ?=
 =?utf-8?B?WGVlYUwvQVEzQzNtSWlhUTNpWkRkbDEyZEJqVXFUMkZkbHhVbGFSKzdQUjI5?=
 =?utf-8?B?V0NTaXdRZ25tR2lrbExzUjFmdXl6S3gvWmhCRXJOdk5RRk5GdklkbFJYRk8w?=
 =?utf-8?B?MWJ2c3lXVFRjdUhWdDBGNEF4VW9sNFZDK2U3a01TNXJFU0o2SEdsWE9ndlNC?=
 =?utf-8?B?cDdkem1XMkNxZGF0T2RPYUF0cXlyYXBtelB1MTRnVmk0TFppV3R5WE1SZDBH?=
 =?utf-8?B?R0VadlFyOW9NRmx6NGhSNEJnQStuUGsxMitSVm1Xd04vamJQRVNyWWJGU2xq?=
 =?utf-8?B?djBCdkF3bElXaVZhZmpVKzJ4ZXU1N1k1QWg5bmFqeWtDYW9jckFRNVhCU0wx?=
 =?utf-8?B?bHhEOEVXQm82eFZDekNveEZIOEVHaWFWMllDYmtoaGpzRGRFQnhHUXZDaU9x?=
 =?utf-8?B?bmZKYktzWFpQdjlQaDRCSjRZQWNuSlp0Qng0dDRsYkptWnUrV0ExNE9VRU5V?=
 =?utf-8?B?KzdnUDRUUXRYU3dmRXZ2Skt1RHlGQmxlVTYxRHVDa1gxLzJLTjBNNXE4V2RT?=
 =?utf-8?B?SUJRTUpZYURrb2tURXBmbi9rUVNreWd4NUJtNHFKdDhnSUxUVXBrcVliSmxG?=
 =?utf-8?B?NXM5dGN1UllBYThkOHpxT0VFOHhETXV3WDRzRDVmWXZ5QVF2STBFV3gzeUJO?=
 =?utf-8?B?OEZ4V0FLYTdsNk5UaFVqV29RS0ZpMHJLSW52U0tQNFg5OEJMMDUrc0l2dWox?=
 =?utf-8?B?RlZLclFKRlZkVjVINDI2RUhSdk1xeXd1OHRUQ3FuLzFNcXR4bHkwWkJSUk8w?=
 =?utf-8?B?L2JQWHFsSVlFM0Mwb1Zjd1pzN3BDeFFDcUhEcUdkeGNxZzNDUXVqUURQUmhp?=
 =?utf-8?B?dDcvS2dPcmZuY3lHcDJGQjNRZHdBWmpWMFNaTTVobUF1SmxnSnZFY01HT3VP?=
 =?utf-8?B?SFJLMlBaMmVEYzNsSklIaGU2elZsbk55dHcrb3krcE54MEJiWFFHYmJSY1dD?=
 =?utf-8?B?QW05c0c3SUhQaUViaXF1aDd4ZXVIQm9JWWJMaEVxeS9zUVVnVFVDcmJtRDZ0?=
 =?utf-8?B?MEpwNG5PTm5rcmVsaTlMOXhvMjI3SzNIalQ2YmJjOEVLSkJXc0VPL0ttNHRO?=
 =?utf-8?B?WnAzb0NucmU5YytBZEVUVWVoeWkyZEJCaXE2WXVhRzBLSkcyVUdxcHVTN0FL?=
 =?utf-8?B?UTNJdk5nZUszd05wQlQxMmhJYThWaTVPLzBRRGJtUDZLQUFHWVM2TTRKc08r?=
 =?utf-8?B?NHdpK2liaW1KRVN1S0VjRTg4KzRhWnpjTCtxQVdWd1AzN3dDZHIwQkg5RExa?=
 =?utf-8?B?aDZvYjFvSjZPbElLVURzWGJoRXJzcTB1YWF5SzRsZEdoN3ZJNWRTeWczWDIy?=
 =?utf-8?B?QVRDZ0daNE1iUE5COHNvNWp4ZFRHZzJHQmk1N09JeWtkZmREOGMzbTNyOEpi?=
 =?utf-8?B?cHFNOHEwS3BxTVF3Q3JYdzlBVEl1L01nbld4eVJDOU1ScDJremFjMVBnajRD?=
 =?utf-8?B?V0hzQXJlN0k2UUtEcmZzamlFTloxcm1uM1B3dk9veGJqTTRVWWtiSWw0dDh6?=
 =?utf-8?B?S3VUM0F1TWV3VGlTRFA1UkxKVXNTVUJYanNaZEFGMFpxbUg1TEZ1MzhUTnZq?=
 =?utf-8?B?bmR2dUIyWjVtaC82ek5yb25adDhKY001MStMa200dHcyY1VxdEcrWXJUQS82?=
 =?utf-8?B?eDc2a094cC9sV0VUK1BIQUpIeUlsRkNXMFlxN1FMMWRTOENiaXZPZC9EZ0dP?=
 =?utf-8?Q?ptMkfar0CHl1mS1kyizi6gw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YJP+qzcbEhcejpZDWIyez6jziPbGJB/lrgWeGM3M70FTCMxViEfNCFcs1Ad8IqZGmvozEcgK4YJWWTeAr+2yE/NimaJX+GTtmHlt7QG4hG3KG0pTLlynF0ry8DxcBwIvTpgQIfrFVokU7n8QQpjo4JnQZ2PWeMSAqL0MiUMKgG6/YxBhoXb7y1825QdKdQE0RoRfgoFKI98LAkps8u82vdkyeI+zZ8cDJt55DqYmcFVGD/xDpUE5+tbDN6LSMSEiBV9c6T212gzhevHZJGbflW/IJ2aC+Ks3KndAyspXU30/2P01fB6Hz0TePC3dfKw2buweBy63nmA0U6SQt4JXcwrtaSNoDJDS5WHxsloJvkDK2Eaz0ulNEJB58uLj2RNqNl7lHES7hqsaBo9gVnNGx/pTo7BC7U7g8sByb1QvJKuZtZeKTJwVbJIcsLO6Tg/QMGPVyFvaMU0VKdpsC26KE5A9ACnCshK1p1JzlHcCIoxLLeHYb6U/EgpvpT0HNmyF3PDk87SCxCnNeSzvnPfnNa+fGpdm0m14N2+bp/fj0edCZHC1WO0VQNag8rn9zTXKwy+s/FGNo0fzitnCOjQ1WoBwOT4zXE3kZwebElFLB20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3978be-3f7c-4050-b1bf-08dcb0bd8f5e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 17:32:18.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6X3iWqBU8f2V5yz3tbI8+gQAv/gv9tFgkfuToTRdHCsgN9mkWy0cfXibyoe5YqsRn5jvABa5lcPs0KEpvYGGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407300120
X-Proofpoint-ORIG-GUID: oI4vRymip6snt3Vm7c5Dls6M49G43FOl
X-Proofpoint-GUID: oI4vRymip6snt3Vm7c5Dls6M49G43FOl

On 30/07/2024 12:59, Alexis Lothoré (eBPF Foundation) wrote:
> test_dev_cgroup currently loads a small bpf program allowing any access on
> urandom and zero devices, disabling access to any other device. It makes
> migrating this test to test_progs impossible, since this one manipulates
> extensively /dev/null.
> 
> Allow /dev/null manipulation in dev_cgroup program to make its usage in
> test_progs framework possible. Update test_dev_cgroup.c as well to match
> this change while it has not been removed.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/progs/dev_cgroup.c |  4 ++--
>  tools/testing/selftests/bpf/test_dev_cgroup.c  | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)

