Return-Path: <linux-kselftest+bounces-23517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4799F6ABC
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DED27A15E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFF1DF27F;
	Wed, 18 Dec 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ror4JQ0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013201A23AB
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538117; cv=none; b=Ve0+N2dNcbM0CpADY8NXmMxF67rsWmIiU/360BmV3ts3pSFtOBzgU7Kc9y0wJDmqK4Fc119R0qgJYx1kc2dofi6NsxjhkMdwcKPogq3bFjTVxwhtwPoaLd0xulC3IJs7DMP/MJflesnjMoRiZbkOVkeXzVgmF5QUKDqoPaar2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538117; c=relaxed/simple;
	bh=xbs6pkcGGYg7MyC5acef3Ng6hd1HLWjVDBGDfxb/tJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o5NIaQVOkYfzXuZfNdcjyyGFgOB0KwnFxSQfhOMFymWva9SPkdWtqyF98AILNm2VaudgzeD4AnKDmNpZxesfo+ssPcX/41MppFAF5wKYdgp/X7ut4ZuEiX3ZFqkk3mYTi2FX9BTBA9FRJtPhlJpM0PxH9EvMTDCfAFWDnAPj2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ror4JQ0k; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso11473410a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734538114; x=1735142914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QW50ES75k7ZlA+0aVGA2vQrwcPxqpxjuyk1+khizvpM=;
        b=ror4JQ0kE5AOwhenmIghuE5eMkA0VuPgU+Q6k/fpEt3uL1/W7mNjdiVgG69ysPSTl+
         86vmU6mYNgvpZxowsbV8GbD3lZCDgB4056/tbNobInAkye4sQ8VbAxiEMQQELOvxvhp7
         1UqECqrUJid0GDRncmQsYY2WY40m0OIc0BY9Kg3DUdn32RLrM0QLRVweE7SnFRP5YvRB
         mCEMJ6cpoj/KItcYVT33LQxOh+MeOzAUWpQCToc8ApiwBb9od+DRjOrQu/MYev+RL4XP
         Y+Pa7GW020USzsFKGf/09IOYu4oRfPSnN0gKIx0rtwp/MAMENCZEu0leMMZgUBBrVHxw
         Q2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734538114; x=1735142914;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW50ES75k7ZlA+0aVGA2vQrwcPxqpxjuyk1+khizvpM=;
        b=kEHgXp/MCJ8jcJyzGB9wd1N4AAM7MPVMRtuosnn2CyEMu+DLAF33zVBokBgjka6rla
         em0hTYRaCuCAq6+CgPn5jIQCLm5hvS8UiJx+MqmSVezP0qFIqTG1Vsu9HNBVjYmmOlqT
         wPiRHcmK9H6DGWTXMIDzZIbgnx31eUN02L2IaKajPkb+QohqwlIzWFK/nbPxPhSgpbks
         gqh7syTK7Yby63mizN7OOi0DnGiiVJesfMXaCXYkcqrep/MX6cQZWQjhCegheIk7+f5H
         SQOojt1PJ6bNt/sYSvz2HoOKNx6Xp904ypULRN3C7Lj5vwdk6y8kpKJXdFEFlgFunA9Q
         jpUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rILVQyXwu0pWQP8OX8Zst81vzEAf0Jkhmg+XQTT7oB8NbmEc/8bZ46i6GHlB5VSM4o1K673ImWjEOSk7+zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nFxBBdJFMmW9zK/kDZvDa5+sK8xpe4CISq6WoFuWz/PzOKvz
	Z5CrfNDeis50AL1aoXh9PqRCKrV8JbjtOBJppn9tLG5Fyc8fBWe9N7bmMcAMQyXoUKymgv4QUHs
	u6kzaiLd8Z5TUkfPbOCmXrxbo6bMX+JDmz9l7Ww==
X-Gm-Gg: ASbGncsdpH9ja0hM+db/eiKeuQ0N1/TZvcYivSJmkDF9Ky/gBhXfh8B9yxbF2NZog42
	Sp5TJpcNHIBJJJoMKFJtgPeqI7M9/WKg3RG9I+HI=
X-Google-Smtp-Source: AGHT+IEvRDswF6qCA4Q4qe8FqmZE+32BF9dCulruYx6y5eM7Eq42ZItCwVXs3YMMPKWYBAIm0XcFZu7vNiJzcGvFsW8=
X-Received: by 2002:a05:6402:2547:b0:5d0:d087:6d5b with SMTP id
 4fb4d7f45d1cf-5d7ee3b614bmr3267431a12.18.1734538114296; Wed, 18 Dec 2024
 08:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 21:38:22 +0530
Message-ID: <CA+G9fYuP2bHnDvJwfMm6+8Y8UYk74qCw-2HsFyRzJDFiQ5dbpQ@mail.gmail.com>
Subject: arch/x86/include/asm/current.h:49:9: error: call to undeclared
 function '__typeof_unqual__'; ISO C99 and later do not support implicit
 function declarations [-Wimplicit-function-declaration]
To: rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The Rust gcc builds failed due to following build warnings / errors on the
x86_64 and arm64 architectures with selftests/rust/config on the Linux
next-20241216...next-20241218.

First seen on the next-20241216 tag.
Good: next-20241213
Bad: next-20241216

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this regressions and found,
# first bad commit:
  [20b3c3eccd9361c9976af640be280526bef72248]
  percpu: use TYPEOF_UNQUAL() in variable declarations

Build log:
-------
arch/x86/include/asm/current.h:49:9: error: call to undeclared
function '__typeof_unqual__'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
arch/x86/include/asm/current.h:49:9: error: expected ';' after expression
arch/x86/include/asm/current.h:49:9: error: use of undeclared
identifier 'pscr_ret__'

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241218/testrun/26395023/suite/build/test/rustgcc-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241218/testrun/26395032/suite/build/test/rustgcc-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241217/testrun/26355712/suite/build/test/rustgcc-lkftconfig-kselftest/history/

metadata:
----
  git describe: next-20241216..next-20241218
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCRNosQCRWxj5dIUE87pDXos/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCRNosQCRWxj5dIUE87pDXos/
  toolchain: 'gcc', 'version': '14'
  arch: arm64, x86
  build name: rustgcc-lkftconfig-kselftest

 --
Linaro LKFT
https://lkft.linaro.org

