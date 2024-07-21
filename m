Return-Path: <linux-kselftest+bounces-13969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163E9383D2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 09:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3CE1F2142D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A58C0B;
	Sun, 21 Jul 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhp2lDr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC28BE5;
	Sun, 21 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548288; cv=none; b=nNABgxI5exUlqPLVzwgD75+A/AoYZ7cfeCwVirP8TaAdmQPXw7KT1dyowan/CgLddlaoteN7+7zFn1+cW2lqDAvHcQCTPZFGXUwWR8LxSCS4qvDlbB84rwi+G+NPiXTWu1MF/l+0/NZGAEI3npun9J6p2kCGDnvwvIqz7ClgMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548288; c=relaxed/simple;
	bh=W7r0foFN4YETCnmjLVaIoiRWPsZ6QFDBo5GGtDjY4w4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gAgZjPhZuo1+2CB2Jb72yMi74Odk7rGbrp83qMPfyHdWMBO48fkvALZSXTN42r/4E0VCnaIM+lb+90plYW/jT08id6NEEm5fqsaC6sab33TdUrJw4SsKhuo4QqMJoEgonnBJe5HJcn6a0jpg1FPIBQkRtDYnxefsgEl/qc+v2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhp2lDr6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af81e8439so1789772b3a.0;
        Sun, 21 Jul 2024 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721548285; x=1722153085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nr+m7W0mIba3WYETKiUFqBDDcPusJbv1sLo7YRpeyqk=;
        b=hhp2lDr61BT5UpG2yM2NZsED7bYR8RBf5nAXsGIrLLBGpJSA9ipAtG9VsiGVNF4nHr
         qbbZ5Nrk9W2VFFysSR0xjAniy9xh+UrXGepRLCfxB2ZCmU5Y9WMCuL9gnOBkbjKWJ7yc
         LdnGLqehlcYi4AXj32Ry271+sNxLTKN2m4T6aQvAUFF/A8UFkE4XSB3LCjtmzds2DXRD
         1hGI0PDZmSmQDp/MOXyMtd2r2mBf0908PL0x4wAa7jO3kT8AAtMrZu602+9RPJliyQnL
         hw4UwcP+r5No7GCqPfR3NvTgRM8jZiiy07G7jgQdQ2FqUILafwMD1pduLGGskObq5D+M
         pg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548285; x=1722153085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr+m7W0mIba3WYETKiUFqBDDcPusJbv1sLo7YRpeyqk=;
        b=tbCjoVyuuW6V47QgtlFNQ7Xkr6D5xlTe4W3Xs/Cz1Pnf9RwecTReM38o780PJHfv/+
         u4izAJr7SVcotdm/oJ7NqRc0xwJAu2GZpcmWH79LhFn7SQ4pWWpazAjRHqjU1SkvvCW7
         g+CFLmWycUwvrMZVKsQ3d3cDSFnn8uR0OuRwpJGJSu20h7jIQRAfQ9/Q3sg1E1+sngp4
         gLbjya3c63s1JTMcwjdsNn+RxYsPHBX6SiCF8iFzgVNaT68NFepWmbjRSBVgKdImuWj/
         Xzvy4Emo/I9jBwQW9+XXU2O0cZ9Q88QP0qIs9D158kwqrx/Af9uHQIe1rEhhzOsklvWL
         VBcA==
X-Forwarded-Encrypted: i=1; AJvYcCU8xd8pBt+1mW6kijK7mTTK12Is5Px/M/M+YHIIN4Ba8wjw6a9P24RcyEqWBDOSPkm9RsXg4Teg/FgHydtTG+EGOF4qIN1S1Y1ZbheIC78h
X-Gm-Message-State: AOJu0YxH+liBlLZSt7RmGE0as7jt19lXefkdVDI7m8uZmv1eRf0pDiCv
	35jCBGqT/uMwLLGVzYfONq2kP5FDp2QD6M0Mcc9MczQs1c6eJlOhWFMXq7XE
X-Google-Smtp-Source: AGHT+IEyukavIBmFBaZUZuTljKkuGAnJgIqRyyFOpSnrR3Aik4xtRqEtalC/kxnrL/0gvIu5Kp8Qzw==
X-Received: by 2002:a05:6a21:9997:b0:1c0:e728:a99e with SMTP id adf61e73a8af0-1c4228cd990mr6340938637.26.1721548284988;
        Sun, 21 Jul 2024 00:51:24 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77504952sm5760591a91.40.2024.07.21.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:51:24 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v1 0/2] selftests/bpf: Add support for MIPS systems
Date: Sun, 21 Jul 2024 00:50:54 -0700
Message-Id: <cover.1721541467.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series includes two fixes to support builds targeting MIPS systems.
The patches have been tested both with the kernel-patches/bpf CI and
locally using mips64el-gcc/musl-libc and QEMU with an OpenWrt rootfs.

Patch 1 adds support for MIPS system includes when compiling BPF.
Patch 2 fixes a MIPS GOT issue when linking uprobe_multi.

Feedback and suggestions for improvement are welcome!

Thanks,
Tony

Tony Ambardar (2):
  selftests/bpf: Add missing system defines for mips
  selftests/bpf: Fix error linking uprobe_multi on mips

 tools/testing/selftests/bpf/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


