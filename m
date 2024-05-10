Return-Path: <linux-kselftest+bounces-10000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A08C217A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4361F21F0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31216E890;
	Fri, 10 May 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QC4d2x+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6516E880
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335114; cv=none; b=iO3y4JoQPmIN0aybihUQ8Z68C7Wk0QXHgz42hkiwCIgUg+Do8N2bN5Tu+g87IulVeFw4sfLd9Isstt6tOcusoV8yFsLOrAeREZd/BA62Z6fldxK9R3KaaPaU5EDtmcvbhJnpUvLC1MeS+hWcRnRddGZf+V0slKHcUZjLMXoCaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335114; c=relaxed/simple;
	bh=n56aSoeaesxhZLXjh7komGxYG9xTu0UlluiOU0myr0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXI/hLqoI2+IP8cVBH/EKcwRGqWQ+q0Ce/x5lBVh7zdf6g+/iem+p6EhY5sFm+J7vwR+FxwSewjdgSISRlEsHHErma5qvUuGRmkJMYj/9H5SzA1J0B5Q6H8AmUvS8/31+XJmAlT+917+PBQadLWBaVxZPbR6ybhRsfkZVjzQZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QC4d2x+U; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715335111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nUhuTP23hsrziqOf8yd0GU1qZX9RbuetxzNfweNTAA=;
	b=QC4d2x+Uvb42OVN7atGAVYtug+FQ6KHIlk74Fp+4qQRTfZD5y9W9cKP+/1bCIje0Sg9xW6
	/DOWweToYjAI014yjmDNMbdcZ2KaAQjh/PxdnETXBOWIyynRbnwMn8mdJ4mFp0GYyf2XjF
	e7PgIepQrPjCSDK9lkGbtseXH7HFWAk=
From: kunwu.chan@linux.dev
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add a null pointer check for the load_btf_spec
Date: Fri, 10 May 2024 17:58:02 +0800
Message-Id: <20240510095803.472840-4-kunwu.chan@linux.dev>
In-Reply-To: <20240510095803.472840-1-kunwu.chan@linux.dev>
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

There is a 'malloc' call, which can be unsuccessful.
Add the malloc failure checking to avoid possible null
dereference.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index df04bda1c927..9c80b2943418 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -762,6 +762,8 @@ static int load_btf_spec(__u32 *types, int types_len,
 	);
 
 	raw_btf = malloc(sizeof(hdr) + types_len + strings_len);
+	if (!raw_btf)
+		return -ENOMEM;
 
 	ptr = raw_btf;
 	memcpy(ptr, &hdr, sizeof(hdr));
-- 
2.40.1


