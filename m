Return-Path: <linux-kselftest+bounces-46501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BAC8A098
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C252F3AA816
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF732693F;
	Wed, 26 Nov 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEwomvb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC42F3611;
	Wed, 26 Nov 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163809; cv=none; b=g63DkkyA6EmZErXvRssx2xQiI9yT2C/YRYs77WFj/moujlv2lAzLWmkDnyBsNRtMtQ5G/CDtrmpQ0VekHIu0sSnVDgH16TQSDgZV9NPrp8A5Egh8ggpk96CnYBZmKwoyTC6rdlGMik5vvpwda9aImcmOwSAS+lbQ5DkiPGcy/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163809; c=relaxed/simple;
	bh=6IxsIFeDY4CiJNhb1slgtxRoogMZu8Iz/+F2yiygSMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twvf3VhbwOGztwCNfVTbF+D/dQ6snOZMrKh+EuxBD+nFScScqQBRmUQtvvCV7tMMlNNs6b3CDtj0yPWm69MM0qqxSAZYlQYvej4So57Te+3w8UIgiFCUZogdxTOaT0KIwQbmRHk+uvLi80RGXdCh2NdPeNSYM2bSXOyGfXgzw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FEwomvb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ECFC116B1;
	Wed, 26 Nov 2025 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764163809;
	bh=6IxsIFeDY4CiJNhb1slgtxRoogMZu8Iz/+F2yiygSMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEwomvb1NbUsJcuNaBg0CXkRyaCO4WbZN1V2ugakHnVMTx68lPVtVha1f/ULlHvNN
	 ZFMyf/MhqwD090+yva/3DLE7WO/soIipo23Xtk14MEv/AWsRfds0nUwwXYHohBnHJb
	 wS6TB0Pz4Sc35Txiss86b8hN6sv0evWzTB/0i6Wc=
Date: Wed, 26 Nov 2025 14:30:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 2/2] rust: device: make example buildable
Message-ID: <2025112600-vaguely-residual-54c4@gregkh>
References: <20251110113528.1658238-1-ojeda@kernel.org>
 <20251110113528.1658238-2-ojeda@kernel.org>
 <CANiq72nFxpNP3JH-ENKRM72phHXYSMfp_7X89-q4UuGH-OyT-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nFxpNP3JH-ENKRM72phHXYSMfp_7X89-q4UuGH-OyT-A@mail.gmail.com>

On Mon, Nov 17, 2025 at 08:46:39AM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 12:35 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > This example can easily be made buildable, thus do so.
> >
> > It would have triggered an `unreachable_pub` warning without the previous
> > commit.
> >
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Greg et al.: a quick Acked-by would be appreciated.
> 
> I can also pick the first patch without this one if preferred.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

