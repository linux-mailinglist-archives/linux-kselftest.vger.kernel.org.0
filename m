Return-Path: <linux-kselftest+bounces-5617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B086C4EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597CE1F22417
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983ED59B77;
	Thu, 29 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlHri6tL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9359B71;
	Thu, 29 Feb 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198608; cv=none; b=ddwcrNHwq/sl0FXTKssPTd+Z4+aTHJjayrHbpnZ368P/jT+zGO+4DIVSZhA/1GJG2Ob1fg88ZG0NgSsbJu80NbjXFTY2j+kF2tNrw+8sx9wu57tauILOPerenQMiy3gFpUTzYaje4NbBsqWtyudaGjnEJmPN+ZlAwEI1yqyjSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198608; c=relaxed/simple;
	bh=Y1VF961paWGjYTepm54lGjEBp1wEbEGeWrtYpW1U5Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtRZcHe5JFxRe0Q9mMX4g/VN2uqaOFhPUSfr7BH1+7GhQlApprBJEZ+Vgs0KxdH7fdak7IwVs2fLxMbmxuoPYIuThLEvZtQfTHUfwPColv645QSSqKjVfftpAbWW/GIEYBjf4ovwXD930En9c5YKeH86nREp1+vOPs6eTp7CXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlHri6tL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bd533be0so722709e87.0;
        Thu, 29 Feb 2024 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709198605; x=1709803405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N07RhVVTSDQOyo4eDr4hHwQOWKc0jlT5jQWzrwVgOx4=;
        b=AlHri6tL+p+KMvMDOV07W/RELblZUakyMAoNzcjF/tdLk+R44ySamD0O8SDP+W+gwg
         in+smscr7IN3f8VkY3490PxgFPiV1N9CqOXaqnaKDcfS8W+2pn1+z7fs8Ss5wpPLg0tN
         0odJt4BBkCcMiVU20nRhxj5PbZhudhqwDvMVmLIqcRGKvM89J+vvFXjlq1YLxiK05kHp
         zQx0SFGFw9UvN+B78lOK4yoSO4if5f4Hjz8YBbaX/jkmVatlm2l4ryhQJGt9OxRE2ik6
         joX+MN5ZeVwbO20o1qDRNBPEnLdX8JiSgRlZzA+ucFGKS8kI73iPSRMWArmuxLy+dSCl
         NeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198605; x=1709803405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N07RhVVTSDQOyo4eDr4hHwQOWKc0jlT5jQWzrwVgOx4=;
        b=DqKggTmxQZoWqUeDqbopnWdgdRwweQuS5mf06/bEY1WmVkufrTqzIYHgLtg4OVQmji
         +aFDrDINufb2x5RtFbYSx4u45Ge4SvcLvv1ENfF5NKyExIyElAdVNEKL/ADjDVrFRINU
         gC/wetYCLPEMMVTFYsVJX/N4MB9kpsM1SjgPEO/6A6nBMJtNDfdcU4b0MYm+2j25ATtG
         GPfI4Ykx7rmyUQPaMtZGhwi+sL+uMMP+P9VVe8GIckgbr9onQXwuYFPZGEmQysofAB3o
         1UmuckB0yEYaJrpKQquFMf9J5xMnfu8+Jl9MCjJWdydcKfruOib3yLdrnwbtnJiO50Pu
         j9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXSLZ+IDsjw2kmbVwjINZmAU4VjH0kDLAQYysN3e7XTVvCsw13sVl/VH6Fa9qM8ebobPpgXLVTrszt06uvP61vjpDBKm1kSAtbbFsgCu3/H/hpwAV00Xeww2FJlapbDW9MpY8b/ICTiIFxS+z/G0JFRLO8D61s+XPpkJ1kQpq+agiYHdcKfLH23
X-Gm-Message-State: AOJu0YzR4b0pYGWUOv0JIJ3J92LUPPyQa7rbb1ZoVv5ASUMWMAQJuFpE
	WpH24yfWxJBGTOXI3SuK8a7nvNLpt4WbZPeMNBZCvDsT6YS1SVNT
X-Google-Smtp-Source: AGHT+IH0NneLS2naHPyQSuK2V6PBB0Kthv4bW9sQwfbLO1EV2s0XyuAxODvSdoZ8N7aM5gfpHsgNCA==
X-Received: by 2002:a05:6512:2147:b0:513:2016:47d5 with SMTP id s7-20020a056512214700b00513201647d5mr927401lfr.56.1709198604426;
        Thu, 29 Feb 2024 01:23:24 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f49000000b00513246fe458sm181985lfz.266.2024.02.29.01.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:23:24 -0800 (PST)
Message-ID: <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
Date: Thu, 29 Feb 2024 11:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>,
 Helen Koike <helen.koike@collabora.com>
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20240229-dancing-laughing-groundhog-d85161@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

On 2/29/24 11:02, Maxime Ripard wrote:
> On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
>> Which rating would you select?
> 
> 4.5 :)
> 
> One thing I'm wondering here is how we're going to cope with the
> different requirements each user / framework has.
> 
> Like, Linus probably want to have a different set of CI before merging a
> PR than (say) linux-next does, or stable, or before doing an actual
> release.
> 
> Similarly, DRM probably has a different set of requirements than
> drm-misc, drm-amd or nouveau.
> 
> I don't see how the current architecture could accomodate for that. I
> know that Gitlab allows to store issues template in a separate repo,
> maybe we could ask them to provide a feature where the actions would be
> separate from the main repo? That way, any gitlab project could provide
> its own set of tests, without conflicting with each others (and we could
> still share them if we wanted to)
> 
> I know some of use had good relationship with Gitlab, so maybe it would
> be worth asking?

GitLab already supports getting the CI YAML from other repos. You can change 
that in the repo settings.

However, I think a better approach would be *not* to add the .gitlab-ci.yaml 
file in the root of the source tree, but instead change the very same repo 
setting to point to a particular entry YAML, *inside* the repo (somewhere 
under "ci" directory) instead.

This way all the different subtrees can have completely different setup, but 
some could still use Helen's work and employ the "scenarios" she implemented.

Nick

