Return-Path: <linux-kselftest+bounces-41653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB8B7D904
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02740483EF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C931E7C2E;
	Wed, 17 Sep 2025 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATmbDyVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A772614;
	Wed, 17 Sep 2025 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086681; cv=none; b=BZY0E64DFrk1xrrW1LenhI15b2RcNUpp/+kQpfqMtsbGoc9bo0blylk9khbhXtzGXXm4KrRbQQmBjVNNjLG0lAT2cNOefS97ZlB91e8LucEqD1Tusa25d5AnjGSjyChvAG246EQsOX38oWt+JUFXT+nezKplJJNm1xXFWSjh60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086681; c=relaxed/simple;
	bh=hC8OfH0upO2tWZ/vj30OsQiqM/inNpI8faJFzeMwnTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJQHM4TFDdEoDNvupGzsB1NvCfX4jbF9ssPXG4zqgK0bk9Z1HWOgKesEkZdmt5aj6NSZ2HCHA/rtasj0DSD4n5j7ZXSUpys3ueCjH1CYQRXYQEvBKAnf+Xj048fEsRpv+17Rl3okHq25LXFztBmx2MJrq6BK6YY+K+TQZKuXk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATmbDyVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A09FC4CEF0;
	Wed, 17 Sep 2025 05:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758086680;
	bh=hC8OfH0upO2tWZ/vj30OsQiqM/inNpI8faJFzeMwnTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATmbDyVb8jzVUmoXm+PzTLsARTy0oqxTSNFIFgp3QqxFMJJoJuvrXU9XcMk7SRlis
	 N0wQSeALrTnx4sHc5N4jThpvKNgg14OUNUGmTbBavjRdkJhhhXPlSuu0lM3TVHhNAj
	 livMs3ZTXH4oOS2l2z7/ITAZ4Z7WMWUa02Z9mP7L56V++mofG04DHcfoqm3zDPUcd/
	 sX4nM7DtwUEAgbNTxYDsa9n+Dqu38HR/Xx3BxOWSICR87PHPCXJi11PXHiZkZrSWll
	 IGm73YjWGFoSQw4VRLNkp4q9RjJH+NEKwGfGxbudQ7KA0E0CpzmWtHqbrLcwUwd9ow
	 L5DhAGzWTqqdQ==
Date: Wed, 17 Sep 2025 05:24:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] revocable: Revocable resource management
Message-ID: <aMpGFXII_WGviShc@google.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <20250912081718.3827390-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912081718.3827390-2-tzungbi@kernel.org>

On Fri, Sep 12, 2025 at 08:17:13AM +0000, Tzung-Bi Shih wrote:
> +void *revocable_try_access(struct revocable *rev) __acquires(&rev->rp->srcu)
> +{
> +	struct revocable_provider *rp = rev->rp;
> +
> +	rev->idx = srcu_read_lock(&rp->srcu);
> +	return rcu_dereference(rp->res);

Got a warning from lock debugging.  This should be srcu_dereference().  Will
fix it in the next version.

