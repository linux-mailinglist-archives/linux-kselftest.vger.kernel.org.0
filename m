Return-Path: <linux-kselftest+bounces-22543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE459D9DC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085EE2871F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73751DE2A3;
	Tue, 26 Nov 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evq0lHqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5C16F0E8;
	Tue, 26 Nov 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647874; cv=none; b=dOgZL+rjFBs1vOzzfVHxaOGOaRI/Z0b4jjMeQ9Y8kOWiWpP6tUdv4AVKOMbxQg2xhCr+eZPMRAq12Mimx5jyAF9PgwIPhLrjaK5lRPnp6sJ/V+Hrhn9Saux/9kC1ZF1xjHoNEb1bTxkAqjhyW92MYX/bmN7EQB5h2KI8p8vmo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647874; c=relaxed/simple;
	bh=E18gfvq447oO7905Vj2Agqf4+xGXFE0FgW3F4b7o0Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM2VlsMQ2Mx9hX8h8cOcCyQ8EkMILUEQKS05a42mzsXSrWaMnpJKg0rJ/UUsCsfso+Fk1/ZVYurpTpVf5pxZyCNNmxvxnYHMU606vSqBhQRYC0+zmwHXrxVyEVfN/DDdTKz655i3W5EoQHmYMYFqFyc48AoiOB5r+/SZOqYK2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evq0lHqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0614CC4CECF;
	Tue, 26 Nov 2024 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732647873;
	bh=E18gfvq447oO7905Vj2Agqf4+xGXFE0FgW3F4b7o0Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evq0lHqQcRyOWBXrClvl/1VAJ8nO2sr/dOC3x1+WlqqujfoTC4ZXYWcwPVbv4gwTy
	 OlIFx9XYY/w/liF5WJE1p42IrMOx2KrHMc6gcnVrLCaJGdyzXSCMo1Mi3Ffdivj0O1
	 MSxb7kSw9B0zNQADgLbAdFyKr7+ucf9mLTvuP+5oVxOYGGyBYq+TzlBq/a/1lF8cry
	 kjXpsCCFcl38DIliPVPFAu7C3QUHNhlXNxNLrbh6SfwA6rlyZiGebaMp+rsDBmB+8s
	 NYM60vsi3Lia2B4/GrzeutZhCFQLYqENG5UBcXrNqz6UM1R3KMgJwguPZ3yyThIUSi
	 iYwe37ciSIjJQ==
Date: Tue, 26 Nov 2024 11:04:31 -0800
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
Message-ID: <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>

On Tue, Nov 26, 2024 at 11:25:07AM +0100, Roberto Sassu wrote:
> On Mon, 2024-11-25 at 15:53 -0800, Luis Chamberlain wrote:
> 
> Firmware, eBPF programs and so on are supposed

Keyword: "supposed". 

> As far as the LSM infrastructure is concerned, I'm not adding new LSM
> hooks, nor extending/modifying the existing ones. The operations the
> Integrity Digest Cache is doing match the usage expectation by LSM (net
> denying access, as discussed with Paul Moore).

If modules are the only proven exception to your security model you are
not making the case for it clearly.

> The Integrity Digest Cache is supposed to be used as a supporting tool
> for other LSMs to do regular access control based on file data and
> metadata integrity. In doing that, it still needs the LSM
> infrastructure to notify about filesystem changes, and to store
> additional information in the inode and file descriptor security blobs.
> 
> The kernel_post_read_file LSM hook should be implemented by another LSM
> to verify the integrity of a digest list, when the Integrity Digest
> Cache calls kernel_read_file() to read that digest list.

If LSM folks *do* agree that this work is *suplementing* LSMS then sure,
it was not clear from the commit logs. But then you need to ensure the
parsers are special snowflakes which won't ever incur other additional
kernel_read_file() calls.

> Supporting kernel modules opened the road for new deadlocks, since one
> can ask a digest list to verify a kernel module, but that digest list
> requires the same kernel module. That is why the in-kernel mechanism is
> 100% reliable,

Are users of this infrastructure really in need of modules for these
parsers?

  Luis

