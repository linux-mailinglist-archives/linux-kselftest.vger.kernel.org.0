Return-Path: <linux-kselftest+bounces-32779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33957AB1D72
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877A8189139F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D425E455;
	Fri,  9 May 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UbUqh4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F641F4C8E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820042; cv=none; b=SbuJqqJJEeDwED7Fsw+zr6qtjH8DaycBaoe5F2u+s+2B0vac47gYoRsFhFE1N17IwnMygXlIQVTrOmavXA7ovPQXZXwHvaQ3vj4ozN86wp0PCsOgikbp0thokR6psoZdQ0gXEv27CVfFU6xEd6SEaXhnj4M29SuWn6xOxcFGLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820042; c=relaxed/simple;
	bh=OO+z2GhWq1run59oczVnBduA+f96Lk5wwHADcom/fng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwBK7PoR6iEiLs2DBNmGu4yVOZNaMKOfuPDYjzU4XNSVjO0tcbvmIgScrljttjYZBRN7pInM+qQ5BhLdfQVzKhlNAwfXElCHfMAhkQRKy35fr7jtlw4h5hjOThZ2lwVoREzEeDPLZYA8N3bgcV3sLSnLJ7Rf4pRhw3EIYMYJVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UbUqh4t; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0ad74483fso28337786d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746820040; x=1747424840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9shy6K02vQjMGB7MmfZj+4nXyKd0s5WFhDhK79BCcBY=;
        b=2UbUqh4tjBVyOPobWeVe0efMUjwvbrUafYw2Py+f7lGY73chX7r3cyqFwv5A+x2Pi8
         sSaot+w3Wop1p4SkndTxRdrt/7vXN4MbN3yyKVGVoi5jo6iqrSsYJlkZWs66gHiCl2S3
         qQwScWtyehDRZcDGqDN3jz5cN0iDLVr1ZPjRLAINtzgEOUsnGlZKvJBeXqYDldSaIsVj
         fxfXnO1dExuPfCA5Q6E5utPcevY7zpVcuJ/gKLrR/6BDYhspr83ItLSsaSAHQodoAnFv
         8XDQGIhZt+fYMjaC4Yo1U+ueAuxPRHjQwgoHVzZmCNYFAg+Aj2IHejIGo9KvJTax5KxQ
         bcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820040; x=1747424840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9shy6K02vQjMGB7MmfZj+4nXyKd0s5WFhDhK79BCcBY=;
        b=dxUsGPz00nBVfTw2lhuSQ/Tk3guDv07C0AXB69/Nh7qjs9Mumt+lhV8a1GoFXRN7TL
         AqqzAkRcnH2ztQmjGkoIyIJf33vLgWuAIcixtFZyzpvr+aoIjZ/PItWXA2FJLtFfeBJF
         wyYMn3nVYodGeJDRMhtCfVqVnMxV+fWcXh+HewGQLR2UEiD+ccOl8qwgCqo7kTj9JQow
         Qc2aX+oExOxxXNHrXJdNimu+OTOYe5bEgCvilfl4kiz7IU3oimbM9pxCxCGiLqWsyCX2
         4QlCgSuhhmNgOe/pAHZ3p/pIm4rg5BPny2WKEhnInH50jZzkm7AweW36erqPwHNItc6J
         Wxgg==
X-Forwarded-Encrypted: i=1; AJvYcCXczcY414SJCSay+nFNkSyuD5Ch+m39JcXa5hB8Ks4KTXjI+7Icjw9Pjz99MYv9SwBKWTt8o7d8/5OEfgVU7qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjS3jTGDCQRWlGg4o9dZMzY/V3AP3qVNWUjxhhJ0pWOxcsTCP
	ZM55alU0MUoJA6T+nyX1Hv3k8shP4sCGyJuXd5Wo0ts5GMsMcm/gBrZ7/U5vArX1K0ZNJPwTWek
	gEo5M+yZBJTEq+e/G9Mr2HfMqvMPjYne57f/p
X-Gm-Gg: ASbGncvTaD6ZAng/R76MolEeLzQeWYpFtPXJ8OhvJrZTvcfd9uYAKC8ulKWOPnLgcMf
	YinO/UqZWXQeBZICoRn2ji1PRQf2ef5jrR6QVz0miaVmGX9vbDiRtM4CEGHELzutJXq2mVRIzkr
	NCbKXwe5ASCpWH/rk32qr4YKHR2roNKD81kuD8/3rkzTV65raDlVkibQBDkjHM2oo=
X-Google-Smtp-Source: AGHT+IHWeVpitaw9+HTdbPSleQLjEOfgr8oao3PJI5c1muVeFjRCogXyp+U2tit84vvrnN59iWb7EkYy9EIh1kNTLdk=
X-Received: by 2002:a05:6214:d64:b0:6f5:3e46:63f9 with SMTP id
 6a1803df08f44-6f6e47bc7b1mr80886646d6.7.1746820039595; Fri, 09 May 2025
 12:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-kunit-enable-missing-tests-v1-1-263391818e76@kernel.org>
In-Reply-To: <20250425-kunit-enable-missing-tests-v1-1-263391818e76@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Fri, 9 May 2025 15:47:08 -0400
X-Gm-Features: AX0GCFtmbJiDUNQjlB8ohbklHOQW5buEz2dRX0lgiHhq8IU8bguhlRCiWbDar1g
Message-ID: <CA+GJov6vfs=tdWW_F5mkin+EDAft+j9CK=5kHcOf11MufOFdvA@mail.gmail.com>
Subject: Re: [PATCH] kunit: configs: Enable coverage of the bitfield packing library
To: Mark Brown <broonie@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 6:19=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> There are KUnit tests for the bitfield packing library but these depend
> on CONFIG_PACKING which is not enabled by anything in either the
> existing KUnit all_tests.config or the base UML config it runs on as
> standard.  Enable that in all_tests.config to improve coverage.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Hello,

This looks good to me. It adds about 70 tests to the "alltests" run.
They all seem to pass and run fast so I am happy to add this.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  tools/testing/kunit/configs/all_tests.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index cdd9782f9646..b0223b7aebde 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -51,3 +51,5 @@ CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
>  CONFIG_SND_SOC=3Dy
>  CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> +
> +CONFIG_PACKING=3Dy
>
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250422-kunit-enable-missing-tests-9189ee930cae
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

