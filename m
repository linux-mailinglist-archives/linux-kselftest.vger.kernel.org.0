Return-Path: <linux-kselftest+bounces-39293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C2B2BB30
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CC3168406
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B143112D8;
	Tue, 19 Aug 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjR3Zvgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6SN7b+rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3881732;
	Tue, 19 Aug 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590116; cv=none; b=LoDxLhQr0UJsTjUyyUbqYmbsL6rPABRhAlHejRDPXO2a5NEhtxUB1HwJhrt0bhgBJmDdhT+e5/3jA4EbOsPWzC6jfIZbcv9h+xy5NjID0J33BU++jpbFI9XT7CfsrYm5X+RrNlBdQ2aEzO6UZkKODPAIR+eoe+bzMDH8XCoFBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590116; c=relaxed/simple;
	bh=HzxKLm0RgQoT2US6l5pneSyB6YLbN/GFCcKarA4Fxt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS9gujj9OKyl39SvSic3ULNhPWMtln/85W12NXmdrIbCkSQvupSEo//DDJOQU92nOBKcqKxpZHXcZ+6xGGFLqmVOGJraBPy1gwhFAC9RdszQ48OMdUseewsfD6pnK2qFnw/hwkx8Kud8MCzqg8KB12hhHcncdVHkx1ogVnBnjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjR3Zvgz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6SN7b+rr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 09:55:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755590113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3B+0G0YRkyoQ+K/Z1srwXYL2NkxF7r0p54dZMCXk9g=;
	b=CjR3ZvgzpmbhQTI2CGLc3vNBgUZmQbvNSW+IipIUrgebEqMbJyWMda6GsAYgjWr1MHmQIx
	wg4leSiFxFe7WoRdLUKUQQhVl5B4VjR8Y4xCt5j/NtoELL1KmLg1OD9B+wdItie30iRkiM
	ALVLIKvgMUodtI/5kUkzwQ4l6ups7rsKaqVLHjMLn7KX+aKTMhPv3IRGUMIa+RaNBNdYFZ
	E/sidnAMe8GO8zb2Vvc9b3TvM6jhTmXyJsl46EQ6rXX/mEGWtvP82C20Et4kffyG3uhCeE
	wg84XLoHukzXGB1azMclXu0UesW/k3nhU2Zgd7p5lp9vGwSG/MOWnaZmrvE6zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755590113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3B+0G0YRkyoQ+K/Z1srwXYL2NkxF7r0p54dZMCXk9g=;
	b=6SN7b+rrsrNq/FaTC99wYXaH/Y7Gbot/0sRgWfMnKIRA8wMZoGiodVIEbyN+Tm9ezpEdHO
	cB+8hGLWEgf/bUDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/futex: fix typos and grammar in futex_priv_hash
Message-ID: <20250819075511.6mHXEwdt@linutronix.de>
References: <20250815093942.8595-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815093942.8595-1-krishnagopi487@gmail.com>

On 2025-08-15 15:09:39 [+0530], Gopi Krishna Menon wrote:
> --- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
> +++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
> @@ -115,7 +115,7 @@ static void usage(char *prog)
>  {
>  	printf("Usage: %s\n", prog);
>  	printf("  -c    Use color\n");
> -	printf("  -g    Test global hash instead intead local immutable \n");
> +	printf("  -g    Test global hash instead of local immutable hash\n");
>  	printf("  -h    Display this help message\n");
>  	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
>  	       VQUIET, VCRITICAL, VINFO);

This hunk is addressed by 
    https://lore.kernel.org/all/20250808112458.831212-1-colin.i.king@gmail.com/

the other are fine.

Sebastian

