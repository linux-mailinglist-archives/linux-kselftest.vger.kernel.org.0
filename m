Return-Path: <linux-kselftest+bounces-17871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFA9773AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 23:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0041C2032A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 21:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DC1BE851;
	Thu, 12 Sep 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsGkpoP3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C572C80
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177003; cv=none; b=Lt9dM6cfD4t8806ZhHG8KvBKNdjJA9T9AAEyKbRnkkCb7N0lzVOSXZyMv5aJYqFvqxCFbXMz2O4GsaSNO/gT9hcsJ/rbwnB2MqflcFhqh5s7t7oljbT5ebY6agsSaLfpYCBQKwoHpFLZQ7g0iFv1EmcYRnpnh/s4C0iQhltoWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177003; c=relaxed/simple;
	bh=pDqhAgtaGUIk/5wz/QDpvGvuqyiDlqtUCUYvT654FxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlNhtmiDwSSdG7s8FfWOnZcT5gM8TWcSaqICfOoQJqihfwhsRbJuEu5ZMwlE0jnkLz5atlLi7f7F7y3RcFjLqYP2BW99e7yBqkHNCY+J+ZVczvuN+q47KxdcvFKi/IMF/PN5I/8GRVWt2lzv7pYnbftYUdhb/Tuez7bF5blxp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsGkpoP3; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bcaee2754so439013137.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726177001; x=1726781801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV/uSQHel3G7NaBIuUYTK9WPHlxT4nG6GtUVNt1aiiw=;
        b=tsGkpoP3WeGnT1Y3yRFPSNgHhYDFWlGngGv3H9MtrjvxtA+cpAFWULYs/5lrwoToJY
         V+STe8ps1yP2aGj/9Ahlc2Y7n9NzHFUs1E6lzO8Ysx7tjmnc0x7OWd/8mSzfsRqkQLr2
         7krdm+MLVn1t3V72OcTlHqIM/wPleNjSsX0wRyMLKO9qlVr3OtcIyB5mv9FFb6JAgC3U
         YAVKoZDyV05qHit1vtrJ+MMxO8ZrhqhLZ74RthkeuG4+k8kPhpPcnRfmgmSG2NOh/O/q
         d+33zAde4EgIZyPvsekkwwtfqfpX/fqkdzpzZnPVMQCn3DZGZ53WAkUC22us0Ta7jil0
         x9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177001; x=1726781801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV/uSQHel3G7NaBIuUYTK9WPHlxT4nG6GtUVNt1aiiw=;
        b=dCBOF70iMr6eJBgz50SPW3F9RAmqOiswP9kEJuw3uu39TZp9nTgo9R/nDra4bsIGBo
         DwAAatE0c6gC8S4ZnjiUV/N7ZBl9R5UGKhSKRhZgSIRBO3tv9YEa/s03rpkw5JkkTTqp
         MSDT9hsO6kWIGlvK6OkwOHG98UJHZVTuPU8o/WhOCmXxFLvT1kUfwCkkiOgfltChUylY
         9+gGUhv6uwa1trHr+3xrIP8e4hydwSG2fS5ZNZG5UdiQ94NFheCM9y2opvWRdKqeY086
         dGIDXPL5izeTE30DxuD3a0o2lrI72QrDgYzLm33J0QUdE2D5CnVBFhJXryLwUp92ELg0
         2Mug==
X-Forwarded-Encrypted: i=1; AJvYcCXkWQF5O1bomq0ugNbgdFXQJjTAwATWMvPR3aOWHSyd0SWIkS1cyG8uFmdd3Es2i00uSoMGkqtW2h/3uS7BQ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3crizNnIdv4ozdZBnq4wL0obtyNryfAEVAgcpmkn1fV1y+7tX
	rqOIU0LLRlu4/GvZVoRLDdOE0nJerc9NvlM1dse+FZT3WF9L8tCRQNrAQSQ4uo3uIR/pk7txu+i
	p9tqSkftYgPT2osBLnsDORDKGGFa/jIg0jfow
X-Google-Smtp-Source: AGHT+IH05pjtSDhnhSat0T4TMcHpVIIy9ELPbIRaoAr2cIE1oDrkYRJOYxE3o0MeBcNuyMPFcCB85eDpRsk4NuzwEyU=
X-Received: by 2002:a05:6102:511e:b0:49b:be3b:8812 with SMTP id
 ada2fe7eead31-49d4157c4eemr4055765137.24.1726177000369; Thu, 12 Sep 2024
 14:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516-kunit-compile-commands-v1-1-05fc32b79312@google.com>
In-Reply-To: <20240516-kunit-compile-commands-v1-1-05fc32b79312@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 14:36:28 -0700
Message-ID: <CAFhGd8pLAa7vkVUtcdhvdk+oq=dOSGQWCOf0oZK7pszaLdsKNA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Build compile_commands.json
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:38=E2=80=AFPM Brendan Jackman <jackmanb@google.c=
om> wrote:
>
> compile_commands.json is used by clangd[1] to provide code navigation
> and completion functionality to editors. See [2] for an example
> configuration that includes this functionality for VSCode.
>
> It can currently be built manually when using kunit.py, by running:
>
>   ./scripts/clang-tools/gen_compile_commands.py -d .kunit
>
> With this change however, it's built automatically so you don't need to
> manually keep it up to date.

This is great!

>
> Unlike the manual approach, having make build the compile_commands.json
> means that it appears in the build output tree instead of at the root of
> the source tree, so you'll need to add --compile-commands-dir=3D to your
> clangd args for it to be found.

This is annoying for some. For my setup, the discovery of
compile_commands.json depends on where I open my editor from. So this
isn't really an issue as I can *choose* what compile_commands to use.
I think some folks may wish the compile_commands.json was also dumped
in the top-level directory so clangd can discover it easier.

>
> [1] https://clangd.llvm.org/
> [2] https://github.com/FlorentRevest/linux-kernel-vscode
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/kunit/kunit_kernel.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index 7254c110ff23..61931c4926fd 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -72,7 +72,8 @@ class LinuxSourceTreeOperations:
>                         raise ConfigError(e.output.decode())
>
>         def make(self, jobs: int, build_dir: str, make_options: Optional[=
List[str]]) -> None:
> -               command =3D ['make', 'ARCH=3D' + self._linux_arch, 'O=3D'=
 + build_dir, '--jobs=3D' + str(jobs)]
> +               command =3D ['make', 'all', 'compile_commands.json', 'ARC=
H=3D' + self._linux_arch,
> +                          'O=3D' + build_dir, '--jobs=3D' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
>                 if self._cross_compile:
>
> ---
> base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
> change-id: 20240516-kunit-compile-commands-d994074fc2be
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks
Justin

