Return-Path: <linux-kselftest+bounces-20388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF89AA1E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338B2281316
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773419E999;
	Tue, 22 Oct 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcaosis7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWekv5ho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVKfW3fT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aThTYqFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6CA199938;
	Tue, 22 Oct 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598896; cv=none; b=hJ7Nzjv5VVDD1ottPknqqeOEGUDJMSWqK2l8zj8uuFHmxKmLIoiy5mems42cqLQs58WImEIzeisSjSoEhozTKESA7u0xutYH5DIzFvwU9IjPH27xQ8CEHup6FJOFFCOoI8hebYavpb6Piruy4FP7/VXfZhNZ0gZjczXlp23QJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598896; c=relaxed/simple;
	bh=BfHArBpJ/UL1oHni/v8tgLqXZHg75cxklG7eWDDiEOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EpmnI81r+2fIjo85iVs0DCbiPbWFYJ1R9Szel0h+Gc8LohhG017A1JkByRlRpRzKPSQue/i/1k2iFIZTGOzgQdoNiS/qTiPdhTOCACj3dBTZ3OIvq4XnQPvctox5fUomFWmajrCsu3+My3np2n9vYeoCYLLT37ayTNI+L+mSwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcaosis7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWekv5ho; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVKfW3fT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aThTYqFM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3939221C4F;
	Tue, 22 Oct 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsJ9+dT9qkqoIKboYtB7qSQeBE29M2adWLR8m1oaY+0=;
	b=mcaosis72jjgqGQMUHABqZen8b76vSpVUrjN3FzuLptjeOGTWRZkNuF2ny85AViJVux4D+
	YtCX4beJFLhppaPXIDaVrgACsGXGgu5GtnTq9q1QqOGW8M8BXhaRwCiRYe8dZAEUvSbnlj
	TJ0z370a9lSSSdtbp0cyzHMLqskiThc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsJ9+dT9qkqoIKboYtB7qSQeBE29M2adWLR8m1oaY+0=;
	b=yWekv5ho8n7TKEjYBY9sIkmadcmbCGpU+Nm77X6lmbVsPhJR1h5vR1Uw4aJNC4TEQKBjLm
	s7JopXRslF/xdECQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsJ9+dT9qkqoIKboYtB7qSQeBE29M2adWLR8m1oaY+0=;
	b=MVKfW3fTwuRaPx5hwxsWodlHLAe0aBoOmsZJ3Jw/wkxtkOW8whSQSnofBt4CsCHRvmEOKb
	juaBuk7LfiXypjUvQ+Tjgiw5Q2KpI9k9jJ8OtxNOsG4xhWYxq7JYLssnDBm+3yDjY1PrSB
	NmXtf2qAX+SL+8IwUqa9OoP25brR5k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsJ9+dT9qkqoIKboYtB7qSQeBE29M2adWLR8m1oaY+0=;
	b=aThTYqFMYn3lwZdo8Y17iZIx5fW/kpWnVOOhe9rRU1HOizvcR0iHZFyMc4FNX9W6efMF3w
	NKN9R/prWJ+ugoBA==
Date: Tue, 22 Oct 2024 14:08:11 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] selftests: livepatch: test livepatching a kprobed
 function
In-Reply-To: <20241017200132.21946-4-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2410221407430.13912@pobox.suse.cz>
References: <20241017200132.21946-1-mvetter@suse.com> <20241017200132.21946-4-mvetter@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,pobox.suse.cz:helo,pobox.suse.cz:mid,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 17 Oct 2024, Michael Vetter wrote:

> The test proves that a function that is being kprobed and uses a
> post_handler cannot be livepatched.
> 
> Only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be registered
> to any given function at a time.
> 
> Note that the conflicting kprobe could not be created using the
> tracefs interface, see Documentation/trace/kprobetrace.rst.
> This interface uses only the pre_handler(), see alloc_trace_kprobe().
> But FTRACE_OPS_FL_IPMODIFY is used only when the kprobe is using a
> post_handler, see arm_kprobe_ftrace().
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>

Nice test.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Thank you,
Miroslav

