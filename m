Return-Path: <linux-kselftest+bounces-47116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C9CA8952
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23DC30386B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6077347BB8;
	Fri,  5 Dec 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx3s/rzO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A61917FB
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954745; cv=none; b=B1eNBkhFxWqWavsgJGRTLZ5VmOPX6XvzkZT7qSsMbXaSMcK6UvPZP37HoRTkMJGgm+I5FMe+/xLNDjaHZEV7j0yudKezzS+vBZTsE1mzLWcy33kPIfLnkG7/lIVsElvkSclQMNF2bTPvU/SGlxOcajXlbVDT87+VjBpu3PaQkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954745; c=relaxed/simple;
	bh=pgJ6ff8paldt7V+cFG947O9X9Ylktw6h4GCVRLqVB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p88XtOO971ovGgtnBTqNRdYvUxGJtfjOhP4ITta61kgnRiAUhSgCDfFcEAevEepgakqmYaV4WtUSqi4sN1WCnGJn9Pik/39LHTVxcm16HgE+027ftpPmPMpwLmGP++iWWyrDp+Bv83nqahOqIIQhK0odvffN/s1mV4PlgMBCtRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx3s/rzO; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4118768c88.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954735; x=1765559535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=Qx3s/rzOxetlefVCd/9b0e6fuf9Fxcyhf4+Un+8WtZbK3GehiKSpqlVaskjOGKoh24
         wHwCCa6SGkX88GU3x0ydtAcq8CyMECYfCUPwW6TJVZQp2tsSAHGaUCnICmM+qOXmfpk1
         uwN7IcFLC5587uRO6q79Qm6CF184uWBz7SzZKFwi4KAIrlnwbLeLAzW2GzlPIHxPmoVL
         Mcaz0CBx+iYDUDGdZd1bM+9DtOSWYzSayQdbswTFCtI86ifHelQnBh6SHPeb35b9cT6K
         MZfYEZakBTlHh0P68RNSk1209SP631YXS2Ik2jeaaY9tNuErPKzvd6THNdLe0eZRf7gB
         RvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954735; x=1765559535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=clrgrKrs5WfPJriSPG/sASXn6CIar5n27Q05xf3uWM3TC2ZLO7GN8P0LicuGqZoVNM
         bH49+fRoFRckWkGlH6CgOkWHpR1hjzEPqid5I1/I0pKO9o1zWQ5bqo/le5H42VMtcSNx
         1R0uXEqPVwBOHlYShtnbYHuqWtQ9ajMLZVIKo+Op2DmsICqJEbNLa0eqJ5TQTKAWFprr
         57fkCThdSpeh/fVxwN0vBK3MJD36z+2ucZjhcyGSsiUM2dUE9yGMN+yNucAjtlD/BT16
         UJO9UAXb1VmW4UF9WOMMj8Vjsky66ou4OsTkSla+FBtlJvTxEn+CTWeWjFJ52LzeqeoY
         ZAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXlGopJpIXvzkRTNWNYS1itBDFQwVOCEkYUVL4Rs34c2HjlzKYHMbxFab/cKhT+Net58SdidL7F1Sz03ak5zdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkR+EEqP2LHjTpoHRb71pVxcxFclso1nn785fh2U8laU5nypMq
	0CiEGMozz+3kE2otgfWSd5TBAtZ0xgnUcZmD7YlDnVwytCn+05mV/lbv
X-Gm-Gg: ASbGnctTW+mkx5AFC8ZoBduN8w9G4j3wiVVyuAQSFQlLiG93nfKjrlaRJ2uE7jrnOAD
	Ei9GHV10S33Kefr7gd+DeWBpvuXzZyeSa8ralwxW/sNEoPpkDtf0xtdtpXnNLLA7NY0ewibFnoB
	dyiJUUf34ogj+JMv36heHWl6iKwVAYCGx+6C3rXMKW1oASToJDFwbM1nOfUFRrWLFuFlvvnOfiX
	l+8nlGYcb6wWP2/wHr9B8V3OQF1yx8OSs6TthnSelQUTlsZwdHOmLGrYTqj9hXndrJnzt/2LlsF
	CqGPYxYM9LyJDBe2nzzyX3fgDetR4FanuIupw4AU4rdOeFfe2A03jMUJgJQ065pxIMGHEOd+KIo
	OGjhH+1i33vJwFe++qXnOn33NlJK/WjcWn1QPPy2LOtLpNLC+gZZoihzoCkAfsa76Nmx5VEiPZQ
	7CPaLTcHoKCm8VsDuatQ7KAOk=
X-Google-Smtp-Source: AGHT+IFCC9u36dpszL8LHl6yuqSwEshH6IcGGz8u5zeSSUuddfN+n2v1mO2/tmCjMeVOnHnvUljNXg==
X-Received: by 2002:a05:7022:249a:b0:11b:ca88:c4f1 with SMTP id a92af1059eb24-11df600e305mr6401788c88.20.1764954734841;
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20698013c88.9.2025.12.05.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 04/13] selftests/filesystems: file_stressor: Fix build warning
Date: Fri,  5 Dec 2025 09:09:58 -0800
Message-ID: <20251205171010.515236-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

file_stressor.c:112:9: warning: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/filesystems/file_stressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..4f314270298d 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -109,8 +109,6 @@ FIXTURE_TEARDOWN(file_stressor)
 TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 {
 	for (int i = 0; i < self->nr_procs; i++) {
-		pid_t pid_self;
-
 		self->pids_openers[i] = fork();
 		ASSERT_GE(self->pids_openers[i], 0);
 
-- 
2.45.2


