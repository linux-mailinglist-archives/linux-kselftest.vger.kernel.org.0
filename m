Return-Path: <linux-kselftest+bounces-47480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28449CB7E84
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7724530433FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262930DECB;
	Fri, 12 Dec 2025 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHET7gqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA330E0CB
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516460; cv=none; b=Chki66PeiK7eu9WNy3nuIsVaL7hkDnrdEeC0PajGeC+IVbeSNd9syiBWhWGCjzYGU2ChhcnMXgHJP8Xox/UUAlLKmSWahKt0lnwc4o4EcwTaOfhWLuT/lYU9aQd1kQpvG/9d6R7g2fdrtRXYdapLP2r1xahi4nsC8hjZ3lVZVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516460; c=relaxed/simple;
	bh=oozfKk78jL4/B//YdtjgpeFurYyUykBA/+RYuo4AlKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEuqnt1YBm3QG78gJTUZ1Cm6LUmlv5V5zOHFhGwj90Gk1+nP+EsYb9aXV05QNS4OIiiM+aMMUg+3gppUDa7Dq3xpZe8c8zVXp7apUF1jq4fUFc9+5Q4Ap+/meCPOPiXbmQ4gtMX5LT4CjW+6mCBF6oY9mL7ISIN1iBCOXqImNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHET7gqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765516455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqxweQIYYG/1ykvY627v2zLoo0tpBIH30PWEy5Jx1kY=;
	b=LHET7gqK6n1UsTBNJA47oTK96v8C8+aaHz4N+1TF9O5tbojnsL0hO+P5BbbYfL6DoG5R5N
	3hjBRybqywECg/NbrBF09ovTYPXBEkJZklA8xc8Db6iMMkPqJDeEL/Ydm0btzP5fH79sLS
	yRfjbNVx/5qgxFFj/ikzA6DFFxQy+mU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-l2vVuZCLPFe_c4PvNT0xOg-1; Fri,
 12 Dec 2025 00:14:12 -0500
X-MC-Unique: l2vVuZCLPFe_c4PvNT0xOg-1
X-Mimecast-MFC-AGG-ID: l2vVuZCLPFe_c4PvNT0xOg_1765516451
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D18991955F34;
	Fri, 12 Dec 2025 05:14:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743111953984;
	Fri, 12 Dec 2025 05:14:04 +0000 (UTC)
Date: Fri, 12 Dec 2025 13:13:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTukkFnbsl5_I0No@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com>
 <aTqKLSbpQN26XLNq@fedora>
 <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com>
 <aTtOGmEeYBZLozO8@fedora>
 <CADUfDZpzZ16vsWhMm6-tYfdj7EBBE_iUaLTmhyiZeR1CxT5d_g@mail.gmail.com>
 <aTuAGQOurmAfbJc7@fedora>
 <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 08:59:00PM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 6:38 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wrote:
> > > On Thu, Dec 11, 2025 at 3:05 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wrote:
> > > > > On Thu, Dec 11, 2025 at 1:09 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wrote:
> > > > > > > The kublk mock ublk server allows multiple data copy mode arguments to
> > > > > > > be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> > > > > > > The ublk device will be created with all the requested feature flags,
> > > > > > > however kublk will only use one of the modes to interact with request
> > > > > > > data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> > > > > > > clarify the intent of the test, don't allow multiple data copy modes to
> > > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
> > > > > > > independent feature. Don't require zero_copy for auto_zc_fallback, as
> > > > > > > only auto_zc is needed. Fix the test cases passing multiple data copy
> > > > > > > mode arguments.
> > > > > > >
> > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > > ---
> > > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++-------
> > > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
> > > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> > > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > > > > >                       break;
> > > > > > >               case 'd':
> > > > > > >                       ctx.queue_depth = strtol(optarg, NULL, 10);
> > > > > > >                       break;
> > > > > > >               case 'z':
> > > > > > > -                     ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
> > > > > > > +                     ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY;
> > > > > > >                       break;
> > > > > > >               case 'r':
> > > > > > >                       value = strtol(optarg, NULL, 10);
> > > > > > >                       if (value)
> > > > > > >                               ctx.flags |= UBLK_F_USER_RECOVERY;
> > > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > > > > >                       optind += 1;
> > > > > > >                       break;
> > > > > > >               }
> > > > > > >       }
> > > > > > >
> > > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
> > > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> > > > > > > -             ublk_err("%s: auto_zc_fallback is set but neither "
> > > > > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
> > > > > > > -                                     __func__);
> > > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG)) {
> > > > > > > +             ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_REG is disabled\n",
> > > > > > > +                      __func__);
> > > > > > > +             return -EINVAL;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > > +             fprintf(stderr, "too many data copy modes specified\n");
> > > > > > >               return -EINVAL;
> > > > > > >       }
> > > > > >
> > > > > > Actually most of them are allowed to co-exist, such as -z/--auto_zc/-u.
> > > > >
> > > > > Yes, I know the ublk driver allows multiple copy mode flags to be set
> > > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the others are
> > > > > set). However, kublk will only actually use one of the modes. For
> > > > > example, --get_data --zero_copy will use zero copy for the data
> > > > > transfer, not get data. And --zero_copy --auto_zc will only use auto
> > > > > buffer registration. So I think it's confusing to allow multiple of
> > > > > these parameters to be passed to kublk. Or do you think there is value
> > > > > in testing ublk device creation with multiple data copy mode flags
> > > > > set, but only one of the modes actually used?
> > > > >
> > > > > >
> > > > > > >
> > > > > > >       i = optind;
> > > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > > >  fi
> > > > > > >
> > > > > > >  _prep_test "null" "basic IO test"
> > > > > > >
> > > > > > > -dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
> > > > > > > +dev_id=$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
> > > > > > >  _check_add_dev $TID $?
> > > > > > >
> > > > > > >  # run fio over the two disks
> > > > > > >  fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
> > > > > > >  ERR_CODE=$?
> > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > @@ -36,19 +36,19 @@ wait
> > > > > > >
> > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
> > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback &
> > > > > > >       wait
> > > > > > >  fi
> > > > > > >
> > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > >       wait
> > > > > > >  fi
> > > > > > >
> > > > > > >  _cleanup_test "stress"
> > > > > > >  _show_result $TID $ERR_CODE
> > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > @@ -35,11 +35,11 @@ wait
> > > > > > >
> > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
> > > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> > > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback &
> > > > > > >       wait
> > > > > > >  fi
> > > > > > >
> > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > > >       wait
> > > > > > >  done
> > > > > > >
> > > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
> > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
> > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > >               wait
> > > > > > >       done
> > > > > > >  fi
> > > > > > >
> > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
> > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
> > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > >
> > > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > > >
> > > > > Ah, right, I forgot that the fallback path relies on normal zero copy
> > > > > buffer registration. I guess we are missing coverage of that, then,
> > > > > since the tests still passed with --zero_copy disabled.
> > > >
> > > > Looks one regression from commit 0a9beafa7c63 ("ublk: refactor auto buffer register in ublk_dispatch_req()")
> > >
> > > Is there a particular issue you see in that commit? I think the issue
> >
> > Looks I overlooked.
> >
> > > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but zc
> > > isn't enabled, the null ublk server will just complete the I/O
> > > immediately. And --auto_zc_fallback isn't supported by any of the
> > > other ublk servers.
> > >
> > > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> > >         queued = null_queue_auto_zc_io(t, q, tag);
> > > else if (zc)
> > >         queued = null_queue_zc_io(t, q, tag);
> > > else {
> > >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> > >         return 0;
> > > }
> > >
> > > So it looks to me to just be an issue with my kublk change.
> >
> > But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallback code
> > path isn't examined actually.
> 
> How is it broken?

typeof(q->flags) is u64, but the return type is i32, so it is overflowed.


Thanks, 
Ming


