Return-Path: <linux-kselftest+bounces-29181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E69A64430
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 08:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D553A1784
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037921B9C5;
	Mon, 17 Mar 2025 07:47:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0498F5C;
	Mon, 17 Mar 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197646; cv=none; b=fTm6/vAAHKF5O4PJlRzBf25T/wJXl3lxKwxttmJY3WoLgwpl4Nn1L2LU8KX2mwxincC+wwBEnjKPHpqNq1yL93J0W6JF4Wf0niWa/zF0uJA+gSzRleVrFCjxnVaGm5ndP5NtJmJRGVH4tY5cLEfH6bAug6Xkoks/aDdYqm75fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197646; c=relaxed/simple;
	bh=gPIajBVKq4rXHmPk+hUGg64doFuZ8TLuMJGnWh797tw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=lPOrGd0XM5DdMzaGSO81iu+Loz9f60/uLsImGEYXKqt+rCS3onXVV/s1bkCYcOldFnyH401Gw34wGUEHDOzkH0qhlWR/XgSNhQ4PrPYu1VJluZJXisXlXV0+zEPoYW0cZt4ceojb3T4RtQsCa1XRANNkQVE57Gz34Sr3+ZY8ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGRrl5Md6z8R049;
	Mon, 17 Mar 2025 15:47:19 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52H7l4Sv022486;
	Mon, 17 Mar 2025 15:47:04 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:47:06 +0800 (CST)
Date: Mon, 17 Mar 2025 15:47:06 +0800 (CST)
X-Zmail-TransId: 2afb67d7d37a33c-0e793
X-Mailer: Zmail v1.0
Message-ID: <20250317154706711RvRh_96VDw-u63cPmkeHk@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <andrii@kernel.org>
Cc: <eddyz87@gmail.com>, <mykolal@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzZWxmdGVzdHMvYnBmOiBSZXBsYWNlIGRlcHJlY2F0ZWQgc3RybmNweSgpIHdpdGggc3Ryc2NweSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7l4Sv022486
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D387.005/4ZGRrl5Md6z8R049

From: FengWei <feng.wei8@zte.com.cn>

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 tools/testing/selftests/bpf/test_verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 447b68509d76..dfe64c6d4f87 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1320,8 +1320,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
 			printf("FAIL\nTestcase bug\n");
 			return false;
 		}
-		strncpy(needle, exp, len);
-		needle[len] = 0;
+		strscpy(needle, exp, len);
 		q = strstr(log, needle);
 		if (!q) {
 			printf("FAIL\nUnexpected verifier log!\n"
-- 
2.25.1

