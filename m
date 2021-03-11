Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2F33787F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhCKPw7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 10:52:59 -0500
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:45495
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233943AbhCKPwd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 10:52:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br4FhzLL2M2CKKYo2vzwkZ/sHDnei/zJIII1UD4jprqypGu+avLXgog1bnFK9HwTVlqlUbCxxfxi0ilQYzLRkuHnEVwk0By7YswpjJD8Ase1vuNps9JOnFHsfN4k7oqhuChAmg25MG+13aBHt+birf4txwuW7DeBNTyn4HfYKe86h2MUjjZsx234E81P9g4m1NnIB5pOSVrw3W6X+wsgpON1VoylkBIWRU05uozlgSJoOahKmDsuwDCslVSg+z+y7fOgHKXmSZIUtPD1U6AgAW1aLxNNOj3ZOTDljpmNDpvAUacmnFtykQbAsGmB4pqA/naFiEW3qIKh1Ax6iJ5fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQBqN8/Hjka9Q9Y9C2ifg8Vk0pcyecrhhHNnWBzmUIg=;
 b=dx3KyHGTw5tbTvJhPeyV1uN3KsPPVQJBln1kWOpVCxFJmOV+TgYLi+R8DiZaZwUJt5wcDXpg8VedI2brnBFqORuB12X/CHv8a+GgcIxCVJTC7voIzf0krg2nP5XYVEZfyUyMsFJwewJYYv7ny8lhQNgpBE/iWjWXR7UBstWkQRwxk+8Fz0PSc4gedqJgTH9QY2UG8Wo77VydGhlwQcOU5m+6FjX1NRx+fIfGoRmjWZOkpF5fnskVlng2/98E3tiwOjCRHTi4vuqcluHf/e65oTwIwDlxqbOaoSz+Z9rUGYTf7gu7LrXCISfFXOCtQ0fqHerIfrsIxz6EarD0vY1O9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQBqN8/Hjka9Q9Y9C2ifg8Vk0pcyecrhhHNnWBzmUIg=;
 b=VhJQnZSly/Lu75FNjpDKSPuSDdCblCE9UKImSlE3Mh/3WQF+ODg6B6/AWg9CGR6vGA5PELUdOL6Y9BA1NdEWFwgZdsdrJigihJWQEQ8JgIGi+sjo2GcBVhLdMxA1xVkI0xAtsa/FcSAW2BwyXEnorWXgNf+DnSZ2dfNk7tpOzxvIy78hhRT8NVRgDvK83nQ3eH2+Df6mNIk+QgQUl/uJZheACgFEaueEuFpbV6xA0a/SSLl/zEgkIsWY5q+PE7uhu7gPmXdnVlX1dQRXgAEeQKUIX8INAbyPz7N/B8CE10LsHM+lVrI1EuCLsbCvBDuoEP/CcBTG7WXTTpC/uW9gHA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Thu, 11 Mar
 2021 15:52:31 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 15:52:31 +0000
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
Subject: Re: [PATCH v2] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Thu, 11 Mar 2021 10:52:25 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <A3A1CBF3-B5D2-4CF2-97D6-9BC12E82BEAE@nvidia.com>
In-Reply-To: <CAHbLzkqaGqW8_dmR=PBojEVFGU+FfUm2Y+Rhu0Ay8aP1cAChdA@mail.gmail.com>
References: <20210310153544.434160-1-zi.yan@sent.com>
 <CAHbLzkqaGqW8_dmR=PBojEVFGU+FfUm2Y+Rhu0Ay8aP1cAChdA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C7BC74D9-ECED-4338-B45D-2E12B37F2167_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0271.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::6) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.49.51] (216.228.112.22) by BL1PR13CA0271.namprd13.prod.outlook.com (2603:10b6:208:2bc::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Thu, 11 Mar 2021 15:52:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cfe522-c927-4f86-4833-08d8e4a5ada3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47981BB9E8881AE6A46A669AC2909@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LOHb5gCH8fFTSX2B2PQxTV46tRnwB3F+sAFH23Em/0CEx8Zvq2Ks33/Nu98R8CExhF5cBqNrsqiFyRejSDonznFGxladZbIUvVWxg46R09fQjEUN3H0FiwofYI5paYljObvrVnqz0vfqff9eLrQzfDnvPpbLkFYLJVCIFCvPO26vmJirEOi3kpu1b3/txyT/SSzeg0rmOZlP2L9U50EDQfivButuygmx363qcGc7mn/hJkDzDRgISuUN0gKUawAaT0wFhn2k6VTNoWjrvNmjnB7TMQQ/jKX8MKlGdILg4xjLq8UmRf0d54s6r1mFpCsa/RQIMpIdt7KzJTmewmvxZ3NQBGRccuNjdJUtOFgQAr3xdZZRN3PMrAMDa4s/JHZvqdMXS2N04vZ3G+QuplCd+nRw0dhpqUGtITFPjUgkCOiNvJ08S7FK2KMXawKmg5UKY3mL6gAZSVSpP0YhPUy7zk0895bZ/N8AgLixL9a4nmZyGohQ/l/efcOHuXoo1wn+QQQRlJ5DMOnJ1uamSUA7Tr6SNFuDOSxmydlNDWxdQDTyo30kXfFxlaedCXgBhsG8rIL8NrE7eoI9b51D4DNSnegnNxB9SaSiivuircjs1QNpAYctLfeCWs28V/yLO21
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(83380400001)(66556008)(5660300002)(8676002)(53546011)(66476007)(54906003)(8936002)(86362001)(2616005)(26005)(2906002)(6486002)(186003)(16526019)(36756003)(956004)(235185007)(316002)(6666004)(66946007)(33964004)(16576012)(478600001)(7416002)(33656002)(4326008)(6916009)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2YzSWk4anloRXU2STRQc201bWFCYS9lTVp4VmdVcG40Wm91MnIvVFc3MEhW?=
 =?utf-8?B?aVJyekE4K0Y0Q0txOUs4S1hnR2lCM3ZidGFHUnpMUXpGVFBCRE1FaXVxR1B6?=
 =?utf-8?B?SDZGNnQwdE1ZSk1iN2ZYUDFIWlhiMHVmVFlvS3FJQ0xLMmtZUDBOR1J0bFR3?=
 =?utf-8?B?aWY1MXhDdnlscWIzSGlVanNoc2tLcGdQMVVuRGQxTHd3dGpMTUo5UEpLUkxI?=
 =?utf-8?B?RjFGTXQrQmtEOTNCdXlDdndpUXdFOFEyUjN0ai9FR3JEYzZxV3J6QjVaY215?=
 =?utf-8?B?cUpBVzVzSUR4M2h0WlJnR2hGOFV3SlVrSDU2aFlxMCtwWU9OQzg1azJQTUVX?=
 =?utf-8?B?U09kaW5qdGJrSkxDL1VteTdQM2MraDM0aWFKOGN4MEM0OUVqY3JSLzdoWEhB?=
 =?utf-8?B?U1BNRjRnSkZUSnFJQzRtOUZvYUQwN3RJTDBEa2VtYU9oS2NwdDhXcG5PQitH?=
 =?utf-8?B?TXBlY3p0TlBGVkxPekJ1K3c4T0JUK0pXSnNZZEhtRitPRkExZ1QwVmZNNVZV?=
 =?utf-8?B?UnNUY0pReUZJNEZzMmx6RklQamZWdDlzTXV4NXVaV1pKSVl3YWtSVTMzL0F4?=
 =?utf-8?B?YXhGdFFZQWtnNWVXWmdwbCtBbUtxbUNWUU1INmJPaUE4emlFSmVLcHJFR0NC?=
 =?utf-8?B?cFBlaGxsYThVZGMwM0NacEc5amVBc3FpWjBmRnFyZHFQM3duS0pNdmducHY2?=
 =?utf-8?B?Y1AyWEtFeWVYRnByb3RZTC9QSVdGQzJtTGcvR0xOMEZyVXB5NWZDZ1VWdDFJ?=
 =?utf-8?B?WkhoWkU0QUxHcEoxdG1MSTRiNkVXdlJWTFlzQnpiWU9Zbmp5ay81d2NQZ2RV?=
 =?utf-8?B?aExIZDQ1ZWI0QUNpK0hSWXZhMWppY240cG90VDVhbUV0Vzl4d0tqYVRGM1My?=
 =?utf-8?B?dG93TkRLb2ZZcFcxZDJFd0IwRklUNk9kRkhDL3NtVW93aHdHbXkwaDN5MEFX?=
 =?utf-8?B?V2V6UWZDUzJaaUN0Z3B3eSswaExSWXhaZCt5RGZxVUZtc0RhYS9XdHZwSFZn?=
 =?utf-8?B?eWVHSkhFZkh5R1R4TzloeUxKek9qWkhEY0dPcWhxWUdTbmZ3RUp1R0hYYkN0?=
 =?utf-8?B?bWRDbnI0TVlDWEVYTHpmYXBYdWR1MkFzeEFhbG1KWThlaUoyVE0rOGlaMXF0?=
 =?utf-8?B?VldSVU5uUWFydVpNS3NPMWlqZm5BVnkrSVM1NmdlQkdiS0ZtYmZKTE5FYXdz?=
 =?utf-8?B?Z0dTWDRwRFNUenVqQVJERnlzbjJVOG1xYUxMY3NXa1IwVERacEtUS2NmTXkz?=
 =?utf-8?B?a0wreDRVSk5DR1NkaEl3OWdtZFNSM2hPS3o3c1dqWWFXTjl3MHRsTFdTVzV2?=
 =?utf-8?B?L1NHbFY2ZkFmWnpRQ3ZJSS9lVlZtMkw4eFVkcGdiMXQvQXhTa3ZwWC8yNktS?=
 =?utf-8?B?Wm01N0Z2dElqb29vTUJtMFErSFJERWVVaHgyUVRWTjl1K29XSTFQMWc2TUtR?=
 =?utf-8?B?ZE9jb2ozSlFUNDVMcDA5ZkVqS3ZsNURoNms5ODNvbTVkcG5DZXFUZkJoWlNU?=
 =?utf-8?B?OGtYYVI1aDZoZzZKUnd1THg2WlhBdzNCUHU4QWtLVTNURlFXc0FiK3JXZ1dB?=
 =?utf-8?B?NWlMdkNyS3MwNHNFK3ZYdHB0Vm94cmE2Tm1DczQ5VGM2UEF0V0NuMThlSlgw?=
 =?utf-8?B?NHdBWEJ6eG1aeFZRSk1ObXV5MGtPRlR6RDMwR3NtV3d0M05GYWRKenVkcm9p?=
 =?utf-8?B?elZuaDA1RW82L0x0bUdMKy9qcnQvaHZsMStrWUpZaWZVRFhkOS9JM0djZjJZ?=
 =?utf-8?Q?NHZX+YT0lw0Uw0WFuIUVIJ+zGKbli++dwCp1kSZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cfe522-c927-4f86-4833-08d8e4a5ada3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 15:52:31.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW4mVRLvEbqPQMZiGzxdnyhlTN8FMP1QRXKHRdGFCTook+1GkHY411q8itwEDq3m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_C7BC74D9-ECED-4338-B45D-2E12B37F2167_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Mar 2021, at 20:12, Yang Shi wrote:

> On Wed, Mar 10, 2021 at 7:36 AM Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We do not have a direct user interface of splitting the compound page
>> backing a THP and there is no need unless we want to expose the THP
>> implementation details to users. Adding an interface for debugging.
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages_in_range_pid, THPs within the given virtual=

>
> Can we reuse the existing split_huge_page knob instead of creating a ne=
w one?
>
> Two knobs for splitting huge pages on debugging purpose seem
> overkilling to me IMHO. I'm wondering if we could check if a special
> value (e.g. 1 or -1) is written then split all THPs as split_huge_page
> knob does?
>
> I don't think this interface is used widely so the risk should be very
> low for breaking userspace.

Thanks for the suggestion.

I prefer a separate interface to keep input handling simpler. I am also
planning to enhance this interface later to enable splitting huge pages
to any lower order when Matthew Wilcox=E2=80=99s large page in page cache=
 gets in,
so it is better to keep it separate from existing split_huge_pages.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C7BC74D9-ECED-4338-B45D-2E12B37F2167_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBKPLkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK/4QP/1dxavX0w0G8RD5iVNwQfkVgpLAkZDXieitV
8AdDwks47bew/sDhj7CC4TrdESB3+kPMFDE9Bwon/bpj7j6TDU9oWUYknLjnIKwY
slML3JTh/0Sv/17vkcHpE77ZIPv/GI+Vs5y+7Et1TXNpA58BV7N2gB7GpbymDqvL
97idRka5nIUsi7ISTojMZz+zZ272LELkgffIJZzNBCO7l23w06yUWZ0AL7GN7AFm
TJFESftRYm2eZOwwBlkpE2pzoyAsBS9w9QantpS+zLgd+f0118zzrPkUVlwMAn+w
ZRWIg29RJGtQuG3aE4ODOvbUSf8P7L355hbTKeE6QdPPwC9qz3JpUayC5krWPstq
J0BO2CNI/in+qKA0ONg8mH7ae83LqqRzzjfu5maMDZQoT/WCBz13U2rJ54tH++Yn
TFzudCSSMsryvyK28jjLgiw8APLS24LPIORKJq6cplRHyOOKO5pT6BP4TIWsvzox
XU9cSqfp6aOT6DVFCNKhdoOTGJN+i1/V4ToLjogikGVf7TV2kDqVAeZ7DV93jxof
hDBkUXUYz5zNq4E8zTQ+0coTyfIcvNjQ4ziVQpkmQ4B/Ch5uo8+M861KjNzzfnKl
m2M607vrJXU0RqdcE2O+/yotBxQ4y3ok0qHDIYT6QOPePX3WdVEU9YRHd+cvVJdX
Pf7pzkjK
=c6PJ
-----END PGP SIGNATURE-----

--=_MailMate_C7BC74D9-ECED-4338-B45D-2E12B37F2167_=--
