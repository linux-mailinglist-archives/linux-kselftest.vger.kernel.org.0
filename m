Return-Path: <linux-kselftest+bounces-18671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F299398AB2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B381C284EB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D055199928;
	Mon, 30 Sep 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULNnKSfz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD81990CD;
	Mon, 30 Sep 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717666; cv=none; b=s51s9AQ7Mnr+o34/5IxXPl8A5jfGJYS0R3vfI65BOwZzNmdR76wqxBsLYlzEy3/8ETC5qH3nICb/i1aACaJpVrE15TxgLu3Cx2FNAVk9ypoUWRCOFfhKowCMpUM2Uc2J6tm9LgUFdS6TczQ+VOkP0x6l5iBEDHXRJkvhjtJqG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717666; c=relaxed/simple;
	bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZAhwckatFGLxeGZTjnu9qZkt0v8475uH6KTeuy4ZpERMQhFTs0AEfU6xcBSnktsJU8MMmD3DLPHvpbiXOkTA1fdohHqb3PAXqXgAKqzaUqGEi+SlRRvfcILJwu+QgcR4oaxSLXP8svy/nXlA1lwIRdVrK//xKImggCgVPQ12hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULNnKSfz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd3419937so2124541f8f.0;
        Mon, 30 Sep 2024 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717663; x=1728322463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=ULNnKSfzTGIegowNzy8rp8qG6Uu9yHG80j5KFEp9Wji8FMRDKl9eeYuxqNYYda5q4l
         DkkPnx9RJaF256yESVE8UwA5/o2ZBdaeuQq2/v9bLAtekrvcvIdnE1SLzAshzH8krrlb
         SWWrcHKkmNedbBvDhL0nvgpOmM8rEpMPbRvutei2dRDSosnvRcdO0TgMyLoCXbvM39J4
         YsOERtrfTm0PVA1CjbrmwcZ2obf2iuLwO4ohccWFd0xXqkqenyHVMAM7SQ2d6z+DK/Il
         wutC4EJRCjyqqx1Y4ecwVgW0GGIl60lVwPLC2WOatQRXJo/krihZXeN6cx37l5oLWTNK
         0ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717663; x=1728322463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=gCPq0w+S7xDJdfgiD7yZSPEqqjrbJFfxAumvFA6chiHcdrttJexrfEbhdlBK6ik2I/
         56GBB+176GOydSiQsrym8nCJXmRD+i95dwmetPKhNQO2U4W9rBDyMZwPxU8Li3DCPBFv
         z0HNf1STmzhvTokJ9FIUpJnHt5F2e5/lRaaR7BYRXrvhxJkdVd6x2GU4j60eTjQEKpBG
         2fn0tnx33PVeIjX4oqDO2z1nvIkLtGJsa6t28qsLJUzvWQTPJaGPvPPN1BybVc3ra5TK
         xqGq0vXz45/IyvDUcfVXWCF520hLwOqLkl3SSRlOgXU/ffRaGpBEbJeR7MP/uIyYvz50
         MKmA==
X-Forwarded-Encrypted: i=1; AJvYcCUKlMOCSKEHOMxefs1p3LuSByXmROo9nP7Fniu9nPU3313JY2E3xGt77Hg6Zg5K+ksvu5EouBY84JMHhA==@vger.kernel.org, AJvYcCW39RWRcvxYjbdgtR+OtB/RYphm9RSAhj74PSO6W0RFGh4ZIqE/B20GJua9kJ6eb6KcydnXzwR4blmO9X8=@vger.kernel.org, AJvYcCXDP4VQdemcWM0T1Fco+ZbCIYbv7XZ3sh10QBV+VbQQEXoT30esLI3uoeDeVYHmmyDuuS9jiE6RWtCLZJoBKULs@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ4cjc3r/ME/9wBZjlcFEmsOotNaaUfygNoWZHYibblruashm
	2Pa6jNjzWSEXVlwaKGQWQLK+Ji76SVnLZhTkX5Nt0vP++q3uIbwp
X-Google-Smtp-Source: AGHT+IFkabZES76ptFN4nv1gCCG/WWlOpV4er/3q3udOMC93rVfBGqjz5kKGBB8VMFeVJjsHqnuoRA==
X-Received: by 2002:a5d:5548:0:b0:37c:cfbb:d356 with SMTP id ffacd0b85a97d-37cd5aebe7bmr6351064f8f.28.1727717663141;
        Mon, 30 Sep 2024 10:34:23 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm9706942f8f.3.2024.09.30.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:34:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 19:34:12 +0200
Subject: [PATCH 3/3] selftests: net: rds: add gitignore file for include.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-selftests-gitignore-v1-3-65225a855946@gmail.com>
References: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
In-Reply-To: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727717657; l=593;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
 b=2Pl+Niuhue01gc01wrXUewrif94f6AkMlXw/DgPPKKRj8XaME56qFjfW6f+nZzafYf/orB5wE
 GZ972fcF/SbDt+WFFXkxtIIF6lfLmFxE8map7CkSAitUI8q89llKm+6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The generated include.sh should be ignored by git. Create a new
gitignore and add the file to the list.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/selftests/net/rds/.gitignore
new file mode 100644
index 000000000000..1c6f04e2aa11
--- /dev/null
+++ b/tools/testing/selftests/net/rds/.gitignore
@@ -0,0 +1 @@
+include.sh

-- 
2.43.0


