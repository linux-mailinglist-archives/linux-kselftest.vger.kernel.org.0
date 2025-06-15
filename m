Return-Path: <linux-kselftest+bounces-35026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D35ADA38D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346477A77C9
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90EF280018;
	Sun, 15 Jun 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnVLFPvx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6526AA91
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750019722; cv=none; b=e5bhUqq6rKECNNenyhX55d+Pa2BnnI9gCWPZPvs/8EQG5xIWlRtdP+5/RIuZc3NLEDIEq4CtNPCDwIowMIbmdgp8NnRtQID2mzcR+8bQ215jMak42pajJs3NHlWNwy4JxVhvhkCZF1VRaHYjGQfX2C0VRkwPhsS3IWtx7Tmz6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750019722; c=relaxed/simple;
	bh=tL1PLzIyUqJpZNsRBF7JRfwA8Ed51h34XsLMqxuM5k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i367Uoi6Ejj4f3ajwkQFBiBKSZY/bEP+K5aLgUHiUd+O7ULQLpuHKrlyHxFonw1kuowxoQctT7i2kT95piNetVDjWgV9qX7+5QUX7wFnXo3PbhWPxJmjyrGGdsbBIwAAzz2V43MJEGqTOL4gYoOc1WwuY6ZKNPPYtivzBt/Brk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnVLFPvx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742c03c0272so4566951b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750019721; x=1750624521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=NnVLFPvxmSnJvYGAIXEcxlwjhP1g/yyvKA856KMmIyzjwlCbilh1u9njjcl5DdohES
         SSkacP0pTCm4qpxmOjwe7ruFIYkHHRFQzEkPt25Mg5CFNZBaQsjLX9i6Kx+4aVsXPe6f
         Hq3XLZo7Qg46QJm/HB1E1v/6QmtDCfKEux2y854v0tl90VokTyon9kt7G7unHOjQMoEK
         tYRo0ZzqeX2EdzqWeui+6fvi7dD2Oto1/mF9s+o//42gWfbSMNSH81LVUfzbr+LeiRZm
         v7/5m/6knno8TUytEWk8EB3k4JthJzTSl5y6/R+ob8ICz2J6CmUgcIV+P0QNU+mUIfTQ
         VZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750019721; x=1750624521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBZvfyHdUGl/wklBqtBO8YvE+0ucQlCTvcKf6Jv4wE=;
        b=wUBZ3b+Hvek97bzmS+CdyF89xW92hokIrx7EEJYnZ8Z3amMQD47QRZfkBmfcAmDjx6
         AlC+/AjobM9qLWG1mw36H70uqq3wHjLz7pAIIz6VOfZrXFNBscauAM93qRdRwUIGYCBH
         Q5WM44tjQMHWKzE3qBvrJeoGTkdJZyA7vlZ3S+BU89BkFGfcDVxNsvOLL6ko5wzCuagO
         DazfJ6kwv6ofkrY7wMofVKkVVgS9BkPpeJ7H6x8siRuGUH3zASGBo9ukLlo9cgpQdXS5
         IS4ATbMx8rZEJqQ2VBlOW+0qHYZjRskoX/CdZNCzX9NBjQ6zF1g6CjZ349yCAH9Kheel
         gC/w==
X-Forwarded-Encrypted: i=1; AJvYcCUjg04hrCvR5nzEc2KJ4D28DyrtqftPY7zk1Y896hZaiagvOMQ+pvOOuZh/GFGxeTgsrU09R0xR1BLtPgSCI80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72tAGURvWtQdGI8kr4eHf3JutAL//KRD7TUKkzMgaXBtA1liy
	7u0WMksqpuWjm9A6buzmFxplz9SMmecyx4GWyGJeNChnOfSSgUiQz0Tw3XzD8z9nDFYJKvm1dH1
	RVYnLDzuETkmBMqsKew8zwjxZRQ==
X-Google-Smtp-Source: AGHT+IFQlZziYA817lu/73yLmpn7sPVEPc394qq6+dQp9QPSswE2TkY7bl42VZyxldW6rQHZSvuUoNwrZd8E3gCohw==
X-Received: from pfbjo20.prod.google.com ([2002:a05:6a00:9094:b0:747:bd3b:4b63])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b4a:b0:742:b3a6:db09 with SMTP id d2e1a72fcca58-7489d02d847mr10802713b3a.16.1750019720698;
 Sun, 15 Jun 2025 13:35:20 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:35:10 +0000
In-Reply-To: <20250615203511.591438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250615203511.591438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615203511.591438-2-almasrymina@google.com>
Subject: [PATCH net-next v2 2/3] selftests: devmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>
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


