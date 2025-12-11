Return-Path: <linux-kselftest+bounces-47458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3BCB74E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 23:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D7A300E162
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250127E7EB;
	Thu, 11 Dec 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAqpzy/J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FE1E9B12
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765492534; cv=none; b=ZmiqFkkZvQq6/7iJ/vhWuUrZX/crwvIe/9DnGUzvxX43X6ysbRf4gUD/1w43XxiC+cTPMtNS0nuOgx0WumAE2IMrUKKb/av9i4dpJg7A+P9MLut/qwIGfwVDeS2glAkGpy7RDbzgIxhojSsvZUqR+mhVa6OFF9ZHljexW2nLJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765492534; c=relaxed/simple;
	bh=4qCKEtMtZ/d3qLKU3hqSsg/jlOitbG/cy+VURFXxrD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7yI6pQ/H7Sjsp3YReVJ39Ew9wFHmRhxw1kHmD1hOx3/ARJl8TwPN1ORSTTiOc9h4+rI6NHHTVh6/C8LYLHhhEOWK8X2rfBmcEm7RgVLvd6/CA49Ee69EPk9eJwCQgtLDxlYT9FqdJMScbM9fMNtXoNkBc4OUIGdpWti3deU2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAqpzy/J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765492531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMaJDn1GDDLRNnYB3S6cxwEpJWfKeaV9vZ+xd73GtK0=;
	b=AAqpzy/JU2cmLQH/AreC/PqPWy9sP3wK+RJe5EZ2GG+mH2PGXnqqv3702h4korSwlh7K+S
	a04myVacka2cqhWj9DsG6lYzSiTp7I3JLM+CCyOz2KaPI3DhB0aw90YYjxJ8HbGYcBK+dX
	tOBBKpqP4jZiNNK7PHV09Q/THk4memc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-HTDdVv_uN0OS2j2yKk-kYA-1; Thu,
 11 Dec 2025 17:35:27 -0500
X-MC-Unique: HTDdVv_uN0OS2j2yKk-kYA-1
X-Mimecast-MFC-AGG-ID: HTDdVv_uN0OS2j2yKk-kYA_1765492526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ADB5195DE49;
	Thu, 11 Dec 2025 22:35:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1046830001A2;
	Thu, 11 Dec 2025 22:35:22 +0000 (UTC)
Date: Fri, 12 Dec 2025 06:35:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] selftests: ublk: add user copy test cases
Message-ID: <aTtHJm_qcQIYkXcy@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-9-csander@purestorage.com>
 <aTqMNP3aDpAs044T@fedora>
 <CADUfDZr3WZHwZSMidQKH5p8yMDM6yWwbdyEJcvS6YBHSfFY_RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr3WZHwZSMidQKH5p8yMDM6yWwbdyEJcvS6YBHSfFY_RA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Dec 11, 2025 at 10:46:41AM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 1:17 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 10:16:03PM -0700, Caleb Sander Mateos wrote:
> > > The ublk selftests cover every data copy mode except user copy. Add
> > > tests for user copy based on the existing test suite:
> > > - generic_14 ("basic recover function verification (user copy)") based
> > >   on generic_04 and generic_05
> > > - null_03 ("basic IO test with user copy") based on null_01 and null_02
> > > - loop_06 ("write and verify over user copy") based on loop_01 and
> > >   loop_03
> > > - loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
> > >   loop_04
> > > - stripe_05 ("write and verify test on user copy") based on stripe_03
> > > - stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
> > >   and stripe_04
> > > - Added test cases to stress_05 ("run IO and remove device with recovery
> > >   enabled") for user copy
> > > - stress_06 ("run IO and remove device (user copy)") based on stress_01
> > >   and stress_03
> > > - stress_07 ("run IO and kill ublk server (user copy)") based on
> > >   stress_02 and stress_04
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  tools/testing/selftests/ublk/Makefile         |  8 ++++
> > >  .../testing/selftests/ublk/test_generic_14.sh | 40 +++++++++++++++++++
> > >  tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++++++
> > >  tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++++++
> > >  tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++++++
> > >  .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
> > >  .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++++++++++
> > >  .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++++++++++
> > >  .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++++++
> > >  .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++++++
> > >  10 files changed, 250 insertions(+)
> > >  create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
> > >  create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh
> > >
> > > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > > index 770269efe42a..837977b62417 100644
> > > --- a/tools/testing/selftests/ublk/Makefile
> > > +++ b/tools/testing/selftests/ublk/Makefile
> > > @@ -19,28 +19,36 @@ TEST_PROGS += test_generic_08.sh
> > >  TEST_PROGS += test_generic_09.sh
> > >  TEST_PROGS += test_generic_10.sh
> > >  TEST_PROGS += test_generic_11.sh
> > >  TEST_PROGS += test_generic_12.sh
> > >  TEST_PROGS += test_generic_13.sh
> > > +TEST_PROGS += test_generic_14.sh
> > >
> > >  TEST_PROGS += test_null_01.sh
> > >  TEST_PROGS += test_null_02.sh
> > > +TEST_PROGS += test_null_03.sh
> > >  TEST_PROGS += test_loop_01.sh
> > >  TEST_PROGS += test_loop_02.sh
> > >  TEST_PROGS += test_loop_03.sh
> > >  TEST_PROGS += test_loop_04.sh
> > >  TEST_PROGS += test_loop_05.sh
> > > +TEST_PROGS += test_loop_06.sh
> > > +TEST_PROGS += test_loop_07.sh
> > >  TEST_PROGS += test_stripe_01.sh
> > >  TEST_PROGS += test_stripe_02.sh
> > >  TEST_PROGS += test_stripe_03.sh
> > >  TEST_PROGS += test_stripe_04.sh
> > > +TEST_PROGS += test_stripe_05.sh
> > > +TEST_PROGS += test_stripe_06.sh
> > >
> > >  TEST_PROGS += test_stress_01.sh
> > >  TEST_PROGS += test_stress_02.sh
> > >  TEST_PROGS += test_stress_03.sh
> > >  TEST_PROGS += test_stress_04.sh
> > >  TEST_PROGS += test_stress_05.sh
> > > +TEST_PROGS += test_stress_06.sh
> > > +TEST_PROGS += test_stress_07.sh
> > >
> > >  TEST_GEN_PROGS_EXTENDED = kublk
> > >
> > >  include ../lib.mk
> > >
> > > diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
> > > new file mode 100755
> > > index 000000000000..cd9b44b97c24
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_generic_14.sh
> > > @@ -0,0 +1,40 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +TID="generic_14"
> > > +ERR_CODE=0
> > > +
> > > +ublk_run_recover_test()
> > > +{
> > > +     run_io_and_recover 256M "kill_daemon" "$@"
> > > +     ERR_CODE=$?
> > > +     if [ ${ERR_CODE} -ne 0 ]; then
> > > +             echo "$TID failure: $*"
> > > +             _show_result $TID $ERR_CODE
> > > +     fi
> > > +}
> > > +
> > > +if ! _have_program fio; then
> > > +     exit "$UBLK_SKIP_CODE"
> > > +fi
> > > +
> > > +_prep_test "recover" "basic recover function verification (user copy)"
> > > +
> > > +_create_backfile 0 256M
> > > +_create_backfile 1 128M
> > > +_create_backfile 2 128M
> > > +
> > > +ublk_run_recover_test -t null -q 2 -r 1 -u &
> > > +ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
> > > +ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > +wait
> > > +
> > > +ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
> > > +ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
> > > +ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > +wait
> > > +
> > > +_cleanup_test "recover"
> > > +_show_result $TID $ERR_CODE
> > > diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing/selftests/ublk/test_loop_06.sh
> > > new file mode 100755
> > > index 000000000000..1d1a8a725502
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_loop_06.sh
> > > @@ -0,0 +1,25 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +TID="loop_06"
> > > +ERR_CODE=0
> > > +
> > > +if ! _have_program fio; then
> > > +     exit "$UBLK_SKIP_CODE"
> > > +fi
> > > +
> > > +_prep_test "loop" "write and verify over user copy"
> > > +
> > > +_create_backfile 0 256M
> > > +dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> > > +_check_add_dev $TID $?
> > > +
> > > +# run fio over the ublk disk
> > > +_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
> > > +ERR_CODE=$?
> > > +
> > > +_cleanup_test "loop"
> > > +
> > > +_show_result $TID $ERR_CODE
> > > diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing/selftests/ublk/test_loop_07.sh
> > > new file mode 100755
> > > index 000000000000..493f3fb611a5
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_loop_07.sh
> > > @@ -0,0 +1,21 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +TID="loop_07"
> > > +ERR_CODE=0
> > > +
> > > +_prep_test "loop" "mkfs & mount & umount with user copy"
> > > +
> > > +_create_backfile 0 256M
> > > +
> > > +dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> > > +_check_add_dev $TID $?
> > > +
> > > +_mkfs_mount_test /dev/ublkb"${dev_id}"
> > > +ERR_CODE=$?
> > > +
> > > +_cleanup_test "loop"
> > > +
> > > +_show_result $TID $ERR_CODE
> > > diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
> > > new file mode 100755
> > > index 000000000000..0051067b4686
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_null_03.sh
> > > @@ -0,0 +1,24 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +TID="null_03"
> > > +ERR_CODE=0
> > > +
> > > +if ! _have_program fio; then
> > > +     exit "$UBLK_SKIP_CODE"
> > > +fi
> > > +
> > > +_prep_test "null" "basic IO test with user copy"
> > > +
> > > +dev_id=$(_add_ublk_dev -t null -u)
> > > +_check_add_dev $TID $?
> > > +
> > > +# run fio over the two disks
> > > +fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
> > > +ERR_CODE=$?
> > > +
> > > +_cleanup_test "null"
> > > +
> > > +_show_result $TID $ERR_CODE
> > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> > > index 09b94c36f2ba..cb8203957d1d 100755
> > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > @@ -78,7 +78,14 @@ if _have_feature "PER_IO_DAEMON"; then
> > >       ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
> > >       ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
> > >  fi
> > >  wait
> > >
> > > +for reissue in $(seq 0 1); do
> > > +     ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> > > +     ublk_io_and_remove 256M -t loop -q 4 -u -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > +     ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> > > +     wait
> > > +done
> >
> > I'd suggest to not add new test coverage in old stress tests until default
> > timeout is overrided, now it is close to default 45 seconds timeout.
> 
> Okay, I can just drop the changes in test_stress_05.sh if that sounds
> good to you?

Yeah, it is fine to drop it in test_stress_05.sh.


Thanks,
Ming


