Return-Path: <linux-kselftest+bounces-31395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D164A9894C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF47178DC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2D26C3A3;
	Wed, 23 Apr 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqtxG3Dr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B821B8F2;
	Wed, 23 Apr 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410298; cv=none; b=gzXasSxsoHhIekcXXqOSRsR/1pT9BLwgtNpb7jP91GouGkUqhQMSsB/kv2DcX4rA/tfGGpXro8deHgXucVTeMg9WaH7xvrOZpg7zoaP0R1GheuKQAkrLYk5BJ/0Wy5Q/7QFS1WbAOsRV9CXsWmWFPUn9Rybju4ZIBDlVqdtcO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410298; c=relaxed/simple;
	bh=Y5CMdkLAs1EhaZzP2ORXYybX4SQwoCCxeWBfkyzxj5I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jO/uGiZEQ/aRbKkHj8a4dQAkoOzrHdGG4xUNKKUB2SfnWUCz4SX95Wo9MeDdwvTKCxP8ziTlc8xYhPu4W6OcL9DWXvg5/FAmHSYJpmqccmzIbk+1F15H1PqFQ1WsE5XyZHzZscIZdM69Z/ChqeB6FIcDATJxjz+TuBzt/uR5XBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqtxG3Dr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso47180695e9.0;
        Wed, 23 Apr 2025 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410295; x=1746015095; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/n/LpA+jm38OJGDkm2NGK6n3gVlFyytgh1SrWBnTWMM=;
        b=bqtxG3DrT4+9mTK8F/GLPfGClKNLFClfsNsX2fZFeRVR/LPZUgxUVMDLOlB2qgdxGQ
         BxDoucLX5D+mBxB2IEn192y4sMsdrnR9lLNN/FZ5h9iP91KmZXIuctZqpaSRDWYZW8rX
         AQ95CN6x/e1l/BM+OvQZ6TYGwrInz6uHMi7cQWskLKghgtsxEHMZfUwPtA6En1us/p0f
         OkTHJ3n2ANr2dem61H3AvqR+tl+dSdlQPlsgk/qnRPHBRtP2LzGbsd8el4sHEN/w0kLU
         uJ+rw1kfh05h7IB4ZUPeFxeCq9+XlmHBkT4rvRgEPTlQU5j3q/Pdr6mNnke56NEV/UzM
         qycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410295; x=1746015095;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n/LpA+jm38OJGDkm2NGK6n3gVlFyytgh1SrWBnTWMM=;
        b=uTH8rOkJMEo2he0EEkd/LrpEvPKR4mJw1F0d1+jgmsCegzA6daaeV51+Pu6K8TNrEg
         /5nC6sGRkdsX7DUgW/TCXUAQf2opzIvYLl2JGUYt3bo3PV6SqS2BGarCfNKLoD1nmCQ1
         IuuGhjagMVXbykNNPFA9QZooTfbbtzp1inuuiV2cgopLsh5ukTH4XGAfJ7U4Lrtc0sR+
         IOpX3CfSd2E9FPPJ5Ym3D9i+FcEW1DJ4lCNYZQWp1gq5lQL8+yoD9ihCf4u99uuBoOA4
         lp1a0vb8Mdi4O1wpC9ywbeFT8+0aZHAJKMuEG1I075glyv4k8R92VsyypzcGCE2JyCYr
         ws/w==
X-Forwarded-Encrypted: i=1; AJvYcCV4h6/zJZ0TWPuPkjub9mtlwFuoCcX+9/o1DWSjXhbdEV3bbnBm9LIw2kt6ptH8LFCJNuSF0AUr@vger.kernel.org, AJvYcCX86cqLiblo4KxuilUW/huuZZzOECZJe5yJdLJdIyWvNsjYDRgXceFoXfMT0dYoXFidRgpmzAtmKFlgP2WVjQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxin9MaWEVMhJHoWEtqBLM3taIaB+9oOzRL39jh35U7/eEWDuad
	7PLzJ7xbLeCFmnj9WGzwCf4BN7Ugo2QgOVF4sVDb0LfMwBT/hH6Y
X-Gm-Gg: ASbGncvjcMWDGIqc9a9oHHpImmjXjw837c/mLD4RSU2uZtGWcaLkZ0K3oQkKkQT0pPx
	6jR7lwwgr8+I/kPUQkUrnSlImyTbJ0kMfM+N7DvTFJb1SeuEjELhcT4Dxe+ChvKLRJ8Z3oaSA2I
	Mn065NWdgVuK7CCTlKQDpjLBDJ3WfvAB9OW3Jcrh5qGOIZEpgrEffy+o8iLuAGUPZj6Qi2Nb4tl
	fgHprMerHPUBZFgqELGPXhASIpRKwvE0Ud4rkPTj0FJF3mLdmuq4XZCBEswCsCKoEOSMphUWNtT
	IFNSr8FJCD9NR4MghzOxMoo7kz/iizSIPAFK2ZTbt+ejgI/VLAkL5qTzvw==
X-Google-Smtp-Source: AGHT+IHMojiBwktw3Qsn3mOvuwFiKqpvKDv7hKkk5+79w1uq8RNs8vTro7HiHqmIDV3Z5zCsl7Xh+Q==
X-Received: by 2002:a05:600c:1e8f:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4406abb1128mr185778755e9.16.1745410294581;
        Wed, 23 Apr 2025 05:11:34 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:80e4:de9:c3ea:a346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d3eb2esm23578495e9.34.2025.04.23.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:11:34 -0700 (PDT)
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
Subject: Re: [PATCH v12 net-next 3/5] sched: Struct definition and parsing
 of dualpi2 qdisc
In-Reply-To: <20250422201602.56368-4-chia-yu.chang@nokia-bell-labs.com>
	(chia-yu chang's message of "Tue, 22 Apr 2025 22:16:00 +0200")
Date: Wed, 23 Apr 2025 13:03:28 +0100
Message-ID: <m2ikmvt78v.fsf@gmail.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
	<20250422201602.56368-4-chia-yu.chang@nokia-bell-labs.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chia-yu.chang@nokia-bell-labs.com writes:

> +
> +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
> +	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_TARGET]		= {.type = NLA_U32},
> +	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
> +	[TCA_DUALPI2_ALPHA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_BETA]		=
> +		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
> +	[TCA_DUALPI2_STEP_THRESH]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_MIN_QLEN_STEP]	= {.type = NLA_U32},
> +	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
> +	[TCA_DUALPI2_DROP_OVERLOAD]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_DROP_EARLY]	= {.type = NLA_U8},
> +	[TCA_DUALPI2_C_PROTECTION]	=
> +		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
> +	[TCA_DUALPI2_ECN_MASK]		= {.type = NLA_U8},
> +	[TCA_DUALPI2_SPLIT_GSO]		= {.type = NLA_U8},
> +};
> +
> +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> +	struct dualpi2_sched_data *q;
> +	int old_backlog;
> +	int old_qlen;
> +	int err;
> +
> +	if (!opt)
> +		return -EINVAL;
> +	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
> +			       extack);
> +	if (err < 0)
> +		return err;
> +
> +	q = qdisc_priv(sch);
> +	sch_tree_lock(sch);
> +
> +	if (tb[TCA_DUALPI2_LIMIT]) {
> +		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
> +
> +		WRITE_ONCE(sch->limit, limit);
> +		WRITE_ONCE(q->memory_limit, get_memory_limit(sch, limit));
> +	}
> +
> +	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
> +		WRITE_ONCE(q->memory_limit,
> +			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> +
> +	if (tb[TCA_DUALPI2_TARGET]) {
> +		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
> +
> +		WRITE_ONCE(q->pi2_target, target * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_TUPDATE]) {
> +		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> +
> +		WRITE_ONCE(q->pi2_tupdate, tupdate * NSEC_PER_USEC);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ALPHA]) {
> +		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> +
> +		WRITE_ONCE(q->pi2_alpha, dualpi2_scale_alpha_beta(alpha));
> +	}
> +
> +	if (tb[TCA_DUALPI2_BETA]) {
> +		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
> +
> +		WRITE_ONCE(q->pi2_beta, dualpi2_scale_alpha_beta(beta));
> +	}
> +
> +	if (tb[TCA_DUALPI2_STEP_PACKETS]) {
> +		bool step_pkt = !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);

Would it be better to define TCA_DUALPI2_STEP_PACKETS as type NLA_FLAG
to avoid the u8 to bool conversion?

> +		u32 step_th = READ_ONCE(q->step_thresh);
> +
> +		WRITE_ONCE(q->step_in_packets, step_pkt);
> +		WRITE_ONCE(q->step_thresh,
> +			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
> +	}
> +
> +	if (tb[TCA_DUALPI2_STEP_THRESH]) {
> +		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> +		bool step_pkt = READ_ONCE(q->step_in_packets);
> +
> +		WRITE_ONCE(q->step_thresh,
> +			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
> +	}
> +
> +	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
> +		WRITE_ONCE(q->min_qlen_step,
> +			   nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
> +
> +	if (tb[TCA_DUALPI2_COUPLING]) {
> +		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
> +
> +		WRITE_ONCE(q->coupling_factor, coupling);
> +	}
> +
> +	if (tb[TCA_DUALPI2_DROP_OVERLOAD])
> +		WRITE_ONCE(q->drop_overload,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));

Type NLA_FLAG?

> +
> +	if (tb[TCA_DUALPI2_DROP_EARLY])
> +		WRITE_ONCE(q->drop_early,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));

Type NLA_FLAG?

> +
> +	if (tb[TCA_DUALPI2_C_PROTECTION]) {
> +		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> +
> +		dualpi2_calculate_c_protection(sch, q, wc);
> +	}
> +
> +	if (tb[TCA_DUALPI2_ECN_MASK])
> +		WRITE_ONCE(q->ecn_mask,
> +			   nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
> +
> +	if (tb[TCA_DUALPI2_SPLIT_GSO])
> +		WRITE_ONCE(q->split_gso,
> +			   !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));

Type NLA_FLAG?

> +
> +	old_qlen = qdisc_qlen(sch);
> +	old_backlog = sch->qstats.backlog;
> +	while (qdisc_qlen(sch) > sch->limit ||
> +	       q->memory_used > q->memory_limit) {
> +		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
> +
> +		q->memory_used -= skb->truesize;
> +		qdisc_qstats_backlog_dec(sch, skb);
> +		rtnl_qdisc_drop(skb, sch);
> +	}
> +	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
> +				  old_backlog - sch->qstats.backlog);
> +
> +	sch_tree_unlock(sch);
> +	return 0;
> +}

