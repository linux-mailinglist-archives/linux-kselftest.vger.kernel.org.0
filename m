Return-Path: <linux-kselftest+bounces-21894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D689C622A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 21:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571A4281007
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C03219C8D;
	Tue, 12 Nov 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6Jsvxhs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908E20ADEC
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442085; cv=none; b=VbM2QUv4VRcmzYY8PJcorYZenLhzzu7ES6wV0+At+Eb13pe412CqZfbddctqSoeD7bzdxvEK3VhRfbnMPeXMohKDVL92foXx3Z0eflHtS/TYmjEkXlh8QDV+gr3yphmOGI4+PFHCrgjWHW3wwgmR6KekXt3whqEVGbr9khkEcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442085; c=relaxed/simple;
	bh=RHZ3bzWQ32ir8dvykH3nttL8q/pnHAH4dgFUQF3xSZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W5fjudWoTsyX0ZPKJtLmp0yKR9vKQsLbWgbNP3c69f2KaKkzc2tCicBT1cAKQFPvl3sB/XclQLJ9/vSdf4KCO2pAKe6iJMYqCcf/Zbffp2Of+5M+3r8AGHqHf5FLRFpkMCPmqYYBq9wmSlUwkOfJqhJ7yMfD2dBL6Ot3jgy7Q8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6Jsvxhs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so8763716276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731442083; x=1732046883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNJMf/dEdEXGOQzVC+DsIsgZe/E51V+ULiXsqRjRICw=;
        b=R6Jsvxhs4K7870mi+/AOrewXYL5We9lpDjFQYs1fUicKEGk9ReOwxhnAJxgd1BgEOS
         PNkV2JzLsJm+IbMrFbKL9XJ9VMd2g8SahE1Qec5NYM4dW/BBkVXiT/yF71twc3ldOOye
         lS6aKRrHW0JXE+d3NgS1dHQLvALI7v+2zjMz/7eWJf6biIxC6PROPEIrsteycmOTXdbc
         gb+Fx36wKGlTNpEiiYe/otl3Ra/F457Y4S0IaVd0XeW4UVIp2HhrZyUSKjYxlKWTJ9zg
         /Hzy0BBoIzNS2qv1Ol8m3W3rXeSbgfTS+WtGXOwVIPW3E/K5ygsu444yTxlRq3FmhEEV
         QmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442083; x=1732046883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNJMf/dEdEXGOQzVC+DsIsgZe/E51V+ULiXsqRjRICw=;
        b=onKfUZb3AW1eUgyB0Ln8+mea+/jEeiu6b/8PYEya+H9LkHIl6qpCn2nCud8zrbAiXf
         niakOmB+/kNMgcCiSn+A+x9T033rxwwfmx3veqXMBfanKWQ+TuNIO/rEZDVpgtQZDFdJ
         UC1IepUJ/usul8id1pOM8l2NTlcwDgzepCYGJEK0LLpkmY4E4Rnbbk7dDcSOGYjz4Y/Y
         EZodrbLfhhPOTdkvTVPWZ9Ph+nqTupJkiQgM0gYRnm+3aGjXYKwjmUVlBJnVnwAoxptM
         mqLD19TwT2SvknGI3AjzshvwLa8JwLtG8P2qDkftxGW4Y7vheV5xnShbtcROQIFUMEL/
         4A7g==
X-Forwarded-Encrypted: i=1; AJvYcCWCdhlrIRyEVpscJWV7z9XN+qy8Lw328B+eNn4yiyConwZlJuEExd+2nAkbHVKkRtQNMQ+z2ld0V5EDa5QKPqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmL50ywF3b48iTeHIHYfAyNBuNO8KN9ARvfcq7Tw/eNVBv42UM
	0THHA/RJ+V36OyQg+YYx2npeT346zSB4EqqmZ0mUHbXeJHko9B7qrto+17kwretvbDaUSt7/jw=
	=
X-Google-Smtp-Source: AGHT+IGWbxSkKKXBUo0jXvLY76zHqclSM/Sk5GYrZs492hudc1yUtPuCSAnoXDL51XUAfvEFlt5QUI6Nfw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:d3:4d64:ac12:6a5d])
 (user=rmoar job=sendgmr) by 2002:a25:ef03:0:b0:e30:be64:f7e6 with SMTP id
 3f1490d57ef6-e35ecdea920mr175276.3.1731442082279; Tue, 12 Nov 2024 12:08:02
 -0800 (PST)
Date: Tue, 12 Nov 2024 20:07:43 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112200748.791828-1-rmoar@google.com>
Subject: [PATCH 0/5] release of KTAP version 2
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	Tim.Bird@sony.com, shuah@kernel.org, brendanhiggins@google.com
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series represents the final release of KTAP version 2.

There have been having open discussions on version 2 for just over 2
years. This patch series marks the end of KTAP version 2 development
and beginning of the KTAP version 3 development.

The largest component of KTAP version 2 release is the addition of test
metadata to the specification. KTAP metadata could include any test
information that is pertinent for user interaction before or after the
running of the test. For example, the test file path or the test speed.

Example of KTAP Metadata:

 KTAP version 2
 #:ktap_test: main
 #:ktap_arch: uml
 1..1
     KTAP version 2
     #:ktap_test: suite_1
     #:ktap_subsystem: example
     #:ktap_test_file: lib/test.c
     1..2
     ok 1 test_1
     #:ktap_test: test_2
     #:ktap_speed: very_slow
     # test_2 has begun
     #:custom_is_flaky: true
     ok 2 test_2
 # suite_1 has passed
 ok 1 suite_1

The release also includes some formatting fixes and changes to update
the specification to version 2.

Frank Rowand (2):
  ktap_v2: change version to 2-rc in KTAP specification
  ktap_v2: change "version 1" to "version 2" in examples

Rae Moar (3):
  ktap_v2: add test metadata
  ktap_v2: formatting fixes to ktap spec
  ktap_v2: change version to 2 in KTAP specification

 Documentation/dev-tools/ktap.rst | 276 +++++++++++++++++++++++++++++--
 1 file changed, 260 insertions(+), 16 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.277.g8800431eea-goog


