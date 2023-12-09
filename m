Return-Path: <linux-kselftest+bounces-1465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADF80B121
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 01:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0641F21248
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55EB7F8;
	Sat,  9 Dec 2023 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="P/HLUXnp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0111710;
	Fri,  8 Dec 2023 16:59:29 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-42542b1ed5dso17553071cf.1;
        Fri, 08 Dec 2023 16:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1702083568; x=1702688368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xB8OrZERO5Rc7R1JqpBtCzHbgKs7lLfjwuEVh+zHQ0=;
        b=P/HLUXnpNVaFZj36qWUhFhsTV/d8q/pXm1//j3+mtGHw8/HpMRLvkX5Qi7PArCA/Q/
         RR/NkSUfs8yp4kR+K6mA58LcwBdbM1iGN0VU2yDxUB+9bvpASC7IXYVVBBi/MrH1otMk
         RlmzxvansJCTU11IU8NDg2LsmTNkKPF2jydkWJo86qCsw7WGzs6dSZq+zz+4fAVKstQO
         DhqKHzPf21Ae4hSegskcIBDoi/jEZcw1CDOruHOCuXNri01oxyamCM9AEnMQ5WgTnwwE
         PCr4BKq1ZVAK2/hHzbjIA4OmoSg6/6Fj7J/jPDpBXt6lpnlA35MXVISiHfglyv9lPYZ9
         BtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702083568; x=1702688368;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xB8OrZERO5Rc7R1JqpBtCzHbgKs7lLfjwuEVh+zHQ0=;
        b=pFxY3QwunbKkg36jQuIkfBJQWlt4AJYnf1SBYpa9ZgeMgouMCdSk07RLQ8z4fYF16K
         IVJhq6elSdsCe8VcolP8lCgaSPQDzLN59+u/QfyeSETfjFMafJ8Km2UVvHAAeSq0/lTp
         tvgh+KuUE43CQyjG1VdVt5qDRzqOY9OUbhNNBSoYLHfj8Bjb+Ldb7qX/H/zB1AwLumyr
         HjSHap7+AWFz/vROxfU/qPZxQ/atL9YX5C3qHqVsyoLqcO5jhGWsFqkkEXY1wR/kE5xy
         uaagZrPeK0PIKNYI8St9trgAqWfSwQdhKg1gB79Z/tq3zB4VqVjSCvjZ3OyFSoC9RMEs
         qHMw==
X-Gm-Message-State: AOJu0YxymwRRKL+k8lIqiFe/kFNOVuOH07FIOedIRkfmJ+RDGHMjdLqG
	QJQprUxREGGQth7F3wL7Em7EWRj8woePAoTQMUg=
X-Google-Smtp-Source: AGHT+IGsGZPqEINhaFGRwR1jMgaduEOJWeTcRGUhCAt+ENgkK2atfn+uV/psa9Yf+oKDboa+r26g2s1qwtgK0WpWCoQ=
X-Received: by 2002:ac8:5a8e:0:b0:425:4043:96f4 with SMTP id
 c14-20020ac85a8e000000b00425404396f4mr1034352qtc.129.1702083568530; Fri, 08
 Dec 2023 16:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
In-Reply-To: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
Reply-To: robert@ocallahan.org
From: "Robert O'Callahan" <robert@ocallahan.org>
Date: Sat, 9 Dec 2023 13:59:16 +1300
Message-ID: <CAOp6jLY8aEFOOqe4ADkgeACvat+07_F_Xj963FhyXkF+0F5Pqw@mail.gmail.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, 
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, jannh@google.com, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 07:31, Mark Brown <broonie@kernel.org> wrote:
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner
> to how the normal stack is specified, keeping the current implicit
> allocation behaviour if one is not specified either with clone3() or
> through the use of clone().  Unlike normal stacks only the shadow stack
> size is specified, similar issues to those that lead to the creation of
> map_shadow_stack() apply.

rr (https://rr-project.org) records program execution and then reruns
it with exactly the same behavior (down to memory contents and
register values). To replay clone() etc in an application using shadow
stacks, we'll need to be able to ensure the shadow stack is mapped at
the same address during the replay run as during the recording run. We
ptrace the replay tasks and have the ability to execute arbitrary
syscalls in them. It sounds like we might be able to make this work by
overriding clone_args::shadow_stack_size to zero in the call to
clone3(), instead having the replay task call map_shadow_stack() to
put the the shadow stack in the right place, and then setting its SSP
via ptrace. Will that work?

Thanks,
Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.

