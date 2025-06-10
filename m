Return-Path: <linux-kselftest+bounces-34551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3EAD325E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBC71895910
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F81628C02F;
	Tue, 10 Jun 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzN+yh8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57A28BA96
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548452; cv=none; b=CdLaDF3nJwp+E63fqzvwSNyGzawvzoKlIYrVgO3uluES0o48pEUW76We9wdxYXWmOM22yeawd5PM43/E3vysh+WygNzm/8d22R1gpYv1/IfvMhlSZRCqwzKJpbp4TVK9R3xAMjRiE7/7fTBoVzp3WGiOEwzWH+7d/d5abHiZw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548452; c=relaxed/simple;
	bh=Ay5oQohGM+cVjnNWHVNcpUKrCpFL8jgt+c4zZIHKDB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lyGQZIlwrfD9z9FdpBo+BHp+llRkPhFkMJ6IZGqwapx+oeerm+SHJ4O+dPU/zaajFMBW1UiuK3xAFePqqkiNGGkZ5cqsAn3qYGwx/kBAbZrjBU1xCSLec5qMuSoZJgWr/E5URfb5Wk5XEDFjO+8IhdPi7OK15cTid8FQ8Lmdqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzN+yh8v; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2355651d204so49400145ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749548449; x=1750153249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=HzN+yh8vBao3UrbjV8zQ3qtyO/iV9GD7JC+7CmOV2g4QYiRrpuuYCpovywO8iI/Awv
         6Ru8HuKJ88jE9+mDpZzoPx3kYMpVrK5A5b/lDGaNtmQDFaBfLfclqzdHIc3jrgWLG90Z
         f8k/bYfv3c2Q9vPUYRR/e3SBpvPQBP41OtMxVOeO+b6YQAojrotIv/9cWxA6iAKlrAjG
         zQh3XtQkx0UonaBONHfNs20D2amV4tk8iRxkfOInyKy2e7j/cgFP9fHMHwlOYhEsRT63
         uJD6JfhFIoCZPziSWqnU9gbP11S/G0HKwXD/guK77nuUxqPEgIKt6jvdih6SKz47SIIU
         0Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749548449; x=1750153249;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=LZ0u900JW/Tc4vLohS7EaKPs89Zd/xKg717Vr3LcgoIan+EMWMw3q34oYnpkNi4tO/
         Vw7+r1NA/WJBZgaVBc1RVcP93H8+iZvSVrdLiTU2Jnyr7Ms0lpXfm7dvbXEaqQ+EAuBf
         xzGvrkihWnJfe05L7HoJxIxixKkAskqhEBrVXi50KOgllJiHl3jC4uk5bNv/ypAyQFwT
         nF93ijQrAWZYT7w8oI2Pm8xCRaYjhc8Pmo57iplZC/jFRL8qZnnEcQdZ4M9XyXq32Gwd
         ziOkpvbnCN4RJvhjOUgo1VMAw09/wsBIOF1P65ASYCkDarLoKniMlrTskiqAbRuTYO+S
         qDog==
X-Forwarded-Encrypted: i=1; AJvYcCUnmQ7p6W31UBO5rwqKnYLMk9MUdoCQ0ECuqqJnq/HvKXgjZw7WkJHPgaYbCoW4GJcLDgfcY+2PGBCOYIZBqFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLiJ10ASEKyc/kTCj2ITRLi84uza9PvpONXO01HygmB8k8+qG
	cFyE6z+D/4aVqDj4cVSTw/kXidTaW9yNnMNuwdWlO4sGZLxgjQu5by8xRV+wJrp4Eu8qrI77Qm8
	elyb3fWf8nCYUjBb0dKsxxseenQ==
X-Google-Smtp-Source: AGHT+IHsPq+vdV/YlOTd0sWoiyauA4/hsj5ntF/YMP67oggciRP0ROMwuW5E9EMI6TMVeBy2YCAWZSfoy5JflTd8og==
X-Received: from pjz3.prod.google.com ([2002:a17:90b:56c3:b0:311:c20d:676d])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:76c1:b0:235:f4f7:a62b with SMTP id d9443c01a7336-236383918d9mr19990545ad.41.1749548449493;
 Tue, 10 Jun 2025 02:40:49 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:40:45 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250610094045.3829667-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v2] selftest: Add selftest for multicast address notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
removing a dummy interface and then confirming that the system
correctly receives join and removal notifications for the 224.0.0.1
and ff02::1 multicast addresses.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=3Dnet TEST_PROGS=3Drtnetlink.sh \
TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v1:
- Skip the test if the iproute2 is too old.

 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selft=
ests/net/rtnetlink.sh
index 2e8243a65b50..74d4afb55d7c 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,6 +21,7 @@ ALL_TESTS=3D"
 	kci_test_vrf
 	kci_test_encap
 	kci_test_macsec
+	kci_test_mcast_addr_notification
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -1334,6 +1335,44 @@ kci_test_mngtmpaddr()
 	return $ret
 }
=20
+kci_test_mcast_addr_notification()
+{
+	local tmpfile
+	local monitor_pid
+	local match_result
+
+	tmpfile=3D$(mktemp)
+
+	ip monitor maddr > $tmpfile &
+	monitor_pid=3D$!
+	sleep 1
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		end_test "SKIP: mcast addr notification: iproute2 too old"
+		rm $tmpfile
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add name test-dummy1 type dummy
+	run_cmd ip link set test-dummy1 up
+	run_cmd ip link del dev test-dummy1
+	sleep 1
+
+	match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmpfile)
+
+	kill $monitor_pid
+	rm $tmpfile
+	# There should be 4 line matches as follows.
+	# 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=C2=A0
+	# 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=
=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=
=C2=A0
+	if [ $match_result -ne 4 ];then
+		end_test "FAIL: mcast addr notification"
+		return 1
+	fi
+	end_test "PASS: mcast addr notification"
+}
+
 kci_test_rtnl()
 {
 	local current_test
--=20
2.49.0.1204.g71687c7c1d-goog


