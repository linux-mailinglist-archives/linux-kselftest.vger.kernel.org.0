Return-Path: <linux-kselftest+bounces-24168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ACAA083D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 01:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E118A188BF2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC7539A;
	Fri, 10 Jan 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="crfQ6j27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3D10A1F;
	Fri, 10 Jan 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467967; cv=none; b=IabiDVTI4So2SjJkF2JmzkU5m7Cwg/cCU6jFb22qg5LLM3QABGJnTWwwDCeg/xbJ4AJW0GEFBf3nXPnT1QYMSvEw7lD/W6QnpN67o9xLjAJfvxCeCp5w7krlpwmKDyoKnL6u3XK3G24B50KnJmVYcCrHagMvm6RKyHtcJdQzuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467967; c=relaxed/simple;
	bh=rDQeTjvQwRT/nd2YKdWqi0hN0vLQhu/Ejz9wMqiJcf8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=taQd5c8SovQJskOv2Fs3FN6Es6H1PvdAIIvV6+esNCKiVYfnyfs0IUcgmhvbRD+8gMLQtcF8RZdIjTmrg3Fma3sIeOjyfqzZNcW3lVfU5PqH/RAIqn6ok3kvQJGbp9+VJmOmCCxcuhDveJIeULIAoUEtiWTl3t9LCZ8GgcoAU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=crfQ6j27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE7BC4CED2;
	Fri, 10 Jan 2025 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736467967;
	bh=rDQeTjvQwRT/nd2YKdWqi0hN0vLQhu/Ejz9wMqiJcf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crfQ6j27WeD30Pi802j0+AyXq0ZC/rlOe0CWzx+J/JrxJkzPmNdBOl9okCHgB9LSi
	 5L6zS3AGRm7mhb0wcabOZGIGDobM1Py0faj9ri6mq5xuTBWIWoib4VZElMJCtNCw9v
	 0uNEpjQi4/BPkrkD4r4eljJBWYEWEKZFjCw1+hRY=
Date: Thu, 9 Jan 2025 16:12:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, Andy Lutomirski
 <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan
 <shuah@kernel.org>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse
 <jglisse@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
Message-Id: <20250109161246.f43a69773b5459e5200d3f45@linux-foundation.org>
In-Reply-To: <202501090949.793D9A0@keescook>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
	<20250109173842.1142376-2-usama.anjum@collabora.com>
	<202501090941.5289E7444B@keescook>
	<843bf743-4005-47bc-9e39-8ea49255b152@collabora.com>
	<202501090949.793D9A0@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 09:50:45 -0800 Kees Cook <kees@kernel.org> wrote:

> On Thu, Jan 09, 2025 at 10:48:52PM +0500, Muhammad Usama Anjum wrote:
> > For the all other case, why should we keep argv/argc and mark them unused
> > as well when they aren't being used?
> 
> I'm fine either way, but my personal code style instinct is to keep the
> "standard" main declaration with argc/argv present. But it's mostly
> aesthetic.
> 
> And if you think use of kselftest.h isn't universal, then perhaps we can
> avoid the macro, but it does seem nicer and more "normal" feeling for
> the rest of kernel development.
> 

Agreed.  __attribute__((unused)) is a bit of a mouthful and isn't what
the kernel developer's eye expects to see.  

