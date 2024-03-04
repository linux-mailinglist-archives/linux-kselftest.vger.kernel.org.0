Return-Path: <linux-kselftest+bounces-5858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B6870EA6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE79B242E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8467B3FA;
	Mon,  4 Mar 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aChUylf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7B46BA0;
	Mon,  4 Mar 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588747; cv=none; b=Dw73M9T2tmpNyMw+2Q515gDmCLaATGYdQOix1q7+pZpA3yk5q4kxI4a0f06JvUU5hLAHHt1ScMfq3hye6buEwOGsXd+sIYYwHiHNlf4aBSTOSv2kvzsR9lenHNC1v3/ygGIUxj24KLPeYJloXHueXaYHorsgj9JWkmyMf+MIXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588747; c=relaxed/simple;
	bh=XV95ADWCt9SlcZ8u/EFGMeLeOk3IcW2jLKJtlEt3LvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdJdt5GtR+FojRxD6C9pjEMGXWdgaJlJd3b/FSRcsPSoAakSfQn/pVw1fb/qU3/qlV0E40rgFxeMTHRPaIni8ocF/VkFD2sryyvLUueycWurSO3hetG4tKUsdS8DFQYTFlET9vLdTosoL18GdM+lTAFxEB6SRK8wdCFtRyOz75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aChUylf9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709588743;
	bh=XV95ADWCt9SlcZ8u/EFGMeLeOk3IcW2jLKJtlEt3LvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aChUylf9pqH0pRyxupBsIGBiyQfFvaj6tZQyP/+Oov+ZRgIXTK6RwvtLPZJeLwDhq
	 Vm35JuhECN/Bp9GC/be7hxNZwGrq6HCROApsnWxBYuw87dVk0NRDBT6AMkri5Ub/yx
	 0f+mwrxnJFeEQ66y3KlDiQpi57UIBa6WfuewCzyly9by+dWGgUqqZkhS6KWZHSqTv9
	 EOmXy3qqVdE+HaJAZj389eCSgrYm5l2HNn169EEA//oOlFsInxE1JeRKn+zLmK4aCY
	 zTVXd6wPDUjVsf5RQqckMK0KFXbd/yRhU+U6gsLUDS+c05v0TSJ0QfBvulj8dZc+Cn
	 JB/Y/knJ89dLw==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB00C3780627;
	Mon,  4 Mar 2024 21:45:36 +0000 (UTC)
Message-ID: <17341b96-5050-4528-867a-9f628434e4e6@collabora.com>
Date: Mon, 4 Mar 2024 18:45:33 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
To: Linus Torvalds <torvalds@linuxfoundation.org>,
 Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, linuxtv-ci@linuxtv.org,
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
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
 <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Thank you for your reply and valuable inputs.

On 01/03/2024 17:10, Linus Torvalds wrote:
> On Fri, 1 Mar 2024 at 02:27, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>>
>> I agree, it's hard to imagine even a simple majority agreeing on how GitLab CI
>> should be done. Still, we would like to help people, who are interested in
>> this kind of thing, to set it up. How about we reframe this contribution as a
>> sort of template, or a reference for people to start their setup with,
>> assuming that most maintainers would want to tweak it? We would also be glad
>> to stand by for questions and help, as people try to use it.
> 
> Ack. I think seeing it as a library for various gitlab CI models would
> be a lot more palatable. Particularly if you can then show that yes,
> it is also relevant to our currently existing drm case.

Having it as a library would certainly make my work as the DRM-CI 
maintainer easier and  also simplify the process whenever we consider 
integrating tests into other subsystems.

> 
> So I'm not objecting to having (for example) some kind of CI helper
> templates - I think a logical place would be in tools/ci/ which is
> kind of alongside our tools/testing subdirectory.

Works for me.

We  can skip having a default .gitlab-ci.yml in the root directory and 
instead include clear instructions in our documentation for using these 
templates.

Thanks,
Helen Koike

> 
> (And then perhaps have a 'gitlab' directory under that. I'm not sure
> whether - and how much - commonality there might be between the
> different CI models of different hosts).
> 
> Just to clarify: when I say "a logical place", I very much want to
> emphasize the "a" - maybe there are better places, and I'm not saying
> that is the only possible place. But it sounds more logical to me than
> some.
> 
>              Linus

