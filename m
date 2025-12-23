Return-Path: <linux-kselftest+bounces-47926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB017CD92DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1EA300CBB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62A3314AB;
	Tue, 23 Dec 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlPWO9Qx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635FC2D2496
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766491870; cv=none; b=iuTudHXZDXxi3+926fH05FDdyaQj4bOMkaMvbCMWkuwS8Iq6wO2FZliGqsllXbiM6lW6KIwY8AtGmqZSNLFjqsDAYYkXqV1l/cMURtmfKqnUwfM0gQJeF7qem5aVCYOtk4mrzs757+ggp20dks0Hxo7Szk2bygl4igEBm4dwQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766491870; c=relaxed/simple;
	bh=LBZbirKjMcmopBpuSPX0NMZdd5FQ/yKjOijYhvNcls0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZy2zZxsuA7cLbP+CX6/GPkftA8yOJTDds4ORJyo/SF7+/EsdcNKwIYYnhuvpHyJ89Dy8459QHMk7KscNPPFbihamizzdSf9/lFXeTd9Iu+LohByi3LicsLJ6WOb20SeG1cS5ckNiXXOBH7dzyY+L1/DN2vfCDweaIWyGOEGn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlPWO9Qx; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477770019e4so41439805e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766491867; x=1767096667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/wET59k4s2dAKSrBriEQvD/zKuN/8Hb0OllkRrq6ng=;
        b=DlPWO9QxQDsFwGqXyl6//2CPXP37yxoHpQ0N6tbe6YuhshVln7j2GHSdTOlcNvVA5l
         pfKCQ1eFyeg2I+CpswEUFfc+tLVVNJe71KLCpxX1cLWYxovUfhJGi13DmquvnqEp7u/Z
         mOUiKgBlK902YaolcA+qsp/m/JvuLORct66Y09dMEz1EVWDHKr4GRACMd80eMg/6TXL/
         x4okTI+4MjwFnkKKROKtEkT+vIqb3Ff1rIkvyYxtm7RJM2Se5sOHA7g1/vdtgVrPYj0s
         QWAiLK4DaMsTgc/9DUWTF99tBy9xLzYPIlXu3TGl6pkimIjNVTLgJNrnnezGDnmiP0/u
         bD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766491867; x=1767096667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/wET59k4s2dAKSrBriEQvD/zKuN/8Hb0OllkRrq6ng=;
        b=ujRDreFBTtmMtP18jPeGl+6CzlrQ6sKu90WH11QmROurcPUg3OR195xKSf5gx18LhG
         i7hXZH7k+SLBU0bqhXi2YBfWGKK2c/NiY+C8FA34rhatzC8nvDl0dLg5XezozDWTOoVp
         P6TeJXAwCX6qqy66SrO6rMGdqSafVVAZWZNhlQ0GTotpgUIUacTD/YeY9VdKiVV3O/hT
         DaKH7sH/4gd4C/g70ZSHekknMA0nCrm6BDaZI8K3aJptIgLt13gaS39zLoZC8FMFWBqJ
         p+KvUqCG8Yw/l3VdKWr40HxMBfEkJsg4M04opuIf0HBMcDxsJUvdbK+6XILkHOS3d/61
         mWGA==
X-Forwarded-Encrypted: i=1; AJvYcCV9UlzAZqkV0Zsyoysd6N27MlU8Gypn1X8WdtpDRrc7hSSevsaJaXGXhI9fXF9I12Rr1/e8QsvRZLYgpjQXG00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVng+J/kZ2Clm10Qu5MGMzVVqkfcJG6oBI9Zq6iFvyHEQt04T
	eWEPbyRpw/mTY3I1a5a5A/IIltJC3Ci+Fdx1Xo2B91iSOmVife3ELLly
X-Gm-Gg: AY/fxX7gcfYBHWrfIepopt8rO4nuPPjT6vDKy+Ae5xcFVgpnxutdV56cXoyLXHRLvT8
	6bSjeM99NxwlU0dP0/TxKvedEOJALnvBheLi6NAPU13MdlS9yBsjiuyFaRpgNpKyvrqHphIEru7
	KTSnep9SP1PMp7XS/Hf2j08nywMhLna0tiTcDrLrwjkY9u1rEJEuP1wQAikndeBtEnj5qQ4rJqI
	1Zu+m+vKb6UkVmQCZICIRL7nK1alb6wWOF2m6/fj1hFnQuhIE2UINDdiS4kvLkfxsQxsxmALc9p
	jsvl6jtkEcKCj+cdLKiHk6tP6oU/IGmh2/9XhaPvUBNaYGopOqvYAUjP+IGUBFKAl7hgRQtP5Xb
	BI7P+T37SB4Q/wyHx7vx9d6JHBsrb86AmE+BgJHgtua5+N++1VCFiv5vws/3IRKEkF6BLoPirmV
	pukN5Swbi4OP0JD2OyerX4VheV88aDxxnmMLuukbe/W4adXhcTD/4=
X-Google-Smtp-Source: AGHT+IFpoVFVoGdds3xWS4nCVuXAsQ9kuPwMMvakRoZvNm0Y5y6VuK7Us5eEf+GT7UsIy7axfy9yIg==
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47d195911b8mr125877655e9.30.1766491866369;
        Tue, 23 Dec 2025 04:11:06 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm239696985e9.15.2025.12.23.04.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:11:05 -0800 (PST)
Date: Tue, 23 Dec 2025 12:11:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long
 <longman@redhat.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
Message-ID: <20251223121104.6614c1e3@pumpkin>
In-Reply-To: <CAEemH2e3C_oor-CK3_35m-gAp6uU5+75up7sL0wfX1MZdh3+jQ@mail.gmail.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-2-liwang@redhat.com>
	<20251221221052.3b769fc2@pumpkin>
	<CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
	<20251222094828.2783d9e5@pumpkin>
	<CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
	<20251222180509.b12684e112195ac3f7ee9389@linux-foundation.org>
	<CAEemH2dZ3DxDPWuV1Uze213CqoFHec9kK+MeteigGANYTUzbqA@mail.gmail.com>
	<20251223084035.67ba1b76@pumpkin>
	<CAEemH2e3C_oor-CK3_35m-gAp6uU5+75up7sL0wfX1MZdh3+jQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 17:29:38 +0800
Li Wang <liwang@redhat.com> wrote:

> David Laight <david.laight.linux@gmail.com> wrote:
> 

> > What was wrong with atoi() ?  
> 
> As the patch summary described, write_to_hugetlbfs previously parsed -s via
> atoi() into an int, which can overflow and print negative sizes. This
> problem was
> found on our kernel-64k platform and
> 
>  #./charge_reserved_hugetlb.sh -cgroup-v2
>  # -----------------------------------------
>  ...
>  # nr hugepages = 10
>  # writing cgroup limit: 5368709120
>  # writing reseravation limit: 5368709120
>  ...
>  # Writing to this path: /mnt/huge/test
>  # Writing this size: -1610612736        <--------

So the problem was that atoi() doesn't let you specify valid values
over 2GB.
That isn't how I read the patch summary.
It read as though you were worried about detecting invalid input.

	David

