Return-Path: <linux-kselftest+bounces-42047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27CB8FB33
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8EF1898F8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C04285058;
	Mon, 22 Sep 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdtwv/jb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AD284687
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532255; cv=none; b=piw0vXuPQg6ereqwrDy9TUzTdl8jy7YxKxERDZXMWocR1WQKJEhgBPNaITKH1Ojoz4GB7ODfrL7tJPVCvdf1tVma8E2yuBQah83DM9/Tc+baG5kHFbxjWzOvUHzs1grSvTNRzlZGY1smi4Bdch8Ep/YCK35ha5BtYENF0tfYvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532255; c=relaxed/simple;
	bh=gUrGUJakgPzosFGigVs6XaFTjxgLzYgllr06uUiM3u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urw8bJNmAE7bAAe/tSkoGtesr5RO9DdVJn20v1PXMjP8Y285IcmX+fiFClI8P88VsFRypxgZrfHt6wvBDTxBQXaJ5qOAgdlSzzvCl0cbirN5AVF2diWyL2JQVEFR9P+ZfTJbEmxFNs2KNGHYXmQiX5rWubul36QL8FEzi20ShDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdtwv/jb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3744610b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532253; x=1759137053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6Be5B7JgVJk/GLRraqIJqx9p+yxvWVlj/0uensJ0pg=;
        b=Bdtwv/jb+axa4NiIm3Jk7Nwq4zlmmkovLnfbbxnLUzLCNI0NijgdR5SD0x7U3/sk1v
         XkKoPVkD+gSgB2K1xdaGag+e7qcpW/1zPRggZV5iR5K8KQGxy5T5kVNE7E2QYL7YQOk+
         qBjNKS9NalgQs7Jm8S10Zt8PUEPTg2yFc9phzf9UPH7vSAUoBTvNsWo35SjtJ9FO10Ga
         VZr2SHjtnySamWueRP6pChFocV6eTuZWDUhyRazMDPZUlzrbqHNwcbh/AEmYufxJ/klj
         HjEebdQAMJ0Ai54CsQGRGfmdxspOdcSkHr49kwT4/VX9CImF/J91EIm8yCQJRkPCxOsp
         g96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532253; x=1759137053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6Be5B7JgVJk/GLRraqIJqx9p+yxvWVlj/0uensJ0pg=;
        b=ElK2RmHqldzlCOc+UwVPOaplLe0kHWGjWIbIZUiQXjaYSIY7bzolXXc+VYSKaj3tBe
         tSq1KCZJe3tfawd/VQyzm5f64fGB9RPqzyiizdBEezieAW7Bo7v5kYDDzQjDahyUT7nH
         XCR8on3iyhbtUdoVGYfiXUrhrdimJaIlQ+3pH/Y4JYcGG4ZY2HELs27gt1rfqeS1kzF3
         AxXNH2j/GMmrznxey3DniQliz3gePSIkuoz1DlT4PB54LTD4uPbT0DHgX4nmqnkimenZ
         fkvpfMIiE/nRexOzROdS3gNqnsUSUQooi5ZqjmFKinO8UnlRqA7TA2O2RUKn4x6+UmB4
         wBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP7xkaPP2CCtno/h0ZJUE86ieX7ZMqjPmmeEkkTC1KOv42ar/jS6jRFYHLFZ/qjXinLCoWXzQDIf9CSuuSnnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1Z2rXFSHx/qp3zjvoDN9R3iJVn7vp27ltyhoxcegS5AWYcyq
	on7/07GT6E/anxRWK3/i2x+iNWnE8sC+CxEji3choBkdWgKCLQVzykG0
X-Gm-Gg: ASbGncumI+CFf4IXzW+Txr6nox3cW+YSixlTzXn7lD5dVFpoBIyycFwVmn6uYaQpuaI
	iQNHbPPwyrXJtd9V+MH6wedbCfDHEc4OcYecu6ZXZRRVedKzYQEH1/29awhIQZusN7Z1Y2YYgwX
	H7dg0lEKcGv6piCx0plU31QXEcnVt5DRnKUJO38AwZ8gM0Wn/fyjeAfQwL4qb4mWj89jzR9nAgh
	D2D8H8iAilOEYcP0G0XEs4eylBbZDIYMAOzIB2PBvnBIYvBbXS7ZULRFZWoBmqjYlYv2n7oh/Ma
	phDI5n+qay048zrym1dArKaZbKiafVU5p0pGU6rI91M2Hji+KeNOP0hIbyHQTrUJKjVudDfz0ku
	jMWGV+BEUkRsta8Suod6lTG0F
X-Google-Smtp-Source: AGHT+IGOJce+qqy9vWaSkzQ7B5SitoIzZV0BK+drOi40fTRQuov+y43GMyhTFnomgzYjfXxBRox77g==
X-Received: by 2002:a05:6a00:340d:b0:77e:543e:3f3e with SMTP id d2e1a72fcca58-77e543e4318mr12853674b3a.3.1758532253047;
        Mon, 22 Sep 2025 02:10:53 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4190cc8dsm1393548b3a.2.2025.09.22.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:10:52 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Mon, 22 Sep 2025 14:40:41 +0530
Message-ID: <20250922091042.149117-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kselftests generate temporary binaries that are not tracked
by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
during `make kselftest-clean`.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/acct/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..16eb97079e63 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
 CFLAGS += -Wall
+EXTRA_CLEAN := process_log
 
-include ../lib.mk
\ No newline at end of file
+include ../lib.mk
-- 
2.51.0


