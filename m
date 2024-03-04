Return-Path: <linux-kselftest+bounces-5851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1C870A1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B256B1F22D21
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991F78B6C;
	Mon,  4 Mar 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNZH1qsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E378B5C
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579360; cv=none; b=KgVWphSVtp3NVVeexxxefosyW4zid4+2P8BmPZ3a9oyltqYFKjDUBHdSEoXGEdi9/h2MqPEsvYwFH5uwRdUULvDAopxvH5A06gUPTs4+42KlnzPX3PSgqumn+aS9O4m8KkPaQgflmFwevjNbx0oOFpshZ3GchdrKRK14Xxm8+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579360; c=relaxed/simple;
	bh=kIYyxnV0Q3hfFaPKlETsc9QdTOBcN/w5dkg0ZaLqCj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d06hKEFyhX10WqM7+2HVritpUCPM5HRujSw1iN7BO9ElTTf47rwGIXS8hFiCFckKHD+5USk844BJyTXaV/fTHgX3oR2SFsZYP5mPUX1lx80/JnDQMb/L/WgnK1vryi3Io3FQdwCi7njtINw0aNjR+RiZnOEYhsXx2eCZwxrpDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNZH1qsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tiOsoLjDyH9qgATuk9KBE0wMThlXEkQhbl+ACqPams=;
	b=GNZH1qsfKJd92mfb/TSGN3YpjBiXcHd+T9vavjt/4IuAxlVJiI05kUk+EAqNoH+CLVW52S
	bm2L6E87cZFdrSN/RLUEDTY7gNgcvQDD2RnpIC4aOBTcuyj2GMVgTfS7veUYtBmFPJjvVY
	eTO3sUU7sd48Qdk06eBP/nCpJHIt+90=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-_EzvU1aPMly3NdZCYSCuug-1; Mon, 04 Mar 2024 14:09:16 -0500
X-MC-Unique: _EzvU1aPMly3NdZCYSCuug-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso8447557276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 11:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579355; x=1710184155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tiOsoLjDyH9qgATuk9KBE0wMThlXEkQhbl+ACqPams=;
        b=jZCN6NHSL0SXLY5q0Ts09SUXZ9gqpTVYEoh5nqYGhT93Ql7b5edJD7NLxdoC/jENR8
         0hj3+uqYZVnpXPhXKCiAZOpppg3x/nHAE0ERqaMdeYKzfkkt+6sB+SBuTt+xijLUcQ6r
         GnMJ65RkXCKg2+6nc+WBuav6AYVaG39iyuGApNpBbs8JsyTwFkhKwBQM7P0dtHZhUIvD
         wagez26F3j+yyz3MxekV/CpKPUVJgZKtNVc8uVRQwdUfP5rRn3Ov4unaRf2ME1L+ZMYn
         DYSPWogP/cgsmgGJjD5T/1v5q1m3QvnNyKuAGlWdn3BVgEV6Xna+7+rSZo/3e//PPfYQ
         mIKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQb6KDNAD7f4J1iN1sRxfnBu3ep+Uwd07zSqED4QI3bH3Vc0A8yIvHN9ZVB1m97GqXx1uonMsHMSOBLi8opnhtG+GeRcDoNhT96aE3KIT
X-Gm-Message-State: AOJu0YybhmHMcRevM94G//0pG6R/868DVRAasoKQbkeWBici4atr0LK7
	17T4LbWDdPy+55N4l22kDxYC7SjZCyNTow7BoVHiSffuwQWdTdKD0HG38XVBlm1LLuKH2VXgjev
	F/KZ05xkm13WCqY7UOHLJ5zOP5EbKMqZKRFEKJuxWF/pEGWchUjpeRWRaaK9GxY/MzotdaYkg+h
	omhnaXEa41umpg6yaPdALmBneKLigwhNwTv6Oh015D
X-Received: by 2002:a25:b204:0:b0:dcf:56c1:5a12 with SMTP id i4-20020a25b204000000b00dcf56c15a12mr7029279ybj.38.1709579355523;
        Mon, 04 Mar 2024 11:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1WcLBSSbX0iebArXcd5CgjCMzw9CJRS+5TVmsdZ4vzbJ9Vng84vACPnWisD9eqfcpWiPGyAnMVIYG0R7e6VQ=
X-Received: by 2002:a25:b204:0:b0:dcf:56c1:5a12 with SMTP id
 i4-20020a25b204000000b00dcf56c15a12mr7029265ybj.38.1709579355051; Mon, 04 Mar
 2024 11:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301073300.287508-1-npache@redhat.com> <d44ada61-8789-444c-9823-fc68704586bd@collabora.com>
In-Reply-To: <d44ada61-8789-444c-9823-fc68704586bd@collabora.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 4 Mar 2024 12:08:49 -0700
Message-ID: <CAA1CXcAKXhv1nM8ULoQame2dQonVp_K-hJ9AGSV2PpURPmwtmQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Dont fail testsuite due to a lack of hugepages
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben@decadent.org.uk, shuah@kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:35=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 3/1/24 12:33 PM, Nico Pache wrote:
> > On systems that have large core counts and large page sizes, but limite=
d
> > memory, the userfaultfd test hugepage requirement is too large.
> >
> > Exiting early due to missing one test's requirements is a rather aggres=
sive
> > strategy, and prevents a lot of other tests from running. Remove the
> > early exit to prevent this.
> Why don't we only skip that particular test which requires huge number of
> pages instead? Thus the behavior of this script would remain same.
Hi Muhammad,

That would not solve the problem-- The issue is not with the
userfaultfd test, but rather this part of the script that tries to
allocate the hugepages. If it doesnt succeed at allocating the right
amount of hugepages it will exit the run_vmtests.sh script, thus
stopping all other tests. With the `exit` removed, the test suite is
able to run, and upon running the userfaultfd test will result in a
failed test case.

If you'd like I can follow up with a patch to skip the test cases (in
the actually test) rather than failing.

Cheers,
-- Nico
>
> >
> > Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages"=
)
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  tools/testing/selftests/mm/run_vmtests.sh | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index 246d53a5d7f28..727ea22ba408e 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> >       if [ "$freepgs" -lt "$needpgs" ]; then
> >               printf "Not enough huge pages available (%d < %d)\n" \
> >                      "$freepgs" "$needpgs"
> > -             exit 1
> >       fi
> >  else
> >       echo "no hugetlbfs support in kernel?"
>
> --
> BR,
> Muhammad Usama Anjum
>


