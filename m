Return-Path: <linux-kselftest+bounces-32174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD0AA7183
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A9A1C008FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF525179A;
	Fri,  2 May 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSUDdo/V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95F250C08
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188299; cv=none; b=N0oVUPGyFrQnAERgVwosqzQgUJCDFZU04qF14p7Z2cYRCbloWTlcbbHd3Pba2Q3W5kX+LvLw2N/LN2H/6/LghZnWqrVMOJjSDQTXV8Oihn7gPFndJqlioqDLm06O4yaa9xioQX8Vz4koKdfWCUQLHUqAt9RpP42xuqU+fYenlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188299; c=relaxed/simple;
	bh=vGE2Q+jxE6JFBFMDR7fs6IEpZuRYN8Hz1ei0pbuERLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TNCO3oB5ZY7g7x+t2ks3DgqIsj+27hIO5RqGxSk4FryCezcfjrCFv1yMIoU3iqOiZ0v/6ldC443Q5lKivKuu3QWRSGQP7989t1hUqgz8+Dui+F6IlFoHyfcTSTzE4v2Lt6bLs9gFLy84bfYqY6JrV0vOaJMI3PaRQGWZs1x4j4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSUDdo/V; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso12152505e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746188295; x=1746793095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4EIqRH8s+HJXS4njQ/v+2ek79fyo/PhNx8U1JoTIak=;
        b=qSUDdo/VPjFGYaD+QtZjS4yzOs4pAZKoD9m9vUR6iniQ/5UDzdShCXE/6Qg91sa4MH
         HLopWUuUutaoWe8Ln+kycZWMc3OXoudKTzJvfVFbUHxgPVtojjk610iCMNXeGgrpfREm
         dGWyywIQudq1BpHae5avHPwZQ4Y4CP4AzCaCaZSPMwjE/bpumIX32xujGIsAIaGNZk6i
         iUiItuWQU5lK0J7o6soH8V31A2Qh7hSbGNifXOrjdHktC0NbkeqR6S9Uc4rF0MzRfbWb
         hTJa8nD5LZx9LXlXNxdq8E4a30JeFIROtssNGmMKHZZ5PKIRdRBhbG5m7/YSL0cG9iD4
         ZkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188295; x=1746793095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4EIqRH8s+HJXS4njQ/v+2ek79fyo/PhNx8U1JoTIak=;
        b=bIg5U4VeJ4aBz5hrzA28RXTxKOkvCuFSFaSFqZ2vYsc750IsgC+Q5Ru+Q9wwgYKy2N
         SfoR+DGGo/xzq0GVbX9K1iaIQuKbuSu7iWfEjVMVhn9j+OYwen4EW7f43L54wPObNPP8
         THr8Nzo3pwlwFWal+2FsacGdOvHSal66o2PquJf23a4eu1f18+LQ++B8jET7ohfUNAAB
         uDfyxNp7QqrePoF0NlywBn+AJv23/mgwPBwsRj4M+ka+4w9D5K948BsjIVXGZQTQfnoq
         NFD91pEp9VDsKinRXjah5vpzHSHsizGr5E/eWTV61SgahDKMK/ph0rO29kdIiE5ybZ98
         9oew==
X-Forwarded-Encrypted: i=1; AJvYcCXbZhFb4Ksjh/+ZTWeexTEKg+/cvP4W1i/w89isy7S58IHhvVZkksNzft1rVQb1HKgY3KcnHE2dMy39hvrMk9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtwfFEs1AuUXXChUx4dn9lejEBOrd9x4APMUFhoPvaoWcs52H
	hpnev8D8gu8Wn8heRSwnGTQMiGJxx7zIQY/pR9oK2I1sp0PRx8YfZy7Fm14l+oaTY7LxbjsDlLx
	ztthKCKVc3Q==
X-Google-Smtp-Source: AGHT+IFmoIah9vIU+ME6LTH3yaSoPOxR0iqcuVmJEVttYxbVNA2iy85jqW8QzQsVUdCyB+30OgU962ian6s4pg==
X-Received: from wmbjb17.prod.google.com ([2002:a05:600c:54f1:b0:441:bf4e:899c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8711:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-441bb88d42emr21008445e9.12.1746188295600;
 Fri, 02 May 2025 05:18:15 -0700 (PDT)
Date: Fri, 02 May 2025 12:18:13 +0000
In-Reply-To: <20250501163827.2598-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.0
Message-ID: <D9LO37W7M7YJ.2R0GAINJRE55C@google.com>
Subject: Re: [PATCH 0/4] selftests/mm/uffd: refactor global variables
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu May 1, 2025 at 4:38 PM UTC, Ujwal Kundur wrote:
> This patchset refactors non-composite global variables into a common
> struct that can be initialized and passed around per-test instead of
> relying on the presence of global variables.
>
> This allows:
> - Better encapsulation
> - Debugging becomes easier -- local variable state can be viewed per
>   stack frame, and we can more easily reason about the variable
>   mutations
>
> Patch 1 needs to be applied first and can be followed by any of the
> other patches.
> I've ensured that the tests are passing locally (or atleast have the
> same output as the code on master).
>
> Ujwal Kundur (4):
>   selftests/mm/uffd: Refactor non-composite global vars into struct
>   selftests/mm/uffd: Swap global vars with global test options
>   selftests/mm/uffd: Swap global variables with global test opts
>   selftests/mm/uffd: Swap global variables with global test opts

I tested this using this script:

https://github.com/bjackman/linux/blob/523e40a88fac34b17f49614dfb24fd5e18e63685/.github/scripts/run_local.sh

After manually enabling the userfaultfd tests (I disable them in my
crappy CI thing as they are flaky):

https://github.com/bjackman/linux/blob/523e40a88fac34b17f49614dfb24fd5e18e63685/.github/scripts/test.guest.sh#L15

So

Tested-by: Brendan Jackman <jackmanb@google.com>

