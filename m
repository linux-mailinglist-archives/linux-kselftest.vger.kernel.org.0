Return-Path: <linux-kselftest+bounces-27078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2A3A3DE32
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F953BD5A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242AE1FCFF9;
	Thu, 20 Feb 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWFTYJUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348A1FCFDA
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064654; cv=none; b=Wde4dMwdr36NKzno5JUgkXlWHDrQe7q/wVzxhcPUu5uSM1NJLlmJ6PH87taf0vM2fJ6pop9NAIj1e2JHIGDps0WMXs3Cx9xm5FkM+8uk4oiXOtbTRm199e/DJTUJ8x2WiTVHxPB2t28Q0o7OPmhSQA9k23Zq9cwoPrABEmOqnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064654; c=relaxed/simple;
	bh=hjbVevJDsAnw9R1jKzAcMVdMe+e0Cb/Fj4Olj9+4LeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQoYhJRe7xFhAeS1YaRk+SSvA5wlxQVo3M1d0zIbeu/+oQcyz0har/SQFHQ82L5f/ZfY8G/7Axj/9f5+dt4t54oijtcKuxiXLnRgCjKLUY6KrLw5dQal5VEf+VvLHLoc3dqQfmU+LX2WCUdTkBXHJqGgczadRzkD1qalDPDR+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWFTYJUD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-472098e6e75so286441cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740064651; x=1740669451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfqLAf2Bt1MZOxsTzROGpX4mEJpPOhYETeaZVqIiLtY=;
        b=UWFTYJUD7pS3GoygUk9JfskGqEhvOeau99u+wB6fxkIyLvLz7Ht5/VbFnPYHYPeQ+e
         dugAJzBy5hRVyXjm3yztp/bOiwOUitjvSgnjSNWa50amsQSt83thDkabxv7h5bgpNlG0
         dWIkBCpi+rgqdYLifERzQ5ZaFdIBhceNNYuyfm9AUPeOLzxi40QfmiKkgpTl7V5R5+mn
         6yBVAHAL8cg3junqRA8dVe1EKIlfhnOfPMEHWLU5os/W+6clQEh7D/gPTd+3ajWpopgw
         9A2CnVpJ566AhDMI3hor1u+7eG5+bfV9odbUkqDbNGHcsqKzWz2GB6I4EkE878iV5Psu
         FA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064651; x=1740669451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfqLAf2Bt1MZOxsTzROGpX4mEJpPOhYETeaZVqIiLtY=;
        b=XPV4F045u1DAlZr4s9LywhVVci0ztDwlpkBBJ10pCdkYb7GpKOOeipMbGw8sn7pr6F
         HjM/aqQI9J5bAWs86FlQema8lpFWTfVutOEY/ikstoVe+E6zMqaspAaGIU578yuqMY4f
         1DDTm0MakfHxy4qXmzzsvBcCn/YIU0JhlaPGjSKJDYRAcqPYcg51zOU/7846rI4XR4S2
         Ixbv+EuOA4E1yd67MLvKC8AU+v70Uu1wchN7kq2mylscSLQcgXjQPD/cD7tTTnV3b7c3
         Fznl3I9yO6zkhzzc0RJ7eln4rP+R1cQUGgdgijcHfNfzl3mznZQShFaimAmRi8CZamI1
         2Qxw==
X-Forwarded-Encrypted: i=1; AJvYcCW9nWPluJf0efpRUC8KOA+NmVJ76gYk0V9g5LWfpxOEjip1XHTUTUN4n6mpq74p9qklyFxAsh2UKGXzpvc9TgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWe6fjELgskwLwmd4oiJnwhN3kzV4eX+YPUpTA2YNRX49heEI
	o0HIBqpyQaV3gvELA5jSErmczHY3t9FzB8/JBrm8fUoM//CLkCTodiY+TaZb7G0Fb1hH8t7I0su
	eaA3wEvduDAfAUmEqw5lvRwXNI3RZjdq3Rw2S
X-Gm-Gg: ASbGncvw0HF+yUure8058PyJFLDaedfsM1lGdjYbxjklftRfbxZxkZBZh46U/UJbYaX
	YoRqgZ698Cpp8vExc6TWjjuZ8d5fRBZ4veBN1Uc03HKJPDnvNNLzRxizpTPxc8/Gt/aoWbZ9SL1
	15GWlHp8I8HmlLTMwbUOcbY8XLBMc=
X-Google-Smtp-Source: AGHT+IGhyGVmDHiveCYislzBLpxmEyFf8bbj2ICmMKfXu+YhRG0z57YQ28qadOmItdhl4ZLbIN/D33o1DiOb1WYbGYM=
X-Received: by 2002:a05:622a:1a88:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-4721708fbf4mr3622511cf.1.1740064651173; Thu, 20 Feb 2025
 07:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com> <20250220-mm-selftests-v1-5-9bbf57d64463@google.com>
In-Reply-To: <20250220-mm-selftests-v1-5-9bbf57d64463@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 16:17:19 +0100
X-Gm-Features: AWEUYZkyoMHZt5wOSmW4C7MoQ1154jjgu5NFAI7r6rF-taWxuY5uZ_vFpxeDUv8
Message-ID: <CA+i-1C3K=Fm=OfNy_5a40HYDwp_FBy4BBV9+4L0gF3S1grE5sw@mail.gmail.com>
Subject: Re: [PATCH 5/6] selftests/mm: Print some details when uffd-stress
 gets bad params
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:03, Brendan Jackman <jackmanb@google.com> wrote:
>         nr_pages_per_cpu = bytes / page_size / nr_cpus;
>         if (!nr_pages_per_cpu) {
> -               _err("invalid MiB");
> +               _err("invalid MiB %lu (%lu / %lu / %lu)",
> +                       nr_pages_per_cpu, bytes, page_size, nr_cpus);

Oh this is actually wrong - the number it's printing isn't MiB.

Assuming there's a v2 I'll fix that up. Otherwise honestly this patch
could just be dropped, it's not important.

