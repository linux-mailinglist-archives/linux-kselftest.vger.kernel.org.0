Return-Path: <linux-kselftest+bounces-4492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AE8508CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3BD1F22727
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982905A4D5;
	Sun, 11 Feb 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7KA3tth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82373A8FA;
	Sun, 11 Feb 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650305; cv=none; b=UZDnv3NyXgl0y7TWyiM9uWGmlDu/Pkq1CJqGgSsbuDoHa8qPL3+Z1IeWL/z0xVUlIwMXNShGQqmqRE9VmTdJG6KX4kJ6ZLM/AHtTLXz/97FxJ3L9CZ+86rRGvojWSDV/ilH18gRKQPuOEFa8P/8L6+oq+Z1KZjPl5yHcEOwU4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650305; c=relaxed/simple;
	bh=I4YQN3Grp2nt6qoaBZpOBZCecQE6bzdWSYgDBqwEBF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ET1K89BTd0VENwJjeC1607ypnY8VM0eEF+cHpG0DSMHyfi6WYsxXDd5N+v4m3U1xwJiclQL1qh9D3PriNhtTHmjx1Q3lXn3NkMm19ccEcUsLGBCIB3KK3C+toZZwR/wrj2dhe7civt5S+Mu74tzJn/4ImRP+h4s7vOToS3nm3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7KA3tth; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso3642636e87.0;
        Sun, 11 Feb 2024 03:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707650302; x=1708255102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+djsQtzzdGeSs25oMrMSG1dNLrpW7giJEKVLMJxID1c=;
        b=B7KA3tthsXA7cVTLbqanjRo9FlRdLUvbqe6VvJ27q3Gj8wHRon0gQcU0fPaKH0UNs8
         dLrDTS5SWyejAkAwDsHG7Ur/oaCy9QSDxRYf12PdOPl2M65LFZkFGIEJnV0pmSXwgmJy
         D5iry/OW824CICxBrMesyHg5mhBuhdMNiQtxpZn2lSWbLBh6fYJtEY7o3zB7AU38WBou
         DZvgXsiCFmc4mC5srY9GqcOUbwKxLIFeeRjsfaKItOq8bZL/HNpdoTih1EsmBjOzJpNM
         e/31aCEUjb3t4NEbaEBIXKNXIyNn2mA9Iex8v+m0nw3KVrmOq/XSULqU7kAhTJp/6AXE
         9hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707650302; x=1708255102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+djsQtzzdGeSs25oMrMSG1dNLrpW7giJEKVLMJxID1c=;
        b=ljY5O1hsp1oZ5XnREpfXpmI+RVWdLsuODNRHNerv/5BTatXj9iV/opzbb128cW4Hj3
         Lp71JOH+Rd+30L65ruh4EQM5ivO6lj95wOxCtODzJNgG7wHt52ShteOPRBvyQHyAK11C
         8WNBIGBolyIp2VO0lLuzQbXuOqwENteAtex/dRSOL/hUaWX7DfUiTJZW6vON5IHsKT9H
         2Vv37bkRVffKZ+tAb+aInVhGmsZqTJ5sBISACAijrWVMRjYnP6pZ/3y/2ps5xCbi/QN7
         RP06DBtqvNgsD1p0HzAlkddKIBCvM1NcmgzwmlLMt7SinJAXorY69kx8H/vKJiv6/NUS
         rmRw==
X-Forwarded-Encrypted: i=1; AJvYcCVj4PxqhbrZFxB6cjFHKNv0lsPgDenX31Unux60O1qN5ANeSi+5rPM3NaQSUqWenXDzXidc7355PLrD1TFVX21NcauYXKPwPZBw546Mf45MNpjBFOB6IXL2laq1wEi3uBBhhaJ6NBMsqKYEd9rtBgVhv/XE
X-Gm-Message-State: AOJu0Yy6gGgeGSXgRMdi4TPywwK2PioIk9h9St54CYnBiU12k1pmnhln
	wYjK2b86XRAUO+a4W6kkvMfaS3P0NXP1cpZ463nl5j6egOjTDF2LpbF43DO7ii9Qyg==
X-Google-Smtp-Source: AGHT+IHYlopmYEg/R6JSagluRGm76W1anUOluAWlyM0nH3AbZ+ZbdPlYqHRf06P76ihQatCu0M8e2A==
X-Received: by 2002:a05:6512:2011:b0:511:8be0:c38d with SMTP id a17-20020a056512201100b005118be0c38dmr302362lfb.9.1707650301553;
        Sun, 11 Feb 2024 03:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQpxrd9b5isma80UEvsWb8bwsX/jL02T6A0Z4W4fgbjer3OGvWBCzL8LO+8fhWbajfvrL5/Nj/gU/S6ohMLTwICpW7je1dJ4qf4TuEsZ8dsL7GD/aA6x8gvGzWe/ydvtiJ8vop/8L2rdW5G3tCS2zM7Enzk9ZIZFDNi+cF9D9pkdFgEORbOdDZiViUkE9UgPIQhZtHul4K66qYWkxM2pgLg9co7TfvIbY6TCE3ASgKDQe5v0KqKaSZCa/E5aWX5dmIZLtpnKfjqamRm0SeMaAoO17+PMsX
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b005118c5595f3sm99017lfl.11.2024.02.11.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 03:18:21 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] selftest: ftrace: fix minor typo in log
Date: Sun, 11 Feb 2024 12:18:18 +0100
Message-Id: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolves a spelling error in the test log, preventing potential
confusion.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---

It is submitted as part of my application to the "Linux Kernel
Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
Foundation.

 .../testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
index 4562e13cb26b..717898894ef7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
@@ -40,7 +40,7 @@ grep "id: \(unknown_\|sys_\)" events/raw_syscalls/sys_exit/hist > /dev/null || \
 
 reset_trigger
 
-echo "Test histgram with log2 modifier"
+echo "Test histogram with log2 modifier"
 
 echo 'hist:keys=bytes_req.log2' > events/kmem/kmalloc/trigger
 for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
-- 
2.34.1


