Return-Path: <linux-kselftest+bounces-29692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1179A6E239
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417933A951A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF7264A84;
	Mon, 24 Mar 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQh6ePKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404A26462C
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840589; cv=none; b=qZZPXAfDCs7YdvaKEzZ8ObAmiahZzNe+ouhRPZKwA6Mxvi1BGfYApvmf+Y9mXUHKYhkJZY0DUwNeOUnyaOa+aKhb/GPzAFQVrSIRDM9mGAMRKNRkAmpwDqPVk+Eao0ZSMzzNvK+nhEw4+qLdBfeSTyWLSP/OhLeRgjLDuxhwuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840589; c=relaxed/simple;
	bh=ZeRY07bNCq4ht4qtQOC4e9VFCeSCnYwVqOaj75U64GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAXRW5w6pttciWWxt3P1WcpuIGpisW6LUG74vqhGi27DQrqb7AxssCC/zzB7yi0aIO/GXoMWypjwOS5fU9Rbmt6jFikvIUtmWqwiXE/+rHQLtS9kM4s04XJioRhNZ0QN68+6VDXBwOn5G9VayPHtsvaUpdODjgwDLU9YUcQH/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQh6ePKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742840586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5FUeUf5qZFkxlfZh7QgAlQGxD5fCVQ/217Dc1NXrL8=;
	b=PQh6ePKGMb6RfwS3/bY/KxIhmHZSm50SW7miCJCV2gnokh8vmTG2RDF9N8lCkWMYo209h6
	8Vv4CAek1hBl082uEiA44vkXVq8xWcIb+1lgXOyRBrDv62xxtKApisWXLdkwJ/FeVIBxWT
	GOD4B9bfB4uinBFo+ehmqdurz4j0O78=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-QeRIsDMqMCGxfRC2gqpXvQ-1; Mon,
 24 Mar 2025 14:23:00 -0400
X-MC-Unique: QeRIsDMqMCGxfRC2gqpXvQ-1
X-Mimecast-MFC-AGG-ID: QeRIsDMqMCGxfRC2gqpXvQ_1742840579
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFB73196B356;
	Mon, 24 Mar 2025 18:22:58 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463C330001A1;
	Mon, 24 Mar 2025 18:22:56 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:22:53 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v2 1/2] selftests: livepatch: add new ftrace helpers
 functions
Message-ID: <Z+Gi/QEFPffEonTE@redhat.com>
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
 <20250318-ftrace-sftest-livepatch-v2-1-60cb0aa95cca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-ftrace-sftest-livepatch-v2-1-60cb0aa95cca@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 18, 2025 at 06:20:35PM -0300, Filipe Xavier wrote:
> Add new ftrace helpers functions cleanup_tracing, trace_function and
> check_traced_functions.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 49 ++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 15601402dee6567837c2c49ba342eb357e410d18..dea9cc10a3f09662c57c2593cff49423302c8a5c 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -10,6 +10,7 @@ SYSFS_KERNEL_DIR="/sys/kernel"
>  SYSFS_KLP_DIR="$SYSFS_KERNEL_DIR/livepatch"
>  SYSFS_DEBUG_DIR="$SYSFS_KERNEL_DIR/debug"
>  SYSFS_KPROBES_DIR="$SYSFS_DEBUG_DIR/kprobes"
> +SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"
>  
>  # Kselftest framework requirement - SKIP code is 4
>  ksft_skip=4
> @@ -62,6 +63,9 @@ function push_config() {
>  			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
>  	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
>  	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
> +	TRACING_ON=$(cat "$SYSFS_TRACING_DIR/tracing_on")
> +	CURRENT_TRACER=$(cat "$SYSFS_TRACING_DIR/current_tracer")
> +	FTRACE_FILTER=$(cat "$SYSFS_TRACING_DIR/set_ftrace_filter")
>  }
>  
>  function pop_config() {
> @@ -74,6 +78,17 @@ function pop_config() {
>  	if [[ -n "$KPROBE_ENABLED" ]]; then
>  		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
>  	fi
> +	if [[ -n "$TRACING_ON" ]]; then
> +		echo "$TRACING_ON" > "$SYSFS_TRACING_DIR/tracing_on"
> +	fi
> +	if [[ -n "$CURRENT_TRACER" ]]; then
> +		echo "$CURRENT_TRACER" > "$SYSFS_TRACING_DIR/current_tracer"
> +	fi
> +	if [[ -n "$FTRACE_FILTER" ]]; then
> +		echo "$FTRACE_FILTER" \
> +			| sed -e "/#### all functions enabled ####/d"
> +			> "$SYSFS_TRACING_DIR/set_ftrace_filter"
> +	fi
>  }
>  
>  function set_dynamic_debug() {
> @@ -352,3 +367,37 @@ function check_sysfs_value() {
>  		die "Unexpected value in $path: $expected_value vs. $value"
>  	fi
>  }
> +
> +# cleanup_tracing() - stop and clean up function tracing
> +function cleanup_tracing() {
> +	echo 0 > "$SYSFS_TRACING_DIR/tracing_on"
> +	echo "" > "$SYSFS_TRACING_DIR/set_ftrace_filter"
> +	echo "nop" > "$SYSFS_TRACING_DIR/current_tracer"
> +	echo "" > "$SYSFS_TRACING_DIR/trace"
> +}
> +
> +# trace_function(function) - start tracing of a function
> +#	function - to be traced function
> +function trace_function() {
> +	local function="$1"; shift
> +
> +	cleanup_tracing
> +
> +	echo "function" > "$SYSFS_TRACING_DIR/current_tracer"
> +	echo "$function" > "$SYSFS_TRACING_DIR/set_ftrace_filter"
> +	echo 1 > "$SYSFS_TRACING_DIR/tracing_on"
> +}
> +
> +# check_traced_functions(functions...) - check whether each function appeared in the trace log
> +#	functions - list of functions to be checked
> +function check_traced_functions() {
> +	local function
> +
> +	for function in "$@"; do
> +		if ! grep -q "$function" "$SYSFS_TRACING_DIR/trace" ; then

Small suggestion here: grep on "$function" may find partial string
matches, like:

  $ echo 'hamburger' | grep 'ham'
  hamburger

so it's probably safer to user --word-regexp to avoid longer function
names inadvertently matching:

  $ echo 'hamburger' | grep -w 'ham'
  $ echo 'ham' | grep -w 'ham'
  ham

Also, maybe also --fixed-strings for the extra paranoid?  Off the top of
my head, I don't think any C function characters are special regex (like
$ ^ [ ] etc.) so it's probably safe w/o.

-- Joe


