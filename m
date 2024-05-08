Return-Path: <linux-kselftest+bounces-9704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF608BFF47
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B127B1F29681
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D08184FAC;
	Wed,  8 May 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPR2FNMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEA7D095
	for <linux-kselftest@vger.kernel.org>; Wed,  8 May 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176027; cv=none; b=HqvoeA5/ofaTIt2o7jDmb/hNZ7itrpwjcPYe2dGjP8Vx7NhD/WA6kfbfE7IG/YcZBnBixpJFRd/3ym+XflBJmLthIlVP6q4D19fgFYDyWkTB2ggKhQu/P0EuqrkTy5o7J8TGg9WnyBvA+TIk3bHLX/VDhgAp3XCezvHn+43KpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176027; c=relaxed/simple;
	bh=u6EyzHXd27fFGrN9Et656hCo/08PPyT+hT+CjlkxkTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ilLRk3tfjWXSZ785bdz7ERh0jzlT32LyB3dEWbS5a5NG/D7UmJMyufz4ZlCm9CZDsgbdYTaXE+Xc1J6xeRbkfFTo6oEQ6F2IJ7YyYCF76NpK6On75+k4W7ahv+iiew2RsLKiMFXdKt4nfAs3zAkQfNbDzKlpYQs/g50tY8gdbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPR2FNMY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so3654197a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715176025; x=1715780825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Cy96MEbs4JLv+XlnJDrNT2CJ2qEQRDaH5Qu53Pf8ZU=;
        b=bPR2FNMYRrL08LQZsHzX4L6KUGDoby1D7kq9CdVilnTl6CW9lrBNQYoFJsegU0aGHp
         4Rvak8c4UmtoXc6S3fFjOZBo01YZflQzqFYbXxLIMfFX6eOvhYD8CtmBrq+Mb4rYJAd4
         2TsYLBRRZ5lpklLD11TRJUBP059D2HhrmxyI4sMyN7bd6vthUJHtxs4RdEeGguR3wo9D
         30qJITdawJLGFg0swiui7xrCU72XGr5q34hiCJUVBCjHrubNk4EFfWZpBaPVUzsm1Ifx
         +T4FgDSpNbi6t6XMJh7DSzyQHM216u9cGZYXYgPB8SaOhyO6WycTJJETY3cK0TX2A9N0
         gIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715176025; x=1715780825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Cy96MEbs4JLv+XlnJDrNT2CJ2qEQRDaH5Qu53Pf8ZU=;
        b=mDkzh/V+EqDagvQOwXc34fVhBYAFWyLN5WKMJBZKAQwwv6BL2UKn+o7gymeBlVY3yi
         PzOWRL3670qk2ZMq2CpRIFmVoLjjMk5fruYsI31s5Sj03kQxlereeZ63mKoSjeaOlFQj
         K4+iAcMQSHVmJg0Cb4U93ZCq6k+hnPA7GZYCt6Frgf8u+6DAk/rEkKgnSvWOzwB8NMBE
         vHs+iaPLNDQ3GsdEo+HAZeoT/PB7Huf7//MYWo1At6JwKJjYusvkmn5UT3iIVPZmpno6
         axI/dfJAjOgR6feO4D8HcGyz3XmcCnRvES2POPg/qmz3R6g5j+7U3qxhQNwIm0AxNm0P
         5HRg==
X-Forwarded-Encrypted: i=1; AJvYcCWviPb3Mdo8Oomidv4I4gc6Ap/xdT78S4mfMcSo4BctuHEa0nlDAe0X/6ys51wzux+txrJfMMNDLM1vc5UEtCRA4FbC/fhuwXNJShRSlVlD
X-Gm-Message-State: AOJu0YzcuMMuFVbOq+zz1uIHVnMfA0eszxAh7UXSkXBHvhz8RTcr2CRZ
	z8FATl8YKLrOQOkdwCINtaSLJPmzNKgwhtiLBYU+AfizbvslI0FdFrsvNZHbQTtRw5erbsp2qYJ
	8Ag==
X-Google-Smtp-Source: AGHT+IGkEzt3rrLCYEAc2MIkDJ4rSudkNPJV/ZI7YDr6FjDNwR59XbPWzyPuXmQfxq7n/1Jp45z9S3futCA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:128d:b0:2b4:32ae:483e with SMTP id
 98e67ed59e1d1-2b61638c780mr8658a91.2.1715176024465; Wed, 08 May 2024 06:47:04
 -0700 (PDT)
Date: Wed, 8 May 2024 06:47:03 -0700
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com>
Message-ID: <ZjuA3aY_iHkjP7bQ@google.com>
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
From: Sean Christopherson <seanjc@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, "=?utf-8?B?QW5kcsOp?= Almeida" <andrealmeid@igalia.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, 
	Bongsu Jeon <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"Andreas =?utf-8?Q?F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-input@vger.kernel.org, iommu@lists.linux.dev, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 07, 2024, Edward Liaw wrote:
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
> v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> location.  Remove #define _GNU_SOURCE from source code to resolve
> redefinition warnings.
> 
> Edward Liaw (5):
>   selftests: Compile kselftest headers with -D_GNU_SOURCE
>   selftests/sgx: Include KHDR_INCLUDES in Makefile
>   selftests: Include KHDR_INCLUDES in Makefile
>   selftests: Drop define _GNU_SOURCE
>   selftests: Drop duplicate -D_GNU_SOURCE

Can you rebase this on top of linux-next?  I have a conflicting fix[*] for the
KVM selftests queued for 6.10, and I would prefer not to drop that commit at
this stage as it would require a rebase of a pile of other commits.

And I doubt KVM is the only subsystem that has a targeted fix for the _GNU_SOURCE
mess.

If we want/need to get a fix into 6.9, then IMO we should just revert 809216233555
("selftests/harness: remove use of LINE_MAX"), as that came in quite late in the
6.9 cycle, and I don't think it's feasible to be 100% confident that globally
defining _GNU_SOURCE works for all selftests, i.e. we really should have a full
cycle for folks to test.

[*] https://github.com/kvm-x86/linux/commit/730cfa45b5f4

