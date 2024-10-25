Return-Path: <linux-kselftest+bounces-20629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8269AFDC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EA3B23215
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C11D460E;
	Fri, 25 Oct 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Cyg77fxc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AA1D4144
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847699; cv=none; b=tTSfx+bLS+XV2Qi4zwcIdyysMQ1R4pvWWcLhJGxJTXhBuOwEcTc+Uhogq7MOfrFY90B3VuhFKh/cQJ79JIt51L+zpIFVKQjgc61neolfi5E3ali3dwaKE1XY6hazkEB5oNuVfKyI8HtMXXtP++JNOg6yOVrrg9djmHVjwDj8KJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847699; c=relaxed/simple;
	bh=fOSlSWYG0lgLVVr+ucCPo4U0dC5VQgPZwtEY48RC90o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7km+z3DnXYu9uO365Cbq+pftLyQgXWv1HZiQelei8GifnR6be9R1MZsD5yr8LZoK3b77J9BWHHeIlugpwO+Cr3gxVAP8fllLHSKMaZoySZ0z5Qgo/EqjNxgNUU0sENAxMbMB/teaQesQ0y3BLSNODesFaJDMTjJRsejHNqZtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Cyg77fxc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152b79d25so16998645e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847695; x=1730452495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGiZxa2E7sqtgONSAUC4Nmvw4dH7bOqk5a+o6Y88FNk=;
        b=Cyg77fxczIzaaCLVHtiu1NlATMezdPdPq6aoegkXH4farBMtidYitEEhQH1IQ+3pJS
         IeDtFZp8bU9vIlVwqgvbZKfuCtm3JHNRYt2gUTHKNswXHH2mFuAza87854lBdLd9VpbH
         UAO9cnyyzNWeh22GfqEtz3Fvpgd/Qx2UNNXe+gGL0/exLf1WjlpTCXT2MqMVFYCzYImR
         0Eor9kp3LwlE/B5aALgbEfKXszY41j5NDbHx2fnP//9SP+3brX9tbzJGq1Uc+S0mmO1j
         OoelgCZSTUvYFISBtDNIesun4x39uirXOAZAE9pQhh4wzzYSOT0Gzg+LPMu+ujFc+fTi
         HFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847695; x=1730452495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGiZxa2E7sqtgONSAUC4Nmvw4dH7bOqk5a+o6Y88FNk=;
        b=ca/G+id9cQWFSc0N7lNZsLrZczvNuBmagC21EQWuXxyVwa9lYIMKapkjwMKsLP6BsT
         dVFQ/rdYMBhJgTjRunGCiOkWcaZgAtVWZ3epHf0RowmmMGyVBMNbp5Kisq82E9IExMx2
         vCbzNg1DVTIlb5mFpKjT9+84rI19Fk2rJipXhqmaKdQhoMkK7CuPb8QWckSppkcjTnjs
         KA+IlJ0T6YNmxTw1xAg2GIQa60NIR6MTuAqF1Aa7bvjoBAir/+wlMLXFE4fJ2XYn8FWk
         WF1clwlwinj3UwqF+oJa8IiLyK1L7ADteJP98Ghxmqh1w858eai8kBqtRG7fNEn0cUky
         x9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVTI7qRGZzm0iOZrHbbzvCgUoPzlqY0udC4h2vRFjhSt52rFhH3c/vpMEmmuUIJ7su3O9lNA389Noyrfi0xdVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvxo2s/+b8kb0VTjrON1HC98X2yhR3F0e8YppTGMnC9t3OpTCz
	zbHKMrbJ4k33GulcvYbbfNwHQndtTedQCHC8rpnlEzMpoZ3ms+tMpsxfLybckuo=
X-Google-Smtp-Source: AGHT+IHLcgQNjY6XF/wexk7zHI6iIlLLnCqNadXogCHu4Bxoy+oBcneqJgSZUJQTZ3yMuHRWbvJJOA==
X-Received: by 2002:a05:600c:4f10:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-431841a2ee1mr82327795e9.29.1729847695008;
        Fri, 25 Oct 2024 02:14:55 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:14:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:00 +0200
Subject: [PATCH net-next v10 01/23] netlink: add NLA_POLICY_MAX_LEN macro
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-1-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fOSlSWYG0lgLVVr+ucCPo4U0dC5VQgPZwtEY48RC90o=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GY+CqSTO/jdHukrHMJCdtwbEC9mzBmFdyhj
 OmVr0RZTiWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmAAKCRALcOU6oDjV
 h+hWB/9JxKC/nWOHY6hmBJVilJ+fpAP2BM4RJfgaC4JWAdVOk8i9ibqoDYn0H4LbkLIwILQ2wdR
 S88TGfx1AfTU+p5ZJeX/oYRAjZBeNogA/36uJ/ErtD85f4RSpNKyzqJ+QH7HaRGbHNspy/X7C0d
 3N8NsSpHePbVzJQYQYcYwM5RViEs2F6+GJlT9H/DKSkEMY/e/i8OCaazAhJQbcU9YMy4QRqtzwI
 ahM6eXMVVe/Qf96J158GMODH1fcm5K9wbXgQYr1zoMiM6o3txt+o9kEoBCeXFk2qUqw1XEidvcy
 vhiGJz9w8bS1OkMuUVmkqdkMUXL2FQ+xSWSl8fbTxNL7oh7M
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
with a maximum length value.

The netlink generator for YAML specs has been extended accordingly.

Cc: donald.hunter@gmail.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/net/netlink.h      | 1 +
 tools/net/ynl/ynl-gen-c.py | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index db6af207287c839408c58cb28b82408e0548eaca..2dc671c977ff3297975269d236264907009703d3 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -469,6 +469,7 @@ struct nla_policy {
 	.max = _len						\
 }
 #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
+#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
 
 /**
  * struct nl_info - netlink source information
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1a825b4081b222cf97eb73f01a2a5c1ffe47cd5c..aa22eb0924754f38ea0b9e68a1ff5a55d94d6717 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -481,7 +481,7 @@ class TypeBinary(Type):
             pass
         elif len(self.checks) == 1:
             check_name = list(self.checks)[0]
-            if check_name not in {'exact-len', 'min-len'}:
+            if check_name not in {'exact-len', 'min-len', 'max-len'}:
                 raise Exception('Unsupported check for binary type: ' + check_name)
         else:
             raise Exception('More than one check for binary type not implemented, yet')
@@ -492,6 +492,8 @@ class TypeBinary(Type):
             mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
             mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
 
         return mem
 

-- 
2.45.2


