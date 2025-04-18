Return-Path: <linux-kselftest+bounces-31114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DDCA92F03
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 03:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E78D3A1ECC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FFDA921;
	Fri, 18 Apr 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/e8Zv8g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9F8C0E;
	Fri, 18 Apr 2025 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938165; cv=none; b=Bzc2xFbTx7UBzyFAQHSjTx4WBoNrmQyHQIyjUMN1R6wuy2OOShdjoiXqU0H0FvZxVsDNcYaBNdhGBLNmxUTy4em69MUjttBgJOXSd6YFfhjqhqLCHb+vamWRFrJe7UNHK/KBaRqY0ldiZ4eZXs6TNRrcE5/EoYf5hgnVDB3CJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938165; c=relaxed/simple;
	bh=l4e/uYzgG6Tdwe8y7t0wmGDfbKXLpFehIIub+FZvEv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVOAKC/bZpV2+S1v33lgpLvvg4oUHoqB7FRpcreMZkcDzti+Rk0Tg9cSFJqJUKj4c2SvP3Gwu/Nuozo2wNObcfJHFdjSDt8RifiZQtlhvDMFj+k0DNJEx2CTquNws+QHhCeeNAsOkHc5sSpDil8zkeBJNrRYQ/tdR/RZ0SKCZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/e8Zv8g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33e5013aso18077795ad.0;
        Thu, 17 Apr 2025 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744938163; x=1745542963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NXDfDK3aSml2E+saDauRdMH/9W2bC9OP7905GHXeqg=;
        b=e/e8Zv8gBxIWR9YdN7uvZ1wbzUSG3gVGPlJCUoKUF4hQSxSCqPQictjhecmL2LpUiX
         EIHvtwppU2Xq+s8JTHl5NhQ3myFwRsAzElxLx8PIDpTlaGDTOifF3dJW4LRpbQbWRD0r
         EMW0UZ5ckTnvgG1Ds/vYSvSOX7O8EFl9rpfQD+aodyfBomnRZemULO9cN16RyYF3/nj8
         3UAcFH/GlnmdFumtKqer8hasnNu+VZVs4ywDu+tK47zKovsTebDRD4ukYxuJGwqsspqL
         dJ8i0OrFwZjNy4j8z3Cs0kW2YGbib9EnNa+cP5Z1tP6IsG2ZZKk4wTTOjolfrmfQuyzB
         hSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744938163; x=1745542963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NXDfDK3aSml2E+saDauRdMH/9W2bC9OP7905GHXeqg=;
        b=IemXEEu5COhV5tAv9qZcIgqdxp0alD6YxVlxtL3Q2T4SKNIbnYiiL2r7gGkWwNy4uC
         PeYTmAtu6PncfMn58KQbvQGlftzbs40rb2hAnA00x+3EMaJgEIBYNZRI/3SvePZQVgOX
         JMyyIOced5wAbQCXX3I0y+lvaEWjG5YhR+RHz02VKS0s7IINOBrfdjAFaQOoLaaJ47GR
         IFOOW5LNgA1ZwtdZa0uC6xDnGmUtEfeDyAI8mdsNrV5Xf7vrto9NQzFyqmPX9SQO8jJQ
         ZSmYo/7yutRB48ZPHe3p2HfhbnV/BFFs1MVCAVCyHdtsQFxvgwJfILsk35bNjoG95w0t
         OPtg==
X-Forwarded-Encrypted: i=1; AJvYcCU1FF4DOLns1y2XhApOyv4Nic35R3BeZGjfgHnjpS7I6h/fss9o45hjyw3qcBWri23LZLhpfNLYDM8=@vger.kernel.org, AJvYcCUjD7MNuzUJEgw+B8o4UQfUp74QZ+7yumWe5BCiPEXu1UoYIxxjn0LbB2WLkGsHS5sa3vCDhex8ZvX6HqCm@vger.kernel.org, AJvYcCV1aPz0htTK3LNKxONKG7mArFskDCT7MbMfuvTYje+2AIydo96pS4lE819npgp7akZf9H8Qw6eOPK08qSp+3eMF@vger.kernel.org
X-Gm-Message-State: AOJu0YwblCWRBy5ot4ClcPPBeuEeO3nJrGIX179vT1+FWEZuyZ7P2vpr
	78ptE0C22rd/K0S2WMhQKvW+DG/kpdQyKRbw1GQ2qjgezWUPvO8I
X-Gm-Gg: ASbGncttxtPusCoTOjn77B/hki7uSFt5v4+G0FQwphJTl7rMNO+YadQnsqI7IxJq48G
	/MthP6peri3KzeUk2ps4lH+mx/16ZW/QlzBNV8Qe6kFu7MKqUpHk1/COdYQbNrhYnguN6WD19wr
	mEooUlmPockWHqmW4Pf75OURjqZQn0/tyFvZ6l9LnzKzR/EtrDqj6+4AClbo38O2ObY81lDQCxm
	qoFth+8Z9Ia/8VdsexduK6LwkT+QBcqt5Fbhtt61YmECU9h6JtWiASo0aSjoZ2slaJK5vnEda1G
	z0kQTqQq+iHDcYq3gxrcv5xQj1miYRj3ld6VAeb/
X-Google-Smtp-Source: AGHT+IHDm2/uiDHbeptzLGovtbbE44rhzmmK5eRP8BwU9MWedsOqamPglnynKile7HYwKCMMQ1kxTA==
X-Received: by 2002:a17:902:d589:b0:224:1157:6d26 with SMTP id d9443c01a7336-22c53573b4amr15702485ad.4.1744938163034;
        Thu, 17 Apr 2025 18:02:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4912sm550714b3a.60.2025.04.17.18.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:02:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3238A4209E46; Fri, 18 Apr 2025 08:02:39 +0700 (WIB)
Date: Fri, 18 Apr 2025 08:02:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	david@redhat.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com, willy@infradead.org, peterx@redhat.com,
	shuah@kernel.org, ziy@nvidia.com, wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com, sunnanyong@huawei.com,
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v4 2/4] mm: document (m)THP defer usage
Message-ID: <aAGkrw5O5OcVFDFQ@archie.me>
References: <20250417001846.81480-1-npache@redhat.com>
 <20250417001846.81480-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KNDrqzrcH5sLMMxx"
Content-Disposition: inline
In-Reply-To: <20250417001846.81480-3-npache@redhat.com>


--KNDrqzrcH5sLMMxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 06:18:44PM -0600, Nico Pache wrote:
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 06814e05e1d5..38e1778d9eaa 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wide=
, application
>  may end up allocating more memory resources. An application may mmap a
>  large region but only touch 1 byte of it, in that case a 2M page might
>  be allocated instead of a 4k page for no good. This is why it's
> -possible to disable hugepages system-wide and to only have them inside
> -MADV_HUGEPAGE madvise regions.
> +possible to disable hugepages system-wide, only have them inside
> +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> +handler to khugepaged.
> =20
>  Embedded systems should enable hugepages only inside madvise regions
>  to eliminate any risk of wasting any precious byte of memory and to
> @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepage=
s and that don't
>  risk to lose memory by using hugepages, should use
>  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
> =20
> +Applications that would like to benefit from THPs but would still like a
> +more memory conservative approach can choose 'defer'. This avoids
> +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
> +Khugepaged will then scan the mappings for potential collapses into (m)T=
HP
> +pages. Admins using this the 'defer' setting should consider
> +tweaking khugepaged/max_ptes_none. The current default of 511 may
> +aggressively collapse your PTEs into PMDs. Lower this value to conserve
> +more memory (i.e., max_ptes_none=3D64).
> +
>  .. _thp_sysfs:
> =20
>  sysfs
> @@ -109,11 +119,14 @@ Global THP controls
> =20
>  Transparent Hugepage Support for anonymous memory can be entirely disabl=
ed
>  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> -regions (to avoid the risk of consuming more memory resources) or enabled
> -system wide. This can be achieved per-supported-THP-size with one of::
> +regions (to avoid the risk of consuming more memory resources), deferred=
 to
> +khugepaged, or enabled system wide.
> +
> +This can be achieved per-supported-THP-size with one of::
> =20
>  	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/ena=
bled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/en=
abled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enab=
led
>  	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enab=
led
> =20
>  where <size> is the hugepage size being addressed, the available sizes
> @@ -136,6 +149,7 @@ The top-level setting (for use with "inherit") can be=
 set by issuing
>  one of the following commands::
> =20
>  	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/enabled
> =20
> @@ -282,7 +296,8 @@ of small pages into one large page::
>  A higher value leads to use additional memory for programs.
>  A lower value leads to gain less thp performance. Value of
>  max_ptes_none can waste cpu time very little, you can
> -ignore it.
> +ignore it. Consider lowering this value when using
> +``transparent_hugepage=3Ddefer``
> =20
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -307,14 +322,14 @@ Boot parameters
> =20
>  You can change the sysfs boot time default for the top-level "enabled"
>  control by passing the parameter ``transparent_hugepage=3Dalways`` or
> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever`` t=
o the
> -kernel command line.
> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Ddefer`` or
> +``transparent_hugepage=3Dnever`` to the kernel command line.
> =20
>  Alternatively, each supported anonymous THP size can be controlled by
>  passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[=
KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvis=
e``,
> -``never`` or ``inherit``.
> +``defer``, ``never`` or ``inherit``.
> =20
>  For example, the following will set 16K, 32K, 64K THP to ``always``,
>  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--KNDrqzrcH5sLMMxx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaAGkqwAKCRD2uYlJVVFO
o76GAP4gVe3Gv1BdLnJiW4rDIJQ6VD6/W+Sr//civHKYU9VsUQEAuc1azxqwsSEj
K00HI9k41AAjpL6TTipYDczBL0F01w4=
=KYIn
-----END PGP SIGNATURE-----

--KNDrqzrcH5sLMMxx--

