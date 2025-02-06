Return-Path: <linux-kselftest+bounces-25897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6FA2A436
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14273A5807
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7214226167;
	Thu,  6 Feb 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TH0TLVUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BC215079
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834032; cv=none; b=H6Gidfzym6+pidEeSGuDus/QbvXdr0hzfbGLzQPlSVB1Gflsp2D9rld3peI8pGDSUA5kMcRld6DgpWynun3N2hPsy17y9dM7JCEJujB8FUL+VXJ2VOTm+FkTMqs4qo9LihavUHSjsxWcyZNeRZbxrI6tsVf7OaQjCv56w1Wdts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834032; c=relaxed/simple;
	bh=lP8L6P99Da7P5rOznCiD8xPrVuKAMRimkUUQabFUPq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSKrHtOa8aTHhMAp4uQSbYiN5GY76ULIJQi+gj75Ah+d3sM85XRjBqo7e4cN1VmiaEHw+Qmdm4MFRR87DbXAnIFubtOde0o0z70lqbBJd/D1UT6x9P3h10Rd3VkR44WdZN3K28Fs0er/ZEAKh392BD4Q7NiA0E8/0NuCByHJpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=TH0TLVUJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30737db1aa9so6370571fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1738834029; x=1739438829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lP8L6P99Da7P5rOznCiD8xPrVuKAMRimkUUQabFUPq8=;
        b=TH0TLVUJozoM+l8rA7x6uprvrppR9ob008u3V/WitQQISEizgqD5C0tis9Jupnx/b8
         0QEMp7hSmBeBCbBvEoMGoGEpb/tITgsUXcL6mpvMaxux7C9EeC1krxIBpe0nU+D1efGJ
         oW3uV4L1wRykG1IqzPFJcSxd56zNut41yKqpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834029; x=1739438829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lP8L6P99Da7P5rOznCiD8xPrVuKAMRimkUUQabFUPq8=;
        b=qRXOcdsGdWh8DvWaYFY9xWjGL9HuEzQ5WlTJK9jXekjyWEhvEeJagLMCm4yFZzHWDS
         w5Oj4LFjeGawhUw1cyn1hY+FybDnKAq+khgW4iIr/rq/iAfDgZGuXC/qjiODuVhRiDbB
         eJDtxUXc+2s3sBsFizqaHRnPIpAjyluRlCKwQoWCPyfczRvoibgtzneO9DnlsT3LFbfs
         wrS4lvOxQLxGJVpf2+q+th8EE9/+3lm6DRYw0aTQCDexDxLCXPXyQ8DedZZ5IbVrAbKO
         o26eg8oZ2vFIGRZiI1vxYX9oYSVKpdnQHAc36CbVxWF/wsWJRmpUpEePmwLazc6k5ET6
         8Dbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuftzoMbqqOsaDcrmXi0kl4lT8dqQBpbhMj/dwZaigbPPLexeEwtNlgpTWGu8IvH8w4wXTqGBBKMfEfA3n6wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymiSebA1WVBwZSG0Ww1mxt9gQ8vNnX5LMASGBnNdst6Q7arBE6
	jYl1rGMtS34VOo0W0VnqT3Mr9YqoowznsvzXuXfWUkeHAU6bI47Qh6Ib4AvvX1mPA7n08qaFVgK
	7Ds4XnJ4SFlqsb62icp0y8BU1q7lBU7mhYwt/3Q==
X-Gm-Gg: ASbGncvMbrWEv2I4EjX0vS+iN1yu7XodQoL1Db4/od31XQoxxdmL8rXCCD+AC7tKx60
	OsysTaUegM+1QaXi4MM5Jh87II53dTVUvxlUbXkrTYFOwdKxVXg351BPP/v8LLlnlUencobLJ
X-Google-Smtp-Source: AGHT+IHPnewXkffAiBGcrtmcy3j3cfhDwZ+2SPwIiAKww3nKVPkKcTuwbR6xs8hTWb+0K5c2LwrluhW6I8eg+D5eWiY=
X-Received: by 2002:a05:651c:249:b0:302:17e7:e16d with SMTP id
 38308e7fff4ca-307cf2e7ab2mr21136871fa.3.1738834029088; Thu, 06 Feb 2025
 01:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
In-Reply-To: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 6 Feb 2025 10:26:57 +0100
X-Gm-Features: AWEUYZnFSg2BHwTqUgiMh-7R8tClcKx1qxbeUbsIzoGqPOf06jI3u33zNtE0gIg
Message-ID: <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 20:36, Tamir Duberstein <tamird@gmail.com> wrote:
>
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and scanf), the rest having been converted to KUnit.
>
> I tested this using:
>
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
>
> I have also sent out a series converting scanf[0].
>
> Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
>

Sorry, but NAK, not in this form.

Please read the previous threads to understand what is wrong with this
mechanical approach. Not only is it wrong, it also actively makes the
test suite much less useful.

https://lore.kernel.org/lkml/f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk/
https://lore.kernel.org/lkml/876cc862-56f1-7330-f988-0248bec2fbad@rasmusvillemoes.dk/
https://lore.kernel.org/lkml/0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk/

I think the previous attempt was close to something acceptable (around
https://lore.kernel.org/lkml/57976ff4-7845-d721-ced1-1fe439000a9b@rasmusvillemoes.dk/),
but I don't know what happened to it.

Rasmus

