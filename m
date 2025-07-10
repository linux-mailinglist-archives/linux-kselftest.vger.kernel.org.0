Return-Path: <linux-kselftest+bounces-37048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE387B00C1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CC14E63C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD742FC3C7;
	Thu, 10 Jul 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D99Dt27d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CA21D3C6
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175819; cv=none; b=JSyeWbvm4HGeEGsxKfQqdXqL7+9OGgrXndc8yydaex5T4LXZ0sFpaitQC+QhjXSO0xr2iLW0LSYOD2mgVGDFpyPfKaUY02qf+mk5UXKMSqLhNpyBaQW7O3EWaGEE+5c/PLKybyE0SoOo5YXDmCWs6YrTQUbxKv1EqNb8SSDwM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175819; c=relaxed/simple;
	bh=EJ6s4tjHUT6RtbgUP+qOWodtQci0cx0J74QsTYz4VVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWu3Fc2WjkfHxV7g8B6oIoGSWIyJajENM34+O2bqK0bxZ5DIXcxduhYrWrzdKtNnhDdQ5cbSnI+Wtfpe0mK7ImKwkhWdxnfRmIR4wCRwfrD7ITCtwU5EiffeIoLRBLh7tzwYzr1nyjMTppv4WtPRFBJh58RsVAj74ifegM/Go08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D99Dt27d; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad8b4c927so12720026d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752175817; x=1752780617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USEIpL4apCBHIBMoQ7JPvYpW1LrAcOYziqZdXP5+KWM=;
        b=D99Dt27d141/r5XQ/AIfIN8sEKybEgVy7KPWWfLB2K8kxh9YeXPGm4liw6icOra0Az
         RIrzbkR6FkuMImrnm5UBZj3oYgGJ5pDuTkqnjW85R6LZUEeIrG6lTLLCHkbmakuFi/nt
         5St2wwFFjszvFIhC6rB5PcvHyjNm/+Cta8yC9FYvUus+k8SeQGVSzjmOVyc+8rZtyR19
         0r+ztu1MFTnXkSE0DKGmZ6QO9K4RusOtR2F1lUDdceRC9W3fpkopsgMkFLPl1lBw80cY
         L4WmSlDwQf9WrLvhmx6w13iLs2Qc9KMuFcdTVCr5xEfsNwYrXm5d6SMgRN1EhMo0T06C
         Yp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752175817; x=1752780617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USEIpL4apCBHIBMoQ7JPvYpW1LrAcOYziqZdXP5+KWM=;
        b=bxmcGJEMOeRXKKoeNYIgasG/USAdWC1ssWGVZ00at1+N7RePmDN3yeAL4JORNQC59G
         lq8derHf3kPylLsCOq1gP/JGLvVp0EnzjgdxVDNcC3gGdUvA0GwCsBFKTSkSG8xG/YiD
         exrdNwczknkhbD6ujnaMVlf89pGt4VplBLYRPgASI377Qa+EdSfmCXLOs4iVhZAFEYjy
         AS0Zdbh261OpNLFAVd6vIwOVOHAKCiV6iPjwMdo37vzrOje4PnjgIi4BukE3CEw8TdYP
         hVk88sJEEr4j3trBTVMf9jZ45DiMj+La/KcdTrXFonz7Fb7f40zbMu3YpwijM4Fonzzb
         9YmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcK0a3VPZfNpIY9xpBzJZHXTEpFNHOeMqyGywVjg+DLxqNU43f+Uv40GDfljceEhVtztnZvl8ErqYmO01WhPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW5Y+av1LcyzaotiTBkxxxH5IhEM/Q5IGlQYjkL2iQ84hQGnz
	N4ii3AVHmXQ+UG7ZqpuJOFA8/rzUGv5rKTlcUz1vDpG2OT308wZhx2ln9BHcA8752BWG5DqGZZN
	YJjQX15bY7VUu/j+hi7Q0SfzqDtYnFh8nP883g/HY
X-Gm-Gg: ASbGncvtcPc+jB6IKWhFECXsQWtOImHnXN79QQGFKX3OG0UhVskvh5gHhEcJ45m+0Q2
	f+grQkvNFt2j1HJdoRwfvlpTybPMdDw8To5O2fvDL0zAxZ6Ok248dytyzZr7W4yrq/0IULo4DpU
	5AwFciv4oT8T6FPp6WE/Ypfd8d6iFBiaJIjUBu+Dt92eyEresm3ka77de3R+PG8u79rXllMgzA
X-Google-Smtp-Source: AGHT+IGZ42wCwYI6/mUsKs5W1wwGLVBaIdQX9pYAG5+GOjYCAt5QsHm7XxQOSQrB76f5N4QqzG2xfswRS2/KVu8ypPA=
X-Received: by 2002:a05:6214:1d2b:b0:704:778c:3b9d with SMTP id
 6a1803df08f44-704a3976eb8mr7470116d6.30.1752175816350; Thu, 10 Jul 2025
 12:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706201855.232451-1-sergio.collado@gmail.com>
In-Reply-To: <20250706201855.232451-1-sergio.collado@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 10 Jul 2025 15:30:05 -0400
X-Gm-Features: Ac12FXx5GXs_yCw2SDS55fJaE3Sbr8VfcBVMKoEwWHmO2efRO1bMOT4Nye6j_po
Message-ID: <CA+GJov5eXsoKG2eYch8h5HgLCwnE8+9RA0v-+9DW9TpP5SordA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] kunit: fix longest symbol length test
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, rust-for-linux@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 4:19=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> The kunit test that checks the longests symbol length [1], has triggered
> warnings in some pilelines when symbol prefixes are used [2][3]. The test
> will to depend on !PREFIX_SYMBOLS and !CFI_CLANG as sujested in [4] and
> on !GCOV_KERNEL.
>
> [1] https://lore.kernel.org/rust-for-linux/CABVgOSm=3D5Q0fM6neBhxSbOUHBgN=
zmwf2V22vsYC10YRBT=3DkN1g@mail.gmail.com/T/#t
> [2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/=
T/#u
> [3] https://lore.kernel.org/rust-for-linux/bbd03b37-c4d9-4a92-9be2-75aaf8=
c19815@infradead.org/T/#t
> [4] https://lore.kernel.org/linux-kselftest/20250427200916.GA1661412@ax16=
2/T/#t
>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Hello!

Thanks for resending! I don't believe this has been accepted yet.  So
I've added it to the list of patches to get accepted for the
kselftest/kunit branch.

Thanks!
-Rae

> ---
>  lib/Kconfig.debug                | 1 +
>  lib/tests/longest_symbol_kunit.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6..4a75a52803b6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2885,6 +2885,7 @@ config FORTIFY_KUNIT_TEST
>  config LONGEST_SYM_KUNIT_TEST
>         tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
>         depends on KUNIT && KPROBES
> +       depends on !PREFIX_SYMBOLS && !CFI_CLANG && !GCOV_KERNEL
>         default KUNIT_ALL_TESTS
>         help
>           Tests the longest symbol possible
> diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_=
kunit.c
> index e3c28ff1807f..9b4de3050ba7 100644
> --- a/lib/tests/longest_symbol_kunit.c
> +++ b/lib/tests/longest_symbol_kunit.c
> @@ -3,8 +3,7 @@
>   * Test the longest symbol length. Execute with:
>   *  ./tools/testing/kunit/kunit.py run longest-symbol
>   *  --arch=3Dx86_64 --kconfig_add CONFIG_KPROBES=3Dy --kconfig_add CONFI=
G_MODULES=3Dy
> - *  --kconfig_add CONFIG_RETPOLINE=3Dn --kconfig_add CONFIG_CFI_CLANG=3D=
n
> - *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=3Dn
> + *  --kconfig_add CONFIG_CPU_MITIGATIONS=3Dn --kconfig_add CONFIG_GCOV_K=
ERNEL=3Dn
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> base-commit: 772b78c2abd85586bb90b23adff89f7303c704c7
> --
> 2.39.2
>

