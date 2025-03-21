Return-Path: <linux-kselftest+bounces-29561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402BA6BB7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 14:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4F7176970
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F922A4EA;
	Fri, 21 Mar 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfMHJWgh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/aYrDIf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfMHJWgh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/aYrDIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DD228CBE
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562790; cv=none; b=rWfYkqqhtcCC5/lVHNzZ0kTBK/90FOpbeVuzdQmlS2WbSlhU6QbSG2F93yqPe79ljZE192wDkJpEL6y7e54leBWH1LDsPHaMhjHp4BDBwgm6Js5mML0KhA2Db7mi0HFM6fjAFRMwWn78MiONjaax3Tl7pyndRf8DGQUtcAOlLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562790; c=relaxed/simple;
	bh=myxFxmWfgAaw5W5xyI0IBJVCHz9jurtAEGnFUOEwHFk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HOVW1T0HoSuOdj7wBLqFRiSgrVRVOQDZeYzZxCE59aXzfdRYkNuj6b4gbW1k9+j4ENgiXfWMZd1+kW2fnNBJNbQhQBdcp2VumsEUnwu49/gcbZNSaUMNzCnVsaSpyo8SkjYUCbnWpT1sfVzJ3r5Wb2OYGTE4G36dl1RN7KspHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfMHJWgh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/aYrDIf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfMHJWgh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/aYrDIf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 335F521B7A;
	Fri, 21 Mar 2025 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742562782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnNudQNwYrh4P9QBPumKXRNgfzxFcX63UX/KJSI7PC4=;
	b=gfMHJWghMw29PICV0RYynLCRpA4HzmW2YL/UI+1XjPI91mrDOqikdjk1+iWps+dERsu6r0
	C7GgXjK/XQAIu/+UcZc9/oGbkJMgVUt/UMrSpRPSMM6OAzMOtApk87i2rcnoOgWaZDH6pJ
	LlU6YJ2hyIqFWtNxSW6m6hmif8Ata9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742562782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnNudQNwYrh4P9QBPumKXRNgfzxFcX63UX/KJSI7PC4=;
	b=U/aYrDIfYeWgBU+0SjRGcMYPP6aVDq3jtEegXIhSndsdE+8tB9lSYmX5uy+sVOXbU1j8G4
	O8z/p9QGob97GtDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742562782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnNudQNwYrh4P9QBPumKXRNgfzxFcX63UX/KJSI7PC4=;
	b=gfMHJWghMw29PICV0RYynLCRpA4HzmW2YL/UI+1XjPI91mrDOqikdjk1+iWps+dERsu6r0
	C7GgXjK/XQAIu/+UcZc9/oGbkJMgVUt/UMrSpRPSMM6OAzMOtApk87i2rcnoOgWaZDH6pJ
	LlU6YJ2hyIqFWtNxSW6m6hmif8Ata9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742562782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnNudQNwYrh4P9QBPumKXRNgfzxFcX63UX/KJSI7PC4=;
	b=U/aYrDIfYeWgBU+0SjRGcMYPP6aVDq3jtEegXIhSndsdE+8tB9lSYmX5uy+sVOXbU1j8G4
	O8z/p9QGob97GtDQ==
Date: Fri, 21 Mar 2025 14:13:02 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Filipe Xavier <felipeaggger@gmail.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
    live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v2 0/2] selftests: livepatch: test if ftrace can trace
 a livepatched function
In-Reply-To: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
Message-ID: <alpine.LSU.2.21.2503211412390.29639@pobox.suse.cz>
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,vger.kernel.org,live.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 18 Mar 2025, Filipe Xavier wrote:

> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Suggested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M

