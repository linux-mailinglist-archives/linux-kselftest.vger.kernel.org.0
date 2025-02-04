Return-Path: <linux-kselftest+bounces-25689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C217A274B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BCF3A4145
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3BA213E69;
	Tue,  4 Feb 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFP6qEwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D00213E62;
	Tue,  4 Feb 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680319; cv=none; b=l95hNJSoJq9G3cmo9WSfMlQTwB5GOzhw0g1ov5TUU0YI3xG4rzUbCBScxOD/HZKbMoBswOtUCqIbTKLMFhfyrbY5Bw8Avic6xOdKH6T9pmQaVcGaW7JC5kgRyQfv2nZjURyjvHWptPJO9MR0HXb90itvFMS8r/ExoU3mENEbQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680319; c=relaxed/simple;
	bh=yYu4q3NJ1sq1PaSg3xqU5VewCbNfnhDtZNgXMokhAMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx7gVveSj0JzxFKH6VelYzBvvnxVsAhVtjJsYaHWJqbd/AG9RgVb1bZBMmCBuysBLBfbm+ClxoZWowd4uohKqZZChtKa2+TzwG13XqXYsToAwnpIw9/ThU6wsF84t2hmGbszEhRfDDC+/8wqP9nNrKns4MMv8vkOa/YXtzRXflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFP6qEwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067E0C4CEDF;
	Tue,  4 Feb 2025 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680319;
	bh=yYu4q3NJ1sq1PaSg3xqU5VewCbNfnhDtZNgXMokhAMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFP6qEwO+epTHBmeev/4cxUizjbcbhfUsFHMFpE7qpmkPBKdqozVF4lYVpkMDGudd
	 MEJAl5UqiOJQ1+5noMcgzd3Vcj20rNlYTwDehAKSXOY+cI9YpP2C2knq/p1Vyk9yXD
	 Uqk/PB4sEnA5bpXSjKD//UlT1lV3M83BS5S9FD9hyHwyszCmxo/bdsqY9spkHkzSiL
	 RiUjSPiuUYhG1Si8b5xvxfBTeTlbhsMVCc2yKSx2FHWQAoG6EqCzh3pe+5zF/6Tg/8
	 Pjwn6rgBcSxF6W+AURV4TcfqN0ExXz4a54rd0B+4KFpR8o1p1qBkYplELUSNvoPuD7
	 N9YrKJKjwsZXw==
Date: Tue, 4 Feb 2025 14:45:13 +0000
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
Subject: Re: [PATCH net-next v3 07/10] net: pktgen: fix access outside of
 user given buffer in pktgen_thread_write()
Message-ID: <20250204144513.GK234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-8-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-8-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:58PM +0100, Peter Seiderer wrote:
> Honour the user given buffer size for the strn_len() calls (otherwise
> strn_len() will access memory outside of the user given buffer).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


