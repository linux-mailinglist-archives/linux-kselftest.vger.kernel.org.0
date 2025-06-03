Return-Path: <linux-kselftest+bounces-34232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A9ACCC74
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DDA16C6A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC01E5B99;
	Tue,  3 Jun 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpavKYqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B819AD8B;
	Tue,  3 Jun 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973017; cv=none; b=dgQplL1KqNMJJVvFQ71ZADjAlls8V7+VfJAUVXm+UGcfXWkj9ZveePfv1PCLI5JNcmo7WzPcguHA5Bdinn+02ekiSGcdqp6oVQCGDOW7gg6Bkudgvv66RDTf0Wh9QtmlIWbaUYc1YiYFgQyZDi/5GGlxIEIlHD7IdJAGpdk5DZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973017; c=relaxed/simple;
	bh=+P9mz2/dNx+Ja6g20CiNWT7U9sEmU4shm9zpnDESgVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cziGtuA18nB0l5mY39yNbuPHCoihi0NA7qLcZUje/61GWSbPjZvhYCFEpVRIhxtQG6I2JydoetTJ0GTiZlYDPeHIFyf7CD5yyBPYd500k7hs/WaLZH6RqJDx0tFYx4J8Pzoux0khgno8+g+Xjch8ihEjvvFUTRQ+7CuIxKCblok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpavKYqH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso51238065e9.2;
        Tue, 03 Jun 2025 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748973014; x=1749577814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3ZMB8cbHHataGljo/wMvu1pmX63Ggbe+B4wUbd/xuk=;
        b=dpavKYqHIarBKigGgvnhI8k5Zx9MHSX3n4BVsCXCiG0VojdHIdpNsBWfJbGOc6GRPA
         YZjrAvf4pzAsvtBM5tqowYx9K1tC9kJEEEPv1zaF9AYljYANAOPoBcVDDNIznSlDi979
         tgTil0phLI0rPq4Wf2edzjmHySCcJ6rPBf/DQfHY1VTNLHjLbuj9pKVTVgJFPaNtPzTc
         XO9PqlVq4MAGhzlYd1ZhHUnMTVLcT/BIdc/mzXWe/O4m+OgI9OT+NyoWTsjDBncqs6KA
         1EKIVV9MauBtrs0PoCPkenBC/AbJlpCavvycPp4Fr+Nw8vZw01M4xbqwkaCQE0og98Wa
         U6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748973014; x=1749577814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ZMB8cbHHataGljo/wMvu1pmX63Ggbe+B4wUbd/xuk=;
        b=ME3hr0nXqbmZMVj6oxltz+8tgMjKdV/yN9VU50G2JmZx/qilu4cDA5bNKaTkzqWIOm
         zB2BUPis0O6s+a6KjJLr54thUbjXU0ytXERH1XFFMdvIGhXQBJfWSVgb8kicpwRoyWK9
         Nb9xZ4VB33yGT5iDkwwgI0rMsP9UWkEB5x43+hagnHV28bxbtuEfJq1R0g0VhRERmojV
         zwR4/0olxwutmbPbO//jdoy/zkxMsJgjHTRQgsyVMZf7WYju661thQhOXVmKigZkSVBy
         e97Iiv5/zK/DA89Lj/vc1f/9eANih6icqpl0igBTPuO/mvj+22cwBLnvBpsk7JnLn9Km
         /j9A==
X-Forwarded-Encrypted: i=1; AJvYcCV80F0xkUNM60TWN9S0dLxukyIhGGVVxiNyUJzH2Y1gJS6/oFUFGhU9CME7eOt/eVd3DRU=@vger.kernel.org, AJvYcCX0MkWdkyBEbTzxGg6GAAgr9nD9I8pZDw0NMEVzz4hKhk/73aLHDm4pOkMLzCq6D/D73bI6BXlwGMqKsAJqpbNC@vger.kernel.org, AJvYcCXFTnVbaGbgllG3U+kafvxa0kBVYsiknFq0r1p25ERepc19z4KJV+Oc089+V5cZ8h5h6x56POWgQfdv2hQN@vger.kernel.org, AJvYcCXMSF8Vc5457gItvYonBAsIA9fTU8R/wdKKgWJQoJDyfAgrDGiOmb2EUqFh0+UD9ZNN1WkkM5NTiiLCRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ftuMIv7dRHblwJ8Zkt1vkNH6V8ih7f0GpvhEdBDW2sgVOowD
	EDimv2WEw03A6B0kEZqFA5eEnTNP21kr3HYg4un9XLXgBaQ4xWNWHuVGw5rFqJH4wX0UYuF3zN/
	PEHZkfzI/YRuFYMUy4D8svyPf32o5aEg=
X-Gm-Gg: ASbGncuxJTbdnf4d4qs0oWZiJILS1fqKrVjNXJLbLUcVZ90iS+VEB+gRfgpcYJtgKpU
	PEKQa206QyilkIYLnsJ9kK5gZQzpWWdR4NLUSpTbiULpKIo5CasAVnWRdPh/udOFjF7HITQvavD
	JqV7oUCa7Z+B7gB0oAodHS3WhcDWCa5moAxT1Ye2T4XFdO2lzEmf1ee82OioM=
X-Google-Smtp-Source: AGHT+IE7N8QgUDuzY/ZtEIGI0StuV37XVRZa3tJdfbumK4XtvEoQF4MNSQ/+6GnYZf5KESZS1wHKiI2OUTXDKwWu5yM=
X-Received: by 2002:a05:6000:4203:b0:3a4:dd8e:e171 with SMTP id
 ffacd0b85a97d-3a4fe3955c6mr10414934f8f.40.1748973013878; Tue, 03 Jun 2025
 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512091108.2015615-1-skb99@linux.ibm.com> <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
In-Reply-To: <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Jun 2025 10:50:02 -0700
X-Gm-Features: AX0GCFurfVFjsMvuGM3D6ZaZW-BLTEWjlxEbU_zc0831tkJsc3_2BgFkbpLjvAw
Message-ID: <CAADnVQKWZCu_hgrV6=PMzHizDpJuR+yQjZs4b_=f7MyD2Lip+w@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build error
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Mykola Lysenko <mykolal@fb.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:33=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Mon, May 12, 2025 at 2:12=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.=
ibm.com> wrote:
> >
> > On linux-next, build for bpf selftest displays an error due to
> > mismatch in the expected function signature of bpf_testmod_test_read
> > and bpf_testmod_test_write.
> >
> > Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_att=
ribute::read/write()")
> > changed the required type for struct bin_attribute to const struct bin_=
attribute.
> >
> > To resolve the error, update corresponding signature for the callback.
> >
> > Fixes: 97d06802d10a ("sysfs: constify bin_attribute argument of bin_att=
ribute::read/write()")
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f378129f=
6@linux.ibm.com/
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >
> > [RESEND]:
> >  - Added Fixes and Tested-by tag.
> >  - Added Greg as receipent for driver-core tree.
> >
> > Original patch: https://lore.kernel.org/all/20250509122348.649064-1-skb=
99@linux.ibm.com/
> >
> >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 2e54b95ad898..194c442580ee 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
> >
> >  noinline ssize_t
> >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > -                     struct bin_attribute *bin_attr,
> > +                     const struct bin_attribute *bin_attr,
> >                       char *buf, loff_t off, size_t len)
> >  {
> >         struct bpf_testmod_test_read_ctx ctx =3D {
> > @@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO)=
;
> >
> >  noinline ssize_t
> >  bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> > -                     struct bin_attribute *bin_attr,
> > +                     const struct bin_attribute *bin_attr,
> >                       char *buf, loff_t off, size_t len)
> >  {
> >         struct bpf_testmod_test_write_ctx ctx =3D {
> > --
> > 2.43.5
> >
> >
>
> The build is broken in Linus's tree right now. We also now need:
>
> @@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
>
>  static ssize_t
>  bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
> -                        struct bin_attribute *bin_attr,
> +                        const struct bin_attribute *bin_attr,
>                          char *buf, loff_t off, size_t len)
>  {
>
> Should I send a separate patch, or can we update this and get it to Linus=
?

It was fixed in bpf tree couple days ago.

