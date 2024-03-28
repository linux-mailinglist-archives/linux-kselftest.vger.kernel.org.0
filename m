Return-Path: <linux-kselftest+bounces-6763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E5890732
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EEF1F24927
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1281725;
	Thu, 28 Mar 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oiqg1GgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A742A86;
	Thu, 28 Mar 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647000; cv=fail; b=c0istSTnw/vspmt8kG4CqHBv6esYz1/y6as6KfzSBHvHC+NtVerdT34oQikkqhMrakZCqpOjfMsQqBQqwuRY1xunevss/KqYY1GjWHkABStYwj5XkdOAyqjnHWIJI/M+VY1bOj8UDrADvfUTIY3zSVl6foDedPvklGzn+1dSI/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647000; c=relaxed/simple;
	bh=fRVZ/0TN21qQ5mIeRyJoawG2z2CSHMFXDCMLy0+nflM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOBerZc6yhQyBcWtSUR9+kEmj73NryNdVUnhFODY17lPyfk2HtECiSYxmQ14TUveOQD3l+b+XQbONWVIis6Ob/6pffglZFJVQqW1CHo9j00CyJ3tOgsBJtzogju+O2193eNg8g1m5g4kDu+ENX9VqcWrJ9YptAaRbEdhLHHh5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oiqg1GgN; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmH0HH6lC10ZIUuDx5TxZApVSYIBHjefpe09flusfN1kewK8FjZOKo/I0mka5nSWhxKsJxR0hn4cgpTLO96jTinFL0JFARiECM96fFCsudHeB4D7fPhx2gUmoSv6F/f7SJ4km5brDGg5xw/e8D1KZ6MJKQM4RTNCOwRfS3DXZKTbW5p3+fNILwnZbZLT5sS4Q5RPKfedYyd/Tm/sztgPpPsChnidFQuE+ThuOimC/he5rUENcZ+rk/xFiftKqBfewHr9Grz3RHiuBOc6SF1iICgV98k0DqA7d6EAfkmhGlyNo2PSHBFuZcreRKmk6T0M3Jainm8XidVFSPfvELxj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRVDdqkRE9u811TlxFnDjKgnALbB0yjT3536hZRI8LE=;
 b=nFftzH0Kb31DXJqW5+apSdeg6NINSPOqVjWUDW39dEPrS6rkE5FOQK0IRiggg/fQXQayZEYxLuhIcy+lOYmsWgi4aTNFIJClHvs1I+dTVCC7592wGzLuBsSG2ysmAxMqxu3/gpbKW2sdmld03MnUf2ihybJ1R9OateWmYbhAaU8DpEvIP8i1gFE02SYhMwo/vJJeFw1JUW7BGP7FmK05F1REcobgmUuGS6wANIditYk55ex0ZE3jTjz9QMOmgMf0jTvMFYPZkbAN9xk3Fh+yzTyYZ52vEJ3tsLQ5o7Ba2hRoy+EpKr9SJCb/BdcA8PP8tvo4gQlyMcAHXw6nwsGomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRVDdqkRE9u811TlxFnDjKgnALbB0yjT3536hZRI8LE=;
 b=Oiqg1GgN9ssneohjsqIQvwO7qxD2lepWeMQx9lasMCILN83wgliVkGxzHL36q56/u8o62n4stCXiRzQuFAQgLrwAPD+L5K/JMyx7BtBaWlwAtbYZ745Er5ZR+oRfC/kl2b7x0lgdLcxgPdu0cQpVyE9zYAhkHV/G936x0hWx4mD4B1rWoZiugRiM9P2TbQW9wYTk+Cs9bIl54HSND1DneXIsz9/2ZA8R+6mZwB9UCpcyforqUZiWaRFoFMi8QDFN5/KuwYvFm7snFPBiTIVU736YkvtiEwAS15mK9GjvY+UkuMBIDvtRRVQXP1OP8jKo3QPqQhBVTTivU5PDRfhxuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 17:29:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3889:abf7:8a5e:cbbf]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3889:abf7:8a5e:cbbf%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 17:29:54 +0000
Message-ID: <834542e1-bb29-49ed-98ee-13a79168819f@nvidia.com>
Date: Thu, 28 Mar 2024 10:28:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix selftests/mm build without requiring "make
 headers"
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Guillaume Tucker <gtucker@gtucker.io>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
 <6d82298b-b17b-440a-beef-590177d0ff50@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6d82298b-b17b-440a-beef-590177d0ff50@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: c4de883d-cfff-43c9-2199-08dc4f4caea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K0ANV4ao7aCyZmGrdgWewnGQUsdLhYy1BbW/PfpmsjTfGvXFzEZMFc8/BshS02A2Imjrq9oy3WLPF/1aNWHNvUidPqKDWkaBXG0mLDfB+nnaPdtUEwNtjDnonjnFyafjBDy+TTB/xKZjqIhz3bPRXoDHvrQIPRW/1Jrc7aM32HDXjoXopQBco9XSrkcRs316yONPSBkZAdQGRKh09lPrEvVGkizaiQfoncBQoN50Vbqip7hRQtNhfXywWF9hVfTw3F89K9n+nEIq42PEDPDMPrvFI/OSTcJYn3DzslFHhdAAyFkcj8h/QhOCAcEu8SKeUsnl/szYIu5Qvph3xScZy8E+6dscgin1rKSAxINobEUsifT/FQGNuBtNZVTUSN5yX07GXT85ZcTMqHx0CBaDsbI8QB6k+nNIrPv9gKXpgndHfW2YFVyE3RGv+ZUc+1YoeTjCRzEntc3BteQylpivnCJLJVcob7o0RCNntCbKzJQ3LGEPWcTHU7gJ4nyx1cexfjiYkGOUSfxsKrqzDAGgMtD0MMZ8hPUYf1INThpMYlCEH6/ivVRxrnNZWn9H+E/HgP8uqRC0JViMyMHCgb9cF1dnDvMwe9lSfKEsV11h2igP/aJcOdrUhIJEJJjSwqZaaYJNA+vTFQ8CWOlIKzBUrfBGQxgn4XT0JJJNEbhb/Xk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUtQS2tRY256QmVyaXpwNS96K2x4dWxoMHdsOVpkb2t5MFJwcGpLUllMNHJ1?=
 =?utf-8?B?ZEFaRWpJdFNoWmdFb1piQTBXdmd5enVneEEwYWc1azNSTTF5eHU1TTlheUhz?=
 =?utf-8?B?Mm5VQWV1ZC9lSG5KQnZaMmZ2UitTQjkvYW40NnhxTFFpczU3aW5NME9IVlhk?=
 =?utf-8?B?dEgzcTY3Y21iQk9JRHU1UzFHWDAvR1AyVGxkamZPWWhoUEJPcTQ5dGphRTVP?=
 =?utf-8?B?MUdYS3lBOWFpR2d2bTdYQzJjQkZVSGxXTVNvSEt0QzNOak5MWHI4TjdnRW1U?=
 =?utf-8?B?REVrRVd3L1lqbkJoR2c5c1R4cDdOUVJnVWh1Qkh5V09Qa2ltdFJpTkVmUURn?=
 =?utf-8?B?SDZLN1VPTnhZK25Xa2tVeVpua0IzVEdEbjR4N2RQK0U4bTI2Q0wzNk44aGUz?=
 =?utf-8?B?T21jOVdxOGNTcjhodkdFVFRDbWhPVEF0cDlVQ1JKMGhsZEFSc2RIQnM5b01W?=
 =?utf-8?B?RS8rL04xbGpYV1lic05SeHpkT2dXMUEvaXVJenIySHlTdEdFQjQrdnhNZWls?=
 =?utf-8?B?SGt2Uldnc0Nob1R0Z214alNWTDZnS2NNdWdPUkx6TThYWjJqdVRqM0I4b2dQ?=
 =?utf-8?B?SlF1SW9ZdE5Kc0k3c1ZQKytNZW1reUpiMkN4Z1gvNTU3Mnh0eXAwcEVSVjJE?=
 =?utf-8?B?L1hhK3JOQzNlUVpNOGF3SDRZb1dHV0k1RytKelM1NU0wOGt0SktCMEM4cDFI?=
 =?utf-8?B?MXBOcnh3R1RvK29Id3BGdWg3SEVJM01kcTA5YXIvNFJCdVJPSktaSXhlbkhX?=
 =?utf-8?B?VHpKOW9aOW1lQm1VcXVmVVg4V0JTSzBrVjFETU40Q1MzVzVSbjhWODNJUVZR?=
 =?utf-8?B?SVlaYVBWRDMrQlVGMEFDUVBpSXFsR1Z3UmdrZjFpWkhlODBudUJET29nY1VZ?=
 =?utf-8?B?RmhmRjhRQXlTVnNtWDJrbEpEaFVabmRMWHhlTXRrczMvM0R4WGlCb3VvSlM5?=
 =?utf-8?B?QnNpeUxnejF5ZUpJY0JyWTRrY2tZSVV3RUljOHcvREpFdEpDZTdKWnJISWM5?=
 =?utf-8?B?RWpqVm82UDBtN1NITWxqdFlwY0s0WGxoeU9wSU5UMUNPb3JRbVRONTJWSGxK?=
 =?utf-8?B?aFFoQWpyOXA5Y0FmN1FpTzBtREVxSWs2ZGFJOGo2Vzk1QUR4Sjk1WGZHbmdH?=
 =?utf-8?B?cEZDUUlQaGg1YmdxdjlGWGtld2R1c0ZDQXhOejVERTc5b2tnZVVOek5DOWZN?=
 =?utf-8?B?clhzNWM5SVVIWXdzdzBYcVR3RmJpMXpWeE9FVS9GMm1lQzQ0VG9uM1VmU1ZS?=
 =?utf-8?B?MjFhcVdpWWRMVy9tMGlqU3MvL1JMMlpYeUFIOXlZNGxxdUJteWJNTWR3cmxz?=
 =?utf-8?B?K1ppeHlxWlJRMlhqQnZmcW4yR2hiQ3AxaHFwdmkwSWllRHN6OVUrQS85dEsz?=
 =?utf-8?B?VDRTdjlBNE14TjRVN2t0aVpuNVFQdDBxTHhtS2l3YVVXNUJ5cW5KSEcwY3B4?=
 =?utf-8?B?ZmlaOEhKMFZJd2JpUmp6eXFHU0dSRzdBMnlFVWxPSEdvdk94TStDak9GandK?=
 =?utf-8?B?YlhxYTNVR1FIYUxxMHpjV3k3OXRxMzF4dTJBVG9LTDArWStsN09rRHlrSmR6?=
 =?utf-8?B?bENDcU80RWZSZ0NUeE5DV3k5aHlCMG5lOFhSWE5pL2xERDEyNDdSc3MvbmRk?=
 =?utf-8?B?ME1PSzFYTFRldGxFamxiYVcxY2tsSm1wWUhLTTIreWdlQWVML0R0RVlBVFNp?=
 =?utf-8?B?M3NaUUNUMDRtaVdrS2ZvNy9vUUdGclI0QkloK1BXWUhTOHAzdHl4eXZQVTdp?=
 =?utf-8?B?dTNUeE5UZi9kNU1RVS82WDRTODFwVHVBTmtjOTBsQXZ0cU5mQW9iQnhJRkVn?=
 =?utf-8?B?bCtXYVVON0Q4SXhVV0Z5Y3lEa2VORWFsWXFFNTN5dUc0eElhb2J0UGhkVVdR?=
 =?utf-8?B?VEN5UldWUCs3N3JPbUcwUC9QeC9OVUZ0a3MramVFcnJHNkNtMktuRXBJb1JE?=
 =?utf-8?B?L0ExZVJydy9SNVplcktZWjZRZXZPaWtHa2ZmN2gwNUY2ODg2VjRWeWdiK1VX?=
 =?utf-8?B?NkxvRFFpNXZtMmpaN1dxOWtoc1BhWmFacXdodm85eDVhc3l1SzhhajhzL004?=
 =?utf-8?B?Ry9rd2VkL1FLRUc5c0hwR0tEMWVKY3FEN01IQUNpdDIyZW9ySVM5bmFrTGVX?=
 =?utf-8?B?c2k3Um5LdUx6eHh0MHlNemFBdEJuakk1MzYyY0pudXdqRUdBenFNeWRWV1M3?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4de883d-cfff-43c9-2199-08dc4f4caea1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 17:29:54.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pepeeygQHwRWjBbKqKvmyLXB7r/Oy3gZsBfHnGtnuissL4oXaX95Yo4psCikZJBpqOEFOG2m1TIBDFDZgbtNFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

On 3/28/24 2:02 AM, Muhammad Usama Anjum wrote:
> On 3/28/24 8:34 AM, John Hubbard wrote:
>> Hi,
>>
>> As mentioned in each patch, this implements the solution that we discussed in
>> December 2023, in [1]. This turned out to be very clean and easy. It should also
>> be quite easy to maintain.
> There is another way. The headers should be built automatically by make
> dependency. The topmost make file always builds headers before building
> kselftest i.e., make kselftest
> 

I think we talked through this already: Peter Z. pointed out the problems
with requiring this kind of prerequisite. And it really it overkill. The
approach here is simple, easy to maintain, and avoids breaking the various
unusual build setups that people have.

I'll shut up now and let others weigh in, though. :)


thanks,
-- 
John Hubbard
NVIDIA


