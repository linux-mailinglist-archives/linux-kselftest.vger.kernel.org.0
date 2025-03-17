Return-Path: <linux-kselftest+bounces-29186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AECDA64699
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB311893F66
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5382222B2;
	Mon, 17 Mar 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdmwEFVO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="34eQYoD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdmwEFVO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="34eQYoD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73447221F1B
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202481; cv=none; b=bYCNETCEp/+wsQnO0GhDdDGfX73n1qiCnD4IwQYZUaq4GEzVjld/GD0RFljgzTnwAjloGDiibueTeHjS3snPrg2Ozj+5xW7IaZ2M+t2TtOtiZxKpU40GXQh/FmEOD9/T9H8cld0eEOPNaSUxynmEQTFI5Cfr3TbqRIdCsw+TnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202481; c=relaxed/simple;
	bh=UgPBZvjsFQmiYNA6znXuMhzjQ271ggAz4JFSOSvqvZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T8mN6sSB6WpYLcuIbILpPLHEZvxQ8AnRZ35Gia/CtqmVYh9kxaQzkpYM3NY28Ezkm7MdH848QvH+Ou7g1eQ4dDfibLHwCBF26BT9OYupFm3E8eRoF7CzWMkZcakgkwJKMwwTGTZDFkuvnrCpvpVJeuJQBWXquPW0zPm2mkTMggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdmwEFVO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=34eQYoD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdmwEFVO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=34eQYoD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9C0321D92;
	Mon, 17 Mar 2025 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742202478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnKFNLrLhAN97UeP+wzQU9edyI2DXXEOjOLsBP6B4eQ=;
	b=mdmwEFVOvZgIbkhQEoa9slH513xeG7AGOURUICIl1Jp1Fdeh6vi5MxfuQG/2/rlt5ZrG4/
	Tf5ea1HCt/QclEZrMFSWgbmODsbF78/k2BaRnKOZCXfKo9EcPL3WpfEdj7aOUo2BODlNYq
	7e1qO1IA46lUQlj+Yp1PiVTnVtzAJRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742202478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnKFNLrLhAN97UeP+wzQU9edyI2DXXEOjOLsBP6B4eQ=;
	b=34eQYoD0Q40srGmeBJ5kuXok7ZTv2bSKWLuqtLeeouHNL9TsGu4KbnrWwBXioFteWi9ZfU
	JNZ5yfK6tXPri+Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742202478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnKFNLrLhAN97UeP+wzQU9edyI2DXXEOjOLsBP6B4eQ=;
	b=mdmwEFVOvZgIbkhQEoa9slH513xeG7AGOURUICIl1Jp1Fdeh6vi5MxfuQG/2/rlt5ZrG4/
	Tf5ea1HCt/QclEZrMFSWgbmODsbF78/k2BaRnKOZCXfKo9EcPL3WpfEdj7aOUo2BODlNYq
	7e1qO1IA46lUQlj+Yp1PiVTnVtzAJRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742202478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnKFNLrLhAN97UeP+wzQU9edyI2DXXEOjOLsBP6B4eQ=;
	b=34eQYoD0Q40srGmeBJ5kuXok7ZTv2bSKWLuqtLeeouHNL9TsGu4KbnrWwBXioFteWi9ZfU
	JNZ5yfK6tXPri+Ag==
Date: Mon, 17 Mar 2025 10:07:58 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Filipe Xavier <felipeaggger@gmail.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
    live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH PATCH 2/2] selftests: livepatch: test if ftrace can trace
 a livepatched function
In-Reply-To: <6d9b9394-690b-49a3-b8df-7ef510c96c00@gmail.com>
Message-ID: <alpine.LSU.2.21.2503171006260.4236@pobox.suse.cz>
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com> <20250306-ftrace-sftest-livepatch-v1-2-a6f1dfc30e17@gmail.com> <alpine.LSU.2.21.2503141411010.4442@pobox.suse.cz> <6d9b9394-690b-49a3-b8df-7ef510c96c00@gmail.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,vger.kernel.org,live.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Mar 2025, Filipe Xavier wrote:

> On 3/14/25 10:14 AM, Miroslav Benes wrote:
> 
> > Hi,
> >
> >> +start_test "trace livepatched function and check that the live patch
> >> remains in effect"
> >> +
> >> +FUNCTION_NAME="livepatch_cmdline_proc_show"
> >> +
> >> +load_lp $MOD_LIVEPATCH
> >> +trace_function "$FUNCTION_NAME"
> > trace_funtion() calls cleanup_ftrace() to prepare the test. Ok.
> >
> >> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live
> >> patched" ]] ; then
> >> +	log "livepatch: ok"
> >> +fi
> >> +
> >> +check_traced_function "$FUNCTION_NAME"
> >> +
> >> +cleanup_tracing
> > Here, I suppose, cleanup_tracing() is called to clean up after the check
> > above so that nothing stays and more tests can be added later. Right?
> > Would it make sense then to call cleanup_tracing() in
> > check_traced_function()? I think it would less error prone.
> > If needed, check_traced_function() can always be upgraded so that it
> > checks for more traced functions.
> 
> In cases where we need to check two or more functions with
> check_traced_function,
> 
> if there is cleanup_tracing, it will not be possible, make sense?
> 
> e.g: function1 call -> function2 call -> function3.

I meant... check_traced_function() (or check_traced_functions() in this 
case) can have multiple arguments. You would loop over them inside and 
then clean up. Or did I misunderstood?

Miroslav

