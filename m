Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1747C8AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhLUVLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 16:11:44 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:40833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230326AbhLUVLo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 16:11:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqfqBKFRzsSOSkwO+w/DKArsUsSP4X/ITWLv1qManyrpvNOT+/WV5w4IrFn+Eg8PgVLnxLpvLaEGGGfWjdCM/0v9foRKOSVVx4BsV7Ov+JeI6yRcChmSEyVkRVHcF/fQVku09SJeb3yGkAYDCGkPTeID/lHE4VInN7WHTG6wx6NbrWoik4MVk8Ql+rF/6V/CfS1gF7Ej+ZvobtWiCg/LPNpjTfT0B/IV5pY0TrHuWBFldc5xGPXE9jep9pAhpTSmV6QO9GbJsCAPFbSv1NGKRhz37VOdqx9zMF6N0xuRP7qLx5SIxvR2eud+9p+6XLRpdZ7hdFhtsLBZp2KKJ1xVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4SGVUxkblXwUuGlOvyWVp4N13r325MHbKaa2Gmd48Q=;
 b=GaCSmL1DAo3gGwzYUt4NDL2M0J6wMDcGrsjsMfynPBe4azRHMmqOAW/bJagCyGwh5IkAyWmMNaxnag3o83ZMrkTRBG2M0NXjL8bQqJ+5D64+Dk/SAPq1AikLH1fxOvfWGi8g4UBF0JTxhdsacY8HF+7SvHkImWmgPnqjfVnC/IBo7BI5SSXG7zFGeNN2sJF03cbaNTOLz4cFOgrfyPVpn61o8d3tAUme9vJ1mcAARimP6uhqfqZXHsdQyChgY5xOE7GI+IJpy0K1YJf3Yfo93FzD9WZLqr/T/fvlo7MIOOXVLnRa2Hrfea+EBAcHRup73wqhM9IvbCeKiAaKmcK7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4SGVUxkblXwUuGlOvyWVp4N13r325MHbKaa2Gmd48Q=;
 b=V1cpjDQM3plmwD5+VCGWMm3kZiQZ26y+OtljpVbmcwQAeGXhqIBy53XGdqkF6B8P4AiG4UzPrB7ugwT4k26QG1bihFns5oGfzx3EODNpJgKf2vJfLzCzkon0fR7I1xMhn5IACk/oa7C+VauuJatPBEpeW3xkoMNESx1WH4LwyUsHI9JNKsNBfK6oE1BamVYN5vVh0fEz62Sp4W9J6n8zX+qK4Z5W/PCwopO02r2HdAS8sXLICS4tNZAzfTNxwP+uO26Jbc+oFSCidfT/BOsXw3EZWL8wz/cKPuzWesv9lXtLnQnT7df0QjnzZe/IpQFuCmvnUhEK5VAY4eu3IFTCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 21:11:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 21:11:42 +0000
Message-ID: <ad13fb5a-1bca-3b4b-6f34-c1e7b12a1467@nvidia.com>
Date:   Tue, 21 Dec 2021 13:11:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Nadav Amit <namit@vmware.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <CAHk-=wi191H+U0TNJhL7Jf7VAA+mA6y8MUQLy9DkkaS+tNgp+w@mail.gmail.com>
 <dda021c8-69ec-c660-46be-793ae345a5bb@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <dda021c8-69ec-c660-46be-793ae345a5bb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0dc9832-3ee4-48b5-3e6d-08d9c4c67c71
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39704B2D544AAD6A7A9E48BCA87C9@BY5PR12MB3970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6xghQh2kBsNjpGFBb0wws74Ay0fTM3dizo7vOXOlSifY4GJQ3bipF8A6ugbUfwmkmmjmoax5JLK1SECqQlfXCeysNrTsSo5V92AdMcnmkjLfySUNM/dLMfTRjAIrfM1DmTGq1/1AOwadGL0IT7YG5OjWI9TdYLzJ9rQ01THaU+nIHlA+SLgWBDIMUicCccgLw9f32QkeN9sAWtXa0V4EIgcBxSl3oSDjh0oVHRmD5O4/BGMp6WBXQ1qysRvIV2KX42Bs5fZnspq0BXJmC9fwMEGBmfI3+hqOXbGfC9OLLaULlytjDoKp+B3ftB7kdYKX0qHHQVETUt3g0BKfQcmYKxf/6Oz9bD/26fNg6SHC8vpTqkTxWPXi8zd0mKY8/OB1ASv/SEmzGmW7YvEbrpOCNibDMRnjLWyKM2hajXpA46It2srfJlBtEzJ//NmGqbpVFdTJqagii2vSStQD1h9apzAzGvatAWS0RNGlmgVg5z+6P1KMKiN4i+CHp2CKHJqN4nEULygcWnCd411AzLdvA1/l7bUNEXTHcI5llcdY15jxRycQ6l3m3aMMpCDa8oUepEB89J/440el9Yrgqv2bFF/RqHWET7lJbPKcfJXj8orGutdmBQQ26Y00wz4A4QzN0snvI8f5cxaLYgpUulCGEeCfqrIjj+kVj6CjBbsxT1VKq1GwkfjyhAnWodTtp0v2GyaZSzjaQr4DOeQvHM7Gw1n+CldJ58LCsU9OQaRmpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(508600001)(83380400001)(186003)(36756003)(66556008)(31686004)(4744005)(5660300002)(53546011)(86362001)(31696002)(38100700002)(6506007)(8936002)(2616005)(2906002)(110136005)(66476007)(54906003)(66946007)(7416002)(26005)(316002)(6486002)(8676002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZWdW5YclpUaUZsYS9QbStjc3ZpU2l5TXJhQVZFSlAyc3VydEMzeHVkeXJ5?=
 =?utf-8?B?VkppekQrWjNxc1JxQ28wQWs1dmpWVkpyb2t5Q3JLOVJTWjdjYW12L3UzQ2Jp?=
 =?utf-8?B?U1VmZDRzbVltQUc1VjBndW5PMjgrM1BZY0dGWjNEbVdQdEpNNHBZQWtxVUoz?=
 =?utf-8?B?aDRFclRFc1hZR2xjU0s3R21Sa1Q0Z0NFUkowTmwrMERRSVNZRUtqdXV4ZHNX?=
 =?utf-8?B?aEtQUjZscmNUdkxEOEZUNjVITnhyT0YzQUdsVHZQUFFUZU5DbjFVelpwWUt4?=
 =?utf-8?B?WUsyQXRIQnE3Njc4QUV3TG5wdmdKNXFQbzU3aWVPNkVDeHFSdEM1K3VGSURG?=
 =?utf-8?B?WWUwRTRkakY4cWYxK2FvTkFONmVkQ3I4SDRodnd3NFBoM3VhemRPN2Jsd1FR?=
 =?utf-8?B?OGRWcGRqcldPMzVUWDgrQ0t6eXMyeTlMWWpFSFZncHp0ekZ2ZzRhK1hiM0xn?=
 =?utf-8?B?UUhvL0paVTZIY0VtZW04dmpsTG1KVU9hcUNnRWZVNDBpTjdVVEdaTXFsQk95?=
 =?utf-8?B?dys3WlJya2dkN3djbjlhclVISU9uUGF6bFNVZ3hES0k3U0Z1dnJiOSs0dkpI?=
 =?utf-8?B?Ui9UdUdleHk4Y2szQXZKTVFoNGxyNzJmL3h6R2pha0d4VFpPVVQ3Qi9JY1ZE?=
 =?utf-8?B?bERjcWc0Mkd2djBVNHJtaGJIVFN0bm1zYTJ0K3lRY0JZOUxuSkFYU2V1MC9m?=
 =?utf-8?B?ZmZYbytaSG9IVzhyYngrTUZ4MDZRZTg0THh5Nk5kaitYa21xa0RyVkRVdWs5?=
 =?utf-8?B?ZnpGbzhVS0xVdkFjUU11bTBaWWlHMHhMcFArV0VmSWs2eU9QSzJhSzFIZERM?=
 =?utf-8?B?SExDV0Vib00yQ3l4QXpjYU5VdWNqeFYyVk5XWGRrZkxRdkhPaFgyMFdEWXZE?=
 =?utf-8?B?aHlOdE5pejRrd0ZQQmUzQVppS1JaUjlYOE5EbkRMZStoOXB4SWpNbXVaV3No?=
 =?utf-8?B?VS84T0tQL1N6WXNjQTM2YnA0eHBHR1Z6c255VGIzR0hiZTdmd0drZDJROXZB?=
 =?utf-8?B?VlNLRnpleHl0ZU0xL21NRjBaQVphWTNxVTk4clFWaG1kZC8rak9CN3pUV2Qy?=
 =?utf-8?B?L1lyZE9FeDhEZXRjaVFkT0szeTZhaFphOGlBOEd6VFBMNXNlRnBPZjdQaWNC?=
 =?utf-8?B?THBTNk1hcXZTNy9JTldWT29QVGZ0elZSa2xRYlMvcnRLZ0tHQmNiNGF5dGVq?=
 =?utf-8?B?QmFtYzFyU09wR3FSaW95Z2ovZDNwUmV0UzdVMElUVHlGSlc4OEZhRUtqRWtL?=
 =?utf-8?B?ZEY5T3lFYlVJNVVKaWFNUVFOMDBEVHV0S0xjWnlRYnNkK0dyUFdpNlY5L2RH?=
 =?utf-8?B?emZmTkNKMFdSalVObmtCTTdHK09iYTFRd2MreDZOK0VmT2hQVE9kQmxxZG9C?=
 =?utf-8?B?QzlsVTkrQUZlc1hhOEtBNGFYOW91SDFGaHlqaXYzVjVlWVliMzhQc3NrcDZU?=
 =?utf-8?B?UnZzSHgwVkUvRzdlcXRWSUduUDhlRmpVdUlBdTZIYkU5R0FHd3NvMjVkSFg4?=
 =?utf-8?B?MW1zODQ5M09ndHdKRUxIazYrcTF1TjBJazVNZzBRbHlwZm5ZQjZaREFCVkVX?=
 =?utf-8?B?WHlKRmI5eGw4QkxSMmlua0JrOS8wWU56QmpqTUoyZlpTeUViT2d0NjV2dTlF?=
 =?utf-8?B?M3JiOFF0YkZsNXJFei9sMXlqakR1eTJyMDRuOHFwTW00Vlk3UFZMeFZzdGdx?=
 =?utf-8?B?SFhvM2hFTjBTbEs1K1Brc1daS3ErSFg0bkx1bG1BTmdvOG9abTQvVUZXREtD?=
 =?utf-8?B?emM0NFZCY0lMUExaQWoyczVKREdUMDc2QXZNSkNZME9Kb2dmSjc0SktvbEs2?=
 =?utf-8?B?ZUZZVjVOTUdtS3h6dGtLNFVFeXd2b0lIMmVRTW9BUGZuRXVHdThHcUhWend0?=
 =?utf-8?B?aUlEOVBnTkJvWGZvSU5zbTB6dnhoSVpQZWd3R0RSRjkvejV0UHpFM21jWFE1?=
 =?utf-8?B?T1N1bkQ4bEpzR3hRMi9UZUdNUDhqQ2xjd1l5YVg0ZnIrYjdwZ1k3YzRtZXpQ?=
 =?utf-8?B?eUp1UEtLeWQzQ0pLbjhhQjRyUXZjWDJmczlBVm5iYVdOK0w0Y2pXUzArYTBp?=
 =?utf-8?B?S3NwWEk1cUZYNzBBc1Yrdmxic0Z3VUp3OGhnaWE3K1FnRVVORFp2QWFuUXdy?=
 =?utf-8?B?OVY0ZE1DSWcvK2ZkZ2pmNVZkWWNLT29NR1piTmc3VHYySTg3VnU4YmlWT28y?=
 =?utf-8?Q?shvDkevrvUZUld1Xo8Rsc4I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dc9832-3ee4-48b5-3e6d-08d9c4c67c71
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 21:11:42.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7rvjhiDnilBMX67cRjVLu5Ph4j63+ygi0lRBovfmEzhlAf+jUhC3kJPlZlbRMoSmEbQw/60xTdpSAYe0x6ZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/21 10:28, David Hildenbrand wrote:
...
> I'd appreciate if someone could work on the O_DIRECT FOLL_PIN conversion
> while I struggle with PageAnonExclusive() and R/W pins :)
> 

Yes, I'll sign up for that (unless someone else who is faster is already
working on it). I've tried a couple times in the past, but without the
proper level of determination to see it through. So this time will be
different. :)

> [noting that I'll not get too much done within the next 2 weeks]
> 

Likewise. Starting in early January.


thanks,
-- 
John Hubbard
NVIDIA
