Return-Path: <linux-kselftest+bounces-3725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30E841815
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45061F23760
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C12D05B;
	Tue, 30 Jan 2024 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbDicfoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8D36117
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576738; cv=none; b=SfoL+YWOC9sqF86/d88MWiLTJjfkVDzx5ZIy+gXJGbHHCIMg18iQzL4oYWl1JAX4wxiTeLSpD8UxqkYqhbZOx1dkuQnFMeSNxNiw8nVx3Ad/+61xEM81tj+1ntq1EVDncItBPeIYynvz8DwHzkGj/DV+/GuDtiNSogMqlwBmunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576738; c=relaxed/simple;
	bh=bP5uiJ/5RnXIvoYIehfl5o60E8dgpUf1Hp3tp0SJCB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LN4svDS+q5yun2cHXjxZ6a9iSUjsjLUQD3danFeK/kw9x+Cm90265aYQsxA29q6AiVtpdM9DvzB7qUgE8TQsnDFANL4lBHMIUVVqRsP5t0NssRuPmAii6AAbEbllIcpk1zLmmQw+m7H0DTXVN8K6l+QwKDwNqfyPDCFbWnXT408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbDicfoP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2284779caso4840361276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706576736; x=1707181536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vw6COnvcr34EckSRXJ+rxQe1Z7hZfWxJzyine5oZCQQ=;
        b=UbDicfoPxA64JJMREM06iQh5KwpgEscQp+x60KNeOkS7y64t/IST6S9Ap+Y84PIwYp
         U+xvHOTQgnIKHa+JDDZIX4d+iw7xt+mY4EcmpJjTOsvN58ggL44ndH/PRXrFFF2Z/gZk
         9F/9EREBaJFl1q13NTVxNCh42pq9P2gU4zEHXVABkt2LOwPOu+SpOCl0XbB41d0IytM7
         Zt1h/IjeAYS4wJV1L9wmv4qrfuEl38vbO1Qu8GQnOZAa7F7iuylWr06K7nRc2xc1YszC
         7b+n8jqygaUNcNNHf6yk6N3+BzahUjy1Vo5NYxt7yhgO4Q2tVphmRXc1FcIJ+Vm/Dlmi
         yjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576736; x=1707181536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vw6COnvcr34EckSRXJ+rxQe1Z7hZfWxJzyine5oZCQQ=;
        b=OHpeVIdLEbc2ECk2aqzVxJiu+Mup8aXmkRTOVtrDCOH1HbB7CWL7arTH6cFMLlmjXD
         Lr3aHDItrrS+3MQ6pDzMD8Od+EokNyZwp/WSVLM+zhHcloiw0iJtYNpMp3Hm2izDiEvg
         77sZjhil/AivSYeIFW5u6btOqDAWf+X2kSP+GpXDTbcsohWE5Zu9mSNCYJcFYVKZaMjo
         pxVFtBPUCov3Ochg2vRfQsrCFvBDmgJ8KaM6xTU5n3mptRv1i1sJ9qoXQqNhhRWfA+eN
         LAAwP/gzpaSQ1ZDf5Fx4SV2ixyh44OO6s8OVemovOA+OAzNPjfwg0mAkm7mC19Hf8OGO
         Rh9A==
X-Gm-Message-State: AOJu0YxOGen2Yxt4SW8k/cPAt2B5JI514kAwQWzjvaTH2rdVekZs5opV
	JdO176iQh/Bgf9zIDu0r2Ou1Ahohb+kw9Zyg7SKAA4NK1DDUiiauGdvCJrpkHrK+jUoHEtGV+KW
	S0hKvZzCpnoBhnGjFVQ==
X-Google-Smtp-Source: AGHT+IGe0NvY4HXE6eFA0hpwVc6vgidpZ8bbGhfiv2RgcaV8cAbmIjcxpghn/hAx94smBwwzRwWCzi/M/FDlWP05
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2503:b0:dc2:661d:11fc with
 SMTP id dt3-20020a056902250300b00dc2661d11fcmr390539ybb.8.1706576736085; Mon,
 29 Jan 2024 17:05:36 -0800 (PST)
Date: Tue, 30 Jan 2024 01:05:34 +0000
In-Reply-To: <20240129224542.162599-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-3-nphamcs@gmail.com>
Message-ID: <ZbhLXoOw8Zs2AQ7X@google.com>
Subject: Re: [PATCH 2/3] selftests: fix the zswap invasive shrink test
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 02:45:41PM -0800, Nhat Pham wrote:
> The zswap no invasive shrink selftest breaks because we rename the zswap
> writeback counter (see [1]). Fix the test.
> 
> [1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20231205193307.2432803-1-nphamcs@gmail.com/
> 
> Fixes: a697dc2be925 ("selftests: cgroup: update per-memcg zswap writeback selftest")

Looks like this should go into v6.8 too.

> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

