Return-Path: <linux-kselftest+bounces-44118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E064AC0F845
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8735E3AB0A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBED314A9D;
	Mon, 27 Oct 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM3on8gP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F73313552;
	Mon, 27 Oct 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584286; cv=none; b=hMU5b8TDWHjp5sca5/VicJ1fJioUKbmWpiWZriB9RDYIoLnfDuonWkoL1CAFj289X6Ny/QRPiG6g8oaJZEVPWbZMnh7s1vy4Dn8YTA34qgkL1nGYfqiengZHNBbQlOwCX0x1q+169uIiKuppDCoggwz14Uh/k4tOBeYFJps6AEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584286; c=relaxed/simple;
	bh=vU1/rp5K+pctYg/RwfoIK9LfV0aElb5+0vJw7kJqTgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ9aOdNso6vKyLggOSXv3Y5053PfSy0HzwKlpUOcx7GhXdOfpl/e8/cBFj4gbJmNJZI6hZ5k9D0F1v8hoBFn2Lfpw2fZpf3RS6cy+fHorTIOENGYZqmgDNIEU3HoIODlsEoZvjEot9iLmQCXpbLrhYWQApjARBcXZYU0BbmNt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM3on8gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E358C4CEF1;
	Mon, 27 Oct 2025 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584286;
	bh=vU1/rp5K+pctYg/RwfoIK9LfV0aElb5+0vJw7kJqTgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SM3on8gPSv0yQm6U+ESBDeTf7Rdu21XsM42JrAjnqd0+4IcJzte06AZQXgmRUucqU
	 kqUc7PGLfT/i07NliMxlhLTuFl1opuiGyCARhIuI+58e/1N7GVuh6Qu64dZaJke1T9
	 n2YMtfKqKwM0QZC/ouu6miuqkUuRVcaCkwmn03DHipDP5SbIZfM6F4fSXuUAj96ilH
	 q6JhXQju6kg3oI7RnwU69kLto0bc24TP4/yis9T3JPF8hR9xWctCN1jJ4H8ZahXNRA
	 iETujN7gf9/ZTMAXWXE2POpSkfed0ARkmKi6XmdntUAoAmQzz5reUE6paxj4KwEcyw
	 M2OBH2hVZN6cQ==
Date: Mon, 27 Oct 2025 16:58:02 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP-kmqhvo4AFv1qm@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> the vsock_test binary. This encapsulates several items of repeat logic,
> such as waiting for the server to reach listening state and
> enabling/disabling the bash option pipefail to avoid pipe-style logging
> from hiding failures.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

shellcheck has some (new) things to say about this patch too.
Could you take a look over them?

...

