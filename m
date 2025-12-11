Return-Path: <linux-kselftest+bounces-47407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A10CB5569
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BECCC301BCF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8B2F690A;
	Thu, 11 Dec 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBQ6JZaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D252F7AC6
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444678; cv=none; b=kIYau87cr+6IM8Aqy++IW3JlOBOQbtzL0loCpJL4rcNfJLEr0La2jPBFy8mHfBLyV+EYbIBGPi9dv2mhuTR7qwno6WkibGq3uqfp88V7jJXXQMxmIufUE0VdBJmrdZLW4+HNsocaJqi5+0Ib8NVsapGaTe/04RzOAOUMlWB6OyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444678; c=relaxed/simple;
	bh=ob9x1WqoEHp+gV0GwXS0qQqw5rgKiUHf/5WBVyG1XIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au38XVmv/JTyYbQ1ovZLjzLlJuY7vQD39Sqj6U9prync1B845E9VmVwv2dkFI51NRBpcC9tdYhhpVufAZeMk516+YWbM0NVxyEXgdD2xLiQFLxyUo9B9Q4xbCHAY7phG+Lo9TEA9yH4YnY29Gu3K17l5N1cp2d53XAW5rjyJhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBQ6JZaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAb8z7HgBlxCUquYpAcSPYLBADzQ1kN8BZNLr9LeMJ8=;
	b=DBQ6JZaAI2clKKvEqxypUzziBINL9NROCtmo2KYEP2W5jHFPXrQOqYM+xp9KzKISjhXhlh
	71V0X9oC6jYUb7M+OnJG66X4RglhCDn68oU6WLTc39NhsMIKalQQWdnQcpUqgEmoYPeLiT
	2JP8Nf1SryFE+ciktnkdzkHd5+tpd1Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-G9X8WpKrPu2VgZCWYiyjfw-1; Thu,
 11 Dec 2025 04:17:51 -0500
X-MC-Unique: G9X8WpKrPu2VgZCWYiyjfw-1
X-Mimecast-MFC-AGG-ID: G9X8WpKrPu2VgZCWYiyjfw_1765444670
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E660195DE61;
	Thu, 11 Dec 2025 09:17:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755DE1953984;
	Thu, 11 Dec 2025 09:17:46 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:17:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] selftests: ublk: add user copy test cases
Message-ID: <aTqMNP3aDpAs044T@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 10, 2025 at 10:16:03PM -0700, Caleb Sander Mateos wrote:
> The ublk selftests cover every data copy mode except user copy. Add
> tests for user copy based on the existing test suite:
> - generic_14 ("basic recover function verification (user copy)") based
>   on generic_04 and generic_05
> - null_03 ("basic IO test with user copy") based on null_01 and null_02
> - loop_06 ("write and verify over user copy") based on loop_01 and
>   loop_03
> - loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
>   loop_04
> - stripe_05 ("write and verify test on user copy") based on stripe_03
> - stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
>   and stripe_04
> - Added test cases to stress_05 ("run IO and remove device with recovery
>   enabled") for user copy
> - stress_06 ("run IO and remove device (user copy)") based on stress_01
>   and stress_03
> - stress_07 ("run IO and kill ublk server (user copy)") based on
>   stress_02 and stress_04
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  8 ++++
>  .../testing/selftests/ublk/test_generic_14.sh | 40 +++++++++++++++++++
>  tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++++++
>  tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++++++
>  tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++++++
>  .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
>  .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++++++++++
>  .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++++++++++
>  .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++++++
>  .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++++++
>  10 files changed, 250 insertions(+)
>  create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
>  create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
>  create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
>  create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
>  create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
>  create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
>  create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
>  create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 770269efe42a..837977b62417 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -19,28 +19,36 @@ TEST_PROGS += test_generic_08.sh
>  TEST_PROGS += test_generic_09.sh
>  TEST_PROGS += test_generic_10.sh
>  TEST_PROGS += test_generic_11.sh
>  TEST_PROGS += test_generic_12.sh
>  TEST_PROGS += test_generic_13.sh
> +TEST_PROGS += test_generic_14.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> +TEST_PROGS += test_null_03.sh
>  TEST_PROGS += test_loop_01.sh
>  TEST_PROGS += test_loop_02.sh
>  TEST_PROGS += test_loop_03.sh
>  TEST_PROGS += test_loop_04.sh
>  TEST_PROGS += test_loop_05.sh
> +TEST_PROGS += test_loop_06.sh
> +TEST_PROGS += test_loop_07.sh
>  TEST_PROGS += test_stripe_01.sh
>  TEST_PROGS += test_stripe_02.sh
>  TEST_PROGS += test_stripe_03.sh
>  TEST_PROGS += test_stripe_04.sh
> +TEST_PROGS += test_stripe_05.sh
> +TEST_PROGS += test_stripe_06.sh
>  
>  TEST_PROGS += test_stress_01.sh
>  TEST_PROGS += test_stress_02.sh
>  TEST_PROGS += test_stress_03.sh
>  TEST_PROGS += test_stress_04.sh
>  TEST_PROGS += test_stress_05.sh
> +TEST_PROGS += test_stress_06.sh
> +TEST_PROGS += test_stress_07.sh
>  
>  TEST_GEN_PROGS_EXTENDED = kublk
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
> new file mode 100755
> index 000000000000..cd9b44b97c24
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_14.sh
> @@ -0,0 +1,40 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="generic_14"
> +ERR_CODE=0
> +
> +ublk_run_recover_test()
> +{
> +	run_io_and_recover 256M "kill_daemon" "$@"
> +	ERR_CODE=$?
> +	if [ ${ERR_CODE} -ne 0 ]; then
> +		echo "$TID failure: $*"
> +		_show_result $TID $ERR_CODE
> +	fi
> +}
> +
> +if ! _have_program fio; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +_prep_test "recover" "basic recover function verification (user copy)"
> +
> +_create_backfile 0 256M
> +_create_backfile 1 128M
> +_create_backfile 2 128M
> +
> +ublk_run_recover_test -t null -q 2 -r 1 -u &
> +ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
> +ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +wait
> +
> +ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
> +ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
> +ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +wait
> +
> +_cleanup_test "recover"
> +_show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing/selftests/ublk/test_loop_06.sh
> new file mode 100755
> index 000000000000..1d1a8a725502
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_loop_06.sh
> @@ -0,0 +1,25 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="loop_06"
> +ERR_CODE=0
> +
> +if ! _have_program fio; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +_prep_test "loop" "write and verify over user copy"
> +
> +_create_backfile 0 256M
> +dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> +_check_add_dev $TID $?
> +
> +# run fio over the ublk disk
> +_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
> +ERR_CODE=$?
> +
> +_cleanup_test "loop"
> +
> +_show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing/selftests/ublk/test_loop_07.sh
> new file mode 100755
> index 000000000000..493f3fb611a5
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_loop_07.sh
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="loop_07"
> +ERR_CODE=0
> +
> +_prep_test "loop" "mkfs & mount & umount with user copy"
> +
> +_create_backfile 0 256M
> +
> +dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
> +_check_add_dev $TID $?
> +
> +_mkfs_mount_test /dev/ublkb"${dev_id}"
> +ERR_CODE=$?
> +
> +_cleanup_test "loop"
> +
> +_show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
> new file mode 100755
> index 000000000000..0051067b4686
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_null_03.sh
> @@ -0,0 +1,24 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="null_03"
> +ERR_CODE=0
> +
> +if ! _have_program fio; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +_prep_test "null" "basic IO test with user copy"
> +
> +dev_id=$(_add_ublk_dev -t null -u)
> +_check_add_dev $TID $?
> +
> +# run fio over the two disks
> +fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
> +ERR_CODE=$?
> +
> +_cleanup_test "null"
> +
> +_show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> index 09b94c36f2ba..cb8203957d1d 100755
> --- a/tools/testing/selftests/ublk/test_stress_05.sh
> +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> @@ -78,7 +78,14 @@ if _have_feature "PER_IO_DAEMON"; then
>  	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
>  	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
>  fi
>  wait
>  
> +for reissue in $(seq 0 1); do
> +	ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> +	ublk_io_and_remove 256M -t loop -q 4 -u -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> +	ublk_io_and_remove 8G -t null -q 4 -u -r 1 -i "$reissue" &
> +	wait
> +done

I'd suggest to not add new test coverage in old stress tests until default
timeout is overrided, now it is close to default 45 seconds timeout.


Thanks,
Ming


