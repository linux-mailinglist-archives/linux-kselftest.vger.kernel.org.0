Return-Path: <linux-kselftest+bounces-13256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA89928E64
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21B71C22C21
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44C144D25;
	Fri,  5 Jul 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1Vo/81m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28B143C6A;
	Fri,  5 Jul 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213097; cv=none; b=dkq0Cjyoqwn+9fEioNK1qZ7mPNBplVGjcilxZz+t8n5WX/t0cA5rrQhmfZLgrmEpnHpLNIvc44NiyFCslSXorrAtQHouyc9hi3/ayI6lsNCO6NrYas4ZzmNWbpppDalpNLJhQC519R52YRJRpSAkDnWUJZxrPD0nZuHLYNsbszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213097; c=relaxed/simple;
	bh=oNImnp1rD635YLZFlLT6bKdncx0muCBxFA6JOCvAK1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8Jcv7A4GrkFgWcYjecGTCn4nQfMjGeUVs9Agp5DJCmfc3aalnieKZlAtYbDt/CCuSYT390jaAYnMI9PaMH1+ES+0ellloZAn/t0nQ3we5TIHnzA/Mg5C6cG740ekz5kA7BfXfz/iGuGySs1Al+gNToGQYBdw5D3KoOa49GOdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1Vo/81m; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75cda3719efso1186549a12.3;
        Fri, 05 Jul 2024 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213096; x=1720817896; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNImnp1rD635YLZFlLT6bKdncx0muCBxFA6JOCvAK1s=;
        b=X1Vo/81mK1ZkFbnVzyQITjV5sXYrMUJXGaVmU0FfBQAKzQvRJR0OA7BleWrG4UaEVi
         XFQMSFLBgczPSKBLmObgh2j/g8n/cAtBQ033Pz1STV61QX1lcMxsf3vMDLKk1w7KhrJ2
         Vs1EZ85zuf0QPuQkhb59HclsS9whxazPsEFLLlWlxiOBZuFzFZQ3iKSnCNhNGykN2D3n
         BdLK558uUI8SqqS0jQL3ow6TvofDt1RCSPikxs3PYhEGG1CcRE1T7dGuRziD1Y89VOJ2
         dK3Y0tpoWhwFVZkHLWqXoKoic24mlwGorrzyuhb/POYJQIrRusQk/V44VLjt9Urwl8eA
         T5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213096; x=1720817896;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNImnp1rD635YLZFlLT6bKdncx0muCBxFA6JOCvAK1s=;
        b=nZwYQNIf+GDkqdVeiEtG0GP46na3XpH+2W6nyz3jh+Y2qNOMDOJSTQRDeCxtH+DV+l
         a41wxITEwY4KU+/2PMWHS+5Cr3HZ5aA4P2fuqtYBYyPoeFl1XKSaHeNaMO9thBPaT9wE
         DeiOqAmI0/zHZmLbkoq1yu2F3RadHEZ9LH8wTOyCiPq3wmGjSC83e2Zw2nR/sST2VdLU
         Mz0e/4tjOYCy8fELqxJoKyTBu+pFYvvMffXc+CDwtPWNJ7D0wNRC2wm5mpxlw/zlhkbC
         MpuQhbs5f0U4QB+naBYpFOZWs3qOUnR3v9U2/U2blq9RgZrLgNNamlv0+KGTRDInefN7
         GkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeMDeTf/9z97zzaM1XLKjeYTjetTIuUAqydORvUzRAc5yJZK1DCZveRKhtmsDHj7L1jEzn8mn9HZZBp6rCXkNx/NZyvErvHHzZuMPYHfPmYsEJ6leMloonZfIBe3jqtS+6hKOEPES7YKgCkn24
X-Gm-Message-State: AOJu0Yzep1G1A+jLs9sF61RtQSyepnthHwEruL0fAMAft87BeKeqSxvO
	jzhUR+grmYSkQKeM6w1SJV9M1xbGaJM1IqaIJvfV1syOfB/wJNT+
X-Google-Smtp-Source: AGHT+IGOiGp4poAr4RiUJZfT+xIteErM7zNhsVYCFAcGZxncPPbWDlXQdtEf7PHabf/S88V29W7xQA==
X-Received: by 2002:a05:6a21:3299:b0:1bd:1aca:2b38 with SMTP id adf61e73a8af0-1c0cc8de327mr5681370637.51.1720213095851;
        Fri, 05 Jul 2024 13:58:15 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15b890asm144740855ad.301.2024.07.05.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:58:15 -0700 (PDT)
Message-ID: <23da6ae19d3cc17b445b77e18e2ac98c490f9b7b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: helpers: fix bpf_wq_set_callback_impl
 signature
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 05 Jul 2024 13:58:05 -0700
In-Reply-To: <20240705-fix-wq-v1-1-91b4d82cd825@kernel.org>
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
	 <20240705-fix-wq-v1-1-91b4d82cd825@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 15:44 +0200, Benjamin Tissoires wrote:
> I realized this while having a map containing both a struct bpf_timer and
> a struct bpf_wq: the third argument provided to the bpf_wq callback is
> not the struct bpf_wq pointer itself, but the pointer to the value in
> the map.
>=20
> Which means that the users need to double cast the provided "value" as
> this is not a struct bpf_wq *.
>=20
> This is a change of API, but there doesn't seem to be much users of bpf_w=
q
> right now, so we should be able to go with this right now.
>=20
> Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

