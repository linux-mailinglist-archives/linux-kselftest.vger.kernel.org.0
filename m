Return-Path: <linux-kselftest+bounces-5705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDF86DF31
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 11:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A60FB23532
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520866BB2B;
	Fri,  1 Mar 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7zSQN+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3E6BB23;
	Fri,  1 Mar 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288841; cv=none; b=FCivNLoHaT/mxsvic787CgzEMPCPaevY4mHUqTp3M811/d+9pmGAYzIsajsYyaz3CvKEApGcbywlBG1cWziSfI4C3XNSR+AvD72sBAxE+71xV94iMSoZvOsKWFqABpVOcD8xjtM5UTL8dBUEXI3oXz+A0Jyl6k78/pku9uOUUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288841; c=relaxed/simple;
	bh=+8R8JBu0KnyCCbyrJSAZ0i3n/0DKjztSJha154VV2Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8WD6Kl5haMOKUM5+1FUtc0bHwCiHQsSkpeFLdI0CMVp/IkW+N1MlL0FLt3ltIwh/lIu4ZMkJzhTU/5t7ihfPMorqKfja88ngQaVmkUj5sB4y7b9eJO8KDJEeYNnGc3T49eCBQsxCOibAeYHJvlRBm9CYdGnp+qwA4Xd48kn39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7zSQN+y; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so912843241.3;
        Fri, 01 Mar 2024 02:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709288838; x=1709893638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8R8JBu0KnyCCbyrJSAZ0i3n/0DKjztSJha154VV2Vg=;
        b=A7zSQN+ybvAU/+N+uTiMilWWdAl7L+a/TLFpxiceukhPC0gwIS9nvVXSKWf1zDusDR
         o/k4ov3eEF4WkQTiz41v2Hnx7SbCfZPG5GAhRTpGPlExNxwRx5JN51A4neZDJ9tp3GGI
         OTL8Bv8UrVClATBCzJnjx4dfpW7TQstsaP7G7oTZBzPMR6x2Yyok6orGKUmOBOd1dMro
         ra0F+WWF9CLG68s2+1O5Mm/Dzib6fUYMMU5mSKOwjgrZ1wZ48XyKTA/g4FhVjagSvg4O
         vbZ/3mUrivb45zmqRGu+LBzZiFT3i32JHU8F3CkKYWhpoAvDMDx5UyiCwqu/dQKwU2Xu
         wepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709288838; x=1709893638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8R8JBu0KnyCCbyrJSAZ0i3n/0DKjztSJha154VV2Vg=;
        b=eTp4Liy7kx2QZawftlyQ9pRPvMI6jgV2F8EkLy6VqlIUA+6HGmQyiEFqP+oEENok8W
         vDM7p/oc8SZI9bDg+PFVqSleyEveJii+Zuxgun2txGvHaDNCmwm3R3RU3Z3Z8pf23Ldg
         J/PksTPditPZ3N50kQR2Riv4iD97ybrAwC8GV7DCXHUk4/5veibNn5/vd7wmz+TKlIcw
         QBx5NMxQOwOm+IreYzT70KX+VIz/q54WuhUFGF3pPgk9jkQrEPFYLz3/1z/CeoIbd4eM
         2Thhoh182ObmuUkKOPs9O8S8bgAlCpa5nLoeWHldE/zI40mEVqHL78+9gJ6Gq6abTsJa
         1rDw==
X-Forwarded-Encrypted: i=1; AJvYcCX67cZKSw2u7c7j5+Jp6/JCnojP6D3Er2z8udbx0quPzLkU8jLWoIcXRu6yd5NqGCkKH3e/k3XoYA8HrgbAMRQ75eLqrR3AoWdt1TZRkXkh8r5O2qnsCZHzJ7F4+HAB7oyPsvgbc/+GIa4HhUc5EXDwLPPHTPsoln/WzceyfOOHAs5yG1G/f9eG
X-Gm-Message-State: AOJu0YyWLKk/wbKdu1G1ApDe+QbbFLSfzymOZYSO8YHPErgHyQa6+Tas
	owK1McKkwzTIMKjDu52j7YZl7sBpnMiXfjQfPptmgrBLg4BcMNPC
X-Google-Smtp-Source: AGHT+IGA2EhlSIveghf5fPs7eCJWWBEt2uWG2e0AMbakP0YO1TEMJxKEq/LVB0SDs/hMMY9hmOLxYQ==
X-Received: by 2002:ac5:c923:0:b0:4ca:80c5:7544 with SMTP id u3-20020ac5c923000000b004ca80c57544mr809997vkl.4.1709288838389;
        Fri, 01 Mar 2024 02:27:18 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id b22-20020ac844d6000000b0042ddde7c415sm1586898qto.9.2024.03.01.02.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 02:27:18 -0800 (PST)
Message-ID: <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
Date: Fri, 1 Mar 2024 12:27:13 +0200
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
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for stopping by, Linus!

On 2/29/24 10:21 PM, Linus Torvalds wrote:
 > On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> wrote:
 >>
 >> However, I think a better approach would be *not* to add the .gitlab-ci.yaml
 >> file in the root of the source tree, but instead change the very same repo
 >> setting to point to a particular entry YAML, *inside* the repo (somewhere
 >> under "ci" directory) instead.
 >
 > I really don't want some kind of top-level CI for the base kernel project.
 >
 > We already have the situation that the drm people have their own ci
 > model. II'm ok with that, partly because then at least the maintainers
 > of that subsystem can agree on the rules for that one subsystem.
 >
 > I'm not at all interested in having something that people will then
 > either fight about, or - more likely - ignore, at the top level
 > because there isn't some global agreement about what the rules are.
 >
 > For example, even just running checkpatch is often a stylistic thing,
 > and not everybody agrees about all the checkpatch warnings.

I agree, it's hard to imagine even a simple majority agreeing on how GitLab CI
should be done. Still, we would like to help people, who are interested in
this kind of thing, to set it up. How about we reframe this contribution as a
sort of template, or a reference for people to start their setup with,
assuming that most maintainers would want to tweak it? We would also be glad
to stand by for questions and help, as people try to use it.

 > I would suggest the CI project be separate from the kernel.

It is possible to have a GitLab CI setup with the YAML files in a separate
repository. And we can start with that. However, ultimately I think it's
better to have it in the same repo with the code being tested. This way you
could submit code changes together with the required tweaks to the CI to keep
it passing, making development smoother and faster.

With that in mind, and if you agree, where else would you say we could put it?
Under "scripts"? Or "Documentation"? And where it would be best for the
various subsystems to put theirs? Or could we have the top-level "ci" dir and
pile all the different setups there? Or would you like to wait and see how
adoption goes, and then decide?

 > And having that slack channel that is restricted to particular
 > companies is just another sign of this whole disease.

Regarding the Slack channel, we're also on #kernelci on libera.chat, and we
have some people there, but if more people start showing up, we'll be spending
more time there too.

 > If you want to make a google/microsoft project to do kernel CI, then
 > more power to you, but don't expect it to be some kind of agreed-upon
 > kernel project when it's a closed system.

Yes, our Slack is a closed system, unfortunately. However, it's not a part of
the proposed CI setup *at all*, and it doesn't depend on Slack. We just like
using it, but we're also fine with IRC.

GitLab is open-core, and no closed-source software is required for the
proposed setup. There is the public gitlab.com where you can deploy your CI,
there's also the freedesktop.org instance, and it's possible to set up your
own (albeit not easily).

Nick

