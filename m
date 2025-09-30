Return-Path: <linux-kselftest+bounces-42611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D2BAB288
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 05:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6961B3A73EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 03:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031322F74E;
	Tue, 30 Sep 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYbkka0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802B20FA81
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203128; cv=none; b=GkoRx1ePH2TF5WBiDDKEgB5LQuRLHT5aYOJE3p6KGx7UvP8qyTWrFY9w4/jT4afIFplJKu0Qg4WyTTB9I3OnGN0FEsoPH17j9NYVHdYql5YxKqZMu2RALUsmRXSKFjp9l85frENav205FqxAwWVhrKCcPbNpjzWpg9BRegasErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203128; c=relaxed/simple;
	bh=Y+lQgfVtEaVz7kZQiydB7t0gpe+2jiEEcUOe7R2jlA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juHbnfgTZmKt6mHssKiBJX+jRzLsXjl3JNVvfaDUgZ7GeooM5JI7UeSsNgWQ4u7m5AO8Ei0n4k4ZYif72HhPh6fOj24jMdIs8GAWwmXECPg6N6UGt9Ewh3HMLKzIfI7P/5EuzrJjDDFqT9EQ6JstaPVWgStQRI+FgKioOqMC1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYbkka0U; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781251eec51so2688124b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759203126; x=1759807926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipg2xSQ+y9eG+cY+ycWtarKVzuOf0KH86wwLmftXUAk=;
        b=TYbkka0UOXhpDbUmwAwR4fT69omLNHcYhshOIVdIyWzej8p7IoHNM5I9u5deo3vw9v
         18gKXoOFH37JIXSSOuNVzZve3092htk/s2qnw/YjReD4IHKML7LTwZX4BMrKK49Je/vi
         UC8tyTGiD4T1H8vkt0xaLcukFfZhWth1oWYHyi1s/DozsmIMDmdhwUCRIwKE33k3bxZH
         QMQ9KTT4JjPzPxe/+CjNcNNBezJ5R8b9ankxokyGwS7nxraF5Wgg7grcoKe70h1Sg8M9
         ERvvvWY9fDMnqDOZs/XdWxU3u39IcxZwAOJah7Ox9+JnpY+cXG1iH5D2PsCaU0EvnqLc
         rqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203126; x=1759807926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipg2xSQ+y9eG+cY+ycWtarKVzuOf0KH86wwLmftXUAk=;
        b=CsyY3wpstmcRnmnDUZP0VIPehn3NDCmZXpl90/Gnu6OETkyN1/IdsdSWM/PaVTHqUp
         MK3lNlTsvs+2Cmek7zkdCValH5EYJ1e+IRKStEOdAvf4XvxZH+S+8WAzULS5H8g3zlZG
         CHDQpAwpSjAH0CPOGBeEbTjWHhVDIcll4l8W8ur5VI5WuqN3mskrGNdAHiRVBZ5xB9pT
         FsE5ER3V89zFrrCgc5ktgBJNWoYr+l+p+Cgu/6gv4JIFno4HVkz0hqmsJfH61I/0Zb7w
         VCoZV2qPWK/VeRk/sidZamjvr3ntYMim/3FdbgeynZbAj/XYpahrlccPxAgIphv7jddi
         VUIg==
X-Forwarded-Encrypted: i=1; AJvYcCVycxyiCN3uxzvuK61vLlqm2Py73RuQbC5SX0J0NaGlDmHmqxwU3eSlJkp9fCvbNn16Fmk/LjPusB9pBJ5mOBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJcZwPzyumpPbzaBdRoB3v4U5u4IAYr/i0uK1scRpFMHDV+hs
	SxozP5VwYwMDNhMiooTr0Pv3IaVK8Q9KxHQTWHKv4N4LdVY3n11uo+EvJNkQn0P/
X-Gm-Gg: ASbGnctXw/6yQu2ZATD0WBcLnASDR6Gt3GcNpyXNK6CAZfhNsfUkmhlE6x/4y5Pwx65
	yB2M2sYT2a/ll33PS/u4VHN+p8BsR+qGTj3/WX89IWmJdCWZT87diypoSktDzSU3p56fssTp0k+
	7Wywpz7n01CKNvpLipjBye1ya0dJQIKbSTpJOPA2xJEI2cMWFWR16lg3y8Vqt7thkjsdgRGh4E6
	/Bu0+JE9cD4P/NLOgHbLw3EAvxGqPoh5jU4V3uzU32griyH03rRmVDRQBjqwknKvVE0DycFCuBr
	xUroksv5gCY7a858P8z2yAydA+ly0QzaNz8cFGd3iXcu20SjzNISnyAzMVtgPVuBr4/R3WOnQjr
	iMuVajPOFXukeyT3ZT7jEMfWlHWogQWAm8naCttXbiNTU02uXBO9MCvZdjWpbGSK76me0IvP97q
	Jtfz4=
X-Google-Smtp-Source: AGHT+IH6LhWbk9ue158EeoJf03eqT7m8bYm+d7vM0ErLdQPaLK8hlGYtsJv7ZK2fU0mzhBBLUHqIUg==
X-Received: by 2002:a05:6a00:b53:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-780fce27f29mr20086588b3a.12.1759203125932;
        Mon, 29 Sep 2025 20:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:7cd:1d59:4483:ece3:c019:40f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23634sm12557741b3a.66.2025.09.29.20.32.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 20:32:05 -0700 (PDT)
From: lianux <lianux.mm@gmail.com>
X-Google-Original-From: lianux <lianux@lianux.local>
To: sj@kernel.org
Cc: david.hunter.linux@gmail.com,
	hannes@cmpxchg.org,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nphamcs@gmail.com,
	shuah@kernel.org,
	sidharthseela@gmail.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
Date: Tue, 30 Sep 2025 11:31:11 +0800
Message-ID: <20250930033111.63465-1-lianux@lianux.local>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929172724.75108-1-sj@kernel.org>
References: <20250929172724.75108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wang lian <lianux.mm@gmail.com>

Reviewed-by: wang lian <lianux.mm@gmail.com>

> Fix warning caused from declaration under a case label. The proper way
> is to declare variable at the beginning of the function. The warning
> came from running clang using LLVM=1; and is as follows:
> --
> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>   260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>       |
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Best regards,
wang lian

