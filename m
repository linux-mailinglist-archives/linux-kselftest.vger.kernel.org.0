Return-Path: <linux-kselftest+bounces-34864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E71AD821F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D43B7F80
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 04:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60A25487A;
	Fri, 13 Jun 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybzfkIUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AD202963
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788908; cv=none; b=g2OMH6eT2Vy98O/kVFNR8NR+ynFvcQp2qP4Yh0/IlmxQBiZ0OABjy/Frz2DrBfqYR+g+yqYX8FN64DT936TSbx5Tt8fP8rKiCM01SMa87THGHQ56WzpplPaKphapty3lOuccntfhhyaLu2gSV1CrTS2buy8kHTK8h1ofbx9lHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788908; c=relaxed/simple;
	bh=tL1PLzIyUqJpZNsRBF7JRfwA8Ed51h34XsLMqxuM5k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiATOLpgQHDgeZ3z0U0XMbRMKzURBLRfYu8aJ2nHzkpBsssarbFnoyAc2LgewcT18YLQwFeSz+3PjKREGa4kG10FU2U2KquUVfPe/AcESfuHre8VbgdexP4F8HCgfmUTSoOc5tugj3gqpxoiDrTkENhZ2RCF3S+EHxn7TbCsi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybzfkIUU; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e8eaf0a2b1so1727101fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788906; x=1750393706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=ybzfkIUUFvxNbQLLohhlN9wgUJjkUcDYvoYskmX5arnn1rs4SdlQLvpOAfVe3Cfreo
         F4Mq+TLcq4VJ/3rSWmxc8+/4L+ce8NUPSwN3zCmcY1ayKJX57CfLlOLEPKXq5Pkv9dXu
         gnb0OAqsh0dNyRvYtkkNMIZzZhLtd+ipw13SLxTa2qVubDVHBSznyHQMAC5n/4IIy7aY
         IIjwqrj/UXixl32juXYGaDe0a8X//idNcN+kfYuGcP1Kzk4jVAz5aolPCy82ET64wKGZ
         2UK4w6kDUMnmYSPLMjRlVmQOuuHFuH4NvtEDyCOk/vrvPx2eJUn72AO3tCTF6LsInhKY
         nYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788906; x=1750393706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=DwMIL6r97dRLrn9ZTVywUwPw5Z/UcFt5HYK3PYfPY0s+FqMQg5dn/MAhURHfcSuCi1
         4k5W1uvcqiDy6+EVsvElRh4UEa8TdjjapcWBap/ppK521hmubwQ/My25ilvywHDiGRCa
         ov9fOqTFAfpHx5ONAHVw7C0Waqry+uiGPCQlPTs0P3QrESDibrnm0n9i+b3TjQk9n+mU
         KJ2vdI83T2JqbiISoTMdWkOTOo+UCvKpcoMV1m9bva4yLhpBaXVX9M0iInk9PjkqkWJ6
         CYT1NhWreGB2CnRP+gSthFIIfd6rozHQyM1vdXAKwbQIRA+DCXitv7RKA6p1g19umoOY
         A4GA==
X-Forwarded-Encrypted: i=1; AJvYcCWoaqXsgGRmy8JYwC00W5QxefO3ZNu2EpeJ0CAJpdudF0a7YDl1u+XjVMP9MCHmHYZoPrTIAcRKWr4CAXo4f5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzntKC6DEWI8c+kspaSBdQj4NOxzch65Q98OlUCo/KNvHLAWU+U
	Zvty01rJ9V9mzsW1bgYLP5lMEJLNOqEPov/D/Q/jBqrfCGvd4GZNbkNpLx3TNENijBffjWz9s+j
	ki64XZG+xdhuwws4lG7KqvcY2VQ==
X-Google-Smtp-Source: AGHT+IGE43XcqhBFW+fQotJi4fyRgEkRR+8OmumQVou8oP2GURUevvi+LmO0+PoZqsrLru+kQ4PW7qlbTdI+8ngBXg==
X-Received: from oabgh10.prod.google.com ([2002:a05:6870:3b0a:b0:2c1:6d20:7b92])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:de13:b0:2ea:6ec5:f182 with SMTP id 586e51a60fabf-2ead51d3976mr1007327fac.38.1749788906187;
 Thu, 12 Jun 2025 21:28:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:28:03 +0000
In-Reply-To: <20250613042804.3259045-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613042804.3259045-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613042804.3259045-3-almasrymina@google.com>
Subject: [PATCH net-next v1 3/4] selftests: devmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Trivial fix to unused variable.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 02e4d3d7ded2..cc9b40d9c5d5 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -852,7 +852,6 @@ static int do_client(struct memory_buffer *mem)
 	ssize_t line_size = 0;
 	struct cmsghdr *cmsg;
 	char *line = NULL;
-	unsigned long mid;
 	size_t len = 0;
 	int socket_fd;
 	__u32 ddmabuf;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


