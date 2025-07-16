Return-Path: <linux-kselftest+bounces-37419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE8B07468
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 13:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0E3189C6D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB12F3C3E;
	Wed, 16 Jul 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh7gPysw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328C2F3C20;
	Wed, 16 Jul 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664450; cv=none; b=rpZj/MFAbWrj820GPDp1h0/tlKaumXmIsJfdhboOBkLosWaSpcsaVZMV+NpPoQ1K0ZKu7wM+SnsTbc8ndnfpzd3VhEOjNdB63K31zb2kh655ZdAGOjxBVggWDuvtd5UHYZkoDzl7SAzHuyoKyuOu21DPC4JgugGnzxFG/wCSopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664450; c=relaxed/simple;
	bh=gPjM5gE3QYVIdGPmzi3eRfNuF0wEp1qVH0As7dk/a1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5eQDk47mv/OFzlv1QHZQCYEHPnPtTZb43I2sCk2kp5qnGGbh1VxBfUb0K8mkN9r7JfCi2sH3oFGGcLTrsc7FIXdPFTJT2uJ8UaHBc3XvZ0s2c8kuziXUDofTiM+I5GmBnZlYlCjoLQA2kmLX0tWhz8VKan3x/+NtoDD6v3EcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh7gPysw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c8a5053c2so62217595ad.1;
        Wed, 16 Jul 2025 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664449; x=1753269249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILrfa6+Be99Ef+DqDqF3KrI5+9Fqfus/HTsYMl0wNxM=;
        b=mh7gPyswND1c9npiSy2W4LMa4t7y5d+uxCdYabmeNlyCWitkR0Dj8IxIirZlohYl0B
         4ieQaOmP2i+XJ3vFu3Tgo8jegKJcluOO3Mu9Z5kV99dIPCnEVneMWQ1RDIAgONMcd9Do
         saby39cIfDKT/26/506xl67pcKAYVL41FFNJOjI3zK4wB7q4a8wAFqXxW7lRFgJy6DkK
         QyJMivF79+hn7KFb/beuDrbP7NB450CS+LrCToGwAHid8zepVpbdptMELvrwZGOg7fP4
         ORiBn/Zw1GaIwjaIJj8zaLpjAQzesoH/hooMkC/7095plYRPVT0AJZlKDoTMXrAVrnUv
         rYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664449; x=1753269249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILrfa6+Be99Ef+DqDqF3KrI5+9Fqfus/HTsYMl0wNxM=;
        b=vPpqxzy41h29cSyVNMMqy4BQJGGLu+2yFF+Py9Dvof8hIGsJolLzUMBO6Hu+fY1Xxj
         Xx+RX0Dtcwxz2r6Wu4pJ1mpFRyF+jqmPfgRGM6uSx6CLf9Z/pBULUodKn4wrmOk2lu/o
         muATE6fFKPn79gOFJIl3fB6Qxb/QgMNxdkndeTXpvPNLlWFvSIl8Caw5YAcUPaghtf5F
         5GPRjAvG7Qd/rkIpuFEk+jqcC2WsoPeBZaEsyTuZ52Vv7ehqZX1x9OvfZvKahYbyItn3
         AlkazxsULR+ptkVoV3QoHVu7R/ahF4m5l7L59LBi0MP4rqiJgtDm3u3YPCisW+pfpxtm
         hhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNoxZkX0XyFtKJEKmpJrqFxVpt/S/eoOk4g1pFYe6N9xCChF6yFfAYfhXhGBArJ6DmzqH6AcESpFPv9eQ=@vger.kernel.org, AJvYcCVEKe5GEITey4lLWHjg6J9CE4E6Q53xrmOC3o8dlw/sDjFvGR50I5uATGrLZyHN1pZEYicvdM2+0vfRqP4u9nqi@vger.kernel.org
X-Gm-Message-State: AOJu0YzyER1A6CuZHzKnY/WMa16oGS+lZrOhN9z6E+JlkUneqz8CxcWv
	tWrd4+WfVaiYtIKb1QN8CtG+odipqUJ+9aUVTvbb3OKyvhDglsfF5cc2
X-Gm-Gg: ASbGncvyLd7Xo5+U38dW2/vwEiL47dghJch3ukoGUOOdRmjaQVQY3uqEtOCdhuZ4Kzg
	iNALtesX6lguSabScBMFa+GfG84Z5G+xJ6e/UoreLVstIXOBvVJnn9h4vIrtFASsBBpkhxXX1E9
	+vZ0g1fgC6gRtDofcDmTE9whkBn5P9A3wgaANuTvzjkQxGUQL5ZTihoIe+gf8GeTpSM4KYnjJpZ
	iesmyV6xHkD+vCMbrpNMxSyVQupnI990XAK1gJwBMT76qNOlQkxD0ICq4633VwKu9SVRnpawc80
	m2uk5vSPawM/54buxSlVf+I6TuaiDV6JpdsX1VDmRShEzCY3TX2w+/+PP6q8LosAl4ISrpv3dHf
	AQS3Nuc7pD1CJF8MHmLhgztoSLht7DQ5lV2b1wG4yVg+BWEVs
X-Google-Smtp-Source: AGHT+IEtq2HofrDl50I4yMIv753bCF0oc5ifYugPoHdMZqPXOZSmZKBiJlsK9Rg4pn6POgFEFZklsw==
X-Received: by 2002:a17:902:f686:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-23e24f366a9mr31649585ad.6.1752664448591;
        Wed, 16 Jul 2025 04:14:08 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2b49easm1284797a91.43.2025.07.16.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:14:08 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: broonie@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v5] selftests/mm: add process_madvise() tests
Date: Wed, 16 Jul 2025 19:13:58 +0800
Message-ID: <20250716111400.10156-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e727c66d-a034-4e83-b743-c66235bae1e9@sirena.org.uk>
References: <e727c66d-a034-4e83-b743-c66235bae1e9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On Tue, Jul 15, 2025 at 06:58:05PM +0800, wang lian wrote:
> > > On Mon, Jul 14, 2025 at 08:25:33PM +0800, wang lian wrote:

> > > > +	/* Cleanup */
> > > > +	kill(self->child_pid, SIGKILL);
> > > > +	waitpid(self->child_pid, NULL, 0);
> > > > +	if (pidfd >= 0)
> > > > +		close(pidfd);

> > > The cleanup here won't get run if we skip or assert, skipping will
> > > return immediately (you could replace the return with a 'goto cleanup')
> > > and the asserts will exit the test immediately.  This will mean we leak

> > Fortunately, this situation is handled by FIXTURE_TEARDOWN_PARENT, 
> > which reliably takes care of cleanup when the test exits early via ASSERT_* or SKIP(). 

> > During earlier testing (in v3), I did run into an issue where a missing cleanup 
> > led to run_vmtests hanging,which prompted me to make sure that subsequent versions 
> > correctly rely on the fixture teardown mechanism for child process termination.

> > So while your concern definitely makes sense, this specific case should be 
> > well-covered by the existing teardown logic.

> Are you sure the parent cleanup sees variables set in the child and
> actually takes effect?  We fork() the child so it should be a new VM
> which means that values stored there won't be seen by the parent, it'll
> see whatever values it had before the fork().

> It does also seem like bad practice to have duplicated cleanup code in
> both the test and the fixture cleanups, the fixture cleanup always runs
> so we should just use that all the time if it's in use (that's the whole
> idea really).  Indeed as things stand since the cleanup in the test
> doesn't reset self->child_pid so if the cleanup at the fixture level
> does anything there's a minor risk that we might race with the PID being
> reused and kill some new task 

> The fixture teardown handler also doesn't do the close(pidfd), either
> that's redundant for the in test cleanup or should be in the fixture
> (given that it's a child process it should be redundant as any open file
> descriptors are closed when the process exits).

You're absolutely right — thank you for pointing this out.

The reason for the redundant in-test cleanup was due to a previous issue during development (in v3), 
where an ASSERT_EQ() failure at the end of the test left the child process lingering, 
causing run_vmtests to hang. To address that at the time, I added explicit cleanup in the test body.

However, as you correctly observed, relying on test-local variables after fork() is flawed, 
and duplicating cleanup both in the test and in the fixture teardown is not ideal. 

The fixture teardown reliably handles cleanup and is the proper place for all resource release logic, 
including the close(pidfd) if it's needed.

I'll remove the redundant test-body cleanup and consolidate everything into the fixture teardown 
in the next version. 
Thanks again for the detailed and helpful review.

Best regards,
wang lian

