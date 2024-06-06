Return-Path: <linux-kselftest+bounces-11295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E88FF085
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5E528E933
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172A19750F;
	Thu,  6 Jun 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZnUQpUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E611D688;
	Thu,  6 Jun 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687164; cv=fail; b=DIAGmrPPRYKM1Tz1qoTHZv3zckBwwFkj8by6AH2EX4mTC5prjLVnLHI/6DBo+JmWj29wM4rAA1lAbGKOajgiT3fl0/Mvd08hjRNMVG6EQ9PPLbe3gjnCkkjviOAf8ArSaxSvRM0Q5CP5MXet9wpV2BEG9oTdi9n3uUF89aPlbz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687164; c=relaxed/simple;
	bh=vPsNTSBx+CRCjoeEqm1WspgsHQfoyQAlTrxX6St6knc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVyKBMI/4/4yX33gmnNxquowo/17/sd7MDn4GY9BmjgTjaiTuO8Tp9RCCkVyIZnkLbuogr/jZXfjWSHIEyGEWfynhg3+dkwGUISk5Iha35fEEJo97nk48WMcYsZhqFyOM06UUgbe9V/uKNIa4Q6YCSsf9/0VC3tH2DD625e9E9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZnUQpUu; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH0tgud7Q5eH4H0BDpWJuktOc7VVTEF15Vr0kQVr0Ck6ET3UCCN6t/i1wlzOPKv+aFuu5U/LVB6vqeSsRd4zXXxSyBJYaL3RKrJzy6dXbPmPMohDsthujjJ4ltt3ChhaZZ3Xe+J1gvKoWVlDRXkYGButB5Rg56fonQxv7uYG9Y7DJbSstBiyHzc4SL9FNNx9R3xSEvfzvD9XvqYRvefpjX0WIyH515OOQrV8IlMDqGEVbC+afM4V8zi+OMCtBXsNXtdcPr0ZZEY7LZjp+Ths/p0h+YlkJx5AUsWQpOk4gpoCuxXIs7noEVTcoK8Up/KI41D8JCh5i6QgXrnIJIT/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njK3f/cvTGx0QxR8fswxseRvAiIBxhcfL7GWdiBr368=;
 b=cxSS8zEdnATUgQ+BRICFJHEUTymRircOrWy7rzwoDDCtSzMSyPAvI5arw34aGqcWabswmQpoCVL8S55Mra02JARO9iwDT5izLVLD/RvCCOoIZivh/KT5qia5MlJ/KWxCljDaoVdBhJ9fHA7mRZ4UVjZnObvYns8PYar4jQc0xfPWW+2d/Ohaiw0AQ8VsJQklZmAQ5tbtFHSfUK2oA0DPXiImL+U66qc7GXKzxZhgSViK4zhh9EEDO4SGSkm2HVKXlOAUZ1Hfq7PQbk7aQvhDxtYMErB+uLvYFgDMfr/ngr87tVFqiN30rSw9hsVgG7/ebbogUrdpYpMVjkdD9jPaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njK3f/cvTGx0QxR8fswxseRvAiIBxhcfL7GWdiBr368=;
 b=oZnUQpUumukBP6anlcxG40BIftPk9GlNymCkq22Z7dqU2OVWPrvxGUjaqnIO5QDVWrmqzArusDegUAZJ1+Y/5lkyxCmRDG60LVaQZnEqzJpGV7c8/OqZyFPLTmddIQVnm70uy6dg3g8oXLQfVfnWdlI7hyaZcJ84CB+DNwaO/rzQaC31Ezu7hycIFLHsN11/b/hunOEcd8Adx5gRiQOeJ7CkcH78aR9pMinS3j5DCdtYVlW0vUmUVzokXxiy/GYqhtUNOtucyYqZ3Vp5iCt1Wc6/7N2xSy9B0JR1X1dtoRuBFrrIEzQpwahaXfljpk/OlimYO8sVHrW0hEwnRtwWnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 15:19:19 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 15:19:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
 mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
Date: Thu, 06 Jun 2024 08:19:15 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <4821478C-1B80-4229-9C14-47DDB6BBC823@nvidia.com>
In-Reply-To: <ZmHJMyo37QdtTWee@casper.infradead.org>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
 <ZmHJMyo37QdtTWee@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_5634B141-D808-4ACD-A931-0E5C48B7F427_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: debf8d9c-e628-4320-48d7-08dc863c0987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXZtbUNpMlRrdWkrSTk5R2RpdWtNOS9XZy9RNnVvbmxrVysrL3o3OHZmRHBL?=
 =?utf-8?B?eitYaTE1VDIxT3Y5OXhWWExEVk9RM3lwK2ZYUWNlSHVvME9wNVVGRG14ejVV?=
 =?utf-8?B?RWxoenlpakY2Nkt5NjNsbGhLVytqa3gwVzFDeGhsVWlVN09wOVJNZVA1bXE5?=
 =?utf-8?B?RlMrT0x6THVwS1BSaUxvMWwyWnNpYkFkSlRGaktKY1k5SjA4Z1lKY0lwUkdC?=
 =?utf-8?B?cUJwdmdQaVY5OU0yc2p6RmxscGRYZW9sYTA0bFM1ckdWZVJPNENFcDlQbmo2?=
 =?utf-8?B?RDlKam54WCtnUEJWLzN1VnROQ2RVNHJGMURHS044STVSOFVwV2h6bHh5QW5R?=
 =?utf-8?B?MmF5SjlmU0dDalVTU2gvZ3plMHREZ0FFdkhFSW5IbEZacXdSN0s1cGNRZ3Ar?=
 =?utf-8?B?NmZJMHFUM2lPMHhoOURLVCtZTkZvVWkvSUx3MzRUR3M2YWdrdU56eVM3MFZI?=
 =?utf-8?B?TmVYMlJ6Q2JybkJqTzFkNFdXZXpFR25LUC9SUDRET1BPbUhZbHJyUmZQMCth?=
 =?utf-8?B?NTExTitJcS9PbWZ4WFVpYjNISVowZ3NPWmk1WVpmOEQ1S1JDUGhnTWgyWkFS?=
 =?utf-8?B?dnozNTlPY01lQTRVUHpyVDU4YXM5V1FJeXRIclBTU1I1KzkrZGRsdGtsaDFs?=
 =?utf-8?B?aDNvMDBkYU9ZT3JUWGhnZlhRZEozM0ZtbnI1QXJmUUVlN2xHYlBRL3dFZ1Zr?=
 =?utf-8?B?a1E4L3pQa2pWVzh0eEQwYVcrK2I0c0tNUVRPRkhhRTlEOXA4dWNqSjNzWWRu?=
 =?utf-8?B?VGJHcEN1alBnY3VBZldoL3ptZ0ZkRVNLdGRVK24wUlJYK2J6S3QybnV3cm4y?=
 =?utf-8?B?VGh4ZnNJUXd0S1FnY2k2N21MSFJsZ0FEVDQzWTQ5M0MxQVhhMUFubXVpU3pC?=
 =?utf-8?B?ekNzVitZRDdCeUk5NFJBUmhZNkpPc0lLMTlZS1hDK0hybnVoMndyeEljVlp0?=
 =?utf-8?B?UkhSVTkyZUxiTk9GT1VWYk9lcGRPeVU4b1M0bzdVMzY5dmozejE5STk5VU9J?=
 =?utf-8?B?dUpqQ0kyeHQzMVl3NkJ6L1l5dEFBRjhDZXd0bmpOb05hVzVGNkZ2NmxQTDJW?=
 =?utf-8?B?MExDbDMxZEZid04rbDR6SWJFSkxZNSt0Q3hnZ2ZhTEhmTFJVMXAwaHg3QVFv?=
 =?utf-8?B?VU00RUE3ODB1YTYxOUx5M09rU0UxZlNpRklyaEhUdDQ2QjV3N1Q0dWN5K0g2?=
 =?utf-8?B?N2h0cXdtcFBSd3lUcS9ZMklHMG1rVVd0Z3VaN0doQmZDUUpkR0NET2NxaGZG?=
 =?utf-8?B?bHFzRHR1ZE1yTElCYk15UzlwbzZMVVVJMDIrNjljMG5TZDlGUGdNMU9hMk52?=
 =?utf-8?B?MFFuY3hsWFM2Y3FpdnZRek5OanNmVWw2N3did1NQaUh3KzN0eDB2YkwzZ0JT?=
 =?utf-8?B?RkhxTkFyVW9ybjFHU2RkRk1KL3hMWmZodjdaWUFqcDdvYm9rRnlrb0xLYTRP?=
 =?utf-8?B?ODRDWnVXVHovNHlrSXZQK1RXdWcyK2tBbjFSTWpXazU3WGt2Si9kVWNEREVi?=
 =?utf-8?B?dUlYVkdrZnZtZ0NrRjhhZEEvMDBvM2VCSU96RGErMnowczVKR1VMQmZ1OXps?=
 =?utf-8?B?WVJiY2Z4NGM2UWxHZXNOVHJIYXNHcGxkTjdweHVDUUFxVzRQdFEwVVNES1hL?=
 =?utf-8?B?a3lLQlAzZzJ6QlQzUXpBVXB5MUtLT3lzMUlwYUtpNWlTWmswLy9uR0g0YWNH?=
 =?utf-8?B?MHhod1hrZ3MvdFZuZitkRDFzVE5nbS94ZmlRbzRtdnBwNUlSNDJQTFFhalZr?=
 =?utf-8?Q?flTu8znlNNSMqiF5M0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJVYkdqVURQT1hOMkpJWWJCd2FGYVZrK2lYNUl3VHA3WDFTMG8xRmZUM1pN?=
 =?utf-8?B?bFM3VVZ3QjhLaWV4ZzhNUjA0Ri9sdGtWWStkclhmUlFPQWYxMlFOSWNNcmtp?=
 =?utf-8?B?RE5OZ21QWFJFM0VGVXJ1NG8zd2FqdldGd2RZNUNmaFlKTU94VGZwK3AzZElw?=
 =?utf-8?B?d0ljRUtBOUplOFowdHY4YnN4OU8vRXhmNko1QkplNUZFZmFkRlZDK2xnekJM?=
 =?utf-8?B?MHdnLzZlTmJpZElHMklPZUpBVEdqN1dFZnZHQk5EdjZaNmF5cDNzcmRXT2Fa?=
 =?utf-8?B?YkoyQ1Q2UXBYQ0JieElxZFZzbXdyUXNyd0t2U2cvcFdPSVN5ZTV0dEF3dThC?=
 =?utf-8?B?a09YTXk5R01xSHFoaUF1L2RhOGRGaE80dlAwVHFGdU1IQ3ZFWEk1UWNpYkdN?=
 =?utf-8?B?bVE5aHkwZWxNWFZneit5aXZaeVZnS1RvaWtEVmVYT3J6aXJ5a2RVS3hYaWtX?=
 =?utf-8?B?UVJDYlg5d3l6T0R0SFlCNi8xK1ltY01TZjlOVzJQYjYwNy80OEE4dmVsL1oy?=
 =?utf-8?B?T2VRQkVqMzV5K01BVC9Bd0pqV2FIK1d0QWRpTkxmdlQxc2ZGOWJsU2NxRFN5?=
 =?utf-8?B?NnhQdS9xWFpmajVZVEIvWjFQenVLQWZaUUM4dnRLQ3lidzM4YXFkZFJKR2pF?=
 =?utf-8?B?YnVudWNkMGlyMFZqK1RhNTYrU0NkMU9JVXZjWitFNzcvSG1rTVNpU0lLNjF6?=
 =?utf-8?B?Z2ozSnU4Z1pvdWwySVFhVENCQVJJd08yTldaamlwZC9YOGpZdFZ0NytpdDU4?=
 =?utf-8?B?OHRQZ2g3Ry9XNnMwQmJWMjl3UW1BZHFHYlBRc21rbEU2Zk1yRloyTzM1U05s?=
 =?utf-8?B?M05aQXROMVhoTE9MaW53YzU0MktNNzFsOXNwQVlhTVBuWkJCSTNTQWc2cjdj?=
 =?utf-8?B?ZDJ1MWlmUTJUc0tQNnhPSHY2aVdmcXY3WlhNY2MrNHFMM2luRm5JMlZBbyti?=
 =?utf-8?B?ZWN0dEJac2kxNjVZTExPNEpraVdZbVZVczRhQjNTOHk3Z1UvZjFOZ0RsRzNy?=
 =?utf-8?B?RlRaamZMVFhRVXRGc3FIcUxYaDFmaG02R2ZVQWtsUGJoM2JuVUFQOW93VjJF?=
 =?utf-8?B?MmF5QWhPNWk3WWNOdlNmRUtTMzUwRisxSzZKWllmM2h2YWdPNkpubkN3MVdr?=
 =?utf-8?B?SzZxZUpWcTAxV3J4TncxNUI5Z0hYRStNUlMxYm1QTW1lZXNuM00vMnBXOXo2?=
 =?utf-8?B?VTRQampWVlQxV2wvcDRGRWlvejZvZzg0dkhzcGMyd0JwTlVhakZlZHFrQ0JW?=
 =?utf-8?B?S05Gbi9nTk81WXpIU0ZTaHE3N3IxYWgxQlhvd2pJSlNBbktsSExKdTR4OWpK?=
 =?utf-8?B?OFNRYnJOb1JheFA4cVY4Y2RSNXI1b1VJMm5tL0hDYVZWdlFMVUhoOEpTMHVR?=
 =?utf-8?B?Y2hEdytZMWpSNFIzMTBKSmxPQXZSVjBmVVFzdTJtTzhESEpXUjNOQkFiZEkv?=
 =?utf-8?B?UjMydGhkNTI3d09pcWJZTGhHVmdma0V6QlYzaklpaTgzWVFwWFF1dnBKVTcv?=
 =?utf-8?B?d0xZUmRpR1E4S1lCajNhd3lzOERiak1FOE9sMmRJV29ud3lUVjhNMWRUZzNz?=
 =?utf-8?B?NWtCSCtqVUJyRnpSRVkzb0prdk9ITWFFUng3Zk5tcFFTKzhGRjZiQlpoS2Rh?=
 =?utf-8?B?MHhWMVFLSXNXRXBmVC8zRG9hdldhK3dNNjJ5c1ZvKzd6ZmFkNjVWK1FlVzJi?=
 =?utf-8?B?Z0JYM2ozbCsvZmtmcHZEOWUvb2tnbGphTHFnaklrU09qdU5wSTVLdGV5NE14?=
 =?utf-8?B?SWVUdUVMZksyK1lYbVQ0Si9WMXNMNHc2d1diemhmeWQvTXlGeWZMTEZacHYy?=
 =?utf-8?B?bUFvdU1jYWM2MkVyRW1rbTdlUmxnU1J5Q0FiaDJSUXp6eHNRUU1JTC9CQktB?=
 =?utf-8?B?MFByM0srM0I2ZGNSZzRkTkhCdU9Vais4dlludXBjQzV1SGNwY3E1ckdsVk1B?=
 =?utf-8?B?bit4NnRwSXh0bWpZWGZrbDdXeWRIMWhXV0V4YVk1REhCVkRmankrMjgyOVR1?=
 =?utf-8?B?aFo5azFqMmRid3A5ZllmY05VZHNiSXhtSWlidTloQWExakFlZ3ozb2NhK00r?=
 =?utf-8?B?UmczTjJMNlppSkxpWlMzOXU2RFZiNnA4aG5XRXdPTXJrK3Fmelg1QnBZUXh0?=
 =?utf-8?Q?tY8g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debf8d9c-e628-4320-48d7-08dc863c0987
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:19:19.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XExIQjJ5RpMxnh6JyiPWBiqw0/1ZIZywCtMPloQ+qR+jUbuzOreBJCyoRxiwQ5qs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

--=_MailMate_5634B141-D808-4ACD-A931-0E5C48B7F427_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Jun 2024, at 7:35, Matthew Wilcox wrote:

> On Thu, Jun 06, 2024 at 01:58:35PM +0000, Pankaj Raghav (Samsung) wrote=
:
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfi=
le, size_t fd_size, int *fd,
>>  		char **addr)
>>  {
>>  	size_t i;
>> -	int __attribute__((unused)) dummy =3D 0;
>> +	volatile int __attribute__((unused)) dummy =3D 0;
>
> The mistake made by whoever wrote this test was making 'dummy' a stack

That was me. :(

> variable.  That lets the compiler figure out that it's unused.  If you
> make it a top-level variable (not static) so the compiler can't tell
> whether it's referenced by a different compilation unit, it can't make
> that deduction.  And you don't need the stupid attibute or volatile on =
it.

It is better to just move =E2=80=9Cdummy=E2=80=9D like you suggested inst=
ead of adding more
keywords to fix it.

-
Best Regards,
Yan, Zi
--=_MailMate_5634B141-D808-4ACD-A931-0E5C48B7F427_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZh03MPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKmgMQAIn7gOvl6o9OPu/3Afyon/ao1gQUrZbrXRpO
TMnNsKI7GxNBgTQ3sx54DGRBOARi5W1RFdJxY1psQfO+0wZ5+SP6fnypwubEJfwi
HJAjwk/vZFwtra4sHaOiv5Ir6LMMgrciiwHJYmaAPwa7Gk5lOW4nIFA5Fy4RMZor
0vFsq/Siu2DJloh+uRxDmNosJy/go2KRGZRubiTzDwpF3q3qmKrUgiohVFYQVjPK
DSUGHQZ7Ky2XzbrYRz89uLFLvy+E2X4U7AvgdE6cfPhjfozdkr3bQAicG+Jl/BDD
hfzmT2GOTwQHgBW3d9jVnFphMxaq4j7yEWdE+VY3oq/TQrUkYSD+aNXdBzQ5s7Ff
8f/5PIl50MVrfeaEOG+//fe192SXBUvH6sfV5tIXqEOd4JY+8q4fS9umqPqfojZ6
puSTnHawC77dgV7DWi4b+ZDwDVviwmmS4b0utlcEjPu0Ium+6GaltQYCUxwxivyD
falHMetTu3LHdnpVa2Wn0/xDstuaqAoqQa5yhUeYnHa7XfDvS3Smqb2qwAsWiZmb
fGPIDkrqSAdmfxp+W2xnbRd7gbMgaF/2bhXS+0c+rIuYe5b5rt4eIlgaV519Wo5H
f2436k9QUMI9jeFG16zhpJyKS7ErRS9+ZjTpoZW1wfSj8ihVXCvgOrPHtnF9OHUX
3DP24VJY
=2dvt
-----END PGP SIGNATURE-----

--=_MailMate_5634B141-D808-4ACD-A931-0E5C48B7F427_=--

