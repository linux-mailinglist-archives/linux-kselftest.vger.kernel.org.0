Return-Path: <linux-kselftest+bounces-10972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636378D5641
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CA4288813
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4E180A71;
	Thu, 30 May 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjHslTbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343B183A6A;
	Thu, 30 May 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111682; cv=none; b=rk1jUTyiI5jQgQCFqx00T0iUkRyv1B1iHGqinRcgM+JtYDI4jk2H7RFBmMkpBe1AGRwKm3oi18/T5yS0/g3TYavn+wuBjny1W4WEZeSAvwa0+A0mEYwHv44eX0vriLujJu8ZCWh4PqnbCoxV8J+rP8VEZ1LDTZ/ZRHaEvvazdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111682; c=relaxed/simple;
	bh=ujw6A7cLPJ4pZoF4QMgdKjARQaEwljLkk/Cun06F0n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih4fQhiDSXnCGtOFLqmpG2RskFzZW6oIDm6gIu9H1JMtb6wJ615UTw2u6ReABoLovIKsdPi/PPjl1H2b7jC12QaalC2FEOVwYsvsccpH22GcrXbWIjn4dexCPbAu8zM7xIZw1sqR5uyJAZAusVayPbM2P559RHwg1WGwuAHVZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjHslTbs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso248140a12.2;
        Thu, 30 May 2024 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717111679; x=1717716479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86jy8d5X7FFm14WAT6OxpflPnTEq2yva/bp539o24YQ=;
        b=QjHslTbsqMEaoF/ZiV/wjPlvcrGKL48dSrZQKWS3Bph4iCBHRbCNnliProLzpVAEll
         R+m2AAEC5AuAHl1xVRC+rBO8Iu7PvpP9kF77kivNScUBJBuyQTGqZpKm0s/OD6VyY0Dt
         Crn11E21v632RhyT8ip4GHnH7cDuk6KjFTbtKtkQEdOwo6XM5bugWXqVqqpapcy7CRZ4
         LFvHQj5K5yliR5ZUNwAezAgBO4ZzFoRMtWcm/yV4qL1218hkZ8mBV0W2B8zH58Ythgq9
         1K16GPgzW10/JfqmyC4yKLrGVmB+GcSxi/MertVklEf66ENbXNROUD/7FUZ+V0uNF58U
         TXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111679; x=1717716479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86jy8d5X7FFm14WAT6OxpflPnTEq2yva/bp539o24YQ=;
        b=hTKDuSo0v/5nzcllKD1J9f90JSPRm8OpCwtiOSCxOk5ZQPVoiEzoFR9g1RJboOoJsa
         kTDlNnFN5atgiuJTlJltFR7E3R4aGyb4G5GwldQOCRP/bf4HRsrmUVmhZy4a/Wb3Knyc
         7y9ZOdCDlRb4MOyFuamTxq0kHBYsuMOhalaqXE0YOC7h+2qPhiWpx/JrR9kH/19tuUkZ
         ssad6atAKUcH3sLF8qT7tv471KX+SZbPwz8IZeBD+zZwCAEc2toQ3q59en3EpMvKSqTb
         2C0W1+VKv1DO1AJVmCP8f1IsZYLHJXT5ByouzFucmVZHqYSQykrBzZ52EQbgmdIV4Uj1
         39mw==
X-Forwarded-Encrypted: i=1; AJvYcCWiB7OOHhSAyIwfY01b7cGbn+M7KoXYN7xRU1oUD89MIrGt3rC5MhAQyWDE5UAzkiAC/HF6LV1aBLJy0nylCjDkzeNP8vU5RhuDzDVgJZ2T/asFxvuCV0iBn8Mb/M1eZAzBgqKpAcC76zeGN2Ec
X-Gm-Message-State: AOJu0YzoxDdwM5uqYhIo4WcrW2c8LIZ8uH7yubENKWhO6avg+67Va0je
	djxs4ja7gEDNJUl3K5ODXKMkQgicTxE0oH7iIDb9dBm1vVjzyrsnmmbJ7g==
X-Google-Smtp-Source: AGHT+IEsITIBxxuwId87jffyD/ukXFKSCHoAbQ/t0LNpNWhJ1TwBiF1flDVKvATVGvNxzh+1GuF3Kw==
X-Received: by 2002:a50:8a9d:0:b0:57a:2742:de36 with SMTP id 4fb4d7f45d1cf-57a36563e86mr198024a12.35.1717111679199;
        Thu, 30 May 2024 16:27:59 -0700 (PDT)
Received: from lenovo.. (mob-2-43-182-132.net.vodafone.it. [2.43.182.132])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a35e86c36sm197223a12.54.2024.05.30.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:27:58 -0700 (PDT)
From: technoboy85@gmail.com
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH net-next v2 2/2] selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a netns
Date: Fri, 31 May 2024 01:27:22 +0200
Message-ID: <20240530232722.45255-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530232722.45255-1-technoboy85@gmail.com>
References: <20240530232722.45255-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Add a selftest which checks that the sysctl is present in a netns,
that the value is read from the init one, and that it's readonly.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-sysctl.sh | 40 +++++++++++++++++++++
 2 files changed, 41 insertions(+)
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
index 000000000000..45c34a3b9aae
--- /dev/null
+++ b/tools/testing/selftests/net/netns-sysctl.sh
@@ -0,0 +1,40 @@
+#!/bin/bash -e
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test checks that the network buffer sysctls are present
+# in a network namespaces, and that they are readonly.
+
+source lib.sh
+
+cleanup() {
+    cleanup_ns $test_ns
+}
+
+trap cleanup EXIT
+
+fail() {
+	echo "ERROR: $*" >&2
+	exit 1
+}
+
+setup_ns test_ns
+
+for sc in {r,w}mem_{default,max}; do
+	# check that this is writable in a netns
+	[ -w "/proc/sys/net/core/$sc" ] ||
+		fail "$sc isn't writable in the init netns!"
+
+	# change the value in the host netns
+	sysctl -qw "net.core.$sc=300000" ||
+		fail "Can't write $sc in init netns!"
+
+	# check that the value is read from the init netns
+	[ "$(ip netns exec $test_ns sysctl -n "net.core.$sc")" -eq 300000 ] ||
+		fail "Value for $sc mismatch!"
+
+	# check that this isn't writable in a netns
+	ip netns exec $test_ns [ -w "/proc/sys/net/core/$sc" ] &&
+		fail "$sc is writable in a netns!"
+done
+
+echo 'Test passed OK'
-- 
2.45.1


