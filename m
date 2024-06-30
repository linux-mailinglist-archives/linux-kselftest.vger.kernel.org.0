Return-Path: <linux-kselftest+bounces-12971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2A691D24E
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708DA1F2130E
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32014B953;
	Sun, 30 Jun 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1rCNtp+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B763D966
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760800; cv=none; b=K9EUfkV4v9ObDp8UqUt0MvYVhrIdxhAvHBNpI+Zw0tD+VQE4iT5VqAd2rkfPwaSBrengo1Wd4eriZjremVYtvZ5ycu20rXS4aZ2HPoMPhRoKXCgBiwC5rT2+J1SV3PEPgv2n1ixgVYekc5knK/6q4VmECxmdw42Za4cK0s9FonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760800; c=relaxed/simple;
	bh=y0GCV1s7z5QcjuCuXrZ65YOxUbYQxD7IzeF/Mo2/6Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu1GLD5ezhHbodayJDEo47ccPYnguxUnUT5vg6nys0fK2Iewc0EeyVNTFrnCRztDkiJnywxRy6hKQ6WiEIUcKBP/3MRdJTHE3WNE1UQtt4HeV05rrpZA14DiyY9H4iS2ZIqnB/4qPiRJF9f1J/OhnmZKG5+A7KIMPvihSymrthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1rCNtp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719760798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uw60rNCpwnr0C3iThEmSKSDPQVzVdj9gxMj7KcciDY=;
	b=N1rCNtp+UzTTm3Z39VBO+ZJ4r/9t4qtM6iphZsq90lFlMLGTzUJSUkjtA0rPKqE/7QgYzM
	tzQFG8W466Uh5L265iJBuIL7nsdePASfxyJ9/jtRPINCSl3QrDBb+pJjrzmtqYWEkgfcJw
	jLh4Px0X0DQnH6VqnOpm6VMnUyP7u7I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-kbgdXdslNjSRwvgoGPAgqA-1; Sun,
 30 Jun 2024 11:19:52 -0400
X-MC-Unique: kbgdXdslNjSRwvgoGPAgqA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B3819560AA;
	Sun, 30 Jun 2024 15:19:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C951D1956089;
	Sun, 30 Jun 2024 15:19:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Jun 2024 17:18:15 +0200 (CEST)
Date: Sun, 30 Jun 2024 17:18:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <20240630151808.GA13321@redhat.com>
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627035215.1527279-3-dev.jain@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I see nothing wrong, but perhaps this test can be simplified?
Feel free to ignore.

Say,

On 06/27, Dev Jain wrote:
>
> +void handler_usr(int signo, siginfo_t *info, void *uc)
> +{
> +	int ret;
> +
> +	/*
> +	 * Break out of infinite recursion caused by raise(SIGUSR1) invoked
> +	 * from inside the handler
> +	 */
> +	++cnt;
> +	if (cnt > 1)
> +		return;
> +
> +	ksft_print_msg("In handler_usr\n");
> +
> +	/* SEGV blocked during handler execution, delivered on return */
> +	if (raise(SIGSEGV))
> +		ksft_exit_fail_perror("raise");
> +
> +	ksft_print_msg("SEGV bypassed successfully\n");

You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and check if
SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == NULL.

Likewise,

> +	/*
> +	 * Mangle ucontext; this will be copied back into &current->blocked
> +	 * on return from the handler.
> +	 */
> +	if (sigaddset(&((ucontext_t *)uc)->uc_sigmask, SIGUSR2))
> +		ksft_exit_fail_perror("sigaddset");
> +}

The caller (main) can do the same rather than raise(SIGUSR2).

But again, I won't insist.

Oleg.


