Return-Path: <linux-kselftest+bounces-7663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AF8A0585
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38D61F21632
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D269DE4;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdQeKtR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07269D0A;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798921; cv=none; b=YLnsT6jmlUKohjuseuCQQYjxs1qbriORnk0LnFkonw1Nc+qIM7Cwf2E/q4qx0asiSuUhfd1b/vA41lzEMMH/IeiSdtJj/3Hh/4z673oDkDIBBSXrWT7NEm+lCcSoF6OQNMsODIcIbPUCMJD8ZabzTKDWBjjGskU+QJxXbLpRCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798921; c=relaxed/simple;
	bh=Vfp9UyJOM8kMpvSyXcIKRtaJ0zyB4mIgfD2CwgNCQVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxnF1qgrYVawBIoR6jBbKHQxPStXfN7b6sqVIBAjzUHE9/PFuaMCQahqf6e/Gb/nBoT9aOfJPgCKB9AIPwCoKP9vEqQZde9qWstpXnQCDbkiX2dCxruWYcaxVxX7jHxd08JwEqWxyjfbLcHW4uN2QM3dfzsZg6uozGdopHNpd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdQeKtR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4CC433F1;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798921;
	bh=Vfp9UyJOM8kMpvSyXcIKRtaJ0zyB4mIgfD2CwgNCQVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdQeKtR+qCBjWICspR0vy/IahEeGkhri/1IP/Gv7WxC6maxfhizZ0c06v5oB/h1m3
	 rh13c1Wd9g838zzQtciVKPfcZoADvLEbYVWB0ryher0n5Po6r5O85BtZKctzW0bXpe
	 V6GkV3X1fPr7TnQ+LVYxmo2z6EIBmbfuaOId4GwrCvmvJT4wXUGnJAUCWBzBFHHhLS
	 n13jvbNa7lGbNMb3zktVsFdryeXlfTRE/1+ydOKfwUh7epEnp834uHo79qk2AlIllH
	 o54mM9zpbuqUL2d7eFeMUT9wpspNjQ71fRU5+cM4mzMQUQ2UFWV2f+OrHSKDgrPNr5
	 ZGBS6hXOBbIyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next 2/6] tools: ynl: don't return None for dumps
Date: Wed, 10 Apr 2024 18:28:11 -0700
Message-ID: <20240411012815.174400-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YNL currently reports None for empty dump:

 $ cli.py ...netdev.yaml --dump page-pool-get
 None

This doesn't matter for the CLI but when writing YNL based tests
having to deal with either list or None is annoying. Limit the
None conversion to non-dump ops:

 $ cli.py ...netdev.yaml --dump page-pool-get
 []

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0ba5f6fb8747..a67f7b6fef92 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -995,9 +995,11 @@ genl_family_name_to_id = None
                     rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
                 rsp.append(rsp_msg)
 
+        if dump:
+            return rsp
         if not rsp:
             return None
-        if not dump and len(rsp) == 1:
+        if len(rsp) == 1:
             return rsp[0]
         return rsp
 
-- 
2.44.0


