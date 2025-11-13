Return-Path: <linux-kselftest+bounces-45510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E0C55A6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 05:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723D13B6E91
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 04:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6CB29D28F;
	Thu, 13 Nov 2025 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCmvK5Nh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C247219E8
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008267; cv=none; b=Zvam9HCfaal4CI0eLi/66FYBzdpkxd+okFLTp5WISgQxz1P41PfrsRKbnq8D65jgk2OY0r+WY0RxRHAj0Ob/Hi6pihBbmRgM/1GXvE9vuMqseHda2yKJPFI+c/SRMc18+KxRtuZPne9YEYJcGGBBXx6p216nTUFvdu3ZMFIoQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008267; c=relaxed/simple;
	bh=c263BORVt9zh1SNppfW30PEA0OUxdyPYJ/ly3G1wWyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUeZ8mhv0W8Df3MRcwmlpXRDX82blb7XN9KGrh/LnWdkoLADjgqFExysEzqItsjRT4oyti3o5jyw8fFFZQp6ozA2olzGPTusydgFhjOGmm7vuZGz3dZpkuKY+1zMyjMqOJtaWgiPK3QlEXjgldA643FxgV28/tMHfQWGi/knb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCmvK5Nh; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so208015fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 20:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763008263; x=1763613063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WDt5Zh4CY8eJs4W8ykxXmnnsDaX4tUrTU5JY25ZhXw=;
        b=PCmvK5NhK/zfqGEwS+4ra208qV3q15+BPBhh7TEjORYEjnzvtS/KR4D9TpU51awZzi
         JSoZmEruFEi9rTEtMfqpVBc3n2dMXo8iL/KxVh4x1SbE6rTPoWUQoYEEy7herM5LkAP/
         2lidpr07JZdYoRuzOyXbEwb0lquKiwlE0ZCvjPs3n+qkH1YZ9tELotIcigdOAx1v69vS
         009eCrDyrKdM6lCYIKbKUo4PzUvop0U1V2A8+LbFIr6qQLsD9EImDlbMrCmmNr7gYAt/
         IRMUvTcpUw0dt1R/aw3NbxiCLh/9hpOOb/gM4oG3EfnZ3MC9/kWaLq8E5RM75vt+/VTF
         kAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008263; x=1763613063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WDt5Zh4CY8eJs4W8ykxXmnnsDaX4tUrTU5JY25ZhXw=;
        b=OJ8wqEcVU9UJY5jNkbiMt8w5+1z8JLi8CvqNVQbwoTjpwD4D70z7N5zlkF+bqwlO4e
         BLCQbQo9GEGu28FkiOyyAT8sbzhwdMq0cQUn1SRzm2wdZM38rOJjIqmYeoOaCJA9r5OL
         rQ1OhNMtbBUvcb+cnPwdSWW6Z1bShaHYsY0LebF06utcD12iZmQj/7ZyT1dS3ogE0gHr
         vmpcmtlmgSlXfQ7+57jiIblQJ+RLqsvy8g1BsSqWrctmwLoNXndxzt6l7gdJ/v/2DwE8
         qVHmA/24OkzsGxrHALv9AqD1iT8Mt9UtQl5zBZw4lzx6F85bZYpCNIeYTEJ0Q+m5IxPv
         hbMw==
X-Forwarded-Encrypted: i=1; AJvYcCVWKYMSNSia9kMIkZBMba4UOlYCYg64iEw6llRlf0YF3FOWtYMlpsh8O8aXT18pyh+eiUlDebX50gmhIjtLhVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzchle0S3FzSqMyBfig0ifN5qOH5dLWKd0OTWLKAiX6q2Nbgouc
	divT6RwLOIAWe05Z5kB0jdWD39hO59vHOr2FufZrINHHGroLitHmgBi9
X-Gm-Gg: ASbGnctPQSIe46JYEoeXqNS16CqfqrqEFeGtLz/IB4STGCpgN9QJlr/21lgvJprr44v
	M9+PQVwYvbvDFlATIYg6L0atsx84/5fycz9vjQgG8LhmqQzSU4OCjBGuwsPAEepP+wpa/Zj/IE+
	taPFwTbV8BlsmRCJVgnRlYLnXYE4nEhfR0crJwB2iSG3Up4xYGbMd7oEhoaPNIequFIA5hIkdzu
	WgDPhzPs1Ijl0ESeKcC1Pdqlmwha0nDe+dWaHhOcSEEDN3bg/Jy9e1Kgwx1akdrnn5lP0a1rfpo
	frUAEjUmJqnMA9XIKKH6bGk0r0fiC0H2Fz1BqZ640wnTpgkwQVv/lpTjZaGHAqAicVN07VLtt/6
	fs/GNb+UUOiWpjqXrw9R4LpWwgR1cHPkuoIwVFrNRUr0HfNgrjmSKH3R52u7nIwAoU1dyTI7uzs
	eAHyN0j9s2MxrO+u6adbo=
X-Google-Smtp-Source: AGHT+IGJ4ELwLXwPJt2nOCnAR00gAs+/s2qXEwZaFNHtL1hCNbx4GfuHDxZu3clFmqhPvKkDtNncdA==
X-Received: by 2002:a05:6871:c317:b0:3d3:599d:fe98 with SMTP id 586e51a60fabf-3e8341d01bamr2451306fac.41.1763008263207;
        Wed, 12 Nov 2025 20:31:03 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e851d64d3dsm742607fac.0.2025.11.12.20.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:31:02 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: xdp: Fix register spill error with clang 20
Date: Wed, 12 Nov 2025 20:31:02 -0800
Message-ID: <20251113043102.4062150-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On clang 20.1.8 the XDP program fails to load with a register spill error.
Since hdr_len is a __u32, the compiler decided it only needed the lower
32-bits of ctx->data, which later triggers the register spill verifier
error.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
libbpf: prog 'xdp_prog': BPF program load failed: Permission denied
libbpf: prog 'xdp_prog': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; return xdp_prog_common(ctx); @ xdp_native.bpf.c:670
0: (85) call pc+1
caller:
 R10=fp0
callee:
 frame1: R1=ctx() R10=fp0
2: frame1: R1=ctx() R10=fp0
; static int xdp_prog_common(struct xdp_md *ctx) @ xdp_native.bpf.c:635
2: (bf) r7 = r1                       ; frame1: R1=ctx() R7_w=ctx()
3: (b4) w1 = 0                        ; frame1: R1_w=0
; key = XDP_MODE; @ xdp_native.bpf.c:640
4: (63) *(u32 *)(r10 -336) = r1       ; frame1: R1_w=0 R10=fp0 fp-336=????0
5: (bf) r2 = r10                      ; frame1: R2_w=fp0 R10=fp0
6: (07) r2 += -336                    ; frame1: R2_w=fp-336
; mode = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:641
7: (18) r1 = 0xff110001099ada00       ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
9: (85) call bpf_map_lookup_elem#1    ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
10: (bf) r8 = r0                      ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R8_w=map_value(map=map_xdp_setup,ks=4,vs=4)
11: (b4) w6 = 2                       ; frame1: R6_w=2
; if (!mode) @ xdp_native.bpf.c:642
12: (15) if r8 == 0x0 goto pc+669     ; frame1: R8_w=map_value(map=map_xdp_setup,ks=4,vs=4)
13: (b4) w1 = 1                       ; frame1: R1_w=1
; key = XDP_PORT; @ xdp_native.bpf.c:645
14: (63) *(u32 *)(r10 -336) = r1      ; frame1: R1_w=1 R10=fp0 fp-336=????1
15: (bf) r2 = r10                     ; frame1: R2_w=fp0 R10=fp0
16: (07) r2 += -336                   ; frame1: R2_w=fp-336
; port = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:646
17: (18) r1 = 0xff110001099ada00      ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
19: (85) call bpf_map_lookup_elem#1   ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
; if (!port) @ xdp_native.bpf.c:647
20: (15) if r0 == 0x0 goto pc+661     ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
; switch (*mode) { @ xdp_native.bpf.c:650
21: (61) r1 = *(u32 *)(r8 +0)         ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R8=map_value(map=map_xdp_setup,ks=4,vs=4)
22: (66) if w1 s> 0x1 goto pc+20 43: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=scalar(smin=umin=smin32=umin32=2,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
; switch (*mode) { @ xdp_native.bpf.c:650
43: (16) if w1 == 0x2 goto pc+26      ; frame1: R1=scalar(smin=umin=smin32=umin32=3,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
44: (16) if w1 == 0x3 goto pc+123 168: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=3 R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
; return xdp_adjst_tail(ctx, (__u16)(*port)); @ xdp_native.bpf.c:658
168: (61) r2 = *(u32 *)(r0 +0)        ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; udph = filter_udphdr(ctx, port); @ xdp_native.bpf.c:430
169: (54) w2 &= 65535                 ; frame1: R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
170: (bf) r1 = r7                     ; frame1: R1_w=ctx() R7=ctx()
171: (85) call pc+512
caller:
 frame1: R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
callee:
 frame2: R1_w=ctx() R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
684: frame2: R1=ctx() R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
; static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port) @ xdp_native.bpf.c:71
684: (bc) w6 = w2                     ; frame2: R2=scalar(id=54,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R6_w=scalar(id=54,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
685: (bf) r7 = r1                     ; frame2: R1=ctx() R7_w=ctx()
; err = bpf_xdp_pull_data(ctx, sizeof(*eth)); @ xdp_native.bpf.c:78
686: (b4) w2 = 14                     ; frame2: R2_w=14
687: (85) call bpf_xdp_pull_data#85514        ; frame2: R0_w=scalar()
688: (bc) w1 = w0                     ; frame2: R0_w=scalar() R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
689: (b7) r0 = 0                      ; frame2: R0_w=0
; if (err) @ xdp_native.bpf.c:79
690: (56) if w1 != 0x0 goto pc+55     ; frame2: R1_w=0
; data_end = (void *)(long)ctx->data_end; @ xdp_native.bpf.c:82
691: (61) r2 = *(u32 *)(r7 +4)        ; frame2: R2_w=pkt_end() R7_w=ctx()
; data = eth = (void *)(long)ctx->data; @ xdp_native.bpf.c:83
692: (61) r1 = *(u32 *)(r7 +0)        ; frame2: R1_w=pkt(r=0) R7_w=ctx()
; if (data + sizeof(*eth) > data_end) @ xdp_native.bpf.c:85
693: (bf) r3 = r1                     ; frame2: R1_w=pkt(r=0) R3_w=pkt(r=0)
694: (07) r3 += 14                    ; frame2: R3=pkt(off=14,r=0)
695: (2d) if r3 > r2 goto pc+50       ; frame2: R2=pkt_end() R3=pkt(off=14,r=14)
; if (eth->h_proto == bpf_htons(ETH_P_IP)) { @ xdp_native.bpf.c:88
696: (71) r2 = *(u8 *)(r1 +12)        ; frame2: R1=pkt(r=14) R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
697: (71) r1 = *(u8 *)(r1 +13)        ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
698: (64) w1 <<= 8                    ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xff00,var_off=(0x0; 0xff00))
699: (4c) w1 |= w2                    ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
700: (16) if w1 == 0xdd86 goto pc+15          ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
701: (56) if w1 != 0x8 goto pc+44     ; frame2: R1_w=8
; err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) + @ xdp_native.bpf.c:91
702: (bf) r1 = r7                     ; frame2: R1_w=ctx() R7=ctx()
703: (b4) w2 = 42                     ; frame2: R2_w=42
704: (85) call bpf_xdp_pull_data#85514        ; frame2: R0=scalar()
705: (bc) w1 = w0                     ; frame2: R0=scalar() R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
706: (b7) r0 = 0                      ; frame2: R0_w=0
; if (err) @ xdp_native.bpf.c:93
707: (56) if w1 != 0x0 goto pc+38     ; frame2: R1_w=0
; data_end = (void *)(long)ctx->data_end; @ xdp_native.bpf.c:96
708: (61) r1 = *(u32 *)(r7 +4)        ; frame2: R1_w=pkt_end() R7=ctx()
; data = (void *)(long)ctx->data; @ xdp_native.bpf.c:97
709: (61) r2 = *(u32 *)(r7 +0)        ; frame2: R2_w=pkt(r=0) R7=ctx()
; if (iph + 1 > (struct iphdr *)data_end || @ xdp_native.bpf.c:101
710: (bf) r7 = r2                     ; frame2: R2_w=pkt(r=0) R7_w=pkt(r=0)
711: (07) r7 += 34                    ; frame2: R7_w=pkt(off=34,r=0)
712: (2d) if r7 > r1 goto pc+33       ; frame2: R1_w=pkt_end() R7_w=pkt(off=34,r=34)
; iph->protocol != IPPROTO_UDP) @ xdp_native.bpf.c:102
713: (71) r2 = *(u8 *)(r2 +23)        ; frame2: R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
; if (iph + 1 > (struct iphdr *)data_end || @ xdp_native.bpf.c:101
714: (16) if w2 == 0x11 goto pc+14 729: frame2: R0=0 R1=pkt_end() R2=17 R6=scalar(id=54,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R7=pkt(off=34,r=34) R10=fp0
; if (udph + 1 > (struct udphdr *)data_end) @ xdp_native.bpf.c:128
729: (bf) r2 = r7                     ; frame2: R2_w=pkt(off=34,r=34) R7=pkt(off=34,r=34)
730: (07) r2 += 8                     ; frame2: R2=pkt(off=42,r=34)
731: (2d) if r2 > r1 goto pc+14       ; frame2: R1=pkt_end() R2=pkt(off=42,r=42)
; if (udph->dest != bpf_htons(port)) @ xdp_native.bpf.c:131
732: (dc) r6 = be16 r6                ; frame2: R6_w=scalar()
733: (69) r1 = *(u16 *)(r7 +2)        ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R7=pkt(off=34,r=42)
734: (5e) if w1 != w6 goto pc+11      ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R6_w=scalar(smax=0x7fffffff0000ffff,umax=0xffffffff0000ffff,smin32=0,smax32=umax32=0xffff,var_off=(0x0; 0xffffffff0000ffff))
735: (b4) w1 = 0                      ; frame2: R1_w=0
736: (63) *(u32 *)(r10 -4) = r1       ; frame2: R1_w=0 R10=fp0 fp-8=0000????
737: (bf) r2 = r10                    ; frame2: R2_w=fp0 R10=fp0
738: (07) r2 += -4                    ; frame2: R2_w=fp-4
; count = bpf_map_lookup_elem(&map_xdp_stats, &stat_type); @ xdp_native.bpf.c:65
739: (18) r1 = 0xff110001099ad200     ; frame2: R1_w=map_ptr(map=map_xdp_stats,ks=4,vs=8)
741: (85) call bpf_map_lookup_elem#1          ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8)
; if (count) @ xdp_native.bpf.c:67
742: (15) if r0 == 0x0 goto pc+2      ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8)
743: (b7) r1 = 1                      ; frame2: R1_w=1
; __sync_fetch_and_add(count, 1); @ xdp_native.bpf.c:68
744: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)         ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8) R1_w=scalar()
745: (bf) r0 = r7                     ; frame2: R0_w=pkt(off=34,r=42) R7=pkt(off=34,r=42)
; } @ xdp_native.bpf.c:137
746: (95) exit
returning from callee:
 frame2: R0_w=pkt(off=34,r=42) R1_w=scalar() R6=scalar(smax=0x7fffffff0000ffff,umax=0xffffffff0000ffff,smin32=0,smax32=umax32=0xffff,var_off=(0x0; 0xffffffff0000ffff)) R7=pkt(off=34,r=42) R10=fp0 fp-8=0000????
to caller at 172:
 frame1: R0_w=pkt(off=34,r=42) R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
; udph = filter_udphdr(ctx, port); @ xdp_native.bpf.c:430
172: (bf) r8 = r0                     ; frame1: R0_w=pkt(off=34,r=42) R8_w=pkt(off=34,r=42)
; if (!udph) @ xdp_native.bpf.c:431
173: (15) if r8 == 0x0 goto pc+508    ; frame1: R8_w=pkt(off=34,r=42)
; hdr_len = (void *)udph - (void *)(long)ctx->data + @ xdp_native.bpf.c:434
174: (61) r9 = *(u32 *)(r7 +0)        ; frame1: R7=ctx() R9_w=pkt(r=0)
; key = XDP_ADJST_OFFSET; @ xdp_native.bpf.c:436
175: (63) *(u32 *)(r10 -328) = r6     ; frame1: R6=2 R10=fp0 fp-328=????2
176: (bf) r2 = r10                    ; frame1: R2_w=fp0 R10=fp0
177: (07) r2 += -328                  ; frame1: R2_w=fp-328
; adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:437
178: (18) r1 = 0xff110001099ada00     ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
180: (85) call bpf_map_lookup_elem#1          ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
; if (!adjust_offset) @ xdp_native.bpf.c:438
181: (15) if r0 == 0x0 goto pc+500    ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
182: (63) *(u32 *)(r10 -344) = r9
invalid size of register spill
processed 2736 insns (limit 1000000) max_states_per_insn 5 total_states 190 peak_states 156 mark_read 19
-- END PROG LOAD LOG --
libbpf: prog 'xdp_prog': failed to load: -13
libbpf: failed to load object '/root/ksft-net-drv/net/lib/xdp_native.bpf.o'

 tools/testing/selftests/net/lib/xdp_native.bpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index c368fc045f4b..64f05229ab24 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -332,7 +332,7 @@ static __u16 csum_fold_helper(__u32 csum)
 }
 
 static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
-				     __u32 hdr_len)
+				     unsigned long hdr_len)
 {
 	char tmp_buff[MAX_ADJST_OFFSET];
 	__u32 buff_pos, udp_csum = 0;
@@ -422,8 +422,9 @@ static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 {
 	struct udphdr *udph = NULL;
 	__s32 *adjust_offset, *val;
-	__u32 key, hdr_len;
+	unsigned long hdr_len;
 	void *offset_ptr;
+	__u32 key;
 	__u8 tag;
 	int ret;
 
-- 
2.47.3


