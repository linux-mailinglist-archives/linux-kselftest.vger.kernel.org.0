Return-Path: <linux-kselftest+bounces-20387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D459AA1B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39901C213BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7E19CCF3;
	Tue, 22 Oct 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WdkLoBmM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PnTWB7A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WdkLoBmM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PnTWB7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3919AA53;
	Tue, 22 Oct 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598767; cv=none; b=NDG+M0wEuV65E7orYhxqdsnM5Sbs5G3E6HP+UhaOLrNmiNF7CqL2mq5KlxA9l29NOuFZKVJX+sbsZjVrJy0KoP3lfZrJFCeU5QrjFbAC85YUbXfUFo7ozCTWV3d9ffjNnlVx5EIOzcFApVdVT7fLzI2vUOaBDIIaYQRNVNOofDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598767; c=relaxed/simple;
	bh=LRqjz3NatrCHcOfmFjBEesLgu+Ndn6WCqSp+YVoZ2WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LFru2mpV9mmUrJTgTJf9nu53VGqh/hpozhwalxudT5FjlUbEA6GD6YKsIOx5sPBuOTWOnS0QsboePakYSQvlcHNAkxq478sPUA7U8RBLD9s0pUc8I3CVABCRgGTO1fOy4eS3G+3Zsuh6QqDYxlzzoqikRPkJLmlVLAYMjQdcC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WdkLoBmM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PnTWB7A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WdkLoBmM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PnTWB7A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83FFB21C4F;
	Tue, 22 Oct 2024 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMaP/CFNdvyZjyzA58TZniyqyn1l4/23UXh+C887wxU=;
	b=WdkLoBmMbS3bghpyLQ2T2ppT6LINGNwMLV9yemcITmhIWcrgMp9Ub1957/jRTcj3uHtp/Q
	etbY8S1LiK/AWrM6a6Y4si76BLTYiexK1I6raI5hQnPAV/7dsLzYrM78yrNmaxxmn3Az3q
	mZzvYFY1t5n4tV+/jbEVvb1SFyHHfvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMaP/CFNdvyZjyzA58TZniyqyn1l4/23UXh+C887wxU=;
	b=1PnTWB7AoH5Cer+lBkQnJHgfReNt6BmZEBf9o+e2dEqxyz/VVYDbMqceQfAKf+n1Lntup0
	e9U90VN+9ZdMppBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMaP/CFNdvyZjyzA58TZniyqyn1l4/23UXh+C887wxU=;
	b=WdkLoBmMbS3bghpyLQ2T2ppT6LINGNwMLV9yemcITmhIWcrgMp9Ub1957/jRTcj3uHtp/Q
	etbY8S1LiK/AWrM6a6Y4si76BLTYiexK1I6raI5hQnPAV/7dsLzYrM78yrNmaxxmn3Az3q
	mZzvYFY1t5n4tV+/jbEVvb1SFyHHfvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMaP/CFNdvyZjyzA58TZniyqyn1l4/23UXh+C887wxU=;
	b=1PnTWB7AoH5Cer+lBkQnJHgfReNt6BmZEBf9o+e2dEqxyz/VVYDbMqceQfAKf+n1Lntup0
	e9U90VN+9ZdMppBg==
Date: Tue, 22 Oct 2024 14:06:03 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] selftests: livepatch: save and restore kprobe
 state
In-Reply-To: <20241017200132.21946-3-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2410221402420.13912@pobox.suse.cz>
References: <20241017200132.21946-1-mvetter@suse.com> <20241017200132.21946-3-mvetter@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid,suse.cz:email,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

On Thu, 17 Oct 2024, Michael Vetter wrote:

> Save the state of /sys/kernel/debug/kprobes/enabled
> during setup_config() and restore it during cleanup().
> 
> This is in preparation for a future commit that will add a test
> that should confirm that we cannot livepatch a kprobed function
> if that kprobe has a post handler.
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index e0e7f8db894c..e78e0e16ad4d 100644
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

there are still two occurrences of /sys/kernel/ in test-syscall.sh which 
can be replaced with $SYSFS_KERNEL_DIR now. I suppose that Petr can fix 
that when applying as well.

The patch also contains two separate things... the cleanup and the kprobe 
state handling. Ideally, it should be split but unless someone else also 
speaks up, I can certainly live with the current state.

With that

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

