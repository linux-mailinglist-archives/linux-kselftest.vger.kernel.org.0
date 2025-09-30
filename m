Return-Path: <linux-kselftest+bounces-42624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC69BAC970
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41191925FDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF62FB989;
	Tue, 30 Sep 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKBOP4yR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C1248F57
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230009; cv=none; b=a8WTCS2jW8Ez4/pXl1MWsoqNJKTMzQU/DMJhM0ChPQfPJF77YsQXZiN6A7vANxnzdHEOCC9yMInSb3IjxpI913dhnN8umKFcNSLO7I3dh4vJlK4meMNxnNEWBTUYogM4jN5P9J3WZOXMRwPk5fTi1WMF6wgbTKzcEM/rpgYINtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230009; c=relaxed/simple;
	bh=wFnoy4QXjxAmYJyA1+5t7l0ikN0i8PEuNczTcDuAws4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rZei607N8kLC18Fx64grYgPrbuS/tQMvQetYC27SdQ1grMRdgmsejVYlyEnqy09lSVLLfW+ngI4kOtjByZNgY7nKAmgtUl8rIXKfOap/IBPv0rD5xjdI7UIm8dHDSYpfwmhWXSWNNXDZ/VAwGRRFV0tV+zBMHE//wOtFXutDL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKBOP4yR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b556284db11so5572969a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759230007; x=1759834807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BW2Qtj+KVSZo32MbcvWapFjwhM8eljdM2/EMaeJKXfU=;
        b=xKBOP4yRxXeQil4xoiFV+ATZKn67HZHAjxJfuvQGgoRXgpCMdYKCA3S3w43F/bqs31
         NYQcTDCvo43m1wkVYVNiR+VuX+kGghzsyEsFZJyL8jFvektUCnmjYluMrvzL7lEZFZ2C
         uwgtkLshxchhEWbdowqd2bh/lEuxRgumxZZCTQDOg5w8A601g9qQyVLRczBrWRGr8gUt
         Kn9/M+jJ9lkyVhAjmxm6khjaq2EerP4nvaOG/A0j1BpQYkZw1vXmL5+/tBH/+4H7v2ts
         HdLh3I977Ot2w2S3S/DoFgB3Dmacp8unEUH3rE9pZ2i5yUi5bhd6BRQljyQ5WOGTvFYJ
         8WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230007; x=1759834807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW2Qtj+KVSZo32MbcvWapFjwhM8eljdM2/EMaeJKXfU=;
        b=HKDQUalJDWdhYOHFoKmyhtcTFD/c60uBqC36BPbcSEVN9qqLBdR/07wQN/vR/3LKBB
         P4R33ohi0wZZp3E71mzGsrkyEt560KJKDaMU7+OsSdzLU6z+qk5dR/HoURE4Be+ZS7hV
         EWiqAkkFm1eibMEa+8FUhhQ3Ma7sK1bjNpv2xymy+wt97MFWOCm6FZsnXwfYDL1LL4jz
         spMhyWSQFPjE8vWN+69XuYm/Zgr4pox5Rrg/sKdS4XpPoBwqH9Fnj87GPxiFmrHBmP+M
         263yugc4j427+naDT5c6st3npj7F7Dp8OLyYL3KsFiU0guD1ToVXf5GaH4JyArr/GY/L
         oWkw==
X-Gm-Message-State: AOJu0YxL+kPzTgclZ7w0BheT1DM46qESdg+p6gTiyxzmOfJa0Gxq8Zi9
	MemBMRshm9IE+OWEnhI7y9x7gQsYwFRQMxkhgA/6F/FvOPrwb2I3qzz+pgJA64dnkZG+MhBRvQM
	ZebRu5lV5xuVengd2MehxfW+3J+Vcm5q9qhckkqlfVhZxQER6nziTPJYgfg==
X-Gm-Gg: ASbGncuGtQKLc4FwFQtZPzS27Gw14YgN0sngNv5UX0VH7QjGwLCAiZ3aWV45CaKD5Tw
	+sj521FvhxARpgs/HRgYa1OAdlChKzCyItqiW4+lmKRzNezOa+7Rd+NJujD50xshD1c0Nb7tGUz
	F3b+d43r2mGspm18kY3qVsOYjNAMcu9bON8Wt8VzrhTqJ9qKXO+nG+r8VsjgniXPOUP5g3lpa1N
	haevsUrohP1gPfHXQqj2eeeimoa3LJEMVkmr1cT+9gXEKIteXUHZS1AIRU5gbVTYL25LSwJdyZ+
	NWfJTaQiTa1AD9tGIAi0PlY1Hjk9Zw==
X-Google-Smtp-Source: AGHT+IHtPuZgSVMGlUzaI5vj/KwcQ6zTwdUWSWUwa6mgNiKsVgXu8raJbRpSbZR/+jnNv3jtSjo9LDhitaHxBXunC00=
X-Received: by 2002:a17:902:e809:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-27ed4a89ac5mr212915705ad.61.1759230006932; Tue, 30 Sep 2025
 04:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Sep 2025 16:29:54 +0530
X-Gm-Features: AS18NWA_909avJZvTE7jLbzzAOBb2Sb9YrnKfuZvYcjUAeZSImH28wlpR68IqJ4
Message-ID: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Subject: selftests: kvm: irqfd_test: KVM_IRQFD failed, rc: -1 errno: 11
 (Resource temporarily unavailable)
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvmarm@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: kvm list <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The selftests: kvm: irqfd_test consistently fails across all test platforms
since its introduction in Linux next-20250625. The failure occurs due to
a KVM_IRQFD ioctl returning errno 11 (Resource temporarily unavailable).
This has been observed from day one and is reproducible on all test runs.

Reproducibility: 100% failure on all test platforms since
next-20250625..next-20250929

Test fails on the below list
 * graviton4
 * rk3399-rock-pi-4b

## Initial Observations:
The test is attempting to register an IRQFD but fails with EAGAIN (errno 11).
This likely indicates resource exhaustion or unsupported behavior on
affected ARM-based platforms.

Could you please advise on the way forward for this test?
Should we treat this as an unsupported case on ARM platforms,
or is there a missing implementation/configuration that needs to be addressed?

## Test log
selftests: kvm: irqfd_test
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
  include/kvm_util.h:527: !ret
  pid=721 tid=721 errno=11 - Resource temporarily unavailable
     1 0x000000000040250f: kvm_irqfd at kvm_util.h:527
     2 0x000000000040222f: main at irqfd_test.c:100
     3 0x0000ffffbd43229b: ?? ??:0
     4 0x0000ffffbd43237b: ?? ??:0
addr2line:      5 0x000000000040206f: DWARF error: mangled line number
section (bad file number)
addr2line: DWARF error: mangled line number section (bad file number)
_start at ??:?
  KVM_IRQFD failed, rc: -1 errno: 11 (Resource temporarily unavailable)
not ok 4 selftests: kvm: irqfd_test exit=254

## Links
   * https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250929/testrun/30048394/suite/kselftest-kvm/test/kvm_irqfd_test/log
   * https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250929/testrun/30048394/suite/kselftest-kvm/test/kvm_irqfd_test/details/

