Return-Path: <linux-kselftest+bounces-38847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AEB24885
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 13:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256B13B4829
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589632DECB7;
	Wed, 13 Aug 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWMaxsJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AF2580FF
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084814; cv=none; b=GFt7K0Z2XT2CgIU55MgzpS5fcFk24R0AEBZjOpDQl3se8x96xccavazwyu8PM/hDltXndgHbG08t0/kew5/vfqJkHAOkhvSIjLySS3Y1MulSkx2tEy9fpx+HBvrWT/Co+kqIzEuABshcZ6ZiixSSK0OL4Y3/hfuOgBAQBeOVbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084814; c=relaxed/simple;
	bh=oc9in2Mi6mf5HpHVi2qkhAwXsYPHgkrLdyS0CqhnHrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzhiMTxVhC8qdotz26D/I/xc9My+dq2uPqUqvXuw5SJXCal5pTAiTlTF5E04NdyLeSCXqIbyxivN7vRsVTjq4pC4dy6rSPxogc3PnhsyE8zUMT1kl/68BU/gEYFwGD3YGnZt7DlK3VmS5YP3eT2Bws/r9/I4CutyvOLp+dcykSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWMaxsJp; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b785aee904so3041959f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755084809; x=1755689609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc9in2Mi6mf5HpHVi2qkhAwXsYPHgkrLdyS0CqhnHrc=;
        b=mWMaxsJpbZ9NGrGY5kzqY2trtheT+IyRxLFYIX10PgDGUkNERzcLaQWVdoA5jmTOBv
         N9mKlW1n8jXe//yX6l06Q2y8BSuPNw0h2my3F/5HKz3jGC8qqQ5myv8NEh0P643tw0/U
         LkK38a2q/LnNqBNkA0Ur8X9MCiyoXhk9iVBA6TWK7HJK/85dGfChevmqIfBPUjUAXGhc
         j4e7O5j8zrl5Enfyd4gOhYO1txhiFOG0vmpo7jwOfk7xRYomTiy0b1O45mhcP0wmzogV
         eJBZ6Cr/UTC99UBnqqx5VaOrxwS5p7bC2YWgEGBw5O6hTmtAJee4bNW10FGherxic1Nz
         t0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755084809; x=1755689609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oc9in2Mi6mf5HpHVi2qkhAwXsYPHgkrLdyS0CqhnHrc=;
        b=WuSFWSzWgY9iB8m3Yt4UM2Ow8MsezgFU5ZzR6ALmYNm+5phXOvs7TeYVWTklrMtY73
         Sx3OpBgjTLPPJswFxFrkUJ4k7kCfOAzTrv5ZohTCiSmBou1sUTVJRnAXENDj52zyRDdY
         IkK6b6jLzmxEGM8O4YQNE+l17G6iU2JGRaJSTqQajpWpFSaiUdFzQOdioEDCx2OGgJ0Z
         +VhsBbjkwRVRyv24+cCcfkDlArMjk0uIFM4dsOgEIf7seugGS1OEz/y59BBWRn2qfHZu
         k3yo4YY5OPPrT26eF8vZ8/bpdMiLZ8et2VpilgWu4zMkTKiKi8QQfCA6VDN9Ith/gUhe
         elIg==
X-Forwarded-Encrypted: i=1; AJvYcCVOQi/XeMI8UO6v9nCs/FGlFGlgRcHwLZi89MxgSvsBcCiBwi0rarB60GgN4KcCg6sLdQ+b9jTt1zfLT8DYvcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGKg8YEaJb8EltIwti4fmLO72f8ZKekWTrhM4UHUyghN6pjrj
	li5W2Oq4W/2zhzf4hQlg3ApRTkZro8EceAxdCnXN7phk0IfmCLoh5jkN9k4X/Tsjjfqm9mO0S4R
	Hvl/D300NOYr+ZQ==
X-Google-Smtp-Source: AGHT+IEOU16JJnNS8DhWDwtXItrP3lqHsHHp/ybxdPD7FIOs5yLSi2Dy68rYeST/N/WH3SvPANrd5RZ3hKcQGw==
X-Received: from wmrn40.prod.google.com ([2002:a05:600c:5028:b0:459:db4a:1e14])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4102:b0:3b9:1d32:cf2f with SMTP id ffacd0b85a97d-3b91d32dce0mr307978f8f.38.1755084808709;
 Wed, 13 Aug 2025 04:33:28 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:33:27 +0000
In-Reply-To: <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local> <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
 <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DC19N1YGQP7J.1MH8WV5KHUHFF@google.com>
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: <akpm@linux-foundation.org>, <shuah@kernel.org>, <linux-mm@kvack.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Aug 6, 2025 at 3:03 PM UTC, Ujwal Kundur wrote:
> Ping -- please let me know if there's anything else I must address.
> I've ensured v6 still applies on mm-new.

Hey sorry I've been on a nice long holiday but I can take a look at this
soon. Just need to get out from under my other review snowdrift first!


