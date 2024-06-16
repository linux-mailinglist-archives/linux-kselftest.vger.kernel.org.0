Return-Path: <linux-kselftest+bounces-12024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69771909E8E
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8AD2814A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177EB1BC4B;
	Sun, 16 Jun 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6CdWl53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C11B27D;
	Sun, 16 Jun 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555391; cv=none; b=G4CSPBPU//SpEE+nZlny0KC6txDvBQlBlkBYYXFWNBCTjP1gruq/si2j+Qks8goRaPbbM97OcDkR8lHHLckh6nk+QAyScIcz4JWTTAb0HHJNLkjUdin6G5Q1ys+RQO3MSszzGKlbK9gDKfZ6vnuBbCfo8PJD+4jACKg29x0m+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555391; c=relaxed/simple;
	bh=4Y/E6RxkTEYNMIfKk+59HnDcld53CGZNkpQPW+AuQl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTlZyGoAM6JO0ybFa/hpfZxevwpPwmXsA97BUChu3lzxh/C9x051XsmQCzqDtLEB3wZRNjoz6/IwVaPakXj+3u3eF+2yheXpaYlA+7Kv9fcNAfMEK9EZbZKSgPtkcLrcMjusUX0hFzlsn2LrqBtOZfM2SX7S5X2eup/NE98dELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6CdWl53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2964C2BBFC;
	Sun, 16 Jun 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555390;
	bh=4Y/E6RxkTEYNMIfKk+59HnDcld53CGZNkpQPW+AuQl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6CdWl53xMpuEU/Oz9BuKVD4umx4vKLNdJA8ebdHXy6GmL7G5BqP6G+4t1fgkX9Bv
	 kZpocaSNCYEiYvYaExO0esoE5aURDY6mBB9QIHE7UUWSQupf8V4GYfZDTx9AB4HOBr
	 EAU9t42RQ1IYZG/ut7UPlay1+WWiVoHLfmpjMrdPVYKfHuGyYFoRA7RUM89KfjMRXt
	 QzOPLiEudZD072NCUyWQKz+Lfefq66KDaAGjfdeai4Zt3BH7NSDhTsYsekg4f3Y6ET
	 qjI9qNXBjEdf/EVt5Ugai3RroNKn/V2aiRdlJGJO74f1ltjiScZQyuZKKnr1NqhJg1
	 XyLkGXKywX/IQ==
Date: Sun, 16 Jun 2024 17:29:45 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 3/7] selftests: openvswitch: Add set()
 and set_masked() support.
Message-ID: <20240616162945.GM8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-4-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-4-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:29PM -0400, Aaron Conole wrote:
> These will be used in upcoming commits to set specific attributes for
> interacting with tunnels.  Since set() will use the key parsing routine, we
> also make sure to prepend it with an open paren, for the action parsing to
> properly understand it.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>


Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

