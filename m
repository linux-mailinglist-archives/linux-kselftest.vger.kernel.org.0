Return-Path: <linux-kselftest+bounces-30886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E8EA8A506
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B22B4418B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A17218592;
	Tue, 15 Apr 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MASYSJPz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4F163;
	Tue, 15 Apr 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736992; cv=none; b=dnx9gYfse2br56zyUdw3m5BRLfz+rFH7P8gUxOCJATyavQVHh4gOMuHZlbx5MUqi3iBe11dBemmahGLhue3eaqwBicUunh5bJyEUbPukauyJgouUt/QCNJA9fqDhGP3cLK1bojn+EcJ+922eIxL2UFxOLU3Wua3Cf2R5CrK6U58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736992; c=relaxed/simple;
	bh=MTxGoC4BpioZcRWG/zm7Kk5SqdnGqA04/C85BpU85ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqRKvNswDuO1dGguWPgrTb18qQCjE+HoHL0IkR+EFRxL+1J0GgM4QarWteHGuP7rhrjTQmr/vtJ4UKJvEG3tjqgARsgLS49dE9TsB60gd02rknmRx71CXqBB5qa/y5Y6vWLmje+dr2TFqwAc9XoTZ8n4gM5h7KD1Ricgf2ibiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MASYSJPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB59C4CEE9;
	Tue, 15 Apr 2025 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736991;
	bh=MTxGoC4BpioZcRWG/zm7Kk5SqdnGqA04/C85BpU85ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MASYSJPz+lAlRc2CEVdeSjmxxQarSAxWrd8v5UVp202CkYT1f79ktOgjOefk/q1cO
	 rs8qyM+ROx9RuuhnKnEi7E2U0CrwXITzDEB2+fh+N7wo3O6qe2Sm84PVEGBI5Tt8Nx
	 ptuZpYp+YPXIA6smMj7AMsr3BOuBBGAa+Y/pHzmUulW9TGCZFtXpv+vOWF8getNtgI
	 06uW5sQxSJ9y/AM++RQa/VRWwO+f49a0TEbszOc8py9gOtk+uF+yTVlbghjY/dVzdM
	 Uw4/sqCbxj4tGkIiHI2ZXCkwUT6on/XezwRAchoCo1Mb9biKdpC/mkKUFv9tYZ2W+Z
	 FTCIGOlAWxnng==
Date: Tue, 15 Apr 2025 10:09:48 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] kunit: tool: Implement listing of available
 architectures
Message-ID: <202504151009.DC4EBC7BE4@keescook>
References: <20250415-kunit-list-v2-1-aa452cd317ae@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-kunit-list-v2-1-aa452cd317ae@linutronix.de>

On Tue, Apr 15, 2025 at 09:03:06AM +0200, Thomas Weiﬂschuh wrote:
> To implement custom scripting around kunit.py it is useful to get a list of
> available architectures. While it is possible to manually inspect
> tools/testing/kunit/qemu_configs/, this is annoying to implement and
> introduces a dependency on a kunit.py implementation detail.
> 
> Introduce 'kunit.py run --arch help' which lists all known architectures
> in an easy to parse list. This is equivalent on how QEMU implements
> listing of possible argument values.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Oh nice; I like it! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

