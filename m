Return-Path: <linux-kselftest+bounces-10180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB28C592A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBB6B213E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6E17EBB4;
	Tue, 14 May 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqU/sBjS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6C17EBAA;
	Tue, 14 May 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702254; cv=none; b=PgDDt6V1La9m7Pg/XkNlYiHTwHimwI2+/CNWBZu8LXgrCdOjnnbpwPg/EPP7I1ArfvLOtXLtvHtfvCekctltl3mNjcjI03vdvW1Vd4BShZiYG2Lc+ulNmxJrKp/6SpTFtAL3/1D0V72fV3cStNeosquUidp5vpTIMDLFIFeQLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702254; c=relaxed/simple;
	bh=7vQ9caJ69PPA/iWpxP0PVdG/Xnyf24O2zVxjSm9eec0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asedzKwJ8iF1eOh3iECzKZrqAvDHsaf0MJErPcvJZnhWDyIcIcPbOrXa1h0vOxGcfwq3WYHMG8X0P4x59qjCW5i/gKcdWC2MVOrFYPLWMPmLNFY4zLj6iML++oCB7VGB9OAC+VPV2UJ85P7fk2K1qkVMA8zRySMciaUVgRPfih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqU/sBjS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34d8d11a523so3650309f8f.2;
        Tue, 14 May 2024 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715702251; x=1716307051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+d4421rpsL7HiUws1Ztdbm4DVzL1jztBkW9+LQ+UBo=;
        b=dqU/sBjSwLu4bozDDv2XKBuqOl8eeZ+3hp2B4XnRatnNrIVuWow/8w1/b20UMc5vG9
         uyJc0Jyr0A0fUDN/2UYa9eLtOQs9G10nQIfz+8C6o+g8xUYPR7d29TRLJGgJofiSnl7L
         nQ0FwOVRb3a/0qBp1OwPapDuonBup8t2zP4xqi9wwO2852/YFjBB03w+B1vmoclsQf+j
         UstRiJ74Qb+tiimw7tlTEYZ5V438JMDuQx16oNOPCV2QpgWnJTallS/8T7G2I2RRNuzu
         A+EN6bsGiA7cYNO7gRPBXmaEA3wG1Um9oXXXQGVsfWvNhSF0PFttkFowvfxZLmV4UWoJ
         Tkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702251; x=1716307051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+d4421rpsL7HiUws1Ztdbm4DVzL1jztBkW9+LQ+UBo=;
        b=uupcYeRcfrI3YEzv51OkDY3M4UXuGpV5bGPWlsz2TWWGxVZ/1am0Lc5B8SqFQ4/r5M
         QAgjylRk764qqgSesqajSOwEkUqJ51OqGpst9DsAJ5tL0KIesDcyIjQ2tKbToC6DJraJ
         zJCqBkXL7oV6bYWkTPM/2ozhGOPL817WXNXwJqkU44PVF6kU55VmU3zeYY6p7fAbF1Sh
         4ZZCM3eje51uG1efFzRNamNE+s/KcL517ZilY8lWP0EQAAn3YkkTSkivt60bLmdZtoK3
         zxZrECXBDr0pgm7mBGfY0mwEZ5W82E7RXTmtfW0RBawnMVxJPU975IQpyZZF2RxUm+gv
         1i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUap3VSv6HTQF2yDeTOgGFNlMuT6uY5xLevdpqs+YebtwPK2vTIvlzlvjsfKaGoS2xqN2fplzad/BRXb2PGGrakOwRYSZudULcHgLxbEGGRQghNS2ruvMYTNqqTfxI4txF4hZFaIdF9IVTyoaWntVTjsjsXf8e4NGKTg79ppz+OxQCoxKOp
X-Gm-Message-State: AOJu0YzyGbJAlcncBZrkdQQ9bDnJq63YxnL9B/uMCm2Sicqlwt6q5c1d
	69XqDKh7GzDuv5JgZcqNO+BTZ+OjB4d66KyAO2FVxiOvWS+AKSko
X-Google-Smtp-Source: AGHT+IGfTM40WEprBTch2H967ZRRzRzKTT0rxn3GV9l1lNsS/HTRokQXI1/DIIFxF4ck9xhTstklVQ==
X-Received: by 2002:a5d:6451:0:b0:34e:34c5:2312 with SMTP id ffacd0b85a97d-3504aa62fd3mr9068696f8f.59.1715702250770;
        Tue, 14 May 2024 08:57:30 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm14042487f8f.107.2024.05.14.08.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:57:30 -0700 (PDT)
Message-ID: <8e0b027d-4d30-4f0f-82ef-113287f17c6a@gmail.com>
Date: Tue, 14 May 2024 17:56:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Jakub Kicinski <kuba@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 alexander.duyck@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240509190819.2985-1-richardbgobert@gmail.com>
 <20240509190819.2985-3-richardbgobert@gmail.com>
 <CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
 <20240514071407.257c0003@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20240514071407.257c0003@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jakub Kicinski wrote:
> On Tue, 14 May 2024 14:13:21 +0200 Geert Uytterhoeven wrote:
>> On Thu, May 9, 2024 at 9:09 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>>> iph->id, ...) against all packets in a loop. These flush checks are used in
>>> all merging UDP and TCP flows.
>>>
>>> These checks need to be done only once and only against the found p skb,
>>> since they only affect flush and not same_flow.
>>>
>>> This patch leverages correct network header offsets from the cb for both
>>> outer and inner network headers - allowing these checks to be done only
>>> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
>>> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
>>> more declarative and contained in inet_gro_flush, thus removing the need
>>> for flush_id in napi_gro_cb.
>>>
>>> This results in less parsing code for non-loop flush tests for TCP and UDP
>>> flows.
>>>
>>> To make sure results are not within noise range - I've made netfilter drop
>>> all TCP packets, and measured CPU performance in GRO (in this case GRO is
>>> responsible for about 50% of the CPU utilization).
>>>
>>> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
>>> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
>>> net-next:
>>>         6.94% [kernel] [k] inet_gro_receive
>>>         3.02% [kernel] [k] tcp_gro_receive
>>>
>>> patch applied:
>>>         4.27% [kernel] [k] tcp_gro_receive
>>>         4.22% [kernel] [k] inet_gro_receive
>>>
>>> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
>>> results for any encapsulation, in this case inet_gro_receive is top
>>> offender in net-next)
>>> net-next:
>>>         10.09% [kernel] [k] inet_gro_receive
>>>         2.08% [kernel] [k] tcp_gro_receive
>>>
>>> patch applied:
>>>         6.97% [kernel] [k] inet_gro_receive
>>>         3.68% [kernel] [k] tcp_gro_receive
>>>
>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>  
>>
>> Thanks for your patch, which is now commit 4b0ebbca3e167976 ("net: gro:
>> move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
>> in net-next/main (next-20240514).
>>
>> noreply@ellerman.id.au reports build failures on m68k, e.g.
>> http://kisskb.ellerman.id.au/kisskb/buildresult/15168903/
>>
>>     net/core/gro.c: In function ‘dev_gro_receive’:
>>     ././include/linux/compiler_types.h:460:38: error: call to
>> ‘__compiletime_assert_654’ declared with attribute error: BUILD_BUG_ON
>> failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed), sizeof(u32))
> 
> Hi Richard, any chance of getting this fixed within the next 2 hours?
> I can't send the net-next PR if it doesn't build on one of the arches..

Hi Jakub and Geert,
I'm only seeing this mail now, sorry for the late response.
I can fix this within the next two hours, would you prefer a standalone 
patch or should I add it to this patch series?

