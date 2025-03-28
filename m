Return-Path: <linux-kselftest+bounces-29892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756DA750FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC19D7A73BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4C1E6DCF;
	Fri, 28 Mar 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CjUcN1RR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E831E3780
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190994; cv=none; b=uqzjJ/zCwFdEC/Yv9Fut2ZBFuW0S3wLf0KRhlz2SoJI/auCHSUigiuBFKwB1fL2n26GedJaZhIokIC8IkRLJw8aThbjZe0TjkQJmvSgMhl6B64zDokffKqyTbZ+AKFVXKYDKWHp1dB37X1AJCR5Vi1RkAxPWBctJyIep6CydIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190994; c=relaxed/simple;
	bh=OLxAmO7yW2b8KKMedc+3ZdU1b31cGrrllojaBB9EdZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sx51Qs7RYyJnbqXHHzfb8ZXST4takZ076PhDgNcrueZ9Uq8Ta4N5UcSiEsPGvF8mmEZfG41PRi1lppooRPQs/6ZHXsnaiaStes3thulWsYZbfe8lnPL00myMCZrlJxkelNrc38nv2haYpMDVDm9kHhmM4bufDOd5DhhkbAQz8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CjUcN1RR; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6ed0d921c6aso3431856d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743190990; x=1743795790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODvPSfxlecP14OuA5OKuO2EdeJD2/HHQgbxBXvFdj/Q=;
        b=CjUcN1RRgmd+h+DNqzoT+AT4x2H0VyxybgSxUTZmtuIJt/T5OKfyfLb+EeTJEuL6ER
         K3UFIT5X582QF19jXN2+I5Eh7Jazrzpn6+Um0BCy+NEyQtvApDXsZ+Odawppg0Ds+tHe
         9rFDJvFsdp0hAoM8JQMkFIXopy54/05JIP1eSNh2vxZq0EsHo/wvVLWiyeVF5yRKL/ng
         SRIqaR9cFLQuV1MZKf77XrfO7gGEG6BZmJR1VWuvIBjce3E5OtW1zgdBVfEsdPDpnou5
         l0ngFK1b+2jrcJkKsIt/fMemEQccCIKGsMCQwraSEv5rRiv+OmqZ4ngcWhhC7eODDEtc
         8E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190990; x=1743795790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODvPSfxlecP14OuA5OKuO2EdeJD2/HHQgbxBXvFdj/Q=;
        b=c5fcpfJJsHmHZeDnd/bmg9ksyZBlJJ/dwN0Gun0JH3M9zeS6O+UV5wlw9ef/DBgLTY
         uyJGFDrn3UYOm2B+dt6zoeFvisczGM6Z8h+0M6xHZZLagjLehLT0Mt48Tp2SOx0kX6ct
         8YMNwYorhY2Q64KlUIYy4vutfhl5BsTHoJFuuRGi5jeh2Dtjs5tiX1oZd98UmvqQR8l6
         r1KWFBy84QqrXhPsdj2tL64fOsbU+FQnemgD1IzWGC5RDxvKwErjmBOX/TCwQnCZGthS
         qq9YSU3Gtn0piQ0ijr39AqP2RxbZ+E/YhQ0RDkbsV22st4DEcLxX1J46t9r7x+QGjk5x
         JGzg==
X-Forwarded-Encrypted: i=1; AJvYcCXDFYI5lm0qF+ZXsX8zyfcp8Hzi9v4wyxPhvNTceCNw2bWWTD/AOlpUQfpakiWNzYAldsClAvBwtJme0a0/u34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aV02goRbwI05O+3Nz3F/Vng7pDBtYnO2OPhz70ZJQxTDnIr9
	cPYPPfU/at247fCRSrJTjRQyr+z8o2ecNwmLD34W+BvA74tyGrGlLrvuGTV4XoO35bHjkKTIBT/
	mDI80QbuC8Y6Xj/H6iOMwfVCV/tobVyGUJ+d/x2euduKNgiDF
X-Gm-Gg: ASbGncv07gbjjFxX+byTUjZNM/UbbPOBS8xgsG0ls6If/YaC/7wsrDYdUk8pZ53ndzh
	X8iJRmdx5+UuFrWisuMsMHgReyoexc4tSwE94ec+1ahs6Kmj35mrqNYcD1cN28kiI6aglDDmrcg
	Yg4rfbYHUqyRrCET3WgXfmxKW41VKtDtjvxJ81oOArTA5XH01lm3NQvXpnfCu93o+QKwm/Ro7n/
	j6cPsJOYiKS4rIdISO9yd84EG8qkUrJdYK7E7R0hClS/djUfkDaYX2HonUxBvYYguiND6u54zjK
	g7Ch/dhIs5+H9KwqwHzHdl/UKCXbZ1uEQg==
X-Google-Smtp-Source: AGHT+IHE1BDqSoPFQBosK4FIZagJvkov+uoLlZNqBQtT2+qBsIa0Cb6b1jpVWKVmQ243c8hGamaf9x1PNGPX
X-Received: by 2002:ad4:5bae:0:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6eed620e64dmr1735846d6.8.1743190990230;
        Fri, 28 Mar 2025 12:43:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eec97b6bddsm2788096d6.70.2025.03.28.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:43:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2B899340325;
	Fri, 28 Mar 2025 13:43:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1D2D2E40AF7; Fri, 28 Mar 2025 13:42:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
Date: Fri, 28 Mar 2025 13:42:28 -0600
Message-ID: <20250328194230.2726862-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
char *. Indexing the array requires an explicit multiplication and cast.
The compiler also can't check the pointer types.

Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
indexed directly and the compiler can type-check the code.

Make the same change to the ublk selftests.

Caleb Sander Mateos (2):
  ublk: specify io_cmd_buf pointer type
  selftests: ublk: specify io_cmd_buf pointer type

 drivers/block/ublk_drv.c             | 8 ++++----
 tools/testing/selftests/ublk/kublk.c | 2 +-
 tools/testing/selftests/ublk/kublk.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.45.2


