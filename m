Return-Path: <linux-kselftest+bounces-6068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BD8758FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C970B1C21930
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5B13A272;
	Thu,  7 Mar 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYc76VUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRD8VH7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D713A255;
	Thu,  7 Mar 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845486; cv=none; b=PNld7kMbVu/tIStNwcODto+PkFlIP9WYmsqLmIMyZ7Pqw8+1zB//XRMT9VqdCjKplwhHX9wcqtcqPvozJU19m/cDieaw4INHad/daNgnwrLr+tPczJmwEomCX/xL7kQRZ9ilRn/QqqXPQWXqbz96yZoVP7ZckzavJJxjaYOGMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845486; c=relaxed/simple;
	bh=irwc7n9Fn7k8csD71HYxmp14mVJDWO+UPLB37axRUTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LA5izax6CMB6pntNkCQkbnzgBiTZvynPYARakjCn4sXwTkLctl0SKUxi81OcBrJKa+fgGsP61uLexzyiLFgEdqsAOxZ5wgvaWeMYNYGIXCDqzDLPrLHzmvP20Gc+ZpyHujotjoa5ywBwujsQo4LW7J3fd5plYNWyodDx9FtTyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYc76VUm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRD8VH7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709845483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LVIIOYQF+Xj9JXb6Uk1sXoyVmnyzUgOoPIBozXrj+Y=;
	b=DYc76VUm9Z8gnsuG0HetpYINbA7LNe1YIpKVraPWsJ6N6TBY4o4FeS9ooQaceRIm5CmAaP
	8PMfZw0dvIkJU/h2eCQuHRlpmJY5PHwy00dYtYz1D4CF7QxTsJdISTINKyfMPdFY1Xk2+z
	qmej7rQz9m///EJA56OCWxGgEDPOYjdE0LJjRjPX1AS6EMtazc9AoB2nibNtVldq2D6/mf
	RNg01YTrWgltJXgabCaA/TUg6p7+fDbbTiHpZuorZEOW17QCTwbW50Ph3elmhq/PuX1k+1
	arvyicXKVuWU6CSsLCHcyaepOMj8eh8tB0uIt1N4+l03wBFAgMY47GqrpFDrrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709845483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LVIIOYQF+Xj9JXb6Uk1sXoyVmnyzUgOoPIBozXrj+Y=;
	b=gRD8VH7GeM5cw4yjMx0k5Ef7z6oT98kJysKk5IUEF4jFZLgx+nQJsTcbtIrgsIO2yIe1KJ
	vub3RkkwjTE9X6AQ==
To: Edward Liaw <edliaw@google.com>, linux-kernel@vger.kernel.org, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, Edward Liaw
 <edliaw@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/3] selftests/timers/posix_timers: various cleanups
In-Reply-To: <20240304181140.644212-1-edliaw@google.com>
References: <20240304181140.644212-1-edliaw@google.com>
Date: Thu, 07 Mar 2024 22:04:43 +0100
Message-ID: <87bk7pu51w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 04 2024 at 18:11, Edward Liaw wrote:
> I'm sending some patches that were orignally in
> https://lore.kernel.org/lkml/20230606132949.068951363@linutronix.de/
> to prevent the timer_distribution test from hanging and also fix some
> format inconsistencies.

Thanks for picking those up and moving them forward. Any particular
reason why you didn't pick up the full set?

Thanks,

        tglx

