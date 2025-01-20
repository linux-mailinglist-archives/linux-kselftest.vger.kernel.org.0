Return-Path: <linux-kselftest+bounces-24810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA76A1737C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2A2169338
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F171EF0AE;
	Mon, 20 Jan 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+CNQYfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C41EE032
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403903; cv=none; b=ZBjgL71Ah/kUIGznqFwPZ5Rv9MJvPsMuy37XoXArBGCXQAqFUNqXelrPXPWd82HsefrWGKIGP2CQHpU2XxPchWBJy2loJ9wsWp8G/ONoskHk6J49fPZrBV1fCKc1bejtSp0MzStUE8aooirLk3p7kDlwrZ4dxCFQNMinLr9RBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403903; c=relaxed/simple;
	bh=uijdKY0wDpdzNoyh/SEHCgVUOpZaMnezM7Uau8HiACc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=S/qyzQciqJvQhgK7BuYyDG3HUTqkF+1YSHCfJJ6GWpHwzqsl6iYRe0C1tsHYOpWHC0dmNr8uHOZfW6LXGHNsDGg+3iv9OVNeLT3Rolg+02lbTf8Pz16RaLioY9ap9lduITfXFULzSPQXwi4Tl+Rhj3GhikwBwoa/J6S6OVP6Ix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+CNQYfq; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-844ee1661c9so788984939f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 12:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737403901; x=1738008701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpAqr5jIt3uiRXjUnKjrgnDNDsGAHfvj6DptghegyYA=;
        b=v+CNQYfqfUXQXf9J+m9LXICdcOwDo4Ei8Msp2zvjNj0JWMOxwqHgYqZ8eibocMuotJ
         DuwqcUuwJx/uImwSPT1SuawjuaN0H064BaN3cXhxUnc7Ng54wzOxIaSJFSbJpK6V82AT
         nGSZ3BO0ionNG6NoK+9SQHzK/c9UvCJtl5+f1Vtc+wA0a/ZvHcMMATR9xf3V9Xf3PRp3
         CUKtmgT8cka5ZpHs1sZqSCZceYt7zUEPwDqtwn4rp+Dah/vEgsLxUO6i7NqxbIqJNowZ
         lFRYr9tdbxSDhY3Y83xFNG0IB99+22cWKSpkQ64h1AewoubHVgwjvsr/a1QbGBchQNrG
         uPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737403901; x=1738008701;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpAqr5jIt3uiRXjUnKjrgnDNDsGAHfvj6DptghegyYA=;
        b=k9GS7eN/q+5OCN8byMJHgdlZ5Oy/NQMCK13/NPln2X7iQ76nspaEUsSgPn2LYWfbnn
         u14SWRwqrdK5LaqsF/MOmviJLBcI9GxxXPZzJHiRu32/kYwG6HauJ9HrYK/zpJ9hcXVP
         yQY9nhQAsPUDUQ/RzC30kyRLZL3vGKUR3iDzrQYSECLm7eoyJZqRtGd+HdfgwdrUXVAF
         acqYtKYT3DwiDdzmthn39zDRkj8Eou+QDkjQP6MtfAm5MmSS7Fs05kBH6hobPlj205ck
         wmONQnTbm8iP61Dn0sI9BV9azvhvc2OJepgwthfshYRPpGIXDigNNZW9mw5XjUUo337O
         R5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAgjgkaSnqbd7AfHcM3uoEF1nyFXwR2GN0aegSL68FFBWxlU1x2wA02N6wkNmSzPwA+f4rT2KaziuLZsiz2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw997wfTXeWVggm26bBslhx5X0670C1NqaWoRyaebECF/+vUf/n
	mxR5uO+4etoCOFv84B4QanPyM6lpZaI3FvsQh4s5HjWi0k4EevT8OHu0is/DHNvD79ZL3MBenv7
	I5qBqbPvpTAkugek9FOS/2g==
X-Google-Smtp-Source: AGHT+IG4xjDkjq92PeXe/NqipBdjYi2MmKqrN60LHzWU7Slr3RIeaGGFeCBKl5znBQ0YMbY1xn1jrlL3o456UNML4A==
X-Received: from iowg17.prod.google.com ([2002:a05:6602:1511:b0:844:e9b9:6f8e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:27cb:b0:847:51e2:eb0 with SMTP id ca18e2360f4ac-851b62afe94mr1169419539f.12.1737403901124;
 Mon, 20 Jan 2025 12:11:41 -0800 (PST)
Date: Mon, 20 Jan 2025 20:11:40 +0000
In-Reply-To: <173645110935.884997.7060671564225875763.b4-ty@google.com>
 (message from Sean Christopherson on Thu,  9 Jan 2025 11:47:07 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnted0x2qkj.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, mizhang@google.com, 
	ljr.kernel@gmail.com, jmattson@google.com, aaronlewis@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Wed, 18 Sep 2024 20:53:13 +0000, Colton Lewis wrote:
>> Extend pmu_counters_test to AMD CPUs.

>> As the AMD PMU is quite different from Intel with different events and
>> feature sets, this series introduces a new code path to test it,
>> specifically focusing on the core counters including the
>> PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
>> counters exist, but are not as important and can be deferred to a
>> later series.

>> [...]

> Applied 1 and a modified version of 2 to kvm-x86 selftests, thanks!

> [1/6] KVM: x86: selftests: Fix typos in macro variable use
>        https://github.com/kvm-x86/linux/commit/97d0d1655ea8
> [2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
>        https://github.com/kvm-x86/linux/commit/c76a92382805

> --
> https://github.com/kvm-x86/linux/tree/next

Thanks Sean! I'll get to the rest. Sorry for the delay in responding to
your comments. I was head down in something else and didn't have time
until now to remember what I was doing here.

