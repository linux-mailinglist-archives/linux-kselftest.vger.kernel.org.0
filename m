Return-Path: <linux-kselftest+bounces-44117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE5C0F83F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F803B96C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E7314B79;
	Mon, 27 Oct 2025 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txaa4yUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E500314A9F;
	Mon, 27 Oct 2025 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584253; cv=none; b=ioknepNwYGthmtlLvVGewzPxANdxiSXLC2AJIKdCnQznGNBNj8hYVem3NiWGL/MLhgeR++5fUoLlIbTo297gHBcurBzWJW1UaWnH/6rfkpqRmxfuu0JGALoW80VWGNeOPyC73tnixlQgENjgMRRF1eGMW8+SjnRYm8uP96Rbmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584253; c=relaxed/simple;
	bh=GXXhBNFZYXWSK25Sta6kjqQexMhBYD1607pao0lpSY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Hl56FLvalRat4bZzdebWcOJS82AYtRKz4IDrD6CEclCoYjv4f7mZJuARoWKhI9BgJ5NuEMwnBfNMU8WFy+vjzLeIADczA66XwToCq59Di6N3PT5f2Wxky2ozPlpnOEkxPTwUgqEFhHnccNQu9DX2usud8Je0e/641owOKz2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txaa4yUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D70BC4CEFD;
	Mon, 27 Oct 2025 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584253;
	bh=GXXhBNFZYXWSK25Sta6kjqQexMhBYD1607pao0lpSY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Txaa4yUOKuKVTP3nPFL+/gze+Wsd9l+LhOwYrkRfyWBZ5YjPGZ2jRIoGjbPgkpNZV
	 USu2K08vNoMduSHkONmqM1luKE0Fa5qxOeScMEEKeisZQYi6ITw8uXj3HEMXdpWjH5
	 t5UBkxYGDCFpCFOL4GBECRUH7Nn+uVR/VGGWjOERnyRH1Ci8H9j4gO8LVLfa8TRGVM
	 692A17oGW80N19erFnxMMWGPcUaYsO6NtDUPmApKcSUEXd2HCO+YR0KjnnUOFVUZvn
	 9fKTDCjYcljuWdyQY477nv0Qehf2TBnF7cL9kAaCkHWipZfSi4o1g6nTxU4c0gnDY8
	 1AoAmvw/h+BqA==
Date: Mon, 27 Oct 2025 16:57:29 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Message-ID: <aP-keSURBFPZvNA_@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:08PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Change QEMU to use generated pidfile names instead of just a single
> globally-defined pidfile. This allows multiple QEMU instances to
> co-exist with different pidfiles. This is required for future tests that
> use multiple VMs to check for CID collissions.
> 
> Additionally, this also places the burden of killing the QEMU process
> and cleaning up the pidfile on the caller of vm_start(). To help with
> this, a function terminate_pidfiles() is introduced that callers use to
> perform the cleanup. The terminate_pidfiles() function supports multiple
> pidfile removals because future patches will need to process two
> pidfiles at a time.

It seems that this will no longer cleanup, via a trap, if
there is an early exit. Is that intentional?

This patch also changes the handling of QEMU_OPTS. I think
that should be mentioned in the commit message too.

> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...

