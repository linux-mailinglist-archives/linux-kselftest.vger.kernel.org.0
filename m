Return-Path: <linux-kselftest+bounces-12787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF049180D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE4C28AFB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182B181326;
	Wed, 26 Jun 2024 12:19:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AE17F51C;
	Wed, 26 Jun 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404354; cv=none; b=uTOKvZ+NcGHYOZYbChiDaDwnCojjim67N6mbHNPXU+b2C/7qTVXMUQt2BbuoqlYqR2t0L7vSYIIwVUbOFb3TF8qULe/zEnm07awb/3MMQe/dsD2P0kr3GNmqJygN7xusMCu4NlL0Si4/YotNe5+H625LFZIf5uQlLeg5wXRCSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404354; c=relaxed/simple;
	bh=wnVtmWQ6PmYLBeKxwt/VIXua22iiG221nO/TfX26YHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YF8BvUsSYvQxzk2+KXbdmE3YThSKbKvXYUvBekjMXajYOS1tQfEfT2C+dLtaAoNyy5iYCLEZcnMeFyMezXrohy10EoGGwcrdv2eJMl0hpjLAkASYhiE+NkQyP3lHFReE7Bz2vHRINBJkX+N9GJ/do8D05Dsjww/RwJH+YHAobH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABXeiwWB3xm0Y2VEg--.247S2;
	Wed, 26 Jun 2024 20:18:41 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
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
	shuah@kernel.org,
	make24@iscas.ac.cn,
	iii@linux.ibm.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: improve file descriptor closure handling
Date: Wed, 26 Jun 2024 20:18:28 +0800
Message-Id: <20240626121828.2859797-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXeiwWB3xm0Y2VEg--.247S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4ftw17uw43ZF1kWryrCrg_yoW8JFyUpa
	y8tw1jkFyrWr17Jr18Gwn7XF10gF4kJry5CF47tFy3uw45XryxJF1Ska15Kr95KrZavan0
	yw1ayr9Ikr4DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUeVyIUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

serial_test_fexit_stress() has a non-robust handling of file descriptor
closure. If an error occurs, the function may exit without closing open
file descriptors, potentially causing resource leaks.

Fix the issue by closing file descriptors in reverse order and starting
from the last opened. Ensure proper closure even if an error occurs early.

Fixes: 8fb9fb2f1728 ("selftests/bpf: Query BPF_MAX_TRAMP_LINKS using BTF")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 596536def43d..b1980bd61583 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -49,11 +49,14 @@ void serial_test_fexit_stress(void)
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
 
 out:
-	for (i = 0; i < bpf_max_tramp_links; i++) {
+	if (i >= bpf_max_tramp_links)
+		i = bpf_max_tramp_links - 1;
+	while (i >= 0) {
 		if (link_fd[i])
 			close(link_fd[i]);
 		if (fexit_fd[i])
 			close(fexit_fd[i]);
+		i--;
 	}
 	free(fd);
 }
-- 
2.25.1


