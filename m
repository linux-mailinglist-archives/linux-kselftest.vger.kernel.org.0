Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F133F47A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhCQPtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 11:49:47 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:24672
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232491AbhCQPtR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3Gq+8IWSlKcE8dJ+xaJl/qVMDrdRD4/g92CWCat7AT76OIMtSAdV2szFwIkuO3SQz9duEWrMvkZ6gTtVZkDWMiEdoINjIZz1n9pnPAxmG6UXRpCM7L0C5OcSFnYiGMEcqk6loUBq2kSWtk9/5ftzSrHp1DY2JqvaNvj4w+vydyECAqxbkkdMUUz3FmeYdP3scO+CD8R4lLW3SGS5z0Co3QBMEje4N0d7XsH8PSSUKhhWKb679q4PrBykfWHCcYtRNx0gndyYhikyiJd/OPEvV2hCtihreakh+AMiterx/a57tTqUFzn1SHeQ4jpDhatsaT9SlEKiTLHUujE2ueHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XnI+UbIwH2o6cHQKuO/p3DdVULH5yl7zP2sEoHp5JY=;
 b=lWl0kT4pmnyzEtALZmivIIZxNeLjv87wW+MOqg9zXxPJOWS4/OsN63ODzkJfTZNXLp0g5kdgqcM7eWGqtcLHXQZ8Om204afkltMVG6xZNAa4zbU4jF91WcPCOb8BEoinjT22kfwvQPmk+kgNsFKcaJwbLcuEDe1mMgYuH1s5wtTIinXCOnCkADFYuIm4tCKAJmkkGtmSpKALDKCSFmzFQsoQ6xgJz3QbSHm8BqdF1aRXSDbLbHSxFHD4jcS5v9LnZtXY2m5ZVerFIYHrKeKLO0PeZ93h01dI0kcpzp1pJuvx52oLxxCOB3J6oSXoOZe5L9lg0rG80LqSyEkvSFj16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XnI+UbIwH2o6cHQKuO/p3DdVULH5yl7zP2sEoHp5JY=;
 b=BgwehsMHAzFOGzEWICOigwfkzd9+QloaNVV/FgzR2Je5X5rug/97DaSzpYazuR6J8KehFNyIshnQZeuqrSgurJkWmpRTKl6lM6tEnFk3/z/Lhfgw3uu0H0mnkLRQM+7i3m+ikt4aRX4HeV1ntaNEBjC7m/JWhjLvxaK8Nxz+0iqeoxO/lfTnCtk4ATLgMCE42kHJ44rbFccl/YdXnnYqyJLSWz50sNpcWPNf1qfyJjg3wl27IDML72jOC235pyg3taGpJNF/T5iV37sGNr98pv+9p+SFzjrNlhuaX2ugbE48G2/DL9ueV+6crp6NFfXdFWpVcr07sXYLUNpf2XPiGw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 15:00:45 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 15:00:45 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>
Subject: Re: [PATCH v4 2/2] mm: huge_memory: debugfs for file-backed THP
 split.
Date:   Wed, 17 Mar 2021 11:00:38 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <10CA242B-9994-41D0-A84B-E711A5CD2975@nvidia.com>
In-Reply-To: <CAHbLzkpmFhBxMRetg8QM4BQ4fDiTS823XBm73+5BV-eXsoCP+Q@mail.gmail.com>
References: <20210315203349.171760-1-zi.yan@sent.com>
 <20210315203349.171760-2-zi.yan@sent.com>
 <CAHbLzkpmFhBxMRetg8QM4BQ4fDiTS823XBm73+5BV-eXsoCP+Q@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_79110CA8-1A80-4867-87C6-2B0A3D58C98E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::12) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Wed, 17 Mar 2021 15:00:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f2ce8a-8da8-4548-3f61-08d8e95570e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB386986C88251350F986979C8C26A9@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rW3rnIKuA3ObPg8/ba/fwKq4HtNY9dIN49iRIZ4+/VOROQ+jBAomxDUekvvEn/57EfMrgfAmUksUfNzlyWSaSJlcmo57To0vIWs0zztHvQQALVH1EBmFlaNYMb1gdEu7W+xU8W3IwXNt9LxKPAJ/Wou1gECKUW5fg/7tDj21mCbEs/bh0fw0pdfVa/7q0b+RaSBPl5kf8degIhVrAUi6BFNTOaJF+xGoVjyz8A+RZjV62Hnv2MSt85Diytubna8otw5M7L9ryn/MB6Lak7JQs3q9p0Qd7eAxcS7ColB/y+ZaGYnobCVC+JY0DwVLi1QCjRhtia3XV8EwMlbbPyFB1ODLc1Yb6vzgQzOvcOL0kJpvgq1MSjr1GqQIsfGb1mTePWwtwvqlbWfT82+jOTw7iuzdMR68iDQRMgwop8iiK4tlYXw3PrlS2cKtRVSnsIdeCs2f6bNH1rW5o9Ci9PspgkeFDICwjwkaj+Q78UjIuEGukH3frtn6povRscjozkAko3Df/yQOUnj6NVmALw+JX8vXukR1KXxGsX02oSSD2LZRMER3mT+baxU5wJdQQfqqgXbvPEV6pHSq46g7GV+u3rxU9Blu/Bif7awxFJ6nIImYFy62Zl539HjlhpLj8KJOaGuDo+3hb4pGaSVNo59Yw7FfoSK+OKGJtfv+eHyuPKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(6916009)(956004)(235185007)(54906003)(6486002)(2616005)(66476007)(86362001)(26005)(66556008)(36756003)(2906002)(4326008)(33656002)(33964004)(316002)(53546011)(16576012)(83380400001)(8936002)(16526019)(8676002)(186003)(5660300002)(66946007)(478600001)(7416002)(6666004)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGV3eEJwaDN4SHdsRGh5QkdNVFJlZUc2b0ZhUVdvcHI0aXB0UUczZ3lnRVUx?=
 =?utf-8?B?OXo1c25pTHhEenFpTWNmbklvTWtHSlFWRFJUblVublRERGt3RWkxdW9vTlNS?=
 =?utf-8?B?ZGZhcldZNGhVVDdQYXRhMm5iME5iTGNlZFA1RUNoWUdJKzhlNGRwYW85RW96?=
 =?utf-8?B?c2NlTEdqQjZIQWZoZXE4cVFja2tDaVlYMXplbDJSL3QyZnEwcHR5cENsamhV?=
 =?utf-8?B?cjdVUlJRZ3NNekJ1RXozWkNEM2RXM092SklQRW1EeXVBQnlVZ09DMFU5U3lv?=
 =?utf-8?B?N1h2dk0vL0xvYlBibWVpcWZGOXVmMmZtTHdKcDd3dXoxcTg3RWlwSlBJRmxo?=
 =?utf-8?B?aCtTV29UQS95akQ5bjFrUEwyNnhmQUIwSHRnY2VvcEpEUWtCMmtkeEljbE5U?=
 =?utf-8?B?R2hBK3Z2dFBQZ2x1YkZIaFhacG9zbkdXRDQ2YjZqM1VzdUYwbVMvb0pTVjNy?=
 =?utf-8?B?d0hkUzVsRGJpLzRwamZOcnZYZENIclpPdzFIUkE5T3pQRlZyMEFBTk5zMzhw?=
 =?utf-8?B?M0R5ZjNLYVdHWGhjaVBQNzhaaTdxbU1EY29PRW5QdVVWeXBZZ0w1cVROUFJk?=
 =?utf-8?B?MCs2VXNCYUlyVVR2ajNzdTBHa2hYbGF0NU51RmxiVkNtQ0pxV0wvSS9wY2M2?=
 =?utf-8?B?bkphaFVYbXFmOHQxVWhWQVN2RDdYUVNtWkZmRXZ1UXp5NGRFWUNGZkpNU1Qr?=
 =?utf-8?B?cm9lOFYzQ0pzSk9VTWVnQ21aVzY4alcvd0pYaVVGdUR1QlA3STBFVmRNemVU?=
 =?utf-8?B?MFMxSjZiS0t6MHQxY0tCb3hPZnVQZWQ4TVZ4LzB3a0s3QTdmeStUcEhneExQ?=
 =?utf-8?B?ZTkyMkVvT1lTT0l5Nm13aG40MnphOHFreU1nK2MxSVdpeWtkUTgzdGRlUnFB?=
 =?utf-8?B?anFlb0p5TGtHbzE0bGV3Y25sZWxlUlJiOFVDaXR0WjZjbmlxTUZhVjlBMUM2?=
 =?utf-8?B?TVBGVUxuM3NMZUg3ekZrcVB0OWdvKzQ0VmFKVXE2aWljZ1lpOGhyd3I1Z3Br?=
 =?utf-8?B?SGJWK20rSDNIVGt4cklER1dFNjZGdUVFVTQxV0YyZjQ3N3ROTUxFOHFqVVJv?=
 =?utf-8?B?dEhiUmxVVnNlSDNWaUZFQk5xRUpUN0hsaHFvWlltZGthcGo0OXZ0SWtQbmsz?=
 =?utf-8?B?R2JheVdlcTJhdzZkYUhBSzB6a3VrZU9JemxXakVVSVZmTU9WZHFDdDVpWnJ4?=
 =?utf-8?B?STVxOFFQODJNMVhld3dpbjVnTFRFQ1k1MzdPQzVtNFp1OVExNTk3TkF2Tmcr?=
 =?utf-8?B?b3pyYzhsWTZ5TTJiNjdiUjRHSEIvU2VCSnREZ1RhcmtGZWc4RDJsdTlFeHY5?=
 =?utf-8?B?b1NibmRPOVNQRklxdHc0T2tnWU85RjVaUEJIQUQ2TW8wMkRDMVR2cDBmMXRh?=
 =?utf-8?B?OEFrMGZGcWJZTEdsTkNMS1cvb2trcSt2dXkwZWJOcTRXZlhjRWk4MVZRdGhp?=
 =?utf-8?B?WE1MQ2NZdS85MXNNVDZrK2d0YlZKU21FazNsVmo0WXhyUkczZ0NIK2JnWmh4?=
 =?utf-8?B?bHRseFUwb2VlZ2NyZDRENEtlY2dtNW0vZkFjaWtCQlUydTFkeW1QODdTbHlx?=
 =?utf-8?B?MEh5ZW1tV2hsek1NQ0ZlRUFkZDFVU3FxeExZQ2pMQ0RSU3pDa3ZHYmJZb3Fz?=
 =?utf-8?B?K0FtakdSZmtjY0dzSUZlY0ZyOGgwblUxbGt3K3h4ZmhSZnZ3N2FJZ05pbmJQ?=
 =?utf-8?B?OXRjSFphc2lIblVRcU5sZS9rK00xL1Q2a0JWUk9RWXV5TGNaaFlKTFhaTHVw?=
 =?utf-8?Q?f20xw2K0mLrfLsobVwY+16scneUnpx5cZ+i3lc2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f2ce8a-8da8-4548-3f61-08d8e95570e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 15:00:45.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdIK46jnofnANrZfKGyU4f9f4+ESOWGtLDC8Bu1po7+Nf0JTMz8/5aaUmywIAWph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_79110CA8-1A80-4867-87C6-2B0A3D58C98E_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 16 Mar 2021, at 19:18, Yang Shi wrote:

> On Mon, Mar 15, 2021 at 1:34 PM Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Further extend <debugfs>/split_huge_pages to accept
>> "<path>,<off_start>,<off_end>" for file-backed THP split tests since
>> tmpfs may have file backed by THP that mapped nowhere.
>>
>> Update selftest program to test file-backed THP split too.
>>
>> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c                              | 95 ++++++++++++++++++=
-
>>  .../selftests/vm/split_huge_page_test.c       | 79 ++++++++++++++-
>>  2 files changed, 166 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3bfee54e2cd0..da91ee97d944 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3043,12 +3043,72 @@ static int split_huge_pages_pid(int pid, unsig=
ned long vaddr_start,
>>         return ret;
>>  }
>>
>> +static int split_huge_pages_in_file(const char *file_path, pgoff_t of=
f_start,
>> +                               pgoff_t off_end)
>> +{
>> +       struct filename *file;
>> +       struct file *candidate;
>> +       struct address_space *mapping;
>> +       int ret =3D -EINVAL;
>> +       pgoff_t off_cur;
>> +       unsigned long total =3D 0, split =3D 0;
>> +
>> +       file =3D getname_kernel(file_path);
>> +       if (IS_ERR(file))
>> +               return ret;
>> +
>> +       candidate =3D file_open_name(file, O_RDONLY, 0);
>> +       if (IS_ERR(candidate))
>> +               goto out;
>> +
>> +       pr_info("split file-backed THPs in file: %s, offset: [0x%lx - =
0x%lx]\n",
>> +                file_path, off_start, off_end);
>> +
>> +       mapping =3D candidate->f_mapping;
>> +
>> +       for (off_cur =3D off_start; off_cur < off_end;) {
>> +               struct page *fpage =3D pagecache_get_page(mapping, off=
_cur,
>> +                                               FGP_ENTRY | FGP_HEAD, =
0);
>> +
>> +               if (xa_is_value(fpage) || !fpage) {
>
> Why do you have FGP_ENTRY? It seems it would return page instead of
> NULL if page is value. So I think you could remove FGP_ENTRY and
> xa_is_value() check as well.

The comment on FGP_ENTRY says =E2=80=9CIf there is a shadow/swap/DAX entr=
y, return
it instead of allocating a new page to replace it=E2=80=9D. I do not thin=
k we
want to allocate new pages here. I mostly follow the use of pagecache_get=
_page()
in shmem_getpage_gfp without swapin or allocating new pages.

>
>> +                       off_cur +=3D PAGE_SIZE;
>> +                       continue;
>> +               }
>> +
>> +               if (!is_transparent_hugepage(fpage)) {
>> +                       off_cur +=3D PAGE_SIZE;
>> +                       goto next;
>> +               }
>> +               total++;
>> +               off_cur =3D fpage->index + thp_size(fpage);
>> +
>> +               if (!trylock_page(fpage))
>> +                       goto next;
>> +
>> +               if (!split_huge_page(fpage))
>> +                       split++;
>> +
>> +               unlock_page(fpage);
>> +next:
>> +               put_page(fpage);
>> +       }
>> +
>> +       filp_close(candidate, NULL);
>> +       ret =3D 0;
>> +
>> +       pr_info("%lu of %lu file-backed THP split\n", split, total);
>> +out:
>> +       putname(file);
>> +       return ret;
>> +}
>> +
>>  static ssize_t split_huge_pages_write(struct file *file, const char _=
_user *buf,
>>                                 size_t count, loff_t *ppops)
>>  {
>>         static DEFINE_MUTEX(mutex);
>>         ssize_t ret;
>> -       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>> +       /* hold pid, start_vaddr, end_vaddr or file_path, off_start, o=
ff_end */
>> +       char input_buf[MAX_INPUT];
>
> I didn't find where MAX_INPUT is defined in your patch. Just saw
> include/uapi/linux/limits.h have it defined. Is it the one you really
> refer to?

Yeah, I want to use 255 as the max input size and find MAX_INPUT. From yo=
ur comment,
I think it is better to define a MACRO here explicitly.


>>         int pid;
>>         unsigned long vaddr_start, vaddr_end;
>>
>> @@ -3058,11 +3118,40 @@ static ssize_t split_huge_pages_write(struct f=
ile *file, const char __user *buf,
>>
>>         ret =3D -EFAULT;
>>
>> -       memset(input_buf, 0, 80);
>> +       memset(input_buf, 0, MAX_INPUT);
>>         if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>>                 goto out;
>>
>> -       input_buf[79] =3D '\0';
>> +       input_buf[MAX_INPUT - 1] =3D '\0';
>> +
>> +       if (input_buf[0] =3D=3D '/') {
>> +               char *tok;
>> +               char *buf =3D input_buf;
>> +               char file_path[MAX_INPUT];
>> +               pgoff_t off_start =3D 0, off_end =3D 0;
>> +               size_t input_len =3D strlen(input_buf);
>> +
>> +               tok =3D strsep(&buf, ",");
>> +               if (tok) {
>> +                       strncpy(file_path, tok, MAX_INPUT);
>> +               } else {
>> +                       ret =3D -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               ret =3D sscanf(buf, "0x%lx,0x%lx", &off_start, &off_en=
d);
>> +               if (ret !=3D 2) {
>> +                       pr_info("ret: %ld\n", ret);
>> +                       ret =3D -EINVAL;
>> +                       goto out;
>> +               }
>> +               ret =3D split_huge_pages_in_file(file_path, off_start,=
 off_end);
>> +               if (!ret)
>> +                       ret =3D input_len;
>> +
>> +               goto out;
>> +       }
>> +
>>         ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start=
, &vaddr_end);
>>         if (ret =3D=3D 1 && pid =3D=3D 1) {
>>                 split_huge_pages_all();
>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools=
/testing/selftests/vm/split_huge_page_test.c
>> index 9f33ddbb3182..0202702f7eda 100644
>> --- a/tools/testing/selftests/vm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
>> @@ -7,11 +7,13 @@
>>  #define _GNU_SOURCE
>>  #include <stdio.h>
>>  #include <stdlib.h>
>> +#include <stdarg.h>
>>  #include <unistd.h>
>>  #include <inttypes.h>
>>  #include <string.h>
>>  #include <fcntl.h>
>>  #include <sys/mman.h>
>> +#include <sys/mount.h>
>>  #include <malloc.h>
>>  #include <stdbool.h>
>>
>> @@ -24,6 +26,9 @@ uint64_t pmd_pagesize;
>>  #define SMAP_PATH "/proc/self/smaps"
>>  #define INPUT_MAX 80
>>
>> +#define PID_FMT "%d,0x%lx,0x%lx"
>> +#define PATH_FMT "%s,0x%lx,0x%lx"
>> +
>>  #define PFN_MASK     ((1UL<<55)-1)
>>  #define KPF_THP      (1UL<<22)
>>
>> @@ -87,13 +92,16 @@ static int write_file(const char *path, const char=
 *buf, size_t buflen)
>>         return (unsigned int) numwritten;
>>  }
>>
>> -static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vad=
dr_end)
>> +static void write_debugfs(const char *fmt, ...)
>>  {
>>         char input[INPUT_MAX];
>>         int ret;
>> +       va_list argp;
>> +
>> +       va_start(argp, fmt);
>> +       ret =3D vsnprintf(input, INPUT_MAX, fmt, argp);
>> +       va_end(argp);
>>
>> -       ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vadd=
r_start,
>> -                       vaddr_end);
>>         if (ret >=3D INPUT_MAX) {
>>                 printf("%s: Debugfs input is too long\n", __func__);
>>                 exit(EXIT_FAILURE);
>> @@ -178,7 +186,8 @@ void split_pmd_thp(void)
>>         }
>>
>>         /* split all THPs */
>> -       write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page=
 + len);
>> +       write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
>> +               (uint64_t)one_page + len);
>>
>>         for (i =3D 0; i < len; i++)
>>                 if (one_page[i] !=3D (char)i) {
>> @@ -269,7 +278,7 @@ void split_pte_mapped_thp(void)
>>         }
>>
>>         /* split all remapped THPs */
>> -       write_debugfs(getpid(), (uint64_t)pte_mapped,
>> +       write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>>                       (uint64_t)pte_mapped + pagesize * 4);
>>
>>         /* smap does not show THPs after mremap, use kpageflags instea=
d */
>> @@ -295,6 +304,65 @@ void split_pte_mapped_thp(void)
>>         close(kpageflags_fd);
>>  }
>>
>> +void split_file_backed_thp(void)
>> +{
>> +       int status;
>> +       int fd;
>> +       ssize_t num_written;
>> +       char tmpfs_template[] =3D "/tmp/thp_split_XXXXXX";
>> +       const char *tmpfs_loc =3D mkdtemp(tmpfs_template);
>> +       char testfile[INPUT_MAX];
>> +
>> +       status =3D mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=3Dalway=
s,size=3D4m");
>> +
>> +       if (status) {
>> +               printf("Unable to create a tmpfs for testing\n");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       status =3D snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_=
loc);
>> +       if (status >=3D INPUT_MAX) {
>> +               printf("Fail to create file-backed THP split testing f=
ile\n");
>> +               goto cleanup;
>> +       }
>> +
>> +       fd =3D open(testfile, O_CREAT|O_WRONLY);
>> +       if (fd =3D=3D -1) {
>> +               perror("Cannot open testing file\n");
>> +               goto cleanup;
>> +       }
>> +
>> +       /* write something to the file, so a file-backed THP can be al=
located */
>> +       num_written =3D write(fd, tmpfs_loc, sizeof(tmpfs_loc));
>> +       close(fd);
>> +
>> +       if (num_written < 1) {
>> +               printf("Fail to write data to testing file\n");
>> +               goto cleanup;
>> +       }
>> +
>> +       /* split the file-backed THP */
>> +       write_debugfs(PATH_FMT, testfile, 0, 1024);
>> +
>> +       status =3D unlink(testfile);
>> +       if (status)
>> +               perror("Cannot remove testing file\n");
>> +
>> +cleanup:
>> +       status =3D umount(tmpfs_loc);
>> +       if (status) {
>> +               printf("Unable to umount %s\n", tmpfs_loc);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +       status =3D rmdir(tmpfs_loc);
>> +       if (status) {
>> +               perror("cannot remove tmp dir");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       printf("file-backed THP split test done, please check dmesg fo=
r more information\n");
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>         if (geteuid() !=3D 0) {
>> @@ -308,6 +376,7 @@ int main(int argc, char **argv)
>>
>>         split_pmd_thp();
>>         split_pte_mapped_thp();
>> +       split_file_backed_thp();
>>
>>         return 0;
>>  }
>> --
>> 2.30.1
>>

Thanks for the comments. :)

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_79110CA8-1A80-4867-87C6-2B0A3D58C98E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBSGZYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKssQP/015uYC/Mp9FcMuvfn6XBvoDsC7e+a2n4ypF
ooEs+pILV2koGPjQnxCPCORzxzngvom5vTWkv1Cv/EyXTRWlfjWzyX3LOj08QrMv
YnkMYSMuuqirVbMm2b0+1MQRim3JkUoyiME6Z91pIznA+x2DNezcEAtvV+/xH8HY
JSXBG++WcpgpyMIkYL+5XEoFFf6FLvrg8FtsjcBORXN0tpkCk0A66MWCNmgFrRqi
FUEg2GuGVMzky/yVcJ99k3G1rtwtkbD0yEdkDKUKE1jHSWMg8xam1fVcVv29eXBs
Vd4OdCK9fZPKY/SYuztrR7iYGP616TAd1KCKaOGwFupOEZHEoJeIHTySO0GAU4kP
HbEsGE05OkcWAAaB2Mcvr1xHYLrvci4ZyGO2oWccoUJ0Llh1RjItnPrE4scrvTIn
wq9y4R8+ppScRVXh81c3VfTN7RbGVjJE2xOL1JITP8+jSwOxGpCxGTv14ZxkWnlZ
NbvV6O4htiKHmigcEbcAaa4RCbc0fBAiX1nBUpAXoolgrO4IdETYJ0gI8qfOE6xd
ButIYdr7GyHzIBr1RuarMnlySvgcGKUEwBM/2SVind668hLq13+CqZa5qjfYp0AV
V748yg/5pAU2Hn6YirodrttC/Ns09HAlCHPzolJdc3GufmO9Gnkt9SgI91bym+96
A7hNEsup
=oxyi
-----END PGP SIGNATURE-----

--=_MailMate_79110CA8-1A80-4867-87C6-2B0A3D58C98E_=--
