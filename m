Return-Path: <linux-kselftest+bounces-10995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4B8D6032
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A81284228
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC9156C7B;
	Fri, 31 May 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nq+jkujc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IC/gf8bv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nq+jkujc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IC/gf8bv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291F156672;
	Fri, 31 May 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153524; cv=none; b=o5DWRdpQujz4eJVaVEqQHtHV9sySCPbOuiGPs+LpFhB7VkC/IajI/frNRtUVb7W2XDNdlzEdNXcptIbaNwACm/Iapn61+8qOApor8ye0fcwG4mX23gGDNpmVBzGHw7sSnuICr1qg2mCFHZ1ykKiyIvgyj5I7YHQWwK1v0Z6COUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153524; c=relaxed/simple;
	bh=0nEKGRG72PKIONgf+4q/o8b0GACuYDObhxKdXIZhjp4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u0bWSbxjQyd4WCPX1gMdpaztBR0CqSBIqdmoJJxDJsVFS3CP8pzsAithH1sSSN6k/fMF7Eun4rwO76Snq4Heb2a7GKvEqkNz2an73mUchEBE5W3Jwn7zDpEvW869nOPJ0brG4NU/FgdNNC/mq3Z6BXtY7H7L0z2oC2FFaZ77ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nq+jkujc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IC/gf8bv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nq+jkujc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IC/gf8bv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 768DF21B80;
	Fri, 31 May 2024 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717153520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFFyCrFbyEWDoo3J5YoxcpAHtW/B9fBZJZkqRpwz8RA=;
	b=nq+jkujc9BksOE+gGBDmqvrD/FErd/o96IZrmN4/UYYSpKVVksHT3a0tw14AlmNIst/HEY
	JkhaS/DP0puyJQH+KuNP05cZ6ox5eCLc8DBo9MG3PDMWjMPb+mSjUs510QDlqmZ1ZC1BFY
	28XqyqBQgSdwiQWxCnvDiZWf5Pfy6CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717153520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFFyCrFbyEWDoo3J5YoxcpAHtW/B9fBZJZkqRpwz8RA=;
	b=IC/gf8bvJ7tHcQTSv+TFpf5prOkR3avJ/NykjmlnJU9vOb+miuYIsDn5nQXRFNruaEFVsd
	RsrzpzcxQ09QjeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717153520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFFyCrFbyEWDoo3J5YoxcpAHtW/B9fBZJZkqRpwz8RA=;
	b=nq+jkujc9BksOE+gGBDmqvrD/FErd/o96IZrmN4/UYYSpKVVksHT3a0tw14AlmNIst/HEY
	JkhaS/DP0puyJQH+KuNP05cZ6ox5eCLc8DBo9MG3PDMWjMPb+mSjUs510QDlqmZ1ZC1BFY
	28XqyqBQgSdwiQWxCnvDiZWf5Pfy6CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717153520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFFyCrFbyEWDoo3J5YoxcpAHtW/B9fBZJZkqRpwz8RA=;
	b=IC/gf8bvJ7tHcQTSv+TFpf5prOkR3avJ/NykjmlnJU9vOb+miuYIsDn5nQXRFNruaEFVsd
	RsrzpzcxQ09QjeDA==
Date: Fri, 31 May 2024 13:05:19 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Ryan Sullivan <rysulliv@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, mpdesouza@suse.com, jpoimboe@kernel.org, 
    jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/livepatch: define max test-syscall
 processes
In-Reply-To: <20240529201941.13968-1-rysulliv@redhat.com>
Message-ID: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz>
References: <20240529201941.13968-1-rysulliv@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.24 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.15)[-0.742];
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
X-Spam-Score: -4.24
X-Spam-Flag: NO

Hi,

On Wed, 29 May 2024, Ryan Sullivan wrote:

> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

a nit: we usually use just "selftests/livepatch:" prefix in Subject.

Acked-by: Miroslav Benes <mbenes@suse.cz>

M

