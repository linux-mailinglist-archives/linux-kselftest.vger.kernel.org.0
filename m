Return-Path: <linux-kselftest+bounces-29240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC080A657B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6DA161EBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A7194C86;
	Mon, 17 Mar 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="244yvZmO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AD17A2EF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228005; cv=none; b=dW4BNEbcsd1rdKCiBpjnDvnXcMOLyAvcJvWTi97RMDPlkfIqkJm5EQaDEwUv8LzaeV5baF3KirTfj83sP+qrJ0MTKqeCL6A5x9uWxGvNEhRly67P6xVr8y79ygMgxuM3hZYEH1ewu7E34wSDWNSMuyxwOEhN/5tY21JzKnRYM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228005; c=relaxed/simple;
	bh=Qtz7p+qAYY/3PwQbatf+dww5SC/v5fIM77DIa/Z35C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5nKIZF3GpL6wiC5ay7KHdwPhSQbblRrnWcmOQf8VwKn9oN1dAb/GZ8SN41UeJklFrv4LKDDWgV2qPW7mK+Uv5SUYdcUoPm3jVBvIt/lPwf+vkDWQKHrxzeX2Hia33U9gWw49FNr4zfqcSrYcuLX2p178OphJbUuKrCHOMfv8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=244yvZmO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47666573242so107621cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228003; x=1742832803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DUp3Sy0r3ex2clGVuTENijtSpkjkLtkEQ986ciUiGnE=;
        b=244yvZmO1UdZ9IzqLTD2r3OKzynuX8pHzPZDOjyQJcuHKkNKpPovBwGieqaEOyNcel
         SF8fG0djMEDPHe0o+ClynVvdghs2KFFNiQwTZyL+yOqOlFG3FtJh3BqMIF5xpT4ff6KF
         bDex6XBMXnhPrbeV+pxljLJcwtF2V6/nEhZC6NVv+9IhOyySFzCXMIe6NYmXA6vM4lVU
         ziI39lvP4X5KGNZSwPSiaDKVZa3ab8wFeMTjxaDZxcGVAA4ZM4khSCNcpWF5oRG7Gj1W
         AF9UZ92i7Y5NmcsiDzB+PBla33szzHM826BwAD6AQIKYnuSmzKvV7Mk1/vOFBKtvY/3K
         pO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228003; x=1742832803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUp3Sy0r3ex2clGVuTENijtSpkjkLtkEQ986ciUiGnE=;
        b=OaAGuIHXdkbuDPeU81yniDkM6KSGEv8zCJm73ai9QWT4QP5ViM6I4RQmGqJOxOiStF
         8BoCbLtf4ourWIhOB0+ywxzvf49unzMtuj/OxrS70nSLe8DXi00QnBm7rdnYcfBOtZEp
         MT9WULi/Q2Bsg+2c1izjZc3GJIbDnqDBblbK0LixdH/5y/jnFCPX1jy2wgyG9zqnBqS9
         aZrByOeixx1Ow0IWEqercj3OTfIxWdYPFiETzaNLg8IXZ5xxbu5+zNFBfY7KMuYLaLrz
         WBrKBp4SEhu25PhY7+l9FO6VpqKKk5cg3VXm8slLGb5aDPQ/A66P9WpadGlBlOWoyX46
         YkHA==
X-Forwarded-Encrypted: i=1; AJvYcCWvmGN7dhvUEscoXrbAQg+SRKZE4bys/iiXCJLnmo2ZB6Vo8Ag2uIHK2i6cgepvpkw8dQo77oewdViA3dPqdXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEC3U/t34Cyj14sQZia+EKopSk9rDjjb9XECsNZhxVEU38+8aY
	c45nAUD65ZJ/hF0MNV3tZ7p5NhY8N5EIwDqBRemcpJNm2fJ7SLWyq/WFoyz+F3IzcpZtOR/Rq23
	kP7yW6v6wCm9PvQAcloxRJiiFsWRmnHDDrqMF
X-Gm-Gg: ASbGncvCa9EWrO/gQyIsCmzut9jlLmCgoLJivam5UaaMasPLrRbkRgezZacuWtveslV
	ZEVIxAguO9fEGszrcP1UnOoa2UQA9XbZPjYiauCHDtMQn+mtnkbBzuZjecjxnPY4ur+eAGy+4nD
	vjHoiwZqt4Dsvdb08qFTNHbReD5RuSMQjM18X2zy8gJc1A0emyCQkWplI5pdbZRVpXr8g=
X-Google-Smtp-Source: AGHT+IGp5T+nbwvj2pnhzXY0OLK0W4OOqrMBHMsVJ2shuSCrVzln5u4AgmKzFlSy+b1LEmAE3f37cTri0Z6r5gpSokw=
X-Received: by 2002:a05:622a:2303:b0:475:1410:2ca3 with SMTP id
 d75a77b69052e-476d6455973mr7438041cf.15.1742228003130; Mon, 17 Mar 2025
 09:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com> <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
In-Reply-To: <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Mar 2025 17:13:11 +0100
X-Gm-Features: AQ5f1Jop9b3Sam9E4Aqkea8e1CkU7NpyiiWCx4vud9QYvcgrDCB3PeJx7vj9eNc
Message-ID: <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 06:37, David Gow <davidgow@google.com> wrote:
>
> On Fri, 14 Mar 2025 at 03:27, Rae Moar <rmoar@google.com> wrote:
> >
> > A bug was identified where the KTAP below caused an infinite loop:
> >
> >  TAP version 13
> >  ok 4 test_case
> >  1..4
> >
> > The infinite loop was caused by the parser not parsing a test plan
> > if following a test result line.
> >
> > Fix this bug by parsing test plan line to avoid the infinite loop.

Hi Rae,

With this change and this input:

https://gist.githubusercontent.com/bjackman/220265699f346e16161c6534b115019b/raw/a2e0e1aa75c0d8ab9814708b028ec78810a0471b/run_vmtests.sh.tap

The infinite loop is gone, but it's still hallucinating a [CRASHED] result:

[16:07:15] # SUMMARY: PASS=17 SKIP=0 FAIL=1
[16:07:15] [CRASHED]
...
[16:07:15] Testing complete. Ran 19 tests: passed: 17, failed: 1, crashed: 1

