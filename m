Return-Path: <linux-kselftest+bounces-17445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E19703E9
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E6B282AC9
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B40165F06;
	Sat,  7 Sep 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpYt80i6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ks4uzOi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7569EED8;
	Sat,  7 Sep 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737315; cv=fail; b=o7tCDZxWRRBDN0C2ndmx7loX8sKZ1c+e8rG2rDQBqsqYyKamar/lch+kfja555emGahwXV3dVUrVylUXHbup+gAqaMmqAnUGtNDuSMYl6ySaAGIAT0Qkf0CVK6Q/XCIg22iD5Is7PftdqvNSPd+Mt03ZcnK9AvG0+aQ9fDkoL+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737315; c=relaxed/simple;
	bh=YXAWfG/QVx3BAzGNXgYFKKAp0IJjniG3Qmxox9JGVXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWU5RMsigv6TXP8+jy76v6gQl9aVHNxZUQN3PCKD0q01w4RHIdQitgghSHGHt7UBI/u5ztPlA3hgbjDM97h/yKq/RjT+kAf/GfNBLhp+3uPlEyLsFrKgrqTLT8AwYjsrT7d072/Y2OjVCaBjWvGnOpYFt7r2XOZtKoRazZovRmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fpYt80i6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ks4uzOi+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4878fUgS026750;
	Sat, 7 Sep 2024 19:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Y4BYZ0JLY0lt+liJc8bZkDtx9h/nIxLgmmJ9FWzFfSA=; b=
	fpYt80i6Euy9gHB6++GcvCsBaiLi6YYBfI3kEEXWKzj2LgGYi1hOY6ZSDu4epnHH
	vpH6KQ3XBmQTdKmuYjvZhLpkXsHMDaoPLPjGint96/di69mAGDkUbHuNjPyPdEeG
	0PaFVig3fReOeeILaXcr95wCTht0Yk2seT0QlcvRwhn+UcuvqXubfiHUWD834J9L
	fYzrj+yORAba5MnDlClpl5LL+a8N8KQ4nNMws/s3mDTE+DpXMQ3zQxGFsbTtxplW
	XDS72SekUhqVQ1hFZlu95RAeA9t589g/VvwClrfyDuwxqYrrRVtHN0leE7L5WYQG
	xKuO9Q4fmZmO/cliKy6oug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbugdp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 19:27:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487HNnGO032478;
	Sat, 7 Sep 2024 19:27:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9c669u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 19:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiq43zOHa7SRmcL5NpXugL5LBt7LUKn8JRle07qfuUD4pM7FxVA80MeTn7qtScW7DNP1DFneqD3uGDzNGQjWKcmClzLYTCkKtJVEjh+CBEm19J4sMFsbPNAtVQu3LHMcEMVIwHyXSq0jhLGADC2INXtLb9/3t4G+sy/Qb51Qii4UaqhH7JMNv0Yj2DHRjlqsLtPn3xG/3VIba3OUD/C8mRa04cgRLPJnlYo3s7DLAdwBggyWdMUX8qQSkFp8PWvoBUCgtuurKiYRijDhwTGT4+ojgk3xAyJ+kHCCihI5OGeopFXgcvD+4ufFdQQYWJZmQ5AQGk4buO98pnPf0xhvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4BYZ0JLY0lt+liJc8bZkDtx9h/nIxLgmmJ9FWzFfSA=;
 b=IR9FHgq7LUdNsBnTiUNt7L3OpBZKF3s7U802kN36tZIWSw+pONjOhGCw7lVxrwY9k2JnLMOfryunpyXmS4RX89LfJTZgxEsGyhuw1KrEZ/9e0SI8ZBf3uOCn7mTX0ve/HlAQl01mYh7daqH+/o+PIMlCMaxHA/sfYhKkeNfw9WM3lo5WhlxteZod5kRo0UC4/aCLLviBBkcldhzwvojbBRWceSg5/siFPerLHtsbZyLhZZmiKw8YwtwezqzOZxSIe8oocrYMvkOZoCBjrODqiS7q4W1Vi7sh84hBgVGYLJ5OjA5imIChbwJtW8WxSn+6VdkU4UI3J8PfNtTT2DXfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4BYZ0JLY0lt+liJc8bZkDtx9h/nIxLgmmJ9FWzFfSA=;
 b=ks4uzOi+3H5HRhdXmn+o6l0HBuvYuLe6n8IkOKevCEN1dkebD8pi/aGfKVkzwBtsEBuTKQ6R+3yCTfbSMPmVoGzyRp9O2S1q/kZidhjqbSi7pM6X+t2UXvTGMxWVxhFIcJ/oDHZdKjYPj42rfEN86pJj1ROOV5PW+ctiU+R1UA8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7132.namprd10.prod.outlook.com (2603:10b6:8:ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Sat, 7 Sep
 2024 19:27:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Sat, 7 Sep 2024
 19:27:56 +0000
Date: Sat, 7 Sep 2024 20:27:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b6a9d8-b7a7-4e3f-a028-08dccf732ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZhNWVyV09DRDcyNjh3dEhrT2lpYmkzRjl5UWtMZ3MvWjltYmdVN3NFUktz?=
 =?utf-8?B?alVYRXN1TGQzNEJCOUZwTzg0RWV2SGJXREJQRWxRTlFrZ0d4RkxMRElROERW?=
 =?utf-8?B?Y1o0Sy82Nnkxa3o1T1QwVXJnN2krTXhOSHZxN1RtcWlJTjhBMzFISGhtQnRj?=
 =?utf-8?B?aURUeUZhVlBsaWhzMzNETmdWb0hmMlBxTzl6YTRrWTFiYmVOZGpxMXRLS0lG?=
 =?utf-8?B?c200U2FkUlliWFE0eDNMdXRqa0NPNWp5cjBmL1pzaWFLbEkzcGRHOWdEYUVK?=
 =?utf-8?B?UTRUbjhWT0JpQTh0YTI3YzI5YmZlM29GL3dCWTlma0VkZi95VmE3QlBYL0hB?=
 =?utf-8?B?TjdiZnhxc1F3ckxScmltdVZ3ZVdrNGlLMkIveDRId0xTbWIrbUliZTlyOVlS?=
 =?utf-8?B?ek5WT292QnJxNkhqQ2lyVkkxWjBrMzM5UDJzUEFjckJZbGRKd0VYaEMyeWla?=
 =?utf-8?B?VmU4NnQveTBQT0htdmdkRFB1TUZWaUY2UStLVnphdmpHMnZuQjBlZUkyVXQw?=
 =?utf-8?B?azR1NWRXVVNzYU8xSVhFWHJJRlJVVVg0eERNNTBPOGhnb3hJQ1FZcW1Zak1v?=
 =?utf-8?B?azQrci9BNE1tVzZFNEp1MVJ3QWlRRkQrQzJWZ3JhZDY0dmJobStKN1VNbFA1?=
 =?utf-8?B?YTdod1I5cWkzWUZUQm9yMTFYYW01NXpsbUgrRjI0RGNTdG1nMWtsTGJ3YjY5?=
 =?utf-8?B?VzVudXlTakIyRi9ESFpaU0VJQThkbGxMNk1iT1h1Y3YzaCt6SG1hc015ZjJ3?=
 =?utf-8?B?ZGo5WS84N21mMUVleVN2T1hSc1NTUng2YS9INW9nai80WVl1QUJxQ2pOVlJP?=
 =?utf-8?B?SlBKRzBBYWVBZVJQRmd0c3NxeVdobHl1YTFIa2Jmc3p2MXJFaTVHblNsbEM5?=
 =?utf-8?B?Z2tMUnB2aThKbVFKZDZYaEcxMDhaa2ZPTnphKzZtRkVLT25kQjljQ1orelB3?=
 =?utf-8?B?b05xL3F3TmFHTm1tRVl3QjhXcDY1RjhMZllCYytOYUhsM1laQVg0VU1CSnVU?=
 =?utf-8?B?eGIrNDJReTZLdlFrY2JTa0JBWXVSbzNGQUFicTBBS2tnTk9iWW1aLytuZzBl?=
 =?utf-8?B?citPaU5MaGd3dm1kTG05d1lFTFczakxiRXp0SjBVZEwvQ2VrcU95MS9yd0tv?=
 =?utf-8?B?R1grQ2llTisrdnlWQm1FRzRYeDBJc1E2Wmh5WXA5YTVwaDdGUGUyNm5oZzlO?=
 =?utf-8?B?TnBZK0VLSmJKcUo4MzJ0a2FBbmUyR2xGcVE5WVJ6R0xxcjZ2YytBYnoyeUZK?=
 =?utf-8?B?VkYza0d4c2lFa3kvMXF3bG9uZ3BRRW4yK0xFWUJaekozL2VYS3g5dzFqVFhB?=
 =?utf-8?B?Rkh0elhXcFlaT2Y3cmc0M2ZzbXJGQ290alE3eUtIa2dBdlJhNzVwWHBBRXlw?=
 =?utf-8?B?WXpERkVWaEhad2g4U2hVTEU2QlpEZ2pwcnV6KzhUWmlqWCtrSEk0R05GTGdE?=
 =?utf-8?B?Mm85RXoxek41Y3BXMmRTMi9nd21SVTUrV3dybTViWHpzckt4dmdBV1FOTjhl?=
 =?utf-8?B?cEZwSmhweUR6aUUrdW1oYXlLL1NQd1hEeU5zeXVESWZCck1TQkZYZnBiajVy?=
 =?utf-8?B?S21SV3JZdVlCVmVsSkRKOFVQbFh1OFpma3MxUmxwTGJHMnIxT2ZiYzl6WGZy?=
 =?utf-8?B?VEc2V2RwZTVIVWVCVjlRNG9xMEYvTkNKcVgxMHZqV3BERXBWRHlNQVIvWkZp?=
 =?utf-8?B?SWJUalFNMXp5MG45Mzc5NmtJUjZ5VmRaNjJvT3huSWFXeVJUK3ppeHU2cG1p?=
 =?utf-8?B?aFJJVDFBREpQa0ZXZUtEQTRXVlg2V1haekJBTE5zNlVjVHlCcnhmVE05dHhP?=
 =?utf-8?B?Zzl2cjR6UjB4UnhxY0N2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhETVhvcWJtTWdxaDgzYXJKejg1V2R1bk9GSkUySkh1M2NWT3htNnNuZkRU?=
 =?utf-8?B?ZnpJenJYT0NBQUxjMDlLK0xWbzl4ZVVLb1pXN3RIV2RFamNPQmdRZlZhZUNn?=
 =?utf-8?B?aGEyUktSSmRyZGc2cDJRckF2MmNMTm1EbTcxaEJnSWtJclpYOWx2Y1pxY3hR?=
 =?utf-8?B?ZUxMTk5VZkJhU0R0dGlnSWQzcTBZM2psaXQ5UE01RzlhdEExVzA5SEFGVjZ2?=
 =?utf-8?B?eGw1OXBvTXFXRjNSWHVIa0lUbHdqcDM2UEZESTcyblMzTlhYdzhPQnpadlF4?=
 =?utf-8?B?OEJFZ09POTJ4NURzeXEyMm9QVmozNVpxZCtzTjNoVklRbk54aXJuV0FHOFdt?=
 =?utf-8?B?c1NxamZpQlg2aWZsWk01SnBDNHk3SUZnbWRwS21iTFV2emZvQlF6ZmRTQU1r?=
 =?utf-8?B?MWxQbVlETG1VMlJsaXJkdVJxbVI4TkpGeHE1ZnRKMUhVditCM3FwZ2pGd2Jj?=
 =?utf-8?B?bmRpQWpvZHp6TVZ2VWVrcDF4TkxYQzgrNmVtQ0MwUmpacjdndVFjaE8vQ21z?=
 =?utf-8?B?Tk4yeXhjYUpNb013ckl1RHhnZjlPa3c2ZHFGTmplSTRxcHBwN21rSEdvVnky?=
 =?utf-8?B?V2wya0xaVTRvcFoxTkpEcU1qeWJJWWRVOWlKYVY4WFBMakM5REczVXBoVC9a?=
 =?utf-8?B?eG9IOXpEU05OTVd3dDJsMFI2c3YxY3M2UE1VNWRpQTJPQlgrMGk5TE1BaXNK?=
 =?utf-8?B?NWpKZkQxL01kQXA2QTFmYmZsRHFFaTJjSnd3MUFZNm9taGExUEJjUC8xYXUw?=
 =?utf-8?B?ckc3cXVQU21xMFYyQmpNUUlRelR3TzhGZFVNZkxOWG9wTWg0UmtqOUJ3UUFm?=
 =?utf-8?B?Y2NTS2FEMEVmTlpQa283V0J0QTVDTlIwaHFsR0VKWkZNU2FqaTN6Y1AzdHJl?=
 =?utf-8?B?bEFkQzBsU3VtbHdNazcvbGRPa2x1M1BYRDBwREhWRTRuVTIzdjE3MG5yVlF2?=
 =?utf-8?B?Q2ZTRGU2YitTemxlaG5XdDVKOVExUkpFRjV5WmUvZEVoQVdWZVVmU0FOTWZj?=
 =?utf-8?B?Z2RUWHl1ZGRDNVAwL20vVUpnUUNnMElzdWx4SjVGWVZmYlo4aU81MEp4R1Vn?=
 =?utf-8?B?c0dDRHBCb05RT21leXBKUVZ5a1pYY3hITGpadFBKSXBqdnoweXFDSHR1SVpJ?=
 =?utf-8?B?K3Z3ZzcvQnVBUjhxa1BlbUhCMGZRdlZEZmh3b09Gd1RodUFUMm9rNFRVTDdM?=
 =?utf-8?B?SU55ajNESkYraVRhRXFqb0UydXlMa21JQVYzNDY2b2N1emoraDhrd2hrZUhl?=
 =?utf-8?B?My95UXlGYzFDK3E5NVkvVGVZSlZlMnZxbk5IMi83NDk4YjdMbEJzQ0ZYdkRI?=
 =?utf-8?B?RDZ6ZmxXcmVnSng2U0xaWlI3VHNURWUvb3MrSGZRZ0pUWVhOdGpkNnVFbU5G?=
 =?utf-8?B?d0pQZzUwdlhzWUZTc0ZCTDE5VisreHNTMGhTRnRWVGtMaVRMYTR2dnFNd0pq?=
 =?utf-8?B?RnlIc0lsNHJaaDRxUDJCS1lGNFR4bCt5dWZDRTJTSk9VakZPWGZzT1JLY2k3?=
 =?utf-8?B?VnBnN2l2d1Q2SlphNHM1aElLMnhtOFpuNzJ5WCs3L2RrNkdKU09tcXpVemFT?=
 =?utf-8?B?SU1ycmNialRSckcrZ3R5c3VVb1N3eUhic0cwczlsdWQxNzE2VlpNa3ZYRFo2?=
 =?utf-8?B?MzhJY3pxZXM0cmI2Mzk4YXdEUy9OWjhuclllMjRURFVsOHUySnVmNys2Q0c5?=
 =?utf-8?B?SzJUYzZ0QlY4K2ZNd1NaR21Hbk9ZUkhMbDdDL1pGM211aUpNUkJScno5cTRk?=
 =?utf-8?B?QzRJTXZFbmtFSlhreFphZFo3dVdQcjRRUTdhU2RhTnpRTlUzQ24zMk5OM280?=
 =?utf-8?B?U3h1Z1pZUnU0d0RQcjlPckxwRlMvRWhncUM3TU02VzNlSXA5dUkvVkhvUTZG?=
 =?utf-8?B?VU5wVm1yVXNvSHhPSkcvQTdaeW4yQ2xjM3IwOFpMUHdvbXAyM1J5aTRBWDRP?=
 =?utf-8?B?QlR4UkZLWTRFMm9uRnpTQ1NrRGlONWM5aUI4a2FUWStaaUhJeVRNMm8rMVFF?=
 =?utf-8?B?aDJhYm02L0JzZmVFMHhQSW1FSk5PaG1UNFNPWjhhdzVMODhoVG95emQzajFI?=
 =?utf-8?B?ZzZqVUpVcnd3Mmg2UDJTQStPaVB4ODhhd2M4bFdLK1MzNWtCTkdCdXRRY1ZX?=
 =?utf-8?B?Z0tIbkxNOUFEMnZFTFkwMXFIVjB2bGpGekswWFJvd0hqa0h3NHBnVzhYcUFk?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kOlN8a1V3LWOHgzTmwGzh9BSAQ9RUwlCM0RpZPaAz5SSXbqTlpm4R/0pdllkdNzio5XwFz9nkgfFaequCk1o49cG6OIvar524YcGEi+mWuooSTX6kDIwxQuT14D+xjXIAILrQqZlgSRvJOmcuf1Jkzbra2Gj2ZuJIFhtKg0EJbNqtj+wzhaIef0O397mXjdgvXrTKa50SRR+KPPE1Hz24ZQOMMhWr7QSl5ko7OTOEbHxWLVTb3v1WuPeA2OyOr+R3TJ1QVNPG09n92gt/jHdT/MI9mbq8Bovp8MSFeAF4hl/kWPO+VRy70NfDacS7Xo7lGtrqNvMEiipFNMaxC1ny6jtVxzYIFZxVoD2q6VuqWjHb+DZnXnnMMeZkrN7pNJgXyOqygGByZy/4/vPezlM/aMePjmL4Jg5nlSYRVYqdRoyDhR9awmV8huto+82jrTlS9J6ruqddczqqvqZO/oBivPMOUitdFKHaT7v53G/f5tN7VV2ym1I8N6jXSyw99IUn0rSKh9IA47wtZMkcPBN2OHgBEJsvJjUefQj5ov+zPzkgH9VwE1YCYjqeyxsf9EV+TT+CxUpP1BzIOaHfxofqDswTrB+QvGJXUjq83b/DR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b6a9d8-b7a7-4e3f-a028-08dccf732ca2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 19:27:55.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAxLHDb3t+a7BC8OEViU+r/hCJ1+imMdbnBCDrnyhB2QQM7BdfRC2t7I1L9ajeu7gnKHoS7VanV3TdG5qx1D2HNOOMVXAR9ui+4kv1LzfbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070160
X-Proofpoint-GUID: settf5K-l1PYByKWW7OGkeHtodKg03vx
X-Proofpoint-ORIG-GUID: settf5K-l1PYByKWW7OGkeHtodKg03vx

On Fri, Aug 30, 2024 at 04:57:26PM GMT, Jeff Xu wrote:
> On Fri, Aug 30, 2024 at 12:23 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 07:43:12PM GMT, Lorenzo Stoakes wrote:
> > > On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Add sealing test to cover mmap for
> > > > Expand/shrink across sealed vmas (MAP_FIXED)
> > > > Reuse the same address in !MAP_FIXED case.

Hi Jeff, I really want to find a constructive way forward, but you've
basically ignored more or less everything I've said here.

I could respond again to each of your points here, but - from my point of
view - if your response to 'what is this even testing?' is to just repeat
in effect the name of the test - we will be stuck in a loop, which will be
exited with a NACK. I don't want this.

The majority of these tests, from a VMA/mmap point of view, appear to me to
be essentially testing 'does basic mmap functionality work correctly',
which isn't testing mseal.

Look - I appreciate your commitment to testing (see my work on mm/vma.c - I
care passionately about testing) - but we must make sure we are actually
testing what we mean to.

So I suggest as a constructive way forward - firstly, submit a regression
test for the change Liam wrapped into his series regarding the -EPERM
thing.

This should go in uncontroversially, I will take the time to review it and
I don't see why that shouldn't be relatively straight forward. I will drop
the concerns about things like test macros etc. for that.

Then after that, I suggest we have a discussion about - at a higher level -
what it is you want to test. And then between me, you, Liam and Pedro -
ahead of time, list out the tests that we want, with all of us reaching
consensus.

I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this point
too - I may be missing something, but I cannot for the life me understand
why we have to assert negations only, and other self tests do not do this.

I have replied to a few sample points below.

All of us simply want to help make sure mseal works as well as it can, this
is the only motivation at play here.

Hope you have a great weekend!

Cheers, Lorenzo

> > >
> > > This commit message is woefully small. I told you on v1 to improve the
> > > commit messages. Linus has told you to do this before.
> > >
> > > Please actually respond to feedback. Thanks.
> > >
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  tools/testing/selftests/mm/mseal_test.c | 126 +++++++++++++++++++++++-
> > > >  1 file changed, 125 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> > > > index e855c8ccefc3..3516389034a7 100644
> > > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > > @@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ranges(bool seal)
> > > >     REPORT_TEST_PASS();
> > > >  }
> > > >
> > > > +static void test_seal_mmap_expand_seal_middle(bool seal)
> > >
> > > This test doesn't expand, doesn't do anything in the middle. It does mmap()
> > > though and relates to mseal, so that's something... this is compeltely
> > > misnamed and needs to be rethought.
> > >
> >
> > OK correction - it _seals_ in the middle. The remained of the criticism remains,
> > and this is rather confusing... and I continue to wonder what the purpose of
> > this is?
> >
> It expands the size (start from ptr).
>
> > > > +{
> > > > +   void *ptr;
> > > > +   unsigned long page_size = getpagesize();
> > > > +   unsigned long size = 12 * page_size;
> > > > +   int ret;
> > > > +   void *ret2;
> > > > +   int prot;
> > > > +
> > > > +   setup_single_address(size, &ptr);
> > >
> > > Please replace every single instance of this with an mmap(). There's
> > > literally no reason to abstract it. And munmap() what you map.
> > >
> No, we need to abstract it.  In addition to the mmap, it also
> allocates an additional two blocks before and after the allocated
> memory, to avoid auto-merging, so we can use get_vma_size.

It doesn't?

static void setup_single_address(int size, void **ptrOut)
{
	void *ptr;

	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	*ptrOut = ptr;
}

>
> > > > +   FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > >
> > > Pretty sure Pedro pointed out you should be checking against MAP_FAILED
> > > here. I really don't understand why the rest of your test is full of
> > > mmap()'s but for some reason you choose to abstract this one call? What?
> > >
> > > > +   /* ummap last 4 pages. */
> > > > +   ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
> > >
> > > sys_munmap()? What's wrong with munmap()?
> > >
> > > > +   FAIL_TEST_IF_FALSE(!ret);
> > >
> > > Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
> > >
> > > Would be nice to have something human-readable like ASSERT_EQ() or
> > > ASSERT_TRUE() or ASSERT_FALSE().
> > >
> ASSERT_EQ and ASSERT_TURE are not recommended by the self-test. The
> FAIL_TEST_IF_FAIL wrap will take care of some of the admin tasks
> related to self-test infra, such as count how many tests are failing.

Can you please point me to where it says you should implement your own
macro that only tests the negation of an expression?

I have found other self tests that do.

>
> > > > +
> > > > +   size = get_vma_size(ptr, &prot);
> > > > +   FAIL_TEST_IF_FALSE(size == 8 * page_size);
> > > > +   FAIL_TEST_IF_FALSE(prot == 0x4);
> > > > +
> > > > +   if (seal) {
> > > > +           ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(!ret);
> > > > +   }
> > > > +
> > > > +   /* use mmap to expand and overwrite (MAP_FIXED)  */
> > >
> > > You don't really need to say MAP_FIXED, it's below.
> > >
> Adding a comment here to help reviewers.
>
> > > > +   ret2 = mmap(ptr, 12 * page_size, PROT_READ,
> > > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > >
> > > Why read-only?
> > >
> > > You're not expanding you're overwriting. You're not doing anything in the
> > > middle.
> > >
> The MAP_FIXED is overwriting.  It also expands the address range
> (start from ptr) from 8 to 12 pages.
>
> > > I'm again confused about what you think you're testing here. I don't think
> > > we need an arbitrary MAP_FIXED mmap() at a size larger than the overwritten
> > > VMA?
> > >
> > > You just need a single instance of a MAP_FIXED mmap() over a sealed mmap()
> > > if that's what you want.
> > >
> > > > +   if (seal) {
> > > > +           FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> > > > +           FAIL_TEST_IF_FALSE(errno == EPERM);
> > > > +
> > > > +           size = get_vma_size(ptr, &prot);
> > > > +           FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(prot == 0x4);
> > > > +
> > > > +           size = get_vma_size(ptr + 4 * page_size, &prot);
> > > > +           FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(prot == 0x4);
> > > > +   } else
> > > > +           FAIL_TEST_IF_FALSE(ret2 == ptr);
> > >
> > > Don't do dangling else's after a big block.
> > >
> patch passed the checkpatch.pl for style check.
>
> > > > +
> > > > +   REPORT_TEST_PASS();
> > > > +}
> > > > +
> > > > +static void test_seal_mmap_shrink_seal_middle(bool seal)
> > >
> > > What's going on in the 'middle'? This test doesn't shrink, it overwrites
> > > the beginning of a sealed VMA?
> >
> > Correction - the middle is sealed. Other points remain.
> >
> The mmap attempts to shrink the address range from 12 pages to 8 pages.
>
> > > > +{
> > > > +   void *ptr;
> > > > +   unsigned long page_size = getpagesize();
> > > > +   unsigned long size = 12 * page_size;
> > > > +   int ret;
> > > > +   void *ret2;
> > > > +   int prot;
> > > > +
> > > > +   setup_single_address(size, &ptr);
> > > > +   FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > > > +
> > > > +   if (seal) {
> > > > +           ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(!ret);
> > > > +   }
> > > > +
> > > > +   /* use mmap to shrink and overwrite (MAP_FIXED)  */
> > >
> > > What exactly are you shrinking? You're overwriting the start of the vma?
> > >
> > > What is this testing that is different from the previous test? This seems
> > > useless honestly.
> > >
> Again, as above, one test is expanding, the other test is shrinking.
> Please take a look at mmap parameters and steps before mmap call.
>
>
> > > > +   ret2 = mmap(ptr, 7 * page_size, PROT_READ,
> > > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > > > +   if (seal) {
> > > > +           FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> > > > +           FAIL_TEST_IF_FALSE(errno == EPERM);
> > > > +
> > > > +           size = get_vma_size(ptr, &prot);
> > > > +           FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(prot == 0x4);
> > >
> > > What the hell is this comparison to magic numbers? This is
> > > ridiculous. What's wrong with PROT_xxx??
> > >
> The PROT_xxx can't be used here.
> get_vma_size doesn't return PROT_ type, i.e. the bit sequence is different.
>
> > > > +
> > > > +           size = get_vma_size(ptr + 4 * page_size, &prot);
> > > > +           FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(prot == 0x4);
> > > > +
> > > > +           size = get_vma_size(ptr + 4 * page_size, &prot);
> > > > +           FAIL_TEST_IF_FALSE(size == 4 * page_size);
> > > > +           FAIL_TEST_IF_FALSE(prot == 0x4);
> > >
> > > Err dude, you're doing this twice?
> > >
> The second get_vma_size should be (ptr + 8 * page_size)
> I will update that.
>
> > > So what are we testing here exactly? That we got a VMA split? This is
> > > err... why are we asserting this?
> >
> > I guess, that we can't overwrite a sealed bit of a VMA at the end. But again
> > this feels entirely redundant. For this kind of thing to fail would mean the
> > whole VMA machinery is broken.
> >
> The test is testing mmap(MAP_FIXED), since it can be used to overwrite
> the sealed memory range (without sealing), then there is a variant of
> expand/shrink.
>
>
> > >
> > > > +   } else
> > > > +           FAIL_TEST_IF_FALSE(ret2 == ptr);
> > > > +
> > > > +   REPORT_TEST_PASS();
> > > > +}
> > > > +
> > > > +static void test_seal_mmap_reuse_addr(bool seal)
> > >
> > > This is wrong, you're not reusing anything. This test is useless.
> > >
> The ptr is reused as a hint.
>
> > > > +{
> > > > +   void *ptr;
> > > > +   unsigned long page_size = getpagesize();
> > > > +   unsigned long size = page_size;
> > > > +   int ret;
> > > > +   void *ret2;
> > > > +   int prot;
> > > > +
> > > > +   setup_single_address(size, &ptr);
> > > > +   FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > > > +
> > > > +   if (seal) {
> > > > +           ret = sys_mseal(ptr, size);
> > > > +           FAIL_TEST_IF_FALSE(!ret);
> > >
> > > We could avoid this horrid ret, ret2 naming if you just did:
> > >
> > >       FAIL_TEST_IF_FALSE(sys_mseal(ptr, size));
> > >
> > > > +   }
> > > > +
> > > > +   /* use mmap to change protection. */
> > > > +   ret2 = mmap(ptr, size, PROT_NONE,
> > > > +                   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >
> > > How are you using mmap to change the protection when you're providing a
> > > hint to the address to use? You're not changing any protection at all!
> > >
> It is necessary to add the this tests to make sure mseal is behave as
> it should be, which is !MAP_FIXED case, new address will be allocated,
> instead of fail of mmap()
>
>
> > > You're allocating an entirely new VMA hinting that you want it near
> > > ptr. Please read the man page for mmap():
> > >
> > >        If addr is NULL, then the kernel chooses the (page-aligned) address
> > >        at which to create the mapping; this is the most portable method of
> > >        creating a new mapping.  If addr is not NULL, then the kernel takes
> > >        it as a hint about where to place the mapping; on Linux, the kernel
> > >        will pick a nearby page boundary (but always above or equal to the
> > >        value specified by /proc/sys/vm/mmap_min_addr) and attempt to create
> > >        the mapping there.  If another mapping already exists there, the
> > >        kernel picks a new address that may or may not depend on the hint.
> > >        The address of the new mapping is returned as the result of the
> > >        call.
> > >
> > > > +
> > > > +   /* MAP_FIXED is not used, expect new addr */
> > > > +   FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
> > >
> > > This is beyond horrible. You really have to add more asserts.
> > >
> Again assert is not recommended by self_test
>
> > > Also you're expecting a new address here, so again, what on earth are you
> > > asserting? That we can mmap()?
> > >
> > > > +   FAIL_TEST_IF_FALSE(ret2 != ptr);
> > > > +
> > > > +   size = get_vma_size(ptr, &prot);
> > > > +   FAIL_TEST_IF_FALSE(size == page_size);
> > > > +   FAIL_TEST_IF_FALSE(prot == 0x4);
> > > > +
> > > > +   REPORT_TEST_PASS();
> > > > +}
> > > > +
> > > >  int main(int argc, char **argv)
> > > >  {
> > > >     bool test_seal = seal_support();
> > > > @@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
> > > >     if (!get_vma_size_supported())
> > > >             ksft_exit_skip("get_vma_size not supported\n");
> > > >
> > > > -   ksft_set_plan(91);
> > > > +   ksft_set_plan(97);
> > >
> > > I'm guessing this is the number of tests, but I mean this is horrible. Is
> > > there not a better way of doing this?
> > >
> Again, this is recommended by self-test.
>
>
>
> > > >
> > > >     test_seal_addseal();
> > > >     test_seal_unmapped_start();
> > > > @@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
> > > >     test_munmap_free_multiple_ranges(false);
> > > >     test_munmap_free_multiple_ranges(true);
> > > >
> > > > +   test_seal_mmap_expand_seal_middle(false);
> > > > +   test_seal_mmap_expand_seal_middle(true);
> > > > +   test_seal_mmap_shrink_seal_middle(false);
> > > > +   test_seal_mmap_shrink_seal_middle(true);
> > > > +   test_seal_mmap_reuse_addr(false);
> > > > +   test_seal_mmap_reuse_addr(true);
> > > > +
> > > >     ksft_finished();
> > > >  }
> > > > --
> > > > 2.46.0.469.g59c65b2a67-goog
> > > >

