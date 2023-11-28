Return-Path: <linux-kselftest+bounces-706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFDC7FBD45
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F3F282E1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFFE5C074;
	Tue, 28 Nov 2023 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDEW4XCa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37505ABB7;
	Tue, 28 Nov 2023 14:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF618C433C8;
	Tue, 28 Nov 2023 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701183220;
	bh=s13LC6ZqOcgJuEDiOYtPEnnI1TIenYkNDeB6eVAchC4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=aDEW4XCa8SiymRXB0L2NQ5E/+Z5gKrj4cHbcCIsyw7DORAnxXmZVmpk8OhkjlxD5X
	 0RJwRQv5oQWvY9qXn+Ln8lTjUILh7algqre7fmf5Gyxt/hEeynyGo0dvSx8ZUxLgl8
	 mDk4PI3DUrraphNasAYxBhreq6Mb1w578WIHfGuHv1WXFDMuM6t79iTC9/cTFYgpac
	 81etA5a0+Y3W330lqFDudyhlfDUy/Ap08JhnQoctVgVsWcQWlIXnhzmQFoPbLSQ0v8
	 HzOVn8mKmHWH5vauMeR4wYHPUgKmgbbxFQ+bvwEr0m7+bLLziJDHTdQWCNpn0bYAeX
	 qHut2Jwff8t5w==
Message-ID: <0977ffcd30973d0edc1ae4132216b094.mripard@kernel.org>
Date: Tue, 28 Nov 2023 14:53:37 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "David Gow" <davidgow@google.com>
Subject: Re: [PATCH v2 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
In-Reply-To: <20231128072410.952662-3-davidgow@google.com>
References: <20231128072410.952662-3-davidgow@google.com>
Cc: dlatypov@google.com, kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, "Benjamin
 Berg" <benjamin.berg@intel.com>, "Brendan Higgins" <brendan.higgins@linux.dev>, "Kees
 Cook" <keescook@chromium.org>, "Maxime Ripard" <mripard@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Rae
 Moar" <rmoar@google.com>, "Richard Fitzgerald" <rf@opensource.cirrus.com>, "Tom
 Rix" <trix@redhat.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Tue, 28 Nov 2023 15:24:07 +0800, David Gow wrote:
> In order to pass functions to kunit_add_action(), they need to be of the
> kunit_action_t type. While casting the function pointer can work, it
> will break control-flow integrity.
> 
> vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

