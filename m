Return-Path: <linux-kselftest+bounces-35435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B0AE1C9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213743A8C8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC328E578;
	Fri, 20 Jun 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bL6iBar9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uI2lqy+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEB1E47B7;
	Fri, 20 Jun 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427423; cv=none; b=kiAN91J9iWSB5ioTUgNP0A3tml1oO1tHAsXrlL00teMiLt3q/rNsThPGkTqy0DjFtPi6adahlr2B1auxp26pjBoWNFsQqqk+lhAgMkdv4eNs5VlNOGqzzgie6Oav+QESCD6qeB/8gMGVAncfhKjU62WgFI+Vf9MUMnAEy3ORqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427423; c=relaxed/simple;
	bh=EhB/9fVRF7Lh/rEakg8Cd3L6DZp2n4PHnzXdkTUl054=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su3P/FBDA6IrheX3kENJOueLT6AF7njt1gWXj8d/K/IUc3/vqXQL1lKH5KWZ8PRllMAUtpv5cQgXlriIEVuof9C2qmQuYlWfKefc/8ajJ4zigwbQeecKcFNhOCLT+6tUR9YfO69yr+4rlf4FCVM8RB0fEETwCNlFx/ARdw1vryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bL6iBar9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uI2lqy+e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 15:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750427420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjzSfiMgzjbJPtz34LRfOtXpbo+tLxgxkNks+JkVZ88=;
	b=bL6iBar9j84mRqpnw2Bb/piFTqoCtYiys7YQUV+/ydPaRa9/fY/7fEmjlVkAPc/XakoGbw
	sW2MRFs8TMcPHCu413LXsftJlEZtMdQdroNYGVFOEJSOrr3ZDc8ojpD2YCFN76LtYjZEjR
	4EfS+iShJfP33H6stThryXblX1IdUp/Cdda5ynWW0cQ3lFkgF6HOcfRqnaNjwTiLyYLTNb
	y12aoeOdhC6kF0OmuZonAZ5aAwgiE+bgI17vTKmGjUsZZAq1qgGmDJOCwDrAFCY2LJz84f
	DLgeQD5IG/+cHQhnUm7zAJZyhzMUuG89/h/ufq5rIJkNgbuxqgadJZhe9U1Kzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750427420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjzSfiMgzjbJPtz34LRfOtXpbo+tLxgxkNks+JkVZ88=;
	b=uI2lqy+e+cujbEB1wBGlRvE7HiY0YGnrv1yYnXFyP+bB8A2OhDYaslLPUpICycctN+U2CO
	rpo8YxbPjbrhKrDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v3 16/16] kunit: uapi: Validate usability of /proc
Message-ID: <20250620154408-bc103402-56f0-4ac1-a06f-63b2ed30ed29@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-16-55e3d148cbc6@linutronix.de>
 <CABVgOSkzpY8327ePSjuLcbz2jWZkavJvJfF7eehCsS0uzkB65g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSkzpY8327ePSjuLcbz2jWZkavJvJfF7eehCsS0uzkB65g@mail.gmail.com>

On Fri, Jun 20, 2025 at 05:48:07PM +0800, David Gow wrote:
> On Wed, 11 Jun 2025 at 15:38, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Show that the selftests are executed from a fairly "normal"
> > userspace context.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> 
> This is good. I'm not 100% sure the example test is the best place for
> it, though.
> 
> Would it make more sense to either have this:
> - in the main kunit test (since it's really _verifying_ the KUnit
> environment, rather than documenting it)
> - in a separate kunit-uapi test (if we want to keep some separation
> between the UAPI and entirely in-kernel tests)
> - in a separate procfs test (since it tests procfs functionality as
> much as it's testing the KUnit environment)

Originally this change was really meant as an example for users.
But moving it into the main kunit test probably makes more sense.

> Personally, my gut feeling is the main kunit-test is the best place
> for this, even if it means spinning up a separate file is best here.

Ack.

> As for the actual implementation, though, that looks fine to me. A few
> small comments below, but nothing particularly important.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >  lib/kunit/kunit-example-uapi.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uapi.c
> > index 4ce657050dd4a576632a41ca0309c4cb5134ce14..5e7a0f3b68f182c42b03e667567e66f02d8c2b86 100644
> > --- a/lib/kunit/kunit-example-uapi.c
> > +++ b/lib/kunit/kunit-example-uapi.c
> > @@ -8,13 +8,45 @@
> >   * This is *userspace* code.
> >   */
> >
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> >  #include "../../tools/testing/selftests/kselftest.h"
> >
> > +static void test_procfs(void)
> > +{
> > +       char buf[256];
> > +       ssize_t r;
> > +       int fd;
> > +
> > +       fd = open("/proc/self/comm", O_RDONLY);
> > +       if (fd == -1) {
> > +               ksft_test_result_fail("procfs: open() failed: %s\n", strerror(errno));
> > +               return;
> > +       }
> > +
> > +       r = read(fd, buf, sizeof(buf));
> > +       close(fd);
> > +
> > +       if (r == -1) {
> > +               ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
> > +               return;
> > +       }
> > +
> 
> Do we want to use TASK_COMM_LEN rather than hardcoding 16 below?

> (And, if so, do we need something more complicated in case it's not 16?)

TASK_COMM_LEN is not part of the UAPI headers.
But I don't think it can ever change.

> > +       if (r != 16 || strncmp("kunit-example-u\n", buf, 16) != 0) {
> > +               ksft_test_result_fail("procfs: incorrect comm\n");
> > +               return;
> > +       }
> > +
> > +       ksft_test_result_pass("procfs\n");
> > +}
> > +
> >  int main(void)
> >  {
> >         ksft_print_header();
> >         ksft_set_plan(4);
> > -       ksft_test_result_pass("userspace test 1\n");
> > +       test_procfs();
> >         ksft_test_result_pass("userspace test 2\n");
> >         ksft_test_result_skip("userspace test 3: some reason\n");
> >         ksft_test_result_pass("userspace test 4\n");
> >
> > --
> > 2.49.0
> >



