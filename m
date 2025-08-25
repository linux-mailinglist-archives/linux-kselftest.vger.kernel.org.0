Return-Path: <linux-kselftest+bounces-39834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE4B344BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0075F1619CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABC82FB977;
	Mon, 25 Aug 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wq8T7vpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A292F9C39
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133852; cv=none; b=o3zjKETJcc/w2yaSJHsXob1zWuOEz9vVKsYy4iZjKx2pc9z9vNqb+XGrVxdTasC9aWZll+rqghYJhu+JkxR4jrV8yf247JbNApYyg4rMRQNhOwveYtcKWatZnSzX9Y3TE8kzGTe1/KTys0VaM9T0Cih9H5SFFdWAZ/ualAEW3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133852; c=relaxed/simple;
	bh=JH2YsonV3EAZH0DTcNFaxzu8DrMdoOtLh5Y0M8Z1pxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IV7JtBSFq5erEOdxfdLnTtA4qizdBUSdad2Fh8OktatnkL7jnKwbyNw2dXfdEEuKHek8wf8Lyh61LzbV0FPkJbpXsG5iApmFJWBZO9hv07Fl5f9eQupURM0sKYyso54FNOTcUEYCATY7lLhF6OeVb4ooZgjVP9c9ePeguI8cP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wq8T7vpv; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1288546b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133850; x=1756738650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdEVZ5TCp58sTeVk+nfvlA0Ah5Y1WxCmV7eSgrEVDls=;
        b=Wq8T7vpvbumuM+QXjaLEY1TP2qh2kJHJu3YqtFom+RFIwnK1M+P1LX20aJaax9nl3x
         6B0Uk0TbkLM7St7EiWUyaI837MyvGYPaQ7zIVmcNK1g8U/4IyQaAOo7gOZfDKDPdnJDU
         j0b1vItsmLEGso7AlIoMsheOXhaZN/+rccp2Fr6Gc6CA+wW2T7pF8+u1+VrNwteZ8GLw
         f/6uTpcrTqVRYBmI9Af0D4bZB+yjlpsNiUykTDoGtuhMA/BYM8q+0ZlTnVkIR61ejjAY
         7rabhmW9n6e1JHz5dO3sMUuojeT+4Dx4XbjxEU4HmcBLmRZ1UFr3IwaOALvk2f9hBqXB
         zgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133850; x=1756738650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdEVZ5TCp58sTeVk+nfvlA0Ah5Y1WxCmV7eSgrEVDls=;
        b=O8HUoq9+wL7eoSBC0FKGjU+ashCsUfYnAZGIv3G9nWVHavOHBS7BO3FhTcJG27+Ler
         e9u4bYtB4n2djjUqFcSdIbwLEYIAlLFAW3WFLViObgbISW1+i9zCNtT+MDmUxE27XCG6
         cYUcgvtqTmZtGzuA+xVymjTgf/28kk/hV9XS8CTv9hAVeOa3os9p7bQ5lfsHH1oA/5en
         VEPwYj4IS2epgMskW/Er/Hcns62Xgfq58b0caRBe1/FgVZYWXpwoWTLgn+3qMYv6iBlz
         OoSgV3aVkjzpv21lWgc74QD3JWD+afWBOnG7Z5btRRXXxyMnjWgGbisroaOBVRv7jtpl
         kRBA==
X-Forwarded-Encrypted: i=1; AJvYcCXee44hpHW6/Ag4gAZ/KiA79/0XULwls4m4FI4GhhKYqegeR6uvXAJVawphA7OS6pawdLbqRG9OrNOnvghoXbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvQh8JZgNhfTuoo8nONcoUM0uTE6KPaQF2igfB17x62sKQlpz
	Ngess7LphamncpGRuzaVSRpL5SHVaPlbLOjrEpqhIbxQqE37/HmjsryCFAuOFzC9IvU=
X-Gm-Gg: ASbGncuHjMhIFC0otYh/U8Jz/2TKuLQxjr7aIF9tDEPCSWVldZN+64OcIWPSic2kKhb
	+dpVWzHDzQoOdrTxmE/2OAJ29AlGMxkUMWTB+pNQ58QZlNzBpDXP6CNylxihoqKd+G3R2OTJJ3g
	oh1wJ9j4xOfnQGnCZMVoa/nC8CfmPcAT6pzFiy3LjKbggmJknEc0yJ2xGES7hHdtG6ZrHzrLvZB
	m8lYT6WLG+woEMp73LZji0LNxPW0vlMa+T4siBboCq/ggw1w0/rP/KXuLxlIvn07bYxOstAh7ov
	/+TcNTrA7VXyqV0c9CxucNWxdepUVgSophxeze3vuT8cblPfjOtaroXzBwkxwBpH/dUwPmeWAz6
	oeU2XIlMxpDqHjpdA8vzhECOYFUVtnOouMhgABdo2dcaLiRaTB8FvWgVZCg3q
X-Google-Smtp-Source: AGHT+IENPQBoFqdndLCJHhCszx3PtbFlasr7HlxuUT0VwFZeQm4kkp41cyvWYH6QXY7aP4DPdWilzw==
X-Received: by 2002:a05:6a00:bd92:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7702fc09f00mr14592628b3a.29.1756133849771;
        Mon, 25 Aug 2025 07:57:29 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:29 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] Add selftests for mshare
Date: Mon, 25 Aug 2025 22:57:03 +0800
Message-Id: <20250825145719.29455-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mshare is a developing feature proposed by Anthony Yznaga and Khalid Aziz
that enables sharing of PTEs across processes. The V3 patch set has been
posted for review:

https://lore.kernel.org/linux-mm/20250820010415.699353-1-anthony.yznaga@oracle.com/

This patch set adds selftests to exercise and demonstrate basic
functionality of mshare.

The initial tests use open, ioctl, and mmap syscalls to establish a shared
memory mapping between two processes and verify the expected behavior.

Additional tests are included to check interoperability with swap and
Transparent Huge Pages.

Future work will extend coverage to other use cases such as integration
with KVM and more advanced scenarios.

This series is intended to be applied on top of mshare V3, which is
based on mm-new (2025-08-15).

Yongting Lin (8):
  mshare: Add selftests
  mshare: selftests: Adding config fragment
  mshare: selftests: Add some helper function for mshare filesystem
  mshare: selftests: Add test case shared memory
  mshare: selftests: Add test case ioctl unmap
  mshare: selftests: Add some helper functions for reading and
    controlling cgroup
  mshare: selftests: Add test case to demostrate the swaping of mshare
    memory
  mshare: selftests: Add test case to demostrate that mshare doesn't
    support THP

 tools/testing/selftests/mshare/.gitignore |   3 +
 tools/testing/selftests/mshare/Makefile   |   7 +
 tools/testing/selftests/mshare/basic.c    | 108 ++++++++++
 tools/testing/selftests/mshare/config     |   1 +
 tools/testing/selftests/mshare/memory.c   |  82 +++++++
 tools/testing/selftests/mshare/util.c     | 251 ++++++++++++++++++++++
 6 files changed, 452 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c
 create mode 100644 tools/testing/selftests/mshare/config
 create mode 100644 tools/testing/selftests/mshare/memory.c
 create mode 100644 tools/testing/selftests/mshare/util.c

-- 
2.20.1


