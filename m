Return-Path: <linux-kselftest+bounces-37469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BDDB084D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E03564819
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274D2153ED;
	Thu, 17 Jul 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KftUhsqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966B21507F;
	Thu, 17 Jul 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733408; cv=none; b=A/aHYaL0+9lZNaIlKyfauao5CJ6nko9OhNfS8PWLcJxLN50PDGIsjJAZYwwPMkZIcVSNiFMi+D6n72eyfWNU1BtqrArno5MV1QL2Jpvpi1NDw+8qb7XG5aWWRC6XwcXAmvaq/Hw4HdCx40SdWAu5yvSTiubJuE+sk56xw+dA+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733408; c=relaxed/simple;
	bh=rgN5C3cOKpvByO+45AcntBBbazAMNNT+uIf6SNwgdxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKuUKV1Vb+eRFj7OpcNPDKF5LJGTMId486F1GIAuxa09YtpQQSUjmcOnP8Umj7RQxuEItuNR5A2e6MDZvj26hkDFGqj9XszbWKN8mQW/BjRD1LvbK88VaVbC2MdCS+8uZ0wciOF/VOywseIpqm0JIMzXrixbbVzLxnSRezFIHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KftUhsqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ACFC4CEE3;
	Thu, 17 Jul 2025 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752733408;
	bh=rgN5C3cOKpvByO+45AcntBBbazAMNNT+uIf6SNwgdxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KftUhsqyZoFqkWdOhn7YF7+ex8qz2+XrPgOb9qIU1etUeeIk4WkU9XqCgavL0RZVs
	 yM+tUgB2q7AO3zfu4b5GvtaFfH5cctkNqWzTzHfpa5UgjsTocw/rjxfzZE2+ZKbCG0
	 UnhB6nx33ZMga6CdNln/VPYyWqlzHg+nL4D6pWqPqQ3watK+u6KOe7br7S7CJYhd0r
	 mv8IL5IL7zS0r5McslONg2rORNsiNgJn5Lk+nPoJW7OhTMEnSuD+12whBLPdmJyVg4
	 API1MjxsCdNcH9mnCVS3g+ENkhzpks312MfiU6dmTerKSGbdJWkGNxp1b2cHYpbo4I
	 Hd9aMwWizf0UQ==
Date: Wed, 16 Jul 2025 23:23:27 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 1/6] binder: Fix selftest page indexing
Message-ID: <202507162323.FB8BD28A3@keescook>
References: <20250717011011.3365074-1-ynaffit@google.com>
 <20250717011011.3365074-2-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717011011.3365074-2-ynaffit@google.com>

On Wed, Jul 16, 2025 at 06:10:04PM -0700, Tiffany Yang wrote:
> The binder allocator selftest was only checking the last page of buffers
> that ended on a page boundary. Correct the page indexing to account for
> buffers that are not page-aligned.
> 
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

