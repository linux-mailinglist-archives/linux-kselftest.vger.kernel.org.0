Return-Path: <linux-kselftest+bounces-20386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACC9AA187
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777361F239AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863819CC21;
	Tue, 22 Oct 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDwyxCNv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZGUMA4I2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bij662Zk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VmYygXF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF319AA53;
	Tue, 22 Oct 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598214; cv=none; b=ndrrqRPx9rNBb8X4077ZE9M+uaJ4syUA+aQxd5IjX0isRAoMue/q3E8HKiUijaUv4yBzwOLhAL81Ezjwe7B/80JmXOzw9QODsb31teZWFWuFcgQh7iXWDEte/di1YvRtfGUIYNwX5GqHaTFq8PQIQYIa6f3DDECzM5kxXUB9q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598214; c=relaxed/simple;
	bh=mneF1aYI+/3E7kfrtRg3xECSKw4MZRU4SWtMWjJrKK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KsTHNuMGg0N98zDCsFop5M2+L/iP7zwQdGRtDJ7R/yeipfnMXbCnhGJ6mse+yE3IjXxVt6WDO91hhiji+vWS6hWrCsU26iNRa2BlZPBZkEA1/V8i9afafhhVtBzinep7CWvnUb9EmypnVmNN2l7FCj/PvDIFUmnpxzfzeo+H4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDwyxCNv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZGUMA4I2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bij662Zk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VmYygXF7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F65121BBA;
	Tue, 22 Oct 2024 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9S2ssDExBIzpSbGz4cukm9iZBCMafEuEs4DF3aW+pQ=;
	b=mDwyxCNvHJeGPUrfC2BkzXiOaJKwCzstsPET/WqUvtd8mD50aG9tcJLxfD/W8wPbQspuOS
	i2lT08pXLO1BnN5oqAHHhUyIHr2J/CMqBibireqoxPzxV5IElVPSeUitcTi64Q9n9qwYX1
	sbssqKq0xFLudxE/YnCQdjuRRsdYpik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9S2ssDExBIzpSbGz4cukm9iZBCMafEuEs4DF3aW+pQ=;
	b=ZGUMA4I260rhdarGfqE1BPJ1op1+JflIfZUjc9Vi12O5bo9EaJuvsd4KDKLcXtbVWveEae
	T83BcknEYM+oVEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729598209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9S2ssDExBIzpSbGz4cukm9iZBCMafEuEs4DF3aW+pQ=;
	b=Bij662ZkHWfKiH5+bxU7Bd5b9Ej0lUP83+SsclpqVhtSCxbG0Op9dDwYDI7jghlrAroCse
	0JSzsl5z3qYgburOR15GqlJsbr9djKU3gXL/BQixfPOOsWEQ3Z1XcfJR3rhXmEtArnFuYZ
	5Q2k3MJFIRH87bOTYJCIrO/K0UEk+QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729598209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9S2ssDExBIzpSbGz4cukm9iZBCMafEuEs4DF3aW+pQ=;
	b=VmYygXF71+YTb9XqqC2jmBcSFKGQqlfuGbj5ne3Ynq4oo8LQUhmcxAeI2xSVLZT50EM1X4
	IfJaXrBmElr+vOBA==
Date: Tue, 22 Oct 2024 13:56:49 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to
 SYSFS_KLP_DIR
In-Reply-To: <20241017200132.21946-2-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2410221356180.13912@pobox.suse.cz>
References: <20241017200132.21946-1-mvetter@suse.com> <20241017200132.21946-2-mvetter@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.994];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,pobox.suse.cz:mid,pobox.suse.cz:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 17 Oct 2024, Michael Vetter wrote:

> This naming makes more sense according to the directory structure.
> Especially when we later add more paths.
> 
> Addtionally replace `/sys/kernel/livepatch` with `$SYSFS_KLP_DIR` in
> the livepatch test files.
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

