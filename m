Return-Path: <linux-kselftest+bounces-4197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D645B84BA08
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 16:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66B41C22119
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722B1339B9;
	Tue,  6 Feb 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewj6278A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9013341C;
	Tue,  6 Feb 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234387; cv=none; b=a1DMVIV7+aa8cKsnHRXCMS8xJv8uX996ggkEhcJPsllCHPvnYN9IJAcqLc3tuYkp5CGWhlLUmpk97XbRKExYFJWeJDQ3dwcfquzeQNGvwYl1QVIjynP5hX2fmDJG+VhCu01kIP4nlq85jaQxC40q5KmNwqxmXQrAYW1ywVEngwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234387; c=relaxed/simple;
	bh=Dd6I6nV8+ojF1BBf59OGW4C2lH8XSzYBSp+REHgzi8s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A5efStiXmRZSQsvU/9N5uK8YFO4W3/D59YOMrBlLTO8K1AW9wglEFz9D/WSZZ47imVjKNqtKaPYSzDcTIkPh7MYUo76JEvn7KSOpqi4pHns/tni3jPzB4qL+QRSIT9Pt35cDQo4W3cxRJ1BFogqrwwDMu4nZnFfOqkk23RUg8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewj6278A; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78407987510so240162085a.3;
        Tue, 06 Feb 2024 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707234384; x=1707839184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWmt02U4yzDr5xDrGMsZl8c2dz8hpS5VcwFUP5wXbgU=;
        b=Ewj6278A+TVsNAfwLLNQiaVllyQJ7u33PUOP5mCD6T15Tfcn4LzItcqg1BhkF9d6f/
         FgfsZVLEukyD2Zl4GdqmEuJL01gwyptQl0pQ1sl5eBvtrpaZ3eRRhhw3bixhs+B5Smw4
         Ew6yxY6DMNvpfnCPhh7S1+4bKOWSYwGQllfc+7/G4sL0+3U2QBO5ggbT4YFWS2LUpi1t
         llX90RK1SFG5itYxXS2qE8dHbEgi71DK1JZ36w341DW24Vd5nhRe2YuIcnxl3grKJZrI
         qaE13xbQn2rWnesviIluLuAxU6K0iGobSormaSJVk+tH44cMljkkQ0VFJEk/BraFXHy3
         1o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234384; x=1707839184;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWmt02U4yzDr5xDrGMsZl8c2dz8hpS5VcwFUP5wXbgU=;
        b=DVODwTBlDlvwVaOg8s5R4xHxHv/LsruaPDRa6Csc8pCVvqorvrFgKf9rmGGoLIKCfU
         mx0ZRy4svpvNw8hfC5BIn6PxV1jMqRCiCQ4iFkT0HJoCNet5hjWywofMCSV472k5js4C
         4T2IWaBBofC7RbWDRwRnC9/qOhhnnHopg4E4ACWYX/162hPH/UW51XqsAJ6VfQQOYyDy
         7CGV6v1IKj0sbWyJbdzCDj8oKPkb4xY6qEFacUDSjNp3slKnPMO5x/qAlO0EpvnjX72O
         MzbUpVDXsbUx6di/6f3/DU5/w4jlAX7LMnrawop/9U3zDTiuo/5ZYrgQo6uHheIRYKRQ
         Bwlw==
X-Gm-Message-State: AOJu0YyCe0x9OefHP3G3aPBpc93D9T6bsPN7Ko5tAYFvsfi040K7L588
	9LLCcIh+nRLSs0mVlzceV1qy0bDvUR7H8id4huhjeVWx/LdsiSIN
X-Google-Smtp-Source: AGHT+IH246cPOGvuKkLtkcDX5lL6hbbymI1b4EARN0qjgz+MNg0BgHLz6nfQ0wfR6Clfab9iieuNfg==
X-Received: by 2002:a05:620a:381:b0:785:554e:e973 with SMTP id q1-20020a05620a038100b00785554ee973mr2974341qkm.65.1707234384613;
        Tue, 06 Feb 2024 07:46:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxNUmGzhF1yF5DZUI176mH1917UkFok7MFJ75PFlFuqWlY/HfK0vQrucD5MCr3JgmCgPFxFTatbyV49scKDOJHRDI729uhNnZoO4vTzaIu4s2+K9QALHh3SY6wO5vMrowT/6WX2WNnl9kIL1jrXrxK1IkOZdXb7WemKZT+V6niOpG1Bvp7CqfktbNSeNZn99apCNwj7jZA4qW4uQZ50xrgIlFa7QT0ZUZGNL/xxcb3rRuGnW+R3NZTAmmON56nrM5GKhaMqh+GGg0=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a270900b007858c6d3737sm774842qkp.102.2024.02.06.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:46:24 -0800 (PST)
Date: Tue, 06 Feb 2024 10:46:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65c2544fc9a91_b15142944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
References: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
Subject: Re: [PATCH net] selftests: net: cope with slow env in gro.sh test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The gro self-tests sends the packets to be aggregated with
> multiple write operations.
> 
> When running is slow environment, it's hard to guarantee that
> the GRO engine will wait for the last packet in an intended
> train.
> 
> The above causes almost deterministic failures in our CI for
> the 'large' test-case.
> 
> Address the issue explicitly ignoring failures for such case
> in slow environments (KSFT_MACHINE_SLOW==true).
> 
> Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

