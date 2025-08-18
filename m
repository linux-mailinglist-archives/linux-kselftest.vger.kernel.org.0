Return-Path: <linux-kselftest+bounces-39226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3753B2A0F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9217690A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DF31B104;
	Mon, 18 Aug 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+HJdGPg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5731AF01;
	Mon, 18 Aug 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518247; cv=none; b=RARycyDD5vOQQdJrt4g6eH/oB2kp8XDQ/nMMlrS/PqvEydH94HnZb2R/u8Mw5x/YzmIc9HcIMe6Bia1QYQ8CDnjMSxKFZOl5f2+41gHHL7U36qSWcY4eGX6wLSDbIDVWfiorLGI4AOOo4ysxXwZYPZeoU4iiPcHEYDQTxFRMIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518247; c=relaxed/simple;
	bh=5jHJQJsG6PPM3ZiBXsIJKj/EWtSsObcH1vyAtrn3Gp0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gk5TbgE12ABGQytCqovGPJ/XN4X3McqM8Dqzkc/8yBR5Mfn1dBHGnjfPeiWJHMRaSPK6PkkSWu9WOoHkFcAbLiNoIitZl6+NACdTQUbvP8E6DbWJSDUkuZxQ9stkiNEu2+jte0Yw4sKUouM1Y9tpX4KR8U+jfefpowHR59XJEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+HJdGPg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-619998ac786so3479189a12.1;
        Mon, 18 Aug 2025 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518244; x=1756123044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T9iwgo+i86PCVtZqT4kE8ztMHAtNDZ0Rddp49IBLH84=;
        b=f+HJdGPgRbKldTMPeTjftBOP3HmzOW74UzvJmLWEc4W8UJIKXl03EnINm38aaaw71x
         lS60D5DqB0eDNCZkeyebrzppmdd4XtJ7gPUyro+N8+isab6VHj6WFJZr35DpVjYnSVOG
         VIv3Vz7nowZMzazAdTedOYKqn8+3FPpfwNB3mLNxJVAWyvZZ5IFfEdFOGZjqCFDWNSL7
         JSA/+iNTpFYQCUT2M5NUywHRWyYqhyNcl0aPVkxD+KOGEJqNN+6jKNLuL+XFBzfPy0uo
         JpZm8fsbi7KsVoy4VyOixUcvTezFSczJFNMf0P7GMnTj33kQr3G3gb9e6+iIXfdqgWkX
         CQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518244; x=1756123044;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9iwgo+i86PCVtZqT4kE8ztMHAtNDZ0Rddp49IBLH84=;
        b=miFni+xezqrAqWVrOCasPfYIgTypqnnRSF5QlGgf/e/5HEZVbchOTYmvKo+CsBaH6N
         BI2rqEGY368QskAzYYryZP50nNga/Lj8Apb+xp10KT3CeHdvPp+4ooKoT+3nKr7KL870
         jvpl4o8iSPmwEHpPoKAl1Nfuc7nX7K1Fm70a0YOqglOO1Lfgb+Z9eeT/Cu76CpekjV5Q
         Pac9fXMgzMUjVaLUg46WE/OIwTeegDE1hStzLP5o/gyT+UmM9Z/5Mk1k7iKkVhc6k5l9
         O4f/tYNBVoro3C0GotBZ21kNpjqC7fpUFixHIdREv4SdPRUmJbFuYVpLykbLPyFPsn35
         6qkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8KqvnnOeH6bHNj1y41rPfdUS3kTX3fLJaTES17EOYnk1OisurK9I5CX3V3E7Mnf04Sy8hRLRQxFOlYM=@vger.kernel.org, AJvYcCW6xwOERPCLkVU2CARwAKjxx+iGl2+hhTmHqWjgO7AL9lFG+xs+Y9lD23Tj/mgnqiqTrDEmK56/6gI6q4nS7FE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Q/u6IzehXJfnp9d6wPy2+MJDBc7oMD3c4dK+XG8962SmzXuI
	OqZdrn8G0hw1Z4AhLlj/wpPhqZ6mvydqXlkfUmVN/viOJbCPNgtYRDgPmTN+NzIvHHExEppuqRP
	KUjGwBBcjmj0idLTnrREihqDw4GM+QNY=
X-Gm-Gg: ASbGnctsilJeI3RaARFsdO9M63EWSZbOJ0lnDktbK7i8BPdBhmBVLsM7QFhpPWzeCn9
	Q6QC0v+y9qmR+8n4fedgKVwmVmxzGtG4cFgR3EluVqGgnZrbHSkshS4DHbRAYy8JCT3ZLBWOzKQ
	VvXzZ9zsBLiuETUIxsLrHZBO6QC24hHVIZfvxaTcSUICRdJ553ZnFact10+w2cNHPC1LPYm1yoy
	LXf3NAN5Etap88Lukcnn3hz3T5HATdtSC5vO1OH+fBoqBy4iRYD
X-Google-Smtp-Source: AGHT+IFvbQqzH5lN1+Kyg8vBAAzNpFlPf+v42KwiTM2r7r0zwVNLhha2/ttn8fx/3Vm1MJpAvzri1Jbk11XIhxsyTGA=
X-Received: by 2002:a05:6402:2787:b0:617:cd9d:e267 with SMTP id
 4fb4d7f45d1cf-618b052fc3cmr9823214a12.8.1755518243828; Mon, 18 Aug 2025
 04:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Mon, 18 Aug 2025 17:27:12 +0530
X-Gm-Features: Ac12FXwO-bmhfVkEZc4PmVuaYWtBqlneHweG5Fs7DVLHZVjfG4lU6PawU1ViqWI
Message-ID: <CAJE-K+DWK7MCha0bp3D4AeCh57gbR3EUDy3JO5C6b6xFeM7=mA@mail.gmail.com>
Subject: [PATCH] sud_test.c: Spelling correction 'usigned' changed to 'unsigned'
To: shuah@kernel.org
Cc: dvyukov@google.com, tglx@linutronix.de, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 2eb2c06303f2..6b846f5c1fa6 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -140,7 +140,7 @@ TEST(bad_prctl_param)
        prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 1, -1L,
&sel, EINVAL);

        /*
-        * Allowed range overflows usigned long
+        * Allowed range overflows unsigned long
         */
        prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, -1L,
0x1, &sel, EINVAL);

--
2.39.5

