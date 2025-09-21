Return-Path: <linux-kselftest+bounces-42030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDAB8E1F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CFA3B1680
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECF26D4E6;
	Sun, 21 Sep 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxo8s54O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293226CE2E
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475769; cv=none; b=JwApeWZm7LK2XdrFQF1n7OmvTTKQdpRAEAosRqkoVNPocKxsJNsfENQDbfKBZ9IqCVl4RO1XAXsvhuOBGPJL6+Cl5rsQKNl/82o2axIarsxTvA8lUy55YBKFEl6IUXOAp8Im23gIk4gsDvwsZvZSjLzZRxwsyNdwe0Ch4A8XhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475769; c=relaxed/simple;
	bh=EKTu85teQ1TxZrXrUJn05KIs5vLfN9ijQcWezZYc/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYcgAocPfgrvKoKzXi1IOc8GONzohGXn++9XlMc+ffbKryD9EawaoR/j5DUFbXXIfW43W6LQSmCK8mQ3B47lIMrY09TiZUKpXyUAc+iB6aFA6bkry1t3BLKiJ/VymA1OWe7d6OBW+222/8L3aHRFjrYpUUWRetojY8S2o99aTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxo8s54O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f2e960728so577953b3a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758475767; x=1759080567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0uzWoATR0pUTQbyWW9yEXcY/reaD1e4f5P0l2JW6cU=;
        b=jxo8s54OwjFxG50Jf+0X1eVaivE4HM+9kFb3vZEC7YP0hwq8jKkoT4FriDYScCdK5s
         sHWyAiEVA8bWEotbec5/xek2kiOHObQ6LWEbKMfkoBa0QrhcwVGH57J65V6z2lud6Seq
         /oxKky6pPuiV33m/b9I23GsMuaQB/qG+k3SoozITBG2GRunnv90CMOptew2PoN7Xj/VS
         K+/y7dFrgi9Mlmy28ugrI3Irr+bX8+5nryIFk5Mg7Z3I/6hU0PQDdF3bhY/mngmxK5H+
         uhD8tDcjtPvkRuSxtjftF78NzI3NCi1dunUPqU0urxiibKdHiISGEaT9OqQsDSSYBRNx
         IlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758475767; x=1759080567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0uzWoATR0pUTQbyWW9yEXcY/reaD1e4f5P0l2JW6cU=;
        b=LQJee773UvVOtrf/DuL6VBnks+D/YWaQAqCtIDP3LOFGuOgdLFxDFU9BQqddSbXkC2
         REhuJC6QqGCu8Q22l0oSkpt81+8lkx7xJsUd1bA41MHi0C0hxDhs+8k/CYooZ8K/dQ0S
         kwQwQmAl9HYd2kMA3CK3HqkjTNrOB7FgMimf0pGwCgE6cWZzpvrEi54SB05unlz5TvJB
         5nGeLU0YwFIdolZqT5jGpKdrwvt0kS4preF8LKy9wKeYg2WidWF0FON5/G0eoUuwwnMB
         ETN/8EOHDHReEJ0LC4c9B+g5j8lqdgIynhmadmo9mTLlgzAz2xA5zB2DEBSWMKjTnPNJ
         +GSw==
X-Gm-Message-State: AOJu0YxanueVZs0zijy+P2T7Zf8+BtrIhegRFLfEL0u7f0Clg0EapwF7
	Xm2aN3DVmEmOV5XzMIU15zoqyNn/VuYXAsM0qkjw+I1b+oYEFW92nJVf
X-Gm-Gg: ASbGnctAaYftLh+rmAwQV9jvR6QX3bB1uFv5y3qY0cZctWshf7TT2KAhD4c9UUhGa0b
	E7LdpqEjNtrcR1vYJR4YuqPRfd7063U9cAY+t0ltf2JjR/r0Faj7thEnn1uosl09Eynje50SJpv
	W+7qVOtFePH0tWSo88Rrq7koQ99b34g908G+a9V75EXcHYq5VQrUrfx6QTjqkBcu+Ej5XLfvW8Z
	ZyAgZ5N5Ct6k2cJ8qOYH4twy0Db33bAgMmc7OASk+SyK8iUZf/24vcbNSbVXJyOs/7Vb23XtMUq
	j2eV8JOMEhuScgpvlDLhdsGktv2yWYvxhIPjk8VDnI0NsTg6hdtevsq1xabRWOJp9YwiWOn1JZq
	NJWTC+Gr3iBt6cv0uhKO4+KWh
X-Google-Smtp-Source: AGHT+IGuNztlcymR1AZgLQugJMoVKgSqy3Yf45mv6QmCw2RApZSDv88MTQ6VcIfL8NhXwZBVgnXGxA==
X-Received: by 2002:a05:6a20:549d:b0:250:b053:53c5 with SMTP id adf61e73a8af0-2927405e4c0mr14591768637.51.1758475767523;
        Sun, 21 Sep 2025 10:29:27 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551b31ebb2sm6726467a12.6.2025.09.21.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:29:27 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] selftests/kexec: Add .gitignore for generated binary
Date: Sun, 21 Sep 2025 22:59:17 +0530
Message-ID: <20250921172917.77705-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_kexec_jump binary is generated during 'make kselftest' but was
not ignored, leading to it appearing as untracked in `git status`.
Create a .gitignore file for selftests/kexec and add this
generated file to it.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/kexec/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..6cbe9a1049f3
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1 @@
+test_kexec_jump
-- 
2.51.0


