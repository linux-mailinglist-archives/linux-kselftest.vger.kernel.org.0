Return-Path: <linux-kselftest+bounces-12331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF891084E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388D81F21CE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74F1AF691;
	Thu, 20 Jun 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOjHCdDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FA26AE8;
	Thu, 20 Jun 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893804; cv=fail; b=KCs0iS9TfaNsQ0V+xRU1vBmltDF/QGr3tQTSvGWnZSPiBhqYb8rzDfZfqjOFuqvWFxKKx+XBZqMCdNCjNpPy/VPkDrbMAnWE8GMRNDTv0FkgCqFsdamcPiyPFFf7NupmZ+qY7i8vWHKIRdhMzD/Aky/eO7tG19U8vakEFcdY3R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893804; c=relaxed/simple;
	bh=1odzaZbm3XVpbfEUkn//WKhYJMVNTCIkvqIBIbBw8hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDnpQQvwPVSWrRD2/864FDZrzO2PkC2DbtDEuLe/wLsdPUGUrKMbKd4cREBc9O3i2boHaiXym3celvMz4sgk7KulfohAiyHvpCqaWqJutJeIwiKKPQBUgAvPgRoHHObWZtvekK7GRtWGEVAss+KS/AON9qnCSil2lm+3xi4aI8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOjHCdDE; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2KlWnT5oDvoCM8HiMyc4d2lnHgUNTuFRjO3P8Qyjk71ZOdj5sg9tutLg612V3ipytLWJEEwrE4nDwSKqz7gyPlT+H1M/CyDDzuznw9VeCdQWDGAsF6kBnaFsY0ZTaZcwIkNPJL+WCHTWMFaTKmfaspqrLGmdmCeZv3dEqw4rGgV+ppRL2er6iVql2YcDZDy9M/4qyB2iv1ocR7goJta8MOfoREhRcemUm2Uo3RvlTeGNhJjaosNyX2TSzhgYxPLv3Mgj16AsP6GYzUae1tWY19gM2uAhp2XJfzUvLkAkExt8wowVUAvTOK5VqBxzn3IxqBO/gX45MJaTyzp1AjuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIYjr4aY+TGuCVS2Cyhr6i2MlhIUms+LowtNz0CdtOE=;
 b=RWUGgj/88SR5fP+btez7SHbqzCmGPperOBGABCKlM/kK7p+zlCj5l0xp2J+EPQhPwDY/myZ6o0G/MhFXnm0JAz9VzEfBaHo8Y7XLt4hAvgqLnSnF6tZufhM25xDWy6EN/3pfgJzpYB1raf76H/m/6Dx/k+miujueJwOqJhh5jXqf05qy3UCR38f24mn+mZ4KHLAW/ZqbVP+Yx1Emedm90LiN3G7B5O0Q5ff0da8KuXNnxQfWc5SZ03R6cR/4C+oG+T3S/gG/XAOkzCiid1b+qiT1aX2Y2hQyumihb/uyIRdIA/Mky84E2URZiaMCMeypXhrXx/ktMbXzvycZ8NPlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIYjr4aY+TGuCVS2Cyhr6i2MlhIUms+LowtNz0CdtOE=;
 b=VOjHCdDEMOR6ft/TiHQ+0iDnUuevQnZMKio7THo/6FCZiho3EOVyy/wYHUFt4VVjtBSoCMrFZq3L7+i2jhjlX0ym3md6TVwYsKE0JAU6OB+5nFuBke1Clte8GCzksIPhTP8WmQwSES3eJ+K+V4X+nHZ+JmOvJAv3RkAuIXOTI6yRr9/e2YFPYycuh1AnErxPUEW1YiYE5xW4zyrzUOiTCXuHPPFg8pZFdWrWwVzkqR3XHk6X84nQv7J8HPVvuEmY6SRfnqhmQPbCfh+cZ60t2I8nPEFamJlBAlx1KAVnOm6wCMEcTB0CfrJdUEURuoQgAPP8ke/e9uIUVrbTw0mE2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 14:29:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 14:29:58 +0000
Date: Thu, 20 Jun 2024 11:29:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620142956.GI2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
X-ClientProxiedBy: BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 32feaccf-88dd-4401-f655-08dc913575e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUU2ZDZwSXlML3I1N2VsOGFSSWhSMW1kVmo2dDZMZ2hkb1BNTERlL3doemJl?=
 =?utf-8?B?cnZJbDF4NjR4SDgxNEdmbUxJRXBVYzlVOERKYUMrMU10RnlxYS9FRFBJUitt?=
 =?utf-8?B?Z2RENDdvbWQvN2xocFNsSkFnTlU1R2Y0Tyt1S2xqMVA1ZVZoZzRxOThmemV6?=
 =?utf-8?B?R0lYYUhQKytJL1NDSjBCZ0lKYlRPWTZldzBwcUh0MXljR05FQkJyaDBYRHpZ?=
 =?utf-8?B?N0dQYnd4NHZUbkludWcvTDIvVmliSEhBcVNTQkZ3RGtTc0NSNmtJOElpbGNJ?=
 =?utf-8?B?UXJGOGVmV2dUWWlMY1dWSzZldnFKR2F2WHZldUxUU3dQRnFqZFQrSXVwZWY0?=
 =?utf-8?B?NHRvR2VCOWJNVytvRXZ3Z3djMlp3MlFVQ3N6ZnhIUTNobFF4eUYwN2t3SWNm?=
 =?utf-8?B?cm9KQUNUQkE1ZHpEZGNvYmtlZCtYTWJOWlBsVGJpNU51Z2dsemp6MEZtQUFo?=
 =?utf-8?B?ejhNdlpCWXhDWE1sbUMvOXpyQUVPNmpubTRIK3lxYlBQM0xhWDhjeXhRY1Zu?=
 =?utf-8?B?Q0RSUlV1azNUUG9uVzdjQVZNSXczYjJPcmhzazF5SnR6dnhycGJya1ppbGxB?=
 =?utf-8?B?VUdSaGVnb3hicmxKNGYrNWpCSTkzKzNIalQyL1k3dkc0WlV0L1NzdkIvc1Ns?=
 =?utf-8?B?Y2p0ZHJyV25uc1A0dys3eEZYb2VkZFQ5d3VxN1JJbFdObVU4cEhIUWY2VEZL?=
 =?utf-8?B?MzJTZWxaclp1ZFFtTUdBQVg2T1ZSSlZOcmhqZnYwa3MwUm0xQTIzSXhhNUhB?=
 =?utf-8?B?WU1xT20zYjFuOTF6dnJ5U2FiQ25lbmFTTTRWeU9CMkZ3dzhKRTNkUXFBN01q?=
 =?utf-8?B?c1NPUGZ6NTdaYWFpUEJpMlY1QnUzcTBjdndWZ3p3NWh0MUFZYS9mNklTbmlD?=
 =?utf-8?B?cHIyTXZTOU9QTy9pSThEd0xKQlVRcUdXV05tekYxMzlMUDg1Q3N6RURJT1hj?=
 =?utf-8?B?RWdaNHhuaU5abDhOakpNM1hIVTVPWlVUVXhoSnNQc2NnK2txQk5SelhYNGRv?=
 =?utf-8?B?dFpZVmtNa0VhSEhJMnpLV2FtUDZYejNxbkdyMFhDT01pTUIvVmhmRmxiRWwv?=
 =?utf-8?B?QW1MZWZBdE1TWWlUaE1FYnQ0K0VESzBKcHBOMERlbnpockZRem8rWW1DYWNX?=
 =?utf-8?B?SFlJWElHTWhEYWJDTERqNkw0VGFJVHNMR1NGYW0zbHNSRTJoWnpsUXdrUlF3?=
 =?utf-8?B?ZHFWVElndnYvS0dPbEFnUWFMTFdjSXNkQklPNlZ6NUZ1VjV3RmRUNktFSDI1?=
 =?utf-8?B?UllCKzNianRMczlTQWpIbHR6a1JvT05SSllBSnRQZTBYMENML3Bwb3RvNVVh?=
 =?utf-8?B?cStsckUxUS9tM05mclZ6UmFtcFRCeVU4aGg3K0xqZGk3dFE0Zy93TDhlTktW?=
 =?utf-8?B?Y3puVmZVR25rT05vck0xWXRnY2lqeEMrbUtNeEluc2VGMGJXc2tuMElPYm1y?=
 =?utf-8?B?M1pOeXVxTzJyQkhLUEdJRkRRendZWDFGQnJ6czgzTnlLcklBSVNLMXM2OHFG?=
 =?utf-8?B?SnJPMk8rakl3Q0RRNjdTKzNyYUo3dTAyTWZkRURseGhOcW5EQ3FOaEdpMzR4?=
 =?utf-8?B?eHVzUHdrOTFaeVpiZnUvSXpvY0U0S3VKd3hZeFNodThmNXhLNUxneDFTUlB4?=
 =?utf-8?B?V0ZZNWFLdzJjdjZoWjJuZlJCQktneHVsZVBLOFpkQjA5ZlppKy9mZmR5OVVr?=
 =?utf-8?B?ejdyQWp0Y0dFcnlINFExZXZ3NDJWRzhMQythR1UwTEpjQWZUa05mdU9RTlk4?=
 =?utf-8?Q?c8LmuFghx+bculj8vVFJwG+T9tr81oLpaGOPf/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS9PZXdNUndCallIY0FyeFk0V2c5UGtZRHVwRHdrZGd6enBpeXE2T3Zxb1V3?=
 =?utf-8?B?NHhGNXZnWXlwNDBZL29DeHJ0YVNGNjQ3dm9kTy92MzJuNlB6NTA5QXVDRmlV?=
 =?utf-8?B?Tis1Q0VXdFhWV3F3aU5saFJ4L0JxekRYYzExZ0lLU2drakljblArVmZxRnFo?=
 =?utf-8?B?UXZDbmVyaU9IazErNXpQbnQ1aDNIeGNxRkxkWUwwV0x3L3ZSeVEwTW1lTlRi?=
 =?utf-8?B?RHlZakxPUFEwRGVBTWFuczlSUHBuaCtSSWY3YTJhMGpZVGhnaVU1UCtRN2ta?=
 =?utf-8?B?T0xuMi83TDF3bUdUWkpkSVI1b0VsTEJVT1VkVGdURUNOdDhFUkdZTjgvdUlU?=
 =?utf-8?B?aWdvSFdhQnlvOW8zU2RSUG44SHV3dG4wemRaSlVxNXpyV3A2SnR3MDRYTjI4?=
 =?utf-8?B?VktsdHMvaFRuMXZwTnhybExDYUFHK1o5dVV6WE93cDhnV2NWcUwxeGJhT0pv?=
 =?utf-8?B?TFVaa0xWQzd2M2N1S2V6L29LRnlyR0hTQThCSmxlVmNnZHJSRUFHbjBhY3hj?=
 =?utf-8?B?R0h0djlmRjlqYi9Eb2IyTnAyYmdhUS91RjVybkhmemRtODlKNkI2NDFwQ2c4?=
 =?utf-8?B?N0dWZGRwUDU2YmFMejVYeGNaY3BCU2lRNDFUL3NMYzByMEt6OFBhQVpLSWVk?=
 =?utf-8?B?UFFCUXlBNXY5OTNBU0ZuOHM1bFJseDBQSGkyM2RLZTdiV3B2cWtDalhaeFZj?=
 =?utf-8?B?Ykppd0szMFJZZ1JMcnl6MlZHUUIydzQ3dEtlRk4xbnVVMVdlTjl2cUpLbHQ3?=
 =?utf-8?B?YzZNazFMVXlSOFlNVUFZVUFxdlp3SDdkYlE1bkJuVlk1ZkZOSGd4RFo3aHFZ?=
 =?utf-8?B?Um1lN0Q4OG12akQ1TVc0aDhKRDJBRGZpNDNyd2kvTHI4YUZMOEtEeUVmcndZ?=
 =?utf-8?B?aG5XTHkwZHF6RzEwUkNvdUVMZ2k3dHhmM3lJcnNtR0d0bEVNRHZVYzFLN2JD?=
 =?utf-8?B?UEhuS25BektOdXRLcE4xai8rSVpTWmFNUFhoaTNqTmt0YjBBa0taMTVuU29k?=
 =?utf-8?B?d05PaFBPYXVwVmdrWElWUTAwVnBOSDFQdThuSlBPTVJ1VzRaT2RUdTloVVJR?=
 =?utf-8?B?TlBBTWFrRGJqdnpNaThIdTF6Zy96ZGZ2eDVWam1BNTBCUVFKUkYrMG9tQ3RV?=
 =?utf-8?B?Zitoc0VpQUUxN3pFQ005UElhMDhOV3g2VzBieG1BTUdLT1RrU1NFbkJCbVZk?=
 =?utf-8?B?aDQvRFhmdXpBdm9YRFBwQkNqTlkyZC9Na21jUWV5R2pzWWRJWEpaSlNSQjRG?=
 =?utf-8?B?d0xZWFRkUjMvQzhoZjNkTEdhOVVFdUpmRm1PTGxKRUswRlJxRm52U3Q5cXBt?=
 =?utf-8?B?OHhna0V2bUhaK2VEQkVtT295QVlSd01RQTI0SHhSTWIybnlUckF1OWJFNG5p?=
 =?utf-8?B?SWpvTUsyQkZxTFFsWkFpc3E3enpVNjk4cXZLbG00THJwTVBDUXZtUWZxWVRs?=
 =?utf-8?B?Y1NNdk4zSWhZaGNBcG9KYnRITkRYcDdDZnVxejE5TUZ5WGlyWm4wbW9iTCtZ?=
 =?utf-8?B?RkVvS2VwL0pDOHQyQkhnMjBISys5aDBlWGV3aVFHYW9WRS9QVUFsaEh6eHlT?=
 =?utf-8?B?TTUzbHFkbkZ2bDA5YTE5RVpTekhuT1lWSTYvc21ZUFF0ckg2RUN5b053VzZD?=
 =?utf-8?B?NTR1OGtYQlAydUI4aUhxTFlnYTQ2M01pWTJnTS9nWS93YTBLWTlHK1d1amxj?=
 =?utf-8?B?QkRCd2tvaFBiVERpb1lCVTRwMTA4YTl3TFhmZ0ZsakhnK3o1dmFYUUxhZ1dB?=
 =?utf-8?B?KzgwaWNIU0pEZGQ5djJXNWpqTk9JdXpxdjFIR1JXdFN1UHBtcXF3Q2FXRnZN?=
 =?utf-8?B?M21SczRmLzFJSlo1TDRPYUprR0ZwYXY1RUZoY3ozbUtyWTl2R21NcnJPNnFX?=
 =?utf-8?B?SDZpRzBCS0NiR3R1UmxDZDMxemVmNUZTVjdMa2FwbCsxOG0xc0NOSXVBTHRq?=
 =?utf-8?B?UlFiYVhSV3VsSzZiYmdXRHBOQjRSdmRkc0FOUE92emZOK2x0QVpHbHlnVU9L?=
 =?utf-8?B?N1pCQ3RFb3FhQjZNWHphRFBScWVsQ0UwdTNlSE5EU2VKNVY1OWVYazJxZEpq?=
 =?utf-8?B?Vk9odWNmc2ZmTFVhQWJacFBoS2JIN2JEd0p5Z1NFUWNMTFB3SThyZUhaOUJv?=
 =?utf-8?Q?E0HhY9UUkaf0FlJdtNoohdNNL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32feaccf-88dd-4401-f655-08dc913575e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:29:57.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFOC5SdnixPS2cccvF0cC0mvd9gMSgsvJrBd6zlBx6alLwpyEFH7G5+2eK6VUYm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
> On 20.06.24 15:55, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2024 at 09:32:11AM +0100, Fuad Tabba wrote:
> > > Hi,
> > > 
> > > On Thu, Jun 20, 2024 at 5:11 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > 
> > > > On Wed, Jun 19, 2024 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> > > > > If you can't agree with the guest_memfd people on how to get there
> > > > > then maybe you need a guest_memfd2 for this slightly different special
> > > > > stuff instead of intruding on the core mm so much. (though that would
> > > > > be sad)
> > > > 
> > > > Or we're just not going to support it at all.  It's not like supporting
> > > > this weird usage model is a must-have for Linux to start with.
> > > 
> > > Sorry, but could you please clarify to me what usage model you're
> > > referring to exactly, and why you think it's weird? It's just that we
> > > have covered a few things in this thread, and to me it's not clear if
> > > you're referring to protected VMs sharing memory, or being able to
> > > (conditionally) map a VM's memory that's backed by guest_memfd(), or
> > > if it's the Exclusive pin.
> > 
> > Personally I think mapping memory under guest_memfd is pretty weird.
> > 
> > I don't really understand why you end up with something different than
> > normal CC. Normal CC has memory that the VMM can access and memory it
> > cannot access. guest_memory is supposed to hold the memory the VMM cannot
> > reach, right?
> > 
> > So how does normal CC handle memory switching between private and
> > shared and why doesn't that work for pKVM? I think the normal CC path
> > effectively discards the memory content on these switches and is
> > slow. Are you trying to make the switch content preserving and faster?
> > 
> > If yes, why? What is wrong with the normal CC model of slow and
> > non-preserving shared memory?
> 
> I'll leave the !huge page part to Fuad.
> 
> Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
> now the VM requests to make one subpage private. 

I think the general CC model has the shared/private setup earlier on
the VM lifecycle with large runs of contiguous pages. It would only
become a problem if you intend to to high rate fine granual
shared/private switching. Which is why I am asking what the actual
"why" is here.

> How to handle that without eventually running into a double
> memory-allocation? (in the worst case, allocating a 1GiB huge page
> for shared and for private memory).

I expect you'd take the linear range of 1G of PFNs and fragment it
into three ranges private/shared/private that span the same 1G.

When you construct a page table (ie a S2) that holds these three
ranges and has permission to access all the memory you want the page
table to automatically join them back together into 1GB entry.

When you construct a page table that has only access to the shared,
then you'd only install the shared hole at its natural best size.

So, I think there are two challenges - how to build an allocator and
uAPI to manage this sort of stuff so you can keep track of any
fractured pfns and ensure things remain in physical order.

Then how to re-consolidate this for the KVM side of the world.

guest_memfd, or something like it, is just really a good answer. You
have it obtain the huge folio, and keep track on its own which sub
pages can be mapped to a VMA because they are shared. KVM will obtain
the PFNs directly from the fd and KVM will not see the shared
holes. This means your S2's can be trivially constructed correctly.

No need to double allocate..

I'm kind of surprised the CC folks don't want the same thing for
exactly the same reason. It is much easier to recover the huge
mappings for the S2 in the presence of shared holes if you track it
this way. Even CC will have this problem, to some degree, too.

> In the world of RT, you want your VM to be consistently backed by
> huge/gigantic mappings, not some weird mixture -- so I've been told by our
> RT team.

Yes, even outside RT, if you want good IO performance in DMA you must
also have high IOTLB hit rates too, especially with nesting.

Jason

