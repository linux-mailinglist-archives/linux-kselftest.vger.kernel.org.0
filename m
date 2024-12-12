Return-Path: <linux-kselftest+bounces-23243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38CA9EE233
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 10:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6DB168E2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279920E334;
	Thu, 12 Dec 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dqYbQMGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7801F4E27
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994130; cv=none; b=dzZdfEen1xhj/bHYrPOZa9VJbPpg7WFpkyinK6PVNuvRxEPvhOCEqxuQw8U1UPThK5iJK1FKJI5UD96Z+BrqM70foj4F1SmHbZ4g+VjhTqfbV4YnYNgy0BnLp0cBXYVQrVWtANG/o+O4aZE15TarDZjxplEy8YXPR4qUO4YVf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994130; c=relaxed/simple;
	bh=9AT90kklPF3U/jVx0p8QNIfkKZDudoPG9mx4JSZDi1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frnq8vJwCzMZc9pX5ujtCUvvp3tlCGnQdqbREE625Wy641GKsYICfL863e9AOmWa4y5s1BWKXv2bOkX6JY1h0yQqeAOcr1Mam/x2auVB6oTSF/9RCzNtmw8fQ/05dgVUzIYY8L2GzaHq22jaknZ+fQ+TEdgUgCe8eA7iKHfnHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dqYbQMGZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6aee68a57so51131866b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733994127; x=1734598927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YX29TL49Dw2MuCUQ5j7U8rKWSDYxRlOCBf9aFWZ7cC0=;
        b=dqYbQMGZ5uZrbLeXa064M49JVAFwQ433zusML+Pqz6MkD3x9gCZ5gsiOJoiwzZKtlP
         UDD5oLa7QqlNILBv8zJn1HCAK8R848h+hNVr3ac5uzYixJKqz63hxbBkQsYJBeAIjo+C
         t95O8+UxIaRU7yPBbGrgtOfk2MhtE8XYP2ZT7SuKSKT76Q0km1B1PsxUfk/Mw6C7e2+a
         kCIt7V9hka+gFA/7MXxPCoaVMLPNTBoXaa64pw+latkxJVnyfOsKbp0cblKuk4Cb34nL
         7bAVXYjGOsn2M8umCVKdCmzQF20jEWHhIB+gk117K+BcAAVtikj3hy4E9OL995ZfYfjH
         QuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733994127; x=1734598927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX29TL49Dw2MuCUQ5j7U8rKWSDYxRlOCBf9aFWZ7cC0=;
        b=XnXI4ij5YCvazMJxL0b2k5An+D3FdjHqqbckiU695IsmLj9UAZ49fu0YBeRY+MAqWT
         LeqvqZE4dm5BIL8x8e+CmDUCDkzQP1bynEWz6awXj1wazhZaOhWZVWmRMU5aPJk+w7Xa
         atvQ87tf4yQbeR4vMpQdlL6F91mhuXm0R5IWqWswfalkOBxYmkZfebwNe84/HKyjtNQo
         xX3qIuNIXSfq8TmYvI8hj08lgzFa9XJ+JA5iTPIyRD1QRimlxuJAjYdfr5jn9enwA3hb
         CeSFebUiTnoh9D33FfGchc6ocQTdkBny3aQhhaqW9BC3psvOO2U/faBf6y/M5aTZ24ng
         JMig==
X-Forwarded-Encrypted: i=1; AJvYcCUGMkZNXgBc9qOjrtcNYvYgH1pL+QXkIN2xFTiYvCRqj8074EkMz/poBDlRjq4G3ka6YY5zUyiqUXgp3qUyv/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhamhM+0WueXpNNVQ6fm/ZhrT1Qnirk4nFwnKMcVf44U2Tby7H
	t47IqyHR+ZeyovGm1frnzVoOCPZqB2eOSxvOIqudiyQYZ7SCOwKAWEhPIAfjy/b2c8iX4nnNMG4
	4
X-Gm-Gg: ASbGncsV04GLjSzA1wLY9S8bVLFa0PoGCoU3pGPz3WGRzwZF0dD7Q0n94qd1VRwA4kg
	r+hU+J/ssAx7t4hD9fMsbJfW6I0cB9rXW6WYrwgjTBDm5hAIifuZjrNsaZVPvmBVOjciEKKeOj6
	vl+69YTepxqaFq9yqOYv7KhB6Hzo4hk/f//IHWcm4uA79FXD/dqly0wOxLHaDmr0xUYswk07MfM
	//oyCJAHSDdEGHLyYWVCD8znNN/29xQi7WxcRJWhd4U3DTUtbgwgXhDjg==
X-Google-Smtp-Source: AGHT+IGqFie4i+0ghIJeQCQTlYcosHNSt8wKFSH+Qs/Y042IQJIwrLcoCKb9ebNwKnrHEjV9nmQDkA==
X-Received: by 2002:a17:906:23e1:b0:aa6:7e6b:4984 with SMTP id a640c23a62f3a-aa6c1ce756amr272309266b.42.1733994126600;
        Thu, 12 Dec 2024 01:02:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692846ac8sm502499666b.168.2024.12.12.01.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:02:06 -0800 (PST)
Date: Thu, 12 Dec 2024 10:02:03 +0100
From: Petr Mladek <pmladek@suse.com>
To: BiscuitBobby <simeddon@gmail.com>
Cc: shuah@kernel.org, mbenes@suse.cz,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
Message-ID: <Z1qmiwXqJ6rvYmYa@pathway.suse.cz>
References: <20241205114757.5916-1-simeddon@gmail.com>
 <20241205114757.5916-3-simeddon@gmail.com>
 <Z1hWqUMmr6pcadqD@pathway.suse.cz>
 <CAGd6pzNUquikRS8pw7D14qXqLixOCQUWqcCcD0C1O6K2TMLeNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd6pzNUquikRS8pw7D14qXqLixOCQUWqcCcD0C1O6K2TMLeNg@mail.gmail.com>

On Tue 2024-12-10 22:40:51, BiscuitBobby wrote:
> On Tue, 10 Dec 2024 at 20:26, Petr Mladek <pmladek@suse.com> wrote:
> >
> > What is the reason to add another set of dependencies, please?
> 
> I had done this because not every test required all the options specified in
> tools/testing/selftests/<test>/config. I thought it would not be desirable to
> prevent these tests from compiling/running.

The biggest problem is that tools/testing/selftests/<test>/config are
not used during build or tests at the moment. It means that they
are not tested and might be outdated.

If we add the dependency then some <test>/config files might need
to get fixed.

I am not sure how many problems it might cause. But it might
be worth the effort.

> > Both CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG are already mentioned in
> > tools/testing/selftests/livepatch/config
>
> This particular test only required CONFIG_LIVEPATCH to compile, but I
> had included CONFIG_DYNAMIC_DEBUG, as Miroslav had expressed
> wanting both of them checked.

I see. The build succeeds even without CONFIG_DYNAMIC_DEBUG.
But it must be enabled on the kernel where the test modules
are loaded. Otherwise, the tests would fail.

Honestly, I think that this is rather an exception. It works
only because all the needed pr_debug() messages are in
the livepatch core code. The test modules do not use pr_debug()
on its own.

I believe that most options in tools/testing/selftests/<test>/config
have to be enabled on both compile and runtime. Otherwise, the test
binaries might not have access to the needed API.

I suggest to keep it simple and require all <test>/config options
at both compile and run time. IMHO, most people build and run
the tests on the same kernel anyway.

Best Regards,
Petr

