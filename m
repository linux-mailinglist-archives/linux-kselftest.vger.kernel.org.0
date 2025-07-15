Return-Path: <linux-kselftest+bounces-37318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6089B04F2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 05:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C13BE194
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8F2D0C81;
	Tue, 15 Jul 2025 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b="pDyTujqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE52D0283
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550682; cv=none; b=UKR+0LL6JC/qC/BvdaSMwQCyUujnOdGfM9+J5E1KBU525PCu58ur6TTrxJAb5aSI0JwPAT/Op7LSoaTB2iAmuxw3TNCKxvzexySoE8kK4s5QgLmKE6ywBR4fA0pwcVd2AszlS5uhNvMZuTNVeN/sAjOH8hhbww2rcHiYv5lhVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550682; c=relaxed/simple;
	bh=ujj9L5ryXj4vi3ebJiwm+9FC0lN5ZlUdIqgmhKkl47A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NXM/vH8xrqdIrLjIGLp2eqS9fJU+72pPclRiZd6JmXL8XVa6UNkqhsOXssFHU+ZxsKUo6Q8aTSgo8R4uHntiHC58glejT2gHpCDg6bs3CkB9PneH8K8eO9lSP70curutzYyyog6TxahVN5FbMQw469dJWDOpu8ygJpCf6JNFo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b=pDyTujqt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so4877692a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 20:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1752550679; x=1753155479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxoHBnr34PRmw/hllTkLWN7QMmhZogDiI4M0YwgLywg=;
        b=pDyTujqteo/bFHQxAbsl4o7NjljJKBxRITdeTqsuzhXJ/PKxPKDXuMD8lR+SBwmRTb
         7EYF5I0cVmEba2rbTOmvQLDJw3oCplVV+0OAfkWKQWiEE1JkuwmGginaZgOCBEsjA4yy
         1ZWzKyNBQALnYb9vL4nJAAEMJDriadF2FQVcd8jUobMEBzgH6YCAYLV5MVKQOnnSTyQ0
         zfJ+3mY7J5WhSZcO7faOpAd+jHVsLK4cnVHFhQGFCLFbyi8/ibWCVDW7iD6hNQSQMWUA
         B3G7BsfUIXQ8dYWt2ei86mcuXctySU/1gxo489t2XOLMdIkMTcETCyvUcNRXac9iOlt+
         zyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752550679; x=1753155479;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxoHBnr34PRmw/hllTkLWN7QMmhZogDiI4M0YwgLywg=;
        b=PwJPqqGNe0pAIOQAcaiQQFDyeoyJdBIxBkgcsap8WaeG7OfNGIQSZuRGHMynHygMu9
         5mWgKcPUxJhHZV7M1gF1e+grXI5xATZ7o2WZMdsCLOkgTYWC1sSz347F/gz2ojcl++gg
         4gsHmi5zevxOZArkJkhU1tJza57By52STD6QjpitvjiwlKgn1DqWh1D5//aH7aPLpNmw
         kVhTYjn5ddj1Vp3BzGZkSkw0BQLvbzsC1/ZaSPZyUR8a/ZxDnYdCW0azWPOtYhlMGyfd
         ADp7/5N9c9BdQDzPcVGA4YUl3ggyqConT2LnOQfdsINIUqAh3oy31Xa+mXSzQpHqd51r
         Jqdg==
X-Gm-Message-State: AOJu0YxNyoWNwh60dTdlDSF+oO0K3G7VbZRaDiYAAFKAMp4M6KaEmpDZ
	Ln9hRbi46kgSPCEP18FutxNoOKoapbFO2j3qrYFKdMUIrvhMPUjiOBTKKAigs83YO/nsbxlUv2q
	66bZM21jjDwYbDGlREwmYD0+apLXF42V4N3WTd9PAAxVyQOa9b0ausA==
X-Gm-Gg: ASbGncv65xFVxYuSH/Y9U7OvwIh4LNqwHwFMQdrGytye2sOVnLl6annqqPZvNlnydXV
	Hj7T0JGBmn7A+TDKod8nzcQ4bwtylOD6B8slLszyS5lBlUDUazajop5xUWt+OBSMr06XHJskOqj
	VnKe0BbtyFwYEMhlYUfC1JEx+yJJu+FmKxoizFCKt7sGI7PzkYsLt8ADKpQ7KsE0CRL+K9qvOcA
	joFsXc=
X-Google-Smtp-Source: AGHT+IFmjsgHW7JR+TtoUcaad1n4c2FzNzo8ztYC0NNGMQ73k3brFPEzEgDrPnersuDLLSAPwymBvX7PMR27bWjmCqI=
X-Received: by 2002:a17:90b:3d84:b0:311:ffe8:20ee with SMTP id
 98e67ed59e1d1-31c91e486bemr1780044a91.11.1752550679554; Mon, 14 Jul 2025
 20:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 15 Jul 2025 12:37:23 +0900
X-Gm-Features: Ac12FXyn-Uk8iPxQXt73EdHDNFOrp22BI4mdxLcNEl5Gbccq7Kxq9R-M5YFame4
Message-ID: <CANgtXuOhvp74zbU7hQ-unekkwAMj3=ObUb25ev6HnkhcAmxRzw@mail.gmail.com>
Subject: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at LPC
 Japan 2025
To: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shuah@kernel.org, sashal@kernel.org, gtucker@gtucker.io
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I am reaching out to announce that we are once again planning to
gather to discuss testing and dependability related topics at the
Kernel Testing & Dependability Micro-conference  (a.k.a. Testing MC)
at Linux Plumbers Conference Japan 2025.

- https://lpc.events/event/19/sessions/228/

The Linux Plumbers 2025 Kernel Testing & Dependability track focuses
on advancing the current state of testing of the Linux Kernel and its
related infrastructure.
The main purpose is to improve software quality and dependability for
applications that require predictability and trust.

We aim to create connections between folks working on similar
projects, and help individual projects make progress.

This track is intended to promote collaboration between all the
communities and people interested in the Kernel testing &
dependability.
This will help move the conversation forward from where we left off at
the LPC 2024 Kernel Testing & Dependability MC.
We ask that any topic discussions focus on issues/problems they are
facing and possible alternatives to resolving them.
The Micro-conference is open to all topics related to testing on
Linux, not necessarily in the kernel space.

Suggested topics:
- KernelCI: Maestro, kci-dev, kci-deploy, kci-gitlab, new dashboard, KCIDB-ng
- Improve sanitizers: KFENCE, KCSAN, KASAN, UBSAN
- Using Clang for better testing coverage: Now that the kernel fully
supports building with Clang, how can all that work be leveraged into
using Clang's features?
- Consolidating toolchains: reference collection for increased
reproducibility and quality control.
- How to spread KUnit throughout the kernel?
- Building and testing in-kernel Rust code.
- Identify missing features that will provide assurance in safety
critical systems.
- Which test coverage infrastructures are most effective to provide
evidence for kernel quality assurance? How should it be measured?
- Explore ways to improve testing framework and tests in the kernel
with a specific goal to increase traceability and code coverage.
- Regression Testing for safety: Prioritize configurations and tests
critical and important for quality and dependability.
- Transitioning to test-driven kernel release cycles for mainline and
stable: How to start relying on passing tests before releasing a new
tag?
- Explore how do SBOMs figure into dependability?
- Kernel benchmarking and kernel performance evaluation.

We invite you to submit proposals for discussions.
Proposals can be submitted here,
by 11:59PM UTC on Wednesday, September 10, 2025:
- https://lpc.events/event/19/abstracts/

Please send any inquiries to the MC leads:
Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Shuah Khan <shuah@kernel.org>
Sasha Levin <sashal@kernel.org>
Guillaume Tucker <gtucker@gtucker.io>

thank you,
-- Arisu

