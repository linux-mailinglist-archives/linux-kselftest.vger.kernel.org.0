Return-Path: <linux-kselftest+bounces-10766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54218D1404
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D7A1F242AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ED64CB2B;
	Tue, 28 May 2024 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAv7O3FZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3061FC3
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874898; cv=none; b=raLc+sLr8aCDEGwOAhRjiJjZxRD8A0HxFIiWudzDUYZULY4jNIp+atofv1JPOtPzNN9YIfntG1rBTu3AXZxr77N44KObLfIOsvtVL5k8KIcHMxj53BzDpz6T5jCDTejFTbvebpgd9gMLP4OgBvCQyOhWttkT0WmwFJV1PwYGSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874898; c=relaxed/simple;
	bh=L4z1GwiLghVV3s9DN9AH5YgcV8FdHVPsxm5YvTbRa1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWzPOhPs0ggxDVEOkeoAcsDzaU5mSzbREbt9iyD7yYFaFggMnrsFkn5QEdFdN5EPv8DNNB/XNcy+jnj8bUHtiTM4d3WopFj9Oak5H5i32HI9TzuyPaVKpgNfqrVHOIrroKXZ3I3TEQ0BzgC5hu76Lt9JlY0gbXfPXlJHOu+K/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAv7O3FZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso24800a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 22:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716874895; x=1717479695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4z1GwiLghVV3s9DN9AH5YgcV8FdHVPsxm5YvTbRa1Q=;
        b=dAv7O3FZEjAElFhXOBJarE9l9vfgkooZZGPKVDPpghk6erPT2Ug2gxSbi3Zzx5GCPw
         YMBvNI0SzoSE19hnajVxmVda4HakhcuObfeqlVlTYPlUoqfeSEGb8DjvKSq9YQtqfpcG
         uny1EbaPrd5Gy98t7WZdhUlxPPKvUXcBnHsQZ/mQPYcY4MwurQAUdHl8C74/pxa4sQm4
         LkxSyKM5IcQXhPXycNN+/aS4n6KTvbSA/y436ZfR4ayQKcXPtq/b3GteiEkFTwICUy0h
         C4eDTmrGTXlYj3nwduuWDgleMc2VVPb3t5ProsZWYHrnbCB5SRsKc4hTdBO1q2TvPRip
         uPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874895; x=1717479695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4z1GwiLghVV3s9DN9AH5YgcV8FdHVPsxm5YvTbRa1Q=;
        b=oRYXSHC5l9VzJD3EEaOx7Kx2Iak28Q+grFwT7atGdQkM/H6ZUj/VClhm/PJRLVqlmv
         sj+26QmFiTXBdaFUZxgxCSLMuiWaMiiWn4a14j1T/F5plGqyaU+YKm7ZVBc9M6wH+gR0
         XU22g2NoJ6ZN1LXBoR+w9GKE+3tRepKocAlknLjQucMdEJHuJ/480lvqhENlf1dvGkEh
         bqmWEU7B4BDnQkBqjhVT2733YMJW9i0eXKHuOBvHSISSKlXezzkzvl2ecWqVK1a65eoU
         aKKJEjvlhZkzgmMXcON5BxikrtCcsuGk/qXBEl9zeyzzLjHUl9vaht/FEuf4uScxlJty
         QtFw==
X-Forwarded-Encrypted: i=1; AJvYcCUFEP0chZuDI0CEBMkXgSUCW/xonUxCgLkkP7SrlP4DGpUvdoTq4s2yQVVwVRpjonNjlj6uWGpYSEZU+g8gXHI0DSkm3Vp/xfqLBViL+I0r
X-Gm-Message-State: AOJu0Yx+dP+5Yh0hy4e9F4fiwh9NSe35t4VRVx6vfoO2VrclaRH7agb8
	GRa4LBKfVRdYWG+8En3swzlFvcgDPxlOh8ckqX0QlfbDHuFVZoTSmMd4lmq3hmIuckXlz8peulh
	NE5rcw0ZighqoZ5s71g1oxhTudUEpRlk97IM5
X-Google-Smtp-Source: AGHT+IGpQ7AHPE0u9meAaHEYfLkUcVOnrqCQ+muOIKpu8fQq/blVVdVQQe0KfAeFfrKGsBQp9Hl2xTsN9gd3vOP530o=
X-Received: by 2002:a05:6402:5bc1:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57869c1b18cmr250298a12.7.1716874894884; Mon, 27 May 2024
 22:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527153955.553333-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240527153955.553333-1-vladimir.oltean@nxp.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 07:41:21 +0200
Message-ID: <CANn89iKKSCwcjcS2wr0gOGXd3SeWexYKd28=f=iwxnc11dRh_Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: taprio: make q->picos_per_byte
 available to fill_sched_entry()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 5:40=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> In commit b5b73b26b3ca ("taprio: Fix allowing too small intervals"), a
> comparison of user input against length_to_duration(q, ETH_ZLEN) was
> introduced, to avoid RCU stalls due to frequent hrtimers.
>
> The implementation of length_to_duration() depends on q->picos_per_byte
> being set for the link speed. The blamed commit in the Fixes: tag has
> moved this too late, so the checks introduced above are ineffective.
> The q->picos_per_byte is zero at parse_taprio_schedule() ->
> parse_sched_list() -> parse_sched_entry() -> fill_sched_entry() time.
>
> Move the taprio_set_picos_per_byte() call as one of the first things in
> taprio_change(), before the bulk of the netlink attribute parsing is
> done. That's because it is needed there.
>
> Add a selftest to make sure the issue doesn't get reintroduced.
>
> Fixes: 09dbdf28f9f9 ("net/sched: taprio: fix calculation of maximum gate =
durations")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

