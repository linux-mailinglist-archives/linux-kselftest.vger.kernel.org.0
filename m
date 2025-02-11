Return-Path: <linux-kselftest+bounces-26396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E5A311BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCA23A68C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA82566F0;
	Tue, 11 Feb 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDmlZTdL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51232566C9;
	Tue, 11 Feb 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291888; cv=none; b=hbwfipUaUo5kVoi0gMNx0PNw8bDywBg0D825hhER5qyMfmFBffePpjx5MfDL/jUvpvIcX6gO6o9r9IJ3qP07K+UgH7PwlF58VTTmjh1oVx0OI8vWYJA7cwFSEWW7xIztz0dVYhoWjXSDgpA7nLhb9lf7O6qne9DrcpdKYcHRcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291888; c=relaxed/simple;
	bh=vxFM/zUvtMcintYrs+VOf5Y2BFQ30Wu4wLN/ZDLZ51g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHVs+AiaqeFF7wV2DVu4t2il5refTJy1EGgrxx5tI81UvrVMnJKd+BwNrV0u26pmMFoLiChYZijp/TG4R2lhyGKPTapoqqqkv5dTMw+uB8WnTFTXhks7MliE7tudfQIat4vBo+4W5PhELGH3xq2NRvo7kswlCe5/5RW4V6TVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDmlZTdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5900AC4CEE5;
	Tue, 11 Feb 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291887;
	bh=vxFM/zUvtMcintYrs+VOf5Y2BFQ30Wu4wLN/ZDLZ51g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDmlZTdLWrjrBI8w+Fq/CFIqM/V8z+Qh9wOFqaUsOq7HIxDOX21QcMsu3E9LB2Pn9
	 IGqvTXMATD0YCyznwrBPb8btj2CUVQocWTnWED8mxclIdIAGdsSsrkmTXR6BDwuYDU
	 kb5D0J1Rlyrf6Qy4I8B4DYcJA5vpDi/jZDPsGEQxke2monfZ+mrTwamRLvBWJ583oh
	 K1NLcqxt+QVcdkTUnAP2P/9ifjIoTt0WGNqTl6xLJK2EwFZX7h/jJMfdaqpgtXS4wL
	 6fIjBe8KNnx1becsXcGIRnrR1vTZZmMGX7xRuitEk/jcY+20qosKeOfVI8ZSVg/BNa
	 /IFXjJMooIpLQ==
Date: Tue, 11 Feb 2025 08:38:06 -0800
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
Message-ID: <202502110835.2FEA5CCFD@keescook>
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
 <202502101836.2B3E7BC4@keescook>
 <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
 <CAJ-ks9nDH9Zk9vaiBP599LN-Jx3aN+JyxFXP16ikV0cayc01SQ@mail.gmail.com>
 <CAJ-ks9nK2oNz7s+QW5eF=W_SRZuuu5j4_DNQj9WM5iqH2ECZnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9nK2oNz7s+QW5eF=W_SRZuuu5j4_DNQj9WM5iqH2ECZnw@mail.gmail.com>

On Tue, Feb 11, 2025 at 06:51:09AM -0500, Tamir Duberstein wrote:
> Kees, it looks like the private header didn't make it to your tree.
> This bit is missing:

Whoops! Thanks. I've added it (and fixed the comment style).

I really need to do my build/run testing from a fresh checkout instead
of in the same work tree. :(

-- 
Kees Cook

