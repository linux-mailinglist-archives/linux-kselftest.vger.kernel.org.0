Return-Path: <linux-kselftest+bounces-14250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993793C983
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 22:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F42281BA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464C78676;
	Thu, 25 Jul 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae+9tJiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446043CF5E;
	Thu, 25 Jul 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939243; cv=none; b=c9A8oG4oeeCkjGz695QF569/q8SZ7zru61b/msaMw1HWNKI6dT9Nvf+R75OLsACnLMckIa2UcNKr6gN0LdsmlbaBCbcD4ZcG7gqDRTHh9iqgqOXxMtTAccpsN51LzSk+6QG1qNRv0cscXz9bG86jCWbyQI1YL9e63juudFX2ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939243; c=relaxed/simple;
	bh=rIhpQcHLexoU70NqZ5sOXp9YztY0XGAmkJr7EX7Zec0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdL7B6v9711rQBIxi5IbFO8G6gkY+EFdt046T05MOxKEy3WxX1iuanxbEavHLg5q/lfzwYWWOhAVw3Ju5XKWg2sRKPk7rXO7/zX5135K/kfX3YtPVYu+wS9xnzJlcerTDhUSzYmQeBogogcxbgLeNX1M1ZWC03jJfo09nX+z7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae+9tJiR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso1749735a12.0;
        Thu, 25 Jul 2024 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721939241; x=1722544041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb8R8eLBfLQ4PUNDUO5vUKAo7AQFDp2s++IGNkKCcOU=;
        b=ae+9tJiRkkj62a7svvO+rXa5DaDX/1KEbj6sgYv4YviET/tw1nAf706w+eGRZxCrhX
         tuRZgI9P4E8KgtDmPdp7Mgr1IOEJWHSQknR9PLdsAXBWiaQWJtEC638UU2sC1A0koRVS
         nTgyQd4kzA1DtMbC7VsRaT1wibxS4jbi8tuET+UYvjGONjMocR+sLE2qaKQVljNrDlEk
         FjvKcBijJmVnH+8oQYxOEBTiRjGALVp3sd0P7eveuNLLEYhrY+zT5rKIdzbYHs7ft+Wn
         15ErJMo4N2Wv2jYVAi1Eo7q4Ge44rAU9Eh/jY+2/et5uGgaiAMQ6rw/njJLbFVeIdZEe
         1MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939241; x=1722544041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb8R8eLBfLQ4PUNDUO5vUKAo7AQFDp2s++IGNkKCcOU=;
        b=fx/wanWJ/KXEfyQDCj7pemQ96itlS6rWpm6RfsHomApNEN+44RX0Y0r20BpTtwgSO5
         t0IaKfnJJAmwABEWDFCjGXbv0bYt3ep7/16oM4HdSukjfIQBFf5oQ3K9RNcvI8AobpU/
         ZCK1jGG2UWEmyQCsJiQc+jkO2/kW2TeWqKuy29uVH4z6kDvvq+sAoh/rzcpSVMsNZaU0
         H20UgONAkOXGPf3wwIe89PqMANEIiLzYkLOBZ0BcNgSzJWywQ0EoFpcA6b0Iz9EMSG2/
         mChW9h2a27imloBXPwU/69ux1OgB8glXSQGY6edvS0HOfniXXmKcIzvdD6n9PH86YXxd
         tRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYa7SZQ/PRMHi2sDE/FZqRTgvj3kmVCZG2qX6xZ442NIoys3cPZnG5MFlH7zUxcuiPUOo7BFRqShbPtf2jmqU8NgxU5x+NSQ5ishzzMIgyR+uFcQONWY5VZ1B5Hk6X4Fi7OV3Q+Rn5
X-Gm-Message-State: AOJu0YzXAGktiObayagt2ywNFliecEbe76TX+C0JwmwOY2AZulPCB8Mh
	PJCbx2PaM+I7uFKPNFzj8Nzkmc2IiWj4fUVIF/6HiAxRDaShDz2vkF222gSHeeUzNZkpbnb3P9X
	moa61pcbP6D/RYb0j+Vhekxng++8=
X-Google-Smtp-Source: AGHT+IHy0L9fRJnYe/XWQ2G3znrbvTEGOOqdD/yftu7hGD3FQIOewEjpOrlI1k//aSVXc/6tZg4DbEx80E2UNXjLfxo=
X-Received: by 2002:a17:907:a46:b0:a77:b054:ba7d with SMTP id
 a640c23a62f3a-a7acb92ebe2mr168245066b.46.1721939240288; Thu, 25 Jul 2024
 13:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721903630.git.tony.ambardar@gmail.com> <847a5b798f24e81b9dec4e8d9eb3eb1e602a909e.1721903630.git.tony.ambardar@gmail.com>
In-Reply-To: <847a5b798f24e81b9dec4e8d9eb3eb1e602a909e.1721903630.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:27:03 -0700
Message-ID: <CAEf4BzauQQgWfc8eKsWF+Fr-j--oY6tJAM2+ZfAPHP7JJqZ6Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Fix using stdout, stderr
 as struct field names
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:39=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Typically stdin, stdout, stderr are treated as reserved identifiers under
> ISO/ANSI C, and a libc implementation is free to define these as macros.

Ok, wow that. Do you have a pointer to where in the standard it is
said that stdin/stdout/stderr is some sort of reserved identifier that
can't be used as a field name?


I really don't like these underscored field names. If we have to
rename, I'd prefer something like env.saved_stdout instead of
env._stdout. But I'd prefer even more if musl wasn't doing this macro
definition, of course...

> This is the case in musl libc and results in compile errors when these
> names are reused as struct fields, as with 'struct test_env' and related
> usage in test_progs.[ch] and reg_bounds.c.
>
> Rename the fields to _stdout and _stderr to avoid many errors seen buildi=
ng
> against musl, e.g.:
>
>   In file included from test_progs.h:6,
>                    from test_progs.c:5:
>   test_progs.c: In function 'print_test_result':
>   test_progs.c:237:21: error: expected identifier before '(' token
>     237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->=
test_num, test->test_name);
>         |                     ^~~~~~
>   test_progs.c:237:9: error: too few arguments to function 'fprintf'
>     237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->=
test_num, test->test_name);
>         |         ^~~~~~~
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
>  tools/testing/selftests/bpf/test_progs.c      | 66 +++++++++----------
>  tools/testing/selftests/bpf/test_progs.h      |  8 +--
>  3 files changed, 38 insertions(+), 38 deletions(-)
>

[...]

