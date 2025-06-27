Return-Path: <linux-kselftest+bounces-36018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8721AEC2F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 01:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB604A816D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909B291C0A;
	Fri, 27 Jun 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itKzoUOu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE0291C02;
	Fri, 27 Jun 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066372; cv=none; b=fvsfmo4du5/erlSBLLT5LbdLxdkatXpYkapqB11m77xMpXkpWQ7OBH0aM/CfU3gK/wIi0Mz/d7bAuBRgiyeIGogjqtLnBCoL1732i58NFYVp48ehEDruiocBJW00C6++gV+WacsALNWLEaDWYoHvBWeOvsX3Lg9D4Hb0bJtaOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066372; c=relaxed/simple;
	bh=v56BmeYKzQBOPdOvlOJjHAE5S3lY/mnOHTfpwMRrjbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAZtnZm0peY62rte/+OkfQgve+VrLvOJNrhKxylp32E+PM6YdZyd9CM3lGXlZUpY2B47sI+1PCfXxOkcJeYlzOT7tEGTkh2PycTISSaFL0AnnwJYu6KJkX24UQogMuqIEHHOyXCsI81Ngf4Oja4ngiTL/p5kpuT++XlFstli1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itKzoUOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F75C4CEE3;
	Fri, 27 Jun 2025 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751066371;
	bh=v56BmeYKzQBOPdOvlOJjHAE5S3lY/mnOHTfpwMRrjbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=itKzoUOuJcOyXipAorUlxcybjBWcdrpz+1G4DG2f9LeW2IiZSOseCgU1ZyQgc0C6G
	 qkxAMMQnLsWfglppJwS3PjnoBd5crPhqQU08uq/AGU7mw6i6qQ4kW+BBTZEGYAkbe4
	 5MUrRbMOP7RxYPbHtsjvwt1uTgxp5ReFKrAHb8Y/P8+VhFqTd25Etajevt9iy2ojiU
	 yqUTTP+ZCbY3PIxjez1qyCHfcyiRBPCsbJcde8Etc85v+z1XiSQ2m6S6ixiT1VFlPQ
	 C3rUbCWr/G9E0zHQeiXvvGvWr04DG4Nw0BCvBNsMmade8CVM2vDGhgO6Q0SAujVY6C
	 8nT1TC4eBCR8w==
Date: Fri, 27 Jun 2025 16:19:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: alok.a.tiwari@oracle.com, pctammela@mojatatu.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Message-ID: <20250627161930.385554c0@kernel.org>
In-Reply-To: <20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Jun 2025 21:33:31 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Introduce the specification of tc qdisc DualPI2 stats and attributes,
> which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
> (https://datatracker.ietf.org/doc/html/rfc9332) providing two different
> queues: low latency queue (L-queue) and classic queue (C-queue).

> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index 4cc1f6a45001..8a183799dceb 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -56,6 +56,41 @@ definitions:
>        - tundf
>        - tunoam
>        - tuncrit
> +  -
> +    name: dualpi2-drop-overload
> +    name-prefix: tca-dualpi2-drop-overload-

As far as I understand tca / TCA stands for TC Attribute.
This is an enum for values, not for netlink attribute IDs,
tc-dualpi2-drop-overload- would be less confusing here

Which may in fact mean that you don't need name-prefix,
because I think that's what the default name would be.

same thing for other value enums

> +    type: enum
> +    entries:

FWIW if you don't document you can use the shorter notation:

	entries: [overflow, drop]

> +      - overflow
> +      - drop
> +  -
> +    name: dualpi2-drop-early
> +    name-prefix: tca-dualpi2-drop-early-
> +    type: enum
> +    entries:
> +      - drop-dequeue
> +      - drop-enqueue
> +  -
> +    name: dualpi2-ecn-mask
> +    name-prefix: tca-dualpi2-ecn-mask-
> +    type: enum

you can use

	value-start: 1
	entries: [l4s..

or just drop the values for entries other than first.
in enums the next value takes the previuos value + 1 by default

> +    entries:
> +      -
> +        name: l4s-ect
> +        value: 1
> +      -
> +        name: cla-ect
> +        value: 2
> +      -
> +        name: any-ect
> +        value: 3

> +  -
> +    name: tc-dualpi2-xstats
> +    type: struct
> +    members:
> +      -
> +        name: prob
> +        type: u32
> +        doc: Current probability

what's the probability of ?

> +      -
> +        name: ecn-mark
> +        type: u32
> +        doc: All packets marked with ecn

ECN

> +      -
> +        name: step-thresh
> +        type: u32
> +        doc: L4S step marking threshold (see also step-packets)
> +      -
> +        name: step-packets
> +        type: flag
> +        doc: L4S Step marking threshold unit in packets
> +             (otherwise is in microseconds)

Why mux two distinct values in one attr and carry another attr for the
unit? IMO it'd be more idiomatic for Netlink to define two attributes,
one for threshold in packets and one in time. And enforce that only one
can be sent in a message (probably using an explicit check in the code).
Conversely only report one in GET / DUMP.

> +      -
> +        name: min-qlen-step
> +        type: u32
> +        doc: Packets enqueued to the L-queue can apply the step threshold
> +             when the queue length of L-queue is larger than this value.
> +             (0 is recommended)
> +      -
> +        name: coupling
> +        type: u8
> +        doc: Probability coupling factor between Classic and L4S
> +             (2 is recommended)
> +      -
> +        name: drop-overload
> +        type: u8
> +        doc: Control the overload strategy (drop to preserve latency or
> +             let the queue overflow)
> +        enum: dualpi2-drop-overload
> +      -
> +        name: drop-early
> +        type: u8
> +        doc: Decide where the Classic packets are PI-based dropped or marked
> +        enum: dualpi2-drop-early
> +      -
> +        name: c-protection
> +        type: u8
> +        doc: Classic WRR weight in percentage (from 0 to 100)
> +      -
> +        name: ecn-mask
> +        type: u8
> +        doc: Configure the L-queue ECN classifier
> +        enum: dualpi2-ecn-mask
> +      -
> +        name: split-gso
> +        type: u8
> +        doc: Split aggregated skb or not
> +        enum: dualpi2-split-gso

Keep in mind that values in netlink are in 4B granularity, so all these
will be carried as 1B + 3B of padding. If there's any chance you may
need more bits in the future u32 is a safer default choice.

