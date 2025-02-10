Return-Path: <linux-kselftest+bounces-26147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C843A2E543
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797603A5AEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1201B4F21;
	Mon, 10 Feb 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bOJKXR3j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3071B2182
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172162; cv=none; b=qpUfwRRD0ljOp6CqFcNZRF9bO7gtgw+2I8J8ltVQGJUBnhszZ6WXL+eESKvfeNDvAAMqOTpJ1UcaYCcQg6HEqStkN6KLrLsao2RTenVYuzELQBZYcRPjfrNB0QNBIqrjMZV3TLhBoTbhuCoRyxQT9rQxk4u3Hn7YwOXJrA2G8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172162; c=relaxed/simple;
	bh=gF2eMyTOLb6cKzMVtZrMlI7thdNCfssIfqf+cnBW0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkpFt+KaM7wODL8kF1YSUEHp0iyZ+9t39j/sSBH1Y1x7bTK2qLuQTba8JuAGLyj93uVxybgaul6V8BT5K8uJx/1/Bjy8AsYyhJY+EDJPwFl/YfaJzym5DJyAcgly0rfHXrxPNSJguk9wu41KeZ9SFFu5uHmVCC244zEsihLjvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bOJKXR3j; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c060568959so41063885a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Feb 2025 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739172159; x=1739776959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp4WDTh7aU0LAokfvQ9vfZPrliNLs/vu/ZlOg7/rnDw=;
        b=bOJKXR3j2vL8/FGGG+wL/XeQybDbcPO1FdY3MPeG5uli/mZ4nMg7/qpZpEG+2ldH4G
         rjAWNxXB7BGNzwNytiqz9CtkrJL4eY/cnKUUH7/QsTb5ChAeIIhM7frPOeN3D27l6j7N
         a3/EjoqbzeyTR4UustFwgK5/ukHykK3xMBYAyMltogM6uA9DcZsVi6sisRt0ymKRth0W
         PY6M25NOArxAqrwpkoUkLEg131QUYWjPXbbiR3Hphr5AhuNI886+5DmOy9YuLW21tnwg
         NGgtVMSjNnYe8d+hAjQCNIzmTSmCO4FOYKS+F1BuDkmDBE+UImDlCqk4KSmMvgbaRl4L
         8iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172159; x=1739776959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp4WDTh7aU0LAokfvQ9vfZPrliNLs/vu/ZlOg7/rnDw=;
        b=DCtjdFl35NQeAD5E1bmDhignqHW2qko3v9nYgiP1e4Ms1maOsLftKwe+sSgkXa8um3
         OAZ3hE+E2s4OGD2qZ56U8XHad4RzQUGgELBmEaHerwgwNC4DNSEkcbZGwE+vPZtwEmMq
         scif43pkvK8EmCIBK8YJBHLp+f1UxWvP0A+Y9vbmChjQSx9mUizUUBTOml8C7/Y5NMpH
         t2MNLuiveMXWV0uN1NZIKd7TAP6RHahHGyBd+j9ClGrlub7niTRvyPP6Cs6hIn+k3MoF
         AvlY5R8dDZJtyTN/cGI52GPxS/h5dYVzefXO+YgracgBEXChWZuDPp8g5Kz5kgiYHDIN
         Q9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUiPtDCNeHbxqKIeFedmREk4dZZQQmXhEH05VJSoCuRY2BCmIkY6T2XOP1aNQtQzcrP5vrM6MYoiLnczgiS4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+ANgmIhG0T3YqYnwUuZs2dfS3bl1hfpBUONwOmXpJyPWzuxi
	rwnCHKeTe+wrIJO+2HQr0rTIYAKkZVakdMZfVFgi9gQYJjTa1kQ8NHeVUu2/ejM=
X-Gm-Gg: ASbGncu6x/wf7l4HHaLtANGqzvz7WBHLQA1C41I4H8uJaNrlJXFuAtypavrQFAlkZNz
	zILc4DBPdJH6M6gdYHC4AHBRt9E+i5qM61iaxWLbaQRSUS/i82/4LRt5q4G5C/NA2D1DHasJ5z0
	mb5rojuZ7KgQKnnzU32BvcD4d1582+ZRj0pysIq4ZU4ASGTzIDORqItZ/8l7KeFB/xrGtYRG8RB
	x+lNTqjrxG+KfaOFyqIBRPm76/5iwLEnKfX8cVWdaUEcks/cL//yOAuAMM2AF1Q6J5Z/1tM+C88
	Wnn+
X-Google-Smtp-Source: AGHT+IEjBZhZuALA3RKeEOhkSOGO8BcLbjZzT8lCDmkLwUBg4Uo9I4Bz4Xpb76/AtD+EXiCFw9kxDA==
X-Received: by 2002:a05:620a:2612:b0:7c0:61d2:4ec4 with SMTP id af79cd13be357-7c061d25019mr141452385a.57.1739172159380;
        Sun, 09 Feb 2025 23:22:39 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:f9b::18e:183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719729977csm5587051cf.18.2025.02.09.23.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:38 -0800 (PST)
Date: Sun, 9 Feb 2025 23:22:35 -0800
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
Subject: [PATCH v3 bpf 1/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
References: <cover.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739171594.git.yan@cloudflare.com>

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
Acked-by: Hou Tao <houtao1@huawei.com>
---
v2->v3: deleted a used macro
v1->v2: incorporate more useful information inside commit message.
---
 kernel/bpf/syscall.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..e5f1c7fd0ba7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1968,8 +1968,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	return err;
 }
 
-#define MAP_LOOKUP_RETRIES 3
-
 int generic_map_lookup_batch(struct bpf_map *map,
 				    const union bpf_attr *attr,
 				    union bpf_attr __user *uattr)
@@ -1979,8 +1977,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -2026,14 +2024,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
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
@@ -2048,12 +2040,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
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



