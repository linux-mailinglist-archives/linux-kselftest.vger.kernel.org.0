Return-Path: <linux-kselftest+bounces-23178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012939ECDCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E021618E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D52368FB;
	Wed, 11 Dec 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoOIkRdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C032336BD;
	Wed, 11 Dec 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925464; cv=none; b=UNcTgfVh+afYoD1nQx8fOccQn1yF0jfPCdAbkXdnGE11nV7IVXY1ri45W9oAPQv9DRuMpQJT94hIeB5xKz8A9r2r6r7WAgI5VPpYcs7OAf4ChFUrAd1w0ncZ+oQ9qjMh14sRXy24WeEerDMC/b6kOH2j/SmfllTF5QDzVV0y5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925464; c=relaxed/simple;
	bh=RT5uihM/rC1b2yck9l0Tr/c4MLoW6UiSI8o1kYUVozk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMWA7RjZTqV0GMVzthPQ+bN6BtNoxsENRbzIHuXeMMZ0Ew+APzzn6MbRTGw1q8oGgiD6n4mUpmbzKBFpGxteIiFGG9/cyxOHNA5KrtnXDm5oYl4tLG8QAlzET+CU8wweMkvjN2Ei/EaFchCtH0BJW0mpL8EBLLFiiJP71ZDrbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoOIkRdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422AAC4CEE5;
	Wed, 11 Dec 2024 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733925464;
	bh=RT5uihM/rC1b2yck9l0Tr/c4MLoW6UiSI8o1kYUVozk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YoOIkRdF9zXeXf+4LTv82ivkNPn44tmqHR5Ut15J8YpsWUtbS3zKwfuBoIYvZOENx
	 WmwM1+XW+QeZ2eQOJcythLLKJsyd7+tJq1u2P3mRZvk/Lrm3IF+Vw6ATB8FMK3f0G+
	 hoZ2F1P7k20gIsfBLGTyhxyPq7K302QgvHJLzV3tYAKu3LDw/szy7Tew57/FGNEPAv
	 tqOrfvxTn5rT1bxwLVo2OU+xfjhj73b74B8Bnv67rjjZ41v1OC7SQKjWvmKLBN/3uL
	 8AbPsibA1DPq9cotI3OUj6uLssFcPaHhtFivxU3+XoI/Csb1JeAVLW4m+GTqitXwjm
	 KYYv+YHqLf1Rw==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3a26de697fso3276395276.3;
        Wed, 11 Dec 2024 05:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCaMdnoZf66GNVD1zu7MFGHq2QI+Vr9OzfpY0hpfdVTae5bt+PZZxJbBBIf1KZwiX3EuNcF5Syo7xY@vger.kernel.org, AJvYcCXtLjTSTfXFnEw6jn7jFEnpSJA+S4F3PhCwspNXerJ4/dQrG3ug5O9rZt3AEg/BysEHB6SdK7jmZJ3QZv/ZTeWH@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/maLFJV2FOEygKx3Lo64ef3ex/jpzJww5MAPXmkuGVY4yBzh
	c+B84BZwq7SNBgwNnn82uCOVRpdXg2KVZ9UI5KmoL8qo1dClP5si0Lck6fZGNK9h6l1g++KD5ek
	4Ny9YiPhHVHbVLiiPMqMpwCC4BA==
X-Google-Smtp-Source: AGHT+IEqls92e19jtYGMja3H+WHoTIOik5ec1NxAyhqoerzKj7xRyZCDXASsMIxGfwXLMRlQ3bKQTuCWQTJVmlsMxXg=
X-Received: by 2002:a05:6902:2086:b0:e28:fa51:634a with SMTP id
 3f1490d57ef6-e3c8e660f1dmr2411160276.31.1733925463422; Wed, 11 Dec 2024
 05:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210191353.533801-1-briannorris@chromium.org>
In-Reply-To: <20241210191353.533801-1-briannorris@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 11 Dec 2024 07:57:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVs9qLQxp2zPN_6SHJ9KvjAOhUw2MfPo=75PZ_XnihdA@mail.gmail.com>
Message-ID: <CAL_JsqLVs9qLQxp2zPN_6SHJ9KvjAOhUw2MfPo=75PZ_XnihdA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drivers: base: Don't match device with NULL
 of_node/fwnode/etc + tests
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:14=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> This series:
> 1. makes the behavior of_find_device_by_node(),
>    bus_find_device_by_of_node(), bus_find_device_by_fwnode(), etc., more
>    consistent when provided with a NULL node/handle;
> 2. adds kunit tests to validate the new NULL-argument behavior; and
> 3. makes some related improvements and refactoring for the drivers/base/
>    kunit tests.
>
> This series aims to prevent problems like the ones resolved in commit
> 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if one
> actually exists").
>
>
> Brian Norris (4):
>   drivers: base: Don't match devices with NULL of_node/fwnode/etc
>   drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
>   drivers: base: test: Drop "devm" from platform-device-test names
>   drivers: base: test: Add ...find_device_by...(... NULL) tests
>
>  drivers/base/core.c                      |  8 ++---
>  drivers/base/test/Kconfig                |  1 +
>  drivers/base/test/platform-device-test.c | 42 ++++++++++++++++++++----
>  3 files changed, 40 insertions(+), 11 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

