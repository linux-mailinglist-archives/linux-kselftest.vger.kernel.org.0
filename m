Return-Path: <linux-kselftest+bounces-6701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA688DB62
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DE31C220E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB44EB5E;
	Wed, 27 Mar 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F6lHahGZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JVoM/TlF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CB4EB4C;
	Wed, 27 Mar 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536139; cv=fail; b=gG9OhsmnjEJI3larPqsmtUa+MtemZvZJz7gLSDbEvfJBgeVKhHlNccmUJOoaDJQcaLLLyJmJ2HE0AVFitMMSAO4fvYycZdWqiUr9Ye0CgCOlto3nztX/rTtYsxHF7h6hx2WqJ14K7BHSkD1+/y8MZ7g8sPSeN8V1aeU4unxa4Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536139; c=relaxed/simple;
	bh=NqD9tPnGHCQozT0zJNwH19f2izHKcjuhvFGfMqEoX/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFeoX9IlYhq5ryB4XoWoD0tFSEWgY4LmTUgAL7eP4glm6wLVyihJxYCfz6ALsJQCFveY1M0vEfSxVMU4NX9Ezm2pw0ru3aBoA8G5g34rj7SJSkOOu31J6E52wlECeD2GJ9UzQXy49P4MCay3UbZ6FiEWcGdtDQ+7/PcXyOd3JoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F6lHahGZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JVoM/TlF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R872nk009119;
	Wed, 27 Mar 2024 10:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RIkUEzpJk0x+kxfBkl9MkloBvsGiYjCraQQF55Qc8qM=;
 b=F6lHahGZCIBEVXsI44rh7Ef4ivmm6XaM5awdQ7F2L94AIJqWMuzscOPsuuzMVKNmAACo
 Yu1k6wYCfuCHT3UUwvCymmQYJwWBCrxnOncI/FFcW01f6qmQMXFE/p68JzoDcEz+dNv5
 f+ZOKZHWmH3Eg7rdk41kWLCCb3j1G24A7BtFJhtBBbmMdNwaJkP48Pv1lWCBQjqcEYZf
 H31dTIudL/0YtRbJ01c6D01GfchU3fiWrp9gnA1ZAznKfF+dA/mTDIZmD0l0M6lYIjet
 D4rXlz6jMGE5xSC1ejlcCC88/Z/EDBQwJDt3Lcwpv4kOnhEZg+vyIQwx18yziHNBCg9e cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy0ghj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 10:42:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RAQBEG019101;
	Wed, 27 Mar 2024 10:42:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhekktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 10:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlkoGsTiKRTieDS9w48qjoxEZtHDIb48IZ3O8U9yxDcmbjpiYN+cbrFmuH6qPNDR2iIfgpJbbSlGErtcfz61b2nUmLpODkmpc7a4G06Ja33o9R8uMqw+v3PdrHOVuVsvZcLTMntDyoVoRi/pemCwH3wGnyoUfcuvQrwyEvgkN9PIw7038jtT2mND9sHuZIqJexmYGCAbxAtHBXWCEjlSZCBuxdfRbSH4C71o1qOaPJnpmdVskXd6RhoIg1dZs1WbBNkT8aGPDFZMAhv9kmCTO71doN4pCSQUhE2H9xkgqC1AcCY/ORaDOLq2UmmqBricygCkbOOsbOaU2yISmTw42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIkUEzpJk0x+kxfBkl9MkloBvsGiYjCraQQF55Qc8qM=;
 b=Qm/x3y9WC21POm1WsOr0TfOFlNtyrLfpiaj58LMkhc9zCq+CVyJUvd+GpJD1vBym7piSCY0VxzNByBSmScZtIA1HMLQgz8Wj2PHBb8b/QLaqtasPIFdr+VJQYGKEyHmc4vBW71JWcqakZ9ESn9VHGXaqIhAQ5fZSg9j25EiJEdJ2k3P1atOu4JjI3/aOPo8PlWVEjzTqky/PV7H+t3lChXCD1EolBuTAGX6MPEuiqP3n1WJlBJJUmo6/guctPcMQfk8dkJRjZxNtnSb7Ct9OxBK1gGrxl6ESVVJe7+SrQNub8R4OaTJOi7n7e44Vup+2jC0gZvCQyytvmoolN17KiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIkUEzpJk0x+kxfBkl9MkloBvsGiYjCraQQF55Qc8qM=;
 b=JVoM/TlFs12fSXGPkw1m7T9rCtF097x0i8DmfKuVvHL72KU/IfQjO4YgDSR1cxSIVBFXC7ZCXqTO1zfL7jFpgb+1OMQshFA3LJdF60aJyRX12oe7GDrJW/Ahx1ynpfjiDGmdBBf9sqoC2sC7Pgo+1lV/bsOrAWsnLDXuQKYNmvo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 10:41:59 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 10:41:59 +0000
Message-ID: <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
Date: Wed, 27 Mar 2024 10:41:52 +0000
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240325135207.GC6245@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: a69a29fd-5ec5-49ab-88ae-08dc4e4a87f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HJrBv4J4948DmESDzWI9soLxiEfNYmI03hQ7dtkRbFxgMbg7+5KXab0Q/YI0S/zcXpIWAsZsW/oM9QwSpeiFnxMjlPqyY0naFODOwDv48kbfJAZv5FIEtBSeukiz4MR4hDfXy+Nfx2y8gAMK16V+apR7bQ5qGQ6SJuYoAdvQwak05F+Aikr4FVcryHHtQb2jDz3s/mVIcy0X12/Rt6HqLI0XfPeeOlzwCNtknA/Gw1KiY2Pe36cT2fM+zdlyTnCiY0H7rru0W+f9zhkcGygYN1n3UC73UpD+LlnQJMeO0VRWdHfcx+AQCbk8LvxhnJVsF5GWYSD8x2Qb/NrDlf8GUE4Bq6e19G73IHYW57Qo2f/3n4uNkl1bXUEg3X00fTXrl3UL+IiRVhqMSu/paKR8/WwSEzOTmuDkyX9axa5HjVIqjL5YYqCN74ePlG9s1Lm1XpdcqFV++CbyX+Ff1GNArRRzt6fQvNeL9uHd1XT9BDJONDNO7UAzPebNi2k+vw88j5mbFgXsgbTSuHhayUGht5OPM4U+dCbSDjzsHebw8KBngZ08Lrf6mEqFv62sHXmEG5My/1TbWt5C1+G2WcnzK3cHUqK2DzzfzNKIxm3/Y/MOyXk3SVKlUhm/pe40LAahyGh9EPj0U0l4KhS5Zh//AuY9CjC7DCEpjtZctVrRIHY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1ZkNjdaZmlkOG1kQVRKWnJYdTZJZ3l4SzZVZjNHSGlDbEtDd1M0VENHc3Y1?=
 =?utf-8?B?d0RNZmNOeFdrOFZYZ25XLy9RdkpIenZvUXFPRUpJd3RuV09LcG5aeTJmZWRR?=
 =?utf-8?B?OHFHRitJRzdLZGRxZlFBRlNISDE4RVFnWit0YWtxb2N4Z2F2NG5jZ2tVMmt6?=
 =?utf-8?B?aVN0SlQyQjVKWWY2dnJTWWo5RkFac0dFZTVva0p5T3owUXJLVjIyRE85cmNP?=
 =?utf-8?B?MFBGdTA3ZThXVGN3dm81eGgvL25SWDE4ZzhGK0g4MDRseGhPQkRKdXluVXNk?=
 =?utf-8?B?ZTNrOWVzWTFuNmhEK2FFRzlSaTRpMzR1a05CZjduSWxob3BPQVB5dHFSQ3hH?=
 =?utf-8?B?ZVJMVnBhQWswOE8yQ0M4SUdLVWplWUlrK2JvR05XYXJyMmhsRDVlaytmYW1L?=
 =?utf-8?B?NlluNlJzT3U3M0xOR2p3OC9GT3ptZTdrWEQraUxRMnUwcC9YYlNFYzh6Y2x0?=
 =?utf-8?B?K2xGbFAwVmJlL2drODUwNGJQRDZndXR1MmprUC83U2lIMjlpYmRndDJwS1Va?=
 =?utf-8?B?b28wV1JkZmZoV3lYbWNUWTBLeDJGWWRzQ0o3VGg1NWNGMTZsYUVKZ2xBemhC?=
 =?utf-8?B?WHcwTklwQ2M2K3cvNTMrN0hPYllwMzEyQ1dweTB1c0dRVGdnNGNDbVNxcGxR?=
 =?utf-8?B?N29WOHdUT1YrUms0RnJkQXlNem5CTmkzVVgzNXh4bDVQaDQvUUtjY3U2bGg0?=
 =?utf-8?B?d1lEakkzSzNoZkFjSkc2U1VNTXdXMVBEWTJ6bFZaTDNscFd5UGczN05lOUND?=
 =?utf-8?B?VjQ3K251ckhKclJoK0hOUFdOYkxnZXJTS24wdkN6NmVHeXo4WEhVcUhaNEVG?=
 =?utf-8?B?WEkwMkwzTk5qRjJudXlBdXl4MksxVWtLNWJnUW1ZSkNVb0hKVUtrakV1TFdU?=
 =?utf-8?B?alRucVgvQW56VlhCQW1kblRPQWF3ZUx3VDFCSFlQbFFDeHI3c3dod2Nza0ZQ?=
 =?utf-8?B?ekZTVFRmY3RsVnliR2syNVArM1hGWjdUUzY4UTVlSlZzU2s2ckdvOFZ6T1d2?=
 =?utf-8?B?T1krUlB4NmJqdUdXQ08vN1lIMlZFb24rWW0xV1ZBTTFUS0Zia2JPaG5UVkFi?=
 =?utf-8?B?c01DMFlUa3hJajB3KzFiT2NGOXBYOFIzNy9XQVh3ZVp3c2N3bnQ4MGU5bVEy?=
 =?utf-8?B?a0hTNmc3L243elFtNjd0cTNaaEQ1VUNJM3I3TkVkaUR2endTSjFYa3pUK2N4?=
 =?utf-8?B?ZEk0WmVoYisrc2VHeFd4VFhHdVdOaXFISjZoU0d3L25DcllPYlJBdzlKZ2p0?=
 =?utf-8?B?N2FZbGNqM3pOM3FWc3JTazV5VWp5d0F4SGo2ak9ieWFLUTYzbzZaMVNZa0wz?=
 =?utf-8?B?bEJuRjNQQm92b3ljb2w2cWxhVlFKdnJkd0h0RjBWeEpWWXZPRUl1NU0weE1t?=
 =?utf-8?B?UlZHbThUVEhZRFJNYVpEV1hoNTZlZFRRSFFRU3RYd29wczBvbnhTVWlhbjZW?=
 =?utf-8?B?WGt0NnFvYnlSV2pjdFcreXhjbGJvbGtLNnBQcXFoWkJGckcxMmJuUVp0WW9K?=
 =?utf-8?B?YjdaME1sT3lzU1NQdzlYMnl2N2VkVGxiNVhSZ1NlRHpGSWlOSzQ3QUtyMmhX?=
 =?utf-8?B?dm9XNG9HSktFS0lBeVdiR1VGUDZnVnVlSm5SR09GeUQvSzF0MGZ1aFhmRkg5?=
 =?utf-8?B?ZjViS2k2VHZNWlFzR1FURGtRdlk1QkxURTY0R2N1cXQ4YTNaakFmQ0ZKMjNp?=
 =?utf-8?B?OHJENnRBTGVPNWhDUUhxZ2lFbFp2bE1iWGt6SjRLN280RUpnc1dkUEpZZFFl?=
 =?utf-8?B?cTZkTk5TZE1HNnYwQ1VPdVZJUjFxRkdqN3FOdWsrQmJVMDlqTXNrMWpUS1d5?=
 =?utf-8?B?NXErZ3NHZ0Y1aVFFS0E4djZjRFNQNUZCSUJnVUhaVEN4dHJWSGN5czc3eGJT?=
 =?utf-8?B?ZDlES3JGbElmQnM5eWJjZFRncGIzYXMzaW82bldIaUIxVU1lckc5cjNvckps?=
 =?utf-8?B?WGxPNFpLdmpyQ2RudGVJRUhSSTYxK1FSMnJPUzY1OHRQamNzQmtSandiQmZR?=
 =?utf-8?B?emVyQ0U4NTFMZVB1dVFXVjNaRzBJTnd0M1hwVGZrQnZ6NmxWdnhobUEwRmFD?=
 =?utf-8?B?dHRvQk51cmNGN3BpaUJST2lrbW5HVDFCNmNLdFJ4TGh5ZHhXVTRpVGhLMHFN?=
 =?utf-8?B?aU8zaXhyeVJPSmVFQUJ2V1dvdVB5VzZjVndLSTYvZmlDRGVJNkJiQUtRbXhx?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0i7B+BuwcdlIrKKymbN7UC0pIjH2VcZIukINYhrA2UqA31SeoZvI/tbkdCOPiqolQKIA2czL2MCeCfk0vGicmyNfQkoE2KjAAXu+UQ+XdsQLCBzU23WHciNHQmSeb8auFwbNRk16lPs10GVYho0C/kFzYu6EAk07BFP/G+TKsc+tXNc4M6HvOvtobr+GnqSW+69azmER4xZLvAGy20SslvXeT0/2zNfrgX6LWjKyD67wi0DU6wQzpJtgdMwAo83gS7a1/Z++iKtCYdulADPtZbflYv6Drkd3hqzXsJfo7tA5AewN07b1mq4pLo3ZB5Pek58rmgzhoe/Qwy6e0cZ9mDYCmn82FPJz8BuWq0xJRwbjj8TWPiHC5fMo1SSDo+25SzD0XQyG0ELJZNMuy3v3bT9GRp5bXS6qR37OaZno9K4ISi4uKY58J3vI/d8au5VgANScMWSLONffjVvYOQ1nvQD7yBfjUtN061/cFeDHazegwLissO58KNCRSuzKJIpk729tSbHMUsP4RzlM7fIoIt6skHCAg+EUkuRLWJs3mYmZ//G6HKW+MCIe8p9uzRGouRiqUGFve5RsLwXCcUGz94HKTRzdFhnolip5hvbplNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69a29fd-5ec5-49ab-88ae-08dc4e4a87f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:41:59.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzWTfiWVJssEo9b4pfuN0l/Z5rF+IuuzU5DMVxYi0mONHcKaLXE8tDJINypwASe9UfYs5L2i1m91t7sQiydfr65mKE6Q1CCXiyesOfYwQPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=958 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270072
X-Proofpoint-ORIG-GUID: dTh7GlRS3DGOt-bxsTnzB4fSlBFzb2pq
X-Proofpoint-GUID: dTh7GlRS3DGOt-bxsTnzB4fSlBFzb2pq

On 25/03/2024 13:52, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>> However, I am not smart enough to figure out why ...
>>>
>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
>>>
>>>   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>> PROT_WRITE,
>>>   1748                    mmap_flags, -1, 0);
>>> → 1749         assert(vrc == self->buffer);
>>>   1750
>>>
>>> But I am not that deep into the source to figure our what was intended and what
>>> went
>>> wrong :-/
>>
>> I can SKIP() the test rather assert() in here if it helps. Though there are
>> other tests that fail if no hugetlb pages are reserved.
>>
>> But I am not sure if this is problem here as the initial bug email had an
>> enterily different set of failures? Maybe all you need is an assert() and it
>> gets into this state?
> 
> I feel like there is something wrong with the kselftest framework,
> there should be some way to fail the setup/teardown operations without
> triggering an infinite loop :(

I am now wondering if the problem is the fact that we have an assert() in the
middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
other kselftest macro that). The expect/assert macros from kselftest() don't do
asserts and it looks like we are failing mid tests in the assert().

Maybe it is OK for setup_sizes(), but maybe not OK for the rest (i.e. during the
actual setup / tests). I can throw a patch there to see if this helps Mirsad.


