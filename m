Return-Path: <linux-kselftest+bounces-28361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D80A53EB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201D21698A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59846207A32;
	Wed,  5 Mar 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="auArPCwS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C789207A0E;
	Wed,  5 Mar 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219087; cv=none; b=PhIwjGfDkL1BG6St3YIAzLndCJwahIRkiVHwzHOoorGDldzdR+o9xPqJSFnG8X5Yb6pbdv5DrK82vmmGA2g3JLPrAijBORnLc7njdTPhQ88u3y611bjYBBAaKAKXXUeyFM/FZgyHaeGspPhsRj1PVt60q9N1O+MhR6RVYk7jajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219087; c=relaxed/simple;
	bh=DdFRK5RO2d7e2RkVlHvn5ifCCgLCy1rv+W704pCWsPU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GwxhAKCTQZse1NiE92k52vWgV3meeZdTzEd76EvZ3O/J4oA/ivQPvD6QLXkCrNiHpfKupJriZJQE98TmIwAOkLpNmuyT+H3EB980xzXqpQEmM0nRa+KxSr2efCxrMDWurIHQzA+zCcf+oUkVEKEp2p7fqSJPrE35WGs+UvLAms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=auArPCwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD6DC4CED1;
	Wed,  5 Mar 2025 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741219085;
	bh=DdFRK5RO2d7e2RkVlHvn5ifCCgLCy1rv+W704pCWsPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=auArPCwSO46zIPphRHxOUBEzD6w9CPJoDgp0H5896CaLY2Yp9tBm3+zOG2SduFJ6Y
	 wKiQrzMRUo5Hloo8zu/S7O0tIyNU9djorNdSdRhpQoKw6Ujb6CPiPiEwlcjmb9zFFn
	 8xsWNe+CrXEUNGNeuZ2UiF8yQpuWHxpKQL2xNcaY=
Date: Wed, 5 Mar 2025 15:58:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: jeffxu@chromium.org
Cc: keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
 vbabka@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com,
 adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
 benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
 sroettger@google.com, hch@lst.de, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
 johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
 willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
 linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
 rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
 f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
 mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
 peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com,
 groeck@chromium.org, mpe@ellerman.id.au,
 aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v9 0/7] mseal system mappings
Message-Id: <20250305155803.b4fc5f265d9f1d3d3fde4b22@linux-foundation.org>
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 02:17:04 +0000 jeffxu@chromium.org wrote:

> This is V9 version, addressing comments from V8, without code logic
> change.

I added this series to mm.git, thanks all.

