Return-Path: <linux-kselftest+bounces-40709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2FB42B3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 22:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346E916B7D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302F2D29B7;
	Wed,  3 Sep 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+5+pB6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADE32F755;
	Wed,  3 Sep 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932333; cv=none; b=f8PgRPfBR38MLP5c3HPFGqRgqY+OvvrBixHxnlNpXlNZEqyYMnwy03tXDDNWS8oGOGr1EtWAu5eltpF0BXBWgZizgmH4W5sMfxxQRlsaG/CPAmSSjgndNAHc4uwgrVMt0ffO1y33eOxM/asn1rLKwiksc5aoCr+Fi5ttaZcTui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932333; c=relaxed/simple;
	bh=8Xv16h2KiIDyhQTLlmsUgVfIu/PAOnLcttZccG8gp+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT/FGyQBbDIJCc2SK0Bep4Evp5EpUkxe4DQONMoSKjcQ+wJ6+oBuo5aXp7FGOv04oiVTd9Q9dqwCpMt3k512jqkooWPYD6GLUSt/p0bizAzlufyQBm81a/T4AAmXbfLgD16jV9rTXdFhD86RKhi2iaTWmRpNHVXRT/4t2Bggm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+5+pB6d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so2499535e9.0;
        Wed, 03 Sep 2025 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756932330; x=1757537130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNSJ4OFuc0qJzJtggAMFVjTd+/JDhBon9pakUv8hWp8=;
        b=f+5+pB6d8S4uc2HzgSzo9b6ebQ7LcGEpgIz2EzFdpzm3MNIXNrAhHKmTbV27aF/Ozt
         1/YxXrI45apZCf0gYtGqu69UcZY+ttyopEGP26HwUEdpr641ZOrLTt6WGXDk2rZBRUOn
         oFRtAQcHRF+KBfjy2hvQDBuNw+Qs6sNYxCQiKs76Q7fyCJAHdYOeJuRbp6bTSmhila4F
         Yp6LsNTPk/84mrRaQGuKwADTraxoJ6y8g9vSG5N6pTTu1hKkyr+ERb3F2RZm7dqqcN2D
         GEhO3nNwhVj57jfvApJNubyhJfjQhJDXVaS05wWQ2IgyEgTHJBxHeuD2lI7WvGaCWFY1
         Q1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932330; x=1757537130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNSJ4OFuc0qJzJtggAMFVjTd+/JDhBon9pakUv8hWp8=;
        b=n3p3S2AfGNB0y04tQFEq340Zfv6ypfTzsWcw7S8e0OEFoFbrfBjQWmot6NGqRozOqH
         dI2eXDtFxaxl0Xhue0mi44B5OWU+zfYQp8cZhwMP64LQ4ZwM90qKqBbRcHe1Zl9q7c9x
         m1lCaLAxU0jq+ni6Y8VpJhFoEzGCcSgm1NuX4stsciqegGIcYvlklEt3fMLPHEcLbDVO
         KWmPLKXhTO2WwcMRhTna1OeUv8C3tcz8wsKdr+nr2suJ98kuXUWP0X/MAI0sLN7hzcnJ
         IGIPtuGD3KfuVN8zfto2fKdkr6zh6nC9RMhsIihctFCaKT6DjMhJKXz0SItB0P1G0mPl
         hiDw==
X-Forwarded-Encrypted: i=1; AJvYcCUaj6k7e9pfvqMInXTF+KVt19RP7GXaoUjEgYNnalRdKkPz7ZE+yXJsnm0R2h+qWuPVseFNmTFBn8E1az7R@vger.kernel.org, AJvYcCVOxNo29UOPKHEm7prcfKxRe5qZfWtuyLeBhBcnd/wjwbbPLlVhzpZdpRq7x44Xe2nQQjl/Kx/2kAg+GirHbJGb@vger.kernel.org, AJvYcCVXAeUR9N7Qs61AQ8BrmxYwD8XEX+rO5VT3S/ivN0mrG/4v9xcWQGBHZ2o/MTfwsSwLGLU=@vger.kernel.org, AJvYcCWH/hwK9Yb8wy85X9eYfDxlUXRMMMMHcuC3NQEYy9GUPMabOgt5oivI44doclXBlTH0hBEAlIikGfAJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWyxMOdxOdzDGaanufnCzhxgOL/d/T4ZOP4errl/w1HTsErEw
	8FOIvpUMcTB8xGVgRXC/W6hkQiFMjhmbIcjGgAloNWq+q+u123WhQNeOxf9ITY+XqTVTAAbNqGN
	eTMHLKw0T8vMdSavZNc6XXHaIqyZRUtNdhw==
X-Gm-Gg: ASbGncvrbyrhjXhh6k4yiDsIg/gH27pMv5hCZ2HNjlJ8FQZB7cqKiZK+sVUIBV4zYOW
	7HS4AmYObj5vOcRijdMrVDN5HGnsHl0/x/qVGybOXxTx1+qHNT5g7oI02Ziqsi7ZFAQzfoCxo4g
	dLNlW1SGxxKYl5rRlpZ++DBuBCCyTwCktrBXArGELjkWbJRH3PeX4PUyM30e7LCsXJQpf1nENdD
	NY05ABXtpYk4p0q4hEzMS0=
X-Google-Smtp-Source: AGHT+IFE6dL5bgcnUBgZBuqjo8JoRtUZkDDFJozb02kFPQw9snoXc2ZWcJRHOBTqspVuwWDDx9KoVetSpoJG8erm9fI=
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id
 5b1f17b1804b1-45b891fb24dmr111536585e9.27.1756932329553; Wed, 03 Sep 2025
 13:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
In-Reply-To: <20250903203805.1335307-1-tom.hromatka@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 13:45:16 -0700
X-Gm-Features: Ac12FXwNBTZEH4i39M2Lvsx2-HjuxmuNitFFC744jhe5v33rhJFQsMivvhBTsdI
Message-ID: <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Sargun Dhillon <sargun@sargun.me>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:38=E2=80=AFPM Tom Hromatka <tom.hromatka@oracle.co=
m> wrote:
>
> +
> +       spin_lock_irq(&current->sighand->siglock);
> +       spin_lock_irq(&task->sighand->siglock);
> +
> +       if (atomic_read(&task->seccomp.filter_count) =3D=3D 0) {
> +               spin_unlock_irq(&task->sighand->siglock);
> +               spin_unlock_irq(&current->sighand->siglock);

did you copy this pattern from somewhere ?
It's obviously buggy.

