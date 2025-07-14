Return-Path: <linux-kselftest+bounces-37239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53851B03E3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819534A1DAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8324BCF5;
	Mon, 14 Jul 2025 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLo1i9Fv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9B1EEF9;
	Mon, 14 Jul 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494662; cv=none; b=f8Td8sOI/M7FxDwhAtnMG6ePc0bjEVaZWeU0HYNo2HuC+onP0UTIM/o/gieMdl/XJTy07UG/EtCI03R7ZbneyBwStwgg1NDfHLlV2SW9+rP6yNeNbmnYWKjS6f/I74ChhT7Fuagz2Q3chX3SxrZjn+qCuMijeqmNSO5CEaQE0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494662; c=relaxed/simple;
	bh=4ojJ6q6a4p7qbfAIGgVP5A2fBeW3ohzD64jsl+Xqpd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jn4R15grcfXgjAxWQE+kzSDTWJ5QXtMYx6rG3Ycj8+UnppA3Y37UrTfybpHGAlm3LIY+nnsWv2wSceupPp0u10e8RVaXZgZo+BaOi3KMwuiiHDupDWhPGAbMs6Y3Bpvk029Nb9OCwUQ4D/hfaH30YFVi3/zuv3SE+EZaf6AUEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLo1i9Fv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2366e5e4dbaso40571475ad.1;
        Mon, 14 Jul 2025 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494661; x=1753099461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLQnFWSpHiCxC3tiUF83szw3bby4M3I217AXevLt7Ek=;
        b=XLo1i9FvUnZep5dsK2I2CfbaG6Y4K8ywu2zK0/NLeoFVp8hA0JDQ7IhmX18nl7dgTT
         nnIr/6Ud/eTTdu1r/Ri1fTkArC/b3/q5p5LI7kdgc3GwrtbYs0QW9Z5M0aRzlU5w6xLI
         mUI9T4cHTKwoHVKyN4PAqtY2BpCgKBBPrFS4NnOchVT/HOxIz/3PaN2v2NHPV79LQdjx
         2EgHMm5JXojCkw1AQ/vOKGgE2NJUBfgOsR63wwIo1l+4VViFC2qyKHMYVAvbZH9pWacA
         tEQlM/tI/zuS9fVgExbrLDsCLfF3rqMzYilFv7H9X8M0vVaLBT9mjcgN1fX3QyzaTQ+8
         ZtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494661; x=1753099461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLQnFWSpHiCxC3tiUF83szw3bby4M3I217AXevLt7Ek=;
        b=oNcRMGJ8zY24ycsjIq2cK13kY1YLVCW6jQHP/iv1E92LBxOaHk3EJ5TV6uQfumvqTq
         NxSsi8QgMiuZBVOX9SXnEbbNjtjK7zVSGue5YfoqVs9oPb8LFk64yMpWcAVycwv+g/9J
         QUoxPmi+zRiUot7l0v5/Ulf7gP+1ZsAz/c+yJpk+4/sU5/20dIfUcRaBehIXi7AdxfwB
         oZJqmJlVVtwy3LVnxvkfSNKexpbIWy9MMC73OJrMivcsqKZ5uL9uRf7WEDNB1PGnqqlh
         0VMJ/YBWS9JxbaCqd+x2udE4jJqojcPS1tKGBnVDINvEe5qiUE8XF9/Y8vrHG0fPD0R/
         PH9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzTiRdYAnuYqWhevW4oMJtb3UFJUtMeRVo/974YRXTx/zBr4m19sPUJEhXPrWdTyw+qhyOTQDMUkEtCl+j@vger.kernel.org, AJvYcCV9pHfP5ZUE0Idf320fo6Qm1XJCEwMZArpnVmPkId/8yVj7qsfHv+uPyKqbGoBX2XJJpE0=@vger.kernel.org, AJvYcCVYpurmdw5dP5oLgcZLZ0lPdEf/yeJvoqALIl6b3+xDgVuTK0DImAB/d/9zml1eL7eOW3EpHthpzVD0gOwWZbpX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0f6nLsuKybUC3VP3OhXZhO4qHDbZjvH5ol8rwscSK+eFDRaDJ
	t5GzOSovY+8mQd1XK8rW1gDlziDV66dwO3F6BAc+45O7fg/ZKLqhyx/R
X-Gm-Gg: ASbGnctKLK3znFhgz3KUmM8p99/2KiUUMpjCTJUM3G5bUghs2hQTZsm2khSfy+aEgQb
	BYVOQ4DlUPB4y2IcbjtwIFUO1x5ysHU0VVoD296JjPde5CTPNGHMNDaxACC+nnHGkjMEjigd74v
	7qwwIc+5Lt84ouoREL7xUgVDlgemVIaLv7Fb885WAhghZHxPBbRk60ynmo7dfhO/YtRc3h17d+X
	6IPj+is/1K8s9ZsJzyElngVqrAV4rvPhgcebOhALOWv3D+ah/4APJhT9gO5g5mEdOm8R09dtkhv
	BOCCDsfpkZVcJve/god9HlIf2rHIwnBGQMiRIIQ8FPpbGI/mNuKffvc9Bqu++Fe+yfE9wkY9Kly
	UbrLpGTI5a1VWJKCboWYuw/A=
X-Google-Smtp-Source: AGHT+IG2ZWulLP3HcUmHIw3GZPvxilMwzoRHxnFqBRDNAUlrv/mtI7z7Soa9kVw9mJxW2yR8ULZtaQ==
X-Received: by 2002:a17:902:f785:b0:235:1b50:7245 with SMTP id d9443c01a7336-23dedd13873mr142214145ad.7.1752494660497;
        Mon, 14 Jul 2025 05:04:20 -0700 (PDT)
Received: from ubuntu2404.. ([125.120.99.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359e4bsm89612895ad.215.2025.07.14.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:04:20 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v2 0/3] bpf: Show precise rejected function when attaching to __noreturn and deny list functions
Date: Mon, 14 Jul 2025 20:04:05 +0800
Message-ID: <20250714120408.1627128-1-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show precise rejected function when attaching fexit/fmod_ret to __noreturn 
functions.
Add log for attaching tracing programs to functions in deny list.
Add selftest for attaching tracing programs to functions in deny list.

changes:
v2:
- change verifier log message (Alexei)
- add missing Suggested-by

v1:
 https://lore.kernel.org/all/20250710162717.3808020-1-mannkafai@gmail.com/
 
---
KaFai Wan (3):
  bpf: Show precise rejected function when attaching fexit/fmod_ret to
    __noreturn functions
  bpf: Add log for attaching tracing programs to functions in deny list
  selftests/bpf: Add selftest for attaching tracing programs to
    functions in deny list

 kernel/bpf/verifier.c                             |  5 ++++-
 .../selftests/bpf/prog_tests/tracing_deny.c       | 11 +++++++++++
 .../testing/selftests/bpf/progs/fexit_noreturns.c |  2 +-
 tools/testing/selftests/bpf/progs/tracing_deny.c  | 15 +++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_deny.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_deny.c

-- 
2.43.0


