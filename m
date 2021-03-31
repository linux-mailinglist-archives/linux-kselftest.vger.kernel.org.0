Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90A350530
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhCaRBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 13:01:43 -0400
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:15073
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233977AbhCaRBX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 13:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er+lEFJTHVqoQfMKb5Ti5lrEGSW7yL9tguxkKZi/kmll3xJzYyUjYlXIKUp6AogeIPPXRiRvptNtwa8q36gyS7ZGyYc4ZFG8/qoKXR9THT957LWS3tp/KeYPxt2Qy2+dqaxCgX5z2iiQRXu6ILYDyoES06T6MR60VFywpWu4T1kv3JIg9gSQUdQM46KEsoBCmv1VlQ0tlkz3+M44JFaYmxJuvuR7+jCIo1y7VQqDdrnTWroBxIac1UB4lZLGgjoDi58ZNMPQypjfwczpg08hdjuFQyc9mW9IG5krJaEZmiMrgW2XqkXOOLSfD9QgOhjtKexIfKsJRGma6iYBuHtCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxrZGVzhdBk+qVz6ENAMRiiXIw6j2GzK7mHX/54hKrU=;
 b=TukzkbUwbmBd8nyJopwLePU5QyyoQ8D0C7DQ20oCkqYGcFkqieGn1QWhHZIM6tvilC4UjPZV+waROEGch/nwH9vfeU4T+KVAn0smF8Pu4FswxVbJ+W8t+Tw/gCUy+XRl94KFQq/6H/12EaTlZIJI0osJAok0L9B67Vfw7YTRyd4iAGp8ydKv2groMot6Ext6c9RDWAMlqwlUTPw4H8taenSRik6JYUyCKSUaLzSMXem0xYzcupWu3Blah+mqgT5paHKSe52x8TanhoIWf9o4DtFxiBQDJKVhkfc+2j8Z5/MxuK9WQ+QhYUJUlqw+OIn4YlLXc1lfV8Rw6MPLq+dkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxrZGVzhdBk+qVz6ENAMRiiXIw6j2GzK7mHX/54hKrU=;
 b=ccuiFAp2wmRZzZF5763h4qU2VNH/76RDBAyyHxGVeee+OT0V/PjE4dOZXV27zDP7h4MguW9IyuLZr9qgJMLQPNYukxD8lN9e43dSO6Wdw9OCLkfkc4LafoxDlTJqghMSO0xe7zzVvfBuSGENeAsKNI6mGqEoXnaZiAPuvF4fWVIB3gJPN0EjYBtO4o1OLNmkNm1vIjnjuS+kzyvmbRgyxy2/Rem5PJbAMB/KZy8KXlc1Qum1BiY8fB5N/oyZjEw46iTU7DkXVlgkf1L2+PbUFMPmz5VEz0pFJnkbie+32gJnf0XENJNS6IH2Nad3qb02/BKYtOFCw5GKFubRPftT6Q==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 17:01:21 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 17:01:21 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>,
        "David Rientjes" <rientjes@google.com>
Subject: Re: [PATCH v7 2/2] mm: huge_memory: debugfs for file-backed THP
 split.
Date:   Wed, 31 Mar 2021 13:00:08 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <B74255A8-0103-4888-830B-0ADC60947E8E@nvidia.com>
In-Reply-To: <20210331164438.GY351017@casper.infradead.org>
References: <20210329153932.134510-1-zi.yan@sent.com>
 <20210329153932.134510-2-zi.yan@sent.com>
 <20210331164438.GY351017@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_E13773CD-6198-4991-90A3-3A050FA36886_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.57.140] (216.228.112.21) by BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Wed, 31 Mar 2021 17:01:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec916c1-ad4b-4e8d-73d0-08d8f4669bcf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4238ABB2E89C2406FDC8A603C27C9@MN2PR12MB4238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfYtgFayIF1fhH+yROji/0b5r2RwJiD1Kg80kilUZZRWU4IremqG+iJOTgC7DMDcGsPAZa1AjBgOR816TpCgy7MBc20R2Zl+IR4+FEWcgcPEa+77yMUTDbH03wNemOPXAtbjCzbp91VO83jQkb0Pcy9Dxl6Xm4aZu5iB+A1f3bBD0mnrZmF7P4RjW/gCNgaCa35/z2L+5ubUlNQlpWK7Dpegf6VTFcAH7rEMQbH9IvI55kN1P9GjHizuQakR2Pz+t0wQ+YjcnjBVgKvyG84SOpwL7eoiKLoHBjdfmVjiJrrr1y7NS24iDZ8jX7lDRaQMsu2D8zU+myIsWBS1gFcMK15Ei/8vR2EsmnmDkHwCPkKLSZHdeTNfcMCbDM9b4vwTYrFO/VL5w3sS7wQ/WPBUcxxSyYZUwM31Y6ySO7tl4EKxwzn2DO89cWqXDyTFPoJAQRBarWGBepr8WzUp2FytHz72NtexJL7R9bkZGV6W9yHCUaoaUTrhb+6cWlD4wgVFAZMNUl0Tx8pNixfSWpEm1f0i2+7wUITyy+blXl7NmSmh2omcw1siMNJ0X/XfewFv00czrLxljQd/L+Fz4t3SOMZLnziO1tgHtExyijbLBwlGsW7ps7to7UpSy+G6Cpqyr64+1SupK5edXEhyPfcUOQ2/djotD5aQ/hzqB2I5QhbFXjnqaMJqLst3U7TNtSg/KDOMCUQ71zOyXMRFzAJbCVC5J7ft/tuA/VhqPlfomA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(316002)(2616005)(54906003)(6916009)(33656002)(956004)(2906002)(16576012)(66476007)(36756003)(66946007)(4326008)(6666004)(66556008)(53546011)(7416002)(26005)(8676002)(8936002)(478600001)(235185007)(186003)(33964004)(86362001)(5660300002)(6486002)(38100700001)(16526019)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnZoR1RFdmNoODNJdTZKUEZrSjdVb3VnVUduVXppY1Q5NTlUd3BGVHJxTFJV?=
 =?utf-8?B?RSsrY1o0UkwxbEF6ZGkxTlU1QkFPSjNQMW5hNHNhUkRVd0dGKzViY2REVmRW?=
 =?utf-8?B?UjFDMTlVR0dWWXR0QnhjTkNLM3hBOHZyVHk3REFLbGwzbERRUFJVZE5ydHdS?=
 =?utf-8?B?THlmRFZCbVIyUEVOWEtTMTZkcWhiajlmaXRYcGF3RXNjM3NXYVVaYlVLemdZ?=
 =?utf-8?B?RFprdDlsMGVZZWhMdXFJQ3BMbUxyZThzcDZKU3ZrbWRrZU81WXJUeUxwSFE2?=
 =?utf-8?B?VmpnNm9YSW9rbDNWVHVRNE1aZTdJdTRsaFNKOGVjb0k0RS9PeCswMDRQTW1j?=
 =?utf-8?B?QWEwdE1MT3VSYWtmL3VBTklLL2hhYXJyS1M3bUxwL0RIUVpiRnZEZjZKVmRh?=
 =?utf-8?B?c0hWK21kYkYzMGlRa21xS3IwYytqQXFURENrWmJFNFhyWFRwazRIWEQ0eHhm?=
 =?utf-8?B?RmVtS1laL2Z1dEk3bVFMaUdjVVIxajVxbDE5MjlFQ1pLT3VPcmdwLzhqZy9F?=
 =?utf-8?B?a0h2OXYrRmNxdzkrY3J1TXVxTlZYYW55biswTVF0NXdVLzVmSHVGYjlUWWFv?=
 =?utf-8?B?clJIa1hIRm1neElycWpRZi93TEl2U2JtMFN2MDlCUjR3T29vRmlPNVpzcUxh?=
 =?utf-8?B?NEdKYTQ1Zkw2dXpnOHdZNTZpWjVkeUhnemhheUJ0STZUTnl3czJOak96WW1H?=
 =?utf-8?B?YTNCNWxPOEtqbVFORVN4NThSdkVaL1ZkdnVhY2NnVEZUOWpKSTlyc3ZhdWdv?=
 =?utf-8?B?cHM5Yk5PYmFwazJOT2tFN25mWWlOaW9SckladlN3RUVEY01sNnU0blpDR1BM?=
 =?utf-8?B?a3cxNys1Z2YrMVlhWmRuU204ZnVDSmhQSUg4VEhCOVJHSDhlanVLVWF5eTZp?=
 =?utf-8?B?SlFHcWNJRStUYWlsUTl5UDdpM0N1SWVObkwzaHVIWklnUGdUM3JCYVVZZHpE?=
 =?utf-8?B?VmxxRjZ4N0RkT1dIcHhWRHA4a1FaMTRjdVE4SGdRazc5SGVYYnRHNi9xY3RR?=
 =?utf-8?B?RTBsSFIvOWRhcmVYM0xFY1BmSkplT01IZHFUTTU2dWdYWVZESWRhM0ZjMVFH?=
 =?utf-8?B?NVlUaUR1MHlqTUtoVDRGSE9TWC9MUkxJellWdFFYZW5tS2lGRnBGY0g2TWpD?=
 =?utf-8?B?ZnpMUUtGN3lxRjZNVzgzOGIxZGNLRnNwUDZjbUdzejV1QldWeGpGUTgrcTlq?=
 =?utf-8?B?eDkxNHJrRzJUa1JpN3l3RWJhMS85cVpqbFlPbHlTZlRHSUdaZzJNekhDZ1lT?=
 =?utf-8?B?U1BBQ21QU3RqdzRqQXJCaGxwNGNXMWR5QXF6eURMZkFFdWxXZnplcWVnVzQ3?=
 =?utf-8?B?bzJWNUs0TGNzWGpYRm1QVVRxaDcwWGNlemljMUNpM21MZXU4cHlQRDY4RVBi?=
 =?utf-8?B?dUovN2FHRW5FRmFxd3JiYWprRzUwczNrQnRkczF0OEprQmNIN2o5dnV1SmpM?=
 =?utf-8?B?ZGgxRjNXVGRpZ0p6M3RZaDVVN2hwMUFJS3A2Mk9MV2N0NW1hYkFhcThQRklE?=
 =?utf-8?B?TnVZWWtxejgvWHFLRi85anhvUGN2SlhIWVlmemlCM2MrbmhHc0t0TlVBZFZU?=
 =?utf-8?B?NFVXNHg3MnNwNlAxa1ZXT2JHRjlpQ0hkWDdLenR6TEd0eXJHMC9iZjJtaEds?=
 =?utf-8?B?YkUzdmg5bG92MmpkTjgwSmJNZkJkQ0R2YjJ1ZGljTzB2MSs0NjczaXI4UFVr?=
 =?utf-8?B?SW5HcUdtTG83bkhhOWJwd3lsM2NXc0g4djE3RGVjOTI3MDhZSS83Zk5vVFZ2?=
 =?utf-8?Q?fyujsAqQKClgnHr1WLGCvVW0F+8PqifsLi3yv2q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec916c1-ad4b-4e8d-73d0-08d8f4669bcf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:01:21.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLtomP0CeHF70MPOakbs1JsMKJHAQxoxN+hD+gkCGxq4vWeDqYNX0caywr1GzkTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_E13773CD-6198-4991-90A3-3A050FA36886_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 31 Mar 2021, at 12:44, Matthew Wilcox wrote:

> On Mon, Mar 29, 2021 at 11:39:32AM -0400, Zi Yan wrote:
>> +	for (off_cur =3D off_start; off_cur < off_end;) {
>> +		struct page *fpage =3D pagecache_get_page(mapping, off_cur,
>> +						FGP_ENTRY | FGP_HEAD, 0);
>> +
>> +		if (xa_is_value(fpage) || !fpage) {
>> +			off_cur +=3D PAGE_SIZE;
>> +			continue;
>> +		}
>> +
>> +		if (!is_transparent_hugepage(fpage)) {
>> +			off_cur +=3D PAGE_SIZE;
>> +			goto next;
>> +		}
>> +		total++;
>> +		off_cur =3D fpage->index + thp_size(fpage);
>
> That can't be right.  fpage->index is in units of pages and thp_size is=

> in units of bytes.  I wish C had a better type system.
> I think you meant:
>
> 		off_cur =3D fpage->index + thp_nr_pages(fpage);
>
> Also, I think this loop would read better as ...
>
> 	for (index =3D off_start; index < off_end; index +=3D nr_pages) {
> 		struct page *fpage =3D pagecache_get_page(mapping, index,
> 						FGP_ENTRY | FGP_HEAD, 0);
> 		nr_pages =3D 1;
> 		if (xa_is_value(fpage) || !fpage)
> 			continue;
> 		if (!is_transparent_hugepage(fpage))
> 			goto next;
> 		total++;
> 		nr_pages =3D thp_nr_pages(fpage);
> ...

Thanks for catching this! I mixed this with looping through VMA, which
is in units of bytes. I will fix this and use your suggested loop code.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E13773CD-6198-4991-90A3-3A050FA36886_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBkqpgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBCoQAIKcwYCQUlrelGG3S1n5yp2RLrpwV4fPQ4tX
ooTwWpJAd7nxWeZxKeMuwZlm9UfCpzZHqLy7KZ8KVhuiDpNdvW8Z5UveiI8mEThC
y8hO+rZjKCtu9i1ZI8ZAudHbWAl5So10eVDOiGzNm6YYfVHnshbxF+M40sCV/0vv
b3Vac4cWsA9+cT6UN8xjJsJP+ByAYTf7e3nv/xcXgdBHAhayXFY809sv/vuFD7bC
jGNS6q3eORqMq35opNaxAX1O3u9cWBoVlW9DOQGGt9U0NfKryfqpzRLAAtQMvGOs
6GaPILd7MvKFygusTvTalIZLsTj0No1cGsgmGlcbYho8Ew67/vRlU9d9xqBfv6Tn
y8l2jALKZyotSA0q5ZiG6CyAT+ggtSb8pKlMhfyxmQF8DbPqShaptNjVjp3Aivn3
9Mv8DqD9Ql/fNd9+/CPN9EbEdBVWMyxmNiOSgpDAVWO7BUDHIxZqGdw2/0Og/oD1
RQGbUGbscj950n3AwU/9P2cxmst766yAYSa43cebH8RWFE9wVLJfpv/x2klRtSNO
uZCn3ZjhxY9X+pWRjR4c07SbP5vyy/gAurrZmFu+wMXK0xJiLjaYt1fVWypcqAT3
zngcvvT/LkQ0leJzUToF3H8toXR4gF2dJ9kozCBF22pBj16EjKboB84k0M4dgECH
nXbB/kbD
=jbC/
-----END PGP SIGNATURE-----

--=_MailMate_E13773CD-6198-4991-90A3-3A050FA36886_=--
