Return-Path: <linux-kselftest+bounces-48735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754ED11DE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490D630AE78D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1A2C235B;
	Mon, 12 Jan 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BahZuqng"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFC26056E
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213640; cv=none; b=mL69zV4slP/m3dCkmMYqVyqqzMkm5llYJjzXlztuZKSkA97tACA/I3EfRe4YXQVE/atsav6Uj0sQVq7Ya8RwnjKQtMXONLQ/mO/OZ0ene9ZbX4G6NZ+AbEInndRiey4fuKeH7Bslmtb/NiUoWgFiDN5ntx6ZwH3OkVYBYYrC/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213640; c=relaxed/simple;
	bh=/OcnzYIs+nvQRD5T/arHhLd77GZB9o83jwScrQb6p9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YoWY+ard5u2wVj/g8miUUNOJF+af2VRkeZKnrlsdRnMnKHS4kAgGNSn07Io/++d4JLQar+FjFLL+/FtaYZVvW4MaiSP0JYK/dBT4Ci5YCJu603F8bPlvrd/GvPu7i8Phu9H9FJV4uzc3jvRkPG06AoRHOXrkMM4zUNFc68OqhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BahZuqng; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8701175a88so96615366b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 02:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768213637; x=1768818437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OcnzYIs+nvQRD5T/arHhLd77GZB9o83jwScrQb6p9I=;
        b=BahZuqng7T0+izWwP/UqGGrAWO16Q/RKmU80ZJ43ZrB/jQZ9wgzkdjvBpgVgOuiLzG
         Fiigmy+eQTWfeZ54MuD1+HFZmtNZKeiJi/P00uRy+EEzKCwmyKGvuo2oS2NtyfWCYE/K
         QGkJDLunC6GU07oDVQeRd7i5sJVX9xN8PVdN0TMI0bYqZcj0DNRRijvCseUG9k7oEmNi
         valGp32tORXM1DJ/kHIU7CYJSitGdLdE+FN7gTnlrqmY4L5XSPTb2B8Yqkt666c12+BT
         Oq+NlT27CZaP19rGkom3k41SMjEN/Ulf/oRXlgey2zOru/H5rXxMiJ/c0uacXmpMnMnu
         8Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768213637; x=1768818437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OcnzYIs+nvQRD5T/arHhLd77GZB9o83jwScrQb6p9I=;
        b=WdRzKCFGPQkdydVC3Sn6lot/ot2dP52/AGysXpL05fEx6Z12OxQ5ZZvUPA8ZkD+ksd
         kBwLEgHDI4BDkDlzw+AdUVd2iRTA2BXExHZ4PpXFQBxjDDu235fSSU5gGcg7Q4VaSIOz
         BpTNao0TQAmsvsyfNMYVrydKRwl/AVDMEdV4jXyCzYpQjlzB7mhL9r18VVXOu/ZKNew7
         GQlZoZRJy/jX2lf6ZSStYcmrgWXAgxzNSB1msGFrEpFFsV2Vp3c6Hjcc+OCikncfOZD0
         6R/8Or9TO94cseFHVq8um3GSiUfcCyI+YzQdFLC9yg4hbnLItBeJk0fuOGl0ZmQDcFKn
         UwYA==
X-Forwarded-Encrypted: i=1; AJvYcCUUBF89FkCyZxWVEO1MMoXDuWMR2kuXatxGB9ahKimnPbSApOZsTCWyXw/Ttfz+IbgatHyOhQgIB7jW2OsKtGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrAfgdW4oz8yST/ldFDkK/ytNI9gm7j9ZO5/4N3iMdSgDncSt
	VnMeewg+19fvbh6+H4aTbMITbdDzeNY0bGtqqloFNGbHUKTj3VIaianwOwbu7jEGTJV4dMtMS2I
	s3mwb8Tiujc6ZEA==
X-Google-Smtp-Source: AGHT+IHZcTUd9JtBkbA4Ff21KbsCNwcOB4RCa/TipWmxjc2/LKdAT08tD9PvaWOaoTJ16cAK8lSFKQIasyVrww==
X-Received: from ejcre13.prod.google.com ([2002:a17:907:a2cd:b0:b87:1820:251d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d25:b0:b87:1839:2601 with SMTP id a640c23a62f3a-b87183929d6mr333880666b.40.1768213636875;
 Mon, 12 Jan 2026 02:27:16 -0800 (PST)
Date: Mon, 12 Jan 2026 10:27:15 +0000
In-Reply-To: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
 <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DFMJF68KIIHN.3Y2YF3EXRJ53@google.com>
Subject: Re: [PATCH] selftests/x86: Add selftests include path for kselftest.h
 after centralization
From: Brendan Jackman <jackmanb@google.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, <naresh.kamboju@linaro.org>, 
	<broonie@kernel.org>, <bp@alien8.de>, <shuah@kernel.org>
Cc: <anders.roxell@linaro.org>, <arnd@arndb.de>, 
	<benjamin.copeland@linaro.org>, <bp@alien8.de>, <dan.carpenter@linaro.org>, 
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, 
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<lkft-triage@lists.linaro.org>, <mingo@redhat.com>, 
	<regressions@lists.linux.dev>, <richard.weiyang@gmail.com>, 
	<shuah@kernel.org>, <surenb@google.com>, <tglx@linutronix.de>, 
	<x86@kernel.org>, <linux-kernel-mentees@lists.linux.dev>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 22, 2025 at 6:29 AM UTC, Bala-Vignesh-Reddy wrote:
> The previous change centralizing kselftest.h include path in lib.mk
> caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
> ":=", dropping the include path added in lib.mk. Therefore, helpers.h
> could not find kselftest.h during compilation.
>
> Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.
>
> Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360
>
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Thanks, this fixes the issue I reported here:

https://lore.kernel.org/lkml/DFHI984SEFV3.2JL88CLHNT2SO@google.com/

Tested-by: Brendan Jackman <jackmanb@google.com>

Shuah, does this go via the kselftests tree? If not, Boris can you take
it via x86?

