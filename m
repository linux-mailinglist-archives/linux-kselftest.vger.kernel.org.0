Return-Path: <linux-kselftest+bounces-25963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5874A2BACC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3521888846
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 05:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFD1AB6C8;
	Fri,  7 Feb 2025 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rski2O3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE6187332
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907122; cv=none; b=KBJ+B3du+VYfJWedCDqLOsk7odSi8MnGyGZd7qSvAPjRdYZoZGKMVi5R8HTt1MVKyRHvxEUt8pkkeUe0PxTuwzaSV04x47IRQoGgOwfJbTYAnDcGK4wA2o0oBM5pgg/CKB2FOatqyF1V7tj+XXLbJOfLqwTHnMnnv/aqiNyx8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907122; c=relaxed/simple;
	bh=x61C/F4J/oG3FG1KFD20Za19v9HG288Z19JPSbWmAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3xikzj7hxX2ZOdYVI+yt/xwEzR5mwpdoxep/ECtrWBKe4K7qPoHzYGlLvr0i/gtvuCYsf/3SlfECJx6xtiH6XcUEgVTGhkN6BIIXvcyAgzDoFsEBtqq5pc4TNIhZvuXDrs37mzVxTNnH2trTfrN5AdwlbEGeuMCPpHg19C383g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rski2O3F; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e1a41935c3so23042106d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738907120; x=1739511920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPMcU7relN033a1ztg4Vj2Rf/KyzQJjjuQ/8o89cp7k=;
        b=Rski2O3Fs1cxOgik6Hjyhi9grCRj5cgcx+diKvtCP7QxwDeVEYStfoWukXqQN9swbB
         LeWoMCdlzsLB4UBcbeUTg685aLuKFf+zejzdpVbhhDh1fxeJxkZcEuYgvHT3b0czkQGZ
         glTr9E0N07yK1aP3qHM4gIZeFk8RCa3PzQSfR2nbloaA4feXPCJEUaG8i6qJxFxGevvD
         IB16NXb1rwvEve2Eo73tOchMfVmroJlC5oJ2A/PsuVFIQrIjqAroYtvR0cCwedZg2H78
         7pas46gbQWLLlZTpUUBHNF24mvAqAB7172CtCyDC5PKi6w8Ba5plcSQBLkmDRSQDB0hZ
         X1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907120; x=1739511920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPMcU7relN033a1ztg4Vj2Rf/KyzQJjjuQ/8o89cp7k=;
        b=rnYn9sz6hODBlsdBEhIRq0ecLVHiQNAWoJ5yWh/31Gi2LsqIcXraLJxRFf0Nlmik+c
         ddxg9Ykq9DDnMHsifVBAX/WFSEmne6CYtJbnIKLvFz/s6eyNcGKAH5Jm2+fZ0sZe84Fh
         5/QEHfXV4NAtZOh5KgFCdpdGavdqbhIdTkMje0+OpXM17mqmQa7zo7hWkpZX+qwXqc6d
         ibvvhP3xMQK8+WSdnPNGIMsUhXZxU/8m3JD4NcWV9KhYebRKEWTvezOlYczsQw4y1i61
         +mw/dWCZ0CC/x2bUvZI/Oj1vFu+brTHQuMEkXiicU95eNea5L2L45BE5MjGT5h15iV+3
         qmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5+si7bcD7nmmfKEJsB5Qngb6So3pOsU7aTOgfgo7AcwIIEYBLcMQo+2Uc4RC0SfDzTjmDY4RcUzojT2OBso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYnb0oGLp89uvqOeAm0vVKueMgiMJTL9duz8EoOJc18rJ1jm6
	6TTOrxvxiShZHiOmpEIw2zaXpp295dzbIIxuHcdt4hxMkTpLy9OdneEIpcWsIK8=
X-Gm-Gg: ASbGncufS7e60hcnbu4XUeRp4HTtmyeyIhzeABBv1tuTefbMPQHWooeeehvhfz9XMVN
	fkM4NgHhf0GUa+1t6K1ZzzRo49aXUJRiTE7ZY9dq3iLzOpHRS4cDz5yV1VoObVQG4UStWDLQKZv
	LCstBUFJDFrwb23WOq8K6M7Rmm0euQA1zIaWqoK6xImVoVPUwOG8GvvU4P/E/KcIp4mxMhPWxO6
	p4LZXj4BloPVUhbkrh8h7TfmjubUSffjJ2h5tSZmumRAeuWJ1nJb0/ckMrNvzrawU+u5II3X7m/
	jdA=
X-Google-Smtp-Source: AGHT+IEMtX5bNJe8+qFygANCqnKDtR8huQvrBTgdMpqJiJ33srctAZXEpbmfeT9ktGaXGKTQzI09GQ==
X-Received: by 2002:ad4:5fca:0:b0:6d8:932a:eaa3 with SMTP id 6a1803df08f44-6e4455d4541mr26654036d6.3.1738907119910;
        Thu, 06 Feb 2025 21:45:19 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb5dsm13228256d6.88.2025.02.06.21.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 21:45:18 -0800 (PST)
Date: Thu, 6 Feb 2025 21:45:16 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v2 bpf 1/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <177c4a3417d848aa9d72158e235be7d6b6f43915.1738905497.git.yan@cloudflare.com>
References: <cover.1738905497.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738905497.git.yan@cloudflare.com>

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

Rather, do not retry in generic_map_lookup_batch. If it finds a non
existing element, skip to the next key. This simple solution comes with
a price that transient errors may not be recovered, and the iteration
might cycle back to the first key under parallel deletion. For example,
Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:

For LPM trie map:
(1) ->map_get_next_key(map, prev_key, key) returns a valid key

(2) bpf_map_copy_value() return -ENOMENT
It means the key must be deleted concurrently.

(3) goto next_key
It swaps the prev_key and key

(4) ->map_get_next_key(map, prev_key, key) again
prev_key points to a non-existing key, for LPM trie it will treat just
like prev_key=NULL case, the returned key will be duplicated.

With the retry logic, the iteration can continue to the key next to the
deleted one. But if we directly skip to the next key, the iteration loop
would restart from the first key for the lpm_trie type.

However, not all races may be recovered. For example, if current key is
deleted after instead of before bpf_map_copy_value, or if the prev_key
also gets deleted, then the loop will still restart from the first key
for lpm_tire anyway. For generic lookup it might be better to stay
simple, i.e. just skip to the next key. To guarantee that the output
keys are not duplicated, it is better to implement map type specific
batch operations, which can properly lock the trie and synchronize with
concurrent mutators.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v1->v2: incorporate more useful information inside commit message.
v1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/
---
 kernel/bpf/syscall.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..5d0a4db6fb85 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1979,8 +1979,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -2026,14 +2026,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -2048,12 +2042,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
-- 
2.39.5



