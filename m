Return-Path: <linux-kselftest+bounces-36608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D84AF9C22
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 23:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939523AC1BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF326CE17;
	Fri,  4 Jul 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbo23xrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1306230278;
	Fri,  4 Jul 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751666196; cv=none; b=X9SwXQ+5SwspoAVsoHKgR/SYaVpbU+sl0tRvILy/Ms1jvz8RZwDUQMRE+Uzy/Q9pX52UdkJT0b7m6iqDonBSKKxaiuMYfcaUvzCXyXLHiqbwjbmDoYNuHdARQlvSeWHBSt/oYy82jTRDpgSQSqjJNyigPyLhdBcp8+bTrC03edY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751666196; c=relaxed/simple;
	bh=Y4dP4R0COLDEO9XOwXP8MqcGxLifElXto/WM/FyiYcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjTUaF2BtWmghqwgrk1Tx6A4KxVQuziiT6qG/ZY3OL7IG5hKC/vesiZ08XlVJK7MSFWTLE1R/E25gN1mlAKi2rkFIKxP2UVFwaeJfwaiSg+JAvP9NH/PSxT9SQ6QGLnGi4uAOc3NJfhFfqMEkgmMtxeex/cT66fPAEInjWvY31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbo23xrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669A7C4CEE3;
	Fri,  4 Jul 2025 21:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751666195;
	bh=Y4dP4R0COLDEO9XOwXP8MqcGxLifElXto/WM/FyiYcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dbo23xrG5ByYRVbASAUjR43dkkWMtWth1KbfXWQ0lXDitgB6Osq8mIiWxeCv2ta2j
	 CP9iJ/AtLTCBV8QhzsIr7dl6I16YgS4SMv0lZ0j0EeK4ILG/oTuqbPUWHVMYB+IcoV
	 Zdb7aQYzwKdVMdE66pBH62baQWg0Rt3ec0DqR6JmEdZhg4q0JMJLt2ILvksHqE2wQP
	 NvSFQrL/oXMU7HjgHHqVn855zDAM9B+SoNGjmZxaaP9ZTSMSJi0AGtGl4nbuGShSHA
	 ePwwaeidWEKFAfK1hiRmeW+ERfnndFWkymS/ezbMgayeZktz30vShMBs0E1v0H7TSU
	 s6dIlIp371o3g==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32adebb15c5so10048961fa.3;
        Fri, 04 Jul 2025 14:56:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8F8upAT2IivQStJnw+AoD4avSQB17ki/qyXdQWUw/QTHRU/p1w/FwBHsY1tifG2SNPFXnZWKbEYObxtF9@vger.kernel.org, AJvYcCVFoGUX0Nrw2/Lz6cZr9ogCa9J8Xx9MvXuUqT+90pmUeGFcT3lOk1owRuH1TJczXTj2fJbuHhd4cJEE@vger.kernel.org, AJvYcCVZigzeOWfQVYdIDpSADDneWakMsnxEh4/y1/bpzzuU5Dh6RQ86MY7rv+wu0uomeKKcD0bpRQ0MLfc0usWm@vger.kernel.org, AJvYcCVkPGx7TpwaWFAf4einAxtIaatt26XPBWUTOO5CBYDJW2eTC52+7w+37aZdJJqKxw4MjHdUATKeoOo=@vger.kernel.org, AJvYcCWmYtKE+BBfsLsiysegIGGRwXiI/GbMTDH0FMDXjTJLSC+AVRNxqdnXav2d9tEOD2pb7f1yliPkn2GRfugS7Dh4@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+IiWuN+/V40soYSxCZ75KleSSJTH8tVTpJOWd9fASTDmajLW
	QRnBk9dmqykCTaY4gfhgwL6/mUVulLpH3RIWXhuQRJA4gxyoPLKb4M0QMoGblken2nByKE9vo+Z
	Msl1mS3BSJybAOby2TfaFJBK6rJSS3zU=
X-Google-Smtp-Source: AGHT+IGVZoDUL4hlVPhvud7l5bcj+GhwWkCdlk8b33LW3OzhrN3d/HzeMnr/omzaDFlVqDxqjw12uE9q9dhxriRfEeI=
X-Received: by 2002:a05:651c:4018:b0:32b:7356:94cb with SMTP id
 38308e7fff4ca-32f092c6cc3mr7970301fa.19.1751666194115; Fri, 04 Jul 2025
 14:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-3-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-3-48760534fef5@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 5 Jul 2025 06:55:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARz6-7s_pV9X-XcfU55s-AUs_y0Sm6YUgey+Q1=-QkZpw@mail.gmail.com>
X-Gm-Features: Ac12FXwnNIDkk4V1pS1bMlMnoRbXLTf3Hf3er3XEcmiWfxGzkmEMLQCUYkde3EI
Message-ID: <CAK7LNARz6-7s_pV9X-XcfU55s-AUs_y0Sm6YUgey+Q1=-QkZpw@mail.gmail.com>
Subject: Re: [PATCH v4 03/15] kbuild: doc: add label for userprogs section
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:10=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Some upcoming new documentation should link directly to the userprogs sec=
tion.
>
> Add a label to the section so it can be referenced.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Documentation/kbuild/makefiles.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/ma=
kefiles.rst
> index 8aef3650c1f32b6b197e0dc777e26775d371a081..c14c1f632f6069c8751c8388a=
35bef539e19f9e8 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -891,6 +891,8 @@ This is possible in two ways:
>      This will tell kbuild to build lxdialog even if not referenced in
>      any rule.
>
> +.. _kbuild_userprogs:
> +
>  Userspace Program support


Acked-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada

