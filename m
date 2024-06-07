Return-Path: <linux-kselftest+bounces-11344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B38FFE62
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3090A1F287A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495E15B560;
	Fri,  7 Jun 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7oFaJcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oh1S/sbw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7oFaJcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oh1S/sbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADC15B96F;
	Fri,  7 Jun 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750216; cv=none; b=do/nAl0hUtr1mcMVWuWLSM80Zbb1d+A5tkkqwNCs27YRosCCxc4kKo+7sUao+g11rwqQjcRMRlAv+xD61OIUkAWt/zKGrE39M+S0BhwzBoyFxBu14NgNNNUw0850i6PhIxDD7QnNF1HuwLeKrPQbJoh6r7qxhoCN7lFngD6d80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750216; c=relaxed/simple;
	bh=xXWAMq1TN1qL0sjXz2pm6pfBpLz5T6IDYD3I5lZGAPs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JDZ1LDcxOp2If4p6IODMr7BwOsG36X9N+45Nez4s/6zLU87xmJuZE7XhMKbu9U2PPyZyXiHJtAaYFWiFC73VsU/IOwbsWXOrVfjCucpn80NAOBghsNW8NbbRREAYYz7jk61tsGOZLn/v3UvB3QTv2F0J0Rcv1T1F1LCLQHcSrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7oFaJcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oh1S/sbw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7oFaJcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oh1S/sbw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 312D721B37;
	Fri,  7 Jun 2024 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717750207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WySfIkrdFUzVMysnegvmaTbNgtbzTvDeDSIeqhgNmJA=;
	b=k7oFaJcqrcGnLJlXjHd7r7UNx2NgIFUvVtA8YU9kMpBx2xeLAM5MEn/C/ynUFrGE6zrZUe
	lkOvsUg//sBwrZbQKElZsxCHH2zqZIXts8hz6FBB8yvxFo/4OyPyh2UQiLZnXoeAEgC4R7
	+saiQqxaaW0e273s4d8IyR45XlELNqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717750207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WySfIkrdFUzVMysnegvmaTbNgtbzTvDeDSIeqhgNmJA=;
	b=Oh1S/sbwhNpahTZVO7Nl3fozPDeFH9Xi5OpiNVysSQxPkRyUcoX8w1r+Egpsr7jCMMltIA
	rl5rXcsJbnvNqABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717750207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WySfIkrdFUzVMysnegvmaTbNgtbzTvDeDSIeqhgNmJA=;
	b=k7oFaJcqrcGnLJlXjHd7r7UNx2NgIFUvVtA8YU9kMpBx2xeLAM5MEn/C/ynUFrGE6zrZUe
	lkOvsUg//sBwrZbQKElZsxCHH2zqZIXts8hz6FBB8yvxFo/4OyPyh2UQiLZnXoeAEgC4R7
	+saiQqxaaW0e273s4d8IyR45XlELNqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717750207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WySfIkrdFUzVMysnegvmaTbNgtbzTvDeDSIeqhgNmJA=;
	b=Oh1S/sbwhNpahTZVO7Nl3fozPDeFH9Xi5OpiNVysSQxPkRyUcoX8w1r+Egpsr7jCMMltIA
	rl5rXcsJbnvNqABA==
Date: Fri, 7 Jun 2024 10:50:06 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Ryan Sullivan <rysulliv@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, mpdesouza@suse.com, jpoimboe@kernel.org, 
    jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: define max test-syscall processes
In-Reply-To: <20240606135348.4708-1-rysulliv@redhat.com>
Message-ID: <alpine.LSU.2.21.2406071049570.29080@pobox.suse.cz>
References: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz> <20240606135348.4708-1-rysulliv@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]

On Thu, 6 Jun 2024, Ryan Sullivan wrote:

> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M


