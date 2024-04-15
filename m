Return-Path: <linux-kselftest+bounces-7990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6A8A5643
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08AAB20E38
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51477F08;
	Mon, 15 Apr 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSbHdCYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DD42047;
	Mon, 15 Apr 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194606; cv=none; b=kjaU7+4VK5B421Gqxk+9cU1DwRNzMybdP8RYtza0KvxhA2+c4udhaE6x3k6UuOEumhK77HT9iiIOIajWn0vnvnsYd70COKVXH+RDaaeypwS7y60MJv+akulKkJqRGO+G6nDyIAQ4zhWkWMvDZ45iSF0+ZtRvDokCzbtWhYtEgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194606; c=relaxed/simple;
	bh=/+oTadXQg/wcougv+ZALkoCYykeGX5ekKxZJ0VZOuq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BmTF2M44tbOr1eUz3Vh4wKUMj3PiGuDbXW9ykDpPVKlAMkqBHdvl1pi96gzbIWgLnMicTWtNEFNS+Eb3J+xRNrgohsEMHPrHXGiqqliCHW0FLj06ta1ZOaB+H5+M+G4004a2pkiRXjeWODGCJY4x66lMS++HM9EcN8xag0HKdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSbHdCYO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78edc3e7cd9so120219085a.1;
        Mon, 15 Apr 2024 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194604; x=1713799404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00+WKqcWxRVODtQrBSLLMAMkHkC+vdMV1Sj6f4X1gSU=;
        b=ZSbHdCYOdJyyF9wrkWF9v7lNTTjY6in1YkebGN+3WQZ1UIIzXcIMpiU0wWYvvSeWMq
         vHxWFrVbOP5DVLy1bt3Nbr/cXBE4X4fsp+iD+w5dANRAjK37WJWv5QlZwH9d9bg0QOKz
         IHSJwTh5bDTMUgEWYEZFNxwDbQdEb5mN3by6LAr7G78vfVBRA4sPAH8sTLcIqJGWO4nX
         1Z52G2RLom0IWJcRkvwgRvS5FFD3LR3uDG24cAtYC4NeQv/lJhZnuZd7BTaiFynov6KL
         RXbCRZfuL8VbPte/LV1tsqR6PyDsp2DpA5AdLmtKs3HjAN0hfVh0Xu8P4uVNgBoCwvLQ
         X7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194604; x=1713799404;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00+WKqcWxRVODtQrBSLLMAMkHkC+vdMV1Sj6f4X1gSU=;
        b=Y/PbpKe2S6COBLNSvKfICfDbbjGAFKxt6sFcRAXx2xy47mDW/bIu6f187qFPN9ARsA
         sjiVY3Phg3C1b4a8KUIS3BCEQUS7pNIVWPDGb3IFoec2IytT3m0VZjbvtpEm605MJA2p
         fxHpWf0kJVbHBwg/SVdjfZu7Xw9R3Z+fV+NtObnapXTSmBJjVX1olSYUNANQAKN/EIrT
         EKUNBqeZKUHAw7sC0o8dwqzP4WStBIvSAVliC0L/xQpow1ZSxdN/DRx3l11FvGqrlGQU
         YKrjVS98rf3hSpY4Dae0+KldZSx2vZIoq1KKe4uqjb63TMwp5fVfuhzYr0/WU+FpSFcu
         fbjw==
X-Forwarded-Encrypted: i=1; AJvYcCXBmF84oQ4JEbiNAf7hfUDrOd7cyECDbkry4HISocmdijNfaI42cqQ0eja8jA33eHLoxhF3P96lyJCehh+0Ws8OBa7qKx5xnsUmGc7Zkh9nSU5ttLksB9JvSKIUDgyStw4OjwqTDl4w
X-Gm-Message-State: AOJu0Yws9Iiyo5ZZMGbVu2FkCwDfMaNXegJr0/08ma5fzCcjJmMTwuGJ
	WDCAX1BmUHvvTL6T2YZazeu0E8w73BRiWowPB0qRziX9VzY6ykDj5aDRnw==
X-Google-Smtp-Source: AGHT+IHwieKmMqQzpF0d5qwkxZiJ0yZ1tr6e0f2uoDSlK/bp5Ah8N9HxZ7fDo8gtqGR4ClhHrdJQ7Q==
X-Received: by 2002:a05:620a:2119:b0:78d:7588:c19b with SMTP id l25-20020a05620a211900b0078d7588c19bmr11290215qkl.40.1713194603992;
        Mon, 15 Apr 2024 08:23:23 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a439300b0078d6ef5fd07sm6398565qkp.50.2024.04.15.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:23:23 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:23:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com
Message-ID: <661d466b7c11b_1073d29442@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240415071639.03c9cfd6@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
 <20240412233705.1066444-2-kuba@kernel.org>
 <661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
 <20240415071639.03c9cfd6@kernel.org>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 14 Apr 2024 13:04:46 -0400 Willem de Bruijn wrote:
> > 1. Cleaning up remote state in all conditions, including timeout/kill.
> > 
> >    Some tests require a setup phase before the test, and a matching
> >    cleanup phase. If any of the configured state is variable (even
> >    just a randomized filepath) this needs to be communicated to the
> >    cleanup phase. The remote filepath is handled well here. But if
> >    a test needs per-test setup? Say, change MTU or an Ethtool feature.
> >    Multiple related tests may want to share a setup/cleanup.
> > 
> >    Related: some tests may need benefit from a lightweight stateless
> >    check phase to detect preconditions before committing to any setup.
> >    Again, say an Ethtool feature like rx-gro-hw, or AF_XDP metadata rx.
> 
> I think this falls into the "frameworking debate" we were having with
> Petr. The consensus seems to be to keep things as simple as possible.

Makes sense. We can find the sticking points as we go along.

tools/testing/selftests/net already has a couple of hardware feature
tests, that probably see little use now that they require manual
testing (csum, gro, toeplitz, ..). Really excited to include them in
this infra to hopefully see more regular testing across more hardware.

> If we see that tests are poorly written and would benefit from extra
> structure we should try impose some, but every local custom is
> something people will have to learn.

The above were just observations from embedding tests like those
mentioned in our internal custom test framework. Especially with
heterogenous hardware, a lot of it is "can we run this test on this
platform", or "disable this feature as it interacts with the tested
feature" (e.g., HW-GRO and csum.c).

> timeout/kill is provided to us already by the kselftest harness.
> 
> > 2. Synchronizing peers. Often both peers need to be started at the
> >    same time, but then the client may need to wait until the server
> >    is listening. Paolo added a nice local script to detect a listening
> >    socket with sockstat. Less of a problem with TCP tests than UDP or
> >    raw packet tests.
> 
> Yes, definitely. We should probably add that with the first test that
> needs it.



