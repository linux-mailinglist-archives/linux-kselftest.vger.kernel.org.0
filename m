Return-Path: <linux-kselftest+bounces-15801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24C959159
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389F41F2380E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B771B8EAE;
	Tue, 20 Aug 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+Fj2QQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDA18E351;
	Tue, 20 Aug 2024 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197808; cv=none; b=pNgg0f9I5dssIeea4CdWt8E+jDdp49gCgXZfsEKFFG9pkJpxGnaEmBkkae+xTLpNpvfrNhUjrKSvPgZDog+14ac/NIV52rAMDFtsbHGDrKmSYKQNzUUzsCv3WTGnNT6ByH/TfvHDEUeVHlRBUtB/BBwGa2mA0uUU0zeZZyka9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197808; c=relaxed/simple;
	bh=1Y8VPSJPTcMjRrF5SWBm65dCgzJpNsJleTBgewKTYrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+AE/oU488nnGaI+Fp0KhZxjxLvEoZWciY6aytvTPMZH/sZC8Sk+Fra+nuetwyPp/LBPSMV0jGHhg213Hce6WZ2pnsPuVViykgVISwk9N/oPTz9SU2NAFSixZ+L555v1NOvmcHgOadjIsAgeka1Sh6ooR7Kz6QRxLNdd1Zk7NhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+Fj2QQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E6C4AF09;
	Tue, 20 Aug 2024 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724197807;
	bh=1Y8VPSJPTcMjRrF5SWBm65dCgzJpNsJleTBgewKTYrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y+Fj2QQwo7kFOyEwhd7cKgwnITNolAcC0kfAvrwJS/Ifi0EoQAFDFCMJxnEcPqWVY
	 QZ0p8z7ve45ly4v6rXqAPp68tm8iFcnaxpCEOo9hiPy7g4sA1xWqC6e6iZYUiwl8wq
	 d/DGcTqZcEqlOQs1DZ+0i+6zGoLYe7toyoH+s+56+vgXokoKr6bdMUx/VV9QK+M2rU
	 0G3TQMpb/b096i6emh/J21ZmlybXFNgVK3biH7UqAUU1YiQdpAQjboR5ad2iwTTjPV
	 znuz2+8j+R3XYQUjqbHB650PrqgYlDtNHo67MnvT2CrU2BsIXPBNzd13Qw0VZ3lL/i
	 zmoWBLiUL6tUQ==
Date: Tue, 20 Aug 2024 16:50:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for
 testing in networkless kernel
Message-ID: <20240820165006.4b6c8e44@kernel.org>
In-Reply-To: <20240819121235.39514-2-jain.abhinav177@gmail.com>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
	<20240819121235.39514-2-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 17:42:33 +0530 Abhinav Jain wrote:
> +	echo "veth0" > "$TMP_LIST_NETDEV"
> +	echo "veth1" >> "$TMP_LIST_NETDEV"

Why test both ends? 
Aren't we going to do the same exact test twice?

