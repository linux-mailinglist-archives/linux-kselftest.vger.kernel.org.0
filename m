Return-Path: <linux-kselftest+bounces-44938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52951C3A711
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29AA3AEF71
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032D2F0686;
	Thu,  6 Nov 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqxWTnNI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="grDVQcA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B52EB5BD
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426640; cv=none; b=Hsa+JolCo0yYESUl5FizlqIhlwA4Ph6xwC91W1Jed2zR1a/bADM3jKTlnLyU4e/0RQ+IiJC2AhZz/zxon2OSAR3p8tvegZ/WJKKnTI6G6cL6Mk/VEYKlrwLLLcskfd1b1SMk3APfxBd16W//pFyin9UNZIOZedgE6kqDZfBZFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426640; c=relaxed/simple;
	bh=9invMdERfhYKNnXg74LQAFbXckBFXN636tVMG/vPhmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=THkyQ2kNm6p3pyQCdcBAQ9lYhmVKOJynPeyanvkO25zUvXqXWMyq6emYDniTWrwxmtQYIKDR4LpplypNyKFxYckmx8eio68FaHEIQt4tOe/QQMgmxjiFSyPZ8sbHifiyRU2pwI9YXPVH3u8i/my4bpwhgRmGlOmYIXweCvrAPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqxWTnNI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=grDVQcA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
	b=VqxWTnNIHukx3FndNseXfptaDOfwT/LREH8Cpog1TiTWjJHAYj1IVcG6JkBNEYu52TiCcg
	anFOqoHf9Tnyqc9KJKZwN4jtMGClm5f2/KOhcb9lSj17y8/88tkYFU751eKWaSU2PcWMLw
	CbU5icDS6lJDYS7h+nL6fa7gw0KWmpE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-vOV3IQEEPI2vjPlqK6GQbQ-1; Thu, 06 Nov 2025 05:57:14 -0500
X-MC-Unique: vOV3IQEEPI2vjPlqK6GQbQ-1
X-Mimecast-MFC-AGG-ID: vOV3IQEEPI2vjPlqK6GQbQ_1762426633
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso885843f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426632; x=1763031432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=grDVQcA4IIFdE0So8kwToiBQbNlLPgaIdDPiSxX+C/FuB++X/USEZOPz538ddu4iNT
         Mx3ebMoFz2lRn7MwLwXTUuMCHAt5XM7Ytnqr/Zu4kHRU9+4cgSpAIyXWXl3CVkXog45d
         BwKJucxcUPFMcjsl3o2eliFK4MjWROxAhSQRlQjV58OvFAHMwk8VA41EDUKctDdLYj++
         uhODnFr1vzcRSSG0GwusM9vO250X/D4dXLaPhVLjkEHw6A80FmaeqPQcPOT/2xGkFxuc
         QiCGAWA7ljTZNUhxTHi1t2+CMf/DRs/ayYeucX0R4dZqTenDsfpLK4E+G3+/pT8NnFMq
         0GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426632; x=1763031432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=RDxxoOCEXxnkI3CUMi0qcd6ql35Yf8VH3u4tpLuuDNuk7IA7u+jMRMFDY0uDtQ9iwV
         +6ni3YQcqZgHrvHQ/oiYvJlurbrFHGSIvKbQI8cNP7uO2tq4wGKezXHXa5QEmCW3UHmu
         rllgK/zTaTKpaxpz/B8RBkhmNZFOvqQrhW4MYCWyEMjYQEHCwY6GuFI0ZIyd9lKQZai4
         ztKALHMicThcgn4gKlsuapKq3segQSS0yflcBUIzb2xkoO5//zSHbjFpu8mgZ2d0xvBb
         /xvzw9RcMTANeMuvwmXyAL5nq8/VHZu1yUG83ecSRspbbIBRMaidWLMUZRjkYYe2DNid
         cCSw==
X-Forwarded-Encrypted: i=1; AJvYcCVaIsyxhjvUybhqgSsTVDP0h1e3jlwq3W1BZnoJfxtqRHAqCNL+EhMY2W1JShwVjy7VJIMEZdOcvlJDk+L1fL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+snkBHPLpUfiZrST72cGYu09qm7dVVrjlw/+zIEI46HkCeMCN
	nashAhiLjOwuOvmmI4lwQUQxU1zmslQjamv/K3gftpiaObJP+rOJz7LPkstO7AOpTvEumieJBq2
	fXBPkrCAfUGL3pNcCtBurfzLZf6fIPIO4G5RZ07KH/DpLkKOZW66e0wF72Kqyzpm3GxdQqg==
X-Gm-Gg: ASbGncu5ORZ3pKiaK5B40qaMG7hcxabFHExBSCw0NJ+M2KBhjzXcchGAFbx8o7jnRa1
	9UHdcUcochiCJyCInbnmQhqxd2kgclqqUEtBmjoZrGFefi6q0c9FkCXwRJomXngbGRw7aEhwoTO
	WpdgeWjaMG27cGaxVRhtS5+VLbTFxs7mngyoy+8jR1J9iWtZ4X0L3WsndV+e7n7lW8GgXHtONZX
	tIoXHYNRPkTAa0FJ5AJ8f/xJj4BB8VrJFHB9XSAzyq5x8uN6rlGkpifvZ9tsxZWyKraSvRq2cZp
	b30zmR8Ffy0T8qhQZ3KrcOj6rmIdxB/xlIIc41HWrKcxudRyRyt/Ky2lQvL+D45L/rYguojUgZZ
	Mnw==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087646f8f.20.1762426632515;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuo4Zz37FAjgeqMkvLjK2yjkrDZq4CtR/TEtSlcvQWi/2zCplPBisLlN9/n2avyBib7PRi5Q==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087626f8f.20.1762426632119;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49baf4sm4127409f8f.33.2025.11.06.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:57:11 -0800 (PST)
Message-ID: <2f38933e-f24e-4a14-a906-0d06bc194a21@redhat.com>
Date: Thu, 6 Nov 2025 11:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 01/14] tcp: try to avoid safer when ACKs are
 thinned
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
> 
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:
> 
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     /* XXX 4 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 177 */
> }
> 
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     u16                        pkts_acked_ewma;        /*  2756     2 */
>     /* XXX 2 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 178 */
> }
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


