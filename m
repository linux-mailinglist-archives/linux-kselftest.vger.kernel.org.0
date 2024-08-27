Return-Path: <linux-kselftest+bounces-16470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10E961954
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8E51C22E4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A171D1F59;
	Tue, 27 Aug 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axm0xRyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2841BF329;
	Tue, 27 Aug 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794648; cv=none; b=GDfW30r+zxGToZzzQy0Dbvb9XxfWwprB/FO795fymqofklqrnCqAncYQjbrzC4UcB4bcTYczdNf9usXT8PDzlkW7jBipJjjm8X7vf3egQgRiF5yadG4T6sHQGJJ1nlXszqhmDkRQer4BZEivXLcfDXwgsNzqlxDLVnwyxJ9vlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794648; c=relaxed/simple;
	bh=lDhbzcirsY5GM0jnnvWfEeRrwcyqscHdRr6voGwJCdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCDfyr+e9Nz9XpSErIuz8KVl/k5yLpFTCZ94w/e7BaUVqBcO/zEoD4I0batmpA20ZRAksU/Jx6ZzOpttpZ++RYv6Ou8x6g0rE4dLpCBpXp56Y8O2WSQxRTMzAaGyrNDfSYcPVrd+xGXJt6ocfSlHYKxpk2e5SC7weEScm2t7+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Axm0xRyd; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-842f5a3839bso1608747241.0;
        Tue, 27 Aug 2024 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724794646; x=1725399446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DppSmxBdCY/V0uVcRU1KeZL9ULAg0SrjNOmoMd8Polc=;
        b=Axm0xRydcdkNoKuik5nBWodoo/SKxMrenij/F4MwPzqi/r7g8AUL/XLq/9jRtjYwqF
         N//tcMZQvsP2BTp1CDNJsKF/FLzp2eVp7B5bLmF8qU+fRZeIUbz/632rx7R5erbhW9qQ
         7XjJ1vKd6eUcFPZ0SR50vDma1dFg4ahudbcNvf+up03/yr7DAccBtv4r6Ygy+6BwtwJB
         10jBKCpphCx6rkCWSvRzYvdRBwCN3gRoMfW81ja3MWkYam+F/y4pe+1XB+gAtE6uIaAG
         prdnK2hAfaQeEhRDER1RLvKffi3o3B0d0L+YFCENV22hyu+6d9LIq82g3OUsiXBoFUtQ
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724794646; x=1725399446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DppSmxBdCY/V0uVcRU1KeZL9ULAg0SrjNOmoMd8Polc=;
        b=ky8+xw+7vpDMDNQhcvL2v9rnsBlLEsV3p1qNU9jEC94g3q+qOLtatPsf0iEaWeNo6c
         d2wxLwzOhMx+sCW8Zp5vJGLR0t2NwX8SqHl1okKEaCFhmOPHGF17BbLczI31s3B5TEVL
         MtCZZqY5myUGuJzfqGbdRSqOOEHD/cel2z84/n0MwLRH89P5pOsUw4U2qgWrJGZgKdOy
         S8lsSkftqvhsUKrgr63qiDMKKEa0IYW4yQv2PxWgEJjltgekZ7lS0FvD0gp9dYINlgId
         ZpRLkkKJHzwNbWGts7nz85u/MRasTRkxjOGDoSh8Jrlf9yWGvEMY+c6UUkZ5yC3rQCar
         vZyw==
X-Forwarded-Encrypted: i=1; AJvYcCV4rfXEWLsNJCDfDpkB7YDDLpuZ+MAREh4qIQqy1PhVl24KbYyMhzPOYqfqN5NhfR3z61ZxWb13XekLZk8=@vger.kernel.org, AJvYcCWe190dANzTrooPNxcigQA2mfyXXOmsyka+5S8/JSezNJ2lTZCqV1mT5IxalO6KShXl1kiN1ApaTHiaOxf7+pEd@vger.kernel.org, AJvYcCWt8D+InrZ/8vXbI1kTIPNyIl4Tj+htF+GvbA/flfQQxeT8+BCuDEJnO+ZjBGrhKnqB0TuBPtQD@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZpL93fw6lp7qJkLyLwVN6NKBTOBGcLrf7x0ecSjsciDVXzzV
	E1bLINx/RfzkKaALNys2yM/vziYu7lkwBjLIFEYyZv9bMcsePrOH
X-Google-Smtp-Source: AGHT+IGEFxGG32KKtDziMamKj2CkA8VfW2gthhdK9ekLQW/6/Ix+5FrtjLQlSlLK8uzYPalLRtWHPA==
X-Received: by 2002:a05:6102:cd1:b0:48f:48c0:4335 with SMTP id ada2fe7eead31-498f468d08dmr13705781137.18.1724794646207;
        Tue, 27 Aug 2024 14:37:26 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e47ef606sm1713375137.16.2024.08.27.14.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:37:25 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: Re: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell script
Date: Tue, 27 Aug 2024 17:37:21 -0400
Message-ID: <20240827213721.53379-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826144022.72a80d8c@kernel.org>
References: <20240826144022.72a80d8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: david.hunter.linux@gmail.com

On  Mon, 26 Aug 2024 14:40:22 -0700 Jakub Kicinski wrote:
> What is linux_mainline and how does one download from it?

The Linux Mainline source files can be downloaded using the following command:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux_mainline

I meant to say "Linux Mainline". In my computer, I put the title for the directory as "linux_mainline", so I have a habit of putting the underscore when I should not. 


