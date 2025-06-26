Return-Path: <linux-kselftest+bounces-35812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138BAE9523
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 07:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0455162393
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18120E32B;
	Thu, 26 Jun 2025 05:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMKXJGRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3538FB9;
	Thu, 26 Jun 2025 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915376; cv=none; b=T6jca1feNxeUdGhpv/fXO1CoCFwS9rNr6BNsYjB2LQbDqavmW2xu4uqt15BzdE0JgssT9e3eNuBgLEOT1QmWOswLdYsyMBjfooPO+HeR+oxLSVOy8TVKmnpMB7tuS+3Xfg+QzAYo5G6QOnebIFbJqZhl9GMgPVwkjCD7wRHBRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915376; c=relaxed/simple;
	bh=DgPueT0FVH+s+1tOBBcFZ6uSCotZFHDPWJ+ROEwtJqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEWkla+cvhSfydO1+ZEggu11zf8uWpPJtsTImJa7m0TB6MihmmEibyGfqrarJ8ldkVcOCqsWenVvs300KmVx77wt99yNIn8hti8oHThJzow4YlaaOEAbemb5rDTCDLyO+6aL72zBeH5k80oCwTBMSNgbyl6LOeMpkGK35iI3KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMKXJGRW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1178960a12.2;
        Wed, 25 Jun 2025 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750915373; x=1751520173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgPueT0FVH+s+1tOBBcFZ6uSCotZFHDPWJ+ROEwtJqs=;
        b=XMKXJGRWF+4tS+uWrLwfSaayTWSCkRgmMA6zd0W3TttdpB/DGRwS2ltdDSeu8ATcsW
         CUGDX9QWo6XKU+f/uh9SPvXPNywCknWThar2RVcUhh+slggNsWfzqPitd7787lKst0YU
         6VFw4rmzu3auifx3yz41kTTTMjy8ByTx1kGHtsBgS6/UFpT3vqTl0/CMhhN+p59K0+2k
         yKtE4qzvVDQrN6JCjWWj35Tn5N4izf3aiAZuWBdQgJHj3o32Ib0oK3pUGUsHoqM5OW3b
         /o+UeGIZlROT0+WEC7eYzPrUZDj+6GPVQM1dd/CG0g0zB8VyXZHC/yjH6cBf1GK1TBoR
         jpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750915373; x=1751520173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgPueT0FVH+s+1tOBBcFZ6uSCotZFHDPWJ+ROEwtJqs=;
        b=Nc22E/sPe4/1yQuxjvof/9Ag5EVe+DShemLnKlkMwB9yDsjPymc9kCU5k1u4F2Ydmt
         vLczEswBkYmFvE5GlLmoDbyC75620tUVbd7s2OsK0gSiIttCWDzWGruVjXV/ArdTX715
         fhhKxuez2DLnkJRLapAZM24zQvJGmbAEl1sAQZAqcKOeZWs86k9bC0FqNfUHVD93SZ2w
         9vItEsO9ytg1Z8k+g/U76iaifaU1BzI9W7YdbLGzvSZT6CI4+CBLkyCWoI1rN0I2sBDd
         QUY2yJ21R31EIRm9O66B3O358ysSZQ8F718Bp7OtdoTfKzfC3kAuuoLHbnEs+DaHnSSm
         KDVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/P+spc9hXzGIZo4ZXM30iLNADBZE2pO+ZBci6tNw8vBtW9IqxIC/Di9R/EalEGiF7tOUzbXh2ms8IdRk=@vger.kernel.org, AJvYcCWsvwQOtU60xKtz0TKgKkCJjEMhoaGXKJJwuIzixJFD459jyD/Fj7tCc4Zb2nRGXTBsQ4K4u/dp13v2Y5AOlZrk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7Fr1x1sdj7CS2HPjNtLbjLixyaP8RRRSVZ7qEFQzuCpLCfw8
	yq1inJAiqjLLC6m0Hb2cLY88+7c2ynhq+PcFdXnnWRUJgC486HCdwbOeLZf2iDD0ONZVnXLDqUQ
	LvcwTt6fdlFhPxiKvV25x5cjo7ODFmQ==
X-Gm-Gg: ASbGncuCpY6W4JcwToPhjfFsD6owsjzSmxlJCckFcInkws2D+7DMakVHPV2SPoCg4O8
	WQ0TTJojMLjLHGwErl7VS21mcQapi9xnanmmiTuIoUKMdgn+eBwuAeRQVddR4rMowF3o8wafNpC
	BQ0zXBJFQa0D9ip3MIGcdGumVrrbtJ03pnI9nehImJrXk7CJLcn1Qe6+c=
X-Google-Smtp-Source: AGHT+IFMtI9vNN4mVc4Uj643Koas+IVY4144ie/eip+PQxxbCdBGXf1mdG9mEH5HIpz38t1lC0w2i/z2+s6gKUkuj1Q=
X-Received: by 2002:a17:906:dc90:b0:ae0:c690:1bed with SMTP id
 a640c23a62f3a-ae0d0d69237mr249238666b.51.1750915372722; Wed, 25 Jun 2025
 22:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250616100406.2853-1-ujwal.kundur@gmail.com>
 <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
 <aFGPVPDKGLOIEucg@x1.local> <aFGkVh-rs2ZqcL6g@x1.local> <DAPKLM86IC4F.1MCOR35P2D9VV@google.com>
In-Reply-To: <DAPKLM86IC4F.1MCOR35P2D9VV@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Thu, 26 Jun 2025 10:52:39 +0530
X-Gm-Features: Ac12FXyFSCtM1gISILFlaHmOn5UMXxggV9pDS9HhDySU1ituOJIVAR92vq9HPPU
Message-ID: <CALkFLLK2-SCPZz9tOseFp4Ry77GYg+LKik0SEbjK6LuanDyyKw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> Ujwal, can you reproduce these issues and have a look?

> The script I mentioned in that other mail should help with this

Sorry about the delay, I'll try to reproduce this over the weekend and
send a v6 over.
Will rebase on Peter's patch [1] if it's been applied to mm-new already.

[1] https://lore.kernel.org/all/20250620190342.1780170-1-peterx@redhat.com/

Thanks,
Ujwal.

