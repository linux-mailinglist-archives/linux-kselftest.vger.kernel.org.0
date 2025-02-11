Return-Path: <linux-kselftest+bounces-26290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F453A2FF67
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AD73A86BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB21E47C9;
	Tue, 11 Feb 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gzV3Z2v+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED91E3DD6
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234478; cv=none; b=EeqNbxFCA25m0eWxCzxD8QdSoAQ4VtEtiRA/+SehdLsoRal3gZ+brtAv6zypqKp2iyK6Fp88l7VPx0B/2qYVHFSap6n4HQ4kWXJyzypoi1LUWiimUCi9yJj06XMBb+v7hi97GD4ZX+T1kJOwaxbGan4ujkyKesU0CkbAjDFQ1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234478; c=relaxed/simple;
	bh=G9MvzYO3Ny58MIPU3gEDrP/93Du1klO3eFnBz3MwfEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDRO8eknLq73dv2x1l+at7npmT9+EqNHkgcLzKP0gewyKaaqkoWHls3OhdWeMnbs6U4+b2ZgeLoxog6eJQ7i1Sd7L2DJt0ucB9ulX7Gr+9LPR74/+/xjrEHHgw1fo0Rn657a4NxuyKCFUHOmcpR2LU3N0khcd6aaegNyY1OPZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gzV3Z2v+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd93ace00so1174997f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234474; x=1739839274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrEXm5KUMO8bu4cOPykFFzU59kwJuQPspTdEoef+/X0=;
        b=gzV3Z2v+WZr3Dud6431AVCgDALaayJywERoQxV2IfPCzcRj01Che54hPvE0bl+4330
         XFPBLfW7fN8jXaTW0tohbcF6mubL9JF9YQ1l/EIIBFopvStdFL9LnW2y3XdYFlsxIlkZ
         794TwiBaOj9XbyTe/1TZ6qksUjtPGqZ69KmOWtqfzlT8prBkcvJX239UaAx6pHq8ZgGo
         gdS6arf09lqY/OOZ4umGHjRrAZaLGJz7eNFTRaRI/FUW+iUKJSBHEvj5UYppr0shdepF
         x358Qfx0UVeUI6CDs8VRPQreBoHEa4Ee6r8a+obzSBSQNLdl6EXTHY243gIuaaVZRkRi
         wo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234474; x=1739839274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrEXm5KUMO8bu4cOPykFFzU59kwJuQPspTdEoef+/X0=;
        b=V7YZ65CnGLwngCMOCDD550y35zjc23Oljfj6FjwX5uuLrZ5zZRU6f34sM/SkuFte2H
         whlgYjXoSCBEYwfhZAaakj8esfGlsHHlo8EYrmn0oQkq0GRal4vD4NEqsrzjomTEyFlk
         YNsXMHf/unv/vjrGuOqSv9c41IbZJfhJ40sSmmMIakq1nwImpvYCIk5SugNjoMsJZ3+F
         /KRQjzkCtmFex7C+BhhPU1Bv3Lq4us+eKVdC2e70llPI0/HxkvUxd3jWyFDoxrQjpDUb
         h9lIO2w+HU2vTikW01sA3X7KrbHCVhWK9wOIU1f38gyn2VmFDmkBbpgrnL+4ICqns3Hw
         H8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVOZBlgylLGrP8Xg00zZmSUwhbiRvJeLLwJ/PEr1KWFLDfmxYU/mzkgAKOqQjF5XV/OMpXuP2D7gPLvWXrTSrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfrqFOa5hVrMTUEYkSDGXPjRtuDUBInT7Di6mr9OLPe+oy5Xe
	38vHjYljO4OwATX6xr6guqZwuq8CRoMr6gHiEsyBlLW3P0ibXqWw3Lqm+icxWnw=
X-Gm-Gg: ASbGnctQ71/eiV/chA1Ilxmd/g4iQvPQk3nwX2hWigabd4IKo0amiWhCW6ytr+4orQa
	w41Z7BDy/JhS55yajOPn4pueTu8STHsw+qdzTl26mwQlfw08Cw8l9+yP9YUolOSUqgXJAurX0Xg
	aSxoOTfAgaggMAoe/534qrWFrKFa2TbRFQoeJefji9mXr7alcbtd51X7yFtAwyivIAvkRIY5HPQ
	iuiOvCdE8rNFapYvHmE0OIO8vN6rNIgs5oCbnMvXqpKVWHRzJaJx+REMvk7oVYJ0ySkBHyMJgXj
	EELU3gDc5ZdZpkX0+1tzlpO5cg0=
X-Google-Smtp-Source: AGHT+IFEvAQ8oU6tPW2P71IYr9BPXZM34giANi4cHxhLRkH+SXRfnHxvZH9cCQFtUS7HlHjYaBlPFQ==
X-Received: by 2002:a5d:64e3:0:b0:38d:d4b5:84cf with SMTP id ffacd0b85a97d-38dd4b58773mr8481281f8f.5.1739234474070;
        Mon, 10 Feb 2025 16:41:14 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:04 +0100
Subject: [PATCH net-next v19 11/26] ipv6: export inet6_stream_ops via
 EXPORT_SYMBOL_GPL
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-11-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
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
 h=from:subject:message-id; bh=G9MvzYO3Ny58MIPU3gEDrP/93Du1klO3eFnBz3MwfEM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNNNEbasLJHjbQQKAHJzCvFMV3DdV899psE
 U+bNXJ4a/yJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h7UXB/4v3kLDFmgBy1T2UzT9VU26GS9qnrxnH3kBUKbjLy4XTftVVXVQ9zB42hxUAZBzaGLMN1X
 pFrZIR86b9cujt5p2ZhoBKmOz0bBGFJbeQcoX/rk+IqA03D/naZpqG0NNhfRkGpr7ojC3hOFRml
 ErBXzD0BbEB7SX+/DUlCpIjaF8G5Vj2faDZ3vyREMEOld+hMCE/Zimhet/CfocXoMFbTjGdInBk
 XGipqycn7IZr5dEVjNPz1SA1WzdYU/VRpnGCkfyvJDoexGgTJCPHfN1qD1Ma56RJIZyjAVlYfbf
 eaw109OFmpM7IGIDqLM0DxyPLjFGCSR9LOXFOWV5je9uWGSb
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
2.45.3


