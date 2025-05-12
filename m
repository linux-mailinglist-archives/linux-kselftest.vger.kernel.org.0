Return-Path: <linux-kselftest+bounces-32842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12DFAB337F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8DC1888657
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23B26FDB0;
	Mon, 12 May 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gk3Nh3JL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62F25EFAA;
	Mon, 12 May 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041820; cv=none; b=HMkmpohdOpzqPbIaiYSgrIsvgk+1AwdtwSXd9WgPpqVD0Ql+txQNFgL0TMQYMVjGB2Yuv3b6EyQ+FZEvR/9kCiZdKxSnaERe9Rw7aBF/m+864kvpKiiJAZD0Ff7Q34BwB8WHxgabugg19jTLRVYKPj9+smppiGO3WEpcZRDb++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041820; c=relaxed/simple;
	bh=2J2ar2Sp8/cSedjyE6WCclt+GMAoKGgjSafOgTKuqmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu1bMt7d57GN150PX1xjvTJZxqYe35yt8Ndmb2fRp0kM32036roclQjEQW4WbcUm3ZM565H0KjH00msS0X+gz3uNj57k0e1YSSlsx+tZtQ7gYm9oBGqE03itqhEI3d6tZh/wU4UcX4tIsBZsy62hsGSKirTI/oi9sCinx4WE0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gk3Nh3JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF50BC4CEE7;
	Mon, 12 May 2025 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041820;
	bh=2J2ar2Sp8/cSedjyE6WCclt+GMAoKGgjSafOgTKuqmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gk3Nh3JL/rcT9Qz+wbn5ktDUu04nQOiMZncWlscgzyzUt9dXT9eX1U4z6SfR6WP4a
	 iYSmeAR7uUb/EZjI+79+jMixIC1JvbDdsKhf4W2CKZqqBitu+2ylf1NqJXLoSeEujW
	 6OIaciQ9JjyQuAHis8+zAcTEYIDlQvq1JIU5BzhI=
Date: Mon, 12 May 2025 11:23:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	hbathini@linux.ibm.com, maddy@linux.ibm.com, venkat88@linux.ibm.com,
	sfr@canb.auug.org.au, alexei.starovoitov@gmail.com,
	daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build warning
Message-ID: <2025051204-numbness-nephew-05f9@gregkh>
References: <20250512091511.2029269-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512091511.2029269-1-skb99@linux.ibm.com>

On Mon, May 12, 2025 at 02:45:11PM +0530, Saket Kumar Bhaskar wrote:
> On linux-next, build for bpf selftest displays a warning:
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> differs from latest version at 'include/uapi/linux/if_xdp.h'.
> 
> Commit 8066e388be48 ("net: add UAPI to the header guard in various network headers")
> changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
> in include/uapi/linux/if_xdp.h.
> 
> To resolve the warning, update tools/include/uapi/linux/if_xdp.h
> to align with the changes in include/uapi/linux/if_xdp.h
> 
> Fixes: 8066e388be48 ("net: add UAPI to the header guard in various network headers")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com/
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
> 
> [RESEND]:
>  - Added Fixes and Tested-by tag.
>  - Added Greg as receipent for driver-core tree.

Why?  Commit 8066e388be48 ("net: add UAPI to the header guard in various
network headers") is not in that tree/branch, so why do I need it?

confused,

greg k-h

