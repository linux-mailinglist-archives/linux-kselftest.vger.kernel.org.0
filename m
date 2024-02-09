Return-Path: <linux-kselftest+bounces-4442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5A84F6D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA661F21D29
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4066BB5F;
	Fri,  9 Feb 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="FaKIjbR2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="Av2ay1qn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1C69DF4;
	Fri,  9 Feb 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487918; cv=none; b=ZvqES60GKw2B2v5LHVWzs8QYAUgkmjqkvsmkMrD7XaGvwHW9A1y31MdJ4X9ar5evuRyOl+BVmV4DTWNcnCL9Uz0bkRAd4bUtKzH4pXB2yFXF9nXHNbKGq7rsiHeQVGWu/c70xr3IL5tcRcdt+W7plTMwMiey2q4zoyXIgtjs94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487918; c=relaxed/simple;
	bh=m5QrSPeQfcWhb09oi6JBmIJ9tAlZ4VzlYKSWguAW0Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsqQGEHLUaorX6g4W0ZcH8Hf8Cei0bP/bjHYyST3BcqfRnrZ8iwv/yx+GnpTem7Z7Cz+kD3NqY2OAoQmRrxOyhO1A4yLujRYKId9I7MG4nbE1QVWW23PcxFo6WC0QDldy+w+8Si32qep0WBkP6spc3vCGIIN3AiAtX6tCL7RxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru; spf=pass smtp.mailfrom=internet.ru; dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b=FaKIjbR2; dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b=Av2ay1qn; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tGm1xHoSALIuckOtkwQfzR+mYVuPULCOH52yQLjIngA=;
	t=1707487915;x=1707577915; 
	b=FaKIjbR2BB+h9Vt4rL1uN6qUF/lIdWx269CPpNRrEyEjH2D0HDgnBqeMdSqGah4/taH9sj2NbsWgSyeQCQ/TbAYF2yziS1V95m3lBlVk0qv7SX16UtOJKYkltNFjz2IhOUAkfX09CpGxE7P7NrnDYnmqbR3VZWdaeKRo+TFML30R/x+Oq0izwUEhvPZsACPmQRhAnBUGI/TQbPMyX37yy0L/AV2keSgcfv7AKDZNvlu20OzOoziyit8UW5C7UMaEBstGiWQ5wgtfi+4Zk1toa6aeA5pUIukmVgg9/DxRlDN54YjupfGzLGhU9b00FNyKFmh438jh3m6zf+tKIYDJVA==;
Received: from [10.12.4.28] (port=55320 helo=smtp52.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1rYQst-00DShM-SE; Fri, 09 Feb 2024 16:25:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=tGm1xHoSALIuckOtkwQfzR+mYVuPULCOH52yQLjIngA=; t=1707485139; x=1707575139; 
	b=Av2ay1qndN9MV0EqToYfmS3FaEWYq59ZXjK8A9XoE9dVssc3L2F9AUF0np3QbyIcPoECROozvlp
	4kdNAxJjvDPUDpr/eoZbfPjd6Go/eZ4ASLQ4KrJSPpRjvgPcT1TSKiGJL/vyss4Q/0vlgOL5WXj2k
	Qsbpu0ZeBAn1wEiPAHhXWdvtlZFdO5dTSm3OzjBfnlFQnyf12YROzxUNZvu4GcNzYk+abZbrfj/1U
	7opkgBB+T0hjZem7rXbD24Iv0ER1sn3fzE3uQsd5iAAzIEY5pfeUQw4Xh5LNB4lnRqhoin62Qj91M
	F4L8TZnCrCSZDOcxZwyt3Os9v1GmrxPbb6lw==;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rYQsb-00000003PQy-2OCY; Fri, 09 Feb 2024 16:25:21 +0300
From: Maxim Galaganov <max@internet.ru>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Maxim Galaganov <max@internet.ru>,
	Matthieu Baerts <matttbe@kernel.org>
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
Date: Fri,  9 Feb 2024 16:25:11 +0300
Message-ID: <20240209132512.254520-1-max@internet.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD91FEFD63CE1B09916316E0C418293B113AB9044BC056ED5D000894C459B0CD1B96F2DCF2EB9516F7EA6157006EE19D6B17A5657F235AA3BC3D19983833F01B5B9B92CE970A8DCB349
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AD2F2D6F6013FF7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE75C385DEB91CEC222EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871467D157E8F25F1AADBC39DB49C565281320118AE8804E2271DF9E95F17B0083B26EA987F6312C9ECB28585415E75ADA9C26CFBAC0749D213D2E47CDBA5A96583C09775C1D3CA48CFA7AC412AE061D850117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE74601F13E4625331C9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE7B069F7EBDE4CC8E27B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F4B6963042765DA4BAD7EC71F1DB88427C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF45156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A57063E2B8E6039BB35002B1117B3ED696C2290E273ED22A6FCCE9A60C8CB01D7C823CB91A9FED034534781492E4B8EEAD81B3E0F64AD3EF57C79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF3B4699ED58432B14E6B2F4E3FD3F2A99C7823ACAE87B23FED2D4102B8A317CD1B94BA8791A304480766A7423F6D95CBEE5CEFE7B9F5A6687BBF9CF5BE62D93E11E4B4B0579F44D0242BF32D1DA1046D202C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777ZrnQJgvwi+sbA==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA496F2DCF2EB9516F7EA6157006EE19D6B19D9319118D6564F7AF8E75F3432433F792BBD60AF8093D9D3DDE9B364B0DF289325BD006FD28D9A0A3EAC56F6A374A440D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A782CFFFEF9892CBE786A78F94A7442A9D4049FFFDB7839CE9E2038077D049FFA75D1CD41B6E85E9CE99090A86D6500F52B17C480687FFA3F3B
X-7FA49CB5: 0D63561A33F958A5C0A701A6ECEC674582086D814B21B76BE4CA3DA7BC45C3AFCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637785F28B24E3E349D389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC89B873608BE13BC28F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7E55904F49B65B757731C566533BA786AA5CC5B56E945C8DA
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777Zq39vCcElGA7w==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Older glibc's netinet/in.h may leave IPPROTO_MPTCP undefined when
building ip_local_port_range.c, that leads to "error: use of undeclared
identifier 'IPPROTO_MPTCP'".

Define IPPROTO_MPTCP in such cases, just like in other MPTCP selftests.

Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/netdev/CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com/
Signed-off-by: Maxim Galaganov <max@internet.ru>
---
 tools/testing/selftests/net/ip_local_port_range.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 0f217a1cc837..6ebd58869a63 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -16,6 +16,10 @@
 #define IP_LOCAL_PORT_RANGE 51
 #endif
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 static __u32 pack_port_range(__u16 lo, __u16 hi)
 {
 	return (hi << 16) | (lo << 0);
-- 
2.43.0


