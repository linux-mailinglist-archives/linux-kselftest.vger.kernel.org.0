Return-Path: <linux-kselftest+bounces-38191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C9B188E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B28856474B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CC28DF12;
	Fri,  1 Aug 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4zSFKVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302D2E36F8;
	Fri,  1 Aug 2025 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084658; cv=none; b=fv00PbwALLrnZL1d2c5RERtLBmEiqf5JNzW97iOxUoXNRSytx2zSBUTlu7sBTtoVTkHQ2oPq0i0Wb0rgHnJXmun9sAh0LRkwxvVrZZo3HfMJXI/0Og2BpQq75G6chZ8/3zgbifWFBM2AZIbbz+FhzLfOzqv1s70K8rLoObYHDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084658; c=relaxed/simple;
	bh=TugDInWfzLtuHmQ5NgSA7Tisgx2UotnZn+XmrZxxWTU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CM1eVDDFyNAXOO8MxyoxJYlY0it607bNabuKWNJOo5mTCgXyAUtskeoxiLvwi/3lAZtCahd9fd7CmF4GdqTgduWaz7FbYr7b9+OwQz2GD2ViV7wmph0F9x0qlzoAfR3cgMtEHUIpe4/w4slq3+TkK8/5AN3Ug+fFlZ+Mb2B7Rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4zSFKVM; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e75668006b9so1399104276.3;
        Fri, 01 Aug 2025 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754084656; x=1754689456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K76Y2KN/aWyarE1AwOC1zR3geasJuQAhmoAIi56PhCE=;
        b=M4zSFKVMizh7x86Wow8biEjSgeRq5KNNramecgU3p7qYMIqBSHoVgU3d/dGedJpWZD
         iKKHnmznXm3ecqRH4zNIX69HedUe562DNecnS3stvYylKMf8ddBhzb8ZiqVuCEacDKwR
         rOF+hfchgnKoRyLZegJDcdMHuTQR1GcnJMt9g7YC0ipYuhTYRlNdTCk+4nih5UZSCMoV
         J+CxpVCcR3k5lsnMogFkzPhdMe7rnUctT5afVvWRcbNAKmq5Rhyk+ZmkLyYl9wkvyu/g
         0Phvc3aYfiRFzY35ee1at4XtetswDp/1vtv6DVQslQgMB7pBKnUDHbZ9SeStn9Ig8Tnb
         cSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084656; x=1754689456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K76Y2KN/aWyarE1AwOC1zR3geasJuQAhmoAIi56PhCE=;
        b=dt5dB4XyLmpiDjs177Arwg+EGlQhZVfNSjpPTqW+CKDhuR+Bzzuq3dJX8OIFLtNPTB
         Ok9xBTHpXVW5bFvQFP8Jzu4Xrb1wiE9xJ/NVOCX8Hd8SrJDYmcAzmL8cpUmbaVb8103N
         EAkUPS7HgQVN1DUiVWKxn11fDFkaTun8yJnsQwTuUX7BkOmvtQqX9Jirh4fXAQ3Djj0C
         lptXRnBp3omtQs+luHleRmbQ0gFI+p8TtfTs02uEAzuDq0wT56X6b7GKwumAm9Ej2Wfn
         JSh6oAtKG0O3vcONMkzlGHYox/6D0aELR7Crmrm9OBPbn0cC30nJsmYVsxGecU0Y0W3I
         UdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPmGdQAQeTnOUqY3cSvvkfS3l+BjsgEKkDuzAtI4v0yNLlXDkirhDfste6GJ1I/MiZLYISdupcTihzj0Lb7jI=@vger.kernel.org, AJvYcCWBCBHNMVef3gLRMzxKQvqruV8PuagxQKkxCkMQVmqtYsHw0QPtNj2NAflCaiUYQ02l6kB16Q8O@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8L+rczNQEPr+E3Xzfz0/C+Wpc89NpeXilFttoeweq8IMrJLj
	/XF7JYpRkCarkEZ0Z7z64HvmA+4IbfM0Ojk9Qx7ZLJ/lf/DDAep2Rcv2
X-Gm-Gg: ASbGncuCP6R059a5BnRO/27ezXNwqz5EAxJoFcZC7PhK0dF/h4lFNdQTtEbe9YFGv9L
	s8d1i0QtpA3Vs1oaCucWMT4H7IyJJE6VC9HnFS9DfUoPw0CoAFggj0eo4vrkHYKEhVt8J+8845k
	/1ByxPxxIPnNpItThYR/CtryBxImL0SRDb+AqqrryONvlRq+eUDV0MubByyYVPVqTfKf+GUAw29
	lYm1lnjwBzp3rjpEc9s/2nWohGEAKf79ujqas9uwrAHj4yYPrpfg3AEm7md/KTkiIPLddzHe3sQ
	fa9MV8i6jZSOjNZmZ9h05XMgnF+bNpbLHs5xkn3uLwCU4nbjEdG5hjV5nhUWGa0Ok+lNoGg7yf3
	CI9HgT4aNqOfnk3H9ltiEEzAOyP659VzR6BVui+xz5eC/W1/SfA0vik3RTwa0JCDJhU62bQ==
X-Google-Smtp-Source: AGHT+IGewaD37pUuA1PuA8zaHerjPVMCnUrtjn2yXhbuyQnF7Y7/8x/fFhfwly9JQGMuzScI12rMiA==
X-Received: by 2002:a05:6902:12c6:b0:e8b:3e67:b90c with SMTP id 3f1490d57ef6-e8fee10857amr1720026276.16.1754084656121;
        Fri, 01 Aug 2025 14:44:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8fd3860b42sm1813579276.25.2025.08.01.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 14:44:15 -0700 (PDT)
Date: Fri, 01 Aug 2025 17:44:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 matttbe@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <688d352f2fc3b_2e527e294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250801140557.53a36012@kernel.org>
References: <20250801181638.2483531-1-kuba@kernel.org>
 <688d2af39aff_2e1a6829416@willemb.c.googlers.com.notmuch>
 <20250801140557.53a36012@kernel.org>
Subject: Re: [PATCH net] selftests: net: packetdrill: xfail all problems on
 slow machines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 01 Aug 2025 17:00:35 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > We keep seeing flakes on packetdrill on debug kernels, while
> > > non-debug kernels are stable, not a single flake in 200 runs.
> > > Time to give up, debug kernels appear to suffer from 10msec
> > > latency spikes and any timing-sensitive test is bound to flake.
> > > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> I should have added "Willem was right" 'cause you suggested this 
> a while back. But didn't know how to phrase it in the commit msg :)

Ha, did I? I was hoping that the short allow-list would work. But if
latency spikes can happen anytime, then that clearly not.

