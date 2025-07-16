Return-Path: <linux-kselftest+bounces-37431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CDB07801
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2500F503320
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81141243969;
	Wed, 16 Jul 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cbcc5COI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F305236435
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676072; cv=none; b=rZivNf8cvNcRjKWpx2Th/WYqXh1Bk6OcTtHEyv52QgTdpizZEloeEupoadcuxN1bn5AQNHH4N8HNBgmclkE8kFUrfSaGOxj/9Q1IKtvgMcBBUrFo5FkCLkl8JK0ZG3fen94cK0PQw8jAMQPddfac9DLRizfYW1txRs5tSmX9qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676072; c=relaxed/simple;
	bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkxL1MvvVZ6r2NcexK3I2q6Tln+iqI7TQbyv2bIDEJOoTUCAsbxkmXok5XoWOVwbRqPR4hRXWfQ2RW//aae5OV9bcP4dFQ0bRBdXKjrTpd75utFaCz8nbPPlhBcV3DhsWTzcP/rBQD1qgKLGRSjPY75idzBuSAiXRUp/TRgzsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cbcc5COI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso12672a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752676069; x=1753280869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
        b=Cbcc5COISwvDVxOLl2AuIR9A6AyZG2Z4LZn1srBY4TVHfbnWZWo9reKS78+V9jnTfJ
         sbKtqU+btoKu7OLT31JTSgVh5pl5uUIklF0Q+d9aRDTf25UtcjcrWG//qXKmUyQmsVAD
         EuyPdZY2Pv4p1lSNH/1X3A0Q2tXrZkSgUg9dsc3vUtqPf/erHqTSpuJe7UjS662T4L8n
         6WEED7J38WkkBDmBCAYpMLICuV8BLjV+GeuWMfPX+Lc1yxbs9Xnp0TU+EJ4CdD/BL1CJ
         wiRpCd02sLyRFj9C8RTvxNap6S8qL9OJb3cgxj651P7ZHQPU2WUP5shHEOkBbxnU28zG
         gZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676069; x=1753280869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
        b=Z20m2O7sbti4fihw7++6U1euGC1hLJQ6Ir6QgbB32VJ2IOUbWJg+20rcQJW5oC8RCM
         91r6++WqF4CxxodJnwRN9dLSnTRn4hV/OyQPl8M8aFKjrFlvP+j24a/DJ++bppgbDthu
         wvy4W7DZqP5+X0CSCgg4acdzEIEZqpNcV7KfN1QcEly4dWhLlXzwHBBzJUgYMR6dyP5w
         u4hfTilw9pS6pjcsMqVg41CKIM6WJi2bxlAq8q5w9/YhPULcUqhh3mPHf9JyojuZHNwG
         W2+zFlAGeNHDNxdTP0/Acl3d7NUWdvosuyfceeMPLm5aM21+1u8WdX0Z3833I8BDbety
         00jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC6Vg+4suANcW3OxYpTjKJZtRLNjO89K1rWt4u03oOlkvF7LW7q6uxMpQh5dpLR/V5sEqvmH1Dc3K3P+S8Q4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVVbCQUfB62QQCgHemHuYoGQGIsY6BMrT21QP9jzspIapendP
	KRRsWHoZRbRVRlqRnodxYmm1F2fSaWiEEkiTZrpuU/5bBRat/Eq5Whi9nOTrjwgHpKSvG6G6lkN
	Bai+hDBLNZmopjRBM648Qzs+DkUyLju7IVsi+QOes
X-Gm-Gg: ASbGnctY5lks/duhpMmYMM/B9KLQl38XSur3Euvdh6LIZZoKGmKRznBIWBYNOYI45WN
	4VAH84sMxdr3Kvkim1REpH0keLqB5MLxCi+Eoz+PLyh/4eNMaOPHJEuMJg5db2Hi6NdcCUTi7kc
	xIK+nnqNm4Nlcw1B5Ss/1QMjcm2orjrsLayRpJEzS6gKJKUDdGivxMlmfVauv7Y5oqJ9VvANiFW
	swq2JSkXBnfbYka0ZSryYDdtVP7K0BTK7Na
X-Google-Smtp-Source: AGHT+IFtn2Jt43sGdMrRnFbMM4zR7ZvvUOW5aRjpbxzkLX62FzMlCaPlKzcAzbgKN34QMkxqDCHX/orQFd9yCAvuWCQ=
X-Received: by 2002:aa7:c14c:0:b0:611:e30b:5707 with SMTP id
 4fb4d7f45d1cf-6128dc01d52mr57489a12.7.1752676068588; Wed, 16 Jul 2025
 07:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz> <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <CAJuCfpH8zsboafV1UWufYhbVXN-yKgMOKm=vr2vBYAPNmPtrvw@mail.gmail.com>
 <07de1e8c-9319-49b8-8e86-97ea0d18142b@lucifer.local> <eb432785-e916-4714-a1e3-4ea5218cfa76@suse.cz>
In-Reply-To: <eb432785-e916-4714-a1e3-4ea5218cfa76@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:27:35 -0700
X-Gm-Features: Ac12FXzkQUKbjHWly2XAM-75FxXxF7P_PGAXAyUAeeE-cM1Ys06wCiWNzG6_w_w
Message-ID: <CAJuCfpFohprJEshKXX9awPdwJhRNU1995suvwegXHpiYWO-ONA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 16:00, Lorenzo Stoakes wrote:
> > On Tue, Jul 15, 2025 at 01:13:36PM -0700, Suren Baghdasaryan wrote:
> >> Huh, I completely failed to consider this. In hindsight it is quite
> >> obvious... Thanks Vlastimil, I owe you a beer or two.
> >
> > FYI - Vlasta prefers the 'starobrno' brand of beer, he says he can't ge=
t
> > enough :)
>
> FYI - Lorenzo is a notorious liar :)

A search for starobrno in Tokyo provides a couple of suggestions:
- Pilsen Alley in Ginza focuses on Czech Pilsner beer, and while they
feature Pilsner Urquell, they might also carry other Czech brands.
- Cerveza Japan ShibuyaAXSH, a casual restaurant specializing in
Spanish paella, also offers an extensive selection of imported craft
beers from various countries, including the Czech Republic.

