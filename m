Return-Path: <linux-kselftest+bounces-47479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57356CB7E4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C98F73007214
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2130DEA4;
	Fri, 12 Dec 2025 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="REmhfUCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6F30B509
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515555; cv=none; b=qsWqo4KnHZaVKXGi2OTUNkTv+v38M77wTHKCEMg9orvCS/56o9YaCBikN2VukuyVMKfV9JFXoWFIVrF/xFQcoXaT3UNL4ebceKIJMFaZljhTEF9rrfT2rQgt/+9N8+B9wL/JQsjueqau6Ghs78imK7bBwe98bREaIHK30asUifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515555; c=relaxed/simple;
	bh=JsXSANY5x9qYuoEpX0iN8rj64TPTx9OOfyT78UEOKO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j41iGb9/D393fm5pkzcmu9h92ufBMt9QEGA2YL3C4MY1Cdidd/DLZMJ9tgfOtkOE2QV3kjpRt0sxXzXucOMy9r7ZjrrfA5yihnhTaT5s418iY7kIty7tHmyRS7OEtr3PihzBV7zyeNc9v7wEh2YTnVl9P7JPKGufMBjbxRgNLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=REmhfUCC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34abca71f9cso76091a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 20:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765515553; x=1766120353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbySMifjoEM/vxngZ1qDY6DG+JhyZOZSoJ49L6Z32Go=;
        b=REmhfUCCe/rxpnCbtdyH+cffUVIB8nuYQIUkheSLK/2nD9ASTiwISYUyCNBXZlJqj3
         XD/GLL+ro0UtpQA3L+nbPbnpQKLCj/AWHaUvc+VSbnitV6mCeuLB0j9hqhf45mXovTJE
         wMmGkYZP9Rd0dCIQ5x+AMGITejMltSkmtY4eqSCA2dWUG7b2jiIlnRCTd/PhcIks3/fs
         llytoWd6jy4VbdQo3iqMtl2GBdqoqk0FNXNV6uUdIzXOP9EptoI1LyGKBAzcTPci4Afc
         0cg/l8aeSQ6EWcPIXJXVt8OyBUgvlB9gsOUv8F8iBe8wXacLTYZ9i45FzO1sJvggAcVB
         xApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515553; x=1766120353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbySMifjoEM/vxngZ1qDY6DG+JhyZOZSoJ49L6Z32Go=;
        b=IGsS4Xsw1fIP9MuMEa0ILUHEgDWRkKNlSEISyf6dnHD81ddrWsLVho/mDU5kjCrAFk
         c9qWm/oLzqjItsS+1RGBXA4eJWs8Ofjy1eshlK+bkx4Tk3CqRmSrh9CLJRhPozSatQbE
         0B9fANC311h7HC/5YmXRmOfYq/awlIjJvTFnmdq6r2Zyvij3GuTmJBUY9QS2lKUKnPgr
         edF7F8EFgUIjX7PFh1huSHI/uCS43XhiwI7DS7it5w1l3EmrnD+PI+A3suSPNPn2J31X
         KkwjbOCz5Dw5B6hrT5eiUpNe5mNfeQ7Eiz3YmCTH0GQIkgOR6n5yzsgY/OHduwrIYOJo
         7MQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4AlzFcsmLFhvK1iyDqTqGizGIMXKgko8Z0MofNem2rBNZIku0GtVw/Z3XeDKuQv6a7tTo0BDO8DGF7rlBotA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyYtDJO5vl2ATs+sQbv01w0IQvJ45d26F3oF20IKv8gDNyCXy
	wBTam0G2P/2DqCzLePy7Kh8gOI614YQmU9J6dRE5u5Jy0fmKjhFDfVlThhk3R7G8lDf3HqY75HU
	AHDtN+sTutuNUQ/xJwdt+192DSEflB3IEyrXQrtqD1JVdQnbjfsJR
X-Gm-Gg: AY/fxX7XMxAFkKg7YD5XYtb8nLNpdRKtia2kTEu5+pISfe29LEVlDoVUdbSees6rimd
	x4RsBcNpOSpYgr0uTZTeDiRGgY92ui4K1/gOp0+ylV3eherUJ274F3rSCeTOaFbKdMNJI1xxdAC
	NmS7Ogx0Sjzz3Ti28lz50ByKJydhjUA9l+U1JpuL+VhtskHypzVCkvdC0ddvyyhklFKzT8oJbqo
	+f6cv74qmKtQ3xKh3AVnob7ARsLeNhwAr29fiv9LwVI67Ul0zZrg5DBaqJdzAG8obHTLJlZTrRW
	xEv0fQA=
X-Google-Smtp-Source: AGHT+IHJFIJctIFMYGvO0ua5435NS/1w+uUcAtottr81JUHeXT+Z3RKNtckKVcBOTe+KO0chme59upbMLWKFCD9eFvs=
X-Received: by 2002:a05:7022:6390:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11f34c47486mr453909c88.3.1765515552393; Thu, 11 Dec 2025
 20:59:12 -0800 (PST)
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
 <aTuAGQOurmAfbJc7@fedora>
In-Reply-To: <aTuAGQOurmAfbJc7@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 20:59:00 -0800
X-Gm-Features: AQt7F2qSdhQM6s0uy_jcJ416mfBHD3FuJYFA0RaVMGGLncXb2Ins_nDSfxRhtbU
Message-ID: <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 6:38=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 3:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wrote:
> > > > On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wro=
te:
> > > > > > The kublk mock ublk server allows multiple data copy mode argum=
ents to
> > > > > > be passed on the command line (--zero_copy, --get_data, and --a=
uto_zc).
> > > > > > The ublk device will be created with all the requested feature =
flags,
> > > > > > however kublk will only use one of the modes to interact with r=
equest
> > > > > > data (arbitrarily preferring auto_zc over zero_copy over get_da=
ta). To
> > > > > > clarify the intent of the test, don't allow multiple data copy =
modes to
> > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's=
 an
> > > > > > independent feature. Don't require zero_copy for auto_zc_fallba=
ck, as
> > > > > > only auto_zc is needed. Fix the test cases passing multiple dat=
a copy
> > > > > > mode arguments.
> > > > > >
> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 +++++++++++=
+-------
> > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
> > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testi=
ng/selftests/ublk/kublk.c
> > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > > > >                       break;
> > > > > >               case 'd':
> > > > > >                       ctx.queue_depth =3D strtol(optarg, NULL, =
10);
> > > > > >                       break;
> > > > > >               case 'z':
> > > > > > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY |=
 UBLK_F_USER_COPY;
> > > > > > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY;
> > > > > >                       break;
> > > > > >               case 'r':
> > > > > >                       value =3D strtol(optarg, NULL, 10);
> > > > > >                       if (value)
> > > > > >                               ctx.flags |=3D UBLK_F_USER_RECOVE=
RY;
> > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > > > >                       optind +=3D 1;
> > > > > >                       break;
> > > > > >               }
> > > > > >       }
> > > > > >
> > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT=
_ZERO_COPY */
> > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> > > > > > -             ublk_err("%s: auto_zc_fallback is set but neither=
 "
> > > > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT_ZER=
O_COPY is enabled\n",
> > > > > > -                                     __func__);
> > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF=
_REG)) {
> > > > > > +             ublk_err("%s: auto_zc_fallback is set but F_AUTO_=
BUF_REG is disabled\n",
> > > > > > +                      __func__);
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > +             fprintf(stderr, "too many data copy modes specifi=
ed\n");
> > > > > >               return -EINVAL;
> > > > > >       }
> > > > >
> > > > > Actually most of them are allowed to co-exist, such as -z/--auto_=
zc/-u.
> > > >
> > > > Yes, I know the ublk driver allows multiple copy mode flags to be s=
et
> > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the others are
> > > > set). However, kublk will only actually use one of the modes. For
> > > > example, --get_data --zero_copy will use zero copy for the data
> > > > transfer, not get data. And --zero_copy --auto_zc will only use aut=
o
> > > > buffer registration. So I think it's confusing to allow multiple of
> > > > these parameters to be passed to kublk. Or do you think there is va=
lue
> > > > in testing ublk device creation with multiple data copy mode flags
> > > > set, but only one of the modes actually used?
> > > >
> > > > >
> > > > > >
> > > > > >       i =3D optind;
> > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/=
tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > >  fi
> > > > > >
> > > > > >  _prep_test "null" "basic IO test"
> > > > > >
> > > > > > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallba=
ck)
> > > > > > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
> > > > > >  _check_add_dev $TID $?
> > > > > >
> > > > > >  # run fio over the two disks
> > > > > >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioengin=
e=3Dlibaio --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>&1
> > > > > >  ERR_CODE=3D$?
> > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/t=
ools/testing/selftests/ublk/test_stress_03.sh
> > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > @@ -36,19 +36,19 @@ wait
> > > > > >
> > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BA=
CKFILES[0]}" &
> > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_=
BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc=
_fallback &
> > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fa=
llback &
> > > > > >       wait
> > > > > >  fi
> > > > > >
> > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8=
 --per_io_tasks &
> > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads=
 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthrea=
ds 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc=
_fallback --nthreads 8 --per_io_tasks &
> > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fa=
llback --nthreads 8 --per_io_tasks &
> > > > > >       wait
> > > > > >  fi
> > > > > >
> > > > > >  _cleanup_test "stress"
> > > > > >  _show_result $TID $ERR_CODE
> > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/t=
ools/testing/selftests/ublk/test_stress_04.sh
> > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > @@ -35,11 +35,11 @@ wait
> > > > > >
> > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UB=
LK_BACKFILES[0]}" &
> > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --n=
o_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --au=
to_zc_fallback &
> > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_=
zc_fallback &
> > > > > >       wait
> > > > > >  fi
> > > > > >
> > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthre=
ads 8 --per_io_tasks &
> > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/t=
ools/testing/selftests/ublk/test_stress_05.sh
> > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > >       wait
> > > > > >  done
> > > > > >
> > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > >       for reissue in $(seq 0 1); do
> > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i =
"$reissue" &
> > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -=
i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$r=
eissue" &
> > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "=
$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > >               wait
> > > > > >       done
> > > > > >  fi
> > > > > >
> > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > >       for reissue in $(seq 0 1); do
> > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -=
r 1 -i "$reissue" &
> > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc=
 -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --auto_z=
c --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1=
 -i "$reissue" &
> > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r=
 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc --au=
to_zc_fallback -r 1 -i "$reissue" &
> > > > >
> > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > >
> > > > Ah, right, I forgot that the fallback path relies on normal zero co=
py
> > > > buffer registration. I guess we are missing coverage of that, then,
> > > > since the tests still passed with --zero_copy disabled.
> > >
> > > Looks one regression from commit 0a9beafa7c63 ("ublk: refactor auto b=
uffer register in ublk_dispatch_req()")
> >
> > Is there a particular issue you see in that commit? I think the issue
>
> Looks I overlooked.
>
> > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but zc
> > isn't enabled, the null ublk server will just complete the I/O
> > immediately. And --auto_zc_fallback isn't supported by any of the
> > other ublk servers.
> >
> > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> >         queued =3D null_queue_auto_zc_io(t, q, tag);
> > else if (zc)
> >         queued =3D null_queue_zc_io(t, q, tag);
> > else {
> >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> >         return 0;
> > }
> >
> > So it looks to me to just be an issue with my kublk change.
>
> But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallback code
> path isn't examined actually.

How is it broken?

