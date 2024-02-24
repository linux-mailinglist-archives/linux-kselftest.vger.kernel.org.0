Return-Path: <linux-kselftest+bounces-5403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C584862397
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F3A1F23D12
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED841EF1A;
	Sat, 24 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JkdJLm/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2D18046
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765489; cv=none; b=eS5t/fYsSrJhB2cTRy8cfqad6gEiEGaLkfD7/FKPYzYwWMiFtO9qdXLTzF1EqO55rQ+Vs3sWjiD3ygK4X7F27oPoVemxGh3edTFew2LfjG5dClztNoEymtMbzKgz0ZG1rILN7aLVmhM4253y8T64skRnDDT/3cRzZl+tOh56kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765489; c=relaxed/simple;
	bh=MVFcWwkG7n4Gl2hWUwI00JsntCopPDcwfLrApRfCBMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5sB1z+onvIvp6Pr1bdLKcTo1RMAH+VFEnldaekQ2/Ys6PlJQ45SV4rb0M+lbyxSIeEZuQdqv/tGt7uLZC/lB52AsQw4OMYCGH50ygygl5o+Q+sPGypRAAukb5tNMPOjHa+RcW10XNAkD9YumpWMYMD74uxOpdmmlhV+5SO98GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JkdJLm/W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4129b4cef3aso1266635e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765485; x=1709370285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juqpa+YmJMwWq9ujgAmWRIwmIrMmMg68TxjW3KTtjMY=;
        b=JkdJLm/W/2E0JuRaSjNeRaBuvh0Q6nUFzXkuTjEDekShHSYiXMGrAJyzo08+y1FlAq
         4s42PdQmLfhcs2HCFUYY1oqDvamI4m6dax5rAfZuUepnswPsOYgrcL5fLrY8L5eB9nYH
         3+JsCdtnuGr5E4ZfWnHQVYh2tKQeZ9omPMsSDrzhog/PTKMgQ7PaKO/Ym5zaL+nyepqS
         K9c2Gs2cEHBryvnZd+aCFq8iyl14r8mEQUJz7cIguLr4EtxAyzSAkT+4HUjXv3zD8v6h
         r8/23pY3rzQ/D3u8fspW8blhHj4L9bsKNh0U5zLwOuLqVxBiV8tmIfIC9SMd6xW/Utc8
         Cekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765485; x=1709370285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Juqpa+YmJMwWq9ujgAmWRIwmIrMmMg68TxjW3KTtjMY=;
        b=dvdRLm4W3db6avfoUgV70J2SHZJeILAWdIKdm/qUv451ddr2CV5X2Ztzs/nMTH72NI
         UWKNiCu4dd9IaNufFGoOfBE8h19bbgyNtSrOfaqKSDFrRiFzcd0Teyqz6AUmYbttBv7y
         CBp1IoBclQg1LO+bt2XGjiLfAi7z4XUVzWF82ifI7I5s6nUlzLLPTs35wrOgZiXDsXTh
         mZhOqZZW5c/2g0OtrM0/rflyiYanmTRzdoeG/RhYttwINKXSs6GdKVOfsEtMNUyhTGsM
         woq0mOEf4AF+b0yAn8HMevWxVEWA8vGW53CXC0+OxVZpiEbWQJjrMpN3ENmNIQXfV10X
         go1A==
X-Forwarded-Encrypted: i=1; AJvYcCVhj8445XB+HUmFEWk/qEt6xCS3U2GprDzFjlgeul1R6DeWrORv8eE3JtWqZnqHmBhxJvBD8yVoTYBn6JCbiXNtIGi4k5igdB0jTtEgdqje
X-Gm-Message-State: AOJu0YznIuKvRO5BpGjamHTKUvy2CA56AyjqOE7r5y22DGs8SBBRESe8
	qI1tkd0eFUilD9F6vh62LonjN3YNeOi9fnT1MPeA/VJy4apziAmkTvJPfW3l+g==
X-Google-Smtp-Source: AGHT+IE/v4Y77xHfDfwUj7mgt7/JJNZWj546Xq0JHNRXMyVIyZqM5v5JOrhU5whoc/IWfYePwfpQdw==
X-Received: by 2002:a05:600c:4708:b0:412:8f3f:bd06 with SMTP id v8-20020a05600c470800b004128f3fbd06mr1948177wmo.8.1708765484836;
        Sat, 24 Feb 2024 01:04:44 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:44 -0800 (PST)
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
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 02/10] net/tcp: Add a helper tcp_ao_hdr_maclen()
Date: Sat, 24 Feb 2024 09:04:10 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-2-15f31b7f30a7@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=1223; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=MVFcWwkG7n4Gl2hWUwI00JsntCopPDcwfLrApRfCBMw=; b=dYV67W6rPZfpE9Z+hOApC8UtuF3cZlqJCdYtSwEPqPdI/XlEslH54K7WXEmeNVQZYPNjTlQfD rproo9nfyO5Ab6uMz3+AcGp19e8cuXGVCR5WBgvfXMlxprRbocWK6P4
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

It's going to be used more in TCP-AO tracepoints.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h | 5 +++++
 net/ipv4/tcp_ao.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..6501ed1dfa1e 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -19,6 +19,11 @@ struct tcp_ao_hdr {
 	u8	rnext_keyid;
 };
 
+static inline u8 tcp_ao_hdr_maclen(const struct tcp_ao_hdr *aoh)
+{
+	return aoh->length - sizeof(struct tcp_ao_hdr);
+}
+
 struct tcp_ao_counters {
 	atomic64_t	pkt_good;
 	atomic64_t	pkt_bad;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3afeeb68e8a7..8726aa58e8b6 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -884,8 +884,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		   const struct tcp_ao_hdr *aoh, struct tcp_ao_key *key,
 		   u8 *traffic_key, u8 *phash, u32 sne, int l3index)
 {
-	u8 maclen = aoh->length - sizeof(struct tcp_ao_hdr);
 	const struct tcphdr *th = tcp_hdr(skb);
+	u8 maclen = tcp_ao_hdr_maclen(aoh);
 	void *hash_buf = NULL;
 
 	if (maclen != tcp_ao_maclen(key)) {

-- 
2.43.0


