Return-Path: <linux-kselftest+bounces-11306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D335E8FF430
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 20:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE16D1C26AC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4161974E7;
	Thu,  6 Jun 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4NoENYt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3F2110E;
	Thu,  6 Jun 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696952; cv=none; b=gfPVrjV3ajWor4HBUzcOJhk87mK6aTZci6MJnCKzIgXoqz8Ag0k58I5NXWpUxz3nSBjHynkGyVs1hei/VjT8g6pIKemDKODfHNTbxrtk7gi21uUHVBxeDfHa6ruQ0WH/1Rj6zTTziJXmOGXXZlPzXuSosr5wQwdULH1Hevnoo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696952; c=relaxed/simple;
	bh=poZeW91FEAcK+LR8apJL9m9Ughfu2Nu4hcz5bnJpHTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W94syl6jDnp5wSpexliWu8Fwh76WqnM/d6E25hNzj/XuIgElrVJoLJLQr7IfZcFDTJ56ja1zCtV24j/PXS3THL5kSVYIlI9Fau2Bf1kMP9dasBZ2Mw+dg/3Z4MYiEXs0KO9ev4efGmm9+UkXJE9uD+a9eIArjrezGvU91zwQpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4NoENYt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35e0f4e1821so972881f8f.0;
        Thu, 06 Jun 2024 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717696949; x=1718301749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKboiQNCgjTtj2XP2zVG0LoDtn/Tdn95ZqhsAO9F9iA=;
        b=C4NoENYtV4QCAQKa+DsyM389XV7ntDaipmYxqAAUBl71JrbPetJ5Hx18QcC/fgtRWT
         V2zdloxqpM7qEM/McX6AR5n5hK3Lb6gGeXlCsWweBWSvOngLiW6Z/7Q7R0LbwuX7yQ23
         XiOJvQ3XMC8+1YbIFlTpUwd03LacMalp1/i7ZDaoxxAYae37kaKw6Fvq88LK7pFzn8Tl
         OC53oyi+Qsj+PrJWB2iDPxB/FRhrfmYmBuCs6/tLVgumBePy5bauoR6tytTc5OGIJUlr
         y8UkxZ5JMhW6Opo+EexutqbvN7+Hu0brkXRzDY9tzcyIbgKICZEo3OvcR9vU8yxojfqq
         xWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696949; x=1718301749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKboiQNCgjTtj2XP2zVG0LoDtn/Tdn95ZqhsAO9F9iA=;
        b=fCPv5pJKZerau7LDf9lbSFkG384En3YJ7Z674FJVFt6G2daCzj2nWBEIAFwPZXuEEs
         Seekn0ieq00Ygpn1PTGtoZOWsWrqtI4puxqOIW/lP/sC684JgNXl1HNFlnLTD8O9IA02
         d71vJjTmQGFnekI4+uPktRpNjU+Vub2oNPWoINOEPU349oog0iOaOmDOy+b2kzsyud7r
         N+xJNCgVbFSpv83eusgsturMh6skdRX0iMR8HnvJVpPqvSQY/+bo3379zhYluErNPMiE
         g2kvc+rAV3Nxkk8tNV1N6KuwRRBUNtu54XavRa3wQvNIDvRaOjAd2mfJT/AsLaUUp75l
         KsSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuSeZBmPGL79neIH3La3qI3WlpCb4x+m1SwNoCDcTwLOhdpInzNT8Be3KZuOUvkGxVDYiDDctq4eTb3kqE9QTjZHjl9NIxMJ5E+ioRSsl0KFjHTN64VjV7ZZKcBnIzAraJZ/Wm4Gngak6Aa9fi
X-Gm-Message-State: AOJu0YwaPbvqkQEyFP/Cc0rT67Pd0v254ryVdCavD84NJREsV4jHijOu
	QAwLhNr9hk4pyNroakilCY9YTQ6vAqHFY25we1/OmsNYunyUJTnY
X-Google-Smtp-Source: AGHT+IEyUJK0+WcN94l4qlqs/C/t+LVyad6TUE9aRji3xljA0mFNuKLLoyFJ66N1cpYON1MlB67WDA==
X-Received: by 2002:a05:6000:1faf:b0:35e:5b3f:3954 with SMTP id ffacd0b85a97d-35efed2e00cmr339702f8f.21.1717696949130;
        Thu, 06 Jun 2024 11:02:29 -0700 (PDT)
Received: from localhost.localdomain ([78.190.122.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29e57sm2177503f8f.2.2024.06.06.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:02:28 -0700 (PDT)
From: =?UTF-8?q?Okan=20T=C3=BCm=C3=BCkl=C3=BC?= <okantumukluu@gmail.com>
To: brauner@kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/10] selftests/pidfd: Fix wrong expectation
Date: Thu,  6 Jun 2024 21:02:23 +0300
Message-Id: <20240606180223.5527-1-okantumukluu@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mickaël Salaün <mic@digikod.net>

Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
which will be actually tested on the parent and child sides with a
following commit.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20240511171445.904356-8-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 6e2f2cd400ca..47746b0c6acd 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -158,7 +158,7 @@ FIXTURE_SETUP(current_nsset)
 	/* Create task that exits right away. */
 	self->child_pid_exited = create_child(&self->child_pidfd_exited,
 					      CLONE_NEWUSER | CLONE_NEWNET);
-	EXPECT_GT(self->child_pid_exited, 0);
+	EXPECT_GE(self->child_pid_exited, 0);
 
 	if (self->child_pid_exited == 0)
 		_exit(EXIT_SUCCESS);
-- 
2.39.2


