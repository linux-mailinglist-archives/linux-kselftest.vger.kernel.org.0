Return-Path: <linux-kselftest+bounces-41904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E44B878BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 02:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AC11C25C13
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16662242D89;
	Fri, 19 Sep 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YydwEGiU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053C1DE4C4
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243528; cv=none; b=Bf9RSc7YUxyMw1l8tAprGSA4sPu4DRchQHtZEY5bbbMhDMNYcbkfCQGCAtDDVrbq8CRLOKqy6IZVi1Hrd+H+6J8hzMQtoZOpt+6dWR+7bL6ve3hXNaTdSqQ7eYpW3S1/m8ks49zXStyFaKym82OF23g2cGZsRxMJFCIuRursSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243528; c=relaxed/simple;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgSL9jqWSdiirNGAPjhihWjrVXUMUeMm2akmYXd+iVKnmRoYPRoZljX7C9AdCxKevNfVyz9/3uhVfBr2J6fPHeGhT8Okn0s80HO7o9qAq20Hz+4ybEmdMYZeQXkpoOJ/hxvXTszI+JAvH/E+9yAYK2zJxAdssU+g7efbPT4L/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YydwEGiU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758243524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	b=YydwEGiUvywtpBzVB6wr8L+HcuSsWztDyAiHssPdiWbqXcf4AQ3uwp7TgRyD3C4q7yEBzE
	jhLORiD2qv950AaAHggePOIoCY+HUN+j+CjAi4gWVi3E+1Lybs9f60S2GCA1QPBJKgO9O/
	4OV1AxWYShnpQpcgB/eQg2XlxtilHBM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-5v4TGmGWP6CF7x6iPcwt-Q-1; Thu, 18 Sep 2025 20:58:41 -0400
X-MC-Unique: 5v4TGmGWP6CF7x6iPcwt-Q-1
X-Mimecast-MFC-AGG-ID: 5v4TGmGWP6CF7x6iPcwt-Q_1758243521
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7946137e7c2so31203516d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243521; x=1758848321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
        b=kpEdo0j9roU7hiyyFyqErVIWi+1lxlXrhe7ABjtYV+EsckXyejFg1jOCe2D23oUKlj
         MF1WD8BOT17X4ErkrQZBtlhttXISAq/kO0Qo3B91nJaFTlpi7rp7hbclM3KrqLQT0sJq
         y70CIj4pGsqsu1Frsi7N58jQa6OXhD9ZpaGgekiZu1FmwzXWjfJxbdnycl3H+Z3/7SDJ
         uOTNzK8cnAM9DN6XcYUm8oLGqPziyiM1ZAZjlB/w7OL5XA2NOn805Z6l8ohhIfgtb5cC
         aUup5QXw8PKmkhkNssJp9XLyepI3sfuPs2zUVx1PUKbGT1ECDtG10HFafGpcwJdeVhY/
         rrKw==
X-Forwarded-Encrypted: i=1; AJvYcCVvdhG/uA/iu1e9CcSdiJCdRIh3tzN9kOohjvSNOEwmJtiEEphwKEL8P9YGu7PwlnPr1RI4WrsVjZeJlMG0GeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYgY/ZwRYowDtPhrluC/YofywuxkPCK+jTkeCOIFdRbgGs/Km
	G+lHB0CQZGLX2QhXIr2PYFeouORw9ob8Lm+JaQ9tD3NZxYy/tbotmnD+9cUCAyaQIfTjSMEc4pM
	1xB9XqZon6vPyjiCvU2zGWV9J1dH0N5zYWOXydx7LMvTU5AcCsn4ijAGRENpTCiqYfGLMXdYchb
	o2s+Qg7Drut/TjYni3iQ1utezZUSNji+Q8xmLaYIghaZQT
X-Gm-Gg: ASbGncsFNJ4l/8oPL7Q/N5pfh7GMJqkCsHdVPdcSRRx+0odRWT9mul6ZnEYghi9e0vP
	6PX9Y2S/nfUzOW7bX6kLHXU8Sw3+ry9uRIkKAIoOgoq2okuj8Dsz2Q2ayqpac2glJpe8USUs6IG
	Vg5EX+5No7fo0xnI6Mppxdyg==
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id 6a1803df08f44-7991f60498fmr17130096d6.54.1758243520877;
        Thu, 18 Sep 2025 17:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCePSrkJyt8xOhV9XFxKyR5ORnkdYCLN1UQ0pORMOf3Vpbal9XfU/aSeiMZSMO/Y8ggPzzI0yEwXtZdhKDphA=
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id
 6a1803df08f44-7991f60498fmr17129876d6.54.1758243520392; Thu, 18 Sep 2025
 17:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com> <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 19 Sep 2025 08:58:28 +0800
X-Gm-Features: AS18NWBMx6gMYpA8xwEV8T0_f_E3cL4Rmg1pd231x9f1zxxG5V9QV0oQsLm1gZ4
Message-ID: <CAFj5m9+ZFkuq=n9R=d5N_ePzrtvx44TdR+YniCJVEWu_P+DGKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests: ublk: add test to verify that feat_map
 is complete
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:34=E2=80=AFAM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Add a test that verifies that the currently running kernel does not
> report support for any features that are unrecognized by kublk. This
> should catch cases where features are added without updating kublk's
> feat_map accordingly, which has happened multiple times in the past (see
> [1], [2]).
>
> Note that this new test may fail if the test suite is older than the
> kernel, and the newer kernel contains a newly introduced feature. I
> believe this is not a use case we currently care about - we only care
> about newer test suites passing on older kernels.
>
> [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@=
purestorage.com/t/#u
> [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf=
705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


