Return-Path: <linux-kselftest+bounces-30398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E4A81C6F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5191893CC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882D1D9A49;
	Wed,  9 Apr 2025 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b4noqCsk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9mSXyTV9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b4noqCsk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9mSXyTV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D611D5166
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Apr 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178222; cv=none; b=ErQXphOyBrdMqpJSwwqB0OaHu/1RrmogCdnCPVi/oNbGPwk5vcKmKErTwRm5cAIRbUkjMcXOW9foSEc59GI+E63Icn8c1hKPJakUqcBEeY94JUHhr1OPxTeGh78pZFPlSOHEPNr7TdU7EUjKYwyC5UzkTlVTTe5BD1D+CMilIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178222; c=relaxed/simple;
	bh=IDSG949iQP5auR/V2iZIwBW6D3hJ18HWvGAip58Rc0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikMljz9mQmkZzWGaimidaBtPTD7SkiYNvn8KGq9TZypgO39tjBQCzIOOdV+z86RhTZCnACHveNXgkk+hQiDVWpHQGptiSbnNB9AL14IvJKTZm+5QnHJgkliklOGs5fe7flBbPb3j8HSHR6b8T5CU2DZOyMHn9blO3rblCtBf53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b4noqCsk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9mSXyTV9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b4noqCsk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9mSXyTV9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F43E1F388;
	Wed,  9 Apr 2025 05:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744178218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SFS6ix8xTiG52yrxKF7w5NOgsptz1yfekx0SLzywe4=;
	b=b4noqCskonZ2iOECqsadq591Q5wsiNos8qxlFocsxYd6B7TUG3iCFMkOEc4lx4bKeWA2tp
	HeN7fyN0PeLqsae25dQEZuOcCBQ/H4BfcJPXKmeiB6pBbR7jD1OdQ7qF2x0l2XnV85iTPF
	5rh1TuDjLRJqe1oR4UfRlXZdDcGMUWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744178218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SFS6ix8xTiG52yrxKF7w5NOgsptz1yfekx0SLzywe4=;
	b=9mSXyTV9aE1zLE6guRekU/t/WXrtNDnCuUF6JBtLvXL9Rrl64TNgkfurQ2ZFS7D9JIY6DT
	h6BKQmzkuAWS1hAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744178218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SFS6ix8xTiG52yrxKF7w5NOgsptz1yfekx0SLzywe4=;
	b=b4noqCskonZ2iOECqsadq591Q5wsiNos8qxlFocsxYd6B7TUG3iCFMkOEc4lx4bKeWA2tp
	HeN7fyN0PeLqsae25dQEZuOcCBQ/H4BfcJPXKmeiB6pBbR7jD1OdQ7qF2x0l2XnV85iTPF
	5rh1TuDjLRJqe1oR4UfRlXZdDcGMUWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744178218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SFS6ix8xTiG52yrxKF7w5NOgsptz1yfekx0SLzywe4=;
	b=9mSXyTV9aE1zLE6guRekU/t/WXrtNDnCuUF6JBtLvXL9Rrl64TNgkfurQ2ZFS7D9JIY6DT
	h6BKQmzkuAWS1hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506F9137AC;
	Wed,  9 Apr 2025 05:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lsSmEioM9mdyMgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 09 Apr 2025 05:56:58 +0000
Date: Wed, 9 Apr 2025 07:56:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: lufei <lufei@uniontech.com>, viro@zeniv.linux.org.uk,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] unshare_test: set nr_open using soft limit
Message-ID: <20250409055656.GA231133@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250401015557.113872-1-lufei@uniontech.com>
 <8aa78b76-b9f9-4d23-a009-97b26aefcf33@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa78b76-b9f9-4d23-a009-97b26aefcf33@linuxfoundation.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

> On 3/31/25 19:55, lufei wrote:
> > Set maximum file descriptor number limit by rlimit.rlim_max than
> > nr_open(hard limit). Hard limit may cause dup2 fail.

> > Signed-off-by: lufei <lufei@uniontech.com>

> Petr, Al,

> Okay to take this patch?

LGTM, hopefully I haven't overlook anything.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI Cyril Hrubis suggested a different approach (for LTP tests which is based on
this Al's test):

https://lore.kernel.org/ltp/Z-u7yYJpTBG8Hi6A@yuki.lan/
https://lore.kernel.org/ltp/Z-vwYZxLms8juTjX@yuki.lan/

	filedescriptor that is >= 64 and set the nr_open to 64.

That would help to avoid using /proc/sys/fs/nr_open.

Kind regards,
Petr

> thanks,
> -- Shuah

