Return-Path: <linux-kselftest+bounces-9584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03568BDDF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2011C22074
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC414D6F7;
	Tue,  7 May 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ArLEAsdz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9214D451;
	Tue,  7 May 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073616; cv=none; b=bYUaH3Sc6Jwk9kN+aOJ0RMoUChUu9ty24k4PDNr/bpWIv+PcfJOZODx+eG0O4Wj+/DfrDE51tV9a/0xgBYGh6iP8dI2kXbGBFHjX+tMxE9vWRLgnSv2UvAytapsulEBEIQ1YU2N/eC+hycXlpEPNWNF1xDeDKUVU9AHbgHmteYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073616; c=relaxed/simple;
	bh=sGf8/xmI8qDULHoJO68RRuCV/ofbkTSGYEIclQqzzuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cags6hqHaeghlQcYlldB4CqFEBD2HmBvvkhg/kxwTBnjhpnNmNIxdMegEokgSXqRkGdxJW+RlLMhDw10w1YvtmXUjWISRQgItBXnGySOnHv4MFj7cDMljc1hirAT/7WfYp2SNJ1jo8RbH3nSxSP330rhuSEei0ik+eE9iu7LgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ArLEAsdz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A545488662;
	Tue,  7 May 2024 11:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715073140;
	bh=gIiuGYeGovNn1vn+AbPqA/C3xilWFjjooh3cCUPXJPg=;
	h=From:To:Cc:Subject:Date:From;
	b=ArLEAsdz4l92leGhoyWDkV8sQUhnYA6o1EJlEc+Br8rlw2eUYYZMZgW4mqRKDmgjL
	 tnyz4BaMDumIT1Ail6J+uruYZrQu8Q0zPp/cAbJH7DRcauhTJq3h0HNxUotlRh16YK
	 UjNjF86KrS3u8F6oaviOfdUNyo43Ose8mw+U65qIvSTUtFtFZ4MWy6SHMLWIe1aTgN
	 JS/dCdyB9QRlS23UJxlg4Obb3z1R1fjut4IjJXAuozq6lnheq7lM8kyWPmlQ+Aq+vk
	 FCxNql/j7uLcY1IaUkgdF5gmpeRh7Xvt/5EfC/x/hkrT2z1dZwg9HWw40lyflk+fh0
	 qAb65qHsZdeYg==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next PATCH] test: hsr: Call cleanup_all_ns when hsr_redbox.sh script exits
Date: Tue,  7 May 2024 11:11:55 +0200
Message-Id: <20240507091155.3504198-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Without this change the created netns instances are not cleared after
this script execution. To fix this problem the cleanup_all_ns function
from ../lib.sh is called.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
index 52e0412c32e6..db69be95ecb3 100755
--- a/tools/testing/selftests/net/hsr/hsr_redbox.sh
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -86,6 +86,8 @@ setup_hsr_interfaces()
 check_prerequisites
 setup_ns ns1 ns2 ns3
 
+trap cleanup_all_ns EXIT
+
 setup_hsr_interfaces 1
 do_complete_ping_test
 
-- 
2.20.1


