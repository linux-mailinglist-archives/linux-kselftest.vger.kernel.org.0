Return-Path: <linux-kselftest+bounces-19160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511279932FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F3828313A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666A1D4152;
	Mon,  7 Oct 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcVR/dlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF618BB90;
	Mon,  7 Oct 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318050; cv=none; b=Lk0IB2iPFLsFHTSagpuIWUgsTUurSlO+9HfhTJHBQ2lYnNgGKPdy4fAGu59F/nnDtTNSiV99FyzgSLD1QGni7sd8XeJ+79WJoAN5AjUlHK9dX4CvahQLbUjbWZkasidhxeuXB6OzTPFfHnsf/kXXsjkmo/gMIn6cG8gPeHy7ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318050; c=relaxed/simple;
	bh=hKJzopKHIeeU94UDMhzvhWyaC1SlZ98rMal4CeJdZFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2Ucf8ZrU5WwCOp6iocQHESO/JbbO8PBLaWE7C9ow/D2vf2/TCkOU+UvM5TZTmqu5o6P29r8Q3NqW+HwkITGVzJpZRrgK6UaEj8EeY4BdD+3sY8sQVExLWC1N5Ob5gDVR4EFmP7oaobf2zjm47ZajrjLp6cbQREMTdwtv8rUY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcVR/dlU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so1476381a12.1;
        Mon, 07 Oct 2024 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728318048; x=1728922848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMyy4GOoNHMRhtRy1l8HrsCNrD3SbIJwMor5KtyLhp4=;
        b=XcVR/dlUk7wcZi0H12ShoucQHRxrz7SlPAVZ5w8zm1uppMylrCqw45kzb/x7noOEtU
         Qzti+lQLsye2oe2GvnukKSFJSmuRcIkkB7wHtaP6j4NlqNGOOjGTyz9TQg78UElI3z2E
         e58k1Q9uOu5FaCPXaEonD+9I8u0f6Bh3ZQKZj+6db5ERoKjqvUm31jfE8GigMExycacV
         msjWlAvEI/Xb6Po0KTIx7AxVhSVH3owIlo+NDPrQf+CsdLOCHQvwSAPvmt9I8CT3LoY2
         W/ieG0jjL6Hetud7RzH3ltHAzOGT/BPMktM92ZCW0D+96PrWD+ApLkCtjnBCVjnA78kb
         x5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318048; x=1728922848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMyy4GOoNHMRhtRy1l8HrsCNrD3SbIJwMor5KtyLhp4=;
        b=rBp66IdCslAI3F8j3S8y3PvqrVz+s+rzk4chnMCA2NGRLS1pGpigka+I+uityPqVxj
         jWrZ7y9mbM649f0c0OY3/RCCpCyYGdAMOWDbgjBH6WQEJ9wtIx44XlLyUS3RMc7dOWlQ
         oV69Mux3w6/9KrX1kQsg77SoY8D1uV1uyheUnmLWy5A6HYPr6mxPgk5Hs9LzpuQrmzuL
         IskUB6TnxPWO2y2EPbgyBYkPDEzeheGkcUS7w/OBpJAxX9dhsp4YQmWhjuf7O4KUZryC
         z/e4/i3ztqcQcRgg0YVH0uF3HMlLvrXCGhfj+rXzEnw18XeIrJkXASLy26FDs037nh96
         Q77g==
X-Forwarded-Encrypted: i=1; AJvYcCUexBwd5zR/W470DMdm+P3CI8E1zwL6ucHp8unuDDyh7FT7UwfN8KTjOjWweK5XJjdZnUTmuvx/tTh//G9ANaSY@vger.kernel.org, AJvYcCUk+uDSeErWP5ICzEMjs67KZLnP2JUeegutw7za2bnCvawXvG6UEcPBeimAQAq3V/o7V0c+rsvHfHAtAmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRN0TwkTVX7xNhY6Q0XoNOcEwJgRhEyxLBf7qW/5wV8RGOTlIM
	59OOopY2FLmpgQeOzty8gZZfPck+Oo17lKMJQoFxIuusj8y98+Hq
X-Google-Smtp-Source: AGHT+IEze680vpkfwUUEo6fgj/dfA5lTIXJZ8tUOciSBvYROqJiUC1WQYbK78P5XDgIWUBogWjXCbw==
X-Received: by 2002:a05:6a20:a8a6:b0:1d6:e55f:53d5 with SMTP id adf61e73a8af0-1d6e55f5573mr10733287637.11.1728318048318;
        Mon, 07 Oct 2024 09:20:48 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:d13b:ab1f:73a7:7b60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d452b7sm4600550b3a.108.2024.10.07.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:20:47 -0700 (PDT)
Date: Tue, 8 Oct 2024 00:20:43 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: David Gow <davidgow@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [RESEND PATCH v3] list: test: Mending tests for
 list_cut_position()
Message-ID: <ZwQKW6-YTGwEo1F6@vaxr-BM6660-BM6360>
References: <20240930170633.42475-1-richard120310@gmail.com>
 <CABVgOS=8-UH4Exnh8nw3zws9xrcearCvH8_NDFC_tsZL+KhJ8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=8-UH4Exnh8nw3zws9xrcearCvH8_NDFC_tsZL+KhJ8w@mail.gmail.com>

Thu, Oct 03, 2024 at 02:49:15PM +0800, David Gow wrote:
> On Tue, 1 Oct 2024 at 01:06, I Hsin Cheng <richard120310@gmail.com> wrote:
> >
> > Mending test for list_cut_position*() for the missing check of integer
> > "i" after the second loop. The variable should be checked for second
> > time to make sure both lists after the cut operation are formed as
> > expected.
> >
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> 
> Thanks. I've tested this, and it works now and makes sense.
> 
> I would recommend updating the patch description slightly, as it's a
> little bit confusing as-is (partly due to the early version having
> already been applied and reverted).
> Could we describe this (a) in the imperative mood, and (b) focus less
> on this being a "fix" or "mend" and more on what the new check does.
> For example, something like:
> "Check the total number of elements in both resultant lists are
> correct. Previously, only the first list's size was checked, so
> additional elements in the second list would not have been caught."
> 
> Otherwise, this is fine.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Thanks for your patience,
> -- David
> 
> 
> 
> 
> >  lib/list-test.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/list-test.c b/lib/list-test.c
> > index 37cbc33e9fdb..b4b3810c71d0 100644
> > --- a/lib/list-test.c
> > +++ b/lib/list-test.c
> > @@ -408,6 +408,8 @@ static void list_test_list_cut_position(struct kunit *test)
> >                 KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> >                 i++;
> >         }
> > +
> > +       KUNIT_EXPECT_EQ(test, i, 3);
> >  }
> >
> >  static void list_test_list_cut_before(struct kunit *test)
> > @@ -436,6 +438,8 @@ static void list_test_list_cut_before(struct kunit *test)
> >                 KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> >                 i++;
> >         }
> > +
> > +       KUNIT_EXPECT_EQ(test, i, 3);
> >  }
> >
> >  static void list_test_list_splice(struct kunit *test)
> > --
> > 2.43.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240930170633.42475-1-richard120310%40gmail.com.

Hello Mr. Gow, thanks for your review and sorry for the late reply.

> I would recommend updating the patch description slightly, as it's a
> little bit confusing as-is (partly due to the early version having
> already been applied and reverted).

No problem, I'll refine the commit message, hoever, I want to ask do I
have to send a new patch for this ( since the commit title and commit
message will be different ) , or do I just resent the patch with RESEND
v4 in this thread?

Best regards,
Richard Cheng.


