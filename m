Return-Path: <linux-kselftest+bounces-47463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F707CB79F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A853032AAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A528850E;
	Fri, 12 Dec 2025 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QeEaFZeG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D820E00B
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505229; cv=none; b=YggZ3JjZ+BStVT4/K3GHjEgOo7Rh9YBgLeh0t7Fhc/VU7NsOn4V/YFyfuVkWtM9ca15NJ8OCVac57QrlFjJ/AhD+5RU6bLhixquDtS5EbSCdlOdLs+g/J5cLTbJLPwqRQPsvO4OonCD4lMq3Lis3l3IB+jJGgY4cRDDPmpWDoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505229; c=relaxed/simple;
	bh=Xg6Bg1tijGMJKkMlYTloVpchtjGMtzHq4gPBwCRSrhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXaikTrBa8ckR5MpNdpDCJ+7bufnp/3zugUPvSJm5XAQkbJCn9X/mp98GzyU5LvKxyRzFElIGjNhW1UqaEzULDe7c5p7tHpbXodU6F1a2aFywns2H9JIBf8izo2AqtGcDxcGX57OwKHPZ305/J9J+zWLG0wvgkbb9VFJ2lOTYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QeEaFZeG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ea4c2933so889065ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 18:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765505224; x=1766110024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NmU0hq/0XF2uCs/LWIOasykeL5nY7LRRU3b2g+YUuI=;
        b=QeEaFZeG2JPLfxw46QzcWDH1MnBnOwvG4rnSdswytqd9neno6KQ3oV/HFisLHAW2zt
         CBe40Le97coaHqEKXeMoSDE9MR9p9IXpqtsglUvY0z8rd9OzGv1isuYBoFyGYdxZZm/m
         xxd2/JmRP6cM76CeSWRYJE8+6wXSMRHdDhx2XF1BaIESqG/fUu5PMuyVfbEXfmat9fDb
         Dnhcgr/UsNXe7zsBzrmVX2EJHmWWW4SoJJPc4/2nkPZh8DF7SReL5u4iiVHMt+0vK7iq
         a1EslJVLLBSIDEJ/c6lHnowPG4kTE4GLe5Mn5LejOJZALnnkiMPO9ci9x6caVx+6gkU3
         Bg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505224; x=1766110024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NmU0hq/0XF2uCs/LWIOasykeL5nY7LRRU3b2g+YUuI=;
        b=GxKHwLHTNtpqO3ymH+3LoPYdGqtIHUFBPOFX3j9CZh4YssHB6RbZvNyzaaUp1gFdDN
         WCKv4/xeSfsPYNwHC0YQ6i1m/eU0+DIofi7SqACmMoogO1In+w6Yj9K24wZKPMatJvwn
         5ERXfu/ipQ924A5eWrLoMv7uiSQj7U1AIQwX12yMlyvWfV5zfRVcML6lI4VMiB/WesJp
         mw49F1KBFdQik6DohTiNuWEGjjSVQH2mFjbQ4E48etZZ7Ab7bo/3HwZJHbWpSUxBby0b
         kAm46pjkOH7e1KLdC0DePTMZ6fdJGVT6gY0VgkxaEe5rEvm4T9TYyygpid/lTyrn02VN
         wGJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Zrng5fiwUlHeR9rXZ9uGPSYxuAUq0n/YvucwYfnb4vrCXu9xHXspSdcYxVkpUx0Vxuxzj5YYK4WbFGgKjOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFy8ir4oUHoy5rjpG33zwduShdQbcUtxXl6MlehOcJE0jlKoG
	mcE3NW5Yb7knh3ZF2W/MzbN0yvW1bRtEZlvUHMaQusZVjpyEYfoIgqLtbAfuDJTeDUxqhkErpj8
	4sgFx5nEXyDdprCAJheUdPtKuyjDFV8g/FLgPlGHJbQ==
X-Gm-Gg: AY/fxX7voia8X8992nYghraOUMlsPXR75xo2uz4lbwONMD/ePkFN8ghFvM5sxPiDUsU
	EGPG76tqxGubM29nBJN1xYx19VcnedIHsjF9d76wHticuhkwsZx27jXb4was0pVNgPkEkgms6Mc
	d12gpCbEr5NHFsDeAk53Os6jkKDt2V6K6YGodySwLWp1ByIpIX5pKWxD3U1PdZc0/NuHEQ5OaGz
	IdBlFmEfgRLcbYyq0phUMO3slQ4s/QmMrVh7IdRrIeMfMvF552uK+jEWYRgVG5QhjCLG/Y1lGWI
	kPnE+3E=
X-Google-Smtp-Source: AGHT+IH5cKGMFyYlSmHE/xkt8ih+6WEXHoOq4B5+ghUK0Gb78U+AIuai0rPqovbUd8m2VjS6bN1g9JWzPZC/41wHSLk=
X-Received: by 2002:a05:7022:b92:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11f3486364fmr285043c88.0.1765505223349; Thu, 11 Dec 2025
 18:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com> <aTqKLSbpQN26XLNq@fedora>
 <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com> <aTtOGmEeYBZLozO8@fedora>
In-Reply-To: <aTtOGmEeYBZLozO8@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 18:06:51 -0800
X-Gm-Features: AQt7F2pIO_qiv_NdO3mmxm1RsGcKFok9cL4Q2LY-yzpZrILVu0Irzcp4iud6RJI
Message-ID: <CADUfDZpzZ16vsWhMm6-tYfdj7EBBE_iUaLTmhyiZeR1CxT5d_g@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 3:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wrote:
> > > > The kublk mock ublk server allows multiple data copy mode arguments=
 to
> > > > be passed on the command line (--zero_copy, --get_data, and --auto_=
zc).
> > > > The ublk device will be created with all the requested feature flag=
s,
> > > > however kublk will only use one of the modes to interact with reque=
st
> > > > data (arbitrarily preferring auto_zc over zero_copy over get_data).=
 To
> > > > clarify the intent of the test, don't allow multiple data copy mode=
s to
> > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
> > > > independent feature. Don't require zero_copy for auto_zc_fallback, =
as
> > > > only auto_zc is needed. Fix the test cases passing multiple data co=
py
> > > > mode arguments.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++---=
----
> > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
> > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/s=
elftests/ublk/kublk.c
> > > > index f8fa102a627f..1765c4806523 100644
> > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > >                       break;
> > > >               case 'd':
> > > >                       ctx.queue_depth =3D strtol(optarg, NULL, 10);
> > > >                       break;
> > > >               case 'z':
> > > > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY | UBL=
K_F_USER_COPY;
> > > > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY;
> > > >                       break;
> > > >               case 'r':
> > > >                       value =3D strtol(optarg, NULL, 10);
> > > >                       if (value)
> > > >                               ctx.flags |=3D UBLK_F_USER_RECOVERY;
> > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > >                       optind +=3D 1;
> > > >                       break;
> > > >               }
> > > >       }
> > > >
> > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZER=
O_COPY */
> > > > -     if (ctx.auto_zc_fallback &&
> > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> > > > -             ublk_err("%s: auto_zc_fallback is set but neither "
> > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT_ZERO_CO=
PY is enabled\n",
> > > > -                                     __func__);
> > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG=
)) {
> > > > +             ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_=
REG is disabled\n",
> > > > +                      __func__);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > +             fprintf(stderr, "too many data copy modes specified\n=
");
> > > >               return -EINVAL;
> > > >       }
> > >
> > > Actually most of them are allowed to co-exist, such as -z/--auto_zc/-=
u.
> >
> > Yes, I know the ublk driver allows multiple copy mode flags to be set
> > (though it will clear UBLK_F_NEED_GET_DATA if any of the others are
> > set). However, kublk will only actually use one of the modes. For
> > example, --get_data --zero_copy will use zero copy for the data
> > transfer, not get data. And --zero_copy --auto_zc will only use auto
> > buffer registration. So I think it's confusing to allow multiple of
> > these parameters to be passed to kublk. Or do you think there is value
> > in testing ublk device creation with multiple data copy mode flags
> > set, but only one of the modes actually used?
> >
> > >
> > > >
> > > >       i =3D optind;
> > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tool=
s/testing/selftests/ublk/test_generic_09.sh
> > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > >       exit "$UBLK_SKIP_CODE"
> > > >  fi
> > > >
> > > >  _prep_test "null" "basic IO test"
> > > >
> > > > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
> > > > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
> > > >  _check_add_dev $TID $?
> > > >
> > > >  # run fio over the two disks
> > > >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioengine=3D=
libaio --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>&1
> > > >  ERR_CODE=3D$?
> > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools=
/testing/selftests/ublk/test_stress_03.sh
> > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > @@ -36,19 +36,19 @@ wait
> > > >
> > > >  if _have_feature "AUTO_BUF_REG"; then
> > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFI=
LES[0]}" &
> > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACK=
FILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fal=
lback &
> > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallba=
ck &
> > > >       wait
> > > >  fi
> > > >
> > > >  if _have_feature "PER_IO_DAEMON"; then
> > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --p=
er_io_tasks &
> > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 -=
-per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8=
 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fal=
lback --nthreads 8 --per_io_tasks &
> > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallba=
ck --nthreads 8 --per_io_tasks &
> > > >       wait
> > > >  fi
> > > >
> > > >  _cleanup_test "stress"
> > > >  _show_result $TID $ERR_CODE
> > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools=
/testing/selftests/ublk/test_stress_04.sh
> > > > index c7220723b537..6e165a1f90b4 100755
> > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > @@ -35,11 +35,11 @@ wait
> > > >
> > > >  if _have_feature "AUTO_BUF_REG"; then
> > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_B=
ACKFILES[0]}" &
> > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ub=
lk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_z=
c_fallback &
> > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_f=
allback &
> > > >       wait
> > > >  fi
> > > >
> > > >  if _have_feature "PER_IO_DAEMON"; then
> > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads =
8 --per_io_tasks &
> > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools=
/testing/selftests/ublk/test_stress_05.sh
> > > > index 274295061042..09b94c36f2ba 100755
> > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > >       wait
> > > >  done
> > > >
> > > >  if _have_feature "ZERO_COPY"; then
> > > >       for reissue in $(seq 0 1); do
> > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$re=
issue" &
> > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$=
reissue" "${UBLK_BACKFILES[1]}" &
> > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reiss=
ue" &
> > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$rei=
ssue" "${UBLK_BACKFILES[1]}" &
> > > >               wait
> > > >       done
> > > >  fi
> > > >
> > > >  if _have_feature "AUTO_BUF_REG"; then
> > > >       for reissue in $(seq 0 1); do
> > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 =
-i "$reissue" &
> > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r =
1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --=
auto_zc_fallback -r 1 -i "$reissue" &
> > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i =
"$reissue" &
> > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -=
i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_z=
c_fallback -r 1 -i "$reissue" &
> > >
> > > --auto_zc_fallback requires both -z and --auto_zc.
> >
> > Ah, right, I forgot that the fallback path relies on normal zero copy
> > buffer registration. I guess we are missing coverage of that, then,
> > since the tests still passed with --zero_copy disabled.
>
> Looks one regression from commit 0a9beafa7c63 ("ublk: refactor auto buffe=
r register in ublk_dispatch_req()")

Is there a particular issue you see in that commit? I think the issue
is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but zc
isn't enabled, the null ublk server will just complete the I/O
immediately. And --auto_zc_fallback isn't supported by any of the
other ublk servers.

if (auto_zc && !ublk_io_auto_zc_fallback(iod))
        queued =3D null_queue_auto_zc_io(t, q, tag);
else if (zc)
        queued =3D null_queue_zc_io(t, q, tag);
else {
        ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
        return 0;
}

So it looks to me to just be an issue with my kublk change.

Thanks,
Caleb

