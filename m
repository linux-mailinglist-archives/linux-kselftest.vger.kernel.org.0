Return-Path: <linux-kselftest+bounces-14032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08731939757
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 02:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901721F22737
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B52579;
	Tue, 23 Jul 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP4eX+D8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE7F;
	Tue, 23 Jul 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693653; cv=none; b=M+UPrBuW/TqSC2aMJOtbIk4ic+UMcAPp54kLKdADvCMdT8KMpqA7ZySRsIUhBGky2Cnpq4Do+WZVsekU4WSD12DWkjO9SBnPmbbr3MphaEZuGaYsaQN+5NFthpbWF7xbpQQtB7KIC0r33toT8VRj0KfMxOazf2K7murLduehbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693653; c=relaxed/simple;
	bh=fMIiiwF/8KT3Ihu31SNEhh7KgE/wOF47oWGWKBl/gRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkOxTIEw0CihP+U3tTGwfiHwuGX8J5VzZnYnCewytWBUk6/P6ypc/RddoLes62DzqO+/Thy0ObBNCdsZPkflOS4W8kkm+TW77x4oQWVcW+Sm8bWzjKS99Ymb2rMQPVwW1Br8UmrH4/Z4ySl8xl2+2wsgIF/mX9ryfE/vTqAwqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP4eX+D8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd70ba6a15so830175ad.0;
        Mon, 22 Jul 2024 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693650; x=1722298450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZxO5Yffej+v0UdKyiQJxUeNLy7cx3lHnIrlCNqVQQg=;
        b=PP4eX+D8+C/+THfYX0aCywMEqde/AzrQDJdrmx3FdqUG5f83E96OU2NjQgNWX9JaZu
         7hB9VQmmrWHc3MwAxRcp0QIVHqF66XMG9OUw9wep1jBasUFDwV0pqM//O8WTT0vggTIh
         92mVoCLVB8gkOa5XjsrOKI5t8U1cpCJLBCoTs3WNyIp+qiie0MrNstVtOTUBRWuzxw9a
         /ZRk7W/GGjbI6m7/w+FoovUV+Nm0oGWGG7i+WCZW4Py7iDDnV/w8d89V1tJRsiDMTTBO
         7Gtufg1Jw6ehKoDvUB7mcLYdPnODedEL2tjHqBhEIER8beAJsXxYghywbchOVVjh55OU
         NOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693650; x=1722298450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZxO5Yffej+v0UdKyiQJxUeNLy7cx3lHnIrlCNqVQQg=;
        b=G278+cQbdpsnsIvzFzrNCD7/mVXB6E5FcuPbfKcYyWVWL0uMCw1lZu8A6yMDbt7APh
         FKnPcAFJnGePZ9n6QLkfETzizAkhs5EpCYM8+uiUZNxASk9JRzrtXmojIHaDw/ZM/tXE
         4+f0zY2NQHvbuBXU7jnuezvTTX4kXt2dqcvqq1GlF/3Yow/r2thLTEIqcaSnU1/R30EV
         kOi2aec1ZBvCU0IFCq3g6vzsp/GLGYGDNrFyfWgee84cbrwnWYNht0qW9gUVY4cTg8iO
         Ds7VY5mGu+dIe+HTo8sP9DBUdqdhLTsKBqMd/Iitpwf7bc9UrZkmjlCo1kPP6QPX6ZbU
         bh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLhFR0tu/ezO/bFNZx+gMqfnHb3CXEPRKFGNOKctvauyNyW+PQaFMzZ3vhcTpYwYaKU5oymg2YR835Hu04FYnt0/9j8WHYs2TRSjS7UD2o
X-Gm-Message-State: AOJu0YxuCZPz4BW7WWE9T2rbxKPcsV8H+j/TqB7+Rng2toMYfcv3aWdq
	yP6L95EZ3uOLRaro9sbZhZ/On+gCXJHYoXq1CNxNSNFnPrszwfEHjjlR3qxm
X-Google-Smtp-Source: AGHT+IGckL46kThmGU9G72fGyTEz03NVp4yK/A1c77+f32LG26KsAgwky7f+lBYZduliDiNlhu0PZQ==
X-Received: by 2002:a17:902:da8b:b0:1fd:6b87:2154 with SMTP id d9443c01a7336-1fd7455e313mr58015465ad.27.1721693649842;
        Mon, 22 Jul 2024 17:14:09 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48e7c4sm61395485ad.307.2024.07.22.17.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:14:09 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Add missing system defines for mips
Date: Mon, 22 Jul 2024 17:13:28 -0700
Message-Id: <f3cfceaf5299cdd2ac0e0a36072d6ca7be23e603.1721692479.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721692479.git.tony.ambardar@gmail.com>
References: <cover.1721541467.git.tony.ambardar@gmail.com> <cover.1721692479.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Update get_sys_includes in Makefile with missing MIPS-related definitions
to fix many, many compilation errors building selftests/bpf. The following
added defines drive conditional logic in system headers for word-size and
endianness selection:

  MIPSEL, MIPSEB
  _MIPS_SZPTR
  _MIPS_SZLONG
  _MIPS_SIM, _ABIO32, _ABIN32, _ABI64

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b638069446d..11fdf126cb7c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -396,7 +396,8 @@ define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
 	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
 $(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}')
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
 endef
 
 # Determine target endianness.
-- 
2.34.1


