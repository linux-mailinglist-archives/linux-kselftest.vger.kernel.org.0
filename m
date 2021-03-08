Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF933176C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCHTgq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 14:36:46 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:15745
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231156AbhCHTg1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 14:36:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqF4U8331Rr+a5hTWnCPK4kvmcb4TaSGAbk00CPn2AfejOL/2gIXEB1Z4FYHjxPiwoEYzzk7p4FSJjRAHMg2fG4mCLvPsNbYCzIMUcEw2nTYl1xX1Rqaq5wfdDXj18h1rDRLR3k3dCqkU8HGnpJ+TFmdap/Xb4PXqbRVCKlPkNb4AhwO1yU4w0x6HqGbzHT91q/k2KbzfuKCffV4emK0k+vNfyepWcvg+s2t6QK80OAiufrwWjwvh2Wdvag8HV70DygU/y7WDtZ6iC9Ch3Gk+R5vqWYFBMRNMB3u++gAYVuBiDeA8E2Al1IFYaIvfDNfL1TBqkv8zBkECU8OQYiv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMmGzNa88CZ+ydmodCQdp47CX2fRI7AXWPIJIha5X2o=;
 b=XrPOHggSy+U+MkGPmcR620ysNkvwKsxa2/At7n4D1BbaHTk3hyONV4iJV1Jo6yYN07/P0aj5QToZssmvBD/8l+RCP8LwRJhURw6tMvqW2XXbyGcQY4imPbTjNOSxe0bY/Sr7jptJDlpxu0VE5UnOHtMF5EdZZ7976AlKSwJwY447j25bwsHhMYLUwX4TCRz4ZaAIU3in1lapFUNDE6DBANicBI8Inc/TJOWcGOnWTklQbE9MXv0osFyP/klYH2Tzv1XjYVltTEH0FWIJb4XhQMXrFjw2duagZzVg8/NbX+Aq/lbS8HmWrKpRXRqTmxC7LnSrOLfizTSIVLjMi6ZIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMmGzNa88CZ+ydmodCQdp47CX2fRI7AXWPIJIha5X2o=;
 b=agUq1mDNZpvmF1PsvV2OzOPVgGFSRw3nzmpa5jlMTtt0BQVB1stswhbCxKjgJui8CQD4KD1RBZa576iem9UKoOqWWESZESkWbo7yHc4o4zNaUKdiUBvRpOhB2BbPsJC9goUNS/mtd16aRZ1uSsBU4V9h8KCtnHqZOummODved3s=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4611.namprd12.prod.outlook.com (2603:10b6:208:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 19:36:23 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 19:36:23 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "kernel test robot" <lkp@intel.com>
Cc:     "Zi Yan" <zi.yan@sent.com>, linux-mm@kvack.org, kbuild-all@01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Mon, 08 Mar 2021 14:36:18 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <6D152AE0-2B5D-412C-94E8-170116E94C82@nvidia.com>
In-Reply-To: <202103090339.GV1I1C6V-lkp@intel.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
 <202103090339.GV1I1C6V-lkp@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D4FAF53E-EB45-4AB5-BF48-29686776AF15_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.237] (216.228.112.22) by MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:36:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e14a571b-4f55-45b5-fc88-08d8e269750b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46113C2119F74BA61E0B9E61C2939@BL0PR12MB4611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv2v4wveLxCYXpIDSwvreBA150jsBkAaTJFJCLtzMZwC8P2FOLpQ2fKEUBZ6XgNlfAZm28/ZQuD6oV1QnJdtTHPtXj1UeHcTEbJmf4DhcthCywe0HD4Jd3Z/N/ftyQ1b4Hz29STLRvrIAN58LdvbSMUjmRTocGcclZzaVxC2Ew9KkCaWGpHkQalBBoKGHrHY2YPfiEB/4cSnkDT3dXp/o/DX2jGgaT/o3OgDkno0+hIr6fG0NyrgFUZD7l5phSXeGktlWki6ZS4S7cTtORNdHLObN7MDQAelXhXt8Ok8mJEAkvSf8u88tN63LZ69XhxTrmElu3A4pXp96L6W+0DcGtrZObr8ffqejxgG6rlNvMNNHp3i9cMFTx13HJfGJTFJLfWcij5SEXWkkC//ddbI2OULNQLJLo6WsvaDqnDJQJ/j3uBi3BZ+cAf70fB4tQT77Dz8+srWwxeA+L1j1AUbF6//zdfE+RQxHbSZT1ohhMeLfzYeOweFUUUYPau/LyMeT+66nmgeGgjki6LGtj/LEq8q0I6efldN5z2S9lhVZ4Jecao0N8O0xUU0X8qXVHo2h2d7mws5QJI2b4uWNGU12AbWJ7LBlehJ5EC6SKnOZ85sYWSHt3qhgORvfzjuV/yJEy934CSamlHx77ceHX/NYgqv5yYxuZ4FTDZETecAmB99Bqq8Fy3qYKDNAFFrvVDxaqDdyZsdFV+yPo4q+eo7bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66556008)(8676002)(66946007)(2906002)(2616005)(66476007)(33964004)(956004)(966005)(86362001)(7416002)(16576012)(8936002)(54906003)(235185007)(16526019)(316002)(26005)(6666004)(6486002)(36756003)(33656002)(5660300002)(478600001)(53546011)(4326008)(186003)(6916009)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkdpeEwvVExuU1VKbjQvN2VFT2FUQmozeUZIMWptRDdHRXRyK3VGY1crU0Z1?=
 =?utf-8?B?NEZSSC9rQnhoWU1CREtsQWt3Qll0QWNINE44ZG91M0tzblUvdEx4RkRoKzFh?=
 =?utf-8?B?T0FUbjVZQXJIUnpQYjRHR2xKdFQvMWZkN2hoc29JU1dDWjQzQnErY1VLV1Z1?=
 =?utf-8?B?K3g4SitxVDBWcG5JYi84NTlibGl1OGJUczhNZlNIaDNYZEEyOTBMaXc3MDZh?=
 =?utf-8?B?ZGcvM05kRDdTVDBqZlZTQnJ1L3VaVmtzeUZya3lEbzNkbGNWbm1za3lXOFR5?=
 =?utf-8?B?VjlLUWtKQ1piK1hWN3QvaFZpaEpqdXRzbmwvbGJUOC90Q253UHU4NXZNMDZO?=
 =?utf-8?B?QU0vQ2RYZDcxdzlMOWJ2aXpmZFFFcDdJKzBWMWszTlh0TzBjcDhBRjA3STMx?=
 =?utf-8?B?VUFpMUtHeEQvbWs3ZzVRdnNSSE4xbnFBNmE0VXAzZ3J5b3hMY3JIOFN1cHdq?=
 =?utf-8?B?Q2UvN2o2N3dJRmZvOHdlcHRNOVBEK1VPVCs0ZStWeGozZG5kTEgvOW1XZWN2?=
 =?utf-8?B?NHVYVkNHRmtiWXREak5XdTV1RDdFSzNpdFZ1V3ZLM1hYR2N0QlR2N0ZPQUI5?=
 =?utf-8?B?NnZnVVcrN2Rzc0ZJU0NTVlNyUHlkc1ZwdEJXZHM5QStTTm1XR0JGendIT0F6?=
 =?utf-8?B?TGZmZk05OG9xUjJtM0h0K1FKUHI1bUR4Ym9BWTFDOHpwL0ZnNWJ6Ujh5dno2?=
 =?utf-8?B?REthc3U4dmFWY2JJaTNxZzZRZ0ZjTzBKTEx6MTBjMGNKTUlrd2EwZE1Zenlp?=
 =?utf-8?B?anNOQXovem10akhHWGc3Mjlkck8xTHp2MVptOFcxbDYwWGhETytSSnhEZFJa?=
 =?utf-8?B?YlZoSlNjbkIyaHdtUGEySTRzci9jTzBERnhzdHppWDdVV09VY0dESlM3bmtt?=
 =?utf-8?B?cWhLSGl4bEJLU1FNWnR3citDYVdMMllZUEoxTCt0RTVBWXhVcE8xZXpheHJC?=
 =?utf-8?B?UytXR0dsSVhFRWRyVGhKejhuUmgreEIvVWUvUEtEQUlyckVFYkpkd25rbFp1?=
 =?utf-8?B?cEpTc2V5UlFXR3pmSW8xTkxUWUJtNjd4cFcwKytUVkZDWitOSWM2VlBDWXkr?=
 =?utf-8?B?Q3N4aGNlUEl6VXhqeWo0bmxmaExUb3FyQUtrbGFiUDQwZW5hYUVvY3FHSzFq?=
 =?utf-8?B?WFdsTHVWb0t0b2IzK3R0WnFSa3NYSy9RblVkb3F4Sy9TaTdOTFNicGtqNDVx?=
 =?utf-8?B?WTJDQlBRYzlXdkZEZUsxK215VDh5VVNGQXJ1U05MYVM1aWtCNkZKZ1lYY3dz?=
 =?utf-8?B?M3FieTBDN2tQODljampnRWhuVVBDcTlIdEd1bk5ucFRac0FrMmhqM3hUT1Vu?=
 =?utf-8?B?bUVXYmRyQk5pWFhYMVZubGJ4ZENpcS95eElmek1SNHFENzNPaHBQeXRvTTUx?=
 =?utf-8?B?WnFIVHNVdTR5MUNMSDhlZFhNdWx1em1zQjh6NmtZMTFQOXhDUTZSdzZodE1V?=
 =?utf-8?B?dXZNMithL3JrMDkxWEhlbFQ0OEFwZ2tXeURINGJsZFhQWTl2Uy9QZVBQU0Ra?=
 =?utf-8?B?a09Ha0VMVDBDV2trZ1FhZkdybFNvZEw0TUdPTWtYZjNQeVR6R0hLMGNCWEdu?=
 =?utf-8?B?V0swbkVOK3pmMm8wb3VpdnJTQWlLRkRyUWYzTS93UE1DcGJRL1M2bWVqRVNy?=
 =?utf-8?B?QVR6RFRXeno2L2ZBVXdVVDcvQ0RGcWttdGtTQmZ1M0VhczkrMi8rb01kMGZw?=
 =?utf-8?B?ci94VG5yVXozenFJWDR3OTNoS2hXVVo2b2xJU0NKT1RmZ0VxUzJ4SmU3U2tp?=
 =?utf-8?Q?tQkEJlmNKfVpjLcVNWExWcez5HSCuKUkz8zIU3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14a571b-4f55-45b5-fc88-08d8e269750b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:36:23.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ef3MN9/kAwWBnInl27FvwWWatI5n1y/lYePJhiiMnv7MNK5ycyk6Z681lvpPVtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4611
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_D4FAF53E-EB45-4AB5-BF48-29686776AF15_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8 Mar 2021, at 14:23, kernel test robot wrote:

> Hi Zi,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kselftest/next]
> [also build test ERROR on linux/master linus/master v5.12-rc2 next-2021=
0305]
> [cannot apply to hnaz-linux-mm/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.=

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Zi-Yan/mm-huge_memory-=
a-new-debugfs-interface-for-splitting-THP-tests/20210308-232339
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git next
> config: x86_64-randconfig-a015-20210308 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 3a=
11a41795bec548e91621caaa4cc00fc31b2212)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/961321af55684845ebc1e=
13e4c4e7c0da14a476a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Zi-Yan/mm-huge_memory-a-new-de=
bugfs-interface-for-splitting-THP-tests/20210308-232339
>         git checkout 961321af55684845ebc1e13e4c4e7c0da14a476a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Dx86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> mm/huge_memory.c:3026:40: error: implicit declaration of function 'vm=
a_migratable' [-Werror,-Wimplicit-function-declaration]
>                    if (!vma || addr < vma->vm_start || !vma_migratable(=
vma))
>                                                         ^
>    1 error generated.

There is no need to call vma_migratable() here. Will remove it.

Thanks for catching it.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D4FAF53E-EB45-4AB5-BF48-29686776AF15_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBGfLIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKRtoP/RtSID4HJj42BI1lr2hudHNeTMKv58OByW4A
Sw3xU/HwUyRgJk1CdBZmsLd/zx1g4z9iVEg6NgUTo7HCSI1wZxBadKVvuHmUUp8S
/th40tmUJF9lXHzvCBRxLUFKsa+ICImUn68Wnvkvo4c8aQ92vMkwbM10ZcPuidW9
dUbt5+SVeAl1IHOZ4Bq5kGwecgV/kr5l/SHGu3Tl03dZ0mel/shHYjjqsHjwdrzB
2+j/JtuOB4biJJR25KKlijgCidOdVlDFC2pz+RFCB3ABMw13zU14yRS9Hek6VoSy
5DuOtzWLlLhSUKE2Y0ODy2GVagek8jp0vuPrb8EhMCVUYueKS4dkD/6O0s5Gd1SZ
nEUPvvNFjVSjmSgRyNkY1y5qWhKZcoJhHiNhjMdezEVk2+OBblbqSEwYAFxTlCAs
Ze9Z9++w1GeZ68ufw67XKXeLLA/pgwROUDi4RhMsS5qKvLkEJbKTBGFR3JErqvyT
1MrNWlpGW24Et+pqcoubpZeyzTdKi4riIke2lYiAtDfAoIz9dLmsg7G8kJk+LC19
wTefRNkdS56xqJ7L26it6ax1vP2FecCP7vbyz5CU93+CEbzcAL5i13BQyC0uYiDe
BJMKxEOumKPvVnsEvGgUIMaRsaMLtd8WTgqqKW2XxieBqMVhv5RCFOqaGF9U3kJH
FpR/yBm5
=mjm/
-----END PGP SIGNATURE-----

--=_MailMate_D4FAF53E-EB45-4AB5-BF48-29686776AF15_=--
