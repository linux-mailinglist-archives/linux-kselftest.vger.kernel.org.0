Return-Path: <linux-kselftest+bounces-17760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923DD97586A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11970B29FA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61991AED3F;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64211AED30;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072074; cv=none; b=H3Y/xPVKtbKxx62GfWQ4hTHJlpv215RMHoY53TAO8Od4BXUeHxdcBmtpiSxriqeWch7VIPHd90XRnj4PiEd3O8YxTXwlD4ghOVy4izZgHHzd8aU6TN2THynUPiD99nbhKZIUF6/h70Nqviv8X8+Wi8r+J1nT9HPLpWghu3gZPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072074; c=relaxed/simple;
	bh=xrnqH8JWFQ3s5GTxCs9Mt4bGaZQLLtjEgwLPCPjKXmE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pGtqkHYKmMBgesHKbbMsW/g39R00TKBRaWPx/eikjvm2YxePnYBe6r6Jg6YwMaYTkpPTHcNZbfi+oZ6c+LJIb+M4eYXRkYs3XrIbW3qiARi0z7NwzRINyvax8zqF1caIrplR4mRMp8lT2fAZV5Irnz+d3nJLWtu+u5OgZHP3mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D150C4CECD;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1soQCE-00000000fbC-0oVO;
	Wed, 11 Sep 2024 12:27:58 -0400
Message-ID: <20240911162758.056529108@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 11 Sep 2024 12:27:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 2/2] selftests/ring-buffer: Handle meta-page bigger than the system
References: <20240911162729.318348827@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Link: https://lore.kernel.org/20240910162335.2993310-3-vdonnefort@google.com
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ring-buffer/map_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index ba12fd31de87..d10a847130fb 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
 	if (desc->cpu_fd < 0)
 		return -ENODEV;
 
+again:
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 	if (map == MAP_FAILED)
 		return -errno;
 
 	desc->meta = (struct trace_buffer_meta *)map;
 
+	/* the meta-page is bigger than the original mapping */
+	if (page_size < desc->meta->meta_struct_len) {
+		int meta_page_size = desc->meta->meta_page_size;
+
+		munmap(desc->meta, page_size);
+		page_size = meta_page_size;
+		goto again;
+	}
+
 	return 0;
 }
 
-- 
2.45.2



