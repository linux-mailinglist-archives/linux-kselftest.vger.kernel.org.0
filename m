Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A832B11DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgKLWhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:37:45 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18724 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKLWhm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:37:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb9300001>; Thu, 12 Nov 2020 14:37:36 -0800
Received: from [10.2.174.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:37:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 5/6] mm: truncate: split thp to a non-zero order if
 possible.
Date:   Thu, 12 Nov 2020 17:37:34 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <77E2A434-4A28-4161-B145-8DC951BFA603@nvidia.com>
In-Reply-To: <fb468c74-7da3-8b2c-e98e-ebb12793846e@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-6-zi.yan@sent.com>
 <fb468c74-7da3-8b2c-e98e-ebb12793846e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_DC93BADE-3D24-418E-81A1-0357978B8C2A_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605220656; bh=u2Hc1y/LdwmxJ07kFzHTWkMeNNuGrh2xp9EB8qf+MPM=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=Cp52WUxE2zzHXlicgvLYOIV/DH/0TQjyg06bXeBk60CirarrkMb1wJqd2QIa2kVYi
         qEfg5AEnVWBKzN4DktY80mNq54FeijlfrjKBTZamOkz3qcOxHu/l0FfdBXpJWtW5Rz
         De8BoZMJqyiGrRQZbgYZ+7SQZsZFFmI567OFJWTdIgXzJ+J11fnJe94/YHxcUa/oJa
         Jxqn1mtTNZl7zX4Hc82sKkSh585xQMhBXzcV3sBG77VnKhVsL7qRctrsyrnFHuQk3y
         51NRW2gNaRrgHuphDhSfqBywckDgW7pfIcvtFzzOmtWBnYCkCDqNlGdzfLiFm2wpme
         4GrsduN1H1r6g==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_DC93BADE-3D24-418E-81A1-0357978B8C2A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 17:08, Ralph Campbell wrote:

> On 11/11/20 12:40 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To minimize the number of pages after a truncation, when truncating a
>> THP, we do not need to split it all the way down to order-0. The THP h=
as
>> at most three parts, the part before offset, the part to be truncated,=

>> the part left at the end. Use the non-zero minimum of them to decide
>> what order we split the THP to.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/truncate.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 20bd17538ec2..6d8e3c6115bc 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -237,7 +237,7 @@ int truncate_inode_page(struct address_space *mapp=
ing, struct page *page)
>>   bool truncate_inode_partial_page(struct page *page, loff_t start, lo=
ff_t end)
>>   {
>>   	loff_t pos =3D page_offset(page);
>> -	unsigned int offset, length;
>> +	unsigned int offset, length, left, min_subpage_size =3D PAGE_SIZE;
>
> Maybe use "remaining" instead of "left" since I think of the latter as =
the length of the
> left side (offset).

Sure. Will change the name.

>
>>   	if (pos < start)
>>   		offset =3D start - pos;
>> @@ -248,6 +248,7 @@ bool truncate_inode_partial_page(struct page *page=
, loff_t start, loff_t end)
>>   		length =3D length - offset;
>>   	else
>>   		length =3D end + 1 - pos - offset;
>> +	left =3D thp_size(page) - offset - length;
>>    	wait_on_page_writeback(page);
>>   	if (length =3D=3D thp_size(page)) {
>> @@ -267,7 +268,24 @@ bool truncate_inode_partial_page(struct page *pag=
e, loff_t start, loff_t end)
>>   		do_invalidatepage(page, offset, length);
>>   	if (!PageTransHuge(page))
>>   		return true;
>> -	return split_huge_page(page) =3D=3D 0;
>> +
>> +	/*
>> +	 * find the non-zero minimum of offset, length, and left and use it =
to
>> +	 * decide the new order of the page after split
>> +	 */
>> +	if (offset && left)
>> +		min_subpage_size =3D min_t(unsigned int,
>> +					 min_t(unsigned int, offset, length),
>> +					 left);
>> +	else if (!offset)
>> +		min_subpage_size =3D min_t(unsigned int, length, left);
>> +	else /* !left */
>> +		min_subpage_size =3D min_t(unsigned int, length, offset);
>> +
>> +	min_subpage_size =3D max_t(unsigned int, PAGE_SIZE, min_subpage_size=
);
>> +
>> +	return split_huge_page_to_list_to_order(page, NULL,
>> +				ilog2(min_subpage_size/PAGE_SIZE)) =3D=3D 0;
>>   }
>
> What if "min_subpage_size" is 1/2 the THP but offset isn't aligned to 1=
/2?
> Splitting the page in half wouldn't result in a page that could be free=
d
> but maybe splitting to 1/4 would (assuming the THP is at least 8x PAGE_=
SIZE).

Is it possible? The whole THP is divided into three parts, offset, length=
, and
remaining (renamed from left). If offset is not aligned to 1/2, it is eit=
her
greater than 1/2 or smaller than 1/2. If it is the former, length and rem=
aining
will be smaller than 1/2, so min_subpage_size cannot be 1/2. If it is the=
 latter,
min_subpage_size cannot be 1/2 either. Because min_subpage_size is the sm=
allest
non-zero value of offset, length, and remaining. Let me know if I miss an=
ything.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_DC93BADE-3D24-418E-81A1-0357978B8C2A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+tuS4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKZGkQAItilLhKZUMQgdYdP37xs6xcZRSu5D2EWyjZ
ch7hzuC1+/DURRzdByYSJMuf3DQ8a6bzuTRIF17YSrKEo96Yrwo+hBY/pjfROlnZ
mtmz5Nyf59ptRkTlu1ttPSCCe+fUWUQCS8dJM3mGcVnSybx0JCT6uKMc1sD3KHCP
dEfCluUIuFH1hzm70AljH4oD5Pjx+R7XjUgbxr3W7cmXaZzyl1p2JxbcyDs/VvzQ
OII3FzsZSHnr7M9bYe+VQbrF4yiHMkpe+Yk2vfpm2Bof8Xx+giIuqT95p6Ppjf+S
E85X4bWXdVkjEM8S6ZQhaR9MMlD8DMuNB8CUfvB+bcft1oHGPrVtKsNG2c8e8fio
N4NylDEu0f8/5kZJz8wPJy6kmnIfTNTCqeN/ztL6dae8hIHiOrU+lBk+Nu/TyD3L
eeLLAOcOC9OlaSFePGH57Yi90o+zjOdX5nH+mLNJKCo6EuR7zPIvPqplF5Xoi/9f
8DyTRxTGzyTGaHrkoCIOEnxcazL5zYRE/fBkQoU4AeZtjI6TdyAwnD8GOW5UOe5H
dnNj18EqY3mZK4JTEqTjEDivxQaWxeycdWE4SzT51Zuo15i9zON28hHJHktkvlR2
GFLm/XqED9+GPZJn0ziOm0GwDriwwFQUWoL017zdnLFUW/8RNC9gclgw3aXzDVHK
PrD2fI46
=SRw1
-----END PGP SIGNATURE-----

--=_MailMate_DC93BADE-3D24-418E-81A1-0357978B8C2A_=--
