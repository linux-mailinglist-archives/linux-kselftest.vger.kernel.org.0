Return-Path: <linux-kselftest+bounces-14732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC394631B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0955B21C06
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BEE21C194;
	Fri,  2 Aug 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpejpyeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BB21C184
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623006; cv=none; b=hqeM5jRwnoFXjZX/1V3wxBFoXDg4nYz6Zh6fzEqzqI1mAC0W0fmOCRF/5bBmC+FacZPseWRJm+Q+SeTWQfhEd+ZtZITbkaRX0dcriWdef1kZwdpgIhJHlGNPfpBR0JwZ+iOlfHprgH03+iMLxjmzUqy4nzDknECT2PAKBnPuCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623006; c=relaxed/simple;
	bh=n7duDsM65mzHev29g9uDVsLH1yQalJC6szNRoaYmK7U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DYrSs/PFdQD0p1Y7wsKrHIvRX21oiWtN6nbrKaI2IGKMNkd1CZ8NBcDidA/K4wEfoxbwwf5tVAQ0YRyHBneSbPcnEHiBZAuGMp5YGbYsSMztDT/5zwb8CaXfO98C9QDORXEtxeYYr4iDsRaerL0dyL3nNiR6pv9iL1ap/09atY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpejpyeB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso13360635276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722623004; x=1723227804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6oxP+tD4KnlUfKN411qGS5qcktJ3QWZ/pUaaNeI8BVo=;
        b=KpejpyeBK+wviR/5qH9L4p+xLoWZKho+RxsqL9ofmKwg0Ekx9qFFl/5O5tuHVa+Se/
         tRm8J6WsryFI0GFODRH91KPlrn+R0TlyJFpEG27wsmi3aW+yrZ0w3RKhRMR0sJTQkNRA
         tKhje43q+1AiOxmI/XZNhEtXdUGatcdJh0H7mmK4IOPMa+hRyCazA6coUiW4U3wz2dzy
         rJRSGQqNapbkf1NzUojOkS/BoL9UXQ2Oa/nS3v7RGQkTkqBuZOXZvaexBSIuQgJO8/6I
         BS4DlMbChsnAIXsc4JdTfEfDOSXDNy3IKpd1kCBW7w5AhPl9yMVW+KR4z4gMoygwC49k
         MkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623004; x=1723227804;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oxP+tD4KnlUfKN411qGS5qcktJ3QWZ/pUaaNeI8BVo=;
        b=kvtmv85JTrJeoc1IwNVhY4qzHbZEhIk9eWoFynO1C4dCcyrHz9/u31vfVM4F8jXp9w
         Z9QoSM9L3IDfrUbsCKH20oj5VLmFDhDdS1jok4GFUlGYOVFqL8oC58IA38qmz1wgIezX
         bl1/78bqwSEoGUukvNUAQ3wn4hChLbwsAKyzXzBalA/gIBuf5zlZw9jhfJDwBwNvAh8W
         d0kGMpVZvVzrrlqDrxM2bPiDH91E9MXtA6/J6sIjAFrqziPprdgK6JaK0JBNbew95+JS
         duZOmPk823EL9EkT/7th/URWqpJkpXueJwLNgMtn1+dTwa661WU8NoObdZzaGi31s8Hb
         TvZw==
X-Forwarded-Encrypted: i=1; AJvYcCVAQsuemgKUWJPigyVFzEXg1goF16q5LtDhTSk6ZjN644zZ7DKJWHj3rDV3lrKPfosMIHrwuYzoakecfLQj43vivlSVnwdawjX90TRAFjaX
X-Gm-Message-State: AOJu0Yz8KVQ+5aMZKYzOnL0DTKnuDWG/5WAkw98HdcVSPowCxkudchXc
	ya+CAAWu17HiAxYeB84RbX4ktJZDRnoDfBuGhHu4tNKubu5qXzVCajgvSE0IeLem+S4vSDmFZC3
	cIRVC2aWNLXuoJN0Wad8W4w==
X-Google-Smtp-Source: AGHT+IHhJZUMUJlOwDgUo6lqW8JjwdwUbeftwTJqmLMxmcUdMbOBXHUOM9McHNpi1/8vR8rYt9dKZJnJJNnE2h3m5w==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1241:b0:e03:3cfa:1aa7 with
 SMTP id 3f1490d57ef6-e0bde1e9203mr5468276.1.1722623004394; Fri, 02 Aug 2024
 11:23:24 -0700 (PDT)
Date: Fri,  2 Aug 2024 18:22:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802182240.1916675-1-coltonlewis@google.com>
Subject: [PATCH 0/7] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend pmu_counters_test to AMD CPUs.

As the AMD PMU is quite different from Intel with different events and
feature sets, this series introduces a new code path to test it,
specifically focusing on the core counters including the
PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
counters exist, but are not as important and can be deferred to a
later series.

The first patch is a bug fix that could be submitted separately.

The series has been tested on both Intel and AMD machines, but I have
not found an AMD machine old enough to lack PerfCtrExtCore. I have
made efforts that no part of the code has any dependency on its
presence.

I am aware of similar work in this direction done by Jinrong Liang
[1]. He told me he is not working on it currently and I am not
intruding by making my own submission.

[1] https://lore.kernel.org/kvm/20231121115457.76269-1-cloudliang@tencent.com/

Colton Lewis (6):
  KVM: x86: selftests: Fix typos in macro variable use
  KVM: x86: selftests: Define AMD PMU CPUID leaves
  KVM: x86: selftests: Set up AMD VM in pmu_counters_test
  KVM: x86: selftests: Test read/write core counters
  KVM: x86: selftests: Test core events
  KVM: x86: selftests: Test PerfMonV2

 .../selftests/kvm/include/x86_64/processor.h  |   7 +
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 267 ++++++++++++++++--
 2 files changed, 249 insertions(+), 25 deletions(-)

--
2.46.0.rc2.264.g509ed76dc8-goog

