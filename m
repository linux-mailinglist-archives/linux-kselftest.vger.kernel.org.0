Return-Path: <linux-kselftest+bounces-11342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A08FFDF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182191C234C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 08:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0B15B0F1;
	Fri,  7 Jun 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CgqFsdpl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFbr+qob";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bV0kaGCL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHJ2qv4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0015AAC7;
	Fri,  7 Jun 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748798; cv=none; b=Mn3JX3S/+WdPe320qwYRJk4vTO5D8yrF0lSUmLn5v2fHygDp3bvNrprtM4UtlKhH0+Hax8cVLPU6qvSBOlmUn16ujqTz6Rf6fczc8Rn+fbIzyIUKC2yYvCW0q0Z5U4nhfGVcjigM1e6zJB3l8L7TNSuAhF84rb8zKL7eqkuqsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748798; c=relaxed/simple;
	bh=izweJl01cfvuZrl5QoPNzU2bZiu04ECAvpb97T2e8+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oDJ/z8OVWPRTgHbgWRU9zUvhiQQ9zsZQbBugWxgWmJ0pGfI/hYBS8TLsNP7Y6YhYz5FfLt+ET9u4fqPS81KP8YiRNBpeSyAiHxgsxxx2NO23Czb3w0/V/nuVcEfb8gWnDG4eEsF+HDYsJNo8l7VJCpNDdGSSYYNGqwrFA7fR9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CgqFsdpl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KFbr+qob; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bV0kaGCL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHJ2qv4V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8A2F21A76;
	Fri,  7 Jun 2024 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717748795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K4nbpVbxr6IAJzN8S5PEK07maGVoKTCO7IaVjWMJY8=;
	b=CgqFsdplmAYdlmjeHV1wUix4FXVRpTdf+tB8GF71aND+VuecYNEM+uM4F39Nezmnf07JGo
	ywahJ36p/2CCoEELHn/LhDm+WkLFDiVOWxk0RpSDOrCNPSHKc3cLItPG9Sq2/o+OAyTecP
	QRn8dKwn1e5i36iNfU7ySNhTypzD4ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717748795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K4nbpVbxr6IAJzN8S5PEK07maGVoKTCO7IaVjWMJY8=;
	b=KFbr+qobwDtPnMeCgySooe72iMYNioeb30Y70R+0c/TVghH1TqRB7Qz+/25HvEseThFJD2
	yN497ak3A4eXYLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717748794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K4nbpVbxr6IAJzN8S5PEK07maGVoKTCO7IaVjWMJY8=;
	b=bV0kaGCLUOvFoGnob5z0Wm2Ok/gRHjTPWT+z9TIKDvDQlLJUK6hIZQ4DmVV7AY/pnQpJlP
	8ETVt+7Du0C5V0/hhZ4XOLWHiCiVF57H52SlfNtkVqY8iKe5r7aR/qWunEtGcjYf44tHK0
	wE91M3R8f12/D4g5fyKzNzmSPQU+dy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717748794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5K4nbpVbxr6IAJzN8S5PEK07maGVoKTCO7IaVjWMJY8=;
	b=gHJ2qv4VmCdtXaz/MrOQtKaprH0X28q91GKuPLGFZ3Lfx0SyqpO3OVAVJ020C4nRP+36fP
	2wBKYesQilgt2aBg==
Date: Fri, 7 Jun 2024 10:26:33 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
In-Reply-To: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
Message-ID: <alpine.LSU.2.21.2406071025160.29080@pobox.suse.cz>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.82
X-Spam-Level: 
X-Spamd-Result: default: False [-3.82 / 50.00];
	BAYES_HAM(-2.53)[97.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon, 3 Jun 2024, Marcos Paulo de Souza wrote:

> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes since v2:
> * Used variables to stop the name of other livepatches applied to test
>   the atomic replace. (Joe)
> 
> Changes since v1:
> * Added checks in the existing test-livepatch.sh instead of creating a
>   new test file. (Joe)
> * Fixed issues reported by ShellCheck (Joe)
> ---
> Changes in v3:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v2: https://lore.kernel.org/r/20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com
> ---
>  .../testing/selftests/livepatch/test-livepatch.sh  | 138 +++++++++++++--------
>  1 file changed, 89 insertions(+), 49 deletions(-)

with 's/addtional/additional/' pointed out by Joe

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M


