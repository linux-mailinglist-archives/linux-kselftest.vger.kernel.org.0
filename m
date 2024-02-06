Return-Path: <linux-kselftest+bounces-4173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0884AD4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DE4B23BB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9D74E01;
	Tue,  6 Feb 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+FMcmKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08473199
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192831; cv=none; b=Xy0yvW3BFgVj1p4dVVNrEAgc2XI4hxsVkS1nqY5Z5wqaaWb9m+cpeObXjJw42qHNs9ViUyiCugzHM4nX5n/x3z0/k6UObYuqPI6XXrJFamb72fJtoKFtZ90CZ/1mSufGebfAvAwFGojhPKrFhNqeepngDMHvKYJqmMtE/9Fys0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192831; c=relaxed/simple;
	bh=EYpWYhMOaFrNlOzVvjkYESVcffXmMcKcNtjN3dNEo0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNviggr+gjHnmHPXssT5PnW6BdWZ2yq6w+O2qMSwYAXi9MFolYadywTTKiJOSirIC+GTIaSgBpxg7NB/OUTOpSaGktMI6yAY2LtQHOvehiGCl8KqhHEQDioVzei+wGorgMaIqcQXndrleUnY7YzbsfimzJxjvPFSu7dG66+NbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+FMcmKA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a7765511bso121831cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 20:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707192829; x=1707797629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWjlypBtyTUxplHTk3D9RBXwXO2gt9OAC5LJGVHbulw=;
        b=Z+FMcmKAZez4UGqd+3LWG/oc5h8SXRagDchpyQTILn7EWat1ErsNZPHp2wB95PSxFH
         hvc1KjXUGhgsX1F+tZqh2TMhKYJQWeajWTVurjApCgkFR3WxFwXp58HuLOVlMdvMbesA
         SKvMyD0qBj2OpZ+IxXzA/ZR2YX9ALZK8JIWtFsNHK0DAfsorSlYge0fziTJIhY00W/cX
         0WdafjJcSoc86BfCWNMJpmCMGv6mQ/6WylI+t/RGGyl9OwbKJ6ecKaeGTewDxfhOzOPI
         zhnR6i7Tn7HcNtKhHA0ompZMoKLuiSGz7pFvaEEjj/t0OF03oxq5i+J/ZMovLk3JfxH7
         sCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192829; x=1707797629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWjlypBtyTUxplHTk3D9RBXwXO2gt9OAC5LJGVHbulw=;
        b=hRiWoeH8ttYpjQhBVsGeuQ5SIhJxT2yZnLj5c0xkGncAvrxUBsp1R0mq9MIQBcpLNW
         z2WOGhox3WYXVxqxnz9PkqEOuRTn3GY4IpoYknaZBNbFd2OZRNh/35/Yh9mJheIgccIw
         ckzvjXyTJ3dq7456XnRySV995aGGgFtfGrbO1VHTC77mDFyLuLpniyMIvS/dZhArpnTo
         kftM97795EDfj33Wndt9TKmfgZzGu6pJxP3xHpwJa8eb0sXIcpK324J/HOxC9akA4z+m
         96KN0v8iJYKl8bPaEX1Ud/BgZfGZsHsLbqBhgG/HsT4CyvqbA0VlyEm0s1S66DHjkIqG
         Yccg==
X-Gm-Message-State: AOJu0YwDFjCYCRB0jAm694hyoAEruFiqu4X2hx7CBzPNYI91V1VzP5vd
	Qq8/gF3PlHLUC+V38UVvQBpprOHSI3uFHkeuCvVN8jO+xUTm8gKxC05Bv4+NQzvSBe6nkH0tPZa
	dWnfCV4QsmdDbRPj/h6R4mX3AOFat/l1vTr60
X-Google-Smtp-Source: AGHT+IF+zwncKIMpfuhRX8d3KjdNcOIMUCb5EKpDL39rd4uTlyenwEJDN39KRailL3Phrr64u3gyORCgl9FVKUVUGt4=
X-Received: by 2002:ac8:5ac8:0:b0:42c:2d41:5f7d with SMTP id
 d8-20020ac85ac8000000b0042c2d415f7dmr132013qtd.17.1707192828650; Mon, 05 Feb
 2024 20:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126221426.4173112-1-rmoar@google.com> <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
In-Reply-To: <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Mon, 5 Feb 2024 23:13:36 -0500
Message-ID: <CA+GJov5nCLjD1iTUGxQOPMCXjBCci8-VbUje46Qd66szJgGtxQ@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
To: Kees Cook <kees@kernel.org>
Cc: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	Tim.Bird@sony.com, shuah@kernel.org, brendanhiggins@google.com, 
	dlatypov@google.com, tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com, corbet@lwn.net, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:03=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On January 26, 2024 11:14:26 PM GMT+01:00, Rae Moar <rmoar@google.com> wr=
ote:
> > KTAP version 2
> > # ktap_test: main
> > # ktap_arch: uml
> > 1..1
> >     KTAP version 2
> >     # ktap_test: suite_1
> >     # ktap_subsystem: example
> >     # ktap_test_file: lib/test.c
>
> I think it's a mistake to mix "diagnostics" lines with semantic lines. Si=
nce the diagnostic prefix is [# ] (hash space) how about make the test meta=
data lines be [#:] (hash colon). For example:
>
>
>      1..2
>      ok 1 test_1
>      #:ktap_test: test_2
>      #:ktap_speed: very_slow
>      #:custom_is_flaky: true
>      # format-free stuff goes here
>      ok 2 test_2
> ...

Hello!

I really like this idea. The reason I chose the diagnostic line format
was to make it easier for existing parsers to parse the KTAP Metadata
lines. However, if it won't be too much of an issue for current
parsers, I think this idea would be better. So I am happy to change
this in the next version if there are no complaints.

>
> > ok 1 test_suite
> >
> >The changes to the KTAP specification outline the format, location, and
> >different types of metadata.
> >
> >Here is a link to a version of the KUnit parser that is able to parse te=
st
> >metadata lines for KTAP version 2. Note this includes test metadata
> >lines for the main level of KTAP.
> >
> >Link: https://kunit-review.googlesource.com/c/linux/+/5889
> >
> >Signed-off-by: Rae Moar <rmoar@google.com>
> >---
> > Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
> > 1 file changed, 159 insertions(+), 4 deletions(-)
> >
> >diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/=
ktap.rst
> >index ff77f4aaa6ef..4480eaf5bbc3 100644
> >--- a/Documentation/dev-tools/ktap.rst
> >+++ b/Documentation/dev-tools/ktap.rst
> >@@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which =
may be nested: i.e., test
> > can have subtests), each of which can contain both diagnostic data -- e=
.g., log
> > lines -- and a final result. The test structure and results are
> > machine-readable, whereas the diagnostic data is unstructured and is th=
ere to
>
> We even say it's unstructured... :)
>
>
> >+prefix must not include spaces or the characters ":" or "_".
>
> Why not _?

My thought here was that the first "_" character in the KTAP Metadata
line would indicate the separation between the prefix and metadata
type. So the prefix could not contain "_". This makes it easier to
parse. I'm inclined to keep this but also willing to change it if
there is a proposed prefix that contains "_".

Thanks!
-Rae

>
> --
> Kees Cook

