Return-Path: <linux-kselftest+bounces-4374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B252484EDEB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 00:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F512283398
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C15026B;
	Thu,  8 Feb 2024 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgO4IYHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72B50250;
	Thu,  8 Feb 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435282; cv=none; b=lqLPY/7REmvMg/xrxBJFAKXzoY8mU6EuOv+pX94x18gRsr0/jRhd/efY7PLyWbyR3am4FyQgIOV8q4C1g7kjFQNQzHdqa97H1keHcUnx0RMxPKZny2HN3ab7oUnaby53WFO/TkJRgBvNtuX5S1HrEtiKuI5SGMgFVQGDWRT8PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435282; c=relaxed/simple;
	bh=EJ9Wn0iBaNjCd5QKP1Bx0vkFW1Ydx1VBsnaQxF5lcrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oB+KWyXGC4lJ9QvaJbTHxDLiXrjhw4QxtQNYO7v3ssPQswoP1SxgvMAq9j/0nRgSB5c9v82lVwpYYePP8S3ccGqJdgBfpTPdssalWl13uU4mYzklVsnYGz0SPQec/KXHRcOglLS9SRSIqyhHwgk8OeBs+GtYlZtQM8p/Cdm5JzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgO4IYHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42983C433F1;
	Thu,  8 Feb 2024 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707435281;
	bh=EJ9Wn0iBaNjCd5QKP1Bx0vkFW1Ydx1VBsnaQxF5lcrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgO4IYHqabvPBBje1KS18L0mEgBpyk4FJpFCmEBZFITHntLQrNzbrM8/bC0aTkg/U
	 YYuNIi2WsHuJxvwuZ32/NKGDWGQTV4HXeKhFwSXw+xDTcnmhJ/yq1IDIsDWqBta92T
	 uI71U6DDBRb6vlkcOtM8n9Ci3dtyYf1PbKbv/Jl5ufkk3Bspjl+NnzCPEBgXxOiQhc
	 QConIfTSJ+8cgGqbMVwU+msYmjJBc2kSN/cS/OUDoqmfWUKx1Wxz02Vh2XwYjnr18/
	 cBcN6vD1nfPAF751jvOs9YcqTjFeAg2d7CgJ/DwH8ElXvcZtWEc9xQj2Oi2U7oYcCT
	 FFg6WLo5N/bLw==
Date: Thu, 8 Feb 2024 15:34:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: ignore timing errors in
 txtimestamp if KSFT_MACHINE_SLOW
Message-ID: <20240208153440.590685bb@kernel.org>
In-Reply-To: <65c53ed3bbeee_1ca1e229434@willemb.c.googlers.com.notmuch>
References: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
	<65c53ed3bbeee_1ca1e229434@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Feb 2024 15:51:31 -0500 Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > This test is time sensitive. It may fail on virtual machines and for
> > debug builds.
> > 
> > Similar to commit c41dfb0dfbec ("selftests/net: ignore timing errors in
> > so_txtime if KSFT_MACHINE_SLOW"), optionally suppress failure for timing
> > errors (only).
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>  
> 
> Is this still failing after commit 5264ab612e28
> ("selftests/net: calibrate txtimestamp")?

On a debug kernel it continues to flake :(

https://netdev.bots.linux.dev/flakes.html?br-cnt=80&tn-needle=txtimestamp&min-flip=0

