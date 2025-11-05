Return-Path: <linux-kselftest+bounces-44849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EBC382D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 23:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2ABA34E435
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E52F12CB;
	Wed,  5 Nov 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjUVa7tk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424C2EFDA2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381357; cv=none; b=Uc5jGFTaO1AOcb7xYxcud2V/nLZlmPg/Ob5GSLHHRLSNQc9rluKuq5wlerQ1IvDiXLrKtG9k3hbzpz5OezkYRCvmWhjj9//CSJ6ZR/KWuRVbS36dk59EzqE5Fp3zHtpEGkFWJ5AY3YgHvhTDivZEhb7WMFOCithL0h4so1GLwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381357; c=relaxed/simple;
	bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7rXsIILJ+eElLz1jYOs7E/vntPmTa3XHqyECMm6oELgT8UVfLe6vetdaJMYXyJWuSOC0/w0lwvxSeVRfqzRmTnJphO7iyOcwkZfGd0fdEr4U9yEp7/gTcGq73OjpNXxu3vkVnd8i5X8Gnrtz5QokUZRvQb03YbWnTCzdgi+Vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjUVa7tk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29555b384acso3143825ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762381355; x=1762986155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
        b=XjUVa7tk5vQNbSrCkjSQ21NCTxgLjdenDUJBjiex2/P2nkIpBieQoHuq56b6g/7YrV
         IbmCNcNxbyXOQ2uBCfI489/JZGD6ppFUb/D1I3IHoO2PvAXbny7yg2I6tDlXHrHxxBRA
         kEZ2/2VskiyQHdYKr++cz6LgEFGvxeuArADjw7NXnQUgmWQYcByEvQpKuz1/daiIkr3+
         IiGyk0dSCQyl+YftXEsyHU+/Hm86/h3kbTQ/AvEqCKZPG4GsVnsWR2+YASpwfo5nN2WF
         Vtvj1k0V4w1fUzmfhOTLo925Ylge8fFvwHDKbcDeBNhYGTxo7VHmoqqiBuF3iwznSJFk
         5C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381355; x=1762986155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvLX/B9HyZgBFy6vMfMFfbx7Z3GJR59vS3ShKrNuy5c=;
        b=olQmI7E8Ogjvi7TSO/A4IM/+COs1H5UO3aVdxJCfvIZQ7k3OyUdo6gegfZL4VbgDbQ
         e5vVQSLG58h6aEEIrksA1ckL8kblBtQKLT3JJehiPCWfvnbpwvsoqCyBIBGEltNHJsqy
         XueSM38Nm0rWo+meSM52vv4FPZmiKcXEXCzNablMZpU29vQQvWOFnLKbo2T2f90X/Gz9
         um5fTmgthO4lDvfMeo2z3kD6EWeBh9PNeD2AAc+8+fj8uZsZhf03wIjOxU3hwixYLngw
         eT3h+F54OlD3EM+UrYKxRvXvPJEFj4CQiVd79zfKrRv21Gubz93gMvgP8+EM6GVwwDVi
         SqBg==
X-Forwarded-Encrypted: i=1; AJvYcCX9tQMCVKZQAdnrIwOzFYSJz5nXF/srwWdRRKddjQll2dfBQ3dcL/rWEaieOKXvDwR3wcnUk1DvyiWfHo3TueA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLkTK85v9TY5OHPR+KU+IeR3hagfZd86j/YgEzB0Cw0YRKtH9
	GTJlllnH4/7KffXVhaOXYvOctubdGtFghJmfjrKXUDzxeU9YL+af3Psn
X-Gm-Gg: ASbGncvMqdN3w7sx/6o1fE1xPOyJeAIHqNyyyCwVCNL8uLh5nyBpFdDn8cZP10/75nG
	WZaTeA9FWdlXA2Q+o0PXZI/G+PCPgEg30smbl1o3mmY4n2qmdiQkALLrUdI12fqWPUOKkd/sXJY
	x/aEC74RuPjdh4uKmy51Gm/j4herjULgKjPrEXcAh3ZMyr1EOnioSrjMj4Cicm4VxxYDgBv6Oix
	vq4HYGHPS6RuCQfqB0W/qKtPsY21k30rwfDXrsHUUV6uJae1n6WdIq9KhgAvhabbXCptj/1WUof
	dva/YbBWu96WH0xKWOQpn8t2yrIX1AF0t6Zv57pkHGMRk/ctrkdUOSXCw03MBLVv5GV0FOfuvEn
	BEPARc0V96/9mztIq4PBYhwKHaJDUpPOUh1pmiiLae2jc0cJ5kJ8FBuDwFhMnDizHCztyU5FVtO
	pLbqZQwY3rMq8OB3KV1HkpKYWO
X-Google-Smtp-Source: AGHT+IFNpsrJwWvShOgzTaHvHA8SiGJMawi4S4q7i+YGcAuUdkfNhD0nsFKo1Vh7uDY2cIu5PeeeTA==
X-Received: by 2002:a17:902:d489:b0:295:702e:66e4 with SMTP id d9443c01a7336-2962ad29f31mr59676325ad.19.1762381355250;
        Wed, 05 Nov 2025 14:22:35 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8ef47sm5677345ad.74.2025.11.05.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:22:34 -0800 (PST)
Message-ID: <29784285224aed7ffa9a44434251c75c96c2c26b.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 14:22:33 -0800
In-Reply-To: <20251105201415.227144-1-hoyeon.lee@suse.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 05:14 +0900, Hoyeon Lee wrote:
> The netif_receive_skb BPF program used in snprintf_btf test still uses
> a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> available and provides the same functionality.
>=20
> This commit refactors the test to use the bpf_strncmp helper, removing
> the redundant custom implementation.
>=20
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

