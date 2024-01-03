Return-Path: <linux-kselftest+bounces-2613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0B822F15
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B522834BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F51A28A;
	Wed,  3 Jan 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrvKS9JS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438A1A27A;
	Wed,  3 Jan 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368abe1093so9215207f8f.2;
        Wed, 03 Jan 2024 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704290495; x=1704895295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BErBM0wPdwvSBc33sZfKMWNPmjAg4dmUERmQ8FyzhY=;
        b=DrvKS9JS9cChm6u3o/0mBK1GiKFO187SNG2lfYMfO9+zOLXYmJlR0LFbaihn/pE0g2
         KnxYI12xtbNumNf894YLjaOcSC1GCsH2a3Om6pbY7XOu4/wjFld1THXvctZK7FwPFDo8
         hqYfmCk1aIq43fAdpTFdEHlnFsSr1sovzK8sIz2VAXjr3d7FLaJYNr7P0U+GAxFxC0e/
         xLUmGzbuu8av7igwhJJqqzf9/dP4RPmg75XBlmjTTXybLhNgjKsESbPeNkLV64jR0tuE
         PXdy26ZSo2G7B/q2ALKZa0XeB0UnOUbwRpFoImk01zJSEhsHSWvMvmiabVSkFqbV2f2k
         KGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290495; x=1704895295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9BErBM0wPdwvSBc33sZfKMWNPmjAg4dmUERmQ8FyzhY=;
        b=uRrk1mnbbtPB1XI0xO1P2mlLVj8aKcrUEggGVpHvYbg7YrmYl9I5h6kIQDeUULbTiU
         GSQ6QkXjD7RGsfFxjGoIBXaTfjgwxCRt0OVKsmhsSiRakGqI1iP0bHBkeUzYGNxm3M34
         koX5RP2nDHsTSQ2hEZaB0LHBit48QvNhvA3U+StP0SYWgoqmCTorf1D2TdWcDtP2uwEJ
         VbVqYXc5A6hwL2PQzD38uWavOSmm30wbXvqtYS75CJZHATB102w6Prw40Qaj0BxPXNYT
         eaf1cEjG69FBEcjmLlmRWYe2mB49B338B9j3LK6vJHxMdjylZhdwH9LCmqT1IFUfdJQv
         EzeA==
X-Gm-Message-State: AOJu0YxeXirKHvyLeebeYhbl5+PnOp0q4cUoUeXu3fku52u/bwXkcr0t
	jIBHnTJmGdJGpxLtkrqhE0o=
X-Google-Smtp-Source: AGHT+IFdZ3buW4ywokrWfvLiSPOyxmG+Mp6bHvVAaY2H43y0Cs4nR/z1KL6Q4m42TETaPWuDqov5gQ==
X-Received: by 2002:a05:6000:184d:b0:337:3de5:d70f with SMTP id c13-20020a056000184d00b003373de5d70fmr2772418wri.102.1704290495296;
        Wed, 03 Jan 2024 06:01:35 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b003372b8ab19asm12025202wri.64.2024.01.03.06.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:01:35 -0800 (PST)
Message-ID: <50450c53-caa8-49bf-a718-5819a4263e9f@gmail.com>
Date: Wed, 3 Jan 2024 15:01:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
 <CANn89i+GJOgcDWK=C0+vmomt2ShotrOKyLiXzFkfT1W8vpJv1Q@mail.gmail.com>
 <9419df03-a203-4b73-91a6-f008076c29b4@gmail.com>
 <CANn89iJdPRspWo2XzqdGdGe9_am7zNwbq9vm0AFLF-KRODzE7A@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iJdPRspWo2XzqdGdGe9_am7zNwbq9vm0AFLF-KRODzE7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:

> 
> 
> Hmm... I was looking at
> 
> skb_checksum_setup_ipv6() , it uses skb_maybe_pull_tail( ...
> sizeof(struct ipv6_opt_hdr))
> ipv6_skip_exthdr()  also uses sizeof(struct ipv6_opt_hdr)
> ip6_tnl_parse_tlv_enc_lim also uses the same.
> hbh_mt6(), ipv6header_mt6(),  .. same...
> ip6_find_1stfragopt(), get_ipv6_ext_hdrs(), tcf_csum_ipv6(),
> mip6_rthdr_offset() same
> 
> So it seems you found two helpers that went the other way.
> 
> If you think pulling 8 bytes first is a win, I would suggest a stand
> alone patch, adding the magic constant
> using it in all places, so that a casual reader can make sense of the
> magical 8 value.

I guess pulling 8 bytes first is not such a big advantage.
I will submit a v3 with sizeof(*opth) as you suggested.

