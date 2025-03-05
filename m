Return-Path: <linux-kselftest+bounces-28348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573DA50EAB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0003ACFCC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B920201266;
	Wed,  5 Mar 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZLCSiax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333E1FECCC
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214300; cv=none; b=JmaOQKduuXhZm4KA2XYK5VkewXGL6q3ney9ZLJv922qj4OqnBpWw7LxeqwLr2l5xRt4ZZ/YAJJyhOPt2HvWrKwGN4QZHRjJUntYceB4sPOyaU4uLm//K+eMFIv4bs1pA+W/gQH35XGsJ8hMeJqXbgbMuqHlQwc4KjI0orn1uuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214300; c=relaxed/simple;
	bh=Xi/hSMI0QlULt9i08ZHRCTXE1xApf25x+b0AZdKIryA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YDM7Zudd6XLF7oX1hE6hezd43mHBMHnbXEK6EkHAyd1F4Fs39A5VyKOtf5eVeOn/pmkVY/XteVH23001G+uswLhKBEvfqG7a+TRg0CVzh5aZrrjoI8Zq+WTk2OdurInlsa6Dy0elJlxOzZ9UKqU4o8wbSH209H2DoZHFcCQHZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZLCSiax; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fe86c16f5dso14261eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741214298; x=1741819098; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjOvi6sl2VIvgnDBWTKhh6QRUEoSop9v3GepSmadXxw=;
        b=IZLCSiaxEAo9mn5L3qKMO22EpA+YU5e11IiSbKKTth/gYs3IG/INbjyykI3gEF2mXv
         9jGe4dPLWZyAh9zYXu6iHHVag3/XJi+vZHZ/Z1wqvGjJNqtYUcTXXE6B5XeE4BAH8+E4
         2ZbnYqeLM93rxOtkzOeTAjOg3EQiMLcfr0uYUTrs0851i8KRYA9bl6wjaibwwHGrblsJ
         Z/plc/7esnAPtQIdt5tlPH6W83tBwowqerDL9JGTTa76Zpplwpzul4mrVuJo30troHKa
         fLOY+Vjy27UorDnQJDJvP0Zmv5Vsw9KnEihyl3yBJdsXq8I9V7idfk8J0LDbFOuXEKeq
         MPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741214298; x=1741819098;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjOvi6sl2VIvgnDBWTKhh6QRUEoSop9v3GepSmadXxw=;
        b=C4sKZ23b80bKvmxCesjkJpxaF9PuAuJcKIVWvddJvdSerP5p+AxWrjdbvJ9I8OwrSG
         zam2hv2EvWVS7d5XIYjC542fkthyWIPuSEvG//c2R4nFbUmW5AyNTxvZ1NwRsAPWZhW9
         OdYJJnno9dO6s4368ILhHfgLiWyy54NA18SLe2b9jnDnA1kL+P8JsrImzk/2bVy7nBdz
         f6jCe+as6vgvWirw38O+jwgfiweoIbQSb0iikWTlzxZmbFz45Z64TcUeiSytdIzQjOQS
         m6qqkZq4Yg5VKGvTghCwbb19whXfZTxIm/qVuY88Aa6338CxIckFC3V5TiOCUq1SycRB
         uQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeDFcrsEJT+ydnkoyEXqTvIFAGelEUw8E0UhXMxnXrmAf/XJj4fnoXQdHF6vcby8Qt0Qe5oe7xtAVy4dvdT5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERx/u0wtXfAkQ1Cx4mocGCui2Grzcm0d218AqTHlZ4Ve7KmEL
	Bodt/Ybtkte1FHFePFlRx6JKLsO1NYS+0iznlGRwJxPibpti0WyC4mwTvAh+Hw==
X-Gm-Gg: ASbGncu5WbiRsrDSS0Q0WbWqEcTmg2BWKFFMFfbRoa1lMw1Qmf0ZTyOou4newmzPgS8
	E8Fk/HRKIA4UqTB2eUIuBy05GIQxF1Ark4N9MREsDaDbMsFyn4HAJovDH47E4tBPBZgS6WgCIwJ
	JAOD3h8/IXkz0r6c6ywo6EAZzhKp19q/CXlrdQZkkOwUgIkk5AxObQbXfd4nRSGF5ZiV7d1muV6
	cBhqE/Fa2lMnd/5U3paJtycfDOh6m/qPRpAcdLNC+ai3OFa9Hj+c9ckeZv9hqSZmCZyYY6Lexoo
	ReWAD62JibG9yJuPLHoHXTNX3YOi0ZXaE1wbt1Eb25YKqvJIkwl1VgLirN3CugnOwDoJBF0PshS
	UEwPWS+/CeVcy+QsHRsrYiEuOjKC6
X-Google-Smtp-Source: AGHT+IENCRda4YblETp7vN9oJvjvecYwsrpti/odR7sPkl62SCbV9fZvgs2gw1PyJJPEAr1GtS158Q==
X-Received: by 2002:a05:6820:a01:b0:5fa:6805:645b with SMTP id 006d021491bc7-600336499dbmr2496467eaf.6.1741214298269;
        Wed, 05 Mar 2025 14:38:18 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-600410a0db9sm3504eaf.26.2025.03.05.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:38:15 -0800 (PST)
Date: Wed, 5 Mar 2025 14:38:12 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    linux-mm@kvack.org, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
Message-ID: <176731de-6a3b-270b-6b5d-dfce124c8789@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com> <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com> <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com> <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
 <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-323578906-1741214295=:4219"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-323578906-1741214295=:4219
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Mar 2025, Zi Yan wrote:
> On 5 Mar 2025, at 16:03, Hugh Dickins wrote:
> >
> > Beyond checking that, I didn't have time yesterday to investigate
> > further, but I'll try again today (still using last weekend's mm.git).
>=20
> I am trying to replicate your runs locally. Can you clarify your steps
> of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D? D=
o you impose
> a memory limit so that anonymous memory is swapped to SSD or make tmpfs
> swap to SSD?

Yeah, my heart sank a bit when I saw Andrew (with good intention) asking
you to repeat my testing.

We could spend weeks going back and forth on that, and neither of us has
weeks to spare.

"To fulfil contractual obligations" I'll mail you the tarfile I send
out each time I'm asked for this; but I haven't updated that tarfile
in four years, whereas I'm frequently tweaking things to match what's
needed (most recently and relevantly, I guess enabling 64kB hugepages
for anon and shmem in addition to the PMD-sized).

Please don't waste much of your time over trying to replicate what
I'm doing: just give the scripts a glance, as a source for "oh,
I could exercise something like that in my testing too" ideas.

Yes, I limit physical memory by booting with mem=3D1G, and also apply
lower memcg v1 limits.

I made a point of saying "SSD" there because I'm not testing zram or
zswap at all, whereas many others are testing those rather than disk.

swapoff, and ext4 on loop0 on tmpfs, feature in what I exercise, but are
NOT relevant to the corruption I'm seeing here - that can occur before
any swapoff, and it's always on the kernel build in tmpfs: the parallel
build in ext4 on loop0 on tmpfs completes successfully.

Hugh
---1463770367-323578906-1741214295=:4219--

