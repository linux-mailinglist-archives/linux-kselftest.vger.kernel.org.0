Return-Path: <linux-kselftest+bounces-19791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFA99FDC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495D4B22898
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20513BAE2;
	Wed, 16 Oct 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QtitJG8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2A762E0
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040624; cv=none; b=FTjFqrXrQI0p3p9sH5P7zB2o58NHa3Uqq86lDGTZGRkC0kdv3b/jK6KIU2TWi+O5VyMBEoBtxNbkJpVRSoZndPWY+DGczPf58gCOeaY0/uRizSxsiAguojulthSPi1pvvuewyCSU2jXhWJn4P7Eq1jiSaW+FljqWXHuM6KrVc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040624; c=relaxed/simple;
	bh=YWzfJwwDj9H33yTKqyIsks1NPkpejrGE0PuiyJ5QhmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=larcBctwtlaxJ5GbPUMn7ymhlb3ook4w8ovw4KjI2Voq8+V1LWraLcA/efA6sX4BtFfE+wZZ8H8/a9ZbiUgVZc4zdtn/eBdklV3kGVzduwVojwn/7u7sjZWiGOEqHytPEx4/rYNc5kwpv2QihnkvdrCV1yVDuvenT8MgLJir8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QtitJG8y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d8901cb98so195637f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040620; x=1729645420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9GdUbPvHtzqsFu2h4/Im5jGzt5vX/Qgs50BtWNazkE=;
        b=QtitJG8ygbhw//ICLnRY5t9+9MgAkTQpl0xfY3FGilgcPCzt4U/a5+bjVbflQ5mMWn
         aJGaAJNEVLCHJFamNbTmELeBlilanctjFV3gxw4n/ZkUBxUMLKmi8VLYVykTcTgKyFhz
         h13wd9DalJRNbPL2De6wwTOBvv9xRRDBfN4eoGV8cYUrGcmxXrBcqLxZpexLCwL1quHW
         2B+pT19F/W1UEyR5ad2+p1XGzsnKXVPBRrrfUBkY4SMY0wGayjGF7DVkWhUYy9rfkLPc
         ya+nBbUnpfUpwM5poHJWaWJ6JxbA64OATN60c8dwUns1taxiPlbTW5x6qQN8OmfUmJPP
         NbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040620; x=1729645420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9GdUbPvHtzqsFu2h4/Im5jGzt5vX/Qgs50BtWNazkE=;
        b=dKRK+aNh08SxSRkPw/2+5L3gPqLiaZ+H5paXTW96R+4DeV0fADF1PssreUnxNCIfZF
         ye6zEHs0oUUk1ctZFxiMnCPpbdDaaccGvUEcpXOLWJFWKCJKwrlcDxRZHseKKRTShyv4
         2j7UslK2Kl4mVueZQ2iDa2KzChQPqSBDSv5kOic+lnJBc3FPwxZeyB1XS8KeKprTogTp
         x1Gqa0vZJfYFUp9JNwVHqTGqq96jdQcQF1MeVw649pHl9p36EQUm8RZK+MyQ1OHVFNag
         Ur4QL/T3T2AEypBiElQik7hspvTpkcjI1JRn5JFCqO0cJyc683unAvTcP/S2C8V8jtWz
         XfqA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTfEStEB+qqlr684aZ30e82RkA2lx3qa+O6jHf+mxDR4U0TEl8VEIbXDRo8TtYfJUEnPjb7bvxMr34wxvuPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hiYZ7zxPAwonstmIEhkis+9IBKO8+gWrwQOxwa+6xLHfMZhS
	6KJqIKJwUCuu/TwggyDTwWgojrUNnUUSu4AtPFaKWJq6e3EfErMcBM8lQfUm1TU=
X-Google-Smtp-Source: AGHT+IGnhSAmGLGUDKKbUqvI6y6PJo6IA+NC1DmkR+MMI0dzKNGfU/PKwcleDFpP8R8tmigj6tcp+g==
X-Received: by 2002:a5d:591b:0:b0:37c:bafd:5624 with SMTP id ffacd0b85a97d-37d86329aefmr1528351f8f.25.1729040620564;
        Tue, 15 Oct 2024 18:03:40 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:01 +0200
Subject: [PATCH net-next v9 01/23] netlink: add NLA_POLICY_MAX_LEN macro
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-1-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=YWzfJwwDj9H33yTKqyIsks1NPkpejrGE0PuiyJ5QhmQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDudYwSrNv2JxTj0AACirqozqaUNwxcVn54Q
 sOfOYs8hbyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7gAKCRALcOU6oDjV
 hwgTB/9SsO69NczktOYtzGXdzG9nYDdyCJ8UPQAROWiG8V/HoF5ibInTrwSYNc6Ot4Eoxtxvx6D
 G3SHjSpbyeN0F0AuCfNztVYN/RyKBT16gz1KkJx98EEm2lMZG8KYjCOmcBbnWJRH6yBo9xBJJG7
 xFoNKmxRUJZNAFintQFuETYwyZzPdf0bOc3OCDa/eQy5MAqUd2m9qKRLMhnVTZ7TrqnYPNEqD4M
 6eNkbReTbtv/uNXG493MiHeGahWTvXYsSQN2+scPgWuTqbRW4pF0Cyq9BchTF1NJHZovTRtutB/
 HOXj17O2jFC8MdOD1cHlcyfLrDMZkvgeh64TQpLILAnkAl37
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
index d64cb2b49c4437cfc018c669dadafdb43037e727..89ef308e56bbe287aee81e118f45cb951df88046 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -478,7 +478,7 @@ class TypeBinary(Type):
             pass
         elif len(self.checks) == 1:
             check_name = list(self.checks)[0]
-            if check_name not in {'exact-len', 'min-len'}:
+            if check_name not in {'exact-len', 'min-len', 'max-len'}:
                 raise Exception('Unsupported check for binary type: ' + check_name)
         else:
             raise Exception('More than one check for binary type not implemented, yet')
@@ -489,6 +489,8 @@ class TypeBinary(Type):
             mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
             mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
 
         return mem
 

-- 
2.45.2


