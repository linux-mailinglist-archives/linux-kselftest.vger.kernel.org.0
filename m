Return-Path: <linux-kselftest+bounces-4410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C284F3E5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976D71C20A4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0321EB27;
	Fri,  9 Feb 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9XyB3S1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE22E856
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476145; cv=none; b=W183arSbuPkD2yfm0CB+GZ6srEqN7kyF650BEcj1Hb5o4ugGWfcfGw8GTL8077xV9HaXX8ChgfCekZEUjS6MuQJJTBMDoFN5ahoSgk2w9Ritv133l8UHlWIw5mfkwiaFzdMP2ATAuaD6xACgb2+GRQfxa1BLnwR7zb9K6yNBhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476145; c=relaxed/simple;
	bh=o+/IioxPnfla+dglQmYWkPg9m2XjN6K4vBJSsfMOeaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kbNNOVAaoCjEdLpxE4mpNMk/++/stLUi5ElKXcAk3t9y9LTWPxHVJHloKUlMVJZw6axu51rF2EPIDr73LLM51gk7egAvlCa0H4gjwTost+6yP787QeWK8fE+MumYKHWlblTWmjmVar4SirkNBXhRiRK0JnCVT4eMNNjD7/pT2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9XyB3S1; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c0375d438eso277925e0c.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707476142; x=1708080942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jhuyoBsFKzxtpnWlhnmTfZzhM8BWCrRSLCg0dJcXB8=;
        b=Z9XyB3S1xW8Rx/PXHKKLcBph+ns0hKGZne3wQOsLZwXHEaGH/o9loUfWOLzebtXhQ1
         esW1PtpOfTiSmCKBE3yg6o8bBmQ4fgffADfKunFaL6t9kD/65RgfqC4iylLqkcSBG9NM
         R//gpnN/aq2ymSb6cdHoRX9QRN7lpsucYIr9dIMSSdGQlRKABwWA+E7E8Yvwy+bB5AFm
         pTapE5JjjDk4TdQQJo+Q+tEnMvooJC3NgZzZbHXsS+/sY5KYCh9UqRGEFk1JKWWgpdzT
         FzjhXvfwPyHnlydT7q0cZJypv49fy0oSKzfTucxN2+VWTdM+qTv37SXROUDocvbmbtdi
         7W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476142; x=1708080942;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jhuyoBsFKzxtpnWlhnmTfZzhM8BWCrRSLCg0dJcXB8=;
        b=CPMxPtoyOd9uebEym+g5/Ldjl0pnfWZG5bL7ixxh2f3A6fcqG9k/oMC58XSKbAs76b
         ff+tdTeCaz03+WRKCnirhCMrg0p1Da0tgVUJ+T5ZCpUAFUzNbCRNQGqbCAjdyYXlgPrk
         Cy0WSJPgMSI3+g659BDtNc/JqmNgXvBJq89iwcJuRyGJ8AfpV7DDTN1YpDaw/0IsiyXS
         gDvcQ0ZrjvQPiilgxUvyiP4pDPMxbtl5EZRqnR0z2UXUlL/yUwALnKumha6a7HyJmQZa
         PFTxsRkGpeY+/rTDphBxvq6r20uL40gmLjD0HLiHsYd2pElv6rgsyLOXPrthWXJy1clf
         c+hg==
X-Forwarded-Encrypted: i=1; AJvYcCVlz9mi1GJdD1+sQ6/7WGYOqKCb6ab1yn2CCDmPvhaIb4q4DS7s2LJv6Z6C1N1P1aAMYCIfXTPX+mLZ2AzrnL5r1oBfqCipFV1yU7Z7gee0
X-Gm-Message-State: AOJu0YyKvK+t01CgFqIlAf9/ff5igG/Eny//tXg03Rb0js1hVxGJpW6h
	31z3gWb0dUAja1VcgT/IbV3s8/9ldKFJwCOM7KybD5XgndKYiE10qz8IdWN4blvhYUrRfczLNi2
	h/k02IZYF4utY2+CiuOvUaSi/vy3daO0ibMduWQ==
X-Google-Smtp-Source: AGHT+IGOvIWPUUibYBmld0tkqSUyoDYLjUuvcBaVP4a9ufjBsQCQ9MzKEEAWhiQM0P67jY13SdRYbhmNlFMGNMybc7c=
X-Received: by 2002:a1f:6683:0:b0:4c0:fda:7d8c with SMTP id
 a125-20020a1f6683000000b004c00fda7d8cmr1380013vkc.2.1707476142203; Fri, 09
 Feb 2024 02:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 9 Feb 2024 16:25:31 +0530
Message-ID: <CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com>
Subject: selftests: net: ip_local_port_range.c:152:17: error: use of
 undeclared identifier 'IPPROTO_MPTCP'
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Mat Martineau <martineau@kernel.org>, 
	Maxim Galaganov <max@internet.ru>, Matthieu Baerts <matttbe@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

I encountered the following build errors while compiling the selftests net
test cases on Linux next-20240208 tag with clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

selftests/net/ip_local_port_range
ip_local_port_range.c:152:17: error: use of undeclared identifier
'IPPROTO_MPTCP'
  152 |         .so_protocol    = IPPROTO_MPTCP,
      |                           ^
ip_local_port_range.c:176:17: error: use of undeclared identifier
'IPPROTO_MPTCP'
  176 |         .so_protocol    = IPPROTO_MPTCP,
      |                           ^
2 errors generated.

Build link,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2c4LtUoRSYhdGbErOY8hqHxc6Tu/

--
Linaro LKFT
https://lkft.linaro.org

