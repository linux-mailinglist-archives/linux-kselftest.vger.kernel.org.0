Return-Path: <linux-kselftest+bounces-221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D308D7EE20B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822381F2458B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2230F8C;
	Thu, 16 Nov 2023 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWuN6oCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DA30F83;
	Thu, 16 Nov 2023 13:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF8AC433C8;
	Thu, 16 Nov 2023 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700143157;
	bh=oreDXTUFD1p7EOCadmsrNnBKYaZXlHAjodag6YCr5sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zWuN6oCTXkMwNE1HalrHk0dL6JJ8Ftpu1Xvijzw1uQn9ypVpax/WXZjD1QFBmkLsE
	 7EEYSUUDX3B6/9BC9tYRVezGFj/V60Xt3IvQSHsbl9/N1ZBVfWPhyqCgJPwPbFkMMy
	 sMUma/KePpFUutEufuw34VLxQDJI4skUef9Rk+/0=
Date: Thu, 16 Nov 2023 08:59:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Charles Han <hanchunchao@inspur.com>,
	Linux Kernel Unit Tests <kunit-dev@googlegroups.com>,
	Linux Kernel Self Tests <linux-kselftest@vger.kernel.org>,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <2023111601-unsecured-decode-3fc1@gregkh>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <ZVYXEry40HTCis00@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVYXEry40HTCis00@archie.me>

On Thu, Nov 16, 2023 at 08:20:18PM +0700, Bagas Sanjaya wrote:
> On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
> > Make scripts/checkpatch.pl ensure any added V: fields reference
> > documented test suites only, and output a warning if a change to a
> > subsystem doesn't certify the required test suites were executed,
> > if any.
> > 
> > If the test suite description includes a "Command", then checkpatch.pl
> > will output it as the one executing the suite. The command should run
> > with only the kernel tree and the regular developer environment set up.
> > But, at the same time, could simply output instructions for installing
> > any extra dependencies (or pull some automatically). The idea is to
> > get the developer into feedback loop quicker and easier, so they have
> > something to run and iterate on, even if it involves installing some
> > more stuff first. Therefore it's a good idea to add such wrappers to the
> > kernel tree proper and refer to them from the tests.rst.
> 
> Does it also apply to trivial patches (e.g. spelling or checkpatch fixes
> as seen on drivers/staging/)?

You are assuming that drivers/staging/ has actual tests :)

