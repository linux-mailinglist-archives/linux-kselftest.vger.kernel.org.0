Return-Path: <linux-kselftest+bounces-14215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C493BFFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A27281C95
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7962198E80;
	Thu, 25 Jul 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA+z7EcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E7198E74;
	Thu, 25 Jul 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903837; cv=none; b=uTRfueFH30SsFhLn9CauzpqFhRe7npUCKQfFamIcwjpdhoWkhF1+VlApZj246r71Nsk5uynG8BY2w3m6klYLCiETahTPFnI5WLOtUYGzXzjci04ThieoHHD/zoJBklOOJQe+A939rgpg7VYqy8aigXtRzQpgyN16dvoGaQn6NN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903837; c=relaxed/simple;
	bh=ciBgnFEAoV4vmAcZRIq08sujnM0GCX6tER42tCyt4Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bg9VqwihSyebI97uyXlhJ3LvdAZgmoHTr+smIJcyo7PLYcbWbbBq+rlrf0oiyiDbmQ6dz5bk+2TYbtj/n4X0j6sYEGOQiS+VX4i5l8CIWbRkbzPDD0AzpcisZS2zDD02W+ka/9SsuF5f2fGpP3kwYxZB1gkSCm/OMTWOimoX09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA+z7EcX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc6a017abdso5663235ad.0;
        Thu, 25 Jul 2024 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903835; x=1722508635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcmXaeoVwRZCEPr5EVJy1EUry7VOrM2uGGRBKo55OWA=;
        b=cA+z7EcXgJr9OCjsgetzgVeLW2Fc+MKPbNm3/0Q/95Zi9HFakwyt5+hrTiLu70jfqx
         GfqFw6J3LC9lTHeJW1D4erM9vlzCugSFO0UR+TKIqiuS+83ItPi5KQNg/gUZrkWqaSgB
         Ssl/cvdeopXEYHg72yQztlstw4VJE3XfUZDw6/wy+AadqEaIUSFxf49j/yqQTALuJ5Ip
         GPCTQ8FOZ0bqh98Vk1RQAMBDw/ry+Bo5r48WPp3tKPZz/QCkH5WupKF4NVClQ7caESq6
         GT6xCJ4GfEXQ8JWzIftXxyN3EJU42nNpGC2igNih0WS/hO/YvKTnq//3fTpKitO4u2te
         RIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903835; x=1722508635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcmXaeoVwRZCEPr5EVJy1EUry7VOrM2uGGRBKo55OWA=;
        b=UPzrbH+xMPf+M59Ig9oFk5j6akeVHsTAxXfmjbZWF286n4tp5rBh1mGuqgw5GVDvlC
         qQA/T/+LoJKtrfQaIyOXoovAwrIQdoN239+olIhOrkxCgQ6yMhzcNn79Cc4LSrzlX3It
         tY+LYR+QJLxuFZr7bm6PmBNnNf8nmSR+H2Z+tNOS8WKYIJut34hH6PFYg9TYchTQs8gm
         NigTEBxp9JGfAJzEWIFO4r9morsmBnTP2uqjTJl1fB+52sQZnhB16BbqeXfXa98U2kXs
         1Oh5x3w8iAhvN7I8Z5xz2PSoAjHDLsEpoUqi0iL9V3stIpsnCEjg3yRmpu3o9LjIlYvf
         Tj5g==
X-Forwarded-Encrypted: i=1; AJvYcCVpkhu8wJ/YXSEaELz3Gx9v+wc9dOml0SsuEhP+NYEgqb/BlyfKikLBf0EwTB1AISt3rZrMFf792Y6DQsSVZjHbyfLbtXGASWTMWuDPUwAwnen4XyoPq3tAbG0VPJhfzTrLmRPzKYQp
X-Gm-Message-State: AOJu0YyksndqbPJKiFKG0TBpwJOLAv/ldMfq9kkedZz98oko0espATRi
	oUpZnHTyXLrC5LzbypU8aZXwdbgtGppKXsU1lMalEJWfzOcVi78lNmvUEUB6
X-Google-Smtp-Source: AGHT+IEEFC3yDkVPzWhHEyRfUsRlqSyS3hswUTjlsR5e/yy9jVch0oRdD4eOgvhbS8Cq94N2WLro2w==
X-Received: by 2002:a17:902:e5cf:b0:1fd:a1e9:29a9 with SMTP id d9443c01a7336-1fed92f389emr17492485ad.47.1721903835139;
        Thu, 25 Jul 2024 03:37:15 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:37:14 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v1 0/8] selftests/bpf: Improve libc portability / musl support (part 2)
Date: Thu, 25 Jul 2024 03:35:52 -0700
Message-Id: <cover.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Hello all,

This is part 2 of a series of fixes for libc-related issues encountered
building for musl-based systems. The series has been tested with the
kernel-patches/bpf CI and locally using mips64el-gcc/musl-libc and QEMU
with an OpenWrt rootfs.

The patches cover a few areas of portability issues:

 - improper libc usage (strtok_r(), reserved identifiers)
 - gcc compile errors (include header ordering, sequence-point errors)
 - POSIX vs GNU basename()
 - missing GNU extensions (<execinfo.h>, C++ <stdbool.h>)
 - Y2038 and setsockopt() / SO_TIMESTAMPNS_NEW

Feedback and suggestions are appreciated!

Thanks,
Tony



Tony Ambardar (8):
  selftests/bpf: Use portable POSIX basename()
  selftests/bpf: Fix arg parsing in veristat, test_progs
  selftests/bpf: Fix error compiling test_lru_map.c
  selftests/bpf: Fix C++ compile error from missing _Bool type
  selftests/bpf: Fix order-of-include compile errors in lwt_reroute.c
  selftests/bpf: Fix compile if backtrace support missing in libc
  selftests/bpf: Fix using stdout, stderr as struct field names
  selftests/bpf: Fix error compiling tc_redirect.c with musl libc

 .../selftests/bpf/prog_tests/lwt_helpers.h    |  3 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 12 +--
 tools/testing/selftests/bpf/test_cpp.cpp      |  4 +
 tools/testing/selftests/bpf/test_lru_map.c    |  3 +-
 tools/testing/selftests/bpf/test_progs.c      | 75 ++++++++++---------
 tools/testing/selftests/bpf/test_progs.h      |  8 +-
 tools/testing/selftests/bpf/testing_helpers.c |  2 +-
 tools/testing/selftests/bpf/veristat.c        | 12 +--
 tools/testing/selftests/bpf/xskxceiver.c      |  1 +
 10 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.34.1


