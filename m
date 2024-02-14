Return-Path: <linux-kselftest+bounces-4676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA98855491
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 22:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFB1C20E90
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E613EFEE;
	Wed, 14 Feb 2024 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XNbIPGHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D913DBBC;
	Wed, 14 Feb 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945368; cv=pass; b=BYqH4MQU4w7iAbVTVnfgeg2I+QhJME2wsNUXc5izXfkcECgaAjYVfFom6DpW3T3Fk+uXgShfGGoXD2CC7a8AAYBFoRQ83Lt9qjmsTIYV4wWR8EyGM6sfsNiG+MYRFKQNRFo8Kb4/VRz7Ph93Zi3oswZ936Jl8xoLVmOQcqqbwCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945368; c=relaxed/simple;
	bh=32ZT+v+5JzF5aL7sf+dzxCe3Q4deHg+ix3PfzWTz9OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3Xj+Hp6CpBKcndjcsJfdLheynrrnFaEqwjBbtFku7HbgGCa2HD3/ICc3+ZFM/j4x5JsCcf22DvQ3WzXxmhEVfpslaQhq13J5RHL7TmGYiyWf9f6aDlqYxrMtEqh7gKtiMkXQfnOfZ1tvzOoAC3ey16yCfGZ3Cy2Lzdjs26y3ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XNbIPGHb; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D0BCC3875;
	Wed, 14 Feb 2024 21:08:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 07003C38E5;
	Wed, 14 Feb 2024 21:08:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707944915; a=rsa-sha256;
	cv=none;
	b=qW9q/dyfJcvz1Dzzm828vunpkgVoSSDgdgfU13G9Mn/EYyJq++eAChtrcWWXUbkHsNzE/T
	uq9t9J8YRSphbfTrL/fAoShJdZAyeUntCRPR17qXkdnqQg3igw+8uWvaYjs55eZZzMnh/p
	ALMJGD+7evhDIkwfOFm2SIA5VlNUkyO3DlWZPpU5AA74o3yKg36mF0j6/gF2Bk8aeVIGVE
	xodNr3kYwxVESTxXPBPuP/9sGWEi4s9LPWYytWapaaOxXL2/zY4Vc7EiQ2Z2aeE0R1Dmg7
	fxOctX4AvVBAJfzggK3Butr3gJBd2r/rfju1a9OktFUCLwt1aQhFBCAs+Is2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707944915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=32ZT+v+5JzF5aL7sf+dzxCe3Q4deHg+ix3PfzWTz9OE=;
	b=uVUz94c7ILK/FHJXkUSfxKuuZOkTvTg0V9UHXfoZgQ9yyC8BpVpfrz6yPgC6kD03eLmN7V
	zREhYP88Aa2r7ZnzOpsXHYcXmuUeXfOhcrMnemFQ0m3jDCgOFX1KDcuKkBmIVLdae3sapW
	2wwxt7YnO4qRsi11h3RermMwgCNxdqUKFd0dyuXiFjWgn/pqs+uFTnb72sQ5KilCGB8CW9
	xMSfAsop4lVu7sH8CN1sn8KE567bzXuOLci66LAkOLyqTI5rynDrLVUw08pB17xDgZSutR
	UbS779ITPxr7h+42xHszfgTX2MLV0nJ5Ed3FJuDAPdcA4nG2akNzQBUUWXjQjg==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-drw6l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Quick: 6b103d901e01a3c4_1707944915346_3956582227
X-MC-Loop-Signature: 1707944915346:1267690406
X-MC-Ingress-Time: 1707944915346
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.244.10 (trex/6.9.2);
	Wed, 14 Feb 2024 21:08:35 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4TZrQV296mz6x;
	Wed, 14 Feb 2024 13:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1707944914;
	bh=32ZT+v+5JzF5aL7sf+dzxCe3Q4deHg+ix3PfzWTz9OE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XNbIPGHbbg9Cr61Sb16Rbn0gyAMav+UymMelNSIV36MOITM/fp9aKFtXnaDek5LJO
	 oxvkIQ3D9AU606gK+EJvxjJ/HkW1D4btZn2EIxLCfC6+CLEU2osi4frVkH1XTQCM7L
	 NsOnehRrihNI/GqSeIsNA8XSe9bXLN3fxvN1r9nQ+z14bj6+/1N8ttWGV8frQC9KsT
	 ++XEg4vpubZvrl+EsbvX6nQph4YIjOyGOG7FKa/D4qvPD0JOSPTt1Bim3Xcn20jnEC
	 xPsMnLRCzgWpYjmYwToKXXw0zhqa2vxE2osc14AMVfCnw8vBtG0n8S+Nq4DeT7M59o
	 MH2n+0HDSzfVg==
Date: Wed, 14 Feb 2024 13:08:31 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	=?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: fuxex: Report a unique test name per run of
 futex_requeue_pi
Message-ID: <20240214210831.kzhrhqabot55llcd@offworld>
References: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
User-Agent: NeoMutt/20220429

On Tue, 13 Feb 2024, Mark Brown wrote:

>The futex_requeue_pi test program is run a number of times with different
>options to provide multiple test cases. Currently every time it runs it
>reports the result with a consistent string, meaning that automated systems
>parsing the TAP output from a test run have difficulty in distinguishing
>which test is which.
>
>The parameters used for the test are already logged as part of the test
>output, let's use the same format to roll them into the test name that we
>use with KTAP so that automated systems can follow the results of the
>individual cases that get run.
>
>Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

