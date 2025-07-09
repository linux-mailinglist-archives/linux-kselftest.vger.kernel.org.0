Return-Path: <linux-kselftest+bounces-36812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D851AAFE3C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DF04E5089
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653E8274FFD;
	Wed,  9 Jul 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWl3Ceft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED62AEF1;
	Wed,  9 Jul 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052385; cv=none; b=kMNfrmCD0VYj7dlBpme6SOXxJ+FFnGg4RaWp7yDIMa7jigzk7fPkTv1a3tkZ3prJurP9DZ12yy8DLFW7U5JZ6G8iLvGzSJWYSq7bEfP3McmXM5SYb2EKNhTufCfhiYdO2OC9PsyT7k+LiP4ZxSYYJNvvyKp8vKqvr4sOk3YsAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052385; c=relaxed/simple;
	bh=DgRV8aH3m4n7TW8MORSgVnp7RcOBeKCgtETsqrVg7qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrhD6xWDqomBk4eofBPl+4GplUa5ot3uCwTvufmpMqW7Zj6NFwPl3OJo/e1uOpYz9qyiwrIgKtAxPAA7yMJoP9xOiotYJSdRf72bIqfSfEu5tts4EPG9pli9AvEkJG7e5RKao+uUdNy4sF7Grj4VzKlPlwk9rWslAZn+hf4REoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWl3Ceft; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c8f179e1bso49125405ad.1;
        Wed, 09 Jul 2025 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752052383; x=1752657183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0EtQ667+oA9hVGNX4C1visNhQyJhN+mdtuXN4Qcpio=;
        b=TWl3CeftHwEPAuLPUT0mjPK4D6BgWPVifabMn3nhCLFRiTQ2LBmO9wFxjEUT/LJCWb
         uyT30RSBcMSWaY24TnOnN8pp3P+3KHFaYfOocm6DS+rtxCQBQDuzg8fZq21UX33AQw9q
         eB61IOxBG2FeVun2YItrf25f+NmvIGvBD+WUHoRgTjuldF/VSnhxGzfw1GmN6bONyUfk
         MvQBjG1NDerczpfFCTGZfJzB/GmK+DpiKwLoOfH3MnNyteMStIvXl2czWFmOQGSh5P5A
         +1EXW8Hf7Rqtl8hV7VJbdj9GHAcmYEK57mcjR2uSMmiunD732OFsd3IKzv3rAPvrEdBe
         Yu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052383; x=1752657183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0EtQ667+oA9hVGNX4C1visNhQyJhN+mdtuXN4Qcpio=;
        b=EAwLyGz1V2/aASRNqofIgBTI3fCLZkO3Dhmxp610A+RqPdhAHo7b/ED/4i1gyH4ryy
         fdbiSDk45P6Ng3sEmA5w4Jf2syBZRMFnmwn/yPbIXR9DX6EJ3XG9y79BUv6WAaVS+Zi+
         SewhBZW5gua5XyL+ovfpzLfl/X5+Q9wb7qojFf4i10K45iuLEUQ9nIG4idxDkfhZ+8xm
         eoC/1hUCd3dLRv7P260FgElpqiAuHnKhyxO88zmr0KjW8S2MZT6edgcjs/AyViquIbH6
         d8MO3pv5GsICb3L4nbzNXA7zB6W50y+Dnrp6E24a6cUZm5jKiK/ZLsLd3GgtMGxzTlAO
         FIWw==
X-Forwarded-Encrypted: i=1; AJvYcCWBtmmqj2I+dMFKaRwwhe98IWKBfaGGNQiLVhIhU1lFHUNcuE74DPY15BaNlS0j1ECHsqYsXyZopOUSJ4Kdmrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aJyrK2rUNv4YesnqLvtMVwDnRxglrjRpk86yVlbxrX0Iywiz
	l1jCFISNryoSqA+z/CwZkLrcU5GuPiwVyNaG8TZQu/icRlezRy5R/Bj6K8w0GIsDEr8=
X-Gm-Gg: ASbGncs0w9raItZ7uLJDQGywEEODS2HinS4lYqxMb/Gl7K8BhDguO88KfjDMeDqQuoJ
	o0MKJ4Xn9AZlgGy7ya1FEi38nepPlbHq9zoFVq2Oe53ufs6cEiBX3ncFHb9h9nfx9/anblEZe6B
	4ufajP2PsPC4gdSI4kWG+JLMibjsz0C7eXTFoi6+65Ql9z6FWQdov9jl2KCuEkHO4D0XNvvAm6G
	BNrBJMalKpuvaf53IoeLTAQc79S0e8Ki9tQpP6wLMsYP7AuGccpkCh5e+XjUyCuWTLLbj9hEc5A
	P33+APg4kSZcchraSpMbr8Jjr6bE3uusoPwYVbYo/CW6oiWxFJxLgrBwAjg85A8IlsrsAkcXXW/
	AnX3J5xD63ZQ=
X-Google-Smtp-Source: AGHT+IHskOVUsLmY2F5lK6noeT/D59dONFBJc4A/cKo1GOtt9fNvzu1Cj6Gzor3N6EnlHY8Q38TBvw==
X-Received: by 2002:a17:903:2443:b0:234:a44c:ff8c with SMTP id d9443c01a7336-23ddb2e210bmr24244505ad.18.1752052383174;
        Wed, 09 Jul 2025 02:13:03 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c843519b7sm136684755ad.79.2025.07.09.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:13:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: net: lib: fix shift count out of range
Date: Wed,  9 Jul 2025 09:12:44 +0000
Message-ID: <20250709091244.88395-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got the following warning when writing other tests:

  + handle_test_result_pass 'bond 802.3ad' '(lacp_active off)'
  + local 'test_name=bond 802.3ad'
  + shift
  + local 'opt_str=(lacp_active off)'
  + shift
  + log_test_result 'bond 802.3ad' '(lacp_active off)' ' OK '
  + local 'test_name=bond 802.3ad'
  + shift
  + local 'opt_str=(lacp_active off)'
  + shift
  + local 'result= OK '
  + shift
  + local retmsg=
  + shift
  /net/tools/testing/selftests/net/forwarding/../lib.sh: line 315: shift: shift count out of range

This happens because an extra shift is executed even after all arguments
have been consumed. Remove the last shift in log_test_result() to avoid
this warning.

Fixes: a923af1ceee7 ("selftests: forwarding: Convert log_test() to recognize RET values")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 006fdadcc4b9..86a216e9aca8 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -312,7 +312,7 @@ log_test_result()
 	local test_name=$1; shift
 	local opt_str=$1; shift
 	local result=$1; shift
-	local retmsg=$1; shift
+	local retmsg=$1
 
 	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
 	if [[ $retmsg ]]; then
-- 
2.46.0


