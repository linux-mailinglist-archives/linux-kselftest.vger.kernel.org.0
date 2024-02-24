Return-Path: <linux-kselftest+bounces-5407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73D8623A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A191F21662
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7683A1B2;
	Sat, 24 Feb 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="b5O5EhPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F09364C1
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765495; cv=none; b=GYXxCrR8WTwi/jjMIf2mS7FiR0u6a5/px0vbm9kgIAp0Syymx5QyKEfCvdFuAzdf4xgvXCurNDm6ip68hqRDP+U4LobUns3JMo1+DvHe7H4jH6Ri/hOJup6srAMjgvvd6+mJ3VZP43D783RoSkTG7+E5UeJAT7fl0Kl/ZY/hwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765495; c=relaxed/simple;
	bh=ONxj7Z5bQEyPpk/sK690IPfrd/nKeK9bQ4FibvhzH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjTua+IWweDA3D2039XjtfAKyjsiKBR1Z8mRwD9H+Yas7yj/I602jeoikw+hjRLflQhtUvP8VQ5hNcMfNWuCWDfMq8F9v6pCTrRVxCkF0Y7M74t+sXDATaSbddrmKyZX1nS/PwhbltcsgVDvLtv9IIl7pjzwnE71AgkOFcwvbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=b5O5EhPW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129e98f1d7so756325e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765492; x=1709370292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfQPvdG/1knhuB2wdxd38i85RMYhhb/ulQhTX77Xabw=;
        b=b5O5EhPWnVR2ykOEHHgrIzkS5V1Hb1ov8m+Q52/l9GxGNsmJtCRf+OLbnTnVUcnjQi
         pNBPOBlDXd5rLeGJ1qfwE9K/47IsQPJ3gGlJgG+EAB7OAXHyB+l+pSUJCNKY13wOKwQj
         8wwPuiMqkaWsdiEsG5g0mxWTBvgzItSNXpcHjA0cahQvc7y2Ic9EDCOazDXJ+axfEsFj
         iUKmHijJ/hTGm99RpDMZI9KQKNOZb7iZxF00h1ztBJvgKQazM8AQ2OqwRpacjOA879qE
         8y9rDtlmavThdfEnisdz3uMMrocE48fJGzdLyQuCGw29CB5kdrzoiQ/Ax8beHMGQybbb
         LEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765492; x=1709370292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfQPvdG/1knhuB2wdxd38i85RMYhhb/ulQhTX77Xabw=;
        b=mXtkmt0aac1sVdMmo+Cv8NJpij3scuS5lZ5y7MKkG2cPovTJUM4h/Mny8nH2/0bYm4
         4y2rjm+Y5Zc220nP5WlXoHueNpsH4Kd8uJLuYx/seaqTN0Y3erkKyMeCdtTuTWngA0P3
         M7CMsJdYneyoUatD16jBSf6itVl6awFz+nihm+uC6Ff+vKazGL0k9yjiCu8iV/YDLDsX
         p8UMs5oyRChl0cBy3U/40UpEpJHDqBgbFBpDcb4q77kuNu9uwVZV1+RXPj1KITGCrRf8
         eBJ0QyH51aI5SHzL2aKSeSct7+Q2GNOa0rgpkf3z9gl3kizQ5VcUCpiawTCUlsXrf9vU
         HPng==
X-Forwarded-Encrypted: i=1; AJvYcCX1nX14+n9uEpz5VvWumhwd1WkkAvhBPo9Vy6OjN03mVSMHR5Cv/+gO3aeL+T+uNfhktm84wN7bf0XyMWpNrmIxfdEv+U/WhSNAIIpfi+Uc
X-Gm-Message-State: AOJu0YzVcXL6Dt9U6eOO3m/E18zXZcgivf6AWRyl4NZ+lMjBuhhpVnMa
	yUfLKxACPufeuE8vWcUASwWSDugzNuGItIcRYmgZIFRfvQr1xVljAW6MyCoLxA==
X-Google-Smtp-Source: AGHT+IFSkxATvfxvoXpDJxSlMvUknkklMdh5OB6Hod5HFKIXcAkHG5kSo9ueF/pxNq6xZIhvsXOYyg==
X-Received: by 2002:a05:600c:1d9c:b0:412:99a9:efa3 with SMTP id p28-20020a05600c1d9c00b0041299a9efa3mr1038094wms.2.1708765492693;
        Sat, 24 Feb 2024 01:04:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:51 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>
Subject: [PATCH net-next 06/10] selftests/net: Clean-up double assignment
Date: Sat, 24 Feb 2024 09:04:14 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-6-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=887; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=ONxj7Z5bQEyPpk/sK690IPfrd/nKeK9bQ4FibvhzH/w=; b=ApyCZf2dRuD/UzWSTFlquW9P+8yF76Z2re53ax/cuKzDykILrZj070hC8QcMGoC4IwTtCZu8w C1GlruS6OfTBeWvbTf2OlH7qHOZ+wdNLNRJO1kOLmqM21rYvr8mhC+V
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Yeah, copy'n'paste typo.

Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 15aeb0963058..0ffda966c677 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -379,7 +379,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 
 	key_dump[0].nkeys = nr_keys;
 	key_dump[0].get_all = 1;
-	key_dump[0].get_all = 1;
 	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
 			 key_dump, &key_dump_sz);
 	if (err) {

-- 
2.43.0


