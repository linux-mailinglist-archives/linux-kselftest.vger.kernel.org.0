Return-Path: <linux-kselftest+bounces-42139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD977B94FE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0C2E27DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBB31D377;
	Tue, 23 Sep 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGbuLz6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CD31D370;
	Tue, 23 Sep 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616171; cv=none; b=C6d1R+EmmvuG6TzAN7Ow32op74ft5F0ehnTd8wN79kC0rbXOV2co7YhrZQu1FEjhn3B8P6QKVq06X4gUgGnWlS/pD3ZiMSgpdhyXHLHE+hMvf/MFbg6GicEABNY4K0m6IpZhBEOkCF+IL5IfXxwzZhukeM2xvUVlGWT+y4uRlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616171; c=relaxed/simple;
	bh=QA4dhLngrf/N2QuOvxCA3alevmBqOHkEYDYr4dVdZDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiZ3BmymlpUG2h9/FihbbBjPh/516goEhsGF149Wehrj48hDmYTQV0A4VXfnnvbQkdJChHciFPsrUBHt+wGrTJ72LXkEVW3feblNxBvLzNkAJmOoBxdoT6WuVwsKCkiXuZ7dDGV8YS6HTrHPYMRR9p8b+ob170Rq+dYdQrkbf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGbuLz6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CEFC116B1;
	Tue, 23 Sep 2025 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616171;
	bh=QA4dhLngrf/N2QuOvxCA3alevmBqOHkEYDYr4dVdZDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGbuLz6FhVbXg03xpmbk7NRWcmZxBtgummMr53CyHiuAWFH41jST/frd5GdyxHjFm
	 VLROdVIfK9YbkNjFqv/jlysEeMKh2PDqyL9hsiwOnmWwJMuiwUfBM9QAInVY6w6UB5
	 of3KcoET46JsujxQdU2FzOZsCL5tpeJLYetdsSpg/Lyykc57xubbYDqyaWXRyLR/e9
	 AuHEFt1RuFXYpr3PaUhqdDNccR+q+ydGs1ywECauVqoypVWfCHi/gDy6zkhMADlx0k
	 vVf4GRbMP/8DPio0FrEfS6a20zoEchCXmvUEp8R0cYsZkJ90bMQtYwuj1lsd++C9wD
	 hAUBJU5hxuSXA==
Date: Tue, 23 Sep 2025 08:29:26 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 7/7] platform/chrome: cros_ec_chardev: Secure
 cros_ec_device via revocable
Message-ID: <aNJaZr8b7If54e8P@google.com>
References: <20250923075302.591026-1-tzungbi@kernel.org>
 <20250923075302.591026-8-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923075302.591026-8-tzungbi@kernel.org>

On Tue, Sep 23, 2025 at 07:53:02AM +0000, Tzung-Bi Shih wrote:
> @@ -166,7 +166,6 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->ec_dev = ec_dev;
>  	priv->cmd_offset = ec->cmd_offset;
>  	filp->private_data = priv;
>  	INIT_LIST_HEAD(&priv->events);
> @@ -370,6 +369,18 @@ static const struct file_operations chardev_fops = {
>  #endif
>  };
>  
> +static int cros_ec_chardev_rev_try_access(struct revocable *rev, void *data)
> +{
> +	struct chardev_priv *priv = data;
> +
> +	priv->ec_dev = revocable_try_access(rev);
> +	return priv->ec_dev ? 0 : -ENODEV;
> +}
> +
> +static const struct revocable_operations cros_ec_chardev_rops = {
> +	.try_access = cros_ec_chardev_rev_try_access,
> +};
> +
>  static int cros_ec_chardev_probe(struct platform_device *pdev)
>  {
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> @@ -385,6 +396,8 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
>  	misc->fops = &chardev_fops;
>  	misc->name = ec_platform->ec_name;
>  	misc->parent = pdev->dev.parent;
> +	misc->rp = ec->ec_dev->revocable_provider;
> +	misc->rops = &cros_ec_chardev_rops;
>  
>  	dev_set_drvdata(&pdev->dev, misc);

If we prefer to avoid modifying the device driver, the driver must at least
register its resource providers with the subsystem.

This would allow the subsystem to guarantee resource validity by calling
revocable_try_access() before dispatching any file operations.

The device driver could then access its resources directly
(e.g., priv->ec_dev) within its fops, as their validity would have already
been checked by the subsystem.

