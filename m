Return-Path: <linux-kselftest+bounces-13618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55892EFC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7922811D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5017D35F;
	Thu, 11 Jul 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhr8/eB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA417C211
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726660; cv=none; b=BfFNnPc+FKXuxmCUmZEeDdtdw5Q+NmRRAztBZmIlxRDBk1HBnT+PlrtXPzi0Obx22CmDHby/LFzX37JDnNKQZ/MBNbN24+rA6yTF5AMsVUaXWefq01motYpG2CdXJBBJNqhV1JbadWZOS/F+oiQbT3ofY0GhzFUq9HwaZAPSrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726660; c=relaxed/simple;
	bh=IT6Quss8qGzn5EGUoOLEBspCO6vRpnOKFMFcjESA974=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UcwhiKO1QPcu2n8uA86alNyWTfaZ3Utu2UKIG6ZfkVWUCcodn6h5z1+bLCWI/nCE3Fai6psPUtHeWvZ0eUlklySUiUwGXZFy9xgfeQUoNF/Y4UjerRhDykrVqWFR+LbqGQQjyfP+veclW1+5vHOPVoJxZVGQGYtvZRIHQ59GirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhr8/eB8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6590a57788aso19747897b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726658; x=1721331458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=STOOzVEt+vbX1CvvmSVwRNox61LAyACU/ArHQQ0k6yQ=;
        b=vhr8/eB8zHfWPsp0qoXKvgL9x9bNBQvrTlVoOXQLRkXuI2W5HvQ1bqU2dlFyNzTjeB
         1Y972nWhJoZ+szJgDtp1R31vIJZc4ZEk/D3lWyLIEIAAmTL2ltBQTSgwYTPsFa3gJqqz
         +h/mItF3E4CZdZm+SXWfIIy4ApPm6PxJc1tCkYgDCFzSylD2B2M8O9ozuSo+UCkvznxQ
         1GRWxtlLxG7r5e5ZIVsYhzmJz42y5whbYtGF8UPRQJ5kNHwzZDHgbReVBlPzPXyO1r3m
         cpgcm8naHGVFM/Zt33sulJcBPnUQsT53AeFiB6Ac276xPWB7aa6H2AXfZ8vE7cTVJIpi
         YBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726658; x=1721331458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STOOzVEt+vbX1CvvmSVwRNox61LAyACU/ArHQQ0k6yQ=;
        b=lfWU9Pe92U1iqF/nmdy7YAroKhBhxHMBdNn5zFWy2rMiwxkMaB6Nj5M7Dp+VUgSDUK
         6Ud/LhpprtXd/u7e7Hr2CWdsCx3bY+ju5HVvpi6sYxYhz77x0RHALBTe4YrCe0CX0iyF
         /+hluxP+TQhcSeVNPC845ex0nu0DcjEoLbsCMfXjNBBourlRSHRSPUQ3eyiImZ3cLpVK
         OM2L+HyLTjSL5GAH5rxZ/y/7lKhTSFRmW9ugUyDrUPRfTMZlJlD1okUeHNrJWYgK6x4s
         +wWgvkQQEn9QXrXhub18ugJUnCYxxKi493Z6tVFe97hmy/TQQ2FI8N+YXFdOFSqJIiWP
         cTCg==
X-Gm-Message-State: AOJu0Yx3mskrsobKqhnahWTIcTYep8+uBv5DprW2T9C+IWFcT/KcpE3r
	ug52xjYlG5Rh+zgR4r74RZnsrj1OMeWej/fnm7juE8oUzYZE6+ueGloqoTp6sE13Al2mO029qtO
	e5NXjBbQXEJ42cukHpw==
X-Google-Smtp-Source: AGHT+IFO1LV5PwXv1wT/w3Qyf/9BTMINc7q1X7z8bt0HbJrgdwlCnB1nmPP2jDJViXtB7+SXZ5FteJt4IIeR+dMF
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:690c:380e:b0:62d:a29:537e with SMTP
 id 00721157ae682-658ef53b41dmr2192867b3.4.1720726658069; Thu, 11 Jul 2024
 12:37:38 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:37:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193729.108720-1-ericchancf@google.com>
Subject: [PATCH v2 0/3] kunit: Improve the readability and functionality of macro
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series let kunit macro more neat and clear.
Fix comment and rename the macro.
Also introduce new type of assertion marco for functionality.
This is a follow-up to [0](v1).

v1 -> v2: [PATCH 2/3] changed KUNIT_ASSERT to KUNIT_FAIL_AND_ABORT 
[0] https://lore.kernel.org/lkml/20240710170448.1399967-1-ericchancf@google.com/

Eric Chan (3):
  kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
  kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_FAIL_AND_ABORT for
    readability
  kunit: Introduce KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros

 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 71 ++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

-- 
2.45.2.993.g49e7a77208-goog

