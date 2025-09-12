Return-Path: <linux-kselftest+bounces-41416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC2B5571C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71105567FAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1D283FFC;
	Fri, 12 Sep 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Ul7iC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82C2777F1
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706833; cv=none; b=pvhsz/uTAVm2bER2sI4FtO65sJGN8KjOxSzKvRGnOneIHp7zcLipkMZQhvQw6Np1JIOSLfx79A+xEx+XSx3c9vV9rKk9Vt2RWmO47Q3Rw8rf92Oy5bVgTYLW0xwZRlRwSsZFYjBgsBef5s0Qt/o944/bMrZMNEww1UqN3dDtao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706833; c=relaxed/simple;
	bh=fCUTGtNGsGZ5r8jfbbLtppKMsWLoWvtOButsYG55zPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbmGPJT4gE2mFzAJVCFJ0Vq2QLHewFafZZ0qAz//3s9vwOPsqgqXQI6nlmgM8/+OLX4mlJ0X7Z3QQCP4LP9wmlIrNPWtqbuuWgQerJnU7mPG0Rba0Q7yAhbzhCitGYn4nbR4l6BVNQQ2hg3KwtGhVQTTAZc6NgSsP5yL6yKXiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Ul7iC5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45df09c7128so19170615e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706830; x=1758311630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im9Lq21+8J5Mf+5Q2uEKKjoiHcxVE9gd6Lc8gRvhOVI=;
        b=b0Ul7iC5cmeUD9YWfGGZMaMMp9dX9sudglDagj4vH5odmnPhHpNkaN1EcBjFKpufv1
         qj9JezF/sWIU26+/pITBMK+mZpQRWpQ512u7Km0gV0xWvHrwGRHydzYp+GL1vh3rCzn9
         kR4lrIaVP3N7rv8Qz/SnPTV/qu5HbdOtu//Y8wU56A8f9Kb3JbbX4i0Fc5RJJHMbJM7l
         dYw4VcpALWDt91paTZijXjcffn9tIuJbXxO1gEUHVvya8BIHKrnepwB4dkFr6A9pJng4
         89DlwVHweCiIO/w4jT9FguOyHnCemkuHVW7hMKt8HlOquUhqeuUartXixzFPsQDdqRIN
         uzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706830; x=1758311630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im9Lq21+8J5Mf+5Q2uEKKjoiHcxVE9gd6Lc8gRvhOVI=;
        b=wQTKgogCotUPwOuIcrtQp/QnMPGCaGXDdCnruXO+lylErfRFP5+ARfNlDqfvfn0Pst
         D25QrYaLKpBRdSyh96m5UW0j8F2/wc7gcfEzVSsdOaqxI22fFGr2r29S7T2heWHJ9QGz
         puPM0Mez0Pea4AdFDPGvyt/3xIHNmnEuxXmqPB2kdyEK9NQUDDl5XDFVx0xGMF96zNEy
         gEOiMMB/rILUAVGtmkr/WmDrsOJgSDZUNaHlYPj1+QESl55cjCRIcW0GR6uxeCr/1OEp
         9hGB34g/6///oeDOi4Torez1Pk94BhHYT0N5eIZww3n5BlsOX0NHgz3Fp+g4QIbL7BiY
         GJgg==
X-Forwarded-Encrypted: i=1; AJvYcCUOXdIBT14/qUAilJ9VDDzMiTipv8c562JN9j1rrqfGKuCDicYSZk8e997HR2c763KZohdMvpGagICNvY6fUVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcpmohQn2Xrmrsg8uHD/u3AyeD/025x2oLV/Q03RLRIAtJTxN
	MsSlaOCxA2Vajj9C7yDr//aD7SkEoAbgYKQBDnanC+D/JZjvi4uWxMLt
X-Gm-Gg: ASbGncsAIwZmFOOPbSH3FI5URUn5zxuEoUSL3uaz7pokIUULzqdcmK3eAB7sHoEHw07
	4vVGt4f0e6ebRQ5i6fUvVoaJEhrSApUrf/zLyOKagNL/GneUdaYz0QITYjKBkHrmpZIfkAadY47
	uBGb7axd6/Nx3TtwjVWTIQm4msSlQhsa0rRuo+F+hVFm1EkMV9xFTkSXCRNYx1V5RKwcukkMUvo
	2eN6ZXRYaH9pIvTuehWRtUPK+aLRKGH0uYkYJNuKcP2wwDYJ1ZSWyZmgnQkdwVinF8qJPuy0As9
	mrfoc2RmBWIxyA6mcRXw4tUuaXz0Cft6oJHIpzAUxrv6OJ6jp8henchOGfo4dTGHQO18eUXUueB
	rxBErlZllEq57xccpyzO9n4OLrY5mp9j5oAvuppR4G8Vjrasy5wsgVJk/u+I5qQ==
X-Google-Smtp-Source: AGHT+IG9aZcd6e5qxsZVmaWzgC1SbVThJULp4P95JK54XvdW/IaMNxg/kygFEwGzo4IyxjxCygpjwA==
X-Received: by 2002:a05:600c:898:b0:45f:21e6:3ef7 with SMTP id 5b1f17b1804b1-45f21e6403bmr28589515e9.17.1757706829510;
        Fri, 12 Sep 2025 12:53:49 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:49 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux v6.1
Date: Fri, 12 Sep 2025 22:53:23 +0300
Message-Id: <20250912195339.20635-1-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds comprehensive testing infrastructure for Netlink
and Generic Netlink

The implementation includes both kernel module and userspace tests to
verify correct Generic Netlink and Netlink behaviors under
various conditions.

Yana Bashlykova (15):
  genetlink: add sysfs test module for Generic Netlink
  genetlink: add TEST_GENL family for netlink testing
  genetlink: add PARALLEL_GENL test family
  genetlink: add test case for duplicate genl family registration
  genetlink: add test case for family with invalid ops
  genetlink: add netlink notifier support
  genetlink: add THIRD_GENL family
  genetlink: verify unregister fails for non-registered family
  genetlink: add LARGE_GENL stress test family
  selftests: net: genetlink: add packet capture test infrastructure
  selftests: net: genetlink: add /proc/net/netlink test
  selftests: net: genetlink: add Generic Netlink controller tests
  selftests: net: genetlink: add large family ID resolution test
  selftests: net: genetlink: add Netlink and Generic Netlink test suite
  selftests: net: genetlink: fix expectation for large family resolution

 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    2 +
 drivers/net/genetlink/Kconfig                 |    8 +
 drivers/net/genetlink/Makefile                |    3 +
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 1921 ++++++
 tools/testing/selftests/net/Makefile          |    6 +
 tools/testing/selftests/net/genetlink.c       | 5152 +++++++++++++++++
 7 files changed, 7094 insertions(+)
 create mode 100644 drivers/net/genetlink/Kconfig
 create mode 100644 drivers/net/genetlink/Makefile
 create mode 100644 drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
 create mode 100644 tools/testing/selftests/net/genetlink.c

-- 
2.34.1


