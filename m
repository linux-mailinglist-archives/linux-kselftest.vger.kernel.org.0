Return-Path: <linux-kselftest+bounces-28240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D60A4ED42
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 20:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AD01891281
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24D25BAC9;
	Tue,  4 Mar 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHPVMeTA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91790259CAC;
	Tue,  4 Mar 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116270; cv=none; b=W/v/mTBRMKdPMLpzvWo0Q6rIF5VskdNrt7YJnoKToXh1/H9h1PgW4sKg9M74dnzc2CSDgQJNoFuFEXwyRgZm1fOYljy52UwJQbMUXHhoT/vJKkZHnopP9fS9cnFAS8kDRjwBeUi0YJ2rIKXMhhpI6PFEKha1+AQkRoVtd8bXnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116270; c=relaxed/simple;
	bh=sqOoP6qtQH+z0V252rI4cc0trTllwqKtMaxYZTrbQlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0kT7PHgsGq0q8nVYK4gD7A6rxlKPTH0esJTT/SicjMYhBY11Obl6phUxmpYgc6HeP3YTAdXeMz6U4MUWckaKinFiks3oxgPghbgM7hWf4ceoKauxWUEfXxGhDamx1JQvNO3AuPOruzi5d9rQTUKEtVwCwRLUoPfuP+xW85T92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHPVMeTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD1FC4CEEA;
	Tue,  4 Mar 2025 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741116269;
	bh=sqOoP6qtQH+z0V252rI4cc0trTllwqKtMaxYZTrbQlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qHPVMeTAVw+KBNx4Plw7imddYR3bWWUXTpHl9KC8vEtXc/paFXOfKnvO+pdtTx3SY
	 RGB9X4j/NEmlI8CXQKgZsK98pLO4caCzemMWDgIxAf2HiabWlbndSc9WH35hla/DnQ
	 8J26Qm1AXhhWTB48XmGi/E2Zqvxoyav9hg8+hsb2KQjhXaq+ZpsoGA81E/2un2SNTZ
	 /0cnYHLFvpfEoISDGqEBL1ecxTbrDNQVolhjOSct3/G/yaeZbwGqhv86/zmFqQkldo
	 MY8KgTpMLm02RhfQlBmZwKXSAH+9eDOAsy7+oreZeCyf4B7d9whBGtCY37v/upkvcp
	 1+FZE/Nm0g+8g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5495e926364so2951221e87.3;
        Tue, 04 Mar 2025 11:24:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ9ihNN2sU2pe38keUL4B6qyjqcinm84fVJaKb1+cyZlOu9JSwN9xeudkqQumtW+dVUN4qIRjwzXas6cv8@vger.kernel.org, AJvYcCWsDOfQxuHkt7lIFPRnrGXrJ4Ki6CYiS1Kp8Pc56jSVAE3ADzSNODrZr2iFNsVZ6reYBXVNbyzwzJ2Z7tF1@vger.kernel.org, AJvYcCWuK/kHFUwTiwXJpt7KyoG7oIb3XAzB3L/URnY2qn2bKuEXppQXXCDGiVluV/65DGuKMXMO+7BCt+xkudiaaIuH@vger.kernel.org, AJvYcCXFJGE40YxR2WzqLUA0ew2+NCxSN9BnDzSsgzuEum5nBaCV4mesdgij5YpDGoFHJpphXiZLk85AhQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOh0Ql8C4CtMIEPQzdatns9eJ/soci1SxuxXCGha4Yxr8yUXbg
	c9g0k9Ih7tfg/yeqq9c9rBGfHg5/g7T1G/ySvgBaRxuLBEHdiv6AeYDw1sblRz0OZgNWy3AzYgM
	YSgM0UwWI9SmhXlqloamg2FvmUWM=
X-Google-Smtp-Source: AGHT+IET8vj/yG3AdG8e8f1Ip4fbT+3bL2YrcsjlWbBKdOpoUun8nHQlHQPie5a4pPWBe/Qdno00in9upo3HUiJQTc4=
X-Received: by 2002:a05:6512:489:b0:545:aa5:d44f with SMTP id
 2adb3069b0e04-5497d35811fmr121961e87.30.1741116268516; Tue, 04 Mar 2025
 11:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de> <20250217-kunit-kselftests-v1-1-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-1-42b4524c3b0a@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 5 Mar 2025 04:23:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6U9ZSRHW+6J1PjwuefQPFFUwdjRdaLQT9NtRBkEGUAQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqnsz9EeEagDtG-j1LU-LhgsPAPKhnZ99QZ8tUu3o8tPV8yMe6vSpykRME
Message-ID: <CAK7LNAQ6U9ZSRHW+6J1PjwuefQPFFUwdjRdaLQT9NtRBkEGUAQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] kconfig: implement CONFIG_HEADERS_INSTALL for
 Usermode Linux
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:00=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> userprogs sometimes need access to UAPI headers.
> This is currently not possible for Usermode Linux, as UM is only
> a pseudo architecture built on top of a regular architecture and does
> not have its own UAPI.
> Instead use the UAPI headers from the underlying regular architecture.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Applied to linux-kbuild with the subject prefix fixed.


What concerned me was that this patch creates
multiple paths to visit the same directory.


[1]
ARCH=3Dum archheaders
  -> ARCH=3Dx86 archheaders
    -> arch/x86/entry/syscalls/

[2]
ARCH=3Dum headers
  -> ARCH=3Dx86 headers
    -> depends on ARCH=3Dx86 archheaders
      -> arch/x86/entry/syscalls/


After carefully reviewing the code, I was convinced that
this is not a race condition.
(I am particularly cautious about race conditions in parallel builds
and try my best to avoid such code.)








--
Best Regards
Masahiro Yamada

