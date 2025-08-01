Return-Path: <linux-kselftest+bounces-38188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E7B187C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 21:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A372D7ABFFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274B205AA1;
	Fri,  1 Aug 2025 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHK+K7Cu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18893C2C9
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076660; cv=none; b=azNpdCfV8I1quJTuwHeEuyf3LLIVS4wOpRcYuk3zMtAc3VIKc3fGxxkMcnlI/GHb6U02qpIbn+hRCZYEl5vDmLNeCe6yZ0ii8l11RJ91eMXbffcQwMwr1FubNMalivGYQVwAkQdDsV+4k0PQGmVmulXTt+0T7AiYyulk9tOIL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076660; c=relaxed/simple;
	bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8WBlY98jeH2aABdHwpVuMcvkAm01oxJg1BmxDGELvaMAHo3D543mls10KQ3n/XI0VO0aix5pAagwyYq6hJBeuMP7OqMZtrlG93jvAzghWH4cq3Y+Prb7QrNMl2gck8NF6Md+hBxpwSl28LdqQZYVa6WaftjCtXpIIPT0NbiL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHK+K7Cu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso451cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076658; x=1754681458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=HHK+K7Cuj+m86DT7fUiStpyZ5py/pKWNDGFBifxgli2bNVoJWs1jedmfpSPP6MweDs
         HrCWqp1qkNrSd0KFHsGjvZF7fBmHRqRpYB9qW1a2MIfk/UD9OMHEmNAot7lTteF2D4Z0
         LlEqa1PrSneOGuWDrMxVAi3bLwPxyLyrbkYnWfwWqoeQpTEQjb/HsnwBfzdK1ixotYRq
         jBfmFcWCdSjCpAgdXK6jtOWDDV8my+k3LyupzBXF33zpIHvasID6uGGFqeZFLDBOnl1k
         6x1xt7RDB79GNnjDJPQ4cSYXGKWImXJXWouM9SQ2aAkMu/vOu749Q10gg5Foi6aMk4ur
         9Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076658; x=1754681458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=g8Q6RuY3FlegE6qtdD/sLK2K0FzmTAEHGosT6XBqZ9f2aYqiJcGSOcva/QLbikC8fB
         UlvUj5KPiunLas8u+7QmoJdJ1sl3fcyR1Z7wQh2jR2z4gkkB1GQ1nBsL2Ml0PCOAIvMc
         53p+vs+0s17kRx+cqaZZ1KWQRBDkQdmq0fF2TDOD+zX85yYT+Opzpw0Nffmh74QlWZCu
         nHcw6cUo9vvQZmrsj1w1hNLm/ar36WHo1TYv0P1nq9W3GwgXjIpVn+Ac7gttGT2GNXED
         gABAGTpYMlMzVYIz68vBtijhKXSr/v6UrJUF+mtHkT1uLq+cOe4hmtAJi5giDzRN71H6
         PLgw==
X-Forwarded-Encrypted: i=1; AJvYcCUvkYNDTOwnZJSD5+iDa7+/f53Zxg3mSF6EaspUL5dx0d66tD30Sc1NM4CkB/ZAeOzZose+NYl9sbp6YT9BJ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvz5KBu4CKXMomSFcJBp+PSM8w+wlU1C55ltl0RhipWgxYYO0/
	MZDJuYamvN9rNbJUPqu7hCViF9OwaLTWKUU2GGvv2JQ9wrHHPuNxzYDqE9PVxrrXrBfCMdkYPTl
	VjZM5OrJVsodcBe+R4j9TYufyazlOgFDl0RcyhnJE
X-Gm-Gg: ASbGncswvhK6ZIn6RunhkHleZb9QiszF8OfGuyrPOGI0xQ+gPKrDAlqvjGOvoZKNPwA
	l7nEk011dbXtJ2IJF5beO8hnvwijg1YrN+oq11oWOWglEfixYnWgK/SaZcK9UgTL9JhjogACWSo
	ZCAs4AUHS+cQoQVtVuD117P1pS5W9Nznupzcz5mRX+1damScQkfV6NSPapmMUHzIYLgbn/5Z5A9
	FBNz2GvrLVomJ/rUfLe3B9lt3z7xaP31ko=
X-Google-Smtp-Source: AGHT+IH0mW5f/qmqu9jwFpseJ5sBEGT+3smSxDV4uopSaI0KwsbmE/+dq3CsqpUFK06gNcNwwYnxKt51RS3MEF3u6D0=
X-Received: by 2002:a05:622a:1984:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4af12de2691mr759991cf.6.1754076657499; Fri, 01 Aug 2025
 12:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731220024.702621-2-surenb@google.com> <20250801183833.30370-1-sj@kernel.org>
In-Reply-To: <20250801183833.30370-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 19:30:45 +0000
X-Gm-Features: Ac12FXxvF4QVnElqOuim-YcXYx27wMsfO8zYCFlPV8Iub6EM4IPZ7MZ5jF-KLug
Message-ID: <CAJuCfpH+bXgm0RK=CRxD_evnwkdeqg=-hrf5dtejCMXhxg5cpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 31 Jul 2025 15:00:22 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl opera=
tion
> > correctness while the vma is being concurrently modified.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Tested-by: SeongJae Park <sj@kernel.org>

Thanks SJ! I'll include this in my next respin.

>
>
> Thanks,
> SJ
>
> [...]

