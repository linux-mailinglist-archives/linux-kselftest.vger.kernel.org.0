Return-Path: <linux-kselftest+bounces-19170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0F9933AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C69B22F63
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21E1DB34C;
	Mon,  7 Oct 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFpqTEZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F0210E4;
	Mon,  7 Oct 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319536; cv=none; b=WYdhkk8F0IIRkMyPH25eGh3HZZky+D1vLE3f2fhKWfCEysfO8qdC+RT6FrpH02uwHbmI8kDhcOOL0FKB6bgtea+l+d6Je7a5dkEXOWkoPa+2DSjnBUpPcJY0eYyPAP3QzfJfwkPMA01j05ExvsFceRuB482u0VXMGp30UFn110A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319536; c=relaxed/simple;
	bh=RHLEWzCLyBN4xFFOl+qf15YS/UdOA1RB+ZXNvpTNpWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBpxHEy3jbCtzbKs+dnCi9673EZhlo3kveOoWweMNg5zjWbSkN3Uhtg5fWH6xy95pOq0Vk4mqqfHUOk0gELSwJm4jySRfabIP/WSNKoK+nyQ1q1FxCHRlO3Mne9FWdmjhzfXJx9/UmyFZLgoSHcj97Vdgb9JeLyonsdg0kjVCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFpqTEZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B8C4CEC6;
	Mon,  7 Oct 2024 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319535;
	bh=RHLEWzCLyBN4xFFOl+qf15YS/UdOA1RB+ZXNvpTNpWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JFpqTEZouLwUu4N+gjdJrc/Rc6hlA9F+JKUncCBWBDKlFVq267zmTBUSEnemXr5/F
	 0p6Af4rNvAtTuc2BsI9iWuH8FehyWQ/Wjya9t5tGjNnaDsXFfiIDBWwnd8P+zaCqt/
	 vRJnMzpd8Gba5qKWgRShwexTkj9QKexMmo53xcfDf6TXg+FuqXsWJZ20b5kdMowEIo
	 JHtY1qXK72SD2ZqaWeSB9oElI+Ui2XTHIcye8i4h+mi4/OwWM3JgetOQ3IOHj7KrPW
	 MWXY6EoqiGjG7TXPQQwh1yLkvhpDKjkKf3c4yVxJU4TCGM+RdZmRI09bnY2+ETyOHD
	 0rtJTFbKPo02A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] selftests: sched_ext: Add sched_ext as proper
 selftest target
In-Reply-To: <ZwQKRe7iIzZjjEQd@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
 <87r08rnbra.fsf@all.your.base.are.belong.to.us>
 <ZwQKRe7iIzZjjEQd@finisterre.sirena.org.uk>
Date: Mon, 07 Oct 2024 18:45:32 +0200
Message-ID: <87msjfn9oz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:

> On Mon, Oct 07, 2024 at 06:00:57PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Mark Brown <broonie@kernel.org> writes:
>> > On Mon, Oct 07, 2024 at 09:31:32AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>
>> >   CLNG-BPF create_dsq.bpf.o
>> > In file included from create_dsq.bpf.c:9:
>> > /home/broonie/git/linux/tools/sched_ext/include/scx/common.bpf.h:33:17=
: error: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
>> >    33 |         _Static_assert(SCX_DSQ_FLAG_BUILTIN,
>> >       |                        ^
>
>> This is most likely due to incorrect VMLINUX_BTF_PATHS, so that
>> vmlinux.h is incorrectly generated. Try grepping for
>> SCX_DSQ_FLAG_BUILTIN in vmlinux.h.
>
> Yeah, it's not in the generated files:
>
> broonie@finisterre:~/git/linux$ grep SCX_DSQ_FLAG_BUILTIN ./tools/testing=
/selftests/sched_ext/build/include/vmlinux.h ./tools/testing/selftests/sche=
d_ext/build/obj/bpftool/vmlinux.h
> broonie@finisterre:~/git/linux$=20
>
> I didn't actually build a kernel, if the build system needs a kernel
> it's just silently not detected that it's missing?

It tries to find a kernel with BTF:
  | VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                         =
           \
  |                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)   =
         \
  |                      ../../../../vmlinux                               =
         \
  |                      /sys/kernel/btf/vmlinux                           =
         \
  |                      /boot/vmlinux-$(shell uname -r)

Similar to all the other selftests using BPF.

(Oh, and at some point the BPF parts should be in lib.mk...)


Bj=C3=B6rn

