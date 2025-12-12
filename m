Return-Path: <linux-kselftest+bounces-47503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0469CB8A7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1F0300975D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311C31960F;
	Fri, 12 Dec 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO8F+Mhy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EEE30DEB9
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537017; cv=none; b=KxGsvBngXBQ6kGJnj6Oy6LzJjhHZouZlcxBnKsuvRRn4TLq8hIjdp1G14eqNVGiB8h+t3kdicPbwvHtf5Pcn5w47R7hnrGHI3NEA2RBMTONGCRE7cEbn0E6/L9bRdwEUD5UtSn2L9buviO4+2LJdihwtn1PliXy3coL7GYcnm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537017; c=relaxed/simple;
	bh=ibQJsHwkc+7Pma/2fkkv0U4dadiyxgGSoLTWPaqXEkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxPSKrmv0T1BB1iN2JnvCtn3i06zBaatcC6fKaeuPyQ/7V4k9psHjZowUjZLqHGS7qA1IHBkDjUF9redJFHBpxWe+dJpSUQLhUiVy/z0ks1PFOBtSpYVb0uG3gUz7LV0U1PVlTgIxV8UWRHUMHryeicDFasM4kidTepkIF1PzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UO8F+Mhy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765537014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OERi9wgee/xA9tebuxmJovKCJLd5or7+bUVPWM9Skcw=;
	b=UO8F+Mhy95ab6Ut5n/GTOXJVm5m7l5CQo3UJZNA6DIbHH7jU3bdgeecWXTR5VG3cgMeK0F
	nwwgMVkY11apTK+2QvVD+CLjpKruZbzB9IWkGxIWjA7LHzcSEYAUjPYT7VjJVtLgUldANB
	Khs+fA4kjf2cjQHQc1x2H97qsx00jMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-debKW8RjMeK9Se_joa4MHw-1; Fri,
 12 Dec 2025 05:56:51 -0500
X-MC-Unique: debKW8RjMeK9Se_joa4MHw-1
X-Mimecast-MFC-AGG-ID: debKW8RjMeK9Se_joa4MHw_1765537010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E20BC18002C1;
	Fri, 12 Dec 2025 10:56:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FCB180049F;
	Fri, 12 Dec 2025 10:56:46 +0000 (UTC)
Date: Fri, 12 Dec 2025 18:56:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
Message-ID: <aTv06QEJIYyJKCVQ@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
> stress_04 is described as "run IO and kill ublk server(zero copy)" but
> the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> test cases is duplicated. Add --auto_zc to these test cases and
> --auto_zc_fallback to one of the duplicated ones. This matches the test
> cases in stress_03.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> index 3f901db4d09d..965befcee830 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
>  	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
>  	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
>  fi
>  
>  if _have_feature "PER_IO_DAEMON"; then
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> -	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> -	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> +	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &

The last line needs `-z`, otherwise the following warning is dumped:

```
# selftests: ublk: test_stress_04.sh
# main: auto_zc_fallback is set but neither F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled
# stress_04 : [FAIL]
```


Thanks,
Ming


