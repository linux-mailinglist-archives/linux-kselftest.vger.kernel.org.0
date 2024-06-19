Return-Path: <linux-kselftest+bounces-12246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B3F90EB4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1241C21907
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E214372D;
	Wed, 19 Jun 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HS7n0L+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23481422A2;
	Wed, 19 Jun 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800932; cv=fail; b=TyWDMY1lswhuLrv/ykeuHueB1ztUJ7BWAyRRORBHdiFCE+Hy18WXew6LCn/DV+NzbVyPVg9bQ67J0H2dRbm2JVvHv/lsZgYUi81XwP6PaFCHer7qIcrS+cZ+YyIW/4ynnG1emPLb2JoiyIzWNGOPxAHCVNEKZGnlgrQwPjtn1Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800932; c=relaxed/simple;
	bh=xHNzaWk3/TQJbMsVkZ8qfL+wEK4QI7FGIUHUhPWhSIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFJ4Yn5+MWK+XZhKFAUzZlBepwtC6+K6iqaWs4bUdJxCzcFJL0u4JEPfwDkJqU8Qc9JNg35r3vbt9/RLw6dlEftVQYg15c8lHwyeaVVZwEMXs9dYRZtEQ+RlAIQivKsu65nnxW6XaYI0tRHiTcc9ZsodObkfG60/Bd4QBkgxsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HS7n0L+0; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0eACu+Xxg1oQge+G01YEVWvxu+aQfq7cqHdAzR08aSUhasW188AAYxX9am4YP0VTndvePEA1s6bnFmXjP1y8SOFTMKrMmo1i1T3v95Uf8ayBN5MXniOAhQf1jFNnm2269ETnubXhxKe+WAV53zlWJRVlHOn96pkfGL/LqwhZc79YcBvkseFlEIfjdaWwv18mKqLKC7Ju2SlzDXvE2mJcHSrBp/2UniYaBPcLfmgV5j2lY1xrgsYbQ1hNiFY8+lFRwA83I59JKLEmWjDGyTFHBTP9hFWqDf78pH1fc2nhHfAJQjlnwkvg2MqxuIX1DEnR6YI0c+oSwl27yEQx7j2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gongxciwdsn5xlATE2Lvvz4wGEwytPkuU79L4gv1mPI=;
 b=oErVUv6SxAm0ppr01YISQTNpD43O2I//3S0mY1qI4KVA8bnPozYrSQYQavGn09od7efxUf3kEWSZettuiEtNNlWwU7qJnRUX+M58A6l6j9BD4VgvuDTxTumo3Httsduj67+jAANMoku6VruLkZ3ewpNtocS1IONUqPjLddBRZ0zI1kluqeqw053kaL32w3z7p+8zqmDQW7pBSgEOUp/wI/UR/BY45zt6bmHkU3fdrHTYiI4iPKC8Eij2SKANTyvNOln8NpWwCtXIrNEU6jQDTjCU318eR+8CJDq432fGSgGNcF/ZZeiE0BAJ1GEM/dEFE/4w7CXVEflV3PFf5Wndaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gongxciwdsn5xlATE2Lvvz4wGEwytPkuU79L4gv1mPI=;
 b=HS7n0L+0XHhSoA6Pi5pVIljLBbTmTJ4jJd4YPMpgNnCT+tClQh9ewXFit6wobagehU+14Bw6dhRN9oaJEILxYbeVEJppwECr04FQ8+FBE/nz07OzNnwSbipeBqpWC95NX+fvkZs4R82O2C9SK2cjkf+YTvugRMAApNCh37cVO99o2cXfsKi17CcQTW8fnQzb2c38zPt1mMnd1e/qFcSpr5xt0px173bOR3rcgtG/Lnnd0nAL4wUrTza0dbiuYWqpENsofHZiwv6gLIUlxe7/DdRVUmfmrTNTtIGPnndPoHYDCBRZ/Q8kgfOMo7ki0TCZ4cuQQhZBnYaHXs9bTFGe9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 12:42:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 12:42:06 +0000
Date: Wed, 19 Jun 2024 09:42:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Fuad Tabba <tabba@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240619124205.GF2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:208:e8::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 65875458-f3d6-4319-4fc7-08dc905d3a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlNQdFZMYnJLM3p3VzAxQXN6NlBuTjl3WFBjeWNrMkhNZldXd3JOcGIxZnF6?=
 =?utf-8?B?bmY4UjZaUzR1TjhpODcwWGNMeXFCRVA3SVcvRy96MUNHTHY0RHIwSEp2eWxM?=
 =?utf-8?B?WjVVNFFnY3hYMEIyU3FLYlpMZkdweCtsYUJjUVNPeUNPbER4NGpnZWZQSDQv?=
 =?utf-8?B?KzcvdVcyT3hoNjRiSG1aYm9SajhpM2JUZktCc2wwQ3pQTVd5ZmZmekxObTBu?=
 =?utf-8?B?Q01TWWZDd2FrUS9pQ2hVSkZsUVJBVUtxMmhVSS9oamxnSjFvbStMZFozRTJE?=
 =?utf-8?B?OWJEaWVIMkFTL29FNHRiem1WNmNaSDFoSnFKbklVR09XTWhaWktYaXZXMDVF?=
 =?utf-8?B?TjJRTnZNOE51Qk5uS3Z4V0JCUTlIUS9xNWttN3hHZ1dWd2krNXNCb1V6WUJi?=
 =?utf-8?B?eStrSVFkWnduTXdkWWNLM2hjdUI4SytSZ2xwTGRsc0oyS2UrZDQ4d1I1Y2My?=
 =?utf-8?B?dkVKbVE5bFJRbXhLa21JdVR1WXQxczQzZXRZSnFNenp2d0JwRDFOSWZ3SjJN?=
 =?utf-8?B?L3BnUnFPdU1ZbHQwMW9WdWxEWHpIYW9oVzBYZ2gzeEJRSzhTaDJOMzByMzBj?=
 =?utf-8?B?QTNZQWJudnNLblRtV1BTdjc0WlRhcjU1VlU5QWFERERpMDVTQ0MvMkRtTmU1?=
 =?utf-8?B?THovZjVJQ3Y3NlRGdGlEako3VmNSWVhLZDU0T2FneW5rMGpPMzUvaGpYcURI?=
 =?utf-8?B?L2lQOU52ZlJ4YjJFTlNyTmFxcDNvQndjNVQ1RU00NjYybkgyMXFyK3pjcGpG?=
 =?utf-8?B?TldyekJoQVBKMmxuRW1lOWNLNmdIelBLRXEyT21NM3NocTdiekxWUGJNQXVl?=
 =?utf-8?B?MXRpZXlCa3NRb0RmV2lwRGdIL0lUc3MxakhMV3J2YjhXV1BETjZvbG40QlZw?=
 =?utf-8?B?R3A1dGUweHZaeWxrbGxjaXdSem9aNHgvNHNsZ1dpKytUOTBWaVZjNkd6QTIz?=
 =?utf-8?B?STNCMmx0a0pwc1JZUFJ5bTd4SGtWUi9uRmpvUUs0d2VzMkxucG4zUXhaSDZw?=
 =?utf-8?B?YWFiTUpPUnhoWTUwMURKWUVpU2Fyc1NlcHdEQ2ZiS1FUWFE1dWErckw1OHZ5?=
 =?utf-8?B?QWJiV01LeHByMG8vQ2VkQTZNcXhmMEMrWmpZNGppZWVtamp1U3NVTFJ2WTFV?=
 =?utf-8?B?NW4rendWM2hBbStkM3JHMk4vWWxJYnVjUzBLMjlORzI3QmR0Mnhuc3dnRjh0?=
 =?utf-8?B?Z3VpWjJYb2lJejdxV1YvOWVEU3BNUEhCcDdEVEhZaU96MVdmZXYzeFBvRW4y?=
 =?utf-8?B?VjM5ZlJtcHJiajdJVm5iS3A0NDZmbHFnclVxaVJ2Y1JadG54Y2lOZWxHNUpH?=
 =?utf-8?B?b0xXZDA2SHBONm9jN1N6WGM2Y0tBRGlXVFU1ak5aYUpyNXZSeEdVYnYwczFz?=
 =?utf-8?B?WkgvZGxQdFNBVDgvaEgrZW1SMGhQcnNWdDRHRnFzUmcvOUFVdjRCOTMyU092?=
 =?utf-8?B?ZHJXa3VwWU5qeVFzTEdJc25sK0NXRGpoSHFLdElYd2F4S0pGYmRNZGtwTi9h?=
 =?utf-8?B?Z3hiWWQxTDlKZDR2d2RoWVkyRWlreXAyR3cwaUlSd054VUVkaHFrdWE0QUhV?=
 =?utf-8?B?eWZzNGxjSkllRTNTaDVRYXFPUkFUOVAxTTBrNDlBeWttbEp6OUQrR3JXU0FV?=
 =?utf-8?B?RkU4MmVLaFdlQ0ROdTdaMXU4Nm5lWElZVWE4ZmlVKzBraGlxT3VXQW1HLzlp?=
 =?utf-8?B?QTFUVkZZb1BMMnBhZUtCem5ZWHVCRlZ1RU5LQWtScGhhRzRIajhjTmNSZGJY?=
 =?utf-8?Q?N/qgJGQXPA52JY6RyUSDaPBbv8W17KE7ryzlJfL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mlg3M2I0L3lqTlBGYjAzTDRGdnZDbjRuN205WUh2bGtWVDFwSjNzeERuZmsy?=
 =?utf-8?B?a1phUDh0YXBKL05yMnYvTVpZbzV2Z0IwQzlJYlhYRDdzenNoQnNtOHg5YW8x?=
 =?utf-8?B?Mi8yaW9OWElhamVvazRTcFVWQnloUmdLQUl3MlpSR2tSK1grM1JtQ3JoMHU2?=
 =?utf-8?B?alBWSzBXODJkM2EzRDF4NGpaK255Y3ZkUkZFeHljcGJGRUp1TVZ0Qmt1YnFt?=
 =?utf-8?B?ejYwNFBkd3NrVDJlWTYxeWFDS0pPODd5VVZiS0NITWZsdmUrN1ZSb3gwS0lK?=
 =?utf-8?B?RGVrL0ExQlF3UVJmcDhNWmxnSUFVQkdUY1ZNU3hLOVh6RHpRTzE2eTRldHpM?=
 =?utf-8?B?UWVWWXJmcENNNzN4QTFCYmJXNUMyV2UwOVU5S2JhU1A3eGIxUmlHa3hNQzYx?=
 =?utf-8?B?WXB4YmlpeENiWlVLNGd3dWRURFhXTEErMVpFMW8yWVpjMDN0MzdsMVJtZzZX?=
 =?utf-8?B?Rm1NSmZtWEJiOEpiNlR5WmNEdkNkczhGOU1LS2RpOWJFUytjaTlFU0laMHBN?=
 =?utf-8?B?K3pVU0dnbEF0b0kzOEpMMmJ5Uk9ORFRUQ1VDN3BDai9wd1YyeGV3NUJYWnpC?=
 =?utf-8?B?VnlHMWRpN09mOElQRk9lK3dCaDZQTmtxKzJjYUZLRGtMTmFpZUxWc3NvRTg1?=
 =?utf-8?B?V0dETkU2aHJVVE5SekJEeG1DMHpwc2ZxNW5kcUZpWHprZ2xDVExmUGdwcXlp?=
 =?utf-8?B?b1F6aWtnc0xyRmcxbksvQTJ2SmRWd0pJYmllZ3gxaW1jbWgycXBFTW1OZkw3?=
 =?utf-8?B?K2RwQnd6WmZrRkdpLzQ4UXJKOWxSRmNKbGtyaElIeU1kNVBrN0dxQUQ0K0l2?=
 =?utf-8?B?RVNZYnRVNldoQXVzS2VZU291NFBZODhnOHl0WWZxMGE4aHFmWVhVRUJVSFFk?=
 =?utf-8?B?aWdrNVNXOGFMcFMxV2VOK3RPWEdXNjF2WWFVa3hDandhaGxGTUVTTzNYOTE2?=
 =?utf-8?B?VjNMYlpNTDFKQ2p3QkVGUEdRNFhia0pBVmsxaURUOFRsdGRXdzNTenB2NHdZ?=
 =?utf-8?B?SXJQNG9JK3hVNEJ0d09BVk1zNnp0VmtTWXk5RVQ4S1hLOExZOWJoaWRlTlI3?=
 =?utf-8?B?MG9NL2NOc2luUkdTMjQ5aU1NRnlrWWUvU1VRc2ozRDd4bVE0VFFQZVlIZ2hT?=
 =?utf-8?B?VE9lMWt1Rmkrei8zSWNMRi9yamttbzdUZUZjY0FBbEdlYmxXVTVKRnBVcERO?=
 =?utf-8?B?OWtIMEpzeS9CR09BRW52aXR5U3dTNGRTMXBpZDFKSzhVKzRVNlg0UEQ3ejV5?=
 =?utf-8?B?ZTZwUmEweE04eG9lZEo3VkZocHl5bGtYRnAzU1UzSkMzUGdhTU5FQjZsTHZW?=
 =?utf-8?B?UmxZaEkyR04vT0RyN1NEZXZac2pUNWFaYnUrRml0N25sdnc4R05lY3BsMW9Z?=
 =?utf-8?B?TVJUWThpeFNjU1JzNEovY003ekdxWjFVaVd6YXhlN3UvWlkyVzNBOXBxM1Ey?=
 =?utf-8?B?RzNycVFTamdHVWFRT3VUQS9mcmhGcSt6UjJUb0FKUysvL2hVMVZaNlJ5VU1Q?=
 =?utf-8?B?cW5TckFNTmtuWEN2YmQ1Nk9FaWovSVJmVFNSeDNaUEtwMWR1TWtFQ3VOQ1Mv?=
 =?utf-8?B?ejZPY0xVNC9paDVxUFRKcS82TE1CQS9HTHdZU2lmVThFRHRiT0plUmMyanRp?=
 =?utf-8?B?V1R6bW4yS1BpM05ETUhCUktjTGwvUm5Tc1NrclgxVEVoSTd6Yk1Hc0hKRzhG?=
 =?utf-8?B?ZXVOdlgveENMQjd0VEVkUXVMZU4vTG1wa0lUWjFWSnhDMnp2M0FQY3VKRjF5?=
 =?utf-8?B?SUFHSXdEMktaNkQ3VWtXNGlvWHdGUlRyOU5MYnlacTZNSFVFYUhQL2t0MTFt?=
 =?utf-8?B?a3lwL21aRmF6RWk2UkJBTEZDRXVqRjBCWjVRYVd2S1NsNzBjL21JV1o1d21s?=
 =?utf-8?B?MXU5eVpOcVRSWjVRV2pBbm5tY2pMZVk2R0MzSS9teWtzRFMxS2ZsbkJEQmNx?=
 =?utf-8?B?dTErdnNhZ2t2eStpZHZqZWJHcDlQaFkvYnFDVkhUd2I5MjVGYmtsejgzTTJB?=
 =?utf-8?B?OTNXYUpYWlMrMkNjelBlS1RaeEt3VXd5WkU1L21UU09mSm1TaGRDVGxuTk05?=
 =?utf-8?B?S3ZVSTFEaUZQL1czVytFbkpwMDZyaUJHUzBpY2VSbytodjFJMXltbkpHUFgw?=
 =?utf-8?Q?s28KS+bokufIrPbrhenD4LZhJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65875458-f3d6-4319-4fc7-08dc905d3a25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:42:06.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWXMJEvzeseKzih4hC6DBCW1LCbJud5SfgceWnLC0E0rokcPM76YCPIEEPwR0jt7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205

On Wed, Jun 19, 2024 at 01:01:14PM +0100, Fuad Tabba wrote:
> Hi Jason,
> 
> On Wed, Jun 19, 2024 at 12:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Jun 19, 2024 at 10:11:35AM +0100, Fuad Tabba wrote:
> >
> > > To be honest, personally (speaking only for myself, not necessarily
> > > for Elliot and not for anyone else in the pKVM team), I still would
> > > prefer to use guest_memfd(). I think that having one solution for
> > > confidential computing that rules them all would be best. But we do
> > > need to be able to share memory in place, have a plan for supporting
> > > huge pages in the near future, and migration in the not-too-distant
> > > future.
> >
> > I think using a FD to control this special lifetime stuff is
> > dramatically better than trying to force the MM to do it with struct
> > page hacks.
> >
> > If you can't agree with the guest_memfd people on how to get there
> > then maybe you need a guest_memfd2 for this slightly different special
> > stuff instead of intruding on the core mm so much. (though that would
> > be sad)
> >
> > We really need to be thinking more about containing these special
> > things and not just sprinkling them everywhere.
> 
> I agree that we need to agree :) This discussion has been going on
> since before LPC last year, and the consensus from the guest_memfd()
> folks (if I understood it correctly) is that guest_memfd() is what it
> is: designed for a specific type of confidential computing, in the
> style of TDX and CCA perhaps, and that it cannot (or will not) perform
> the role of being a general solution for all confidential computing.

If you can't agree with guest_memfd, that just says you need Yet
Another FD, not mm hacks.

IMHO there is nothing intrinsically wrong with having the various FD
types being narrowly tailored to their use case. Not to say sharing
wouldn't be nice too.

Jason

