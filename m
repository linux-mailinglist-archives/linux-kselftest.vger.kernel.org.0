Return-Path: <linux-kselftest+bounces-28826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05529A5E109
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF9E1881768
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D9253322;
	Wed, 12 Mar 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDjDbIKs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FItRgatL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6218A6A7;
	Wed, 12 Mar 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794669; cv=fail; b=H+Ddqnp3OVYzaZ69VXw3LNoAD8UsLtvH6xHOGaLJx0VHbdLZMUmtCSVn6dv50xhZMOP7u/a6vb8WIv8ooIAqce9gFbvepmGIpPDayrCD7XUd1jL6QCpk/D7j3+M1g0RwFGZYHuqxqutY+Y7gpdwdZFjLW6dZWK7h6HgR7IjY4n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794669; c=relaxed/simple;
	bh=RKLNoUOQ7KEOuZ95qt6r6KRsSXsSevnP8RhQc20m36o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjY8sc/cffPNHkf5O/vQlidEsRQThF01SHAULCJun1yvCzKDwuZbiowl6QItd8D9WU6gDF9GjL8RQUdA1abTGCC7jy5LYnhCBqd2mYol9/8r+8fNW0w15KigNf/968/0idQkjVG/ibdCu/A3hxyMnkg7S3kEK4V0z/oHwR/E/t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UDjDbIKs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FItRgatL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCEXtZ025269;
	Wed, 12 Mar 2025 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k6iYwvhxYUyPeAlBGAZLhsrbdLeLXaCXB23z+xipcTs=; b=
	UDjDbIKs8c079fz+VXHwxOiFkqgs7J1bd/C8FBf+QDE2Bp9qo/fYsek9PUbDKKWy
	xhx0m6eiF/Fz7LToUaHF51FKZ1ujaSjINq0Rcc2/VyDLruOPU+k42Dcws8KTO+J8
	fwo51jOjAa5Vow2RUGkBlHMX48rCY5iLSRXZ480p34wccOb39xBEbFhoQW8Phr9b
	Dk16Ce66jytKVHdY70+hlVrKYqMKQqzkbC25HcAzyajfF0vU/H7OYukCYiSPV8am
	ioyz1UaLPnVhshmxqNNWlEin6CUSh09Of3eFrZwd1slRM/gpGVhlxAq9UVEOOEO1
	QlbrsvDLEIKqlst/RjjRkg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dt45x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:50:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CEgtGp012293;
	Wed, 12 Mar 2025 15:50:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn1ese7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3y924t7oeKy8HEm61ZobFmynN9HGKTnqRjpfe87CzCj5fjWko4sXexwH0fM7iYCW+RKS6lTzvhTEMxyhL++gKW2+DGn31YBVnGR7OL0ivRYtRSCp8Y+WRwmmUiEbkoaVjCoblXALNMK8gV/egCaclcpXm2sFTB7JaPpzL/Uaol9ZV4dO+py9lunfxhNqXGW1lon3tzm1Asc+cTGEVeG+H0FDbT1OSjO1BsBRc+mCydk+VuU6K/hakpKUCwjfGpTynvFJYe9EuZMGHWht+N3MF0BEH/Zcpt3aRMz7Jc9uP9rlCnFMYOxyxD/NbDIPoW9EwbUR7m9k1pjlmLYmezzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6iYwvhxYUyPeAlBGAZLhsrbdLeLXaCXB23z+xipcTs=;
 b=rfsgnS2vKaSSRTARH8wTnos3VZAIBXbHgKwup9ARhKYBos0WmR/GXJJ0H1d2YXvuIhAlaKB1BMKIP5jwzSQXVj2mq+bXCik8zRMhhi1bi8rPgOFx9GZHtGen/OkZeB0lPtEd93esZcEPvnPCFJFUgGaQITaY/Sx6lyjLtACEKAJZ2TX/oxfTEjTrKfkCGpYXhdBKEvPznYR1TE0pdZfRkncSGI2o/3PdXUnM5yq9QLb4WUwHWlAxs7bVNa6z8HrvxvvGszWEuX6aDyH7WRe0U/WFZ08+Dvc1k8diG1w/XvXxOzVvrJDr6Ar7Fy+n8H5tzXhRKTJSuiLJWXjaSyVtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6iYwvhxYUyPeAlBGAZLhsrbdLeLXaCXB23z+xipcTs=;
 b=FItRgatLjnBDie+mXKdMnvcIJ0pbgmGIbltpeSB/l51RgHekehWHGrhicA6lVMYYeutGEKDC3d4f5/WClR/NJrCLfmw46b9J2UK8EnLeB4TZOGjowfEy73y9AWusGLGGQ05WS0qeoI77vwBGgftcPITd0+C4RlRQIMPJZSVhOeI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:50:43 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 12 Mar 2025
 15:50:43 +0000
Date: Wed, 12 Mar 2025 15:50:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, keescook@chromium.org, pedro.falcato@gmail.com,
        rdunlap@infradead.org, jannh@google.com
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Message-ID: <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local>
References: <20250312002117.2556240-1-jeffxu@google.com>
 <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
 <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: c58465e4-41eb-4d64-5379-08dd617da56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjBjdXF2ZDdiZk9NTlFmdVJRQVViWUIvb1pPanNMWCtlZzRZckJqN3EzVlEw?=
 =?utf-8?B?ZmdYUmtrMzBhQ0YvTzJFSjFnSU9LYVdSTVE5K3FyNDR4Q3Q3N2NCVThySnZO?=
 =?utf-8?B?a1dycjNqZVgvUldQYWJOOVFzb2lXSmk1dEdpR09BcHprMks1d0tpRTR6RHFE?=
 =?utf-8?B?VWRHOWFUV2ZLbEc3ejgxVnJrY21qRGVWaXVnNVVzYnI3eXB6ckoxQVpzM1hK?=
 =?utf-8?B?YStQWXh5MTJrYW5oYzNLcXJ3QStCbmlObGFKRjBZYi9qM1FRT0Y3aHlmSVpj?=
 =?utf-8?B?S1hEYW11dGwrK3FtWit2M01TTkdBOUxMaTgzRmMrUC8zcFYvcW1FZFJwQ0Fv?=
 =?utf-8?B?bFVFZDhwY1lqWGhEMEtndkF2dVpyakpGL0tvVWJwV0NrYVkzR284c2QrZzRu?=
 =?utf-8?B?ZkMydlplL05pVUpjNHBlZDFnLy83dEVNeG5NSEU2cVVPVkdxN1hwTFk0NFV4?=
 =?utf-8?B?VkE2S1BFYWFydkV3S3gwdkRhNHdkNmNjUzU5eXh4UDh3c2tnM29WTGk0YWFx?=
 =?utf-8?B?N1V5UW1KWTZGKzZvbmhwUmxNZG1JK3JZS2tYQ05GWlhRL3RvcGhyQ0RycTNY?=
 =?utf-8?B?SWhscFBaK3Fmb2NOR3JRdERDcEwzOFR0Vmpodk5heXNNeVFzNGZUUW5VSGdl?=
 =?utf-8?B?ZkJGR2hpdStxbDRreTN3OGFUMXVidGJTYWRWRnhsbWFrRlFMRDRrdmVnQWx2?=
 =?utf-8?B?R1U2eGFpS3RXVXpNd256OHVUQjZkdDg4SHdTL0krc29lS3p4WEhPRjlwMkdR?=
 =?utf-8?B?MXFwQlY1S056bmhOYmIvOWl0Z1dXc2pmUGJ1QmoxSjJUQXhSMGpOdk1LeWtr?=
 =?utf-8?B?N3N1UFpGYmdkL1c2VWhOQW9iZmo2cGJDejN5bjlLNFVOM1NKdCtTall5TFJt?=
 =?utf-8?B?RWUyUjlMdG5oMGk1S1dZTzM0NWNNVE9penVRa0Y0b2kvdTJUU1pSQVlqSURL?=
 =?utf-8?B?czIyRHI3c1huTDQ2alp1T3pyTHN3Y2E5bmZDSnMvZTJLbWFKRmdmSHpYVzlQ?=
 =?utf-8?B?N3llRHVJQ3BvcnJlK21MaVZPenZYTXZWbHVGR3RVYnZvL0ZHNktQelRYSE1v?=
 =?utf-8?B?VkJzeFliU052WVE4QU9YRnpkYTZQUEtrWmpURFBYUnYvVG4vcEMxY0VNSXlF?=
 =?utf-8?B?YjN1QkltNFBBNUs4WnU3S0hSUE5FTVByZThMSU11UVI2NDVlaFU5ODE4UGxI?=
 =?utf-8?B?MlBpSS8zaTlPVm9MNGtnVkFzMGpaWTg5N1hSRE1xRWhuaG9GR3AzZXpCblky?=
 =?utf-8?B?TllMRnZGUEVwNDNDMG1GV1lSMXo3OGQvTTJUL25DQjlIYTRCWXhDTDkxdGdR?=
 =?utf-8?B?b0ozU2RpMHNpajJzSEhDNHluMnJLMjgyWFNKQ1M5V25IWm4vN0N4UVExeUc1?=
 =?utf-8?B?OVR6RUw0M1lnREdyU2IyRjd3emROcWF1V2I4eHlyQWw3RXRSU1grK21lbjJ1?=
 =?utf-8?B?cDJreG51bWJYRk9xa2ZoRE9kQkNwQTFuMEkrS0lXVm44KzlWQ3k0V0VFdCt4?=
 =?utf-8?B?MGVCYVhQUUFZYkFrWUZlNHU0NVU5WE1qU3BCcUpMbDlOYyt0eGVtSU12bGpv?=
 =?utf-8?B?aGVjTkN6Wnd1Z1BmdXFnYnZQUWRSRlJjNGN6M1d3WHN3YVNEdHNFYU4zclZp?=
 =?utf-8?B?RGFEcjMwbTNYMEhPTFIzZFdyd3phNkR3bGlLMFZBeU1TY0FueWVSaWR6N2JZ?=
 =?utf-8?B?VEZsZ1RFUldSdjQ5Q1BsVWJKVkQ0cnJLVTRWeTgvZlU3ZWJPcWxwRVFJdnZs?=
 =?utf-8?B?SVg5WWNDeDU4RVFNTTdGdlR0L0dTQm9IdlQxa2MzbERvTkphK3dMY3dtRTFq?=
 =?utf-8?B?MUxERmhZL1hjY21jQ05nUHJ3Y1BadmdJS1N6Z29sODBPd21DcXNHWnVWcENN?=
 =?utf-8?Q?kbVg7N1ip2TiC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZOMW1tMFdhQWhJSGVUQ0ttVzFXRUJYWUd3Q0I2eGkxZDNiRGQrM1dJelNR?=
 =?utf-8?B?R1J0L2VQZWh0MlBIbUN0WWp3d1FYendJdzUycnpORlc1VXdSdzdsVXc0UUpH?=
 =?utf-8?B?UnRlNXdsS3JzaDhYWFFXYUtKQ0wxRG53R2p1ckRub21wVGJGWGp6bFNXcDZ0?=
 =?utf-8?B?ZHpCazZLM3REUUI2Z2I1YjNrcjY5QS9ZK0RRVFFGU2pQOVQxVkkxeXRwSkhE?=
 =?utf-8?B?VE9GNWR0RjZyZkRSdmJyTjZFZnp0QU00N3QyMU52T1NhdDRBT3c0UzFGUFdn?=
 =?utf-8?B?WjBaM3V5WlVNeXE2NU9ydmNYQUttdURJZTUxcXRkcEkrMWhJYU9xVkh2NVp1?=
 =?utf-8?B?YWVjTDhNd3F6aExkTG1vSVI0RVQ2UTRrcHg2a2NyZnBSVnorM2hBNGt6dHNt?=
 =?utf-8?B?QkVRUVBBMFNsTG1QUEpBREpmbmRMSitGWU9Nclo0ckNyU3F0VlJyZlZQdDZD?=
 =?utf-8?B?QTl6eHBMcHFLbld4YnMyWjZjdWFWQzdkTUI5ZGlYS1RBNXlmSWdlSUtTdTdW?=
 =?utf-8?B?MDM3SDUvWExoY3ZTVnF0NkZDR0VDbjJIdElhc2dUK2dqM0haZlkyTnQ5dS9T?=
 =?utf-8?B?SGZubkxZdVVvMGhpT2d2akNTVTlCWnlrMGJqOE1PekZSR2I3bm1kN0NtaXJY?=
 =?utf-8?B?RWFZRW5OZjRteHRoajEzT0dVMXpNL3NwN3NMa011dklna3NSNGg0QU8zZ2Iw?=
 =?utf-8?B?Rk9IcnBRcGh6VDZyWnpXNE1Rb3BZeGRiSjNKczg0WWhsS0lCUG1VMCtYVnRn?=
 =?utf-8?B?UzdCV0hVaklRZnJGdW4zLzEwcytuL2o4K1c2cE5WeUJMRXo0N084VGYySytF?=
 =?utf-8?B?OHpicWJsdlkyb0NJYlFzeEUvTW96cVpuLzJXVzdIcXRUUGdKbDlObFM5VENK?=
 =?utf-8?B?TWxuTWJZQVV3VjVsSzRoeGphQmNOS0J1NUpqSEQyMFZIV3FLZng4UzFvRzNV?=
 =?utf-8?B?SHpaNWpvYldzQkhMRDA0blRjRDRORkIzZ0hFYURwdG1FUTRkV3dBQU5TTjFk?=
 =?utf-8?B?NmxjSXZ6NmFCeUZVMW4zcE5HZlFkb1A5OHR1RXBrSzQzTklIUHJqRDJQU0Yw?=
 =?utf-8?B?TkU5ZVpTODdpc0dBd0x3ZEg4OEhRdStZZzJ3UlZtVkpJVUY0Rmp2RUV5dnRh?=
 =?utf-8?B?Mzc1eXh1Q3NTUFh0Q0hOdGF5a3lFZ2s4Z3pIelZaS2dxa2VSYk95WEhHbUhU?=
 =?utf-8?B?Z3p4aDRSb25NMjZuRnNRakVscE9aa0czZlZ3ZXBvNHZ2c3pOWHJtcmJwQ2w1?=
 =?utf-8?B?TUFXaUVxN1FFR2NFU2JVT3BCWHR4K1dVb25UdTZPYUxoQ2VZTHVUa3J5Ny9s?=
 =?utf-8?B?MVdxWG55SXUyMi91MjNtR01GdGpLSnNSMy9EM1psMlFmdUFpK2puQm1aSmJM?=
 =?utf-8?B?TklTR3M4ZnVFUUZiT1RZb0FvQ3FQZ2tYMjhpejkrdERpMTRrNTNXYWVWUGZq?=
 =?utf-8?B?eDYyUTBMa0l1Ui9KYTR4TEhTTGZQbHdwdzRpMlI4OW9idCt3Z3NYNVd4d2Rw?=
 =?utf-8?B?REF6MWdFbHFYYjJCSXRmaHc4K05jS20wLysvV2s0bTF1UFZ4S1FDUTQ5Qmxn?=
 =?utf-8?B?ajl3a2pwd1p1Qk83LzE1bGg3Z21XRS9VMlBvbWQ5SGNCbWRabnZWMzJjUHF0?=
 =?utf-8?B?SllZeXJaTXNCNnFSNnJTUlhteW1mVEdJVFMxNkszMEprTzJJOW0zWWpvMGJy?=
 =?utf-8?B?a0tCcE0xNFZiQVFBZ0ZWeHh6ckNrWlRDU211M0RJTWIrUjUyT1YwOXo5T202?=
 =?utf-8?B?V0FKMUpQQVZBVXcwRTlWYnNSYVJaWjA4cmZiQ2hGWlZjcUlCVlNpZmUvaWZu?=
 =?utf-8?B?c3UvVVJvazd3MWNIZGpnS0FBWDh5elVmeEhnaDE5cHMwcGp4cDNOUUFEYVZa?=
 =?utf-8?B?bVNNaDIzcnI0V1hqZnE0MUs1bkpsY0Qvc3cyaFdNNmlTNVlQTVlaN1M4ZUov?=
 =?utf-8?B?Wk0xU2cwVVU2WFo4UG45dnNXU2lkNnhDVXovbUtMdUE4Z01PeU1mVHhFaHAx?=
 =?utf-8?B?MkpVNVB5K3FnclloT3dCMnVCK1JIcUJ6N0FPZUpBS2xQWUtkNGhjS3NUdUdZ?=
 =?utf-8?B?c2RmTnVGbE5QdGtTczcwRnM5QUNMaXZCbE40VnZXaUw1MWE3dDBIVi85N3pD?=
 =?utf-8?B?RDRMVTY5SjNsNDdDR3FYRXp1bVhTR1o0SkxGMzBzUkttVThNdVpUdzhpcHpk?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EnHkY1cMixZBHbr8DipXH7f/nh+Zv3MUKkZy6janMEh/tAxb7+NsTKf41BhS4ci6lzJvifJJmyUacszQPs/44Ssw4ue6w9GH0X1Af8/QPiiFe01hdE3HjMB3Owf8T4hVHUsV+vPm2je8oP2JfBAum0uY+OLcMeqbCozqL0z7ZSPsSvodDn7HxNLzATTNKSGw7oCg54yC0ywYxhOVB8ky5EX7Lk5kPvJTNw6TiGcBq3NvFNg/0vsIIBGAkxsra1qrkpNMUJVaTnkmjzZ155Np0FdowGp+8+29OW9yBYHp0r4BZ8tEuexRfXOV1tkjcf+tdrLxDF40F+dxoXGt7KqGGwCb96vyH59fIFYhP3FQ9iRapGMSYL7mrNiQFVQbLVxMc2UrbehLpUQ3RcMTsfcD4TBKHiscVDN2I4dRq1hTF2V2MkviYnpmuPadMkqPPlc55OdyT6AjoDanqMTjQT9VhQ52qT9GPudO6ReFsempOgGcWCKx4uA3dK3/PRamXi4T+nFxt+Zt00FENRTijqBTlhX6Bi4dmUX0yNqf+a+yTUvG0eIWnY1Q45puOMYNxhFMbBALi5VH+X7sFuT7tZULp6wFjNVmCG4nbxFXfIwxipQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58465e4-41eb-4d64-5379-08dd617da56b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:50:43.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v09gOYjVcTTQDjes30SOMKEj8C5HxpoC654seowJ1tvG0Gnk+Qm/o046QDUlsFGuVod2pgQheSCBkPrUs3l3eKVRvdO6HuMucINA011gVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120108
X-Proofpoint-GUID: t2b6vg9ZRRteJB0nhktlDfW05lMNTcHv
X-Proofpoint-ORIG-GUID: t2b6vg9ZRRteJB0nhktlDfW05lMNTcHv

On Wed, Mar 12, 2025 at 08:27:57AM -0700, Kees Cook wrote:
>
>
> On March 12, 2025 6:49:39 AM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >On Wed, Mar 12, 2025 at 12:21:17AM +0000, jeffxu@chromium.org wrote:
> >> From: Jeff Xu <jeffxu@chromium.org>
> >>
> >> Initially, when mseal was introduced in 6.10, semantically, when a VMA
> >> within the specified address range is sealed, the mprotect will be rejected,
> >> leaving all of VMA unmodified. However, adding an extra loop to check the mseal
> >> flag for every VMA slows things down a bit, therefore in 6.12, this issue was
> >> solved by removing can_modify_mm and checking each VMA’s mseal flag directly
> >> without an extra loop [1]. This is a semantic change, i.e. partial update is
> >> allowed, VMAs can be updated until a sealed VMA is found.
> >>
> >> The new semantic also means, we could allow mprotect on a sealed VMA if the new
> >> attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
> >> impacts for applications that want to seal a particular mapping. Doing this also
> >> has no security impact.
> >>
> >> [1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/
> >>
> >> Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
> >> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> ---
> >>  mm/mprotect.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/mprotect.c b/mm/mprotect.c
> >> index 516b1d847e2c..a24d23967aa5 100644
> >> --- a/mm/mprotect.c
> >> +++ b/mm/mprotect.c
> >> @@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >>  	unsigned long charged = 0;
> >>  	int error;
> >>
> >> -	if (!can_modify_vma(vma))
> >> -		return -EPERM;
> >> -
> >>  	if (newflags == oldflags) {
> >>  		*pprev = vma;
> >>  		return 0;
> >>  	}
> >>
> >> +	if (!can_modify_vma(vma))
> >> +		return -EPERM;
> >> +
> >>  	/*
> >>  	 * Do PROT_NONE PFN permission checks here when we can still
> >>  	 * bail out without undoing a lot of state. This is a rather
> >> --
> >> 2.49.0.rc0.332.g42c0ae87b1-goog
> >>
> >
> >Hm I'm not so sure about this, to me a seal means 'don't touch', even if
> >the touch would be a no-op. It's simpler to be totally consistent on this
> >and makes the code easier everywhere.
> >
> >Because if we start saying 'apply mseal rules, except if we can determine
> >this to be a no-op' then that implies we might have some inconsistency in
> >other operations that do not do that, and sometimes a 'no-op' might be
> >ill-defined etc.
>
> Does mseal mean "you cannot call mprotect on this VMA" or does it mean "you cannot change this VMA". I've always considered it the latter since the entry point to making VMA changes doesn't matter (mmap, mprotect, etc) it's the VMA that can't change. Even the internal function name is "can_modify", and if the flags aren't changing then it's not a modification.

Right, but here it's easy to determine that.

What about madvise() with MADV_DONTNEED on a r/o VMA that's not faulted in?
That's a no-op right? But it's not permitted.

So now we have an inconsistency between the two calls.

Should we now check to see if all the madvise() calls are somehow no-ops
and permit them? Because that gets potentially egregious, fast.

My concern is that we set a trap for ourselves by establishing some kind of
contract, implicit or not, that otherwise-mseal-prevented-calls will be
permitted if they result in a no-op.

To me it's simpler to say 'if we touch a VMA with a call that modifies
things, and it's sealed, we abort'.

Easy, doesn't set traps, no reasonable situation in which that should cause
problems.

>
> I think it's more ergonomic to check for _changes_.

I don't know what you mean by 'ergonomic'?

>
> -Kees
>
> --
> Kees Cook

My reply seemed to get truncated at the end here :) So let me ask again -
do you have a practical case in mind for this?

