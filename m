Return-Path: <linux-kselftest+bounces-10942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0778D524A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866132852B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FA14B96F;
	Thu, 30 May 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TN8Apn21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246D14B953;
	Thu, 30 May 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097121; cv=fail; b=uBszvn4cPT+Zcht4oHLEsssdVpGjob+og/kxMqqD1ZKFykdh83LKDQjfrKWh2MVRj90pgxdWMvZkE7j87DwDDNWOdil9dZsKneJgwm1YzSvUsai4CPV6FkRe8TVTHRpKN6ZOXoSt5aqG1rF4Ox0nrJC70M897/aIDPzbhngRC80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097121; c=relaxed/simple;
	bh=eAQuQWqsXlQ/FVm6lPtjTnDElKQyBHYSmZkCCSyFrbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=batsWx0JWh6HsDL9FpHDFkYHhc7prFHBJc7eiIw1UYkiBRRlalKS8geW97tJbyrH1KVw0dMQMbGl40yc2Qpcj024y4ZDRSAY5tBVuI6rGgjz5pKbtstlofzsZExxXxUtb/FwqMzCBP2XhbMNMqO6HRBvDD92CGzZFDgjIDovQcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TN8Apn21; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIjr/MkX85mFoXVirvNGEM2dngEh68PUoUhsRzC85RWi3YB6Ja1JRymU8pXUiSDXV7SICprgSBuSj9VeE9S0vrkgWMfwE7FSRVxPoTlxFpN46eOAVUaApDaZSjv7VieoEffxN+UG4qYL+prAqzYvQN787YTsp9dtNS+h0n0DgYx45JLWOFaRvEFbwoSO3z3W1DB5voH7Vmby7WArm3Cz3EhGFAEpeSAc3LQuroC0JriuC7BV4ck4ZueS8bziDXtPyIlKsB7bTw4lwTWGnWrDVGeKGcJ7xB7cig3DpGKpvE5s6dpUsKwsE/LHvdOuCCtGSD/zuZWKbyVt+m/QGnuiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVjtq0/TDhpZPnqZyaHsArlrKOMYHFMdoxe2z246KRE=;
 b=GMxde/6iFppNTbr217QwHuDyo1QxuVEvE+7EelxtIRhkMQzbxbZv94/KTDcaBg6zeFP4uhFBCLob8f6KQlVwkvjLS40NFNt0OR+w+igAJ/bGUFAGMZSYXdBmaIk4C8t8anYrfedUFRiuNSOSYEPghMlRND5ghBw6LVw8KNwi+ccHOscKR5zAq3/WQIKqg23BcF9RI/b3+maz2Heebmqzwwy8gMuyyRaNbnnmFefOhC7A0YnJGnhY7VsihYjpWMgBhPchGr54oAQ/JZmXULBI9TBes1DABaHL57AFpwXtoAUjUs2m6tcp20qAyUxerZwsxFMUwO/19D+xAssiRWKDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVjtq0/TDhpZPnqZyaHsArlrKOMYHFMdoxe2z246KRE=;
 b=TN8Apn21hT2FALH+zEakuVf1u1zdvVNPdBlRDpe4HdimqLslj8+y6BBgGCCz3ofd8PKP5DE+WGY3zEjz4gEq4onthicIuFL6Ql/qRKEfpyWLnKQd2NJ/xnwPz59FvMJ57kU206FtchtKo6+b7fwnPZxuwmkKn9Mee/QLQLut5WWm8zMkBQT0wuZS59h3dDxflkYZsuZguXL2Fc3IhC86jYAltk5kN+4NMQio44C+VVkjAzRyHlgwhQmFxQNmjECpSysW3J1OKw3QbQ4Kv06YOv9KUDOdJyRmT+S3G1QnRDBs4al9WTgE48zbrq8/ZtPIgUoKu3j7u2ODMGKuigAWIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Thu, 30 May
 2024 19:25:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 19:25:17 +0000
Message-ID: <b29ca6e1-82a0-4682-ba29-cb31f53a5502@nvidia.com>
Date: Thu, 30 May 2024 12:24:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240527211622.290635-1-jhubbard@nvidia.com>
 <0816b38b-41a1-431a-90a4-1ac33401a671@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0816b38b-41a1-431a-90a4-1ac33401a671@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: b253c4ef-8db9-48a5-03ad-08dc80de3cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TC84V2RyOVNYMnIvKzJBa0xJVFFjQk56Wk9PSDEzcnh6KzlWNmNxYmFKNE5F?=
 =?utf-8?B?dXVpUlVNRHQ3L2Y0SStSOUROdmxmL3cxTnhFSUwvaG10Nm5qL2QrYmovcFVi?=
 =?utf-8?B?dmVyaEx5Vzc4bXV6NVQ5QnBvTU9CNWRFWXFrQjVROE5KMnByOXZ6WlZIaW1B?=
 =?utf-8?B?Uml1eDVBd2V1Wks0U1dUR2dpSWQ1dlNWRVRodGJmK3NxSEgwczMyOGtZanlC?=
 =?utf-8?B?eXc0WDBnREN3bDhGaDA4RTNTVmQ3ZTZ6M1BXM2RURUk0clpIdlBkL0RRdWZy?=
 =?utf-8?B?TmJUZWJIMkZQNTAvS0lUbHp1bFBMa0ZEbC9HR3ZhQi9NQm1jZXBzMUVRcnUw?=
 =?utf-8?B?NDF2YXFHM3ErSTJpcThVQWlrcmFDL3pBZ1E3RzY2WDhzSVA0emU3cWRkN1Bq?=
 =?utf-8?B?Y2JQL0RPTmZVRnZ5TDgyMmRJcVNYcmVWeEsrL1JzaElJQjZnR0d4aENSQlpO?=
 =?utf-8?B?MlFDM29lNXp5T0dDVzlrVEI2ZnBtSGhRT1RMTWozSkNVdTc2Ykc0ZUR0K0lu?=
 =?utf-8?B?bHpHYjFUWWsrRVNpWmNBdnk0SDlLeTdmQzB3S2paaEozR3RHWmZ1clFCcXdZ?=
 =?utf-8?B?NG5RVGJZdDZoVWU4VE5qaWJrUS9sdlpyenFwK2hKczhGcy9XQmkrSUJrdloy?=
 =?utf-8?B?N3dlT1A1eTg3QWpsWmxtS3BQR1Y3c2k0ejRMb3VGdUQwMFRPbHR1TTBUZ1Fm?=
 =?utf-8?B?K0VNMHZicktPYWZzUVhnQ0dPZmdRS2VnMHJEQ3pTRVlRSWMxZm0ySmdZOVJ5?=
 =?utf-8?B?MTJxZXZFWjVwb2JYU2N2ZE10ZlIwTXI1RTRBMWhXZkxYVWNyMjVQZmFETHZF?=
 =?utf-8?B?UEk4NWEzTS9lWEU5VXR1MDg3MlJYcGpndTIzcFB1Mm55YlU2RXJ6Wnc5emdh?=
 =?utf-8?B?bjBrTDJzUWIzZDBhUVRUOUwvZW9wTTV6YWl4YmdlcEF2V2wvNjZUcXNxS1Vq?=
 =?utf-8?B?YUx4ek1hVnNEcVY4STgrUW1sSHdGcmw5UjVKbU9lZncvRVFhSytwcjcxSi9q?=
 =?utf-8?B?akFpckdENUc0L1pmMjlVNkErLzhYL2ZBbU5UVGNOZ2gxQnJaeXpqNzBQOUpZ?=
 =?utf-8?B?NjNuNGlLcGJ0TUlpVVIvQ2dUMmJZNDhZTXpKM1ZOUGgvU1RBSUU2Zmpxdnhz?=
 =?utf-8?B?T2pGZUpVSlFjSEd3bjMzQUl4UXNGQ2Z2T2dwNlRsVlc2TWFMazJHdmp4dW9Q?=
 =?utf-8?B?Y2VnZk5YNUF1WDFGMFhzMUEwam1tNjJ4Y0FtbG9ISk9YZ01MNkZURG40WFVI?=
 =?utf-8?B?Tld5TWxTajZRRlY1NDhMYkloTUwya1JYZ0lYNkpyWDhFak94RUhNOXdYMG50?=
 =?utf-8?B?ZS95Mld3WTRpL0E4ekozaU9SVzJIU2k4Qks5VWdMRmFIVEpRS3E3SURNOVNs?=
 =?utf-8?B?Z0tNd2pFL0ErbW8reU03RWcyaDJuaTFpOXArb1ppd1d4RURLZGlLeW9iM2Q0?=
 =?utf-8?B?TTJadlFxcmpValRKU1U4ZENQdVRka1NVUmtjQU1xSE1RQmluZ2tESi9lK0xD?=
 =?utf-8?B?VkkvK2hCTDZUOXNQS3RiU1A3THhIdzIwdXpJenJNZlA1UlBEcUNpT3k2NSti?=
 =?utf-8?B?N0dZeDZzTHVPbG9JdGgzTG4zbCtWU21sTklHbTNTYWxDd3U0UzZ4TjhsOGNP?=
 =?utf-8?B?S2xmbTBTdGorcGFnN3lKRXhvVGVkK3hxalRYT2pNU2RYQ2xGTUM0QXFBcHJ0?=
 =?utf-8?B?VUdPTUplQ3AyU2JHSTdQR29UNmIwdGxDSUJrL2FMNElnQ1pjTmhVY0J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJ5WjlreFZXWGJwRnJIODVpUGU4QmRjWGhQeVNyRkN1YTdrM1dpbG84OHBC?=
 =?utf-8?B?VTVHOWVsMXNFY3gvRHNCc1g5dGI5K2hyMmdjMm1VUlZkNVZNZkhWeFB6UTFw?=
 =?utf-8?B?WWhXM3FSTmduU2UxZzlDbURRb21VNENqV0hnT3RkVnB5ZmUweUdQS3Z4SGd2?=
 =?utf-8?B?dnNMMDdQdDYvcThwQmNPQlRYTE5nbDlDZngwNnZNaHF5ajFoT1NudXQxYkYv?=
 =?utf-8?B?K3luNWpkZ0hzaTk4MnpWb2xyNjZ3bkg3QUlWdVJRWWF2M2dsVWI5ekdzaE14?=
 =?utf-8?B?d3hQeDlvNUVwTzg0RDNHQ1M0VkVJWVpzSFJEc3NuV0FXenllMVlBSTR1OGRj?=
 =?utf-8?B?VDhyTTFUc3ZFZFFWa1BNdWd1NWxPZk0wWVFydWhWcDhGbXVRWERCRldRN2NC?=
 =?utf-8?B?dXBDRzNMTXc3ZDdaL2RONjc0enp6Y09IMFA0K01uZUNCd3AyVG4wUWtGVWhC?=
 =?utf-8?B?L21XNTMxSHlXSUxReGlVOHZRd1YrTWpET0toL3RnSjRqT1JETlcxR2lkZHBw?=
 =?utf-8?B?TFlJV0RVMG5jRUk2WEE0bTJURkIxc1VrV2hKTGtLSWtkZ3lWem4wQ09wemZG?=
 =?utf-8?B?YzJ2MHV4Z09JL2ZjV0tSTGhoWmJ4Zjg3RUNHTVZ1RnFzeEtqS1VmdVFhaGpX?=
 =?utf-8?B?aiszQjFSUlN3ZjZ5NEpQTDNyWmhrOEs2a09XTzAyVWt1RndONnZZbm90RjQy?=
 =?utf-8?B?UnhtTEYyRkFvU08rTlRuMDFSazVEaVJkdkRWdFlaMWtzL3M3NjkyUzdRcEpH?=
 =?utf-8?B?SXBvUm96V1pwaXVIMlJlM0h2U3VUOTUxb1RBZlhkck8rZ0VrZXN5T0VjbXB3?=
 =?utf-8?B?VlVoemwyS3JwTXl5V01rVnRoSVhseTdrMktYbThLMlQ2UXBqMTZyV3lXOGFU?=
 =?utf-8?B?YllSZlIvUVlLTDZGbGNlUFVhbFhsVk83bzFlUTc4b0tzZCtOanNubmhsQXpB?=
 =?utf-8?B?WmpoWlg0ZmtjRE5hd21NNFNvWEdrWVlsanRqUm5ETnRMYzh5aDBZTDRzQ1hB?=
 =?utf-8?B?ci92YkNZano0cTRHMkJSWjRQSVRtMU0wL0tBZUJZYTh5UTBCdG9Ld01WTWNM?=
 =?utf-8?B?VDNlTjQ5N2szNzlvc0RJeTUxaFRnVVJPdytSVGJCWlpEQWo4aXNuaWg1WFZD?=
 =?utf-8?B?TDY0dUdLWGhRbk92TmpJUkNnMHVhQkVUTDZwV3hYOERGRWZUSFFXRDVOMUZj?=
 =?utf-8?B?NmM1ZVQvMlpmMTVEOCtCWjh0ZnQyc3hWMExuSFQwdWR6ejRsc2F4NGIzeHJS?=
 =?utf-8?B?RjBMZzRzV1NBRlh1TFNQb0pGMFhCNUozZVlkRVJ0dTl4SnIrRDFVelRlbnpS?=
 =?utf-8?B?QzhXcGJ3aEhEYVBqQWRVMzdqRGFaMXBzQTA1dlpxK21zRlZ6RGpnTGxsdzZr?=
 =?utf-8?B?ZG1xaENzeXhhVVc2MjBqaTgraEs1R3UwSDFhMDBIcnR5S3JnTVRMaUlBUkJD?=
 =?utf-8?B?UWFIcS90aGphdmVQYVBac0JSWUZrSlgzaHFkTTV2WHdlT0RyeWpzWk1XWGpL?=
 =?utf-8?B?OFhCZHdScEJWZDVEb0M2RDRuMnQrR0NzTGp0WndpbGF5MHhTbnhWWU5XYWVl?=
 =?utf-8?B?KzlBaWhWUlg0U000aFh5R2tkLzh6cURFOHVEMUNkUXpaOWJVMndtTThnVjll?=
 =?utf-8?B?eWtEQmJ4aDFNcUNYdXdjeXVOeXVBNE5hcEdYRFRWSWlxTTk2WjFoejByQ3or?=
 =?utf-8?B?QU5zb0VCVEt4MTZNWVFOclkyNWlJK0hrUU9FTzJYb0RVU2RFb0dWZUdpS3hO?=
 =?utf-8?B?dVlaaVdmMklmSU9Nb2RQc1BKMDdSdGtmY01wRjA3YWZ6MStoeFpXN2N5VkUx?=
 =?utf-8?B?Vm9Xckwwa1l0a3ZsTDlVVnNoQjBxalV0cHFCZHplaklqU0RnbVJYT0ZCUVhs?=
 =?utf-8?B?UlBwd3k1V3NrRnNScXc0OGxpWnZ0c3JIZ0xIdGxpeThmMXpzZDhkUFBsVUc3?=
 =?utf-8?B?ZzFFd0pEazRsT3l4WkNOcGhhVkJWUVo2MVFBVW9iT0RVZjlOb1JGbTVFNWl2?=
 =?utf-8?B?Ulc1UmhwdTdNWVNlTnRnRTl6WnlwWGFpTkVCaFhuWEhPZTdaK0hROUNnZmcz?=
 =?utf-8?B?bTEzYmFJa3F1T0Q3cDZHQ3VwSUp4VWkxUnFCWVVxVmY4bFZhRXNISWlheW5o?=
 =?utf-8?B?N1BkRHd1ZG8zMGpTdlMybkx2MTZVS2Y5c0NrWHNjY2hXS2tEcEl2K0MvYnVO?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b253c4ef-8db9-48a5-03ad-08dc80de3cd7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:25:17.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXC9/FhG7R/Oj3pt9WWKU2lkau7QsgwPjiDk19jT0mwxynVut35Hg2N0TvctAfYL/qtky8pQXiw/+Qy3KZa53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

On 5/29/24 1:05 AM, Muhammad Usama Anjum wrote:
> On 5/28/24 2:16 AM, John Hubbard wrote:
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...there are several warnings, and an error. This fixes all of those and
>> allows these tests to run and pass.
>>
>> 1. Fix linker error (undefined reference to memcpy) by providing a local
>>     version of memcpy.
>>
>> 2. clang complains about using this form:
>>
>>      if (g = h & 0xf0000000)
>>
>> ...so factor out the assignment into a separate step.
>>
>> 3. The code is passing a signed const char* to elf_hash(), which expects
>>     a const unsigned char *. There are several callers, so fix this at
>>     the source by allowing the function to accept a signed argument, and
>>     then converting to unsigned operations, once inside the function.
>>
>> 4. clang doesn't have __attribute__((externally_visible)) and generates
>>     a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>>     to require that attribute in order to build, run and pass tests here,
>>     so remove it.
> Just checked with GCC 5.1, it builds fine without any errors.
> 
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> LGTM
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 

Thanks for the review and testing, Muhammad!

I'm also adding Andy Lutomirski to this thread, in case Shuah would like
the vDSO maintainer to ack or review. (scripts/get_maintainer.pl is letting
me down, I will need to run "git blame" more I guess.

thanks,
-- 
John Hubbard
NVIDIA

>> ---
>>
>> Changes since the first version:
>>
>> 1) Rebased onto Linux 6.10-rc1
>>
>> thanks,
>> John Hubbard
>>
>>   tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
>>   .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
>>   2 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
>> index 413f75620a35..4ae417372e9e 100644
>> --- a/tools/testing/selftests/vDSO/parse_vdso.c
>> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
>> @@ -55,14 +55,20 @@ static struct vdso_info
>>   	ELF(Verdef) *verdef;
>>   } vdso_info;
>>   
>> -/* Straight from the ELF specification. */
>> -static unsigned long elf_hash(const unsigned char *name)
>> +/*
>> + * Straight from the ELF specification...and then tweaked slightly, in order to
>> + * avoid a few clang warnings.
>> + */
>> +static unsigned long elf_hash(const char *name)
>>   {
>>   	unsigned long h = 0, g;
>> -	while (*name)
>> +	const unsigned char *uch_name = (const unsigned char *)name;
>> +
>> +	while (*uch_name)
>>   	{
>> -		h = (h << 4) + *name++;
>> -		if (g = h & 0xf0000000)
>> +		h = (h << 4) + *uch_name++;
>> +		g = h & 0xf0000000;
>> +		if (g)
>>   			h ^= g >> 24;
>>   		h &= ~g;
>>   	}
>> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
>> index 8a44ff973ee1..27f6fdf11969 100644
>> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
>> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
>> @@ -18,7 +18,7 @@
>>   
>>   #include "parse_vdso.h"
>>   
>> -/* We need a libc functions... */
>> +/* We need some libc functions... */
>>   int strcmp(const char *a, const char *b)
>>   {
>>   	/* This implementation is buggy: it never returns -1. */
>> @@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * The clang build needs this, although gcc does not.
>> + * Stolen from lib/string.c.
>> + */
>> +void *memcpy(void *dest, const void *src, size_t count)
>> +{
>> +	char *tmp = dest;
>> +	const char *s = src;
>> +
>> +	while (count--)
>> +		*tmp++ = *s++;
>> +	return dest;
>> +}
>> +
>>   /* ...and two syscalls.  This is x86-specific. */
>>   static inline long x86_syscall3(long nr, long a0, long a1, long a2)
>>   {
>> @@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
>>   	}
>>   }
>>   
>> -__attribute__((externally_visible)) void c_main(void **stack)
>> +void c_main(void **stack)
>>   {
>>   	/* Parse the stack */
>>   	long argc = (long)*stack;
>>
>> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> 



