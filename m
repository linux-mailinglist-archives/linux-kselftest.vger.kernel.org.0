Return-Path: <linux-kselftest+bounces-34274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D1ACD542
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43783A2DFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C1200A3;
	Wed,  4 Jun 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0cItEXK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5806ADD
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003614; cv=none; b=qb1STJboEsA0Blxd36Sa76Mo8k5osujSo8MVWTjbWATss5yEDg0sVpJ814ettEHZ0mKSfJCBg495eyzmp6/DQE2WQye1aM6P+wNHKMjM/IyG/f+daHs4PajWLJm++hS1wKlgDCQBafrj4rbcs2KwllKpjZ6fRfNdymNAT5znj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003614; c=relaxed/simple;
	bh=aqRzIH4YZmOMMcRlcaEeuvd9lr4Eg/uYOhHtEzdtK8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tvbxeSf5tp2CkX7fji9bZU8QO57N7Vy5p0soHVUmn0yRi4yDNE2afwTYcxJoUfOac9H3mGfGX1d0BBjDzqFs5sAX3ATl68oxIZ0oLAfSaTJu9FHCbmOYmk9NsTQNKD0giOVZ+8fTiza5muc+pCsvAP6gNPXAmIJu0H5Q1TRE9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0cItEXK8; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86d0168616aso448369839f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749003611; x=1749608411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qejrTtwV/N3l/netOhR9CrpngsFpqe2KTsbhYRzMHf0=;
        b=0cItEXK8PFZ1VIm2GTZ2G7kXuONWELnJxtCCA/TZB7XlNkbwYcDxns9uXGcwi3H9nQ
         3bcvzomnOoYbpNjx7L5B4W/3Tl97+85+vtSmxt1fQmVHVsx5aMJXFpsCupofjGVUwrKk
         UiFuNWCmjJUi8Ky6zuqa8OT+euSseRwXgWiEAyJq3lvHHetkzOTAM77e2lrhEyNUJrAC
         7MBKns5SkGNAKuk69JZgHhPGzfV2FJsfLveY7XZLFZjlLQEIB2koYX2j04D8ZKyWHmsD
         kKgopRbIyruqOztETeZptuqjqrr9pHEu7+l4rfeuUsMc0NqIGeJIcyNb/RSocA+pOPkZ
         qYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749003611; x=1749608411;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qejrTtwV/N3l/netOhR9CrpngsFpqe2KTsbhYRzMHf0=;
        b=Py4YtCph4JITH005tdd4fmqw18IDpuK2KwRrUDUvO4zprJ2KWR42qe19D5DbkHQPR9
         pNprd4Ha5wyAXRUuXXBHsXTngOLnZk5fgMdoLarguRowNnRNkfdPBUWuE+fB3uPiErDl
         mc1I89xhSfK87iUW+bMCK9IPACuQlGzfNZdvvn5agqWFnitIMbj1/2kuCRla7M4QN2J/
         0ERlw1hOnaq67LfbKebPffaJWK/JCUHKo6064KAb0TeMShy6ered42Z5rftxdmfWffnM
         NzFGjNQ85+RgHOd8MhFdi4vmqZQk1YurRA3IqlcngbrikEgkcSIqrEdhV8ZqmkjdCVaM
         1FiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR6kJklwLXReEC9/Q5h4Jo5TSE3dFhVpuhsU/PwnDUlI5BbnZ59SeQo+fhh2tUe7WR7Voodyz2Q+2r0wMZ8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Mbbod7odgjeuNbIB/aigxpY10lO2fBl0cNZ35uqBD0WykQEN
	ynfQ4lnkKiyKiwSnuHmQzAS7OLPW8+oZYi/V/oBZgDXWMnxa/RFmqi55IsEek4NkZak=
X-Gm-Gg: ASbGncshLqrJtl1cwWT7VCRZAJ5CLefE1SvqvYcNdLwTphUVNsB+8uaAA86KrRXFjaS
	lEI19DWJ7oedQO/xWuHXEnL+hvb1LPJMPSLVl3Ki/g4da5H1cp/Cbn4OrTduz8di0fdIZtww3P9
	3UF6/21tHPrv78dxozQzU37kEzaZVjwUtQsbtYMKsnu16Y+K78Py/tQdixTq0o3tHTdNK5rJa/U
	lO12Q6L9Ex5xbj2Wsr0rUl0Uq2RnZeqP7FqpmrEAThP0q7i28C1XW6c1Wgg2C/3w4QYKviVY2Wy
	0cR3Mv6xD0+vT8BW6O3Zp1hV/plsryZ45/WQ+tbYCN4PIOk8ARQdrQ==
X-Google-Smtp-Source: AGHT+IG0g/LKKvwE+q0o5yidPMzs2yIX6t0WlWWtUgIsIU2EQk6Leb9umH6a08mNT2boXGRAuOfyJQ==
X-Received: by 2002:a05:6e02:3193:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3ddbedf6e64mr14260415ab.15.1749003611511;
        Tue, 03 Jun 2025 19:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935a7ad0sm30334405ab.66.2025.06.03.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 19:20:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
References: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: kublk: improve behavior on init
 failure
Message-Id: <174900361050.109618.15847979671218890744.b4-ty@kernel.dk>
Date: Tue, 03 Jun 2025 20:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 03 Jun 2025 17:38:33 -0600, Uday Shankar wrote:
> Some failure modes are handled poorly by kublk. For example, if ublk_drv
> is built as a module but not currently loaded into the kernel, ./kublk
> add ... just hangs forever. This happens because in this case (and a few
> others), the worker process does not notify its parent (via a write to
> the shared eventfd) that it has tried and failed to initialize, so the
> parent hangs forever. Fix this by ensuring that we always notify the
> parent process of any initialization failure, and have the parent print
> a (not very descriptive) log line when this happens.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: kublk: improve behavior on init failure
      commit: a2f4c1ae163b815dc81e3cab97c3149fdc6639e3

Best regards,
-- 
Jens Axboe




