Return-Path: <linux-kselftest+bounces-5922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954D871E50
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07962845B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1343858ABA;
	Tue,  5 Mar 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lCbW5Fku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB458123;
	Tue,  5 Mar 2024 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639661; cv=none; b=qTnaJUzkJwBoltoUbWrraDwkqmse9n1cWO+MND0VcvShD5WjClVe6i/5z2fEIeHpB8NJeFqSbSO+aDZqBjG0N/ICm+Qd9YF+Tp508U+YEqa0K/HDShywLqact+TrRnsOA8o3HKM0EV2RilVX9TH63OFXW2OhzilOIqIPkiJkKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639661; c=relaxed/simple;
	bh=x67k3bXd+uwmOFJJWOm3lRnqdPiR3GAdvjQmyD9Eock=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMHeSuszuuH0N2nzYmrNAoi/atZHiTCvalXDtqtX7S/3n+gSjriET9d4IJvaFqeIZ0eP2/qHnS41blgjK4aDhuBYjBN1g1A5/UX+A7DgM+rjaBIyTDXQy+M3hrsMNgagwM9jXeCboj8YHshTZfQ+oN02uN7ZbzKGEZ3EsEcfYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lCbW5Fku; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tpv9Y2RPSz9sdN;
	Tue,  5 Mar 2024 12:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1709639649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiRlMg6h832yaauOUM6BWIgl8Xd8q3pgd4fABlp2sNE=;
	b=lCbW5Fkub4izG2Oae+U/G280FBsPwV8XxqT1+OYlgVxXYXzDihADmuze4xgdqFMYUvK8rW
	oJyybsoihkw07bNiavbIs7msvfck72PWOOWrJpj3uur04l60nNW4XiNT2MazDIG2W2VARa
	+a8hijWBWxiv34doewuhy6xQPcrV4jS9lUt20cdGct+RgK5pnbrx7WDxxZ0dr6/q9A1yh4
	UgG1XdhWaaoGRB/8J1rihDNeV2+oRpWWFVIc/Nt6eGR+1qHXm5ZO4ZvRGinB7ysS0kj2pb
	UBuAw51IIfos4Ml37c6FKtD7AeZDaY9K5+q/oTSvnBtn6WL4wk/D5xFyZVwu6A==
Message-ID: <2c828aa1-d9bb-4b27-844b-a098e206318f@mailbox.org>
Date: Tue, 5 Mar 2024 12:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
To: Linus Torvalds <torvalds@linuxfoundation.org>,
 Nikolai Kondrashov <spbnick@gmail.com>
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
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iuhiedtbyd865d5er91f663bapgj73ny
X-MBO-RS-ID: 76dfc0d5d612d7f2266

On 2024-02-29 21:21, Linus Torvalds wrote:
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
> 
> I would suggest the CI project be separate from the kernel.

That would be missing a lot of the point / benefit of CI.

A CI system which is separate from the kernel will tend to be out of sync, so it can't gate the merging of changes and thus can't prevent regressions from propagating.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


