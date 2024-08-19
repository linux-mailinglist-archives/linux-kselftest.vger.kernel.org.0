Return-Path: <linux-kselftest+bounces-15700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7A9574AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68051F21DFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F61DC483;
	Mon, 19 Aug 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kyg//etU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB301DC479
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096655; cv=none; b=Eb18lSjC5af5dkuC26Ww4wQal05cWIvNe1tYbzYs+O2L5DKgc/QxU7wsxh6kh7Q2pbzaZmwcf/oNQMhinfyAVKf15YfZ3QCZLoQO1TB3iRmuSd5uhpxDZQoeP5SsNNGohSQHw0KjZ7xKHTDIkcgLfUi6YBTURI1V9a5s9heDwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096655; c=relaxed/simple;
	bh=w83ocErDZIzCw8c8O7vL+g1+VP5ZM2OU81Qz7bqaBRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iugCILvFOhDOBGL7M8EgsMWUlonfe9q0OX9h+rGzVNrmG/OzdYr+qRIHsty6H+AMRgvrGG6KNYskx45ujchyoZX86YSWH41g+pPSAe3fKul9TeX3T1JnKyNmofQcF9hqUJqc1pf2GEvoyhrHzyBBFetIG7pkzQ1L7VLCx0Sg+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kyg//etU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530d0882370so4878421e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724096652; x=1724701452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDiz02fpJ0BHDvVXU18To+N8ajErks/Wn/P49vHS5RA=;
        b=Kyg//etUfl0pXEFI1K5vRdrvtTNHadCSLXJdcUhGYYklIkB3SEOX27TfADQDnjqA31
         2F1OSgLeTj6+o0oP1pQ5/o5ejkhHZn/84gGwE5lVGIMaaBfDGm+UmLV5sl/ThQbcfWBj
         sZtjiWZnsZKFm7wLZo1NjrCmKiSzF5tb9xct9I3jjiEJB1KRT/lJsibZg3ZXEv8ZXGzk
         f3OnplQE7LS2ec0qLtp/7UNc9c+5L6w7tOJYA275+5HBOqi5ax5ECZMA9Gg3GMZw39GM
         W7dK+5JXiyjPIq4Koxt0cFwKdz+HfEYHBrYDpoqLm8TBHrWlj9Zk4NYE0m86/x+gzHUx
         dSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096652; x=1724701452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDiz02fpJ0BHDvVXU18To+N8ajErks/Wn/P49vHS5RA=;
        b=ijBz1eqevYc912QJea3qLypVP4YrpPPdgof0P/Av+iZ5SS/rARKDf8xlxPNLhuqtHJ
         gZD9VTiYw+2VOkYrvd3jpMqIWu/bo7dM40eJotFg9EBGhAj4JAp/uClMGs7SzjJaafBm
         MHybSEVWwwJF0hWrSqpOm7zkgFUfiZhIzvqQZx+jxnIxyI6USWJI6kxC+JoE0VjNk7QB
         /erRlgDqcuqzUQthv/GHG5YlXhU6A9+ErYq/Wjtz6xtJgz2I2+tPtY0y7uihEC6OMCg3
         /ZLwiM3Jxn5z4xEtFmrtbLDSYW5lfK56IXN8j5zqFV9y4FCMQa7xe+nA2oJLkcvFbKdc
         uvbA==
X-Forwarded-Encrypted: i=1; AJvYcCUL1M+fW9mdKlRrCY2nJt0kpCf+fGDOqrbTmdGYqbtONU6Ur8gICwq101bMGXj+0PdednzRws6rrDW5Y54wHuy735Bgz3NiBaTgalHqynNv
X-Gm-Message-State: AOJu0Yx+KLPLw/0gkBhUtlDyqYlQqTk9raSfoqcGPiSZq7nN5A/t+AmZ
	4ev1CXV6ZspNHAKDyKmjm5wcFsUd0BC+D2eJ7n1EYODm3Vj1wRq/46ETy/KnftKXE1GsYBWBF/k
	a4RaqkbkNa9kDcUmvJfwQh6KNtazQoweDv657
X-Google-Smtp-Source: AGHT+IG1BaOgHVZEdvbKaXGctP//pb7CyT3HJWWrHjhhlPOcCZVibicxUbUt9KdvzqmsEwfys0s9oPhOXTmbq0LTH3Q=
X-Received: by 2002:a05:6512:33d5:b0:530:e228:276f with SMTP id
 2adb3069b0e04-5331c6ba93dmr8709338e87.36.1724096652012; Mon, 19 Aug 2024
 12:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Mon, 19 Aug 2024 13:43:59 -0600
Message-ID: <CAMkAt6o1KZH=fTWWOoPf+Z0j12xUYrbqj=Qob4E1LxJBtivo4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] SEV Kernel Selftests
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:23=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> This series primarily introduces SEV-SNP test for the kernel selftest
> framework. It tests boot, ioctl, pre fault, and fallocate in various
> combinations to exercise both positive and negative launch flow paths.
>
> Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
> asserts which enables the use of negative test cases. No functional
> change intended.
> Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
> calls and sets up memory to boot a SNP guest VM
> Patch 3 - Adds SNP to shutdown testing
> Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
> Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
> Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP
>
> The patchset is rebased on top of kvm/queue and and over the
> "KVM: selftests: Add SEV-ES shutdown test" patch.
> https://lore.kernel.org/kvm/20240709182936.146487-1-pgonda@google.com/
>
> v2:
> 1. Add SMT parsing check to populate SNP policy flags
> 2. Extend Peter Gonda's shutdown test to include SNP

Thanks for this.

> 3. Introduce new tests for prefault which include exercising prefault,
>    fallocate, hole-punch in various combinations.
> 4. Decouple ioctl patch reworked to introduce private variants of the
>    the functions that call into the ioctl. Also reordered the patch for
>    it to arrive first so that new APIs are not written right after
>    their introduction.
> 5. General cleanups - adding comments, avoiding local booleans, better
>    error message. Suggestions incorporated from Peter, Tom, and Sean.
>

Tested the entire series

Tested-by: Peter Gonda <pgonda@google.com>

