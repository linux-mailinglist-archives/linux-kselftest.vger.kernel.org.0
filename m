Return-Path: <linux-kselftest+bounces-40169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44539B39B55
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE24172B3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664082D738E;
	Thu, 28 Aug 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BwCfnwXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB53214813;
	Thu, 28 Aug 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379971; cv=none; b=D0iXMwQMFMsfXWKbSadEtTJaJvFNis2PFYxvQlzxTSo+LWhk74qgUJY1Wiiy4KTo+6n7Mlbxyesn2l2alEQz+G/pP1rEW4rGlO1+oPc76vmMJWwgAX1bZVQr5aWttYVpV8a/wfe0qRWdZfdPSGGc4uVwYrJnFH11r4eK7/hBUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379971; c=relaxed/simple;
	bh=FXgfQymDrsmrepLJABIctJ0oih0TYDCQeRXty9SQJdw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=X1TEc5sks74Zmg5b9SGaC4Jc0taz4kxWi56aS5OcdZQTYX/8mbP3xDSTZn63eE8/2MuiS3f2evxc7l0c4GspEKEiu2X2FaTzHJrKiC4TEHCkGE84vx/k5kxKVxC9Tb8VwOUe5q+uSTIyTdSTp5c9Ojdgx6WNxSGno51voayKqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BwCfnwXr; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756379657;
	bh=tcR1dyJby3rnBKKEPlwBslHLorWRcZCdjqllQkvmPyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BwCfnwXreQ31C2w/qPOdbXx+4uik5jw4wYAkBbQYW1NxX3oq6DoUvxN4mRZfbVUwr
	 j89Rt2xtuR89kyq9SH1IYg7MgLBzxEWtMMPX3olIV7H3BFsGQFYCDmK8JOaOnDqztM
	 4wmh4rKramiaoqm/U2IwlJeW+Pp4lHw689BQpSFI=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 204184AE; Thu, 28 Aug 2025 19:08:04 +0800
X-QQ-mid: xmsmtpt1756379284tcf27c71l
Message-ID: <tencent_A842AF5EA32A88970690424E592897FC2A08@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWq3KNqT5Iyod68V1MYkhI8XKpuANWh6xLWrgN9KAxvzDlV7wbX0r
	 ++acAEkktHYeBNf31kmldATyh3lU+FuzWXEWHFoyvZvSbUx/QVdnB2SE3DqBZ9GjbzcF0NvpJaZU
	 VQec3cH1S/R0kiuJJdlabiUo7F1RTmP30L5yCE8o5DrwokJcykmiduiHOW5wunTa+jFI6XK6oF3a
	 P9wn/5ivIreAcVH7d4sWxZvzQNJOdnSAwhdm0s1Qn683ClMZDJ7/bCiC6o9l+9B3VUNizpctjkzd
	 XCe3RtDpd2/l9ZZTQ9aUZBiGxQYkLH7ML/ShWhpuIM4WUAfCPqbo5dYaZocLVHj5fFjAXhM/5sMq
	 gr0ir0bGG4K1OjaQd4uHaS/fkzlYleBW6MGaWnNX+IbUGUq4ycdmQggPeaZ1fqeNWoNg4nTCmYFq
	 X2rGjau2+c7E/5NZsJZEYgZ7bLG/QJiBVuwiXJ6HCIhhpQicgxxvna9OKLm+LuPToy/xQoWvM7WH
	 Leh2REUzVd5oj5un9zslNp4Nzeftbmm44fZM2Db3gupDQKHRuaBNUP8aqcS0LenpB0+sRuM9ej+5
	 RQ9wp7VX7rjH8zqgo6y2Ne9zIXU1kn88vTJjCDkfVaryy/SXQiv8m+ne9LRVp1vFw3e4D32hk3Fc
	 o8jMnhk4kOMKegoLzUUu/XWEbS1i4HE50TqFE2LOAZBsJKPfX+OMmkXHuzPjlBfK4y7d44mB4Oqf
	 i2Mb2cgwyvMb2cIf6alv9qUhAlqVJWMsyG2YJy2aC6Ro7fPJ0y0fw5IwNix8SSkAqw7GypsbOalL
	 K42tiYuj3iqyz3SteKjK4IdWhrKlKcbFvuSJcnRrjVMeXhqB33Zu07N4Rn0ms9bLoDAbDgd6OwCb
	 weYHmfX/UfusgolCMDQa4tpsFNAaDzDs++iVrR2SO0CiH5Yc3cjc8jIeCUDkZB3/fCvQdnX1MAqc
	 sMaqG5Pz7lve3o7sifCRfvNhJY6c1iht5G88I9wPeDSdNBGf+enj9mjgbLkrt2CUH0oo5KJmADlA
	 wF3HoC715EKfhjdTyB/5gC1mCmxvU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for bpf_strnstr
Date: Thu, 28 Aug 2025 19:07:37 +0800
X-OQ-MSGID: <01ab64c260739383c3f9253789c9b5ba0762776b.1756378974.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756378974.git.rtoax@foxmail.com>
References: <cover.1756378974.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add two tests for bpf_strnstr():

    bpf_strnstr("", "", 0) = 0
    bpf_strnstr("hello world", "hello", 5) = 0

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 46697f381878..1b56bd5860e9 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -30,7 +30,9 @@ __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
 __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
 __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
 __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
-__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6); }
+__test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", "", 0); }
+__test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "hello", 5); }
+__test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "hello", 6); }
 __test(-ENOENT) int test_strnstr_notfound(void *ctx) { return bpf_strnstr(str, "hi", 10); }
 __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
 
-- 
2.51.0


