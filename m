Return-Path: <linux-kselftest+bounces-11056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF98D6A0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9E31F22CF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582317E47D;
	Fri, 31 May 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYw38o1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D717D889
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184698; cv=none; b=ekkc6XFhy1xM/QXpmUR5fGrYs9ZCOcbDbpLypbmLnNxyhKDJ/SlDbrztHGj38JEDSuKwr4xpdb+s6dQFoJEtMEg2o41UDyYuMoOiTAscZw2Wgppwi1COxOrVaN2PwlJzAy0oMRcZgjYggXGAlfp7JEfDO6TwsE2eA7ViOE86pvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184698; c=relaxed/simple;
	bh=WsXsZUZBHM71gw5SH/Pl2AmNjI0Fjt2FzypgjJ5Rw5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyFbsmfwHVlUxVK9xKNvfOWJE7vEkOjfU/doe0stB0B5tWEPCHly91kH01iWI8uuLtqhhEsGqVRZIXjMRbFZtp9RXDd7wVRZ2/TgsQIzbC6BfEkoAa5Jv60qBKk3TAd5zwwQcYUOek17Xa2bjh7HO9xo191dDFWktYEIUs5oQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYw38o1F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717184694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srIuKAq+Z2eXfh6Ltvl4It8PMcDQP7/BZ/A3IAY5rw0=;
	b=AYw38o1FPK7sKO5+K1UgHgatWAvZojrAx0pE/n4QCQ2VdfgulP/3Nse4S2YE+i/qgfP/g6
	X9DDUs0d2C8gcSHE0vaLoUXup6GZGlqZKGg0Bq2UkA3SC9JUz2+8HmbC9XFwTVRmJwIQHd
	Y8f0JVoo6313EfTn4VPTg8899PzFoHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-pOdfD2urOUW337F-bRD_dA-1; Fri,
 31 May 2024 15:44:48 -0400
X-MC-Unique: pOdfD2urOUW337F-bRD_dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37EAE3C025AC;
	Fri, 31 May 2024 19:44:48 +0000 (UTC)
Received: from redhat.com (unknown [10.22.18.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BEBAC3C27;
	Fri, 31 May 2024 19:44:47 +0000 (UTC)
Date: Fri, 31 May 2024 15:44:46 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <ZloormpDnnc4SDub@redhat.com>
References: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sat, May 25, 2024 at 11:34:08AM -0300, Marcos Paulo de Souza wrote:
> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes since v1:
> * Added checks in the existing test-livepatch.sh instead of creating a
>   new test file. (Joe)
> * Fixed issues reported by ShellCheck (Joe)
> ---
>  .../testing/selftests/livepatch/test-livepatch.sh  | 46 ++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index e3455a6b1158..d85405d18e54 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -107,9 +107,12 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  
>  # - load a livepatch that modifies the output from /proc/cmdline and
>  #   verify correct behavior
> -# - load an atomic replace livepatch and verify that only the second is active
> -# - remove the first livepatch and verify that the atomic replace livepatch
> -#   is still active
> +# - load two addtional livepatches and check the number of livepatch modules
> +#   applied
> +# - load an atomic replace livepatch and check that the other three modules were
> +#   disabled
> +# - remove all livepatches besides the atomic replace one and verify that the
> +#   atomic replace livepatch is still active
>  # - remove the atomic replace livepatch and verify that none are active
>  
>  start_test "atomic replace livepatch"
> @@ -119,12 +122,31 @@ load_lp $MOD_LIVEPATCH
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> +for mod in test_klp_syscall test_klp_callbacks_demo; do

Slightly nitpicky here, but the tests were originally written with the
livepatch module names via variables like $MOD_LIVEPATCH.  Would using
$MOD_LIVEPATCH{1,2,3} help indicate that their specifics aren't really
interesting, that we just need 3 of them?

> +	load_lp $mod
> +done
> +
> +mods=(/sys/kernel/livepatch/*)
> +nmods=${#mods[@]}
> +if [ "$nmods" -ne 3 ]; then
> +	die "Expecting three modules listed, found $nmods"
> +fi
> +

I was going to suggest that we might protect against a situation where
other livepatch modules were active, that a simple count wouldn't be
sufficient.  But then I thought about this test, atomic replace!
Anything previously loaded is going to be pushed aside anyway.

So maybe (in another patch or set) it would be worth enhancing
functions.sh :: start_test() do a quick sanity check to see that the
initial conditions are safe?  That might also prevent some collateral
damage when test A fails and leaves the world a strange place for tests
B, C, etc.

>  load_lp $MOD_REPLACE replace=1
>  
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> -unload_lp $MOD_LIVEPATCH
> +mods=(/sys/kernel/livepatch/*)
> +nmods=${#mods[@]}
> +if [ "$nmods" -ne 1 ]; then
> +	die "Expecting only one moduled listed, found $nmods"
> +fi
> +
> +# These modules were disabled by the atomic replace
> +for mod in test_klp_callbacks_demo test_klp_syscall $MOD_LIVEPATCH; do
> +	unload_lp "$mod"
> +done
>  
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
> @@ -142,6 +164,20 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  livepatch: '$MOD_LIVEPATCH': patching complete
>  $MOD_LIVEPATCH: this has been live patched
> +% insmod test_modules/test_klp_syscall.ko

Similar minor nit here, too.  If we think copy/pasting all the $MOD_FOO
is annoying, I am fine with leaving this as is.  I don't have a strong
opinion other than following some convention.

With that, I'm happy to ack as-is or with variable names.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

--
Joe


