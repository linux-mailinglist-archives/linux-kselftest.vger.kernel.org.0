Return-Path: <linux-kselftest+bounces-37020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6DFB00882
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58045A4852
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FBD2EFD8B;
	Thu, 10 Jul 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbBCfSuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0879DA;
	Thu, 10 Jul 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164852; cv=none; b=R9B1fptTx6T3HbZLpb9idbgoLY9041YLfDq+0ITarLbRDzBYlT0qwdfIPenbnnBQTXVcHUBd4WpD42xa4ZmWqFGOF6QOkF/WplkgnbE8aJr90SxF6BqQoPlPe3UJsNu/ib5a3slDLfFQCjIw2wN+MZTma0cqqq3m9ewDILAh8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164852; c=relaxed/simple;
	bh=hgECrPHdypNc06luUGps17bMFfMd2XhvvMPWti66x3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hqz20Cqcq44SrYPXl0tumR+X+VqVxBfFcBjykI/5xIxUmn7ejA+mhU1HTM+l51vPiSotRvpN196uyf/p6Gqvo8+VzvL6LBZi78Q/omUF6xtbT7UGb/sRpehRYvxEbIjOXSzEuAZsavZ0YFG5ibUEFhlo/lWQQJxVVw/eE96BqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbBCfSuN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1224083b3a.2;
        Thu, 10 Jul 2025 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164850; x=1752769650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3v5uVCH5JQNNkFqSP4afQLC6OnRWthBKWPxieJrGD3U=;
        b=MbBCfSuNETBtG1+W6WmdHG0HItwALGSmV4EuVuo6g8qR6L48wQvnpGVihT0dbEltsH
         oQd85Z+j+3dVSXVpvtkJICx1YHCJuRmRbz9SQGAyfmDli8b9aL3ZroMCqDIZmV5tClio
         Kjl5hLM592n/oiR5IdHKcKCE6U3+kxFV5702YT7wn1g6lp8M8zdKwReKFWSwIvH/Hvl0
         LzXlg/OcYL0AWoJJ9N+fgkWDdG/zIA++waftzjmyP8B1WwYNdlnpXm1MScJD/APHBrmP
         VUK9mkL4Dll/BR1t+QrfkLte+zkm1qoApJHvEBUwVoLsK6vLVWj5CdF6Cg4eSutsSXsn
         U7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164850; x=1752769650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v5uVCH5JQNNkFqSP4afQLC6OnRWthBKWPxieJrGD3U=;
        b=sDkkVWCmYYytm3GwkKEKdmLy1yDmPBvn9apI0mEPSkO3gib3i9hnKXLlu8rjHX3FwD
         tqfhVNjjKq3byUzjkFrQ9HCZeucaVHPWdu6knxDP75G/THqI4LjazRrLNcyytL1LUPsj
         G4CkLXuI8/ZCJIpi7HBH62DUiDyv54gzkLdHR/MCPJlFat+KXS+Xj+RVx1VtEv5n0uUS
         qOx1vyQWs9zuZEn+NLCkDnXQstqwb5jbNOa53Y8Z5uP10UDF3+FOKswY4K+4OhSRn7fd
         ShzIMKhoeTtg00vliB+1yXChRfoF9MiV1dv9oyloqRPTy5+Z3UfHjY5ySpizr20xchzg
         yccA==
X-Forwarded-Encrypted: i=1; AJvYcCUPAyRlvqQyyU3H3Sbi3dk4oLzIDpf/pFv3Y1Mjfc/4wXdUL5HwbS9cvu7CdgXnBWGR7vJ7LNUFRNgWDwZUWZcT@vger.kernel.org, AJvYcCUSr/WLZaldaaZ1vPhYfXLT19u7v0tXs5yScjzAFrqqX/9RE98sT+W6KhgoUv7pc7aLRSSi3DfJwbfGBdWC@vger.kernel.org, AJvYcCUb857sN0f5jCTUdAqtStihdFu6yeVEiw8bEDeysOSpK20o4kXEJ0/mgaNL9YI/CkwFD9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HpytmpQUmlR4fd0xNdSCMFj4EdGet4V6m72OB1bvy1BM+FH6
	pOHpxtpWFdHYxJwfpW/7F5AxBS+XRSf+66BkcO1GDt90sEwC/Ogc/y09
X-Gm-Gg: ASbGnctv8pAYcScNG0RZknXyvhidy9Wvg1rjFNnsDrbjGMgDba1yeOytJqRdm+G6JHz
	T8p2Aff04U+i6NC4X+xyeMbhoNANBqoxl3u1sBm3u9mWdQdiprIQgUFf5SxOq6EfkQOPsO0bRv+
	f+gUSQbclFR6DutGm1eSb+fO8IemHfbuH07bBRe5pdwCgQdRxukK0s+oSOd6MF/x0eAub6WeSF5
	+bt/VMp0ip8FRKzhI29XsjntJNM8gD4E5gLvb645WpVkt05HAttvmGZnMgb5YRqnUbIHogNY1ys
	a1UfHWdJWAxAtmU98dx9PaVuf77/ch0DaykDLd/TfXU7MoXs7FIrI8DT4OCp8no=
X-Google-Smtp-Source: AGHT+IGrMMd1dGanE55/YvNPdA1xZ7NLbA5CS4oJO2IkUnkbkYs3cxrQoNQJ0oiIng/SxIrBKcISOA==
X-Received: by 2002:a05:6a00:2d9a:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-74eb53e6700mr5071147b3a.2.1752164849958;
        Thu, 10 Jul 2025 09:27:29 -0700 (PDT)
Received: from ubuntu2404.. ([60.176.129.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f25269sm2690418b3a.107.2025.07.10.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:29 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mannkafai@gmail.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: Show precise rejected function when attaching to __noreturn and __btf_id functions
Date: Fri, 11 Jul 2025 00:27:14 +0800
Message-ID: <20250710162717.3808020-1-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show precise rejected function name when attaching to __noreturn and 
__btf_id functions.
Add selftest for attaching tracing to __btf_id functions.

---
KaFai Wan (3):
  bpf: Show precise rejected function when attaching to __noreturn
    functions
  bpf: Show precise rejected function when attaching to __btf_id
    functions
  selftests/bpf: Add selftest for attaching tracing to __btf_id
    functions

 kernel/bpf/verifier.c                            |  5 ++++-
 .../selftests/bpf/prog_tests/tracing_btf_ids.c   | 16 ++++++++++++++++
 .../selftests/bpf/progs/fexit_noreturns.c        |  2 +-
 .../selftests/bpf/progs/tracing_btf_ids.c        | 15 +++++++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_btf_ids.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_btf_ids.c

-- 
2.43.0


