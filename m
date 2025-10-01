Return-Path: <linux-kselftest+bounces-42655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B1BB0B0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4328A3C82E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490425E44E;
	Wed,  1 Oct 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4YGdh45"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953948CFC;
	Wed,  1 Oct 2025 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328596; cv=none; b=geN7I6k18IaRb9VIM2OyHKpEyEoifnyN9Ool55x/XGWTSXNOaShp6weKp9g197mM4ngiANCdA4devZid/4frr0973u7Y8RerHAt/5T5YrCEQOHBV+rJRSnCORBRysC/EEfk1iWMxLl0Jpnufo9u9FYDuSxGqfWnAdWhU0YeiLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328596; c=relaxed/simple;
	bh=v0msVvEXki4VSloaosqyyuTSkXQRWNLTLuPCaVMUF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqNLLQft7Av+vILxZVqMIuMkwkJofJIvlPO7sbi4BUd0vlNcBFGHVFUj9QYHtDEuG0J6LdWOZaHyQeJroPzDFUo+XgRf1uEBDbf3TvIvWqO+rvjwp42byWfs2mZVRgIIGZjkqOTfePjLSXLMGnFUZWnPxDE/8SEU/bbLzPM3cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4YGdh45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB505C4CEF1;
	Wed,  1 Oct 2025 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328596;
	bh=v0msVvEXki4VSloaosqyyuTSkXQRWNLTLuPCaVMUF/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4YGdh456cOH25wO9qXrkQEjFfV2/qeA8B1ANtaQnKDNix5zdJNZbVa80eajpkYCt
	 tmXvA9kVkUwNxpF07chYBwnFs3m6J30H3cw202gtsgp3hLAKloQ+jiTV4C6iMqdg/a
	 UJp0seAQgxiBSNk7PF5OXq1TnGthwb2byQ6PmDn4XlScq0vZi4GaSEicHxKfE4kWBW
	 Phumzk+ewjWWtM34T+7PqrSfstwjOwM0xLqSpc3v3+fuOs4U014R5hoL7dODbudPJc
	 odXG6yLEaiSmlzNVuKZEuhzPVDDCV0VE2RM7u9TzwryZJsuHeVjrqXv7ta9wqUkjB4
	 HTmOG5tXuTjCg==
Date: Wed, 1 Oct 2025 22:23:09 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: dan.j.williams@intel.com
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 5/7] revocable: Add fops replacement
Message-ID: <aN05TFvhPPj5voUD@tzungbi-laptop>
References: <20250923075302.591026-1-tzungbi@kernel.org>
 <20250923075302.591026-6-tzungbi@kernel.org>
 <68d45a76a36ad_1c79100a6@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d45a76a36ad_1c79100a6@dwillia2-mobl4.notmuch>

On Wed, Sep 24, 2025 at 01:54:14PM -0700, dan.j.williams@intel.com wrote:
> Tzung-Bi Shih wrote:
> > +int revocable_replace_fops(struct file *filp, struct revocable_provider *rp,
> > +			   const struct revocable_operations *rops)
> > +{
> > +	struct fops_replacement *fr;
> > +
> > +	fr = kzalloc(sizeof(*fr), GFP_KERNEL);
> > +	if (!fr)
> > +		return -ENOMEM;
> > +
> > +	fr->filp = filp;
> > +	fr->rops = rops;
> > +	fr->orig_fops = filp->f_op;
> > +	fr->rev = revocable_alloc(rp);
> > +	if (!fr->rev)
> > +		return -ENOMEM;
> > +	memcpy(&fr->fops, filp->f_op, sizeof(struct file_operations));
> > +	scoped_guard(mutex, &fops_replacement_mutex)
> > +		list_add(&fr->list, &fops_replacement_list);
> 
> This list grows for every active instance? Unless I am misreading, that
> looks like a scaling burden that the simple approach below does not
> have.

Correct, unless we want to embed the context (e.g. struct fops_replacement)
into struct file.  FWIW: the issue also listed as a known issue after "---".

> > +	fr->fops.release = revocable_fr_release;
> > +
> > +	if (filp->f_op->read)
> > +		fr->fops.read = revocable_fr_read;
> > +	if (filp->f_op->poll)
> > +		fr->fops.poll = revocable_fr_poll;
> > +	if (filp->f_op->unlocked_ioctl)
> > +		fr->fops.unlocked_ioctl = revocable_fr_unlocked_ioctl;
> > +
> > +	filp->f_op = &fr->fops;
> > +	return 0;
> > +}
> 
> This facility is protecting the wrong resource, and I argue hides bugs
> in drivers that think they need this. That matches the conclusion I came
> to with my "managed_fops" attempt.
> 
> The resource that is being revoked is the device's attachment to its
> driver. Whether that is dev_get_drvdata() or some other device-to-data
> lookup, that is the resource that gets removed, not the fops themselves.
> The only resource race with fops is whether the code text section
> remains available while the fops are registered, but that lifetime scope
> is not at a per-device instance scope.

revocable_replace_fops() doesn't protect any resources.  It replaces the
fops to revocable wrappers and recovers the fops when the file is releasing.

