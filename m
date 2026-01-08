Return-Path: <linux-kselftest+bounces-48455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF4D00888
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 02:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CF0B3001FD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 01:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F3136E3F;
	Thu,  8 Jan 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmyBdwU0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DC3B19F;
	Thu,  8 Jan 2026 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834414; cv=none; b=LT+z2K+bu8NBEDTygVT2JPucNnbZCTrr2t5xjZveWPXZrN5kfow4EUaX7xCI6mtT5zqN/JdQHzlBcQEytaAvkKxuC/PD8yv0ZVxy23BafXgvbkIzKuRM/0NvZA3juhJxwY7FM+5F3rsNK0blrEcmEyOcpT9Z1YkhdxU4aUD1Pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834414; c=relaxed/simple;
	bh=j08Dlj1bBoeLCSSKPIfav64GBCjVLleA7aLgxebYpeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+qpYSzQw3kX93geM5tNcvNBQRD/fe4wLJFODQBV5cBtKLIm0TbcJBx9DqPYkA4f4W4O2p6M2zsZxPouF+vCMgoE/X1RsRx8jpoHQAry+U6AN+UNw8AsNa1ykDBB965YMEW0TY90t0AKom7sg1kkPyaOlf4S23nAWDLp2yI7e9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmyBdwU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67569C4CEF1;
	Thu,  8 Jan 2026 01:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767834413;
	bh=j08Dlj1bBoeLCSSKPIfav64GBCjVLleA7aLgxebYpeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmyBdwU0f6fvtiqRTTYsTAW91UHc0CYcIFyQZo86wGk3qq9YwwLKrTphcA4jZyOAr
	 Dstz1aob3LXgig9TVoUBIgdAo+k06l9Kqx5WQ5j1K7JrSHxcXoo/kDQ41IMQWtFMji
	 B9tnW/6MYdk+V2W3NAY+TGtc/BAjPgkgbgj3D/DB7H6roJlto6JdfwkvWgEe64tIfD
	 pa9/9z9Vfvjw+g+oNBY2YDCI+VMM7kEkEn1LzaEDNL2QExHeuQar/DBJr/F6u7lZVp
	 ipfsIEFzl4oJJVnNjc2A6ptZytOpgp8ADfsjDdrvR3anMehC8AgUFoml5Iu5CLXax+
	 xX5NxSABgrdcA==
From: SeongJae Park <sj@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Usama Anjum <Usama.Anjum@arm.com>
Subject: Re: [PATCH v2 7/8] selftests/mm: fix exit code in pagemap_ioctl
Date: Wed,  7 Jan 2026 17:06:50 -0800
Message-ID: <20260108010651.80083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107164842.3289559-8-kevin.brodsky@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  7 Jan 2026 16:48:41 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> Make sure pagemap_ioctl exits with an appropriate value:
> 
> * If the tests are run, call ksft_finished() to report the right
>   status instead of reporting PASS unconditionally.
> 
> * Report SKIP if userfaultfd isn't available (in line with other
>   tests)
> 
> * Report FAIL if we failed to open /proc/self/pagemap, as this file
>   has been added a long time ago and doesn't depend on any CONFIG
>   option (returning -EINVAL from main() is meaningless)
> 
> Cc: Usama Anjum <Usama.Anjum@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

