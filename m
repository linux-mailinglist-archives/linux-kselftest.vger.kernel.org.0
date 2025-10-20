Return-Path: <linux-kselftest+bounces-43564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB547BF26C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C99818A5DB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E6287507;
	Mon, 20 Oct 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjfM3gm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51EB288C34
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977703; cv=none; b=avtfgkb6oaGTbLyVE9ogfYCdDyoT4S5RFzRA+naE3wysb5o3YGkdImIghJzWWHTI/5G8ZxuChh9PRSOaXli0WqEa76PAjTBMZg3XX2XRDvnSgUmmjUaKVdlaIkZ2gb9vft7HDVbsJyYnJnhISi00Km64XN6z6LJqHxFj4iA4IVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977703; c=relaxed/simple;
	bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNyyF2LnLKiA98HKEq0GdfQa+4t3O5Z4WWHNxQpUC9j9n7VJYe5EMxf98NG4CgbTgOC3NKVp/VgPBZUvQDZYrbtJtoSbg32s8sMHST/3mMLxyMgOcfmRyRsXk8+Wls9uCatkIzv7VbSSWorl954G03UOuqpfWDPm0AXlQunTAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjfM3gm2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711f156326so32821015e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977696; x=1761582496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
        b=RjfM3gm28U5ghZSqu2mnef+2Jt4MrrtHHtl1+Suw86NPNckFD1eHRdxFiZ4yJRaqgM
         IK/81AFPbKx6RKPlfugMIH004AL2JvFPO5h8MW1XOgvOiyvDXN0/fYvZMCi9u7qMvgn9
         hOkNQ61hk1RmT4IJ7LarCDYFBf0M20yMcaiBB8/EqF02ToE6y41pwTgeFXCydMB/y5XX
         jUegSRqohqZry9qvTTpw/DRIL7s0qVEacP9y7hS0LVPXWASp8oM9ftKBSLSE0Ynxn2wb
         oiz4pig+tZ+IeTJxxTWclBIR/ojL70CyI8nx3ibmD7uirBpW2stXejV6cKGplM0mDtwt
         bGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977696; x=1761582496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
        b=JyChICOQpxpPFSdspt7WFANw/ZGv4luXMMTAlm9vMsy552fesYNZp2wX0q5O+oT7vD
         Y5Zhq9i4bezcueALdR0ahwvbnTevtQTiajxiy+CqeGjWl/2KfpclC82FPKoeLHLaWPnj
         ySvgOYQbrlt3S19S/LZ742I/5nuoe7vUvzsbck7uhZ6S7d9YhT8suaSoUn5Lc4PiPKBY
         hWuraUw1eOyVYdGP1nvAxWfFmNUrOne5lf6Ws/YfQAs/ydkfn6/S06IQ73OuGBU6TTQy
         YY8D/pMWDInjCrzz8M0SF8sCmWYUOqmQl5jzfqT8jYT9eYNG5DUOl/mYyh7UFxsKbVw8
         aLRA==
X-Forwarded-Encrypted: i=1; AJvYcCXASIC5LxjZlMlzhnlFE6zNmJcW6DmIiPgx4Y6xba82kauqyCkcc1l3pViqKXkkN+I9wBPuJqew0mRLhL+8T6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxQz0bC+FOrJoua52vLygv71rgBiq+eIWCENnxcOneGec0VPD
	VzFYgV37tFHzzsIwvHANwJgmcj4aTTdjhKDtZrZc6Bc3Gya1LdbhCfus0ld3ikiw6KfUm+PzF7R
	j+UUvzstNuaAlB/WTYp/q6KM1zsU3Xcs=
X-Gm-Gg: ASbGncsh1f7RI3cBzX5z8LiWxy5Xi7i/0S35uA9PMEg1MG2qNAk44RqXKb4cu1U8VS/
	lyk6PiSCdZ+u/7bLhjPOSnpypfbkbyto6gl1IdZUYVr40y+fI3IBTVPF8uvqKNiao2XEdotsbex
	sLd3vKX7QURwlmQW0Q7V2GIfM9QX1oX9EwOCG1T8rYJyGZ0lA0Kb+mK+AA0S7n5GrnsnsWJKofX
	LstT/YiQGyVoFl4d9TlPnUlFlr0Cyr/Fm6qJsCXMYOen60JpjPNy8v0rst/gDX7wyIDUiqPIamK
X-Google-Smtp-Source: AGHT+IGgsb23uLOYmPtswWrzHBvsGatayTaNyrZEWVwipxccOWsj2/tNIa+9q5qhrVZNBeJYMzzwLQsvnR4FFMLm6S8=
X-Received: by 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47117907234mr107718165e9.19.1760977696264; Mon, 20 Oct 2025
 09:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
 <20251020085918.1604034-1-higuoxing@gmail.com>
In-Reply-To: <20251020085918.1604034-1-higuoxing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Oct 2025 09:28:03 -0700
X-Gm-Features: AS18NWAYQpOtsQ2xgj0ICvDQj1f9fYVEjTCZgyvRi5tfiwjitQ9rlcRw3bERhgg
Message-ID: <CAADnVQLDQpNEa0bT6nyX3UfGTE94YxrM4gPD+PirmqHwXRB15Q@mail.gmail.com>
Subject: Re: strace log before the fix, with fsync fix and with fclose fix.
To: Xing Guo <higuoxing@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:59=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Test with fsync:

I doubt people will be reading this giant log.
Please bisect it instead.
Since it's not reproducible when /tmp is backed by tmpfs
it's probably some change in vfs or in the file system that
your laptop is using for /tmp.
It changes a user visible behavior of the file system and
needs to be investigated, since it may affect more code than
just this selftest.

