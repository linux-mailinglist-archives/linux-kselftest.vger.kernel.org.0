Return-Path: <linux-kselftest+bounces-18800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9B98C35F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E90B2234C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CB1C9EA6;
	Tue,  1 Oct 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQ/jdD+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEC1C68AC
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800017; cv=none; b=o8lIyi/YVuYEKhLUyz4n8rdq+K/xsrYJEVdS+O9oMsArzphWt1xxYLhWTs6f3Otv8r9PPk/ONjl/X1qoZHEvWCkSFK3oABbDbNa2KwxaW6bxVWGzcbfXtwo+sLntgjWMcD+pHm8DtlAFVXH89ZZOxcHBipSKx5s6UABCb1I0rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800017; c=relaxed/simple;
	bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Dn3XgS+THwaNK74ToqOUlQqNFEfT/NgeYIlXeMeP4aLs6VYi/UY3CE48wggGyvNYxR+MiMXt4rM+SSRnKA5/TgzUb4X5etBmsrCPyXwb6ftIgUxpu7IORQtobcs/q9kGwIDiPQIotC7e7sB8QNjJjrj8D43xulkjfld/Qdf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQ/jdD+8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b40c7fd8eso234885ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727800016; x=1728404816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
        b=lQ/jdD+8AwDRQzwMqcxcYd6wkn2V65gZXTvavuwkX7bUAQYO+TfEESLoocovZhxme1
         xUjE8oXTxu/6E5wWQxLLqTHVArX5X4oyH0ysDHZHjeRZ+at0dN/l2IzXfCPDRR6oEQ/i
         Dz18vKEGgeJy/UT6NDznZkHLjEFsVt1hZXyQRA4abiIrRCZthMdpxwTlYKnmpkpKJD+3
         zxQzefc2qBZYORE8gcBDLC1P1oZtHQNaPQMV0Ay5M1rKJ85HccKWQqI9Nf+ljYWaIQEH
         j7S2zNxqhcDZsuckgg/Sg+pWyniyLAVErPkD4Etyadm4Pg0hoXxKmLHDAkbv1wB1OAF6
         hxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800016; x=1728404816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
        b=GArpTN+/7PUPS52bO1oM7JBGo1TsQyoddLXQGjMM8iQk5JxO1EBV48UMTvcTSjNDid
         lYyRzN8vKvVc11L5Va5l3u9+PPGnAt/se2BFPIydauTfLb6Gk2JK3G18w9hbsKT/Lg4C
         4h88M3SFJLpRATBWcieq3X7oakj/is5eXZu8fMtkFZGr0HeV/b9JrBb5YONG5v4R0UgO
         AGEiMm5njeVdD+hJkVe6UYGd9CHz90CjaxfQl4sIFXCd6kgvSHhW0ZEv1OqeC4PKfrBB
         WEbxw0GxIyLdLn2deLxBhOPpQuRVk4vNGMgGLW55fVCzfIRlf99xNEYriPL6ref0cfpe
         enBw==
X-Forwarded-Encrypted: i=1; AJvYcCUbMl6YR1Lmzh62OGgeZErJpdt1vKAKcOtSqFWx01dSnxdoIoozMfP4utdh3mvMGWke9bHiUGwgPB5AGZ0ybPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWQF9MTrCZeYuhRXClRBLGtKS4lrkxiNYo4XpJ/0XRPdKlogj
	ZZxvSiCC0xrro4FIHI/Nf63lx5oZzwQklOZ8X4V5u/JAeV5VZfa+EUQmYa2RBhP6pULmeU/Xnn0
	SpGHOnUqGM3tms9FPQxfmXTMlmLSSW1uQD/ji
X-Google-Smtp-Source: AGHT+IHdrQbAqpejQaNhVvnlIZgEwuDo5VjmqDx/kOgnNdj+gWj66NYWwVdsH2uRpgkV2fh2pLnWhSrh6EUiZbbDSoI=
X-Received: by 2002:a17:903:228a:b0:20b:a3f7:ca8e with SMTP id
 d9443c01a7336-20bb0804a02mr2571395ad.13.1727800015581; Tue, 01 Oct 2024
 09:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905200551.4099064-1-jrife@google.com>
In-Reply-To: <20240905200551.4099064-1-jrife@google.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 1 Oct 2024 09:26:44 -0700
Message-ID: <CADKFtnQGCic1fAQFbwBZVmYsZb2jykaBzPMrOMVuvENxUSZ6bQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

Just reaching out to see if you've had a chance to take a look at this. Thanks!

-Jordan

