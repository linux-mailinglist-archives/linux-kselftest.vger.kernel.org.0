Return-Path: <linux-kselftest+bounces-8561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC538ABDDF
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541232817A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8D645;
	Sun, 21 Apr 2024 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePSHcc6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D363D;
	Sun, 21 Apr 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661128; cv=none; b=f3ZCOvnFQbsd27h87lUL+Q6afTtgIbNqBNxaC6CHtX6SVhVogFH8uUlTdXZlnr56E0MrYJMteJVlce7xfcLBNN/IRQEnFlhbjwy1YRv01jBbe1W8yBCymmCGKJxBvyxTC8kd6WowcuzOVvLZqSALAmZGeY+M+feXXSbhOdAz5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661128; c=relaxed/simple;
	bh=ymC1QnVHxhOD2DDVfEZFRZeGCfvWjZCmsx/3+C3Nk8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyG8kGsB4IdaK6emhpm84py9i10BN1cFiqEmYRpPt+/QhzoUrb4t7XjmlywN5wzhmdjYO6siYfAqZ5GsGV7+k5S7nOkOa/3lKAgr/fRr5M9KN6pTKgHnQcyZ7/ZwyyD6W/AWgD77wP8nwxT2ZQBkNzD98jmxQPCeznT1ytti/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePSHcc6X; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7da37436e36so116332539f.0;
        Sat, 20 Apr 2024 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713661126; x=1714265926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rotKs/HRBUThPvtoAm+JwDL8D8t3IdbuQt7JNy7S+eQ=;
        b=ePSHcc6XNc5ZNYYdhgXPa1MtN1RcWBfT/u0TBCulbmiCtJuQi6Uo4QmJVqo2gpDjUf
         6Abyjvz6p5vhLfUWKjSXOJuEVJ+2HAWw0SqB2d8/1+6WAyjkCj9J2ajDFuSQDn2xKyA5
         BtxL8/93aPnoXTULPCMuxyh5tX665ImAI5XJoAKTddxdlnZqVgHgdmd6yDujrULp9Nvb
         X7lsJanFRUlhbI0gJNR0AUe7Zo07MgG9soZIgWlGNkOoXCA5UTPvAwZVoLG4RceBzTbI
         PQyBvZidChraM7WJ+hfksAidgIXSgmKrZauMRRbu3SbCU64IlSmnkv3W0EUr4Q7isXDg
         gnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661126; x=1714265926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rotKs/HRBUThPvtoAm+JwDL8D8t3IdbuQt7JNy7S+eQ=;
        b=q0O2vyxK8sVMfvns3AJc93L+5NwG7QLayxMfmfIKQS9XNQB/GlQ4b2VbVFqt1IgLrY
         hJphvSNFpaNx4vClUT7JkimUjLCML7eb9Z+LgH7Z/1GCBe+r3Z3bDdTRq1FAqzbDPBR+
         vHikStSHIzWQHMAte/WXT3og79PaLPlv9IXR3OPX+eCY8wKKTUXAgDHU0fjCrHCg5bzE
         ko4EHuHEBjixPipG22L32oocqDegNCrf25P6vnQbuudzRyCX4bZ4M9aDubZvsHif+c3k
         GMo+b/lm4nIG1jZ7BYvyqj9TOlHi/EHu1NkOCImBA3wJcuTJB/11hitrh5lI+Owe33Zb
         BCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsJAQ3NlLdjM/rWBIzua6RSL6Nx4uKxGkl4IO1GV0cnsrOYfLy+MrAasl9zPpoJFsMuPWQBYmNIV7nR8SgiuBo+SOQRrUqzE4y+PKcj6H7
X-Gm-Message-State: AOJu0YxpaN1krAaeCTNAalIkPiv4jD31MM3Kh/GzuniwXFkwO0L3Madd
	6jiUXxpI9jNfGJJpSgFziJyaPBxNxF7oazrZo8Sl8e88Qoot8SO2
X-Google-Smtp-Source: AGHT+IFRUyg8B7Uf8CxpRLgFfeKm7cudFal5LSALGN4uBXfPvkRBniXhEKfnlUL3Lni85Jo7QbuxLg==
X-Received: by 2002:a92:c267:0:b0:36a:fe86:5fcc with SMTP id h7-20020a92c267000000b0036afe865fccmr8325083ild.0.1713661126149;
        Sat, 20 Apr 2024 17:58:46 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:1518:4e26:8dc5:c7f9? ([2601:282:1e82:2350:1518:4e26:8dc5:c7f9])
        by smtp.googlemail.com with ESMTPSA id p6-20020a92d286000000b003687fe513f2sm1416458ilp.2.2024.04.20.17.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 17:58:45 -0700 (PDT)
Message-ID: <11dbe8b4-7827-4c86-b870-c255214f069c@gmail.com>
Date: Sat, 20 Apr 2024 18:58:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in
 qstats
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com,
 linux-kselftest@vger.kernel.org
References: <20240420023543.3300306-1-kuba@kernel.org>
 <20240420023543.3300306-2-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240420023543.3300306-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 8:35 PM, Jakub Kicinski wrote:
> Having to filter the right ifindex in the tests is a bit tedious.
> Add support for dumping qstats for a single ifindex.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  1 +
>  net/core/netdev-genl-gen.c              |  1 +
>  net/core/netdev-genl.c                  | 52 ++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



