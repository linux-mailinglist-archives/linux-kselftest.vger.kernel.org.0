Return-Path: <linux-kselftest+bounces-15927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD795A6B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8A1281804
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6617ADE2;
	Wed, 21 Aug 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejr9qBOF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB813A3E8;
	Wed, 21 Aug 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276123; cv=none; b=EuB5l+/0z44QNXuQdsbU7OEZfxsVkO8kX+VX5hguFDPSwL23UvQZ/d+GMqCMWm4xDgDoBUYuNXxfASgRVGbZ3n2kJwA0+eI/M7w73CV9u1yY8BM0Bfi2cxg5eMMmOIEQXfgLwZjWZ1pMFdYGgQSSQ0Ehx3v2wf8AVJ+4Kznajbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276123; c=relaxed/simple;
	bh=qeg+C+K2iALtj/9Hv8kgdh54FyxhBs/z1HvvtBaf+rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8nZn7pAbNI3CyUsap+DtfxJ7HaPM32F2eCdzUcVK+YSk3tWy348qgkp7IWq6oyi7EVs9wZWlyhNb25IPg0Kk0AQ8yfY3F14JV1oqkOwM+NEDPbk0nzFNxkPy+/lcC1GY9AVdSIRslHDUy6RPOLkXDpreZ8ZkyQpqGGbFpeL+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejr9qBOF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so88397a91.0;
        Wed, 21 Aug 2024 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724276122; x=1724880922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiRWZencQ5BdanR4rXMdsAj10s77PTSt3pM/pTKZMVE=;
        b=Ejr9qBOFZX9n4UEMpeJnoZAlALsyaJizwZF4Og2DIMjQ/1LprFoElapkygzU9+Rgxc
         uPb9BiYGqlEEZWQs9PtxObY3cVtJPQ0lawGJ1hRS0I54D30qafa1wCA1A+8Lw4JSrA8r
         5zuL7cCUxDamFirHlRAN4irhIG2NOfPGLb/H5IvliRXy57U6HiCs5NX4lf4yXYs/JJOJ
         zNuUMSUyzqonaVYRwPoXjLA3+HPePNUbkqKfeQOOgusKG8tqgiei+xw5ZuGQGUjXaKw8
         r6nGmJzALf4Aiqzbpyqdbb+2VWSUrgM+39GXqtQMLV2iGueK9W8BU9SaepXKcimc880W
         KJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276122; x=1724880922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiRWZencQ5BdanR4rXMdsAj10s77PTSt3pM/pTKZMVE=;
        b=emB7nqTugqkn0jiDXhlSR6fuCl1UKlg2JykoFdiSrKQxxVN49lf3kkzLwBkWdy3ngQ
         SjzfePy4+7+Ylj/Xz3nQcqjH+dgBWYFXMuRu0jdxrut4mGo+WXGBHLPnovlyuuma7g6s
         9QnmiOgCRb5ah46ZQkTT0K9RQ0d/eMbtJHSOseVVsS+rM4Z5SL9mJl2gapoBTtXgJXzM
         mkSKWXj0cG+d7BtKDoyHKWv39oQwaIbFnCJDb+x+3r45uGz+mLXkt68NebdsO4YNSVTU
         eMFNzcGD/QktPKYHabnzshMaV7nb+WJeGcd1pwFL3c0N3W0suSIq63HNjZPW9ga7YhP+
         7GGg==
X-Forwarded-Encrypted: i=1; AJvYcCVEvUn6gloTRBZAmVEuTbEcEnxzfO/6T3IQ/gk6Ta8EOLauCrgPO8cIYNXb+z85rLMlkpUOpKwwE6y/N7o=@vger.kernel.org, AJvYcCVVF8Pj8fyI4iLDOTgmU2SLVpaVFyXK2CrFjCFhoDg+CW2RZwssvamb7bPBZFcO2f4TUbiqPcRUvckE3dOobmJT@vger.kernel.org, AJvYcCWqyeGfRAs51GdEfHmQm8gj3uQItf9fabV7gkesFHnbcH93pOYlYJdMJlJ7hEWiD4DdoXWKIeF9@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfFElmpKaQYkL0w2zySmU700ApxzZ/4evevBMI19uN57WoPUu
	38DjkFJY6WPkxqajP7xtHa0zh4scrNm47CKipY0JmugRvHekU2AhXniIJONTU13kNejWLkw23D1
	6yJ/10RDg7vl4KaOkAP5lmWr/Hkc=
X-Google-Smtp-Source: AGHT+IFfOCMcYuKg3u62U5RV7LxsvnfBktFhWYPB8QiK8juqSPZPmR9LoT6QV0wjI32HSOBoFlbgCnMAzBxyt9EFZr8=
X-Received: by 2002:a17:90b:813:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2d5e99cb1b9mr4078411a91.1.1724276121665; Wed, 21 Aug 2024
 14:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-2-7bd2e22bb81c@gmail.com> <20240821191004.GF2164@kernel.org>
In-Reply-To: <20240821191004.GF2164@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 21 Aug 2024 22:35:10 +0100
Message-ID: <CAJwJo6Zix_bkE38RmDW6ywojvmzeOuPVtwH+Jqqz6AT=6jmh5A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] selftests/net: Provide test_snprintf() helper
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Wed, 21 Aug 2024 at 20:10, Simon Horman <horms@kernel.org> wrote:
>
> On Thu, Aug 15, 2024 at 10:32:27PM +0100, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Instead of pre-allocating a fixed-sized buffer of TEST_MSG_BUFFER_SIZE
> > and printing into it, call vsnprintf() with str = NULL, which will
> > return the needed size of the buffer. This hack is documented in
> > man 3 vsnprintf.
> >
> > Essentially, in C++ terms, it re-invents std::stringstream, which is
> > going to be used to print different tracing paths and formatted strings.
> > Use it straight away in __test_print() - which is thread-safe version of
> > printing in selftests.
> >
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Hi Dmitry,
>
> Some minor nits, as it looks like there will be a v4.

Thanks, both seem reasonable.
Did you get them with checkpatch.pl or with your trained eyes? :)

These days I run b4 prep --check and on latest version it just gave a
bunch of fmt-strings with columns > 100.

Thanks,
             Dmitry

