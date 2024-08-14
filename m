Return-Path: <linux-kselftest+bounces-15339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9895208F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786FBB2334E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74C1BA89F;
	Wed, 14 Aug 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnrvC043"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7B1BA89A
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654643; cv=none; b=qHYTAEdrbDd8FXT80/L5880yXquoWVibktjhWGG/iPT80mnW2572gFJv7OoT7wmxlJO52881qajVXk2TwPUigsF1UC6czIMD5UlYuORc/hjKYvMfGFngk5w2QZc7xQ7BpXszvrYJDILk82LOK/n4am1qsGYcDpgJD+lsEjIBWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654643; c=relaxed/simple;
	bh=ZKpdMlwy1Vuuc8abJVg8YoHUbcl+6GvtZq48vUrGLY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lnC1fBeHpMjQVRj2Cb3AvE+pRvAFlaqAXaOCul12nSRSY0TpvouuelsALETIzkuan4pQrpXMLDFZmbxgTih+oFcU4ErdI3+YncQT4PE6T1orRYVwU2r4waIO06XZwKKHZET0abcF8mbVByH9HKIp5kQG2GaX9OUNWu0wlqixoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fnrvC043; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f23f22so75962eaf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723654641; x=1724259441; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3V7sI5wa59RYo+sZ7xurVHGqINhPxAhasnZ5W2BayU=;
        b=fnrvC0432wJJexqO+555N8ww1qFWm9nFbI1szZyw4ev+x4vkFE0q2l37yrM/ohaa7m
         AAbV5SOEXiYz4UHtb3zj3S9vWGbRhe3/mCdBBjnI1iz4hahFKTMNlc0t68DXFUpAcjmU
         XonN6AfAI0RP8MQQy6KPd3GKPmLYVhDU8S7kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654641; x=1724259441;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3V7sI5wa59RYo+sZ7xurVHGqINhPxAhasnZ5W2BayU=;
        b=PBKBL2OzFVFRSaFixa46AuWM2Zph5YtPUhomkIXXlEYYExwF/O9jsAbkq+ZZsLdbb0
         EPjs02lJ0KUD1qQ6YmTlPotvcmV5DsHYuB29eCfGoVKNvIJQsqmuZZyd56uQ99LnvBIo
         EU90aZDLp4VnrxYfGc5q1cetub8SYYk36X2aYwswODaWn3htQaYa0e5JIALd4374FXFK
         kgjETgljyUzP5g9vtiNjMbCFmaOSEEJ9geWumPI4LQwGiWf5Sk28vBQdJWLzCOpviviQ
         646GMoJ0HQ9Xe+fPhO5c0UjTQeXLL+RXT18dFTNHWPrk67aibtzjYg+TONs8ce4USa1c
         C/hg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+M24s0XZsPwqLCylMAmx6wLTtKv1QDauxcMY/4UngokJhw46WRvBxwDefYotVV4Gy33L6fBtAsU5PIeJJ8NTfXWIB9i1B/9gVPZagjvo
X-Gm-Message-State: AOJu0Ywu4S+r7nMS2M7QRYoAqHfWXl0Ce0fOYlx0Mub1yYRlm3rXJOW2
	lzhdH+2ayKjH97xaJl+rajTh4ELqxFt8NRNMFk8g3ht8qlRNrl/g0D3Zy+a7NDhz/1sAIQDEA3E
	g1UHEcw+6fqWMv9udjj51dXp0i+eMvX+K/qy9
X-Google-Smtp-Source: AGHT+IFrRfkhR2XduT5ByCnGofWNAIRptASixgPkXKhJgovUeEbG9xWDO8oNJsdQPuXoITtCyftAROEZJLTwNudxnuI=
X-Received: by 2002:a05:6870:5b88:b0:260:ed20:dcb3 with SMTP id
 586e51a60fabf-26fe5aea2camr4053360fac.30.1723654640802; Wed, 14 Aug 2024
 09:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
In-Reply-To: <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 14 Aug 2024 09:57:09 -0700
Message-ID: <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	willy@infradead.org, torvalds@linux-foundation.org, pedro.falcato@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:40=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [240814 03:14]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > refactor the code to check src address range before doing anything on
> > the destination, i.e. destination won't be unmapped, if src address
> > failed the boundaries check.
> >
> > This also allows us to remove can_modify_mm from mremap.c, since
> > the src address must be single VMA, can_modify_vma is used.
>
> I don't think sending out a separate patch to address the same thing as
> the patch you said you were testing [1] is the correct approach.  You
> had already sent suggestions on mremap changes - why send this patch set
> instead of making another suggestion?
>
As indicated in the cover letter, this patch aims to improve mremap
performance while preserving existing mseal's semantics. And this
patch can go in-dependantly regardless of in-loop out-loop discussion.

[1] link in your email is broken, but I assume you meant Pedro's V1/V2
of in-loop change. In-loop change has a semantic/regression risk to
mseal, and will take longer time to review/test/prove and bake.

We can leave in-loop discussion in Pedro's thread, I hope the V3 of
Pedro's patch adds more testing coverage and addresses existing
comments in V2.

Thanks
-Jeff

-Jeff

