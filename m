Return-Path: <linux-kselftest+bounces-31914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E9EAA146F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945407B66D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A32459EA;
	Tue, 29 Apr 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM3/RfEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D607245007;
	Tue, 29 Apr 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946917; cv=none; b=MP5Q0GX9Dkf1voozel+cdddO+gyO24Vi+NClUB32DsOZWUxwC10eGHzlljr+PnMRYRtSoSpFxikBPa4oZaLYiSNBlRjPjbeOGF7vj2f8NHohYO9KjKh/0TQsN9GQbBi3nzH2VbJRIyBzm/w7Gf64AKqtri0UpzJ07rFVFwk6zZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946917; c=relaxed/simple;
	bh=3mg4I7QyOW1gVwOz/6rYaIXF4k7NSz/cTj9ZXZq/4CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IROGE1zGsbuxO/Nr5FnDZi8lkwU1ysE0M1tqpNG2vuCAR0I7HFJZXA7uim2tgbDYK6zrDxznmrFTm7Z48c7zNz0JnOg7KI16RWzfqu6pO5atJ+aCwx2ZHdMUAaSL55Us9KC6vXwiJLyUTGREsVeJZywMBRF4keRk57HhggPPkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM3/RfEf; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f8d2f8d890so4087477b6e.0;
        Tue, 29 Apr 2025 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745946914; x=1746551714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmofmemgoWFhRw05fKVJOk2vZV3Pg/3zezcHkaC2gPM=;
        b=FM3/RfEfqxEA8rRIvUkJwI4wEwoQAlMPzJEAwmYlH0yPTy85NmvZnJVOqpOl/QbV9/
         1PGOAcaJEjAj96vjADqyamoLk7DiiieQ7gs1uHWYF4LxU70lSGN/LN8oiFmBFhvSWv8q
         1HjSUPXW8+Bjh/YMPezPrjEk95d8KjSVvJ6KwrAVvM8JC98PR3IpuyqBFqgBS0BhukDV
         3iBcBv22IxFqNaSeUQQkKhz6QpMXEtCPvg4eV6OpEGzeoi3EGHYi2aQUOAKjA0SGHFre
         B4DIpXNVJzfZ3QAKLJUGmZzY44TFsoEvFdlMqwXXJxWgvvsYEa5vCb6CEIJpAjcm99Oj
         ZL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946914; x=1746551714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmofmemgoWFhRw05fKVJOk2vZV3Pg/3zezcHkaC2gPM=;
        b=Rg7qr/EPeM08zBqHE0Bb0vunfHqn+Fq2NRUKxr1Dxg67sJ3Fj7R4fGnop39T+OJftU
         1qp0tD/CdeBmVW6yDtV6vZGj2Q7TfBkL1/qPXw8fSA/6ZZse3KiBRoIwIQHYle0bSWfQ
         UX/Rsiwn6ucDoVFSa8UUcVcQslUeHbEhIoODQRetkZw68xsGEuZsuqJlMtjZJYOP3+7y
         wOzXWlB+ucyL9EL9v91LYufy+dkeitsjq6XzXMhs0tdO5eHMOo2LwwqK4l0TTfwMRO0i
         HuJoemuzvRwUlELefnG+REN85dyv9gxvvL2mxYsnsj+WaqRYtL87palxk2dBeDzrsWyZ
         IS9w==
X-Forwarded-Encrypted: i=1; AJvYcCVMeJ/3faDT4SDkadpTlFjJFH5CbnbLEi/MVjj3o0wkD83gTrXZYRYjHTgEHlBUdj8CVyiIo0uq@vger.kernel.org, AJvYcCVhZN4/kiHCLMM6BGVPEgXOoqskmsXMpPwsZxG0dRaaLI1tqEuDmGJj1JxO+b7HHPHHCElhYY7VaeQg1FkFbF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG4F5pgMe0kIw0bUubp79wf8jZJ80MK+xiRvCw5su6W0rLN6a
	dT24tn4JMlkd2ocIdQfyE0TMJVvlpKd32G94o9b+hFqgk5LVtj+PYSRJvF3+J/3efOu2R/in6aZ
	xBPT8quVwdChPd3+GCHW5lQAmNRI=
X-Gm-Gg: ASbGncuzGicjL3SpTtqtSylM4QZJfbZ6QRFngRvMuNaIgI7BuCxPgsZKQyDVJS+N/HW
	/6aIL5c/jBsNvyXiNCh08XKh0oezxqCT9REhM71T93PkhjRhCoBJwNb8wzzONoTDwkhlggTNiMo
	UkTfOVwtzB2eNuvrikrhYURnsA2GfGZmvM9feXNvkCQM+jYThr04dw70jdvknSQus=
X-Google-Smtp-Source: AGHT+IGVvH53UuIhNspPIC2B/maPvHC2bXaEeIwWfgVsATYlEe7sf/gZkW4Qf1oFMcDZb68RVR0J4Pse5D35aI2S37g=
X-Received: by 2002:a05:6808:3194:b0:3f8:91d1:d950 with SMTP id
 5614622812f47-4024399b8b3mr116588b6e.38.1745946914208; Tue, 29 Apr 2025
 10:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com> <20250426172025.9459-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250426172025.9459-2-chia-yu.chang@nokia-bell-labs.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 29 Apr 2025 18:15:03 +0100
X-Gm-Features: ATxdqUFemhdUNz5EampAyUMbPYK2LpYqGKPxoiCRao4tXy6UeqtfaouvhsvFTH0
Message-ID: <CAD4GDZxPrgfMFLTG4Mc1VK0hM5ODP2tTFF771EhMzWnbC8BwaQ@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
To: chia-yu.chang@nokia-bell-labs.com
Cc: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com, 
	pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Apr 2025 at 18:20, <chia-yu.chang@nokia-bell-labs.com> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Introduce the specification of tc qdisc DualPI2 stats and attributes,
> which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
> (https://datatracker.ietf.org/doc/html/rfc9332) providing two different
> queues: low latency queue (L-queue) and classic queue (C-queue).

General comment is that this does not work. Please test it like this:

sudo tc qdisc add dev eth0 handle 1: root dualpi2
./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/tc.yaml --dump getqdisc

Consider moving this patch to the end of the series so that it can be
tested against the implementation patches.

> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  Documentation/netlink/specs/tc.yaml | 166 ++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index aacccea5dfe4..9eaab15cc216 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -51,6 +51,31 @@ definitions:
>        - tundf
>        - tunoam
>        - tuncrit
> +  -
> +    name: tc-dualpi2-drop-overload-flags
> +    type: flags
> +    entries:
> +      - drop
> +      - overflow

These enums need to be defined as part of the UAPI in pkt_sched.h and
this file needs to be in sync with those definitions.

This enum seems to contradict the comment in sch_dualpi2.c:

bool drop_overload; /* Drop (1) on overload, or overflow (0) */

> +  -
> +    name: tc-dualpi2-drop-early-flags
> +    type: flags
> +    entries:
> +      - drop-enqueue
> +      - drop-dequeue

Also contradicts comment in sch_dualpi2.c:

bool drop_early; /* Drop at enqueue instead of dequeue if true */

> +  -
> +    name: tc-dualpi2-ecn-mask-flags
> +    type: flags
> +    entries:
> +      - l4s-ect
> +      - any-ect
> +      - none
> +  -
> +    name: tc-dualpi2-credit-queue-flags
> +    type: flags
> +    entries:
> +      - C-queue
> +      - L-queue
>    -
>      name: tc-stats
>      type: struct
> @@ -816,6 +841,64 @@ definitions:
>        -
>          name: drop-overmemory
>          type: u32
> +  -
> +    name: tc-dualpi2-xstats
> +    type: struct
> +    members:
> +      -
> +        name: prob
> +        type: u32
> +        doc: Current probability
> +      -
> +        name: delay-c
> +        type: u32
> +        doc: Current C-queue delay in microseconds
> +      -
> +        name: delay-l
> +        type: u32
> +        doc: Current L-queue delay in microseconds
> +      -
> +        name: pkts-in-c
> +        type: u32
> +        doc: Number of packets enqueued in the C-queue
> +      -
> +        name: pkts-in-l
> +        type: u32
> +        doc: Number of packets enqueued in the L-queue
> +      -
> +        name: maxq
> +        type: u32
> +        doc: Maximum number of packets seen by the DualPI2
> +      -
> +        name: ecn-mark
> +        type: u32
> +        doc: All packets marked with ecn
> +      -
> +        name: step-mark
> +        type: u32
> +        doc: Only packets marked with ecn due to L-queue step AQM
> +      -
> +        name: credit
> +        type: s32
> +        doc: Current credit value for WRR

The credit member is declared in the wrong place here. The struct
members must match those from struct tc_dualpi2_xstats, in exactly the
same order.

> +      -
> +        name: credit-queue
> +        type: u8
> +        doc: Current credit queue
> +        enum: tc-dualpi2-credit-queue-flags
> +        enum-as-flags: true

The credit-queue member does not exist in struct tc_dualpi2_xstats so
should be removed from here.

> +      -
> +        name: memory-used
> +        type: u32
> +        doc: Memory used in bytes by the DualPI2
> +      -
> +        name: max-memory-used
> +        type: u32
> +        doc: Maximum memory used in bytes by the DualPI2
> +      -
> +        name: memory-limit
> +        type: u32
> +        doc: Memory limit in bytes
>    -
>      name: tc-fq-pie-xstats
>      type: struct
> @@ -2299,6 +2382,83 @@ attribute-sets:
>        -
>          name: quantum
>          type: u32
> +  -
> +    name: tc-dualpi2-attrs
> +    attributes:
> +      -
> +        name: limit
> +        type: uint
> +        doc: Limit of total number of packets in queue
> +      -
> +        name: memlimit

The convention used in YNL specs is to use the same naming as the enum
definition from the header, with the prefix stripped off. For this
attribute that would be TCA_DUALPI2_MEMORY_LIMIT -> memory-limit

> +        type: uint
> +        doc: Memory limit of total number of packets in queue
> +      -
> +        name: target
> +        type: uint
> +        doc: Classic target delay in microseconds
> +      -
> +        name: tupdate
> +        type: uint
> +        doc: Drop probability update interval time in microseconds
> +      -
> +        name: alpha
> +        type: uint
> +        doc: Integral gain factor in Hz for PI controller
> +      -
> +        name: beta
> +        type: uint
> +        doc: Proportional gain factor in Hz for PI controller
> +      -
> +        name: step-thresh
> +        type: uint
> +        doc: L4S step marking threshold (see also step-packets)
> +      -
> +        name: step-packets
> +        type: flag
> +        doc: L4S Step marking threshold unit in packets (otherwise is in microseconds)
> +      -
> +        name: min-qlen-step
> +        type: uint
> +        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
> +      -
> +        name: coupling-factor

The definition is TCA_DUALPI2_COUPLING so either this should be
"coupling" or the enum name should be expanded.

> +        type: uint
> +        doc: Probability coupling factor between Classic and L4S (2 is recommended)
> +      -
> +        name: overload

The definition is TCA_DUALPI2_DROP_OVERLOAD so this should be "drop-overload"

> +        type: uint
> +        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
> +        enum: tc-dualpi2-drop-overload-flags
> +        enum-as-flags: true
> +      -
> +        name: drop-early
> +        type: uint
> +        doc: Decide where the Classic packets are PI-based dropped or marked
> +        enum: tc-dualpi2-drop-early-flags
> +        enum-as-flags: true
> +      -
> +        name: classic-protection

Also does not match the eum definition. Should the enum name be expanded?

> +        type: uint
> +        doc: Classic WRR weight in percentage (from 0 to 100)
> +      -
> +        name: ecn-mask
> +        type: uint
> +        doc: Configure the L-queue ECN classifier
> +        enum: tc-dualpi2-ecn-mask-flags
> +        enum-as-flags: true
> +      -
> +        name: split-gso
> +        type: flag
> +        doc: Split aggregated skb or not
> +      -
> +        name: max-rtt

Does not exist in the DUALPI2 enum so should be removed.

> +        type: uint
> +        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
> +      -
> +        name: typical-rtt

Also does not exist in the DUALPI2 enum so should be removed.

> +        type: uint
> +        doc: The typical base RTT of the traffic that is controlled by DualPI2 in usec
>    -
>      name: tc-ematch-attrs
>      attributes:
> @@ -3679,6 +3839,9 @@ sub-messages:
>        -
>          value: drr
>          attribute-set: tc-drr-attrs
> +      -
> +        value: dualpi2
> +        attribute-set: tc-dualpi2-attrs
>        -
>          value: etf
>          attribute-set: tc-etf-attrs
> @@ -3846,6 +4009,9 @@ sub-messages:
>        -
>          value: codel
>          fixed-header: tc-codel-xstats
> +      -
> +        value: dualpi2
> +        fixed-header: tc-dualpi2-xstats
>        -
>          value: fq
>          fixed-header: tc-fq-qd-stats
> --
> 2.34.1
>

