Return-Path: <linux-kselftest+bounces-39384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A60B2E192
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B4189BAD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD7322741;
	Wed, 20 Aug 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCsEdcNp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22498322558;
	Wed, 20 Aug 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705221; cv=none; b=b64e/0HgVJUjl1c+n3RIcyT02P/hEI5P7mIdwEvZbgLQ8enU1s4b3bFydJqt0uKe6eJFG7ZQdtuYGTXYvcN4HCPoBsUMhf4+kuC4651DhJX/eOny0Y3WrwnEpQjU244+AkQ8TpzoOUl4mobaA3+I3/cWBGIPbIY06P7xU+N25Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705221; c=relaxed/simple;
	bh=a/hCJoXL5I+lxBOtX74CyJftUCvYnA5vpF2rrW1Yp9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qo6m5AjoqFIFsCas330cjSJcktyaCSf/yE13xpFngMn4pseysU/iifkMrqlbXFA7OjEcVsK+sLZCL86gPz6qe0KTeW2KlQaBbbbgZUg7lvk1+Fcyfy2uMRToDIJKy97JNmeMUGroyH48WzxvBgkjlN7ZPJpi9sUc1/1eInvXT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCsEdcNp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445818eb6eso50084845ad.2;
        Wed, 20 Aug 2025 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755705219; x=1756310019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85YxivsvpcP5IRNp6DBdLOeXv3NB9wRFZGxkMTe9r9E=;
        b=aCsEdcNp2GlusO0gXzdyZRQLRBpX9ZcgbkUlMM5XZKkkJC6oeZ44A1RzDNi2aIyhqn
         2mLbkVhGJ0MmMFQdrpjCOGRbd3485Gk4G6qtYVeE/M+Mv1HG+MoYPEysQMowMkWuMk14
         Y9so7Sn8vKLvhyMc7pqFsnSd/xXJHA67K2xfOauU/o6xpvtU9peo5v28+osF6fPGYjex
         dvnMy9FUwRU2fXd92lejX3s54WkT91l/To5SajFVWkE1fQNets1lXgLi+D97bhim5/W2
         xqeh19pZfTE8l2RlQZi9ze8gUCRIMcX2XxwSHER5+GtuC3wcHnm5XSmbf4UBVVyJiubl
         ri2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705219; x=1756310019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85YxivsvpcP5IRNp6DBdLOeXv3NB9wRFZGxkMTe9r9E=;
        b=SxSpJkaialiPWd4MgfBchg9AfMnb8qCLHMkGOAUBbKSJAEqbZ3xK/iK8wLgVHQrsmu
         sKzARvDj+jpNl0udCogZZI0spTZgt27YVgvhqHhBP8xtTB6N0V4OIDBavXAWLf1QIhKq
         TRE7r/VaJL2RCBLrBsAlrYGLtaLAZmMDbO7jkW1oV5JZ2I91oQfrMUQ+ZzW9GHKww5YP
         y5GsVz9xqTRujWUCiOkNPivHVmX9BJ3Zy0cJjpkMQgQucaH4B3VTHnPDRgPKZWyMxjgU
         R6VNPW2E35xx6KSOSjHcz1Owz8gGQ15xh8xU6F3Yvjyy5ER9CVnQcEGNCgupSDQHFv4Q
         6yuw==
X-Forwarded-Encrypted: i=1; AJvYcCUnDAGczibx7jY6Vnv5lzETlimSacqKnJnKEFp734geNgxTRGrhLwS2GytpVtfekRTAlZiJozzB51gvkCY=@vger.kernel.org, AJvYcCVWg0zKIQ6mvSLHVWtGSYypGlzEkAeWYSEL3xltqTd8k2oUWsWOW95abW5zpJ0jL0ApqkDSsa6MMj8YioRwtpwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4UgJMwKB9+mJtpVQOvT4OWt6l2xFCXZQXK4yTzQXkkq8ybVy
	pEezq0UFUh5CBqE+Cis+Afk9Xjy4sWg4sLMB0YGtozazEY88qEfi7cNHO+08Z61QvGM=
X-Gm-Gg: ASbGncshRmrTeHKk9d8ZLDfaa0kGgNqdeo3ibzTiX76yN5MdRWSXx8EfR+3srTepI7X
	zbLQ3xDQSl/Xxj3xP02xB0N+U9ryiaBDLYLGX7oS6aqVdulKJCEcGfasIV2DuVRVHnlSXtsq2tr
	4xkgH3ArzVv7mvHzaEfDBvkoIR4nySJKypMFqzeij+7OSa7057J4GOO/sc1ZoW+i6uac2pA1MhF
	SeAyTYC3eLRYmnxbDZ9dq9wgkNAmgp8EOFZf3ODIQAYBPcZdTfL45cys/P3bhq+OPwyxvtyrQc0
	Phkc7EQgw/DfprQwLFRlVP9VYie5UYtYrvXiUC2vK1L+Sr9NecenfG6oI7djneXPqSC55GBF9Fm
	7dYF2Ir3gMdt3AUkVg6WBptCSMUUl9H8sAdp8vOZseQ6+0y5FjA==
X-Google-Smtp-Source: AGHT+IGQlZwARaldPqzdhtQ7tbsSk3uP7Nk0kfrYh02Q6xCWNl2/Qy6d1TtZcYrK2wV5sowJ+h3p1w==
X-Received: by 2002:a17:903:11c3:b0:23f:d903:d867 with SMTP id d9443c01a7336-245ef2272a8mr36335675ad.35.1755705219237;
        Wed, 20 Aug 2025 08:53:39 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51c7c8sm30188675ad.140.2025.08.20.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:53:38 -0700 (PDT)
Received: (nullmailer pid 71549 invoked by uid 1000);
	Wed, 20 Aug 2025 15:52:14 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, katharasasikumar007@gmail.com
Subject: [PATCH] selftests/bpf: fix typo in comment
Date: Wed, 20 Aug 2025 15:47:59 +0000
Message-ID: <20250820154758.71280-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling of 'occurrence' in uretprobe_stack.c comment. This
patch fixes a minor typo in the BPF selftest.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 tools/testing/selftests/bpf/progs/uretprobe_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/uretprobe_stack.c b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
index 9fdcf396b8f4..cbc428a80744 100644
--- a/tools/testing/selftests/bpf/progs/uretprobe_stack.c
+++ b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
@@ -27,7 +27,7 @@ SEC("uprobe//proc/self/exe:target_1")
 int BPF_UPROBE(uprobe_1)
 {
 	/* target_1 is recursive wit depth of 2, so we capture two separate
-	 * stack traces, depending on which occurence it is
+	 * stack traces, depending on which occurrence it is
 	 */
 	static bool recur = false;
 
-- 
2.47.2


