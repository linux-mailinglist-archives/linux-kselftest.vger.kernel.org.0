Return-Path: <linux-kselftest+bounces-11516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DF9018DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA32811AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3517EF;
	Mon, 10 Jun 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBSp1Q0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A064136A
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717978742; cv=none; b=saGWNwC3qanOIKSRy+kuxAh+i+uGNeTAVtL7+xXe34CDq6QXhfIGt8btRfayUBu+IaZ8NSpPlhWD3V2D+1T5pwepvqSXOF8VqW8eeIUwPH5JPaeKaJbZoigVG5WriOw3iK42Xqgt0Bq0C871dPnKqACWTfEVcTloX+VShFDCUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717978742; c=relaxed/simple;
	bh=ouwqqZ0IrZq2p2VNSQskkMAORAvHn7/TuYsSh0/Nnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULCfYjy7DaOEFGq834bhGyPRgSSvnDUcxCkwLxmWbvOtuCWgQVEQ0KRx9hVZiNv1+DW33H7oZhwrT1v27pcDy2wraZtwxdgiZd11XW+MwxAM0/PIh2t+gR0u6Zca9A1VByNuRHlgwPC4PkIOtVicVC47yAQbdYAEAi1h9QyrCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBSp1Q0K; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfa727d47c1so3895651276.0
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717978740; x=1718583540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaBC4lccKq90V2Qdlha3eJDRzM1Bcauqmp5mASHkKAs=;
        b=RBSp1Q0KZSkKXckwKm0NH9KWKK5B+2YY5YU4X/4nzvQWEKPM1v55ClNvnC7+Yny4jC
         Uc3bPfpFgjmC0zjs+fdvdjzoQDxGJuSlUEp8DCWfatyKzs6qil3gyCYvKQgcGElhOAzx
         P1C9KAk+0vHoMGuVp1BOPlydzgjvuEhRsAEsD7kHLRwdVoJzLXtU1kFGlexxszvYLhpV
         RW5PYCH3gr9itlXgflPMlGvcobNWzbGArbc2ztA8wDEv0N6mmfEjwRxGMV05SWDQkZ6/
         hTer95s4MbetC8+D4CQnIjl1+EsjgEQb7pDoJCIMONxKk9D3QxuztjlH/INCSjT6GhE0
         JqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717978740; x=1718583540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaBC4lccKq90V2Qdlha3eJDRzM1Bcauqmp5mASHkKAs=;
        b=fUPRIeVmWJID9Uub7hObs5hIsUDEkI+2QpiKOJxCFn/n2Q5Bx888hxlPSiiRBbIq11
         1VKHjBryXrEq8FA4cN4CueJd2+1p+tHj8MOvEm34LRInz68mrx2667UwG6rHHBaYwHqJ
         h1mdNOUR7RGMRyF2fPbv3JJ4YHQLtmgItoyT+7ypmTLw/vmpWF44mmPf5TqGgS2yTOKL
         V6SL+K5Fz5iGTOeGToLIaI+eczPmDplyW8XngG3XrT2zzizrC4UE8DcX/v9vBrbx9StQ
         ryw59wAid2SQlQjwiMcPevZGCBwdECCZIZ71m7QqXb3ujG3tpFAciI2VrNKAr3BMPTZK
         CQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU71XoWY4mphsPDXsIXlusIRP+hc+Sy1YCcE0wJmRPTHg8j2WRcXW0u3MkZIUtrU6Ui7q8Wk1jlSP5kUZw4CXq1sx7YnCP/ntBrEENPbyP+
X-Gm-Message-State: AOJu0Yy04CYScbqMcssfd/nM6MM8x1/xNBzKlQam6xCFuJVvdyFa+v3R
	ekDimgx2/U2GFExJ2oeL6R+6CH6cLE6qHKrXU6AVtMVq0akxeq7umetcW0nwZ38+lLf6mXSBDsK
	Bc/i0vQMxm61GdtnRK93InMmh73pZgeVwQcc0
X-Google-Smtp-Source: AGHT+IGUSJ9gCJQ/d525KZWGwnLKi0KTucuS2fT52NdM142pz4Cm/kHolpWE6kV3MsEu37U2P/YkyNLgVNYRzBxA+78=
X-Received: by 2002:a5b:2ce:0:b0:dfb:308f:911 with SMTP id 3f1490d57ef6-dfb308f0b87mr1143735276.60.1717978740109;
 Sun, 09 Jun 2024 17:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-1-jcalmels@3xx0.net> <20240609104355.442002-5-jcalmels@3xx0.net>
In-Reply-To: <20240609104355.442002-5-jcalmels@3xx0.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Jun 2024 20:18:48 -0400
Message-ID: <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, John Johansen <john.johansen@canonical.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 6:40=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net>=
 wrote:
>
> This patch allows modifying the various capabilities of the struct cred
> in BPF-LSM hooks. More specifically, the userns_create hook called
> prior to creating a new user namespace.
>
> With the introduction of userns capabilities, this effectively provides
> a simple way for LSMs to control the capabilities granted to a user
> namespace and all its descendants.
>
> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> namespaces and checking the resulting task's bounding set.
>
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>  include/linux/lsm_hook_defs.h                 |  2 +-
>  include/linux/security.h                      |  4 +-
>  kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++++++++
>  security/apparmor/lsm.c                       |  2 +-
>  security/security.c                           |  6 +-
>  security/selinux/hooks.c                      |  2 +-
>  .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
>  .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
>  8 files changed, 76 insertions(+), 14 deletions(-)

I'm not sure we want to go down the path of a LSM modifying the POSIX
capabilities of a task, other than the capabilities/commoncap LSM.  It
sets a bad precedent and could further complicate issues around LSM
ordering.

--
paul-moore.com

