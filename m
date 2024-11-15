Return-Path: <linux-kselftest+bounces-22089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C49CDC39
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAA283094
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846E1B21B5;
	Fri, 15 Nov 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X3dWkFpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qR6LsGMN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcHcjCHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGMorJSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819F17E44A;
	Fri, 15 Nov 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665619; cv=none; b=SfI5bJtCuW1XczmzOIU4wogG6g6IfJd6L6u5yH7Jbc5rGdDkI+s7a/qBvz6O+b6mtWC4ZueiSW8F/GNfIfs5JMxMfu18zqMB8mY+qgoFfL+78BdwDeoyNu7IuPJlVNIf/BeWKOxYH3IiVVK/ln+m5oIezeLOfOPARRFTWB9DfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665619; c=relaxed/simple;
	bh=dllOzNYBZCycekP+E/MGT4e9VWkyWh/yT0kAE4dCQFw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hVP9wkcj7BDBvzI5thY3NFh0bL++5ikCjmQwtRlOxh9QGMmEznP30434uFHvIhmS4gpqp/DqfJDBtHpNbFqQ8Py1etV2KrZFOwqnpLRYaTl4oj4a+ugPUzrk0jAq91uweyc2OnUXyt180pUwQpLG+7MCbkXg+8EX/7gdxhojoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X3dWkFpq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qR6LsGMN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcHcjCHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGMorJSa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8912E21264;
	Fri, 15 Nov 2024 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731665615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF8NPKAP944NqrTfLoKuxMXQJTChdjIevG2xbsMT28k=;
	b=X3dWkFpqissXEX0/tk/C+3fApBuFaJMHKT/oLA7Yx04fPj89AbanRp8kH0JwsghTICmgDu
	sPJH4AFl6yIIhB4aGwSjaxJj3W6AvbDitpksfD/rQKlT3AeZjWCCQ2V5H8H+6n53avj/aC
	n3GX/lKUMzo8Jw6xGcx46eUJiwKdI28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731665615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF8NPKAP944NqrTfLoKuxMXQJTChdjIevG2xbsMT28k=;
	b=qR6LsGMNCDBV/LQf9WONK9wXinvk7IDkYWuZur59nEPfs1xGF5MIpOrtiNzDzTyoAgZ7qJ
	rrmVDYk2uK0iHqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731665614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF8NPKAP944NqrTfLoKuxMXQJTChdjIevG2xbsMT28k=;
	b=VcHcjCHG5uqNQRQKIGzmRVVEVv9LPBdMWjB723GBrmrBmURQforIjFXZXXTOkn+RQLYnC2
	sTiz+CCpUa+dxBP2rYsy6xzTcwHGvQoSjLpfxnSBNJz6sYY3YYYKjzjCm85TyoOMDUR1lh
	Ijr96X4fOeMg/+8Da873ZYt5cDolpQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731665614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF8NPKAP944NqrTfLoKuxMXQJTChdjIevG2xbsMT28k=;
	b=fGMorJSalk4gRP42ukuriysS434dzUJSNf8rZPQU2DXnlj1XstffwB4aZmUcgA4qJRWskj
	hA118j+uHTnTt6CQ==
Date: Fri, 15 Nov 2024 11:13:34 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Siddharth Menon <simeddon@gmail.com>
cc: shuah@kernel.org, jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    Shuah Khan <skhan@linuxfoundation.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH] selftests/livepatch: Check if CONFIG_LIVEPATCH is
 enabled
In-Reply-To: <20241106174120.5602-1-simeddon@gmail.com>
Message-ID: <alpine.LSU.2.21.2411151104500.5135@pobox.suse.cz>
References: <20241106174120.5602-1-simeddon@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.19)[-0.952];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo,linuxfoundation.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Wed, 6 Nov 2024, Siddharth Menon wrote:

> When CONFIG_LIVEPATCH is disabled, compilation fails due to the
> required structs from the livepatch header file being undefined.
> This checks for CONFIG_LIVEPATCH in order to verify that
> it is enabled before compiling livepatch self-tests.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  tools/testing/selftests/livepatch/test_modules/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

thank you for the patch.

tools/testing/selftests/livepatch/config contains

CONFIG_LIVEPATCH=y
CONFIG_DYNAMIC_DEBUG=y

I assumed that these prerequisites are respected but apparently not for 
building the test modules if I understand it correctly.

Is it possible to fix it in the way that the config file is respected? Or 
how do kselftests work with that?

Regards,
Miroslav

