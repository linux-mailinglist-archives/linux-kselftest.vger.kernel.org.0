Return-Path: <linux-kselftest+bounces-18477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA449885AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2349E28403C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3A18C90F;
	Fri, 27 Sep 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKB7Ma40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NF0xsi3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKB7Ma40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NF0xsi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371116D9AA;
	Fri, 27 Sep 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441686; cv=none; b=TeeVMzGOXsRtFYEpkTEH9HlQKQHpEE4TpDO1C15C97racLhNXwZzZeOTbTCNJiVLxgtal3c00O9qhCqa2QVmVjLo9q30b1ea1v8AX8mHPozKKKRhIbPZ3ViIwyVdNsUIHy9b7Nxer/DEwdocj1AKx9EzTlkLXxdgI6f8ny9o080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441686; c=relaxed/simple;
	bh=InK0PDJWlx6THXOea6wr9PRfOwmr38Y9USw+wLa2e+c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZxmBo70OatbelG+BI6KhGvuk1XLf11sKTItKXXwPPqi02BQ95kX4iu/NGIkDvssZvid8kte4HSuwMtxq+LpRImNrjeLBPyc31xOJ1ouHD5JPp4aCu4VSX9pT1wund9SHn7rTBK6/y005hk5r448TlgL480+AmcZSV2Ugu18xvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKB7Ma40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/NF0xsi3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKB7Ma40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/NF0xsi3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16A8121BC8;
	Fri, 27 Sep 2024 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727441683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InK0PDJWlx6THXOea6wr9PRfOwmr38Y9USw+wLa2e+c=;
	b=dKB7Ma40+Yo8V8o2fJihqQuaIGXVk12F9LSFifur9DTmtLUFxPEZaIMffaw50TXH97pae/
	KLzF/xkM7ZcUKTeGKhcqTPyO6VxBKE7kOKoBiWQiPbWe7LfBcFWdGJc0i13eqv7O4GoisX
	CLT8I8aYcTDQrELAQANRK+EYDVJBA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727441683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InK0PDJWlx6THXOea6wr9PRfOwmr38Y9USw+wLa2e+c=;
	b=/NF0xsi3NqgY44cZF6oiLYworOTahK7/ahcUsD3D3CyNdO3rnvGMLpap9T+EwN5WTrPWjt
	WzLODVapSOeBZXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727441683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InK0PDJWlx6THXOea6wr9PRfOwmr38Y9USw+wLa2e+c=;
	b=dKB7Ma40+Yo8V8o2fJihqQuaIGXVk12F9LSFifur9DTmtLUFxPEZaIMffaw50TXH97pae/
	KLzF/xkM7ZcUKTeGKhcqTPyO6VxBKE7kOKoBiWQiPbWe7LfBcFWdGJc0i13eqv7O4GoisX
	CLT8I8aYcTDQrELAQANRK+EYDVJBA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727441683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InK0PDJWlx6THXOea6wr9PRfOwmr38Y9USw+wLa2e+c=;
	b=/NF0xsi3NqgY44cZF6oiLYworOTahK7/ahcUsD3D3CyNdO3rnvGMLpap9T+EwN5WTrPWjt
	WzLODVapSOeBZXAg==
Date: Fri, 27 Sep 2024 14:54:43 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: livepatch: test livepatching a kprobed
 function
In-Reply-To: <20240920115631.54142-4-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2409271453340.15317@pobox.suse.cz>
References: <20240920115631.54142-1-mvetter@suse.com> <20240920115631.54142-4-mvetter@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.948];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Fri, 20 Sep 2024, Michael Vetter wrote:

> +# Kprobe a function and verify that we can't livepatch that same function
> +# when it uses a post_handler since only one IPMODIFY maybe be registered
> +# to any given function at a time.
> +
> +start_test "livepatch interaction with kprobed function with post_handler"
> +
> +echo 1 > /sys/kernel/debug/kprobes/enabled

opencoded here again.

The rest looks good to me.

Miroslav

