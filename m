Return-Path: <linux-kselftest+bounces-6535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086F88A5D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EDE32039E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688184E1C6;
	Mon, 25 Mar 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZ2+pfCr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JBdWG225"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6E13CAA6;
	Mon, 25 Mar 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369078; cv=fail; b=Hn1y4i8s6SbsAjK+ZFhwgiuT1mFcfXtMWxzG9qhWAy/Yhm1CGe+7wKx+CLmOitYCDIpRvy2JcLXLK3D2gbJXSYUw4AKm0P3q3WLWEeXdFd0BOjgn2+5Sk5HhwF0w/vQ2kbpVIJsbd6UrD54INzFh8SkfUQzrOmyJwH7xhQBFqzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369078; c=relaxed/simple;
	bh=cdNGJOldht4R8I52nHpmHskbIn9PPGXdpezVWAZEO3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PyfKvzSg30qgDbG9fpuPnmbWHI3BGLs24PeFlmqoUqg8kfAN8XEvv0cT5fjE568tImBbOeWQcKm5d0Ukas/xuaMTzkkFAxlZieYuQ7hQX2NEyt4+EonXtU8Z+PqHVzAG1VdzGFnK1RR7IWfrHgNR6p6af8JLMNjNzZQQNLrqsPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZ2+pfCr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JBdWG225; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PC3puX024539;
	Mon, 25 Mar 2024 12:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ax6SMUrMH8AiBOL0lD7ZNVF/nrqjDnKIv7fnQBYpUqU=;
 b=JZ2+pfCrT3VpPl01NErfnezr8zr5qy6SnMje8ADqoNKr+dL1032Nd3ajUpU+PFe7ochF
 frXq8KIIexPOB2HaqbtEFSg19NgnbIr2y9UBLUxaHIJiUZpfo5mAy4YLevvoA99+8rZj
 QhPm877Hh80SOPAtPpEnQm/oQeKijl0mCn8Mlirk7G1YmY/JJ6TB7I4YecL2ucXczSu1
 gvG1qW/N3xELwdlKJnN+nTEcmGixToqbbdh5s4fAlKxP5G29but0wUszRDxjuSKN/wvH
 FePh5ieJRN38saUIJTNpWrXelUCeOdtWYjxusf7U1Z9XPjENMzEUe/A4L4n62dC9fAF5 UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h1hdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 12:17:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PC0Aw5010779;
	Mon, 25 Mar 2024 12:17:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh5h4kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 12:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTER+5gcEEIqn73mIS8dIjBgFk3s7/m0I6EoAqEcB3Yl32tqP48CFSs42nAlX2P4/a2PHPT/Ck1ybkk7ycDj1lrtrY5hIE7wwtMo1Ix18Kstmg4SJFtOX8cOsmd6MvcX/WSobav5Omw4m1mmMsoUg36DthOPWEm3KriMJqW+0GKMv9FjqlnA7UbV9j3TIbj0CHWkS8L6SuH+N+LgxN/2kpS75MI65jRcAZAbaBxtNho852WMlqjbnR5/FeUAxVAyNwcrJIcK4/PLAmMDGI7Mj/tzIQPef1HIKSdUnqWu+KTyfAIZCQurSnO+angXJdM5xpoTdP+F3oXhHxkPBrPwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax6SMUrMH8AiBOL0lD7ZNVF/nrqjDnKIv7fnQBYpUqU=;
 b=k+oC7bqF+DH6qi3hsueo23ZLyBcEwSLrI23F3o5Shkprke0MZthmkaYr+vTUjNKoj73qRjUvfoE35XYWn1Hq5tz3CtedtOXrRIbYf9zTZm4gzweb+TjAY2XsQiM12m7hdqp2oV7GmFY/zfmbrnrYjN1t+WdAhZQgp4P/TPtwdityko/hTZL/LrXvgOQgmS264Lb3sPuoEDDprpPLUntRh+lk3uLEXpDUH14DSu6Xn3vLRqapC/62wy2SBMozlgnWrNHTf0xk9UwEf2feU6VqsYbUhLuKDRsTrO/PnzkagVzhcoPkE295VeSR0A/tO8LXXPWNZt4ofU77cfXs7e/XqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax6SMUrMH8AiBOL0lD7ZNVF/nrqjDnKIv7fnQBYpUqU=;
 b=JBdWG225CEq2Jk75D8YT2HezD2INn3Az1l1p1UmVeW8wGRQYyAtWOm92ZNY1fBWw2nkssrDOdKFjHD5woDN2RxYPw81l/edFc8WGstsWbhm8scBTnFDIqNL/yW7JiQzHMxQHZ3iD1YaUxkepVZgE/OBTWhqyoswNgYXCWAR7QBk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB7342.namprd10.prod.outlook.com (2603:10b6:8:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 12:17:39 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 12:17:39 +0000
Message-ID: <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
Date: Mon, 25 Mar 2024 12:17:28 +0000
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f78135-4d5d-44e6-ab69-08dc4cc59039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I4viphZmadzYyaP/PsIcqXbTqJWDxDdlTVTPgWioP+1+h2QHZfgU8VbBtBzLgVgthARmQZKA6+D40vlRf3GbNDKQncTuad/hL3nxwwYLJFGj2l0ruFd8YAjofSbVEuCOCzskmzWRfYpuKp56B+YIfWJiNGTZKwxMufkrMyEA+g+wHL+1GeJF4W/8I0WZGPPgaUThXdkNFrnaH51TA1VmKmf6lb16RNT3xdHghdoifQ2r0S5pKDwoLcJitRa3X6GmYFlPE09xh8imUwhc5AXENZODmjlk0jOrA1ikOju7CQvCTSOuYXoF2fAwNhl5nAmta740LnClwqXJh2Dj4RBL6i9XyX8G2qKr/m763iadu4WS7X9/A4gL7Pmt0jwAWrQjNwYrCdLDfiW4GrxeRxf/A7EAI5trsHlKmjmC9F3n/eAKHc4MNdzTsmOjHNr++wVLOnawZa7/OR1VQBgHg+vpZbu7CzlY5BjKpl6FkdKiQup2hGJt8YXwVH1a69jg7bQBCPPcUY6nafe8Z2KhSYWONWebSZAVWsXd5UyCPaEEehpMkLMPwk7wvV4IfqwOWx2iu4loKNnAss5cbPrw0SVf9azvjdnwjscJjLlLw2ApCxNt2BeUDUwajqF8sJ3cATrMvbv0VnOgREGjgmlbISJ6hh1KLJ+mank2Uv7A4+MUtY8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWNEYVMwbzRKcWJZZ1FValdxaEdpR2huSEFNbVExMHAzS09kbUprQ09TMGdZ?=
 =?utf-8?B?M0RQRTFJWWFqM3ZObnN2K0pwUjdLb1N5N0IrR1M2VTVvTmR0NFJwMlRlcjVk?=
 =?utf-8?B?cnZzNExMMTBkL0J3cGZyU3dZMWVKTWlsdVVHN0ttMEdrM1c4M2Y4Tm03b3Rp?=
 =?utf-8?B?M3E3d0F0RjVyMUFSRnJSWWZGaTVaZlFrL1M5WWYzU1ZRd2JPbjUzRlhBaXpJ?=
 =?utf-8?B?S2lYVWJacXJNOUU2NGJGVmRmSGVsYXRmYWpFWG8vbTExeDdMZGcvNFJqVHZK?=
 =?utf-8?B?NDg4UDFNeHBiamNlN3hrRURZS3lQUTJEamxpKytzTktzdCtqWmE1dExEYmZv?=
 =?utf-8?B?ZnorU2tKaEVwZE1aQUZIMnZ3Wi9TQXhPZnlYWEliVUd3OFRnQ0V6MTQ5RUVj?=
 =?utf-8?B?dnhhaWVYaE9xS3lETURKYlhJeXM4eFp5U0dCT1d5a0tXc05INUk3azZnVVFK?=
 =?utf-8?B?T2VnejRvaGNuVTBkQVNNaWJlMnk5cnhIN0Z5WGlEaURGTFNpSzV0K0liOGlW?=
 =?utf-8?B?cW8xR2tBYUU1VHB3WGxCbERBUlFwbW93ZGx6bHN1TFBSUkNhcUtuTEZtMVh4?=
 =?utf-8?B?ZFlPWC9QcXg0bHRQTHBwTWxpR05keDJMTlRhdUt0c0E0RlBjUFVZSi9rQ0dC?=
 =?utf-8?B?eEQ0WjBoWHl2RmRPOEtRUFBIVGM0TGVDZjdaMi9CS3J0Q1Y4bkx2bWxmWEta?=
 =?utf-8?B?MVJCd3pDanBnV3kwN3NRalkrU0xxOFVnZy9Ub25HbVoxT0ZpKzBMV0JNTWtZ?=
 =?utf-8?B?MkRKV2NlZVcwN2gzSmVCTzZWa3RvaGplY0J0Skw5Q1V6WVhJWkUvdis3OTBF?=
 =?utf-8?B?cXZGVmE2Z04wWFAyNm03Q3JBTzdTRW1LbEswOHJaZmFOR2VJUkllRnl0bUdS?=
 =?utf-8?B?N2FNTHJCQnFrZ3pnSkNjcHBidmFGVDc4aFRBd0dmYUtabUNHWkJpY3RSQjE3?=
 =?utf-8?B?bHYrbVM3bGN6K0d5ZHdWeDlrZGp6YVVWbTVhT0VMeDJtZ3poZGd6S3NBNVhz?=
 =?utf-8?B?dWtkVXZ0M0pEa3RYM2hqdTRSQjJzZDRDMWc0NTBiQUxOVzVXR1pidFNicTd3?=
 =?utf-8?B?S2d5dTZ2WHNsSDdNMUZPRHdRU0h5NVZkc21ybUNPeHdIdHoweERWbUhRdDZr?=
 =?utf-8?B?UU5DOUFBWFNyKzdDYURVc2VqN2VSbmJUVDEzdU9zN3BnRUxKZTBkM2xKWVdG?=
 =?utf-8?B?cW54NTJIeWFQeHJkOS9MblVnYkVYaFlGUHluWDBKdEllcVdnTURxOE1qRlJz?=
 =?utf-8?B?MVpkL3UzRVpPNWxFNWFOVXRieUFCSGhVZWZTbERpekpLbGJHVXlBREhjckpP?=
 =?utf-8?B?T0V2SGtWejFIMFo3SVZWZlQ4QXdlQVVQMk9qUDNNVzhudzFudzNYUWZzTGFM?=
 =?utf-8?B?aXY4VHRlTnQ2aStzTVF3M05DT2RCSVdIT0hKRm5xNTl4bE9MUEUwTXhOVzJk?=
 =?utf-8?B?RW5DV1k2TDNZNzRHTlM2d0RoVENpZjM3Q0c0T1hnVUxVWmZxMTcvMldDUU5K?=
 =?utf-8?B?SGN4enhqVitpVitxRDBna29YODcwaVBiTHVPdHNHMHROWlhjS1hwaGRwOHB3?=
 =?utf-8?B?TTJWVTMxS0FHL085K1Q5bjVlajBSTnIxTDQ0L3g5YnVqdzdaelQ5OXkvL2FE?=
 =?utf-8?B?MGQwekhNQ0s0WFAwUDVuY1NCa1VqWjVDMm9mYmtDOTkxWmw3b0k0ektnWSts?=
 =?utf-8?B?MTZkTThIMUZyamhhZ3FCYUN2eVUxM0JKRHk0QXVRZlVmWWpJbWpIa3ZXUWZ5?=
 =?utf-8?B?MUtORlU0bjlMY3E1RzJxNjhDc2R1Ymh5Wi82amxZZ2hQNTVHNzVVQXJBaWh4?=
 =?utf-8?B?ZHZNUlBUYTBYNm9MM0hHZnhVK29jNDVlZFNrR2JIMnpmNEtsNnRxVzdKZ3JF?=
 =?utf-8?B?a2l4Q2VPaU93T1c5ZFdvSjV0Unc1dElKZllQTnV0UGZRN0hhUkp4OUNFY2xu?=
 =?utf-8?B?QjVLanFCNEVPZDNIc09pbHRWUWtNNTdhcHI5WHA5MFRDejJ2d2V3T3dSUUxY?=
 =?utf-8?B?bVJHcDdlbm5YSTZvN1g0OFR5Uzg5RVFZbkx4OXA1djZaZVRWaVJMS09tSTlO?=
 =?utf-8?B?RmU1MDdMck9PNlVhZGlYS0h2UTNlUlhTNEx4MTQrUktoY3Q2cUVRUGJXTU5a?=
 =?utf-8?B?aWRjUEltTG0yR3VOY3ZEbytuS2RFSFhVV0M2WFlkVTVPbFh2cSsveWtrRWQw?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nPM//NguwDWguvihCj0IK+5z6ouNhGZ0OSOT3WX9A7MpFPh2WH7X7Tp59gsmu2wk5Ta2p/i17JwvNrlds1554RxTgQ9gzRA9nF8PAbp4WogFhnH55Hb32QWV2o1PsCVOUiGtMhwmQQJpEKNDBzzf/riI2yJ1hdgwxqvTCEBlmz/Z4XcBMGCA3vsExCmqZnUKkD24h/5ifBe2B/2oa6zf5oLM5d9qe42BnVQfkZ/hgLLR5xb6Y6BZQ5mkZlUUcRmGLj9T579mH5vgXtNEXdTvhLEHJfK4tNcS67RGeKUc1I1Gv8vo8g7XdWUc7+f6v8pu4H8smmq09ndCoYxMbo0P6iM0dAgfKvkhalaWy8CzxYXLw0x2Od14sEUMKWTL7wXYBtfE4e4pbp1i2+xfC9BFrYE/6X3YlKn8jDFOGdNd2zdqcmNLd3ECklgChaJUrkvdKR88wk/KRsq5h41Yx5e7LILm/U1s4BZPKK2lB34XZn2Y/kfLWp2OX0Um7VGObiC/ga03yBJXxVc+Ws5xmXvI4cnaMwdFvl/X2Drdn8DhxZL/mT88pJHDtxaeOk9Xw1HQyiqSlwPiDt4KFfSNFP4Zg1/6U4vFXfS0PS8W0EWmsvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f78135-4d5d-44e6-ab69-08dc4cc59039
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 12:17:39.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT1xbT+qTcBju8L6xLo3vWWhrzsV88L0THsuCwK07S96uNHL5aUwzWTtQLUKPqDqD0ptOw9DZnwZOeBbV9oLakZXtgkpks3lPGOiyBKRyXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=798 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250067
X-Proofpoint-GUID: O7Uvw0lZC6wUzsVPx2Lb884nKlm6OOSt
X-Proofpoint-ORIG-GUID: O7Uvw0lZC6wUzsVPx2Lb884nKlm6OOSt

On 23/03/2024 20:13, Mirsad Todorovac wrote:
> 
> 
> On 3/19/24 14:58, Jason Gunthorpe wrote:
>> On Tue, Mar 12, 2024 at 07:35:40AM +0100, Mirsad Todorovac wrote:
>>> Hi,
>>>
>>> (This is verified on the second test box.)
>>>
>>> In the most recent 6.8.0 release of torvalds tree kernel with selftest
>>> configs on,
>>> process ./iommufd appears to consume 99% of a CPU core for quote a while in an
>>> endless loop:
>>
>> There is a "bug" in the ksefltest framework where if you call a
>> kselftest assertion from the setup/teardown it infinite loops
>>
>> The fix I know is to replace kselftest assertions with normal assert()
>>
>> But I don't see an obvious thing here saying you are hitting that..
>>
>> Jason
> 
> Hi,
> 
> I'm not that deep into kselftest for that intervention.
> 
> Yet, with the v6.8-11743-ga4145ce1e7bc build, the problem with ./iommufd did not
> stuck.
> Instead I got these 10 failed tests:
> 
> # #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # enforce_dirty: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> # not ok 156 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # set_dirty_tracking: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
> # not ok 157 iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # device_dirty_capability: Test terminated by assertion
> # #          FAIL 
> iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
> # not ok 158 iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
> # #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # get_dirty_bitmap: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> # not ok 159 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # get_dirty_bitmap_no_clear: Test terminated by assertion
> # #          FAIL 
> iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> # not ok 160 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> .
> .
> .
> # #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # enforce_dirty: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty
> # not ok 166 iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # set_dirty_tracking: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking
> # not ok 167 iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # device_dirty_capability: Test terminated by assertion
> # #          FAIL 
> iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability
> # not ok 168 iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability
> # #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # get_dirty_bitmap: Test terminated by assertion
> # #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> # not ok 169 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> # #  RUN          
> iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear ...
> # iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc ==
> self->buffer' failed.
> # # get_dirty_bitmap_no_clear: Test terminated by assertion
> # #          FAIL 
> iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
> # not ok 170 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
> .
> .
> .
> # # FAILED: 170 / 180 tests passed.
> # # Totals: pass:170 fail:10 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: iommu: iommufd # exit=1
> 
> It seems like the same assertion failed in all 10 failed tests?
> 

... It means that the hugetlb mmap() failed, which is required for this specific
tests. Because we need to allocate a bigger IOVA range, and in hugepages to
exercise the test.


> However, I am not smart enough to figure out why ...
> 
> Apparently, from the source, mmap() fails to allocate pages on the desired address:
> 
>   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
> PROT_WRITE,
>   1748                    mmap_flags, -1, 0);
> → 1749         assert(vrc == self->buffer);
>   1750
> 
> But I am not that deep into the source to figure our what was intended and what
> went
> wrong :-/

I can SKIP() the test rather assert() in here if it helps. Though there are
other tests that fail if no hugetlb pages are reserved.

But I am not sure if this is problem here as the initial bug email had an
enterily different set of failures? Maybe all you need is an assert() and it
gets into this state?

	Joao

