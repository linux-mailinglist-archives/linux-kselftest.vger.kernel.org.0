Return-Path: <linux-kselftest+bounces-11538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50638901A31
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6C1C20B7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8094DDB8;
	Mon, 10 Jun 2024 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PpmVAcZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35941A935;
	Mon, 10 Jun 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997270; cv=none; b=skGPEdpxYYg71XPVlcgqO0yUFKIgclKu9AQW0WrlYRmkE3Xrls6cmC5WMEVHCT66eEEkH8i/yhV2Vw7nlPJokX7rSqvbp8G0fXHHAUaQSQKSO/8SF3XJKIdeWH2VknfDYCkaC5V1YcaRMFLYsBb5wzoEJjRDNPOB9c+lJqxplmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997270; c=relaxed/simple;
	bh=Q5CPkw7W5Qs1+jCVle///FndTMVAPqB2MwLBM/VCMgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rRVHmWb5o6z2TXKssgkJJMdGg7CdpX2Qqyps6TONhDoudyC5Y3dCmcrjEdkjN0wsPL8NKRUbmyeNdh1aAwmdJsn6W6a83R5SIVo1fAyEAffQt9FXU/c5gJ1OWyKYaRrtOAFQLEgXS1A0iGl/jQqb0sQhRS64K3DXotutxxJK7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PpmVAcZQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717997267;
	bh=Q5CPkw7W5Qs1+jCVle///FndTMVAPqB2MwLBM/VCMgA=;
	h=From:To:Cc:Subject:Date:From;
	b=PpmVAcZQe5LjjEdKjqwh4bVflJNL3csSYsBxjMTOI9VVQOGdSC5IWQsVVp0tspWPh
	 bu3h8nN0pdw5aYuO2Ruvff5xf0k996kCy0DMwzG0zY51EQ3tO2AX6MJ1TbYiSuiqJ/
	 +MgfCa8AXvgNbiE1wGxSUOs+AEC7ipp3Ul0sj8js0PO156cskeJ9dRRPZs5cdlRx9L
	 aAtyOCVQEiw333lAPS26iHiL7q7BL0JdukcmRqsWN1DErgnhkJjEPSIsybdyhNHNuv
	 vh0KDsWJR6eJ6RAFKVfM2dLLZ515oOMkNK0W0K/lszuUdM1qwC8WOsBidjQSZ3jxPp
	 MKTFV5xdg9vsQ==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED2303782009;
	Mon, 10 Jun 2024 05:27:44 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: skhan@linuxfoundation.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH] MAINTAINERS: Add selftests/x86 entry
Date: Mon, 10 Jun 2024 10:28:10 +0500
Message-Id: <20240610052810.1488793-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no maintainers specified for tools/testing/selftests/x86.
Shuah has mentioned [1] that the patches should go through x86 tree or
in special cases directly to Shuah's tree after getting ack-ed from x86
maintainers. Different people have been confused when sending patches as
correct maintainers aren't found by get_maintainer.pl script. Fix
this by adding entry to MAINTAINERS file.

[1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 523d84b2d6139..f3a17e5d954a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24378,6 +24378,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/arch/x86/
 F:	Documentation/devicetree/bindings/x86/
 F:	arch/x86/
+F:	tools/testing/selftests/x86
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.39.2


