Return-Path: <linux-kselftest+bounces-3943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECAB845DE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794B21F2A823
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C12C682;
	Thu,  1 Feb 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WnRuO1q5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6E63AF;
	Thu,  1 Feb 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806676; cv=fail; b=HxZZ6iuKrr9UycKa5EbfhnE1pJ5yF8dt+FpYyMHU1XnKOCxwQykQvzyND0jyJrKtziP3S6xbOekAdhmtcfvwxj6aNqmWP/RMlyTOI6ZcZLmTVvEVTfUaxMsPvBe63OiLLBSXR1vf7t1iZnhtV8PV/yPQy04m8iDuucX1k2+566M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806676; c=relaxed/simple;
	bh=bcGba+BRPETqADotig5lo28qo9Lnf5ap2W7SAbPlrrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=V+4mrSiZCOoR5QetDCCmvYoR6TEmtnhnd53lzMr9gZJH2rl4e4ydBtH4aj0TgSJD6xo2TDyjSbmqVmDVGQaVSMPAJw30cJT8418Aj3XGYCyAHLtrFOw9iVN7i2neNqQr/g+TVkrrAbUSXdTpOdv+/3DxO70HiS9moHCXu7poKi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WnRuO1q5; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411Fr842016641;
	Thu, 1 Feb 2024 16:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=bcGba+BRPETqADotig5lo28qo9Lnf5ap2W7SAbPlrrw=;
 b=WnRuO1q5z0pE3BELJLKdxSLFaGNzEsgaU5HSCjzT/6/9qmYCqrA+vuEjkdrQ1CznEewj
 d/bR+lm4mxSYOaQgKtV1FalS9CjqD9FVe+PbB87fMn24t72kb0scDYSQfVcA/Bw9IijO
 nORxAQt5npzoMYw1eGEX0A9HyhLBrYk6rC1mEv4mBTYdbgW/aNgVrrNjGCbSLlDcOrW2
 fCx6qVJ7si/sYpdA0G1iBC+8pRPJ6dJ7INnhTAfHgugvZ/mzxlhgkPEyIxhnH0TELbMi
 OPdDGpvrsMR+pAPcXqyh0X2R60rGw/7kCmdPGBJYuj3RoKJcn+CGuNUOfufCKSbVjk08 AQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vvqqp5bbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 16:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIY6bsP4GNvxdQBKTMnUqlQso0k9Nl6MG+yuqXL1ngGzLAtOemiNfxpsWACPfEfthu6cEgiUHDPdDF/O/zTYzW/bVVnZp4dpUnF952uYtJ9Z+ofztXaZ9A7Uje/FVg1lGZf2mSk/+jGy9tFhYW7lWIlw/hUNnTMzhdoQVNA6aLn6VTE5ZODwy0ETgdUTYf1QKQEmGU55QZavtchZvoX01kMW+k2iBXQhTgs7AGaRFLyhnqa/xCs+8GI99FmZW/eKwmjchJ4PWZY4xNPQ104f+HKmYxi0ctO/YvhpmZkUGn55z6NAkzgoZKoVN3K69IdkJiQnZ6L5CQn3maCKXPciDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcGba+BRPETqADotig5lo28qo9Lnf5ap2W7SAbPlrrw=;
 b=RB3/x/ds/yMs/8RYzXzyhvaeumiEX7wNkVg+MAUtnXQz0GmPMbbQ0Gg6PUHekS021ht8EYuWkNFddI1ALqz3ocPAWeLIm/XAFpQk3VLRv+b9wfypMTjCWUinYx+kTHPEQnYj2u1W/VEQn0z2vmaYwelBdiJJfITs+EuesWroZJjbO0KkP4Yb7pYDbI3msq54fbWgbK48ZLg3JNBSBVhF7BDMc4/6QS20Q8U5ehCpD9CJyGRnnE98kTxDpjUgPHojK+vmuI0RMZLw1BokBtNxjyTMMUfaM1mQ/1UcJYYG+YXst9hnQJCI8poSUYrK2S9U7LboDFYsx5zxG4GOmlHfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by BY3PR13MB4818.namprd13.prod.outlook.com (2603:10b6:a03:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 16:56:47 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b%7]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 16:56:45 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@chromium.org>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jonathan Corbet
	<corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com"
	<jannh@google.com>,
        "sroettger@google.com" <sroettger@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "usama.anjum@collabora.com"
	<usama.anjum@collabora.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jeffxu@google.com" <jeffxu@google.com>,
        "jorgelo@chromium.org"
	<jorgelo@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v8 0/4] Introduce mseal
Thread-Topic: [PATCH v8 0/4] Introduce mseal
Thread-Index: AQHaVG4Tc8ZzTZjVxketnu4gNV+kU7D0UBGAgABioYCAAAVugIAA/bWA
Date: Thu, 1 Feb 2024 16:56:45 +0000
Message-ID: 
 <SA3PR13MB63726DD1D2B639F47E00A4C4FD432@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <92663.1706751997@cvs.openbsd.org>
In-Reply-To: <92663.1706751997@cvs.openbsd.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|BY3PR13MB4818:EE_
x-ms-office365-filtering-correlation-id: 29aaaa99-36de-4a4b-39cd-08dc2346c5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PODs3NQ5tn3prwDywqaoh0+KRK+lb9twOK1fxHLgUiwhMUpVRCIMaKBQVP981xdepsnpnbndp5dDdErQmT9sultjvwSbDGEH/Zh1z3H+qg3u5KCR4B/oFIO71lQ9KDilQTrdC10UPNp+eCS3ORXq3ga12Gu8IoxDc9Bc0eY2r66Mm9/RbW/S4Jb2rez4b7vwfLk9C2ArMLS0R9TMSUquOw13+/JctpTLgCrRAeabGRXrQ80eCkCAl3o4WXURMMLBnckSLy0+j5/Yt5ssDUBUOvMgac0tY5bLyX+jNYzwiRoi23P8gCFSOGte62nFDZn5j0DD091/UNYTpAgwNNNSb3pKAgKuK6gOaC/n3y0KcsRzg/UFxL5HMjlik1bxEXY0GuHgoOKkSA2CEIlJw0ci4fUT7oDEnLc9lBx0w5LnZ/owBj0RIGUmHbdl34sotKP582kEy+UTDCxPAZymSE6HugGXoxf2RtF/ppbUxeWceLwaQ2nDUK6vcQ4wt5J1frb9pYjfTqmlJ0G4XdE5pZAP5N8jZr3tSXFeiXYIbLQgPYthIwlulrmwF0Qgy0JyjJ/My5etLVt1kYW7sXB7A6FTnpOrDh+c0ePafhNqVLfGnipywSPbR/X6Q9peVfSwcgbe
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(83380400001)(33656002)(86362001)(41300700001)(82960400001)(38070700009)(122000001)(26005)(38100700002)(9686003)(7696005)(6506007)(2906002)(4744005)(478600001)(76116006)(66946007)(110136005)(316002)(66556008)(66476007)(71200400001)(66446008)(64756008)(54906003)(4326008)(8936002)(8676002)(5660300002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkYyTWVVamVDRVNhcC9SU1c1SkRydUU2SU15blRSZm1jNlpVVk5FTGZHS0pS?=
 =?utf-8?B?dVY2L1hWWkw4L0QvSkY1QVpVNjVEYXZoT0FhZTdudU9jampZTW9ybUF1RnJP?=
 =?utf-8?B?dFNkK2RxSG9NMmZBV0paYTZURjM2N2ZFM3FaaGRSV1J5UW5uME00bnVENjNw?=
 =?utf-8?B?eXVXUXl2bzYvTS9mTWkyZnhyc0FUa1orYm5sY2t2cHB2QzFMdlp6SzlqWmV6?=
 =?utf-8?B?blk5eFMrbUhEN2JWdFA5ZFdMZE4xZUJjNEhiQUJvVU1vVzh4dEJZdjU0Rm4z?=
 =?utf-8?B?R2pJMGwrWnNER1J3MFFBUTNqcndJTmdBT3g2a0RyVzdYWmVqeUJaTGtOOWJG?=
 =?utf-8?B?WkVHT1lPMk9sL2RBcFJ4UFhSOUo5V1NKVnJYbDNlNlZ0TnZyUlNYcGYrT1ZC?=
 =?utf-8?B?d0VHQlgyTGJ2WDFZcmtLVUNtbmJ6S3ZEVVBTcU85T3VxZU1HUk9KNURrSlU4?=
 =?utf-8?B?MDZFN1JmYWxlR1A3TFVCQzEvMVJjVDhzbEJDK0NsMUtldmNpRWlLYmFkS0Nu?=
 =?utf-8?B?K2hHRzhwQ3haakhYeCtYZzFjSG9tN0REQ28zS1RXdEw3T09FeEVOanpscUF5?=
 =?utf-8?B?ZDYvbGxON0QyNll4Zi8ra3BFT3NYZ2t2dE8zdzhBYzBPT1lOY2RsTlBsZlFa?=
 =?utf-8?B?WEtXVEtHNWswcyt0TS9aWkZoeWg3K3B4ZUVuT0ltbUVkdFJhZkNubDdmNmg0?=
 =?utf-8?B?ZUhnMUNpdHdVNVM0ams5bzNZU2ZibGlTTHJrWWZlb2NSYWJkL0VFN28wMWVu?=
 =?utf-8?B?TTg5ZlRwYnloTXc2c3ZQT3N3MDVFYWdoeXJ1UFVwNksyaEtCczcyTmlDNHRw?=
 =?utf-8?B?c0F4aEFPdDJqc2lpYzV1ZzRUTzNTWmcyR0pmcWJ6OFh6enFtUndLK2cvZlNu?=
 =?utf-8?B?ejZlM2d4TzYrSFNJMWk1bE0zQ3M0TVNueUJoRkgwM29uZnEwbHpFano4dWtP?=
 =?utf-8?B?TkllSnpUemx4L0VENWVKVE1iUkdtdjRKK2VnTFNscnV5Uk1JT0lFNnNhdEVM?=
 =?utf-8?B?YjJ2SkJiUmtBQlZ6cGlrd2xIU1BGeS8vQy85R3U3Zk9ud2FObmFJZ25VWWsr?=
 =?utf-8?B?VFlCTEdLN3FnRnlvUUxrYUR5RFNaamRqRzM3MVZQSjRWMHJoQ0ZKcGxXNTFp?=
 =?utf-8?B?ajMwa05XYkl0d040aEt0RHY5M1Y5MUYwZS9mM25jZXBLUTBnNUZiTzJsTGY4?=
 =?utf-8?B?WmxnU25UVEZ1akoxSEEzUExKcHhiNW8yODUwb1VzS0oycWtYdGtBL1Vodk1x?=
 =?utf-8?B?eHdUZS9iZml2djVGKzhEVkh6Snpyd3RmRTVtN3VuNUpoZWpCR2lvNU51R042?=
 =?utf-8?B?dDdRRjdKdnBkcUJWYVBENXlCLzlBYXN4TFJlTXVET3ZTK21BY0FLTGFrZHdt?=
 =?utf-8?B?TXNKOHcrdFkrOWhZWWZadm5BdVN3R1lhRDl4YURsT2s5SWpZMnVCeExlSERV?=
 =?utf-8?B?YVVidUlJSFFpY2dMbmFUWllWd0JReitSeU9DNEtzY2tTYU42S1JsSWN1ZXB0?=
 =?utf-8?B?STNyb0NjYjVYdVJDTGNUTm92ZVNKc3B2MzBOM0NqUWRrZmVNb3NiSnlpc1Ba?=
 =?utf-8?B?dFVaeGk4VEIyYiswbnBia2VMWFZPcHFmQUdLVGd1SlZwcHRTaTc4L3liQlls?=
 =?utf-8?B?WmN2aTFoT1VpcDIyb1lRRjJhVXVhNk9CNkxKeWZvK1Z2WTFqczhsNW5xNjlE?=
 =?utf-8?B?dzNQclRDV253QnRPSTg1ZjJJUVdQVzF0ZDNFQnl0WmZ4elJKMisyLzhRb2Vw?=
 =?utf-8?B?M2IwVVdHTU9qcEt4Nm02elZTU2wycFdub3Z2NFJYaFM3bmVsc0MyNC9rVkpz?=
 =?utf-8?B?RGlXNHdGOFliRmVpdUFYVVpNQU5ld1B3M0FiWTJreXU0bmoxREp5aEV0ZG9I?=
 =?utf-8?B?MEtyZFhveHB6QlpjRCtaSmNlaGl3VGpiSWVOYUdhL25iRU93cGc3QVNSWVJw?=
 =?utf-8?B?RGFLT0lTQUZ3U2lBQ2hoRXc1ekFFYXliaFYxWUVSdkNjMmVQUW4yUEU0aFhM?=
 =?utf-8?B?WFlkM2YrOWxReVc1QkU1cjZ1QXNEZlZ0M1M1Qkl3bXBJa016Ykx6UXo4OFF2?=
 =?utf-8?B?Qk5xQnNEYm84dE9BR1NLd2FCZlJNR1dvcEhjTmZJRnRGaXF6ZnFlYmZtM2VQ?=
 =?utf-8?Q?Ry3w=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wns5xvjSRxI++lf6U/h0FiYgmTvHYb7YS/w6i7zDl0aQqkDdWSg/8ifYSd97A6uG1TLR5SofOdJOAwxxG65VuPkMATUTKQGx4JvvCY9Uz3Q/2/YqvlbiHGldVNs2pMG5aZoFmF9SJFJWZBOafOrTR7Nc3sqxdhrAf4CO2ogG7N8b0tbfFAiQGgRM5u4A7B4ir9PmDrVrcFeOjqIJpuDjZOhdZ2gFLQ9OxBri04cOtGhOtT3EXm/DqPqY2VmyrF3m14TAYSqKdhZOtMPjaycOMoaOevUu4OHZtrj0AGRkxvmeA/hkogdICiEkZSsHwgiJDjG/pU+ymt0/14r/lj15A8mzd01LXwHSjotueyTtRwlsCiZC7/wDHVRKPiQUunTeTkyXi5HaF/xCcHe7KeZy7O193CGgLXjBwVWezFS2LuZee5NBrDPnmr3pwALXtcbxCM+r2yW79odIFbHj1tSZe52tK/Pde3/pOd3MXFBM5ZxBxOjOCzI2XOVGqFEu7FysqjUbo4rTgOvtkZMMSa5RZieo12zbYrr+9v0cs0ihrC5iJrLFSrnGXJ/Wkr8qV/TR/CKZ0kAshP+RoqJdhdfhKwID225dzPKrV4mAn/KBZjGrsq7VikNaxm4Fzk3F12Pa
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aaaa99-36de-4a4b-39cd-08dc2346c5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 16:56:45.0914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWQpX1jQF8AYTtJQZjPGpxJi6XNckskXjGzfqFPH/Q7jUjDfQI7HtVBsdlmoKN+jrz0VXNHPNEZ6TTPAb0imdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4818
X-Proofpoint-GUID: wgoGPF3tGUOh4Mxh-E2Jmh7nd0HW9FHg
X-Proofpoint-ORIG-GUID: wgoGPF3tGUOh4Mxh-E2Jmh7nd0HW9FHg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: wgoGPF3tGUOh4Mxh-E2Jmh7nd0HW9FHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhlbyBkZSBSYWFkdCA8
ZGVyYWFkdEBvcGVuYnNkLm9yZz4NCj4gPiBJIHdvdWxkIGxvdmUgdG8gaGVhciBtb3JlIGZyb20g
TGludXggZGV2ZWxvcGVycyBvbiB0aGlzLg0KPiANCj4gSSdtIG5vdCBzdXJlIHlvdSBhcmUgY2Fw
YWJsZSBvZiBsaXN0ZW5pbmcuDQo+IA0KDQpUaGVvLA0KDQpJdCBpcyBwb3NzaWJsZSB0byBtYWtl
IHlvdXIgdGVjaG5pY2FsIHBvaW50cywgYW5kIGV2ZW4gdG8gZXhwcmVzcyBmcnVzdHJhdGlvbiB0
aGF0IGl0IGhhcw0KYmVlbiBkaWZmaWN1bHQgdG8gZ2V0IHRoZW0gYWNyb3NzLCB3aXRob3V0IHJl
c29ydGluZyB0byBwZXJzb25hbCBhdHRhY2tzLg0KDQogLS0gVGltDQoNCg==

