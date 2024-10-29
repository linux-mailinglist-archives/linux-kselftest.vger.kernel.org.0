Return-Path: <linux-kselftest+bounces-21016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286AC9B5485
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC1B1F220ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E320969D;
	Tue, 29 Oct 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3CCQu6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3DD208965
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235334; cv=none; b=X08EDsoO8XiBvco8Pxank3LsSh4jbWCxXLhvsNALbUSwV/dQ+aVd81oMQgtK1gnR0lH9e6oc082F3ibTnxkjdaFR3qhVb5sqlL61DC/nyOtaU8qMLF/HjchecgKo8045bmIjPDjIaqgA7FmX9Ac5+qHXPP73tWhIq+LlQZdYXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235334; c=relaxed/simple;
	bh=NpiPjVlAleIs97JWrTTn4QJPsC0BpJIKw9WCJk+Z79w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qDD+eVer122x9bJeKBq9fcy802hGH3LmLiuHBqkpxVKEMMtkeD3GDrufaTEy0uFwblczH4QVWhxtTSJ/gtCoffJxhjGi1eB9DG/fGaAbF8I/1iMVg2nWdPfLHsXhuoBYYuLmCwUlSIecpR/72+t/MjLsLkEOU53HL4+ayLpDyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3CCQu6V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29205f6063so10125251276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730235331; x=1730840131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtLM3BZMi5MIdFZN9lcNyhV6lseOB34DRhYH9xsg+Ww=;
        b=g3CCQu6VO4Ch+qwjkBGjxW2sSO1t5E9ViI4Q4t9LbNK9mBzd9gedI0pQh9SZ+qLcdS
         vXwLzlOR7Y2/RcC+qDMXcUrksdvnVJJzkt19/yfDnERR8JcXLouEgmgK8ShEvAxNARZl
         aHtQToG2wTNa90TG1J8JmJTPHgA7Y+QIXmqTXMBQmD32x818gu8PTzlfKO5qIhAEw6Bv
         KXhtH8kcNEWcjNfS5iel+R1v0krw5ya9EQ0FOpNuSpopoFv0qjAd6xOAo81PQFKD2KeU
         pWMu35EtbV3A0B5HNKdmGXcEmmVy0UVSISYTNqMv4PTe/Kk+vVNmDsMpnTTQ1RnqWDoW
         iqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235331; x=1730840131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtLM3BZMi5MIdFZN9lcNyhV6lseOB34DRhYH9xsg+Ww=;
        b=fWTtOdZWIQpEZA7ekYUSMB54bokmIQgqzVKbOCtyllZrEfeGckn4tTZuuK2FeX2p3y
         ixqS1pqDwt82msYdEak3RJDAXio9gurf9b9h0m+QQ/YWXWMpHxY1vhKAZ8VZV9AqCDKT
         eQ1WIL17cNgsWR8eWLIT9WVZ9ttQtQFTHO+7XvTDZ3EUGnIvsq7S7McmVO7keKPfyOXg
         fqihRVh+3o2xN2Quu2KiUWLVmywoerSlWnUbRqOFJjTk1NIKcNzpMKI/2UdRPxcQjWfm
         FJYnipzdU9MpSctw44kqVhQU4rV1VIhev/yWKscxo5U2cSg/Ixee8ys2hGIddBaYQ9E5
         pDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCF/cOsosDfoglOt79Wbk5AdshnLy6tuxsvtovQRCXDGaYWewOjS/YVd+qdB7V84FGpE3uHYpNt+TQ5165Dls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3+Q0vdHY75sJ1TIFyBcehLV7LEPZXCjgl8qpA8llnK3rYJya
	yozEEQKogpgRp2PZirwyfRnd4YzP8DB3xrU7bVoc2Wq0leJk2VHR+gB009DlYQrCpRDo56Uqu28
	uhZLsHLKdudjqgEjdpJgLAw==
X-Google-Smtp-Source: AGHT+IFn71lHuPHiTD9RgndIXcKae2ZOCG2qnAN6B+/dPZ7/I2Uz1eJaAxX4qOtQrBvdw/LPXzQJ1QqhI/OPErXQEQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:c78a:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e3087c2d8b1mr69575276.11.1730235331689; Tue, 29 Oct 2024
 13:55:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:55:22 +0000
In-Reply-To: <20241029205524.1306364-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029205524.1306364-3-almasrymina@google.com>
Subject: [PATCH net-next v1 7/7] ncdevmem: add test for too many token_count
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add test for fixed issue: user passing a token with a very large
token_count. Expect an error in this case.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/net/ncdevmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 64d6805381c5..3fd2aee461f3 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -391,6 +391,17 @@ int do_server(void)
 				continue;
 			}
 
+			token.token_start = dmabuf_cmsg->frag_token;
+			token.token_count = 8192;
+
+			ret = setsockopt(client_fd, SOL_SOCKET,
+					 SO_DEVMEM_DONTNEED, &token,
+					 sizeof(token));
+			if (ret >= 0)
+				error(1, 0,
+				      "DONTNEED of too many frags should have failed. ret=%ld\n",
+				      ret);
+
 			token.token_start = dmabuf_cmsg->frag_token;
 			token.token_count = 1;
 
-- 
2.47.0.163.g1226f6d8fa-goog


