Return-Path: <linux-kselftest+bounces-48026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8721CEC68A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA33302C4C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBFF2BEFE4;
	Wed, 31 Dec 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BeIsK024"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC772BDC35
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202649; cv=none; b=HwRLEUia1x3T69fBJl7en24VVogGtegHajlEuSUy/yvAsPtaEokvp92YertHUAUI20etSQqu2kwSeXsCnAe8sfdoHDRZlWlnsmYXsAu7VSHxy/67VPJfBKT0Zddfh1JEhj0VIWwaP+2qw9hf63gZvsQEhxtHcQQg4YeBr3/Q0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202649; c=relaxed/simple;
	bh=LZYOpaJobrgCoHjgtRl+RztH/j8GuhkRE/eHMkq8QYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7RBXTtcAeyVAURk+zulPrjVhOkrjpQQttQJd64KRvl2fG0Zrhvpj9FnR8e/aNmDGsiNyCCTum0ldxfn+3g+6j2TehLPtfq4PXSUQfrYvqtDTyfIT4IpMMaJraiejTOCzjznZSC6BwDw6Cni91AhmENPfKcGpmKwMH/yCqch16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BeIsK024; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-47d211aee52so7239805e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202644; x=1767807444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVlyjcKAentrmX30QVvO0mBVKIkrp0xM35G2rMEV4pU=;
        b=BeIsK024gQBeYxE45plp9XLT5WDl1u1NqYaXbFnaqK9wBWqATAF8hiTETePy4qtKbb
         sfUHEDoT69toDnHGUt3cmffIxAUjxm+EkU0/lFD+U/Pm9cus8P9rMWzSZGCwmS+a5wxl
         HbHrJVgqkmuDNXd+HATOqT7eLKvBq3nKYEd9suCGoiQGc3At7pnqzumk/U0rTtI1kshC
         H3Yk7Ek3tO5M5UoBa1l0Qig1jjaRjA7k6IJO19J/+eRavG+rulnsX/X4AGBNzRZJX/LU
         1Zc1UjbfDuLwiUaWJqmxw+KuGAtMSdJMyXndH03j2Z9NG4oe4NmZidNaqaC6AgI3l/p2
         uSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202644; x=1767807444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVlyjcKAentrmX30QVvO0mBVKIkrp0xM35G2rMEV4pU=;
        b=Xi5w8TsISLOwyVi31K3OXdYzxCeWwKk5GeQMvb7hLE33pOslBwvq0WWm2gV5Y7pMgH
         Je1l/Z5p4XAD97x5MNkHBEPidzGSVBLkfDKWvTS8QlKeOFLobJqq0OwYc+91wQ4EMehe
         RJGv9JUw29Use2PcSjCSauuuR7HXcAjLaxFWMQHMTyBQcTeLYBDoww4E12w6a0IveBjS
         Bz+WFsjzJ1Z69DWJreRSV4aaZQuMZF70EjfBJ6kfNtU1YUamqMdEeDeB1y42G9SiNq+z
         ndgF+rHpzab1fC5AEuGUZTOOSVSIRrnn5iaGpt7udDoOA+GmGYVAWHy3oQYpfZ6icpTP
         KCqw==
X-Forwarded-Encrypted: i=1; AJvYcCX4jm77Ddf/owUqt5VJgANPC4lBbtFLUDSoV8JTvzkIs8fHEaCX1O6F9sw0I6Hl5A6KPKZSNBaGjMio1txVSFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsxPHxUr/UG/kWlohTgz/ekMaF+yQhUCxKTSpUfDaGeE9ifkT
	XCcm4iL/1pZ6Tx5Dgc1tonKM/o/TF+D2LRCmC1iLgZp1jzkUtRZcs2smbUiBp/S+6cMqIQ6cBkq
	MphPkaoNGM37jxdq0yZ5BQquuf5o4eIykofB8
X-Gm-Gg: AY/fxX7nhXRXgjEF8wmTbzQZrxbfB9NzfBZJTxOu+FOwlVb9Ah0BrEm5Royl+etMdI3
	uCZ+SwckclI519u0VLvuw7sEI00r0wZSdUe7VXAPbEeUbsytPhmZj1Jm5TRgPif002cLneefIZS
	BiOdenzEb/SicUfVaHswNHexoEug+Q9VtF1QlRM1FV6WBOpbMJ2yYzalvvdV0s/qwgxQ3OEyZeB
	772+nnVdXvFjBkwScAPWKC2wkBbnxs+r60RSoAg4iEG1v8opKBn7XOPpbe7RUBVsNECvLPBS+NG
	F9TP1f/LWqxqQ69hEf3sxziMT14nFXDySTnqZoBHXTdfCSYrCijMIiS7hUqF3npK4tOboY58BK9
	cjvluNGAbKGovD8Ny4lCyQ740+CYiGcLIKr2Z+93Rdg==
X-Google-Smtp-Source: AGHT+IHGNcufNXfcgEiaG3fE++EJIUmFXSODBiTSSOMmOJWuTmPgyA5t+pQycATcDgetKa4a7ZLxQVnzL4oj
X-Received: by 2002:a05:600c:4ed2:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-47d19597517mr267166145e9.6.1767202643565;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-4324ea81ee9sm4354365f8f.19.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 304C53403AF;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1CE0EE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/5] bpf: use const pointer for struct_ops cfi_stubs
Date: Wed, 31 Dec 2025 10:36:28 -0700
Message-ID: <20251231173633.3981832-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct bpf_struct_ops's cfi_stubs field is used as a readonly pointer
but has type void *. Change its type to void const * to allow it to
point to readonly global memory. Update the struct_ops implementations
to declare their cfi_stubs global variables as const.

Caleb Sander Mateos (5):
  bpf: use const pointer for struct_ops cfi_stubs
  HID: bpf: make __bpf_hid_bpf_ops const
  sched_ext: make __bpf_ops_sched_ext_ops const
  net: make cfi_stubs globals const
  selftests/bpf: make cfi_stubs globals const

 drivers/hid/bpf/hid_bpf_struct_ops.c                   |  2 +-
 include/linux/bpf.h                                    |  2 +-
 kernel/bpf/bpf_struct_ops.c                            |  6 +++---
 kernel/sched/ext.c                                     |  2 +-
 net/bpf/bpf_dummy_struct_ops.c                         |  2 +-
 net/ipv4/bpf_tcp_ca.c                                  |  2 +-
 net/sched/bpf_qdisc.c                                  |  2 +-
 net/smc/smc_hs_bpf.c                                   |  2 +-
 .../testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c |  2 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c   | 10 +++++-----
 10 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.45.2


