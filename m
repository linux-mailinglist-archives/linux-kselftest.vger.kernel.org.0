Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723DE4797EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 01:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhLRAuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 19:50:44 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:18480
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231367AbhLRAuo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 19:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P44dC8CJyAySUMn+k9YbMqyPTiVQR19uc0DNu+JVsyr8Tm4C5Z6b9FGx1nssxkK0VA4nd6Y4wopfb4BoEfDWpPZ1HbRS7xDuG81gjwOtEMBMfIP9Z3ueG6PL+Mzv0N5RPWF1FTUpfX4V3Kmh4bs6E12tpa+1XU1HNrHCgwZPOl9RGqhJGYQGaE6LWeyEpO1vfiYcJ27Yjol5qxEAL3OY6vufxfw29AUEYzxhuxG1l/BFoCXVL/hEwZHF8GVPiqUknWJhsmhkpv7lbWkLAQ9nTu+rW1TH7TG/bt4vpEZbINgA6n9izjcx2c1NcQE/jBXcNgCmAvLfqiiG8B91hlOMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmYKBd0P78iopJhb/YhO1w2zGNzDWa8yGXtSRxHurjQ=;
 b=TmiMu6EJ1DDe2qRRQcjw9zpd6ls4R+AGyRnK2m2z7yUXZ6QttPi66nYIL6I9f34YxSPCFNwT4hxBhHYEQCBrwLqsVta2eGI1buf4DdOpZynFZpetw/hYeOt09BV5MKd36urKJ/FWe7v9UFzsnze7ZygYR2A0PEN9DkfTmkOjE25ddSjSIewzNZTGvAYvHIezzPsnQmLeD+scfebvlpKfJv+qeGZh0wUZNCEUyGQ9C0+QTUdm1ahpxBXlYGgfT2674uqtSlZG2WZQV9A4m3eFzvgVXwVB2kfvsgwl2EIn4lwX3UG44r2dKlNsY7LNbKBgLi5fD55BvOU81KlJjm0vaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmYKBd0P78iopJhb/YhO1w2zGNzDWa8yGXtSRxHurjQ=;
 b=ZKxiP7jGuaAVxQlPpLFR6sKa1ycLlexheWdsd5IMGfRNsiNGwD6Tj+rZRnifimMOMbQRhJlbkN3HNvVdhN+XqfpgkcSt4ExnOUkp+xGA7dSG4mK9EfMxjYfQbkTieqs/wHEeRUaajAa7+aTkm8OboOQLlR+9bAU+2YSn/EocK/7J/e4iPeHuuT7D+/Jz/30ZsMDntAnnze2MAk5/gZWUda0M3GE/GZbj0z7ryEMsTWBrsrwCaZM2yhbmVhWKq1yiyIHEH+ZvEzxI2/WEBc3CLYXIQylUEOQ4iqBUE2m/J1E6zl5hFXQDEInGb5GoY/RforvnzNbZ/qK5YAYI2xgjcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sat, 18 Dec
 2021 00:50:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 00:50:42 +0000
Date:   Fri, 17 Dec 2021 20:50:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211218005041.GA1425904@nvidia.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ab3268-5d3e-4389-a0ed-08d9c1c06af8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB520691BBCCF1522A7DE62C4EC2799@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgq6+H9v/SM12VPEcw8Q3rG+PQ++zQildSMNSj54ErpZ59NoSc2tFD4EKoGkhCwVNpLV/RX0/eu3cb7Aed30nOShTBydJJHKbs4lUl6NJZS9A/HCuzRXY906jvjVA6h07pznniK2IO5hacO2MCyn0rqkSLhNissG/zAHbkxROEhhTnXH17wavr3xWBGk/lit7MVBtod7YfpG4ebV3K+wvhmQ8cir8SrOmQgOj2JMdviO6B9DQ5Y1n71GQfWuv9+Onad4e+2VmDAqXhRaMi5StpkARG6FMBC0Vlvp8lNGdDU0f6KcxTjLBRleczmQVIu84h+MSI2dEbMXV7wVNNyQ67uJ4kXZH4cXLFegZ67kxPchTzInTYf9j1qyb/264lXpz/C7A7jBl+KHwX9SZDfiHZWj4pMKlSiEUJFHX+T/iYiJ6CKDEczzoCRgCTbRHQlePT2wEs3aGai18t/8ROrQj7vNuVjgOZQf2D5p189FlgbO2VGmxsqPAJ+cuhACPXXvnD4u/NsfBGoalVhU0SCpMbZyE5Xsy8ZWvzTIh9pyn9QvmQyRUb06tnuA8AZD+CCanK5JT349PLpDXwA6BggY4uA+WJLaBcoarNfwpA/omtxT9gV7An/9naJd7/BLjAMUm+j/4j0ALvtICvEy2gE3iGJyRYu+iYXBuo7UMuBrZKrD1nQo7YiLy4FdpINBq9PSLX17mnj4xSHIsM9U5FSXfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66476007)(86362001)(2906002)(508600001)(8936002)(7416002)(6916009)(38100700002)(54906003)(4744005)(316002)(1076003)(36756003)(33656002)(66556008)(66946007)(186003)(26005)(6512007)(6506007)(4326008)(5660300002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MR2ktUzPKzRW7NV2ORzK90N/nn6T/311ni3es0Q19uyOjfJVHvpKSNNHKgS?=
 =?us-ascii?Q?aE1Os4+dNQvht2W1+utGN2GeKj87QLKKVYRhb2v5VOBIYT+NTPmATpFep47P?=
 =?us-ascii?Q?g8BzTukmIi6IsC+HnRp6CCayClKZSoP1ImXDOWnnGBdtfRvDTZtRlw5YFdu2?=
 =?us-ascii?Q?TcJFbwURR29hrCbvCADZMzwYXKlLeKaXNQcli9DLKWvh8xegzqZ36AQN1RlH?=
 =?us-ascii?Q?3oXOh2m8HF4r+rdKwPf3PcgnpDTKor+leeSYZ/Fqh2S0AJ9JiFdfiig33p8J?=
 =?us-ascii?Q?Awk8XRVLaZkXWSiZDJKC/1zB594iAOiAUMsYBklPa3W9+m8Xm/UySvd61CPj?=
 =?us-ascii?Q?q07E7ee0kqMcrvZpPX22w9RAS5vqyUpnlW4kvljzmsFAb69gBLSXw7Vk6nGp?=
 =?us-ascii?Q?lG015HpAKh1em9d21cps3OD42t/KKDkYKdGGqSbKADcl/VXci5x7O1NPu1bU?=
 =?us-ascii?Q?R22yDBHmm/VDKCXZ6TJwA6XkTTfF4VW827OKGP2CIn9OnWCXiYg3WcpgSJoU?=
 =?us-ascii?Q?w4OiL6Vop8UXXPwbuFh0vu75dyE8h5KpfTVIMhRluImAN1JPNo5nC+6HYhxU?=
 =?us-ascii?Q?I4vR2pNIe7VYMhLqp2olj20cF7F1LtrE9lmRxFBMgz7T2TYcKtP14e1vGu3r?=
 =?us-ascii?Q?IdajxllQsb1aw61M+MmT63FUbmdbJf1hJTQaomgntMXoZmzuamLD9+0mflM7?=
 =?us-ascii?Q?boINKXJVqaDCOmNPbpjSzJT2RJNSzO1JbWLWB7pYsW0h39aYkcLJ0BbnGCfj?=
 =?us-ascii?Q?9BFB5xs4iU96GCUyE6YVYp/hkI3qnpQbarT5DTHyHiYJIROHR/ihShOg1cDl?=
 =?us-ascii?Q?+4O67GDhRsSdXu1zwhYB6EMroPzhb/qAQ+PUKMzudFzz3LrDGaCkWnzRoLFj?=
 =?us-ascii?Q?3bOQWwGiE5FM/jC0etP1OWYwVvdrne5DmjkOcqEqB0crORhwsnvcyRv7LyZm?=
 =?us-ascii?Q?wR9w8sdu2gTL3lWx/zbgRHA8kBFXJ9ravQGc8suWNNcku1ZSzwzjpZQcFOVK?=
 =?us-ascii?Q?h7lrwsbi9u/FPndN9gfqnlUuJ6v4WFb8UJnRdja8grOsgN7bMbXEAA2zGFD4?=
 =?us-ascii?Q?18KgSEJGj+oBTtPWVyyhyZqvl984JYO7gqwbWjNlX8CsYqgkGF0qIaItzV1E?=
 =?us-ascii?Q?RyCU5lb2XgmG93+rKgSaPaPkqde8XijdKQDsU4LzpfH+vqjVcVzRliGHDSZ6?=
 =?us-ascii?Q?fJuLNqMQMfQeEsLRKdRhnOboBWsLHiQNEkdd3+w5HvbuilUZ4tooKvrv6YjL?=
 =?us-ascii?Q?Vl6tF5QEXrpr4LYyGh6lTQow970anpIUt8A5S2MsmcnycgQ3qEPbF2edGfTN?=
 =?us-ascii?Q?rZXGUzfjQpZPiAIsdjMpRmGFkhdg+hqR2FpYC4O9zgwd0VzkixZvOwHZ1AWI?=
 =?us-ascii?Q?YBb/G3KWgwbUzFF+kaW291301Hvik7082BTRjy5DUkAV8MyUS1yjJLYcanyb?=
 =?us-ascii?Q?TMLwpNNQOnmgChdNOK6b4vrKgzNlYel0SIMhGqGvdtirJiP8J+caV1GlAKis?=
 =?us-ascii?Q?rU7HxzFTUbKxkIcftGFC5Drd28STZXUnNugvL9/ckr3uijWwupkYxB+JTZGV?=
 =?us-ascii?Q?9o3AYY97jkYgThq2wKQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab3268-5d3e-4389-a0ed-08d9c1c06af8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 00:50:42.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+NLH4OFfjuZN8VoaunwN+5JqXO3FnnmNIZxrgPvhU1V+djWAoi+DwSBEdn9ol79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 09:15:45PM +0000, Nadav Amit wrote:

> I think that there is an assumption that once a page is COW-broken,
> it would never have another write-fault that might lead to COW
> breaking later.

Yes, that is what Linus has been explaining, AFAICT

> AFAIK at least after userfaultfd-WP followed by
> userfaultfd-write-unprotect a page might be write-protected and
> go through do_wp_page() a second time to be COW-broken again. In
> such case, I think the FOLL_FORCE|FOLL_WRITE would not help.

Right, and this is a good reason why refcount is running into trouble,
it COW's too much in cases like that because userfaultfd-WP doesn't
align to the first assumption.

Jason
