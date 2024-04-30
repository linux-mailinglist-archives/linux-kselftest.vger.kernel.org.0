Return-Path: <linux-kselftest+bounces-9135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39618B75D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95EE1F225B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9A17107D;
	Tue, 30 Apr 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdG6Whia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43899171062;
	Tue, 30 Apr 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480671; cv=none; b=JrkFjEpLRA5u/PsYCMCjSAigX/Qb4fqBmlhOfmVuQRtBhMgOvBUuzDKr42w4uouZOZ3GIM7mUnhpxJXOadMuR7dh5B1Y4jEneMSr6M0kGFQ1bN8ICW92VFlzvBseEYt4EhsYKNHde5h6XcglFNf611ktvL8UBM9MSV5iIDtw7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480671; c=relaxed/simple;
	bh=KmT8Ckyct/qkynI81wU2lhJ/4ljfYIDCJj1VpehlV/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNmviFV5kZUYlCOxTgqfcvj082wMkNQwmB5YzOdbeEDqLAMHvpGMNNtRs53JNDOzpfrb7LVzs3rSuJdISCfEQMAVmxwOSYY8OPyN2XkkSZx7yR8mhoL23BlEi2urgYdbf5cWJgAeDg8NXz7sZsjAHmZCEFsUKmbQsq5/Aj1DUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdG6Whia; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a58c89bda70so513215866b.3;
        Tue, 30 Apr 2024 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714480668; x=1715085468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0lacwrMCw3G9BvoUqJs9pKTPfNhYjsHB7mBDb6ejY0=;
        b=UdG6Whia8+jOfjUyhZDf4SL5VTwiJpuI7ulugqZAdM+VSt2+e4tUpd+SjXFvUoEByf
         3MqsiFMJVo/X5XeWH+EkFBz9ff9STFRVtdX4S0ETMhI6PUcvrFEMPv6P97FCD5+8Hc1K
         ZUMARnP3Xy88Ay0kE1hYXSS2ZxDNQ7X2mbmTNqXnjmGfD2psdVaoWr++XRKv93XoHznB
         Nj/JqcEmVvqFobeSnhWL31USLxUI6ufzHMHFw6QOGTpT4ENdxgVzmUch4iIFbNtKe9Ql
         v/jn86aeZmmlbk55D01VoT38XB8BUsqU0ljpVZZV4+V1/DncCYpeH1Jtm5s3YdR2KKOZ
         mHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480668; x=1715085468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0lacwrMCw3G9BvoUqJs9pKTPfNhYjsHB7mBDb6ejY0=;
        b=SRanym9+sEiWrzAJcJpvX3L4RI31vywQhN3IaZ4XU9PtncXAoavZo61xATDrnRa220
         8kMYrsqXb9FKQSBoqcPKcSkNg8V4+RrRUMeiv/Y7D/vDBWh55tTMmJyBhRkAEg/w6UxB
         FvPTx6fljjR/mnU1QlsGKdAzLhdEfU0+RI4HLGq/jdAFbT4WgNatxxApRF1Me4WdHYMq
         eBXed7i23ikvqu5XquK0LJUswJmpitgl7aHR88W+rfCKys6PqYwXfyarYnYAXguGf40s
         jBOeZ/xv8T+FLksfRnAfj+8V0ayqdka7Quuo4cTUlki4+/AaKslT1cjLRetDH5Clmqyu
         bJSA==
X-Forwarded-Encrypted: i=1; AJvYcCXdwKvdvTm1QkbUTyVMPJ4RBeI0B0lVIxmydM5F02usVSiQ0FfmezQYOKznNqG+1nCgz0P14DsipWJN++P1TgCdvC+pQIINnoMG5uWKn3VLxTIIMjfunoF6WgTqUk9NeqMxFyKPXh/AdWtKbR/ch8gookedWhwiXWkGv6nbaAJsVAJf
X-Gm-Message-State: AOJu0YwT08e7ePbbpWVuh1uPmc1iH+2rQAto3lnYAHxSkyCDxHkyOqRP
	jLxlQWCMTsvoYA0XPwTcLRbPhZitRIk8K89VwhOfn2Nfiu75CSsdh9yqR9sHY+9fGwSOhQVChSQ
	XtcR7e+dF5pn7papAXyLkyLD8H4o=
X-Google-Smtp-Source: AGHT+IHghp1JXIma5F1yg2WTsiV1Yx6+FHtBsWNRdGB6/rn8D8Y1Gjdz9wQ+4BFPnXfrmIlDY9Pt31GxHD967UeroTc=
X-Received: by 2002:a17:906:2c06:b0:a55:9195:362c with SMTP id
 e6-20020a1709062c0600b00a559195362cmr8698551ejh.49.1714480668203; Tue, 30 Apr
 2024 05:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org> <20240430-bpf-next-v3-1-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-1-27afe7f3b17c@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 14:37:11 +0200
Message-ID: <CAP01T773_6Qt43kxwbH0b7Q7XfcopzUQzWwjF13DGyYAvVo6pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: do not walk twice the map on free
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 12:43, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> If someone stores both a timer and a workqueue in a map, on free we
> would walk it twice.
> Add a check in array_map_free_timers_wq and free the timers
> and workqueues if they are present.
>
> Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> no changes in v3
>
> no changes in v2
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

