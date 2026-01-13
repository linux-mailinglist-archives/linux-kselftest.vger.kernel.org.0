Return-Path: <linux-kselftest+bounces-48873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DACACD19E97
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5765430E0F7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41203933F5;
	Tue, 13 Jan 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbyCnqF/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCB3933FB
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318063; cv=none; b=iWgH1SSuyqptbMNMJvPOMIBe3ddaBy3yfDefz9933OaoMDjeqDgfkEEzaBWCGiMChd8XQqwx2ZX84CZzKKQq1IY2LUkgyAgKHdenh1NruMdxKKd+7CbMZl3Yvg5VLQk1zEbk/FZs78S5ozheYaHpB0sbVK7LmeDpRoWYFy7r9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318063; c=relaxed/simple;
	bh=6hD5bFYTiFw+u5WlC3Ja4RO6p0L5y/V0JPy40yb4pNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9Lp/5qOb0wPq80uxlmXRMMG3favZGwb2Mo3MDHAB4IYDccy7rMYYDdxcpJchO1sFGtR+i3geshZOa+PI8J1Yp8ui/OEmN26vv72B84N3BLYSbeeINbBh9iNtZfkmBRSXFKA46Flqf/dKDmGr07RTxINImBUHfczaXp+yrJgyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbyCnqF/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47edffe5540so3804805e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768318051; x=1768922851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbTTWN64JGBAoQywDuAxXApY2+pw8bYawwCoCRHZJYI=;
        b=lbyCnqF/uiHT76EHR7Fb8yi/oQMkvHIl5/MegJ6csICwi9WnC9kZbktu1iI6x/27lp
         Qd0GuFwTMuqF6LzjeOc9jtLYL+qro2GZcOfGOwDvm0w0JKBX1t7wJ3wbSFvj93S0mHIr
         uKxm+NAJTzRLKDpQ/0W5NYOtIXNGqrWb02vSO6UfgbYTMVHfsqWuk8LRnjvz55/eCnJi
         OH0l6meX0erV6ZsqRR+lmzQOwhoUzJUSs+LSWNsTNa7y+6snOzzEJpZcOWFUsnYo4O7b
         lJ38qxFilbLTv9aZysowY1TOOQEwiuyZIFO+FCMfPvlvgU05gGEJ9PPSFE6ZvzmewSC8
         aCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318051; x=1768922851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbTTWN64JGBAoQywDuAxXApY2+pw8bYawwCoCRHZJYI=;
        b=nz77FHEAUHvFZtnRSXk89SKGvgbC/WhfwGIURcHkvfZzfha2PzPmjc1hz4ywRe1i00
         3V75ha2GJjVTwnbo6lABXT6n0k8d9ajmffEbAYHFfBE0ZDslc462m5p/yRBGbq1PyGW7
         QwsypF45gf9/UhXy0xOB3MJmKeFLxNwxWwL7EB1Rc3qefnklWpoXbF0qV1uYHdEQp9yn
         4xZ66pLo19MkbLijml8zrveA66mqgWzNcDPor+iN17KAi/iG+k5lbF53yDkOulbygwZ1
         O4T3l06ARvxLkvSljmYXnKYAUVeXOazJNDYe9YTpQ/zuowRl8BKr3tjkcsGIfKjq3pyj
         3tgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJxkqaSi5BfjZfpwq7zsJf949QkviUEpxoT4O6vJXcOXNOZWHV5j/It/hWyguqKGd4AKKUDawl/Tbp5ezVMqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wYcdtIgnvLSWQuveqCgWedTTMOd1p2I6epKkvwouZ3nya4R+
	7YZmkUDJEBrx5IKOVic11PyU3dx3jponxJDE4ulkndjqi26OmL9efw3a
X-Gm-Gg: AY/fxX7wYWSGqcEEeebghrXC8v9GYOskHKvBsE/VY+4nD9WJDbdp6LiTyIm8ua6bKWV
	ZjDgX+MTwY+vOK0gYk4EpY+wriK/3alMJBcHSJZVpvfREhtZPNwFOi8Q7ShQLSpDkTWSLfeb01j
	TcLJfz3SMb75sBrQZrWTIdkiDzzjCGzArDgQ2WhCdwPRA+jx3dj9pDiahLKmmZTr70p1chws/2/
	OSRn98FQTzpbZXeHTQ/S5DmFxsFEiNed36Px7gi7hRIyCt56557WKYaSXwpJtXMchggpAA2YnXx
	HGwc8aMRmMOhgD3WXJFc02N3R8pepESj1Z04pUMNWyg9nuv46CoQJKYRzhyfPjFTRH38x3tC018
	aMZ5EF8x2ed9yUN6HeN7Pww7lOzL2XRzv4ofvBgSoHm0P6nhWTQLQMJmZkoNBQpuMteKOR6KOuc
	eeejut3ZkGISU9U4QFnu1Q7AJaZDC7c8LYg+N2PSfuT3BbcAuITbucU18=
X-Google-Smtp-Source: AGHT+IGxO1vUemwqVC6JKUpSwSlNgSOMLT+M80yAIztyVdNJEhHixQ6jTf/ZgIZ7VfPNTxO2jx4HyQ==
X-Received: by 2002:a05:600c:6096:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-47d849ba979mr245697915e9.0.1768318051058;
        Tue, 13 Jan 2026 07:27:31 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm421025325e9.2.2026.01.13.07.27.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 07:27:30 -0800 (PST)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v4 0/3] KVM ARM64 pre_fault_memory
Date: Tue, 13 Jan 2026 15:26:39 +0000
Message-ID: <20260113152643.18858-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
feature, which was previously only available on x86 [1]. This allows us
to reduce the number of stage-2 faults during execution. This is of
benefit in post-copy migration scenarios, particularly in memory
intensive applications, where we are experiencing high latencies due to
the stage-2 faults.

Patch Overview:

 - The first patch adds support for the KVM_PRE_FAULT_MEMORY ioctl
   on arm64.

 - The second patch updates the pre_fault_memory_test to support
   arm64.

 - The last patch extends the pre_fault_memory_test to cover
   different vm memory backings.


With regards to the additional parameter to `user_mem_abort`, noted in
the v3 review, would you like this to be fixed in this series or would
a follow-up series be ok? I also found a series from Sean which looks
to address this [2].

=== Changes Since v3 [3] ===

 - Updated to now return -EOPNOTSUPP for pKVM. Previously this was not 
   checked.
 - When running a nested guest, properly resolve the L2 IPA to L1 IPA 
   before pre faulting.
 - Refactoring, page_size is now unsigned and ordered definitions at 
   top of pre_fault function.

Thanks Marc for your review

=== Changes Since v2 [4] ===

 - Update fault info synthesize value. Thanks Suzuki
 - Remove change to selftests for unaligned mmap allocations. Thanks
   Sean

[1]: https://lore.kernel.org/kvm/20240710174031.312055-1-pbonzini@redhat.com
[2]: https://lore.kernel.org/linux-arm-kernel/20250821210042.3451147-1-seanjc@google.com/
[3]: https://lore.kernel.org/linux-arm-kernel/20251119154910.97716-1-jackabt.amazon@gmail.com
[4]: https://lore.kernel.org/linux-arm-kernel/20251013151502.6679-1-jackabt.amazon@gmail.com

Jack Thomson (3):
  KVM: arm64: Add pre_fault_memory implementation
  KVM: selftests: Enable pre_fault_memory_test for arm64
  KVM: selftests: Add option for different backing in pre-fault tests

 Documentation/virt/kvm/api.rst                |   3 +-
 arch/arm64/kvm/Kconfig                        |   1 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/mmu.c                          |  79 +++++++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/pre_fault_memory_test.c     | 115 ++++++++++++++----
 6 files changed, 169 insertions(+), 31 deletions(-)


base-commit: 3611ca7c12b740e250d83f8bbe3554b740c503b0
-- 
2.43.0


