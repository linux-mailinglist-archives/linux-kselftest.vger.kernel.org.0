Return-Path: <linux-kselftest+bounces-41258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D4B53A5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38527B402C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36732274C;
	Thu, 11 Sep 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn2SmYc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D8288D0;
	Thu, 11 Sep 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611631; cv=none; b=G5NXiJYC3UGkBLTXACFgMmqs3q34fb1xzHlrO2LFv1Qewwfiszz3KRVfEj1oRMkhDi2b2i0od/U2CHI3Gfes80/vcTgzsryEoFg6czz8MpdgCwyrb2Q6NipWPBX50eXViv7LXZ9quyBzlXHZcEYT/l+n7jwE8kuCV6WsKbS1zbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611631; c=relaxed/simple;
	bh=xPLOGf61wh2KeY14Y9+f+chSdVXc9yDvHz91k43cG1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK/IIU0u88fyFX3ZSnRBKwycuF0+8HSxl0GvS2zz/w0ePVyUqfoeLxCKdnQarNDbyAGil06srW6jRzF7B5XGNQrOn6vvot3j/S/2oeCk/ssSDSPYHGHYSGweBX1jZqMtqpjh22xuuMyc3iTRPAgAHgPsKyyBvDfw5taV0pqYv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn2SmYc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888D8C4CEF0;
	Thu, 11 Sep 2025 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757611630;
	bh=xPLOGf61wh2KeY14Y9+f+chSdVXc9yDvHz91k43cG1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jn2SmYc7xPpjzlS0mD7jSRlL1uQRkdmjFmF3q9mEMb+KerVTKHOgesHHJW/LTEErK
	 sP5J1QUBvZDMDB8bh5wxC8/hyIUZI3yJqzRpDzJGSP9zDEZdJ0c8N7epFcs61/rb0k
	 lL/S0wk31IxdjnTFettd424Rtr6wAl3vdnovXDoXlDJvtyyy4gL6mSyTyBtWAY6lPg
	 jfy4okI1GRMZVxWATv/JNQ1bRFPbs8XpRIc5OeLZ6bXOCDZ+kFK11axfmvGEqnhmNX
	 wi4fUkUKtVpEs08HxQO+giMjykPdScg7eKwu2fzRHbZsIfjYqs1QDWh43xGOBrUnhJ
	 FtneybzRxz6fA==
Date: Thu, 11 Sep 2025 18:27:06 +0100
From: Simon Horman <horms@kernel.org>
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
Message-ID: <20250911172706.GR30363@horms.kernel.org>
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>

On Wed, Sep 10, 2025 at 07:30:32PM +0800, Nai-Chen Cheng wrote:
> The selftests 'make clean' does not clean the net/lib because it only
> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
> compiled objects in net/lib after cleaning, requiring manual cleanup.
> 
> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
> dependency is properly cleaned.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

