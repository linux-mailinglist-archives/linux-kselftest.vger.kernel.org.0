Return-Path: <linux-kselftest+bounces-27260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D2A40757
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049AD3B001F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A13207675;
	Sat, 22 Feb 2025 10:24:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD4205E2F;
	Sat, 22 Feb 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219885; cv=none; b=GTDTbL9aDbQn7mH12V07XOcC9hV/g1evVeGmRCdS6MX0mepOOpixcjD0SoQPYB2mlKddfKLkHcNZMZ1EDPPIUwiejndV4eHE/N7UJ5IbXLaICS7v+bpBlWWsiRyv/S7XwoeOGYC9GjLQfy2iZf6oX4bwtMZ227VjHI0ninLT1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219885; c=relaxed/simple;
	bh=q002xTAonhKK9lzADPJJAP3eRqDllXsdNS3CGjJMB8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPcW0C5RfLQ5dolDx3Zl5fBUfIlJoRzV56X6GI5azQMyN+wWRZpGc1qM6R/7XNLa0TVh9EfqddmWPyk4/P6hb2fadOVTGU3uSyv5IK/Z5kMgYeeQ1BQQS1Qq39L4EMqZ276g9eQTSScbwg6iPbRTqzX5kNUg8r43UZNfQ4o/hBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51MAOQHv014812;
	Sat, 22 Feb 2025 11:24:26 +0100
Date: Sat, 22 Feb 2025 11:24:26 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 13/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Message-ID: <20250222102426.GA13708@1wt.eu>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-13-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-parse_vdso-nolibc-v1-13-9cb6268d77be@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 03, 2025 at 10:05:14AM +0100, Thomas Weißschuh wrote:
> nolibc does not provide this header, instead its definitions are
> available unconditionally.

Please think about reminding which one you're talking about so that a
simple "git log" shows what header you're talking about (limits.h)
without requiring to also see the patch itself.

BTW, I think that limits.h is common enough that we could probably
provide it as well with nolibc to ease porting (and the current patch
is a good example of this). Maybe it could simply start by including
stdint.h to provide the various limits we rely on. I remember that in
the early days of nolibc-test we had to exclude it as well for nolibc.

What do you think? The less we need to patch programs to insert #ifndef
NOLIBC, the better.

Cheers,
Willy

