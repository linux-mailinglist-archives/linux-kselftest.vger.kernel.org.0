Return-Path: <linux-kselftest+bounces-47406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34148CB551A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060263010FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE52BE642;
	Thu, 11 Dec 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH3LX5Fj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7B1C3F36
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444159; cv=none; b=jIWu0tuT+f/yqa0RYyHeQPW7XnyygA+EG35Zr9GrLf+Y+hmtSCaucKNl9svcxgzXmraILVyTK86a+7BIUg++cnooOSnSP35kgsSVOmcj66ljFLPJJbrzDkRk/nUeBavyr9w2h6Uj96SmIFPDqw55RuqsdJLZs8yVW4slSNsJ9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444159; c=relaxed/simple;
	bh=PKu7ZhIVsE8UhKO2SOkz+m/9URXW4ZGOqZXBusYamKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX2t2N/kgmrD2MAHlOYwKleASucueuJ3DhGdoGboEJlDEuHQoVYraWcZbAxH4MOml33oXXdI816Da5LscLDSZA6qGGJft2nKwWOVxERCxBLyAKpLHMUBAh2D5ZRECaouA+dtj8xOkVjxi8khYy31Xa1ojxbHgj7WhjWB3DsMXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fH3LX5Fj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA24b3Ai8QTbCJIBJABmbbtnT8esC9akKU7XcThUJt0=;
	b=fH3LX5FjxxdT3WaI+fZt7h2fnLZlbvx/tLfke9/Qt13jcOwPmSsdNGtDVt2NjQFpfkMvJb
	tNAN8742t92MPq/cbO9Gjoe3fMHLNtf6FVNJHHU1My33e8pu/dT4RvyRiS6LNsp+tBTLUM
	iHzZVUpWMlUWVXMaA7fStZh/SIpsJTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-DkWRgFiZMXaMWKCSk-gWAg-1; Thu,
 11 Dec 2025 04:09:12 -0500
X-MC-Unique: DkWRgFiZMXaMWKCSk-gWAg-1
X-Mimecast-MFC-AGG-ID: DkWRgFiZMXaMWKCSk-gWAg_1765444151
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96887195DE61;
	Thu, 11 Dec 2025 09:09:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 355B01800451;
	Thu, 11 Dec 2025 09:09:05 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:09:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTqKLSbpQN26XLNq@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wrote:
> The kublk mock ublk server allows multiple data copy mode arguments to
> be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> The ublk device will be created with all the requested feature flags,
> however kublk will only use one of the modes to interact with request
> data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> clarify the intent of the test, don't allow multiple data copy modes to
> be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
> independent feature. Don't require zero_copy for auto_zc_fallback, as
> only auto_zc is needed. Fix the test cases passing multiple data copy
> mode arguments.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++-------
>  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
>  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
>  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
>  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
>  5 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index f8fa102a627f..1765c4806523 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
>  			break;
>  		case 'd':
>  			ctx.queue_depth = strtol(optarg, NULL, 10);
>  			break;
>  		case 'z':
> -			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
> +			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY;
>  			break;
>  		case 'r':
>  			value = strtol(optarg, NULL, 10);
>  			if (value)
>  				ctx.flags |= UBLK_F_USER_RECOVERY;
> @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
>  			optind += 1;
>  			break;
>  		}
>  	}
>  
> -	/* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
> -	if (ctx.auto_zc_fallback &&
> -	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> -		    (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> -		ublk_err("%s: auto_zc_fallback is set but neither "
> -				"F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
> -					__func__);
> +	/* auto_zc_fallback depends on F_AUTO_BUF_REG */
> +	if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG)) {
> +		ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_REG is disabled\n",
> +			 __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> +	    !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> +	    !!(ctx.flags & UBLK_F_USER_COPY) +
> +	    !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> +		fprintf(stderr, "too many data copy modes specified\n");
>  		return -EINVAL;
>  	}

Actually most of them are allowed to co-exist, such as -z/--auto_zc/-u.

>  
>  	i = optind;
>  	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
> index bb6f77ca5522..145e17b3d2b0 100755
> --- a/tools/testing/selftests/ublk/test_generic_09.sh
> +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> @@ -14,11 +14,11 @@ if ! _have_program fio; then
>  	exit "$UBLK_SKIP_CODE"
>  fi
>  
>  _prep_test "null" "basic IO test"
>  
> -dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
> +dev_id=$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
>  _check_add_dev $TID $?
>  
>  # run fio over the two disks
>  fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
>  ERR_CODE=$?
> diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
> index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> --- a/tools/testing/selftests/ublk/test_stress_03.sh
> +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> @@ -36,19 +36,19 @@ wait
>  
>  if _have_feature "AUTO_BUF_REG"; then
>  	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
>  	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
>  	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> +	ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback &
>  	wait
>  fi
>  
>  if _have_feature "PER_IO_DAEMON"; then
>  	ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
>  	ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
>  	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
> +	ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
>  	wait
>  fi
>  
>  _cleanup_test "stress"
>  _show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> index c7220723b537..6e165a1f90b4 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -35,11 +35,11 @@ wait
>  
>  if _have_feature "AUTO_BUF_REG"; then
>  	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
>  	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
>  	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback &
>  	wait
>  fi
>  
>  if _have_feature "PER_IO_DAEMON"; then
>  	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
> index 274295061042..09b94c36f2ba 100755
> --- a/tools/testing/selftests/ublk/test_stress_05.sh
> +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
>  	wait
>  done
>  
>  if _have_feature "ZERO_COPY"; then
>  	for reissue in $(seq 0 1); do
> -		ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
> -		ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> +		ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
> +		ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
>  		wait
>  	done
>  fi
>  
>  if _have_feature "AUTO_BUF_REG"; then
>  	for reissue in $(seq 0 1); do
> -		ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
> -		ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> -		ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
> +		ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
> +		ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> +		ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &

--auto_zc_fallback requires both -z and --auto_zc.


Thanks,
Ming


