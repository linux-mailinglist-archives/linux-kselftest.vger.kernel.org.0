Return-Path: <linux-kselftest+bounces-10060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288F8C2C7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FA11C20C79
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370413D245;
	Fri, 10 May 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkhaYzmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF613CFB9
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379194; cv=none; b=YAi59Ho+35zApjv6CsfU+dEbJhDOQSHbGxCLubWEHy2qbxEEmZI45SlC2a5YIu1Y0ownHCT8oS6/4j86mvcWVylozzEMOiu456AmIWtwao4tyzCf32ExHdQ788x2gq+JmIfldx3brhlGyaDJUF0tXaU4Bcc/w5Tss+0ILMOVI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379194; c=relaxed/simple;
	bh=bApJfaNHXG3b/3zCEI1V3flWSAJVlqDSLLrghqSaM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2ZuOfM+Rq4Qt7wnpzaXXCq+U79eRe1LPWe36kxSf8Zponqo6k/cwM0QGxnXze2ZODeNUjRMFb53I0M9Ji0svFqsonsOeCShhGbOF2W+wZ/fIOps+9SaDeIQ78z1ML1xDfPNvFgetcUWzD3aM8s8iG0vt4dRMgQIncq92OD2aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkhaYzmp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a9d66a51so580658866b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715379191; x=1715983991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bApJfaNHXG3b/3zCEI1V3flWSAJVlqDSLLrghqSaM08=;
        b=LkhaYzmprFgzB8wHwaOZY7/M9p2qfcxwq3N1I6/K8ZvrOqR3jlf1omRjSKXOXtWENF
         PMjazc8/t+uTKph+jvOy+GUg+PY4nmrlQtup2ddO7xkRWtxhTqGZxt6M2PDUX+GYWeBJ
         NAenRRZrlIKwVRo3cRscd1feICcXL4IqvqjwmrEzMcJb1uat+nTVkivRsDFnSzZwO+YO
         Lko29z46Ioo6jFkqlBARE8Ns0DDaondTtoOLJzIFjIFcLtseqQYpjaNGW0DtD3/OoOpI
         weTqMJBi1nTWbUhmMN/FmfZBi8B7hwmM700Dj6CNtXgXdcOGIzNIJVK19lLWK0cDBb0S
         8q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379191; x=1715983991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bApJfaNHXG3b/3zCEI1V3flWSAJVlqDSLLrghqSaM08=;
        b=Zh0NO6tGnPWMMP3tbtgmwWszNPHPgVwuTzmFROOc9myfZ6H2XKC9TSneZwgUuYYCy0
         O6g9euei3WQ5+nM1WfCL86+kubpA75JC5fzuJMjufck6V8q5vJ7Ym4d4B9cBmG8L2mYu
         z12fjE5Oxc5J7PIAOhUQIyESVdWukoBVktdMajrouucYDqyKwYKrduEWZWEZfKzj64pG
         ttQ4rpK3ZIx5SSqm4FWzdJuJ+gfn+3Okq95Ny7kEcXYL1+Y/kAKeerp/S4lmDomorhmW
         0GAtnKn9Ck3je+HSk/N+PeMgdIDmfUSYxTECm0mA4Bp15cXq/UsuBLFOUhkZfJpPwMQZ
         5W7w==
X-Forwarded-Encrypted: i=1; AJvYcCVCnzcxWjCKbPP0kKjgP5dP/3NUembertL59DYSPLqBBULRnxHgUvt3Zmi+ZcTjU6CkRUK6yIpuNw0GEx44g1zhvimS+M3460EEBF08fJO4
X-Gm-Message-State: AOJu0Yw1Zs9JWf9Y2cfip1Se858Y6yWgfleTK18lPN+Vfk2N07PXMmXM
	Wax/2+K5SGzCu4hQYKzEYRWj0c4FkD6/QxvBfUiUVddrUQ6p6jtmZpUJGAutqfdCz2jOk9kDBFB
	mbKQ4rqxfy+NczC27QWWWhbMwAK3PjGjQAlBd
X-Google-Smtp-Source: AGHT+IE566iuaqOlwpfk6cqCKPJ+ihU+0o6Y7c3+XgSwkthhfcnZWZlG5bzWBk1XOFri5WHJXmOgt/QKO/gNlfCMFbU=
X-Received: by 2002:a17:906:a404:b0:a59:a8a4:a5a0 with SMTP id
 a640c23a62f3a-a5a2d5cb736mr255545266b.36.1715379190587; Fri, 10 May 2024
 15:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com> <CAEf4BzZ+Gymr9hgJog3NddVVhtvcGiYwLHGGUVEruUUy-h8t8Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+Gymr9hgJog3NddVVhtvcGiYwLHGGUVEruUUy-h8t8Q@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Fri, 10 May 2024 15:12:58 -0700
Message-ID: <CADKFtnQCbWm4geSJ0FBhb7kJtLC3sLmdnKOpZbc5k=mc+HwExA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Andrii,

It looks like the PR bot dropped one of the commits from the patch
series which is why it didn't build.

> selftests/bpf: Handle ATTACH_REJECT test cases

Is there any way to get it to recreate the PR with all 17 patches?

-Jordan

