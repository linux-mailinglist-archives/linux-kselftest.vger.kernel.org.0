Return-Path: <linux-kselftest+bounces-47512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A087BCB95BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8076309B125
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469BC2FFFB9;
	Fri, 12 Dec 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kerfs//+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7462FF163
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558249; cv=none; b=hlI6sn9ZlGINSMkXbVoaBBM3FMWpdaOkgR41U//jhUX+0wm2aO/qpH1Tns5ERGkgN0s26t6DJGE/7E9dq5OHGq4+xV3XE8lKrBGhWdKnZFsuOkAXAcFcgHUy4yebdK90NZjqTfLxZ8b75LRSOvsK8tbPvEqaKIu9Xl9C/cMC6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558249; c=relaxed/simple;
	bh=gHqFmJu8Q7cEzcmAy0y+0r5LxtGfMwXgn88CsLSJY80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgI9LJLsMHom7nH/jrqS/w1mpQLB9h24V+33/QuZJgHl5LXTVdKnxfzZ0GFSpvEGEJCods7khh77H4NrduC+lu7NhM957EXRZXBXZSEq3kCAsdgdpqvrfh44ZZ41HI4uqSEVfpehcADphS+sMG42ICpr9R7IqJMN2gwVpnQEPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kerfs//+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7e7a1b08e9dso62110b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765558245; x=1766163045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6TtTuhlyGm4Yzy8Bwa+JBhXmcS0UPhYZfP/K0YNXHE=;
        b=Kerfs//+O9YJkJqjUC3VyP8BCGn6vb/FCkHiekSswPd3ywfiJUqLp5hIu8r3rJkJzg
         VL4Bx7fQuujYAfSex28aDUmiVAAomgutWVx+YaRhSeLvWNyHtWI4pAjaetpIfcq4YDLD
         MvkJqMTdGcmxDz5z8hThDbPihLk2aAGOr38IfeKikpGYykNsTiaPpD6ZXe4SLTPitOXQ
         B2NUVbzs+exEHTnTX45W7uQN6wRl7ucpw0JcKeDngKv3LIY3JL4U8r5NC+1uH6vE8r1r
         F6uNEVZxVjX51VM0RteTO2iSiaoS8YU64dj4u3LwtR/ufWfB2pE9YFm8PVsxSKw6Co/b
         z+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558245; x=1766163045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6TtTuhlyGm4Yzy8Bwa+JBhXmcS0UPhYZfP/K0YNXHE=;
        b=dyotzXBO6iuNykgWBzoUgEw/WkLmjKnu6GoW24Z26m2DhrzKkSku+tjGnvAHyNU2PD
         mFBAI/T88IGSAoeUo3pGsS8d71cu3ZlsLhTyZ44s8BZLZIaIdd7KsgE0VeMtss2pA6f6
         CRUojWtBrgpnXS+fHQYbOwE7s+Suf4MsnSVqcDw6uaVpQV+iQ6zOx6pt37aEQ8qI/U2q
         CHB+bLp/XEnRb6QYciyMOM2uvjGEc6Dl7iqbR8MeRUCFxm1T77QkSolgz8sd4MfL/xgM
         eJHhbzSjNI+VGiDw6fWyWtDhyMOMNw0jAs6hBd5PeFODRqTc84MjC1gxlCgvU3AUmOUm
         Ucxg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+sfH6kpYU6LhIS/4AETOl2zNTLYAa/RlcoYUmlKaI4x3suuKs55P8Lhu7ALDCOiYmnn1pKHXC8t4CCTemLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOP0XhG7bU0zFu8Pz1LHJSCaiJK6aLsi0R3b8yX57TKf0IDyu
	cXpfT7io7H7Zn81qoSOY1qXX/wEF1/ZgV3qiZyQFW1MWGDWKlQ708hhQrV2BjdfJuvAtjzcMvGm
	cr/GjZJOR7TRGPd8u4yE6uN5tG95lSUNRmjuBm2Ineg==
X-Gm-Gg: AY/fxX728P/k+g2JJEPjZsJN8s7TJw+4PNVCPWb/9N/lao7RnyjVCxCh7+JyDgXvnOR
	oY1OtEUFWRd16fyXDTRieEYFCsA5BbSMnC0RYVmR1TTxLoYGkxSCoqYTMLZVZ8lROKa5dMXZL7X
	akFInWYkMhWZHNogmytu8ss8r4OD7sp82YN/+6uQxOB8v4oJSpbGYzM14q61+dp5+BOqFLwLmPb
	POvfgOdMBMa7Ynz0kLsUd8vfDJKiEPlUtckuu5Q8Edxxw5ergzGm6ybTwrgag00Sl6t2RhN
X-Google-Smtp-Source: AGHT+IEcJsxz5ZEELPu6pxm4vJWkI5dllQ3f0rhBgVRfUNTGD/NqYNvbUp05BHQg6uvLwAj4rrBSA4R+LEUpwwKjShM=
X-Received: by 2002:a05:7022:989:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f34c47c98mr1052360c88.3.1765558244555; Fri, 12 Dec 2025
 08:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com> <aTv06QEJIYyJKCVQ@fedora>
In-Reply-To: <aTv06QEJIYyJKCVQ@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 12 Dec 2025 08:50:32 -0800
X-Gm-Features: AQt7F2oV7VYFcC0-QUXJvhB3eLP1TVAemCkfOOOvLxD3ZsJNAOgqc72w4YyEZl8
Message-ID: <CADUfDZq7wno5FEKrJEQ-YNc_VzshNAoefjsrRL4AC6QK4c_DoA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 2:56=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
> > stress_04 is described as "run IO and kill ublk server(zero copy)" but
> > the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> > test cases is duplicated. Add --auto_zc to these test cases and
> > --auto_zc_fallback to one of the duplicated ones. This matches the test
> > cases in stress_03.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/tes=
ting/selftests/ublk/test_stress_04.sh
> > index 3f901db4d09d..965befcee830 100755
> > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
> >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_f=
ixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> >       ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fa=
llback &
> >  fi
> >
> >  if _have_feature "PER_IO_DAEMON"; then
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > -     ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_t=
asks "${UBLK_BACKFILES[0]}" &
> > -     ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io=
_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --=
per_io_tasks &
> > +     ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 =
--per_io_tasks "${UBLK_BACKFILES[0]}" &
> > +     ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads =
8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallb=
ack --nthreads 8 --per_io_tasks &
>
> The last line needs `-z`, otherwise the following warning is dumped:
>
> ```
> # selftests: ublk: test_stress_04.sh
> # main: auto_zc_fallback is set but neither F_AUTO_BUF_REG nor F_SUPPORT_=
ZERO_COPY is enabled
> # stress_04 : [FAIL]
> ```

Yeah, duh! I swear I tested this... Oh, it's because I had revised
this patch following your initial feedback but replaced it with the
version from v1 right before sending it. Will fix.

Thanks,
Caleb

