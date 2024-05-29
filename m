Return-Path: <linux-kselftest+bounces-10835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D478D38A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2D2822A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18341CD2C;
	Wed, 29 May 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gxQnBgQh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jg6JtFYa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gxQnBgQh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jg6JtFYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57241BF3B;
	Wed, 29 May 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991539; cv=none; b=Kn0HQXrFbhFOHEPcmiT86pDh/HFUPmxK8hmqXAyQxBIN5OHWLtw0Y+aVygfDKIEk64s6kECCgnqTMwpFpAU4C0cI3JNQDLzZpcx7Mgo+UObNS+sdyMwlP8bq/mLqqtt6JZ1C+xYcBvqDO5V9AcajOaotEjNEJasuEbgl3ixBMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991539; c=relaxed/simple;
	bh=EXhy7Y0Mf45o5EJir2NiWLb5gdZ7rsjUh8NPftXsJow=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PB1m1ZqUpg3yzFH8a1ilOUXhmlw/eDqE7S1bIMUC43irQgD0ijyXHRq5kPLnuZbvHzUsKyJwPRO9/viHkcQCI0wwPU08VSgPmmxXamfup2yWxHr/9jOaClhFRpKr1a54+eUCC/BNe9vG4sg4fXpJXLSMjTaasrn6S/Q3dwDDU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gxQnBgQh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jg6JtFYa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gxQnBgQh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jg6JtFYa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A615336AF;
	Wed, 29 May 2024 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716991536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g08lDbPcwFQ8xueoQtCrEiFoHfACj1CSYR+KNNv+rMU=;
	b=gxQnBgQhL4HkNjTak2bPFeBqDyKa6HKwDD64Hb/vi8YwyJn4yE4LnDJgWLjVyMmJEko6zD
	U9s9wzyG3ZbcejYjL6cHY9lZQijApHmEtfC+ROU5kSK0oDBDMn04zvpGe3ry3bYC1o1HCN
	1HBSqpxHQNkgJPlZoyIfZN0r0cMwUKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716991536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g08lDbPcwFQ8xueoQtCrEiFoHfACj1CSYR+KNNv+rMU=;
	b=jg6JtFYabPnoubKactJdtDdpnEmpjWiYk1QHerLv9exgjvH6ECp0gQRVF08SYZrI5wMlZU
	yevDfrkVJQ/YXvCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716991536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g08lDbPcwFQ8xueoQtCrEiFoHfACj1CSYR+KNNv+rMU=;
	b=gxQnBgQhL4HkNjTak2bPFeBqDyKa6HKwDD64Hb/vi8YwyJn4yE4LnDJgWLjVyMmJEko6zD
	U9s9wzyG3ZbcejYjL6cHY9lZQijApHmEtfC+ROU5kSK0oDBDMn04zvpGe3ry3bYC1o1HCN
	1HBSqpxHQNkgJPlZoyIfZN0r0cMwUKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716991536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g08lDbPcwFQ8xueoQtCrEiFoHfACj1CSYR+KNNv+rMU=;
	b=jg6JtFYabPnoubKactJdtDdpnEmpjWiYk1QHerLv9exgjvH6ECp0gQRVF08SYZrI5wMlZU
	yevDfrkVJQ/YXvCA==
Date: Wed, 29 May 2024 16:05:35 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
In-Reply-To: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
Message-ID: <alpine.LSU.2.21.2405291601040.9680@pobox.suse.cz>
References: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 25 May 2024, Marcos Paulo de Souza wrote:

> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index e3455a6b1158..d85405d18e54 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -107,9 +107,12 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  
>  # - load a livepatch that modifies the output from /proc/cmdline and
>  #   verify correct behavior
> -# - load an atomic replace livepatch and verify that only the second is active
> -# - remove the first livepatch and verify that the atomic replace livepatch
> -#   is still active
> +# - load two addtional livepatches and check the number of livepatch modules

s/addtional/additional/

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

