Return-Path: <linux-kselftest+bounces-5262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DF85F13A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 07:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E361C2251C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5015AF6;
	Thu, 22 Feb 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DxLgGjNg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717E1C14
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581613; cv=none; b=dJnKCU7z6TiNuhCXRndJFWMIogqkn3vXD/1pZFgG1dR+K6vF7e3HmAZHH92DHITc7NEp6JTQB7MRVUpaoqIW9kJ7vkoTHg78GM8m199XvtN70dPzXJllncK5VoGLYVUuK2kdhU/U+WZRKN52uzCWq5NGgh0Hfg4u3pxXyG9yGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581613; c=relaxed/simple;
	bh=jfydpiinpYlW5lz/CxxcHMi0x0ZILrRNe4+Fx00kgU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0ThecmTclqD9ogTpZdElvSU2rs/RbfJCr+3qtR0JtQ9HRwo5lXPBsEQINZkxIwH0iXHcXwfU97zKWctXRu2MOaDXUumm5pO2ZKLaauzYsWbStI5X5iP+jlEV0B1vhb4w6ZGisy2nF9lRNDTqWEmF9i9QsC/zp50GJu+xCXLSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DxLgGjNg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso603184e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708581609; x=1709186409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=DxLgGjNgez8oxjwtcWaW0FjseG5krDVXuGyKU+t8vjdKbVEHBkEHhIXIhYME5fm7q0
         pLD7u0DkmYWV7beYRUUz6ikvN6bQO5gpUCl3Zyt9sF/QLR5UagiR+/9itQHman3UQnHP
         ABY9Q7boT2pMHHg1/JprYzt2jx1co2eBzOBho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581609; x=1709186409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=qLf4wYQvOMH/+qxD4NLuofI4x9Q0UlB0DKPru74QgQc+66cNVdp+Vd1MPNoK5UZjj7
         V2cTHXe65o0btPpt5NtS8NwSiTQXdzKjX1iDYuRcc/CLJacRcGM8rO61VHpbl1FhXuja
         8j14Ma/HLJXf5Xi+fzFi8ZmBv0cxbp/z+SbdhQYhZNcSZkkZ00nlVukQp5xZSMv349rS
         vrTbW4eKA9EAwV/tJPd+6x6VPKHygDFyZsswxrKZb+1APmJ1DioY5upA/OeXS7P4RrK+
         FfVPch4hZiR/LUeux+okmq+gr6HF4HAl7bXRIpQYb0UTruJHbqX0Ezqz7JpsWl8Hpz08
         /RLA==
X-Forwarded-Encrypted: i=1; AJvYcCUGfpzfFKqGuo9hZMZCYhttPqYikRKJVBNBkr7ygB3KVuzCpcD/+aVVMjJ1Cnrbq3GRvKpI85hRfF6d7Dd75ztdqiHh6E4aDnMu9jq8pQ8R
X-Gm-Message-State: AOJu0YyLY6Tsn5LuKnFiWDR60KItynyGu9NErH7rMRTEBL3m3/Opv8dD
	JYmUIDUo/1x/qNgPcHpSJJd7y7ds4yds2cz9bAWklRTa/tCit2xJRixkT3GoppAa02/cPJfMJgw
	Kooluqg==
X-Google-Smtp-Source: AGHT+IGSFv+N4psx4T1bgoLEjOQVawZMrnAfzOwkGP12iSQqdNgvfoe5KSiGrtLRCqy+sIW2RDGY0A==
X-Received: by 2002:a19:c216:0:b0:512:a940:a88 with SMTP id l22-20020a19c216000000b00512a9400a88mr587018lfc.0.1708581609435;
        Wed, 21 Feb 2024 22:00:09 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h7-20020a197007000000b00512d6bbe0basm409676lfc.55.2024.02.21.22.00.08
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 22:00:08 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso4972421fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 22:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWN17R3N4sWqqCNMecp3E4/lnrSlr+simXSpwYonwHsSTb7e6TJxSI8be93XDQQ11p2eilHW+zbC75rtA+hadroKlOlKfoQOoFsWRGrb5OY
X-Received: by 2002:a17:906:f0c4:b0:a3e:719b:c049 with SMTP id
 dk4-20020a170906f0c400b00a3e719bc049mr1321213ejb.28.1708581587292; Wed, 21
 Feb 2024 21:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-9-davidgow@google.com>
 <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
In-Reply-To: <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2024 21:59:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:05, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> this has a potential to cause conflicts with upcoming work, so I think
> it's better to apply this through drm-xe-next. Let me know if you agree.

I disagree. Violently.

For this to be fixed, we need to have the printf format checking enabled.

And we can't enable it until all the problems have been fixed.

Which means that we should *not* have to wait for [N] different trees
to fix their issues separately.

This should get fixed in the Kunit tree, so that the Kunit tree can
just send a pull request to me to enable format checking for the KUnit
tests, together with all the fixes.  Trying to spread those fixes out
to different git branches will only result in pain and pointless
dependencies between different trees.

Honestly, the reason I noticed the problem in the first place was that
the drm tree had a separate bug, that had been apparently noted in
linux-next, and *despite* that it made it into a pull request to me
and caused new build failures in rc5.

So as things are, I am not IN THE LEAST interested in some kind of
"let us fix this in the drm tree separately" garbage.  We're not
making things worse by trying to fix this in different trees.

We're fixing this in the Kunit tree, and I do not want to get *more*
problems from the drm side. I've had enough.

               Linus

