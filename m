Return-Path: <linux-kselftest+bounces-29463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E0A69AA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 22:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E6C189BEEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5D215F63;
	Wed, 19 Mar 2025 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyKfAYiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8135214A6C
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418720; cv=none; b=VAut7+XKHyJS+eqBbrgyhUgrKbm/JjSFqd07eqFH71I3rq0oL0B5XXoZRachJ7c5HgmBheDuemz483djDAqQfd900ND6uePI7aZd2VnVX8MFPP5oA2s3HOUPx7FxC/G0bh7U79qLTrSzNap29M1rY43XH7CGPVMKzIpcp5SBanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418720; c=relaxed/simple;
	bh=mHzkeamJAVirED9+PA9L2O3y8025Yf73WTQxHmfofNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd2njQjuEoGKotcNTW49u3NW3uvvV6+cRAkEu/0u/YslFBL80O7dmYjwcVjDGnZtDtaYlsF8hZCciD6NI3QWa6qeMNDBxONf6kO0WFCG+PvZOgFqypJJIU8VWKqKrB1bSBHxldrsk4EVSQLdoxNDNbY49pHFcwxm5G8N70/2LN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyKfAYiH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e6c082eac0so763336d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742418718; x=1743023518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzQ6ZEr1gpJCZD9/ARUm6ZtLa29Cm83+ahOdT49JFZM=;
        b=vyKfAYiHIJi3E/xeVEJKI0LrDu6O5be38jHBcKB0O/1LeRKLJmXdwV2rft/7cc0W2i
         GLtR+igTetV/DY50WXqbdLikHgrrKfrujNhXj+Aj7XPAjbYE6JZpE+npn29a1CY4/DMH
         GgzHwFOwnbo0GlgdLdkPVo73AGdFGBRzf5VxC64C3/bdYzl0E4RRBNBPBN4py1MsdUnk
         Q2W3eDcwYtnKIVHspinsw4qrmCc3E/v8dW8WpApqbq3kkDhplGee4ea9FMWNoWBDsDkB
         V966MRSlkR4qMWWRDprA6pvFOlFs1BNkYTdLvjjnfhPXMUDh1UaAZrRH2xA31bpKoozD
         Xdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418718; x=1743023518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzQ6ZEr1gpJCZD9/ARUm6ZtLa29Cm83+ahOdT49JFZM=;
        b=liUR8l7bPHEG5M6k8HpGXIHgv+t7NFuvtU3V8NMDy/7HiteEY6Nu2nLGLhj8p9HaaD
         7Kc6E7L+ZUyO4W0YGcOBOiufxuJUSHXXDxGULJeiDs2Q7YJPahJyt/buHMS4VQV4Cpa/
         xTwk+OZkG1ZAK/sWfnYv+CteXqXnSNpFEbACL30Kh36r2rq5IPOq2ekpMeMOEC9jKp/z
         EkLYO1EnBr/Xa3qxLx3y5HffRuRZd7bvCHUX1+geT3VQ2ylJ24We0gBZgtXva89YPCXi
         IACS0+Zsi5BrLKhYPYdP1gepB5F3zG2MFEi5LvfKlDdcGzigz1OOFfdWs7Pg5UkYPlVx
         u7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrkkrcinLEAqzvVGipMQeRb1JYIPOT2kJvKR7DphTznS3GM85kh4kj6oXZz/T7MT4UxAogVDuaUIY5LogeLT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UG+Yddb5rQHylfh5MN4H0AI3m9PDpVHxg+Hx+QE8oytiKZ7Q
	EvHmPihsq2zg5coPKa/Ej+b2cP4k33wCvHBvSs/qIfdruqL4OL8UXUDFCk4wri+7KD5xhe1k024
	E+cPEs6lQYBM28Rz/DtSXnV3hWXGJEy1d36qW
X-Gm-Gg: ASbGncsY6K0oEcrXgLylCYPKDztRzvu2NDqyjV7xlSJDSLi98BqHtKr/aFxNoJ7oeD+
	6rI38w2jUAMoiLyMIsn5sAUJG0MLlsD6FEEl11h7xjDBbCWWh70jM0LSPWTR6GEp+N7iclvdJqj
	voIDPMr3N6qxRqv7O7oSzvlXtaxIXi3zpwNsapqfNKHrOIYTM5/4vqG+icI8H6
X-Google-Smtp-Source: AGHT+IGI0WFUFXKVZef1WwByRwZlBRHuGM1DviOdU10DZnONCKX8AFIG66ZYTPFgUbjuSNp1mcIIaop8R9piDbAczZ4=
X-Received: by 2002:ad4:5747:0:b0:6e8:86d3:be73 with SMTP id
 6a1803df08f44-6eb3538c672mr10615636d6.37.1742418717612; Wed, 19 Mar 2025
 14:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com> <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
 <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
In-Reply-To: <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 19 Mar 2025 17:11:46 -0400
X-Gm-Features: AQ5f1JrFEqZICWggvDN9nQM3ZFvRMwPJ7oPNjINKbR3le5BHzjL9pyv2-L4Meq0
Message-ID: <CA+GJov4CDitQ0w2CU46rk_zwNxU_Mn1wwGNgn-xx3uA3MwDoRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
To: Brendan Jackman <jackmanb@google.com>
Cc: David Gow <davidgow@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:13=E2=80=AFPM Brendan Jackman <jackmanb@google.c=
om> wrote:
>
> On Fri, 14 Mar 2025 at 06:37, David Gow <davidgow@google.com> wrote:
> >
> > On Fri, 14 Mar 2025 at 03:27, Rae Moar <rmoar@google.com> wrote:
> > >
> > > A bug was identified where the KTAP below caused an infinite loop:
> > >
> > >  TAP version 13
> > >  ok 4 test_case
> > >  1..4
> > >
> > > The infinite loop was caused by the parser not parsing a test plan
> > > if following a test result line.
> > >
> > > Fix this bug by parsing test plan line to avoid the infinite loop.
>
> Hi Rae,
>
> With this change and this input:
>
> https://gist.githubusercontent.com/bjackman/220265699f346e16161c6534b1150=
19b/raw/a2e0e1aa75c0d8ab9814708b028ec78810a0471b/run_vmtests.sh.tap
>
> The infinite loop is gone, but it's still hallucinating a [CRASHED] resul=
t:
>
> [16:07:15] # SUMMARY: PASS=3D17 SKIP=3D0 FAIL=3D1
> [16:07:15] [CRASHED]
> ...
> [16:07:15] Testing complete. Ran 19 tests: passed: 17, failed: 1, crashed=
: 1

Hi! Thanks for the response. This is an interesting problem. Should a
test plan at the bottom cause a crash because no tests were found
after? Again with KTAP, a crash would make sense. I feel this example
demonstrates why there is a need for a general parser that can parse
kselftest output as well as KUnit.  I'll see how difficult it would be
to change the parser to accommodate removing the crash in a new
version. Thanks!

-Rae

