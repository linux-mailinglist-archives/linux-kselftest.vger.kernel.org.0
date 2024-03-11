Return-Path: <linux-kselftest+bounces-6186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B487804D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66721C21117
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EE3D0AF;
	Mon, 11 Mar 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKgddW3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D733070;
	Mon, 11 Mar 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162513; cv=none; b=AVOAjF2DcLv77AeZj0XnMqvq3gxmTI4iczZjPJdrxCrCxRNTqR+geLmJt1ETNMxp7Xsm8CyeG1vSa6266Y30wkS3HvmP7UDI4bMkYK7kyzR8+U+ofPoSu2oAh3Zx1HnLYp9bk2JNBgkrEak2OIharFDYig7F5wRAN72BSaMU/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162513; c=relaxed/simple;
	bh=oKePPvFOmU7F+ec9ZsP7Ma8O/65orFc90wUDYKchcng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCg8IvMFqMmXD4OFm8XQqwYknWPvkZsAwZ4zcbAjjsEvBIkDQOusK7NPZwxoFox9EM5rNT5cKPVRYaDGpSyZPoD2yPO/mwwlTYzU5+HdHCTSBkv8fsHrpTIBA4NjMM9z4yMKCHeQEPncvr3PbIFSRuGtxYW6ULUIGuUYPulDK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKgddW3y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512ed314881so3734213e87.2;
        Mon, 11 Mar 2024 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710162509; x=1710767309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0X5OChNYE43tEooEk8m8V1aAF3iqUU8zLF/55fXaqPg=;
        b=XKgddW3yAU9xAmP4iT8N/oJLrkDZay6c8NMKfEoPIYjayOWEmJy/pVoA8QUxwBHAtn
         HRWJT1QrTDCaDELcGdA4xPBNCG2/rZZuN/zOo/5506l709000kNmj1DTQ2/Tu7bckjbb
         AOx2unjVvqt/xbS6PuCjmuwtF03ejbFA3kB67Xgy3fdgO+iKtXSb7CZtAHpSbAI1rDza
         POksJix1lAYAQ4BKZsd/V5HqmT6WRDAiRLvfteq8gfc725A3NPr+wYIA2I+8YUC72rL7
         p1tvRz9IsPEFQREBA4U+Z/MSGyZuKlAgcxeI5kKBvXNY2ZtPxrfraC3bldj2vlcKT3gq
         0PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162509; x=1710767309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0X5OChNYE43tEooEk8m8V1aAF3iqUU8zLF/55fXaqPg=;
        b=n9fv5AhUV2FzU5+3fvn/HbOPrHXaXD1r3WPa3yvxvkV+evflQpJsbfy3eN9JAFwJ6x
         JJRy7YQWvBSAEPka24rwyQjo6WcG/SjhUpclAAUZVJHI+9AWrAqWtlnk/J7PhimJK/mM
         xRN5uXYEIuVsNMxaAku8463rPO1FkFi8GkMA1JgyXZ9MVIyUirV2offNWorGP1vnQV8A
         OJL2IyL9CU3+1d6+LnKKsjezj0GAge7RokZdmD9MvkhY6lidoTCwEFVvVpgK/NKeqJds
         /n40JL6kJ/Upg1+1yLT/HViFm0j74z9W/1xpFfelS9dBneteXyq3H5KIvEjICztyGMtQ
         S6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVg6KTvnq6lpxXFhPkJNVl59CO0uy5LiwZhI+dsS0abSjQEaECQMZ2EjZkpSJcrB2MJr0so9e3s/IevJJtERsPdTRZa3Y9u4PGZTd8xQKPsiBwZYNpliJse7Pbg+ZHIVIJmLMt/oHEibiefnQwknFJY6Mm5JMs5XndVN3wzQ7Htn120iL4
X-Gm-Message-State: AOJu0YyvcoGGbtwEkJbEz9uDnbLwLAwtffmaiS6p49U+hPrBl7wxXRvk
	R225FR2uXovpkp9TbMdCvX6uk3ZxrGYaY2GIxMtKlkYQjt4blRAk
X-Google-Smtp-Source: AGHT+IG6HGRuE0IeQuOucerPs8ubSbdUOykENZj21NsPxbybZu3M/4hmmioRP7Lmr0f4GLN7gEWf0Q==
X-Received: by 2002:ac2:4a6a:0:b0:513:1e31:ddec with SMTP id q10-20020ac24a6a000000b005131e31ddecmr4032809lfp.40.1710162509103;
        Mon, 11 Mar 2024 06:08:29 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b0033e033898c5sm6459960wrb.20.2024.03.11.06.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 06:08:28 -0700 (PDT)
Message-ID: <d72bfd79-ce72-49db-b648-930a08b9302e@gmail.com>
Date: Mon, 11 Mar 2024 14:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com,
 bpoirier@nvidia.com, b.galvani@gmail.com, gavinl@nvidia.com,
 liujian56@huawei.com, horms@kernel.org, linyunsheng@huawei.com,
 therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
 <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
 <967ed173-b556-4bfc-b3c8-ff0fc902b951@gmail.com>
 <65eef506331e8_1db78c2941c@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <65eef506331e8_1db78c2941c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Eric Dumazet wrote:
>>> On Sat, Mar 9, 2024 at 4:35 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>>>
>>>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>>>> iph->id, ...) against all packets in a loop. These flush checks are
>>>> relevant only to tcp flows, and as such they're used to determine whether
>>>> the packets can be merged later in tcp_gro_receive.
>>>>
>>>> These checks are not relevant to UDP packets.
>>>
>>> I do not think this claim is true.
>>>
>>> Incoming packets  ->  GRO -> GSO -> forwarded packets
>>>
>>> The {GRO,GSO} step must be transparent, GRO is not LRO.
>>
>> Sorry, I should rephrase myself. The patch preserves the
>> current logic in GRO. These L3 checks (ttl, flags, etc.) are written to
>> NAPI_GRO_CB(p)->{flush,flush_id}, and NAPI_GRO_CB(skb)->is_atomic - and
>> all of these are currently used only in tcp_gro_receive.
> 
> That was perhaps an oversight when adding UDP GRO?
> 
> Simply because the flush is determined in the innermost callback.

It might have been an oversight. From what I have seen it's only relevant
to GRO's UDP fraglist path (it was added in 9fd1ff5d ("udp: Support UDP
fraglist GRO/GSO.")). That's the only UDP path that calls skb_gro_receive -
which may alter the forwarded packets and make GRO/GSO not transparent.

AFAIU NAPI_GRO_CB(p)->flush value is not overwritten in encapsulation - it
is determined by both outer and inner callbacks.

I tried to preserve the current behaviour in GRO - if we want to change
this behaviour I'll gladly do it, although I'd prefer to address it in a
different patch series. What do you think?

Thanks

