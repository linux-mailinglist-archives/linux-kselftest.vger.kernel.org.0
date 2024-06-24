Return-Path: <linux-kselftest+bounces-12527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4391401B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C36B2820B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C61FAA;
	Mon, 24 Jun 2024 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="raMoYs3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46ED4C7D;
	Mon, 24 Jun 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719192950; cv=fail; b=NB9885XzQ7JqLWsY8OgNCsGoRdzXjgkMszrURD1kzh8hDUcnGciiwlCiSyaePDn2P7v3n8vykHc18hPq2EYLAZYJt8Ol/G4ov7pBT7vIAPjwy0j4UrlZZaGIo19RtbXuIkjtKwKY7FtS+/q0clYk5/D5Z6vrXGJETsWv6608PNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719192950; c=relaxed/simple;
	bh=6kA6h4gDi+HHYgrk+Db7gYm+yaePKOzT44yVVP1jD1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CRCEsdaSmsiQr9+Chp5Y6jAGwLqjE9Z4cyl1tJWP3au4XvFGYd9BMQF3yVirIIlZG6E80eJLb78o3tVXlznZ3HKxY0fK2aKHCxFjSfTkLg7TeZ5dWHY0QeD3Ib4DjzsGQYRLYlsioOFtV/8hMVfS6F6todf9CgpW4MogdRGhzfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=raMoYs3R; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktXcrKaMCK4iBYRypKMVe7N3sV2iT27/OnIRC28JrAQj5BU3zmNlW5NKR3N+8Vw+VW7teGmv3gy5OJRa/6MvHfb/1ntzYWyd3O/hF6ESRq0Dn+VJXx1pnJsTZqgo0eLtVhIqxklHzcjlWqAfpSAHP8ARqEWi7fCMenLR0npJ/CTWy2Iu1cWNE7XnV7qCAbjgIMvhA08FyjKtpLPYdc86ovLX7wEay5it2jm0K2hOzfyS5/4P72CeTNP6htjX57bRnD7uL8U5sVGv7Bew07Bq9Ajitva3kCLowY1KXcreTPxUGOIRVdh2Zd3cmnBHet41ckp8+7MA55XERpXYwp80Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J94LVqYy45OI3jqbcmjjSALgNeeWkbAAvTWz22WaCg=;
 b=lhR+5MCQKnMXh7/LQrmjCmofkxPEXDNJfQLGY0uhtLjEiqn7L+yj4mCE9J9W3eTUFQ7zTBhsntiCxRhE3tCN21oKYf2VnLeJSeogY23LnI476WpzHURsESgsQSdFm9i9HiROFfoZw3qzR444TL6H1bIpOYlitFXQBkAwC/vsZ3vPTilxeQdcNYpbdGTAWvWtn0NXMT3PHtdlriO0a1AlBawlGGtk+DecOWiVsqkeqpPHe0NeGlSTfVqhHe+oasvgtvDcN5E7L2Viar72+2rn8e3kE8J8hXLxLRiiZ0hSf3cD9s45gUsu1k7MJKw6SDVWfABEde7SfxezqzOyd8yr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J94LVqYy45OI3jqbcmjjSALgNeeWkbAAvTWz22WaCg=;
 b=raMoYs3RToeJmtxo/Lg7PqwL/hY+8PWjJVlWKDXi/JH/JUcSXqXRx21phu834ZIuAeK6+xDlG7KMaL0UETK1lNdRUN5W3rgvvwGVZ/C7Fxwm9pEEx4ZnpQIdJaWpmAbgFb+PLVWTfmVCYAxFcNe+ldAA9wdQHruHShdzE00TBk/9VfnyXnxDM2vUpqM8/bhaa2gKVfp12ps6JuCe1jGy/AnyIH6Ws1XofK4F3LjdCASrscw2XYsOMHs190HhtkHj3MzQMiJ7rgrmXFvNMSG2lrRUATMKzu+kgmMUu/d3/cBZixRlUphAw4UVPVGwhjZv9cTpyn19qYZ0AWGg/2vphQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 01:35:44 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::c28c:f5f4:7b8:e636]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::c28c:f5f4:7b8:e636%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 01:35:44 +0000
Message-ID: <fea19d65-fef2-4f2d-9ab1-85af4b85247c@nvidia.com>
Date: Mon, 24 Jun 2024 09:35:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
 <20240620193654d3cd1f05@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <20240620193654d3cd1f05@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::13) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1ad590-20dc-4e86-e617-08dc93edf734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1RBcnJLNFpHQ1VsZTA0MEMzUXNlbFNMWkY0bXE3QnV3WVF5REViSXZFNFMr?=
 =?utf-8?B?dGFYTHY0Tmw0V2t5UzJObUl5ZzRkTkJ1WTI3aXIxaXExR28zZ3JEamZHOVRV?=
 =?utf-8?B?Z2VieXFwMXIvNFdyUUJUYnlTaWN6dXZPOExPSTNEajdJVXdIYUh4QmpFWVhG?=
 =?utf-8?B?ZHpmQlFVNVR1ckMwcmt2ODZKK0l2OFVEaGZnV0NOMUVhdXFvUWNEQy9GNjJn?=
 =?utf-8?B?SlNoZUdmT1pkZG1TaTNhdTYxTVVDdXdlVENHdSszaFpGcWZ6RDZBbXVFbzlh?=
 =?utf-8?B?NnJEaS9wdkxmZlYxSndDMDdDVXBIb2pWMGRibnEwVnVNRGJ6UXg3YmZ4WjBG?=
 =?utf-8?B?YzUwY2ovMmhvOXp6eWQ4YXZOY2FDeWhKZnBUZk9GRTJpd1ZNM0dSaVIrSUFr?=
 =?utf-8?B?TFM3VmljdmJRcHZ5SW54TXBROUxjajIxS3RQSUVUUjFLTXRHOFJ2SC94VC9I?=
 =?utf-8?B?NVlEdEw5MnFmSVRnMmNaT0dXRG5vRzIvcmdGU0ZsQllsOS9ERkdUNGEvVTQw?=
 =?utf-8?B?ZEpsYWpMNCtiM2NoWHl5UWY0SEhqN2x0RGp1ZW9aOEVUdzFkZDlTWmpzcUpV?=
 =?utf-8?B?MUI2dXVVUkVlaHJXTmcwL3RTdmlsdDZTMVZyQ0lnYjdsUjByWGhISURqaS9W?=
 =?utf-8?B?cVBNZTR2NmJKaHdraDdaalpxZnlkSTNXVmx5ekpaR212ZWxteFlGN1VocWhO?=
 =?utf-8?B?d3pZdzI3bEZURC9mUkNRa0h5VVduYUEyV2tyNllFMmsvdE1SeXFuWmpBRytL?=
 =?utf-8?B?R0lFKzNkUzJPdjgvM2thUTdDb0VyMW9wVms3YXZQL1B2bjhpL2duWFZtZ3ps?=
 =?utf-8?B?RndDN1pQSElNR2x3bCt1OWFqc002aFNXdjRMVFpTVGpZdmNYWXRXL0I2c1hn?=
 =?utf-8?B?YTRTc3dUcWJPckpjcWxSL1FoMS9VUEkvYjJ5SEREbjhlTU5NVHJNRzhhOEhJ?=
 =?utf-8?B?YW8xaVEySlNZaGxvQ25HamRJN1pTZnh5d2M1WkIraDUwV1h4N1dJRlRUc0ZY?=
 =?utf-8?B?YVg3RjJxbEpYeXVqTUNuME5YaWg5OUdXNWZSNFZVWE9BVGxBeTQyYzE0eGxL?=
 =?utf-8?B?QzBLditWQ0lhWnNiRFQzZExsN1hHbXRwMlB4MkNzSkc1bkg5cmcwdFpoY0Fq?=
 =?utf-8?B?M1Y4blc0MXQvd0ZFL0VnbHkvMXlwT3kxZTJzd3pRZjdRMTExS25jdk94S2dm?=
 =?utf-8?B?dk83MW9HNHRDQVRaVERQYnRMa2tLSzZwZXV4SFU3b0FuVWxYT1hPZE1Zb1dL?=
 =?utf-8?B?bWZobmZWbEVyNTlqV21uWUw2T09rVGgzUG15RnhHMGNDTkRBazlzNWlveGFy?=
 =?utf-8?B?a21CejVMQzFhNWMvajY0T0VDR3k1RkNNajBVRjB4STZMbEp6QVFZUVJpN0wr?=
 =?utf-8?B?MDcybS9QV2ZIdmtQUjJkenVyZTd4eW1ndVZaNTlSamNoYzJmOXE5Y3NkeUhL?=
 =?utf-8?B?V3NBRVpET2xtcWwrQ3h2UG9JY1RPNmlydjJwNzk3VEZPZzNub05lVk9HMXdB?=
 =?utf-8?B?aHdZR3QyNjNCNERTR0x4R1RWdk84WTR0dElPT29tYlJJOVJoZGpvby9jK0Fu?=
 =?utf-8?B?Zk9EbEtmc1ZORUVqbjlNUVFQWis0M0Z6Qi8wRTRrY2Z6SER4WGN4SHRwa2ZC?=
 =?utf-8?B?eEFhOHRvSjZZUGZjajJKMm4wREhJemRtU3Y0cElOZ08yNnhLVjdKa0JjWnFa?=
 =?utf-8?B?RXFZQkdYMnpkbmVUMTRuUFFsUnVOK3RYeGNiUEZvQU1EOFVOR0NJNXZkcFVD?=
 =?utf-8?Q?P6AEr5S+Rkn+L2Cf4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEkxdzhrSVlsNzFTZEREZXY1Y0FUcU5NSUdXZUZSTzlQRk41VXg5dGs5ZEhL?=
 =?utf-8?B?ZElZVmQzblVoMmk2MWd5Qmd4a2ZhWXBORVQyOGZZeitnZWxVTEtFSTNKcmxO?=
 =?utf-8?B?OEdRR3EzN2ZhbGJhMFh5RUdDRWpZMjk2SUowSkh3UStpdGtJN3d5MGhkY0E4?=
 =?utf-8?B?a1BTSXF1Ky8wWXQrajBoOWplYUpSeWZMd2I3eDQ5ZllPYldkYS9rYS8rdHdC?=
 =?utf-8?B?ZkxJenFUc1FQNktET0RmQVJKN01oQ0hHeGpMUjd0UUVPUkZyMnpUUU5pck5u?=
 =?utf-8?B?V3pqcUl6SVF1dEVFU1VpUmZvQnY4SU1oL0dyWTJRZEsxelB4dG0wbFdQMHVZ?=
 =?utf-8?B?czltbjROMll6dFhhNE1rMGxSL05ySnJDK3JFa0ZtbnBtdnVCV0dybXNIS1Rt?=
 =?utf-8?B?MnB4elNsV3RVc3hWamVSelJoa24veTBzTkE5YndUa3BjUHp0emNXNWJzWDRr?=
 =?utf-8?B?dFZRY1psdmZSWmluOCtQWDdqNDdLdmRQK2dCcTF0bld6UW44eGZ3ZjJ1OEdY?=
 =?utf-8?B?MjYrQ2thTWNtNzloMG9XYTZvR0krc3A1TlhOT2UxS1JrdjhjRkVZOVMzYTYz?=
 =?utf-8?B?SHNPNjJ5dThhUk11VXZjbjc2d2U2T0lqZUdEcHlDazF2TG12N0tEQ1p2aWxi?=
 =?utf-8?B?dDFqbG5XcFVPbnk4c1RVandKdi9BcktwNG44UTNlV0Z6VVBFZTlGcEUwcUpR?=
 =?utf-8?B?YjlDaGdQd3gzZ3ZZQVd2U2RXbmVHWWFaRXFDMEdYL2Rnait6TlFlRGdlOW5M?=
 =?utf-8?B?em5OR3UzTlc1dndlTTJob3cwcmFEL2xONHRDOHVJc0hVQU1wTXY3OHJjQ2xv?=
 =?utf-8?B?MlFDTDZWbW92ME04YW5WZDVnci9remk5OXgwZSs5Ujk1YmNIejZXOCtIYyt4?=
 =?utf-8?B?cGxCMVlsYWJ2Q0ptNHZLZ3Mwd2JiVllRVHBVRGlFa3liV2xwMWorODIyNlZU?=
 =?utf-8?B?VzVBbmM4TXJQUUhQczhlSW9OZXgwdEpRQ3RlYU9MMDUzQ1NpeTZDZmdGbVh0?=
 =?utf-8?B?S0hzcnBkUVJsbktzRW9OcEFKTktyMm1ucGpzK3VhUjFrZDhyNmdXeWp4QjJr?=
 =?utf-8?B?d1lraTA4eEUvUlREbURiUzFuWnFxZDZuVFpGRXVxbVZ3N0FsUkVJTGpaTm9C?=
 =?utf-8?B?M0ZFYjJYaEszZkxwYTRjck0vc2ltR05pNjFhdk1ObHhaaytOVkwvd3hFOHhK?=
 =?utf-8?B?VjJBUVBrWFpsMHFJSGdNVGJiWkZzOEl4cjQxV3pQUERiS0taOHlDaW9nN1JW?=
 =?utf-8?B?aXZCYUdtZFhNSGdsem1TM2NHQ0EwVW02WFZ3aGp5a1BHQnc4VnZQNlBweDV1?=
 =?utf-8?B?OFdqUGdZOHlOQkVEQkcvZENTcnBJb1RtTWRBMXdmRUFwTzF4RklFTWxEWGFB?=
 =?utf-8?B?SGVMMU1rNkxCTmFoMmZZUDVGalhGUmZFc3p6WGVEdS9VUjF4Tk1sNC9lMHd3?=
 =?utf-8?B?MjdNU3Q1UktPNXI5NjVXdGJ4VjA1eXUydkFXNUpIUjZsK3RjZFlneEpETThZ?=
 =?utf-8?B?OWVMUkM5ZXNjQ1dQTmVWc3lmZ2FaSHNxN3Z1RjEwTHREYW54bmZyK1ZtbTZa?=
 =?utf-8?B?NDFGOFdXclJZZVZSRmFEalFnRDh6bzFTajJVNndpNWtwS1hIUTY5a2N5dTBY?=
 =?utf-8?B?VG5aOWQ1cGtoQkRFbWNrZVJXcGlPa2h2YnVwL2NVczNFTjZkczFWeGlRWUk0?=
 =?utf-8?B?UlZyNm5mZkppdXZ4eU11MnA2K1RoWExWNEJ1Y3hJNjljOUt3SjZleEJnNXN2?=
 =?utf-8?B?UXVTdDRVdUlYTlRCRk41Y3FoSXVzUElzOEdFNE1KT21YVm91cVV2bmcyRWMx?=
 =?utf-8?B?a0k2cmVSQkFweVA4UjQ0K2xjVVZpZXBRVWJMT0VhV24zVFd1aTRhS3ZqMlNk?=
 =?utf-8?B?TGI1NUpERjdCV1hTR3RkVU1USHRlbUpISlRNQlJFd2FnVDlTNUhTUU1IejZX?=
 =?utf-8?B?OFBkWE9scWxKQUxzV3phb0haek9QLzRkNnJYaTlFc2k4OEx6ZGNPeE81WW4w?=
 =?utf-8?B?d0JWT0J3YXpzcEh1VFFEVkh5VHVaUXV2U3FlWXIrMnJVVWlINnFuTWNFN1lJ?=
 =?utf-8?B?TGU5WEJldUZOUVl1Sm56aURacUMzS0ZvS1hFLy9zZDAwckkxRmMrZXFtaEhD?=
 =?utf-8?Q?LGya6Gn6GWywpC0oNNVAPhaQN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1ad590-20dc-4e86-e617-08dc93edf734
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 01:35:44.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVy3plhRod8s2SfYApwGfZZKyImZ9O9wSX94Ud08kYXrz8jzTlrcaQSnV1IRV34mbk2B3hZ4qV0S+iHB2eMkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242



On 2024/6/21 3:36 AM, Alexandre Belloni wrote:
> On 23/05/2024 18:38:06-0700, Joseph Jang wrote:
>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>> code. This design may miss detecting real problems when the
>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>
>> In order to make rtctest more explicit and robust, we propose to use
>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>> ioctl interface, we will fallback to check the error number of
>> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
>>
>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>> as optional")
>>
>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> ---
>>   tools/testing/selftests/rtc/Makefile  |  2 +-
>>   tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
>>   2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
>> index 55198ecc04db..6e3a98fb24ba 100644
>> --- a/tools/testing/selftests/rtc/Makefile
>> +++ b/tools/testing/selftests/rtc/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
> 
> Is this change actually needed?

If we didn't include "-I../../../../usr/include/" in rtctest Makefile,
we may encounter build errors like the following because rtctest default
look at the header file from /usr/include/linux/rtc.h which miss the
definition of struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET.

rtctest.c: In function ‘get_rtc_alarm_state’:
rtctest.c:94:15: error: variable ‘param’ has initializer but incomplete
type
    94 |        struct rtc_param param = { 0 };
       |               ^~~~~~~~~
rtctest.c:94:35: warning: excess elements in struct initializer
    94 |        struct rtc_param param = { 0 };
       |                                   ^
rtctest.c:94:35: note: (near initialization for ‘param’)
rtctest.c:94:25: error: storage size of ‘param’ isn’t known
    94 |        struct rtc_param param = { 0 };
       |                         ^~~~~
rtctest.c:98:22: error: ‘RTC_PARAM_FEATURES’ undeclared (first use in
this function)
    98 |        param.param = RTC_PARAM_FEATURES;
       |                      ^~~~~~~~~~~~~~~~~~
rtctest.c:98:22: note: each undeclared identifier is reported only once
for each function it appears in
rtctest.c:100:23: error: ‘RTC_PARAM_GET’ undeclared (first use in this
function); did you mean ‘RTC_ALM_SET’?
   100 |        rc = ioctl(fd, RTC_PARAM_GET, &param);
       |                       ^~~~~~~~~~~~~
       |                       RTC_ALM_SET

After adding "-I../../../../usr/include/" in rtctest Makefile, the
rtctest will look at linux kernel source header files from
<Linux root directory>/usr/include/linux/rtc.h to find the definition of
struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET and then fix the
rtctest build errors.


Thank you,
Joseph.



