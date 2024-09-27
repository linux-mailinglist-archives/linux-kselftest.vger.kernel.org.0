Return-Path: <linux-kselftest+bounces-18471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA3988576
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632FE284C78
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0018C01D;
	Fri, 27 Sep 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mud4mNe7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZS0sg2o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mud4mNe7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZS0sg2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07D185931;
	Fri, 27 Sep 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441344; cv=none; b=Iq7uZO7IWZAc6wQahDm/kNG3IICYUsPP+yCrgLwH0vjZKYJ/vZnmpIPiMgSfNzJk+z5z9r0vRsyOQ7uBKOA7qqd45V5NCJsLGt0MLYXT95iVSCrw+6dL45QiXNZPcqk4oStjkTTvjWT8Pth0YcOQ5W0dYLSpbnOefa/Kx3WvA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441344; c=relaxed/simple;
	bh=+7iaIZO96eO3T7bArZenn8Z39jrA4m7mqea7DmPvADg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qfHOUEEN7iXa9+iShJ2eHTKw/bgtPfZ3MqXzbtygP0TIjVYSn94Q5zOgAtutvUtdbRQYFTiBoRYGqTULf9SV+PglKf7N6lmyXmLqxOyDfCL50c+dAtVIeMOIyd8ceVdYW35i4Ld9vsv2Iijiegct0Zk4SaJ1uA0Us33iqyNBlyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mud4mNe7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZS0sg2o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mud4mNe7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZS0sg2o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69E462190C;
	Fri, 27 Sep 2024 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727441341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6rhHq9cJ7Weusaf2FOwzw/13pEzSW1cNDEfSg43wtc=;
	b=mud4mNe7GtGhvuSQFNd8jN0Q24DnJoGSf+IUrwHgJnsXyj1BA1yK7n+mPxWYsn4FuNkgeJ
	2ezxnlKflcPOPGW6ab3ZNJ4Y2gFGukpyWot/B9CUQ9asUMcGGKu5fhDTeXPlBOTm8tvrcn
	YcXswrxI5ES6xtUTXjT074a/akhUcL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727441341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6rhHq9cJ7Weusaf2FOwzw/13pEzSW1cNDEfSg43wtc=;
	b=nZS0sg2oyerMOz4HFz3TAgZlF2hSqB2Fg4m43ahEkJ3dP6O175GNDToe0yewuh3/6QD0q4
	abNuLREF8k+27uBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727441341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6rhHq9cJ7Weusaf2FOwzw/13pEzSW1cNDEfSg43wtc=;
	b=mud4mNe7GtGhvuSQFNd8jN0Q24DnJoGSf+IUrwHgJnsXyj1BA1yK7n+mPxWYsn4FuNkgeJ
	2ezxnlKflcPOPGW6ab3ZNJ4Y2gFGukpyWot/B9CUQ9asUMcGGKu5fhDTeXPlBOTm8tvrcn
	YcXswrxI5ES6xtUTXjT074a/akhUcL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727441341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6rhHq9cJ7Weusaf2FOwzw/13pEzSW1cNDEfSg43wtc=;
	b=nZS0sg2oyerMOz4HFz3TAgZlF2hSqB2Fg4m43ahEkJ3dP6O175GNDToe0yewuh3/6QD0q4
	abNuLREF8k+27uBQ==
Date: Fri, 27 Sep 2024 14:49:01 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] selftests: livepatch: save and restore kprobe
 state
In-Reply-To: <20240920115631.54142-3-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2409271438130.15317@pobox.suse.cz>
References: <20240920115631.54142-1-mvetter@suse.com> <20240920115631.54142-3-mvetter@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Fri, 20 Sep 2024, Michael Vetter wrote:

> Save the state of /sys/kernel/livepatch/debug/kprobes/enabled

I believe it is /sys/kernel/debug/kprobes/enabled.

> during setup_config() and restore it during cleanup().
> 
> This is in preparation for a future commit that will add a test
> that should confirm that we cannot livepatch a kprobed function
> if that kprobe has a post handler.
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 50361fceff06..6684c01c0567 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -6,7 +6,10 @@
>  
>  MAX_RETRIES=600
>  RETRY_INTERVAL=".1"	# seconds
> -SYSFS_KLP_DIR="/sys/kernel/livepatch"
> +SYSFS_KERNEL_DIR="/sys/kernel"
> +SYSFS_KLP_DIR="$SYSFS_KERNEL_DIR/livepatch"
> +SYSFS_DEBUG_DIR="$SYSFS_KERNEL_DIR/debug"
> +SYSFS_KPROBES_DIR="$SYSFS_DEBUG_DIR/kprobes"

Personally I find this harder to read but it is a nit and Petr asked you 
to do it, but

>  # Kselftest framework requirement - SKIP code is 4
>  ksft_skip=4
> @@ -58,6 +61,7 @@ function push_config() {
>  	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \

it stays opencoded here and also elsewhere which is not great. Could it be 
consistent, please?

Otherwise I would just squash the patch to the next one.

Thank you,
Miroslav

