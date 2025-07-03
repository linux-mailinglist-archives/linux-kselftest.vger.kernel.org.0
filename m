Return-Path: <linux-kselftest+bounces-36461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C6AF7D17
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915F94E6F82
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F52D3A86;
	Thu,  3 Jul 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNolMbEw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+PJjqBcy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCD236A70;
	Thu,  3 Jul 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558405; cv=none; b=DsnpmzbX/wSam+8MgUlwxlReGaRnqTLbkYu0N6HMDVCK+hyJlFs4BdHHSRUgfcct6ZMB+trxLxS2s1jmhmmg2V7oHA1k9enBlhUY+Htbx25ut3hT0yH/Xo54qKMolBxz1RjVOXnMsVJOiQ85zwn3ADZ6jxdyQqCMYjEGmz9T9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558405; c=relaxed/simple;
	bh=3Pj0427xdMZ4I26tk/jkLsUjXBeSTMEAHLv8oOJqYuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKgl8vlhfxghCelZTp2jNnLrsYpqsT0Z4ZcIIPpyKccstlGVp1D/uDZMmAovHbrCfUVs2P5z4bS4Lxm+heq/My2VcHQXaty16gs8ZJxNx/80rnO5Ao9QfdbKbHVc7Th8D2dYoBO1zYo+4o8z1wodmVOalTXqupGjzVND6p/yyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNolMbEw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+PJjqBcy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Jul 2025 17:59:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751558401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfHdGhts9p3gqu5lIIaqmscwxy1s8kWHcDGpikLQ3tA=;
	b=gNolMbEwCOCl4yMfeC/iBYFgUXptyQPBLssa09PXqJz2RbbIcf/S6akhWNaqPgdhm1V6Ul
	DX4ollftygERDLdRi0iunHcisvZi0sfLuc8mZoQ75Yx/SSqog2VTR7gMfkAQmhjtmS5JUH
	uTjp3iOMwnk8f/y3S8jz9M85OEF7yMKJQOQuEKJmyFcuRcRsaQ/n5/buUuYnLW5kGUqwbO
	/scb/zQT6O/4Ty8dIb98gWkUFqiKKKLNu9qLkufDN1Wg2LqLb8NuDkso2aOLFDzHpWQS0h
	3qoyvFzruOC4bKi4VIy++09MULhWe3GlnAzKoTbqRlAeO/oyVuZExImtGIUCPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751558401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfHdGhts9p3gqu5lIIaqmscwxy1s8kWHcDGpikLQ3tA=;
	b=+PJjqBcyqg/NfQCEreDNyHdRcqK4bgObWbiIPBry2m5lO9Y6u/e7h1bFDLZGgHc3b//iej
	BKTJKyZ7ULEMq+Dw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Rae Moar <rmoar@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org
Subject: Re: [PATCH v4 09/15] kunit: tool: Parse skipped tests from
 kselftest.h
Message-ID: <20250703175819-09e1d46a-ab23-40bf-a7cb-de191d81b154@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-9-48760534fef5@linutronix.de>
 <CA+GJov7HN_HTVOygyF6SW12DeghW6BYc4KxEz8Ktub=QBqv0oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GJov7HN_HTVOygyF6SW12DeghW6BYc4KxEz8Ktub=QBqv0oQ@mail.gmail.com>

On Tue, Jul 01, 2025 at 05:22:07PM -0400, Rae Moar wrote:
> On Thu, Jun 26, 2025 at 2:10 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:

<snip>

> > -TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
> > +TEST_RESULT = re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?([^#]*)( # .*)?$')
> >
> > -TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
> > +TEST_RESULT_SKIP = re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?(.*) # SKIP ?(.*)$')
> 
> My concern with this patch is that this makes the test number optional
> ([0-9]+) -> ([0-9]+)? for both the test result regex matches. But if I
> do pass in KTAP containing a line where the test number is missing, it
> causes the parser to crash because other lines of the code rely on the
> match with the test number.
> 
> I would prefer if we keep the test number as required. This is
> integral to the KTAP specification and seems to be largely shared by
> different frameworks test output.

This part of the patch was actually unnecessary, so I dropped it.
Good catch, thanks.

<snip>

