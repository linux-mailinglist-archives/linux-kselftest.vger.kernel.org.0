Return-Path: <linux-kselftest+bounces-20016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1909A2BDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4943A2861AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9FB1E0491;
	Thu, 17 Oct 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="So5tK1yo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B601DFE06
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188877; cv=none; b=IUK8yThU1UM1DlrBniNn63pxS6QhGzlLfADrthVxJGLW/NJF1vtEOttf8VfoiIUbMAIJKzSvrX3nu5GOReYONqiAt5v8sfvtTqVsRCuu3N1RccKwYfWGq7MxhuuAhIqN+Ad+cqjymbtSnWPVLNeMQgmu8isVDVyFXH8Ghg4g0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188877; c=relaxed/simple;
	bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwHjPMBqhjqgSm1GimEhOgrHo0RsRLE+ZSx3r8DduxXLZAstZ7nT4dBjYBiFcrfSVMxYgY2n13mMl9EJFi63mCTWy1VvJfbLG4okLbyaLac5YvZJQhka94RgcK3wkTgfPU71rmHl9g42Gdrk0Z3ZIRjVoTPWrwaCRKsOvJlA+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=So5tK1yo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-268d0979e90so72061fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729188871; x=1729793671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
        b=So5tK1yoNCceX/2d5lckMMUnim05kGN+RDyKXhAqf6mHwushwu+HPnt24J2JKjQXkw
         R3o12IZLSwFCr66RSh6ltG5RfyL973KXfzhTR7Cblw18BKoGyzA5nCAigElUf0I4NPNz
         yTLbv4/J2EOWvgkNnIBwF6AhhokbtyP/XVBew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188871; x=1729793671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
        b=b6AVoyi8U+kkfpVvp2Agg5wurKq9YeCyCFdoAu0FMMlQNslQQj3ml2QfLQaOprvwU/
         xMKy64QBJjh7ZGvS061YOqgM0BkC2Ot9wp/qsI+95fQn5YWV2UekN0byrjSyZp8XBBU/
         7trsQynDtupN2M1YXkLbsq/B9iM80CTwOUw/BuaqzTuGbfHwoTha6FJLeSIXXfgOoH4W
         58yyMYSdik7vDdTVWai6Cy2d9d9UQAj1c6LtO39oxEbvQzd0OUZiv1gUDOMslmgNV5EA
         UcBkcb6hUVTNC7YjU3fyB6HMiO9mDhGJT5lr+fBQE03UDng94hcSvtd00kQxXcsO8wLi
         1EPg==
X-Forwarded-Encrypted: i=1; AJvYcCWMlp4AYrLqCMugmyaIr6XDIL0tm6ONYaOC2A0366E26Ne7GRWS1eZ0RhFWgWlkBpPJpzbohwflda3wnH9qmNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65hLvQcdWbCh3xc20IHNgz0LWBlfRJfmYf2DzeG6c3ZLuDkGV
	MU7WzkIgcEPKauf+eoX9qArZ6A7vM1y9+1InW9fygZn106uot4UQKJGMN+gplvB6LIEtROaD/hU
	JnyhsjfSk5Klc2p9fTx3vpEtZu78aSQl+sWWA
X-Google-Smtp-Source: AGHT+IEVVY3x9zDyAxMQtSpj1wu+AKPQttF5+Qsw65HIRp9QuQsb3AQbNuaft90UaiRUD5a3DfimZkgaCjLSlrpmkTk=
X-Received: by 2002:a05:6870:e414:b0:25e:44b9:b2ee with SMTP id
 586e51a60fabf-2890c617250mr1177242fac.2.1729188871620; Thu, 17 Oct 2024
 11:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
In-Reply-To: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 11:14:20 -0700
Message-ID: <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com, willy@infradead.org, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo and Muhammad

Reviving this thread since the merging window is closed and we have
more time to review /work on this code in the next few weeks.

On Fri, Sep 13, 2024 at 3:50=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hi Lorenzo
>
> On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> >
> > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this po=
int
> > too - I may be missing something, but I cannot for the life me understa=
nd
> > why we have to assert negations only, and other self tests do not do th=
is.
> >
> My most test-infra related comments comes from Muhammad Usama Anjum
> (added into this email), e.g. assert is not recommended.[1] ,
>
> [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@coll=
abora.com/
>
Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE

Muhammad Usama Anjum doesn't want assert being used in selftest (see
[1] above), and I quote:
"We don't want to terminate the test if one test fails because of assert. W=
e
want the sub-tests to get executed in-dependent of other tests.

ksft_test_result(condition, fmt, ...);
ksft_test_result_pass(fmt, ...);"

FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
replacement of assert.

Please let me know if you have questions on this and Muhammad might
also help to clarify the requirement if needed.

Thanks
-Jeff

