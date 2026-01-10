Return-Path: <linux-kselftest+bounces-48666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D89D0D618
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52DFF3009257
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C933987E;
	Sat, 10 Jan 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ4+E6i6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F4336EE3
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768049075; cv=none; b=QDOGodsTMRp2ynYQiUPZRaeq3W1SCrHa7ZKVVnoI0PXCRDTMTpoW8KvWAOGEpPe8AwLaVKuR1sREY/0Qn3QZwBDZ1kvlRktv0N9t4dPHXyAi9A86vuOTW5O72wCfvWbAUC7cByUpwE/mMnny5Xyg0dKBgSFDsyZbJ9xMBbhsUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768049075; c=relaxed/simple;
	bh=2ATWW/HLpqiweEYqLT8vRIgSliGVg19nOlBrikeJ7z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o16U8tr0lAPgIcAcFaGU/dNHtmHvi85/gjen2FfOZFRjuJI2dUeqB4DXvd/lNMi0x1cON/GYoP4bjwZvsZOYp+cFG8nq9wpw/6/50+eWlHymGJkLz8XhgU+ae4PnGCVflpkQ/tQqFsLymNUKiucJwMBmyr16GdEjcDDLBmHzZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ4+E6i6; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-646d9eb45afso4762023d50.2
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 04:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768049073; x=1768653873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ATWW/HLpqiweEYqLT8vRIgSliGVg19nOlBrikeJ7z0=;
        b=QQ4+E6i6Y+o71bzBjhlPvFaFTXkZEyrN6ktCXQvfQ860dj1ylMxCnQVuIdEobCXr7A
         TbJIkOilNWXkLdqpNIveYARVvyOa9W1EvIFV0Tm6nR+ty3vOs3h9nykqMjXzkSXhoyo1
         0+PO4gfm98DeO5Oc11yAjbLehD5QR58Q9FP5gOyP4fOYK4q51Hb8kwmYIq6RX1b+nOS3
         r+mPTcpmgdjZPy71j+9+VMt9k1gdSA8lVRclNvb09bwBjzhwAhhoDMEglpn70ddy3jw+
         ozM8h8F1ZsPk9xkc7yf/Yj1Zm1ThRX16yjAXvfzbh0ume5AfZLYaDKWn8jcJVxyXv/MJ
         XEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768049073; x=1768653873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ATWW/HLpqiweEYqLT8vRIgSliGVg19nOlBrikeJ7z0=;
        b=Z0uBZuStzeo9aILsjNO7sd4+w4QBv6M3DxEEKRVzKZCCYFqio1Np+UboMBNlTlyyNG
         ZDiPm8jqY81DNdq9XhivT9alYYroqJ4B/nzfdeH+8hWOHB32MCO9MwgkpBpba1o9xAP1
         Nq+jRsfi4RYY43UobdPLLdMotkNDL5BfbJPL6Fs0Mqu77GbyksQEFj5otZliGyZnUu1o
         kQInJircnwVNBw0Fon/6XS6QZFdnJwTfQGB6K2vUs6XLD+HWVvFb0jmV6PEypHLPyG9O
         hJqC7xm0Nj645x5TKzvXBfuuCDN9x5LslIoHUHBWi7nnQxQWWb6AxuPonzz2uAPupr+e
         sfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFaFuSrq0fLd/jy3Kl75lvBs5cExY7elROzXaRceHbrKMg8z5wVeUvfjveqt8CtkitJEWalSb2FIn3SyS8Ldc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQPxTkPzHu5Miy/URTGXcZGY6LurwO4Hf8Do6bZ8+XfEOBtuR
	9d6DOFMtStXsJtqvGnpD9Bfn+yyvUVhVd3qJ981MgJheX+EuBE5XQ3qiVxWPq+p7a6XTlJxHuc4
	+gNPxx4wbtxY0MZWF53lQv1jfNN3+Gnk=
X-Gm-Gg: AY/fxX7NuPCqyFGgsnwHzt04sMJJjeMVvdN1UaL2bdWJHdoiAGOBtsqPVPuLgSBNu1f
	z6nG5NHiBo/U3kKGsluKwFAnV3CkoCnfMDXsDDo0bIcN0gdhquI44PQndDoj4MAKYS8bJT1y4NC
	2fpJYdX2zKneTu6Pk5V/+VeXmXmJA+n7+h7R6KyrkEt6o7hrubBXvJUQZon9RFODGp3w+0OJDCN
	8k34tHjmC5N0CGCZlNdTBD2WLOgZ+IhBKRH4gzg4FKCc/ok8rtAn2c51e+3EZ2povngf/33bNDp
	4xDC7KhkCFEWHufDtg==
X-Google-Smtp-Source: AGHT+IETWZK9RqMS2ankKQKCP3Af4KiZf5Idfm5YJ7cXURSnpzjquubk+1eqrAE4PCAe3MrG+/FDqO0zSaKKeGFnFKI=
X-Received: by 2002:a05:690e:4105:b0:63f:bf9d:e530 with SMTP id
 956f58d0204a3-64716b8d87dmr10902720d50.29.1768049072933; Sat, 10 Jan 2026
 04:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109094313.52307-1-sun.jian.kdev@gmail.com> <20260110011641.81278-1-sj@kernel.org>
In-Reply-To: <20260110011641.81278-1-sj@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sat, 10 Jan 2026 20:44:21 +0800
X-Gm-Features: AZwV_Qgm0OSyVdhuNlptboXVPT1IdCA995oh-89jCEg0X7pwTwvX7mSblK0Y2FU
Message-ID: <CABFUUZE50X=PXAK0nFC1qhj4GhZ1FQJ2T2Jf8M0APE6s5-mgvA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: ksm_tests: skip when not run as root
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 9:16=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
> What about using ksft_exit_skip() instead, like compaction_test.c does?
ksm_tests is a legacy selftest binary and doesn't use kselftest harness/TAP
APIs. It only includes kselftest.h for the KSFT_* exit codes.

This patch is a minimal prerequisite fix. Returning KSFT_SKIP already
provides the correct semantic to the runner, without pulling ksm_tests into=
 the
harness model, which would be a larger refactor.

Regards,
Sun Jian

