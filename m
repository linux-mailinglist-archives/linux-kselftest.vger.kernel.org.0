Return-Path: <linux-kselftest+bounces-12722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60B916FD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7091C25D10
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1317C7C5;
	Tue, 25 Jun 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io9S9UFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F517C7B5;
	Tue, 25 Jun 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338748; cv=none; b=NLqvnzS6Xig0BQXqJUrn+Jt4HgzdRhCDTDkNH96vxR8Usa2ShTSFD+R9NRpcqDfw5evE2+heWDE+rCoOW5NB+qJYkZFT2K3q3NslgTQ1JhAxZ7t0y9PH9ZXuRxqi3EMupLK1hJHZZMfiCzAFrVoL+GnEVgDgCPg/TvKSBJtwaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338748; c=relaxed/simple;
	bh=lD5FdO0GjKR1qAYavsvEm7e4xnZladhl0pTurzLbRRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaOeJ0mFY3ul1WSA+BaYvJfGBiX83qtZaHrZNFmr7CMOU/4yt2uhQdpYQ5IA456riA8kNItalqSTUHjCsu+mMPCukvqQF4LTi5njLxA/BRJ1bdmZNlRP/NrxJxSZcs9woRJUUv9tv0x3d+WJ1qD5TBkW58Q7cUspMN/XpbDxN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io9S9UFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F431C4AF09;
	Tue, 25 Jun 2024 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338747;
	bh=lD5FdO0GjKR1qAYavsvEm7e4xnZladhl0pTurzLbRRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=io9S9UFUNH/oAQ5pEtWW2n7hXGpqwhp/fGIEQ4TEsD4moQYtEuxh0rGfSwoF5dlKh
	 81yPdqkG+YR8pdg/Kq1VN3ax7i2owrWD++iqCGuVwBYMUVg+OInJZTEMAB5xNO3UBg
	 U+mrLmHEBEBv2kSmO6f3OhnpgB4CjL66fiWDyqPkTPScI0gkkgGgA0FL6sXyxYke8/
	 1lowHFMMg3OghChgQjYcU4uGdU0Y+ZPMG3a8kJHV7Lmf4cstkUry4Tk8XCZbO8fiMe
	 uUAAzjhMncsMCLLFF7tjPxWQwEupciLGjdlqz3idRAaJ218xGX1pWiyOMmXaQXNaBX
	 l0XLTgdhNjuGg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] selftests/damon/_damon_sysfs: implement kdamonds stop function
Date: Tue, 25 Jun 2024 11:05:35 -0700
Message-Id: <20240625180538.73134-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON stop function on the test-purpose DAMON sysfs interface
wrapper Python module, _damon_sysfs.py.  This feature will be used by
future DAMON tests that need to start/stop DAMON multiple times.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f975742f29b3..17352b9d204d 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -406,6 +406,10 @@ class Kdamond:
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         return err
 
+    def stop(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'off')
+        return err
+
     def update_schemes_tried_regions(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'state'),
                          'update_schemes_tried_regions')
@@ -511,3 +515,10 @@ class Kdamonds:
             if err is not None:
                 return err
         return None
+
+    def stop(self):
+        for kdamond in self.kdamonds:
+            err = kdamond.stop()
+            if err is not None:
+                return err
+        return None
-- 
2.39.2


