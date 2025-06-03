Return-Path: <linux-kselftest+bounces-34233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6925ACCC7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8846116C8D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA841EDA2C;
	Tue,  3 Jun 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYQ0PiCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792D1EA7E1;
	Tue,  3 Jun 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973032; cv=none; b=cz2fSXbg9QhV+KiEqiavvokv5JeE1CCObCaLA439tm0Bpx3h2cEC5mvAjDl42GXrQN6DbzQFren3dntSXY2TsZRpBCB7EJChy/tcbr8oEtG5tc57GkeAVd0TW1tAJcNvle5RE5vmEdBExbj/fIG10gKuiIbE3pqFTsSLmtQGQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973032; c=relaxed/simple;
	bh=rR55h1Oc5I7OX507jj0QzQQDChbR39GtqPq5gFh9m+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpdrroOXrQjTCHU44CwOzzx+RZ4cb2/e7Co6OYo/oFqydBTbKvoxX08RkQhTRxqBKzJ02GkggaRtppBKZ1pITJL8qzwNGN8iwiGWJ410iF7vPz1d+wTxrCiuBIdO+hdHDWMphi+wRLWcb75VUvfLfK2LFZJAC/5eZKyRi56hGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYQ0PiCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E487CC4CEF9;
	Tue,  3 Jun 2025 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748973031;
	bh=rR55h1Oc5I7OX507jj0QzQQDChbR39GtqPq5gFh9m+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qYQ0PiCGCjVgwiTilxKBP3ORRq5c93uCt9XVOzikZjpHwanX2sSty9XDyVC78mDKD
	 M+B6UmmkLIV28MStuSRQC4n4z0vpU/bcB2PUdJ4ciB6I6Hf9jv5thZpjOzK2Yzhbi0
	 StsIsHZ+Z7qMpJJ2prhCalBzESUcHozhIF6IzYzJg9ht19WPJacJvw1jflKcA32Vvp
	 JRjromliNbm7LyKQ6GDD8cYisqDVAn8hr2zHjZ2Lqi+4dattMpWkEYxnDuxj6Bx9Tv
	 KxVWJwgpLXS9ZSJru8cKjtmFum8ggXqLo2zzEEkEu4CWqhienN3XcpyFw0/BOerLyO
	 3+jx9EOBUm+NA==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43e277198so43098871cf.1;
        Tue, 03 Jun 2025 10:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0bXhvO1eS2PSEfV5pJdeArIaTH8Bucw4hpIM9r3EQH6loiGBlnHe4wD87Y0Je8XGcRUzoB//DwXbHmw==@vger.kernel.org, AJvYcCUko2gE4bZW8ci2Qy7Zi5bHry1suG2ryRu+2t4BOQzbgQnsUGLctNg5YOxY/UR74V78nCc=@vger.kernel.org, AJvYcCW5Dsciq8oE1MVInHPraFOUjlmyaHOauaAOlxMGhKr9J99AW4ZmjX4uoQyRoeaqdEGgZe5+soenintEAMQD@vger.kernel.org, AJvYcCXEVmduACBx13jF8xDwhA8dMNbrW4fEirHZWQIf6nquPSuNttmFe2VTRr/mfymZi5FAqZG14kYtnyhzW/205Lxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDMEfCZBPn/dUG4QPvrMoXxdpn7YLNW+QVUt4BZXEoI6vt4ew
	9pdd57ZCIMK4iLmxmj3qyPH/0LgTyGaBqvb1NnFbX4cctapITQ9tTdtJ2FhLKk68cjGUmFnuzlq
	GhD5Th8S0j9zO/Dvt8JuuerQNjeRGUQ4=
X-Google-Smtp-Source: AGHT+IGH89bNEIZJdNXWW/fmQbltNFmI6Lpl8xNk7B7qukpUNnjBjFGNWP4jL95c+qF9DoqBC9pLkWNsiMf2MiibVzk=
X-Received: by 2002:a05:6214:2422:b0:6fa:c168:8de4 with SMTP id
 6a1803df08f44-6fad914c9b6mr239099746d6.33.1748973031011; Tue, 03 Jun 2025
 10:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512091108.2015615-1-skb99@linux.ibm.com> <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
In-Reply-To: <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Jun 2025 10:50:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
X-Gm-Features: AX0GCFucC_KlFpcqemykP-Etlbbk5Y7NbPJFzc0j54LWJAAGEUOW479vezMZd8Y
Message-ID: <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build error
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, gregkh@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com, 
	venkat88@linux.ibm.com, sfr@canb.auug.org.au, alexei.starovoitov@gmail.com, 
	daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com, 
	martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org
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

A fix is already in the bpf tree, with this fix as well:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D4b=
65d5ae971430287855a89635a184c489bd02a5

Thanks,
Song

