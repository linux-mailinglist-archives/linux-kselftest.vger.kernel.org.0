Return-Path: <linux-kselftest+bounces-1604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA0480DA42
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94780B213AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912DE4776B;
	Mon, 11 Dec 2023 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHMet1mf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34A9B;
	Mon, 11 Dec 2023 11:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDLWIU2PlQhmLbUtQH3Jwm+9KzNCrJgM2W3LpS2+Csi9ETqJqsIa2XbIqMv7OauVt+BPNnBNTYgAM3e/u+s4/IiEirK0FcPte+x6AWw8PDCy5KJGpLYi/H86n/ADuSIpndZvznD1pyn425YaGJgIEJnTOuvgHCuN48icwp6zVt6GVmqnz2ZtZDoo4V/wco2bL3R8re43HE5PftI9u3mvKkv1YCFcIElYK5WeoyWBmwg0f7CEZ53QI+XzBCE918L6+6BEE+PBBPmiFUBnQC5X+lfjJfWdMIR6iG0nyZKgEo/HicRVTbp7ZP/+X0CHozuB3Ukf8BGUHeinRHKIxaQkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quix6r8g+blM8v6i7ap1h5Znw2DiJAOohGlfoy1NGcs=;
 b=JAZ2++0URyQ8206iDKLU1OTYMDKA0GtVhN/ETahTPY6EkhRhCZJ/b28jReSyYp2vq7KJYv7HAwH6MYAoSEG8blEcYRYTKe8juw9hxSyA4v4SyWcrim70JAhg20u12DACKtgQC8GUVdhUScxQpM/vp2m6whIMEAge7IozPbFa08akztBQvr5P1vKEsPG1MrsiRXuC4CXZOQfTS6r9NebsHJA4nJfdPHKrMIjLvu06zmyfPEhexXFOI8Rap+Gw9c6Ugww0gPlow/Df3ZUfxp1fOk8F8nrdY7EtogJWUXhnfcDV5774+Q2TViZEsb9ZeHnHI8n0+cQhWSgE5ovFAH6eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quix6r8g+blM8v6i7ap1h5Znw2DiJAOohGlfoy1NGcs=;
 b=hHMet1mffviqJeRUxD84m4l3COdbjjkmDlUU73ZO+QRrslp3zoSGh7OiL55P4Qf35RaL9abhVa0GnLiuFRBzGRihqP1kmKPRcdcjkFLDVvxKbfvkjtxSpmqq+w8Rara7jjS/DOhmVYhUkrjnJIa+FH9LP+rCmEtsx2CxctdQXdOr1iR6FBmvGZ86O5ZpjcFPmerJ/id35HCox2dGryi3+NAfQfLGT2t4MbsL1UwSknPI6w9MZTX89pb3RY2G3ksz1TXSUjN5TRBbYhTpj8IqzeWyM0xco7cY2VkZJ8VyazRz76Z2X1dSTi8ma0G9TRaiLkTnsDUS8sqCOtkEn3y8/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:01:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 19:01:06 +0000
Message-ID: <cf4e9f8b-7d31-44d9-93fd-1677918b56f4@nvidia.com>
Date: Mon, 11 Dec 2023 11:00:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "selftests: error out if kernel header files are
 not yet built"
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>
References: <20231209020144.244759-1-jhubbard@nvidia.com>
 <0b35fcbd-ce8c-4c12-9725-01f18ade9fc0@collabora.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0b35fcbd-ce8c-4c12-9725-01f18ade9fc0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8849cc45-5c89-45f6-f62b-08dbfa7b8745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+tkpqQb0ZzMcHqgWBqBY2LkVL6KNxoylOwzGVEoNQaMERM7bPye9ZVHc6TEKTPp4CWUZ8hkknkM/xMjKE7D3b1zjbQch+rFb1TC2ajitiCukL1re3bmSDN2ndOz3ve4i1GINIEo5qOeDlGY1CpVLMikNl/Q8NhIKBJUvP64XEttem8tONycn9AwRj79p51JeMD5XSy4buDAPstMh3FXpDqxBMpOrhb97gnHfhGUt87XCiHjrdDPYJEhMAz6dZC7eRERvN1wRTZxCTcRDBNObhmAzt4/0dMzpn3Fm6VrEOrMKLX6LqqUkXdvlMyWIdElg78q6Ax5y0z/uR1ptCu3YahvuP6NpUyJc8iOKLuN1yuXW0DDe5CzZENTA3npwU/w8iO/5mSTA2zGehkj15/FxIu+5AQjmMjIkx0C0+2tlti5GUX77ooH0Ku3xdYLjwyxXAx5/GiA+QxV0/ToeQEDwHfKJnqH/gpve0a4CuRTvkykSxZi+L8vIkEc8BFQnxLrIb4nNg/vntRXNx1mG+r1Hi60E0h3B5OOw677mp1HbaP7yCSUrzFWI8OsjyvPzMHUdBoE+C5xw5uBefRsLYFcDeM6nbqKpFpNzuiv33LbTL40SV/kTUOT0CPgahhwR2fSTmnoqNB7ywAcYpBKaG3mA4QOuS3U96obZe/a4cPSURaBgm2ALmlWc6MJHA4eYvvlnJjO203sqEb8JSUCaZWnCBmCbKNXMIdBHYr5Wl/RaKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(31686004)(41300700001)(38100700002)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(8676002)(54906003)(66946007)(66476007)(66556008)(2616005)(31696002)(110136005)(86362001)(36756003)(966005)(6512007)(6666004)(478600001)(83380400001)(6506007)(6486002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdKN1lZZzJKUHVDeGxxcEJsWkxUdFRhV2lGWVhXT1dBVlpYVzV4QlAxRGhs?=
 =?utf-8?B?TGJqc3NuVEN3UGxRWUxzck02K3lDUXU3V0l2T3g3K3FSaTdEaEdma2xldlNF?=
 =?utf-8?B?WUplWUdaQm50ZU4wSHM0Q0t1YUkwTEhqcDVMZXJqT3NMcHJZRzZMV2pPZUpQ?=
 =?utf-8?B?Y3JJOW1uSmZvSmdVb3ZRUUg5SFdzL1QrSEJRTmRHRFF2dzJ0NDBvTGl2VWJI?=
 =?utf-8?B?anY1eXM1N09nYk0yN1JQeWZmQWQxMERQUDFkUWRwUzFxZ1RUNzd4em1ON1pw?=
 =?utf-8?B?SXdWZ1ZsVHpTcExSdmt2LzJxcUFYZHVFRlFtNDZ6V2w3NmFVK2FGMWYvc2tK?=
 =?utf-8?B?MUU2Y0FsMnlSQVZUSy9yK20wWDh3aGhzcmFSenBUemk0cWNTcG5CMFJGN3FZ?=
 =?utf-8?B?bC9lMXBHMVE1TFUyMkZpZnRGWDFibXoyakxScXVFUXU4RXcvc21HdFhQMTZC?=
 =?utf-8?B?MVRtNHp6OWkrNlV3VzdieFRGU0p1M0VsWXN1SXcxVVdjUUNrQTJPOGZVTC94?=
 =?utf-8?B?WTRMMFJzRWlTRmpJK1pRaXVDS0RzUjVMTk5PQU1FVFJzNUJGQ0pVam43ODQz?=
 =?utf-8?B?RnBXTTEyTUY2U0RhZ1hCUGdsQXllRDRzRWIzNE9YN1dpbXI2TEpOT0tvQ281?=
 =?utf-8?B?SW1qeFkzd3RHOVBtd0YwOEIxU0xhQmFvNEk1WGhWSmlNZkhtaEFBVHAxMjlu?=
 =?utf-8?B?Q090dFUyRlFEYXFDMFR5VFZsNVY4K0NiVEFJdzlBTEFFVEY5NjRmN2d2ZkVr?=
 =?utf-8?B?U1U5TkJhNnRnOUxQamZFc21meGUxd1lzZUdPTWdwQ3ovTlkzVmZlWk1ocGlr?=
 =?utf-8?B?bmxSWnMvRW9KSHZ5NWlTaThwc2I0RndyQVVvSW54bWZuTnQ1Ym5IOGwvMTdO?=
 =?utf-8?B?QkpWdVBjQTBodHkxdHB4d281Tit1V0QrTGtIUlkreVdyTWFrbXczR2JzMW5E?=
 =?utf-8?B?ZnRkanJlaDdtZ1E2bG55S1NUSkc4Tyt3ZmVaOFd3d3d0RHMwOC9ZZkZJRlVm?=
 =?utf-8?B?R0hrVTFndFAvZ1RPZDNOMmNZZVRoRFpXdGRDZ3NHS2tJYmRSOXVhUmU5eTNB?=
 =?utf-8?B?akZtSWZVU09OZGNCOTF5dC9zY0dVdFhIbENCZ1VMd0ovY0YwcGlZNWs2bjNX?=
 =?utf-8?B?MG5DS3k4TmMwNXVMaTZmZCsyMUJwY2ZyRGxxcDU0Mm5RNTVnWlRzLzk3aDdC?=
 =?utf-8?B?a084YkY4ZmJqY2lnK0kzRzZKNVIwQjhoenJxK3JpS3FFV0JUOERsaVBSQ003?=
 =?utf-8?B?NlZlWU5ETUtyZS9sRndYYThvVnI5VTU1S3ZzWEU0azJWc2FyMFVscHNvVDRm?=
 =?utf-8?B?aEk1ZnZndFllZCthcmxhNloxMkdkeVJvbGlYbUp3QzBJTU5rWDdJNStMQ05D?=
 =?utf-8?B?WUd5ayszd2pDRVJFd2Uvam9rUE1hc29VVkRNYUJDSmtPR2haWm1XV2VWLzNB?=
 =?utf-8?B?MU9vVTRFZUwvbzJRVXp0MTJRM0dCTFl6L1F0YUliR2hTZ1RKQVlwOS9VVVdr?=
 =?utf-8?B?SzcyMGUrYmp3dFovbFpMcEpYOUtFcEtYRVFCYW9McXNJVmpFS2YrdjArbVlL?=
 =?utf-8?B?U2o1eDluOEJKaktsVk9UMWptN0xtM2xRRlU1bU03YXhRdXozeTdUbWNZNkRn?=
 =?utf-8?B?YTlqZ2dHMzBEN1AvNERjMStoaG9TTWRaYVNqWUd2TE9MOXE3M1VpeGhZN0Fi?=
 =?utf-8?B?bHVSQXkrcmNkUngwVjI5amdTN3krZnFEY3RqRGNZVHM3OW9KdGZDbjhHMGp2?=
 =?utf-8?B?RmM5b2VmN0FDYWJZcVpmRmppR0JFbXJzYi9UeDJOblA5NjVGZUd2cldEQnRJ?=
 =?utf-8?B?NElUY1YrMHQ1YXdCU2szV1RJV29BaS80ZDZvVk83eXZiUmZicTJmcFQrSkVH?=
 =?utf-8?B?WUg3R21oRmM3WGdTaDhJM1dNdVY3U2Y2UHdLSHowKzJjbENNeFZVbEl6NUFu?=
 =?utf-8?B?ZGk5NzVUTjUzblVNRHJlQnhZeXpGUnNHVVk0ek5WUy9VaHpRdGlQNDZHVTV2?=
 =?utf-8?B?QjJZUXJmTmZPOGd4Qnl4Wnl6elI2QUthTFI4TEZDK3E3aTgxN1dERVQzREtT?=
 =?utf-8?B?WFhsdk9LUUs2R0VLV3FWQW9qS0tUdFNWQi9JYzBBQTh5TGZUUGt5YW1wYjM0?=
 =?utf-8?B?b0xHYTh4Um9VYU1sSkhDYmcxODhPS2hzTjUxeGZUY29sSHduOTRHb2JTWEY1?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8849cc45-5c89-45f6-f62b-08dbfa7b8745
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 19:01:06.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQJt8YV0Dn/VoPotJ4BlX+c2jdhQtIbCGTwlbIvdJRfqesi4WCy3U9eG5CwDqPkl/HHerQH8JBK/bg3o4l0axw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On 12/11/23 03:00, Muhammad Usama Anjum wrote:
> On 12/9/23 7:01 AM, John Hubbard wrote:
>> This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
>> files are not yet built").
> I don't think whole of this commit needs to be reverted. Lets leave the
> warning message as it is and just remove the condition to abort the
> compilation.
> 

Hi Muhammad!

If we do decide that "make headers" or something like it is required,
then yes, this patch should be changed from a revert, to a "warn instead
of failing out" patch.

First, though, I'd like us to choose a design direction. The patch as
written is intended to put us on a design that does not require "make
headers" before building the selftests, because that approach would work
for all the cases I've seen so far.

If we want something else, then David Hildenbrand has listed several
ideas, and I've added a 4th one to the list, in [1].


[1] https://lore.kernel.org/3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com


thanks,
-- 
John Hubbard
NVIDIA


