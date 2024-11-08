Return-Path: <linux-kselftest+bounces-21667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96C9C1B13
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60746283260
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C41E4101;
	Fri,  8 Nov 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THjr+TiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184091E32C3
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062981; cv=none; b=erA+kGOl8BRBeudqWThwxocP4m5YRXH4spUmSybF5iR7DUH4dJGhydfdRyG4bxKM0YLSnNkAIDwqKRsklDXPssnjLYDwMY2UidMireSnBvPM00bTdplj1DMkdfnwatMd55k1fXzPbtC8tSI9npe2pZFJ0zTUSI5MJ5lz27a9cSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062981; c=relaxed/simple;
	bh=zLmhsiQtPD1Y5MFv3rZcEySYkDoAeoBkGNVnq4zjeFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nWD2+CArJjbh8jZahzunggQC9qgdiyOYf2XVJFAPPFGlnIxY8GhKWK0hAcVy8eyn0VATEPLaXBDPE4Bq8phbbbLbxS8RF5xhBULrQPkAoDb2jju/dWsdds1RI5Cn5Nr+bBMd9E48hyoy+TkyOVa/QBDklEqjPQGkQqG2yPhXquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THjr+TiP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so152135ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2024 02:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731062979; x=1731667779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLmhsiQtPD1Y5MFv3rZcEySYkDoAeoBkGNVnq4zjeFo=;
        b=THjr+TiP2tVCRqsIjIITHudODSjHf2ylph/jocH7yNAEgQMXgc795u3QH9bNUg1U+e
         RETBMAmz2G2Xw3STiNNo1FIKBzfJS72AM1iE2hX5bxpytaXT16t2EMkLeQcgqUsvK6vW
         lMYw4aptA9IEyuuH7mrvrOfCfEb9cbUlsCSzDMgm9ciL6zPsKOvhTtWiuyy/PwR/++N/
         eKDDAcgITbjEoHY0B5b12krmuqiCUt9zrbFUovFqb+YA+N5De68h5NRc0vbBxPp65beA
         h0UWqakUz13OWSZleVCnt1q31BjFOFutSoc+M/2gXgDshTwza5pvBw/pAk1o10ET4/5B
         b4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062979; x=1731667779;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLmhsiQtPD1Y5MFv3rZcEySYkDoAeoBkGNVnq4zjeFo=;
        b=hbjNNNL295FQfOYPyzFkF82vDcqXqBHBnOtrmSXlDPVZVs6NU3SwrlFBrt9Mt6NHc9
         7QLx71Le9qDxXQYFyFrRmkSGS3VCxu6SB2g1NfKQ3bEAZlMZNn/0PJYMmn1HEZ7Wa93Y
         UT/LOtCVCeRpOOx+bQtUjlRrxyfzFEtm+0uuON1mk65dys84iXkLRUMTBUhTOYN4M+M6
         6inGGuK4sCXxrTseojf9a+BXOM8fxr3PZ1fs1JTXUOkYl+KiHtGjAmcG8YHWkXtOWgmZ
         qZA5cF7COA5YAizM7r6ycpNt808dYGGCFt1dieR4qFGvQoNlfQIm7wFdz+WRVLoQNzzb
         o4dw==
X-Forwarded-Encrypted: i=1; AJvYcCU7slZSAzNpZCs5CyUEQaUn7DUdeo9xBEcq0nmbuk7nRzxE82v257oiZcXrdRnCFIWD4Ua0t4YSOV+SjJB7Jrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlnFY6NytNjZFXRikw+cVHcCYRm6PuTPgp3jE7ogfLV1cUWCB
	9Buk33tzfDxsrsvsF2ZFfYycf6wsob4z97FaTz3bKgz+xeKN7KJuUSk0jX7556WKytmv4FW+2hX
	ojzwOeiRmTZJWk/XH+ckAsjIOgKAomslJ/zKm
X-Gm-Gg: ASbGncuWUMxz+un3HXWD9q/rnSkDxkEDpVu5Lgm0+E4rjFktTiPhA0qNDIFwrfrZdpB
	ARtXikkzziVYcgjJp4U3KUVDRrJi3hfYPvtpGcUbqrqmp1Fz1bChDeKGD5defkw==
X-Google-Smtp-Source: AGHT+IFx+OWLgFqYtmDOmn/uqVcIUKptH9zmcyKnFHbrAhfSumGLLuJB1tfoqwP0zJ0MRIeJMhhnwuaCGhakaSl53yc=
X-Received: by 2002:a05:6e02:1c06:b0:3a0:a34e:9ab1 with SMTP id
 e9e14a558f8ab-3a6e7a2da81mr9313265ab.8.1731062978627; Fri, 08 Nov 2024
 02:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 8 Nov 2024 11:49:27 +0100
Message-ID: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
Subject: "stty sane" in kunit.py
To: Daniel Latypov <dlatypov@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

Does anyone know what the 'stty sane' invocation in kunit.py is about?

The other day I ran into an issue when running it via watchexec[1]. At
the time I believed that it was there to clean up after the firmware
that QEMU runs potentially messed up the terminal.

However, I just realised I'm not sure if that makes sense - stty is
about setting terminal settings via ioctl. I don't think QEMU or its
guests are messing up the terminal with ioctls, they're just writing
funny control characters.

What's going on here? I guess one of:

1. Terminal is messed up with ctrl chars but ioctls are the
easiest/only way to reliably clean it up.

2. Nobody thought about this unimportant detail so hard before and
there's no particular rationale in place here.

3. I made bad assumptions about why the `stty sane` is there.

If it's 1 or 2 I wonder if there's an alternative way to clean up
without getting the SIGTTOU issue.

Or, maybe it doesn't matter and the fact that this was ever a problem
is just a bug in watchexec (maybe you can tell I haven't actually
taken the time to research the SIGTTOU thing properly). But thought
I'd raise it in case this points to issues people might have using
kunit.py in CI.

[1] https://github.com/watchexec/watchexec/issues/874
[2] https://gist.github.com/bjackman/27fd9980d87c5556c20e67a6ed891500

