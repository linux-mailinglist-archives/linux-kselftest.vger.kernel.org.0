Return-Path: <linux-kselftest+bounces-25848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA30A28B89
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92E71881739
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4A524B0;
	Wed,  5 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOjWUMpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4D1FC3;
	Wed,  5 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761676; cv=none; b=HBLJ/UatZ5+//yjsVVgMaZ5798fCsvqydkX49yQNsdokfTFx4N5/Th+C3zrRJ1qFfEF7xDh4+vKgOprDnRYzbBnY/se4IgwAPgORF7zHCnnXaIEnjqAWvxY2o8qoPVs7aPZxIhPnJLSxsGXu2rC4AUN90GL0xxnbRceTdfERWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761676; c=relaxed/simple;
	bh=mKANO8CJJZYbPi2P74uf8bwuYp59ycVKMSulOmI+IOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjDQHKJez2jAploPjC7znWOHbBAoLnesx1xuVN75hOVmMP7urG8Hav3WWhkud3d4I28gR07uuYA6h+frXOFp3BWnexNQIa3f+4OrmH8HU1CoQ+MRvEA/deNf9DFHzyFLfSmfrxgrnWFjyUn0xYKNJcs1kQQ3Vhaj85WHHb6i5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOjWUMpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F9C4CED1;
	Wed,  5 Feb 2025 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738761676;
	bh=mKANO8CJJZYbPi2P74uf8bwuYp59ycVKMSulOmI+IOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOjWUMpiVKib/fAUm4fXJ3IusGRI+DUPc2b921KzbUZIIxMatpZU1d3WUWX6mEgPf
	 5p8KVtJT6wsotnrxhKMqbIdFg2AJBMazH4vAzaBvxpt5XluSaka+0IqZO3lHno5e4E
	 jQFIy6maGxEq1T/zqJgI2pMWnCOSL8IMzYy2ExtBp+dIy93Odp0jWdiTA9eun3oudj
	 RipOfaosP7tiRrY246h/eIPmMG/ikuu3v7wQrGJNPxOItMMG5Ss5vUWRi/1XsayXrV
	 7aWptPBl5NbE3qM9PLNwHeGe2LWqoZAK/C7ggHbdjaOexgwYk6LtU/RrCLckBYhmDM
	 YVVhQG0mjTt7A==
Date: Wed, 5 Feb 2025 13:21:11 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: suppress ReST file generation
 when building selftests
Message-ID: <20250205132111.GB554665@kernel.org>
References: <20250203214850.1282291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203214850.1282291-1-kuba@kernel.org>

On Mon, Feb 03, 2025 at 01:48:50PM -0800, Jakub Kicinski wrote:
> Some selftests need libynl.a. When building it try to skip
> generating the ReST documentation, libynl.a does not depend
> on them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


