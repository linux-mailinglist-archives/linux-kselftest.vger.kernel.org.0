Return-Path: <linux-kselftest+bounces-42285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D9B9E68D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D904C731A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3122877CB;
	Thu, 25 Sep 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHSPkon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81BC1BC9E2
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792972; cv=none; b=nJfOHoxWg7EL96Mqd9GS7yRVz+/D7mgvCIjc7+ingUtsZlSvgzPcOXqnUmdF74LMcpEgxy7iP1YJsU9iHaZ63o5I26dpn0PmkUbc5UwZSBTSx4tUmu8/ptRn2dPr8IdnXMMdEhWZKq6rzjr8AACeqBm0XhvpxBiOAbgzBDV4Sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792972; c=relaxed/simple;
	bh=rvmn/9fNBwLXiR/naWUZlKBH+/yw0HMGHd9myyptFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB5eZtFs+NcPeK7J0QzVOqVmNSF1Qyz8+sp8jCKYfRK2nfEiq9teGu7pB8kYhhyFFlJIdwNDDrfMQduQ2QOfH0Dby8MxQDhbIKp3Y99XI88Si1oyKbI1ZjRvPO5GzjDu8U7RW4rt1qqEctJVLREPPnGsQvl6JMzI9cJP0e1PLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHSPkon; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62ad0c9cf8bso95784a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792969; x=1759397769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=hsHSPkoniy4OM3osSYrthKjNlU3U8eRIKniZJr+FZNd9fkcLB/uwwvTJd3uKtY8c1E
         YUE2361b46Ye8Lr0720uCToRQEc6e8+4Wl+aGmLcr1iIYE0WMnklFDXmyMeQAyeYzbQQ
         uaRVeEKdAcoCQTu4N2kau8It8VrdxJWkBtfVnA+QzPrcDwWc23VwnhgOBTslar2Qukk8
         c5Vzfo3X1Ys4yQ7UKdJSg27RgDXt1XmFMPsAXDqr6tg4JUk7gKh5GkOI29KEPS+nOLQn
         4R1rHedWPpuUC4DXV7BA6DcZOpM5Go3jQgxhGLr1NO8m/jhhRtenf9evBMgW/nxx6RfN
         FBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792969; x=1759397769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=FmEea9Gjf4DKCkU6MDW8/aKFbDENZEYvjYCBB1f6TaGDhNKVGjFCzSLpPu/Q8dVNZm
         SUZt1fuSYNNIEAM7UD1I9Ttyd4UHgJSzEkG6XUKUOvdurFLx0KayTQq/vRVgOEPxG8tI
         3rufCyLxOpiPzPV1qrhlaEgN8G/raZcU+7NGdHuRa4vXTP2udeM4XHwf4Y2BDv9H6pSU
         L+InYe4H38WNQn0lJQkO4Zos4MNo/M91wP0WUpMkxmwql5Fo42e0KhR1XKNZTacHC/GZ
         ZcLCgQYtYwLZox0wwDwRDyvBH3W/v/AEbqt5Hr0jaGx6q/yXKwsp0XNsF+oftrXRR9+C
         fZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtS3X0DPnAWgS3hFn1J7Tf19E40sD4O8gikH/30NXXGyG35eD5efhvAnaXsdppfifTAtR3qdG4t2cp3GFNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIb0ibASyokoueRHbsEOGdxn+WG7mvIL16dY/Ltj3aBBo2gn2+
	WChS97T9q24F93iR45Yk96vJgmzLnA+q42uwbDnOnjP56YD1fNSNupev
X-Gm-Gg: ASbGncuvjl69f8MV7NiZ+67x8li5wIz3fRfCMZdH/XiTvlvDZ9QyoQXrc8nD7Sr9HP1
	Z7ajUO7f9FuxGhZUWnSNIMXWqpanRyFc+516BxUWZ1WEQqJqAlyQq60Phj0UBG/1v4Ydzz2DYnK
	KVILJgJgc7PbKc5tLV+E394fOE/dZB0z6j8MfpIPfsjVwi94aVmZ8OcxtJxHLwZzQTmfBRgJzUx
	RKU6Kt0vTMDLRdP84oFMWpT/2+2tGFZlIgGW98kJTpfjaP2txHD2TcNHw6NGS1Jyt6TniAUb7xy
	aWltCD86IK8EkYBZY9QkG+0EAuT+jLX9k1qFlk+j7J4auVSvS4n3NvA3Q+MyQ2xfvypywniQDX4
	8AG2LPtUtEM6rCCa58kFnwY6o+8JwWEeWH6fFbQ==
X-Google-Smtp-Source: AGHT+IEn+TRY3f3rNpLqKcwo/IFO0X1TqRBrGc61qVTD+XlR37lk96NhcpagZXDaWeHbktL+5wxb3A==
X-Received: by 2002:a05:6402:4389:b0:628:d1b5:d207 with SMTP id 4fb4d7f45d1cf-6349f9d26b0mr1238596a12.2.1758792969099;
        Thu, 25 Sep 2025 02:36:09 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:08 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for bpf selftests
Date: Thu, 25 Sep 2025 11:35:38 +0100
Message-ID: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is preparing to add the -Wsign-compare C compilation flag to
the Makefile for bpf selftests as requested by a TODO to help avoid
implicit type conversions and have predictable behavior.

Changelog:

Changes from v2:

-Split up the patch into a patch series as suggested by vivek

-Include only changes to variable types with no casting by my mentor
david

-Removed the -Wsign-compare in Makefile to avoid compilation errors
until adding casting for rest of comparisons.

Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Changes from v1:

- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.

Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Mehdi Ben Hadj Khelifa (3):
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests

 tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
 .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 18 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.51.0


