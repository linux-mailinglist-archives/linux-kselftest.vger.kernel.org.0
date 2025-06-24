Return-Path: <linux-kselftest+bounces-35688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D9AE652C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160164021AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D727A913;
	Tue, 24 Jun 2025 12:35:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06D1D52B;
	Tue, 24 Jun 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768505; cv=none; b=Kvhge7SMsBvddM1moW99Dyha88KVs8m+6XPUyPRafJK0yL1kww4BiwWI04DEKfTOhjydoZr4AqWUfXIvKrFtObL7qWZBPr49fbhTP1oicLll+/2+GbWozf2Vsx/gHwVCjX19uiABl/s947QtA8N7ygRDpurVLxsLZ0cESu3hJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768505; c=relaxed/simple;
	bh=vO6kx9P2dBA5m8J1U9nii5EEhuooiv9bKaiWcrrGZBY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHllTAYiJx9LR+Lw1gBSxFwiY1DNJ6H95f4vNZXstOHktmrJchinxyw7Upl0dYD30TK7xQwr9Ks4NqUX+6+tKriqbLeXehyVpsgxoC+xDoozUfV+mzA2dZgwzvMle5nUvxtqZ3FT5SlcGOueF6ROPMVxamO67UaiUi1rZN0nopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cf214200so47543835e9.1;
        Tue, 24 Jun 2025 05:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768502; x=1751373302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO6kx9P2dBA5m8J1U9nii5EEhuooiv9bKaiWcrrGZBY=;
        b=XwH9krYt8G+4y9F3V8QomGpT96vsTEANNYwm/SizHOjIGmZo48qE5P9n1N0o9iktIK
         A3YdYFVze1sFw9Cb2UQNDNv013jKHGfR9NSQCZ9/1zRGz8JDflMGmlHHO6RYf3e8NFKt
         KctYfTH66rFSe0BanNfCs1+mlTv6RqIG/x2tEVTZQyRIxJxOrenr0Cc+Lk5VZ0s+4vna
         hhNHkjD8Mj5C2D8sYnMsPZ5B1vXsoebpcf2MngM7MnNxf/HrUa6n6zKPgEy3l43JfJZ2
         VyTRRPzJxLLWb7tvOVzlBGgnOrhQl4uMF3+ooHlI+hA1EZvgF1i0SrXOf/cugFHzTpsf
         ZjDw==
X-Forwarded-Encrypted: i=1; AJvYcCV4NbgIdtoQM2jlVpzYIppG0uz91OJ6o9hD2PuarJFKnqG8PLmT7k2zDH3tZfuIwIYcNRX4czPQCJv7Iy8KaNU=@vger.kernel.org, AJvYcCX4kzBrWNi1OAoc6g7eR+lqw802z4gg2iBzMcy+DBq4587GMmsv5bfhLLqVc38yRgl2nuhYLcsW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AlYQD6TjZ+9NrML35typA7/fP4sXg8ywThriQK1ev+T+pflI
	xBJSMR81lBADzlk2dmZh9Vv5FQKSgL0qWhGh8N7XWJyjs4wuLC2v0pcU
X-Gm-Gg: ASbGnctWbEXQRaD4GqbbQwtvyHK0I9BH08mojcevcMNW1m/kSC0F7c8uHJ6C3R5XMBz
	9H4HxXv7W0Kd11QcfeAChGbtJkBRh7/61UXZn960193kiHGPz8WVtCdDQVNcVOWdSMzUCuf9ZjA
	V0cq7kkiodIwjgZLSn/B9Z4z/pK46guwCPotueDXkwFqeWmvcC0nnU9W39GGbCn9Gqsej0AEDq1
	js+Fkt3Nvz8zAt93OG7N3WNMp8ej6OqnMl4qujZ5/EmuAfn7yAekdZeKGEXR60eNYZCFsFS5AGN
	lpIGrZabcu1FN3jVMXdzlI44GCzqyyc46z5itiLqMKpctimjz4PedzQDyH4=
X-Google-Smtp-Source: AGHT+IGU5aurfEaFN5yYiteziFoxX752x4NwSEcFi+QXFzqK7qCY3Nfhc7kq1gMvvLwKAlqjQkp9lQ==
X-Received: by 2002:a05:600c:4510:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-453659c484bmr151534765e9.4.1750768501473;
        Tue, 24 Jun 2025 05:35:01 -0700 (PDT)
Received: from [10.148.85.1] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm143029305e9.6.2025.06.24.05.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 05:34:59 -0700 (PDT)
Message-ID: <6f880f49c2d9ef20ab087c6e9d1a6d6c8f6e500a.camel@fejes.dev>
Subject: Re: [PATCH v20 net-next 0/6] DUALPI2 patch
From: Ferenc Fejes <ferenc@fejes.dev>
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com, 
	pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com, 
	xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, 	jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, 	xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, 	edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, 	shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, 	ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, 	g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, 	mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, 	Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Date: Tue, 24 Jun 2025 14:34:57 +0200
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-06-21 at 21:33 +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> Hello,
>=20
> =C2=A0 Please find the DualPI2 patch v20.
>=20
> =C2=A0 This patch serise adds DualPI Improved with a Square (DualPI2) wit=
h
> following features:
> * Supports congestion controls that comply with the Prague requirements i=
n
> RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queu=
e (L-
> queue), without harming remaining traffic that is scheduled in classic qu=
eue
> (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN=3D=3D0b*1) to classify traffic into
> respective queues
>=20


Looking at this, I wonder if DualPI2 would be implemented in BPF.
For example, you could have two FIFOs with a BPF Qdisc, such as:

struct bpf_list_head l_queue __contains(skb_node, node);
struct bpf_list_head c_queue __contains(skb_node, node);

The bpf_list_push_back and bpf_list_pop_front functions are also available =
for
handling these.

There are also spinlock helpers, and the pi2_timer can be replaced with upd=
ates
based on the struct bpf_timer. Of course, there are tricks to consider rega=
rding
GSO, which might require additional BPF helpers. However, looking through t=
he
code, I see a chance to implement this as a pure BPF qdisc. What do you thi=
nk?

Having this as a regular qdisc with the iproute2 tc interface is great,
considering the effort already spent on it. However, since all the operatio=
nal
bits are already sorted out, it might be worth looking into the feasibility=
 of a
BPF version.

Best,
Ferenc

