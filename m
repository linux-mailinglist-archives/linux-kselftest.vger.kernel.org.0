Return-Path: <linux-kselftest+bounces-3686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFD840452
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 12:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787F4B2492B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433C5D8EC;
	Mon, 29 Jan 2024 11:53:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0060253;
	Mon, 29 Jan 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529206; cv=none; b=U+GLMtlqWMCJEXUEYjNjoJgPuAdOibwpbVc0Bsv4jYg1QRlOzl4TdFOSFfXYgZc/+OdfpK6yZgTsuSvez3s8xWJBy6xDM6R2MdUjpTMEtDTPrFbGMAE5FCoCaui1uVP3uwzxCdoxPQDvGfgQI2emMhgRZbGWv/kOCTDS6Xj3so8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529206; c=relaxed/simple;
	bh=qOaPb48Mg0Dn52P/04gL6UpkUhY24L+F/u9PD/A1rvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmAbqC8JpckQDJeikqu8tQvzug7ccWmpMll47Xi00fnMktCv1YjmS7DFZrkMNcDM8NwgSLYq5LhYuMWH82Nfm04Y19ajsJ2RD2KH9EY8r3r1GrTBLT+i3jlIBwSwXC1VDIuCDo5fg+xBEDymAu/1+1JdgmJii5+kR66R0WTPqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso945275a12.0;
        Mon, 29 Jan 2024 03:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529203; x=1707134003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRcfOqPZkCt5yj3TO5MHHKhmcnZx1t7myx7AttAycCY=;
        b=ox97tXXKq8vI7zm/gcGmoea7REQEu5197xaJMbQiLcu+hpYEtdRUFrqQfqXve1l80L
         rYaIar7z/yt6qLrr7f8ED33I54i9OPd1t6esv/tedj7L6uzujguX6FI+fZRFXOzLf1LB
         kagJW/V7dl6En7vPVMRNZdQOTddA86163Ul6JHH1H8j/tHNWCuzjr9jHFc1cuHobgL6R
         MjH+ibO4ZF4XP7+0TSM/sa9mMBrGFRlBlvR6rCrMK/JzQZ8myL8XF6Ze/6WCsP64W6qF
         Q+45qF46+SU0jX94cLT0t/zCcEQx8Y1+EXjKufWaOULxuRdXPb/JVVDVGfSXVhQ+2zwO
         CdMg==
X-Gm-Message-State: AOJu0YwKuVcDv7N6hGmFv9lq9Wcp/8LYC/39grRFLiw783QS13AihyCj
	7EPQ23C+FUfC4WbbopP9o7qQB/x6bZR6dz0cWwr3Su9Hp9EvnLCXicikhCDGbk0=
X-Google-Smtp-Source: AGHT+IF+m7fX821IhTDAdXTLqeZfPk4/8eyXUyiGWqE+UJC4GLc1ejBi75mpNioDi5PkmKInhX3IBg==
X-Received: by 2002:a05:6402:125a:b0:55f:28cd:bb3a with SMTP id l26-20020a056402125a00b0055f28cdbb3amr104624edw.18.1706529202823;
        Mon, 29 Jan 2024 03:53:22 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id da18-20020a056402177200b0055efaddeafdsm1113834edb.86.2024.01.29.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:53:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: jsavitz@redhat.com,
	ryan.roberts@arm.com,
	usama.anjum@collabora.com,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/mm: run_vmtests.sh: add hugetlb test category
Date: Mon, 29 Jan 2024 03:52:46 -0800
Message-Id: <20240129115246.1234253-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of run_vmtests.sh does not include hugetlb, which is a valid
test category.

Add the 'hugetlb' to the usage of run_vmtests.sh.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 55898d64e2eb..2ee0a1c4740f 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -65,6 +65,8 @@ separated by spaces:
 	test copy-on-write semantics
 - thp
 	test transparent huge pages
+- hugetlb
+	test hugetlbfs huge pages
 - migration
 	invoke move_pages(2) to exercise the migration entry code
 	paths in the kernel
-- 
2.39.3


