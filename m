Return-Path: <linux-kselftest+bounces-22518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15D9D8F55
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 00:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A0B28AFD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DF1C07C8;
	Mon, 25 Nov 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhzcJKQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88B18DF93;
	Mon, 25 Nov 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578809; cv=none; b=OodHxDxeRxktYjRWvfkZQj2ZARwxI0jQ4yMOXIeH34ak6z/fZv4yjHYZhHiGaVu9ckTeTftrqNbRh4PjWJoP+2q/1XrTlieyhip9dHvZ8Zs4mdPv892LZYGXrato9iX70Saxd++j5o0i9j0wOAmK/hMUNESM+2HqTlGd/ruimvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578809; c=relaxed/simple;
	bh=rFUNPbzQlq88yUnuIXu1GlgkAuvdh0NSAiK2v1NpN/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6kiGPus38XkEeFh6QBnXzBCd2D37poWMPPBp6ZlWXyc7GGqIKQRUtAbq6WLhFhxzaez1EUrc0xnaWw3S/awfgqMUc8QyC7uIEMlEViKuZkdnehqPghjOinrV3Yj0LbL9o1HMzXf34YdhvNOO7q3XTqupnarohljX+lvk+CHeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhzcJKQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553D5C4CECE;
	Mon, 25 Nov 2024 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732578809;
	bh=rFUNPbzQlq88yUnuIXu1GlgkAuvdh0NSAiK2v1NpN/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhzcJKQcyFCUtosPxA+fxXKVzVwR4Vkwbo6QZyWXGiFw8yo9yb3mm94PD1VjqWv5W
	 /OtRDdB2tST/ixbp15laVL/v2rNiInFajj2iwkx7M/NM/tTSG9DKHh8zJQYpnFmP7O
	 SCW4o5ZMD37qIHr2rq7jVi9K4f04PWnR3Vqtg0e+ywUGH29iOmTrI/pHCiULi/YpXE
	 esTZD4gBlY8jiGnH4ws4QeI1T3ro3CF4bi568anQt56mASop4f3LrJuqjgfVk88OAb
	 2QoGVKi6RGtwOlbSjgza6CrRBRoMo1W+7YxTleKhIEXy1Cy2FVVOxfVePtny/I/wth
	 HBOpG2FQSS/Pw==
Date: Mon, 25 Nov 2024 15:53:26 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, corbet@lwn.net, petr.pavlu@suse.com,
	samitolvanen@google.com, da.gomez@samsung.com,
	akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
	mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
	dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
	ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest list
 parsers
Message-ID: <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>

On Tue, Nov 19, 2024 at 11:49:14AM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> Introduce load_parser() to load a kernel module containing a
> parser for the requested digest list format (compressed kernel modules are
> supported). Kernel modules are searched in the
> /lib/modules/<kernel ver>/security/integrity/digest_cache directory.
> 
> load_parser() calls ksys_finit_module() to load a kernel module directly
> from the kernel. request_module() cannot be used at this point, since the
> reference digests of modprobe and the linked libraries (required for IMA
> appraisal) might not be yet available, resulting in modprobe execution
> being denied.

You are doing a full solution implementation of loading modules in-kernel.
Appraisals of modules is just part of the boot process, some module
loading may need firmware to loading to get some functinality to work
for example some firmware to get a network device up or a GPU driver.
So module loading alone is not the only thing which may require
IMA appraisal, and this solution only addresses modules. There are other
things which may be needed other than firmware, eBPF programs are
another example.

It sounds more like you want to provide or extend LSM hooks fit your
architecture and make kernel_read_file() LSM hooks optionally use it to
fit this model.

Because this is just for a *phase* in boot, which you've caught because
a catch-22 situaton, where you didn't have your parsers loaded. Which is
just a reflection that you hit that snag. It doesn't prove all snags
will be caught yet.

And you only want to rely on this .. in-kernel loading solution only
early on boot, is there a way to change this over to enable regular
operation later?

 Luis

