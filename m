Return-Path: <linux-kselftest+bounces-38069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B1B15541
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 00:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237103AF47C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4400283FF2;
	Tue, 29 Jul 2025 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CH6SMMxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53907192D6B;
	Tue, 29 Jul 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828001; cv=fail; b=CHUATvQF8SsevDrSzyDiXaurlkHpIpMCrGGpOrskP5xOj4CX7+3Z4LJ/zfN/eEQxzgmzoSlxoZtKMHMxdjk6akG+9yhfKpr6ab36qn8NCc4xUW8Kl0bKe+MMcQgm6zBZisWEqj3ofvLw4BEkG8dv3dC3BqmVHCaAb7vNcmXuxT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828001; c=relaxed/simple;
	bh=wh7BjJ8aFs2VfSUAYjYRhrb3APWSOnCdmR+08+6B/es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bppu1vxdh/MClrfWRTsLJuQkxidcNS8Ckq+Wa+M2ggaj4yRkPk00+Dg7ZexcnPpIx1NAStIOu/+DZtfjAPJ076eFAyH6YhCE5h71B3UXKEE9iWB/vypj2ot6G/CV9KFht142FDLUgYs4FZmafWJmzhGwG5tgPaLxsEzVIZf458I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CH6SMMxA; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR3CpZkFvteQY3Uh9HJEBUZcPfJW4na13aSYS7n9GapN1fofWBM9df8a+9gXdoO6SsBl4lYi4dky5m3NzF8ukqQASNAXQgwoWE9ZntQ0h076yYhPgpx97+pIlXtkHsMHaG2rEzn5sQ5bYCB7Dw0M1uFn96+uIOhqwuuIhbG1tqxZZqeoPXkkky0V2xmvzSG4L+DlcjFyeiPczTSOlm4cjIpse20KxSQ9ax0TU6Qa0PAYBW1RLdBwIB8mMLWWGV7ZCtr3yCqrkfP8s20+OjNcuaTJKauKvdScTyBtIVqZxUoGq6wP+VjB9BAiipQhm+nwQgdDluwdIeFAoAIZtz3OIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU9/ZTe7aigLvtHH4lR4aD2xka76wNZuzppitQ0T+XU=;
 b=ivMV1Ozki3Y43pFeeg4LehW2Ye/isLgvcClHB4Y9B5wIfpfqgRvDFinJJlR8t3uo574wv/dVNgL6t70q+1phRW8+fXiLpBrX1l8umeaChnspcaSf1zBLsXyx77P+NDrbNCkBco59SP+r7LjwRK+abfMZ0tov/9qmP4QLqxwU4PE+RvsPz5RNg9G4Skyr+G7sJYJmlcTcSeIClgq0x6odMPxEMsyfjw5kYo8EGGA6rRzlv3JeUNBynh48721XiNH8RDH8DbjHYaREqtZziZMFRHWd1Yp16qvoDeMfEFDQ9SdqwcrZd4vkt/Zc0AeUXFs5SeHPp72/Q9HO5BB+GEmLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU9/ZTe7aigLvtHH4lR4aD2xka76wNZuzppitQ0T+XU=;
 b=CH6SMMxAV6FgYIN6YjPwNqwnDzjCBdJrlweu46lDAVmPpFdFtwXsncsZTqsmy/MIzqQlGsdxQp5aB6DA3Ho4iJMkfS39/TPe8EVOhr0J+A6VupBB7i4LPDXwa48b8Rl6IUqcOromuwJTXnmBIql9cVXV3NI62fZzV2/8TVNclSWTCu++ixibpv786APzFXSIiJ3lFy+VZ6ImRJ8xp3CIztVXuKBiRI8cax3wh/n151TCdY+bC2gVFGEybntKUJ3xLEmegaYaszgFtveJ9g0XN8TfqgqAa3oJ/V0DkM7jfqIfNB8WU7vlUOoJWcbVVH2HHlQVk78tDJI9vPYTb+o8fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 22:26:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 22:26:36 +0000
Date: Tue, 29 Jul 2025 19:26:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: David Matlack <dmatlack@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	James Houghton <jthoughton@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Pratik R. Sampat" <prsampat@amd.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250729222635.GU36037@nvidia.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
 <20250728102737.5b51e9da.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728102737.5b51e9da.alex.williamson@redhat.com>
X-ClientProxiedBy: YT4PR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f99f13-421f-46c6-3f1d-08ddceeefaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVJybG51L2FGZGVaOTV5MTdtMnUvZnVmbTFxU3B3cS85bjhNRVpYS2N2aGRJ?=
 =?utf-8?B?ZTA4V2toWVF1V3kzL3ByYVo2Nm1xeWNNYzRpOStMelVBa0ZLY3JPSlBWQ2Jt?=
 =?utf-8?B?NW9rckV3b1FqVW5xZm1sakZHb1Z3SHZ5RjV3TFV3L1htMW1yQXVrZnVnVktZ?=
 =?utf-8?B?VFF3SGd3U0VvSkEwTkk0b0U3MGJIMGJuZHpNZ2piaU95VUcvMEF3ZVpuMUN3?=
 =?utf-8?B?Ti9IQlhiQkdJZ0hibUQyMkdqS0R6YlljbE84OC9sNEhUeVVUV0hYNDJWRzcx?=
 =?utf-8?B?SGZocVNjSW04THRNNk5RdEVTZnQvYlNDZ1VrYVBwOGxrYzY0T2gwdmRmU2gw?=
 =?utf-8?B?SHlQVnFDVS9heGRhYUtVSVpQVFJBTHpuVHBGTFFodkxQa2lRRy95Ym00V0d3?=
 =?utf-8?B?OWNEd3JKZXJpWG5renNxVExoTW1sbEVhQWRCMzMreHdJZHQvM0hzeVFBa1Q0?=
 =?utf-8?B?VzZHWC9qcFdyRDdPUzdqa3h2aFU1S21mTTNiSDZVS3NwSzh6cGVldHd1WTAz?=
 =?utf-8?B?TkVGWklqaXZiMkdhdnlwN1dPVFhvZExsMVFUdTRNeTF5R3plOXh1T1I3d2x2?=
 =?utf-8?B?T2xsZEQxZ3M4TUFFaEVlSnhlV241dFVRZWVSS3cycWdKcndubGp2WTlOLytj?=
 =?utf-8?B?R2tYR0ZwNlgzWHVUeHYyZ2JKWTdwaFI0WWU1amNCY1pUazlKVWV0VFovcmZk?=
 =?utf-8?B?aTBaTUxzdkpVL3Y2OXgyN1pxVk5Cd1NxNzdkd2NWajVoeno5SWVzT25MWUYv?=
 =?utf-8?B?M2ZkR2txb0d4QmRrZmVyVWFmdDh3SXgybzFiMndMZjlsL0xUdWhyN1VkQnBt?=
 =?utf-8?B?KytrYjYySTMxQWdVdjlVOEtxaVkyOWRoZjNiUE5jZVNPdUpVT1pKM3dtOUV0?=
 =?utf-8?B?WlY3cmVrcURhNXFiME9UN05KZUdoZWovUXFXekhjcVJEZmpSWmFrOFJURC9l?=
 =?utf-8?B?cTgwSVlxb01GVmJwbEQ0R3lveVJ3OXRDc0hEajdLNW8rdGZHVFZienIwa0pn?=
 =?utf-8?B?Mkg0Q0VRSWh1cjFaSE0wSkxFNC9VK3JJRXlsM05xMDUzMHhLZzU1UXdrWlU5?=
 =?utf-8?B?N09OdXg5UnI5eU05RGFMZWNvZmZlYlZNRTM2UlY3c3BnT1F0WUVnSTlQQTJ5?=
 =?utf-8?B?bkpVR2Y5Nk1kVHhKdW1wSGFRcDVYUkMxbnhvanNqbW03WXlFOTNUYWJhOXRm?=
 =?utf-8?B?RmxVSUZWSjV6eGd3dHFaUE1Vc1liUVJnL1Q3WlhRb0dpYlE2VmR3a3pETFI1?=
 =?utf-8?B?akFMZkdid0I0WWVFOEk4TisvV2ZmRHJ3NUYzS3ZLSjdZU2dOczRuNHBhMzRN?=
 =?utf-8?B?cVdnQ2pRTEc1c2dUVEloLzB3Zkc4aFFTOHVGK2p6WGF6KzM1WFplT1FOZy9F?=
 =?utf-8?B?V0x1aDNXSTNDYmFVTU9BOVd4ZWpyTGM5KzdSUEwxYnVCREhHd1o2c1lSd29K?=
 =?utf-8?B?TVo2OUNXVk0zZk8ybFV4REkxUWZUR2FaR29OZTRtcFR3SS91ZFkwa0NIVTVL?=
 =?utf-8?B?eDBnTU1UcUxQWWpxbENvcUZKU2M5NThady9CN1RTS2YxY0xQRXBrK24vN2tp?=
 =?utf-8?B?NW1pQkhMRWdUKzU4eCtmeXFSZU0ybkdsY1EwNWkwZ1FncFhvdHkyRXE0RGRZ?=
 =?utf-8?B?Mytlc0s1Y0RZc0dicHh3R3YzT1VTeXd4ZHM2K1R5Sjlqc0NmVytoSnd2MnQx?=
 =?utf-8?B?a1FvTUlxVVRDdHhWY21xb0xjRTZKdGZzbWc4TmZyUkFkZ2tuZUZWOUVHRlZ1?=
 =?utf-8?B?RzZBNSs1Rjl3WFpScG5XYmVnYlZnbExKRXJ3SVF5MjJhbDJaS2hOajFVakRy?=
 =?utf-8?B?UTE5MmtQaVlZU3pHZDBHSVJXWjJEUjdBL0tGK2lNdWc4S25QdFVOVldGd0tj?=
 =?utf-8?B?WlpKbDhpY3FyZmtvalFIVmdka3BQRHlkcUlDMzJIekpkc2VUR0VDeTI4dmtq?=
 =?utf-8?Q?OmTDqMT/nGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjdZZ2EyZGJJbEVkellHeGFoUnFqamJZQmtZVVJUd0hYVWF5WEpqTy9KMFpD?=
 =?utf-8?B?T2lOOGM1elhxUXF1V1hYMFdNVkY2WlJqTnB5YWRKZjNyOEhBRUlMUlA0bmVy?=
 =?utf-8?B?c0Npbjd6S0RqZGZsam9OUDJUSXhGeWY3eDFwUEYvRkRiMXNxbk5WOS9OSFFx?=
 =?utf-8?B?S0JYT2FJU0JyWDFUZkVPbk1WRzFGQ2N6VDZ3QXR2bCtTODhKT1NEdGNCZlF4?=
 =?utf-8?B?K0V2Z055OG03MC9XNWpwbmJHTDBoaUN5RHRydFpsVHRNK1RBbElPRmVWVms1?=
 =?utf-8?B?QlI5cTVKK2ZMeUpTMFhTenhOdGsyUlFlUm10eWVvT2ZnMjZTY0Rrdm1zOVFF?=
 =?utf-8?B?RmtCck9mSVBWUVR1MTdXQ3VlSW1aQ1JTVnNRN3d6WkVqcFdPMytpQnJ5ZTFO?=
 =?utf-8?B?aVc2MHNiVEdZa24xOTZ5UEh4YmVxSExxb05hTEpSdDZiSUpUSGQxeXN4Unlu?=
 =?utf-8?B?eUNYR01td1JjRDEzeG14VnZIVGIrNDFJUzlQZ3ZEa2FyRndkTmRNZC90ZUZI?=
 =?utf-8?B?UTJnSUVuQlJEODhQUXluRWp1aUwzWU1WQVczMk5FVkkyVEhRQmE4Nm05OTly?=
 =?utf-8?B?eHU5MVhxZXJxOXRjT1d2MytZaHI2UkFaZEU5aVQrV3B3SUZqMzNlbTI2a09M?=
 =?utf-8?B?TEkzbTgvZDBPMDB1YVV4NWFNSy90QTlDOTJvcXJ6aVZsN0xEMHZCWmNPUi9z?=
 =?utf-8?B?Y2VYYy83bVFiTzhNQU9mY2pFaTFqejVEN0J1T3JDRktYam1xcC9ZZzN2b1U3?=
 =?utf-8?B?R2JwMS9UUW5NSC9XU0g0b09wZUo5M3BrUUgxOEhISWcrQnA1bXhtRk9SZ09U?=
 =?utf-8?B?MEJFTFE2cUJjMGV2MlQ3UGZ1Z0d3djhlNjZtZkcyaW1DVWVOdWtiRHVIL0JS?=
 =?utf-8?B?VkxUT1AxSEczQys2Zm5Eb3VtSGVWN0Ixc2FQRHJQU1ptRU9ZK29GZG12U1B1?=
 =?utf-8?B?V0JJanZWSWp0ZHUzbWhEZ1pzdEliV1hmMXlyeXVhbVNEY0JJb2oxZHVGb0Rm?=
 =?utf-8?B?cURybTdoUW1Rd0xidlRnWWt0ZjFBcE1qR0x2bGl0MXRMS2o4YXlJdUdaU2tu?=
 =?utf-8?B?c1A3NzVYMlBsSGwyWTUzRFl5bG91cjVCWmZLbSt1bG1LZW84WHEza2c0emQv?=
 =?utf-8?B?MnlHdnc2dS9tM2YzSkQwbmFHUVNlVmc1QXhCSkE3SEpTbENLTStpU3ZoRW5P?=
 =?utf-8?B?eEdSZTdmMjcvTmVJamQvZm52dnBNZWE1cUwwbFdwYzdUTHpIb2RYNDZYNjNB?=
 =?utf-8?B?a0NXRTMxZXVSblRnakVsbXQyUkZ1MGgvVzd6VUJqOHllS3JlK095WTZVMlRR?=
 =?utf-8?B?M002bWxoMXRjd3JoVUk4UjM5UWxWa2g1dUZLOXgzbERodzJPNndsY1I4aGlW?=
 =?utf-8?B?cTRvRnRSOW03QjdnNTh4anA0ZGRLRnJEOUJvSVlrVlBGRHI1TURDNWJNVzky?=
 =?utf-8?B?SnI4d044Z0QzdVVmNEdJRVY4M2ZpOTViQW9MQTR5bERNUmMvelp0RU1iNk5H?=
 =?utf-8?B?WnFDeUw3eXVpeE8vWDBlWE1oaTZvVW9mVjVicHNRMDdvclFFSHcwYzFuWGFs?=
 =?utf-8?B?b3g4WjVYZzQvcENiUGNqR2c3WGFqNGhlV2NZd05xVzdTajgzUlRSK21jOHJo?=
 =?utf-8?B?dGRoeC9lQVFTTXRSa0FMSmI1RTFRWmZkajVDUnVaNjVNaCszSGp3KzhyNkJ3?=
 =?utf-8?B?RjRZNjQ4K3dsZDBmMmEwOVFoSitYMHhZWVJta1EzSVBjdFR1RkUrUmZ1R0d6?=
 =?utf-8?B?MFd6bm5JZXV6ek9lb0dCYmI0azJGanluV05BY0NQdC92bm9NdUd6SDFZcWQ2?=
 =?utf-8?B?K0VURGxOZjAzd05zYzQ2aW5FYzFLaTNzZ0dWYkQxcU4zemZvNHpnL3ZYcEI5?=
 =?utf-8?B?eDJRZlBaR0NWdWVDSXJZK3g5MEQ0Z1djOU9ybTN0YjRNNDlCYytPY1Zucit4?=
 =?utf-8?B?clNrTm44UXg4UTNReWVyRFVVaXVhUjJ5UzhJZXhEQXpEeFlFbFhkQ2kyT0xI?=
 =?utf-8?B?QkdzV3JKbEVIYVdmT1dCVjNaQVFodUtQVmtITXVickxwREltVDZ6ZncxT3Jn?=
 =?utf-8?B?NTcyYzZZYjNENzNCQXU0VWZ2dlI0RWliRUdCK2pGbzlneERUNmdXNG1MNGNh?=
 =?utf-8?Q?8NhQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f99f13-421f-46c6-3f1d-08ddceeefaec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 22:26:36.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWY+WaHq8VEBFywj+IsW88bIb4Rjp/VRLl5tF+kny08bjp0wOTNyehgeXsHibyYt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Mon, Jul 28, 2025 at 10:27:37AM -0600, Alex Williamson wrote:
> On Fri, 25 Jul 2025 09:47:48 -0700
> David Matlack <dmatlack@google.com> wrote:
> 
> > On Fri, Jun 20, 2025 at 4:21 PM David Matlack <dmatlack@google.com> wrote:
> > >
> > > This series introduces VFIO selftests, located in
> > > tools/testing/selftests/vfio/.  
> > 
> > Hi Alex,
> > 
> > I wanted to discuss how you would like to proceed with this series.
> > 
> > The series is quite large, so one thing I was wondering is if you
> > think it should be split up into separate series to make it easier to
> > review and merge. Something like this:
> > 
> >  - Patches 01-08 + 30 (VFIO selftests library, some basic tests, and run script)
> >  - Patches 09-22 (driver framework)
> >  - Patches 23-28 (iommufd support)
> >  - Patches 31-33 (integration with KVM selftests)
> > 
> > I also was curious about your thoughts on maintenance of VFIO
> > selftests, since I don't think we discussed that in the RFC. I am
> > happy to help maintain VFIO selftests in whatever way makes the most
> > sense. For now I added tools/testing/selftests/vfio under the
> > top-level VFIO section in MAINTAINERS (so you would be the maintainer)
> > and then also added a separate section for VFIO selftests with myself
> > as a Reviewer (see PATCH 01). Reviewer felt like a better choice than
> > Maintainer for myself since I am new to VFIO upstream (I've primarily
> > worked on KVM in the past).
> 
> Hi David,
> 
> There's a lot of potential here and I'd like to see it proceed.  

+1 too, I really lack time at the moment to do much with this but I'm
half inclined to suggest Alex should say it should be merged in 6
weeks (to motivate any reviewing) and we can continue to work on it
in-tree.

As they are self tests I think there is alot more value in having the
tests than having perfect tests.

> Something that we should continue to try to improve is the automation.
> These tests are often targeting a specific feature, so matching a
> device to a unit test becomes a barrier to automated runs.  I wonder if
> we might be able to reach a point where the test runner can select
> appropriate devices from a pool of devices specified via environment
> variables.

Makes a lot of sense to me!

I'd just put Dave as the VFIO selftest co-maintainer though - a
pennance for doing so much work :)

Jason

