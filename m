Return-Path: <linux-kselftest+bounces-47513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60ACB966A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A470302356D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA32D3EDE;
	Fri, 12 Dec 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RvlH1I4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499D26CE33
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558939; cv=none; b=FWEX+JvsNcSlqsqoV0BeQ9Fkmbzc/Y7GvX59QDdX5/j3GzvnqKdVkZfrJF/XV3ajLpuJm7PWj3Buidv6avSG3pZNcW574KfrfzIWDRs/Wl3iG0eargrxPRUyUQA7SKJbhAj5gaOfxwjzo4YPgx3ccXsTW/JV8CnTI4mTbFygaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558939; c=relaxed/simple;
	bh=464KWwNBKNfXPoEHxeXTFpwEqv44+W/SD/IdW4t7oPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUzN+/CNz7mjBNiWwv0vzWvxlNAwx7CggacsNhcEocGhBxjUE/NghPqRypo+CZJt8BM1JND5hAEwOr/N20o6eao1iznnu66dyhoDPb1QqZsTpgC1+V/3RcRRgSm6F3hkjzVW2Zp8/piYSxQNaRmj3I3BYjez3JbR9ruKWO2YePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RvlH1I4j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7baa28f553dso33982b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765558935; x=1766163735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym6jAAZF+CDsp3ilPffvqhNgKf/5Ozjkc/vStK+GCWE=;
        b=RvlH1I4jjO/CPZcHOFGnLOVg1XG/qNL1/MGvHqoabGCMTZAB2X5IFVSaPnEBcJwl3B
         txW+d5r7cEpe+CoWTWjVuUJnkzX8i1AfvJQWSPo2vHPPVtHM0aAsEXbjohLL0FeJcgao
         Q45Ijgju3gX96PGMwr02RzppvTbZ7ur5iDPMr6Pjxa1VdPEE8zuCA4DF4H1ltD0awgzs
         dwQFaeCP8bZwl3aEOHi+cNUhdi9lMpAXfLWH1XYVRwBWmI+BXhlBOmu+7JZVfvGuhMp7
         FX5nMIYy9fy+fcgHvHGIg/l20vlDTk6zlxBih1VwAOSHz0hCGPjsNP4zIFgoBuVtoK6w
         RMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558935; x=1766163735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ym6jAAZF+CDsp3ilPffvqhNgKf/5Ozjkc/vStK+GCWE=;
        b=SArGZCrOv5m2CtvLHK/YF3POM97X8h9EDr/xAad9FESCGRUIRDz5QstZbB3eO8p9um
         FsHQotntE2uWijK1i6aOp8RWMjuz9Pf2TnRBLI/nh2k2KDF3ZsCfB/fXXjSRNcAwZJ65
         WiN0sMpUSdXOI25q4oTauoNPuoI1ZMUvFEEBaBXFa4D+ZohEGLWakvm1cdE1raXezwmO
         dXDPntgf6Bu7vHbhVufvfgvrgJReJfGLtrY2V5acZ5OM+HgVyGOkQm2nRTWsME8CTQeH
         KC7zmKwvR37i7kgQvvw8e+AW7TT2FtrKKdWhwVe1YPDS/33vgQ8uuqo9x8iHoTjc7YpK
         dVVA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1XJkUhFBg/H+q+2JSydsU/CvzyPV2OiTeJhQ0QoRWty3XCEX9OejxZaoKmJ1E8dZS8e7Z0hED4HBVXM/8uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhL+CTVGMVEGR4rHjBw0jT4WNQGEjaNjpuhbw03PZChuAExojX
	NBzisRmizkwNVhtVnrHoHUw94emSaCimvgMvrDGtaZ/RKylxHyrJfwGCVT/i42yJoCC4mnhTVEz
	dejWqZDq0kU1jftNKJ/40g/Z7S3joPg21mpLOhuQTcg==
X-Gm-Gg: AY/fxX61fpQgQh+0aw2DhJ+wH29UYjsj6J3qGrS+xMxZbgP55YJ4GNXKFFzVV1jTgGC
	rmmvaIp29ENaLMLq7h0+Xkut64wrnx4Vv3BV5ySUlESbDpKzHeKi2AYhxG2gOP14GfUO8ro/Nt4
	EliBKj21lAWvQ5cvyvdSIIDAW5/Kb7A8PuxG7zxHTZn5cq3YQCvjsss6G4+Wap48kMA080HacLC
	+qEX8XXBvL1jAtTZif3OZ8ocupr6ewMUjQCaYr4p/uV5Rp1Gin0GkmcNOYgJ3Apq0vqD2Hd
X-Google-Smtp-Source: AGHT+IEXNAQcy8lOTSASaTaFWGmJhQ3gw3rq6GgAdJlPgzPzsLLVyo/P44AaN99wrGW7pUYVIszDLuVADpFmt36Amrs=
X-Received: by 2002:a05:701b:2615:b0:11e:3e9:3e97 with SMTP id
 a92af1059eb24-11f34c3d0f0mr820170c88.6.1765558934233; Fri, 12 Dec 2025
 09:02:14 -0800 (PST)
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
 <aTukkFnbsl5_I0No@fedora> <CADUfDZp3oyFSwLhuAOi24quNFYK2CxLB0dPm5dRiB-AjmHbG=Q@mail.gmail.com>
 <aTv8vpxAapZCc6yq@fedora>
In-Reply-To: <aTv8vpxAapZCc6yq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 12 Dec 2025 09:02:02 -0800
X-Gm-Features: AQt7F2q9YuZR5xEC19OSDODqghw2-7p14e93OGFRxBgg0DBHhlj-wyIl0izhhVI
Message-ID: <CADUfDZp=J1qnjdcm7oF-7v1majbmr9iCKZnp870HHj7L0t_tFQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 3:30=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 09:21:37PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 9:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Dec 11, 2025 at 08:59:00PM -0800, Caleb Sander Mateos wrote:
> > > > On Thu, Dec 11, 2025 at 6:38=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wro=
te:
> > > > > > On Thu, Dec 11, 2025 at 3:05=E2=80=AFPM Ming Lei <ming.lei@redh=
at.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos=
 wrote:
> > > > > > > > On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@=
redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Ma=
teos wrote:
> > > > > > > > > > The kublk mock ublk server allows multiple data copy mo=
de arguments to
> > > > > > > > > > be passed on the command line (--zero_copy, --get_data,=
 and --auto_zc).
> > > > > > > > > > The ublk device will be created with all the requested =
feature flags,
> > > > > > > > > > however kublk will only use one of the modes to interac=
t with request
> > > > > > > > > > data (arbitrarily preferring auto_zc over zero_copy ove=
r get_data). To
> > > > > > > > > > clarify the intent of the test, don't allow multiple da=
ta copy modes to
> > > > > > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy,=
 as it's an
> > > > > > > > > > independent feature. Don't require zero_copy for auto_z=
c_fallback, as
> > > > > > > > > > only auto_zc is needed. Fix the test cases passing mult=
iple data copy
> > > > > > > > > > mode arguments.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage=
.com>
> > > > > > > > > > ---
> > > > > > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 +++=
+++++++++-------
> > > > > > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++-=
-
> > > > > > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 +++=
+-----
> > > > > > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/too=
ls/testing/selftests/ublk/kublk.c
> > > > > > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[]=
)
> > > > > > > > > >                       break;
> > > > > > > > > >               case 'd':
> > > > > > > > > >                       ctx.queue_depth =3D strtol(optarg=
, NULL, 10);
> > > > > > > > > >                       break;
> > > > > > > > > >               case 'z':
> > > > > > > > > > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZER=
O_COPY | UBLK_F_USER_COPY;
> > > > > > > > > > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZER=
O_COPY;
> > > > > > > > > >                       break;
> > > > > > > > > >               case 'r':
> > > > > > > > > >                       value =3D strtol(optarg, NULL, 10=
);
> > > > > > > > > >                       if (value)
> > > > > > > > > >                               ctx.flags |=3D UBLK_F_USE=
R_RECOVERY;
> > > > > > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[]=
)
> > > > > > > > > >                       optind +=3D 1;
> > > > > > > > > >                       break;
> > > > > > > > > >               }
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F=
_SUPPORT_ZERO_COPY */
> > > > > > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY=
))) {
> > > > > > > > > > -             ublk_err("%s: auto_zc_fallback is set but=
 neither "
> > > > > > > > > > -                             "F_AUTO_BUF_REG nor F_SUP=
PORT_ZERO_COPY is enabled\n",
> > > > > > > > > > -                                     __func__);
> > > > > > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_=
AUTO_BUF_REG)) {
> > > > > > > > > > +             ublk_err("%s: auto_zc_fallback is set but=
 F_AUTO_BUF_REG is disabled\n",
> > > > > > > > > > +                      __func__);
> > > > > > > > > > +             return -EINVAL;
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > > > > > +             fprintf(stderr, "too many data copy modes=
 specified\n");
> > > > > > > > > >               return -EINVAL;
> > > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > Actually most of them are allowed to co-exist, such as -z=
/--auto_zc/-u.
> > > > > > > >
> > > > > > > > Yes, I know the ublk driver allows multiple copy mode flags=
 to be set
> > > > > > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the ot=
hers are
> > > > > > > > set). However, kublk will only actually use one of the mode=
s. For
> > > > > > > > example, --get_data --zero_copy will use zero copy for the =
data
> > > > > > > > transfer, not get data. And --zero_copy --auto_zc will only=
 use auto
> > > > > > > > buffer registration. So I think it's confusing to allow mul=
tiple of
> > > > > > > > these parameters to be passed to kublk. Or do you think the=
re is value
> > > > > > > > in testing ublk device creation with multiple data copy mod=
e flags
> > > > > > > > set, but only one of the modes actually used?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >       i =3D optind;
> > > > > > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES)=
 {
> > > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_=
09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > > > > > >  fi
> > > > > > > > > >
> > > > > > > > > >  _prep_test "null" "basic IO test"
> > > > > > > > > >
> > > > > > > > > > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_z=
c_fallback)
> > > > > > > > > > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_f=
allback)
> > > > > > > > > >  _check_add_dev $TID $?
> > > > > > > > > >
> > > > > > > > > >  # run fio over the two disks
> > > > > > > > > >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" -=
-ioengine=3Dlibaio --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/nul=
l 2>&1
> > > > > > > > > >  ERR_CODE=3D$?
> > > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_0=
3.sh b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > > @@ -36,19 +36,19 @@ wait
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "$=
{UBLK_BACKFILES[0]}" &
> > > > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc =
"${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc -=
-auto_zc_fallback &
> > > > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --au=
to_zc_fallback &
> > > > > > > > > >       wait
> > > > > > > > > >  fi
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nt=
hreads 8 --per_io_tasks &
> > > > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --=
nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc =
--nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc -=
-auto_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --au=
to_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > > >       wait
> > > > > > > > > >  fi
> > > > > > > > > >
> > > > > > > > > >  _cleanup_test "stress"
> > > > > > > > > >  _show_result $TID $ERR_CODE
> > > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_0=
4.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > > @@ -35,11 +35,11 @@ wait
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc=
 &
> > > > > > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_=
zc "${UBLK_BACKFILES[0]}" &
> > > > > > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --aut=
o_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto=
_zc --auto_zc_fallback &
> > > > > > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc=
 --auto_zc_fallback &
> > > > > > > > > >       wait
> > > > > > > > > >  fi
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc=
 --nthreads 8 --per_io_tasks &
> > > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_0=
5.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > > > > > >       wait
> > > > > > > > > >  done
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z =
-r 1 -i "$reissue" &
> > > > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -=
z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r =
1 -i "$reissue" &
> > > > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -=
r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > >               wait
> > > > > > > > > >       done
> > > > > > > > > >  fi
> > > > > > > > > >
> > > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --a=
uto_zc -r 1 -i "$reissue" &
> > > > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -=
-auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z =
--auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto=
_zc -r 1 -i "$reissue" &
> > > > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --au=
to_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto=
_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > > >
> > > > > > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > > > > > >
> > > > > > > > Ah, right, I forgot that the fallback path relies on normal=
 zero copy
> > > > > > > > buffer registration. I guess we are missing coverage of tha=
t, then,
> > > > > > > > since the tests still passed with --zero_copy disabled.
> > > > > > >
> > > > > > > Looks one regression from commit 0a9beafa7c63 ("ublk: refacto=
r auto buffer register in ublk_dispatch_req()")
> > > > > >
> > > > > > Is there a particular issue you see in that commit? I think the=
 issue
> > > > >
> > > > > Looks I overlooked.
> > > > >
> > > > > > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc=
 but zc
> > > > > > isn't enabled, the null ublk server will just complete the I/O
> > > > > > immediately. And --auto_zc_fallback isn't supported by any of t=
he
> > > > > > other ublk servers.
> > > > > >
> > > > > > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> > > > > >         queued =3D null_queue_auto_zc_io(t, q, tag);
> > > > > > else if (zc)
> > > > > >         queued =3D null_queue_zc_io(t, q, tag);
> > > > > > else {
> > > > > >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> > > > > >         return 0;
> > > > > > }
> > > > > >
> > > > > > So it looks to me to just be an issue with my kublk change.
> > > > >
> > > > > But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallb=
ack code
> > > > > path isn't examined actually.
> > > >
> > > > How is it broken?
> > >
> > > typeof(q->flags) is u64, but the return type is i32, so it is overflo=
wed.
> >
> > Ah, good catch. Yeah, these ublk_queue flag query functions should
> > probably return bool. Are you going to send out a patch?
>
> I guess you may have to send V3 for fixing patch 4, I appreciate you may =
include the
> following fix in your V3, otherwise it may conflict with the added ublk_q=
ueue_use_user_copy().

Sure, will do.

Thanks,
Caleb

>
>
> From 62da81c7a9883dc251cc0daa2a3081226abc5da1 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Fri, 12 Dec 2025 11:23:56 +0000
> Subject: [PATCH] selftests: ublk: fix overflow in
>  ublk_queue_auto_zc_fallback()
>
> The functions ublk_queue_use_zc(), ublk_queue_use_auto_zc(), and
> ublk_queue_auto_zc_fallback() were returning int, but performing
> bitwise AND on q->flags which is __u64.
>
> When a flag bit is set in the upper 32 bits (beyond INT_MAX), the
> result of the bitwise AND operation could overflow when cast to int,
> leading to incorrect boolean evaluation.
>
> For example, if UBLKS_Q_AUTO_BUF_REG_FALLBACK is 0x8000000000000000:
>   - (u64)flags & 0x8000000000000000 =3D 0x8000000000000000
>   - Cast to int: undefined behavior / incorrect value
>   - Used in if(): may evaluate incorrectly
>
> Fix by:
> 1. Changing return type from int to bool for semantic correctness
> 2. Using !! to explicitly convert to boolean (0 or 1)
>
> This ensures the functions return proper boolean values regardless
> of which bit position the flags occupy in the 64-bit field.
>
> Fixes: c3a6d48f86da ("selftests: ublk: remove ublk queue self-defined fla=
gs")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/kublk.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftes=
ts/ublk/kublk.h
> index fda72e19ef09..8a83b90ec603 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -396,19 +396,19 @@ static inline int ublk_completed_tgt_io(struct ublk=
_thread *t,
>         return --io->tgt_ios =3D=3D 0;
>  }
>
> -static inline int ublk_queue_use_zc(const struct ublk_queue *q)
> +static inline bool ublk_queue_use_zc(const struct ublk_queue *q)
>  {
> -       return q->flags & UBLK_F_SUPPORT_ZERO_COPY;
> +       return !!(q->flags & UBLK_F_SUPPORT_ZERO_COPY);
>  }
>
> -static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
> +static inline bool ublk_queue_use_auto_zc(const struct ublk_queue *q)
>  {
> -       return q->flags & UBLK_F_AUTO_BUF_REG;
> +       return !!(q->flags & UBLK_F_AUTO_BUF_REG);
>  }
>
> -static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q=
)
> +static inline bool ublk_queue_auto_zc_fallback(const struct ublk_queue *=
q)
>  {
> -       return q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK;
> +       return !!(q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK);
>  }
>
>  static inline bool ublk_queue_use_user_copy(const struct ublk_queue *q)
> --
> 2.47.1
>
>
>
>
> Thanks,
> Ming
>

