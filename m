Return-Path: <linux-kselftest+bounces-2915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC682C2EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F1B23942
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4408F6EB5F;
	Fri, 12 Jan 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EOMgwZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3jYSW8/u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EOMgwZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3jYSW8/u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCD67E95;
	Fri, 12 Jan 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C578E21E10;
	Fri, 12 Jan 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705074033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBHakYrvA9JjjAAFKEiWxZ2a5n/TKBm4bbM+4W+LYI8=;
	b=3EOMgwZDDNmEEkU2hAvq8hlcuma3t3apHPDzoCAbnJpMV2DeOHfOdyFFTfJ+V7ISywqnVP
	NTYA0cyCflxkRTC/FuZ41eLXBx6Axrw4EaHbSqGwSkY54cUFTsmaGQ/bIHKzOkIEGZGMKx
	g/QGFm1cDtPzsFWUgLHDagQKUm4SW3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705074033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBHakYrvA9JjjAAFKEiWxZ2a5n/TKBm4bbM+4W+LYI8=;
	b=3jYSW8/umOSp/Ci1GI34yYNEM3J469I0YfucTAftP3UgJyLtQKzXmGK76/23UYeflJIY1u
	vquuUomU1vR228CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705074033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBHakYrvA9JjjAAFKEiWxZ2a5n/TKBm4bbM+4W+LYI8=;
	b=3EOMgwZDDNmEEkU2hAvq8hlcuma3t3apHPDzoCAbnJpMV2DeOHfOdyFFTfJ+V7ISywqnVP
	NTYA0cyCflxkRTC/FuZ41eLXBx6Axrw4EaHbSqGwSkY54cUFTsmaGQ/bIHKzOkIEGZGMKx
	g/QGFm1cDtPzsFWUgLHDagQKUm4SW3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705074033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBHakYrvA9JjjAAFKEiWxZ2a5n/TKBm4bbM+4W+LYI8=;
	b=3jYSW8/umOSp/Ci1GI34yYNEM3J469I0YfucTAftP3UgJyLtQKzXmGK76/23UYeflJIY1u
	vquuUomU1vR228CA==
Date: Fri, 12 Jan 2024 16:40:35 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
    Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] selftests/livepatch: fix and refactor new dmesg message
 code
In-Reply-To: <20231220151151.267985-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2401121639580.26925@pobox.suse.cz>
References: <20231220151151.267985-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[37.98%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Wed, 20 Dec 2023, Joe Lawrence wrote:

> The livepatching kselftests rely on comparing expected vs. observed
> dmesg output.  After each test, new dmesg entries are determined by the
> 'comm' utility comparing a saved, pre-test copy of dmesg to post-test
> dmesg output.
> 
> Alexander reports that the 'comm --nocheck-order -13' invocation used by
> the tests can be confused when dmesg entry timestamps vary in magnitude
> (ie, "[   98.820331]" vs. "[  100.031067]"), in which case, additional
> messages are reported as new.  The unexpected entries then spoil the
> test results.
> 
> Instead of relying on 'comm' or 'diff' to determine new testing dmesg
> entries, refactor the code:
> 
>   - pre-test  : log a unique canary dmesg entry
>   - test      : run tests, log messages
>   - post-test : filter dmesg starting from pre-test message
> 
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Closes: https://lore.kernel.org/live-patching/ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M

