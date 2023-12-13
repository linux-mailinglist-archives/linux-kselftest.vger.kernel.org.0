Return-Path: <linux-kselftest+bounces-1842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54989811582
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C061C20E14
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EA2F859;
	Wed, 13 Dec 2023 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSo1JyPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEB2EAFE;
	Wed, 13 Dec 2023 15:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F8C433C8;
	Wed, 13 Dec 2023 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702479785;
	bh=ERYPWlZcuAsc3JTXR2wiRcqYpvAqlyOmPFSh5X5mKMU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=OSo1JyPIEEiOqSQkxHZc0rW9gEY26xIxY2pFyOxbAqRhG/rDBaAxtpEvgzIC3a3pt
	 BOTZ1qII5VJxtazr9MqP8EACT+Y10dkh0nTg/2zbkGhXa39zOHCp0lS2agt9gVpSUA
	 CltxBEF/1zLz9K6yQKhdzCOxewWh1wdpeSegUeTuIg7GJzS/3k3qz+1WtZ7QogvGzF
	 xVziHZ9wNt/ymRn/TJmviMnMb+ThIlYT9UCT3XrJ4PtKzjYsjv5K19rJ/CRjLpihym
	 bUxdTZmbWd91qtxA4hOgs52zd4GHLQMWjdLK6nitFMxSRK908BKfPZqXp/RqsI97M0
	 /RT3giJthg+FQ==
Message-ID: <09db7e8dadfa5d73bdcbf2f6c6af9fbd@kernel.org>
Date: Wed, 13 Dec 2023 15:03:02 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: davidgow@google.com
Subject: Re: [PATCH v2 1/4] kunit: Add APIs for managing devices
In-Reply-To: <20231208-kunit_bus-v2-1-e95905d9b325@google.com>
References: <20231208-kunit_bus-v2-1-e95905d9b325@google.com>
Cc: kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-sound@vger.kernel.org, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jaroslav Kysela" <perex@perex.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Kees Cook" <keescook@chromium.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, "Maxime Ripard" <mripard@kernel.org>, "Rae
 Moar" <rmoar@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Stephen
 Boyd" <sboyd@kernel.org>, "Takashi Iwai" <tiwai@suse.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Fri, 8 Dec 2023 18:09:29 +0800, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

