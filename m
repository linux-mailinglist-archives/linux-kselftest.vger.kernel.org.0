Return-Path: <linux-kselftest+bounces-1106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0C804869
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 05:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC22B20C1D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F8C8ED;
	Tue,  5 Dec 2023 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD+6kY7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2BD3;
	Mon,  4 Dec 2023 20:05:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1a496a73ceso487463466b.2;
        Mon, 04 Dec 2023 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701749139; x=1702353939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k7iixUT5DlTn6h1rQEcCyY4ImOO7JGoRLtRpOFAc8o=;
        b=aD+6kY7oEUbMvsvS2Ooh3gkQdxirDXK6g3GM8e6tdAFewVrLnfdUwDnngAvdTZVJ8O
         pz0wuZkkEx5TDOR2InNCU3utlYmTA1hktnTQO49mkAeIEUA8KILiw33s6VA70EBU+RsB
         Z2iTkA9FaqYSHR0EXimsGxFqH35GwEiEVcCsEoZUCf3IRvxeWcXMb+NYFZHs2ti0ILFS
         oWjqZLdS9qq7FMO3Tw7JyJ2WweibHtyCFf2fbb/Y7sQytyZfRjJueCzQJ3W2EoVjJ0pQ
         LGaG/j/tzoOdSklfwrnBB7xKUWI9jpwlQpuQzZOqya1ikYxKRjU0pyXbe/UY1gXuR9/I
         L4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701749139; x=1702353939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k7iixUT5DlTn6h1rQEcCyY4ImOO7JGoRLtRpOFAc8o=;
        b=pqXf5sFQr32oHyMLsVPZFPJjlmQBCQamJbtSu4ISnDXkiNXyu/hvK2nEos/ECZ/ARg
         VcN1Oeytkw4Mb1ivBf5eE72xv87G8Ctn055ulkkcoHumobJ2yYZMAs9G87dBu3MTUkOa
         DAq82gRhvSmOQFrvJw0z9sapo0GCbMF7DZ4w7yw/iqj8NYd6Pf8z9jn2/EtiBSf8f66P
         RkWiRitqhYDw8P01jv/ERa3g7FJsd6Zcnqx6CLZqie32nTDv5DSRarU3xqXfI4fBIFp7
         HTFW9rdAj1yyZ8OykB2B+latm8deULUC9hE2dwDHpcyX3odUFZWN9C3Bcwmi45duhSUC
         fLaQ==
X-Gm-Message-State: AOJu0YymP7pfpEyv8PnQm1gln0QgORc8oB/RUUybd3WPAOCDZMJ3N8Ki
	CQMaCLSPV2aJo+qGHfMBh6kDhGA2D41omkFEXqI=
X-Google-Smtp-Source: AGHT+IGhkddhCDG4agTaAdkzi8AdH3aBcGfj7PIzbkB3LUqn1FwhtskDdgNCANy5y4jv4mBcMUfEpAn5GNED8IQXEcw=
X-Received: by 2002:a17:906:10d0:b0:a19:a19b:7897 with SMTP id
 v16-20020a17090610d000b00a19a19b7897mr94028ejv.90.1701749139497; Mon, 04 Dec
 2023 20:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <d47d9105686551f0435091f45888bc64d1101bd4.1701722991.git.dxu@dxuuu.xyz>
In-Reply-To: <d47d9105686551f0435091f45888bc64d1101bd4.1701722991.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 20:05:27 -0800
Message-ID: <CAEf4BzZPwHnGf6kirHg+wiNQ-y51GS5Qid4sFykpCneESP1fDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/10] libbpf: selftests: Add verifier tests
 for CO-RE bitfield writes
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, shuah@kernel.org, andrii@kernel.org, ast@kernel.org, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, devel@linux-ipsec.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:57=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> non-trivial bit fiddling is going on, make sure various edge cases (such
> as adjacent bitfields and bitfields at the edge of structs) are
> exercised.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

nit: please drop "libbpf: " prefix from the patch subject, this is
"selftests/bpf: " actually


>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_w=
rite.c
>

[...]

