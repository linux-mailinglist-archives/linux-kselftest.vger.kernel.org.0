Return-Path: <linux-kselftest+bounces-5658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D826886CF86
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE45B212AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB52C85D;
	Thu, 29 Feb 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdqwT6ao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582516063C;
	Thu, 29 Feb 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225103; cv=none; b=JkCHwCJM4wxrg9eWrx4KQ3Mc6jf9rCWaRczmTy0zEqNwGpsteAidU9kUmJuLMyhwyi2p4kncr7THTWHp2UUWPCmgIVPnlH1+hPuyqHSVPeUGS9OhHs8BNEw3LZuztBBEQOpsZxh9OK7er0eVoayNa+Zh9ksulswtGVHonSPOWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225103; c=relaxed/simple;
	bh=IRXPz5eQgY7CFlGjDHi+xw0LfTWY9bNESjy2Ei7NXJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMyXAF6VUtb6dDmTca2MYHRdetULqCfu3xc2Qc8WeGAWl7StanHZBCp28eJJ5gytEfLzZvdqv+Rv0xq6knrNlYKlTF8CYe38Z7vyP5OK0u19b/vYIoOMZt9kk1QDetlJzE++gjvGYhRFDeFlLboUJZuz8mHGebeV0SUVHc1Qs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdqwT6ao; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so809966a91.2;
        Thu, 29 Feb 2024 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225101; x=1709829901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm3oo/HPNFhUMimup98z849HwAM3VHswOp84oAb1UY0=;
        b=WdqwT6aogf1TcInYy7HivCeZ1va76aw/pUimWeeHpX2xF9qWaRJ19LQ9VJfPoBkAFh
         IGSXiKFNC5Hy/zdN7gM+4z/0of4m8nLjAXi6d0aFkPaqXXTzwMk6wuTvG4SEgHnyJCft
         jXpQGPdtFDZQFgZzZZZv1vgL5LvdiohP5e58R6lPA0TGIZyAZv+XrcPrnrdK7QkHsKHU
         UEDmdlXYVk+vi3u6vIUcPUzGGLm7DVcf6TvMlB9hy6NKVNSMw/e+3GdPDR3vcluFEs4E
         yqSD/8xQB4BmpopobOtyvy8lJy0zPGFxugvJuBr+mfcWA2/jvps2TEO873Esu6EVvVZd
         puag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225101; x=1709829901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm3oo/HPNFhUMimup98z849HwAM3VHswOp84oAb1UY0=;
        b=XeRHbhqAxnjjTdgC4uc5lfmKD6k8qRsLctda8ACRg/cGWTURmzwf0+Sp8IjPsVr9Te
         U+MNcGx0Zmdz3ovX9Uu834bqQnIrwOXbDwhIuD9prZSg0b1R5O4XZD9O1213eXQtv9cy
         Y5Xd5Q401lnoAR1jVB5izKqtI23FJNWxvuheIh8F0tu92HxU5HPfG5Dnz5S3kmLq5Aeb
         OEAnL6XCwFtqhwJJ6BqIhVrGaRN5tkIeeD7j6d1AwZc/ZSKJGBf4yhrJNNym1BTZqvk/
         QZ4g44cvm4t8zRZgFPppiQE59IKtxT3c4se27WDvYGTJ/8OvbzNWq1f7Jmi7Dqknkwnl
         R2tg==
X-Forwarded-Encrypted: i=1; AJvYcCVCoSqIsFeIFGXPe362T6uDiouhmIUl4SnCKyyNC+3y4TubV1Rb/RrDclFXI+97F2mPaGocW2zJ5va15pyNss2mPK27YtOrAEECcA8guO9NcCrG7j4FpXpXzBiBFKLO8b2Lc9xVTIvYlZ5h9THffTeQxedSAQxpM/FLLb5UTIdaB80+mayHR+yBpKs/EDI=
X-Gm-Message-State: AOJu0YyYS5x9pb7AKqULtW6S7jmUKj8mvQ0l87CJ1nbyDzRaLd8r/a21
	/Vq80rCl4pAmF0+Fm5sKgo4RQCqSgczpQDVdOJQOLVmIqBLsOC5QZ9cQTrxwdvhVhq1R7NYIfkn
	n4zSsogKeRNm8pwGJRtisU/ISAh4=
X-Google-Smtp-Source: AGHT+IFF8vUpouiFhqkFcDF+wV1jo9NQbuT+G7SP18qRyxwJzsJkJMNN7SzS13vDg4QM+ZT4oSR9QI//eSXRTQGEXfk=
X-Received: by 2002:a17:90a:d718:b0:29b:5c1:5e05 with SMTP id
 y24-20020a17090ad71800b0029b05c15e05mr2679787pju.2.1709225100614; Thu, 29 Feb
 2024 08:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229155235.263157-1-laura.nao@collabora.com>
In-Reply-To: <20240229155235.263157-1-laura.nao@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Feb 2024 17:44:48 +0100
Message-ID: <CANiq72n5VmPQL32smcWz9HJdNg_KfLLRM7syhtM+TiL+pPcEGQ@mail.gmail.com>
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample modules
To: Laura Nao <laura.nao@collabora.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	shuah@kernel.org, usama.anjum@collabora.com, a.hindborg@samsung.com, 
	aliceryhl@google.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, kernel@valentinobst.de, 
	sergio.collado@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:53=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for this Laura!

Replying here to what you wrote in v4:

> At first, I hadn't planned for the kselftest to skip entirely if only
> one of the two sample modules was missing. However, considering that
> this kselftest is designed to test all available sample modules, and
> given that both are enabled with the provided configuration file, I
> believe it's more logical to verify the presence of both modules before
> running the test. If either of them is missing, then we exit the test
> with a skip code. This also covers the case where rust is not available.

I guess it depends on what is the expected behavior in kselftests in
general and whether the user is expected to have merged the provided
`config` or not.

Also, what about modules being built-in / `--first-run` in `modprobe`?
`modprobe` by default may return successfully even if no module was
loaded (or even present, if it was builtin). In that case, is a
kselftest script supposed to succeed, skip or fail? I would say at the
least it should be "skip" (like it is done in the case where the
module is not found), and I wouldn't mind "fail" either (i.e. running
`modprobe` with `--first-run`).

In addition, what about module removal failures? Are they ignored on
purpose, e.g. because the kernel might not be configured with module
unloading? If it is possible to check whether `MODULE_UNLOAD` is
supported in the current config, it would be nice to check the removal
also worked. And if it is not supported, skipping the removal entirely.

Finally, what about the case where `RUST` isn't enabled? I think Shuah
mentioned it in a previous version.

> +KTAP_HELPERS=3D"${DIR}/../kselftest/ktap_helpers.sh"
> +if [ -e "$KTAP_HELPERS" ]; then
> +    source "$KTAP_HELPERS"
> +else
> +    echo "$KTAP_HELPERS file not found [SKIP]"
> +    exit 4
> +fi

I am not sure I understand this. In which situation could this happen?
The helpers should always be there, no? I tested this with `make
-C...../selftests install TARGETS=3Drust INSTALL_PATH=3D...` and it seems
to work in that case too.

To be clear, I agree with Shuah that we should test that everything is
working as expected. In fact, I would prefer to run with `-e` or, much
better, use something else than bash :) But if something should never
happen, should it be a skip? Shouldn't we just fail because the test
infrastructure is somehow missing?

Orthogonally, if we want the test, shouldn't this just test the
`source` command directly rather than a proxy (file existing)?

Thanks!

Cheers,
Miguel

