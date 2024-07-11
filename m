Return-Path: <linux-kselftest+bounces-13622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E244C92EFEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E5E28290C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3319E811;
	Thu, 11 Jul 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjLdM4x3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F355C1A
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727329; cv=none; b=VfoOsMH2ifJoQGX7dUVFngiv2sPYBPbjetFiz3UTtQeUrP3pCHyALY6L+5nP9hnu03tYgx7tMNSAl2LBsGxmbrC3NiVPk2vyQxnLnlwGEZQlqDuQqdGTxsw4VK2+16SKzEeOb5ytS16i/w5DPoWG1N1KpYVKQyiPbyOC5yes4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727329; c=relaxed/simple;
	bh=tb58gEoHRf00usq4YrS77k7tSz89sKAGoUyIQBAoONg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecN92vXuL3Y2M3s3s6Myb/U3s/r91hbBuiJ1YYtySgD0INQBS5FgA51Yvb9wI3FCO6B/zkcIL69lX0Oq/vvhWyGR/xv4UvZsqqTXTio1Z/4ntxfDVcg46o1XqJLK5A1jTU3MtK0uPXdaHOFP0000FDhT7GY0pSGmhJ6Ui+dj/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjLdM4x3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0561513c21so2508964276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720727326; x=1721332126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aElB1fegglFT2D3JN2CLPcQ6qQqO2qosToZ4jk6yCY=;
        b=LjLdM4x3TA62czES2Km2g3UH7qQJLQJL1GMIDsQYMHQrh64iYJ5XsUkKydx2KHja9A
         lvJd5r1Sdw3+ZfQAl0h/0hG1FadMwSaB0BSN8M8pnttTUwi+fFFjrlCHe7HkfuGqR62n
         gVND+o7RSqop7Ipc6jemn/lZsBGoY0lfFLQPgLwvoUHvqGnWpDHz3aWgO8E2k9VwNsPP
         PZgCD0DMuF0ND3jMQpXyw+Xb1rT2ydUZe+EsiMSU6ANkrpHv7x1VwZcvdEfPuGx002Rx
         fGBwFporDmjvz1BBv7hxuzP/O/EOGYSrlhSiIY8jpk+VuaEmssKGGtWY0WJWfc5SZQ72
         v8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727326; x=1721332126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aElB1fegglFT2D3JN2CLPcQ6qQqO2qosToZ4jk6yCY=;
        b=oJmg8pRzTbPaE3R3TPIQfyZnmyUaBceBOeXmoXGH2pVNQj9wSi39HtZr7ZQV697nEw
         H/kNETKwsfI2xcjEgD4HtMBTPKpNo453nRHJK5Cw522H6BPaXf6SO6dQml7Knmk1j9aG
         qzDSaKlEcOvF92YwhCTibghoH/FfurMVp9EwKEo7FCyGLsb5OzC2tbxQYEXnruDEy4P1
         lcwrDyLKEcnhyluqPkhRG1z80aMHQj79ADqMhUNPvWV1uVy8UNnybVVxj+qQzF/8Jn7s
         tJoKeYh+5ZH0kDU2a/Kc+ocWyZwS/F9wJTqzpVG5auVGpeQojJshcJU6WX0MwM2Pcq3E
         a6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUhZJyVwXb+9wnBO8c+KaKNZ0OJ20rG0coH298DW8ud9vWu4DxIR/q3MLXtRk0rDhP+sH0/V+PHr5LrFD4nW9+UFCWYXAriLBemcrPzEbho
X-Gm-Message-State: AOJu0YyHyeEtwijwrAWffneVpmrCz09vet1nXRKO+x0LN7W5tuXJG2y+
	DoMJ2BpdIUzISipXqV80pNedLHAUWNMkMLKhbeNdWvp6gr5SWkxVMOqApiNFeBLQue6KLEBjx4r
	8WFLe4BZQQmzR6yIaKw==
X-Google-Smtp-Source: AGHT+IHnnxoOarI7jzIaWtWcX2Acp5MLnm56F5CDC46aUMGpIq0booqF5aFvVLZgeP6B7QwA3ZvVN3nNWTsG0DMV
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1508:b0:dfa:ff27:db9 with SMTP
 id 3f1490d57ef6-e058a92c5e8mr4355276.5.1720727325988; Thu, 11 Jul 2024
 12:48:45 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:48:39 +0000
In-Reply-To: <CABVgOSkJOyLDZmPk5vj+o7aRbEZFDJvynWRacNJZ_M_gn9x1XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABVgOSkJOyLDZmPk5vj+o7aRbEZFDJvynWRacNJZ_M_gn9x1XQ@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711194839.116575-1-ericchancf@google.com>
Subject: Re: [PATCH 2/3] kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_ASSERT
 for readability
From: Eric Chan <ericchancf@google.com>
To: davidgow@google.com
Cc: brendan.higgins@linux.dev, ericchancf@google.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rmoar@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 11, 2024 at 11:49 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, 11 Jul 2024 at 01:06, Eric Chan <ericchancf@google.com> wrote:
> >
> > Both KUNIT_FAIL and KUNIT_ASSERT_FAILURE defined to KUNIT_FAIL_ASSERTION
> > with different tpye of kunit_assert_type. The current naming of
> > KUNIT_ASSERT_FAILURE and KUNIT_FAIL_ASSERTION is confusing due to their
> > similarities. To improve readability and symmetry, renames
> > KUNIT_ASSERT_FAILURE to KUNIT_ASSERT. Makes the naming consistent,
> > with KUNIT_FAIL and KUNIT_ASSERT being symmetrical.
> > Additionally, an explanation for KUNIT_ASSERT has been added to clarify
> > its usage.
> >
> > Signed-off-by: Eric Chan <ericchancf@google.com>
> > ---
>
> I personally am not a fan of KUNIT_ASSERT() as a name here: to me it
> implies that we're checking a boolean (like KUNIT_ASSERT_TRUE()).
>
> Does making this 'KUNIT_FAIL_AND_EXIT()' / 'KUNIT_FAIL_AND_ABORT()' or
> similar seem clearer to you?
>
> (Or possibly we could make this KUNIT_FAIL(), and make the existing
> KUNIT_FAIL() become KUNIT_MARK_FAILED(), though I think it's not worth
> the churn personally.)
>
> -- David

Hi David, 

Thank you very much for patiently reviewing.
I understand your suggestion, indeed KUNIT_ASSERT will be misunderstood as still an assert behavior.
But in fact, this macro has one extra abort behavior than KUNIT_FAIL.
I think KUNIT_FAIL_AND_ABORT is a pretty good name to understand itself.

I've updated patch v2 at [0].
Thanks for the reviewing and suggestions.

[0] https://lore.kernel.org/lkml/20240711193729.108720-1-ericchancf@google.com/

Sincerely,
  Eric Chan

>
>
>
>
> >  drivers/input/tests/input_test.c |  2 +-
> >  include/kunit/assert.h           |  2 +-
> >  include/kunit/test.h             | 13 ++++++++++++-
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> > index 2fa5b725ae0a..cbab24a265fa 100644
> > --- a/drivers/input/tests/input_test.c
> > +++ b/drivers/input/tests/input_test.c
> > @@ -31,7 +31,7 @@ static int input_test_init(struct kunit *test)
> >         ret = input_register_device(input_dev);
> >         if (ret) {
> >                 input_free_device(input_dev);
> > -               KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
> > +               KUNIT_ASSERT(test, "Register device failed: %d", ret);
> >         }
> >
> >         test->priv = input_dev;
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index 24c2b9fa61e8..02c6f7bb1d26 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -60,7 +60,7 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
> >   * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
> >   * @assert: The parent of this type.
> >   *
> > - * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
> > + * Represents a simple KUNIT_FAIL/KUNIT_ASSERT that always fails.
> >   */
> >  struct kunit_fail_assert {
> >         struct kunit_assert assert;
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 87a232421089..d1b085fd5dc3 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -1193,7 +1193,18 @@ do {                                                                            \
> >                                                 fmt,                           \
> >                                                 ##__VA_ARGS__)
> >
> > -#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
> > +/**
> > + * KUNIT_ASSERT() - Always causes a test to assert when evaluated.
> > + * @test: The test context object.
> > + * @fmt: an informational message to be printed when the assertion is made.
> > + * @...: string format arguments.
> > + *
> > + * The opposite of KUNIT_SUCCEED(), it is an assertion that always fails. In
> > + * other words, it always results in a failed assertion, and consequently
> > + * always causes the test case to assert when evaluated. See KUNIT_ASSERT_TRUE()
> > + * for more information.
> > + */
> > +#define KUNIT_ASSERT(test, fmt, ...) \
> >         KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
> >
> >  /**
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >

