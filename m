Return-Path: <linux-kselftest+bounces-6075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4584875A66
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5586E1F23330
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F638DD3;
	Thu,  7 Mar 2024 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J72VMQaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4555381CF;
	Thu,  7 Mar 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851398; cv=none; b=WWVpu3gTrjgSqXeOW6XXEv4jtpDJv2nIv4oKaJjpLvTwCMs5e3HG9JIRuvJ0KQ2ezJp5A3GarN90wrO1p0WKGnu1ZMkST9if128FrRgSBLKGis1shv82gEFsZINShj1qnkTU1ezKAKeiFiExVebT166EO48UQGgtkJyf50f86H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851398; c=relaxed/simple;
	bh=6QK4W1NufyM+scYXoml0RdEgGXJVv/Tf0aCSLp9EfLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqOjwSwem9Xy6WKrCyBWbEn0NYxWB/pS87jzUEd99c+1oPJ9T6GWrQ5epW7d62j00HD5U1Z2VwjSLdrAq8vJqKif1GkeI/MoPrddmw1Q7DCiV3rF4hoYgReqIZ3hyBi1rEgkFN1RtBtxNWpRmyZ4GyGaABlrqV90ACVW4wafmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J72VMQaA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1113327a12.0;
        Thu, 07 Mar 2024 14:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709851396; x=1710456196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfbS9E4Z674Rghf4uG1aBze02oodSRDBbrR7JY0TaRQ=;
        b=J72VMQaAt07ZU5JWBY98iYCZI2rvTK9nqVbZD0oyuGEFcEhPeVQbal2UEzTEGrCvOZ
         FRsGomt4iNSxwBPh66C+Hq5qz132jNyMpNieoEkMeG0jSUadZdlgveM8XeMbHBjm0/jC
         X3iQdfXh0ER+N0pJCDQM8tVtvruSaHNyWoQ+1HxtxOx4PyaqJFIeXSI0nQHGOIJ54HUH
         JdAIxWj2dl6dgrWroqNtfPhKktIPUKPO87eSP3sTFdzktSlnV/dCdOjlijz91PfpEJfr
         4DQkh9dU/pRT4IG1jMlv5gt/1ngfmUWekjsG115p/qNPRsXzvcksScsiLXQmmzYiXTD4
         z8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709851396; x=1710456196;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfbS9E4Z674Rghf4uG1aBze02oodSRDBbrR7JY0TaRQ=;
        b=IM8ocS5r0GMQXkQztf7cPvgCmFfvMLIl0HqYSNO4H5YifikcAna+zHi1aagdmyhwVv
         K3HXj+ICbZbAcncJkgtubBYKygs++9lIT96ticj1lZ1Zsfh8ne8p4CIpeF7kJbA/aJAS
         GnK4mNB2jfMxd78/VqK5G2c8RIGLFtr9vo7igTdhlRX/wo5wcoWm+TG02SzAwWYIZxLe
         tKpuPb/uGz+bAKu1UXtqu/lUl5ML7rC4BnIkI3fpJkKm8k1GvYy/6rBI7QUynldpMgND
         h9KwDN3gyiT2mmhfDtw9S4yDoY7czCw90SGDwgEUmwzKPzkS3Y2zWiGYC8Cye1Q4GCVZ
         j4QA==
X-Forwarded-Encrypted: i=1; AJvYcCVkGoWUs7EwSodSlddCN1BbcDq8gxZzXhJ/Ph0as2CjfiSwc9q+142XhLw8bfDvax9xc9AOPkY3Us2mDBdGuryCxkV2YnCrAg7PJYMFhMuVQTEtWZFXfvG9r0NdtLtiKl0T0FCyV+YlZZOIEWRmK4rHTnFlqgPxFAfBWnY4Nel4E/vJqVPDddbf
X-Gm-Message-State: AOJu0YzyvufnVkLLux4IIcxFgYAYST7dRUn3V0e2PJI6RL4JiKcI1OYZ
	5DcVR/Hq+Rvic+newmMTnBYhhNEiJTS7j2KSyLrESEGOQwO64lkTsoSBuYZ9
X-Google-Smtp-Source: AGHT+IHtTE1JX4FWkJmXISxOpLlBlT4E93v3RIPvarcuDzGIbaoE7RwplZ6pR6YPOiYfZGA2Q6GFwQ==
X-Received: by 2002:a05:6a20:9f03:b0:1a1:56aa:bf66 with SMTP id mk3-20020a056a209f0300b001a156aabf66mr13285633pzb.13.1709851396096;
        Thu, 07 Mar 2024 14:43:16 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:2ba7:2726:579:e699:a435? ([2804:1b3:a801:2ba7:2726:579:e699:a435])
        by smtp.gmail.com with ESMTPSA id ei30-20020a056a0080de00b006e5359e621csm13053181pfb.182.2024.03.07.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 14:43:15 -0800 (PST)
Message-ID: <673ec9f4899cd1380d02bebe92d9a3d6dd7cda55.camel@gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Helen Koike <helen.koike@collabora.com>, Linus Torvalds
	 <torvalds@linuxfoundation.org>, Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, linuxtv-ci@linuxtv.org, 
 dave.pigott@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
 gustavo.padovan@collabora.com, pawiecz@collabora.com,
 tales.aparecida@gmail.com,  workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 gregkh@linuxfoundation.org
Date: Thu, 07 Mar 2024 19:43:04 -0300
In-Reply-To: <17341b96-5050-4528-867a-9f628434e4e6@collabora.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
	 <20240228225527.1052240-2-helen.koike@collabora.com>
	 <20240229-dancing-laughing-groundhog-d85161@houat>
	 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
	 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
	 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
	 <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
	 <17341b96-5050-4528-867a-9f628434e4e6@collabora.com>
Autocrypt: addr=leobras.c@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 18:45 -0300, Helen Koike wrote:
> Hi Linus,
>=20
> Thank you for your reply and valuable inputs.
>=20
> On 01/03/2024 17:10, Linus Torvalds wrote:
> > On Fri, 1 Mar 2024 at 02:27, Nikolai Kondrashov <spbnick@gmail.com> wro=
te:
> > >=20
> > > I agree, it's hard to imagine even a simple majority agreeing on how =
GitLab CI
> > > should be done. Still, we would like to help people, who are interest=
ed in
> > > this kind of thing, to set it up. How about we reframe this contribut=
ion as a
> > > sort of template, or a reference for people to start their setup with=
,
> > > assuming that most maintainers would want to tweak it? We would also =
be glad
> > > to stand by for questions and help, as people try to use it.
> >=20
> > Ack. I think seeing it as a library for various gitlab CI models would
> > be a lot more palatable. Particularly if you can then show that yes,
> > it is also relevant to our currently existing drm case.
>=20
> Having it as a library would certainly make my work as the DRM-CI=20
> maintainer easier and  also simplify the process whenever we consider=20
> integrating tests into other subsystems.
>=20
> >=20
> > So I'm not objecting to having (for example) some kind of CI helper
> > templates - I think a logical place would be in tools/ci/ which is
> > kind of alongside our tools/testing subdirectory.
>=20
> Works for me.
>=20
> We  can skip having a default .gitlab-ci.yml in the root directory and=
=20
> instead include clear instructions in our documentation for using these=
=20
> templates.

From previous experience[1], I recommend this approach.

This way it does not bother current Gitlab mirrors / personal repos, while
allowing anyone to setup the CI from Gitlab menus just by changing:

Repo -> Settings -> CI/CD -> General Pipelines -> CI/CD configuration file

Thanks!
Leo

[1] Last year I implemented Gitlab-CI for the perfbook repo, and I came acr=
oss
some issues, including the disruption of .gitlab-ci.yml in the root of a re=
po.
https://lore.kernel.org/perfbook/20230201201529.901316-1-leobras.c@gmail.co=
m/

>=20
> Thanks,
> Helen Koike
>=20
> >=20
> > (And then perhaps have a 'gitlab' directory under that. I'm not sure
> > whether - and how much - commonality there might be between the
> > different CI models of different hosts).
> >=20
> > Just to clarify: when I say "a logical place", I very much want to
> > emphasize the "a" - maybe there are better places, and I'm not saying
> > that is the only possible place. But it sounds more logical to me than
> > some.
> >=20
> >              Linus


