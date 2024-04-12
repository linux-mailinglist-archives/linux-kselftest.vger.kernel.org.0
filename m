Return-Path: <linux-kselftest+bounces-7803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B58A303B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D241C23DF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC286644;
	Fri, 12 Apr 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr8C/F80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A18626D;
	Fri, 12 Apr 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931282; cv=none; b=X6FU/TepBgpqwA/aa3drDoIkngySfOV9WCjiuUcSobKyOitTcFGMc3SkBcGHRG64zitKp6fYQXCY9nqxEODJPMjZt4cTB6mIaAWSMqfTwiF2Y6VpDN2fN9KgcWK3L8U5ZDWmMduZ4dXL1xQjr2i1nnweHvueMUIPenaiY62+X+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931282; c=relaxed/simple;
	bh=8BkxfNl3hd9M6SMm4rbkPdYQAOfcfQq2OyLXTwlHs5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZcA8ujTsODtSaV/1HUMjbHlZbWEiuL+GSEKLWCdfoOoH5JM/A7GwHdpBv5CwMfFc6qf0fPRoxzMrwvceXuSuDrLn4FyuTdm/HCS4k7X8yr2mD0VyTUPvTYKaK6mQxaRNDL+qBd+ZIfCR5ECfuHL0QhMuGggRPH/G4r79YzKicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr8C/F80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD6C32783;
	Fri, 12 Apr 2024 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931281;
	bh=8BkxfNl3hd9M6SMm4rbkPdYQAOfcfQq2OyLXTwlHs5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qr8C/F80BCKzlhkmpbQ+LWalzFhxeRAgmBLJETWAm8Os8FJpUBwnj2Y/0g+eOP3Bg
	 07OMUI2AtMNg3U851iZZze3ICFHUIdUAWr3qMEShHQZusThKS+d9MeOjM2kA8GkzbK
	 edKOZ5XHz2HI8MQH1p/u8HLN91tktkqPgmAQU0Ah1e11jHW/4SVFWNQg8RZDf2LTsZ
	 /IwddFazxeMzGz1GUsmxkDIZMzbPNh8y+uIg0Eub6jAeQi+h68uOrhYY+sVwROGmpu
	 aKeAPguN16sJIEVZRfm2GmsdV/6kx8rf6nLnbCp/9mBHnm4nEx7JMYcVPfV6YZ2hPz
	 EbZr8DA2wqlTA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	jiri@resnulli.us
Subject: [PATCH net-next v2 2/6] tools: ynl: don't return None for dumps
Date: Fri, 12 Apr 2024 07:14:32 -0700
Message-ID: <20240412141436.828666-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
References: <20240412141436.828666-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
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


