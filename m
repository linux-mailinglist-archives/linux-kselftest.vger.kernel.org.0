Return-Path: <linux-kselftest+bounces-12843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A688919EF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 08:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7981F23F14
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337821CAAF;
	Thu, 27 Jun 2024 06:01:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC317550;
	Thu, 27 Jun 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468078; cv=none; b=PWZAcw9wpx9En8zwNq9TFQ1ZHNSiKXmCxkU4CPlGegEW012JxtckhmNP67dtM4+OODpChrWfSPyY8Bzjly0M6REDeNXCa1PNE+uRI8yxw7gat4eVoOlFjU4ncI6BUA2sW7y8GyjVBnN+52Jrd0EfcULuBf9+4CrPSrGKetjnfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468078; c=relaxed/simple;
	bh=U+ddQlhWR49fZqXuUZD7m2O148KFGP46ZGttjUuxy7k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YbeWb6tCS4zVg5ZC8yKrrfEzJeX+dFSVbQF9Z1F+Z0LEWhgZr5MnlzOs1KXQbhZe2OmI80DjpkTIqvNO1fb5DX3NfBumzuDYHu/hElcFVeXl8pV/0GsNwqqimTtFXgLbNrtc7F90irdBExM0Owf22GQhUi4ZcSu1qm8D2oV7n9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5667d00250fb-889bd;
	Thu, 27 Jun 2024 14:01:09 +0800 (CST)
X-RM-TRANSID:2ee5667d00250fb-889bd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6667d0020ce6-c3da5;
	Thu, 27 Jun 2024 14:01:09 +0800 (CST)
X-RM-TRANSID:2ee6667d0020ce6-c3da5
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: ast@kernel.org,
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] selftests/bpf:fix a resource leak
Date: Wed, 26 Jun 2024 23:01:07 -0700
Message-Id: <20240627060107.8682-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The requested resources should be closed before return
in main(), otherwise resource leak will occur

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index a34e95040994..03d5dd617c4a 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2092,7 +2092,7 @@ int main(int argc, char **argv)
 	if (err) {
 		fprintf(stderr, "populate program: (%s) %s\n",
 			bpf_file, strerror(errno));
-		return 1;
+		goto out;
 	}
 	running = 1;
 
-- 
2.17.1




