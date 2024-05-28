Return-Path: <linux-kselftest+bounces-10773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF58D1AC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C944A1F22E68
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924716D4E7;
	Tue, 28 May 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8GNfx7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178616D9AA;
	Tue, 28 May 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898326; cv=none; b=GA07f/jGJeGzzmt8iCqmwxm0/zsMaAzF6fg78x7dvLL8oIcmpKmBLHfGjPyHev+FeVNbJkrVN5h0iWFiRxgUXy2d04hGKcUpQZGA616t/wgAzJYTtqaha/9hBbepxPYAoar5Y0m8rLVavNZiPlrE+Ac0HeqdfCLeqnSxY1WnIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898326; c=relaxed/simple;
	bh=/ipaOxFtBwyfIXHF4ggyxVFLnpuptNMK5y8P54jR0Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzdldbCUs4yn1annbkDmSyQHW7vdeN3ay0BQvWGuOMTQ776mh8zMOwU8xXv8HeBUqHPT+WPWVxqSwsShSKf1KU8DzjPiStmoxHpjBEOe3ZUmE3ZRtBqzzEcZEQzEw8dIOf5hmxeKLB7+UQAur0onNBoV3AGiulO5s4jyWzLbPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8GNfx7j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so4894675e9.1;
        Tue, 28 May 2024 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898323; x=1717503123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYZXJmyumgms+Q7J/J6ShT1VOA9/iNpIXyrtMkKuYf0=;
        b=Z8GNfx7jTkXKBMrX6gen1AHHctHOrpsSTOsRT6cvFeZR7SfG3FmWeuVJU9tP+2VV3P
         JX14QrOcXWHtGd4GBARqjJRZsACl2EIMn+H2S3ISPgrzPLt/rR/warsOc7nC+iQa5l6h
         QPuYU85DZcJUlA89pUrE7pSKPhKS22MiKlEArwfuy/ToiL/DB2hOgpoQBScX3Zsc2c9T
         cY9aA3HxOB397QuNEC23B39lBrZrhfSkaHTTRUjBLy/649rFkZa/ryQKjG22SLBQ1gIx
         Hbr3xK3mIUzm9L33kqeHYrRi1tOwmaJbU3f1MO5y8Twx/8qGXidN9bSknwx6F5FymiFw
         sB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898323; x=1717503123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYZXJmyumgms+Q7J/J6ShT1VOA9/iNpIXyrtMkKuYf0=;
        b=rWmKBd93VlwlcQ1dag7c7DACBz5Y7K4HezNNeKJ1M06MVbk3TALtj4W5VunmPOjklj
         hiK6Lyv79v3S+pHqOJm7y16LERPDdZY0wla7grOW09QqaCqlxmA/2MHjWC+5DVgAq9C9
         TAKYoMfexD36uj5OAXVjHWH5ybH6ETsorQV0+tP449iwkqgxjczrc4QRXUsaCb/YOXwY
         m67pUxa8AB+dDyrj2fW1vlctBsf1etdFP49l8d0UEVqHzxnSSFFQe0VeBd2lmgPXgRrQ
         yjqAzvgj0ODZoncX1MZ+eCxm2iMetG6MjRMZkb/wW0Nvy4JQ401otjhnWrJsFtAhg/sf
         2UvA==
X-Forwarded-Encrypted: i=1; AJvYcCUW/U40vt/T6joa3Gnpm75bsc1VprGChKSe8F+LFXPZjMD9iY5dY9sND01ZEz5Val2wGnw/GdTaprI5X2I87ESoJLaCYuA0Rirx7XBfZp323hjuitD8VI6mvFKko8/Q+DfCrR00hdtbAIuKWCcK
X-Gm-Message-State: AOJu0Yz7fRA3HbPosOxLulFIb3/2VP5o71Qvji9bfBJ72D25976YMHoe
	7BKhG/iftkkuxAKfUHRgR5iM0DCiQaXgffYSVtW82oWML+AbsqmgjUAKmg==
X-Google-Smtp-Source: AGHT+IFT1iIJjlzSvoYUAMuY1FlDD6EgzXr3GmIMeE4KKsPkc5VuKSEc/7DWXt1hjPQOBYg9GyPeUw==
X-Received: by 2002:a05:600c:ac9:b0:41a:fa9a:d86b with SMTP id 5b1f17b1804b1-421089d3390mr100343155e9.11.1716898323449;
        Tue, 28 May 2024 05:12:03 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-94-218-116.cust.vodafonedsl.it. [5.94.218.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f69850sm168281625e9.26.2024.05.28.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:12:03 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a netns
Date: Tue, 28 May 2024 14:11:39 +0200
Message-ID: <20240528121139.38035-3-teknoraver@meta.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528121139.38035-1-teknoraver@meta.com>
References: <20240528121139.38035-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest which checks that the sysctl is present in a netns,
that the value is read from the init one, and that it's readonly.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-sysctl.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns-sysctl.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index bd01e4a0be2c..6da63d1831c1 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,6 +53,7 @@ TEST_PROGS += bind_bhash.sh
 TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
+TEST_PROGS += netns-sysctl.sh
 TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
diff --git a/tools/testing/selftests/net/netns-sysctl.sh b/tools/testing/selftests/net/netns-sysctl.sh
new file mode 100755
index 000000000000..b948ba67b13a
--- /dev/null
+++ b/tools/testing/selftests/net/netns-sysctl.sh
@@ -0,0 +1,15 @@
+#!/bin/bash -e
+
+for sc in {r,w}mem_{default,max}; do
+	# change the value in the host netns
+	sysctl -qw "net.core.$sc=300000"
+
+	# check that the value is read from the init netns
+	[ "$(unshare -n sysctl -n "net.core.$sc")" -eq 300000 ]
+
+	# check that this isn't writeable in a netns
+	! unshare -n [ -w "/proc/sys/net/core/$sc" ]
+	! unshare -n sysctl -w "net.core.$sc=100000"
+done
+
+echo 'Test passed OK'
-- 
2.45.1


