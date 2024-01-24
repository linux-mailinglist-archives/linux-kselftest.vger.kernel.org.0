Return-Path: <linux-kselftest+bounces-3448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0883AA85
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EE4285CCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC077F23;
	Wed, 24 Jan 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpkiq0P8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E977F1A;
	Wed, 24 Jan 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101244; cv=none; b=UZ+Ith1HkTZ875YE7V/g4dkc9kFurZ0JZwssThasuhsji10jGVXcp0RDaPOEq6Ag1vQzxM+vEQcOaa9bbPRI/xCXd6Vo5LQHGFwUd5Rf+ayDGEGEWOguYvUXyxShFG6x+oHiqsA89AcXJbLwb2vmaueCGKpTWswNtx7iAuX7YEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101244; c=relaxed/simple;
	bh=/vkNrDXpJXxQEVwMKcAclY2ef9tG0/Qkc2+hembTXCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FBB6o+YmPZ813hPJnjtflscJTIRObbPhp/y+H4QO8OUDNR6I+AYkRPPYdQpF5LGgpJnDrp6EebjZgzhEhc6VglxL+bAjmTwZV8HiWRj36dKfu6452xdRqYS3klHZ1jPQ1EM9NBirBH/Tb1ds/g9pu68fVH/ctJIZoJJVX2LbzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpkiq0P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4781BC433F1;
	Wed, 24 Jan 2024 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706101243;
	bh=/vkNrDXpJXxQEVwMKcAclY2ef9tG0/Qkc2+hembTXCA=;
	h=From:Subject:Date:To:Cc:From;
	b=cpkiq0P86Glwwo7ls0WM5gModHbtdp4TmSOjkZn7aXDO0zVmejAX6wD4sRs1eydx3
	 mJFjxtsYMuFaf/2426+kX7XEKC8rPCtfecdfEutJAGG2rDivi721407YI+8d2XydUp
	 zByS5e0/VushAH7CZbd3aGOtzEPTrHx9NpmExnoaBAzMCJb4qVBSLZSRh4Mv+cfjjr
	 K0cR9bceHwscAuTAfGi0CTqp3HbSIEpNFxeXBpr23Qr1+e1d1ND3QLYxKFEt+Te3IL
	 7sH97TipamMFpf/ZvDra8hhfjhCJ1AUtARsVcgAssGWKFvFiQtzqmyBIzU0JK08q+l
	 CjwfX5FKZBUgA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/2] kselftest/seccomp: Convert to KTAP output
Date: Wed, 24 Jan 2024 13:00:17 +0000
Message-Id: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIJsWUC/53NvQ6CMBSG4VshnT2mPS1/Tt6HcSjlVBoUSEuIh
 nDvFhIH46KO7zc838wCeUeBHZKZeZpccH0XQ+0SZhrdXQhcHZshRylQlFApaANd7UhhhEDG9Lc
 BKupMc9O+hXbUA8g0z7gsUOa8YFEaPFl3315O59iNC2PvH9vpJNb1N38SwMGWJSEWmRQVP7bkO
 7rue39h68GEL1RxgfgdihHVVAuZkyatxAcq/0BlRPMiraxVhitbv6HLsjwBkLK/H4EBAAA=
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/vkNrDXpJXxQEVwMKcAclY2ef9tG0/Qkc2+hembTXCA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsQn3ZgOre9hm5oZQLIzXFo6+XtyVqivfhysaNEtc
 /6uyumCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbEJ9wAKCRAk1otyXVSH0DkFB/
 0bfy6SCjD0imEgAhIiyEUF+LhZpSIr7GV7U1uwQPwHCpwLxP1eD3JRpcyOHCBDpd/84ozflKE4EbzD
 bSCZ5dxJCAASx1ZKc0EDYEE0h/LzC0U63kC+rr/48ZU6a2+qrq/50YoUmXqYf7JokKokpvVJIxWCuS
 6mOlPkxTikR/6YFogHKlScGhLagF4bwvBUqKo1pxjBO9V7lENqltFsxErnfe2HlBAdr0GjbNSd0pm7
 yR1TDRaMO2I0u8KiGpA1g6Br8ozny8QQgWct+AfTM54+yF01I5hCSbLxgXkN2pH6DmCBLWUJ2w/fYS
 XDdSRCYBDncwoQKgR2I8RWRyya7aLY
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
Changes in v4:
- Silence checkpatch noise.
- Link to v3: https://lore.kernel.org/r/20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org

Changes in v3:
- Re-add signoff.
- Link to v2: https://lore.kernel.org/r/20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org

Changes in v2:
- Rebase onto v6.8-rc1.
- Link to v1: https://lore.kernel.org/r/20231219-b4-kselftest-seccomp-benchmark-ktap-v1-0-f99e228631b0@kernel.org

---
Mark Brown (2):
      kselftest/seccomp: Use kselftest output functions for benchmark
      kselftest/seccomp: Report each expectation we assert as a KTAP test

 .../testing/selftests/seccomp/seccomp_benchmark.c  | 104 +++++++++++++--------
 1 file changed, 64 insertions(+), 40 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231219-b4-kselftest-seccomp-benchmark-ktap-357603823708

Best regards,
-- 
Mark Brown <broonie@kernel.org>


