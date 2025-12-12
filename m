Return-Path: <linux-kselftest+bounces-47508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F089ECB8B66
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EF483011596
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448231D38B;
	Fri, 12 Dec 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOYvQ7fa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EE31D381
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765539023; cv=none; b=ihCMpbG56XahWQOh5rK7P/aH8LxR96YtNVS1r9TeoNx27fa1kukgJM972hFATWk1jUoYlXQGImC0VGz6Wvt96FyCB7o7qr5Gok4EH4FQrif6zM2ITZZAnu2aWwhhyrHaf4x2i+rqNEmFSs24bE5z4y28vEIBk0Gi5/3IkN0JAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765539023; c=relaxed/simple;
	bh=HxErTQUo0ubd0fVuuTkKdhL3mqmsL0Zs2l5tfirHv4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijdfRLDbezH3WttVp3wqAbGhcRVKOneRSr0xLWfflC1+CJkLdzSI44UFeYy1gH+Xf3wST42Ls7s7kPRqSjkottawjVKLik1xU7cvs/lIp4aUIFlVGub1IHu7B4Jg8PTmwqL1LJ0u0w73SKSfBaO9TcCds0nPOBf/1PuYoyHeez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOYvQ7fa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765539019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shRrGScj/xebqUYoFmsFMzSX+XWQRhfVfXbkA7/Ebck=;
	b=WOYvQ7fatHLHWfBYhbcmvqtsckA3AgZVx6GWsiiiKWjp4SSTGGOsnkUsu1tDR9Qn3YC1V/
	46oWSaHYXGl1ve7KMunrc6Os9G2zRlckDkS/XXt3IP218++SyxNxOtqhNB6rqSTrCqdYRG
	s6pWtvPWoXo+9ZZKlJQN5BlwWnYPxFI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ni1bV7TgPaCPiaJepCvZ-Q-1; Fri,
 12 Dec 2025 06:30:15 -0500
X-MC-Unique: ni1bV7TgPaCPiaJepCvZ-Q-1
X-Mimecast-MFC-AGG-ID: ni1bV7TgPaCPiaJepCvZ-Q_1765539014
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDCE1956058;
	Fri, 12 Dec 2025 11:30:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5788C180044F;
	Fri, 12 Dec 2025 11:30:10 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:30:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTv8vpxAapZCc6yq@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com>
 <aTqKLSbpQN26XLNq@fedora>
 <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com>
 <aTtOGmEeYBZLozO8@fedora>
 <CADUfDZpzZ16vsWhMm6-tYfdj7EBBE_iUaLTmhyiZeR1CxT5d_g@mail.gmail.com>
 <aTuAGQOurmAfbJc7@fedora>
 <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
 <aTukkFnbsl5_I0No@fedora>
 <CADUfDZp3oyFSwLhuAOi24quNFYK2CxLB0dPm5dRiB-AjmHbG=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp3oyFSwLhuAOi24quNFYK2CxLB0dPm5dRiB-AjmHbG=Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Dec 11, 2025 at 09:21:37PM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 9:14 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Dec 11, 2025 at 08:59:00PM -0800, Caleb Sander Mateos wrote:
> > > On Thu, Dec 11, 2025 at 6:38 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wrote:
> > > > > On Thu, Dec 11, 2025 at 3:05 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wrote:
> > > > > > > On Thu, Dec 11, 2025 at 1:09 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wrote:
> > > > > > > > > The kublk mock ublk server allows multiple data copy mode arguments to
> > > > > > > > > be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> > > > > > > > > The ublk device will be created with all the requested feature flags,
> > > > > > > > > however kublk will only use one of the modes to interact with request
> > > > > > > > > data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> > > > > > > > > clarify the intent of the test, don't allow multiple data copy modes to
> > > > > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
> > > > > > > > > independent feature. Don't require zero_copy for auto_zc_fallback, as
> > > > > > > > > only auto_zc is needed. Fix the test cases passing multiple data copy
> > > > > > > > > mode arguments.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > > > > ---
> > > > > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++-------
> > > > > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > > > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
> > > > > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> > > > > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > > > > > > >                       break;
> > > > > > > > >               case 'd':
> > > > > > > > >                       ctx.queue_depth = strtol(optarg, NULL, 10);
> > > > > > > > >                       break;
> > > > > > > > >               case 'z':
> > > > > > > > > -                     ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
> > > > > > > > > +                     ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY;
> > > > > > > > >                       break;
> > > > > > > > >               case 'r':
> > > > > > > > >                       value = strtol(optarg, NULL, 10);
> > > > > > > > >                       if (value)
> > > > > > > > >                               ctx.flags |= UBLK_F_USER_RECOVERY;
> > > > > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > > > > > > >                       optind += 1;
> > > > > > > > >                       break;
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
> > > > > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> > > > > > > > > -             ublk_err("%s: auto_zc_fallback is set but neither "
> > > > > > > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
> > > > > > > > > -                                     __func__);
> > > > > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG)) {
> > > > > > > > > +             ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_REG is disabled\n",
> > > > > > > > > +                      __func__);
> > > > > > > > > +             return -EINVAL;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > > > > +             fprintf(stderr, "too many data copy modes specified\n");
> > > > > > > > >               return -EINVAL;
> > > > > > > > >       }
> > > > > > > >
> > > > > > > > Actually most of them are allowed to co-exist, such as -z/--auto_zc/-u.
> > > > > > >
> > > > > > > Yes, I know the ublk driver allows multiple copy mode flags to be set
> > > > > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the others are
> > > > > > > set). However, kublk will only actually use one of the modes. For
> > > > > > > example, --get_data --zero_copy will use zero copy for the data
> > > > > > > transfer, not get data. And --zero_copy --auto_zc will only use auto
> > > > > > > buffer registration. So I think it's confusing to allow multiple of
> > > > > > > these parameters to be passed to kublk. Or do you think there is value
> > > > > > > in testing ublk device creation with multiple data copy mode flags
> > > > > > > set, but only one of the modes actually used?
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >       i = optind;
> > > > > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > > > > >  fi
> > > > > > > > >
> > > > > > > > >  _prep_test "null" "basic IO test"
> > > > > > > > >
> > > > > > > > > -dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
> > > > > > > > > +dev_id=$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
> > > > > > > > >  _check_add_dev $TID $?
> > > > > > > > >
> > > > > > > > >  # run fio over the two disks
> > > > > > > > >  fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
> > > > > > > > >  ERR_CODE=$?
> > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > > @@ -36,19 +36,19 @@ wait
> > > > > > > > >
> > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
> > > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> > > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback &
> > > > > > > > >       wait
> > > > > > > > >  fi
> > > > > > > > >
> > > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> > > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > >       wait
> > > > > > > > >  fi
> > > > > > > > >
> > > > > > > > >  _cleanup_test "stress"
> > > > > > > > >  _show_result $TID $ERR_CODE
> > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > > @@ -35,11 +35,11 @@ wait
> > > > > > > > >
> > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > > > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
> > > > > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> > > > > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback &
> > > > > > > > >       wait
> > > > > > > > >  fi
> > > > > > > > >
> > > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> > > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > > > > >       wait
> > > > > > > > >  done
> > > > > > > > >
> > > > > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
> > > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
> > > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > >               wait
> > > > > > > > >       done
> > > > > > > > >  fi
> > > > > > > > >
> > > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
> > > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
> > > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > >
> > > > > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > > > > >
> > > > > > > Ah, right, I forgot that the fallback path relies on normal zero copy
> > > > > > > buffer registration. I guess we are missing coverage of that, then,
> > > > > > > since the tests still passed with --zero_copy disabled.
> > > > > >
> > > > > > Looks one regression from commit 0a9beafa7c63 ("ublk: refactor auto buffer register in ublk_dispatch_req()")
> > > > >
> > > > > Is there a particular issue you see in that commit? I think the issue
> > > >
> > > > Looks I overlooked.
> > > >
> > > > > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but zc
> > > > > isn't enabled, the null ublk server will just complete the I/O
> > > > > immediately. And --auto_zc_fallback isn't supported by any of the
> > > > > other ublk servers.
> > > > >
> > > > > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> > > > >         queued = null_queue_auto_zc_io(t, q, tag);
> > > > > else if (zc)
> > > > >         queued = null_queue_zc_io(t, q, tag);
> > > > > else {
> > > > >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > So it looks to me to just be an issue with my kublk change.
> > > >
> > > > But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallback code
> > > > path isn't examined actually.
> > >
> > > How is it broken?
> >
> > typeof(q->flags) is u64, but the return type is i32, so it is overflowed.
> 
> Ah, good catch. Yeah, these ublk_queue flag query functions should
> probably return bool. Are you going to send out a patch?

I guess you may have to send V3 for fixing patch 4, I appreciate you may include the
following fix in your V3, otherwise it may conflict with the added ublk_queue_use_user_copy().


From 62da81c7a9883dc251cc0daa2a3081226abc5da1 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 12 Dec 2025 11:23:56 +0000
Subject: [PATCH] selftests: ublk: fix overflow in
 ublk_queue_auto_zc_fallback()

The functions ublk_queue_use_zc(), ublk_queue_use_auto_zc(), and
ublk_queue_auto_zc_fallback() were returning int, but performing
bitwise AND on q->flags which is __u64.

When a flag bit is set in the upper 32 bits (beyond INT_MAX), the
result of the bitwise AND operation could overflow when cast to int,
leading to incorrect boolean evaluation.

For example, if UBLKS_Q_AUTO_BUF_REG_FALLBACK is 0x8000000000000000:
  - (u64)flags & 0x8000000000000000 = 0x8000000000000000
  - Cast to int: undefined behavior / incorrect value
  - Used in if(): may evaluate incorrectly

Fix by:
1. Changing return type from int to bool for semantic correctness
2. Using !! to explicitly convert to boolean (0 or 1)

This ensures the functions return proper boolean values regardless
of which bit position the flags occupy in the 64-bit field.

Fixes: c3a6d48f86da ("selftests: ublk: remove ublk queue self-defined flags")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index fda72e19ef09..8a83b90ec603 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -396,19 +396,19 @@ static inline int ublk_completed_tgt_io(struct ublk_thread *t,
 	return --io->tgt_ios == 0;
 }
 
-static inline int ublk_queue_use_zc(const struct ublk_queue *q)
+static inline bool ublk_queue_use_zc(const struct ublk_queue *q)
 {
-	return q->flags & UBLK_F_SUPPORT_ZERO_COPY;
+	return !!(q->flags & UBLK_F_SUPPORT_ZERO_COPY);
 }
 
-static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
+static inline bool ublk_queue_use_auto_zc(const struct ublk_queue *q)
 {
-	return q->flags & UBLK_F_AUTO_BUF_REG;
+	return !!(q->flags & UBLK_F_AUTO_BUF_REG);
 }
 
-static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
+static inline bool ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
 {
-	return q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK;
+	return !!(q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK);
 }
 
 static inline bool ublk_queue_use_user_copy(const struct ublk_queue *q)
-- 
2.47.1




Thanks,
Ming


