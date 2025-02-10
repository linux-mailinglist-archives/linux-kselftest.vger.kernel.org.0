Return-Path: <linux-kselftest+bounces-26184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A18A2F1B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C86A3A35D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1C24BD12;
	Mon, 10 Feb 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htvRimFu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229524BD03
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201185; cv=none; b=CGrJ9ZRleg6JvlS5IktgPu406eYe7FGB33eCoobADDmYW+GSBcjCjvnUcEjJnXaAhBb/4u+FeXpsKuZgcOTQptHacsKvbMjI/W2IswK2wO5AnG5chz6ASwq0BZvrvv3Bc2/5VYIvNK89uZLHTiGaSkS2ZYn67N5eSqQq96hR8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201185; c=relaxed/simple;
	bh=cqCf4NDqz6PP8XjbskK0JUt0MZIFFfNj+ukOYMRG8+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPK6Y+3V+OPomoGczqqBq5dDP4KKwDlPrIiwQDZxo9K0NUzVMjNwaEyHpBG0bwS4cdb8c9T5WhM/huhKs+CY22Up6lr821Qsyoek6K8FEOzJX9/iXV+yLFSbI2xh3Ks8LL8JWL+HhtCVFdo1ts2uL3GhC96fQRLYopY2soJ9anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htvRimFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739201182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DyU0PD8obl5r6J7r3/RI/9K2JsBJV1aeauj24rGL0J4=;
	b=htvRimFu3Uvnp+H1kSHAof8GBIEHsienONFMGoTErNKdTlQtJ7OpPJcAapV+QjTXmY/Qvq
	xhZzEu0qb/eQerd1SuOJ9Vb2fv4qHnEaz+AFz5DRXHD7uOFINO/TSrKGR2eMwM6MvK2skq
	lneDmrjZsKKkp/OgzCWwaZig00tI1eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-2L10QBDYOdq0bUJLfu1LSQ-1; Mon, 10 Feb 2025 10:26:19 -0500
X-MC-Unique: 2L10QBDYOdq0bUJLfu1LSQ-1
X-Mimecast-MFC-AGG-ID: 2L10QBDYOdq0bUJLfu1LSQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43626224274so26815205e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739201179; x=1739805979;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyU0PD8obl5r6J7r3/RI/9K2JsBJV1aeauj24rGL0J4=;
        b=edwh9etChMoWBrZkyL2bGOMqXWx/2myuw8nL+trqFf2BFPgwrbLwIfh/SKY8tfqkKj
         ElJslrcaTLNQgK+ps3G0amQCPjEWN5GfcauGqTAun1/yRw9u9X0WYDcwLcPidqCVM1RF
         2yLpKJRmlHFlz5CnxDB7sw3y17hI7gpu7KwjTZbdsKNbhasB+b80U497gUh9YsTQya+U
         gyPnQoEgjbR507dosg5GF+6iLvLGh4///2rc2TEMEpOeQMgkJHKBnaqi3tq2k7RISjAO
         hcndqWxgfrikniu0nFKX9ig5IWLG3GJhkT+H0iNGYW2Fc+wH87lZAa58uWn2gWtCvt7r
         83Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUlDTWlrH5ht7z0zMhASzyA3MJgOTvt9y7ZNr2KuRe+yETYpt3A6V1uNcmmWYogI2BQdQ6tP1b75Ip6fSq77Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTqQY8O54oHwQ00X6RV7YzjLYEYuB6ZF0FcWOpEiz0JZMSROD
	CdkeuVtm+ema8AbFU5camLC/qKjV2pt74yywraEcg2WbfcMCBkB9yFdmvo1GlfrCEPlizN1qxL+
	U1TiN5tD234YbfdGspNbGEtNuxqRq7ZkvfVEV7/wBTW/qCc8sP6PHVgs0qGyu/oEzKA==
X-Gm-Gg: ASbGnctSUFdhVWLUJ3v1bfhdPysa+DKKO5t0TRncZjTH22Hoi3Tlmvlafu35NbYrRK4
	qG/Y33YW1PtPfz6FSyDkx4jCDvTAaVqIscb3FS3XowFEUbQlEPx/tVoTUlfwm3ArhX8nekiZfKl
	+vtvXs1VfpN9y8joqjDznPvMit1GHv/CaWxpDlRdmaLUxIlqx99q9F9N+ZUpjcsP2K1rOGy2UEj
	VYD//ej4wjhAi6hVTiQnyJLObpKEeuVjSyWg+VmkDWQy/PHHkNHQWEy5Pb89ZAVrBPpjy6XTJ3t
	OTdPxgrPBRqzAAVHuSiHLLAdcxIqBMw=
X-Received: by 2002:a05:600c:4e93:b0:439:4036:e925 with SMTP id 5b1f17b1804b1-4394036eb16mr63685425e9.11.1739201178643;
        Mon, 10 Feb 2025 07:26:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENw/oXxAGB+H0r+IgDEAwCWcxHZDYtwcMjowLVmO3YEF3rnAieF6nRyMgKVMNUn35trPu9UQ==
X-Received: by 2002:a05:600c:4e93:b0:439:4036:e925 with SMTP id 5b1f17b1804b1-4394036eb16mr63685105e9.11.1739201178195;
        Mon, 10 Feb 2025 07:26:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfd8448sm150058285e9.38.2025.02.10.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:26:17 -0800 (PST)
Message-ID: <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar
	 <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 10 Feb 2025 16:25:59 +0100
In-Reply-To: <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
References: <20250210075703.79125-1-gmonaco@redhat.com>
	 <20250210075703.79125-4-gmonaco@redhat.com>
	 <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Mon, 2025-02-10 at 15:53 +0100, Mathieu Desnoyers wrote:
> On 2025-02-10 08:57, Gabriele Monaco wrote:
> > A task in the kernel (task_mm_cid_work) runs somewhat periodically
> > to
> > compact the mm_cid for each process. Add a test to validate that it
> > runs
> > correctly and timely.
> >=20
> > The test spawns 1 thread pinned to each CPU, then each thread,
> > including
> > the main one, runs in short bursts for some time. During this
> > period, the
> > mm_cids should be spanning all numbers between 0 and nproc.
> >=20
> > At the end of this phase, a thread with high enough mm_cid (>=3D
> > nproc/2)
> > is selected to be the new leader, all other threads terminate.
> >=20
> > After some time, the only running thread should see 0 as mm_cid, if
> > that
> > doesn't happen, the compaction mechanism didn't work and the test
> > fails.
> >=20
> > The test never fails if only 1 core is available, in which case, we
> > cannot test anything as the only available mm_cid is 0.
> >=20
> > To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20
> tiny nit below:
>=20
> > +		usleep(RUNNER_PERIOD);
> > +	curr_mm_cid =3D rseq_current_mm_cid();
> > +	/*
> > +	 * We select one thread with high enough mm_cid to be the
> > new leader
>=20
> Missing punctuation here (...new leader.=C2=A0 All other...)

I guess I'm allergic to those ;) Thanks for finding it!
I wonder if checkpatch should be able to catch this kind of problem,
but that's for another day.

Do I need to send a v6 for this or just reply here with the fixed
patch?

Thanks,
Gabriele


