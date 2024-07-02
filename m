Return-Path: <linux-kselftest+bounces-13079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B3924961
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2583C1F258B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7F201242;
	Tue,  2 Jul 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dc+6/1my"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0B1CE0A1
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952587; cv=none; b=oTQNagNhsMHfLxVVAMDq64467dxphh27CR714PFr5ZEetajkdLlNLBz8NKEIKiFsparuLvHExRJBoVc0BU1Yo4CJyXliA633k7nF8L8XuBHTLOhP9U034C6DAmPIpjv5TJZE68O6QYnZ2+ATXOcCDL/g0oxB7ho6a8usgHc3Dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952587; c=relaxed/simple;
	bh=oIZ+qFeEAMiEHqcHkGf420iEqeFpgZPDR6xLSjPRQZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUz5hRmKbNQU3Kq0raVqlhowawhhlNH6RNGoRbzpCsqzT750KMb1dQOGYJiqVnzfwWGkWQwLr/tWyZNV1qYxZioMgsYo6UTrSB6C/UZhm6RfIjeR883tk3T6BBGqeMvuQW/6CPAzdFATJh2cCS1/64aF1phcff1/MLrUxZsWbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dc+6/1my; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-444fe7e9f11so104631cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719952584; x=1720557384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3XnOUTxL7Khvj5clLjXUpjkjIAJvXl6J+yhlYNwVw0=;
        b=Dc+6/1myJBVkHbpgutY9GzbhK9z295MV5LjraiqT+PycFTY7ZAj5faQ8heBYyknVGn
         5Kq6wZ4Sp5Qaqs6/NZag3bO+sM1cIiLDCeHa7W09Mlrfuz3fkAe+csZvNwo3SbRS010D
         +/U6VgRChXu/M+Pi0TelI8i1yDpjmQbbOuFcHW3zN8xXuZ74rZywV+ll11raxVeh9u+E
         uFC4YtOSSqdbgNoJ1As80B9n+2qYWrjcWaht6b4ode5FPNdEcCtjh4o33qC7MydNaEgr
         zrHKoEwmvcZKug8wvROGhf0T6n0af0gY+jpdaH7tYBPXAL2+hUV5+6fNzbp5v5E19Sp4
         8nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952584; x=1720557384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3XnOUTxL7Khvj5clLjXUpjkjIAJvXl6J+yhlYNwVw0=;
        b=fkc4vl6aQeJtZX6ikfCe7FiJdrE+4Y05U7KwUsfuaErOjvLdkCY96S6/bZcXyE3nnA
         N4QuoJu0jNGQ3j0/MkoTLKQXyf+HODmTgvvr/rQbsVEZm3ENdRNga3PTrHiIHKSj0Qv/
         VBzfoRsiam1brKjtAo5UTqpCR/QglelEjSxoM8YcL+JwTc/bg1c9Zs1GGEE66dG4R2Ii
         8Ug9E/27JF8ZDyvcW/9F6vF+gegwkWTHcfDNfg2Rhpsxx8BabksgWtsN6XH8jdE/4j1z
         +nVCgttL/UL5Rp3eRnN0ilP50jVXMkYtU/z7WUhIDkV65ItdvmxSpEdeDy/Ifw2dcCt+
         L0vw==
X-Forwarded-Encrypted: i=1; AJvYcCWp29OYg3HLf1EqHVbLKOjO/pmUOoQMw/diXA8AzAvRgw3mWyI7Q1hKqFnp1Iopvd6JpjjvL+o+Ax+ZtzyIY1kjRVHp1kO6XK61REqg6soh
X-Gm-Message-State: AOJu0YzM9yKg66/yovGDcIg0Tlehfd4h6ng+BwoUOGX2xkpnJcciJ88a
	gWnXY102iXywH1+7/f+TgAghWCsiyvKZFmf4Gk6w0/CWQa3uH6UVlmSNFjkDLan94G8pGyNkmOj
	g95kcUtFciisIq4FBjB82BM8TFO3myBSRlbRW
X-Google-Smtp-Source: AGHT+IHAG7v9n5i2ldh8TX1jsYKCXmrofIE/3++As3TOB5fu1ttid4KYzf35bt3BFAU6aTcbOkSIW3Fghzdnyy/bWqM=
X-Received: by 2002:a05:622a:a028:b0:43f:ff4f:c130 with SMTP id
 d75a77b69052e-447bc4a36c6mr980141cf.2.1719952584271; Tue, 02 Jul 2024
 13:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d4afb49-3cb9-f176-61a2-5bbaab698644@gmail.com>
In-Reply-To: <6d4afb49-3cb9-f176-61a2-5bbaab698644@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 2 Jul 2024 16:36:11 -0400
Message-ID: <CA+GJov5=HVTQL8fk50f5LGCfVMDXRLx65UYLt-t1vD9vu0M5Dw@mail.gmail.com>
Subject: Re: [RFC] ktap_v2: KTAP specification transition method
To: Frank Rowand <frowand.list@gmail.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com, 
	Brendan Higgins <brendanhiggins@google.com>, Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com, 
	guillaume.tucker@collabora.com, dlatypov@google.com, kernelci@groups.io, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

It has been a few months since there has been activity regarding the
second version of KTAP. I wanted to bring this topic back up to the
surface.

Currently, Frank has compiled a list of KTAPv2 patches here at this
link: https://elinux.org/Test_Results_Format_Notes#KTAP_version_2

I am interested in starting the process of accepting these patches as
changes to the KTAP documentation as KTAPv2.

First, a decision that needs to be made is which branch should be used
to accept these changes. Frank has a git repository for KTAPv2.
However, it is my understanding he has retired. As a reviewer of
KUnit, I am happy to take the patches in through the KUnit branch.
Would this work for everyone?

Second, we need to finalize the changes. A current list of proposed
KTAPv2 patches is as follows:

[PATCH v3 0/2] begin KTAP spec v2 process
[PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP specification
[PATCH v3 2/2] ktap_v2: change "version 1" to "version 2" in examples
[KTAP V2 PATCH] ktap_v2: add skip test result
[KTAP V2 PATCH v4] ktap_v2: add test metadata

Note the patch on adding a skip test result has not yet been reviewed.
So please take a look at this change if interested.

As a rule, for any feature of KTAPv1 that is replaced in KTAPv2, it
will stay in the documentation as allowed but deprecated to allow a
smooth transition.

If this process sounds good to people, I will try to get discussions
going on current patches and ask for reviews. My goal is by the end of
the summer, I can apply the approved patches and send them through a
chosen branch (potentially KUnit, as discussed above).

Let me know what you think. Thanks!
-Rae


On Sun, Mar 26, 2023 at 7:25=E2=80=AFPM Frank Rowand <frowand.list@gmail.co=
m> wrote:
>
> In the middle of the thread about a patch to add the skip test result,
> I suggested documenting the process of deprecating the KTAP v1 Specificat=
ion
> method of marking a skipped test:
>
>   https://lore.kernel.org/all/490271eb-1429-2217-6e38-837c6e5e328b@gmail.=
com/T/#u
>
> In a reply to that email I suggested that we ought to have a process to t=
ransition
> the KTAP Specification from v1 to v2, and possibly v3 and future.
>
> This email is meant to be the root of that discussion.
>
> My initial thinking is that there are at least three different types of p=
roject
> and/or community that may have different needs in this area.
>
> Type 1 - project controls both the test output generation and the test ou=
tput
> parsing tool.  Both generation and parsing code are in the same repositor=
y
> and/or synchronized versions are distributed together.
>
> Devicetree unittests are an example of Type 1.  I plan to maintain change=
s
> of test output to KTAP v2 format in coordination with updating the parser
> to process KTAP v2 data.
>
> Type 2 - project controls both the test output generation and the test ou=
tput
> parsing tool.  The test output generation and a parser modifications may =
be
> controlled by the project BUT there are one or more external testing proj=
ects
> that (1) may have their own parsers, and (2) may have a single framework =
that
> tests multiple versions of the tests.
>
> I think that kselftest and kunit tests are probably examples of Type 2.  =
I also
> think that DT unittests will become a Type 2 project as a result of conve=
rting
> to KTAP v2 data.
>
> Type 3 - project may create and maintain some tests, but is primarily a c=
onsumer
> of tests created by other projects.  Type 3 projects typically have a sin=
gle
> framework that is able to execute and process multiple versions of the te=
sts.
>
> The Fuego test project is an example of Type 3.
>
> Maybe adding all of this complexity of different Types in my initial thin=
king
> was silly -- maybe everything in this topic is governed by the more compl=
ex
> Type 3.
>
> My thinking was that the three different Types of project would be impact=
ed
> in different ways by transition plans.  Type 3 would be the most impacted=
,
> so I wanted to be sure that any transition plan especially considered the=
ir
> needs.
>
> There is an important aspect of the KTAP format that might ease the trans=
ition
> from one version to another: All KTAP formatted results begin with a "ver=
sion
> line", so as soon as a parser has processed the first line of a test, it =
can
> apply the appropriate KTAP Specification version to all subsequent lines =
of
> test output.  A parser implementation could choose to process all version=
s,
> could choose to invoke a version specific parser, or some other approach
> all together.
>
> In the "add skip test results" thread, I suggested deprecating the v1
> method of marking a skipped test in v2, with a scheduled removal of
> the v1 method in v3.  But since the KTAP format version is available
> in the very first line of test output, is it necessary to do a slow
> deprecation and removal over two versions?
>
> One argument to doing a two version deprecation/removal process is that
> a parser that is one version older the the test output _might_ be able
> to process the test output without error, but would not be able to take
> advantage of features added in the newer version of the Specification.
>
> My opinion is that a two version deprecation/removal process will slow
> the Specification update process and lead to more versions of the
> Specification over a given time interval.
>
> A one version deprecation/removal process puts more of a burden on Type 3
> projects and external parsers for Type 2 projects to implement parsers
> that can process the newer Specification more quickly and puts a burden
> on test maintainers to delay a move to the newer Specification, or possib=
ly
> pressure to support selection of more than one Specification version form=
at
> for output data.
>
> One additional item...  On the KTAP Specification version 2 process wiki =
page,
> I suggested that it is "desirable for test result parsers that understand=
 the
> KTAP Specification version 2 data also be able to parse version 1 data."
> With the implication "Converting version 1 compliant data to version 2 co=
mpliant
> data should not require a "flag day" switch of test result parsers."  If =
this
> thread discussion results in a different decision, I will update the wiki=
.
>
> Thoughts?
>
> -Frank
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/6d4afb49-3cb9-f176-61a2-5bbaab698644%40gmail.com.

