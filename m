Return-Path: <linux-kselftest+bounces-44951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D38C3AB3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F742619B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576A312812;
	Thu,  6 Nov 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="X2lvrJmL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D21F92E;
	Thu,  6 Nov 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429506; cv=none; b=OUtVDguO5EamaxAYfT3ExYB/y6yvn4Ievl23m+oRTse3cH5mY3NY5hnuUb+JBaiDuE+7WytOgztvH77XZrAebV3VoeRMbNWgV1EGR8E/q4lVgS8KKNztp2DdPqddHENMBBK7rU8XFt4sqlc0KizZmZ2DCIQqoB5sNf2eUedwLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429506; c=relaxed/simple;
	bh=S7dHuDs4dusGdC7nWVsmaNaflurVFBFY7eiWSGnc36g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xl1MD8Yjk/pq6RJdrIXoFsB+0lE7zxf1deS6MHcHQwHAzbkWhWV3Bw0qFjjjeUkJ0nYeR1ZUMT2i9/QN55FxJsS3RgzksdZw+K3ozlJ8Qbpyse4wOBGHN5nhWdY2Ki5NAX/OEqYiDNMaC5cntl9Y83V54PDw0rPg4Q6QC/0sukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=X2lvrJmL; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 8EFD426344;
	Thu,  6 Nov 2025 11:45:02 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 51A293E99B;
	Thu,  6 Nov 2025 11:44:55 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 24709400CB;
	Thu,  6 Nov 2025 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1762429494; bh=S7dHuDs4dusGdC7nWVsmaNaflurVFBFY7eiWSGnc36g=;
	h=From:To:Cc:Subject:Date:From;
	b=X2lvrJmLtvlmOZxEHRtmigxXvgQaIEEp8k7+nklmZVah+bhJ9Ykt0wCci4lEPWmZj
	 CHj1Dkc9eiTRC3GhB76GWsNL6Pn15g+/ZV2f9Mc3AjPY7QXcLZcm2upIvECMh84nhJ
	 OsctCE4iIvWik8bUVTiyiTAYI1y+LfQ9PY8HDsq4=
Received: from avenger-ThinkPad-T14-Gen-4 (unknown [114.247.186.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 97FF140594;
	Thu,  6 Nov 2025 11:44:50 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyl5933@chinaunicom.cn>,
	WangYuli <wangyuli@aosc.io>
Subject: [PATCH] selftests/seccomp: Fix pointer type mismatch in uprobe function declarations
Date: Thu,  6 Nov 2025 19:44:40 +0800
Message-ID: <20251106114440.850468-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.90 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[wangyuli.aosc.io:server fail,wangyl5933.chinaunicom.cn:server fail];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 24709400CB

From: WangYuli <wangyl5933@chinaunicom.cn>

Add __nocf_check attribute to probed_uretprobe on x86_64 to match
probed_uprobe's function signature.

[ Fix follow error with gcc-15: ]
    CC       seccomp_bpf
  seccomp_bpf.c: In function ‘UPROBE_setup’:
  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional expression [-Wincompatible-pointer-types]
   5175 |         offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
        |                                                                          ^
  seccomp_bpf.c:5175:57: note: first expression has type ‘int (*)(void)’
   5175 |         offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
        |                                                         ^~~~~~~~~~~~~~~~
  seccomp_bpf.c:5175:76: note: second expression has type ‘int (__attribute__((nocf_check)) *)(void)’
   5175 |         offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
        |                                                                            ^~~~~~~~~~~~~

Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: WangYuli <wangyuli@aosc.io>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..19df80d18619 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5057,17 +5057,23 @@ __naked __nocf_check noinline int probed_uprobe(void)
 }
 #pragma GCC diagnostic pop
 
-#else
+int __nocf_check noinline probed_uretprobe(void)
+{
+	return 1;
+}
+
+#else /* !__x86_64__ */
+
 noinline int probed_uprobe(void)
 {
 	return 1;
 }
-#endif
 
 noinline int probed_uretprobe(void)
 {
 	return 1;
 }
+#endif /* __x86_64__ */
 
 static int parse_uint_from_file(const char *file, const char *fmt)
 {
-- 
2.51.0


