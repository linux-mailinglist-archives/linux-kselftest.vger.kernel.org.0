Return-Path: <linux-kselftest+bounces-41816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B72B83950
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171B1C022FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5F2F532E;
	Thu, 18 Sep 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0cR9NE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241452C08AA
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185254; cv=none; b=kwdVo/3F5ibYH1FRPjcjd7EZ4TqlRvuePj8KnphTrtcQ3xXfwHnil8dydgUi22qnxDJZwflxMFSRZsOPBUi+Fl3iB4nqH7q1YQOPGvP6YEGC6PrMmzDNEB0LbE0JbuLrSRlTwmGQ3zrM8s2MSo7BWVYkRqkx5OpVNciMaHHQeLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185254; c=relaxed/simple;
	bh=L45ZHUW76JMrGXCpZTDkbXpqy+oHe8GXZEgOVfexB8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c683IJHyqX2TCJmQ48P1uSDd+eCZAVxgtdmv1hpQIow4a85RFxZR74nMqsfkjRN3TBj/cSvohCGtcSqARY9Zf69RLrsBDb9929aVcxMQhIsb32okC10DbtCjuSS2tY3PDSHnUTzw3jPKbsfuig57Gq+VUVNFxmyBAOa04XMhUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0cR9NE0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042eb09948so128776566b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758185250; x=1758790050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=M0cR9NE0W9Y1xN7+c4xlGTZwwhVigM/FIVmgKAIyZvwqF3Np4p7DxnWa2VF+gezaFy
         svZvKYCwUdmmAyap3TRZCZTt0eHvCqiX+5uMjpoX6Dp9KLOLcH/pD5INZwpurGQ9ZbXP
         vRobPnSAwwQ5I/V+z3lQ32nk0GeSoJHXbVB/WZrUX8WinuxqUdZdp4HcG2rvvVNfLnrb
         X+HxqJhjEPs9oHLaKCYMB6hgsPHKB3DMzSWKIM/MHV6GHofzL6XA/3RRzGQLMxlLtAw9
         aOS2FP2noNdiE/Zlk8JvO0Zb8Erbwee2waGIetr0UyAVy/whOhE8sSBQ/qe5zt/hJ6kp
         TgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185250; x=1758790050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=fiawCfmwQNLJrdK/3rZd1gH1AAbGMBJZOE+Q1GCJaTFfBMLd03GkMXQpx5ErtywLb8
         s2SLMCpWJSG1LhLUBxdF54QtRYCzBFHO/QmldznX493KlNAwAqtHdIuGYbwA0oaBjMPs
         JbGoEJKC8oiIQWJneyTR7ivFDCaQ52b4E4Glp9SenRwta4k/zrPvPqJNBRO1VIZDMPE9
         YDdLfkOlcFz4pW16eUX2zshaWmrYLj/kALIIOrzN3IdoXI/xE59IFRSua0Fr7sTsj6B6
         nQFd+N4k6867bFL6uATXH8sNEilShNjkwcMJgxXc3FEdGufRqWmX3Muaby8PhUy3J/TA
         D4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+/ShrgBJaiKqveLtFwI0e13JY0p/xFEcIQl9ffn2Q+ZLuUw5EGkDoaJDsQAYFQu7V0fdjtM81XTXGbISljK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoyKVLvAaUyqcKhwqmuJWNTx4Bw1cwAKey6Skb5N/nyBM9ZVFc
	f82Jk7VhvFdUAq+c9E9rNHq/kMFMZMYAZlvK9A5VTZEUBCGti18D+jgQ
X-Gm-Gg: ASbGncvIo+/bp0X4mZrRH2Li0fi6ot3ZIKCzL5OVUoAf2zR/fT4E9pcVxaF5r4XqmZd
	kbt9M3F6okKGHuR5cD5bnJNxAew0iov3Q49R5zFySrhYE6WL8AcC2E+RIetSMSrTym7q4D6xaho
	qQBvlc4jrShXcMPBJ31Pg+LUFOBSm94/56ZKmp+OYCq+JevxwqZOhGpkI534hbkC2oRXCW0W+IA
	XqK4I5iGfaRHakd5HYlkLWo6KtgjlWRdvaNJkiW03plnNX3TSWSseJvGubjm3c8Dizao4/o91EN
	IAm9XaaOu2kePxg3y3GdIw6dzDYvr3xE+zQOH5hIhV2FL0Q6XM57jkL4BLtb7IrChFiwKf8Umn/
	qwQ84/iiwRnVGTqv9wBoCa1mZzoPeLwkyBKGREr+F5Vyb2OPJhUmMfQ==
X-Google-Smtp-Source: AGHT+IGSY6T0zgBstKzdppw+beER6+Ou6Xf+HZr5uZODjknR4sf0RTrkDM+Z+jzltMePgD/ZZBp0rA==
X-Received: by 2002:a17:907:3e8c:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b1bb6802513mr591131566b.40.1758185250193;
        Thu, 18 Sep 2025 01:47:30 -0700 (PDT)
Received: from krava (37-188-233-225.red.o2.cz. [37.188.233.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44bb1sm148036466b.21.2025.09.18.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:47:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 Sep 2025 10:47:15 +0200
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	haoluo@google.com, eddyz87@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, shuah@kernel.org,
	willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
	martin.kelly@crowdstrike.com, ameryhung@gmail.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <aMvHE-iW5eAwf4km@krava>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
 <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>

On Thu, Sep 18, 2025 at 04:05:51PM +0800, Fuyu Zhao wrote:
> 
> 
> On 9/18/2025 4:02 AM, Song Liu wrote:
> > On Wed, Sep 17, 2025 at 12:23 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> >>
> >> Hi everyone,
> >>
> >> This patchset introduces a new BPF program type that allows overriding
> >> a tracepoint probe function registered via register_trace_*.
> >>
> >> Motivation
> >> ----------
> >> Tracepoint probe functions registered via register_trace_* in the kernel
> >> cannot be dynamically modified, changing a probe function requires recompiling
> >> the kernel and rebooting. Nor can BPF programs change an existing
> >> probe function.
> >>
> >> Overiding tracepoint supports a way to apply patches into kernel quickly
> >> (such as applying security ones), through predefined static tracepoints,
> >> without waiting for upstream integration.
> > 
> > IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
> > tracepoint with btf (tp_btf).
> > 
> > Did I miss something?
> > 
> > Thanks,
> > Song
> 
> As I understand it, raw tracepoints (raw_tp) and raw tracepoint (raw_tp)
> are designed mainly for tracing the kernel. The goal of this work is to
> provide a way to override the tracepoint callback, so that kernel behavior
> can be adjusted dynamically.

hi,
what's the use case for this? also I'd think you can do that just by
unregister the callback you want to override and register new one?

thanks,
jirka

