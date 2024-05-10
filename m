Return-Path: <linux-kselftest+bounces-9981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0458C1C61
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 04:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1BB2172C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196913B7AE;
	Fri, 10 May 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVbkVtnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A33EE;
	Fri, 10 May 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307938; cv=none; b=Os+Lo7k4nhZv0lar4aMxUtDyryH8Dqhg15bzEyfXPYhDUJBUVq7BD63sslgju2dZzq4Gw9tJmawfJ2eXlJi9siG8erLrGdxxjj32VYW+DoIAYKbmBkao+ziknW7yZoaT7+zgRTcmGPw/PKzkpIrGNXV8ubwILNETUyqBiyRTH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307938; c=relaxed/simple;
	bh=jhLLzVegFMZvyiy8cL/vO0crRoYlCpso5+7FB2DMPzU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TZpb88+ql4Vy1EtYFRYe7+D7kID4givrsysTPcZHj88uMa3jMLDM7oiYns0ahnAy6SMJe7lpHRhv2YeRgxzdcwqBMZmMmOs9WzNrYC4KMJmjytdms3vZnHAlES6/uFn5NxNN5HUOC0Ux6fdOrf2l+SaF29HPPY/vgrIpJVXb3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVbkVtnZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f043eaee9so92191985a.3;
        Thu, 09 May 2024 19:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715307935; x=1715912735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCZTLndKOQ5y/uEU5YgKiCzBjdbzWGlzdII5qsqfRNg=;
        b=KVbkVtnZ3IhGXavTEoiJ4qZ/mJ1AuMbHvzrxPnXvOaLO6f492xdyQVqwAUI8G3farx
         +dJMEI6GB8dSImhC2eTeQfwJdGcNNVLjuIfMGDhEgupUPhl1c7O1gFQBqeWfq7neycsI
         ZYcdxz7klSTjeQQjFiT1qHl2MAq17z4965gmZMBe0NtWiw46dIkZKdphcI2FgTtc/awl
         9XXtAurDHXhnHoGGFzz6fle3b9hSqArpripB2l8zZxSQO1T1qAGXWE/fpbjZL3EThioK
         FfCIKCjFXKMRnwMBTStQOteckyEHngocsFzbekDKZt3IL0pqSYvc7e2/8CYI43EhwyUF
         YF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715307935; x=1715912735;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCZTLndKOQ5y/uEU5YgKiCzBjdbzWGlzdII5qsqfRNg=;
        b=MrGRhMDqBl45SyifS7ACpNRkjrTQ6WJZ12c8smDGGB19gY5ytaF9PTm5RFP/7fMqOQ
         93LnVa0PcfBwJbHegNdqX9thbZwq5sywOug+SCTug/97ZKF3dycc/5we18R3h9pREvFo
         fMlR4R9RV9sJASuZDLdKZg2SIEGPLKOq88sQaQrggIdUK1ZRfdmQojD9MFfa7+05X9xk
         mianSRBXAHU15ltTTvX/ZoBoDrP4bhSNpzil3J5O87kfFudTA9j2UFZNxx75mBjEY+pB
         gnTumUWVwn19ZGtyVdko8UFApS19+9trTK2NFaddzk4IP3JClvlOURGkeLe2ZXBhC7n/
         TSZg==
X-Forwarded-Encrypted: i=1; AJvYcCXZWlmXQiElodT+HHKZUdO2Ohx1tZRM/M0sk7ymIcb4+p8z8USr2F75kzstgAZ/MLQST5kBmJ7HwchTEjKfcsYaG2mYOXrIS2SlIn7sBeQQ
X-Gm-Message-State: AOJu0YzycrioTxlgBqhb25CAcCHPHkRAZ7pqF09xPidUeblGc6wJj6Z5
	1oOu5fIHU9F1VAuLNm5POEPQ/lQA7PaRHtgQ8cGhDJoleYHEnjRy
X-Google-Smtp-Source: AGHT+IEjmaFnfe1+Z9TLsbWgBILgZ9RsO+J2AfeJnPZmsH66e/7Kr2BNVnnUKZ3HJ/iqFH7ajmjwJQ==
X-Received: by 2002:a05:620a:5d83:b0:792:c2b5:ca9 with SMTP id af79cd13be357-792c75f0c93mr144608785a.49.1715307935563;
        Thu, 09 May 2024 19:25:35 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc5a7sm131240485a.84.2024.05.09.19.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:25:34 -0700 (PDT)
Date: Thu, 09 May 2024 22:25:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <663d859d60010_13d89429497@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510005705.43069-2-kuba@kernel.org>
References: <20240510005705.43069-1-kuba@kernel.org>
 <20240510005705.43069-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: net: increase the delay for
 relative cmsg_time.sh test
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
> Slow machines can delay scheduling of the packets for milliseconds.
> Increase the delay to 8ms if KSFT_MACHINE_SLOW. Try to limit the
> variability by moving setsockopts earlier (before we read time).
> 
> This fixes the "TXTIME rel" failures on debug kernels, like:
> 
>   Case ICMPv4  - TXTIME rel returned '', expected 'OK'
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

