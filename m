Return-Path: <linux-kselftest+bounces-1457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FF80ADDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A6B202FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC433DF;
	Fri,  8 Dec 2023 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWnQ7iGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142710E6;
	Fri,  8 Dec 2023 12:30:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVGECp10Ah6kopSza4DH4hJ8MhIkxEUNsY0wk5P7y9YPCzQUevoo5HHoD6ypC5jYrjo7iNrbbubQVcY8H01+cKc+IsgbCJeDQWLNkNYnY5ZVyJMgtrSOl8b/KZbMcqtAe+y0cJj0FWaW0rD6hHBRC4abb9eLvAr7gjf0dvTKJWql+cWe+Rmh4dGAjeC0Cz12U/U5ka+6zOoSAm6iSIUHhK2nguFL+p3bJ+QT6puzF/6YKgz45UyaqsEu1FoqK+xY3yNFmoHkufaUlRdyx10krn6VgCKmvZCfhdNiEHEWrBWppCobDatdsy3KPWYdvSUyB+8vobt7HPhfN8Jl15QxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXep31Vj7YsyaCiJHkYToC6i5Awy+k3YfN4DUeffgT0=;
 b=huCLRlWuXUEKYKcu857HzGsxOSBWwhdas4WVL3V5OdahOzRWAeM9ygGjSpsYt/h2NMSCtDFqjE/M6fOZTSb+AC/Aggs/JW+21QarQoKEsiK/8u5wq1cZsrGY9ZtdsHm70cqPJoFVCWxwKqlO13XEuUIl1HB7vGy+KW3vFHA17ERMMCKi0MBjdevA4ovI5r3SyzM0a9Wv7hL5+4HRMiuv9ReDgW3yD/8ZlnNRA137asqSYiU1ZbIciVZAb9uvrMSGWyjbalPD9IwvdUueNBEHdUYqWsxVbxpFQpxVps4LZbyg38lb4AUUebZ/4gwSKDPE4VZAlAuaOvwfDxcz+VeRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXep31Vj7YsyaCiJHkYToC6i5Awy+k3YfN4DUeffgT0=;
 b=KWnQ7iGoPdtK1dNexlsxDhMWnEF1iDartPxKpxmuQenWRjR7ufqX42kvwaZv1Cbx1ulNWzro4FISFPqi9BQLfyYjYekXEiWpJjHfLReNjxVa/Dnl24bo0Ki5MqkWNfNMo1JmRQ4tHaAxWx4fo4VSnOvmT8KnNLSFJhGFQcnVH/RY4pOuwjYv7pUvLSH5Ygf2nIRTpTDhcTLpLZIY4wQxBy6cp1pfdeqVWiGv7eInxs8/chZCdgK4xDnHuRdR6w0/YRxTNj7r0ltLQZkWCMsvEPHSFEDnltCHVsVN7K/j89fnHuziMOs9HwPJYARRQ16bIObdwZXKZCuEqwP2cUB0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 20:30:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 20:30:06 +0000
Message-ID: <c54b4059-e3a7-40bd-84dc-013dc3b15c65@nvidia.com>
Date: Fri, 8 Dec 2023 12:29:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231208151401.GG28727@noisy.programming.kicks-ass.net>
 <990feea2-c7a8-4cd9-8a6a-bc4bc1c2ffab@redhat.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <990feea2-c7a8-4cd9-8a6a-bc4bc1c2ffab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 920f9016-3763-4c09-7715-08dbf82c771d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/EwtO0Xzl3g98SESY269xqbl7F9+HZizzorrUf+zdtFL6eAt77aBT5XXb9zET84FMUjU9bSm+cFkyQWle6fC3p57q7jOT2WP7fWp94YNyRU2VQnM2Z4P4UXM35m9G8ycKUmEaxRjKEmjg8ICM+mU6vlL4GYMGfqdDm29s8zBTDJbAyf1rvgW6rok+JjuIBAPgEPQqVFLkEST0uMnHIO0HK29jWfMvkwmAB+DMKmUiJnY+fc1I4bQSsuiz3EkOCHiJjyaxLqR9uzXP1cSdrEKJ80c5xVPg9yCzwKc8iOpCzmDcCMpqgbvhnPBqCPRJxHiQRqaFkrm7Eq2M+WEEs+od1mYdaNwxdquuI4tz7dGp8xa7Zx7citWru98tEPTh5E3dpm+7dYpER/Q3qHnsfoykwud0lnfEmdyJdQJ/tnGEyrGmnOw5wItK28cieT8N2cuhC9EWaRyrbPVHXKAJpDB2+XxJlIw5BzlFYBDtj6uxRr2WMVHyQLf6kr1zl5ev43rwSag1Kf9pOmYBDRmLFXKWtrNMg22oYCw6y/hSgem78mwHp2HBHNZCjmZhJxeKNSUKT88wXfXB/ml7v28YFXVjH8UeRFcoD7G5Odzm0LN1StlH4h5cy61170ZkT0weE4UtFzovbEwb7Z2n9VwxM7GQY6Bq2BDbByXkfWlmNJcgnKAnxP+CH9WQRMCQ9aC5TOd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(6666004)(8676002)(2616005)(6486002)(8936002)(38100700002)(478600001)(4326008)(86362001)(36756003)(6512007)(31696002)(5660300002)(53546011)(41300700001)(31686004)(6506007)(7416002)(316002)(66476007)(66946007)(54906003)(110136005)(66556008)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFHZ1NBNndWZjBJQlo4Y3JWQWRkaHRvdXhnMzhkcE1SdnlKVUNUMitNWjVX?=
 =?utf-8?B?cEpKaTIzK0dGTEdkYjZZY0NOR1prRm9JcGlZVVBPUzdjQWs5cVNSOHY4NzRK?=
 =?utf-8?B?ZUlMdDVqRCs1U1RkNUdQOVBnK1dJeDMxbGNkanBvM2daZUJKbERraXpwMmcx?=
 =?utf-8?B?dTBnRTVlaXZhdVhSSjh3TEdwMzB2NnpNYkwyb2VaS3BtKzJaZWR6bEhBZFMz?=
 =?utf-8?B?dldlSk5zZXhBcGhNOWZjWFdES1oxMGk0MzZTTEQvMmtkZnlTSVo3SnordkNr?=
 =?utf-8?B?RlhMYytxQis4cUpTUUVjU2NkRHNSTjRiSG8xdVpHZUN0VHVnVWwzZVdSTC9j?=
 =?utf-8?B?ZGQ1TkNJU0hPRlNyY0lZVjUrRUVRUWoyb0NSQk9QK1FTVzN2NENzMVR2d3ZF?=
 =?utf-8?B?RWlVblFKa2hBOHZOMWZEVTB1NG1CK0h4U0J4eVVHNlRPczJVZDFlTTFpZ2lY?=
 =?utf-8?B?N1E3YnVmM05UN0IzUkM4MERJdFBiM0MrdVYvT01nL1ZQMXIyNjl6Q0k4Wk1J?=
 =?utf-8?B?Y2twZ1JVUU9HVmtCbSs1S3k3R0lzeXJ5WUU5Q0hzMk5XOEVzK1h5blkxSmV0?=
 =?utf-8?B?bHF2K015eTFpZzd2VjFiVUlUaXZTZDVwbDlONkdOWG1NbzR0aUxrOFVUQzRj?=
 =?utf-8?B?dUtxRk1hTDhQSzBzQ09INFFEWVI5UXlkUGlncDhhbDZTR3dwRi9NV2U0dFdO?=
 =?utf-8?B?NzJydjJ4YkZBWUNETFRRMlY4RmE3amtRWlZKNnovL0RMOWpJWXh3MUE4TmVr?=
 =?utf-8?B?WEdYb0Q4RW92aC9NNzFDb1ZyL3dveitCMjJRZkUzNnFLZlNrRTdvaHhYSlFy?=
 =?utf-8?B?dTNIZW9GVEdyM0tIQzdEb3dNM1V3NnZiQnRjT01LSEoxWURmbWMrZktUUDdo?=
 =?utf-8?B?RE1MUWxXb2pRN083UElCVVVVMGlEb1NCUGt3K25oS3pXNHBYRnZJUkluTGxP?=
 =?utf-8?B?UlhFeE9EakpTWm9hZzczR2Zqd3F2SU9TdFhrUkxYZ0lrWHphSmx2WUxYbCtK?=
 =?utf-8?B?NTczbkxHcG1YTEFxN3dOYWRWTnpneE1ka0gyVlNkK0lxOTRHb0Nzb21LR0lC?=
 =?utf-8?B?NjZnQkhvNVJjbklvRmJVZCt2dWRTMlhkZWRlQy9PTTdRQmVCNU9TUzBMQ041?=
 =?utf-8?B?YVFyNDZZbHV3VlJSWWx1d2FmclVxTTRFSVZqS0Zham9uSG1jWFIxeGVTci9C?=
 =?utf-8?B?djZDa0IvUEM1cnloanRFajI3ckdpRDdmRHR5M0RWRWZ4cGhQdUptRlQ5eWlK?=
 =?utf-8?B?M2EzVVFFWVZoNDRpcWRsZnpLakx1bUJJZW91b2p1dzB4Q2ZTWVdmMUo4Ky9a?=
 =?utf-8?B?M1RmWTMxRXFCVWlYVWllYllTcWJhY1lnWm5MVEFxZFY3Z2cxVzd6WHh0b0l5?=
 =?utf-8?B?RzBxWVBFY1c1UVNCRExWR1NlcnJKZjFwU3J0a2FMT1MwNXcwcXdkV1VnNE9y?=
 =?utf-8?B?Qi9VZnVEVmJFa01ZSWpxRFlaY1VpcjFWOC9KRlV0ekk3ai93bURkQkV2dytj?=
 =?utf-8?B?YVVnK3NFdHh3QVJGazJRVExxWDE3cTJ5MnREbzl6T0FXazVva1NDREdKSG1Q?=
 =?utf-8?B?OGRJbndFMFhURFlqNHRzK3NaOENzVjkyQkEvZlFZUnBTUi9IZUMzU3N0eGd2?=
 =?utf-8?B?RlRXb2xZdGpzRXBCcHBINkt4TmVNMmsvcWNxaGgwTDZZMWlYVW9ndGFvYXV1?=
 =?utf-8?B?L3lDbEdEMFdmM1lHdTQvNXM5dmcwQThtT3FUOGUxaHdZclJUb0VVWWxJdmhm?=
 =?utf-8?B?ZmpkcHpDc095ZGE0bUw2OHcrbnJsWmxPbGhXejhldmU2dTRncEtQVHFhejM4?=
 =?utf-8?B?b2lFQ091L2dWNW9tZkpvV3NkaXFYZEdOQ3JVNTNGUUpibnBPb1BQMVhGQmc2?=
 =?utf-8?B?YUUzbWNJbENGNGVVbGFGZm1kL0RPb2dxTDh1V0JOQ2YwYWluazNwM201eWkr?=
 =?utf-8?B?YkhVekwrNndyOEtiK0FDK3N5QXNzZVpHTWNCZTlYdkZVMTlsL2xRUGtyanYy?=
 =?utf-8?B?Y3VnZ3E0OGgzZ2JxN2c1cnNoejJlSGRmZFNTSVdKUkVJUG9aVm1hMFkwcmQ0?=
 =?utf-8?B?TGpEUHI2RDlPcmM2T1ErZnBYUnVEanRIVlFUZXE0K0d1WHZnY0U2eGtqQzlm?=
 =?utf-8?B?eVMrRjExaEJmZWdXWk1tV25IM2JGb1pxTVp1bEhKbTYwbVFuV3o5MFFLeUZm?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920f9016-3763-4c09-7715-08dbf82c771d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 20:30:06.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/29/XPAGC4ZlXw183CQfm0YHJtgdP6aVjk7SlVQIJL2qKxeLnX83vPprF1YDthn//YXudV7/oecfQCEms0gNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460

On 12/8/23 07:21, David Hildenbrand wrote:
> On 08.12.23 16:14, Peter Zijlstra wrote:
>> On Fri, Nov 03, 2023 at 01:22:54PM +0100, David Hildenbrand wrote:
>>> On 03.11.23 13:16, Peter Zijlstra wrote:
>>>> On Tue, Jun 06, 2023 at 12:16:37AM -0700, John Hubbard wrote:
>>>>> As per a discussion with Muhammad Usama Anjum [1], the following is 
>>>>> how
>>>>> one is supposed to build selftests:
>>>>>
>>>>>       make headers && make -C tools/testing/selftests/mm
>>>>>
>>>>> Change the selftest build system's lib.mk to fail out with a helpful
>>>>> message if that prerequisite "make headers" has not been done yet.
>>>>>
>>>>
>>>> NAK NAK NAK
>>>>
>>>> This now means I can no longer run selftests, I thank you very much! 
>>>> :-/
>>>>
>>>> root@spr:/usr/src/linux-2.6# make O=defconfig-build/ -j64
>>>> make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
>>>> ***
>>>> *** The source tree is not clean, please run 'make mrproper'
>>>> *** in /usr/src/linux-2.6
>>>>
>>>>
>>>> I've always done:
>>>>
>>>>     cd tools/testing/selftests/x86; make
>>>>
>>>> and that has always worked
>>>>
>>>> Now I can't bloody well build *any* selftest or risk not being able to
>>>> do builds.
>>>
>>> This change landed in 6.5, no? And 6.6 was just released. Just 
>>> curious why
>>> you notice that now.
>>
>> And I hit it again (different box etc..)
>>
>> Can we please get this garbage fixed already?
> 
> I'd suggest to either revert or turn into a warning.

That would put us back into a half-broken sort of situation, though...
see below.

> 
> @John?
> 

I don't have a strong opinion about how this should be done, and in
fact I believed at the time that I was bringing the system into
compliance with what everyone wanted here. :)

There seem to be two conflicting visions:

a) The way it was (much) earlier: use ifdefs and defines to get by
without the latest kernel headers, or

b) Requiring recent kernel headers to build the various selftests.

Shuah, Peter, others: can we choose a direction please? Either
way will work, and I personally don't care which one we choose.


thanks,
-- 
John Hubbard
NVIDIA


