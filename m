Return-Path: <linux-kselftest+bounces-21588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D39BFCB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 03:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081172830CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0C82866;
	Thu,  7 Nov 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELgjQHcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4344C94;
	Thu,  7 Nov 2024 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947481; cv=none; b=nLZK1HDQMBrVtHfqg+zxdB6/EIQfdJSRuUDMsAFWTg+uEP9qef+9kqlpUfrJNtcWKf9rp9TjhXzi5UvwxfvziS/1a+3T5FIfh11L3nHT9OEj5RD9lk3uZRdBOKf/MUBRou2IJhFniLUAg2fnaVcvWvdZn9TFItYEYnNrrcrOqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947481; c=relaxed/simple;
	bh=5iVe3vqS+F1kzI8Uv9BKzZrwmri78+ea6GpjZ+ThSsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PadOzn2SrTUUotxdHsdWJvpehBbVoh+WiCBJvKQohPTx40pOMzVl8iEHC1iwplkFeufo0sP/yV7MKWcMSkJGUKP1vam0Z/ACXt2K7B3Lqgf8BCGBH7Z37CXOfvg+Pws2yJjwESC9hh8+mCDJV+Zcp5srA7XGHISM3Nzkqtry4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELgjQHcg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21116b187c4so4414445ad.3;
        Wed, 06 Nov 2024 18:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730947479; x=1731552279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=loG8eJYDFPVgMwg8ZCVGVs1Bg+cc695VBtfdcMG/Pbs=;
        b=ELgjQHcg5BYIQMuPFA/Isrvlg9G45++u2DdNOm3Kwumpg68Ye9A8Qc/tA31nco1o3/
         PgYn3XbiaYEv9sAPeMgsCYZaahEZYFDMXcx/dMy0oLPx4qNBvDqj6n+KqF1VARfbRdqJ
         sC8qBr4r7PcA7A+wOD6aPakREMABanoI7JCNad7fz1ww5ekTwM9MJdS4UeYEAqih3Dwu
         CdWADaSyeR9EBqOEJec5pRxzMZCd1ySdisEHBeqeVjNdNE/fn0xDu2wGyWCkz754MuRa
         Qrk//eDn5azSmreroBXZYYnIcDryDFp2uDrYzB5/d4ocSWQH0C+Bl0/blEnKcPzBO/LE
         INjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730947479; x=1731552279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loG8eJYDFPVgMwg8ZCVGVs1Bg+cc695VBtfdcMG/Pbs=;
        b=C0U9OW4b+nwaSrrr/S1xUe79KqepeiMbJFgWmUpOAKVWNoEuWvcu3c/Fyj+EHCx/V1
         zrtnrZdy4L5MP26ZoX3vBTWwTqFEcoRJpepBqBOyTyFi4t5bmhkJgHyvCR4NBwv1fzcE
         qV2e+xQyYxPrCXHk8V14Cg3S4U0OuzKehL1vvss2dLuYFn9mCsEzDM4ZBuIVcc6qJ90z
         Tdj87sBQxv7l4BMzC5luxinIOKVrP76xR2a/p9vEovzh1UyjRAMd503Wq/m3QhEvvB3x
         pP9hO56op1J6VXtjBmUIGXPqNDAA1Vtq87r0/5qonszkUxKUD5iaez5z5Zou78G4+E7S
         fqoA==
X-Forwarded-Encrypted: i=1; AJvYcCVmMYcuvViwc3OXPl284vUqBCjctqrp0vAsgxEjSUIQmB+Yr7/Jz8uhPEvc8RwsZLVVchiKpO3M7fVcO7E5GfPn@vger.kernel.org, AJvYcCXBRtFjCubrjh+RQ7OmkycsMs4S6IiJS11o0iWhLcig0LEwDyUk6w8RyyyA7vnrdedpLfnpFoiUgH4NIpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDFcCeKaravhE1QaXCpMxcYncoWSF0oT7gNWnxFUXvsixeelS
	77D+Q11BuD6zDypDVJyR9vgWgO6uvE6rYFmNWjqSBTlveNmw0kHaHLckoqKdlOI=
X-Google-Smtp-Source: AGHT+IF3faaaeb+GfUqpTBgS0NbMgnK0qUQoAqDyAmNXEFBW9+dVkjBxUwprxn00asTAcUf/YG6TQw==
X-Received: by 2002:a17:903:1c6:b0:20c:c15c:96ab with SMTP id d9443c01a7336-2111afd6c30mr320340815ad.48.1730947478876;
        Wed, 06 Nov 2024 18:44:38 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177de0578sm1816545ad.89.2024.11.06.18.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:44:38 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: wireguard: load nf_conntrack if it's not present
Date: Thu,  7 Nov 2024 02:44:18 +0000
Message-ID: <20241107024418.3606-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distros may not load nf_conntrack by default, which will cause
subsequent nf_conntrack settings to fail. Let's load this module if it's
not loaded by default.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/wireguard/netns.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93..508b391e8d9a 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -66,6 +66,7 @@ cleanup() {
 orig_message_cost="$(< /proc/sys/net/core/message_cost)"
 trap cleanup EXIT
 printf 0 > /proc/sys/net/core/message_cost
+lsmod | grep -q nf_conntrack || modprobe nf_conntrack
 
 ip netns del $netns0 2>/dev/null || true
 ip netns del $netns1 2>/dev/null || true
-- 
2.46.0


