Return-Path: <linux-kselftest+bounces-23864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C4DA0098A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F81636C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061D1FA831;
	Fri,  3 Jan 2025 12:58:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20771FA163;
	Fri,  3 Jan 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909098; cv=none; b=h7VZFD+Jn6p4qNqdyUfXuAiYmtS+YcQFU2lEIcl3msaixwRvbMSarWs+2HMkvXUCydNGcoRsWMiZTCET0F1d+Uny9jLCkHGROk0G7gz0t+g+oIf8ui8kD87Myxd2VIcgWFi5sbGsFzkHv4LhcHIRs1GI03u2BQojdbnSUDSoDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909098; c=relaxed/simple;
	bh=b0dr5T0QwnIxuuEvkRyv8EVkHvyXW4ldpeHd7C+rkBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5rosYV7ima81m9G9t4rb6AaUui7kE9nkRVdZl2UtBynyLpFC44hjYpp0CzMoNI4xYoG8Tz80bs2ENrY1W6IBSlfQ2jMGEQH9855fvai3DwweWSdPq/Xwr2jbzqHTUB96h6aiwsmmNu+ao/XOYLW3QbNZVO6FOGlZ5y8Vk0RCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so2019028666b.2;
        Fri, 03 Jan 2025 04:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909095; x=1736513895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Psq5v8QcPJKBmtJbh0DGeIRlVIPLBPUK0VHBQQ4Les=;
        b=dzmOjDO+rhB++nFsudhTqlNsWDXjmtQeAoTOpJoHSggBb3FMA3aAuZt0p4ejJZTatM
         2Hb8yXaNIBiXln2KB31o6IDO1WjdAacg/J+j1jaTUvFGh7zgj9Hktlez129kzwJpW5lF
         kvxTYwp0jWHTDL2KE5FVYZqoX1egjQJG8h4v/4hZFxsiN8hcpHcUkgoeS1RiCAuuK86h
         SJDL9LTyxCPgdPCTYxuk5iZBqt935QWlxRRMdyC4By30LSs9wqxRmlLmLi0Gfh/RlXYC
         IMh+nCAuow1c24RIqUK2Fq6LkjwZJtLvVM1vSUd6zyXIhaUL2zfdwOMh1Opx3aiIoGNR
         Q8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbMKL/d7X7Yf+yX+W04OGyz1Bo5YKcsYXTm3l/0Z4p2m0LxhtAOYM6E3r7GwFvAfKja59e0VsQtr+qtRnqPcbH@vger.kernel.org, AJvYcCW8zmn1aDvLZaR2kK+CIa+LFiXw4/CMSBPolUxsR41CNoZFAocj2N3ydZ+FCjuJnEAisxbisOU5Gr5wA/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalVBqrkfNH4i3y9269XKMdEiNHk1kIRtxszfQS40mM7OTHmbf
	adEtoquBkV4kd2KJHnkloZvWmbU23H37rOBnWg2NqJizUhWKtudTgImhIw==
X-Gm-Gg: ASbGnctZedr6tEZEKZC0doZN3mQHEo3qj0Mw9QKGOI1+Zfnvhd+MlY8S7THOtqh2Ary
	Ee8gU+MH62LRjwBwI8rhphYoQRBxZeB8UIUrpHLbP37xRxotiqD18qoxNaATtzzQJ4wihwgGcd2
	mjJw6zq2hCE1kE0aqYAtAPvFzlsKEi26Z1gIYlisTiHXaDcqho6WvhizNbsAwyfVxb/G+rCy0k3
	ZlakrhuJ/8I/T/vqvpyxSYrDHVuBCOsDgyYfaA1h/Fv5IQ=
X-Google-Smtp-Source: AGHT+IH91eUxxXQCMUe9oLi8Kk8U0ragcVDdmvo3IT+p+2LBh3LFLA6cGHMLOlViOzICb41aV5TmQw==
X-Received: by 2002:a17:907:78b:b0:aa6:af66:7c89 with SMTP id a640c23a62f3a-aac271333f8mr4365926666b.5.1735909094697;
        Fri, 03 Jan 2025 04:58:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e892bb7sm1877853866b.43.2025.01.03.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jan 2025 04:57:49 -0800
Subject: [PATCH net-next v2 1/4] netconsole: Warn if MAX_USERDATA_ITEMS
 limit is exceeded
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-netcons_overflow_test-v2-1-a49f9be64c21@debian.org>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
In-Reply-To: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=leitao@debian.org;
 h=from:subject:message-id; bh=b0dr5T0QwnIxuuEvkRyv8EVkHvyXW4ldpeHd7C+rkBU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnd97h0oK6txn7150mY+xpPpjWtT/19xVuCeDf5
 hPYTsWhr4SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3fe4QAKCRA1o5Of/Hh3
 balwEACkqgwD3O98j2HBmmstJth3Kr5KTiJem1x69v4KRHVWgJ/7dPLIPxJxzeP50AmsO3maV1M
 kZyB0HVVvJm+6MfddFu+CwbqZ+Y+wPkam/bZs7HcJpWzlvv5hRp8Dpswg+QhxWyJfYY0ea1EgLf
 y0tT8wzyLsgd9Hi6EUcjhA7yyiiLSQcJ/AeJtdyiw466yrmrS22msMqi01ksOwhpT4oMaqHxF9q
 wIwkI6FDCdd+Tpvkxh9KAtKg2f0WWo3H9SQVN1juJvxE/nhmyDlydQmQtdYE8x3a81yWk5nsG+y
 JJ1bJFtTbbhcJn3LAu9dSpqSnYGFaSP0sYdXNxvDAf/ZEfIXNijPdpiGdXYrlfjdcIbHibR9wPu
 w58gHxI/vk7PDnUltTRelm/8lnKNRu8TSmf32vZFrJBO8PGHg1SoN6HLeTA0k0HC32JJkqReuwI
 ZZeWlZ1LxKzuT3KTSzhn7P/JuNhSJii+hhrbDeG4/f9pONHqwAa+kMOxjSm38wAELT+Sm1V+uVm
 OUMlsxH61QhCAl6jfAUVOXp3yTLPWqrW+Vmdq32z1pFSnvVtTmoXKqwudz7FPe43n/VsFYkmP+x
 uFS8pDNWLtt+g3nU714B4ISuenuj7Y20QeQitdDmOHZGDKsJvndBlh7iLXxKzoekYFWJliXp0nF
 BVsxbeqmIqqhaAw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

netconsole configfs helpers doesn't allow the creation of more than
MAX_USERDATA_ITEMS items.

Add a warning when netconsole userdata update function attempts sees
more than MAX_USERDATA_ITEMS entries.

Replace silent ignore mechanism with WARN_ON_ONCE() to highlight
potential misuse during development and debugging.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f422a2f666ef2276cf5b10e1dbc6badbc8ef0038..86ab4a42769a49eebe5dd6f01dafafc6c86ec54f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -730,7 +730,7 @@ static void update_userdata(struct netconsole_target *nt)
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (child_count >= MAX_USERDATA_ITEMS)
+		if (WARN_ON_ONCE(child_count >= MAX_USERDATA_ITEMS))
 			break;
 		child_count++;
 

-- 
2.43.5


