Return-Path: <linux-kselftest+bounces-27968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CCA4AC97
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B1171795
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F51E25F2;
	Sat,  1 Mar 2025 15:45:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DC1E25E3;
	Sat,  1 Mar 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843901; cv=none; b=GphP7A5qN+/rwnWT6qXdUJW4/9a/GGs6eAD/cVHS106cZZH7lapb71Ub9S+yFYgNoaTC/zCqvv99flX6zJb/58VObbGEFjLMPIBDqcuyFErGQAVL80bxukyZdxgA75F5k01q6cAioUz/wPVGAn1yLvwn9J7ln0EwgRTsK/WfcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843901; c=relaxed/simple;
	bh=b4MOibz+eOGYfXh6UPXfRXCu04Wc+IYJ3Q57u09KO+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hacSBp3LkDGeZe/Z+CXZ+HFnw8hbiCCxpvk9YeppAFHRx0yoC8EV2MQTeJaH4co7ry43qOTQx85YdaEZoGjL/SHbLFgSzPIKoQo2KqSMHPZPwEdxZ7R/ebjItL53w+2CMgsvC3w7VtvB5ZRrlpv2fz31XFxZYP6yYV0lZU/uVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 521B7Zvw018945;
	Sat, 1 Mar 2025 12:07:35 +0100
Date: Sat, 1 Mar 2025 12:07:35 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <20250301110735.GA18621@1wt.eu>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
 <20250216093940.GA2192@1wt.eu>
 <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
 <20250222093851.GA13258@1wt.eu>
 <b36e1946-fda8-4893-b081-7ac9b4933947@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b36e1946-fda8-4893-b081-7ac9b4933947@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Tue, Feb 25, 2025 at 10:37:24AM +0100, Thomas Weißschuh wrote:
> > > The tests are written specifically to test for execution order.
> > > While we can not rely on the order for other libcs, the idea was to
> > > expect a given order for the nolibc implementation.
> > 
> > OK.
> > 
> > > > I'm wondering if we shouldn't make the tests more robust:
> > > >   1) explicitly set linkage_test_constructor_test_value to zero in the
> > > >      declaration, because here it's not set so we have no guarantee
> > > >      (we're not in the kernel)
> > > 
> > > Ack.
> > > 
> > > >   2) only add values to check for cumulated values (e.g. |1 in const1,
> > > >      |2 in const2) and verify that the result is properly 3
> > > 
> > > This would stop validating the order.
> > 
> > That was my purpose but OK I got it. Then there's another option which
> > preserves the order and even gives history:
> > 
> >   __attribute__((constructor))
> >   static void constructor1(void)
> >   {
> >       constructor_test_value = constructor_test_value * 0x10 + 1;
> >   }
> > 
> >   __attribute__((constructor))
> >   static void constructor2(void)
> >   {
> >       constructor_test_value = constructor_test_value * 0x10 + 2;
> >   }
> >  
> > Then if executed in the right order, you'll find 0x12. If both
> > are executed in any order, it will always be >= 0x10. If only one
> > is executed, it will be < 0x10, and if none is executed, it's 0.
> 
> Sounds good! Do you want to write a patch?
> It should also add the missing zero-initializion of
> constructor_test_value.

OK so I've tested the patch below which does what we want, except that
it reveals that the order is still not granted. Actually I haven't found
what dictates it. On one machine (gcc-9.5, ld-2.26) I'm getting:

  $ ./nolibc-test|grep cst
  17 linkage_cst = 0                                              [FAIL]
  18 linkage_cst_ord = 0                                          [FAIL]

On this same machine, using another toolchain relying on ld-2.27 gives me
this:

  $ ./nolibc-test|grep cst
  17 linkage_cst = 1                                                [OK]
  18 linkage_cst_ord = 33                                          [FAIL]

And I'm getting this as well on another machine with various toolchains
such as gcc-9.5+ld-2.34. The nolibc toolchains fail similarly on gcc-5.5
(ld-2.27) and gcc-6.5 (ld-2.32), but work for gcc-7.5 with ld-2.32, while
other combinations do work:

  $ ./nolibc-test|grep -i cst
  17 linkage_cst = 1                                                [OK]
  18 linkage_cst_ord = 18                                           [OK]

All of this is a bit confusing.

I continue not to understand what could guarantee an implicit execution
order since for me it solely depends on how things are linked, so the
purpose of the test remains uncertain to me and I think we'd rather not
try to enforce any ordering that might work only by pure luck.

What do you think ?

Cheers,
Willy

---

diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.c b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
index 5ff4c8a1db2a4..ebb3eb4208efd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test-linkage.c
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
@@ -11,16 +11,16 @@ void *linkage_test_errno_addr(void)
 	return &errno;
 }
 
-int linkage_test_constructor_test_value;
+int linkage_test_constructor_test_value = 0;
 
 __attribute__((constructor))
 static void constructor1(void)
 {
-	linkage_test_constructor_test_value = 2;
+	linkage_test_constructor_test_value = linkage_test_constructor_test_value * 0x10 + 1;
 }
 
 __attribute__((constructor))
 static void constructor2(void)
 {
-	linkage_test_constructor_test_value *= 3;
+	linkage_test_constructor_test_value = linkage_test_constructor_test_value * 0x10 + 2;
 }
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6fba7025c5e3c..2b5c30033e5eb 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -682,14 +682,15 @@ int expect_strtox(int llen, void *func, const char *input, int base, intmax_t ex
 __attribute__((constructor))
 static void constructor1(void)
 {
-	constructor_test_value = 1;
+	constructor_test_value = constructor_test_value * 0x10 + 1;
 }
 
 __attribute__((constructor))
 static void constructor2(int argc, char **argv, char **envp)
 {
+	constructor_test_value = constructor_test_value * 0x10 + 2;
 	if (argc && argv && envp)
-		constructor_test_value *= 2;
+		constructor_test_value = constructor_test_value * 0x10 + 4;
 }
 
 int run_startup(int min, int max)
@@ -728,9 +729,11 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
+		CASE_TEST(constructor);      EXPECT_NE(1, (constructor_test_value & 0x111) && (constructor_test_value & 0x222), 0); break;
+		CASE_TEST(constructor_ord);  EXPECT_EQ(is_nolibc, constructor_test_value, 0x124); break;
 		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 6); break;
+		CASE_TEST(linkage_cst);      EXPECT_NE(1, (linkage_test_constructor_test_value & 0x11) && (linkage_test_constructor_test_value & 0x22), 0); break;
+		CASE_TEST(linkage_cst_ord);  EXPECT_EQ(is_nolibc, linkage_test_constructor_test_value, 0x12); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

