Return-Path: <linux-kselftest+bounces-39276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F35B2B7C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 05:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0518845D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37724A043;
	Tue, 19 Aug 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9n2DkZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACE3AC3B;
	Tue, 19 Aug 2025 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574808; cv=none; b=CNagnK88LJ9ye/fY4i/J+NvNR6haSnrEPIpL9PnaRyj/BUFSM8L/hZGhNlMhc3AwF0nhEyV56ePK452OVUrxMppGwxCVMutMszdiDgOuTViYBiAsgPjip5NGVHdyHCCw9IGsCr2cAmsi+LB2tLKPHn/hY0958Ancq+kCqi95gIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574808; c=relaxed/simple;
	bh=oMMTTpZ7DDLG7SH/wCcYpwJ8GcWUpvWEpD3dzj+P22E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awPNZf1fHHlWS4TYsWb825PAdmcp+0BdGq6x4FtitavP+WqJnbxIF0x3TT0jlT0v3XeDZbsWnRv4IyFgUByYI03FGJkUXvFULNjpZGqv4PwNw+OfqOQmziBOtT/HuvbnyrrF28qbmM3ZHEsJBucvJeNgAWSWFdeMc9my0mR5PX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9n2DkZc; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so5181787b3a.3;
        Mon, 18 Aug 2025 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755574805; x=1756179605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFHQgOMcHjeD9oe1SG5cmQkVXc+xDQWsrx1kiEfHVL4=;
        b=L9n2DkZc0Gm7HKl39/f7fbpnwMN/3ZA2ZEyE4IZQf3Vp02PoVoGqtLWu2lqSmlkE3n
         KGih3EGFOJHrUVFhtEhOZGIOPQTXccpq0wLXobqkEsHwigYS5dAtM9vle+WO8okNIJ1s
         Th9GuNs8UDCVxyQ9sNCsOTcsIivaK2739c3KzXHZ8fw6xrsSEtC6P40ONIktMXan8Mmv
         DD2dTmUHVDGT05cv6d6Y/prxRommV3EHFONJymVDnLNewt1GcIBdlbT1wK8+u+Iq1aXe
         OqQTXOgGcEo1Rdtx4t8EuPtPSJdUoGfVIfIlCzR/GLx9Ry1Dgaw68dc0EJUp9slVXCxG
         PYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574805; x=1756179605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFHQgOMcHjeD9oe1SG5cmQkVXc+xDQWsrx1kiEfHVL4=;
        b=fXfRGmGaATXH2YVox4WaS4YyyjKVWIUxnUxBZ9OLJVt1en9QZ+BnEVuFT4ZlObt/Bq
         vPGlwtZuzmKWkd1oWEmxcZ38bMPVAPCXWdmAph7bGnmSX+dhE4Zv0HHakq+w8g2HNUq/
         OT0y5NUlEhmkbXNcEQFVhG2URXAZydxTpmojyIXaZLx2aoQS6or9R8rrFyeQlOOYa71Q
         uaDNggT9kzqHL0N1o1i0Y4Om1/n4HFITJ8Xx6XMaZVA683rUus5Ud12E+hUnHiq7XL9I
         VrW4LpkpoZ/9bBoIrxlhk+Mi/r4DbHcush6vrdQaWcD3CZjS2cJDcJXbTbzw3cxOn/ZA
         vuhw==
X-Forwarded-Encrypted: i=1; AJvYcCUZmh5P43mtPbhNQpOR1i94hsmb2AKA9hZ6kpwwQ+GAWFou9/0ifsnbVENM7mteKV4m5EBJAqRKeyYUakn9kJL5@vger.kernel.org, AJvYcCUy+KzNT1+5h2aEzSqQPDXDu8F8GPAWmjiixTX7nCcwfjf9si8uRcSjx6l8TrHy0joYSgI=@vger.kernel.org, AJvYcCVjIqT117Z2vyCWeAaAXf9ZTNXOtj7nEVlC10eJjGsi04K1ABa8ZIla2SP7wSp1qIyqd0kzLrufhAp7Y4ni@vger.kernel.org, AJvYcCXt1VIb/z9HScWghhuDHPOwl49ikY+k4Z6tRbOYUVkyq7crLWg1JgL2GrA/71oV6yVqOc++VdeG@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnuUR7AXrg/WVviilB0aSAL4aoTnK+9zNTvXmlvM1n7pGCInT
	4MeLHbGfJOb6TrnxQf7hp1HAcoDA7g/JorAI1KFhqrx2XMqgYzeA919g
X-Gm-Gg: ASbGncuLAmoIOhpumZHtDmt+Il7FCYTvyRSDi/Jlq+1NceDgxAZTKqdpfug/P4LZP4w
	W+IpBdeUkjhAYoIIKexHhOPhDy8C/1+X5hjB8bIGOfjqHC/uIVpg5usarHjgqHtrdXCE9Mw998H
	XiCv0To4L/vaB/GtT4CbgeC7ArjpMUKqfMOG+VGsg2aV00mRdhZBQIPwCC+hJ+EA8U2t1eDpJSe
	3w1mLiePRVPXLdnBgrN2AlvRBHLY+GEGdE6ijlwurlCDrNXc0YnUfFlFaAcwmAmJhgZBQakCTrZ
	d7ywS2kBXTEM3pOaBHS+it3sdsyyfei5w234zEikUgOnpZDbRiwzEEHcrCyGLp2GU5T8NwYfT2v
	c6ylqfITbJSRCLKhxedJ1O69Bja8ssg==
X-Google-Smtp-Source: AGHT+IGo53aHj64WUcT7KLQgE0O5qWaO3awd9VIpUREednRbIbqbChBLi5/6xo0pVoRbbwFaPLl3jw==
X-Received: by 2002:a05:6a00:3a07:b0:76e:7ae5:ec95 with SMTP id d2e1a72fcca58-76e81140c6fmr1453049b3a.31.1755574805503;
        Mon, 18 Aug 2025 20:40:05 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d22b8sm1109804b3a.4.2025.08.18.20.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:40:05 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next 0/3] selftests/bpf: benchmark all symbols for kprobe-multi
Date: Tue, 19 Aug 2025 11:39:53 +0800
Message-ID: <20250819033956.59164-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
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

Link: https://lore.kernel.org/bpf/20250817024607.296117-1-dongml2@chinatelecom.cn/ [1]
Menglong Dong (3):
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 7 files changed, 311 insertions(+), 219 deletions(-)

-- 
2.50.1


