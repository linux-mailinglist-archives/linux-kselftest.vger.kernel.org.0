Return-Path: <linux-kselftest+bounces-47933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78BCD9FF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0176930194C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86152266565;
	Tue, 23 Dec 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMhiLafF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614A19D074
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508413; cv=none; b=KTtn4m9DZsiHoSCyykTyLG6Cv4fTqomf8So4C9uU0/NQYLOVVsHffGMhAQEiX8Uu5VvtrQMIgH+jAworwrn/AtU1rvMN3MNf+j9CAk+VRTUXbjQbT1DAjH//c4g0mVhe9ncFtgaCJMNmWyOfqLHnttivPfsgfoM6tgTvEZ2Eeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508413; c=relaxed/simple;
	bh=nBvdW4uwcY29fy4YHXaOO1CwVIkvGwDD6WuTQ//PQuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCOI5xZ11yzigOr456Ja5YJwKxzLDjtVRIAl1QU8MAxS10KGDP2XS+eqTUizgWkvVuiICNub/qFwEYZ4Jf6eS9yg5nMYy00oXdozRfo8EcZ2NuTu2FFE13h90h2Kh1IhOXf4puox8Dz/Z9gImFA33FxSm8rzvpiLbSWOpW3pLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMhiLafF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47918084ac1so44228615e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766508410; x=1767113210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBvdW4uwcY29fy4YHXaOO1CwVIkvGwDD6WuTQ//PQuo=;
        b=rMhiLafFkUgarEjkXOWHrd6SeSYHJhCimjJUitU6PAQLcN+FBJn5YNBDHHB3TFVRvp
         u1hGBSz5vqX4P6AgOStNfoDduLtlIvmVlOSAaMea7B5Kb+lUzUIYWltO33ZP8bPtMxwj
         74E6jmeIV8fhdZvVJq1b5vGutQe+t0TjSu17JRIs7ROEt1bGQ8GGn1y7LXfWfreASwPz
         FddgPjNiVcpBBKMKmsVH0gaG0tz07kQzoJqKTToo7tQZbN3qsGtn9BY3PU8HNrodaWpW
         l+jN+5xyE16ryZS0+mOiHER5M/H1tZ+9b7xPJyPrbGLeI9GdogWTSDKjfwN5LbR17GZI
         oPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766508410; x=1767113210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBvdW4uwcY29fy4YHXaOO1CwVIkvGwDD6WuTQ//PQuo=;
        b=h1k0koV2EDuMXFwsHYUJqiXILrmgdhrVm3blGXdexdNWwgLSVJmzAMw6S7IIBOGrSv
         7GcMJRqlZlUxWzjmO0Ep34xS9h5QP/9EIzunt5jlqjS+SjJEPqyDK8O1NBYpVJqWhbrs
         6o7PuAn1dL42Qcc2ykcCm02gnEjG8Ymm0iAaTB6UMgFGXOvF1wDNHUiYLmCte+n4EaFZ
         XMSxYgVNs9/Fb/Ltc9Vswe3qiLPc2bNGdk9wJo1tGuV8PCGahmF+D/ygSGVJpG5ww9ut
         P795UdWAHtlPkAiS41SZ1OU9dY24nfqVKl9cewYXHHeEb+d58qHPCMZVZXCvw4o6n0dn
         SFDA==
X-Gm-Message-State: AOJu0YxJtS3DY+X5WHt2KW+CNufVLr9/y6cpZU/dgKG4r7nJq7YJYTDC
	Mk2A0P2sXc9Grp9TINEacR9AplWW3sqZXFP8SteO5oMtH7xoZOkyffA/gSFDlav3UVZGKiuQwxK
	pHoiG1uOJwMT84w==
X-Google-Smtp-Source: AGHT+IGaHQK2nt2OAnM0/DenA+ZxyNpyFw07Lmu0lVUq2l6SlAcO5cZsDiLB2cSN2kfRbalo6AxJ8d5wrveQww==
X-Received: from wmoo8-n1.prod.google.com ([2002:a05:600d:108:10b0:479:36b0:ff54])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8a0a:20b0:477:a3d1:aafb with SMTP id 5b1f17b1804b1-47d2001edbamr88904085e9.29.1766508410211;
 Tue, 23 Dec 2025 08:46:50 -0800 (PST)
Date: Tue, 23 Dec 2025 16:46:49 +0000
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DF5QYW6E1324.1BBFBH0UQP2Y4@google.com>
Subject: Re: [PATCH 0/3] EDITME: cover title for b4/kunit-user-alloc
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

> Subject: Re: [PATCH 0/3] EDITME: cover title for b4/kunit-user-alloc

I hope everyone is suitably impressed by this. My talent for discovering
new ways of screwing up LKML submissions is simply unparalleled.

This should say "fix mm_struct leak in kunit_attach_mm()".


