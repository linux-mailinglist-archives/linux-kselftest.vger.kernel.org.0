Return-Path: <linux-kselftest+bounces-11646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F35902F8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EF62845D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA116F91C;
	Tue, 11 Jun 2024 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZe+HMqU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF0386;
	Tue, 11 Jun 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718080456; cv=fail; b=VhbTUan3qlaCBh/YpGYAfqCukgKw2VqiiRueeYpkTfrE8CSAGPkgj/TDCdiiH/E+WIQVHBsFwHe4h5uGnkgYK50ZxgFG7S9RdBFNxzFeNcVjCTSNCH5aJHdlQBoqnYYX7YR6Olh5YeqmqD6ph2iVu2sEBTuaohTNmqo4b6bmZ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718080456; c=relaxed/simple;
	bh=UO6jLYam64KBjmWmdPbcRuVGpj2binfo4XOTm7OzLmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1hx7hIjxJSMNHMminp9OjecVCunMql6Vr9rBGov4RvJraEcIyicgbLgMBoKLxz6WcrUh+51geAmS0q+SRp6pWKv9X4qyI22BsVH/A9ZFhHPSqk2bZsdWP5tEvYlHsTuJr5emTF2zpuSg2R9SMECq/3rHWGTL/6uOUEj7uziiyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZe+HMqU; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7DWfuhM8WoQ/hVqmmpis5nYxZ0vI5DxbHzAlOtwcmQrc9YYTAkY6j8nJRBrmtMTh0418ho1gwCkEWk0VCCRU/83xNlsAWc1Ut4JXGgPA+gHTIJdVV01iMIpRf8fPhs3jnNX+Gu1225SDKkx2/1UTVF/8GCxfLhys9bNIMqgWj0+DpF64cV/AV17Kxobmwk0pmr8kEv9ZySZd/QTO3q9XxM72B0u2qGkPJ1tLqr7Q+XoxuBgjCg+txMGwMPPj5tUVfA1U8UTDhZb+67CgdiX652tNlKtEeTgI8g0NLIvYhezBp6olbUqVkfgvde+EWWlypDVqMyRBY1NNhhwKZVSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpzIu5y0xnn9Pff+XF+K3wDFlsC8MQQwlt0AzxRTD7Q=;
 b=M8CLbHtVAfUQ18kX9BmNHPX+XL8nXEIfuKkwo0aYGC6kumDiZtKunWPKzjLbQc9K87k8TPQaIH1wtt/nt+W0y6dEoV9c7099lgkWzJahe6YB9AJgn6WE9eM9zWGgwjiC6lZ8YM4j5aF9hEmf5px9fJfBvdY/7eB5n3AhDFWkclv75b3cvjQALvErkPkSgKGcrUm/LO2P/bHfebqfiyZRUiGz508Pb6fySV7r0LOHq73FRTQeCi4SbtWkjtREmrPLoCvpE10Y5PrZPajLXk0fhjSHgoBvpm59XCD0lP+DTBMyJ74NtlEDCK6c3DuqY82dUEWeIITDvGSA+pvagxyZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpzIu5y0xnn9Pff+XF+K3wDFlsC8MQQwlt0AzxRTD7Q=;
 b=aZe+HMqU8uYdY8HJmH6XAG2qkHhsWlNXUkhnGNOkAeAi+L9OE9plID5NqCq8XFubEVE+6WfShCOKwpJDeZNN6TGJx4xAQkhu9nRyS3HvPILSBODBx1couuIzhClLnzgVnJiv28OU6ygK/C7SrS/YtgraMrk2a2fuOBc9ANZvO291iSqIVhgF96zpzZDMAVoS1fgRYG5NLmP6dASiDKwTffJdK6QNgoIQH9CoUFaGwXkuo6obuJGhjFnk+HBT50WSEk89zxliq4YA3FBQStiDhYQn54FGAB266pkpVcseHux3aanndywy/pCoHKBNUzr8s/FYRiVzhL3p7/CQwh37Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 04:34:08 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::657e:28eb:3569:4f91%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 04:34:08 +0000
Message-ID: <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com>
Date: Mon, 10 Jun 2024 21:33:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d65ba0-a376-4add-b463-08dc89cfbbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtRUzQxc0poN3cyekxodlg1SWhIa2JWbmp3VFRxS3hUVTlpL0hkL1hCWkZR?=
 =?utf-8?B?RVc3elRQUzRLT3AzWjl3NUxPWlVrOUM4R3N5N0YrL2VIdEo2UWkvUzBOM0Fw?=
 =?utf-8?B?NHczamorRHVVVUNWTHA0WXNDaEVrejJDaTVRTlVxQjdyeGxnNmFlL0ZHRVNi?=
 =?utf-8?B?K1ZBZktOcUswazArYjl4a0hZZlluRDhINXdNbTBOTzBBdTNRL3R5TmU1ako5?=
 =?utf-8?B?WS8zS0JEUmwzOHNhTUhSQlFxRTZ3d1hWUHJsV3BHSTNsR1VRYUZCQmg3Vzhh?=
 =?utf-8?B?RnRyaUFCelQ1SVJYVmQwaFpRNHZFSWQ2UUpLUlA3UzRiWHpETUxmSyt4Mkpa?=
 =?utf-8?B?Y3dsSWcyRWxiWjVqbVo4N0pOQTQvYU9XaE1mRDNxSXJNd3BuQ3dMUGE2Mjk3?=
 =?utf-8?B?cFMzMzNRaWU1dE1LQ2cwdVBzS3NrQlFobGthNG9nQTkrVjVseFhCemxlOE9T?=
 =?utf-8?B?bk1SUVdCVVRTaHQ5TVFRTU1PNnJMd1ZjaXFmdU1qZXBIMHZ4QUpBdFJPM01j?=
 =?utf-8?B?aG44d2VNZEZVNnBUOEpRODBtRHJleUEvT2xTbDJmNWM1cDFheE15a0JtOGJu?=
 =?utf-8?B?NEhWWEdneDRIR01OdlN1dzlNNEkrWnl1REJDa05mNUl5amRvYlhYRURlK0Ez?=
 =?utf-8?B?UVV4NFhKelU5S3ZsMmZKTVBrM0xlRGtCRWs0L1VhQlNWNzBEc1Z4V0hZMng0?=
 =?utf-8?B?eEpNNjV3WXpWR1RZQnJhWnpUWVZpYTRCVjdEQk1ONGJicmZZblJiRTIyODVm?=
 =?utf-8?B?K3BVanNhY2hsNWpLelN3SjZrVDFWV2tjTkNPT1dlTTY4SlZnMTZrcVY0UGpr?=
 =?utf-8?B?TERIMTY3QWFQZEdzSHJBNlUvc3EwcUZIL3pKM3R1TWNlOVA4dmVVZldJU0xS?=
 =?utf-8?B?MS80eXRiOFVYb0FhODlYR0NERXlLRnM3Wnk0OEIyRE1mdkFBV0hnVUlkc2M0?=
 =?utf-8?B?TzJEQXdxTWlpRkh1ZS85VmtJa2E0RzhZTllweHV6NWUzclJCb2VZOE1OTXhv?=
 =?utf-8?B?OUREMkRoUWxTQm9waHNCZE5VNDJyYStRU3YyRjExRnNwb2tnWUVyY2pLTTRk?=
 =?utf-8?B?Z00wOU1RVnR4N1JIeC8wcXR5Vkh5c2hkTG95b3N1SlltWVpxZ3Z0bVl4dHl5?=
 =?utf-8?B?cnM0S0hoNnpka0N5TlVCaEd3a2w2czl4ZXhmOXh3bGdKSjhUM0JZR2VtL0ZP?=
 =?utf-8?B?eHdLQkF1ZG5MS2pkVUU3anJLNnNvRG1GYyt0OEVoajJMRTU2RWVrSUJTV00w?=
 =?utf-8?B?QlVFQW9kQ0JXa21mNFpsejJCZStxWHlCSG5ONC9pMjRoSHJEcHA3b3JBeGxo?=
 =?utf-8?B?Zm1Dd0ZFQk9VNit6UVFOUTc1NFg1ZkR0VlJJUERYejVmYjlURzJVZ2ZDdnBx?=
 =?utf-8?B?blJNQkFuYVlmVXd4azNMRDJ4cjNhSDhCRTJVdm52N25OSXZvenZtQzUvK3M0?=
 =?utf-8?B?R3VsaDFobU1JblVaUUdaZFpUbE1iM3ByUDBOT2g5VjJ4L0JHNDFzd2daUlRE?=
 =?utf-8?B?R05USDhOTzhXc1QxR3pwOWd4OWh0U0loc1VGVmVQN0IwVkxlUXZwSXJTa1dY?=
 =?utf-8?B?a0lYR09CRzFDMnJ4Kzdub1dEMG82WnZnNzFVL3FUVmZHWVhDNWVMTVYvYzl6?=
 =?utf-8?B?Rzg2VmdLc1hMZ0dTbm1xSk4zNWwrOGw1M2EvN2xDK04wd2lLdisydUg2aVhL?=
 =?utf-8?B?eHlGdXgxRUdKNk56RU5LSndNNkpRRzlaNC9xd0toaUhTdzNVVUlOdWt1K2V1?=
 =?utf-8?Q?ocsNiL7g8ebnQaxB1uWORhiv65ii+1io1rn1jr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWlBd0dvN2x1aXI2dlJSdUFrTURhbzcvWkwvdjI2SjZTV1NPaFprYUpLU3Q0?=
 =?utf-8?B?ZU5NdE94UFJFK2tISi9MRUdnYUtETzM3QkZqSlk3UGk4UzZmcG40RU80UVRY?=
 =?utf-8?B?K0hqRkxrRWw2blQrbkRFTlVsTHZnQ2g3RFBrQmJaRmM2aGw5MVA2UWU1Z1pI?=
 =?utf-8?B?dkQzTnhQeTlpdWNmSVZPU3UzM2o5WWVCMDRxMTkzSXdNS0NrTk9iT2lOL29h?=
 =?utf-8?B?dGhCb0M2TTEwQWxJRW5kR2ErNGlPeUdISHZBWUVvVytWTWNzV0FpbHJZaDB0?=
 =?utf-8?B?QUVnQTdIRUFoMFlpK1pkMWdJL3lsSlRPQkJVVlFiMUJLd3o2aW5TTGFTbkhS?=
 =?utf-8?B?SW0za0JPVHFib3Y1M1A0ZXU2clNYcllOckVtQVE4eDhZT0RpMUFkMUJrWTd4?=
 =?utf-8?B?QkpvUjl1YjgzdTBaQ29xNFJyZS94bVlvWTBiT0M4cm1PY0owMEF4VFYzR3pW?=
 =?utf-8?B?L2JVb2VsMThZZlFBWDdFdG11blNEQncrZXlraDNrQmVucTZydHQ1a0c4aHhl?=
 =?utf-8?B?WUtIc3NBRUtvVG5EL291MFBySTdOSWc2WmNZMFNxNHVNSHg1a0hjdGpLcGRP?=
 =?utf-8?B?WWVmdlRybUpGQ2ovTjgwWkRsSmhPLzZFNVBmVzMxcWUzY2dmV2pXRk1CU1J6?=
 =?utf-8?B?UXIxWGVGTnhoZ1BaYkp6cXo1VjhaaGdnZXF0T2sxVm94ZGpnTDdNVDdnUGpY?=
 =?utf-8?B?bVlWaVJYcGxvVVlIci9DVzladkMwdVVtSDc4Q1ByWmcycTJLV3BzWTZ4c0Vx?=
 =?utf-8?B?dk9XN1RzTUc4SlVZSTd4aFJ4L0Ezd1NtbGZJL2haTUNMTFBwclR0cGxjcUFl?=
 =?utf-8?B?RG1wY2lSdE5QR1VrY0pTc202KzN2akMvMW1sUDByZXBIY28wY3o1MTlHb2hi?=
 =?utf-8?B?MW9WY1pRUldTODJGQVEyU2syQnJzQWM5QVVoVndiVWgzbVYxVEVmb0JRakpu?=
 =?utf-8?B?NFFMS0hBdXl5bkNMRHk2dW0rNWVON2EzNGM5RVQxa0llbDdveW1DeG15VVZ2?=
 =?utf-8?B?TDdLSjZIVkVjeGlyRW9wQWtkYUdRaUlUL1dScUt2c2NLTXlpc0VYUUlVQ3Fs?=
 =?utf-8?B?bFBOejcxT3JjRVlXajc5NWpFZll4M2F1bDI4Q1hTRzVqeFN6NHlHeUNOc0pI?=
 =?utf-8?B?eFppNSthdjc5WFpYY2h4ZGlyTHBicG51dDM1N1VON2ZGSzhXWWwrSmcxbkk2?=
 =?utf-8?B?MEdTdHZWelVPT0pCS2VaMHpiczVUbG1EUWVXQWpXZ1YvM3Y2OUVCdmF4Wm9J?=
 =?utf-8?B?UTQ0ZGNDUjJWa01XWStZSEhHRnhucktHc2U4Q0h5VlBjMXlsRkdFTDRoM1hx?=
 =?utf-8?B?U01iSzdWbzZVZkVlUUNkUTBtRXgrUkdYV2FPUXVjWEZpME42NDBaWWRmVjZ4?=
 =?utf-8?B?OUw3cS9IMlRxMm1EWUJZeWlrZkU3dXNMc1NxNG5WSmVXelZvVU80R3djazVo?=
 =?utf-8?B?VGpyRUl5YTJRbGxPMWZMTFpUOVlBQ3l1Ui8zakZNT1lmN0t1UnJXcDB0OVEx?=
 =?utf-8?B?dnFYbXFBZHduL2lrUWZ3NDFVdDZsaFhWbCtCaUU1T1p0OXpXUU1MeVFkYWtI?=
 =?utf-8?B?V1hLdXRPR3ZnRUZqajR1VjVYSk5ac0piWG9BTDA2MG1XMTk3QjduREQwK3Mz?=
 =?utf-8?B?dk91V0JzMTNqZ1hyZUxHRm5icVMweE9QaTVwWUdoOXBwZXN0ZTU4eDU2YzZH?=
 =?utf-8?B?MmdQSExuYk93ZXYzSU01b09kZnk5d3RSUXhrc1Rsd0diRTZMOFpFVnhSU0xr?=
 =?utf-8?B?clZreHhjZnNUdE1oemx1K2dtbG1JdFIxU3dTN3dkbEdUdlBqK1RPWnZ2R3ow?=
 =?utf-8?B?bjVtLzg4b2xoR1FRKytzYU5NajlCaEpKSVZKV01pREZUSnZpM2FKNmJndmNO?=
 =?utf-8?B?NDFVUW4rKzBiT0thRHJ2R3I2RytTTm0wS3RRU1hORU5LdjNRK01yTGZnaTNw?=
 =?utf-8?B?K0xoUkhVQzkxYlpXcnFiVU54YWppNFN4RGRDVDVkLzRSMHFwcDZxQkNlOGZJ?=
 =?utf-8?B?QytBU09HR3orUTBmSU9kU1djSWI5QUNxZzhpdjlqM1FHRjdRaXUxVVlhUjU5?=
 =?utf-8?B?OGVJa21RU0taMEpXQWxtdEhPcm1lNCtyTzVlekVONEx2LzNrQVM0RzljTldS?=
 =?utf-8?B?eW4yWnpNbUVFQlQwTU1PNnRiY1M5YlBqM0NrNTV0N2JpUW1NSW9mTVluNlpt?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d65ba0-a376-4add-b463-08dc89cfbbd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 04:34:08.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOhL+3eOD5LfHIod3BAFkyRrCbOMAYmUzPPU9yoWAuZzg9KCovTBhLCBHd7z4RhcBkW1u4WiVmHOgxHIZavskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

On 6/10/24 9:21 PM, Jeff Xu wrote:
> Hi
> 
> 
> On Fri, Jun 7, 2024 at 7:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Eventually, once the build succeeds on a sufficiently old distro, the
>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>> after that, from selftests/lib.mk and all of the other selftest builds.
>>
>> For now, this series merely achieves a clean build of selftests/mm on a
>> not-so-old distro: Ubuntu 23.04:
>>
>> 1. Add __NR_mseal.
>>
>> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
>> after running "make headers". This is how we have agreed to do this sort
>> of thing, see [1].
>>
> What is the "official" way to build selftests/mm ?

 From Documentation/dev-tools/kselftest.rst, it is:

   $ make headers
   $ make -C tools/testing/selftests

> I tried a few ways, but it never worked, i.e. due to head missing.

You are correct. Today's rules require "make headers" first. But
I'm working on getting rid of that requirement, because it causes
problems for some people and situations.

(Even worse is the follow-up rule, in today's documentation,
that tells us to *run* the selftests from within Make! This
is just madness. Because the tests need to run as root in
many cases. And Make will try to rebuild if necessary...thus
filling your tree full of root-owned files...but that's for
another time.)

> 
> 1>
> cd tools/testing/selftests/mm
> make
> 
> migration.c:10:10: fatal error: numa.h: No such file or directory
>     10 | #include <numa.h>
>        |          ^~~~~~~~
> compilation terminated.
> 
> 2>
> make headers
> make -C tools/testing/selftests
> 
> make[1]: Entering directory
> '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
>    CC       migration
> migration.c:10:10: fatal error: numa.h: No such file or directory
>     10 | #include <numa.h>
> 

Well, actually, for these, one should install libnuma-dev and
numactl (those are Ubuntu package names. Arch Linux would be:
numactl).

I think. The idea is: use system headers if they are there, and
local kernel tree header files if the items are so new that they
haven't made it to $OLDEST_DISTO_REASONABLE.

Something like that.

So if you systematically install various packages on your machine,
then apply the various patches that I have floating around, then
you will be able to build selftests/mm without "make headers", at
this point. Or so I claim.

thanks,
-- 
John Hubbard
NVIDIA


