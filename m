Return-Path: <linux-kselftest+bounces-46197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E27C778D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 07:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF735B7D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366913002A3;
	Fri, 21 Nov 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGW1sMYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A02D979B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705706; cv=none; b=ZU79L0/UOyVcDE5VcegBqzoLbq/NQUBpmSkHy9MDZmS1C9DmKAEaXIlvLDtcf3C7+TsNxGlWu06urAOpDdfSSpD4WNIvxdFfWRQj7yyIoDzOUxlaj0CsvWvRfDUU1Cj6DIdpzzgGMY+8oJSNtXq4pblGtW7hxpjhiJOTv7+0SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705706; c=relaxed/simple;
	bh=J6yts0692oNbckDHoLvXs4DMBmIkVVG792DZoIpyafk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRBjfdS/UIDMMtNMA6n9+qmp/muTj0zLaA1lnlE4kh9/nSvj0uICpcqIYpsAUngGONqHIOjUbNQ+VPSJNmHz2RCwqSmwBTkKsNFFnILIDZMqwjrf2PiSoLvl7+FxIpKQWpKWyZmRwf/tkCkPLrw7owXLSjoYk+nucglEZzTVa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGW1sMYH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29568d93e87so14811795ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763705703; x=1764310503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J++f67xZUroNSU3sM+QK10kr9uNblSA2E0GGy7o7wA8=;
        b=dGW1sMYH94IcTH09MTQYbRNCZcHfevXNz9a8A7hCXZejcuXqEnpLJQCfOTlsivRzZH
         WV/FaNq3Wx0IHOd8DVbW1FWAqZQ80L6ONMr1zXyjEl1E1D0NCNzgjhxDIyV/OjVv3QEl
         FEpKTG4nSYM+HpCgfjUX2lMSTAyicWGSRFO7UwR97cWzo6XBuldNpF2PW2suvDeAq+qo
         V2U19aU8gwg/+xfxTlal4MhXIl49vOzwxCZnwtrKxAQ8f/bOihWUDA9kbtb2trOvuzQh
         3bw5MPsTOldsfOhVK2McX8exs06fOMawy+XVphNDJUsJt/NaD7szi/oJspgZsW5n3QUG
         5BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763705703; x=1764310503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J++f67xZUroNSU3sM+QK10kr9uNblSA2E0GGy7o7wA8=;
        b=P448V8LP9OWqkRPViNVKJHaAdGORvaAmSD6F7IXf2sd02X3PjOYDNICv0vVX90Ohg7
         NtA7yjrPnzqb7XoK8CqKpyuejJfFE8hvg0yxHXa/nDJagQnDPYsqyAkaJfbxLhIYpQYK
         F877VccGWyik3q79VblfmpUYUj+AtGwLyRgZOls7FQWHhJwbgHLTb2bUUIBXneasDT76
         X9hxmOloYXhEl0SbANXiJNlUttfH2De92j3L4S5rz/+4WVpj7vrDzmJ2AexxCgk4DLZr
         cz9DXCXMLpfBjLWgWYDOaMO2Zn3DqGbdyw9pjmtSFxKwZHGSNE86HMsOVl+R6XoqeOar
         HqxQ==
X-Gm-Message-State: AOJu0YzNkLjdArnrsjp/zC3EGyLzoIKEm+pdQQCmyCdiXudcR2DQ4SLy
	3bZcEzmaqBH9bEUaitxGlm4vGOkM4HAW73osR+W0zD4I6XfvhkLZydun
X-Gm-Gg: ASbGncttZE7v3HgPDIlXfyIe2pep4S7EIQflW0EJ4zlo85EthyFI7AEPENbhl59D1/C
	uPgZ1r1c554ite5OuhZTy+RTRMcPRHc2h87+ppmQmLmWnZ4tiTv4+V+kRCCMBcHmelDMGB7LuCm
	SSmnt1GCBY61tloSTdvo4Dq4iJkyqI5LTDA0OpvfGOGEnTfR0Bdne6c8RRf5tzh2nM+Bp2+x9A+
	VtUkRYVofHlUyS/Dkdz4g0vmkfVh3rjuhujQxLIpNd9w/swR08Ab3exOTgmGfm+UMNrnbv2xq/l
	q8BtKvzoCCgRVCi85DrijAkRymoPiOYBGO3wjKGQCoV03uHkD+8BEf2wYipgS4JiVexp/+UnwbJ
	seaivekWT0aAmjq77kPT5QNONzUlhE67Iz/1++xxBtEqyguB5+gp1anoO60ng5pcZzgnqwxfbt2
	FIs8Z7blQ8ASvwpeyNg7Jt7QDGTU6G6k2zWE4jIgZjzIAlYCOljQ==
X-Google-Smtp-Source: AGHT+IGNCWomOCLHFwn5qGPrBhCRdd2z+rGyb+/IFjbvf5UbLDSOe/YqRxvRuvSTizY0g3yfCUjWPQ==
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr16162625ad.42.1763705702714;
        Thu, 20 Nov 2025 22:15:02 -0800 (PST)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ae1c3sm45561315ad.92.2025.11.20.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 22:15:02 -0800 (PST)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf v1] selftests: test_tag: prog_tag is calculated using SHA256.
Date: Fri, 21 Nov 2025 14:14:58 +0800
Message-ID: <20251121061458.3145167-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
changed digest of prog_tag to SHA256 but forgot to update tests
correspondingly.  This patch helps fix it.

Fixes: 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/test_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tag.c b/tools/testing/selftests/bpf/test_tag.c
index 5546b05a0486..f1300047c1e0 100644
--- a/tools/testing/selftests/bpf/test_tag.c
+++ b/tools/testing/selftests/bpf/test_tag.c
@@ -116,7 +116,7 @@ static void tag_from_alg(int insns, uint8_t *tag, uint32_t len)
 	static const struct sockaddr_alg alg = {
 		.salg_family	= AF_ALG,
 		.salg_type	= "hash",
-		.salg_name	= "sha1",
+		.salg_name	= "sha256",
 	};
 	int fd_base, fd_alg, ret;
 	ssize_t size;
-- 
2.51.2


