Return-Path: <linux-kselftest+bounces-15738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53B957B79
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 04:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AADB224D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2A381BA;
	Tue, 20 Aug 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="radG637o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446F22318
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121339; cv=none; b=dRQa7P4MMEdhZaYt3IZo2Yp476bxJu/i9Hrm7cYB7GaLA92MCjbUa7OgnJXrX4qCk+YtJ2zihwvZwjgUneag1yO9DbjA7ZpqFJbq3nVVBlop2PG0wdl/fLwOgy382Wb/z8cdlrPeyiSztPBdbjL37MpBgrMj4/CRHdAdndsY2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121339; c=relaxed/simple;
	bh=3FA+zhY3J2aurdG8ymeG/8o1uucMCSTevRTGmf/g0j8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CrEhjfeqOc5S+xbFGAbLw7Y33gOgxh6d1TOrqzEDsAeassxLsRHyAu3N7YkWH6TiVRxlShImTSuPBE5TXdAjMNzBj9kATYL0vA8UDterMkQkN4TdD3yZ9mDbQRQ3H52waWOwtHHj7Fkhra5w4cdS9C4r/k8d3BlIcLlw3/VUaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=radG637o; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724121335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d3N4eAp1zNkGpAB397euBnf4ls1mgFuOdl80fVhDMCk=;
	b=radG637oDVCDIvt3PWEEmr6brYVRi2wD7sDKaadZcZdaos9DGm29UQRQOhBaxZkyFei8yt
	XpYgTZHIhFpJ7UACs2v2Y20E/WIP2Ig/C1lOjtoPH18y/PXjdgbjXXxrsNGD68CKUUvdKe
	d5hlpai8hxSjpwwhWaF7ehmziJI1QYc=
From: Hao Ge <hao.ge@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer checking
Date: Tue, 20 Aug 2024 10:34:47 +0800
Message-Id: <20240820023447.29002-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Smatch reported the following warning:
    ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 454)

It seems correct,so let's modify it based on it's suggestion.

Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
check in get_xlated_program()") fixed an issue in the test_verifier.c
once,but it was reverted this time.

Let's solve this issue with the minimal changes possible.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 tools/testing/selftests/bpf/testing_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d5379a0e6da8..34dfea295c8e 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -451,7 +451,7 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 
 	*cnt = xlated_prog_len / buf_element_size;
 	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
+	if (!*buf) {
 		perror("can't allocate xlated program buffer");
 		return -ENOMEM;
 	}
-- 
2.25.1


