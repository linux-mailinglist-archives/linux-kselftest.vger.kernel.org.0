Return-Path: <linux-kselftest+bounces-35384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81216AE0D06
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD2169202
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B523B607;
	Thu, 19 Jun 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYUOGLPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A117D2;
	Thu, 19 Jun 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750358172; cv=none; b=rtnYWjonN6Q0V70xaekZ4DmRr4v3hoAREdVTxgpaNIUFylJfHmRaPUemg5l3bwZ7LAuRj6L3j298q2mOLgdYGY+OEabk8oASHxrsOKVFZXDbdWnu2EeAxzCCwszmAuKi8yqzRPDsCLpqnK5i5qFSBUkdrM+98m/rEM5T4FWCQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750358172; c=relaxed/simple;
	bh=WsaNlTsPKbwW1LA0IoyQALMLAOiw40vo3RwoI/57mP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iV8ohHvVjzBSK3devKVnwn9r+4Xi56REARH815EKp23XDxxKu37D074L+nRCDo2LTz5jsPLtQ1LZomIFfLUqRAQR38ai0MeQNjeOReBOB20Jm7r72jjJ6IGC1NbKy9iOq9b/Ypvssn+2/0qB+CwLeBglMY2+QCA2VBSrYGlxf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYUOGLPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6FC4CEED;
	Thu, 19 Jun 2025 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750358172;
	bh=WsaNlTsPKbwW1LA0IoyQALMLAOiw40vo3RwoI/57mP4=;
	h=From:To:Cc:Subject:Date:From;
	b=iYUOGLPINT7v2eZ9EfUO7JoqJdLRVd5Wdo/snAnY8of/vlou0/0qj7XZ3THZYByxI
	 UMSah//Kdrq/NMOr5MqIt8PVvvq8wUyJPRta7Iq8h8SRvI+VsyKUsBsClzO6PaBtTH
	 JNlO/lXhR8MxEal64AhpGP7ZHVCs/3yXYBM81jjWtV4zHXxsTiCEihuUloroTBU6Cy
	 yig6CC0dUcv286ggwZKWGvwOJcgeGmUIe7ijQgYAfVUh4ps5f1Gzf2IR6jmYMmGkMl
	 NoOH1YLlcJzyApt1kmcCQKCxn7+TfA1xygXAsZFXX13HatyPQsSfkyQquROySnDJtL
	 S0Z6HdFk26i8Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, #@web.codeaurora.org,
	6.3.x@web.codeaurora.org
Subject: [PATCH 0/2] mm/damon: fix memory leak in memcg_path sysfs file
Date: Thu, 19 Jun 2025 11:36:06 -0700
Message-Id: <20250619183608.6647-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can leak memory by repeatedly writing a string to DAMOS sysfs
memcg_path file.  Fix it (patch 1) and add a selftest (patch 2) to avoid
reoccurrance of the bug.

SeongJae Park (2):
  mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path
    on write
  selftets/damon: add a test for memcg_path leak

 mm/damon/sysfs-schemes.c                      |  1 +
 tools/testing/selftests/damon/Makefile        |  1 +
 .../selftests/damon/sysfs_memcg_path_leak.sh  | 43 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_memcg_path_leak.sh


base-commit: 05b89e828eb4f791f721cbdc65f36e1a8287a9d3
-- 
2.39.5

