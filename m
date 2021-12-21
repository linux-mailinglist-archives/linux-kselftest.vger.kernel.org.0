Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8302A47C8B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhLUVQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 16:16:28 -0500
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:32595
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230326AbhLUVQ2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 16:16:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgFQQvzkNFk36+yio/wcu8EJmEU2PdayHEVMEDXP8Cz5PZuIg1jW91xsf5fUJ8WcR1uFBJyh62+KyM/SE8hxV5hmjJEtr/8hmdiT9El6pmGai84/EdN7lj5Lqn17pBMt5lnvwarpjQ0jYBwWdGQPrukWHWPPDjVi8aaJYO8RXTMYUul4WHGvXzlO1ppPOywJCFKLOTnRIM+DjTsz+938zVFKA4gsLjcdaJ2PekxOIJJOm3Ks3R/P2j/pSSvuNCto+KnJLJ3hwOez1f5MoE6zOhldXrM7IN6KXRFsippXyQEfrfs4s3IIEDN70CfJO/NhDk6FjuSTWdzafTXQavmrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O6QFM/eAnnv9JABI2QoenOGX46iZGipaGRZDeAaOFQ=;
 b=Xj+fOJn/ypqiGSQjFRy/hYyJWLm40G4f8/oA9ZtelTocD3uxTTHt0iSh38KhKqh9aT+T8qMLgMF9AyMVFCAKnk/7EJXtOfkV6fWt/56bcotTBWnVzpPVbLUuSPm/eADRo4ku74u6ozCkcK7XqVFrYGhPdWRGpKVLyqIufei3aoVeN6pc89TwzN/UyxPIHryZCn+YMWr0ymM3ZMOc4lnAkhcd4tbSheAl0t0MzPy2aiWxvxqQDVQ1dBZ1RlhsiVLeG7gFWtEwk/a9085sDJ/TaRZNY56xpirzn/2WL0qUK44sVleW4uRuNTxEm+rbzXMMxncTNRS2XbaDazZpeCTryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O6QFM/eAnnv9JABI2QoenOGX46iZGipaGRZDeAaOFQ=;
 b=JOAkEZnt6352IEI0B6gZpMLZePlnpyLK/KeOKKO8zdAwwR9I65jCKsj8ZTEDjTM4ZYL4bkNCLYN/HNxHKTsZkz8qqycBZCo62J/HZqKB/ev0nXhnelz0U5xSL01P3G499rY0T/dzEaONhsAws6IOo6VQDoZGQAUvmejDZbZS+sbu/wD0kZ5zX3epuYrWAvqwJLnpLh/LNHSeDCHkn2xDer7KygdgnGBFkR7dlVL3EANeyDmEtD+++bgC6gK+dMthjz+yI62caZx+aEdzUrLQL/QYf+/J97XpEt4ERW4SVTDaydr9kkN6BED/LYvEutI+JqOCPlO7iR1wRSy++g6vAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3142.namprd12.prod.outlook.com (2603:10b6:a03:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 21:16:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 21:16:25 +0000
Message-ID: <3eb81a1d-a5fd-eb76-d23e-0f6998c647e9@nvidia.com>
Date:   Tue, 21 Dec 2021 13:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221180705.GA32603@quack2.suse.cz>
 <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f96fa1e-d0ad-4506-5048-08d9c4c7255b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3142:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3142C94A6F8AA266D8987991A87C9@BYAPR12MB3142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ+2YWVX2kZUsT/K9l28iv7C7/1RKdWKkrrfCWqIq7ZFfT1ERspofq3s5sng9dimKwRGrtmXC+S2TrGEk5/dl3c0gv1j2sOB673gelobjFcNkSlIXqxyo3iEPjbVT22ktdM1TZEM4bUpgEwQEqrvYzuEp0IRMmgD63qYXZYKkSCEeFcpKYXTj/xoqdfCcvyn8VW4SUK6PfCK1w64+N//+biQSnkOC/P1M9fvWoQgLRCcXlfpHMBDdDa7k5LOhMNL2Pm+nLlD224zoMldPxqCTUONqcQe1o/OEli4ZA/vCezQ4wdRiNqKxb4f3G1ByoB7Df5ZhGLbgYcFz3abjkRNv/3dPC1Zsw0qawTVpaxDVXxuqAyrAhgEjIcdAyvcVuNB9Y6dQVJonQrlcHO189p+77En4CkHBwTU11i1E9WFGRi8GC9cwaL8wGeCm1hPmXy02Y4/YH/Aubtr2S7fPEywXOIwAjMPvHzyueeB8qnzG34Bf2VfeOygD9x3j3Mk8gbIcVoH68UBkAIFhEovgCrFexPMOpx8kC0VNWr/S1En3LPRZCwbQ0Kcv4HVv/I3U1Hkn7jhzdwle78gipUkc58UgMIfPnwwqADa6H4PM2uKkvNGNu2pgEt+VpCzl6JrWKgYc9yxn/YBsrnIE8TbdcmDnf611b+PZCgknzys0PDGjwUec7dJ68VF08wrNF7+lSyAxX7IaaFGLVOoJdjQhQNdU6K0vakUAFhpMrK8OIXm0SkPMjVNs+tL3GOXpKiVnpLyE4suY0NOXNGqsbUmcFLW3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(5660300002)(53546011)(2616005)(110136005)(54906003)(86362001)(66946007)(8676002)(31686004)(6486002)(66556008)(36756003)(6506007)(4326008)(31696002)(66476007)(186003)(26005)(508600001)(316002)(7416002)(2906002)(8936002)(38100700002)(60764002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVFYmF0eU5mT3ArK3hFdkwxQzdaRG44TVdpMEo0cGhNVGhGKzVPT21MdU1L?=
 =?utf-8?B?ZnBza3Y0RmVyenU1VlJrNWVnaFRVbGFwWkM0TVpXcDVXTDhmWXY3V3krOGZB?=
 =?utf-8?B?OEZzVjUxSjNCWExsT0E1UmNIdUdoTXBKQWFJbkdKTlZYNnNLM09kdzNjeFFl?=
 =?utf-8?B?cW0zMlQ0Y3A1ZWNyU25hQlowcytPMnFwdmRwTUlFbDJUSWRTTmFqeHRqdUl3?=
 =?utf-8?B?aE5SWmYxbVl6eUFnZXFoYWZycjdvZXRuaXRGQngxeW1BcE1lZlNNc2p5dlVW?=
 =?utf-8?B?N0tJWXBlbCtaQnRCcjNQWXVqMFNCQUhMbWU0dzRVNlJCcVd0THlBRnNCZmtO?=
 =?utf-8?B?MStXTTROL2NxY3dONVBveXc0L3B3MkJSb1dqendwdHV0czFDbnFud0pIUUtB?=
 =?utf-8?B?eTBWRkhOVDY1SHhiR1RKVy9BbjU4RW81SkJkSGxETXZyemllYnhjcFZnVENi?=
 =?utf-8?B?Qm9qSlM4ODZhQUlNM0JodElESVR2RWN3MkZKaXNFckhRa2hYaDZ1aVlrTW1l?=
 =?utf-8?B?VG9pdE5YaDQzTUFTWmdXTFhaSkFNOUl4ZTJvRUg4cWlETlRyZUNFQjhFVlNv?=
 =?utf-8?B?QkswMXZncFI0cWcwclBGSWZTbnBmQ1N1eTAyL1dlNjdvS3pwUk9GUkhyRGZ5?=
 =?utf-8?B?RVAzM2I1S0YxbGJmcHVkWG1FaHNMaE5SWnZxZ3F6VnMwbEhnZEZGUzhqbCtG?=
 =?utf-8?B?Y0JZWGwwWEM1WE1JN0Y2U05KdHU4YncrdWQzZ2ZCOEN1RTRaN000bWJkZUlh?=
 =?utf-8?B?Z1Z0SDdlbkpwN2cvZSsvcmw1QnJVd25DT25VN1ZCU1JRVkZjRVhURGNWTmwv?=
 =?utf-8?B?UHRlWlN5MFRMd2tVdjBYSEo4WE5TR0xMNjhaU2Yxak5zN2hSTUFHNTlkNXZi?=
 =?utf-8?B?M0lNcHRCNnZ4d003ODB6QlJsOWp6YmE0eERGZ2dqK1lDM25KU1VBTDBpVmdV?=
 =?utf-8?B?TEUrMGhOQlFmTGhGeVpqK2RaY0lxVVQyTEJkSzlFSTNHUlNaY3lacUowd2FZ?=
 =?utf-8?B?RGZpbjdUejllVUQzSnRuYy85aFdEalNOQkd6NUt2VTN5S1JpZW5WYnhQQzVo?=
 =?utf-8?B?TUllc1dVSGFJTnEyclZKbmNrWEFidFhSVDJnOHBFQVc4SFRIK1oxZEpPc2FM?=
 =?utf-8?B?RTU4OExudjNuVGJpcTNwNm1kMmh6NUpjUXFoYTErZUFJa2JrVjJIenFsRFRM?=
 =?utf-8?B?SW5kMW1iWDUzR3Y5N2dabUtoNSt6Zkp4MHRkSG80aW4xNlNEZGtXeXFXaXFv?=
 =?utf-8?B?SHByY28zcW81MVdGYkZWZ3Y0YStOZnU3YWhCOTZMdmFXZGwwNTFtbm1PcXNx?=
 =?utf-8?B?b29NaXNWLytKeHBkbzVzLzE0S2dReXRZbGJCZE56V01FWVQwcGRybUhFT2NF?=
 =?utf-8?B?aG9td21ZQzBwelV0cEdyMVU3MjhJV0ZDWjR4OXZqUzdxUm1JbGZ4MTEvQlQ5?=
 =?utf-8?B?TGIyaDRtS0o2Zm80dG5Bd2pCb1J5SVdEVklSVERIOEhscDIxNGJVWVRGZnZ0?=
 =?utf-8?B?a1Flc3lVcnVJS0tpUmpLZlNVMDFuaEY0aVU2aXNjYk5YMEdVKzU3SWlJdFRM?=
 =?utf-8?B?MnpET2lmM2QzRktsV1AxdjEyeFNrNDlUR3pnZ3NQdCsyQzJZOS95dmxPcWY3?=
 =?utf-8?B?Q3IzczBzQStkczM5cVJkWUFNQkthVm8zOS96cVBEcW4zbXdRK0tTR3VNWUZE?=
 =?utf-8?B?aGo3ZTJaWUtWY0w1U2t1ZmtxZWljSmt5Nm1MbmRCK0cwZXp6UDczcXhCRjNV?=
 =?utf-8?B?RFZlSVVFMHl5SWRzNmVLbFNTUWhHdVV2ZmRxS1ZNNHM3d2tyS3duTE4xZEhw?=
 =?utf-8?B?dC9OeEUzU2JyYzBEaTQ4N1k2MjhhdlFNTDY4RGNhV0RSOUVGZ3o5N21BWjEw?=
 =?utf-8?B?WDFPbWJYWE5MTFVNRWxKaTZZMlJwRTFEWlJsRmNOd3lXMWVPbWlYeUJ2TFN5?=
 =?utf-8?B?WHZNT0RoZDRWaC9zK05Xd0g4akxUZXliWSswNnhjekgyZi9CeXhkeVBkdkYr?=
 =?utf-8?B?TDkrbmhaVUozeE1BdFpYRUh0M0hYdTZrWTE0S1pJNktFdFNKZXNJMXZpbkJZ?=
 =?utf-8?B?U25qbURLdHRoZlVLU1ZSelNjaEdyWTV3NTNCYURPZ1NGZXlqOWVYOXdNRWQw?=
 =?utf-8?B?enlFK3Zvb3dNeVhFdndIdXEvM0JCdHdBWnl5V1d6bEU1Tk90aERSWXN1RWJV?=
 =?utf-8?Q?Fbj4mpWtvYIFezRMZLrsreo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96fa1e-d0ad-4506-5048-08d9c4c7255b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 21:16:25.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDMw3ZWODariuZnbhwvzTvJolrey7ccuo1bdv1mbhxvgD88Ns/RDW51fyu9xpy37ZYz576ItIix63XPj13gtpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3142
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/21 10:30, Linus Torvalds wrote:
> On Tue, Dec 21, 2021 at 10:07 AM Jan Kara <jack@suse.cz> wrote:
>>
>> For record we always intended (and still intend) to make O_DIRECT use
>> FOLL_PIN. Just it is tricky because some users mix pages pinned with GUP
>> and pages acquired through get_page() in a single bio (such as zero page)
>> and thus it is non-trivial to do the right thing on IO completion (unpin or
>> just put_page).
> 
> Side note: the new "exclusive VM" bit wouldn't _solve_ this issue, but
> it might make it much easier to debug and catch.
> 
> If we only set the exclusive VM bit on pages that get mapped into user
> space, and we guarantee that GUP only looks up such pages, then we can
> also add a debug test to the "unpin" case that the bit is still set.
> 
> And that would catch anybody who ends up using other pages for
> unpin(), and you could have a WARN_ON() for it (obviously also trigger
> on the page count being too small to unpin).
> 
> That way, at least from a kernel debugging and development standpoint
> it would make it easy to see "ok, this unpinning got a page that
> wasn't pinned", and it would help find these cases where some
> situation had used just a get_page() rather than a pin to get a page
> pointer.
> 
> No?
> 
>                    Linus

Yes, this is especially welcome, because it means that after enough time
sitting in the -mm tree, we can reasonably expect to catch the most important
cases, if any were missed. That makes it a whole other level of useful, as
compared to local testing hacks.


thanks,
-- 
John Hubbard
NVIDIA
