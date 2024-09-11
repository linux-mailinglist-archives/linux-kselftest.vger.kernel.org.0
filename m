Return-Path: <linux-kselftest+bounces-17759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F7C975864
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B52D2820E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB211AED20;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D211AE872;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072074; cv=none; b=Typ9tWU4YTLVjCwSe4blR61xoH9hzNUddA5HsOOgmOjvBxbor+ztzb7CbBYol8NvGrqA7kC6HYTrG4xKSc78oGu4jq3zO5NVY9SMTxvi/xFLmczqZDlK2XA+hYLMzyEsQBAcUR03xLJPoYG9viB1U6QAdi6/05ruJEvq8hl9C+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072074; c=relaxed/simple;
	bh=ZFJfTzhPGixix/FXAVt9zXGX6aDUZXjke7xQwKyYC5g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SvTJ1JPhVvu4r6iR8UR1QdOU1LwMfZLrk55D07CApweIURFqxRUyiztufj3TSI67dqKFb3qgVXQ9VxIXoV0GiRO8QAkUjh/XJT0dLiZGB/Aefg66jBqKZkh8D2HLnqH6+GrMKneZHLwBhoubUtvewoOlCx40PdWH/3CNXTJg9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1882DC4CEC7;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1soQCE-00000000fah-09YW;
	Wed, 11 Sep 2024 12:27:58 -0400
Message-ID: <20240911162757.900621117@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 11 Sep 2024 12:27:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 1/2] selftests/ring-buffer: Verify the entire meta-page padding
References: <20240911162729.318348827@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Improve the ring-buffer meta-page test coverage by checking for the
entire padding region to be 0 instead of just looking at the first 4
bytes.

Cc: linux-kselftest@vger.kernel.org
Link: https://lore.kernel.org/20240910162335.2993310-2-vdonnefort@google.com
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ring-buffer/map_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index 4bb0192e43f3..ba12fd31de87 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -231,15 +231,15 @@ TEST_F(map, data_mmap)
 
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
-		void *addr;
-
 		data_len = desc->meta->meta_page_size;
 		data = mmap(NULL, data_len,
 			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 		ASSERT_NE(data, MAP_FAILED);
 
-		addr = (void *)((unsigned long)data + getpagesize());
-		ASSERT_EQ(*((int *)addr), 0);
+		for (int i = desc->meta->meta_struct_len;
+		     i < desc->meta->meta_page_size; i += sizeof(int))
+			ASSERT_EQ(*(int *)(data + i), 0);
+
 		munmap(data, data_len);
 	}
 }
-- 
2.45.2



