Return-Path: <linux-kselftest+bounces-6898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB08924C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC191F223D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D313B292;
	Fri, 29 Mar 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PpdbJ3dL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946081752
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742538; cv=none; b=J03vkgNNdcy7W3uPYia+Gtk5+Vz2khBM3gheXhF1ffSJ8yhDxyuNtd0QdKGmw8UiBgbT73pOQd2KhTLbHqPS5SbqWyKOCSBL0DW1kbByJM5R/ujnQTrkiCGFO6bE6BsS24CSxig6nFHLeMnBDe414RQ1tBJZQNo3YO7k5zRc1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742538; c=relaxed/simple;
	bh=4s7FSUVD/FVF5uIwuXZCch5XKC36897y0OwJwUbVkWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcdgzo6KQyAHEEl9fA3phpORxwxjM/+JfuRPv9taZzFNX44pkt6s0E4jkQspUiZ/J1KxrAYZctafbFlZmslv47AqnrcLNimd8OdDJmSKl4iEyTsq1pUvdRQYidkgRr2d+UKGQpKvakSY3Fnz0zHxt9SFzy6xFonl6hE5i00iu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PpdbJ3dL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3015189276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711742534; x=1712347334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t40h4ZVVyU3YcHuS3ADegeoOz9PnpHCj92mWxUgwXKE=;
        b=PpdbJ3dLERUkITJYMoM+a1cy/96JymF+wE1D1yJKQX5faXTDoD72D6WoH0axtT/aSs
         Yz/BoJn7V8VbfqVkGpvBGRA+tAP/tOHT8chsRJ682qF6ZbPVud3ICpQAs/RhzGMdi43F
         IwKLEhFhZpo48O/UbPyEolSn8HVhWo2fHAzMZenHzcYFXxgwE3iKO2XLjTlRSHjfRj9+
         340BsyUD6TQCaikIUq/1pc/GuyEyw4xOWRkXnGOGw+gd9kxQNwUbzQ+rmWiNgxf9lKl4
         zpUZona16fJXAtqbsRG65WeSQpklE2v1ubUdzBXVoIDFbkLAsfzspl5VW77VM9K48Awi
         FqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742534; x=1712347334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t40h4ZVVyU3YcHuS3ADegeoOz9PnpHCj92mWxUgwXKE=;
        b=my0sNIEreoTCqVzcZ60YFDdVCkYt2SBRV5LQHvSF5t8Yjg68MRnnaNLf0luqd2eCqq
         p6mlp9UXn38ygu2yjGJvlqjYuloMRU09SQOnSDuU0or2kOh98SC5fLzbYtN5dWDWo9sb
         yUOobLynBdP7ixqGYIphfmBiLQ3MoodoUpijNiLKn9Bm3ARbm3jpHgIZjymfZ3saLIVP
         GYxJukWcCfCdIO+aT9Syva+EZijLvNvNygcvfPp2duLGVV4e8kseKhmxzo5RhiPbvm96
         Ix0smnV+lL8fNOu87qU/f6QGR007krBbPvXsCKGJyoiAxjAU3rDfOgCJ/W14stS1LUwV
         e3ug==
X-Forwarded-Encrypted: i=1; AJvYcCWkWXo6oC+Ks3YvsGPJnGBXQz7DYSQCrsO8TYXSH+AzN/XXcjwK5fi1A6Oa2MnfqWWcP3m+KtspA3DQEdaEGVaPfd7yr/Dmd0Zf9LX/tFhT
X-Gm-Message-State: AOJu0YwPxBE5U3l3g3L6mHfwZ0Ja4Aui4kupg7zfPxwlWE1pLCFMBazi
	9aKZJbBjEAZ1wYI+Q6axi4BW0rq6K/wNM/oJ9Dc2qtyQdTdaye9DyI6ZzezCEfXxPlYetVoB0XS
	EQ4JKdPJOxeOY4G/uR0ihPWZQlDf22u0coPofqA==
X-Google-Smtp-Source: AGHT+IGtnKg+yyXhs907Pora7J+RzD45KJQ+UfSqQQ1XkC5eECGLQ66rb6PRiDq9m4/5ND7CCb26prI4BwPY/uB5eaA=
X-Received: by 2002:a25:f912:0:b0:dc7:494e:ff33 with SMTP id
 q18-20020a25f912000000b00dc7494eff33mr2270811ybe.7.1711742534274; Fri, 29 Mar
 2024 13:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044459.3990638-1-debug@rivosinc.com> <20240329044459.3990638-28-debug@rivosinc.com>
 <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com>
In-Reply-To: <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 29 Mar 2024 13:02:03 -0700
Message-ID: <CAKC1njQ_RU=uHhrna=MFVdjAMjjQNqZWnkjPoJvO7CxtPMeNuQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] kselftest/riscv: kselftest for user mode cfi
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, palmer@sifive.com, 
	conor@kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, 
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com, shuah@kernel.org, 
	brauner@kernel.org, andy.chiu@sifive.com, jerry.shih@sifive.com, 
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com, 
	xiao.w.wang@intel.com, charlie@rivosinc.com, apatel@ventanamicro.com, 
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com, sameo@rivosinc.com, 
	shikemeng@huaweicloud.com, willy@infradead.org, vincent.chen@sifive.com, 
	guoren@kernel.org, samitolvanen@google.com, songshuaishuai@tinylab.org, 
	gerg@kernel.org, heiko@sntech.de, bhe@redhat.com, 
	jeeheng.sia@starfivetech.com, cyy@cyyself.name, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com, 
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	david@redhat.com, catalin.marinas@arm.com, revest@chromium.org, 
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, 
	ojeda@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:50=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 3/29/24 9:44 AM, Deepak Gupta wrote:
> > Adds kselftest for RISC-V control flow integrity implementation for use=
r
> > mode. There is not a lot going on in kernel for enabling landing pad fo=
r
> > user mode. Thus kselftest simply enables landing pad for the binary and
> > a signal handler is registered for SIGSEGV. Any control flow violation =
are
> > reported as SIGSEGV with si_code =3D SEGV_CPERR. Test will fail on reci=
eving
> > any SEGV_CPERR. Shadow stack part has more changes in kernel and thus t=
here
> > are separate tests for that
> >       - enable and disable
> >       - Exercise `map_shadow_stack` syscall
> >       - `fork` test to make sure COW works for shadow stack pages
> >       - gup tests
> >         As of today kernel uses FOLL_FORCE when access happens to memor=
y via
> >         /proc/<pid>/mem. Not breaking that for shadow stack
> >       - signal test. Make sure signal delivery results in token creatio=
n on
> >       shadow stack and consumes (and verifies) token on sigreturn
> >     - shadow stack protection test. attempts to write using regular sto=
re
> >         instruction on shadow stack memory must result in access faults
> >
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> >  tools/testing/selftests/riscv/Makefile        |   2 +-
> >  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
> >  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
> >  .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
> >  .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++++++
> >  .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
> Please add generated binaries in the .gitignore files.

hmm...
I don't see binary as part of the patch. Which file are you referring
to here being binary?

>

