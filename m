Return-Path: <linux-kselftest+bounces-9296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E638BA36E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3779B2111D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A71BC2F;
	Thu,  2 May 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZ7tGXWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC81B810
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689926; cv=none; b=T8k60YGHMNsgmzlt81/CkJ+1uwz/g1Qf3RCLjD98lIhULK6mXHvSnpAE+xarKvx5LU3vEOQC404qA/r906+MQAN4l2BW4cG/uQ5dMbCh6zI4WuGiiK3dXW8j6wPFDTxukQDmZ+zwK34mk0+yK9+REfeYEXS33m1swy4blf87sUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689926; c=relaxed/simple;
	bh=I3uuLxNzOCssz8m+55xA6cGRFEwNKBKZs5w/RJydG7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FjaC9oOtYul4uvsPFVmhP0KAs0xOv2VIxezzJ1zW4NkE4BpgMWNzGuyhtQOvwnDApij2qhYj8wetrfDXuozLC/Uc6aQ5KEklXDBpkWWu1XgU7ZWqt0DrWXFIzAyXtZzT6A2Mm9xawmH4brTyQnJ9bemrmlIPxXTd1X3pown1Oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZ7tGXWg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bbd6578f9so100343247b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714689924; x=1715294724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng8wdniletCwnFQX4IxNkyDUgPARM59dfJ0NnGdDa/E=;
        b=mZ7tGXWg2jZXu408aU7lE3xcxXutK/7tP//AXPMwln79e9Uh/Q1sBWEoUE7ge2WboF
         zH7f3QtnQc8jfOVVwpkLFtnWxNN/b0yrc+B5fPjA6FQ8Z2t8FC/mikfHTxbmPCEjHSlw
         qNzdvEmTYI2Zu5KVVUxrg7HbKdrg1jDDyv90eVAtCKl3WMJ0rc4WlOL6+QiWsUPd0XZx
         I1QxR3n/27jZqlHOVCkXqt3iTagjdJmmbKCymY4aYx3Z9Ky66yrPGVu5gPZ54Rp+OASR
         +Udv2+2oAcBBXqiV54G2UuQYND0PrrNQvs4i0DTejSXxOFap9d9iZIDj5Y1EVvwwQUi7
         +a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689924; x=1715294724;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ng8wdniletCwnFQX4IxNkyDUgPARM59dfJ0NnGdDa/E=;
        b=DHFDd4cOTcfvPi4Pth6bNYu6RFFEd4e1NAzGPZrtjUEdnsXUime2kZCxlcdm4VYpwp
         /apXp1JabzIzbDVATvThV1NrVKT470cfA1bj8cekPN+lVcJFcQbOuaQbsuNNtzyxvmo7
         VE+uf9boo8kgFJ4oPZfhh7Rhk4tr0k5yKmF4KFfI96+dVfQ6Sxjo+K6RVMTnKturQcej
         pyc2BkW2dOXHWtxZXlpaJIJvUyr2DYOVviE+NJXmY6gge3zUJF1uBOBONLuaaSeve0M0
         nxLZn6h0PhywlAvldjHahD6OHOhkDNbGjm2/NKZeKnNoIKL77cUU7EBxWc7Ds+H16ATp
         TJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCViVPRUTpQhIxX2Teecx6kK7ITnOsegg4wreGjkBPJppK/30w5TrK2iltMGZeKUlFBqsrs4hINzX3F8KxkpsqTDUke/vtd/8cyAQtNg6AKu
X-Gm-Message-State: AOJu0YxyzkYcmID63CboTogn1GmlG9LtwMZOGms8LLVlTCt2Q7MEJ1Rw
	POHHsNF9oeHqkhhPlUwBm4h4mb0whom/LeJ4nmPMCuVNtzwze8lBnhoAnBCfn7Wq4PaepKgoZ3W
	nog==
X-Google-Smtp-Source: AGHT+IHSaclY4T7RoFl8xX5G9CqldxXXjOMPdHJpuQAdr0cFPX+iMLHEEOj88Q1SBORTFHpk2Agd2Mml/kE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154f:b0:dc6:cd85:bcd7 with SMTP id
 r15-20020a056902154f00b00dc6cd85bcd7mr359179ybu.3.1714689923750; Thu, 02 May
 2024 15:45:23 -0700 (PDT)
Date: Thu, 2 May 2024 15:45:22 -0700
In-Reply-To: <20240502210926.145539-11-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502210926.145539-1-mic@digikod.net> <20240502210926.145539-11-mic@digikod.net>
Message-ID: <ZjQXghB6imRFU4HX@google.com>
Subject: Re: [PATCH v4 10/10] selftests/harness: Fix TEST_F()'s exit codes
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> @@ -462,8 +462,10 @@ static inline pid_t clone3_vfork(void)
>  		munmap(teardown, sizeof(*teardown)); \
>  		if (self && fixture_name##_teardown_parent) \
>  			munmap(self, sizeof(*self)); \
> -		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
> -			/* Forward signal to __wait_for_test(). */ \
> +		/* Forward exit codes and signals to __wait_for_test(). */ \
> +		if (WIFEXITED(status)) \
> +			_exit(_metadata->exit_code); \

This needs to be:

		if (WIFEXITED(status)) \
			_exit(WEXITSTATUS(status)); \

otherwise existing tests that communicate FAIL/SKIP via exit() continue to =
yield
exit(0) and thus false passes.

If that conflicts with tests that want to communicate via _metadata->exit_c=
ode,
then maybe this?

		if (WIFEXITED(status)) \
			_exit(WEXITSTATUS(status) ?: _metadata->exit_code); \

Or I suppose _metadata->exit_code could have priority, but that seems weird=
 to
me, e.g. if a test sets exit_code and then explodes, it seems like the expl=
osion
should be reported.

> +		if (WIFSIGNALED(status)) \
>  			kill(getpid(), WTERMSIG(status)); \
>  		__test_check_assert(_metadata); \
>  	} \
> --=20
> 2.45.0
>=20

