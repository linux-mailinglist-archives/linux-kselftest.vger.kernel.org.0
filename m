Return-Path: <linux-kselftest+bounces-31666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C6A9D562
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 00:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40B09E0BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E829008A;
	Fri, 25 Apr 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQWurkxS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2528FFF9;
	Fri, 25 Apr 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619581; cv=none; b=lvv1w4BBphWJ/Db7KeANcxkBqhSXfaifsuKqRb21D+IK5WqeYLoQ4S/3btas4XeYEwizUkaE1qezUHJDUGPb4c8z4DGi+XGoXX5fwwgWXb5a2hVY/M0+RsJnKbxoLLAdc8pa06qDozzeePj0BVCV8xvieyD/N03YD/DjRUXsNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619581; c=relaxed/simple;
	bh=1pwExWgzQErCNQpG3IK9AR9oyY6nKXm+lJRSU+lGktw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=koapWcVnolS9oIZe3XyQoRIiFna9EIQ4Fl4gsdBYhVVZ6sbNA/F3bdYefy2iXAbgetQpsrYOL84uG+y6LAAxexh1C+UPLGSje/C3+TDws24OWDMjUnyTUhn+hEt5/T0kN51NeYCYJV3mv53OZUwcOOirfrqzsOrSeJEtanTYGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQWurkxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52299C4CEE4;
	Fri, 25 Apr 2025 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745619580;
	bh=1pwExWgzQErCNQpG3IK9AR9oyY6nKXm+lJRSU+lGktw=;
	h=From:Date:Subject:To:Cc:From;
	b=nQWurkxS05sNgzdnf0RW8zEdnoFaCTBD985ecBJa0eiqtG5dNbVg+dzxthbK0RVet
	 znj3yKgZzJFZDllRGUljS/xgCVF5/YhcM/xZF7TsZ+Q0ZBoyGJPV4LUl3RP6BfQ7/W
	 K9igGWa8EyJuLIv4v8L4a5FpktEtG6fGsVjDaA/lym8ORbnYunNGPijZEbVOdhxAQW
	 dCLMrUsv7Dix0kxsVqoeBswgwZGYCrlmuKi7ZZAxjtLuliAvD+YDZSqj8qCl+BjHpz
	 Cd+2A9yzinIot4ReDIkWv0ALzqP18Q99q7oqfGAZvJyb4PT4uXiITlt/CbtCgQ7jtb
	 sCHunmNDmQ/eg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 25 Apr 2025 23:19:01 +0100
Subject: [PATCH] kunit: configs: Enable coverage of the bitfield packing
 library
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-kunit-enable-missing-tests-v1-1-263391818e76@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFUKDGgC/x3MQQqDMBAF0KvIrDsQUwXjVUoXqf7qYDuWTFoE8
 e6GLt/m7WRIAqO+2inhJyarFtSXioY56gSWsZi8861rvOflq5IZGh8v8FvMRCfOsGwc6i4A4eq
 GCCrBJ+Ep2z+/3Y/jBJ98XyFsAAAA
X-Change-ID: 20250422-kunit-enable-missing-tests-9189ee930cae
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1pwExWgzQErCNQpG3IK9AR9oyY6nKXm+lJRSU+lGktw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoDAp6+lP6/ndCW8ZI2tXyIFYRXjlEQ0Zu2sJoStoo
 C2ggJbCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaAwKegAKCRAk1otyXVSH0Ij0B/
 49P0xPGDljkPpfc1s5fxxrfeU0z8QYeyQ7oIIm6/v/z1wfYh5oKrF8lOeL3D17+XAkE6ysVpo/lCjc
 3sk8cncoI+WjN9mIZpm5MGenYjfqD5TjBIGuuV/r6eNIkuiR6Xq95qp9VPqYMJf6gT/alvX4TQJjiJ
 IsnuB5riA0O5cqa2izqbenxxr0/nmSCbXICDKb79NX6WvFSNDQFfbe3xkSiM7VVNCnzDiOv4nvhhoU
 jKr0ksI90E1FSAA1q2/0cwFpuGNynIO1wycrV9/bhzIq+XkYxgeJmKl1pHolOX77dtUNm7BlwF40uv
 PoUCiaZiKumDOezHIWXIfxsZlMLv1B
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are KUnit tests for the bitfield packing library but these depend
on CONFIG_PACKING which is not enabled by anything in either the
existing KUnit all_tests.config or the base UML config it runs on as
standard.  Enable that in all_tests.config to improve coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index cdd9782f9646..b0223b7aebde 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -51,3 +51,5 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TOPOLOGY_BUILD=y
+
+CONFIG_PACKING=y

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250422-kunit-enable-missing-tests-9189ee930cae

Best regards,
-- 
Mark Brown <broonie@kernel.org>


