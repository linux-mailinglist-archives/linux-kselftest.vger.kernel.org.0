Return-Path: <linux-kselftest+bounces-20076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDA9A30FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F712868E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F21D7986;
	Thu, 17 Oct 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q4sqRTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015D1D278C
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205448; cv=none; b=O3YtGLS6IDpSpqULIWM6gUlPDp1XwdCF/E8SPtqqGsG+hAr1JA8VdlZ1kHTTiU4sHZtOMOATIVbOiVtmp/kT7NyJr+XsOXTwFMy1i+0+sw1ZSTcHvpDWGZQP7kxnSSIl+zRNrMLzQDp9VrIL3LkMNpbG+FW6icXHbFjuYCcRXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205448; c=relaxed/simple;
	bh=02J+V8NG6bHla3E+1N/RlJCPVCy1MnSIM4FUtfDgQJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pN5vti39I+YFkZHSOWqmkK66SHGdGPK8c2DLojzHXZHwgkomIklMFJE5APQzX+vYb6iqsCa+4GS3TNlVT9jLFPmqMopMPR63vMpbSKjNxj/D9Q8BuN3Q6j/Zyx0CUf4s71YqXMBGzdEV+2+SF948rcefRQzDEaLgy4Hz2LavFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q4sqRTQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e6ee02225so1497523b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205446; x=1729810246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DO0xZfjMAK5plEQzAxj01KmG25qszPmEMxhmNCqVL1w=;
        b=0q4sqRTQiKac6jj5r2V4gHmSzEckcJuhXBUrBWu5NjhJFILWtL23genlOs5njvWxNU
         huQUegKgTXNssOycxn19n/mu55g4FCuskoVeNPZHTG+GPKS2CE2OvEr3XOPHJzagFzjn
         ho5HeJNkqDf/nn9fpZ8N7URvA3LaYbvuz/Et7mBCjtyQjEn6xTVZLGO6j6nca4CpH0af
         WClErfO1GJgGuWI1RvY6DdV17MN7VXSwSxapI17hZgmIgFHhLZONZlK/v4n51bLi0cWF
         K/rJmPjJvSn8HTOY453TJ4JxC4qi3DnFXI3IaprZYnpOZ2nos/KjHXD0HPXaUKTQXiX1
         UFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205446; x=1729810246;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DO0xZfjMAK5plEQzAxj01KmG25qszPmEMxhmNCqVL1w=;
        b=KWHaKVyjst7VUGY1kw9EXPtDKAzKt/b6sGTCjCm3Rr2bAqVvvcE8wuS5fW6cclpXP2
         rfyPDcZzvxlYj283jlb5/ZRiNQozO9LijIaSmxNP3bzPMTO92FJFSJAbc9+NNm0FjlvS
         0NMVWwnla7MONoRHAvMq5OwSB8s/2QxdMcUOlv+qEOMJ0fZpZDYVgWFVHq4dxVSpsO+2
         qO/l6xU1DM0M1AccX/ZN28tanLDH7oa+XC4SSzoM4cGiClDy0b+vC5vqYKxnNNoePnUY
         2U/Kz3ILoG87qOAa5tXYAjCeYQO+180oCxwBnQDhsQDMTTQluQsT8fA5jUqI36EvnKhl
         Z6HA==
X-Forwarded-Encrypted: i=1; AJvYcCWNqGam5fdpfg1+MTMq7ljuzQWwj5nS5Pwwl3d6xHgAZE++0Sh0K9NjbqM/Y0vdysF2KRzMKKTvE2M4ECVqlfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx269Fy+Ul0P43OPlfFvNHhtiQKFlEIxOZdquGOh7+SwRnLEydN
	MuKkk2mpbLM6T8u6DmZ5KWa+FAQx35dXzzu+A1wEDN5GZtVNcQto9+K6B5e0EsMaoHOVM680Sg=
	=
X-Google-Smtp-Source: AGHT+IGLK73eHVwoR0z/+pgC+vpmYoUvPITR59cWQylZjVbBb0ETIKY7OpoqslSyts6mQbSbnvHR2NSLGQ==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:aa7:81d8:0:b0:71e:5879:68a1 with SMTP id
 d2e1a72fcca58-71ea31884a8mr863b3a.2.1729205444547; Thu, 17 Oct 2024 15:50:44
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-1-jrife@google.com>
Subject: [PATCH bpf-next v1 0/4] Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series migrates test cases out of test_sock.c to
prog_tests-style tests. It moves all BPF_CGROUP_INET4_POST_BIND and
BPF_CGROUP_INET6_POST_BIND test cases into a new prog_test,
sock_post_bind.c, while reimplementing all LOAD_REJECT test cases as
verifier tests in progs/verifier_sock.c. Finally, it moves remaining
BPF_CGROUP_INET_SOCK_CREATE test coverage into prog_tests/sock_create.c
before retiring test_sock.c completely.

Jordan Rife (4):
  selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
  selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
  selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to
    prog_tests
  selftests/bpf: Retire test_sock.c

 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/sock_create.c    |  35 ++-
 .../sock_post_bind.c}                         | 251 ++++--------------
 .../selftests/bpf/progs/verifier_sock.c       |  60 +++++
 5 files changed, 142 insertions(+), 208 deletions(-)
 rename tools/testing/selftests/bpf/{test_sock.c => prog_tests/sock_post_bind.c} (64%)

-- 
2.47.0.rc1.288.g06298d1525-goog


