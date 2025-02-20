Return-Path: <linux-kselftest+bounces-27085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B48A3DFB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D218834C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB781FF7C3;
	Thu, 20 Feb 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUPXFUC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2F1DF75D
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067309; cv=none; b=YiwHwbUucbtw2RMFUb5nnr4V+ERGLkxmo0J4+SM5GakTJewB2TKsa5oix7HNss7z+CsJHjZUSAaw5ghK80a3DVCUlaS6PqTfy32r7hzqcVaRyznX2dbLuXEkFL5CqQWFq63DMJ1sl+KNtGhzmWefT7Qwmqx8nusOqclSbYku7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067309; c=relaxed/simple;
	bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3e0NnBVtgSxHE+mTbnzghRC3WiXs2+3u8aAVJc/Gk1gYdEwwaCXLM7iE1qF/Txs1H4QwW53WnoTwx3MO5SxoA/f0+TBINGez8dMmo3ETxOE5NK3L3skoDNmUlAxxD1H/XoJ4vx1BnXRXAfoBsWjZoGj2Neol3D0xziYRioJ2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUPXFUC4; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472098e6e75so302991cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740067306; x=1740672106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
        b=zUPXFUC4wHo2dQWfUG4faR+kkQyC3GeVt7A3j6rH89SFFUdGExH3uiIVcbym9vCFjm
         QAda6HEEg8lnoSEuWuzNbN85S6TgRe5SYIV+aiXvuTylqK+bDiVn/VqxaP/Wwu+Jb9YB
         UzvdXo2jn57Q9/8t0M7WZne7d+vz1Cp/Ha5tB3JxKz48jA5EKhGGF+04jjMw9EmfgW3Y
         GvS7r3xOkYXNsyE5csE1TVxhwxY9S++ICLlo4oGwm2E+7QApdBDofwr9V4E+yWIopkks
         GLz3p/Vq34igQGOHFnWENFwrq+XsrJTSGx2Ti6ncI1T7J5kOI9Y8cKcb2ysYlPA2o73R
         Fsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067306; x=1740672106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f30t0FycP7wwwGERE0OSDlKv139yOSwMDMH3gonzjQ=;
        b=kfxS2gSVg76xV6bFuh4Og80xDls/7KaiczbkQTS2U1xKijd7HS0AX3ATntBf3fPpXW
         r2bsUiXGQVIqP2dVawdCbrwQlD9T5Ap+G2V0UWBawxULncOjTuRgCCmjlsLILspN9uqa
         7bRNiLN45FcOGXaPjn7+VCyhyQC3kLHrBlVXyzaimYXL/0WD1VKzTLumplbtk+/hGIfT
         c0GyNbHyJO/MX9wWHwd/YL11MlHkBz1CZopz+8Nny1p8IW0hdIV+v1rUmHeYQLGGhyoA
         A6R6Sx2T+V1fwNO4LgQzhcrzueUcht3hktzD3w+PFM9FCTUBi5fwet6XLDHhvJtEuFPL
         QwQA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqFuLszDESPiMQ6nayGbCNSYAi8Kpo7L9KxnaQMLomi2uOCNMtP7lrWC/ngRzF26CvcgsPlJru5NEhtxrUF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EBQcAQO0ock9InW0KTqXYs9kbE+4c/hCEtaFmdo1vFyxmcH0
	lb52by1K87z4tFIoIIHEMHOGx5MJNxiDNPg6X+SjC4oqXSS4ov9NJH2/7dX+2TJGBwp26J/o8Sj
	wevTV8fPxRXyFlMJqqVa7un+w8RKJTf0lRzY/
X-Gm-Gg: ASbGnctHdOFqNg9+RcEUKZHYWQ6XQhbPSkuzWmouuNu6T9zr7mBoSPdu3gZ5K7NggSt
	+oNBu8MoJMUhbxzL4mff+gwV0wSjeSza1m3RTO8HU4yi36QQgilzD5XiJQArRXM/vnf8/7ZlEPp
	NQojgz8Yq0eIguOor5mFQj5nlF1/I=
X-Google-Smtp-Source: AGHT+IHooJi+toMZzU34UpvZpQN12onTQrE7RJ6EGpciFt65M9cIektFHfEiQcxn19hTRXYVvPqlYBs3LU7ABqSCJiY=
X-Received: by 2002:ac8:7f0e:0:b0:471:9480:a14b with SMTP id
 d75a77b69052e-47215bec013mr4381041cf.12.1740067306032; Thu, 20 Feb 2025
 08:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-6-9bbf57d64463@google.com> <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
 <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
In-Reply-To: <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 17:01:34 +0100
X-Gm-Features: AWEUYZn5jQYXZnAzrw-ROi-YfDD7dcdvcVZBy_GodR3_QHZfRC5arYIJp-Gr774
Message-ID: <CA+i-1C2_Ooi59HEmVma-=XF99eqHa-uZwd7DL21VtAvPg3S1EA@mail.gmail.com>
Subject: Re: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:55, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Thu, 20 Feb 2025 at 16:48, Dev Jain <dev.jain@arm.com> wrote:
> >
> >
> >
> > On 20/02/25 8:33 pm, Brendan Jackman wrote:
> > > This calculation divides a fixed parameter by an environment-dependent
> > > parameter i.e. the number of CPUs.
> > >
> > > The simple way to avoid machine-specific failures here is to just put a
> > > cap on the max value of the latter.
> >
> > I haven't read the test, but if nr_cpus is being computed, then this
> > value must be important to the test somehow? Would it potentially be
> > wrong to let the test run for nr_cpus != actual number of cpus?
>
> Based on my _extremely hasty_ reading, the variable is misnamed and
> it's actually a thread count not a CPU count. I can double check
> that's the case and rename it.

Oh yeah actually, it's only misnamed because I made it misnamed. So
this patch needs to rename it for sure, thanks for pointing it out.

(But yeah I upgraded my extremely hasty reading to an only hasty
reading and I still don't think this test cares about the actual CPU
topology).

