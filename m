Return-Path: <linux-kselftest+bounces-3182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BCF831187
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 03:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358DC1F237B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C672610A;
	Thu, 18 Jan 2024 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PHPfExvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FD53A8
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546307; cv=none; b=WYPnOlqFJ1HamY0Gq4FNoUMwR579S48q1soy2PE0HTfSp1fJ2I2UYuylGIDUwxBrj8ft3jzm1ifkPMtg0IeuQDpYvtjABsv8qz6oZ3hSC5jvq78Hd+AOrV+eeslcVJNKB/z0OsO0dGoJ4cSY8SzDpjYuQNxfZ5BpDkbC+GxZMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546307; c=relaxed/simple;
	bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=Cypm/i6me+jNaFwy7X/D5x0/hARUipW8sSk92h6PwIefoQGmNtSZrxd7XV1zTv+dzSSpnA3rOHqgRdF7TjlspiGUDnhWeM6gagyTFTumgEqytJDCCmvN1xKywsyA2P1ZbbKBqeG3xqbub2NUhM7Op+wxHZk44BV18yPsdPfBM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PHPfExvq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337c5eb1bddso884992f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546303; x=1706151103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=PHPfExvqFP9dNkw/o1LSkVNxh6G6osL4+UztZaPS6M0NUeISe5flKcZVRQz+UKZbVW
         oARqCfAPr6CwtY7/naIvTKlrEGSe8pfSmeWSIEE40dcrWIQbuERvvrGEBd1jlGLA+XBA
         0iEMeDvqlD9WrkZtuA5HFhzlH+OyYaXe+sBgWo0aNsrdHQTjjfUJkJpgaPJxvcuViza3
         U4d122bRIWi8OtteFp87ekFHFOkw2nCY5vDX2LAiDrHT/Jeg03xaLA5S4Zh4SZ+hOsOL
         EWB1sxcXlXH1cGAIGs2DeOW9Aa8a8sTZaWoN5S89l9kmZ7NUYqgz5ZxXrAFT3gun6z0G
         qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546303; x=1706151103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=OApBSdSq35UNjQTYXplyioLA8EdDqnbtmOtGZaZPCGI1jWF08VKJ6SR3VjEDxD29p5
         Xz/tltNOFTiG++IMZoWQGGZH7/ehNcw8Qg6/ysGBySXLiLF9QKJRv1GGr2wh72sFOGVS
         S/RSx45/C1cZSeilwDeOKrAGTc1dawy2gLv7K8A3g5GdpSzY9p9TkFD3rt6scvoC9sLR
         Qkostr+2v/ELw9AIFV8OpZJUmz3U5A4Oa6YPWzw3JIfcCyUNAqw0Mtn4zgOkcM266NlI
         PwakdrriZd7yoPWKrQUFRjX4wjYlAgZXV2/+Azgs1pkMYFYhkBAQS+dbov4YBi+8Z8l7
         rjDQ==
X-Gm-Message-State: AOJu0Yz96u5WCwzBvzBwA/t+eXSQA84RCSuSNdaBLd3FUnDCdHPq4rDy
	wg4PuDhtHBEL8us+EGv9rGu5d0GVzgr44/JOh0ttYsYiNsnUYviKxU4w1iT+Ew==
X-Google-Smtp-Source: AGHT+IGuu+Qi2Tx2cCYMGpPYN+O0khIiJHE3lWN6J6IrC2aFuK1G0SyFIM92LO01t3+UwG9sk29NlA==
X-Received: by 2002:a5d:400b:0:b0:333:44e2:16b7 with SMTP id n11-20020a5d400b000000b0033344e216b7mr79098wrp.49.1705546303326;
        Wed, 17 Jan 2024 18:51:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:42 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] selftests/net: A couple of typos fixes in key-management test
Date: Thu, 18 Jan 2024 02:51:33 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=736; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=; b=E1xkCdz0M9XB7LOyp1foBBxJnUvlo7QXSIQqLpKlLQB377ZXUXuwOvQUCG4cuseiQQNIU4E6N RodDkay3j8aAB5yco4ZxHozCAOJCI4dCrc0vyqgUf83CsOC7UR+yKr3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Two typo fixes, noticed by Mohammad's review.
And a fix for an issue that got uncovered.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Clean-up double assignment

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

 .../testing/selftests/net/tcp_ao/key-management.c  | 46 ++++++++++++----------
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  1 -
 2 files changed, 26 insertions(+), 21 deletions(-)
---
base-commit: 296455ade1fdcf5f8f8c033201633b60946c589a
change-id: 20240118-tcp-ao-test-key-mgmt-bb51a5fe15a2

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


