Return-Path: <linux-kselftest+bounces-13484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC292D716
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 19:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084FE1F2337E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2072194C6C;
	Wed, 10 Jul 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4JQkaJI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56067194AF7
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631112; cv=none; b=iB/bk8f9Cdcpt+rPEAcr96zSLXB85hzxIrjh/tGzkupsJaZg9pE/g3svPcIyyVAhAgsrlMtWf3aUOdtqCLJo6hcGcK97/V0hpcSEq2CMfAJuGyntGnFxJfaWgPu8i5Pf48HbjnPTBDxNVm8ZIl+GEkyprc5iwdti78Zg2HGz+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631112; c=relaxed/simple;
	bh=IfcJkSc/LNwp9LlB29Us6vaIZxKEnh2p+SCln+tmuyI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DeT795pRUfMPm90G7MzVDmZRm22sQRrZP85hf+Ix2p1MCg+Ox2rwQXzieQySJF+d/4J+scrMnAHI7vtAwwyNm5sgdOPx/yWPzpDe0OEPRErhhuhy9xN1UWHtrOCyfe7akbJezEfeDxwqz5wC1exLBAyMCjYq9fwcvV+nk9DOszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4JQkaJI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-652c6e92147so109387247b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631110; x=1721235910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cY/lfgDlHnS08Kow/zkoxri6JCWNBRfckkCZV0YNXKM=;
        b=f4JQkaJI1QFykHYnMu4RSuWXFH0ZKrwRm5cqvM84MzIIvDU/y95O2KwyCddGpuZdi7
         V61JUuMRXYgvfuXaQu+TNbfmW6XleovcKo95xlRVEbo/LGVW/NqTCcE+FeVfsVCTryeG
         H+BYIwgXOI+uDL8rYt6y79gDdVo/lOJPEb4cTda0DMtndZ91Zk+muUGD4hlgKABrdACE
         jCRavVfTmjzkJk6xuaPvEr0jdpPalI6e3bb4LWXutHdiee2XXmBtBO1+cznKo8Z4y+gE
         +yh9jDa1nnHJ1cBhc6R6oAj+ewNwGhYHqkbE9VDn+RLkqraJauKzo3v2VjKzgoIXrVSM
         fnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631110; x=1721235910;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cY/lfgDlHnS08Kow/zkoxri6JCWNBRfckkCZV0YNXKM=;
        b=C/WVgftDkh52EvVtouN2A6nkVdr8jQbLxfBVtSmFSycPA/Bz3mjiT9/FA96h/axRy8
         /JLkVOFmCBmaITbLWEpury2s/NjN8ttzCsB22kq6X9KQJE9HMP9U3OZiCScFIoZeTVK1
         gl3vIWKFyV7GRx2/ErVUFC8Wf4xympBKTEi9cqwwf1Shws3T/9Hx9+oAejDnGups589a
         N1NUmguJJACu4FYCWI/CN8X3xO1FHwCYJvAiHK2O9Y9gmvADgtPnJIY5h6IOVFrEm+zS
         E93RseM+eM0xyGw02CIub1hcJUbo0SFK4tMEdsLYCYJwFqKy2xf3uXkfZghemomG9CI/
         lCKQ==
X-Gm-Message-State: AOJu0YwxWqyK6C384lPXhFueCO1GyFwiFAoY4LFDutT7cj8cwY16SZJ/
	rF4t5kzot4rY0LTzmXQJgY545En0cMNo5EXNeFrC9LmjOK/dadG1XM2cQWxZOrEOGnyFpLqpafL
	pPhxAmBLWDl/T6LlRng==
X-Google-Smtp-Source: AGHT+IGj8HtzaJx1AJHVLeKKYwrMAwK8N6nm3v4IK7iTRBO5uLo7bkOz+HhmrwwwdqMrcdtrCJ2Toe+er6l63gMY
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3c8c:e806 with
 SMTP id 3f1490d57ef6-e041b07159cmr15222276.7.1720631110325; Wed, 10 Jul 2024
 10:05:10 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:04:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710170448.1399967-1-ericchancf@google.com>
Subject: [PATCH 0/3] kunit: Improve the readability and functionality of macro.
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series let kunit macro more neat and clear.
Fix comment and rename the macro.
Also introduce new type of assertion marco for functionality.

Eric Chan (3):
  kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
  kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_ASSERT for readability
  kunit: Introduce KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros

 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 71 ++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

