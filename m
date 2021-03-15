Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ACF33C5DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCOSiR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 14:38:17 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:28193
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231643AbhCOShs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 14:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amxJSIMkiJMkd55oD3jQFdjgHrur9tmfotJcnQRKEt3rlxdGU4KPbknhYxBmp8LbH+OzuFpKSWv3k3GAWgv2SbzbMbnMitO4Sh1gflveWxU+fB+cUEyISpXTitr8aqk7sTstMYa8g2lKOY0mI8M6naL8eGHhQHgdTi475xxC6iBfuEQcW6++8Dn3KBaVYUe8Pvp0qRO+QeiMWHtSFB0cYynaOVx8qEPl7LMkevKWat6kfmuEdMEpGVKWCBLIlbeIHu1RbdSD/LO9snbLpleboa9zsRvSTLJw8GNI6I9jz1SIc/LgdeYj7CQKTH9sAOHcUBKgaTRAXvKSbkZCnjZsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyr8pEUEF7VA3ngpofJGMEb86HSm5H3s3Vy9fTfp+Lo=;
 b=f8oUcaQl/G5ovlhDuzKv47D66Ha9PUGrTMSnUDoDyRiPOfJdWQ+b+PufQI8IDUsrUSk8MSxdw3tZ5y3DgcBm/Ij2/FXt3Nk0XNo7Wz6qS3hRNi7s5lxzGHQ5U4vD45f3tDb9oWeDU9jYwy7Ydw8ByDYKhpGaNXYkHXfpveHZG7seA0Bw6UWxmiqZWIULMQjZn5QTzfK90xk9g6hs60zfNX/3Kfdlo40k7C23eGPbe8Dir+guGx7BLgaJTEiB/IpSE97LAlQtxl9bGsEq+TWr3E6sw+y2poWo1Q5ZPkgpKB+B9JAZkhXqGM6xeQf0NlKCRD9C8FIjrlHzVJQb6/8urw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyr8pEUEF7VA3ngpofJGMEb86HSm5H3s3Vy9fTfp+Lo=;
 b=W/0hHVd8IXXC6u3wCWLl+57uwIiNrXqFw5KvwBSZBAGTU8tH8gssUZbb6MPDZReJ6eqPE/+k142wcQ/AfhvQTk8PlczlL/DEDZBQ9j1+jhN3QteMumWLWWUBR4CH8lK3lAV18oWAGHpeQhcDxiiz2TjuhcDMT7GN2kahzp0CPUX4XlaczG+jBxq3RJXeEllxhpQShvKPAPMQ5ICCdGT/Fk2UDpJ5im0y7ipzQdh7qNmoDHK3noBA+pFoevQfCpeY/ZHHYEx/LG28fyxS9b//qmE+ZtDXI2z0YL+i9PQiY4U8Q6SPMfiucyCgEvDeKfmo059eybqueOZuIjFuxNK7uQ==
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:37:45 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:37:45 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>
Subject: Re: [PATCH v3] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Mon, 15 Mar 2021 14:37:39 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <D3A202E7-6F74-4937-A160-199032E15AC4@nvidia.com>
In-Reply-To: <20210315120748.nuw5vk6grmfacact@box>
References: <20210312005712.116888-1-zi.yan@sent.com>
 <20210315120748.nuw5vk6grmfacact@box>
Content-Type: multipart/signed;
 boundary="=_MailMate_E26BD2E7-E4B8-43B5-A5FC-C9B6AD612057_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:208:a8::49) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by MN2PR12CA0036.namprd12.prod.outlook.com (2603:10b6:208:a8::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 18:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b4f0a4c-f0ef-405c-a150-08d8e7e16cb1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3919CECAB131B76EB995CF8CC26C9@MN2PR12MB3919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DiJ3G2eiNXrZ3iSnbeBu77hTvx/yYRNbAio1e6PFsYiQf/XS8V3JhyxtfeRd3LljfUN1USGBE/95e+iuWBgBlDqCNNRPuiK+Ij8BaPTf3oWINOgPGoXBeksXPOFk/kths88c8pDKgr8YC9OG6q0KtTrqk4aeAaCdh1RYp5VRX4Mw4g8MAU2n3MqGWcyjoZ4NaWZ7WglqqXdKT2Oa0/rQ3iSYCOpdFNi3pgX+WgMjSs4YWQa+la94IXp5VjKW9papl7VzdBgs/g/XCZ3ZZPWqNTBCsZX0hV8/Jw8RwgSDYPR3EuRH2DrgLo0ntiwYNFuFkhF6fI2JWWrTDZu20/cVhMqFDlMLZTfzXSc3PHNSBiMu4xr5iYgli9N9mra/qIcG1s55A88oipLtMfr/EoHjBFDgTOXMliudwXm08pUbUKywOhcYMFJ2zfM8CtB+lY4+3YdEEcrfdKq/DJvzCSB+onGzVZToNDZzjZ5kX70w6NLd+jx7gKHnAXg33Apl4mrHC4jy/z8v1IxHJq9HaCfArUvze2Ighopcy5x7Mlta65jNH0pCWAOc51gHdYHujXgtoPmhCcBQhoUeViilhaQYQiFRmfgtNHbu+eth643hsJDLLCKe9m9OE6iDcfkzABVhYlMEtJupDnpO0vjnjSaexSX6fasDrbPexshIFpIJPv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(26005)(2616005)(186003)(53546011)(36756003)(33656002)(7416002)(2906002)(54906003)(86362001)(8676002)(8936002)(478600001)(16526019)(6916009)(956004)(66946007)(4326008)(6486002)(33964004)(316002)(66476007)(83380400001)(66556008)(235185007)(5660300002)(16576012)(6666004)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q21vMjNQblFFOXAwUnJxbUFBZE5OaUdOajVjcEVvNVlUTmdwa2FwNTlRQUtr?=
 =?utf-8?B?MjQ0ZjdSL2FCRzAyUElobHZZaXBRZnU1NFFkeGJTelNjdC9hWkRuS0pKdjRx?=
 =?utf-8?B?eFY5Rnl2amt6aXRmdFNYeWlsczB2MmRKb2V2TlFNakV6a2xxSE04dGlEQXZm?=
 =?utf-8?B?TGxVa0xuVlp2T2UzRVBRMXNHc3dwOVg5dG8vV2laKzhWL2d2NnRSUXNyVHlQ?=
 =?utf-8?B?ckoveUl4UnpkNDZhbDNkWjlGc0s5cUxCNDlxbjRBZ1BJRXV1LzRtamxnQmJH?=
 =?utf-8?B?bWpwaVVUbWlZU2hvUGRYTUVGOEZ2TjNoYldaUXdkTnoyYisrRVllRUdPNmhu?=
 =?utf-8?B?WWhQMDNERllXTFRpbWdiKzc3bWhYdVZ0dUQrQmtwYzlBMHN6RkZoa0toRER6?=
 =?utf-8?B?dm5YWE5YZlBGL0JBRzlmV3RRcG1IZ20xWXdLdy9vT2MyRm41MlJNLzV2aUtv?=
 =?utf-8?B?Zm5PY0ZPSXV4eUx6YllPZE0yeWpYOFhtY3YzeG5IK1RLaXo5SzhQREdzVWNF?=
 =?utf-8?B?NFBYV3ZTSG94ZzM4U3BQaUcrT2JUUzkwSi9VdndselUzckxpS0NJN1pLK1hi?=
 =?utf-8?B?WjZ6VTAxTUdWcEJWdllCNjRwNjNIZkh1Sjl0c0NhWVRURmlRRWhRbDFsZUR5?=
 =?utf-8?B?ZFNTNHpVbWdtakh5ZHRiRmFab0NFOHh5Nnd1NFcrdmlEY1hyQUZsajM1MDN6?=
 =?utf-8?B?K1pIOVQwenRGL1g3VVJKNUdHazFWR29FYW1HUVJMMWgyQ29zelI4U3JBOVlS?=
 =?utf-8?B?WmdEeTNQTmJ6aE1xUnlTcDJZMVNyb0JCZzN2MC9sdlUwbXA1dVRZaHduMTM2?=
 =?utf-8?B?czlGUW1EaEpKZElOUURpU3ZNNTJFck4xM045b1BxL3lLNXY5empBWnY5NzUw?=
 =?utf-8?B?VEVtcllvV21YZ1ppVWRRQ0JGMGw2MHlhZGF3YzIzSjFMR0ZmRExVTnRxR1pP?=
 =?utf-8?B?RElJa3hpWUpaNTZ5L3d1ejhRNlJ4bGNldVJhaUJxSUs4N0ROMWJhL0tJSXI4?=
 =?utf-8?B?Y1AzdFZORHlOMU5LOExFOFpMT1d4ZGpmUWxlUVN2N01rNGQ2SmRVOWVPbG8y?=
 =?utf-8?B?ekVEZ1Y0YzB6NHM4aytxN0E1bE9rOTBzbHRXUmdnNVF3L3M4MVJiV1F5UFNT?=
 =?utf-8?B?ajZnbWltTGt2L2dIQnNDRmRBeDhZSDNNYzdOVzQzS3J5ajQ1MlY2M1hyTm92?=
 =?utf-8?B?R05mNXNxNTM2TnhidkxyOHhxbml5VkVUWUZWVmx2QjMrOURQTkxvWDFsb0Jx?=
 =?utf-8?B?MUtGbTVmbmFLWlNsK25qZU9tTTRxRVFTT2lqYU9xZkhLOWNoOUNoT1pKb2Jv?=
 =?utf-8?B?OWVPNHBEdHg2R1JCeHdFYlNuN1dQRmtPL212WmtrWFFHckhmdXhZdXBKeEt2?=
 =?utf-8?B?d0Z3Tm9pUGNxZ2lob3J1d3hoMW5YcTExMjBMamFBZ0o2MWRpdzV0ZnlnQk5M?=
 =?utf-8?B?cXV3RVozbHdlcnBiNjhVeHZ5Z01mcERmck9NZ0FJVmJEaGQ1T3MyU0JUZk51?=
 =?utf-8?B?N1pxcGFyWXIvbHdTVG9INUpaZGUxUTZCRGJ4Q3BqVnd4UEhvMGJZeUtyenli?=
 =?utf-8?B?WEt6SHlCcTlsVzNNQy9sZG5JT3VXQ1FNbVFNNnRvUm5iVC81L2F6ZkNCQ1NC?=
 =?utf-8?B?UWpOaEExS0p5b3R2NTVMR0w4Vjd2RXV0UWpTQTZkN3dDSE9sUy8yb2xkMjc0?=
 =?utf-8?B?bFVGUWdTcVc1U2pSV3cxbzEwYkduMnRzWUozSlFyUGtJNlYxeDF1NjJldTlN?=
 =?utf-8?Q?VHM9XgiLOPYX1xvaZAT4KpqS1xlQ6+Cycaxf0e8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4f0a4c-f0ef-405c-a150-08d8e7e16cb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 18:37:45.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A57Ii+IFhne41+Rp7i+S4fJYd7DP2UundRPR90akJed/lKGiyR8RqP+ce+4yqfCB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_E26BD2E7-E4B8-43B5-A5FC-C9B6AD612057_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 15 Mar 2021, at 8:07, Kirill A. Shutemov wrote:

> On Thu, Mar 11, 2021 at 07:57:12PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We do not have a direct user interface of splitting the compound page
>> backing a THP
>
> But we do. You expand it.
>
>> and there is no need unless we want to expose the THP
>> implementation details to users. Make <debugfs>/split_huge_pages accep=
t
>> a new command to do that.
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages, THPs within the given virtual address rang=
e
>> from the process with the given pid are split. It is used to test
>> split_huge_page function. In addition, a selftest program is added to
>> tools/testing/selftests/vm to utilize the interface by splitting
>> PMD THPs and PTE-mapped THPs.
>>
>
> Okay, makes sense.
>
> But it doesn't cover non-mapped THPs. tmpfs may have file backed by THP=

> that mapped nowhere. Do we want to cover this case too?

Sure. It would be useful when large page in page cache too. I will send
v4 with tmpfs THP split. I will definitely need a review for it, since
I am not familiar with getting a page from a file path.

> Maybe have PID:<pid>,<vaddr_start>,<vaddr_end> and
> FILE:<path>,<off_start>,<off_end> ?

Or just check input[0] =3D=3D =E2=80=98/=E2=80=98 for file path input.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E26BD2E7-E4B8-43B5-A5FC-C9B6AD612057_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBPqXMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK7koP/iAmhCslYy2DAF7yeyTGq13GtlzgS3UpROI0
eVDH7uscTbsdeXqgFjjk9S7pF+fF/bZpHNxbFRI6Lvgdtc4JdypPHCcAjsopGHgj
3f6snMa3QyzZN8sI1LFPLa9bQfwTEoaxenFDxSQffxLXSX0l1F41Xh9ukUEhnrL6
Yy/KDUocRmuFmMGkcx2kbMutcetkp/RSLsp8tOmq0KxL7bB9tUWrq/SNsdPN8t5g
Y5e0xuXZWyM24NejXr2o4B5t6TueIwznOn27KVAgXpIw2NR0j9k9llrZb4FWWmlX
TaawXmvnRyY194ry1LRM0qkRYGuGQNkDHX3hPMP6IMVNBEXViHnterKe2d7ytAIz
G1suK+Ds4uywXXZN189oqFc8+0KU551y5xIXkfojMdKlkHq1JuRO9Jyes0MV6/2C
BMsGom38BhVA2xaxJKR3tjWje2WXkMlBYjQnWEp5SJ53xKr6SSAy07EKeyTR+hf2
OSvfFcBlkip6mqMUTPDqBLzAqX31lPvVHt01CKXepGLnGgshyO4x9fC1nQDhxiN9
VHOCkM3EZgGkntHx2dxMsR+yxckZOQHSCT44Z9PBQmUwQUNkFDt9iuyTsZr6enFl
a/D2qW5s/BFj8cDpCz9CFe/VQmi07HQYFIvpj5lvUB+VBx0f8Y/YPz9rnq7fdltO
E7dfdJt/
=ISvS
-----END PGP SIGNATURE-----

--=_MailMate_E26BD2E7-E4B8-43B5-A5FC-C9B6AD612057_=--
