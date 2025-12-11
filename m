Return-Path: <linux-kselftest+bounces-47453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44328CB6F26
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB1630194F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827525F78F;
	Thu, 11 Dec 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TkeTRsT7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA739272E45
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478816; cv=none; b=j5xiZMel9OmCVf02p4GnnY2d3G7w+8tNzNyu7xcgvsyGojZbNXDlNTBFuw3Ipgo9YPFAgrSj/S1wp1O3YzY03KT4PC25GpYKN19ZBoEHVXudvFsMdG+0FEfie93LDwCwyVoBALFyj3uT7ajT8V4L0lGfmBYf/6e+xPDdPHtRvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478816; c=relaxed/simple;
	bh=pQhcRGjeiu/3V/J6mIwmYOG4lNjPUS7TBpA93yYi8KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl/zoMZr9/ELG1aKBe4eMIgNGCNDM8F0vVPbZvVZCAslftZCxbRpzKFwcqlzpWpLTasBlQxqcBDJpGfoyP0GhMzygOhuMtV1YehLpfr70DkQ/4ST7GxjFPiyPIgxsY7TuKXC6ilvp90TJRyjmsKJ5pphNKBQiGRM/7SVfzdooKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TkeTRsT7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e2736308so582435ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765478813; x=1766083613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iSrIJaiBhg5gePezp8i0mtO1ph9hDeuHacXyx7pKY0=;
        b=TkeTRsT7Hro7zcYAYI5Etrer8319PsMGK63I9JeYjftA159XgdldWJLCCcgVd8euYU
         lbkgnd753gsLrIllNBw8WAVRuRP44GVG2TXR8/kiBfEozlqZ5lqYvOJzRGdFvrwKR9h9
         NTpTqPgJrW79KlY2fIzYAQOYouN2Y/dckacx777ZULWGesUgKFeLJE2Z63oUKamphFia
         q2JMFIYVyfrhyHG62C2G7pX+9ljqchAZIuiSBn4us8X3EXYBcMiQOfOwnQHPP4G68Tff
         c5sZbAceTy7ryVLbFBFXeQ48JAjq9QMApsQm5qdt4f2pE+EJQHesNoZcyYJ1Xgfr3pTO
         PH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765478813; x=1766083613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iSrIJaiBhg5gePezp8i0mtO1ph9hDeuHacXyx7pKY0=;
        b=q8qfuQulcPwBRrqv52DQcLDs8Qtd22wCbP7+kmsCoiUPvl3e9qGNimSpfiXue/Aa5b
         jWqsjvZUaMrjXJizujnUoLHRKUKo0A6jGkHD1y/Qy9dqK/uIlnXFix+ga6MR60orThHg
         4jgI4PWQ9dSalusFOoLcu/GqFmb3jeTWPDQpP12SIC6d7oaf8zNWAuocD6yCHimrcpAa
         ek0W2XEZJNrDKmOjVs4Yii135dLMOWkPC/EZQHVno6B5wgqyfgiIgwkJ+SzzSUqb4xVC
         lVUXPY7a9YTDxkYXDDmkpZM3MyfpXUVUfL98dPae9ntyqJwqCnDRn05nC10UikB4Ww07
         d7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhA8XVxtkC6r9hpVowEh25YQx20Lh2Zd6eIxenMkPkiZ57rkLFg/MuiSmwW8RAQgOdK4iCda2Tl6+uiJ9wJEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdJr+uIGtikdsO4BeA5Pvpo7Vi0hXe4hpOlLSnNLRT/KIvnDQ
	wHIqpY6ttgn+FRT+vcqhfgin6yBRPr25eTJd8yZhAOtRJDpsW9ppgSD455XSclvRiTvodPy6tPE
	hne2vR+9pl0BGVEzcvnaJxuQsQTE6gi2lOZ/uumy6Q9w2lhg87fGBheU=
X-Gm-Gg: AY/fxX7Q9McRIs88nff5JA1oxGc1eV/xE0u/7Cd7GFwkaeDVltnZ68Q39iBpmWwg8rS
	HazW+8XnrdPt0PXxkRvre/ddTBRLdsa+6gED5UyqBSnPwb1UvbxJviM8e6lchHw+jNd5TJ/ATPR
	67l7TMUG147+5ZT6MurrJ4GiR4BoAqDtAAUdzgM7RukUo4vGIPJguLlS83OrNZbNZW21b76U2r6
	BBAoQ7czU+P236YLcXT/LNfD+Ejul4FXy2ByAriLARph6pDbJ/qOOorB14mS22cJoM93r9/
X-Google-Smtp-Source: AGHT+IGsAaiXnorxHt4G4c8gZUm5iPvun87rOgiAz6ih4wtCvilF07mImoXTc64WvSSClGzbu2uwGdFMpWe1jQGHu3g=
X-Received: by 2002:a05:7022:60e:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11f296edc1fmr3101211c88.7.1765478812620; Thu, 11 Dec 2025
 10:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-9-csander@purestorage.com> <aTqMNP3aDpAs044T@fedora>
In-Reply-To: <aTqMNP3aDpAs044T@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 10:46:41 -0800
X-Gm-Features: AQt7F2q77lhKyfzt-lD3LppG4ZPYxQUrvzOqpBl0gJFAXPMDdKiZhPuHfU4lwVM
Message-ID: <CADUfDZr3WZHwZSMidQKH5p8yMDM6yWwbdyEJcvS6YBHSfFY_RA@mail.gmail.com>
Subject: Re: [PATCH 8/8] selftests: ublk: add user copy test cases
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 1:17=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Dec 10, 2025 at 10:16:03PM -0700, Caleb Sander Mateos wrote:
> > The ublk selftests cover every data copy mode except user copy. Add
> > tests for user copy based on the existing test suite:
> > - generic_14 ("basic recover function verification (user copy)") based
> >   on generic_04 and generic_05
> > - null_03 ("basic IO test with user copy") based on null_01 and null_02
> > - loop_06 ("write and verify over user copy") based on loop_01 and
> >   loop_03
> > - loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
> >   loop_04
> > - stripe_05 ("write and verify test on user copy") based on stripe_03
> > - stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
> >   and stripe_04
> > - Added test cases to stress_05 ("run IO and remove device with recover=
y
> >   enabled") for user copy
> > - stress_06 ("run IO and remove device (user copy)") based on stress_01
> >   and stress_03
> > - stress_07 ("run IO and kill ublk server (user copy)") based on
> >   stress_02 and stress_04
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile         |  8 ++++
> >  .../testing/selftests/ublk/test_generic_14.sh | 40 +++++++++++++++++++
> >  tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++++++
> >  tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++++++
> >  tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++++++
> >  .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
> >  .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++++++++++
> >  .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++++++++++
> >  .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++++++
> >  .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++++++
> >  10 files changed, 250 insertions(+)
> >  create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
> >  create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/self=
tests/ublk/Makefile
> > index 770269efe42a..837977b62417 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -19,28 +19,36 @@ TEST_PROGS +=3D test_generic_08.sh
> >  TEST_PROGS +=3D test_generic_09.sh
> >  TEST_PROGS +=3D test_generic_10.sh
> >  TEST_PROGS +=3D test_generic_11.sh
> >  TEST_PROGS +=3D test_generic_12.sh
> >  TEST_PROGS +=3D test_generic_13.sh
> > +TEST_PROGS +=3D test_generic_14.sh
> >
> >  TEST_PROGS +=3D test_null_01.sh
> >  TEST_PROGS +=3D test_null_02.sh
> > +TEST_PROGS +=3D test_null_03.sh
> >  TEST_PROGS +=3D test_loop_01.sh
> >  TEST_PROGS +=3D test_loop_02.sh
> >  TEST_PROGS +=3D test_loop_03.sh
> >  TEST_PROGS +=3D test_loop_04.sh
> >  TEST_PROGS +=3D test_loop_05.sh
> > +TEST_PROGS +=3D test_loop_06.sh
> > +TEST_PROGS +=3D test_loop_07.sh
> >  TEST_PROGS +=3D test_stripe_01.sh
> >  TEST_PROGS +=3D test_stripe_02.sh
> >  TEST_PROGS +=3D test_stripe_03.sh
> >  TEST_PROGS +=3D test_stripe_04.sh
> > +TEST_PROGS +=3D test_stripe_05.sh
> > +TEST_PROGS +=3D test_stripe_06.sh
> >
> >  TEST_PROGS +=3D test_stress_01.sh
> >  TEST_PROGS +=3D test_stress_02.sh
> >  TEST_PROGS +=3D test_stress_03.sh
> >  TEST_PROGS +=3D test_stress_04.sh
> >  TEST_PROGS +=3D test_stress_05.sh
> > +TEST_PROGS +=3D test_stress_06.sh
> > +TEST_PROGS +=3D test_stress_07.sh
> >
> >  TEST_GEN_PROGS_EXTENDED =3D kublk
> >
> >  include ../lib.mk
> >
> > diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/te=
sting/selftests/ublk/test_generic_14.sh
> > new file mode 100755
> > index 000000000000..cd9b44b97c24
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_generic_14.sh
> > @@ -0,0 +1,40 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID=3D"generic_14"
> > +ERR_CODE=3D0
> > +
> > +ublk_run_recover_test()
> > +{
> > +     run_io_and_recover 256M "kill_daemon" "$@"
> > +     ERR_CODE=3D$?
> > +     if [ ${ERR_CODE} -ne 0 ]; then
> > +             echo "$TID failure: $*"
> > +             _show_result $TID $ERR_CODE
> > +     fi
> > +}
> > +
> > +if ! _have_program fio; then
> > +     exit "$UBLK_SKIP_CODE"
> > +fi
> > +
> > +_prep_test "recover" "basic recover function verification (user copy)"
> > +
> > +_create_backfile 0 256M
> > +_create_backfile 1 128M
> > +_create_backfile 2 128M
> > +
> > +ublk_run_recover_test -t null -q 2 -r 1 -u &
> > +ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
> > +ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "$=
{UBLK_BACKFILES[2]}" &
> > +wait
> > +
> > +ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
> > +ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}"=
 &
> > +ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]=
}" "${UBLK_BACKFILES[2]}" &
> > +wait
> > +
> > +_cleanup_test "recover"
> > +_show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testi=
ng/selftests/ublk/test_loop_06.sh
> > new file mode 100755
> > index 000000000000..1d1a8a725502
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_loop_06.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID=3D"loop_06"
> > +ERR_CODE=3D0
> > +
> > +if ! _have_program fio; then
> > +     exit "$UBLK_SKIP_CODE"
> > +fi
> > +
> > +_prep_test "loop" "write and verify over user copy"
> > +
> > +_create_backfile 0 256M
> > +dev_id=3D$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> > +_check_add_dev $TID $?
> > +
> > +# run fio over the ublk disk
> > +_run_fio_verify_io --filename=3D/dev/ublkb"${dev_id}" --size=3D256M
> > +ERR_CODE=3D$?
> > +
> > +_cleanup_test "loop"
> > +
> > +_show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testi=
ng/selftests/ublk/test_loop_07.sh
> > new file mode 100755
> > index 000000000000..493f3fb611a5
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_loop_07.sh
> > @@ -0,0 +1,21 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID=3D"loop_07"
> > +ERR_CODE=3D0
> > +
> > +_prep_test "loop" "mkfs & mount & umount with user copy"
> > +
> > +_create_backfile 0 256M
> > +
> > +dev_id=3D$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> > +_check_add_dev $TID $?
> > +
> > +_mkfs_mount_test /dev/ublkb"${dev_id}"
> > +ERR_CODE=3D$?
> > +
> > +_cleanup_test "loop"
> > +
> > +_show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testi=
ng/selftests/ublk/test_null_03.sh
> > new file mode 100755
> > index 000000000000..0051067b4686
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_null_03.sh
> > @@ -0,0 +1,24 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID=3D"null_03"
> > +ERR_CODE=3D0
> > +
> > +if ! _have_program fio; then
> > +     exit "$UBLK_SKIP_CODE"
> > +fi
> > +
> > +_prep_test "null" "basic IO test with user copy"
> > +
> > +dev_id=3D$(_add_ublk_dev -t null -u)
> > +_check_add_dev $TID $?
> > +
> > +# run fio over the two disks
> > +fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioengine=3Dliba=
io --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>&1
> > +ERR_CODE=3D$?
> > +
> > +_cleanup_test "null"
> > +
> > +_show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/tes=
ting/selftests/ublk/test_stress_05.sh
> > index 09b94c36f2ba..cb8203957d1d 100755
> > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > @@ -78,7 +78,14 @@ if _have_feature "PER_IO_DAEMON"; then
> >       ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks =
-r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
> >       ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r=
 1 -i "$reissue"  &
> >  fi
> >  wait
> >
> > +for reissue in $(seq 0 1); do
> > +     ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> > +     ublk_io_and_remove 256M -t loop -q 4 -u -r 1 -i "$reissue" "${UBL=
K_BACKFILES[1]}" &
> > +     ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> > +     wait
> > +done
>
> I'd suggest to not add new test coverage in old stress tests until defaul=
t
> timeout is overrided, now it is close to default 45 seconds timeout.

Okay, I can just drop the changes in test_stress_05.sh if that sounds
good to you?

Thanks,
Caleb

