Return-Path: <linux-kselftest+bounces-10376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1950B8C915B
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F365281CBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D938384;
	Sat, 18 May 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8tE7fhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAB1DDC9;
	Sat, 18 May 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716038471; cv=none; b=eYWdUeiH1/EqT9mUGeUe8mdr6hq/Au/ZaW8Ul8pMhS8c1DkVKQePc2VIZTrK7pQkxhBVFikaJrFe1acePPqPAwMiF8n+jzFqmzOVIr8Qj9wkW9aiSyPRH0Wpy50uJwMcSgROMJuNOfNVaKlZhjuPWDILFCXTWWeUue3IpYhLZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716038471; c=relaxed/simple;
	bh=ZYxibtoXl21fMBJ/iT2ilXjtHq9YVKQtJyijxIzTego=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8HURuvuUJ9WFi9Oz+m75HCmwkZWDcDWyI3xdW2mzcQ/UqO2FpLy3IwAQh7bGoSCbGMq9Pz42hlfvTwDx6li6NkXYEjahmsMCIRIfJ7easyhsnHsg3wanCB1SkllsvD21Ul+cA4HdXE73AX6iSqsUkmlPGevXbZ+BHaNsCo0nXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8tE7fhN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c3aa8938so34680105ad.1;
        Sat, 18 May 2024 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716038470; x=1716643270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ5wT+MkOZjGLMc8vRhcbO+teh1jI9whaasnCH7i854=;
        b=R8tE7fhNFjhfICZmZS+oo4yGKKsM3xDaUDscZcrFPHElYoD0hNqbiPg+dzRbgzsw/d
         Kn87w5jYqf0Tn9eClSHQmbYOBzkoEIkd3aqyhWDHPjFuxk+66hxZI4gUeDqTQfeLfa5N
         /kz5SYeHspLH2F0xyea0gO7ofQd7vJlUgrbTLO6KBzMjrNwZjQTlG7/rsCXz5m2tf0Ci
         p2MJmQFidpBdBPWuFLWOSNgIu+Hzx4uTnfV22Ykl2bWk+2coQl+xdBexbfzSYqa6U+q9
         eEO4bDBbfedhJCaa5opcR4yk/UaxKy8KW2nGxQs7QQSwefUg3HyUbRPpv5i/isvKKfap
         wOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716038470; x=1716643270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJ5wT+MkOZjGLMc8vRhcbO+teh1jI9whaasnCH7i854=;
        b=q10VGrD/o65lZYeJuw7bjOl6k++hDlC9+g7rUwkQmUmeIuEuiin8tiwrt2TFEYJok0
         D1f0h/6Yw9OW5hg9Ky4GAmrYq5HjMkPNFvyphJtCKIcUnsT+W8OOJlZXzTB/rVr0cT/2
         FJrjQr+ZcSW459brDNw8jJj2IzldPmcbtCmDHhcWtMFrG1iAPJZwUaPtNuKtDgz3ZS0q
         LmZRSVhjNePEcd6QgaZSTRwuKZkLs9QUIhx/NoH93WKlluIRYGfgVOZ3bFJqnyW39YpZ
         pB+WKlcZidkFPHxi2R0x766liKAr0e21b3Vn3qJ3V6usc+547PYgQ1C/BX3xn3Obpd8o
         MgUA==
X-Forwarded-Encrypted: i=1; AJvYcCWuT2KcdG/ASmWQIQ+JU2G+YZ3543WN0loAUGGxrfOngTY9nwRCZbEPFnkm3pYQiRYvZfy9EflO4o3PZ/9rQKTNoZkq6TgqW31AwfovYrrkhrTWWwky/s1TjFA4LXswS3nRWqSUzbAb
X-Gm-Message-State: AOJu0Yzr/xcpR+ICKGC5Z/MXblptepCGKo0mWK0lzJk/OGMbD8nPgaY5
	5Euv2qx4udlDiVD1qm6uNNRjhh7RpbG7mqwIHnovGH/7SHwQLnYr
X-Google-Smtp-Source: AGHT+IHRA40vD9NqiZJrLkaVeth/VvcwY6RXCubdVF3ZxZ9m6MXZcozE/8vIKWjWpUcRByLEY4ih4w==
X-Received: by 2002:a05:6a20:9e4c:b0:1a7:4944:d49 with SMTP id adf61e73a8af0-1afddee52d6mr25397028637.0.1716038469769;
        Sat, 18 May 2024 06:21:09 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b769197sm14480855a12.24.2024.05.18.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 06:21:09 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ap420073@gmail.com,
	horms@kernel.org
Subject: [PATCH net v3] selftests: net: kill smcrouted in the cleanup logic in amt.sh
Date: Sat, 18 May 2024 13:20:52 +0000
Message-Id: <20240518132052.1293474-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amt.sh requires smcrouted for multicasting routing.
So, it starts smcrouted before forwarding tests.
It must be stopped after all tests, but it isn't.

To fix this issue, it kills smcrouted in the cleanup logic.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
The v1 patch is here:
https://lore.kernel.org/netdev/20240508040643.229383-1-ap420073@gmail.com/

v3
 - Do not change shebang.

v2
 - Headline change.
 - Kill smcrouted process only if amt.pid exists.
 - Do not remove the return value.
 - Remove timeout logic because it was already fixed by following commit
   4c639b6a7b9d ("selftests: net: move amt to socat for better compatibility")
 - Fix shebang.

 tools/testing/selftests/net/amt.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 5175a42cbe8a..7e7ed6c558da 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
 readonly SOURCE=$(mktemp -u source-XXXXXXXX)
+readonly SMCROUTEDIR="$(mktemp -d)"
 ERR=4
 err=0
 
@@ -85,6 +86,11 @@ exit_cleanup()
 	for ns in "$@"; do
 		ip netns delete "${ns}" 2>/dev/null || true
 	done
+	if [ -f "$SMCROUTEDIR/amt.pid" ]; then
+		smcpid=$(< $SMCROUTEDIR/amt.pid)
+		kill $smcpid
+	fi
+	rm -rf $SMCROUTEDIR
 
 	exit $ERR
 }
@@ -167,7 +173,7 @@ setup_iptables()
 
 setup_mcast_routing()
 {
-	ip netns exec "${RELAY}" smcrouted
+	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
 		172.17.0.2 239.0.0.1 amtr
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
-- 
2.34.1


