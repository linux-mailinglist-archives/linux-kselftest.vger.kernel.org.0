Return-Path: <linux-kselftest+bounces-31394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C8A9894D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919463BEDDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33091265CB0;
	Wed, 23 Apr 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgjuVud9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAC216E24;
	Wed, 23 Apr 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410298; cv=none; b=j5qQ1epPorXgX8luV4pp5zQl9gP2S72xR5lwo4tErTE7wQ2ne9q8eUKhmBi6aSnV35GcKkfNwqaEbkxSf28FOVSOdOg50sGbRgk+vpAjXquw0fQlBAwg5eTAaIbhGaJDgsGVjJWy/m2PfOFDGPLLvsgggJtcBVLJyXoxy9HDSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410298; c=relaxed/simple;
	bh=tLhEeR0/dWlpr0q2H5VLyapgnu965andvVyMMjEP8ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hnyOpAK/kzkOzRo+GEFotd4MjIPGrSCQu8SZwScvocANUEnEZpoWYgSn8GQXWmFUHuGGOJqzd7Ce0UZeWChPsNxFg8Fdeb2inxhSq0R/qlyOVLL/A0entD0L16bgHHOzegvboBVhj+lNCs+s6+01JgYHBbQRtoK6vHHNzeHbxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgjuVud9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so71820185e9.2;
        Wed, 23 Apr 2025 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410293; x=1746015093; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTCW0kMf2NqWP/BYLA31IcLDRncMXrQxmocLoFGfDSU=;
        b=mgjuVud9KuH5uaIhSnVfMWRsmpiEgXJ2GMQepcyBtsVHcyWOf7GKYY4Yha2DkUmHkq
         p7EiDhbMpvu4anUmp/x/SUlNOOf8CQAsrmoI70yIJF6jxZ1/hjFrLFe2z/IhtDZ5cfLH
         2rDXCNJauLgqm2jd4sH3Zq0R0xc75TQ3Lqua7vVjE1pVZw7Q2umK1U6024lFMT4DyB5B
         Yb+6KT2J6olhEGd9fpm7JRsrOCeThD2B5Wfw9B+HpjVf3rFRqE3uBkvFK0BmCOQXx5eR
         Aa0JoTI7m9mT85l+pW1R1pCr6fu/P+55dKnyW1JCnPJt/UYHFNqguKew3WUXtzPcUfpg
         VskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410293; x=1746015093;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTCW0kMf2NqWP/BYLA31IcLDRncMXrQxmocLoFGfDSU=;
        b=W/GEh6zPgXzdVWWP/xPSKlVv8BliA4O9r8clG4nNseNtKfmNPmMyz7m9SKbId5lnm1
         SO9J43JVSwcMIoumIi+IWaBh7LzZaC/3eKf1b+eZ9qVXVmfdH/kRuOvvZaHirX4qGoVO
         SjX3HVSPL+y9Ytf9k9xk5ZY+/piPigIe238nKQdFookJ8XgVjU8pJf0gpIJJaCzhdbK2
         SeYmLEs0M4hoDOAJRTSy2CvBxgXjpopT5zYFQhpjOtneKecjGgqS0fE18gifaHw4nDwQ
         RL0BWPOOQa1bvFlmajB5KhEo5v2M4NMYwzVCYQ3RP5EaOjsrU50/aV6ybjnz4ueLW3Mc
         As1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvsZOcnxNVeKCDC9idrnAiFTrZaPtqQlUMym8wbgJZ/nteefFROf7ROz9mHjAffvzXUIjDJxoh2fihuu/CdoY=@vger.kernel.org, AJvYcCXg7TD4jAsuZG1CxZEEyGuR/2zpLrfl5cIfI99MWy1YVGB34fOGs2aWYWsoAkqkNqZrgGAmDKir@vger.kernel.org
X-Gm-Message-State: AOJu0YyuX2LQJZpRtRAFXXnRV6KFtZXsoPuj2tiJ/kNmuzxmBeWSNKeh
	czJK90Flo9eO+B+COoV+92KPy8ODWY+IwYicm+ptjW7e6jXNmfeB3E+TNwoj
X-Gm-Gg: ASbGnculPzcdPl2RNLEaSL4PyNs/IjgjT6dUGdcV+7ctjv1NbV+Su6wafs1bqItx0z4
	cFP7u0LUZa1XpNauE1/cgHSxqEr2XBsZyWU5FjSnWGhOTt7/tjCswRBuhrZTCk0HTR+2yM8iRwM
	G4qnD1dLNzV1oDsIWN4xNxs5EXriy8Hccq/xzYN69aNjBSgnrqss+pke4wX7hxe2vYIOkO00Wql
	RLzeyT4/da/jh4brz31704jJcRBbgh0rytP9RTR/7r5IvT0Oqy6Ml8v2JRYL3SsHuKC5coTfDqg
	STqZ7z1pFZ+oCnQ71IYnCznl6qXg/GrQVj7U1AzRtDTB1tCo3zMTamCPcg==
X-Google-Smtp-Source: AGHT+IGhndCRFypx5BasqWdT+50NXxs2yMhrZUF1X0OHMS5wvK123JM5zE/ItPfF6ohRVUkccDLF6w==
X-Received: by 2002:a05:600c:1ca0:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-4406abfa9demr134180395e9.25.1745410292622;
        Wed, 23 Apr 2025 05:11:32 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:80e4:de9:c3ea:a346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d2254csm24096255e9.13.2025.04.23.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:11:32 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: xandfury@gmail.com,  netdev@vger.kernel.org,  dave.taht@gmail.com,
  pabeni@redhat.com,  jhs@mojatatu.com,  kuba@kernel.org,
  stephen@networkplumber.org,  xiyou.wangcong@gmail.com,  jiri@resnulli.us,
  davem@davemloft.net,  edumazet@google.com,  horms@kernel.org,
  andrew+netdev@lunn.ch,  ast@fiberby.net,  liuhangbin@gmail.com,
  shuah@kernel.org,  linux-kselftest@vger.kernel.org,  ij@kernel.org,
  ncardwell@google.com,  koen.de_schepper@nokia-bell-labs.com,
  g.white@cablelabs.com,  ingemar.s.johansson@ericsson.com,
  mirja.kuehlewind@ericsson.com,  cheshire@apple.com,  rs.ietf@gmx.at,
  Jason_Livingood@comcast.com,  vidhi_goel@apple.com
Subject: Re: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
In-Reply-To: <20250422201602.56368-2-chia-yu.chang@nokia-bell-labs.com>
	(chia-yu chang's message of "Tue, 22 Apr 2025 22:15:58 +0200")
Date: Wed, 23 Apr 2025 12:29:23 +0100
Message-ID: <m2o6wnt8to.fsf@gmail.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
	<20250422201602.56368-2-chia-yu.chang@nokia-bell-labs.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chia-yu.chang@nokia-bell-labs.com writes:

> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Introduce the specification of tc qdisc DualPI2 stats and attributes,
> which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
> (https://datatracker.ietf.org/doc/html/rfc9332) providing two different
> queues: low latency queue (L-queue) and classic queue (C-queue).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  Documentation/netlink/specs/tc.yaml | 144 ++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)

The syntax is not valid so this doesn't pass the schema check and
presumably hasn't been tested. Please validate YNL .yaml additions e.g.

./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/tc.yaml \
    --list-ops

...
jsonschema.exceptions.ValidationError: Additional properties are not allowed ('entries' was unexpected)
...
On instance['attribute-sets'][30]['attributes'][14]:
    {'name': 'gso_split',
     'type': 'flags',
     'doc': 'Split aggregated skb or not',
     'entries': ['split_gso', 'no_split_gso']}


>
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index aacccea5dfe4..08255bba81c4 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -816,6 +816,58 @@ definitions:
>        -
>          name: drop-overmemory
>          type: u32
> +  -
> +    name: tc-dualpi2-xstats
> +    type: struct
> +    members:
> +      -
> +        name: prob
> +        type: uint
> +        doc: Current probability
> +      -
> +        name: delay_c

Please use dashes in member names, e.g. "delay-c", to follow YNL
conventions. Same for all member and attribute names below.

> +        type: uint
> +        doc: Current C-queue delay in microseconds
> +      -
> +        name: delay_l
> +        type: uint
> +        doc: Current L-queue delay in microseconds
> +      -
> +        name: pkts_in_c
> +        type: uint
> +        doc: Number of packets enqueued in the C-queue
> +      -
> +        name: pkts_in_l
> +        type: uint
> +        doc: Number of packets enqueued in the L-queue
> +      -
> +        name: maxq
> +        type: uint
> +        doc: Maximum number of packets seen by the DualPI2
> +      -
> +        name: ecn_mark
> +        type: uint
> +        doc: All packets marked with ecn
> +      -
> +        name: step_mark
> +        type: uint
> +        doc: Only packets marked with ecn due to L-queue step AQM
> +      -
> +        name: credit
> +        type: int
> +        doc: Current credit value for WRR
> +      -
> +        name: memory_used
> +        type: uint
> +        doc: Memory used in bytes by the DualPI2
> +      -
> +        name: max_memory_used
> +        type: uint
> +        doc: Maximum memory used in bytes by the DualPI2
> +      -
> +        name: memory_limit
> +        type: uint
> +        doc: Memory limit in bytes
>    -
>      name: tc-fq-pie-xstats
>      type: struct
> @@ -2299,6 +2351,92 @@ attribute-sets:
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
> +        name: step_thresh
> +        type: uint
> +        doc: L4S step marking threshold in microseconds or in packet (see step_packets)
> +      -
> +        name: step_packets
> +        type: flags
> +        doc: L4S Step marking threshold unit
> +        entries:
> +        - microseconds
> +        - packets

This is not valid syntax. Enumerations and sets of flags need to be
defined separately. For example, look at the definition of tc-cls-flags
and its usage.

BUT step_packets is defined as a boolean in the implementation so could
be implemented as a boolean flag in the API. If it needs to be
extensible in future then it should be declared as an enum in uAPI and
defined in this spec as an enum. Either way, the parsing and policy in
patch 2 should be made more robust.

> +      -
> +        name: min_qlen_step
> +        type: uint
> +        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
> +      -
> +        name: coupling_factor
> +        type: uint
> +        doc: Probability coupling factor between Classic and L4S (2 is recommended)
> +      -
> +        name: drop_overload
> +        type: flags
> +        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
> +        entries:
> +        - drop_on_overload
> +        - overflow

Not valid syntax. Use a boolean flag or define an enum.

> +      -
> +        name: drop_early
> +        type: flags
> +        doc: Decide where the Classic packets are PI-based dropped or marked
> +        entries:
> +        - drop_enqueue
> +        - drop_dequeue

Not valid syntax. Use a boolean flag or define an enum.

> +      -
> +        name: classic_protection
> +        type: uint
> +        doc: Classic WRR weight in percentage (from 0 to 100)
> +      -
> +        name: ecn_mask
> +        type: flags
> +        doc: Configure the L-queue ECN classifier
> +        entries:
> +        - l4s_ect
> +        - any_ect

Not valid syntax. Type should probably match implementation, unless you
want to enumerate the valid values by definining an enum.

> +      -
> +        name: gso_split
> +        type: flags
> +        doc: Split aggregated skb or not
> +        entries:
> +        - split_gso
> +        - no_split_gso

Not valid syntax. Use a boolean flag or define an enum.

> +      -
> +        name: max_rtt
> +        type: uint
> +        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
> +      -
> +        name: typical_rtt
> +        type: uint
> +        doc: The typical base RTT of the traffic that is controlled by DualPI2 in usec
>    -
>      name: tc-ematch-attrs
>      attributes:
> @@ -3679,6 +3817,9 @@ sub-messages:
>        -
>          value: drr
>          attribute-set: tc-drr-attrs
> +      -
> +        value: dualpi2
> +        attribute-set: tc-dualpi2-attrs
>        -
>          value: etf
>          attribute-set: tc-etf-attrs
> @@ -3846,6 +3987,9 @@ sub-messages:
>        -
>          value: codel
>          fixed-header: tc-codel-xstats
> +      -
> +        value: dualpi2
> +        fixed-header: tc-dualpi2-xstats
>        -
>          value: fq
>          fixed-header: tc-fq-qd-stats

