Return-Path: <linux-kselftest+bounces-34014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D39AC84C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A10F16B838
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F522D9E4;
	Thu, 29 May 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvpJY80f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474A2629C;
	Thu, 29 May 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559341; cv=none; b=YBZoukVsAEw/XiZD+py6a8WfmQWVec8byYWaKocBXf+QLl0PzazYVDh7UxFyoRukytJ96zRZQsVt0mu5XzIpNJpT1rqDXAl6JWsrRtfmIynMtuSwgu60GpAbaUvVLD1uQmAmrpOT5m8hRvyHrtrC6usstlnKHD3+DVlVUuDj1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559341; c=relaxed/simple;
	bh=w3gjafHGRQ0pUvL/vFa3B9mNuehw++fg/Uf9FLi1Ovw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnDIbkkWWPNOhY8UJgd+4qF3fgMBhgDFoahPoxm4dUdhmURJJBO7atFjbLODHt1n0YJcuYo8dAxEnoplHncbp1HIy4TCQ79PSVp/INeHzzb8EZQk0XfDZKFytSdf6cHa/HQYDDmx13AiAKLiQ/ORB0ENaqxQRC9k3OxNHDtECu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvpJY80f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3119822df05so1487971a91.0;
        Thu, 29 May 2025 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748559339; x=1749164139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIxlk/7XXpi/+G/vr1hpiAzjYKjdQamrqkoxioR8Y9w=;
        b=UvpJY80feerxlj7HMSi2Bc0gFRIWZcF6OOgpAxV7Gh4AGGcISpB2/XT3bG0ABkWFSK
         PFhCmrmCR/z7D+8v0dFeUFYEvIVks/d0MH1qGeDw8cyRVDzKfXGP9jKy6Wfzj6uj1zFb
         Xq+fzCfMUDM8Yo/eQDCEShNtPD7rIIsp0JpC04wtlXuSDE5YALBdCJfCvnig73/JCtEj
         KgRzm5clIIeGtZ4azMg6LxFOp243+sUjY3ZqVmiX7t+2SP+uMkRCx391ioH24/HBw8zZ
         NclpfLCW41zysgD2DWtcbL/GF2wrZV/zAjMhMOpHgFGy9KH7ElPiSnes6+EkewHU3Fng
         GOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748559339; x=1749164139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIxlk/7XXpi/+G/vr1hpiAzjYKjdQamrqkoxioR8Y9w=;
        b=QVym5CQPCj1IcTSUO+Llca0zbEO0eq1GNEmubDf1oOhT8y5Vq1681cdJGc/V4Pa6Pz
         4o4k9w/cqQcVr2F0eGMl/rRTylYKkNlrp0ZExPucUw9rxSgdnlrgnG3/yYJc4GhW3omp
         nDMClo1AfJLT7zCKgdb2SzYW0rhGOBKOm4NYp/I0uKBfBsWKq5jmQjQ9KInnhrxlwUD6
         BbWf08O957+ksBXEP855Zqr4NZxUCwXiN2hW6DKwJPB0wivj0BocpG/cWAg2p1fHIgx4
         TZxMxZATztsm/zI/T9H9WxGvL1QNY1t964LyJLwwqBlxk8x1oUR+1BA6jYdK7jYTl2LM
         GW/A==
X-Forwarded-Encrypted: i=1; AJvYcCVoEDQrxabtcKT7BWQ5orxbEgB241hQZkZm/ZhKffaqEvNd23gwQrFb4iuDITQfn9da4Efm+44s++yvBpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHq5DpTLXGVqTv5iguILv5XSOjmS4BMd1cGdmj98B1nwt72XOs
	0c5HYLf9P1eyS3v61nBsVo3+WnXsoK7NXIqpeM0iZObplCiEMjLkWMuC4c7skP8cBA==
X-Gm-Gg: ASbGncsbol85XjxZWKYS0+iksRgPy6tjGmYGlJEp60Ale7plrhaJlALjNDNyjWRFZp7
	i2QU4rcUC40fIEMg/9trYM10S/E5XJLYgw14BK0X7o8kj93/Xcki/6FV/5HlYgUfUn2bTgh6zif
	RmT9SpsUfDjhBAToz9+JN9BlB4+cDyNUdAdKYz1Ge38PcqxPZhaQo0gX0ObMPrsJs6sorwbtxi8
	KUreEMM3kYO34mnf0TdeI36TYICtkb7VfBgR6ZxtgWSz15V9JHD5soctG1EAQ44ONPq1IvTNJQd
	5MtdV7OBSsMBd5upDRoAU7FckNA9BRX/ZLnwDDRsRj5TZ6vA2OsAVdaUH1i+9VhclZ5j5EGNc+I
	s0gn9jWxTObZPqphCgcuK
X-Google-Smtp-Source: AGHT+IGwswwx4/7cqqjPlzjnzsL4rSpWVuAaIUB0fvfsDxYPUnmFVM673MKZZmayYhpfGUR64pMkFQ==
X-Received: by 2002:a17:90b:3c8a:b0:311:f684:d3d9 with SMTP id 98e67ed59e1d1-3124173bcc7mr2183803a91.18.1748559339098;
        Thu, 29 May 2025 15:55:39 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([103.211.112.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3219cdsm49009a91.41.2025.05.29.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 15:55:38 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: skhan@linuxfoundation.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH v3] selftests/seccomp: Fix indentation and rebase error logging patch
Date: Fri, 30 May 2025 04:25:24 +0530
Message-ID: <20250529225525.12494-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202505280933.33EEDC4DC8@keescook>
References: <202505280933.33EEDC4DC8@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebase the error logging enhancement for get_proc_stat() against the upstream seccomp tree with proper indentation formatting.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
v1 -> v2:
- Used TH_LOG instead of printf for error logging  
- Moved variable declaration to the top of the function
- Applied review suggestion by Kees Cook

v2 -> v3:
- Rebased against upstream seccomp tree (was previously against v1)
- Fixed indentation to use tabs instead of spaces
- Used scripts/checkpatch.pl to check the patch for common errors
- Removed the blank line beforeS S-o-b added in v2

 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..dbd7e705a2af 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4508,9 +4508,14 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 	char proc_path[100] = {0};
 	char status;
 	char *line;
+	int rc;
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
 	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
+	rc = get_nth(_metadata, proc_path, 3, &line);
+	ASSERT_EQ(rc, 1) {
+		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
+	}
 
 	status = *line;
 	free(line);
-- 
2.43.0


