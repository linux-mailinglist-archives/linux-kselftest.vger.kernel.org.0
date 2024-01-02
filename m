Return-Path: <linux-kselftest+bounces-2588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F578220C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 19:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D763C2834F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FD156DB;
	Tue,  2 Jan 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mG5t1Rdr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E9156D6
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jan 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d9e845c0fbso2331554b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jan 2024 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704219096; x=1704823896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=STqN8+id8xOXR4JwigzV6hothyUF9kt5Ue3l3saivJk=;
        b=mG5t1RdrgEsvW/Qmbq/ajTipvpvJH8Oi+6JVCTce5jjh+EdOvism/VZs/ZZJqwSKce
         PweFHc4zEQGqfJj+5RF/5Lq5/LE8QbgF7KQB4oHY9uo+wN6J50eNzHYAG84J6OatE6Sq
         5neS++ul/EpwllclTdd/2xrYgqi7StU/I6lDNGJhgBrqy1+WqAvJR+nig1PVPe9fU7ES
         gS0GNyz+D2EEiz6l8t6y2Y98gsADqO988f4RKy9BOm+Wb6rT9YewXFVkOyFY1IXOsAbw
         lCbMb3geiz9N0AwvV0XgZato4+SQvJE1pRvPYPuHQGJtXq+RDi/1xTrvDLXKP6K8Hv3l
         7HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704219096; x=1704823896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STqN8+id8xOXR4JwigzV6hothyUF9kt5Ue3l3saivJk=;
        b=IfmJHb075ARwWyIuDF0jRgb6QMGpULIY2Rg6qPN8jBmuKTT/sp0mv+fWgd98QYNyMI
         jjb0kQSQibn6t7/LmlVcRQJpXLhz7JFZrOJxw5wDnpzx37Ua9kArYI+JSn2awZwtlOSd
         DHLOXiTzFd7T2+kDOfo3cBkTyqPShopgdLgipK039BPopTFaU+TjZkDpVZZdGLDdBtqJ
         qmQ0FTdNlMJXca7TLlrT5PzeHCYD3MgAK8YJDnKzMesNIMOAdn6I46nbQ0b6XbA2UW77
         XUiZ2lEMtuDeTMqWRume7Atozzg95kqbWhVIoec8FiNXO35EgPseoucIMA7nvkxnMoF3
         5OWg==
X-Gm-Message-State: AOJu0Ywu54hBfFvxF9xQPaNyP2D6e+d7MCTSbNGxWI4ZGvo+vNStde6J
	JZ/r98ukh0/TcJu0/yVhAfLfDdcSI3qhbw==
X-Google-Smtp-Source: AGHT+IHqCmrQAH9xo58u1x9kh7B6PHS2ZFO8CBoaFvnThto2SDCZ8vSUwhXdAgmrJW7OvtNBqeJZsaw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:114f:b0:6da:b362:34bf with SMTP id
 b15-20020a056a00114f00b006dab36234bfmr538pfm.1.1704219095942; Tue, 02 Jan
 2024 10:11:35 -0800 (PST)
Date: Tue, 2 Jan 2024 10:11:34 -0800
In-Reply-To: <20231229081409.1276386-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
Message-ID: <ZZRR1q1JrJMD1lAy@google.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: add csum/ip_summed fields to __sk_buff
From: Stanislav Fomichev <sdf@google.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, horms@kernel.org, 
	dhowells@redhat.com, linyunsheng@huawei.com, aleksander.lobakin@intel.com, 
	joannelkoong@gmail.com, laoar.shao@gmail.com, kuifeng@meta.com, 
	bjorn@rivosinc.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 12/29, Menglong Dong wrote:
> For now, we have to call some helpers when we need to update the csum,
> such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers are
> not inlined, which causes poor performance.
> 
> In fact, we can define our own csum update functions in BPF program
> instead of bpf_l3_csum_replace, which is totally inlined and efficient.
> However, we can't do this for bpf_l4_csum_replace for now, as we can't
> update skb->csum, which can cause skb->csum invalid in the rx path with
> CHECKSUM_COMPLETE mode.
> 
> What's more, we can't use the direct data access and have to use
> skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, such
> as modifing the vni in the vxlan header and the underlay udp header has
> no checksum.
> 
> In the first patch, we make skb->csum readable and writable, and we make
> skb->ip_summed readable. For now, for tc only. With these 2 fields, we
> don't need to call bpf helpers for csum update any more.
> 
> In the second patch, we add some testcases for the read/write testing for
> skb->csum and skb->ip_summed.
> 
> If this series is acceptable, we can define the inlined functions for csum
> update in libbpf in the next step.

One downside of exposing those as __sk_buff fields is that all this
skb internal csum stuff now becomes a UAPI. And I'm not sure we want
that :-) Should we add a lightweight kfunc to reset the fields instead?
Or will it still have an unacceptable overhead?

