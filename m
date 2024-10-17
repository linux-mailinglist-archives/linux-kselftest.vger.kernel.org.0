Return-Path: <linux-kselftest+bounces-20022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159B9A2C2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102CD1F22425
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAA1E0B83;
	Thu, 17 Oct 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4u6CRp3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C6ZvOjLz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E751E0B80;
	Thu, 17 Oct 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189769; cv=fail; b=FZr+quP34RcWjvfUiKmMRBY4oTvgb/DgZh9X606xR6anEiM4bYbU112gohTz9SRr4A0kITquQ4TZhOckn+HXhmv+D+RcgZkJFizBeKzrUTQP84W8OkWKzp+bc05dz8zNFFUTB02zwaPe/kxjbXOetbapFMRn1kuPTrlrheRnv0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189769; c=relaxed/simple;
	bh=dD6DawQC4/IM5iaXUDb1u5LDfTDGQxhs13dMly3BkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPitgKXHWRwaJcihCBLwlQekrI3AxFZB99FCz8g3HoE5eaX53AY1sadH3hUwQlTMQy2UvaeDqTzYl6K7rrpW7WIWTiEj57GXYDjWV09swQ+DewuEYowwUOwg5RBKMJRpRRpWXv6s7AFVKzUXyVwXb2veNJ8QAmy58TnFQTVbo3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q4u6CRp3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C6ZvOjLz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBoCa019283;
	Thu, 17 Oct 2024 18:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yuAOFyBWdtSw/vlE+MQsgE/klgagKvf9Dm8+ni/DBXY=; b=
	Q4u6CRp3pYJrm5TgK/octjPlJK8oHHhfsXgSSaIBQf9lxZRbs2c+0NZLkN0GeAtQ
	/iK5AkgGD2nYCUlgcZL1ugf1+zzg1s3VLNGSWWxODUlBXoezuuS/YfTxyzWrCQTa
	QtACepQBOIsMwQK4XH3AwDzj8QqDSz3a8CCXgLGZaoMfuSqMJWg/4Mbri62hjmpW
	O0XKrHR5PV3uy7RqiYTzMEU6JBsOZJjrPttBGtxr0THKAW+ZD1jGS/MM+1KeqtNh
	TTHQMIaQFW+d9xDRo0vVxBSYTR41qMEOWxmAqrqxWt9500RDKO1wU0ahQcIfEXXQ
	jdchBP6cqOxYF+Jeb59c5g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cqhqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:29:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HH267j026314;
	Thu, 17 Oct 2024 18:29:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjamkrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba4ZJYi3ljLhe8q5ByoWhcprVGQs7EX22vYhC0HWGllL5kEnGQ1d9whGLgaiSGPL3rXsEx+2OqZEo+dBHRuTts69f4xjvgi2JHgOlY/VHhPu15uJIVK1XqAg5xATi2MnhXt5hyt62fjp94TZzziUMjmCA8IkDl4YfMBelKuT9XmXsVROkWbwVvuNRdq4BqDjT+ZnUydlaNuxqARVVyIpb0TCzdtWh0UBCFvhsEIOdT7rFAXOcg/bA94rylStqRy/zkLvRfHddw8o06wFbdvGnZ5JxlzTqvLRG6pcKSn7WIbO3lNsUNJ8+9PpVVZqX0Xgo+UN8gh6rfNkbXVPKaFIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuAOFyBWdtSw/vlE+MQsgE/klgagKvf9Dm8+ni/DBXY=;
 b=kRyzz5T+igZ9cYaOue/6eJPGwLMpzMWbJqjXFBLzGSL9iw4u/YtBngOyR+XUjFq7DWc84XS8i9zpeoUgP9lnRMz/jfMpy/bDzEH2PapUEuyzv6TBCzz5gswJmAAEjEbzjchc9dO7TNYoB3qMPExbXCQodWoEIawCPzAYPRI9oJHdXcUcq9u7f1IW6mZTWPGsxndPjTB1440tDOOSRmqfP+cYEbGafWw9/Ql+lSB30Pfa/G8Ex1ZWR2gImHoNXxlFe9lcOZj0pT5GPxdq6+gdS0kfH8gy2kXywN1wMkRcw35WVr7+Sz0L9vjXuCpdo3/H7lPfa+IiWUzwOqIV7vQJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuAOFyBWdtSw/vlE+MQsgE/klgagKvf9Dm8+ni/DBXY=;
 b=C6ZvOjLzt9Od7ZZe69S2/WiXz0bUB0lNOzI1Rrct9TWLJxpvMI2UZKJIDDCBu9Mp/x87jVBtjWH/8nZAOuBxwXWJ0TpQSK2I9AFdJjYeqdR0Yy5i3202hh2jCZlwgSHSl7DSOd/r80snicAq+G3++zkIreV9hihobuXVQLlyBbs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 18:29:01 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:29:01 +0000
Date: Thu, 17 Oct 2024 19:28:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c498d3-3cf0-462d-70e3-08dceed99252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGVBejVyZnFmZTEvM2lJei9NRk9qS0FMU3l1bWJ4UzUwSGFrR2YrbXF6Ynp2?=
 =?utf-8?B?S2tvMmRHOXA5UDNiTGxFQ0Y0bXBHMmNmZHVNUzhmRGxicXJzdzE1cnRBTDFa?=
 =?utf-8?B?Y1pJWXhQeVlVRkN3WlBSU0hjTWhtYk14NkU4bi9wNlE5Umc0bXFtVEZjL2ZO?=
 =?utf-8?B?eHpNMGZvbGpuRlRLTHRTZ3hVazlQRVBVWkNIMUh2QXZZQjN0d0wzdldncVJ6?=
 =?utf-8?B?RXJ6QzlVL2xuV3BpZzU5RWZGQ1JSejZWNGV1dlpiT0MvdDBPYjR6Q21hdGtW?=
 =?utf-8?B?ZUhrNWZOUm1xVXBaRk1qclhvNWxkN0JJaThNYVBFSGFiNXlUNWpoM0dzeWhw?=
 =?utf-8?B?NWRBcFdTc3ZlNGNuKzFxUDNMZ3JtZDQwdWRPWkJ3akdTcUVvNXNNbi9KWWNQ?=
 =?utf-8?B?Y0pkQXZNZVZoZVdudVQyTXpaWXNZa05LRGdWRmE4cm5TWXJWaFE1bWE1RXFW?=
 =?utf-8?B?amZLU2czOE9Ubk95SjQxTWlOZ0FleDI1VUxxTjBtTUVIZnB5TzA1MEp4Ymtk?=
 =?utf-8?B?WmF2czh2Y3NWRjc1RWx6WC9lSGhsMnZ3Y1pjYjYxWC9Oa3YrNFZEdFhsUlFm?=
 =?utf-8?B?eGg2RkZJcWNMMXNPaDdJNzd1NTZQTzd2blgrU0NrQUt2UVVuaTJJSWdadUVI?=
 =?utf-8?B?U1RuNmpyUVZhMkhaMS9xS0YyMGZ4dGpYM2JtNUU2WkZCSFdPb1ZheFRWYy94?=
 =?utf-8?B?TzdxcjdSa0gvUEsyRlpkbmx1NmpsVHVjclNCeTQrQWZrMGhxT2JneFA4QU4w?=
 =?utf-8?B?bGcvYitVSzJraXV3MFZaRkxIMkgyamZtUTZKcVpJQUwxM3p4R00vclI0a05p?=
 =?utf-8?B?eG1ZYm5NRnVmdmpwbVd0MENzZmVsQTFOUUlXdjVPMmpKYUtHUXhMbnp4WWdH?=
 =?utf-8?B?ZHFrS3JwaGtkUHdtSERuLzJjQ0JMOS9QUjhUKzBxYnJCMHQ2ZUJ4SzRDR1pG?=
 =?utf-8?B?M2liSWxyTEdUTGNvNVJ2cHRUeDFNYnpTeFJnWjJEdTdXNmZQWlZ4azFaaXJw?=
 =?utf-8?B?RzVNMTk2a1VsUGg4bkJKRzBzdFU1MzVMR0pwYVA4Y2JVcklUZHZXeDdmNnhm?=
 =?utf-8?B?VUlBcW92RWlIZnhZWmN3YkM4Mm42VndOa2VuU1pOcnY2MlZrdGJtOWpKQzAz?=
 =?utf-8?B?bnkrclN5b0l0c05pZHVSbGROVTdNK0U3MkxBcE1IdmV0cmtPZWhMMkowRnRw?=
 =?utf-8?B?UUF1L3kvK29WMFdKQmVwSlhKcGpuQWhKUDBmb1U4VHZiaU9JUTI0WjI4cmJB?=
 =?utf-8?B?NjNXWVhyK01yR2d6clJZTXpKNmthb1hOdlRaTmJHMTdDZEpPSHp4OVpicFVY?=
 =?utf-8?B?b2kxZWpHMHpieEQwa2Z0THF1QVI3R21HS252bk5sZVdIK0FFYlJrS2JaSEFG?=
 =?utf-8?B?SDZGMFliTW5QbldVamxZcHNtbnhCazQ4QkJBeEcwQ2xpL2pRWi9SK2Y4NmFz?=
 =?utf-8?B?OVRiOGwyNDZTNEwwZjJjckdWZDZ1VWFhbVBUMjlrREN5dW9zMUp2cy9pQUFi?=
 =?utf-8?B?b0lpYWN3N3k3RmhXalZDd1RiYXp6WHVqbHNQK3FiWm14Nks3WmVpWERlODFo?=
 =?utf-8?B?WU5PU05VMGtSakgzeFlPdkxrWXFLczFHSm1DVlZXVXlXTTcrdnF4dERhRUo3?=
 =?utf-8?B?a3JMRWVtVXlLL3FJR2Y5ZHovSGttbzZKZ0hDMURXeHJlQXRYMmxxNjNId09x?=
 =?utf-8?B?N2hsMUhpSkd1eVlEemtOQTJaa2dpeXpOeTZhcXhqN25lQWJlVy9INm9veXBu?=
 =?utf-8?Q?in4/hNcl1wKFK8R2KUbCJpInfdxFXzwmVaDmuVk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxmU1M4cENSVTRobzZETSs1UG5DVEFnV3YvUjZ5bkhHUlZDOTNJZlJQNG5K?=
 =?utf-8?B?WHZObDIyd1RkRE8yQUJqclJHbGZjcVNFM1FsSC80SlpGK1dGM2xCdS8wak9W?=
 =?utf-8?B?SkM5WlBOZ1dWakhZMnJJZnJCWDZRcE41STVGNHA4YlpseTBjQnpHZXpwa3o1?=
 =?utf-8?B?TEw0cTNVNmxrdUxDQ1RwV2EwRU1yUWx1bmhjQjNDc081a1B4RlVleWFRZkdy?=
 =?utf-8?B?cmhidWhEeWxqNHliSXFuZWVPVUw3MEVXY1Vqa0NuQ0Y3cmZvMUF0SU5LR0JB?=
 =?utf-8?B?U0FvWkRPZUdCbklWZEpiSFdMd0RzeHhKL25jNU5LbFYwSlVzNHB0V3I3WUp5?=
 =?utf-8?B?MC9jNVMwWWNPVnhlRzgyaGJJRmJ0K3U4bjcrOUVyYytZYWVhdko3cndDN3FX?=
 =?utf-8?B?QzZGNi9uMmp4YkV5WUpGVzRocE4yQ2RkdnVRdG54ZWw0Y0IwaCsybFlQKzVK?=
 =?utf-8?B?L1ZLQ2hIcElNa1NqRGd2NHUvL2R0dWZyYzZpZktxVjNEYk5kM1U5YUVWYjRR?=
 =?utf-8?B?blFNNDQzSkZ6SW1HYkdpQ3pBUFI2bkM0YXdpMG5Yc0FEU1R6Tit0akhsZWc3?=
 =?utf-8?B?SDFtbjh6RkxCaHo3NFJqb3J5Uk1aQk9ram9nendYRk1OSU5xNEwzNEpHM251?=
 =?utf-8?B?YUh0UzJNVFdkdkJFbjgyR1Nnb3pFK1diZjNvOHdtVE5XWGhnYWxQb01kbDFt?=
 =?utf-8?B?MW42MmNUYUEyS0p3SHNaVHBmbU1DMlA3Y2FPRlMzUmRKK0I4V2w1S291d2hj?=
 =?utf-8?B?dnFaWGpVbGVwdGMvZ3dDTlJHUmhCTTNub2dtL0ZUUGtEUlhTem82MDd0T2ZW?=
 =?utf-8?B?NDU3NFcwWTZzNVhES2Z6bW1zQlNQM2tnSWNtQ3R2VGtKV3dDTG9JdW1HWUtH?=
 =?utf-8?B?Z3VTSFJreFE3MXdaWnlMOGpoWWQwSUhyYWUvT0hzeC8wRitBdW5GY1JUZndl?=
 =?utf-8?B?U1VCeitiRXkwSGE1ZE5PK09mb0JnQjJRODh3czZqVmRDZ0pmNGVucDF2VnFi?=
 =?utf-8?B?emNrQk5pcEFyMTVIZGQyekJ1WjA2QjZwS2IrWGp0YThaTEhHVTRqdWZwWkpI?=
 =?utf-8?B?blRSdU9qUmNzVDJKeWdHdG1ZV28xYVJ4Z3dha09RaE9sQnNZZVJ0Z2FvS2Nw?=
 =?utf-8?B?NjkyVHM1dUxkN0djamtGWGdhd3VrZUxld2hyTGl4UUE5alhXTFc3SkhFc2xZ?=
 =?utf-8?B?T1FyUEpSQWNpSEZxYjVzbFRuUUpOYU9PN0FxY29LMDFkUEh3MFV0S0tJZFpS?=
 =?utf-8?B?WkUwK2p4TFV6bjVMVlg5TjFmTXFHS1dPdWxLS1NMdW1WTGZRL0lVSFhTdFRn?=
 =?utf-8?B?UHVtOVYrQW5Yc0hTMDdENDhsRG9XNTNTK2NYRkZVWWNkQ25RTFc5NGszMlZL?=
 =?utf-8?B?VjRVSzBIcXRTWkpGMnNyeWF4QzRNTkNXUzdxUnY0WXMxcjlUMEZZTDY4OWxJ?=
 =?utf-8?B?dml5RVpPTlNaK3JEQXViS3ZJUkJDVUdnWjBaY1JFWXR5aVllMU5DZ3BJYzJl?=
 =?utf-8?B?QmRPb1N0MCs5cUxVbjZjZnRSQ2JGS2V4a0NPOHQrdndFNmdEbWQ2UkhMMGJi?=
 =?utf-8?B?VWJ5Nk5JMkkzQWNzREVJbUowd0g3STJiUmJaVjgxeEdTcHc5Q2xXeHpuZnpI?=
 =?utf-8?B?ZjA3NGFDR2FSUlVvTWplS1c1UGptZmVka0NGdCtNVStuTFVOU1FZMkpZMHVU?=
 =?utf-8?B?UzhuV0l1eEVQYkFIUGhjT3JlOFg0UEU4NFBnTUg5UEJpaVZISWdMNkVwUC9M?=
 =?utf-8?B?LzAzQmhHUTV3a3dSZU8rSmh3Uk9kS1lHYlBMa3QvZlVCMndOOGRGZ2MxdElG?=
 =?utf-8?B?NUEvbzlBMWlJYVlTQnppQWRrU0hXZk9pVmVYdE5QN0o3UFViUjgyZXhCQU03?=
 =?utf-8?B?OG9UbnFGaWJaTWo3WThlaHhnRVhOQUdLbERISFEzOFJZQTRuLy9LekJrRWNy?=
 =?utf-8?B?dFNka3E2a2ttdCtCaVNvYXFtV3FjaWlVV2g2SUZSaUtYSUZ6Sk0walQvWUE2?=
 =?utf-8?B?Mld6Q1g1WTQ2N0VqTlJ1THlxUVFrYUxwZ0VRNjh0ZTZKQ0tCM1p3ZnVFOGNw?=
 =?utf-8?B?UEQzUmFFNDVyMEd1YkRTM1dYRjg4R3JSV2tjdmFmdExtV2hJSXhMUXZ6NXUr?=
 =?utf-8?B?ZGRXQ2h4N2Q1bFhwVWp5VTRtNHFLaFJPRzRlS1IwWGgvTHhDbVJDbjQwUngz?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	38RIWv0X+9d9Dwx6Bz1mpAA76BzZWdTxSILEQhxRIx4VTlEuii9onRb8cKuzSi2x5cwdlgjdj0aNc0kUDLlGnyti+fW4dJpcmDNBmq5AcKAvUeY89Cb3wk4bjkROp34xViaf//wT9p9zLXZ12gGwF72C1DQA5bFaAe9KriWGt0eSPK/5VrcvRg4C8pyQ7CbKDwqvG0foDfeEwop0SkyAHZhMohCQRduACSbjbd583YNn2eR8KoFjSYYBUGTbaCi2517QDqo8tjUE54XFrpDtn8DIKm4OXH9MEMN5SbCrrJi15iZgi1UmRWnIaq8ycKsTDbS8Bu+fkBT0zZ8ypGfjS2eqk5Y1EXDV3jIw3jYTBtZ7k3L4/o6CfwBh9W3vyMTn0mPJqkuSLRZxPzzoRJVrij9ze0YVRwdXyKoEM6A/9tqDKfqVh00cfc3xRCW9Asz3cUAOEE4N/mFUQ7uO0U7y3WTRdJ+Pmbb/0B6XCVg2j4eTCG/LuUTcXGgFAmt2eQM3aSqdfJbJe4uMqBvGzZilBDsWbB+VCPluZY5kmZ8o+DLzWyE7Us+RhiqEphMK1yVom8HdaY3ODAZ59onyyO6wXVgAKSCBhNm5zBr32sQb5jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c498d3-3cf0-462d-70e3-08dceed99252
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:29:01.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr6X/6017ij8BAnE02CZbqBU2vKzrKPVE0UcU6gH4imEKt+eMQsMjblqIbHGECR8TpQ/C/RXXdi4MLxx2GiRO/f9ljyI6+BSIUp8One83Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170125
X-Proofpoint-ORIG-GUID: WqIGQod5J-eLK6xK5oDZmobnMu0Cmgza
X-Proofpoint-GUID: WqIGQod5J-eLK6xK5oDZmobnMu0Cmgza

On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> Hi Lorenzo and Muhammad
>
> Reviving this thread since the merging window is closed and we have
> more time to review /work on this code in the next few weeks.
>
> On Fri, Sep 13, 2024 at 3:50 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Hi Lorenzo
> >
> > On Sat, Sep 7, 2024 at 12:28 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > >
> > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this point
> > > too - I may be missing something, but I cannot for the life me understand
> > > why we have to assert negations only, and other self tests do not do this.
> > >
> > My most test-infra related comments comes from Muhammad Usama Anjum
> > (added into this email), e.g. assert is not recommended.[1] ,
> >
> > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collabora.com/
> >
> Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE
>
> Muhammad Usama Anjum doesn't want assert being used in selftest (see
> [1] above), and I quote:
> "We don't want to terminate the test if one test fails because of assert. We
> want the sub-tests to get executed in-dependent of other tests.
>
> ksft_test_result(condition, fmt, ...);
> ksft_test_result_pass(fmt, ...);"
>
> FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> replacement of assert.
>
> Please let me know if you have questions on this and Muhammad might
> also help to clarify the requirement if needed.
>
> Thanks
> -Jeff

Right this is about not failing the test i.e. equivalent of an expect
rather than an assert, which makes sense.

What I'm saying is we should have something more like

EXPECT_TRUE()
EXPECT_FALSE()

etc.

Which would avoid these confusing

	FAIL_TEST_IF_FALSE(!expr)

Things.

Hopefully that's clear? Thanks!

