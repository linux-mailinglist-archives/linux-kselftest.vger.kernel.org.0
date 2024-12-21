Return-Path: <linux-kselftest+bounces-23712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6949F9E19
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 04:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B94188DD7E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E21D9A60;
	Sat, 21 Dec 2024 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQN/eqnk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F79191F88;
	Sat, 21 Dec 2024 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734752519; cv=none; b=Kgabjel8b0SmPrGSXvcsy5nMNiJsKfKCZc2Yjq+qYVlpBSmuAAVzfS/qG/XP7LaYz5xU11rJFLCYBTwlwk4KLY/OUsRl5ypi1OHWn4u5KJbSsMwIj1uPxjjkL2LiT3GMtp22BtgVTTfwxxy6HlQBii3bcOXdCxhDFZ1fE4iqEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734752519; c=relaxed/simple;
	bh=yG9MP6/1nDTaMeFSwhjRT+j3EwObKL+mO76ZF2tLz3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5YJCrn5d9sxeTeu+/uTMwKmEw5Sj6IHOBRt/RikLQ4CGWHaXS44PmTvZq7NfQJwjGQTxHJXCk12Q4RY2AAI6wEThxIlLqAvsB4zqTr+r6XGqkUYzeWFxgOLaC6PMFH6tzXM0dwTBnvHmCG7TWCy37zP8oqU7VpdpsKxPNoMrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQN/eqnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BF4C4CEDC;
	Sat, 21 Dec 2024 03:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734752518;
	bh=yG9MP6/1nDTaMeFSwhjRT+j3EwObKL+mO76ZF2tLz3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HQN/eqnkhplQgwaYqx6q/aYlGAAK3XbLp2SEXTYmh4ODuWAOhYYbhRgPEPov2Sr/6
	 aeddXVi0PCLkolnEQ0OOfYPW8iRgtmA04BMZz4rEEMopWfpMVn5O5N8lzzBmxoTM59
	 hAcKGIMI8f8jBbZcliMw6ZKRkCytJqoyuwbu/SEjRzLNq7RvGFdz79ZDQkuw53YTu+
	 UfCoOCOC+8iYC243Vzc9mpJ01tovi7gtZL4IgXYvf1FjKrCz/h2arxGFKuCOfyrXRV
	 4erL78nkO88U/+wiuXx5qA5oYKMSkqG/YZ7PyHTtlFNfmGLB0h3B4XemvMa4xZk+cZ
	 3HeejBGaly6Qg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3c47434eso2650973e87.3;
        Fri, 20 Dec 2024 19:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMCwau5LA8QOc7VLcXzBoK9GVYsNf20WX1tBKP1FU2DMMJcpTt+9Ra6FXuhxTuTXnxyQNT8vCsBzgHFkRG@vger.kernel.org, AJvYcCUtaGK008EQvVgn184xWeKF09VKJxZQWjUHXSh4WfPfUD8kgoC2DWayXIg/vGky+hgZtb7/uhJxN0zgJkWNvhfq@vger.kernel.org, AJvYcCV4Cot6HWo0gMdrdH2t/j+3Nxs4bp2zD85Yih4yc3umO8I/zIIdPfLE8/MtUs9gBeVy+5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyhYrzsq3Cq5mRILGzqNsAa5hvrh8AA5Di9BD3Nn0xrHKLeLD
	yKkT9lCrEpWBL0k1KHz6bg6mQ79ksZCdbvbZLacQhmSQmRKdLNpY+RgOrFV7JHPah5D/keeXa1T
	UhYJOL0Qy1QEq59Aq9Yig1I9qeqU=
X-Google-Smtp-Source: AGHT+IHIP6YEkUj/lGilUyhY5zs38Ycs0bicoiYQQh+9XbXFMhOFib18iKHw3u5M4pvLfqhkO62vVO5dxMj4pGpnNzc=
X-Received: by 2002:a05:6512:230a:b0:53e:28e0:cde3 with SMTP id
 2adb3069b0e04-54229540697mr1491984e87.30.1734752517474; Fri, 20 Dec 2024
 19:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217031052.69744-1-lizhijian@fujitsu.com>
In-Reply-To: <20241217031052.69744-1-lizhijian@fujitsu.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 21 Dec 2024 12:41:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4yrEvvDOFdHyNxBp9Yzi9=eGRsO+2R-t+NNTOfp=gHg@mail.gmail.com>
Message-ID: <CAK7LNAS4yrEvvDOFdHyNxBp9Yzi9=eGRsO+2R-t+NNTOfp=gHg@mail.gmail.com>
Subject: Re: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:10=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com>=
 wrote:
>
> Fixes an issue where out-of-tree kselftest builds fail when building
> the BPF and bpftools components. The failure occurs because the top-level
> Makefile passes a relative srctree path ('..') to its sub-Makefiles, whic=
h
> leads to errors in locating necessary files.
>
> For example, the following error is encountered:
>
> ```
> $ make V=3D1 O=3D$build/ TARGETS=3Dhid kselftest-all
> ...
> make -C ../tools/testing/selftests all
> make[4]: Entering directory '/path/to/linux/tools/testing/selftests/hid'
> make  -C /path/to/linux/tools/testing/selftests/../../../tools/lib/bpf OU=
TPUT=3D/path/to/linux/O/kselftest/hid/tools/build/libbpf/ \
>             EXTRA_CFLAGS=3D'-g -O0'                                      =
\
>             DESTDIR=3D/path/to/linux/O/kselftest/hid/tools prefix=3D all =
install_headers
> make[5]: Entering directory '/path/to/linux/tools/lib/bpf'
> ...
> make[5]: Entering directory '/path/to/linux/tools/bpf/bpftool'
> Makefile:127: ../tools/build/Makefile.feature: No such file or directory
> make[5]: *** No rule to make target '../tools/build/Makefile.feature'.  S=
top.
> ```
>
> To resolve this, the srctree is exported as an absolute path (abs_srctree=
)
> when performing an out-of-tree build. This ensures that all sub-Makefiles
> have the correct path to the source tree, preventing directory resolution
> errors.

NACK.
This negates 9da0763bdd82572be243fcf5161734f11568960f

This is a recurring topic [1] because kselftest adopts a completely
different build system.
If kselftest cannot do this correctly, please do not hook it to the
top-Makefile.

[1] https://lore.kernel.org/linux-kbuild/cover.1657614127.git.guillaume.tuc=
ker@collabora.com/



> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Request for Additional Testing
>
> We welcome all contributors and CI systems to test this change thoroughly=
.

This is NACKed. I recommend not wasting CI system resources.






> In theory, this change should not affect in-tree builds. However, to ensu=
re
> stability and compatibility, we encourage testing across different
> configurations.
>
> What has been tested?
> - out-of-tree kernel build
> - out-of-tree kselftest-all
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index e5b8a8832c0c..36e65806bb5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -275,7 +275,8 @@ else ifeq ($(srcroot)/,$(dir $(CURDIR)))
>      srcroot :=3D ..
>  endif
>
> -export srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
> +srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
> +export srctree :=3D $(if $(building_out_of_srctree),$(abs_srctree),$(src=
tree))
>
>  ifdef building_out_of_srctree
>  export VPATH :=3D $(srcroot)
> --
> 2.44.0
>
>


--=20
Best Regards
Masahiro Yamada

