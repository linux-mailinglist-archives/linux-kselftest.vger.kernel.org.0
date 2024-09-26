Return-Path: <linux-kselftest+bounces-18392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CA987019
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7361F2780D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5271AAE0E;
	Thu, 26 Sep 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbHbsCot"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55761146596;
	Thu, 26 Sep 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342893; cv=none; b=f06jPN/68EVCWXU6HqRCVwwfFrnbIydKusS0Ch55+gsSUFn/7R0AJexKRVzhPNKAnt2c7fas2f8gkDZhL/jRs/IEg9LEmqIL7z6ve87t/7e0JzgAMSC0ufbSAnYWHBQHXVWqRSktEYsBTYhT+gh0jpIbN2KwFa/PTy/Z9678L1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342893; c=relaxed/simple;
	bh=25rFXqM2uBpI3RjHF1ZogNT2clAm8Lel1Rl0BiHxvwI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cC1XiZp1K1NRb/qZMvRxn8deBr8wjDfLuZhuv+82khlhJ2Zwrv1CQTBN0EQr+gyIafcp9PdQaUNh3uId5VhyH3nDoyVKJv8Et9SsQbs8eI2I+XckesbkuZR7tpgVFoiTIfDRhmoklHvjJFW7E3OV72E/ED4AIKqo2fwHEE1rmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbHbsCot; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9ad15d11bso67851485a.0;
        Thu, 26 Sep 2024 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342891; x=1727947691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5FkCK+JrIMChZjlzSiapcbDvabvUj4tqe2FIB4gEk0=;
        b=IbHbsCotuu/6//CrxRYn+FGmQP0FIVbzq7srj+vsv0cnwUKYKWZ/4HkLCX4lKvJbr4
         GuYi726Uz2diwJw9ZIInwfKXv4jH6U4ga7eahRgD3dqh8eN8ogTfDX4t61dRbAfVdw6A
         WSx7EJ9pjd26NA1gJuYcbzMp6JG8oddaz0FkG0hBMzQ1fDWNeKB19mFkTsKJpY0bYGLr
         2PIQEiOS4HKisbtjuryOPusgdCJpVCTvdD3K9LY6MtQxxiSe4g5pgH+gCDsqAHxrR0J3
         bXOcmUYKQaOwuWbtox2ibhcGr35gIG6FcCPZf9vO5xbd5gbeDqt13FW4x50M9QHDb8qe
         0jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342891; x=1727947691;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k5FkCK+JrIMChZjlzSiapcbDvabvUj4tqe2FIB4gEk0=;
        b=wSPOia1kUzT4EeBk6p1BQrTIxTGndY8BMsMoeAUMzHVsrG7NrDDqeLdtuyVfARUMdK
         zwEvtua7F/EV8NpctdzhPEQh599UHoSHIU4kgJdPMnv3jwmrjB2QfEGQBu3W0sgQ/SGY
         Gigui53SSYRgMbBeEXReH3MW2n5orUeMv7anBiZydbbr+OYp/hMHED2d3PSCx0C6F4eH
         ZAEsUJN+8XbzG3qJeeOQEXmPDteXfbXlWd8G8B3t//K/2JYl8QuKwgAN2cVMTQvnWQP8
         whZ00AA1HXKyAhwW7oXyZvOB7i6PRp0/aUsFShHM2xSCU0H2Xmz6ta21zOB+9IDJfx+L
         vYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV6KBqcqik7fH9aWSL+XW+cZTU1Me53lbX3xHMvh5lysNwI9EZFwi8wIiKP+7JTvhD5bFQptSw@vger.kernel.org, AJvYcCWocQLjuB5+IIz3M8QidlLnglRou39VNJmqNmGMbhGDX1SdGOaz8uPRbpVaQVcUbMdIqPSNgZCNlEOvH8B0RDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkg77dGR+A7T72f6PfcQhAGFSqwudkAqPNaYxfdKp3TZLFZ7FQ
	1+U+PG3MpIPEATGdbI7nXaqhjOV33qSrFNGCc8RVLVkT/mo2lZA/
X-Google-Smtp-Source: AGHT+IG/hvBHE8wLhkoCz375O9QtZF/PXItTvuRGUfoK5Kgwxy7SGCufCl9mmBmQuABhGU2ZNgL07g==
X-Received: by 2002:a05:622a:1789:b0:458:4bf3:7c5e with SMTP id d75a77b69052e-45b5e04553dmr70828791cf.49.1727342891059;
        Thu, 26 Sep 2024 02:28:11 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5253a9f1sm24181881cf.15.2024.09.26.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:28:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:28:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f529298e48a_85aa62949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <76d0de38-aff5-41e9-8085-afeb97b4d4f4@kernel.org>
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
 <0849977a-e772-4778-9130-c8ac0539bbdc@kernel.org>
 <76d0de38-aff5-41e9-8085-afeb97b4d4f4@kernel.org>
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing tolerance
 in debug mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> Hi Willem,
> 
> On 20/09/2024 00:03, Matthieu Baerts wrote:
> > On 19/09/2024 14:43, Willem de Bruijn wrote:
> >> From: Willem de Bruijn <willemb@google.com>
> 
> (...)
> 
> >> We have been doing this for debug builds outside ksft too.
> >>
> >> Previous setting was 10000. A manual 50 runs in virtme-ng showed two
> >> failures that needed 12000. To be on the safe side, Increase to 14000.
> > 
> > So far (in 3 runs), it looks like 14000 is enough. But I guess it is
> > still a bit too early to conclude that.
> > 
> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg
> > 
> > (Your patch has been introduced in the net-next-2024-09-19--15-00 branch.)
> One week after the introduction of this patch and >50 builds, it looks
> like the results are good, only one issue related to timing issues:
> 
> https://netdev-3.bots.linux.dev/vmksft-packetdrill-dbg/results/782181/1-tcp-slow-start-slow-start-after-win-update-pkt/stdout
> 
> And it passed after a retry.
> 
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill

Thanks Matthieu.


