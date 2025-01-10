Return-Path: <linux-kselftest+bounces-24256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B279A09DE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DAE16A412
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7D225767;
	Fri, 10 Jan 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LObea50O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55552248BD
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547991; cv=none; b=F85n3/MF+NnPY18UYDo7wYW8tjkNAOf0cZUzAvZAZqadGj3oowTuLVGSMu2R2/NTLfMto4fhL1ed40Uf2fn49OyvhDW9SNvRa8b/hh1V8hPTgXh6pIEiOpBVaWjnq1leoUUH2wT8tTlxhJ/3h792ULI18DuWnFmsne87CkeoMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547991; c=relaxed/simple;
	bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEW8Hacjdr5eS5szD5jd5V0Vsb/X4HOVTZr2OroHUs0c7cmiHD6GOtF2eTqZ2Ph068xh23T7TCli+XMyNqSGmLOaGyRzxFwj0yBuBOAmywF4MWKJgOdY92K2tPSONO1LV0y4COrjVqHZKbgcwhAeS81cLpj+i5aVkpMaJVFccVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LObea50O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a39e4891so18706655e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547986; x=1737152786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=LObea50OOkhOi7YExUCiGGM9aHNwYflCRm03k0diseAmuQ4HvDI58+zhrXQbe+eDJA
         DH8D7x6Bs+cPYalcZSknAFJQLHkVXpS5oWd/3R/PmEwKoBefIuQCHfS5tCa+a5/pLbRg
         dqT+dRGZhy20txDP2abuJdrvVMf3xTvzafDfVWxKKy8tLMhgCn+4q2RM103dYii0sue2
         BfyRVms0ejGlv2Atxtoxb9pB5nk9SBwXBHQwaNshjDwhiBHaLlwHRWq9E5Ol9jOEr5hF
         VdSRm5mH1cGVdZwVzrdTWxaL5IL6F3nf/JtUBf4qTROkreRG2H3zpX1tPiVUs8rujlgj
         90VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547986; x=1737152786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=TzuL0Q8zaZf1rS3AM/sxF4BdWSpS1T1U49L05UfGsCG7CxLw5aJ+E1EKwN5XP0JKLP
         x0Zkkv0CHF6SnUv198VpaRRqnSCrYdJzgRppQlwPb1+OJyrAquQ0yWicFmDlHTMwMgHV
         VEEBY1AR3LlvYJ1wrloqbeFLKaYga/YCJZei6q9uePOQoFOuYcFF4MPyJPsvrPNFIPz4
         9bYqwRrZmwQLtAaIM6MUFG6v8a3/waU6E/DpfslxYAC1DkHEiD9CcoFfFIxAzojeMmMM
         fQE0cw/B7X7QkBYe6gsIpRissP4J3UHwuMlCOYjfbHjG9umLjtOrprfQQ+uDI0m+MNKp
         GcGA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPW7UF2kOuNu0P38Ef9uKVl4IZ24JzcowsEIU2cMQcjUkbHHqCVsCLDLRydpiQTCH4e0IA8Nsg950/53Z2/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvnRKOsxBELo+kmMHYWmcXscn67bx/UT1hwElDARlWKM/oeN1
	MVUzy+FeKHI1Z4Sij6G6PHprytuHEiKMML717lxlpEsiGxlOv8c92yfbhOzEb3Y=
X-Gm-Gg: ASbGncuuOhxTSTX3qV+VIEYfpUV82brb0D7PdQEm0i9kcd0AEOa313wLyhYBZI1qPwy
	v6vxmFqXeQsItlIkpKk1X8uMymaKPnkVFlbmEAhaWPH506D6E09PlIAmLWcv75OAQ2coSPCCSXL
	nas5kUq6fkTVsX74xulh2osQmLBX/bC3smtuP6NGf5NS95sr7kNgTyO+kJ/ckHkXrXHRzJvvqI/
	tLNJPQjzWlASxYYn7uS3yQyj+k2LHXQKE7bTRZwbHsl8YqGLrJLkgbEHgBzNTiqZHZF
X-Google-Smtp-Source: AGHT+IH0Jj1tfks439GTP8TiXGh17Zt0H75JpCO6rncqDgNB268n7Q3X15lEk/6c7fjxzewczqrBqg==
X-Received: by 2002:a05:600c:3b0c:b0:434:fa24:b84a with SMTP id 5b1f17b1804b1-436e26d96d8mr100203245e9.25.1736547985874;
        Fri, 10 Jan 2025 14:26:25 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:25 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:27 +0100
Subject: [PATCH net-next v17 11/25] ipv6: export inet6_stream_ops via
 EXPORT_SYMBOL_GPL
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-11-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xXJ3P/5MXOMl1UskXkMiBnz1LmzJrNfdpA
 gJ50D1xAg2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h3Z4B/0YWg0zeODlTBv5lEWd3Psf3Fs0EbMqIfdMPL4nWnIj1UnN8guoK6343lZ3ySHLTYV73eA
 dXQaTBhEw8Dpo8T2P11QEs/ohswWNHTBjv8TxT9h95GfPguYe3lXqZ8gmOlbQAw8jfup07dbxoE
 blW2DXUsvEP/byYcQF8Kl05+mQbNoHx8pOXnlSfwUqZvX3aAmvN/tLopVhkYN3UFzmEF5VAFHg2
 nL9uBw7HtQ3hs4VykqaEHMS0BF1p/jRH3dE1MqvpnPwNaRt4nyNPbddcrnNL3hDlVwrFF5reNaa
 cI7mBQMMYf3Lwl7JhIL23BeL+gxCYg9i24ZK41uggwWC/VTR
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

inet6_stream_ops is currently non-static and also declared in
include/net/ipv6.h, however, it is not exported for usage in
non-builtin modules.

Export inet6_stream_ops via EXPORT_SYMBOL_GPL in order to make
it available to non-builtin modules.

Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/ipv6/af_inet6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea40b2d635d802a3bc4f9b9d844417..3e812187e125cec7deac88413b85a35dd5b22a2d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -715,6 +715,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
 };
+EXPORT_SYMBOL_GPL(inet6_stream_ops);
 
 const struct proto_ops inet6_dgram_ops = {
 	.family		   = PF_INET6,

-- 
2.45.2


