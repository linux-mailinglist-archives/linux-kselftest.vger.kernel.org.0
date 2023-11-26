Return-Path: <linux-kselftest+bounces-610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D27F9085
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 01:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2DC1C209E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 00:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE51368;
	Sun, 26 Nov 2023 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajEzRZqY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6213E
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 16:52:04 -0800 (PST)
Message-ID: <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700959920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPg+/Q1bfdSOekshqxIavDgK/xM+ZX8z48MtbsXRZC0=;
	b=ajEzRZqYRvm0a8tqOnR9BhAiabu7ctEBf1vosMXD+gbq/fKZPgDo0ZHXLOCxYbD5mxFGHC
	QmdB4wjhWfSaaTgEpk5zg7m9Sh7NKSRDEOhPDFGzLruUks42SOo8suBz1ZY032FYOGZ6cf
	SbdeooZLsqotxux1If0H6Y/nxbnhHzQ=
Date: Sat, 25 Nov 2023 16:51:51 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, ast@kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, alexei.starovoitov@gmail.com,
 Eddy Z <eddyz87@gmail.com>
Cc: mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@linux-ipsec.org, netdev@vger.kernel.org
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 1:20 PM, Daniel Xu wrote:
> Switching to vmlinux.h definitions seems to make the verifier very
> unhappy with bitfield accesses. The error is:
>
>      ; md.u.md2.dir = direction;
>      33: (69) r1 = *(u16 *)(r2 +11)
>      misaligned stack access off (0x0; 0x0)+-64+11 size 2
>
> It looks like disabling CO-RE relocations seem to make the error go
> away.

Thanks for reporting. I did some preliminary investigation and the
failure is due to that we do not support CORE-based bitfield store
yet. Besides disabling CORE-relocation as in this patch, there
are a few ways to do this:
   - Change the code to avoid bitfield store and use 1/2/4/8 byte(s)
     store. A little bit ugly but it should work.
   - Use to-be-supported 'preserve_static_offset'
     (https://reviews.llvm.org/D133361)
     to preserve the offset. This might work (I didn't
     try it yet).
   - Eduard did some early study trying to remove CORE attribute
     (preserve_access_index) from UAPI structures. In this particular
     case, erspan_metadata is in /usr/include/linux/erspan.h.

We will also investigate whether we could store bitfield store
directly with CORE.

>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3065a716544d..ec7e04e012ae 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -6,6 +6,7 @@
>    * modify it under the terms of version 2 of the GNU General Public
>    * License as published by the Free Software Foundation.
>    */
> +#define BPF_NO_PRESERVE_ACCESS_INDEX

This is a temporary workaround and hopefully we can lift it in the
near future. Please add a comment here with prefix 'Workaround' to
explain why this is needed and later on we can earliy search the
keyword and remember to tackle this.

>   #include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>

