Return-Path: <linux-kselftest+bounces-24004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CEA045ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088303A5362
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA261F4273;
	Tue,  7 Jan 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APKjrjxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B6125B9
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267028; cv=none; b=p2zdKXtoJh8zKGw6aGB8A85Ogc7rWL9OPKZr/9iLPFFWp5omIaWC2WlfxsnXUZCoObtj0h1UqJsddSOeSQZ5MUGFKYIvSSW7QCZFlgsdFsT3geP74M3cAQwmgKompYnll/BrmScbSzXsISgHNLBarPgxv+LYf/+1gWHWwAcjhyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267028; c=relaxed/simple;
	bh=W4KF39PABBH5ml2mGjKonNLqTB8qoU6Mmq6wPWwdFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZFohSyC84t4qPBQL7YlXx88SOcJ656F5DNChI+iO3e+8TCwGjugLpiqizGJXuYevmoXnUVQE8ZRTEOkJqeV2pMu2icwwlcTC7inpyHJKvWvlbwC4rZzRW8l5M2yprOXu2I74rELEOhWV6U97iIlKecnSWoXO3+uAMUD65chbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APKjrjxp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736267023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SML5E82jLDZPoDfWHBjc7GGkwKJX7zSEAE1HHyFwSy0=;
	b=APKjrjxpsxCR8mGrfuEkcmAV1juJzeR6pJKwiR9mz8aAhxg1Kz3gEvHL7uFt6VVfNQbBcA
	b3rkh01WRwgfjFXd0AWLNag6f8FRx9x2XzG+1gBN32xG85zToQrZIPV9P/CsqfhyXYFPnZ
	z2U+gKHZXSUaFaLyKtXtPyuIVNBOZK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-ZinBM8BGPCO1rxzAVLBQ1A-1; Tue,
 07 Jan 2025 11:23:39 -0500
X-MC-Unique: ZinBM8BGPCO1rxzAVLBQ1A-1
X-Mimecast-MFC-AGG-ID: ZinBM8BGPCO1rxzAVLBQ1A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C74C71955E9D;
	Tue,  7 Jan 2025 16:23:37 +0000 (UTC)
Received: from redhat.com (unknown [10.22.65.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 518A81955F40;
	Tue,  7 Jan 2025 16:23:35 +0000 (UTC)
Date: Tue, 7 Jan 2025 11:23:32 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>
Subject: Re: [PATCH] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z31VBN3zo47Ohr27@redhat.com>
References: <20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jan 02, 2025 at 03:42:10PM -0300, Filipe Xavier wrote:
> This new test makes sure that ftrace can trace a
> function that was introduced by a livepatch.
>

Hi Filipe,

Thanks for adding a test!

Aside: another similar test could verify that the original function, in
this case cmdline_proc_show(), can still be traced despite it being
livepatched.  That may be non-intuitive but it demonstrates how the
ftrace handler works.
 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> ---
>  tools/testing/selftests/livepatch/test-ftrace.sh | 37 ++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index fe14f248913acbec46fb6c0fec38a2fc84209d39..5f0d5308c88669e84210393ce7b8aa138b694ebd 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -61,4 +61,41 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
>  
>  
> +# - verify livepatch can load
> +# - check traces if have a patched function

nit: wording?  "check if traces have a patched function" ?

> +# - unload livepatch and reset trace
> +
> +start_test "livepatch trace patched function and check that the live patch remains in effect"

nit: wording?  "trace livepatched function and check ..." ?

> +
> +TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
> +FUNCTION_NAME="livepatch_cmdline_proc_show"
> +
> +load_lp $MOD_LIVEPATCH
> +
> +echo $FUNCTION_NAME > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
> +echo "function" > $SYSFS_DEBUG_DIR/tracing/current_tracer
> +echo "" > $TRACE_FILE

A few suggestions:

- The tracing is also dependent on the 'tracing_on' file, so if it
  happens to be turned off, the test will fail.

- See functions.sh :: push_config() and pop_config() for an example of
  saving the existing values rather than turning them all off at the end
  of the test.

- Nitpick: shellcheck suggests wrapping filenames in double quotations,
  applicable in several places.

> +
> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +grep -q $FUNCTION_NAME $TRACE_FILE
> +FOUND=$?
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +# Reset tracing
> +echo "nop" > $SYSFS_DEBUG_DIR/tracing/current_tracer
> +echo "" > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
> +echo "" > $TRACE_FILE
> +
> +if [ "$FOUND" -eq 1 ]; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +
>  exit 0
> 
> ---
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8
> 
> Best regards,
> -- 
> Filipe Xavier <felipeaggger@gmail.com>
> 

Thanks,
--
Joe


