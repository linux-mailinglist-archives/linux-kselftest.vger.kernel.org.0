Return-Path: <linux-kselftest+bounces-1133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28A8051E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962231C20B34
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5C5675F;
	Tue,  5 Dec 2023 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP4HIHup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58962184;
	Tue,  5 Dec 2023 03:17:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso2337583e87.0;
        Tue, 05 Dec 2023 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701775061; x=1702379861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iI7MNYltXP/pFO87Lkqjtj0O5CyAgLwLAo0fkrJE6Hk=;
        b=dP4HIHupoDaUrRdXC6/3nhxStEoAGkfozR7nMkZtdng+eB+A5PgdBy9gzD5A1b3FSF
         EmVCp7aRzQbnCN20lKjaz9IAOT9eB6i7JbFLJyEvl8Fo3a2Hz+tv9dr6lwuCubVv0fVp
         vObs1xqCl3urp4Ea5jrK+/VKR8rLCOvGDee2wF781mjNA1hy4fuLqKwPJj70ituzoDgu
         +iUuqZQGl59e4EuRrXP0RfcMVZ/kmZmMr+jsIom3Y14mxQu2Xx94eKWJWQk2CFRRhkZD
         VYI+OJtKAVo3qhRj3m09fTRXYHN1wXBy32jRq50qWTWidBczklwITM++GDpi2awQ9Clk
         9JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775061; x=1702379861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI7MNYltXP/pFO87Lkqjtj0O5CyAgLwLAo0fkrJE6Hk=;
        b=msAt2mlxO2Yfv9RjAx3Je1dnUYGhr7RR2xzVaC1RpYS++5a8jmnUhjQgWFkkDJcdDa
         /3Wnk3bSD67Urbn+Vp8Ztc1ri1G4Mux4ainJEYch0R8cTrHH6v36cohFdj62aKr4Onso
         S35HIaHtJ4496ipGH7Ov1KoCJfZPmk7tH4xHmrcqKORFOpyykT1qfnvVgLDrGD++wpnt
         vxLLiL9ZZXCj+w0uzjfUdM+cX8zXpG0qe46B4Ene2PhROGNqGPOFl2YghAOs/X5KVW/g
         OtZhEojAAetcguuZWV3vm1PWDOGOCXTARhqF1rsmweYEkm0Fkw0Ug/Me5GR1Cs3f6Hv3
         HN/w==
X-Gm-Message-State: AOJu0Yz+0N8fjhUDDQ0Bnn09UBHgDGeA/IwFSJqycxv70e7drF+nj/Nb
	G1/wjoEZAn/AlIf35Gm4jRc=
X-Google-Smtp-Source: AGHT+IHEN61nwDvELtOai4WeGBT9eS7LRDhWTpi6AarU8d/CaG3ducgh6GQhHOrB3Cg4T2+3Gc6DXw==
X-Received: by 2002:a19:c507:0:b0:50b:feb2:dac9 with SMTP id w7-20020a19c507000000b0050bfeb2dac9mr873236lfe.2.1701775061066;
        Tue, 05 Dec 2023 03:17:41 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7cf0f000000b0054ca7afdf35sm936627edy.86.2023.12.05.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:17:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Dec 2023 12:17:38 +0100
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Robert O'Callahan <robert@ocallahan.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf
 program suppresses SIGIO.
Message-ID: <ZW8G0muteKBhP18a@krava>
References: <20231204201406.341074-1-khuey@kylehuey.com>
 <20231204201406.341074-3-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204201406.341074-3-khuey@kylehuey.com>

On Mon, Dec 04, 2023 at 12:14:06PM -0800, Kyle Huey wrote:
> The test sets a hardware breakpoint and uses a bpf program to suppress the
> I/O availability signal if the ip matches the expected value.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  .../selftests/bpf/prog_tests/perf_skip.c      | 95 +++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> new file mode 100644
> index 000000000000..b269a31669b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <test_progs.h>
> +#include "test_perf_skip.skel.h"
> +#include <linux/hw_breakpoint.h>
> +#include <sys/mman.h>
> +
> +#define BPF_OBJECT            "test_perf_skip.bpf.o"
> +
> +static void handle_sig(int)
> +{
> +	ASSERT_OK(1, "perf event not skipped");
> +}
> +
> +static noinline int test_function(void)
> +{
> +	return 0;
> +}
> +
> +void serial_test_perf_skip(void)

does it need to be serial?

jirka

