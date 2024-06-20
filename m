Return-Path: <linux-kselftest+bounces-12325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875B9106E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B4B2461B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C11AD9C1;
	Thu, 20 Jun 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBlbmiTA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248348CCD;
	Thu, 20 Jun 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891748; cv=fail; b=skB3CmB8hkHz1hmNgu+ixohR9O3sD368jH2nzpBv3wWJLrMegkqJm8OjmjysthyzDRH/eMIn7Bi+U9DS7iYgIVnasR8GgFUxx2EjGaJSSf2DOs4f3aJd51v8D7ddyGP0MJ0gi0oko6xzLSs60kTTQbog1iGz8tLFySsyHnF1wDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891748; c=relaxed/simple;
	bh=nI15mm40W7zMyr7NZlfXOB1PNXbWIH5RM1mA0Or4Yok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rha1Q4KYQsEOjzD292yAGle07m+jeGPN3HlZSJyhKPBEMXNAvu/o0P2wxfXya4327PqP9wYscK0ftubjRy/sGPnR4XZxd1FWTYTiWLD8uvl3SjfQJKNWK3Cq1UVaCz5KzZ4j/FqnC/zNWUpJmyvRtv+Cig8RsYY591wnvc2uDWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBlbmiTA; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9fMiN9cvdkp5C+V647OdRHi7WqjXAk1F/Y70vjLnFijE5FfQXGjO99JgShO7TVjG2Ftr5JZzG6joHz5gobVBsp3R9pBJ1R4mM7aE2SI9PnrSobJ6zP6QnCl4Op+RDWYxdMZHGB8PDznH598cMKZCISHLPYk/xOZZh971LGNEKeZwlbmbjPynXi4AtQSIrubcQkFi3Q/WorZ48ukzkeM5fKECF1V9ZYYEdC2FAL1UhOYgxeJODBZQQR/H6OSGzFdmG7q4AXteMYg8FLOGqvCPW8NFkSjHQOP9hqktE/ivzIH18eD4wVpsaVaSNgY8IORoq7PF9jtpXtVV7xsDYzRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IsWb3NVnOr8uUFvzDtaqHlzaVg9d+GNRRJgkOyoth4=;
 b=knW9ReQ7MEbcyrTyzU2cT4jTESwiaDssb/1cQOwcp7Jmre8Rud8ROxp5ymgT1RKRoXzN7TQS/ukLUIr9gINIOHLqyAjEedF+AoUGH88BfRVaUeIho4ll+babSQrLCh+IY0g2iDyGKUYGltgiNxN3ysr3tT9eWqlgh+4asSVbcxq3tCNc1QxEHL1mcwfG97AR6UGkf7+/r2XmcpHvnMGR5ruXY3nm3sr9ba9V5gTckhO8csmG++LOirv1PwD5pIe0oSPm5ZTQVn02PLJnvxpJVfz1OAmE1rsYY2imb04sn9ioATdVkIlcklV1AGnmvg6gEiqpAsKxueLvqToBRxNbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IsWb3NVnOr8uUFvzDtaqHlzaVg9d+GNRRJgkOyoth4=;
 b=BBlbmiTAOkrDYo1f0gIHGLjGOMmmYzfKmRrpCia6RnQtishkjNvZAWYfO4HzGzpWaILM/Pu2yU7er+wz3aIsDX1w42t8mfiEAe1L3BQO8XGc9QWNB+Aersccsl0X+2jDIJLgD271ZsKojBqWDlET/9avvMxx7I2pkTfo0M55LSdLPVqF9s6a+Ky0u/ivvSAImdaGbyAGu4r+z8HX7ijI/iDmmA3kwZEGQmHklKQEQyQJ6p4kiXcEJzz9oQuvDiZ3uJg38/vSPzFLVvWUMwTU/O8lCqbHR8OVpyIi/RtFmUiNHQlUjUEXq4OOhm2RkL+PMslmuqDbLzvRnFCtMQotqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:55:43 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 13:55:43 +0000
Date: Thu, 20 Jun 2024 10:55:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Fuad Tabba <tabba@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620135540.GG2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0292.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: c6332ba6-6459-4dba-0462-08dc9130acda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEtnMjNjU21BSXBqSUdsKzhDVXd1TVNPbmlENlA4bVJ3eDM4bUV5K2NmWkNv?=
 =?utf-8?B?S2hQT2ZNK2thLzkyb2V3U1lRcEQ1eTEyek9LS29uem1iclhQT3dTbGZlenpT?=
 =?utf-8?B?c29GTk9JRmlnUGh0Uk96TFRDZ2F3WnJaR2lqR0Zoc1g5aUl4bkRTRWtuRS8v?=
 =?utf-8?B?SzFMemdlc2wxU3Bqb0dsbFhBWnhKVjlDTCs0dlZTbHJZb1ZtRGFlY1FGVlo4?=
 =?utf-8?B?WElad1pnNlRmZjNkRkxaQnRPK21FZUZtTDdHRWh1RUxiYlNySVZ3bGlSR3dF?=
 =?utf-8?B?NXBSSTlna0p3Z2k2aldqSk5GSWRqL0ozcWxYQlFtL09UMTQrY1UvVVoxWUs3?=
 =?utf-8?B?bWhERGFmci90RTR6NUJnYmkwY1lFMWRWdUkvemtIYW4vaGl6Y21lWFFXVHpk?=
 =?utf-8?B?dzJIWnJNWTJ3bEpRV0pnYWZkZ0hKaHBMeitUUlRPSWpwYVVjZEZQdVBCbzFQ?=
 =?utf-8?B?MTlpY004UXdJRXhINGRnT21nV3RMVHlIZHR4a3prR3dTUndudjVnR1VCam5m?=
 =?utf-8?B?UlZjbWFsVVIvcU5FdW50bytIMnhoVXFOUlBwM0YvQmZvVHRnK0Uvbk1DVXhD?=
 =?utf-8?B?a0tIbDZNUHZHbXlweU9mcXRMWWsxUDY2VWUrQ2FsSFVaM2pYYnlBUkVwS01P?=
 =?utf-8?B?c053TVliZE5hZUQzcXQxL2Z1bEhQTmk4Y05NTWxZN1NESWJkL21zblNubXBF?=
 =?utf-8?B?aXliWFRmbmlKc1R0TU44SEVPZW5yQ3FLZlRheVk5dmpxdWoreEVHZXNWbG95?=
 =?utf-8?B?VnE1Y3B2MktaWTdmQ1JMLzRETllxRnpEbngwc25tYlN4MU5PdzFBZkZXMWps?=
 =?utf-8?B?WEVUMkRiUDhiZWl5M0poV2x6YXFSN2ljcG45MnlVWEVmQXlHRVhZOXF0MUUy?=
 =?utf-8?B?alM5S3YwNlVReTZwbTFBMnBGRFBoM09VOW9wM0l0V2lNUlpndkdTWDNNZHhj?=
 =?utf-8?B?d1JCNC9UN3ZEdktqd3htdjdiemVhS2lGNkN3VDdoaUJTUGtWVWoveTFyTit3?=
 =?utf-8?B?TVhTc1lKWEg3YTJJUWtJQ0I0bVdiMlNnVGQrZFMyOFFvTmtUdjA1WGhxYk9O?=
 =?utf-8?B?akE0eVo4MTFGMkdIZGJkZ1h6aVlxNWI2WTFYa3lKOFNkMUFGS2pPVVF6dVBV?=
 =?utf-8?B?SEpFY2lmb1BoTXBFMUdzZkMyWmdyR0sxa0w1Q3lmcXBrY2tQWnVoSlFIWFR0?=
 =?utf-8?B?Z0MzNUpoTVcrdUpnR2hUNllLWlNnNHV3eFIrUFdubWw1b3VMN2VGTWlmSWNr?=
 =?utf-8?B?Z1JRRjFlMDZwMEN5QmFDalZ1ZHdjaUlleE01dUxxemprOCt2UjZkV3NzVXJQ?=
 =?utf-8?B?OEROTnBLaHdXeks5THpnOGJlVFZuTGZJZ0FlTWZJUVI2UVJXR25DN2Nvck1B?=
 =?utf-8?B?b21xNmkxOHlUTEJIamxtb0JjZFBtRlk3bGNMSTdlWHlZaEtnMUdlaUhmRHlm?=
 =?utf-8?B?MzVZUFh3ejNsTnUyMUI4OXVPMkJDdzhlY1VMcHhOZ0JqV1E3bHgvZTZ2c3pN?=
 =?utf-8?B?ekhTam4wWlZFbTMwMy9OMHR0UWpRNWZSVEVYKytiMk1RcE1zekU1TTd3Wnll?=
 =?utf-8?B?NWJWT0NZbEdBc01Db0tFYUhsbFV4bGFIVU1IL0FxQmlpZFRRT0VCZzdaZnQ4?=
 =?utf-8?B?NmxjMHRUZ0g2dWdLSG5nNUl6VnZvbzhBTTk2RW1Od1NubDVIT3VpSDRneUhS?=
 =?utf-8?B?ZGpRTEw4eEVHN25xNkxWcEo5ZWpDT0RpZTNVMjVrM25KYzF6eWNodFN0VWZy?=
 =?utf-8?Q?3kZchIMpqiOdmNsHQ4ABU1/FqyYIQn+8VX+qzg+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFXY1BHQWZUaEhwbGg0TjdQRndtZ1B5YytJUFRXV2MyMTRYVzdyRTBPTFcy?=
 =?utf-8?B?NXlFTVRVdnZVbUtYVlRFdmNueGFBZU1IUzQ0QTAyalRNUFRLUkJxM3NBMTBO?=
 =?utf-8?B?cnV2WnJiUk9neW40YzdaOUtVYm5CdkQ5L0VBN1gyWkJMOVhwSVo3WUtYbjEz?=
 =?utf-8?B?bG9BN2Q1RjFWVVdxbUdHK3ZwVlI3cGRBWkhHS3VDZzVhMFZkaFJyY1FEM2Ew?=
 =?utf-8?B?K2dkakJyMTBrd1VoY3BKd2ZSZlYwNDNIL2UxQk1YVkFwelJZQXdNcDdYaUdY?=
 =?utf-8?B?ejhFSGlqSDlmMzRtWW5rMmowZnc2a21TWHNsQmtBTTlrNzVmTGlIWlJDNVp4?=
 =?utf-8?B?MmpNNGs4ZmZHMVl4NDk0by9UU2NhcnhnNmJRL2QwY1UwN1N3OWptbzFZbXor?=
 =?utf-8?B?WkdZdGRjT2NMWVhIVG5nWFQzMXBXUjMrcjhXOE4rREFsU0RvVDF6WDhJemRw?=
 =?utf-8?B?NDJOOEU3K0tlc1AxQngzcmRIYy9CVldaclFQb21aejR6enJSWk5OS054VVlZ?=
 =?utf-8?B?S3FUbGQxbVl5QWlOQ0MwYld6UTAyRmZUZFNGS29NYmhEYmNsSFM2aW9sdE9G?=
 =?utf-8?B?ZW5ya3AvaGwxbXpYVXJodFhRN25IMTRVRDVqNExaN3hmYXFQNklWMFI5a1FC?=
 =?utf-8?B?QnEyQWZkMHNwRDlhSkR0SlNuSTcrcTRqcDNXS2dESHFnSm9lc0N2aGhNRzMv?=
 =?utf-8?B?c0tMcjMwSFFYK2UvMWdkRzVpTXowQ2pMQnc4WHRGNjMyWWU5MDhSaVlSejJz?=
 =?utf-8?B?REdsOVU0L1VRTVRYOEZPK3BPSHVpcnZuR0duc1g5Rng2YnZBOFU3MGhudloy?=
 =?utf-8?B?NytFakZxd0NzaEw3SkZWaVZXaXBoaEpjcGRwWC9UY2syY0MveFpuMXdOOXRW?=
 =?utf-8?B?OGdEUnhRVEszdU9GUWFxbDhaNGloVDk3UVVJNGVHTm50ZWlkT3BuUFdjVEZF?=
 =?utf-8?B?QzhtWkJNSkVrQW5lRlkvQkxNYko0cnYxUHVhTmNOYnNuNHlPWUtEL1JYNEhR?=
 =?utf-8?B?Ly80ZmZMdWw5czRYMFRNYjMyR0RMVDJrb3lDQVQ5V2JwUGxFMU9YSEN4QmVu?=
 =?utf-8?B?bzdhVS9Uc3lJVTRMSzNPQ1BZTnNyeHJSQnVGY3JXekpVK0U5Z3lPM3VDUUUx?=
 =?utf-8?B?RDJFTGtaODdMT1IyaHo4amZUR3pxdExJQitxK2FZSXQ0ZTQvaUZXZG4vRjl3?=
 =?utf-8?B?cnpJUjFWODlVRHhkejFGMmI1YVdMZ1R1MjlmSTlmUlBZeWNBYkI0aWtHMzls?=
 =?utf-8?B?TGJiK21Bd3hJRUJ2VHpBZVFJdmlmZVp2Nzh3bVBFY20vcjM2UHRrdlhUWitV?=
 =?utf-8?B?cHFBeUQrRVYxYlhoUVUzV1Z6cHpuRmJKZ1M5TVFvRk5BcFJXN2FtQ1VYaXdJ?=
 =?utf-8?B?aFJkbVBqSG1kZEdpdzVLdDA3WWJQZVQ1cHNGdlRhRkxPTHdwUHBNekJkMGVl?=
 =?utf-8?B?eVpiZEx0V2VZdnhNWEtQU3dnekpBV25VVDc5UkZLSGVZcWJzdGtKMEV4Y3Va?=
 =?utf-8?B?ZE5iVUlmeWcwa0Fwc3pJUnZURkJQSXo0dTZvbE1YdXVEd1krK0dCKzFWTzlT?=
 =?utf-8?B?ekJseFFkZCtJUlhJZ1ZFYzR5U2VHcENXa0lpU3VTQnBXS2RpVjJaMXFPMFpG?=
 =?utf-8?B?V0JYMGp6bmxLL0RZU003eEcvNy9zNDVJTzZha2Vra0JCQ0FZbmdPYk4zaFNX?=
 =?utf-8?B?TkYwVmtwU29pUTM5OFJwb0kyeU4rZTRPQkJ0Q3pGYlg5M2hBKzlTTXptb1l6?=
 =?utf-8?B?ZGRRYS9qV2ROZGsrK0g0Z0VUZW9kUGZVRU8ybUMwbk5MdytNL04yRFJOb1BM?=
 =?utf-8?B?WkZSalV2am5qeUpWRysyMTNrM25YR25NRHd4L0ZnUnd2RTRLN2NhdWJvMDJU?=
 =?utf-8?B?ZFZJVmhHRzU1M1J2cXhLQTdnb0lENWQvVTNBTEt5K1R2ZFVBRCtYaSsvd2hU?=
 =?utf-8?B?MHRUZDJHUjl1TjVnSkh2QWVINnpJRTYxZ0tIZ2JySjIyeUM2ZFRBZStvWmkz?=
 =?utf-8?B?M1R5cUd5d25nR2toMmxmZDk4UnZKVXRMR0RSZC9NcU1hT1E2WmhlMUd2REdO?=
 =?utf-8?B?NE1iU25aT2xlS2hKd2RXUmRWenVPM3l1dTYxTlR2MTYwZ2E4c0laN05wUWx4?=
 =?utf-8?Q?B9Z0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6332ba6-6459-4dba-0462-08dc9130acda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:55:42.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gS2b0uF2ZOS/nrxSpAg3wV9EXjNTPUHFJR65jWGL7ukrFJ32z3GcreGvfh97s56X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256

On Thu, Jun 20, 2024 at 09:32:11AM +0100, Fuad Tabba wrote:
> Hi,
> 
> On Thu, Jun 20, 2024 at 5:11 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> > > If you can't agree with the guest_memfd people on how to get there
> > > then maybe you need a guest_memfd2 for this slightly different special
> > > stuff instead of intruding on the core mm so much. (though that would
> > > be sad)
> >
> > Or we're just not going to support it at all.  It's not like supporting
> > this weird usage model is a must-have for Linux to start with.
> 
> Sorry, but could you please clarify to me what usage model you're
> referring to exactly, and why you think it's weird? It's just that we
> have covered a few things in this thread, and to me it's not clear if
> you're referring to protected VMs sharing memory, or being able to
> (conditionally) map a VM's memory that's backed by guest_memfd(), or
> if it's the Exclusive pin.

Personally I think mapping memory under guest_memfd is pretty weird.

I don't really understand why you end up with something different than
normal CC. Normal CC has memory that the VMM can access and memory it
cannot access. guest_memory is supposed to hold the memory the VMM cannot
reach, right?

So how does normal CC handle memory switching between private and
shared and why doesn't that work for pKVM? I think the normal CC path
effectively discards the memory content on these switches and is
slow. Are you trying to make the switch content preserving and faster?

If yes, why? What is wrong with the normal CC model of slow and
non-preserving shared memory? Are you trying to speed up IO in these
VMs by dynamically sharing pages instead of SWIOTLB?

Maybe this was all explained, but I reviewed your presentation and the
cover letter for the guest_memfd patches and I still don't see the why
in all of this.

Jason

