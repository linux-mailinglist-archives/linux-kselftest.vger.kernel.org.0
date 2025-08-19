Return-Path: <linux-kselftest+bounces-39291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5ADB2BB01
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF417061E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496226F443;
	Tue, 19 Aug 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uotk7mVy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ra9AYyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694418DF89;
	Tue, 19 Aug 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589594; cv=none; b=IfGdv/O2o5FwfOhvbgjAkuzz/C0R9VVtrDnrOBqyg6uaiciUKExZ3GB3l0YEdYE6ypfbBwArDjX4ufHkfeJytAz1IVnsr3nsSGiirK7jHIYKO8IHeE4CsPJw7qBg9evygdZr8tq/HxtGlzKClR+agJKHMpmwe7fpsUoOv95LzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589594; c=relaxed/simple;
	bh=wJcSbSaH+PQefvs2XtBUEQXgTWu1o/uzSD/hJi/SAtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgoVgCBvyAzG5+OEHT+TjgnjRBPkxKGXtTHF9O3ve2t9QZ/JIBOO1lrg8vUNMypp4vbKC0gyYxjndvlPoxtnjBUyIIqmZ6tY72rZAk3erik6HNwdout7OSxdk7hYMcfEsn/iI1OJM37Td2FLMsBfFeXhQpgtzKn6cAWy9AMv0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uotk7mVy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ra9AYyB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 09:46:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755589591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njgvpH3ua3DuvP6DCxd0zfqMOwOEntgEDnP+hYudycc=;
	b=uotk7mVyTlTtX7wkSaVZaCIZgqtE7uADavG1Mot51HtP2ZChgxnvsYRV6sb3lhqwm/jKop
	SXDTqM72zLh5nXSd/UXJgzC5KfFZGk74S1Uun14irb5CHY+y5kqU4fRZ8SRNJDNmtur1DM
	UbSQve44AdCSiVZTIPiR1UYCc9aQ2HJTDSl906QTb8f5cpyydR58yY6Fq9ym14qej9pkL3
	ebwyne0LMt8a1RiKQOmzeVpn4XVFaofG7JuBhwxu48L/nq4DUH4drf/zbrLBsHNv4+bvq8
	ylD5XupCgfhgHh/D2rPVPp99qdWpA0E5KjCsVyp5CWr/VUvVfli4w+JL7cZBxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755589591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njgvpH3ua3DuvP6DCxd0zfqMOwOEntgEDnP+hYudycc=;
	b=1ra9AYyB2MDw6cq2SjWiOOP3FXT9ApBzurIZtTk8pM+Fzy4ss3AUKR+w7QUtSIoDV9MaVR
	UPFMht32eP0B+7Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/futex: Fix help test for option -g
Message-ID: <20250819074630.2xC2Waqo@linutronix.de>
References: <20250808112458.831212-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808112458.831212-1-colin.i.king@gmail.com>

On 2025-08-08 12:24:58 [+0100], Colin Ian King wrote:
> Currently the help text for the -g option contains a spelling
> mistake, a space before a \n and is a little hard to comprehend.
> Fix it.
> 
> Fixes: cda95faef7bc ("selftests/futex: Add futex_priv_hash")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

