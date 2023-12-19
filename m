Return-Path: <linux-kselftest+bounces-2237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E025181922F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC012876FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073F3A268;
	Tue, 19 Dec 2023 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIRrVxde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C23D0A4;
	Tue, 19 Dec 2023 21:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D868AC433CA;
	Tue, 19 Dec 2023 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703020891;
	bh=2seEOgq+gqVcBhPue9Lq8IjiLv1aBugq6YYJHM2Wm9c=;
	h=From:Subject:Date:To:Cc:From;
	b=XIRrVxdeTb+lhQUpc90GqP4QEFpO2kOTHHxo0uLE05yxkJTzSWQ+YTTWCpODLo+1h
	 Dx8zk0UPn3Nm6ed/59q4DHgf28R7WRoTJ9PS65DVaD95lCF4/6X55hLqCjfvy+eKVX
	 pyH/TmPZsEodWaTr4otBy4StLRVWwpE67tByIGIESW3o0K8NMNqAJT/YWzeCZoEaoH
	 1VH+JaEuVgNNL9glRVGWcEmBA1yLQXdTDI7HfFXlWd64qvqf+ttAZJKxWziNeD041I
	 ug9nYLqMJqgBPL2dXV9M0AxdzIc31fJFOm9IqGxis/1Q2c/rkkKYuFDv897qun69n7
	 h0ZT1HSJSuaoQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/seccomp: Convert to KTAP output
Date: Tue, 19 Dec 2023 21:21:18 +0000
Message-Id: <20231219-b4-kselftest-seccomp-benchmark-ktap-v1-0-f99e228631b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8JgmUC/x3NTQqDMBBA4avIrDuQn1ZtryIuYjrqkBpDJkhBv
 HtDl9/mvROEMpPAqzkh08HCe6zQtwb86uJCyO9qMMpYbfQTpzsGoc9cSAoKeb9vCSeKft1cDhi
 KS2gfXatsb2yneqillGnm7/8yjNf1A+VsrbR1AAAA
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2seEOgq+gqVcBhPue9Lq8IjiLv1aBugq6YYJHM2Wm9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlgglXoRAvlWmqI1O+t+4ipDdNNd6cxMltCLGXHf62
 x59dyguJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYIJVwAKCRAk1otyXVSH0AHUB/
 sH1VXarSm9MortDtWxJLDp8bwdnntwJX37q8CMyTOgNzKRXPE7uUS6+PANIG+dGanBJS7/aHyixz7j
 VyZ7tL8T0aX+H+/vNdDkb6i8bD5AvBmkwCKOsbWHceON3b+VJQZPFCVxjELkR7UkDJw8Stm1QrUo6t
 12srjyy279jjO30HzRscPpWnEh4rhL9sDwG8wp9VBijDJYgnmtUqjuxGKW8ljLRF/hoQMF9SqApn02
 oUrnRzZ1kJkTIomRhrOe3EVRF+p1Hez4im8Bia/KBf5YUc1b4Znnh3RxBFsXJb5cjBf3u9LunRwNjp
 tRz2kOGTEiEcNLN2rNJKcOa6sixIOu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the seccomp benchmark selftest produces non-standard output,
meaning that while it makes a number of checks of the performance it
observes this has to be parsed by humans.  This means that automated
systems running this suite of tests are almost certainly ignoring the
results which isn't ideal for spotting problems.  Let's rework things so
that each check that the program does is reported as a test result to
the framework.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest/seccomp: Use kselftest output functions for benchmark
      kselftest/seccomp: Report each expectation we assert as a KTAP test

 .../testing/selftests/seccomp/seccomp_benchmark.c  | 105 +++++++++++++--------
 1 file changed, 65 insertions(+), 40 deletions(-)
---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231219-b4-kselftest-seccomp-benchmark-ktap-357603823708

Best regards,
-- 
Mark Brown <broonie@kernel.org>


