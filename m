Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0665633CA90
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCPBKj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 21:10:39 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:11669
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhCPBKS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 21:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWfx9x8lT1HXPf1rVsx53jT9576JQPSzeS+vpL2mxXadfzlG1c66aBjVxfSoOGHPiim7+6vKVuGHWGzHreR3ZBZIFjKjcws1Aw1ydLn3qZe504Df4NEiZXUMfWPKL2+vTjjR7p2Cn7DlQd/zWtxGZjsVHIpw9E4vx/G9PA+GzwaCyXLnOLC2o5W5PPoztfXe63NDWI4pV/rDS8uZhyuMh75XwhzqG6GSSNqoHulk0lKXmJEEYmVBl8JTYz/7Ie5iA6hPnQvrnbWkKWGfUJBzr69bdF7xReyfNbMtYZkfEapextUa8BCvuYMUsq8l8KXSRyBe3cBlQrT9jjPU5Bh5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeV0w8bSY4iAJDxmIYcvr/0T6CyoiuNt82kk+7nC0Dw=;
 b=XdNtjScJJtsesl+KfPNijiCuycx4gstNS/vN55utfG4FHKEZWPzH0ZuQrxwkhF8rrj0xFOGfpFPK4xBODsk8uDtsAeZY2kTGbg0Pi3le15ZFHK/FJ+KdXcflWR8BFv5iW1PeSnnduAsErK8PIRODLukubwUUVCeQcYuBjEy6jZQucMGkBcvVAzzLVTzbC9UnREitDhHYOmWMqiqsRSrNVJygxZBADM66DuqVtERRoESmpWk5lDXG1fULr80yAx8y96grpDgvUUTNE1ZRWqmGWQX8Abh03Hf+E+q8douoswEiiDMmh9zRUUc3491c446XnOxxyv/Fv6opI0oFHCYHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeV0w8bSY4iAJDxmIYcvr/0T6CyoiuNt82kk+7nC0Dw=;
 b=KB0wakReEiLgbD5G4jwPsWstDSc3Fmbq7c4xnFMngCmsW9jgC2NNMCD48FupM3UuEgQK3lStCtpcduqK3P+XibLlE94c4sH+1rAuNH4H1dcky/+y7pbkI4ZZDou8nBKin58aRLIqIiG0OwxSvBrat8wdlub8nRFm+jslgIl333xDooumVVth+krTlnj7Mo2kBE9rGKXB1VRA0+MoRq6QV1m7YJTTITG15Nln8+hdbS6CvSdgbVpEzG/P0DzFIbM6VqyIqrkIcNVNQy2/ps4Oc5WSek61Ep5JR8vQb/n17Tw5wSaMTaC62gamPiOxTJYlKG6iraKLKeJxBOKzycECmw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 01:10:15 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 01:10:15 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "kernel test robot" <lkp@intel.com>
Cc:     "Zi Yan" <zi.yan@sent.com>, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>
Subject: Re: [PATCH v4 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
Date:   Mon, 15 Mar 2021 21:10:08 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <F969CAE6-AEC4-4FEE-A200-74110A042C8D@nvidia.com>
In-Reply-To: <202103160807.JLJ4NOSP-lkp@intel.com>
References: <20210315203349.171760-1-zi.yan@sent.com>
 <202103160807.JLJ4NOSP-lkp@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1475C6EF-9477-476E-972A-70A623798DE8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Tue, 16 Mar 2021 01:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1262500-7751-46da-02b6-08d8e8184170
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3856F4826010937623574B02C26B9@MN2PR12MB3856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNVJDgoiIvorpvcH0XRUEkIdQ100ee/K3NBzAh3p6RRfQTKRCDEZ1azKRqeBc86TfewAcrePOMmkLW5YgQ8AfCvF5EDAQRTfJ24GnmicWJoj87l0io4wV+/SJ0j9iQlIOfGm1cpMj7OdPT+OJLBwLYHn7pAxZG5zfWGS+bKunuH27ot+4rdBAtXmyK/VnhfVutFlDD2h9hFGQlmTHoqrMncgCxC/zFq9NJQf8xZC36LdFoJX8LLXMOjUBghr19lu0FL/6jG6l1UOSX4onz3Zc3JF3ZgB6zNBfyfT9NDTzS9DnVuI+mDE7k9QcPHT+AjkJBbIuag0s/JjFtlXJqcKxyO37xqe/1oJWJICWJ9sFzLzKNOoKZSL7xSwTJj99joSNitfvtvdkabq6zFHsX8DDFfL+PqzrwPtzzVHLy/mzhwyLuAEEZszjkMbMIAY2sesXAP7MBegd9OUIHYia0+fw/Ii5zd0e9DM/Iak0/vLiHA2rEDMO+0V/80uGwXGba7VRf+wL1OOioKZO/5HbFjXhfOpg4AAvO19Q7C3DBjdJ3CG7iRK50o5XKUcmM2z5CnorlvN/+f6NL3SR7rza8w55Qbiac5JK6tTiCIYYfnlHpIx5RP6uNcZlxP43BwSovfAwfd40JZS0SL+xyPm28SQtRA9o5TjLcxVuwrLszGiL5jEuyXzUeAcQdH5EiEmxPrZSh+iP05K6ibnB7KcV9frjoLQcdIxqmNJ939xD22rPuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(16526019)(2906002)(316002)(6486002)(8676002)(186003)(6916009)(26005)(235185007)(83380400001)(54906003)(86362001)(53546011)(66556008)(956004)(8936002)(66946007)(33964004)(66476007)(33656002)(36756003)(16576012)(478600001)(7416002)(5660300002)(2616005)(6666004)(4326008)(966005)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0ZTNHVUZnBUMjhoSFY3K3FtWWZPUkMyejdyYU5aZkJLa09hZnRKSVVPWjE5?=
 =?utf-8?B?dXpXeldBVFo2V1NYaldxTUFuaCtKdWcrL1JiNmk2UDM4RmxCeFpIUWhhbUZN?=
 =?utf-8?B?RTg5ckhEdTlud3hYZDdDUS9hUHNQU1lYdGZNczlza0I0M3VJbjZKR2NFUzF1?=
 =?utf-8?B?WlQza3ZnamJ4NzJ0WDZ6K1JpS2E0d0hoZlB4a1ZWTGx2L3hKcFY4c0VDN1pp?=
 =?utf-8?B?Q2RGMlRUYThuQlFCTkJKUEhLVmNlSG56Z1VuY29YK1ZlQkQrbko5M2ErYWow?=
 =?utf-8?B?TXptZEdhYlhVZWpWZ0JHcGsxd2pwUHRxOGdFTWFOVloyTG0rQmZRUElUZ3Z3?=
 =?utf-8?B?QVhSSmNZSnFrY3Z6ZlUvQmJUS0tnbHJKVU9FeHlZbGNKWXE0d0ZCNXBuaEVk?=
 =?utf-8?B?aGVhNndvQkh2clFvTy9XNnorbmtMbGNuOWhKcVl6bHVxejVNUy8vcGprZGg5?=
 =?utf-8?B?dHUxdVA3SlRONm1BaUxVTTB4SjhEazluODJCY3JFTCtYeHhpTTZUZVFoc00z?=
 =?utf-8?B?c0RtSHdoVTZMOFozZlFhbk15Y2VCWlkxWklzQWx6UUF1cTA2NTVCRXBobXhy?=
 =?utf-8?B?UFlUUjEwSVFOOElMN1d2MnpLbWg2NHEwaEJ0REVZdGNQRG11VjAydFdQSzRr?=
 =?utf-8?B?eG1MOEQvaXBhVnVCSGRqT1N3c0s0R2NQOTB6R2lnQUhVSmN5Rzd4NkdxVGpS?=
 =?utf-8?B?bXVDV3MvWGJUOUJtTFM4MldmWlY5am53YmdVbUx1Nk5VSVVUWjNjWWFCMEw4?=
 =?utf-8?B?UnRuejhqeWdleWlYUWxMVytMcW5kanR3VGNycThkazBYSEloUnc4NnljS3gv?=
 =?utf-8?B?RHZVc0daREowVHd3QURKTEdmM2NSVW1ZamJCSnA3aDQvUXA0N0JVYk1Mc2Ir?=
 =?utf-8?B?bUZyMFhNdWZGODRpN2RoS1F4MC9ad3ltemhFOExmR3FNUTJYYWw1d0hobzNB?=
 =?utf-8?B?WWNZNysveUEyMElNL2ZGNzUvY0FvQjBhcVVJSEpZb1VjM0RaRVRmci9OWVV0?=
 =?utf-8?B?cXFhSForNHlVbi9vMTdjc04yRGFxcFd4eU9TU2lSM0phRnY1Y214ZGt3Mysr?=
 =?utf-8?B?Z1JraDkvbElOOUdLbDVFRWxJRzBla0RUcEJoQ05ZajJweXdJS1YrU3pyZm5s?=
 =?utf-8?B?TGZJWFE4U3REbTRUcFJwam84ZDJIN0wreFpML2JvUDVHR0ttK1ZuOGo4UXVr?=
 =?utf-8?B?SUNxQU1sd0gzd3RaWDN0OXJpMkZVM1A3OUxMMThaZkJmQ2NndXJ3S3lCc2du?=
 =?utf-8?B?TG94OGhaR0d3RHdqZndsK0FuT3pVSVVTNGIyekN3eEtqSFBzSm5oQ1ZpS1cw?=
 =?utf-8?B?WCtaZ3BUTHl5OFVlNkE3THpxdjFoVnpadjdCaXp3WFRFOXlqNENVbkNNMlBy?=
 =?utf-8?B?WVhnQTBXQ1hOZ0Q4cGhaeGsrYXJJdFdkOXl1b3RucnY5aDJ4c2djbGpxaEsx?=
 =?utf-8?B?Y2o5SjRYMHZadTAzVlFCeXFZTWtiTFVsWkFadEo2M1pmYVFKMlo0UEdtK3pB?=
 =?utf-8?B?ckE0ZER1bldQT0tlenQydGlFSUhpeU0yTVp1S29hMFhpNWR5LzNqcjdBcFQz?=
 =?utf-8?B?RG5IcVRoY08ybTd4YzlsOTZJWHIwd1dxSHlCSWxVZWFOUHVpbm9iMUI4Snl4?=
 =?utf-8?B?K3duREo1VlFoZGxSb3gvN2luMGhFWUMxL25aNGhCWXlwZEp4aVdQcmd0MFZL?=
 =?utf-8?B?U0daRkkzKzc0ZS9mUE9weGFQYXlQNjBTRS9JYTB0cDZ3RGhXOG4zNnFOaTha?=
 =?utf-8?Q?A7UQ4EafuWXhQP8oMV7kCanzKK8ogcfQKpwfrKG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1262500-7751-46da-02b6-08d8e8184170
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 01:10:14.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljH/wAShSycEmfYjAmW53QAJ4wLXaqjL26TB2tksK/NdbACu39ljFWm7WabJzIZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_1475C6EF-9477-476E-972A-70A623798DE8_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 15 Mar 2021, at 20:36, kernel test robot wrote:

> Hi Zi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on kselftest/next]
> [also build test WARNING on linux/master linus/master v5.12-rc3]
> [cannot apply to hnaz-linux-mm/master next-20210315]
> [If your patch is applied to the wrong git tree, kindly drop us a note.=

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Zi-Yan/mm-huge_memory-=
a-new-debugfs-interface-for-splitting-THP-tests/20210316-043528
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git next
> config: i386-randconfig-m021-20210315 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> smatch warnings:
> mm/huge_memory.c:3086 split_huge_pages_write() warn: sscanf doesn't ret=
urn error codes
>
> vim +3086 mm/huge_memory.c
>
>   3051	=

>   3052	static ssize_t split_huge_pages_write(struct file *file, const c=
har __user *buf,
>   3053					size_t count, loff_t *ppops)
>   3054	{
>   3055		static DEFINE_MUTEX(mutex);
>   3056		ssize_t ret;
>   3057		char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>   3058		int pid;
>   3059		unsigned long vaddr_start, vaddr_end;
>   3060	=

>   3061		ret =3D mutex_lock_interruptible(&mutex);
>   3062		if (ret)
>   3063			return ret;
>   3064	=

>   3065		ret =3D -EFAULT;
>   3066	=

>   3067		memset(input_buf, 0, 80);
>   3068		if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>   3069			goto out;
>   3070	=

>   3071		input_buf[79] =3D '\0';
>   3072		ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start,=
 &vaddr_end);
>   3073		if (ret =3D=3D 1 && pid =3D=3D 1) {
>   3074			split_huge_pages_all();
>   3075			ret =3D strlen(input_buf);
>   3076			goto out;
>   3077		} else if (ret !=3D 3) {
>   3078			ret =3D -EINVAL;
>   3079			goto out;
>   3080		}
>   3081	=

>   3082		if (!split_huge_pages_pid(pid, vaddr_start, vaddr_end))
>   3083			ret =3D strlen(input_buf);

Change this to:

ret =3D split_huge_pages_pid(pid, vaddr_start, vaddr_end);
if (!ret)
	ret =3D strlen(input_buf);

should fix the warning. I will resend after I get feedback for the patche=
s.


>   3084	out:
>   3085		mutex_unlock(&mutex);
>> 3086		return ret;
>   3087	=






=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_1475C6EF-9477-476E-972A-70A623798DE8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBQBXAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzTMP/389v2RdmQZHHFvVDC5yWJ5ecJ7HS8jFesOB
VciW4n748dsMTQCSRuejnHbl/8O1EQFjFJpwZwivVqg01S425Jh1NWLp3zth34IU
eWSfNsQISc5Q7lOKDx2Ec7Cn/rBTUzD9iTOAXgQinSCeVQ4WbxyZAITPKdIwOfLZ
UAv2WpMJphq+D1vLg7M3RUFbBwiqnP5/Zs7+/VSlPCTdR6trBV4IZSZaLKGwJ13x
diNnRol4oNFNUQUtzfA6cn1m4VZHTzjNFHFhiyOCi6UnJJrDcHlEvb6tD+Xv0LXR
rs23UvwDZlkLtnNBf6SP0zKthwiR5FjCyXukGd9U+AD25ihd9MjauETVEnWgkM1I
IpgNl5TqQF3b1pMXthwZx8Vw23LJgoDakQBFxWu9Rn5QYMLQYQsV3vL+fbxQjuXS
BMA0wCUmBjvlhylTtIgoLFvvI3N3hEquqvJzRqZNCx4O8+ZRuVkJS4anVokrbL93
SCwhAQt85LVDmBqknELwfgP9rOvrmGnFzetKNoKvAOA/C4ac32+p/Wcnch+SYtsi
4EatEcyUMwAZXno2WSym+kBfoDh06LxVREUAjIUFxzB4B7B2fJIPIiWLY6IGQeBE
GUx+OOlkl1h+5ILUjM78Tuo8NXHs2QK72Mm11VLut4wci12zEXJeiir18s94raLC
c8MZOLPM
=3Mv1
-----END PGP SIGNATURE-----

--=_MailMate_1475C6EF-9477-476E-972A-70A623798DE8_=--
