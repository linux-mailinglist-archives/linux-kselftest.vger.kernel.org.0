Return-Path: <linux-kselftest+bounces-14370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781593F0ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74F31C21A30
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63313DDCE;
	Mon, 29 Jul 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jonsL4zq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866813C9A2;
	Mon, 29 Jul 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245074; cv=none; b=deLH6bz0isBrUfuKhyS/KcHt1pfmBGdGRt0hEUFVjQa/3K/Qw25H1uFdSVs2jKgjfR2JyabgsL4M6DeffJMZ2VlFCeX8h/277Es6/X8D4kOIo+A/opACKJUH/wOXynQorQ6vjHk1W6IhWvwBK9BaX3eRh9Sp/Yt5mvvwQoRfCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245074; c=relaxed/simple;
	bh=3rUQkPjIOwFJUBWmZp8IFs2yXjztHWJI7crBuO20AxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pzxe9M7uXn3Bigd31xDMV54ffyh9pT/ufxEkmIdAHh/F1TXkBTHNFRWyBLSu5HjXdWz11OZa+cVghRqjUsROYmWMHgJHaGQThxrk5FJMNqVvNQvVcWLiL93E0ZiE/GfEitq8p11oicvHcYOv/eeDqznl3UphXxA03nPYAiY0ANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jonsL4zq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc60c3ead4so16157205ad.0;
        Mon, 29 Jul 2024 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245072; x=1722849872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFBBBk3Ymv7htQ4XkXi/7Fx7lMl7AE7lundlX2NUFgY=;
        b=jonsL4zquPeys82RAU0xuUfnsyPt0PN6gwEATpAJudyZE9VPSZeXejQFlo5xAKZw4K
         RqZcrhM47inHjAPhFGMs4b7o5N5sMpZ1FTu3tKXuSGSpdUdocb/Vgryb7mtcvK0be4pr
         8KI2+on4dP9U/PFv/k6J7LC8RbIOXUWutSZgvr57GTO97JQPBs+49D9LY+pL1bb13BXY
         V0qQ4Fw2PNOZY58tKVLp6hklJtxuQGzUjtdWbro12emv3dgAvGtMA73l6j9PNTwiucUZ
         /qWqDhcV+R2EgATL2nStxLciKKugJjZ3aRVn4qG3+SAIFMJlmbZf9onHiwvtgeCaXWEd
         Sw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245072; x=1722849872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFBBBk3Ymv7htQ4XkXi/7Fx7lMl7AE7lundlX2NUFgY=;
        b=bEasRCMMwUSeyB/QB9NkmU6Mh6zEZgwSBuu87RrHzgNOAayZ6PpVwCZxh/PeX1pSjD
         zuYsQ75OsmyHvIP+yddf2LMdv/Nbrr9ljQmaxWSzJzfAviJgQ1zQbC1b/TkQQQznv7cW
         eJ/BVWC83DjyjHPBR8XaUNQom1qqp6kqH8ALJF7kXnfUK0yaP5YTjBDLTA+vZ/gm4Xk7
         XSZ84UGG5sKijL/h0L/wO00PjpJZAud7FRL5bUk7GQSyL+vj9OSSzBedDowZcmqoIgFh
         myu1KYD4f8ts92GjeLo8BngfuSkPQGj9/3cjuuh6OYm03V8nBptVGWl/m8Sl0sYb51Tp
         25MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtBsDF2JcIoGCTACxL3W7WWH7L0BwLpM/VLNfYK4ZGZCIK3uuwXVHKNa7Swg9lCiDJJgYbu8v+z/OrpmfILcxAszRrhymJGAN2Mw+wT00kLrx3J0/oUXBx9lszyID8y0KkZV2NN9JW
X-Gm-Message-State: AOJu0YwgKHY95GBHyVFd+ick/6pGJusio6azB7r49Y0maRnKIKas/Cah
	jnoI8gu1ldizLFbJEmlq9d86JmOJ6/u5HgkZ/MNoI0evY6JYQz3CtJ8pFL5l
X-Google-Smtp-Source: AGHT+IFQS2Gj75T2+HjDQbyrh/tiMWHse7j/u0Fs8yjq9U2v86vOdNU3HQv+OcHwdvUFgLRVw4IRnw==
X-Received: by 2002:a17:903:1111:b0:1fd:6529:744c with SMTP id d9443c01a7336-1ff048075b5mr50970715ad.1.1722245072293;
        Mon, 29 Jul 2024 02:24:32 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:24:31 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 0/8] selftests/bpf: Improve libc portability / musl support (part 2)
Date: Mon, 29 Jul 2024 02:24:16 -0700
Message-Id: <cover.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This is part 2 of a series of fixes for libc-related issues encountered
building for musl-based systems. The series has been tested with the
kernel-patches/bpf CI and locally using mips64el-gcc/musl-libc and QEMU
with an OpenWrt rootfs.

The patches cover a few areas of portability issues:

 - problematic libc usage (strtok_r(), stdio macros/reserved identifiers)
 - gcc compile errors (include header ordering, sequence-point errors)
 - POSIX vs GNU basename()
 - missing GNU extensions (<execinfo.h>, C++ <stdbool.h>)
 - Y2038 and setsockopt() / SO_TIMESTAMPNS_NEW

Feedback and suggestions are appreciated!

Thanks,
Tony


Changelog:
----------

v1->v2: (feedback from Andrii)
 - P2: rewrite simpler code using counter
 - P5: update description/fix after more research
 - P6: use weak functions for backtrace stubs
 - P7: use stdxxx_saved names, update desc



Tony Ambardar (8):
  selftests/bpf: Use portable POSIX basename()
  selftests/bpf: Fix arg parsing in veristat, test_progs
  selftests/bpf: Fix error compiling test_lru_map.c
  selftests/bpf: Fix C++ compile error from missing _Bool type
  selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
  selftests/bpf: Fix compile if backtrace support missing in libc
  selftests/bpf: Fix using stdout, stderr as struct field names
  selftests/bpf: Fix error compiling tc_redirect.c with musl libc

 .../selftests/bpf/prog_tests/lwt_reroute.c    |  1 +
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 12 +--
 tools/testing/selftests/bpf/test_cpp.cpp      |  4 +
 tools/testing/selftests/bpf/test_lru_map.c    |  3 +-
 tools/testing/selftests/bpf/test_progs.c      | 82 +++++++++++--------
 tools/testing/selftests/bpf/test_progs.h      |  8 +-
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/veristat.c        | 16 ++--
 tools/testing/selftests/bpf/xskxceiver.c      |  1 +
 10 files changed, 78 insertions(+), 55 deletions(-)

-- 
2.34.1


