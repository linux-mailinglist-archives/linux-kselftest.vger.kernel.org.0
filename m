Return-Path: <linux-kselftest+bounces-30017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D5A78F7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8371B1892428
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E7623A984;
	Wed,  2 Apr 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JVwcPq7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1445239592
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599569; cv=none; b=eiKP4YGLqGLYvwzcBUOafp8Fn1n35vNapmRGTDVklA87cOVu2dCQKvzps5vEyKx2cR4FrV/EcgCkLJH5fLGywVO8YPMhFp8pwhMKZRMOVjPVR9qBXFB2EdI7r/7bpx67XadO7MOdo7/fxLN/5yGARlg1vqKq4D3MoZwuIcWKCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599569; c=relaxed/simple;
	bh=tOcpGZ8f5Tb47JNS5BNoknblBrTyos3un4K9kSh6yAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jfjm6CzO3nMLKTlWbRG0Px+pDLaVjLwRvX5gt87qLsa4eJERk6axFtBsd16Tc5UE7lZiB7CnnqKvS/UH5ZYe0JQTKkyb8x2rwuOnJwjuvaH+Lpp3cDSotDgn7iPZ9jlGbJQGoEXCizm4MAQGLepEnNDzdA5BzmFCFkTwKZcD5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JVwcPq7A; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d59c8f0979so2735395ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743599566; x=1744204366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BQoS285p3ACMznO/yhKhIxe+5v4IUlbAZzIu1YF/lI=;
        b=JVwcPq7A1wYLI6HanfRZBwxUCnBFUCgL0DDsnUb3R/6kPoICi5KThFMKUWWuXNe20d
         dvie86+AaCAFFwgbWtkm07CLw+wvm0pbpQIBlcbXpDQGncvC9WESUz85Plyj44w3w+yM
         wSpnMR2N0aQ19mXj8oeKAbdALSn8insFOIWv9nQU6DmXsmhDpgexcBnX/EHB7ziFviUQ
         /9bE8i3UBc6yg2EiP0+XtGXEs24qTx0YAnowkoJml6ZYSwArI/lQM7+yTKI78ctPQ+lQ
         A2hUxXMvt20o9JpSbTmmsrs/8QxTf6z1L8ANJ1hYsNpE6RybIKMkJObwC3Sz1EuIwPA4
         X6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599566; x=1744204366;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BQoS285p3ACMznO/yhKhIxe+5v4IUlbAZzIu1YF/lI=;
        b=aF/RXKMqB9UHFo/H1ar4Q+qBTzDqmFRAlZIg0W5k11RoWqQsOXKXsPMgR/7LYUdD6E
         X5qDj2v3a31bGcnNvypfW/InAwQSEKJ3COAMzLgZbRBnUFgkuYGJjjSYSUSBepj7H+wI
         c4QaTwllzDgTI/T3c7jCAbnhkZNhkn51WvckmG63ChtLil6s+p90zgyPl1Bwqn1bD3vE
         UpsLFSW58viMuDkLfx+TXeAAe4Wpf0bAT/LqVBbK63W6dWFXhI6Jybco2wdrbHd+2grb
         XL2EoM2jbK/3IdQJmN3MAxj+tlS4P0LhdYjIs/9t+4js3xXg53EPwqop8XPN0PdpIWjD
         VEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUj4kNhVM5QaJ1ZKqowby2lGPz9cB24EdqNlXyzGhJ27GQ2gTUNGcgXSoDPDVPjmg3HcCu5F9v8lWN8E9URi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwE5z5q85JgVqeI+x5LbYsraNVdVfUc7j/FBD7wXpO/cbJMkgU
	8yvrnX9IHjWn74oXfra7C5+K8BrtyNiKeTAaSLQozCTUnr0NyECDSM7zaBOsWXQMGrDRwuY8r7k
	C
X-Gm-Gg: ASbGncvSyl3juXYLe2vqRUv3Y4j4VNf1yb56L7RqAcxpkxRbB5LgmsFc4duncXse2rh
	H9nDbKnkWQ87GcMzkWRguVW7GCA60jatloPoiP+FhBxEbKf6OVqHEHTBhFTttzk317ZVFqsY3tV
	c5CqhGhKBZeDgjO7Wh85OoaX50OeWAOqHrSkZySYaDSsasnNRA7xB44OMexB6KScwJdFR8g0CFJ
	QDY+6LiFF7xbol4RCPcJaucV9jFk3ZfFBfLTED3X7XQH7V/bBJTVYNi+9QjyYHLSL6yDNZSou9Q
	hlcAUI/w9wSM6QEbKoHOqP+mw1Pih8yh3mw=
X-Google-Smtp-Source: AGHT+IGYEtc0rVmUripwItyyW0bmRlCGHyKYzRGoLqwNlAxm5qK9125/20/ajFem/q54Yg0ZLMrZLw==
X-Received: by 2002:a05:6e02:2783:b0:3d3:fa69:6755 with SMTP id e9e14a558f8ab-3d6d6d17acbmr14537565ab.5.1743599566623;
        Wed, 02 Apr 2025 06:12:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6ca4bsm32985265ab.22.2025.04.02.06.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:12:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
Subject: Re: [PATCH 0/2] ublk: fixes for selftests
Message-Id: <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>
Date: Wed, 02 Apr 2025 07:12:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 01 Apr 2025 14:49:07 -0600, Uday Shankar wrote:
> Fix a couple of issues I saw when developing selftests for ublk. These
> patches are split out from the following series:
> 
> https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t
> 
> 

Applied, thanks!

[1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
      (no commit info)
[2/2] selftests: ublk: kublk: fix an error log line
      (no commit info)

Best regards,
-- 
Jens Axboe




