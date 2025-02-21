Return-Path: <linux-kselftest+bounces-27201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3BA3FD31
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC317B640
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8924CEEE;
	Fri, 21 Feb 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyQLCDoF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2F24CEE2
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158072; cv=none; b=bDSA2vkdrgdEw+Io5D854ze0ta9Huv6gBDIY/1k0yg3ucfYr5XafgADTLtPnEW9K6CCoBtRI7b5Nu1zXiDS3822dMfckC6AaLCDFPyFUccHUgYx9MOCviJE0/la1kokdVE+VrvkZIjr1q8UdrM5SMwxrF3Ab9XIJy/Zf+Ftd3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158072; c=relaxed/simple;
	bh=SQM2Zd24+tc9RM6wK1jpTq8xKmBYq+FC7GVRlyvHJjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUKInrzAimF/Zt7DdbKAGSTdIXDTjCXa2ud7AP0jOpbTG5og1gFzdKDzrofloERN00MrXXiKqGglZ/ATnZsewRZeRynNoWQGXYFXXCvhDYiFLegq/g/SVD/LFffk3lMQ2DYxixd94YUEDukEaR6ik7SUZhqBmAoXLtN2QaUTjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyQLCDoF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e0575f5bso193555ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740158070; x=1740762870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0gSK2FCxaWmxefntBhNlF54L7D98cEEXS9T8Pg40TY=;
        b=CyQLCDoFa/zE6++mlqw9/KsI+uUGEGGE1NRLnxsbsEGAZC6RhYFjZXA3qJJcSpLmU7
         JghpZK4heJD18Z+PAHMtfB0E1Hri1POFz1uD05r2Gt3ounIcJ4zKvR7FLYrwONOXpWPY
         e2/h6bq6r8nOU9f0I7cjMlQnhUs8Y1X3RLPt2tV4Vaz58P3SaDfty1pa0mo47BoENgtE
         X1ynuZpOypslOQmy4zCIQghlOy2dEpKDWr8mEr1M2k4vPtbVw0IWbeIdtck2opYFcEc1
         ushJd9BtfkYwi8h+C+4PVsw/Lv5XumyEZoGilEY0LM8BazUAzT4+z7PHUbpexjUn/Ccm
         ge+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158070; x=1740762870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0gSK2FCxaWmxefntBhNlF54L7D98cEEXS9T8Pg40TY=;
        b=uT4ST9LcLItuEoUB/D6exA49l5ousfV0DDVQ3w5NUYU/xFqWepyhhDxqHkYOL52EmR
         IU+c1YmojgjEUbdsLexact8cQd8g7TEVIJ24DHIaK/4HPoJ31OiWAWUS1kJv/pz64i+v
         fHZjFuPbQWcDsNDvzVuWlupNBSoZiRLAMnJC9RAi0kNmWiR/V7XD9w891zMXeGBA7RNE
         08sRQE/vh2mqR3GL27lYPi5jOIOweH/tO7inXX3fgqdOPfznAb1Kn1/rJBGTpp5r81dd
         XLe34mp5mp7G1GwN+HL850vj3Qu/g/213lNcRijSt9EvYFyHA2cwna9ikzX4sJjvY4e4
         Gduw==
X-Forwarded-Encrypted: i=1; AJvYcCWcjBFPiwOH1VCfqjGiwMmckp3kH3sAiX9MVz1R+ifG7Ufvf9zmngvtQeGCtKtLqtnkqJY0kMkt0sr4LR+7Svo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2xkgGIPlB4Kax1UTjrKo8ecFWkG9eZu9TOidaGCpexDXVHkS
	86HuBX0YuxnqnY5XwadjWnCed5onHGegwnjpD2dd4mGA2fFL2uO0rp3tCqwb7DsNKvR0yn431nf
	n08b4Lh0JU3hNWW8I9aFruucfPllrOJt5FOgD
X-Gm-Gg: ASbGnct8ZU7pJikmjywSRQxpDSPH2xLgUCXJ28DRG2dwn7UekLthzk4/ROWXWF0e3dr
	Yxni54ZrzXqeaqFoFcbwDVmR3JbmxDw9ZHyI2UdnpOTPl0SFYWlHXHx6TtuGilH3o6v2yxnWQTY
	5vyrzn0m7M0FjrfPt8a6YahOulgX+eKY/QqobndFFv
X-Google-Smtp-Source: AGHT+IFNyUGqlslXX37x4LbVQZRrq75tIiNhK2lhe/pPGYWt/2yXJVlCueghSa7c76ItC22g78yrCg/UqJB9sy8R4qo=
X-Received: by 2002:a17:903:2bcb:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-221a045943dmr2994765ad.4.1740158070005; Fri, 21 Feb 2025
 09:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <164feb0a43ae72650e6b20c3910213f469566311.1740139449.git.lorenzo.stoakes@oracle.com>
 <32e83941-e6f5-42ee-9292-a44c16463cf1@lucifer.local>
In-Reply-To: <32e83941-e6f5-42ee-9292-a44c16463cf1@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 21 Feb 2025 09:14:18 -0800
X-Gm-Features: AWEUYZk3mhTNh_WBC5ffotM6wthK5i4atwZUkga3FHvQ0eq4dodOkvuYfjsE_F0
Message-ID: <CAC_TJvf8kqnAKAfHyTAz_c4-cGrjNYyLBUTWzYrJZGmanOvRGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/selftests: add guard region test for /proc/$pid/pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, Juan Yescas <jyescas@google.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Feb 21, 2025 at 12:05:23PM +0000, Lorenzo Stoakes wrote:
> > Add a test to the guard region self tests to assert that the
> > /proc/$pid/pagemap information now made availabile to the user correctl=
y
> > identifies and reports guard regions.
> >
> > As a part of this change, update vm_util.h to add the new bit (note the=
re
> > is no header file in the kernel where this is exposed, the user is expe=
cted
> > to provide their own mask) and utilise the helper functions there for
> > pagemap functionality.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

>
> Andrew - Apologies,
>
> I managed to not commit a change I quickly made before sending this out
> (I'm ill, seems it is having an impact...)
>
> If the series is ok would you mind tacking on this fix-patch? It's simply
> to rename a clumsily named define here.
>
> No functional changes...
>
> Thanks!
>
> ----8<----
> From 60be19e88b3bfe9a6ec459115f0027721c494b30 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 21 Feb 2025 13:45:48 +0000
> Subject: [PATCH] fixup define name
>
> Fix badly named define so it's consistent with the others.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/guard-regions.c | 6 +++---
>  tools/testing/selftests/mm/vm_util.h       | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/s=
elftests/mm/guard-regions.c
> index 0c7183e8b661..280d1831bf73 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -2054,7 +2054,7 @@ TEST_F(guard_regions, pagemap)
>         for (i =3D 0; i < 10; i++) {
>                 char *ptr_p =3D &ptr[i * page_size];
>                 unsigned long entry =3D pagemap_get_entry(proc_fd, ptr_p)=
;
> -               unsigned long masked =3D entry & PM_GUARD_REGION_MASK;
> +               unsigned long masked =3D entry & PM_GUARD_REGION;
>
>                 ASSERT_EQ(masked, 0);
>         }
> @@ -2070,9 +2070,9 @@ TEST_F(guard_regions, pagemap)
>         for (i =3D 0; i < 10; i++) {
>                 char *ptr_p =3D &ptr[i * page_size];
>                 unsigned long entry =3D pagemap_get_entry(proc_fd, ptr_p)=
;
> -               unsigned long masked =3D entry & PM_GUARD_REGION_MASK;
> +               unsigned long masked =3D entry & PM_GUARD_REGION;
>
> -               ASSERT_EQ(masked, i % 2 =3D=3D 0 ? PM_GUARD_REGION_MASK :=
 0);
> +               ASSERT_EQ(masked, i % 2 =3D=3D 0 ? PM_GUARD_REGION : 0);
>         }
>
>         ASSERT_EQ(close(proc_fd), 0);
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 73a11443b7f6..0e629586556b 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -10,7 +10,7 @@
>  #define PM_SOFT_DIRTY                 BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
>  #define PM_UFFD_WP                    BIT_ULL(57)
> -#define PM_GUARD_REGION_MASK          BIT_ULL(58)
> +#define PM_GUARD_REGION               BIT_ULL(58)
>  #define PM_FILE                       BIT_ULL(61)
>  #define PM_SWAP                       BIT_ULL(62)
>  #define PM_PRESENT                    BIT_ULL(63)
> --
> 2.48.1

