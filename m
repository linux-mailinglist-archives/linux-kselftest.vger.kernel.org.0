Return-Path: <linux-kselftest+bounces-612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A961D7F913A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 05:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7791C20A75
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 04:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240720EC;
	Sun, 26 Nov 2023 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFZ1kHr0"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 12625 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 20:22:27 PST
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC675119
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 20:22:27 -0800 (PST)
Message-ID: <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700972545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPqbGwvoWuhH3MNinMuIoCbVuSs6v7gO8I55MtBSoJU=;
	b=iFZ1kHr0JZmtTSmpiAQW0kJwEZwA2ZDUGadFJNdN4Xb6zgg5w0HO3U4tT+Wh1oK/6dJq9a
	jZGPr5LjmCSgn6KBRW+H6QBHPiXz3RDDaf02BawHtOiX78jLogyZ7gDFWhyXgHgYowGOdE
	nEsGPUjAhKOBmOaFutn/Y8xbp9F5Lqo=
Date: Sat, 25 Nov 2023 20:22:14 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com,
 Eddy Z <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, devel@linux-ipsec.org,
 Network Development <netdev@vger.kernel.org>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/25/23 7:54 PM, Alexei Starovoitov wrote:
> On Sat, Nov 25, 2023 at 4:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>>> index 3065a716544d..ec7e04e012ae 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>>> @@ -6,6 +6,7 @@
>>>     * modify it under the terms of version 2 of the GNU General Public
>>>     * License as published by the Free Software Foundation.
>>>     */
>>> +#define BPF_NO_PRESERVE_ACCESS_INDEX
>> This is a temporary workaround and hopefully we can lift it in the
>> near future. Please add a comment here with prefix 'Workaround' to
>> explain why this is needed and later on we can earliy search the
>> keyword and remember to tackle this.
> I suspect we will forget to remove this "workaround" and people
> will start copy pasting it.
> Let's change the test instead to avoid bitfield access.

Agree. Avoiding bitfield access is definitely a solution.
I just checked llvm preserve_static_offset (not merged yet),
it seems to be able to fix the issue as well.

Applying patch https://reviews.llvm.org/D133361 to latest llvm-project,
and with the following patch on top of patch 6,

=====

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ec7e04e012ae..11cbb12b4029 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,7 +6,10 @@
   * modify it under the terms of version 2 of the GNU General Public
   * License as published by the Free Software Foundation.
   */
-#define BPF_NO_PRESERVE_ACCESS_INDEX
+#if __has_attribute(preserve_static_offset)
+struct __attribute__((preserve_static_offset)) erspan_md2;
+struct __attribute__((preserve_static_offset)) erspan_metadata;
+#endif
  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_endian.h>
@@ -25,12 +28,12 @@
   * 172.16.1.200
   */
  #define ASSIGNED_ADDR_VETH1 0xac1001c8

  struct vxlanhdr {
         __be32 vx_flags;
         __be32 vx_vni;
  } __attribute__((packed));

  int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
                           struct bpf_fou_encap *encap, int type) __ksym;
  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
@@ -174,9 +177,13 @@ int erspan_set_tunnel(struct __sk_buff *skb)
         __u8 hwid = 7;
  
         md.version = 2;
+#if __has_attribute(preserve_static_offset)
         md.u.md2.dir = direction;
         md.u.md2.hwid = hwid & 0xf;
         md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
+#else
+       /* Change bit-field store to byte(s)-level stores. */
+#endif
  #endif
  
         ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));

====

Eduard, could you double check whether this is a valid use case
to solve this kind of issue with preserve_static_offset attribute?


