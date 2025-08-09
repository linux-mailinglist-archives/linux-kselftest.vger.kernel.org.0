Return-Path: <linux-kselftest+bounces-38629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7AB1F5CF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDFE189E5FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62DE2727ED;
	Sat,  9 Aug 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp/5FTlb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927A2E36F1
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754764520; cv=none; b=YCcU2nnHEDm0HnA1XFeaadKGDm6YJIUdUPpAJOr0gI9xU60GVOWhKWNT0Jv3+XilDBcOPPSaCo+tBpGYFY5lnq7efPG5DfET/5fKRN5gCn3FbNh+gxaDuZX8eSX4IbHewkA2vyh1EgF4bgF6vcpjS2bM475qXJlC2UQn7HH/LH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754764520; c=relaxed/simple;
	bh=nS+QbrEpjfCmNmz4JNUDuHPEC8+I9U/zao2sTSvZAMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImR8fgDZT7HQCgTjyojbvcPl9UR1zR4fVsVuNHKQEeTbktC7pCtH38J9RUmPyMZN6Rig8hTMs4CyXVWx57MeelHryRuWc1ZTRy8F3h7Rcnl6IasiJlulDIk4tDuGd6c5j+SeFPmCIPoThzyW2fmOH6kgjycdJXL/W5ASc5jw/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp/5FTlb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso4665783a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754764517; x=1755369317; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjckj0A0NDqV5W5kz0Zu42Up3b9/6XLIFESqh0fq8UM=;
        b=Sp/5FTlbv6cddJ53G7tf+IRGea5nAqlyJjRcwDwwtr99bMQ6UnQliIH+O5Y30vjQzy
         6sXEgntLvVhMtOfi8hFK1MX4bG9BH0rDXgJc8e8IhOjKY0XHXVOgdHoBggsq8Rkf8crp
         9G3kn9zLQLRree8kjk1l+4Qr5i1woSujoB62b9vy2Z97hFuZ/N6XIK6nuQvTKgcXAuX0
         cRhiD3t8ZIJauEJIwnfPSVUZkJc/uL4S3veGTO70MuHDLKCkMn9tR1u5v29uRzBAEFv1
         Inq7Jbkh7JYp/mR1b9zz1xFI0OW6gVWQXPvTOGNKs9Pl2zUCYVYByYEcOl+vmKrxZ3tF
         2weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754764517; x=1755369317;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjckj0A0NDqV5W5kz0Zu42Up3b9/6XLIFESqh0fq8UM=;
        b=ENUWc992DYgLNtK9WFL4vz4JOfRML/gpj+UEkcm2SbH5PrCRscm35vjZZkIQWf7BVQ
         do2OECQ5PmqQnnveDPDO3H8Qx8bEMICaKqWgpoFoxwzzKeEN12GHpXJoy0juNStb2sV5
         0J6tLKpOP7Yz6lcNTULt1oVkhHAUdTlsInNQ/Bv9Vtq1SxU1afCdjKn8RKAqHtKR12eP
         ecspojEs+ThGpQrCOc87vNRYD8b3rzLOvR8fEf7IW2XtF0dw0azXtBeab7lHPlsMUwPJ
         /QO81tovGGy6zJjzAtUPijzNbTz7SRzDVnWGKHJk/GD6wm6ZBuOa9i9GHwNlfk68CkmH
         RPyg==
X-Forwarded-Encrypted: i=1; AJvYcCXey92/f6PXsc+pZQakfoGju/4h988kOxzdsG0cD5jvCb5zec26q2Frei/wOVMOCZcV9UZry7CKAS3rZFSjzew=@vger.kernel.org
X-Gm-Message-State: AOJu0YywA4b97EcJxhfWC4lN1RxDg1UrGqPq12ubnFw9WvswII+B5ihf
	Dx0mFIXuhlTBkOM7WADnlN2vLv0CpFDz4Botcu2XP+Q9FF+ew6Pad8qg
X-Gm-Gg: ASbGncuWT2aDbaE5vFDLU8gWZj7Yw+peU6KiMCO7lg3fS07ucCbJw0IXgu9wdjnaWnO
	WWcVskw4oGXWakbXFVpUDcjGXf0L826FsHIxeKWly0hTqW7bUsXJyzaQy8m49qCI7bn3ByfC/WX
	7b6rVU2UOxOOSv91EnTmscN3I5gbB3s+01NbAJuevNb3it8DbnQRGvlMQAq1C5htuC/ME8K4yrm
	7zR0UgfihfmHnfZ1TNess6Y6YDY/TOeainJzpaeFR3umgcM4bJq01pGMpwIWJCMsaGWd+lKbPD/
	sVBRcomp0ytvMCzO/C1KKqFikLcA/OG8bOnyVi9OFjuRDbvwIMEaof7tC1zahNUEZd01E/P8Tpt
	D/Q/3CNA2rCjFYxXCrU9RUg==
X-Google-Smtp-Source: AGHT+IEIPUcEAow/xxCt+orakeVHzU1xZq+nPhg9Oh0ec1/DwLk6ymkRwZ+iewK92+YrZwI+8hxUyg==
X-Received: by 2002:a05:6402:1ed0:b0:617:f723:cb34 with SMTP id 4fb4d7f45d1cf-617f723d517mr3625012a12.21.1754764517111;
        Sat, 09 Aug 2025 11:35:17 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f16062sm15339707a12.18.2025.08.09.11.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Aug 2025 11:35:16 -0700 (PDT)
Date: Sat, 9 Aug 2025 18:35:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, dev.jain@arm.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
Message-ID: <20250809183516.w5fbt2mrt7dqotcg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
 <0467FDBA-A2CF-4CF0-ACCD-760ECD30BA8A@nvidia.com>
 <207BD61A-5561-4E8C-B867-D1CFCAD37509@nvidia.com>
 <13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 08, 2025 at 12:01:47PM -0400, Zi Yan wrote:
>On 8 Aug 2025, at 11:59, Zi Yan wrote:
>
>> On 8 Aug 2025, at 11:56, Zi Yan wrote:
>>
>>> On 7 Aug 2025, at 4:27, Wei Yang wrote:
>>>
>>>> Currently it hard coded the number of hugepage to check for
>>>> check_huge_anon(), but we already have the number passed in.
>>>>
>>>> Do the check based on the number of hugepage passed in is more
>>>> reasonable.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> ---
>>>>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> index 44a3f8a58806..bf40e6b121ab 100644
>>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> @@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
>>>>  	unsigned long rss_anon_before, rss_anon_after;
>>>>  	size_t i;
>>>>
>>>> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>>>> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>>>>  		ksft_exit_fail_msg("No THP is allocated\n");
>>>>
>>>>  	rss_anon_before = rss_anon();
>>>
>>> Which commit is this patch based on?
>>>
>>> In mm-new[1], verify_rss_anon_split_huge_page_all_zeroes() accepts
>>> char *one_page and size_t len but no nr_hpages. This breaks
>>> split_huge_page_test.c compilation.
>>>
>>> Are you forgetting some cleanup patches before this one?
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/tools/testing/selftests/mm/split_huge_page_test.c?h=mm-new#n110
>>>
>>>
>>> Hi Andrew,
>>>
>>> Can you drop this one for now? Thanks.
>>
>> Wait. It seems that mm-new is different from Linus' tree[1]. I wonder
>> what is going on.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/mm/split_huge_page_test.c?h=v6.16#n109
>
>Wei, it seems that you lost the race to Muhammad Usama Anjum's cleanup patch[1].
>You might need to add nr_hpages back.
>
>[1] https://lore.kernel.org/all/20250731160132.1795351-6-usama.anjum@collabora.com/T/#u
>

Thanks.

My patch is based on mm-unstable. So currently we base commit on mm-new?

>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

