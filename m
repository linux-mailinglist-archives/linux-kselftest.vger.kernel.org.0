Return-Path: <linux-kselftest+bounces-43180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7435BDE794
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E0A3BD492
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2221E515;
	Wed, 15 Oct 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0ewttuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8135D531;
	Wed, 15 Oct 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531477; cv=none; b=ttgdTtLaJoINYnB378E5i4nlo60fDhEnQRxwKORKGu3AS7klvrqkZRnRzwMk6u2YXIegLzgxHx927anwJm78+1TOH0U5858MZOvu6B+J2D7RWEMpl956XOE/ZrraNJxC8QQUfthiIdCWvUbF2TH6kfuQyHXrSjXJPuKBqpRW04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531477; c=relaxed/simple;
	bh=0DoYYVxgoCw/gI8ffEygf52guZZcAcTGzDGtZona5vg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZGrHyHusxlzl527hbu3Ztc+fSqCEIXtgeHNd/RdCw+sK+FgVTCQUIFe5farcbTxCQ1EJuLnjd8lQOWYfecpZy2Tc9dNSg23hZDi5KWkkMRpCf9IeyTbfOht71FG0E42Bb6c0hA0uT3R7J1uavTK4egfVi9rXRGb8nEv9Ec26b4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0ewttuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC0AC4CEF8;
	Wed, 15 Oct 2025 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531477;
	bh=0DoYYVxgoCw/gI8ffEygf52guZZcAcTGzDGtZona5vg=;
	h=From:Subject:Date:To:Cc:From;
	b=q0ewttuuIEky6m+lOYxhuJKEaLIYLQlwxq3GhQMszO2OOzk+vY1sjDPGwE1A4Uy+4
	 FJ3or/WAE1/stK5PX9UlUz0g2LJfdsUJihjg2veu8xhR2zGUJzY4cEblfP6ppUYraj
	 /ItLFdb8N+R0XqaZOZnyzPrq8OBfRmtT/H8DlQW02W+IairnKSbsoYJEt0DnR3Z/ya
	 j6eyD4vKSwCngGbrH2jSr7Ph2Fo7SBqS4Dt474SDO/GOpkDOjIqu+KRRQgNPRN1G/E
	 eYWyKZyI6ld/0l4VAhMWUD5C8tvBjycUPq6/9fJHkhpWYU135KJhAfAyl4IKzrmTNK
	 Ff9isvNx00Grw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] selftests/filelock: Make output more kselftestish
Date: Wed, 15 Oct 2025 13:30:49 +0100
Message-Id: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmT72gC/3WNywqDMBBFf0Vm3SlJan2t+h/FRdCJDgYjSQgt4
 r83tesuz4F77g6BPFOArtjBU+LAbs2gLgUMs14nQh4zgxLqLipRYiBrIoWIhi1ZNyy4RL2hUZr
 attFiJAF5vHky/DrDzz7zzCE6/z5/kvzaX7KRzb9kkihwLKU2dW3kra0eC/mV7NX5CfrjOD7uR
 u3rvQAAAA==
X-Change-ID: 20250604-selftest-filelock-ktap-f2ae998a0de0
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0DoYYVxgoCw/gI8ffEygf52guZZcAcTGzDGtZona5vg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75QNKj12De4v44uEsDIAampmni+FuZNYB0plA
 T1VQ6iBwDGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+UDQAKCRAk1otyXVSH
 0PK3CACFrDX38e9548p9XjmWA0/MhvpghOAaftKQ/iXSyINbVNjTTk3vwin83S1AeLHBVuw6CE2
 eiHvr8HDDotjot4sPVBNG4IUbmStrI+UhmxaBptqTXl/oYY+pGnok5i/swk1uXvt20DNa4Hd69c
 I2wuaMMqHY7XD8dgvw/qiIM07qYbx4RzRkdliSX6/VMmhVv7Y7OjXJJxBkBwJUPbER9bPjiYhW4
 9f8uIJ4sE1s3SJ6dCqYoIKeq0xNXjxRRYjxLDNbo56z4ffi+eVKBTCIGud5eVr8u9JSf1W9o//M
 Zx7CDL0NykjD7/CZXE+DPnMgRXmL405IWwiBr2ZeUuEgsbyU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series makes the output from the ofdlocks test a bit easier for
tooling to work with, and also ignores the generated file while we're
here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.18-rc1.
- Link to v1: https://lore.kernel.org/r/20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org

---
Mark Brown (3):
      kselftest/filelock: Use ksft_perror()
      kselftest/filelock: Report each test in oftlocks separately
      kselftest/filelock: Add a .gitignore file

 tools/testing/selftests/filelock/.gitignore |  1 +
 tools/testing/selftests/filelock/ofdlocks.c | 94 +++++++++++++----------------
 2 files changed, 42 insertions(+), 53 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250604-selftest-filelock-ktap-f2ae998a0de0

Best regards,
--  
Mark Brown <broonie@kernel.org>


