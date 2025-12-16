Return-Path: <linux-kselftest+bounces-47614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF9CC48CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B814E301693C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C138329388;
	Tue, 16 Dec 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fgOxuPtV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8232936D
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904867; cv=none; b=BXERbhzsOTsuxXOs3Rj3VHnmsYGVFwcpNQAgVMG4I7wjaQmYYsNQQ89XiHhVbZDvlnd9K+IggeFTbsMX1bDhWx+uXKyamVecfajNqZ0RVlM2Xxq+XMuf/t+ukdkdF3IwcurdsGatvrTkFBR9q+RkX6UaxFRcBaxY9qT8dKi3FmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904867; c=relaxed/simple;
	bh=r/FDIWaDcL7tzJvoOctfFeLod3RGeiffLgS1g//bHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGfyzpxDWycbKgUAyrf8QFHb7LNJPrJF6k1x/sXqnKDYez1VNwm01jeZ1loZsHRXRVrrVvkEHb8DWwekGQtX4Pt41kBCZ4O/xCJMyOIXEG9u+v8k5SiaCbldLohcv00x4FIdnx4ghz6+zqbwPfIYzJagJ6hYE9/4Ze3nSR+kVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fgOxuPtV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7D6853F321
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765904858;
	bh=0Wv3W8Or+AfdbFFZhOAbvXi7U6Iihxvczf8zxZ/vudY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=fgOxuPtVsETmL5CZZl4/Z6U9lPSzVUTAzRUpj4IWTFXMdBTNPEHerUeQGUDaEFf6n
	 QDXRVt0/F1R5INpaupv7K/qA+WIioTrwpjxfMVxHLbOMh0k5nLtyRs2ovJyy7FLCJp
	 GnX/NmakCdvCBZC/o3E/Qfcik4Q4Z13DnLAScLUGanm6+wAFXsLvO8n4gcSfVVcA5Q
	 yfCCJwKtA/Y4xmHRQyw4LsWJmy7dHxu3+AbKiQDLzkYswV4bCcxqGrZ8hd/oVE4rbw
	 NG6JFrQteKvQ8jX3ZRMkYM6MCwArrohdiTpNE38cbQR8/7yU4jf11mm/qY/AKL4Rkn
	 O3Kn/qixcOWYvW8Tfj34bfpbREDHE/s+q61djrxSEG+TVcGcdt12XXDgetDJO6CFaW
	 v9VcEQFDCK3dXbbRCjs8IOXLd4mselbhjtxtkZCR7YMz6nE7NRBx195/JOMMDz9Glw
	 3eZgLL2pp+xJ86gZU1go8p6vD4OA0v4a1eSi4yJtDm7DNjAwy5F9BvMWfFHgOCZtre
	 ryMAyIjRHC8fQITxs3A/fxsiURECRJ/O9UokpZ71SIsbuYzQh1B9C0K7EKfD4rNmR6
	 GbfRWGOoUjxsKmKBqgy2anQp5mMQe5bQHXvoFgHzW2O3MkGlVlppzacZf/7PkC52O/
	 aYibf8HT90zGvqj32EKpliAQ=
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b245c49d0cso1086435785a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 09:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765904857; x=1766509657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wv3W8Or+AfdbFFZhOAbvXi7U6Iihxvczf8zxZ/vudY=;
        b=QyA7FzE/B7pEChGkZrddRRlyi20xQUc+srOHh4UNJWWzkYshy3f580yFO4kwOHkIqL
         1738Bk+9VpBbrkxXDaKfmEuPFj2hmHB/Qve12Uehd6AqnYMmqCP6DAnPQVGH+/gmwKlm
         xI4E37l87/AxRO3YElDsm6kK0EkoFi1IynWLCeZ6mtVp7/oH55q8jiE1IWuxVKTbV3Hp
         w3LVEpWWOkH0sSDCM11f1K0vdbzpeowWxgFB87B+MbKzCCoPe5g2Eluvv59lxQcZ9tBg
         3t3ZrtuKksaDdd0XKjd/ydaKIQJ2PWis+ssST7XlGa0b0SR4VynAHh1l4R2OGxAPBbok
         tFfg==
X-Gm-Message-State: AOJu0YyEwWfrWzcnBfZ9G6KSEXdnVWKbMzZI1CEURwEk6qQxQ551+S36
	l1GU5UJuDLJPJ2spuugfKxbCIE/pLg9xf6uPxMY+n2ps41t5yOLYU3x/Huw4Ap1SOZ77l+O6kbn
	T9bW0WCJ/ixxuPgiyeHSk9aGhbuPRVPC5vsXEgpfaK5niIUyZRypdQxz3tUZ4OzRy9ezgRgKy5G
	y4K7Drcy9snQ==
X-Gm-Gg: AY/fxX4CDBGpM/V/ANFUG4NxQbmhWV6SeWCrqMo0bvN2i9fwvyJH6rOXhHI0JFYsL0v
	yYz/GpInpsz1apBkQdvhSJ17E00ScA2zHqJ8nSvEhK0k/LvD7MMhFZtMMP0d/wOH1cZC/Ufs3Xk
	5GeV525NzPpsLxu4jqiN268pmN+n9S9l0kgg0JCDgaW1dK7fw8VHlDjR5RB68TBWTYCtmZcOpLh
	VFaIXPEihX0J7RAwy1B7DFALMmpZuL4nkKjWWtqNefx4jaG96n8rGgDsiSlL9A8BAGcq1xQkuAB
	XSeVZhMj1TD+TW5SpeN1ZkhTr6ErZXkVrHRZC9nXLMFVihmByisMm1aHsTd3+3ttbO0bRMANzU9
	Nh089I+t5FrETte+HzNzbyPSzyHGK851n6glRNsfKKegSVC1QmylWy/jULgxqa7Y7
X-Received: by 2002:a05:620a:40c1:b0:8b9:d2cc:cded with SMTP id af79cd13be357-8bb3a27623bmr2246353685a.52.1765904856069;
        Tue, 16 Dec 2025 09:07:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoVMP64M1IhGDJjh39XY59ctMuj3UH2eDMGIf3ZwpmoQLFJ9DzmyofZbh9CRewHdRRI2tbGQ==
X-Received: by 2002:a05:620a:40c1:b0:8b9:d2cc:cded with SMTP id af79cd13be357-8bb3a27623bmr2246330685a.52.1765904854123;
        Tue, 16 Dec 2025 09:07:34 -0800 (PST)
Received: from localhost (modemcable137.35-177-173.mc.videotron.ca. [173.177.35.137])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8be31b53dbasm224404285a.34.2025.12.16.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:07:33 -0800 (PST)
From: "Alice C. Munduruca" <alice.munduruca@canonical.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	"Alice C. Munduruca" <alice.munduruca@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Cengiz Can <cengiz.can@canonical.com>
Subject: [PATCH net v3] selftests: net: fix "buffer overflow detected" for tap.c
Date: Tue, 16 Dec 2025 12:06:41 -0500
Message-ID: <20251216170641.250494-1-alice.munduruca@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3',
the strcpy() in rtattr_add_strsz() is replaced with a checked
version which causes the test to consistently fail when compiled
with toolchains for which this option is enabled by default.

 TAP version 13
 1..3
 # Starting 3 tests from 1 test cases.
 #  RUN           tap.test_packet_valid_udp_gso ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_gso: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_gso
 not ok 1 tap.test_packet_valid_udp_gso
 #  RUN           tap.test_packet_valid_udp_csum ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_csum: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_csum
 not ok 2 tap.test_packet_valid_udp_csum
 #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
 *** buffer overflow detected ***: terminated
 # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
 #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
 not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
 # FAILED: 0 / 3 tests passed.
 # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0

A buffer overflow is detected by the fortified glibc __strcpy_chk()
since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
reported as 1, even though there is ample space in its bounding
buffer `req`.

Additionally, given that IFLA_IFNAME also expects a null-terminated
string, callers of rtaddr_add_str{,sz}() could simply use the
rtaddr_add_strsz() variant. (which has been renamed to remove the
trailing `sz`) memset() has been used for this function since it
is unchecked and thus circumvents the issue discussed in the
previous paragraph.

Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
---
 tools/testing/selftests/net/tap.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..51a209014f1c 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -56,18 +56,12 @@ static void rtattr_end(struct nlmsghdr *nh, struct rtattr *attr)
 static struct rtattr *rtattr_add_str(struct nlmsghdr *nh, unsigned short type,
 				     const char *s)
 {
-	struct rtattr *rta = rtattr_add(nh, type, strlen(s));
+	unsigned int strsz = strlen(s) + 1;
+	struct rtattr *rta;
 
-	memcpy(RTA_DATA(rta), s, strlen(s));
-	return rta;
-}
-
-static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
-				       const char *s)
-{
-	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
+	rta = rtattr_add(nh, type, strsz);
 
-	strcpy(RTA_DATA(rta), s);
+	memcpy(RTA_DATA(rta), s, strsz);
 	return rta;
 }
 
@@ -119,7 +113,7 @@ static int dev_create(const char *dev, const char *link_type,
 
 	link_info = rtattr_begin(&req.nh, IFLA_LINKINFO);
 
-	rtattr_add_strsz(&req.nh, IFLA_INFO_KIND, link_type);
+	rtattr_add_str(&req.nh, IFLA_INFO_KIND, link_type);
 
 	if (fill_info_data) {
 		info_data = rtattr_begin(&req.nh, IFLA_INFO_DATA);
-- 
2.48.1


