Return-Path: <linux-kselftest+bounces-47123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D79CA8937
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6FD314C6C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D134A793;
	Fri,  5 Dec 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltgsSjVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AD33C1B4
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954757; cv=none; b=SggDDAgMcU23hbklTccLW4WHG4XtqvrKn1IqN27BAgT6FF2KNf438opVg+7QPP0AaZWhCIZPGVQOikyMzItcYQ65WRWycrJcwaflK+ma+CfyVKEW2M88miTSJPnU5ZDYFgY9P2bpi2ki68nWPOGQqaDKflox2AkfE++veBUQO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954757; c=relaxed/simple;
	bh=YtYoTmiGxnOh5dtDECL3sKhDmcIdC9O9DzDnMbMxrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn9JPvnyYcNK4/n2kGNWb4SlhY5ugzpnV2eV/C59KFJHSK6biukuRQrGAxCxGn/sVeR8bnvLGm07Ts2fSOFWjPxp2F/PGyw0csktiIXkTaUXMI7c3GsN4Vu8FuvHPnL0Z0HpWYNe4zlbY+vNkHpq1RRE5DPh/vUgmsN8ebZnppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltgsSjVp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b98983bae80so2178394a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954742; x=1765559542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=ltgsSjVp9ysDRlyKerXQDlumgJHsv8QOUwqmqbFHUJlFY9PFQQl4RxJVkc7D4TdXrP
         NgNT3zJVmv+y//SUoCdaVemBWaTX0RZnfb2NlMh9fmRr6NVT0D7zQU20jncF+jGv8ir2
         5yoM5I0A70Zcp1B7XkjOHGbfFDyvULGsFBzM8vwk07XRU+vZutb2XyQO5eFNqywQ0NlG
         MJGuhjDbjzoRbROY7l0sCYU2CAS+62wIuDKT0UHR03Dc5Lbx+jRUSiPGpSI61swp5ole
         lW7jDxxotS2fO6dj761HvoifHLNZdeWS7OwEBO7FDMMuKquEqtvCRkmOry8LQ8i3WYGc
         Hw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954742; x=1765559542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=mWjnUWL63w09+0WdmV/t6F3jb239IEOHPMnSaWHL7H+D/uR8HTMjhfJq+K+TcRNyuB
         u2gk7h4nkX+/ep/hoLH2+aks72WQVRJrf74O1oSTEkHGvEEoGDo+m58iXlPspqT3zq04
         zpPcOVEj7n9Cc+96WVkNCQmUx+L8sQyXOH0QWMvz4K73yPPNeHJ0Nj+uxs5zkqUKAlED
         O6OOFp2RoNhckqc8X7jAyvLWDdKy5Rg7htlyuG2wRYeOaLWzRdpTKjkNMgyU2TtVzZvk
         ZGFqMsICQtbhznwv4BasDdFElppUCjbKjFVcmPldDxa33LWo3AZS3glmtcZMwtcDQwSo
         5VSA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZR6P+EzmeOTuPELYvrs/Id25mTcqcreYzGPvVVIVal2dAucF+i6Db29N96a1Q6h5UQo6kkLbfsVbtj86e48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxEuzltic6crvFwW7D64PlKRLVKI0dY4Wxnu4JUjseuA3MkYL
	K3MW4egvLhetv2b7DlIWvN9KhtwWy+OYBMBNKKpbjyLar7FmRQq9e7e6
X-Gm-Gg: ASbGnctdY+VGBRPebTCqbJYHBVELaLubc5VXXTUxJBy7OCPTUECLY+ADTXl17hoFLGq
	ScIlWXhADnNZ6QtBDfyYvFMI0/7zWNZOgG7AeWqtTiAtZjlZtgZGZ+qlyETubyjs8NgBVQd1LFf
	HTvQDfu/5SBHPQfUcCNwBnC8QUapUeCo7C39wBzdgxOBh36CUNhFMa8wOjRpPXnwYTM8yf7SWic
	/4lRebT3VAuFL/3Cdo6DeanX49b5yKbMk3kqFTGSnbtgAML2PIIZIqeARmGuGpSSL1gCRl8gMnT
	OGny5iQsQrccOT9yY9gZROWOAnB8DbeehBbWqcfMTH3gZUeRciFLSNL34lJUMCzORXyjg9XBBfz
	qjofp1MYtJe52NdN3GkI4fpyzeDGKLT1FoSlnp76rjwDK24ZXzF4DxOyHtxuyuTUTrVuhkyJ/br
	IIKn0KK6KLQ7f0OngKbMJiAdU=
X-Google-Smtp-Source: AGHT+IEk22OUEE7gdeZwhTjpvbdAQz+kolwi6WKygGxoM1AqKfc3siF5IPSsP8KEFJASWzEJYAwOyg==
X-Received: by 2002:a05:693c:2d86:b0:2a4:664e:a5af with SMTP id 5a478bee46e88-2ab92e88ab7mr9468546eec.28.1764954742216;
        Fri, 05 Dec 2025 09:12:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm15102636eec.5.2025.12.05.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:21 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 09/13] selftests/seccomp: Fix build warning
Date: Fri,  5 Dec 2025 09:10:03 -0800
Message-ID: <20251205171010.515236-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix:

seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: warning: pointer type mismatch in conditional expression

by type casting the argument to get_uprobe_offset().

Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..2584f4f5c062 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+				   (void *)probed_uretprobe : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.45.2


