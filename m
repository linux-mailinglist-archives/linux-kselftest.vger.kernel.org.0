Return-Path: <linux-kselftest+bounces-34780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBAAD655A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 03:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213B71BC2B31
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AEE19C540;
	Thu, 12 Jun 2025 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6mX2mVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600015ECD7
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693508; cv=none; b=u8isWIazsfZ2A4aUppbOKsrmqXt9SjjPR72zqo78svQXepK86dnUKbwY2j/B76F0gOhJUInwGxw2VrlZHWsSz/0nZtKfZ5RZVEiseE6IglBpp0PSj/coyDrAZThbjfwYo4Q/6udugldIvKwkujkaf7qqkhxhoQZAJWz6cZiZP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693508; c=relaxed/simple;
	bh=Ay5oQohGM+cVjnNWHVNcpUKrCpFL8jgt+c4zZIHKDB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mPycgPliOmnMXkZWb6yUhkxBybK6pGNXLAvWzthGykHr2DDFO7vZo411O18kJMB0rwO/kSuVfIrvaOAYhR84zRak8P4rKsAg1wuMXXaTC6KDE7Zm+lT6boZvWNHYHyZjsoeuQoExsBKGXNIjUw6vQwKdnBhopyVuytYF77UTds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6mX2mVK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso541359b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749693506; x=1750298306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=R6mX2mVKxWB6gmSSW1uaAXjazlZp2mi1s/I5LqGPVVXXVTcZ+sqt8UQq6Ikhdk1QvQ
         SwZVh0ZACS1s9rW1ABjJf9xGeM7wcfCD3fOmtzPmd4RGXYxdz3mHXzMUxnlw2bjXfZyu
         EhlnlgEyD+M5kY40Gv46JXEbqo9f2Run4DDZYzwI8sgLM0TGLMSWOctzkVoUxLjNpElO
         et6fclmNsz1B4hIyh/RTJgbsemdI8tNizQZZEkAcZVvzVxgvtkzmliFWPhzrcj49fsWS
         LJQvIVACfUYpZZyXDJbkXVsfWbZnlwQe8MVZKg8McW3EVkz5sh7Bwz1xNhJ++titvFaq
         wyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749693506; x=1750298306;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xOt1jqHtKfWjw2Okk5Lx4VTTX7yg4srSCqsBU9bfdk=;
        b=A2E4iRdSA3+s6YSpX+z3PYE61GUl8MIEp7WugAEh4G2YETt1844dBH64P20JUMzOt6
         5diZFZDiaqmr4tW65hVPj7P2LTsDrguGVPFTzAdVJeTKYG0evphOQVwlf159tjqPSDVZ
         KuOnDkC+ubGaW4AIpENSxE5QXtIAD5gWf9xlU0TsIZlKmVpylJ8NPw31wkSbuswZqL22
         ujlesFngxQyyV4NFQL148ar2Ei2KclKD3dXF7ck2EDJmRJV+1rtk6YIegNjAY8TF6w55
         dezK3+Jq7ssWWCFC9VJq1B+SFd/4Clo1wiwRwqJhb7t3nKbnYMOw/Dsk69kawWZ8EoNv
         6lGA==
X-Forwarded-Encrypted: i=1; AJvYcCVzmFQVKo3nW1Cyae/2Nxpz5Tm6NuIjcvPSJh8m8KtgHXyshfH6w96JFhSAmZoVqsgGJyxtXp5d33LOby2Go1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8kSd0v2TURfVKlYq8RZjcEW8Qz+/e3y9j0WMpeIeDfTHhCQF
	IyP0R8ATlypFZ5wGtEwnbYKg/ojdpEOus6DmK+6nm+k/AS49zD7s3DIAGzdN9lXZXf4XR8FvVRp
	3LcBStYrFmOkwP0qawTP0NvrwYw==
X-Google-Smtp-Source: AGHT+IH0xuhQyu7PzeBD2lZe2ItcmrlnVX8CKI5tsgo+GqBtt/K3hLGGc+yQSmUUI1O0fxnFPA7xdeO7SO6ERkuafg==
X-Received: from pfez22.prod.google.com ([2002:aa7:8896:0:b0:746:257b:1d37])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a60d:b0:21f:8817:f695 with SMTP id adf61e73a8af0-21f8817f6a5mr4714343637.25.1749693506379;
 Wed, 11 Jun 2025 18:58:26 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:58:12 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612015812.2520789-1-yuyanghuang@google.com>
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


