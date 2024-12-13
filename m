Return-Path: <linux-kselftest+bounces-23322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852F9F0F5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1FC164CD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3321E1A3F;
	Fri, 13 Dec 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te9L7yZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA31E0DD9;
	Fri, 13 Dec 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100735; cv=none; b=VWCaLpY02jlJfcQhiXlAlCxt/ZkVx+pDihOiZ8ndL+8AW0rMw0lOy3sjxVXT0yd8yBHNHvSWURu3YjTswefzAAVfQU7H1Shde1+HUMU9SH1nAAOZfrCc2ifpAWtQDFMdZwdxO8sbsDv+3kX2BSRSl8C9BVX01tHMkBG5W7mojG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100735; c=relaxed/simple;
	bh=JyFF+T3NiQ3bpjkGsyF5HGaVVrJauE8H4Qo736pmrxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFb2SH7lG/QMEgQNPEG3eFgHKrCfgm392icjD7Aqt5R9hlcFd6zl+U/BK5zet6oIKpXrR6viOt78MQeXbo6Oz/baFQMaCikqNE6+dLYcLuKvSdLIbqCWmAb8u7y58pv5eYx15dzMu1znd/BNniT8LHvVbbw43tvKeNzWy85qgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te9L7yZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D2FC4CED0;
	Fri, 13 Dec 2024 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100734;
	bh=JyFF+T3NiQ3bpjkGsyF5HGaVVrJauE8H4Qo736pmrxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Te9L7yZS3fi5BAzVTCw/TKpltm3viGPM6Y6wVHP6IqR2cyiJGIWGogHdIEvgwA0Li
	 W0d1LKfN0NS2tC4kjFaScJ00ATWk1kOby4Xd0psUf9jI3NKG2ey/piW1YW+zYD3Q15
	 ufq17JWPYrDvyg0QusV//bVFykMyIxLd+hfD/toLAXsh7KQwTrS/VRRp+TshYJmH4/
	 Fu+6A0oS5UqzmaJ7TiKVzHwkf66wmuRjYyne30s03GqiGqwdcOFmd8a8t+Ja4ZiZmQ
	 UZ4FUcVtNHnnyeYc5JKcTJ1EZc6jTSLwH9bc5lJw+k3Y+AvjUssz7fFbrYcRXfSME0
	 tZENXJYFW9hgA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ea55a2a38bso962580b6e.1;
        Fri, 13 Dec 2024 06:38:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpGG7clk2S/wFZSpXfBbrp2SyorEaxiN9vdJRXJf40I/Gb1V0BkOPm8SFD2emndpP3elXX92UXWxHm@vger.kernel.org, AJvYcCUs2VxvSYdLgRF4cXqHZyL+70tdbHqUdOFmJBWEhBoOjkHlRV5lWzaSxYDDh/MQNSBHA+hZ4FRtCXehEaG0ftGc@vger.kernel.org, AJvYcCXp/X+FWdS7OTE5xObgIID8rA0S8URKZJjToiRv1rxg+WCjMj6brnQr8Ij4vykHl0cWzRsovaAxZZzejWuM@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4TnMi62+I1Sj3HOe2UYzBQmIqIR1GTm+AKvFtgBM9NQcbQ4J
	//ekp+y7V8ux8saOF+hklfEyv/Q7YdSskR51uy1DQ2fvaFeGBlEDGPPov5LLQVTcfdvyZ+qeK9Z
	JfpFhdZbo/Gdq8h+ilxK57lVnnwQ=
X-Google-Smtp-Source: AGHT+IFyre0J9CImHbllUvwTGmrPYHXBt6ubdpS8LuYzsYwFeublEs32ivntjIy366aB7ladKYrxX9oaqIsEjn/3JZg=
X-Received: by 2002:a05:6808:16a2:b0:3ea:44ae:a65 with SMTP id
 5614622812f47-3eba67fe978mr1810634b6e.5.1734100734047; Fri, 13 Dec 2024
 06:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212003201.2098123-1-briannorris@chromium.org> <20241212003201.2098123-2-briannorris@chromium.org>
In-Reply-To: <20241212003201.2098123-2-briannorris@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 15:38:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0id5MxNniN7xndMWKU4mvegNZ2V-sGRC6cJ3jHCu0puCQ@mail.gmail.com>
Message-ID: <CAJZ5v0id5MxNniN7xndMWKU4mvegNZ2V-sGRC6cJ3jHCu0puCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: base: Don't match devices with NULL of_node/fwnode/etc
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	Maxime Ripard <mripard@kernel.org>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:32=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> of_find_device_by_node(), bus_find_device_by_of_node(),
> bus_find_device_by_fwnode(), ..., all produce arbitrary results when
> provided with a NULL of_node, fwnode, ACPI handle, etc. This is
> counterintuitive, and the source of a few bugs, such as the one fixed by
> commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
> one actually exists").
>
> It's hard to imagine a good reason that these device_match_*() APIs
> should return 'true' for a NULL argument. Augment these to return 0
> (false).
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

For the ACPI part

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> Changes in v2:
>  * Add Rob's Reviewed-by
>
>  drivers/base/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 94865c9d8adc..2b7b13fc36d7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5246,13 +5246,13 @@ EXPORT_SYMBOL_GPL(device_match_name);
>
>  int device_match_of_node(struct device *dev, const void *np)
>  {
> -       return dev->of_node =3D=3D np;
> +       return np && dev->of_node =3D=3D np;
>  }
>  EXPORT_SYMBOL_GPL(device_match_of_node);
>
>  int device_match_fwnode(struct device *dev, const void *fwnode)
>  {
> -       return dev_fwnode(dev) =3D=3D fwnode;
> +       return fwnode && dev_fwnode(dev) =3D=3D fwnode;
>  }
>  EXPORT_SYMBOL_GPL(device_match_fwnode);
>
> @@ -5264,13 +5264,13 @@ EXPORT_SYMBOL_GPL(device_match_devt);
>
>  int device_match_acpi_dev(struct device *dev, const void *adev)
>  {
> -       return ACPI_COMPANION(dev) =3D=3D adev;
> +       return adev && ACPI_COMPANION(dev) =3D=3D adev;
>  }
>  EXPORT_SYMBOL(device_match_acpi_dev);
>
>  int device_match_acpi_handle(struct device *dev, const void *handle)
>  {
> -       return ACPI_HANDLE(dev) =3D=3D handle;
> +       return handle && ACPI_HANDLE(dev) =3D=3D handle;
>  }
>  EXPORT_SYMBOL(device_match_acpi_handle);
>
> --
> 2.47.0.338.g60cca15819-goog
>

