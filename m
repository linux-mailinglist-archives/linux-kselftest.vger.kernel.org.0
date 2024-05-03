Return-Path: <linux-kselftest+bounces-9352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688DE8BAAE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242BD282941
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED61514EC;
	Fri,  3 May 2024 10:42:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842201514CD
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732952; cv=none; b=LF6O0MZfJQB6aopIBtwdmbR1fD7vX61kVQlF3n9nm4jTAtAAsEL+hVBJRmIbmA8VV60SVL/jSMuacNJfmdE4cEcVfXoPpUjbp2acCe1RrnHUiMxVA80obIhXDUXifASMFWb9zHCAeJqa/4QQ8mxfYwD1l6MC8knI65MNPGjrtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732952; c=relaxed/simple;
	bh=4B2TlPDiESp22hsGJx9RvmqzAQxJHwdIawyvCeWnOUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V5mFF8cZUaHjPqpQ9/G9PcbkOhGfFhDnH7iDG1zd7flEG+e3obBRykWe8EA/M6+u4JhWMr8Va/3GILsRFj4FXcCutBMqGqPyut7TLyojJQ8FstWrwbNZOG9c1cimkzoiQHStLV1xISU6QOi/m8NBVmpIJJH5EClHWhjf70agpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6nc3jsxz4xFg;
	Fri,  3 May 2024 20:42:28 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, shuah@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20240229093711.581230-1-maddy@linux.ibm.com>
References: <20240229093711.581230-1-maddy@linux.ibm.com>
Subject: Re: [PATCH 1/3] selftest/powerpc: Re-order *FLAGS to follow lib.mk
Message-Id: <171473286290.451432.4486404094591945834.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 15:07:09 +0530, Madhavan Srinivasan wrote:
> In some powerpc/ sub-folder Makefiles, CFLAGS are
> defined before lib.mk include. Clean it up by
> re-ordering it to follow after the mk include.
> This is needed to support sub-folders in powerpc/
> buildable on its own.
> 
> 
> [...]

Applied to powerpc/next.

[1/3] selftest/powerpc: Re-order *FLAGS to follow lib.mk
      https://git.kernel.org/powerpc/c/37496845c812db2a470d51088a59ee38156e8058
[2/3] selftest/powerpc: Add flags.mk to support pmu buildable
      https://git.kernel.org/powerpc/c/5553a79387e92ffd812a49fdcf679f392281f6a9
[3/3] selftest/powerpc: make sub-folders buildable on it own
      https://git.kernel.org/powerpc/c/108e5e683333615023265a9a73a29d4c2fa16c70

cheers

