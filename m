Return-Path: <linux-kselftest+bounces-47490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BCECB7EF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02590300776D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88442777F9;
	Fri, 12 Dec 2025 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FZm8sp+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8802C0284
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516911; cv=none; b=JNbCJY7MDPV+CkpwOuBL7GAVd25ktVCvKUSY4VobvLHTdNEaxJcgv3b1XoPTjwA0iuD9NBQAXWlJOGQIkmiYz2t+Y0I6NJsjPV7P4VRMifOOODtqSW0D5G0I2XjQ0IIcUog96hvVSRIEbZChr5c2camblxx0+6EhylaudNpCGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516911; c=relaxed/simple;
	bh=caRn6+YjTjfWjMskcJDu10kqvdlmrWciiKlFqekJ6VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJl/N2sDqy3D+NAG4UnYZ9e1SVsVZXjxtQSqRPVJq365ihnJTcF9ZnK9kW5vdvZXj95Dm+DRtVXWGkFLEqkiuiqHyyFtsXm/il6Y0Y2Fs5H8MBgWaRA/iE/JUdl6ArJhmoxIH9xrP9fNyuKo5DQLSHJuSSNi7s8F1dmgQ7XjBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FZm8sp+k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297dfb8a52dso938605ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516909; x=1766121709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTd51BYB9azkPglNcZoA6pJmBBLZI/2+nKAtQ6hSR/0=;
        b=FZm8sp+kqH2wnhjsV8SxuQ7+22ElO/7wIpbbKDkGg6KbSIIal/8z0xY471T0HSc7f6
         4ZWucjBvoo+nqIXNGPxniIMDWPtMpf7QvjCYop0OMGYRDBJb1cHqhlaCHldJZr1R5APl
         /iCdea8XC+K5eWheS7dVaQKo+iufzOAHYHrWWJYP0UIHKzzKQ5u5bjtN8R9hC199IBen
         rlLle7pQrMV4bDo/asYQW9PpK+vwO0yxnG4v/27O4Udn+IG+y1uULfWqTMERxL8r7SLL
         RG/ZfM+M3H2HOXiapv63e5EAvYnGCwkHS7SnVKsT5Y8yKg9oPeYUQTdBbcvoTLybeH0r
         BBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516909; x=1766121709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTd51BYB9azkPglNcZoA6pJmBBLZI/2+nKAtQ6hSR/0=;
        b=cWvfvx2ojM7twJWNagm8ZnjfPJ4wU9vWJ+gerKoY8t/Oneniv0+k+xf7AE5HmbfdYi
         fK5nl8s8dGp4MLqQGK2WL7gV7ekwDXTIWwbL0eKWR1nVNflQhjORfqNz44Ifw5AYoTw4
         XE8PRY/5ReBxRVxoEO58eCSQVSVPDcx/vz82voFT5ufDpPqajJ5gNfzJIfmM00hMwzsn
         8KR8BjBICxjodVr39QrUB3Xlli5HVm8ePf20YtyMVZ3GAp78haOTRdrRZOxYdjSwFenJ
         ocJNxJNvmrUogloepnApesDNDu8jCVTYtRAWNgjp2bmjUDPpfxIndViQIpZje4BPO4K8
         XhGg==
X-Forwarded-Encrypted: i=1; AJvYcCWv3x2/YqEUm2iliZejH7BzjMN1CG2pNRZbxvVNbWxoJF2BKUYeQRhFiRe/l5wdJBZquQU86aLuYSrynieoGjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnC0AOmSy8IbZ5TRDMjDuJ6+wz8ftoyoHgEe0DzaPMSz31YNO
	I8+GGB6R+u1Fhm0DjBAPtR6WoZwkt7jdHawrsxhdA0DukAnQPPuEQmR71iVJAl6HtR25sjDrvjG
	BKesp5mTXOJQ7BOAu6/4tNt1RcW6b5IZMO8njRMW8Sg==
X-Gm-Gg: AY/fxX62PJIEtTja7AL7jIfRF60DB1i7HGC9HU9SkZ1oOfu0hqHYvro6D5WYjC5yYLZ
	YHQGtzKCMy7H14IE7G2FmsdHB1XEiIB8k4QNLLVLqscuxhXN/N4ws61C33TmzQzwdCKz6ddhI/V
	ziFCiQtsXXtSsIXZkYE9kNUvyS7uyxsS2AKrnv6k6yVDDosehIwKyOy1/6cccwR/SMQhXJGDIGr
	ZlZU4so8nu6IgpfCjhcZBe+LtuKT/zwcukZn3ImMBYmt0JP4t/YcIcjjZEvgGikSD01nUpr1KfF
	y+S0MKQ=
X-Google-Smtp-Source: AGHT+IE+oqHTuGWJeLoqvmw0PVKCBgzgOHg9zHDgSAZtgzbOOJWf8RqlD4i1hWesur0diOI7wLjnbsRXp+zxYGlLUOw=
X-Received: by 2002:a05:7022:989:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f34c47c98mr378447c88.3.1765516908755; Thu, 11 Dec 2025
 21:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com> <aTqKLSbpQN26XLNq@fedora>
 <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com>
 <aTtOGmEeYBZLozO8@fedora> <CADUfDZpzZ16vsWhMm6-tYfdj7EBBE_iUaLTmhyiZeR1CxT5d_g@mail.gmail.com>
 <aTuAGQOurmAfbJc7@fedora> <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
 <aTukkFnbsl5_I0No@fedora>
In-Reply-To: <aTukkFnbsl5_I0No@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 21:21:37 -0800
X-Gm-Features: AQt7F2rqVhacWyF5Nx-QnMQA06O8XPGiBfBGg9VIinhMm0TTfNgBmQjk0KtcG6s
Message-ID: <CADUfDZp3oyFSwLhuAOi24quNFYK2CxLB0dPm5dRiB-AjmHbG=Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 9:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 08:59:00PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 6:38=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wrote:
> > > > On Thu, Dec 11, 2025 at 3:05=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wro=
te:
> > > > > > On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@redh=
at.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos=
 wrote:
> > > > > > > > The kublk mock ublk server allows multiple data copy mode a=
rguments to
> > > > > > > > be passed on the command line (--zero_copy, --get_data, and=
 --auto_zc).
> > > > > > > > The ublk device will be created with all the requested feat=
ure flags,
> > > > > > > > however kublk will only use one of the modes to interact wi=
th request
> > > > > > > > data (arbitrarily preferring auto_zc over zero_copy over ge=
t_data). To
> > > > > > > > clarify the intent of the test, don't allow multiple data c=
opy modes to
> > > > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as =
it's an
> > > > > > > > independent feature. Don't require zero_copy for auto_zc_fa=
llback, as
> > > > > > > > only auto_zc is needed. Fix the test cases passing multiple=
 data copy
> > > > > > > > mode arguments.
> > > > > > > >
> > > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com=
>
> > > > > > > > ---
> > > > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 +++++++=
+++++-------
> > > > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++---=
--
> > > > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/t=
esting/selftests/ublk/kublk.c
> > > > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > > > > > >                       break;
> > > > > > > >               case 'd':
> > > > > > > >                       ctx.queue_depth =3D strtol(optarg, NU=
LL, 10);
> > > > > > > >                       break;
> > > > > > > >               case 'z':
> > > > > > > > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_CO=
PY | UBLK_F_USER_COPY;
> > > > > > > > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_CO=
PY;
> > > > > > > >                       break;
> > > > > > > >               case 'r':
> > > > > > > >                       value =3D strtol(optarg, NULL, 10);
> > > > > > > >                       if (value)
> > > > > > > >                               ctx.flags |=3D UBLK_F_USER_RE=
COVERY;
> > > > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > > > > > >                       optind +=3D 1;
> > > > > > > >                       break;
> > > > > > > >               }
> > > > > > > >       }
> > > > > > > >
> > > > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUP=
PORT_ZERO_COPY */
> > > > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) =
{
> > > > > > > > -             ublk_err("%s: auto_zc_fallback is set but nei=
ther "
> > > > > > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT=
_ZERO_COPY is enabled\n",
> > > > > > > > -                                     __func__);
> > > > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO=
_BUF_REG)) {
> > > > > > > > +             ublk_err("%s: auto_zc_fallback is set but F_A=
UTO_BUF_REG is disabled\n",
> > > > > > > > +                      __func__);
> > > > > > > > +             return -EINVAL;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > > > +             fprintf(stderr, "too many data copy modes spe=
cified\n");
> > > > > > > >               return -EINVAL;
> > > > > > > >       }
> > > > > > >
> > > > > > > Actually most of them are allowed to co-exist, such as -z/--a=
uto_zc/-u.
> > > > > >
> > > > > > Yes, I know the ublk driver allows multiple copy mode flags to =
be set
> > > > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the others=
 are
> > > > > > set). However, kublk will only actually use one of the modes. F=
or
> > > > > > example, --get_data --zero_copy will use zero copy for the data
> > > > > > transfer, not get data. And --zero_copy --auto_zc will only use=
 auto
> > > > > > buffer registration. So I think it's confusing to allow multipl=
e of
> > > > > > these parameters to be passed to kublk. Or do you think there i=
s value
> > > > > > in testing ublk device creation with multiple data copy mode fl=
ags
> > > > > > set, but only one of the modes actually used?
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >       i =3D optind;
> > > > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.s=
h b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  _prep_test "null" "basic IO test"
> > > > > > > >
> > > > > > > > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fa=
llback)
> > > > > > > > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_fallb=
ack)
> > > > > > > >  _check_add_dev $TID $?
> > > > > > > >
> > > > > > > >  # run fio over the two disks
> > > > > > > >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioe=
ngine=3Dlibaio --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>=
&1
> > > > > > > >  ERR_CODE=3D$?
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh=
 b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > @@ -36,19 +36,19 @@ wait
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBL=
K_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${U=
BLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --aut=
o_zc_fallback &
> > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_z=
c_fallback &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthrea=
ds 8 --per_io_tasks &
> > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthr=
eads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nt=
hreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --aut=
o_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_z=
c_fallback --nthreads 8 --per_io_tasks &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  _cleanup_test "stress"
> > > > > > > >  _show_result $TID $ERR_CODE
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh=
 b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > @@ -35,11 +35,11 @@ wait
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "=
${UBLK_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc=
 --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc =
--auto_zc_fallback &
> > > > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --a=
uto_zc_fallback &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --n=
threads 8 --per_io_tasks &
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh=
 b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > > > >       wait
> > > > > > > >  done
> > > > > > > >
> > > > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1=
 -i "$reissue" &
> > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r=
 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i=
 "$reissue" &
> > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 =
-i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > >               wait
> > > > > > > >       done
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_=
zc -r 1 -i "$reissue" &
> > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --aut=
o_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --au=
to_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc =
-r 1 -i "$reissue" &
> > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_z=
c -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc =
--auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > >
> > > > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > > > >
> > > > > > Ah, right, I forgot that the fallback path relies on normal zer=
o copy
> > > > > > buffer registration. I guess we are missing coverage of that, t=
hen,
> > > > > > since the tests still passed with --zero_copy disabled.
> > > > >
> > > > > Looks one regression from commit 0a9beafa7c63 ("ublk: refactor au=
to buffer register in ublk_dispatch_req()")
> > > >
> > > > Is there a particular issue you see in that commit? I think the iss=
ue
> > >
> > > Looks I overlooked.
> > >
> > > > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but=
 zc
> > > > isn't enabled, the null ublk server will just complete the I/O
> > > > immediately. And --auto_zc_fallback isn't supported by any of the
> > > > other ublk servers.
> > > >
> > > > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> > > >         queued =3D null_queue_auto_zc_io(t, q, tag);
> > > > else if (zc)
> > > >         queued =3D null_queue_zc_io(t, q, tag);
> > > > else {
> > > >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> > > >         return 0;
> > > > }
> > > >
> > > > So it looks to me to just be an issue with my kublk change.
> > >
> > > But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallback =
code
> > > path isn't examined actually.
> >
> > How is it broken?
>
> typeof(q->flags) is u64, but the return type is i32, so it is overflowed.

Ah, good catch. Yeah, these ublk_queue flag query functions should
probably return bool. Are you going to send out a patch?

Thanks,
Caleb

