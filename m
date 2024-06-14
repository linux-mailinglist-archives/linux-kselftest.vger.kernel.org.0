Return-Path: <linux-kselftest+bounces-11967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B690905F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC33B2813ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F01AC234;
	Fri, 14 Jun 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n60hXclS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3818F2D0
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382674; cv=none; b=NR/SDFcYL1KdTC7HJohpU8JAelGvay6Z6JDZ5Pe83aqAzCBoR3A6bGFFrqt/2GrKI7s1E/Hmzztthf4wgMYwcIyYQtbQzFWcr/BXiGsqF78c03/owiF51TLidTZhAbExYLE43995eKH1KbES+nKTwsbO8rHmfbvZvRJSQ1h80PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382674; c=relaxed/simple;
	bh=6MgyH+UaOm9jsT4OyGJoYlo6VcCBqjDFJmB4oSQr0fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKO28mUhbPfwZoZ9YiJo6DSrV5QZHbSZUiwvsZwhjGcHgx5KMF8wTdzz2Vg8luEdxfxwmRFIL5Wd1gm8aJmkApN64b5Ntbjmi/cH+FHL7s7Sj/d9oycXf5f5K0jAKV5loqz3zh513KA+nQqZUtw4uVKhgF7EeBd/XyI6Qgh7r+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n60hXclS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so21712275e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718382671; x=1718987471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHabd/J4Wd8iFYsfwq/Rjz2F7MrwAzZMKt21CUFAuTc=;
        b=n60hXclSrMY80Ie+Rjj328MKs1GnNNUIDumVasdCm0em9p9XrXqJBnEekf41i9hbXM
         NILiHNd9rquKrYQSJ/EVlvaPpZjisJShyG1MKz2cpdjwEzweGkkK65QE3ABkjX1sBmQo
         kfkoG4rd5DlVnPqJjn7AlvSy/MSS2Po3zVLjvJh2aiNZJZtBcouMcoYME62tI099oBXh
         VO6WccWN+9Jx+nVyXkPNQFM5kiD1rrYQED9sF42vwCXQhWMy5JRR6CPXL3Sq0Se5ajFQ
         XPn4YWveWsM9I2o247YjDkOcbKS4CPKZXf7j2kVbjua/LZyPRiVXnlGSOMZ7FBfRliqC
         8KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382671; x=1718987471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHabd/J4Wd8iFYsfwq/Rjz2F7MrwAzZMKt21CUFAuTc=;
        b=qF9gOtL+Qnl6hWaQfHZX7J+slFGOiMhHvJE0B4n1OG7I66EgfuHQbt20EAr4UMOdvO
         Dpk9x9BLD/BZmSSVlq94oBsRVu52uLi+EiEwMrDVbSxrse5sgvUb4zfOSaIG/z4f8Hlm
         p6nbPApw6WM6mLZL8NerhUl063203TI4ODhorzBGf4k6eHLExEOlyZPi1FQQQVndNT8n
         3yC2lqyaqizU82yAV4+zi0CwcNyCtsTWHjMO1SfWCmaZOnKMuOK5QQZxLBm5Xzc9FuBw
         atdQZun4kf5xhA+FmZyB0fUbbYOAN61yxT3ngELsSoozVF+4f61oySKx6XQXrCYfweFl
         BvWw==
X-Forwarded-Encrypted: i=1; AJvYcCXkLXOxunL0t1VVt8Gp8OypXjb8+R78s51ztYjZOjhf8/ddy0Aw+P3LCQnW7sfS/7Cibf7pB8SrXBFpLtDNoONeJ8xh5zKo3KBpCyA+n+8P
X-Gm-Message-State: AOJu0YzStM/KRepvmT0+2/98UGIhDjYc+qOKNnjVVoDTmDEY7WY0EEQz
	wDk0sjXpHOcSoQ0P97HOzPny0VxSa6p83mMGVlaDiSAVYVgSgHEKRo/xnkn0x6V/eUE00Fq3r8v
	eBQClHjAWK7rZQYOvIyUK497IR/fHK6ZLihM0
X-Google-Smtp-Source: AGHT+IF3RYTewQNUO29sU0IeAlB8PahfU9UKR06ru7WydepJid0XkPOG7hgoTXXCXiU6Yf2kaohISDR04mVUUsDJxfU=
X-Received: by 2002:a05:600c:b42:b0:421:7109:c7b3 with SMTP id
 5b1f17b1804b1-42304827d80mr26851395e9.14.1718382671175; Fri, 14 Jun 2024
 09:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-2-jiaqiyan@google.com>
 <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
In-Reply-To: <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 14 Jun 2024 09:30:59 -0700
Message-ID: <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Lance Yang <ioworker0@gmail.com>, linmiaohe@huawei.com
Cc: nao.horiguchi@gmail.com, jane.chu@oracle.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 1:35=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Hi Jiaqi,
>
> On Wed, Jun 12, 2024 at 5:56=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> w=
rote:
> >
> > Correctable memory errors are very common on servers with large
> > amount of memory, and are corrected by ECC. Soft offline is kernel's
> > additional recovery handling for memory pages having (excessive)
> > corrected memory errors. Impacted page is migrated to a healthy page
> > if inuse; the original page is discarded for any future use.
> >
> > The actual policy on whether (and when) to soft offline should be
> > maintained by userspace, especially in case of an 1G HugeTLB page.
> > Soft-offline dissolves the HugeTLB page, either in-use or free, into
> > chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> > If userspace has not acknowledged such behavior, it may be surprised
> > when later mmap hugepages MAP_FAILED due to lack of hugepages.
> > In case of a transparent hugepage, it will be split into 4K pages
> > as well; userspace will stop enjoying the transparent performance.
> >
> > In addition, discarding the entire 1G HugeTLB page only because of
> > corrected memory errors sounds very costly and kernel better not
> > doing under the hood. But today there are at least 2 such cases:
> > 1. GHES driver sees both GHES_SEV_CORRECTED and
> >    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> > 2. RAS Correctable Errors Collector counts correctable errors per
> >    PFN and when the counter for a PFN reaches threshold
> > In both cases, userspace has no control of the soft offline performed
> > by kernel's memory failure recovery.
> >
> > This commit gives userspace the control of softofflining any page:
> > kernel only soft offlines raw page / transparent hugepage / HugeTLB
> > hugepage if userspace has agreed to. The interface to userspace is a
> > new sysctl called enable_soft_offline under /proc/sys/vm. By default
> > enable_soft_line is 1 to preserve existing behavior in kernel.
>
> s/enable_soft_line/enable_soft_offline

Will fix this typo in v3.

>
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  mm/memory-failure.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d3c830e817e3..23415fe03318 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_mo=
stly;
> >
> >  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
> >
> > +static int sysctl_enable_soft_offline __read_mostly =3D 1;
> > +
> >  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0)=
;
> >
> >  static bool hw_memory_failure __read_mostly =3D false;
> > @@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] =3D=
 {
> >                 .extra1         =3D SYSCTL_ZERO,
> >                 .extra2         =3D SYSCTL_ONE,
> >         },
> > +       {
> > +               .procname       =3D "enable_soft_offline",
> > +               .data           =3D &sysctl_enable_soft_offline,
> > +               .maxlen         =3D sizeof(sysctl_enable_soft_offline),
> > +               .mode           =3D 0644,
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ZERO,
> > +               .extra2         =3D SYSCTL_ONE,
> > +       }
> >  };
> >
> >  /*
> > @@ -2771,6 +2782,11 @@ int soft_offline_page(unsigned long pfn, int fla=
gs)
> >         bool try_again =3D true;
> >         struct page *page;
> >
> > +       if (!sysctl_enable_soft_offline) {
> > +               pr_info("soft offline: %#lx: OS-wide disabled\n", pfn);
> > +               return -EINVAL;
>
> IMO, "-EPERM" might sound better ;)
>
> Using "-EPERM" indicates that the operation is not permitted due to
> the OS-wide configuration.

Miaohe suggested -EOPNOTSUPP. I agree both EOPNOTSUPP and EPERM may be
better than EINVAL. But I wonder how about EAGAIN? With EAGAIN plus
showing "disabled by /proc/sys/vm/enable_soft_offline" in dmesg, users
now should be clear that they can try again with
/proc/sys/vm/enable_soft_offline=3D1.

>
> Thanks,
> Lance
>
> > +       }
> > +
> >         if (!pfn_valid(pfn)) {
> >                 WARN_ON_ONCE(flags & MF_COUNT_INCREASED);
> >                 return -ENXIO;
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
> >

