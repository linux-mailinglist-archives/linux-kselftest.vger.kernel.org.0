Return-Path: <linux-kselftest+bounces-7330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7E89AB68
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0B81F21E99
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA5374D2;
	Sat,  6 Apr 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ1eyWnk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497941CFB9;
	Sat,  6 Apr 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414791; cv=none; b=rYn4TAzDHsCESqrac+31K+TdORUGkvbH2OSY0Eu+uQlyhWtaxz+Ypr5ib7SlbeN0htu3L9Vaby6SX4q99WmQPL2Ff6tdxXB6vq6K3KbUmfnZ0veyivu50sWuEGFcw70fGZcQeyAMHZCPi4uQ6W9UsnUZwiUSfS6NH3dB+44DZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414791; c=relaxed/simple;
	bh=ptiA1PCzQan4LIlitfTk82UdxdeYk8S3aeHGjbzn7KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nf0p2+MFTkBzobkNSOTnxWJ9wQG0DebsMoxQ8E0PY2vX1oqZ5zwdsK0bcphp0ZcYm7VG4/DlFKASJbD3pCHkjLvvdCipi2z1OT1DUo0BhpyUfalbccI+4v/9tYLK/9rPcXbIC05fDCyENX9cZ2DAmZLODafzSthNN7zwpXkkThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ1eyWnk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2232e30f4so27980435ad.2;
        Sat, 06 Apr 2024 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712414789; x=1713019589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSXRqJM5tC4sSesaPkUfqrE6J3PdYWbaxpDTJoUDDps=;
        b=IZ1eyWnkRzuuBo7JaL7axvaUpY8RnsjQHFzcyhA33T8m51WwNF/FqvB/cWe49ZIKjL
         BKDgGUwO/e+MT2tB0iAk/irVtuSSiaTkZKXgq2QPE6jZknYJUNIU1oUBqhrAVmurTr+/
         eZ1JgzDuELE6a/HWIVUnjaPAXQ7m4RfunJhEYNIrQuvWWcY0u/nGNza9rldjcoKbbPVy
         NBmYw4gseiMv+a8dZEdEjwfWkQ7Q03tCm8w78q5pPtChPlsS7TsL/5IXmH2NIjaK7Csz
         LxZKQjNexH2Tw3WpJwiivvUsH0kZx/CFeyW6jO/lq6OcZiAbAGbOr78d3F0PCfDNSlQz
         d+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712414789; x=1713019589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSXRqJM5tC4sSesaPkUfqrE6J3PdYWbaxpDTJoUDDps=;
        b=MOvfOQYNaGfBym4r4O9BXFgGEEAexCmdKngewsFrDLUiWjEisp958NvgyyYRvFvT8Q
         5XkrNyV2tMonqOyk7BlK3qH0+YOEKC2g6sSz7DbE9K16PEyH38TaYGHMJvfQDk+pN4XH
         UE0tA85CVy+fYOGpEme62qOdhILM5CF5JPFAc9YRfC4PfjKvzoQ2WFgYyu1jK5JBgPak
         sHoGdufeSok/6ik3jA6c6UPn1vs7SoKaxjmSIjRFXy2T24PcPMK2Xc+1uOmYmrcdr6SW
         YyNasfvbeQG66Nsx27R6zXWDurNqWPPNX/hhBjddDxOAHoyrsdyiKZF7hMKzblIoVhhP
         hXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVWgXUC/yUCn885Pr2HjQDij6mpLatkW7M22fOtlT/LcI1/etKCWw7t3suPP8GUhQKPDBqUB5i7FNSjzYxF1LOt++Ko0C/nSPrvCKFYiRuPBT8pP2IT3hqcke6fQg+rBoOY8N1Her6x
X-Gm-Message-State: AOJu0YyfaJlBtVUQgIHxHhxrKqyfeTi5zGLuPMcOsVe5pZGcP26MPnIz
	3Ch185PwV5wx8GLd6g9b6uMOUGIewyfLvnBC1vcju9ERvXc6owuP
X-Google-Smtp-Source: AGHT+IGC2PYGcZn8I5MO7PTPhm7t8IjxnbWHW+FBFkrNXHx3c7p01R40iOHFoLUA8tP3R6O1XIiYEA==
X-Received: by 2002:a17:903:984:b0:1e3:f226:1377 with SMTP id mb4-20020a170903098400b001e3f2261377mr225480plb.61.1712414789606;
        Sat, 06 Apr 2024 07:46:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001e29833ada6sm3481965pls.140.2024.04.06.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 07:46:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] selftests/bpf: eliminate warning of get_cgroup_id_from_path()
Date: Sat,  6 Apr 2024 22:46:13 +0800
Message-Id: <20240406144613.4434-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The output goes like this if I make samples/bpf:
...warning: no previous prototype for ‘get_cgroup_id_from_path’...

Make this function static could solve the warning problem since
no one outside of the file calls it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 19be9c63d5e8..f2952a65dcc2 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -429,7 +429,7 @@ int create_and_get_cgroup(const char *relative_path)
  * which is an invalid cgroup id.
  * If there is a failure, it prints the error to stderr.
  */
-unsigned long long get_cgroup_id_from_path(const char *cgroup_workdir)
+static unsigned long long get_cgroup_id_from_path(const char *cgroup_workdir)
 {
 	int dirfd, err, flags, mount_id, fhsize;
 	union {
-- 
2.37.3


