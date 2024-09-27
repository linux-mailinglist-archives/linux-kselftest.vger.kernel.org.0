Return-Path: <linux-kselftest+bounces-18469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D6988524
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F34528385B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B818C90A;
	Fri, 27 Sep 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvUIULog";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cik/fePL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCuqRX4H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CRtiyJUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687E18C35F;
	Fri, 27 Sep 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440872; cv=none; b=MBeaOaBQazkCRG3jH+TBt8ZWA03rYMYCl/VB7qf554jVyUYnOiXjcBX6oSz8p5kbDMgMesjiPJp0j8zytFKKnETaPpS3kB8pqD2rXV9eUkSNW3NN+E/QZremzFkYRvP1NyFwPuSiaC78YTLeQtkJRzZPiiKPAtnwSYX9iAWdYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440872; c=relaxed/simple;
	bh=UIFmOXWsUvsxNWgZC/Z2Cuq0RXOEbSONUdIW0wTM7Ig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CdXtZWYYkTtbXjBSM0xyBXvC6wwUDYxVL472a+40a81yUUi+0LGgYAvrAvJJ/pD6Z3jeM51IfqY6YAihXy2nwyXH3lt8FfXV0OJQxkXbTEtvH7QVUegUmICThNnnJaTlXt3GtqgEJX0fuQUHQrS+zuDDjMOMuj61oRTyl+nyHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvUIULog; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cik/fePL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCuqRX4H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CRtiyJUt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6B4621A9E;
	Fri, 27 Sep 2024 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727440869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrs3VcxAe9MTgTfxMXq61kMMwa35QVr50xqvHgWWAk=;
	b=wvUIULog+NF+GLJlMNMz/E4ZXtR0W4y6Y2G+2toJgJGD43DerM9m1WXhw4U84CRvjXFFHB
	7ar/29y2rBREF5W5JNqCDznpenvLthJqUSMP9MNgC113stpNiPPebzjUwxqXkchMXQbEc4
	HfYRvYMhbx4Sf64h8yXmvBqMRMg3WYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727440869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrs3VcxAe9MTgTfxMXq61kMMwa35QVr50xqvHgWWAk=;
	b=cik/fePLlRtZOOKiNECMV4Tlu6sS0Hpnm8mm6BINXlJcW2ac91SyU4/5sj9r0UAro45JLK
	TphvHDZZBWF/U/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727440868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrs3VcxAe9MTgTfxMXq61kMMwa35QVr50xqvHgWWAk=;
	b=XCuqRX4HTKnNBKW+m5RnoUwf4sntVx6DFOScmSwxJ3b9II5UOgvv8o+NXLBcDqV2sLqWKZ
	i61+PVxqtTdcT1knTgLnw9OhCB4Ff6i5smowh6Xr+8+JyLPwXBRuBJNqvLBU8sbW0jp7pN
	RodGTxhGHIQJP4IFYf3E8skR7GggmWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727440868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrs3VcxAe9MTgTfxMXq61kMMwa35QVr50xqvHgWWAk=;
	b=CRtiyJUtA70QqOmzJZZF7QHMLGnuPQP+zOUbRrjNtowrtQdhzkALPJaNJ51P7qXi3ErwIJ
	7dxtUgWHxd+wWjCQ==
Date: Fri, 27 Sep 2024 14:41:08 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to
 SYSFS_KLP_DIR
In-Reply-To: <20240920115631.54142-2-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2409271440520.15317@pobox.suse.cz>
References: <20240920115631.54142-1-mvetter@suse.com> <20240920115631.54142-2-mvetter@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 20 Sep 2024, Michael Vetter wrote:

> This naming makes more sense according to the directory structure.
> Especially when we later add more paths.
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

