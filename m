Return-Path: <linux-kselftest+bounces-5072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5285C59A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4F9B21812
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA12768F1;
	Tue, 20 Feb 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b0Aox2C3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CB14A0BE
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460184; cv=none; b=qsy2VkIH70Ns3Bo9vU3QSTfA/BYZhhYqd+QUP10K3AbuZ8xftu5zAoFoUkgacHimZe+iQYA7KEUK9P/FXXAOAuTftfC4c3DRdS01utRU5OFx2fhx705BfUJ8v0F6XAvs9bkNpbqyQtTBkJkFsJKx6Sx5kJgtF9pcQa0q2vClqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460184; c=relaxed/simple;
	bh=Bn1Gdz/wdbcEWBGG2cIMSmnLhdSFWbRTBNhZ7jo0UNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5W/TxQ9PgP6hfQOKi8SaP2wdcLL/QQVB/Zw+Xa97DRYSP9FI7nYdZNWtR11yOuZa9XG6ezhJrKdIiL9KIr4gtBKXeTVLvNE2K0+yZU0ZyuJLfqSFCRgkNOil4GrB3ghgI+XBGwvQGI+saBQtpoLYYx9Jn+0B3V6V/VczmZhyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b0Aox2C3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e72ec566aso356164466b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708460180; x=1709064980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SASJvZiK5JLGZlQtlEOJrENESAKzYR2wqRZox3lXmic=;
        b=b0Aox2C3UNhk2JPypHY7D+FbqHQtKDrLRqjx6zf3wfqZM0z2/Ynmn2eaK0CRCIAkmS
         KmWrECceXEdBj8ZsWSr9DX+7LaKn0BB35SmX+F5RuNjscYQMgpyvKlKQSSL6za8+3w3K
         N1y65Cug8gKq90Jeg+YwL+dvprVNHHV/croxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460180; x=1709064980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SASJvZiK5JLGZlQtlEOJrENESAKzYR2wqRZox3lXmic=;
        b=FqpNvPqcnCE50mYwK3ydtQl3fVVlXjAqKlFhZWCdzu808rMUBYlpODXrYsFi+NwpWr
         kll2SBH3ABtqlW43D1bSO1U3UPLG1dlqlzfGjzIt7qN0yWOTznDAPOZr67g8jHePKHRx
         mBDH/sL9/t2T+ZZ7wmtJq+PSO1k03bGSk3yluoimlJ31iXu2ah1LiqjDVQ8VA3XZspK9
         UuMqDdz9bEoojRDbDX7AMZmt/BrDozFfmLVgTVWhm4EfkbZFAuG3M3+5H80e6TKxxyV0
         Fx/7K+TOW3IKcsV/4+04tqWwLwySUro5RU7DfGCZz3sRrwL7P4tuQH6uHEAp8d9y765D
         xcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSAUzzDi7VPp0ig74gVONbeYSCgruGmt5XSJiXsCx1Aj/Ja3E+Px3F7J6X8wsqfmCGezaTUeydA+UguhUoikbuphWhV4edrMJGx3Hms+P5
X-Gm-Message-State: AOJu0YzZ62t1EMPFOkDonJppPu9eQ+hfT2GitheAH5oK37Z3P8t9qwLI
	Ky5FijjyjmmEvsxDACdiDeJN2kcZG3Tlxx5BkhBH3StjQ0K4N60I+jV12gV2SrcMJfQlFjzLJEV
	/fJYzxQ==
X-Google-Smtp-Source: AGHT+IEhHrCTFf+tu0o4dZv2+vDA7GetG8JMUVVgtGJ4a56Jwfw8dk6sG9FYJVNWfHfB7Ikb3g3geQ==
X-Received: by 2002:a17:906:29db:b0:a3f:10e8:ae2b with SMTP id y27-20020a17090629db00b00a3f10e8ae2bmr1503722eje.54.1708460180281;
        Tue, 20 Feb 2024 12:16:20 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a3f04112c0csm799590ejb.221.2024.02.20.12.16.19
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:16:19 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so7133004a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 12:16:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEbsDcBiGnOhocPE+KNhzql7J6aDWC/CDTuAJIinso1ferbEiMYnPAKZGsr5An03woOzenncOfg4RJc06+SEEqp92J8llIGgU3XdcdOUgN
X-Received: by 2002:a05:6402:1850:b0:561:f6db:2fd6 with SMTP id
 v16-20020a056402185000b00561f6db2fd6mr9678466edy.42.1708460178802; Tue, 20
 Feb 2024 12:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net> <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
In-Reply-To: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 12:16:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
Message-ID: <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
Subject: Re: Linux 6.8-rc5
To: Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	kselftest list <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 11:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It turns out that that commit is buggy for another reason, but it's
> hidden by the fact that apparently KUNIT_ASSERT_FALSE_MSG() doesn't
> check the format string.

The fix for that is this:

  --- a/include/kunit/test.h
  +++ b/include/kunit/test.h
  @@ -579,7 +579,7 @@ void __printf(2, 3) kunit_log_append(struct
string_stream *log, const char *fmt,

   void __noreturn __kunit_abort(struct kunit *test);

  -void __kunit_do_failed_assertion(struct kunit *test,
  +void __printf(6,7) __kunit_do_failed_assertion(struct kunit *test,
                                 const struct kunit_loc *loc,
                                 enum kunit_assert_type type,
                                 const struct kunit_assert *assert,

but that causes a *lot* of noise (not just in drm_buddy_test.c), so
I'm not going to apply that fix as-is. Clearly there's a lot of
incorrect format parameters that have never been checked.

Instead adding Shuah and the KUnit people to the participants, and
hoping that they will fix this up and we can get the format fixes for
KUnit in the 6.9 timeframe.

Side note: when I apply the above patch, the suggestions gcc spews out
look invalid. Gcc seems to suggest turning a a format string of '%d"
to "%ld" for a size_t variable. That's wrong. It should be "%zu".

A 'size_t' can in fact be 'unsigned int' on some platforms (not just
in theory), so %ld is really incorrect not just from a sign
perspective.

Anyway, I guess I will commit the immediate drm_buddy_test.c fix to
get rid of the build issue, but the KUnit message format string issue
will have to be a "let's get this fixed up _later_" issue.

              Linus

