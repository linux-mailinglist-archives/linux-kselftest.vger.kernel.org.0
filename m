Return-Path: <linux-kselftest+bounces-40387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E97B3D7D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD3A17B858
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 03:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C72367A8;
	Mon,  1 Sep 2025 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyYikQ2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19C221DB9;
	Mon,  1 Sep 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698183; cv=none; b=u5GgcO7XXYaS4n3bgVq/oPe0AKTlbt9Lz6EUydCIgvTQkzLSWvr9Pfh6ngyPVmlrD99I5uzIZVbhNuzfZpqzBoHpCdrIwOrPCnQi2cDiGUplsdlzEaaoUpKNiyQo9HKIIHkse4Y3b1nNRchPRMfDHBlWeNr2q+jyH3CbjGK/QfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698183; c=relaxed/simple;
	bh=eVDJfS2vmBwBj0ehU+kXujnjMgfdwYhD36j7tAij5nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiHlmvbD7x9uDxRgirQFnH8296ymfvzf8eGDwgaj8mbS3S72cd1R9XQljYR8IOk497QVi7sFjyyOa1RSLaadmQzoEhmaJ+jSJRrYczNMIxkQXoRN618DqPMHMKy0s1UwGxIeUeYDHsU5Zn2y52oiqNF//WmQ/PEXYH7J6a5qFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyYikQ2w; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b476c67c5easo2638012a12.0;
        Sun, 31 Aug 2025 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756698182; x=1757302982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkUmNTikddeYTMML9G3HM9oCIw6tu9oOLJ0SSZ6TK2o=;
        b=iyYikQ2wGoA9QSlebcDT2I71uQxMBgBKUXbk2nyyXItQV2QqF0qGrlflNX9+hsVw+q
         yN+zHL8oHqlaKSNVx2ZkZ6e7EjFSb2xGg+0nJLbP05F3XzRqDoT+6tnaz85EAmtxrmDh
         Vqk25WYiU2MYDjc9ySwAm8Ct1LNC7A48hF2RxB+xkKAyHL5jVesgTzjO76FV5zK3w7Xt
         /39RXe7CdRWU4MNPvabJ1c+UxmZG+VNx5/Ts5Zi2kESCeUBTYyYPvyEusjS6YC0C+r8i
         hdnSPtLu2U3w2TT6Ias7KJBiobwba+au4lz2s5W7ojXvtleVILMxaHD27XbXI/lB2sPS
         1y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756698182; x=1757302982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkUmNTikddeYTMML9G3HM9oCIw6tu9oOLJ0SSZ6TK2o=;
        b=RqrrbcYbp5aI7CZxYKu3D+Aoeds6qNYptcOouJ5/O1M5Jx7ulKigGOzhOPJVm1hf+v
         TKgkWCblY0CxMLbJhByj1seG3X+xTG2i6XBXnxrqCE0uDzx6/f9Fznsd71uEGyA7xha1
         m/c6TkBPCGKQmIOeHRN4tEnRJeYe56vHUD3ulUA+SJxFgUEI3atOadf0TluKWF7kn5B4
         wbBUzb7nZLzd2/VXT0Fo9WdBXFCho0TqruYsAqA9NONv6yMGNKvVzG0zOAUFn+fgXXuD
         L2K8lgAtvNyBpnx4fX4H8rT6uXh08uj2TRQITzsDhRgdqeIgWdwnMu/jjwcV6YMMGdhQ
         h8ig==
X-Forwarded-Encrypted: i=1; AJvYcCWJlDlCtwPl5zMYBMY0AOVUirXaSqie3yl3UiuMNfZ6yxIFVrkPO6WCWRWI/S5Zt95KJ+o=@vger.kernel.org, AJvYcCWqYsF8Md/X4BQbs1WvD1oFQ5HCNRZGZ+tgSrasOnRciWrvfLu42REzKXbTSnVVALFBMSDj/QW4Soq7ypR/@vger.kernel.org, AJvYcCX8t4w3ydNDXuzLBdsIq96sMv/xNLwThCr0ADj1gJz45iqOmftRrGx+2LrM7+ZmR4bwFEyJDvWerXBN7s2xgEJN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyTdHdm+UxOwQvlfZd2OBat1BIoCeayl4r52LOHs/QvseK0Nc
	o68wJWOnkH5k5bJSLeewfk2TBUWHoExSmuXEmj5e2czA/ZQSDgCpMQxi
X-Gm-Gg: ASbGncvKbB/i4WbwVmIL78qlMBLvgIGqkfmVbrs1t1iIIjzt2Uk9BAiKhELbY3jUJQk
	mVIFjBjdKZG7OL3ty+yy6AugbndRBcTYbvxgeVVtlSJv2B7CRng1gKTIO2YDLVs2d7/7ztjOh62
	IPKvpkZCQQTjfycqcje1Q1+TkSyKf6puCkey+0g+ZBbXcAh1cgHdsZkRPrpTehwvP7oM9ovDhmT
	8tt1zXtWjWkvBXjGITjPU63x6nN6jDa0wCadlwgtqWmJpHZMPfND+9VBK85ubcmFP7r2rIKcbYE
	TYs20f+m+YfGk+LpqAjGjwhoEiqIFlYyHbqBy4HE4OWnotqIrCQWwE3QWmcilZ6w8J6Pc4Q13Q6
	5OdfTI4pc7AAv9qyZVGspcoY=
X-Google-Smtp-Source: AGHT+IFZK2yUvz4eipEije432KTVp+GWRyDeDriQPJeQEwuwH2w/3obW82hgUyWbVqQ1wtm46W5HMg==
X-Received: by 2002:a17:902:e5cb:b0:249:f73:bbad with SMTP id d9443c01a7336-2493ec11630mr101946855ad.0.1756698181590;
        Sun, 31 Aug 2025 20:43:01 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm88398265ad.151.2025.08.31.20.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 20:43:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	olsajiri@gmail.com
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
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
	yikai.lin@vivo.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: benchmark all symbols for kprobe-multi
Date: Mon,  1 Sep 2025 11:42:49 +0800
Message-ID: <20250901034252.26121-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the benchmark testcase "kprobe-multi-all", which will hook all the
kernel functions during the testing.

This series is separated out from [1].

Changes since V2:
* add some comment to attach_ksyms_all, which notes that don't run the
  testing on a debug kernel

Changes since V1:
* introduce trace_blacklist instead of copy-pasting strcmp in the 2nd
  patch
* use fprintf() instead of printf() in 3rd patch

Link: https://lore.kernel.org/bpf/20250817024607.296117-1-dongml2@chinatelecom.cn/ [1]
Menglong Dong (3):
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  61 +++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 234 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 7 files changed, 319 insertions(+), 219 deletions(-)

-- 
2.51.0


