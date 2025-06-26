Return-Path: <linux-kselftest+bounces-35810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17757AE94C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1467B7B4C5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FCA1F3BAB;
	Thu, 26 Jun 2025 03:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nTWqIuwh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nTWqIuwh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E61EA7CC;
	Thu, 26 Jun 2025 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910296; cv=fail; b=dV/tfijXJRdVjHNS0lkbDrNPN+Q6gZ5g+XlelTyQH8w1wDiVjQHUNtniKk94EbniH2hoafzclyE1EMfgiMDSiVuCukIZLuo6O7G1pAf6xaMh3Ms9T2IcLqhzxCkypSgoIpg4FhhnTwHWWFBVVX089zYJVAoVahTACpMZFQMARYE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910296; c=relaxed/simple;
	bh=GVyPObhoYJhHsxS2oCd6AWPseS0r/83n/jg9xZaSsAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X1ApZeIEfT94Xj+//mIOTwMgUet0vnaXYl1iqU+TbZHfcvM2QaBu04/txqL7BZZgqM7kWIy1A3EtTXnV696q5YytS16EqAnUPFaxzLzHnNsCiNdoUfHOYU6pPeGz4htX11iWJa9d9yLhrbRGCsJlQnLEeqXCx5Ei5UfauYpbB/Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nTWqIuwh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nTWqIuwh; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hgabUC/44WMm0zRfwCOhbMEkpcB58X/uLXx8TX9suEPEhxRfwvHSOd4YTHmGkCxfFSweAb1b+aK1F24rJrLowRyYyUMS7l8/+uxUC0AhFIk3Qzmu2b98iuY0KZQ4+XiMI9hCQvfJ6EFNxgnBBHrS+Awu7h5I17SMwp8ShZe2k4FcuoqBbUaDjsEdS/oV2gp8TxsS9nrZOGxBQ23LC1jsDNA+BjJRdIbu8lSTc04NMsANBfhlmzxg/Nz0vHQPSSqbGwIJQXvAY4j9+yu1Ej5klj1SQgY0wlpu+5o7tvWlI7dVxOHIdw4/MOPDn5hyEF+BSNL3+yGENp+P3DvgWD8/Wg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU0EZKtDuBS4+ZIQWiJTPKlvHszr5PzbaSc3h7CvIt4=;
 b=rvNvD4LFNGVmae5U9NFPi2LP3zmk53AjFwXXCrhWRSZe0QLFvS0GMRuGhkVwdulEWz7cuZDuForxDf7CVqXdFd5ToUJ28DGMRT5vLzUXiDMkzpPagEgTx67/OHV9Ktt1jCdTdAB2GWnCef3JDY6hSPcuzCqcfmlv99QTAkzic0In7l2QwyR/HHD+YMrSqpaccsFQR5vPBFbo3S8eGzNjGORyAHZbEBCF7ueYd2w+AzJKYJoj55F2Humgh7lwbvN+B5HyDGRr+VkZZryao7aBQgOsDwPaPazNeUhdEO8yTgZ4BVF0zYx3nFCxTVJO5fJNkf9ccOjZOdxPLReg+yyZ9A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU0EZKtDuBS4+ZIQWiJTPKlvHszr5PzbaSc3h7CvIt4=;
 b=nTWqIuwhOwcxETo821Z4Dl/qmvx+5Ay7WndVFXVZ6w1vsAmDS3dZDEi21VZhIB0/dQG9RfAZohzbKS2+AtvxlKHrcIKeUvhV6BkAedfDfyF7o0iA7WCdrhbPuacJbt9yileueMrYTvWPQxdBDErHLPuoehCrskHLH2BMwx3St0E=
Received: from CWLP123CA0193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::18)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 03:58:09 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:400:19c:cafe::e) by CWLP123CA0193.outlook.office365.com
 (2603:10a6:400:19c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Thu,
 26 Jun 2025 03:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Thu, 26 Jun 2025 03:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4zxBQqGiLQ+TMsUp1GEG6f5nsv+rqN1369amyOZXRd0YA5Vp45KOpBT1LgF6QMWUxyvC6lq3Q0y4jXpJ8rEO4Fu10Ayzld2NDytZhTc57Gnw6kbRnbgp1tnfM3RWhPmbqNtlpCtsX3DlUlJhelK2roC7zCq4I+chdFIxwLPPUmisP4msch5adqV7r028BKUH2Nu8p5EukdpYA2cJ5ulXkUErUv46SjrU5sYiMLZeRdev9ZbjeZxou7WGo8TYmn+wdeUsVSLuTgheSVFo+lHD7MBLMwgP/R48wgmOTJ3lvsg6b7YoTtyyik1FTGDseQ2rCm/IuQpGTN+VLy2JmYyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU0EZKtDuBS4+ZIQWiJTPKlvHszr5PzbaSc3h7CvIt4=;
 b=sJtGxAeJAFND6yafjaN9UozZEKfxNEXU5nEUC+a+GM551v/0dhKhgyLfDstnjpsRX8Q/7/ifh/I7i58MC/JtltZzJquZioQ3YSHPYCuotmxllhRxDOuIN1D9XyxZQ9n3wljtF8wTyF0+YPfRLLWZZQGLXu6jgzDaiLuGdxDQK5HnQXjgTnvopsBIqJzq7NzQkmoqlBMneN1H8L7k8YKeg7gu/QxQQBYX9eRtszpAru1QW1zfgJXkSqg6x7w5BN1dyr40ytu2rxhnIXulkdKsYdx5iIFuCMXh1+fHldF4T6IuAvRQHOcyLQSKh2C1FcDKMjZwMY2U6xhKjRtngFJjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU0EZKtDuBS4+ZIQWiJTPKlvHszr5PzbaSc3h7CvIt4=;
 b=nTWqIuwhOwcxETo821Z4Dl/qmvx+5Ay7WndVFXVZ6w1vsAmDS3dZDEi21VZhIB0/dQG9RfAZohzbKS2+AtvxlKHrcIKeUvhV6BkAedfDfyF7o0iA7WCdrhbPuacJbt9yileueMrYTvWPQxdBDErHLPuoehCrskHLH2BMwx3St0E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6005.eurprd08.prod.outlook.com (2603:10a6:20b:298::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 03:57:36 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 03:57:36 +0000
Message-ID: <3bc08930-06f3-443e-a267-ff02c2c053f6@arm.com>
Date: Thu, 26 Jun 2025 09:27:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Donet Tom <donettom@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
 <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::21) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6005:EE_|AM1PEPF000252E0:EE_|AM7PR08MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bfc746-30da-4e1c-b83d-08ddb465a951
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TE9QVHdRcjBKWGlBUmJSd0JTNS96R2w4YXlxRHVCRGZJNVZzckpmY1l6REgy?=
 =?utf-8?B?QTFUUlNNVzFpM2F3VjBiRGV1QXpRd3FETEZpTTZKMjVEMm4zbVFVSFRNdXVS?=
 =?utf-8?B?Y2pnb0E2T0Y4STVzZ1l4VkZ6bWtpMEFQSXZmdU45U1FrNkM1V2RpTllsVko2?=
 =?utf-8?B?QUZsNHNPU0o3b2pkR1ErNnE0NjBpSG1qeWdZYUxiTjZhbi96ZG1QUmFzeHJQ?=
 =?utf-8?B?eEE5dWxoTStmcUlQdzRQRHpzSlNJZ2htWnpLenM5S3h0MkIyVzRUZGEwK2Mr?=
 =?utf-8?B?amRNb2N3WnNPeFlGQytMZHRoeURlS2ZpQ210WmtPQWhvbjlFUlhNVGkwTWk5?=
 =?utf-8?B?eEU3bC9QU1NTV05kQ0YwakFxMlhtU1NUTTl3TS8rLzB0WUlUSy9CYlNVZ2Ru?=
 =?utf-8?B?RWc5d3lIdFdSOGE2aDM0Yy9ucXFSRXBxWVFpbWx4bk44UEFwVytTQUZTNG9L?=
 =?utf-8?B?RFNkc3pBVXdMVkxWWmF2aG9LdmYzcTYwVFRtalcxY00vQXdLcWZoSnhaYWxG?=
 =?utf-8?B?WE5rRUNCYy9ab3oxaytiQTZJMWMvcWs1S2VOSDNVWnJheEx2K2JjQlR1Yyti?=
 =?utf-8?B?ZHNiZmtmSitaeUJKRml5WlBjSXdYZVJxRWdrdC9qRnoxeHBjZFhiNzRyUDNU?=
 =?utf-8?B?SW50OUJIamxNR3llcS8yQnA0WkxmNXFTZ2FGQjFBbEZJTmJRYkM0RkxZTERU?=
 =?utf-8?B?S2NlV1hWL3ZhSHhKODBwWVRzbnlBWjVTUTlmNDdFSldUTjZweXhha1lsSmxX?=
 =?utf-8?B?UFdWT0R5d2NQL01MRFlCZGlXdGVtNzhIRG0ydEd3Q0NQbEZTdmJNTjdGdzJ1?=
 =?utf-8?B?TE9FODl6aFpPcEZZaUpoMitDenluYmZLN0NaUmtpUWFlYzVXUFNsY0NqaFdn?=
 =?utf-8?B?cXh5SkhJKzFQbGhnWDlqL0NkVkQ0aEtTd2RDV3hDRDkrY3RWR2cxa2VDajBS?=
 =?utf-8?B?WDZhbmM0b1FtVUdhMEU3RGYwa2trTmxwNFRzRERJekMrVXQ0ZGVSeDE3cEZS?=
 =?utf-8?B?LzVWL003MW9yZ09SSnF0RXFnSTc1cUkzNFpwMUFTYXdKTUkzMFovZ2ZIRjJH?=
 =?utf-8?B?WW41OEZFWU9ndkFnNGZwQjJSQ3BYU0ZSOFJia3VMdUxKckRFR0laa0dKTkl0?=
 =?utf-8?B?Wjl0QlR5b2dhZzVDcC9QT1ZydnRwS1REV0xxaTYyM2pRWjJLRk5vckxWMzNM?=
 =?utf-8?B?cEEzMUFndk02OVZUQWVEaEVNMjNwdVp4TzlnWHVMb3YyLzk3dHgwV2ZTVDhx?=
 =?utf-8?B?Mlh4QWdtNmVxbjN6dkFjdC9kNlBsUlpHTlVrRld1bndUNTFyTnk3L1ZDZFk5?=
 =?utf-8?B?L1prVUw3dGhMVGI2NFhGNnAxVkNra0I2YVlOZ0VZVkVjYnVEUG9aS05DdkFq?=
 =?utf-8?B?bnhJQ0FnMnc0SERhNVE4WFY4L1dJMEZWZ2R4WmV1V0dXb0EvRFVwQThoTkxi?=
 =?utf-8?B?L0dWOGFoQlJ3TFE4ZDhFdWZ5MzlTbVh2dWgyQUZtQ2FJWGJCWDRZaUJyb21n?=
 =?utf-8?B?UnpqYkRObytibTFuOHNMNit6U2w0VEltRFdXM0NXY0lnUzVhaWlQU3d0ai9R?=
 =?utf-8?B?Q3JHaFZ6Z28zd2lYUzJrcnYvNFJrbzRGVDVkNExua2ZZQ0xCN3IrQmN0RW01?=
 =?utf-8?B?RWVkSHBWR3dsbGFySVAvOVkwb0lLbVRzeFl0OWl0aFFDOXZrd2x4Y2hGc3hm?=
 =?utf-8?B?dll1RE5DZGczclAwYm5OMWxnS2ZrSjh2QTNDTE1WVmpXaGlucldTbTBBSkVX?=
 =?utf-8?B?NTlxR2pDREYzb01rZVVVU243MkdBWFd2WUhSZ3NpUHUraG9qTFhYQUpvMzBz?=
 =?utf-8?B?cXhya1d6TWdPVGlnUVIyZklYM3lNRXBreVlPNVlRN3NUeU9YUUJLR2QyUWhW?=
 =?utf-8?B?K3lQYzFRMTdxbjh3anJKck9vZGhYWkJlWlkrSlNUU3dlTEZOdXBNYlNUWFlz?=
 =?utf-8?Q?hFZ8nYXcB40=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6005
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	289349bc-48b9-4abf-d0ac-08ddb4659601
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|36860700013|14060799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFgvbTJsZVFkdTJFSW5FbXpnQS93Si9JOGE2MGtsaU5mL2xINEk2WTcxbHN3?=
 =?utf-8?B?Yk9yVm1PNlJPUkFPMW9PcXdyTnhCQ21pSjVzZlVBUGhjMTBCMC94eTQ5VVJE?=
 =?utf-8?B?cU45aThpRGp2ZXZBeHpWallKUk0yNVhRQjNRaVQwVEJxTVhLaFBmL3A0dkhn?=
 =?utf-8?B?dFNxVlV2a0pkRHFNNlFITGhUa2kyMEtXOHlqK2lyTFhzQUlNSXphZmNNVXl1?=
 =?utf-8?B?OXpEZGxsblpyYWc0eFBFc3VuM1NzN2tVbkd0S24wQ01vM0tCS0tER3JxWllT?=
 =?utf-8?B?T1JPa3d5L2d1dytoVElyRFhwVFpLWGEwNjRSZVBjZGI2YjJ3VEJsb2E5dWFz?=
 =?utf-8?B?RXBWYUVha3ljbjczaldtMkNmdzhYMVZTU1gyUVJwRmk0Q1plUlhhRFpkK3Bs?=
 =?utf-8?B?MXFyQ1hITmZ5UkpiWmVMSkJnS3hFUHRIcXhBS1BrRkhiRElKQTh3ejRMWkha?=
 =?utf-8?B?aWk2QjZ3QVRmejhLbXhoN2RzVkNLSTd5aGFpdmVtTHA2YTJkamFCd1BHTEJk?=
 =?utf-8?B?OVR6YVg4WDBGbFdrWU10eDU3VXhZcWV2aWlsR2Q4V0NBOGJZZXd3aTF1TC8z?=
 =?utf-8?B?TWZmSEtVc05FZllacmhJRlV4aTRuZldDSUpIemJEWnlRbFpjR2NsREVpMVNU?=
 =?utf-8?B?WEhDTWIzNnhRK093WDR3cGsrL3A4TjJyeVRmdTRHVkpuSW1iZS9aZzl6d3RP?=
 =?utf-8?B?c2hLc0xSa0dXZlpzNXk5RTN1NkE0bXNtWDU3WGU3YkZHOXZqR2NhS05sc09V?=
 =?utf-8?B?eHZNa1Fjck1BeGl4clVuVnFZdUx1VWpqbGxlZ0V5eWhhSkF1Qkd1dUN4Um1j?=
 =?utf-8?B?T2pVYnp0Z2VuNW5oaUkxZTd6OTVIMlJBQVRSK2dzdGNvdC83ZTBKM0xFM0Nr?=
 =?utf-8?B?SnpIL0hLVlEzNVBhNFRDU2RlTW82UWpSQldpaVFaNjNXeGJyT0FOZG0waUNu?=
 =?utf-8?B?WVVSWmV5WFV0Q1kxSGhsUG51aHplWjUzQlo5Wlo4bVNkU1NWTU00SGFRZGtm?=
 =?utf-8?B?M05kQm45OTZkMTB2UXcvd1pWK1Y5RjVEZUNDc3JlanF2RndXaVJIcXZUUGZ6?=
 =?utf-8?B?V1ZYTVdFbHdPSkdpc2ljRkowZkQ1TEJsMlYzNmIzUEtZeWxlL0pZUVlpOGdl?=
 =?utf-8?B?Znh2NEp5L0hkQ1pPU2tid0V4ejZGZ1k4TmFBS1lpWGh3STB0MjMrSFFUWFU2?=
 =?utf-8?B?NHl2bHhUWmR6M0RNU1ZHZVpua2grc2FDbVpEc2Q1WnBBeWN2YUorMnJMeGVo?=
 =?utf-8?B?ZmFwTmtnY2dDVzd4YUFjcXlmVENneitPTm9pK2dxYTVQUUdJSHpHc0MvQk5y?=
 =?utf-8?B?WWhzOWJzRDd0SlpCZ054aitUTThWRWNpc0pNSWVKL1djTUthYWFjVGUxUS85?=
 =?utf-8?B?YXEzMnlab3FpRkpHWkU3eU5ZaWRTcUZoZG1SLzcyL2pPbG9ZZG95SG5pUm5T?=
 =?utf-8?B?NURuK09ENFFyOG5oclljU3ltRFNoL3FXeUg4RXg1ejRXN1JRWnI4WkpzNzQ5?=
 =?utf-8?B?N2NhM0pnSDVRa0I3OUM1dStkQXZkQWRpcm1rU0pqUHUwWEM0YTlpSWxSbDZm?=
 =?utf-8?B?OGVOelFLdDBkcFFueGM1ZFNLZjQ0T2xSV2xxc3lFeDYwVWNxdHpMTktrM0p3?=
 =?utf-8?B?VE9xV3NRWVgzZVJrVnlyaTIwK3FIV3hqNUJLcHlmdFpJTjdGRGtuT0FVSzNX?=
 =?utf-8?B?anMzK3lJTVJrdHhJcFJHSkp5d3ZvNTNOcVh2Y3RZdk1RMWlwaktxS0hWYzRX?=
 =?utf-8?B?NDlYZmg0bDNWcWpmQjdwUksvRm96ajZtWENnNkhteFhWQkJ2WS90alRPK25Q?=
 =?utf-8?B?Zk5UUUErMEhZbE9pUCtIUERLUERwd1I2ai9Qd01oU2VCenVXUTEzUHFhREo0?=
 =?utf-8?B?d3EzN1lhSlN6K3lWTit6NmFjT1hzeGhvWXZEUkZtMmZXbzRQbGZzSTVneFpy?=
 =?utf-8?B?bVBPNnJhQXBRT1JtWUpqOVF3Yk1lYmNnVUJjUHQyVUJKNzNSTjFlWjgyWEt6?=
 =?utf-8?B?SHFHRmk1L1d0TzlLTFl3bFY3eVNoZ2kwRGxpWnUyZFRXVkV3QlNQS0ZnRE9u?=
 =?utf-8?Q?tYUV+J?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(36860700013)(14060799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 03:58:08.0908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bfc746-30da-4e1c-b83d-08ddb465a951
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333


On 25/06/25 10:47 pm, Donet Tom wrote:
> On Wed, Jun 25, 2025 at 06:22:53PM +0530, Dev Jain wrote:
>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>> first.
>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>> mapping count check.
>>>>>>>
>>>>>>> In do_mmap():
>>>>>>>
>>>>>>> 	/* Too many mappings? */
>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>> 		return -ENOMEM;
>>>>>>>
>>>>>>>
>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>> this.
>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>
>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>
>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>> is doing, I can do that : )
>>>>>>
>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>> it passes, but it might just not be of great value.
>>>>>
>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>> leave larger gaps if we feel like it :)
>>>> You have a fair point. Anyhow a debate for another day.
>>>>
>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>
>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>> implementation details.
>>>>>
>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>> userland VMA testing I'd say.
>>>>>
>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>> technical appraisal!
>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>
>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>> this later.
>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>> the gap check at the crossing boundary. What do you think?
>>>>
>>> One problem I am seeing with this approach is that, since the hint address
>>> is generated randomly, the VMAs are also being created at randomly based on
>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>
>>> High address VMAs
>>> -----------------
>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>
>>> I have a different approach to solve this issue.
>>>
>>>   From 0 to 128TB, we map memory directly without using any hint. For the range above
>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>> starting from 128TB.
>>>
>>> With this change:
>>>
>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>
>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>
>>> Below are the VMAs obtained with this approach:
>>>
>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>> 20000000-10020000000 r--p 00000000 00:00 0
>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 4c4c35eac15e..0be008cba4b0 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -56,21 +56,21 @@
>>>    #ifdef __aarch64__
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>> -#define HIGH_ADDR_SHIFT 49
>>> +#define HIGH_ADDR_SHIFT 48
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>    #else
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>> -#define HIGH_ADDR_SHIFT 48
>>> +#define HIGH_ADDR_SHIFT 47
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>    #endif
>>> -static char *hint_addr(void)
>>> +static char *hint_addr(int hint)
>>>    {
>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>> -       return (char *) (1UL << bits);
>>> +       return (char *) (addr);
>>>    }
>>>    static void validate_addr(char *ptr, int high_addr)
>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>           }
>>>           for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>> -               hint = hint_addr();
>>> +               hint = hint_addr(i);
>>>                   hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> Ah you sent it here, thanks. This is fine really, but the mystery is
>> something else.
>>
> Thanks Dev
>
> I can send out v2 with this patch included, right?

Sorry not yet :) this patch will just hide the real problem, which
is, after the hint addresses get exhausted, why on ppc the kernel
cannot find a VMA to install despite having such large gaps between
VMAs.

It should be quite easy to trace which function is failing. Can you
please do some debugging for me? Otherwise I will have to go ahead
with setting up a PPC VM and testing myself :)

>
>   
>>>
>>> Can we fix it this way?

