Return-Path: <linux-kselftest+bounces-8012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D98A59D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED51F23044
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097E13AD0E;
	Mon, 15 Apr 2024 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dev3Q9U6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CE13C91A
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205294; cv=none; b=aKpmHx1pGYNLJJqm1saXdYXFLeWOwKZpZk+Y7ooKilqKUaGrn8oJ/JznA7y5TPfRvRvArutrV6jGoV6WZAUZlSStvR5daRsBz93CAGQtFt3hgsj11YH+87bufydje0sKPPmPa6kRNH5uQwcF5NrqSymuZjDxnVC5UslJ1eM7XyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205294; c=relaxed/simple;
	bh=umxCZeWTQDH3zMqqM6T6ZP1c8rPGI3duZNpIriEi1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTfBh3VcFSrJ4j1LGeLdhKF3kenL6tzdmh6YZaMN8XAbljhK+tGUTN6Faqz5diHPuUgGm54Db9+jTZG8BjHWvcMOW3aOsDZzgcyNt1k30ZRFitUQ6Fyip61hDD4xxq36njEqzpiSr4vcKj6NQefDKZJupQYTS4ZZytGqJH5BSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dev3Q9U6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5171a529224so4476121e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713205290; x=1713810090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=Dev3Q9U6dmX6v6OzlaIWAqGZiFlGAPqpDUfWzg1j6yNrBSHfQcy62zz+7XHqLED/hZ
         CULwX6srrQoCH27AW97FN24nPMgsherSHNkwv8SApphzm1nxTCYVwAzIer7iq4yLOpep
         ha357bAe/4SWiYbkhqOU66SngXp2KHzZcdfiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205290; x=1713810090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=MgdJQZ9jazul7WFiGy2RNeTHRvAdOjOJvpabtR6j9DPYQUFAA7bPBapzTWgxPURu9O
         sM2H1fiKCd/NBYXKZ9Sz3AnDwAqSYEHu4qDWeiWXsnphhDMO9Krz7du3Uv3gJWO2XH6p
         ngxAGquK0eGrrX2B3ra6tDDCzh+E6dftk1eSSJ5htyAFjRVTJXHdRyLM48lSZlAKy3cW
         0kW4+ycCYz5P4knsqYZeQUdaAogjiUXGaa/oIpMFs7aNKxEgW7tP2g1JESzvudD+/cc2
         Kgeu8JjyU8vVAMIVRACXgGiOgpNklV3AoNJArn9GtBN9ROcQlXJcyEKwUzextfXlWEyQ
         NNOw==
X-Forwarded-Encrypted: i=1; AJvYcCWHLoEx7pw9jpFk4bxhFzqRiG8uuvhj4jdYb+KtIcxliUPyKH/ZEKqnwGPFknbUPvKW+ZSzfV5zwuR1DIGZ8wmhdr4fmn3CqyHRvLkVBgZ4
X-Gm-Message-State: AOJu0Yz0V/rHucsbkGILGyTwGeBNuHWcH7EFuZ2q8d7YX2hRUBh2OvD9
	ROsOQMgMOBRhp21fqrZa4wTprwXR7+2EyiiH2bLs51VPIkX7RNLqYUJeF6QJe2yz5IycwpmsxE9
	u6KGbrw==
X-Google-Smtp-Source: AGHT+IG6eiEcWuYXwl3GNxt3FFVLM3LALDZ7O+iGQVvJQ02fepxLoHoeiUjpf5dR09j9ARBUHwtxJg==
X-Received: by 2002:ac2:47fb:0:b0:518:b58c:522c with SMTP id b27-20020ac247fb000000b00518b58c522cmr3520640lfp.50.1713205290051;
        Mon, 15 Apr 2024 11:21:30 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id p32-20020a056402502000b0056bfca6f1c0sm5115902eda.15.2024.04.15.11.21.29
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:21:29 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso503517766b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 11:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXXF+5cn8Tk90sjE3C85E/3D15AlGmH6KP8v384IChw/u9xQWduxqg01LiS6DtKveS9TBwxFKNXa0GhWQF/P94+3N9u38LPpNshmwbu1Zt
X-Received: by 2002:a17:906:110e:b0:a52:320a:6320 with SMTP id
 h14-20020a170906110e00b00a52320a6320mr6421452eja.51.1713205289339; Mon, 15
 Apr 2024 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-2-jeffxu@chromium.org>
 <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
In-Reply-To: <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 11:21:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] mseal: Wire up mseal syscall
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 11:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> It isn't logical to wire up something which isn't present

Actually, with system calls, the rules end up being almost opposite.

There's no point in adding the code if it's not reachable. So adding
the system call code before adding the wiring makes no sense.

So you have two cases: add the stubs first, or add the code first.
Neither does anything without the other.

So then you go "add both in the same commit" option, which ends up
being horrible from a "review the code" standpoint. The two parts are
entirely different and mixing them up makes the patch very unclear
(and has very different target audiences for reviewing it - the MM
people really shouldn't have to look at the architecture wiring
parts).

End result: there are no "this is the logical ordering" cases.

But the "wire up system calls" part actually has some reasons to be first:

 - it reserves the system call number

 - it adds the "when system call isn't enabled, return -ENOSYS"
conditional system call logic

so I actually tend prefer this ordering when it comes to system calls.

                Linus

