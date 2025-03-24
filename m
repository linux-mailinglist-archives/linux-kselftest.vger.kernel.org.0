Return-Path: <linux-kselftest+bounces-29696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F9A6E29C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562FE16EFB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E91E264FBD;
	Mon, 24 Mar 2025 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6m0NYcS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C33264F83
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841815; cv=none; b=V7LONg8p3kJY38tFojH714Z2tk6KDVtefsDG2aKQJm+je+tuVgi7rI/nuEX9v2AmVxxPSndW0MVLQdrT+7g0KdC6PNK1eASLlErXMJ7kmWRqg8DHdEJMTf22rPNEMkOzUa+dn3x3GMxFnz3hzZ4pfSZoDPzqJqxc5IRg4SH62QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841815; c=relaxed/simple;
	bh=a/60Gz2XcnfG+t3/f2uLSscvy4uBkeNMSaylO44euTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGpDDgRZZR7ukkvIzz0fzn4fykFrI6g5RrQnEfUTnCBsBSGtN21sXLBqYc/aqX+YIFIQmvFbNaU7C6SbEcenKznrMtDlGg8NT57r5UsccFqDXSul48dY2pRIuEMCetspr/yip1HVjc63wMb1iaPpdCflc/OVyBkrXyjkbFnh4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6m0NYcS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742841812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dirlrC9HUIJwMMcxh44t00bYDCSz1022lqmCTgSxUDs=;
	b=O6m0NYcSplgTx0thIJ0kO2wRfzHw1vAT+Wl5C/lERqifCiaFe+DK0PMu82MCDpVjWOdOSd
	Tf4UwijkPhWN01fmJrriTeCUDkrPt3uIG3tQlMGBqDSVqvTNBqR2tn5+c0s+ttX2MLT4C0
	5Umu4yv4DLMxm28gZUKcREdHPveMXOE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-7rcx0zzhPKixMjC_goCYWA-1; Mon,
 24 Mar 2025 14:43:27 -0400
X-MC-Unique: 7rcx0zzhPKixMjC_goCYWA-1
X-Mimecast-MFC-AGG-ID: 7rcx0zzhPKixMjC_goCYWA_1742841805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6682D1956067;
	Mon, 24 Mar 2025 18:43:25 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B75F30001A1;
	Mon, 24 Mar 2025 18:43:23 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:43:20 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v2 2/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z+GnyGJxRFHhQR6U@redhat.com>
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
 <20250318-ftrace-sftest-livepatch-v2-2-60cb0aa95cca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-ftrace-sftest-livepatch-v2-2-60cb0aa95cca@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 18, 2025 at 06:20:36PM -0300, Filipe Xavier wrote:
> This new test makes sure that ftrace can trace a
> function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> ---
>  tools/testing/selftests/livepatch/test-ftrace.sh | 34 ++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index fe14f248913acbec46fb6c0fec38a2fc84209d39..4937c74de0e4d34e4e692f20ee2bbe3cd6f5a232 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -61,4 +61,38 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
>  
>  
> +# - verify livepatch can load
> +# - check if traces have a patched function
> +# - reset trace and unload livepatch
> +
> +start_test "trace livepatched function and check that the live patch remains in effect"
> +
> +FUNCTION_NAME="livepatch_cmdline_proc_show"
> +
> +load_lp $MOD_LIVEPATCH
> +trace_function "$FUNCTION_NAME"
> +
> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	log "livepatch: ok"
> +fi
> +
> +check_traced_functions "$FUNCTION_NAME"
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +livepatch: ok
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled

A few months ago, 637c730998b8 ("selftests: livepatch: rename
KLP_SYSFS_DIR to SYSFS_KLP_DIR") tweaked the functions.sh::SYSFS_KLP_DIR
and then updated all of the test-*.sh scripts to use the variable
instead of the spelled out "/sys/kernel/livepatch" string.

So if there if there is another patchset version,
s/\/sys\/kernel\/livepatch/$SYSFS_KLP_DIR/g

-- Joe 


