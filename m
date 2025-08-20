Return-Path: <linux-kselftest+bounces-39417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D345B2E8A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C87189781C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC122DE6F9;
	Wed, 20 Aug 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nst3Rw/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A2280312;
	Wed, 20 Aug 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732375; cv=none; b=I2n2xmZ4j42bFu8PTOTDgIEIfgru+VnrbMcLjYEid5mMFYu5EqkR/n7my+OLONbyYeE3DL15VxTOm7sRjW0O9UT6SvkHE+JXGrXlOg6lSq2Srv63Zv/ZWm7IjmuJv2+Oj3xtJdshJiRLpA600BeGgaQ7JXT2l4DtYqDqrDqsCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732375; c=relaxed/simple;
	bh=b10TlkvbmvDi0x4GzXCIZCojhHmwVxsqmwh3eQrGkO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5KkYP/CKcTuGQm+4NhGcPOXg3c9ec18Q2bS+DVqUILs6VwkxDy6M/VC8Rooug44ugCSHPfEt2QzZRPN8W8/kL0zIySOgOJ6HBLFAV2WUC8KNiFpX6BIhjQDQpZ/TesCRfrWoRsy9kkQVkySixCzOWxz3bwR4NIBivNj4yfFkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nst3Rw/+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4717330f9eso254414a12.1;
        Wed, 20 Aug 2025 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755732373; x=1756337173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWAYEZlnzW0EYER//uhfeVSUakJM7nTK+2ZKfTrr0DI=;
        b=Nst3Rw/+T6oFNpI3qKD3csAj0gMnSh2ROVgq2JXK0BeBmWQL+tVUdD6Zu75TXi2rTN
         NPy7eiVP2uLLt8FWjPzgeYw07umC6QpiO3QIMyI8Pkth3qoE0obBv4br1/51b6jcY+8v
         DjeUggTBsK5g1uS/xdPQOEGTQdTQzyyxJ0EIYe1F7zuYURvNZlnWq200rM49b3qc81AJ
         wXPSGuwMBdB8qdXjBguFMhUTlnjjdHiDbSPsI9nlVsGDnHrXem/8/3fmt4Edgw6z0sjl
         Q0uRuNg8gQo20t8RXoD7CAO11F9dqckBZ7mOP3kZTGF4s2lezCuhKZ5/p5wFjI3gZMO+
         bEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755732373; x=1756337173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWAYEZlnzW0EYER//uhfeVSUakJM7nTK+2ZKfTrr0DI=;
        b=VQiZiwTBK82GY8XzWSIL2o5hX+itOjK3anM2U+ClR4T7ZGhA3wy0R3BU3tF4ZhFyGy
         +tiRwLQSzsb9Plc7NnSKz16h3LzLIyGTq1A8zpu2MWfTZwXf+qKzi5idYZ38kVGF4qUB
         bDWi3wEcyxD8VrMwhGJw4yQke1JpuV3I0FZxWq7x46JYgLPnUeNl+7NDV3umKbE5jQU6
         +dNA5l0kuVM+sDvtDuZamDXkmiSjcO4O/bIiFvrf9obifjJ5x0J48I+ZI67UGLdStqi8
         4EsSedU+qMTFF6z5eH7+id3TptLcbz3U5TNdu6+YzCScJ3HylmtvBrGuU1d6wOLdgHus
         jttQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkkNaqJq4SyQbnKITSEbTH8sqyU2rkqQMIWa4DpFImnrVrTfCYBpEkpRuDdBb85heAI3WUCuGmJHIZ41KM@vger.kernel.org, AJvYcCWQaqxA5Ekka3njDh3zyYJxGR4WLquzZeytaof63rAF991g6m0Q+2PXWsm2F8UbJzzUwPw=@vger.kernel.org, AJvYcCXm4SdfYe4Zj2zP7rdf2WFfStq7tu0LTilxui9j9z/qvYRTp8lvapPHL6N8eJtDi3Z4qr6+fnGetjdxJhRzpveh@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvZoD8dpLMN35V+2VvNYr/L2RBgQ1YyUigrUryxjd0k2vkops
	P9x59lH+AC7R2u3Op50ZGHkF6IQzw5roWo3W2NK7dvAUF6qLXH+J8tCNDBlP1gQJ7sLGuR48ach
	HBmYtK3g7r6Dl9FNu8+N2F7pp6z4CzPvBkFwq
X-Gm-Gg: ASbGncsMTsZ+zURsydZcdLXRTw2GCDp8HkygGxHDuPYSifVB8qi4nYvAahUzSs7lWAR
	FMQqqedam6VIP03t3ov6SuDaNmMGmNPtuhiJdlnGoSCYTLLM+wx3cshr/QFb5GUMGjDLYAz1eD4
	D09MASySZkoG8TO/L8BJKJbSe0pv5bxpTs7EhkaugfIDRlxUxxGK8VBg4evMzaliMSiL/pOI1YZ
	kjFWyEe1L28lMcZnS/C4Fs=
X-Google-Smtp-Source: AGHT+IF5tSFWnEet2TpRRgscQg+yziokErCe/YK3oBy3u6xnr0YYp6+tCU9SMfzbRjVSuDSsd12nsV7ZaIlENScMPEQ=
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id
 d9443c01a7336-245ff87a0acmr5688245ad.51.1755732373203; Wed, 20 Aug 2025
 16:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074632.433008-1-phoenix500526@163.com> <20250818074632.433008-4-phoenix500526@163.com>
In-Reply-To: <20250818074632.433008-4-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 16:25:58 -0700
X-Gm-Features: Ac12FXwtZhwDSYveEhsotjsmijdZwetMC94VSjNrj0mw_p3WWFPrhZB7PFhmnGw
Message-ID: <CAEf4BzaGUhYmUyVZbO18fMYaWphPu6btuHomqx-D2Fk_BD__rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 3/3] selftests/bpf: make usdt_o1 reliably
 generate SIB USDT arg spec
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:46=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com=
> wrote:
>
> usdt_o1 is intended to exercise the SIB (Scale-Index-Base) argument
> handling in libbpf's USDT path. With GCC 13 this reliably produced a
> SIB-form argument (e.g. 8@(%rdx,%rax,8)), but with newer GCC (e.g. 15)
> the compiler frequently optimizes the probe argument into a plain
> register (e.g. 8@%rax) or a stack slot, so the test stops covering the
> SIB code path and becomes flaky across toolchains.
>
> Force a SIB memory operand in the probe by:
> * placing the base pointer into %rdx and the index into %rax using an
>   empty inline asm with output constraints ("=3Dd", "=3Da") and matching
>   inputs
> * immediately passing base[idx] to STAP_PROBE1.
> * only enable on x86 platform.
>
> This makes the compiler encode the operand as SIB (base + index8),
> which in .note.stapsdt shows up as 8@(%rdx,%rax,8) regardless of GCC
> version. A memory clobber and noinline prevent reordering/re-allocation
> around the probe site.
>
> This change is x86_64-specific and does not alter program semantics; it
> only stabilizes the USDT argument shape so the test consistently
> validates SIB handling. Clang historically prefers stack temporaries for
> such operands, but the selftests build with GCC, and this keeps behavior
> stable across GCC versions without introducing a separate .S file.
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  .../testing/selftests/bpf/prog_tests/usdt_o1.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>

See the suggestion on the previous patch. sdt.h has STAP_PROBE_ASM()
macro that allows to trigger USDTs from asm block. I have never used
it, but this looks like a perfect opportunity to make use of it. Can
you please give it a try?

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c b/tools/tes=
ting/selftests/bpf/prog_tests/usdt_o1.c
> index 706168e804cb..6c04519b3757 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
> @@ -18,11 +18,19 @@
>  int lets_test_this(int);
>  static volatile __u64 array[1] =3D {test_value};
>
> -static __always_inline void trigger_func(void)
> +static noinline void trigger_func(void)
>  {
> +#if defined(__x86_64__) || defined(__i386__)
>         /* Base address + offset + (index * scale) */
> -       for (volatile int i =3D 0; i <=3D 0; i++)
> -               STAP_PROBE1(test, usdt1, array[i]);
> +       /* Force SIB addressing with inline assembly */
> +       const __u64 *base;
> +       __u32 idx;
> +       /* binding base to %rdx and idx to %rax */
> +       asm volatile("" : "=3Dd"(base), "=3Da"(idx) : "0"(array), "1"((__=
u32)0) : "memory");
> +       STAP_PROBE1(test, usdt1, base[idx]);
> +#else
> +       STAP_PROBE1(test, usdt1, array[0]);
> +#endif
>  }
>
>  static void basic_sib_usdt(void)
> @@ -66,5 +74,9 @@ static void basic_sib_usdt(void)
>
>  void test_usdt_o1(void)
>  {
> +#if !defined(__x86_64__) && !defined(__i386__)
> +       test__skip();
> +       return;
> +#endif
>         basic_sib_usdt();
>  }
> --
> 2.43.0
>

