Return-Path: <linux-kselftest+bounces-41977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD46B8AB21
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF91BC3BB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097C321293;
	Fri, 19 Sep 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dEu51Wd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DF2773DA
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301599; cv=none; b=SvfcwocBnd4zu8lxPNYV/5dmov6myBbWyERMR0iTTi18DtnF0Hsq3eetr/5g5C2uaPk9SjBy5F7lorNw2xlLs7B8Fl1ClXr1rmA0ay2Uc/RaJWS3rAV+Yzmys1mPg09YaY+owDA9JvAlgiazLppQbTiSavoj200Nhf/Wi8JP01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301599; c=relaxed/simple;
	bh=q8hVKWTJYFegeK+gcBPDI5sNVfJB9gAyqBbqKkBR/hM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8yr9dUt8GxKxfmqgKih0lRi7d6TqjGkPDTtExKOOmJWU0uxkPenKtKduBzNdGxM77g6Aw4wr9vdQobXmFLEO15LOyokY/JSrj26XAqvcxfHnvz+hXF9QTGYN6FwQvYmpvosjxe3piaQGZcu7Lb7HjSrFqKtcwGh0Z3wkzfhlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dEu51Wd4; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432e29adcso81923639f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758301596; x=1758906396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=dEu51Wd4iY0tT1PRC8AXmYSzNp3/M8jEPAX6Osol236IDICTFPF55YSrhkTm2MQIVv
         H666IJi5qpiTdbcdBgSs082G8iK0qXKiuc0mVH98lxTsrIOcmZ/aS3E6ZrTN3P7t5tps
         LDpRxtPP9zNZrRtFc82w4IEcdc3IExPt86EAaB29DbFCErqsbQEUZh7TrPDLDWgxDBGm
         YjjZhrNm0Mu7d1SXy76GFAZUu1jAXZudorY/Q/CxX0pap1u0UEwwEIAu3Hqbqd71HlpQ
         7rSYD4MDdU3TrCEjxbipzfAIXkErFV2VF2J4MEsH9TAphUtAGHI5D1k9Z3t2UcC2b6js
         vJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301596; x=1758906396;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=I5tfQL+4tI88kVMcE69/5tnwUHJvEdL3M0ZjRX29+tJZJPaf1RX7NLJFhNYLEosH0o
         Ee2rIpIZbZUJfzTg9OW3ykebKKwdQc7v11+8ZrJxIoSjmjMRwapD3CfqPmzwHcGVX3QW
         C6mZInHuDYatI4A/2EmK7m0KT7dqvwuKNgCyCQSXAhrzAyY4GfjmUj+UuxJkD3OxdJ2z
         JSNuWFe54/+feurtp5zu/LuNS2dxZqg66Mw+/vgS3h9dmSqrCjc0bDDk5Lk62cYNK6FL
         lr033leY3DMJbofJZfYF7b3yMms6xGbNbBSt98VCYXImRv3Gspdr9hGJWMR2FqEazpuS
         f+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXbTh3DcoWoXyGUF904Y1kI2dcUuh0nSW7vuD8UfsD+7MOPCSm4NARao0nBAdxYG3tRuQp2zAQRQkw7GhJhttY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCxF5ThXkLeYVwYvnBraFeERjE+XnWJaGMYjTQ/gzWlm83ba2
	+eYmg/bMiiwG4buL2XRlT883ygcmzPoIRO5YXkeQCV7CMRaUZOJnzqsF4yetlwOOKNE=
X-Gm-Gg: ASbGnctonV+NjlbSJZ+7IyTepIPgrBogWJFEGp7zALnyMsTEOfv2Xt/vsOAcqPt9+u/
	ZBfBim3T1Z71XnjW851TyD6A/HdQ2CTEukWl3YBjRPKn9b2oAX59wDUZXiIhpy+wWocgk68neP5
	++dPq2eC1idUwX4l9QlTQX8prSiuh5QWdOH/Z21Ah5SMqONI1FoxDBz8voo3a+d2xRLJ43XYC5C
	r/55CoYSPW69pOgda+an3o7i48hw4kXsCIT6gAS473SvugGnmfMSTsNNYe7HiQC+wWFql2tbDrb
	FOZR3WYtbhvSVMggun6UaAA438rbE+7wwG2EjrSVayJJRunR4YpSnkbryFs2VFxytBQh1k13HzW
	NxggIXZiFi3AY/Q==
X-Google-Smtp-Source: AGHT+IEWozrJP43M4DVIrxcb0S2DwxZPhA4LrRW0lqAN04mhddqVBixtfK+2/UInAStgyEXg1YXAIA==
X-Received: by 2002:a05:6602:164b:b0:887:3ae9:c3d9 with SMTP id ca18e2360f4ac-8adcd809f54mr646108739f.2.1758301596382;
        Fri, 19 Sep 2025 10:06:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46a68330fsm188484939f.2.2025.09.19.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:06:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
Subject: Re: [PATCH v2 0/3] selftests: ublk: kublk: fix feature list
Message-Id: <175830159548.906981.4104343901277988094.b4-ty@kernel.dk>
Date: Fri, 19 Sep 2025 11:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 18 Sep 2025 13:34:06 -0600, Uday Shankar wrote:
> This patch simplifies kublk's implementation of the feature list
> command, fixes a bug where a feature was missing, and adds a test to
> ensure that similar bugs do not happen in the future.
> 
> 

Applied, thanks!

[1/3] selftests: ublk: kublk: simplify feat_map definition
      commit: 1f924cf781de47432f220185bb2beeb12c666aa1
[2/3] selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      commit: 742bcc1101bcaca92901fe3fe434e4b1a467b5e8
[3/3] selftests: ublk: add test to verify that feat_map is complete
      commit: a755da0dd0530e53aa026fd4d08b3097e1be6455

Best regards,
-- 
Jens Axboe




