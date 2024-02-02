Return-Path: <linux-kselftest+bounces-3966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A88465C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF3EB21CEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A653A1;
	Fri,  2 Feb 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="frbL0wz1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3ABE59
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840712; cv=none; b=RiFWpaTYu3u/uOU1qRNDMZ3im3YRp64DywkTfG6RpU/CLnH6NzYlp5wD0RhGIVkhMmJMRRRmYUX+dKypCWfEOjOl/GLNmR4Lsed04pKsJqVO3Sge8gZyOxNaXllkdVotz07yLauZq/qlQiEY9OS+dJY6+yYxq169VQGnY4VymJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840712; c=relaxed/simple;
	bh=9N2iU88+gARQNe6fozJMjFI5OkOXZkUyFALlpWKir8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i65sC8422FfelaE2IUBr9xEfEVeDb2UVbnK9k6il7DbAaO6D6AtHz6AvtJuJXKVtVhbM3Y51SgmsMZK4CjGRdh6zxA1NU4q6dkVbquvf/2jNpWSiw3UR+i7PTc1j83Iip3RH0vTe80KT4TGJmoJ7OJQXq+Ruk6fFtw6AuaDbhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=frbL0wz1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso2325435e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 18:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706840709; x=1707445509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+MYOUdkffZklmJiRyDcBSvfexdw+Ug/dwNFb912Mic=;
        b=frbL0wz1UmxnOBA5ovKX05Ts7a3K0TlLlKRG2bDTohnp8LoLAnyt56C6UR9d+CH0Yc
         FuJiapWXxscrm/qaCPYqWvhvTweU063XysN6at25XE6NmtxeRmm5K8ypX5mWUC3auhXt
         dgzc9eq5HhlNkRwW3iJgHaXRlZvhjEPTfJKn3qf6v6GURY3/eRYzhcMlB40l+kHQ2uEU
         k22Hg7Xpz/8bG7MvkS5UUpmZXpYhnJFM5p1zgiDXDKqjazCZDVRgBzkmJM25+HCcYxj8
         28XrBWPNGxCUPSl5EtJGRLIYIi2ST8IThJuaa01tg/EvBrMq4sF6ND6oe6P4U4ZEkxqZ
         9Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840709; x=1707445509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+MYOUdkffZklmJiRyDcBSvfexdw+Ug/dwNFb912Mic=;
        b=LFqZOxD8Yz0eFt5bsRRoB8GWz06O7juU+OJAsREWpCANgUAMgnfimBZUiZ5DOtFEiW
         ZI8YkNK2/gwE48g+G8cMryMrWBUW7bkntutvyHsKYD9MI0+WvdbK/Ynwh3l/wVOMBQHr
         7CJ/cZ+hCP9kQjejU8dpKnSABt6dNp8gzQY+t/Ai5sWBdjaN4K5+xI0SIIQdn4m6fxN/
         bsqADvyV2I0WqrR0AAD0iVBSDqBXG3WNQnCkHdfYXdPJHMQJwDbV6kdrDQbdQ4qUtJ9Q
         8lNoxdBMD7dy5bU9Z3ZVLyYCbjFb3t4jo86O70qDug0KtcU6G/hfP6pi6dlpVE0NfDAt
         LsAg==
X-Gm-Message-State: AOJu0Yy11yUHNDgHbISMPjxhZiT6ubBTT/+fP9tico2XEpc1H9Jg0Z/4
	dAo0MTYjjP7lIQiTVoE+883OSGZGeQcclBW/dtVIEBY4HUKN/ol9S21/ATgYhQ==
X-Google-Smtp-Source: AGHT+IHKoqvqHwrBIymRLXaN8QWWHiRU1Hnh5rwpivU3OiIucqg0XN5yHdkFYRxlifcErpSpJBiHsA==
X-Received: by 2002:a05:600c:1e09:b0:40e:e839:82d3 with SMTP id ay9-20020a05600c1e0900b0040ee83982d3mr558787wmb.20.1706840708752;
        Thu, 01 Feb 2024 18:25:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxrAidf68sKuOnQRo82PhZxVEETGD8gQt1wMzSdK5oZVhC3f7C4bCzGBZPilM1QM3clRcjoHMVeBfNy8z6CipHoaMrSIKBWu9MT3MjibepjVJZTx9N7qj6AIKxw5eW21ot8gfK1Ldw9uDRUN/fmuQzcNR+7HZMsRJztUONVQTZ0DZ33/idL/7sWEdICOhwKDn7pOv0Ai3dSgG2oQp1kCmtax51lFGdszk4WMAzBzDBk2Oke5mintYVzQ6fTaMDIeWo0wNpXY2/qg24Qnbra4bGeFFwNCOfQLI44y1fEFKU7aEdtwbuI/20aq2dyt8tw4b+6MgNEu/bEG5f8ccXOFhfIskTTSmo8V0NASEp
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b0040f22171921sm1201476wmq.3.2024.02.01.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:25:07 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: Amend per-netns counter checks
Date: Fri,  2 Feb 2024 02:24:59 +0000
Message-ID: <20240202-unsigned-md5-netns-counters-v1-1-8b90c37c0566@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706840700; l=2805; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=9N2iU88+gARQNe6fozJMjFI5OkOXZkUyFALlpWKir8s=; b=Puw0xgLo615QE2e5RmlZ8jpNiFzXn/gxginyxBI+5ARAFf3Yf/fwt1KlR7ELKNDr5xs5BwLnh Vt+269xSIvFDDBwXaQR/uQqRY+N8HWQp2YYJrQKGvZFm1ELDkbYIv2F
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Selftests here check not only that connect()/accept() for
TCP-AO/TCP-MD5/non-signed-TCP combinations do/don't establish
connections, but also counters: those are per-AO-key, per-socket and
per-netns.

The counters are checked on the server's side, as the server listener
has TCP-AO/TCP-MD5/no keys for different peers. All tests run in
the same namespaces with the same veth pair, created in test_init().

After close() in both client and server, the sides go through
the regular FIN/ACK + FIN/ACK sequence, which goes in the background.
If the selftest has already started a new testing scenario, read
per-netns counters - it may fail in the end iff it doesn't expect
the TCPAOGood per-netns counters go up during the test.

Let's just kill both TCP-AO sides - that will avoid any asynchronous
background TCP-AO segments going to either sides.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20240201132153.4d68f45e@kernel.org/T/#u
Fixes: 6f0c472a6815 ("selftests/net: Add TCP-AO + TCP-MD5 + no sign listen socket tests")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index c5b568cd7d90..6b59a652159f 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -110,9 +110,9 @@ static void try_accept(const char *tst_name, unsigned int port,
 		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
 
 out:
-	synchronize_threads(); /* close() */
+	synchronize_threads(); /* test_kill_sk() */
 	if (sk > 0)
-		close(sk);
+		test_kill_sk(sk);
 }
 
 static void server_add_routes(void)
@@ -302,10 +302,10 @@ static void try_connect(const char *tst_name, unsigned int port,
 		test_ok("%s: connected", tst_name);
 
 out:
-	synchronize_threads(); /* close() */
+	synchronize_threads(); /* test_kill_sk() */
 	/* _test_connect_socket() cleans up on failure */
 	if (ret > 0)
-		close(sk);
+		test_kill_sk(sk);
 }
 
 #define PREINSTALL_MD5_FIRST	BIT(0)
@@ -486,10 +486,10 @@ static void try_to_add(const char *tst_name, unsigned int port,
 	}
 
 out:
-	synchronize_threads(); /* close() */
+	synchronize_threads(); /* test_kill_sk() */
 	/* _test_connect_socket() cleans up on failure */
 	if (ret > 0)
-		close(sk);
+		test_kill_sk(sk);
 }
 
 static void client_add_ip(union tcp_addr *client, const char *ip)

---
base-commit: 021533194476035883300d60fbb3136426ac8ea5
change-id: 20240202-unsigned-md5-netns-counters-35134409362a

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


