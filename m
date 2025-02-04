Return-Path: <linux-kselftest+bounces-25690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2949A274C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F267A2919
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC682139BF;
	Tue,  4 Feb 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDO3ZUZZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B713C3F2;
	Tue,  4 Feb 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680348; cv=none; b=A+mDDDhFoHpBqgjgKpoEeFzEF8tP2mC+5uuOk4Qztgk62wqeJSHj5qkTvQ6PFIVOZke9cs0vng5z+PZ6pTa/kzkN355ON1R9AYZbYQcF6ClZjNaW/QWQRQtdHyIyyobp8QMa4YCInSLneh5Z0440vzMtHT8z81oJLZJfTGQLTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680348; c=relaxed/simple;
	bh=RVboHX5boTaireHUXD7iHP1YjPmYbIqMOxSJBsKmGMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6Z1i+LqWOcO5CvX8g/WLp4y3DFuQNJRb6NJAv2jyLMvB0HeNhgmcna6Ek+a63IpXkYnT0YVWIdY/FmGZp1pZfkeDi/GRiPdxSDhLVIGOTATKcqdHbKt7uIYloJS8Fn9C7XDUmqFMIAwEwxnOotjmGYm8K0vY+IOn/Rrfw7cUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDO3ZUZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C888C4CEDF;
	Tue,  4 Feb 2025 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680348;
	bh=RVboHX5boTaireHUXD7iHP1YjPmYbIqMOxSJBsKmGMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDO3ZUZZN2iaPy3VOtU8XkyzaO/hQglQy3LjWfM/HrdJmp2Dxc7+YS5GQ87Bwz86C
	 Pqb3XK+Kyb0nMu95dfZscPI0Y35QtfXKrajJTIDAEfo8tKOKlaErWtB5yOqHAyr287
	 i2MPgZZk6RBIG/Lli9S3p8EkNCjQd8Mi4/28Wk/FbZ4S5fbhckY1MvxCy/RgAfeqYT
	 QnkBrZ2s7/Hs/v4NBUOsj1fOmlkLCRGVop6coRyRGEkSWkqqgq64+3lJdnhm21hBGO
	 ZZHeHYqrzcgdMXts/EEd9645+JW2xhYwQQ2M0aFyjfpQ9pk0aViIWFllEDKmgngq+k
	 iSk6HdSMe73uA==
Date: Tue, 4 Feb 2025 14:45:42 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 09/10] net: pktgen: fix mpls reset parsing
Message-ID: <20250204144542.GL234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-10-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-10-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:02:00PM +0100, Peter Seiderer wrote:
> Fix mpls list reset parsing to work as describe in
> Documentation/networking/pktgen.rst:
> 
>   pgset "mpls 0"    turn off mpls (or any invalid argument works too!)
> 
> - before the patch
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	     mpls: 00000001, 00000002
> 	Result: OK: mpls=00000001,00000002
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ echo "mpls 0" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	     mpls: 00000000
> 	Result: OK: mpls=00000000
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ echo "mpls invalid" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	Result: OK: mpls=
> 
> - after the patch
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	     mpls: 00000001, 00000002
> 	Result: OK: mpls=00000001,00000002
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ echo "mpls 0" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	Result: OK: mpls=
> 
> 	$ echo "mpls 00000001,00000002" > /proc/net/pktgen/lo\@0
> 	$ echo "mpls invalid" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	Result: OK: mpls=
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


