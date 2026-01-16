Return-Path: <linux-kselftest+bounces-49144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9ED31CB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C6A73027816
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E63274B4D;
	Fri, 16 Jan 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ISgBeH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3C26C3A2
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569965; cv=none; b=ePZhDDWByJSNxwi3Z8GCWLVjW+xRFtKgjU81GbQxQgNfldDrNMO3Fzcowo9/Laz2j9D9cC8J3K2DbRiTHLXNBrfNWm4ug4UY5shhguEDZ7+BYnBVc44jGbhW1r/QH+7c2ymo7WJreKQ368i5tua6j0sQ3izgX20a0J0dLpd0VaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569965; c=relaxed/simple;
	bh=IR3KwNWNKGPtS44m5xlCPYzSAGbubcbp6zpZ8tb6nAo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ8gTkNVbB8SOrPouisIBLeHLu8IOVKD6UYZWZy+rDSugggdYAUpzAAavpeGxLN/wbkrS+jNLUCQvsvWosIqEX7yuHv+f8JngncoOM0kRGnbpPuOmw1pQPT5EyZWWkDSrqWreMJnZ1n2sKYBtFgcJ8InFDhnFcqaPNLL2P6Cltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ISgBeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA1AC2BC87
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569964;
	bh=IR3KwNWNKGPtS44m5xlCPYzSAGbubcbp6zpZ8tb6nAo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=G9ISgBeH8iyNsYYQXxnHbuiQa9xxaDmZa76j7YBGuWtUjZXFWtSltx+/fBfC4B3Zl
	 PMcpgMnWQFn19cmPvXHw9+KdCBUhtPK/2B3AMpCi1cCbdwNW8XbZj8kLgMCEAg/mjT
	 VIzNk1nJDRY6NKxGID7e5QlrBs7sm+Yw6PTzWwntoHfV52XgP6DQlaryMdDGwW53dd
	 kksWm/yK9d8kbIkPwNJ8IsBK+AfgfbNDQMlnqZ78QIvdtlUP++ZxHFzhn9y5g6ieqo
	 Ux/d0iFx87+lBKHrGU0MaNxEWHKFdQyuSoMhmIlZM1XWMe4QsPbmnXLEy04NdH93qs
	 uofvgtfAeac5w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6f267721so1894151e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 05:26:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo2izkoFY4kWxhcFtQYYgazxGumubbOstWYvMQBsh8g3YoP2KZwjtqcOzE5N+aJokGYJyB4tKFYo1loI19BH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZvLKIZQEplTHYeRyYKOkBvGVkZRbUBkKR0HiRMGSichmXhTA
	o+VA4f9iBpfgrcCZ+SYi314N957+OTwrrTOueV82opXCAwxWtzjg9FjEWfKRtehsWf7GTJya6pO
	v5vH5r/B+asmPNB89J1h8qW9ECW152Wl7Fi+O5KH5eQ==
X-Received: by 2002:a05:6512:3f20:b0:59b:2670:aa5 with SMTP id
 2adb3069b0e04-59baffd29famr758352e87.37.1768569963190; Fri, 16 Jan 2026
 05:26:03 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 13:26:01 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 13:26:01 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260116081036.352286-5-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-5-tzungbi@kernel.org>
Date: Fri, 16 Jan 2026 13:26:01 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mc4UoXif=vwUQG1jYW8G3QziZwbdcfvZGquytdrd4SBpg@mail.gmail.com>
X-Gm-Features: AZwV_QgiwcYDrwjaLeT09nufbHbwRGBProJRFcLW2Iu2MBC1N5SlHrenV-Bc4z4
Message-ID: <CAMRc=Mc4UoXif=vwUQG1jYW8G3QziZwbdcfvZGquytdrd4SBpg@mail.gmail.com>
Subject: Re: [PATCH 04/23] gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 09:10:17 +0100, Tzung-Bi Shih <tzungbi@kernel.org> said:
> On error handling paths, lineinfo_changed_notify() doesn't free the
> allocated resources which results leaks.  Fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: d4cd0902c156 ("gpio: cdev: make sure the cdev fd is still active before emitting events")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ba1eae15852d..6196aab5ed74 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2549,7 +2549,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
>  	if (!ctx) {
>  		pr_err("Failed to allocate memory for line info notification\n");
> -		return NOTIFY_DONE;
> +		goto err_put_fp;
>  	}
>
>  	ctx->chg.event_type = action;
> @@ -2563,6 +2563,9 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  	queue_work(ctx->gdev->line_state_wq, &ctx->work);
>
>  	return NOTIFY_OK;
> +err_put_fp:
> +	fput(fp);
> +	return NOTIFY_DONE;
>  }
>
>  static int gpio_device_unregistered_notify(struct notifier_block *nb,
> --
> 2.52.0.457.g6b5491de43-goog
>
>

There's only one place where you need this fput(), please do it directly in
the error path of kzalloc() and drop the label.

Bart

