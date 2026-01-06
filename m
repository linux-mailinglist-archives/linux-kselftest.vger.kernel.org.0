Return-Path: <linux-kselftest+bounces-48291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DABCF858A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 13:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC7930198CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE632522A7;
	Tue,  6 Jan 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWUnrMCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC121C173
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702552; cv=none; b=naur1ywWdIhLUieNMiGT9EPewkGvqPVmFpeOqkqKeMqgLJI2SJNbBOUlRdSGJTe6ae+91sU3HpBYqayQSePrHjd0TUa8vtABIJhx+237w4rXSd0qK1+1GkavyN5ezDYB527xzKKjNPcnJzDlB5CcnzZgXREj06+lnUPggOq0U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702552; c=relaxed/simple;
	bh=wXZzH27gnUDagNl5a0ME5KVazZHyReqGn/kmzzyAPc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8Ot7rS868hi/RC3FfRkZN71wF3djHBxrtJFhVGSduYG4Zt8E/6RR0hUJx+xjWfyYSn4H9CQGrJyN5ABognahIOYq3Kp/NmZ3ZvLL+Q6buqN18Xc4zFzsdklqSmSuY38KwOB/YBKw1epoA4VNfwAkp4qao0FUIISaBdc72x33BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWUnrMCK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so9400225e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767702549; x=1768307349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pZdwAP/wq9kuKKVzLJ5M0q6p8KUwTZW9kKk5Fbt3zQ=;
        b=OWUnrMCKUalOFZT/gUYHr07AWT2rTRwrSqgqxeuDxnE0z0GZZ+NGPZ+hCJf4Ir222K
         K4otTyiq/JnfKQtblLaZ+v44nK3+hDCbknid3jMOiVfU2GBRk1KjJXszrsdQS2XhlacK
         2kOxEL3hmQhCLdGQcQIs9eO+bjL2/JjZoXlFQ6ukfhnjiuQr/9cjGGPBByYHGsGHCw13
         VUWO7pEgb64JcKpaVdWMADfIo8hUd409h974cDRdGb7Tun5ff7AXVNDT73pTDjHTxWzN
         4dazhgDBfqXyaeY1Zcz1nhK0WLMXJ6R3CqKZMFBnOq6YlR+XkHAE6kaoND/u6Ir6lbRe
         1SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702549; x=1768307349;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pZdwAP/wq9kuKKVzLJ5M0q6p8KUwTZW9kKk5Fbt3zQ=;
        b=Us58W1Kgi0JSCgfwBU78OoyRVSyV+56v178OkDmzrVBF+BCICgGQfAW9oWMAxEe9JU
         6tqgjX0upOP0IH/KYCVUAhvove99F6E4qw+VQkg1lSvKvjBZrFy320jq0QqgD/34kkMr
         CVZFOh7U1agDCwlUMoSNHuFZXGR1W2jwsZ4m74XvkVk9SQqHBQk+bSCKrfn+BZ6Mj8OP
         7hYbwgEEkGCWmfsCVjSiYqpY9sTp9aeH9w3TEGJBo2z22lj42E/HMU9pg4XiQvCsK6oI
         89tqYdV/+arED+Dv/X5xh+8AGFq4ZFc0dyfwDRyhcKUqLxYNy3kjuFScPR+yoNaU+ojN
         2q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqgCkDG5jVf4a2da2np1eTajKbEkHuI8H/dnpNvG9XtpylOSkttcwwneURDKLbttxbglQrwTL20EdWppGwasE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyo8H+ljgwrwHPE9S7gXqqUZHFJ51RxHK7V4XvVywk3xCvBY+r
	hpPgA2y1DrLte/ExHjRzCU4S2J7nKMkk3SUidszrLyl8h1Bv9jzUzWTuKb1jJPdN29TKG/y6uwB
	7qXWis4OYyf9ONQ==
X-Google-Smtp-Source: AGHT+IGDb5uS6PkHdgGZm/vN+neaeuomXNsUF5fH4vDNKaBbgCTUgMqpCF8VtoYm6kaWCOvj+sJGU4W9OTyeoQ==
X-Received: from wmoo8-n1.prod.google.com ([2002:a05:600d:108:10b0:479:36b0:ff54])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b27:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-47d7f062feamr32360515e9.1.1767702549472;
 Tue, 06 Jan 2026 04:29:09 -0800 (PST)
Date: Tue, 06 Jan 2026 12:29:08 +0000
In-Reply-To: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830163949.20952-1-reddybalavignesh9979@gmail.com> <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
Subject: Re: [PATCH v3] selftests: complete kselftest include centralization
From: Brendan Jackman <jackmanb@google.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, <akpm@linux-foundation.org>, 
	<shuah@kernel.org>, <richard.weiyang@gmail.com>
Cc: <david.shane.hunter@gmail.com>, <khalid@kernel.org>, 
	<Liam.Howlett@oracle.com>, <davem@davemloft.net>, <david@redhat.com>, 
	<edumazet@google.com>, <gnoack@google.com>, <horms@kernel.org>, 
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>, 
	<linux-security-module@vger.kernel.org>, <lorenzo.stoakes@oracle.com>, 
	<mhocko@suse.com>, <mic@digikod.net>, <ming.lei@redhat.com>, 
	<pabeni@redhat.com>, <surenb@google.com>, <vbabka@suse.cz>, 
	<linux-kernel-mentees@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Oct 16, 2025 at 10:44 AM UTC, Bala-Vignesh-Reddy wrote:
> This follow-up patch completes centralization of kselftest.h and
> ksefltest_harness.h includes in remaining seltests files, replacing all
> relative paths with a non-relative paths using shared -I include path
> in lib.mk

This seems to be breaking the x86 build for me:

=E2=9D=AF=E2=9D=AF  git checkout e6fbd1759c9ece5044d3470f30a5e2166dc9de89
=E2=9D=AF=E2=9D=AF  make -j mrproper
=E2=9D=AF=E2=9D=AF  make -sj100 defconfig
=E2=9D=AF=E2=9D=AF  make -sj100 headers
=E2=9D=AF=E2=9D=AF  make -sj100 -C tools/testing/selftests  TARGETS=3D"x86"
In file included from syscall_nt.c:17:
helpers.h:10:10: fatal error: kselftest.h: No such file or directory
   10 | #include "kselftest.h"
      |          ^~~~~~~~~~~~~
[...]
=E2=9D=AF=E2=9D=AF  git checkout HEAD^
=E2=9D=AF=E2=9D=AF  make -sj100 -C tools/testing/selftests  TARGETS=3D"x86"
[builds]

If I just revert all the changes to tools/testing/selftests/x86/, it
builds again.

