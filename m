Return-Path: <linux-kselftest+bounces-27249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023FA4040C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E80179C3F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04E35956;
	Sat, 22 Feb 2025 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftTjcCjm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6153D76
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Feb 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183816; cv=none; b=XacGZIrEZ8/YP1NOma8oTaKRm893vuIovzcSsUCU9+KSWeuxAPi+BIFcImAHUjGxeHNxh2E3kBQZzIXSHxG7Uxuken4v9mEUW5f8Tny2FKG6sy9LAULxjjQepfXBbVV9sCWP5Z2qca7r9bcWGNKgzCMue4FEKZu+dnrEpnvuBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183816; c=relaxed/simple;
	bh=uWGj/ghDVjddUIymJroVvjH/8Eeew7Akh55VEKldi0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjF/bOwG5WZ1QQfKjjV+ghxr84AmYcL7ydXkXidlhD26N67msK9siF/RPJGt9hqL48odNjHXV0IdGcAwDbPsyCNjblPsmPhQ0cBpSvy+OgyuI/OjfROsouGU1zMwlk0D8MthAd6rvY0DS3pV2+r76vJ+n9TEQKjd6U//x4bgmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ftTjcCjm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6df83fd01cbso13208716d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740183814; x=1740788614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSzQcTJF5xLPZTvWx3iP/k+uVIkdYz50MFGnhN54B4k=;
        b=ftTjcCjm1k1zfpnaap8hCLBJy00DKY0HtrXdKThR2yPM47EMDOSztXfrx3+TNn1Nl3
         TE6ifyYxGZadqPi+t222T2i24K3dNtPau25/rzx634qGJpSROoE+GHxUbOrFQ+NQEnbr
         OV4JAFNGU5XLI5L3fBHBnGskA9yCqDht10YIbVDcBLAqrVAixNX2QR4yyEaFvYw5ERNY
         Khx1IU5YdGcG0Uci1zkipyLWio/33BZfcOkBSsf9nh3IjCZTPci+2lUsHMhDnxMYsEQF
         2n5F6xkg2M9eq6sdRJQ/ZE5Pyf5fkjsQ1y0KtiCjGJ2Uqh3+MIvgTAnhgEVe0ezpQIwP
         vGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183814; x=1740788614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSzQcTJF5xLPZTvWx3iP/k+uVIkdYz50MFGnhN54B4k=;
        b=EoWZN6AaKP7gj8HnFomtno0xdxzflEL2HNsS1iNQ6Olah9c8h2pJFwvG4C1RCECDaG
         29SKMZgz8VgL4lOXvX2GrL92rUXxBan7gFBp4+61m3YDUxDVSgp9HzJj4r5r7LiZqqMc
         3EaBT/xJXWKZutG2awIEt9fp+3AsmdTTflDgrp72EF6DzpfipycA6I096dpcBIB5yxgt
         Neom/acqGevJiPsxqN5KTByi+C0LeiCnXdQrW0K1JUfueTfQNiKg5LkPiSpwCkZLxKVo
         M62SNlp3342jT6qaoLaIFLGw7bA6IzjfqnePqbiRr8syOUXPGpzByCwgwcTWtlvZ/4Zn
         ATWg==
X-Forwarded-Encrypted: i=1; AJvYcCUPLhWlJKVfO7EMmZ1RFMpeQl+EgBkw27qbsRTPi11GlQhmG7YlCsuCOjIUAeeSjBLiF/9Q97lk2eOmeBnJwmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5ZiGKdPgIrv2L9WaQ3AdUTYxnqrU2Hk2L09DdA+EWpZQBaf7
	ypjRRRqxEdSKeDrmuM3UJpszrncCKJ1uZzLcy4IABI2rPL+cMq4D4YsX/3s1HC8nlrS3Gwv7wFf
	U7pFhYnMML91AuSnQ1ptHJDsIXnSNMKerOufo
X-Gm-Gg: ASbGncuec82TN+7WytzykfXs4K/0ACgnCBmr2Bxs7efuRhFqBRf4ayt4WGgGyZdU67N
	3MzZ92W2sQw6ynUYwMzEjy+JRnidejmlAMhUarduNIvdqOLCbzX2SI7vim1e6x9qTOskPOemzbS
	UHD5PkdYqvgxSY2k9EImUxrpv0EyiP7yNvEHj8NzfvAQ==
X-Google-Smtp-Source: AGHT+IGuQ0EvmHyfKG5oNm+O437XGsKsIWjy7D69nwbmU+BvrwdeCAVThohimbQuZ5UbFbSqz6k2XiLKMUmXP/PvzrA=
X-Received: by 2002:a05:6214:29e8:b0:6d4:b1e:5418 with SMTP id
 6a1803df08f44-6e6ae995a51mr75420156d6.33.1740183813487; Fri, 21 Feb 2025
 16:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-kunit-list-v1-1-40b9d56417ee@linutronix.de>
In-Reply-To: <20250220-kunit-list-v1-1-40b9d56417ee@linutronix.de>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Feb 2025 19:23:21 -0500
X-Gm-Features: AWEUYZmnGvGuhAJ-WPSpg1m6Yg9Ho5W4SXQsSKmnp-R-4-C-DrR6attW40T2wKY
Message-ID: <CA+GJov590t3N5NgsPTan2yR2150Y41wotPzW1RojTC6CEd_O1A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Implement listing of available architectures
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:44=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> To implement custom scripting around kunit.py it is useful to get a list =
of
> available architectures. While it is possible to manually inspect
> tools/testing/kunit/qemu_configs/, this is annoying to implement and
> introduces a dependency on a kunit.py implementation detail.
>
> Introduce 'kunit.py run --arch help' which lists all known architectures
> in an easy to parse list. This is equivalent on how QEMU implements
> listing of possible argument values.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Hello,

This patch looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
>  tools/testing/kunit/kunit_kernel.py           | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentatio=
n/dev-tools/kunit/run_wrapper.rst
> index 19ddf5e07013314c608b570e297a8ff79a8efe7f..6697c71ee8ca020b8ac7e91b4=
6e29ab082d9dea0 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -182,6 +182,8 @@ via UML. To run tests on qemu, by default it requires=
 two flags:
>    is ignored), the tests will run via UML. Non-UML architectures,
>    for example: i386, x86_64, arm and so on; run on qemu.
>
> +  ``--arch help`` lists all valid ``--arch`` values.
> +
>  - ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
>    same argument as passed to the ``CROSS_COMPILE`` variable used by
>    Kbuild. As a reminder, this will be the prefix for the toolchain
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index d30f90eae9a4237e85910fd36f7f1c731d952319..e04195b135edc8f1aabe21d09=
4b276e47c4f6848 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -14,6 +14,7 @@ import os
>  import shlex
>  import shutil
>  import signal
> +import sys
>  import threading
>  from typing import Iterator, List, Optional, Tuple
>  from types import FrameType
> @@ -201,6 +202,13 @@ def _default_qemu_config_path(arch: str) -> str:
>                 return config_path
>
>         options =3D [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.en=
dswith('.py')]
> +
> +       if arch =3D=3D 'help':
> +               print('um')
> +               for option in options:
> +                       print(option)
> +               sys.exit()
> +
>         raise ConfigError(arch + ' is not a valid arch, options are ' + s=
tr(sorted(options)))
>
>  def _get_qemu_ops(config_path: str,
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250220-kunit-list-552a8cdc011e
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

