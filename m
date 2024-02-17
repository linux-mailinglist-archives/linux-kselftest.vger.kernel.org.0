Return-Path: <linux-kselftest+bounces-4903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90707858CB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530F62843D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894C171A4;
	Sat, 17 Feb 2024 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpZe7huA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCED11CB8;
	Sat, 17 Feb 2024 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133183; cv=none; b=AIsy8jSevIwT5xbv9ujzVByDc9DMoDUWwXpPDI547mdXRhtq+HviYqKLpRd1OzGqbh/w9XxVmp0uHXmtMgV86PP+X39iN3bquPfKEKdfWlg5XT3A4tyqgu7J7B3uSM7Y8J0geANM9Bdqik5WlEUaf32kV3NtwhrniG0DGqK80Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133183; c=relaxed/simple;
	bh=+pv+WMhZMZkPDX16J6zCOkciLAEZjmNgH9DrP3Q4HHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2dvaPXAZK5tfsP5hJf9Jr2hB6lhdjXdQsYQKM+CfE5e26mGy6fkjIHH8gWZznbWXIgx+mcexUypNKOmEAnxYW1ePh5ao7f+SgrnqbNye6GT8NluToNvYILbQz+k2PSnFsXhfh7u2zMY23PUJe6E3ACCaVVeYOWezbvUgr/PXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpZe7huA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F15C433C7;
	Sat, 17 Feb 2024 01:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708133182;
	bh=+pv+WMhZMZkPDX16J6zCOkciLAEZjmNgH9DrP3Q4HHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpZe7huA2cnAD7B9rcYku9ooMz9vx+LrZLjyHoEOvEG4lv9aoh8Vxjc9X719KFtgX
	 yCLRRkypDlXhd0PSlloKxH7IPJp5z60iWIXCZiNRSnc+ItFOVhn5jPVO1sHSE6sd1p
	 nqJZyJXlPESr/bEBFWS1OoLGtMbW+AxBS6MsW/AK8nXDR4fQhJm2ZyS//pnYagEg5M
	 jADndLeQVW5jFFiD/h254T3Tz4idqCb7TM9+pW+U3PkS1nftffvsgl87MnILp5t6EX
	 RsKlEAYSS1ihtJefnN3MdIn8huUsXQH0xIvM3gwgkNSYoSdikaPhAX4WxsEs/zsqYS
	 Tyqrlqb6Kl1lA==
Date: Fri, 16 Feb 2024 17:26:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: kselftest_harness: use common result
 printing helper
Message-ID: <20240216172621.44df880b@kernel.org>
In-Reply-To: <20240216163304.2ab0ff7a@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
	<202402161328.02EE71595A@keescook>
	<20240216163119.7cc38231@kernel.org>
	<20240216163304.2ab0ff7a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 16:33:04 -0800 Jakub Kicinski wrote:
> On Fri, 16 Feb 2024 16:31:19 -0800 Jakub Kicinski wrote:
> > Let's see if I can code this up in 30 min. While I do that can you 
> > ELI5 what XPASS is for?! We'll never going to use it, right?  
> 
> Oh, it's UNexpected pass. Okay. So if we have a case on a list of
> expected failures and it passes we should throw xpass.

I got distracted from this distraction :S
Is this along the lines of what you had in mind?
Both my series need to be rejigged to change the paradigm 
but as a PoC on top of them:

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 202f599c1462..399a200a1160 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -826,6 +826,27 @@ struct __fixture_metadata {
 	.prev = &_fixture_global,
 };
 
+struct __test_xfail {
+	struct __fixture_metadata *fixture;
+	struct __fixture_variant_metadata *variant;
+	struct __test_metadata *test;
+	struct __test_xfail *prev, *next;
+};
+
+#define XFAIL_ADD(fixture_name, variant_name, test_name)    \
+	\
+	static struct __test_xfail \
+		_##fixture_name##_##variant_name##_##test_name##_xfail = \
+		{ .fixture = &_##fixture_name##_fixture_object, \
+		  .variant = &_##fixture_name##_##variant_name##_object, \
+		  .test = &_##fixture_name##_##test_name##_object,	\
+		  };\
+	static void __attribute__((constructor))		\
+		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
+	{ \
+		__register_xfail(&_##fixture_name##_##variant_name##_##test_name##_xfail);	\
+	}
+
 static struct __fixture_metadata *__fixture_list = &_fixture_global;
 static int __constructor_order;
 
@@ -840,6 +861,7 @@ static inline void __register_fixture(struct __fixture_metadata *f)
 struct __fixture_variant_metadata {
 	const char *name;
 	const void *data;
+	struct __test_xfail *xfails;
 	struct __fixture_variant_metadata *prev, *next;
 };
 
@@ -890,6 +912,11 @@ static inline void __register_test(struct __test_metadata *t)
 	__LIST_APPEND(t->fixture->tests, t);
 }
 
+static inline void __register_xfail(struct __test_xfail *xf)
+{
+	__LIST_APPEND(xf->variant->xfails, xf);
+}
+
 static inline int __bail(int for_realz, struct __test_metadata *t)
 {
 	/* if this is ASSERT, return immediately. */
@@ -1139,6 +1166,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	struct __test_xfail *xfail;
 	char test_name[LINE_MAX];
 	const char *diagnostic;
 
@@ -1172,6 +1200,14 @@ void __run_test(struct __fixture_metadata *f,
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
+	/* Check if we're expecting this test to fail */
+	for (xfail = variant->xfails; xfail; xfail = xfail->next)
+		if (xfail->test == t)
+			break;
+	if (xfail)
+		t->exit_code = __test_passed(t) ? KSFT_XPASS : KSFT_XFAIL;
+
+
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
 	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index d4f789f524e5..242ff7de1b12 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -414,6 +414,9 @@ TEST_F(ip_local_port_range, late_bind)
 	ASSERT_TRUE(!err) TH_LOG("close failed");
 }
 
+XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
+XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
+
 TEST_F(ip_local_port_range, get_port_range)
 {
 	__u16 lo, hi;

