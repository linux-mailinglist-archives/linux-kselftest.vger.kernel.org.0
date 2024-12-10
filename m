Return-Path: <linux-kselftest+bounces-23104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDB9EB351
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 15:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742F3162480
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F391AA1D0;
	Tue, 10 Dec 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FA27LtW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF71A704C
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841047; cv=none; b=M4O1WgQ5hopHKS744Xnir9w1d3Vmqv/p42PPUwGqF0SzC3H4nnWMIWH6YUFqqhf41Ef+/JQw8DHaP/wzPw0NtFHX6g0svC4A4V8na4W6rW4bg0+QEcRdZkAMyggb0KHMGn4ebfrZBmtSYLRrOOh6HguBKhoasPXQePz7fbie+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841047; c=relaxed/simple;
	bh=TmKNCI5crBsnuoKu79pQm5kUHEY7ldggI2M+CYfFJUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF0q1gQ6RrFlR1z84OwpLSCg5Jz8GtGxxNdqcBdXh0UBMDo5PJxvkEMU7sTLbhB4JUHhCH90VD1tAFn4OpnfWOyLuoQsj7AjGxbOkUBj/jGUF/O/DMe2+HYg0CJvk/IK5S6PIpHCVwfauGnVGVIiQQ2sVC3tltqW6E752dEbvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FA27LtW7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2398853f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733841042; x=1734445842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/cm+nrSG+5II0qAA1CApN1Olr5UrAZOBnUEX4G2C9k=;
        b=FA27LtW7gseJNuwxkZexH0iL6PR5Q3/Cy8LYRD0oSYV2n2+HzUof/akhPd4/zzlocB
         iKaMQ8mrKNjo1bVsZNupePBGJjANG4u3Pu8wrSawNqcRLJK9gDmGqXC7u2Zwr0TMQaC5
         9N6bKGifjn2LAileq/bRtm3lMm5+7KmGVqqSGkU6UPjsR4zfoE5X22RtP+UeDL+lwcGn
         rnayHhRoWeLjaL+LzFxOSAa48EqHrEyhcd4FA/BYbwQeG4G03fU31qLBjJsr9sivcRyo
         9Vpn922atDVpAjANISb0fvsePwRbOebtzgWZmQyqgUCrl8irnKijX3q9SfvuaUvUgojS
         DdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841042; x=1734445842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/cm+nrSG+5II0qAA1CApN1Olr5UrAZOBnUEX4G2C9k=;
        b=J2fBNNYvgjQYZws0s27jmDY+u3iysXwI36pxJ8Nl9oinIuQF/Sgj7X4uxGYKbECJWN
         M5pFT1JVOYErkQlIxgAyKghw6NaKmW6IwCiWpOlFU5lX/PJ30OGxzMa+zlWQ8i45aGtQ
         dY3FxMrmvjA9mN1OiXr9gVtD+TglgObHSIKRxYdsDALsEykPtr/rxsz9Y44V506bDi8b
         eKNFQ2sjMYhXCpFi5ib3QD43Zj5z3lSSJpE4XWO2IbKxoPzguIJIrgjWxUUlxOA5IpRM
         Sscg6FsSv/nrSTN1ggHv11PW5HakNunIiz2rLapMepf3w8nHZ0m2tytXtKUl2FVOhpbX
         uTug==
X-Forwarded-Encrypted: i=1; AJvYcCVP6uEUeAkW2LxkEWyDt7z3lOFQlXQYfcrQ4X4dU56EkkijWNZfKjS5HX8dxk4vhocHhC1DqAtsVYFCZLafRyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1IcDfjlY5qtHqYw9bwEUYtBHISplnEISPNeCr3R4A5kF2QTc
	GX7i1UNEfJHQCB78ZSyJrx/n0h8XPBPuNUxLUE/Bz+kEjIWNhk+2IOkh+0IewTY=
X-Gm-Gg: ASbGncuPV0ndU7cza1zqZcY0Tbkk2bsRL++5lN/7CvZmKNnprIQDFijvmXrZXq5IydN
	xif505RSB4LNj739RWb2A/I6k1S8bzswVl5eZ0bSS7FDtRIYGuMFD9gHo4q8fILuYNhjlZSXhQO
	J3VENrxF+MbgQbe/q9+UE6xIyw3XUVQjJ/b0A67XscPHxQML+jYr15TF+99FDjSNXkRtQAB82oS
	yMqrIPDIKDGL48Z1rLYWE/NhkeRkCwbMlqBJjWpfYRvEbKgjCUM/5I=
X-Google-Smtp-Source: AGHT+IEJUtTpPMf6G7jAGMibFprqv06Na9zpQvm8dtsXFCJXR4j5vR2w2ykd5ZBdmLcAr/Bwz0G0XQ==
X-Received: by 2002:a5d:47c9:0:b0:386:3328:6106 with SMTP id ffacd0b85a97d-386453e5101mr3654337f8f.35.1733841042098;
        Tue, 10 Dec 2024 06:30:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216688a6d8dsm21735495ad.163.2024.12.10.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:30:41 -0800 (PST)
Date: Tue, 10 Dec 2024 15:30:33 +0100
From: Petr Mladek <pmladek@suse.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, corbet@lwn.net, mbenes@suse.cz,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] docs/kselftests: Explain the usage of
 TEST_CONFIG_DEPS
Message-ID: <Z1hQiQM5FbSVpiEy@pathway.suse.cz>
References: <20241205114757.5916-1-simeddon@gmail.com>
 <20241205114757.5916-2-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205114757.5916-2-simeddon@gmail.com>

On Thu 2024-12-05 17:17:55, Siddharth Menon wrote:
> Update documentation to explain the TEST_CONFIG_DEPS flag in lib.mk.
> TEST_CONFIG_DEPS is used to validate the presence of required config flags
> specified in the selftest makefile before compiling or running a test.
> 
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  Documentation/dev-tools/kselftest.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index fdb1df86783a..e816b282363f 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -301,6 +301,9 @@ Contributing new tests (details)
>  
>     e.g: tools/testing/selftests/android/config
>  
> + * Use TEST_CONFIG_DEPS to specify required config options to be enabled 
> +   before a test is allowed to run or compile.
> +
>   * Create a .gitignore file inside test directory and add all generated objects
>     in it.

It might be a matter of taste. It is a chicken & egg problem. I
personally find it weird to document something which does not exist yet.

Please, either update the documentation together with the code or
later :-)

Best Regards,
Petr

PS: I haven't got this mail. I have got only 2nd and 3rd patch.
    I prefer to see the entire patchset. I suggest to always
    send all patches to the same list of people and mailing lists.
    

