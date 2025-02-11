Return-Path: <linux-kselftest+bounces-26314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E35A2FFF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154643A3A24
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E713DDD3;
	Tue, 11 Feb 2025 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c0BlioY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89B1805E;
	Tue, 11 Feb 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236287; cv=none; b=cMsYnNxWi0zgHsVSDt2SI91idZ9zHsDiUsZWcErDSFpv/3z5nHNfZIS26SBYknqEAwQGfiGn5SRyPWe7ParE2XRlO/3YWaUL/V7pvz1E4VU9vLze46sjmHHNKrD/bRMZTGeXWmLBsvye/4WXELr2Yi7R4oqftqouSue/IVfMIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236287; c=relaxed/simple;
	bh=yoZGb2lKRHWre6AfmQNFLV+sf39nUuBFpE+2CI929pI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=to/TonI16Ib7z2bgY9aqKcUohcrADNuZ6Q2ZxlRYVKKGQTIekq4lQVdIy1B1l/NbhNy5RhXWnh6Cm4u7KTaaBBU5s3ZmhtjKTMbN8eEzy5a982tgWG45sJI6ya/V0syXyJ+OepTeux2pGB3r3dOUiZNElKeOQf6pCBG43MYhnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c0BlioY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D203C4CED1;
	Tue, 11 Feb 2025 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739236286;
	bh=yoZGb2lKRHWre6AfmQNFLV+sf39nUuBFpE+2CI929pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0BlioY1UYpCAx0luGWoqtFA+3CU9MBcJre6EzOfF8cU5zRh/QtHEh4F2foplzsaX
	 w7jVYQjrKL3xR8P49T/uQ9Oa3VtHMsQJIgq9QoOh20uUra9KVWWjRauYLEsIydFJ/t
	 aWXEN+FudKv+KNxbMm5EXt6RNi43sfT5ljsVKkqY=
Date: Mon, 10 Feb 2025 17:11:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Luis Felipe Hernandez
 <luis.hernandez093@gmail.com>, Nicolas Pitre <npitre@baylibre.com>, Rae
 Moar <rmoar@google.com>, Pedro Orlando <porlando@lkcamp.dev>, Danilo
 Pereira <dpereira@lkcamp.dev>, Gabriela Bittencourt
 <gbittencourt@lkcamp.dev>, Gabriel Krisman Bertazi <krisman@suse.de>, Shuah
 Khan <skhan@linuxfoundation.org>, Diego Vieira
 <diego.daniel.professional@gmail.com>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, Jakub Kicinski <kuba@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Vlastimil Babka
 <vbabka@suse.cz>, Bruno Sobreira =?ISO-8859-1?Q?Fran=E7a?=
 <brunofrancadevsec@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 0/6] KUnit test moves / renames
Message-Id: <20250210171124.9917819a078c16c6442480a7@linux-foundation.org>
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 16:31:28 -0800 Kees Cook <kees@kernel.org> wrote:

> This is rebased to v6.14-rc2. I'll carry it and folks can send me new
> tests, etc, as needed to minimize future collisions.

Actually seems designed to maximize collisions.

I'll drop ("lib/math: add Kunit test suite for gcd()")
https://lore.kernel.org/all/0eaf6b69aeb2fe35092a633fed12537efe645303.1727332572.git.zhengqi.arch@bytedance.com/T/#u.

