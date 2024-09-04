Return-Path: <linux-kselftest+bounces-17124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F096BDED
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DA9282C48
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1421DA610;
	Wed,  4 Sep 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A11/46Zl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D01CC8A2
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455214; cv=none; b=AsZQa2QlwsnacZzS60mlxLb1NLl5NySQ8BvkUBpX1kIK6MRRao55HbmLRdy71SagcOeFZhGvlaSQmx2S1PlqKBZ9wSnr7xILO5eP15R3KcXICCgkafs/fhrIyfXeGAwcu7kt/A1O9cKkA5b0pONOMAyj6rSy6rytWjiSrIURAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455214; c=relaxed/simple;
	bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXWxx1tY/N9cbq8efP8OV7kHFz+rIvfDQ5lkHSkuYPtyJSaFsu0QwQcL8zP4D76Ek8Wp/oWHaS5OFn2vC5B+5DSXyBztF7C79BLaum+jqibUFoq0PqxjK41t5WtKUnfwjTtP2TaYGhsxFE4fBJAd6rCIjeLJ/U2SXFt6+CKCXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A11/46Zl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1348555a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725455211; x=1726060011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
        b=A11/46ZlKkz/95mNpA6guHL14Yk6SRP5AAmvBlxSaTKGnKkrfZ/4/ri7pLHqMuSkfN
         9bNgpcivxK4H3USQwN4eqySfP0F1RRNBN5pJwRB4ayrD6Edg7Nwk+mdXv+ayNeyvrAy1
         QPAJUG6NBBzb2aHEnjugsvhLBEhP+5v9AgJUj8sMwGG4DVvDXLyeqDgmjfvzD9ht3oAO
         WC2jzhw2cqnQ4FB9pVzp5MUODwSJ9puqUhlOTl1HFYfgQaLVvQ6no5ETqtCdkUL692F1
         HvA4dKCw7l2EyUNSKw71igkqWFnZ79nQWxJmrHO29Z/dmmDqup9N2wG93yagVeLhStjh
         sUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455211; x=1726060011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
        b=tzx6UJBVYZkrbEMbiT8BvmIHLic49Oh2YRsfAy6lzqMaM8qwLiq/xVLFd7JjxkhhLy
         NI81jX09NXz7f5yFySFANrIhoPpOXTeMNHF/1f87oXA0N8W0yI3IKlPTWf87TByFjX+r
         EYd6/FNJ7+6+CEApBtyRWE44l2okiN9cJVdiXCgAgBFnrBkl1/IPoWJx6Se5gUJzq22p
         KuW4YCCQuEGdXXi+/3BtU1rSP419am8b8QCE9g+GmOecV5NMGzt9azGUu/dMG+DCi7UH
         9xzm+sh/XdiQvSO6Y8uxssHVB/fQGHFNTikjLJ6Qs0BRylqJstYucB6solGDEPyEkMSG
         Sbgw==
X-Forwarded-Encrypted: i=1; AJvYcCXXCZiZtOArebtBNelAv4WrhaOBbASobZNxBTba8ri13L1/O45sSVeO1P65osDNRlrb8p8HQbo0GKHAwsjZkLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKmZrpVGaUQ8BKgMKQQWZP1cRyQDZoVQZKNQdGJuN8r/vTD2S
	9Ua/EXr0+vbnRBbHunsOyzhE0DRuZEeUTCmzTu1fAWK0z1JiT/KAQxowRePqKcA6HFt/XorE65M
	gDmX5RnHqX1HtIDU9a5yO2SSG20D2v5cdQgJr
X-Google-Smtp-Source: AGHT+IHn22ssXGW0yF7W9DrfoEIn7rM9xJ97Zc9egCpo1ER3mrV/IPOElhJVd80kL2WB7ZM5FZIBkfoGxF6mwE/00eQ=
X-Received: by 2002:a05:6402:d08:b0:5c2:1803:ac65 with SMTP id
 4fb4d7f45d1cf-5c21ed54d08mr19008148a12.21.1725455210156; Wed, 04 Sep 2024
 06:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
In-Reply-To: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 15:06:35 +0200
Message-ID: <CANn89iLe9vdyOSknQNqhpm4Ehibziq5oBMn_yOJ4cFBHdZjTxA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: enable bind tests
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Joanne Koong <joannelkoong@gmail.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:12=E2=80=AFAM Jamie Bainbridge
<jamie.bainbridge@gmail.com> wrote:
>
> bind_wildcard is compiled but not run, bind_timewait is not compiled.
>
> These two tests complete in a very short time, use the test harness
> properly, and seem reasonable to enable.
>
> The author of the tests confirmed via email that these were
> intended to be run.
>
> Enable these two tests.
>
> Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
> Fixes: 2c042e8e54ef ("tcp: Add selftest for bind() and TIME_WAIT.")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

