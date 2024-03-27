Return-Path: <linux-kselftest+bounces-6714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C984288E8E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CE9B3170E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC44143898;
	Wed, 27 Mar 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9VYn5z8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IwOnQqSN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96B142E84;
	Wed, 27 Mar 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551869; cv=fail; b=aP5vq3vKVfscxARgDSGD1pyhmMmcEtqgTeh0ccriSiX6LdH+RppauBHSXhWxwrOYro2AC25ZmCJgVYoDglJWRxMLGP5pZo0s31vpBnzVViwLTn/pDvZyZ0khXzre+NYSk/3mWUL8LwEJpkGCrDcg+R5VcsIAEpYH0AuhML4tGBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551869; c=relaxed/simple;
	bh=6gys1uwYb+tK86sL8kee5goqDiMoSwyGd6I0wegjIp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GIb/a0NcwbkbBrhuNcMettoV3K+Fhcl1Y4EmR4k60CG2L54trR5DFZpIFYb9mhc5aYkz5av6bT69riajXhejtisL7sFzmJZE+NBKA30nfgZPotrNqTI9eas4NVn0fLdMUbCo9Umf3XVxYBOsk7z6yIPOmkiAY2IRBG0gjNQTayo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f9VYn5z8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IwOnQqSN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42REiaEN007348;
	Wed, 27 Mar 2024 15:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JTGq9Xsl+sBs44MnRCcgpAk+isSfWnLoSwkMByArhfc=;
 b=f9VYn5z8/20swMc7sVB9iDRcjP1jpDijc6Wcms7HWhQv0uftJ0ObcE+qhNQ7KlyeADSd
 YGm5g6S1w6+gno7lHVqYuIPKz0P679U5O80Y302UqgLb2q++HdtBilbArPmu0GMUYj5t
 YGv3dy5ZkenVFjN8QeZho1TZ5/7jNiwsBujDarWpq3RxzKlPAOzWRAI/fBLh501CcF+L
 3PpOhbsUEX6HFJ09oMgCdP0PzToGaCF4a5grz6BDYqi7HP7DaOdzQMa3wK1CT+1ocJ9J
 INHZyQR0spvrbl9113omAplTnKVgzfV14hMVBi48krcse3wH5wQWdb6HRbQP4pJRRRrv MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct700k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 15:04:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RDv4t9008926;
	Wed, 27 Mar 2024 15:04:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh8xjru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 15:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az46jj1Vl9dkVf03hS4rPHXTnFF5Wu7p5bIHdeTIqE7J1beblxFavEAw4oK23KExSIkzTd0cALuIGVBe2knj1nbV0o9endSn7wboo87yVWU2D799ZY5kafwOpD4IcKWhqCvAUjnQkJ7W/VC7+ADGMZibV45JeNR9KfMxAvM6WbNFos954rqPfagTM+hgl3M0nV4O2JDk8fiws67EkvS8alxVzgf229KD25HZnYBc7erCaWjNMbQbCcAO7Td/dMH6uBuoRmIyueYBJ0PiYRHFOlCHAiUdjjjOGgJgv/eS8+Wy7GnGZro8hU5iyj+tM6pVXQu45YyZRhRoqli3mpQwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTGq9Xsl+sBs44MnRCcgpAk+isSfWnLoSwkMByArhfc=;
 b=OFkhyvUP4JRbLWjFtL0caIMtx6ck0lF3l2Lqvd7PbDDn6MnBk3J8/dS/ggXXTJpkOqly5ltC7P/mxII4RQTCbBbDDzQXSG5p3f+w/sRzDGoeB8waSHepHPo4vBjQu80xgRgL3GgzySEGu9dACzn2lOol1JKqdXgG8rHZQXe0xRduJA43LmpgHR9qLg/V6PQET33SdhZVaEVVx6TJKNnJ9qmfPnzrQqtH0ykyj3yr2JTX9EPuXHQV9NRCgKFAmtrhXmTnuG8MLhlaoXAWwwqbdeIHB7LuCNa93SMG8sSyEpUk+k5JZiSLqMZvHJn7V+fXwunFSoQsJYdBr5nQfBc3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTGq9Xsl+sBs44MnRCcgpAk+isSfWnLoSwkMByArhfc=;
 b=IwOnQqSNpp8DwXnmboNIOikinduK1KVBIDt6YoC0C9moL9jU1iTWLaXcWlNL+RFcKf8MWh699ZvTFyltr1IDDiHta6r5V1QxbqLcnmLFrFOuwmL8+uLS1fTLpAEXuihuHouj3HvI3G0nRr3OjidsH1hD0e1Cz5SaITHhke4BKJ0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 15:04:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 15:04:14 +0000
Message-ID: <ab5d2b61-2dd2-46d6-a106-a9aea69b0a1a@oracle.com>
Date: Wed, 27 Mar 2024 15:04:09 +0000
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
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <20240327114029.GC946323@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240327114029.GC946323@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0257.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b1b41b-39de-43e3-2b57-08dc4e6f2a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YR/0KOoWvk1+E+SIWsy8h9ouApySvSs3EIIQmTUEdLCBgEcSI1EFjVUgT/ydwC4H1VuC2V799uxVVGGMYx7BjjbcHQkA/MzFPheDAAQY6rNcZDeSwdvSwVtTjjnUYGEczhfbJNXrr4B+yMa82ZiJipYzJs2ClvCPClsRMYxD/E9/dzs+QzwecO75MhZre+rLmYJxXiGo8Gt3Ibadph0QYGm7vu9UDFZCsXw7wm5k7A1KCc/mJ22jDMEGCnhuD4kBb5MmK0nf0CwZ/2twCuSqDbNgQHqtgeQ9DJnFt/XBMXrfI6Ug7Yo5BF3zNp5Jw8Z9GcvM8sjjOyq7V4ppMapyvGHcq+fiqqprQAjTO+1jcanAWslccrQYdy3DWO7sIaP7Kk+Y0F3ocfncPI0HwCxTaRfItOgU+rs9U/mtAHdGW7HBmsFhelMV67Bwe1v5ETB7oAuCyFkrqJxwSa/2Zlwnppv5tECCB/vTQMcjTNq9TtCXtGPhSB3RmdiWTaySE3BFJLuhPxAIYRjG3vPD+vvHS8Ew2jmQnCr+Utg5TW3r2o4rOySf46C2DMM4DF81Oe8xNc3lL3W/3EidqxD80jeTCQvfuQOoPiG+m9mEQsM8MbuqdPRw2Mn72EHgMbWvui4Olc8SCNO3N0i58OHqsC1RKGRGJ7aSCw/vUJ3+aH7jfXc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3dZUEpyQWwwM1psSjAvcDhTeG50MW9DSmxWelhidC84NnJlUzRYUDB2ZjdU?=
 =?utf-8?B?UnhTVkdxTHBtT0FLQVJEVmZOTWZMSmR2bDQ3V3g5MWlpaEFrVkR0SEhCd0hJ?=
 =?utf-8?B?endFMCtxWGVWbVVvcmRMdkxaM3hxVDBoZ3AvdDE1WklrbWtyK0JFcnE2N1VX?=
 =?utf-8?B?c3lYb0NscnpkMVFwb0o1RVQ4MWxFYUdQRzlhNGZKRXB2ZkVlTWcrOVVxZkVk?=
 =?utf-8?B?Ulk5ZUpFMTFaMWkrbHJneXliOFZVb3MzY2N1R3dFQTBqVGR4L3V2ZTZUYUox?=
 =?utf-8?B?YU80Sk9lWnRxMHNuTytMeWtlRFJ4amN4ajhmMzhSdVdUNkVTUlpFcWxXMFRG?=
 =?utf-8?B?QzJ3R2ppbHErT2t6aWFaQm9LOEpacUU2Si9uYTF1VE1hNlkxTi9HREt1VHM0?=
 =?utf-8?B?Zk1VTFpqNGhWUnB5RmxQWjFMdnRrZ2Y1aExHT2hKQXlGY2VHc3N1N3dPNFk4?=
 =?utf-8?B?aUwwaEF6Q1BDNTVvLzRkdTQxUlZrWUZsaGdjbFRjTElnTW11eDJ1bUpITnph?=
 =?utf-8?B?UXJNcnJ6eU5seXBubWlycm9KR2FZV29wVGo1OENoakFXTk91UThLckdkTTlF?=
 =?utf-8?B?SlVjYmJBamgxajZXaUhWS1JxbnU5dDZSU2UzeStUNmg4NXkyR05DNHFVV1hX?=
 =?utf-8?B?K3gwMlV3SHdKcVZaQWovMDlWM2laeGs2OGFsckdRZUxhSDBLc0VYRG5maVkx?=
 =?utf-8?B?TCt0UEtRN0V0SUQ5Y1M5dFlHSisydHY2Rm1XVHY0VVVqTTlVbWlnMVlwL2w0?=
 =?utf-8?B?NUxJQUgwQ0k2d0VSbXFIN1Y3WDlCTDg1bDl0U0QrVzVGdzlEcWlMVEJQSk9Q?=
 =?utf-8?B?V1ZMRGxkSjkrS3lWQ1lpWUJMMm5aSnRnOHo3bDQ0ZWkwRzd5SnhOZDZTNDU1?=
 =?utf-8?B?V0tOVUVKeWxyS2xmenQ5UFk0VEY0RWN1T1lYUDh0Y2Y2clVZM0hNd1g2ZWoy?=
 =?utf-8?B?T0xYNVNpaVBIQ3puTkgzZHgwVk9QOTNzKzFxdUsrUGI5SGpReUdyMVl4a3lp?=
 =?utf-8?B?Q1RnOWdiY1J0ZmZQZTRyMUlVRVZPa093alAvTEdxWTZ2ejlLTG8zMU9wWnNk?=
 =?utf-8?B?NFRxSWtOZXlmQnlBZkU5alFWOERTVW10ZUNNRm9uVkk0WFVWa1I4RXkwV1Qx?=
 =?utf-8?B?cytpQUc1dnY5K2tnVjZoUEo1VEJjVzI5c2lzbW1RM0JibGRWUVpPdk5MbEpi?=
 =?utf-8?B?dzNTN2xXTWJ2cXg3ZnBjSCszVUR3QWx5bXJiOXNjTTVqR3YxbGh1aU9uVmZF?=
 =?utf-8?B?TE9YalErRjAzMDloZE5wS0RIK29kNUNhM0RsQVJMTnU2NVpZUG1RdmtPZ01p?=
 =?utf-8?B?VnJHY25JYlJrcWVBUWhmczlUY3RDc0dkNHhrMHlOUXNQZGtyZVRuUDF4bVVC?=
 =?utf-8?B?UG9JTHg0VmlvNEVRblRWOVZWWjcrZU9tekxmSlNWUnRocWtKSVRURURjTTVC?=
 =?utf-8?B?WVNiTEFUWExDeTlCZ1BwNE12eXh5L1lZdFZCYnVVVUNXN1RLbmpGanF1aCty?=
 =?utf-8?B?UE1rOGdkeDBoVFE4MmhJZVNLV3NLZVdVbzVNRUNjQk9udi94QmdjbnVnamh4?=
 =?utf-8?B?d0ZZRHpwTmZObTg1RG9PZldROFNkMXFxanorSzBJY2k3MlRJVEFzNVRtTWV3?=
 =?utf-8?B?S1ZGQTdIaXJ1a3NnOUVmdFJVWGtscjQyZVVLSTlJSTd3ZDhTWUZudmo0RUZh?=
 =?utf-8?B?c3dhM1lPZ3h0cUZaa1Q5clBYVE9wRENyMU0xME9DQ0hyTTZydUJaN0RVT0lM?=
 =?utf-8?B?ZzFWKzRHWDRzcm9ZMHdHQmRNYTNWTDc4S3lyTEpubWV1ZFE2YndaTHZ3dkV2?=
 =?utf-8?B?NG5MTjJ5UHlvYlpqVXNyZXdsck42ZXkrY3lvcFJ0Ylc5c3E2N3NOekdBVzdS?=
 =?utf-8?B?eWRRenBrdEQzTnAxRUgxMDFQRDV2NE5WWFhaZUFubUp4TDhiejh3c0gvTWJ2?=
 =?utf-8?B?TUVmVVB3TjByQ3pBUFJWTmRoRGVKQStlalRIblR0RTAwVzdLekNZcWZ6Tk9W?=
 =?utf-8?B?K2RsNW51cVZxZ292ZU5aOXZGNUpBcmpXR2lzaE5ycmxIMVhmNWNwVjg0Rmpj?=
 =?utf-8?B?RnJ3MTJZbllzWjgzR1oyV2UraGV5Tm5CSkNLT3piZzczYnRxeHVNZTFCRno1?=
 =?utf-8?B?UEloWW1ScVdlRm1EN0htYWxKTjMrb3RYMUdxSk9lclZWOUc3Q2JwbmNZeDdQ?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/3h+bc+1I+hSuxb4vT5hGC8c3a/xTe9AzpGUDW1TD0QO1q3fBu8PeUed0mGVko4adSJTXyn+haz+wekj9+Nz8SmClKLLJgjsaO/6ptWZHjleTWkyL/qdyWdeJr+PqVckZ3WnPdgLa8MOla+Xrxsc4rBCPRkFbHneLh0kGpd/FeKafun4/hWo5k65Zemi0eSpZx5ftBWJ5D1XTJHRwvjak6UOYOi+u80Erck/z93GxxMoGi/IQmQpL3OUA3xqnTwfjEIJvNlySqXvFBn7I8aGTXtsaTvKPG56nm072XZrcH/5cj0MDCQye0OD025eI7qwEWMinKH1AFpgVZ5xxitq4IGHa1wo8aWTqv9M9WP4TMhNJLs00iwUEDxWLNNeqPXO9xCLkaZjyXF/MZZHfNkUmAiNI2qN1NDcdvlzSl8VbHMHw05A8Fdh0soteztSXF7ZsXpsLTQTpUePsbrkmZ4m3spzsrvzR6Q0dcrs+V/h/krE8k6CQTu9GzANvBuuLcmQWq9OZmWIQAiCQRcdeQONLagZRnoEadVMw7XdxgBIOtMrDJz8WmL746JAvaFudJuRwswW5KCXHQ9zHf4tB/i1UR8n2Vo+PENwJuI6+pzxnGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b1b41b-39de-43e3-2b57-08dc4e6f2a7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 15:04:14.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNNS4PeRxegqoDcgmJAgFHI1I8QjNNFBfvR1UvZMKQSt6AnnMhjF/bQwp3Pdy5Mi/pBrYCtXy6gJcm4Evx36XK6rE0NZSZsR3ZiS3dsykq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=964 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270103
X-Proofpoint-GUID: ebrfvk3DAp3SdgSMu9A2KshoVgP1bmvl
X-Proofpoint-ORIG-GUID: ebrfvk3DAp3SdgSMu9A2KshoVgP1bmvl

On 27/03/2024 11:40, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2024 at 10:41:52AM +0000, Joao Martins wrote:
>> On 25/03/2024 13:52, Jason Gunthorpe wrote:
>>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>>>> However, I am not smart enough to figure out why ...
>>>>>
>>>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
>>>>>
>>>>>   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>>>> PROT_WRITE,
>>>>>   1748                    mmap_flags, -1, 0);
>>>>> → 1749         assert(vrc == self->buffer);
>>>>>   1750
>>>>>
>>>>> But I am not that deep into the source to figure our what was intended and what
>>>>> went
>>>>> wrong :-/
>>>>
>>>> I can SKIP() the test rather assert() in here if it helps. Though there are
>>>> other tests that fail if no hugetlb pages are reserved.
>>>>
>>>> But I am not sure if this is problem here as the initial bug email had an
>>>> enterily different set of failures? Maybe all you need is an assert() and it
>>>> gets into this state?
>>>
>>> I feel like there is something wrong with the kselftest framework,
>>> there should be some way to fail the setup/teardown operations without
>>> triggering an infinite loop :(
>>
>> I am now wondering if the problem is the fact that we have an assert() in the
>> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
>> other kselftest macro that). The expect/assert macros from kselftest() don't do
>> asserts and it looks like we are failing mid tests in the assert().
> 
> Those ASSERT_TRUE cause infinite loops when used within the setup
> context, I removed them and switched to assert because of this - which
> did work OK in my testing at least.

Strange because we make use of ASSERT* widely in our selftests fixture-setup.

setup_sizes() is run before the tests so it can't use ASSERT macros for sure;
maybe that's what you refer?


