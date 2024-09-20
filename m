Return-Path: <linux-kselftest+bounces-18185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832597D9E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C643A28226C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5A17C7BD;
	Fri, 20 Sep 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXOKgqhG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lz1e9WVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1244C81;
	Fri, 20 Sep 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861170; cv=fail; b=fB/344U9xa5uqGjhdzbpVmiQlcnSSfw8+9BIvdP+qqBsLxUUP/6jC/PziIsESFUvZ9OWjkW78sBMJESCYCoB1V6GAGHFG7vvZwcvpeeKQiy9vZlnQsvRJLIfgoTC//eDmSii52r5+7tKkzyxoINQdMqK+8QATknac2zCXZf4YJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861170; c=relaxed/simple;
	bh=BIGt+o1I/TLH9tHzwgMnVOb4vnl0oGisUwqmXuqabKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gUmwN3GyWSxCI2HSOxe5vZGyzToOf4drnUpYFg6m3pcj//XWrOs7JZHXm95KkSr4sY6+T/XuP5zCSI5JONqAirvOvEjS5HNPZlU7rOHdHcONEeTdN2iULvQwPXAnGtuN+N444TGgB5sxyCPyZn2dkd2OUOAUXf7dazg0LMXsCgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXOKgqhG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lz1e9WVQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItXu0005907;
	Fri, 20 Sep 2024 19:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=BIGt+o1I/TLH9tHzwgMnVOb4vnl0oGisUwqmXuqab
	KY=; b=JXOKgqhGdFWk7ZQbbI6Raa8J7p/NNqBBKi5QkI9EZdZTxjFAVG3ZsT1Fw
	S4gn9zknIKz6t0J07CE4pH0mK9BfT9QZYbKI+IC9DVxDMO0CDK0z7qeN5OQXU6xQ
	5DPmTFmUR09fAyO5QPdR2TpwKyqH44VkshBaUk1YjuBenWg7v0rIYIPnJwa6jcnV
	7MvU2UyP9KE2wYQXetX/OxEvJty3vDkmtsuLuMda7OWiqLdD4sOnVErQ2C91RRvm
	9pnHoH8+uDuWDSSvSDk6lTPqMFPSXxXUrqFQVT77rLHDjUlp5PbZaII+JxcE6Mup
	VB3KHxpdy6Ha9yEGnpUVGRDr1V+1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfynma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 19:39:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KHoAI1034144;
	Fri, 20 Sep 2024 19:39:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycnh0a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 19:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F57Y3HIEGbbz4MgOa2bKXi2OWfB69KHvufh1DQ5tJcRYCniK2oJ3J7op3GuRFZXDS8+nST8PRkFSjYwq8+yGLshRdV44hahO9VICv4GTON6pxemnHlonVZioMRrsg9R+b88Rl06QngoWhp5SwchoJ5MDHIk8HQW8oqlqE2Y+ZLCLr6u2Z/l5eBpsi+RB3syZ0dzbbtRhuSx+U0lcvsaTAIR3Tmb9mN0Xvk3cd6LzCTI7q+HnHw3j7fT00sn3xs6EkMbEYSNl0ix7vblAHIurk2R5+VhTh9cDXY5m9WyIc2OZsx2K+hovS7WAHHjmy9XLRj1eZ/z8zn8I91gKxg4Eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIGt+o1I/TLH9tHzwgMnVOb4vnl0oGisUwqmXuqabKY=;
 b=dFC0LM5OU2PwLDCY5ambE3Xf1ehCy1RYClj6hPlImf8Vlw8QVifEBBCW3bYytQeyEJTv/HjNEsYqCADh3329en2vmbx9FHJXnyEhBiw0JQdFaIKoTn2an3zv89H/eerGEqiTexLe0F0yXcnkKWLTBppViqymsvRQQUTC43Zv5daA5Oxg9Y1yF7MTe0Jj7Ae3F/8UAjEhwMeajAR+M1sN2NCL1ONMTwH3/JL1Oi+bmTPM2yCfR77RQq7EPWfwywAY1IfvKaU7wMCiU7Oc8BvwJPpVF1ZGingkcQW6TN0LJEUuzgyIhgW3jdqCfLqnM5NqHROnHe636BalTYn/iTuQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIGt+o1I/TLH9tHzwgMnVOb4vnl0oGisUwqmXuqabKY=;
 b=Lz1e9WVQdMYu/U8Nw/yC8quphACXxThTitpw2phLORBAk2Kw01XjuNv+iASwETras0dk96pVBhX1lQKjPcjybfCC21ioCyf6D9YsHkatbSd4F4gfmGD1S2avF1jeJYhiPfoJarQCYxl56O/IhAwD00gP3i6/+58pGBdMBajucEM=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by MW6PR10MB7551.namprd10.prod.outlook.com (2603:10b6:303:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Fri, 20 Sep
 2024 19:39:04 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 19:39:03 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "alexjlzheng@tencent.com"
	<alexjlzheng@tencent.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Christie <michael.christie@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>,
        "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Thread-Topic: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Thread-Index: AQHbCvFjDQh6bC0JZkaatsp5diOi/LJggrGAgABOzgCAADLggIAADy8A
Date: Fri, 20 Sep 2024 19:39:02 +0000
Message-ID: <6D9B4443-4293-4EC8-A64A-1CDDB2CE4E4E@oracle.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
 <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
 <20240920110022.GA15795@redhat.com>
 <72426AB7-DAF9-4779-A29E-EA5FF8816695@oracle.com>
 <20240920184430.GB20847@redhat.com>
In-Reply-To: <20240920184430.GB20847@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|MW6PR10MB7551:EE_
x-ms-office365-filtering-correlation-id: 3194a57a-34f0-4745-2638-08dcd9abe1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXNKYW1uZ1p1TzhsWFdnRzNYSGVMYUFNS0duNEYxV2xTb3B1c0ZVUDB3MExu?=
 =?utf-8?B?T1BITUtydzRDaG8xQ0c5YkE5b1NSMlpYYjQxVlM3S2k5VFBxekJJWWU1bmps?=
 =?utf-8?B?Vkh2LzhUa2toaXdkbUtVcGs5bWZ5UWhiZzFuMTJzbFFRQnpnMWlmMUJFR0RZ?=
 =?utf-8?B?V2dLQ0JuRHFsWmRxdWlseTFaMVZ3c1ZJb2xGeWk1dFppZlg1d3dxU3JlTmJ1?=
 =?utf-8?B?WnZCcm54MEtlQVA3YS9Yd3RQeG1xN2d3MGUyaGg3eFAyUndPRlM1aU5GR3Rk?=
 =?utf-8?B?aXJ4L1lDRkp5U0JKOUR4RTJVZ01UVmdjNWlRalo5VnJtMkNzS1Npb3ZpaVhU?=
 =?utf-8?B?cTBIRVJwZmZua2txMDY3c1JjWnhZbmNWbC9PYmNsWXZMWWxQRXB0clB0eWVC?=
 =?utf-8?B?Ryt3d0R4OC95UVJEcEUyQXByRCtXWVFkZDdzU3JwRlRjMWE5Zy9ESGFORDA5?=
 =?utf-8?B?ZENWemFMVzhxWmllQUd5czhyM1ByTnkzbDJlY0kyck5qZytEdThmUWU3bitH?=
 =?utf-8?B?SXlPQUVFUE5pQmc2NEkzSytJOEdsUnluOUhUMXRSN20rbTVnUFpPVUJ1WmRQ?=
 =?utf-8?B?d3loOU1IL3RLTjdhMm96aVhGUnphTjZ2ZnFDZ2VJMjlPSjBNTE5WdmdsS1VY?=
 =?utf-8?B?TE1TV1BubXJ0eW96dmVmNHNjakwvNGlVb1ZBeDIxeTRDVUErQkszdUlmOHBP?=
 =?utf-8?B?MitPZlNFZUdVcEhvUzhqN24ySlh5eklqaWRTRHB5dllxeUdjQnNqTTVHOWNY?=
 =?utf-8?B?WnpOOU5sZkEvaGJLNGVoS0s2UVdjOS9lS1M4cFoyTkN2V2ozZlZxdkY5Kytt?=
 =?utf-8?B?UnROcnhyWHpKV0lUR1pVSW9xemFNRjdDbUdHbXpQN0pUZG5Ub3FTbzR6T2Nv?=
 =?utf-8?B?QVFqcE1ERmdDMlZ1TWNlL3hXRGFJOUNjekJsV2JqSDdVZTlKT25DK1NERjFz?=
 =?utf-8?B?eDYzaGhTQ2xRWlF1aEh1WXpvMnNjWGNvaVNsV2I3Wm1OVXJxZDBFRU1rR3dm?=
 =?utf-8?B?TjN1SEhYOXJTSEdhdDJxYlpzUXUzcllvekpnclE4Q2JROWt0aFJXd0hvU25D?=
 =?utf-8?B?aFBtdXh4RldodVlLZExuZnVTVnBFZ2tmN01VRG1uem8zYnVrbEdDREhSV1dz?=
 =?utf-8?B?ZFIyOS91bUFwYWVUMmhDYVVKbGswUS9Ic1RHVnk3OHlVbGZjWG1CckVzUkdl?=
 =?utf-8?B?SWU0SngwOHZaaTJnZjlvNm4xSVJ2U3ZxdS9jUTQveElSSW9FcmExaWlVbWpK?=
 =?utf-8?B?RUtUcVB2SHBCa0xFSTdQMDVwMVlkajRYbjU5MWI1bkk0aEVYNXlCSGMwRHZF?=
 =?utf-8?B?RzRPaVc5OHB3MFNFbmt0V3VXemRrZHIrd1NGYzdHLy9vVTI5em5JNUFhNFNC?=
 =?utf-8?B?WDdBUzNHZ1owSFNNbFkvbS8yMnVkekQ4cnU0L0VGRFpyRUo4V3pZTWxUTFQw?=
 =?utf-8?B?Z1M0d21ueG5hVjFVOFFmc04zRFNrQXlJTUIyNzNKc09jQ2lJQWhxZHBkRTZ1?=
 =?utf-8?B?aGlIdVljVmpyYmlDSE95NWNSMXFGVGxGVUxHdUsxVmF5R2w4bW1WRis5M3gw?=
 =?utf-8?B?VDAyOXBTRk90TnA1YTFpZUZQVHk5czhWd3pxWGd6MDM2cjZvQndTaXd2QmhD?=
 =?utf-8?B?TmNsZi8vRmxQT2xRbmQrZWNGVjhVemxTblQwYkpQSDM4T2ZLS0kyY2tiWEZB?=
 =?utf-8?B?OU1IU0svZ2ZvTjFic25tQ3l0T2hmZFByNHRRQm1QQ0dtQUYzTVFjeVlxNUVx?=
 =?utf-8?B?dzl4dFBDMCt3b3N4ZDlaUlhwVDRPZlZpTVd1cEx6eDlCRHU1ZmR1c1pVWWFs?=
 =?utf-8?B?VmduTnl5Ry9pWnZtdkl6NkNGUXkxY2pRNnJyK0hacjZSMnlHUmpkWXlMNFJz?=
 =?utf-8?B?VzZOV0FPT1NkR0dBYmpzemYvb0MrQ0pQTGhtS3BBUG5uVnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzF6V1lOQlJkMDBzOFpzbXVlT1FzV2xpWVVwczFsN2tndnk3S2tEQUQ5SDJv?=
 =?utf-8?B?ajMzZ3I5NUpVakpORzZoMVRBZ3RsRnVScXNPNE1PbnFTRklPZGh6M2pnNDNO?=
 =?utf-8?B?VUt2NCszcUNGQ2ZYa0RMTjgxYmFEU0VFOFVkMWpVYkRDenpyQithMU0yM0Vw?=
 =?utf-8?B?SE9oc0YvaHNtcDJvYnlwOFo4Mm9MWFdvSHFlNW9yclljODBVMXR2K2o5ekRV?=
 =?utf-8?B?R0U5R01VLzN1eEYyclRhMU1aRnJxa0kvQlAvOUNaVGlibnFHdnltU2dqRy9V?=
 =?utf-8?B?enQvTEsxajR1NHhJdDdvdFdzZ1dzSFZTeC9FWHhHVjJLYTZnUW9HdFo2Skd1?=
 =?utf-8?B?Wk9EeGhJbm9YZEVIZlpYbXgva0VlYlZ4Q1IxZ3F4Q2R4ckJRTVhHdy95Rkhx?=
 =?utf-8?B?dEtJT2tzaURzRTE0WFI1VEJqRmdyYjBDc3RGcFJaVlRKSFRrYjdwYU1hZGZa?=
 =?utf-8?B?TVErVWJpQStqbktzRy92QXp5QzExbHVRUkFsQm0rTnhnRnN1M1VMbmxNd1pM?=
 =?utf-8?B?dWRMZlQxLzhUNWFZTE9HRWk5Mzh2dDN1dFJ4VDFhK3BTMHFlNVRBeGV0QzE4?=
 =?utf-8?B?aStTRnlxQkRPMVZlV1lEQ2VFZEI4K08xQnkvdXphcFZTeDN6WUh4K2hpU3gx?=
 =?utf-8?B?ajh2NDkrMVA0WlR5OHdkSFJ3MERvcjQ5TGlCVGVzZ0NYZDlORTdlRGI4bDZN?=
 =?utf-8?B?T0RheGVDOU92ZzhmeFRxMC9zbFBOY0txTnZUNGJJOFJiaHI1SDBtRkQ4a0JG?=
 =?utf-8?B?RnNMM1oxQ1pZN2huOGl2Zlk3c090eWtOS2JJQnRWQ0MvcEtLZU9yZUxlUDZF?=
 =?utf-8?B?bjByUDlWSDdmb0x0Y1lZZzZWNEdDaEpkM255d1pFUWRiU05UK0lDRTVtazFO?=
 =?utf-8?B?UUxLQlVLbTNxLzN2M2FkR0tTcSt1bXQ4UW1xWVhXbFEyTk1WOFVBcW9oNlNS?=
 =?utf-8?B?bVdncndhRTB4NVdEd1BFL3REQm8wWkFibStDQ2tOclQ3SHFxRlV2NUpJcEVm?=
 =?utf-8?B?ZFM3TC9nNGJmUjBNR0Z2TWRFRDhMa2hUL0hsWkN2SEdDMzlwZHpXK2E3RFha?=
 =?utf-8?B?ZGozN3JzVTFkRWtTM1hpa0lyVnl1UTMrZVo1SzNwUm1HUWhOS2VuNTdkUmEw?=
 =?utf-8?B?bUNuVkZxekszQTRaOFFRaWNoZTREdURkeTU4K1dITklCaDBzeTl5a2pPRjRM?=
 =?utf-8?B?S01nTTVWRU9wckhCdnpGd2JpeGdZeFM5U3gzU2NPd0t0WHVQR2l5ZWxKRGVB?=
 =?utf-8?B?azQ0SXo2aXRMTzFYWjcxZFJ5MkY1SEV2ZlNydEpEVGNmbTFTaFJwUjZubVNI?=
 =?utf-8?B?VDF0T2JuYytaMnJmRi9qQTV6S2RTZDdYb0ptY09ZbG00ZS9qQ1FuV3VQeWZN?=
 =?utf-8?B?RHBVZWlBQmR1M3drYzJuRmdKNndJSU1YU3VYYU1tNi9UN0cyWkMzN2Y1OXBp?=
 =?utf-8?B?SFNsRFJKaVI2ZTFybjN5OUkybUpXSmladlFyZkx4cXRNdVFNM0d2eG1ueU1W?=
 =?utf-8?B?ck9wM3JkZWg2Y3Y2ODcwV0dwRERpZTJyOStXdW5wZFFPOFprL2Vic2doa2RS?=
 =?utf-8?B?NUZsWkcweEhES2lxbk9yMkp4Y3dLdWU4ODNvN2RUZ0pZUkhUd20zcGVFbkZy?=
 =?utf-8?B?SXIrUFRaQjZRajdSei92RjRIald5M05HOU80aVJFWlRvOStMMXZTb2ZTNm5F?=
 =?utf-8?B?WCtCb3pNbWVmaWdnczAzZTNJb2ovMzRuRHRLSDJiNGJMUlByYUtvUUZvMC9x?=
 =?utf-8?B?QlBYRFdORStVcUErUUVnaU5DWjMxc09uMmVPTFBVRUdNTWFkMzJVZy96OERD?=
 =?utf-8?B?RUtaNUE3RjE4b0lucmdqSDBIV05Nd2lZUk1OYU9xTzJjMnRJSmsrTTluV1hT?=
 =?utf-8?B?enZpNlhsMVBmakVkRFhvSjNsamtqcXFORFhNSzU3MkZRcTM1NGpIcHNvdG41?=
 =?utf-8?B?NTlxdFpIZWVJQThxb3FyVURNQjBxcjExd1g4QU5XZXZSelVjWUVjL2JBTDhh?=
 =?utf-8?B?UXhKVjRuV1VtZzJZWCtoTWlQbGVxQStHMGpBUFRwU3hWZnZDMVZTbEpIMW9k?=
 =?utf-8?B?d2NpN3lDeFNkSVlISHJHZHJ3dTV2ZnAyd1ZmWW8vVXB3ZVJZbHE2eURjeUxM?=
 =?utf-8?B?ZlU5THBtUUhCcjdsTWhsZ2doelVvK1h1K2lPQTJYa3dSRHllcFVpRXBlRkJJ?=
 =?utf-8?Q?nJqz7c51B9hU/gN5gsLpfNe2lJ9m3Kqkkk9Qb45zUJUt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D63EED5763340489FAB4F47157A9C2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KKBUwU9h8r9e8rTr/cC7eEqXDjSRGJBlOT4Ffv46pHT7hbuLWmvSM8pydP1i3A+QS/2d8LsCOa54us2s4UrHl56J/1e1QbhuyTOIhX/wLJr+L+GqQRVIDn5BS8nyObN1N9ERs4LKTdAYI6p49D5uDrEsov2ficDFXjDtJBG/Bd3kuQPsIV6H5yFKto54lMYrOMEcwHWYmG8GzJFB4dTsAYHbQmo4ntuYKfJ2EeQV9tuS+/jTtjSpXdIaR0yAzAfEKoOyhP2tonZeiEyF+sJvBnpRC2EVGNplKdKSrX2N4V+0gZDkrWPGPDQyzU5FimVXLV7/CadONDqq13+wDilAm2WME1uSfAHubGJAFf4n2B1m1bMbG7Qd3F7xdcJOrcA9BWmKOkOk7ntMMMp/VuVNtBd/Uvy4EFD6k99naMzAni+ExNuGoh3IKcRRNFAiTFDP+e9yxh2b9Sx04seodsOTKpoNPHFpV5ELyVSMk3+zsqIsaHk6TDp0emZIbOD7AqIOW9mIqYGGhiOAwtCM6rwVcPBzqzci6xPZs2erDNaq/d5Bo7OjdRKaExHtfPkAEMB9RGFCPIYmGF0deNEnAcAMyG+JLIJZOMAiyFmtCVL2IbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3194a57a-34f0-4745-2638-08dcd9abe1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 19:39:02.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvU6MLAE5xv2cj/Om01ns3iB+lbenBAbntQzoRQJVZEeBdrjd+dRBdUWmDFFq4l4BnoYRNRo4vTv9zZzM0XhuUyhB+7/QOfD/lf8uQ3kP10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_09,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200142
X-Proofpoint-GUID: YkgXjVduCRFfXSZ0YEWlbLBvOv-YzYN_
X-Proofpoint-ORIG-GUID: YkgXjVduCRFfXSZ0YEWlbLBvOv-YzYN_

DQoNCj4gT24gU2VwIDIwLCAyMDI0LCBhdCAxMTo0NOKAr0FNLCBPbGVnIE5lc3Rlcm92IDxvbGVn
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMDkvMjAsIEFuamFsaSBLdWxrYXJuaSB3cm90
ZToNCj4+IA0KPj4+IE9uIFNlcCAyMCwgMjAyNCwgYXQgNDowMOKAr0FNLCBPbGVnIE5lc3Rlcm92
IDxvbGVnQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEkgZG9uJ3QgdGhpbmsgeW91IGNh
biB1c2UgdGFza19zdHJ1Y3QtPmV4aXRfY29kZS4gSWYgdGhpcyB0YXNrIGlzIHB0cmFjZWQsDQo+
Pj4gaXQgY2FuIGJlIGNoYW5nZWQvY2xlYXJlZCBpbiwgc2F5LCBwdHJhY2Vfc3RvcCgpIGFmdGVy
IFBST0NfQ05fTUNBU1RfTk9USUZZLg0KPj4+IA0KPj4gDQo+PiBUaGFuayB5b3UsIHRoYXTigJlz
IGEgZ29vZCBwb2ludCEgSG93ZXZlciwgdGhlIHVzZSBjYXNlIG9mIHB0cmFjZSwgd2hpY2ggSSBh
c3N1bWUNCj4+IGlzIGZvciBtb3N0bHkgZGVidWcgYW5kIHRyYWNpbmcsIGlzIGV4Y2x1c2l2ZSBv
ZiB0aGUgdXNlIGNhc2UgSSBhbSB1c2luZyBpdCBmb3INCj4gDQo+IFdlbGwuIEkgZG9uJ3QgdW5k
ZXJzdGFuZCB5b3VyIHVzZS1jYXNlLiBPciBhbnkgb3RoZXIgdXNlLWNhc2UgZm9yIGRyaXZlcnMv
Y29ubmVjdG9yLw0KPiB0aGF0IEkga25vdyBub3RoaW5nIGFib3V0LiBCdXQgdGhpcyBpcyBpcnJl
bGV2YW50Lg0KPiANCj4gVGhlIG5ldyBQUk9DX0NOX01DQVNUX05PVElGWSBmdW5jdGlvbmFsaXR5
IHlvdSBwcm9wb3NlIHNob3VsZCB3b3JrIHJlZ2FyZGxlc3Mgb2YNCg0KWWVzLCBhZ3JlZWQuDQoN
Cj4gd2hldGhlciB0aGlzIHRhc2sgaXMgcHRyYWNlZCBvciBub3QuIEJ1dCBpdCBkb2Vzbid0IGJl
Y2F1c2UgdGhlIHVzYWdlIG9mIC0+ZXhpdF9jb2RlDQo+IGluIHlvdXIgcGF0Y2ggY29uZmxpY3Rz
IHdpdGggdGhlIGN1cnJlbnQgdXNhZ2Ugb2YgdGhpcyBmaWVsZC4NCj4gDQpPaywgSSBzZWUgdGhh
dCBwdHJhY2Vfc3RvcCgpIHNlZW1zIHRvIGJlIHVzaW5nIGl0IGluIG11Y2ggdGhlIHNhbWUgd2F5
IEkgd2FudCB0byB1c2UgaXQgLSBhcyBhIHRlbXBvcmFyeSBwbGFjZSB0byBzdG9yZSBzb21lIHZh
bHVlcy4gU2luY2UgaW4gZG9fZXhpdCgpLCBleGl0X2NvZGUgaXMgb3ZlcndyaXR0ZW4sIEkgZGlk
buKAmXQgdGhpbmsgYW55b25lIHdhcyB1c2luZyBpdC4NCkNvdWxkIEkgYWRkIGEgbmV3IGZpZWxk
IGluIHRoZSB0YXNrX3N0cnVjdCB0byBzdG9yZSBteSB2YWx1ZT8gKEkgZG9u4oCZdCB0aGluayB0
aGVyZSBpcyBhbnkgb3RoZXIgdW51c2VkL2ZpZWxkIEkgY2FuIHVzZSB0ZW1wb3JhcmlseSkNCg0K
QW5qYWxpDQoNCj4gU28sIE5BQ0ssIHNvcnJ5Lg0KPiANCj4gT2xlZy4NCj4gDQoNCg==

