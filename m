Return-Path: <linux-kselftest+bounces-37097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EAB01BDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477BF7A2374
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CF293462;
	Fri, 11 Jul 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSCVCpX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6C23ED6F;
	Fri, 11 Jul 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236401; cv=none; b=gj1dj85Edakf2QCiMWC5cjB1WmztJNyWxm5mCIMIeSJ/4Dq/FJpnZaccprF5zXDpaQads1MZ5ysxk/+P5KOILRCPL1CHiFX3GgPMBdQMXNgwjlionBfutZmrPGU0fVY66veeMrRrv6HriT8UNtvSnyouVrO/22GZHn+hgtmDhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236401; c=relaxed/simple;
	bh=5QrNAvXeMUk7y37R7Zu/tN58cr40TcjK1OVyDOV63P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVoCyh+Dk6dZFmQ3DeBTVB4wSc4WUbTYOj01Cw87TrdgTlxnBBdqNPEfCXco1cZ+gcCaAdktfJH3cgLPfm9XuuI1Bls2FqCBmiwX88GdgTHX7WQz8cyVXcVqXlNmORbvdQfHNQdBvPjxZuA4IJrUT0AIEo1pxSMD+0IXvggsl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSCVCpX+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74264d1832eso2739527b3a.0;
        Fri, 11 Jul 2025 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752236399; x=1752841199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtD/R9U6PRpAzS1nHpzjgk1+bYjlX29GjraDajvp0u0=;
        b=hSCVCpX+ORNXMIKTl94ndv4vFRPmht6WOtRbAr+RLyv9wljOYKa9iWPt86wW2Bk1ff
         1Sfwb9SQvE4nt0BHF3STrdDudgrfjsfsHjx07ZD3K1ptJqNzR078Wl0E9rzTLSlV7Sqy
         Np278C1bsgbZk8djprt9iAx+rMIwpJTJV85FdPUrEUAeaT6nzr1lSB7zHm4KlU6rjk+N
         +acKFeQj6UtxtvZa1ZcMAXM7SBnrAtyOnFj3GirZKXiTB6C8HVVCE2rqU5R+ip/ULIYx
         kFKec3HfuWiDb//i7qLS0eFIUWkJZW/dM0fhu2qns6qjM2WQrJ3P5zp8jaj2i5ArDlX5
         gKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236399; x=1752841199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtD/R9U6PRpAzS1nHpzjgk1+bYjlX29GjraDajvp0u0=;
        b=ONQEaKGaoy+VAvgFdLs1PL8GbPmSrr6NBW2+4C72JbTNJkW+4AbXDtir6BSGopk9+B
         F8+k89fMdiOX2Mv76PQhkN9hV+ao8ho4HOBgkhqAh9r36QGtecwTnXqrXaOceFpWfdPH
         EZjfKZ06EzpcEnZ9gyURREAs/2kk2YFSjg8b3Ol/OLgPx41XsNIgcGaS5wT7IWqNUCkD
         rNG2vO2vZ3Z4In1E1dJxbg9D1Mn8ylJ9aP35NDr2T4afMvOEF9zPSgc1VL6kpeY2w+pz
         zZii4EmhxEM8CSdpfLGiYECQZtpukExfqd4ZOlfge0TM2MUdwolLOqsBAoztrqIv8E3o
         2CWA==
X-Forwarded-Encrypted: i=1; AJvYcCXsP6Jw2pigMnDR2d8Ay58MedE7gCr6fVEWvDUTFvUv57qW0jMP3aesGn7JFSgVgHXz/k7BlcnplLN7jOg=@vger.kernel.org, AJvYcCXzLTC+tKa7df0tuWPxvny+C6kq2GsqAHZSliMvEAz1cH9ihD+LHkIHTb+CQz1yqRN3cSqEOPZtC1feCxlXtQ8H@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPNM2Jk3cMjZ+g5a1PEolQFbCSrCr6vcWKykJAxiLE7V620TT
	nAQ8x8hpuFHxIUxZkwLGBu3XBxfmI1sYjqisLxx5rRA3jAf5VHKbJ/ej
X-Gm-Gg: ASbGnct2nz7760+4VKw/c2aDbNrEZTpUOvoB6sleNeGG6YKZ074EbltrB1ZPncPSPvg
	0sK4vIt5tJyhhvy/zYAhxqADg6dKwOScML22yaxi26fcIzJTbAyswt/KxTg/0xJAj9MgIsKr6Cq
	QjnXY/rY+hWK5jXw8C/PFDpalpcrQbZ7GixLHNzhqxfwW3/xn0j7FLHHFvY8pU9xLbNFdffgZJx
	x3iyxe4n2h5seyKhAcC6R5+wy2PwStOzo2LZavLpmVMXwyQZ4ZQeaResGNOQ7BoyWJOZ/Ik2N0o
	k4vicsYIeRHTPRSf9kLiyb6U9Td9uXcCcYKnYO0cwYdZuMKn+y+KZELa8+8DVhaB1HsnEA8D2D7
	Dhi73uVSzCjN/QtPG2qPWNLaTfniYhqKyVkmZgiLSOdbhex7S
X-Google-Smtp-Source: AGHT+IFir+KTTk8mgUXFq5lbtUVSMfktmgJYRFls6w9p8Eajyy/4y3kuXXHD32P4jlxeEkBaynv8ew==
X-Received: by 2002:a05:6a21:3318:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-231363657d3mr4445241637.11.1752236399289;
        Fri, 11 Jul 2025 05:19:59 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd97fsm4963163a12.36.2025.07.11.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:19:58 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: broonie@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Fri, 11 Jul 2025 20:19:48 +0800
Message-ID: <20250711121952.17380-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
References: <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

Hi Mark Brown,

> On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:
>
> > Add tests for process_madvise(), focusing on verifying behavior under
> > various conditions including valid usage and error cases.
>
> > --- a/tools/testing/selftests/mm/guard-regions.c
> > +++ b/tools/testing/selftests/mm/guard-regions.c
>
> > -static void handle_fatal(int c)
> > -{
> > -	if (!signal_jump_set)
> > -		return;
> > -
> > -	siglongjmp(signal_jmp_buf, c);
> > -}

> I see from looking later in the patch that you're factoring this out of
> the guard regions test into vm_util.c so that it can be used by your new
> test.  This is good and sensible but it's a bit surprising, especially
> since your changelog only said you were adding a new test.  It would be
> better to split this out into a separate refactoring patch that just
> does the code motion, as covered in submitting-patches.rst it's better
> if changes just do one thing.

Thanks for the suggestion. I’ll split this out into a separate patch
that just moves the helper to vm_util.c, and follow up with the new
test in a second patch.

> > +#include <linux/pidfd.h>
> > +#include <linux/uio.h>
>
> Does this work without 'make headers_install' for the systems that were
> affectd by missing headers?  Lorenzo mentioned that we shouldn't depend
> on that for the mm tests (I'm not enthusiastic about that approach
> myself, but if it's what mm needs).

You're right, and I’ve seen build issues due to that as well. I’ll drop
<linux/pidfd.h> and define PIDFD_SELF locally to avoid requiring
installed headers.

> > +	ret = read(pipe_info[0], &info, sizeof(info));
> > +	if (ret <= 0) {
> > +		waitpid(self->child_pid, NULL, 0);
> > +		ksft_exit_skip("Failed to read child info from pipe.\n");
> > +	}

> If you're using the harness you should use SKIP() rather than the ksft
> APIs for reporting test results.  Don't mix and match the result
> reporting APIs, harness will call the ksft_ APIs appropriately for you.

Understood. I’ll convert this and other cases to use SKIP() and ensure
the test consistently uses the test harness macros.

> > +			if (errno == EAGAIN) {
> > +				ksft_test_result_skip(
> > +					"THP is 'always', process_madvise returned EAGAIN due to an expected race with khugepaged.\n");
> > +			} else {
> > +				ksft_test_result_fail(
> > +					"process_madvise failed with unexpected errno %d in 'always' mode.\n",
> > +					errno);
> > +			}

> Similarly, to fail use an ASSERT or EXPECT.  Note also that when using
> the ksft_ API for reporting results each test should report a consistent
> test name as the string, if you want to report an error message print it
> separately to the test result.

I’ll revise this to use ASSERT/EXPECT, and separate error output from
test result strings, as you suggested.

> > + * Test process_madvise() with various invalid pidfds to ensure correct
> > + * error handling. This includes negative fds, non-pidfd fds, and pidfds for
> > + * processes that no longer exist.

> This sounds like it should be a series of small tests rather than a
> single omnibus test, that'd result in clearer error reporting from test
> frameworks since they will say which operation failed directly rather
> than having to look at the logs then match them to the source.

That makes sense. I’ll break this out into multiple smaller tests so
each case reports independently.

> > +	pidfd = syscall(__NR_pidfd_open, child_pid, 0);
> > +	ASSERT_GE(pidfd, 0);

> This is particularly the case given the use of ASSERTs, we'll not report
> any issues other than the first one we hit.

Thanks, I’ll switch to EXPECT_* where appropriate to allow multiple
checks per test case.

Thanks again for the detailed review!


Best regards,
Wang Lian

