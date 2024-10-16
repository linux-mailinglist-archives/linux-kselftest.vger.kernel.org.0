Return-Path: <linux-kselftest+bounces-19788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5773B99FD2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 02:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0FD1C2165E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 00:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2316107A0;
	Wed, 16 Oct 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QjMzvwDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLevXMFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BB10A19;
	Wed, 16 Oct 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038800; cv=fail; b=Tht81Fx1PFSOGJDRenyLUx1FPMlouKJwV/hcrs3U2BIuk/HTihjKJoUdC67yRQT8cQ0Qb43S9UyilqEHYq0u5FSbRHUK24+ubd97DJSlWDqlVSt3+1rYEWUsoQRY7/GWJ+Mka1knktPrUyn0edz87TWlXNejQF8YsiMutXhLWG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038800; c=relaxed/simple;
	bh=LnHEyOMy2NBD3K//509lb0Qrf8l9bodWMzANirknk9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKyyYprgQbDlisGzUXMiy6sDv50vwmdGasmmB/LWO5ePEi8pTiBnVY9rX7C8GnwZB161K635ofUGwNlqtEVchgU5GXKW3LnFNs19xVIWQVc6WsP4/fEl74HG6hGGgzTnwHhKAWrqLPw3QmekjGwkjZK3LwLNikExkGDbslGKqtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QjMzvwDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLevXMFa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtg8O023479;
	Wed, 16 Oct 2024 00:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IWlCC87S7btVMEdWvivXrfUfzN8GB/aVaMMey6tLxrQ=; b=
	QjMzvwDU7UdwmwQ/W3FbBhTWVm8owjhfSoFDsUuYBP6dYSBIBMXgSQGSUtNworsd
	V/uINIRVW3xGTbsKDFQI1WmZNT13kuZteoNsaSxJz8pMbQU8Nqr4FKe/RgycC946
	5AuRBbE+4eg24gjsU3BCZVBriqOyGDjh+8FcO4xAdPdhBiTlCuts79WT8FIuG2OJ
	N5lE0E86TmG8Rm+fN4/BmdqqtICplm7uCz97eAvH/CMZA2/3l+JrC+tUvGVpe+XK
	YJa3HvtXyegYbhFXHG53HSLhLEUCMBuFLXwm2MnzGPBWtWsfO7kTkO+DuVMyVX7X
	omPXAZgMbmSELCRLYWfj4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09j26p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:32:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G05hMI036038;
	Wed, 16 Oct 2024 00:32:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjehd82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAC2pCqH5kdmG/MAjo8YcpGxMqIZfr674cEE3yQvUIntX3vy5rT55lLT2zN4E2LNgK/cOe+8iW56Yq/ImTzkPloDZsgqjnL/Jk2wpMC6s48yTPj8OUp8FvAAognXfA6WGkwZO06gFuOKui7o6F3kJU0E/Bp+xB7J2qTSdZxql5Wsf210Z83EbuPzX4PeY1gbp2b7SegQw8iCpTXMrZV1Ahp2D66DaaonNVaOWdVyvmyag4sxDUZ/zOa7zpQZ0eq+jipe2tXqT7xPVrwkPDyyadcEoOWZGFquqtb0ODfqfctoTPM2JIAlgjDfzkoZNd38hGW1BKhE4UwxhQBlwtP70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWlCC87S7btVMEdWvivXrfUfzN8GB/aVaMMey6tLxrQ=;
 b=YSz1Z7LRG9RWSL7jSWQdyq2GjQLrsVZFtOItWQ/Xd+j3SikisrzjhuhO9k9PNM2EEdRP31OzMnTCpElOTtX/JRq5i1DoXjjSfyoHmIcvbZdAv1zXbdXa5UQmn+/KMFgjncRAURBXWTkar/fnXl/4vDEBAFKSraBkHRAIX1dk2c4E6QkstRS+00TO3QVn6sljChyG1TVvedFBNSobHQq2yt7ZNuNSow9l/p339L0f0PuBwSOPnCoxOR8J/y6XfVTWqYQTVg1jLhpxfKR2TaOYbk+gPi1Gf+IQ1tIPlLH/A6vSe7Bu9654ccKdhijzxe2/oY5Uy7erJcu2I/PYyc0Bjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWlCC87S7btVMEdWvivXrfUfzN8GB/aVaMMey6tLxrQ=;
 b=XLevXMFavxo8agbFn08OAjlSEwSctwZQBxB++S3kTg12/FhMsqLmPKF+m5vgq8SJWAmWErix1nBtxVex1tQDfmulaDmIuP+h7ddR0dGSo0vCF+x0RnuNBOcQS9bZlBTwNMT0/rYPB3BX+ww0pnzCPyTOv5+ZROKJc8+Xyd66mh8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 00:32:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 00:32:53 +0000
Date: Tue, 15 Oct 2024 20:32:50 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Message-ID: <sjvtcbqkewl6n2sh4eukwhj2grcun5outspl2chm3dmlomxgxh@sycexvmnhsn3>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-4-anjali.k.kulkarni@oracle.com>
 <36kdqgl425qzoqqbct4jusrzgpcn4cff62jaswcsrc4licalvp@f3okz2ygoww6>
 <B4DCFCF8-BD05-4379-BCAE-DD507D894032@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <B4DCFCF8-BD05-4379-BCAE-DD507D894032@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: fe59e3e2-eac7-4a8a-4def-08dced7a1270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEpLREFNVkVzWmp2TGs4cUtHUjBhRC83Q01YQkFLc0VXM3FkMmxZVjRZNTFE?=
 =?utf-8?B?TUczeHFubnp4b1JPZEt5RXVhK25nZlVkZHVmYnBobytFSTZVTzV1VnZrRDB1?=
 =?utf-8?B?YzNBN2FsVE5EVGRrTVBaYUh0WktNUUlzSSt4R2NtWWZZQkxFbUFnRU1IbGJl?=
 =?utf-8?B?Q2tUOERZWEFqS2VNcU1uK0Vac1hwV1JwRGJycjhuK0ltc2dkZW5RWFhTQ3gw?=
 =?utf-8?B?clpiblpjRmpUN2dEYlJtN3FRbjNjcklkajlncGNSY1Rqd2xSRENkMXhhWDA1?=
 =?utf-8?B?Ky8wUW9SMStJcmYxYmVKb3gvdDN2L2JtdlFmSWVTTWxzSEV6amIyTWY1VTJ4?=
 =?utf-8?B?bkF0K0hJelFFT1JSVkpuK3pxKzZNSWJmQWZuRWpyUEtzUnFpdVZiNC9JY3VZ?=
 =?utf-8?B?MDZBK2JnVk1HbURObDBLWnpLcjZWQ2JMYi9Cd1YzVklQclpYSVEzVFlaTjJP?=
 =?utf-8?B?bkQ1YWhWaHp2LytnU0M1c3lUWUZlNEJCT2FrbHJUcU5LZUlKc2ZWMnRXWDZE?=
 =?utf-8?B?NVF4ZFFHbEQ3bHVxbUE2eXhCbXFuUnNiY3hmNzF3L0pxbDFJbmppbkVaSGQ1?=
 =?utf-8?B?L21CbTN1K2hkTUpabVRQaWl4bU9idW9HR0xhVlBBUDZyMVNXWFVYN2NydFA0?=
 =?utf-8?B?Rm9KRk13ZysrZFAwZXp5SEZaK0s5cFpqWUZDcjduKzI3OHc0WGViRVpQZWxS?=
 =?utf-8?B?MDM2Z2lQWW5JMmh5Qm54eXhFN2NwVGp1S2tQREY3VSt3eWttVmJQQnl0TEVD?=
 =?utf-8?B?WVhxY3NHT29pQkd5VHJuVkY3Y3BNYWhZQU4yWWdjZnZCOTZsQk1kVE4vdDhP?=
 =?utf-8?B?Qjk1RW1DY2Fucm9nU2E2ZCtSK3ZhblVTYVhYc0t3WlgzNklaOHlMa3l5Mmd2?=
 =?utf-8?B?VjJVVEhCeVdZQURDRjJKa2ZPNGNGeXlZbXNqMk9wMHU5ZWUrN21MVVBiZTU0?=
 =?utf-8?B?SmxUSTBhcDUzRWwzS0Foa1RMci9QSTdIM3c3eG5nYm9JU3ZXNk1xWSswMnNE?=
 =?utf-8?B?ZnRvM085YktRODB4NmE1L3JyN0V0bThhWW1TbTZZdWhXSjBUR0ZGcStXSy91?=
 =?utf-8?B?L1J3UURCQkxkUEdtU1dwa0x3TDVTaS93Y2NJYTNiWllMaVlsckpTRFVQR0xI?=
 =?utf-8?B?SFJaWG5aWUV6amV5Q24yT3AwcTkzQ21WelhFaldBalZ3UTJCalRxWHhURHQ2?=
 =?utf-8?B?ZmhmYThzQkhhbDQ1cFB3WVd0R0VEZTVxR2pMbFdjelZpNEhGUGhhZTBacWQr?=
 =?utf-8?B?SE5SWUlCUmxGanR1aDl3Nzh4WFJ3cWY0bWo5ZHNLY3NVWTFGY3k4UmlIeVBD?=
 =?utf-8?B?TTA3enZoRS9OaW5SbmhoT00vWFY5d00yM0t2NGlKVzBESVljWXJaRWlGdDVZ?=
 =?utf-8?B?VmF0dVZLdmxyaGxKWlhZQVd6Ymw2ekkzZG5jcE1VSm1ZRDFSeVNjWkVlS2I1?=
 =?utf-8?B?aExmWFU1djVHclJnWmJYcERKd2M0ejRYbGc2RVpmWHE0ZjQyeWtPbVRlbWpL?=
 =?utf-8?B?L2tKdU5jMEhXZmg2aXNrWmVpTXlaMS9RalRBcDFCVzJUUkpRVHcxVlFWendE?=
 =?utf-8?B?b3dLN2cxVFVYWUFwSzdKaFpEWjBwS3RzbHJFV2xaWU5ZYW5ndmhPNUNoWDN2?=
 =?utf-8?B?YXp3Mk95U2lvdThVWTdSbkkxaWFXSWdrRlpaWFRZQXJvWk54THJ5bHYzWVMv?=
 =?utf-8?B?WmpTU1ZidTg3blpPcEZ1SnJnc3gvK0Y0SE9TMTZvc1BvVHlKU0FIYkt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJueFhnUHRnQjY3REtiSnZQbTB6UDVDTXc5SG1pQVBJdmJMTXZOeit1QUNo?=
 =?utf-8?B?MjUzL1YrZVF3NGtkaXNIMGVwY0w4dURneVc4ZEM2QlNnK1dMeXBJcWhITEE4?=
 =?utf-8?B?MjB1ZHJLaDhiWG9qUlIwV0JuYS9TRldhU3dCWE5TY3VBMEtRVmE0Ykw5L1Vq?=
 =?utf-8?B?K3hEK2JKUDh5NWpIbzRzbmZwYWQrV1hRTnBaRVNSd3dUcWlZUGZ1ODI3ZFhy?=
 =?utf-8?B?bWYvWkt0N0V6ZklKckR2clVUYUlwdG1pdnFsRWdDN3ErbUxnajZuekVROFVF?=
 =?utf-8?B?dmtJcWJzT21TZmtJSUJORUdwZC9SaktXbnhLZDVjdEk5Q1l1cUdQdDkzV3k2?=
 =?utf-8?B?b25xV3JDR3RZUGlRTkYyazJCa2FCdUxmaXc0elpSZTU2aU5MY1BvNHp6S1U2?=
 =?utf-8?B?bm1hc1RGQ1ovUXFsbm1yRFY2VkZqcHN1V3FRMDVxM1hkZFhxNnZ1K2RCYTl1?=
 =?utf-8?B?Z09BUXZWeStDV1RuZ2dWdVBjOTBmZC9ZVzBhOXoraXFsWldCM3JiaUVvbUlh?=
 =?utf-8?B?WWJsMXkxc05haER3VXRuejZYc2gxZVl5K0ZUUnJ2Vm94MjgwQVp4aFl3UFd3?=
 =?utf-8?B?Q2M3VUJ2WFlzZWVTQ01lQVZBRXhrdG4rWEVLM1YyN2c2dHMvRmk2Rzl3UC9t?=
 =?utf-8?B?L2RBK3Y5M0NoSC9tSGd5WFlUNmhrcXpEZWp1ZTJkWUgweU5TaUwyQnRVdGdX?=
 =?utf-8?B?cjRHaW5ScWFzb01ERUQwdGRTWEV6TU5hcFB1aGpHMGRHYzRpanlwTW8rMW9h?=
 =?utf-8?B?cUhKUGcwYm5RU1BjY3BuaHVzZ0RvTG05clIwQ1E4S1dnUnpSSnM2S3ROSEdi?=
 =?utf-8?B?TmRJN2REWmNERXpRc3lXQk1vNjZRWXE4dmFacDRPbTQ1Wi91TkpwSUZ0MERa?=
 =?utf-8?B?SXpMZjJGcytKQXZtVDZDSkQ1ekNsVkFLOW9ZcnFYTjA4QTk0M3M5WndYeVZG?=
 =?utf-8?B?cmYvQytVYVFFT3YyMWxkYSs1ZDFhYW1hV3p5SFprSE9KdGFBc1JmVHlVeHVQ?=
 =?utf-8?B?UzA4RkhxRnN4UVZaa0JsQXEzK1F6VlphQUtzdnFRYm9FcEd5MmtIaXpzNHBv?=
 =?utf-8?B?VVFLMlY5L21DVFlmVjNNL1QvRjdTL2sxN0d1VGFvQXVTMm9yWkUrcDByWCth?=
 =?utf-8?B?UFJuSVFLYTBRanFoSkpTdGZqUThtK3A1djFnVGZHWFVpeUVyK3VwTjY3M05j?=
 =?utf-8?B?aHBGY2xaZERaQk5HVXEzM2tFdGJTU0lyTE5rYXU5R1phNHRGMTZyYVVHUDhW?=
 =?utf-8?B?b2Y0RUVRWWRxRVJoN3piVmZlZ21EVWtIUFhEYjF3dzFQOERkMmhMZ0VualBE?=
 =?utf-8?B?bUdZcDJqR0Z6V1dPckp2TEl5VzNSWFp1TFlubnpzS29VeHMxK1B2aFBiMGZp?=
 =?utf-8?B?cEliekM2SGF2QjdVS2xucnJhZkRpSzhpQm00TkpqOHBzM21VVFphTjlyK2Jh?=
 =?utf-8?B?RTVoeDNvekh6bFlwQjV3clArOEVBcVlSVUsreWQxL3pWVzJ4dVJTczJzTWJY?=
 =?utf-8?B?dDB0NFlOK0lpdGI2N01FemZ1YnZYYkdTL2lGM2VrRzN0c0xTVG5Iekd6dlpG?=
 =?utf-8?B?eCthYnpKUzIrcEFIYk1Xb2tXVmxUQkl4SXorcHBvWGV2eUtGUnBtMThVY2U1?=
 =?utf-8?B?WStGWThyKzZQV1FTZnVhWEcyT2ducU1wS2QrV21TbFU5cnFDUE9GejNMUW5v?=
 =?utf-8?B?TkxRWkpML0c3SVlNZFFhb2EzZXJ3L0dhTCtoRXArQ25kYzAybUNWRjZLVmt6?=
 =?utf-8?B?L2pveEFIOFdSUUs2eFVsMnNKaW1pakJqZ001UGRPR3J4Z1B3R3NDY0pyTjAx?=
 =?utf-8?B?MW5XMitVdEhMUU1mYTd3SzRqRDRaRmgxcXhJODlZRWZiazBla21sc0dCUHFO?=
 =?utf-8?B?UFNna01pcWwySFNiUm5ZcEkzbW5vbnBaem5Ga0tLd1hyNVc4cVVxQjZrN0t2?=
 =?utf-8?B?dnY3bXNhZjFLUUdFL1J6ZjlwdjE4Ym1QRzFMQ0ZWSVI5VS95K3BnYjd1OGJC?=
 =?utf-8?B?VXc2OWhtSHFnWXM4c3BKcWgrRnUzOHZPTEJxL1FsR2dGazYrMFRDcFRIWnlF?=
 =?utf-8?B?bWdHTGhFM0NwYmFVKy9Md3RvMnptQStseTIyV3JIMHNRSWx3c1hBdVVjbW1v?=
 =?utf-8?B?QWJrbTVTTnYvdVpScmlMSnFIVkwzKzJZdUkrYTVkaWh5a1owbzQ0VmZFWFdG?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P8dKca/iU/MSeFi5jm6CXpO/uKTy+FCPwd00TG1IeWeu22jwACssVa9wQrnq+4OUKySV+6ar9k8dF9rOs0tP+o5r1TUW84CTW6Vq0BiQmNIFgyRqhtSY5+R214E6e3A1A/Y/EU6lDuKgK3GP383PvTiofi1vCg/5j07ayOAbmGk6gEPPYqml1bqrSTng5To/HoFqz5nTfWabykrEI5Yoe4usfOHaaZzbe5XOmbtvvWCGlI14V6VwCPvF9lshjw4PMSQ71j/3yB19dRtrFq9Q8MqTPfhy3BulDdsFermGPt7WlZj43GFHCE431S+poHSfy8u+O7ZFSVQX4esKOKSxxJ1PCS8lt/kRyKuHPvjiZD2/iB+9IihaOPxD4vkhnia/upug5zPXsJ+4OCgnTywWh22crY8mdueEOP/sdRAROhfhmv2EQhbDVHxTCYP+qGjA0FHgtqifbEst3K4OtjSJXFJxsnNfvYCidWx/X7jmdXhRbUJyKQOJJJWBdhWanLFOQtkvZmKn/HW/GdtZbdb5YOHu9GdK4otRysRyzdWdtu6GGeHeCczQDQClnYFPdXvLOg/SpqDSVjd8tMoi0VyhKidw2R6volp8yUb7kTgrgNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe59e3e2-eac7-4a8a-4def-08dced7a1270
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 00:32:53.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgqx1E2K2FeHygmjHwRmLqmba3AclHv6nkcxvcIMvpTD1Os1GnJwv2sg00HPKZ/PR/HX3qCAS3HKeyNbIRKtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_20,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160002
X-Proofpoint-GUID: bzovcu_zZPG4fzoVdsKHlmkiJ985-I9O
X-Proofpoint-ORIG-GUID: bzovcu_zZPG4fzoVdsKHlmkiJ985-I9O

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 17:28]:
>=20
>=20
> > On Oct 15, 2024, at 12:27=E2=80=AFPM, Liam Howlett <liam.howlett@oracle=
.com> wrote:
> >=20
> > * Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 13:30]:
> >> Test to check if setting PROC_CN_MCAST_NOTIFY in proc connector API, a=
llows
> >> a thread's non-zero exit status to be returned to proc_filter.
> >>=20
> >> The threads.c program creates 2 child threads. 1st thread handles sign=
al
> >> SIGSEGV, and 2nd thread needs to indicate some error condition (value =
1)
> >> to the kernel, instead of using pthread_exit() with 1.
> >>=20
> >> In both cases, child sends notify_netlink_thread_exit(exit_code) to ke=
rnel,
> >> to let kernel know it has exited abnormally with exit_code.
> >>=20
> >> Compile:
> >>    make thread
> >>    make proc_filter
> >> To see non-zero exit notifications, run:
> >>    ./proc_filter -f
> >> Run threads code in another window:
> >>    ./threads
> >> Note the 2 child thread IDs reported above
> >> Send SIGSEGV signal to the child handling SIGSEGV:
> >>    kill -11 <child1-tid>
> >> Watch the child 1 tid being notified with exit code 11 to proc_filter
> >> Watch child 2 tid being notified with exit code 1 (value defined in co=
de)
> >> to proc_filter
> >>=20
> >> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> ---
> >> tools/testing/selftests/connector/Makefile    |  23 +++-
> >> .../testing/selftests/connector/proc_filter.c |   5 +
> >> tools/testing/selftests/connector/thread.c    | 116 ++++++++++++++++++
> >> .../selftests/connector/thread_filter.c       |  96 +++++++++++++++
> >> 4 files changed, 239 insertions(+), 1 deletion(-)
> >> create mode 100644 tools/testing/selftests/connector/thread.c
> >> create mode 100644 tools/testing/selftests/connector/thread_filter.c
> >>=20
> >> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testin=
g/selftests/connector/Makefile
> >> index 92188b9bac5c..bf335826bc3b 100644
> >> --- a/tools/testing/selftests/connector/Makefile
> >> +++ b/tools/testing/selftests/connector/Makefile
> >> @@ -1,5 +1,26 @@
> >> # SPDX-License-Identifier: GPL-2.0
> >> -CFLAGS +=3D -Wall $(KHDR_INCLUDES)
> >> +KERNEL=3D"../../../.."
> >> +
> >> +CFLAGS +=3D -Wall $(KHDR_INCLUDES) -I $(KERNEL)/include/uapi -I $(KER=
NEL)/include
> >> +
> >> +proc_filter: proc_filter.o
> >> + cc proc_filter.o -o proc_filter
> >> +
> >> +proc_filter.o: proc_filter.c
> >> + cc -c proc_filter.c -o proc_filter.o $(CFLAGS)
> >> +
> >> +thread: thread.o thread_filter.o
> >> + cc thread.o thread_filter.o -o thread
> >> +
> >> +thread.o: thread.c $(DEPS)
> >> + cc -c thread.c -o thread.o $(CFLAGS)
> >> +
> >> +thread_filter.o: thread_filter.c
> >> + cc -c thread_filter.c -o thread_filter.o $(CFLAGS)
> >> +
> >> +define EXTRA_CLEAN
> >> + rm *.o thread
> >> +endef
> >>=20
> >> TEST_GEN_PROGS =3D proc_filter
> >>=20
> >> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/t=
esting/selftests/connector/proc_filter.c
> >> index 4a825b997666..6fb4842894f8 100644
> >> --- a/tools/testing/selftests/connector/proc_filter.c
> >> +++ b/tools/testing/selftests/connector/proc_filter.c
> >> @@ -1,4 +1,9 @@
> >> // SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> + *
> >> + * Copyright (c) 2024 Oracle and/or its affiliates.
> >> + */
> >>=20
> >> #include <sys/types.h>
> >> #include <sys/epoll.h>
> >> diff --git a/tools/testing/selftests/connector/thread.c b/tools/testin=
g/selftests/connector/thread.c
> >> new file mode 100644
> >> index 000000000000..8c9abf6115d6
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/connector/thread.c
> >> @@ -0,0 +1,116 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> + *
> >> + * Copyright (c) 2024 Oracle and/or its affiliates.
> >> + */
> >> +
> >> +#include <pthread.h>
> >> +#include <stdio.h>
> >> +#include <unistd.h>
> >> +#include <stdlib.h>
> >> +#include <signal.h>
> >> +
> >> +/*
> >> + * This code tests a thread exit notification when thread exits abnor=
mally.
> >> + * Normally, when a thread exits abnormally, the kernel is not aware =
of the
> >> + * exit code. This is usually only conveyed from child to parent via =
the
> >> + * pthread_exit() and pthread_join() calls. Sometimes, however, a par=
ent
> >> + * process cannot monitor all child processes via pthread_join(), par=
ticularly
> >> + * when there is a huge amount of child processes. In this case, the =
parent
> >> + * has created the child with PTHREAD_CREATE_DETACHED attribute.
> >> + * To fix this problem, either when child wants to convey non-zero ex=
it via
> >> + * pthread_exit() or in a signal handler, the child can notify the ke=
rnel's
> >> + * connector module it's exit status via a netlink call with new type
> >> + * PROC_CN_MCAST_NOTIFY. (Implemented in the thread_filter.c file).
> >> + * This will send the exit code from the child to the kernel, which t=
he kernel
> >> + * can later return to proc_filter program when the child actually ex=
its.
> >> + * To test this usecase:
> >> + * Compile:
> >> + * make thread
> >> + * make proc_filter
> >> + * To see non-zero exit notifications, run:
> >> + * ./proc_filter -f
> >> + * Start the threads code, creating 2 threads, in another window:
> >> + * ./threads
> >> + * Note the 2 child thread IDs reported above
> >> + * Send SIGSEGV signal to the child handling SIGSEGV:
> >> + * kill -11 <child1-tid>
> >> + * Watch the event being notified with exit code 11 to proc_filter
> >> + * Watch child 2 tid being notified with exit code 1 (value defined i=
n code)
> >> + * to proc_filter
> >> + */
> >> +
> >> +extern int notify_netlink_thread_exit(unsigned int exit_code);
> >> +
> >> +static void sigsegvh(int sig)
> >> +{
> >> + unsigned int exit_code =3D (unsigned int) sig;
> >> + /*
> >> +  * Send any non-zero value to get a notification. Here we are
> >> +  * sending the signal number for SIGSEGV which is 11
> >> +  */
> >> + notify_netlink_thread_exit(exit_code);
> >> +}
> >> +
> >> +void *threadc1(void *ptr)
> >> +{
> >> + signal(SIGSEGV, sigsegvh);
> >> + printf("Child 1 thread id %d, handling SIGSEGV\n", gettid());
> >> + sleep(20);
> >> + pthread_exit(NULL);
> >> +}
> >> +
> >> +void *threadc2(void *ptr)
> >> +{
> >> + int exit_val =3D 1;
> >> +
> >> + printf("Child 2 thread id %d, wants to exit with value %d\n",
> >> + gettid(), exit_val);
> >> + sleep(2);
> >> + notify_netlink_thread_exit(exit_val);
> >> + pthread_exit(NULL);
> >> +}
> >> +
> >> +int main(int argc, char **argv)
> >> +{
> >> + pthread_t thread1, thread2;
> >> + pthread_attr_t attr1, attr2;
> >> + int ret;
> >> +
> >> + ret =3D pthread_attr_init(&attr1);
> >> + if (ret !=3D 0) {
> >> + perror("pthread_attr_init failed");
> >> + exit(ret);
> >> + }
> >> + ret =3D pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_DETACHED)=
;
> >> + if (ret !=3D 0) {
> >> + perror("pthread_attr_setdetachstate failed");
> >> + exit(ret);
> >> + }
> >> + ret =3D pthread_create(&thread1, &attr1, *threadc1, NULL);
> >> + if (ret !=3D 0) {
> >> + perror("pthread_create failed");
> >> + exit(ret);
> >> + }
> >> +
> >> + ret =3D pthread_attr_init(&attr2);
> >> + if (ret !=3D 0) {
> >> + perror("pthread_attr_init failed");
> >> + exit(ret);
> >> + }
> >> + ret =3D pthread_attr_setdetachstate(&attr2, PTHREAD_CREATE_DETACHED)=
;
> >> + if (ret !=3D 0) {
> >> + perror("pthread_attr_setdetachstate failed");
> >> + exit(ret);
> >> + }
> >> + ret =3D pthread_create(&thread2, &attr2, *threadc2, NULL);
> >> + if (ret !=3D 0) {
> >> + perror("pthread_create failed");
> >> + exit(ret);
> >> + }
> >=20
> > I expected the test to check for the correct value to be returned?
> > Could you use pthread_join() and verify the same value is returned
> > through the new mechanism, or will they not match?
>=20
> This is a manual test, you need to check visually that the proc_filter
> Is returning correct values for the 2 cases. I can make this an
> automated test, reading the output of proc_filter directly from a file
> and checking the values are as expected.
> There is also another test program which does an automated test
> of the values returned by proc_filter for scale (100k or so), which I
> will send out later. (The co-author of that patch, who wrote the
> original code for processes, is away - @peili.io@oracle.com)
> pthread_join() cannot return a value to the kernel, so we cannot
> use it to verify the new mechanism.=20


Okay, as long as there is an automatic test then it's probably fine.

>=20
> >=20
> >> +
> >> + /* Wait for children to exit or be killed */
> >> + sleep(30);
> >> + exit(0);
> >> +}
> >> diff --git a/tools/testing/selftests/connector/thread_filter.c b/tools=
/testing/selftests/connector/thread_filter.c
> >> new file mode 100644
> >> index 000000000000..3da740aa7537
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/connector/thread_filter.c
> >> @@ -0,0 +1,96 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> + *
> >> + * Copyright (c) 2024 Oracle and/or its affiliates.
> >> + */
> >> +
> >> +#include <sys/types.h>
> >> +#include <sys/epoll.h>
> >> +#include <sys/socket.h>
> >> +#include <linux/netlink.h>
> >> +#include <linux/connector.h>
> >> +#include <linux/cn_proc.h>
> >> +
> >> +#include <stddef.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <unistd.h>
> >> +#include <strings.h>
> >> +#include <errno.h>
> >> +#include <signal.h>
> >> +#include <string.h>
> >> +
> >> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_m=
sg) + \
> >> + sizeof(struct proc_input))
> >> +
> >> +/*
> >> + * Send PROC_CN_MCAST_NOTIFY type notification to the connector code =
in kernel.
> >> + * This will send the exit_code specified by user to the connector la=
yer, so
> >> + * it can send a notification for that event to any listening process
> >> + */
> >> +int send_message(int nl_sock, unsigned int exit_code)
> >> +{
> >> + char buff[NL_MESSAGE_SIZE];
> >> + struct nlmsghdr *hdr;
> >> + struct cn_msg *msg;
> >> +
> >> + hdr =3D (struct nlmsghdr *)buff;
> >> + hdr->nlmsg_len =3D NL_MESSAGE_SIZE;
> >> + hdr->nlmsg_type =3D NLMSG_DONE;
> >> + hdr->nlmsg_flags =3D 0;
> >> + hdr->nlmsg_seq =3D 0;
> >> + hdr->nlmsg_pid =3D getpid();
> >> +
> >> + msg =3D (struct cn_msg *)NLMSG_DATA(hdr);
> >> + msg->id.idx =3D CN_IDX_PROC;
> >> + msg->id.val =3D CN_VAL_PROC;
> >> + msg->seq =3D 0;
> >> + msg->ack =3D 0;
> >> + msg->flags =3D 0;
> >> +
> >> + msg->len =3D sizeof(struct proc_input);
> >> + ((struct proc_input *)msg->data)->mcast_op =3D
> >> + PROC_CN_MCAST_NOTIFY;
> >> + ((struct proc_input *)msg->data)->uexit_code =3D exit_code;
> >> +
> >> + if (send(nl_sock, hdr, hdr->nlmsg_len, 0) =3D=3D -1) {
> >> + perror("send failed");
> >> + return -errno;
> >> + }
> >> + return 0;
> >> +}
> >> +
> >> +int notify_netlink_thread_exit(unsigned int exit_code)
> >> +{
> >> + struct sockaddr_nl sa_nl;
> >> + int err =3D 0;
> >> + int nl_sock;
> >> +
> >> + nl_sock =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
> >> +
> >> + if (nl_sock =3D=3D -1) {
> >> + perror("socket failed");
> >> + return -errno;
> >> + }
> >> +
> >> + bzero(&sa_nl, sizeof(sa_nl));
> >> + sa_nl.nl_family =3D AF_NETLINK;
> >> + sa_nl.nl_groups =3D CN_IDX_PROC;
> >> + sa_nl.nl_pid    =3D gettid();
> >> +
> >> + if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) =3D=3D -=
1) {
> >> + perror("bind failed");
> >> + close(nl_sock);
> >> + return -errno;
> >> + }
> >> +
> >> + err =3D send_message(nl_sock, exit_code);
> >> +
> >> + close(nl_sock);
> >> +
> >> + if (err < 0)
> >> + return err;
> >> +
> >> + return 0;
> >> +}
> >> --=20
> >> 2.46.0
>=20
>=20

