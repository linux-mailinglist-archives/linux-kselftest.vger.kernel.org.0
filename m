Return-Path: <linux-kselftest+bounces-38546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79CB1E5D9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA256788B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4895E27147A;
	Fri,  8 Aug 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Wk8yjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE9271456;
	Fri,  8 Aug 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646274; cv=none; b=NQ2yPiVARP1Shz+J+d8p/ypAo0lXGmoIosDFqL5spszwlufpiIh+K4DvZmHMUo79xB2S4cJBVVoTK9vLzL54pXqHZpfUgpI83hgb4HpIWG77PX2LM/8n2zU/azi/3EFY0/ASZc82Mbv+1mguyhA9e5kjYXEBuFpK8n9sZ9OzpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646274; c=relaxed/simple;
	bh=1ZJ4ldKCI69qLoYIh53Dk0H49HJT6go1Z5K0fsK0RZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gobD1HxY5mnZ+YajpDq9W6+LfRnjHmxDam78O0d5gxNto8lv+iP4CZz9rKLGqRaAh3K1v0PBdGjgSdBTmdcRgt7hYmBb5SyIqJ60m1Zws6USOSMbEyq0rP2SRMoSf0hsJTbXLmLWGFjJVVz6H7f/SEJ32/B7AdiP0H7vgX+VfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Wk8yjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34FFC4CEF0;
	Fri,  8 Aug 2025 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754646273;
	bh=1ZJ4ldKCI69qLoYIh53Dk0H49HJT6go1Z5K0fsK0RZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X8Wk8yjsDVhHaE+xDTYwLqOPyG3wua/VBoVf9vdxy9oBl1IMu5AJ8JzSVtypG5WB+
	 0p7ejSOBEWIF1xbm8CbTz4nWhFT/d/a4173pcy8rAJ4Bg4PHOxvJnAb7VUGHQYBpgP
	 5LlPLtJ81G39HmPGI8VnPhVcIFYMqM6SD5oSaSSu9uV7J5s6Ic+UnC/I+8NomGuZ44
	 vtwJ8gsijjJqqpBx0zq+pE8iPnFON6RS+GAywviYw9iN5ed2DD/ecS06xQUsIF8keF
	 9AkDCrMacaon6Ui/LmmO0gq/wSrRDaX+g3k5+yGPY0QGYpMtknXxOeC3yyBg3TFUrY
	 Lz4xdRAQY4P6g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens
 Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 3/8] rust: block: use `kernel::{fmt,prelude::fmt!}`
In-Reply-To: <20250719-core-cstr-fanout-1-v2-3-1ab5ba189c6e@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
 <gRsj-X3HsgPY0RHRFi_436uiCVwsW6_foevaDuyAYA05QfuGKU-LNQcofLAG8W-PBuuU1cZtSvkcI7gijo5vVw==@protonmail.internalid>
 <20250719-core-cstr-fanout-1-v2-3-1ab5ba189c6e@gmail.com>
Date: Fri, 08 Aug 2025 11:43:11 +0200
Message-ID: <87ikiy5ets.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



