Return-Path: <linux-kselftest+bounces-40993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2043B49B85
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7444A16833F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038820C004;
	Mon,  8 Sep 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POW/2AD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D210FB;
	Mon,  8 Sep 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365684; cv=none; b=n5EgBkiZF0y2K0G3vx5Y+yOTzbSNIWkjaQcSS+eJVrvdUWJRDr0TVhMqeXzFwbnCI/Riv1ycXTN+G/wI27Ffzg+35k78aZtt6zy0VV4VYAAIlJ52TzLY3PQE+sZLZXemLrCJS7i5Ed7msJ6useORmXii5J6FMjzGtkYOCyNdPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365684; c=relaxed/simple;
	bh=7x3M6OzxcXR2xOr1b5H9lv4C1AJvoLHd62rq0tUNUtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzQCo2GyXoayBgEiVpn2Tr5LDnTxdFL0Tx3p9Vy32onYisLWhNciygdYjGvBkL7nkswnwKoTbhL6T41+Nf+dVmWGslOKU3CpgXEEyBpuzCafFGWFoQ5JY7wkWgKBh0utCaI4A6hNZLcXTAMhtBruV6eUH53DBaxDfRQ5lqnCKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POW/2AD8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso2515135e9.3;
        Mon, 08 Sep 2025 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757365680; x=1757970480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4leMcgV/Vy8OWc/rM83qJwvkBLtx9OG8BWRrknnRgs=;
        b=POW/2AD8tWwSwWHzLC4DAksINjFe8xj5JuDoQRsY6XKopNgjzy/4BRu4XxV47sBigU
         ElI3cJ37TRG84ZkJ2qY/1pFAj6C9lYYXtqoAuK9bvQg84W0GAaSGkMzsKiSamIYK6vbK
         nvACzCpuqzr4IATwRfWJCFtXU5j/j+oPAlG3FJ7niyoV6jwnaDpqlcG1RLz6MAG5O1tL
         HBFRyWNElbVk6xDJvymJita33SS3EPevPzVGYhifhIgQegtMXSqyhJAFoboNn3Vk28m7
         BgKWfk2n4Xyu4CZKMTpPE5HaxGgNAYEimqovYi86/RoS8l7H9IiN6wDodH49pd+kzWHd
         w5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365680; x=1757970480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4leMcgV/Vy8OWc/rM83qJwvkBLtx9OG8BWRrknnRgs=;
        b=h/drUUoVQoNub6afjVtO52uC7xugoYB3CPfdvIO21CmGyt2AW7q7BCW2t7a+q1PKZi
         YFPSCdv25KaGGanxxPlrmK47RA6INT4hxVQ/hGMlf2iqgdfM8KGYDzjWJnS5fpmk8guJ
         Mr9arOVHIV2D2A6cHV2RNnuDtgP7VaS1tmnpAkmlQZYlqywF0r5Bhy07cz7gSDhzA9or
         wTFmULKXplmznUtLjqcgv8RyYXwZ/r7deOaYkdh6eIaJ71sdpAaQpT7rcIgVXubk8M9q
         slyIOs49iWxA16a48WsA0UeUbrLvsLi+LWCCamsS+pmfO/Fv5dlNG7HAaTzfIgm/keOB
         0Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCVYrZr7zy3/10CUNlQ1JFeDBX5NIMOpoki6+K+NUbv8P4sG1Z1XOe6vWyFvhTibRfhtgvQ=@vger.kernel.org, AJvYcCW7RnaAeb5GzHx83LoDTDpdAsa850Bc5h0Rpo+tKzQwLvqRVpIcrLGtLZrOGhx9i3b9fAgK4w+JcRvVuUxn4019@vger.kernel.org, AJvYcCW8GSKMbOHyy6nLW2IxFSMert1vXfqVx8Dte9xOoiHpBaBzjvrbbOiXpSEYJvyngX4r3IJ3tHJMnW47Lvyp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hw1wB6ukh5UhK9E0ThtszerUjazwZilCb76d1LLh5hoLrV6j
	8vrDxQotgTv0ru199mFw+zcxNb8Znu0laHGLtp1K+3PQVUuS5jPbXX6m
X-Gm-Gg: ASbGnct9lLsXI1a8HgxOAf3D38a/x8TSpqw9//eG66C9TO+OOxcJx6GfHXmYUOBwsim
	U9d0hGkUq3EmSgzD7fIEuTVwIXFQnzcVLkJeqzhnAtKR6dKnzoCyIDuFvGG7dXkbS0GufHPlqEj
	F1QJeMR/NgpKyURyz5p1KGDJEwDbTthebNAXbHBc0o1KFQ8t+AGtH8Px06EF0Dx4c/lA7HJFFm3
	f/owe1XFDZieg4a+gQ8exhTeJhgVamT0q09cHf1UuksFTZUu2nLcbAs5zYk1y2IEu0+38m8cHBM
	30pO2XzTQiBfp2cc7D8MLKLabpXHDzFC3fjK3VB/BPzVrbAru/IinPKYKc3paVPetnKbz0d7aIG
	XhzsQJ3lzI/CecRI=
X-Google-Smtp-Source: AGHT+IEZnnAHqHVfPKeJA9IdmNibK3eBQPXtsg1GVMTDzXHQwM4c/a/SYqcXoCqH7jonCYzxYsChJg==
X-Received: by 2002:a05:600c:3503:b0:45c:b627:3b05 with SMTP id 5b1f17b1804b1-45de0060bb1mr88806405e9.5.1757365679876;
        Mon, 08 Sep 2025 14:07:59 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de2132cd3sm92749285e9.9.2025.09.08.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:07:59 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] selftests/kvm: remove stale TODO in xapic_state_test
Date: Mon,  8 Sep 2025 23:05:46 +0200
Message-ID: <20250908210547.12748-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO about using the number of vCPUs instead of vcpu.id + 1
was already addressed by commit 376bc1b458c9 ("KVM: selftests: Don't
assume vcpu->id is '0' in xAPIC state test"). The comment is now
stale and can be removed.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/kvm/x86/xapic_state_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index fdebff1165c7..3b4814c55722 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -120,8 +120,8 @@ static void test_icr(struct xapic_vcpu *x)
 		__test_icr(x, icr | i);
 
 	/*
-	 * Send all flavors of IPIs to non-existent vCPUs.  TODO: use number of
-	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
+	 * Send all flavors of IPIs to non-existent vCPUs. Arbitrarily use
+	 * vector 0xff.
 	 */
 	icr = APIC_INT_ASSERT | 0xff;
 	for (i = 0; i < 0xff; i++) {
-- 
2.43.0


