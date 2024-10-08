Return-Path: <linux-kselftest+bounces-19252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620B9955CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C5EB23598
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72B20ADC7;
	Tue,  8 Oct 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e44s/QOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2220A5F5
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409068; cv=none; b=etKzdQXJZwezKXnUfdoU4/RJGTsOUQMpYY/LbYvVlk5d+2bPL8ZdHdR/FYvUA+h3EpEeGNlolRdBbRhITWy3ODecWuyLoJdwVsq4/f1HF8GaXu8jFK70UVBGBKHmb9ycJeAOJTMB8P7K864s69ppJhus91e+/uXvdTCDG6NnaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409068; c=relaxed/simple;
	bh=Guj7TfV3TcxARKzx+rJNwO0C0B4eZgbfH7Q0kiMwybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjBk6Aa+uW34O0/87VW3FdSBJKEOKnkRZnEZ6/w58Gz+vUrluyLBPD9HyXYT2MzV7eysDEGkdO/GQhyx1i/fXPAdKdDu6zLLAYaYlLuEWFeRBuQrfRmrFEHQgEkTfVjaeyi/277+d0Vt5mtn9aEJiK839dHkphM7mFYyWqX6lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e44s/QOh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4581cec6079so23021cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409065; x=1729013865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zafKKPAnf6wRyGI9fM/mWrAHSuYDFy9rvx6KAYkSotU=;
        b=e44s/QOhIDS5hpV7eBaL9yw4hsLAFsCOhVCo/3Ee/hbWZq+0Hh/En+6gxSkqkXfz8u
         fxI58WTL6/0Q1gkB2PF3RZpl1oRV0idLVbu2hT43QxDS3kdqUqOjE0RzoOkcY0sypj1m
         7Rx7z06uI6C+B9QELyLa9lRKp8WpBFKkq5ZDRl+wxxrpOZduVl0z/pRZo9KHIYtyllH9
         L18nMuJf3oeM7WoB2lfsSNxWCIE2Gt/dLmxgA1bOT/rmzD3NQiuHcDeoFCgohGmZxXxe
         rKCcqU1NgiCynGMQ6NnBA1nBYpork8QDYWM1rfyrvylaT8ZiCoyBtnuEr7Gl8RkGCyHP
         /UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409065; x=1729013865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zafKKPAnf6wRyGI9fM/mWrAHSuYDFy9rvx6KAYkSotU=;
        b=OrXIKvCZ0hAGy1tLBsbglxIGKgbunrUbAiGR5wBTWigQ1aRQdNoaSobjf3EsDWJSOf
         x8QN0XroMK33dbhZ3wA/RUUZpAlHgz5qiocirRkrjYJZc0CK2AProRy94j1IRIUKWPZU
         iPz7nU2KkhfGUUWZU4v7IO70w5ZyPjfmbtfxwQBPDLfoI3PVIJ6gZMWYXtH02Z46NUcx
         LHReVuYC7vGJNpf0Cjhtud6ah7eyjj6479jGXzYUBKFyHdBNGa9jlpGi+v3LlgTMfCQd
         DZkegOTJMRLemV5TRjLjiChL7xXS7yoi6lugUJFdUUWuvgLE6CtUR1nsxBTSUzHk9rVQ
         Oyow==
X-Forwarded-Encrypted: i=1; AJvYcCV+wi10Kx5dE2RulwCMsUfQnb8iJMi6UF0dWtxLJ64vrtk7fuGDYDkHJxYRBOmLlZCcMsSMdXnM1osP8R03Qig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/3hnEo0aPEj6vbDVKhLvJIfBhB28HBOV7FfILkwLe5q4Wkdg
	6OC6ZiU3hZTOAww3rbklwGwRZUDJEjVTKzOD+QbfBnAcLlmhhug61IegRaTO5ZTuN0EYkARYRiq
	MFJ2m7ZNV98eVfzmtBPVJUw0BnP1+tACS2CRK
X-Google-Smtp-Source: AGHT+IGE69oCQ2HDTvsCqdwT50xkz7bC4VKtcCeozQ2tMmUXi7qJJf+x0ipv/+Kr5o3bLg9ApLotHmcXQtUYTyCev6Y=
X-Received: by 2002:a05:622a:4f0f:b0:45f:597:3b6 with SMTP id
 d75a77b69052e-45f05970470mr2478051cf.19.1728409065387; Tue, 08 Oct 2024
 10:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005215600.852260-1-gthelen@google.com>
In-Reply-To: <20241005215600.852260-1-gthelen@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 8 Oct 2024 10:37:31 -0700
Message-ID: <CAHS8izNMxm0Au9TEMs-WF_==j1i3qc7Vv1o3-68Y7_9K-g7nqg@mail.gmail.com>
Subject: Re: [PATCH] selftests: make kselftest-clean remove libynl outputs
To: Greg Thelen <gthelen@google.com>
Cc: Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:56=E2=80=AFPM Greg Thelen <gthelen@google.com> wro=
te:
>
> Starting with 6.12 commit 85585b4bc8d8 ("selftests: add ncdevmem, netcat
> for devmem TCP") kselftest-all creates additional outputs that
> kselftest-clean does not cleanup:
>   $ make defconfig
>   $ make kselftest-all
>   $ make kselftest-clean
>   $ git clean -ndxf | grep tools/net
>   Would remove tools/net/ynl/lib/__pycache__/
>   Would remove tools/net/ynl/lib/ynl.a
>   Would remove tools/net/ynl/lib/ynl.d
>   Would remove tools/net/ynl/lib/ynl.o
>
> Make kselftest-clean remove the newly added net/ynl outputs.
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")

Probably moot since this is merged already (sorry for the delay), but
likely it's:

Fixes: 07c3cc51a085 ("tools: net: package libynl for use in selftests")

The referenced patch doesn't touch ynl.mk, but adds a dependency on it

> Signed-off-by: Greg Thelen <gthelen@google.com>

Thank you Greg,

Reviewed-by: Mina Almasry <almasrymina@google.com>



--=20
Thanks,
Mina

