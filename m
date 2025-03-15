Return-Path: <linux-kselftest+bounces-29117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3EA6233B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E4516A141
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90FBE4A;
	Sat, 15 Mar 2025 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4m6hc4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2A33DB
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Mar 2025 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999095; cv=none; b=CG7IUnKAeY+KF9hp6+lak8IxHlZQwHHCFClD8vbF4Cm7lsHKfXs7mbDLuJZEMUzq0iNmI0sRXxiYuNM2b8kGEE51RFywg1cvP9dHkEjwsurzm2w9Xgf2fxAokbPTEQ1Cl8OFDtR6lvTFq+5jmYjpMlBKjrDnxudVYhX4WJk+Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999095; c=relaxed/simple;
	bh=guS8gknpoH4PksJnmNCcceh9PcsABAUXeCAP1Y1dYrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBX0uP4lyZY53XH3Bn8lYOVgaDla6p71BT6miTpAGdByndalbcAyC8VkkJXMKjJ/hGGLsWk0t7IV1khr07wamgwSk06efQw0vWuij2j/wjVGqb/nivSHCcV8V38hx3wnjDx4HraK98kYOj6+V2izsgumXlc1SMqU6XAwnrlQCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4m6hc4P; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22410053005so68908025ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741999093; x=1742603893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+SLHPHHuV/xC8U6E0Epjjy44PLNtmXVc5Z1rd6ky98=;
        b=E4m6hc4PxV7dpbaYPMnvS1kSg0tMn8UQbeIB5ZD/+5R2Jr07mnY/lWH5Sn1vKPdMWy
         RKsPy1aIRocItgsBmGyP1seiLJdo1J1Mj2kbHvx0FU94qJ1DawRETVHrM7y5gGL1fu5r
         sAi7jm5s/unusaNRrtXkbya2ROpfCrL+3OEWTY4XEPNkDj8DZrWA+OG9qeqZOkrzqi7I
         RE63OO89anxvnGMGUeoY7rg1YNxx4VcoYfyfrNf/78rLdVO2CqAdo6laLgBf7LBejMYA
         jsJ859QOfJmAH5p+0pODkCN/N4pzDi+M5L9gqAH/mKeCNuGNxFxpGP81zMSBqHCWXUHh
         j74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741999093; x=1742603893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+SLHPHHuV/xC8U6E0Epjjy44PLNtmXVc5Z1rd6ky98=;
        b=BGJtwaT165OYejROCEUPZNVWAbq7vErTQGjw6xyYIz3d2wN4AP1+DYXMSIwRIEysWA
         dW2nEdE5SLeLHqd2YxyoHaMlkfKt/NWZt4LHIcN7O6A+2U6shsHSvCxtkSuOSzhcO5uH
         WqfJl3OoZVSKFke2EcAHPJwTE/+aXQqw0UEzjs6AnQw2X3TyO7eOKvPJzprBIEPxPexo
         5tjbz0nERRWUekYuLK483R2sS3G9wUvcirRKW40+dFB86qs3Z9fd7oqhtm6kiJuC+58A
         RACdy3IDNtl3EG7Fh2S1lD7BFLMKJ2e3B3+Wv/iw2h8lFzbXfiand0RTpYaJ7naD/wvz
         qzOw==
X-Forwarded-Encrypted: i=1; AJvYcCXR5HUvywhJOFIOtsl/Jk03jWXb7aOuuZmUOyvE0EWLp9pq+RZfI1mG1LsE6UPZ4bPzM4+x/oXOQceMMQnN4IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNb1WlBatiWnAd2v1kNMfT9JxT1WHMFcb5BdUeQuew7xJSHNX5
	yad5hFPDb2nOCcPLEZUeZuHuTT1RAa/8ola6ft5tjKkIA8xqcuJCJxnZ4c6DHNPVWpTdcmnSz5X
	3fNxu
X-Google-Smtp-Source: AGHT+IFpO17RX8u3hT0s2/8+ktJrwgIlsab+Tmhy/Dox5brpO1uBFHo0Ng3JB72ldjyQI+OCpzQ5MwiZwTQ4
X-Received: from pjh13.prod.google.com ([2002:a17:90b:3f8d:b0:2ea:5be5:da6])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2308:b0:224:192a:9154
 with SMTP id d9443c01a7336-225e0a6e305mr49593805ad.26.1741999093351; Fri, 14
 Mar 2025 17:38:13 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:37:42 -0700
In-Reply-To: <20250315003800.3054684-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315003800.3054684-2-jstultz@google.com>
Subject: [RFC PATCH 2/2] selftests/timers: Improve skew_consistency by testing
 with other clockids
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Lei Chen reported a bug with CLOCK_MONOTONIC_COARSE having
inconsistencies when NTP is adjusting the clock frequency.

This has gone seemingly undetected for ~15 years, illustrating a
clear gap in our testing.

The skew_consistency test is intended to catch this sort of
problem, but was focused on only evaluating CLOCK_MONOTONIC, and
thus missed the problem on CLOCK_MONOTONIC_COARSE.

So adjust the test to run with all clockids for 60 seconds each
instead of 10 minutes with just CLOCK_MONOTONIC.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kernel-team@android.com
Cc: Lei Chen <lei.chen@smartx.com>
Reported-by: Lei Chen <lei.chen@smartx.com>
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/timers/skew_consistency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 83450145fe657..46c391d7f45dc 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -47,7 +47,7 @@ int main(int argc, char **argv)
 
 	pid = fork();
 	if (!pid)
-		return system("./inconsistency-check -c 1 -t 600");
+		return system("./inconsistency-check -t 60");
 
 	ppm = 500;
 	ret = 0;
-- 
2.49.0.rc1.451.g8f38331e32-goog


