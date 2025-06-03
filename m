Return-Path: <linux-kselftest+bounces-34198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327BACBF8E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 07:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2ED16FCB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 05:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504461EF38E;
	Tue,  3 Jun 2025 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxgrdDkC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C42C326F;
	Tue,  3 Jun 2025 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928506; cv=none; b=tdbo+ixtT6zA9767ntq/AfcXt5NJFlPGmc6ne5aXrqLY7fOwZrpFNNY/8AtegrcOwkMHw0gxLg2gGj1xrArVktyjZRt0qzyiXicBQrbV3jq2ZkRk3R+qkVmupukX4iVSbL7t9kOVav0VrIvjrUb9eIJ64RU2tplCCDbAf0iZxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928506; c=relaxed/simple;
	bh=qbZ8vdgrHkOjM8xG6D+IRZiJ2GijsSwWoqkk9PXGShk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miryrydNWwsyVbZrSNIf90p0ULGvvSJhIiHUYo0wMCRW23hS7hGvgoxF0M9l3dY81NO91wAGitOKIkSs1HC/bByleIijptUtJJjf2ladaTYpdLYhLcWxIOkg9c/3rZoXfBfJgq87T+DMiH6fozdxwIi64AW6xGeRA9jV8pxjjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxgrdDkC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2347012f81fso64479985ad.2;
        Mon, 02 Jun 2025 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748928504; x=1749533304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfhA7DjpfmFUne8RMzckoWCV+BE2SFQz+qafLLBGY0o=;
        b=jxgrdDkCaIipbq7UBDTbRYoYJSMkp5f6PAlNfg3oJ1xiK9ffaCK397ojbk6FnwNgqy
         7yH+zJEa4i1GBts4OHC8a5Lw7k4iKbYdYLkhG2UYSWk37QTRcxCki+zcL4IWGKK478XU
         b0lBsGmbTL8MmFal4CBjwRCQT23GEpBz7Ess0vMTKXL+OhWwcbRwH/onjpCoQTPXvagF
         JHJQ1+QMbrxOvdIlbD+TPvZicT9ng6u6PzrnAnvE7nndU7u4BB8zKBzs+i3beUsVG2DV
         oLvMjwSsaFm7tsDnNn1cno3vHB3g44KVUFNJOhmxOxFVO5BEl/VKn4ucIbuFefxOMwtt
         DXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928504; x=1749533304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfhA7DjpfmFUne8RMzckoWCV+BE2SFQz+qafLLBGY0o=;
        b=Y4ZPxsXzSzS54771yEhLhwy3xYYw45pD9+Z+sOnOUUFG2qFOlaCS6RavEvfF81GXmS
         02TU1FU6knjYf8SYSvwZgm5JGUfg0/GVpOmb9NID4iLNeJLZIlCfhAN59gN1uNDaaSVW
         7kVsxzMo1HaCtnFtSG7bKyJTfertK0u9faG0d7YnxcFb/2EX/142ARqPZt9M6ouqO5bU
         dhXUtkR7+OtvOqF8tX+zDiSj+n9LLjY+1HlwfzfNpO1U55rn+CgJeO23IKFz5g3HZw2s
         E3lWk3SLpalKnOJ4xigeD6hYv9yadrGY70oq2l2Q5SXJUIsz9r2nMIYdHx3Vr/nGJxGx
         ZUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+aL0moJRqQyGrvpQXHFmgOYh6YYmtCuBjpHZMQJFnfxLD5W5X+NUWMLRfC0q122gGi4=@vger.kernel.org, AJvYcCXFvA0qFpV1o0qJTis6+Z3syV8BsU+21mLmOKy0Ui2W3a9x/u4USuAy1aeAcFdma75PA5LmYZuOOzdSl8HW@vger.kernel.org, AJvYcCXlWj099IOO30Q4rjZwV3WXu0O+te84UcCppvGzD5yEYO8ncRUwk7QILpEzp7ExumqTbWd/U7F0Ygns3/9fZfRK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8stcLTUegCCG7BCdWrKPcYs6ta5V+SvCwz5dZnI2WWOCc+vTH
	CwEMDpGz6SyaN57ForLIBB17JU4X0aiKKPtFYgXHRxT52O01+DgQcJaE
X-Gm-Gg: ASbGncveK7BYjpLxJjp8i0Hs9Chdp2Z/YYSFnUz/18qUjVyRja1HNKtSfkC9Xvc5Gdi
	7sKRXqUWZ35ZjmYgJX/yGXA/+5cKKpzWzCoOq4mUdXZqkJ/TEp2FAYQyiEKQZLe8gAjCsqKvMy8
	IQL8868at4dQ0jklr/gNNiw8fuLZ1Rp9xF8aXmzRgrCsAI3BcNPqdRRkPFcSv5uL8ZpyPRcNn8W
	U61WLzgHA2vbJRhDY/rZybJ1k1Ao0aIXSQ9NTieLobttzJ/ugg5SRQclVJQu0Bk8xzIXYMhPwor
	rTnsGThSogugvcgzzf9Eh7iuj7N9rAsVc4ILMOrw6HNfmpNNittv83kj9j0Cjmc76G1vXHSdY5o
	=
X-Google-Smtp-Source: AGHT+IEJ+Kwf9w+5q10eTE5lDq+RtmHXEE6Xymi1THrGGgplTnKtn85eoCYl+2WNXdrqxjlqcHugpQ==
X-Received: by 2002:a17:902:cec1:b0:234:f200:51a1 with SMTP id d9443c01a7336-23538ed11b6mr199190825ad.9.1748928503869;
        Mon, 02 Jun 2025 22:28:23 -0700 (PDT)
Received: from localhost.localdomain ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2354fd632ccsm51004225ad.104.2025.06.02.22.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:28:23 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Suchit <suchitkarunakaran@gmail.com>
Subject: [PATCH v2] selftests/bpf: Validate UDP length in cls_redirect test
Date: Tue,  3 Jun 2025 10:58:05 +0530
Message-ID: <20250603052805.13042-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suchit <suchitkarunakaran@gmail.com>

Add validation step to ensure that the UDP payload is
long enough to contain the expected GUE and UNIGUE encapsulation
headers

Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
---

Changes since v2:
- Rebase

 tools/testing/selftests/bpf/progs/test_cls_redirect.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index f344c6835e84..c1d2eaee2e77 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -978,7 +978,14 @@ int cls_redirect(struct __sk_buff *skb)
 		return TC_ACT_OK;
 	}
 
-	/* TODO Check UDP length? */
+	uint16_t udp_len = bpf_ntohs(encap->udp.len);
+	uint16_t min_encap_len = sizeof(encap->udp) + sizeof(encap->gue) + sizeof(encap->unigue);
+
+	if (udp_len < min_encap_len) {
+		metrics->errors_total_malformed_encapsulation++;
+		return TC_ACT_SHOT;
+	}
+
 	if (encap->udp.dest != ENCAPSULATION_PORT) {
 		return TC_ACT_OK;
 	}
-- 
2.49.0


