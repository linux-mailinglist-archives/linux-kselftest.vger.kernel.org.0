Return-Path: <linux-kselftest+bounces-22829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D89E3E71
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAA3281021
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDB1FAC30;
	Wed,  4 Dec 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORN7kT1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E6182D9;
	Wed,  4 Dec 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326670; cv=none; b=CmRGa3IWWyeCjvY+FgdXzjuz7jja5m20/LAF6PF3JRqpdcn9xcVdeFZQ/G/o9tVLap2n8EAW7nZbxYm85E/uJVavBB6kEMMc5Arew0K33gXynTKMB02m0WZcPzJ1v29bbNmBcpJb43EB54dtHuFx1tMP6cToWa6zTpcmz0Tq09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326670; c=relaxed/simple;
	bh=mz9WS0Cz66il0FOJLswE8qNx2ZxttVVFvXfHD5UQR8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuileKFWcDoSFk9xKhIZs6NNzi1ZXo7kUm3TJSL0nPKJEo1R/YdhkrQ3yqXHGe7nlWC/PRtaVutvCRB1Y9WpV3eampUiir63iPu/rhzap6mtfs/ZWuy8Tw7rxwdNpOR63ASfOp08zQql389Ug1pt9pW90vxGqBCmvkuHULqcdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORN7kT1K; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7259a26ad10so322578b3a.1;
        Wed, 04 Dec 2024 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733326668; x=1733931468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XePlx1QIgk8VgfmNUtG3QcTLLTBW/dlI16JoLuecilM=;
        b=ORN7kT1KWze8RsKgL84Y/QlKiCIRUjdigDmQO3uU5jzHs3yUKkSgbPJEpfH5149vjv
         /NYwpFZuzUaBDlWihTbbWmM8BC7ShPLSzjzf6l6fyEsxC7tQ9PJGTP28WOwuivNz4baI
         Ltpvl/XsJCMFSYB0sJxaydiz+v+7tRje8Omd1sjnKrZ4M1TdSrD0/NCU3OHBrhf8rek5
         1QULALxOj0S2TiyV9LL3jQ4Z3y2ATm9SQw1WW1uiwfyIUD2abg0H2TrYiDrsTyLmu9qU
         IzYhaEkR74B9YfkAsAGPXIcmA6zulMq8UfrpttBVwn3+A3sNxzL4oE3XZccDCUEeJBl/
         HvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326668; x=1733931468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XePlx1QIgk8VgfmNUtG3QcTLLTBW/dlI16JoLuecilM=;
        b=GMASNOLDpJpaTEQCJ/TvZnWLOMfbrahuBuI7EfDPOOuN+KXluaEKFiYJ/eZqGq+stt
         W1Qwoy35uXxYsqpqHBvE/2EWaYN66kyllnki+DoGXNl06hafllPACahd/q7kJYxZL7Uy
         fJIsRSXpBp0qcOTSJ/LtXZU09xMUY5d08AmUNsPOClbNkTflejkLiqRZbIeIDsiIX8Pq
         g5f7QeUo9kMNyWn07VlWTRK/Russ+4yOv0zPWubFxQuC4Ye2BohIHMf+lFX9urCywyyR
         m+RMSHQW2opYC9azkHiqLWZShbdVgTCNvB0RYlW4zIaeForuW5gW5holnqHLk58ZuoYS
         +CUw==
X-Forwarded-Encrypted: i=1; AJvYcCUMIc3/FHXRpLYerInsCrWN+rCMBdmfmYw8bxnVgpZ8YkOK24p3p93UWuqPZGlFDtMo6jBrV4ozpnLtCgU+@vger.kernel.org, AJvYcCWsYvWhXHtGebE+vHNbYyrhNDTE/wwb9MqdGGSOL0fdVLcxmFQHd+dnkfqMmzt1hVK71RTEbfIpHPiFQriePyuc@vger.kernel.org, AJvYcCXK/sB8FegHGDx0/oVRBtqaKKQ+tUsiclC5sQocS1EFZqWFfiqxa3CzjipN0PDoEPutoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdOIx4yPcNJ9u2zxSVQoWAy2dTmLCIhmrPcy17p3E8CN9d/Jm
	G5jLkvwbijBv8RBfq9MJqJcnEoew5laNbJJ2uzg60WaSEUjZzFM=
X-Gm-Gg: ASbGncvZ7yMvTLoc1Nk2Rri+DK50B8it+ZgwLajcZ/Pu0VjvAS7BANbJ57HmGWfb1ku
	bPoksMOdBQazAMJpaxQYuLJu+GrW47gmNQQYXjhnV22WJ0Bl5B6PLotNXjhAnhWCWUI1svQ9ACN
	HH6JwdaEtFuMb/tgbWZ0nD+mFx6gwTACsLlAKYtX9GrR6NTADVtL4+4qYZmv9xw9WKSmraA9ZoD
	kLWGzIXpwQSin9Axn/+SQQ8I4K21FRDffGW2X3BZSddSiIRqA==
X-Google-Smtp-Source: AGHT+IHjF9fLaaJKo31QaNdNnOQRJjOkOHR5MDxMG4OGqUKVLDH9AL+hXQbnVZj1eNfsz8H3gzx7uw==
X-Received: by 2002:a05:6a00:7185:b0:725:9253:62c8 with SMTP id d2e1a72fcca58-72592536489mr2372552b3a.2.1733326668425;
        Wed, 04 Dec 2024 07:37:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c324943sm10091109a12.48.2024.12.04.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:37:47 -0800 (PST)
Date: Wed, 4 Dec 2024 07:37:47 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marco Leogrande <leogrande@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
	willemb@google.com, zhuyifei@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh:
 Fix wait for server bind
Message-ID: <Z1B3S2Yh3v069n7e@mini-arch>
References: <20241202204530.1143448-1-leogrande@google.com>
 <Z05NhvyagBbHs8Gq@mini-arch>
 <CAD1qLz0UwaFsk3ZnQ9e5RG1XvJ2i=7FJhtf_9AB6KVZ1fbEh3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD1qLz0UwaFsk3ZnQ9e5RG1XvJ2i=7FJhtf_9AB6KVZ1fbEh3w@mail.gmail.com>

On 12/03, Marco Leogrande wrote:
> On Mon, Dec 2, 2024 at 4:15 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > Do you see this failing in your CI or in the BPF CI?
> 
> I see this failing in our internal CI, in around 1% to 2% of the CI runs.
> 
> > It seems ok
> > to add wait_for_port here, but the likelihood of the issue seems
> > minuscule. There is a bunch of ip/tc/etc calls between this
> > server_listen and the next client_connect (and I'd be surprised to hear
> > that netcat is still not listening by the time we reach next
> > client_connect).
> 
> I'm surprised as well, and I've not found a good correlation with the
> root cause of the delayed server start, besides generic "slowness".
> 
> You also make a good point - by calling wait_for_port this early we
> "waste" the opportunity to run the other ip commands in parallel in
> the meantime.
> I had considered moving this wait down, just before the next
> client_connect, but I concluded it might be less readable since it
> would be so distant from the server_listen it pairs with. But I can
> make that change if it seems better.

Thanks for the details, let's keep as is.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

